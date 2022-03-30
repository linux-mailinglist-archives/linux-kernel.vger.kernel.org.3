Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67B284ECA51
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 19:10:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349186AbiC3RMf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 13:12:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347347AbiC3RMe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 13:12:34 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0ED247040
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 10:10:47 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id b15so25236727edn.4
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 10:10:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sweetwater-ai.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=5+1Zj5574HVqGgubfIlGvK1ggJAfVXOkMEgNOA1AAMQ=;
        b=xeEA0HiUi3KNKRAugxwOL5pfNG5v6jOWYPby+IZi8TN7ycskNoe7nZe6Bvho7koFi2
         syttQyjfdGXuaLlI4+YqmerP0AmzJgprCFYztfu1qKEfld7USarnAqOZQRjpKnE1qxew
         Z8RHWZiAbFnrtS9YHZgC78fW77FYOGkP9XYFiYbad/h0MH5XcdXuKrKIf+KuXq/LrV3P
         4RYzU/2cI+oTsdZIj3dN9inkoZp4ap98/g1WhnKUswH8p1SCBCOHdk1uTSfIsxKdDL6x
         y5ZZSAsugdVLrCvB/vx4LqgoFkCMfRGsKhSJTX54SjjygVugnxRhXbabdNrqlVRf1vri
         cSKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=5+1Zj5574HVqGgubfIlGvK1ggJAfVXOkMEgNOA1AAMQ=;
        b=vYS9vnnpB0O+YcgESEaEHG1rS/kpZW+7TOeTN1WqcyXMdkOX/i3FERU3bKotBE6T1l
         HDKxHVeTXHJEoy7xa2DTWWABquKR47UgKqNuVhHvUYogl+rBVKIbDHNrwbK7v/1EFGsC
         qedr2cRKW8XvgQaO6ma3QfzCGqg+KUO8NkC4F5Cby5h0EQdFwdTxinpoWsC0QS/XUnaS
         bzkCtzoN72GQofvedSJfb1l5nZ+Ow5YU+sCg59o04Y1R0C3FkmRJV6tclSewt7x/RA1k
         TWByJrAGJP8b/by00NmyzvVJ2mcWMLSb1wckv+x84csNjXqNIhb2Y8h05IWlgTt7lyaE
         nQdA==
X-Gm-Message-State: AOAM532F1YmkG23i3enwaxevxTlODNuT24gzSuMMAavK5J/ruTqDUWMs
        bxPhf2FEtZ1I9SLGvcM7fQr8FUJbaS+NpAoI4w8LBg==
X-Google-Smtp-Source: ABdhPJyHY1u+Hjwp/9Vo8Vvx8Ta9KtzBLExEwugTBXcKXGbCRrbXUT8+L40AGkStu/t/Tq+0zlJEKsKY6chEEFicrEA=
X-Received: by 2002:a05:6402:5191:b0:419:3963:beff with SMTP id
 q17-20020a056402519100b004193963beffmr12249421edd.328.1648660246444; Wed, 30
 Mar 2022 10:10:46 -0700 (PDT)
MIME-Version: 1.0
References: <20220328111828.1554086-1-sashal@kernel.org> <20220328111828.1554086-16-sashal@kernel.org>
 <CAOnCY6TTx65+Z7bBwgmd8ogrCH78pps59u3_PEbq0fUpd1n_6A@mail.gmail.com> <9e78091d07d74550b591c6a594cd72cc@AcuMS.aculab.com>
In-Reply-To: <9e78091d07d74550b591c6a594cd72cc@AcuMS.aculab.com>
From:   Michael Brooks <m@sweetwater.ai>
Date:   Wed, 30 Mar 2022 10:10:37 -0700
Message-ID: <CAOnCY6QNPUC-VK+ARLb6i_UskV2CkW+AG5ZqWe_oMGUumL9Gnw@mail.gmail.com>
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
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Of course I am assuming local user non-root access.  One does not need
to reverse the mix operations in order to form a parallel construction
- a one way function is sufficient for such a construct as both sides
will operate on the data in the same manner.

This attack scenario is simply a non-issue in keypoolrandom.
https://github.com/TheRook/KeypoolRandom

On Wed, Mar 30, 2022 at 9:49 AM David Laight <David.Laight@aculab.com> wrot=
e:
>
> From: Michael Brooks
> > Sent: 30 March 2022 17:08
> ...
> > I=E2=80=99d like to describe this bug using mathematics, because that i=
s how I
> > work - I am the kind of person that appreciates rigor.  In this case,
> > let's use inductive reasoning to illuminate this issue.
> >
> > Now, in this attack scenario let =E2=80=9Cp=E2=80=9D be the overall poo=
l state and let
> > =E2=80=9Cn=E2=80=9D be the good unknown values added to the pool.  Fina=
lly, let =E2=80=9Ck=E2=80=9D be
> > the known values - such as jiffies.  If we then describe the ratio of
> > unknown uniqueness with known uniqueness as p=3Dn/k then as a k grows
> > the overall predictability of the pool approaches an infinite value as
> > k approaches zero.   A parallel pool, let's call it p=E2=80=99 (that is
> > pronounced =E2=80=9Cp-prime=E2=80=9D for those who don=E2=80=99t get th=
e notation).  let
> > p=E2=80=99=3Dn=E2=80=99/k=E2=80=99. In this case the attacker has no ho=
pe of constructing n=E2=80=99,
> > but they can construct k=E2=80=99 - therefore the attacker=E2=80=99s pa=
rasol model of
> > the pool p=E2=80=99 will become more accurate as the attack persists le=
ading
> > to p=E2=80=99 =3D p as time->=E2=88=9E.
> >
> > Q.E.D.
>
> That rather depends on how the (not) 'randmoness' is added to the pool.
> If there are 'r' bits of randomness in the pool and a 'stir in' a pile
> of known bits there can still be 'n' bits of randomness in the pool.
>
> The whole thing really relies on the non-reversability of the final prng.
> Otherwise if you have 'r' bits of randomness in the pool and 'p' bits
> in the prng you only need to request 'r + p' bits of output to be able
> to solve the 'p + r' simultaneous equations in 'p + r' unknowns
> (I think that is in the field {0, 1}).
>
> The old kernel random number generator that used xor to combine the
> outputs of several LFSR is trivially reversable.
> It will leak whatever it was seeded with.
>
> The non-reversability of the pool isn't as important since you need
> to reverse the prng as well.
>
> So while, in some sense, removing 'p' bits from the entropy pool
> to seed the prng only leaves 'r - p' bits left.
> That is only true if you think the prng is reversable.
> Provided 'r > p' (preferably 'r >> p') you can reseed the prng
> again (provided you take reasonably random bits) without
> really exposing any more state to an attacker.
>
> Someone doing cat /dev/urandom >/dev/null should just keep reading
> values out of the entropy pool.
> But if they are discarding the values that shouldn't help them
> recover the state of the entropy pool or the prng - even if only
> constant values are being added to the pool.
>
> Really what you mustn't do is delete the bits used to seed the prng
> from the entropy pool.
> About the only way to actually reduce the randomness of the entropy
> pool is if you've discovered what is actually in it, know the
> 'stirring' algorithm and feed in data that exactly cancels out
> bits that are present already.
> I suspect that anything with root access can manage that!
> (Although they can just overwrite the entropy pool itself,
> and the prng for that matter.)
>
>         David
>
> -
> Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1=
 1PT, UK
> Registration No: 1397386 (Wales)
