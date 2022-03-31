Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFD434EE368
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 23:42:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241943AbiCaVo0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 17:44:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237702AbiCaVoZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 17:44:25 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AAB123193C
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 14:42:37 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id z12so1466912lfu.10
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 14:42:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0pTTmNVMSyMEwS5OnmioHWV/+GsRtHshB4f8LSYtuCg=;
        b=driGMHbP9qKFTxECyaZVvpJZ8x5bZ6Ey0xhyyyg5776JvHRTfcpirgSjK+aO0qoqTc
         P5VwleUCiJOxq3WYLxz2p/+MtkMwHfz0KMGlI/bW7NNfYAW4lBDlAVITIECxGwaI50WS
         COG/clLaeByVaP8igQDMB4D+YZL6Uv3EQAga8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0pTTmNVMSyMEwS5OnmioHWV/+GsRtHshB4f8LSYtuCg=;
        b=M6qUAWN9pXk6n9tg1ixEkPBpNlWGID2kSq/9Pvgnmm8GQJDz+gO8iNjhc5eTrP/GKz
         CFYcXHB4WYc3Cf1a13ca27E5a7gc1T8O09J0bjE+2Ls+tLZqMjTeVFALQRhKs0PkyMNA
         KdXav+0R3dePiaUHbJEKiETTErouV2RqOSIIGdapdcEclfp30NVrMKCOmjUYzgzogn/2
         Aa5yw0GGTyJwFKYNawsY/g/5NP294yLHJfzXCqNqM3pmdK9282NbORUBP2JLEFKL6yTu
         AZAbogA7Uw7aX+AxHiIZ9AOk08C77UMdwlHvW1YL3NRLgnI/Byau2TXfbKxvrxu4SykH
         Xg8Q==
X-Gm-Message-State: AOAM53274KUwdGxT4Qn0mZvV/eO6H2wbenLVMMP5Rldn3k7xJgKUz/FX
        iA6gymcqF+uzqXWTEoXtHKt1rfPfm/dMjqU0swY=
X-Google-Smtp-Source: ABdhPJw8GYnLq1GYG+1eTnkiyp+GzPySP3zkhGGYrNZJcRhqc/UU2sQRka1hVeFkSPgKuwfxc59J4A==
X-Received: by 2002:a19:6b1a:0:b0:44a:873e:7332 with SMTP id d26-20020a196b1a000000b0044a873e7332mr12014738lfa.612.1648762955243;
        Thu, 31 Mar 2022 14:42:35 -0700 (PDT)
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com. [209.85.208.169])
        by smtp.gmail.com with ESMTPSA id f8-20020a193808000000b0044a3e963a0asm50007lfa.295.2022.03.31.14.42.34
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 31 Mar 2022 14:42:34 -0700 (PDT)
Received: by mail-lj1-f169.google.com with SMTP id c15so1489179ljr.9
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 14:42:34 -0700 (PDT)
X-Received: by 2002:a2e:9794:0:b0:249:8488:7dbd with SMTP id
 y20-20020a2e9794000000b0024984887dbdmr11564092lji.176.1648762954071; Thu, 31
 Mar 2022 14:42:34 -0700 (PDT)
MIME-Version: 1.0
References: <20220331212352.182168-1-Jason@zx2c4.com>
In-Reply-To: <20220331212352.182168-1-Jason@zx2c4.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 31 Mar 2022 14:42:17 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjZys1fehfPCF2utXb_fthJwLywKO1ZsjiK2GsDu_e7dQ@mail.gmail.com>
Message-ID: <CAHk-=wjZys1fehfPCF2utXb_fthJwLywKO1ZsjiK2GsDu_e7dQ@mail.gmail.com>
Subject: Re: [GIT PULL] random number generator fixes for 5.18-rc1
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
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

On Thu, Mar 31, 2022 at 2:24 PM Jason A. Donenfeld <Jason@zx2c4.com> wrote:
>
> PS: I noticed that for my previous pull request, in your merge commit, you
> replaced my numbered list with a bulleted list, and even went through the
> trouble of adjusting the irregular spacing caused by numbers >9. Impressed by
> this wild attention to detail, and imagining you clickity-clacking away in
> uemacs, I'll stick to hyphen-bullets now.

Heh. I just care fairly deeply about commit messages in general, and
my own in particular.

As a result, I try to make my merge messages be *somewhat* consistent
in layout, and with N different people sending my pull requests in
usually N+4 different formats, it means that I am very used to just
reformatting things so that *most* of my merges tend to follow one of
a few standard templates.

The standard templates I tend to aim for are

 (a) just regular quoted human-legible prose

 (b) bullet lists (sometimes with multiple levels of indentation)

 (c) a combination of the above: a human-readable introduction
followed by a bullet list.

 (d) Headers (eg "New drivers:", or "Fixes" vs "New code") with bullet lists

and if it's some other format I usually try to make it conform to one
of the above.

Along with just fixing typos and grammar as I find them.

And to make it even more exciting, sometimes part of it comes from the
pull request email, and another part from the signed tag.

But yeah, it does make it easier if the pull request already comes in
one of the normal formats. Then I generally just need to reflow things
for the common indentation.

But I do this _so_ much that I mostly don't even think about it any
more. I basically do it while reading the explanation. So while it
_has_ happened that I've complained about formatting, it must be
pretty egregious for me to really react.

Much more commonly I complain about people just not describing their
pull request well enough, not about some "you don't conform to the
usual formatting".

              Linus
