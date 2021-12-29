Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F7D0481147
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Dec 2021 10:31:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235144AbhL2Ja6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Dec 2021 04:30:58 -0500
Received: from vps0.lunn.ch ([185.16.172.187]:44190 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232237AbhL2Ja5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Dec 2021 04:30:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
        Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
        bh=OmEP0vlBess7yf0G2D2gupKNnfHYjQqlkRVEW2GfamA=; b=wtKGvYFlIeFSNFKxxz/r3pTMw+
        cLH5t0E+MY8zwJRaluOoLMzSgsSLiEWtgtZ3z/kUawUjqTFo8sdJ6a6ZI6uQbI7a1tCdk1SoyJ16e
        BLQ7R28Xmg3dOZ22vWQSG2umq9lGI0Y/aioCuGSlWO2QTIAxzHxy8qfboDqjFa5VPBsE=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1n2VIM-0005sX-3W; Wed, 29 Dec 2021 10:30:54 +0100
Date:   Wed, 29 Dec 2021 10:30:54 +0100
From:   Andrew Lunn <andrew@lunn.ch>
To:     Colin Foster <colin.foster@in-advantage.com>
Cc:     linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Linus Walleij <linus.walleij@linaro.org>,
        UNGLinuxDriver@microchip.com,
        Steen Hegelund <Steen.Hegelund@microchip.com>,
        Lars Povlsen <lars.povlsen@microchip.com>
Subject: Re: [PATCH v1 pinctrl-next 0/1] add blink and activity functions to
 SGPIO
Message-ID: <YcwqznBTLZgNcU7o@lunn.ch>
References: <20211229003729.618079-1-colin.foster@in-advantage.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211229003729.618079-1-colin.foster@in-advantage.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 28, 2021 at 04:37:28PM -0800, Colin Foster wrote:
> Expose a debugfs / devicetree interface for Microsemi SGPIO controllers.
> By writing values of 2-5, the SGPIO pins can be configured for either
> automatic blinking or activity.
> 
> The implementation is modeled after the code in
> /drivers/pinctrl/pinctrl-ocelot.c.
> 
> I have only tested this with currently out-of-tree patches for the
> VSC7512 that I hope to get in soon. They are not needed for VSC7513 /
> VSC7514, SPARX5, or LUTON - but I don't have any hardware to test.
> 
> Of note: the 7512 chip has a discrepancy between the datasheet and the
> registers. The datahseet claims 20Hz blink default frequency, the
> registers claim 5 Hz default frequency for BMODE_0. I override the
> OCELOT registers to correct for this. I don't know if that is needed for
> LUTON or SPARX, but having two blink modes at the same frequency isn't
> beneficial. As such, I make the blink modes match the 5Hz / 20Hz for the
> two modes.
> 
> Tested with VSC7512 by way of:
> echo SGPIO_O_p1b0 {blink0,blink1,activity0,activity1} > 
> /sys/kernel/debug/pinctrl/pinctrl-sgpio-pinctrl-sgpio-output/pinmux-select

Hi Colin

Since this is an LED, you should be using the Linux LED interface in
/sys/class/leds. See Documentation/leds/leds-class.rst. It includes a
way to make an LED blink, using hardware.

Activity is another story. I assume you mean Ethernet frame Rx and Tx?
For that you should wait until the Ethernet LED offload code
eventually lands.

	   Andrew
