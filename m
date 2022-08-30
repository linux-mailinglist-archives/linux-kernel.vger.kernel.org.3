Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A0095A71E7
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 01:35:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232010AbiH3Xff (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 19:35:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232105AbiH3Xcw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 19:32:52 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F0DD83F15
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 16:32:18 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id n16-20020a258d10000000b0068df1e297c0so879956ybl.15
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 16:32:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date;
        bh=QaAhiBNrHu6GYkLFA3B7rG1GS8UtnkRvQfTpKHPiaFU=;
        b=Uzu0hS7fYpQn9SuqY6pJYAs0mwU+Cbcm7VfqttztC5Y7vvGMMQbw4wbd/rsgMajhX8
         hCYkTHXcE5WgpL526ftRFAS1iaJreodEJpABN25rLzozJPt3fTcwLmVcYcs0vcC1nhlH
         yp59OC26/dM0xfLKycIeelmnMx/ctiemiWAngqrglcx45erw27Nl2sLJAj1c3kLUftM8
         0iSFHBjA1GYjEC6cZmd4UeYpgAKFk2VTxcYmGZKFX6zgfodGL620Sb3emlMY85C3OcAo
         bE5fs06VNU0/03FLltVrwNWpMmfeDGopu8w2Crj1CckQW60JmF6IEikz1fcox97zq9e0
         FlXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date;
        bh=QaAhiBNrHu6GYkLFA3B7rG1GS8UtnkRvQfTpKHPiaFU=;
        b=0uY+SQU35VEKHPMz6EeX4DWAgqFTTFdzU6/fD2ECOla3GrYpdTr5pHQkFwwyr/YyLZ
         OXJ+0Tui8gZP/Hu2hMLMaT1cL+H9yy8GtzG/DAFOC4Im1S7CNhNmxBwfzEFQTETA/Qhq
         BPtEF5FB0nitzuZWJbGkTkM1d96w2f20sCE0CfWeehe0ry62DlizKRCt0+KIyp/6FgQk
         9EeneDm1B8gouqzgt35SotgIOv7VVapX38mKnTM20qOc5MLy78n/lev05W6o0RRujFuD
         AsaLmH32Y07yX3be9yiUFwMoCDzJrufJCvUcaW4vbYITV5osFzRk9AbY/+fEF2qurik+
         Mw0w==
X-Gm-Message-State: ACgBeo2HkE3K+KKbuGVIn1ZD8ZQejnByqRToaS7uGz1vDwkjr7RpaD0T
        a7HO4Vln9Er0vkkApa52v/F5ITuBqRlOLYog76XIVDTLB8nK4IrT9mVlggyEFf46b2xCOY7hDo3
        ppx71cws4VUYeL5/WEbeN1r3F0VQGEYSIUZh1qWpCr7XVwrMr9zYM0iZXTkiHtjaepaWIWvRibk
        nu+2NnPAnZsw==
X-Google-Smtp-Source: AA6agR4FDK+ca8ExoQOJuxzStWcPg0UmoHQzTdwmwi9npQMvWgOYplZw4nRfd6yLznTzYg9mNTUtUOCVf41ZKmBVqKc=
X-Received: from samitolvanen1.mtv.corp.google.com ([2620:15c:201:2:54d9:7143:6a7d:91d])
 (user=samitolvanen job=sendgmr) by 2002:a0d:d850:0:b0:340:d2c0:b022 with SMTP
 id a77-20020a0dd850000000b00340d2c0b022mr13497429ywe.469.1661902336610; Tue,
 30 Aug 2022 16:32:16 -0700 (PDT)
Date:   Tue, 30 Aug 2022 16:31:24 -0700
In-Reply-To: <20220830233129.30610-1-samitolvanen@google.com>
Message-Id: <20220830233129.30610-17-samitolvanen@google.com>
Mime-Version: 1.0
References: <20220830233129.30610-1-samitolvanen@google.com>
X-Developer-Key: i=samitolvanen@google.com; a=openpgp; fpr=35CCFB63B283D6D3AEB783944CB5F6848BBC56EE
X-Developer-Signature: v=1; a=openpgp-sha256; l=1745; i=samitolvanen@google.com;
 h=from:subject; bh=jQm92I9xQfCJPH6jkHCDpzvvJGb/s+FwIZvLF3ZcxmA=;
 b=owEB7QES/pANAwAKAUy19oSLvFbuAcsmYgBjDp3OLXWXp4dv7z7QEAEH5wDVXEoy6vQwE4MAgTih
 TKcGqJ2JAbMEAAEKAB0WIQQ1zPtjsoPW0663g5RMtfaEi7xW7gUCYw6dzgAKCRBMtfaEi7xW7uhuC/
 4mLD2OTFFRM6dzC+U3G8nSByx2EP7YNHOfYlhOKl0Gv/CfgBF/GmPU6h3gd2FYTdIVAmx+Jt5i7jod
 yHHS4gZDl8y9ik+cOIJfaq9PCplP1qzBI5UZveW67TQSOg6aWHjQltgyelJnFQOdFAyzVFhcjo1ZT4
 RasjgLDZdDZaCQZXWXBTkwjmqg7yGU6nx6FTkZor6xheRDX2kEOcxc/tAIWc/F3tCwLKZO3b2OacxU
 kLhRFXfTjDHGI8CEMPaaAiF2HgUeJEAfx8o4vhL4zMeTDaKFmRQlmf7F9COJc6E7kag2I6rBVTMLaT
 FWl2SlSRnYF0zOFsCumLTWzpoCgAijPhDKp/uWc4Bl+x2WAveRz8IYR1rkvZSXXc/Y0/ys9658hItd
 QLTUDCSGboZ0fd2TFzIbCfImlNrGKDomVDfTKP6XcarqWEI1dc/zyJKjcz0KqduDH2E4Ieu9sxhkpl
 Xw4LrtrfDpSWz1SEU4GR+7wRiD1adQkP+R3N0lIVY4BnU=
X-Mailer: git-send-email 2.37.2.672.g94769d06f0-goog
Subject: [PATCH v4 16/21] objtool: Disable CFI warnings
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

The __cfi_ preambles contain a mov instruction that embeds the KCFI
type identifier in the following format:

  ; type preamble
  __cfi_function:
    mov <id>, %eax
  function:
    ...

While the preamble symbols are STT_FUNC and contain valid
instructions, they are never executed and always fall through. Skip
the warning for them.

.kcfi_traps sections point to CFI traps in text sections. Also skip
the warning about them referencing !ENDBR instructions.

Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
Acked-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
 tools/objtool/check.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index e55fdf952a3a..48e18737a2d1 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -3316,6 +3316,10 @@ static int validate_branch(struct objtool_file *file, struct symbol *func,
 		next_insn = next_insn_to_validate(file, insn);
 
 		if (func && insn->func && func != insn->func->pfunc) {
+			/* Ignore KCFI type preambles, which always fall through */
+			if (!strncmp(func->name, "__cfi_", 6))
+				return 0;
+
 			WARN("%s() falls through to next function %s()",
 			     func->name, insn->func->name);
 			return 1;
@@ -4113,7 +4117,8 @@ static int validate_ibt(struct objtool_file *file)
 		    !strcmp(sec->name, "__bug_table")			||
 		    !strcmp(sec->name, "__ex_table")			||
 		    !strcmp(sec->name, "__jump_table")			||
-		    !strcmp(sec->name, "__mcount_loc"))
+		    !strcmp(sec->name, "__mcount_loc")			||
+		    !strcmp(sec->name, ".kcfi_traps"))
 			continue;
 
 		list_for_each_entry(reloc, &sec->reloc->reloc_list, list)
-- 
2.37.2.672.g94769d06f0-goog

