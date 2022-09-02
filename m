Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BC635AB748
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 19:11:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237036AbiIBRLk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Sep 2022 13:11:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237008AbiIBRLf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Sep 2022 13:11:35 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D428AEC4E5;
        Fri,  2 Sep 2022 10:11:32 -0700 (PDT)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 282GeC1V025030;
        Fri, 2 Sep 2022 17:11:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=DCRQm9f6UeM81ddw5LTtHNHLfhyrv8aniXGaw6FyzEk=;
 b=ICQ7Sk9Bk/06RmnX5eBDUyGgy8zeA8SpFv+nyBMAWtAT68u3TVV/0MdSzh1TQi8gpyxD
 469kVeNralKRasqmU5abr4ArIEli64IddG4EwzUGDZIaayT4ko2FFqTHrSM1K29MniVy
 bU8mo9/SmAQ8bmqzwfZyaLdDbyyHtT7MPevXe5XgxWbVhsakT6wjuOlPqeB4uCJ/hDV3
 K5mS8Nks1f1HRGQzsqf+sHUbBNwCxmcIRkrSZTWV+jrLYIaD25OZe1KIcDtcMfg9eeZ6
 rWiWdy3CdP/qC29Gd6V2pM6iXEzLt1QguDEpeYgBOMyqASSqvY2bPVqdfPjayM5QvCD1 ZQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3jbn9xh3kn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 02 Sep 2022 17:11:13 +0000
Received: from m0098417.ppops.net (m0098417.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 282Gkk4g022023;
        Fri, 2 Sep 2022 17:11:12 GMT
Received: from ppma03dal.us.ibm.com (b.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.11])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3jbn9xh3k7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 02 Sep 2022 17:11:12 +0000
Received: from pps.filterd (ppma03dal.us.ibm.com [127.0.0.1])
        by ppma03dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 282H6PcZ017296;
        Fri, 2 Sep 2022 17:11:11 GMT
Received: from b01cxnp22036.gho.pok.ibm.com (b01cxnp22036.gho.pok.ibm.com [9.57.198.26])
        by ppma03dal.us.ibm.com with ESMTP id 3j7awbkh7d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 02 Sep 2022 17:11:11 +0000
Received: from b01ledav001.gho.pok.ibm.com (b01ledav001.gho.pok.ibm.com [9.57.199.106])
        by b01cxnp22036.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 282HBAj520185430
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 2 Sep 2022 17:11:10 GMT
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6518528058;
        Fri,  2 Sep 2022 17:11:10 +0000 (GMT)
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 87E7F2805A;
        Fri,  2 Sep 2022 17:11:09 +0000 (GMT)
Received: from [9.160.86.252] (unknown [9.160.86.252])
        by b01ledav001.gho.pok.ibm.com (Postfix) with ESMTP;
        Fri,  2 Sep 2022 17:11:09 +0000 (GMT)
Message-ID: <273fdd58-549c-30d4-39a9-85fe631162ba@linux.ibm.com>
Date:   Fri, 2 Sep 2022 13:11:09 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH v4 1/2] iommu/s390: Fix race with release_device ops
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Robin Murphy <robin.murphy@arm.com>, iommu@lists.linux.dev,
        Alex Williamson <alex.williamson@redhat.com>,
        linux-s390@vger.kernel.org, schnelle@linux.ibm.com,
        pmorel@linux.ibm.com, borntraeger@linux.ibm.com, hca@linux.ibm.com,
        gor@linux.ibm.com, gerald.schaefer@linux.ibm.com,
        agordeev@linux.ibm.com, svens@linux.ibm.com, joro@8bytes.org,
        will@kernel.org, linux-kernel@vger.kernel.org
References: <20220831201236.77595-1-mjrosato@linux.ibm.com>
 <20220831201236.77595-2-mjrosato@linux.ibm.com>
 <3b065fb5-3ca7-8f48-bdf7-daf7604312df@arm.com>
 <369ad331-8bdc-d385-a227-f674bd410599@linux.ibm.com>
 <YxEYAcFK0EdahXzJ@nvidia.com>
Content-Language: en-US
From:   Matthew Rosato <mjrosato@linux.ibm.com>
In-Reply-To: <YxEYAcFK0EdahXzJ@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: ZtXKxpkCZEhW1SZFMGuriq_IwEvNqk7T
X-Proofpoint-GUID: 1DEEad5wBl2iz8sSy0O_BCG6-Jq6uEkR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-09-02_04,2022-08-31_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 lowpriorityscore=0 suspectscore=0 mlxlogscore=999
 phishscore=0 spamscore=0 clxscore=1015 mlxscore=0 bulkscore=0
 impostorscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2207270000 definitions=main-2209020080
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/1/22 4:37 PM, Jason Gunthorpe wrote:
> On Thu, Sep 01, 2022 at 12:14:24PM -0400, Matthew Rosato wrote:
>> On 9/1/22 6:25 AM, Robin Murphy wrote:
>>> On 2022-08-31 21:12, Matthew Rosato wrote:
>>>> With commit fa7e9ecc5e1c ("iommu/s390: Tolerate repeat attach_dev
>>>> calls") s390-iommu is supposed to handle dynamic switching between IOMMU
>>>> domains and the DMA API handling.  However, this commit does not
>>>> sufficiently handle the case where the device is released via a call
>>>> to the release_device op as it may occur at the same time as an opposing
>>>> attach_dev or detach_dev since the group mutex is not held over
>>>> release_device.  This was observed if the device is deconfigured during a
>>>> small window during vfio-pci initialization and can result in WARNs and
>>>> potential kernel panics.
>>>
>>> Hmm, the more I think about it, something doesn't sit right about this whole situation... release_device is called via the notifier from device_del() after the device has been removed from its parent bus and largely dismantled; it should definitely not still have a driver bound by that point, so how is VFIO doing things that manage to race at all?
>>>
>>> Robin.
>>
>> So, I generally have seen the issue manifest as one of the calls
>> into the iommu core from __vfio_group_unset_container
>> (e.g. iommu_deatch_group via vfio_type1_iommu) failing with a WARN.
>> This happens when the vfio group fd is released, which could be
>> coming e.g. from a userspace ioctl VFIO_GROUP_UNSET_CONTAINER.
>> AFAICT there's nothing serializing the notion of calling into the
>> iommu core here against a device that is simultaneously going
>> through release_device (because we don't enter release_device with
>> the group mutex held), resulting in unpredictable behavior between
>> the dueling attach_dev/detach_dev and the release_device for
>> s390-iommu at least.
> 
> Oh, this is a vfio bug.

I've been running with your diff applied today on s390 and this indeed fixes the issue by preventing the detach-after-release coming out of vfio.

Can you send as a patch for review?

> 
> dev->iommu_group is only a valid pointer as long as a driver is attach
> to the device.
> 
> vfio copies the dev->iommu_group into struct vfio_group during probe()
> but then lets vfio_group live independently. Particularly the driver
> can be removed()'d and the vfio_group keeps on going.
> 
> Thus it is possible to UAF the iommu_group by referencing it through
> the vfio_group.
> 
> We must wait during remove for all the vfio_groups to stop
> referencing iommu_group.
> 
> Something like this or so:
> 
> diff --git a/drivers/vfio/vfio_main.c b/drivers/vfio/vfio_main.c
> index eb714a484662fc..d8f40b22c98ddb 100644
> --- a/drivers/vfio/vfio_main.c
> +++ b/drivers/vfio/vfio_main.c
> @@ -65,7 +65,15 @@ struct vfio_container {
>  struct vfio_group {
>  	struct device 			dev;
>  	struct cdev			cdev;
> +	/*
> +	 * When drivers is non-zero a driver is attached to the struct device
> +	 * that provided the iommu_group and thus the iommu_group is a valid
> +	 * pointer. When drivers is 0 the driver is being detached. Once users
> +	 * reaches 0 then the iommu_group is invalid.
> +	 */
> +	refcount_t			drivers;
>  	refcount_t			users;
> +	struct completion		comp;
>  	unsigned int			container_users;
>  	struct iommu_group		*iommu_group;
>  	struct vfio_container		*container;
> @@ -276,8 +284,6 @@ void vfio_unregister_iommu_driver(const struct vfio_iommu_driver_ops *ops)
>  }
>  EXPORT_SYMBOL_GPL(vfio_unregister_iommu_driver);
>  
> -static void vfio_group_get(struct vfio_group *group);
> -
>  /*
>   * Container objects - containers are created when /dev/vfio/vfio is
>   * opened, but their lifecycle extends until the last user is done, so
> @@ -305,16 +311,21 @@ static void vfio_container_put(struct vfio_container *container)
>  /*
>   * Group objects - create, release, get, put, search
>   */
> +
> + /*
> +  * This returns a driver reference. It can only be used in the probe function
> +  * of a device_driver, eg as part of the internal implementation of
> +  * __vfio_register_dev().
> +  */
>  static struct vfio_group *
>  __vfio_group_get_from_iommu(struct iommu_group *iommu_group)
>  {
>  	struct vfio_group *group;
>  
>  	list_for_each_entry(group, &vfio.group_list, vfio_next) {
> -		if (group->iommu_group == iommu_group) {
> -			vfio_group_get(group);
> +		if (group->iommu_group == iommu_group &&
> +		    refcount_inc_not_zero(&group->drivers))
>  			return group;
> -		}
>  	}
>  	return NULL;
>  }
> @@ -364,6 +375,8 @@ static struct vfio_group *vfio_group_alloc(struct iommu_group *iommu_group,
>  	group->cdev.owner = THIS_MODULE;
>  
>  	refcount_set(&group->users, 1);
> +	refcount_set(&group->drivers, 1);
> +	init_completion(&group->comp);
>  	init_rwsem(&group->group_rwsem);
>  	INIT_LIST_HEAD(&group->device_list);
>  	mutex_init(&group->device_lock);
> @@ -422,8 +435,28 @@ static struct vfio_group *vfio_create_group(struct iommu_group *iommu_group,
>  
>  static void vfio_group_put(struct vfio_group *group)
>  {
> -	if (!refcount_dec_and_mutex_lock(&group->users, &vfio.group_lock))
> -		return;
> +	if (refcount_dec_and_test(&group->users))
> +		complete(&group->comp);
> +}
> +
> +/*
> + * When the drivers count reaches 0 then the group must be destroyed
> + * immediately. A zero driver group is a zombie awaiting destruction.
> + */
> +static void vfio_group_remove(struct vfio_group *group)
> +{
> +	/* Matches the get from vfio_group_alloc() */
> +	vfio_group_put(group);
> +
> +	cdev_device_del(&group->cdev, &group->dev);
> +
> +	/*
> +	 * Before we allow the last driver in the group to be unplugged the
> +	 * group must be sanitized so nothing else is or can reference it. This
> +	 * is because the group->iommu_group pointer is only valid so long as a
> +	 * VFIO device driver is attached to a device belonging to the group.
> +	 */
> +	wait_for_completion(&group->comp);
>  
>  	/*
>  	 * These data structures all have paired operations that can only be
> @@ -434,19 +467,15 @@ static void vfio_group_put(struct vfio_group *group)
>  	WARN_ON(!list_empty(&group->device_list));
>  	WARN_ON(group->container || group->container_users);
>  	WARN_ON(group->notifier.head);
> +	group->iommu_group = NULL;
>  
> +	mutex_lock(&vfio.group_lock);
>  	list_del(&group->vfio_next);
> -	cdev_device_del(&group->cdev, &group->dev);
>  	mutex_unlock(&vfio.group_lock);
>  
>  	put_device(&group->dev);
>  }
>  
> -static void vfio_group_get(struct vfio_group *group)
> -{
> -	refcount_inc(&group->users);
> -}
> -
>  /*
>   * Device objects - create, release, get, put, search
>   */
> @@ -462,22 +491,6 @@ static bool vfio_device_try_get(struct vfio_device *device)
>  	return refcount_inc_not_zero(&device->refcount);
>  }
>  
> -static struct vfio_device *vfio_group_get_device(struct vfio_group *group,
> -						 struct device *dev)
> -{
> -	struct vfio_device *device;
> -
> -	mutex_lock(&group->device_lock);
> -	list_for_each_entry(device, &group->device_list, group_next) {
> -		if (device->dev == dev && vfio_device_try_get(device)) {
> -			mutex_unlock(&group->device_lock);
> -			return device;
> -		}
> -	}
> -	mutex_unlock(&group->device_lock);
> -	return NULL;
> -}
> -
>  /*
>   * VFIO driver API
>   */
> @@ -576,8 +589,10 @@ static struct vfio_group *vfio_group_find_or_alloc(struct device *dev)
>  static int __vfio_register_dev(struct vfio_device *device,
>  		struct vfio_group *group)
>  {
> -	struct vfio_device *existing_device;
> -
> +	/*
> +	 * In all cases group is the output of one of the group allocation functions
> +	 * and we have group->drivers incremetned for us
> +	 */
>  	if (IS_ERR(group))
>  		return PTR_ERR(group);
>  
> @@ -588,18 +603,6 @@ static int __vfio_register_dev(struct vfio_device *device,
>  	if (!device->dev_set)
>  		vfio_assign_device_set(device, device);
>  
> -	existing_device = vfio_group_get_device(group, device->dev);
> -	if (existing_device) {
> -		dev_WARN(device->dev, "Device already exists on group %d\n",
> -			 iommu_group_id(group->iommu_group));
> -		vfio_device_put(existing_device);
> -		if (group->type == VFIO_NO_IOMMU ||
> -		    group->type == VFIO_EMULATED_IOMMU)
> -			iommu_group_remove_device(device->dev);
> -		vfio_group_put(group);
> -		return -EBUSY;
> -	}
> -
>  	/* Our reference on group is moved to the device */
>  	device->group = group;
>  
> @@ -702,8 +705,9 @@ void vfio_unregister_group_dev(struct vfio_device *device)
>  	if (group->type == VFIO_NO_IOMMU || group->type == VFIO_EMULATED_IOMMU)
>  		iommu_group_remove_device(device->dev);
>  
> -	/* Matches the get in vfio_register_group_dev() */
> -	vfio_group_put(group);
> +	/* Matches the alloc get in vfio_register_group_dev() */
> +	if (refcount_dec_and_test(&group->drivers))
> +		vfio_group_remove(group);
>  }
>  EXPORT_SYMBOL_GPL(vfio_unregister_group_dev);
>  

