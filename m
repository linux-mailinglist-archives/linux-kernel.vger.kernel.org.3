Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 321C5479320
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Dec 2021 18:52:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239947AbhLQRw4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Dec 2021 12:52:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236205AbhLQRwz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Dec 2021 12:52:55 -0500
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E83B3C06173F
        for <linux-kernel@vger.kernel.org>; Fri, 17 Dec 2021 09:52:54 -0800 (PST)
Received: by mail-qt1-x82a.google.com with SMTP id q14so3395585qtx.10
        for <linux-kernel@vger.kernel.org>; Fri, 17 Dec 2021 09:52:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ndufresne-ca.20210112.gappssmtp.com; s=20210112;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=EdfDMc3dGy+rtz/PQ2kf0voPWh+Gy8fg3uDbtzFcCyk=;
        b=s1yP2xfwlw4arGnpUI7y1LjifZqDnsQb1y/tviXNIW6r5+cfjaBQctF8AGDlp4uLNB
         W+518UCjBVCrf2JL8fHE2MvU2mQVOH//19q5aMXsUTw604ZLTHK6jdaBHoalX/DnMxY2
         N35BUyeBK3f++52UL7N848oA3qKgR+DYoWXvfGf5NeQEl7Nw9r3zp5I5wzl3HTaqMzu4
         vkkieGMUrCPWq4Xx+cBvX8MGdQygOsQ+vQ/QMUwzPv372ygeMe3PAyLsywMGtsIZ18AW
         EoDoqyI/DdKVHEP2ZpOy6pMCWvFaVKWNjx0B3Z/Zvphq8DpbL7P9aPFiTalah3iOG50j
         d1/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=EdfDMc3dGy+rtz/PQ2kf0voPWh+Gy8fg3uDbtzFcCyk=;
        b=vl323mp+/R7RapKniwyOzWy3876OLGg2iyNDhYb8aAOFrPrhcSYMjIToJlyGqtWGik
         ajzBEzfAxTriuURk0k13VhzqPsfFSdl9jBKXyY76019ITdGTmUAGgGK/YZH+MOAutTgc
         4hGya2OUq1dDaKJx0tcdoZ96uVDjpJtud0uIeoCyw196skCDGAYpeDfWv0tJogNEzFEL
         F3qXYLEcBHYAsFN00RAjE5JC8uz0MzebQkxrlpBvrUh9pC6w8SKTqsHFrQh3+gwuwLVg
         woynXrkfgSdDvkvQ1aRay0CiNaFLSEEvyFtfxxAnLJgHB9iJHwX1Zi/tS/tVpK9+2cyp
         z+6Q==
X-Gm-Message-State: AOAM533Fp/TpP/4Z1Fop00D5NOm4B4tjtA07zK8scthQ9QbduShJjaxI
        yVAVliXrzKa0B3GIZiBrGfqYOw==
X-Google-Smtp-Source: ABdhPJzydc3+rBb7SLARVOLCMtRjYOmkbg8KG3gbO/t8lzwiGUAnAnHeWbz325P00g8oSWik3/9jeQ==
X-Received: by 2002:ac8:7f06:: with SMTP id f6mr3508448qtk.258.1639763574019;
        Fri, 17 Dec 2021 09:52:54 -0800 (PST)
Received: from nicolas-tpx395.localdomain (mtl.collabora.ca. [66.171.169.34])
        by smtp.gmail.com with ESMTPSA id x13sm5683430qkp.102.2021.12.17.09.52.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Dec 2021 09:52:53 -0800 (PST)
Message-ID: <41f0e00cf5e57668b643b096e6bb69c67635c540.camel@ndufresne.ca>
Subject: Re: [RFC 0/5] arm64: imx8mm: Enable Hantro VPUs
From:   Nicolas Dufresne <nicolas@ndufresne.ca>
To:     Tim Harvey <tharvey@gateworks.com>
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
Date:   Fri, 17 Dec 2021 12:52:51 -0500
In-Reply-To: <CAJ+vNU1ZxAAasKT8j1sfcFz1pk8fyYjwOW6wqxYq_ur8+2MX_Q@mail.gmail.com>
References: <20211106183802.893285-1-aford173@gmail.com>
         <718f7f6d6cd564d031c1963f1590c62d549ae725.camel@ndufresne.ca>
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
         <CAHCN7xL4y67V6AW5MV=8iudvvGVBWs2LoUhu_2CUJf6bSycgFA@mail.gmail.com>
         <8438070708d16c34c0f79aba19e67fa343adb169.camel@ndufresne.ca>
         <CAJ+vNU1ZxAAasKT8j1sfcFz1pk8fyYjwOW6wqxYq_ur8+2MX_Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.2 (3.42.2-1.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le vendredi 17 décembre 2021 à 09:26 -0800, Tim Harvey a écrit :
> On Fri, Dec 17, 2021 at 9:13 AM Nicolas Dufresne <nicolas@ndufresne.ca> wrote:
> > 
> > Le vendredi 17 décembre 2021 à 07:15 -0600, Adam Ford a écrit :
> > > On Thu, Dec 16, 2021 at 10:49 PM Ezequiel Garcia
> > > <ezequiel@vanguardiasur.com.ar> wrote:
> > > > 
> > > > Hi Adam,
> > > > 
> > > > > 
> > > > > I will post a V2 last today with the Mini's post-processing removed.
> > > > > Someone, I apologize that I forget who, mentioned it was fused out of
> > > > > the Mini, so the testing I've been doing was with that removed and I
> > > > > removed the H1 encoder since the Mini doesn't support JPEG encoding.
> > > > > 
> > > > [...]
> > > > 
> > > > Resurrecting this thread here. IMX8MMRM Rev. 0, 02/2019 mentions
> > > > post-processor features for G1 and G2.
> > > > 
> > > > Have you checked the fuse and synth registers to see if they throw
> > > > any useful information about the hardware? For instance,
> > > > comparing PP fuse register (SWREG99) and
> > > > Synthesis configuration register post-processor (SWREG100)
> > > > in both 8MQ and 8MM could be useful.
> > > > 
> > > > As I mentioned on my previous mail, even if G1 PP is disabled
> > > > on the Mini, I would imagine the G2 can do linear NV12 (aka raster-scan)
> > > > which in our hantro driver jargon is a  "post-processed" format :-)
> > > 
> > > You're likely right.  I was going on memory from an e-mail from
> > > Nicloas Defresne who wrote:
> > > 
> > > "I will check the patchset, but you need in the mini-variant to disable the G1
> > > post processor, because this block was fused out. We didn't make it optional
> > > from the start as according to the V1 of the TRM it was there, but that error
> > > was corrected in V3."
> > > 
> > > In my head I assumed the G2 was affected as well, but when I double
> > > checked his email, and based on the above statement, the G2
> > > post-processing is probably there, so I'll run some tests with the G2
> > > post-processing enabled.  I'll also double check those registers on
> > > both to confirm what they read. I am not sure when I'll have time
> > > because I leave for London next week, and I won't return until early
> > > January, but I'll do what I can.
> > 
> > Sorry if this was a bit ambiguous, indeed I meant the G1 only. I've learned
> > later that the design of the Mini is that there is a good pre-processor in the
> > H1 block (encoder), so for the targeted use-cases this shall be sufficient for
> > most users (the output of the G1 is suitable for GPU and Display already, so the
> > post processor is not strictly needed).
> > 
> 
> Nicolas,
> 
> Does this mean that if the IMX8MM G2 may be able to output a wider
> array of pixel formats and that the H1 encoder may be able to accept a
> wider array of pixel formats? Is this code already in place in the

No since the G2 post processor does not have a color converter (it is very
limited). In term of format, this is pretty much identical, produces linear or
tiled. The difference is that G1 supports the two layout natively, not the G2.

> hantro driver and it just needs to be enabled if the IMX8MM can handle
> it or is there code to be written?
> 
> I'm not clear if anyone is working on IMX8MM VPU H1 support. You had
> mentioned that some support [1] and [2] can be derived from the RK3288
> using the Google ChromeOS method (a v4l2 plugin that simulates in
> userspace a stateful encoder). I'm not sure if this is worth pursuing
> if others are working on stateless encode support in kernel and
> gstreamer.

My colleagues started last week the project of crafting mainline stateless
encoder uAPI. This is too early. In older project, we have had good success with
the emulated stateful encoder. It is of course quite limited, but works in
gstreamer, ffmpeg and chromium. It is also likely safer compared to the vendor
provided driver.

p.s. From my knowledge, there is virtually no difference between the H1 on
RK3288 and IMX8MM/P, but we've learn from G1 that there could effectively have
more of less features.

> 
> Best Regards,
> 
> Tim
> [1] libv4l plugins /
> https://chromium.googlesource.com/chromiumos/third_party/libv4lplugins/+/refs/heads/master
> [2] Kernel Driver /
> https://chromium.googlesource.com/chromiumos/third_party/kernel/+/chromeos-4.4/drivers/media/platform/rockchip-vpu/

