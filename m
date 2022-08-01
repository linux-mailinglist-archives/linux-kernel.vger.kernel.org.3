Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 769265866D7
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Aug 2022 11:29:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230012AbiHAJ3q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Aug 2022 05:29:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229909AbiHAJ3o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 05:29:44 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 526453A48E
        for <linux-kernel@vger.kernel.org>; Mon,  1 Aug 2022 02:29:42 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id s11so1532476edd.13
        for <linux-kernel@vger.kernel.org>; Mon, 01 Aug 2022 02:29:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=dbzg+GPWLRcgadG8H1umO0RU/iJrt3Fpb+tnPvJIv50=;
        b=bZGcwf1PF/s8iE6aOi/Tbp9xcDN9oP2wsGD24ZxwSmopeRyeKqyhoLMh2aoFQQ9LEZ
         8k6wMJgHfm20Mr1jzyDAcFC0GiLa5mbvVKMBgKWB3mmNiVbV2u4D5RUTMan2cgU5+ZJr
         h1CZhFSWkDC5QqGnfs4SIuejzMDZk84uYQ5+fX/WML+MkYKQOtT/HVv6sN4heFQScs/W
         +ytoaxtlRgd5azF+GZHll7kFOFmHfoIa3zgp0h6IqVVUrEWSNo4dTi1s0lrNirdALpbL
         WNbXQ2J5jgir12ojygb53BccGe4T4OptrB7/41cks84xBw8DK/cq8dYYZzL3OW0nxUOE
         eR2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=dbzg+GPWLRcgadG8H1umO0RU/iJrt3Fpb+tnPvJIv50=;
        b=PYKSvZxKnAN6R6DTda2YtyUersYGLVSVRwhGT0ny2tUKxetTNJEdtwBwd2dyJs0GKw
         VV7KvtER9ZHDVZQWWWTserAewC2DgWPHUESei79U5b0K8uLjWF67ZZnNukRJOJUwUYUo
         xbd2j24UcAooM2Qe2XvFLCjhJ1MFunoatnDCAeoaJcFXFGtHpWomMa9fKH/bmXmzo/fN
         lWDnsek2hWh++Lz71zY6SkfSmOZ8RCFeiv82I+Avy73ofiWvHTSq33eW1JowYfyHH5uN
         r55PMe1uBvLHnUudYHW7b4GabdjqOI5PwTitj3o++mTJUT7/5O5YDHipxW7eSwqAholb
         oeUg==
X-Gm-Message-State: AJIora9tvZH4LWm+EROXT+nkqQWHGikb9W6+lhmZnQaSdMu1KrAg02th
        dGI9pNRxDRupQY5hm1PxOOJmtp1YyK6ALZm1K6g=
X-Google-Smtp-Source: AGRyM1t1hGvLmwbSGPn5h+yEyR3ix5Tb3AyJexwfnSLIS2WAIZrDS1BN6pfc1dDw0GiR+jWiFEm2eINvwnGhV2ooyFw=
X-Received: by 2002:a05:6402:40c3:b0:43b:d65a:cbf7 with SMTP id
 z3-20020a05640240c300b0043bd65acbf7mr15295117edb.380.1659346180866; Mon, 01
 Aug 2022 02:29:40 -0700 (PDT)
MIME-Version: 1.0
References: <20220731201258.11262-1-andriy.shevchenko@linux.intel.com>
 <9b9abdf0-7cd5-df51-adbf-2225291f0dd2@redhat.com> <CAHp75VduSG=BerPJo9phXJKWa-yu_uXbP+ifkax=3FUTE7et+Q@mail.gmail.com>
In-Reply-To: <CAHp75VduSG=BerPJo9phXJKWa-yu_uXbP+ifkax=3FUTE7et+Q@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 1 Aug 2022 11:29:04 +0200
Message-ID: <CAHp75VcmuVcA_heURNh96zBDtpeNvx0t9buDOxnWNoea2G1uDg@mail.gmail.com>
Subject: Re: [PATCH v2 01/10] mfd: intel_soc_pmic: Fix an error handling path
 in intel_soc_pmic_i2c_probe()
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Lee Jones <lee.jones@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Lee Jones <lee@kernel.org>, Andy Shevchenko <andy@kernel.org>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 1, 2022 at 11:14 AM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
> On Mon, Aug 1, 2022 at 10:43 AM Hans de Goede <hdegoede@redhat.com> wrote:
> > On 7/31/22 22:12, Andy Shevchenko wrote:

...

> > >  err_del_irq_chip:
> > > +     pwm_remove_table(crc_pwm_lookup, ARRAY_SIZE(crc_pwm_lookup));
> > >       regmap_del_irq_chip(pmic->irq, pmic->irq_chip_data);
> > >       return ret;
> >
> > Note alternatively we could just move the pwm_add_table() to just before the "return 0",
> > there is no strict ordering between adding the mfd devices and the pwm_add_table()
> > (the pwm device only becomes available after the pwm-driver has bound to the mfd
> > instantiated platform device which happens later).

Just to be sure... How is it guaranteed that that happens later?

-- 
With Best Regards,
Andy Shevchenko
