Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4147E58D3C9
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Aug 2022 08:32:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237514AbiHIGb6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Aug 2022 02:31:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235179AbiHIGby (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Aug 2022 02:31:54 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61BB71901F;
        Mon,  8 Aug 2022 23:31:53 -0700 (PDT)
Received: from [192.168.1.111] (91-158-154-79.elisa-laajakaista.fi [91.158.154.79])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 08C8E3F1;
        Tue,  9 Aug 2022 08:31:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1660026711;
        bh=pRkiH090hm/3+AzIhawmn+O3nQNdF8FZ7zjdilQgQvM=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=dtLhiHZqB//pIENe29MK1W35VjCbvu3uxsuL3XBQSZuqpKHadZIFzS+WTWuRqMXgW
         hyETYuRo9VROcKajrZYNR46y8/FEhQXZ4aSdgdDF2+ChXQAsfc017U6XC6VtPCdE9O
         1/HnyNEd4yXRU6hAAGXQbpAIyRrFBmoYMQXbm/To=
Message-ID: <1a394a4d-1099-400f-2b52-e7a02e379cba@ideasonboard.com>
Date:   Tue, 9 Aug 2022 09:31:46 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v3 2/2] drm/tidss: Add support for AM625 DSS
Content-Language: en-US
To:     Aradhya Bhatia <a-bhatia1@ti.com>, Jyri Sarha <jyri.sarha@iki.fi>,
        Rob Herring <robh+dt@kernel.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Nishanth Menon <nm@ti.com>,
        Devicetree List <devicetree@vger.kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Devarsh Thakkar <devarsht@ti.com>,
        Linux Kernel List <linux-kernel@vger.kernel.org>,
        DRI Development List <dri-devel@lists.freedesktop.org>,
        Rahul T R <r-ravikumar@ti.com>
References: <20220627151200.4693-1-a-bhatia1@ti.com>
 <20220627151200.4693-3-a-bhatia1@ti.com>
 <4382b760-418f-4033-97f2-47e082a30232@ideasonboard.com>
 <cb9ada9f-9673-2039-c22b-fa0d3345fe41@ti.com>
From:   Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
In-Reply-To: <cb9ada9f-9673-2039-c22b-fa0d3345fe41@ti.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/08/2022 09:08, Aradhya Bhatia wrote:
> Hi Tomi,
> 
> On 28-Jul-22 17:34, Tomi Valkeinen wrote:
>> On 27/06/2022 18:12, Aradhya Bhatia wrote:
>>> Add support for the DSS IP on TI's new AM625 SoC in the tidss driver.
>>>
>>> Signed-off-by: Aradhya Bhatia <a-bhatia1@ti.com>
>>> Reviewed-by: Rahul T R <r-ravikumar@ti.com>
>>> ---
>>>   drivers/gpu/drm/tidss/tidss_dispc.c | 56 ++++++++++++++++++++++++++++-
>>>   drivers/gpu/drm/tidss/tidss_dispc.h |  2 ++
>>>   drivers/gpu/drm/tidss/tidss_drv.c   |  1 +
>>>   3 files changed, 58 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/gpu/drm/tidss/tidss_dispc.c 
>>> b/drivers/gpu/drm/tidss/tidss_dispc.c
>>> index dae47853b728..f084f0688a54 100644
>>> --- a/drivers/gpu/drm/tidss/tidss_dispc.c
>>> +++ b/drivers/gpu/drm/tidss/tidss_dispc.c
>>> @@ -272,6 +272,55 @@ const struct dispc_features dispc_j721e_feats = {
>>>       .vid_order = { 1, 3, 0, 2 },
>>>   };
>>> +const struct dispc_features dispc_am625_feats = {
>>> +    .max_pclk_khz = {
>>> +        [DISPC_VP_DPI] = 165000,
>>> +        [DISPC_VP_OLDI] = 165000,
>>> +    },
>>> +
>>> +    .scaling = {
>>> +        .in_width_max_5tap_rgb = 1280,
>>> +        .in_width_max_3tap_rgb = 2560,
>>> +        .in_width_max_5tap_yuv = 2560,
>>> +        .in_width_max_3tap_yuv = 4096,
>>> +        .upscale_limit = 16,
>>> +        .downscale_limit_5tap = 4,
>>> +        .downscale_limit_3tap = 2,
>>> +        /*
>>> +         * The max supported pixel inc value is 255. The value
>>> +         * of pixel inc is calculated like this: 1+(xinc-1)*bpp.
>>> +         * The maximum bpp of all formats supported by the HW
>>> +         * is 8. So the maximum supported xinc value is 32,
>>> +         * because 1+(32-1)*8 < 255 < 1+(33-1)*4.
>>> +         */
>>> +        .xinc_max = 32,
>>> +    },
>>> +
>>> +    .subrev = DISPC_AM625,
>>> +
>>> +    .common = "common",
>>> +    .common_regs = tidss_am65x_common_regs,
>>> +
>>> +    .num_vps = 2,
>>> +    .vp_name = { "vp1", "vp2" },
>>> +    .ovr_name = { "ovr1", "ovr2" },
>>> +    .vpclk_name =  { "vp1", "vp2" },
>>> +    .vp_bus_type = { DISPC_VP_OLDI, DISPC_VP_DPI },
>>
>> This looks correct, but with the two OLDI TXes, I think there will be 
>> some interesting issues.
>>
>> The tidss_kms.c associates a DSS VP and a DT port, but that's no 
>> longer true if you add the ports for both OLDI TXes, as they both use 
>> the same VP. I think fixing that won't affect this patch, though, and 
>> merging this patch will, afaik, enable similar DSS functionality as we 
>> have for AM65x.
>>
>> So, I think these two patches could be merged, or we could wait a bit 
>> until the OLDI situation becomes more clear. Up to you. In any case, 
>> for both patches:
>>
>> Reviewed-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>\
> 
> Thank you for the review!
> 
> This patch set is required for the dss DT patches to be upstreamed for
> the AM625-SK, so I would like them to get merged.
> 
> Since these were posted in the previous merge window, I will re-send 
> with your tag.

I'd like to understand better the dual OLDI TX case before merging any 
AM625 dss changes.

At the moment you have only one port in the DT for the OLDI TX for 
AM625, right? I don't see how that is supposed to work as there are two 
OLDI outputs. And if we do add a new port, it perhaps makes sense to 
have two OLDI TX ports as ports 0 and 1, and the DPI as port 2, which is 
then different from AM65x.

  Tomi
