Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A642B511189
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 08:46:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358315AbiD0GsP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 02:48:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358261AbiD0Grz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 02:47:55 -0400
Received: from thorn.bewilderbeest.net (thorn.bewilderbeest.net [IPv6:2605:2700:0:5::4713:9cab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EEB414AF41;
        Tue, 26 Apr 2022 23:44:45 -0700 (PDT)
Received: from hatter.bewilderbeest.net (174-21-163-222.tukw.qwest.net [174.21.163.222])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: zev)
        by thorn.bewilderbeest.net (Postfix) with ESMTPSA id 94A401BA;
        Tue, 26 Apr 2022 23:44:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bewilderbeest.net;
        s=thorn; t=1651041884;
        bh=Pc/P965/OJeehYyicfBvk821lPIWQ3ALNZy/rCj/WUw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=foeAGPh8IshQudsNi3FtMgXt5RQKupidc5utcg6pJ0R1r6FjqNlVtUXQW5xwSijDa
         0moau1aY1QU0jWseodPxgoHK2iBADT0ddLoE1DGzFdwhqgVagZ3y3fymCG2D1rMCUU
         yGZSzchECmBbKnbjx4tklTDTakXcwJVWwyqn3Wnk=
Date:   Tue, 26 Apr 2022 23:44:40 -0700
From:   Zev Weiss <zev@bewilderbeest.net>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        Renze Nicolai <renze@rnplus.nl>,
        Oleksandr Natalenko <oleksandr@natalenko.name>,
        openbmc@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/7] dt-bindings: hwmon: Add nuvoton,nct6775
Message-ID: <YmjmWNUpCAFYesyk@hatter.bewilderbeest.net>
References: <20220427010154.29749-1-zev@bewilderbeest.net>
 <20220427010154.29749-2-zev@bewilderbeest.net>
 <178b9310-a854-dfa6-a4f3-f971b608abe3@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <178b9310-a854-dfa6-a4f3-f971b608abe3@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 26, 2022 at 11:04:30PM PDT, Krzysztof Kozlowski wrote:
>On 27/04/2022 03:01, Zev Weiss wrote:
>> These Super I/O chips have an i2c interface that some systems expose
>> to a BMC; the BMC's device tree can now describe that via this
>> binding.
>>
>> Signed-off-by: Zev Weiss <zev@bewilderbeest.net>
>
>I already reviewed it so I guess you did not include the tag because of
>significant changes?
>

Yeah, the nuvoton,tsi-channel-mask property is new this round, so I 
dropped the previous R-B -- and since it looks like I missed some stuff, 
thanks for taking another look (though perhaps some of it could have 
been avoided if I'd remembered to run 'make dt_binding_check').

>> ---
>>  .../bindings/hwmon/nuvoton,nct6775.yaml       | 56 +++++++++++++++++++
>>  1 file changed, 56 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/hwmon/nuvoton,nct6775.yaml
>>
>> diff --git a/Documentation/devicetree/bindings/hwmon/nuvoton,nct6775.yaml b/Documentation/devicetree/bindings/hwmon/nuvoton,nct6775.yaml
>> new file mode 100644
>> index 000000000000..418477374fdb
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/hwmon/nuvoton,nct6775.yaml
>> @@ -0,0 +1,56 @@
>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +
>> +$id: http://devicetree.org/schemas/hwmon/nuvoton,nct6775.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: Nuvoton NCT6775 and compatible Super I/O chips
>> +
>> +maintainers:
>> +  - Zev Weiss <zev@bewilderbeest.net>
>> +
>> +properties:
>> +  compatible:
>> +    enum:
>> +      - nuvoton,nct6106
>> +      - nuvoton,nct6116
>> +      - nuvoton,nct6775
>> +      - nuvoton,nct6776
>> +      - nuvoton,nct6779
>> +      - nuvoton,nct6791
>> +      - nuvoton,nct6792
>> +      - nuvoton,nct6793
>> +      - nuvoton,nct6795
>> +      - nuvoton,nct6796
>> +      - nuvoton,nct6797
>> +      - nuvoton,nct6798
>> +
>> +  reg:
>> +    maxItems: 1
>> +
>> +  nuvoton,tsi-channel-mask:
>> +    description:
>> +      Bitmask indicating which TSI temperature sensor channels are
>> +      active.  LSB is TSI0, bit 1 is TSI1, etc.
>
>Need a type/ref.
>

Ack, thanks.

>> +    maximum: 0xff
>> +    default: 0
>
>Since by default it is disabled, doesn't it make a required property?
>IOW, if you add a node without this mask, will the device operate
>properly and usefully?
>

Yeah, zero active TSI channels is a totally legitimate way for these 
devices to operate.  TSI is just an optional source of additional 
temperature readings that's used on some (AMD) systems; all the basic 
Super I/O functionality works fine without it.


Thanks,
Zev

