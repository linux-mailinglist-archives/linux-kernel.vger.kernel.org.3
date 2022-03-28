Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A66764E9D2A
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Mar 2022 19:15:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244511AbiC1RQF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Mar 2022 13:16:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238057AbiC1RQB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Mar 2022 13:16:01 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6306BCA8;
        Mon, 28 Mar 2022 10:14:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 92493B81123;
        Mon, 28 Mar 2022 17:14:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF4E9C340F0;
        Mon, 28 Mar 2022 17:14:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648487657;
        bh=+Hb2LAPdRASu0puANzdXUhUgmLTF67j/rG9PCaiUMqo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pZdVrHtaWG1GPyzB/STvsklR2ifLgXC388kXnxLb+KCC589bhjgKeAiF5+Y1+KO9y
         9bdGpaGU6oAFoyyWAKglHJ5hxwx/jGzz5dHOSrTCvRnR/R8nMl3RERFI6kXjMOwWyP
         dkigqiegP1bp5yXRxR+YM8Wf6HGavnrvmtsjzfEZ4R4wove09bNZarqE6nKTcVEi3C
         AEa4kHm5KjTbFQm5P5dWP1D//At5uRvZHEFrj7OH42U9KCOpqpueKoAy8kg8lw3w4Q
         qnliSE0yYgS58e9n0e89j7LH7OLOu0uVgQi7HyW/TI5UeLl9GJodUiN0Lib+DPpdTH
         U73FJXRK9KMvQ==
Date:   Mon, 28 Mar 2022 22:44:13 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-arm-msm@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Andy Gross <agross@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/6] arm64: dts: qcom: sm8250: move sound node out of soc
Message-ID: <YkHs5TuYBKmOLrHO@matsya>
References: <20220328143035.519909-1-vkoul@kernel.org>
 <20220328143035.519909-5-vkoul@kernel.org>
 <3cc9c1a0-45f3-cb1b-1991-f51da4789afd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3cc9c1a0-45f3-cb1b-1991-f51da4789afd@linaro.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28-03-22, 17:14, Krzysztof Kozlowski wrote:
> On 28/03/2022 16:30, Vinod Koul wrote:
> > The soc node expects all the nodes to have unit addresses. The sound
> > node does not have that which causes warnings:
> > 
> > arch/arm64/boot/dts/qcom/sm8250.dtsi:2806.16-2807.5:
> > Warning (simple_bus_reg): /soc@0/sound: missing or empty reg/ranges property
> > 
> > Move sound node out of soc to fix this
> > 
> > Signed-off-by: Vinod Koul <vkoul@kernel.org>
> > ---
> >  arch/arm64/boot/dts/qcom/sm8250.dtsi | 6 +++---
> >  1 file changed, 3 insertions(+), 3 deletions(-)
> > 
> 
> I don't know the SM8250, but usually the sound node (e.g. containing
> audio-codec) is not part of SoC. I propose to remove it entirely from
> DTSI and define in same place in each DTS. It makes more sense logically
> in such case - one clearly see which board defines the sounds, which
> does not.

Most of our boards have sound, should we duplicate it in all the
boards..? Bjorn..?

-- 
~Vinod
