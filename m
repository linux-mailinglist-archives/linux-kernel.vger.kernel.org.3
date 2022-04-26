Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 945E150F265
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 09:28:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343913AbiDZHb2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 03:31:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245098AbiDZHb1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 03:31:27 -0400
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3B12C8BF4
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 00:28:20 -0700 (PDT)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 023C9C0012;
        Tue, 26 Apr 2022 07:28:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1650958099;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tlA6eFLQiQcvdObgX0y/KAZVkQq8yyldXd7UmkZhtaw=;
        b=nILske/qJ9cD7oEE4ATOk9UuLAW6GjGK0Hs64tIkF4UtPq9cTnKW78SkDHuuIQKS2q8jjS
        gyP/2CZOIKPS8qb3EafIJXfvJFv3YMh1cBy9lxaTBAMTkTuQ28YIaFlVBHFOIgxIEUj29z
        oi0j0L/rPPvMAASHWcAHKMSS3P33mOgKfUy+swJMRtdMxB17aHDJ0xmlOXWJQ7WMPyMQsD
        iQdoBzh2TKdDPpzigBFiesu+pxZ44hDuUaaKU7N8fQE8dw/hfMp8C6rn3vPnH66LMjdpfs
        ocvTz5+KfJ9YGRjSxz/GgYusH34tQ+kfzTFYohCCRccNMFkwbt09IIEzzsAmjw==
Date:   Tue, 26 Apr 2022 09:28:18 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Jean-Marc Eurin <jmeurin@google.com>
Cc:     Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 0/3] mtd: mtdoops: Add timestamp to the dumped oops
 header.
Message-ID: <20220426092818.530b7e9b@xps13>
In-Reply-To: <CAL3wywVS0EyBNQ_vp+TDdxO1=x4PgTZoyzGJ8-5qXzhCd0uOcw@mail.gmail.com>
References: <20220415001321.252848-1-jmeurin@google.com>
        <20220421234244.2172003-1-jmeurin@google.com>
        <20220425104201.173e65fa@xps13>
        <CAL3wywVS0EyBNQ_vp+TDdxO1=x4PgTZoyzGJ8-5qXzhCd0uOcw@mail.gmail.com>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.7 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jean-Marc,

jmeurin@google.com wrote on Mon, 25 Apr 2022 09:14:08 -0700:

> Hi Miquel,
>=20
>=20
> On Mon, Apr 25, 2022 at 1:42 AM Miquel Raynal <miquel.raynal@bootlin.com>=
 wrote:
> >
> > Hi Jean-Marc,
> >
> > jmeurin@google.com wrote on Thu, 21 Apr 2022 16:42:41 -0700:
> > =20
> > > The current header consists of 2 32-bit values which makes it difficu=
lt
> > > and error prone to expand. This creates a structure for the header.
> > >
> > > Some oops only have time relative to boot, this adds an absolute time=
stamp.
> > >
> > > Changelog since v3:
> > >   Fix the printk format for sizeof to %zu.
> > >
> > > Changelog since v2:
> > > - Add a timestamp to the header.
> > >
> > > Changelog since v1:
> > > - Create a header structure to simplify code.
> > > - Patches in series.
> > > - Patch prefix.
> > >
> > > Jean-Marc Eurin (3):
> > >   mtd: mtdoops: Fix the size of the header read buffer.
> > >   mtd: mtdoops: Create a header structure for the saved mtdoops.
> > >   mtd: mtdoops: Add a timestamp to the mtdoops header. =20
> >
> > Looks like the last patch was not sent to the list?
> > =20
>=20
> I'm not sure what happened.  I've just sent it and then noticed that
> the mail threading is wrong.  Let me know if you want me to resend the
> full thread.

It's fine like that.

>=20
> I'm really sorry about that :-( and thanks for all your help.

No problem!

Cheers,
Miqu=C3=A8l
