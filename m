Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CF3E56B3D5
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jul 2022 09:52:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237305AbiGHHwU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jul 2022 03:52:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237058AbiGHHwS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 03:52:18 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C432D7D1EE;
        Fri,  8 Jul 2022 00:52:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657266737; x=1688802737;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=239uULks6zxjGO4uNR0/JzpAO+dLRTWr6fDzTNhSsAA=;
  b=G1nHxIy7Auw21jq/+Dj9gSjhaf7if+VvPSYPN9mxCwAlLP8Q70KTSKaF
   Sn9bO5wWU9A4FCrerPpbT8APd4trLrGIIaxasEiNl+E0kGm66UA7917ed
   CfEuLJCC2iXAgL9spT9ryjBp8PocgGpJq7Y7SXCxsML9Roqr0kzofcC1i
   dPnGZXBfqWwS3zEGPp284T7dR2BALgLTu1onIKB0Ei+adrJNAzSxjPdK6
   wBPMcFwZZH9VQf00SnzYvBJeNYTgbIwaOocXhZuCioR4eZFsY8Cv8wUih
   pID6g4/gb39+cjTberokNjlod7CWS34BukM/tpInv10Kk316DvquRW4UR
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10401"; a="284245073"
X-IronPort-AV: E=Sophos;i="5.92,254,1650956400"; 
   d="scan'208";a="284245073"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2022 00:52:17 -0700
X-IronPort-AV: E=Sophos;i="5.92,254,1650956400"; 
   d="scan'208";a="621122916"
Received: from yanc1-mobl.ccr.corp.intel.com (HELO [10.255.28.91]) ([10.255.28.91])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2022 00:52:14 -0700
Message-ID: <903a1677-4217-d793-6295-3927143d98fb@linux.intel.com>
Date:   Fri, 8 Jul 2022 15:52:12 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Cc:     baolu.lu@linux.intel.com, will@kernel.org, iommu@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org,
        suravee.suthikulpanit@amd.com, vasant.hegde@amd.com,
        mjrosato@linux.ibm.com, gerald.schaefer@linux.ibm.com,
        schnelle@linux.ibm.com, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 01/15] iommu/vt-d: Handle race between registration and
 device probe
Content-Language: en-US
To:     Robin Murphy <robin.murphy@arm.com>, joro@8bytes.org
References: <cover.1657034827.git.robin.murphy@arm.com>
 <894db0ccae854b35c73814485569b634237b5538.1657034828.git.robin.murphy@arm.com>
From:   Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <894db0ccae854b35c73814485569b634237b5538.1657034828.git.robin.murphy@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/7/6 01:08, Robin Murphy wrote:
> That also highlights an issue with intel_iommu_get_resv_regions() taking
> dmar_global_lock from within a section where intel_iommu_init() already
> holds it, which already exists via probe_acpi_namespace_devices() when
> an ANDD device is probed, but gets more obvious with the upcoming change
> to iommu_device_register(). Since they are both read locks it manages
> not to deadlock in practice, so I'm leaving it here for someone with
> more confidence to tackle a larger rework of the locking.

I am trying to reproduce this problem. Strangely, even if I selected
CONFIG_LOCKDEP=y, the kernel didn't complain anything. :-)

In fact the rmrr list in the Intel IOMMU driver is always static after
parsing the ACPI/DMAR tables. There's no need to protect it with a lock.
Hence we can safely remove below down/up_read().

4512 static void intel_iommu_get_resv_regions(struct device *device,
4513                                          struct list_head *head)
4514 {
4515         int prot = DMA_PTE_READ | DMA_PTE_WRITE;
4516         struct iommu_resv_region *reg;
4517         struct dmar_rmrr_unit *rmrr;
4518         struct device *i_dev;
4519         int i;
4520
4521         down_read(&dmar_global_lock);
4522         for_each_rmrr_units(rmrr) {
4523                 for_each_active_dev_scope(rmrr->devices, 
rmrr->devices_cnt,
4524                                           i, i_dev) {

Best regards,
baolu
