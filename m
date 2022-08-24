Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD18A59F14D
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Aug 2022 04:12:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233688AbiHXCL2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 22:11:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231663AbiHXCL0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 22:11:26 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7ED325853B
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 19:11:25 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id d1so4944576edn.9
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 19:11:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=C0g7r76Av4npIvjzCVYb/bPcHGD+BQyziIjMEcxSypQ=;
        b=cUAEJn6uh5zv9UDCfh/cYTtsNLdtoNjuT4vhTLWNckO+veHri8Akk0Z8oMjLOeNAb0
         eOH0XeQX7/K8gKoUCDOT0bpJ7mOx1nC69ygkK+9ELI6DctclVslnfCOs4NGtqB3oftPk
         z4X4/KcAP3xeIrCsIWOAgTaIEKLM7MCkwRrVs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=C0g7r76Av4npIvjzCVYb/bPcHGD+BQyziIjMEcxSypQ=;
        b=QTFUOsy7orwxcvgt3inw8e9ZsAgCYBZqMbMmOozfZ1J2dKqUKeK5qzp/fkzpqaClY0
         EB9LNGXrzY3p2pd3D6NO65wqBDSelUfSEtQyzM2yW6aTYQh2IPaR99aBGex+8+S2g5uq
         Pm8cmrex8Zy3O9cCaL84HifsOL4XAVo+DdCrf6cEy717ugQKPYTt4NwBs0GR1XHnBsla
         e6Hrs9UJV9pzauOqxNMHMhi6rKCo6YDVRgBNMprb5qA1f1330bnD3lecAogS4Y4eeTQh
         zC2UZWg9quu6Op16r1a6ZJnWwbA7ox899RvPPXOQUiNKnPFH6BASwYbEROBECwbSOfex
         MWow==
X-Gm-Message-State: ACgBeo22JnGkUSPz2nhNhNN8DfMF9Ib3l1B3qGG9X8K1dbcRNGDti+tP
        3wI/5ESNReR/s/6Iq7OP7C96USQ/XuahkuS7
X-Google-Smtp-Source: AA6agR5WP4Ypflu3uPS4K6a6Dm1zEkxkcGfNv7Z+4R/v9idvn6jHrLlLovPTxBrTD1rFvsw0NBr4QQ==
X-Received: by 2002:a05:6402:2691:b0:43d:ba10:854b with SMTP id w17-20020a056402269100b0043dba10854bmr5672195edd.158.1661307083888;
        Tue, 23 Aug 2022 19:11:23 -0700 (PDT)
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com. [209.85.128.49])
        by smtp.gmail.com with ESMTPSA id c16-20020a50d650000000b0044402ac02f7sm2299122edj.67.2022.08.23.19.11.22
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Aug 2022 19:11:22 -0700 (PDT)
Received: by mail-wm1-f49.google.com with SMTP id v7-20020a1cac07000000b003a6062a4f81so76881wme.1
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 19:11:22 -0700 (PDT)
X-Received: by 2002:a7b:c399:0:b0:3a5:f3fb:85e0 with SMTP id
 s25-20020a7bc399000000b003a5f3fb85e0mr3710246wmj.38.1661307082283; Tue, 23
 Aug 2022 19:11:22 -0700 (PDT)
MIME-Version: 1.0
References: <20220821000737.328590235@goodmis.org> <20220821000844.510643400@goodmis.org>
 <CAHk-=wjsxu782N0P+oMu35N7rJAOeh3buQFWJaZHZTNmVSB=3Q@mail.gmail.com>
 <5700ac75-f6a9-877e-4011-9b314f12b5ab@acm.org> <CAHk-=wjqkWEr0MRO5hWuBoTDgNUj4qQK8V_Y36et=61mdPztJw@mail.gmail.com>
 <02daa3d6-2847-d7e0-e23e-411076c6d4db@rasmusvillemoes.dk> <0163b361-14bf-7b4c-751a-14f1a004b1a9@acm.org>
 <CAHk-=wjMLb30d0WT_RyKBCX+JBkg3QQU6pCYkrV8f58Ya4Rgzw@mail.gmail.com>
 <b79c83af-e9fc-9fa0-dff7-f3a8a39887ff@acm.org> <CAHk-=wgV1F7_ErXkXT2wd+07LJd_3Vp-yVUKLROPiEgijeoTrQ@mail.gmail.com>
In-Reply-To: <CAHk-=wgV1F7_ErXkXT2wd+07LJd_3Vp-yVUKLROPiEgijeoTrQ@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 23 Aug 2022 19:11:05 -0700
X-Gmail-Original-Message-ID: <CAHk-=whjH6p+qzwUdx5SOVVHjS3WvzJQr6mDUwhEyTf6pJWzaQ@mail.gmail.com>
Message-ID: <CAHk-=whjH6p+qzwUdx5SOVVHjS3WvzJQr6mDUwhEyTf6pJWzaQ@mail.gmail.com>
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

On Tue, Aug 23, 2022 at 6:49 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> That's the
>
> > It does require that kernel change to make
> >
> >   #define is_signed_type(type)   (((type)(-1)) <= (type)0)
>
> part I was talking about.

Side note: I think you could move this into '<linux/compiler.h>' and that would

 (a) make some conceptual sense (unlike "overflow.h" and "trace_events.h")

and

 (b) mean it gets included automatically in both files.

overflow.h already explicitly includes compiler.h, and trace_events.h
gets it from

   linux/ring_buffer.h -> linux/mm.h -> linux/bug.h -> asm/bug.h ->
linux/compiler.h

(it goes other wats too, but those ones are through arch-specific asm
headers, so the above is the first non-arch-specific unconditional
chain I found.

And yes, we should have some tool for sorting out these nasty header
chains. Some automated tool that says "You don't need header X,
because you already got it" or "You don't need headed X, because
nothing you do depends on it".

             Linus
