Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 711C54CB996
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Mar 2022 09:50:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229660AbiCCIum (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Mar 2022 03:50:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230378AbiCCIui (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Mar 2022 03:50:38 -0500
Received: from the.earth.li (the.earth.li [IPv6:2a00:1098:86:4d:c0ff:ee:15:900d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 914F4175871;
        Thu,  3 Mar 2022 00:49:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=earth.li;
        s=the; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:
        Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=JraoEzfEu6BVdZPY22b9hr2HRvi9Lg4wAD5QnaTlQvQ=; b=Uzu5ikcdaD2LeKuz7YlSfqL2Rd
        zHmlzoo/7Rp94sqmn55Y/prB0TYZe/9B8ocnsqcxOeflHQ8BQFcwYU9Gc8A17OfgljU5DWsREfzox
        pGqr0j3osNbyhYjud8eLurnfnoAsSq8AuhFCMVsARC5/MCGJbMIFgkKVD3/YvaV0X7cukuL6khjr4
        dCSs9kLBkqv3FYqdxHTWdgWYUzFyWA5ucAcuVCJeYbJEdGipec3/oEUetYU1CVBAaG6F9ZOxATauF
        2yq9GIlMYgqieGSRGmOpttxgLxwTtZtU9DDm/9EPTz+H1jIU9cGhwPRK1+AvYnxH50KelgKX3eGWo
        ofb6PtZA==;
Received: from noodles by the.earth.li with local (Exim 4.94.2)
        (envelope-from <noodles@earth.li>)
        id 1nPh9U-00287t-A6; Thu, 03 Mar 2022 08:49:36 +0000
Date:   Thu, 3 Mar 2022 08:49:36 +0000
From:   Jonathan McDowell <noodles@earth.li>
To:     Ansuel Smith <ansuelsmth@gmail.com>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Taniya Das <tdas@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 00/15] Multiple addition and improvement to ipq8064 gcc
Message-ID: <YiCBIIA1FU1DbOso@earth.li>
References: <20220226135235.10051-1-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220226135235.10051-1-ansuelsmth@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 26, 2022 at 02:52:20PM +0100, Ansuel Smith wrote:
> This is an attempt in making the ipq8064 SoC actually usable. Currently
> many feature are missing for this SoC and devs user off-the-tree patches
> to make it work (example patch for missing clock, patch for cpufreq
> driver, patch to add missing node in the dts)
> 
> I notice there was some work in modernizing the gcc driver for other
> qcom target but this wasn't done for ipq806x. This does exactly this, we
> drop any parent_names stuff and we switch to the parent_data way. We
> also drop the pxo and cxo source clk from gcc driver and we refer to the
> dts for it.
> 
> This also add all the missing feature for the nss cores and the
> cryptoengine in them. It does also introduce the required flags to make
> the RPM actually work and NOT reject any command. There was an attempt
> in declaring these clock as core clock in the dts but this ends up in no
> serial as the kernel makes these clock not accessible. We just want to
> make the kernel NOT disable them if unused nothing more.
> 
> At the end we update the ipq8064 dtsi to add the pxo and cxo tag and
> declare them in gcc and also fix a problem with tsens probe.

FWIW, series tested on my RB3011. No regressions, tsens driver now
correctly loads.

Tested-by: Jonathan McDowell <noodles@earth.li>

> v6:
> - Add more info about the changed define
> - Fixed wrong definition for pxo/cxo parent map
> v5:
> - Drop patch removing fixed clk
> - Use name in parent_data to keep compatibility with old dtb
> - Fix error in the documentation commits
> - Keep old copyright for gcc documentation
> - Fix an error with the rcg floor ops
> - Set nss clk based on the device compatible
> v4:
> - Drop drivers in all the patches.
> - Introduce floor ops for sdc
> - gcc.yaml to gcc-other.yaml
> - gcc-common.yaml to gcc.yaml
> v3:
> - Rework Documentation with Rob suggestions
> v2:
> - Fix error from Rob bot.
> - Add additional commits to make qcom,gcc.yaml a template
> - Squash parent_hws patch with the modernize patch
> - Create gcc_pxo instead of using long define.
> 
> Ansuel Smith (15):
>   dt-bindings: clock: split qcom,gcc.yaml to common and specific schema
>   dt-bindings: clock: simplify qcom,gcc-apq8064 Documentation
>   dt-bindings: clock: document qcom,gcc-ipq8064 binding
>   clk: qcom: gcc-ipq806x: fix wrong naming for gcc_pxo_pll8_pll0
>   clk: qcom: gcc-ipq806x: convert parent_names to parent_data
>   clk: qcom: gcc-ipq806x: use ARRAY_SIZE for num_parents
>   clk: qcom: gcc-ipq806x: add additional freq nss cores
>   clk: qcom: gcc-ipq806x: add unusued flag for critical clock
>   clk: qcom: clk-rcg: add clk_rcg_floor_ops ops
>   clk: qcom: gcc-ipq806x: add additional freq for sdc table
>   dt-bindings: clock: add ipq8064 ce5 clk define
>   clk: qcom: gcc-ipq806x: add CryptoEngine clocks
>   dt-bindings: reset: add ipq8064 ce5 resets
>   clk: qcom: gcc-ipq806x: add CryptoEngine resets
>   ARM: dts: qcom: add syscon and cxo/pxo clock to gcc node for ipq8064
> 
>  .../bindings/clock/qcom,gcc-apq8064.yaml      |  29 +-
>  .../bindings/clock/qcom,gcc-ipq8064.yaml      |  76 ++
>  .../bindings/clock/qcom,gcc-other.yaml        |  70 ++
>  .../devicetree/bindings/clock/qcom,gcc.yaml   |  59 +-
>  arch/arm/boot/dts/qcom-ipq8064.dtsi           |   8 +-
>  drivers/clk/qcom/clk-rcg.c                    |  24 +
>  drivers/clk/qcom/clk-rcg.h                    |   1 +
>  drivers/clk/qcom/gcc-ipq806x.c                | 649 +++++++++++++-----
>  include/dt-bindings/clock/qcom,gcc-ipq806x.h  |   5 +-
>  include/dt-bindings/reset/qcom,gcc-ipq806x.h  |   5 +
>  10 files changed, 685 insertions(+), 241 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/clock/qcom,gcc-ipq8064.yaml
>  create mode 100644 Documentation/devicetree/bindings/clock/qcom,gcc-other.yaml
> 
> -- 
> 2.34.1

J.

-- 
Web [            Even the Evening Herald slags me off.             ]
site: https:// [                                          ]      Made by
www.earth.li/~noodles/  [                      ]         HuggieTag 0.0.24
