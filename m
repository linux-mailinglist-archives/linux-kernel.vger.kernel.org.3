Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F055C54F6EC
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jun 2022 13:46:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381507AbiFQLqe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jun 2022 07:46:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234717AbiFQLqc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jun 2022 07:46:32 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82C4D6CF48;
        Fri, 17 Jun 2022 04:46:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1655466388; x=1687002388;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=rUrUGf34kDrDC4stey+5q/ue6Jew8NaeJPenPSRedGo=;
  b=bqhLXLBzBcHVSOtf24yrcKRxllQkeANzhs3BXfejsGjdjMowrhgNCZ/V
   +f63ZtdP4Mq3PAS5WMyKxFpAZFdQgofkNNWcRaxDA7MOukuTWnWbltVM/
   qighGjlYOoZUcHBFvuRVFfzvpzoB27rSVdZD84VsuwXtVm+rG+W3QenHT
   I9HPQXAC9kHtDXEku0kmcLXzAs9bm5Ad3F0+Pm+K3TLT0rNJItPRQ1JdE
   PdA7w2LW/clLdzbMuoSqx4L2koQZwAkGhCkFiNNPulp9CTHHR808M2o/q
   kVkH8sw+YN/RubP8PcIPtX+e2fYG/hiQTfMSmLIv2RaPw7t2hDOvF+ykp
   Q==;
X-IronPort-AV: E=Sophos;i="5.92,306,1650956400"; 
   d="scan'208";a="178383739"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 17 Jun 2022 04:46:27 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex02.mchp-main.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Fri, 17 Jun 2022 04:46:26 -0700
Received: from wendy.microchip.com (10.10.115.15) by chn-vm-ex02.mchp-main.com
 (10.10.85.144) with Microsoft SMTP Server id 15.1.2375.17 via Frontend
 Transport; Fri, 17 Jun 2022 04:46:24 -0700
From:   Conor Dooley <conor.dooley@microchip.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        "Lee Jones" <lee.jones@linaro.org>
CC:     Daire McNamara <daire.mcnamara@microchip.com>,
        <linux-kernel@vger.kernel.org>, <linux-pwm@vger.kernel.org>,
        <linux-riscv@lists.infradead.org>,
        Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH v3 0/2] Add support for Microchip's pwm fpga core
Date:   Fri, 17 Jun 2022 12:44:41 +0100
Message-ID: <20220617114442.998357-1-conor.dooley@microchip.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Uwe,
Got a ~v2~ v3 for you...
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

Changes from v2:
- fix percieved idempotency and rounding issues when shadow registers were
  enabled
- use do_div() for divide of u64 tmp in apply_period()

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
 drivers/pwm/pwm-microchip-core.c | 325 +++++++++++++++++++++++++++++++
 4 files changed, 337 insertions(+)
 create mode 100644 drivers/pwm/pwm-microchip-core.c


base-commit: 61114e734ccb804bc12561ab4020745e02c468c2
-- 
2.36.1

