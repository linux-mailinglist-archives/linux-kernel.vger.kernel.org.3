Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 814BD5731FE
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 11:04:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235941AbiGMJDs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 05:03:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230240AbiGMJDp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 05:03:45 -0400
Received: from ssl.serverraum.org (ssl.serverraum.org [176.9.125.105])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D8F36318
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 02:03:43 -0700 (PDT)
Received: from ssl.serverraum.org (web.serverraum.org [172.16.0.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id C0E502222E;
        Wed, 13 Jul 2022 11:03:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1657703021;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=P15uBo3f2QrJwHhK8GtuhBb2uMFkFJb88giYq9AhW0M=;
        b=dN3+EklkHR8WA9TcR3T4+93/c8Wqspgf+D0wlQE6gs0oowHNr03BOdSxRGV8cnpG2NXutI
        U8EK5oZiZFeRyssjts5pExR2m023d8KaM5fGCHxkhSCoDunFcJAsmBzs4arhTbWoYQQAwS
        H5OrNFTR0ctUIIJFJQ8BLwGFAYTatds=
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Date:   Wed, 13 Jul 2022 11:03:40 +0200
From:   Michael Walle <michael@walle.cc>
To:     Philipp Zabel <p.zabel@pengutronix.de>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Lars Povlsen <lars.povlsen@microchip.com>,
        Steen Hegelund <Steen.Hegelund@microchip.com>,
        =?UTF-8?Q?Cl=C3=A9ment_L=C3=A9ger?= <clement.leger@bootlin.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Kavyasree Kotagiri <kavyasree.kotagiri@microchip.com>
Subject: Re: [PATCH] Revert "reset: microchip-sparx5: allow building as a
 module"
In-Reply-To: <20220713084010.168720-1-p.zabel@pengutronix.de>
References: <20220713084010.168720-1-p.zabel@pengutronix.de>
User-Agent: Roundcube Webmail/1.4.13
Message-ID: <73dc6fcedebcae098751bd093fe2d028@walle.cc>
X-Sender: michael@walle.cc
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[+ Claudiu, Kavyasree ]
Am 2022-07-13 10:40, schrieb Philipp Zabel:
> This reverts commit b6b9585876da018bdde2d5f15d206a689c0d70f3.
> 
> This breaks MDIO on kswitch-d10, presumably because the global switch
> reset is not released early enough anymore.
> 
> Reported-by: Michael Walle <michael@walle.cc>
> Cc: Clément Léger <clement.leger@bootlin.com>
> Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>

Thanks!

Tested-by: Michael Walle <michael@walle.cc>

And maybe Microchip can chime in here and tell us what
subsystems in the SoC will actually be reset by this.
I fear this reset will affect almost every part of the
SoC. So it would have to be bound to every single
device? Or maybe adding that reset to the switch driver
was a mistake in the first place?

I mean, if it wouldn't be for the guard bit, it would
also reset the CPU core..

-michael
