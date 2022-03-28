Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 641124E9D18
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Mar 2022 19:11:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244441AbiC1RNK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Mar 2022 13:13:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236364AbiC1RNH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Mar 2022 13:13:07 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1543289B6;
        Mon, 28 Mar 2022 10:11:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6AA9AB81178;
        Mon, 28 Mar 2022 17:11:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 070B3C340F0;
        Mon, 28 Mar 2022 17:11:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648487484;
        bh=nhTbLdAHeywYHwvCNkja4sDro8JXug829PcpuFzlDJk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=irEz5nnEiL5PElg4GKAhNWH/5pSi9xMv4h49LCdjFso8H/c9dO1ZJ8dM9XQaG+S6R
         KeVmjwIrlw8/a4IfumbyhEdaTBb1ElxlwoGDTfvN03yMph+6z/JGLXhznakY9/9SCh
         KiwCYZwUpgTgBb3DT5dIV9+nKgGr5YkWcT89hCtOG9mjWijqEd4a9tYLnYu83IU40q
         gAFOd4lBYPKPQrx6d4qJ6wx1zo1crzOSl6b26vnZFWZSJfimVrhbJAl91UH4N2oiDs
         FYPgjxeBoZaNcQwPrS0kUhaKI7qazb/wxW811fwwpbFiWFklWPLjXnws4S2txwibWP
         q6sft0MPftGsQ==
Date:   Mon, 28 Mar 2022 22:41:18 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-arm-msm@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Andy Gross <agross@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/6] arm64: dts: qcom: sm8450: rename interconnect nodes
Message-ID: <YkHsNtF8oGqE0g2i@matsya>
References: <20220328143035.519909-1-vkoul@kernel.org>
 <20220328143035.519909-2-vkoul@kernel.org>
 <784aa271-5c95-3675-07e1-25b495d9eb80@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <784aa271-5c95-3675-07e1-25b495d9eb80@linaro.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28-03-22, 17:07, Krzysztof Kozlowski wrote:
> On 28/03/2022 16:30, Vinod Koul wrote:
> > clk-virt and mc-virt interconnect nodes were named interconnect@0 and
> > interconnect@1. That is incorrect as we don't have unit addresses 0/1
> > for these node.
> > 
> > This causes warning:
> > arch/arm64/boot/dts/qcom/sm8450.dtsi:255.27-259.4:
> > 	Warning (unit_address_vs_reg): /interconnect@0:
> > 	node has a unit name, but no reg or ranges property
> > arch/arm64/boot/dts/qcom/sm8450.dtsi:261.26-265.4:
> > 	Warning (unit_address_vs_reg): /interconnect@1:
> > 	node has a unit name, but no reg or ranges property
> > arch/arm64/boot/dts/qcom/sm8450.dtsi:255.27-259.4:
> > 	Warning (unique_unit_address_if_enabled): /interconnect@0:
> > 	duplicate unit-address (also used in node /soc@0)
> > 
> > Rename the nodes to interconnect-0 and interconnect-1 to fix the
> > warning.
> > 
> > Signed-off-by: Vinod Koul <vkoul@kernel.org>
> > Suggested-by: Krzysztof Kozlowski <krzk@kernel.org>
> > ---
> >  arch/arm64/boot/dts/qcom/sm8450.dtsi | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> The DT schema will still need to be fixed because it expects 'reg' address.

Yes will update that as well..

> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Thanks

-- 
~Vinod
