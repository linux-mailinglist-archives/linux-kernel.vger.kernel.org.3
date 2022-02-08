Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D5B84AE461
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 23:30:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354881AbiBHW3y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 17:29:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1386641AbiBHVBS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 16:01:18 -0500
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62373C0612B8
        for <linux-kernel@vger.kernel.org>; Tue,  8 Feb 2022 13:01:16 -0800 (PST)
Received: from zn.tnic (dslb-088-067-221-104.088.067.pools.vodafone-ip.de [88.67.221.104])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id E38351EC052A;
        Tue,  8 Feb 2022 22:01:10 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1644354071;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=VSZPvJg1viGdH9o4n4cA3WjI+OUnAwPRlh9H3bwhWHk=;
        b=n7TG2dghoTq9CdmbA4/OXGTwX6C1eu0dmKOzHRcbdHcmExorJRm64OkbJ+cCJxqS9qgndY
        Lr5Bh3pZ17BkEVPvGuXizlS5OfAzvQEi7qiWbsDH0GYv8W6XOlQaY5DhItXqOLfm6Wblp5
        5EoL8u/3vYo/f+lNGB+uEwae4fMDiTY=
Date:   Tue, 8 Feb 2022 22:01:05 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Kees Cook <keescook@chromium.org>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     X86 ML <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>
Subject: Re: [PATCH v2 3/6] x86/cpu: Remove CONFIG_X86_SMAP and "nosmap"
Message-ID: <YgLaERuGcefANHNi@zn.tnic>
References: <20220127115626.14179-1-bp@alien8.de>
 <20220127115626.14179-4-bp@alien8.de>
 <202202071405.FB72C07@keescook>
 <YgKHDBvQFVJhTBzN@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YgKHDBvQFVJhTBzN@zn.tnic>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 08, 2022 at 04:06:52PM +0100, Borislav Petkov wrote:
> Hmm, I think you're right.
> 
> Mr. Z?

He says yes.

Ok, that was a good catch, thanks!

This chunk looks now like this - I'll send a new version later.

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
index 666f7bbc13eb..0fcba46fc10f 100755
--- a/scripts/link-vmlinux.sh
+++ b/scripts/link-vmlinux.sh
@@ -106,7 +106,7 @@ modpost_link()
 objtool_link()
 {
 	local objtoolcmd;
-	local objtoolopt;
+	local objtoolopt="--uaccess"
 
 	if is_enabled CONFIG_LTO_CLANG && is_enabled CONFIG_STACK_VALIDATION; then
 		# Don't perform vmlinux validation unless explicitly requested,
@@ -140,9 +140,6 @@ objtool_link()
 		if is_enabled CONFIG_RETPOLINE; then
 			objtoolopt="${objtoolopt} --retpoline"
 		fi
-		if is_enabled CONFIG_X86_SMAP; then
-			objtoolopt="${objtoolopt} --uaccess"
-		fi
 		if is_enabled CONFIG_SLS; then
 			objtoolopt="${objtoolopt} --sls"
 		fi

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
