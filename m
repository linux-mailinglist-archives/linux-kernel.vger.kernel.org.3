Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B98F582852
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jul 2022 16:15:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233427AbiG0OPF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jul 2022 10:15:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232982AbiG0OOx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jul 2022 10:14:53 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19B923ED52
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jul 2022 07:14:52 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id v13so16673791wru.12
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jul 2022 07:14:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=pgiicmFbHSV+cnHrXl1sGqeUiitZ3BsicQPNI51cCmM=;
        b=YcQ6nagqtnIjc6HP17wf717/xUNa8Xp8WAw8F1L6Czw7NPtkINekRK+7XcOMNxRKWo
         ob4cCRrfxGt+8EGc9CR9A/7e+YQ2+7jA9sc4sYe1QuZA5qyWk7fzjzAt2YP/m2FNxU4P
         mu2FYGreZNuicSOk7HQauit1IGFEk5dvQFlopho2X0NOwh6XhKyF6Cmoz8yq/9MnbX7+
         ukc4YRhAXh6jbo72lxdN57Wjv5/fcrpf9IXaVCnhOjidkjPwINKwG9o/rS05ZSi6ER9O
         HvpyoOHwLU/3ZPurk/JQ7TLTwXK3ZTSkS8fGT4+brzDFAbC1/pAOt49aDW36HjmIR3p7
         GE4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=pgiicmFbHSV+cnHrXl1sGqeUiitZ3BsicQPNI51cCmM=;
        b=xI37e9kSgR9MP+87DUTsse4sGBCM5t07opnlJs5mIWvQofYdtuHXhFm199uj1KwUPc
         KqXfxNxrln875IesCx3Y19Rf85/uJ2r0T1KZFOuV+i81Frti3owyGyAXJm6/8jwZypju
         9z8aHE+eki//w8vb9Dnkk6EKJutZU74StV+mT6CevakScmM95ZcVD55cyOyzEwteo78m
         GUZ+/ATwB73uGwwtKJlIOfKvAfBRf3HQvNBkS133yCCvFLS82IQC//zRgrj6WSoyGmsw
         tbNDS9FnuzC+Cxx6V8MHzjjJFW0uPYAXnw2hEnlffC20m3FJSpPtIzuuxEBRt+dEkItv
         U5cQ==
X-Gm-Message-State: AJIora/kpTZjUOjBKgGr64GLsWO8I4il0my1j5VvxxP4H+spRLBzaxDa
        cthuQQc/wlYOjpfPVP1z+CQZRQ==
X-Google-Smtp-Source: AGRyM1tTJYxDOoXCV28u1H4DSZIyhb/0aGX6VVOUkzgLCrsmdPKKoQZCEfiC4od2irWvsxe+iVGrWw==
X-Received: by 2002:a05:600c:4e44:b0:3a3:279b:30e4 with SMTP id e4-20020a05600c4e4400b003a3279b30e4mr3379879wmq.37.1658931290552;
        Wed, 27 Jul 2022 07:14:50 -0700 (PDT)
Received: from localhost.localdomain (210.145.15.109.rev.sfr.net. [109.15.145.210])
        by smtp.googlemail.com with ESMTPSA id o20-20020a05600c339400b0039c54bb28f2sm2489524wmp.36.2022.07.27.07.14.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Jul 2022 07:14:50 -0700 (PDT)
From:   Amjad Ouled-Ameur <aouledameur@baylibre.com>
To:     jan.kiszka@siemens.com
Cc:     linux-kernel@vger.kernel.org, narmstrong@baylibre.com,
        kbingham@kernel.org, Amjad Ouled-Ameur <aouledameur@baylibre.com>
Subject: [PATCH 3/3] scripts/gdb: timerlist: convert int chunks to str
Date:   Wed, 27 Jul 2022 16:14:43 +0200
Message-Id: <20220727141443.133094-4-aouledameur@baylibre.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220727141443.133094-1-aouledameur@baylibre.com>
References: <20220727141443.133094-1-aouledameur@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

join() expects strings but integers are given.

Convert chunks list to strings before passing it to join()

Signed-off-by: Amjad Ouled-Ameur <aouledameur@baylibre.com>
---
 scripts/gdb/linux/timerlist.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/gdb/linux/timerlist.py b/scripts/gdb/linux/timerlist.py
index d16909f8df35..98bb9a239283 100644
--- a/scripts/gdb/linux/timerlist.py
+++ b/scripts/gdb/linux/timerlist.py
@@ -172,7 +172,7 @@ def pr_cpumask(mask):
     if 0 < extra <= 4:
         chunks[0] = chunks[0][0]  # Cut off the first 0
 
-    return "".join(chunks)
+    return "".join(str(chunks))
 
 
 class LxTimerList(gdb.Command):
-- 
2.37.1

