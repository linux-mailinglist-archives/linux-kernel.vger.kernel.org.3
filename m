Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7ECD5954E7
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 10:22:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232147AbiHPIWO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 04:22:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232117AbiHPIVN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 04:21:13 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD9F265828
        for <linux-kernel@vger.kernel.org>; Mon, 15 Aug 2022 23:04:03 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id w3so12175606edc.2
        for <linux-kernel@vger.kernel.org>; Mon, 15 Aug 2022 23:04:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=jdACKcZQnW2rz+ym/pyFpE18JDDBRDsTGyRhdRj6JS8=;
        b=gqP6eFnkxg6m9YfSUzZ+10ZckWcrXTsAkZH0q+/zWP6PQQ1qM9nrnOZTfPWOPIIAHt
         Ni0Y6J1PD0BbYmGLR37J/IVpCDgWZB9D4z9b5oRZmqVQjPUK+0A1N0rS84547ExO55I/
         wnXf8etONDtUtGvrJys1HFW6iEOEr9i6fsIEM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=jdACKcZQnW2rz+ym/pyFpE18JDDBRDsTGyRhdRj6JS8=;
        b=gSanKhLIcgG5H/JTHZDg+mjaq5w9AiE04U0BjvgkMD3i7AFBgmZlYj66BdGse5sRWW
         7xh/nOKCrTOcKWIDWSl6/DPu6Ix2+8kSFKh8LWOs/qfFJLjA5If1agk73GfG1aGuU1bM
         QBuLQ7PTYOUaYCmCS4CuSUGgu5gi6voDnmyx5NVKG9S8Afzv3+W463wsovDnsOVlKkZ4
         lD1DBTOct4i9Guy1nlPGuoWFBTOaQGP0i7Vni2JXHnJMjrdCnUu0cKmu98dFcSYok/ou
         jVLHPvZ72qI1EDz4dxfYB1GeRqiQl6uA43ZyAeZHgFkYslpfghxET4xKEKtXCZ02xoNC
         lG1w==
X-Gm-Message-State: ACgBeo1z/viWLEjieH6D/pwl29BRPHqbTOSDoveuyO0/D1/yVNp0JOcG
        TI16xlsQpB4O89VXB/w0Nkj+r7gFxB6wpjNhWH8=
X-Google-Smtp-Source: AA6agR7nJ/v2PerzlfYhyvFSIktyRb2SBlaP3khKjSXQyNTfm/P8qfk+GgNxrt7E4mh4HxzXZCbbeQ==
X-Received: by 2002:a05:6402:11c8:b0:440:6513:be2c with SMTP id j8-20020a05640211c800b004406513be2cmr16980831edw.45.1660629842541;
        Mon, 15 Aug 2022 23:04:02 -0700 (PDT)
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com. [209.85.221.42])
        by smtp.gmail.com with ESMTPSA id r2-20020a17090609c200b0073156e6cd59sm4899837eje.4.2022.08.15.23.04.02
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Aug 2022 23:04:02 -0700 (PDT)
Received: by mail-wr1-f42.google.com with SMTP id e27so6635296wra.11
        for <linux-kernel@vger.kernel.org>; Mon, 15 Aug 2022 23:04:02 -0700 (PDT)
X-Received: by 2002:a05:6000:2a4:b0:225:162f:4cc7 with SMTP id
 l4-20020a05600002a400b00225162f4cc7mr1024841wry.274.1660629841690; Mon, 15
 Aug 2022 23:04:01 -0700 (PDT)
MIME-Version: 1.0
References: <YvqaK3hxix9AaQBO@slm.duckdns.org> <YvsZ6vObgLaDeSZk@gondor.apana.org.au>
 <CAHk-=wgSNiT5qJX53RHtWECsUiFq6d6VWYNAvu71ViOEan07yw@mail.gmail.com> <YvsvwCUVtNA5N5+U@gondor.apana.org.au>
In-Reply-To: <YvsvwCUVtNA5N5+U@gondor.apana.org.au>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 15 Aug 2022 23:03:45 -0700
X-Gmail-Original-Message-ID: <CAHk-=wi8FOpkDUdy48s0_3DVP2emB++_u02Pgus1EBpNv1dtig@mail.gmail.com>
Message-ID: <CAHk-=wi8FOpkDUdy48s0_3DVP2emB++_u02Pgus1EBpNv1dtig@mail.gmail.com>
Subject: Re: [PATCH] workqueue: Fix memory ordering race in queue_work*()
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     Will Deacon <will@kernel.org>, Tejun Heo <tj@kernel.org>,
        marcan@marcan.st, peterz@infradead.org, jirislaby@kernel.org,
        maz@kernel.org, mark.rutland@arm.com, boqun.feng@gmail.com,
        catalin.marinas@arm.com, oneukum@suse.com,
        roman.penyaev@profitbricks.com, asahi@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
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

On Mon, Aug 15, 2022 at 10:49 PM Herbert Xu <herbert@gondor.apana.org.au> wrote:
>
> I think this is the source of all this: [ commit 61e02392d3c7 ]

Yes, that doc update seems to actually predate the broken code.

But you can actually see how that commit clearly was only meant to
change the "test_and_set_bit_lock()" case. IOW, in that commit, the
test_and_set_bit() comments clearly say

 * test_and_set_bit - Set a bit and return its old value
 * This operation is atomic and cannot be reordered.
 * It may be reordered on other architectures than x86.
 * It also implies a memory barrier.

(that "It may be reordered on other architectures than x86" does show
clear confusion, since it also says "It also implies a memory
barrier")

And the very commit that adds that

  - RMW operations that are conditional are unordered on FAILURE,

language then updates the comment only above test_and_set_bit_lock().

And yes, on failure to lock, ordering doesn't matter. You didn't get
the bit lock, there is no ordering for you.

But then I think that mistake in the documentation (the relaxed
semantics was only for the "lock" version of the bitops, not for the
rest ot it) then later led to the mistake in the code.

End result: test_and_set_bit_lock() does indeed only imply an ordering
if it got the lock (ie it was successful).

But test_and_set_bit() itself is always "succesful". If the bit was
already set, that's not any indication of any "failure". It's just an
indication that it was set. Nothing more, nothing less, and the memory
barrier is still required regardless.

             Linus
