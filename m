Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 952C0576392
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jul 2022 16:25:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230503AbiGOOZA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jul 2022 10:25:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231394AbiGOOY5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jul 2022 10:24:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B355D6C11C;
        Fri, 15 Jul 2022 07:24:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2671B619BA;
        Fri, 15 Jul 2022 14:24:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 023F4C34115;
        Fri, 15 Jul 2022 14:24:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1657895094;
        bh=gqsoRO92+mlK0ZwNvJsGoKnNnTCOYRtKI3/YidxBbgA=;
        h=From:To:Cc:Subject:Date:From;
        b=pWnBapWadb8KavruX98mihY0W9d4gGhIWwwBhQUThI3GIWNzhnmsujkRtyQEng2pN
         ZMpT6O1TOnGYC8NXyhr7fQu8qnvYNs3BkTkrp6FfsiYjlFPUkzqBclF8ASTP8PJXat
         p7GR2osWup7j2ocp/WKjZtbCPXhZDHW4yLdtnX08=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     johan@kernel.org
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Yan Xinyu <sdlyyxy@bupt.edu.cn>
Subject: [PATCH] USB: usb-serial-simple: add new device id for OPPO R11
Date:   Fri, 15 Jul 2022 16:24:44 +0200
Message-Id: <20220715142444.4173681-1-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1360; i=gregkh@linuxfoundation.org; h=from:subject; bh=gqsoRO92+mlK0ZwNvJsGoKnNnTCOYRtKI3/YidxBbgA=; b=owGbwMvMwCRo6H6F97bub03G02pJDEkXK5aus/rpLdgjOL9H9Jiv4bRXwcUGUv7cXyV+7112Ibcp ZKthRywLgyATg6yYIsuXbTxH91ccUvQytD0NM4eVCWQIAxenAExkdhzD/Ciuc7Iy/sZV6penqcrKJH 88suJlPcM82+csPNmlrwRCzAIWFE7arJD+4cZWAA==
X-Developer-Key: i=gregkh@linuxfoundation.org; a=openpgp; fpr=F4B60CC5BF78C2214A313DCB3147D40DDB2DFB29
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Oppo R11 diagnostic USB connection needs to be bound to the
usb-serial-simple driver as it just wants to use a dumb pipe to
communicate to the host.

usb-devices output:
 T: Bus=03 Lev=01 Prnt=01 Port=01 Cnt=01 Dev#= 10 Spd=480 MxCh= 0
 D: Ver= 2.00 Cls=00(>ifc ) Sub=00 Prot=00 MxPS=64 #Cfgs= 1
 P: Vendor=22d9 ProdID=276c Rev=04.04
 S: Manufacturer=OPPO
 S: Product=SDM660-MTP _SN:09C6BCA7
 S: SerialNumber=beb2c403
 C: #Ifs= 2 Cfg#= 1 Atr=80 MxPwr=500mA
 I: If#=0x0 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=ff Prot=30

Reported-by: Yan Xinyu <sdlyyxy@bupt.edu.cn>
Cc: Johan Hovold <johan@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/usb/serial/usb-serial-simple.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/serial/usb-serial-simple.c b/drivers/usb/serial/usb-serial-simple.c
index 4c6747889a19..eb832b94aa3a 100644
--- a/drivers/usb/serial/usb-serial-simple.c
+++ b/drivers/usb/serial/usb-serial-simple.c
@@ -60,7 +60,9 @@ DEVICE(flashloader, FLASHLOADER_IDS);
 	{ USB_VENDOR_AND_INTERFACE_INFO(0x18d1,			\
 					USB_CLASS_VENDOR_SPEC,	\
 					0x50,			\
-					0x01) }
+					0x01) },		\
+	{ USB_DEVICE_AND_INTERFACE_INFO(0x22d9, 0x276c,		\
+					0xff, 0xff, 0x30) }
 DEVICE(google, GOOGLE_IDS);
 
 /* Libtransistor USB console */
-- 
2.37.1

