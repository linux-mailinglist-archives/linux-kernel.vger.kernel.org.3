Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACD92543A2A
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 19:23:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230031AbiFHRXA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 13:23:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229697AbiFHRWm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 13:22:42 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 805A524A685
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jun 2022 10:14:22 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id o6-20020a17090a0a0600b001e2c6566046so24451381pjo.0
        for <linux-kernel@vger.kernel.org>; Wed, 08 Jun 2022 10:14:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=egiLLKGdpV2llxCKr0nnUtNRcHSTkDD/C9StjqhJwTA=;
        b=k1sfvISH2Sdwc1FIPhi3BB/QRohqYKpauU1UWP0WMUSa2pVAd2t/OWq8UizdfKJ1Gs
         0cEF2PM+PZEo4VgS7QP1/IfcIgk37/IS6d/g2aBxi6nz6zcDHOmE4AbzYBxv6TO7+6Gs
         dVdZDMAuSjNREJGGvzoIeG30ETbSwWUMdn/yr0lE88yCP7ur3M0Y1jO9eqA3rxjE8blQ
         wuX5g+Z0l3X+Ee3pkCLb1twGLH9iBL4LQSA2zQTimczmbnNVXNkjYorwyapf78W/3yUc
         72c154e3w8K1kNFavpAJlAVOw4EyDrma+OX0pYxYDpYhVqPsb/zTYi5BdfdRDHxSTb3N
         834A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=egiLLKGdpV2llxCKr0nnUtNRcHSTkDD/C9StjqhJwTA=;
        b=OvGNdMy6ailMOD5t/yhnWC8QObZLhvZW9R7wGFa4n5y3dgrpmcTZi2UrkztCjIE7os
         s1s6Rcx16vvkVMvaDCX7ns9nGUltbeEhXa/ChmtMmz5jLREl4MxOJOlGXtcAMhN+UI3n
         J7/5SU8xM1ugoV/YLl44LBAu7UAKV4ghZR1657OKxAj/g0juH8/IKST1755qWOlJYjLR
         /PJfh9xqQ+INxvZbnw5QDeSjwoSOJBRefKPaMIQFUzMD7Grmh/e+AErf4J4GvhNmVLF3
         I7HwaKPeNQ+r9MDfB6wDSjy/s6H2jDUfwJOhpUzyFiZJXXFsYcmtqtxZ9jlQJywGZEMt
         oVHg==
X-Gm-Message-State: AOAM531RTDhx4AlH4r/OG2NbwT8ZM1HYBW4ddgV6bqMLhUq/AcRm+qey
        wYBya/cYiUcU81DnR/zPA4obGA==
X-Google-Smtp-Source: ABdhPJwnSXhqanUExGjOjaslzLH28gNyihKxRKbOKvlSQ5G9Fh+O5F4WK51Ziid1m7cnlKuvugoFEQ==
X-Received: by 2002:a17:902:ec84:b0:167:6f74:ba76 with SMTP id x4-20020a170902ec8400b001676f74ba76mr20402231plg.17.1654708461912;
        Wed, 08 Jun 2022 10:14:21 -0700 (PDT)
Received: from anup-ubuntu64-vm.. ([122.162.103.97])
        by smtp.gmail.com with ESMTPSA id t7-20020a17090a4e4700b001df4b919937sm16803986pjl.16.2022.06.08.10.14.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jun 2022 10:14:21 -0700 (PDT)
From:   Anup Patel <apatel@ventanamicro.com>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>
Cc:     Atish Patra <atishp@atishpatra.org>,
        Alistair Francis <Alistair.Francis@wdc.com>,
        Anup Patel <anup@brainfault.org>,
        linux-remoteproc@vger.kernel.org, kvm-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, Anup Patel <apatel@ventanamicro.com>
Subject: [PATCH] rpmsg: virtio: Fix broken rpmsg_probe()
Date:   Wed,  8 Jun 2022 22:43:34 +0530
Message-Id: <20220608171334.730739-1-apatel@ventanamicro.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The rpmsg_probe() is broken at the moment because virtqueue_add_inbuf()
fails due to both virtqueues (Rx and Tx) marked as broken by the
__vring_new_virtqueue() function. To solve this, virtio_device_ready()
(which unbreaks queues) should be called before virtqueue_add_inbuf().

Fixes: 8b4ec69d7e09 ("virtio: harden vring IRQ")
Signed-off-by: Anup Patel <apatel@ventanamicro.com>
---
 drivers/rpmsg/virtio_rpmsg_bus.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/rpmsg/virtio_rpmsg_bus.c b/drivers/rpmsg/virtio_rpmsg_bus.c
index 905ac7910c98..71a64d2c7644 100644
--- a/drivers/rpmsg/virtio_rpmsg_bus.c
+++ b/drivers/rpmsg/virtio_rpmsg_bus.c
@@ -929,6 +929,9 @@ static int rpmsg_probe(struct virtio_device *vdev)
 	/* and half is dedicated for TX */
 	vrp->sbufs = bufs_va + total_buf_space / 2;
 
+	/* From this point on, we can notify and get callbacks. */
+	virtio_device_ready(vdev);
+
 	/* set up the receive buffers */
 	for (i = 0; i < vrp->num_bufs / 2; i++) {
 		struct scatterlist sg;
@@ -983,9 +986,6 @@ static int rpmsg_probe(struct virtio_device *vdev)
 	 */
 	notify = virtqueue_kick_prepare(vrp->rvq);
 
-	/* From this point on, we can notify and get callbacks. */
-	virtio_device_ready(vdev);
-
 	/* tell the remote processor it can start sending messages */
 	/*
 	 * this might be concurrent with callbacks, but we are only
-- 
2.34.1

