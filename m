Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B3CC518FF6
	for <lists+linux-kernel@lfdr.de>; Tue,  3 May 2022 23:22:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242795AbiECVVl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 17:21:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242726AbiECVVW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 17:21:22 -0400
Received: from mail-oo1-xc30.google.com (mail-oo1-xc30.google.com [IPv6:2607:f8b0:4864:20::c30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE09640929
        for <linux-kernel@vger.kernel.org>; Tue,  3 May 2022 14:17:45 -0700 (PDT)
Received: by mail-oo1-xc30.google.com with SMTP id o10-20020a4abe8a000000b0035eac0a004aso2628328oop.11
        for <linux-kernel@vger.kernel.org>; Tue, 03 May 2022 14:17:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JBcUXt5dt4Py/iqZdre4Zy424VTqJ8vz54Hn9FgKdxs=;
        b=G8KQVq6J/KLIzXxh/gCjlEbeH5myusk0qfSJ+kOnrXRM6suRjc/cRd11ipsFif0iW8
         5Sa8FtrQt7pm0l0ckHDYes4z463oi5Id1/KwoUukneYOQvjP+sDXHJGMqnhE9nzj8LDQ
         VJDg34XWtAhhbrtEtRs2IVEWoImvmCpAry2xND3O/uhLuqJD98jPC225AlIH+ACitKL5
         ZEci23lUxJLDLh9I5BPhR+t7lasdKgR79DkpBuHpfcyVmh4FkY6F8MPrw9KhSuoBrZYA
         Zp8YDqZ61rwpDe4AG7P8aYaH9wWdC1QSeG1cnZlUBXpKK2ZnuqoyFE45WxmzBKoLD7lM
         e5IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JBcUXt5dt4Py/iqZdre4Zy424VTqJ8vz54Hn9FgKdxs=;
        b=2BaYDnMtY95DwYJQwSe9+taWTbM2MhJ+zJI+gMEzmi/WWdE5z97tg09DMmjm8XLXHF
         PUBBaaYpNUXg0p0D7noMBgF9TqTWaxnPLuF48XZMur7lCK6p4NEHZS5zkNv71wTMzJoQ
         vshFfeES7sxau+hRbU1qz/FSeczGyw2uboLSZFbzk3LC64MggJI2X3Lw71/8P4yAivhj
         fKAnFII6JAe7pAADUtofAq/+ontqZ1Fq7f9ga8L/r0USJG2LYYxSs9jjWbEnC32RN8RK
         zI9QolVa2qIsOoDK8BWLn3832VBMctj8NrHHvNFT/+n9uV3lyRfdFtqqtOP/pKe2MS+n
         aDGQ==
X-Gm-Message-State: AOAM532OYetwxFwvgwZK/XGreLtDDKr1Qtm1bfvg5Jhk9wYyyy3iiGhk
        iH9djALrUvA2xX2hfvHxfODXzQ==
X-Google-Smtp-Source: ABdhPJyf2RQj+l4lDSS1iSQb6aXRzO2rbt5RlRQcGdLnQvfRr5ayUX2SKaYBWt2w5H2xWB0bVkYeVA==
X-Received: by 2002:a4a:8242:0:b0:33a:336b:8a00 with SMTP id t2-20020a4a8242000000b0033a336b8a00mr6358546oog.72.1651612665125;
        Tue, 03 May 2022 14:17:45 -0700 (PDT)
Received: from ripper.. (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id b3-20020a056830104300b0060603221263sm4305906otp.51.2022.05.03.14.17.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 May 2022 14:17:44 -0700 (PDT)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Georgi Djakov <djakov@kernel.org>,
        Steev Klimaszewski <steev@kali.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 4/4] interconnect: qcom: sc8180x: Mark some BCMs keepalive
Date:   Tue,  3 May 2022 14:19:25 -0700
Message-Id: <20220503211925.1022169-5-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220503211925.1022169-1-bjorn.andersson@linaro.org>
References: <20220503211925.1022169-1-bjorn.andersson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In line with other platforms, mark BCMs controlling paths between the
CPU, AOSS, GIC and memory as keepalive.

Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---
 drivers/interconnect/qcom/sc8180x.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/interconnect/qcom/sc8180x.c b/drivers/interconnect/qco=
m/sc8180x.c
index 86500d05caa3..1a9a39ab9c05 100644
--- a/drivers/interconnect/qcom/sc8180x.c
+++ b/drivers/interconnect/qcom/sc8180x.c
@@ -173,29 +173,29 @@ DEFINE_QNODE(slv_qup_core_1, SC8180X_SLAVE_QUP_CORE_1=
, 1, 4);
 DEFINE_QNODE(slv_qup_core_2, SC8180X_SLAVE_QUP_CORE_2, 1, 4);
=20
 DEFINE_QBCM(bcm_acv, "ACV", false, &slv_ebi);
-DEFINE_QBCM(bcm_mc0, "MC0", false, &slv_ebi);
-DEFINE_QBCM(bcm_sh0, "SH0", false, &slv_qns_llcc);
+DEFINE_QBCM(bcm_mc0, "MC0", true, &slv_ebi);
+DEFINE_QBCM(bcm_sh0, "SH0", true, &slv_qns_llcc);
 DEFINE_QBCM(bcm_mm0, "MM0", false, &slv_qns_mem_noc_hf);
 DEFINE_QBCM(bcm_co0, "CO0", false, &slv_qns_cdsp_mem_noc);
 DEFINE_QBCM(bcm_ce0, "CE0", false, &mas_qxm_crypto);
-DEFINE_QBCM(bcm_cn0, "CN0", false, &mas_qnm_snoc, &slv_qhs_a1_noc_cfg, &sl=
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
+DEFINE_QBCM(bcm_cn0, "CN0", true, &mas_qnm_snoc, &slv_qhs_a1_noc_cfg, &slv=
_qhs_a2_noc_cfg, &slv_qhs_ahb2phy_refgen_center, &slv_qhs_ahb2phy_refgen_ea=
st, &slv_qhs_ahb2phy_refgen_west, &slv_qhs_ahb2phy_south, &slv_qhs_aop, &sl=
v_qhs_aoss, &slv_qhs_camera_cfg, &slv_qhs_clk_ctl, &slv_qhs_compute_dsp, &s=
lv_qhs_cpr_cx, &slv_qhs_cpr_mmcx, &slv_qhs_cpr_mx, &slv_qhs_crypto0_cfg, &s=
lv_qhs_ddrss_cfg, &slv_qhs_display_cfg, &slv_qhs_emac_cfg, &slv_qhs_glm, &s=
lv_qhs_gpuss_cfg, &slv_qhs_imem_cfg, &slv_qhs_ipa, &slv_qhs_mnoc_cfg, &slv_=
qhs_npu_cfg, &slv_qhs_pcie0_cfg, &slv_qhs_pcie1_cfg, &slv_qhs_pcie2_cfg, &s=
lv_qhs_pcie3_cfg, &slv_qhs_pdm, &slv_qhs_pimem_cfg, &slv_qhs_prng, &slv_qhs=
_qdss_cfg, &slv_qhs_qspi_0, &slv_qhs_qspi_1, &slv_qhs_qupv3_east0, &slv_qhs=
_qupv3_east1, &slv_qhs_qupv3_west, &slv_qhs_sdc2, &slv_qhs_sdc4, &slv_qhs_s=
ecurity, &slv_qhs_snoc_cfg, &slv_qhs_spss_cfg, &slv_qhs_tcsr, &slv_qhs_tlmm=
_east, &slv_qhs_tlmm_south, &slv_qhs_tlmm_west, &slv_qhs_tsif, &slv_qhs_ufs=
_card_cfg, &slv_qhs_ufs_mem0_cfg, &slv_qhs_ufs_mem1_cfg, &slv_qhs_usb3_0, &=
slv_qhs_usb3_1, &slv_qhs_usb3_2, &slv_qhs_venus_cfg, &slv_qhs_vsense_ctrl_c=
fg, &slv_srvc_cnoc);
 DEFINE_QBCM(bcm_mm1, "MM1", false, &mas_qxm_camnoc_hf0_uncomp, &mas_qxm_ca=
mnoc_hf1_uncomp, &mas_qxm_camnoc_sf_uncomp, &mas_qxm_camnoc_hf0, &mas_qxm_c=
amnoc_hf1, &mas_qxm_mdp0, &mas_qxm_mdp1);
 DEFINE_QBCM(bcm_qup0, "QUP0", false, &mas_qup_core_0, &mas_qup_core_1, &ma=
s_qup_core_2);
 DEFINE_QBCM(bcm_sh2, "SH2", false, &slv_qns_gem_noc_snoc);
 DEFINE_QBCM(bcm_mm2, "MM2", false, &mas_qxm_camnoc_sf, &mas_qxm_rot, &mas_=
qxm_venus0, &mas_qxm_venus1, &mas_qxm_venus_arm9, &slv_qns2_mem_noc);
-DEFINE_QBCM(bcm_sh3, "SH3", false, &mas_acm_apps);
+DEFINE_QBCM(bcm_sh3, "SH3", true, &mas_acm_apps);
 DEFINE_QBCM(bcm_sn0, "SN0", false, &slv_qns_gemnoc_sf);
 DEFINE_QBCM(bcm_sn1, "SN1", false, &slv_qxs_imem);
-DEFINE_QBCM(bcm_sn2, "SN2", false, &slv_qns_gemnoc_gc);
+DEFINE_QBCM(bcm_sn2, "SN2", true, &slv_qns_gemnoc_gc);
 DEFINE_QBCM(bcm_co2, "CO2", false, &mas_qnm_npu);
 DEFINE_QBCM(bcm_ip0, "IP0", false, &slv_ipa_core_slave);
-DEFINE_QBCM(bcm_sn3, "SN3", false, &slv_srvc_aggre1_noc, &slv_qns_cnoc);
+DEFINE_QBCM(bcm_sn3, "SN3", true, &slv_srvc_aggre1_noc, &slv_qns_cnoc);
 DEFINE_QBCM(bcm_sn4, "SN4", false, &slv_qxs_pimem);
 DEFINE_QBCM(bcm_sn8, "SN8", false, &slv_xs_pcie_0, &slv_xs_pcie_1, &slv_xs=
_pcie_2, &slv_xs_pcie_3);
 DEFINE_QBCM(bcm_sn9, "SN9", false, &mas_qnm_aggre1_noc);
 DEFINE_QBCM(bcm_sn11, "SN11", false, &mas_qnm_aggre2_noc);
 DEFINE_QBCM(bcm_sn14, "SN14", false, &slv_qns_pcie_mem_noc);
-DEFINE_QBCM(bcm_sn15, "SN15", false, &mas_qnm_gemnoc);
+DEFINE_QBCM(bcm_sn15, "SN15", true, &mas_qnm_gemnoc);
=20
 static struct qcom_icc_bcm * const aggre1_noc_bcms[] =3D {
 	&bcm_sn3,
--=20
2.35.1

