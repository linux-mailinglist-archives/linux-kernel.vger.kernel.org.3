Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1758A523E72
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 22:09:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345513AbiEKUJZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 16:09:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235778AbiEKUJV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 16:09:21 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5935B73544
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 13:09:20 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1652299758;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=a7NawlKYu3QodR35FTRzKw5nCCPq3TD4KSebWdKcyUQ=;
        b=UCJy6hzaYRsCePyxYTKoqSPy/eU76DBtKjgBlQViGRhYk+RyKQMHzirUQTZJReKrek4Zv1
        AuxcBooAjPvk3IQFtipJXU2yJe63ZsRDH6K0kP/216+1TUnkFP+95k/Pt8ypv0kaPnj0Mg
        WnkoRSxE5N/51xY3YCA8PW2HHwD6kXqxeTlkPOAdiLFo3cEaRPZAsDTWRFwcGQB7Nne/lR
        362MJRSGvpMapeU/75NYRYJdMbD5V6gy3cKLmeuTomlD910O6PWbtD8LhnQ2ZUxAIwpSQl
        l1c3DEpC8iY3VdPr2pysLdHsoTQ4I1FhLl8X7AONGYvvlrG5bN9YvcOmELC4Fg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1652299758;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=a7NawlKYu3QodR35FTRzKw5nCCPq3TD4KSebWdKcyUQ=;
        b=uf5NxaIs4bnOj4TuXkHxTZTpVVAeXu4vdNYYIg8ulJy7MYbrFRtaoo4kFuqWOR6BxZ0sqy
        IJi4kfKPCG2jcZBg==
To:     Nick Desaulniers <ndesaulniers@google.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>
Cc:     linux-kernel@vger.kernel.org, Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Andy Lutomirski <luto@kernel.org>, x86@kernel.org,
        Lai Jiangshan <jiangshan.ljs@antgroup.com>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Joerg Roedel <jroedel@suse.de>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Marco Elver <elver@google.com>, Hao Luo <haoluo@google.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: Re: [PATCH 1/7] x86/entry: Introduce __entry_text for entry code
 written in C
In-Reply-To: <CAKwvOdmF_5KudQbC8j5hJT1CqxvYtMneZxb1Si3A2uNxopk3yQ@mail.gmail.com>
References: <20220511072747.3960-1-jiangshanlai@gmail.com>
 <20220511072747.3960-2-jiangshanlai@gmail.com>
 <CAKwvOdmF_5KudQbC8j5hJT1CqxvYtMneZxb1Si3A2uNxopk3yQ@mail.gmail.com>
Date:   Wed, 11 May 2022 22:09:18 +0200
Message-ID: <87bkw3hlw1.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 11 2022 at 11:01, Nick Desaulniers wrote:
> On Wed, May 11, 2022 at 12:27 AM Lai Jiangshan <jiangshanlai@gmail.com> wrote:
>>  /* Section for code which can't be instrumented at all */
>> -#define noinstr                                                                \
>> -       noinline notrace __attribute((__section__(".noinstr.text")))    \
>> -       __no_kcsan __no_sanitize_address __no_profile __no_sanitize_coverage
>> +#define __noinstr_section(section)                             \
>> +       noinline notrace __section(section) __no_profile        \
>> +       __no_kcsan __no_sanitize_address __no_sanitize_coverage
>> +
>> +#define noinstr __noinstr_section(".noinstr.text")
>
> I haven't looked at the rest of the series, but isn't `noinstr` used
> in a bunch of places? Wont this commit break all those uses or at
> least make it break bisection?

Why so?

This is still applying all the 'no' annotations and puts the code in
the very same section as before, no?

Thanks,

        tglx


