Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 310814E54E1
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Mar 2022 16:07:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237757AbiCWPJJ convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 23 Mar 2022 11:09:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244993AbiCWPJF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Mar 2022 11:09:05 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB9407D03D
        for <linux-kernel@vger.kernel.org>; Wed, 23 Mar 2022 08:07:35 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1nX2a8-0004Yt-FC; Wed, 23 Mar 2022 16:07:28 +0100
Received: from [2a0a:edc0:0:900:1d::4e] (helo=lupine)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1nX2a4-002Vih-QY; Wed, 23 Mar 2022 16:07:27 +0100
Received: from pza by lupine with local (Exim 4.94.2)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1nX2a6-0007nK-BN; Wed, 23 Mar 2022 16:07:26 +0100
Message-ID: <d2d119b07cb51878904574ff14c8e4dd92c28907.camel@pengutronix.de>
Subject: Re: [PATCH 0/2] add fwnode support to reset subsystem
From:   Philipp Zabel <p.zabel@pengutronix.de>
To:     =?ISO-8859-1?Q?Cl=E9ment_L=E9ger?= <clement.leger@bootlin.com>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>
Cc:     Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Allan Nielsen <allan.nielsen@microchip.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Date:   Wed, 23 Mar 2022 16:07:26 +0100
In-Reply-To: <20220323095022.453708-1-clement.leger@bootlin.com>
References: <20220323095022.453708-1-clement.leger@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.38.3-1 
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: p.zabel@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Clément,

On Mi, 2022-03-23 at 10:50 +0100, Clément Léger wrote:
> This series is part of a larger series which aims at adding fwnode
> support in multiple subsystems [1]. The goal of this series was to
> add support for software node in various subsystem but in a first
> time only the fwnode support had gained consensus and will be added
> to multiple subsystems.

Could you explain the purpose of this a little? From the referenced
mail it looks like this would be intended allow to register reset
controllers via software node? Are there any real systems where this
would be useful?

> For the moment ACPI node support is excluded from the fwnode support
> to avoid creating an unspecified ACPI reset device description.

Are there any plans or ongoing discussions to specify such a
description in the future? Right now I'm only aware of the ACPI _RST
method as used by this patch:

[1] https://lore.kernel.org/all/20220307135626.16673-1-kyarlagadda@nvidia.com/

> One question raised by this series is that I'm not sure if all reset
> drivers should be modified to use the new fwnode support or keep the
> existing device-tree support. Maintainer advice on that particular
> question will be welcome.

I would prefer not to have to switch all those small DT-only reset
controller drivers all over the tree from of_node to fwnode.
On the other hand, I think it would be good to avoid the direct of_node
assignment, possibly by letting devm_reset_controller_register()
initialize of_node or fwnode from the device for most cases, and by
adding of_reset_controller_register() and
fwnode_reset_controller_register() variants that take the node as an
argument for the rest.
That could allow to eventually get rid of the of_node pointer.

For those drivers that provide their own .of_xlate, I'm not sure it
would make sense to force them to use .fwnode_xlate if they don't
already have a reason to use fwnode on their own.

regards
Philipp
