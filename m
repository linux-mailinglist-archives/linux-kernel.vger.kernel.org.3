Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DFFC549B8B6
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 17:35:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244380AbiAYQc7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 11:32:59 -0500
Received: from mga11.intel.com ([192.55.52.93]:10994 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1377447AbiAYQ3c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 11:29:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643128172; x=1674664172;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=lCAhx+7z9ejFv1CsTeDdzgeWY4c3i+3bRGbCXPsvqCs=;
  b=KHTxlf8ZYPaLoRB1akStB1vNINZijp4gmR3kfMKJHfA/cJY0VMNcH5gM
   QRzBam8SPprykcpg48gv9uHgy6hMc0On5d56QZ7xij2il7a8Oanr53/cS
   kqDiLCGFGLkTbX/pxLybe1uxICzqYX+dJ6dfUoX97+YRiVfQscxLB2mO5
   7mm0QFbIMwCXQk8d5itY4mrGGIBhrLdChArbfure+67bvdqiR5ajmiOYn
   gMxr13o1JWMJGRlVB31Jv4oZoNQu1sW2HI66/Ot0Is9ixQqcU0dOg19sW
   te6ITPxqy6RW6kPOJqFenIGTvVKnrjd4jKojVVck8occTPzU2WEH6bE/I
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10237"; a="243941899"
X-IronPort-AV: E=Sophos;i="5.88,315,1635231600"; 
   d="scan'208";a="243941899"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2022 08:29:25 -0800
X-IronPort-AV: E=Sophos;i="5.88,315,1635231600"; 
   d="scan'208";a="477164920"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.162])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2022 08:29:22 -0800
Received: by lahna (sSMTP sendmail emulation); Tue, 25 Jan 2022 18:29:19 +0200
Date:   Tue, 25 Jan 2022 18:29:19 +0200
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Andy Pont <andy.pont@sdcsystems.com>
Cc:     Paul Menzel <pmenzel@molgen.mpg.de>,
        Zha Qipeng <qipeng.zha@intel.com>, linux-kernel@vger.kernel.org
Subject: Re: mfd/intel_pmc_bxt: `intel_pmc_get_resources()` results in page
 fault
Message-ID: <YfAlXzNKPTWMl/YS@lahna>
References: <92c233bc-d1e0-b180-efaa-27e05fbd732b@molgen.mpg.de>
 <YfAIrkJaahKpCta6@lahna>
 <2ebf7968-a324-6f98-e178-45d4d19cfb48@molgen.mpg.de>
 <em755e7a07-2a6b-4b3a-9bc8-5f28857392dc@andys-imac.local>
 <YfAbBIxDvfIYrgPV@lahna>
 <em1f48e0b2-2380-45ef-a0c1-2c38a477aa5f@andys-imac.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <em1f48e0b2-2380-45ef-a0c1-2c38a477aa5f@andys-imac.local>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 25, 2022 at 04:27:02PM +0000, Andy Pont wrote:
> Hello Mika,
> 
> > Thanks! The dump looks OK to me wrt. the PMC device. However, I think I
> > found the bug.
> > 
> > Can you try if the below hack fixes the issue?
> I’ll give the patch a test and let you know how I get on.
> 
> Which fields within the ACPI dump are you looking at?  When we boot the same
> hardware platform / Ubuntu image with the stock AMI BIOS then we don’t see
> the kernel oops.

Probably the driver is disabled there.

This one:

 Device (IPC1)
 {
  Name (_HID, "INT34D2")
  Name (_CID, "INT34D2")
  Name (_DDN, "Intel(R) IPC1 Controller")
  Name (RBUF, ResourceTemplate ()
  {
   Memory32Fixed (ReadWrite, 0x0, 0x2000, IBAR)
   Memory32Fixed (ReadWrite, 0x0, 0x4, MDAT)
   Memory32Fixed (ReadWrite, 0x0, 0x4, MINF)
   IO (Decode16, 0x400, 0x480,
         0x04, 0x80)
   Memory32Fixed (ReadWrite, 0x0, 0x2000, SBAR)
   Interrupt (ResourceConsumer, Level, ActiveLow, Exclusive, , , )
   {
         40
   }
  })

