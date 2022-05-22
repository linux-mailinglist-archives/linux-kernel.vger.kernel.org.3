Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA74B53058E
	for <lists+linux-kernel@lfdr.de>; Sun, 22 May 2022 21:52:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350525AbiEVTtk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 May 2022 15:49:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350435AbiEVTtg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 May 2022 15:49:36 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98A6E38BFF
        for <linux-kernel@vger.kernel.org>; Sun, 22 May 2022 12:49:14 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id gi33so16268785ejc.3
        for <linux-kernel@vger.kernel.org>; Sun, 22 May 2022 12:49:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=tW0vbsqNyBqWB8eLL+zLqE/3yrno5YNaQTHqzB2WNng=;
        b=CanW3o/0o7Jp9mq96FqklsTPi1uCmU/qtWV7warAwwNfuZSx/IOX9GSUQaCh/OXvbT
         LjhpL4jqooFmFpYAzSfB4DJd7xPItmL7RPPx98S3DZTIfLYeT2aZ5G22D7K6n+27JPsq
         LIl2vqmI7gi3cGs/ZMaW0WTlY4SV4l0xG+MQIwTLnQdTu7Tn6Hbof2ePagFwaJZgNaE7
         n4HVCs87I+vwn3bJc3a0IKugkSHdaPN2p7fDk5O9fds47e49cCWwxQpaC87ZV5kQhR0o
         xSNvCK0bzfR35kLXASDo9x8MRsBKpu+Axw44yxEPC7Pm+4aM/eUNAlfsU8hOD5vphvJK
         ZhFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=tW0vbsqNyBqWB8eLL+zLqE/3yrno5YNaQTHqzB2WNng=;
        b=FW9FruMKPnp/hIF9WQqzeNg/xeCpghIO53VvomdfpNOlo2cF5S2xwEv6bEpc8JKGxa
         jKGtJTE+tYcPo2zWR7OEgDL56TGJv8xVfArXnI4frGhdiy9Myp0++qPfKVaoumpe7Jjz
         u+IYm//kY2ilFi53XO4MtuSn32S/DKafawxEcA8yIPjcnZ1zX9AyX7Gmr8G854DSn+w+
         Vw5Y9BMDMYj7dZdXeU371bBFFq6fQNLiAsQUg31OvWk5xhvP6kwVcKelW8mIYKPIMQkJ
         4MkfSvtzlAGeQ/OuvAIkzzEbDSpkwLV+ZSBYL9LAGzFIY3SLjrvCxJxTJ1mCMIXvdolm
         yYjw==
X-Gm-Message-State: AOAM533Fe3oD4KN1HvtCdUgaXTf+NJC38u6LfUqSDLyo4XYng2dUD5jv
        K/bBAPIgKjTjLyZ8nadOxewRmJEwWIs=
X-Google-Smtp-Source: ABdhPJwF+yD1jv0wGZgcBf3rKgRIMvhBNXlvV3liHMIFonghMV8p+lKTdUB9PPOFuwfSLSKwW9IiyA==
X-Received: by 2002:a17:907:8c8c:b0:6fe:ecbf:3412 with SMTP id td12-20020a1709078c8c00b006feecbf3412mr495869ejc.377.1653248953106;
        Sun, 22 May 2022 12:49:13 -0700 (PDT)
Received: from matrix-ESPRIMO-P710 (p57935774.dip0.t-ipconnect.de. [87.147.87.116])
        by smtp.gmail.com with ESMTPSA id sa24-20020a170906edb800b006fe8ac6bc69sm2782191ejb.140.2022.05.22.12.49.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 May 2022 12:49:12 -0700 (PDT)
Date:   Sun, 22 May 2022 21:49:10 +0200
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Forest Bond <forest@alittletooquiet.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 06/11] staging: vt6655: Replace MACvSetCurrBCNTxDescAddr with
 VNSvOutPortD
Message-ID: <1db079979f7e0e3535463d9f31204aa708c6f680.1653203927.git.philipp.g.hortmann@gmail.com>
References: <cover.1653203927.git.philipp.g.hortmann@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1653203927.git.philipp.g.hortmann@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace macro MACvSetCurrBCNTxDescAddr with VNSvOutPortD and as it
was only used twice, it can now be removed.

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
The name of macro and the arguments use CamelCase which
is not accepted by checkpatch.pl
VNSvOutPortD will be replaced in this patch series.
---
 drivers/staging/vt6655/card.c | 3 +--
 drivers/staging/vt6655/mac.h  | 5 -----
 drivers/staging/vt6655/rxtx.c | 2 +-
 3 files changed, 2 insertions(+), 8 deletions(-)

diff --git a/drivers/staging/vt6655/card.c b/drivers/staging/vt6655/card.c
index 72043a29b543..23804cd72477 100644
--- a/drivers/staging/vt6655/card.c
+++ b/drivers/staging/vt6655/card.c
@@ -411,8 +411,7 @@ void CARDvSafeResetTx(struct vnt_private *priv)
 	MACvSetCurrTXDescAddr(TYPE_AC0DMA, priv, priv->td1_pool_dma);
 
 	/* set MAC Beacon TX pointer */
-	MACvSetCurrBCNTxDescAddr(priv->port_offset,
-				 (priv->tx_beacon_dma));
+	VNSvOutPortD(priv->port_offset + MAC_REG_BCNDMAPTR, priv->tx_beacon_dma);
 }
 
 /*
diff --git a/drivers/staging/vt6655/mac.h b/drivers/staging/vt6655/mac.h
index a1d5eb52ddc4..89a3979aeb10 100644
--- a/drivers/staging/vt6655/mac.h
+++ b/drivers/staging/vt6655/mac.h
@@ -565,11 +565,6 @@ do {									\
 	iowrite16(wData & ~(wBits), iobase + byRegOfs);			\
 } while (0)
 
-/* set the chip with current BCN tx descriptor address */
-#define MACvSetCurrBCNTxDescAddr(iobase, dwCurrDescAddr)	\
-	VNSvOutPortD(iobase + MAC_REG_BCNDMAPTR,		\
-		     dwCurrDescAddr)
-
 #define MACvWriteBSSIDAddress(iobase, pbyEtherAddr)		\
 do {								\
 	iowrite8(1, iobase + MAC_REG_PAGE1SEL);			\
diff --git a/drivers/staging/vt6655/rxtx.c b/drivers/staging/vt6655/rxtx.c
index 390b27b02562..03c2ab8489fa 100644
--- a/drivers/staging/vt6655/rxtx.c
+++ b/drivers/staging/vt6655/rxtx.c
@@ -1420,7 +1420,7 @@ static int vnt_beacon_xmit(struct vnt_private *priv,
 
 	priv->wBCNBufLen = sizeof(*short_head) + skb->len;
 
-	MACvSetCurrBCNTxDescAddr(priv->port_offset, priv->tx_beacon_dma);
+	VNSvOutPortD(priv->port_offset + MAC_REG_BCNDMAPTR, priv->tx_beacon_dma);
 
 	iowrite16(priv->wBCNBufLen, priv->port_offset + MAC_REG_BCNDMACTL + 2);
 	/* Set auto Transmit on */
-- 
2.25.1

