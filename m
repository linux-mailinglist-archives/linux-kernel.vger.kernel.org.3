Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C31354E8955
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Mar 2022 20:32:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236259AbiC0Sd4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Mar 2022 14:33:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229529AbiC0Sdz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Mar 2022 14:33:55 -0400
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 993771A811;
        Sun, 27 Mar 2022 11:32:16 -0700 (PDT)
Received: by mail-qk1-x736.google.com with SMTP id 1so9866434qke.1;
        Sun, 27 Mar 2022 11:32:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=19uBF9iCIoMNrxoWIz9dMSdfhYfSKOAUfWryPoAUr/c=;
        b=Gje6NJsyJp7AHQqT8ZqvE+6dIuz3pv15I4EH5k6OsoU+u8gfU8rTssKRtwx1aJXBj1
         0aSvPogUKwd3anE2Qwp0SJQJXD1Q/DrTfufYwhPAU7wNL8+StG7Kr4/ZO46hZV8HmoIi
         zbhGm1yN/SOLjvVRFhHKef1ugLlgQNTDs7JhrNE8ynd8yH1Xdppwa/jQnpjVkJIALGKW
         ENpLg3SwSDyMW8otYwnsPwZT7ZlZToUIZfp7MZUHK1vprze3Mk1sY4i1Ll1lwuDSUdCv
         ZwM8i8rAEMAHbje9tk19AvBCzRjrOCwGu0/YbcNlxUprgloq6dF52KPdxWBbvtCeG3MR
         i28w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=19uBF9iCIoMNrxoWIz9dMSdfhYfSKOAUfWryPoAUr/c=;
        b=33RO0RSGYM7fDkWpxPc0cIwIsPLdnQFCBnn4s/ByqDbAOsYQZJcsJEo7/dBBRrvvaT
         pPtp/eOtthFEyK2ZvXAXZrww5ezH7cY62uA86FiA9kBFTMzXvzSMWCWsM2X6fgBDJPxF
         30A8xpML+xDN81ClMwtEMG4BBNMQM4VA5d5d0mtML8y9un3f0nrRqnNv4VO7KGznrqsR
         D/qsZcTtM52WN8Ca1DaX3iZuAbE0HJn14WIcxtikURuqIRpU2XpvCxuljJun+sy4KAG0
         jAt/iZVZMzoNJKZV0ZiAgQauiGIhzahvg9dnGb+U1f1IqNvU7KH+0+reB1jRhBr7ZF8w
         QocQ==
X-Gm-Message-State: AOAM530/Fh+mkQqbTzHbM/LQwk2P+lnh5jbuUfB+xsyK/g9/VG5apDgd
        TgCxsdZD0IqgXhegJ3K2l3U=
X-Google-Smtp-Source: ABdhPJxCaiO7jDnSjehUfjkz+hqrEdPwhVeKUAkTK7W6xw2jWYd/Z6bqyePBx1P3+qPV7N2hL4lZ1g==
X-Received: by 2002:a37:9dca:0:b0:67b:8dfb:6835 with SMTP id g193-20020a379dca000000b0067b8dfb6835mr12859531qke.638.1648405935727;
        Sun, 27 Mar 2022 11:32:15 -0700 (PDT)
Received: from localhost (pppoe-209-91-167-254.vianet.ca. [209.91.167.254])
        by smtp.gmail.com with ESMTPSA id q26-20020ae9e41a000000b0067d1a20872fsm6564613qkc.94.2022.03.27.11.32.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Mar 2022 11:32:15 -0700 (PDT)
Date:   Sun, 27 Mar 2022 14:32:13 -0400
From:   Trevor Woerner <twoerner@gmail.com>
To:     Vladimir Zapolskiy <vz@mleia.com>
Cc:     Robin Murphy <robin.murphy@arm.com>, Arnd Bergmann <arnd@arndb.de>,
        Kuldeep Singh <singh.kuldeep87k@gmail.com>,
        Olof Johansson <olof@lixom.net>, SoC Team <soc@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 3/3] ARM: dts: lpc32xx: Update spi clock properties
Message-ID: <20220327183213.GA36326@localhost>
References: <20220311093800.18778-4-singh.kuldeep87k@gmail.com>
 <4aae560d-d266-d0d0-136f-32891b15bc01@mleia.com>
 <CAK8P3a3a_WXbDKN-jJUt_Wuvop0rfaUs4ytwyhogOxdtJAPx0w@mail.gmail.com>
 <4f39f086-1932-1729-8761-d5c533356812@mleia.com>
 <dc599cae-7245-73dc-8050-14ec6c1336b8@arm.com>
 <f497fb65-3568-cda2-f086-2275b50daf4b@mleia.com>
 <faea4c0c-e20b-c043-6f74-95af8177e8bd@arm.com>
 <4a7e3d0e-f804-74a5-ef5b-206404eb9b61@mleia.com>
 <CAHUNapQMaBZ2-yJR10Qv+Pix9BA3AGSgjBaMBB9zJTTLLOGSkg@mail.gmail.com>
 <024f0d22-47d8-2d14-bed4-9f538a1537b3@mleia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <024f0d22-47d8-2d14-bed4-9f538a1537b3@mleia.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vladimir,

On Sun 2022-03-27 @ 07:27:00 PM, Vladimir Zapolskiy wrote:
> Hi Trevor,
> 
> On 3/27/22 5:57 AM, Trevor Woerner wrote:
> > On the lpc32xx both the SPI and SSP peripherals are APB devices (low-speed)
> > 
> > lpc32xx-apb-peripherals.png
> > The APB devices on this SoC are driven by the PERIPH_CLK which can be
> > derived from either the HCLK or the SYSCLK.
> 
> thank you for the data, I'd like to reference to Table 14, which says that
> both bus clock source and function clock source for SSP0 and SSP1 are a
> non-selectable HCLK. I'm unsure if for instance PERIPH_CLK can be set as
> a function clock source for SSPx.

Interesting. I see that I had assumed that all APB peripherals would be driven
by the PERIPH_CLK since the diagram shows that clock as going to all APB
peripherals.

In the SSP chapter, for example, there is a clock prescale register, which
says:

	This register controls the factor by which the prescaler divides the AHB clock
	HCLK to yield the prescaler clock that is, in turn, divided by the SCR factor
	in SSPnCR0, to determine the bit clock.

So that confirms that the clock driving the SSP (an APB peripheral) is the
AHB's HCLK!

Section 21.7 of the SPI chapter also clearly shows the SPI clock as being
derived from the HCLK as well.

Thanks for the clarification :-)

> > lpc32xx-clock.png
> > The default on reset is for PERIPH_CLK to be derived from the SYSCLK but
> > both U-Boot and Linux run in "normal" mode, which is to say that
> > PERIPH_CLK, HCLK, ARM_CLK, and DDRAM_CLK are derived from the HCLK PLL.>
> > There is no separate SSP clock, the SSP is driven by one clock: the
> > PERIPH_CLK (or "apb_pclk").
> 
> Right, there is no separate SSP clock in sense of a bus clock, it is
> correct to get HCLK clock (or equally its child SSP clock) rate as a bus
> clock rate, and the reason for introduction of SSP0/SSP1 clocks is that
> these clocks are gated.
> 
> If I'm correct above, what does it mean in connection to LPC32xx device
> tree bindings? The first or single clock source shall remain to be SSPx
> clock, either the former is "sspclk" or "apb_pclk".

Doesn't this mean the apb_pclk should not be specified as the SSP/SPI clock?
If sspclk is a synonym for HCLK, then sspclk and apb_pclk are completely
different clocks. On my device HCLK is 260MHz and PERIPH_CLK is 13MHz.
