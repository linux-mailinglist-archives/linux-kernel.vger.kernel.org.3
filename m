Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52C1157E8EC
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jul 2022 23:34:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235670AbiGVVep (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jul 2022 17:34:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbiGVVen (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jul 2022 17:34:43 -0400
Received: from ixit.cz (ip-94-112-206-30.bb.vodafone.cz [94.112.206.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D9F8AF843;
        Fri, 22 Jul 2022 14:34:40 -0700 (PDT)
Received: from [10.0.0.163] (_gateway [10.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ixit.cz (Postfix) with ESMTPSA id 3F0D12007F;
        Fri, 22 Jul 2022 23:34:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ixit.cz; s=dkim;
        t=1658525677;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IGvDGHRGx9ntEIidHJIFw9uv8+buMKH8bvNvMLSCf3w=;
        b=JLDpM72YTJgPfeMefMM/Npbs8Lz5xh8x96C9nbsVInesHuNWAYVJlE2xZci7XT/G6977iB
        QryG4NMu0iCW1oC39FBrAjqxAsEjSKXKWfY9KHCoibx8LPrFZrHVodqTwr1V7L8sxhnVY0
        RWDKL7bZJJShW1kY3WrUu6L9P4PMbSA=
Message-ID: <b228bc62-c307-0662-3a6e-e3408c328178@ixit.cz>
Date:   Fri, 22 Jul 2022 23:34:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:103.0) Gecko/20100101
 Thunderbird/103.0
Subject: Re: [PATCH v5] dt-bindings: firmware: convert Qualcomm SCM binding to
 the yaml
To:     Rob Herring <robh@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Robert Marko <robimarko@gmail.com>,
        Das Srinagesh <quic_gurus@quicinc.com>,
        ~okias/devicetree@lists.sr.ht, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220708090431.30437-1-david@ixit.cz>
 <20220711225705.GA422079-robh@kernel.org>
Content-Language: en-US
From:   David Heidelberg <david@ixit.cz>
In-Reply-To: <20220711225705.GA422079-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RDNS_DYNAMIC,
        SPF_HELO_PASS,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/07/2022 00:57, Rob Herring wrote:
> On Fri, Jul 08, 2022 at 11:04:31AM +0200, David Heidelberg wrote:
>> Convert Qualcomm SCM firmware binding to the yaml format.
>>
>> This commit also:
>>   - adds qcom,scm-mdm9607 into list which has only core clock
>>   - adds qcom,scm-sm6125, qcom,scm-ipq6018
>>   - #reset-cells, because the property is already used
>>
>> Signed-off-by: David Heidelberg <david@ixit.cz>
>> --
> Should be '---' in order to be removed automatically when applying.
typo, sorry.
>
>> v5:
>>   - add qcom,scm-sdx65 from new commit to txt binding
>>   - add freshly merged qcom,scm-sc8280xp
>>   - add interconnects
>>   - add accidentally removed # from #include directive
>>   - move mdm9607 to 3 clocks (thx @Guru)
>>   - fix compatible string in example
>> v4:
>>   - added clocks minItems and maxItems
>>   - removed quotes from $id and $schema
>>   - adjusted description of TCSR HW block
>> v3:
>>   - add preceding patches for ARM and arm64 adding missing compatible strings
>>   - extended with missing compatible strings
>>   - added two additional maintainers, see https://lkml.org/lkml/2022/6/23/1969
>> v2:
>>   - changed maintainer to Bjorn
>>   - document #reset-cells
>>
>>   .../devicetree/bindings/firmware/qcom,scm.txt |  61 --------
>>   .../bindings/firmware/qcom,scm.yaml           | 147 ++++++++++++++++++
>>   2 files changed, 147 insertions(+), 61 deletions(-)
>>   delete mode 100644 Documentation/devicetree/bindings/firmware/qcom,scm.txt
>>   create mode 100644 Documentation/devicetree/bindings/firmware/qcom,scm.yaml
> Doesn't apply for me, so I'm assuming this will go via QCom tree.
if you want to merge it, I can rebase it against your tree?
>
> Reviewed-by: Rob Herring <robh@kernel.org>

-- 
David Heidelberg
Consultant Software Engineer

Matrix: @okias:matrix.org

