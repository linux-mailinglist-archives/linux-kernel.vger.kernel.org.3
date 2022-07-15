Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DD555766DA
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jul 2022 20:41:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230254AbiGOSlP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jul 2022 14:41:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230235AbiGOSlM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jul 2022 14:41:12 -0400
Received: from ssl.serverraum.org (ssl.serverraum.org [IPv6:2a01:4f8:151:8464::1:2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1124C747B7;
        Fri, 15 Jul 2022 11:41:10 -0700 (PDT)
Received: from ssl.serverraum.org (web.serverraum.org [172.16.0.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id C683322175;
        Fri, 15 Jul 2022 20:41:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1657910467;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nN2veZaRxjOolGJnonMhuLPMtImYKhPfpudTYWFdxUE=;
        b=Z7irUITp+zxV6LnKnC2bKjSZ8kV+QxJLsGt0BRN8ZcG2fzo3BtjLGq0ejrbuOOn6m6BQMh
        NkhB85+it9+YaJPfiB+ub+pw9+kvEG1gtyPjNWYd/ycOFvsnFmGnwZhaTxIDxXBlJe9RZ4
        unftHJjkncxwjAXzUirUOAedtdK6z6g=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Fri, 15 Jul 2022 20:41:06 +0200
From:   Michael Walle <michael@walle.cc>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Kavyasree Kotagiri <kavyasree.kotagiri@microchip.com>,
        Claudiu.Beznea@microchip.com
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ARM: dts: lan966x: fix sys_clk frequency
In-Reply-To: <1d2cbab375b50c0be31780f2d8d7a088@walle.cc>
References: <20220326194028.2945985-1-michael@walle.cc>
 <3e860b122533f488c053abe0f3ff03eb@walle.cc>
 <1d2cbab375b50c0be31780f2d8d7a088@walle.cc>
User-Agent: Roundcube Webmail/1.4.13
Message-ID: <ad62beb5a2c8582014a3b4172d55bf64@walle.cc>
X-Sender: michael@walle.cc
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[+ Claudiu as he seems to pick patches for at91, too]

Am 2022-06-22 13:51, schrieb Michael Walle:
> Am 2022-04-28 10:49, schrieb Michael Walle:
>> Am 2022-03-26 20:40, schrieb Michael Walle:
>>> The sys_clk frequency is 165.625MHz. The register reference of the
>>> Generic Clock controller lists the CPU clock as 600MHz, the DDR clock 
>>> as
>>> 300MHz and the SYS clock as 162.5MHz. This is wrong. It was first
>>> noticed during the fan driver development and it was measured and
>>> verified via the CLK_MON output of the SoC which can be configured to
>>> output sys_clk/64.
>>> 
>>> The core PLL settings (which drives the SYS clock) seems to be as
>>> follows:
>>>   DIVF = 52
>>>   DIVQ = 3
>>>   DIVR = 1
>>> 
>>> With a refernce clock of 25MHz, this means we have a post divider 
>>> clock
>>>   Fpfd = Fref / (DIVR + 1) = 25MHz / (1 + 1) = 12.5MHz
>>> 
>>> The resulting VCO frequency is then
>>>   Fvco = Fpfd * (DIVF + 1) * 2 = 12.5MHz * (52 + 1) * 2 = 1325MHz
>>> 
>>> And the output frequency is
>>>   Fout = Fvco / 2^DIVQ = 1325MHz / 2^3 = 165.625Mhz
>>> 
>>> This all adds up to the constrains of the PLL:
>>>     10MHz <= Fpfd <= 200MHz
>>>     20MHz <= Fout <= 1000MHz
>>>   1000MHz <= Fvco <= 2000MHz
>>> 
>>> Fixes: 290deaa10c50 ("ARM: dts: add DT for lan966 SoC and 2-port 
>>> board pcb8291")
>>> Signed-off-by: Michael Walle <michael@walle.cc>
>> 
>> Ping :)
>> 
>> Btw. this is also true for the new B0 silicon. I just verified it
>> with the CLK_MON output.
> 
> Ping #2.
> 
> Could this please be picked up because most drivers use this property
> to calculate output frequencies and so on, e.g. the PWM driver.

Ping #3. Now it even got a Reviewed-by.

-michael
