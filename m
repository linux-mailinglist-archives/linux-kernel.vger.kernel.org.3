Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0382156CF5A
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Jul 2022 16:08:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229536AbiGJOIr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Jul 2022 10:08:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbiGJOIo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Jul 2022 10:08:44 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 16C8F95BE
        for <linux-kernel@vger.kernel.org>; Sun, 10 Jul 2022 07:08:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1657462123;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=sZ+Ir5UHkWJnKPJDN3wCsOO/4a0jZwNAsijgMvisGzE=;
        b=Nr1QLycOdPuX+LxkR+q01vdSInVsKk6/y1kOmUbcKgACDBTVq2nThYNsFm4qLJxRxV8uAU
        KX6cyF/59ZZ45e2uGkfv5UxLkBtaYpLE3AvhsrVqj0W8yyV/TpVzLUNPNM0EQ4bgyPfjeV
        cuoUIALPc+g9E7TNg6/W/znYAf0G3uM=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-231-ByhH7ebQOPyQk4axnha-eQ-1; Sun, 10 Jul 2022 10:08:41 -0400
X-MC-Unique: ByhH7ebQOPyQk4axnha-eQ-1
Received: by mail-ed1-f69.google.com with SMTP id f13-20020a0564021e8d00b00437a2acb543so2596012edf.7
        for <linux-kernel@vger.kernel.org>; Sun, 10 Jul 2022 07:08:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=sZ+Ir5UHkWJnKPJDN3wCsOO/4a0jZwNAsijgMvisGzE=;
        b=JWv+ktEzIyNaGS3+aWd+pGFCBwvG6viNEQ7Ai0AWN1tS2axaVvrbMIFpg3WLoAB2pn
         Yk8ABup3+p7zNVb75uJMlAzFzqQTAA/vM2keaSkodpRVI79TodfRkrJQIodveoCGNduw
         RriUPZuXG9Jd0TwFEnHRKdULotW9GbKEg9LPJ+suHmNNi7w3tgIsyZ/IgnLK17puQXEN
         Vg313KSidJQ7aa6YQi9PRljv567iNnceSprLqGzLRbKj5ZyA+Pd3Dqto6tqTkqQmL5v5
         kWd/Ms1DNLkOBj8LDYErfgJZxfgrC8f1a7ILvxtD69AxN5FlMBwNBKLEdECoPfz8Yda0
         Tvqw==
X-Gm-Message-State: AJIora8aEgpEvPVg0JvSGO4uRsmpcG4HneHze52QPxh/TBw5zXFYwyLr
        pVIgVAkJS6h4KQ5TKB8rLIMN/yEEYS26jPYL5x1XacCSjZI53KODCDNclXs0JB2xIUZzlFMjJJ8
        ycbrtOfOTD71uR4ww7iuBIfFO
X-Received: by 2002:a17:907:9693:b0:726:372c:2c02 with SMTP id hd19-20020a170907969300b00726372c2c02mr13804638ejc.483.1657462120456;
        Sun, 10 Jul 2022 07:08:40 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1tvZYcSZLE5z95IwwNnidfUvhPzTEicgyUuf8VshR8QlLUySMai4yVrsn7nMBFpW59UEsA4Dw==
X-Received: by 2002:a17:907:9693:b0:726:372c:2c02 with SMTP id hd19-20020a170907969300b00726372c2c02mr13804623ejc.483.1657462120277;
        Sun, 10 Jul 2022 07:08:40 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c1e:bf00:d69d:5353:dba5:ee81? (2001-1c00-0c1e-bf00-d69d-5353-dba5-ee81.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:d69d:5353:dba5:ee81])
        by smtp.gmail.com with ESMTPSA id f10-20020a1709064dca00b006fef557bb7asm1615582ejw.80.2022.07.10.07.08.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 10 Jul 2022 07:08:39 -0700 (PDT)
Message-ID: <c416b93b-8adc-d9a8-ef0d-594cce6d9a9d@redhat.com>
Date:   Sun, 10 Jul 2022 16:08:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH] platform/x86/intel/ifs: Allow non-default names for IFS
 image
Content-Language: en-US
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     "Joseph, Jithu" <jithu.joseph@intel.com>, markgross@kernel.org,
        ashok.raj@intel.com, tony.luck@intel.com, ravi.v.shankar@intel.com,
        linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        patches@lists.linux.dev
References: <20220708151938.986530-1-jithu.joseph@intel.com>
 <YshNAh6awfPFmxzU@kroah.com> <33a6193e-1084-ae5f-1f80-232274f71bd0@intel.com>
 <Ysqm1BRbCTtWfAcW@kroah.com>
 <79eae42f-50ca-c23c-9fd0-8c356b2d3783@redhat.com>
 <YsrZwc9P34lICS99@kroah.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <YsrZwc9P34lICS99@kroah.com>
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

Hi Greg,

On 7/10/22 15:53, Greg KH wrote:
> On Sun, Jul 10, 2022 at 03:42:29PM +0200, Hans de Goede wrote:
>> Hi,
>>
>> On 7/10/22 12:15, Greg KH wrote:
>>> On Fri, Jul 08, 2022 at 11:34:40AM -0700, Joseph, Jithu wrote:
>>>>
>>>>
>>>> On 7/8/2022 8:28 AM, Greg KH wrote:
>>>>> On Fri, Jul 08, 2022 at 08:19:38AM -0700, Jithu Joseph wrote:
>>>>>> Existing implementation limits IFS image to be loaded only from
>>>>>> a default file-name (ff-mm-ss.scan).
>>>>>>
>>>>
>>>>>
>>>>> Ick, but now what namespace are you saying that path is in?  If you need
>>>>> debugging stuff, then put the api/interface in debugfs and use it there,
>>>>> don't overload the existing sysfs api to do something different here.
>>>>
>>>> The namespace related confusion could be because, the original commit message
>>>> was not using full path-names. The below write-up tries to be more clear on this
>>>>
>>>> Existing implementation limits IFS images to be loaded only from
>>>> a default file-name /lib/firmware/intel/ifs/ff-mm-ss.scan.
>>>>
>>>> But there are situations where there may be multiple scan files
>>>> that can be run on a particular system stored in /lib/firmware/intel/ifs
>>>>
>>>> E.g.
>>>> 1. Because test contents are larger than the memory reserved for IFS by BIOS
>>>> 2. To provide increased test coverage
>>>> 3. Custom test files to debug certain specific issues in the field
>>>>
>>>> Renaming each of these to ff-mm-ss.scan and then loading might be
>>>> possible in some environments. But on systems where /lib is read-only
>>>> this is not a practical solution.
>>>>
>>>> Extend the semantics of the driver /sys/devices/virtual/misc/intel_ifs_0/reload
>>>> file:
>>>>
>>>>   Writing "1" remains the legacy behavior to load from the default
>>>>   ff-mm-ss.scan file.
>>>>
>>>>   Writing some other string is interpreted as a filename in
>>>>   /lib/firmware/intel/ifs to be loaded instead of the default file.
>>>
>>> Ick, you are overloading an existing sysfs file to do different things
>>> based on random stuff.  This is a brand-new api that you are already
>>> messing with in crazy ways.  Why not just revert the whole thing and
>>> start over as obviously this was not tested well with real devices.
>>>
>>> And what is wrong with a firmware file called '1'?  :)
>>
>> Actually the Intel IFS stuff has landed in 5.19-rc# so it is
>> a bit late(ish) for dropping it now.
> 
> We can mark it BROKEN right now before -final happens as it seems that
> the api in 5.19-rc is not correct for its users.
> 
> Perhaps we should do that now to give people the chance to get it right?

That is a good idea. I've just send out a patch doing that.

I plan to submit one last pdx86 fixes pull-req to Linus once rc6 is out
(prepping it now and want to give the builders some time to build test it).

I'll include this in this fixes pull-req.

Regards,

Hans

