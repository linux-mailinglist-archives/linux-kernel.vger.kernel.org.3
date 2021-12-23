Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55B7447E82F
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Dec 2021 20:17:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350085AbhLWTRT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Dec 2021 14:17:19 -0500
Received: from lelv0143.ext.ti.com ([198.47.23.248]:48636 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350093AbhLWTRN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Dec 2021 14:17:13 -0500
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 1BNJH9G8031906;
        Thu, 23 Dec 2021 13:17:09 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1640287029;
        bh=1inwVu8SzK31tduM6kUze8nQHVa4UxiPGrg5o9Bzqnw=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=qm6DWgtMDA3IXgq8agvHDyJJguRuMX3RE9RdYF/vv06yRLrychPEJEqejVUxBBKov
         sx6HW6b2PWuV0+dQLi1RJfCDtt5HRybxhzTC6R23knNXylFmlurzpjg3KfU2dWsKI0
         8yaZNw0/4aNRI8kuqWER5fU1QILvfS5sc0Ph4kxg=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 1BNJH9n5007446
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 23 Dec 2021 13:17:09 -0600
Received: from DLEE108.ent.ti.com (157.170.170.38) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Thu, 23
 Dec 2021 13:17:08 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Thu, 23 Dec 2021 13:17:08 -0600
Received: from pratyush-OptiPlex-790.dhcp.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 1BNJGGQZ006164;
        Thu, 23 Dec 2021 13:17:05 -0600
From:   Pratyush Yadav <p.yadav@ti.com>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>
CC:     Pratyush Yadav <p.yadav@ti.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Nikhil Devshatwar <nikhil.nd@ti.com>,
        Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Benoit Parrot <bparrot@ti.com>,
        Maxime Ripard <mripard@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        =?UTF-8?q?Niklas=20S=C3=B6derlund?= 
        <niklas.soderlund+renesas@ragnatech.se>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-media@vger.kernel.org>
Subject: [PATCH v5 12/14] media: dt-bindings: Make sure items in data-lanes are unique
Date:   Fri, 24 Dec 2021 00:46:13 +0530
Message-ID: <20211223191615.17803-13-p.yadav@ti.com>
X-Mailer: git-send-email 2.33.1.835.ge9e5ba39a7
In-Reply-To: <20211223191615.17803-1-p.yadav@ti.com>
References: <20211223191615.17803-1-p.yadav@ti.com>
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
2.33.1.835.ge9e5ba39a7

