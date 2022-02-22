Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33AE64BF2FA
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 08:58:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229789AbiBVH6k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 02:58:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbiBVH6j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 02:58:39 -0500
X-Greylist: delayed 600 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 21 Feb 2022 23:58:13 PST
Received: from hel-mailgw-01.vaisala.com (hel-mailgw-01.vaisala.com [193.143.230.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0DB61405F6;
        Mon, 21 Feb 2022 23:58:13 -0800 (PST)
Received: from HEL-SMTP.corp.vaisala.com (HEL-SMTP.corp.vaisala.com [172.24.1.225])
        by hel-mailgw-01.vaisala.com (Postfix) with ESMTP id 82D566082A42;
        Tue, 22 Feb 2022 09:42:15 +0200 (EET)
Received: from [172.24.254.98] ([172.24.254.98]) by HEL-SMTP.corp.vaisala.com over TLS secured channel with Microsoft SMTPSVC(8.5.9600.16384);
         Tue, 22 Feb 2022 09:42:19 +0200
Message-ID: <4f0c786f-e29c-4838-59e3-236a908e4431@vaisala.com>
Date:   Tue, 22 Feb 2022 09:42:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [RFC PATCH] iio: core: provide a default value `label` property
Content-Language: en-US
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     lars@metafoo.de, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220216135604.3435769-1-nandor.han@vaisala.com>
 <20220220131809.1bc184e0@jic23-huawei>
From:   Nandor Han <nandor.han@vaisala.com>
In-Reply-To: <20220220131809.1bc184e0@jic23-huawei>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 22 Feb 2022 07:42:19.0874 (UTC) FILETIME=[B8B81C20:01D827BF]
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/20/22 15:18, Jonathan Cameron wrote:
> On Wed, 16 Feb 2022 15:56:04 +0200
> Nandor Han <nandor.han@vaisala.com> wrote:
> 

Thanks for reviewing the patch and provide feed back.

>> The label property is used to correctly identify the same IIO device
>> over reboots. The implementation requires that a value will be provided
>> through device-tree. This sometime could requires many changes to
>> device-trees when multiple devices want to use the label property.
>> In order to prevent this, we could use the device-tree node
>> name as default value. The device-tree node name is unique and
>> also reflects the device which makes it a good choice as default value.
>> This change is backward compatible since doesn't affect the users that
>> do configure a label using the device-tree or the ones that are not
>> using the labels at all.
>>
>> Use the device-tree node name as a default value for `label` property,
>> in case there isn't one configured through device-tree.
> 
> Interesting idea.  However a few concerns come to mind.
> 1) If we start having a default for this, then it will get used as ABI
>     and if a label is applied later to the DT then we will end up breaking
>     userspace scripts.

When a label is explicitly configured means that the userspace expects 
to have that value available. Therefore, I don't see this as ABI change, 
given that this affects the property label content and not for example 
the property name.

> 2) If we do this it should be firmware agnostics (we need to fix
>     the existing code to be such as well).

Not sure I understand this. If you could explain a bit more I would 
really appriciate.

> 3) Is the node name always unique (think multiple accelerometers on
>     different i2c masters)?
> 3) I'm fairly sure this information is readily available anyway.
>     either via the of_node link for the iio\:deviceX
>     So why not have your usespace use that instead of label?
>     I'm not a fan of duplicating information that is readily available
>     anyway - be it as name and reg in the of_node directory.
> 

The node name supposed to be unique AFAIK and you're right it is 
available already in the userspace.
My point with this patch is to provide a default value for the label 
content and I'm open to suggestions related to content. The of_node name 
was something that I thought that is unique and easy to use, but if 
somebody has better suggestions I'm really open to these.

> Thanks,
> 
> Jonathan
> 

<snip>


Thanks again and regards,
    Nandor
