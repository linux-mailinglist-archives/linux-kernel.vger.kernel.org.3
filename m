Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA3AB55890B
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 21:36:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230301AbiFWTei (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 15:34:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229789AbiFWTcR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 15:32:17 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E638D50;
        Thu, 23 Jun 2022 12:08:00 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id t24so609592lfr.4;
        Thu, 23 Jun 2022 12:08:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kcVKIksrL1T9nYsJOsA85D5uEfgk6mbUZ7YHZbbcbN4=;
        b=YLPURpU4e3oBJ33JI7xttyZBFe4Act4JNht8wrBLjKuBYBMcrppJKSi8AXi0XgLok0
         rIKC3DrIkcTVqA6Hr3F5LbPqMXbo04MRzQ4Ytfe7VYweJnThC1VIkbq2EBBBCWIj/PjJ
         g4zdjBq11kfQpWrRVseXGvsYxfo1L/fMeti4ZT7lpF2p2VykEl8GOrzExc3wvO/hAMr+
         vCJE7GFSd2OuPdl9lum4rjlVdVICVtp2mE+nxaAjZmYy84pJICtLdq5SD+OUYHwUhW0X
         xYw0vRwHL8vugBMW0b31rvxqrzoBVTE3128XPvUAKqyC9jP0hflcmMZRpzyQ0LbasQzY
         veeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kcVKIksrL1T9nYsJOsA85D5uEfgk6mbUZ7YHZbbcbN4=;
        b=4ZPVoxghmafawKbBTm860NqGkJJmZ4lA5ExnNm4hY1UR0oaaygFl2QT1/JGiAR9MdE
         Y/2l7zguArcs8O41l+FdMDanR3VEnapCM+xk1sHySgpOUl5vtGIXxBhM+tUB209jwO/t
         iDxSNPK9nH5nPRlnnAzutSHHV9TVkXu2Zgbtx4yRTiMMNQ04JTdvSIE92p/aMj9w1YK4
         4+O8XjujD4sOoMwR4X1JJCvYTqgLeuEwK35UL8CA5RyBXZQCssijt1/seq8W9DKhD9ZR
         3Diqg/6JcdQdwxAuyX2KSz133VNmwdcLAiUrqTRt2LkZ9IKgmCyW3aVuZxik7S8jFntH
         6T7Q==
X-Gm-Message-State: AJIora8EN8Eb2j1BFOjyLkTg00AvSf+7tPESZqiFwB3x6lfhuo9wVAPm
        d54iJEFivRUgcBvrE01VGbuyNGbnenICcrxVsts=
X-Google-Smtp-Source: AGRyM1srxBiZJnoeW2LP8XpRvRJZ8NqpI3EulE0sHB8fUpDhYoHJxxfLDe54HLUbME86mkm/rjSfaRteU/g8cM97fiE=
X-Received: by 2002:a05:6512:ea5:b0:47f:785c:7031 with SMTP id
 bi37-20020a0565120ea500b0047f785c7031mr6529346lfb.35.1656011278838; Thu, 23
 Jun 2022 12:07:58 -0700 (PDT)
MIME-Version: 1.0
References: <20220623170844.2189814-1-marcus.folkesson@gmail.com> <20220623170844.2189814-8-marcus.folkesson@gmail.com>
In-Reply-To: <20220623170844.2189814-8-marcus.folkesson@gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 23 Jun 2022 21:07:21 +0200
Message-ID: <CAHp75Vff8Avpxany=5j3e+4gmAAefJgDVX3riONN-=VLwj1HNQ@mail.gmail.com>
Subject: Re: [PATCH 08/10] iio: adc: mcp3911: add support for phase
To:     Marcus Folkesson <marcus.folkesson@gmail.com>
Cc:     Kent Gustavsson <kent@minoris.se>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
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

On Thu, Jun 23, 2022 at 7:42 PM Marcus Folkesson
<marcus.folkesson@gmail.com> wrote:
>
> The MCP3911 incorporates a phase delay generator,
> which ensures that the two ADCs are converting the
> inputs with a fixed delay between them.
> Expose it to userspace.

...

> +       case IIO_CHAN_INFO_PHASE:
> +               if (val2 != 0 || val > 0xfff) {

>= BIT(12) will show better the intention

> +                       ret = -EINVAL;
> +                       goto out;
> +               }

...

> +               ret = mcp3911_write(adc, MCP3911_REG_PHASE, val,
> +                                   2);

One line.

-- 
With Best Regards,
Andy Shevchenko
