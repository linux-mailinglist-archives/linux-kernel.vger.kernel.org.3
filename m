Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7130B59F121
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Aug 2022 03:50:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233775AbiHXBtv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 21:49:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231280AbiHXBtr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 21:49:47 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0372399
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 18:49:45 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id t5so20191589edc.11
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 18:49:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=OHeBxohCNlHTlRjKpGtQEToB1/XBYVhvN5GGiz4x9IM=;
        b=Hqu5fj+YA5mUBXYfWLJSRQ5WIlWLSWXnoMRbUZteOGnyMP6wwBf4U1T8RCHhP3jOE7
         I7z/t/b4eUJgAyH2dTnO6LpqyzCpCnci62HLUkkNUWXDGHdHAMhR9b0zZrmNEuG3Qh/d
         tJstcZBZZgWyyWOP1/5a7S6DzyFkhfduK4IK4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=OHeBxohCNlHTlRjKpGtQEToB1/XBYVhvN5GGiz4x9IM=;
        b=P7VgRb/BS0Ex6rrgr2KgABuLisI5t6KCinpqJSpZuGL3BgI3tldr/53TSKSQqjP8dU
         0W0T04nSqswqHCFE1p+2Wqxs75ahNMOrcMmPsSb6qP39wXG8ZWgbERhXz5YiSEqP/QHZ
         6EMUAow29vcSkNbwgmEqzMIgOsZZgYzdLsCTW2jvakv8tdDVOlTbXj3/9bALgJy8ww/e
         aa+k/v1o1L7xz3HGes0UzTjD6GVg72trRWlBKUA13rAVpNS9XO2khUg4FwAs4EXgWK8E
         bRwNPmpqH4XdAUOcxMVwccPC0CAvWcei4N2fJ+SoG1xNTng1XnOzNNaBt1HXd4zYZd+j
         A20Q==
X-Gm-Message-State: ACgBeo3ALcPvOB1zgwGN6boNAxLECv7x2nEQaCzgRc/12m1In8i4HtEX
        g78HEhDXJ2vBe5mIKSqnECuKBtwWZOPJlwNd
X-Google-Smtp-Source: AA6agR48hrB3CXiH0B0015UfnvVSlP2NfKsli5jH14rkxT7PeN7MVDWqNQwupZp3WTurk9UUF+zhnA==
X-Received: by 2002:aa7:d1c9:0:b0:446:bfcd:170 with SMTP id g9-20020aa7d1c9000000b00446bfcd0170mr5687206edp.209.1661305784200;
        Tue, 23 Aug 2022 18:49:44 -0700 (PDT)
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com. [209.85.128.49])
        by smtp.gmail.com with ESMTPSA id m26-20020a056402051a00b004464c3de6dasm2200798edv.65.2022.08.23.18.49.42
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Aug 2022 18:49:42 -0700 (PDT)
Received: by mail-wm1-f49.google.com with SMTP id ay12so8042448wmb.1
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 18:49:42 -0700 (PDT)
X-Received: by 2002:a05:600c:4ece:b0:3a6:28:bc59 with SMTP id
 g14-20020a05600c4ece00b003a60028bc59mr3624697wmq.154.1661305782219; Tue, 23
 Aug 2022 18:49:42 -0700 (PDT)
MIME-Version: 1.0
References: <20220821000737.328590235@goodmis.org> <20220821000844.510643400@goodmis.org>
 <CAHk-=wjsxu782N0P+oMu35N7rJAOeh3buQFWJaZHZTNmVSB=3Q@mail.gmail.com>
 <5700ac75-f6a9-877e-4011-9b314f12b5ab@acm.org> <CAHk-=wjqkWEr0MRO5hWuBoTDgNUj4qQK8V_Y36et=61mdPztJw@mail.gmail.com>
 <02daa3d6-2847-d7e0-e23e-411076c6d4db@rasmusvillemoes.dk> <0163b361-14bf-7b4c-751a-14f1a004b1a9@acm.org>
 <CAHk-=wjMLb30d0WT_RyKBCX+JBkg3QQU6pCYkrV8f58Ya4Rgzw@mail.gmail.com> <b79c83af-e9fc-9fa0-dff7-f3a8a39887ff@acm.org>
In-Reply-To: <b79c83af-e9fc-9fa0-dff7-f3a8a39887ff@acm.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 23 Aug 2022 18:49:25 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgV1F7_ErXkXT2wd+07LJd_3Vp-yVUKLROPiEgijeoTrQ@mail.gmail.com>
Message-ID: <CAHk-=wgV1F7_ErXkXT2wd+07LJd_3Vp-yVUKLROPiEgijeoTrQ@mail.gmail.com>
Subject: Re: [for-linus][PATCH 01/10] tracing: Suppress sparse warnings
 triggered by is_signed_type()
To:     Bart Van Assche <bvanassche@acm.org>
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
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 23, 2022 at 5:09 PM Bart Van Assche <bvanassche@acm.org> wrote:
>
> I'm probably doing something wrong but even with sparse commit 658ee8e0f631
> ("unrestricted values are unrestricted even after a cast") I see warnings
> being triggered by users of the is_signed_type() macro, warnings that
> disappear if I change the definition of the is_signed_type() macro into 0:

That's the

> It does require that kernel change to make
>
>   #define is_signed_type(type)   (((type)(-1)) <= (type)0)

part I was talking about.

So your kernel side patch looks fine, except I don't think you need
the '__force' - the sparse patches in my tree should make sparse happy
about casting '-1'.

But I didn't do very much testing.

                     Linus
