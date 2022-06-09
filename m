Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5439F5440A0
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 02:39:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235966AbiFIAjm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 20:39:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231579AbiFIAjl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 20:39:41 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FCDB1182E
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jun 2022 17:39:40 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id w2-20020a17090ac98200b001e0519fe5a8so19753441pjt.4
        for <linux-kernel@vger.kernel.org>; Wed, 08 Jun 2022 17:39:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:user-agent:in-reply-to:references
         :message-id:mime-version:content-transfer-encoding;
        bh=fzZbe8intrXhthn1s1bNq36n/kNKj5fAUKcD/RdB7Mc=;
        b=fVDYPTbCWFa8rRMmV83/fu1sbKOoZnDztqEPT7N63Ze0B0mGeqpoQJ+78nQzUyxrb/
         XHPlYFKJleZWIvbXKv9q4cuEZ8o4C5Q8/nUIeIa343oX0fIIASasOHxG4/nbwZK0KzSZ
         jUCH1XuPsRaWEfx01sK7ZAeRJr0SsFZy0o/VQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:user-agent:in-reply-to
         :references:message-id:mime-version:content-transfer-encoding;
        bh=fzZbe8intrXhthn1s1bNq36n/kNKj5fAUKcD/RdB7Mc=;
        b=be+pd7wjf5CxeWAam+tm2vP67Ppy5plMBe8vDyulLJTfdi/RvkqzGBIdpOeCI7ZZ0A
         TCusZUN1AK0SSU11E1X5c6CYIffuShNRBhYIucAHZHjO+Hm94+Q8N2ytnuc9sHHPm6cu
         OgIA5XKUBDIT0lBoWg7h0qICeTisocdVmlahdhza7x6OaNFVQ1iJA9PV8reY4jJcBBes
         n25W2gvViQ98De1T7yqIyCIb9XQ+zoKgIS167vw6h5XPDeHiJbahh2NM3r0RDP73y/cD
         l8HZwOZKAdkvXGcyvF+KxGKFOPZGu2LfjKABx5w3H0SYlU+uDR7mUEjn5TM7lMO1A3Nd
         TkxA==
X-Gm-Message-State: AOAM532xJ7Op9xHzvIEgcRf9Hep5/xQIeskjl9dIlT7jDwmAa2QLlpH9
        zuRZwzWClw1anRZtBtEiDKdV2w==
X-Google-Smtp-Source: ABdhPJw8x1ft0UD7NiFu5DTYUnNQadwrbj3jCLJxuYv6Ar33aZelqsGjHQVNYzru/vds8jDsIOZAKA==
X-Received: by 2002:a17:902:db06:b0:166:42b5:c827 with SMTP id m6-20020a170902db0600b0016642b5c827mr34384226plx.145.1654735179664;
        Wed, 08 Jun 2022 17:39:39 -0700 (PDT)
Received: from [127.0.0.1] (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id k16-20020aa79d10000000b0050dc7628162sm15808314pfp.60.2022.06.08.17.39.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Jun 2022 17:39:39 -0700 (PDT)
Date:   Wed, 08 Jun 2022 17:39:36 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        David Howells <dhowells@redhat.com>
CC:     Sven Schnelle <svens@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] s390: disable -Warray-bounds
User-Agent: K-9 Mail for Android
In-Reply-To: <CAHk-=wiFn-_OaWKY=nXt3YSiy=obrNoQW_u7zKO7qoArez=GUw@mail.gmail.com>
References: <20220422134308.1613610-1-svens@linux.ibm.com> <202204221052.85D0C427@keescook> <CAHk-=wjahn2fZtMxmc4D9UOUGWVws1wZ=X46jrTV=_tEpzXeoA@mail.gmail.com> <202206081404.F98F5FC53E@keescook> <CAHk-=wiFn-_OaWKY=nXt3YSiy=obrNoQW_u7zKO7qoArez=GUw@mail.gmail.com>
Message-ID: <AEEBCF5D-8402-441D-940B-105AA718C71F@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On June 8, 2022 4:59:29 PM PDT, Linus Torvalds <torvalds@linux-foundation=
=2Eorg> wrote:
>On Wed, Jun 8, 2022 at 2:33 PM Kees Cook <keescook@chromium=2Eorg> wrote:
>>
>> I and others have been working through a bunch of them, though yes,
>> they're not all fixed yet=2E I've been trying to track it here[1], but
>> many of those fixes are only in -next=2E
>
>Hmm=2E Even with that disabled, I get a few warnings I *really* would
>want to get rid of=2E

Yup! :)

>
>The one in ipuv3-crtc=2Ec seems valid about "address used as boolean is
>always true"=2E
>
>The 'dangling-pointer' warning does seem interesting, but not when the
>compiler does as bad a job as gcc seems to do=2E
>
>See the attached patch for
>
> (a) make the s390 "use -Wno-array-bounds for gcc-12" be generic
>
> (b) fix the ipuv3-crtc=2Ec one=2E IMX people?
>
> (c) disable -Wdangling-pointer entirely for now

I'll take a look; thanks! Should I send them back as a pull request?

>but that still leaves the netfs_i_context games, which gcc-12 is very
>unhappy about:

Yeah=2E Happily, this has already been solved, but it looks like David did=
n't do a pull yet for it?

https://git=2Ekernel=2Eorg/pub/scm/linux/kernel/git/dhowells/linux-fs=2Egi=
t/log/?h=3Dfscache-next


>I'd like to use something more surgical than
>CONFIG_CC_NO_ARRAY_BOUNDS, but considering the s390 issues, it may not
>even be worth it=2E Kees, just how far away are we from that being ok on
>x86-64?

For gcc's UBSAN_SHIFT (I typoed this in my first reply) bug, netdev has be=
en moving it to W=3D1 builds on a per-source basis for the moment:

https://git=2Ekernel=2Eorg/linus/e95032988053c17baf6c7e27024f5103a19a5f4a

Some discussion:
https://lore=2Ekernel=2Eorg/lkml/202205231229=2ECF6B8471@keescook/

Perhaps these could be even more carefully limited to GCC 12 only, using t=
he Kconfig you suggested?

-Kees

--=20
Kees Cook
