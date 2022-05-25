Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF55F533DED
	for <lists+linux-kernel@lfdr.de>; Wed, 25 May 2022 15:35:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243834AbiEYNfM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 May 2022 09:35:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244458AbiEYNfK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 09:35:10 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22A045EBCC;
        Wed, 25 May 2022 06:35:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1653485709; x=1685021709;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=lPcr1Kl7mtugE4RnqH82rEuS7mbXO0sNIAN2KGPqVMo=;
  b=i/fOWTCu2/M3fMyD63v5sdDuw2pC+U3J0PZ/y/u0O0abU1hCJD3TJSEK
   fAceBIcgjXTDKpgr01wQ20C7YjrPfvb6LGQXINdo1+Wl3YFJJ/OANgYz2
   aF3JB6H9ppi/dC9z6xG/2ivFzN6MIZcx9XHpugxN9/hXXdS540jbk2SjU
   KP4b4BEY6IzFqFpBwxYI96yK15dpVcCykpCB/TjzkXI/cMMyx76AXOWnl
   b7O3zrHu97kd7exjs108l7jB7MGCCwF3faWabbZ+STjlCUdvvAnsLt6Y1
   6drtbEVgQzMim43o93x5fzfQFm4J4kTwvf/5Vi+sKlJgjMadd59FNQN8m
   w==;
X-IronPort-AV: E=Sophos;i="5.91,250,1647327600"; 
   d="scan'208";a="175023846"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 25 May 2022 06:35:08 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Wed, 25 May 2022 06:35:08 -0700
Received: from localhost.localdomain (10.10.115.15) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2375.17 via Frontend Transport; Wed, 25 May 2022 06:35:05 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <richard.genoud@gmail.com>, <gregkh@linuxfoundation.org>,
        <jirislaby@kernel.org>, <nicolas.ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>, <patrice.chotard@foss.st.com>
CC:     <linux-serial@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH 0/3] serial: atmel: cleanup code
Date:   Wed, 25 May 2022 16:37:30 +0300
Message-ID: <20220525133733.1051714-1-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

The following patches does some cleanup for atmel_serial driver by
switching to dev_pm_ops and improving clock management code. Along with
it I took the chance and introduced a patch for st-asc which removes the
include of pm_runtime.h.

Thank you,
Claudiu Beznea

Claudiu Beznea (3):
  tty: serial: atmel: stop using legacy pm ops
  tty: serial: atmel: improve clock management
  serial: st-asc: remove include of pm_runtime.h

 drivers/tty/serial/atmel_serial.c | 93 +++++++++----------------------
 drivers/tty/serial/st-asc.c       |  1 -
 2 files changed, 26 insertions(+), 68 deletions(-)

-- 
2.34.1

