Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C8654A9CC7
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 17:18:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376456AbiBDQSU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 11:18:20 -0500
Received: from smtpout1.mo3004.mail-out.ovh.net ([79.137.123.219]:48897 "EHLO
        smtpout1.mo3004.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234695AbiBDQST (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 11:18:19 -0500
Received: from pro2.mail.ovh.net (unknown [10.109.143.120])
        by mo3004.mail-out.ovh.net (Postfix) with ESMTPS id D1098241C84;
        Fri,  4 Feb 2022 16:18:14 +0000 (UTC)
Received: from localhost.localdomain (88.125.132.78) by DAG1EX2.emp2.local
 (172.16.2.2) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Fri, 4 Feb
 2022 17:18:13 +0100
From:   Jean-Jacques Hiblot <jjhiblot@traphandler.com>
To:     <geert+renesas@glider.be>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Magnus Damm <magnus.damm@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>
CC:     Jean-Jacques Hiblot <jjhiblot@traphandler.com>,
        <linux-watchdog@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-renesas-soc@vger.kernel.org>, <linux-clk@vger.kernel.org>
Subject: [PATCH 0/6] ARM: r9a06g032: add support for the watchdogs
Date:   Fri, 4 Feb 2022 17:17:58 +0100
Message-ID: <20220204161806.3126321-1-jjhiblot@traphandler.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [88.125.132.78]
X-ClientProxiedBy: DAG2EX1.emp2.local (172.16.2.11) To DAG1EX2.emp2.local
 (172.16.2.2)
X-Ovh-Tracer-Id: 5892678638484994517
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvvddrgeelgdekjecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffufffkofgggfgtihesthekredtredttdenucfhrhhomheplfgvrghnqdflrggtqhhuvghsucfjihgslhhothcuoehjjhhhihgslhhothesthhrrghphhgrnhgulhgvrhdrtghomheqnecuggftrfgrthhtvghrnhepjedugfffleelheehveevuedtjeffgfejkedukeekudfguedtfeefuefhueevheeinecuffhomhgrihhnpehgihhthhhusgdrtghomhenucfkpheptddrtddrtddrtddpkeekrdduvdehrddufedvrdejkeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhhouggvpehsmhhtphhouhhtpdhhvghlohepphhrohdvrdhmrghilhdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomhepjhhjhhhisghlohhtsehtrhgrphhhrghnughlvghrrdgtohhmpdhnsggprhgtphhtthhopedupdhrtghpthhtoheplhhinhhugidqtghlkhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

This series adds support for the watchdog timers of the RZ/N1.
The watchdog driver (rzn1-wdt.c) is derived from the driver available at
https://github.com/renesas-rz/rzn1_linux.git with a few modifications
(devm watchdog API usage and WDIOF_MAGICCLOSE option)

In order to be able to reset the board when a watchdog timer expires,
the RSTEN register must be configured. This is done in the clock
driver of the r9a06g032. The rationnal is that this driver is the only one
that handles the sysctrl for this platform and there are a couple of other
clock drivers that also handle resets/reboot. I intend to later post
another patch to add software-triggered reboot capability that will
leverage this change.


Jean-Jacques Hiblot (5):
  clk: renesas: r9a06g032: Enable the watchdog reset sources
  dt-bindings: clock: r9a06g032: Add the definition of the watchdog
    clock
  dt-bindings: watchdog: renesas,wdt: Add support for RZ/N1
  ARM: dts: r9a06g032: Add the watchdog nodes
  ARM: dts: r9a06g032-rzn1d400-db: Enable watchdog0 with a 10s timeout

Phil Edworthy (1):
  watchdog: Add Renesas RZ/N1 Watchdog driver

 .../bindings/watchdog/renesas,wdt.yaml        |   4 +
 arch/arm/boot/dts/r9a06g032-rzn1d400-db.dts   |   5 +
 arch/arm/boot/dts/r9a06g032.dtsi              |  16 ++
 drivers/clk/renesas/r9a06g032-clocks.c        |  33 +++
 drivers/watchdog/Kconfig                      |   8 +
 drivers/watchdog/Makefile                     |   1 +
 drivers/watchdog/rzn1_wdt.c                   | 197 ++++++++++++++++++
 include/dt-bindings/clock/r9a06g032-sysctrl.h |   1 +
 8 files changed, 265 insertions(+)
 create mode 100644 drivers/watchdog/rzn1_wdt.c

-- 
2.25.1

