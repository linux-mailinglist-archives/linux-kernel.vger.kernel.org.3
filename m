Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D43E84AF084
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 13:01:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232025AbiBIMB1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 07:01:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232370AbiBIMBG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 07:01:06 -0500
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72C93DF48F0B
        for <linux-kernel@vger.kernel.org>; Wed,  9 Feb 2022 03:54:01 -0800 (PST)
Received: from zn.tnic (dslb-088-067-221-104.088.067.pools.vodafone-ip.de [88.67.221.104])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id F2ADB1EC056A;
        Wed,  9 Feb 2022 12:53:55 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1644407636;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=5d/dWM6NpJR/S9WWcKnf/vIfTVhWKMO4oWHdS6A/tto=;
        b=A6z6+JMC7X5AioTDEGY2H0ly3d3JG0XFW+JsX+1AsQgtjFBRK/s7l4WZI2zSJ86jGcJ4Y2
        9NjLcgyhTCAdoJHrUGP/qnzjz71G4E9viaJ+WB3PsXAcQ/PchjjVqDCmdJMyr4dvzzhiSY
        KGVMC+vJ/zEw46IJChcZup7Voxo7Sgs=
Date:   Wed, 9 Feb 2022 12:53:51 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Kees Cook <keescook@chromium.org>
Cc:     Peter Zijlstra <peterz@infradead.org>, X86 ML <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>
Subject: Re: [PATCH v2 3/6] x86/cpu: Remove CONFIG_X86_SMAP and "nosmap"
Message-ID: <YgOrT5emtH2damsR@zn.tnic>
References: <20220127115626.14179-1-bp@alien8.de>
 <20220127115626.14179-4-bp@alien8.de>
 <202202071405.FB72C07@keescook>
 <YgKHDBvQFVJhTBzN@zn.tnic>
 <YgLaERuGcefANHNi@zn.tnic>
 <202202081854.90ABA52F@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <202202081854.90ABA52F@keescook>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 08, 2022 at 06:56:40PM -0800, Kees Cook wrote:
> Cool; yeah, that's kind of what I was expecting. I have a knee-jerk "I
> don't want to touch this again later" reaction to seeing it always
> applied instead of gated by CONFIG_X86 or something, but then, I doubt
> that'll be hard to change when/if objtool becomes multi-architecture.

Yah, what I had doesn't build with 32-bit allnoconfig etc because of
CONFIG_STACK_VALIDATION=n or so. So I ended up doing, see end.

In this case, it gets set only when the earlier LTO_CLANG/STACK/VMLINUX
validation options are enabled.

We could do an is_enabled check around it but what would be the correct
criterium to enable uaccess validation?

> Consider the update as:
> 
> Reviewed-by: Kees Cook <keescook@chromium.org>

Thx.

---
diff --git a/scripts/Makefile.build b/scripts/Makefile.build
index a4b89b757287..404ea669ecca 100644
--- a/scripts/Makefile.build
+++ b/scripts/Makefile.build
@@ -233,7 +233,7 @@ objtool_args =								\
 	$(if $(CONFIG_FRAME_POINTER),, --no-fp)				\
 	$(if $(CONFIG_GCOV_KERNEL)$(CONFIG_LTO_CLANG), --no-unreachable)\
 	$(if $(CONFIG_RETPOLINE), --retpoline)				\
-	$(if $(CONFIG_X86_SMAP), --uaccess)				\
+	--uaccess							\
 	$(if $(CONFIG_FTRACE_MCOUNT_USE_OBJTOOL), --mcount)		\
 	$(if $(CONFIG_SLS), --sls)
 
diff --git a/scripts/link-vmlinux.sh b/scripts/link-vmlinux.sh
index 666f7bbc13eb..fbdb531cca18 100755
--- a/scripts/link-vmlinux.sh
+++ b/scripts/link-vmlinux.sh
@@ -140,9 +140,9 @@ objtool_link()
 		if is_enabled CONFIG_RETPOLINE; then
 			objtoolopt="${objtoolopt} --retpoline"
 		fi
-		if is_enabled CONFIG_X86_SMAP; then
-			objtoolopt="${objtoolopt} --uaccess"
-		fi
+
+		objtoolopt="${objtoolopt} --uaccess"
+
 		if is_enabled CONFIG_SLS; then
 			objtoolopt="${objtoolopt} --sls"
 		fi
-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
