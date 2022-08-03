Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECCC35886AB
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Aug 2022 06:55:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233659AbiHCEzm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Aug 2022 00:55:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbiHCEzh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Aug 2022 00:55:37 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 256031EACE
        for <linux-kernel@vger.kernel.org>; Tue,  2 Aug 2022 21:55:36 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id i71so8599767pge.9
        for <linux-kernel@vger.kernel.org>; Tue, 02 Aug 2022 21:55:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=QIK/ZKlqdZyMGOYkI4p6QTuyx7SIwyBRy8rMjz/hO5A=;
        b=uXmCXGAKn+5PoS6YzgfCiXH8QjuUV50WM8mQ9PcsIY/qpjtYmWvOw+I+kFivESc3aE
         tzlafoXk5XzAX0L+ZyQ+A/2UsPDXFKJlVr68EWi3TPdrCmla5nmTIcZM8GmozALt6VkA
         TaAvgDRO+WFVJZOTMxSdAav7GkTOTHLDprgKqmTBZkKdIJiNfZ/3bxO7vSIrShDxDMVj
         eb+8GRtZ9gUQdpcBdeRb1uKbOkRgq4S+lFnvxLGWcsY3j1EutEtrMPpDdKs2UUukoq2M
         Fk0NE/qStyJeFgKVeq+HjwDwVv1tcVewr4u4b8ap9pBaYSNqQtR2zCe8KwHF6hfJ3J9T
         OdTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=QIK/ZKlqdZyMGOYkI4p6QTuyx7SIwyBRy8rMjz/hO5A=;
        b=krtHnnUtipQmBeYgaTTtWrnab7Wb+JO8s2oH65nmjuik5YKf3QjgwDvh2h6Fz4XxXn
         NCkUL8xltjjlk6yppUEUadaqYGenelJb1nGI3fJ3uorwCCimERoNOc2fueMK2fwYg+5k
         RuVM4Bq+ATaqGakGLZjDnfeAeSo8Z7UaAgYKwT2TCJqCwQluHDgfDLDtqNKyJ7CXoTLy
         u+KF4vufYyNgmqdOiHw+fNC4z7LOJULiti9slByvpGq14ng/Tx0MCGWcz+QUfdjv9xB5
         JQz9BD3XMc7YBb9nW5aL4/JWnol2ulTZPis6KGtETV6jTJntPD3rKSzrgPKHK51foEyV
         cQ5w==
X-Gm-Message-State: AJIora8figmDegRBEm3IVZgLj1ygcKMYnl5vUPV4AucjosaMUaVJuhTZ
        KBA3m77ofMjBxMDy6BBnq8rM
X-Google-Smtp-Source: AGRyM1srTRHH6q9Go8PEyk4WQKO4nY7p2qnmTFcjVMxUqpA/4dEC6CNQ6nqzr5rS3jxKKDr83u5cig==
X-Received: by 2002:a63:1d49:0:b0:41b:425b:fbc6 with SMTP id d9-20020a631d49000000b0041b425bfbc6mr19379527pgm.407.1659502535631;
        Tue, 02 Aug 2022 21:55:35 -0700 (PDT)
Received: from localhost ([139.177.225.247])
        by smtp.gmail.com with ESMTPSA id q10-20020a170902a3ca00b0016ee328fd61sm640814plb.198.2022.08.02.21.55.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Aug 2022 21:55:34 -0700 (PDT)
From:   Xie Yongji <xieyongji@bytedance.com>
To:     jasowang@redhat.com, mst@redhat.com, xiaodong.liu@intel.com,
        maxime.coquelin@redhat.com, stefanha@redhat.com
Cc:     songmuchun@bytedance.com,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, Xie Yongji <xieyongji@bytedance.com>
Subject: [PATCH v5 0/5] VDUSE: Support registering userspace memory as bounce buffer
Date:   Wed,  3 Aug 2022 12:55:18 +0800
Message-Id: <20220803045523.23851-1-xieyongji@bytedance.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

This series introduces some new ioctls: VDUSE_IOTLB_GET_INFO,
VDUSE_IOTLB_REG_UMEM and VDUSE_IOTLB_DEREG_UMEM to support
registering and de-registering userspace memory for IOTLB
as bounce buffer in virtio-vdpa case.

The VDUSE_IOTLB_GET_INFO ioctl can help user to query whether
one IOVA region support userspace memory registration. Then
user can use VDUSE_IOTLB_REG_UMEM and VDUSE_IOTLB_DEREG_UMEM
ioctls to register and de-register userspace memory for this
region.

During registering and de-registering, the DMA data in use
would be copied from kernel bounce pages to userspace bounce
pages and back.

With this feature, some existing application such as SPDK
and DPDK can leverage the datapath of VDUSE directly and
efficiently as discussed before [1][2]. They can register
some preallocated hugepages to VDUSE to avoid an extra
memcpy from bounce-buffer to hugepages.

The kernel and userspace codes could be found in github:

https://github.com/bytedance/linux/tree/vduse-umem
https://github.com/bytedance/qemu/tree/vduse-umem

To test it with qemu-storage-daemon:

$ qemu-storage-daemon \
    --chardev socket,id=charmonitor,path=/tmp/qmp.sock,server=on,wait=off \
    --monitor chardev=charmonitor \
    --blockdev driver=host_device,cache.direct=on,aio=native,filename=/dev/nullb0,node-name=disk0 \
    --export type=vduse-blk,id=vduse-test,name=vduse-test,node-name=disk0,writable=on

[1] https://lkml.org/lkml/2021/6/27/318
[2] https://lkml.org/lkml/2022/7/4/246

Please review, thanks!

V4 to V5:
- Use more precise check for the bounce buffer region [Jason]

V3 to V4:
- Fix the ioctl definition [Jason]
- Rename VDUSE_IOVA_CAP_UMEM_SUPPORT to VDUSE_IOVA_CAP_UMEM [Jason]

V2 to V3:
- Check if the reserved fields is zero [MST]
- Fix some compile errors
- Rework the VDUSE_IOTLB_GET_INFO ioctl to hide some
  internal implementation (bounce buffer) [Jason]
- Add more commit logs for patch 1 [MST]

V1 to V2:
- Drop the patch that updating API version [MST]
- Replace unpin_user_pages() with unpin_user_pages_dirty_lock() [MST]
- Use __vmalloc(__GFP_ACCOUNT) for memory accounting [MST]

Xie Yongji (5):
  vduse: Remove unnecessary spin lock protection
  vduse: Use memcpy_{to,from}_page() in do_bounce()
  vduse: Support using userspace pages as bounce buffer
  vduse: Support registering userspace memory for IOVA regions
  vduse: Support querying information of IOVA regions

 drivers/vdpa/vdpa_user/iova_domain.c | 102 +++++++++++++--
 drivers/vdpa/vdpa_user/iova_domain.h |   8 ++
 drivers/vdpa/vdpa_user/vduse_dev.c   | 180 +++++++++++++++++++++++++++
 include/uapi/linux/vduse.h           |  47 +++++++
 4 files changed, 324 insertions(+), 13 deletions(-)

-- 
2.20.1

