Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7835D59D147
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 08:27:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240623AbiHWG13 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 02:27:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240611AbiHWG10 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 02:27:26 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B83A76068F
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 23:27:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661236045; x=1692772045;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=bSeAnQzDpJyFPIeSY9JqILoUkwywcUOSbLiQOQt+oh8=;
  b=j4I0u+6DX9yUCsAmFiJMSqjIlVDXlDP/BZv9V6pdp4oQTON/B9ZI/auU
   d4HwNMmOjfHvWqYd3vqIP0iet/nsNvILP7DsNN2IQwaN3BNED8KRTpa4n
   J5Gh6bWFMUi6jxPvG9dBgdc01yuuHA+pc3/AIA6PaBpD/9kG3gJXF2D8b
   SLllzAJ7lNL+MkDAxcnpnktPdDYzmrt/yKlZOv+ydgdnI1k9fE+oz/pec
   DkrvPuuWmo0LGfL+Xg94bP1qhCqjeD7FseoFXXt3o6HDcptoCsRB6oP7Z
   7+XCw2pyuFLQNng1v2oycQvH2HpOg7LFnAWKtVk3LZjywOh3WHfdImhNT
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10447"; a="379893820"
X-IronPort-AV: E=Sophos;i="5.93,256,1654585200"; 
   d="scan'208";a="379893820"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Aug 2022 23:27:25 -0700
X-IronPort-AV: E=Sophos;i="5.93,256,1654585200"; 
   d="scan'208";a="642324907"
Received: from xujinlon-mobl.ccr.corp.intel.com (HELO [10.254.211.102]) ([10.254.211.102])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Aug 2022 23:27:22 -0700
Message-ID: <e18b428a-7390-c42e-e607-ec745add1068@linux.intel.com>
Date:   Tue, 23 Aug 2022 14:27:21 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Cc:     baolu.lu@linux.intel.com, Joerg Roedel <joro@8bytes.org>,
        Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Kevin Tian <kevin.tian@intel.com>,
        Lennert Buytenhek <buytenh@wantstofly.org>,
        Bart Van Assche <bvanassche@acm.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] iommu/vt-d: Fix lockdep splat due to klist iteration
 in atomic context
Content-Language: en-US
To:     iommu@lists.linux.dev
References: <20220819015949.4795-1-baolu.lu@linux.intel.com>
From:   Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20220819015949.4795-1-baolu.lu@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/8/19 09:59, Lu Baolu wrote:
> With CONFIG_INTEL_IOMMU_DEBUGFS enabled, below lockdep splat are seen
> when an I/O fault occurs on a machine with an Intel IOMMU in it.
> 
>   DMAR: DRHD: handling fault status reg 3
>   DMAR: [DMA Write NO_PASID] Request device [00:1a.0] fault addr 0x0
>         [fault reason 0x05] PTE Write access is not set
>   DMAR: Dump dmar0 table entries for IOVA 0x0
>   DMAR: root entry: 0x0000000127f42001
>   DMAR: context entry: hi 0x0000000000001502, low 0x000000012d8ab001
>   ================================
>   WARNING: inconsistent lock state
>   5.20.0-0.rc0.20220812git7ebfc85e2cd7.10.fc38.x86_64 #1 Not tainted
>   --------------------------------
>   inconsistent {HARDIRQ-ON-W} -> {IN-HARDIRQ-W} usage.
>   rngd/1006 [HC1[1]:SC0[0]:HE0:SE1] takes:
>   ff177021416f2d78 (&k->k_lock){?.+.}-{2:2}, at: klist_next+0x1b/0x160
>   {HARDIRQ-ON-W} state was registered at:
>     lock_acquire+0xce/0x2d0
>     _raw_spin_lock+0x33/0x80
>     klist_add_tail+0x46/0x80
>     bus_add_device+0xee/0x150
>     device_add+0x39d/0x9a0
>     add_memory_block+0x108/0x1d0
>     memory_dev_init+0xe1/0x117
>     driver_init+0x43/0x4d
>     kernel_init_freeable+0x1c2/0x2cc
>     kernel_init+0x16/0x140
>     ret_from_fork+0x1f/0x30
>   irq event stamp: 7812
>   hardirqs last  enabled at (7811): [<ffffffff85000e86>] asm_sysvec_apic_timer_interrupt+0x16/0x20
>   hardirqs last disabled at (7812): [<ffffffff84f16894>] irqentry_enter+0x54/0x60
>   softirqs last  enabled at (7794): [<ffffffff840ff669>] __irq_exit_rcu+0xf9/0x170
>   softirqs last disabled at (7787): [<ffffffff840ff669>] __irq_exit_rcu+0xf9/0x170
> 
> The klist iterator functions using spin_*lock_irq*() but the klist
> insertion functions using spin_*lock(), combined with the Intel DMAR
> IOMMU driver iterating over klists from atomic (hardirq) context, where
> pci_get_domain_bus_and_slot() calls into bus_find_device() which iterates
> over klists.
> 
> As currently there's no plan to fix the klist to make it safe to use in
> atomic context, this fixes the lockdep splat by avoid calling
> pci_get_domain_bus_and_slot() in the hardirq context.
> 
> Fixes: 8ac0b64b9735 ("iommu/vt-d: Use pci_get_domain_bus_and_slot() in pgtable_walk()")
> Reported-by: Lennert Buytenhek<buytenh@wantstofly.org>
> Link:https://lore.kernel.org/linux-iommu/Yvo2dfpEh%2FWC+Wrr@wantstofly.org/
> Link:https://lore.kernel.org/linux-iommu/YvyBdPwrTuHHbn5X@wantstofly.org/
> Signed-off-by: Lu Baolu<baolu.lu@linux.intel.com>

This patch has been queued:

https://lore.kernel.org/linux-iommu/20220823061557.1631056-1-baolu.lu@linux.intel.com/

Best regards,
baolu
