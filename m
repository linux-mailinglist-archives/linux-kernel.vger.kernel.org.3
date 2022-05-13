Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7785A526B1F
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 22:22:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384126AbiEMUWP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 May 2022 16:22:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1384114AbiEMUWH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 16:22:07 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12190154F9C
        for <linux-kernel@vger.kernel.org>; Fri, 13 May 2022 13:22:07 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id d22-20020a25add6000000b00645d796034fso8238850ybe.2
        for <linux-kernel@vger.kernel.org>; Fri, 13 May 2022 13:22:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=dq5ya0HLbqhoGaxybMwD+u455UO61ysiO/Cn6SCUV4E=;
        b=QhvLqyQ7SGkhcJcmlPcAMvH4X9HlQFOiCjtBh/sxV7YFuCJ87i5PkY99k8mpn88Z7L
         bAJHA6Yi+ZPZn6RvkqV/eFGCG1px4tIYEl7/NiOpU+6qbrDMEZhC+SRZjcWXz+crVMyB
         k89fvJN/FDgzHnNowBikxn+RDEi5rz5cjkFzu4OdcmLuH5qG5wD0z0VtWR17tHJLAXz6
         D/UCknaW80Q18TX1vss3qORW2jhII4B6rQkGv+V6pGg9zIzJdJU8oSKhfhM1q13nyTu0
         RtKAlKqIMYJgUOayt2WSeBxXLwmjgEC/4qZ7cyJ+5su7ftJjYIt4dwxMI94GP5ohXkvi
         VOKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=dq5ya0HLbqhoGaxybMwD+u455UO61ysiO/Cn6SCUV4E=;
        b=qdanJFxJqKCSkxSrz4i797UpLKyZXWFKQBQdFZk+IKnxBK1xQNaUDQNrWoGVC1fViJ
         BeB6pQ6QnyU5aZ+xn6Zd1Ele6UfAbx4qDMgqwtM8lmZ6Pc5/YrmChNAcaDEmadw3S768
         9nApao//oX8OaTs74RozCTGQt2GPhRN7A9UtL5GLZ7yLgDAXIm9DM3PA69N7j460UwxI
         JvBTYiMbslXedmmq6e+mrhozQjyJKwi2KLa9wq+BrCjSYC+ZT6YebIWbGqbCVKQsCHVf
         XIz0wmzA5kmQwevCqJBy0neMnNq/k69r/Ou0YL8zg9k0ZPRwiSxmnvMqC/kHSWiEZjy1
         CSnQ==
X-Gm-Message-State: AOAM531AZfScV4qq/YIB6iZLNbdxta8aI28wUkOrDVG6G//FO/5EmeVT
        lJzGCFtcjSUAdQ/sCyZ+fteWmYnzldvDr/yLJ12x8DFCWhDM5JNDJKG+Bnb8g9P8mh3abzBrUUb
        u2TBXwh51ge2l2aJGUfpWm16i2NnWcIIbJaFbw5Oek19OVayI8WaGQI1dTco3BGx3aEDWhTngHh
        knGBEYYqgDkA==
X-Google-Smtp-Source: ABdhPJx6nPe/UG4ioi9xxrUNrDLMncxESewxC/vESjwPAZ8T0UiRXU3Rn9QJIYSuvrV9TPZrXKmlIeVohGiRmaBJe18=
X-Received: from samitolvanen1.mtv.corp.google.com ([2620:15c:201:2:e0:c17e:c2dc:13eb])
 (user=samitolvanen job=sendgmr) by 2002:a25:d1d7:0:b0:64b:6193:cd6d with SMTP
 id i206-20020a25d1d7000000b0064b6193cd6dmr6849614ybg.149.1652473326244; Fri,
 13 May 2022 13:22:06 -0700 (PDT)
Date:   Fri, 13 May 2022 13:21:40 -0700
In-Reply-To: <20220513202159.1550547-1-samitolvanen@google.com>
Message-Id: <20220513202159.1550547-3-samitolvanen@google.com>
Mime-Version: 1.0
References: <20220513202159.1550547-1-samitolvanen@google.com>
X-Developer-Key: i=samitolvanen@google.com; a=openpgp; fpr=35CCFB63B283D6D3AEB783944CB5F6848BBC56EE
X-Developer-Signature: v=1; a=openpgp-sha256; l=988; h=from:subject;
 bh=RNVQHrlEA9fX91aGJUv17nzO52aQ646VsAxq7TYCVmE=; b=owEB7QES/pANAwAKAUy19oSLvFbuAcsmYgBifr3isUdSjjLVv9wzgpsbojWEfNbcYqclULDOWDcw
 kQXpx/yJAbMEAAEKAB0WIQQ1zPtjsoPW0663g5RMtfaEi7xW7gUCYn694gAKCRBMtfaEi7xW7p9EC/
 9JO2MwCu1MjbT8Exc52X4QzT9yYK9ojOtmr6WsnYMtpgxHa2q1EE6j+R5DjIqzA+m2ZWPHkY8SrMeG
 ZrpJnTHJPvFOmOV9L+KDF1UT+Vgo2YVrHJuQqxkraewUIudUDq4Bab1FpnWkPZ4QtwJ9xuzKjcnA12
 rUIsUKiEhUi1G12cNkjH+aGc4Ny0YP4T2rz89dMrdARLVOHhRPupWfkUNfNVLrIlXbnof/ZCCjhJz1
 /gosCtk/66Q2tgY9KlHpacjuBslmTAN6blKpml6eqY1jRO1Hqa6ScjNXsr7+p5muSKkIRmxw1nPydt
 uEjXwjPlU5Ruc4YYTkRQ1SHEvAY/KmfK1bxhTW2zqyS909mhqMUEKaAw+n3DCzcCfosyD9GzAspMLK
 SZA/KsxdlXzjUxfsDSQMVqyc7AOnO30FS+TtKeAMlZU6kbhpl6I1yJyRW4cejjllmWB/ynZIDhDZTJ
 mZiNpwrFr0PQBQTYS1f63TSat1c1BfyDD5IZxeq1F4sM0=
X-Mailer: git-send-email 2.36.0.550.gb090851708-goog
Subject: [RFC PATCH v2 02/21] arm64/vdso: Filter out CC_FLAGS_CFI
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

Explicitly filter out CC_FLAGS_CFI in preparation for the flags being
removed from CC_FLAGS_LTO.

Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
---
 arch/arm64/kernel/vdso/Makefile | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/kernel/vdso/Makefile b/arch/arm64/kernel/vdso/Makefile
index 172452f79e46..6c26e0a76a06 100644
--- a/arch/arm64/kernel/vdso/Makefile
+++ b/arch/arm64/kernel/vdso/Makefile
@@ -33,7 +33,8 @@ ccflags-y += -DDISABLE_BRANCH_PROFILING -DBUILD_VDSO
 # the CFLAGS of vgettimeofday.c to make possible to build the
 # kernel with CONFIG_WERROR enabled.
 CFLAGS_REMOVE_vgettimeofday.o = $(CC_FLAGS_FTRACE) -Os $(CC_FLAGS_SCS) $(GCC_PLUGINS_CFLAGS) \
-				$(CC_FLAGS_LTO) -Wmissing-prototypes -Wmissing-declarations
+				$(CC_FLAGS_LTO) $(CC_FLAGS_CFI) \
+				-Wmissing-prototypes -Wmissing-declarations
 KASAN_SANITIZE			:= n
 KCSAN_SANITIZE			:= n
 UBSAN_SANITIZE			:= n
-- 
2.36.0.550.gb090851708-goog

