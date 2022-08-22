Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D63D659C6EB
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 20:47:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237644AbiHVSq5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 14:46:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237934AbiHVSqB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 14:46:01 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BF68BBF
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 11:45:59 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id w10so2986377edc.3
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 11:45:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=f7AiHkMF8Q+p41BvxNYgDt9TnjBH3OCG1Mo7Ra0+mk4=;
        b=Xk8o0EPxKkzKnWijmQOvALIjZVZPpuZnZ0GmA5RiKQDGcUlNKae1qjUiUO52nM8yZU
         b99sj0HNcBrPiINvmVq8vlSLl5zWeGHV9hC2c9JQgyZulqB4Ur7QhpI/kSa6rQo0477n
         Ja5bFAekeNumGkHVitEGlFzipO6nlUjZWdRRs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=f7AiHkMF8Q+p41BvxNYgDt9TnjBH3OCG1Mo7Ra0+mk4=;
        b=s6XkNfq4kNqX4wB22atrg+/SAKd182GHas9zP8jmwEUqeDKsISlnihxeAmY0THCcWv
         5yLHYjgIf6HhdlP/Z9NAykL5tlcb/OjUgpURnSaO65VgNr+2ixbiK5R6XC4aT5WBGp1g
         B9rbiWqu3yAPgEQph/jsEJ5Q/wyRXq2ohzB9Nz+n/1aeSoaiKmo7DGAom+BTZTjKUObd
         89UQahiKQrP8scmQ0aYCIHZTu3W+yImvarhjHUics+qRkbpZF9khqjIV31+IdCZeUde3
         9wnw7Otq5XS1LOuHtEVpqRt7dXLhKePmmHBCbESo/rWNws99eg0CyuzL+uNDUkCnh/Rz
         7apA==
X-Gm-Message-State: ACgBeo0VQWdzaurhECjaLnZ8MnfxMb2sSHetNqNkjT/6/BxceqTfh404
        bTNYjnBpLtIsHKlOS9xCtyiEr1wwMdTSC5R62G4=
X-Google-Smtp-Source: AA6agR66UWp5zAl79EXNw0gh0E2ku5rgTtSI0o5Tlm25PqPuoLVdgmMAAP3FqZbr/gYfwjuzihZ+Wg==
X-Received: by 2002:a05:6402:2b8d:b0:43a:5410:a9fc with SMTP id fj13-20020a0564022b8d00b0043a5410a9fcmr432652edb.99.1661193957656;
        Mon, 22 Aug 2022 11:45:57 -0700 (PDT)
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com. [209.85.221.51])
        by smtp.gmail.com with ESMTPSA id lb5-20020a170907784500b0073d61238ae1sm4015220ejc.83.2022.08.22.11.45.56
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Aug 2022 11:45:56 -0700 (PDT)
Received: by mail-wr1-f51.google.com with SMTP id h5so13516869wru.7
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 11:45:56 -0700 (PDT)
X-Received: by 2002:adf:b343:0:b0:225:1a75:2a9a with SMTP id
 k3-20020adfb343000000b002251a752a9amr11277709wrd.281.1661193955805; Mon, 22
 Aug 2022 11:45:55 -0700 (PDT)
MIME-Version: 1.0
References: <20220821000737.328590235@goodmis.org> <20220821000844.510643400@goodmis.org>
 <CAHk-=wjsxu782N0P+oMu35N7rJAOeh3buQFWJaZHZTNmVSB=3Q@mail.gmail.com> <5700ac75-f6a9-877e-4011-9b314f12b5ab@acm.org>
In-Reply-To: <5700ac75-f6a9-877e-4011-9b314f12b5ab@acm.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 22 Aug 2022 11:45:39 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjqkWEr0MRO5hWuBoTDgNUj4qQK8V_Y36et=61mdPztJw@mail.gmail.com>
Message-ID: <CAHk-=wjqkWEr0MRO5hWuBoTDgNUj4qQK8V_Y36et=61mdPztJw@mail.gmail.com>
Subject: Re: [for-linus][PATCH 01/10] tracing: Suppress sparse warnings
 triggered by is_signed_type()
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Hellwig <hch@lst.de>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
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

On Mon, Aug 22, 2022 at 11:20 AM Bart Van Assche <bvanassche@acm.org> wrote:
>
> I agree that it's better that sparse sees the same code as what is used to
> build the kernel. However, I do not agree that the patch above is a solution.
> Sparse reports a warning for the suggested definition above of is_signed_type()
> because the new definition tries to use the less-than (<) operator to compare
> two __bitwise types.

Argh. I forgot that part. It wasn't just the cast that warned, it was
the compare too.

But we did have a sparse fix for it, didn't we? That fix required that
the '< (type)1' cast be changed to '<= (type)0' iirc, and a patch to
sparse, but it at least avoided the problem.

          Linus
