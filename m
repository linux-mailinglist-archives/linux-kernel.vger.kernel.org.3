Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E967D5185CE
	for <lists+linux-kernel@lfdr.de>; Tue,  3 May 2022 15:43:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236402AbiECNrQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 09:47:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236380AbiECNrL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 09:47:11 -0400
Received: from ssl.serverraum.org (ssl.serverraum.org [176.9.125.105])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD53C1D32C;
        Tue,  3 May 2022 06:43:38 -0700 (PDT)
Received: from ssl.serverraum.org (web.serverraum.org [172.16.0.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 8A86022239;
        Tue,  3 May 2022 15:43:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1651585417;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wUhybUQ9wgcQ0ISiRM6y/Kbz55BvTsWvkuDWu8QOB7M=;
        b=Dv8DNuDpkZlRXdB8+UQL7pAMGq6Ylo/o0fqe612D1mvZYd7KMbJxTD0T5JbYdVTKO4qUgH
        paYRsNapZPvIwbnXJSxiRDkTtDmrM+PjG+Iqj5+BaaLNL5z/abkqDFrDCggDL3B23DMT3b
        O3vk8rO8LsEASepsME/hAtxrZKgEEYw=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Tue, 03 May 2022 15:43:36 +0200
From:   Michael Walle <michael@walle.cc>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     Sean Anderson <sean.anderson@seco.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        Li Yang <leoyang.li@nxp.com>, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andrew Lunn <andrew@lunn.ch>
Subject: Re: [PATCH v3 0/9] nvmem: sfp: binding updates and additions
In-Reply-To: <7aa5d553-04ad-5198-153c-39a9375a6a12@linaro.org>
References: <20220428181703.2194171-1-sean.anderson@seco.com>
 <7aa5d553-04ad-5198-153c-39a9375a6a12@linaro.org>
User-Agent: Roundcube Webmail/1.4.13
Message-ID: <3b8fc56f64508f7604f3b9e14b048568@walle.cc>
X-Sender: michael@walle.cc
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 2022-04-29 17:56, schrieb Srinivas Kandagatla:
> On 28/04/2022 19:16, Sean Anderson wrote:
>> This adds several properties to the Layerscape Security Fuse Processor
>> (SFP) necessary for writing. Although the Linux driver does not use
>> these bindings, I plan to use them in U-Boot [1]. It also adds a new
>> compatibles for Trust Architecture (TA) 2.1 devices. In addition, it
>> also adds an SFP binding for all TA 2.1 and 3.0 devices.
>> 
>> I would like to get this series merged for 5.18. As noted in patch 2,
>> making the clock property mandatory is not an ABI break, but if this 
>> is
>> not applied then it would become an ABI break. The absolute minimum
>> patches to apply for this would be patches 2 and 5. The rest 
>> (including
>> the regmap changes) could be deferred if necessary.
>> 
>> [1] 
>> https://lore.kernel.org/u-boot/7c8e206a-cd40-2a77-6282-7f4bead2b13a@seco.com/T/#m591f8425b6f096ab3d54e6f7bd258e41cfa4c43b
>> 
>> Changes in v3:
>> - Update commit message to note that this binding has not yet been
>>    present in a relase, so it is OK to make otherwise breaking 
>> changes.
>> 
>> Changes in v2:
>> - Mention "regulator" in the description for ta-prog-sfp-supply
>> - Convert sfp driver to use regmap
>> - Fix various typos in commit messages
>> 
>> Sean Anderson (9):
>>    dt-bindings: nvmem: sfp: Fix typo
>>    dt-bindings: nvmem: sfp: Add clock properties
>>    dt-bindings: nvmem: sfp: Add TA_PROG_SFP supply
>>    dt-bindings: nvmem: sfp: Add compatible binding for TA 2.1 SFPs
>>    arm64: dts: ls1028a: Update SFP binding to include clock
>>    ARM: dts: layerscape: Add SFP binding for TA 2.1 devices
>>    ARM: dts: Add SFP binding for TA 3.0 devices
>>    nvmem: sfp: Use regmap
>>    nvmem: sfp: Add support for TA 2.1 devices
>> 
> 
> I have applied all the patches except 5/9, 6/9, and 7/9 dts patches
> which need to go via dts maintainer tree.

Ahh. At least the device tree binding change (and the device tree
changes itself) should be applied as fixes for the 5.18 release,
so we don't have any conflicting descriptions. My fixes tag was never
picked up, unfortunately:
https://lore.kernel.org/linux-devicetree/4a45db184fbadc278624571dfbeb5004@walle.cc/

Srinivas, I've seen you picked it up into your for-next branch.
Can we fix that?

I'd guess the layerscape device tree change also need a Fixes: tag.

-michael
