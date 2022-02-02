Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AADFA4A6E12
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 10:48:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245576AbiBBJsz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Feb 2022 04:48:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245565AbiBBJsx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 04:48:53 -0500
Received: from relay07.th.seeweb.it (relay07.th.seeweb.it [IPv6:2001:4b7a:2000:18::168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 964E0C06173B
        for <linux-kernel@vger.kernel.org>; Wed,  2 Feb 2022 01:48:53 -0800 (PST)
Received: from SoMainline.org (94-209-165-62.cable.dynamic.v4.ziggo.nl [94.209.165.62])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by m-r2.th.seeweb.it (Postfix) with ESMTPSA id A34393F7D3;
        Wed,  2 Feb 2022 10:48:51 +0100 (CET)
Date:   Wed, 2 Feb 2022 10:48:50 +0100
From:   Marijn Suijten <marijn.suijten@somainline.org>
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Martin Botka <martin.botka@somainline.org>,
        Jami Kettunen <jami.kettunen@somainline.org>,
        Pavel Dubrova <pashadubrova@gmail.com>,
        Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Abhinav Kumar <abhinavk@codeaurora.org>,
        Zhen Lei <thunder.leizhen@huawei.com>,
        Bernard <bernard@vivo.com>, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/msm/dpu: Bind pingpong block to intf on active ctls
 in cmd encoder
Message-ID: <20220202094850.2asbry44vyh5xw2p@SoMainline.org>
Mail-Followup-To: Marijn Suijten <marijn.suijten@somainline.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
        AngeloGioacchino Del Regno <angelogioacchino.delregno@somainline.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Martin Botka <martin.botka@somainline.org>,
        Jami Kettunen <jami.kettunen@somainline.org>,
        Pavel Dubrova <pashadubrova@gmail.com>,
        Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>,
        David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Abhinav Kumar <abhinavk@codeaurora.org>,
        Zhen Lei <thunder.leizhen@huawei.com>, Bernard <bernard@vivo.com>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20211222105513.44860-1-marijn.suijten@somainline.org>
 <84bd598c-b1b7-984e-9fa1-94ad28087ef0@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <84bd598c-b1b7-984e-9fa1-94ad28087ef0@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-01-20 02:12:51, Dmitry Baryshkov wrote:
> On 22/12/2021 13:55, Marijn Suijten wrote:
> > As per the specification of DPU_CTL_ACTIVE_CFG the configuration of
> > active blocks should be proactively specified, and the pingpong block is
> > no different.
> > 
> > The downstream display driver [1] confirms this by also calling
> > bind_pingpong_blk on CTL_ACTIVE_CFG.  Note that this else-if is always
> > entered, as setup_intf_cfg - unlike this mainline dpu driver that
> > combines both behind the same function pointer - is left NULL in favour
> > of using setup_intf_cfg_v1 when CTL_ACTIVE_CFG is set.
> > 
> > This solves continuous timeouts on at least the Qualcomm sm6125 SoC:
> > 
> >      [drm:dpu_encoder_frame_done_timeout:2091] [dpu error]enc31 frame done timeout
> >      [drm:_dpu_encoder_phys_cmd_handle_ppdone_timeout.isra.0] *ERROR* id:31 pp:0 kickoff timeout 0 cnt 1 koff_cnt 1
> >      [drm:dpu_encoder_phys_cmd_prepare_for_kickoff] *ERROR* failed wait_for_idle: id:31 ret:-110 pp:0
> > 
> > In the same way this pingpong block should also be unbound followed by
> > an interface flush when the encoder is disabled, according to the
> > downstream display driver [2].
> > 
> > [1]: https://source.codeaurora.org/quic/la/platform/vendor/opensource/display-drivers/tree/msm/sde/sde_encoder_phys_cmd.c?h=LA.UM.9.16.r1-08500-MANNAR.0#n167
> > [2]: https://source.codeaurora.org/quic/la/platform/vendor/opensource/display-drivers/tree/msm/sde/sde_encoder.c?h=LA.UM.9.16.r1-08500-MANNAR.0#n2986
> > 
> > Signed-off-by: Marijn Suijten <marijn.suijten@somainline.org>
> > Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@somainline.org>
> 
> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> 
> > ---
> >   .../drm/msm/disp/dpu1/dpu_encoder_phys_cmd.c  | 21 +++++++++++++++++++
> >   1 file changed, 21 insertions(+)
> > 
> > diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_cmd.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_cmd.c
> > index 8e433af7aea4..e0e08a874f07 100644
> > --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_cmd.c
> > +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_cmd.c
> > @@ -71,6 +71,13 @@ static void _dpu_encoder_phys_cmd_update_intf_cfg(
> >   	intf_cfg.stream_sel = cmd_enc->stream_sel;
> >   	intf_cfg.mode_3d = dpu_encoder_helper_get_3d_blend_mode(phys_enc);
> >   	ctl->ops.setup_intf_cfg(ctl, &intf_cfg);
> > +
> > +	/* setup which pp blk will connect to this intf */
> > +	if (test_bit(DPU_CTL_ACTIVE_CFG, &ctl->caps->features) && phys_enc->hw_intf->ops.bind_pingpong_blk)
> 
> Nit: here we bind all interfaces, but later we unbind only master. Is 
> this correct?

Not sure: it seems downstream only calls
_sde/dpu_encoder_phys_cmd_update_intf_cfg when it is _not_ a ppsplit
slave, which appears to be very similar to being the master (both check
for ENC_ROLE_SLAVE but ppsplit also checks RM topology support for
ppsplit).  Should we do this too before calling
_dpu_encoder_phys_cmd_update_intf_cfg?

- Marijn

> > +		phys_enc->hw_intf->ops.bind_pingpong_blk(
> > +				phys_enc->hw_intf,
> > +				true,
> > +				phys_enc->hw_pp->idx);
> >   }
> >   
> >   static void dpu_encoder_phys_cmd_pp_tx_done_irq(void *arg, int irq_idx)
> > @@ -507,6 +514,7 @@ static void dpu_encoder_phys_cmd_disable(struct dpu_encoder_phys *phys_enc)
> >   {
> >   	struct dpu_encoder_phys_cmd *cmd_enc =
> >   		to_dpu_encoder_phys_cmd(phys_enc);
> > +	struct dpu_hw_ctl *ctl;
> >   
> >   	if (!phys_enc->hw_pp) {
> >   		DPU_ERROR("invalid encoder\n");
> > @@ -523,6 +531,19 @@ static void dpu_encoder_phys_cmd_disable(struct dpu_encoder_phys *phys_enc)
> >   
> >   	if (phys_enc->hw_pp->ops.enable_tearcheck)
> >   		phys_enc->hw_pp->ops.enable_tearcheck(phys_enc->hw_pp, false);
> > +
> > +	if (dpu_encoder_phys_cmd_is_master(phys_enc)) {
> > +		if (phys_enc->hw_intf->ops.bind_pingpong_blk) {
> > +			phys_enc->hw_intf->ops.bind_pingpong_blk(
> > +					phys_enc->hw_intf,
> > +					false,
> > +					phys_enc->hw_pp->idx);
> > +
> > +			ctl = phys_enc->hw_ctl;
> > +			ctl->ops.update_pending_flush_intf(ctl, phys_enc->intf_idx);
> > +		}
> > +	}
> > +
> >   	phys_enc->enable_state = DPU_ENC_DISABLED;
> >   }
> >   
> 
> 
> -- 
> With best wishes
> Dmitry
