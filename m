Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F32A5099FC
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 09:56:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1386278AbiDUH60 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 03:58:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1386275AbiDUH6X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 03:58:23 -0400
Received: from polaris.svanheule.net (polaris.svanheule.net [84.16.241.116])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D66314008
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 00:55:34 -0700 (PDT)
Received: from vanadium.ugent.be (vanadium.ugent.be [157.193.99.61])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sander@svanheule.net)
        by polaris.svanheule.net (Postfix) with ESMTPSA id 607DF2CA971;
        Thu, 21 Apr 2022 09:55:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svanheule.net;
        s=mail1707; t=1650527731;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZpQe7I0qfISQzBp6OdH99ET7LGqCNHIm5wpnvInHgbY=;
        b=17qULL0woLTgnaBxbCZJHpWHqL14Qg9TSsdXpEA9RTPIZUGVKHVrUChvS5inYxEzc5YcZ+
        1yvOa5rcaSWTzZZkOcqGQykfsBd4KXkd7FrQQbYE0HlRsk8yLKPlhwIP3vNtKxEWc0QMFH
        uexAXeHswH9HEWqMwtncc3T9WPwSuh6A6kjSBNcohchvqX995AGweWDIudKMzQBMENoZLp
        NigA+F1D33HF/+MWouFDwiIJMWl7KyDNjOp311hganFzXSIRO5pqqOL7uk4QEceomDkqrm
        XXtVOD0ow5eshtuESZgmdaffIl9S679BU21EhKw/Ms6dpb0ERvGwhyWWbjx1vg==
Message-ID: <0a48cd99805736d6a01573effa28f771fdbe9485.camel@svanheule.net>
Subject: Re: [PATCH v1 2/6] gpio: realtek-otto: Support reversed port layouts
From:   Sander Vanheule <sander@svanheule.net>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Bert Vermeulen <bert@biot.com>, linux-kernel@vger.kernel.org,
        andy.shevchenko@gmail.com
Date:   Thu, 21 Apr 2022 09:55:30 +0200
In-Reply-To: <CACRpkdYmKbHOZChSHjB-ykQCyCziwYTO_+Ai2vheo0y-vD_akA@mail.gmail.com>
References: <cover.1649533972.git.sander@svanheule.net>
         <7105ae382d7b328102f66b39ffd7c94998e85265.1649533972.git.sander@svanheule.net>
         <CACRpkdYmKbHOZChSHjB-ykQCyCziwYTO_+Ai2vheo0y-vD_akA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 (3.42.4-1.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

On Thu, 2022-04-21 at 01:01 +0200, Linus Walleij wrote:
> On Sat, Apr 9, 2022 at 9:56 PM Sander Vanheule <sander@svanheule.net> wrote:
> 
> > +       if (dev_flags & GPIO_PORTS_REVERSED) {
> > +               bgpio_flags = 0;
> > +               ctrl->port_offset_u8 = realtek_gpio_port_offset_u8_rev;
> > +               ctrl->port_offset_u16 = realtek_gpio_port_offset_u16_rev;
> > +       } else {
> > +               bgpio_flags = BGPIOF_BIG_ENDIAN_BYTE_ORDER;
> > +               ctrl->port_offset_u8 = realtek_gpio_port_offset_u8;
> > +               ctrl->port_offset_u16 = realtek_gpio_port_offset_u16;
> > +       }
> 
> Just checking: is this really a different silicon block, or is this
> GPIO_PORTS_REVERSED flag passed around just a way of saying:
> 
> if (!IS_ENABLED(CONFIG_CPU_BIG_ENDIAN)) ...?

The kernel for RTL930x SoC is built with CONFIG_CPU_BIG_ENDIAN=y, just like the
older SoCs that were previously supported. The SoC's IRQ controller is also the
same across RTL930x/RTL839x/RTL838x, even though 32-bit registers are used
there.

On RTL838x/RTL839x the GPIO IRQ control registers have byte layout:
	[H1] [L1] [H2] [L2]
	[H3] [L3] [H4] [L4]

On RTL930x, the GPIO IRQ control registers are:
	[H2] [L2] [H1] [L1]
	[H4] [L4] [H3] [L3]
which is the reverse of:
	[L1] [H1] [L2] [H2]
	[L3] [H3] [L4] [H4]


Same for the GPIO registers:
	On RTL83xx: [P1] [P2] [P3] [P4] (four 8b ports)
	On RTL930x: [P4] [P3] [P2] [P1] (one BE32 port)

It looks like the RTL930x could use a little-endian interpretation of the 32b
registers, followed by a little-endian interpretation of the contained port
values. That would mean two reorderings for every 16b read or write operation,
and manual manipulation of the register values. Although I have to say that the
current offset calculation is not too pretty either.

We also discussed this with Andy with the original submission of the driver:
https://lore.kernel.org/linux-gpio/CAHp75VdrqE0kBwzK9Jk7pZGjyfFnhatfa8UY0z-3T1w1PrbAbw@mail.gmail.com/

Best,
Sander
