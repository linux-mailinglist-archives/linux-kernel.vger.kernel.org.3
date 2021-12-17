Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79E2E4792D0
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Dec 2021 18:27:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239891AbhLQR1N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Dec 2021 12:27:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239909AbhLQR1K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Dec 2021 12:27:10 -0500
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1FB9C061574
        for <linux-kernel@vger.kernel.org>; Fri, 17 Dec 2021 09:27:09 -0800 (PST)
Received: by mail-pl1-x629.google.com with SMTP id e17so2421357plh.8
        for <linux-kernel@vger.kernel.org>; Fri, 17 Dec 2021 09:27:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gateworks-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=94lytwgo2pGPKoCz7cXjNIBQaFpmuX64JbTjaHifeEo=;
        b=R/D+giI9xp6G3jBIYNNDmBdzy8vtLbErm1zXG1RUpUrVR7TplNui48kHW1HA7L4AXr
         8xYSnKLB/KktrXYjS5rcAfBqUAG3k7JMmlN3Z4cmdNnjLxA9G6f7hSVmW97x+QlbZyju
         7CvKfsGCnO0A37sh//tlbNDCgdjk8Xg81hQQ6WPJ0QwNNKGFHiLM/MCpZz0HfgyuwjnR
         r+8tQosxe7KhEgBHoCAes46E4VMj/3CvCDjxGTyyKl3Y2yVCxn2IHJQo/ssx/0fJQPzn
         mt2f/cAHhVIXZMu9HYc9cR14FshrILqP0+1mmNqnZKov6JMTkdYmxRaLTBcmxCMsHEfe
         6WxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=94lytwgo2pGPKoCz7cXjNIBQaFpmuX64JbTjaHifeEo=;
        b=TbK/bOB25dnFDR33ts8xvEDS3UP8eq+5iavuPt0dVy2c61Z/H7DI1s96DYQzPcFlD9
         jwqqQqhB9YXbZH9EJS7GxejtCxySFJLNhsmI22/cYETUo05vU4Ljg2H0uE/FRHu4+U0C
         /FkzxgPFqOo4zDm3AS/I8YTSbeeBpvsTWkaOcf/W9ARsZwxld53/ZV1HffirNU11Sq1C
         Zaprfhd6C4qLw0gDD4LugVc0Tct5vAM0/D1aG5YsNW/m4nxquH9WBOfuBSbPrs+XlTzW
         /rWNOabOGTvWKPQeuAOEKmelT7Tf4dnKaabj0ercVfA26dxOK/A43VlhsXD978pjtodt
         nAGA==
X-Gm-Message-State: AOAM531ge5esJMIVi3EcswrDCO9WiKK59gdpzn9lMD+6YMYicnWTHQ5w
        z5q3H/99jN2Mv2x5sJeP+OZrWo6oLqZKJACfBDWgWg==
X-Google-Smtp-Source: ABdhPJxh6drjRqJyeeghVLdXC+QG2CUejhvUilM6pihIKCowBomy2bFqr6Blk7qvQTT9UHKElHVBCV9i+77UTKQoPfE=
X-Received: by 2002:a17:902:c214:b0:148:a798:7aa with SMTP id
 20-20020a170902c21400b00148a79807aamr4115431pll.90.1639762029356; Fri, 17 Dec
 2021 09:27:09 -0800 (PST)
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
 <CAJ+vNU2we5mGXgYsR6CfimvFXZsc0zktR3fDa-h6RRa02jTT0g@mail.gmail.com>
 <CAHCN7xJrM9uZUnmx65uTxWEo6HAkjozd3kD3UoEv-pYd5DV4QA@mail.gmail.com>
 <CAAEAJfBXU-AiKKhkhXzgUSR4p1yefysNuHFycBz3F-GzNewS6w@mail.gmail.com>
 <CAHCN7xL4y67V6AW5MV=8iudvvGVBWs2LoUhu_2CUJf6bSycgFA@mail.gmail.com> <8438070708d16c34c0f79aba19e67fa343adb169.camel@ndufresne.ca>
In-Reply-To: <8438070708d16c34c0f79aba19e67fa343adb169.camel@ndufresne.ca>
From:   Tim Harvey <tharvey@gateworks.com>
Date:   Fri, 17 Dec 2021 09:26:58 -0800
Message-ID: <CAJ+vNU1ZxAAasKT8j1sfcFz1pk8fyYjwOW6wqxYq_ur8+2MX_Q@mail.gmail.com>
Subject: Re: [RFC 0/5] arm64: imx8mm: Enable Hantro VPUs
To:     Nicolas Dufresne <nicolas@ndufresne.ca>
Cc:     Adam Ford <aford173@gmail.com>,
        Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
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
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 17, 2021 at 9:13 AM Nicolas Dufresne <nicolas@ndufresne.ca> wro=
te:
>
> Le vendredi 17 d=C3=A9cembre 2021 =C3=A0 07:15 -0600, Adam Ford a =C3=A9c=
rit :
> > On Thu, Dec 16, 2021 at 10:49 PM Ezequiel Garcia
> > <ezequiel@vanguardiasur.com.ar> wrote:
> > >
> > > Hi Adam,
> > >
> > > >
> > > > I will post a V2 last today with the Mini's post-processing removed=
.
> > > > Someone, I apologize that I forget who, mentioned it was fused out =
of
> > > > the Mini, so the testing I've been doing was with that removed and =
I
> > > > removed the H1 encoder since the Mini doesn't support JPEG encoding=
.
> > > >
> > > [...]
> > >
> > > Resurrecting this thread here. IMX8MMRM Rev. 0, 02/2019 mentions
> > > post-processor features for G1 and G2.
> > >
> > > Have you checked the fuse and synth registers to see if they throw
> > > any useful information about the hardware? For instance,
> > > comparing PP fuse register (SWREG99) and
> > > Synthesis configuration register post-processor (SWREG100)
> > > in both 8MQ and 8MM could be useful.
> > >
> > > As I mentioned on my previous mail, even if G1 PP is disabled
> > > on the Mini, I would imagine the G2 can do linear NV12 (aka raster-sc=
an)
> > > which in our hantro driver jargon is a  "post-processed" format :-)
> >
> > You're likely right.  I was going on memory from an e-mail from
> > Nicloas Defresne who wrote:
> >
> > "I will check the patchset, but you need in the mini-variant to disable=
 the G1
> > post processor, because this block was fused out. We didn't make it opt=
ional
> > from the start as according to the V1 of the TRM it was there, but that=
 error
> > was corrected in V3."
> >
> > In my head I assumed the G2 was affected as well, but when I double
> > checked his email, and based on the above statement, the G2
> > post-processing is probably there, so I'll run some tests with the G2
> > post-processing enabled.  I'll also double check those registers on
> > both to confirm what they read. I am not sure when I'll have time
> > because I leave for London next week, and I won't return until early
> > January, but I'll do what I can.
>
> Sorry if this was a bit ambiguous, indeed I meant the G1 only. I've learn=
ed
> later that the design of the Mini is that there is a good pre-processor i=
n the
> H1 block (encoder), so for the targeted use-cases this shall be sufficien=
t for
> most users (the output of the G1 is suitable for GPU and Display already,=
 so the
> post processor is not strictly needed).
>

Nicolas,

Does this mean that if the IMX8MM G2 may be able to output a wider
array of pixel formats and that the H1 encoder may be able to accept a
wider array of pixel formats? Is this code already in place in the
hantro driver and it just needs to be enabled if the IMX8MM can handle
it or is there code to be written?

I'm not clear if anyone is working on IMX8MM VPU H1 support. You had
mentioned that some support [1] and [2] can be derived from the RK3288
using the Google ChromeOS method (a v4l2 plugin that simulates in
userspace a stateful encoder). I'm not sure if this is worth pursuing
if others are working on stateless encode support in kernel and
gstreamer.

Best Regards,

Tim
[1] libv4l plugins /
https://chromium.googlesource.com/chromiumos/third_party/libv4lplugins/+/re=
fs/heads/master
[2] Kernel Driver /
https://chromium.googlesource.com/chromiumos/third_party/kernel/+/chromeos-=
4.4/drivers/media/platform/rockchip-vpu/
