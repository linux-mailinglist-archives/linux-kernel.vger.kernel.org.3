Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 182C35550D6
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 18:06:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359203AbiFVQGV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 12:06:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358896AbiFVQF7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 12:05:59 -0400
Received: from mail-oa1-x2a.google.com (mail-oa1-x2a.google.com [IPv6:2001:4860:4864:20::2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62CDE26AD3
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 09:05:58 -0700 (PDT)
Received: by mail-oa1-x2a.google.com with SMTP id 586e51a60fabf-101dc639636so13226897fac.6
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 09:05:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jFC4cNY5zbSDfSvr3npwCt7dDz8aPPm7c4kPd4eEXSg=;
        b=hz2QEETvDhkY1QrtCHM4s9S3m9NTKLfkyFbY7FmOeH3Q6ljfbCZSbf65HK/JlCAxzm
         dX7TbzMcMIe45t8f7RoMCPXBQQZLkEF3cAn+YOaBu0ZNQgj8kseMxeIDqwHG+oSyI1UT
         9zKmwtu0fs49pXC3QeBLIKy/hWg7yhEgDspRPwKlqC2LjrMQQLiBdTjFTuwLh8KUBbLd
         LWGmp7oVfDDKozt9/gvJgBCTNhdH4JLGZaKSRHqlAp8uSjCVU8lYGs0hAyiXE17J1UCF
         xBJl8/m4ZQI5XEBMosq0aBzF6BUoAqrL6uo5s1FDqvMatzL9d80pn8F6ng1HaKwiZio1
         DBVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jFC4cNY5zbSDfSvr3npwCt7dDz8aPPm7c4kPd4eEXSg=;
        b=zsALirre0H9bFb2JDyYmu1qen3m/cPn5UmUZr00XndLuRJvd6F5FgFPVqaaUpsrA4h
         MsrQ7j/aicfjm4AZW6R9afsl5rxAFuW2OOcKyhO75D/AdzvvALIVb/DOLfYz2whtT1ly
         9DimsZZ9ivXkM8S5L0eYVmSE7IoMqlTfC2C8N0A8aVEV5FQwknAJ5eJM4/2F4S+UDf1u
         cpYJBT6jjzMZ32W9/Skxfx+62kwY9HQtw0V8PT3AOvPE84GTK2rGLZh43TyPRXoA4WWW
         xBtikdc0LT2CphU1oWq/et3PgdpCFDR+jQbiCjThIji/2o+IJ1fzX2hN9REQrBOJB755
         a7Ow==
X-Gm-Message-State: AJIora8cYBKCJ2phjYDFMmsuGG4Lu3RE/CAwgwmFTbE05XBq0vyPdjX/
        oRLjhfT/nQ1lGqBP/P9l3jkJQmMbFfse2vdWBf4=
X-Google-Smtp-Source: AGRyM1sskIl4FLiSD94GzSBf0mEnDLqvrDPUEdzFGq7YDjBA+mkqly3EuPDSy8K2N/9s8bSN9LdDmh7SPtoAApSCEiE=
X-Received: by 2002:a05:6870:f2a7:b0:f1:7205:d130 with SMTP id
 u39-20020a056870f2a700b000f17205d130mr2507573oap.146.1655913957677; Wed, 22
 Jun 2022 09:05:57 -0700 (PDT)
MIME-Version: 1.0
References: <20220620134758.1286480-2-aisheng.dong@nxp.com>
 <YrCM0reni+x/KWsG@sirena.org.uk> <DB9PR04MB84779EF2842D789FA66094C380B09@DB9PR04MB8477.eurprd04.prod.outlook.com>
 <YrCXILblKsp6DuN3@sirena.org.uk> <DB9PR04MB8477CD99D5847291A629994180B09@DB9PR04MB8477.eurprd04.prod.outlook.com>
 <YrCznap77OyHu4bO@sirena.org.uk> <DB9PR04MB847785E1861525FC1E4AD97280B39@DB9PR04MB8477.eurprd04.prod.outlook.com>
 <YrHkXH1M4NydBfQT@sirena.org.uk> <DB9PR04MB84772F73D4AA1B49F87BECCF80B39@DB9PR04MB8477.eurprd04.prod.outlook.com>
 <CAA+hA=RQVRHzdy_ZpwcC-ZB8mwUYuMYu_iLNAfuPcMCS1G9WXA@mail.gmail.com> <YrMMzizzE7rIji5x@sirena.org.uk>
In-Reply-To: <YrMMzizzE7rIji5x@sirena.org.uk>
From:   Dong Aisheng <dongas86@gmail.com>
Date:   Thu, 23 Jun 2022 00:05:46 +0800
Message-ID: <CAA+hA=SA7BY8WxrbuRAOsuHyz+bx-EJq-UT_YLW5wYMS+io+pg@mail.gmail.com>
Subject: Re: [PATCH RFC 1/2] regmap: add option to disable debugfs
To:     Mark Brown <broonie@kernel.org>
Cc:     Aisheng Dong <aisheng.dong@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
        Peng Fan <peng.fan@nxp.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>
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

On Wed, Jun 22, 2022 at 8:36 PM Mark Brown <broonie@kernel.org> wrote:
>
> On Wed, Jun 22, 2022 at 06:12:49PM +0800, Dong Aisheng wrote:
>
> > NOTE:  i didn't fix _regmap_write() as i.MX controls regmap write well in driver
> > with power enabled first, so don't have issues in reality.
>
> I can't tell what you think the problem is with _regmap_write()?
>

Because from what I see,  _regmap_write() seems still can write to HW
register even with cache_only mode set theoretically.

> > It can be fixed in a separate patch later if needed.
> > You may check if it's as your expected solution.
>
> > For syscon, I still have no idea how to fix it if I can't disable it.
> >
> > diff --git a/drivers/base/regmap/regcache.c b/drivers/base/regmap/regcache.c
> > index 2eaffd3224c9..da1702fd57cc 100644
> > --- a/drivers/base/regmap/regcache.c
> > +++ b/drivers/base/regmap/regcache.c
> > @@ -495,7 +495,7 @@ EXPORT_SYMBOL_GPL(regcache_drop_region);
> >  void regcache_cache_only(struct regmap *map, bool enable)
> >  {
> >         map->lock(map->lock_arg);
> > -       WARN_ON(map->cache_bypass && enable);
> > +//     WARN_ON(map->cache_bypass && enable);
> >         map->cache_only = enable;
> >         trace_regmap_cache_only(map, enable);
> >         map->unlock(map->lock_arg);
>
> What is the purpose of this change?  Why would the combination of cache
> only and bypass modes work be a good idea, and how should things behave
> in that case?
>

Because without this change, there will be a kernel dump caused by
WARN_ON when drivers call regcache_cache_only(map, true) after power
is off. There's no cache used in the imx blkctl driver. So map->cache_bypass
is default to true.

I did this by following your previous suggestion as follows:
"You don't actually need to have a cache to use cache only mode, if there
are no cached registers then you'll just get -EBUSY on any access to the
registers but that's hopefully fine since at the minute things will just
fall over anyway.  You shouldn't even need to flag registers as volatile
if there's no cache since it's not really relevant without a cache."

Am I misunderstanding your suggestions?

Regards
Aisheng
