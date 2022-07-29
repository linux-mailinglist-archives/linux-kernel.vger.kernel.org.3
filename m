Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2AFF584A75
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jul 2022 05:57:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233945AbiG2D5W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jul 2022 23:57:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234165AbiG2D5U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jul 2022 23:57:20 -0400
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B6237D1C6;
        Thu, 28 Jul 2022 20:57:17 -0700 (PDT)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 26T3uuPT110119;
        Thu, 28 Jul 2022 22:56:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1659067016;
        bh=Vt0VHKRHoAGRwb0JuT/P1s1lR5MiWqzD+L1IqtnBN4g=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=rGGQPDRA7K6qQxES6ycnI2HE7vuhdTGYsI5rit3UQUA4aErthBK4gRr1BXIBevsdy
         adXIeREC3b//mVvvcIBGT4OB6z2g1lEnbKquUEBB19zcFEhsdf7Vd0K9bqVGbdSYkK
         3aNcR/QnUgFDqiM+irPtSHuYg2l88ABlbT/JvVlw=
Received: from DLEE112.ent.ti.com (dlee112.ent.ti.com [157.170.170.23])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 26T3uu6c103501
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 28 Jul 2022 22:56:56 -0500
Received: from DLEE109.ent.ti.com (157.170.170.41) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Thu, 28
 Jul 2022 22:56:56 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Thu, 28 Jul 2022 22:56:56 -0500
Received: from [172.24.157.172] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 26T3une5095020;
        Thu, 28 Jul 2022 22:56:50 -0500
Message-ID: <5abdc690-3b0d-0763-2a8a-30d1516c8ab0@ti.com>
Date:   Fri, 29 Jul 2022 09:26:49 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.0.3
Subject: Re: [PATCH 7/8] drm/tidss: Fix clock request value for OLDI
 videoports
Content-Language: en-US
To:     Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
CC:     Darren Etheridge <detheridge@ti.com>, Nishanth Menon <nm@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Rahul T R <r-ravikumar@ti.com>,
        Krunal Bhargav <k-bhargav@ti.com>,
        Devarsh Thakkar <devarsht@ti.com>,
        DRI Development List <dri-devel@lists.freedesktop.org>,
        Devicetree List <devicetree@vger.kernel.org>,
        Linux Kernel List <linux-kernel@vger.kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>, Jyri Sarha <jyri.sarha@iki.fi>
References: <20220719080845.22122-1-a-bhatia1@ti.com>
 <20220719080845.22122-8-a-bhatia1@ti.com>
 <03c77b33-271c-5cb3-fe00-cda7ff21102b@ideasonboard.com>
From:   Aradhya Bhatia <a-bhatia1@ti.com>
In-Reply-To: <03c77b33-271c-5cb3-fe00-cda7ff21102b@ideasonboard.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 28-Jul-22 15:35, Tomi Valkeinen wrote:
> On 19/07/2022 11:08, Aradhya Bhatia wrote:
>> The OLDI TX(es) require a serial clock which is 7 times the pixel clock
>> of the display panel. When the OLDI is enabled in DSS, the pixel clock
>> input of the corresponding videoport gets a divided-by 7 value of the
>> requested clock.
>>
>> For the am625-dss, the requested clock needs to be 7 times the value.
>>
>> Update the clock frequency by requesting 7 times the value.
>>
>> Signed-off-by: Aradhya Bhatia <a-bhatia1@ti.com>
>> ---
>>   drivers/gpu/drm/tidss/tidss_dispc.c | 10 ++++++++++
>>   1 file changed, 10 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/tidss/tidss_dispc.c 
>> b/drivers/gpu/drm/tidss/tidss_dispc.c
>> index c4a5f808648f..0b9689453ee8 100644
>> --- a/drivers/gpu/drm/tidss/tidss_dispc.c
>> +++ b/drivers/gpu/drm/tidss/tidss_dispc.c
>> @@ -1326,6 +1326,16 @@ int dispc_vp_set_clk_rate(struct dispc_device 
>> *dispc, u32 hw_videoport,
>>       int r;
>>       unsigned long new_rate;
>> +    /*
>> +     * For AM625 OLDI video ports, the requested pixel clock needs to 
>> take into account the
>> +     * serial clock required for the serialization of DPI signals 
>> into LVDS signals. The
>> +     * incoming pixel clock on the OLDI video port gets divided by 7 
>> whenever OLDI enable bit
>> +     * gets set.
>> +     */
>> +    if (dispc->feat->vp_bus_type[hw_videoport] == DISPC_VP_OLDI &&
>> +        dispc->feat->subrev == DISPC_AM625)
>> +        rate *= 7;
>> +
>>       r = clk_set_rate(dispc->vp_clk[hw_videoport], rate);
>>       if (r) {
>>           dev_err(dispc->dev, "vp%d: failed to set clk rate to %lu\n",
> 
> The AM625 TRM seems to be missing the "DSS integration" section, even if 
> it's referred to in three places in the TRM. Supposedly that has details 
> about the clocking.
> 
> Shouldn't the source clock be 3.5x when dual-link mode is used?
There should not be.

Whenever OLDI is enabled, the clock generated from the PLL is 7 times
the required pixel clock.

For the OLDI TXes, the clock passes through a /2 divider. This divider
only gets activated when the dual mode has been enabled in the OLDI
configuration. Thus the OLDI TXes get 3.5x the pixel clock in dual mode.

When the OLDI has been configured for a single mode,
the PLL clock passes through the /2 divider without any change.

> 
> While I don't know the details, this doesn't feel correct. We're 
> supposed to be setting the VP pixel clock here, and the serial clock 
> would be derived from that as it's done on AM65x. Is the DT clock tree
> wrong for AM625?
Ideally, yes, its the pixel frequency that we are supposed to set here.

The same PLL clock (7 times the pixel frequency) passes through a /7
clock divider. This clock divider only gets active when OLDI is enabled.
Thus, the DSS VP clock input, only gets the actual pixel frequency that
it needs.

Since, the /7 divider is controlled by a signal from the DSS, the driver
needs to request 7 times more the pixel clock to accommodate for the
divider.

In AM65X, the system FW is able to model the 7 times requirement because
the divider is not controlled by the DSS signal. DSS signal controls a
multiplexer which receives both PLL Clock and PLL / 7 clock.


Regards
Aradhya
