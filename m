Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 711C655FA6F
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 10:27:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232693AbiF2I0f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 04:26:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232126AbiF2I0c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 04:26:32 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1352D3C704
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jun 2022 01:26:31 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id i64so14398430pfc.8
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jun 2022 01:26:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0UIAQQ9HCGyHER97dnkBFW2T9Xt3CuTBUILGnHr700w=;
        b=uU5F5rC4RstGQ0rEUREbgWgEu5TkCkITLHxu/bprRgOeBawqHc/HCq+qPUQgJev5vu
         mAsFX1VLQU8Vyt2DuPoi6lcoqMTFJ29ZzftT2I4/5HQ/rt424PGlmZ3D4PQpYCMsCffQ
         U/2ymA8oemaz7ZylvZ/rcq3gI83BxMPlxdxB74lodjDe4anim9FCVz2sp5N6qqe6l3/k
         HwZ9ORx+zHSSd6ra8l4D4jXxAaYCpml705/GY/0h44VSFLmfYjL+3fSQ9+bwO8vr/zuE
         2SUackat9tYweva52a4QubnEIFY89BF9XBaFNfN5qLM/aBeTJ56hYPtpjoR2EfDhqtXc
         9rrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0UIAQQ9HCGyHER97dnkBFW2T9Xt3CuTBUILGnHr700w=;
        b=7mzg8dMmBU8hR2pLo3WHR2cK8nJ8xjOKEJklbc7cklXvzi2amIS1HLw1HytvgbgGHb
         /yTcP7HQtjNnU/1JMfAd+TuLIE8/FdQVFqWJCS7o8ZHwz24APDHACORDfuTC7sEesUkU
         BgiOoghpELcefvs0mrvZwRPS1JGatZU7DlChbMUqsT7Dx/lBnwifQs+NdEPsFEh6hgV4
         bnp/HIg6OzqaFIKif3RSdC54wSxitaRnwNxd6yTySHYbq7KzwG8ZOhK5+XRSaeGFMkO0
         ANxd2HswYfzWcbFPw1zQu5n85BBCGqg7v8f8oJ4+p4tSBxyG9dofyR/ScxIGMJ9Lhv7C
         eArw==
X-Gm-Message-State: AJIora9rVsnmw/z0QoUgiCr/b+y/1sXB49M7uijtdWUmFjHeks+htKBM
        tV2hgggc7uFA4lR4BU4J38Jm
X-Google-Smtp-Source: AGRyM1vrYIRAfVCqxwRqwN5r8vqcmLRbqIMJBj1xrww6ohJOnwQTTUUejTm37tmibbl2FizUGAYpeg==
X-Received: by 2002:a63:86c7:0:b0:40d:af99:608 with SMTP id x190-20020a6386c7000000b0040daf990608mr2000712pgd.515.1656491190403;
        Wed, 29 Jun 2022 01:26:30 -0700 (PDT)
Received: from localhost ([139.177.225.240])
        by smtp.gmail.com with ESMTPSA id h24-20020a635318000000b0040dffa7e3d7sm5246347pgb.16.2022.06.29.01.26.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jun 2022 01:26:29 -0700 (PDT)
From:   Xie Yongji <xieyongji@bytedance.com>
To:     mst@redhat.com, jasowang@redhat.com, xiaodong.liu@intel.com,
        maxime.coquelin@redhat.com, stefanha@redhat.com
Cc:     virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/6] VDUSE: Support registering userspace memory as bounce buffer
Date:   Wed, 29 Jun 2022 16:25:35 +0800
Message-Id: <20220629082541.118-1-xieyongji@bytedance.com>
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
efficiently as discussed before [1]. They can register some
preallocated hugepages to VDUSE to avoid an extra memcpy
from bounce-buffer to hugepages.

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

Please review, thanks!

Xie Yongji (6):
  vduse: Remove unnecessary spin lock protection
  vduse: Use memcpy_{to,from}_page() in do_bounce()
  vduse: Support using userspace pages as bounce buffer
  vduse: Support querying IOLTB information
  vduse: Support registering userspace memory for IOTLB
  vduse: Update api version to 1

 drivers/vdpa/vdpa_user/iova_domain.c | 134 +++++++++++++++++++---
 drivers/vdpa/vdpa_user/iova_domain.h |   9 ++
 drivers/vdpa/vdpa_user/vduse_dev.c   | 163 +++++++++++++++++++++++++++
 include/uapi/linux/vduse.h           |  53 ++++++++-
 4 files changed, 345 insertions(+), 14 deletions(-)

-- 
2.20.1

