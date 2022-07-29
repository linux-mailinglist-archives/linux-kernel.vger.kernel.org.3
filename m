Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 636B5584D42
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jul 2022 10:15:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235585AbiG2IPG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jul 2022 04:15:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235601AbiG2IOw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jul 2022 04:14:52 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55BA8820FA
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jul 2022 01:14:50 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id va17so7328040ejb.0
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jul 2022 01:14:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=o4vW0UYou3fHkj8i9Q3MbAUiW6l95nNxKH7RBWOhBEI=;
        b=lM41+MOeWZIf+vIEDgI8G7YilKe6uV5Zid5DRANx70RDlgn0OB//yD/7Kp2VTM7fQv
         XmDkmzk4SuUHVxipxh31weWXMm5GCRoXOZhHxptSv8tnZA3qqiRZtFG8TGrjJy+JZeUe
         KpgtlZgDQMkY6YWrpTzQzbYiFJz7OR0sP7Tq8JeW3R11Hbp8ccdq3IgIkVQDqa9i91vP
         JMnI4yYlSNcKfqV5G8wN6/MeOVfxBLp6xkuBpmmaZOay/1uz8CYDV/ARJwmA3TVnJ8qh
         NUbhgbbrGU5KmGaXdmR+pG881h1KkGjc9egMVxo033NqaL3sLJm1MlRKeO7vb1bNOj0I
         8unQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=o4vW0UYou3fHkj8i9Q3MbAUiW6l95nNxKH7RBWOhBEI=;
        b=w3Eo3q4spbYtLg9S7JRqaWnkIQ0gvttXE8UsDjPn7xwmhA3qwk/sZksfgmFIwIv1Pd
         jRwm1uGhtAgQyg1Zvvmna1KglN9bte6gHSYqaGKvsLWqm611e6ECOLmsLn9mFvAhvY7i
         V3cgOE0F3jeXU8T4RRi1GHoERdcgoF1j9plA4K6MHu2m4n1m9kan7qSA89S2tqdsVA0U
         FQPVN2dp8WO7vmwlgGGHwEQB+oaV+f5VMkIvI6+ykg1hbW+vCBZl5SGx/9K1xh4Qvv5g
         eCcBeiMpbKRQkx1G+PgxGUn6Mvr5UKh6nBx+t9ms2cAP0xTP1+xnsflIiHaSLxWvlJp5
         Nvkw==
X-Gm-Message-State: AJIora+e+SkepfDt8m3hDfkLfpbyntH3AuH8tINo2zW0E1n3j+b0J9vQ
        SmvUjcMuxI8pMD1OYg047yI=
X-Google-Smtp-Source: AGRyM1sDnGUVNtE6Vg/PEwO4s6uCfhUYlEE65SUIGxzr2DtcT6sswobLgFBi51+WLA2N8xrk6S/bEg==
X-Received: by 2002:a17:907:d1f:b0:72f:5d89:d08 with SMTP id gn31-20020a1709070d1f00b0072f5d890d08mr2037896ejc.231.1659082488852;
        Fri, 29 Jul 2022 01:14:48 -0700 (PDT)
Received: from matrix-ESPRIMO-P710 (p54a07b82.dip0.t-ipconnect.de. [84.160.123.130])
        by smtp.gmail.com with ESMTPSA id ku24-20020a170907789800b006fed062c68esm1369857ejc.182.2022.07.29.01.14.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Jul 2022 01:14:48 -0700 (PDT)
Date:   Fri, 29 Jul 2022 10:14:46 +0200
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Forest Bond <forest@alittletooquiet.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH v2 4/5] staging: vt6655: Replace MACvTransmit0 with function
 vt6655_mac_dma_ctl
Message-ID: <fc412f0fda11045a55b6b5867d51e250ca841ee8.1659080988.git.philipp.g.hortmann@gmail.com>
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

Convert macro MACvTransmit0 to existing static function. This saves
codelines and multiline macros are not liked by kernel community.

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
V1 -> V2: Improved description
---
 drivers/staging/vt6655/device_main.c |  2 +-
 drivers/staging/vt6655/mac.h         | 10 ----------
 2 files changed, 1 insertion(+), 11 deletions(-)

diff --git a/drivers/staging/vt6655/device_main.c b/drivers/staging/vt6655/device_main.c
index 554531411dad..c0a00063e4d1 100644
--- a/drivers/staging/vt6655/device_main.c
+++ b/drivers/staging/vt6655/device_main.c
@@ -1231,7 +1231,7 @@ static int vnt_tx_packet(struct vnt_private *priv, struct sk_buff *skb)
 	if (head_td->td_info->flags & TD_FLAGS_NETIF_SKB)
 		MACvTransmitAC0(priv->port_offset);
 	else
-		MACvTransmit0(priv->port_offset);
+		vt6655_mac_dma_ctl(priv->port_offset, MAC_REG_TXDMACTL0);
 
 	priv->iTDUsed[dma_idx]++;
 
diff --git a/drivers/staging/vt6655/mac.h b/drivers/staging/vt6655/mac.h
index 5a473ca393f2..be33da59dd84 100644
--- a/drivers/staging/vt6655/mac.h
+++ b/drivers/staging/vt6655/mac.h
@@ -537,16 +537,6 @@
 
 /*---------------------  Export Macros ------------------------------*/
 
-#define MACvTransmit0(iobase)						\
-do {									\
-	unsigned long dwData;						\
-	dwData = ioread32(iobase + MAC_REG_TXDMACTL0);			\
-	if (dwData & DMACTL_RUN)					\
-		iowrite32(DMACTL_WAKE, iobase + MAC_REG_TXDMACTL0);	\
-	else								\
-		iowrite32(DMACTL_RUN, iobase + MAC_REG_TXDMACTL0);	\
-} while (0)
-
 #define MACvTransmitAC0(iobase)					\
 do {									\
 	unsigned long dwData;						\
-- 
2.37.1

