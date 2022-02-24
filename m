Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79F0E4C284B
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 10:39:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232923AbiBXJir (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 04:38:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232678AbiBXJij (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 04:38:39 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75EBC276D61;
        Thu, 24 Feb 2022 01:38:10 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id bx9-20020a17090af48900b001bc64ee7d3cso1524715pjb.4;
        Thu, 24 Feb 2022 01:38:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4tPg4OnWHW1AFqVTKn4PbYlPw2jcbJ+Uaul6Y89V8MY=;
        b=IXqOkV4rJZ0idastlUagEa5ULc6Yr9JrsclHg1mZJ+qZcUcGjM8n6xc9bWd9q37G8u
         kTWmTLFy/4Wq6V/2fz7xD2dp1gbpYt2HXxMkc1HJdJcCR2jq+28i+RaVaMZWbGD2Rc/a
         c/4bQtumv8DIsndf8ZgNqhAhdlekhCw/oAskXnbGksR/DATn19uyemnExqFQBHy4dhqM
         hKkZsWPbIkCEgt2aM+cCPJ/xlbJOh0KvfQy0ZeOG2YhsJDbM732WN1gGJtQq8A3MNoyA
         qhdTH00TlkIv//3VQAdjebHyzsLnZGBo4+dU3lBs7Wwh+D1XilcLaIls2mzIz14qGTeC
         CZIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4tPg4OnWHW1AFqVTKn4PbYlPw2jcbJ+Uaul6Y89V8MY=;
        b=iCmThAkp8t4wq5Ct9MCrG00ATm7izti2/GOxaboveaad8REQkhDIuVn2i6ppGmWFaz
         GfIHSeKyS4RPhWHOigoyHZeTJB3mhKZzUi3aMSz8cRqbtyWjpGQzhSHFPxy1PjWM3ayx
         85wIfAZ7AK8WKt3EArid4bmvXLI5lwexA25E8//O1RvDrRZCBC5K+4gjrRcCAv+aCZ/h
         ZxkYIkKhe1rZHTR8Dj1cbVzSUp2gDGcSKKI7Pjt0bEXJUUtUGHcQSmS6pKzcR2N6xtC7
         PnGmbZcZ7h0amOwrTIhevU0JiXFkvuagoBhGMPknfChcETNRKAd1ZUqIIjj0Y8ebcRXY
         Y+fg==
X-Gm-Message-State: AOAM531jlH31DiaRmkAa04aiTfdLd1fiDpIsrhrT3B7ZmH7hFjS8EcRi
        mStMZFsf3O4fwyVXbGjTsVBFDSvALts=
X-Google-Smtp-Source: ABdhPJxTiKcU6Pumm09KOZBfOETpGzAiVaWoBhOrlHXsOpRWhqj54/dcUo8/ApzvQ3sp1iKY6PyjdA==
X-Received: by 2002:a17:90a:d206:b0:1bb:e73f:9592 with SMTP id o6-20020a17090ad20600b001bbe73f9592mr13500303pju.17.1645695489827;
        Thu, 24 Feb 2022 01:38:09 -0800 (PST)
Received: from fedora-qemu.flets-east.jp (p912131-ipoe.ipoe.ocn.ne.jp. [153.243.13.130])
        by smtp.gmail.com with ESMTPSA id i17sm2033359pgv.8.2022.02.24.01.38.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Feb 2022 01:38:09 -0800 (PST)
From:   Akihiko Odaki <akihiko.odaki@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        Jens Axboe <axboe@kernel.dk>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Akihiko Odaki <akihiko.odaki@gmail.com>
Subject: [PATCH] virtio-blk: Assign discard_granularity
Date:   Thu, 24 Feb 2022 18:38:02 +0900
Message-Id: <20220224093802.11348-1-akihiko.odaki@gmail.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Virtual I/O Device (VIRTIO) Version 1.1
https://docs.oasis-open.org/virtio/virtio/v1.1/csprd01/virtio-v1.1-csprd01.html
> discard_sector_alignment can be used by OS when splitting a request
> based on alignment.

According to Documentation/ABI/stable/sysfs-block, the corresponding
field in the kernel is, confusingly, discard_granularity, not
discard_alignment.

Signed-off-by: Akihiko Odaki <akihiko.odaki@gmail.com>
---
 drivers/block/virtio_blk.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
index c443cd64fc9b..1fb3c89900e3 100644
--- a/drivers/block/virtio_blk.c
+++ b/drivers/block/virtio_blk.c
@@ -913,11 +913,9 @@ static int virtblk_probe(struct virtio_device *vdev)
 		blk_queue_io_opt(q, blk_size * opt_io_size);
 
 	if (virtio_has_feature(vdev, VIRTIO_BLK_F_DISCARD)) {
-		q->limits.discard_granularity = blk_size;
-
 		virtio_cread(vdev, struct virtio_blk_config,
 			     discard_sector_alignment, &v);
-		q->limits.discard_alignment = v ? v << SECTOR_SHIFT : 0;
+		q->limits.discard_granularity = v ? v << SECTOR_SHIFT : 0;
 
 		virtio_cread(vdev, struct virtio_blk_config,
 			     max_discard_sectors, &v);
-- 
2.35.1

