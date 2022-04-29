Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6ECB513F80
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 02:25:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352229AbiD2A2M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 20:28:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237176AbiD2A2I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 20:28:08 -0400
Received: from out2.migadu.com (out2.migadu.com [IPv6:2001:41d0:2:aacc::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DA44BB081;
        Thu, 28 Apr 2022 17:24:51 -0700 (PDT)
Subject: Re: [PATCH v2 01/12] md/raid5: Factor out ahead_of_reshape() function
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1651191889;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=iSBOO50OR8+5K2ZkY0YlkbGrEvhyMneIB+LGNkRkwU4=;
        b=WHdR1HcgICEpWz+lyrno+13G8LUYpkcqZs5jc/jWDY3B8imjX78V2+gQmyCdrKv2DOQt+S
        IQt77bt2cWTHsONhpnlI4sB0bhy6bQLQvsbGtTnZ/i9elRWeFomgK+AeOeGxl/fKOmb5t/
        pAC+k9jgTjWM8uoFMWw/jGjm696/cQo=
To:     Logan Gunthorpe <logang@deltatee.com>,
        linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org,
        Song Liu <song@kernel.org>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Stephen Bates <sbates@raithlin.com>,
        Martin Oliveira <Martin.Oliveira@eideticom.com>,
        David Sloan <David.Sloan@eideticom.com>,
        Christoph Hellwig <hch@lst.de>
References: <20220420195425.34911-1-logang@deltatee.com>
 <20220420195425.34911-2-logang@deltatee.com>
 <2a6d5554-4f71-6476-6d14-031da52005f5@linux.dev>
 <fe7f6d8a-8c66-3e90-1c52-140fe9d4cf1a@deltatee.com>
 <19d88098-7e52-38de-ceb7-a68debfbbd10@linux.dev>
 <78a6ffae-7701-e0dd-3130-a9a95473d16b@deltatee.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Guoqing Jiang <guoqing.jiang@linux.dev>
Message-ID: <7c2c8d8e-f13f-ac89-40c6-7d5c5c084970@linux.dev>
Date:   Fri, 29 Apr 2022 08:24:44 +0800
MIME-Version: 1.0
In-Reply-To: <78a6ffae-7701-e0dd-3130-a9a95473d16b@deltatee.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/28/22 11:44 PM, Logan Gunthorpe wrote:
>
>
> On 2022-04-27 19:49, Guoqing Jiang wrote:
>>
>> On 4/28/22 12:07 AM, Logan Gunthorpe wrote:
>>> On 2022-04-26 19:28, Guoqing Jiang wrote:
>>>>>     +static bool ahead_of_reshape(struct mddev *mddev, sector_t sector,
>>>>> +                 sector_t reshape_sector)
>>>>> +{
>>>>> +    if (mddev->reshape_backwards)
>>>>> +        return sector < reshape_sector;
>>>>> +    else
>>>>> +        return sector >= reshape_sector;
>>>>> +}
>>>> I think it can be an inline function.
>>> Marking static functions in C files as inline is not recommended. GCC
>>> will inline it, if it is appropriate.
>>>
>>> https://yarchive.net/comp/linux/inline.html
>>> https://www.kernel.org/doc/local/inline.html
>> Thanks for the link, then I suppose those can be deleted
>> linux> grep "static inline" drivers/md/md.h -r
> It's standard practice to annotate small functions in headers with
> "static inline". Without the inline annotation, any C file that includes
> the header and doesn't use the function will emit a "defined but not
> used warning".
>
> Functions in headers also should, by definition, be small and
> specifically inline-able (ie they are used as a type-safe macro).
>
> static functions in C files (not headers) should not have the inline
> keyword as GCC can optimize them and inline them as it sees fit and the
> inline keyword doesn't actually do anything.

I am happy to be taught, but still I can see lots of static function in 
C files
as well, at least

linux> grep "static inline" drivers/md/*.c -r|wc
      98     661    8630

Anyway, I don't want to argue about it anymore.

Thanks,
Guoqing
