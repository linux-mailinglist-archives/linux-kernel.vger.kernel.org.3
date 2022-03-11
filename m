Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1758B4D5B16
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 06:59:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347755AbiCKF7i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 00:59:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346715AbiCKFyT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 00:54:19 -0500
Received: from mail-io1-xd43.google.com (mail-io1-xd43.google.com [IPv6:2607:f8b0:4864:20::d43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CD81F1E8F
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 21:53:14 -0800 (PST)
Received: by mail-io1-xd43.google.com with SMTP id x4so9011341iom.12
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 21:53:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iH2ohTMZfPnRZ9E6jdBe6JKfO5koQv5qtiPS15nsl0I=;
        b=lBLSNHNDBDLhECW+i7GItRVFc2s/fgUj/HMjqg84Xln7MQUu6DxpDIq7jdrZwx2YWB
         HDmLI2wAzHNtmqomw5J3eD4YE0N+ivlLv1Er2iRuVUG3/ri6ZqhWubh8509kcBE3idYJ
         QSA8JQqsfolKtgGCs518PBnajsSWdlErkZ82pu6WfzPooJzUIJTbF/7cexQ5S5Qzlfm4
         T3VU65+SP5zmCBG6TatJtUP47W9CAUa1dZzaetX2Lj37T5DDBjKD1toIp6o1KdpvmHbF
         sS2V5edCKN/TlpsmgAUVLXwVE/c7LQBrMEB794Vlthuht9Tw3zS8/YqcEUwo9Q6D9LGW
         yd4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iH2ohTMZfPnRZ9E6jdBe6JKfO5koQv5qtiPS15nsl0I=;
        b=MFV9eJSnm7/8G5Yh6B3+nqwHIOBVgN++NcG1hnEefuLMirb8GoT4sqOG76k08OICvq
         5zS1iZfyllYg7OQQmFURSgB6aTlbxy0I8oeBgbSfZRhJlBiH7Q6Xb6NHnM3ik2BZub/t
         oQXypv35Dw5k0AIS16qj4Q6MOF2URLpUWCHLteQjTOCxrfXt3RzdC073u7NpAgYQ1MKI
         bMBC+1nuQ8FfJR763GpHGr9cKeicEpmIfHky/iCaEzC2HQAQ7A2Q5UZxGqkVyGIiqYLl
         7uv+QKv3e2z6r1jhYV4bvfFsYAm7nmcmQ36wQqS3G99A8VI4/2ZB5OoDtFntJFfp1eu/
         3WtA==
X-Gm-Message-State: AOAM5320JmI6XzShPbBDcWjFzpupSwSSgJvl3kBK674zUlGj2eC1qtCk
        ZOO+vdmHm64TMARKgEr97Ih/OyYtf2TGltldWCs=
X-Google-Smtp-Source: ABdhPJyhB8o0PTCDqSOXDuEw7PVy6+1fE/kih9mRtFuqIls65qjo2Ut/x9nk2zkysjNJPIYFuuSGFOigSWM7dqpBCj0=
X-Received: by 2002:a5d:8ace:0:b0:641:2a6e:471c with SMTP id
 e14-20020a5d8ace000000b006412a6e471cmr6896106iot.42.1646977993769; Thu, 10
 Mar 2022 21:53:13 -0800 (PST)
MIME-Version: 1.0
References: <20220310081548.31846-1-steve.lee.analog@gmail.com>
 <SJ0PR03MB67794358405FA661992A206D990B9@SJ0PR03MB6779.namprd03.prod.outlook.com>
 <YinhDPrSvrYV5vKp@sirena.org.uk>
In-Reply-To: <YinhDPrSvrYV5vKp@sirena.org.uk>
From:   Lee Steve <steve.lee.analog@gmail.com>
Date:   Fri, 11 Mar 2022 14:53:02 +0900
Message-ID: <CA+Fz0PZN=aW=YQ=np=tbcJat-B7GR-DFeWKufABEJbPfOz9bpA@mail.gmail.com>
Subject: Re: [PATCH] ASoC: max98390: Add reset gpio control
To:     Mark Brown <broonie@kernel.org>
Cc:     "Sa, Nuno" <Nuno.Sa@analog.com>,
        "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "perex@perex.cz" <perex@perex.cz>,
        "tiwai@suse.com" <tiwai@suse.com>,
        "ckeepax@opensource.cirrus.com" <ckeepax@opensource.cirrus.com>,
        "geert@linux-m68k.org" <geert@linux-m68k.org>,
        "rf@opensource.wolfsonmicro.com" <rf@opensource.wolfsonmicro.com>,
        "shumingf@realtek.com" <shumingf@realtek.com>,
        "srinivas.kandagatla@linaro.org" <srinivas.kandagatla@linaro.org>,
        "krzk@kernel.org" <krzk@kernel.org>,
        "dmurphy@ti.com" <dmurphy@ti.com>,
        "jack.yu@realtek.com" <jack.yu@realtek.com>,
        "steves.lee@maximintegrated.com" <steves.lee@maximintegrated.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 10, 2022 at 8:29 PM Mark Brown <broonie@kernel.org> wrote:
>
> On Thu, Mar 10, 2022 at 08:48:09AM +0000, Sa, Nuno wrote:
>
> > > +   max98390->reset_gpio = of_get_named_gpio(i2c-
> > > >dev.of_node,
> > > +                                           "maxim,reset-gpios", 0);
>
> > Why not using devm_gpiod_get_optional()? We could request the pin
> > already in the asserted state and make the code slightly better...
>
> Yes, and it'd support other firmware interfaces too.  We also need an
> update to the binding document covering the new property.
>
> Might also be worth putting the device into reset when unloading the
> driver, though that's not essential.

I will check and update v2 patch.
