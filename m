Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96BB359E665
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 17:55:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243529AbiHWPzJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 11:55:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243423AbiHWPym (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 11:54:42 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 224D0B14F2;
        Tue, 23 Aug 2022 05:02:23 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id 2so12637851pll.0;
        Tue, 23 Aug 2022 05:02:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc;
        bh=MW5XHnocsOAaHtG3kygIZyIxCnx5KeX6wL9mjNNXSWw=;
        b=eZXrnK9xqPJeFdFVnwd4Dje9M1VtwDGevH3/C76E5FZrjekitnJDYxsTALFSLxXNUQ
         +hSN7IIZom46H8XOL0s/gvJ5CWl3GPmcwMFYy844ihT8T4UPUmolsMLwEFj8pxwhs/Q7
         H72Kk0vhrcz/74qsNYB1qcnQDlyJcuAANhKPG8s8uv5PywigVU69kW3Y8nmzVT/2TUQH
         GeJtib/WA8YU+yjQCnaK7R2NmAw6TaJitJT7rIZMt2mYewBNbKeZZUV/YvFhs+xxDTJt
         Z07Lh+gR7pnDCMfT19XhJiE11ZPuQ34c1K2tLqr0ZW+t/IfxNZQn9enzejASxwF5FxdB
         OJ5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc;
        bh=MW5XHnocsOAaHtG3kygIZyIxCnx5KeX6wL9mjNNXSWw=;
        b=TONB3UJ+tMbPqdFJmiZkamB9hEQ1Bt8/27janl4NqsXZncN4R1rrZ4ZvXlz2Rzchl/
         a1lEVWZk/0VEUpAcIBM5GovTYvuUoJRsAWeqUh7KaKhB7+dWANZ1BDGvTWtcFZMyDb9c
         Jm8g2cSSsrt2RmQlye3UyO6FhF1ZGG437OAW9ySrn+SvpXBClWgdMbLkURuvBkcCGE4L
         4YW2X9gFVsHKMeyVjIQsBBmb2FnyIcT4ZO8xEhk7meqo6nZU+nqWLUH/QICvtMp8xmVI
         xZL8ZDRbfZzsEHpcldsRwuUSCLbs4col89jECwNBXX5RjMTnue2WHxHm6EYL6tJwGo1n
         ciEA==
X-Gm-Message-State: ACgBeo1xl1VU+o0gK8JX8u/L0IMnALl0Gc+eRsPbhCBftJCudZDtrtbQ
        VPkjguWVWONTXecn1m3tsk0=
X-Google-Smtp-Source: AA6agR78SqzHncKtHN1CIlqDbFm1R7V4cFot4jLfRNHLIMGY1Ft28MBNZOJ5ydYRsctb+ZOzo/3cqA==
X-Received: by 2002:a17:902:b483:b0:170:a89f:32b3 with SMTP id y3-20020a170902b48300b00170a89f32b3mr24219704plr.149.1661256142738;
        Tue, 23 Aug 2022 05:02:22 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id t15-20020a17090340cf00b0016dbce87aecsm6684594pld.182.2022.08.23.05.02.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Aug 2022 05:02:21 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Tue, 23 Aug 2022 05:02:19 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Marco Felsch <m.felsch@pengutronix.de>
Cc:     "Alice Guo (OSS)" <alice.guo@oss.nxp.com>,
        "wim@linux-watchdog.org" <wim@linux-watchdog.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>
Subject: Re: [PATCH 2/7] watchdog: imx7ulp: Add explict memory barrier for
 unlock sequence
Message-ID: <20220823120219.GA203169@roeck-us.net>
References: <20220816043643.26569-1-alice.guo@oss.nxp.com>
 <20220816043643.26569-3-alice.guo@oss.nxp.com>
 <20220816062330.z2fvurteg337krw2@pengutronix.de>
 <AM6PR04MB60537292F559EC012F0EB510E2719@AM6PR04MB6053.eurprd04.prod.outlook.com>
 <20220822080010.ecdphpm3i26cco5f@pengutronix.de>
 <20220822140347.GA4087281@roeck-us.net>
 <AM6PR04MB6053E26CB59410EBCC2C93AEE2709@AM6PR04MB6053.eurprd04.prod.outlook.com>
 <20220823091027.ezyxkn64asajvjom@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220823091027.ezyxkn64asajvjom@pengutronix.de>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 23, 2022 at 11:10:27AM +0200, Marco Felsch wrote:
> On 22-08-23, Alice Guo (OSS) wrote:
> > 
> > 
> > > -----Original Message-----
> > > From: Guenter Roeck <groeck7@gmail.com> On Behalf Of Guenter Roeck
> > > Sent: Monday, August 22, 2022 10:04 PM
> > > To: Marco Felsch <m.felsch@pengutronix.de>
> > > Cc: Alice Guo (OSS) <alice.guo@oss.nxp.com>; wim@linux-watchdog.org;
> > > shawnguo@kernel.org; s.hauer@pengutronix.de; festevam@gmail.com;
> > > linux-arm-kernel@lists.infradead.org; linux-kernel@vger.kernel.org;
> > > dl-linux-imx <linux-imx@nxp.com>; kernel@pengutronix.de;
> > > linux-watchdog@vger.kernel.org
> > > Subject: Re: [PATCH 2/7] watchdog: imx7ulp: Add explict memory barrier for
> > > unlock sequence
> > > 
> > > On Mon, Aug 22, 2022 at 10:00:10AM +0200, Marco Felsch wrote:
> > > > On 22-08-22, Alice Guo (OSS) wrote:
> > > > > > -----Original Message-----
> > > > > > From: Marco Felsch <m.felsch@pengutronix.de>
> > > > > > Sent: Tuesday, August 16, 2022 2:24 PM
> > > > > > To: Alice Guo (OSS) <alice.guo@oss.nxp.com>
> > > > > > Cc: wim@linux-watchdog.org; linux@roeck-us.net;
> > > > > > shawnguo@kernel.org; s.hauer@pengutronix.de; festevam@gmail.com;
> > > > > > linux-arm-kernel@lists.infradead.org;
> > > > > > linux-kernel@vger.kernel.org; dl-linux-imx <linux-imx@nxp.com>;
> > > > > > kernel@pengutronix.de; linux-watchdog@vger.kernel.org
> > > > > > Subject: Re: [PATCH 2/7] watchdog: imx7ulp: Add explict memory
> > > > > > barrier for unlock sequence
> > > > > >
> > > > > > On 22-08-16, Alice Guo (OSS) wrote:
> > > > > > > From: Jacky Bai <ping.bai@nxp.com>
> > > > > > >
> > > > > > > Add explict memory barrier for the wdog unlock sequence.
> > > > > >
> > > > > > Did you inspected any failures? It's not enough to say what you
> > > > > > did, you need to specify the why as well.
> > > > > >
> > > > > > Regards,
> > > > > >   Marco
> > > > >
> > > > > Hi,
> > > > >
> > > > > Two 16-bit writes of unlocking the Watchdog should be completed within a
> > > certain time. The first mb() is used to ensure that previous instructions are
> > > completed.
> > > > > The second mb() is used to ensure that the unlock sequence cannot be
> > > affected by subsequent instructions. The reason will be added in the commit
> > > log of v2.
> > > >
> > > > Hi,
> > > >
> > > > I know what memory barriers are. My question was, did you see any
> > > > issues? Since the driver is used mainline and no one reported issues.
> > > >
> > > > Also just don't use the *_relaxed() versions is more common, than
> > > > adding
> > > > mb() calls around *_relaxed() versions.
> > > >
> > > 
> > > Agreed with both. The series is a bit short in explaining _why_ the changes are
> > > made.
> > > 
> > > Guenter
> > > 
> > > > Regards,
> > > >   Marco
> > > >
> > > > >
> > 
> > Hi Guenter and Marco,
> > 
> > 1. did you see any issues?
> > This WDOG Timer first appeared in i.MX7ULP, no one report issues
> > probably because few people use i.MX7ULP. This issue was found when we
> > did a stress test on it. When we reconfigure the WDOG Timer, there is
> > a certain probability that it reset. The reason for the error is that
> > when WDOG_CS[CMD32EN] is 0, the unlock sequence is two 16-bit writes
> > (0xC520, 0xD928) to the CNT register within 16 bus clocks, and
> > improper unlock sequence causes the WDOG to reset. Adding mb() is to
> > guarantee that two 16-bit writes are finished within 16 bus clocks.
> 
> After this explanation the whole imx7ulp_wdt_init() seems a bit buggy
> because writel_relaxed() as well as writel() are 32bit access functions.
> So the very first thing to do is to enable the 32-bit mode.
> 
Agreed. This is much better than having extra code to deal with
both 16-bit and 32-bit access.

> Also this is a explanation worth to be added to the commit message ;)
> 

Definitely. Also, the use of mb(), if it should indeed be needed,
would have to be explained in a code comment.

Thanks,
Guenter

> > 2. Also just don't use the *_relaxed() versions is more common, than
> > adding mb() calls around *_relaxed() versions.  Memory barriers cannot
> > be added between two 16-bit writes. I do not know the reason.
> 
> As written above, writel() as well as writel_relaxed() are not 16-bit
> access functions.
> 
> So to me it looks as you need first to ensure that 32-bit access mode is
> enabled. After that you can write drop the to writel_relaxed() functions
> and instead just write:
> 
>    writel(UNLOCK, wdt->base + WDOG_CNT);
> 
> Also why do we need to unlock the watchdog during imx7ulp_wdt_init()?
> This is handled just fine during imx7ulp_wdt_enable() and during
> imx7ulp_wdt_set_timeout(). So just drop those relaxed writes and
> everything should be fine.
> 
> Regards,
>   Marco
