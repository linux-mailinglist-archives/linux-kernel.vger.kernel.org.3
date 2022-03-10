Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C8C44D43DC
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Mar 2022 10:52:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240978AbiCJJxt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Mar 2022 04:53:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240974AbiCJJxe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 04:53:34 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30041DB;
        Thu, 10 Mar 2022 01:52:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1646905948; x=1678441948;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ktAuPeikT5yIzQagKaEvWRybAOSvIjqqN73SIJDSJFk=;
  b=srnfr7HSwAwdbUhe0ukwSZyn9IyEK6BmPLqRlCsTQyd26//6WTeeo+Cd
   HZzxFNQrwb75oc1kIB1En7HnYtQmUJEHkwoOtlYmgmI0nAHcpGVFQhnPD
   WRevQsf7xqZGmPb7u4qmIHC1daimGiyyB2Ywy31yq9iumhoJhXR2aTVBV
   JCLVpFwt6igPp/VRDn/gdx8iqOZuY8rtCd9+uUYpOEskqzhJmZyvj8rcC
   6bHwb2rhg8TbcVu13kW1/J97wMDKFBlTOJLQyqMY5dMZNHXFuVa545Stm
   in/zXUlLmWnS5te9YztZLSpeG6jC2uUdbIkjaUxGUILzVBNMpiCgJJytI
   Q==;
X-IronPort-AV: E=Sophos;i="5.90,170,1643698800"; 
   d="scan'208";a="148746115"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 10 Mar 2022 02:52:26 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Thu, 10 Mar 2022 02:52:25 -0700
Received: from ROB-ULT-M18282.microchip.com (10.10.115.15) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2375.17 via Frontend Transport; Thu, 10 Mar 2022 02:52:22 -0700
From:   Eugen Hristev <eugen.hristev@microchip.com>
To:     <linux-media@vger.kernel.org>, <jacopo@jmondi.org>
CC:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <claudiu.beznea@microchip.com>, <robh+dt@kernel.org>,
        <nicolas.ferre@microchip.com>,
        Eugen Hristev <eugen.hristev@microchip.com>,
        Hans Verkuil <hverkuil@xs4all.nl>
Subject: [PATCH v9 02/13] media: atmel: atmel-isc-base: replace is_streaming call in s_fmt_vid_cap
Date:   Thu, 10 Mar 2022 11:51:51 +0200
Message-ID: <20220310095202.2701399-3-eugen.hristev@microchip.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220310095202.2701399-1-eugen.hristev@microchip.com>
References: <20220310095202.2701399-1-eugen.hristev@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,T_SCC_BODY_TEXT_LINE,
        T_SPF_PERMERROR autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In s_fmt_vid_cap, we should check if vb2_is_busy and return EBUSY,
not check if it's streaming to return the busy state.

Suggested-by: Hans Verkuil <hverkuil@xs4all.nl>
Signed-off-by: Eugen Hristev <eugen.hristev@microchip.com>
Reviewed-by: Jacopo Mondi <jacopo@jmondi.org>
---
 drivers/media/platform/atmel/atmel-isc-base.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/platform/atmel/atmel-isc-base.c b/drivers/media/platform/atmel/atmel-isc-base.c
index d2cc6c99984f..67b4a2323fed 100644
--- a/drivers/media/platform/atmel/atmel-isc-base.c
+++ b/drivers/media/platform/atmel/atmel-isc-base.c
@@ -1029,7 +1029,7 @@ static int isc_s_fmt_vid_cap(struct file *file, void *priv,
 {
 	struct isc_device *isc = video_drvdata(file);
 
-	if (vb2_is_streaming(&isc->vb2_vidq))
+	if (vb2_is_busy(&isc->vb2_vidq))
 		return -EBUSY;
 
 	return isc_set_fmt(isc, f);
-- 
2.25.1

