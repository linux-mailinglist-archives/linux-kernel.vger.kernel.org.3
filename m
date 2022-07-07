Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C7B756ACEA
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 22:46:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236491AbiGGUpZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 16:45:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231875AbiGGUpT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 16:45:19 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFC082409B;
        Thu,  7 Jul 2022 13:45:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657226718; x=1688762718;
  h=message-id:subject:from:reply-to:to:cc:date:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=pEzztt4x7TuSYLGDhfj8WnqW4H1+jbfMqaaC+PMJx+U=;
  b=JBcsR1FVYwEVkgTc00aKuStw9AVTE9EhBFbSmo0TgeiMMbSWmoTxc11G
   5OMSBY+vCEGHXQ6aG/tNAlz2TMGhGjlHpmkkj7ft6+7RSKH30NyJHYR4H
   4YltrKwM6J0E/IBUp3hmvFS/3x/IUCQmSmlnR+YZW+iQ6KICEAblP7yhM
   24jzAqY0ffTZj2hvofq1H9cY57iKSfaFPj7ZDyXKm3RymNXoZj/Pwjd5M
   O820jhs3cSdiZl6yu0rz23M+sXTdc5+BRH79fsOh31aUdXGzoBW10n9sD
   GOclE5cEfqCi+bxbLsZJ3X/CqmeewP814t7TEJflSrQp1wBc6DDgJWWez
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10401"; a="284859965"
X-IronPort-AV: E=Sophos;i="5.92,253,1650956400"; 
   d="scan'208";a="284859965"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jul 2022 13:45:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,253,1650956400"; 
   d="scan'208";a="651284219"
Received: from wopr.jf.intel.com ([10.54.75.125])
  by fmsmga008.fm.intel.com with ESMTP; 07 Jul 2022 13:45:17 -0700
Message-ID: <51b9e2cc3baf61a604bd239b736ec2d12f1f6695.camel@linux.intel.com>
Subject: Re: PNP0501 serial driver takes almost 2 seconds to suspend/resume
 (printk issue)
From:   Todd Brandt <todd.e.brandt@linux.intel.com>
Reply-To: todd.e.brandt@linux.intel.com
To:     john.ogness@linutronix.de, pmladek@suse.com
Cc:     linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        senozhatsky@chromium.org, rostedt@goodmis.org
Date:   Thu, 07 Jul 2022 13:45:17 -0700
In-Reply-To: <12fb98fe27e23e3f74a139e5e8eb83a97a343372.camel@linux.intel.com>
References: <12fb98fe27e23e3f74a139e5e8eb83a97a343372.camel@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adding printk maintainers to the thread


On Thu, 2022-07-07 at 13:31 -0700, Todd Brandt wrote:
> Ever since 5.19.0-rc1 the serial device has taken almost a second
> longer in both suspend and resume. This effect is witnessed in half
> the
> machines in our lab (~10 machines). It occurs on dell, asus, gigabyte
> and other machines so it's not hardware specific.
> 
> I opened a bugzilla issue which includes the git bisect:
> https://bugzilla.kernel.org/show_bug.cgi?id=216216
> 
> 
> Bad commit:
> 
> commit 3b604ca81202eea2a917eb6491e90f610fba0ec7
> Author: John Ogness <john.ogness@linutronix.de>
> Date:   Thu Apr 21 23:28:46 2022 +0206
> 
>     printk: add pr_flush()
> 
>     Provide a might-sleep function to allow waiting for console
> printers
>     to catch up to the latest logged message.
> 
>     Use pr_flush() whenever it is desirable to get buffered messages
>     printed before continuing: suspend_console(), resume_console(),
>     console_stop(), console_start(), console_unblank().
> 
>     Signed-off-by: John Ogness <john.ogness@linutronix.de>
>     Reviewed-by: Petr Mladek <pmladek@suse.com>
>     Signed-off-by: Petr Mladek <pmladek@suse.com>
>     Link: 
> 
https://lore.kernel.org/r/20220421212250.565456-12-john.ogness@linutronix.de
> 
>  include/linux/printk.h |  7 +++++
>  kernel/printk/printk.c | 83
> ++++++++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 90 insertions(+)

