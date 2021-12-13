Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77B62472BF3
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 13:06:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236459AbhLMMF7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 07:05:59 -0500
Received: from szxga01-in.huawei.com ([45.249.212.187]:32915 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232598AbhLMMF6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 07:05:58 -0500
Received: from dggpeml500022.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4JCKw424DXzcmRq;
        Mon, 13 Dec 2021 20:05:40 +0800 (CST)
Received: from dggpeml100012.china.huawei.com (7.185.36.121) by
 dggpeml500022.china.huawei.com (7.185.36.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Mon, 13 Dec 2021 20:05:56 +0800
Received: from [10.67.103.212] (10.67.103.212) by
 dggpeml100012.china.huawei.com (7.185.36.121) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Mon, 13 Dec 2021 20:05:56 +0800
Subject: Re: [PATCH v3] uacce: use sysfs_emit instead of sprintf
To:     <gregkh@linuxfoundation.org>,
        <linux-accelerators@lists.ozlabs.org>,
        <linux-kernel@vger.kernel.org>, <linuxarm@huawei.com>,
        <zhangfei.gao@linaro.org>, <wangzhou1@hisilicon.com>
References: <20211206104724.11559-1-yekai13@huawei.com>
From:   "yekai(A)" <yekai13@huawei.com>
Message-ID: <aeaa46e2-0adc-142e-f7e2-dcb4bbf8a74f@huawei.com>
Date:   Mon, 13 Dec 2021 20:05:56 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
MIME-Version: 1.0
In-Reply-To: <20211206104724.11559-1-yekai13@huawei.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.103.212]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpeml100012.china.huawei.com (7.185.36.121)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2021/12/6 18:47, Kai Ye wrote:
> Use the sysfs_emit to replace sprintf. sprintf may cause
> output defect in sysfs content, it is better to use new
> added sysfs_emit function which knows the size of the
> temporary buffer.
>
> Signed-off-by: Kai Ye <yekai13@huawei.com>
> ---
> changes v1->v2:
> 	modfiy the comments.
> changes v2->v3:
> 	modify the "changes" lines.
>
>  drivers/misc/uacce/uacce.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/misc/uacce/uacce.c b/drivers/misc/uacce/uacce.c
> index 488eeb2811ae..281c54003edc 100644
> --- a/drivers/misc/uacce/uacce.c
> +++ b/drivers/misc/uacce/uacce.c
> @@ -289,7 +289,7 @@ static ssize_t api_show(struct device *dev,
>  {
>  	struct uacce_device *uacce = to_uacce_device(dev);
>
> -	return sprintf(buf, "%s\n", uacce->api_ver);
> +	return sysfs_emit(buf, "%s\n", uacce->api_ver);
>  }
>
>  static ssize_t flags_show(struct device *dev,
> @@ -297,7 +297,7 @@ static ssize_t flags_show(struct device *dev,
>  {
>  	struct uacce_device *uacce = to_uacce_device(dev);
>
> -	return sprintf(buf, "%u\n", uacce->flags);
> +	return sysfs_emit(buf, "%u\n", uacce->flags);
>  }
>
>  static ssize_t available_instances_show(struct device *dev,
> @@ -309,7 +309,7 @@ static ssize_t available_instances_show(struct device *dev,
>  	if (!uacce->ops->get_available_instances)
>  		return -ENODEV;
>
> -	return sprintf(buf, "%d\n",
> +	return sysfs_emit(buf, "%d\n",
>  		       uacce->ops->get_available_instances(uacce));
>  }
>
> @@ -318,7 +318,7 @@ static ssize_t algorithms_show(struct device *dev,
>  {
>  	struct uacce_device *uacce = to_uacce_device(dev);
>
> -	return sprintf(buf, "%s\n", uacce->algs);
> +	return sysfs_emit(buf, "%s\n", uacce->algs);
>  }
>
>  static ssize_t region_mmio_size_show(struct device *dev,
> @@ -326,7 +326,7 @@ static ssize_t region_mmio_size_show(struct device *dev,
>  {
>  	struct uacce_device *uacce = to_uacce_device(dev);
>
> -	return sprintf(buf, "%lu\n",
> +	return sysfs_emit(buf, "%lu\n",
>  		       uacce->qf_pg_num[UACCE_QFRT_MMIO] << PAGE_SHIFT);
>  }
>
> @@ -335,7 +335,7 @@ static ssize_t region_dus_size_show(struct device *dev,
>  {
>  	struct uacce_device *uacce = to_uacce_device(dev);
>
> -	return sprintf(buf, "%lu\n",
> +	return sysfs_emit(buf, "%lu\n",
>  		       uacce->qf_pg_num[UACCE_QFRT_DUS] << PAGE_SHIFT);
>  }
>
>

Hi Hartman

Could you help to take this patch?
Thanks.

Kai
