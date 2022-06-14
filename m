Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5B9354B31F
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 16:27:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235246AbiFNO13 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 10:27:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241845AbiFNO1Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 10:27:24 -0400
Received: from smtpout1.mo3004.mail-out.ovh.net (smtpout1.mo3004.mail-out.ovh.net [79.137.123.219])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 060DE17E34;
        Tue, 14 Jun 2022 07:27:22 -0700 (PDT)
Received: from pro2.mail.ovh.net (unknown [10.108.16.183])
        by mo3004.mail-out.ovh.net (Postfix) with ESMTPS id 6F5912456FF;
        Tue, 14 Jun 2022 14:27:21 +0000 (UTC)
Received: from localhost.localdomain (88.161.25.233) by DAG1EX2.emp2.local
 (172.16.2.2) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.9; Tue, 14 Jun
 2022 16:27:20 +0200
From:   Jean-Jacques Hiblot <jjhiblot@traphandler.com>
To:     <pavel@ucw.cz>, <krzk+dt@kernel.org>, <andy.shevchenko@gmail.com>
CC:     <robh+dt@kernel.org>, <linux-leds@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Jean-Jacques Hiblot <jjhiblot@traphandler.com>
Subject: [PATCH v4 0/3] Add support for the TLC5925
Date:   Tue, 14 Jun 2022 16:27:01 +0200
Message-ID: <20220614142704.155496-1-jjhiblot@traphandler.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [88.161.25.233]
X-ClientProxiedBy: CAS2.emp2.local (172.16.1.2) To DAG1EX2.emp2.local
 (172.16.2.2)
X-Ovh-Tracer-Id: 11153445955525491163
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: 0
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvfedrudduledgjeehucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucenucfjughrpefhvfevufffkffoggfgtghisehtkeertdertddtnecuhfhrohhmpeflvggrnhdqlfgrtghquhgvshcujfhisghlohhtuceojhhjhhhisghlohhtsehtrhgrphhhrghnughlvghrrdgtohhmqeenucggtffrrghtthgvrhhnpeejuefhkeelgffhlefhtefhgeektdevvdfgkeeltdehgeeujeeutdehkeeuhffftdenucfkpheptddrtddrtddrtddpkeekrdduiedurddvhedrvdeffeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhhouggvpehsmhhtphhouhhtpdhhvghlohepphhrohdvrdhmrghilhdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomhepjhhjhhhisghlohhtsehtrhgrphhhrghnughlvghrrdgtohhmpdhnsggprhgtphhtthhopedupdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdfovfetjfhoshhtpehmoheftddtge
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series add the support for the TLC5925 LED controller.
This LED controller is driven though SPI. There is little internal logic
and it can be thought of as a deserializer + latches.
The TLC5925 itself drives up to 16 LEDs, but multiple TLC5925s can be
chained to drive more.

The first patch describes the dt bindings.
The second patch implements most of the driver and supports only
synchronous brightness setting (brightness_set_blocking).
The last patch implements the non-blocking version (brightness_set).

changes v3->v4:
 * add missing MODULE_DEVICE_TABLE(of, ...) 
 * use dev_err_probe() to avoid spaming the log in case of deferred probe
 * use bitmap ops instead of direct mem access + lock
 * sort headers and a few other cosmetic changes.

changes v2->v3:
 * fixed the yaml description of the bindings (now passes dt_binding_check)
 * renamed shit-register-length into ti,shift-register-length and specify its
   type

changes v1->v2:
 * renamed property shift_register_length into shift-register-length
 * add a SPI MODULE_DEVICE_TABLE structure
 * fixed the yaml description of the bindings (now passes dt_binding_check)

Jean-Jacques Hiblot (3):
  dt-bindings: leds: Add bindings for the TLC5925 controller
  leds: Add driver for the TLC5925 LED controller
  leds: tlc5925: Add support for non blocking operations

 .../devicetree/bindings/leds/ti,tlc5925.yaml  | 107 ++++++++++
 drivers/leds/Kconfig                          |   6 +
 drivers/leds/Makefile                         |   1 +
 drivers/leds/leds-tlc5925.c                   | 191 ++++++++++++++++++
 4 files changed, 305 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/leds/ti,tlc5925.yaml
 create mode 100644 drivers/leds/leds-tlc5925.c

-- 
2.25.1

