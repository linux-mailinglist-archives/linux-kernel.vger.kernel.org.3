Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25BD559534A
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 09:03:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231344AbiHPHDo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 03:03:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231532AbiHPHDV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 03:03:21 -0400
Received: from smtp-relay-canonical-0.canonical.com (smtp-relay-canonical-0.canonical.com [185.125.188.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5725140BE1
        for <linux-kernel@vger.kernel.org>; Mon, 15 Aug 2022 19:53:11 -0700 (PDT)
Received: from localhost.localdomain (unknown [10.101.196.174])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id 832BB3F0C6;
        Tue, 16 Aug 2022 02:53:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1660618389;
        bh=IQLHeSHMCgVndEybNXy3VEpy6W3eNIybZWGGP1wHszU=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
        b=JKzWmfhnLy7p+XWRftjo55h4+OEj/1ovUfur4+PYJ8YkxvpB5MfEWaDR9WZXVVGeL
         oWSS0jQ5KPFiirXbOkySLddOYxRWeCO8UwVm0rO9TyB1Kx61jzqCQew0boTcklHG/X
         WmaFe1Bbu6Un4U0SBPOQ87JdVyS5Zot1PEJHjoMSTqOKzJeVMzCBiS7Wovvp6NZFWo
         QdSa/Hxxx0qzVFovhz1ojJ7WlXi8vQvI4EGhbbs0F1/4IGw4SfNISBnLM0tn4PSb/Y
         rqRn8I3SwT1zk0ywcNZS1XBsWsMGH/toefKJv4/qjkpSvSWZBTX6tKCxzh346VG/fT
         sSaiDteA7uhzQ==
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
To:     jani.nikula@linux.intel.com, joonas.lahtinen@linux.intel.com,
        rodrigo.vivi@intel.com, tvrtko.ursulin@linux.intel.com
Cc:     Kai-Heng Feng <kai.heng.feng@canonical.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        =?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= 
        <ville.syrjala@linux.intel.com>, Zenghui Yu <yuzenghui@huawei.com>,
        Lyude Paul <lyude@redhat.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] drm/i915: Switch TGL-H DP-IN to dGFX when it's supported
Date:   Tue, 16 Aug 2022 10:52:16 +0800
Message-Id: <20220816025217.618181-1-kai.heng.feng@canonical.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On mobile workstations like HP ZBook Fury G8, iGFX's DP-IN can switch to
dGFX so external monitors are routed to dGFX, and more monitors can be
supported as result.

To switch the DP-IN to dGFX, the driver needs to invoke _DSM function 20
on intel_dsm_guid2. This method is described in Intel document 632107.

Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
---
 drivers/gpu/drm/i915/display/intel_acpi.c | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/i915/display/intel_acpi.c b/drivers/gpu/drm/i915/display/intel_acpi.c
index e78430001f077..3bd5930e2769b 100644
--- a/drivers/gpu/drm/i915/display/intel_acpi.c
+++ b/drivers/gpu/drm/i915/display/intel_acpi.c
@@ -20,6 +20,7 @@ static const guid_t intel_dsm_guid =
 		  0xa8, 0x54, 0x0f, 0x13, 0x17, 0xb0, 0x1c, 0x2c);
 
 #define INTEL_DSM_FN_GET_BIOS_DATA_FUNCS_SUPPORTED 0 /* No args */
+#define INTEL_DSM_FN_DP_IN_SWITCH_TO_DGFX 20 /* No args */
 
 static const guid_t intel_dsm_guid2 =
 	GUID_INIT(0x3e5b41c6, 0xeb1d, 0x4260,
@@ -187,6 +188,7 @@ void intel_dsm_get_bios_data_funcs_supported(struct drm_i915_private *i915)
 	struct pci_dev *pdev = to_pci_dev(i915->drm.dev);
 	acpi_handle dhandle;
 	union acpi_object *obj;
+	int supported = 0;
 
 	dhandle = ACPI_HANDLE(&pdev->dev);
 	if (!dhandle)
@@ -194,8 +196,22 @@ void intel_dsm_get_bios_data_funcs_supported(struct drm_i915_private *i915)
 
 	obj = acpi_evaluate_dsm(dhandle, &intel_dsm_guid2, INTEL_DSM_REVISION_ID,
 				INTEL_DSM_FN_GET_BIOS_DATA_FUNCS_SUPPORTED, NULL);
-	if (obj)
+	if (obj) {
+		if (obj->type == ACPI_TYPE_INTEGER)
+			supported = obj->integer.value;
+
 		ACPI_FREE(obj);
+	}
+
+	/* Tiger Lake H DP-IN Boot Time Switching from iGfx to dGfx */
+	if (supported & BIT(20)) {
+		obj = acpi_evaluate_dsm(dhandle, &intel_dsm_guid2,
+					INTEL_DSM_REVISION_ID,
+					INTEL_DSM_FN_DP_IN_SWITCH_TO_DGFX,
+					NULL);
+		if (obj)
+			ACPI_FREE(obj);
+	}
 }
 
 /*
-- 
2.36.1

