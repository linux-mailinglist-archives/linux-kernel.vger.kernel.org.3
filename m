Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91DC8566A69
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 13:58:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231461AbiGEL6Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 07:58:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231340AbiGEL6W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 07:58:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEF68383;
        Tue,  5 Jul 2022 04:58:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 732D6615BA;
        Tue,  5 Jul 2022 11:58:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C823CC341C7;
        Tue,  5 Jul 2022 11:58:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657022299;
        bh=lCXFzDOu/arhn1E7qbcpYeWsTGXEZM7HRnIjvJuXRQo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ItEhj+54jubFtuMGB8gFICe9Al+h8/22un5trpf08ioiYyvwAhcQzH8J88lV0U0Wk
         3kjJoLEbZ999TJifjmeJ2AwV3LE8AGTm5SW8a0VbWS/jRSxWRcs0MgbfYv6I3JUbY5
         oWlVK3xxkK0cuX9vrewGjpSUrtKS6NUGwyo5lmGSfYP/Etsm65PW47EAH8KnNNIBAK
         mbszHYkTs/pjmhQSLifETgm9myld2cOlwWOz7opBpUtW9M9iin29/e2On84my9D0dS
         iaLLBkRA28pyUz2XF0HEHioDPv/P3pqY+j6u2i3yZtvqyM5Gz223bCAimMTq9WM22o
         wp5tytzOK0tIg==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1o8hC7-000679-Jh; Tue, 05 Jul 2022 13:58:20 +0200
Date:   Tue, 5 Jul 2022 13:58:19 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Johan Hovold <johan+linaro@kernel.org>,
        Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 38/43] phy: qcom-qmp-pcie: drop pipe clock lane suffix
Message-ID: <YsQnW2o4eCU8PlWl@hovoldconsulting.com>
References: <20220705094239.17174-1-johan+linaro@kernel.org>
 <20220705094239.17174-39-johan+linaro@kernel.org>
 <dcff330c-92ec-2302-8e2a-4ac124e72942@linaro.org>
 <76508b56-6733-b65c-d81c-31ac173780c0@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <76508b56-6733-b65c-d81c-31ac173780c0@linaro.org>
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 05, 2022 at 02:13:04PM +0300, Dmitry Baryshkov wrote:
> On 05/07/2022 13:20, Krzysztof Kozlowski wrote:
> > On 05/07/2022 11:42, Johan Hovold wrote:
> >> The pipe clock is defined in the "lane" node so there's no need to keep
> >> adding a redundant lane-number suffix to the clock name.
> >>
> >> Drop the lane suffix from the pipe clock name, but continue supporting
> >> the legacy name as a fall back.
> >>
> >> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> >> ---
> >>   drivers/phy/qualcomm/phy-qcom-qmp-pcie.c | 8 ++++++--
> >>   1 file changed, 6 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c b/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
> >> index 385ea3d8de08..254ad25591b9 100644
> >> --- a/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
> >> +++ b/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
> >> @@ -2210,8 +2210,12 @@ int qcom_qmp_phy_pcie_create(struct device *dev, struct device_node *np, int id,
> >>   	if (!qphy->pcs_misc)
> >>   		dev_vdbg(dev, "PHY pcs_misc-reg not used\n");
> >>   
> >> -	snprintf(prop_name, sizeof(prop_name), "pipe%d", id);
> >> -	qphy->pipe_clk = devm_get_clk_from_child(dev, np, prop_name);
> >> +	qphy->pipe_clk = devm_get_clk_from_child(dev, np, "pipe");
> > 
> > Just get first clock and no need for handling any deprecation.

I still want to deprecate the current name as it makes no sense and
risks introducing inconsistencies when adding new resources (e.g. should
they also get a bogus suffix).

> If I got it correctly, passing NULL instead of the name would do the trick.

Ah, thanks for spotting that. I feared this would require adding a host
of new devres wrappers otherwise.

Would still be needed for the upcoming second pipediv2 clock though...

Johan
