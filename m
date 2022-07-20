Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FA4657B013
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 06:44:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238395AbiGTEmI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jul 2022 00:42:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235726AbiGTEmG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 00:42:06 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BE7F4D81A
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 21:42:05 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id o18so2496676pjs.2
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 21:42:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=j3tROHUdq4pnGcgsDeBeDQDHXCu1H/Hsh0ZTYdZJBlc=;
        b=kepDbCgbgVndCELhXQpLr2ojeoqI6UyFCaw2uLKvl3/fYxDGxbB8jKrO+bA5lkczVD
         wOc8iAQqfDXTwacxbtqk+/f9R6bhZBjc93AUwxhAy5Pvjdw2K4+yDdlHaL3AEkL+uXgb
         n5vCsVvYGYvuvowMKTxCK0N2ljIBC+7rfD+VxPJhc+mCpz7dka7O9EkrEaM2C97AAY6x
         EZ33PJHNw8dHMXxtlbJSIZp2JUtGZc5MuY68270SZzoa+S00PhyEYPnOBL3ByK9XIHkX
         9xiPLch3UOVVV4hhopYI3V/yX/IiWnbhyYRahm0WIOCkzyCNhxGOKbPZLH03n6ZwHopp
         mtsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=j3tROHUdq4pnGcgsDeBeDQDHXCu1H/Hsh0ZTYdZJBlc=;
        b=tLzSC+g7DVgMvyu6kU3WEdW5UbceC6P+etLi70RPcwcJHdFsPwW7eHp62vJ76hYBBx
         cCYR6yOzlKUalWoD64sPIAFg3iTwAAUSkBAFcU7PL/hQRUO5J2V8vxQ4rM+1eK7RWBBV
         gUYlwQv5pGo3zWmf5pi4p9FUx5NE0krobFKvu5S8jd/V4Bh0edB/0YGMfEmVlzi+SaCA
         l5FXW43N9GDsnSj0sKyfL9KLKv6SqOIW4PL/9xc+deabrrofK+G/fA0V8dwhUWNBjLGM
         stCHvNcSRdygA1TuNBdabcZbCEo9QH2xR/rGJZ2uNuPEORCMgegEfJwX1/mKDNR37fn6
         AlWQ==
X-Gm-Message-State: AJIora/kokHXfGrwFeG6JTNQL210/eUKZPQB+5fHIIkaAVSUYAc9G20b
        yM0FAAWPwVbrmI3gkq9fKMzpD6m7yfw+
X-Google-Smtp-Source: AGRyM1uNgdGB4X4QEOb7QYHeNUZ9QS4tmzY9w26M/YfLXXBnP89vcSTwDzrs6aGBe/2SCDC77+Hc5g==
X-Received: by 2002:a17:90a:6d63:b0:1f2:1669:7c30 with SMTP id z90-20020a17090a6d6300b001f216697c30mr3195559pjj.89.1658292124663;
        Tue, 19 Jul 2022 21:42:04 -0700 (PDT)
Received: from localhost ([139.177.225.253])
        by smtp.gmail.com with ESMTPSA id e29-20020aa7981d000000b0052a8128699fsm12388428pfl.207.2022.07.19.21.42.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Jul 2022 21:42:04 -0700 (PDT)
From:   Xie Yongji <xieyongji@bytedance.com>
To:     mst@redhat.com, jasowang@redhat.com, xiaodong.liu@intel.com,
        maxime.coquelin@redhat.com, stefanha@redhat.com
Cc:     songmuchun@bytedance.com,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/5] VDUSE: Support registering userspace memory as bounce buffer
Date:   Wed, 20 Jul 2022 12:41:39 +0800
Message-Id: <20220720044144.90-1-xieyongji@bytedance.com>
X-Mailer: git-send-email 2.25.1
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
 include/uapi/linux/vduse.h           |  48 +++++++
 4 files changed, 325 insertions(+), 13 deletions(-)

-- 
2.20.1

