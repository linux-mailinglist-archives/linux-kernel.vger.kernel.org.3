Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADE8C57FC76
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jul 2022 11:33:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233593AbiGYJc5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jul 2022 05:32:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229822AbiGYJcz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jul 2022 05:32:55 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5354716597;
        Mon, 25 Jul 2022 02:32:54 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id ez10so19359188ejc.13;
        Mon, 25 Jul 2022 02:32:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=H6BGHgFdbJL+XS6vYiSuVnkczhHrzWWLIlSkEvWwevA=;
        b=mRs5TGOr+9XVbblTmcGNpZIU6o5rQVIWK1UUQxpPQolkg3gs+G9PBv4TlqngSGX/OG
         FEXH7z75Doc/WOKaHYerbb4b5uYI2+1aZFSYZSrTcmnEsIsHK/yefGZ3ldKb3qpXVkG+
         wHLAXHD6QiJX/KjYwOA4/3fufcB6vDTr5Sr0sxecqcJqfWTLuV1FzlU+i7u8jtPl3G1J
         lb+hxLLE1UoCUGxOlPSUt4/QungXuZErJp2sVTDhO8gEwnP/IpI9JG37SbnMbrWgJ9vl
         yWXtDf81G4HH5EykcGYv/bq/cKM8ic/jbkb8EOPdRB7VBGXqgMaa5A7AVpQuUv9N7m4x
         syOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=H6BGHgFdbJL+XS6vYiSuVnkczhHrzWWLIlSkEvWwevA=;
        b=y4f+HVU9rS3yiv/4P+jJdeq+otHAZWrHGOkCB+jaiztcM/AovgpTKxw+0L28kbtci0
         J/6dbh5nfqzXIiEyI32us9hZoR6fmLc6wTB1uVbbXZaeQta1HyILAbetpODVLVjKov1D
         LXByvZGXlhaMb21gAWTRpOe1R/vHxXehfMtCXVgXs0epJqzxrWX7HjyCfyO3y2yaZ4S/
         UlJdH6qFKW+sAsjsYtUJ/H6dAOZkXeR1/tGPJPlPFVWxpG05spQL0//IlOh3f5jPdwzQ
         //MbV7GH4dTFge7XCIn6PozJvtkkLup/hiVkum1xhwWAN9p4Z6GA06jAqGASKXMDv7DF
         0ETA==
X-Gm-Message-State: AJIora8kZN58RN0vH8rabpr3rEG/nSUPE2MeVOzroZFcHz470CZiJXVy
        zKeq9qSgphufAKgCd45xtCe060dbGPBBvuLkEIo=
X-Google-Smtp-Source: AGRyM1upuXILnRF9inOFK/zwvHo6nwSOtefaRM0cJon/Yy9QW2JkAi33u9kQaXllspCcYYI1jV3F7lSFNAfq4ev8CvQ=
X-Received: by 2002:a17:907:a063:b0:72b:52f7:feea with SMTP id
 ia3-20020a170907a06300b0072b52f7feeamr9471309ejc.740.1658741572658; Mon, 25
 Jul 2022 02:32:52 -0700 (PDT)
MIME-Version: 1.0
References: <20220721093422.2173982-1-marcus.folkesson@gmail.com>
In-Reply-To: <20220721093422.2173982-1-marcus.folkesson@gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 25 Jul 2022 11:32:16 +0200
Message-ID: <CAHp75VddBhc9peHXfNfTyTNni246kC8CyLqCrMFadn67LGDarQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] gpio: gpio-74x164: add support for CDx4HC4094
To:     Marcus Folkesson <marcus.folkesson@gmail.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Maxime Ripard <mripard@kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
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

On Thu, Jul 21, 2022 at 11:32 AM Marcus Folkesson
<marcus.folkesson@gmail.com> wrote:
>
> 74hc4094 and 75hc4094 works similar to 74x164 but has an additional
> storage latch associated with each stage for strobing data from the
> serial input to parallell buffer tri-state output.

parallel

> Add support for an optional strobe pin.

Sorry for my absence of understanding, but why?
SPI has MOSI, CLK, CS, where the last one is exactly for that. No?


-- 
With Best Regards,
Andy Shevchenko
