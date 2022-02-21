Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B235E4BDC6A
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Feb 2022 18:42:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354856AbiBUKcA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Feb 2022 05:32:00 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:45322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354834AbiBUKa2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 05:30:28 -0500
Received: from smtpout1.mo528.mail-out.ovh.net (smtpout1.mo528.mail-out.ovh.net [46.105.34.251])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 217D263EE;
        Mon, 21 Feb 2022 01:51:39 -0800 (PST)
Received: from pro2.mail.ovh.net (unknown [10.108.1.79])
        by mo528.mail-out.ovh.net (Postfix) with ESMTPS id CC381E72481C;
        Mon, 21 Feb 2022 10:51:09 +0100 (CET)
Received: from localhost.localdomain (88.125.132.78) by DAG1EX2.emp2.local
 (172.16.2.2) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Mon, 21 Feb
 2022 10:51:08 +0100
From:   Jean-Jacques Hiblot <jjhiblot@traphandler.com>
To:     <linux-renesas-soc@vger.kernel.org>, <geert+renesas@glider.be>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Magnus Damm <magnus.damm@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>
CC:     Jean-Jacques Hiblot <jjhiblot@traphandler.com>,
        <linux-watchdog@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v3 0/5] ARM: r9a06g032: add support for the watchdogs
Date:   Mon, 21 Feb 2022 10:50:26 +0100
Message-ID: <20220221095032.95054-1-jjhiblot@traphandler.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [88.125.132.78]
X-ClientProxiedBy: CAS3.emp2.local (172.16.1.3) To DAG1EX2.emp2.local
 (172.16.2.2)
X-Ovh-Tracer-Id: 6957217000239806939
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvvddrkeeigddtkecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffufffkofgggfgtihesthekredtredttdenucfhrhhomheplfgvrghnqdflrggtqhhuvghsucfjihgslhhothcuoehjjhhhihgslhhothesthhrrghphhgrnhgulhgvrhdrtghomheqnecuggftrfgrthhtvghrnhepjedugfffleelheehveevuedtjeffgfejkedukeekudfguedtfeefuefhueevheeinecuffhomhgrihhnpehgihhthhhusgdrtghomhenucfkpheptddrtddrtddrtddpkeekrdduvdehrddufedvrdejkeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhhouggvpehsmhhtphhouhhtpdhhvghlohepphhrohdvrdhmrghilhdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomhepjhhjhhhisghlohhtsehtrhgrphhhrghnughlvghrrdgtohhmpdhnsggprhgtphhtthhopedupdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
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

Changes v2 -> v3:
* dts: changed compatible strings to include "renesas,r9a06g032-wdt" and
  "renesas,rzn1-wdt".
* driver: removed the SOC-specific "renesas,r9a06g032-wdt".
* removed all the changes in the clock driver: the watchdog reset source
  are not disabled anymore when the machine is halted.
* fixed the clock rate type in the computations.
* removed unnecessary printout and call to clk_disable_unprepare() in the
  driver probe().
    
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

Jean-Jacques Hiblot (4):
  dt-bindings: clock: r9a06g032: Add the definition of the watchdog
    clock
  dt-bindings: watchdog: renesas,wdt: Add support for RZ/N1
  ARM: dts: r9a06g032: Add the watchdog nodes
  ARM: dts: r9a06g032-rzn1d400-db: Enable watchdog0 with a 60s timeout

Phil Edworthy (1):
  watchdog: Add Renesas RZ/N1 Watchdog driver

 .../bindings/watchdog/renesas,wdt.yaml        |   6 +
 arch/arm/boot/dts/r9a06g032-rzn1d400-db.dts   |   5 +
 arch/arm/boot/dts/r9a06g032.dtsi              |  16 ++
 drivers/watchdog/Kconfig                      |   8 +
 drivers/watchdog/Makefile                     |   1 +
 drivers/watchdog/rzn1_wdt.c                   | 206 ++++++++++++++++++
 include/dt-bindings/clock/r9a06g032-sysctrl.h |   1 +
 7 files changed, 243 insertions(+)
 create mode 100644 drivers/watchdog/rzn1_wdt.c

-- 
2.25.1

