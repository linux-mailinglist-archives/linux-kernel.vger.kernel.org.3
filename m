Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C68A501B63
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 20:53:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344973AbiDNSwk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 14:52:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237165AbiDNSwY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 14:52:24 -0400
Received: from out28-197.mail.aliyun.com (out28-197.mail.aliyun.com [115.124.28.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D1FD3D48A;
        Thu, 14 Apr 2022 11:49:41 -0700 (PDT)
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.1454297|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.0132996-0.00728371-0.979417;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047190;MF=zhouyanjie@wanyeetech.com;NM=1;PH=DS;RN=12;RT=12;SR=0;TI=SMTPD_---.NQnX3.j_1649962165;
Received: from zhouyanjie-virtual-machine.localdomain(mailfrom:zhouyanjie@wanyeetech.com fp:SMTPD_---.NQnX3.j_1649962165)
          by smtp.aliyun-inc.com(33.40.38.164);
          Fri, 15 Apr 2022 02:49:38 +0800
From:   =?UTF-8?q?=E5=91=A8=E7=90=B0=E6=9D=B0=20=28Zhou=20Yanjie=29?= 
        <zhouyanjie@wanyeetech.com>
To:     daniel.lezcano@linaro.org, tglx@linutronix.de, robh+dt@kernel.org,
        krzk+dt@kernel.org
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        dongsheng.qiu@ingenic.com, aric.pzqi@ingenic.com,
        rick.tyliu@ingenic.com, sernia.zhou@foxmail.com,
        zhenwenjin@gmail.com, reimu@sudomaker.com
Subject: [PATCH v5 0/3] Add SMP/SMT support for Ingenic sysost driver.
Date:   Fri, 15 Apr 2022 02:49:22 +0800
Message-Id: <1649962165-111806-1-git-send-email-zhouyanjie@wanyeetech.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
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
  the X1700 SoC, the X1830 SoC, the X2000 SoC, the X2500 SoC.

v4->v5:
Fix warnings reported-by: kernel test robot <lkp@intel.com>.

周琰杰 (Zhou Yanjie) (3):
  dt-bindings: timer: Remove unreasonable binding.
  dt-bindings: timer: Add bindings for new Ingenic SoCs.
  clocksource: Ingenic: Add SMP/SMT support for sysost driver.

 .../devicetree/bindings/timer/ingenic,sysost.yaml  |   8 +-
 drivers/clocksource/ingenic-sysost.c               | 405 ++++++++++++++++-----
 2 files changed, 313 insertions(+), 100 deletions(-)

-- 
2.7.4

