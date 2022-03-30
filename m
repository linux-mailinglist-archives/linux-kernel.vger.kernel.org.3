Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C55904EBACE
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 08:30:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243333AbiC3Gaw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 02:30:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231327AbiC3Gae (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 02:30:34 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39BD511C1C
        for <linux-kernel@vger.kernel.org>; Tue, 29 Mar 2022 23:28:49 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id m3so34014791lfj.11
        for <linux-kernel@vger.kernel.org>; Tue, 29 Mar 2022 23:28:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+058yQ0rk1dSz4lOGrP1Pz3rRM6fvoBLkVgOS4k3umk=;
        b=CHuPaTr7VHK4xZuxnF9F3hsYr0aHjZPaHruOVyc2QxKzUQa0aa9p0oScHfUrczNu6j
         9yH3SvjIIFljkwbchTKgwGdQ4b/iETvyDMJay5BuI1nDNDrlTotTD28NAnmKrXWUic0A
         XdQkuc6Qmcwjwzm46QNtw6BY087qsZZ43ZsEU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+058yQ0rk1dSz4lOGrP1Pz3rRM6fvoBLkVgOS4k3umk=;
        b=DtRFdCMpUvEBwqVu4JuIap/xgqkEyvrMxu3fFAj0hANHARIKNeLanyu/n/kV9PYuhi
         Hk+gbdyxrVTjaBIhF+wTsq5kK1YMZcclBskmMXadlRrgTSYBB4vvuVNc/2z/ptSPxhfh
         Ht6KH3yXZx2wFED6sgp5FEu8325WC1bJaVbmhn+afQYmbsIF86WbgYtubc3v13rRbzt4
         6xv1fu8xJEPk/s3IVM3IbfEFkhqR9Hvec68yU3pwiAuVL3JR9mfAcANK5nQI6D0LIa+P
         aXb6FALwFi7MOCv1WfHV/JUXZdqcyiy8JAd5IUIyig7IFcTKurwD+EgqvOZWins5TsIf
         3Hkg==
X-Gm-Message-State: AOAM531mgwgfme5vmN+LlLCIY0+cLmdkhkE5h8Ga89Nd2Qldej0FPGVW
        kZV1pZKWKVMMHM+hbFtJe7OquxR/mLhvzgqo
X-Google-Smtp-Source: ABdhPJyPwT0GcgqRt3bPBC/78AutTIZvuqa0SMC+hfTeQ7OfRHmbZePhVDgYKB7PGb+gn/SFQ/ZXLw==
X-Received: by 2002:a05:6512:230b:b0:44a:7d29:4636 with SMTP id o11-20020a056512230b00b0044a7d294636mr5683611lfu.307.1648621724411;
        Tue, 29 Mar 2022 23:28:44 -0700 (PDT)
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com. [209.85.208.172])
        by smtp.gmail.com with ESMTPSA id y26-20020a19915a000000b0044a0356abc4sm2219451lfj.220.2022.03.29.23.28.42
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Mar 2022 23:28:43 -0700 (PDT)
Received: by mail-lj1-f172.google.com with SMTP id q5so26322620ljb.11
        for <linux-kernel@vger.kernel.org>; Tue, 29 Mar 2022 23:28:42 -0700 (PDT)
X-Received: by 2002:a05:651c:1213:b0:247:e2d9:cdda with SMTP id
 i19-20020a05651c121300b00247e2d9cddamr5743894lja.443.1648621722263; Tue, 29
 Mar 2022 23:28:42 -0700 (PDT)
MIME-Version: 1.0
References: <20220326114009.1690-1-aissur0002@gmail.com> <2698031.BEx9A2HvPv@fedor-zhuzhzhalka67>
 <CAHk-=wh2Ao+OgnWSxHsJodXiLwtaUndXSkuhh9yKnA3iXyBLEA@mail.gmail.com>
 <4705670.GXAFRqVoOG@fedor-zhuzhzhalka67> <CAHk-=wiKhn+VsvK8CiNbC27+f+GsPWvxMVbf7QET+7PQVPadwA@mail.gmail.com>
 <CAHk-=wjRwwUywAa9TzQUxhqNrQzZJQZvwn1JSET3h=U+3xi8Pg@mail.gmail.com>
 <YkPo0N/CVHFDlB6v@zx2c4.com> <CAHk-=wgPwyQTnSF2s7WSb+KnGn4FTM58NJ+-v-561W7xnDk2OA@mail.gmail.com>
 <YkP2hKKeMeFrdpBW@zx2c4.com>
In-Reply-To: <YkP2hKKeMeFrdpBW@zx2c4.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 29 Mar 2022 23:28:26 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgtH+Nq+LSCdjS4v2=XOnL3wtO2FA5wvWu5n5imCsFFCA@mail.gmail.com>
Message-ID: <CAHk-=wgtH+Nq+LSCdjS4v2=XOnL3wtO2FA5wvWu5n5imCsFFCA@mail.gmail.com>
Subject: Re: [PATCH 4/4] file: Fix file descriptor leak in copy_fd_bitmaps()
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     Fedor Pchelkin <aissur0002@gmail.com>,
        Alexey Khoroshilov <khoroshilov@ispras.ru>,
        Eric Biggers <ebiggers@kernel.org>,
        Christian Brauner <brauner@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
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

On Tue, Mar 29, 2022 at 11:21 PM Jason A. Donenfeld <Jason@zx2c4.com> wrote:
>
> Yep, that works:

Ok, I'll apply that asap.

I think the "do this better" version is to get rid of
count_open_files() and moving all the logic into sane_fdtable_size(),
and you end up with something like this:

    static unsigned int sane_fdtable_size(struct fdtable *fdt,
unsigned int max_fds)
    {
        unsigned int i;

        max_fds = min(max_fds, fdt->max_fds);
        i = (max_fds + BITS_PER_LONG - 1) / BITS_PER_LONG;
        while (i > 0) {
                if (fdt->open_fds[--i])
                        break;
        }
        return (i + 1) * BITS_PER_LONG;
    }

but considering that I couldn't even get the simple ALIGN() in the
right place, I think going with the obvious version I should have
picked originally is the way to go..

              Linus
