Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 282BC5A5AFC
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 07:05:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229788AbiH3FFf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 01:05:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbiH3FFc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 01:05:32 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 039DD22BDD;
        Mon, 29 Aug 2022 22:05:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id BC921B811B2;
        Tue, 30 Aug 2022 05:05:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A914FC433D6;
        Tue, 30 Aug 2022 05:05:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661835928;
        bh=QByjyPDQTVmrZkD/ABp5KCdvC712AjaNKJc4hM/Cjuw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YHbhzdGT4HOapIGMSBNK3IXUrhMgOrVgg+FqjL4MABT2a3cFcx8UGZ9IC/hk1qiH7
         bOGMCfWG0R80VYZmsok11TsEsgqTglAY8k7hh8CFMGoNE6Oms4UWLHu4BceaajEfPR
         OE13tRQxsC/tE6S49nCsQ0N3ryRgrN8L7S69Z1hE1D6fnxr/Q5RzjHZXu0TzvcAW61
         Sjbh21VCC5/4xlK/zyMYcVjamxvfVuU7p4Eiq3k9lFVcUTzgi1VxagAExwq0X6ymtv
         HxzPRUOayDI2kALXkY43eIelhApzL732Scv8m3IWvZHzh3DxH3jMKjruBrvA2zCw02
         Km5bM8AqUrXWw==
Date:   Tue, 30 Aug 2022 10:35:24 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Johan Hovold <johan@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 00/30] phy: qcom,qmp: fix dt-bindings and deprecate
 lane suffix
Message-ID: <Yw2alI4lV7aIsA/o@matsya>
References: <20220714124333.27643-1-johan+linaro@kernel.org>
 <YtVPX2WHKU61MTo5@hovoldconsulting.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YtVPX2WHKU61MTo5@hovoldconsulting.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18-07-22, 14:17, Johan Hovold wrote:
> On Thu, Jul 14, 2022 at 02:43:03PM +0200, Johan Hovold wrote:
> > When adding support for SC8280XP to the QMP PHY driver I noticed that
> > the PHY provider child node was not described by the current DT schema.
> > 
> > The SC8280XP PHYs also need a second fixed-divider PIPE clock
> > ("pipediv2") and I didn't want to have to add a bogus "lane" suffix to
> > the clock name just to match the current "pipe0" name so I decided to
> > deprecate the unnecessary suffix in the current binding instead.
> > 
> > To be able to add the missing child-node schema and handle device
> > specifics like additional PIPE clocks, it quickly became obvious that
> > the binding needs to be split up.
> > 
> > This series clean up and fixes some issue with the current schema before
> > splitting it up in separate schemas for PCIe, UFS and USB and adding
> > missing parts like the child PHY provider nodes.
> > 
> > The MSM8996 PCIe PHY gets its own schema as this is the only non-combo
> > PHY that actually provides more than one PHY per IP block. Note that the
> > "lane" suffix is still unnecessary and misleading.
> > 
> > The final patches add support for the updated binding to the (recently
> > split up) PHY drivers. Included is also a related combo PHY cleanup.
> 
> Hi Vinod,
> 
> any chance of getting these into 5.20?
> 
> Note that there'll be an -rc8 on Sunday.

Sorry phy tree goes thru char-misc and it was already sent and closed,
so couldnt do the needful

-- 
~Vinod
