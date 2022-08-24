Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55FCF59F0DC
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Aug 2022 03:26:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230152AbiHXB0A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 21:26:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbiHXBZ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 21:25:57 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24CC52B60B;
        Tue, 23 Aug 2022 18:25:57 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id 20so14342804plo.10;
        Tue, 23 Aug 2022 18:25:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc;
        bh=uUmdHBpzbriSuoiotw31C+sqS36Q04kPztFqTxJQriw=;
        b=dpb/yMlot+zmKLKXIjN6Lvob6LhNAAMCj/+/Os1pajANbCivi3fer2r0Fmqkba5q5j
         mbVtDCeEkBqAxJA3Jwlcnmc1UGiPMfco0NiKCUraZVvrh30cMjKwZxOY9GGgVhthe9Ba
         9YnAbqk5d/0N1mR8i2cUsV7gh4GHg62DdyrbY8WR+VFMR8zadMzS98Xqp6+Rt14tDot6
         pPYnphfWLxgQrJveBRXJbcJ65Cl48WyQilgLXE7j4egkKdSNlm0kFrmVKaakvi1wWVxf
         fPS6XZsZsSycgRBMgX8F1jZmlqbGON/rJYkPsA+k23m1N6Yq7vijy6NkAS6mIBkCqrXR
         D+0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc;
        bh=uUmdHBpzbriSuoiotw31C+sqS36Q04kPztFqTxJQriw=;
        b=GPNj+g7jpkJARxsmHFEPO3PW5Qgs4TkPO1QuL8hmr1d44q2AyiEEYkaHd2UY4Zwdmo
         Nni63aX0MBR0UJdmKD1XAutHRS42C1C7joFqxQaCj37xINdB1G71NRcxoOkUsAg9E1W2
         4Zv8pGRey91RYpT1P+g80nJ3gxW5B4IZc4JWMypBlkw7He1H5axSUJM5C/Eua554bJzN
         1dVtfDBSMuQasDQhK843E9/MmRS9oXfsfdC+OIZjyarv7vdaQke3S/9y2ayWzbrVR/R+
         aAbsZmymkNnaNv1x4vNCTl6j6RqHbmb4KOlDWOeMZF0AaHpTeT4/jn6WL8j2iS4IYSKG
         HCBg==
X-Gm-Message-State: ACgBeo1ph3rDgF6DE46Qy1BZTPmvR4U5dtK/lHDzqap2C7Ho0pr9VNqb
        JZhPqv9XYMML7S3/L+al4Hy/d8XQpseH4iZND6U=
X-Google-Smtp-Source: AA6agR7xbfLJ1Uo0SN1Sc8YyuIhlZnLymcTgcuHc3xIKaCc5l2Col+H8uCrdOb9eDMMna3TkYDUkhhZNCNjnMhaqWsU=
X-Received: by 2002:a17:90b:4a05:b0:1f5:62d5:4155 with SMTP id
 kk5-20020a17090b4a0500b001f562d54155mr6063079pjb.6.1661304356632; Tue, 23 Aug
 2022 18:25:56 -0700 (PDT)
MIME-Version: 1.0
References: <20220821010030.97539-1-zhouzhouyi@gmail.com> <87edx7l5px.fsf@mpe.ellerman.id.au>
 <0d7b55bc-4dd2-7de1-8ca5-353b1a044caf@csgroup.eu> <3756ad84-a5b0-b404-7962-86f77d6f38b3@csgroup.eu>
In-Reply-To: <3756ad84-a5b0-b404-7962-86f77d6f38b3@csgroup.eu>
From:   Zhouyi Zhou <zhouzhouyi@gmail.com>
Date:   Wed, 24 Aug 2022 09:25:45 +0800
Message-ID: <CAABZP2w5zOWwLknAEY4UoEQZraOn29TqpaaZxmZKpqS2GhT_yQ@mail.gmail.com>
Subject: Re: [PATCH linux-next] powerpc: disable sanitizer in irq_soft_mask_set
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        atrajeev@linux.vnet.ibm.com,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        linux-kernel <linux-kernel@vger.kernel.org>, lance@osuosl.org,
        "Paul E. McKenney" <paulmck@kernel.org>, rcu <rcu@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 24, 2022 at 12:50 AM Christophe Leroy
<christophe.leroy@csgroup.eu> wrote:
>
>
>
> Le 23/08/2022 =C3=A0 10:47, Christophe Leroy a =C3=A9crit :
> >
> >
> > Le 23/08/2022 =C3=A0 10:33, Michael Ellerman a =C3=A9crit :
> >> Zhouyi Zhou <zhouzhouyi@gmail.com> writes:
> >>
> >> My worry is that this will force irq_soft_mask_set() out of line, whic=
h
> >> we would rather avoid. It's meant to be a fast path.
> >>
> >> In fact with this applied I see nearly 300 out-of-line copies of the
> >> function when building a defconfig, and ~1700 calls to it.
> >>
> >> Normally it is inlined at every call site.
> >>
> >>
> >> So I think I'm inclined to revert ef5b570d3700 ("powerpc/irq: Don't op=
en
> >> code irq_soft_mask helpers").
> >
> > Could you revert it only partially ? In extenso, revert the
> > READ/WRITE_ONCE and bring back the inline asm in irq_soft_mask_return()
> >   and irq_soft_mask_set(), but keep other changes.
>
> I sent a patch doing that.
Thank Christophe for the fix. I am very glad to be of benefit to the
community ;-)
Also thank Michael and Paul for your constant encouragement and
guidance, I learned to use objdump to count the number of failed
inline function calls today ;-)

By the way, from my experiments, both gcc-11 and clang-14 behave the
same as Michael has described.

Cheers
Zhouyi
>
> Christophe
