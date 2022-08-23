Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EDAB59F008
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Aug 2022 01:57:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229746AbiHWX50 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 19:57:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230511AbiHWX5X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 19:57:23 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98FAD8B98C
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 16:57:20 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id w19so30470114ejc.7
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 16:57:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=Lf1dHLfCJkniP1F19KAz5wBeVklkXqAiGejB+yACP9k=;
        b=dYoXe8vfvQri/po+bSqBEb/KQFriWQKqlH2yM2VuMcR5VInZ6ZujupYWaJ0WCntdeE
         HaW/6djWwopArJVgxxIn/Vu8lYy3I9bKqVKjHR6vZN0Qm21Zl9zeqokkNjXRmxPyxOYZ
         C8RUX14HMqyDeab31qDEUDw/TrFPxn+qK1VfA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=Lf1dHLfCJkniP1F19KAz5wBeVklkXqAiGejB+yACP9k=;
        b=Twu9AQqZAE/6xv3vR2BAlyrLeiqoFKDCTuP49OBWWR/ikpQhtcic1XPoWnXdZGdRYZ
         I13i4RBPhlKrfj4RYDeMhPToJdgpaIEvq/octEi35oJKJ0Ya2Rvq8Tws4b1fhK17OWl+
         M7xvpFAAeQCLph1cCl9ojUKrg0UpSdG4OQBvsBPrra6dg5hOI0eYluJ32jO15rb3VRt2
         phEtiFgkkQIHEBAPXJjafTWrSReu0M0sPPoGqqisfgIzGSo0k/EYR0lHWjpVG58g/itF
         H9fjYGcS+pNEDcpVLNkI7N2E8stpkDA+NoF7/ZuNR1FFbgQe5160lEEp4NtD/S7/xlqn
         H+yw==
X-Gm-Message-State: ACgBeo1R8iLTybBymgGVLpSYs+s7SuU8HNiCADMbXgCOVAkZpj9eNLqf
        SHHk1Y/m84ST4jxRYLLKIC9Dw2MjY7c3tsEn
X-Google-Smtp-Source: AA6agR75kVqXNSD0C27oWtBpvgd5fly23IHZjAPbq/by7pyilY6yI4H6SMdlf6l9EfQESUCyiqx5Hw==
X-Received: by 2002:a17:907:2ce7:b0:73d:9028:8038 with SMTP id hz7-20020a1709072ce700b0073d90288038mr1245084ejc.273.1661299038854;
        Tue, 23 Aug 2022 16:57:18 -0700 (PDT)
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com. [209.85.221.43])
        by smtp.gmail.com with ESMTPSA id kx1-20020a170907774100b0072ffbbc3341sm403635ejc.204.2022.08.23.16.57.17
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Aug 2022 16:57:17 -0700 (PDT)
Received: by mail-wr1-f43.google.com with SMTP id e20so18290795wri.13
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 16:57:17 -0700 (PDT)
X-Received: by 2002:adf:b343:0:b0:225:1a75:2a9a with SMTP id
 k3-20020adfb343000000b002251a752a9amr14271545wrd.281.1661299036780; Tue, 23
 Aug 2022 16:57:16 -0700 (PDT)
MIME-Version: 1.0
References: <20220821000737.328590235@goodmis.org> <20220821000844.510643400@goodmis.org>
 <CAHk-=wjsxu782N0P+oMu35N7rJAOeh3buQFWJaZHZTNmVSB=3Q@mail.gmail.com>
 <5700ac75-f6a9-877e-4011-9b314f12b5ab@acm.org> <CAHk-=wjqkWEr0MRO5hWuBoTDgNUj4qQK8V_Y36et=61mdPztJw@mail.gmail.com>
 <02daa3d6-2847-d7e0-e23e-411076c6d4db@rasmusvillemoes.dk> <0163b361-14bf-7b4c-751a-14f1a004b1a9@acm.org>
 <CAHk-=wjMLb30d0WT_RyKBCX+JBkg3QQU6pCYkrV8f58Ya4Rgzw@mail.gmail.com>
In-Reply-To: <CAHk-=wjMLb30d0WT_RyKBCX+JBkg3QQU6pCYkrV8f58Ya4Rgzw@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 23 Aug 2022 16:57:00 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiwr2Ff_1SKzRkjSbNLFYfk4KurvZhLuwVuTT-m9w5_6A@mail.gmail.com>
Message-ID: <CAHk-=wiwr2Ff_1SKzRkjSbNLFYfk4KurvZhLuwVuTT-m9w5_6A@mail.gmail.com>
Subject: Re: [for-linus][PATCH 01/10] tracing: Suppress sparse warnings
 triggered by is_signed_type()
To:     Bart Van Assche <bvanassche@acm.org>,
        Al Viro <viro@zeniv.linux.org.uk>
Cc:     Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Hellwig <hch@lst.de>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Jens Axboe <axboe@kernel.dk>
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

On Tue, Aug 23, 2022 at 4:18 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> Can you try the sparse version at
>
>    git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/sparse.git
>
> which I just set up temporarily with some patches of mine.

Ugh, and while testing this with sparse, I noticed that sparse itself
got that whole 'is_signed_type()' check wrong.

The sparse fix was to remove one line of code, but that one worries
me, because that one line was clearly very intentional:

   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/sparse.git/commit/?id=7e5f1c2eba1426e414698071dd0de7d039eb385d

Adding Al, since he's actually the original source of that bitwise
code (and did a lot of other sparse code on the type handling and
preprocessor side in particular).

             Linus
