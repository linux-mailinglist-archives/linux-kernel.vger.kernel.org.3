Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0B334FBF7A
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 16:46:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347447AbiDKOss (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 10:48:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229782AbiDKOsq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 10:48:46 -0400
Received: from ssl.serverraum.org (ssl.serverraum.org [IPv6:2a01:4f8:151:8464::1:2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 281751FCFD;
        Mon, 11 Apr 2022 07:46:31 -0700 (PDT)
Received: from apollo.. (unknown [IPv6:2a02:810b:4340:43bf:4685:ff:fe12:5967])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id DEA542223E;
        Mon, 11 Apr 2022 16:46:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1649688389;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+RSECJ+CEyfjPWT/tfdNYeMHsiQqq7qeZXL2Sxx3RMg=;
        b=b2Gv4nuR8HsYZyaaiYxiXBbclBKcL++tLeiPy2bZrup4of7iR+blbz96N+cjJqyeLX4Nqa
        aNaZwKademI++CiAskjbwa4xhAd7J8BerpzT/sLEPVmaPDdqg6z7AkRUNHN9x+Ih0VtXmy
        sj7pUIaK8w6yaZmpbsPr5VZVb64E5zc=
From:   Michael Walle <michael@walle.cc>
To:     kavyasree.kotagiri@microchip.com
Cc:     Claudiu.Beznea@microchip.com, Manohar.Puri@microchip.com,
        Nicolas.Ferre@microchip.com, Tudor.Ambarus@microchip.com,
        UNGLinuxDriver@microchip.com, alexandre.belloni@bootlin.com,
        broonie@kernel.org, devicetree@vger.kernel.org, krzk+dt@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org, robh+dt@kernel.org,
        Michael Walle <michael@walle.cc>
Subject: Re: [PATCH] spi: atmel,quadspi: Define lan966x QSPI
Date:   Mon, 11 Apr 2022 16:46:19 +0200
Message-Id: <20220411144619.101883-1-michael@walle.cc>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <CO1PR11MB48654DEFB31E8F8AB00C180292E99@CO1PR11MB4865.namprd11.prod.outlook.com>
References: <CO1PR11MB48654DEFB31E8F8AB00C180292E99@CO1PR11MB4865.namprd11.prod.outlook.com>
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

> > > LAN966x SoC supports 3 QSPI controllers. Each of them support
> > > data and clock frequency upto 100Mhz DDR and QUAD protocol.
> >
> > How is this IP different than microchip,sama7g5-qspi? Does this speed
> > limitation come from the IP itself or from the board that you're using?
> >
> > Neither of these instances support octal mode?
> >
> Thanks for your comments. All the three instances support only QUAD
> protocol.
> You are correct. There is no difference from sama7g5-qspi. Please ignore
> this patch. I will send next version of dt patches where I will use
> "microchip,sama7g5-qspi" for all my qspi nodes.

Are you sure? There is a max frequency property in Tudor's sama7g5-qspi
driver (200/133MHz) which doesn't match neither the LAN9668 manual (which
states 150MHz on QSPI0 and 100MHZ on QSPI1, funny enough there is no
mention of QSPI2) nor does it match the max frequency set in the downstream
linux driver (24 MHz).

-michael
