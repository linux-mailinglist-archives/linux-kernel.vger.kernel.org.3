Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A47256823B
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 10:58:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232588AbiGFI5m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 04:57:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231959AbiGFI5h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 04:57:37 -0400
Received: from ssl.serverraum.org (ssl.serverraum.org [IPv6:2a01:4f8:151:8464::1:2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E3242497D;
        Wed,  6 Jul 2022 01:57:36 -0700 (PDT)
Received: from ssl.serverraum.org (web.serverraum.org [172.16.0.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id DE2C722236;
        Wed,  6 Jul 2022 10:57:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1657097854;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3M+/1GThJ5TiT3Lr6PZgjiW2H7Zb8HKFfY7StVR7M0A=;
        b=mZVIG7QyY0FcofTloSBowi+7bLc0M/RYL5S/pZTVd+QajZohi5mObALZVSqjYNZ4VJotCb
        5izwcgtr8EBhOdhuJ715F1KV7Yca7czm+zvz/IgVVf+2jeqj73RkDtvmylC0ULJYubBhc+
        xwLXaJSrDVBNdxJe49nEW3llIb38jts=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Wed, 06 Jul 2022 10:57:33 +0200
From:   Michael Walle <michael@walle.cc>
To:     Claudiu.Beznea@microchip.com
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        Nicolas.Ferre@microchip.com, alexandre.belloni@bootlin.com,
        Cristian.Birsan@microchip.com,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] ARM: dts: kswitch-d10: enable the USB device port
In-Reply-To: <32a2193f-aea1-6237-a993-d0ba89cce431@microchip.com>
References: <20220705130637.1386120-1-michael@walle.cc>
 <20220705130637.1386120-2-michael@walle.cc>
 <32a2193f-aea1-6237-a993-d0ba89cce431@microchip.com>
User-Agent: Roundcube Webmail/1.4.13
Message-ID: <1747f5d89ca65a9e54d95e7dd77c4709@walle.cc>
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

Hi Claudiu,

Am 2022-07-06 10:41, schrieb Claudiu.Beznea@microchip.com:
> On 05.07.2022 16:06, Michael Walle wrote:
>> EXTERNAL EMAIL: Do not click links or open attachments unless you know 
>> the content is safe
>> 
>> Now that there is driver support for the USB device, enable it.
>> 
>> Signed-off-by: Michael Walle <michael@walle.cc>
>> ---
>>  arch/arm/boot/dts/lan966x-kontron-kswitch-d10-mmt.dtsi | 5 +++++
>>  1 file changed, 5 insertions(+)
>> 
>> diff --git a/arch/arm/boot/dts/lan966x-kontron-kswitch-d10-mmt.dtsi 
>> b/arch/arm/boot/dts/lan966x-kontron-kswitch-d10-mmt.dtsi
>> index 5a6c5f7c371a..d0d26e136c38 100644
>> --- a/arch/arm/boot/dts/lan966x-kontron-kswitch-d10-mmt.dtsi
>> +++ b/arch/arm/boot/dts/lan966x-kontron-kswitch-d10-mmt.dtsi
>> @@ -200,6 +200,11 @@ &switch {
>>         status = "okay";
>>  };
>> 
>> +&udc {
>> +       atmel,vbus-gpio = <&gpio 66 GPIO_ACTIVE_HIGH>;
> 
> Can you also add pinctrl to avoid issues described in:

Do I need a pinctrl node even if I just use it as a gpio?
Isn't that handled automatically by the
.gpio_request_enable op?

-michael
