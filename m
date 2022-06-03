Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92B6C53C3E9
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Jun 2022 06:59:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239498AbiFCE7V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Jun 2022 00:59:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239407AbiFCE7T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jun 2022 00:59:19 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D888038BC7
        for <linux-kernel@vger.kernel.org>; Thu,  2 Jun 2022 21:59:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654232356; x=1685768356;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=XflJj+AVkb5ATVJNtxqgULNANQfV/2C+BCIyozBLS3o=;
  b=J11wGRpBLvwq4UdFswcbWm3PoEE6t/TDNgxzZHZm+qzh3CXDVZi/28w2
   fohUsdq0lCMi8G9kaF+7YPMsdep5Jx1CRTwmyplUS8QQSJTmeTUQkHQAM
   7Oo5FPpNoZMwwyflR3LCP3OYVtbryV6sVbsNXtDoiym9j48G1NiVQf63z
   KYq6AoLhLmkU5hkUHkXEv8OdBFTujsfBLbXIM+Pq4bNjwJ0KMG4aO02Lf
   Qx+Zifw3I3KwIimsIb+eI62p1RNk6LWLoZvpiF2clvFscM9vBPrMBG/e6
   Hf32ep3MtrCVqSHOFIJfgbkNQX5oh9DF9gSVewn3+DjWRlvl1DGrDvukP
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10366"; a="339213146"
X-IronPort-AV: E=Sophos;i="5.91,273,1647327600"; 
   d="scan'208";a="339213146"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2022 21:59:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,273,1647327600"; 
   d="scan'208";a="646315933"
Received: from unknown (HELO localhost.localdomain) ([10.226.216.117])
  by fmsmga004.fm.intel.com with ESMTP; 02 Jun 2022 21:59:14 -0700
From:   kah.jing.lee@intel.com
To:     gregkh@linuxfoundation.org
Cc:     arnd@arndb.de, dinguyen@kernel.org, kah.jing.lee@intel.com,
        lftan@altera.com, linux-kernel@vger.kernel.org,
        tien.sung.ang@intel.com
Subject: Re: [PATCH 1/2] drivers: misc: intel_sysid: Add sysid from arch to drivers
Date:   Fri,  3 Jun 2022 12:57:33 +0800
Message-Id: <20220603045732.3073983-1-kah.jing.lee@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <YpkaTFywg+GkPElr@kroah.com>
References: <YpkaTFywg+GkPElr@kroah.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kah Jing Lee <kah.jing.lee@intel.com>

> On Thu, Jun 02, 2022 at 08:22:13PM +0800, kah.jing.lee@intel.com wrote:
> > From: Kah Jing Lee <kah.jing.lee@intel.com>
> > 
> > Add sysid driver. The Altera(Intel) Sysid component is generally part of an
> > FPGA design. The component can be hotplugged when the FPGA is reconfigured.
> > This patch fixes the driver to support the component being hotplugged.
> > 
> > Usage:
> >   cat /sys/bus/platform/devices/soc:base_fpga_region/
> > 		soc:base_fpga_region:fpga_pr_region0/[addr.sysid]/sysid/id
> >   cat /sys/bus/platform/devices/soc:base_fpga_region/
> > 		soc:base_fpga_region:fpga_pr_region0/[addr.sysid]/sysid/timestamp
> > 
> > Signed-off-by: Ley Foon Tan <lftan@altera.com>
> > Signed-off-by: Kah Jing Lee <kah.jing.lee@intel.com>
>
> Please work with the Intel open source group as there are some internal
> Intel requirements that you have not met here in order to be able to
> submit a patch for external people to review.  I'll refrain from
> reviewing or even considering this to be able to be accepted this until
> that happens.

Will update the license header and commit message, and resent.
Thanks for pointing out =).

> good luck!
> 
> greg k-h
