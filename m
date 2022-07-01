Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABC27563787
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jul 2022 18:14:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231665AbiGAQNx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Jul 2022 12:13:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230479AbiGAQNu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jul 2022 12:13:50 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E9D2377C9
        for <linux-kernel@vger.kernel.org>; Fri,  1 Jul 2022 09:13:48 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id sb34so4861203ejc.11
        for <linux-kernel@vger.kernel.org>; Fri, 01 Jul 2022 09:13:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=fmpoE3SOxYGWE+UCHZpRNu+aOmNCjiBhQz/RLU3kMgM=;
        b=qJk6VJJcSU7isiM5qXM+sSU4s/LlKTET2BRCOqWrJIqxxh/i3lPC7pfHcyhMy+btU+
         g5n+l6B2zEXXP8cSrA9forQxxsIT41YfSI9xAlHmPO3yGqR/8H++2vtHX7XmJAnHlQD1
         9fNm5fDQV5+OonmZesiVvE4l5AUtWzvZ3ewhgmnsGL1nfMinckdK7NXALm7l2mCfo+oP
         rqLfeuNYXtDP3GOKQ09P/lcUObHjjfmsIZcFrLEY7rqGB0BaqD2lZaCFlt7MnY3d5MB4
         zox+hrKu84JY41U+bgJjNd4tRsqQ1qPSp1uIlMGJRPZ0Nf7YN+xKrcPMTIKqxyeoy7ZB
         n7Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=fmpoE3SOxYGWE+UCHZpRNu+aOmNCjiBhQz/RLU3kMgM=;
        b=Eg6VrDHineh6eSEaTfZY6bqOfg8zPjmeuPO2dY5uo/uxP0uDJXbFThD9jugEGUpxoC
         8VBJDa7yWpkof0yvqkYyDxJQlTIwJtWBzwqrVnjbN3fYFjj6A8BZdD03Ne/h/u/yPRBX
         8ekDTUQt9ZJXhR9WMOPqnJ0/AVqODKR05i05csUgSjvO+4CckwmBsDnZ5JZxu2I/H36l
         A7X5NrR6Let7Xr99nNiyGfbvD0sBkU9DlaMNUX0JjIrN38crSw8OlBEWBkpM4cgcKGHT
         lzotyI/fRpoObuLR/ModYCOv+MryBiQrEaQcugTfpVpoLYJB3+TQ4XgyN453Nva7q3bL
         vA3w==
X-Gm-Message-State: AJIora/3JN2MzfLoMRi6/EzSZEDgHgPPlEmgKaK54T21oD6/jwrf/ldf
        t9yRD1Rz5AWkawrrm4iZD9w=
X-Google-Smtp-Source: AGRyM1sz1O6/fl0Ea97Sugobh0As/pTf+zl7GKY+/4ILQ5LqMP8NXQlvG/BhAH8xe+n8+2hAfZwTNA==
X-Received: by 2002:a17:907:7f90:b0:726:e8ed:3c28 with SMTP id qk16-20020a1709077f9000b00726e8ed3c28mr15294148ejc.63.1656692027029;
        Fri, 01 Jul 2022 09:13:47 -0700 (PDT)
Received: from [192.168.1.10] (adsl-146.37.6.170.tellas.gr. [37.6.170.146])
        by smtp.gmail.com with ESMTPSA id s10-20020a1709060c0a00b0070beb9401d9sm10689704ejf.171.2022.07.01.09.13.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 Jul 2022 09:13:46 -0700 (PDT)
Message-ID: <d74cb4e1-e504-75be-f46c-aac1115cdc55@gmail.com>
Date:   Fri, 1 Jul 2022 19:13:43 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH] iommu/arm-smmu-v3: Fix undefined behavior in GBPA_UPDATE
Content-Language: en-US
To:     Will Deacon <will@kernel.org>
Cc:     joro@8bytes.org, robin.murphy@arm.com,
        linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux-foundation.org, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org
References: <20220630063959.27226-1-burzalodowa@gmail.com>
 <20220701143401.GA28408@willie-the-truck>
From:   xenia <burzalodowa@gmail.com>
In-Reply-To: <20220701143401.GA28408@willie-the-truck>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/1/22 17:34, Will Deacon wrote:
> On Thu, Jun 30, 2022 at 09:39:59AM +0300, Xenia Ragiadakou wrote:
>> The expression 1 << 31 results in undefined behaviour because the type of
>> integer constant 1 is (signed) int and the result of shifting 1 by 31 bits
>> is not representable in the (signed) int type.
>>
>> Change the type of 1 to unsigned int by adding the U suffix.
>>
>> Signed-off-by: Xenia Ragiadakou <burzalodowa@gmail.com>
>> ---
>>   drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
>> index cd48590ada30..44fbd499edea 100644
>> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
>> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
>> @@ -96,7 +96,7 @@
>>   #define CR2_E2H				(1 << 0)
>>   
>>   #define ARM_SMMU_GBPA			0x44
>> -#define GBPA_UPDATE			(1 << 31)
>> +#define GBPA_UPDATE			(1U << 31)
> There are loads of these kicking around in the kernel sources and we compile
> with -fno-strict-overflow.
>
> If you really want to change these, then let's use the BIT() macro instead,
> but I think it's really just churn.
>
> Will
Hi Will,

I thought that since in commit 587e6c10a7ce89a5924fdbeff2ec524fbd6a124b 
there was a similar fix to Q_OVERFLOW_FLAG (see below)

--- a/drivers/iommu/arm-smmu-v3.c
+++ b/drivers/iommu/arm-smmu-v3.c
@@ -183,7 +183,7 @@

  #define Q_IDX(llq, p)                  ((p) & ((1 << 
(llq)->max_n_shift) - 1))
  #define Q_WRP(llq, p)                  ((p) & (1 << (llq)->max_n_shift))
-#define Q_OVERFLOW_FLAG                        (1 << 31)
+#define Q_OVERFLOW_FLAG                        (1U << 31)
  #define Q_OVF(p)                       ((p) & Q_OVERFLOW_FLAG)
  #define Q_ENT(q, p)                    ((q)->base +                    \
                                          Q_IDX(&((q)->llq), p) *        \

then it would make sense to fix GBPA_UPDATE in the same way.

Xenia

