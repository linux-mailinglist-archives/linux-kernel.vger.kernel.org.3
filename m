Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 341F6565F50
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 00:02:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230347AbiGDWCu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 18:02:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229641AbiGDWCr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 18:02:47 -0400
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com [IPv6:2607:f8b0:4864:20::1135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1307659D;
        Mon,  4 Jul 2022 15:02:46 -0700 (PDT)
Received: by mail-yw1-x1135.google.com with SMTP id 00721157ae682-31c9b70c382so29921737b3.6;
        Mon, 04 Jul 2022 15:02:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kHQVO4IVI5Nu3mABfLxgUokHJ97BmMHW4sV/TPK2cTw=;
        b=aWZwkcSeOA3pdL40mhX5FSA7N+MbV/9hAo28GvjZROV4rInMfxJ1PDXkzFIyUTUldw
         sXFhAYu8UPi/Ydzn3/j4vNnyA2ueQrPktgeM7l9TTuG/noatim6EppTcghAbe7Cyqx2U
         /5XBC5OjmJaxlqSIg5QMvIeB4tcgpAOeP0s9L28oYhYC7CxyDd6EU/j8tf+Oe42J7rwn
         TI71tpHQkOQR7MBKpe/gQy8tppnp1OzjBVOTRG/xUND1J3kRc3reCkSlPYFQZBRryv2l
         UvVYl9/BCqlSgsWsQ+FmcgEaPSijO/Y/fDWZviHQS5jCjwptEJPFHTzI/jNpY6l81ndy
         7JLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kHQVO4IVI5Nu3mABfLxgUokHJ97BmMHW4sV/TPK2cTw=;
        b=QdYbL+UHU9ccX34w1aFazOaQiWU9NUAq4zLWVPq5YTGEsTIP+WwfqJYzWL3+f63x0C
         5cc+azI0Nb9J2l1O7Jg4RXKFMpC0Jir1z5U9XY7/FsO/VWhoMGBXIdw59a2NV+fJ+A8T
         AZVg4CDTWJjrqHwYSWRNwUOBQkL9ukz5Xfc1ivKG9DHowIh5cqTMRhqjEa39k3h4Ie0o
         SrOqkuVsBswD/KGko7I0RoxITPMn2f64/D5dB6dtHenXRcJ8aH9fOZmHg75Oe2pgdAja
         EDjSYlZ3NydyhNXKRH3v3IdFAmEinRx73ohJUFH0uXRnFfP/l44D2sQBIgohckPRp0l1
         qaCg==
X-Gm-Message-State: AJIora9IRCVBLlOCIOzGXoRkQ19LBCE1ljG+PUNe9plcG97UHzpINHrX
        +MOUwHwvE/ZsZJ7CIFlJkYfvTNPMCnpr6QbXyWo=
X-Google-Smtp-Source: AGRyM1vLAhrZPmbVotLc12HkkfgdkXrT+gFdFnjkgZ1T7U166VhzG0ZlJfBh9zuQ0ZS4d0fAob8nwJFY94OsBvbJ3PQ=
X-Received: by 2002:a81:8397:0:b0:31c:8a02:3f6d with SMTP id
 t145-20020a818397000000b0031c8a023f6dmr11368374ywf.486.1656972165995; Mon, 04
 Jul 2022 15:02:45 -0700 (PDT)
MIME-Version: 1.0
References: <20220704172116.195841-1-marcus.folkesson@gmail.com> <20220704172116.195841-10-marcus.folkesson@gmail.com>
In-Reply-To: <20220704172116.195841-10-marcus.folkesson@gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 5 Jul 2022 00:02:08 +0200
Message-ID: <CAHp75VdKLnM9v+c+dS=jta0rZwn4GLsJ-je8PWS9fsNhhC1ncA@mail.gmail.com>
Subject: Re: [PATCH v3 9/9] iio: adc: mcp3911: add support to set PGA
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

On Mon, Jul 4, 2022 at 7:23 PM Marcus Folkesson
<marcus.folkesson@gmail.com> wrote:
>
> Add support for setting the Programmable Gain Amplifiers by adjust the
> scale value.

...

> +#define MCP3911_GAIN_MASK(ch)          (0x7 << 3 * ch)

GENMASK()

...

> +       /*
> +        * For 24bit Conversion

24-bit

> +        * Raw = ((Voltage)/(Vref) * 2^23 * Gain * 1.5
> +        * Voltage = Raw * (Vref)/(2^23 * Gain * 1.5)
> +        *
> +        * ref = Reference voltage
> +        * div = (2^23 * 1.5 * gain) = 12582912 * gain
> +        */

...

> +       /* Set gain to a known value (1) */

What is '(1)'? In parentheses we usually refer to something like a
formula somewhere.

-- 
With Best Regards,
Andy Shevchenko
