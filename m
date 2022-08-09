Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DEF458D395
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Aug 2022 08:09:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236391AbiHIGJM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Aug 2022 02:09:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236500AbiHIGJF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Aug 2022 02:09:05 -0400
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A0141D32B;
        Mon,  8 Aug 2022 23:09:04 -0700 (PDT)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 27968jgW044816;
        Tue, 9 Aug 2022 01:08:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1660025325;
        bh=wiHB6xD9Q5AdYRvL7AHA6OTJj98bD0Jg2wNMsviboic=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=LCPo+mC7UbTES/O6NyGnVGaKyeZAsQjipQVoTwYjEZcv+OyUBCUnDHOFUe4ho1731
         wMWHqW3zYZ+jFcORYFtDOVy7XbSW7AxShdnd1Cc4WL94izKplEh5cB+Y7eq/Pdl2oF
         OjurfNfhoPU1MePqTl45jaCC/dWJ9HruL+l4zd1M=
Received: from DLEE108.ent.ti.com (dlee108.ent.ti.com [157.170.170.38])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 27968j9U088478
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 9 Aug 2022 01:08:45 -0500
Received: from DLEE105.ent.ti.com (157.170.170.35) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Tue, 9
 Aug 2022 01:08:44 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Tue, 9 Aug 2022 01:08:44 -0500
Received: from [172.24.157.172] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 27968exD088222;
        Tue, 9 Aug 2022 01:08:41 -0500
Message-ID: <cb9ada9f-9673-2039-c22b-fa0d3345fe41@ti.com>
Date:   Tue, 9 Aug 2022 11:38:40 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.0
Subject: Re: [PATCH v3 2/2] drm/tidss: Add support for AM625 DSS
Content-Language: en-US
To:     Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
        Jyri Sarha <jyri.sarha@iki.fi>,
        Rob Herring <robh+dt@kernel.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
CC:     Nishanth Menon <nm@ti.com>,
        Devicetree List <devicetree@vger.kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Devarsh Thakkar <devarsht@ti.com>,
        Linux Kernel List <linux-kernel@vger.kernel.org>,
        DRI Development List <dri-devel@lists.freedesktop.org>,
        Rahul T R <r-ravikumar@ti.com>
References: <20220627151200.4693-1-a-bhatia1@ti.com>
 <20220627151200.4693-3-a-bhatia1@ti.com>
 <4382b760-418f-4033-97f2-47e082a30232@ideasonboard.com>
From:   Aradhya Bhatia <a-bhatia1@ti.com>
In-Reply-To: <4382b760-418f-4033-97f2-47e082a30232@ideasonboard.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tomi,

On 28-Jul-22 17:34, Tomi Valkeinen wrote:
> On 27/06/2022 18:12, Aradhya Bhatia wrote:
>> Add support for the DSS IP on TI's new AM625 SoC in the tidss driver.
>>
>> Signed-off-by: Aradhya Bhatia <a-bhatia1@ti.com>
>> Reviewed-by: Rahul T R <r-ravikumar@ti.com>
>> ---
>>   drivers/gpu/drm/tidss/tidss_dispc.c | 56 ++++++++++++++++++++++++++++-
>>   drivers/gpu/drm/tidss/tidss_dispc.h |  2 ++
>>   drivers/gpu/drm/tidss/tidss_drv.c   |  1 +
>>   3 files changed, 58 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/gpu/drm/tidss/tidss_dispc.c 
>> b/drivers/gpu/drm/tidss/tidss_dispc.c
>> index dae47853b728..f084f0688a54 100644
>> --- a/drivers/gpu/drm/tidss/tidss_dispc.c
>> +++ b/drivers/gpu/drm/tidss/tidss_dispc.c
>> @@ -272,6 +272,55 @@ const struct dispc_features dispc_j721e_feats = {
>>       .vid_order = { 1, 3, 0, 2 },
>>   };
>> +const struct dispc_features dispc_am625_feats = {
>> +    .max_pclk_khz = {
>> +        [DISPC_VP_DPI] = 165000,
>> +        [DISPC_VP_OLDI] = 165000,
>> +    },
>> +
>> +    .scaling = {
>> +        .in_width_max_5tap_rgb = 1280,
>> +        .in_width_max_3tap_rgb = 2560,
>> +        .in_width_max_5tap_yuv = 2560,
>> +        .in_width_max_3tap_yuv = 4096,
>> +        .upscale_limit = 16,
>> +        .downscale_limit_5tap = 4,
>> +        .downscale_limit_3tap = 2,
>> +        /*
>> +         * The max supported pixel inc value is 255. The value
>> +         * of pixel inc is calculated like this: 1+(xinc-1)*bpp.
>> +         * The maximum bpp of all formats supported by the HW
>> +         * is 8. So the maximum supported xinc value is 32,
>> +         * because 1+(32-1)*8 < 255 < 1+(33-1)*4.
>> +         */
>> +        .xinc_max = 32,
>> +    },
>> +
>> +    .subrev = DISPC_AM625,
>> +
>> +    .common = "common",
>> +    .common_regs = tidss_am65x_common_regs,
>> +
>> +    .num_vps = 2,
>> +    .vp_name = { "vp1", "vp2" },
>> +    .ovr_name = { "ovr1", "ovr2" },
>> +    .vpclk_name =  { "vp1", "vp2" },
>> +    .vp_bus_type = { DISPC_VP_OLDI, DISPC_VP_DPI },
> 
> This looks correct, but with the two OLDI TXes, I think there will be 
> some interesting issues.
> 
> The tidss_kms.c associates a DSS VP and a DT port, but that's no longer 
> true if you add the ports for both OLDI TXes, as they both use the same 
> VP. I think fixing that won't affect this patch, though, and merging 
> this patch will, afaik, enable similar DSS functionality as we have for 
> AM65x.
> 
> So, I think these two patches could be merged, or we could wait a bit 
> until the OLDI situation becomes more clear. Up to you. In any case, for 
> both patches:
> 
> Reviewed-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>\

Thank you for the review!

This patch set is required for the dss DT patches to be upstreamed for
the AM625-SK, so I would like them to get merged.

Since these were posted in the previous merge window, I will re-send 
with your tag.

Regards
Aradhya
