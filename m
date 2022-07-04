Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDD66565D00
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 19:34:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229771AbiGDReM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 13:34:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229671AbiGDReJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 13:34:09 -0400
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::228])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A795BFD3B
        for <linux-kernel@vger.kernel.org>; Mon,  4 Jul 2022 10:34:05 -0700 (PDT)
Received: (Authenticated sender: clement.leger@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPA id EE2571BF20A;
        Mon,  4 Jul 2022 17:34:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1656956043;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=v4ySACSpNhWvmIlYvPpx0FlEnih7rbgRBTZHLz8rJjc=;
        b=e9jtzXtqknIQcGussNHER5Zad2A2pcGQKlTMcXi8hcekU2frnnPsHU+KtHIQRSeBFDPnkf
        CDTmemdWAw95cm5v5ATmwyMST9c/A9oo87K7+7xo0BAKyf+y2dVOLctU7ar7NWnITOXIA0
        8fdEmg8cbwy61qufd0u8UE6boaOl7Vomti9u3jThBjDLTK+1KIS/xMHXZgiTZPLlS9+pLv
        R1k0aBPwpXXz5bgErH+UcRVdLwJ1qfvL67FrOMArzwOG38CKHCprIx5bsynw8r35IdlFGL
        D2wxmkwmiuaABnGeh+lHPkHXWY+nX+ozX3XZw4z1Erw85TSqVX9K4IlNHW1mEA==
MIME-Version: 1.0
Date:   Mon, 04 Jul 2022 19:34:02 +0200
From:   clement.leger@bootlin.com
To:     Claudiu.Beznea@microchip.com
Cc:     linux@armlinux.org.uk, Nicolas.Ferre@microchip.com,
        alexandre.belloni@bootlin.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        thomas.petazzoni@bootlin.com
Subject: Re: [PATCH 1/2] ARM: at91: add sam_linux_is_in_normal_world()
 function
In-Reply-To: <fe771973-e9aa-d397-1849-41617cc2d226@microchip.com>
References: <20220606145701.185552-1-clement.leger@bootlin.com>
 <20220606145701.185552-2-clement.leger@bootlin.com>
 <fe771973-e9aa-d397-1849-41617cc2d226@microchip.com>
Message-ID: <386e02d5067da8e684332c5a788326ee@bootlin.com>
X-Sender: clement.leger@bootlin.com
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le 2022-07-04 08:19, Claudiu.Beznea@microchip.com a écrit :
> Hi, Clement,
> 
> On 06.06.2022 17:57, Clément Léger wrote:
>> EXTERNAL EMAIL: Do not click links or open attachments unless you know 
>> the content is safe
>> 
>> Add sam_linux_is_in_normal_world() which allows to know if Linux is
>> running in the normal world or not. This function is used by code
>> which needs to differentiate the world in which Linux is running.
>> 
>> Signed-off-by: Clément Léger <clement.leger@bootlin.com>
>> ---
>>  arch/arm/mach-at91/sam_secure.c | 6 ++++++
>>  arch/arm/mach-at91/sam_secure.h | 1 +
>>  2 files changed, 7 insertions(+)
>> 
>> diff --git a/arch/arm/mach-at91/sam_secure.c 
>> b/arch/arm/mach-at91/sam_secure.c
>> index 2a01f7a7d13f..1ec8c8b9d119 100644
>> --- a/arch/arm/mach-at91/sam_secure.c
>> +++ b/arch/arm/mach-at91/sam_secure.c
>> @@ -27,6 +27,12 @@ struct arm_smccc_res sam_smccc_call(u32 fn, u32 
>> arg0, u32 arg1)
>>         return res;
>>  }
>> 
>> +bool sam_linux_is_in_normal_world(void)
>> +{
>> +       /* If optee has been detected, then we are running in normal 
>> world */
> 
> In case optee hasn't been detected don't we run also in normal world?
> What I want to say is that maybe you can change the function name to
> something like sam_linux_is_optee_available().

I would say it depends on the bootloader configuration, but Linux can 
run
in secure world also. It would not change a lot of thing though.
However, you are right sam_linux_optee_is_available() seems easier to
understand ;)

Clément
