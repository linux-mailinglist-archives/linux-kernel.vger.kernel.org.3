Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40BF55889A1
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Aug 2022 11:47:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236001AbiHCJri (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Aug 2022 05:47:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232303AbiHCJrf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Aug 2022 05:47:35 -0400
Received: from sender-of-o53.zoho.in (sender-of-o53.zoho.in [103.117.158.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90C331CB12
        for <linux-kernel@vger.kernel.org>; Wed,  3 Aug 2022 02:47:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1659519997; cv=none; 
        d=zohomail.in; s=zohoarc; 
        b=XvWsWjE8t5zW4M60jT2kOoKrtmPXvGOMsKVwKyiC2PnFszBqjdRoLPEB5p0Gm4snpFnbYZXTpo2f16yAE99b5YKURvkAqOpSpV5x+fcKGA+qHTZ9eoviJpaSLmXBMEjSoOQdwCbL6hIrRDBCVDyg36UZvsrFYIrC069hNuHmhpY=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.in; s=zohoarc; 
        t=1659519997; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=tCHNfkvLKa0BySi4rSrFMkX48wCJeADFiMbfJkU5ves=; 
        b=HOyH+TgaaaO2ChMWCD3C9KPP3EGmrp0QUke4MOKwGprGZFQbFRQp2xY9Tyyz1Plz5al4841MlxDMKySAaxJH9rog+bQClxfO6KmUcnb5DaNhRAWlZbs+p/c19AN2GoqAjkTfstZP4KCTqfHkN47VuysSTIieON8M5FOw4lISLis=
ARC-Authentication-Results: i=1; mx.zohomail.in;
        dkim=pass  header.i=siddh.me;
        spf=pass  smtp.mailfrom=code@siddh.me;
        dmarc=pass header.from=<code@siddh.me>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1659519997;
        s=zmail; d=siddh.me; i=code@siddh.me;
        h=Date:Date:From:From:To:To:Cc:Cc:Message-ID:In-Reply-To:References:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
        bh=tCHNfkvLKa0BySi4rSrFMkX48wCJeADFiMbfJkU5ves=;
        b=LjjQilODd69kMHJImKMUgwONAibLg0YAN8FOsMPeE36IMjtDxzLrJj9TY/02IOqe
        rezK8hZNAgPX0BkAmfPwP/s8bqbqgOW/MpEIK7ECFtoMn1CH3yZ9MJfBduOnZBv2L/h
        Ky8fP0E8dFzeKVY9obsL3O2nyFW+hyIdjbg/9I3M=
Received: from mail.zoho.in by mx.zoho.in
        with SMTP id 1659519981497938.089830690879; Wed, 3 Aug 2022 15:16:21 +0530 (IST)
Date:   Wed, 03 Aug 2022 15:16:21 +0530
From:   Siddh Raman Pant <code@siddh.me>
To:     "Ingo Molnar" <mingo@kernel.org>
Cc:     "x86" <x86@kernel.org>,
        "Dave Hansen" <dave.hansen@linux.intel.com>,
        "Andy Lutomirski" <luto@kernel.org>,
        "Peter Zijlstra" <peterz@infradead.org>,
        "Thomas Gleixner" <tglx@linutronix.de>,
        "Ingo Molnar" <mingo@redhat.com>, "Borislav Petkov" <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "linux-kernel" <linux-kernel@vger.kernel.org>,
        "linux-kernel-mentees" 
        <linux-kernel-mentees@lists.linuxfoundation.org>
Message-ID: <182631957a7.c72ff42439506.3030495024426988155@siddh.me>
In-Reply-To: <YupC88xuQ4rcyLVR@gmail.com>
References: <20220731160913.632092-1-code@siddh.me>
 <YukFgFTaq4Aw+uht@gmail.com>
 <1825f63b142.8968bde3116633.1242410031840350968@siddh.me>
 <Yuo2UkkyaYtZ3rMZ@gmail.com>
 <18262ed2459.44b0d74d434377.3690496800292832933@siddh.me>
 <Yuo7A0KYoNnbgwWT@gmail.com>
 <18263030220.8a990e82436929.3216192040531777412@siddh.me> <YupC88xuQ4rcyLVR@gmail.com>
Subject: Re: [PATCH] x86/numa: Use cpumask_available instead of hardcoded
 NULL check
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Importance: Medium
User-Agent: Zoho Mail
X-Mailer: Zoho Mail
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_RED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 03 Aug 2022 15:12:11 +0530  Ingo Molnar <mingo@kernel.org> wrote:
> Oh. So I was daft, as suspected. ;-)
>=20
> And I can confirm that while gcc-11 doesn't trigger the warning, gcc-12=
=20
> does:
>=20
>   $ make ARCH=3Dx86_64 CC=3Dgcc-11 arch/x86/mm/numa.o
>     CC      arch/x86/mm/numa.o
>   $
>=20
>   $ rm -f arch/x86/mm/numa.o
>   $
>   $ make ARCH=3Dx86_64 CC=3Dgcc-12 arch/x86/mm/numa.o
>=20
>     CC      arch/x86/mm/numa.o
>   arch/x86/mm/numa.c: In function =E2=80=98cpumask_of_node=E2=80=99:
>   arch/x86/mm/numa.c:916:39: error: the comparison will always evaluate a=
s =E2=80=98false=E2=80=99 for the address of =E2=80=98node_to_cpumask_map=
=E2=80=99 will never be NULL [-Werror=3Daddress]
>     916 |         if (node_to_cpumask_map[node] =3D=3D NULL) {
>=20
>=20
> > [...]
>=20
> Yeah - and I agree with your fix - will apply it.
>=20
> Thanks for your patience :-)
>=20
>     Ingo
>=20

No worries, and thanks! :)
Siddh
