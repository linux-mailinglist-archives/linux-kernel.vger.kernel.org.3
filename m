Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB9A3507A83
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 21:50:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356246AbiDSTw6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 15:52:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235239AbiDSTwy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 15:52:54 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CA2C1FCC8
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 12:50:10 -0700 (PDT)
Received: from zn.tnic (p200300ea971b5839329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ea:971b:5839:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id AD73E1EC0559;
        Tue, 19 Apr 2022 21:50:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1650397804;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=HxYUB75lup5uwxCBEjUofOvHUPmIPtuLo9r8yX4GZdA=;
        b=m75cSQ2Uk8D2Okb5zyPo4a9qgp8xEbfOWQDmIeGHd7lnSawh/x1RCPBXpluxjDIKgA/3Ra
        iutNFqyaP7zG5ZiHQHBZ/QnSnwEFYaNNqiud5XuY9MYVs0w2Bmr49qyeGq+0LGLYHRuU5v
        5AXZRA81Fj2G1h4PPFjYcKEW0GX9dUg=
Date:   Tue, 19 Apr 2022 21:50:01 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        Miroslav Benes <mbenes@suse.cz>
Subject: Re: [PATCH v2] scripts: Create objdump-func helper script
Message-ID: <Yl8SaZbqXPJQyoXB@zn.tnic>
References: <fe61d8835ba60ef20920d2d0e6493748c80e4d7e.1650384661.git.jpoimboe@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <fe61d8835ba60ef20920d2d0e6493748c80e4d7e.1650384661.git.jpoimboe@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 19, 2022 at 09:12:23AM -0700, Josh Poimboeuf wrote:
> Add a simple script which disassembles a single function from an object
> file.  Comes in handy for objtool warnings and kernel stack traces.
> 
> Originally-by: Peter Zijlstra <peterz@infradead.org>
> Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
> ---
> v2:
> - require gawk
> 
>  scripts/objdump-func | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
>  create mode 100755 scripts/objdump-func

Was that supposed to be user-friendly too?

$ ./scripts/objdump-func -h
./scripts/objdump-func: line 16: $1: unbound variable

:-)


It works tho:

$ ./scripts/objdump-func vmlinux rewind_stack_and_make_dead
0000 ffffffff81001c00 <rewind_stack_and_make_dead>:
0000 ffffffff81001c00:  31 ed                   xor    %ebp,%ebp
0000 ffffffff81001c02:  65 48 8b 04 25 d0 ec 01 00      mov    %gs:0x1ecd0,%rax
0000 ffffffff81001c0b:  48 8d a0 58 ff ff ff    lea    -0xa8(%rax),%rsp
0000 ffffffff81001c12:  e8 39 24 07 00          call   ffffffff81074050 <make_task_dead>
^^^^

I guess those zeros at the beginning are supposed to mean something...

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
