Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B202B47BE60
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Dec 2021 11:47:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234445AbhLUKrF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Dec 2021 05:47:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232364AbhLUKrE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 05:47:04 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77012C06173F
        for <linux-kernel@vger.kernel.org>; Tue, 21 Dec 2021 02:47:04 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1mzcel-0005B7-VS; Tue, 21 Dec 2021 11:46:08 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1mzceh-005nfr-LC; Tue, 21 Dec 2021 11:46:02 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1mzceg-0004BP-Dm; Tue, 21 Dec 2021 11:46:02 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Alexandre Torgue <alexandre.torgue@foss.st.com>,
        David Lechner <david@lechnology.com>,
        Fabrice Gasnier <fabrice.gasnier@foss.st.com>,
        Jarkko Nikula <jarkko.nikula@linux.intel.com>,
        Kamel Bouhara <kamel.bouhara@bootlin.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Oleksij Rempel <linux@rempel-privat.de>,
        Patrick Havelange <patrick.havelange@essensium.com>,
        Syed Nayyar Waris <syednwaris@gmail.com>,
        William Breathitt Gray <vilhelm.gray@gmail.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com
Subject: [PATCH 0/8] counter: Remove struct counter_device::priv
Date:   Tue, 21 Dec 2021 11:45:38 +0100
Message-Id: <20211221104546.214066-1-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

similar to patch
https://lore.kernel.org/r/4bde7cbd9e43a5909208102094444219d3154466.1640072891.git.vilhelm.gray@gmail.com
the usage of struct counter_device::priv can be replaced by
container_of which improves type safety and code size.

This series depends on above patch, converts the remaining drivers and
finally drops struct counter_device::priv.

This series was compile tested using ARCH=arm allmodconfig with the
following change:

 config 104_QUAD_8
        tristate "ACCES 104-QUAD-8 driver"
-       depends on PC104 && X86
+       depends on PC104 && X86 || COMPILE_TEST
        select ISA_BUS_API

in drivers/counter/Kconfig.

Best regards
Uwe

Uwe Kleine-König (8):
  counter: 104-quad-8: Use container_of instead of struct
    counter_device::priv
  counter: ftm-quaddec: Use container_of instead of struct
    counter_device::priv
  counter: intel-qeb: Use container_of instead of struct
    counter_device::priv
  counter: interrupt-cnt: Use container_of instead of struct
    counter_device::priv
  counter: microchip-tcp-capture: Use container_of instead of struct
    counter_device::priv
  counter: stm32-lptimer-cnt: Use container_of instead of struct
    counter_device::priv
  counter: stm32-timer-cnt: Use container_of instead of struct
    counter_device::priv
  counter: Remove unused member from struct counter_device

 drivers/counter/104-quad-8.c            | 64 +++++++++++++------------
 drivers/counter/ftm-quaddec.c           | 14 ++++--
 drivers/counter/intel-qep.c             | 24 ++++++----
 drivers/counter/interrupt-cnt.c         | 16 ++++---
 drivers/counter/microchip-tcb-capture.c | 18 ++++---
 drivers/counter/stm32-lptimer-cnt.c     | 24 ++++++----
 drivers/counter/stm32-timer-cnt.c       | 24 ++++++----
 drivers/counter/ti-eqep.c               |  1 -
 include/linux/counter.h                 |  3 --
 9 files changed, 106 insertions(+), 82 deletions(-)


base-commit: fa55b7dcdc43c1aa1ba12bca9d2dd4318c2a0dbf
prerequisite-patch-id: 9459ad8bc78190558df9123f8bebe28ca1c396ea
-- 
2.33.0

