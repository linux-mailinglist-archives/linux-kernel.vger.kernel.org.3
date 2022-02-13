Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2D134B3D96
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Feb 2022 21:51:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238339AbiBMUvX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Feb 2022 15:51:23 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:56772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238297AbiBMUvS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Feb 2022 15:51:18 -0500
Received: from mail.z3ntu.xyz (mail.z3ntu.xyz [128.199.32.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A859A53717;
        Sun, 13 Feb 2022 12:51:12 -0800 (PST)
Received: from g550jk.localnet (mobiledyn-62-240-134-32.mrsn.at [62.240.134.32])
        by mail.z3ntu.xyz (Postfix) with ESMTPSA id 9C480C6663;
        Sun, 13 Feb 2022 20:51:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=z3ntu.xyz; s=z3ntu;
        t=1644785471; bh=9MXa6ypwqHPugUz9R83CYNLxExHJTxgjpEJeOoX190c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=hWZ+p/0AUdCNsc8zdR11AHFgAbrp5cW+wBUSg81w5udgpwi/Dx20I8Tz7SIlgszDn
         ishgkpbjGG33o0XLa2T1zfriZ2uuq1PhWYKqgV/wpWoAjDIMA8jTK9qPbi1RrohR9a
         zMR6ZSrb7MmBjLJ4qytu2ynl5hiIsaq9BVmrba4U=
From:   Luca Weiss <luca@z3ntu.xyz>
To:     Stephan Gerhold <stephan@gerhold.net>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Vladimir Lypak <vladimir.lypak@gmail.com>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Andy Gross <agross@kernel.org>,
        Ohad Ben-Cohen <ohad@wizery.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: Re: [PATCH 09/15] rpmsg: smd: Drop unnecessary condition for channel creation
Date:   Sun, 13 Feb 2022 21:51:09 +0100
Message-ID: <3503848.e9J7NaK4W3@g550jk>
In-Reply-To: <2615776.mvXUDI8C0e@g550jk>
References: <20220112194118.178026-1-luca@z3ntu.xyz> <Yfhjil3pfZLa5g3j@builder.lan> <2615776.mvXUDI8C0e@g550jk>
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

Hi Bjorn,

On Sonntag, 6. Februar 2022 21:17:22 CET Luca Weiss wrote:
> Hi Bjorn,
>=20
> On Montag, 31. J=E4nner 2022 23:32:42 CET Bjorn Andersson wrote:
> > On Sun 16 Jan 10:30 CST 2022, Stephan Gerhold wrote:
> > > On Sun, Jan 16, 2022 at 05:08:29PM +0100, Luca Weiss wrote:
> > > > On Mittwoch, 12. J=E4nner 2022 22:39:53 CET Stephan Gerhold wrote:
> > > > > On Wed, Jan 12, 2022 at 08:40:58PM +0100, Luca Weiss wrote:
> > > > > > From: Vladimir Lypak <vladimir.lypak@gmail.com>
> > > > > >=20
> > > > > > RPM Firmware on variety of newer SoCs such as MSM8917 (also lik=
ely
> > > > > > MSM8937, MSM8940, MSM8952), MSM8953 and on some MSM8916 devices)
> > > > > > doesn't
> > > > > > initiate opening of the SMD channel if it was previously opened=
 by
> > > > > > bootloader. This doesn't allow probing of smd-rpm driver on such
> > > > > > devices
> > > > > > because there is a check that requires RPM this behaviour.
> > > > > >=20
> > > > > > Signed-off-by: Vladimir Lypak <vladimir.lypak@gmail.com>
> > > > > > Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
> > > > > > Reviewed-by: Konrad Dybcio <konrad.dybcio@somainline.org>
> > > > >=20
> > > > > This is effectively a "Revert "Revert "rpmsg: smd: Create device =
for
> > > > > all
> > > > > channels""":
> > > > >=20
> > > > > https://lore.kernel.org/linux-arm-msm/20171212235857.10432-3-bjor=
n.a
> > > > > nd
> > > > > ersson @linaro.org/
> > > > > https://lore.kernel.org/linux-arm-msm/20180315181244.8859-1-bjorn=
=2Ean
> > > > > de
> > > > > rsson
> > > > > @linaro.org/
> > > > >=20
> > > > > Won't this cause the same regression reported by Srinivas again?
> > > >=20
> > > > Do you have any suggestion on another way to solve this? Without th=
is
> > > > commit the regulators just won't probe at all, I haven't looked very
> > > > deep into it though given this patch solves it.
> > > >=20
> > > > I guess worst case it'll become a devicetree property to enable this
> > > > quirk?
> > >=20
> > > My spontaneous suggestion would be to skip the check only for the
> > > "rpm_requests" channel, e.g. something like
> > >=20
> > > 	if (remote_state !=3D SMD_CHANNEL_OPENING &&
> > > =09
> > > 	    remote_state !=3D SMD_CHANNEL_OPENED &&
> > > 	    strcmp(channel->name, "rpm_requests")
> > > 	=09
> > > 		continue;
> > >=20
> > > This will avoid changing the behavior for anything but the RPM channe=
l.
> > > I don't think anything else is affected by the same problem (since the
> > > bootloader or earlier firmware should not make use of any other
> > > channel).
> > > Also, we definitely *always* want to open the channel to the RPM beca=
use
> > > otherwise almost everything breaks.
> >=20
> > Last time this came up I asked if someone could test if the RPM is stuck
> > in the state machine trying to close the channel and as such we could
> > kick it by making sure that we "ack" the closing of the channel and
> > hence it would come back up again.
> >=20
> > But I don't remember seeing any outcome of this.
>=20
> Do you have a link to this or should I go digging in the archives?

Replying to myself, I went searching but couldn't find anything. If you hav=
e=20
some PoC code I'd be happy to try but as I'm not familiar with rpm/smd at a=
ll=20
I'd have to read myself into it first.

If Stephans suggestion with the strcmp(channel->name, "rpm_requests") is ok=
=20
then I'd test this and use that in v2. I'd personally rather not spend too=
=20
much time on this issue right now as it's blocking msm8953 completely (no=20
regulators =3D no nothing),

Regards
Luca

>=20
> Regards
> Luca
>=20
> > > Many solutions are possible though so at the end it is mostly up to
> > > Bjorn to decide I think. :)
> >=20
> > I would prefer to get an answer to above question, but if that doesn't
> > work (or look like crap) I'm willing to take your suggestion of skipping
> > the continue for the rpm_requests channel. Obviously with a comment
> > above describing why we're carrying that special case.
> >=20
> > Regards,
> > Bjorn




