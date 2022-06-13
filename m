Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2F7B548984
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 18:05:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359816AbiFMNQr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 09:16:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359302AbiFMNJr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 09:09:47 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 554DF28E06;
        Mon, 13 Jun 2022 04:20:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1655119203; x=1686655203;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=+Z7LwiQq63QPFqjyunT+jVzk6Ngr6unTuvtymNkZK5w=;
  b=BwOmVlLlT7k5TNs7jMUOTyPwLc5tdDeGjHhHgDoswAUc8W3cwEJfoM8w
   IdZj8+n53cAuyS3hbmUuUAGKQOz6FzL6AkQQjWxNoJmAPLNw/UtkOFtsg
   LuT2O2DzMLlzL/ko60/xFzI2Y6gvNrjSEB+vMDQLmVQDZnBSd57GQeY7l
   MsLqI+ses+XeT8bx2+efY3Ej3sslpxLnKBWk3rz4+q46wHEBWE/ZXufVx
   E33cdhMUB4Ea1hnQ7KzljIBaY0qG3iCub9uC4A4f9RLh/AWVcPYTJZjCb
   a2jHXoJvZNSRD1KmhQl0kKz0YXuENpVCd/ZPirJiSp6jzWo8eqvGNfhlK
   A==;
X-IronPort-AV: E=Sophos;i="5.91,297,1647327600"; 
   d="scan'208";a="163066291"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 13 Jun 2022 04:20:02 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Mon, 13 Jun 2022 04:20:01 -0700
Received: from wendy.microchip.com (10.10.115.15) by chn-vm-ex03.mchp-main.com
 (10.10.85.151) with Microsoft SMTP Server id 15.1.2375.17 via Frontend
 Transport; Mon, 13 Jun 2022 04:19:59 -0700
From:   Conor Dooley <conor.dooley@microchip.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        "Lee Jones" <lee.jones@linaro.org>
CC:     Daire McNamara <daire.mcnamara@microchip.com>,
        <linux-kernel@vger.kernel.org>, <linux-pwm@vger.kernel.org>,
        <linux-riscv@lists.infradead.org>,
        Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH v2 0/2] Add support for Microchip's pwm fpga core
Date:   Mon, 13 Jun 2022 12:17:58 +0100
Message-ID: <20220613111759.1550578-1-conor.dooley@microchip.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Uwe,
Got a v2 for you...
I added some comments explaining the calculations and a documentation link
so hopefully things are a bit easier to follow.

Code wise, I went through and sorted out a bunch of issues that cycling
through the different periods/duties threw up. Along the way I found
some other problems - especially with the longer periods which I have
fixed. I also added a write to the sync register in the apply function,
which will resolve to a NOP for channels without "shadow registers".

Other than that, I managed to ditch the mchp_core_pwm_registers struct
entirely but had to add a short delay before reading back the registers
in order to compute the duty.

Thanks,
Conor.

Changes from v1:
- account for edge "quirk" while inverted
- block changing enabled channels' period
- document the hardware/driver limitations
- rearrange get_state() more logically
- fix cast sizes in get_state()
- fix remove() and probe error paths
- delete mchp_core_pwm_registers
- simplify .apply() logic
- don't warn in calculate_base()
- fix period calculation
- fix duty cycle calculation
- add COREPWM prefix to defines
- add a documentation link

Conor Dooley (2):
  pwm: add microchip soft ip corePWM driver
  MAINTAINERS: add pwm to PolarFire SoC entry

 MAINTAINERS                      |   1 +
 drivers/pwm/Kconfig              |  10 +
 drivers/pwm/Makefile             |   1 +
 drivers/pwm/pwm-microchip-core.c | 310 +++++++++++++++++++++++++++++++
 4 files changed, 322 insertions(+)
 create mode 100644 drivers/pwm/pwm-microchip-core.c


base-commit: 61114e734ccb804bc12561ab4020745e02c468c2
-- 
2.36.1

