Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9A1B4AB6F8
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Feb 2022 10:08:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348488AbiBGI7x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 03:59:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244055AbiBGI4o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 03:56:44 -0500
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60A41C043188
        for <linux-kernel@vger.kernel.org>; Mon,  7 Feb 2022 00:56:43 -0800 (PST)
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com [209.85.128.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id EC1864003C
        for <linux-kernel@vger.kernel.org>; Mon,  7 Feb 2022 08:56:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1644224201;
        bh=btDpU5FmsTkCm5Mc+WyqRMkXXG3Fg8Z86T3tz0oN0CM=;
        h=Message-ID:Date:MIME-Version:Subject:To:References:From:
         In-Reply-To:Content-Type;
        b=HepHLUJh7x3PakI0ZWJV0Iy7bSoGdHu68AE9wjL1bUgbOacsNEc5ZVSrOoXzIbjPP
         a2Qxm9VLBNzFNIkPVJkF+Lbckf7nhUN9rbwd0uBTKK7qu+bpmYt8QblGX9f8lvBLWw
         Py6vDiaJkyNirKJK72AyzQloEdSdt/7Wo4RlKQvIY8IGpuo+epS2wKfwtSKYPdNRM/
         cpNYofpHIkOAGiD+v80C3L6PYsT4zNcXtyY5X8yVklFD7WrzybSLq5flIp+60DfxD2
         qDrD18XitNL3p3LmdhA6LB2i/4ktTlRpe2OrY4zh7T2fj3owW7+e9MjQEzItDE+VMp
         R+vxYns3BDtYQ==
Received: by mail-wm1-f70.google.com with SMTP id bg16-20020a05600c3c9000b0034bea12c043so11906293wmb.7
        for <linux-kernel@vger.kernel.org>; Mon, 07 Feb 2022 00:56:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=btDpU5FmsTkCm5Mc+WyqRMkXXG3Fg8Z86T3tz0oN0CM=;
        b=WiA3/ZpPeHO59ps8cfFiZLpDLHd9Tr1eMRGS677+cuhNitcI6YUxafoxxdPMyCTodY
         6PlSrAmNCEwNGlaV0w0TB5v/InSO3Wu4qeKRXvzvVP8k/J8+5qs0qBDNp6o8ykNIac5h
         GN3vKCuHilCvJ2vJ9yXqkuKNv+7cEF5CuELDCOrE52xv1117PTf2vlwFmT4OPVQhyykR
         rmlCe3yB229tDeE3dt6uP6tvYv2VKcYPoLmfd+kAPaNOprMCWZLI+8HmJ3u7eGjj+26a
         bPqxChZAXV4GnE9wbPi4MtEARwm1Vfeqsl82jpCJHAi1KFtDNn/SWtP+o2JZfoSG91ik
         8W6A==
X-Gm-Message-State: AOAM533IylikWUgii8uTKEiOjH2jxATTovYjdnRW+XsJGxZmUhn4WgAc
        Z1I2vwrodh5dNvTzdVan3Bcc633FM8jNxRy8Zl2Y042W2OKiVovPD03KzCK87VqFDLH2m5u4bkf
        s5H7VnwNJHjI80LPIByJVNsL1VcPOcYcVBNMRMUHxGg==
X-Received: by 2002:a05:6000:16c5:: with SMTP id h5mr9011101wrf.364.1644224201261;
        Mon, 07 Feb 2022 00:56:41 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwUWIz/kuedsRBnrB7RSMh9Ojazqtas2KPEtQ5IG7MGExl8fZ8JQjN+4o3EFV9rqV86qk4Cxw==
X-Received: by 2002:a05:6000:16c5:: with SMTP id h5mr9011087wrf.364.1644224201104;
        Mon, 07 Feb 2022 00:56:41 -0800 (PST)
Received: from [192.168.0.86] (xdsl-188-155-168-84.adslplus.ch. [188.155.168.84])
        by smtp.gmail.com with ESMTPSA id t14sm17259601wmq.43.2022.02.07.00.56.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Feb 2022 00:56:40 -0800 (PST)
Message-ID: <4b18991e-1c93-077d-368f-a861e8c2b845@canonical.com>
Date:   Mon, 7 Feb 2022 09:56:39 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v3 5/8] dt-bindings: memory: lpddr3: deprecate
 manufacturer ID
Content-Language: en-US
To:     Alim Akhtar <alim.akhtar@samsung.com>,
        'Rob Herring' <robh+dt@kernel.org>,
        'Lukasz Luba' <lukasz.luba@arm.com>,
        'Dmitry Osipenko' <digetx@gmail.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20220206135807.211767-1-krzysztof.kozlowski@canonical.com>
 <CGME20220206135825epcas5p4c07136cf0a54eb4d6c8441cd6dbf14bc@epcas5p4.samsung.com>
 <20220206135807.211767-6-krzysztof.kozlowski@canonical.com>
 <0a7101d81bd9$33088840$991998c0$@samsung.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
In-Reply-To: <0a7101d81bd9$33088840$991998c0$@samsung.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/02/2022 05:14, Alim Akhtar wrote:
> Hi Krzysztof
> 
>> -----Original Message-----
>> From: Krzysztof Kozlowski [mailto:krzysztof.kozlowski@canonical.com]
>> Sent: Sunday, February 6, 2022 7:28 PM
>> To: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>; Rob Herring
>> <robh+dt@kernel.org>; Lukasz Luba <lukasz.luba@arm.com>; Alim Akhtar
>> <alim.akhtar@samsung.com>; Dmitry Osipenko <digetx@gmail.com>; linux-
>> kernel@vger.kernel.org; devicetree@vger.kernel.org; linux-
>> pm@vger.kernel.org; linux-samsung-soc@vger.kernel.org; linux-arm-
>> kernel@lists.infradead.org
>> Subject: [PATCH v3 5/8] dt-bindings: memory: lpddr3: deprecate
>> manufacturer ID
>>
>> The memory manufacturer should be described in vendor part of compatible,
>> so there is no need to duplicate it in a separate property.
>> Similarly is done in LPDDR2 bindings.
>>
>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
>> ---
>> .../bindings/memory-controllers/ddr/jedec,lpddr3.yaml         | 4 +++-
>> 1 file changed, 3 insertions(+), 1 deletion(-)
>>
>> diff --git a/Documentation/devicetree/bindings/memory-
>> controllers/ddr/jedec,lpddr3.yaml
>> b/Documentation/devicetree/bindings/memory-
>> controllers/ddr/jedec,lpddr3.yaml
>> index d6787b5190ee..3bcba15098ea 100644
>> --- a/Documentation/devicetree/bindings/memory-
>> controllers/ddr/jedec,lpddr3.yaml
>> +++ b/Documentation/devicetree/bindings/memory-
>> controllers/ddr/jedec,lpd
>> +++ dr3.yaml
>> @@ -40,7 +40,9 @@ properties:
>>   manufacturer-id:
>>     $ref: /schemas/types.yaml#/definitions/uint32
>>     description: |
>> -      Manufacturer ID value read from Mode Register 5.
>> +      Manufacturer ID value read from Mode Register 5.  The property is
>> +      deprecated, manufacturer should be derived from the compatible.
>> +    deprecated: true
>>
> 
> Shouldn't it be the other way? As DT describes hardware and MR5 does contain
> the Manufacturer ID, 
> so getting Manufacturer ID from MR5 makes aligned to hardware description.

The code/driver can read MR5 and report it to user-space in case for
example we have a device compatible with different vendor and same
compatible is used. So compatible is re-used but we want real
manufacturer ID from the hardware.

But storing a fixed MR5 value in DT does not fit here. If someone takes
effort to encode manufacturer ID in the DTS, then he/she should take
effort to actually document the compatible.

Basically having MR5 in DT is equal to having a compatible in DTS. I
prefer the latter - simpler, less properties, using existing property
from DT spec instead of custom one.

Best regards,
Krzysztof
