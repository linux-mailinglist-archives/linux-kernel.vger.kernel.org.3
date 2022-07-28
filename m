Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89EE4583E24
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jul 2022 13:57:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236438AbiG1L5g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jul 2022 07:57:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229648AbiG1L5e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jul 2022 07:57:34 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A234668DFB
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 04:57:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1659009451;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lXdadE5tFLQU4NSWbSKARNnxeWjymRpUklOO5iznGkM=;
        b=iRN18K7mjP9pMLasTpqTFDt4o+6p70ZzpVPpzk882KVquAB5z+hwoDMPU01zqc+DFOf5O7
        NDYrzbgsp5r8JOHDw23uacMTvtecDw2pCzSOihK//R9WKDlFvtQl3/uwSsNPwLxCsLqWp2
        AWQYQ5Z3RXGpw3YPUr5mJZdf4Yb08e8=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-609-dgA2mKRaNWOviA_y7sqHww-1; Thu, 28 Jul 2022 07:57:28 -0400
X-MC-Unique: dgA2mKRaNWOviA_y7sqHww-1
Received: by mail-ej1-f69.google.com with SMTP id gt38-20020a1709072da600b0072f21d7d12dso536683ejc.7
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 04:57:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=lXdadE5tFLQU4NSWbSKARNnxeWjymRpUklOO5iznGkM=;
        b=NiJ2bUC0whjv6yEuAFWbDHBlp3cWxqMiXfvCpU2herRHLY1JJlSwQ+zqgQhDiutIVE
         9we3D09AG2k8ohCtyB+zSn5A8N3Flb2S2saxhGiEYwt12RU1wcmWgQ5qnIun5N5yjDDF
         oKKNSAyWdJFXJpf1AXkbFJG5cX+xfCEAKjg3nW4FKANkOzgp0z44L08Q3Rih09Lp02+W
         l3+sCXTBEleiapnUDq9XE++YjwRy+TSK3FW3W5STAJaFR2ASajfQKYEBqw6Akx7335lD
         OlQmkoGrZ7BCa2HQ8igxfqdfdJ7Z2hmUM285l+WDaVM3HHFEG+yokBnzom4+2XMHToJK
         sQ4g==
X-Gm-Message-State: AJIora/xhuKqVVxaNCDgSkHRGf3jpelek0PZXspmcaCYlgFfVBD3xwoQ
        GIsnrXcuPNXWP1PSYCdpeDb87Fuy7b/P28BLR1vJ5bUe9cBD7+54x/Z6aQBrzhhQlEQZupYc2zT
        4dlpDj8lpXDcsHOEZ/kQ8YstM
X-Received: by 2002:a17:907:b590:b0:72f:90ba:bef0 with SMTP id qx16-20020a170907b59000b0072f90babef0mr20756569ejc.333.1659009447398;
        Thu, 28 Jul 2022 04:57:27 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1tuXpvxXmwR6QuCBW2oFr9VUVUTxVb5GbohLTgM1ifkzzjiPM+iEnf7FFka48eZWK+hylu/Zg==
X-Received: by 2002:a17:907:b590:b0:72f:90ba:bef0 with SMTP id qx16-20020a170907b59000b0072f90babef0mr20756550ejc.333.1659009446888;
        Thu, 28 Jul 2022 04:57:26 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c1e:bf00:d69d:5353:dba5:ee81? (2001-1c00-0c1e-bf00-d69d-5353-dba5-ee81.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:d69d:5353:dba5:ee81])
        by smtp.gmail.com with ESMTPSA id z16-20020a17090665d000b0072faba43409sm348039ejn.58.2022.07.28.04.57.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Jul 2022 04:57:26 -0700 (PDT)
Message-ID: <55368a65-c536-93c7-c501-9f6086e308d2@redhat.com>
Date:   Thu, 28 Jul 2022 13:57:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2] platform/x86/intel/ifs: Allow non-default names for
 IFS image
Content-Language: en-US
To:     Greg KH <gregkh@linuxfoundation.org>,
        Jithu Joseph <jithu.joseph@intel.com>
Cc:     markgross@kernel.org, ashok.raj@intel.com, tony.luck@intel.com,
        ravi.v.shankar@intel.com, linux-kernel@vger.kernel.org,
        platform-driver-x86@vger.kernel.org, patches@lists.linux.dev
References: <20220710160011.995800-1-jithu.joseph@intel.com>
 <YssFjbveghDLNn4N@kroah.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <YssFjbveghDLNn4N@kroah.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 7/10/22 18:59, Greg KH wrote:
> On Sun, Jul 10, 2022 at 09:00:11AM -0700, Jithu Joseph wrote:
>> Existing implementation limits IFS images to be loaded only from
>> a default file-name /lib/firmware/intel/ifs/ff-mm-ss.scan.
> 
> That was by design, why is this suddenly not acceptable?
> 
>> But there are situations where there may be multiple scan files
>> that can be run on a particular system stored in /lib/firmware/intel/ifs
> 
> Again, this was by design.
> 
>> E.g.
>> 1. Because test contents are larger than the memory reserved for IFS by BIOS
> 
> What does the BIOS have to do with this?
> 
>> 2. To provide increased test coverage
> 
> Test coverage of what?
> 
>> 3. Custom test files to debug certain specific issues in the field
> 
> Why can't you rename the existing file?
> 
>> Renaming each of these to ff-mm-ss.scan and then loading might be
>> possible in some environments. But on systems where /lib is read-only
>> this is not a practical solution.
> 
> What system puts /lib/ as read-only that you want to have loading
> hardware firmware?  That kind of defeats the security implications of
> having a read-only /lib/, right?
> 
>> Modify the semantics of the driver file
>> /sys/devices/virtual/misc/intel_ifs_0/reload such that,
>> it interprets the input as the filename to be loaded.
> 
> So you are now going to allow any file to be read from the system, in an
> unknown filesystem namespace, by this driver?

@Intel folks to me this is the big blocker which needs to be solved before
we can move forward with figuring out how to allow loading multiple
different sets of test patterns through IFS.

Which in turn is required to remove the broken marking...

How about echoing a suffix to be appended to the default filename to
the reload attribute? This suffix would then need to be sanity checked
to only contain [a-z][0-9] (we don't want '/' but it seems better to
limit this further) to avoid directory traversal attacks. 

(and echoing an empty suffix can be used to force reloading the
default test-patterns after a linux-firmware pkg upgrade)

This way we avoid the allowing user to load an arbitrary file issue.

Greg, would using a suffix appended to the default filename be
acceptable to you as a solution to solving the load arbitrary
file issue?

Also as Greg has mentioned for the next version the commit message
+ ABI docs need to a better job of explaining why support for more
then one set of test patterns per CPU model is necessary.

Since there has been no progress on this I'm going to drop this
as well as the "[PATCH 0/2] Two fixes for IFS" patch series from
my patch queue. Lets continue discussing the userspace API issue
in this thread and then once it is solved please post a v3 patch/series
addressing all the issues.

Regards,

Hans




> How wise is that?  How
> much has this been fuzzed and tested to ensure that it can not now be
> instantly abused by anyone with access to this sysfs file?
> 
> Be aware that most systems have now locked down the ability for
> userspace to pick filenames for stuff like this for good reason.  This
> feels like a step backwards from those protections.  Are you _SURE_ you
> want to do this?
> 
>> diff --git a/drivers/platform/x86/intel/ifs/ifs.h b/drivers/platform/x86/intel/ifs/ifs.h
>> index 73c8e91cf144..577cee7db86a 100644
>> --- a/drivers/platform/x86/intel/ifs/ifs.h
>> +++ b/drivers/platform/x86/intel/ifs/ifs.h
>> @@ -34,12 +34,13 @@
>>   * socket in a two step process using writes to MSRs to first load the
>>   * SHA hashes for the test. Then the tests themselves. Status MSRs provide
>>   * feedback on the success/failure of these steps. When a new test file
>> - * is installed it can be loaded by writing to the driver reload file::
>> + * is installed it can be loaded by writing the filename to the driver reload file::
>>   *
>> - *   # echo 1 > /sys/devices/virtual/misc/intel_ifs_0/reload
>> + *   # echo mytest > /sys/devices/virtual/misc/intel_ifs_0/reload
>>   *
>> - * Similar to microcode, the current version of the scan tests is stored
>> - * in a fixed location: /lib/firmware/intel/ifs.0/family-model-stepping.scan
>> + * The file will be loaded from /lib/firmware/intel/ifs/mytest
>> + * The default file /lib/firmware/intel/ifs/family-model-stepping.scan
>> + * will be loaded during module insertion.
> 
> So you have a default directory, what happened to your read-only /lib/ ?
> 
> This also does not properly document what the kernel code does.
> 
> {sigh}
> 
> Please do not rush this, it's not acceptable as-is at all.
> 
>> --- a/Documentation/ABI/testing/sysfs-platform-intel-ifs
>> +++ b/Documentation/ABI/testing/sysfs-platform-intel-ifs
>> @@ -35,5 +35,4 @@ What:		/sys/devices/virtual/misc/intel_ifs_<N>/reload
>>  Date:		April 21 2022
>>  KernelVersion:	5.19
>>  Contact:	"Jithu Joseph" <jithu.joseph@intel.com>
>> -Description:	Write "1" (or "y" or "Y") to reload the IFS image from
>> -		/lib/firmware/intel/ifs/ff-mm-ss.scan.
>> +Description:	Write <file_name> to reload the IFS image from /lib/firmware/intel/<file_name>.
> 
> "reload" should not be for specifying the filename, please use a sane
> interface instead of this overloading logic.
> 
> greg k-h
> 

