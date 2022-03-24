Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59CE14E5D41
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Mar 2022 03:38:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347797AbiCXCj3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Mar 2022 22:39:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230051AbiCXCj2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Mar 2022 22:39:28 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 032FB939BC;
        Wed, 23 Mar 2022 19:37:57 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id o8so2717142pgf.9;
        Wed, 23 Mar 2022 19:37:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Wp5DLQb+USFm7mzuZJGSy8PNZhZNB0xhhfYgseM1XQI=;
        b=Iq9F7pdpJIivW9VGFcKIthMtHJeIrqCuPiUZWwhUpeM3nDHIzJsZ8KXXHmATPyZ8IT
         MB081rIQWQlxRhCAs6oQBD7HPibkl4Tmbn8T8FCTlf6+qIwJwYbaPZGne14wl5lOrKeH
         2HBef0bFJkBph0ruNxz/CEj6dEaz95PuOnL13IiUVtQ3WX/7WzriWsp5SVNLngf9OG7x
         MTr7dsggYzGzkRfDc9+Z0bV+1k+5DxgUBadV5QdccnJI4GMpfANzJ8HKPi0R2jZSdDUV
         MPkTgRXVD1/bEkvolILD8S8k47hy+YBhB6RF/oftMNaRHFMpDI5Q9lcjDzdT/7065OqP
         NoBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=Wp5DLQb+USFm7mzuZJGSy8PNZhZNB0xhhfYgseM1XQI=;
        b=1Xp+F10aezKc2pcZGI5+wzODzdiTsj/5wV14bHlyfQlGsyQuYL5re46PzaXTwJd4PR
         xHti/5yhxMzKDSv/rT2KQz2tl8+huKqorTqkl/kaTz3t1ewbEYzYyfitb0CPvbJ2Q9RA
         /T7UojCRQt+T35GXTDE67fdDWiMOYEwYgwTtHNpRdEkdK9lIKRaXVW8S7ijAD+/pc9C9
         3sS+0V3u9y0PzfbPUEi/ldlx+lDysYMVPfmlcMm/AnE8ees5k09nkOGnKTTrPBQgO4xh
         oHwt6JOVZNOIGvgXp3CNYtyHHeY7UB5wwHwiKmT/0ZsebpuqNLN8kcztJMo5GzMm47vX
         THbA==
X-Gm-Message-State: AOAM530CxTFJsmwYBJmqANCUa+TtDbOf79vu5di1/eA8Ppn0wYUXE3Sl
        lTlYi/Gqjh9e44IGQwChuVU=
X-Google-Smtp-Source: ABdhPJyjo7cx/EkAukEQF0sa32DBVqkH9XFVWcb81TCaJxBAyWXF3vM7ONa0LG9uJNUZxW6A3shpuQ==
X-Received: by 2002:a05:6a00:238f:b0:4f7:78b1:2f6b with SMTP id f15-20020a056a00238f00b004f778b12f6bmr2659743pfc.17.1648089476382;
        Wed, 23 Mar 2022 19:37:56 -0700 (PDT)
Received: from localhost.localdomain (124x33x176x97.ap124.ftth.ucom.ne.jp. [124.33.176.97])
        by smtp.gmail.com with ESMTPSA id k10-20020a056a00168a00b004f7e2a550ccsm1156587pfc.78.2022.03.23.19.37.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Mar 2022 19:37:55 -0700 (PDT)
Sender: Vincent Mailhol <vincent.mailhol@gmail.com>
From:   Vincent Mailhol <mailhol.vincent@wanadoo.fr>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H . Peter Anvin" <hpa@zytor.com>
Cc:     linux-kernel@vger.kernel.org, adobriyan@gmail.com,
        jpoimboe@redhat.com, linux-sparse@vger.kernel.org,
        llvm@lists.linux.dev, luc.vanoostenryck@gmail.com,
        nathan@kernel.org, peterz@infradead.org,
        Sasha Levin <sashal@kernel.org>,
        Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
        Charlemagne Lasse <charlemagnelasse@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>
Subject: [PATCH v3] x86/bug: __WARN_FLAGS: prevent shadowing by renaming local variable f to __flags
Date:   Thu, 24 Mar 2022 11:37:42 +0900
Message-Id: <20220324023742.106546-1-mailhol.vincent@wanadoo.fr>
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

For example, GCC would yield:

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

For reference, sparse also warns about it, c.f. [1].

This patch renames the variable from f to __flags (with two underscore
prefixes as suggested in the Linux kernel coding style [2]) in order
to prevent collisions.

[1] https://lore.kernel.org/all/CAFGhKbyifH1a+nAMCvWM88TK6fpNPdzFtUXPmRGnnQeePV+1sw@mail.gmail.com/

[2] Linux kernel coding style, section 12) Macros, Enums and RTL,
paragraph 5) namespace collisions when defining local variables in
macros resembling functions
https://www.kernel.org/doc/html/latest/process/coding-style.html#macros-enums-and-rtl

CC: Charlemagne Lasse <charlemagnelasse@gmail.com>
Fixes: bfb1a7c91fb7 ("x86/bug: Merge annotate_reachable() into_BUG_FLAGS() asm")
Acked-by: Josh Poimboeuf <jpoimboe@redhat.com>
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
Signed-off-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
---
Changelog:

v2 -> v3:

  * add a mention that sparse is warning about this too.
  c.f. https://lore.kernel.org/all/CAKwvOdmSV3Nse+tGMBXvN=QvnOs6-ODZRJB0OF5Pd6BVb-scFw@mail.gmail.com/

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

