Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E2D44DD612
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Mar 2022 09:24:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233757AbiCRI0L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Mar 2022 04:26:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233752AbiCRI0J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Mar 2022 04:26:09 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id AFF2A85978
        for <linux-kernel@vger.kernel.org>; Fri, 18 Mar 2022 01:24:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1647591890;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vWQLy5IVfUZr3c04Id1YtbqZ9FtSqY8WSD+6zPZmxk8=;
        b=eo2hApl0p+rrHZyBLvcMSbQ9pkVluA44gJcLGedgKA2jjkNsF0w8l2OzfJfO5s51ifolrQ
        zrKjUKWxGp9xD12vmV+6yrS06HWp0W5zcJoTptJP2tswsBsA+x2x6r80B340qNa5buTZyT
        4GmL/QsEPmHM5bG7EMbVNHoyojD5M5w=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-558-BHO-P27aO0WR0lSaemx4Bw-1; Fri, 18 Mar 2022 04:24:47 -0400
X-MC-Unique: BHO-P27aO0WR0lSaemx4Bw-1
Received: by mail-wm1-f69.google.com with SMTP id c62-20020a1c3541000000b003815245c642so5448291wma.6
        for <linux-kernel@vger.kernel.org>; Fri, 18 Mar 2022 01:24:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=vWQLy5IVfUZr3c04Id1YtbqZ9FtSqY8WSD+6zPZmxk8=;
        b=2Tu5pGQpUF0szveNbZhg3kNlNHHSyGip6yp5NOzjb5qA69wMtYfwJHmgYtBzZTe+7G
         Jkm8UPMrzK6hVxsT5jgH0LQQb1SRqKHmEA1SY1ogdhEGRBJbSSiLwzyJPsn3mzMrPbyv
         xmEVzLJtdq+tOVreyd4bav+kwD628K1E9sCubyN64C51J63mSRodVYK9qG1XJEUtfxYO
         3saCqK7RTItW0BQwzg77AYir1Y3lMpVBK61sBKfXe0pKisudtnZbyLI6WUzrvEVcs9DD
         7B3dREWGvGvHZkBJtzerRqjbHxxS8+vsXtJ4v+O2Vni/JfYkXBkXUMXDQGSZBX2MaSyG
         7S4A==
X-Gm-Message-State: AOAM531m1sR14wHkO8U5y6AkpN6xjWSegb4LhOENPXBAcf3U0dhbRdZ3
        p545+kOPeDYeCvZhs5HcNHPfRSOLLrPIRlnmHokKB1HbxQL5Ex81WwZVD8RTZjWLr9MF/38VSZW
        wIBM9PVnDTn+vlvL5ete/gSVF
X-Received: by 2002:adf:cd87:0:b0:203:71f9:c333 with SMTP id q7-20020adfcd87000000b0020371f9c333mr7110953wrj.637.1647591886181;
        Fri, 18 Mar 2022 01:24:46 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzlAz62Pxp0wcCrGpcp/tyulFJ+36qaAxKyjHqN6oK+VcYWMJUFZFhI9BMDgDpasBAND2YfvA==
X-Received: by 2002:adf:cd87:0:b0:203:71f9:c333 with SMTP id q7-20020adfcd87000000b0020371f9c333mr7110940wrj.637.1647591885941;
        Fri, 18 Mar 2022 01:24:45 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f24:9200:124e:f0bf:6f8c:cbd8? (p200300d82f249200124ef0bf6f8ccbd8.dip0.t-ipconnect.de. [2003:d8:2f24:9200:124e:f0bf:6f8c:cbd8])
        by smtp.gmail.com with ESMTPSA id r186-20020a1c2bc3000000b0037bdd94a4e5sm6129710wmr.39.2022.03.18.01.24.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Mar 2022 01:24:45 -0700 (PDT)
Message-ID: <2bb1c357-5335-9d96-d862-bd51c1014193@redhat.com>
Date:   Fri, 18 Mar 2022 09:24:44 +0100
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
 <987bd014-c5ab-52cb-627e-2085560cb327@redhat.com>
 <6233e342.1c69fb81.692f.6286@mx.google.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <6233e342.1c69fb81.692f.6286@mx.google.com>
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

On 18.03.22 02:41, CGEL wrote:
> On Thu, Mar 17, 2022 at 11:05:22AM +0100, David Hildenbrand wrote:
>> On 17.03.22 10:48, CGEL wrote:
>>> On Thu, Mar 17, 2022 at 09:17:13AM +0100, David Hildenbrand wrote:
>>>> On 17.03.22 03:03, CGEL wrote:
>>>>> On Wed, Mar 16, 2022 at 03:56:23PM +0100, David Hildenbrand wrote:
>>>>>> On 16.03.22 14:34, cgel.zte@gmail.com wrote:
>>>>>>> From: Yang Yang <yang.yang29@zte.com.cn>
>>>>>>>
>>>>>>> Delay accounting does not track the delay of ksm cow.  When tasks
>>>>>>> have many ksm pages, it may spend a amount of time waiting for ksm
>>>>>>> cow.
>>>>>>>
>>>>>>> To get the impact of tasks in ksm cow, measure the delay when ksm
>>>>>>> cow happens. This could help users to decide whether to user ksm
>>>>>>> or not.
>>>>>>>
>>>>>>> Also update tools/accounting/getdelays.c:
>>>>>>>
>>>>>>>     / # ./getdelays -dl -p 231
>>>>>>>     print delayacct stats ON
>>>>>>>     listen forever
>>>>>>>     PID     231
>>>>>>>
>>>>>>>     CPU             count     real total  virtual total    delay total  delay average
>>>>>>>                      6247     1859000000     2154070021     1674255063          0.268ms
>>>>>>>     IO              count    delay total  delay average
>>>>>>>                         0              0              0ms
>>>>>>>     SWAP            count    delay total  delay average
>>>>>>>                         0              0              0ms
>>>>>>>     RECLAIM         count    delay total  delay average
>>>>>>>                         0              0              0ms
>>>>>>>     THRASHING       count    delay total  delay average
>>>>>>>                         0              0              0ms
>>>>>>>     KSM             count    delay total  delay average
>>>>>>>                      3635      271567604              0ms
>>>>>>>
>>>>>>
>>>>>> TBH I'm not sure how particularly helpful this is and if we want this.
>>>>>>
>>>>> Thanks for replying.
>>>>>
>>>>> Users may use ksm by calling madvise(, , MADV_MERGEABLE) when they want
>>>>> save memory, it's a tradeoff by suffering delay on ksm cow. Users can
>>>>> get to know how much memory ksm saved by reading
>>>>> /sys/kernel/mm/ksm/pages_sharing, but they don't know what the costs of
>>>>> ksm cow delay, and this is important of some delay sensitive tasks. If
>>>>> users know both saved memory and ksm cow delay, they could better use
>>>>> madvise(, , MADV_MERGEABLE).
>>>>
>>>> But that happens after the effects, no?
>>>>
>>>> IOW a user already called madvise(, , MADV_MERGEABLE) and then gets the
>>>> results.
>>>>
>>> Image user are developing or porting their applications on experiment
>>> machine, they could takes those benchmark as feedback to adjust whether
>>> to use madvise(, , MADV_MERGEABLE) or it's range.
>>
>> And why can't they run it with and without and observe performance using
>> existing metrics (or even application-specific metrics?)?
>>
>>
> I think the reason why we need this patch, is just like why we need                                                                                                     
> swap,reclaim,thrashing getdelay information. When system is complex,
> it's hard to precise tell which kernel activity impact the observe
> performance or application-specific metrics, preempt? cgroup throttle?
> swap? reclaim? IO?
> 
> So if we could get the factor's precise impact data, when we are tunning
> the factor(for this patch it's ksm), it's more efficient.
> 

I'm not convinced that we want to make or write-fault handler more
complicated for such a corner case with an unclear, eventual use case.
IIRC, whenever using KSM you're already agreeing to eventually pay a
performance price, and the price heavily depends on other factors in the
system. Simply looking at the number of write-faults might already give
an indication what changed with KSM being enabled.

Having that said, I'd like to hear other opinions.

-- 
Thanks,

David / dhildenb

