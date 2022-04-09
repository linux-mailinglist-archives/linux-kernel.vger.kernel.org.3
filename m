Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBB364FA25F
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Apr 2022 06:17:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240742AbiDIETY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Apr 2022 00:19:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240684AbiDIETW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Apr 2022 00:19:22 -0400
Received: from mail-40141.protonmail.ch (mail-40141.protonmail.ch [185.70.40.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F861381B7;
        Fri,  8 Apr 2022 21:17:16 -0700 (PDT)
Date:   Sat, 09 Apr 2022 04:17:08 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail; t=1649477834;
        bh=gC2D3uYjVBhkCwgNw3OoZdjOU5tGxtwsCPqWNVYkFgE=;
        h=Date:To:From:Cc:Reply-To:Subject:Message-ID:From:To:Cc:Date:
         Subject:Reply-To:Feedback-ID:Message-ID;
        b=AYENJ+zBJklbKWilpmUGy1KcZs+MxUUWqGGGqabR8SaWcdxdy2qBDWrSuu7ViKXjs
         O8+M7VUxNaYsdvm2QKtTl5Je+axEHBM1EZ8fewvJi5EQ8gh7/h5BBT7K1aewcYXH53
         jQY0qIYlY80NZmVMCvt4mrduVSVRUqHYsvoI0+cIRVwMoub08/1jYC3jUNlgksZSSj
         U110Cd2V1H4rF8XRTlWhCgTw0gg4fdU/vLDuMejMaUcs1ZmZydoH1OeIVNfqjXJQSi
         3pfga3mEmbcfpO9ls5KhlzzDh0GFDFB9g4PKjNF25gHtKcawjiCx1SgMLFkbdMRksJ
         nMaP73Py5TV5Q==
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Ilia Lin <ilia.lin@kernel.org>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>
From:   Yassine Oudjana <y.oudjana@protonmail.com>
Cc:     Yassine Oudjana <y.oudjana@protonmail.com>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Loic Poulain <loic.poulain@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-pm@vger.kernel.org
Reply-To: Yassine Oudjana <y.oudjana@protonmail.com>
Subject: [PATCH v2 4/9] cpufreq: qcom_cpufreq_nvmem: Simplify reading kryo speedbin
Message-ID: <Y9dBnONptyKSAfxkDMNrHE0ZnxoXPbMswY6JV-anlE_BALCes8hTJnFMtfTEtss09rNPE3v1Wvz9ZDO2NK0WPH42Ld5Wiw6ukm7Jy3wa5SQ=@protonmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_MSPIKE_H4,
        RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

MSM8996 and MSM8996 Pro have different OPPs with different dependencies on
CPR and CBF levels. Sharing the same OPP tables will make implementing CPR
and CBF scaling quite difficult, as it will become necessary to use
opp-supported-hw not only to choose CPU OPPs, but to also choose their
required CPR and CBF OPPs which are different on the same CPU OPP between
MSM8996 and MSM8996 Pro. The best solution would be to make a new device
tree for MSM8996 Pro which would override the OPP tables from the existing
MSM8996 device tree.

In preparation for adding a separate device tree for MSM8996 Pro, skip
reading msm-id from smem and just read the speedbin efuse.

Signed-off-by: Yassine Oudjana <y.oudjana@protonmail.com>
---
 drivers/cpufreq/Kconfig.arm          |  1 -
 drivers/cpufreq/qcom-cpufreq-nvmem.c | 75 +++-------------------------
 2 files changed, 6 insertions(+), 70 deletions(-)

diff --git a/drivers/cpufreq/Kconfig.arm b/drivers/cpufreq/Kconfig.arm
index 954749afb5fe..7d9798bc5753 100644
--- a/drivers/cpufreq/Kconfig.arm
+++ b/drivers/cpufreq/Kconfig.arm
@@ -154,7 +154,6 @@ config ARM_QCOM_CPUFREQ_NVMEM
 =09tristate "Qualcomm nvmem based CPUFreq"
 =09depends on ARCH_QCOM
 =09depends on QCOM_QFPROM
-=09depends on QCOM_SMEM
 =09select PM_OPP
 =09help
 =09  This adds the CPUFreq driver for Qualcomm Kryo SoC based boards.
diff --git a/drivers/cpufreq/qcom-cpufreq-nvmem.c b/drivers/cpufreq/qcom-cp=
ufreq-nvmem.c
index 6dfa86971a75..a2b895a930cb 100644
--- a/drivers/cpufreq/qcom-cpufreq-nvmem.c
+++ b/drivers/cpufreq/qcom-cpufreq-nvmem.c
@@ -9,8 +9,8 @@
  * based on the silicon variant in use. Qualcomm Process Voltage Scaling T=
ables
  * defines the voltage and frequency value based on the msm-id in SMEM
  * and speedbin blown in the efuse combination.
- * The qcom-cpufreq-nvmem driver reads the msm-id and efuse value from the=
 SoC
- * to provide the OPP framework with required information.
+ * The qcom-cpufreq-nvmem driver reads efuse value from the SoC to provide=
 the
+ * OPP framework with required information.
  * This is used to determine the voltage and frequency value for each OPP =
of
  * operating-points-v2 table when it is parsed by the OPP framework.
  */
@@ -27,22 +27,6 @@
 #include <linux/pm_domain.h>
 #include <linux/pm_opp.h>
 #include <linux/slab.h>
-#include <linux/soc/qcom/smem.h>
-
-#define MSM_ID_SMEM=09137
-
-enum _msm_id {
-=09MSM8996V3 =3D 0xF6ul,
-=09APQ8096V3 =3D 0x123ul,
-=09MSM8996SG =3D 0x131ul,
-=09APQ8096SG =3D 0x138ul,
-};
-
-enum _msm8996_version {
-=09MSM8996_V3,
-=09MSM8996_SG,
-=09NUM_OF_MSM8996_VERSIONS,
-};

 struct qcom_cpufreq_drv;

@@ -142,35 +126,6 @@ static void get_krait_bin_format_b(struct device *cpu_=
dev,
 =09dev_dbg(cpu_dev, "PVS version: %d\n", *pvs_ver);
 }

-static enum _msm8996_version qcom_cpufreq_get_msm_id(void)
-{
-=09size_t len;
-=09u32 *msm_id;
-=09enum _msm8996_version version;
-
-=09msm_id =3D qcom_smem_get(QCOM_SMEM_HOST_ANY, MSM_ID_SMEM, &len);
-=09if (IS_ERR(msm_id))
-=09=09return NUM_OF_MSM8996_VERSIONS;
-
-=09/* The first 4 bytes are format, next to them is the actual msm-id */
-=09msm_id++;
-
-=09switch ((enum _msm_id)*msm_id) {
-=09case MSM8996V3:
-=09case APQ8096V3:
-=09=09version =3D MSM8996_V3;
-=09=09break;
-=09case MSM8996SG:
-=09case APQ8096SG:
-=09=09version =3D MSM8996_SG;
-=09=09break;
-=09default:
-=09=09version =3D NUM_OF_MSM8996_VERSIONS;
-=09}
-
-=09return version;
-}
-
 static int qcom_cpufreq_kryo_name_version(struct device *cpu_dev,
 =09=09=09=09=09  struct nvmem_cell *speedbin_nvmem,
 =09=09=09=09=09  char **pvs_name,
@@ -178,30 +133,13 @@ static int qcom_cpufreq_kryo_name_version(struct devi=
ce *cpu_dev,
 {
 =09size_t len;
 =09u8 *speedbin;
-=09enum _msm8996_version msm8996_version;
 =09*pvs_name =3D NULL;

-=09msm8996_version =3D qcom_cpufreq_get_msm_id();
-=09if (NUM_OF_MSM8996_VERSIONS =3D=3D msm8996_version) {
-=09=09dev_err(cpu_dev, "Not Snapdragon 820/821!");
-=09=09return -ENODEV;
-=09}
-
 =09speedbin =3D nvmem_cell_read(speedbin_nvmem, &len);
 =09if (IS_ERR(speedbin))
 =09=09return PTR_ERR(speedbin);

-=09switch (msm8996_version) {
-=09case MSM8996_V3:
-=09=09drv->versions =3D 1 << (unsigned int)(*speedbin);
-=09=09break;
-=09case MSM8996_SG:
-=09=09drv->versions =3D 1 << ((unsigned int)(*speedbin) + 4);
-=09=09break;
-=09default:
-=09=09BUG();
-=09=09break;
-=09}
+=09drv->versions =3D 1 << (unsigned int)(*speedbin);

 =09kfree(speedbin);
 =09return 0;
@@ -464,10 +402,9 @@ static const struct of_device_id qcom_cpufreq_match_li=
st[] __initconst =3D {
 MODULE_DEVICE_TABLE(of, qcom_cpufreq_match_list);

 /*
- * Since the driver depends on smem and nvmem drivers, which may
- * return EPROBE_DEFER, all the real activity is done in the probe,
- * which may be defered as well. The init here is only registering
- * the driver and the platform device.
+ * Since the driver depends on the nvmem driver, which may return EPROBE_D=
EFER,
+ * all the real activity is done in the probe, which may be defered as wel=
l.
+ * The init here is only registering the driver and the platform device.
  */
 static int __init qcom_cpufreq_init(void)
 {
--
2.35.1

