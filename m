Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51214478436
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Dec 2021 05:49:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232852AbhLQEtI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 23:49:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231966AbhLQEtG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 23:49:06 -0500
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 996B9C06173E
        for <linux-kernel@vger.kernel.org>; Thu, 16 Dec 2021 20:49:05 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id o20so3152109eds.10
        for <linux-kernel@vger.kernel.org>; Thu, 16 Dec 2021 20:49:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vanguardiasur-com-ar.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6GJxpDiLpbpPINaOcBipsmIBKGtNQ+pTxcsj8dWvqKk=;
        b=XYX28P5JN9Qi9AqY6RdU8NHuKgyb2ni3yWGjFXejI92Mjdz2ktEGfEELSSPmDUvvYi
         VwQtocGg4rHGd9xMk3Bi7dczQ0gTHV5gGIrlx7knTiCdNgY+HQZBz3LLpZ4Hmn7qVHes
         b6+7t6q1ga50czfzqpOCqajlT9bPCwJePv67e86JcPtB3x8/o2wmaOaJh+aSsocy2jIW
         uiJmVzeCGY4indD/+XgNQjohvs6YD7OA6wjDxp4Lislknx/3m2e9qrNEXEnMidcoVu6P
         3mA3ziprDkCer2OKiwRwYJdJ6zmntOfz6XUSs3BPscVTzwRuSZ3YtGD/NsqR1YnuqO3r
         v4bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6GJxpDiLpbpPINaOcBipsmIBKGtNQ+pTxcsj8dWvqKk=;
        b=bom5nmANqPjBHARIP7sGa9esgH8FAvSzFY03KYyLjUrUHIYqpd1yeiDjF1WG6Sd6A/
         fYZNzWbVbHt/jB/ulSOcAJNz6y464nsPvWnPP7Hgud2C3MPBFbyC9w8KqBWvBYRb/lQw
         6/b3f/jrHKrVqC9Rf1Q7YUkEjk8/RSrn5qc5exU77zKdu1d3k4l71mmHSIHRfrPYhw+L
         RLg/uxWro2l+6mOJ2eQ4LTdK2XWhNdBONIAUEy+QpXJd1ISjtNis2Abj79EgFeyMhrN/
         NqQV32/BBWIWJQzbdhszZaLYEMHfhoBshpF4XIQ9JC6YpQ3Pue91tuskjUYoM3FT8CeK
         W7cw==
X-Gm-Message-State: AOAM532mDtVAu06M5Q1uDnwwJYssKS54WIZmy0U9mDJVwzcbKqGabTd3
        GF+Aq5qbKqq7x4dr4jyusiHkX9MNzUPoUMNH/o4yIA==
X-Google-Smtp-Source: ABdhPJzaIuToc0djVyjp+VsjCbme0PeMuRClgq6NqRenM+df1YY9uQXZCbxUdpPkTSZu7ypDqPFBB+GLvvmn9r8MBmg=
X-Received: by 2002:a17:907:16ac:: with SMTP id hc44mr1138627ejc.363.1639716544065;
 Thu, 16 Dec 2021 20:49:04 -0800 (PST)
MIME-Version: 1.0
References: <20211106183802.893285-1-aford173@gmail.com> <718f7f6d6cd564d031c1963f1590c62d549ae725.camel@ndufresne.ca>
 <CAHCN7xKM9RUE7z-+ug1on+D=nDoEm589R4m03ofys92Aq75ZVQ@mail.gmail.com>
 <8db00a4b6faa99c940d9bc86e17161eb0db5efe3.camel@ndufresne.ca>
 <CAJ+vNU28UJffFv9jQ2KryJMudqYxvCaoVOVcU5dPqRA209iN6A@mail.gmail.com>
 <d91532c2c0772f9aa708ead36b2a97203727a7ea.camel@ndufresne.ca>
 <CAJ+vNU3H-V+bPoZ3qKead45h=W7AhQK6Lhjrx5ssdF4c_qfe=A@mail.gmail.com>
 <CAHCN7x+0LwwU_rEST+TZxGquswGKL19gnTy9WLofsXtGAtWqdw@mail.gmail.com>
 <7f94eaacfddb8c5434c17f1e069ea87a17657ce9.camel@ndufresne.ca>
 <CAHCN7xKRzxMBmPbDobWTuvNNSpTXk5XENvfBnfkhRY3eZKhn6w@mail.gmail.com>
 <CAHCN7xJFLNi_g+HX8PCy1Rkgf0jnWpO5QGYVz8nH19xrJkwHrA@mail.gmail.com>
 <CAJ+vNU3zFd=6k_Emc5aafxKkGwCPp4crgOFezQ-E_MbWsn1_EA@mail.gmail.com>
 <fed6c2fd7cf4971062c417ce41ed1e3812b900e0.camel@ndufresne.ca>
 <CAHCN7xK+wROHaqDcsY-3WYFQ82qX17L-LHNL3siSWnWvwFShzQ@mail.gmail.com>
 <CAAEAJfC1xXvemaFP+vTFVJ3S-SpYtrxyZgDamSOgLC1F3ua5xw@mail.gmail.com>
 <CAHCN7x+UMMP6RXsNm0=OC=UTQzh=RKqQo6B7FD5e4eoJAEfmpg@mail.gmail.com>
 <CAJ+vNU1epi9SwPMHkuDmKcb68RLemYF=bsp7AVnzz06zKc2efw@mail.gmail.com>
 <CAAEAJfCpjk5nWWkJYjjDT-YEpJi4pTZqZbzp_if9OGC0HKspzw@mail.gmail.com>
 <CAJ+vNU2we5mGXgYsR6CfimvFXZsc0zktR3fDa-h6RRa02jTT0g@mail.gmail.com> <CAHCN7xJrM9uZUnmx65uTxWEo6HAkjozd3kD3UoEv-pYd5DV4QA@mail.gmail.com>
In-Reply-To: <CAHCN7xJrM9uZUnmx65uTxWEo6HAkjozd3kD3UoEv-pYd5DV4QA@mail.gmail.com>
From:   Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
Date:   Fri, 17 Dec 2021 01:48:52 -0300
Message-ID: <CAAEAJfBXU-AiKKhkhXzgUSR4p1yefysNuHFycBz3F-GzNewS6w@mail.gmail.com>
Subject: Re: [RFC 0/5] arm64: imx8mm: Enable Hantro VPUs
To:     Adam Ford <aford173@gmail.com>
Cc:     Tim Harvey <tharvey@gateworks.com>,
        Nicolas Dufresne <nicolas@ndufresne.ca>,
        linux-media <linux-media@vger.kernel.org>,
        Schrempf Frieder <frieder.schrempf@kontron.de>,
        Marek Vasut <marek.vasut@gmail.com>,
        Jagan Teki <jagan@amarulasolutions.com>,
        Adam Ford-BE <aford@beaconembedded.com>,
        cstevens@beaconembedded.com,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Lucas Stach <l.stach@pengutronix.de>,
        Joakim Zhang <qiangqing.zhang@nxp.com>,
        Alice Guo <alice.guo@nxp.com>, Peng Fan <peng.fan@nxp.com>,
        "open list:HANTRO VPU CODEC DRIVER" 
        <linux-rockchip@lists.infradead.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:STAGING SUBSYSTEM" <linux-staging@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Adam,

>
> I will post a V2 last today with the Mini's post-processing removed.
> Someone, I apologize that I forget who, mentioned it was fused out of
> the Mini, so the testing I've been doing was with that removed and I
> removed the H1 encoder since the Mini doesn't support JPEG encoding.
>
[...]

Resurrecting this thread here. IMX8MMRM Rev. 0, 02/2019 mentions
post-processor features for G1 and G2.

Have you checked the fuse and synth registers to see if they throw
any useful information about the hardware? For instance,
comparing PP fuse register (SWREG99) and
Synthesis configuration register post-processor (SWREG100)
in both 8MQ and 8MM could be useful.

As I mentioned on my previous mail, even if G1 PP is disabled
on the Mini, I would imagine the G2 can do linear NV12 (aka raster-scan)
which in our hantro driver jargon is a  "post-processed" format :-)

Thanks,
Ezequiel
