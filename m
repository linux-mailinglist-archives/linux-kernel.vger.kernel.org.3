Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47995586180
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Jul 2022 22:57:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238455AbiGaU5k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 31 Jul 2022 16:57:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231264AbiGaU5g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Jul 2022 16:57:36 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E10CDED5
        for <linux-kernel@vger.kernel.org>; Sun, 31 Jul 2022 13:57:36 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id k26so1340264ejx.5
        for <linux-kernel@vger.kernel.org>; Sun, 31 Jul 2022 13:57:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=zHs5DigNbmFfl4ihweOFjtJBnI+LejnSW9zgoAc00WA=;
        b=grBcAk81NHh6FjeHlS8R3QpHWx7ucYh4v1m/OXvCC8U7iTniplzdCcxOs0x/e14jiL
         xeMflycY8QiWP7C8N/JDKeNRpyoi5hnaSrSRbYm7nGI/ojO3nfDPmmzYeNKm2TVagBaO
         xElrzy3VYeqvTBcPCBiYL9ZqykMuqvJwZstMY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=zHs5DigNbmFfl4ihweOFjtJBnI+LejnSW9zgoAc00WA=;
        b=RMDLAC0F+hP7R+kSJEQILJI/ACbUpt8+ftg5DrRaVLwSRlrtvs8lQ29flUhKBUXvYz
         vByJmG0c9KeVDMhn7wyATnD3wYa23Wxn2/YTOunxiw7u5glMvxeE5zNYnKp9mCj9wwUd
         nWvaQNBJT0Ppa1lEHlF1bH1yBPKwhJcjgSt7SalQFn42wcPSLdu4LDemEPf9g2gr57oX
         +UONvrNw6rGnakrJWMale95IFo3URfhTg4UrRj4asZFcFPC8Pi2R9R4J4pAP6Khs9nFl
         vzatFeq08bymRGES15e6+mF6/s1IgyipwTfo/Q3iz14eZNljoawQ/wbzgGKt+lRPwF95
         HhmQ==
X-Gm-Message-State: ACgBeo1g4+J+aBA5pK3bzEJj7UZkDyG8yvBYjRgMVk5H6+CmrnIcxO21
        Zcc3w/ooycpsol9bWe4CPgXxALq3BW4w3zXiQqA=
X-Google-Smtp-Source: AA6agR4jhhLeok6JtSYxTIgwgftTqyVaMwvOb2gKyTrqB6TyAvAFdVd4QAx82wXw79/lqO22aHwsoA==
X-Received: by 2002:a17:906:478e:b0:730:49f7:f78d with SMTP id cw14-20020a170906478e00b0073049f7f78dmr5865444ejc.42.1659301054476;
        Sun, 31 Jul 2022 13:57:34 -0700 (PDT)
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com. [209.85.128.41])
        by smtp.gmail.com with ESMTPSA id e6-20020aa7d7c6000000b0043a61f6c389sm5785379eds.4.2022.07.31.13.57.33
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 31 Jul 2022 13:57:33 -0700 (PDT)
Received: by mail-wm1-f41.google.com with SMTP id h205-20020a1c21d6000000b003a34ac64bdfso3435037wmh.1
        for <linux-kernel@vger.kernel.org>; Sun, 31 Jul 2022 13:57:33 -0700 (PDT)
X-Received: by 2002:a05:600c:3553:b0:3a3:2b65:299e with SMTP id
 i19-20020a05600c355300b003a32b65299emr9035672wmq.145.1659301052865; Sun, 31
 Jul 2022 13:57:32 -0700 (PDT)
MIME-Version: 1.0
References: <alpine.LRH.2.02.2207310703170.14394@file01.intranet.prod.int.rdu2.redhat.com>
 <CAMj1kXFYRNrP2k8yppgfdKg+CxWeYfHTbzLBuyBqJ9UVAR_vaQ@mail.gmail.com>
 <alpine.LRH.2.02.2207310920390.6506@file01.intranet.prod.int.rdu2.redhat.com>
 <alpine.LRH.2.02.2207311104020.16444@file01.intranet.prod.int.rdu2.redhat.com>
 <CAHk-=wiC_oidYZeMD7p0E-=TAuLgrNQ86-sB99=hRqFM8fVLDQ@mail.gmail.com>
 <alpine.LRH.2.02.2207311542280.21273@file01.intranet.prod.int.rdu2.redhat.com>
 <alpine.LRH.2.02.2207311639360.21350@file01.intranet.prod.int.rdu2.redhat.com>
In-Reply-To: <alpine.LRH.2.02.2207311639360.21350@file01.intranet.prod.int.rdu2.redhat.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 31 Jul 2022 13:57:16 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjA8HBrVqAqAetUvwNr=hcvhfnO7oMrOAd4V8bbSqokNA@mail.gmail.com>
Message-ID: <CAHk-=wjA8HBrVqAqAetUvwNr=hcvhfnO7oMrOAd4V8bbSqokNA@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] wait_bit: do read barrier after testing a bit
To:     Mikulas Patocka <mpatocka@redhat.com>
Cc:     Will Deacon <will@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Alan Stern <stern@rowland.harvard.edu>,
        Andrea Parri <parri.andrea@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        Akira Yokosawa <akiyks@gmail.com>,
        Daniel Lustig <dlustig@nvidia.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org
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

On Sun, Jul 31, 2022 at 1:41 PM Mikulas Patocka <mpatocka@redhat.com> wrote:
>
> -       if (!test_bit(bit, word))
> +       if (!test_bit(bit, word)) {
> +               smp_rmb();

Logically, I don't think that makes sense.

Maybe you're checking the buffer being up-to-date before you *write* to it?

So smp_rmb() seems entirely wrong.

I think it should consistently aim for just doing

        unsigned long state = smp_read_acquire(word);
        if (!(state & (1 << bit)))
                return 0;

or whatever.

We should strive to *not* add new uses of the legacy memory barriers.
They are garbage from last century when people didn't know better.

Then people learnt to use acquire and release, and things improved.
Let's live in that improved world.

                 Linus
