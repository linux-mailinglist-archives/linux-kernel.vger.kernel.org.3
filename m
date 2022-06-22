Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D86BE5548F3
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 14:16:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357881AbiFVLv0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 07:51:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357760AbiFVLvY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 07:51:24 -0400
Received: from ssl.serverraum.org (ssl.serverraum.org [176.9.125.105])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EB103D1D4;
        Wed, 22 Jun 2022 04:51:24 -0700 (PDT)
Received: from ssl.serverraum.org (web.serverraum.org [172.16.0.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id C582D22238;
        Wed, 22 Jun 2022 13:51:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1655898682;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RWa8M9EIjVZwN1F7UZO9aAUM32nW9Ee70q8ZSVxK9es=;
        b=CZmRVqdUfSwQ0w9rz9waYWxANsBtG4gW3hZOT8+rB6qLPfim9BkyFBfDnMUz2Z2HKdMbpK
        8c269ZQjx8NCVy9cMeJNtW68Bp3qYhsge8SnUUyY4FlpxpWS2t78B4RYSz9fxMpVl5WnR3
        XdanpIH2qTrRM4jdeWp6ZgaYHcGiHSo=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Wed, 22 Jun 2022 13:51:21 +0200
From:   Michael Walle <michael@walle.cc>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Kavyasree Kotagiri <kavyasree.kotagiri@microchip.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ARM: dts: lan966x: fix sys_clk frequency
In-Reply-To: <3e860b122533f488c053abe0f3ff03eb@walle.cc>
References: <20220326194028.2945985-1-michael@walle.cc>
 <3e860b122533f488c053abe0f3ff03eb@walle.cc>
User-Agent: Roundcube Webmail/1.4.13
Message-ID: <1d2cbab375b50c0be31780f2d8d7a088@walle.cc>
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

Am 2022-04-28 10:49, schrieb Michael Walle:
> Am 2022-03-26 20:40, schrieb Michael Walle:
>> The sys_clk frequency is 165.625MHz. The register reference of the
>> Generic Clock controller lists the CPU clock as 600MHz, the DDR clock 
>> as
>> 300MHz and the SYS clock as 162.5MHz. This is wrong. It was first
>> noticed during the fan driver development and it was measured and
>> verified via the CLK_MON output of the SoC which can be configured to
>> output sys_clk/64.
>> 
>> The core PLL settings (which drives the SYS clock) seems to be as
>> follows:
>>   DIVF = 52
>>   DIVQ = 3
>>   DIVR = 1
>> 
>> With a refernce clock of 25MHz, this means we have a post divider 
>> clock
>>   Fpfd = Fref / (DIVR + 1) = 25MHz / (1 + 1) = 12.5MHz
>> 
>> The resulting VCO frequency is then
>>   Fvco = Fpfd * (DIVF + 1) * 2 = 12.5MHz * (52 + 1) * 2 = 1325MHz
>> 
>> And the output frequency is
>>   Fout = Fvco / 2^DIVQ = 1325MHz / 2^3 = 165.625Mhz
>> 
>> This all adds up to the constrains of the PLL:
>>     10MHz <= Fpfd <= 200MHz
>>     20MHz <= Fout <= 1000MHz
>>   1000MHz <= Fvco <= 2000MHz
>> 
>> Fixes: 290deaa10c50 ("ARM: dts: add DT for lan966 SoC and 2-port board 
>> pcb8291")
>> Signed-off-by: Michael Walle <michael@walle.cc>
> 
> Ping :)
> 
> Btw. this is also true for the new B0 silicon. I just verified it
> with the CLK_MON output.

Ping #2.

Could this please be picked up because most drivers use this property
to calculate output frequencies and so on, e.g. the PWM driver.

-michael
