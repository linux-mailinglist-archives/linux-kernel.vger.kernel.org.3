Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA2E15454C3
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 21:20:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240461AbiFITT7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 15:19:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238913AbiFITT6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 15:19:58 -0400
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4479A30B6F7;
        Thu,  9 Jun 2022 12:19:57 -0700 (PDT)
Received: by mail-io1-xd32.google.com with SMTP id n11so3275711iod.4;
        Thu, 09 Jun 2022 12:19:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=Rb9tlzPngQc+rX5AhQJTbl4RHridOOHA3gS0rkPMSlQ=;
        b=dHx5ytan2J4985qxHHdqDVe/9dP+JyQnFYBn5riww//Vkc+tYRRGhgenEkeIBkW12U
         Xr8LYFePBHLuqSyXP04xo2Fq0Tir8n+ZXwpDADc0P3TqXxTns6yncx47OqUfP2TMOZ8m
         JwwmYX4YwPkjxEsm2O7ej1PfQExr90eOsHlBZFxSJ4zmz0seGtGdKQ2lq125agXdYPyy
         785ECZQAOnYVgnERefSTIo+LJhIUZyd59en692oPlg3J8G3jrihLhcJav3tsiLgGOlBW
         GmiC2tw8aD5+NSELdrOoI7S5MUtflkFXBl0BYHMj/PlUa1RP5SQ3+jRnVTp75axb2mUw
         zcpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=Rb9tlzPngQc+rX5AhQJTbl4RHridOOHA3gS0rkPMSlQ=;
        b=jRJDrGy6+9HnrvUxY32Z09UjNsplEiNoAGRbQFO4/sSLtEfVDnPCXEIOorM2iGVZ1T
         sFWvf7Lpym3eNL8wuDJkTqOAug8/h5bcBKqEBgLMyry8SlmGTRsUJjTOL87vC7/lmCWT
         kbwR6JtcSfXDIP75aKbpv7rWlXeHzytxBKyeJRbt9K4zHPISQCgWKuB3Mq+76i0eKnVJ
         X7piND/o5ySmx5d94Pjvv7FkluXIZmUqQq2djmxyzsQFEy86HsCKh+uzpt1L/402f255
         3Uye3+7OTdPfutojQC9hyTtfPtorOxQHuSEYHz68SbyHLr6F/FYlf5T532En7TjWq1QS
         cpVw==
X-Gm-Message-State: AOAM533qosmHPzBUbr1wVmWMoa0OdWs04+avrOD1X0dALRs+WY6DzSMd
        RWFG9E8nCflcpmj6NaVLUcY0tSWYpxQ7eZczv0I=
X-Google-Smtp-Source: ABdhPJxQIfb5SR77YuXxduo6WIjttb5EcY3K/ae887uKrTTT3hC5jbTUOaeEp21OR6gIpobKTXb13WXhyjH7dwIQV48=
X-Received: by 2002:a6b:3ec4:0:b0:669:b9e6:cd97 with SMTP id
 l187-20020a6b3ec4000000b00669b9e6cd97mr524510ioa.128.1654802396611; Thu, 09
 Jun 2022 12:19:56 -0700 (PDT)
MIME-Version: 1.0
References: <CA+icZUUFdsEyNybVORm4x7_bAyoc0zTnudtNdgnTqjvbYXJRYA@mail.gmail.com>
 <CA+icZUWxyNeZnEBDpDWxGc-qJ-jHwR0rJMBhk1a8StPHRgC6qA@mail.gmail.com>
 <CA+icZUW7y3JxQ3dCB8Wy83EjEyYj7z55nFUw-kZ+V4We22HZZg@mail.gmail.com>
 <CA+icZUVyp2CdX7m72GY-=DtK9J+64uHeWPr5-cvo8haQm_4hUw@mail.gmail.com>
 <CA+icZUWiYYQbAav7VxVsT0ikqCeLckym08Au8oSeyYjvJHcNbg@mail.gmail.com>
 <CA+icZUUOQcc4uiVbv+tJzPr_ED7e4tD0u9tC8mcn2BRe3sdPAg@mail.gmail.com> <CAHk-=wiOrXUr0wqHL+hfkzGg_+b7UvtLeB=59KsX8W939bTY-A@mail.gmail.com>
In-Reply-To: <CAHk-=wiOrXUr0wqHL+hfkzGg_+b7UvtLeB=59KsX8W939bTY-A@mail.gmail.com>
Reply-To: sedat.dilek@gmail.com
From:   Sedat Dilek <sedat.dilek@gmail.com>
Date:   Thu, 9 Jun 2022 21:19:20 +0200
Message-ID: <CA+icZUUma1B8KFWF-ed9sjXH4QpCRZ+B2pON3uAFkTUs77tMzw@mail.gmail.com>
Subject: Re: [Linux v5.17.9] -Wdeprecated-declarations warnings with LLVM-14
 and OpenSSL v3.0.x
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Kees Cook <keescook@chromium.org>, keyrings@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Salvatore Bonaccorso <carnil@debian.org>,
        David Woodhouse <dwmw2@infradead.org>,
        David Howells <dhowells@redhat.com>,
        Tasmiya Nalatwad <tasmiya@linux.vnet.ibm.com>,
        James Bottomley <James.Bottomley@hansenpartnership.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 9, 2022 at 9:05 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Thu, Jun 9, 2022 at 11:41 AM Sedat Dilek <sedat.dilek@gmail.com> wrote:
> >
> > Why go back and forth... do it like Alexander the Great and the Gordian knot.
> >
> > Sword - Swash - Done.
> >
> > commit 6bfb56e93bcef41859c2d5ab234ffd80b691be35
> > "cert host tools: Stop complaining about deprecated OpenSSL functions"
>
> Well, it's not like that is the *right* fix.
>
> But I think for now, the answer is "leave it like that until we can
> just get rid of the ENGINE API entirely".
>
> I absolutely detest the "deprecation" warnings. We used to do that in
> the kernel too, and it was a complete disaster. The warnings are very
> noisy, and nobody ever cares about them, so it's simply not worth it.
>
> So we deprecated "__deprecated" in the kernel itself:
>
>   771c035372a0 deprecate the '__deprecated' attribute warnings
> entirely and for good
>
> and I don't think we should care about it when it comes to OpenSSL either.
>
> Eventually, that deprecated interface will go away entirely, and by
> then we hopefully don't care about really old openssl implementations
> and will have gotten rid of the uses.
>
> But for now, I think putting our head in the sand is actually the
> _better_ model rather than fighting some battle over old vs new
> libraries.
>
> Because sometimes, if you ignore a problem, it really does just go away.
>

To be honest: I like your approach, Linus.
Very pragma-tic.
That's why you use pragma's in your patch :-).

I invested too much of my lifetime in making things work "correctly".
And yes, it's post-rc1...

Most of the apps in the Debian world passed the OpenSSL-v3 transition.

-Sedat-

[0] https://www.youtube.com/watch?v=mVvr6PKUoEs
[1] https://release.debian.org/transitions/html/auto-openssl.html
