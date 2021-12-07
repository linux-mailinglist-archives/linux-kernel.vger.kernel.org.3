Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70E7846BA71
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 12:52:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235897AbhLGL4I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 06:56:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231187AbhLGL4H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 06:56:07 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4845FC061574;
        Tue,  7 Dec 2021 03:52:37 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0E9A7B8175A;
        Tue,  7 Dec 2021 11:52:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE21CC341C1;
        Tue,  7 Dec 2021 11:52:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638877954;
        bh=VHf4DnNJqOqa2oPgFh/UVmimHU3NnqH8s5SeAmJ97wk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=E4/N3oMLYGxGDJgjgvkuvMQqK7r6i8HJfAP3ecLJPNiH+XetJY2K5+G2k2W3Cyjx3
         ePi3uI91xvqU/uN5A5CAxNLconsW/Y8BGNxAc/BuY0SmwVcaQL48ksWM4vBVcnhLvM
         Oxm8xIr42O/PjXK9v3q4ON7ZHUk6Xz9EAWr3emm+Oc7e8CYy1jMh1oPHZSFzVvAmTo
         AoPKiswOrQm2SJatH77/OWbUW74hi3dwMF2TYDwaq0wQQg6WXKHzR5honObndh+pP7
         ZfOnXN1bo4olWz1iNzUjWXaTiofYHj7d9IDsb7JXzSbD5WQSCaqMdlNI8FqUmR4WKG
         6DXEWB/g1dynA==
Date:   Tue, 7 Dec 2021 17:22:30 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     David Collins <quic_collinsd@quicinc.com>
Cc:     Stephen Boyd <sboyd@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-arm-msm@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Subbaraman Narayanamurthy <quic_subbaram@quicinc.com>
Subject: Re: [PATCH] spmi: pmic-arb: Add support for PMIC v7
Message-ID: <Ya9K/sF1YDCYCp2Y@matsya>
References: <20211201072718.3969011-1-vkoul@kernel.org>
 <20211202230624.C05F3C00446@smtp.kernel.org>
 <9161450a-40e0-c84f-f529-c903d6f1d722@quicinc.com>
 <20211203031323.211E5C00446@smtp.kernel.org>
 <1fb0553b-eca5-a537-4dc3-77437feffc69@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1fb0553b-eca5-a537-4dc3-77437feffc69@quicinc.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03-12-21, 16:45, David Collins wrote:
> On 12/2/21 7:13 PM, Stephen Boyd wrote:
> > Quoting David Collins (2021-12-02 15:51:18)
> >> On 12/2/21 3:06 PM, Stephen Boyd wrote:
> >>> Quoting Vinod Koul (2021-11-30 23:27:18)

> > It feels like we should make a parent node that holds the core, chnls,
> > obsrvr reg properties with a new compatible string and then have two
> > child nodes for each bus. Then the various PMICs can hang off those two
> > different bus nodes. Of course, it needs DT review to make sure nothing
> > else goes wrong.
> 
> We considered this alternative DT layout when implementing PMIC arbiter
> v7 support downstream.  The benefit is allowing common register ranges
> to be specified once instead of in both SPMI bus nodes.  However, this
> approach has several downsides.
> 
> It results in substantially more complex device tree binding
> documentation that requires a different layout for SPMI buses for PMIC
> arbiter v7 (and above) vs early versions even though support can be
> provided with only a minimal modification (i.e. "qcom,bus-id").
> Complexity is also increased inside of the spmi-pmic-arb driver.  There,
> special data structures and logic would be needed to handle the shared
> vs independent register addresses and data.
> 
> The SPMI framework currently uses a one-to-one mapping between SPMI
> buses and struct device pointers.  This would not work if the new
> top-level node represents the true struct device and the per-bus
> subnodes are not true devices.  Also, platform_get_resource_byname()
> (used in the spmi-pmic-arb probe function) needs a struct
> platform_device pointer to read address ranges using "reg" +
> "reg-names".  That wouldn't work for the subnodes.
> 
> I suppose that "compatible" could be specified for the top-level node
> and the per bus subnodes so that all three get probed as struct devices.
>  However, that makes things even more complicated and convoluted in the
> driver (and DT).
> 
> I would prefer to stay with the approach of the two bus instances being
> specified independently in DT.
> 
> Note that the clk-imx8qxp-lpcg driver has a similar situation where
> multiple drivers need to map addresses in the same region.  Commit [1]
> documents the requirement.  The details of the problem where
> devm_platform_ioremap_resource() cannot be used in place of
> devm_ioremap() were discussed in this thread [2].

Steve, David,

Is this the way we are recommending for this to be move forward with?

-- 
~Vinod
