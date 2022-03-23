Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B8B64E516B
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Mar 2022 12:39:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243905AbiCWLkr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Mar 2022 07:40:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232743AbiCWLkq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Mar 2022 07:40:46 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08F4A37BFA;
        Wed, 23 Mar 2022 04:39:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B7910B81E70;
        Wed, 23 Mar 2022 11:39:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E174BC340E8;
        Wed, 23 Mar 2022 11:39:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648035553;
        bh=UDCzleIC4xOZOO2WFtLxo96UlvhoU0EICO6OpjUHPUY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bd00Ph0sG5jxSCHtFN3wfyo7D7eOW7UKIg+ObY8tpcfafFg6dkimyLrxH00+1NAwJ
         FtdYY75mcDriYSZbbWBbpYpUz8MZAWRWnviq74ZH2LlzOCyvy/YOdENHoCFcCMdmBE
         hdNEJVXnHz+9XQBSyZR4gVdSxsZ7zH3VFwAfGjwroWuC5uNexfjsyfjmkJlPgcm++z
         Kda/mWNOPdNNtwQnhC7e1u2P0cdhvRe99cNVTB7NA2kqZLtIdrt9T1VxxaesomaBkp
         O6fOm7QuWHGxZ99hywJEfZ3J6GBk1vPdGG9OkXTX0tbIs7pQuTEsCfbpRTMOmdKstl
         vKjguYNIx+m8Q==
Date:   Wed, 23 Mar 2022 17:09:09 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Marijn Suijten <marijn.suijten@somainline.org>
Cc:     Rob Clark <robdclark@gmail.com>, linux-arm-msm@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Jonathan Marek <jonathan@marek.ca>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Abhinav Kumar <abhinavk@codeaurora.org>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org
Subject: Re: [REPOST PATCH v4 10/13] drm/msm/disp/dpu1: Add support for DSC
 in topology
Message-ID: <YjsG3epKhFpvdLxw@matsya>
References: <20220210103423.271016-1-vkoul@kernel.org>
 <20220210103423.271016-11-vkoul@kernel.org>
 <20220217223707.zsqdzu5uqplg33p2@SoMainline.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220217223707.zsqdzu5uqplg33p2@SoMainline.org>
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17-02-22, 23:37, Marijn Suijten wrote:
> On 2022-02-10 16:04:20, Vinod Koul wrote:
> > For DSC to work we typically need a 2,2,1 configuration. This should
> > suffice for resolutions up to 4k. For more resolutions like 8k this won't
> > work.
> > 
> > Also, it is better to use 2 LMs and DSC instances as half width results
> > in lesser power consumption as compared to single LM, DSC at full width.
> > 
> > The panel has been tested only with 2,2,1 configuration, so for
> > now we blindly create 2,2,1 topology when DSC is enabled
> > 
> > Co-developed-by: Abhinav Kumar <abhinavk@codeaurora.org>
> > Signed-off-by: Abhinav Kumar <abhinavk@codeaurora.org>
> > Signed-off-by: Vinod Koul <vkoul@kernel.org>
> > ---
> >  drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c | 13 +++++++++++++
> >  drivers/gpu/drm/msm/msm_drv.h               |  2 ++
> >  2 files changed, 15 insertions(+)
> > 
> > diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
> > index 95a7bf362e81..13ccb7b3cce5 100644
> > --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
> > +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
> > @@ -574,8 +574,21 @@ static struct msm_display_topology dpu_encoder_get_topology(
> >  	topology.num_enc = 0;
> >  	topology.num_intf = intf_count;
> >  
> > +	if (dpu_enc->dsc) {
> > +		/* In case of Display Stream Compression DSC, we would use
> 
> Just like elsewhere, since you wrote out Display Stream Compression,
> write the "DSC" abbreviation between parentheses ()?

Updated

-- 
~Vinod
