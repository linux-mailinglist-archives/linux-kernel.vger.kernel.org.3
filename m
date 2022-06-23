Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C70855891B
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 21:36:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229544AbiFWTgE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 15:36:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231158AbiFWTfw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 15:35:52 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E8C46B8FB;
        Thu, 23 Jun 2022 12:20:42 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id b23so273930ljh.7;
        Thu, 23 Jun 2022 12:20:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uk7g0Aw/EDRHBj5LRpy9KD4B4NBBKvlJakN4LOD9oDw=;
        b=XmrpTDwJgogJyAc6MgFm9zgw5CTPEurzYo1zs575PeLPE6f4GG396CBGgQLOil7hqS
         fHLLXI/XanWBn4u0Hon7BiB8xXHkRVt8kHJ6lHYQw7FzIChqJt6YiZQZccs7+g/WixR6
         OdhyK8msgOAEK6fgMvTIs6HlbNLBn6lyK5KJ1LlxnpJPbEf7QdGyyrVmANqepCUm2bBp
         7K9NifoM/02+a9PPUde1kpdBwa9FVoQhHU6njcE0kD5ukne1feFQ2Npn+vyCxLZ4JVBp
         OUYqVPyyAzBlqExSQQeFyMzkSeXe4ndm7rEPDnkEY3aEel83PilzVuQkSoSspux/G1RZ
         GPow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uk7g0Aw/EDRHBj5LRpy9KD4B4NBBKvlJakN4LOD9oDw=;
        b=3rjw7ajOEfG4On1ZGIr8ba1dWEMsR6xWGMFR8ImlhysjDgWfHel8Im2bBMVLLhIbmg
         4GwW+fcANAeKLtg+9hXy/+e7iQd/gwgfJgFbZuHbrR1k6frGv6SEFF7H+/AQVRx7Aj6g
         gdoAeQYbRkcpydF52N+zbyAEGhFNSWExpv0MdBrn6vbttV10yfHkiyXw8ggQeL/OGy0O
         d1voD2ynk+45HIxlSk+iQtnmO6mki2Wg9thf37EC6GIxaX1SHaKw41FIG45bT4rnUe38
         c7mngKRtl+nQR5qgxt1xboOADr+HyA8SszIX9Gw2pnzGf/Y8tZFK+FfiwIPktu9uIAwA
         P2+Q==
X-Gm-Message-State: AJIora/iWIRkk064NZ9+hSO9XmwO20ZIvpUq4BJS/TcLAV1/A9XDGjY+
        UE38M0Ld8l13Fqa2oi9kWIqSFv3c2CdGIwk2cTI=
X-Google-Smtp-Source: AGRyM1tJWW+6956tJa3lm0LJW4qM7fqOh82M5ZyF44p3fdHpVdxSrqBF8LUisXNI6qHiKFgxJgcrfbt8cz9B77aJTLc=
X-Received: by 2002:a2e:5752:0:b0:25a:6cff:6b06 with SMTP id
 r18-20020a2e5752000000b0025a6cff6b06mr5547628ljd.435.1656012040981; Thu, 23
 Jun 2022 12:20:40 -0700 (PDT)
MIME-Version: 1.0
References: <20220623170844.2189814-1-marcus.folkesson@gmail.com> <20220623170844.2189814-6-marcus.folkesson@gmail.com>
In-Reply-To: <20220623170844.2189814-6-marcus.folkesson@gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 23 Jun 2022 21:20:01 +0200
Message-ID: <CAHp75Ve+gDa46MRhTR-5dOutGhXqakZbSX14TurwnsuT4OeuYQ@mail.gmail.com>
Subject: Re: [PATCH 06/10] iio: adc: mcp3911: add support for oversampling ratio
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

On Thu, Jun 23, 2022 at 9:08 PM Marcus Folkesson
<marcus.folkesson@gmail.com> wrote:
>
> The chip support oversampling ratio so expose it to userspace.

supports

ratio, so

...

> +static const int mcp3911_osr_table[] = {32, 64, 128, 256, 512, 1024, 2048, 4096};

Spaces inside {}.

...

>  }
>
> +

Unwanted blank line.

...

> +               switch (val) {
> +               case 4096:
> +                       val = FIELD_PREP(MCP3911_CONFIG_OSR, 0x07);
> +                       break;
> +               case 2048:
> +                       val = FIELD_PREP(MCP3911_CONFIG_OSR, 0x06);
> +                       break;
> +               case 1024:
> +                       val = FIELD_PREP(MCP3911_CONFIG_OSR, 0x05);
> +                       break;
> +               case 512:
> +                       val = FIELD_PREP(MCP3911_CONFIG_OSR, 0x04);
> +                       break;
> +               case 256:
> +                       val = FIELD_PREP(MCP3911_CONFIG_OSR, 0x03);
> +                       break;
> +               case 128:
> +                       val = FIELD_PREP(MCP3911_CONFIG_OSR, 0x02);
> +                       break;
> +               case 64:
> +                       val = FIELD_PREP(MCP3911_CONFIG_OSR, 0x01);
> +                       break;
> +               case 32:
> +                       val = FIELD_PREP(MCP3911_CONFIG_OSR, 0x00);
> +                       break;
> +               default:
> +                       ret = -EINVAL;
> +                       goto out;
> +               }

I understood why the table above, but this is a waste of resources.
Use that table

...

> +               ret = mcp3911_update(adc, MCP3911_REG_CONFIG,
> +                               MCP3911_CONFIG_OSR,
> +                               val, 2);

sizeof() ?

-- 
With Best Regards,
Andy Shevchenko
