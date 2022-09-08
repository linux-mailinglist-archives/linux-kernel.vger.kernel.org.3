Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9061A5B28D2
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 23:57:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230195AbiIHV5Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 17:57:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229970AbiIHV4q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 17:56:46 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68E2412C495
        for <linux-kernel@vger.kernel.org>; Thu,  8 Sep 2022 14:55:52 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-340ae84fb7dso155072707b3.17
        for <linux-kernel@vger.kernel.org>; Thu, 08 Sep 2022 14:55:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date;
        bh=XmniUTEr3IsWekZR2qFDZKEfj9hJcfqgCneNiF7ztZE=;
        b=WCxXiMf9jt0TJXqJVxEGpO5FIe1m1i3ZGCw5CoV/rJ85nw+sR7A+6ka1r8pSYvcykj
         fdhPJfWapSH0tUHrJ7JwfesE8ueKIfcYHTxrBbgThkGTRj8VuUmZhwmCQ3RzlNEM2ecD
         z8ix+vkJAFymmihF+AY2LlKW9zCy2OxSuz73nD3s3LFpsgclOFOYtOtx3tG5ZwDIz+bP
         A+khvfFMbTOSY81mGX3NqvYc+QXhfp46q/BRrc+yAFDotGxiveN3rjh0XY2tB1HOxaXY
         FYx8Y77WPZ5fIYqlsyAut8OvfzqgiV3dRvDT5sKW7C/HCJM6xuapQF9Yzw/zFOz0vgK0
         uWcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date;
        bh=XmniUTEr3IsWekZR2qFDZKEfj9hJcfqgCneNiF7ztZE=;
        b=QHxYJxgsFK+19BbYMIF3LoOTSKDtLpCvW9yWKNSddfWjpeNEL5uVr398lLXXwnzd4C
         prGn/+0ssGqxmGAv3HkAWRvXUGgi98XcySalVJ1Ua/CKMm88Vmp39dI/2FlhdcKa7KEv
         Bfjw7Dos6MvLW291o3rP5n74XbBbPYNwF7vtts9+BPHkAUeHJuWF5E9Ji4fHSZmnSqsu
         ytnms41GexQACADKIiTA2VtUkWMTwGDGdfG60r3vUJF9ZvB+gs6EYnSV0kmSIC7BC9+6
         ig21G0q6P5xvggR8C31w7qMw/IQAQ6DdOgk2ywt4aP9jWJiBUScdBqSrzNdkEjLpyNB0
         BDXg==
X-Gm-Message-State: ACgBeo0FzQqwlZFUA9ljHYOQrkWJmRuR6CW6VYJUvNk0QIPE0J5DNXFU
        5OIHFMONUAWQFdFhMOyqCIUYnlBVrCk/0u+pZTQZQg5h6wNp9dexdd58SHRdWYQCmE2jjNs3WGm
        cvjIzfHkhdchBYEZ7rPfBv10ZhRo+U1VYht/XtP9QAIByvb3fMZWLf35oau+w+vpWN+GM6QrJvO
        4gFjqvjhBn0w==
X-Google-Smtp-Source: AA6agR6M76LG+TWjK8L+F7Pickv1R6NBQMbIyPbnehQFyZI7o5/G4d6MfhU8IvsMdeYW6PT4y2h9Gv6HjQVCTyH+TGA=
X-Received: from samitolvanen1.mtv.corp.google.com ([2620:15c:201:2:a4e4:e6ec:9fdd:1bdd])
 (user=samitolvanen job=sendgmr) by 2002:a81:8a81:0:b0:33d:829f:644d with SMTP
 id a123-20020a818a81000000b0033d829f644dmr9392736ywg.439.1662674151325; Thu,
 08 Sep 2022 14:55:51 -0700 (PDT)
Date:   Thu,  8 Sep 2022 14:54:59 -0700
In-Reply-To: <20220908215504.3686827-1-samitolvanen@google.com>
Message-Id: <20220908215504.3686827-18-samitolvanen@google.com>
Mime-Version: 1.0
References: <20220908215504.3686827-1-samitolvanen@google.com>
X-Developer-Key: i=samitolvanen@google.com; a=openpgp; fpr=35CCFB63B283D6D3AEB783944CB5F6848BBC56EE
X-Developer-Signature: v=1; a=openpgp-sha256; l=1889; i=samitolvanen@google.com;
 h=from:subject; bh=NWDsac0IgzNSFTJgx7iH+qos7yriFkDjm7ciN3deLwc=;
 b=owEB7QES/pANAwAKAUy19oSLvFbuAcsmYgBjGmS2QtXco+6cnttk3ziU1CPssT9FS0Gu8RLffJMX
 DuiPTDqJAbMEAAEKAB0WIQQ1zPtjsoPW0663g5RMtfaEi7xW7gUCYxpktgAKCRBMtfaEi7xW7laHC/
 kBCEQg3rEEpwp43GQ48GjqbCieliDghyyZPPBekjsBnBNrdnG8Vm9GOSBSH6jHBKRoAaPBYbHnmBxJ
 hbAnIoe8iH/1aMV4X2XS0DnwRarAgGvwIT41btmUEvxO+gDCKbg/1aKwS3k77DRva2rgu6fxSqbY2s
 OprIgnrE7+GivPv5e0Mmvr0Hm9YIpYVHRLl+3eLqWZGc9nzlWEmVmnZkVM+RbbwCUfzbxeQ1BY3ykL
 ZvfY5iLCkg0vVolw3s6qlVYn2LwCoGvB66ee8Z5DiX8ZyGfNaPypyV/1qr5xvpAfJroafshKOsowU5
 +v/x6ze8NdAuOZ+7YdikfQwEELuZ9XXt63bCQ+UD/J8pjGQ8KBUSaXQLOKPmBga5+06qVi4a+PEfeq
 M84OhWdJiTRngnFB9fEWgGdP8L+iNYPNVB/x/IwOzi7A2pgIj0eJgShn2uIHPaPynu8nokZaaRX8EM
 Lm6ye3lWt59SFbyI0JEQFniLfVDG47lRJQZrTQ4ptFSUs=
X-Mailer: git-send-email 2.37.2.789.g6183377224-goog
Subject: [PATCH v5 17/22] objtool: Disable CFI warnings
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
Reviewed-by: Kees Cook <keescook@chromium.org>
Tested-by: Kees Cook <keescook@chromium.org>
Tested-by: Nathan Chancellor <nathan@kernel.org>
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
2.37.2.789.g6183377224-goog

