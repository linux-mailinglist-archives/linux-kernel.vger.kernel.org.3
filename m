Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 340E14F5B0D
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 12:41:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378376AbiDFKTr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 06:19:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239477AbiDFKQ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 06:16:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E69EFDAFF9;
        Tue,  5 Apr 2022 23:44:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8279061685;
        Wed,  6 Apr 2022 06:44:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F3BEC385A3;
        Wed,  6 Apr 2022 06:44:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649227451;
        bh=BJfgiIoQUQYLiIMc6u/jkdzzSqCbxhlaeFQX+3zNbYg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HYjekCYckPQzlYNTIu2rKllAWs8+5lcZdBvpLZ9xI5S8TRTJdcr5ttJmpzrvgTHqq
         eBOI+yY11Z3TJfcpG2JyiFMML5RGLQZJsboe9I9cTJW2Ci/Keo8fzQZrlMX9+bPIxk
         AneKP08C/7KyS3208//LaXSwa3QQlgkeONwROWpgAiYNlAFxBuTIrw8A3WPWPvibxK
         HsSwUsWha+bf7a+9bZ0PSFRY3uXveqsQ8JsThOC8+cr4nY85wQurMMEQ5RP1cJlBgD
         8RLXoGCs8CFKCBH9Jm/YxFpfluX7bvVavRQrfH460j6li/IMFTeYAGgBTxFJMxa/rE
         gvsdmmG1GQPOA==
Date:   Wed, 6 Apr 2022 12:14:07 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Rob Clark <robdclark@gmail.com>, linux-arm-msm@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Jonathan Marek <jonathan@marek.ca>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org
Subject: Re: [PATCH v6 14/14] drm/msm/dsi: Add support for DSC configuration
Message-ID: <Yk02t+sZS0I7heY3@matsya>
References: <20220404163436.956875-1-vkoul@kernel.org>
 <20220404163436.956875-15-vkoul@kernel.org>
 <f5fc9704-5c22-8c95-b6d6-e2c20145672c@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f5fc9704-5c22-8c95-b6d6-e2c20145672c@linaro.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06-04-22, 02:42, Dmitry Baryshkov wrote:
> On 04/04/2022 19:34, Vinod Koul wrote:
> > When DSC is enabled, we need to configure DSI registers accordingly and
> > configure the respective stream compression registers.
> > 
> > Add support to calculate the register setting based on DSC params and
> > timing information and configure these registers.
> > 
> > Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> > Signed-off-by: Vinod Koul <vkoul@kernel.org>
> > ---
> >   drivers/gpu/drm/msm/dsi/dsi_host.c | 98 +++++++++++++++++++++++++++++-
> >   1 file changed, 97 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/gpu/drm/msm/dsi/dsi_host.c b/drivers/gpu/drm/msm/dsi/dsi_host.c
> > index eb0be34add45..f3ed6c40b9e1 100644
> > --- a/drivers/gpu/drm/msm/dsi/dsi_host.c
> > +++ b/drivers/gpu/drm/msm/dsi/dsi_host.c
> > @@ -912,6 +912,65 @@ static void dsi_ctrl_config(struct msm_dsi_host *msm_host, bool enable,
> >   		dsi_write(msm_host, REG_DSI_CPHY_MODE_CTRL, BIT(0));
> >   }
> > +static void dsi_update_dsc_timing(struct msm_dsi_host *msm_host, bool is_cmd_mode, u32 hdisplay)
> > +{
> > +	struct msm_display_dsc_config *dsc = msm_host->dsc;
> > +	u32 reg, intf_width, reg_ctrl, reg_ctrl2;
> > +	u32 slice_per_intf, total_bytes_per_intf;
> > +	u32 pkt_per_line;
> > +	u32 bytes_in_slice;
> > +	u32 eol_byte_num;
> > +
> > +	/* first calculate dsc parameters and then program
> > +	 * compress mode registers
> > +	 */
> > +	intf_width = hdisplay;
> > +	slice_per_intf = DIV_ROUND_UP(intf_width, dsc->drm->slice_width);
> > +
> > +	/* If slice_per_pkt is greater than slice_per_intf
> > +	 * then default to 1. This can happen during partial
> > +	 * update.
> > +	 */
> > +	if (slice_per_intf > dsc->drm->slice_count)
> > +		dsc->drm->slice_count = 1;
> > +
> > +	slice_per_intf = DIV_ROUND_UP(hdisplay, dsc->drm->slice_width);
> > +	bytes_in_slice = DIV_ROUND_UP(dsc->drm->slice_width * dsc->drm->bits_per_pixel, 8);
> > +
> > +	dsc->drm->slice_chunk_size = bytes_in_slice;
> > +
> > +	total_bytes_per_intf = bytes_in_slice * slice_per_intf;
> > +
> > +	eol_byte_num = total_bytes_per_intf % 3;
> > +	pkt_per_line = slice_per_intf / dsc->drm->slice_count;
> > +
> > +	if (is_cmd_mode) /* packet data type */
> > +		reg = DSI_COMMAND_COMPRESSION_MODE_CTRL_STREAM0_DATATYPE(MIPI_DSI_DCS_LONG_WRITE);
> > +	else
> > +		reg = DSI_VIDEO_COMPRESSION_MODE_CTRL_DATATYPE(MIPI_DSI_COMPRESSED_PIXEL_STREAM);
> > +
> > +	/* DSI_VIDEO_COMPRESSION_MODE & DSI_COMMAND_COMPRESSION_MODE
> > +	 * registers have similar offsets, so for below common code use
> > +	 * DSI_VIDEO_COMPRESSION_MODE_XXXX for setting bits
> > +	 */
> > +	reg |= DSI_VIDEO_COMPRESSION_MODE_CTRL_PKT_PER_LINE(pkt_per_line >> 1);
> > +	reg |= DSI_VIDEO_COMPRESSION_MODE_CTRL_EOL_BYTE_NUM(eol_byte_num);
> > +	reg |= DSI_VIDEO_COMPRESSION_MODE_CTRL_EN;
> > +
> > +	if (is_cmd_mode) {
> > +		reg_ctrl = dsi_read(msm_host, REG_DSI_COMMAND_COMPRESSION_MODE_CTRL);
> > +		reg_ctrl2 = dsi_read(msm_host, REG_DSI_COMMAND_COMPRESSION_MODE_CTRL2);
> > +
> > +		reg_ctrl |= reg;
> > +		reg_ctrl2 |= DSI_COMMAND_COMPRESSION_MODE_CTRL2_STREAM0_SLICE_WIDTH(bytes_in_slice);
> > +
> > +		dsi_write(msm_host, REG_DSI_COMMAND_COMPRESSION_MODE_CTRL, reg);
> 
> reg_ctrl, as reported by testing robot

Yes, I did run W=1 check for the patches, with gcc I do not see this
warning :(

I have fixed and will send updated revision shortly

-- 
~Vinod
