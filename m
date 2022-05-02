Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8C335173F2
	for <lists+linux-kernel@lfdr.de>; Mon,  2 May 2022 18:12:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241872AbiEBQPr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 May 2022 12:15:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1386198AbiEBQPj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 May 2022 12:15:39 -0400
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com [199.106.114.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9078DF15
        for <linux-kernel@vger.kernel.org>; Mon,  2 May 2022 09:12:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1651507928; x=1683043928;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=oqVfvIwO+ekNl8VYKW8L9XfK9KFqSFa9jxkzZ+Hsbz0=;
  b=DeZTE+pUbycCrYYS9XdFSVZbInAFQbizrtUm+LU1w3qHR2nI/pC6G2vG
   hpcrcTMO3S0y8KtwsPF2crzUgVB0uAS3ZKGlYejSk4lRLlsua2VpY4KYD
   XWU4+Zvi54Md93eI1kdpvNpqyxI2/lI7LjNZ19rOFy4AoUpiqGAd/4oni
   w=;
Received: from unknown (HELO ironmsg01-sd.qualcomm.com) ([10.53.140.141])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 02 May 2022 09:12:08 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg01-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 May 2022 09:12:08 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Mon, 2 May 2022 09:12:07 -0700
Received: from qian (10.80.80.8) by nalasex01a.na.qualcomm.com (10.47.209.196)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Mon, 2 May 2022
 09:12:06 -0700
Date:   Mon, 2 May 2022 12:12:04 -0400
From:   Qian Cai <quic_qiancai@quicinc.com>
To:     Lu Baolu <baolu.lu@linux.intel.com>
CC:     Joerg Roedel <joro@8bytes.org>, Jason Gunthorpe <jgg@nvidia.com>,
        "Kevin Tian" <kevin.tian@intel.com>, Liu Yi L <yi.l.liu@intel.com>,
        <iommu@lists.linux-foundation.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [RESEND PATCH v8 00/11] Fix BUG_ON in vfio_iommu_group_notifier()
Message-ID: <20220502161204.GA22@qian>
References: <20220418005000.897664-1-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20220418005000.897664-1-baolu.lu@linux.intel.com>
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 18, 2022 at 08:49:49AM +0800, Lu Baolu wrote:
> Hi Joerg,
> 
> This is a resend version of v8 posted here:
> https://lore.kernel.org/linux-iommu/20220308054421.847385-1-baolu.lu@linux.intel.com/
> as we discussed in this thread:
> https://lore.kernel.org/linux-iommu/Yk%2Fq1BGN8pC5HVZp@8bytes.org/
> 
> All patches can be applied perfectly except this one:
>  - [PATCH v8 02/11] driver core: Add dma_cleanup callback in bus_type
> It conflicts with below refactoring commit:
>  - 4b775aaf1ea99 "driver core: Refactor sysfs and drv/bus remove hooks"
> The conflict has been fixed in this post.
> 
> No functional changes in this series. I suppress cc-ing this series to
> all v8 reviewers in order to avoid spam.
> 
> Please consider it for your iommu tree.

Reverting this series fixed an user-after-free while doing SR-IOV.

 BUG: KASAN: use-after-free in __lock_acquire
 Read of size 8 at addr ffff080279825d78 by task qemu-system-aar/22429
 CPU: 24 PID: 22429 Comm: qemu-system-aar Not tainted 5.18.0-rc5-next-20220502 #69
 Call trace:
  dump_backtrace
  show_stack
  dump_stack_lvl
  print_address_description.constprop.0
  print_report
  kasan_report
  __asan_report_load8_noabort
  __lock_acquire
  lock_acquire.part.0
  lock_acquire
  _raw_spin_lock_irqsave
  arm_smmu_detach_dev
  arm_smmu_detach_dev at drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c:2377
  arm_smmu_attach_dev
  __iommu_attach_group
  __iommu_attach_device at drivers/iommu/iommu.c:1942
  (inlined by) iommu_group_do_attach_device at drivers/iommu/iommu.c:2058
  (inlined by) __iommu_group_for_each_dev at drivers/iommu/iommu.c:989
  (inlined by) __iommu_attach_group at drivers/iommu/iommu.c:2069
  iommu_group_release_dma_owner
  __vfio_group_unset_container
  vfio_group_try_dissolve_container
  vfio_group_put_external_user
  kvm_vfio_destroy
  kvm_destroy_vm
  kvm_vm_release
  __fput
  ____fput
  task_work_run
  do_exit
  do_group_exit
  get_signal
  do_signal
  do_notify_resume
  el0_svc
  el0t_64_sync_handler
  el0t_64_sync

 Allocated by task 22427:
  kasan_save_stack
  __kasan_kmalloc
  kmem_cache_alloc_trace
  arm_smmu_domain_alloc
  iommu_domain_alloc
  vfio_iommu_type1_attach_group
  vfio_ioctl_set_iommu
  vfio_fops_unl_ioctl
  __arm64_sys_ioctl
  invoke_syscall
  el0_svc_common.constprop.0
  do_el0_svc
  el0_svc
  el0t_64_sync_handler
  el0t_64_sync

 Freed by task 22429:
  kasan_save_stack
  kasan_set_track
  kasan_set_free_info
  ____kasan_slab_free
  __kasan_slab_free
  slab_free_freelist_hook
  kfree
  arm_smmu_domain_free
  arm_smmu_domain_free at iommu/arm/arm-smmu-v3/arm-smmu-v3.c:2067
  iommu_domain_free
  vfio_iommu_type1_detach_group
  __vfio_group_unset_container
  vfio_group_try_dissolve_container
  vfio_group_put_external_user
  kvm_vfio_destroy
  kvm_destroy_vm
  kvm_vm_release
  __fput
  ____fput
  task_work_run
  do_exit
  do_group_exit
  get_signal
  do_signal
  do_notify_resume
  el0_svc
  el0t_64_sync_handler
  el0t_64_sync
