Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 331904FA0CA
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Apr 2022 02:48:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234898AbiDIAuh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 20:50:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbiDIAud (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 20:50:33 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 245092BC5
        for <linux-kernel@vger.kernel.org>; Fri,  8 Apr 2022 17:48:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649465307;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=zgnD5jHYKZrgrF8zW8oGxfRV8nb6Mea8Fv8VwrW84UA=;
        b=AylK38QLrb6etyZkut7xuZEzZhBvAK/eMo1kVeMv9Jd0LLeBWXvvI1kNQ2MV4owBVYok0r
        o0HZ02NPke5FKjkeMcfrpBZNZiJhlbBFkTgJkHw48O0aEhkXbk85mHmTivehNKgm8M0zIb
        iILkjdC1L1kCwkaDdk4YIx9aWf5cHUo=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-202-KLPYzaztNjmSc6iDWuY_yA-1; Fri, 08 Apr 2022 20:48:26 -0400
X-MC-Unique: KLPYzaztNjmSc6iDWuY_yA-1
Received: by mail-qk1-f198.google.com with SMTP id m23-20020a05620a221700b006809e1fa4fdso4577231qkh.6
        for <linux-kernel@vger.kernel.org>; Fri, 08 Apr 2022 17:48:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=zgnD5jHYKZrgrF8zW8oGxfRV8nb6Mea8Fv8VwrW84UA=;
        b=jtzPsKKxES3/Q8z/S43MqfIbtop4XEnQPrVkz653KVs8+4UpHZTGc4GMMZELQBD19l
         z1v4y8uzrxTAvnNznuX76DMd/3egkx4RB+PSTWcrSiMPP7tun4zSUe86cn69WSFPrFcX
         wbqIbY8lOWXjIv+7xVdGOum7Ej8qjws1HsdECJ1Jw73Zx5S3dr2To49mN8gYGTFv6JK7
         c+yWIeb0y1a4CAweKlh8KlBnhrW2ZlHVo007r8uJsM73cs1DggWjKlNZNtwipXNEcoSO
         yq86lZYtuSMdMcg5V2K4DBULw4rDzHhe6SKpRj2aMNKB2r++1bUxe1HoR8z5Jfsaa8t9
         Udlw==
X-Gm-Message-State: AOAM533eYm0L/KI0DuOl2lAC/AbzAIw12SM9xB5X84RUgd1AVy0ElbRM
        UZZ9/p3dMrXo+1rSWTckBHHcJ9Xl6f87HRnJo1CH0XYJa39oa73lclZK8chgcTYiO+D2w/aiVQa
        qFyutRtLreimFmvJKyqWxvDEI
X-Received: by 2002:ae9:f448:0:b0:67e:1929:1782 with SMTP id z8-20020ae9f448000000b0067e19291782mr15011038qkl.578.1649465305553;
        Fri, 08 Apr 2022 17:48:25 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwv6XlsFAyDXsx6nZShvuzF5JD529VISh/GDOhkmQB5J7xnyB1/WMtV9OTZ6+zDJO52KeXsjg==
X-Received: by 2002:ae9:f448:0:b0:67e:1929:1782 with SMTP id z8-20020ae9f448000000b0067e19291782mr15011024qkl.578.1649465305245;
        Fri, 08 Apr 2022 17:48:25 -0700 (PDT)
Received: from treble ([2600:1700:6e32:6c00::15])
        by smtp.gmail.com with ESMTPSA id o3-20020a05622a008300b002e06a103476sm19723660qtw.55.2022.04.08.17.48.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Apr 2022 17:48:24 -0700 (PDT)
Date:   Fri, 8 Apr 2022 17:48:21 -0700
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Sam Ravnborg <sam@ravnborg.org>, X86 ML <x86@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Changbin Du <changbin.du@gmail.com>
Subject: Re: [PATCH] kbuild: Remove CONFIG_DEBUG_SECTION_MISMATCH
Message-ID: <20220409004821.tcztejr2cgsieqaq@treble>
References: <7fad83ecde03540e65677959034315f8fbb3755e.1649434832.git.jpoimboe@redhat.com>
 <CAK7LNARvFcQgEB1b0L6giwx0vD7wU9L-OZ5jvm1c5+StLjeOYQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAK7LNARvFcQgEB1b0L6giwx0vD7wU9L-OZ5jvm1c5+StLjeOYQ@mail.gmail.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 09, 2022 at 03:29:21AM +0900, Masahiro Yamada wrote:
> > But with -O2, once-called static functions are almost always inlined, so
> 
> "always inlined" per GCC manual.
>  -O2, -O3, -O3 enables  -finline-functions-called-once

Not necessarily.  The manual also says:

       -finline-functions-called-once
	   Consider all "static" functions called once for inlining into
	   their caller even if they are not marked "inline".  If a call
	   to a given function is integrated, then the function is not
	   output as assembler code in its own right.

So it "considers" inlining them, but it doesn't guarantee it.  And when
I looked at the GCC code some months ago I remember seeing a few edge
cases where it would inline.

> > its usefulness for rooting out mismatch warnings on other configs is
> > somewhere between extremely limited and non-existent.  And nowadays we
> > have build bots everywhere doing randconfigs continuously, which are
> > great for rooting out such edge cases.
> >
> > Somewhat ironically, the existence of those build bots means we get a
> > lot of unrealistic objtool warnings being reported, due to unrealistic
> > inlines caused by CONFIG_DEBUG_SECTION_MISMATCH, where the only way to
> > silence the warnings is to force a single-called function to be inlined
> > with '__always_inline'.
> >
> > So the limited, hypothetical benefit of "rooting out configs with
> > section mismatches" is outweighed by the very real downside of "adding
> > lots of unnecessary '__always_inline' annotations".
> 
> 
> I am confused with the description because
> you are talking about two different warnings.
> 
> [1]  modpost warning  (section mismatch)
> [2]  objtool warnings

It's all a bit confusing.

To clarify: in theory, the point of CONFIG_DEBUG_SECTION_MISMATCH was to
trigger more *modpost* warnings.  (It may do that, but the extra
warnings are probably not realistic.  And even if they were realistic on
some configs, they would be found by modpost warnings on those configs
found by build bots.)

But CONFIG_DEBUG_SECTION_MISMATCH is also triggering more *objtool*
warnings, which is a problem because the warnings are not realistic...

> For [1], you can add __init marker to the callers,
> and that is the right thing to do.

Yes, either add __init to the caller or remove __init from the callee.

But even if such "inlined single caller" modpost warnings correspond to
real world configs (which is very questionable) then we'd expect them to
show up in real-world randconfig bot testing, without having the need
for CONFIG_DEBUG_SECTION_MISMATCH to root out the rare edge cases.

> Is [2] caused by dead code that was not optimized out
> due to the unusual inlining decisions by the compiler ?

As Peter mentioned it was due to validation of SMAP uaccess rules.

> If the issues are all about objtool,
> "depends on !STACK_VALIDATION" might be
> an alternative approach?
> 
> config DEBUG_SECTION_MISMATCH
>            bool "Enable full Section mismatch analysis"
>            depends on CC_IS_GCC
>            depends on !STACK_VALIDATION        # do not confuse objtool

Yes, that would be another way to handle it.  Though that means the
option would effectively be dead on x86-64.

> Now that -Og was already rejected, the possible flag for building the kernel is
> -O2, O3, -Os.
> All of them enable -finline-functions-called-once.
> 
> So, there is no practical case for -fno-inline-functions-called-once
> unless we explicitly enable it.

Agreed.

> I am OK with this patch, I am still wondering if this could be useful
> to detect missing __init markers.

So there's two ways to look at this question: at a source level and at a
binary level.

At a source level, if there's a non-init function which inlines a
single-called __init function, and modpost doesn't notice it (because
the __init function doesn't access any __init symbols), then the __init
function wrongly has the __init annotation.  But calling that a bug is
very questionable, because it's not a real bug in the binary.  IMO it's
not worth worrying about, when we have real bugs to fix.

At a binary level, if there's a real section mismatch bug with a given
config, modpost will warn about it.  This option doesn't affect that.

-- 
Josh

