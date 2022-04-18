Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4E42505D77
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Apr 2022 19:22:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346983AbiDRRYi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 13:24:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242820AbiDRRYe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 13:24:34 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8516731539
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 10:21:55 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id bg24so13528574pjb.1
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 10:21:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Fogjq+0iPdBZBMK4jYk682UP+pZNG32fCLfhwIfhhXE=;
        b=eNsdqSr4O0QCRIf4YJ6R7gSwH2ItG46kuqFE3YxpMmutZ5ERKfeckih7AFfsT7fdCL
         CFAE+T+u5I+MrrH1+y7jkDyWp7pkiPj0FfQISV3uD6Zm6uG06OvHNLmOfKtPT1HPKnVm
         xGK92DPetlM3mJFlh8cRBNSlHxiRnu2sWgKzniZSLjAx40SS+sbb/5zpAEyVzZkBIYlO
         LoEcYR5DhSxXg9cwd+lOtsnfAhDou4odz+CsP/CjzG7jps3uU6zBMSjXvdcOFKvoyMBv
         i+1u13PZQi8MB9klWrGMnkLy5fOhJy7dULdJkVuGuhFDsIbfaLv3+9DDSSy2CWJDmqGL
         CAZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Fogjq+0iPdBZBMK4jYk682UP+pZNG32fCLfhwIfhhXE=;
        b=XnUn9Q58TgZ2GpLxMel2BFCy+yOHRniJNOGwjvw/9R7mkPwiXuvfrvAZolLoeNLOZ8
         kQsjLCL5gO3SCNxAl4H+X3YnL8Wg78A5NLOdO0C88UafFn1ishHFOJ+IoEP7O6Z8NDJc
         O+dk+928jxrJ1f+x7IqsehjnXUGSGhrX/HZu2wJ0lQALHfbh+w84Ir7XJCLLS2OA7Hh7
         kDHJeLVEJIAq4jsFncC2dYTsgTNtOj8i1uDhgZwr719ZtDKWZ0aL7WXLmr3raa3ICjoM
         K6y83qWm5SyzZjMiDJidHXIdOppx/zRe83XNT8NIFt1rW5W/owTIuGa86dfG4dBRhIl+
         lPzA==
X-Gm-Message-State: AOAM5305eZ+3gRofko9twtODGuHvhHtfw61PEcIS9yvuSLs3fZCDACE0
        YwTBTxEDouqDzXrWwngEdAQ=
X-Google-Smtp-Source: ABdhPJwDJ0uJVfx2QrwbcFNBAgeqo9mTsjaUibpHBycw03Lj63qCZLrmvZN41QlydRogKqV/3XUqQA==
X-Received: by 2002:a17:90b:1a8a:b0:1c7:c60b:f12 with SMTP id ng10-20020a17090b1a8a00b001c7c60b0f12mr13992859pjb.139.1650302514956;
        Mon, 18 Apr 2022 10:21:54 -0700 (PDT)
Received: from aliyar-HP-Laptop-15-da1xxx.domain.name ([14.139.241.88])
        by smtp.gmail.com with ESMTPSA id y9-20020aa78f29000000b005098201d2f5sm13041394pfr.205.2022.04.18.10.21.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Apr 2022 10:21:54 -0700 (PDT)
From:   Aliya Rahmani <aliyarahmani786@gmail.com>
To:     clabbe@baylibre.com
Cc:     gregkh@linuxfoundation.org, linux-staging@lists.linux.dev,
        outreachy@lists.linux.dev, linux-kernel@vger.kernel.org,
        Aliya Rahmani <aliyarahmani786@gmail.com>
Subject: [PATCH v3 1/3] staging: media: zoran: use seq_puts() instead of seq_printf()
Date:   Mon, 18 Apr 2022 22:44:52 +0530
Message-Id: <20220418171453.16971-2-aliyarahmani786@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220418171453.16971-1-aliyarahmani786@gmail.com>
References: <20220418171453.16971-1-aliyarahmani786@gmail.com>
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

