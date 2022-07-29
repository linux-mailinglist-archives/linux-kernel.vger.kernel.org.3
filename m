Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E1A8584D43
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jul 2022 10:15:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235575AbiG2IPR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jul 2022 04:15:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235591AbiG2IPB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jul 2022 04:15:01 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FD4F82137
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jul 2022 01:15:00 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id z18so4881382edb.10
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jul 2022 01:15:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=hbLEgaxrLrA+lt0pf8j+1LPKczyD5CeM4DOxfzFvdCs=;
        b=UtRFL4OFdw21a1MrnvF8HlG/tm8pt0PEjiZNotdSR+BXvB4e7QtRZZkSIGTBvpjbXP
         6jZEiswjrUCJPtJLv6zodOv2cZQyEUT4Ecq6wZ9JfGo3zZbpnBXhznanYKKOhhDb7vBI
         WIOuT3vwx2N/H0JGHIr8y5I0wvMe9e76kLTJdTJIdlX1+KvKtfQVL6Qt/kjmqKd81QLo
         7wZm7AuyZ45vPVPc0Jpy+dZBl4S4bqE6r3lD2vUGmJyvBa6Gp87rVFqzd/0g5qA440W0
         31jfc8ZGYSdA5wtsxdQyIcFLky8GTCdCTKaBcvW76Arpt+iZyJv/8GfiMUvTNF2I1RGT
         a/1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=hbLEgaxrLrA+lt0pf8j+1LPKczyD5CeM4DOxfzFvdCs=;
        b=CX4dwEjDsb5cNoulIxGPkeDAj0ovZu3PFdal4JD9aWpQiT8YKVLsXfwuxPs+rQhFB3
         cn6X3+Qve83GZJ42xBvV6s426UoL9mjSDnUmPP2LTKJaoT0pKkS+NGnKcT5R00bsr8wh
         QEk8kN9b1J6HMF21bkJS4rpxBKA5wkliU1DurcbDelN5dQXFPg5bpgX3cYSfXMDu+vPs
         vgbuu80UDYwwkv1Uivx9snyJtqefl056LSSSRExjexHS8XCSI5h3OOp8QH9VFyl2Vcr5
         C0VXTlGW3z2au7CviodSZ9zQ3Izql3UVcrFidEixYyAtfJR1kH/iwUE2LvvEKg1BkIun
         szDA==
X-Gm-Message-State: AJIora9z8LC1y67MCc3x1SpDDy8D0x8ig5Gxv5qFzx0RgKvZymSHDi9I
        Bp+3+K/zsSR+DpO8UEFozCw=
X-Google-Smtp-Source: AGRyM1uBjg5FfYexSGWqbMQKasmzKoc95hUfYfTRSjIi+l2ZvqN4q0bCCK7juB1Sa85VO+6nQDv4lg==
X-Received: by 2002:aa7:dbd9:0:b0:43b:6e02:7e37 with SMTP id v25-20020aa7dbd9000000b0043b6e027e37mr2455217edt.341.1659082499073;
        Fri, 29 Jul 2022 01:14:59 -0700 (PDT)
Received: from matrix-ESPRIMO-P710 (p54a07b82.dip0.t-ipconnect.de. [84.160.123.130])
        by smtp.gmail.com with ESMTPSA id ee24-20020a056402291800b0043b7917b1a4sm1971865edb.43.2022.07.29.01.14.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Jul 2022 01:14:58 -0700 (PDT)
Date:   Fri, 29 Jul 2022 10:14:57 +0200
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Forest Bond <forest@alittletooquiet.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH v2 5/5] staging: vt6655: Replace MACvTransmitAC0 with
 function vt6655_mac_dma_ctl
Message-ID: <013abd177d9ac129c034776f10cdf823fd87d781.1659080988.git.philipp.g.hortmann@gmail.com>
References: <cover.1659080988.git.philipp.g.hortmann@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1659080988.git.philipp.g.hortmann@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert macro MACvTransmitAC0 to existing static function. This saves
codelines and multiline macros are not liked by kernel community.

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
V1 -> V2: Improved description
---
 drivers/staging/vt6655/device_main.c |  2 +-
 drivers/staging/vt6655/mac.h         | 10 ----------
 2 files changed, 1 insertion(+), 11 deletions(-)

diff --git a/drivers/staging/vt6655/device_main.c b/drivers/staging/vt6655/device_main.c
index c0a00063e4d1..1fc8bdf8a311 100644
--- a/drivers/staging/vt6655/device_main.c
+++ b/drivers/staging/vt6655/device_main.c
@@ -1229,7 +1229,7 @@ static int vnt_tx_packet(struct vnt_private *priv, struct sk_buff *skb)
 	wmb(); /* second memory barrier */
 
 	if (head_td->td_info->flags & TD_FLAGS_NETIF_SKB)
-		MACvTransmitAC0(priv->port_offset);
+		vt6655_mac_dma_ctl(priv->port_offset, MAC_REG_AC0DMACTL);
 	else
 		vt6655_mac_dma_ctl(priv->port_offset, MAC_REG_TXDMACTL0);
 
diff --git a/drivers/staging/vt6655/mac.h b/drivers/staging/vt6655/mac.h
index be33da59dd84..467c599a3289 100644
--- a/drivers/staging/vt6655/mac.h
+++ b/drivers/staging/vt6655/mac.h
@@ -537,16 +537,6 @@
 
 /*---------------------  Export Macros ------------------------------*/
 
-#define MACvTransmitAC0(iobase)					\
-do {									\
-	unsigned long dwData;						\
-	dwData = ioread32(iobase + MAC_REG_AC0DMACTL);			\
-	if (dwData & DMACTL_RUN)					\
-		iowrite32(DMACTL_WAKE, iobase + MAC_REG_AC0DMACTL);	\
-	else								\
-		iowrite32(DMACTL_RUN, iobase + MAC_REG_AC0DMACTL);	\
-} while (0)
-
 #define MACvSelectPage0(iobase)				\
 	iowrite8(0, iobase + MAC_REG_PAGE1SEL)
 
-- 
2.37.1

