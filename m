Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 119504E74A9
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Mar 2022 15:02:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354379AbiCYODn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Mar 2022 10:03:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238260AbiCYODk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Mar 2022 10:03:40 -0400
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3218C66AE9;
        Fri, 25 Mar 2022 07:02:03 -0700 (PDT)
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 22P9DWkq012594;
        Fri, 25 Mar 2022 15:01:47 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=selector1;
 bh=sfoK/AhKJde6QAFBNaKF8n1bgeG1b/nnFL7Tu8qPyAc=;
 b=JOTsJ8ro+zgneByNYKdRjOxqA/io05I1zjzN2eEi95mjj73355qpKXS94wJeKzki8vfo
 /gamEFyNxgWYsmocJ6SFegbG63Xn4812cP4KMVql+NJNJSD0W5m84LlKVNarjM7pd7mb
 frp48Qt9gE6ADDSRAhOzYnntm0U0II1Thr6yVwOHuO0zodyBifGIrwd7E+SQzjAhwgJf
 WcejZLoom1neNj03dcWG0jyb7yznxY+b2sCgg3bdzcdpD0AtnLEP0H3uTibVpqxmABVe
 7YBI1QougA/waoNM22WpGEsvp2BCaMHGrppYjwopHQ/9XLYX7uQ7LN4bNCkhZIn22Crs gQ== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3ew6xm1j8q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 25 Mar 2022 15:01:47 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 614F110002A;
        Fri, 25 Mar 2022 15:01:46 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag2node2.st.com [10.75.127.5])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 57ECB222CB6;
        Fri, 25 Mar 2022 15:01:46 +0100 (CET)
Received: from [10.201.21.172] (10.75.127.51) by SFHDAG2NODE2.st.com
 (10.75.127.5) with Microsoft SMTP Server (TLS) id 15.0.1497.26; Fri, 25 Mar
 2022 15:01:45 +0100
Message-ID: <57b4f49d-ae93-89d4-20ed-43fdd580e0d3@foss.st.com>
Date:   Fri, 25 Mar 2022 15:01:45 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 2/2] mmc: mmci: stm32: use a buffer for unaligned DMA
 requests
Content-Language: en-US
To:     Ulf Hansson <ulf.hansson@linaro.org>
CC:     Christophe Kerello <christophe.kerello@foss.st.com>,
        Ludovic Barre <ludovic.barre@foss.st.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        <linux-mmc@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
References: <20220317111944.116148-1-yann.gautier@foss.st.com>
 <20220317111944.116148-3-yann.gautier@foss.st.com>
 <CAPDyKFqzzKgLHWiy26QW0hvM9kZEATS_c2mXkTuGiFpPaW8YKw@mail.gmail.com>
 <668661ca-271b-9a4f-6482-62f1b0190bb2@foss.st.com>
 <CAPDyKFr3YGd4mytykFMAtESMg9fsRaAKZo5CHBN4hrUa8ekE8g@mail.gmail.com>
From:   Yann Gautier <yann.gautier@foss.st.com>
In-Reply-To: <CAPDyKFr3YGd4mytykFMAtESMg9fsRaAKZo5CHBN4hrUa8ekE8g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.51]
X-ClientProxiedBy: SFHDAG2NODE3.st.com (10.75.127.6) To SFHDAG2NODE2.st.com
 (10.75.127.5)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.850,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-03-25_04,2022-03-24_01,2022-02-23_01
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/25/22 14:43, Ulf Hansson wrote:
> On Thu, 24 Mar 2022 at 17:23, Yann Gautier <yann.gautier@foss.st.com> wrote:
>>
>> On 3/24/22 12:55, Ulf Hansson wrote:
>>> On Thu, 17 Mar 2022 at 12:19, Yann Gautier <yann.gautier@foss.st.com> wrote:
>>>>
>>>> In SDIO mode, the sg list for requests can be unaligned with what the
>>>> STM32 SDMMC internal DMA can support. In that case, instead of failing,
>>>> use a temporary bounce buffer to copy from/to the sg list.
>>>> This buffer is limited to 1MB. But for that we need to also limit
>>>> max_req_size to 1MB. It has not shown any throughput penalties for
>>>> SD-cards or eMMC.
>>>>
>>>> Signed-off-by: Yann Gautier <yann.gautier@foss.st.com>
>>>> ---
>>>>    drivers/mmc/host/mmci_stm32_sdmmc.c | 80 +++++++++++++++++++++++------
>>>>    1 file changed, 63 insertions(+), 17 deletions(-)
>>>>
>>>> diff --git a/drivers/mmc/host/mmci_stm32_sdmmc.c b/drivers/mmc/host/mmci_stm32_sdmmc.c
>>>> index 4566d7fc9055..a4414e32800f 100644
>>>> --- a/drivers/mmc/host/mmci_stm32_sdmmc.c
>>>> +++ b/drivers/mmc/host/mmci_stm32_sdmmc.c
>>>> @@ -43,6 +43,9 @@ struct sdmmc_lli_desc {
>>>>    struct sdmmc_idma {
>>>>           dma_addr_t sg_dma;
>>>>           void *sg_cpu;
>>>> +       dma_addr_t bounce_dma_addr;
>>>> +       void *bounce_buf;
>>>> +       bool use_bounce_buffer;
>>>>    };
>>>>
>>>>    struct sdmmc_dlyb {
>>>> @@ -54,6 +57,7 @@ struct sdmmc_dlyb {
>>>>    static int sdmmc_idma_validate_data(struct mmci_host *host,
>>>>                                       struct mmc_data *data)
>>>>    {
>>>> +       struct sdmmc_idma *idma = host->dma_priv;
>>>>           struct scatterlist *sg;
>>>>           int i;
>>>>
>>>> @@ -61,21 +65,23 @@ static int sdmmc_idma_validate_data(struct mmci_host *host,
>>>>            * idma has constraints on idmabase & idmasize for each element
>>>>            * excepted the last element which has no constraint on idmasize
>>>>            */
>>>> +       idma->use_bounce_buffer = false;
>>>>           for_each_sg(data->sg, sg, data->sg_len - 1, i) {
>>>>                   if (!IS_ALIGNED(sg->offset, sizeof(u32)) ||
>>>>                       !IS_ALIGNED(sg->length, SDMMC_IDMA_BURST)) {
>>>> -                       dev_err(mmc_dev(host->mmc),
>>>> +                       dev_dbg(mmc_dev(host->mmc),
>>>>                                   "unaligned scatterlist: ofst:%x length:%d\n",
>>>>                                   data->sg->offset, data->sg->length);
>>>> -                       return -EINVAL;
>>>> +                       idma->use_bounce_buffer = true;
>>>> +                       return 0;
>>>>                   }
>>>>           }
>>>>
>>>>           if (!IS_ALIGNED(sg->offset, sizeof(u32))) {
>>>> -               dev_err(mmc_dev(host->mmc),
>>>> +               dev_dbg(mmc_dev(host->mmc),
>>>>                           "unaligned last scatterlist: ofst:%x length:%d\n",
>>>>                           data->sg->offset, data->sg->length);
>>>> -               return -EINVAL;
>>>> +               idma->use_bounce_buffer = true;
>>>>           }
>>>>
>>>>           return 0;
>>>> @@ -84,18 +90,29 @@ static int sdmmc_idma_validate_data(struct mmci_host *host,
>>>>    static int _sdmmc_idma_prep_data(struct mmci_host *host,
>>>>                                    struct mmc_data *data)
>>>>    {
>>>> -       int n_elem;
>>>> +       struct sdmmc_idma *idma = host->dma_priv;
>>>>
>>>> -       n_elem = dma_map_sg(mmc_dev(host->mmc),
>>>> -                           data->sg,
>>>> -                           data->sg_len,
>>>> -                           mmc_get_dma_dir(data));
>>>> +       if (idma->use_bounce_buffer) {
>>>> +               if (data->flags & MMC_DATA_WRITE) {
>>>> +                       unsigned int xfer_bytes = data->blksz * data->blocks;
>>>>
>>>> -       if (!n_elem) {
>>>> -               dev_err(mmc_dev(host->mmc), "dma_map_sg failed\n");
>>>> -               return -EINVAL;
>>>> -       }
>>>> +                       sg_copy_to_buffer(data->sg, data->sg_len,
>>>> +                                         idma->bounce_buf, xfer_bytes);
>>>> +                       dma_wmb();
>>>> +               }
>>>> +       } else {
>>>> +               int n_elem;
>>>> +
>>>> +               n_elem = dma_map_sg(mmc_dev(host->mmc),
>>>> +                                   data->sg,
>>>> +                                   data->sg_len,
>>>> +                                   mmc_get_dma_dir(data));
>>>>
>>>> +               if (!n_elem) {
>>>> +                       dev_err(mmc_dev(host->mmc), "dma_map_sg failed\n");
>>>> +                       return -EINVAL;
>>>> +               }
>>>> +       }
>>>>           return 0;
>>>>    }
>>>>
>>>> @@ -112,8 +129,19 @@ static int sdmmc_idma_prep_data(struct mmci_host *host,
>>>>    static void sdmmc_idma_unprep_data(struct mmci_host *host,
>>>>                                      struct mmc_data *data, int err)
>>>>    {
>>>> -       dma_unmap_sg(mmc_dev(host->mmc), data->sg, data->sg_len,
>>>> -                    mmc_get_dma_dir(data));
>>>> +       struct sdmmc_idma *idma = host->dma_priv;
>>>> +
>>>> +       if (idma->use_bounce_buffer) {
>>>> +               if (data->flags & MMC_DATA_READ) {
>>>> +                       unsigned int xfer_bytes = data->blksz * data->blocks;
>>>> +
>>>> +                       sg_copy_from_buffer(data->sg, data->sg_len,
>>>> +                                           idma->bounce_buf, xfer_bytes);
>>>> +               }
>>>> +       } else {
>>>> +               dma_unmap_sg(mmc_dev(host->mmc), data->sg, data->sg_len,
>>>> +                            mmc_get_dma_dir(data));
>>>> +       }
>>>>    }
>>>>
>>>>    static int sdmmc_idma_setup(struct mmci_host *host)
>>>> @@ -137,6 +165,16 @@ static int sdmmc_idma_setup(struct mmci_host *host)
>>>>                   host->mmc->max_segs = SDMMC_LLI_BUF_LEN /
>>>>                           sizeof(struct sdmmc_lli_desc);
>>>>                   host->mmc->max_seg_size = host->variant->stm32_idmabsize_mask;
>>>> +
>>>> +               host->mmc->max_req_size = SZ_1M;
>>>> +               idma->bounce_buf = dmam_alloc_coherent(dev,
>>>> +                                                      host->mmc->max_req_size,
>>>> +                                                      &idma->bounce_dma_addr,
>>>> +                                                      GFP_KERNEL);
>>>> +               if (!idma->bounce_buf) {
>>>> +                       dev_err(dev, "Unable to map allocate DMA bounce buffer.\n");
>>>> +                       return -ENOMEM;
>>>
>> Hi Ulf,
>>
>>> If we fail to allocate the 1M bounce buffer, then we end up always
>>> using a PIO based mode, right?
>>>
>>> Perhaps we can allow the above allocation to fail, but then limit us
>>> to use DMA only when the buffers are properly aligned? Would that
>>> work?
>>>
>> We have never supported PIO mode with STM32 variant.
>> We only support DMA single buffer or DMA LLI.
>> As we cannot have DMA LLI for unaligned access, we'll default to single
>> mode.
> 
> Right, I was looking at the legacy variant, which uses PIO as
> fallback. Sorry for my ignorance.
> 
>> If allocation fails, it then won't work.
> 
> Right, but that's only part of the issue, I think.
> 
>> Maybe we shouldn't fail here, and just check idma->bounce_buf in
>> validate data function. If buffer is not allocated, we just return
>> -EINVAL as it was done before.
> 
> Yes, something along those lines. However, there is another problem
> too, which is that the allocation will be done for each instance of
> the host that is probed. In all cases but the SDIO case, this would be
> a waste, right?
> 
> Perhaps we should manage the allocation in the validate function too
> (de-allocation should be handled at ->remove()). In this way, the
> buffer will only be allocated when it's actually needed. Yes, it would
> add a latency while serving the *first* request that has unaligned
> buffers, but I guess we can live with that?
> 
Hi Ulf,

That makes sense, I'll rework the validate data function with this.
I'll push a new version soon.

Thanks,
Yann
>>
>> Best regards,
>> Yann
> 
> Kind regards
> Uffe
> 
>>
>>>> +               }
>>>>           } else {
>>>>                   host->mmc->max_segs = 1;
>>>>                   host->mmc->max_seg_size = host->mmc->max_req_size;
>>>> @@ -154,8 +192,16 @@ static int sdmmc_idma_start(struct mmci_host *host, unsigned int *datactrl)
>>>>           struct scatterlist *sg;
>>>>           int i;
>>>>
>>>> -       if (!host->variant->dma_lli || data->sg_len == 1) {
>>>> -               writel_relaxed(sg_dma_address(data->sg),
>>>> +       if (!host->variant->dma_lli || data->sg_len == 1 ||
>>>> +           idma->use_bounce_buffer) {
>>>> +               u32 dma_addr;
>>>> +
>>>> +               if (idma->use_bounce_buffer)
>>>> +                       dma_addr = idma->bounce_dma_addr;
>>>> +               else
>>>> +                       dma_addr = sg_dma_address(data->sg);
>>>> +
>>>> +               writel_relaxed(dma_addr,
>>>>                                  host->base + MMCI_STM32_IDMABASE0R);
>>>>                   writel_relaxed(MMCI_STM32_IDMAEN,
>>>>                                  host->base + MMCI_STM32_IDMACTRLR);
>>>
>>> Kind regards
>>> Uffe
>>

