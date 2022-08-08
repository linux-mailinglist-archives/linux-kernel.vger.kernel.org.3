Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C03758C5EC
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Aug 2022 11:52:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242546AbiHHJwR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Aug 2022 05:52:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242288AbiHHJwD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Aug 2022 05:52:03 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AD23140B0
        for <linux-kernel@vger.kernel.org>; Mon,  8 Aug 2022 02:51:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659952319; x=1691488319;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=1DVpE7fPNNHrmHG3iSp9LQk8fkVse1senvugUDPu8z4=;
  b=LrC2WubhcWlJDeFzmhoiuHnhfvqEbQJ2sYj34MTcYkm0SDoahWmVvwA4
   UkE6BHiF2qqdwmwmGxtQdoeHW+GEA+0qE2RbB5CrhFhGtXKjRvu0qn0Ak
   wiJ4Q/dnCLOJYagkQsgVOITSsj6v879XqGpmd6d8niTgKpxH0mxloSgEh
   duwDUTy1SXZKyeGWLe7rxCM3qUiho8tatJjNIAbjxsyOxCO91fdSWOuSZ
   CLE5B/FA7nlDmBglUYmTFY6RObqSTd9nu1ZVR2DcB7s/nUaE6QOItrP7d
   eb3JXlvOjAL4P6j19SVQy3G/jvvmsAQNGdj5E8jmaQPKrQTN5sui1Z5ab
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10432"; a="376845442"
X-IronPort-AV: E=Sophos;i="5.93,222,1654585200"; 
   d="scan'208";a="376845442"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2022 02:51:58 -0700
X-IronPort-AV: E=Sophos;i="5.93,222,1654585200"; 
   d="scan'208";a="850015638"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.162])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2022 02:51:56 -0700
Received: by lahna (sSMTP sendmail emulation); Mon, 08 Aug 2022 12:51:53 +0300
Date:   Mon, 8 Aug 2022 12:51:53 +0300
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Brad Campbell <lists2009@fnarfbargle.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: Apple Thunderbolt Display chaining
Message-ID: <YvDcudE5BRtZAtfM@lahna>
References: <Yk2qMt568oEeTj8H@lahna>
 <49183e52-2e73-b32f-11ad-6036b1040d7c@fnarfbargle.com>
 <Yuz/Q3MTVIhCZU+0@lahna>
 <f5c8b9f0-0d6d-c6db-ae0b-894acb58d078@fnarfbargle.com>
 <Yu0UuOVGeIv/U+jU@lahna>
 <d484d7e5-f1aa-1096-e6fb-bbf16ce28699@fnarfbargle.com>
 <Yu0nWro4xXURbSX6@lahna>
 <87c1a001-ef79-6390-dfe2-06d2850f6e84@fnarfbargle.com>
 <Yu4Gmkous7asng6h@lahna>
 <42e81a8e-e393-7a69-7339-a020ebb57935@fnarfbargle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42e81a8e-e393-7a69-7339-a020ebb57935@fnarfbargle.com>
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sat, Aug 06, 2022 at 05:41:37PM +0800, Brad Campbell wrote:
> I've left in the patch to not set up the DP tunnel and recompiled with CONFIG_PCI_DEBUG=y
> 
> The minimum I can use to reproduce the fault is a single Thunderbolt display. The Apple TB->GBe dongle doesn't do it
> and I have a TB->USB3+eSATA dongle that won't run on the TB3->TB1 adapter due to insufficient power.
> 
> This is captured with serial console. It's a cold boot with a single TB display connected. Boots to desktop and I immediately issue a reboot.
> 
> From -> [   15.337689] xhci_hcd 0000:53:00.3: xHCI Host Controller <- on the second boot, the console output slows to
> about 1-2 characters per second (nothing updates on the monitor) and eventually the machine reboots by itself. I don't have reboot on panic set.

I noticed that the device links are not set for AR/TR devices but it
probably does not help here. Anyway can you try the below patch just in
case?

I did not see anything that stands out from the logs so next step would
be to unbind the drivers for each PCIe device of the TBT display and see
if that helps (so we can narrow this down to a specific driver). You can
either just unload the whole driver (rmmod or modprobe -r) or
"echo XXXX > /sys/pci/drivers/DRIVER/unbind". Where XXXX is the PCI
device name, like 0000:00:2a.0 and so on.

diff --git a/drivers/thunderbolt/tb.c b/drivers/thunderbolt/tb.c
index 8030fc544c5e..bfe023030b90 100644
--- a/drivers/thunderbolt/tb.c
+++ b/drivers/thunderbolt/tb.c
@@ -2181,6 +2181,10 @@ static void tb_apple_add_links(struct tb_nhi *nhi)
 	case PCI_DEVICE_ID_INTEL_CACTUS_RIDGE_4C:
 	case PCI_DEVICE_ID_INTEL_FALCON_RIDGE_2C_NHI:
 	case PCI_DEVICE_ID_INTEL_FALCON_RIDGE_4C_NHI:
+	case PCI_DEVICE_ID_INTEL_ALPINE_RIDGE_2C_NHI:
+	case PCI_DEVICE_ID_INTEL_ALPINE_RIDGE_4C_NHI:
+	case PCI_DEVICE_ID_INTEL_TITAN_RIDGE_2C_NHI:
+	case PCI_DEVICE_ID_INTEL_TITAN_RIDGE_4C_NHI:
 		break;
 	default:
 		return;
