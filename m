Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A64E472AD5
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 12:07:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233687AbhLMLHG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 06:07:06 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:37340 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231629AbhLMLHF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 06:07:05 -0500
Received: from localhost (unknown [IPv6:2a01:e0a:2c:6930:5cf4:84a1:2763:fe0d])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: bbrezillon)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id 0FB331F44952;
        Mon, 13 Dec 2021 11:07:02 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=collabora.com; s=mail;
        t=1639393622; bh=04bequcs/NusDXEPCLT88FK1oMcTVoR+NRtV8yyK19Y=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=HPNa0pEfIv5hz6GQwg7ADSOI51qVUCd/TfMdvCH8ku4dokzLlTwYUlnHF+7KdlYVC
         es/+H7R0Wapod9i7t5ThTjnFFIPLAcnnWoAAjAp1aaBSMcUVmMOn+nTln1rkvFoCur
         GLWAgdzgdri+jR4cx8wNswkEeY7Op9czgpY97qLRd0JUWL7QWBiNJm8jnNNgiCVMME
         dMSSxK2M+9N2zlQ4HU+MLN59N0bjXqM/VePCWMoJwabqapJlGKVMBSYfc/LLeBIgWl
         lzVPj72aHm+EwDEEpZC7pc/BTaRun+PpKExRo/DnLECuZq7Mos0BWQ4BhiN0caVfQC
         VyhDvSBVm/OJw==
Date:   Mon, 13 Dec 2021 12:06:58 +0100
From:   Boris Brezillon <boris.brezillon@collabora.com>
To:     Sean Nyekjaer <sean@geanix.com>
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        linux-kernel@vger.kernel.org,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Boris Brezillon <bbrezillon@kernel.org>,
        linux-mtd@lists.infradead.org
Subject: Re: [PATCH v5 3/4] mtd: core: protect access to MTD devices while
 in suspend
Message-ID: <20211213120658.45f312a6@collabora.com>
In-Reply-To: <20211213105012.65jk4rylxzncqdfy@skn-laptop>
References: <20211130132912.v6v45boce2zbnoy3@skn-laptop>
        <20211130143705.5d0404aa@collabora.com>
        <20211203143958.40645506@xps13>
        <20211209140721.6ki7gznvxwyn3cze@skn-laptop.hinnerup>
        <20211209152811.318bdf17@xps13>
        <20211210132535.gy7rqj5zblqlnz5y@skn-laptop.hadsten>
        <20211213101025.42c27b43@xps13>
        <20211213102801.569b50b1@collabora.com>
        <20211213103350.22590c13@xps13>
        <20211213105336.7be369b7@collabora.com>
        <20211213105012.65jk4rylxzncqdfy@skn-laptop>
Organization: Collabora
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 13 Dec 2021 12:50:12 +0200
Sean Nyekjaer <sean@geanix.com> wrote:

> Hi Miquel and Boris,
>=20
> On Mon, Dec 13, 2021 at 10:53:36AM +0100, Boris Brezillon wrote:
> > On Mon, 13 Dec 2021 10:33:50 +0100
> > Miquel Raynal <miquel.raynal@bootlin.com> wrote:
> >  =20
> > > Hello,
> > >=20
> > > boris.brezillon@collabora.com wrote on Mon, 13 Dec 2021 10:28:01 +010=
0:
> > >  =20
> > > > On Mon, 13 Dec 2021 10:10:25 +0100
> > > > Miquel Raynal <miquel.raynal@bootlin.com> wrote:
> > > >    =20
> > > > > Hi Sean,
> > > > >=20
> > > > > sean@geanix.com wrote on Fri, 10 Dec 2021 14:25:35 +0100:
> > > > >      =20
> > > > > > On Thu, Dec 09, 2021 at 03:28:11PM +0100, Miquel Raynal wrote: =
      =20
> > > > > > > Hi Sean,
> > > > > > >=20
> > > > > > > sean@geanix.com wrote on Thu, 9 Dec 2021 15:07:21 +0100:
> > > > > > >          =20
> > > > > > > > On Fri, Dec 03, 2021 at 02:39:58PM +0100, Miquel Raynal wro=
te:         =20
> > > > > > > > > Hello,
> > > > > > > > >            =20
> > > > > > > > > > > Fine by me, lets drop this series.           =20
> > > > > > > > >=20
> > > > > > > > > FYI I've dropped the entire series from mtd/next. I'm wai=
ting for the
> > > > > > > > > fix discussed below (without abusing the chip mutex ;-) )=
.           =20
> > > > > > > >=20
> > > > > > > > Cool, looking forward to test a patch series :)         =20
> > > > > > >=20
> > > > > > > Test? You mean "write"? :)
> > > > > > >=20
> > > > > > > Cheers,
> > > > > > > Miqu=C3=A8l         =20
> > > > > >=20
> > > > > > Hi Miquel,
> > > > > >=20
> > > > > > Should we us a atomic for the suspended variable?       =20
> > > > >=20
> > > > > I haven't thought about it extensively, an atomic variable sound =
fine
> > > > > but I am definitely not a locking expert...     =20
> > > >=20
> > > > No need to use an atomic if the variable is already protected by a =
lock
> > > > when accessed, and this seems to be case.   =20
> > >=20
> > > Maybe there was a confusion about this lock: I think Boris just do not
> > > want the core to take any lock during a suspend operation. But you can
> > > still use locks, as long as you release them before suspending.
> > >=20
> > > And also, that chip lock might not be the one you want to take because
> > > it's been introduced for another purpose. =20
> >=20
> > Access to the suspended field is already protected by the chip lock,
> > and I think it's just fine to keep it this way. =20
>=20
> I'm reading the suspended variable in wait_event() outside the lock :/

It doesn't matter because you're checking it again with the lock held
when doing a new loop iteration.
