Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D4025A7AC9
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 12:01:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231249AbiHaKBI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 06:01:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230498AbiHaKAh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 06:00:37 -0400
Received: from mail-il1-x129.google.com (mail-il1-x129.google.com [IPv6:2607:f8b0:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E1F9A50F1
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 03:00:32 -0700 (PDT)
Received: by mail-il1-x129.google.com with SMTP id s11so3608148iln.12
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 03:00:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=btMbTIPSX5dbCacGerCyAxqDIoBmYrvBMjvjrYIGNig=;
        b=WYM3XeLVMXVxeaZOoVzvPbeAuSlTMMHkX0Y2eZD1K4/ThGlZ6+Eg/Bv6VJyoDJlB+u
         W9LgBtDjWINhH+2OYh6n1/A5BSQmHGsWXMj8XqAhtn+krL7C++jj6y+j+FmlTs31utN0
         k9tC2ICHRKzAD6KXirg6CojpcPygW6KLNOetc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=btMbTIPSX5dbCacGerCyAxqDIoBmYrvBMjvjrYIGNig=;
        b=VSBOWDGyFeE+D7w4dE+XMIsEQcTIg3HYTfI2fJgUa5q11+rLYy6n3l0j/CzSg3WQbi
         7PD0nXxoqjWS1g+j8AW3OxpuGy//Mio0l0VAz+76VTaOFFrllFfqAdjHq4cpf2AA8iyq
         kRzKXahGdJVCMH5w8LyakLy4ov24SEWFs9tJQP9in/AuGEIuh21ALJ8uKNfYT1lpwx4s
         p3WdQ30ORE5F2E+Iue7crPzDJX8/y5D3iltFIj0UwhV9GpYWwzkgveTk2b3Yp+Vq4+61
         coZKkIiX0wC2JgYHbA2QzQmZUV37lSYM77/w2pSyKBwlGvUwoD6io1lxQqszNao6Ti4m
         Q8oQ==
X-Gm-Message-State: ACgBeo2ZH9NlHQpKXrBx7GBNJ37RWoBnrXPnhN7eax4amffGJpF+dAgN
        DQNPVxUgNt8sBp8+KD7v9LMWT7pTX84O8T8d5HI53Q==
X-Google-Smtp-Source: AA6agR7Ykym679T8iG+4ASbb+ENC/8XjLuzKLFnYo9eL16xdbnKf1MwaRtCyWd2Kj1UhmxqnIYOvsKqLHnQSC+/aFFU=
X-Received: by 2002:a92:cd0d:0:b0:2eb:e4a:2d4a with SMTP id
 z13-20020a92cd0d000000b002eb0e4a2d4amr6517370iln.309.1661940031852; Wed, 31
 Aug 2022 03:00:31 -0700 (PDT)
MIME-Version: 1.0
References: <20220729165954.991-1-ignat@cloudflare.com> <Yv9dvvy0rK/1T0sU@gondor.apana.org.au>
 <CALrw=nEh7LX3DSCa3FTu8BYr4QWx+W2h3Jei9Qo67+XXH-Vegw@mail.gmail.com>
 <Yw3Rneo6Ik1QEfbG@gondor.apana.org.au> <CALrw=nGJgMACrFVy+FVVCDb4H3wNUN2E-GLZaXzLsm3ReOUeVg@mail.gmail.com>
 <Yw8iTNjGlsP1LpNG@gondor.apana.org.au>
In-Reply-To: <Yw8iTNjGlsP1LpNG@gondor.apana.org.au>
From:   Ignat Korchagin <ignat@cloudflare.com>
Date:   Wed, 31 Aug 2022 11:00:21 +0100
Message-ID: <CALrw=nECpsJA-Q1ze2-ErQN37hMeWYbyfrWpmzUpsFCq=6R7Ew@mail.gmail.com>
Subject: Re: [PATCH] crypto: akcipher - default implementations for setting
 private/public keys
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     "David S . Miller" <davem@davemloft.net>,
        linux-crypto <linux-crypto@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        kernel-team <kernel-team@cloudflare.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 31, 2022 at 9:56 AM Herbert Xu <herbert@gondor.apana.org.au> wrote:
>
> On Tue, Aug 30, 2022 at 11:48:23AM +0100, Ignat Korchagin wrote:
> >
> > I vaguely remember some initial research in quantum-resistant
> > signatures, which used HMAC for "signing" thus don't have any public
> > keys. But it is way beyond my expertise to comment on the practicality
> > and availability of such schemes.
>
> We could always add this again should an algorithm requiring
> it be introduced.
>
> > I'm more concerned here about a buggy "third-party" RSA driver, which
> > may not implement the callback and which gets prioritised by the
> > framework, thus giving the ability to trigger a NULL-ptr dereference
> > from userspace via keyctl(2). I think the Crypto API framework should
> > be a bit more robust to handle such a case, but I also understand that
> > there are a lot of "if"s in this scenario and we can say it is up to
> > crypto driver not to be buggy. Therefore, consider my opinion as not
> > strong and I can post a v2, which does not provide a default stub for
> > set_pub_key, if you prefer.
>
> If you're concerned with buggy algorithms/drivers, we should
> ensure that the self-tests catch this.

So it does currently, because I caught it via testmgr. Will send a v2
without a default set_pub_key.
