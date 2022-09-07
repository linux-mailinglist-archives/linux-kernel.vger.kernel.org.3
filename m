Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60FAA5AFFA2
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 10:52:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230164AbiIGIw1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 04:52:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229965AbiIGIwY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 04:52:24 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 259599080E
        for <linux-kernel@vger.kernel.org>; Wed,  7 Sep 2022 01:52:24 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id d12so13833262plr.6
        for <linux-kernel@vger.kernel.org>; Wed, 07 Sep 2022 01:52:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=5MKBlI+RBVCqXryOhaTcObgn3fBJHX07A1bEvczIdVQ=;
        b=VZZ1ecUOLjPlqXPXuvqXDKL7FK3Yma4laTZW4+YVpL0DKXSY6E4eY9U61t4QIQtnYV
         44iybslnnMQ+JzOwSrqaGbikRJs69Hz47vTk2qCQikh3amAFRxOl51qhUb5lYPjKigev
         l6n3H3Gz0AKBZ558y1d+HRLt+mPclWe9q4+HrZC+nZIkWDnL6cadSFdFAZQyvvKMz61S
         1AGA8y31x0qG86FDQ2NoG1cfp1btmjq9P7a/YStyVS87ZH8n+js/XJS+Y/uLumiXJ4rl
         iTl8UzM5pVFmI3BMuAZBP3bHweQ0C9jEXOE68Q09u4OLfsrt2g9X8nvuImXswzcoszZg
         1QlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=5MKBlI+RBVCqXryOhaTcObgn3fBJHX07A1bEvczIdVQ=;
        b=dIlTt9nu1PgA2dhvmVhnBIRM35Vn2Z+05EYggnjckjWzJ4ZjzuxS9p+e8Sw/p8KhRl
         hzNp97mvAMcqo0u58PeN4AIhzZol0u0LEl6cq8sJj5C/cZOHrDriZQucUApTHUj4KCc7
         QbjtVA+cXrNCz84GhDHRJQ172JV/UyrFNgJw5IJIAidjqCrtSzsxu59xSm1SobNqc9+D
         D9TJ4Ub5iIVZeT7YYZUm7DLptvte8ficY5agp1pD/piF/2FMyEYAqKYehAbVl/58SU/E
         JyL1Ice4ILtF6Sw5TZdaNgeQmeDtaYWbvkCXsEUkBwniuvFJqqQPIyeFRGSJ2FNmSZar
         /RMQ==
X-Gm-Message-State: ACgBeo2ZqBmxM9wXWtxea/XRY3uh48cla97Rk7LzkTzNgCXGLzFgqLuC
        51Wpp7b3w/099r4sv0hsgS9YtT19glJU7w==
X-Google-Smtp-Source: AA6agR7nRcLpCoVFfyGi/wm48uGkRkZV+S0nQaMsjVTeea06sDjM9vdQsddHVqV8YxGi+LwUNLu17w==
X-Received: by 2002:a17:90b:1a8c:b0:1fe:2c68:6ad9 with SMTP id ng12-20020a17090b1a8c00b001fe2c686ad9mr2900772pjb.224.1662540743434;
        Wed, 07 Sep 2022 01:52:23 -0700 (PDT)
Received: from localhost.localdomain (lily-optiplex-3070.dynamic.ucsd.edu. [2607:f720:1300:3033::1:4dd])
        by smtp.googlemail.com with ESMTPSA id q13-20020a170902dacd00b001743be790b4sm11662318plx.215.2022.09.07.01.52.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Sep 2022 01:52:22 -0700 (PDT)
From:   Li Zhong <floridsleeves@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     peterz@infradead.org, jpoimboe@kernel.org, jbaron@akamai.com,
        rostedt@goodmis.org, ardb@kernel.org, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        x86@kernel.org, hpa@zytor.com, lily <floridsleeves@gmail.com>
Subject: [PATCH v2] arch/x86/kernel: check the return value of insn_decode_kernel()
Date:   Wed,  7 Sep 2022 01:52:00 -0700
Message-Id: <20220907085200.2316975-1-floridsleeves@gmail.com>
X-Mailer: git-send-email 2.25.1
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

From: lily <floridsleeves@gmail.com>

insn_decode() could fail and the insn.length could be invalid. So we
need to check the return value first.

Signed-off-by: Li Zhong <floridsleeves@gmail.com>
---
 arch/x86/kernel/jump_label.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/jump_label.c b/arch/x86/kernel/jump_label.c
index f5b8ef02d172..59385700f579 100644
--- a/arch/x86/kernel/jump_label.c
+++ b/arch/x86/kernel/jump_label.c
@@ -20,9 +20,10 @@
 int arch_jump_entry_size(struct jump_entry *entry)
 {
 	struct insn insn = {};
+	int ret;
 
-	insn_decode_kernel(&insn, (void *)jump_entry_code(entry));
-	BUG_ON(insn.length != 2 && insn.length != 5);
+	ret = insn_decode_kernel(&insn, (void *)jump_entry_code(entry));
+	BUG_ON(ret < 0 || (insn.length != 2 && insn.length != 5));
 
 	return insn.length;
 }
-- 
2.25.1

