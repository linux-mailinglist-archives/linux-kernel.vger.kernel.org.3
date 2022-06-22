Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 184D45547C4
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 14:12:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352808AbiFVLxv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 07:53:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357673AbiFVLxo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 07:53:44 -0400
Received: from relay03.th.seeweb.it (relay03.th.seeweb.it [IPv6:2001:4b7a:2000:18::164])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D7B432051;
        Wed, 22 Jun 2022 04:53:41 -0700 (PDT)
Received: from [192.168.1.101] (abxi223.neoplus.adsl.tpnet.pl [83.9.2.223])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by m-r1.th.seeweb.it (Postfix) with ESMTPSA id E207120603;
        Wed, 22 Jun 2022 13:53:39 +0200 (CEST)
Message-ID: <d0b55a37-428e-8081-6785-11be20aa14c7@somainline.org>
Date:   Wed, 22 Jun 2022 13:53:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: Removal of qcom,board-id and qcom,msm-id
Content-Language: en-US
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        krzysztof.kozlowski@linaro.org
Cc:     agross@kernel.org, arnd@arndb.de, bjorn.andersson@linaro.org,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, olof@lixom.net, robh@kernel.org,
        sboyd@kernel.org
References: <a3c932d1-a102-ce18-deea-18cbbd05ecab@linaro.org>
 <20220522195138.35943-1-konrad.dybcio@somainline.org>
 <c072077a-cc16-c8f8-fcfa-891b3357cb66@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@somainline.org>
In-Reply-To: <c072077a-cc16-c8f8-fcfa-891b3357cb66@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 22.06.2022 10:21, Dmitry Baryshkov wrote:
> On 22/05/2022 22:51, Konrad Dybcio wrote:
>> Hi,
>>
>> removing these properties will not bring almost any benefit (other than making
>> some checks happy any saving some <200 LoC) and will make the lives of almost
>> all people doing independent development for linux-on-msm harder. There are
>> almost unironically like 3 people outside Linaro and QUIC who have
>> non-vendor-fused development boards AND the sources to rebuild the
>> bootloader on their own. Making it harder to boot is only going to
>> discourage people from developing on these devices, which is already not
>> that pleasant, especially with newer platforms where you have to fight with
>> the oh-so-bright ideas of Android boot chain..
>>
>> This only concerns devices released before sm8350, as the new ones will not
>> even boot with these properties present (or at least SONY Sagami, but I
>> doubt it's an isolated case), so other than completing support for older
>> devices, it won't be an issue going forward, anyway.
> 
> I almost missed this part of the discussion (and Krzysztof had to point me to it in discussion of his patches).
> 
> I think this is a Sony peculiarity. At least the distributed SM8350 (lahaina) and SM8450 (waipio) Qualcomm device trees use these properties:
> 
> https://github.com/MiCode/kernel_devicetree/blob/zeus-s-oss/qcom/lahaina-hdk.dts
> https://github.com/MiCode/kernel_devicetree/blob/zeus-s-oss/qcom/lahaina-v2.1.dtsi
> https://github.com/MiCode/kernel_devicetree/blob/zeus-s-oss/qcom/waipio-qrd-pm8010.dts
> https://github.com/MiCode/kernel_devicetree/blob/zeus-s-oss/qcom/waipio-v2.dtsi
> 
> 
Hi, 

I was puzzled on this back when I first tried to get mainline booting on 8350 too. What I think happened, is that msm-id is used in some code paths, but not others (remember there are plenty of combinations including various Google's inventions from all over the years: QCDT, DTBO, vendor_boot, AVB signage, A/B presence/absence of recovery partition, virtual partitions etc etc).

Frankly, I have no idea why they are still here, but for booting just the kernel (no vendor_boot / GKI / dtbo mess), they need to be absent, at least on Sagami devices. This may be a bug in the Qualcomm bootloader, but they officially have to go with the GKI path to pass Google's compatibility tests, so this may not have been thouroughly tested (if at all), though I highly doubt this is going to change, as vendors are generally reluctant to update their bootloaders and Qualcomm is probably not interested in messing with a useless-to-the-main-purpose feature.

Konrad
