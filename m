Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8493B4B9D9C
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 11:51:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239350AbiBQKv5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 05:51:57 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:44198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233717AbiBQKvy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 05:51:54 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 342A415A1C;
        Thu, 17 Feb 2022 02:51:41 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C4AF261E02;
        Thu, 17 Feb 2022 10:51:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8392BC340E8;
        Thu, 17 Feb 2022 10:51:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645095100;
        bh=cBpyatwdFGvOfC6HlRDqaMPvmaC9LzMnO4rFf5lGpwk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XCgHma6Qc2q/bG0IQaHPXUfhaCrXd6Z9p4kXNM4saS+TvkwbBevv1mdEI2GHPw9B+
         Ke5rn1yIrWk5IXJK3z9OokRkCPhbpn74QVX3pCPNtVK5hXVbhwkxDnl2sZEg5PkXrG
         T5Afg9Y2oDd0mjCs/4Eal+5iAGm+f0zZQbjB9RDG1zNdXJLw2SZDp+qxnkvtdjKgsw
         /cJVuAp7HNe4RhdahVNSnHpTS1kicI/V8YttEY0KNZn2AQy7jpUG6FzP1V6jewchcI
         nLMoYv9HzFkKLoSWJHdAdi9/9zChOA5aVOyEtgFWOT6dX8wbbeTJs0DpqCTJ6BjAII
         cQYHgGbb+Mu5w==
Date:   Thu, 17 Feb 2022 16:21:35 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Marijn Suijten <marijn.suijten@somainline.org>
Cc:     Jonathan Marek <jonathan@marek.ca>,
        David Airlie <airlied@linux.ie>, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Abhinav Kumar <abhinavk@codeaurora.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Clark <robdclark@gmail.com>,
        dri-devel@lists.freedesktop.org, Daniel Vetter <daniel@ffwll.ch>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        freedreno@lists.freedesktop.org
Subject: Re: [Freedreno] [REPOST PATCH v4 13/13] drm/msm/dsi: Add support for
 DSC configuration
Message-ID: <Yg4otzVk3HlA8rlE@matsya>
References: <20220210103423.271016-1-vkoul@kernel.org>
 <20220210103423.271016-14-vkoul@kernel.org>
 <20220217092707.2bfzga74xyicl4kb@SoMainline.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220217092707.2bfzga74xyicl4kb@SoMainline.org>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marijn,

On 17-02-22, 10:27, Marijn Suijten wrote:
> Vinod,
> 
> On 2022-02-10 16:04:23, Vinod Koul wrote:
> > When DSC is enabled, we need to configure DSI registers accordingly and
> > configure the respective stream compression registers.
> > 
> > Add support to calculate the register setting based on DSC params and
> > timing information and configure these registers.
> > 
> > Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> > Signed-off-by: Vinod Koul <vkoul@kernel.org>
> 
> I supplied a rather extensive - yet merely scratching the surface -
> review of this patch in:
> 
>     https://lore.kernel.org/linux-arm-msm/20211211000315.pavmcc7cc73ilb6l@SoMainline.org/

Sorry somehow I seem to have overlooked this one.
> 
> It seems none of those points have been addressed, bar creating a mesa
> MR to update dsi.xml with a subpar description of the registers (offsets
> only).

Mesa MR was planned as we get more closer to having reviews.

> For every point that is intentionally ignored, please at least supply a
> justification of why you think this is the right thing to do.

Ofcourse, i will reply to these now and address as required.

-- 
~Vinod
