Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24C5853F88D
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 10:48:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238526AbiFGIsd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 04:48:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238493AbiFGIr5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 04:47:57 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B527E338A4;
        Tue,  7 Jun 2022 01:47:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1654591653; x=1686127653;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=3CoKXSna6CTgje4u/qjkWGKm+Bb40J2h4l6CX9UJM+0=;
  b=cxkGW6tWbl+IR9mD8XmXKbWYo1/1cSl0QWZqjCUbHeLOVTUuX33hHmds
   gRAR4Zn/yRl4afVA7MvZXFr3ENptfRvwAT7rN8lGxtxFPOUZSZae6MYPX
   mXNA+qb4DgTaf7CGvNOLUBR5fnF936c/KwL38wIqk++eZLrXiE2DVyXLq
   a/Ar5qr8KrBIKBOzFjxo+NG3WB4ajv/0ZpHfE13KNfXhpCwRtjqGocjLr
   3xMNOGWa6I17mdf/AbG+ehPOKJ3kUzCFvhT6guGmtsTiv2sg4OEeZTJvL
   GudjLnR6TpkRsEMcOm0nXsgJEASgKnLUE9pxoQxa/3WauRUnklXK5noJo
   A==;
X-IronPort-AV: E=Sophos;i="5.91,283,1647327600"; 
   d="scan'208";a="167052009"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 07 Jun 2022 01:47:31 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Tue, 7 Jun 2022 01:47:29 -0700
Received: from wendy.microchip.com (10.10.115.15) by chn-vm-ex03.mchp-main.com
 (10.10.85.151) with Microsoft SMTP Server id 15.1.2375.17 via Frontend
 Transport; Tue, 7 Jun 2022 01:47:27 -0700
From:   Conor Dooley <conor.dooley@microchip.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        "Lee Jones" <lee.jones@linaro.org>
CC:     Daire McNamara <daire.mcnamara@microchip.com>,
        <linux-kernel@vger.kernel.org>, <linux-pwm@vger.kernel.org>,
        <linux-riscv@lists.infradead.org>,
        Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH 0/2] Add support for Microchip's pwm fpga core
Date:   Tue, 7 Jun 2022 09:45:50 +0100
Message-ID: <20220607084551.2735922-1-conor.dooley@microchip.com>
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

Hey all,
Small series here, adding a driver for the "soft" pwm IP core
for microchip FPGAs. The binding for them was already added
in 5.18.
Thanks,
Conor.

Conor Dooley (2):
  pwm: add microchip soft ip corePWM driver
  MAINTAINERS: add pwm to PolarFire SoC entry

 MAINTAINERS                      |   1 +
 drivers/pwm/Kconfig              |  10 ++
 drivers/pwm/Makefile             |   1 +
 drivers/pwm/pwm-microchip-core.c | 289 +++++++++++++++++++++++++++++++
 4 files changed, 301 insertions(+)
 create mode 100644 drivers/pwm/pwm-microchip-core.c

-- 
2.36.1

