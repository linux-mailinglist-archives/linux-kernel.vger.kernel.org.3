Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96A304A5DB2
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Feb 2022 14:52:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238915AbiBANwO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 08:52:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230073AbiBANwM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 08:52:12 -0500
Received: from relay11.mail.gandi.net (relay11.mail.gandi.net [IPv6:2001:4b98:dc4:8::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3368AC061714;
        Tue,  1 Feb 2022 05:52:11 -0800 (PST)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 64B9B100002;
        Tue,  1 Feb 2022 13:52:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1643723529;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9wWj1va3LmxR7uptoK225JjVfSAKX5gP2e5O2jvKmFs=;
        b=FolHXnBTaVk5XuRbTsW0DHX9gYw9CMcJbrjgFF4wiTfKl2KYiL7HuQbhq7Mi+UDXj6jrPl
        m4SZGAaMeRPJyg51mND/9QvniCge/K1OBcfJPLVBHrbtWqwxXYrBVltNvhbhPyUQumb6Sj
        fUkh89Orf94sEUL+u8UBtI5MFRzHhtcQc7fS5/GNJqbeGa5+ZrvKzbJgnhx22Hk8agp20O
        FeTPGPilihUAJRzFPeZbCyu9Kz9BLq7AshbdfvQdgakW6JGpJ00dnlMzdSi2dCsTxn/TrD
        g4iipY2XrNCbpMEc4VBMcBcT1IGszN4Vn6x0Q9XaC8+FGNrKp/XZC6KPr/vJUg==
Date:   Tue, 1 Feb 2022 14:52:04 +0100
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Konrad Dybcio <konrad.dybcio@somainline.org>
Cc:     Sricharan Ramabadhran <sricharan@codeaurora.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        pragalla@codeaurora.org, ~postmarketos/upstreaming@lists.sr.ht,
        martin.botka@somainline.org,
        angelogioacchino.delregno@somainline.org,
        marijn.suijten@somainline.org, jamipkettunen@somainline.org,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-mtd@lists.infradead.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, mdalam@codeaurora.org
Subject: Re: [PATCH] mtd: nand: raw: qcom_nandc: Don't clear_bam_transaction
 on READID
Message-ID: <20220201145204.54646475@xps13>
In-Reply-To: <12cad24a-fa2f-9a82-cf43-241a0a6fe4f6@somainline.org>
References: <20220113184427.2259509-1-konrad.dybcio@somainline.org>
        <20220114082718.32a2fc83@xps13>
        <20220126111613.3ab0021e@xps13>
        <20220126103316.GA212068@thinkpad>
        <20220126114200.4cc3c21b@xps13>
        <fc80a6e7-bd44-3b3e-fca2-1316a76d65f5@codeaurora.org>
        <a6fcc533-e7cd-7b55-4db0-cec80c07b46a@codeaurora.org>
        <0a8d6550-aa19-0af1-abae-66bf34c91ea8@somainline.org>
        <be779ed9-bd80-8f01-fe7f-d3c07d3d85aa@codeaurora.org>
        <12cad24a-fa2f-9a82-cf43-241a0a6fe4f6@somainline.org>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.7 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Konrad,

konrad.dybcio@somainline.org wrote on Mon, 31 Jan 2022 20:54:12 +0100:

> On 31/01/2022 15:13, Sricharan Ramabadhran wrote:
> > Hi Konrad,
> >
> > On 1/31/2022 3:39 PM, Konrad Dybcio wrote: =20
> >>
> >> On 28/01/2022 18:50, Sricharan Ramabadhran wrote: =20
> >>> Hi Konrad,
> >>>
> >>> On 1/28/2022 9:55 AM, Sricharan Ramabadhran wrote: =20
> >>>> Hi Miquel,
> >>>>
> >>>> On 1/26/2022 4:12 PM, Miquel Raynal wrote: =20
> >>>>> Hi Mani,
> >>>>>
> >>>>> mani@kernel.org wrote on Wed, 26 Jan 2022 16:03:16 +0530:
> >>>>> =20
> >>>>>> On Wed, Jan 26, 2022 at 11:16:13AM +0100, Miquel Raynal wrote: =20
> >>>>>>> Hello,
> >>>>>>>
> >>>>>>> miquel.raynal@bootlin.com wrote on Fri, 14 Jan 2022 08:27:18 +010=
0: =20
> >>>>>>>> Hi Konrad,
> >>>>>>>>
> >>>>>>>> konrad.dybcio@somainline.org wrote on Thu, 13 Jan 2022 19:44:26 =
>>>>>>>> +0100: =20
> >>>>>>>>> While I have absolutely 0 idea why and how, running >>>>>>>>> c=
lear_bam_transaction
> >>>>>>>>> when READID is issued makes the DMA totally clog up and refuse =
>>>>>>>>> to function
> >>>>>>>>> at all on mdm9607. In fact, it is so bad that all the data >>>>=
>>>>> gets garbled
> >>>>>>>>> and after a short while in the nand probe flow, the CPU >>>>>>>=
>> decides that
> >>>>>>>>> sepuku is the only option.
> >>>>>>>>>
> >>>>>>>>> Removing _READID from the if condition makes it work like a >>>=
>>>>>> charm, I can
> >>>>>>>>> read data and mount partitions without a problem.
> >>>>>>>>>
> >>>>>>>>> Signed-off-by: Konrad Dybcio <konrad.dybcio@somainline.org>
> >>>>>>>>> ---
> >>>>>>>>> This is totally just an observation which took me an inhumane >=
>>>>>>>> amount of
> >>>>>>>>> debug prints to find.. perhaps there's a better reason behind >=
>>>>>>>> this, but
> >>>>>>>>> I can't seem to find any answers.. Therefore, this is a BIG RFC=
! =20
> >>>>>>>> I'm adding two people from codeaurora who worked a lot on this >=
>>>>>>> driver.
> >>>>>>>> Hopefully they will have an idea :) =20
> >>>>>>> Sadre, I've spent a significant amount of time reviewing your >>>=
>>>> patches,
> >>>>>>> now it's your turn to not take a month to answer to your peers
> >>>>>>> proposals.
> >>>>>>>
> >>>>>>> Please help reviewing this patch. =20
> >>>>>> Sorry. I was hoping that Qcom folks would chime in as I don't >>>>=
>> have any idea
> >>>>>> about the mdm9607 platform. It could be that the mail server >>>>>=
> migration from
> >>>>>> codeaurora to quicinc put a barrier here.
> >>>>>>
> >>>>>> Let me ping them internally. =20
> >>>>> Oh, ok, I didn't know. Thanks! =20
> >>>>
> >>>> =C2=A0=C2=A0 Sorry Miquel, somehow we did not get this email in our =
inbox.
> >>>> =C2=A0=C2=A0 Thanks to Mani for pinging us, we will test this up tod=
ay and >>>> get back.
> >>>> =20
> >>> =C2=A0 =C2=A0 =C2=A0 While we could not reproduce this issue on our i=
pq boards (do >>> not have a mdm9607 right now) and
> >>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 issue does not look any obvious.
> >>> =C2=A0 =C2=A0 =C2=A0 can you please give the debug logs that you did =
for the above >>> stage by stage ? =20
> >>
> >> I won't have access to the board for about two weeks, sorry.
> >>
> >> When I get to it, I'll surely try to send you the logs, though there
> >>
> >> wasn't much more than just something jumping to who-knows-where
> >>
> >> after clear_bam_transaction was called, resulting in values >> associa=
ted with
> >>
> >> the NAND being all zeroed out in pr_err/_debug/etc.
> >>
> >> =20
> > =C2=A0=C2=A0=C2=A0 Ok sure. So was the READID command itself failing (o=
r) the > subsequent one ?
> > =C2=A0=C2=A0 We can check which parameter reset by the clear_bam_transa=
ction is > causing the
> > =C2=A0=C2=A0 failure.=C2=A0 Meanwhile, looping in Pradeep who has acces=
s to the > board, so in a better
> > =C2=A0=C2=A0 position to debug. =20
>=20
> I'm sorry I have so few details on hand, and no kernel tree (no access to=
 that machine either, for now).
>=20
>=20
> I will try to describe to the best of my abilities what I recall.
>=20
>=20
> My methodology of making sure things don't go haywire was to print the oo=
b size
>=20
> of our NAND basically every two lines of code (yes, i was very desperate =
at one point),
>=20
> as that was zeroed out when *the bug* happened,

This does look like a pointer error at some point and some kernel data
has been corrupted very badly by the driver.

> leading to a kernel bug/panic/stall
>=20
> (can't recall what exactly it was, but it said something along the lines =
of "no support for
>=20
> oob size 0" and then it didn't fail graceully, leading to some bad jumps =
and ultimately
>=20
> a dead platform..)
>=20
>=20
> after hours of digging, I found out that everything goes fine until clear=
_bam_transaction is called,

Do you remember if this function was called for the first time when
this happened?

> after that gets executed every nand op starts reading all zeroes (for exa=
mple in JEDEC ID check)
>=20
> so I added the changes from this patch, and things magically started work=
ing... My suspicion is
>=20
> that the underlying FIFO isn't fully drained (is it a FIFO on 9607? bah, =
i work on too many socs at once)

I don't see it in the list of supported devices, what's the exact
compatible used?

>=20
> and this function only makes Linux think it is, without actually draining=
 it, and the leftover
>=20
> commands get executed with some parts of them getting overwritten, result=
ing in the
>=20
> famous garbage in - garbage out situation, but that's only a guesstimate..

I would bet for a non allocated bam-ish pointer that is reset to zero
in the clear_bam_transaction() helper.

Can you get your hands on the board again?
It would be nice to check if the allocation always occurs before use,
and if yes on how much bytes.

If the pointer is not dangling, then perhaps something else smashes
that pointer.

> Do note this somehow worked fine on 5.11 and then broke on 5.12/13. I wen=
t as far as replacing most
>=20
> of the kernel with the updated/downgraded parts via git checkout (i tried=
 many combinations),
>=20
> to no avail.. I even tried different compilers and optimization levels, t=
hinking it could have been
>=20
> a codegen issue, but no luck either.
>=20
>=20
> I.. do understand this email is a total mess to read, as much as it was t=
o write, but
>=20
> without access to my code and the machine itself I can't give you solid d=
etails, and
>=20
> the fact this situation is far from ordinary doesn't help either..
>=20
>=20
> The latest (ancient, not quite pretty, but probably working if my memory =
is correct) version of my patches
>=20
> for the mdm9607 is available at [1], I will push the new revision after I=
 get access to the workstation.
>=20
>=20
> Konrad
>=20
>=20
> [1] https://github.com/SoMainline/linux/commits/konrad/pinemodem
>=20
>=20
> >
> > Regards,
> > =C2=A0=C2=A0 Sricharan
> >
> > =20


Thanks,
Miqu=C3=A8l
