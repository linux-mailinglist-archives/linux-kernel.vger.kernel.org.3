Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A364C59BA12
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 09:15:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233050AbiHVHOy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 03:14:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230289AbiHVHOv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 03:14:51 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBB441F2E0
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 00:14:50 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id w10so507724edc.3
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 00:14:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc;
        bh=L4C9jxDEHQJxeNb6tSjoDWUpW5OXjQBjDyyOgdCfm1c=;
        b=HDpf9UEUkLM+5q7kzurPq7l8YVBs2Gwncdlt1GECYz1eWZorNMAeFaFnahENaZwyFY
         18QtbkG2hpVzGZqil0J/u4IDUrBttXvTS+/GqOPCUsats9mqRRteaUrJWoPIjIjIv7aX
         Q8JnYhEUPii5uclxswYUCtlv2KGWXtnfPH5Rm5qPiKSeJQBiZ1no0bMudmDO6W8RMAuz
         E4hrIacq5HCEIw+9o/HrdNxJM5HkM8jr8BVXUrn7FmMLYDOGQoeZGwQUxfEvXIU6LrAi
         x3DDMuFpfH56yBR8kkRMv5PS2rdu2xqG1le13VIig9oVjs9dKho40gBpQfMA1MMVpvmE
         x3/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc;
        bh=L4C9jxDEHQJxeNb6tSjoDWUpW5OXjQBjDyyOgdCfm1c=;
        b=dl4Lk0A7ZYkOY0QNwe4XRE7zlvbfy0xiWxbHFdAaSxrOTxXLrpSY7W7S4ENaulSDmu
         uEpam7nwvtHn/p4dN4tkgXSCZPaEdfmHri8DxoN8rY3GtnqyoiucVq6S3OTQY5KnBz2X
         2wMuiRh0HAwTWleb7VO5iK8FHieY12FlkWgcqc0wAz6TQGFuUH8f5emVv9gX8Ula8yj2
         T8mKjnUcHEjpCXXDx12INk3BUmSJNyg37dU4x3xDPtDxQReqwkdksmptu+f0UauuJWQm
         eq7lXitwwOiZLTIvKm1gDj3v5jM7QJ+dd20sw7k+uD+zjXX5bVDHeSuV6OVK83wUtfMi
         3U/Q==
X-Gm-Message-State: ACgBeo3PVRMGuB8f5HexLvviFbG/5UFDACIY58aUMuvXIru1OFFIC2ui
        ZmSEPTX0dfMsoNZ7xcG32EDy6BefTCCpCS/JhlHRCw==
X-Google-Smtp-Source: AA6agR6uP2gNGTFa2fluxSVgHP2Yn6gtVn9sUtgJUHExaMImKcS0hip/QX/7i0dab1r6zmm25gurJY8lIHclJj9VIs4=
X-Received: by 2002:a05:6402:4312:b0:43d:b9c0:65ee with SMTP id
 m18-20020a056402431200b0043db9c065eemr15253416edc.205.1661152489457; Mon, 22
 Aug 2022 00:14:49 -0700 (PDT)
MIME-Version: 1.0
References: <20220728091712.13395-1-m.zatovic1@gmail.com>
In-Reply-To: <20220728091712.13395-1-m.zatovic1@gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 22 Aug 2022 09:14:38 +0200
Message-ID: <CACRpkdbD1qzJujhq-U0UN0tWam9CaoLvVuAQfafq4XNaEdZ2QA@mail.gmail.com>
Subject: Re: [PATCH RFC v1 1/2] bus: add Wiegand write-only GPIO driver
To:     =?UTF-8?B?TWFydGluIFphxaVvdmnEjQ==?= <m.zatovic1@gmail.com>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        mani@kernel.org, hemantk@codeaurora.org, elder@linaro.org,
        f.fainelli@gmail.com, Michael.Srba@seznam.cz,
        jeffrey.l.hugo@gmail.com, gregkh@linuxfoundation.org,
        bjorn.andersson@linaro.org, saravanak@google.com,
        krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Martin!

Thanks for your patch!

On Thu, Jul 28, 2022 at 11:17 AM Martin Za=C5=A5ovi=C4=8D <m.zatovic1@gmail=
.com> wrote:

> Wiegand is a communication protocol that is still widely used
> especially for access control applications. It utilizes two wires to
> transmit data - D0 and D1, the generic names of which are data-lo and
> data-hi.

So the driver provides Wiegand GPIO, if you want to provide
generic Wiegand infrastructure (for other things than GPIO
as well) then that should indeed be in drivers/bus.

However then you should provide an API for random WIegand
drivers, such as the now baked-in GPIO driver, so I think
what you want to achieve is:

1. A wiegand bus transport driver in drives/bus
2. A wiegand abstract API in include/linux/wiegand.h
3. A GPIO driver on top of the wiegand bus in
   drivers/gpio/wiegand-gpio.c that uses <linux/wiegand.h>

How does this sound?

I don't know how a wiegand device driver API would look
but there are several examples in other subsystems and
buses then the wiegand specifics need to be accounted for.

Yours,
Linus Walleij
