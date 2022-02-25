Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4C124C4256
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 11:32:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239534AbiBYKcR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 05:32:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230500AbiBYKcP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 05:32:15 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4EF87658;
        Fri, 25 Feb 2022 02:31:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1645785101; x=1677321101;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=KQD7n9IlWz2cK2vL5gVsYXD/voNOuf0gAg5CPXpfExk=;
  b=w5GrchaIn/OgyJZO0spkAwFNSkKOFz16hUA/ywcL8N5wCXQRAVl1YbQT
   NXaNMOs0wWxmUbjpQ6ddSyzwBM08xn8WrhCAH/q9Z8JQNmiRgmNF32Ze5
   eCW9tYTvBLtpKLyA+zHCJ+J90w6Hd+iqorf4rCCIXrztTyjr4AW8hfhnK
   q2MvTPhjoiF7B/MvfQvOG9wj1O/IbalsDg+kc88mfYfhzml8qJ7Ie4b8O
   7Z40XPi1G9ps4XwKNENfhmHJXvHt7w40UNYLGwMugt6U9y3N5GxL1Go9G
   s5UZVGgy9GOzpJVsG7HPqliv9/1Ozo0n7m7UXX2fls99gbSEY/Vwyse+/
   A==;
X-IronPort-AV: E=Sophos;i="5.90,136,1643698800"; 
   d="scan'208";a="163635846"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 25 Feb 2022 03:31:40 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Fri, 25 Feb 2022 03:31:40 -0700
Received: from [10.12.72.56] (10.10.115.15) by chn-vm-ex03.mchp-main.com
 (10.10.85.151) with Microsoft SMTP Server id 15.1.2375.17 via Frontend
 Transport; Fri, 25 Feb 2022 03:31:38 -0700
Message-ID: <deb6ace6-adfc-bbaa-d31f-16d02a5f762b@microchip.com>
Date:   Fri, 25 Feb 2022 11:31:37 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] clk: at91: sama7g5: Allow MCK1 to be exported and
 referenced in DT
Content-Language: en-US
To:     Stephen Boyd <sboyd@kernel.org>,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        <claudiu.beznea@microchip.com>, <mturquette@baylibre.com>,
        Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>
CC:     <alexandre.belloni@bootlin.com>, <robh+dt@kernel.org>,
        <rdunlap@infradead.org>, <unixbhaskar@gmail.com>,
        <linux-clk@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
References: <20220111125310.902856-1-tudor.ambarus@microchip.com>
 <20220125010554.BB92BC340E4@smtp.kernel.org>
From:   Nicolas Ferre <nicolas.ferre@microchip.com>
Organization: microchip
In-Reply-To: <20220125010554.BB92BC340E4@smtp.kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,T_SCC_BODY_TEXT_LINE,T_SPF_PERMERROR
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/01/2022 at 02:05, Stephen Boyd wrote:
> Quoting Tudor Ambarus (2022-01-11 04:53:10)
>> MCK1 feeds the External Bus Interface (EBI). EBI's clock rate is used
>> to translate EBI's timmings to SMC timings, thus we need to handle MCK1
>> in the EBI driver. Allow MCK1 to be referenced as a PMC_TYPE_CORE clock
>> from phandle in DT.
>>
>> Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
>> ---
> 
> Applied to clk-next

Hi Stephen,

I depend on the PMC_MCK1 definition for some of the DT patches that I 
must queue for my pull request to arm-soc, for 5.18.

Would you mind doing an immutable branch for me to pull from, so that 
the build doesn't crash while the clock tree is not integrated yet with 
my patches?

Tell me if there's a better way, as well.

Thanks, best regards,
   Nicolas

-- 
Nicolas Ferre
