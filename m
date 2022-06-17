Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94F0C54EE41
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jun 2022 02:02:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378754AbiFQAC1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 20:02:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232134AbiFQAC0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 20:02:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9207462BFB;
        Thu, 16 Jun 2022 17:02:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F38296177D;
        Fri, 17 Jun 2022 00:02:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4114EC34114;
        Fri, 17 Jun 2022 00:02:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655424144;
        bh=WNWSMCR6kMKCT8Lah0iyiGB+iQKBw5vkV13FcXm2+h4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PpbFUKUM09OJQhDucoAN6cA6N69t0R1Wy7GrqioQMhRKQLaAeCHmwxVESLaUNUux1
         EJJTUN/HvE89Pn1elln+TC2v8mse38pBoxXjBgtXIaTw7wlJ9B5Da92Zfj3Q+Qp9K9
         xUvtCjn4lHemORO83jKvVDGWSiIydGpB0Ov2CcVRRolzO1LMj05bNM3weApWLjnN3r
         lPRwOyGNCT5CBqRBbuz3lJM60L9hLho20711irccc9ksbAvwcFECeCD5ajVakWqH9u
         J2kV8gRkE2Up8xnfuvOuUdvqBKegFszzaTyIIr5X+6p1XBJoSJVHBG51kSf/dOj0DK
         RimX/no99Vb5g==
Date:   Thu, 16 Jun 2022 17:02:23 -0700
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
Message-ID: <YqvEjzgSbvrOCFtq@matsya>
References: <1653512540-21956-1-git-send-email-quic_khsieh@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1653512540-21956-1-git-send-email-quic_khsieh@quicinc.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25-05-22, 14:02, Kuogee Hsieh wrote:
> 1) add regulator_set_load() to eDP phy
> 2) add regulator_set_load() to DP phy
> 3) remove vdda related function out of eDP/DP controller
> 
> Kuogee Hsieh (3):
>   phy: qcom-edp: add regulator_set_load to edp phy
>   phy: qcom-qmp: add regulator_set_load to dp phy
>   drm/msm/dp: delete vdda regulator related functions from eDP/DP
>     controller
> 
>  drivers/gpu/drm/msm/dp/dp_parser.c  | 14 ------
>  drivers/gpu/drm/msm/dp/dp_parser.h  |  8 ----
>  drivers/gpu/drm/msm/dp/dp_power.c   | 95 +------------------------------------
>  drivers/phy/qualcomm/phy-qcom-edp.c | 12 +++++
>  drivers/phy/qualcomm/phy-qcom-qmp.c | 40 ++++++++++++----

Please rebase this to phy-next and apply to specific qmp phy driver...

-- 
~Vinod
