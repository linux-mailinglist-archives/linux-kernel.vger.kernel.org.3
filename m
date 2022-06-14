Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2504254B198
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 14:56:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353575AbiFNMoe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 08:44:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357043AbiFNMnd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 08:43:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA87D6394;
        Tue, 14 Jun 2022 05:43:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 827A96162C;
        Tue, 14 Jun 2022 12:43:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BD61C3411B;
        Tue, 14 Jun 2022 12:43:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1655210603;
        bh=4rW1fqUGKgw4alRpBFBSMVMPS3mmp6XOFBNsr8vccHQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Q1lRlwwzBcKBFDzTIf1XscjdNHvW0mw3lk7Aq3FNwH9wrNxATra76T4C20S7D5Y5K
         4wQwSNESZnxHeoqYYheHGMzdtuluW2FHlnC41lGpe5ZQeulphaIYTxW7ll7A8pCEeB
         URCZqmOM/7U4MIot3ZWwprxRyLgXGfGrXa9ZyjH0=
Date:   Tue, 14 Jun 2022 14:43:21 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Kai Ye <yekai13@huawei.com>
Cc:     herbert@gondor.apana.org.au, linux-crypto@vger.kernel.org,
        linux-accelerators@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        linuxarm@huawei.com, zhangfei.gao@linaro.org,
        wangzhou1@hisilicon.com
Subject: Re: [PATCH v2 3/3] crypto: hisilicon/qm - defining the device
 isolation strategy
Message-ID: <YqiCaTAaRoq7c0y0@kroah.com>
References: <20220614122943.1406-1-yekai13@huawei.com>
 <20220614122943.1406-4-yekai13@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220614122943.1406-4-yekai13@huawei.com>
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 14, 2022 at 08:29:40PM +0800, Kai Ye wrote:
> Define the device isolation strategy by the device driver. if the
> AER error frequency exceeds the value of setting for a certain
> period of time, The device will not be available in user space. The VF
> device use the PF device isolation strategy. All the hardware errors
> are processed by PF driver.
> 
> Signed-off-by: Kai Ye <yekai13@huawei.com>
> ---
>  drivers/crypto/hisilicon/qm.c | 157 +++++++++++++++++++++++++++++++---
>  include/linux/hisi_acc_qm.h   |   9 ++
>  2 files changed, 152 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/crypto/hisilicon/qm.c b/drivers/crypto/hisilicon/qm.c
> index ad83c194d664..47c41fa52693 100644
> --- a/drivers/crypto/hisilicon/qm.c
> +++ b/drivers/crypto/hisilicon/qm.c
> @@ -12,7 +12,6 @@
>  #include <linux/pm_runtime.h>
>  #include <linux/seq_file.h>
>  #include <linux/slab.h>
> -#include <linux/uacce.h>
>  #include <linux/uaccess.h>
>  #include <uapi/misc/uacce/hisi_qm.h>
>  #include <linux/hisi_acc_qm.h>
> @@ -417,6 +416,16 @@ struct hisi_qm_resource {
>  	struct list_head list;
>  };
>  
> +/**
> + * struct qm_hw_err - structure of describes the device err
> + * @list: hardware error list
> + * @tick_stamp: timestamp when the error occurred
> + */
> +struct qm_hw_err {
> +	struct list_head list;
> +	unsigned long long tick_stamp;
> +};
> +
>  struct hisi_qm_hw_ops {
>  	int (*get_vft)(struct hisi_qm *qm, u32 *base, u32 *number);
>  	void (*qm_db)(struct hisi_qm *qm, u16 qn,
> @@ -3278,6 +3287,7 @@ static int hisi_qm_uacce_get_queue(struct uacce_device *uacce,
>  	qp->event_cb = qm_qp_event_notifier;
>  	qp->pasid = arg;
>  	qp->is_in_kernel = false;
> +	atomic_inc(&qm->uacce_ref);
>  
>  	return 0;
>  }
> @@ -3285,7 +3295,9 @@ static int hisi_qm_uacce_get_queue(struct uacce_device *uacce,
>  static void hisi_qm_uacce_put_queue(struct uacce_queue *q)
>  {
>  	struct hisi_qp *qp = q->priv;
> +	struct hisi_qm *qm = qp->qm;
>  
> +	atomic_dec(&qm->uacce_ref);
>  	hisi_qm_cache_wb(qp->qm);
>  	hisi_qm_release_qp(qp);
>  }
> @@ -3410,6 +3422,102 @@ static long hisi_qm_uacce_ioctl(struct uacce_queue *q, unsigned int cmd,
>  	return 0;
>  }
>  
> +/**
> + * qm_hw_err_isolate() - Try to isolate the uacce device with its VFs
> + * @qm: The qm which we want to configure.
> + *
> + * according to user's configuration of isolation strategy. Warning: this
> + * API should be called while there is no user on the device, or the users
> + * on this device are suspended by slot resetting preparation of PCI AER.
> + */
> +static int qm_hw_err_isolate(struct hisi_qm *qm)
> +{
> +	struct qm_hw_err *err, *tmp, *hw_err;
> +	struct qm_err_isolate *isolate;
> +	u32 count = 0;
> +
> +	isolate = &qm->isolate_data;
> +
> +#define SECONDS_PER_HOUR	3600
> +
> +	/* All the hw errs are processed by PF driver */
> +	if (qm->uacce->is_vf || atomic_read(&isolate->is_isolate) ||
> +		!isolate->hw_err_isolate_hz)
> +		return 0;
> +
> +	hw_err = kzalloc(sizeof(*hw_err), GFP_ATOMIC);
> +	if (!hw_err)
> +		return -ENOMEM;
> +	hw_err->tick_stamp = jiffies;
> +	list_for_each_entry_safe(err, tmp, &qm->uacce_hw_errs, list) {
> +		if ((hw_err->tick_stamp - err->tick_stamp) / HZ >
> +		    SECONDS_PER_HOUR) {
> +			list_del(&err->list);
> +			kfree(err);
> +		} else {
> +			count++;
> +		}
> +	}
> +	list_add(&hw_err->list, &qm->uacce_hw_errs);
> +
> +	if (count >= isolate->hw_err_isolate_hz)
> +		atomic_set(&isolate->is_isolate, 1);
> +
> +	return 0;
> +}
> +
> +static void qm_hw_err_destroy(struct hisi_qm *qm)
> +{
> +	struct qm_hw_err *err, *tmp;
> +
> +	list_for_each_entry_safe(err, tmp, &qm->uacce_hw_errs, list) {
> +		list_del(&err->list);
> +		kfree(err);
> +	}
> +}
> +
> +static enum uacce_dev_state hisi_qm_get_isolate_state(struct uacce_device *uacce)
> +{
> +	struct hisi_qm *qm = uacce->priv;
> +	struct hisi_qm *pf_qm;
> +
> +	if (uacce->is_vf) {
> +		pf_qm = pci_get_drvdata(pci_physfn(qm->pdev));
> +		qm->isolate_data.is_isolate = pf_qm->isolate_data.is_isolate;
> +	}
> +
> +	return atomic_read(&qm->isolate_data.is_isolate) ?
> +			UACCE_DEV_ISOLATE : UACCE_DEV_NORMAL;
> +}
> +
> +static int hisi_qm_isolate_strategy_write(struct uacce_device *uacce,
> +						const char *buf)
> +{
> +	struct hisi_qm *qm = uacce->priv;
> +	unsigned long val = 0;
> +
> +#define MAX_ISOLATE_STRATEGY	65535
> +
> +	if (atomic_read(&qm->uacce_ref))
> +		return -EBUSY;
> +
> +	/* must be set by PF */
> +	if (atomic_read(&qm->isolate_data.is_isolate) || uacce->is_vf)
> +		return -EINVAL;
> +
> +	if (kstrtoul(buf, 0, &val) < 0)
> +		return -EINVAL;
> +
> +	if (val > MAX_ISOLATE_STRATEGY)
> +		return -EINVAL;
> +
> +	qm->isolate_data.hw_err_isolate_hz = val;
> +	dev_info(&qm->pdev->dev,
> +		"the value of isolate_strategy is set to %lu.\n", val);
> +
> +	return 0;
> +}
> +
>  static const struct uacce_ops uacce_qm_ops = {
>  	.get_available_instances = hisi_qm_get_available_instances,
>  	.get_queue = hisi_qm_uacce_get_queue,
> @@ -3418,9 +3526,22 @@ static const struct uacce_ops uacce_qm_ops = {
>  	.stop_queue = hisi_qm_uacce_stop_queue,
>  	.mmap = hisi_qm_uacce_mmap,
>  	.ioctl = hisi_qm_uacce_ioctl,
> +	.get_isolate_state = hisi_qm_get_isolate_state,
>  	.is_q_updated = hisi_qm_is_q_updated,
> +	.isolate_strategy_write = hisi_qm_isolate_strategy_write,
>  };
>  
> +static void qm_remove_uacce(struct hisi_qm *qm)
> +{
> +	struct uacce_device *uacce = qm->uacce;
> +
> +	if (qm->use_sva) {
> +		qm_hw_err_destroy(qm);
> +		uacce_remove(uacce);
> +		qm->uacce = NULL;
> +	}
> +}
> +
>  static int qm_alloc_uacce(struct hisi_qm *qm)
>  {
>  	struct pci_dev *pdev = qm->pdev;
> @@ -3433,6 +3554,7 @@ static int qm_alloc_uacce(struct hisi_qm *qm)
>  	};
>  	int ret;
>  
> +	INIT_LIST_HEAD(&qm->uacce_hw_errs);
>  	ret = strscpy(interface.name, dev_driver_string(&pdev->dev),
>  		      sizeof(interface.name));
>  	if (ret < 0)
> @@ -3446,8 +3568,7 @@ static int qm_alloc_uacce(struct hisi_qm *qm)
>  		qm->use_sva = true;
>  	} else {
>  		/* only consider sva case */
> -		uacce_remove(uacce);
> -		qm->uacce = NULL;
> +		qm_remove_uacce(qm);
>  		return -EINVAL;
>  	}
>  
> @@ -5109,6 +5230,12 @@ static int qm_controller_reset_prepare(struct hisi_qm *qm)
>  		return ret;
>  	}
>  
> +	if (qm->use_sva) {
> +		ret = qm_hw_err_isolate(qm);
> +		if (ret)
> +			pci_err(pdev, "failed to isolate hw err!\n");
> +	}
> +
>  	ret = qm_wait_vf_prepare_finish(qm);
>  	if (ret)
>  		pci_err(pdev, "failed to stop by vfs in soft reset!\n");
> @@ -5436,19 +5563,24 @@ static int qm_controller_reset(struct hisi_qm *qm)
>  	ret = qm_soft_reset(qm);
>  	if (ret) {
>  		pci_err(pdev, "Controller reset failed (%d)\n", ret);
> -		qm_reset_bit_clear(qm);
> -		return ret;
> +		goto err_reset;
>  	}
>  
>  	ret = qm_controller_reset_done(qm);
> -	if (ret) {
> -		qm_reset_bit_clear(qm);
> -		return ret;
> -	}
> +	if (ret)
> +		goto err_reset;
>  
>  	pci_info(pdev, "Controller reset complete\n");
> -
>  	return 0;
> +
> +err_reset:
> +	pci_err(pdev, "Controller reset failed (%d)\n", ret);
> +	qm_reset_bit_clear(qm);
> +
> +	/* if resetting fails, isolate the device */
> +	if (qm->use_sva && !qm->uacce->is_vf)
> +		atomic_set(&qm->isolate_data.is_isolate, 1);
> +	return ret;
>  }
>  
>  /**
> @@ -6246,10 +6378,7 @@ int hisi_qm_init(struct hisi_qm *qm)
>  err_free_qm_memory:
>  	hisi_qm_memory_uninit(qm);
>  err_alloc_uacce:
> -	if (qm->use_sva) {
> -		uacce_remove(qm->uacce);
> -		qm->uacce = NULL;
> -	}
> +	qm_remove_uacce(qm);
>  err_irq_register:
>  	qm_irq_unregister(qm);
>  err_pci_init:
> diff --git a/include/linux/hisi_acc_qm.h b/include/linux/hisi_acc_qm.h
> index 116e8bd68c99..c17fd6de8551 100644
> --- a/include/linux/hisi_acc_qm.h
> +++ b/include/linux/hisi_acc_qm.h
> @@ -8,6 +8,7 @@
>  #include <linux/iopoll.h>
>  #include <linux/module.h>
>  #include <linux/pci.h>
> +#include <linux/uacce.h>
>  
>  #define QM_QNUM_V1			4096
>  #define QM_QNUM_V2			1024
> @@ -271,6 +272,11 @@ struct hisi_qm_poll_data {
>  	u16 *qp_finish_id;
>  };
>  
> +struct qm_err_isolate {
> +	u32 hw_err_isolate_hz;	/* user cfg freq which triggers isolation */
> +	atomic_t is_isolate;
> +};
> +
>  struct hisi_qm {
>  	enum qm_hw_ver ver;
>  	enum qm_fun_type fun_type;
> @@ -335,6 +341,9 @@ struct hisi_qm {
>  	struct qm_shaper_factor *factor;
>  	u32 mb_qos;
>  	u32 type_rate;
> +	struct list_head uacce_hw_errs;
> +	atomic_t uacce_ref; /* reference of the uacce */

That is not how reference counts work, sorry.  Please use 'struct kref'
for a real reference count, never roll your own.

thanks,

greg k-h
