Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7477F504FB2
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Apr 2022 14:04:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237982AbiDRMHG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 08:07:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237980AbiDRMHB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 08:07:01 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4933B1A802
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 05:04:23 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id z6-20020a17090a398600b001cb9fca3210so13892960pjb.1
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 05:04:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=l539e+cloHDtMJA9q+CEgCemouxdeXvEIx3a6xENmiw=;
        b=EME2rXuHZN/iDCQ2+/fD2SnBtcWDY/WxEDU7zV371DULgDSxAkHyqIHk2HsT9pzYwq
         X0jHxUfQBFj9UbfsPHqd5q6wAhE84cWLfeeR84Dp7k0+QIVeRMQY+B+Aiusixji2MZG2
         ifwV6vhzgL5s5XDlv14p3JgMD+dfhdrtGG2ExdeaqSrKkXm5Ivd/5dMRW7F+tu/ZFwWL
         /WwRqSCNYjFeDgdsPPIuvc0L1BcoHGgxV/4uQAyt138812M31T3nP2qmLeor7vPaz7uH
         KnG4Stv+RmjZ8soo1W61p7OiNnozgmmTtN6ORA2jETC6mtk/2TsMF7NefT1qCxwcdhkp
         6CYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=l539e+cloHDtMJA9q+CEgCemouxdeXvEIx3a6xENmiw=;
        b=sDDrBXQPRcR6CRge18hW+kKj+6H2c6RE9zSodTxgdhbI8iD4ekx0/0WxYuVFPf6bmP
         OBHCrgxSq0yUvQ9RaDhaeRZ5cZhE+khNhav8IkY9QRzlG2KVWChi8LYpnyIsnwl8Q9kH
         eKnssQK0OnrcLRy1DIEUkGZCEenPA6PwRKLIok97IiVUde8iBd9HBh/m7p1NU1GvlKj+
         cZ7v3hbie0qCdXWGR8MUCtY7GZiYZpvOmkuRznHBFuLgMV9jN//9iPxW63crJtl6PGsg
         vohhE+MMtPB7YXQWrePGxUSuYWvGLb+zXxS2l3Vf+njg/7wr0j6fS9Gt/XohS7wtagwK
         ajkw==
X-Gm-Message-State: AOAM533LIgU4s4Ra8PqVuxcGcf2xlVvAtuUAPS35oTnrRRyGra6xa/eW
        s2ZHdhENgetpqHw4nZTokdQ=
X-Google-Smtp-Source: ABdhPJz5tpVjRVY7oW3rrsbG8qVY4KsncSBVc/mgVKR/4pTyMQpqlw0yWDuainxpF/jrj6yIKwpaMg==
X-Received: by 2002:a17:90a:4403:b0:1ca:a4a3:6824 with SMTP id s3-20020a17090a440300b001caa4a36824mr12603150pjg.20.1650283462701;
        Mon, 18 Apr 2022 05:04:22 -0700 (PDT)
Received: from aliyar-HP-Laptop-15-da1xxx.domain.name ([14.139.241.88])
        by smtp.gmail.com with ESMTPSA id p1-20020a17090a680100b001d28905b214sm3840628pjj.39.2022.04.18.05.04.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Apr 2022 05:04:22 -0700 (PDT)
From:   Aliya Rahmani <aliyarahmani786@gmail.com>
To:     clabbe@baylibre.com
Cc:     gregkh@linuxfoundation.org, linux-staging@lists.linux.dev,
        outreachy@lists.linux.dev, linux-kernel@vger.kernel.org,
        Aliya Rahmani <aliyarahmani786@gmail.com>
Subject: [PATCH 3/3] staging: media: zoran: avoid macro argument precedence issues
Date:   Mon, 18 Apr 2022 17:29:52 +0530
Message-Id: <20220418115948.5456-4-aliyarahmani786@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220418115948.5456-1-aliyarahmani786@gmail.com>
References: <20220418115948.5456-1-aliyarahmani786@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes checkpatch warnings of precedence issues. Added parentheses
around macro argument 'num'.

Signed-off-by: Aliya Rahmani <aliyarahmani786@gmail.com>
---
 drivers/staging/media/zoran/videocodec.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/media/zoran/videocodec.c b/drivers/staging/media/zoran/videocodec.c
index 19732a47c8bd..925f90fd5885 100644
--- a/drivers/staging/media/zoran/videocodec.c
+++ b/drivers/staging/media/zoran/videocodec.c
@@ -22,7 +22,7 @@ MODULE_PARM_DESC(videocodec_debug, "Debug level (0-4)");
 
 #define dprintk(num, format, args...) \
 	do { \
-		if (videocodec_debug >= num) \
+		if (videocodec_debug >= (num)) \
 			printk(format, ##args); \
 	} while (0)
 
-- 
2.25.1

