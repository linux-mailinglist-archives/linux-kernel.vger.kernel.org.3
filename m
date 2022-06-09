Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE18E5452D1
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 19:18:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235592AbiFIRSt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 13:18:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243030AbiFIRSr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 13:18:47 -0400
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5789F138938;
        Thu,  9 Jun 2022 10:18:44 -0700 (PDT)
Received: by mail-pj1-f54.google.com with SMTP id q12-20020a17090a304c00b001e2d4fb0eb4so27206472pjl.4;
        Thu, 09 Jun 2022 10:18:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=dBDuOA7Ag4D41J0FVo2zI0CMf8MV1Q4H90cDsiRjqs0=;
        b=lvd2WtunFm7PTxdOOx+1cdHHnKJI+zVMW6XuM/KZatIF+jJ5lTGmQJnNt6Xqo/Kcb/
         ykJjMIi2piK4AqszO3kk5QDvRgxUeM6Iv3LnHDRP5vmsJfLcjGFiUO5DWbRYJ+4VKTV+
         muenkBirnx6Al2heILHjrHww+IYcat++Bh/8P/VWQ38OIjjhByVJij+apIcomL0/68a8
         y7ngR/cGGbqYj7kuWbg839R+7lWe4Q0HufCMxuvKlE9LmiNiUcNNULETL17Ko5kjSNYc
         1xYQOv1XUtY0yU7Vwc/e8rNgyUzOc1GadbJxTlSiYtrH+BPtBEtseIwsCI7giQFLMmpm
         mq+A==
X-Gm-Message-State: AOAM533C2mi8YNC1cbpDzE+qbySemANHKME7t7Vysg2PXGWK3P1RO0SY
        r0q87M+fCv11PMA+LZs2c0o=
X-Google-Smtp-Source: ABdhPJxSk2cA7JFtd6Y65O6LCndnGyH7rcIrk4lhHhvjln2O2sPxd9TjLkzxezsdsn9gL7KtW74Jsg==
X-Received: by 2002:a17:902:d409:b0:167:7425:caa8 with SMTP id b9-20020a170902d40900b001677425caa8mr23376154ple.72.1654795123675;
        Thu, 09 Jun 2022 10:18:43 -0700 (PDT)
Received: from ?IPV6:2620:15c:211:201:8a44:a3e:c994:3f4b? ([2620:15c:211:201:8a44:a3e:c994:3f4b])
        by smtp.gmail.com with ESMTPSA id p8-20020a170902780800b001645730e71bsm17115350pll.59.2022.06.09.10.18.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Jun 2022 10:18:42 -0700 (PDT)
Message-ID: <a2585983-75d7-c627-13ba-38a464cf716e@acm.org>
Date:   Thu, 9 Jun 2022 10:18:40 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH v3 3/4] scsi: core: Cap shost max_sectors according to DMA
 optimum mapping limits
Content-Language: en-US
To:     John Garry <john.garry@huawei.com>,
        damien.lemoal@opensource.wdc.com, joro@8bytes.org, will@kernel.org,
        jejb@linux.ibm.com, martin.petersen@oracle.com, hch@lst.de,
        m.szyprowski@samsung.com, robin.murphy@arm.com
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-ide@vger.kernel.org, iommu@lists.linux-foundation.org,
        linux-scsi@vger.kernel.org, liyihang6@hisilicon.com,
        chenxiang66@hisilicon.com, thunder.leizhen@huawei.com
References: <1654507822-168026-1-git-send-email-john.garry@huawei.com>
 <1654507822-168026-4-git-send-email-john.garry@huawei.com>
 <fe365aa8-00d5-153d-ceb2-f887a71a6927@acm.org>
 <31417477-953d-283e-808e-cf8701e820a8@huawei.com>
 <bccbcc9b-4750-a1a7-130f-69eeea5dcb23@acm.org>
 <5b214e95-dd95-551a-496e-a2139a74e8eb@huawei.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <5b214e95-dd95-551a-496e-a2139a74e8eb@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/9/22 01:00, John Garry wrote:
> On 08/06/2022 22:07, Bart Van Assche wrote:
>> On 6/8/22 10:50, John Garry wrote:
>>> Please note that this limit only applies if we have an IOMMU enabled 
>>> for the scsi host dma device. Otherwise we are limited by dma direct 
>>> or swiotlb max mapping size, as before.
>>
>> SCSI host bus adapters that support 64-bit DMA may support much larger 
>> transfer sizes than 128 KiB.
> 
> Indeed, and that is my problem today, as my storage controller is 
> generating DMA mapping lengths which exceeds 128K and they slow 
> everything down.
> 
> If you say that SRP enjoys best peformance with larger transfers then 
> can you please test this with an IOMMU enabled (iommu group type DMA or 
> DMA-FQ)?

Hmm ... what exactly do you want me to test? Do you perhaps want me to 
measure how much performance drops with an IOMMU enabled? I don't have 
access anymore to the SRP setup I referred to in my previous email. But 
I do have access to devices that boot from UFS storage. For these 
devices we need to transfer 2 MiB per request to achieve full bandwidth.

Thanks,

Bart.
