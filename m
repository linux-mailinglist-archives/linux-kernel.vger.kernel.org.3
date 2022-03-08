Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 007044D1B50
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 16:05:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347752AbiCHPGo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 10:06:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231797AbiCHPGm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 10:06:42 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C70F4DF40;
        Tue,  8 Mar 2022 07:05:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1646751943; x=1678287943;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Ouxu32ZZ3ErI719+yDAu19U1sqNjg9u9G2/LmffjHiU=;
  b=qzXEeKG/GjRggPv7sD5b2/6HndOwnUfiRDvIuWLRSeXb1W73WVnOaNmz
   1qfyrTUo9+4HfGV3+wS3vFB2O0TG7j0wJEUM8MIdgxkfUmcCgmAq7xqJO
   SMtwllG2GsvkPG8cB4pbg0NyOs9OpsLDcQ1RzU9ZTKh0WVm2gMwlWwCHx
   M8c9ef/1koWPwstBIwrpXMMqfq7IFo1Z6WMze7RqdAPIl+aU04zSNQdKw
   waJPPnOZx0iXvqqDDnOOc2x4bzvSzBMr3EF4b/MYG6c9ROEWC6S4DJmkE
   8InxCsLTdvTB1y2OgoJ6csfRMfrySlSjxhWjfGt7g0f+NxFenIeCtah/Y
   w==;
X-IronPort-AV: E=Sophos;i="5.90,165,1643698800"; 
   d="scan'208";a="155662815"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 08 Mar 2022 08:05:06 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Tue, 8 Mar 2022 08:05:02 -0700
Received: from [10.12.73.60] (10.10.115.15) by chn-vm-ex02.mchp-main.com
 (10.10.85.144) with Microsoft SMTP Server id 15.1.2375.17 via Frontend
 Transport; Tue, 8 Mar 2022 08:05:00 -0700
Message-ID: <37fee57d-f1df-e1b1-a07c-be8775ffb3cb@microchip.com>
Date:   Tue, 8 Mar 2022 16:05:00 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] clk: at91: sama7g5: fix parents of PDMCs' GCLK
Content-Language: en-US
To:     Claudiu Beznea - M18063 <Claudiu.Beznea@microchip.com>,
        "Codrin Ciubotariu - M19940" <Codrin.Ciubotariu@microchip.com>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "sboyd@kernel.org" <sboyd@kernel.org>
CC:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "alexandre.belloni@bootlin.com" <alexandre.belloni@bootlin.com>
References: <20220304182616.1920392-1-codrin.ciubotariu@microchip.com>
 <2d6f6552-5ff8-295d-e7e1-d4dc5f767ebd@microchip.com>
From:   Nicolas Ferre <nicolas.ferre@microchip.com>
Organization: microchip
In-Reply-To: <2d6f6552-5ff8-295d-e7e1-d4dc5f767ebd@microchip.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
        T_SCC_BODY_TEXT_LINE,T_SPF_PERMERROR autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/03/2022 at 10:47, Claudiu Beznea - M18063 wrote:
> On 04.03.2022 20:26, Codrin Ciubotariu wrote:
>> Audio PLL can be used as parent by the GCLKs of PDMCs.
>>
>> Fixes: cb783bbbcf54 ("clk: at91: sama7g5: add clock support for sama7g5")
>> Signed-off-by: Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
> 
> Reviewed-by: Claudiu Beznea <claudiu.beznea@microchip.com>

Acked-by: Nicolas Ferre <nicolas.ferre@microchip.com>
I'm taking this patch for a PR sent to Stephen for 5.18.

Best regards,
   Nicolas

>> ---
>>   drivers/clk/at91/sama7g5.c | 8 ++++----
>>   1 file changed, 4 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/clk/at91/sama7g5.c b/drivers/clk/at91/sama7g5.c
>> index e43458673afb..9a213ba9e58b 100644
>> --- a/drivers/clk/at91/sama7g5.c
>> +++ b/drivers/clk/at91/sama7g5.c
>> @@ -699,16 +699,16 @@ static const struct {
>>   	{ .n  = "pdmc0_gclk",
>>   	  .id = 68,
>>   	  .r = { .max = 50000000  },
>> -	  .pp = { "syspll_divpmcck", "baudpll_divpmcck", },
>> -	  .pp_mux_table = { 5, 8, },
>> +	  .pp = { "syspll_divpmcck", "audiopll_divpmcck", },
>> +	  .pp_mux_table = { 5, 9, },
>>   	  .pp_count = 2,
>>   	  .pp_chg_id = INT_MIN, },
>>   
>>   	{ .n  = "pdmc1_gclk",
>>   	  .id = 69,
>>   	  .r = { .max = 50000000, },
>> -	  .pp = { "syspll_divpmcck", "baudpll_divpmcck", },
>> -	  .pp_mux_table = { 5, 8, },
>> +	  .pp = { "syspll_divpmcck", "audiopll_divpmcck", },
>> +	  .pp_mux_table = { 5, 9, },
>>   	  .pp_count = 2,
>>   	  .pp_chg_id = INT_MIN, },
>>   
> 


-- 
Nicolas Ferre
