Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90EC754D71A
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 03:34:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356572AbiFPBd0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 21:33:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356327AbiFPBdZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 21:33:25 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 150731A83D;
        Wed, 15 Jun 2022 18:33:24 -0700 (PDT)
Received: from dggpeml500020.china.huawei.com (unknown [172.30.72.54])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4LNl6b3G9pzDrLj;
        Thu, 16 Jun 2022 09:32:55 +0800 (CST)
Received: from dggpeml100012.china.huawei.com (7.185.36.121) by
 dggpeml500020.china.huawei.com (7.185.36.88) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 16 Jun 2022 09:33:21 +0800
Received: from [10.67.103.212] (10.67.103.212) by
 dggpeml100012.china.huawei.com (7.185.36.121) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 16 Jun 2022 09:33:21 +0800
Subject: Re: [PATCH v2 3/3] crypto: hisilicon/qm - defining the device
 isolation strategy
To:     Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        "Kai Ye via Linux-accelerators" <linux-accelerators@lists.ozlabs.org>
References: <20220614122943.1406-1-yekai13@huawei.com>
 <20220614122943.1406-4-yekai13@huawei.com>
 <20220615140249.000077f8@Huawei.com>
CC:     <gregkh@linuxfoundation.org>, <herbert@gondor.apana.org.au>,
        <linuxarm@huawei.com>, <linux-kernel@vger.kernel.org>,
        <wangzhou1@hisilicon.com>, <linux-crypto@vger.kernel.org>,
        <zhangfei.gao@linaro.org>
From:   "yekai(A)" <yekai13@huawei.com>
Message-ID: <f4fde630-a2ba-2416-5091-33c510c30593@huawei.com>
Date:   Thu, 16 Jun 2022 09:33:20 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
MIME-Version: 1.0
In-Reply-To: <20220615140249.000077f8@Huawei.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.103.212]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpeml100012.china.huawei.com (7.185.36.121)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2022/6/15 21:02, Jonathan Cameron wrote:
> On Tue, 14 Jun 2022 20:29:40 +0800
> Kai Ye via Linux-accelerators <linux-accelerators@lists.ozlabs.org> wrote:
>
>> Define the device isolation strategy by the device driver. if the
>> AER error frequency exceeds the value of setting for a certain
>> period of time, The device will not be available in user space. The VF
>> device use the PF device isolation strategy. All the hardware errors
>> are processed by PF driver.
>>
>> Signed-off-by: Kai Ye <yekai13@huawei.com>
>
> I'll try and avoid duplicating Greg's feedback but might well overlap a bit!
>
>> ---
>>  drivers/crypto/hisilicon/qm.c | 157 +++++++++++++++++++++++++++++++---
>>  include/linux/hisi_acc_qm.h   |   9 ++
>>  2 files changed, 152 insertions(+), 14 deletions(-)
>>
>> diff --git a/drivers/crypto/hisilicon/qm.c b/drivers/crypto/hisilicon/qm.c
>> index ad83c194d664..47c41fa52693 100644
>> --- a/drivers/crypto/hisilicon/qm.c
>> +++ b/drivers/crypto/hisilicon/qm.c
>> @@ -12,7 +12,6 @@
>>  #include <linux/pm_runtime.h>
>>  #include <linux/seq_file.h>
>>  #include <linux/slab.h>
>> -#include <linux/uacce.h>
>
> I assume you do this because you are now relying on hisi_acc_qm.h including
> uacce.h?   Generally it is better to include most headers that we use
> directly so it this still uses stuff from uacce.h then keep the include.

Yes
>
>>  #include <linux/uaccess.h>
>>  #include <uapi/misc/uacce/hisi_qm.h>
>>  #include <linux/hisi_acc_qm.h>
>> @@ -417,6 +416,16 @@ struct hisi_qm_resource {
>>  	struct list_head list;
>>  };
>>
>> +/**
>> + * struct qm_hw_err - structure of describes the device err
>> + * @list: hardware error list
>> + * @tick_stamp: timestamp when the error occurred
>
> tick?   Perhaps just call it timestamp if that is what it is...

call 'timestamp' instead of 'tick_stamp'
>
>
>> + */
>> +struct qm_hw_err {
>> +	struct list_head list;
>> +	unsigned long long tick_stamp;
>> +};
>> +
>
>>
>> +/**
>> + * qm_hw_err_isolate() - Try to isolate the uacce device with its VFs
>> + * @qm: The qm which we want to configure.
>> + *
>> + * according to user's configuration of isolation strategy. Warning: this
>
> Rewrite to make it full sentence.
>
>> + * API should be called while there is no user on the device, or the users
>> + * on this device are suspended by slot resetting preparation of PCI AER.
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
>> +	if (qm->uacce->is_vf || atomic_read(&isolate->is_isolate) ||
>> +		!isolate->hw_err_isolate_hz)
>> +		return 0;
>> +
>> +	hw_err = kzalloc(sizeof(*hw_err), GFP_ATOMIC);
>> +	if (!hw_err)
>> +		return -ENOMEM;
> blank line here to separate error handling from next bit of code.

Yes
>
>> +	hw_err->tick_stamp = jiffies;
>> +	list_for_each_entry_safe(err, tmp, &qm->uacce_hw_errs, list) {
>
> These are ordered (I think). Could take advantage of that by
> maintaining count of elements in parallel to the list then walking
> list in right direction + stop when you reach last one to need
> deleting.
>

thanks, The current list + jiffies solution seems more simple.
>
>> +		if ((hw_err->tick_stamp - err->tick_stamp) / HZ >
>> +		    SECONDS_PER_HOUR) {
>> +			list_del(&err->list);
>> +			kfree(err);
>> +		} else {
>> +			count++;
>> +		}
>> +	}
>> +	list_add(&hw_err->list, &qm->uacce_hw_errs);
>> +
>> +	if (count >= isolate->hw_err_isolate_hz)
>> +		atomic_set(&isolate->is_isolate, 1);
>> +
>> +	return 0;
>> +}
>> +
>
> ...
>
>> +static int hisi_qm_isolate_strategy_write(struct uacce_device *uacce,
>> +						const char *buf)
>> +{
>> +	struct hisi_qm *qm = uacce->priv;
>> +	unsigned long val = 0;
>> +
>> +#define MAX_ISOLATE_STRATEGY	65535
>> +
>> +	if (atomic_read(&qm->uacce_ref))
>> +		return -EBUSY;
>> +
>> +	/* must be set by PF */
>> +	if (atomic_read(&qm->isolate_data.is_isolate) || uacce->is_vf)
>
> Why is the file visible on the vf?  Hide it or don't register it for vfs.
Because VF devices can be registered with UACCE. So this file node can 
be visited on the vf. We're not sure if someone else's device is the 
same as qm. So i configure it this way by driver. the 'isolate_strategy' 
must be set by pf.

>
>> +		return -EINVAL;
>> +
>> +	if (kstrtoul(buf, 0, &val) < 0)
>> +		return -EINVAL;
>> +
>> +	if (val > MAX_ISOLATE_STRATEGY)
>> +		return -EINVAL;
>> +
>> +	qm->isolate_data.hw_err_isolate_hz = val;
>> +	dev_info(&qm->pdev->dev,
>> +		"the value of isolate_strategy is set to %lu.\n", val);
>
> This is just noise in the log.  If someone wants to check they should read
> the sysfs file back and it reflect the new state.

Yes delete it.
>
>> +
>> +	return 0;
>> +}
>> +
>
> ...
>
>>  static int qm_alloc_uacce(struct hisi_qm *qm)
>>  {
>>  	struct pci_dev *pdev = qm->pdev;
>> @@ -3433,6 +3554,7 @@ static int qm_alloc_uacce(struct hisi_qm *qm)
>>  	};
>>  	int ret;
>>
>> +	INIT_LIST_HEAD(&qm->uacce_hw_errs);
>>  	ret = strscpy(interface.name, dev_driver_string(&pdev->dev),
>>  		      sizeof(interface.name));
>>  	if (ret < 0)
>> @@ -3446,8 +3568,7 @@ static int qm_alloc_uacce(struct hisi_qm *qm)
>>  		qm->use_sva = true;
>>  	} else {
>>  		/* only consider sva case */
>> -		uacce_remove(uacce);
>> -		qm->uacce = NULL;
>> +		qm_remove_uacce(qm);
>>  		return -EINVAL;
>>  	}
>>
>> @@ -5109,6 +5230,12 @@ static int qm_controller_reset_prepare(struct hisi_qm *qm)
>>  		return ret;
>>  	}
>>
>> +	if (qm->use_sva) {
>> +		ret = qm_hw_err_isolate(qm);
>> +		if (ret)
>> +			pci_err(pdev, "failed to isolate hw err!\n");
>> +	}
>> +
>>  	ret = qm_wait_vf_prepare_finish(qm);
>>  	if (ret)
>>  		pci_err(pdev, "failed to stop by vfs in soft reset!\n");
>> @@ -5436,19 +5563,24 @@ static int qm_controller_reset(struct hisi_qm *qm)
>>  	ret = qm_soft_reset(qm);
>>  	if (ret) {
>>  		pci_err(pdev, "Controller reset failed (%d)\n", ret);
>
> This is printed below as well - probably best to drop this one and then you
> can remove the brackets as well.
>
>> -		qm_reset_bit_clear(qm);
>> -		return ret;
>> +		goto err_reset;
>>  	}
>>
>>  	ret = qm_controller_reset_done(qm);
>> -	if (ret) {
>> -		qm_reset_bit_clear(qm);
>> -		return ret;
>> -	}
>> +	if (ret)
>> +		goto err_reset;
>>
>>  	pci_info(pdev, "Controller reset complete\n");
>> -
>
> Avoid noise via white space changes like this.  The white space was
> good and generally don't change white space in a patch doing anything else.
>
>>  	return 0;
>> +
>> +err_reset:
>> +	pci_err(pdev, "Controller reset failed (%d)\n", ret);
>> +	qm_reset_bit_clear(qm);
>> +
>> +	/* if resetting fails, isolate the device */
>> +	if (qm->use_sva && !qm->uacce->is_vf)
>> +		atomic_set(&qm->isolate_data.is_isolate, 1);
>> +	return ret;
>>  }
>>
>>  /**
>> @@ -6246,10 +6378,7 @@ int hisi_qm_init(struct hisi_qm *qm)
>>  err_free_qm_memory:
>>  	hisi_qm_memory_uninit(qm);
>>  err_alloc_uacce:
>> -	if (qm->use_sva) {
>> -		uacce_remove(qm->uacce);
>> -		qm->uacce = NULL;
>> -	}
>> +	qm_remove_uacce(qm);
>>  err_irq_register:
>>  	qm_irq_unregister(qm);
>>  err_pci_init:
>
> .
>

thanks
Kai
