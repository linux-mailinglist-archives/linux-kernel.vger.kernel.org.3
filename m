Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E117D4A942A
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 07:55:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344234AbiBDGzV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 01:55:21 -0500
Received: from out29-220.mail.aliyun.com ([115.124.29.220]:52808 "EHLO
        out29-220.mail.aliyun.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245393AbiBDGzU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 01:55:20 -0500
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.156788|-1;BR=01201311R111S40rulernew998_84748_2000303;CH=blue;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.018459-0.0059405-0.975601;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047211;MF=zhouyanjie@wanyeetech.com;NM=1;PH=DS;RN=5;RT=5;SR=0;TI=SMTPD_---.MlUck.P_1643957703;
Received: from zhouyanjie-virtual-machine.localdomain(mailfrom:zhouyanjie@wanyeetech.com fp:SMTPD_---.MlUck.P_1643957703)
          by smtp.aliyun-inc.com(10.147.43.95);
          Fri, 04 Feb 2022 14:55:18 +0800
From:   =?UTF-8?q?=E5=91=A8=E7=90=B0=E6=9D=B0=20=28Zhou=20Yanjie=29?= 
        <zhouyanjie@wanyeetech.com>
To:     daniel.lezcano@linaro.org, tglx@linutronix.de, robh+dt@kernel.org
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: [PATCH v3 0/3] Add SMP/SMT support for Ingenic sysost driver.
Date:   Fri,  4 Feb 2022 14:54:39 +0800
Message-Id: <1643957682-39450-1-git-send-email-zhouyanjie@wanyeetech.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

1.On the hardware of X2000 SoC, the OST has been split into
  two parts, two 32bit timers for clockevent and one 64bit
  timer for clocksource (with different addresses), so it
  not appropriate to use only one "ingenic,x2000-ost", just
  remove it, then introduce "ingenic,x2000-ost32" and
  "ingenic,x2000-ost64".
2.The OST in Ingenic XBurst®2 SoCs has a global timer and
  up to 16 event timers, add support for the event timers.
3.Add dt-bindings and compatible strings for the X1600 SoC,
  the X1830 SoC, the X2000 SoC, and the X2500 SoC.

周琰杰 (Zhou Yanjie) (3):
  dt-bindings: timer: Remove unreasonable binding.
  dt-bindings: timer: Add bindings for new Ingenic SoCs.
  clocksource: Ingenic: Add SMP/SMT support for sysost driver.

 .../devicetree/bindings/timer/ingenic,sysost.yaml  |   7 +-
 drivers/clocksource/ingenic-sysost.c               | 403 ++++++++++++++++-----
 2 files changed, 310 insertions(+), 100 deletions(-)

-- 
2.7.4

