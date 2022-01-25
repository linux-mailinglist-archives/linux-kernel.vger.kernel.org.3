Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1718049BE8E
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 23:32:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233873AbiAYWbn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 17:31:43 -0500
Received: from vps0.lunn.ch ([185.16.172.187]:54038 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233863AbiAYWbZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 17:31:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
        Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
        bh=GqNmRcbIdcR0lkfAVtnAna+7uu5s/9KhZCPTpg6gW2o=; b=eAYD8V1pKf5FniCp1ZOXlFPHYo
        T4qZh9jHM/326fW33sOnTFWI9W3uO7UWjCm/iy4gNq2oRLgByu8WCKD+sy88lKO9hJZpT617KGds8
        tHyi9iBqEllOS/LPoXWlthqgSKYysvcwMvJyfYgM8p/N8kSp89DKGVn6m1NFK78m2Ayk=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1nCUL5-002ifq-RF; Tue, 25 Jan 2022 23:30:59 +0100
Date:   Tue, 25 Jan 2022 23:30:59 +0100
From:   Andrew Lunn <andrew@lunn.ch>
To:     nick.hawkins@hpe.com
Cc:     verdun@hpe.com, Rob Herring <robh+dt@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Stanislav Jakubek <stano.jakubek@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Hao Fang <fanghao11@huawei.com>, Arnd Bergmann <arnd@arndb.de>,
        "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Mark Rutland <mark.rutland@arm.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] Adding architectural support for HPE's GXP BMC. This is
 the first of a series of patches to support HPE's BMC with Linux Kernel.
Message-ID: <YfB6I5PRPlHPxwLP@lunn.ch>
References: <nick.hawkins@hpe.com>
 <20220125194609.32314-1-nick.hawkins@hpe.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220125194609.32314-1-nick.hawkins@hpe.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> +		mdio0: mdio@c0004080 {
> +			compatible = "hpe,gxp-umac-mdio";
> +			reg = <0xc0004080 0x10>;
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			ext_phy0: ethernt-phy@0 {
> +				compatible = "ethernet-phy-ieee802.3-c22";

c22 is the default, so you don't strictly need this.

> +				phy-mode = "sgmii";
> +				reg = <0>;
> +			};
> +		};
> +
> +		mdio1: mdio@c0005080 {
> +			compatible = "hpe,gxp-umac-mdio";
> +			reg = <0xc0005080 0x10>;
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			int_phy0: ethernt-phy@0 {
> +				compatible = "ethernet-phy-ieee802.3-c22";
> +				phy-mode = "gmii";
> +				reg = <0>;
> +			};
> +			int_phy1: ethernt-phy@1 {
> +				compatible = "ethernet-phy-ieee802.3-c22";
> +				phy-mode = "gmii";
> +				reg = <1>;
> +			};
> +		};
> +
> +		umac0: umac@c0004000 {
> +			compatible = "hpe, gxp-umac";

A space in a compatible? 

> +			reg = <0xc0004000 0x80>;
> +			interrupts = <10>;
> +			interrupt-parent = <&vic0>;
> +			mac-address = [94 18 82 16 04 d8];

That is pretty unusual. Normally you leave the bootloader to fill this
in with a per board MAC address. The danger with listing it here is
that you have multiple boards in the same network using this MAC
address, and then bad things happen.

> +			phy-handle = <&ext_phy0>;
> +			int-phy-handle = <&int_phy0>;

Two phy-handles? Some very odd going on here!

> +		xreg_kyes: xreg_keys {
> +			compatible = "gpio-keys-polled";
> +			poll-interval = <100>;
> +
> +			IdButton {
> +				label = "ID Button";
> +				linux,code = <200>;

include/dt-bindings/input/linux-event-codes.h 

However

#define KEY_PLAYCD              200

A BMC has a CD player? Maybe i have this wrong?

> +			PortOwner@0 {
> +				label = "Port Owner";
> +				linux,code = <200>;
> +				gpios = <&gpio 250 1>;

Two CD players?

> +			};
> +
> +			PortOwner@1 {
> +				label = "Port Owner";
> +				linux,code = <201>;

#define KEY_PAUSECD             201

And you can pause the second player?

    Andrew
