Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 953144F130B
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Apr 2022 12:22:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357150AbiDDKXx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 06:23:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244989AbiDDKXt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 06:23:49 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9A3A73CA4A
        for <linux-kernel@vger.kernel.org>; Mon,  4 Apr 2022 03:21:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649067712;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NrIiVtW7zL/EZbvvEh1ijtvz57/RGSqRlI7BljZYLs4=;
        b=LUre/Wm6NpHO0CNcnHZIqvT9odDlWkBu8bui54by19DMqAwNmmC1KnUwcW/A/ENslPfPLy
        gNS5eKxW4GjCmk/P4OLIbbDT58C42aVGuovQdBz0RyJ/to57xlxHmUMHzQa4+1Xg/11/n0
        /awA19XZLDuTg/7xDISvxL2a5I+G8DQ=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-606-kJFZ-wUfOpe9AnRDQb-wKg-1; Mon, 04 Apr 2022 06:21:51 -0400
X-MC-Unique: kJFZ-wUfOpe9AnRDQb-wKg-1
Received: by mail-ej1-f69.google.com with SMTP id sg13-20020a170907a40d00b006e7e8234ae2so1152629ejc.2
        for <linux-kernel@vger.kernel.org>; Mon, 04 Apr 2022 03:21:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=NrIiVtW7zL/EZbvvEh1ijtvz57/RGSqRlI7BljZYLs4=;
        b=5N7GfW+IcH3I/0wFRkVWiEltoNIUs/a0go1lAmTNZamb5wvzxIOnVVcG0wcXaT/gpG
         HSle4a/Rjh3e0kTIESZxgc60+sKPeT3uSiivpKtPlget21IstPb7UI0DS+sog517ITcB
         L/l801PO1yOH90pv5ddzNjOcCxo6rYeUF8b4t356IGZUKRiOFNN5C0VUA8pHd15Ro3oM
         dxz5LMMziz8r2v7HZdoDuMWJzOUsHSDEuwxk/Q8IAZXzSkH+SbJ1aU3LoVqg9YMtQis/
         GvYpx/nbVMYLCwvsOVDhKNEFF4h+CXxY5U2R+L07zTMMtjJTYH/Ofh2TfzRe3p8+rjzn
         RYvA==
X-Gm-Message-State: AOAM533zEx9KTSuWqWjlYjwlP2Tp39hz+ZJA9o6mXFzCMZg9LXvIrlug
        uU53FH1fT6QuFNLsT/n6ZGlpuKWD3vkIyT/pfcsBiIaxgN3Nm15KUb/xze8uuRV8Nb5kiXd/1Rd
        Qwo+ax5Mc+TA6dvY5jCKK8Np6
X-Received: by 2002:a17:906:a398:b0:6ce:71b:deff with SMTP id k24-20020a170906a39800b006ce071bdeffmr9828061ejz.204.1649067710282;
        Mon, 04 Apr 2022 03:21:50 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx3m+Zd29+/ftz6u00cEYEm1e5sEaOZfUaNREapxyh+NMbkZdJaoKQ+wjSusHi4JcoWwaYbYw==
X-Received: by 2002:a17:906:a398:b0:6ce:71b:deff with SMTP id k24-20020a170906a39800b006ce071bdeffmr9828042ejz.204.1649067710100;
        Mon, 04 Apr 2022 03:21:50 -0700 (PDT)
Received: from [10.40.98.142] ([78.108.130.194])
        by smtp.gmail.com with ESMTPSA id bj13-20020a170906b04d00b006e742719b9fsm2200534ejb.7.2022.04.04.03.21.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Apr 2022 03:21:49 -0700 (PDT)
Message-ID: <98b58912-d0fe-0e4d-ef6e-3396840a1e4a@redhat.com>
Date:   Mon, 4 Apr 2022 12:21:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH] platform/x86/dell: add buffer allocation/free functions
 for SMI calls
Content-Language: en-US
To:     David Laight <David.Laight@ACULAB.COM>,
        'Juergen Gross' <jgross@suse.com>,
        "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>,
        "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Dell.Client.Kernel@dell.com" <Dell.Client.Kernel@dell.com>
Cc:     Stuart Hayes <stuart.w.hayes@gmail.com>,
        Mark Gross <markgross@kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
References: <20220318150950.16843-1-jgross@suse.com>
 <accf95548a8c4374b17c159b9b2d0098@AcuMS.aculab.com>
 <2a4573e0-4a8d-52c1-d29b-66b13bfe376f@suse.com>
 <f04348c83155404c8ae4c8e5c3abedf2@AcuMS.aculab.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <f04348c83155404c8ae4c8e5c3abedf2@AcuMS.aculab.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 3/18/22 23:28, David Laight wrote:
> From: Juergen Gross
>> Sent: 18 March 2022 16:56
>>
>> On 18.03.22 16:22, David Laight wrote:
>>> From: Juergen Gross
>>>> Sent: 18 March 2022 15:10
>>>>
>>>> The dcdbas driver is used to call SMI handlers for both, dcdbas and
>>>> dell-smbios-smm. Both drivers allocate a buffer for communicating
>>>> with the SMI handler. The physical buffer address is then passed to
>>>> the called SMI handler via %ebx.
>>>>
>>>> Unfortunately this doesn't work when running in Xen dom0, as the
>>>> physical address obtained via virt_to_phys() is only a guest physical
>>>> address, and not a machine physical address as needed by SMI.
>>>
>>> The physical address from virt_to_phy() is always wrong.
>>> That is the physical address the cpu has for the memory.
>>> What you want is the address the dma master interface needs to use.
>>> That can be different for a physical system - no need for virtualisation.
>>>
>>> On x86 they do usually match, but anything with a full iommu
>>> will need completely different addresses.
>>
>> Yes, thanks for reminding me of that.
>>
>> The SMI handler is running on the cpu, right? So using the DMA
>> address is wrong in case of an IOMMU. I really need the machine
>> physical address.
> 
> That ought to be handled by the 'dev' parameter to dma_alloc_coherent().
> 
> 	David

I must admit that I'm not too familiar with all the intricate details
of the DMA API here.

So does this mean that the patch in its original form is good as is
and should be merged?

An Acked-by or Reviewed-by from someone more familiar with the DMA
APIs would be helpful.

Regards,

Hans

