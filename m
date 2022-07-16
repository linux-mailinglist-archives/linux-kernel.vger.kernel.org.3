Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8501B5771A0
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Jul 2022 23:47:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232151AbiGPVrF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Jul 2022 17:47:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229941AbiGPVrD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Jul 2022 17:47:03 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C93F618E13
        for <linux-kernel@vger.kernel.org>; Sat, 16 Jul 2022 14:47:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1658008020;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=epB7rlrzw6XyEr2+HEifgpL7PVvDrusi3GoURdV5q2k=;
        b=K0KZ74rqZRskbyarYt+uEx/05J6WjZAYqT3JcDpQ1hMdtb7J9hm1QVwaxRJdpYTP/xNPyc
        AU47/5+QJ3lUVlcqvpKK6z8icEO9FHevLMqMMkuUVnePY8/KzW8/IHMKFE60OqUazpiRGZ
        yFm8IkJztyKT6ZvnvPypiDT/nqcAjn0=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-8-gxlRbxR2ODOmZHBHLKIXQw-1; Sat, 16 Jul 2022 17:46:59 -0400
X-MC-Unique: gxlRbxR2ODOmZHBHLKIXQw-1
Received: by mail-qk1-f200.google.com with SMTP id az32-20020a05620a172000b006b58ce94435so6243275qkb.1
        for <linux-kernel@vger.kernel.org>; Sat, 16 Jul 2022 14:46:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=epB7rlrzw6XyEr2+HEifgpL7PVvDrusi3GoURdV5q2k=;
        b=qIXDGdxa2xVh4voxgF+eeJ1eFDbY+5KOnryXPmDT/eOlSfHXhOhffIzvpnYJ0kU3Cz
         sjSPQysXggiKz1oapo1yBl2nl7rg7Rfshx8p795ZqRkRVKEUUcX1xncFEzuFMiehbvHi
         B3XAwy6roM3APc/imtSE7ayWyL/HUz+oNqgKmQlkyD9jKqisB1v2Czl/GcCzZBxWK3fp
         Lfa3LTcC6hFhuGP2IJNdQe2oURwytTvMXvIKInzJF8gFnWjWOMl4CDVmD641wXcI+dRo
         c81tzaUT6w83HPXJTyXe3Q2/+X2QzzdpEJKt6UJo7wMuvTWXkraammP1oAlmG6HyCsYw
         9QqQ==
X-Gm-Message-State: AJIora9xJBqIDiw8Ok8ULsGKOMhbYRioM9KLB1GJupKuKuMkl8p0Hbmy
        s+M0EkYuo8bIX1ifHAgZf2BPFsccaPQU9t3/IvHrj9DAYJzMPrh/quvyLQZaNXke5KqFQ16ZWbp
        Du0cRv3E8vAizDAiPkQZhNgID
X-Received: by 2002:a37:2f44:0:b0:6b5:b10d:6f1 with SMTP id v65-20020a372f44000000b006b5b10d06f1mr13314486qkh.519.1658008018875;
        Sat, 16 Jul 2022 14:46:58 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1sCWMb1HpZpVkq7nYKBH6ZxTcvmV5ifECAsHhu9bjCZGadDxzE/B/vvdUPRDZA6qJClbqRJjg==
X-Received: by 2002:a37:2f44:0:b0:6b5:b10d:6f1 with SMTP id v65-20020a372f44000000b006b5b10d06f1mr13314475qkh.519.1658008018680;
        Sat, 16 Jul 2022 14:46:58 -0700 (PDT)
Received: from dell-per740-01.7a2m.lab.eng.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id o21-20020a05620a2a1500b006b5cdbbfccfsm5742503qkp.79.2022.07.16.14.46.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Jul 2022 14:46:58 -0700 (PDT)
From:   Tom Rix <trix@redhat.com>
To:     nbd@nbd.name, john@phrozen.org, sean.wang@mediatek.com,
        Mark-MC.Lee@mediatek.com, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, matthias.bgg@gmail.com
Cc:     netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Tom Rix <trix@redhat.com>
Subject: [PATCH] net: ethernet: mtk_eth_soc: fix off by one check of ARRAY_SIZE
Date:   Sat, 16 Jul 2022 17:46:54 -0400
Message-Id: <20220716214654.1540240-1-trix@redhat.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In mtk_wed_tx_ring_setup(.., int idx, ..), idx is used as an index here
  struct mtk_wed_ring *ring = &dev->tx_ring[idx];

The bounds of idx are checked here
  BUG_ON(idx > ARRAY_SIZE(dev->tx_ring));

If idx is the size of the array, it will pass this check and overflow.
So change the check to >= .

Fixes: 804775dfc288 ("net: ethernet: mtk_eth_soc: add support for Wireless Ethernet Dispatch (WED)")
Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/net/ethernet/mediatek/mtk_wed.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mediatek/mtk_wed.c b/drivers/net/ethernet/mediatek/mtk_wed.c
index 8f0cd3196aac..29be2fcafea3 100644
--- a/drivers/net/ethernet/mediatek/mtk_wed.c
+++ b/drivers/net/ethernet/mediatek/mtk_wed.c
@@ -651,7 +651,7 @@ mtk_wed_tx_ring_setup(struct mtk_wed_device *dev, int idx, void __iomem *regs)
 	 * WDMA RX.
 	 */
 
-	BUG_ON(idx > ARRAY_SIZE(dev->tx_ring));
+	BUG_ON(idx >= ARRAY_SIZE(dev->tx_ring));
 
 	if (mtk_wed_ring_alloc(dev, ring, MTK_WED_TX_RING_SIZE))
 		return -ENOMEM;
-- 
2.27.0

