Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00D4E55DB57
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:24:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233387AbiF0K3r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 06:29:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232862AbiF0K3q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 06:29:46 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32101266B
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 03:29:46 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id g4so1804501pgc.1
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 03:29:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=v3Ue/YqhI3wZIXhjzUhJiR88+uLRCHqFYS5gNvpHTOg=;
        b=eMNLJG1TZA5X1Hp1kTF1W/tSAJ/fkP4eDfHsHZdcugxv6+Ycl3CqTb8s/RQ2rwMlma
         yDNRn40ej6TeEe698MxZZPrjUmT317zCp5mqCAqsqGht9u6XT3w2c3rl3P+KOyKqEj+U
         ABFWorvaud+H6/+BhsBqpe/D9KWqwQUUV2Qa1xu6XTl2Vde7/rszBKJTmuG3CJXtA0Tg
         t4KUifUZzS9WHXInqkzjgwFQsimWUjmkeJeSYLybhi0y3EYRCII+jPsEinDhv25LquPZ
         Bzy4Y8M7v/xAifQ/c3snWP5W1FTK8zx9maJ0TgcppMj2y3D9ijhP9xTlOv/q/aPvCtDf
         EZiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=v3Ue/YqhI3wZIXhjzUhJiR88+uLRCHqFYS5gNvpHTOg=;
        b=xxx36RN9quW4HvOkMi3pk2vRZQ3/kBzIm8FZVNjgdQFNkPaBUs315dKFCTkoaURRHQ
         U76gH2F/QtQdUDOXc3UcOvNrdxlTmATTA1B/5r7BpZToWaTrlYDk2l1aYEn4FclPn0yV
         UBGU7vdamko+Q9uCszDv3ygynvhUJIiGMBNWb2EjDtZsHaefJhq4nE0Fh0m93gRsdqCK
         M2J73GP/j7z5NXq6NeQOZKafBTTj1pGI3YKOp2DhwjvqbvkdKwKWO8Ny8n4OFPNi9Gk8
         MLKjP6x0DFGczU7fNN99qDN23oUT88h6WDqa9skaqgLivzCJQWAfP8yH8LgVxoiXVqvO
         mnTg==
X-Gm-Message-State: AJIora/HeefqWbLszlWPDNa7TRqJy1UeJqluIjaAXnn9zApAq8JeBQ5Z
        yxwvYX9ZBgzhgP/Gy9x/Sky7NPvpFYAK7VfNlcg=
X-Google-Smtp-Source: AGRyM1shR2SPrnGHr9WEZTkI49qfGmMxocbXq29oboYiLhEo69thaGxiZwHMm+I8QJytWCPmgRa4bQ==
X-Received: by 2002:a05:6a00:22d6:b0:525:74b3:d020 with SMTP id f22-20020a056a0022d600b0052574b3d020mr13738014pfj.80.1656325785719;
        Mon, 27 Jun 2022 03:29:45 -0700 (PDT)
Received: from desktop-hypoxic.kamiya.io ([42.120.103.58])
        by smtp.gmail.com with ESMTPSA id jj4-20020a170903048400b0016a2b68823esm6819598plb.141.2022.06.27.03.29.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jun 2022 03:29:45 -0700 (PDT)
From:   Yangxi Xiang <xyangxi5@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Johan Hovold <johan@kernel.org>,
        Igor Matheus Andrade Torrente <igormtorrente@gmail.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        nick black <dankamongmen@gmail.com>,
        Yangxi Xiang <xyangxi5@gmail.com>
Subject: [PATCH] vt: fix memory overlapping when deleting chars in the buffer
Date:   Mon, 27 Jun 2022 18:29:40 +0800
Message-Id: <20220627102940.23232-1-xyangxi5@gmail.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A memory overlapping copy occurs when deleting a long line. Fix it by
using scr_memmovew.

Signed-off-by: Yangxi Xiang <xyangxi5@gmail.com>
---
 drivers/tty/vt/vt.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/vt/vt.c b/drivers/tty/vt/vt.c
index f8c87c4d7399..d87bff9d8ed5 100644
--- a/drivers/tty/vt/vt.c
+++ b/drivers/tty/vt/vt.c
@@ -853,9 +853,13 @@ static void insert_char(struct vc_data *vc, unsigned int nr)
 static void delete_char(struct vc_data *vc, unsigned int nr)
 {
 	unsigned short *p = (unsigned short *) vc->vc_pos;
+	unsigned short cp = (vc->vc_cols - vc->state.x - nr) * 2;
 
 	vc_uniscr_delete(vc, nr);
-	scr_memcpyw(p, p + nr, (vc->vc_cols - vc->state.x - nr) * 2);
+	if (cp > nr)
+		scr_memmovew(p, p + nr, cp);
+	else
+		scr_memcpyw(p, p + nr, cp);
 	scr_memsetw(p + vc->vc_cols - vc->state.x - nr, vc->vc_video_erase_char,
 			nr * 2);
 	vc->vc_need_wrap = 0;
-- 
2.17.1

