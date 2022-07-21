Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A62D57C5EF
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 10:15:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231213AbiGUIO6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 04:14:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229591AbiGUIO4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 04:14:56 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 197F2785BA;
        Thu, 21 Jul 2022 01:14:55 -0700 (PDT)
Received: from dggpeml500025.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4LpQKT34S8zkWv3;
        Thu, 21 Jul 2022 16:12:29 +0800 (CST)
Received: from dggpeml100012.china.huawei.com (7.185.36.121) by
 dggpeml500025.china.huawei.com (7.185.36.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 21 Jul 2022 16:14:53 +0800
Received: from [10.67.103.212] (10.67.103.212) by
 dggpeml100012.china.huawei.com (7.185.36.121) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 21 Jul 2022 16:14:52 +0800
Subject: Re: [PATCH v5 3/3] crypto: hisilicon/qm - defining the device
 isolation strategy
To:     Greg KH <gregkh@linuxfoundation.org>
References: <20220708070820.43958-1-yekai13@huawei.com>
 <20220708070820.43958-4-yekai13@huawei.com> <YsfeMgbP+bxstf+7@kroah.com>
CC:     <herbert@gondor.apana.org.au>, <linux-crypto@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <wangzhou1@hisilicon.com>
From:   "yekai(A)" <yekai13@huawei.com>
Message-ID: <7cd8e1f3-b4a2-8aae-7b6e-99c5ceb5f17f@huawei.com>
Date:   Thu, 21 Jul 2022 16:14:52 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
MIME-Version: 1.0
In-Reply-To: <YsfeMgbP+bxstf+7@kroah.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.103.212]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpeml100012.china.huawei.com (7.185.36.121)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2022/7/8 15:35, Greg KH wrote:
> On Fri, Jul 08, 2022 at 03:08:20PM +0800, Kai Ye wrote:
>> Define the device isolation strategy by the device driver. The
>> user configures a frequency value by uacce interface. If the
>> slot reset frequency exceeds the value of setting for a certain
>> period of time, the device will not be available in user space.
>> The time window is one hour. The VF device use the PF device
>> isolation strategy. All the hardware errors are processed by PF
>> driver. This solution can be used for other drivers.
>>
>> Signed-off-by: Kai Ye <yekai13@huawei.com>
>> ---
>>  drivers/crypto/hisilicon/qm.c | 163 +++++++++++++++++++++++++++++++---
>>  include/linux/hisi_acc_qm.h   |   9 ++
>>  2 files changed, 160 insertions(+), 12 deletions(-)
>>
>> diff --git a/drivers/crypto/hisilicon/qm.c b/drivers/crypto/hisilicon/qm.c
>> index ad83c194d664..8eb3b790a655 100644
>> --- a/drivers/crypto/hisilicon/qm.c
>> +++ b/drivers/crypto/hisilicon/qm.c
>> @@ -417,6 +417,16 @@ struct hisi_qm_resource {
>>  	struct list_head list;
>>  };
>>
>> +/**
>> + * struct qm_hw_err - Structure describing the device errors
>> + * @list: hardware error list
>> + * @timestamp: timestamp when the error occurred
>> + */
>> +struct qm_hw_err {
>> +	struct list_head list;
>> +	unsigned long long timestamp;
>> +};
>> +
>>  struct hisi_qm_hw_ops {
>>  	int (*get_vft)(struct hisi_qm *qm, u32 *base, u32 *number);
>>  	void (*qm_db)(struct hisi_qm *qm, u16 qn,
>> @@ -3410,6 +3420,111 @@ static long hisi_qm_uacce_ioctl(struct uacce_queue *q, unsigned int cmd,
>>  	return 0;
>>  }
>>
>> +/**
>> + * qm_hw_err_isolate() - Try to isolate the uacce device with its VFs
>> + * according to user's configuration of isolation strategy. Warning: this
>> + * API should be called while there the users on this device are suspended
>> + * by slot resetting preparation of PCI AER.
>> + * @qm: the uacce device
>> + */
>> +static int qm_hw_err_isolate(struct hisi_qm *qm)
>> +{
>> +	struct qm_hw_err *err, *tmp, *hw_err;
>> +	struct qm_err_isolate *isolate;
>> +	u32 count = 0;
>> +
>> +	isolate = &qm->isolate_data;
>> +
>> +#define SECONDS_PER_HOUR	3600
>> +
>> +	/* All the hw errs are processed by PF driver */
>> +	if (qm->uacce->is_vf || isolate->is_isolate ||
>> +	    !isolate->hw_err_isolate_hz)
>> +		return 0;
>> +
>> +	hw_err = kzalloc(sizeof(*hw_err), GFP_ATOMIC);
>
> Why atomic?  What lock is held here?

Atomic is not required. So use GFP_KERNEL.
>
>> +	if (!hw_err)
>> +		return -ENOMEM;
>> +
>> +	mutex_lock(&isolate->isolate_lock);
>> +	hw_err->timestamp = jiffies;
>> +	list_for_each_entry_safe(err, tmp, &isolate->uacce_hw_errs, list) {
>> +		if ((hw_err->timestamp - err->timestamp) / HZ >
>> +		    SECONDS_PER_HOUR) {
>
> No possiblity of wrapping the timestamp?
I do not understand this suggestion, Can you show more detail in this 
suggestion?

>
>> +			list_del(&err->list);
>> +			kfree(err);
>> +		} else {
>> +			count++;
>> +		}
>> +	}
>> +	list_add(&hw_err->list, &isolate->uacce_hw_errs);
>> +	mutex_unlock(&isolate->isolate_lock);
>> +
>> +	if (count >= isolate->hw_err_isolate_hz)
>> +		isolate->is_isolate = true;
>> +
>> +	return 0;
>> +}
>> +
>> +static void qm_hw_err_destroy(struct hisi_qm *qm)
>> +{
>> +	struct qm_hw_err *err, *tmp;
>> +
>> +	mutex_lock(&qm->isolate_data.isolate_lock);
>> +	list_for_each_entry_safe(err, tmp, &qm->isolate_data.uacce_hw_errs, list) {
>> +		list_del(&err->list);
>> +		kfree(err);
>> +	}
>> +	mutex_unlock(&qm->isolate_data.isolate_lock);
>> +}
>> +
>> +static enum uacce_dev_state hisi_qm_get_isolate_state(struct uacce_device *uacce)
>> +{
>> +	struct hisi_qm *qm = uacce->priv;
>> +	struct hisi_qm *pf_qm;
>> +
>> +	if (uacce->is_vf)
>> +		pf_qm = pci_get_drvdata(pci_physfn(qm->pdev));
>> +	else
>> +		pf_qm = qm;
>> +
>> +	return pf_qm->isolate_data.is_isolate ?
>> +			UACCE_DEV_ISOLATE : UACCE_DEV_NORMAL;
>> +}
>> +
>> +static int hisi_qm_isolate_strategy_write(struct uacce_device *uacce,
>> +					  u32 freq)
>> +{
>> +	struct hisi_qm *qm = uacce->priv;
>> +
>> +	/* Must be set by PF */
>> +	if (uacce->is_vf)
>> +		return -EINVAL;
>
> But the value passed to you is not invalid, something else went wrong.
> Are you sure this is the correct error?
use EPERM instead of EINVAL.
>
>> +
>> +	if (qm->isolate_data.is_isolate)
>> +		return -EINVAL;
>
> Same here, why is this correct?
use EPERM instead of EINVAL.
>
>> +
>> +	qm->isolate_data.hw_err_isolate_hz = freq;
>
> No validation of the value passed to you?  It can be anything?
>
>> +
>> +	/* After the policy is updated, need to reset the hardware err list */
>> +	qm_hw_err_destroy(qm);
>
> No error checking?
Due to the process is clean list. So no error checking is required.
>
> thanks,
>
> greg k-h
> .
>

Thanks

Kai
