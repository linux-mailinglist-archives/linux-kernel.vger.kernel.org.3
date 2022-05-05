Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6C6E51B9B0
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 10:10:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346729AbiEEIOO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 04:14:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346670AbiEEIOL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 04:14:11 -0400
Received: from us-smtp-delivery-74.mimecast.com (us-smtp-delivery-74.mimecast.com [170.10.129.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CBFF921E01
        for <linux-kernel@vger.kernel.org>; Thu,  5 May 2022 01:10:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1651738229;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=W38gAA92CbwpAJsovXhkL/wbuo3RfiQzorzsE5/cLJM=;
        b=Lt5I0Q0nLdeIEtqAM0XFhLpboHHGBjVGY1VtpGYD6NI/C2MtpCkG162Gna+74maS6xVfqB
        F4nt5bHqoIEWVB3G3+CnUqgy7b6rTZyNxDOOxE8vmfNzQefwd5mR8q8yISZXUgWkwCLC3V
        JRzgCwgl28I64TnxOqpDmcLAuHWhzT4=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-633-Sn4XYjm-P0iKkXChyHlnlw-1; Thu, 05 May 2022 04:10:28 -0400
X-MC-Unique: Sn4XYjm-P0iKkXChyHlnlw-1
Received: by mail-pl1-f200.google.com with SMTP id m11-20020a170902f64b00b0015820f8038fso1929424plg.23
        for <linux-kernel@vger.kernel.org>; Thu, 05 May 2022 01:10:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=W38gAA92CbwpAJsovXhkL/wbuo3RfiQzorzsE5/cLJM=;
        b=7Xn1xJsgqzwZKv+eMnKi03bv8gGelUtJLfdVu/5susf31wyT5+XU6m0pn/SFFjTVMf
         ifFSvwlrFuIr0n+heCqCII8ClukKViYBLCs97rOFYMFJRzcEPQdOU83yi3M2SPo8vixe
         7iY8RnP750UxGTCD2TWoWLhQjRcbBCvP7m3A9sAEocAGK7mUsmQm1wGMyb7AXa6sy6cd
         QKkWUD+QyzrXw/7iTSHCTZfrA4ErTttvsaeXHxrPyrzqYHmocDh2nZ1LRVVykWvWFWvw
         +u+6nFQpSYmBD1B4Uz8iGKB1uRay5s65Ev2LPwHY2WA8RiwZp9bm0ZrJknHaVv9EjtLb
         2VAA==
X-Gm-Message-State: AOAM533tCyQc56iuYA7FDk+/zfweR6s9qV+b6K9G0e9e78z2ISm1m0Vd
        hB57FzZTiRgSFhgo0fI0pMV/oLIw+dFtPgA+ntQO5On2IraYX0nfIlK2ydTsrw0yhKQakJCbJNP
        F731QCqA3QzF8VntHMa/z6ADN
X-Received: by 2002:a17:90b:4b01:b0:1dc:7405:dd62 with SMTP id lx1-20020a17090b4b0100b001dc7405dd62mr4671456pjb.160.1651738227264;
        Thu, 05 May 2022 01:10:27 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzJNmzcOYcJPY6GOPWW5DcJvaF45auJSncbZBBzW/G+F4/k471Veg764kO7NTNAVVQ8RLluPA==
X-Received: by 2002:a17:90b:4b01:b0:1dc:7405:dd62 with SMTP id lx1-20020a17090b4b0100b001dc7405dd62mr4671434pjb.160.1651738226985;
        Thu, 05 May 2022 01:10:26 -0700 (PDT)
Received: from [10.72.13.116] ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id pf5-20020a17090b1d8500b001cd4989ff64sm874792pjb.43.2022.05.05.01.10.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 May 2022 01:10:26 -0700 (PDT)
Message-ID: <813999b5-8e7e-b9c1-c63a-ca5a80d520b6@redhat.com>
Date:   Thu, 5 May 2022 16:10:19 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.8.1
Subject: Re: [PATCH v3 1/2] vdpa: Add support for querying vendor statistics
Content-Language: en-US
To:     Eli Cohen <elic@nvidia.com>, Si-Wei Liu <si-wei.liu@oracle.com>,
        "mst@redhat.com" <mst@redhat.com>
Cc:     "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20220502102201.190357-1-elic@nvidia.com>
 <20220502102201.190357-2-elic@nvidia.com>
 <f279bbbb-6af2-95f4-08c3-97ba72deb6cb@oracle.com>
 <DM8PR12MB5400350099D5A2C932C32B07ABC09@DM8PR12MB5400.namprd12.prod.outlook.com>
 <f54e1450-bdd0-860c-5962-90f312234134@oracle.com>
 <DM8PR12MB5400F57667C36D579F2EF95CABC39@DM8PR12MB5400.namprd12.prod.outlook.com>
From:   Jason Wang <jasowang@redhat.com>
In-Reply-To: <DM8PR12MB5400F57667C36D579F2EF95CABC39@DM8PR12MB5400.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


在 2022/5/4 13:44, Eli Cohen 写道:
>
>> -----Original Message-----
>> From: Si-Wei Liu <si-wei.liu@oracle.com>
>> Sent: Wednesday, May 4, 2022 7:44 AM
>> To: Eli Cohen <elic@nvidia.com>; mst@redhat.com; jasowang@redhat.com
>> Cc: virtualization@lists.linux-foundation.org; linux-kernel@vger.kernel.org
>> Subject: Re: [PATCH v3 1/2] vdpa: Add support for querying vendor statistics
>>
>>
>>
>> On 5/2/2022 10:13 PM, Eli Cohen wrote:
>>>> -----Original Message-----
>>>> From: Si-Wei Liu <si-wei.liu@oracle.com>
>>>> Sent: Tuesday, May 3, 2022 2:48 AM
>>>> To: Eli Cohen <elic@nvidia.com>; mst@redhat.com; jasowang@redhat.com
>>>> Cc: virtualization@lists.linux-foundation.org; linux-kernel@vger.kernel.org
>>>> Subject: Re: [PATCH v3 1/2] vdpa: Add support for querying vendor statistics
>>>>
>>>>
>>>>
>>>> On 5/2/2022 3:22 AM, Eli Cohen wrote:
>>>>> Allows to read vendor statistics of a vdpa device. The specific
>>>>> statistics data are received from the upstream driver in the form of an
>>>>> (attribute name, attribute value) pairs.
>>>>>
>>>>> An example of statistics for mlx5_vdpa device are:
>>>>>
>>>>> received_desc - number of descriptors received by the virtqueue
>>>>> completed_desc - number of descriptors completed by the virtqueue
>>>>>
>>>>> A descriptor using indirect buffers is still counted as 1. In addition,
>>>>> N chained descriptors are counted correctly N times as one would expect.
>>>>>
>>>>> A new callback was added to vdpa_config_ops which provides the means for
>>>>> the vdpa driver to return statistics results.
>>>>>
>>>>> The interface allows for reading all the supported virtqueues, including
>>>>> the control virtqueue if it exists.
>>>>>
>>>>> Below are some examples taken from mlx5_vdpa which are introduced in the
>>>>> following patch:
>>>>>
>>>>> 1. Read statistics for the virtqueue at index 1
>>>>>
>>>>> $ vdpa dev vstats show vdpa-a qidx 1
>>>>> vdpa-a:
>>>>> queue_type tx queue_index 1 received_desc 3844836 completed_desc 3844836
>>>>>
>>>>> 2. Read statistics for the virtqueue at index 32
>>>>> $ vdpa dev vstats show vdpa-a qidx 32
>>>>> vdpa-a:
>>>>> queue_type control_vq queue_index 32 received_desc 62 completed_desc 62
>>>>>
>>>>> 3. Read statisitics for the virtqueue at index 0 with json output
>>>>> $ vdpa -j dev vstats show vdpa-a qidx 0
>>>>> {"vstats":{"vdpa-a":{
>>>>> "queue_type":"rx","queue_index":0,"name":"received_desc","value":417776,\
>>>>>     "name":"completed_desc","value":417548}}}
>>>>>
>>>>> 4. Read statistics for the virtqueue at index 0 with preety json output
>>>>> $ vdpa -jp dev vstats show vdpa-a qidx 0
>>>>> {
>>>>>        "vstats": {
>>>>>            "vdpa-a": {
>>>>>
>>>>>                "queue_type": "rx",
>>>>>                "queue_index": 0,
>>>>>                "name": "received_desc",
>>>>>                "value": 417776,
>>>>>                "name": "completed_desc",
>>>>>                "value": 417548
>>>>>            }
>>>>>        }
>>>>> }
>>>>>
>>>>> Signed-off-by: Eli Cohen <elic@nvidia.com>
>>>>> ---
>>>>>     drivers/vdpa/vdpa.c       | 129 ++++++++++++++++++++++++++++++++++++++
>>>>>     include/linux/vdpa.h      |   5 ++
>>>>>     include/uapi/linux/vdpa.h |   6 ++
>>>>>     3 files changed, 140 insertions(+)
>>>>>
>>>>> diff --git a/drivers/vdpa/vdpa.c b/drivers/vdpa/vdpa.c
>>>>> index 2b75c00b1005..933466f61ca8 100644
>>>>> --- a/drivers/vdpa/vdpa.c
>>>>> +++ b/drivers/vdpa/vdpa.c
>>>>> @@ -909,6 +909,74 @@ vdpa_dev_config_fill(struct vdpa_device *vdev, struct sk_buff *msg, u32 portid,
>>>>>     	return err;
>>>>>     }
>>>>>
>>>>> +static int vdpa_fill_stats_rec(struct vdpa_device *vdev, struct sk_buff *msg,
>>>>> +			       struct genl_info *info, u32 index)
>>>>> +{
>>>>> +	int err;
>>>>> +
>>>>> +	err = vdev->config->get_vendor_vq_stats(vdev, index, msg, info->extack);
>>>>> +	if (err)
>>>>> +		return err;
>>>>> +
>>>>> +	if (nla_put_u32(msg, VDPA_ATTR_DEV_QUEUE_INDEX, index))
>>>>> +		return -EMSGSIZE;
>>>>> +
>>>>> +	return 0;
>>>>> +}
>>>>> +
>>>>> +static int vendor_stats_fill(struct vdpa_device *vdev, struct sk_buff *msg,
>>>>> +			     struct genl_info *info, u32 index)
>>>>> +{
>>>>> +	int err;
>>>>> +
>>>>> +	if (!vdev->config->get_vendor_vq_stats)
>>>>> +		return -EOPNOTSUPP;
>>>>> +
>>>>> +	err = vdpa_fill_stats_rec(vdev, msg, info, index);
>>>>> +	if (err)
>>>>> +		return err;
>>>>> +
>>>>> +	return 0;
>>>>> +}
>>>>> +
>>>>> +static int vdpa_dev_vendor_stats_fill(struct vdpa_device *vdev,
>>>>> +				      struct sk_buff *msg,
>>>>> +				      struct genl_info *info, u32 index)
>>>>> +{
>>>>> +	u32 device_id;
>>>>> +	void *hdr;
>>>>> +	int err;
>>>>> +	u32 portid = info->snd_portid;
>>>>> +	u32 seq = info->snd_seq;
>>>>> +	u32 flags = 0;
>>>>> +
>>>>> +	hdr = genlmsg_put(msg, portid, seq, &vdpa_nl_family, flags,
>>>>> +			  VDPA_CMD_DEV_VSTATS_GET);
>>>>> +	if (!hdr)
>>>>> +		return -EMSGSIZE;
>>>>> +
>>>>> +	if (nla_put_string(msg, VDPA_ATTR_DEV_NAME, dev_name(&vdev->dev))) {
>>>>> +		err = -EMSGSIZE;
>>>>> +		goto undo_msg;
>>>>> +	}
>>>>> +
>>>>> +	device_id = vdev->config->get_device_id(vdev);
>>>>> +	if (nla_put_u32(msg, VDPA_ATTR_DEV_ID, device_id)) {
>>>>> +		err = -EMSGSIZE;
>>>>> +		goto undo_msg;
>>>>> +	}
>>>>> +
>>>> You seem to miss VDPA_ATTR_DEV_NEGOTIATED_FEATURES from this function,
>>>> otherwise I can't image how you can ensure the atomicity to infer
>>>> queue_type for control vq.
>>>> And should we make sure VIRTIO_CONFIG_S_FEATURES_OK is set before call
>>>> into vendor_stats_fill()?
>>> It is done in the hardware driver. In this case, in mlx5_vdpa.
>> OK... So you think this is not vdpa common code but rather individual
>> vendor driver should deal with? Seems fine at the first glance, but with
>> some thoughts this would complicate userspace code quite a lot to tell
>> apart different cases - say if the VDPA_ATTR_DEV_NEGOTIATED_FEATURES
>> attr is missing it would not be possible to display the queue type. On
>> the other hand, the queue type itself shouldn't be vendor specific thing
>> - only the vendor stats are, right?
>>
> Right, although this feature is really about displaying statistics and queue type
> is just supplemental information.
>
>> Furthermore, without FEATURES_OK the stats returned for a specific queue
>> might not be stable/reliable/reasonable at all, not sure how the tool
>> can infer such complex state (e.g. negotiation is in progress) if
>> somehow the vendor driver doesn't provide the corresponding attribute?
>> Should vendor driver expect to fail with explicit message to indicate
>> the reason, or it'd be fine to just display zero stats there? Looking at
>> mlx5_vdpa implementation it seems to be the former case, but in case of
>> device being negotiating, depending on which queue, the vstat query
>> might end up with a confusing message of, either
>>
>> "virtqueue index is not valid"
>>
>> or,
>>
>> "failed to query hardware"
>>
>> but none is helpful for user to indicate what's going on... I wonder if
>> mandating presence of FEATURES_OK would simplify userspace tool's
>> implementation in this case?
> When you say "mandating", do you refer to kernel? The userspace tool
> can do that since it will have the negotiated features.


I think it might be helpful if the userspace code could be posted as well.

Thanks


>
> I am reluctant to splitting attributes insertion between hardware driver
> and generic vdpa code. If this is vendor specific feature I think all attributes
> should come from the vendor driver. But, I don't insist and can move to vdpa
> generic code.
>
>>
>> Thanks,
>> -Siwei
>>
>>>>> +	err = vendor_stats_fill(vdev, msg, info, index);
>>>>> +
>>>>> +	genlmsg_end(msg, hdr);
>>>>> +
>>>>> +	return err;
>>>>> +
>>>>> +undo_msg:
>>>>> +	genlmsg_cancel(msg, hdr);
>>>>> +	return err;
>>>>> +}
>>>>> +
>>>>>     static int vdpa_nl_cmd_dev_config_get_doit(struct sk_buff *skb, struct genl_info *info)
>>>>>     {
>>>>>     	struct vdpa_device *vdev;
>>>>> @@ -990,6 +1058,60 @@ vdpa_nl_cmd_dev_config_get_dumpit(struct sk_buff *msg, struct netlink_callback *
>>>>>     	return msg->len;
>>>>>     }
>>>>>
>>>>> +static int vdpa_nl_cmd_dev_stats_get_doit(struct sk_buff *skb,
>>>>> +					  struct genl_info *info)
>>>>> +{
>>>>> +	struct vdpa_device *vdev;
>>>>> +	struct sk_buff *msg;
>>>>> +	const char *devname;
>>>>> +	struct device *dev;
>>>>> +	u32 index;
>>>>> +	int err;
>>>>> +
>>>>> +	if (!info->attrs[VDPA_ATTR_DEV_NAME])
>>>>> +		return -EINVAL;
>>>>> +
>>>>> +	if (!info->attrs[VDPA_ATTR_DEV_QUEUE_INDEX])
>>>>> +		return -EINVAL;
>>>>> +
>>>>> +	devname = nla_data(info->attrs[VDPA_ATTR_DEV_NAME]);
>>>>> +	msg = nlmsg_new(NLMSG_DEFAULT_SIZE, GFP_KERNEL);
>>>>> +	if (!msg)
>>>>> +		return -ENOMEM;
>>>>> +
>>>>> +	index = nla_get_u32(info->attrs[VDPA_ATTR_DEV_QUEUE_INDEX]);
>>>>> +	mutex_lock(&vdpa_dev_mutex);
>>>> Given that stats_get() is a read-only operation that might happen quite
>>>> often from time to time, I wonder if it is now a good timing to convert
>>>> vdpa_dev_mutex to a semaphore?
>>>>
>>>>> +	dev = bus_find_device(&vdpa_bus, NULL, devname, vdpa_name_match);
>>>>> +	if (!dev) {
>>>>> +		NL_SET_ERR_MSG_MOD(info->extack, "device not found");
>>>>> +		err = -ENODEV;
>>>>> +		goto dev_err;
>>>> Missing nlmsg_free().
>>>>> +	}
>>>>> +	vdev = container_of(dev, struct vdpa_device, dev);
>>>>> +	if (!vdev->mdev) {
>>>>> +		NL_SET_ERR_MSG_MOD(info->extack, "unmanaged vdpa device");
>>>>> +		err = -EINVAL;
>>>>> +		goto mdev_err;
>>>> Missing nlmsg_free().
>>>>
>>>> Otherwise looks fine.
>>>>
>>>> Acked-by: Si-Wei Liu <si-wei.liu@oracle.com>
>>>>
>>>>
>>>> -Siwei
>>>>> +	}
>>>>> +	err = vdpa_dev_vendor_stats_fill(vdev, msg, info, index);
>>>>> +	if (!err)
>>>>> +		err = genlmsg_reply(msg, info);
>>>>> +
>>>>> +	put_device(dev);
>>>>> +	mutex_unlock(&vdpa_dev_mutex);
>>>>> +
>>>>> +	if (err)
>>>>> +		nlmsg_free(msg);
>>>>> +
>>>>> +	return err;
>>>>> +
>>>>> +mdev_err:
>>>>> +	put_device(dev);
>>>>> +dev_err:
>>>>> +	mutex_unlock(&vdpa_dev_mutex);
>>>>> +	return err;
>>>>> +}
>>>>> +
>>>>>     static const struct nla_policy vdpa_nl_policy[VDPA_ATTR_MAX + 1] = {
>>>>>     	[VDPA_ATTR_MGMTDEV_BUS_NAME] = { .type = NLA_NUL_STRING },
>>>>>     	[VDPA_ATTR_MGMTDEV_DEV_NAME] = { .type = NLA_STRING },
>>>>> @@ -997,6 +1119,7 @@ static const struct nla_policy vdpa_nl_policy[VDPA_ATTR_MAX + 1] = {
>>>>>     	[VDPA_ATTR_DEV_NET_CFG_MACADDR] = NLA_POLICY_ETH_ADDR,
>>>>>     	/* virtio spec 1.1 section 5.1.4.1 for valid MTU range */
>>>>>     	[VDPA_ATTR_DEV_NET_CFG_MTU] = NLA_POLICY_MIN(NLA_U16, 68),
>>>>> +	[VDPA_ATTR_DEV_QUEUE_INDEX] = NLA_POLICY_RANGE(NLA_U32, 0, 65535),
>>>>>     };
>>>>>
>>>>>     static const struct genl_ops vdpa_nl_ops[] = {
>>>>> @@ -1030,6 +1153,12 @@ static const struct genl_ops vdpa_nl_ops[] = {
>>>>>     		.doit = vdpa_nl_cmd_dev_config_get_doit,
>>>>>     		.dumpit = vdpa_nl_cmd_dev_config_get_dumpit,
>>>>>     	},
>>>>> +	{
>>>>> +		.cmd = VDPA_CMD_DEV_VSTATS_GET,
>>>>> +		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
>>>>> +		.doit = vdpa_nl_cmd_dev_stats_get_doit,
>>>>> +		.flags = GENL_ADMIN_PERM,
>>>>> +	},
>>>>>     };
>>>>>
>>>>>     static struct genl_family vdpa_nl_family __ro_after_init = {
>>>>> diff --git a/include/linux/vdpa.h b/include/linux/vdpa.h
>>>>> index 8943a209202e..48ed1fc00830 100644
>>>>> --- a/include/linux/vdpa.h
>>>>> +++ b/include/linux/vdpa.h
>>>>> @@ -276,6 +276,9 @@ struct vdpa_config_ops {
>>>>>     			    const struct vdpa_vq_state *state);
>>>>>     	int (*get_vq_state)(struct vdpa_device *vdev, u16 idx,
>>>>>     			    struct vdpa_vq_state *state);
>>>>> +	int (*get_vendor_vq_stats)(struct vdpa_device *vdev, u16 idx,
>>>>> +				   struct sk_buff *msg,
>>>>> +				   struct netlink_ext_ack *extack);
>>>>>     	struct vdpa_notification_area
>>>>>     	(*get_vq_notification)(struct vdpa_device *vdev, u16 idx);
>>>>>     	/* vq irq is not expected to be changed once DRIVER_OK is set */
>>>>> @@ -473,4 +476,6 @@ struct vdpa_mgmt_dev {
>>>>>     int vdpa_mgmtdev_register(struct vdpa_mgmt_dev *mdev);
>>>>>     void vdpa_mgmtdev_unregister(struct vdpa_mgmt_dev *mdev);
>>>>>
>>>>> +#define VDPA_INVAL_QUEUE_INDEX 0xffff
>>>>> +
>>>>>     #endif /* _LINUX_VDPA_H */
>>>>> diff --git a/include/uapi/linux/vdpa.h b/include/uapi/linux/vdpa.h
>>>>> index 1061d8d2d09d..25c55cab3d7c 100644
>>>>> --- a/include/uapi/linux/vdpa.h
>>>>> +++ b/include/uapi/linux/vdpa.h
>>>>> @@ -18,6 +18,7 @@ enum vdpa_command {
>>>>>     	VDPA_CMD_DEV_DEL,
>>>>>     	VDPA_CMD_DEV_GET,		/* can dump */
>>>>>     	VDPA_CMD_DEV_CONFIG_GET,	/* can dump */
>>>>> +	VDPA_CMD_DEV_VSTATS_GET,
>>>>>     };
>>>>>
>>>>>     enum vdpa_attr {
>>>>> @@ -46,6 +47,11 @@ enum vdpa_attr {
>>>>>     	VDPA_ATTR_DEV_NEGOTIATED_FEATURES,	/* u64 */
>>>>>     	VDPA_ATTR_DEV_MGMTDEV_MAX_VQS,		/* u32 */
>>>>>     	VDPA_ATTR_DEV_SUPPORTED_FEATURES,	/* u64 */
>>>>> +
>>>>> +	VDPA_ATTR_DEV_QUEUE_INDEX,              /* u32 */
>>>>> +	VDPA_ATTR_DEV_VENDOR_ATTR_NAME,		/* string */
>>>>> +	VDPA_ATTR_DEV_VENDOR_ATTR_VALUE,        /* u64 */
>>>>> +
>>>>>     	/* new attributes must be added above here */
>>>>>     	VDPA_ATTR_MAX,
>>>>>     };

