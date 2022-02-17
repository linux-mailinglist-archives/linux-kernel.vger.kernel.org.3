Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 026174BA225
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 14:58:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241516AbiBQN6P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 08:58:15 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:52568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241508AbiBQN6N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 08:58:13 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B472E27AA3D;
        Thu, 17 Feb 2022 05:57:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1645106279; x=1676642279;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=krqpNlGU1PyCsmPAJWzacDtV9sBcV2Yf9rfYsyaElPs=;
  b=1h6dzferH76P6mJ9L+R5ec+93u8ZAiI5TK2uIQSZ3vMX/DAUS4evYdBZ
   AVJaNjmgnN0MaeSxVn4x21HvoHTH0f34W8WeLsus7atv8hDeuGzt7wM6c
   jIHCG6iNFnWhaGUC7ht9IyPejKZczRXXIH561RtpNKwOrwaIXKHe/Ztw/
   VpX5j6mgWJihYIjhDGaLIIkke/1haZ1Ol2lc/JzrFalk4GFaU5i1aEweG
   ekQORWsNwtMsWm7ycrMcwsNUY04YK7t/HzjZTNhS69Xv8h6D70HrmItfz
   5RpIq/rM4z9DwIqp0SjW6JZvBXHzDsvfnQcSUJVXoQmcESSCn7uAJq90K
   w==;
IronPort-SDR: gYTH9kugQOH1rISpRLFhtViMg24Ex7QEFg6i2IzA9ybnDdBsvduPkQZ9HpdcrKEH9yeVO61Dpj
 cL6mbLD4TBnk2A/pmN//O4gZZjn2xaxLMluuboa24zHPRY4lMxFWGgX8n7YXslpcBRj8ARDL4B
 z0C8sG+JQef47SDXPjqmypSUzs5Ghhip8P8AvybdED+XZvbFdOMkiIoEFDA18w2NMJsSEvC9ST
 ouFp/n+/TI9QHkqfWnY7SP/IZ6mFG5HEkC4y/nOMnBJ+37h/iev0oFmiB7qmAM1Isn7K3HxnOl
 Kx+mYLgMJOoiOYlY9kkrRGvE
X-IronPort-AV: E=Sophos;i="5.88,376,1635231600"; 
   d="scan'208";a="162631981"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 17 Feb 2022 06:57:58 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Thu, 17 Feb 2022 06:57:58 -0700
Received: from ROB-ULT-M18282.microchip.com (10.10.115.15) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2375.17 via Frontend Transport; Thu, 17 Feb 2022 06:57:37 -0700
From:   Eugen Hristev <eugen.hristev@microchip.com>
To:     <linux-media@vger.kernel.org>, <jacopo@jmondi.org>,
        <hverkuil-cisco@xs4all.nl>, <nicolas.ferre@microchip.com>
CC:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <claudiu.beznea@microchip.com>,
        "Eugen Hristev" <eugen.hristev@microchip.com>,
        Hans Verkuil <hverkuil@xs4all.nl>
Subject: [PATCH v5 02/13] media: atmel: atmel-isc-base: replace is_streaming call in s_fmt_vid_cap
Date:   Thu, 17 Feb 2022 15:56:34 +0200
Message-ID: <20220217135645.1427466-3-eugen.hristev@microchip.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220217135645.1427466-1-eugen.hristev@microchip.com>
References: <20220217135645.1427466-1-eugen.hristev@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In s_fmt_vid_cap, we should check if vb2_is_busy and return EBUSY,
not check if it's streaming to return the busy state.

Suggested-by: Hans Verkuil <hverkuil@xs4all.nl>
Signed-off-by: Eugen Hristev <eugen.hristev@microchip.com>
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

