Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B850657661D
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jul 2022 19:34:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230407AbiGORdy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jul 2022 13:33:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230336AbiGORdv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jul 2022 13:33:51 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB30F13DF8
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jul 2022 10:33:49 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id va17so10248466ejb.0
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jul 2022 10:33:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WfVY8tQkbJO6PFTeEdb3SLzVsb+vAJ4gu2cqddeKcwU=;
        b=WtFzaSIsuNUvPl7xOKFYOFPvsJouVmlPm4dcWspJ2KV0T8TEcZOUPwMlZTZin7eUzc
         M03B4Ba2wgC01WT86nG/RqZdmXFKRLM5KSi3IJZRPPITaaCu5osjkPul2SiUrgSPu0Ni
         WG2+1rfWIjUPk4hHmR5kQyiVAh5WGUhBY+kfY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WfVY8tQkbJO6PFTeEdb3SLzVsb+vAJ4gu2cqddeKcwU=;
        b=jzSZeztdkHvs5KJanN6uC2BtdBEUnZqkln01DmyIRYV1Pr3LUV2mwNUvmMqzk34SyB
         9qTdHwrKJQsIlENbUiYRL5ue/NiO3FD3GjA7nTZPHK8QnSO/L0n3gNDUtbdCkiewujKL
         XYTOCiwERJiHNMiItPO8ikNTCD8pwpg+rBTyQKxUsAkk8caaS/Qv97v6xT2WYZKL/ofH
         AYpMf+k1nIknFLwdowL+2S5yILcIntgUy13SJociJvs6iA8rT59L5VemWx02q9hZ+DJD
         v7YssvskL4hs95vo8XK+OCRCaushwz+rJwE1eaPZ/XVVitHrJ/uUKSzmzEme5EuDnfPC
         xycQ==
X-Gm-Message-State: AJIora+zwbp2bQWs94ERruFfk7N7ytgh4/749QLi9RTuQdmJbMLFptXW
        mqt6mSgawa4HhqR0DeagGUKXS6fDMl9fopc1O9w=
X-Google-Smtp-Source: AGRyM1toMilf4sJIqbPFE0hHKKWMuz49deOJfuqppzrjgp7pccwi97z2SEIPk6czLn6KnFRuHXwsAQ==
X-Received: by 2002:a17:907:2710:b0:72b:7f52:75da with SMTP id w16-20020a170907271000b0072b7f5275damr13889736ejk.26.1657906428040;
        Fri, 15 Jul 2022 10:33:48 -0700 (PDT)
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com. [209.85.221.44])
        by smtp.gmail.com with ESMTPSA id d21-20020a170906305500b0072ef9c18089sm1230421ejd.59.2022.07.15.10.33.47
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Jul 2022 10:33:47 -0700 (PDT)
Received: by mail-wr1-f44.google.com with SMTP id bk26so7632624wrb.11
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jul 2022 10:33:47 -0700 (PDT)
X-Received: by 2002:a5d:69c2:0:b0:21d:807c:a892 with SMTP id
 s2-20020a5d69c2000000b0021d807ca892mr13544923wrw.274.1657906426849; Fri, 15
 Jul 2022 10:33:46 -0700 (PDT)
MIME-Version: 1.0
References: <20220715140259.205ef267@canb.auug.org.au> <YtDoqhuAt6Sv6qgV@ZenIV>
 <5614fbc0-509a-6341-bef2-8857f4fe610e@kernel.dk>
In-Reply-To: <5614fbc0-509a-6341-bef2-8857f4fe610e@kernel.dk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 15 Jul 2022 10:33:30 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjzpt7T+iuOd9pDR4Mkb+2SCoxi3H2uL+DTGTX+Ur5cGw@mail.gmail.com>
Message-ID: <CAHk-=wjzpt7T+iuOd9pDR4Mkb+2SCoxi3H2uL+DTGTX+Ur5cGw@mail.gmail.com>
Subject: Re: linux-next: build failure after merge of the block tree
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Ming Lei <ming.lei@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 15, 2022 at 7:43 AM Jens Axboe <axboe@kernel.dk> wrote:
>
> On 7/14/22 10:10 PM, Al Viro wrote:
> >
> > I suspect that it would be a good idea to slap
> > #define no_llseek NULL
> > into include/linux/fs.h for the merge window, then remove it (and all
> > stray no_llseek initializers) at -rc1.  Linus, would you be OK with
> > that approach?
>
> Not Linus, but I think that's a good idea as it'll reduce the pain for
> any new users added in other trees.

Yeah, sounds fine to me too.

                   Linus
