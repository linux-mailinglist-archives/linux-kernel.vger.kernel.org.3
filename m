Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C1585604C1
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 17:38:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233306AbiF2PgR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 11:36:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230143AbiF2PgP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 11:36:15 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E3EAB2FFD7
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jun 2022 08:36:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1656516974;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4pj/8p7fgK4lTupGVDg+wJNdzSOiI/nyYThsV/e8tXc=;
        b=GpYFIehO/V7btvE5dgbiHWRQryAZFvh5poNkzJFKW85CaShXTDJv9skIdBUguegVvhV5o4
        Z4qLz2BJekhMq6SH6GDacncNWdgQhbu7USFlFOBQubK7pvgLcJHZS+XHXhaSlnC6qzuH3N
        w9QKfZyyx0FT+B1Dg0Glepjpbm+lKOI=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-632-9QNWTMxJNseIskTjWu5uLA-1; Wed, 29 Jun 2022 11:36:12 -0400
X-MC-Unique: 9QNWTMxJNseIskTjWu5uLA-1
Received: by mail-ed1-f72.google.com with SMTP id n8-20020a05640205c800b00434fb0c150cso12091741edx.19
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jun 2022 08:36:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=4pj/8p7fgK4lTupGVDg+wJNdzSOiI/nyYThsV/e8tXc=;
        b=C3KR6k9+Zgdm8nZY5W1l4X063Rl2t8uWR8JymwgtoXV/wKtsVIiUN5KYhoszAVagmY
         yiFgdn3R32W/nfhYznjPnIo3lcnxgYGGmG6spwPP9CdcwYLYCii5YXbjbuwbNo1GAADk
         YRM2GlgvWcKJSv5VPUT/wiDL+hPA0WfzFNp80nfyNjICNGo2BE25pa6wYjhhocSuLP9V
         C4sRShs4y8A19GQG03grSmeJOJWwmY/ukNbs4UvL7NJgzgKmZBcvp7oranGh18JNzbbe
         CBosXiH+O1hjxHi5bRgd6pfo0aFqQcpfC65yfdBc3ITHJM3I6zHFs1UzRDlhQYfBuf36
         RuTQ==
X-Gm-Message-State: AJIora8T3wIlpB097XON98fBKYdNmUN1gD6EYUPeVddYXHLB5Lxwtv9b
        frMq+Y+bdvDp+fCaeypAqRrGkFiD8OnWuemCTnqdznbGbeh9ZGWnWz6QjbQJ2/9LnnTYUslbBEp
        J2pwG4a9Go2vfOP41A93QQIHi
X-Received: by 2002:aa7:c45a:0:b0:435:d7a4:99bc with SMTP id n26-20020aa7c45a000000b00435d7a499bcmr5030777edr.158.1656516971482;
        Wed, 29 Jun 2022 08:36:11 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1t/v9UQlBl4i2a4w5Iybhw3R6rX2lNYMW4pO5v+9H3djpiafrTaNjXtP2eGQidNugISi77qLg==
X-Received: by 2002:aa7:c45a:0:b0:435:d7a4:99bc with SMTP id n26-20020aa7c45a000000b00435d7a499bcmr5030767edr.158.1656516971331;
        Wed, 29 Jun 2022 08:36:11 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c1e:bf00:d69d:5353:dba5:ee81? (2001-1c00-0c1e-bf00-d69d-5353-dba5-ee81.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:d69d:5353:dba5:ee81])
        by smtp.gmail.com with ESMTPSA id y1-20020aa7c241000000b004355dc75066sm11439503edo.86.2022.06.29.08.36.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Jun 2022 08:36:10 -0700 (PDT)
Message-ID: <d0e8a984-52f4-75e7-93a7-b498af4c859e@redhat.com>
Date:   Wed, 29 Jun 2022 17:36:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH] platform/x86: ISST: PUNIT device mapping with Sub-NUMA
 clustering
Content-Language: en-US
To:     srinivas pandruvada <srinivas.pandruvada@linux.intel.com>,
        markgross@kernel.org
Cc:     platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220627215031.2158825-1-srinivas.pandruvada@linux.intel.com>
 <55a6470c-1ce5-b237-d3be-1b98e4dbe3ce@redhat.com>
 <4fa1d4befe5de6d402aeb72ec1ae9953789da3ec.camel@linux.intel.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <4fa1d4befe5de6d402aeb72ec1ae9953789da3ec.camel@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 6/29/22 16:14, srinivas pandruvada wrote:
> Hi Hans,
> 
> Thanks for the review.
> 
> On Wed, 2022-06-29 at 12:00 +0200, Hans de Goede wrote:
>> Hi,
>>
>> On 6/27/22 23:50, Srinivas Pandruvada wrote:
>>>
> [...]
> 
>>>  
>>> +struct isst_if_pkg_info {
>>> +       struct pci_dev *pci_dev[2];
>>
>> This and (continued below) ...
>>
> Didn't understand the comment.

What I was trying to say here is that this is all
one long comment (continued further down/below
in the email) about checking the bounds
of this array.

> 
>>> +};
>>> +
>>>  static struct isst_if_cpu_info *isst_cpu_info;
>>> +static struct isst_if_pkg_info *isst_pkg_info;
>>> +
>>>  #define ISST_MAX_PCI_DOMAINS   8
>>>  
>>>  static struct pci_dev *_isst_if_get_pci_dev(int cpu, int bus_no,
>>> int dev, int fn)
>>>  {
>>> +       int pkg_id = topology_physical_package_id(cpu);
>>>         struct pci_dev *matched_pci_dev = NULL;
>>>         struct pci_dev *pci_dev = NULL;
>>>         int no_matches = 0;
>>> @@ -324,6 +331,8 @@ static struct pci_dev *_isst_if_get_pci_dev(int
>>> cpu, int bus_no, int dev, int fn
>>>                 }
>>>  
>>>                 if (node == isst_cpu_info[cpu].numa_node) {
>>> +                       isst_pkg_info[pkg_id].pci_dev[bus_no] =
>>> _pci_dev;
>>> +
>>
>> This and ...
>>
> Please explain the comment.

Idem.


> 
>>>                         pci_dev = _pci_dev;
>>>                         break;
>>>                 }
>>> @@ -342,6 +351,9 @@ static struct pci_dev *_isst_if_get_pci_dev(int
>>> cpu, int bus_no, int dev, int fn
>>>         if (!pci_dev && no_matches == 1)
>>>                 pci_dev = matched_pci_dev;
>>>  
>>> +       if (!pci_dev)
>>> +               pci_dev = isst_pkg_info[pkg_id].pci_dev[bus_no];
>>> +
>>
>> This assumes that bus_no is never > 1, is this assumption enforced
>> somewhere?
>>
> Yes. That is checked at the beginning of function
>    if (bus_no < 0 || bus_no > 1 || cpu < 0 || cpu >= nr_cpu_ids ||
>             cpu >= num_possible_cpus())
> 	 return NULL;

Ah, good.

>> Also maybe make the 2 in:
>>
>>> +struct isst_if_pkg_info {
>>> +       struct pci_dev *pci_dev[2];
>>
>> a #define ?
> I will.

Great; then also please update the "bus_no > 1" in the bounds check
to use this define.

Regards,

Hans



> 
> Thanks,
> Srinivas
> 
>>
>> Regards,
>>
>> Hans
>>
>>
>>>         return pci_dev;
>>>  }
>>>  
>>> @@ -417,10 +429,19 @@ static int isst_if_cpu_info_init(void)
>>>         if (!isst_cpu_info)
>>>                 return -ENOMEM;
>>>  
>>> +       isst_pkg_info = kcalloc(topology_max_packages(),
>>> +                               sizeof(*isst_pkg_info),
>>> +                               GFP_KERNEL);
>>> +       if (!isst_pkg_info) {
>>> +               kfree(isst_cpu_info);
>>> +               return -ENOMEM;
>>> +       }
>>> +
>>>         ret = cpuhp_setup_state(CPUHP_AP_ONLINE_DYN,
>>>                                 "platform/x86/isst-if:online",
>>>                                 isst_if_cpu_online, NULL);
>>>         if (ret < 0) {
>>> +               kfree(isst_pkg_info);
>>>                 kfree(isst_cpu_info);
>>>                 return ret;
>>>         }
>>> @@ -433,6 +454,7 @@ static int isst_if_cpu_info_init(void)
>>>  static void isst_if_cpu_info_exit(void)
>>>  {
>>>         cpuhp_remove_state(isst_if_online_id);
>>> +       kfree(isst_pkg_info);
>>>         kfree(isst_cpu_info);
>>>  };
>>>  
>>
> 

