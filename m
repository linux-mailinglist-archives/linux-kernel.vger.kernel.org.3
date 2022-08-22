Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 018D559C145
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 16:04:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233496AbiHVOEA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 10:04:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232970AbiHVOD4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 10:03:56 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2945711A22;
        Mon, 22 Aug 2022 07:03:51 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id 83so4720071pfw.6;
        Mon, 22 Aug 2022 07:03:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc;
        bh=0A2JXfJDSR4G0CYo2LChqbAslPOGOawrmt7yfW7EOa0=;
        b=jrWeRJFk/Qug7juMuMKJs6Hm0+kdzx1Y0XIqmgyg6ofa02GlH1eEC9TvEsy43PDTu4
         ReXx4uKxQPAqYqZKpK2Q+WLwndJefOMPJQ/+DlQNZwhHuHR1T4/Svr4cdWjvwKtOJ6H1
         8VzR2ZeGicNsMB/9QjT/ucdReTx0ddQRtz0FlRmUEsfkpayie+cj5HDCTLdhdiECTXB6
         rAUUGfWBErCRdOmzgEpO0A1iMLW0AHF1ks4HDdVLwMXWEoydr1hrnbr2vsi1ZDrl8cHu
         Hzprd928Ot8YrKrSlmcAW4d0r7jO8jRlK9zP5qqb/bISOO+nSex7qIARzjnfgONCgeMw
         VmxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc;
        bh=0A2JXfJDSR4G0CYo2LChqbAslPOGOawrmt7yfW7EOa0=;
        b=grSE8ADfjENtaFDLvB/uIhrWf8MQ1ZKimHnM3/D42pYdObJDcXg7pFQzqP3YkhnbSW
         iDxJquWZw/ICQlPuKKGjfEqd6dA81lUUy8OHANSEcZn5bsMppjrafqncrn5x9XJoLG5/
         QCBlSQccrV2wGMXhNsZ8KW5Uas9bURmXgpLvnV2etsHFdxI4gGRe9qcnmIZrooqv+ijx
         e4l7FI3VQfurZUMVGBqO6w0qQ0KNMc/YGkoQU2yj66ueR2iVvvAwSWx0AtEmFuKQViYy
         xkouwTEdeF3tuOpgq1XlMo3S69alw+ADkQPfxf/nII9qi+oma8rD6uh2IgytS5hSAsji
         P6CQ==
X-Gm-Message-State: ACgBeo3r6CwMMvko10tJ9rzNfq5ePcJpCN9DBlb+4Jd9ZXT2XK35ZAP6
        0yl4KyqQL8T1zzd9LBkXBq8=
X-Google-Smtp-Source: AA6agR7BNP36mrahNPk3UZjs/dBbAHAgzdCFxVaIVWX1BkIjzc40ErQZX5mnK4duwiw7DbUJwWmLHA==
X-Received: by 2002:a05:6a00:1d8c:b0:536:c30a:241e with SMTP id z12-20020a056a001d8c00b00536c30a241emr3027536pfw.25.1661177030554;
        Mon, 22 Aug 2022 07:03:50 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id 1-20020a620501000000b0052d481032a7sm8724778pff.26.2022.08.22.07.03.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Aug 2022 07:03:49 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Mon, 22 Aug 2022 07:03:47 -0700
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
Message-ID: <20220822140347.GA4087281@roeck-us.net>
References: <20220816043643.26569-1-alice.guo@oss.nxp.com>
 <20220816043643.26569-3-alice.guo@oss.nxp.com>
 <20220816062330.z2fvurteg337krw2@pengutronix.de>
 <AM6PR04MB60537292F559EC012F0EB510E2719@AM6PR04MB6053.eurprd04.prod.outlook.com>
 <20220822080010.ecdphpm3i26cco5f@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220822080010.ecdphpm3i26cco5f@pengutronix.de>
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

On Mon, Aug 22, 2022 at 10:00:10AM +0200, Marco Felsch wrote:
> On 22-08-22, Alice Guo (OSS) wrote:
> > > -----Original Message-----
> > > From: Marco Felsch <m.felsch@pengutronix.de>
> > > Sent: Tuesday, August 16, 2022 2:24 PM
> > > To: Alice Guo (OSS) <alice.guo@oss.nxp.com>
> > > Cc: wim@linux-watchdog.org; linux@roeck-us.net; shawnguo@kernel.org;
> > > s.hauer@pengutronix.de; festevam@gmail.com;
> > > linux-arm-kernel@lists.infradead.org; linux-kernel@vger.kernel.org;
> > > dl-linux-imx <linux-imx@nxp.com>; kernel@pengutronix.de;
> > > linux-watchdog@vger.kernel.org
> > > Subject: Re: [PATCH 2/7] watchdog: imx7ulp: Add explict memory barrier for
> > > unlock sequence
> > > 
> > > On 22-08-16, Alice Guo (OSS) wrote:
> > > > From: Jacky Bai <ping.bai@nxp.com>
> > > >
> > > > Add explict memory barrier for the wdog unlock sequence.
> > > 
> > > Did you inspected any failures? It's not enough to say what you did, you need
> > > to specify the why as well.
> > > 
> > > Regards,
> > >   Marco
> > 
> > Hi,
> > 
> > Two 16-bit writes of unlocking the Watchdog should be completed within a certain time. The first mb() is used to ensure that previous instructions are completed.
> > The second mb() is used to ensure that the unlock sequence cannot be affected by subsequent instructions. The reason will be added in the commit log of v2.
> 
> Hi,
> 
> I know what memory barriers are. My question was, did you see any
> issues? Since the driver is used mainline and no one reported issues.
> 
> Also just don't use the *_relaxed() versions is more common, than adding
> mb() calls around *_relaxed() versions.
> 

Agreed with both. The series is a bit short in explaining _why_ the
changes are made.

Guenter

> Regards,
>   Marco
> 
> > 
> > Best Regards,
> > Alice Guo
> > 
> > > 
> > > >
> > > > Suggested-by: Ye Li <ye.li@nxp.com>
> > > > Signed-off-by: Jacky Bai <ping.bai@nxp.com>
> > > > Signed-off-by: Alice Guo <alice.guo@nxp.com>
> > > > Reviewed-by: Ye Li <ye.li@nxp.com>
> > > > ---
> > > >  drivers/watchdog/imx7ulp_wdt.c | 4 ++++
> > > >  1 file changed, 4 insertions(+)
> > > >
> > > > diff --git a/drivers/watchdog/imx7ulp_wdt.c
> > > > b/drivers/watchdog/imx7ulp_wdt.c index 014f497ea0dc..b8ac0cb04d2f
> > > > 100644
> > > > --- a/drivers/watchdog/imx7ulp_wdt.c
> > > > +++ b/drivers/watchdog/imx7ulp_wdt.c
> > > > @@ -179,9 +179,13 @@ static int imx7ulp_wdt_init(void __iomem *base,
> > > unsigned int timeout)
> > > >  	int ret;
> > > >
> > > >  	local_irq_disable();
> > > > +
> > > > +	mb();
> > > >  	/* unlock the wdog for reconfiguration */
> > > >  	writel_relaxed(UNLOCK_SEQ0, base + WDOG_CNT);
> > > >  	writel_relaxed(UNLOCK_SEQ1, base + WDOG_CNT);
> > > > +	mb();
> > > > +
> > > >  	ret = imx7ulp_wdt_wait(base, WDOG_CS_ULK);
> > > >  	if (ret)
> > > >  		goto init_out;
> > > > --
> > > > 2.17.1
> > > >
> > > >
> > > >
> > 
