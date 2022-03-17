Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0F8D4DC396
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 11:05:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231892AbiCQKGs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 06:06:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232330AbiCQKGn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 06:06:43 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A0D351DC99C
        for <linux-kernel@vger.kernel.org>; Thu, 17 Mar 2022 03:05:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1647511526;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bb6fzF3Qj5vS9q9QxC5szf//8NHBymH0UA9G8kii1YQ=;
        b=FBWVB03uSuo/pp1DDrIUQ+gDl75LVZhT4hvb/5/6BWVHayTpttF8LZnh855kc2ShtxmUr4
        Shg5lv/A0ReUi7lCID7D035V9nMz7IXDj+gOYYzy6PSGPlE8JThafm1dYyjMWMSZ4DY6Rn
        /kzriyXr/z2SIDRzoh8rViyKV1WlVUI=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-70-0ZKoQcvXNOS4PFzGv69ggw-1; Thu, 17 Mar 2022 06:05:24 -0400
X-MC-Unique: 0ZKoQcvXNOS4PFzGv69ggw-1
Received: by mail-wm1-f72.google.com with SMTP id j42-20020a05600c1c2a00b00381febe402eso4084027wms.0
        for <linux-kernel@vger.kernel.org>; Thu, 17 Mar 2022 03:05:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=bb6fzF3Qj5vS9q9QxC5szf//8NHBymH0UA9G8kii1YQ=;
        b=L8BbsLD20OCLaGNbBILS6IiYi55hvlLy2/LhgB9KjOA9G8IxInvhq4osLJ/YlbBjkP
         x+8HpseZFPMCC/5dzt2Jt+EahQZriIiXlgrIgRgd5uxeKypRjAqAHBEUdGAlu2PqEDpA
         pk++gegy40JXNReuscICLtPvy6rwXAk40kXrNviFBnphtQTdKZIENMIUP78UfXp44ON9
         npJ/la3DSVcnSxdW+4dNdrnnVy2A+Kt0NdHbzUWv/A4fLzSvyfoZRx8Up5VnhGMuWPqZ
         MnQjBiHkzhx01h0IE1nTilSV9AN/kdTmvIAfmI+rglMeN2ElnnRm6ozfzFzb/CTUQJGd
         jRWQ==
X-Gm-Message-State: AOAM530aB+LdjGq032Z5zpykedVGfV9pqa3Bnq72nfSXQEMIM68SW3vK
        /C8qngr0CWhcP6ZBXt3iDAO086miKE6dbN+UFbngbpRzhepa/ocmJd3D6A6RTTKP4KYXzWyRIxc
        /wGKzgoSLt0zu0Iu5Eh+O6tJD
X-Received: by 2002:a1c:cc11:0:b0:389:e8aa:ad4b with SMTP id h17-20020a1ccc11000000b00389e8aaad4bmr3110303wmb.79.1647511523238;
        Thu, 17 Mar 2022 03:05:23 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx/avAgRCojAnT8K2071w35Qb11z9hZsLHSIfHIz2Cj64lNtJEyZ6qkqjioeTO29wi4pAjPUQ==
X-Received: by 2002:a1c:cc11:0:b0:389:e8aa:ad4b with SMTP id h17-20020a1ccc11000000b00389e8aaad4bmr3110281wmb.79.1647511522995;
        Thu, 17 Mar 2022 03:05:22 -0700 (PDT)
Received: from ?IPV6:2a09:80c0:192:0:20af:34be:985b:b6c8? ([2a09:80c0:192:0:20af:34be:985b:b6c8])
        by smtp.gmail.com with ESMTPSA id n188-20020a1ca4c5000000b00389c692a3b5sm7060814wme.42.2022.03.17.03.05.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Mar 2022 03:05:22 -0700 (PDT)
Message-ID: <987bd014-c5ab-52cb-627e-2085560cb327@redhat.com>
Date:   Thu, 17 Mar 2022 11:05:22 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Subject: Re: [PATCH] delayacct: track delays from ksm cow
Content-Language: en-US
To:     CGEL <cgel.zte@gmail.com>
Cc:     bsingharora@gmail.com, akpm@linux-foundation.org,
        yang.yang29@zte.com.cn, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
References: <20220316133420.2131707-1-yang.yang29@zte.com.cn>
 <412dc01c-8829-eac2-52c7-3f704dbb5a98@redhat.com>
 <6232970f.1c69fb81.4e365.c9f2@mx.google.com>
 <4e76476b-1da0-09c5-7dc4-0b2db796a549@redhat.com>
 <62330402.1c69fb81.d2ba6.0538@mx.google.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <62330402.1c69fb81.d2ba6.0538@mx.google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17.03.22 10:48, CGEL wrote:
> On Thu, Mar 17, 2022 at 09:17:13AM +0100, David Hildenbrand wrote:
>> On 17.03.22 03:03, CGEL wrote:
>>> On Wed, Mar 16, 2022 at 03:56:23PM +0100, David Hildenbrand wrote:
>>>> On 16.03.22 14:34, cgel.zte@gmail.com wrote:
>>>>> From: Yang Yang <yang.yang29@zte.com.cn>
>>>>>
>>>>> Delay accounting does not track the delay of ksm cow.  When tasks
>>>>> have many ksm pages, it may spend a amount of time waiting for ksm
>>>>> cow.
>>>>>
>>>>> To get the impact of tasks in ksm cow, measure the delay when ksm
>>>>> cow happens. This could help users to decide whether to user ksm
>>>>> or not.
>>>>>
>>>>> Also update tools/accounting/getdelays.c:
>>>>>
>>>>>     / # ./getdelays -dl -p 231
>>>>>     print delayacct stats ON
>>>>>     listen forever
>>>>>     PID     231
>>>>>
>>>>>     CPU             count     real total  virtual total    delay total  delay average
>>>>>                      6247     1859000000     2154070021     1674255063          0.268ms
>>>>>     IO              count    delay total  delay average
>>>>>                         0              0              0ms
>>>>>     SWAP            count    delay total  delay average
>>>>>                         0              0              0ms
>>>>>     RECLAIM         count    delay total  delay average
>>>>>                         0              0              0ms
>>>>>     THRASHING       count    delay total  delay average
>>>>>                         0              0              0ms
>>>>>     KSM             count    delay total  delay average
>>>>>                      3635      271567604              0ms
>>>>>
>>>>
>>>> TBH I'm not sure how particularly helpful this is and if we want this.
>>>>
>>> Thanks for replying.
>>>
>>> Users may use ksm by calling madvise(, , MADV_MERGEABLE) when they want
>>> save memory, it's a tradeoff by suffering delay on ksm cow. Users can
>>> get to know how much memory ksm saved by reading
>>> /sys/kernel/mm/ksm/pages_sharing, but they don't know what the costs of
>>> ksm cow delay, and this is important of some delay sensitive tasks. If
>>> users know both saved memory and ksm cow delay, they could better use
>>> madvise(, , MADV_MERGEABLE).
>>
>> But that happens after the effects, no?
>>
>> IOW a user already called madvise(, , MADV_MERGEABLE) and then gets the
>> results.
>>
> Image user are developing or porting their applications on experiment
> machine, they could takes those benchmark as feedback to adjust whether
> to use madvise(, , MADV_MERGEABLE) or it's range.

And why can't they run it with and without and observe performance using
existing metrics (or even application-specific metrics?)?


-- 
Thanks,

David / dhildenb

