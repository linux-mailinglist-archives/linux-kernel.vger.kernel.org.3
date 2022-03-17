Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D4354DBFC4
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 07:58:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230063AbiCQG7V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 02:59:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229605AbiCQG7T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 02:59:19 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58808F58
        for <linux-kernel@vger.kernel.org>; Wed, 16 Mar 2022 23:58:03 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id kx13-20020a17090b228d00b001c6715c9847so2352418pjb.1
        for <linux-kernel@vger.kernel.org>; Wed, 16 Mar 2022 23:58:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zkOG+K6NjbwTehAPwQYjOzi8UwOfG9D2oWxDR8dVyLE=;
        b=RrybIfFDK8ohQFGv8+EUtM2I24/h2MH4i1AXLe8Cj2YUXZ+zWdS4LpxGK7R/fd769G
         vqed7Gj+hrxECiHFwgxb5pf/ffyksuRz//xjgI0HghNsQnoWql4X70L78oBiaQtdRWJL
         6L+H3lH28vJcARxkl1i40urO8G2Y/moMinuhCgVyNefK9KvFMM6majEj61U6YVPlVWnl
         MJkKGjiWS/3shYZd0TvBsqlWLRH+VTicZMiH5gVQTks9cWMFLvJcxevFxKGjkJsqLODL
         UwtMuDhOzqJ2exhK2Qnp8+FTJVPEfpqbh3X7SRgMjb2JLKGbt9iDdpFPcW137maeWxfm
         vFCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=zkOG+K6NjbwTehAPwQYjOzi8UwOfG9D2oWxDR8dVyLE=;
        b=fLkDgygIdV3NzqMNfpOgmLrhAYGCgd8Iaur5cZDBRUVhJ7IKA/tvEHM1SLNv79zy/X
         q08cC7q3gHCGANTwTDolDhtYAp5dXMGhhf8sEIMa9sRUHJXl69Qj9FP2Ly2/867XakpF
         1nmzGg0QliiIfcmkyxEsRI1rkonhMyEv7BCKqtPC0wHKMTPZAISpMIE3QDsDyW++7py3
         fEqOdJ5KKiY98lgkZIqYTl2fMLWQlgPa8IKpVxDRTcTHk26kIdUb3BSvD63n0nDNRqVJ
         j8w8oslzVxlqJwD8gZOIYqpFk20ZZpCCuRsO1JIwSbEcgUKwZ8aWzH2xxwlGreXsNzSf
         ywJQ==
X-Gm-Message-State: AOAM532W+3eO8qY98Xzwh+jdt1iPM7lwYhKTgr+ej8Rvot93Hqd0UNY4
        V1QXCR2AzWo8NaT5kcv/ls8=
X-Google-Smtp-Source: ABdhPJz8cO+eKq5FW2Ye6/Iw3sa97S65qDsasHARTJHn9yOLMVlcBuAdlFy301s2s56d6gTUfUCS7A==
X-Received: by 2002:a17:902:cf02:b0:14d:54cf:9a6a with SMTP id i2-20020a170902cf0200b0014d54cf9a6amr3090629plg.137.1647500282760;
        Wed, 16 Mar 2022 23:58:02 -0700 (PDT)
Received: from localhost.localdomain (124x33x176x97.ap124.ftth.ucom.ne.jp. [124.33.176.97])
        by smtp.gmail.com with ESMTPSA id s21-20020a63dc15000000b00378c9e5b37fsm4083638pgg.63.2022.03.16.23.58.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Mar 2022 23:58:02 -0700 (PDT)
Sender: Vincent Mailhol <vincent.mailhol@gmail.com>
From:   Vincent Mailhol <mailhol.vincent@wanadoo.fr>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H . Peter Anvin" <hpa@zytor.com>
Cc:     linux-kernel@vger.kernel.org,
        Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Nick Desaulniers <ndesaulniers@google.com>
Subject: [RESEND PATCH v2] x86/bug: __WARN_FLAGS: prevent shadowing by renaming local variable f to __flags
Date:   Thu, 17 Mar 2022 15:57:43 +0900
Message-Id: <20220317065743.8467-1-mailhol.vincent@wanadoo.fr>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220303110755.24147-1-mailhol.vincent@wanadoo.fr>
References: <20220303110755.24147-1-mailhol.vincent@wanadoo.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The macro __WARN_FLAGS() uses a local variable named "f". This being a
common name, there is a risk of shadowing other variables.

For example:

| In file included from ./include/linux/bug.h:5,
|                  from ./include/linux/cpumask.h:14,
|                  from ./arch/x86/include/asm/cpumask.h:5,
|                  from ./arch/x86/include/asm/msr.h:11,
|                  from ./arch/x86/include/asm/processor.h:22,
|                  from ./arch/x86/include/asm/timex.h:5,
|                  from ./include/linux/timex.h:65,
|                  from ./include/linux/time32.h:13,
|                  from ./include/linux/time.h:60,
|                  from ./include/linux/stat.h:19,
|                  from ./include/linux/module.h:13,
|                  from virt/lib/irqbypass.mod.c:1:
| ./include/linux/rcupdate.h: In function 'rcu_head_after_call_rcu':
| ./arch/x86/include/asm/bug.h:80:21: warning: declaration of 'f' shadows a parameter [-Wshadow]
|    80 |         __auto_type f = BUGFLAG_WARNING|(flags);                \
|       |                     ^
| ./include/asm-generic/bug.h:106:17: note: in expansion of macro '__WARN_FLAGS'
|   106 |                 __WARN_FLAGS(BUGFLAG_ONCE |                     \
|       |                 ^~~~~~~~~~~~
| ./include/linux/rcupdate.h:1007:9: note: in expansion of macro 'WARN_ON_ONCE'
|  1007 |         WARN_ON_ONCE(func != (rcu_callback_t)~0L);
|       |         ^~~~~~~~~~~~
| In file included from ./include/linux/rbtree.h:24,
|                  from ./include/linux/mm_types.h:11,
|                  from ./include/linux/buildid.h:5,
|                  from ./include/linux/module.h:14,
|                  from virt/lib/irqbypass.mod.c:1:
| ./include/linux/rcupdate.h:1001:62: note: shadowed declaration is here
|  1001 | rcu_head_after_call_rcu(struct rcu_head *rhp, rcu_callback_t f)
|       |                                               ~~~~~~~~~~~~~~~^

This patch renames the variable from f to __flags (with two underscore
prefixes as suggested in the Linux kernel coding style [1]) in order
to prevent collisions.

[1] Linux kernel coding style, section 12) Macros, Enums and RTL,
paragraph 5) namespace collisions when defining local variables in
macros resembling functions
https://www.kernel.org/doc/html/latest/process/coding-style.html#macros-enums-and-rtl

Fixes: bfb1a7c91fb7 ("x86/bug: Merge annotate_reachable() into_BUG_FLAGS() asm")
Acked-by: Josh Poimboeuf <jpoimboe@redhat.com>
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
Signed-off-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
---
Changelog:

v1 -> v2:

   * Update the reference link to the kernel documentation to latest version.
   * Do not break the Fixes: tag to a new line.
   * Added the Acked-by and Reviewed-by tags.
---
 arch/x86/include/asm/bug.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/bug.h b/arch/x86/include/asm/bug.h
index bab883c0b6fe..66570e95af39 100644
--- a/arch/x86/include/asm/bug.h
+++ b/arch/x86/include/asm/bug.h
@@ -77,9 +77,9 @@ do {								\
  */
 #define __WARN_FLAGS(flags)					\
 do {								\
-	__auto_type f = BUGFLAG_WARNING|(flags);		\
+	__auto_type __flags = BUGFLAG_WARNING|(flags);		\
 	instrumentation_begin();				\
-	_BUG_FLAGS(ASM_UD2, f, ASM_REACHABLE);			\
+	_BUG_FLAGS(ASM_UD2, __flags, ASM_REACHABLE);		\
 	instrumentation_end();					\
 } while (0)
 
-- 
2.34.1

