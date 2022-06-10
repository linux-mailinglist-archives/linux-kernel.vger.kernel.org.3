Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48B90547045
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Jun 2022 01:50:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351072AbiFJXhR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jun 2022 19:37:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350854AbiFJXgM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jun 2022 19:36:12 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B350529420E
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jun 2022 16:35:52 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-30c9a01d1c5so6010637b3.11
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jun 2022 16:35:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=Y96fv5Twtvzm6CyIpXWKw8Jd94PeG6V8wybz0+yAnX8=;
        b=IOPZc5JV3nT2LYllhUNSqQYadg1pAF7x0nJHGRfuoOldyA3IF4MfcUfi28kwW9bjK3
         ZkOn4EyemcOKcBZ4lvbRoM88zdr4pP/X6pNrmQS+Trrh16VsFWzR/ivvrnkgTFcOEBeq
         zh4c1XSjaFca/mNv67WEZZRQg6ZyEcv2WeJgQKjPKDJ+6inRCnLsR02LvK76lq7rrygX
         kc4b07GD1ORl1Vkg+OCQkeYlNtADbEXYf/V4ORhUII4xOAh9HLKlgJsAnnSOy3K+JaGt
         GLg2Vk1h8xnuWJsYbO4m9Twpc05icIIuVq5OYgfBIvRgF9MT/sXYCcHdZ4chr4Z9vQ5Q
         kXOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=Y96fv5Twtvzm6CyIpXWKw8Jd94PeG6V8wybz0+yAnX8=;
        b=19+PYqqfycXaOndLZG3y9PqhNYZdEa0gZfMeyzwCjGOqcNyaxt0eoU/+t4CMHvYLID
         KDMiqoDgzV9Oi7AAecKpwMt868igQpt+iD2K1fJRC1O/UXFlQuti1QSVam5XD2vPt7b8
         iy7ksX0hsuvBVOaU20y0Qgwq08w8t7Hll12XLrRZyEngPbVy6LhskBQ8dO5fKxeleluz
         2+0SIIlyYgI03LApDlSHy2RawsyJ54N2/zWf4rno/2ymmfA6ceSK7BafJrXqOmhzjZ6B
         PQ2ewBbUehrGwlHY8MOzndl5uiXXteEEA9V0/GRMeO1xuzT44LznHrLMYLUH4U6VOCkL
         uZPg==
X-Gm-Message-State: AOAM531jO1MzbSNQPGjuuJldbISpGRRL61Otk5P/9uuLs7ZrFxtIrbk1
        Voa06gyswv2GiJVJym3GjQXF+GXJe88cfqL1OKRU6WYtv80+nGQ+BNSqnHLQWuHQAKF3NLWeGdr
        o+tjoGVUg5IWfO5ue2tVqIjWrj1dPTW6mNOcH8NkiUhfFCAEMBR+nHERHN54ETRb78hOeS1UqfV
        enMffXpSjMFw==
X-Google-Smtp-Source: ABdhPJy9bfekC1t933fOPbzFYENcQN+eqW+7EGnrnrzBGcNrDj6mBwpdrX+ZIvaajj0sxXWUKj9zyhS/v8ScejPId0A=
X-Received: from samitolvanen1.mtv.corp.google.com ([2620:15c:201:2:f464:6db6:3d47:ed14])
 (user=samitolvanen job=sendgmr) by 2002:a25:7901:0:b0:64a:a1d9:43dd with SMTP
 id u1-20020a257901000000b0064aa1d943ddmr45895436ybc.271.1654904151760; Fri,
 10 Jun 2022 16:35:51 -0700 (PDT)
Date:   Fri, 10 Jun 2022 16:35:08 -0700
In-Reply-To: <20220610233513.1798771-1-samitolvanen@google.com>
Message-Id: <20220610233513.1798771-16-samitolvanen@google.com>
Mime-Version: 1.0
References: <20220610233513.1798771-1-samitolvanen@google.com>
X-Developer-Key: i=samitolvanen@google.com; a=openpgp; fpr=35CCFB63B283D6D3AEB783944CB5F6848BBC56EE
X-Developer-Signature: v=1; a=openpgp-sha256; l=1757; h=from:subject;
 bh=BzYyCCjIKMVIFOaxytMd//v1RLhPm9T7iP3/4Zx5xVM=; b=owEB7QES/pANAwAKAUy19oSLvFbuAcsmYgBio9Uusl/O2s6wYiJP/kbTa1chVv26D4F+cGeoouVP
 CLXe2fiJAbMEAAEKAB0WIQQ1zPtjsoPW0663g5RMtfaEi7xW7gUCYqPVLgAKCRBMtfaEi7xW7p5VC/
 9Ik3mkvkfwpcvMaILAG8ecfZFaAeyupedPFpv7JfK5CDJfRdYJy6I8IwkF6zyaPwEpszbFtzIngJp1
 9VLVbi4oBQefo3DpNAVs92FiUcWdUCTKkV7FZtf1KHmTbcXiDaSei1A+sMXqlbWgwS5aukcZ5H+NRj
 ez76Hc3KoZRoN4iKlxLcKRNHKXpC6fe9Zie7IPO1sMkA1OXATSdGQfVw+6gv4q0+ae1ZMD/7994o7H
 svydE+m5htCfP8PK65SJBa8zHBM6ew01HQ1rYygo/X2Sc5yi/4w8Z/ysL3lacG7Jweqr21P7GnS2fR
 EkYD/xUbl9UA4W+IlBSY9HuJiSpiS1MbhICEI2OvNo0BakVlcF8T6rhqcGPF8IKLB7N5SjJnFWHOtd
 5iRHPAaDebe6mi//sYNB0DF52K4EuYa7vPMeX54NUVHcDgamHQlZhqAna7cOgDvpSiS34oTlsond2r
 LOwD6icdz2QqTZkK/eZRy2JwR3ZYdCMaJ91x+ll6SUcLM=
X-Mailer: git-send-email 2.36.1.476.g0c4daa206d-goog
Subject: [RFC PATCH v3 15/20] objtool: Disable CFI warnings
From:   Sami Tolvanen <samitolvanen@google.com>
To:     linux-kernel@vger.kernel.org
Cc:     Kees Cook <keescook@chromium.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Joao Moreira <joao@overdrivepizza.com>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-hardening@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, llvm@lists.linux.dev,
        Sami Tolvanen <samitolvanen@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The __cfi_ preambles contain int3 padding and a mov instruction that
embeds the KCFI type identifier in the following format:

  ; type preamble
  __cfi_function:
    int3
    int3
    mov <id>, %eax
    int3
    int3
  function:
    ...

While the preamble symbols are STT_FUNC and contain valid
instructions, they are never executed and always fall through. Skip
the warning for them.

.kcfi_traps sections point to CFI traps in text sections. Also skip
the warning about them referencing !ENDBR instructions.

Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
---
 tools/objtool/check.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 864bb9dd3584..337b92c3b755 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -3207,6 +3207,10 @@ static int validate_branch(struct objtool_file *file, struct symbol *func,
 		next_insn = next_insn_to_validate(file, insn);
 
 		if (func && insn->func && func != insn->func->pfunc) {
+			/* Ignore KCFI type preambles, which always fall through */
+			if (!strncmp(func->name, "__cfi_", 6))
+				return 0;
+
 			WARN("%s() falls through to next function %s()",
 			     func->name, insn->func->name);
 			return 1;
@@ -3827,7 +3831,8 @@ static int validate_ibt(struct objtool_file *file)
 		    !strcmp(sec->name, "__ex_table")			||
 		    !strcmp(sec->name, "__jump_table")			||
 		    !strcmp(sec->name, "__mcount_loc")			||
-		    !strcmp(sec->name, "__tracepoints"))
+		    !strcmp(sec->name, "__tracepoints")			||
+		    !strcmp(sec->name, ".kcfi_traps"))
 			continue;
 
 		list_for_each_entry(reloc, &sec->reloc->reloc_list, list)
-- 
2.36.1.476.g0c4daa206d-goog

