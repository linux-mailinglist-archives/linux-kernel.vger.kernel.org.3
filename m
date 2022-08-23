Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FFD459EF96
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Aug 2022 01:19:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231147AbiHWXS6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 19:18:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230316AbiHWXSz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 19:18:55 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C1396C10F
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 16:18:54 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id bj12so13293614ejb.13
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 16:18:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=hBa9qDJUyTV6Ehu6X/BwAoxzXggaaMleeqnMPZw9DiQ=;
        b=Qz1frpeISJqOpi7kKQ0gWUZJKJMN9sHyhFBsx72nR0jLL5foIzUtejoXAj40MhoWK7
         AxVf9aWJkX+29ZeR0fFlsFOhNBsUq2EJgAWUxZ8VOFYVc7avE0GNcDoPFsTa+VLAprna
         e8NNpkBL9GEhZVv1gyNs1VVlniREq9b9Wu62g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=hBa9qDJUyTV6Ehu6X/BwAoxzXggaaMleeqnMPZw9DiQ=;
        b=SieVB0jGuQD/4PxBEQZ1+xOkYWfWdSZ7EalzGYWtYjj80S6PiVlDvoBNZyA/MyNURI
         dKhMOJ6iS1cYo2BywgxzUYZzxsjEWCSVWhYpfGFs1tRjvoCCUgJdoukG2xHyow4/7cv8
         DF+TM2Yx+/yblWSTPkcZ6ba/yOKRGmzIfDWVSE0ahZWQ8uxCMzsFniUiM+KiJ1QxfV87
         2MM4HwtgTatMcRaeX2rn6GvqazPpOkwVCEm4PZkV4rnEpfJYgpTulEia0lnzNFqyb+vd
         Q0AQf2jh5WMz2GkIh48vDdTvKxCPxkMk4cSetV/nWqHhHxaZQ9yXmGPS6EzxbXQwCBly
         DAdg==
X-Gm-Message-State: ACgBeo3AnU+3is4mJvLuDbLSFgFHYDlw2adtaYO/myfIaGT18s6FwCJz
        7+OOefHdrb0YShjL8rxKAl8VQmcyC8JrbQhm
X-Google-Smtp-Source: AA6agR7fof6/NlrmXHzgZ42b5+7OqkH80XlP3v4DKAhcKHj/tVf+gfe250BH1B7cdnW7/8RWCg9zpA==
X-Received: by 2002:a17:907:7610:b0:73d:afe8:9837 with SMTP id jx16-20020a170907761000b0073dafe89837mr1177940ejc.606.1661296732645;
        Tue, 23 Aug 2022 16:18:52 -0700 (PDT)
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com. [209.85.221.47])
        by smtp.gmail.com with ESMTPSA id gn36-20020a1709070d2400b00738467f743dsm467853ejc.5.2022.08.23.16.18.51
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Aug 2022 16:18:51 -0700 (PDT)
Received: by mail-wr1-f47.google.com with SMTP id h5so17912973wru.7
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 16:18:51 -0700 (PDT)
X-Received: by 2002:adf:e843:0:b0:225:221f:262 with SMTP id
 d3-20020adfe843000000b00225221f0262mr14764393wrn.193.1661296730943; Tue, 23
 Aug 2022 16:18:50 -0700 (PDT)
MIME-Version: 1.0
References: <20220821000737.328590235@goodmis.org> <20220821000844.510643400@goodmis.org>
 <CAHk-=wjsxu782N0P+oMu35N7rJAOeh3buQFWJaZHZTNmVSB=3Q@mail.gmail.com>
 <5700ac75-f6a9-877e-4011-9b314f12b5ab@acm.org> <CAHk-=wjqkWEr0MRO5hWuBoTDgNUj4qQK8V_Y36et=61mdPztJw@mail.gmail.com>
 <02daa3d6-2847-d7e0-e23e-411076c6d4db@rasmusvillemoes.dk> <0163b361-14bf-7b4c-751a-14f1a004b1a9@acm.org>
In-Reply-To: <0163b361-14bf-7b4c-751a-14f1a004b1a9@acm.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 23 Aug 2022 16:18:34 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjMLb30d0WT_RyKBCX+JBkg3QQU6pCYkrV8f58Ya4Rgzw@mail.gmail.com>
Message-ID: <CAHk-=wjMLb30d0WT_RyKBCX+JBkg3QQU6pCYkrV8f58Ya4Rgzw@mail.gmail.com>
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
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 23, 2022 at 3:05 PM Bart Van Assche <bvanassche@acm.org> wrote:
>
> Thank you Rasmus for having shared this information. Since sparse will
> have to be modified anyway, how about extending it such that the bitwise
> attribute can be removed from a type, e.g. via a new no_bitwise
> attribute?

I think it's actually easier to just make sparse happy.

Can you try the sparse version at

   git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/sparse.git

which I just set up temporarily with some patches of mine. It also
makes that '__cond_acquires' thing work that refcount_dec_and_lock()
uses.

It does require that kernel change to make

  #define is_signed_type(type)   (((type)(-1)) <= (type)0)

in both places, since only "no bits set" and "all bits set" are
special values for bitwise types.

Those patches of mine are fairly hacky, and I think Luc would probably
do it differently, but apart from the very last one, they aren't
actively disgusting.

                Linus
