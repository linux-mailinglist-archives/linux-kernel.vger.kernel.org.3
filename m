Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EEAB584D41
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jul 2022 10:14:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235637AbiG2IOx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jul 2022 04:14:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235557AbiG2IOk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jul 2022 04:14:40 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FF3282101
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jul 2022 01:14:38 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id v17so4926330edc.1
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jul 2022 01:14:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Bql96rsyZxB76GDg2PMxZ15XLQXYm6iZUZ1zvDkMvNM=;
        b=RJLshvwMru71GvjWyDbiCin6AFbkYpMBDFCoG5TtILNQMMPHK9ttWtrN+P+e214ZUc
         D1XWjjWlDNaHJrOru/2nzk+G6M06RSPJ0SXrTswnEA8naFIBZfP6IjmSJ88Ig5s4TuyI
         QDP99YVuBwf8hXpZNmkreGb1eJzuvalx9KP5V3T1jglh61Vuq56gBUGiiA9mbjNGFWoH
         gGkg2RdzdJaa4kQcx1V12UBHmMBDrR3puAhyhdX5nEy5Jc3hLnw6e34vgJGjj8Eu23/5
         zSS8BZ9UI3YgEce8DNpc09A8Ijpe4T9v1uQaOYrteNj5fd8WoZfm8pxFc6DjnWEW7A7l
         NNaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Bql96rsyZxB76GDg2PMxZ15XLQXYm6iZUZ1zvDkMvNM=;
        b=TIGiZLfsmFthAUra07a4igVngEXODnkgWdywYP4g1AuC49NUlLxU21kaJsC0hl1C6D
         N1I6ud4SaMBImuvesLBSU/q0dVvWqAwMP6GyKT2UENbvdDmpG247+m/tVcIQaEUQnEJz
         M4SwFHmlZWAVV8G5bfGPdLiS/UeSaZJmhdaAAB6jT1N4LbmK9taAyatO+bBpQLXHw/eP
         QMQnPdNDcDsJ2QsryKtHd0PYZP6MdKZl7qKMIlNA3tF5GSAEb1qtP2u1j/uJRhetPGhX
         lImLn0WXd/J0zUg4LHkKxYS7M5WEzsgjePixOKeadE0Zpdewk/O7jZ1FEcgd53koBVM/
         fzVQ==
X-Gm-Message-State: AJIora9PqlwF60+LnifJr2W36xrvmir5f1h606qdAGByPBmB868d6YmY
        IBnrqAeWFRq3vw4M18UY/ww=
X-Google-Smtp-Source: AGRyM1uIBPYb3HQEI97ljYGfZYV5BFMyBeQmFBpOCMGfiks5T97fBYVnGRRiqpgq772bFwPNhZ82pg==
X-Received: by 2002:aa7:de85:0:b0:43a:d89f:1c7b with SMTP id j5-20020aa7de85000000b0043ad89f1c7bmr2438607edv.17.1659082476883;
        Fri, 29 Jul 2022 01:14:36 -0700 (PDT)
Received: from matrix-ESPRIMO-P710 (p54a07b82.dip0.t-ipconnect.de. [84.160.123.130])
        by smtp.gmail.com with ESMTPSA id 18-20020a170906201200b006fee98045cdsm344073ejo.10.2022.07.29.01.14.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Jul 2022 01:14:36 -0700 (PDT)
Date:   Fri, 29 Jul 2022 10:14:34 +0200
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Forest Bond <forest@alittletooquiet.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/5] staging: vt6655: Replace MACvReceive1 with function
 vt6655_mac_dma_ctl
Message-ID: <ec8dbbfeccb32e0b5c753702cb70d2749426c054.1659080988.git.philipp.g.hortmann@gmail.com>
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

Convert macro MACvReceive1 to existing static function. This saves
codelines and multiline macros are not liked by kernel community.

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
V1 -> V2: Improved description
---
 drivers/staging/vt6655/device_main.c |  4 ++--
 drivers/staging/vt6655/mac.h         | 10 ----------
 2 files changed, 2 insertions(+), 12 deletions(-)

diff --git a/drivers/staging/vt6655/device_main.c b/drivers/staging/vt6655/device_main.c
index fb40d71d9e8e..554531411dad 100644
--- a/drivers/staging/vt6655/device_main.c
+++ b/drivers/staging/vt6655/device_main.c
@@ -432,7 +432,7 @@ static void device_init_registers(struct vnt_private *priv)
 
 	/* Turn On Rx DMA */
 	vt6655_mac_dma_ctl(priv->port_offset, MAC_REG_RXDMACTL0);
-	MACvReceive1(priv->port_offset);
+	vt6655_mac_dma_ctl(priv->port_offset, MAC_REG_RXDMACTL1);
 
 	/* start the adapter */
 	iowrite8(HOSTCR_MACEN | HOSTCR_RXON | HOSTCR_TXON, priv->port_offset + MAC_REG_HOSTCR);
@@ -1147,7 +1147,7 @@ static void vnt_interrupt_process(struct vnt_private *priv)
 		isr = ioread32(priv->port_offset + MAC_REG_ISR);
 
 		vt6655_mac_dma_ctl(priv->port_offset, MAC_REG_RXDMACTL0);
-		MACvReceive1(priv->port_offset);
+		vt6655_mac_dma_ctl(priv->port_offset, MAC_REG_RXDMACTL1);
 
 		if (max_count > priv->opts.int_works)
 			break;
diff --git a/drivers/staging/vt6655/mac.h b/drivers/staging/vt6655/mac.h
index d21313f3067e..5a473ca393f2 100644
--- a/drivers/staging/vt6655/mac.h
+++ b/drivers/staging/vt6655/mac.h
@@ -537,16 +537,6 @@
 
 /*---------------------  Export Macros ------------------------------*/
 
-#define MACvReceive1(iobase)						\
-do {									\
-	unsigned long dwData;						\
-	dwData = ioread32(iobase + MAC_REG_RXDMACTL1);			\
-	if (dwData & DMACTL_RUN)					\
-		iowrite32(DMACTL_WAKE, iobase + MAC_REG_RXDMACTL1);	\
-	else								\
-		iowrite32(DMACTL_RUN, iobase + MAC_REG_RXDMACTL1);	\
-} while (0)
-
 #define MACvTransmit0(iobase)						\
 do {									\
 	unsigned long dwData;						\
-- 
2.37.1

