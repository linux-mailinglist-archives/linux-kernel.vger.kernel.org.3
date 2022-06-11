Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92EDD5472C5
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Jun 2022 10:09:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231545AbiFKIJO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Jun 2022 04:09:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229661AbiFKIJM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Jun 2022 04:09:12 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5538255A5
        for <linux-kernel@vger.kernel.org>; Sat, 11 Jun 2022 01:09:11 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id f8so1064380plo.9
        for <linux-kernel@vger.kernel.org>; Sat, 11 Jun 2022 01:09:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/1LvpVCwoMjQ4GHgdo6SEb9cA+cNoWEGxjfe3uUOYS0=;
        b=mzP4XvuJ28oxNoPHs5SCRoPybYgIgKtkqjtNDKwcPUI4koqh8x6njuDHmO9Tu1E8mk
         ktFs4YldkEIPbLAG0/w3orCA1ccjbzdbHIZKtnaJB9kIBSy6EEggbkhAsIIlBtH3zdTZ
         kDtW3fUZXUyKudRgquBdjCLBjpI1qgKODMpwJ8OR5y0w+1nm5elkA4CA0rYOfjpb7NXR
         83Yt9OpUJRSoNdjriDc447i5unubf7OcZ6i7lWg5WLCNhKYDNcRrLOxnzjfbo3nZ6qf2
         FJ28GPrRH0E6SNPPNxBHXREMDPEhfPpcaaLQUNXeI7CKWVc1UGtM9eCeRo6RX96KVpEE
         a8DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/1LvpVCwoMjQ4GHgdo6SEb9cA+cNoWEGxjfe3uUOYS0=;
        b=klQ8wQwa/8EjidkMfnaeOiwghF4TV1n45n7+lUSjaqKEtvh1Gy6jmctDRef2eKiTHe
         gjp8cXYA6p1xtFQK1lngQle1zVwfIkxh2NlQ0ddhkCTzSyPuCfheeEpsIZUsq5upQL4z
         qyt9OhOzNs812TZwJVbL2ZujZG3PaZGZyaoXRmYOD5GTEf9IDCmg4l4Zgh304gpHqw3p
         bPwDlpdX4suvOv7sGKnF5WYKSWvyRw2TT2DxmJLI0MqiskV5mUnI2bWQ7VkAwS2J6CJ/
         w6rBCAArup15rsL2CyusHr7M1wY3aFhSkfqDJy75h3OeG3OrvqIVq4t6YU3ppI9Zktde
         zmOg==
X-Gm-Message-State: AOAM530xe2PC4MeAYKSD6WminpLpDXcVwYmrpJbtw16R3SwEELaOOzjn
        UkjarlxwYbzxDoX2dCmq65uYRh7phE8UZQ==
X-Google-Smtp-Source: ABdhPJynEWC2B9PcNZCxAAHQ8EbVX/U9IhfUnvhvvE0LKddC7ET+zm2QRfJPVpq+DJLBh/9uewyCNQ==
X-Received: by 2002:a17:903:2c1:b0:158:f9d0:839c with SMTP id s1-20020a17090302c100b00158f9d0839cmr47937568plk.118.1654934950785;
        Sat, 11 Jun 2022 01:09:10 -0700 (PDT)
Received: from localhost.localdomain ([139.177.225.240])
        by smtp.gmail.com with ESMTPSA id q3-20020a170902edc300b00161ac982b52sm970914plk.95.2022.06.11.01.09.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Jun 2022 01:09:10 -0700 (PDT)
From:   wuchi <wuchi.zero@gmail.com>
To:     bhutchings@solarflare.com, decot@googlers.com, info@metux.net,
        josh@joshtriplett.org
Cc:     akpm@linux-foundation.org, linux-kernel@vger.kernel.org
Subject: [PATCH] lib/cpu_rmap: do *_get before using cpu_rmap
Date:   Sat, 11 Jun 2022 16:09:04 +0800
Message-Id: <20220611080904.92120-1-wuchi.zero@gmail.com>
X-Mailer: git-send-email 2.32.0 (Apple Git-132)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It's ok in irq_cpu_rmap_add:

glue->rmap = rmap;
cpu_rmap_get(rmap);

however, it's logically better to do *_get before passing the var..

Signed-off-by: wuchi <wuchi.zero@gmail.com>
---
 lib/cpu_rmap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/cpu_rmap.c b/lib/cpu_rmap.c
index f08d9c56f712..590eb544f0d8 100644
--- a/lib/cpu_rmap.c
+++ b/lib/cpu_rmap.c
@@ -291,8 +291,8 @@ int irq_cpu_rmap_add(struct cpu_rmap *rmap, int irq)
 		return -ENOMEM;
 	glue->notify.notify = irq_cpu_rmap_notify;
 	glue->notify.release = irq_cpu_rmap_release;
-	glue->rmap = rmap;
 	cpu_rmap_get(rmap);
+	glue->rmap = rmap;
 	glue->index = cpu_rmap_add(rmap, glue);
 	rc = irq_set_affinity_notifier(irq, &glue->notify);
 	if (rc) {
-- 
2.20.1

