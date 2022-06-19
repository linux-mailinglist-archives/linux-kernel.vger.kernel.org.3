Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7334550CDD
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Jun 2022 22:05:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236422AbiFSUFq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Jun 2022 16:05:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235196AbiFSUFp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jun 2022 16:05:45 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E865A18F
        for <linux-kernel@vger.kernel.org>; Sun, 19 Jun 2022 13:05:44 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id cf14so2696364edb.8
        for <linux-kernel@vger.kernel.org>; Sun, 19 Jun 2022 13:05:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Zt19NQISpOb+BzcHD03LYz1ZgRQNfJH/euUE9l640Mw=;
        b=YwlRSLHzOtRrpd2In0ezIB3k1jBosGYMZdU4texM86AzTKS9pMwdeAC0C84wKYzFdo
         sFxB84jg8b4fEufvYxxYgctOC0AkIWAp81rEooLQv0b1z1pWTA/9XWVE0I/r+qeM//ut
         1B47dfsi56vOjBDnVRI6vdX8CCRnDszEUTnkY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Zt19NQISpOb+BzcHD03LYz1ZgRQNfJH/euUE9l640Mw=;
        b=0YHhU+7f60MZqqxuqx7Pe4Aj7E4WcDm7S01gqKU0GWuoq+0UJOZ0dT1l6hkDQhbuCi
         irAOD44e7Oy1c6WvT3S9IScCxx1qaPs0Y0yke9x6nh03PY1J1Cj1KcMM/xg6OPUZiRI8
         rDokS/nJfLZUG4Mg8VTEkfT7WVU5Z77Kaey49XXFj5EndAu+jBt/+UK50gisYcNiJ0o4
         uLnEwt/fq7SVfAI9FK1/wXjkozU1PxhQ3KlRggygGwWSwqLgSWBsy8VKRBU2COlmRTSb
         tQ7OA9UJ3oPITC1iG07ukhoY4OTQpy+yJj4MU53AKQLsj0PBF2qKwd+QwSulVtofAWj4
         /Gwg==
X-Gm-Message-State: AJIora9FbWXLUd38QAPVi8EgUnveh5Jzog2lqq7JjryCQg3I4/ltBOzN
        5TY4WqRRT+J2aoxzvcApXQl+ZgAc38yHFXLx
X-Google-Smtp-Source: AGRyM1uxFPvQNqV6KB1bBCMyvW1Q31R7NWO/YUUtmhoYXViyw46OdCCNn/4+G6xVLc2KkASqYD59OQ==
X-Received: by 2002:a05:6402:538d:b0:435:7ca6:a136 with SMTP id ew13-20020a056402538d00b004357ca6a136mr4861107edb.268.1655669142425;
        Sun, 19 Jun 2022 13:05:42 -0700 (PDT)
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com. [209.85.221.44])
        by smtp.gmail.com with ESMTPSA id la24-20020a170907781800b0071c9ef22418sm4293879ejc.193.2022.06.19.13.05.40
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 19 Jun 2022 13:05:41 -0700 (PDT)
Received: by mail-wr1-f44.google.com with SMTP id n1so11771996wrg.12
        for <linux-kernel@vger.kernel.org>; Sun, 19 Jun 2022 13:05:40 -0700 (PDT)
X-Received: by 2002:a05:6000:1251:b0:21a:efae:6cbe with SMTP id
 j17-20020a056000125100b0021aefae6cbemr12958608wrx.281.1655669140264; Sun, 19
 Jun 2022 13:05:40 -0700 (PDT)
MIME-Version: 1.0
References: <165564429738.1413209.17302088152547038708.tglx@xen13>
 <165564429887.1413209.8729918730024457105.tglx@xen13> <CAHk-=wgfrUdWBXA-Jx7ZC1x3wwsomou0L6niGgpRS2Hd5rQxyg@mail.gmail.com>
 <Yq9Q84H6HIfkJpoR@zx2c4.com>
In-Reply-To: <Yq9Q84H6HIfkJpoR@zx2c4.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 19 Jun 2022 15:05:23 -0500
X-Gmail-Original-Message-ID: <CAHk-=whTg=MCBYCO_+KQ10qKYhZXKXQ=mdgLc=e2gxHwDwRBxQ@mail.gmail.com>
Message-ID: <CAHk-=whTg=MCBYCO_+KQ10qKYhZXKXQ=mdgLc=e2gxHwDwRBxQ@mail.gmail.com>
Subject: Re: [GIT pull] locking/urgent for 5.19-rc3
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
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

On Sun, Jun 19, 2022 at 11:38 AM Jason A. Donenfeld <Jason@zx2c4.com> wrote:
>
> This was initially my concern too, which I expressed to Sebastian, but
> he made the point that this area here is rather "special". Actually,
> randomness isn't really required here.

That wasn't really my point.

My point was that there are a lot of uses of prandom_u32() and friends
in random places. Just grepping for it, there's lots of different
drivers that use it. Who knows what locking they have.

Clearly nobody *thought* about it. This one issue is purely about RT
correctness, but how about all the uses that just want a pseudo-random
number and may have performance issues, or may be calling things so
much that a lock is just bad.

The thing is, that prandom code used to be FAST. Not just "no locks",
but also "fairly simple siphash round because its a PSEUDO random
thing and shouldn't be anything more".

The whole "make it use the same randomness" may just have been a huge
and fundamental mistake.

We've seen one actual outright bug because of it already. That was
easy to fix by avoiding the new thing that now was a mistake. What
about all the other uses with lock bouncing or whatever subtler issues
that aren't pointed out by outright correctness tests?

                  Linus
