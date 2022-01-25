Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9CC2749BED7
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 23:47:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234122AbiAYWrG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 17:47:06 -0500
Received: from vps0.lunn.ch ([185.16.172.187]:54076 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234071AbiAYWrE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 17:47:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
        Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
        bh=k9ztBqKotNbQORGVCT2yV1IoZPY2YsBdgTZyhwhHWaI=; b=s5+z/ky0lF06aNRAoie37oxf4b
        +UN0ENOaYGYd2VSlC7mAvBX5Z30YcH+xy4OmNCLCFWEU7PUiMyzm3obQRNaOD77bCbc+E3+5Xfjmz
        tH8wGQeNLxADNWRMl5ZbAmQbRkJzWbQ2Ff0VDEm/Ddajp6DeugRjIBp//n63Xn+vTXF4=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1nCUaM-002ilJ-Lp; Tue, 25 Jan 2022 23:46:46 +0100
Date:   Tue, 25 Jan 2022 23:46:46 +0100
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
Message-ID: <YfB91lWAtBgNLaGQ@lunn.ch>
References: <nick.hawkins@hpe.com>
 <20220125194609.32314-1-nick.hawkins@hpe.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220125194609.32314-1-nick.hawkins@hpe.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> +		umac0: umac@c0004000 {
> +			compatible = "hpe, gxp-umac";
> +			reg = <0xc0004000 0x80>;
> +			interrupts = <10>;
> +			interrupt-parent = <&vic0>;
> +			mac-address = [94 18 82 16 04 d8];
> +			phy-handle = <&ext_phy0>;
> +			int-phy-handle = <&int_phy0>;
> +		};

I suggest you don't add any DT for drivers which have not been
accepted yet. When you MAC driver is posted to netdev, the DT binding
will get reviewed. And i expect int-phy-handle will be rejected.

Often the first dtsi and dts submission for a new SoC have just the
CPUs and the serial port, since none of the other drivers have been
reviewed yet, unless they reuse existing drivers. The additional nodes
are then added one by one as the drivers get accepted.

	 Andrew
