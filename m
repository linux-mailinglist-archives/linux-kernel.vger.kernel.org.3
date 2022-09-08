Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F16FD5B28DF
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 23:59:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230256AbiIHV5x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 17:57:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230171AbiIHV5G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 17:57:06 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C3ADB3B03
        for <linux-kernel@vger.kernel.org>; Thu,  8 Sep 2022 14:56:03 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-34500e31ee3so137607317b3.0
        for <linux-kernel@vger.kernel.org>; Thu, 08 Sep 2022 14:56:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date;
        bh=YYrJQHPp1VsbrnyKnikDXxJr0Q0IFfWdTrn7QSp/nlU=;
        b=RAO9dBKDPKviMcOwBkkzZY0G3x+gnPOK29NFIOS/Zr8789LtLOlEaeHEybcNsvLdIW
         K+pwExbWGqldW8BJjVtsPZMGTJR3YhH90i0Txv330av0oqQtT/I4/nvWGh5MKlakz2so
         5hIN+nonzm6i3iZB181y8mY7MbESrP96/nYqECARK6XBLztCpkuitNQRkrC/fKBt390x
         C1uQ3nyJhQju/9EuNJyjkAoZ68HF9wch5/WFjrih+g8E79RhgyzSuuDTd6bYOLqDJcZ2
         y7uASan7GCfY1xHDXgLVyn2OJADPTnjC8NCdgKG5ywLhIO7aMrDjSH/GSa7QdsPmgHM1
         CyIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date;
        bh=YYrJQHPp1VsbrnyKnikDXxJr0Q0IFfWdTrn7QSp/nlU=;
        b=ZddB5FSKqRJXAC3gD7woa5DSdEfhOUTW/uQV+JPUd2RLxEVkDC/JQk80+ME1du6RrW
         d7YOxhLvVE1yk8qSagM5jySXB2WB/Si1AmzPb8QgwFjabVkH0jSEvq10q4y0DFcPK6un
         5EWnaJOZD/PyKnY1wDOoeK1lMJxKhzw1Ore3qku5USVJvRSIp3zqwnE4fPRu+drjFx/u
         Lyaeju831LqTTvEfJt4i76CYSfopanSM7EB+aDKMHAjWUunG4TtUAZXIbeqFs5u3MLW9
         L94bOOwcT7TV8ajBfTqOHt5KK+rZ+nmL7tZnEShfDKR+UYiBM0F3I//knH30bpWm2jll
         e1cA==
X-Gm-Message-State: ACgBeo3k7/+pfDEwoRDt52ZglSXYCDMJOy5i/Wd9UWEUKRFrXkzY/PR8
        7I9bKHu/AifccjTN2lNAAhams/GoNZ2+nDql6cdN0diY40ibTfovrP+bpX2SHGkIUjxGuk9ScoS
        pnf7T9R1tr5KQKHrRaVlAKgx3uf3D5/AIULSnTPVexDnZyvNpa3jZg4emuwT8NiL4V75ROV8er7
        yNV1HLi8+tcg==
X-Google-Smtp-Source: AA6agR5Q1US6p1T5MS7XFebio75PXfPm+oTSo10BuqyTKkQ0gqAhJ38ETDbGBcDqV94PluTx9li4JMCPkaAkCGoLKLU=
X-Received: from samitolvanen1.mtv.corp.google.com ([2620:15c:201:2:a4e4:e6ec:9fdd:1bdd])
 (user=samitolvanen job=sendgmr) by 2002:a05:6902:1543:b0:6a9:adf8:14f9 with
 SMTP id r3-20020a056902154300b006a9adf814f9mr9806374ybu.271.1662674162251;
 Thu, 08 Sep 2022 14:56:02 -0700 (PDT)
Date:   Thu,  8 Sep 2022 14:55:03 -0700
In-Reply-To: <20220908215504.3686827-1-samitolvanen@google.com>
Message-Id: <20220908215504.3686827-22-samitolvanen@google.com>
Mime-Version: 1.0
References: <20220908215504.3686827-1-samitolvanen@google.com>
X-Developer-Key: i=samitolvanen@google.com; a=openpgp; fpr=35CCFB63B283D6D3AEB783944CB5F6848BBC56EE
X-Developer-Signature: v=1; a=openpgp-sha256; l=1011; i=samitolvanen@google.com;
 h=from:subject; bh=UWuLwE4y600ClTatyK0xTSLvu56hvYR9AUlhuy/RYBM=;
 b=owEB7QES/pANAwAKAUy19oSLvFbuAcsmYgBjGmS2BBGj4qMjQc0TkhRxkWipukSgdHFHNJbxjALg
 KA9XqJGJAbMEAAEKAB0WIQQ1zPtjsoPW0663g5RMtfaEi7xW7gUCYxpktgAKCRBMtfaEi7xW7tnDC/
 0YewJWckrPSkwmm2Cp5oCkhzPhtbyWs+Y0ti12HWfm4sxYzV1zNPdfoO/xlWW4YUT3EGNpRhm652XA
 1YZnjCMK8RJ9VL0Mkj7BJ885cDES9oNpu/gFc5tvXbign7Whrk+XzM/OStzrXx7yhwZYc+B8eIBZD7
 /sv3RgkBqGX7aNahcU4xiVpdwE9rdGjjov/qxhkiKbltHSgKqBzPeAagsC/HXzYiAJlS/HUVSc/1Oh
 USSeATQh0fDw+EKujE2ITbZC9M2xnRw4dltthWBXcJupkTYvL+AkR6N1b5Nym/rwwYCYftIuFUZyVF
 EzVcnJCbq4gaQpyF85+NOzZUESoUrn0BLrMWYvfQae/Ekp6s0jQWwsIy18tgEV6VaDF8gS3nzAh6KX
 3zL1l5wpZ7U0i197vi++LJVnvNti2UHclotv6EWBHZkZyGdf34HOHcAgdCxorRqu6n4mbDVi3q+yzs
 EEJlV55qqrvRL3C2yd4Mt1uIUXywud8dPE1BGXLm4eKII=
X-Mailer: git-send-email 2.37.2.789.g6183377224-goog
Subject: [PATCH v5 21/22] x86/purgatory: Disable CFI
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
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Disable CONFIG_CFI_CLANG for the stand-alone purgatory.ro.

Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
Tested-by: Nick Desaulniers <ndesaulniers@google.com>
Tested-by: Sedat Dilek <sedat.dilek@gmail.com>
Tested-by: Kees Cook <keescook@chromium.org>
Tested-by: Nathan Chancellor <nathan@kernel.org>
---
 arch/x86/purgatory/Makefile | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/x86/purgatory/Makefile b/arch/x86/purgatory/Makefile
index 31c634a22818..58a200dc762d 100644
--- a/arch/x86/purgatory/Makefile
+++ b/arch/x86/purgatory/Makefile
@@ -55,6 +55,10 @@ ifdef CONFIG_RETPOLINE
 PURGATORY_CFLAGS_REMOVE		+= $(RETPOLINE_CFLAGS)
 endif
 
+ifdef CONFIG_CFI_CLANG
+PURGATORY_CFLAGS_REMOVE		+= $(CC_FLAGS_CFI)
+endif
+
 CFLAGS_REMOVE_purgatory.o	+= $(PURGATORY_CFLAGS_REMOVE)
 CFLAGS_purgatory.o		+= $(PURGATORY_CFLAGS)
 
-- 
2.37.2.789.g6183377224-goog

