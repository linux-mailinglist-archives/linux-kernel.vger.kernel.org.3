Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 405F34ED88A
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 13:32:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235195AbiCaLeW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 07:34:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235161AbiCaLeO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 07:34:14 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDE252028B5
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 04:32:26 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id yy13so47476183ejb.2
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 04:32:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uGbhKLWrsLyCVeSUohrzuJPdjP/ZW8fK03vbsKlcv08=;
        b=qGaUVMWcT0vp4N0OCt+uDOxnuhZySmo8AQz/1WLHwlH8dYGN4tnd0fPSIZPKUyN8Nr
         BPlWsblHNX3Uc3bvihlCWTfOcurwdrXQgb6gtXAfzd/FQzC8pU7iiCD8eyZdMz36Qukq
         l/St2dSTjfoSnKQS1eOoo8kO/RlPYJGibON8ZchfuZbeClHeve8XnJM/oaVR37YQ+JbR
         EhLIr1SJAtw8zz82AobrABPje94zp/8ntEVjs1wJqjghhLhRGmw2DT34tmJcmP5bt+J/
         p5rGWXnmCLTi8KWawj62OpayDfumD4pnCt4Of0BkTK3el6kVICjAcVxVL13E8SP13deP
         2fZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uGbhKLWrsLyCVeSUohrzuJPdjP/ZW8fK03vbsKlcv08=;
        b=pmLGgGd2WIEGjcL7Wn6+51+kowlzWX4sXcpelilbiYpCKMJPGm9ZpkZcQxdpV6+b+Z
         319z9gxiiQYdiZqCyAj/CF9+5m4/koPl06UKviNHm6GLhlSQy5net4HCxJPyutyav2oY
         UpRoY1nfPJDBjub+VP65SM9cAnbMqcSRl7n+RRsc7bJjPauVjxzTw3pHjtJc4aicT1uP
         sGKQ1p14pJI1KsIFjX65X0Eiw6JQdRlEaxmvxZmTJGjEoMmSzZNHDI02IwOJ4v/T7ouZ
         srGoELGlIjUsKLE60U0WIh0DqyKBTqHI3TW8fsV8P8U8GoOFtiNPvblV8dc3d3V4LHMT
         ABZQ==
X-Gm-Message-State: AOAM5307FQRYAi2A4QvTd19PfqXzhFYJqbhYhDPiym+TF1kbiE1yy9ri
        HImwI/+mocm28TUnpG8OD2/0aUXEZD9Sb6N0BCo=
X-Google-Smtp-Source: ABdhPJzQJHyTfSxlc41M45wefiBioqQDgVHvTzSSMPnk0NiQroU9MUA3GLL8SDM5OmjMD5EXK4I6Pg8uoKiKDod8q08=
X-Received: by 2002:a17:907:1c9f:b0:6df:eb80:3581 with SMTP id
 nb31-20020a1709071c9f00b006dfeb803581mr4457496ejc.198.1648726345079; Thu, 31
 Mar 2022 04:32:25 -0700 (PDT)
MIME-Version: 1.0
References: <20211120193916.1309236-1-aford173@gmail.com> <319e976acb0a686e596b88520dbcda59c78afe9e.camel@pengutronix.de>
In-Reply-To: <319e976acb0a686e596b88520dbcda59c78afe9e.camel@pengutronix.de>
From:   Adam Ford <aford173@gmail.com>
Date:   Thu, 31 Mar 2022 06:32:13 -0500
Message-ID: <CAHCN7x+5HXJEdRKbm80trpNwxZRAMhX12+FQ0JeVvrqKpKf+BA@mail.gmail.com>
Subject: Re: [PATCH] soc: imx: gpcv2: keep i.MX8MM VPU-H1 bus clock active
To:     Lucas Stach <l.stach@pengutronix.de>
Cc:     arm-soc <linux-arm-kernel@lists.infradead.org>,
        Tim Harvey <tharvey@gateworks.com>,
        Adam Ford-BE <aford@beaconembedded.com>,
        Shawn Guo <shawnguo@kernel.org>,
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

On Thu, Mar 31, 2022 at 4:28 AM Lucas Stach <l.stach@pengutronix.de> wrote:
>
> Hi Adam, hi Shawn,
>
> Am Samstag, dem 20.11.2021 um 13:39 -0600 schrieb Adam Ford:
> > Enable the vpu-h1 clock when the domain is active because reading
> > or writing to the VPU-H1 IP block cause the system to hang.
> >
> > Fixes: 656ade7aa42a ("soc: imx: gpcv2: keep i.MX8M* bus clocks enabled")
> > Signed-off-by: Adam Ford <aford173@gmail.com>
> >
> > diff --git a/drivers/soc/imx/gpcv2.c b/drivers/soc/imx/gpcv2.c
> > index b8d52d8d29db..7b6dfa33dcb9 100644
> > --- a/drivers/soc/imx/gpcv2.c
> > +++ b/drivers/soc/imx/gpcv2.c
> > @@ -734,6 +734,7 @@ static const struct imx_pgc_domain imx8mm_pgc_domains[] = {
> >                       .map = IMX8MM_VPUH1_A53_DOMAIN,
> >               },
> >               .pgc   = BIT(IMX8MM_PGC_VPUH1),
> > +             .keep_clocks = true,
> >       },
> >
> I missed this patch and just stumbled across it when looking at the git
> history. I don't think this patch is correct. The H1 GPC domain does
> not even have clocks assigned in the DT, so there is nothing to keep
> active. Also H1 is not a MIX domain, so it should not keep any bus
> clocks active, that is the job of the VPUMIX domain.
>
> While this patch is a no-op, as far as I can see, it still seems wrong
> and I think it should be reverted.

At the time I sent this, I was working with some people in the media
group to split the G1 and G2 up in the imx8mq and add G1 and G2
support in the imx8mm.  I had inquired about the feasibility of using
the H1 encoder on the imx8mm, but I needed to read some registers from
the IP block to see which features were fused out.  I tried several
different options to get the H1 to not hang when reading registers,
and that was the only solution I found that worked.  I thought it odd
as well since the G1 and G2 decoders didn't appear to need this.
However, during the course of my investigation, I learned that the
JPEG encoder was fused out of the imx8mm, and there wasn't a plan to
add VP8 or H.264 encodering any time soon.   Since it is, as you put
it, a no-op, I have no objections to reverting it.

adam
>
> Regards,
> Lucas
>
