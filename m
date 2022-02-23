Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EABA54C0F25
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Feb 2022 10:26:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239177AbiBWJ1R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Feb 2022 04:27:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235331AbiBWJ1P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 04:27:15 -0500
Received: from hel-mailgw-01.vaisala.com (hel-mailgw-01.vaisala.com [193.143.230.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0F55109B;
        Wed, 23 Feb 2022 01:26:45 -0800 (PST)
Received: from HEL-SMTP.corp.vaisala.com (HEL-SMTP.corp.vaisala.com [172.24.1.225])
        by hel-mailgw-01.vaisala.com (Postfix) with ESMTP id 6631560674AA;
        Wed, 23 Feb 2022 11:26:38 +0200 (EET)
Received: from [172.24.190.103] ([172.24.190.103]) by HEL-SMTP.corp.vaisala.com over TLS secured channel with Microsoft SMTPSVC(8.5.9600.16384);
         Wed, 23 Feb 2022 11:26:40 +0200
Message-ID: <d62b6e76-164d-0adb-596a-d9743de95839@vaisala.com>
Date:   Wed, 23 Feb 2022 11:26:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [RFC PATCH] iio: core: provide a default value `label` property
Content-Language: en-US
To:     Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Cc:     Jonathan Cameron <jic23@kernel.org>, lars@metafoo.de,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220216135604.3435769-1-nandor.han@vaisala.com>
 <20220220131809.1bc184e0@jic23-huawei>
 <4f0c786f-e29c-4838-59e3-236a908e4431@vaisala.com>
 <20220222163606.00005996@Huawei.com>
From:   Nandor Han <nandor.han@vaisala.com>
In-Reply-To: <20220222163606.00005996@Huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 23 Feb 2022 09:26:40.0238 (UTC) FILETIME=[769998E0:01D82897]
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/22/22 18:36, Jonathan Cameron wrote:
> On Tue, 22 Feb 2022 09:42:12 +0200
> Nandor Han <nandor.han@vaisala.com> wrote:
> 
>> On 2/20/22 15:18, Jonathan Cameron wrote:
>>> On Wed, 16 Feb 2022 15:56:04 +0200
>>> Nandor Han <nandor.han@vaisala.com> wrote:
>>>    
>>
>> Thanks for reviewing the patch and provide feed back.
>>
>>>> The label property is used to correctly identify the same IIO device
>>>> over reboots. The implementation requires that a value will be provided
>>>> through device-tree. This sometime could requires many changes to
>>>> device-trees when multiple devices want to use the label property.
>>>> In order to prevent this, we could use the device-tree node
>>>> name as default value. The device-tree node name is unique and
>>>> also reflects the device which makes it a good choice as default value.
>>>> This change is backward compatible since doesn't affect the users that
>>>> do configure a label using the device-tree or the ones that are not
>>>> using the labels at all.
>>>>
>>>> Use the device-tree node name as a default value for `label` property,
>>>> in case there isn't one configured through device-tree.
>>>
>>> Interesting idea.  However a few concerns come to mind.
>>> 1) If we start having a default for this, then it will get used as ABI
>>>      and if a label is applied later to the DT then we will end up breaking
>>>      userspace scripts.
>>
>> When a label is explicitly configured means that the userspace expects
>> to have that value available. Therefore, I don't see this as ABI change,
>> given that this affects the property label content and not for example
>> the property name.
> 
> The potential issue is that with this userspace code may rely on the common
> option (matches device tree node name) and then get confused on it changing.
> 
> If it wasn't there previously and appears (which is what happens when
> a label is added currently) userspace is unlikely to have in some fashion
> depended on it not being there...
> 

If they rely on missing the label, it's true this will break that.

> If someone modifies an existing label they can reasonably expect to break
> compatibility because they made something 'go away'.
> 
>>
>>> 2) If we do this it should be firmware agnostics (we need to fix
>>>      the existing code to be such as well).
>>
>> Not sure I understand this. If you could explain a bit more I would
>> really appriciate.
> 
> Typo in that didn't help. (agnostic).  Anyhow, basically it has to work
> for ACPI as well.
> 
>>
>>> 3) Is the node name always unique (think multiple accelerometers on
>>>      different i2c masters)?
>>> 3) I'm fairly sure this information is readily available anyway.
>>>      either via the of_node link for the iio\:deviceX
>>>      So why not have your usespace use that instead of label?
>>>      I'm not a fan of duplicating information that is readily available
>>>      anyway - be it as name and reg in the of_node directory.
>>>    
>>
>> The node name supposed to be unique AFAIK and you're right it is
>> available already in the userspace.
> 
> It's not unique.  As per https://eur03.safelinks.protection.outlook.com/?url=https%3A%2F%2Felinux.org%2FDevice_Tree_Usage&amp;data=04%7C01%7Cnandor.han%40vaisala.com%7Cdbfd5d178b484f5258fe08d9f6216e65%7C6d7393e041f54c2e9b124c2be5da5c57%7C0%7C0%7C637811445712047047%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000&amp;sdata=0y2Vx5Cqso5iYAvA58tXnfzI%2BJ9oUbhvDIIkC8XP6Ik%3D&amp;reserved=0,
> "sibling nodes are expected to be unique".  If you have multiple
> i2c masters and the same device under each of them with the
> same i2c address they are not siblings (different parents) and
> will have the same node name.
> 

Thanks for the info. Keep that in mind

> 
>> My point with this patch is to provide a default value for the label
>> content and I'm open to suggestions related to content. The of_node name
>> was something that I thought that is unique and easy to use, but if
>> somebody has better suggestions I'm really open to these.
> 
> I don't see why we want a default label. If it's not provided it's
> not there (no file) and userspace can go use something else for
> it's unique naming. Note that for older kernels they need to do
> that anyway because label never existed. So userspace will need
> to work with possibility of it being absent. As userspace is
> going to do that today, why add another option so we have:
> 
> 1) No label attribute.
> 2) Label attribute == node name
> 3) Label attribute something else
> 
> vs having to handle 2 cases.
> 
> 1) No label attribute
> 2) Label attribute present.
> 
> So adding a default makes userspace code more complex, not less.
> 

Thanks for the explanation and review.

Given the above comments I guess we will drop this idea.



Thanks and Regards,
    Nandor
