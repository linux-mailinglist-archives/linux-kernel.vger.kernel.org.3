Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B1BC5081AF
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 09:05:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359576AbiDTHI3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 03:08:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231806AbiDTHIZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 03:08:25 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E9F22559B;
        Wed, 20 Apr 2022 00:05:40 -0700 (PDT)
Received: from [192.168.1.111] (91-156-85-209.elisa-laajakaista.fi [91.156.85.209])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id ECC0625B;
        Wed, 20 Apr 2022 09:05:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1650438338;
        bh=XI60ceOSPiOukm0RgGIMWmc07mkMjnkrZjqcQsrwgeI=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=VP5344N7sW30pjejQzEYeRU72UYfQq6pmhRTDBQhDQceHec72h4/ndutm5YbALjJh
         zHK/HVvwAhsTafWTtjvE3rYp5aHDvRw1yOcZaW6Hwo2Nc6UtiMflPFdD+1SmJ9h1su
         no87Z1//a8Iy1x4F1TdwnhnIgetHUrBDTjOrpvt0=
Message-ID: <f5eb63b1-8381-99c8-55fa-cc9287103aa8@ideasonboard.com>
Date:   Wed, 20 Apr 2022 10:05:34 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH 1/2] dt-bindings: display: ti,am65x-dss: Add missing
 register & interrupt
Content-Language: en-US
To:     Rob Herring <robh@kernel.org>
Cc:     Jyri Sarha <jyri.sarha@iki.fi>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Nishanth Menon <nm@ti.com>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Devicetree <devicetree@vger.kernel.org>,
        Linux ARM Kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        Nikhil Devshatwar <nikhil.nd@ti.com>,
        Aradhya Bhatia <a-bhatia1@ti.com>
References: <20220419070302.16502-1-a-bhatia1@ti.com>
 <20220419070302.16502-2-a-bhatia1@ti.com>
 <Yl7FEuHEy66KUc5F@robh.at.kernel.org>
From:   Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
In-Reply-To: <Yl7FEuHEy66KUc5F@robh.at.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 19/04/2022 17:20, Rob Herring wrote:
> On Tue, Apr 19, 2022 at 12:33:01PM +0530, Aradhya Bhatia wrote:
>> The DSS IP on the ti-am65x soc supports an additional register space,
>> named "common1". Further. the IP services a maximum number of 2
>> interrupts.
>>
>> Add the missing register space "common1" and the additional interrupt.
>>
>> Signed-off-by: Aradhya Bhatia <a-bhatia1@ti.com>
>> ---
>>   .../devicetree/bindings/display/ti/ti,am65x-dss.yaml   | 10 +++++++---
>>   1 file changed, 7 insertions(+), 3 deletions(-)
>>
>> diff --git a/Documentation/devicetree/bindings/display/ti/ti,am65x-dss.yaml b/Documentation/devicetree/bindings/display/ti/ti,am65x-dss.yaml
>> index 5c7d2cbc4aac..102059e9e0d5 100644
>> --- a/Documentation/devicetree/bindings/display/ti/ti,am65x-dss.yaml
>> +++ b/Documentation/devicetree/bindings/display/ti/ti,am65x-dss.yaml
>> @@ -26,6 +26,7 @@ properties:
>>         Addresses to each DSS memory region described in the SoC's TRM.
>>       items:
>>         - description: common DSS register area
>> +      - description: common1 DSS register area
> 
> You've just broken the ABI.
> 
> New entries have to go on the end.

I'm curious, if the 'reg-names' is a required property, as it is here, 
does this still break the ABI?

  Tomi
