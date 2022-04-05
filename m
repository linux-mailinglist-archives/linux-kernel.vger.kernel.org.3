Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 428DC4F4A40
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 02:41:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1454481AbiDEWip (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 18:38:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1573369AbiDES6x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 14:58:53 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD660CD33C
        for <linux-kernel@vger.kernel.org>; Tue,  5 Apr 2022 11:56:53 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id h7so112961lfl.2
        for <linux-kernel@vger.kernel.org>; Tue, 05 Apr 2022 11:56:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zSvDe2wXRWjVXLEeBb9YX8FvDd3b9Nj5l9utIPFSSwc=;
        b=IhyRdaotisLwt7fVHkbbAVd8yCn1BLRomcM+qu6u/xZ9Xx0SPc1HY9AXMeDo4HAAai
         FhFmInf2Zf/ZWw3z04p7+qcFnWcYMtYX98wJI4MgIr1B6eHBp3DkPGzyfpnXPEHlSbO3
         x5sj/rqZaZEOH2Zel5umautUuhgGoXRKYUfPk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zSvDe2wXRWjVXLEeBb9YX8FvDd3b9Nj5l9utIPFSSwc=;
        b=19JhqveAA+PO287RXJrdoXndtn4UxWSQ49BLEvAtIWivJ230E8k85ymqv7qG29T+PE
         SEHOsXgKJ9wgwpTssSMbHKYQEY19uZHNiQAk6+I56/yKAo7sqrKnu9zrRTV+wqNr5oS1
         eaOwBHaCF2e52bpif9FDemm2ByxOIdx6io/wIuEMFDgFcEIoXJUDyNEePXiRr5rxIipO
         Qzfmz2N+FELbo/Jr2hDdKbIzX+oDhQgj/fg9v31TIcIR+1YFhgCHd1B08SZJ7/AkiN9n
         QhMzSBnPzsoxgZx0xIWTdcI8pIqMysRFaqrYjjGfhx9X+1HrajFs8Y4hNMG6YWJMYS7k
         KcYw==
X-Gm-Message-State: AOAM532/73tcdpJyTKoYj0KsaoqC7C0o1Wjvr5D0L9PYpED7cKPigpkT
        ZYweCkSeBP1Ddeks2tg53eyL/9zPb0PwRHLUDhE=
X-Google-Smtp-Source: ABdhPJwHxj0nFdVITrQ4mjL3IAFrwhHosH1Q6suBxGZinYVRDh3n4Z6i9BV7x27C7zLNlvEeDrXJMA==
X-Received: by 2002:a19:e209:0:b0:44a:51af:b3fd with SMTP id z9-20020a19e209000000b0044a51afb3fdmr3500589lfg.560.1649185011863;
        Tue, 05 Apr 2022 11:56:51 -0700 (PDT)
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com. [209.85.208.173])
        by smtp.gmail.com with ESMTPSA id m28-20020a05651202fc00b0044a315f262esm1583847lfq.166.2022.04.05.11.56.50
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Apr 2022 11:56:50 -0700 (PDT)
Received: by mail-lj1-f173.google.com with SMTP id by7so306201ljb.0
        for <linux-kernel@vger.kernel.org>; Tue, 05 Apr 2022 11:56:50 -0700 (PDT)
X-Received: by 2002:a2e:8e23:0:b0:24b:14f6:d71d with SMTP id
 r3-20020a2e8e23000000b0024b14f6d71dmr3094398ljk.443.1649185009914; Tue, 05
 Apr 2022 11:56:49 -0700 (PDT)
MIME-Version: 1.0
References: <20220405140906.222350-1-Jason@zx2c4.com> <CAHk-=wjFSsa7ZTFOiDCpZbwQsCKdAo3KFetSpGCjusqjjcb2XA@mail.gmail.com>
 <CAHmME9pPG2cgyfi6gV4NONXEc86Kw8_ejpOQUqcoaf3Mq1=Cfw@mail.gmail.com>
In-Reply-To: <CAHmME9pPG2cgyfi6gV4NONXEc86Kw8_ejpOQUqcoaf3Mq1=Cfw@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 5 Apr 2022 11:56:33 -0700
X-Gmail-Original-Message-ID: <CAHk-=wib4v7epabkEZmk5ZsJhHBX5UiVCwT9BWyeWrOwMrKkrA@mail.gmail.com>
Message-ID: <CAHk-=wib4v7epabkEZmk5ZsJhHBX5UiVCwT9BWyeWrOwMrKkrA@mail.gmail.com>
Subject: Re: [PATCH] random: opportunistically initialize on /dev/urandom reads
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        "Theodore Ts'o" <tytso@mit.edu>,
        Dominik Brodowski <linux@dominikbrodowski.net>
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

On Tue, Apr 5, 2022 at 11:31 AM Jason A. Donenfeld <Jason@zx2c4.com> wrote:
>
> It sounds like your suggestion would be to make that:
>
>   while (!crng_ready()) {
>     int ret;
>
>     try_to_generate_entropy();
>     if (nodelay && !crng_ready()) {
>       warn(...);
>       return -EBUSY;
>     }
>     ret = wait_event_interruptible_timeout(crng_init_wait, crng_ready(), HZ);
>     if (ret)
>       return ret > 0 ? 0 : ret;
>   }

Yes. Except I'd almost warn for the "ret < 0" case too, since almost
nobody seems to check it.

But hey, maybe callers that are interrupted by a signal check for that
separately. I guess it's _possible_.

             Linus
