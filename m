Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C685F4B98F0
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 07:11:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235191AbiBQGKh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 01:10:37 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:54068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235170AbiBQGKd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 01:10:33 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 811BDC7D49;
        Wed, 16 Feb 2022 22:10:09 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 17570616A4;
        Thu, 17 Feb 2022 06:10:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3767C340E8;
        Thu, 17 Feb 2022 06:10:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645078208;
        bh=i3fhCS7y6EEHohO6KNRuRf7uAzQv8fU9N54p/nBpQuw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nN7uM8xTOeEfeH3sIbZ7M6bnyYm46Skv29uEWZu0tUGdRPj9d2cYRFd59U2mss+oj
         VSHFt0sASkvxbrfxBUhQQnRNiNXb/5LBFWAXHsOIIgOGNDJa3Nav9RcFkjKtSPPdBf
         cBqQ+d194G7Yo0qUDvCTsEP4jU6LfhYiUQAr3ZYWh/g1PXHu/5Y96ncwadnOUrBLSS
         bWDNPhJlGwX1k6tURYjZ3cMMoqSUEssSyPd0zwID91fjv6pRAYXOUBUvbnYHVTiZ/+
         dpWKM230JCHLNqFCXbM8mwFLOT87isHWV3lwMA5s5QBI4NYLrR3k5lPxgOzEBu20Y/
         V28W70niycPVQ==
Date:   Thu, 17 Feb 2022 11:40:04 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Abhinav Kumar <quic_abhinavk@quicinc.com>
Cc:     Rob Clark <robdclark@gmail.com>, linux-arm-msm@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Jonathan Marek <jonathan@marek.ca>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Abhinav Kumar <abhinavk@codeaurora.org>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org
Subject: Re: [REPOST PATCH v4 08/13] drm/msm/disp/dpu1: Don't use DSC with
 mode_3d
Message-ID: <Yg3mvEvqYs89dJWI@matsya>
References: <20220210103423.271016-1-vkoul@kernel.org>
 <20220210103423.271016-9-vkoul@kernel.org>
 <67006cc4-3385-fe03-bb4d-58623729a8a8@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <67006cc4-3385-fe03-bb4d-58623729a8a8@quicinc.com>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16-02-22, 19:11, Abhinav Kumar wrote:
> 
> 
> On 2/10/2022 2:34 AM, Vinod Koul wrote:
> > We cannot enable mode_3d when we are using the DSC. So pass
> > configuration to detect DSC is enabled and not enable mode_3d
> > when we are using DSC
> > 
> > We add a helper dpu_encoder_helper_get_dsc() to detect dsc
> > enabled and pass this to .setup_intf_cfg()
> > 
> > Signed-off-by: Vinod Koul <vkoul@kernel.org>
> 
> We should not use 3D mux only when we use DSC merge topology.
> I agree that today we use only 2-2-1 topology for DSC which means its using
> DSC merge.
> 
> But generalizing that 3D mux should not be used for DSC is not right.
> 
> You can detect DSC merge by checking if there are two encoders and one
> interface in the topology and if so, you can disable 3D mux.

Right now with DSC we disable that as suggested by Dmitry last time.
Whenever we introduce merge we should revisit this, for now this should
suffice

-- 
~Vinod
