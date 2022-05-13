Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EC89526156
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 13:48:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380033AbiEMLsl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 May 2022 07:48:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345668AbiEMLsk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 07:48:40 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1C8D6D4D7
        for <linux-kernel@vger.kernel.org>; Fri, 13 May 2022 04:48:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1652442518; x=1683978518;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=4Ih4NYGQvx1JTZHxx9PQUa0TSEAzzRcd+K+PBWc6L9g=;
  b=R7j724w5vsiU5gfFsk1uRJZnrwOt8ycLOittNTyL6rAMkUGt4g7LzLgN
   z1Owrv14Bjqm9yjCnGHoJs3b8PjKJpwBtKmIoer4RAwiPPBMtAOR5z/u9
   Mc2bUxrJg2AgGRKZ+21e7wIzHbaqN7Rhy4+K2eqD5HKEPN959vvQm+1zU
   Qz+VqYRisFltDsPyGD/lP/3rbwglsspHhvCVFq0xn9Ka+Cnw3lYVw5+44
   D8jWXQwCiGg7vhXqupkKD4MRgOAg3BTcEHMRJW+JD4+Q8/tq351i6p5Gi
   UHhFZooDVtcg4785RLpLs59CD6y9MHLgTWeUI2tGKrQdDhuQ9/R18KPWD
   A==;
X-IronPort-AV: E=Sophos;i="5.91,221,1647327600"; 
   d="scan'208";a="158954210"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 13 May 2022 04:48:37 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Fri, 13 May 2022 04:48:37 -0700
Received: from [10.159.205.135] (10.10.115.15) by chn-vm-ex03.mchp-main.com
 (10.10.85.151) with Microsoft SMTP Server id 15.1.2375.17 via Frontend
 Transport; Fri, 13 May 2022 04:48:35 -0700
Message-ID: <0868bdd4-04d5-cc7e-9f62-28e370e8ae5a@microchip.com>
Date:   Fri, 13 May 2022 13:48:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v3] ARM: at91: debug: add lan966 support
Content-Language: en-US
To:     Michael Walle <michael@walle.cc>,
        Kavyasree Kotagiri <kavyasree.kotagiri@microchip.com>
CC:     <linux@armlinux.org.uk>, <linus.walleij@linaro.org>,
        <alexandre.belloni@bootlin.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <UNGLinuxDriver@microchip.com>,
        <Manohar.Puri@microchip.com>
References: <20220513075035.18663-1-kavyasree.kotagiri@microchip.com>
 <8f5c894ee9670c991e7d2897ef7c84aa@walle.cc>
From:   Nicolas Ferre <nicolas.ferre@microchip.com>
Organization: microchip
In-Reply-To: <8f5c894ee9670c991e7d2897ef7c84aa@walle.cc>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/05/2022 at 11:09, Michael Walle wrote:
> Am 2022-05-13 09:50, schrieb Kavyasree Kotagiri:
>> Add support for low-level debugging on FLEXCOM USART of
>> LAN966 SoC.
>>
>> Signed-off-by: Kavyasree Kotagiri <kavyasree.kotagiri@microchip.com>

Acked-by: Nicolas Ferre <nicolas.ferre@microchip.com>

And queued in at91-soc for 5.19.

Thanks Kavyasree and Michael!
Regards,
   Nicolas


>> ---
>>   arch/arm/Kconfig.debug | 22 ++++++++++++++++++++++
>>   1 file changed, 22 insertions(+)
>>
>> diff --git a/arch/arm/Kconfig.debug b/arch/arm/Kconfig.debug
>> index 0c9497d549e3..b8a2364df9c1 100644
>> --- a/arch/arm/Kconfig.debug
>> +++ b/arch/arm/Kconfig.debug
>> @@ -210,6 +210,26 @@ choice
>>                  Say Y here if you want kernel low-level debugging support
>>                  on the FLEXCOM3 port of SAMA7G5.
>>
>> +     config DEBUG_AT91_LAN966_FLEXCOM
>> +             bool "Kernel low-level debugging on LAN966 FLEXCOM USART"
>> +             select DEBUG_AT91_UART
>> +             depends on SOC_LAN966x
> 
> depends on SOC_LAN966
> 
> With that fixed:
> Reviewed-by: Michael Walle <michael@walle.cc>
> Tested-by: Michael Walle <michael@walle.cc>
> 
> -michael
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel


-- 
Nicolas Ferre
