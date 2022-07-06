Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D2FC567D96
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 07:05:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229922AbiGFFFw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 01:05:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbiGFFFu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 01:05:50 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C39731B792
        for <linux-kernel@vger.kernel.org>; Tue,  5 Jul 2022 22:05:49 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id g20-20020a17090a579400b001ed52939d72so14681682pji.4
        for <linux-kernel@vger.kernel.org>; Tue, 05 Jul 2022 22:05:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=APTTXF1KrNUUDrXNoiJxzvZeYoTEIILtwqLsTCvQq5Y=;
        b=vaawgXBvgnWPxJe8UmN9/xWMC+8qvcOrS47g6FzlHJhYbcUSZC/lU1HLiNEEI1y5Eu
         oTw9E8LLX3EdllQWwq8Ye4GTvyR7BOYaYn2vU4Ri47YI6pJDVzWgWYpNcys5VAnYMEjj
         Wwe1zRwgCUEYT2mHqffZWzuIl0VF/uByWFh9uqKzUu1Cj8yAtpu+qeHewh+fyedIY6Jj
         CrU96IxNCBPq0TTA2nN9jN8CH4q+a1NtwADqYMNFRYHXrqTD5DxBUDtECcKsuJVgm3n6
         EY4/tGIlThPVM/JwnuSq8oviAH5HycHzhF25KCB5P4/1Qb9Qd08fuuBNOg1e0gY49Kcr
         dKvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=APTTXF1KrNUUDrXNoiJxzvZeYoTEIILtwqLsTCvQq5Y=;
        b=V9IsxMZ5WJB+hB3NjX6vQUIkgGusA3wi2NQRI32FyJZWoWLRowDbeTzF5LJ39r9gQ4
         P7j26DCy5G/wgWDwCwURizkSWJ111tmBl4D6vjQhORPphMisH9oXWc/tWR/hwqHRjpIG
         +DwBgXxp0ETwDLbFTh2/fwE7540ufibq2l8igGv6HH9Qjv5ptJtC5wMywnWDncdnqJ3g
         VEOiuM7GMC1FpRW2VproYo6V3waGE4j3IQ784GLayw3zBqcbus8H/of+bs/QxYuxuLT9
         klRgzLew6RLKu26q4DBnzifEHOkfoG0vOYLksAm4RBUPS2ksV+Ksj3Akwu07/rwb4rIb
         5cQw==
X-Gm-Message-State: AJIora+19H/EM+C/BSXHS5shMjleDI2lNiaiUlPM+49IWCbmGJ47GgjJ
        mNF7R/W6mFdQXuTfQmjtBwiFqgGAAAIh1ls=
X-Google-Smtp-Source: AGRyM1t7M9dF5OFVDjRXazKb7Z0s4+uqyPRQgTrjBbuzNtFYuQhTKLBgdadQ0uYKP/iJ5EkiIoRdpg==
X-Received: by 2002:a17:902:9041:b0:16a:aef:7b84 with SMTP id w1-20020a170902904100b0016a0aef7b84mr46200273plz.124.1657083949289;
        Tue, 05 Jul 2022 22:05:49 -0700 (PDT)
Received: from localhost ([139.177.225.253])
        by smtp.gmail.com with ESMTPSA id x12-20020a170902ec8c00b0016bedb7ed1esm3748028plg.116.2022.07.05.22.05.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Jul 2022 22:05:48 -0700 (PDT)
From:   Xie Yongji <xieyongji@bytedance.com>
To:     mst@redhat.com, jasowang@redhat.com, xiaodong.liu@intel.com,
        maxime.coquelin@redhat.com, stefanha@redhat.com
Cc:     songmuchun@bytedance.com,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/5] VDUSE: Support registering userspace memory as bounce buffer
Date:   Wed,  6 Jul 2022 13:04:58 +0800
Message-Id: <20220706050503.171-1-xieyongji@bytedance.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
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

The VDUSE_IOTLB_GET_INFO ioctl can help user to query IOLTB
information such as bounce buffer size. Then user can use
those information on VDUSE_IOTLB_REG_UMEM and
VDUSE_IOTLB_DEREG_UMEM ioctls to register and de-register
userspace memory for IOTLB.

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

V1 to V2:
- Drop the patch that updating API version [MST]
- Replace unpin_user_pages() with unpin_user_pages_dirty_lock() [MST]
- Use __vmalloc(__GFP_ACCOUNT) for memory accounting [MST]

Xie Yongji (5):
  vduse: Remove unnecessary spin lock protection
  vduse: Use memcpy_{to,from}_page() in do_bounce()
  vduse: Support using userspace pages as bounce buffer
  vduse: Support querying IOLTB information
  vduse: Support registering userspace memory for IOTLB

 drivers/vdpa/vdpa_user/iova_domain.c | 134 ++++++++++++++++++++---
 drivers/vdpa/vdpa_user/iova_domain.h |   9 ++
 drivers/vdpa/vdpa_user/vduse_dev.c   | 152 +++++++++++++++++++++++++++
 include/uapi/linux/vduse.h           |  45 ++++++++
 4 files changed, 327 insertions(+), 13 deletions(-)

-- 
2.20.1

