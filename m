Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B97FB4ECC70
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 20:37:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350143AbiC3SjR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 14:39:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352492AbiC3SfU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 14:35:20 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EA4F49FAA
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 11:33:31 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id y10so25452267edv.7
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 11:33:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sweetwater-ai.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=dKO0rsHOFyAMpWyi1MHnQVOBdREz93tr5XlY/aCT89k=;
        b=HuX8hqSNN5CkzIlnxfFjhdrv+0hTKMiO/saHmO8S5JDzFWMGcv/5KDwUAo32rYCysn
         X77M8eptIyb61789PEkrwWql5tRKB9J77M8fq0MwhTccLCZJLdKGAOoHGL6pWRui9ZTO
         bMRVaQiHPR78HPQOjJ/go74Pw5Cy8v6E3yw3PoryL1+twgVAmF06wPH7EuNgVtgBBMRY
         PGRydspLrTf832CuGoWHkQm7PSSelwm6jOkHWjlMi0X52TNW9TWYxb8LuxqrgKpoPByl
         Xpza3Cb7yNeuPfYSbS/2ylp8aqgwMOMKtcSobjgViLCTbryqSUzJMxoVFksfihYscBks
         V3Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=dKO0rsHOFyAMpWyi1MHnQVOBdREz93tr5XlY/aCT89k=;
        b=vWnVIP06mjcSsPzzkG1DbVLP3aFrbUEkTrvdjchT8tmjksaWXZ/TexJ6Cd+xi6qYCU
         fpN0qX2RsToPercNgB+vNuQQqEnmmCm61FnuPS4wAxM+uABJjmhkkbwbdA+am14xtiI3
         +N3bqtqJoSIei4Zc7B+Q4Rr9Go1M8v053zwDQ6KmkLw/ugoBiPyFkwQMVmPt7rsTGSCN
         MkE8d0TEI6O/tzdkrIOAcrKEqOp5b+mWeF1VBoCVK4Wsrq1zk80HHWKLXcE6EJAXVhZq
         vFZjPXQ28OnkWmVKh6ZRbS3ktk92jlRh2uWrTfqNtFCtzSCuy0Lr4YL+NK9F3hhEMIZ5
         Qjeg==
X-Gm-Message-State: AOAM5314gU7e+NhrVBOeX/W3ZIKZhUxhhLV0XXnsCuaHosdX+6SnzhwV
        dz0maYYzPXnmClCY6FJRZbN1acusFHFlb3X6eYiapQ==
X-Google-Smtp-Source: ABdhPJy4EZDSf9OPi2yzJpr2WG0IVC9oYxrOQ6LZwfMYIux64DzecT6oKH7UaRmQgYGnZbEm3yCppRzJnOe/WI26Qq8=
X-Received: by 2002:aa7:c704:0:b0:418:ee8f:3fd0 with SMTP id
 i4-20020aa7c704000000b00418ee8f3fd0mr12314131edq.248.1648665209697; Wed, 30
 Mar 2022 11:33:29 -0700 (PDT)
MIME-Version: 1.0
References: <20220328111828.1554086-1-sashal@kernel.org> <20220328111828.1554086-16-sashal@kernel.org>
 <CAOnCY6TTx65+Z7bBwgmd8ogrCH78pps59u3_PEbq0fUpd1n_6A@mail.gmail.com>
 <9e78091d07d74550b591c6a594cd72cc@AcuMS.aculab.com> <CAOnCY6QNPUC-VK+ARLb6i_UskV2CkW+AG5ZqWe_oMGUumL9Gnw@mail.gmail.com>
In-Reply-To: <CAOnCY6QNPUC-VK+ARLb6i_UskV2CkW+AG5ZqWe_oMGUumL9Gnw@mail.gmail.com>
From:   Michael Brooks <m@sweetwater.ai>
Date:   Wed, 30 Mar 2022 11:33:21 -0700
Message-ID: <CAOnCY6Q9XoAMpeRfA_ghge3mXkGXFsm4fW64hxcbnMdJyx8Y2g@mail.gmail.com>
Subject: Re: [PATCH AUTOSEL 5.17 16/43] random: use computational hash for
 entropy extraction
To:     David Laight <David.Laight@aculab.com>
Cc:     Sasha Levin <sashal@kernel.org>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Eric Biggers <ebiggers@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Jean-Philippe Aumasson <jeanphilippe.aumasson@gmail.com>,
        "Theodore Ts'o" <tytso@mit.edu>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The /dev/random device driver need not concern itself with root
adversaries as this type of user has permissions to read and overwrite
memory - this user even possesses permission to replace the kernel elf
binary with a copy of /dev/random that always returns the number 0 -
that is their right.

This whole issue of leaks is because we are relying upon fast but
insecure hash-function-like methods to extract data from a sensitive
pool.  LFSR and CRC32 (which was used in an earlier version of
/dev/random) have similarities to secure hash functions - but "aren't
good enough for military work" - which is why we are even discussing
the topic of leakage.

If we use a secure primitive in the right way - preferably one that is
faster than SHA1 - such as chcha20 or even faster still AES-NI (both
in a feedback mode).  Then the leakage is stopped.  If the pool cannot
leak then we do not need an entropy counter which is the mutex that
handle_irq_event_percpu() fights over.  This reduces interrupt
latency, reduces computational load of all interrupts, and helps
contribute to the pool being less predictable because now an outside
construct has to account for race conditions.

-Michael

On Wed, Mar 30, 2022 at 10:10 AM Michael Brooks <m@sweetwater.ai> wrote:
>
> Of course I am assuming local user non-root access.  One does not need
> to reverse the mix operations in order to form a parallel construction
> - a one way function is sufficient for such a construct as both sides
> will operate on the data in the same manner.
>
> This attack scenario is simply a non-issue in keypoolrandom.
> https://github.com/TheRook/KeypoolRandom
>
> On Wed, Mar 30, 2022 at 9:49 AM David Laight <David.Laight@aculab.com> wr=
ote:
> >
> > From: Michael Brooks
> > > Sent: 30 March 2022 17:08
> > ...
> > > I=E2=80=99d like to describe this bug using mathematics, because that=
 is how I
> > > work - I am the kind of person that appreciates rigor.  In this case,
> > > let's use inductive reasoning to illuminate this issue.
> > >
> > > Now, in this attack scenario let =E2=80=9Cp=E2=80=9D be the overall p=
ool state and let
> > > =E2=80=9Cn=E2=80=9D be the good unknown values added to the pool.  Fi=
nally, let =E2=80=9Ck=E2=80=9D be
> > > the known values - such as jiffies.  If we then describe the ratio of
> > > unknown uniqueness with known uniqueness as p=3Dn/k then as a k grows
> > > the overall predictability of the pool approaches an infinite value a=
s
> > > k approaches zero.   A parallel pool, let's call it p=E2=80=99 (that =
is
> > > pronounced =E2=80=9Cp-prime=E2=80=9D for those who don=E2=80=99t get =
the notation).  let
> > > p=E2=80=99=3Dn=E2=80=99/k=E2=80=99. In this case the attacker has no =
hope of constructing n=E2=80=99,
> > > but they can construct k=E2=80=99 - therefore the attacker=E2=80=99s =
parasol model of
> > > the pool p=E2=80=99 will become more accurate as the attack persists =
leading
> > > to p=E2=80=99 =3D p as time->=E2=88=9E.
> > >
> > > Q.E.D.
> >
> > That rather depends on how the (not) 'randmoness' is added to the pool.
> > If there are 'r' bits of randomness in the pool and a 'stir in' a pile
> > of known bits there can still be 'n' bits of randomness in the pool.
> >
> > The whole thing really relies on the non-reversability of the final prn=
g.
> > Otherwise if you have 'r' bits of randomness in the pool and 'p' bits
> > in the prng you only need to request 'r + p' bits of output to be able
> > to solve the 'p + r' simultaneous equations in 'p + r' unknowns
> > (I think that is in the field {0, 1}).
> >
> > The old kernel random number generator that used xor to combine the
> > outputs of several LFSR is trivially reversable.
> > It will leak whatever it was seeded with.
> >
> > The non-reversability of the pool isn't as important since you need
> > to reverse the prng as well.
> >
> > So while, in some sense, removing 'p' bits from the entropy pool
> > to seed the prng only leaves 'r - p' bits left.
> > That is only true if you think the prng is reversable.
> > Provided 'r > p' (preferably 'r >> p') you can reseed the prng
> > again (provided you take reasonably random bits) without
> > really exposing any more state to an attacker.
> >
> > Someone doing cat /dev/urandom >/dev/null should just keep reading
> > values out of the entropy pool.
> > But if they are discarding the values that shouldn't help them
> > recover the state of the entropy pool or the prng - even if only
> > constant values are being added to the pool.
> >
> > Really what you mustn't do is delete the bits used to seed the prng
> > from the entropy pool.
> > About the only way to actually reduce the randomness of the entropy
> > pool is if you've discovered what is actually in it, know the
> > 'stirring' algorithm and feed in data that exactly cancels out
> > bits that are present already.
> > I suspect that anything with root access can manage that!
> > (Although they can just overwrite the entropy pool itself,
> > and the prng for that matter.)
> >
> >         David
> >
> > -
> > Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, M=
K1 1PT, UK
> > Registration No: 1397386 (Wales)
