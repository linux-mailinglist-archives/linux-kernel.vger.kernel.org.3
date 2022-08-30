Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1ABA85A5E0C
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 10:27:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231495AbiH3I1e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 04:27:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231469AbiH3I1b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 04:27:31 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C6ABA50C6;
        Tue, 30 Aug 2022 01:27:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0B0BFB816E4;
        Tue, 30 Aug 2022 08:27:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4399BC433D6;
        Tue, 30 Aug 2022 08:27:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661848047;
        bh=cYROqscLQov2FurMStlbmEPq+s+/Ghnc6Lk9jgwdSLg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DLYXaxJ9jZ7iYH+AC08yMXUwAYG0g/XXQIvgF/Mgszi3ptLtgfqRXemuCyiyYVF8s
         KF34WU73D2dh/BYUuBObTHIE9j0lZIAkLtf2wkCABSyYATZ9jjtgbAU1PMc5nOmDOr
         nuPmbJn+en7E7iYTlPBwruYZw8XvFnTEOPURkPou5JOmNYppNQD+jHBZY4mLx+ZW1n
         ZVyb2EWYwKSpN7IT12oZR121EbGlTUWKgPHeWqfkqhTN2psS+sIZzAt8UjDccx4hh0
         GLn/9eX+Vv/YyvT6Kn6dnJlIxzYiGjfXg6Adkm2mrNOUJ7xkm1ml+gipJk8f6dk4ou
         ZozQiJTbNNfPA==
Date:   Tue, 30 Aug 2022 13:57:23 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Johan Hovold <johan@kernel.org>
Cc:     Johan Hovold <johan+linaro@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
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
Message-ID: <Yw3J694FGcM6jErg@matsya>
References: <20220714124333.27643-1-johan+linaro@kernel.org>
 <Yw2a44l9a6zz5qTJ@matsya>
 <Yw21t1SUGjCcUuuw@hovoldconsulting.com>
 <Yw28FdhYSv4x0a6B@matsya>
 <Yw2/sVyjofEM+61o@hovoldconsulting.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yw2/sVyjofEM+61o@hovoldconsulting.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30-08-22, 09:43, Johan Hovold wrote:
> On Tue, Aug 30, 2022 at 12:58:21PM +0530, Vinod Koul wrote:
> > On 30-08-22, 09:01, Johan Hovold wrote:
> > > On Tue, Aug 30, 2022 at 10:36:43AM +0530, Vinod Koul wrote:
> > > > On 14-07-22, 14:43, Johan Hovold wrote:
> > > > > When adding support for SC8280XP to the QMP PHY driver I noticed that
> > > > > the PHY provider child node was not described by the current DT schema.
> > > > > 
> > > > > The SC8280XP PHYs also need a second fixed-divider PIPE clock
> > > > > ("pipediv2") and I didn't want to have to add a bogus "lane" suffix to
> > > > > the clock name just to match the current "pipe0" name so I decided to
> > > > > deprecate the unnecessary suffix in the current binding instead.
> > > > > 
> > > > > To be able to add the missing child-node schema and handle device
> > > > > specifics like additional PIPE clocks, it quickly became obvious that
> > > > > the binding needs to be split up.
> > > > > 
> > > > > This series clean up and fixes some issue with the current schema before
> > > > > splitting it up in separate schemas for PCIe, UFS and USB and adding
> > > > > missing parts like the child PHY provider nodes.
> > > > > 
> > > > > The MSM8996 PCIe PHY gets its own schema as this is the only non-combo
> > > > > PHY that actually provides more than one PHY per IP block. Note that the
> > > > > "lane" suffix is still unnecessary and misleading.
> > > > > 
> > > > > The final patches add support for the updated binding to the (recently
> > > > > split up) PHY drivers. Included is also a related combo PHY cleanup.
> > > > 
> > > > This fails at patch 2 for me on v6.0-rc1, please rebase and resend
> > > 
> > > Are you sure you haven't applied anything to your local tree that causes
> > > this?
> > 
> > Pretty sure :-)
> 
> Hmm. But nothing had changed in 6.0-rc1 and it still applies on a clean
> 6.0-rc1 as expected here.
> 
> Would you mind trying again?
> 
> 	git checkout -b tmp-branch v6.0-rc1
> 	b4 am 20220714124333.27643-1-johan+linaro@kernel.org
> 	git am ./v3_20220714_johan_linaro_phy_qcom_qmp_fix_dt_bindings_and_deprecate_lane_suffix.mbx
> 
> > > I just tried fetching the v3 series from lore and it applies just fine
> > > on top of 6.0-rc1.
> > > 
> > > Note that if you've added a new compatible string locally, the second
> > > patch which sorts the compatible strings is likely to fail to apply.
> > 
> > At that time no, now I think I have patch or so ... Tree should be
> > pushed in a bit, you can check
> 
> Which tree would that be? The linux-phy tree next branch is still at -rc1:
> 
> 	https://git.kernel.org/pub/scm/linux/kernel/git/phy/linux-phy.git/

It is updated now, my tests were running

-- 
~Vinod
