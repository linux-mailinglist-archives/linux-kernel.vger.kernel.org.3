Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1115C586D32
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Aug 2022 16:46:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232170AbiHAOqG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Aug 2022 10:46:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231317AbiHAOqE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 10:46:04 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBC1033A17
        for <linux-kernel@vger.kernel.org>; Mon,  1 Aug 2022 07:46:02 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id h205-20020a1c21d6000000b003a34ac64bdfso4442427wmh.1
        for <linux-kernel@vger.kernel.org>; Mon, 01 Aug 2022 07:46:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc;
        bh=FR8O4N8tNoaJYbvgZd1Cpg3goq3vbq55nVd9pbrgGqM=;
        b=f+MZQ6S5tIRuf0Ya6Y7XT4KGe2PUHJ+Hsfw3Holdb0ubXJn0zbi2Lu2mMu8hl+h7OU
         rWeaf3qm1lF12n0y6+5YVkqNgAa4W5ecoyldqaujoo1R2tslaXDmZuEDFxmaPFyM5ch2
         fjexgkIne7vvglvpA2HpUQlrEDkM9UMAigaepzLk0qQ45peanef+MZpJrqGNsebPszjj
         88FogTCKGPcWFqHbudBfbncCOlPz+2qGFRqARALnxvs7PonQ0XAX4L0II7c/ngtXQYna
         PYESr0ximyGqWMC8mDnUQk3PTdmYheB9j4C+RD3C1NYov0BpugEtphGESktj9YnkefY1
         l1bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc;
        bh=FR8O4N8tNoaJYbvgZd1Cpg3goq3vbq55nVd9pbrgGqM=;
        b=S97WZzxXxezn5O3aQgm6+39px4o9Tqmj7s0Ac6NBI0gIqrUr85MyzYkpcGUnM+n+fD
         KuKXbOiNb4fVYSLIp4GsX73JDX3vADJgArjuxbsmd+oKfwiGcUZJJFlzcDZO6gNpzqIm
         LAYPWeXQSj41GkXdUWCVCmLtvTy3JxdNq9COboeLjBOdhvCO9sYUuJe3t1NCa7fKkzNJ
         btsNQcO7tvSZCCotoguQAa5s4Gaf9sYFDxE5lUsekeRXe8kId8b6z3SqasSNN31vRGbp
         FI5khhxQd4pSb9v+v0rWS1SWOEv6MnwSc2SJ3fKwtPik70wy2q8lZCukCEmNN3WdR+Hm
         5Obg==
X-Gm-Message-State: AJIora/vuRN52xCbftjWWKdvG7sfxUrDdYMEpC/8vtOpDvYX+YvqhU59
        oqpuWU8yeuAt4fshLUw5M1aKkQ==
X-Google-Smtp-Source: AGRyM1u8gHMw1lYFRiuFnnSBpWToFrrSg1vfiT6fK9TJa4NYb2zmpKgJzOqRFCh9v5Mng8B93FWWzA==
X-Received: by 2002:a05:600c:4e86:b0:3a3:2edc:bcb4 with SMTP id f6-20020a05600c4e8600b003a32edcbcb4mr11850612wmq.85.1659365161500;
        Mon, 01 Aug 2022 07:46:01 -0700 (PDT)
Received: from google.com (cpc155339-bagu17-2-0-cust87.1-3.cable.virginm.net. [86.27.177.88])
        by smtp.gmail.com with ESMTPSA id n185-20020a1ca4c2000000b003a37b7e0780sm14888069wme.8.2022.08.01.07.45.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Aug 2022 07:46:00 -0700 (PDT)
Date:   Mon, 1 Aug 2022 15:45:57 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Colin Foster <colin.foster@in-advantage.com>
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        netdev <netdev@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Terry Bowman <terry.bowman@amd.com>,
        Vladimir Oltean <vladimir.oltean@nxp.com>,
        Wolfram Sang <wsa@kernel.org>,
        Microchip Linux Driver Support <UNGLinuxDriver@microchip.com>,
        Steen Hegelund <Steen.Hegelund@microchip.com>,
        Lars Povlsen <lars.povlsen@microchip.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        "David S. Miller" <davem@davemloft.net>,
        Russell King <linux@armlinux.org.uk>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        katie.morris@in-advantage.com, Lee Jones <lee@kernel.org>
Subject: Re: [PATCH v14 mfd 1/9] mfd: ocelot: add helper to get regmap from a
 resource
Message-ID: <YufnJXB5MOdFzOEy@google.com>
References: <20220722040609.91703-1-colin.foster@in-advantage.com>
 <20220722040609.91703-2-colin.foster@in-advantage.com>
 <CAHp75VdoBO8nKvGicsMhtY226AmL6nzt_52W+fLjeTkndwV7Aw@mail.gmail.com>
 <Yt665a77awMYDqrN@colin-ia-desktop>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Yt665a77awMYDqrN@colin-ia-desktop>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 25 Jul 2022, Colin Foster wrote:

> Hi Andy,
> 
> Great catches as always. Thank you.
> 
> I'll wait for Lee to take a look before blasting out another version.
> I'm still holding out hope for this upcoming merge window!

No chance. :)

Please submit the latest version.

-- 
Lee Jones [李琼斯]
Principal Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
