Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EF064F49F2
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 02:36:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1453504AbiDEWdJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 18:33:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353614AbiDEKIe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 06:08:34 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EAB0C3358
        for <linux-kernel@vger.kernel.org>; Tue,  5 Apr 2022 02:55:31 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id bh17so25558700ejb.8
        for <linux-kernel@vger.kernel.org>; Tue, 05 Apr 2022 02:55:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=c9bcsFTz7o1nm6T6sdAD3XwMAfi3610i3GxsLP1j6GY=;
        b=bWkvwp9wKo7oK0PWO7l+fyV9iJKA01a9CrDr8gPEZrRYTMyPiW7uH0PnKGKYi/V2qO
         8+wfTV2QScMQCc3WMmmmqbhUsW3o0XiKVmUddIdgEiKvHaiQw8RYSHt4WKn11X/jFTUu
         ctH0fgMUoQ+98re9S7pbjyVRqKnlEY1uFtBFZLPfMszzjCJn8KgyCkYsa1NENh34dlPl
         /w80buM+JoFVZQvayAM0w0MsuGRoCKDl064zYloABRjlWZ5G5nQRGMCPBuJnibxV4Ceu
         Sj2s9pXXsj9PwGVlnRUxP2pE96TGF/O5f287B225fOlHhvR5u6BgXEJEy9c5Fn1/+Fep
         /Kzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=c9bcsFTz7o1nm6T6sdAD3XwMAfi3610i3GxsLP1j6GY=;
        b=pJg88aOrClXaLoetQO2nLSFNSyH1jwfmn+Z7dLo0Z/IgOv66A7p3uBL/esvupYvu9/
         IuccWqGSPf/rDBo2lRsxDxAP7IkX/CivyycobVjIBNfh/JOaPv3lHgdq4HO0MMUMOdhu
         Vu5wXRt6DP0taL3OX8m1wLEH/JbwD40cdzcuuhekWWMlidDO5Qlilw1bjUchqnNhXjOX
         RFP0GV4URZMpoQ3Rf9rktuWqsagWCfy+rqiD1v2Yd7HD8rW+zTQMOX0QO5Ev36QvVmp/
         vYKYYjHaoh0t6Dta69TNTR02Qtvu0izY9rNibe+RxZCvA+Ia3/5tG+Q+tjjaglrnJD4y
         TJag==
X-Gm-Message-State: AOAM532OsCud0HBXXz+B/7lhMB43GSbvfEtpKbRR0UvtI+ntXLeFOkMS
        ulicltMCN9WJFNuhGYl9o7ObFZPZ+P+7+/AaICg=
X-Google-Smtp-Source: ABdhPJxqX58QBB/FJLa4jq5hUa9Gru6wPvY57zbPfPCDS76TiHrgDvbMWpCcLLa+fN7M0ssz08RmFGqaUq6S5QWTMNg=
X-Received: by 2002:a17:906:7714:b0:6ba:8a6a:b464 with SMTP id
 q20-20020a170906771400b006ba8a6ab464mr2587437ejm.613.1649152529642; Tue, 05
 Apr 2022 02:55:29 -0700 (PDT)
MIME-Version: 1.0
References: <20211120193916.1309236-1-aford173@gmail.com> <319e976acb0a686e596b88520dbcda59c78afe9e.camel@pengutronix.de>
 <CAHCN7x+5HXJEdRKbm80trpNwxZRAMhX12+FQ0JeVvrqKpKf+BA@mail.gmail.com> <20220405064458.GA129381@dragon>
In-Reply-To: <20220405064458.GA129381@dragon>
From:   Adam Ford <aford173@gmail.com>
Date:   Tue, 5 Apr 2022 04:55:18 -0500
Message-ID: <CAHCN7xKShNswT2JDZFZ9vSQ9_Kk1T+Ow3+=9as8sZ7mDQ6E1Vg@mail.gmail.com>
Subject: Re: [PATCH] soc: imx: gpcv2: keep i.MX8MM VPU-H1 bus clock active
To:     Shawn Guo <shawnguo@kernel.org>
Cc:     Lucas Stach <l.stach@pengutronix.de>,
        arm-soc <linux-arm-kernel@lists.infradead.org>,
        Tim Harvey <tharvey@gateworks.com>,
        Adam Ford-BE <aford@beaconembedded.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Peng Fan <peng.fan@nxp.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 5, 2022 at 1:45 AM Shawn Guo <shawnguo@kernel.org> wrote:
>
> On Thu, Mar 31, 2022 at 06:32:13AM -0500, Adam Ford wrote:
> > On Thu, Mar 31, 2022 at 4:28 AM Lucas Stach <l.stach@pengutronix.de> wrote:
> > >
> > > Hi Adam, hi Shawn,
> > >
> > > Am Samstag, dem 20.11.2021 um 13:39 -0600 schrieb Adam Ford:
> > > > Enable the vpu-h1 clock when the domain is active because reading
> > > > or writing to the VPU-H1 IP block cause the system to hang.
> > > >
> > > > Fixes: 656ade7aa42a ("soc: imx: gpcv2: keep i.MX8M* bus clocks enabled")
> > > > Signed-off-by: Adam Ford <aford173@gmail.com>
> > > >
> > > > diff --git a/drivers/soc/imx/gpcv2.c b/drivers/soc/imx/gpcv2.c
> > > > index b8d52d8d29db..7b6dfa33dcb9 100644
> > > > --- a/drivers/soc/imx/gpcv2.c
> > > > +++ b/drivers/soc/imx/gpcv2.c
> > > > @@ -734,6 +734,7 @@ static const struct imx_pgc_domain imx8mm_pgc_domains[] = {
> > > >                       .map = IMX8MM_VPUH1_A53_DOMAIN,
> > > >               },
> > > >               .pgc   = BIT(IMX8MM_PGC_VPUH1),
> > > > +             .keep_clocks = true,
> > > >       },
> > > >
> > > I missed this patch and just stumbled across it when looking at the git
> > > history. I don't think this patch is correct. The H1 GPC domain does
> > > not even have clocks assigned in the DT, so there is nothing to keep
> > > active. Also H1 is not a MIX domain, so it should not keep any bus
> > > clocks active, that is the job of the VPUMIX domain.
> > >
> > > While this patch is a no-op, as far as I can see, it still seems wrong
> > > and I think it should be reverted.
> >
> > At the time I sent this, I was working with some people in the media
> > group to split the G1 and G2 up in the imx8mq and add G1 and G2
> > support in the imx8mm.  I had inquired about the feasibility of using
> > the H1 encoder on the imx8mm, but I needed to read some registers from
> > the IP block to see which features were fused out.  I tried several
> > different options to get the H1 to not hang when reading registers,
> > and that was the only solution I found that worked.  I thought it odd
> > as well since the G1 and G2 decoders didn't appear to need this.
> > However, during the course of my investigation, I learned that the
> > JPEG encoder was fused out of the imx8mm, and there wasn't a plan to
> > add VP8 or H.264 encodering any time soon.   Since it is, as you put
> > it, a no-op, I have no objections to reverting it.
>
> I do not quite follow.  You claimed that the change fixes a system hang.
> Are we getting the hang back if we revert the change?

It was hanging when I has trying to use the H1 VPU, and this did fix
it, but it seemed weird to me.  Unfortunately, Hantro H1 driver that
is currently in Linux only supports JPEG, and the H1 VPU in the imx8mm
has JPEG fused out.  As of right now, there is no H1 VPU consumer, so
there is nobody attempting to enable the H1 power domain, so it
remains a no-op.  If it's reverted, we'll have to revisit the issue in
the future to prevent the hanging, but that will also require a new
Hantro driver.

adam
>
> Shawn
