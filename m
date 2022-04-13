Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B06554FFF4F
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 21:29:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238387AbiDMTbq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 15:31:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238392AbiDMTbg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 15:31:36 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 863D576647
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 12:29:13 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id bq30so5360638lfb.3
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 12:29:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ze4SVP5i5zsP2I9AhxuyfeE8P/HaUEekN0ckGJjo3WI=;
        b=GRkH4KsJRBinbD8PDvRvxZddDDQBgVmtY+9S7GEjBz4F+zU2SmgpbHJALHBZFQAsyU
         pymx33QW/NCijKNhunbIxA/eqb4GchRBZqBVWXA47zogsugtt2Cnk7zrXv2221f+z9pZ
         69vkDURJiA/czEjur0bU38AaKSqoPsweXiDKsPjyD/znwQt6fXoVD5qqA99wbD7iyAN+
         5lQg9DP3eeqiPmagLqv/VZp38M7mtLdIvNxcbcryM6kqIthk536JVD/6R5/OXNte4oeO
         Vm6UMXVGLYTLmZJf4/XpgGmf76MkWmKo4j/450pPqvJCSNctMTvY8N14FNBSurUzAwan
         vGpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ze4SVP5i5zsP2I9AhxuyfeE8P/HaUEekN0ckGJjo3WI=;
        b=pbCXMNapgdZgHmy3S+1vOB8kH3vJ7zEjRSPJkIW/0Wq/WuQU7tsH5LycBadK/IltON
         FDAneTliDTmu0MddB0Kl2YVj8pIolNd37dHVxRJnWK8lmJ0blY0PMgLgANsZWmaZssf3
         yBqBlJmuiZnUuVntEZT5c2RVf8CWDOzaX2yQ52MpbbwZlFSa05BleG0VLeo388s9qqjz
         27jqDqlWDdmzRyGO1D+rhXu/Fiqs17PEzH7B9sjRYX1lbECcpCzTLuZUi7mv3JDjrzw4
         hTjJW8GAM4eV7X3IgWITuNRtNTAPuXQK8IwOnM4eOIMQ6OU0cvdYJEyRRp+8CVxJhbB5
         YBcQ==
X-Gm-Message-State: AOAM532FiTaErvkkOFz41xe3JnegXhhosRy/xzEITBc05GdQPgOP8S9H
        A8tLfM7saZKY9p5MIdclntJEZND+TQs=
X-Google-Smtp-Source: ABdhPJxiRRH1bbuTJUz/sG6LRfcaXkEQgJDxTIBUJdcDxgaL9MBM6NDKcHmawlmq2jeJ1OSmLWMf8A==
X-Received: by 2002:a05:6512:b11:b0:44a:2ead:daf2 with SMTP id w17-20020a0565120b1100b0044a2eaddaf2mr29636142lfu.642.1649878151554;
        Wed, 13 Apr 2022 12:29:11 -0700 (PDT)
Received: from noname.. ([2a02:2698:8c2a:149d:6d9:f5ff:fecb:a8ab])
        by smtp.googlemail.com with ESMTPSA id m12-20020a19434c000000b0046baf0e3022sm1047999lfj.254.2022.04.13.12.29.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Apr 2022 12:29:11 -0700 (PDT)
From:   Grigory Vasilyev <h0tc0d3@gmail.com>
Cc:     Grigory Vasilyev <h0tc0d3@gmail.com>, linux-kernel@vger.kernel.org
Subject: [PATCH] tools/x86_energy_perf_policy: Fix comparing int with LONG_MIN and LONG_MAX
Date:   Wed, 13 Apr 2022 22:29:00 +0300
Message-Id: <20220413192901.179470-1-h0tc0d3@gmail.com>
X-Mailer: git-send-email 2.35.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A condition that will never be met.
strtol return long value but we have int variable and strtool can
overflow it.

Remove meaningless extra overflow comparisons.

Warning:

x86_energy_perf_policy.c:337:25:
warning: result of comparison of constant 9223372036854775807
with expression of type 'int' is always false
        if (i == LONG_MIN || i == LONG_MAX)
                             ~ ^  ~~~~~~~~
x86_energy_perf_policy.c:337:8:
warning: result of comparison of constant -9223372036854775808
with expression of type 'int' is always false
        if (i == LONG_MIN || i == LONG_MAX)

Signed-off-by: Grigory Vasilyev <h0tc0d3@gmail.com>
---
 .../x86_energy_perf_policy/x86_energy_perf_policy.c  | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/tools/power/x86/x86_energy_perf_policy/x86_energy_perf_policy.c b/tools/power/x86/x86_energy_perf_policy/x86_energy_perf_policy.c
index 5fd9e594079c..5fd7e2d4cd0e 100644
--- a/tools/power/x86/x86_energy_perf_policy/x86_energy_perf_policy.c
+++ b/tools/power/x86/x86_energy_perf_policy/x86_energy_perf_policy.c
@@ -308,7 +308,7 @@ int parse_cmdline_turbo(int i)
 
 int parse_optarg_string(char *s)
 {
-	int i;
+	long i;
 	char *endptr;
 
 	if (!strncmp(s, "default", 7))
@@ -334,15 +334,11 @@ int parse_optarg_string(char *s)
 		fprintf(stderr, "no digits in \"%s\"\n", s);
 		usage();
 	}
-	if (i == LONG_MIN || i == LONG_MAX)
-		errx(-1, "%s", s);
 
-	if (i > 0xFF)
-		errx(-1, "%d (0x%x) must be < 256", i, i);
+	if (i < 0 || i > 255)
+		errx(-1, "%ld (0x%lx) must be >= 0 and < 256", i, i);
 
-	if (i < 0)
-		errx(-1, "%d (0x%x) must be >= 0", i, i);
-	return i;
+	return (int)i;
 }
 
 void parse_cmdline_all(char *s)
-- 
2.35.2

