Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20F77504FAB
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Apr 2022 14:02:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237960AbiDRMFb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 08:05:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231693AbiDRMF1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 08:05:27 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6CB913D3C
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 05:02:48 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id h15-20020a17090a054f00b001cb7cd2b11dso13854035pjf.5
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 05:02:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pHmIfYdFlbEBfg1s7Ca3bU++BraBxET9LrYHIdIzDOw=;
        b=QXDWG5IlrTI1SdTC2t0iJGNjYcOeHl6dU8afA0mPcO0Or+oRWHHlgJ1uRhLd4evU2I
         W5FnM/xeJ4CEyFyqIyGl6RPDQuIgBK8IX3vaQg+woyVXiRJLmLPzc/MMQxkCbDyp+J5C
         KzVgP0q4TD8uaq/vuJGd9gtT0/VjozlwEW52z2J6ISvZ+0eIGyGRpwpsp8lZ6wEEKhGE
         P93idKHTGXZ14lA6TBTim/g+AY/yJXmnroEE3sgC7icduU77CV+GjeB2nS2ueVgPToed
         S4yarTAJPnC3dx9LS3eNG/ZBES560RulN33Pu5aWLesongYn036mb1UpWexUM6xq2bPi
         UaOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pHmIfYdFlbEBfg1s7Ca3bU++BraBxET9LrYHIdIzDOw=;
        b=jgwW7zC14WRGkqZWyyhMAVk/IyDbQJGT+SNkHUyjJFO8AvSE4WmtqLyuiiUZq8dHEV
         3koRPkOhzl5yXVOaT9BsKNsFnALSOLEldRPawF+q4ytvFFOlSVfHkDIVkf0AtXJ/SasT
         5sBSk9zNhJA9h6BvQ6cj9np19ZhSJiURGo4ltTyMZvVTjwpCPipvAMGUQcEikpS4/U89
         q6EQS+pDN/oUMp3PG7hzfWVgbouY5TDC12U9pTQPoe1hiEXan2zXJNo3MdumzcEN31AI
         KCn+JODjCV6ulQELYhCMvFOr9M4w6J8RAX+gw6JIfJgF7M2zHy+lyNpn3t3GtsnXahFf
         ydQQ==
X-Gm-Message-State: AOAM530l8B5POa30qT2zTYEKPja8RW4dK7DPgAU6IArcs6yYnR2Bj8pQ
        zPpC0F7Iedze6dL8ZboJIkg=
X-Google-Smtp-Source: ABdhPJyjaCRepIeQD49ER6XVhKfz5eniRdQHa7nbQuAOV/clAl/1UqGDDXpDHluB+6BttoCRcq5+Tg==
X-Received: by 2002:a17:90b:1c88:b0:1b8:a77e:c9cb with SMTP id oo8-20020a17090b1c8800b001b8a77ec9cbmr17837755pjb.205.1650283368262;
        Mon, 18 Apr 2022 05:02:48 -0700 (PDT)
Received: from aliyar-HP-Laptop-15-da1xxx.domain.name ([14.139.241.88])
        by smtp.gmail.com with ESMTPSA id p1-20020a17090a680100b001d28905b214sm3840628pjj.39.2022.04.18.05.02.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Apr 2022 05:02:47 -0700 (PDT)
From:   Aliya Rahmani <aliyarahmani786@gmail.com>
To:     clabbe@baylibre.com
Cc:     gregkh@linuxfoundation.org, linux-staging@lists.linux.dev,
        outreachy@lists.linux.dev, linux-kernel@vger.kernel.org,
        Aliya Rahmani <aliyarahmani786@gmail.com>
Subject: [PATCH 1/3] staging: media: zoran: use seq_puts() instead of seq_printf()
Date:   Mon, 18 Apr 2022 17:29:48 +0530
Message-Id: <20220418115948.5456-2-aliyarahmani786@gmail.com>
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

Replace seq_printf() with seq_puts() for a constant format without
additional arguments, reported by checkpatch.

Signed-off-by: Aliya Rahmani <aliyarahmani786@gmail.com>
---
 drivers/staging/media/zoran/videocodec.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/media/zoran/videocodec.c b/drivers/staging/media/zoran/videocodec.c
index 3af7d02bd910..16a1f23a7f19 100644
--- a/drivers/staging/media/zoran/videocodec.c
+++ b/drivers/staging/media/zoran/videocodec.c
@@ -250,8 +250,8 @@ int videocodec_debugfs_show(struct seq_file *m)
 	struct codec_list *h = codeclist_top;
 	struct attached_list *a;
 
-	seq_printf(m, "<S>lave or attached <M>aster name  type flags    magic    ");
-	seq_printf(m, "(connected as)\n");
+	seq_puts(m, "<S>lave or attached <M>aster name  type flags    magic    ");
+	seq_puts(m, "(connected as)\n");

-- 
2.25.1

