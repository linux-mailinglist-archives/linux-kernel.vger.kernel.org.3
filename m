Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35EF3587EDD
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Aug 2022 17:15:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237451AbiHBPPr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Aug 2022 11:15:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237534AbiHBPPW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Aug 2022 11:15:22 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD7FF1A82F;
        Tue,  2 Aug 2022 08:15:00 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1659453298;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=fS08hswxcKCvH2MW48Lg06ZhM4anuBSKvkfXm133UYc=;
        b=sfQdP4Tr5Ewrm9HBIgTeQ12Y/PhHlnjP1VJvn+ecexrguaK6TdjHh2u6ci6eCOeffHeOlY
        NNImo5tXkYFZoBJgTRMDNmd/Cf9UCwfmI7bzo4oEntcC5CelDq0Ej2hri3BZ0CJzn5XNII
        sf90vo7Wu/TlHiOuGYN0h/zvUVrvMILPc1Nt/S6VkAePgviLp2KWWIE7XdNpAs7/oflan6
        Co2Lm8Pefr3Vcao7j+J5ptsLeuWCw+0CKfSK7LRP2WczUY2TFviFJ3heRI2rVjHZDI163I
        7t1Rl8vQdix59NtocgBNjKqiVK5T0QR7EeYlCHjdSb/kYfy5vP4gDM+XrTM5eg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1659453298;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=fS08hswxcKCvH2MW48Lg06ZhM4anuBSKvkfXm133UYc=;
        b=edQRKstJDks0wpeZ/5DFs7BY8Lq6Cq4fjT/7SUqBOey3xJuZPvRfq8iiK0SOt8UCS9W3fc
        W6fYQkrA0Ixz1wCA==
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
        x86@kernel.org, Nadia Heninger <nadiah@cs.ucsd.edu>,
        Thomas Ristenpart <ristenpart@cornell.edu>,
        Theodore Ts'o <tytso@mit.edu>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Adhemerval Zanella Netto <adhemerval.zanella@linaro.org>,
        Florian Weimer <fweimer@redhat.com>
Subject: Re: [PATCH RFC v1] random: implement getrandom() in vDSO
In-Reply-To: <YuktqQS7Rb0IbJNh@zx2c4.com>
References: <20220729145525.1729066-1-Jason@zx2c4.com>
 <CAHk-=wiLwz=9h9LD1-_yb1+T+u59a2EjTmMvCiGj4A-ZsPN1wA@mail.gmail.com>
 <YuXCpyULk6jFgGV5@zx2c4.com> <87zggnsqwj.ffs@tglx>
 <Yuhe6IIFXqNMZs5b@zx2c4.com> <87bkt2sqq4.ffs@tglx>
 <YuktqQS7Rb0IbJNh@zx2c4.com>
Date:   Tue, 02 Aug 2022 17:14:57 +0200
Message-ID: <878ro6smmm.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 02 2022 at 15:59, Jason A. Donenfeld wrote:
> On Tue, Aug 02, 2022 at 03:46:27PM +0200, Thomas Gleixner wrote:
>> Right now the Linux VDSO functions are 1:1 replacements for system calls
>> and not adding a magic pile of functionality which is otherwise not
>> available.
>> 
>> What you are proposing is to have an implementation which is not
>> available via a regular syscall. Which means you are creating a VDSO
>> only syscall which still has the same problem as any other syscall in
>> terms of API design and functionality which needs to be supported
>> forever.
>
> Wait, what? That's not correct. The WHOLE point is that vdso getrandom()
> will generate bytes in the same way as the ordinary syscall, without
> differences. Same function name, same algorithm. But just faster,
> because vDSO. I explicitly don't want to dip into introducing something
> different. That's the big selling point: that vDSO getrandom() and
> syscall getrandom() are the same thing. If you trust one, you can trust
> the other. If you expect properties of one, you get that from the other.
> If you know the API of one, you can use the other.

Seriously no. All existing VDSO functions have exactly the same function
signature and semantics as their syscall counterparts. So they are drop
in equivalent.

But:

  ssize_t getrandom(void *, void *, size_t, unsigned int);

is very much different than

  ssize_t getrandom(void *, size_t, unsigned int);

Different signature and different semantics.

So you have to go through the whole process of a new ABI whether you
like it or not.

It does not matter whether they both produce random numbers. If your
argument would hold true, then you can also claim that openat(2) and
openat2(2) are the same thing because they both open a file.

Thanks,

        tglx
