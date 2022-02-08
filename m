Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F2434AE0E5
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 19:35:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384987AbiBHSfk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 13:35:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237383AbiBHSfb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 13:35:31 -0500
Received: from smtpout1.mo3004.mail-out.ovh.net (smtpout1.mo3004.mail-out.ovh.net [79.137.123.219])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A91A2C061576;
        Tue,  8 Feb 2022 10:35:29 -0800 (PST)
Received: from pro2.mail.ovh.net (unknown [10.108.1.178])
        by mo3004.mail-out.ovh.net (Postfix) with ESMTPS id E50A7246E7F;
        Tue,  8 Feb 2022 18:35:27 +0000 (UTC)
Received: from localhost.localdomain (88.125.132.78) by DAG1EX2.emp2.local
 (172.16.2.2) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Tue, 8 Feb
 2022 19:35:26 +0100
From:   Jean-Jacques Hiblot <jjhiblot@traphandler.com>
To:     <linux-renesas-soc@vger.kernel.org>, <geert+renesas@glider.be>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Magnus Damm <magnus.damm@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>
CC:     Jean-Jacques Hiblot <jjhiblot@traphandler.com>,
        <linux-watchdog@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-clk@vger.kernel.org>
Subject: [PATCH v2 0/6] ARM: r9a06g032: add support for the watchdogs
Date:   Tue, 8 Feb 2022 19:35:04 +0100
Message-ID: <20220208183511.2925304-1-jjhiblot@traphandler.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [88.125.132.78]
X-ClientProxiedBy: DAG1EX1.emp2.local (172.16.2.1) To DAG1EX2.emp2.local
 (172.16.2.2)
X-Ovh-Tracer-Id: 13254093705174858197
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvvddrheejgdduudduucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufffkffoggfgtghisehtkeertdertddtnecuhfhrohhmpeflvggrnhdqlfgrtghquhgvshcujfhisghlohhtuceojhhjhhhisghlohhtsehtrhgrphhhrghnughlvghrrdgtohhmqeenucggtffrrghtthgvrhhnpeejudfgffelleehheevveeutdejfffgjeekudekkedugfeutdeffeeuhfeuveehieenucffohhmrghinhepghhithhhuhgsrdgtohhmnecukfhppedtrddtrddtrddtpdekkedruddvhedrudefvddrjeeknecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmohguvgepshhmthhpohhuthdphhgvlhhopehprhhovddrmhgrihhlrdhovhhhrdhnvghtpdhinhgvtheptddrtddrtddrtddpmhgrihhlfhhrohhmpehjjhhhihgslhhothesthhrrghphhgrnhgulhgvrhdrtghomhdpnhgspghrtghpthhtohepuddprhgtphhtthhopehlihhnuhigqdgtlhhksehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

This series adds support for the watchdog timers of the RZ/N1.
The watchdog driver (rzn1-wdt.c) is derived from the driver available at
https://github.com/renesas-rz/rzn1_linux.git with a few modifications

In order to be able to reset the board when a watchdog timer expires,
the RSTEN register must be configured. it is the responsability of the
bootloader to set those bits (or not, depending on the chosen policy).

If the watchdog reset source is not enabled, an interrupt is triggered
when the watchdog expires. Currently this interrupt doesn't much apart
from printing a message.

Changes v1 -> v2:
* Modified the clock driver to not enable the watchdog reset sources.
  On other renesas platforms, those bits are by the bootloader. The
  watchdog reset sources are still disabled when the platform is halted
  to prevent a watchdog reset.
* Added a SOC-specific compatible "renesas,r9a06g032-wdt"
* reordered the dts/i entries
* default timeout is 60 seconds
* reworked the probe function of the wdt driver to better error cases
* removed the set_timeout() and use a fixed period computed in probe().
  This removes the confusion and makes it clear that the period defined
  by the user space in indeed handled by the watchdog core

Jean-Jacques Hiblot (5):
  dt-bindings: clock: r9a06g032: Add the definition of the the watchdog
    clock
  dt-bindings: watchdog: renesas,wdt: Add support for RZ/N1
  ARM: dts: r9a06g032: Add the watchdog nodes
  ARM: dts: r9a06g032-rzn1d400-db: Enable watchdog0 with a 60s timeout
  clk: renesas: r9a06g032: Disable the watchdog reset sources when
    halting

Phil Edworthy (1):
  watchdog: Add Renesas RZ/N1 Watchdog driver

 .../bindings/watchdog/renesas,wdt.yaml        |   6 +
 arch/arm/boot/dts/r9a06g032-rzn1d400-db.dts   |   5 +
 arch/arm/boot/dts/r9a06g032.dtsi              |  16 ++
 drivers/clk/renesas/r9a06g032-clocks.c        |  30 +++
 drivers/watchdog/Kconfig                      |   8 +
 drivers/watchdog/Makefile                     |   1 +
 drivers/watchdog/rzn1_wdt.c                   | 208 ++++++++++++++++++
 include/dt-bindings/clock/r9a06g032-sysctrl.h |   1 +
 8 files changed, 275 insertions(+)
 create mode 100644 drivers/watchdog/rzn1_wdt.c

-- 
2.25.1

