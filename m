Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24F73571AA9
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 14:59:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231261AbiGLM66 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 08:58:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229825AbiGLM6u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 08:58:50 -0400
Received: from ssl.serverraum.org (ssl.serverraum.org [176.9.125.105])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7BC611464
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 05:58:48 -0700 (PDT)
Received: from mwalle01.kontron.local. (unknown [213.135.10.150])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 67F9E22239;
        Tue, 12 Jul 2022 14:58:41 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1657630725;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VZqhLjdPpWOouu/3k4mc94wd7HMgEDYWSUAOagKhAfA=;
        b=WhfUG+VrKPtkzj+587uoSh273/n60biqvNBx/XwN/dC8JF/YKcsPE2xPNq8gyHFBgC9tgm
        DlzRvxNS5ZMeWecDw7kfjy4ysPYKEiJCpm8bufzh1KQgas6QC/HIGZT2St/8bVCwm9jcJ3
        jF3pLAFt+EN4NjGS+8OihvpTVuwx0lw=
From:   Michael Walle <michael@walle.cc>
To:     p.zabel@pengutronix.de
Cc:     Steen.Hegelund@microchip.com, UNGLinuxDriver@microchip.com,
        allan.nielsen@microchip.com, clement.leger@bootlin.com,
        horatiu.vultur@microchip.com, lars.povlsen@microchip.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        thomas.petazzoni@bootlin.com, Michael Walle <michael@walle.cc>
Subject: Re: [PATCH] reset: microchip-sparx5: allow building as a module
Date:   Tue, 12 Jul 2022 14:58:36 +0200
Message-Id: <20220712125836.2676525-1-michael@walle.cc>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <99cba2d231c5971525ec976611e66f86259dd1e0.camel@pengutronix.de>
References: <99cba2d231c5971525ec976611e66f86259dd1e0.camel@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

> On Fr, 2022-06-17 at 12:37 +0200, Clément Léger wrote:
> > Set RESET_MCHP_SPARX5 as a tristate and add MODULE_DEVICE_TABLE() to
> > allow building this driver as a module.
> > 
> > Signed-off-by: Clément Léger <clement.leger@bootlin.com>
> 
> Thank you, applied to reset/next.

Unfortunately, this is breaking ethernet on my board
(lan966x-kontron-kswitch-d10-mmt-6g-2gs, see dts in arch/arm/).

I suspect this is because the postcore_initcall() was called earlier
in the kernel startup. Now, somehow the MDIO controller isn't working
anymore.

For a bit of a background, on the LAN9668 (I guess this is also true
on most other microchip switch platforms), there is a global switch
reset which is shared among most subsystems, i.e GPIO, SGPIO and
switch core. The switch driver will use this reset as there is no other
reset available (e.g. one which only reset the switching core). But when
it asserts the reset it will also reset other devices on the SoC. This
was for example the case for the GPIO, see commit 453200af8a85 ("pinctrl:
ocelot: add optional shared reset"). It seems like the MIIM is also
affected by this global reset, thus it needs the same fix.

I tried the obvious by adding the reset to the MIIM, but that didn't
help for all broken interfaces. I have to dig deeper into that.

In the meantime I'd appreciate it if this commit can be reverted until
the other fixes (at least the missing MIIM reset) will be merged.

-michael
