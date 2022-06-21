Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76E57553B5F
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 22:19:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354011AbiFUUTR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 16:19:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353829AbiFUUTQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 16:19:16 -0400
Received: from beige.elm.relay.mailchannels.net (beige.elm.relay.mailchannels.net [23.83.212.16])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAEC11CB00;
        Tue, 21 Jun 2022 13:19:14 -0700 (PDT)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id 17A7F121F84;
        Tue, 21 Jun 2022 20:13:04 +0000 (UTC)
Received: from pdx1-sub0-mail-a316.dreamhost.com (unknown [127.0.0.6])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id 4900D121B8E;
        Tue, 21 Jun 2022 20:13:03 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1655842383; a=rsa-sha256;
        cv=none;
        b=Ozh6Dejm/iaa6Ij+swIUcPUBaMm4B49OnIW2oDdHCambEKIa2/l8We1Vk+8T1qy1xJheNk
        kAJOuIOrBD18jKFPvB1qvkLp7WjQoutFR2IIJ5/+GETBrq+5vvBQUVYTJqwdX9aimvZ2CE
        lflsk+USygLlQ1/qC3dhNCtE2b7qpf/VdYnBu0lrF/C3l8oVSnF1IUbRgcAE0GgsKaf+6Q
        quASkrpGzZ+LZyiU+h0J1Vl40mdhyMPVNcDV62kA/lURU4iFuQ10xTH0EqfqtDAZuF4+d3
        KpFMCChgmrBFJHEvWgrAFxXJ3/ExcDv9WDW9vPm9dnjCfL9TRAruFJw0LVMpWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1655842383;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:dkim-signature;
        bh=8KPyrK4qTJmhET6C28NIGcqXGbT/X/diSCKe69qw4NE=;
        b=V+QYC5r2rUOBVtq8UUrospbNm1NUtUTJheLOnjzbG7/Dj60krRMjZPzZ80O1bfxYHBfCoN
        w/iHFkan7IGpuJxUA2mXsZMeSHof/dY7bRfQyHwEkQ3cXxUvhUmJ6j1SbFoH8fDa/wR1R9
        ob9q0KBzEBSsMKp3Pke7tnTU8/kYLW2lWDvoNzUFDsiyEa2v1iXmYMQVtdm3+urNuDq93p
        TJHK4w+uQTJKeE6Gs5othTdn3Vy/eu9Bv068D5EgfGAslHkLDdALsgPCPcUoPDOZetA5Kc
        Z7VGmGi9FCoV+ULScP2+3vSWBeBro5RgsDjnh7u40gSmVvksWtVCkqu6EONQDA==
ARC-Authentication-Results: i=1;
        rspamd-786f5898df-lv8dd;
        auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Snatch-Spill: 1d4bca9534ee65d1_1655842383906_3821965475
X-MC-Loop-Signature: 1655842383906:2207848475
X-MC-Ingress-Time: 1655842383905
Received: from pdx1-sub0-mail-a316.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
        by 100.105.211.178 (trex/6.7.1);
        Tue, 21 Jun 2022 20:13:03 +0000
Received: from offworld.. (unknown [104.36.31.105])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dave@stgolabs.net)
        by pdx1-sub0-mail-a316.dreamhost.com (Postfix) with ESMTPSA id 4LSHkk3HV0z2n;
        Tue, 21 Jun 2022 13:13:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
        s=dreamhost; t=1655842383;
        bh=8KPyrK4qTJmhET6C28NIGcqXGbT/X/diSCKe69qw4NE=;
        h=From:To:Cc:Subject:Date:Content-Transfer-Encoding;
        b=eYymlIO2XmOrppHTU3OEIr/W82/B03X8k/1zpG6CRJ8eQgREq90FGoGsO2NbP6onH
         DGdG+AerImRAZzbhBDw98PPX88jmXdq/7exRwIE//VvRCj2uH2a8LPJaAUqr7zL6El
         csozTIiv0i6gzD5BgfLroUi4EPnNUMTFGej6XTI2p9CH9PwHcArzVPpNMMesGqyGZT
         oJUADS2gUb+J5a0U//q81+7b2HrKCN7xyzEJc5B58F5LMwBpB7iTPcvkeM1g0nx44R
         8A+EKV6UXiCCGUz41mUX/hI45GZkdC8uvB3prOaYf/YhivnsL8IrPskS+8xRKd8kvb
         jjnYNzqe2B5pg==
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     linux-cxl@vger.kernel.org
Cc:     dan.j.williams@intel.com, alison.schofield@intel.com,
        bwidawsk@kernel.org, ira.weiny@intel.com, vishal.l.verma@intel.com,
        a.manzanares@samsung.com, dave@stgolabs.net,
        linux-kernel@vger.kernel.org
Subject: [PATCH] cxl/acpi: Verify CHBS consistency
Date:   Tue, 21 Jun 2022 13:12:59 -0700
Message-Id: <20220621201259.1547474-1-dave@stgolabs.net>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Similarly to verifying the cfwms, have a cxl_acpi_chbs_verify(),
as described by the CXL T3 Memory Device Software Guide
for CXL 2.0 platforms.

Also while at it, tuck the rc check for nvdimm bridge into
the pmem branch.

Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
---

 drivers/cxl/acpi.c | 64 +++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 61 insertions(+), 3 deletions(-)

diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
index 40286f5df812..33b5f362c9f1 100644
--- a/drivers/cxl/acpi.c
+++ b/drivers/cxl/acpi.c
@@ -187,14 +187,65 @@ static int add_host_bridge_uport(struct device *match, void *arg)
 struct cxl_chbs_context {
 	struct device *dev;
 	unsigned long long uid;
+	struct cxl_port *root_port;
 	resource_size_t chbcr;
 };
 
+static inline bool range_overlaps(struct range *r1, struct range *r2)
+{
+	return r1->start <= r2->end && r2->start <= r1->end;
+}
+
+static int cxl_acpi_chbs_verify(struct cxl_chbs_context *cxt,
+				struct acpi_cedt_chbs *chbs)
+{
+	struct device *dev = cxt->dev;
+	struct cxl_dport *dport;
+	struct cxl_port *root_port = cxt->root_port;
+	struct range chbs_range = {
+		.start = chbs->base,
+		.end = chbs->base + chbs->length - 1,
+	};
+
+	if (chbs->cxl_version > 1) {
+		dev_err(dev, "CHBS Unsupported CXL Version\n");
+		return -EINVAL;
+	}
+
+	if (chbs->cxl_version == ACPI_CEDT_CHBS_VERSION_CXL11)
+		return 0;
+
+	if (chbs->cxl_version == ACPI_CEDT_CHBS_VERSION_CXL20 &&
+	    (chbs->length != ACPI_CEDT_CHBS_LENGTH_CXL20)) {
+		dev_err(dev, "Platform does not support CXL 2.0\n");
+		return -EINVAL;
+	}
+
+	device_lock(&root_port->dev);
+	list_for_each_entry(dport, &root_port->dports, list) {
+		struct range dport_range = {
+			.start = dport->component_reg_phys,
+			.end = dport->component_reg_phys +
+			CXL_COMPONENT_REG_BLOCK_SIZE - 1,
+		};
+
+		if (range_overlaps(&chbs_range, &dport_range)) {
+			device_unlock(&root_port->dev);
+			dev_err(dev, "CHBS overlapping Base and Length pair\n");
+			return -EINVAL;
+		}
+	}
+	device_unlock(&root_port->dev);
+
+	return 0;
+}
+
 static int cxl_get_chbcr(union acpi_subtable_headers *header, void *arg,
 			 const unsigned long end)
 {
 	struct cxl_chbs_context *ctx = arg;
 	struct acpi_cedt_chbs *chbs;
+	int ret;
 
 	if (ctx->chbcr)
 		return 0;
@@ -203,6 +254,11 @@ static int cxl_get_chbcr(union acpi_subtable_headers *header, void *arg,
 
 	if (ctx->uid != chbs->uid)
 		return 0;
+
+	ret = cxl_acpi_chbs_verify(ctx, chbs);
+	if (ret)
+		return ret;
+
 	ctx->chbcr = chbs->base;
 
 	return 0;
@@ -232,6 +288,7 @@ static int add_host_bridge_dport(struct device *match, void *arg)
 	ctx = (struct cxl_chbs_context) {
 		.dev = host,
 		.uid = uid,
+		.root_port = root_port,
 	};
 	acpi_table_parse_cedt(ACPI_CEDT_TYPE_CHBS, cxl_get_chbcr, &ctx);
 
@@ -321,11 +378,12 @@ static int cxl_acpi_probe(struct platform_device *pdev)
 	if (rc < 0)
 		return rc;
 
-	if (IS_ENABLED(CONFIG_CXL_PMEM))
+	if (IS_ENABLED(CONFIG_CXL_PMEM)) {
 		rc = device_for_each_child(&root_port->dev, root_port,
 					   add_root_nvdimm_bridge);
-	if (rc < 0)
-		return rc;
+		if (rc < 0)
+			return rc;
+	}
 
 	/* In case PCI is scanned before ACPI re-trigger memdev attach */
 	return cxl_bus_rescan();
-- 
2.36.1

