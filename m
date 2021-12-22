Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0070947D05A
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Dec 2021 11:55:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244309AbhLVKz0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Dec 2021 05:55:26 -0500
Received: from relay02.th.seeweb.it ([5.144.164.163]:42237 "EHLO
        relay02.th.seeweb.it" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234994AbhLVKzZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Dec 2021 05:55:25 -0500
Received: from Marijn-Arch-PC.localdomain (94-209-165-62.cable.dynamic.v4.ziggo.nl [94.209.165.62])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by m-r1.th.seeweb.it (Postfix) with ESMTPSA id B7BB520045;
        Wed, 22 Dec 2021 11:55:21 +0100 (CET)
From:   Marijn Suijten <marijn.suijten@somainline.org>
To:     phone-devel@vger.kernel.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Martin Botka <martin.botka@somainline.org>,
        Jami Kettunen <jami.kettunen@somainline.org>,
        Pavel Dubrova <pashadubrova@gmail.com>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Abhinav Kumar <abhinavk@codeaurora.org>,
        Zhen Lei <thunder.leizhen@huawei.com>,
        Bernard <bernard@vivo.com>, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] drm/msm/dpu: Bind pingpong block to intf on active ctls in cmd encoder
Date:   Wed, 22 Dec 2021 11:55:12 +0100
Message-Id: <20211222105513.44860-1-marijn.suijten@somainline.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As per the specification of DPU_CTL_ACTIVE_CFG the configuration of
active blocks should be proactively specified, and the pingpong block is
no different.

The downstream display driver [1] confirms this by also calling
bind_pingpong_blk on CTL_ACTIVE_CFG.  Note that this else-if is always
entered, as setup_intf_cfg - unlike this mainline dpu driver that
combines both behind the same function pointer - is left NULL in favour
of using setup_intf_cfg_v1 when CTL_ACTIVE_CFG is set.

This solves continuous timeouts on at least the Qualcomm sm6125 SoC:

    [drm:dpu_encoder_frame_done_timeout:2091] [dpu error]enc31 frame done timeout
    [drm:_dpu_encoder_phys_cmd_handle_ppdone_timeout.isra.0] *ERROR* id:31 pp:0 kickoff timeout 0 cnt 1 koff_cnt 1
    [drm:dpu_encoder_phys_cmd_prepare_for_kickoff] *ERROR* failed wait_for_idle: id:31 ret:-110 pp:0

In the same way this pingpong block should also be unbound followed by
an interface flush when the encoder is disabled, according to the
downstream display driver [2].

[1]: https://source.codeaurora.org/quic/la/platform/vendor/opensource/display-drivers/tree/msm/sde/sde_encoder_phys_cmd.c?h=LA.UM.9.16.r1-08500-MANNAR.0#n167
[2]: https://source.codeaurora.org/quic/la/platform/vendor/opensource/display-drivers/tree/msm/sde/sde_encoder.c?h=LA.UM.9.16.r1-08500-MANNAR.0#n2986

Signed-off-by: Marijn Suijten <marijn.suijten@somainline.org>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@somainline.org>
---
 .../drm/msm/disp/dpu1/dpu_encoder_phys_cmd.c  | 21 +++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_cmd.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_cmd.c
index 8e433af7aea4..e0e08a874f07 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_cmd.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_cmd.c
@@ -71,6 +71,13 @@ static void _dpu_encoder_phys_cmd_update_intf_cfg(
 	intf_cfg.stream_sel = cmd_enc->stream_sel;
 	intf_cfg.mode_3d = dpu_encoder_helper_get_3d_blend_mode(phys_enc);
 	ctl->ops.setup_intf_cfg(ctl, &intf_cfg);
+
+	/* setup which pp blk will connect to this intf */
+	if (test_bit(DPU_CTL_ACTIVE_CFG, &ctl->caps->features) && phys_enc->hw_intf->ops.bind_pingpong_blk)
+		phys_enc->hw_intf->ops.bind_pingpong_blk(
+				phys_enc->hw_intf,
+				true,
+				phys_enc->hw_pp->idx);
 }
 
 static void dpu_encoder_phys_cmd_pp_tx_done_irq(void *arg, int irq_idx)
@@ -507,6 +514,7 @@ static void dpu_encoder_phys_cmd_disable(struct dpu_encoder_phys *phys_enc)
 {
 	struct dpu_encoder_phys_cmd *cmd_enc =
 		to_dpu_encoder_phys_cmd(phys_enc);
+	struct dpu_hw_ctl *ctl;
 
 	if (!phys_enc->hw_pp) {
 		DPU_ERROR("invalid encoder\n");
@@ -523,6 +531,19 @@ static void dpu_encoder_phys_cmd_disable(struct dpu_encoder_phys *phys_enc)
 
 	if (phys_enc->hw_pp->ops.enable_tearcheck)
 		phys_enc->hw_pp->ops.enable_tearcheck(phys_enc->hw_pp, false);
+
+	if (dpu_encoder_phys_cmd_is_master(phys_enc)) {
+		if (phys_enc->hw_intf->ops.bind_pingpong_blk) {
+			phys_enc->hw_intf->ops.bind_pingpong_blk(
+					phys_enc->hw_intf,
+					false,
+					phys_enc->hw_pp->idx);
+
+			ctl = phys_enc->hw_ctl;
+			ctl->ops.update_pending_flush_intf(ctl, phys_enc->intf_idx);
+		}
+	}
+
 	phys_enc->enable_state = DPU_ENC_DISABLED;
 }
 
-- 
2.34.1

