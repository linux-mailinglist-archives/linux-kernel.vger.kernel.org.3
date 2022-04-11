Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 239914FC5A7
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 22:20:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349824AbiDKUWp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 16:22:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349797AbiDKUWn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 16:22:43 -0400
Received: from mail-oa1-x32.google.com (mail-oa1-x32.google.com [IPv6:2001:4860:4864:20::32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6654E25C52
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 13:20:28 -0700 (PDT)
Received: by mail-oa1-x32.google.com with SMTP id 586e51a60fabf-e2afb80550so6669100fac.1
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 13:20:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=isJA1Tbp1zwgQE0ojXlGzrPJ5Vx/4mUH17JVNgpLXcA=;
        b=kJcsR2X0AKiJb6nAmKnx55hoVRZ+VLgcOk6ySu7cQ/bZve0LKB/XN78HRML73o3UcP
         PGhJ4CBo1m2ak878ylRnxqly+rtWblEKZltcLfcMIiz5yV679AeZ9/3DO1hZ09aXSl/D
         bIPAZgXuArnsMmw7UbbpMDGi6QpMli3eIWXVA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=isJA1Tbp1zwgQE0ojXlGzrPJ5Vx/4mUH17JVNgpLXcA=;
        b=djtNwlP3H1+2VOT3gn2/VD60BfzItiwW0Izgqw0jmORJYcmaKFsuuo3R2vOyfHAc61
         uRLI8fh6FTcVS8opz0diHq1G8s9mvbnZZE29ayMqFbr4B9SpCthYrwUm3AsNPXYi+R1c
         mUsPi6hbLw4IgoV7E+krkwf52Ak2E14vrJeiS4ig9KS78Ta3I4Od313PyjZF+hgMSNgz
         q/amSh8a6ulBX3EIAL7GYBwUN74WxfnfladuVZCquM/PUC/v7kkaZcOMjH/3p4o8g7mm
         GaHfuNdK+0YsYrh5onOpH3e3MFSK3JjhuqNGSw90azPOAYZk8cWGmkx6Q7iOGtk3PtzQ
         oKxg==
X-Gm-Message-State: AOAM531APmVsPQVG8Dt8kZ/O2BKdun+1Din+2h8pXGYo63bS1vJk4GkK
        XZGTeImsY9psNiL6Adu+3VgI9U83ybuog6zDVKS5Jg==
X-Google-Smtp-Source: ABdhPJyFT57mv55wqvTQv+yP3urc6iK0q1QRYkXuKodyXsn1ZrBZAmQOl3iwU+kREAiancKf2f7NNJ4BC9SzUVMWfQw=
X-Received: by 2002:a05:6870:558e:b0:e1:db7c:26aa with SMTP id
 n14-20020a056870558e00b000e1db7c26aamr507696oao.63.1649708427693; Mon, 11 Apr
 2022 13:20:27 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 11 Apr 2022 13:20:27 -0700
MIME-Version: 1.0
In-Reply-To: <CAE-0n51-hpG_5O11FbGrHaMr_mN0ZAky8CVzZNmDj29aK8wGog@mail.gmail.com>
References: <20211125174751.25317-1-djakov@kernel.org> <CAE-0n51xeigKFS9Zek44HZGD9cdc4Em91aQ5HHzuy7P1FBmfFg@mail.gmail.com>
 <a96a010d-9bd7-f760-3c03-d842feef41aa@linaro.org> <CAE-0n51-hpG_5O11FbGrHaMr_mN0ZAky8CVzZNmDj29aK8wGog@mail.gmail.com>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.10
Date:   Mon, 11 Apr 2022 13:20:27 -0700
Message-ID: <CAE-0n51ho9Aia5eUjsvkG3e7rjxjdVMD7CS4XEhYKNUKbQam+w@mail.gmail.com>
Subject: Re: [PATCH v3] interconnect: qcom: icc-rpmh: Add BCMs to commit list
 in pre_aggregate
To:     Alex Elder <elder@linaro.org>, djakov@kernel.org,
        quic_mdtipton@quicinc.com
Cc:     linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, mka@chromium.org,
        dianders@chromium.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Taniya Das <tdas@codeaurora.org>,
        Sibi Sankar <sibis@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Stephen Boyd (2022-04-11 12:06:19)
> Quoting Alex Elder (2022-04-11 08:59:07)
> > The second problem you have is exhibited by the IPA driver if
> > the "fix" commit (upstream b95b668eaaa2) is back-ported to the
> > Linux 5.10.y LTS branch (along with some other prerequisite
> > commits).  We can conclude that applying the above commit
> > makes the bandwidth for an unused interconnect (or perhaps
> > the rate for the IPA core clock) get set to zero.  And in that
> > case, an attempt to access IPA hardware leads to the crash you
> > observed.
> >
> > The IPA driver does not implement runtime power management
> > until Linux v5.15.  You later said you thought enabling that
> > might ensure the clock and interconnects were active when
> > needed by the IPA driver, and I concur (but there could be a
> > little more to it).
>
> Is the runtime PM patch series necessary to enable the IPA clk and
> interconnects? Things don't look good on 5.10.y and I'm not sure it will
> be workable. Commit b1d681d8d324 ("interconnect: Add sync state
> support") was introduced in v5.10 and that seems to be the commit that
> broke suspend on Lazor.
>
> >
> > In any case, based on the time stamp in your log, it seems
> > this problem is likely occurring upon the first access to IPA
> > hardware.
> >
> > I have a hunch about what might be happening here.  There is
> > some synchronization that must occur between the AP and modem
> > when IPA is starting up.  Until that synchronization step has
> > completed, we can't allow the IPA network device to be opened.
>
> Is there a commit that implements this? Or how is the synchronization
> done? I can debug more and see if that synchronization is happening.
>
> > In later kernels I think this is precluded, but perhaps in
> > Linux v5.10 it isn't.  Until I look a little more closely I'm
> > not sure what would happen, but it *could* be this.
> >
> > I'm going to look a little how the particular access that
> > caused the crash is prevented in newer kernels.  It could
> > be that back-porting that (or re-implementing it for the
> > older kernel) will address the crash you're seeing.
> >

I think it's some IPA unclocked access because it's an SError async
abort. I looked some at the IPA clk implementation and it is a little
concerning. I see two problems. The first problem is that clk-rpmh is
only voting on the active state for the IPA clk. Maybe RPMh will move
the sleep/wake state over from the active state automatically as long as
we never make a request in either of those states? I don't know, but it
looks concerning and either needs to be fixed or a big comment
indicating that the copy happens. This patch makes it set a frequency in
each state bucket.

----8<----
diff --git a/drivers/clk/qcom/clk-rpmh.c b/drivers/clk/qcom/clk-rpmh.c
index 74e57c84f60a..03c8c0e7db7a 100644
--- a/drivers/clk/qcom/clk-rpmh.c
+++ b/drivers/clk/qcom/clk-rpmh.c
@@ -260,6 +260,7 @@ static int clk_rpmh_bcm_send_cmd(struct clk_rpmh
*c, bool enable)
 	struct tcs_cmd cmd = { 0 };
 	u32 cmd_state;
 	int ret = 0;
+	enum rpmh_state state;

 	mutex_lock(&rpmh_clk_lock);
 	if (enable) {
@@ -274,15 +275,19 @@ static int clk_rpmh_bcm_send_cmd(struct clk_rpmh
*c, bool enable)
 		cmd.addr = c->res_addr;
 		cmd.data = BCM_TCS_CMD(1, enable, 0, cmd_state);

-		ret = clk_rpmh_send(c, RPMH_ACTIVE_ONLY_STATE, &cmd, enable);
-		if (ret) {
-			dev_err(c->dev, "set active state of %s failed: (%d)\n",
-				c->res_name, ret);
-		} else {
-			c->last_sent_aggr_state = cmd_state;
+		for (state = RPMH_SLEEP_STATE; state <= RPMH_ACTIVE_ONLY_STATE; state++) {
+			ret = clk_rpmh_send(c, state, &cmd, enable);
+			if (ret) {
+				dev_err(c->dev, "set %s state of %s failed: (%d)\n",
+					!state ? "sleep" :
+					state == RPMH_WAKE_ONLY_STATE	?
+					"wake" : "active", c->res_name, ret);
+				goto out;
+			}
 		}
+		c->last_sent_aggr_state = cmd_state;
 	}
-
+out:
 	mutex_unlock(&rpmh_clk_lock);

 	return ret;

---8<-----

The second problem I see is that the IPA clk resource is "IP0" but it is
still defined in the interconnect/qcom/sc7180.c file.

$ git grep \"IP0\" -- drivers/{interconnect,clk}/
drivers/clk/qcom/clk-rpmh.c:DEFINE_CLK_RPMH_BCM(sdm845, ipa, "IP0");
drivers/clk/qcom/clk-rpmh.c:DEFINE_CLK_RPMH_BCM(sdx55, ipa, "IP0");
drivers/interconnect/qcom/sc7180.c:DEFINE_QBCM(bcm_ip0, "IP0", false,
&ipa_core_slave);
drivers/interconnect/qcom/sc8180x.c:DEFINE_QBCM(bcm_ip0, "IP0", false,
&slv_ipa_core_slave);
drivers/interconnect/qcom/sdx55.c:DEFINE_QBCM(bcm_ip0, "IP0", false,
&ipa_core_slave);
drivers/interconnect/qcom/sm8150.c:DEFINE_QBCM(bcm_ip0, "IP0", false,
&ipa_core_slave);
drivers/interconnect/qcom/sm8250.c:DEFINE_QBCM(bcm_ip0, "IP0", false,
&ipa_core_slave);

That sounds pretty bad because it means both interconnect and clk frameworks
are trying to control the same RPMh resource, trampling over each other.
Combine that with unused clks and sync_state support and I don't know
what the state of the IP0 resource really is anymore.

When the clk-rpmh driver got an IPA clk a while ago I didn't want it to
manage this BCM[1]. That's because it doesn't use anything in the clk
framework besides the clk_set_rate() interface. No clk tree management,
or recalc_rate interface, etc. It seems like it kept getting added to
the interconnect framework after sdm845 though. Confusing!

Putting the discussion about how it should be represented in the kernel
aside, I applied this patch and rebooted 30 times and didn't see a
crash. I think this fixed it. I will back out the clk-rpmh patch now and
see if it is still fixed. It would be great if someone from qcom can
tell me what's going on.

diff --git a/drivers/interconnect/qcom/sc7180.c
b/drivers/interconnect/qcom/sc7180.c
index 12d59c36df53..5f7c0f85fa8e 100644
--- a/drivers/interconnect/qcom/sc7180.c
+++ b/drivers/interconnect/qcom/sc7180.c
@@ -47,7 +47,6 @@ DEFINE_QNODE(qnm_mnoc_sf,
SC7180_MASTER_MNOC_SF_MEM_NOC, 1, 32, SC7180_SLAVE_GEM
 DEFINE_QNODE(qnm_snoc_gc, SC7180_MASTER_SNOC_GC_MEM_NOC, 1, 8,
SC7180_SLAVE_LLCC);
 DEFINE_QNODE(qnm_snoc_sf, SC7180_MASTER_SNOC_SF_MEM_NOC, 1, 16,
SC7180_SLAVE_LLCC);
 DEFINE_QNODE(qxm_gpu, SC7180_MASTER_GFX3D, 2, 32,
SC7180_SLAVE_GEM_NOC_SNOC, SC7180_SLAVE_LLCC);
-DEFINE_QNODE(ipa_core_master, SC7180_MASTER_IPA_CORE, 1, 8,
SC7180_SLAVE_IPA_CORE);
 DEFINE_QNODE(llcc_mc, SC7180_MASTER_LLCC, 2, 4, SC7180_SLAVE_EBI1);
 DEFINE_QNODE(qhm_mnoc_cfg, SC7180_MASTER_CNOC_MNOC_CFG, 1, 4,
SC7180_SLAVE_SERVICE_MNOC);
 DEFINE_QNODE(qxm_camnoc_hf0, SC7180_MASTER_CAMNOC_HF0, 2, 32,
SC7180_SLAVE_MNOC_HF_MEM_NOC);
@@ -129,7 +128,6 @@ DEFINE_QNODE(qhs_mdsp_ms_mpu_cfg,
SC7180_SLAVE_MSS_PROC_MS_MPU_CFG, 1, 4);
 DEFINE_QNODE(qns_gem_noc_snoc, SC7180_SLAVE_GEM_NOC_SNOC, 1, 8,
SC7180_MASTER_GEM_NOC_SNOC);
 DEFINE_QNODE(qns_llcc, SC7180_SLAVE_LLCC, 1, 16, SC7180_MASTER_LLCC);
 DEFINE_QNODE(srvc_gemnoc, SC7180_SLAVE_SERVICE_GEM_NOC, 1, 4);
-DEFINE_QNODE(ipa_core_slave, SC7180_SLAVE_IPA_CORE, 1, 8);
 DEFINE_QNODE(ebi, SC7180_SLAVE_EBI1, 2, 4);
 DEFINE_QNODE(qns_mem_noc_hf, SC7180_SLAVE_MNOC_HF_MEM_NOC, 1, 32,
SC7180_MASTER_MNOC_HF_MEM_NOC);
 DEFINE_QNODE(qns_mem_noc_sf, SC7180_SLAVE_MNOC_SF_MEM_NOC, 1, 32,
SC7180_MASTER_MNOC_SF_MEM_NOC);
@@ -160,7 +158,6 @@ DEFINE_QBCM(bcm_mc0, "MC0", true, &ebi);
 DEFINE_QBCM(bcm_sh0, "SH0", true, &qns_llcc);
 DEFINE_QBCM(bcm_mm0, "MM0", false, &qns_mem_noc_hf);
 DEFINE_QBCM(bcm_ce0, "CE0", false, &qxm_crypto);
-DEFINE_QBCM(bcm_ip0, "IP0", false, &ipa_core_slave);
 DEFINE_QBCM(bcm_cn0, "CN0", true, &qnm_snoc, &xm_qdss_dap,
&qhs_a1_noc_cfg, &qhs_a2_noc_cfg, &qhs_ahb2phy0, &qhs_aop, &qhs_aoss,
&qhs_boot_rom, &qhs_camera_cfg, &qhs_camera_nrt_throttle_cfg,
&qhs_camera_rt_throttle_cfg, &qhs_clk_ctl, &qhs_cpr_cx, &qhs_cpr_mx,
&qhs_crypto0_cfg, &qhs_dcc_cfg, &qhs_ddrss_cfg, &qhs_display_cfg,
&qhs_display_rt_throttle_cfg, &qhs_display_throttle_cfg, &qhs_glm,
&qhs_gpuss_cfg, &qhs_imem_cfg, &qhs_ipa, &qhs_mnoc_cfg, &qhs_mss_cfg,
&qhs_npu_cfg, &qhs_npu_dma_throttle_cfg, &qhs_npu_dsp_throttle_cfg,
&qhs_pimem_cfg, &qhs_prng, &qhs_qdss_cfg, &qhs_qm_cfg,
&qhs_qm_mpu_cfg, &qhs_qup0, &qhs_qup1, &qhs_security, &qhs_snoc_cfg,
&qhs_tcsr, &qhs_tlmm_1, &qhs_tlmm_2, &qhs_tlmm_3, &qhs_ufs_mem_cfg,
&qhs_usb3, &qhs_venus_cfg, &qhs_venus_throttle_cfg,
&qhs_vsense_ctrl_cfg, &srvc_cnoc);
 DEFINE_QBCM(bcm_mm1, "MM1", false, &qxm_camnoc_hf0_uncomp,
&qxm_camnoc_hf1_uncomp, &qxm_camnoc_sf_uncomp, &qhm_mnoc_cfg,
&qxm_mdp0, &qxm_rot, &qxm_venus0, &qxm_venus_arm9);
 DEFINE_QBCM(bcm_sh2, "SH2", false, &acm_sys_tcu);
@@ -372,22 +369,6 @@ static struct qcom_icc_desc sc7180_gem_noc = {
 	.num_bcms = ARRAY_SIZE(gem_noc_bcms),
 };

-static struct qcom_icc_bcm *ipa_virt_bcms[] = {
-	&bcm_ip0,
-};
-
-static struct qcom_icc_node *ipa_virt_nodes[] = {
-	[MASTER_IPA_CORE] = &ipa_core_master,
-	[SLAVE_IPA_CORE] = &ipa_core_slave,
-};
-
-static struct qcom_icc_desc sc7180_ipa_virt = {
-	.nodes = ipa_virt_nodes,
-	.num_nodes = ARRAY_SIZE(ipa_virt_nodes),
-	.bcms = ipa_virt_bcms,
-	.num_bcms = ARRAY_SIZE(ipa_virt_bcms),
-};
-
 static struct qcom_icc_bcm *mc_virt_bcms[] = {
 	&bcm_acv,
 	&bcm_mc0,
@@ -519,8 +500,6 @@ static const struct of_device_id qnoc_of_match[] = {
 	  .data = &sc7180_dc_noc},
 	{ .compatible = "qcom,sc7180-gem-noc",
 	  .data = &sc7180_gem_noc},
-	{ .compatible = "qcom,sc7180-ipa-virt",
-	  .data = &sc7180_ipa_virt},
 	{ .compatible = "qcom,sc7180-mc-virt",
 	  .data = &sc7180_mc_virt},
 	{ .compatible = "qcom,sc7180-mmss-noc",

----8<----

[1] https://lore.kernel.org/r/154411934006.88331.2149751521264448532@swboyd.mtv.corp.google.com
