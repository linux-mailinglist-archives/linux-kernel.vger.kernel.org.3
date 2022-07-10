Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B31B656CFFA
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Jul 2022 18:09:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229660AbiGJQJw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Jul 2022 12:09:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbiGJQJu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Jul 2022 12:09:50 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1CB6FD119
        for <linux-kernel@vger.kernel.org>; Sun, 10 Jul 2022 09:09:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1657469389;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5JEb/uVG3DX+vJnFG63dtA/86MruuqcGl4hcFXTDLsU=;
        b=KbciULYgDtIf1uPhyZdqZtQZOam2pYmGJZ1GTyuA+2f/FqHDX3gPmP3qZ616cfyRPdsSJr
        k8HcfC6Av+7a2ft8VdwyJPuv2J3x1m6bPOXKGQTvH1Bqg2DKJ4pbfPoMAsf3SkXD7t6jd5
        qki3hzZIESROcCk7VivlyZy+GudyM1w=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-41-RjV0XwF-M2eV9E6RVWgQ5w-1; Sun, 10 Jul 2022 12:09:47 -0400
X-MC-Unique: RjV0XwF-M2eV9E6RVWgQ5w-1
Received: by mail-ed1-f69.google.com with SMTP id f13-20020a0564021e8d00b00437a2acb543so2703055edf.7
        for <linux-kernel@vger.kernel.org>; Sun, 10 Jul 2022 09:09:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=5JEb/uVG3DX+vJnFG63dtA/86MruuqcGl4hcFXTDLsU=;
        b=CN43n1By7sbkF3WOEZtkrMs+RsPTkYlLkS0nZngaeUOANjbV4mvmCNemZkn5kzI82Z
         KpieJF38JdoZKsjXZGD7EDCVVm27Ew6Mzk2uCnZIt9A6//enM3RocnbUe7817ckh0ycf
         hDVrsjEHptsZiy1NtvPr4hKtv8SNOJxWttuY2Mo8z6cI5r+M+gFGA6L4gd6FWU8byM4D
         3e4eyRya42/ANaUuKdyo14cq0iuYtaaVZmoAv0C68/T8WLittX3nJewh1n2zb2eGXLUe
         lA5iPJyZk7aokDRwfGnlUwbGjju5fN2yhobqQopFc6TIF60WgctE6xJMH2SpgHThAp+A
         juOA==
X-Gm-Message-State: AJIora9bEcR08lPFTO3p4u9FpDKN56tGWDvKPSNHZ3O/SYaKTTYinEK4
        JG4dJk6PC8FiMM5R4DjwVOHozvCZ3ucj0HEA1aRlF6fm0w646MHPlD65tImz41AqyZ3kI4tLEjh
        Bgy8yQY8IMTITBgbv0DjUPM5l
X-Received: by 2002:a05:6402:241e:b0:437:d732:20d2 with SMTP id t30-20020a056402241e00b00437d73220d2mr19246727eda.39.1657469386712;
        Sun, 10 Jul 2022 09:09:46 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1tAEO7VsUhPfsSyPmdDqBi85AM9kac/m49JwWXrH0pYNbMO9JLrifA/AA3CovwAufvSHKZErA==
X-Received: by 2002:a05:6402:241e:b0:437:d732:20d2 with SMTP id t30-20020a056402241e00b00437d73220d2mr19246700eda.39.1657469386519;
        Sun, 10 Jul 2022 09:09:46 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c1e:bf00:d69d:5353:dba5:ee81? (2001-1c00-0c1e-bf00-d69d-5353-dba5-ee81.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:d69d:5353:dba5:ee81])
        by smtp.gmail.com with ESMTPSA id gs5-20020a170906f18500b0072aa0d9ba93sm1686888ejb.134.2022.07.10.09.09.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 10 Jul 2022 09:09:45 -0700 (PDT)
Message-ID: <745efcbc-4b9f-df25-d587-4b4409b82518@redhat.com>
Date:   Sun, 10 Jul 2022 18:09:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH] platform/x86/intel/ifs: Allow non-default names for IFS
 image
Content-Language: en-US
To:     "Joseph, Jithu" <jithu.joseph@intel.com>,
        Greg KH <gregkh@linuxfoundation.org>
Cc:     markgross@kernel.org, ashok.raj@intel.com, tony.luck@intel.com,
        ravi.v.shankar@intel.com, linux-kernel@vger.kernel.org,
        platform-driver-x86@vger.kernel.org, patches@lists.linux.dev
References: <20220708151938.986530-1-jithu.joseph@intel.com>
 <YshNAh6awfPFmxzU@kroah.com> <33a6193e-1084-ae5f-1f80-232274f71bd0@intel.com>
 <Ysqm1BRbCTtWfAcW@kroah.com>
 <79eae42f-50ca-c23c-9fd0-8c356b2d3783@redhat.com>
 <YsrZwc9P34lICS99@kroah.com>
 <c416b93b-8adc-d9a8-ef0d-594cce6d9a9d@redhat.com>
 <4483d1fe-417f-4279-3460-dca351ee42e2@intel.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <4483d1fe-417f-4279-3460-dca351ee42e2@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 7/10/22 18:04, Joseph, Jithu wrote:
> 
> 
> On 7/10/2022 7:08 AM, Hans de Goede wrote:
>> Hi Greg,
>>
>> On 7/10/22 15:53, Greg KH wrote:
>>> On Sun, Jul 10, 2022 at 03:42:29PM +0200, Hans de Goede wrote:
>>>> Hi,
>>>>
>>>> On 7/10/22 12:15, Greg KH wrote:
>>>>> On Fri, Jul 08, 2022 at 11:34:40AM -0700, Joseph, Jithu wrote:
>>>>>>
>>>>>>
>>>>>> On 7/8/2022 8:28 AM, Greg KH wrote:
>>>>>>> On Fri, Jul 08, 2022 at 08:19:38AM -0700, Jithu Joseph wrote:
>>>>>>>> Existing implementation limits IFS image to be loaded only from
> 
>>>>>
>>>>> Ick, you are overloading an existing sysfs file to do different things
>>>>> based on random stuff.  This is a brand-new api that you are already
>>>>> messing with in crazy ways.  Why not just revert the whole thing and
>>>>> start over as obviously this was not tested well with real devices.
>>>>>
>>>>> And what is wrong with a firmware file called '1'?  :)
>>>>
>>>> Actually the Intel IFS stuff has landed in 5.19-rc# so it is
>>>> a bit late(ish) for dropping it now.
>>>
>>> We can mark it BROKEN right now before -final happens as it seems that
>>> the api in 5.19-rc is not correct for its users.
>>>
>>> Perhaps we should do that now to give people the chance to get it right?
>>
>> That is a good idea. I've just send out a patch doing that.
>>
>> I plan to submit one last pdx86 fixes pull-req to Linus once rc6 is out
>> (prepping it now and want to give the builders some time to build test it).
>>
>> I'll include this in this fixes pull-req.
>>
> 
> I did send a v2 just now, which removes treating 1 specially. Not sure
> if it is too late, but just wanted to give it a shot

The v2 patch does look better to me, thanks.

But IMHO it is not good idea to fix userspace API issues during or
after rc6. So lets keep this marked as broken in Kconfig for 5.19 final
and then we can get something like v2 merged into 5.20-rc1 in a couple
of weeks and then also remove the broken marking.

For enterprise distros to be able to backport this what matters is it
being in Torvald's master branch, so from that pov this just delays
things a couple of weeks. Which is well worth it IMHO to give us some more
time to get the userspace API right.

Regards,

Hans

