Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0076B4C5E48
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Feb 2022 19:51:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231265AbiB0SwX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Feb 2022 13:52:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230214AbiB0SwW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Feb 2022 13:52:22 -0500
X-Greylist: delayed 62 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 27 Feb 2022 10:51:44 PST
Received: from fgw23-4.mail.saunalahti.fi (fgw23-4.mail.saunalahti.fi [62.142.5.110])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D91CC57B36
        for <linux-kernel@vger.kernel.org>; Sun, 27 Feb 2022 10:51:44 -0800 (PST)
Received: from darkstar.musicnaut.iki.fi (85-76-99-33-nat.elisa-mobile.fi [85.76.99.33])
        by fgw23.mail.saunalahti.fi (Halon) with ESMTP
        id 27a589b2-97fe-11ec-877a-005056bdfda7;
        Sun, 27 Feb 2022 20:50:38 +0200 (EET)
Date:   Sun, 27 Feb 2022 20:50:38 +0200
From:   Aaro Koskinen <aaro.koskinen@iki.fi>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Oleksij Rempel <o.rempel@pengutronix.de>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [BISECTED] input: ads7846: touchscreen broken on Nokia 770
Message-ID: <20220227185038.GA3016@darkstar.musicnaut.iki.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NEUTRAL,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I noticed touchscreen does not work anymore on Nokia 770:

[    2.131011] ads7846 spi2.0: touchscreen, irq 175
[    2.200622] input: ADS7846 Touchscreen as /devices/platform/omap_uwire/spi_master/spi2/spi2.0/input/input0

(then touching the screen:)

[   52.316894] ads7846 spi2.0: spi_sync --> -22
[   52.336944] ads7846 spi2.0: spi_sync --> -22

bisected this to:

commit 9c9509717b53e701469493a8d87ed42c7d782502
Author: Oleksij Rempel <o.rempel@pengutronix.de>
Date:   Wed Nov 11 16:39:05 2020 -0800

    Input: ads7846 - convert to full duplex

It seems it's failing on SPI_CONTROLLER_HALF_DUPLEX check in
__spi_validate(). The controller used on this board (spi-omap-uwire)
sets that flag. How ads7846 is now supposed to work in that case after
this conversion?

A.
