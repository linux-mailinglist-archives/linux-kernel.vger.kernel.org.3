Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95B724DC87C
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 15:15:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234774AbiCQOQL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 10:16:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233290AbiCQOQJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 10:16:09 -0400
Received: from vps0.lunn.ch (vps0.lunn.ch [185.16.172.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87BCBA6E1D;
        Thu, 17 Mar 2022 07:14:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
        Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
        bh=75pCC8pCmtUToJup8gThaeeaMx/WM4Wbw3nLi1njfHE=; b=Wx+mEggFd3WNHg/gDH8VjqPvEu
        0HE5nRP8IRhSRGrBiXVCsOQP0Rkiz+rRkdRt56xwj9GbBpEB7kl30F2DD/ozcebaLB+Qm7qkTFJdd
        lbDVnVlmbbWLPIpmJ8sdxhQbwMf5IPzJALphzjIjmK96r5XW/aLm9i/pFZtLVQHu/LRM=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1nUqtc-00BQDn-OL; Thu, 17 Mar 2022 15:14:32 +0100
Date:   Thu, 17 Mar 2022 15:14:32 +0100
From:   Andrew Lunn <andrew@lunn.ch>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     Chris Packham <Chris.Packham@alliedtelesis.co.nz>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "linus.walleij@linaro.org" <linus.walleij@linaro.org>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "gregory.clement@bootlin.com" <gregory.clement@bootlin.com>,
        "sebastian.hesselbarth@gmail.com" <sebastian.hesselbarth@gmail.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v2 1/8] dt-bindings: pinctrl: mvebu: Document bindings
 for AC5
Message-ID: <YjNCSENOP8EyWArw@lunn.ch>
References: <20220314213143.2404162-1-chris.packham@alliedtelesis.co.nz>
 <20220314213143.2404162-2-chris.packham@alliedtelesis.co.nz>
 <4e6df448-5562-8f50-6f46-91acb279bc1a@canonical.com>
 <7e73bba0-8b54-772c-2e94-8fca4e4e3294@alliedtelesis.co.nz>
 <cb0af80e-3e5a-fbd9-cd8b-7b252ebe33fe@canonical.com>
 <6d902e7d-b71f-9dcd-9175-cc706e3d60cc@alliedtelesis.co.nz>
 <4b1f4772-35f9-3e21-6429-b64c7427144a@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4b1f4772-35f9-3e21-6429-b64c7427144a@canonical.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> What do you mean "driver fails to load"? You control the driver, don't
> you?

It is a thin wrapper around the mvebu driver, which does all the real
work. So no, Chris does not really control what the core of the driver
does.

The existing binding documentation says:

    * Marvell Armada 37xx SoC pin and gpio controller

    Each Armada 37xx SoC come with two pin and gpio controller one for
    the south bridge and the other for the north bridge.

    Inside this set of register the gpio latch allows exposing some
    configuration of the SoC and especially the clock frequency of the
    xtal. Hence, this node is a represent as syscon allowing sharing
    the register between multiple hardware block.


So the syscon is there to allow the clock driver to share the register
space.

	Andrew
