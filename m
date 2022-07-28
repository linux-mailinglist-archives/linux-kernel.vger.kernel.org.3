Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54E64583770
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jul 2022 05:20:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234576AbiG1DUX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jul 2022 23:20:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233213AbiG1DUS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jul 2022 23:20:18 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECDDE12D05
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jul 2022 20:20:16 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id v16-20020a17090abb9000b001f25244c65dso4062563pjr.2
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jul 2022 20:20:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=I0pDbJFp/4TAald8p9fR9LKm6EPKfhTh9dG+6/FlDFo=;
        b=05QHDSbTkapr3p7hNAl8tkBQW2L/p5JxCJK1h7V+5CExTBUg2JnVfNZAhJeOqUYal/
         xf/0MgB+JWHaCAWUDFvfaW1ygu0D/9/UfYYHhiKuw4Nv58arOXxpZVqsjQoLWh6887W9
         GaCsndMKvn0FJ8ODuPc1C/oBHB4cmKs8QcCOzpcTurtzrTBxNCC2DXrpFFrdQIMDdSi3
         Urw0EFmzBXa8JPyOrrhbSQIqGvhh5tO3gS3uL5DB63y0m5NTxTUru0TRlMN6ELZ7A3MN
         SJ3URErlgw6Y7UKhLKYc5mIhFBD+q+CFnjyB2pQpZkx5IV18ISpKLAyUsJXl9EHpHYc/
         akiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=I0pDbJFp/4TAald8p9fR9LKm6EPKfhTh9dG+6/FlDFo=;
        b=Lv/qIIP7SGDtwZ3RcxdAZQyZ2bavw9alcfy9QJHEuhij+QHXAuIn6uFS3wbgeT3LO3
         DqzJlXUwed9Yirc+/po67poG2X9cxGmJS4Bmk5U8cMm6nSm9T/GG78iK9XBQDA0qsQh2
         cUJL6gjwgCSPG2NQ1hs3y6rTBtVg0i7lEM9yBRX7brIiLd87u5ssfPbSzdZGlf8g0bZR
         K1AOryatwQjUdgSruPScnuGdKZt5ewNsGvL3nR0HRQHr0lR6NBm/kbAX5JGqQanOhd07
         MPc8O+7if8QwOoRrQgf2EqiR0CnuqVzQoXy/f38C7ZtVVzuPqatMUTT2ymqleD25daee
         kkVA==
X-Gm-Message-State: AJIora+2+OQccnx8q+M1AB3n2Yl3wqHW7MKoWDmOmY7A5g449H+tR6+I
        TTzt2O9cCWebIkvrD6i4E/9d
X-Google-Smtp-Source: AGRyM1tLcIliFW1LJQKcL4PuzbqWN6HWn5RleSW897k7M7DrmxeW/uW/bi3H/CXRsx0KwBl8/TJ/1A==
X-Received: by 2002:a17:902:aa84:b0:16d:3ec4:cfc8 with SMTP id d4-20020a170902aa8400b0016d3ec4cfc8mr24830907plr.153.1658978416482;
        Wed, 27 Jul 2022 20:20:16 -0700 (PDT)
Received: from localhost ([139.177.225.253])
        by smtp.gmail.com with ESMTPSA id t15-20020aa7946f000000b0052592a8ef62sm14543125pfq.110.2022.07.27.20.20.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Jul 2022 20:20:16 -0700 (PDT)
From:   Xie Yongji <xieyongji@bytedance.com>
To:     mst@redhat.com, jasowang@redhat.com, xiaodong.liu@intel.com,
        maxime.coquelin@redhat.com, stefanha@redhat.com
Cc:     songmuchun@bytedance.com,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 0/5] VDUSE: Support registering userspace memory as bounce buffer
Date:   Thu, 28 Jul 2022 11:19:55 +0800
Message-Id: <20220728032000.127-1-xieyongji@bytedance.com>
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
