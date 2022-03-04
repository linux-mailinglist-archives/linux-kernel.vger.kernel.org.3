Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 606D44CD2EA
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 12:01:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238020AbiCDLCE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Mar 2022 06:02:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233865AbiCDLCB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 06:02:01 -0500
Received: from ssl.serverraum.org (ssl.serverraum.org [IPv6:2a01:4f8:151:8464::1:2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2298A47AEB;
        Fri,  4 Mar 2022 03:01:13 -0800 (PST)
Received: from ssl.serverraum.org (web.serverraum.org [172.16.0.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 9210122175;
        Fri,  4 Mar 2022 12:01:10 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1646391671;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=99xRnRPJDumTOTwUMBekudNmfTg7+IdOQMg2FPQY/9E=;
        b=m0NnZ75dLCXbxcFWFVKasJNohU3bwywMEbUerq5FTd+HIPJHncdtqjURtSSxUIO5j1TR1e
        ZSAtVJaCkco5IRgIrNoeSPhFWT8T+29R2u51JF5IUk0g/n4dxEeINYZkeoIWkCpblV+zZz
        QEvWljJ8FOtufLPbksZe64cX5GQaa9U=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Fri, 04 Mar 2022 12:01:09 +0100
From:   Michael Walle <michael@walle.cc>
To:     Claudiu.Beznea@microchip.com
Cc:     Kavyasree.Kotagiri@microchip.com, Nicolas.Ferre@microchip.com,
        arnd@arndb.de, olof@lixom.net, soc@kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski@canonical.com, alexandre.belloni@bootlin.com
Subject: Re: [PATCH v1 3/6] ARM: dts: lan966x: add all flexcom usart nodes
In-Reply-To: <a33f0c73-df49-5a22-14b3-0059f7d6b827@microchip.com>
References: <20220303160323.3316317-1-michael@walle.cc>
 <20220303160323.3316317-4-michael@walle.cc>
 <a33f0c73-df49-5a22-14b3-0059f7d6b827@microchip.com>
User-Agent: Roundcube Webmail/1.4.12
Message-ID: <2e0aefc90a80bdf13df0e59857c52ca7@walle.cc>
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

Hi,

thanks for the quick review.

Am 2022-03-04 09:30, schrieb Claudiu.Beznea@microchip.com:
> On 03.03.2022 18:03, Michael Walle wrote:
>> EXTERNAL EMAIL: Do not click links or open attachments unless you know 
>> the content is safe
>> 
>> Add all the usart nodes for the flexcom block. There was already
>> an usart node for the flexcom3 block. But it missed the DMA
>> channels.
> 
> And it would be good to go though a different patch.

sure

>> Although the DMA channels are specified, DMA is not
>> enabled by default because break detection doesn't work with DMA.
>> 
>> Keep the nodes disabled by default.
>> 
>> Signed-off-by: Michael Walle <michael@walle.cc>
>> ---
>>  arch/arm/boot/dts/lan966x.dtsi | 55 
>> ++++++++++++++++++++++++++++++++++
>>  1 file changed, 55 insertions(+)
>> 
>> diff --git a/arch/arm/boot/dts/lan966x.dtsi 
>> b/arch/arm/boot/dts/lan966x.dtsi
>> index a7d46a2ca058..bea69b6d2749 100644
>> --- a/arch/arm/boot/dts/lan966x.dtsi
>> +++ b/arch/arm/boot/dts/lan966x.dtsi
>> @@ -92,6 +92,19 @@ flx0: flexcom@e0040000 {
>>                         #size-cells = <1>;
>>                         ranges = <0x0 0xe0040000 0x800>;
>>                         status = "disabled";
>> +
>> +                       usart0: serial@200 {
>> +                               compatible = 
>> "atmel,at91sam9260-usart";
> 
> Are the usart blocks in lan966x 1:1 compatible with what is is sam9260? 
> In
> case not it may worth to have a new compatible here, for lan966x, such 
> that
> when new features will be implemented in usart driver for lan966x the 
> old
> DT (this one) will work with the new kernel implementation.

During my review of the inital dtsi patch, I've asked the same question 
[1]
and I was told they are the same.

At least this exact usart compatible is already in this file. I was 
under
the impression, that was the least controversial compatible :)

But you'll need to tell me if they are the same or not, I don't have
any clue what microchip has reused. The only thing I can add is that
there is a version register within the IP blocks which is already used
in some drivers.

> Same for the rest of the nodes added in this series.
> 
>> +                               reg = <0x200 0x200>;
>> +                               interrupts = <GIC_SPI 48 
>> IRQ_TYPE_LEVEL_HIGH>;
>> +                               dmas = <&dma0 AT91_XDMAC_DT_PERID(3)>,
>> +                                          <&dma0 
>> AT91_XDMAC_DT_PERID(2)>;
> 
> Keep dma entries aligned.

Oh shoot. How embarrassing they are alligned when the tab width is 4 *g*
Thanks.

-michael

[1] 
https://lore.kernel.org/lkml/20220210123704.477826-1-michael@walle.cc/

>> +                               dma-names = "tx", "rx";
>> +                               clocks = <&nic_clk>;
>> +                               clock-names = "usart";
>> +                               atmel,fifo-size = <32>;
>> +                               status = "disabled";
>> +                       };
>>                 };
>> 
>>                 flx1: flexcom@e0044000 {
>> @@ -102,6 +115,19 @@ flx1: flexcom@e0044000 {
>>                         #size-cells = <1>;
>>                         ranges = <0x0 0xe0044000 0x800>;
>>                         status = "disabled";
>> +
>> +                       usart1: serial@200 {
>> +                               compatible = 
>> "atmel,at91sam9260-usart";
>> +                               reg = <0x200 0x200>;
>> +                               interrupts = <GIC_SPI 49 
>> IRQ_TYPE_LEVEL_HIGH>;
>> +                               dmas = <&dma0 AT91_XDMAC_DT_PERID(5)>,
>> +                                          <&dma0 
>> AT91_XDMAC_DT_PERID(4)>;
>> +                               dma-names = "tx", "rx";
>> +                               clocks = <&nic_clk>;
>> +                               clock-names = "usart";
>> +                               atmel,fifo-size = <32>;
>> +                               status = "disabled";
>> +                       };
>>                 };
>> 
>>                 trng: rng@e0048000 {
>> @@ -129,6 +155,19 @@ flx2: flexcom@e0060000 {
>>                         #size-cells = <1>;
>>                         ranges = <0x0 0xe0060000 0x800>;
>>                         status = "disabled";
>> +
>> +                       usart2: serial@200 {
>> +                               compatible = 
>> "atmel,at91sam9260-usart";
>> +                               reg = <0x200 0x200>;
>> +                               interrupts = <GIC_SPI 50 
>> IRQ_TYPE_LEVEL_HIGH>;
>> +                               dmas = <&dma0 AT91_XDMAC_DT_PERID(7)>,
>> +                                          <&dma0 
>> AT91_XDMAC_DT_PERID(6)>;
>> +                               dma-names = "tx", "rx";
>> +                               clocks = <&nic_clk>;
>> +                               clock-names = "usart";
>> +                               atmel,fifo-size = <32>;
>> +                               status = "disabled";
>> +                       };
>>                 };
>> 
>>                 flx3: flexcom@e0064000 {
>> @@ -144,6 +183,9 @@ usart3: serial@200 {
>>                                 compatible = 
>> "atmel,at91sam9260-usart";
>>                                 reg = <0x200 0x200>;
>>                                 interrupts = <GIC_SPI 51 
>> IRQ_TYPE_LEVEL_HIGH>;
>> +                               dmas = <&dma0 AT91_XDMAC_DT_PERID(9)>,
>> +                                          <&dma0 
>> AT91_XDMAC_DT_PERID(8)>;
>> +                               dma-names = "tx", "rx";
>>                                 clocks = <&nic_clk>;
>>                                 clock-names = "usart";
>>                                 atmel,fifo-size = <32>;
>> @@ -178,6 +220,19 @@ flx4: flexcom@e0070000 {
>>                         #size-cells = <1>;
>>                         ranges = <0x0 0xe0070000 0x800>;
>>                         status = "disabled";
>> +
>> +                       usart4: serial@200 {
>> +                               compatible = 
>> "atmel,at91sam9260-usart";
>> +                               reg = <0x200 0x200>;
>> +                               interrupts = <GIC_SPI 52 
>> IRQ_TYPE_LEVEL_HIGH>;
>> +                               dmas = <&dma0 
>> AT91_XDMAC_DT_PERID(11)>,
>> +                                          <&dma0 
>> AT91_XDMAC_DT_PERID(10)>;
>> +                               dma-names = "tx", "rx";
>> +                               clocks = <&nic_clk>;
>> +                               clock-names = "usart";
>> +                               atmel,fifo-size = <32>;
>> +                               status = "disabled";
>> +                       };
>>                 };
>> 
>>                 timer0: timer@e008c000 {
>> --
>> 2.30.2
>> 

-- 
-michael
