Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D4B2539F93
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jun 2022 10:35:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350811AbiFAIev (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jun 2022 04:34:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239960AbiFAIes (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jun 2022 04:34:48 -0400
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com [199.106.114.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 344AC5537F;
        Wed,  1 Jun 2022 01:34:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1654072487; x=1685608487;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=x5nMSSI5/humEcyp6BGP5MXHhmWKZK8ljqf5CpFlbKg=;
  b=fe1gVsH0qRH7EbcUP6rMO8/aw+W0sSlUzeWJ771tokHEgPc326CwrtGz
   V5PWuRhZECcGUUEE+zZtMEFCYyyXzoQihem6sjdN9LyD0mLmWIEtob7kK
   5TA8uRT2xHAdQnLrJYqne+KzEkWGEiJHmb3O/ldxzFwr5hQoSJAS0puMz
   k=;
Received: from unknown (HELO ironmsg01-sd.qualcomm.com) ([10.53.140.141])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 01 Jun 2022 01:34:46 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg01-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jun 2022 01:34:46 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Wed, 1 Jun 2022 01:34:45 -0700
Received: from [10.79.43.230] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Wed, 1 Jun 2022
 01:34:43 -0700
Subject: Re: [PATCH v2] remoteproc: qcom_q6v5_mss: map/unmap metadata region
 before/after use
To:     Arnd Bergmann <arnd@arndb.de>
CC:     <bjorn.andersson@linaro.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <sboyd@kernel.org>,
        <agross@kernel.org>, <linux-remoteproc@vger.kernel.org>,
        <mathieu.poirier@linaro.org>, <mka@chromium.org>
References: <1652248625-990-1-git-send-email-quic_sibis@quicinc.com>
 <CAK8P3a2b05w3uRjXhx7CgdLEHL78ZHRjgOYoG_SR0SyDxcLDMg@mail.gmail.com>
From:   Sibi Sankar <quic_sibis@quicinc.com>
Message-ID: <08778603-4f15-0fb7-687d-4cf42c8ddbd3@quicinc.com>
Date:   Wed, 1 Jun 2022 14:04:39 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAK8P3a2b05w3uRjXhx7CgdLEHL78ZHRjgOYoG_SR0SyDxcLDMg@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-5.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Arnd,
Thanks for taking time to review the patch.

On 5/30/22 9:41 PM, Arnd Bergmann wrote:
> On Wed, May 11, 2022 at 7:57 AM Sibi Sankar <quic_sibis@quicinc.com> wrote:
>>
>> The application processor accessing the dynamically assigned metadata
>> region after assigning it to the remote Q6 would lead to an XPU violation.
>> Fix this by un-mapping the metadata region post firmware header copy. The
>> metadata region is freed only after the modem Q6 is done with fw header
>> authentication.
>>
>> Signed-off-by: Sibi Sankar <quic_sibis@quicinc.com>
> 
> Acked-by: Arnd Bergmann <arnd@arndb.de>
> 
> Sorry for the late reply, this looks reasonable overall. Just two
> small comments:
> 
>>
>> -       memcpy(ptr, metadata, size);
>> +       count = PAGE_ALIGN(size) >> PAGE_SHIFT;
>> +       pages = kmalloc_array(count, sizeof(struct page *), GFP_KERNEL);
>> +       if (!pages) {
>> +               ret = -ENOMEM;
>> +               goto free_dma_attrs;
>> +       }
> 
> If you know a fixed upper bound for the array size, it might be easier to
> put it on the stack.

The metadata consists of the 32bit elf header and SoC dependent variable
number of program headers. Arriving at the upper bound from the spec
seemed futile since the max program headers supported could be > 0xffff.
The best I can do is get the max size of metadata of all the QC SoCs
supported upstream for putting the pages on stack and leave "count" as
the min between the dynamic calculation and upper bound. Would that be
good enough?

> 
>> +
>> +       for (i = 0; i < count; i++)
>> +               pages[i] = nth_page(page, i);
>> +
>> +       vaddr = vmap(pages, count, flags, pgprot_dmacoherent(PAGE_KERNEL));
> 
> I was a bit unsure about this part, as I don't know how portable this is.
> If the CPU bypasses the cache with pgprot_dmacoherent(), then the
> other side should not use a cacheable access either, but that is a property
> of the hardware that is normally hidden from the driver interface.
> 
> It's probably ok here, since the pages are not mapped anywhere else
> and should have no active cache lines.

yup we make sure the other side can access the region only after no
cache lines are active (that's the main problem that we are trying
to solve through this patch).

-Sibi

> 
>         Arnd
> 
