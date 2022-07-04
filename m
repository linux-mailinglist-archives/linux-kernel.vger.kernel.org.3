Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38FDA5650B9
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 11:27:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233544AbiGDJ1D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 05:27:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231339AbiGDJ1B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 05:27:01 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDAA3B493
        for <linux-kernel@vger.kernel.org>; Mon,  4 Jul 2022 02:26:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656926819; x=1688462819;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Qqfi1RkliWW6P1CYgD0y8b0qTLe8TyQmIvTSDwhAims=;
  b=DybFJk6bNrUj8okrihCIrMc8e57XdZayZsK0GVG6tFbXajy3DXYOI9Cz
   i0nxI8BKYFV7gUZpXnu0rLSYZGMDFw4m1z9BC+lJC6KYvKHBgrmTjZ5jB
   fTSn8XR31/vUdfxlJGF27kh2E8SN433rxSb84gtmzHwy7qFT7ZZvA9Ric
   XDp3Cg9HkREgyt78RMnoKMtS2BxlaHeTUuV+PiRv7fadmiDHKEl+H7ECB
   pLEu+N+FP9jytXEOBbwlnFRxq807oxn9PdulnCZc8I2ZhlH5ZCFrMWaJO
   zO6IoqCRtD0UTabvg3c4UrOe4yUMYp7bGELQZCAg+kfnNRL65J6Q6bIrR
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10397"; a="271853967"
X-IronPort-AV: E=Sophos;i="5.92,243,1650956400"; 
   d="scan'208";a="271853967"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jul 2022 02:26:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,243,1650956400"; 
   d="scan'208";a="542519403"
Received: from storage2.sh.intel.com (HELO localhost) ([10.67.110.197])
  by orsmga003.jf.intel.com with ESMTP; 04 Jul 2022 02:26:57 -0700
Date:   Mon, 4 Jul 2022 05:26:52 -0400
From:   Liu Xiaodong <xiaodong.liu@intel.com>
To:     Xie Yongji <xieyongji@bytedance.com>
Cc:     mst@redhat.com, jasowang@redhat.com, xiaodong.liu@intel.com,
        maxime.coquelin@redhat.com, stefanha@redhat.com,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/6] VDUSE: Support registering userspace memory as
 bounce buffer
Message-ID: <20220704092652.GB105370@storage2.sh.intel.com>
References: <20220629082541.118-1-xieyongji@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220629082541.118-1-xieyongji@bytedance.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 29, 2022 at 04:25:35PM +0800, Xie Yongji wrote:
> Hi all,
> 
> This series introduces some new ioctls: VDUSE_IOTLB_GET_INFO,
> VDUSE_IOTLB_REG_UMEM and VDUSE_IOTLB_DEREG_UMEM to support
> registering and de-registering userspace memory for IOTLB
> as bounce buffer in virtio-vdpa case.
> 
> The VDUSE_IOTLB_GET_INFO ioctl can help user to query IOLTB
> information such as bounce buffer size. Then user can use
> those information on VDUSE_IOTLB_REG_UMEM and
> VDUSE_IOTLB_DEREG_UMEM ioctls to register and de-register
> userspace memory for IOTLB.
> 
> During registering and de-registering, the DMA data in use
> would be copied from kernel bounce pages to userspace bounce
> pages and back.
> 
> With this feature, some existing application such as SPDK
> and DPDK can leverage the datapath of VDUSE directly and
> efficiently as discussed before [1]. They can register some
> preallocated hugepages to VDUSE to avoid an extra memcpy
> from bounce-buffer to hugepages.

Hi, Yongji

Very glad to see this enhancement in VDUSE. Thank you.
It is really helpful and essential to SPDK.
With this new feature, we can get VDUSE transferred data
accessed directly by userspace physical backends, like RDMA
and PCIe devices.

In SPDK roadmap, it's one important work to export block
services to local host, especially for container scenario.
This patch could help SPDK do that with its userspace
backend stacks while keeping high efficiency and performance.
So the whole SPDK ecosystem can get benefited.

Based on this enhancement, as discussed, I drafted a VDUSE
prototype module in SPDK for initial evaluation:
[TEST]vduse: prototype for initial draft
https://review.spdk.io/gerrit/c/spdk/spdk/+/13534

Running SPDK on single CPU core, configured with 2 P3700 NVMe,
and exported block devices to local host kernel via different
protocols. The randwrite IOPS through each protocol are:
NBD 		  121K
NVMf-tcp loopback 274K
VDUSE 		  463K

SPDK with RDMA backends should have a similar ratio.
VDUSE has a great performance advantage for SPDK.
We have kept investigating on this usage for years.
Originally, some SPDK users used NBD. Then NVMf-tcp loopback
is SPDK community accommended way. In future, VDUSE could be
the preferred way.

> The kernel and userspace codes could be found in github:
> 
> https://github.com/bytedance/linux/tree/vduse-umem
> https://github.com/bytedance/qemu/tree/vduse-umem
> 
> To test it with qemu-storage-daemon:
> 
> $ qemu-storage-daemon \
>     --chardev socket,id=charmonitor,path=/tmp/qmp.sock,server=on,wait=off \
>     --monitor chardev=charmonitor \
>     --blockdev driver=host_device,cache.direct=on,aio=native,filename=/dev/nullb0,node-name=disk0
> \
>     --export type=vduse-blk,id=vduse-test,name=vduse-test,node-name=disk0,writable=on
> 
> [1] https://lkml.org/lkml/2021/6/27/318
> 
> Please review, thanks!

Waiting for its review process.

Thanks
Xiaodong
