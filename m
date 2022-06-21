Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 997B5553D64
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 23:18:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355467AbiFUVSm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 17:18:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355354AbiFUVS1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 17:18:27 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 028D835260;
        Tue, 21 Jun 2022 14:03:56 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id x6-20020a1c7c06000000b003972dfca96cso7879725wmc.4;
        Tue, 21 Jun 2022 14:03:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:from:to:cc:subject:in-reply-to:date:message-id
         :mime-version;
        bh=v2qblIOiEq3IV+Rw5HWdpUsMOXZ3HPIB/MKM16Vrm1A=;
        b=fwTohF+N5txaueZetr08UocKNsHSlc0pzESbB1F/y7wPIx38EW4abh69DjLIIjg/mK
         PU5/PAH62EX7TRCqSDP8SsNK5QMFUusTly5FVdavQPdaKxAMzKjYBMDAGreFR6ilv4x4
         Q9rSo5W3HuGDB4NIyUy4Zy9cXxhJnNXFdpWoE0dRh5GS0J/K7eqtjcrwyZq0CH6X+1Y0
         mIk+D/RxPlF8lPrxMUpcP798DAj0/aM/TM0peucKs2oabnmprSy/oo94jxdJiLKNHOgW
         GMSyJCSCHgyPxF2XER+hKCvjGlgXmLCvJq8G4/sS5aro8+uViOglPu+6dioavbEmSzZY
         9VEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:references:from:to:cc:subject:in-reply-to:date
         :message-id:mime-version;
        bh=v2qblIOiEq3IV+Rw5HWdpUsMOXZ3HPIB/MKM16Vrm1A=;
        b=tP1L5X1S1cs3B+CvPpZU9l89GbLpknmeh5/C04EWASwLt9FsSAQjLwu2fFHaAxAamG
         H8zG4ATpI3dobVHzId67YXjaIp9r4UYsvQ/XKSFtgBepcgcCcwUkKR9JN+4+18VhJ7Mm
         thYw/HVrj8lWXlZaStmJeX/WIuh4B3aZPRDSZD4X0uIFWSjJsQ1lWTEM7cqgCNkSYh+K
         I3RYCAVVcRnuv31lk+JTQOVXivAH9oKhge6Nr8u8yGaw0pwmYJNw8z3JWYHGWB+MBs/+
         y/0cJ7eewcQIahZz51hgUP12lofamdnrgkoImQfHT8rm4PbLmQ2auACgXSgzIxrrELsS
         hqzQ==
X-Gm-Message-State: AJIora8m7bpQ4jZbofQJBHjK8LWxHMYHrvXqImSAL/HRjgAdSXAApR/y
        /Dz3pgwteoK6hsCZbyBDXR8=
X-Google-Smtp-Source: AGRyM1seawZlN42pmJSLDQJ3ijOHsGsLAxYpv/JRO9LAGuWDU9AGN2HjpN9wo6nVNwoUmKfzn+8ozg==
X-Received: by 2002:a7b:cf2a:0:b0:39c:4eef:29e with SMTP id m10-20020a7bcf2a000000b0039c4eef029emr117762wmg.28.1655845434599;
        Tue, 21 Jun 2022 14:03:54 -0700 (PDT)
Received: from localhost (92.40.168.123.threembb.co.uk. [92.40.168.123])
        by smtp.gmail.com with ESMTPSA id w3-20020adfec43000000b0021b89c07b6asm11227967wrn.108.2022.06.21.14.03.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jun 2022 14:03:54 -0700 (PDT)
References: <20220620200644.1961936-1-aidanmacdonald.0x0@gmail.com>
 <YrH7JurP2LAl1uYU@sirena.org.uk>
From:   Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     agross@kernel.org, bjorn.andersson@linaro.org,
        srinivas.kandagatla@linaro.org, bgoswami@codeaurora.org,
        gregkh@linuxfoundation.org, rafael@kernel.org,
        cw00.choi@samsung.com, krzysztof.kozlowski@linaro.org,
        b.zolnierkie@samsung.com, myungjoo.ham@samsung.com,
        michael@walle.cc, linus.walleij@linaro.org, brgl@bgdev.pl,
        tglx@linutronix.de, maz@kernel.org, lee.jones@linaro.org,
        mani@kernel.org, cristian.ciocaltea@gmail.com, wens@csie.org,
        tharvey@gateworks.com, rjones@gateworks.com,
        mazziesaccount@gmail.com, orsonzhai@gmail.com,
        baolin.wang7@gmail.com, zhang.lyra@gmail.com,
        jernej.skrabec@gmail.com, samuel@sholland.org, lgirdwood@gmail.com,
        perex@perex.cz, tiwai@suse.com, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-actions@lists.infradead.org,
        linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        alsa-devel@alsa-project.org
Subject: Re: [PATCH 00/49] regmap-irq cleanups and refactoring
In-reply-to: <YrH7JurP2LAl1uYU@sirena.org.uk>
Date:   Tue, 21 Jun 2022 22:04:59 +0100
Message-ID: <oewDtaKXJJctSx2HcLTI4xuAmbzWo8Vb@localhost>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Mark Brown <broonie@kernel.org> writes:

> On Mon, Jun 20, 2022 at 09:05:55PM +0100, Aidan MacDonald wrote:
>
>> Here's a bunch of cleanups for regmap-irq focused on simplifying the API
>> and generalizing it a bit. It's broken up into three refactors, focusing
>> on one area at a time.
>
> This series is very large and the way it is interleaving patches for
> several different subsystems adds to the difficulty managing it.  As
> you've identified there's several different subserieses in here, if you
> need to resend any of this (I've not even started looking at the actual
> patches yet) it would be easier to digest with some combination of
> sending as separate serieses and reordering things so that all the
> things for each subsystem are grouped together.  That'd help with both
> review and with merging, both large serieses and cross subsystem
> dependencies tend to slow things down.

Thanks for the advice. After reading this and some of Andy's comments I
think I understand how to organize this better.

I'll send a trimmed down series including only regmap changes, and
instead of removing things right away I'll just mark them deprecated.
Then the driver patches can go by subsystem (one series per subsystem?)
and once everything is merged the deprecated stuff in regmap-irq can be
removed at a later date.
