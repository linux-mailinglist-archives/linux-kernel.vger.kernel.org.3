Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C789759EAB6
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 20:14:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233478AbiHWSLt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 14:11:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231338AbiHWSLZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 14:11:25 -0400
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70FCA90815
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 09:23:09 -0700 (PDT)
Received: from zn.tnic (p200300ea971b9893329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ea:971b:9893:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 7586E1EC068B;
        Tue, 23 Aug 2022 18:23:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1661271784;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=2YdN7I7EJkAjB7pRvLwBmHF9rFEsbFHXYh/pr0t1L0M=;
        b=kKohZL3GTd4xwIo/TOImx2hDG3yPJrGf2P3IhJjAslpJz1hrhr8629stu026rh9U17pmvH
        LfsMlcMORzLuwANlJ4qt5A2fs51SzvyT+mRkb3g42O35OpY9xlwAo/pgXZaueeD5wWPT+w
        2i/yadC/ub1nzjT80dmwNTMF0MZfdkU=
Date:   Tue, 23 Aug 2022 18:23:00 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Tom Rix <trix@redhat.com>, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, David Howells <dhowells@redhat.com>,
        Jan Beulich <JBeulich@suse.com>,
        Christophe Jaillet <christophe.jaillet@wanadoo.fr>,
        Joe Perches <joe@perches.com>,
        Josh Poimboeuf <jpoimboe@kernel.org>
Subject: Re: [PATCH v5 2/2] x86/asm/bitops: __ffs,ffz: use __builtin_ctzl to
 evaluate constant expressions
Message-ID: <YwT+5GGCOKoTjfQZ@zn.tnic>
References: <20220511160319.1045812-1-mailhol.vincent@wanadoo.fr>
 <20220812114438.1574-1-mailhol.vincent@wanadoo.fr>
 <20220812114438.1574-3-mailhol.vincent@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220812114438.1574-3-mailhol.vincent@wanadoo.fr>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 12, 2022 at 08:44:38PM +0900, Vincent Mailhol wrote:
> __ffs(x) is equivalent to (unsigned long)__builtin_ctzl(x)

Are you sure about this?

My gcc documentation says:

"Built-in Function: int __builtin_ctz (unsigned int x)

    Returns the number of trailing 0-bits in x, starting at the least significant bit position. If x is 0, the result is undefined."

Note the undefined part.

Also,

__builtin_ctzl(0): 0x40
ffs(0): 0x0

I'm using the kernel ffs() version in a small program which is basically
a wrapper around BSF.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
