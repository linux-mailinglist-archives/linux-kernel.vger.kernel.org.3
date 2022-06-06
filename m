Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3696053E099
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 06:59:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229501AbiFFEYk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 00:24:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbiFFEYh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 00:24:37 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B29513F93D;
        Sun,  5 Jun 2022 21:17:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B338DB80E90;
        Mon,  6 Jun 2022 04:09:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39FB8C34119;
        Mon,  6 Jun 2022 04:09:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654488592;
        bh=dYNFi/wy07Ov4cuvSH4qkleX/fOBI4marWs8y/XSuS4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZXQtVBBAMiwnMbu15JFucRfaQ4D/t6U7SeESaIsPkJ8lpemOx/pqqN+CnCrNCSfUj
         ub5go6jWXUQ7oRe9SM5gp0Ll69MUncQyNMnFgIsxif2Nger9B71PyQJ0YNHTtwx0IY
         7baZ1ssPCf5CXLV/ZQfp0waDmmTOrXY3UlFPWlH9YGmoyVppNmOWve5RyRW5XiTqVG
         RJ5nM7rb4SfrUNBui9Hh3KCSYljrsQkUrJG0mfRsq2FN7qavFv+qSDNMmy2a3enT3Y
         WVKRobQm9gXWuEYu7CByr+7tbgtbo1mdGzfhQbn69JgWGkzcnmAKg6oM3r23vr8RMl
         etMN90/2ena1g==
Date:   Mon, 6 Jun 2022 09:39:45 +0530
From:   Manivannan Sadhasivam <mani@kernel.org>
To:     Stanislav Jakubek <stano.jakubek@gmail.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-unisoc@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: interrupt-controller: Convert
 rda,8810pl-intc to YAML
Message-ID: <20220606040945.GA21449@thinkpad>
References: <20220527125633.GA5145@standask-GA-A55M-S2HP>
 <4bb8e18a-11d8-c617-7952-8887aa815301@linaro.org>
 <20220603121258.GA4919@standask-GA-A55M-S2HP>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220603121258.GA4919@standask-GA-A55M-S2HP>
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 03, 2022 at 02:12:58PM +0200, Stanislav Jakubek wrote:
> On Sun, May 29, 2022 at 04:05:12PM +0200, Krzysztof Kozlowski wrote:
> > On 27/05/2022 14:56, Stanislav Jakubek wrote:
> > > Convert RDA Micro interrupt controller bindings to DT schema format.
> > > 
> > > Signed-off-by: Stanislav Jakubek <stano.jakubek@gmail.com>
> > > ---
> > > 
> > > Didn't know what to do about the interrupt sources listed in the original txt file,
> > > so I've split them off into a separate file. Hope that's okay.
> > 
> > Interrupt sources are not kept in header files.
> 
> Ok, should I move them somewhere else or is it fine to drop them?
> 
> > Additionally are you
> > sure this is a property of the interrupt controller, not a property of
> > SoC itself? I would assume that one interrupt controller implementation
> > (e.g. GIC) can be used in different SoCs and the sources are every time
> > different because they depend on the actual wiring...
> > 
> 
> I honestly have no idea, I just wanted to make some YAML conversions.
> Maybe Mani could answer this?
> 

You can drop them. I didn't include it in a header file because it could vary
between SoCs. So added here for documenting purposes.

Thanks,
Mani

> > 
> > Best regards,
> > Krzysztof
> 
> 
> Thanks,
> Stanislav

-- 
மணிவண்ணன் சதாசிவம்
