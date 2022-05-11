Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93899522BEB
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 07:52:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239547AbiEKFv4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 01:51:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232213AbiEKFvx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 01:51:53 -0400
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com [199.106.114.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 663F285656;
        Tue, 10 May 2022 22:51:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1652248309; x=1683784309;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=y7Ma3NU4R9DKob8KaqtrYsX/Lg7x0p6qjlq2IolMo3A=;
  b=ybP8OunGnSp4Cg6yf4bFIX+cEWMCEBXkaTINbzLmQw8dp922yf+Pvt0s
   6cP+R7cHE7BRGAJRIEMISBcU2NPJHlAq8fZEghVjNZCw8epRA8+P8YfFq
   R1C9WYF/U+RoHAEIJHyTy2aqqJEXTUww8Tcf2z2IOfQIE9bEZK9sjVQ+D
   w=;
Received: from unknown (HELO ironmsg02-sd.qualcomm.com) ([10.53.140.142])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 10 May 2022 22:51:49 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg02-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2022 22:51:50 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Tue, 10 May 2022 22:51:50 -0700
Received: from [10.79.43.230] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Tue, 10 May
 2022 22:51:46 -0700
Subject: Re: [PATCH] remoteproc: qcom_q6v5_mss: map/unmap metadata region
 before/after use
To:     Matthias Kaehlcke <mka@chromium.org>
CC:     <bjorn.andersson@linaro.org>, <arnd@arndb.de>,
        <linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <sboyd@kernel.org>, <agross@kernel.org>,
        <linux-remoteproc@vger.kernel.org>, <mathieu.poirier@linaro.org>
References: <1651845086-16535-1-git-send-email-quic_sibis@quicinc.com>
 <YnVj7fxUbTqkJpdz@google.com>
From:   Sibi Sankar <quic_sibis@quicinc.com>
Message-ID: <d6dca8a1-0986-1d56-f0bd-131bda4b1381@quicinc.com>
Date:   Wed, 11 May 2022 11:21:43 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <YnVj7fxUbTqkJpdz@google.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Matthias,
Thanks for taking time to review the patch.

On 5/6/22 11:37 PM, Matthias Kaehlcke wrote:
> On Fri, May 06, 2022 at 07:21:26PM +0530, Sibi Sankar wrote:
>> The application processor accessing the dynamically assigned metadata
>> region after assigning it to the remote Q6 would lead to an XPU violation.
>> Fix this by un-mapping the metadata region post firmware header copy. The
>> metadata region is freed only after the modem Q6 is done with fw header
>> authentication.
>>
>> Signed-off-by: Sibi Sankar <quic_sibis@quicinc.com>
> 
> Should this have a 'Fixes:' tag
It ideally should have but similar to what we did for mba and mpss
region map/unmap, it would be a ugly backport since it would point to
the very first commit. We can agree to do a backport if it's ever
reported upstream on any of the older SoCs.

-Sibi

> 
>> ---
>>   drivers/remoteproc/qcom_q6v5_mss.c | 43 +++++++++++++++++++++++++++++++-------
>>   1 file changed, 35 insertions(+), 8 deletions(-)
>>
>> diff --git a/drivers/remoteproc/qcom_q6v5_mss.c b/drivers/remoteproc/qcom_q6v5_mss.c
>> index af217de75e4d..eb34a258b67b 100644
>> --- a/drivers/remoteproc/qcom_q6v5_mss.c
>> +++ b/drivers/remoteproc/qcom_q6v5_mss.c
>> @@ -10,6 +10,7 @@
>>   #include <linux/clk.h>
>>   #include <linux/delay.h>
>>   #include <linux/devcoredump.h>
>> +#include <linux/dma-map-ops.h>
>>   #include <linux/dma-mapping.h>
>>   #include <linux/interrupt.h>
>>   #include <linux/kernel.h>
>> @@ -932,27 +933,52 @@ static void q6v5proc_halt_axi_port(struct q6v5 *qproc,
>>   static int q6v5_mpss_init_image(struct q6v5 *qproc, const struct firmware *fw,
>>   				const char *fw_name)
>>   {
>> -	unsigned long dma_attrs = DMA_ATTR_FORCE_CONTIGUOUS;
>> +	unsigned long dma_attrs = DMA_ATTR_FORCE_CONTIGUOUS | DMA_ATTR_NO_KERNEL_MAPPING;
>> +	unsigned long flags = VM_DMA_COHERENT | VM_FLUSH_RESET_PERMS;
>> +	struct page **pages;
>> +	struct page *page;
>>   	dma_addr_t phys;
>>   	void *metadata;
>>   	int mdata_perm;
>>   	int xferop_ret;
>>   	size_t size;
>> -	void *ptr;
>> +	void *vaddr;
>> +	int count;
>>   	int ret;
>> +	int i;
>>   
>>   	metadata = qcom_mdt_read_metadata(fw, &size, fw_name, qproc->dev);
>>   	if (IS_ERR(metadata))
>>   		return PTR_ERR(metadata);
>>   
>> -	ptr = dma_alloc_attrs(qproc->dev, size, &phys, GFP_KERNEL, dma_attrs);
>> -	if (!ptr) {
>> -		kfree(metadata);
>> +	page = dma_alloc_attrs(qproc->dev, size, &phys, GFP_KERNEL, dma_attrs);
>> +	if (!page) {
>>   		dev_err(qproc->dev, "failed to allocate mdt buffer\n");
>> -		return -ENOMEM;
>> +		ret = -ENOMEM;
>> +		goto free_metadata;
>> +	}
>> +
>> +	count = PAGE_ALIGN(size) >> PAGE_SHIFT;
>> +	pages = kmalloc_array(count, sizeof(struct page *), GFP_KERNEL);
>> +	if (!pages) {
>> +		ret = -ENOMEM;
>> +		goto free_metadata;
>>   	}
>>   
>> -	memcpy(ptr, metadata, size);
>> +	for (i = 0; i < count; i++)
>> +		pages[i] = nth_page(page, i);
>> +
>> +	vaddr = vmap(pages, count, flags, dma_pgprot(qproc->dev, PAGE_KERNEL, dma_attrs));
>> +	kfree(pages);
>> +	if (!vaddr) {
>> +		dev_err(qproc->dev, "unable to map memory region: %pa+%zx\n", &phys, size);
>> +		ret = -EBUSY;
>> +		goto free_metadata;
>> +	}
>> +
>> +	memcpy(vaddr, metadata, size);
>> +
>> +	vunmap(vaddr);
>>   
>>   	/* Hypervisor mapping to access metadata by modem */
>>   	mdata_perm = BIT(QCOM_SCM_VMID_HLOS);
>> @@ -982,7 +1008,8 @@ static int q6v5_mpss_init_image(struct q6v5 *qproc, const struct firmware *fw,
>>   			 "mdt buffer not reclaimed system may become unstable\n");
>>   
>>   free_dma_attrs:
>> -	dma_free_attrs(qproc->dev, size, ptr, phys, dma_attrs);
>> +	dma_free_attrs(qproc->dev, size, page, phys, dma_attrs);
>> +free_metadata:
>>   	kfree(metadata);
>>   
>>   	return ret < 0 ? ret : 0;
>> -- 
>> 2.7.4
>>
