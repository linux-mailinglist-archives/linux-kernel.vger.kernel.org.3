Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EDC756ACC4
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 22:32:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235850AbiGGUbz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 16:31:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236179AbiGGUbw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 16:31:52 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B02842A940;
        Thu,  7 Jul 2022 13:31:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657225911; x=1688761911;
  h=message-id:subject:from:reply-to:to:cc:date:mime-version:
   content-transfer-encoding;
  bh=0mHJ3bZ/mjcfN+X0VUIUi2V528Dd1R/ffNIJ0LJ2cf0=;
  b=OQWwHWaIzqmIbHRchgElQVFUsmeMHo+J/CfXZAXZuvIq8aZPFq0NKvlg
   IfRAFcO0y8zGt9XXudu46C/Fn3f1b9nEBsB7aJhBX63fT7GJwnkYGPOUe
   eUG1qra86Obs6NgSjmVm8EvB8boteTqT3M8HthskmYVYbkRpu1NNhB6ly
   hxHfGUgY0PlreZ6y5egi7O8uxBXNbxlMbZ+IrfGZ07WpIy9F9km+Cb3yE
   on4MKL8s1o+l5tGMuhG0m7o25Lf+5E708U9X+Wj1UrPoVYvI03WmoAD2J
   JqPsFZ5PKmyAQbzWwqKjGSTDQfX/36Tnp5uv0UhQbjDecHYTkNINUvbZH
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10401"; a="348100831"
X-IronPort-AV: E=Sophos;i="5.92,253,1650956400"; 
   d="scan'208";a="348100831"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jul 2022 13:31:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,253,1650956400"; 
   d="scan'208";a="651280236"
Received: from wopr.jf.intel.com ([10.54.75.125])
  by fmsmga008.fm.intel.com with ESMTP; 07 Jul 2022 13:31:50 -0700
Message-ID: <12fb98fe27e23e3f74a139e5e8eb83a97a343372.camel@linux.intel.com>
Subject: PNP0501 serial driver takes almost 2 seconds to suspend/resume
 (printk issue)
From:   Todd Brandt <todd.e.brandt@linux.intel.com>
Reply-To: todd.e.brandt@linux.intel.com
To:     john.ogness@linutronix.de, pmladek@suse.com
Cc:     linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Date:   Thu, 07 Jul 2022 13:31:50 -0700
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ever since 5.19.0-rc1 the serial device has taken almost a second
longer in both suspend and resume. This effect is witnessed in half the
machines in our lab (~10 machines). It occurs on dell, asus, gigabyte
and other machines so it's not hardware specific.

I opened a bugzilla issue which includes the git bisect:
https://bugzilla.kernel.org/show_bug.cgi?id=216216


Bad commit:

commit 3b604ca81202eea2a917eb6491e90f610fba0ec7
Author: John Ogness <john.ogness@linutronix.de>
Date:   Thu Apr 21 23:28:46 2022 +0206

    printk: add pr_flush()

    Provide a might-sleep function to allow waiting for console
printers
    to catch up to the latest logged message.

    Use pr_flush() whenever it is desirable to get buffered messages
    printed before continuing: suspend_console(), resume_console(),
    console_stop(), console_start(), console_unblank().

    Signed-off-by: John Ogness <john.ogness@linutronix.de>
    Reviewed-by: Petr Mladek <pmladek@suse.com>
    Signed-off-by: Petr Mladek <pmladek@suse.com>
    Link: 
https://lore.kernel.org/r/20220421212250.565456-12-john.ogness@linutronix.de

 include/linux/printk.h |  7 +++++
 kernel/printk/printk.c | 83
++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 90 insertions(+)

