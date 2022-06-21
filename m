Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13687552A5A
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 06:41:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344366AbiFUElp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 00:41:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233633AbiFUElm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 00:41:42 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 547D91FCCB;
        Mon, 20 Jun 2022 21:41:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id DA9E6B811BD;
        Tue, 21 Jun 2022 04:41:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE615C3411D;
        Tue, 21 Jun 2022 04:41:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655786499;
        bh=nM5Ncu4DzAKAp2OYDGK4cJt8P9gyd3/R9Q7YtZK7zWQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=s9NLOnL0OUJZ+pCJHDYG1PbLQ5Y20ijxniiK6cmkV+dMc+H7f1VFfbiCDd6H8oeuM
         ZO57bqSvj1amVwI9FFeuAm2GzGh253Rr5ABVZ1MorTNXW6fpcqvS1doU4Z7UWbux1i
         HSAgWuQJxrUu2J9RUD4YSBL090pwIt+q2FUI4gRa0Rsfka97zuwQZcSy4dOK4Kzdz/
         22SzO1L2eOsjdwAt2BpqwPyYfQlSRwCsq9IxvKLqcKw0t+vU6rnGOhlfDVjJ3B9Yf/
         MEHvUh4W1gpCP59ZTv2lMJifen/5lpsdCcpxtiWL7/auFy26xcwlq7jUs2OszGr/7n
         dj28Auekh8tQg==
Date:   Tue, 21 Jun 2022 10:11:35 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Kuogee Hsieh <quic_khsieh@quicinc.com>
Cc:     dri-devel@lists.freedesktop.org, robdclark@gmail.com,
        sean@poorly.run, swboyd@chromium.org, dianders@chromium.org,
        daniel@ffwll.ch, airlied@linux.ie, agross@kernel.org,
        dmitry.baryshkov@linaro.org, bjorn.andersson@linaro.org,
        quic_abhinavk@quicinc.com, quic_aravindh@quicinc.com,
        quic_sbillaka@quicinc.com, freedreno@lists.freedesktop.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v13 0/3] eDP/DP Phy vdda realted function
Message-ID: <YrFL/9Fu/WZXa2EI@matsya>
References: <1653512540-21956-1-git-send-email-quic_khsieh@quicinc.com>
 <YqvEjzgSbvrOCFtq@matsya>
 <6f1ade9f-38b0-827c-667b-5c8018b7779a@quicinc.com>
 <af23976a-11dc-2503-66ea-8558fc1b3108@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <af23976a-11dc-2503-66ea-8558fc1b3108@quicinc.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20-06-22, 13:43, Kuogee Hsieh wrote:
> 
> On 6/20/2022 1:07 PM, Kuogee Hsieh wrote:
> > 
> > On 6/16/2022 5:02 PM, Vinod Koul wrote:
> > > On 25-05-22, 14:02, Kuogee Hsieh wrote:
> > > > 1) add regulator_set_load() to eDP phy
> > > > 2) add regulator_set_load() to DP phy
> > > > 3) remove vdda related function out of eDP/DP controller
> > > > 
> > > > Kuogee Hsieh (3):
> > > >    phy: qcom-edp: add regulator_set_load to edp phy
> > > >    phy: qcom-qmp: add regulator_set_load to dp phy
> > > >    drm/msm/dp: delete vdda regulator related functions from eDP/DP
> > > >      controller
> > > > 
> > > >   drivers/gpu/drm/msm/dp/dp_parser.c  | 14 ------
> > > >   drivers/gpu/drm/msm/dp/dp_parser.h  |  8 ----
> > > >   drivers/gpu/drm/msm/dp/dp_power.c   | 95
> > > > +------------------------------------
> > > >   drivers/phy/qualcomm/phy-qcom-edp.c | 12 +++++
> > > >   drivers/phy/qualcomm/phy-qcom-qmp.c | 40 ++++++++++++----
> > > Please rebase this to phy-next and apply to specific qmp phy driver...
> > I will rebase to ==>
> > https://git.kernel.org/pub/scm/linux/kernel/git/phy/linux-phy.git
> 
> Hi Vinod,
> 
> Would you please specify exactly procedures i have to do as to rebase this
> patch series to phy=next tree.

Yes pls rebase to above tree and next branch

-- 
~Vinod
