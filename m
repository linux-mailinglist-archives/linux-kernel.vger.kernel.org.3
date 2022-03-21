Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4BAD4E30A3
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 20:17:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352519AbiCUTSy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 15:18:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244022AbiCUTSx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 15:18:53 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB25716F06E
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 12:17:26 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id 25so21226566ljv.10
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 12:17:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aFxzGpzAQGg1EGakyZS/LXoircaI04KYp45wi+/GbCQ=;
        b=MavGLUJGF5YnrI1FF05vdX2WdST/o+GU+GD0GclkvDK5kJekTuz+HWwZG77hOMfGbe
         tXReUUcfX93veYWmTFQGAbO3y10SvkBWvFMoNj2QcTMpRKj2sx/QjR/bO07uGKOUx1uH
         v/O2Pc0JyXzhgh/yeT2I22SHESPS7155zsoiw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aFxzGpzAQGg1EGakyZS/LXoircaI04KYp45wi+/GbCQ=;
        b=qpEM0V+I8XqQYca9h/l2tQJ9j16iWtNCBOCtXMCAPT5jb/0tM0OBKpWB6ROBhiOvKG
         Apd070E878l2QXC7KdXhhK1KSjSTfCLYtn7qAVd11Q+SkFaTfeUHGEBeEdzx+x1Yuj88
         enHr7ehxnS0j7ex2f9YDU1rC59QOjdGejbETkpDwFaXVLoJUasT/SHFI24NY/B4a5M1q
         A6oO3BhrBNDcYMVolHA8JT1ozrayBFEi5v1ZgXinD9kk/i1Dv3EYC4lGQWhq2glvbvCu
         9YfbQJnWOb8vl6AQYZGkwVeYOzSeDTC+oAMJ5wuzcMaiZAVXWmN9B3NiLikdbeCtVFvC
         kXKw==
X-Gm-Message-State: AOAM532Zy9lsPZsrUxNKGhFZ+ZYrA2lR0Bn3GH5xwyI/vxvSDidIeHNL
        I2asZOhwDjh9LQtk1ekcIvoow9mw+MkljCin4rw=
X-Google-Smtp-Source: ABdhPJw7G9vJqsKTi1Tu3iqUXIB+097P/oXF9GW3vZ0F0QU4t2O4sZhekJh12aADoYgSexhu2WJs1A==
X-Received: by 2002:a2e:92d5:0:b0:246:59e9:a591 with SMTP id k21-20020a2e92d5000000b0024659e9a591mr16198535ljh.1.1647890244593;
        Mon, 21 Mar 2022 12:17:24 -0700 (PDT)
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com. [209.85.167.47])
        by smtp.gmail.com with ESMTPSA id b3-20020a056512304300b004488e49f2fasm1879514lfb.129.2022.03.21.12.17.23
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Mar 2022 12:17:23 -0700 (PDT)
Received: by mail-lf1-f47.google.com with SMTP id w7so26220855lfd.6
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 12:17:23 -0700 (PDT)
X-Received: by 2002:a05:6512:b13:b0:448:90c6:dc49 with SMTP id
 w19-20020a0565120b1300b0044890c6dc49mr16158631lfu.542.1647890243315; Mon, 21
 Mar 2022 12:17:23 -0700 (PDT)
MIME-Version: 1.0
References: <164786042536.122591.4459156564791679956.tglx@xen13> <164786043041.122591.4693682080153649212.tglx@xen13>
In-Reply-To: <164786043041.122591.4693682080153649212.tglx@xen13>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 21 Mar 2022 12:17:07 -0700
X-Gmail-Original-Message-ID: <CAHk-=wg_Kyh4zVmBSc4H79jH+yv9wN7dMsf-5x=EDrORbL3fuQ@mail.gmail.com>
Message-ID: <CAHk-=wg_Kyh4zVmBSc4H79jH+yv9wN7dMsf-5x=EDrORbL3fuQ@mail.gmail.com>
Subject: Re: [GIT pull] x86/irq for v5.18-rc1
To:     Thomas Gleixner <tglx@linutronix.de>,
        "Maciej W. Rozycki" <macro@orcam.me.uk>,
        Dmitry Osipenko <dmitry.osipenko@collabora.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 21, 2022 at 4:02 AM Thomas Gleixner <tglx@linutronix.de> wrote:
>
>  - Handle the IRT routing table format in AMI BIOSes correctly

*Very* minor nit here in the hope of future cleanups: the other x86
irq routing table structions (Christ, that's a sentence that shouldn't
exist in a sane world) use "__attribute__((packed))" and this one uses
"__packed".

They are all right next to each other, maybe they could be made to
have the same syntax?

HOWEVER.

That's not what the problem with this pull is.

I pulled this and then I unpulled it.

Because that stupid IRT routing table code already been reported to cause bugs:

    https://lore.kernel.org/all/a2791312-2957-27e6-43af-c805bbb90266@collabora.com/

which seems to be because the $IRT signature check is complete garbage:

> +       for (addr = (u8 *)__va(0xf0000); addr < (u8 *)__va(0x100000); addr++) {
> +               rt = pirq_convert_irt_table(addr);
> +               if (rt)
> +                       return rt;

The above doesn't seem like it could really ever have been tested
properly, since it will walk off the end of that __va(0x100000)
address: it will walk every byte up to the 1MB physical address, and
it will try to find that $IRT signature there, but if it never finds
it, IT WILL CHECK THE SIGNATURE PAST THE 1MB mark!

So I refuse to pull this, and it should never have been sent to me,
considering that it had a known bug, and it took me only moments to
see how completely wrong that code was.

The fix seems obvious (you don't walk every byte to 1M, you walk to 1M
- the size of the struct, and then you also check that the number of
entries actually fits - Dmitry can presumably test), but no way do I
want to get this kind of clearly broken thing this merge window.

And yes, I'm unhappy. This bug was reported a week ago. This should
not have been sent to me today.

I also assume and suspect that the $IRT format isn't even used in
modern PC's, so this must be some really odd special legacy case that
very few people can care about. No?

                      Linus
