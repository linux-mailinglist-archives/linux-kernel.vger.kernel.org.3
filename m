Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B8604960DE
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jan 2022 15:30:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381132AbiAUOaQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jan 2022 09:30:16 -0500
Received: from lelv0142.ext.ti.com ([198.47.23.249]:51370 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381211AbiAUOaA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jan 2022 09:30:00 -0500
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 20LETtJN090898;
        Fri, 21 Jan 2022 08:29:55 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1642775395;
        bh=PQjUeYI6SZb55ZnWteQFG/YxDujWZZKX3/zsTbo6InI=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=l/NynUrRapNBNKD76r2iGaOPBdgN5arVhehw4sytWJTlLmMf9ORCTSWJY5ndEvzax
         OPW1ePw9bB2QeXztAG7PwJ330jwiJIUGF6sEcd2RsdQeVVLwcd0fmUBIfgzsQrI7gD
         8c97FCm372K3jslCl0XGcXlg9dP2/JORUaFWhakU=
Received: from DLEE109.ent.ti.com (dlee109.ent.ti.com [157.170.170.41])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 20LETtmw065261
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 21 Jan 2022 08:29:55 -0600
Received: from DLEE108.ent.ti.com (157.170.170.38) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Fri, 21
 Jan 2022 08:29:55 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Fri, 21 Jan 2022 08:29:55 -0600
Received: from pratyush-4F-325.dhcp.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 20LET4Hx072129;
        Fri, 21 Jan 2022 08:29:51 -0600
From:   Pratyush Yadav <p.yadav@ti.com>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>
CC:     Pratyush Yadav <p.yadav@ti.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Nikhil Devshatwar <nikhil.nd@ti.com>,
        Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
        Benoit Parrot <bparrot@ti.com>,
        Maxime Ripard <mripard@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        =?UTF-8?q?Niklas=20S=C3=B6derlund?= 
        <niklas.soderlund+renesas@ragnatech.se>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-media@vger.kernel.org>
Subject: [PATCH v6 12/14] media: dt-bindings: Make sure items in data-lanes are unique
Date:   Fri, 21 Jan 2022 19:59:02 +0530
Message-ID: <20220121142904.4091481-13-p.yadav@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220121142904.4091481-1-p.yadav@ti.com>
References: <20220121142904.4091481-1-p.yadav@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The data-lanes property maps the logical lane numbers to the physical
lane numbers. The position of an entry is the logical lane number and
its value is the physical lane number. Since one physical lane can only
map to one logical lane, no number in the list should repeat. Add the
uniqueItems constraint on the property to enforce this.

Signed-off-by: Pratyush Yadav <p.yadav@ti.com>
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Acked-by: Rob Herring <robh@kernel.org>

---

(no changes since v5)

Changes in v5:
- Add Laurent's R-by and Rob's Ack.

Changes in v4:
- New in v4.

 Documentation/devicetree/bindings/media/video-interfaces.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/media/video-interfaces.yaml b/Documentation/devicetree/bindings/media/video-interfaces.yaml
index 4391dce2caee..4bce93efae5f 100644
--- a/Documentation/devicetree/bindings/media/video-interfaces.yaml
+++ b/Documentation/devicetree/bindings/media/video-interfaces.yaml
@@ -158,6 +158,7 @@ properties:
     $ref: /schemas/types.yaml#/definitions/uint32-array
     minItems: 1
     maxItems: 8
+    uniqueItems: true
     items:
       # Assume up to 9 physical lane indices
       maximum: 8
-- 
2.34.1

