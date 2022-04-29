Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C61B251416D
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 06:26:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237299AbiD2E3x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 00:29:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230133AbiD2E3v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 00:29:51 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 732205044B;
        Thu, 28 Apr 2022 21:26:33 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id v64-20020a1cac43000000b0038cfd1b3a6dso6339839wme.5;
        Thu, 28 Apr 2022 21:26:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Qmzf5Rpe4BAYEcfLY1mu6024biZhz8XXL3oPqQFDltc=;
        b=PjAh5/xGD32XZjaKZ5LBIsxhVSQPVuMOKUhwHS8hmQjFiCJMkA6rFenyhGDMPzv/0t
         e6tx20JtZm2W6f60Q97OIA2p9Zs3qDnvNuVoWppviX0iqEv0OBsDFiBge4N8y9H1Bhfo
         P3FemlqPN7Uyd00HSbym99eWdrMaeQ0813fczm7/t0FO1DI1NTct6eC3cCpCRqZJUxJZ
         YVgZCZzQPgWtcmRqD0+tZ6LMnjFIJoHeFoucfQY616RCv52427qgI8zgqksc2V0RLdDG
         jfME1RQRPPtusQu5Ti1J0HqxgHX5cv5KwvjQHphC8MemZ3h22vM3PNJAqJtpACK6hQQq
         nGMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Qmzf5Rpe4BAYEcfLY1mu6024biZhz8XXL3oPqQFDltc=;
        b=Rcv2W6Pvqk1tUjNI0SSIt9fDIuuS7ZALq+9cs7nsPxnTN63vc4KVK3oOUQPYnupqx+
         LYLa1vbCqiyrz06kPcU4oYqKk4JJ/wuIIwmb2Axclzjs7PB4vAuVJvMrl19+py3f6RP/
         U0wxROc615ALX9aFX7aAABv3f0Maa0nlwJhNFbIvd+UcJyj5FHKW8KwwXs2vvAThB3Vc
         ty0TOh3VZycH3GDieiv5cg9YCDsrjEnv6s0LrMKsuoKVUGHc6EHHw/GWygRR1Z0SH9jE
         LCc4oXx19K2JT+GSkUJ+qtmaqmoVaSy6E7jEwxZh/EYDi4KogzW3gKy7yDE8hKkLpCmK
         UjDg==
X-Gm-Message-State: AOAM533eEMEN9senieD1qGUfUaK8XJc666Rb+F934QlYSSzrUvbbd+96
        pkk7503QN4NkxYdCGnkbrlOnS+P43Nqq7QnKwdY=
X-Google-Smtp-Source: ABdhPJxmlsLKQ0g/Bey9oPabETfJX65n2wu+SZgjNufxp/w3P+/FGsiyVHNlhVVK+0ytDEK37Fx6ERY1QV/679zMOac=
X-Received: by 2002:a7b:c0cb:0:b0:38e:bac7:3c40 with SMTP id
 s11-20020a7bc0cb000000b0038ebac73c40mr1330883wmh.6.1651206391974; Thu, 28 Apr
 2022 21:26:31 -0700 (PDT)
MIME-Version: 1.0
References: <20220419142458.884933-1-gengcixi@gmail.com> <20220424183443.2382ef9c@jic23-huawei>
In-Reply-To: <20220424183443.2382ef9c@jic23-huawei>
From:   Cixi Geng <gengcixi@gmail.com>
Date:   Fri, 29 Apr 2022 12:25:55 +0800
Message-ID: <CAF12kFuROw9OFPwk0JFDrAgyTycK2zBJsCAPzN2s0SbBDp9KxA@mail.gmail.com>
Subject: Re: [PATCH V4 0/7] iio: adc: sc27xx: adjust structure and add PMIC's support
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        krzysztof.kozlowski+dt@linaro.org,
        Orson Zhai <orsonzhai@gmail.com>,
        "baolin.wang7@gmail.com" <baolin.wang7@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        =?UTF-8?B?5pyx546J5piOIChZdW1pbmcgWmh1LzExNDU3KQ==?= 
        <yuming.zhu1@unisoc.com>, linux-iio@vger.kernel.org,
        Devicetree List <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jonathan Cameron <jic23@kernel.org> =E4=BA=8E2022=E5=B9=B44=E6=9C=8825=E6=
=97=A5=E5=91=A8=E4=B8=80 01:26=E5=86=99=E9=81=93=EF=BC=9A
>
> On Tue, 19 Apr 2022 22:24:51 +0800
> Cixi Geng <gengcixi@gmail.com> wrote:
>
> > From: Cixi Geng <cixi.geng1@unisoc.com>
> >
> > this patchset add a sc27xx_adc_variant_data structure
> > and add sc272*,sc273* and ump9620 PMIC support.
>
> Series applied with the minor tweaks I've called out in replies
> to individual patches.
Thank you very much,I am very appreciated for your patience and sugestion
>
> Applied to the togreg branch of iio.git and pushed out as testing
> for 0-day to see if it can find anything we missed.
>
> Thanks,
>
> Jonathan
>
> >
> > v2 changes:
> >   fix dt_binding_check error
> >   adjust some code-style issue
> >   optimize the copy-paste functions
> >   the smatch warnings found by lkp
> >   and  ohter comments by v1 patches.
> >
> > v3 changes:
> >   fix nvmem-cells Items value and add ump9620 dt sample
> >   add the correct signature for each patch
> >   fix the unused warning in 3/7, add explain for set the scales
> >   remove duplicate code,add goto label in sc27xx_adc_read
> >   pull out the refactor code into a single patch
> >   delete the suspend and resume pm for ump9620
> >
> > v4 changes:
> >   Add fix tag in the 2/7 patch.
> >   Separate modification and refactoring 3/7(v3) to 2 pathes.
> >   remove the pmic_type struct instead of a boot set_volref
> >   to define the specific feathure.
> >   use switch statement in all scale_init functions.
> >   remove ump9620 pmic support in this patchset, submit separately
> >   in the next patches.
> >
> > Cixi Geng (7):
> >   dt-bindings:iio:adc: add sprd,ump9620-adc dt-binding
> >   iio: adc: sc27xx: fix read big scale voltage not right
> >   iio: adc: Fine tune the scale calibration values
> >   iio: adc: sc27xx: structure adjustment and optimization
> >   iio: adc: refactor some functions for support more PMiCs
> >   iio: adc: sc27xx: add support for PMIC sc2720 and sc2721
> >   iio: adc: sc27xx: add support for PMIC sc2730
> >
> >  .../bindings/iio/adc/sprd,sc2720-adc.yaml     |  59 ++-
> >  drivers/iio/adc/sc27xx_adc.c                  | 473 ++++++++++++++++--
> >  2 files changed, 491 insertions(+), 41 deletions(-)
> >
>
