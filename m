Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F4D4501BE4
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 21:27:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345464AbiDNT2W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 15:28:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236098AbiDNT2R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 15:28:17 -0400
Received: from out28-51.mail.aliyun.com (out28-51.mail.aliyun.com [115.124.28.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21A19E339D;
        Thu, 14 Apr 2022 12:25:50 -0700 (PDT)
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.4212315|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.00617324-0.000108877-0.993718;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047193;MF=zhouyanjie@wanyeetech.com;NM=1;PH=DS;RN=18;RT=18;SR=0;TI=SMTPD_---.NQo2NYZ_1649964338;
Received: from zhouyanjie-virtual-machine.localdomain(mailfrom:zhouyanjie@wanyeetech.com fp:SMTPD_---.NQo2NYZ_1649964338)
          by smtp.aliyun-inc.com(33.40.38.164);
          Fri, 15 Apr 2022 03:25:46 +0800
From:   =?UTF-8?q?=E5=91=A8=E7=90=B0=E6=9D=B0=20=28Zhou=20Yanjie=29?= 
        <zhouyanjie@wanyeetech.com>
To:     gregkh@linuxfoundation.org, hminas@synopsys.com,
        robh+dt@kernel.org, krzk+dt@kernel.org, tsbogend@alpha.franken.de,
        paul@crapouillou.net
Cc:     linux-usb@vger.kernel.org, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        dragancecavac@yahoo.com, hns@goldelico.com,
        dongsheng.qiu@ingenic.com, aric.pzqi@ingenic.com,
        rick.tyliu@ingenic.com, sernia.zhou@foxmail.com,
        zhenwenjin@gmail.com, reimu@sudomaker.com
Subject: [PATCH v3 0/3] Add OTG support for Ingenic SoCs.
Date:   Fri, 15 Apr 2022 03:25:34 +0800
Message-Id: <1649964337-114337-1-git-send-email-zhouyanjie@wanyeetech.com>
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

1.Add OTG support for the JZ4775 SoC, the JZ4780 SoC, the X1000
  SoC, the X1600 SoC, the X1700 SoC, the X1830 SoC, and the
  X2000 SoC.
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

周琰杰 (Zhou Yanjie) (3):
  dt-bindings: dwc2: Add bindings for new Ingenic SoCs.
  USB: dwc2: Add OTG support for Ingenic SoCs.
  MIPS: Ingenic: Refresh USB nodes to match driver changes.

 Documentation/devicetree/bindings/usb/dwc2.yaml |  7 ++++
 arch/mips/boot/dts/ingenic/jz4780.dtsi          |  2 +-
 arch/mips/boot/dts/ingenic/x1000.dtsi           |  2 +-
 arch/mips/boot/dts/ingenic/x1830.dtsi           |  2 +-
 drivers/usb/dwc2/core.c                         |  9 +++++
 drivers/usb/dwc2/core.h                         |  5 +++
 drivers/usb/dwc2/params.c                       | 50 ++++++++++++++++++++++++-
 7 files changed, 73 insertions(+), 4 deletions(-)

-- 
2.7.4

