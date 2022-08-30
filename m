Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 426195A5AD1
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 06:36:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229675AbiH3EgM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 00:36:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbiH3EgJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 00:36:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8ABB978233;
        Mon, 29 Aug 2022 21:36:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0B808611DA;
        Tue, 30 Aug 2022 04:36:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85B12C433D6;
        Tue, 30 Aug 2022 04:36:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661834165;
        bh=M5yG2yTFswgWexgNhMPM7W1/h1WPqfE4dGt85x2Ogls=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=V87okQhwG7UDqSnF8GLIb/Aqt2Ig1X+KyVJezb7nrkUeVx9PiVFad8Y4HIvC9yP9Y
         Zx582UPhmxVtJpOA/Nwu+Qf/k1NhKre/OXxO7bBc/jhOfYX+NdqzfCzUFX7CTjLNPc
         pwGOB+y2y20HVfcMRJEplQdI4wAo4X9w4xoRytDMx9bFYsDc904F8q8vjH9mKOrpNw
         xFyf3Qki+Kf1CN3hQXESPv6Pqlgb5fP55VYjVxPe+XopDM79aeS7irGvxZPza4W2E8
         IdWidQ72Fx52rVcNEGnpBDMDMJOeHNgq8y4PLo6HAx+2PLU4npEIdy9yD16UZsZ0bx
         QKSE9mO7Kiibg==
Date:   Tue, 30 Aug 2022 10:06:00 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     David Collins <quic_collinsd@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        David Dai <daidavid1@codeaurora.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/2] spmi: pmic-arb: Add support for PMIC v7
Message-ID: <Yw2TsARPfuCLvDg0@matsya>
References: <20220201134108.2677578-1-vkoul@kernel.org>
 <YhUVAwtfjuIdKrRQ@matsya>
 <1c66890b-6736-61ef-7d16-619f90ced4a0@linaro.org>
 <4f1ae43c-0f22-19fe-0794-3cc268104396@linaro.org>
 <20220829222601.47241C433C1@smtp.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220829222601.47241C433C1@smtp.kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29-08-22, 15:25, Stephen Boyd wrote:
> Quoting Dmitry Baryshkov (2022-06-18 08:29:58)
> > On 01/05/2022 22:41, Dmitry Baryshkov wrote:
> > > On 22/02/2022 19:53, Vinod Koul wrote:
> > >> On 01-02-22, 19:11, Vinod Koul wrote:
> > >>> Hello,
> > >>>
> > >>> The is version 3 of support for PMIC v7. I have added a new property
> > >>> qcom,bus-id for supporting v7 and then add driver changes for v7
> > >>>
> > >>> This depends on yaml conversion patch:
> > >>> https://lore.kernel.org/linux-arm-msm/20211227170151.73116-1-david@ixit.cz/ 
> > >>>
> > >>
> > >> Any feedback on this...
> > > 
> > > Another gracious reminder about these patches. At this moment this is 
> > > one of the important pieces lacking for the full SM8450 support in the 
> > > upstream kernel.
> > 
> > Stephen, yet another ping. This is the blocking point for the further 
> > SM8450 progress.
> > 
> 
> Sorry I completely missed this one as it fell off the end of my inbox
> into the abyss.

Thanks for the reply. Is this applied now or you have some feedback for
me to address..

Thanks
-- 
~Vinod
