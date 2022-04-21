Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AE2750A6D5
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 19:15:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1390643AbiDURSU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 13:18:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232229AbiDURSP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 13:18:15 -0400
Received: from out28-73.mail.aliyun.com (out28-73.mail.aliyun.com [115.124.28.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23A9DDFBB;
        Thu, 21 Apr 2022 10:15:22 -0700 (PDT)
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.4088587|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_regular_dialog|0.00781887-0.000144852-0.992036;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047213;MF=zhouyanjie@wanyeetech.com;NM=1;PH=DS;RN=16;RT=16;SR=0;TI=SMTPD_---.NVFIb-b_1650561308;
Received: from zhouyanjie-virtual-machine.localdomain(mailfrom:zhouyanjie@wanyeetech.com fp:SMTPD_---.NVFIb-b_1650561308)
          by smtp.aliyun-inc.com(33.40.31.76);
          Fri, 22 Apr 2022 01:15:18 +0800
From:   =?UTF-8?q?=E5=91=A8=E7=90=B0=E6=9D=B0=20=28Zhou=20Yanjie=29?= 
        <zhouyanjie@wanyeetech.com>
To:     gregkh@linuxfoundation.org, hminas@synopsys.com,
        robh+dt@kernel.org, krzk+dt@kernel.org, tsbogend@alpha.franken.de,
        paul@crapouillou.net
Cc:     linux-usb@vger.kernel.org, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        dongsheng.qiu@ingenic.com, aric.pzqi@ingenic.com,
        rick.tyliu@ingenic.com, sernia.zhou@foxmail.com,
        zhenwenjin@gmail.com, reimu@sudomaker.com
Subject: [PATCH v4 0/3] Add OTG support for Ingenic SoCs.
Date:   Fri, 22 Apr 2022 01:15:05 +0800
Message-Id: <1650561308-54704-1-git-send-email-zhouyanjie@wanyeetech.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

1.Add OTG support for the JZ4775 SoC, the JZ4780 SoC, the X1000
  SoC, the X1600 SoC, the X1830 SoC, and the X2000 SoC.
2.Introduce support for disable Ingenic overcurrent detection,
  once selected it enables GOTGCTL register bits VbvalidOvEn
  and VbvalidOvVal to disable the VBUS overcurrent detection.

v1->v2:
1.Add Rob Herring's Acked-by.
2.Add Minas Harutyunyan's Acked-by.
3.Use "activate_ingenic_overcurrent_detection" instead
  "deactivate_ingenic_overcurrent_detection" as Greg's suggestion.

v2->v3:
Refresh USB nodes in device tree files, remove "snps,dwc2" since
it is nolonger needed.

v3->v4:
Remove the compatible string of X1700 since it could use the X1600
string　as the fallback.

周琰杰 (Zhou Yanjie) (3):
  dt-bindings: dwc2: Add bindings for new Ingenic SoCs.
  USB: dwc2: Add OTG support for Ingenic SoCs.
  MIPS: Ingenic: Refresh USB nodes to match driver changes.

 Documentation/devicetree/bindings/usb/dwc2.yaml |  6 +++
 arch/mips/boot/dts/ingenic/jz4780.dtsi          |  2 +-
 arch/mips/boot/dts/ingenic/x1000.dtsi           |  2 +-
 arch/mips/boot/dts/ingenic/x1830.dtsi           |  2 +-
 drivers/usb/dwc2/core.c                         |  9 +++++
 drivers/usb/dwc2/core.h                         |  5 +++
 drivers/usb/dwc2/params.c                       | 49 ++++++++++++++++++++++++-
 7 files changed, 71 insertions(+), 4 deletions(-)

-- 
2.7.4

