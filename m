Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE45A4AC418
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Feb 2022 16:46:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384237AbiBGPnS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 10:43:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233016AbiBGPeN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 10:34:13 -0500
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::223])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97241C0401CA
        for <linux-kernel@vger.kernel.org>; Mon,  7 Feb 2022 07:34:12 -0800 (PST)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 58FD860008;
        Mon,  7 Feb 2022 15:34:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1644248051;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UNbH3GXexGdP8asRoGUVYUSmCCb0DsippkqLnYR8tlU=;
        b=NaR/jhgiusyCl0F+9RdOyYfrupXLDC8VV/qcRtRuEt4vS3svCLgTIv563RWOw4i+k7B0Ze
        UXp/T202w0dggkozb7gjFMDHn682+IMwdKjPhylUg2ggKyZC+4tiEVkLg/0c5NsJE+ozfX
        B/OBxqFw/Ie52fF2/8R3xlxV8sbzPk7q9Q/pppk1WGtV7UJpUlLzPnaV6LDBe8bV3LBluS
        ZvWvJ657wOJRJZeVPGqTWkiAQIyP0nynuBMTYiTyW2nDifhoJbFodAbiGrxygO1MXu6Nmx
        HMHyUjL1OBfM3SvWSZEz/ncDgE79LohA+x7DfcdgPu4IEs4h9PDFEeZ0PklRXw==
Date:   Mon, 7 Feb 2022 16:34:09 +0100
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Jean-Marc Eurin <jmeurin@google.com>
Cc:     Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] mtdoops: Fix the size of the header read buffer.
Message-ID: <20220207163409.19c3bc4c@xps13>
In-Reply-To: <CAL3wywWSDJUsbgJf4NXctxJmrJRzyO9V-PVcu3qftM1GGPyU_Q@mail.gmail.com>
References: <20220128220156.4057446-1-jmeurin@google.com>
        <20220131110003.7aacad70@xps13>
        <CAL3wywWSDJUsbgJf4NXctxJmrJRzyO9V-PVcu3qftM1GGPyU_Q@mail.gmail.com>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.7 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jean-Marc,

It looks like you changed the title when answering to my question, I
thought this was a v2 and could not find it in patchwork. That is
because the v2 does not actually exist?

jmeurin@google.com wrote on Thu, 3 Feb 2022 17:53:47
-0800:

> On Mon, Jan 31, 2022 at 2:00 AM Miquel Raynal <miquel.raynal@bootlin.com>=
 wrote:
> >
> > Hi Jean-Marc,
> >
> > jmeurin@google.com wrote on Fri, 28 Jan 2022 14:01:56 -0800:
> > =20
> > > The read buffer size depends on the MTDOOPS_HEADER_SIZE.
> > >
> > > Tested: Changed the header size, it doesn't panic, header is still
> > > read/written correctly. =20
> >
> > On what Linux kernel version are you? It looks like we don't share the
> > same code base, are we? =20
>=20
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/d=
rivers/mtd/mtdoops.c?h=3Dv5.17-rc2
> has that bug.  If you try to increase the MTDOOPS_HEADER_SIZE,
> find_next_position() will try to do an mtd_read() of
> MTDOOPS_HEADER_SIZE bytes in a count buffer that is fixed to only 8
> bytes.

I might have checked another function then. Indeed the fix looks legit.

Can you please send a v2 with:
- Your two patches in the same series (formatted with git-format-patch
  to get the dependency/order right)
- In the other commit, drop the reference pointing to (I believe) a
  commit hash that is local to your tree only.
- Use the right prefix ("mtd: mtdoops:").

And we should be good.

>=20
> Thanks,
>=20
> Jean-Marc
>=20
> > =20
> > >
> > > Signed-off-by: Jean-Marc Eurin <jmeurin@google.com>
> > > ---
> > >  drivers/mtd/mtdoops.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/mtd/mtdoops.c b/drivers/mtd/mtdoops.c
> > > index 227df24387df..09a26747f490 100644
> > > --- a/drivers/mtd/mtdoops.c
> > > +++ b/drivers/mtd/mtdoops.c
> > > @@ -223,7 +223,7 @@ static void find_next_position(struct mtdoops_con=
text *cxt)
> > >  {
> > >       struct mtd_info *mtd =3D cxt->mtd;
> > >       int ret, page, maxpos =3D 0;
> > > -     u32 count[2], maxcount =3D 0xffffffff;
> > > +     u32 count[MTDOOPS_HEADER_SIZE/sizeof(u32)], maxcount =3D 0xffff=
ffff;
> > >       size_t retlen;
> > >
> > >       for (page =3D 0; page < cxt->oops_pages; page++) { =20
> >
> >
> > Thanks,
> > Miqu=C3=A8l =20


Thanks,
Miqu=C3=A8l
