Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 740FB530BFD
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 11:04:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231579AbiEWIRF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 04:17:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231691AbiEWIRA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 04:17:00 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DECBC24BF4;
        Mon, 23 May 2022 01:16:56 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id oe17-20020a17090b395100b001df77d29587so16824553pjb.2;
        Mon, 23 May 2022 01:16:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ovuY8Nt++zJ1053SzkHGKiigzS6Y0jV40vG6yt+W1eI=;
        b=ZVjiyvO3qfxOX7tq+bEXO34TrQGvPMN7ovchF7PRGNt+OLzH/o0kfxCNYpEwVl8NIW
         15DdN2AyLyNOFWCaLpY1THfBGYOmaJa0y3TAxVMKjHJPOMtKzNql/AdEvQMDIYdOw7qh
         b0zaJoWQVVIxx/A64k7Xn6PL/0nqdWTYU7LUUIq/qCsDBw/6VEBjW62dqp72IuqJ/kCO
         qfvwWvvK7E+K0MykJqdgZwjTnDx0W0b3DKJOMYwflmSytPKzgQkLnzrvFM+/Hc4QNaCm
         hhGbU3uRmZAZxh/Urfwysqg2gUvsrriYMrUeah+qi+3NKnPE/vQft0dwrE+OVSF7jZ36
         Vmow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ovuY8Nt++zJ1053SzkHGKiigzS6Y0jV40vG6yt+W1eI=;
        b=cYnz0fWQJJkV9m+IlX36t7bnzf9mXjoxI31vLDvFYE6vKOrYQwGTNrek9wqzLh/RmV
         xOgd0LzAjCkaOboKUdKL6DMwGYrrjqDhkVw62IpDrEpBT+/KpclIC6WqH7j9Og+RKo69
         pWmyzYK50Md8d6qRF33XLAxUOMl4loaJgHd8UTL/+2/O52S1tIViAng5aSUtI1S/0jCd
         IRsxGqO1uKe1wYmIudeYcqWe1jlnkhmAVeQg3x+165w/p3avIupQxu7IHSnU0XxmlyNK
         1YdsLV5RsN841+HeLC4ok64ofKJl6Nfdg7818VYeqmlamBojjnG1GZBNPT8jWL6WC7J5
         Bm1g==
X-Gm-Message-State: AOAM5326Ieo6MgVcy+w/eul+HEB4jbAQdzXchM3QGn93hfW7Nt+14ihs
        t/F4NLevAboJKTmFK1HXegU=
X-Google-Smtp-Source: ABdhPJxBLsxmZzFyXz9mQJ/BBH+eCob19fTghQvjFNlg3BJ57mCS2VDFpIaOm7yetJygOphj8RYjNA==
X-Received: by 2002:a17:90b:1c12:b0:1df:d7e9:2edd with SMTP id oc18-20020a17090b1c1200b001dfd7e92eddmr23479751pjb.35.1653293816131;
        Mon, 23 May 2022 01:16:56 -0700 (PDT)
Received: from localhost.localdomain ([103.167.134.51])
        by smtp.gmail.com with ESMTPSA id 142-20020a621794000000b00518a9c82d28sm1134707pfx.21.2022.05.23.01.16.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 May 2022 01:16:55 -0700 (PDT)
From:   Genjian Zhang <zhanggenjian123@gmail.com>
X-Google-Original-From: Genjian Zhang <zhanggenjian@kylinos.cn>
To:     tsbogend@alpha.franken.de, maz@kernel.org, keescook@chromium.org,
        mark.rutland@arm.com, nathan@kernel.org, siyanteng01@gmail.com,
        yyuasa@linux.com, ralf@linux-mips.org
Cc:     linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
        huhai@kylinos.cn, k2ci <kernel-bot@kylinos.cn>
Subject: [PATCH] irq: mips: Export irq_err_count to modules
Date:   Mon, 23 May 2022 16:16:25 +0800
Message-Id: <20220523081625.2074527-1-zhanggenjian@kylinos.cn>
X-Mailer: git-send-email 2.25.1
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

From: huhai <huhai@kylinos.cn>

modpost complains once these drivers become modules.
  ERROR: modpost: "irq_err_count" [drivers/gpio/gpio-vr41xx.ko] undefined!

Fix it by export them when that symbol is =m.

Fixes: 27fdd325dace ("MIPS: Update VR41xx GPIO driver to use gpiolib")
Reported-by: k2ci <kernel-bot@kylinos.cn>
Signed-off-by: huhai <huhai@kylinos.cn>
---
 arch/mips/kernel/irq.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/mips/kernel/irq.c b/arch/mips/kernel/irq.c
index 5e11582fe308..b0038b715008 100644
--- a/arch/mips/kernel/irq.c
+++ b/arch/mips/kernel/irq.c
@@ -38,6 +38,9 @@ void ack_bad_irq(unsigned int irq)
 }
 
 atomic_t irq_err_count;
+#ifdef CONFIG_GPIO_VR41XX_MODULE
+EXPORT_SYMBOL_GPL(irq_err_count);
+#endif
 
 int arch_show_interrupts(struct seq_file *p, int prec)
 {
-- 
2.27.0

