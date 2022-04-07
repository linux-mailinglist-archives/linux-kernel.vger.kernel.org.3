Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65F1F4F77DA
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 09:41:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241991AbiDGHmT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 03:42:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231745AbiDGHmS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 03:42:18 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3036437A10
        for <linux-kernel@vger.kernel.org>; Thu,  7 Apr 2022 00:40:17 -0700 (PDT)
Received: from dggpemm500024.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4KYtXk6BHGzgYVj;
        Thu,  7 Apr 2022 15:38:30 +0800 (CST)
Received: from dggpemm500006.china.huawei.com (7.185.36.236) by
 dggpemm500024.china.huawei.com (7.185.36.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Thu, 7 Apr 2022 15:40:15 +0800
Received: from [10.174.178.55] (10.174.178.55) by
 dggpemm500006.china.huawei.com (7.185.36.236) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Thu, 7 Apr 2022 15:40:14 +0800
Subject: Re: [PATCH RESEND v5 1/5] iommu: Refactor iommu_group_store_type()
To:     John Garry <john.garry@huawei.com>, <joro@8bytes.org>,
        <will@kernel.org>, <robin.murphy@arm.com>
CC:     <mst@redhat.com>, <jasowang@redhat.com>,
        <iommu@lists.linux-foundation.org>, <linux-kernel@vger.kernel.org>,
        <virtualization@lists.linux-foundation.org>,
        <chenxiang66@hisilicon.com>, <jean-philippe@linaro.org>,
        <linuxarm@huawei.com>
References: <1649071634-188535-1-git-send-email-john.garry@huawei.com>
 <1649071634-188535-2-git-send-email-john.garry@huawei.com>
From:   "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Message-ID: <e1d18bb1-db35-fe36-0212-7d6d83112e31@huawei.com>
Date:   Thu, 7 Apr 2022 15:40:14 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <1649071634-188535-2-git-send-email-john.garry@huawei.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.178.55]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpemm500006.china.huawei.com (7.185.36.236)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reviewed-by: Zhen Lei <thunder.leizhen@huawei.com>

On 2022/4/4 19:27, John Garry wrote:
> Function iommu_group_store_type() supports changing the default domain
> of an IOMMU group.
> 
> Many conditions need to be satisfied and steps taken for this action to be
> successful.
> 
> Satisfying these conditions and steps will be required for setting other
> IOMMU group attributes, so factor into a common part and a part specific
> to update the IOMMU group attribute.
> 
> No functional change intended.
> 
> Some code comments are tidied up also.
> 
> Signed-off-by: John Garry <john.garry@huawei.com>
> ---
>  drivers/iommu/iommu.c | 96 ++++++++++++++++++++++++++++---------------
>  1 file changed, 62 insertions(+), 34 deletions(-)
> 
> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> index f2c45b85b9fc..0dd766030baf 100644
> --- a/drivers/iommu/iommu.c
> +++ b/drivers/iommu/iommu.c
> @@ -3000,21 +3000,57 @@ static int iommu_change_dev_def_domain(struct iommu_group *group,
>  	return ret;
>  }
>  
> +enum iommu_group_op {
> +	CHANGE_GROUP_TYPE,
> +};
> +
> +static int __iommu_group_store_type(const char *buf, struct iommu_group *group,
> +				    struct device *dev)
> +{
> +	int type;
> +
> +	if (sysfs_streq(buf, "identity"))
> +		type = IOMMU_DOMAIN_IDENTITY;
> +	else if (sysfs_streq(buf, "DMA"))
> +		type = IOMMU_DOMAIN_DMA;
> +	else if (sysfs_streq(buf, "DMA-FQ"))
> +		type = IOMMU_DOMAIN_DMA_FQ;
> +	else if (sysfs_streq(buf, "auto"))
> +		type = 0;
> +	else
> +		return -EINVAL;
> +
> +	/*
> +	 * Check if the only device in the group still has a driver bound or
> +	 * we're transistioning from DMA -> DMA-FQ
> +	 */
> +	if (device_is_bound(dev) && !(type == IOMMU_DOMAIN_DMA_FQ &&
> +	    group->default_domain->type == IOMMU_DOMAIN_DMA)) {
> +		pr_err_ratelimited("Device is still bound to driver\n");
> +		return -EINVAL;
> +	}
> +
> +	return iommu_change_dev_def_domain(group, dev, type);
> +}
> +
>  /*
>   * Changing the default domain through sysfs requires the users to unbind the
>   * drivers from the devices in the iommu group, except for a DMA -> DMA-FQ
> - * transition. Return failure if this isn't met.
> + * transition. Changing or any other IOMMU group attribute still requires the
> + * user to unbind the drivers from the devices in the iommu group. Return
> + * failure if these conditions are not met.
>   *
>   * We need to consider the race between this and the device release path.
>   * device_lock(dev) is used here to guarantee that the device release path
>   * will not be entered at the same time.
>   */
> -static ssize_t iommu_group_store_type(struct iommu_group *group,
> -				      const char *buf, size_t count)
> +static ssize_t iommu_group_store_common(struct iommu_group *group,
> +					enum iommu_group_op op,
> +					const char *buf, size_t count)
>  {
>  	struct group_device *grp_dev;
>  	struct device *dev;
> -	int ret, req_type;
> +	int ret;
>  
>  	if (!capable(CAP_SYS_ADMIN) || !capable(CAP_SYS_RAWIO))
>  		return -EACCES;
> @@ -3022,27 +3058,16 @@ static ssize_t iommu_group_store_type(struct iommu_group *group,
>  	if (WARN_ON(!group))
>  		return -EINVAL;
>  
> -	if (sysfs_streq(buf, "identity"))
> -		req_type = IOMMU_DOMAIN_IDENTITY;
> -	else if (sysfs_streq(buf, "DMA"))
> -		req_type = IOMMU_DOMAIN_DMA;
> -	else if (sysfs_streq(buf, "DMA-FQ"))
> -		req_type = IOMMU_DOMAIN_DMA_FQ;
> -	else if (sysfs_streq(buf, "auto"))
> -		req_type = 0;
> -	else
> -		return -EINVAL;
> -
>  	/*
>  	 * Lock/Unlock the group mutex here before device lock to
> -	 * 1. Make sure that the iommu group has only one device (this is a
> +	 * 1. Make sure that the IOMMU group has only one device (this is a
>  	 *    prerequisite for step 2)
>  	 * 2. Get struct *dev which is needed to lock device
>  	 */
>  	mutex_lock(&group->mutex);
>  	if (iommu_group_device_count(group) != 1) {
>  		mutex_unlock(&group->mutex);
> -		pr_err_ratelimited("Cannot change default domain: Group has more than one device\n");
> +		pr_err_ratelimited("Cannot change IOMMU group default domain attribute: Group has more than one device\n");
>  		return -EINVAL;
>  	}
>  
> @@ -3054,16 +3079,16 @@ static ssize_t iommu_group_store_type(struct iommu_group *group,
>  	/*
>  	 * Don't hold the group mutex because taking group mutex first and then
>  	 * the device lock could potentially cause a deadlock as below. Assume
> -	 * two threads T1 and T2. T1 is trying to change default domain of an
> -	 * iommu group and T2 is trying to hot unplug a device or release [1] VF
> -	 * of a PCIe device which is in the same iommu group. T1 takes group
> -	 * mutex and before it could take device lock assume T2 has taken device
> -	 * lock and is yet to take group mutex. Now, both the threads will be
> -	 * waiting for the other thread to release lock. Below, lock order was
> -	 * suggested.
> +	 * two threads, T1 and T2. T1 is trying to change default domain
> +	 * attribute of an IOMMU group and T2 is trying to hot unplug a device
> +	 * or release [1] VF of a PCIe device which is in the same IOMMU group.
> +	 * T1 takes the group mutex and before it could take device lock T2 may
> +	 * have taken device lock and is yet to take group mutex. Now, both the
> +	 * threads will be waiting for the other thread to release lock. Below,
> +	 * lock order was suggested.
>  	 * device_lock(dev);
>  	 *	mutex_lock(&group->mutex);
> -	 *		iommu_change_dev_def_domain();
> +	 *		cb->iommu_change_dev_def_domain(); [example cb]
>  	 *	mutex_unlock(&group->mutex);
>  	 * device_unlock(dev);
>  	 *
> @@ -3077,21 +3102,24 @@ static ssize_t iommu_group_store_type(struct iommu_group *group,
>  	 */
>  	mutex_unlock(&group->mutex);
>  
> -	/* Check if the device in the group still has a driver bound to it */
>  	device_lock(dev);
> -	if (device_is_bound(dev) && !(req_type == IOMMU_DOMAIN_DMA_FQ &&
> -	    group->default_domain->type == IOMMU_DOMAIN_DMA)) {
> -		pr_err_ratelimited("Device is still bound to driver\n");
> -		ret = -EBUSY;
> -		goto out;
> +	switch (op) {
> +	case CHANGE_GROUP_TYPE:
> +		ret = __iommu_group_store_type(buf, group, dev);
> +		break;
> +	default:
> +		ret = -EINVAL;
>  	}
> -
> -	ret = iommu_change_dev_def_domain(group, dev, req_type);
>  	ret = ret ?: count;
>  
> -out:
>  	device_unlock(dev);
>  	put_device(dev);
>  
>  	return ret;
>  }
> +
> +static ssize_t iommu_group_store_type(struct iommu_group *group,
> +				      const char *buf, size_t count)
> +{
> +	return iommu_group_store_common(group, CHANGE_GROUP_TYPE, buf, count);
> +}
> 

-- 
Regards,
  Zhen Lei
