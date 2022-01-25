Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0EE5749B7ED
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 16:49:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1582423AbiAYPrp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 10:47:45 -0500
Received: from mga17.intel.com ([192.55.52.151]:25155 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1356663AbiAYPpP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 10:45:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643125515; x=1674661515;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=6NHizDgnF7Rkj9IXiK0qLr1pWduhfQNsRhiaAx2eOSc=;
  b=XyJiaZ+1O5kSrp0IwTs31d0VaxisKBkKrjI2ZmdGubW4pSP+W8O6Sy3W
   c6hvuvdk5R0dWMvkj+0I9bDb22rVXuxM5VdTKZW5x9a35LELw4Gvgq8BR
   UrN+wB4LSKu5Q3bDNUjRo6AbhDZI6CVUzCqDGZwMWyJSWUhE6sWre8uKo
   vIXJUWrqV3yaynQ/7CgQiK66RM6wEuyXI/B0IB05MIKA3qaku2CpzylYR
   9y4CAjk8ASaJfi5KEX6K58skCDUEuX/66SoMNUwPxAYBsFw2tcgtnrO42
   lq4yJwj9d7nM3ygUBGrN/g4VHkz0nkQ4bKGXxh18N0IueCvkflHtVmh/U
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10237"; a="227003778"
X-IronPort-AV: E=Sophos;i="5.88,315,1635231600"; 
   d="scan'208";a="227003778"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2022 07:45:13 -0800
X-IronPort-AV: E=Sophos;i="5.88,315,1635231600"; 
   d="scan'208";a="766811228"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.162])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2022 07:45:11 -0800
Received: by lahna (sSMTP sendmail emulation); Tue, 25 Jan 2022 17:45:08 +0200
Date:   Tue, 25 Jan 2022 17:45:08 +0200
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Andy Pont <andy.pont@sdcsystems.com>
Cc:     Paul Menzel <pmenzel@molgen.mpg.de>,
        Zha Qipeng <qipeng.zha@intel.com>, linux-kernel@vger.kernel.org
Subject: Re: mfd/intel_pmc_bxt: `intel_pmc_get_resources()` results in page
 fault
Message-ID: <YfAbBIxDvfIYrgPV@lahna>
References: <92c233bc-d1e0-b180-efaa-27e05fbd732b@molgen.mpg.de>
 <YfAIrkJaahKpCta6@lahna>
 <2ebf7968-a324-6f98-e178-45d4d19cfb48@molgen.mpg.de>
 <em755e7a07-2a6b-4b3a-9bc8-5f28857392dc@andys-imac.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <em755e7a07-2a6b-4b3a-9bc8-5f28857392dc@andys-imac.local>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Jan 25, 2022 at 02:54:53PM +0000, Andy Pont wrote:
>    Hello Mika
> 
>    `intel_pmc_get_resources()` does not set the name member in the
>    `resource`
> 
>    struct `gcr_res` resulting in a page fault.
> 
> 
> 
>    On which system you reproduce this,
> 
> 
> 
>    The dump contains the name:
> 
> 
> 
>    Hardware name: Star Labs Lite/Lite, BIOS 8 01/24/2022
> 
>    The Star Labs Lite platform is based on the Gemini Lake N5000 CPU and
>    the test hardware is running Ubuntu 20.04 (Ubuntu
>    5.13.0-27.29~20.04.1-generic 5.13.19).
> 
>    and how?
> 
>    It happens every system boot.  The boot process is coreboot, tianocore
>    as a payload then Ubuntu.
> 
>    Can you also share ACPI dump from that system.
> 
>    I have attached the dsdt.asl file from the coreboot build process.

Thanks! The dump looks OK to me wrt. the PMC device. However, I think I
found the bug.

Can you try if the below hack fixes the issue?

diff --git a/drivers/mfd/intel_pmc_bxt.c b/drivers/mfd/intel_pmc_bxt.c
index 9f01d38acc7f..96a0aa316925 100644
--- a/drivers/mfd/intel_pmc_bxt.c
+++ b/drivers/mfd/intel_pmc_bxt.c
@@ -304,7 +304,7 @@ static int intel_pmc_get_resources(struct platform_device *pdev,
 				   struct intel_pmc_dev *pmc,
 				   struct intel_scu_ipc_data *scu_data)
 {
-	struct resource gcr_res;
+	struct resource gcr_res = {};
 	size_t npunit_res = 0;
 	struct resource *res;
 	int ret;
