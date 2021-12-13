Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40F9E4730E0
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 16:48:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240120AbhLMPs0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 10:48:26 -0500
Received: from esa.microchip.iphmx.com ([68.232.154.123]:56880 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239266AbhLMPsZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 10:48:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1639410504; x=1670946504;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=XhWtFV7u63XPezj9PznQ9BhMGOrSptpvlb1wVN/lahw=;
  b=nHslaDLXUBtcEQo5i0Fb5IE/QbvIt7xu6er4kkxyhV9Nz2C7mPJBL98M
   QEBXez1qc3C2KDeYjaPTmTpfYKDn3YZbc1dxWrcMSdDIqL7UFHy8VbVfO
   /sRPRbwc0H8IG4RQIEe9SbBseJB4IjG9jL4p7UU4f9Y922gMupqFK6hPN
   dYosYBob3N5IfCxtvMRxtO6Iu+hPxrZ5W6+eFddl9GROS3HqD9y17mYdu
   BB7IB+exFpT6u9in39RuBDTAhlGlI7A1CQQ7AmRF965L8zRcVjbmy4kgk
   Cy1dSWJO3KHyiSPPe0x58Y82o/ZqheMz/OqmZXLnsZ1RTcoyO0BeLliHW
   Q==;
IronPort-SDR: AVUwnS3oZZh7vLD3iu65UD6twSY5iwrBrY6jLD2u2q5hGxQQpO2jPo9yiARUofFx8Ci4va1I92
 KIb8/2wf+cvDzZfwXpVBhV2GGLHRM9WPEpOo40z/7XEg6fpkIe5vDOUjJSp3ED6I+1gPqdPJ+F
 +d2yZ65Ay6gadn/XXr4CzjTH8ElSnQqNewRBT7jOaynBOLFoaF2Q3IaJg5jKaI18WoCjKIVM/b
 fD4D1QAomtoiO0GSS4Cq1H9wv519l0bFh20SLY/Azjya0gFy4rMjKPG8YyhLEPbyOmYoG4eaeq
 n60cRx6ohXCoyo9p33d5DEP5
X-IronPort-AV: E=Sophos;i="5.88,202,1635231600"; 
   d="scan'208";a="79373756"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 13 Dec 2021 08:48:23 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Mon, 13 Dec 2021 08:48:22 -0700
Received: from [10.159.245.112] (10.10.115.15) by chn-vm-ex03.mchp-main.com
 (10.10.85.151) with Microsoft SMTP Server id 15.1.2375.17 via Frontend
 Transport; Mon, 13 Dec 2021 08:48:21 -0700
Subject: Re: [PATCH] ARM: dts: at91: enable watchdog for SAMA5D3 Xplained
To:     Michael Opdenacker <michael.opdenacker@bootlin.com>,
        <robh+dt@kernel.org>, <alexandre.belloni@bootlin.com>,
        <ludovic.desroches@microchip.com>
CC:     <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
References: <20211209154540.6391-1-michael.opdenacker@bootlin.com>
From:   Nicolas Ferre <nicolas.ferre@microchip.com>
Organization: microchip
Message-ID: <9f01d0c7-b5c3-1353-8cc6-ed797e466706@microchip.com>
Date:   Mon, 13 Dec 2021 16:48:20 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20211209154540.6391-1-michael.opdenacker@bootlin.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/12/2021 at 16:45, Michael Opdenacker wrote:
> Like on the SAMA5D2 and SAMA5D4 Xplained boards,
> enable the watchdog device on the SAMA5D3 Xplained board.
> 
> As explained on drivers/watchdog/at91sam9_wdt.c,
> for the watchdog driver to work in Linux, you need to make sure
> that the bootstrap / bootloader doesn't disable the watchdog,
> as the Watchdog Timer Mode Register can be only written to once.
> 
> Signed-off-by: Michael Opdenacker <michael.opdenacker@bootlin.com>

Hi Michael,

Thanks for your patch.

Even if I understand the need for alignment with other sama5 SoCs, I'm 
not planning to take this patch to enable the watchdog by default.

As you highlight, this older watchdog, compared to the ones on sama5d4 
or sama5d2, cannot be re-enabled.
On our usual prebuilt demos and configurations, that don't have watchdog 
support by default, enabling it triggers the following errors:
at91_wdt fffffe40.watchdog: watchdog is disabled
at91_wdt: probe of fffffe40.watchdog failed with error -22

I prefer to let the user enable the watchdog explicitly, on the whole 
chain of components for its use-case and make sure to "pet" it correctly.

Best regards,
   Nicolas

> ---
>   arch/arm/boot/dts/at91-sama5d3_xplained.dts | 4 ++++
>   1 file changed, 4 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/at91-sama5d3_xplained.dts b/arch/arm/boot/dts/at91-sama5d3_xplained.dts
> index d72c042f2850..440eccc9eb38 100644
> --- a/arch/arm/boot/dts/at91-sama5d3_xplained.dts
> +++ b/arch/arm/boot/dts/at91-sama5d3_xplained.dts
> @@ -79,6 +79,10 @@ timer1: timer@1 {
>                                  };
>                          };
> 
> +                       watchdog: watchdog@fffffe40 {
> +                               status = "okay";
> +                       };
> +
>                          i2c0: i2c@f0014000 {
>                                  pinctrl-0 = <&pinctrl_i2c0_pu>;
>                                  status = "okay";
> --
> 2.25.1
> 


-- 
Nicolas Ferre
