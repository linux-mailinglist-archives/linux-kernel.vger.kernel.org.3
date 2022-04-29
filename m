Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81D405155D6
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 22:39:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380996AbiD2Ulg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 16:41:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381000AbiD2UlC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 16:41:02 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26FDAC9B5D
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 13:37:29 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id b6-20020a5b0b46000000b006457d921729so8368109ybr.23
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 13:37:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=pCRF8WxuKsJLhQegFtXAhQOgdkZIXxpUFMBNWofutJg=;
        b=rb5PJBXqZ7PDnTljG6ifIE8gyd72IC34q/VtcjXuyOJl6AMtdmAjmsfq0lfuEQekK+
         pMx1HTeDGFvMcB0zYoRjn8iodh+Cl+ug6t0NujoKdJdq5JfOpcm53hx9cYRc9czaoM6V
         wCCo8uZtcZNwjZnC3yaMKuANSRu6vyIDn4uQlpbz9pEsr0iVULxkNpsgUh09QxYqO+bt
         8ih8Yb01J1emTtSHlr8jVVrGUw/d4znoCzHf779F0LEMOL9mgrcOcmkCJcbSd2cORoDr
         xqfesnGB09orA1eomT3hmGVMGTGc6KccZjw7UoOwSyooZfLr+oU9LAzuLtNDPJOImR+j
         aHHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=pCRF8WxuKsJLhQegFtXAhQOgdkZIXxpUFMBNWofutJg=;
        b=ro0hA3imlwsgDVqjuwsfHvvmev9cHZZ4Q2x6jAayQH+9vu7A4hB1uOnLevhJLNqV7X
         8ZmdVHuWKIn4JqTBfpHmDvmnyjWbyWK7AaavTC/tFnzpdE5LWWVtRPQdgdw09kKQOtYe
         X3RzvfbrK7RltRP/DBS/6ZZnUlmz5BFsxmu1UntzP7mFCOcbCuYTbqrCFyZ/10NDryjZ
         xchSf8JfOG+NAQ/s6Lo1cy0aVKUgz3ToOHPtiMVRITlx7VW7Lor+BLu4uiO9e9QSNV60
         ZwP9TO8IyicD7VwfvsnhF1dNfadJPLdskki8WOCX8ty0gH9loXPbFz8pI4uiLhuXbNDj
         Fz5g==
X-Gm-Message-State: AOAM532+0MFtFhlXdZMkDQ5ydgM5RdXoOHY1EVzgbi/zm6SZMSlA9zun
        t/6EwAZh/wvLdLReXCVHiS2Ls+yyD8D4IidkJR/B2LIPfVdCSTdpuKpeR46ryFpZNB1ta2CjRKX
        iq6uOZcpbD2fd2libkWFKQuKP9iYSNni7dOvHzQqRwP/yobBR5z7GJFaCZqEHHVJEO14ZlK5dyi
        L52gDzeg0bbw==
X-Google-Smtp-Source: ABdhPJxW/4+AcaZSu3uuWyLU6uIyltSWFVdpdAXqDeDs5bikx77gj1C032JW2iKcFOB1vCKNvHaYzdWvZDktOIt6B6I=
X-Received: from samitolvanen1.mtv.corp.google.com ([2620:15c:201:2:351:bea9:f158:1021])
 (user=samitolvanen job=sendgmr) by 2002:a0d:ddcf:0:b0:2f7:dc0d:93e0 with SMTP
 id g198-20020a0dddcf000000b002f7dc0d93e0mr1144605ywe.9.1651264648287; Fri, 29
 Apr 2022 13:37:28 -0700 (PDT)
Date:   Fri, 29 Apr 2022 13:36:40 -0700
In-Reply-To: <20220429203644.2868448-1-samitolvanen@google.com>
Message-Id: <20220429203644.2868448-18-samitolvanen@google.com>
Mime-Version: 1.0
References: <20220429203644.2868448-1-samitolvanen@google.com>
X-Developer-Key: i=samitolvanen@google.com; a=openpgp; fpr=35CCFB63B283D6D3AEB783944CB5F6848BBC56EE
X-Developer-Signature: v=1; a=openpgp-sha256; l=641; h=from:subject;
 bh=DxQc6EGDGB8zEXE4dDnKQIh2BeDsSr/ulqb1I/8a6/M=; b=owEB7QES/pANAwAKAUy19oSLvFbuAcsmYgBibExXdkK4E+eES2dE3iysIrEucJWLi1au+dxYyIiv
 PoIr2IqJAbMEAAEKAB0WIQQ1zPtjsoPW0663g5RMtfaEi7xW7gUCYmxMVwAKCRBMtfaEi7xW7jN+C/
 9NuHLivGVpdnQ5h09S1KucfK0dDYhnxeXvjJsVMWhnO+lQDVoYHCCl5XS5s1fIVTqbdKMprLkXjWt6
 pmEkoXNNEA9NLrUjE6YWmfUmUHDQ5qLnl1zZRAdfrDM+TwEdRrdk76z3O1H72HxKW2Fhdo0fp7rO/S
 AfFpWddva2zdjw6GUPJcbTB08W2/n/QuoReY4FJI2CiZ5dhhjeP9UA+yefvCFQNmyhaUX30cg8Jxm8
 H651xE0f2VrSPBcSVmrVMN29dgeghi1M0QnTu3SWABhA9Zq/sWAq4dmOhnHAjFfwPVr/B5TDzIadY0
 yt/QHe4RXgBdIpCeYc+nV8hl/cRLKQ+KtM1YfepHZV2Pn7EqOwnvmiMRpDIt8VWv/W5SqdpE4SNG4K
 wS1d/ZasQIzQxU+EC3z7E5RijhdSJh9X5+J0iYeI4YuT6IhQsCVsn3zqUwQLXusdt9Iu6hwIiOOJ/5
 V86zuETn5IGcbe1euGU6/Eo3BmgfEx8DHtnulobHhXn+A=
X-Mailer: git-send-email 2.36.0.464.gb9c8b46e94-goog
Subject: [RFC PATCH 17/21] x86/tools/relocs: Ignore __kcfi_typeid_ relocations
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
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ignore __kcfi_typeid_ symbols. These are compiler-generated constants
that contain CFI type identifiers.

Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
---
 arch/x86/tools/relocs.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/tools/relocs.c b/arch/x86/tools/relocs.c
index e2c5b296120d..2925074b9a58 100644
--- a/arch/x86/tools/relocs.c
+++ b/arch/x86/tools/relocs.c
@@ -56,6 +56,7 @@ static const char * const sym_regex_kernel[S_NSYMTYPES] = {
 	"^(xen_irq_disable_direct_reloc$|"
 	"xen_save_fl_direct_reloc$|"
 	"VDSO|"
+	"__kcfi_typeid_|"
 	"__crc_)",
 
 /*
-- 
2.36.0.464.gb9c8b46e94-goog

