Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5B3B48FEF3
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Jan 2022 22:00:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236185AbiAPVAi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Jan 2022 16:00:38 -0500
Received: from h01mx15.reliablemail.org ([173.236.5.211]:52385 "EHLO
        h01mx15.reliablemail.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbiAPVAh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Jan 2022 16:00:37 -0500
X-Halon-Out: 35737b2c-770f-11ec-90dc-00163c81f1a9
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=grimler.se;
        s=default; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=9T6zg3rrA/r9nj19nKbG/q9IZ+uuAlzg6gpYvQoELgU=; b=Ol1hBgaTct3AHEq/h0MRERUQMf
        WtExaVZhadyU85sQiFyXYirwbsP/fvnJCOzLfQ7EJzSsxPudhlmml5EqsZaThU0u7YZtqptKwr6n9
        J8FYHHi03cFJ6WmiObgC/UedELTxO8yIrbDTd3tbJUk8s4NR32VfRLt4jGizj6sB6X7QxFIRuSNWe
        xOwRQG7wYyhc8Ol6YBoLx0aCdVZ+u5MABpGuOffqammWOz0UZ+rUbn+/5fNel+TacNbHV8UMhFsgw
        RBeyoMa9pILGPpRMf/kEMELuWjgdGvnidDENbhQDRYwG4XJaEuvRhC+S6+gLRvR1nAt1VaJEtsXMj
        4QMPZSeg==;
Date:   Sun, 16 Jan 2022 21:59:32 +0100
From:   Henrik Grimler <henrik@grimler.se>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     semen.protsenko@linaro.org, virag.david003@gmail.com,
        martin.juecker@gmail.com, cw00.choi@samsung.com,
        m.szyprowski@samsung.com, alim.akhtar@samsung.com,
        robh+dt@kernel.org, devicetree@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht
Subject: Re: [PATCH v3 3/3] ARM: dts: Add support for Samsung Chagall WiFi
Message-ID: <YeSHNCywXhp8gHC7@L14.lan>
References: <20220116165035.437274-1-henrik@grimler.se>
 <20220116165035.437274-4-henrik@grimler.se>
 <ca8c4613-a058-6cde-f9e6-8530f142a821@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ca8c4613-a058-6cde-f9e6-8530f142a821@canonical.com>
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - cpsrv07.misshosting.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - grimler.se
X-Get-Message-Sender-Via: cpsrv07.misshosting.com: authenticated_id: henrik@grimler.se
X-Authenticated-Sender: cpsrv07.misshosting.com: henrik@grimler.se
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof,

> > +/* External sdcard */
> > +&mmc_2 {
> > +	status = "okay";
> > +	bus-width = <4>;
> > +	cap-sd-highspeed;
> > +	card-detect-delay = <200>;
> > +	pinctrl-0 = <&sd2_clk &sd2_cmd &mmc2_cd &sd2_bus1 &sd2_bus4>;
> > +	pinctrl-names = "default";
> > +	samsung,dw-mshc-ciu-div = <3>;
> > +	samsung,dw-mshc-ddr-timing = <0 2>;
> > +	samsung,dw-mshc-sdr-timing = <0 4>;
> > +	sd-uhs-sdr50;
> > +	vmmc-supply = <&ldo19_reg>;
> > +	vqmmc-supply = <&ldo13_reg>;
> > +};
> > +
> > +&pinctrl_0 {
> > +	mmc2_cd: sd2-cd-pins {
> > +		samsung,pins = "gpx2-4";
> 
> Interesting... I looked at vendor sources to board-chagall and standard
> pin gpc2-2 is mentioned as PULL down and not-connected comment.
> 
> gpx2-4 seems not mentioned at all, unless other board files are actually
> used.

Gpio seems to be spread out. GPIO_T_FLASH_DETECT is defined as gpx2-4
in board-universal5420-mmc.c, and then used for card detection.
(Looking at it now again I see that write protection through sd2_wp
should also be supported for mmc_2, can add that in next patch set.)

> Anyway, if it works for you, it's good.
> 
> Rest looks ok, I'll apply after the merge window.

Thanks!

> Best regards,
> Krzysztof

Best regards,
Henrik Grimler
