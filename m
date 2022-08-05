Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77D8F58A90E
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Aug 2022 11:54:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240475AbiHEJy0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Aug 2022 05:54:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240416AbiHEJyW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Aug 2022 05:54:22 -0400
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 015A31276C
        for <linux-kernel@vger.kernel.org>; Fri,  5 Aug 2022 02:54:19 -0700 (PDT)
Received: from zn.tnic (p200300ea971b986e329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ea:971b:986e:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 673001EC026E;
        Fri,  5 Aug 2022 11:54:14 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1659693254;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=tIfI1N0OONraULlSScaWCqIMJV2l+ByDvpkRGd3vG54=;
        b=eHl+JkodlgJQbZ2VLjg9LAOurlfEyzlBSTD9IUQWef3IoIobqpsgAeajCjP90mIZT42oOf
        VXNNB5jmdzl6HIPL60bf/lO1r6EM8VcsIbHGhm4LTRogwDB+Rh3unSxm4O7gU6xa9eJHjs
        8TewOGVhZhxc5+lJ4dl1S8TF9P9f5YQ=
Date:   Fri, 5 Aug 2022 11:54:09 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Kanna Scarlet <knscarlet@gnuweeb.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Ard Biesheuvel <ardb@kernel.org>,
        Bill Metzenthen <billm@melbpc.org.au>,
        Brijesh Singh <brijesh.singh@amd.com>,
        Joerg Roedel <jroedel@suse.de>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Michael Roth <michael.roth@amd.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Sean Christopherson <seanjc@google.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ammar Faizi <ammarfaizi2@gnuweeb.org>,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/1] x86: Change mov $0, %reg with xor %reg, %reg
Message-ID: <YuzowUBt4pTLcMRc@zn.tnic>
References: <20220804152656.8840-1-knscarlet@gnuweeb.org>
 <20220804152656.8840-2-knscarlet@gnuweeb.org>
 <Yuvrd2yWLnyxOVLU@zn.tnic>
 <20220804180805.9077-1-knscarlet@gnuweeb.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220804180805.9077-1-knscarlet@gnuweeb.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 04, 2022 at 06:08:05PM +0000, Kanna Scarlet wrote:
> Hello sir Borislav,

Please, no "sir" - just Boris or Borislav,

> Thank you for your response. I tried to find out other advantages of
> xor reg,reg on Google and found this:
> https://stackoverflow.com/a/33668295/7275114
> 
>   "xor (being a recognized zeroing idiom, unlike mov reg, 0) has some
>   obvious and some subtle advantages:
> 
>   1. smaller code-size than mov reg,0. (All CPUs)
>   2. avoids partial-register penalties for later code.
>      (Intel P6-family and SnB-family).
>   3. doesn't use an execution unit, saving power and freeing up
>      execution resources. (Intel SnB-family)
>   4. smaller uop (no immediate data) leaves room in the uop cache-line
>      for nearby instructions to borrow if needed. (Intel SnB-family).
>   5. doesn't use up entries in the physical register file. (Intel
>      SnB-family (and P4) at least, possibly AMD as well since they use
>      a similar PRF design instead of keeping register state in the ROB
>      like Intel P6-family microarchitectures.)"
> 
> Should I add all in the explanation sir?

You should try to understand what this means and write the gist of it in
your own words. This is how you can learn something.

> We also find more files to patch with this command:
> 
>    grep -rE "mov.?\s+\\$\\0\s*," arch/x86
> 
> it shows many immediate zero moves to 64-bit register in file
> arch/x86/crypto/curve25519-x86_64.c, but the next instruction may depend
> on the previous %rflags value, we are afraid to change this because
> xor touches %rflags. We will try to change it to movl $0, %r32 to
> reduce the code size.

I don't think you need to do that - you can do this one patch in order
to go through the whole process of creating and submitting a patch but
you should not go on a "let's convert everything" spree just for the
sake of it.

Because maintainers barely have time to look at patches, you don't have
to send them more when they're not really needed.

Rather, I'd suggest you go and try to fix real bugs. This has some ideas
what to do:

https://www.linux.com/news/three-ways-beginners-contribute-linux-kernel/

Looking at the kernel bugzilla and trying to understand and reproduce a
bug from there would get you a long way. And you'll learn a lot.

Also, you should peruse

https://www.kernel.org/doc/html/latest/process/index.html

which has a lot of information about how this whole community thing
works.

I sincerely hope that helps.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
