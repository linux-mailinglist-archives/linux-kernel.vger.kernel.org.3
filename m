Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A4CC51BDB9
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 13:06:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356563AbiEELKY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 07:10:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344317AbiEELKU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 07:10:20 -0400
Received: from mail.marcansoft.com (marcansoft.com [IPv6:2a01:298:fe:f::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B86D313F06;
        Thu,  5 May 2022 04:06:40 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: marcan@marcan.st)
        by mail.marcansoft.com (Postfix) with ESMTPSA id 7FB7E41F28;
        Thu,  5 May 2022 11:06:34 +0000 (UTC)
Message-ID: <39ad7d44-7320-bc7c-8645-6643a1e69c06@marcan.st>
Date:   Thu, 5 May 2022 20:06:31 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Content-Language: es-ES
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Sven Peter <sven@svenpeter.dev>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Marc Zyngier <maz@kernel.org>,
        Mark Kettenis <mark.kettenis@xs4all.nl>,
        linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220504075153.185208-1-marcan@marcan.st>
 <20220504075153.185208-3-marcan@marcan.st>
 <a7e87c9a-7b3e-ea46-6171-4a87d1052a98@linaro.org>
From:   Hector Martin <marcan@marcan.st>
Subject: Re: [PATCH v2 2/4] dt-bindings: cpufreq: apple,soc-cpufreq: Add
 binding for Apple SoC cpufreq
In-Reply-To: <a7e87c9a-7b3e-ea46-6171-4a87d1052a98@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/05/2022 17.43, Krzysztof Kozlowski wrote:
> On 04/05/2022 09:51, Hector Martin wrote:
>> This binding represents the cpufreq/DVFS hardware present in Apple SoCs.
>> The hardware has an independent controller per CPU cluster, but we
>> represent them as a single cpufreq node since there can only be one
>> systemwide cpufreq device (and since in the future, interactions with
>> memory controller performance states will also involve cooperation
>> between multiple frequency domains).
>>
>> Signed-off-by: Hector Martin <marcan@marcan.st>
>> ---
>>  .../bindings/cpufreq/apple,soc-cpufreq.yaml   | 121 ++++++++++++++++++
>>  1 file changed, 121 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/cpufreq/apple,soc-cpufreq.yaml
>>
>> diff --git a/Documentation/devicetree/bindings/cpufreq/apple,soc-cpufreq.yaml b/Documentation/devicetree/bindings/cpufreq/apple,soc-cpufreq.yaml
>> new file mode 100644
>> index 000000000000..f398c1bd5de5
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/cpufreq/apple,soc-cpufreq.yaml
>> @@ -0,0 +1,121 @@
>> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/cpufreq/apple,soc-cpufreq.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: Apple SoC cpufreq device
>> +
>> +maintainers:
>> +  - Hector Martin <marcan@marcan.st>
>> +
>> +description: |
>> +  Apple SoCs (e.g. M1) have a per-cpu-cluster DVFS controller that is part of
>> +  the cluster management register block. This binding uses the standard
>> +  operating-points-v2 table to define the CPU performance states, with the
>> +  opp-level property specifying the hardware p-state index for that level.
>> +
>> +properties:
>> +  compatible:
>> +    items:
>> +      - enum:
>> +          - apple,t8103-soc-cpufreq
>> +          - apple,t6000-soc-cpufreq
>> +      - const: apple,soc-cpufreq
>> +
>> +  reg:
>> +    minItems: 1
>> +    maxItems: 6
> 
> Is the number of clusters fixed for t8103 and t6000? Are these
> compatibles strictly related to some specific M1 SoC? If yes, then you
> should have constraints in allOf:if:then.

No, t6000 includes t6002 which is a 2-die version and has 6 clusters,
t6001 and t6000 have 3. t8103 always has 2, but it's conceivable that
compatible could be used for other chips within the same generation with
a different number.

The general idea for these compats is as a fallback in case we need to
quirk something for individual SoCs or start using registers which
changed for some reason, but right now they are not used. But I think
given how closely related t6000/t6001/t6002 are (t6002 is literally two
t6001 dies, and t6000 is almost identical to t6001 with a chunk
missing), I think spelling those out as 3 separate compatibles is
overkill. In general we treat those 3 SoCs as identical in terms of
compatibles, but the one-cpufreq-node limitation means t6002 does have
twice the clusters.

It's also conceivable that Apple could start releasing CPUs with entire
clusters fused off, so then our bootloader would have to start mutating
the reg entry to represent that.

I can add constraints to express some of this if you really want me to,
but I'm not sure it's that useful. The way I see it, the compatibles
really *mean* "this soc has t8103 clusters" or "this soc has t6000
clusters" and the number of clusters is arbitrary and the driver will
never care about that. Honestly I'd rather have separate cpufreq nodes
for each cluster, but nobody else does it like that and there's only one
driver instance, so that gets complicated...

-- 
Hector Martin (marcan@marcan.st)
Public Key: https://mrcn.st/pub
