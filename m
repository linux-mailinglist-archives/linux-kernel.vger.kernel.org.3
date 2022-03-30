Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 038FC4EBE86
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 12:18:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245278AbiC3KUb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 06:20:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245282AbiC3KU0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 06:20:26 -0400
X-Greylist: delayed 581 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 30 Mar 2022 03:18:35 PDT
Received: from smtpout1.mo528.mail-out.ovh.net (smtpout1.mo528.mail-out.ovh.net [46.105.34.251])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6A5C1AE604;
        Wed, 30 Mar 2022 03:18:32 -0700 (PDT)
Received: from pro2.mail.ovh.net (unknown [10.109.156.52])
        by mo528.mail-out.ovh.net (Postfix) with ESMTPS id 0257AF291B06;
        Wed, 30 Mar 2022 12:08:48 +0200 (CEST)
Received: from localhost.localdomain (88.125.132.78) by DAG1EX2.emp2.local
 (172.16.2.2) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Wed, 30 Mar
 2022 12:08:48 +0200
From:   Jean-Jacques Hiblot <jjhiblot@traphandler.com>
To:     <wim@linux-watchdog.org>, <linux@roeck-us.net>,
        <geert+renesas@glider.be>, <linux-watchdog@vger.kernel.org>
CC:     <linux-renesas-soc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Jean-Jacques Hiblot <jjhiblot@traphandler.com>
Subject: [PATCH v4 0/2] ARM: r9a06g032: add support for the watchdogs
Date:   Wed, 30 Mar 2022 12:08:27 +0200
Message-ID: <20220330100829.1000679-1-jjhiblot@traphandler.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [88.125.132.78]
X-ClientProxiedBy: DAG3EX1.emp2.local (172.16.2.21) To DAG1EX2.emp2.local
 (172.16.2.2)
X-Ovh-Tracer-Id: 3184326415195060699
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: 0
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvvddrudeivddgvdehucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucenucfjughrpefhvffufffkofgggfgtihesthekredtredttdenucfhrhhomheplfgvrghnqdflrggtqhhuvghsucfjihgslhhothcuoehjjhhhihgslhhothesthhrrghphhgrnhgulhgvrhdrtghomheqnecuggftrfgrthhtvghrnhepjedugfffleelheehveevuedtjeffgfejkedukeekudfguedtfeefuefhueevheeinecuffhomhgrihhnpehgihhthhhusgdrtghomhenucfkpheptddrtddrtddrtddpkeekrdduvdehrddufedvrdejkeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhhouggvpehsmhhtphhouhhtpdhhvghlohepphhrohdvrdhmrghilhdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomhepjhhjhhhisghlohhtsehtrhgrphhhrghnughlvghrrdgtohhmpdhnsggprhgtphhtthhopedupdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
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
when the watchdog expires. The interrupt handler will trigger an
emergency restart.


Changes v3 -> v4:
 * dts: removed the patches that modify the device tree (already taken in
   the renesas dt tree)
 * driver: Call emergency_restart() in the interrupt handler.
 
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


Jean-Jacques Hiblot (1):
  dt-bindings: watchdog: renesas,wdt: Add support for RZ/N1

Phil Edworthy (1):
  watchdog: Add Renesas RZ/N1 Watchdog driver

 .../bindings/watchdog/renesas,wdt.yaml        |   6 +
 drivers/watchdog/Kconfig                      |   8 +
 drivers/watchdog/Makefile                     |   1 +
 drivers/watchdog/rzn1_wdt.c                   | 207 ++++++++++++++++++
 4 files changed, 222 insertions(+)
 create mode 100644 drivers/watchdog/rzn1_wdt.c

-- 
2.25.1

