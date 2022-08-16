Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D91EE59575F
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 12:01:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233701AbiHPKBB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 06:01:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233401AbiHPKAR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 06:00:17 -0400
Received: from ssl.serverraum.org (ssl.serverraum.org [176.9.125.105])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39FF782D29
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 02:04:22 -0700 (PDT)
Received: from ssl.serverraum.org (web.serverraum.org [172.16.0.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 5EBC7221D4;
        Tue, 16 Aug 2022 11:04:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1660640659;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qwL2HEhoUW8wLgfRNaFDzK4F29xL7uRG6jMPu8nbo/I=;
        b=MypHu4n7Pm4I9FZ4Ldrg+r9W8l+NFTqD5SCHWDqMrMQe6oZ1i3JpGx/tn7t7aIs7nx/dvT
        OL/LrePIXbPf3OKajsYQT5dphb+3NGrzSjsFvXensLM9VD+ZnVk7/K9E31b68vv3IKN8DS
        VzozlMgtLlG+8sa8hLcNS0V2hXP2wxM=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Tue, 16 Aug 2022 11:04:18 +0200
From:   Michael Walle <michael@walle.cc>
To:     biwen.li@nxp.com
Cc:     leoyang.li@nxp.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, olteanv@gmail.com,
        shawnguo@kernel.org
Subject: Re: [PATCH v3 3/8] arm64: dts: ls1028a: add flextimer based pwm nodes
In-Reply-To: <20220728093318.299798-1-michael@walle.cc>
References: <DU2PR04MB89497E16D2E9A01BF763D92B8FEC9@DU2PR04MB8949.eurprd04.prod.outlook.com>
 <20220728093318.299798-1-michael@walle.cc>
User-Agent: Roundcube Webmail/1.4.13
Message-ID: <a4fee40332f27c6ea83bf85ac067c46b@walle.cc>
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

Am 2022-07-28 11:33, schrieb Michael Walle:
> Hi,
> 
> sorry for digging up this old thread. But I've noticed some
> inconsistencies here while syncing the device tree with u-boot.
> 
>>> On Wed, Apr 13, 2022 at 06:07:20PM +0000, Leo Li wrote:
>>> > > arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi:1210.21-1219.5:
>>> > > Warning
>>> > > (unique_unit_address): /soc/pwm@2800000: duplicate unit-address
>>> > > (also used in node /soc/timer@2800000)
>>> > > arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi:1221.21-1230.5:
>>> > > Warning
>>> > > (unique_unit_address): /soc/pwm@2810000: duplicate unit-address
>>> > > (also used in node /soc/timer@2810000)
>>> >
>>> > Well, this is similar situation as pcie.  The flextimer controller can
>>> > be used as timer, PWM or alarm.  We have separate drivers and bindings
>>> > for these modes which resulted in different nodes for the same
>>> > controller.
>>> 
>>> I think the mfd framework can address the situation where multiple 
>>> drivers,
>>> with multiple functionalities, want access to the same memory region?
>> 
>> I know mfd is used for device providing multiple functions at the same
>> time. I'm not sure if it can help dealing with the one function at a 
>> time
>> scenario.
> 
> Funnily enough, I had the same concern:
> https://lore.kernel.org/lkml/92eaa24876a823aa5833435f51095812@walle.cc/
> 
> Anyway, I have a few questions about the device tree here:
> 
>> +	rtc_clk: rtc-clk {
>> +		compatible = "fixed-clock";
>> +		#clock-cells = <0>;
>> +		clock-frequency = <32768>;
>> +		clock-output-names = "rtc_clk";
>> +	};
>> +
> 
> Is that an internal clock? I've checked the RDB schematics and the
> RTC clock output is not connected to anything. The RM of the LS1028A
> mentions the fixed clock input of the flex timer, but it doesn't say
> where it is connected to. It just says there is no 
> "internally-generated
> secure clock" support on any of the timer modules.
> 
> In ch19.3 it also says "For the chip-specific implementation details of
> this module's instances, see the chip configuration information". But
> I'm not sure where to find this.
> 
> 
>> +		pwm0: pwm@2800000 {
>> +			compatible = "fsl,vf610-ftm-pwm";
>> +			#pwm-cells = <3>;
>> +			reg = <0x0 0x2800000 0x0 0x10000>;
>> +			clock-names = "ftm_sys", "ftm_ext",
>> +				      "ftm_fix", "ftm_cnt_clk_en";
>> +			clocks = <&clockgen 4 1>, <&clockgen 4 1>,
>> +				 <&rtc_clk>, <&clockgen 4 1>;
> 
> ftm_ext seems to be the (optional) external clock, eg FTMn_EXTCLK. Why 
> is
> it connected to <&clockgen 4 1>? That doesn't make sense. The driver
> itself, won't probe if the clock isn't there either and assumes that 
> the
> external clock is always there. That seems wrong, too.
> 
> Can you shed some light on this?

Ping.

-michael
