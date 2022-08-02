Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACDC7587A1A
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Aug 2022 11:53:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235945AbiHBJxU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Aug 2022 05:53:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232762AbiHBJxS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Aug 2022 05:53:18 -0400
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43AE215833;
        Tue,  2 Aug 2022 02:53:16 -0700 (PDT)
Received: (Authenticated sender: foss@0leil.net)
        by mail.gandi.net (Postfix) with ESMTPSA id 6151DFF811;
        Tue,  2 Aug 2022 09:53:13 +0000 (UTC)
From:   Quentin Schulz <foss+kernel@0leil.net>
Cc:     linus.walleij@linaro.org, heiko@sntech.de,
        linux-gpio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        Quentin Schulz <quentin.schulz@theobroma-systems.com>
Subject: [RFC PATCH 0/1] Making Rockchip IO domains dependency from other devices explicit
Date:   Tue,  2 Aug 2022 11:52:51 +0200
Message-Id: <20220802095252.2486591-1-foss+kernel@0leil.net>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Quentin Schulz <quentin.schulz@theobroma-systems.com>

This is a follow-up to the mail sent almost two months ago asking for
guidance: https://lore.kernel.org/lkml/778790a4-1239-e9d9-0549-6760a8792ceb@theobroma-systems.com/

This is what I could come up with but I'm not too happy about it so feel
free to give some ideas or other possible implementations that would
have less downsides than this one.

Some background on IO domains on Rockchip:

On some Rockchip SoCs, some SoC pins are split in what are called IO
domains.

An IO domain is supplied power externally, by regulators from a PMIC for
example. This external power supply is then used by the IO domain as
"supply" for the IO pins if they are outputs.

Each IO domain can configure which voltage the IO pins will be operating
on (1.8V or 3.3V).

There already exists an IO domain driver for Rockchip SoCs[1]. This
driver allows to explicit the relationship between the external power
supplies and IO domains[2]. This makes sure the regulators are enabled
by the Linux kernel so the IO domains are supplied with power and
correctly configured as per the supplied voltage.
This driver is a regulator consumer and does not offer any other
interface for device dependency.

However, IO pins belonging to an IO domain need to have this IO domain
correctly configured before they are being used otherwise they do not
operate correctly (in our case, a pin configured as output clock was
oscillating between 0 and 150mV instead of the expected 1V8).

In order to make this dependency transparent to the consumer of those
pins and not add Rockchip-specific code to third party drivers (a camera
driver in our case), it is hooked into the pinctrl driver which is
Rockchip-specific obviously.

Unfortunately, the dependency is not about the ultimate presence of the
io-domain devices but more that prior to being able to use pins,
the io-domain devices need to be probed. However of_find_device_by_node
does not provide this information, hence the check whether the
platform_device actually has its drvdata structure set (it defaults to
NULL until it is filled by the driver during the probe of the device).

Moreover, this dependency needs to be explicit on a pinmux level
and postponed after the probe of the pinctrl driver because a circular
dependency is observed otherwise with the following:
pinctrl device depends on the io-domain device which depends on
regulators from a PMIC on i2c which requires the i2c bus pins to be
muxed from the pinctrl device.
Instead, the pinmux dependency on IO domain is checked in set_mux
callback and returns EPROBE_DEFER if the IO domain device hasn't probed
yet.

I wanted to add the appropriate rockchip,io-domains DT property to
existing pinmux DT node. However, *all* of PX30's belong to an IO
domain, including the i2c bus on which the PMIC supplying the power to
the IO domain is on. Since the PMIC can be virtually on any i2c bus, a
specific pinmux cannot be omitted or ignored, therefore none are added
and it's up to the board maintainers to add them themselves. This is
also assumed only necessary for IO domain that are configured
differently by the bootloader or by register defaults (3V3 for
RK3399/PX30) than their expected values in Linux and whose supplied
power is fixed (e.g. not expected to be able to change from 3V3 to 1V8).

The hope is to not have to handle the io domain configuration in
the bootloader as it is currently done, c.f.
https://elixir.bootlin.com/u-boot/latest/source/board/theobroma-systems/puma_rk3399/puma-rk3399.c#L28
(we'll need an additional IO domain configuration for a camera soon).

However, this still relies on IO domains defaults or bootloader
configuration to be able to omit some IO domain<->pinmux relationships
to avoid circular dependencies.

I don't know how well this RFC implementation would work with
suspend/resume.

[1] drivers/soc/rockchip/io-domain.c
[2] Documentation/devicetree/bindings/power/rockchip-io-domain.yaml

Cheers,
Quentin

Quentin Schulz (1):
  pinctrl: rockchip: add support for per-pinmux io-domain dependency

 drivers/pinctrl/pinctrl-rockchip.c | 19 +++++++++++++++++++
 drivers/pinctrl/pinctrl-rockchip.h |  1 +
 2 files changed, 20 insertions(+)

-- 
2.37.1

