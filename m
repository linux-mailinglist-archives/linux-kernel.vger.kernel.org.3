Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6C0D496288
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jan 2022 17:01:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381754AbiAUQBf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jan 2022 11:01:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381745AbiAUQB2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jan 2022 11:01:28 -0500
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FAD5C06173B;
        Fri, 21 Jan 2022 08:01:27 -0800 (PST)
Received: by mail-lf1-x12e.google.com with SMTP id m1so34842354lfq.4;
        Fri, 21 Jan 2022 08:01:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=fnf2q063vcpul5gnvS1u13+cbRBXFdLS+LpaLMcSRW0=;
        b=DL9NwM1kK1Y5IImBYJ5I3+kL5frmhk0ZyBnGvMOmlIXOH5hbzhTHI9FdGWrEoq7xPj
         VmAxvtd/Eofu7nRtS//4UGtevm+FiTLCWjZYNBVjTpH6lFJudD3nQdNecZ3WbT1vNLKR
         Dtj407KCBoDQkRnxyKfcMYO8kWxGm7YKp4suFzt5L8HmutPvF98RSUUxj+7zSiNzm2dD
         puopdbMsKAe3cRvrcfBtCm+vgaKrIV2QFjkZfBdjfv1Yyc2eHKwqNNf3HLRIcxhh3AVQ
         LB7Q72xzfg8kvBSspW1woE22h82lcqQZv+kOohQuBY7pesAR+tRu0lfJLhRggV7qBWhv
         w80A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=fnf2q063vcpul5gnvS1u13+cbRBXFdLS+LpaLMcSRW0=;
        b=UyuJ0b25efeq1XaZLpaVsGnHAqjAZndh/Tal7Qeb4BNFMUmi1fxrXk7oawVkYJzO2a
         LMKT5oY++7mrJh6oZwYtNc+7RcSCRGigr6uFu107qKWX1RmZKXmeKXrEe1EBvcDm6e89
         9vz93v3qt/4N7ShN4XAdHFE4nrIKy7dTD4F6qq7dM9oXzcbHtEFyPF5jfvNW9J+OOvxk
         1Csa52a/IilQp0okXDtOmIzfJ0fRaVSeZ80eyYllnAIBnDDEEZeh47s4r/NEvEFSpOGe
         DbT7ytZV3shAFhY17yBoOkZtYyloud2KxzUb5OVcm4bImd4Sm3JnbP6XSU2rYcfJcHQG
         idgA==
X-Gm-Message-State: AOAM532j+0J2xV1pep4sqoqy8K5x7n0IKg0AlprwZBJZDndUgu2BNeLg
        9zvRW9+Bp6trkq+FNVd/Em0=
X-Google-Smtp-Source: ABdhPJzWeuF7d6pbmFzST6ep1anCdyKsmBr59cRxuCj0Ym5BLgNWa2XSjGua3c2rgUVH2HNKP1hDJQ==
X-Received: by 2002:a19:640f:: with SMTP id y15mr3987172lfb.638.1642780885420;
        Fri, 21 Jan 2022 08:01:25 -0800 (PST)
Received: from localhost ([2a05:3580:f312:6c01:1b6d:df4d:cbec:e4a2])
        by smtp.gmail.com with ESMTPSA id r24sm294615lfi.127.2022.01.21.08.01.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jan 2022 08:01:24 -0800 (PST)
Date:   Fri, 21 Jan 2022 19:01:23 +0300
From:   Andrey Skvortsov <andrej.skvortzov@gmail.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Arnaud Ferraris <arnaud.ferraris@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Avri Altman <avri.altman@wdc.com>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Huijin Park <huijin.park@samsung.com>,
        Christian =?utf-8?B?TMO2aGxl?= <CLoehle@hyperstone.com>,
        Yue Hu <huyue2@yulong.com>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mmc: core: Wait for command setting 'Power Off
 Notification' bit to complete
Message-ID: <YerY0504bDglnA+C@skv.local>
Mail-Followup-To: Andrey Skvortsov <andrej.skvortzov@gmail.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Arnaud Ferraris <arnaud.ferraris@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Avri Altman <avri.altman@wdc.com>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Huijin Park <huijin.park@samsung.com>,
        Christian =?utf-8?B?TMO2aGxl?= <CLoehle@hyperstone.com>,
        Yue Hu <huyue2@yulong.com>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220115121447.641524-1-andrej.skvortzov@gmail.com>
 <CAPDyKFp=pn=yvEtur4rbQwweq2VNc8+2VniYV5ZVy8=re7VJXw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAPDyKFp=pn=yvEtur4rbQwweq2VNc8+2VniYV5ZVy8=re7VJXw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22-01-21 15:32, Ulf Hansson wrote:
> On Sat, 15 Jan 2022 at 13:15, Andrey Skvortsov
> <andrej.skvortzov@gmail.com> wrote:
> >
> > SD card is allowed to signal busy on DAT0 up to 1s after the
> > CMD49. According to SD spec (version 6.0 section 5.8.1.3) first host
> > waits until busy of CMD49 is released and only then polls Power
> > Management Status register up to 1s until the card indicates ready to
> > power off.
> >
> > Without waiting for busy before polling status register sometimes card
> > becomes unresponsive and system fails to suspend:
> >
> >   [  205.907459] Freezing remaining freezable tasks ... (elapsed 0.001 seconds) done.
> >   [  206.421274] sunxi-mmc 1c0f000.mmc: data error, sending stop command
> >   [  206.421321] sunxi-mmc 1c0f000.mmc: send stop command failed
> >   [  206.421347] mmc0: error -110 reading status reg of PM func
> >   [  206.421366] PM: dpm_run_callback(): mmc_bus_suspend+0x0/0x74 returns -110
> >   [  206.421402] mmcblk mmc0:aaaa: PM: failed to suspend async: error -110
> >   [  206.437064] PM: Some devices failed to suspend, or early wake event detected
> >
> > Tested with Sandisk Extreme PRO A2 64GB on Allwinner A64 system.
> >
> > Signed-off-by: Andrey Skvortsov <andrej.skvortzov@gmail.com>
> 
> I did some tests at my side too, using a Qcom platform and it worked
> fine. However, I also used the same type of card as you, as I didn't
> have any other try with at this moment.

> So, applied for fixes and by adding a fixes/stable tag, thanks!
Thank you very much.
There is one another test report, that this patch fixes suspend with
KLEVV CRAS 128GB (K128GUSD6U3-CA). [1]

1. https://gitlab.com/mobian1/issues/-/issues/389#note_816636364

> I also did a minor amendment to the patch, see below.
> 
> Kind regards
> Uffe

-- 
Best regards,
Andrey Skvortsov
