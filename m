Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D51F24DA3CC
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 21:14:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351611AbiCOUPv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 16:15:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234688AbiCOUPu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 16:15:50 -0400
Received: from mail.z3ntu.xyz (mail.z3ntu.xyz [128.199.32.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C3CF5AA7A;
        Tue, 15 Mar 2022 13:14:38 -0700 (PDT)
Received: from g550jk.localnet (a246182.upc-a.chello.nl [62.163.246.182])
        by mail.z3ntu.xyz (Postfix) with ESMTPSA id AF31CCB556;
        Tue, 15 Mar 2022 20:14:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=z3ntu.xyz; s=z3ntu;
        t=1647375275; bh=invxskIdOgqfDDwWrwC5sBLhuscbs9Z9OfNld5S4mXY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=L2oeOX4C6bkNHEBFWrmsaM2MWMfl0hw6j0WEXU/4cTem9TJB/VvFX3esSLGbqLMVL
         /DRvGBKccPcqoyQ1ywoB04lPUYRS1MaVXJtBSius4TJ81oCYncEcV9rjqpaWl4epA7
         t4WYPkpyP+GXyty/f1eHTaV3vks5fDawj+qSJw6s=
From:   Luca Weiss <luca@z3ntu.xyz>
To:     linux-arm-msm@vger.kernel.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 05/10] rpmsg: smd: allow opening rpm_requests even if already opened
Date:   Tue, 15 Mar 2022 21:14:35 +0100
Message-ID: <5558411.DvuYhMxLoT@g550jk>
In-Reply-To: <2630587.mvXUDI8C0e@g550jk>
References: <20220220201909.445468-1-luca@z3ntu.xyz> <20220220201909.445468-6-luca@z3ntu.xyz> <2630587.mvXUDI8C0e@g550jk>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
X-Spam-Status: No, score=0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FROM_SUSPICIOUS_NTLD,
        PDS_OTHER_BAD_TLD,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Montag, 14. M=E4rz 2022 20:08:20 CET Luca Weiss wrote:
> Hi all,
>=20
> any feedback on this patch? It's needed for msm8953 to boot properly.

I was informed that the patch has already been applied and is now also pres=
ent=20
in linux-next, so please disregard my last email.

https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/?
id=3Da8f8cc6b39b7ee0dbaccbebd1268c9d3458ebf13

Regards
Luca

>=20
> Regards
> Luca
>=20
> On Sonntag, 20. Februar 2022 21:18:58 CET Luca Weiss wrote:
> > On msm8953 the channel seems to be already opened when booting Linux but
> > we still need to open it for communication with regulators etc.
> >=20
> > Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
> > ---
> > Changes in v2:
> > - rework original patch, don't drop condition completely but allow force
> >=20
> >   opening rpm_requests channel
> > =20
> >  drivers/rpmsg/qcom_smd.c | 7 ++++++-
> >  1 file changed, 6 insertions(+), 1 deletion(-)
> >=20
> > diff --git a/drivers/rpmsg/qcom_smd.c b/drivers/rpmsg/qcom_smd.c
> > index 540e027f08c4..887e21ca51f2 100644
> > --- a/drivers/rpmsg/qcom_smd.c
> > +++ b/drivers/rpmsg/qcom_smd.c
> > @@ -1288,9 +1288,14 @@ static void qcom_channel_state_worker(struct
> > work_struct *work) if (channel->state !=3D SMD_CHANNEL_CLOSED)
> >=20
> >  			continue;
> >=20
> > +		/*
> > +		 * Always open rpm_requests, even when already opened
>=20
> which is
>=20
> > +		 * required on some SoCs like msm8953.
> > +		 */
> >=20
> >  		remote_state =3D GET_RX_CHANNEL_INFO(channel, state);
> >  		if (remote_state !=3D SMD_CHANNEL_OPENING &&
> >=20
> > -		    remote_state !=3D SMD_CHANNEL_OPENED)
> > +		    remote_state !=3D SMD_CHANNEL_OPENED &&
> > +		    strcmp(channel->name, "rpm_requests"))
> >=20
> >  			continue;
> >  	=09
> >  		if (channel->registered)




