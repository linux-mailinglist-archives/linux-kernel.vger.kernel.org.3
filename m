Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C4604A0279
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 22:01:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243121AbiA1VBG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 16:01:06 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:42380 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231409AbiA1VBE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 16:01:04 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D3CEC61DDE;
        Fri, 28 Jan 2022 21:01:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E895DC340E7;
        Fri, 28 Jan 2022 21:01:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643403663;
        bh=OO220eVKGYUZ5Gb3hkrywvL1gvt+thYAdPFvpS3OVo4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=B1NubrGueLPC7okx9X23rg+Q9HR72JeXOrlPsgCmcM+80zk3iwhIuyEcbCeJVmDXr
         tPwQYOuN+q7+IQSOhFi7GRvkfamIrh6lyDCZXTdX3Sx4gB1NzV2xM7k2QYxKZZFKsR
         /nKt4lLsvKgxmSKeqKAAm/KRw+7SaxCHFNJm2OLdyhiJ3fMxdFY90nF5rsbOEc2QP3
         DWxD3PYUTUlQq/cIYf7PYUitSaUnyeCSjTDODM7Ng33IW1p42VOtcRQB5OIu/xLRjh
         tUYGMt5t/yW0VYvHAN6t1UqJu6NXbexRGc+qJRxGrayE2Z3rMakJ0vE6WpE2GKKfcH
         aayEEljVunXUQ==
Date:   Fri, 28 Jan 2022 22:00:59 +0100
From:   Mauro Carvalho Chehab <mchehab@kernel.org>
To:     Jonathan =?UTF-8?B?TmV1c2Now6RmZXI=?= <j.neuschaefer@gmx.net>
Cc:     linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH] scripts/get_abi.pl: Ignore hidden files
Message-ID: <20220128220007.085021a8@coco.lan>
In-Reply-To: <YfRWAP2OoW4t8juH@latitude>
References: <20220128201354.1928412-1-j.neuschaefer@gmx.net>
        <YfRWAP2OoW4t8juH@latitude>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.31; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, 28 Jan 2022 21:45:52 +0100
Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net> escreveu:

> On Fri, Jan 28, 2022 at 09:13:53PM +0100, Jonathan Neusch=C3=A4fer wrote:
> > get_abi.pl currently collects every file in Documentation/ABI. This
> > causes a UnicodeDecodeError in Documentation/sphinx/kernel_api.py, =20
>=20
> Ooops, this should be kernel_abi.py.
>=20

After addressing your comment about the kernel_abi.py file, feel free
to add:

Reviewed-by: Mauro Carvalho Chehab <mchehab@kernel.org>

>=20
> > when it finds my Vim swap files (.foo.swp) in the directory.
> >=20
> > To avoid such issues, ignore hidden files in get_api.pl. =20
>=20
> ... and get_abi.pl.
>=20
>=20
> >=20
> > Signed-off-by: Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net>
> > ---
> >  scripts/get_abi.pl | 1 +
> >  1 file changed, 1 insertion(+)
> >=20
> > diff --git a/scripts/get_abi.pl b/scripts/get_abi.pl
> > index 6212f58b69c61..47b7eca5b0b71 100755
> > --- a/scripts/get_abi.pl
> > +++ b/scripts/get_abi.pl
> > @@ -92,6 +92,7 @@ sub parse_abi {
> >  	my $mode =3D (stat($file))[2];
> >  	return if ($mode & S_IFDIR);
> >  	return if ($file =3D~ m,/README,);
> > +	return if ($file =3D~ m,/\.,);
> >=20
> >  	my $name =3D $file;
> >  	$name =3D~ s,.*/,,;
> > --
> > 2.34.1

Thanks,
Mauro
