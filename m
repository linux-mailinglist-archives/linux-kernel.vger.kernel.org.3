Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 932B0570200
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 14:27:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230208AbiGKM1X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 08:27:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229621AbiGKM1W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 08:27:22 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B34E648EAA
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 05:27:20 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id 19so5999201ljz.4
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 05:27:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=HwLJdTH82xNb90qT1vQZYoa9ieJufcUtpYGi92wHmYs=;
        b=g5ySyal7dv4MPrGsk6WJDHQZmAd3ycF+7ygLYe76Ejh3dbJXv4Ja0B+0uwfKU9VF0R
         ccv1kW3iKiqX3rsOZB+j1MBGvc5l4NE76IV40lajU4qWQHMfmR0fzy3AFFz81pOxNkBf
         R7VCd/AUdUW+OqiSPbemtTj8bsBUS1MQv+k/qcuSniIzG/VrLCeyjQcL4MBB1WkobNPP
         d/H6SF/SsAql4NmPMSGMrADZaQC3TAzPgO5oCW7H/ot9SssgcW6VWsFvN6tLKrcR/fBQ
         2rSSImhxDdIWa+NaJrXsgRRjJYvgTUi08uH/0nNpqfXwBUoB4iaCYSnwuAkxX+wBrd4F
         ltbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=HwLJdTH82xNb90qT1vQZYoa9ieJufcUtpYGi92wHmYs=;
        b=blvco19a81mU6n/1hkN1yjOL2pz/ugFJEzAAHEm3P9/7JQPEyzqJ892lcWLSQIviW1
         u/63Rz27m/Gqub4IMYV4Um/tKMAMjPdeDKWTncCETf5nbeeDj3ped2OO8f7fQRoxO/EO
         emMfWxNhImiLFL/9XYopmJB4LJXCVqdvuT+blDs1SBLJeSJHFGNQt6l0KQv81ioeBWjj
         /8myhzSnHZM6Co6C8nYaFkyu8QvxrDFX7KsruDPsfldTtWmk1ZcpjTevfGgFb9op6L2h
         DJTQMYD7/LbgeDqUYUm6SMnDpuCuuOfqlw2lfNG5ze+7ZieewLVXbR+7CDHyoFQb+V11
         JHbg==
X-Gm-Message-State: AJIora97sAkPCshTie50PFwSikggrLOvvYtz4HBYT+p8/Ltd9kIDUeKH
        72/delgK+e+5JYLtuYtcF662CIbNcJBNOhD4
X-Google-Smtp-Source: AGRyM1tHEdXNVASWzQ290O8nAhTmVUh9cRkbOw+puJGj+lykKQ80cpC9LEuZifUvQKY2t6kgXXIRlQ==
X-Received: by 2002:a2e:9e05:0:b0:25d:6230:ba54 with SMTP id e5-20020a2e9e05000000b0025d6230ba54mr6011067ljk.146.1657542439117;
        Mon, 11 Jul 2022 05:27:19 -0700 (PDT)
Received: from [10.0.0.8] (fwa5cab-55.bb.online.no. [88.92.171.55])
        by smtp.gmail.com with ESMTPSA id p35-20020a05651213a300b0047f933622c8sm1518057lfa.163.2022.07.11.05.27.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Jul 2022 05:27:18 -0700 (PDT)
Message-ID: <c2c3c37e-0f63-9b89-ed49-78193c46d7bd@linaro.org>
Date:   Mon, 11 Jul 2022 14:27:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 1/4] iommu/exynos: Set correct dma mask for SysMMU v5+
Content-Language: en-US
To:     Sam Protsenko <semen.protsenko@linaro.org>
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Janghyuck Kim <janghyuck.kim@samsung.com>,
        Cho KyongHo <pullip.cho@samsung.com>,
        Daniel Mentz <danielmentz@google.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        iommu@lists.linux-foundation.org, iommu@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220702213724.3949-1-semen.protsenko@linaro.org>
 <20220702213724.3949-2-semen.protsenko@linaro.org>
 <9afb1e98-706f-ed61-892c-e3cc321364b4@linaro.org>
 <CAPLW+4kfrHOb8utzynhB=2KLDQu-NC08UYpAVjpg__NQSeSQyg@mail.gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <CAPLW+4kfrHOb8utzynhB=2KLDQu-NC08UYpAVjpg__NQSeSQyg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/07/2022 15:18, Sam Protsenko wrote:
> On Sun, 3 Jul 2022 at 21:50, Krzysztof Kozlowski
> <krzysztof.kozlowski@linaro.org> wrote:
>>
>> On 02/07/2022 23:37, Sam Protsenko wrote:
>>> SysMMU v5+ supports 36 bit physical address space. Set corresponding DMA
>>> mask to avoid falling back to SWTLBIO usage in dma_map_single() because
>>> of failed dma_capable() check.
>>>
>>> The original code for this fix was suggested by Marek.
>>>
>>> Originally-by: Marek Szyprowski <m.szyprowski@samsung.com>
>>
>> This is some tip specific tag, I don't think checkpatch allows it.
>> Either use suggesgted-by or co-developed-by + SoB.
>>
> 
> Yes, checkpatch is swearing at that line, though I encountered that
> tag mentioning somewhere in Documentation. Will rework it in v2.

Yes, in tip. It did not go outside of tip.

> 
>>> Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
>>> ---
>>>  drivers/iommu/exynos-iommu.c | 8 ++++++++
>>>  1 file changed, 8 insertions(+)
>>>
>>> diff --git a/drivers/iommu/exynos-iommu.c b/drivers/iommu/exynos-iommu.c
>>> index 71f2018e23fe..28f8c8d93aa3 100644
>>> --- a/drivers/iommu/exynos-iommu.c
>>> +++ b/drivers/iommu/exynos-iommu.c
>>> @@ -647,6 +647,14 @@ static int exynos_sysmmu_probe(struct platform_device *pdev)
>>>               }
>>>       }
>>>
>>> +     if (MMU_MAJ_VER(data->version) >= 5) {
>>> +             ret = dma_set_mask(dev, DMA_BIT_MASK(36));
>>> +             if (ret) {
>>> +                     dev_err(dev, "Unable to set DMA mask: %d\n", ret);
>>
>> Missing cleanup: iommu_device_unregister
>> and probably also: iommu_device_sysfs_remove
>>
> 
> Right. Also the correct cleanup should be added for failing
> iommu_device_register() case, above of the quoted code. Will do that
> in v2, thanks.
> 
> Another thing is that "remove" method is missing. But guess I'll get
> to it later, when adding modularization support for this driver.

remove is independent of modules, so it should be here already.

Best regards,
Krzysztof
