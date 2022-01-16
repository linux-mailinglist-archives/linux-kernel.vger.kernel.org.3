Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B556C48FDC5
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Jan 2022 17:08:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235565AbiAPQIi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Jan 2022 11:08:38 -0500
Received: from mail.z3ntu.xyz ([128.199.32.197]:43306 "EHLO mail.z3ntu.xyz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232447AbiAPQIe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Jan 2022 11:08:34 -0500
Received: from g550jk.localnet (ip-213-127-106-2.ip.prioritytelecom.net [213.127.106.2])
        by mail.z3ntu.xyz (Postfix) with ESMTPSA id 95420CE70A;
        Sun, 16 Jan 2022 16:08:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=z3ntu.xyz; s=z3ntu;
        t=1642349310; bh=4LMg+1VVMXQXKYNpkZ8tcMuM7sLu2TwLatA8b+djne4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=wUEfk15OLngMxPUrqY11hbr6UZvR6c6o7n4bmgShT0A2CeSSPbcSDabmkOOyNtxrd
         C8Xx5/Y9K0dpWFdFa9zqsxYBC8jH5poVVNnHP9rm9XEspWaceXijKkWbGMhyWS2B0v
         88IZNlfqxpXtu+WpdgnUZ8zDPcvi9ehnRQcCMEEs=
From:   Luca Weiss <luca@z3ntu.xyz>
To:     Stephan Gerhold <stephan@gerhold.net>
Cc:     linux-arm-msm@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Vladimir Lypak <vladimir.lypak@gmail.com>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Ohad Ben-Cohen <ohad@wizery.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: Re: [PATCH 09/15] rpmsg: smd: Drop unnecessary condition for channel creation
Date:   Sun, 16 Jan 2022 17:08:29 +0100
Message-ID: <12385151.O9o76ZdvQC@g550jk>
In-Reply-To: <Yd9KebiZUjTuHtIM@gerhold.net>
References: <20220112194118.178026-1-luca@z3ntu.xyz> <20220112194118.178026-10-luca@z3ntu.xyz> <Yd9KebiZUjTuHtIM@gerhold.net>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stephan,

On Mittwoch, 12. J=E4nner 2022 22:39:53 CET Stephan Gerhold wrote:
> Hi,
>=20
> +Cc Srinivas
>=20
> On Wed, Jan 12, 2022 at 08:40:58PM +0100, Luca Weiss wrote:
> > From: Vladimir Lypak <vladimir.lypak@gmail.com>
> >=20
> > RPM Firmware on variety of newer SoCs such as MSM8917 (also likely
> > MSM8937, MSM8940, MSM8952), MSM8953 and on some MSM8916 devices) doesn't
> > initiate opening of the SMD channel if it was previously opened by
> > bootloader. This doesn't allow probing of smd-rpm driver on such devices
> > because there is a check that requires RPM this behaviour.
> >=20
> > Signed-off-by: Vladimir Lypak <vladimir.lypak@gmail.com>
> > Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
> > Reviewed-by: Konrad Dybcio <konrad.dybcio@somainline.org>
>=20
> This is effectively a "Revert "Revert "rpmsg: smd: Create device for all
> channels""":
>=20
> https://lore.kernel.org/linux-arm-msm/20171212235857.10432-3-bjorn.anders=
son
> @linaro.org/
> https://lore.kernel.org/linux-arm-msm/20180315181244.8859-1-bjorn.anderss=
on
> @linaro.org/
>=20
> Won't this cause the same regression reported by Srinivas again?
>=20

Do you have any suggestion on another way to solve this? Without this commi=
t=20
the regulators just won't probe at all, I haven't looked very deep into it=
=20
though given this patch solves it.

I guess worst case it'll become a devicetree property to enable this quirk?

Regards
Luca

> Thanks,
> Stephan
>=20
> > ---
> >=20
> >  drivers/rpmsg/qcom_smd.c | 8 +-------
> >  1 file changed, 1 insertion(+), 7 deletions(-)
> >=20
> > diff --git a/drivers/rpmsg/qcom_smd.c b/drivers/rpmsg/qcom_smd.c
> > index 8da1b5cb31b3..6a01ef932b01 100644
> > --- a/drivers/rpmsg/qcom_smd.c
> > +++ b/drivers/rpmsg/qcom_smd.c
> > @@ -1280,19 +1280,13 @@ static void qcom_channel_state_worker(struct
> > work_struct *work)>=20
> >  	unsigned long flags;
> >  =09
> >  	/*
> >=20
> > -	 * Register a device for any closed channel where the remote=20
processor
> > -	 * is showing interest in opening the channel.
> > +	 * Register a device for any closed channel.
> >=20
> >  	 */
> >  =09
> >  	spin_lock_irqsave(&edge->channels_lock, flags);
> >  	list_for_each_entry(channel, &edge->channels, list) {
> >  =09
> >  		if (channel->state !=3D SMD_CHANNEL_CLOSED)
> >  	=09
> >  			continue;
> >=20
> > -		remote_state =3D GET_RX_CHANNEL_INFO(channel, state);
> > -		if (remote_state !=3D SMD_CHANNEL_OPENING &&
> > -		    remote_state !=3D SMD_CHANNEL_OPENED)
> > -			continue;
> > -
> >=20
> >  		if (channel->registered)
> >  	=09
> >  			continue;




