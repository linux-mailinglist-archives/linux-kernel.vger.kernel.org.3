Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4A56519901
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 09:54:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345889AbiEDH5t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 03:57:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345880AbiEDH5o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 03:57:44 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A8D9E15701
        for <linux-kernel@vger.kernel.org>; Wed,  4 May 2022 00:54:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1651650846;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=e0qApkhnRbO98lM1fh2UaoTYi6JZnkn4syzaIV9qt/o=;
        b=AiYJ3QZ9JUABLxpkMPmRzyq8VIg9nF+DaL+0NbLQmEHReX/ftWK3P7jcKCpGheidUgktf/
        Mj3ALu9Jsy0zL6ITqB55EebGihsBQrQW2KGeZnky8X3OFDOTUuOth3ngGDydOJep/IU8R7
        qp3v28qed6V4plhoRNdMniB+gNG+QbY=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-252-u1qB3skmMJ2uk55ksU0zxw-1; Wed, 04 May 2022 03:54:05 -0400
X-MC-Unique: u1qB3skmMJ2uk55ksU0zxw-1
Received: by mail-wm1-f69.google.com with SMTP id m186-20020a1c26c3000000b003943e12185dso362266wmm.7
        for <linux-kernel@vger.kernel.org>; Wed, 04 May 2022 00:54:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=e0qApkhnRbO98lM1fh2UaoTYi6JZnkn4syzaIV9qt/o=;
        b=VoSv8pgNTbZ3cyHgiX3f/EMq32A8mCpROq0o/eDHrBknaCkbE7uN5+TyVRtJjtm8ae
         kywP9VBx0aq7QL7UZsZzUrz3aCU+aR/UMiqqttpyTN0dEkxd34QIh8aGoRvtqfIBejks
         MKHnGOdjvLm0yVZbhE+UzeBxjsFjX2czHnosprOeHvmgIOjaaCKAnOSJ0qjRJBRXK+sD
         jT6Y9L/D9AorWWaVooLAc1dyzAAZzhcZahaVdqc6ejfDdlSTiHGe8DRXDjl9TgTPRjoo
         iPaJ5+nVQWECpfofILMKDzndu1gYtONMo0yjveC70yvzuV+CwQVNI5U/zjNvYesAZoyK
         TshA==
X-Gm-Message-State: AOAM531HgAbOefWsOyy+crzMkWAXKC17LZn84g74MI73Nsz1B+H2jq6/
        EyoYRdcpqfcynhoPvHA1Q4kHU6LtaLoc63/qRybSmif+NjEBb03ehZNw5xajBIUhiiRcR6lG0/j
        MPk69WB4Npk+o207vzG9r2VOP
X-Received: by 2002:a05:6000:18a1:b0:20c:4d65:393c with SMTP id b1-20020a05600018a100b0020c4d65393cmr15329269wri.639.1651650844423;
        Wed, 04 May 2022 00:54:04 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx0ok0ilOJrNeMVmPQ9HsaUZxSfk7nkSTkJHkNutxZ9n+YLfRt3QiSwF2lgbRwiRAkGLJCm7A==
X-Received: by 2002:a05:6000:18a1:b0:20c:4d65:393c with SMTP id b1-20020a05600018a100b0020c4d65393cmr15329236wri.639.1651650844064;
        Wed, 04 May 2022 00:54:04 -0700 (PDT)
Received: from janakin.usersys.redhat.com ([83.148.38.137])
        by smtp.gmail.com with ESMTPSA id q23-20020a1ce917000000b0039454a85a9asm1779338wmc.30.2022.05.04.00.54.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 May 2022 00:54:03 -0700 (PDT)
Date:   Wed, 4 May 2022 09:53:59 +0200
From:   Jan Stancek <jstancek@redhat.com>
To:     Lu Baolu <baolu.lu@linux.intel.com>
Cc:     Joerg Roedel <joro@8bytes.org>, Jason Gunthorpe <jgg@nvidia.com>,
        Christoph Hellwig <hch@infradead.org>,
        Ben Skeggs <bskeggs@redhat.com>,
        Kevin Tian <kevin.tian@intel.com>,
        Ashok Raj <ashok.raj@intel.com>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Eric Auger <eric.auger@redhat.com>,
        Liu Yi L <yi.l.liu@intel.com>,
        Jacob jun Pan <jacob.jun.pan@intel.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>, jstancek@redhat.com,
        bgoncalv@redhat.com
Subject: [bug] NULL pointer deref after 3f6634d997db ("iommu: Use right way
 to retrieve iommu_ops")
Message-ID: <20220504075356.GA2361844@janakin.usersys.redhat.com>
References: <20220216025249.3459465-1-baolu.lu@linux.intel.com>
 <20220216025249.3459465-8-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20220216025249.3459465-8-baolu.lu@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 16, 2022 at 10:52:47AM +0800, Lu Baolu wrote:
>The common iommu_ops is hooked to both device and domain. When a helper
>has both device and domain pointer, the way to get the iommu_ops looks
>messy in iommu core. This sorts out the way to get iommu_ops. The device
>related helpers go through device pointer, while the domain related ones
>go through domain pointer.
>
>Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
>Reviewed-by: Christoph Hellwig <hch@lst.de>
>Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
>---
> include/linux/iommu.h | 11 ++++++++++
> drivers/iommu/iommu.c | 50 +++++++++++++++++++++----------------------
> 2 files changed, 36 insertions(+), 25 deletions(-)
>
>diff --git a/include/linux/iommu.h b/include/linux/iommu.h
>index 9ffa2e88f3d0..90f1b5e3809d 100644
>--- a/include/linux/iommu.h
>+++ b/include/linux/iommu.h
>@@ -381,6 +381,17 @@ static inline void iommu_iotlb_gather_init(struct iommu_iotlb_gather *gather)
> 	};
> }
>
>+static inline const struct iommu_ops *dev_iommu_ops(struct device *dev)
>+{
>+	/*
>+	 * Assume that valid ops must be installed if iommu_probe_device()
>+	 * has succeeded. The device ops are essentially for internal use
>+	 * within the IOMMU subsystem itself, so we should be able to trust
>+	 * ourselves not to misuse the helper.
>+	 */
>+	return dev->iommu->iommu_dev->ops;
>+}
>+
> #define IOMMU_GROUP_NOTIFY_ADD_DEVICE		1 /* Device added */
> #define IOMMU_GROUP_NOTIFY_DEL_DEVICE		2 /* Pre Device removed */
> #define IOMMU_GROUP_NOTIFY_BIND_DRIVER		3 /* Pre Driver bind */
>diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
>index 7cf073c56036..7af0ee670deb 100644
>--- a/drivers/iommu/iommu.c
>+++ b/drivers/iommu/iommu.c
>@@ -323,13 +323,14 @@ int iommu_probe_device(struct device *dev)
>
> void iommu_release_device(struct device *dev)
> {
>-	const struct iommu_ops *ops = dev->bus->iommu_ops;
>+	const struct iommu_ops *ops;
>
> 	if (!dev->iommu)
> 		return;
>
> 	iommu_device_unlink(dev->iommu->iommu_dev, dev);
>
>+	ops = dev_iommu_ops(dev);
> 	ops->release_device(dev);
>
> 	iommu_group_remove_device(dev);
>@@ -833,8 +834,10 @@ static int iommu_create_device_direct_mappings(struct iommu_group *group,
> static bool iommu_is_attach_deferred(struct iommu_domain *domain,
> 				     struct device *dev)
> {
>-	if (domain->ops->is_attach_deferred)
>-		return domain->ops->is_attach_deferred(domain, dev);
>+	const struct iommu_ops *ops = dev_iommu_ops(dev);
>+
>+	if (ops->is_attach_deferred)
>+		return ops->is_attach_deferred(domain, dev);
>
> 	return false;
> }
>@@ -1252,10 +1255,10 @@ int iommu_page_response(struct device *dev,
> 	struct iommu_fault_event *evt;
> 	struct iommu_fault_page_request *prm;
> 	struct dev_iommu *param = dev->iommu;
>+	const struct iommu_ops *ops = dev_iommu_ops(dev);
> 	bool has_pasid = msg->flags & IOMMU_PAGE_RESP_PASID_VALID;
>-	struct iommu_domain *domain = iommu_get_domain_for_dev(dev);
>
>-	if (!domain || !domain->ops->page_response)
>+	if (!ops->page_response)
> 		return -ENODEV;
>
> 	if (!param || !param->fault_param)
>@@ -1296,7 +1299,7 @@ int iommu_page_response(struct device *dev,
> 			msg->pasid = 0;
> 		}
>
>-		ret = domain->ops->page_response(dev, evt, msg);
>+		ret = ops->page_response(dev, evt, msg);
> 		list_del(&evt->list);
> 		kfree(evt);
> 		break;
>@@ -1521,7 +1524,7 @@ EXPORT_SYMBOL_GPL(fsl_mc_device_group);
>
> static int iommu_get_def_domain_type(struct device *dev)
> {
>-	const struct iommu_ops *ops = dev->bus->iommu_ops;
>+	const struct iommu_ops *ops = dev_iommu_ops(dev);
>
> 	if (dev_is_pci(dev) && to_pci_dev(dev)->untrusted)
> 		return IOMMU_DOMAIN_DMA;
>@@ -1580,7 +1583,7 @@ static int iommu_alloc_default_domain(struct iommu_group *group,
>  */
> static struct iommu_group *iommu_group_get_for_dev(struct device *dev)
> {
>-	const struct iommu_ops *ops = dev->bus->iommu_ops;
>+	const struct iommu_ops *ops = dev_iommu_ops(dev);
> 	struct iommu_group *group;
> 	int ret;
>
>@@ -1588,9 +1591,6 @@ static struct iommu_group *iommu_group_get_for_dev(struct device *dev)
> 	if (group)
> 		return group;
>
>-	if (!ops)
>-		return ERR_PTR(-EINVAL);
>-
> 	group = ops->device_group(dev);
> 	if (WARN_ON_ONCE(group == NULL))
> 		return ERR_PTR(-EINVAL);
>@@ -1759,10 +1759,10 @@ static int __iommu_group_dma_attach(struct iommu_group *group)
>
> static int iommu_group_do_probe_finalize(struct device *dev, void *data)
> {
>-	struct iommu_domain *domain = data;
>+	const struct iommu_ops *ops = dev_iommu_ops(dev);
>
>-	if (domain->ops->probe_finalize)
>-		domain->ops->probe_finalize(dev);
>+	if (ops->probe_finalize)
>+		ops->probe_finalize(dev);
>
> 	return 0;
> }
>@@ -2020,7 +2020,7 @@ EXPORT_SYMBOL_GPL(iommu_attach_device);
>
> int iommu_deferred_attach(struct device *dev, struct iommu_domain *domain)
> {
>-	const struct iommu_ops *ops = domain->ops;
>+	const struct iommu_ops *ops = dev_iommu_ops(dev);
>
> 	if (ops->is_attach_deferred && ops->is_attach_deferred(domain, dev))
> 		return __iommu_attach_device(domain, dev);
>@@ -2579,17 +2579,17 @@ EXPORT_SYMBOL_GPL(iommu_set_pgtable_quirks);
>
> void iommu_get_resv_regions(struct device *dev, struct list_head *list)
> {
>-	const struct iommu_ops *ops = dev->bus->iommu_ops;
>+	const struct iommu_ops *ops = dev_iommu_ops(dev);

Hi,

I'm getting panics after hunk above was applied in this patch
on ppc64le KVM guest, dev->iommu is NULL.

Can be reproduced with LTP read_all_sys test or just cat on following file:
# cat /sys/kernel/iommu_groups/0/reserved_regions

[20065.322087] BUG: Kernel NULL pointer dereference on read at 0x000000b8 
[20065.323563] Faulting instruction address: 0xc000000000cb7c1c 
[20065.323625] Oops: Kernel access of bad area, sig: 11 [#1] 
[20065.323671] LE PAGE_SIZE=64K MMU=Hash SMP NR_CPUS=2048 NUMA pSeries 
[20065.323729] Modules linked in: kvm_pr kvm vfio_iommu_spapr_tce vfio_spapr_eeh vfio vhost_net tap vhost_vsock vhost vhost_iotlb snd_seq_dummy dummy msdos minix binfmt_misc vcan can_raw nfsv3 nfs_acl nfs lockd grace fscache netfs tun brd overlay exfat vfat fat vsock_loopback vmw_vsock_virtio_transport_common vsock can_bcm can veth n_gsm pps_ldisc ppp_synctty mkiss ax25 ppp_async ppp_generic serport slcan slip slhc loop snd_hrtimer snd_seq snd_seq_device snd_timer snd soundcore pcrypt crypto_user n_hdlc tls rfkill sunrpc joydev virtio_net net_failover failover virtio_console virtio_balloon crct10dif_vpmsum fuse zram xfs virtio_blk vmx_crypto crc32c_vpmsum ipmi_devintf ipmi_msghandler [last unloaded: vcan] 
[20065.324308] CPU: 3 PID: 119528 Comm: read_all Not tainted 5.18.0-0.rc5.9050ba3a61a4b5b.41.test.fc37.ppc64le #1 
[20065.324402] NIP:  c000000000cb7c1c LR: c000000000cb7ba0 CTR: 0000000000000000 
[20065.324468] REGS: c00000012a3e3660 TRAP: 0300   Not tainted  (5.18.0-0.rc5.9050ba3a61a4b5b.41.test.fc37.ppc64le) 
[20065.324560] MSR:  8000000000009033 <SF,EE,ME,IR,DR,RI,LE>  CR: 44008804  XER: 00000000 
[20065.324638] CFAR: 0000000000002674 DAR: 00000000000000b8 DSISR: 40000000 IRQMASK: 0  
[20065.324638] GPR00: c000000000cb7ba0 c00000012a3e3900 c000000002b5a500 c00000000cd610b0  
[20065.324638] GPR04: c00000000c3bb0c8 0000000000000004 c00000012a3e37ac 000000023c480000  
[20065.324638] GPR08: 000000023c480000 0000000000000000 0000000000000000 a0f18a8800000000  
[20065.324638] GPR12: 0000000084008800 c00000003fffae80 0000000000000000 0000000000000000  
[20065.324638] GPR16: 0000000010060878 0000000000000008 00000000100607b8 c00000000c3bb058  
[20065.324638] GPR20: c00000000c3bb048 c00000000a034fe0 5deadbeef0000100 5deadbeef0000122  
[20065.324638] GPR24: fffffffffffff000 c00000012a3e3920 0000000000000000 c00000012a3e3930  
[20065.324638] GPR28: c00000012a3e3a20 c00000000cf74c00 c0000000014ab060 c00000001a765ef0  
[20065.325248] NIP [c000000000cb7c1c] iommu_get_group_resv_regions+0xcc/0x490 
[20065.325310] LR [c000000000cb7ba0] iommu_get_group_resv_regions+0x50/0x490 
[20065.325368] Call Trace: 
[20065.325391] [c00000012a3e3900] [c000000000cb7ba0] iommu_get_group_resv_regions+0x50/0x490 (unreliable) 
[20065.325474] [c00000012a3e39c0] [c000000000cb8024] iommu_group_show_resv_regions+0x44/0x140 
[20065.325544] [c00000012a3e3a70] [c000000000cb5478] iommu_group_attr_show+0x38/0x60 
[20065.325616] [c00000012a3e3a90] [c00000000070536c] sysfs_kf_seq_show+0xbc/0x1d0 
[20065.325686] [c00000012a3e3b20] [c000000000702124] kernfs_seq_show+0x44/0x60 
[20065.325746] [c00000012a3e3b40] [c00000000061bd2c] seq_read_iter+0x26c/0x6e0 
[20065.325805] [c00000012a3e3c20] [c000000000702fd4] kernfs_fop_read_iter+0x254/0x2e0 
[20065.325877] [c00000012a3e3c70] [c0000000005cf3d0] new_sync_read+0x110/0x170 
[20065.325938] [c00000012a3e3d10] [c0000000005d2770] vfs_read+0x1d0/0x240 
[20065.326002] [c00000012a3e3d60] [c0000000005d2ee8] ksys_read+0x78/0x130 
[20065.326063] [c00000012a3e3db0] [c0000000000303f8] system_call_exception+0x198/0x3a0 
[20065.326133] [c00000012a3e3e10] [c00000000000c64c] system_call_common+0xec/0x250 
[20065.326205] --- interrupt: c00 at 0x7fff849dda64 
[20065.326253] NIP:  00007fff849dda64 LR: 00000000100124a4 CTR: 0000000000000000 
[20065.326319] REGS: c00000012a3e3e80 TRAP: 0c00   Not tainted  (5.18.0-0.rc5.9050ba3a61a4b5b.41.test.fc37.ppc64le) 
[20065.326408] MSR:  800000000280f033 <SF,VEC,VSX,EE,PR,FP,ME,IR,DR,RI,LE>  CR: 28002802  XER: 00000000 
[20065.326501] IRQMASK: 0  
[20065.326501] GPR00: 0000000000000003 00007ffff1cb8fd0 00007fff84af6e00 0000000000000003  
[20065.326501] GPR04: 00007ffff1cb9070 00000000000003ff 0000000000000000 0000000000000000  
[20065.326501] GPR08: 0000000000000000 0000000000000000 0000000000000000 0000000000000000  
[20065.326501] GPR12: 0000000000000000 00007fff84bca640 0000000000000000 0000000000000000  
[20065.326501] GPR16: 0000000010060878 0000000000000008 00000000100607b8 0000000010044cc0  
[20065.326501] GPR20: 0000000000000000 0000000010044640 00007ffff1cb949a 00000000100404c8  
[20065.326501] GPR24: 0000000010040140 0000000010060660 0000000010040110 0000000010040020  
[20065.326501] GPR28: 0000000010060698 00007fff84880000 00007ffff1cb909b 0000000000000003  
[20065.327053] NIP [00007fff849dda64] 0x7fff849dda64 
[20065.327099] LR [00000000100124a4] 0x100124a4 
[20065.327144] --- interrupt: c00 
[20065.327179] Instruction dump: 
[20065.327214] 66f7f000 fbc100b0 fb210088 62d60100 3b210020 fb610098 62f70122 3b610030  
[20065.327289] e8750010 fb210020 fb210028 e9230560 <e92900b8> e9290010 e9890030 2c2c0000  
[20065.327367] ---[ end trace 0000000000000000 ]--- 

# ll /sys/kernel/iommu_groups/0/devices/
total 0
lrwxrwxrwx. 1 root root 0 May  4 03:08 0000:00:01.0 -> ../../../../devices/pci0000:00/0000:00:01.0
lrwxrwxrwx. 1 root root 0 May  4 03:08 0000:00:02.0 -> ../../../../devices/pci0000:00/0000:00:02.0
lrwxrwxrwx. 1 root root 0 May  4 03:08 0000:00:03.0 -> ../../../../devices/pci0000:00/0000:00:03.0
lrwxrwxrwx. 1 root root 0 May  4 03:08 0000:00:04.0 -> ../../../../devices/pci0000:00/0000:00:04.0

# lspci -v
00:01.0 Ethernet controller: Red Hat, Inc. Virtio network device
        Subsystem: Red Hat, Inc. Device 0001
        Device tree node: /sys/firmware/devicetree/base/pci@800000020000000/ethernet@1
        Flags: bus master, fast devsel, latency 0, IRQ 20, IOMMU group 0
        I/O ports at 0080 [size=32]
        Memory at 100b0002000 (32-bit, non-prefetchable) [size=4K]
        Expansion ROM at 100b0040000 [disabled] [size=256K]
        Capabilities: [40] MSI-X: Enable+ Count=3 Masked-
        Kernel driver in use: virtio-pci

00:02.0 USB controller: Apple Inc. KeyLargo/Intrepid USB (prog-if 10 [OHCI])
        Subsystem: Red Hat, Inc. QEMU Virtual Machine
        Device tree node: /sys/firmware/devicetree/base/pci@800000020000000/usb@2
        Flags: bus master, fast devsel, latency 0, IRQ 19, IOMMU group 0
        Memory at 100b0001000 (32-bit, non-prefetchable) [size=256]
        Kernel driver in use: ohci-pci

00:03.0 SCSI storage controller: Red Hat, Inc. Virtio block device
        Subsystem: Red Hat, Inc. Device 0002
        Device tree node: /sys/firmware/devicetree/base/pci@800000020000000/scsi@3
        Flags: bus master, fast devsel, latency 0, IRQ 18, IOMMU group 0
        I/O ports at 0040 [size=64]
        Memory at 100b0000000 (32-bit, non-prefetchable) [size=4K]
        Capabilities: [40] MSI-X: Enable+ Count=2 Masked-
        Kernel driver in use: virtio-pci

00:04.0 Unclassified device [00ff]: Red Hat, Inc. Virtio memory balloon
        Subsystem: Red Hat, Inc. Device 0005
        Device tree node: /sys/firmware/devicetree/base/pci@800000020000000/unknown-legacy-device@4
        Flags: bus master, fast devsel, latency 0, IRQ 17, IOMMU group 0
        I/O ports at 0020 [size=32]
        Kernel driver in use: virtio-pci

full console log from CKI test run:
  https://s3.amazonaws.com/arr-cki-prod-trusted-artifacts/trusted-artifacts/530073525/test%20ppc64le/2407075056/artifacts/test_tasks/recipes/11913490/logs/console.log
kernel config:
  https://s3.amazonaws.com/arr-cki-prod-trusted-artifacts/trusted-artifacts/530073525/publish%20ppc64le/2407075021/artifacts/kernel-ppc64le.config

Regards,
Jan

