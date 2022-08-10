Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4814E58EB7F
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Aug 2022 13:47:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229990AbiHJLrw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Aug 2022 07:47:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230251AbiHJLru (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Aug 2022 07:47:50 -0400
Received: from ixit.cz (ip-94-112-206-30.bb.vodafone.cz [94.112.206.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FE98785AC;
        Wed, 10 Aug 2022 04:47:47 -0700 (PDT)
Received: from [10.0.0.163] (_gateway [10.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by ixit.cz (Postfix) with ESMTPSA id AAEEF2007F;
        Wed, 10 Aug 2022 13:47:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ixit.cz; s=dkim;
        t=1660132064;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kL0LKrgUP/uBOT9B/FfoWBTR9xsnJ9VC+03kk6ZiaSQ=;
        b=xuBER+xbNtQ8PdBYIMhjPMtG71JYlovT+WQFLCes+8FzVRwLCEhBRiVmSUykT1khVpSeDl
        xjKbjM/BaLkoyS8K1op/GG9uiEjpszIwUvskajppafDzTH2YgcyaHpNUm6vAx+Rlqjxrv7
        KSxBcEe2kJxBZ9kUMBBmR7CUft7YOOA=
Message-ID: <1768ffde-fc99-29c5-d9fe-ce41db052c7a@ixit.cz>
Date:   Wed, 10 Aug 2022 13:47:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:103.0) Gecko/20100101
 Thunderbird/103.0
Subject: Re: [PATCH v3] dt-bindings: mfd: convert to yaml Qualcomm SPMI PMIC
Content-Language: en-US
To:     Lee Jones <lee.jones@linaro.org>, Rob Herring <robh@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Caleb Connolly <caleb@connolly.tech>,
        linux-arm-msm@vger.kernel.org, Stephen Boyd <sboyd@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        ~okias/devicetree@lists.sr.ht,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, Lee Jones <lee@kernel.org>
References: <20220626191630.176835-1-david@ixit.cz>
 <20220809235625.GA2775377-robh@kernel.org> <YvOPKKw60F4qEKM6@google.com>
From:   David Heidelberg <david@ixit.cz>
In-Reply-To: <YvOPKKw60F4qEKM6@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RDNS_DYNAMIC,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/08/2022 12:57, Lee Jones wrote:
> On Tue, 09 Aug 2022, Rob Herring wrote:
>
>> On Sun, 26 Jun 2022 21:16:30 +0200, David Heidelberg wrote:
>>> Convert Qualcomm SPMI PMIC binding to yaml format.
>>>
>>> Additional changes:
>>>   - filled many missing compatibles
>>>
>>> Co-developed-by: Caleb Connolly <caleb@connolly.tech>
>>> Signed-off-by: David Heidelberg <david@ixit.cz>
>>> ---
>>> v3:
>>>   - added subnodes, there are two not converted to YAML yet, but it works
>>>   - now it prints milion directly unrelated warning to this binding
>>>     (it's related to the included subnodes bindings, can be merged,
>>>      but it'll generate more warnings and preferably anyone can takeover
>>>      from here)
>>>   - add qcom,pmx65
>>>
>>> v2:
>>>   - changed author to myself, kept Caleb as co-author
>>>   - moved nodename to properties
>>>   - add nodenames for pm* with deprecated property
>>>   - add ^$ to pattern properties
>>>   - dropped interrupt-names property
>>>   - added reg prop. to the nodes which have register in nodename
>>>   - added compatible pmx55
>>> Signed-off-by: David Heidelberg <david@ixit.cz>
>>> ---
>>>   .../bindings/mfd/qcom,spmi-pmic.txt           |  94 ---------
>>>   .../bindings/mfd/qcom,spmi-pmic.yaml          | 191 ++++++++++++++++++
>>>   2 files changed, 191 insertions(+), 94 deletions(-)
>>>   delete mode 100644 Documentation/devicetree/bindings/mfd/qcom,spmi-pmic.txt
>>>   create mode 100644 Documentation/devicetree/bindings/mfd/qcom,spmi-pmic.yaml
>>>
>> As this hasn't been picked up, I applied it. Thanks!
> I'd prefer to take it via MFD if it's all the same to you.
>
> In case there are additional fix-ups required during the next cycle.

I can rebase it against MFD if it's more convenient.


David

>
-- 
David Heidelberg
Consultant Software Engineer

Matrix: @okias:matrix.org

