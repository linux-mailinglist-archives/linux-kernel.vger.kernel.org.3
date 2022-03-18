Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52D0A4DE408
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Mar 2022 23:31:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241311AbiCRWc1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Mar 2022 18:32:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241298AbiCRWcX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Mar 2022 18:32:23 -0400
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B73E12EB54E
        for <linux-kernel@vger.kernel.org>; Fri, 18 Mar 2022 15:30:59 -0700 (PDT)
Received: by mail-yb1-xb2c.google.com with SMTP id v35so18199643ybi.10
        for <linux-kernel@vger.kernel.org>; Fri, 18 Mar 2022 15:30:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=5fVM9GxpYrKL0vDGShMfVI5LEzMqL6jtRV6TGvb20BM=;
        b=U2GqGKuzbJHZ37d58mvNR42j7vtzFiu5+ShjP+SnBIBUSTEpoSS+4LPWNJW7gZ0Q8l
         fUmxc/Los26bhN33axqlj/Eb5KyKZcw3JA32xC459u9s6qiFUzv4h156LaeiOG3gV2+q
         y+SJOensPKHwrY2YKVQSbR9cm8yqeretLrLPis/lnv+yxT3XXIESat+/6IWVCIJFetJe
         vh1Zn1Hn9TZIY+fTl3I3hELf0BUZXaszXLNCmpazoFvGdy7r0qv8U00udaLnPa2jNb0F
         c1J3W+tuy3Q0nVWMxBBZenffBsyUjXRZiwIPI7oPCGSIn+Jz4LXnvPdCLyKNAfp6fKcF
         A6cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=5fVM9GxpYrKL0vDGShMfVI5LEzMqL6jtRV6TGvb20BM=;
        b=sgHjIJtIa1svP4Qynve7aoRmc5z05hzzXxxlY5W45jues35tuuhGBwmN/SYR5cbZN8
         nn3Df2qUGtQ2WAUh76J1/9GCKE5xSjdVeAJcb+/tGa3mGkTV0HDId35JNBbIYYjZhovj
         aF4QS25eXPUjIP91pVH6PnuegdcUWKkTiRrR0hd0tO3b61Jkqm5DHa9LdUmDeYrzdObY
         SpMzGw6oymONFVxYGTChOWfxSNYNUqJMub5T2KHnDPZedM0P7QYDQ2XU2xxbZR8RFQd1
         0CAgOjr08KeBfkjak0r5Mwg6XI2Qq0HrPQcsXcdoZVKbc/zJlx9iEy0FRMBJB/g8a6Es
         jmPQ==
X-Gm-Message-State: AOAM530aHmFbYiAV+waeBnBuRwq+i2LKtXAyc4Jxfq6SuzcLltNzSoW5
        DrZfdxvqknxFrAMTjlMAardr+UsIpAYdSM59q5GbXE5w
X-Google-Smtp-Source: ABdhPJzMXc24y+UamlsugdiRva9/6oWTheLIuT4vAMJ118qpzKxzU55gAoX2yMAQWxrA7ZRmWkp6dVvlj3vGdEoWyhw=
X-Received: by 2002:a25:344b:0:b0:633:b905:46ff with SMTP id
 b72-20020a25344b000000b00633b90546ffmr5701314yba.330.1647642656484; Fri, 18
 Mar 2022 15:30:56 -0700 (PDT)
MIME-Version: 1.0
References: <2d97ae92b9c06214be0e088a72cf303eb591bf01.1646414295.git.christophe.leroy@csgroup.eu>
 <47e09d6010852db928c0de29b89450ea7eee74d8.camel@redhat.com>
 <edb9aabd-09af-ae0c-348d-f0500e3405d7@csgroup.eu> <672043db-5290-293c-fde4-440989c78d09@csgroup.eu>
 <9aebcbbf-aaba-f7e8-7397-18284e74ab0d@csgroup.eu> <b3e5914f649a9cdc35fbbe9f399d3806f13c3a6f.camel@redhat.com>
In-Reply-To: <b3e5914f649a9cdc35fbbe9f399d3806f13c3a6f.camel@redhat.com>
From:   Ben Skeggs <skeggsb@gmail.com>
Date:   Sat, 19 Mar 2022 08:30:45 +1000
Message-ID: <CACAvsv7iAQN5azzzs820sXHGYv-pKRv0+dBPR60k9Fsw5OYiaA@mail.gmail.com>
Subject: Re: [PATCH] drm/nouveau/bios: Rename prom_init() and friends functions
To:     Lyude Paul <lyude@redhat.com>
Cc:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        Ben Skeggs <bskeggs@redhat.com>,
        Karol Herbst <kherbst@redhat.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        ML nouveau <nouveau@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>,
        ML dri-devel <dri-devel@lists.freedesktop.org>
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

On Sat, 19 Mar 2022 at 04:11, Lyude Paul <lyude@redhat.com> wrote:
>
> Whoops, sorry! I was unsure of the preference in name we should go with s=
o I
> poked Ben on the side to ask them, but I can see they haven't yet respond=
ed.
> I'll poke thme again and see if I can get a response.
Yeah, please keep _prom as opposed to _rom.  It's a reference to the
NV_PROM device.

Ben.

>
> On Fri, 2022-03-18 at 10:55 +0100, Christophe Leroy wrote:
> > Hi Paul,
> >
> > Le 05/03/2022 =C3=A0 10:51, Christophe Leroy a =C3=A9crit :
> > >
> > >
> > > Le 05/03/2022 =C3=A0 08:38, Christophe Leroy a =C3=A9crit :
> > > >
> > > >
> > > > Le 04/03/2022 =C3=A0 21:24, Lyude Paul a =C3=A9crit :
> > > > > This mostly looks good to me. Just one question (and one comment =
down
> > > > > below
> > > > > that needs addressing). Is this with ppc32? (I ask because ppc64l=
e
> > > > > doesn't
> > > > > seem to hit this compilation error).
> > > >
> > > > That's with PPC64, see
> > > > http://kisskb.ellerman.id.au/kisskb/branch/chleroy/head/252ba609bea=
83234d2e35841c19ae84c67b43ec7/
> > > >
> > > >
> > > >
> > > > But that's not (yet) with the mainline tree. That's work I'm doing =
to
> > > > cleanup our asm/asm-protoypes.h header.
> > > >
> > > > Since commit 4efca4ed05cb ("kbuild: modversions for EXPORT_SYMBOL()
> > > > for asm") that file is dedicated to prototypes of functions defined=
 in
> > > > assembly. Therefore I'm trying to dispatch C functions prototypes i=
n
> > > > other headers. I wanted to move prom_init() prototype into asm/prom=
.h
> > > > and then I hit the problem.
> > > >
> > > > In the beginning I was thinking about just changing the name of the
> > > > function in powerpc, but as I see that M68K, MIPS and SPARC also ha=
ve
> > > > a prom_init() function, I thought it would be better to change the
> > > > name in shadowrom.c to avoid any future conflict like the one I got
> > > > while reworking the headers.
> > > >
> > > >
> > > > > > @@ -57,8 +57,8 @@ prom_init(struct nvkm_bios *bios, const char
> > > > > > *name)
> > > > > >   const struct nvbios_source
> > > > > >   nvbios_rom =3D {
> > > > > >          .name =3D "PROM",
> > > > > > -       .init =3D prom_init,
> > > > > > -       .fini =3D prom_fini,
> > > > > > -       .read =3D prom_read,
> > > > > > +       .init =3D nvbios_rom_init,
> > > > > > +       .fini =3D nvbios_rom_fini,
> > > > > > +       .read =3D nvbios_rom_read,
> > > > >
> > > > > Seeing as the source name is prom, I think using the naming conve=
ntion
> > > > > nvbios_prom_* would be better then nvbios_rom_*.
> > > > >
> > > >
> > > > Yes I wasn't sure about the best naming as the file name is
> > > > shadowrom.c and not shadowprom.c.
> > > >
> > > > I will send v2 using nvbios_prom_* as a name.
> > >
> > > While preparing v2 I remembered that in fact, I called the functions
> > > nvbios_rom_* because the name of the nvbios_source struct is nvbios_r=
om,
> > > so for me it made sense to use the name of the struct as a prefix for
> > > the functions.
> > >
> > > So I'm OK to change it to nvbios_prom_* but it looks less logical to =
me.
> > >
> > > Please confirm you still prefer nvbios_prom as prefix to the function
> > > names.
> > >
> >
> > Are you still expecting a v2 for this patch ?
> >
> > As the name of the structure is nvbios_rom, do you really prefer the
> > functions to be called nvbios_prom_* as you mentionned in your comment =
?
> >
> > In that case, do you also expect the structure name to be changed to
> > nvbios_prom ?
> >
> > Thanks
> > Christophe
> >
>
> --
> Cheers,
>  Lyude Paul (she/her)
>  Software Engineer at Red Hat
>
