Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4A1E56D717
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 09:51:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230223AbiGKHvn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 03:51:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229866AbiGKHvl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 03:51:41 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34A0D1B7A3
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 00:51:40 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id be14-20020a05600c1e8e00b003a04a458c54so2519008wmb.3
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 00:51:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=ztvaz5BdnKGZMhPHdfgEZYHb0hAaDWz8do9AwzsiSBg=;
        b=Hwn6nzpGX+T+LutaM8+KjYmqBSQV517VD113jCKqsTVABZpL3RajgVlzsBUtJOj6+w
         4MEC0eMoLndBf/WUzEJ7yzPiCK1SWNCKgIu1M9hYuXO5BmJkIGbetDA8FrXCbRB72Iv8
         cuGtRCIzhnji6qdtB8kjxdp0cHFvMmJ4n0mnOOT3LWt8AMxcvOZGxpsqvtuzWUCKuIMC
         fFdzRXrnV0BOKOs3upAtIl7HIPMA9dScmdkiB7B+/S49RiMn5in2NNk8xfF7F3HOHyiq
         5qfuoOVPIgj2+dKEiBbHEPrrp2a62s/B7gZFv9XINNIpZY787eCcGOnl4p2D5P4utq63
         3Hng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=ztvaz5BdnKGZMhPHdfgEZYHb0hAaDWz8do9AwzsiSBg=;
        b=7FOrDmnL7RgPmr/Zn9+t+arn9CIaRtVIaArzCN5YbmG3KwAOghX0GPFDKaH0iK2BWe
         SwlEogOGASLJkq2f5C/Ij4mYVAnmoqr7srhWNEwop762ewYJ3f0qAfyYBIiqoqzqifBC
         +1lLknDQMN27TqqR4j0zL4bO0a4f7ptbuTGznE3WcfEHdIr/CrQ/6KqH9536R/ED9hIa
         WrjkvfrxthvFFRQLIGd92aSzNXbEuRBoT6Hc4ROTOsZcj7Y08nqFdFLF3vT2BjIWLtLD
         fh5LQGuuDVVZ5CPEdD20i2auDgb39kUepk7+jXl6Wcr18+X8y/GdiR3FivzbPzSJiikB
         cjng==
X-Gm-Message-State: AJIora+RQZZEWXXVZ8Uz4EkkzsUXLC7msLa0f4ugkVsBwjK+vZcoYpi/
        GueJrO49fm3TGRe8bX0GPRM6pnmoQk9Cwg==
X-Google-Smtp-Source: AGRyM1t2LVG3w5w5knczU+KZudV327hkRGwLX8FTdhh12km7FALGEq592+7HTWIKyz30zF/nq6jpkw==
X-Received: by 2002:a05:600c:215a:b0:3a2:cf18:6dcc with SMTP id v26-20020a05600c215a00b003a2cf186dccmr14590732wml.53.1657525898761;
        Mon, 11 Jul 2022 00:51:38 -0700 (PDT)
Received: from google.com (cpc155339-bagu17-2-0-cust87.1-3.cable.virginm.net. [86.27.177.88])
        by smtp.gmail.com with ESMTPSA id j5-20020adff545000000b0021d864d4461sm5112097wrp.83.2022.07.11.00.51.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Jul 2022 00:51:38 -0700 (PDT)
Date:   Mon, 11 Jul 2022 08:51:35 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     Vladimir Oltean <vladimir.oltean@nxp.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Colin Foster <colin.foster@in-advantage.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-gpio@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andrew Lunn <andrew@lunn.ch>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Lars Povlsen <lars.povlsen@microchip.com>,
        Steen Hegelund <Steen.Hegelund@microchip.com>,
        UNGLinuxDriver@microchip.com, Wolfram Sang <wsa@kernel.org>,
        Terry Bowman <terry.bowman@amd.com>,
        katie.morris@in-advantage.com
Subject: Re: [PATCH v13 net-next 0/9] add support for VSC7512 control over SPI
Message-ID: <YsvWh8YJGeJNbQFB@google.com>
References: <20220705204743.3224692-1-colin.foster@in-advantage.com>
 <20220708200918.131c0950@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220708200918.131c0950@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 08 Jul 2022, Jakub Kicinski wrote:

> On Tue,  5 Jul 2022 13:47:34 -0700 Colin Foster wrote:
> > The patch set in general is to add support for the VSC7512, and
> > eventually the VSC7511, VSC7513 and VSC7514 devices controlled over
> > SPI. Specifically this patch set enables pinctrl, serial gpio expander
> > access, and control of an internal and an external MDIO bus.
> 
> Can this go into net-next if there are no more complains over the
> weekend? Anyone still planning to review?

As the subsystem with the fewest changes, I'm not sure why it would.

I'd planed to route this in via MFD and send out a pull-request for
other sub-system maintainers to pull from.

If you would like to co-ordinate it instead, you'd be welcome to.
However, I (and probably Linus) would need a succinct immutable branch
to pull from.

> Linus's ack on patch 6 and an MFD Ack from Lee would be great.

-- 
Lee Jones [李琼斯]
Principal Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
