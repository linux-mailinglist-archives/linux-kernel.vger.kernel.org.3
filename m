Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4947E474EB8
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 00:46:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238317AbhLNXqy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 18:46:54 -0500
Received: from ixit.cz ([94.230.151.217]:55366 "EHLO ixit.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231447AbhLNXqx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 18:46:53 -0500
Received: from localhost.localdomain (ip-89-176-96-70.net.upcbroadband.cz [89.176.96.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ixit.cz (Postfix) with ESMTPSA id D0A952243C;
        Wed, 15 Dec 2021 00:46:49 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ixit.cz; s=dkim;
        t=1639525610;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=oHBpVI1zX0MdWA918+G1nEObZsRGP/0tTmp80DjrlbI=;
        b=STWLsICsbmo6ZaAsoQCv9VQspc8ZlVlJPlkyADg3Ym0IKu4RM4mJ048ipk/kEI+2xS9thS
        igrK6iFEHcUdYI3F+RSD8kPDUN9sarK9gaTY+CcSKGQgPNJxDLrUPrZS+e25IOLOE+S5K+
        zlxKT9T+zPS04hAI4GJNHONHRSJr7FM=
From:   David Heidelberg <david@ixit.cz>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Caleb Connolly <caleb@connolly.tech>,
        David Heidelberg <david@ixit.cz>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] arm64: dts: sdm845: rename memory@ nodes to more descriptive names
Date:   Wed, 15 Dec 2021 00:46:47 +0100
Message-Id: <20211214234648.23369-1-david@ixit.cz>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Pure effort to avoid `make dtbs_check` warnings about memory@ nodes, which
should have property device_type set to memory.

Fixes warnings as:
arch/arm64/boot/dts/qcom/sdm845-oneplus-fajita.dt.yaml: memory@f5b00000: 'device_type' is a required property
        From schema: dtschema/schemas/memory.yaml

Signed-off-by: David Heidelberg <david@ixit.cz>
---
 .../boot/dts/qcom/sdm845-oneplus-common.dtsi  |  8 ++--
 arch/arm64/boot/dts/qcom/sdm845.dtsi          | 38 +++++++++----------
 2 files changed, 23 insertions(+), 23 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sdm845-oneplus-common.dtsi b/arch/arm64/boot/dts/qcom/sdm845-oneplus-common.dtsi
index 7f42e5315ecb..511ca72f465e 100644
--- a/arch/arm64/boot/dts/qcom/sdm845-oneplus-common.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm845-oneplus-common.dtsi
@@ -54,7 +54,7 @@ reserved-memory {
 		 * it is otherwise possible for an allocation adjacent to the
 		 * rmtfs_mem region to trigger an XPU violation, causing a crash.
 		 */
-		rmtfs_lower_guard: memory@f5b00000 {
+		rmtfs_lower_guard: rmtfs-lower-guard@f5b00000 {
 			no-map;
 			reg = <0 0xf5b00000 0 0x1000>;
 		};
@@ -63,7 +63,7 @@ rmtfs_lower_guard: memory@f5b00000 {
 		 * but given the same address every time. Hard code it as this address is
 		 * where the modem firmware expects it to be.
 		 */
-		rmtfs_mem: memory@f5b01000 {
+		rmtfs_mem: rmtfs-mem@f5b01000 {
 			compatible = "qcom,rmtfs-mem";
 			reg = <0 0xf5b01000 0 0x200000>;
 			no-map;
@@ -71,7 +71,7 @@ rmtfs_mem: memory@f5b01000 {
 			qcom,client-id = <1>;
 			qcom,vmid = <15>;
 		};
-		rmtfs_upper_guard: memory@f5d01000 {
+		rmtfs_upper_guard: rmtfs-upper-guard@f5d01000 {
 			no-map;
 			reg = <0 0xf5d01000 0 0x1000>;
 		};
@@ -80,7 +80,7 @@ rmtfs_upper_guard: memory@f5d01000 {
 		 * It seems like reserving the old rmtfs_mem region is also needed to prevent
 		 * random crashes which are most likely modem related, more testing needed.
 		 */
-		removed_region: memory@88f00000 {
+		removed_region: removed-region@88f00000 {
 			no-map;
 			reg = <0 0x88f00000 0 0x1c00000>;
 		};
diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
index 5fac82f026fd..28f7dc5c886a 100644
--- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
@@ -79,22 +79,22 @@ reserved-memory {
 		#size-cells = <2>;
 		ranges;
 
-		hyp_mem: memory@85700000 {
+		hyp_mem: hyp-mem@85700000 {
 			reg = <0 0x85700000 0 0x600000>;
 			no-map;
 		};
 
-		xbl_mem: memory@85e00000 {
+		xbl_mem: xbl-mem@85e00000 {
 			reg = <0 0x85e00000 0 0x100000>;
 			no-map;
 		};
 
-		aop_mem: memory@85fc0000 {
+		aop_mem: aop-mem@85fc0000 {
 			reg = <0 0x85fc0000 0 0x20000>;
 			no-map;
 		};
 
-		aop_cmd_db_mem: memory@85fe0000 {
+		aop_cmd_db_mem: aop-cmd-db-mem@85fe0000 {
 			compatible = "qcom,cmd-db";
 			reg = <0x0 0x85fe0000 0 0x20000>;
 			no-map;
@@ -107,12 +107,12 @@ smem@86000000 {
 			hwlocks = <&tcsr_mutex 3>;
 		};
 
-		tz_mem: memory@86200000 {
+		tz_mem: tz@86200000 {
 			reg = <0 0x86200000 0 0x2d00000>;
 			no-map;
 		};
 
-		rmtfs_mem: memory@88f00000 {
+		rmtfs_mem: rmtfs@88f00000 {
 			compatible = "qcom,rmtfs-mem";
 			reg = <0 0x88f00000 0 0x200000>;
 			no-map;
@@ -121,67 +121,67 @@ rmtfs_mem: memory@88f00000 {
 			qcom,vmid = <15>;
 		};
 
-		qseecom_mem: memory@8ab00000 {
+		qseecom_mem: qseecom@8ab00000 {
 			reg = <0 0x8ab00000 0 0x1400000>;
 			no-map;
 		};
 
-		camera_mem: memory@8bf00000 {
+		camera_mem: camera-mem@8bf00000 {
 			reg = <0 0x8bf00000 0 0x500000>;
 			no-map;
 		};
 
-		ipa_fw_mem: memory@8c400000 {
+		ipa_fw_mem: ipa-fw@8c400000 {
 			reg = <0 0x8c400000 0 0x10000>;
 			no-map;
 		};
 
-		ipa_gsi_mem: memory@8c410000 {
+		ipa_gsi_mem: ipa-gsi@8c410000 {
 			reg = <0 0x8c410000 0 0x5000>;
 			no-map;
 		};
 
-		gpu_mem: memory@8c415000 {
+		gpu_mem: gpu@8c415000 {
 			reg = <0 0x8c415000 0 0x2000>;
 			no-map;
 		};
 
-		adsp_mem: memory@8c500000 {
+		adsp_mem: adsp@8c500000 {
 			reg = <0 0x8c500000 0 0x1a00000>;
 			no-map;
 		};
 
-		wlan_msa_mem: memory@8df00000 {
+		wlan_msa_mem: wlan-msa@8df00000 {
 			reg = <0 0x8df00000 0 0x100000>;
 			no-map;
 		};
 
-		mpss_region: memory@8e000000 {
+		mpss_region: mpss@8e000000 {
 			reg = <0 0x8e000000 0 0x7800000>;
 			no-map;
 		};
 
-		venus_mem: memory@95800000 {
+		venus_mem: venus@95800000 {
 			reg = <0 0x95800000 0 0x500000>;
 			no-map;
 		};
 
-		cdsp_mem: memory@95d00000 {
+		cdsp_mem: cdsp@95d00000 {
 			reg = <0 0x95d00000 0 0x800000>;
 			no-map;
 		};
 
-		mba_region: memory@96500000 {
+		mba_region: mba@96500000 {
 			reg = <0 0x96500000 0 0x200000>;
 			no-map;
 		};
 
-		slpi_mem: memory@96700000 {
+		slpi_mem: slpi@96700000 {
 			reg = <0 0x96700000 0 0x1400000>;
 			no-map;
 		};
 
-		spss_mem: memory@97b00000 {
+		spss_mem: spss@97b00000 {
 			reg = <0 0x97b00000 0 0x100000>;
 			no-map;
 		};
-- 
2.33.0

