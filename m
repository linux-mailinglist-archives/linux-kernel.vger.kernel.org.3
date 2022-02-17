Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FB844B9F4E
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 12:41:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240131AbiBQLla (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 06:41:30 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:57888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239930AbiBQLlR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 06:41:17 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D7CE524BF9
        for <linux-kernel@vger.kernel.org>; Thu, 17 Feb 2022 03:41:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1645098062;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=P/q1kZQEgMusUuWFuSa5r2nvnAdcxOG1sB0tjtALakw=;
        b=Wo+SjLvScitPZI3WJ899HJeZyiJfHUeLsgQhHoLiCI7/Q1sQSPzVvhe+QUVqDJehdKBVSu
        YatdkAO4jnmIyGpVrjG1xDIsQrPKrsra5V6hLndDU/5SWpvlrinyVbWp1wR/Ebu7kC7++6
        8R2klv0h734sam/h5nwCH0Z72SeY8oQ=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-131-pxmJzIXzO4SM0U5SVi9qew-1; Thu, 17 Feb 2022 06:40:45 -0500
X-MC-Unique: pxmJzIXzO4SM0U5SVi9qew-1
Received: by mail-ed1-f69.google.com with SMTP id f6-20020a0564021e8600b0040f662b99ffso3363719edf.7
        for <linux-kernel@vger.kernel.org>; Thu, 17 Feb 2022 03:40:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=P/q1kZQEgMusUuWFuSa5r2nvnAdcxOG1sB0tjtALakw=;
        b=xsZQWgei/IeBkJtBSgHRC/JkFjgGKh6gGbDfrfMkMYNJxs96TaRch0qr4QQ4TOziT2
         swAZoRemzWp7HI8Jl+9PUywpoMoUIlPsosWY2pJYoVyphF9QbQJ7EGBrv0wZosj1LlkJ
         SqMm4Cjnb5cSpij+XTHgxH4xS8hhZ169v/YK5tAGFX7A/YNroIGMjt9Zg6vkebbH2iF+
         +ypWcsqaMbYotUfC03mD38xd7YOreyzjzpN8JPTsrJKUc1zN8YGaqnztRJbcm7J5i5ZW
         NfKK6mOc4+8o3HuUSNWXKabqYWgbvAiWluDNrPnH4aJVK80gTDslMBUHVgpmyhzLZYAq
         ldeg==
X-Gm-Message-State: AOAM531bMunu/ZS222gBs1LJR0aNfjTwcau2vsTreW7x0SRstOuEETfv
        beUzGj6tUScaWMtyDpGIoiDX18NV4kiiOkoYdot4RtUj2CRfB1wF1TJgwjOg8Kq1oYPpfxcxNb9
        Q9zNQEeeH3UhlC1zvcZYzij5t
X-Received: by 2002:a05:6402:280d:b0:410:be87:c59d with SMTP id h13-20020a056402280d00b00410be87c59dmr2166297ede.95.1645098043653;
        Thu, 17 Feb 2022 03:40:43 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzEJPMQOF7E9N27ZyA+VdRNkLeIINC1JMuaIyOfNfnS2e55NWz2pK6KkDAIDCwVEL9yzKt+bw==
X-Received: by 2002:a05:6402:280d:b0:410:be87:c59d with SMTP id h13-20020a056402280d00b00410be87c59dmr2166282ede.95.1645098043391;
        Thu, 17 Feb 2022 03:40:43 -0800 (PST)
Received: from ?IPV6:2001:1c00:c1e:bf00:1db8:22d3:1bc9:8ca1? (2001-1c00-0c1e-bf00-1db8-22d3-1bc9-8ca1.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1db8:22d3:1bc9:8ca1])
        by smtp.gmail.com with ESMTPSA id 12sm1118106ejh.30.2022.02.17.03.40.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Feb 2022 03:40:42 -0800 (PST)
Message-ID: <52a0b719-c1ed-cfbe-ac1a-b54d53835d39@redhat.com>
Date:   Thu, 17 Feb 2022 12:40:42 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH] platform/x86: intel_scu_ipc: Keep polling IPC status if
 it reads IPC_STATUS_ERR
Content-Language: en-US
To:     "Khandelwal, Rajat" <rajat.khandelwal@intel.com>,
        "mika.westerberg@linux.intel.com" <mika.westerberg@linux.intel.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>,
        "Westerberg, Mika" <mika.westerberg@intel.com>
References: <20211230082353.2585-1-rajat.khandelwal@intel.com>
 <CO1PR11MB48359C6EC7DAC17F7FDD91D896459@CO1PR11MB4835.namprd11.prod.outlook.com>
 <e49ac79d-eca1-e404-922b-48129f8a7e54@redhat.com>
 <CO1PR11MB483572AC606C04CBD061AC0896289@CO1PR11MB4835.namprd11.prod.outlook.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <CO1PR11MB483572AC606C04CBD061AC0896289@CO1PR11MB4835.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rajat,

On 2/3/22 15:10, Khandelwal, Rajat wrote:
> Hi @Hans de Goede
> Yes, when the ERR bit is set, it still polls until timeout expires. 
> Also, IPC doesn’t clear the bit after msec as I have manually tested it and verified.
> But also, in the current implementation, it returns ETIMEDOUT even when the status reflects BUSY. This leads to developers thinking that the communication didn’t go through because timeout occurred not because the SCU was busy. We had to write manual debug prints to differentiate between these two. 
> 
> Linux 5.17 has also come. Can you drive a closure to this patch?

I'm sorry, but in its current state the patch is no good at all:

1. You never properly submitted it, as Mika already responded here:
https://lore.kernel.org/platform-driver-x86/CO1PR11MB4835D217B78F17BA6AD79F0096449@CO1PR11MB4835.namprd11.prod.outlook.com/T/

"Please run checkpatch.pl and fix all the issues it reports, and change
the $subject line to match the style in that file and then re-send."

Still I decided to try and merge it manually from your "original message"
(which I nor the archive ever received) quote:

"""
--- a/drivers/platform/x86/intel_scu_ipc.c
+++ b/drivers/platform/x86/intel_scu_ipc.c
@@ -233,17 +233,19 @@ static inline u32 ipc_data_readl(struct intel_scu_ipc_dev *scu, u32 offset)  static inline int busy_loop(struct intel_scu_ipc_dev *scu)  {
 	unsigned long end = jiffies + IPC_TIMEOUT;
+	u32 status;
 
 	do {
-		u32 status;
-
 		status = ipc_read_status(scu);
 		if (!(status & IPC_STATUS_BUSY)) {
-			return (status & IPC_STATUS_ERR) ? -EIO : 0;
+			if (!(status & IPC_STATUS_ERR))
+				return 0;
+		}
 
 		usleep_range(50, 100);
 	} while (time_before(jiffies, end));
 
+	if (status & IPC_STATUS_BUSY)
+		return -EBUSY;
+	if (status & IPC_STATUS_ERR)
+		return -EIO;
+
 	return -ETIMEDOUT;
 }
 
"""

But this actually is a corrupt unified diff. Count the number of + and - lines,
there are 17 - lines, as indicated in the chunk header, but there are 23 +
lines, where as the chunk header: "@@ -233,17 +233,19" @@ claims there are only
19. So this smells like a manually edited diff and one which was not even
test applied after editing let alone it actually being compiled
and functionally tested.

I generally dislike it when other kernel subsystem maintainers use
strong language, but I have to say that the above
(never applied as submitted, thus never tested as submitted)
is utter garbage.

Please:

1. Create a new patch which actually applies and *thoroughly* test that
before submitting the new version

2. Directly submit it to me / the mailinglist the proper way as documented:
https://www.kernel.org/doc/html/latest/process/submitting-patches.html

3. Don't you ever ever again send an untested patch for upstream
inclusion!!

Regards,

Hans




> -----Original Message-----
> From: Hans de Goede <hdegoede@redhat.com> 
> Sent: Monday, January 17, 2022 3:19 PM
> To: Khandelwal, Rajat <rajat.khandelwal@intel.com>; mika.westerberg@linux.intel.com
> Cc: linux-kernel@vger.kernel.org; platform-driver-x86@vger.kernel.org; Westerberg, Mika <mika.westerberg@intel.com>
> Subject: Re: [PATCH] platform/x86: intel_scu_ipc: Keep polling IPC status if it reads IPC_STATUS_ERR
> 
> Hi,
> 
> On 12/30/21 09:30, Khandelwal, Rajat wrote:
>> Hi Mika
>> I hope this annotation is correct? Sorry for the multiple errors! 
>>
>> -----Original Message-----
>> From: Khandelwal, Rajat <rajat.khandelwal@intel.com>
>> Sent: Thursday, December 30, 2021 1:54 PM
>> To: mika.westerberg@linux.intel.com
>> Cc: linux-kernel@vger.kernel.org; platform-driver-x86@vger.kernel.org; 
>> Khandelwal, Rajat <rajat.khandelwal@intel.com>; Westerberg, Mika 
>> <mika.westerberg@intel.com>
>> Subject: [PATCH] platform/x86: intel_scu_ipc: Keep polling IPC status 
>> if it reads IPC_STATUS_ERR
>>
>> The current implementation returns -EIO if and when IPC_STATUS_ERR is returned and returns -ETIMEDOUT even if the status is busy.
>> This patch polls the IPC status even if IPC_STATUS_ERR is returned until timeout expires and returns -EBUSY if the status shows busy.
>> Observed in multiple scenarios, trying to fetch the status of IPC after it shows ERR sometimes eradicates the ERR status.
> 
> So what this is doing is continue to poll, even though the SCU says it is ready, when the ERR bit is set ?
> 
> Are we sure the IPC does not just simply clear the err bit after some time becuse it expects it to be "consumed" within X msec after dropping busy low?
> 
> IOW what guarantees are there that this new behavior of ipc_data_readl() is not actually causing us to ignore actual errors ?
> 
> Regards,
> 
> Hans
> 
> 
> 
> 
> 
>>
>> Signed-off-by: Rajat-Khandelwal <rajat.khandelwal@intel.com>
>> ---
>>  drivers/platform/x86/intel_scu_ipc.c | 14 ++++++++++----
>>  1 file changed, 10 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/platform/x86/intel_scu_ipc.c 
>> b/drivers/platform/x86/intel_scu_ipc.c
>> index 7cc9089d1e14..1f90acaa7212 100644
>> --- a/drivers/platform/x86/intel_scu_ipc.c
>> +++ b/drivers/platform/x86/intel_scu_ipc.c
>> @@ -233,17 +233,23 @@ static inline u32 ipc_data_readl(struct intel_scu_ipc_dev *scu, u32 offset)  static inline int busy_loop(struct intel_scu_ipc_dev *scu)  {
>>  	unsigned long end = jiffies + IPC_TIMEOUT;
>> +	u32 status;
>>  
>>  	do {
>> -		u32 status;
>> -
>>  		status = ipc_read_status(scu);
>> -		if (!(status & IPC_STATUS_BUSY))
>> -			return (status & IPC_STATUS_ERR) ? -EIO : 0;
>> +		if (!(status & IPC_STATUS_BUSY)) {
>> +			if (!(status & IPC_STATUS_ERR))
>> +				return 0;
>> +		}
>>  
>>  		usleep_range(50, 100);
>>  	} while (time_before(jiffies, end));
>>  
>> +	if (status & IPC_STATUS_BUSY)
>> +		return -EBUSY;
>> +	if (status & IPC_STATUS_ERR)
>> +		return -EIO;
>> +
>>  	return -ETIMEDOUT;
>>  }
>>  
>> --
>> 2.17.1
>>
> 

