Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32D234A3F8C
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jan 2022 10:52:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240974AbiAaJw3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jan 2022 04:52:29 -0500
Received: from relay11.mail.gandi.net ([217.70.178.231]:40737 "EHLO
        relay11.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232052AbiAaJw0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jan 2022 04:52:26 -0500
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 6669B100005;
        Mon, 31 Jan 2022 09:52:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1643622744;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HR7lv1T/atYm0h435spzd7hIdETqddhxHf3ercKSY/E=;
        b=DzNdOWCmYphISup4FHoUxnP+Y0rM3AcJduH72xPTeetXuaDyW6CpnnOy2gWw7jwNSnwhDw
        hmmE6rrLvNVmSmIAWvJpuMoHM9tQNpLb+zNxxqdqMSkgRozdXHmWHHL4ErZGqgWomZf3Eb
        c1/R0olzTVt7FqaHwo6yyB00Wa4Ixm2rSx9wNhn4ozVAZYkRNqlSav/9dwmVLDDV4rnE0T
        1Tm+ij2vAbmdcsKHSHI+Arh5YZ3I4jbxvXrCEQT/NeAQbMDppHzeT1+wAxVM3v9GPgmMnj
        JvlMkvH7l/KS8coCouqQCZ8dbjNK6DMuhfho1FBn5+AT8m0VgadRosascbuzVw==
Date:   Mon, 31 Jan 2022 10:52:20 +0100
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Sricharan Ramabadhran <sricharan@codeaurora.org>
Cc:     Manivannan Sadhasivam <mani@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        ~postmarketos/upstreaming@lists.sr.ht, martin.botka@somainline.org,
        angelogioacchino.delregno@somainline.org,
        marijn.suijten@somainline.org, jamipkettunen@somainline.org,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-mtd@lists.infradead.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, mdalam@codeaurora.org
Subject: Re: [PATCH] mtd: nand: raw: qcom_nandc: Don't clear_bam_transaction
 on READID
Message-ID: <20220131105220.167bacaf@xps13>
In-Reply-To: <a6fcc533-e7cd-7b55-4db0-cec80c07b46a@codeaurora.org>
References: <20220113184427.2259509-1-konrad.dybcio@somainline.org>
        <20220114082718.32a2fc83@xps13>
        <20220126111613.3ab0021e@xps13>
        <20220126103316.GA212068@thinkpad>
        <20220126114200.4cc3c21b@xps13>
        <fc80a6e7-bd44-3b3e-fca2-1316a76d65f5@codeaurora.org>
        <a6fcc533-e7cd-7b55-4db0-cec80c07b46a@codeaurora.org>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.7 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sricharan,

sricharan@codeaurora.org wrote on Fri, 28 Jan 2022 23:20:04 +0530:

> Hi Konrad,
>=20
> On 1/28/2022 9:55 AM, Sricharan Ramabadhran wrote:
> > Hi Miquel,
> >
> > On 1/26/2022 4:12 PM, Miquel Raynal wrote: =20
> >> Hi Mani,
> >>
> >> mani@kernel.org wrote on Wed, 26 Jan 2022 16:03:16 +0530:
> >> =20
> >>> On Wed, Jan 26, 2022 at 11:16:13AM +0100, Miquel Raynal wrote: =20
> >>>> Hello,
> >>>>
> >>>> miquel.raynal@bootlin.com wrote on Fri, 14 Jan 2022 08:27:18 +0100: =
=20
> >>>>> Hi Konrad,
> >>>>>
> >>>>> konrad.dybcio@somainline.org wrote on Thu, 13 Jan 2022 19:44:26 >>>=
>> +0100: =20
> >>>>>> While I have absolutely 0 idea why and how, running >>>>>> clear_b=
am_transaction
> >>>>>> when READID is issued makes the DMA totally clog up and refuse to =
>>>>>> function
> >>>>>> at all on mdm9607. In fact, it is so bad that all the data gets >>=
>>>> garbled
> >>>>>> and after a short while in the nand probe flow, the CPU decides th=
at
> >>>>>> sepuku is the only option.
> >>>>>>
> >>>>>> Removing _READID from the if condition makes it work like a >>>>>>=
 charm, I can
> >>>>>> read data and mount partitions without a problem.
> >>>>>>
> >>>>>> Signed-off-by: Konrad Dybcio <konrad.dybcio@somainline.org>
> >>>>>> ---
> >>>>>> This is totally just an observation which took me an inhumane >>>>=
>> amount of
> >>>>>> debug prints to find.. perhaps there's a better reason behind >>>>=
>> this, but
> >>>>>> I can't seem to find any answers.. Therefore, this is a BIG RFC! =
=20
> >>>>> I'm adding two people from codeaurora who worked a lot on this >>>>=
> driver.
> >>>>> Hopefully they will have an idea :) =20
> >>>> Sadre, I've spent a significant amount of time reviewing your patche=
s,
> >>>> now it's your turn to not take a month to answer to your peers
> >>>> proposals.
> >>>>
> >>>> Please help reviewing this patch. =20
> >>> Sorry. I was hoping that Qcom folks would chime in as I don't have >>=
> any idea
> >>> about the mdm9607 platform. It could be that the mail server >>> migr=
ation from
> >>> codeaurora to quicinc put a barrier here.
> >>>
> >>> Let me ping them internally. =20
> >> Oh, ok, I didn't know. Thanks! =20
> >
> > =C2=A0=C2=A0 Sorry Miquel, somehow we did not get this email in our inb=
ox.
> > =C2=A0=C2=A0 Thanks to Mani for pinging us, we will test this up today =
and get > back.
> > =20
>  =C2=A0 =C2=A0 =C2=A0 While we could not reproduce this issue on our ipq =
boards (do not have a mdm9607 right now) and
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 issue does not look any obvious.
>  =C2=A0 =C2=A0 =C2=A0 can you please give the debug logs that you did for=
 the above stage by stage ?

Thanks for stepping up, it is really appreciated, good luck both for
the debugging.

Thanks,
Miqu=C3=A8l
