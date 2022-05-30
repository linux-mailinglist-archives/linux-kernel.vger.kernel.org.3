Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C08E5387B8
	for <lists+linux-kernel@lfdr.de>; Mon, 30 May 2022 21:25:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241598AbiE3TZR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 May 2022 15:25:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233157AbiE3TZI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 May 2022 15:25:08 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AAB623BD7
        for <linux-kernel@vger.kernel.org>; Mon, 30 May 2022 12:25:07 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1nvl0h-0002B4-QC; Mon, 30 May 2022 21:25:04 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1nvl0h-005Vck-TK; Mon, 30 May 2022 21:25:02 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1nvl0f-00D9ro-LJ; Mon, 30 May 2022 21:25:01 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Lee Jones <lee.jones@linaro.org>, Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>
Cc:     linux-kernel@vger.kernel.org, kernel@pengutronix.de,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 0/4] mfd: Some preparations for making platform remove callbacks return void
Date:   Mon, 30 May 2022 21:24:26 +0200
Message-Id: <20220530192430.2108217-1-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1063; h=from:subject; bh=U/QRthux9LF8jDKLKaltbPOEZv+B1U5dPVIJlXbqa2Q=; b=owEBbQGS/pANAwAKAcH8FHityuwJAcsmYgBilRnLpBkEQiTxsbbdoM3kAM3kPTAuGR1Xk+U9RaXn r38B9tSJATMEAAEKAB0WIQR+cioWkBis/z50pAvB/BR4rcrsCQUCYpUZywAKCRDB/BR4rcrsCQ7MB/ 4s8QrIlDVI7ZTLgOcvdZ3EQ50IyGNgtBxtgMRAoPYpiHjeqmjrFYJATs5DuGC75xJBGmGl0uFSCtyj 8elT+y8cZyh4uvz7jw0m6rYiVruVk8nWtdT/4xcc9ry7u2VxisO+scjL6ZkWKqvBmRuJlDqBAZQ/pP rZJdiDLbezyxeOBLGAnw6LLWUpiYtUqPMFG8+3nZZg0oLjdIMhnFPR73Usa7/jYDtvsTrLFN22Vj6D 9gjPiC3LwXuKbQYQCIXkrLbgTXvWwHNAYrBw+Jo7Vcpi3GV1mjoiEhaC47/c0a4dAqNXgciSTwb3WW dhi2NvHTCgrzuh4HYVmr4nTqJT0Y/q
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

this is a collection of cleanups that prepare making platform device
remove callback return void.

Note there is an interdependency between patches #2 and #3 as
arch/arm/mach-pxa/eseries.c uses a single function as disable callback
for both tc6387xb and tc6393xb. (That might be a bug, I didn't check.)

Patch #2 might be stable material.

Best regards
Uwe

Uwe Kleine-König (4):
  mfd: asic3: Make asic3_gpio_remove() return void
  mfd: t7l66xb: Drop platform disable callback
  mfd: tc6387xb: Drop disable callback that is never called
  mfd: tc6393xb: Make disable callback return void

 arch/arm/mach-pxa/eseries.c  | 4 +---
 arch/arm/mach-pxa/tosa.c     | 4 +---
 drivers/mfd/asic3.c          | 9 +++------
 drivers/mfd/t7l66xb.c        | 6 +-----
 drivers/mfd/tc6393xb.c       | 5 ++---
 include/linux/mfd/t7l66xb.h  | 1 -
 include/linux/mfd/tc6387xb.h | 1 -
 include/linux/mfd/tc6393xb.h | 2 +-
 8 files changed, 9 insertions(+), 23 deletions(-)


base-commit: 4b0986a3613c92f4ec1bdc7f60ec66fea135991f
-- 
2.36.1

