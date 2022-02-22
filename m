Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 283F44BFEDB
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 17:36:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232425AbiBVQgj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 11:36:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231527AbiBVQgh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 11:36:37 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9A859E579;
        Tue, 22 Feb 2022 08:36:11 -0800 (PST)
Received: from fraeml702-chm.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4K34XX356Sz67ws6;
        Wed, 23 Feb 2022 00:35:24 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml702-chm.china.huawei.com (10.206.15.51) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.21; Tue, 22 Feb 2022 17:36:08 +0100
Received: from localhost (10.47.30.92) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.21; Tue, 22 Feb
 2022 16:36:07 +0000
Date:   Tue, 22 Feb 2022 16:36:06 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Nandor Han <nandor.han@vaisala.com>
CC:     Jonathan Cameron <jic23@kernel.org>, <lars@metafoo.de>,
        <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH] iio: core: provide a default value `label` property
Message-ID: <20220222163606.00005996@Huawei.com>
In-Reply-To: <4f0c786f-e29c-4838-59e3-236a908e4431@vaisala.com>
References: <20220216135604.3435769-1-nandor.han@vaisala.com>
        <20220220131809.1bc184e0@jic23-huawei>
        <4f0c786f-e29c-4838-59e3-236a908e4431@vaisala.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.29; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.30.92]
X-ClientProxiedBy: lhreml713-chm.china.huawei.com (10.201.108.64) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 22 Feb 2022 09:42:12 +0200
Nandor Han <nandor.han@vaisala.com> wrote:

> On 2/20/22 15:18, Jonathan Cameron wrote:
> > On Wed, 16 Feb 2022 15:56:04 +0200
> > Nandor Han <nandor.han@vaisala.com> wrote:
> >   
> 
> Thanks for reviewing the patch and provide feed back.
> 
> >> The label property is used to correctly identify the same IIO device
> >> over reboots. The implementation requires that a value will be provided
> >> through device-tree. This sometime could requires many changes to
> >> device-trees when multiple devices want to use the label property.
> >> In order to prevent this, we could use the device-tree node
> >> name as default value. The device-tree node name is unique and
> >> also reflects the device which makes it a good choice as default value.
> >> This change is backward compatible since doesn't affect the users that
> >> do configure a label using the device-tree or the ones that are not
> >> using the labels at all.
> >>
> >> Use the device-tree node name as a default value for `label` property,
> >> in case there isn't one configured through device-tree.  
> > 
> > Interesting idea.  However a few concerns come to mind.
> > 1) If we start having a default for this, then it will get used as ABI
> >     and if a label is applied later to the DT then we will end up breaking
> >     userspace scripts.  
> 
> When a label is explicitly configured means that the userspace expects 
> to have that value available. Therefore, I don't see this as ABI change, 
> given that this affects the property label content and not for example 
> the property name.

The potential issue is that with this userspace code may rely on the common
option (matches device tree node name) and then get confused on it changing.

If it wasn't there previously and appears (which is what happens when
a label is added currently) userspace is unlikely to have in some fashion
depended on it not being there...

If someone modifies an existing label they can reasonably expect to break
compatibility because they made something 'go away'.

> 
> > 2) If we do this it should be firmware agnostics (we need to fix
> >     the existing code to be such as well).  
> 
> Not sure I understand this. If you could explain a bit more I would 
> really appriciate.

Typo in that didn't help. (agnostic).  Anyhow, basically it has to work
for ACPI as well.

> 
> > 3) Is the node name always unique (think multiple accelerometers on
> >     different i2c masters)?
> > 3) I'm fairly sure this information is readily available anyway.
> >     either via the of_node link for the iio\:deviceX
> >     So why not have your usespace use that instead of label?
> >     I'm not a fan of duplicating information that is readily available
> >     anyway - be it as name and reg in the of_node directory.
> >   
> 
> The node name supposed to be unique AFAIK and you're right it is 
> available already in the userspace.

It's not unique.  As per https://elinux.org/Device_Tree_Usage,
"sibling nodes are expected to be unique".  If you have multiple
i2c masters and the same device under each of them with the
same i2c address they are not siblings (different parents) and
will have the same node name. 


> My point with this patch is to provide a default value for the label 
> content and I'm open to suggestions related to content. The of_node name 
> was something that I thought that is unique and easy to use, but if 
> somebody has better suggestions I'm really open to these.

I don't see why we want a default label. If it's not provided it's
not there (no file) and userspace can go use something else for
it's unique naming. Note that for older kernels they need to do
that anyway because label never existed. So userspace will need
to work with possibility of it being absent. As userspace is
going to do that today, why add another option so we have:

1) No label attribute.
2) Label attribute == node name
3) Label attribute something else

vs having to handle 2 cases.

1) No label attribute
2) Label attribute present.

So adding a default makes userspace code more complex, not less.

Jonathan
> 
> > Thanks,
> > 
> > Jonathan
> >   
> 
> <snip>
> 
> 
> Thanks again and regards,
>     Nandor

