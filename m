Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31DEE4E7896
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Mar 2022 17:02:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376735AbiCYQDy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Mar 2022 12:03:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376725AbiCYQDs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Mar 2022 12:03:48 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA7E5A0BE0
        for <linux-kernel@vger.kernel.org>; Fri, 25 Mar 2022 09:02:13 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id qx21so16219827ejb.13
        for <linux-kernel@vger.kernel.org>; Fri, 25 Mar 2022 09:02:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dt8vhtKiPbsbCcDg8xMi/AmQ4OjbxYDQR91N6G2Nv8U=;
        b=eP8Y1tjZ6Fdx7y7CstaqPOR2P+1OEINFk5F6Bwa9lUeoWBBkhaHuJtY6k8zbPtWyCg
         f7XoErNmsZauAx5rC9HMwlTYgDfa3BqTJA0Cv1TAsGrAi8mQsFjLR08Enal2k/SCXm5B
         aUCn20OP1arKyyd9nvLs9BSAsuWvEvzBmoP06jeVWquGZvlVHOfV2RjVYj2xx8jyp/JN
         3Unv+3DTQsp3tzz0yV2O26ZTcjFz1Q5zv0HXS3E2N071d3WYozi3OD12Dobq3GBagrAH
         JlDoZBVgf8+uvzc8H5aGLis/dw8UzksD2rlTlEq19nCuo+U20FfMPH6sO+7D7qq2QMqy
         incw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dt8vhtKiPbsbCcDg8xMi/AmQ4OjbxYDQR91N6G2Nv8U=;
        b=nQZuAW7Z+k9ORlk6twVmbxJFzJeGRcO3QqBIK5OirZvxFxo0NJRReDPEa3waNY+wA6
         OoC0ho50C4l0+8fU5WgskH0l9B2jrit68Mqf88qP54QCQtzZzW8CtbAuiTuo22jeSVus
         QkhDUDCYjdSzYnSGeajLfphWaQ/BJpa9HwkNG2NIRqzA8746A3D5o/jHn/wMqxg006jh
         WwqXvmhl63mNMQ58Kj12dTMKsPaw44JnVeqe2QpG7ty/HDh/OT4ehsebRzIOF934j6P8
         P422Pw3UNtGxFHcqXVtSRwFYfp4dhOeZ/dFivKL6YdWhQzuoQErkG9Emy3yeJvy4y9Yu
         U9pg==
X-Gm-Message-State: AOAM532gACZzFUY/SbjS4Ose+16vqkjQwnbLhViUisLA2f08O0oh4JQl
        LiNxQ+EzqSm5uVYPoE4fZxJMjUh8xTqTmlEu2bwAIw==
X-Google-Smtp-Source: ABdhPJzmBi+FlxvitVY57HS8NQh5UNF9rAYcKlF0M2lOGrob4PNv04aYCTE6rtAPsF1CNE1q/tI+Z+043IpaLxVk+7U=
X-Received: by 2002:a17:906:7307:b0:6da:92db:c78f with SMTP id
 di7-20020a170906730700b006da92dbc78fmr12327012ejc.35.1648224132413; Fri, 25
 Mar 2022 09:02:12 -0700 (PDT)
MIME-Version: 1.0
References: <20220308065754.3355-1-peng.fan@oss.nxp.com> <20220324151132.GA3514576@p14s>
 <DU0PR04MB9417991BDB9564321FC30EE7881A9@DU0PR04MB9417.eurprd04.prod.outlook.com>
In-Reply-To: <DU0PR04MB9417991BDB9564321FC30EE7881A9@DU0PR04MB9417.eurprd04.prod.outlook.com>
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
Date:   Fri, 25 Mar 2022 10:02:00 -0600
Message-ID: <CANLsYkyLyROGsUuzaxA7Kx2ouj48NHM1t84DeyOiJmDiDMTgHA@mail.gmail.com>
Subject: Re: [PATCH V2] remoteproc: imx_rproc: Ignore create mem entry for
 resource table
To:     Peng Fan <peng.fan@nxp.com>
Cc:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>,
        "bjorn.andersson@linaro.org" <bjorn.andersson@linaro.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-remoteproc@vger.kernel.org" <linux-remoteproc@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 24 Mar 2022 at 20:02, Peng Fan <peng.fan@nxp.com> wrote:
>
> Hi Mathieu,
>
> > Subject: Re: [PATCH V2] remoteproc: imx_rproc: Ignore create mem entry for
> > resource table
> >
> > On Tue, Mar 08, 2022 at 02:57:54PM +0800, Peng Fan (OSS) wrote:
> > > From: Peng Fan <peng.fan@nxp.com>
> > >
> > > Resource table will not be used for memory allocation, no need to
> > > create rproc mem entry.
> > >
> > > Fixes: b29b4249f8f0c ("remoteproc: imx_rproc: add i.MX specific parse
> > > fw hook")
> >
> >
> > https://eur01.safelinks.protection.outlook.com/?url=https%3A%2F%2Felixir.b
> > ootlin.com%2Flinux%2Fv5.17%2Fsource%2FDocumentation%2Fprocess%2Fsu
> > bmitting-patches.rst&amp;data=04%7C01%7Cpeng.fan%40nxp.com%7Cae62
> > e633010048f972db08da0da89836%7C686ea1d3bc2b4c6fa92cd99c5c301635
> > %7C0%7C1%7C637837315009092474%7CUnknown%7CTWFpbGZsb3d8eyJW
> > IjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C
> > 3000&amp;sdata=Xod3YxSRW8h2WXdnpu1WX4DzRpCTnYE9gVlt9HXMlnU%3
> > D&amp;reserved=0
>
> Sorry, I could not get your point of which part conflicts with the patch rules.
> Please clarify and I'll improve.

The commitID in the "Fixes" tag should be 12 characters rather than 13
as you have above.

>
> Thanks,
> Peng.
>
>
> >
> >
> > > Signed-off-by: Peng Fan <peng.fan@nxp.com>
> > > ---
> > >
> > > V2:
> > >  Add Fixes tag
> > >  Separate the patch from
> > > https://eur01.safelinks.protection.outlook.com/?url=https%3A%2F%2Fpatc
> > >
> > hwork.kernel.org%2Fproject%2Flinux-remoteproc%2Fpatch%2F20220111033
> > 333
> > > .403448-7-peng.fan%40oss.nxp.com%2F&amp;data=04%7C01%7Cpeng.fan
> > %40nxp.
> > >
> > com%7Cae62e633010048f972db08da0da89836%7C686ea1d3bc2b4c6fa92cd
> > 99c5c301
> > >
> > 635%7C0%7C1%7C637837315009092474%7CUnknown%7CTWFpbGZsb3d8e
> > yJWIjoiMC4wL
> > >
> > jAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000&am
> > p;sdata
> > >
> > =CYL9grwXHpUud4qpzFAEijOWv%2BehvefwyZ4aU02wJnw%3D&amp;reserv
> > ed=0
> > >  Address typo
> > >
> > >  drivers/remoteproc/imx_rproc.c | 3 +++
> > >  1 file changed, 3 insertions(+)
> > >
> > > diff --git a/drivers/remoteproc/imx_rproc.c
> > > b/drivers/remoteproc/imx_rproc.c index 7a096f1891e6..f2bfc9077c19
> > > 100644
> > > --- a/drivers/remoteproc/imx_rproc.c
> > > +++ b/drivers/remoteproc/imx_rproc.c
> > > @@ -423,6 +423,9 @@ static int imx_rproc_prepare(struct rproc *rproc)
> > >             if (!strcmp(it.node->name, "vdev0buffer"))
> > >                     continue;
> > >
> > > +           if (!strncmp(it.node->name, "rsc-table", strlen("rsc-table")))
> > > +                   continue;
> > > +
> > >             rmem = of_reserved_mem_lookup(it.node);
> > >             if (!rmem) {
> > >                     dev_err(priv->dev, "unable to acquire memory-region\n");
> > > --
> > > 2.30.0
> > >
