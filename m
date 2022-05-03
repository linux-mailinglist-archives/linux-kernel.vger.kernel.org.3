Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0B79518FFD
	for <lists+linux-kernel@lfdr.de>; Tue,  3 May 2022 23:22:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242748AbiECVVg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 17:21:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242738AbiECVVT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 17:21:19 -0400
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com [IPv6:2607:f8b0:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A47F340A12
        for <linux-kernel@vger.kernel.org>; Tue,  3 May 2022 14:17:44 -0700 (PDT)
Received: by mail-ot1-x331.google.com with SMTP id c5-20020a9d75c5000000b00605ff3b9997so7266862otl.0
        for <linux-kernel@vger.kernel.org>; Tue, 03 May 2022 14:17:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=spKs26r1F2379xZ6tS7kfXY/VPWdGsDMt+IBl0gLnAk=;
        b=NQNVMOLommaHGfCyIQpDMdxw1821g0Ei8uXX550bRFRpSnk3YP9uvGauqW2Wzwd8Kf
         9OeSda68kHIu03rLC40k27AW+yj0b9r2Q0rrw8c6RMs7gvuouueVDTQ1cNnHgVIMSzcH
         94Bvo+aEBHDDLXuBH08BU2T0FDwn57Ene+eVjXqldQ3z5GRFkGi6K8SkJSacDPrH0RRl
         R6bP/R6AxlxvSCOahohTCk0qI6z56LTaVJmdXyK3o9T9nmZzrO1B5C38DPII/AOqivBu
         97w3gusVJyUIXgYC/7bnVKwEUA0KY1lEkDv6C2eUUENV2SLS7Q3+uSvHiwRDzP6gLiew
         loaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=spKs26r1F2379xZ6tS7kfXY/VPWdGsDMt+IBl0gLnAk=;
        b=SeFWhZh0/EPC4jTyQDh8+w89Ev+EmTMU85kId7rtEioox5Ps0xJriSe3bJ+PXKmhAX
         u6SQ9nZHGVeqDNcpTznaLg77yiWfD02S441NT1GrM5E1Yjw2NVREz5RBzxkU0k/gxaNC
         dc4yda+mnkLvxVkvkap9qscIfNMpnKPp+Jy9l/fhVcS0q5toh9YpFuhVl6n2fnuSaPmj
         IYc30zuPh8MvOU0Mmj5f/PCSciPdaeHHWsGivsPiaFkRvpaFpY9FdHAXVMjBdVKhTzXt
         MfJ77uAUNa8EC31HOCOkg69zNnRLuWkvxeKgdgKHUBTC2dwNbSI3gTc5QSiJRwctjF2y
         CVrg==
X-Gm-Message-State: AOAM5331Z7LmMpEguXAF/DoAVVjj34RiMZdX6PLgLh1IcjqbLZJnv8gJ
        2gaxssma39S2p/hu+OYM63///w==
X-Google-Smtp-Source: ABdhPJyaIoThYJ7KaoNFKJNkQ5dvZPDwcVkdtfuVzaiY3Leg+sqlwsZmVIPhPJMgchjvAKq8GjjtkA==
X-Received: by 2002:a05:6830:2ea:b0:605:e0ab:931 with SMTP id r10-20020a05683002ea00b00605e0ab0931mr6552180ote.117.1651612663995;
        Tue, 03 May 2022 14:17:43 -0700 (PDT)
Received: from ripper.. (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id b3-20020a056830104300b0060603221263sm4305906otp.51.2022.05.03.14.17.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 May 2022 14:17:43 -0700 (PDT)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Georgi Djakov <djakov@kernel.org>,
        Steev Klimaszewski <steev@kali.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/4] interconnect: qcom: sc8180x: Fix QUP0 nodes
Date:   Tue,  3 May 2022 14:19:24 -0700
Message-Id: <20220503211925.1022169-4-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220503211925.1022169-1-bjorn.andersson@linaro.org>
References: <20220503211925.1022169-1-bjorn.andersson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The QUP0 BCM relates to some internal property of the QUPs, and should
be configured independently of the path to the QUP. In line with other
platforms expose QUP_CORE endpoints in order allow this configuration.

Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---
 drivers/interconnect/qcom/sc8180x.c           | 30 +++++++++++++++++--
 drivers/interconnect/qcom/sc8180x.h           |  7 +++++
 .../dt-bindings/interconnect/qcom,sc8180x.h   |  7 +++++
 3 files changed, 41 insertions(+), 3 deletions(-)

diff --git a/drivers/interconnect/qcom/sc8180x.c b/drivers/interconnect/qco=
m/sc8180x.c
index 467083661559..86500d05caa3 100644
--- a/drivers/interconnect/qcom/sc8180x.c
+++ b/drivers/interconnect/qcom/sc8180x.c
@@ -76,6 +76,9 @@ DEFINE_QNODE(mas_qnm_aggre2_noc, SC8180X_A2NOC_SNOC_MAS, =
1, 16, SC8180X_SLAVE_SN
 DEFINE_QNODE(mas_qnm_gemnoc, SC8180X_MASTER_GEM_NOC_SNOC, 1, 8, SC8180X_SL=
AVE_PIMEM, SC8180X_SLAVE_OCIMEM, SC8180X_SLAVE_APPSS, SC8180X_SNOC_CNOC_SLV=
, SC8180X_SLAVE_TCU, SC8180X_SLAVE_QDSS_STM);
 DEFINE_QNODE(mas_qxm_pimem, SC8180X_MASTER_PIMEM, 1, 8, SC8180X_SLAVE_SNOC=
_GEM_NOC_GC, SC8180X_SLAVE_OCIMEM);
 DEFINE_QNODE(mas_xm_gic, SC8180X_MASTER_GIC, 1, 8, SC8180X_SLAVE_SNOC_GEM_=
NOC_GC, SC8180X_SLAVE_OCIMEM);
+DEFINE_QNODE(mas_qup_core_0, SC8180X_MASTER_QUP_CORE_0, 1, 4, SC8180X_SLAV=
E_QUP_CORE_0);
+DEFINE_QNODE(mas_qup_core_1, SC8180X_MASTER_QUP_CORE_1, 1, 4, SC8180X_SLAV=
E_QUP_CORE_1);
+DEFINE_QNODE(mas_qup_core_2, SC8180X_MASTER_QUP_CORE_2, 1, 4, SC8180X_SLAV=
E_QUP_CORE_2);
 DEFINE_QNODE(slv_qns_a1noc_snoc, SC8180X_A1NOC_SNOC_SLV, 1, 32, SC8180X_A1=
NOC_SNOC_MAS);
 DEFINE_QNODE(slv_srvc_aggre1_noc, SC8180X_SLAVE_SERVICE_A1NOC, 1, 4);
 DEFINE_QNODE(slv_qns_a2noc_snoc, SC8180X_A2NOC_SNOC_SLV, 1, 16, SC8180X_A2=
NOC_SNOC_MAS);
@@ -165,6 +168,9 @@ DEFINE_QNODE(slv_xs_pcie_2, SC8180X_SLAVE_PCIE_2, 1, 8);
 DEFINE_QNODE(slv_xs_pcie_3, SC8180X_SLAVE_PCIE_3, 1, 8);
 DEFINE_QNODE(slv_xs_qdss_stm, SC8180X_SLAVE_QDSS_STM, 1, 4);
 DEFINE_QNODE(slv_xs_sys_tcu_cfg, SC8180X_SLAVE_TCU, 1, 8);
+DEFINE_QNODE(slv_qup_core_0, SC8180X_SLAVE_QUP_CORE_0, 1, 4);
+DEFINE_QNODE(slv_qup_core_1, SC8180X_SLAVE_QUP_CORE_1, 1, 4);
+DEFINE_QNODE(slv_qup_core_2, SC8180X_SLAVE_QUP_CORE_2, 1, 4);
=20
 DEFINE_QBCM(bcm_acv, "ACV", false, &slv_ebi);
 DEFINE_QBCM(bcm_mc0, "MC0", false, &slv_ebi);
@@ -174,7 +180,7 @@ DEFINE_QBCM(bcm_co0, "CO0", false, &slv_qns_cdsp_mem_no=
c);
 DEFINE_QBCM(bcm_ce0, "CE0", false, &mas_qxm_crypto);
 DEFINE_QBCM(bcm_cn0, "CN0", false, &mas_qnm_snoc, &slv_qhs_a1_noc_cfg, &sl=
v_qhs_a2_noc_cfg, &slv_qhs_ahb2phy_refgen_center, &slv_qhs_ahb2phy_refgen_e=
ast, &slv_qhs_ahb2phy_refgen_west, &slv_qhs_ahb2phy_south, &slv_qhs_aop, &s=
lv_qhs_aoss, &slv_qhs_camera_cfg, &slv_qhs_clk_ctl, &slv_qhs_compute_dsp, &=
slv_qhs_cpr_cx, &slv_qhs_cpr_mmcx, &slv_qhs_cpr_mx, &slv_qhs_crypto0_cfg, &=
slv_qhs_ddrss_cfg, &slv_qhs_display_cfg, &slv_qhs_emac_cfg, &slv_qhs_glm, &=
slv_qhs_gpuss_cfg, &slv_qhs_imem_cfg, &slv_qhs_ipa, &slv_qhs_mnoc_cfg, &slv=
_qhs_npu_cfg, &slv_qhs_pcie0_cfg, &slv_qhs_pcie1_cfg, &slv_qhs_pcie2_cfg, &=
slv_qhs_pcie3_cfg, &slv_qhs_pdm, &slv_qhs_pimem_cfg, &slv_qhs_prng, &slv_qh=
s_qdss_cfg, &slv_qhs_qspi_0, &slv_qhs_qspi_1, &slv_qhs_qupv3_east0, &slv_qh=
s_qupv3_east1, &slv_qhs_qupv3_west, &slv_qhs_sdc2, &slv_qhs_sdc4, &slv_qhs_=
security, &slv_qhs_snoc_cfg, &slv_qhs_spss_cfg, &slv_qhs_tcsr, &slv_qhs_tlm=
m_east, &slv_qhs_tlmm_south, &slv_qhs_tlmm_west, &slv_qhs_tsif, &slv_qhs_uf=
s_card_cfg, &slv_qhs_ufs_mem0_cfg, &slv_qhs_ufs_mem1_cfg, &slv_qhs_usb3_0, =
&slv_qhs_usb3_1, &slv_qhs_usb3_2, &slv_qhs_venus_cfg, &slv_qhs_vsense_ctrl_=
cfg, &slv_srvc_cnoc);
 DEFINE_QBCM(bcm_mm1, "MM1", false, &mas_qxm_camnoc_hf0_uncomp, &mas_qxm_ca=
mnoc_hf1_uncomp, &mas_qxm_camnoc_sf_uncomp, &mas_qxm_camnoc_hf0, &mas_qxm_c=
amnoc_hf1, &mas_qxm_mdp0, &mas_qxm_mdp1);
-DEFINE_QBCM(bcm_qup0, "QUP0", false, &mas_qhm_qup0, &mas_qhm_qup1, &mas_qh=
m_qup2);
+DEFINE_QBCM(bcm_qup0, "QUP0", false, &mas_qup_core_0, &mas_qup_core_1, &ma=
s_qup_core_2);
 DEFINE_QBCM(bcm_sh2, "SH2", false, &slv_qns_gem_noc_snoc);
 DEFINE_QBCM(bcm_mm2, "MM2", false, &mas_qxm_camnoc_sf, &mas_qxm_rot, &mas_=
qxm_venus0, &mas_qxm_venus1, &mas_qxm_venus_arm9, &slv_qns2_mem_noc);
 DEFINE_QBCM(bcm_sh3, "SH3", false, &mas_acm_apps);
@@ -194,13 +200,11 @@ DEFINE_QBCM(bcm_sn15, "SN15", false, &mas_qnm_gemnoc);
 static struct qcom_icc_bcm * const aggre1_noc_bcms[] =3D {
 	&bcm_sn3,
 	&bcm_ce0,
-	&bcm_qup0,
 };
=20
 static struct qcom_icc_bcm * const aggre2_noc_bcms[] =3D {
 	&bcm_sn14,
 	&bcm_ce0,
-	&bcm_qup0,
 };
=20
 static struct qcom_icc_bcm * const camnoc_virt_bcms[] =3D {
@@ -503,6 +507,25 @@ static const struct qcom_icc_desc sc8180x_system_noc  =
=3D {
 	.num_bcms =3D ARRAY_SIZE(system_noc_bcms),
 };
=20
+static struct qcom_icc_bcm * const qup_virt_bcms[] =3D {
+	&bcm_qup0,
+};
+
+static struct qcom_icc_node *qup_virt_nodes[] =3D {
+	[MASTER_QUP_CORE_0] =3D &mas_qup_core_0,
+	[MASTER_QUP_CORE_1] =3D &mas_qup_core_1,
+	[MASTER_QUP_CORE_2] =3D &mas_qup_core_2,
+	[SLAVE_QUP_CORE_0] =3D &slv_qup_core_0,
+	[SLAVE_QUP_CORE_1] =3D &slv_qup_core_1,
+	[SLAVE_QUP_CORE_2] =3D &slv_qup_core_2,
+};
+
+static const struct qcom_icc_desc sc8180x_qup_virt =3D {
+	.nodes =3D qup_virt_nodes,
+	.num_nodes =3D ARRAY_SIZE(qup_virt_nodes),
+	.bcms =3D qup_virt_bcms,
+	.num_bcms =3D ARRAY_SIZE(qup_virt_bcms),
+};
=20
 static const struct of_device_id qnoc_of_match[] =3D {
 	{ .compatible =3D "qcom,sc8180x-aggre1-noc", .data =3D &sc8180x_aggre1_no=
c },
@@ -515,6 +538,7 @@ static const struct of_device_id qnoc_of_match[] =3D {
 	{ .compatible =3D "qcom,sc8180x-ipa-virt", .data =3D &sc8180x_ipa_virt },
 	{ .compatible =3D "qcom,sc8180x-mc-virt", .data =3D &sc8180x_mc_virt },
 	{ .compatible =3D "qcom,sc8180x-mmss-noc", .data =3D &sc8180x_mmss_noc },
+	{ .compatible =3D "qcom,sc8180x-qup-virt", .data =3D &sc8180x_qup_virt },
 	{ .compatible =3D "qcom,sc8180x-system-noc", .data =3D &sc8180x_system_no=
c },
 	{ }
 };
diff --git a/drivers/interconnect/qcom/sc8180x.h b/drivers/interconnect/qco=
m/sc8180x.h
index e70cf7032f80..2eafd35543c7 100644
--- a/drivers/interconnect/qcom/sc8180x.h
+++ b/drivers/interconnect/qcom/sc8180x.h
@@ -171,4 +171,11 @@
 #define SC8180X_MASTER_OSM_L3_APPS		161
 #define SC8180X_SLAVE_OSM_L3			162
=20
+#define SC8180X_MASTER_QUP_CORE_0		163
+#define SC8180X_MASTER_QUP_CORE_1		164
+#define SC8180X_MASTER_QUP_CORE_2		165
+#define SC8180X_SLAVE_QUP_CORE_0		166
+#define SC8180X_SLAVE_QUP_CORE_1		167
+#define SC8180X_SLAVE_QUP_CORE_2		168
+
 #endif
diff --git a/include/dt-bindings/interconnect/qcom,sc8180x.h b/include/dt-b=
indings/interconnect/qcom,sc8180x.h
index 235b525d2803..e84cfec5afdd 100644
--- a/include/dt-bindings/interconnect/qcom,sc8180x.h
+++ b/include/dt-bindings/interconnect/qcom,sc8180x.h
@@ -182,4 +182,11 @@
 #define SLAVE_MNOC_SF_MEM_NOC_DISPLAY		3
 #define SLAVE_MNOC_HF_MEM_NOC_DISPLAY		4
=20
+#define MASTER_QUP_CORE_0			0
+#define MASTER_QUP_CORE_1			1
+#define MASTER_QUP_CORE_2			2
+#define SLAVE_QUP_CORE_0			3
+#define SLAVE_QUP_CORE_1			4
+#define SLAVE_QUP_CORE_2			5
+
 #endif
--=20
2.35.1

