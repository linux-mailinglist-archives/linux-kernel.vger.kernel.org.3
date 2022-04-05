Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F4004F482E
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 02:00:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377739AbiDEV3U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 17:29:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379485AbiDENNo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 09:13:44 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4577D10782B;
        Tue,  5 Apr 2022 05:15:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649160956; x=1680696956;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=eLlXIWgzT4jg7igfmDa9mpSj+r1W/DMEJ9zt2e+BDk4=;
  b=BROFxVoaMdJ9K3TW78g89ECva9COhsR+KZdSIpNuB+CplyS31FqpO7KS
   f+Zm8dbgsvviWO1GUchRhbsi/1kokykUjP1y4U/EyTtDEw42dYU75wCu3
   3X5Ptdp6q1WLlWcrqBe32i5YI1H9KD68oIkJLwql2cLkbqBSRi8mKkK6b
   0nPcCcdUzoSG91pJYUKZu161QQ24tTkQX3sZC+RlsRxN/PZKY9fh7QPq0
   IVsopk/QFZ/K/+32GBkMd1ifAu9XYmQE9/ioSSCBc+yzhWPhx500Ml1cR
   NMAMur2fpbInQJex6lxim03Np6JG9U1SrmDYabBz4JwP8nZf9+TN1ntpT
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10307"; a="248249151"
X-IronPort-AV: E=Sophos;i="5.90,236,1643702400"; 
   d="scan'208";a="248249151"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Apr 2022 05:15:55 -0700
X-IronPort-AV: E=Sophos;i="5.90,236,1643702400"; 
   d="scan'208";a="505260917"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.162])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Apr 2022 05:15:51 -0700
Received: by lahna (sSMTP sendmail emulation); Tue, 05 Apr 2022 15:09:07 +0300
Date:   Tue, 5 Apr 2022 15:09:07 +0300
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     joro@8bytes.org, baolu.lu@linux.intel.com,
        andreas.noever@gmail.com, michael.jamet@intel.com,
        YehezkelShB@gmail.com, iommu@lists.linux-foundation.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        mario.limonciello@amd.com, hch@lst.de
Subject: Re: [PATCH v3 3/4] thunderbolt: Make iommu_dma_protection more
 accurate
Message-ID: <YkwxY59ACqFF9jer@lahna>
References: <cover.1649089693.git.robin.murphy@arm.com>
 <b1f89ea2ad38221e0b75783357b9afb53087061d.1649089693.git.robin.murphy@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b1f89ea2ad38221e0b75783357b9afb53087061d.1649089693.git.robin.murphy@arm.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 05, 2022 at 11:41:03AM +0100, Robin Murphy wrote:
> Between me trying to get rid of iommu_present() and Mario wanting to
> support the AMD equivalent of DMAR_PLATFORM_OPT_IN, scrutiny has shown
> that the iommu_dma_protection attribute is being far too optimistic.
> Even if an IOMMU might be present for some PCI segment in the system,
> that doesn't necessarily mean it provides translation for the device(s)
> we care about. Furthermore, all that DMAR_PLATFORM_OPT_IN really does
> is tell us that memory was protected before the kernel was loaded, and
> prevent the user from disabling the intel-iommu driver entirely. While
> that lets us assume kernel integrity, what matters for actual runtime
> DMA protection is whether we trust individual devices, based on the
> "external facing" property that we expect firmware to describe for
> Thunderbolt ports.
> 
> It's proven challenging to determine the appropriate ports accurately
> given the variety of possible topologies, so while still not getting a
> perfect answer, by putting enough faith in firmware we can at least get
> a good bit closer. If we can see that any device near a Thunderbolt NHI
> has all the requisites for Kernel DMA Protection, chances are that it
> *is* a relevant port, but moreover that implies that firmware is playing
> the game overall, so we'll use that to assume that all Thunderbolt ports
> should be correctly marked and thus will end up fully protected.
> 
> CC: Mario Limonciello <mario.limonciello@amd.com>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>

Acked-by: Mika Westerberg <mika.westerberg@linux.intel.com>
