Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3B6A4C1C71
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Feb 2022 20:44:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244263AbiBWToY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Feb 2022 14:44:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232716AbiBWToW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 14:44:22 -0500
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 357DE4B1F1
        for <linux-kernel@vger.kernel.org>; Wed, 23 Feb 2022 11:43:54 -0800 (PST)
Received: by mail-lf1-x130.google.com with SMTP id m14so115058lfu.4
        for <linux-kernel@vger.kernel.org>; Wed, 23 Feb 2022 11:43:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lcNMst0UtIIGTrfKlSB18fVQhR1XRnA2VRStjFBcviA=;
        b=b42PLZZQu9TR/e6z+rtFw5EwCBoE6Ht0Icmx6W28a7H1D4c1NXmgInCcwFjaCICZs5
         zgMHbLyHK+XhlgySxDTEuGmCb3rFZNGSid3PLc116Z4Oo0NB/TxaimYCEj656ZO9sHpp
         t0PSdPHWlcyizfty7QJRNMUTq6t/72ShzomwQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lcNMst0UtIIGTrfKlSB18fVQhR1XRnA2VRStjFBcviA=;
        b=O+iU40tJBADNHjA7f71pAsE4xQ0bdOsnpZq0l+enBRY4k43BoIKNWYe5inmut4PzUc
         u1wilpyRAe6CoPnv2HSAOzYakDRjX1iSJt7BDkECRXPiCk/lVSMwQM3hRyre0RStTbg0
         bGAcnGaNvKEpvmEC6mZFy/1ZZA215RnMZLpMf38lC7xypm0boWJpyMPLcb1jX07elCSw
         jxbascK+a4k3yAmnhydQx5U/2Ffgxe4iqxL61SzAA+Y3W/OhlBxySsm8F2Cw0A7Fwdum
         Pb3uT5bn8UvIWTEgfmjYjg2x2OGHwPfGlhwEPW7jgf2KVKyVz8CIzWNwvMfXuu84Mp6I
         P69Q==
X-Gm-Message-State: AOAM530ZcTLjeeeY4NgHMQwdaiB3dLdZE8KAzHDUAIAGHeR0+2mUgfAv
        /Nt1FLwIpZny7l+xpdM6+1mLf6GPlfr3VnwIa88=
X-Google-Smtp-Source: ABdhPJw7UM+GANUhIGS6Eco+57B8rCe5UWf2vR8mdUipvlO9zNAqb0L1DkScZRNMtOyI6XAw98AiqA==
X-Received: by 2002:ac2:5bc7:0:b0:442:c31e:876a with SMTP id u7-20020ac25bc7000000b00442c31e876amr802063lfn.382.1645645432245;
        Wed, 23 Feb 2022 11:43:52 -0800 (PST)
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com. [209.85.167.43])
        by smtp.gmail.com with ESMTPSA id b16sm72298ljp.81.2022.02.23.11.43.49
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Feb 2022 11:43:50 -0800 (PST)
Received: by mail-lf1-f43.google.com with SMTP id j15so56369lfe.11
        for <linux-kernel@vger.kernel.org>; Wed, 23 Feb 2022 11:43:49 -0800 (PST)
X-Received: by 2002:a05:6512:e8a:b0:443:7b8c:579a with SMTP id
 bi10-20020a0565120e8a00b004437b8c579amr761643lfb.687.1645645429589; Wed, 23
 Feb 2022 11:43:49 -0800 (PST)
MIME-Version: 1.0
References: <20220217184829.1991035-1-jakobkoschel@gmail.com>
 <20220217184829.1991035-4-jakobkoschel@gmail.com> <CAHk-=wg1RdFQ6OGb_H4ZJoUwEr-gk11QXeQx63n91m0tvVUdZw@mail.gmail.com>
 <6DFD3D91-B82C-469C-8771-860C09BD8623@gmail.com> <CAHk-=wiyCH7xeHcmiFJ-YgXUy2Jaj7pnkdKpcovt8fYbVFW3TA@mail.gmail.com>
 <CAHk-=wgLe-OSLTEHm=V7eRG6Fcr0dpAM1ZRV1a=R_g6pBOr8Bg@mail.gmail.com>
In-Reply-To: <CAHk-=wgLe-OSLTEHm=V7eRG6Fcr0dpAM1ZRV1a=R_g6pBOr8Bg@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 23 Feb 2022 11:43:33 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjspvG4styOAbsa0jdc13+1V9bFYr=Ga3nk_BwvcMv5Xw@mail.gmail.com>
Message-ID: <CAHk-=wjspvG4styOAbsa0jdc13+1V9bFYr=Ga3nk_BwvcMv5Xw@mail.gmail.com>
Subject: Re: [RFC PATCH 03/13] usb: remove the usage of the list iterator
 after the loop
To:     Jakob <jakobkoschel@gmail.com>, Arnd Bergmann <arnd@arndb.de>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        Mike Rapoport <rppt@kernel.org>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Brian Johannesmeyer <bjohannesmeyer@gmail.com>,
        Cristiano Giuffrida <c.giuffrida@vu.nl>,
        "Bos, H.J." <h.j.bos@vu.nl>
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

On Wed, Feb 23, 2022 at 11:23 AM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> That said, we seem to only have two cases of it in the kernel, at
> least by a x86-64 allmodconfig build.

No, there's more of them, it's just that the build broke early enough
that I didn't see it.

Doing

        git grep '\(\(~0\)\|\(-1\)\) <<'

finds a number of them. Some of them have casts in front, so they
wouldn't necessarily trigger this issue, but it's not an entirely
uncommon pattern.

And as mentioned, I think it's a *good* pattern, in that it takes
advantage of the sign-extension of the top bit in any widening use,
when the type might not be obvious (in macros, or when accessing
members of unions or structures, or when using typedefs that hide the
actual type).

So I still think that warning is actively detrimental, and I'm
wondering why it was added (and why 'gnu99' enables it, but 'gnu89'
does not). There's presumably _some_ reason.

              Linus
