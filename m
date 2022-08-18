Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61E4E5982D5
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Aug 2022 14:01:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244305AbiHRMAU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Aug 2022 08:00:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241012AbiHRMAS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Aug 2022 08:00:18 -0400
Received: from m-r2.th.seeweb.it (m-r2.th.seeweb.it [IPv6:2001:4b7a:2000:18::171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE886277
        for <linux-kernel@vger.kernel.org>; Thu, 18 Aug 2022 05:00:15 -0700 (PDT)
Received: from [192.168.1.101] (abxi168.neoplus.adsl.tpnet.pl [83.9.2.168])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by m-r2.th.seeweb.it (Postfix) with ESMTPSA id B596B3F347;
        Thu, 18 Aug 2022 14:00:11 +0200 (CEST)
Message-ID: <0de2d418-7489-db57-af64-68a35711c567@somainline.org>
Date:   Thu, 18 Aug 2022 14:00:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [RFT PATCH v2 02/14] arm64: dts: qcom: msm8996: split TCSR halt
 regs out of mutex
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Lee Jones <lee@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220817130342.568396-1-krzysztof.kozlowski@linaro.org>
 <20220817130342.568396-3-krzysztof.kozlowski@linaro.org>
 <fd1492fa-4244-b283-d2a6-b4ffac7d53d6@somainline.org>
 <2823e662-55a1-0d9f-e95d-40d6f3b93723@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@somainline.org>
In-Reply-To: <2823e662-55a1-0d9f-e95d-40d6f3b93723@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 18.08.2022 09:02, Krzysztof Kozlowski wrote:
> On 17/08/2022 23:57, Konrad Dybcio wrote:
>>
>>
>> On 17.08.2022 15:03, Krzysztof Kozlowski wrote:
>>> The TCSR halt regs are next to TCSR mutex, so before converting the TCSR
>>> mutex into device with address space, we need to split the halt regs to
>>> its own syscon device.  This also describes more accurately the devices
>>> and their IO address space.
>>>
>>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>>> ---
>> Not tested on a device, but looks good to the eye:
>> Reviewed-by: Konrad Dybcio <konrad.dybcio@somainline.org>
>>
>> On a note, are they really named TCSR_1 and TCSR_2 in the docs?
>> Qualcomm is usually more exquisite in their naming :P
> 
> This is not entirely separate address space, therefore it does not have
> a separate name. The address space name is still TCSR_MUTEX which
> consists of actual MUTEX regs, halt regs and bunch of others. The second
> one 0x7a0000 (where label I renamed to tcsr_2) is called TCSR_REGS.
> 
> This applies to other patches as well, so maybe you prefer to have
> labels matching the spec? The first would be tcsr_mutex_regs, although
> it is not entirely correct, because it does not include now the TCSR
> mutex regs...
I think it's fine as it is.

Konrad
> 
> 
> 
> Best regards,
> Krzysztof
