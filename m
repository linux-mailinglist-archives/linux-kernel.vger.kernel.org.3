Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE7434D5B89
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 07:19:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242260AbiCKGUD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 01:20:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234339AbiCKGUA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 01:20:00 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D4449E8682
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 22:18:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1646979536;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VmNykLNZNCecqG/aP33jF1bp4ILM+d6PRQpChl7FYR8=;
        b=aaqRI3tkONYsMliUp7XbtdrQJSkWvCmC1y00v+dskmYT92wPZuhzT4NTjoQlcxcpRXXk4v
        /IZDFSWPNc+FFBOW6EZRN7pXBH5KYULBm6RCPvSzyWjhbpMBzS6oqV2lH14UQMKiO+60Bw
        YSUSIfn9DV8YefQQvGvjffMxZw/Invk=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-376-PQBLPc4RMGSYeE0-bFWGlQ-1; Fri, 11 Mar 2022 01:18:54 -0500
X-MC-Unique: PQBLPc4RMGSYeE0-bFWGlQ-1
Received: by mail-lj1-f198.google.com with SMTP id h4-20020a2ea484000000b002480c04898aso1604447lji.6
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 22:18:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=VmNykLNZNCecqG/aP33jF1bp4ILM+d6PRQpChl7FYR8=;
        b=2fYtcslUvqcDz6FcnTO/EQX6UPej6W7KPxa6p5YlgWfLAI+dLiP2ED6+S3fHS8Gi0S
         W0sqiiCF8boocBVxs1tGYkRwHORU1burE2aylqGL/KrnpNmHP9eDRhbnsojpCkXx+z8m
         F/AsH8sU23cAlK8YAMrKt7pS+E/04q6jq7vkxC3rzafJBmPP2Ht5P/TKGBRz4vtbch7w
         1KMDDRn3/170bQe0rsjfbngDywK4leOGgd089Bs6vSkd0OnLRAREiwxk1YisUy6XCx96
         FCZW8BbtJ+Cy9fymyQ/gekTaHLjyONkxNlz9tvAsUND069YF6pDtnwrO43KsFRuul8Su
         hJnw==
X-Gm-Message-State: AOAM532HNvyQr6XMmup5G7l+/M2MUQVGQXNzFzSLyY1oKKsfCGYbTw3B
        tlVk8Zgc1CgYRj1EXsfEILpoOjkUlXEamL8osaKbmKbWdOSfc5LtvJ6MeHHGOtJaPUru05Iya/P
        0gudUqNZN+hSd1yn5IaAHyRI=
X-Received: by 2002:a2e:84cc:0:b0:247:e395:7948 with SMTP id q12-20020a2e84cc000000b00247e3957948mr5109749ljh.499.1646979533096;
        Thu, 10 Mar 2022 22:18:53 -0800 (PST)
X-Google-Smtp-Source: ABdhPJy3pZdulEss4gvvxl90sW7OTuEHg4qr/SUr/leSBxeLeAWD66PcOmH+rNEd7tWTZmxOo/LfoA==
X-Received: by 2002:a2e:84cc:0:b0:247:e395:7948 with SMTP id q12-20020a2e84cc000000b00247e3957948mr5109742ljh.499.1646979532898;
        Thu, 10 Mar 2022 22:18:52 -0800 (PST)
Received: from [192.168.1.121] (91-145-109-188.bb.dnainternet.fi. [91.145.109.188])
        by smtp.gmail.com with ESMTPSA id g1-20020a19e041000000b00443131b3efcsm1413528lfj.284.2022.03.10.22.18.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Mar 2022 22:18:52 -0800 (PST)
Message-ID: <8b9e7ef4-10b9-1061-d12f-76fd62e1ae2d@redhat.com>
Date:   Fri, 11 Mar 2022 08:18:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v2] mm/hmm/test: simplify hmm test code: use miscdevice
 instead of char dev
Content-Language: en-US
To:     John Hubbard <jhubbard@nvidia.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Cc:     apopple@nvidia.com, rcampbell@nvidia.com, jgg@ziepe.ca,
        vbabka@suse.cz
References: <20220311033050.22724-1-mpenttil@redhat.com>
 <179e3540-b9bf-5fd2-cfa4-f7274b6c33d1@nvidia.com>
From:   =?UTF-8?Q?Mika_Penttil=c3=a4?= <mpenttil@redhat.com>
In-Reply-To: <179e3540-b9bf-5fd2-cfa4-f7274b6c33d1@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11.3.2022 8.15, John Hubbard wrote:
> On 3/10/22 19:30, mpenttil@redhat.com wrote:
>> From: Mika Penttilä <mpenttil@redhat.com>
>>
>> HMM selftests use an in-kernel pseudo device to emulate device private
>> memory. The pseudo device registers a major device range for two pseudo
>> device instances. User space has a script that reads /proc/devices in
>> order to find the assigned major number, and sends that to mknod(1),
>> once for each node.
>>
>> This duplicates a fair amount of boilerplate that misc device can do
>> instead.
>>
>> Change this to use misc device, which makes the device node names appear
>> for us. This also enables udev-like processing if desired.
>>
>> Delete the /proc/devices parsing from the user-space test script, now
>> that it is unnecessary.
>>
>> v2:
>>          - Cleanups per review comments from John Hubbard
>>          - Added Tested-by and Ccs
> 
> The three lines above, starting with "v2:", belong after the "---". That
> way, they are not included in the commit log. That's the convention.
> 
> I think Andrew can fix it up for you, no need to spin a new patch for
> that.
> 
> Anyway, this looks good now, so please feel free to add:
> 
> Reviewed-by: John Hubbard <jhubbard@nvidia.com>


Thanks John!

> 
> 
> thanks,

