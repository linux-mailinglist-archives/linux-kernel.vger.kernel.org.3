Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01AA156B479
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jul 2022 10:29:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237822AbiGHI2L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jul 2022 04:28:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237593AbiGHI2K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 04:28:10 -0400
Received: from ssl.serverraum.org (ssl.serverraum.org [176.9.125.105])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1F11814B9;
        Fri,  8 Jul 2022 01:28:07 -0700 (PDT)
Received: from mwalle01.kontron.local. (unknown [213.135.10.150])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id EE00A221D4;
        Fri,  8 Jul 2022 10:28:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1657268885;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ID/+qW4zs1m53ZSU7+O0Bo0ZHpvrpLWwIGXzC/NBmL0=;
        b=mpilrBbTo0R4ScG1a5DqNUsMa3Ui38t1xQi/Qso0boC3IBLQIi5uAQ8yvcUPuJohc+lHan
        y5MxV0Ezi3K89QGhN2X+axW7GvhN9ytHvG3C86T3iaomz9GmreBroxN9BbmDb2Lg7kr2tn
        PdR4EpQmU022RlzqdKHEUedPIgBtRK0=
From:   Michael Walle <michael@walle.cc>
To:     horatiu.vultur@microchip.com
Cc:     UNGLinuxDriver@microchip.com, alexandre.belloni@bootlin.com,
        colin.foster@in-advantage.com, kavyasree.kotagiri@microchip.com,
        linus.walleij@linaro.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, maxime.chevallier@bootlin.com,
        Michael Walle <michael@walle.cc>
Subject: Re: [PATCH 1/2] pinctrl: ocelot: Fix pincfg for lan966x
Date:   Fri,  8 Jul 2022 10:27:52 +0200
Message-Id: <20220708082752.1745233-1-michael@walle.cc>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220707185342.2697569-2-horatiu.vultur@microchip.com>
References: <20220707185342.2697569-2-horatiu.vultur@microchip.com>
MIME-Version: 1.0
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

> -static struct pinctrl_desc luton_desc = {
> -	.name = "luton-pinctrl",
> -	.pins = luton_pins,
> -	.npins = ARRAY_SIZE(luton_pins),
> -	.pctlops = &ocelot_pctl_ops,
> -	.pmxops = &ocelot_pmx_ops,
> -	.owner = THIS_MODULE,
> +static struct ocelot_match_data luton_desc = {
> +	{
.desc = {

Same for all the structs. Also it looks like it is way too big
for a stable backport:
 "It cannot be bigger than 100 lines, with context."

> +		.name = "luton-pinctrl",
> +		.pins = luton_pins,
> +		.npins = ARRAY_SIZE(luton_pins),
> +		.pctlops = &ocelot_pctl_ops,
> +		.pmxops = &ocelot_pmx_ops,
> +		.owner = THIS_MODULE,
> +	}
>  };

-michael
