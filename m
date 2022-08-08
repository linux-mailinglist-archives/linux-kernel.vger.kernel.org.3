Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A60A58BE64
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Aug 2022 02:13:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230035AbiHHAM4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Aug 2022 20:12:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbiHHAMx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Aug 2022 20:12:53 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED5AE2AD2
        for <linux-kernel@vger.kernel.org>; Sun,  7 Aug 2022 17:12:52 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id f22so9462665edc.7
        for <linux-kernel@vger.kernel.org>; Sun, 07 Aug 2022 17:12:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=00yvW9ypMxDxxH8kNSsUvDFZbWzznyVK2jXU6lzwbiw=;
        b=h3kYla/kRBRK08vrh/tsKWuzkGdegaVz9qcbfa/G+wGFrEZrSDliulfQGC6NCHwdRz
         Znr8X0aX8siaSB3gF6mls/sO8AbpAzMftvZ8cEN+QhNl8vySztRfx21FVW3hWlRdurN0
         Y48xQbiK12ePEOG4qi4un4LD1Fpm1qPAgnQGE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=00yvW9ypMxDxxH8kNSsUvDFZbWzznyVK2jXU6lzwbiw=;
        b=Eo7t+L9GLIoYQSUSvnKjh7+XfEsJ70XdWUCiL/T4nI4tzriq8t+l7shrBzQDqZe72O
         ysmtNdzbUB21E8XfmWHJcrIWR+ZfaFhnm4iYkGYQFAb/9vUJE05sdqcsGdzkXSmnbYB5
         xSQ5/Cmo2AKcY8tWxmpejGsS7j1uUzwylXBq+Hw0efWsXjUu+BgyPn77KAtLR+R4acDR
         1llckDz4k348H6hhq79/AqeYYqnZd8AYyPnZg5hI52q5aBS0M7EM6FqGRFeAqkZ4s4ox
         ckx4zLsuDlOk5957siKzPMcmyF/sIUuFKOkKZyULTcpe6nc484auSWBSYStgm+oVDjZv
         8gJg==
X-Gm-Message-State: ACgBeo3wMYVP4VQEAjavdpLejAYDPPgU5BhNhJOXHCtn0yVPIcrs9QBT
        8NB81aW8GadHK6NssJKtnMyxJXUWMMD0tOgg
X-Google-Smtp-Source: AA6agR6F3rTzaFW9oMz9QvHe3JW5ZUy46cxOH6O9AtkWI5tqRqKWAut0DxnR9M//1f6Zr07Z2+c7vQ==
X-Received: by 2002:a05:6402:34cf:b0:43d:96fd:bdfa with SMTP id w15-20020a05640234cf00b0043d96fdbdfamr15793030edc.40.1659917570782;
        Sun, 07 Aug 2022 17:12:50 -0700 (PDT)
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com. [209.85.221.49])
        by smtp.gmail.com with ESMTPSA id lb6-20020a170907784600b0072b13ac9ca3sm4310604ejc.183.2022.08.07.17.12.49
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 07 Aug 2022 17:12:50 -0700 (PDT)
Received: by mail-wr1-f49.google.com with SMTP id z16so9107314wrh.12
        for <linux-kernel@vger.kernel.org>; Sun, 07 Aug 2022 17:12:49 -0700 (PDT)
X-Received: by 2002:a5d:638b:0:b0:220:6e1a:8794 with SMTP id
 p11-20020a5d638b000000b002206e1a8794mr10148392wru.193.1659917569541; Sun, 07
 Aug 2022 17:12:49 -0700 (PDT)
MIME-Version: 1.0
References: <20220805022940.1637978-1-yury.norov@gmail.com>
In-Reply-To: <20220805022940.1637978-1-yury.norov@gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 7 Aug 2022 17:12:33 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiEVFpiC5M1-zo9Q47uwP+XaCv2rVXan51Ot7L=UXMs7A@mail.gmail.com>
Message-ID: <CAHk-=wiEVFpiC5M1-zo9Q47uwP+XaCv2rVXan51Ot7L=UXMs7A@mail.gmail.com>
Subject: Re: [GIT PULL] Bitmap patches for v6.0-rc1
To:     Yury Norov <yury.norov@gmail.com>
Cc:     linux-kernel@vger.kernel.org
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

On Thu, Aug 4, 2022 at 7:29 PM Yury Norov <yury.norov@gmail.com> wrote:
>
>   https://github.com/norov/linux.git/ tags/bitmap-6.0-rc1

Grr.

So I delayed this because I was anticipating pain, but it was worse
than expected.

I think I've sorted things out, but part of sorting things out was to
just basically undo this:

>       lib/bitmap: change type of bitmap_weight to unsigned long

which just was pointless and the explanation for it didn't match what it did.

The explanation was "unsigned makes sense". Ok.

But what it *did* was not to make the return value unsigned, but to
also expand it from "int" to "long".

That did *not* make sense, and caused pointless changes to printf strings.

And - surprise surprise - new users had come in since, so there would
have been even *more* pointless changes to printf strings just to
resolve those.

So I basically undid almost all of it. I did leave the "unsigned"
part, but removed the "long" part, so at least the printf strings
noise didn't happen.

That still caused the type clash in the 'min()' in the
mellanox/mlx4/fw.c file, but at least I couldn't find any new cases of
that pattern, so it seemed acceptable.

Can bitmap sizes in theory be "unsigned long" bits and thus have
"weight" not fit in "int"? Yes. But it's not a realistic concern, I
feel, and I really really didn't want to deal with this pointless
churn.

And honestly, this was enough churn that I seriously just considered
throwing the whole pull request away.  And I feel like I will have to
do a few other architecture tests too before I actually push this out,
so I may end up still doing that if that shows something else wrong.

So for any future pull requests, please

 (a) make them more targeted

 (b) avoids things like that return value change that clearly was just
churn and affected random files in the tree

because right now I'm left with a "never again" feeling about this all.

                Linus
