Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AE70583B45
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jul 2022 11:33:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235553AbiG1Jdb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jul 2022 05:33:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235547AbiG1Jd2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jul 2022 05:33:28 -0400
Received: from ssl.serverraum.org (ssl.serverraum.org [176.9.125.105])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC10D5722F
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 02:33:26 -0700 (PDT)
Received: from mwalle01.kontron.local. (unknown [213.135.10.150])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 9084922236;
        Thu, 28 Jul 2022 11:33:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1659000804;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Y/485svABlT4PcHXX54aqjhS0XIJuxrMprdkXsRqt1I=;
        b=UfZ5HmMGRE9jGy1yOhKhi38LSuPf5727daBYrbsO845WuXTWMYO4wG5EpLzpwRm+IXNGyQ
        /HuZux599nWrHeURnGS18SIdVcGkLq2VbO2/WFwAo329bOmaO+J93zu3RBWDrmGzIRlprs
        qOezl8PZLt0zslQdwPApT3GAyChdXbU=
From:   Michael Walle <michael@walle.cc>
To:     biwen.li@nxp.com
Cc:     leoyang.li@nxp.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, olteanv@gmail.com,
        shawnguo@kernel.org, Michael Walle <michael@walle.cc>
Subject: Re: [PATCH v3 3/8] arm64: dts: ls1028a: add flextimer based pwm nodes
Date:   Thu, 28 Jul 2022 11:33:18 +0200
Message-Id: <20220728093318.299798-1-michael@walle.cc>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <DU2PR04MB89497E16D2E9A01BF763D92B8FEC9@DU2PR04MB8949.eurprd04.prod.outlook.com>
References: <DU2PR04MB89497E16D2E9A01BF763D92B8FEC9@DU2PR04MB8949.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

sorry for digging up this old thread. But I've noticed some
inconsistencies here while syncing the device tree with u-boot.

>> On Wed, Apr 13, 2022 at 06:07:20PM +0000, Leo Li wrote:
>> > > arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi:1210.21-1219.5:
>> > > Warning
>> > > (unique_unit_address): /soc/pwm@2800000: duplicate unit-address
>> > > (also used in node /soc/timer@2800000)
>> > > arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi:1221.21-1230.5:
>> > > Warning
>> > > (unique_unit_address): /soc/pwm@2810000: duplicate unit-address
>> > > (also used in node /soc/timer@2810000)
>> >
>> > Well, this is similar situation as pcie.  The flextimer controller can
>> > be used as timer, PWM or alarm.  We have separate drivers and bindings
>> > for these modes which resulted in different nodes for the same
>> > controller.
>>
>> I think the mfd framework can address the situation where multiple drivers,
>> with multiple functionalities, want access to the same memory region?
>
> I know mfd is used for device providing multiple functions at the same
> time. I'm not sure if it can help dealing with the one function at a time
> scenario.

Funnily enough, I had the same concern:
https://lore.kernel.org/lkml/92eaa24876a823aa5833435f51095812@walle.cc/

Anyway, I have a few questions about the device tree here:

> +	rtc_clk: rtc-clk {
> +		compatible = "fixed-clock";
> +		#clock-cells = <0>;
> +		clock-frequency = <32768>;
> +		clock-output-names = "rtc_clk";
> +	};
> +

Is that an internal clock? I've checked the RDB schematics and the
RTC clock output is not connected to anything. The RM of the LS1028A
mentions the fixed clock input of the flex timer, but it doesn't say
where it is connected to. It just says there is no "internally-generated
secure clock" support on any of the timer modules.

In ch19.3 it also says "For the chip-specific implementation details of
this module's instances, see the chip configuration information". But
I'm not sure where to find this.


> +		pwm0: pwm@2800000 {
> +			compatible = "fsl,vf610-ftm-pwm";
> +			#pwm-cells = <3>;
> +			reg = <0x0 0x2800000 0x0 0x10000>;
> +			clock-names = "ftm_sys", "ftm_ext",
> +				      "ftm_fix", "ftm_cnt_clk_en";
> +			clocks = <&clockgen 4 1>, <&clockgen 4 1>,
> +				 <&rtc_clk>, <&clockgen 4 1>;

ftm_ext seems to be the (optional) external clock, eg FTMn_EXTCLK. Why is
it connected to <&clockgen 4 1>? That doesn't make sense. The driver
itself, won't probe if the clock isn't there either and assumes that the
external clock is always there. That seems wrong, too.

Can you shed some light on this?

-michael
