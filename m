Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDCAB547E91
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 06:25:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231551AbiFMEZz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 00:25:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229638AbiFMEZn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 00:25:43 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18813CE8
        for <linux-kernel@vger.kernel.org>; Sun, 12 Jun 2022 21:25:42 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id e24so4607573pjt.0
        for <linux-kernel@vger.kernel.org>; Sun, 12 Jun 2022 21:25:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=UJqqtLpsUI2pT8V/J8QM9a7rYqlcj52+1o8fnW9am6M=;
        b=He812w1u3b5Dd74KtEchC1TIzSGg5kClkXcShWEeGsfHAytYBzY5I+6AY7FqtUd6w/
         y1mgEQiDAJVqsG+QpdRShDqonwebndEmRqiqbHw0SWXzmvKrnFVeKTvoU5Psmmvbk5+J
         f/gdnibNG1cPge9uJ40GWZCYtEqKkNdTwo3XXf9pBrKHpKn6fPKJzFc6NYUiTekBLn0j
         tEdiH+dbhZGDZWcBO6DS0Ad/rSoe/RCjVhDlYOPQUNo236u+7JlZdIe3SHp/WO/MXzzy
         /qNvKVlrKFLedFrUuwVs2ugwiKDRHPIbEo4DLvXj9HpP1w62ZCFJimj7l5+AV9N+gggS
         E+BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=UJqqtLpsUI2pT8V/J8QM9a7rYqlcj52+1o8fnW9am6M=;
        b=jW3bd/ML+Hf2I4Xl/+Cq4pCM3x0vVWZeg56VE+WvnAbMFzyTFQ2wKBK/VX3gsdj2iJ
         Axl8tHeNWT0Jb6vvonsSuFiU85l6su56YQH5nt2E2KGKhp23ObmdLvssE/aVNLWnwwWO
         dZd+krvg5KpXN/TsXRErKy6u77Mh5lxteTW9nsetmOCFy4G/IzII0EWe8ZikHOeCQxu6
         gu7WDFCz9n3dvZISEpxj4kAUbwLptoObRLxj2OrdtR2wkItlpNDC1Kq9Ls15qP6V6Cmt
         FbL7Olgzdl1QTst6FTTnbGEib+Nv/HFXh+Pkrpv+ck1h22+7QDib1m2XlWBiyHfurBDL
         2cew==
X-Gm-Message-State: AOAM530hSlyw0SpY8NZ84e3LXDX7ugxUdZY2Ca1f8fONudepJb3yS9z2
        3u9yeCntSJhDV8CUKO4NFgI=
X-Google-Smtp-Source: ABdhPJylwmTgv3qIMrAGkTiS9qCSUJUC8S7LvwQsbNxfneogBdy+AJDtg7D1yR1mGEIx+5udNY99oA==
X-Received: by 2002:a17:90a:df14:b0:1e3:33ba:a94 with SMTP id gp20-20020a17090adf1400b001e333ba0a94mr13468317pjb.83.1655094341541;
        Sun, 12 Jun 2022 21:25:41 -0700 (PDT)
Received: from localhost.localdomain (l3b2w1.cn. [159.138.1.25])
        by smtp.gmail.com with ESMTPSA id bf10-20020a170902b90a00b001664ce47e11sm3848260plb.210.2022.06.12.21.25.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Jun 2022 21:25:40 -0700 (PDT)
From:   l3b2w1@gmail.com
To:     mhiramat@kernel.org
Cc:     naveen.n.rao@linux.ibm.com, anil.s.keshavamurthy@intel.com,
        davem@davemloft.net, linux-kernel@vger.kernel.org,
        "binglei.wang" <l3b2w1@gmail.com>
Subject: [PATCH] kprobes: drop the unnecessary unlikely()
Date:   Mon, 13 Jun 2022 12:25:36 +0800
Message-Id: <20220613042536.20329-1-l3b2w1@gmail.com>
X-Mailer: git-send-email 2.27.0
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

From: "binglei.wang" <l3b2w1@gmail.com>

!ap is likely when checking re-registering existing kprobe.
	register_kprobe -> warn_kprobe_rereg -> __get_valid_kprobe

!ap is unlikely when checking whether the kprobe is valid
on enable/disable ocassion.
	__disable_kprobe/enable_kprobe -> __get_valid_kprobe

Considering these two cases, choose to drop the unlikely() here.

Signed-off-by: binglei.wang <l3b2w1@gmail.com>
---
 kernel/kprobes.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/kprobes.c b/kernel/kprobes.c
index f214f8c08..f4a829d98 100644
--- a/kernel/kprobes.c
+++ b/kernel/kprobes.c
@@ -1504,7 +1504,7 @@ static struct kprobe *__get_valid_kprobe(struct kprobe *p)
 	lockdep_assert_held(&kprobe_mutex);
 
 	ap = get_kprobe(p->addr);
-	if (unlikely(!ap))
+	if (!ap)
 		return NULL;
 
 	if (p != ap) {
-- 
2.27.0

