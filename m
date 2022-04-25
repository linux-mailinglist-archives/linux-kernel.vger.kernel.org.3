Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D85AB50E8FA
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 21:00:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244766AbiDYTDk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 15:03:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244759AbiDYTDh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 15:03:37 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6A3B01ADAC
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 12:00:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1650913229;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yesgUQqnGsJp5AZDU8lHq6JmWqxHleZ7ErqYUsZh9NA=;
        b=I4+sVm+YugF/usbgAp6lOaCY5wUZhPNArqOC6tBAfOn87alyuP0cbA3zC8OMfAoIy8eWxf
        rhKP/GSvS7+R+ppgGlq3IUb4E3J44sMuX4SZZW4T90XQ59yzQuwjpiFTzXRt23+RypvMNM
        yY1XWtHZIhm+b1aO0EjFe/+g+Y2ZgOw=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-134-c4weJ5qqMC2uKEebxPsUOA-1; Mon, 25 Apr 2022 15:00:28 -0400
X-MC-Unique: c4weJ5qqMC2uKEebxPsUOA-1
Received: by mail-qt1-f200.google.com with SMTP id a25-20020ac844b9000000b002f1f8988487so8484442qto.17
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 12:00:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=yesgUQqnGsJp5AZDU8lHq6JmWqxHleZ7ErqYUsZh9NA=;
        b=2eVCwwSrV0e/GnpLBH8TfQF5yGpsCpFU2TjuM870z9KOQ42NhzmDc4/w7zwkmHRx6E
         svYsJtrAaKgfqfQiO7BXF220XXUO+iV+4ZRMVJzjdno1ckLyfZXsdxRETTuWworZHNfA
         chRBzulWU5H50WmWqOTG6Ov3L+afX2SopH5V2KhjhtAz+4mo1sTIezS/rNRJqd5TbdvV
         qBi0jSrPPnKrC6TcixhGGYMEKKGTM+Q/5GRtUlv+x91RB9Xn+NvW1mY1jAPEUHU4w2Di
         spCFPwWR1KhhUkg+eZgVTxKX8XazZ5staffv643hLyx06MGng1vzFPDQfWt7OrIsAADK
         +ejA==
X-Gm-Message-State: AOAM533MAQxT67j9U6E+zAAPpEp6j/I5QR0FFiEJpEz5hfyyhga2v71q
        LvSq1nRe5aDCSXYccDHZk+dqNlUkxR8oua1pWdWHTOxlQmYQGlLqKKEy4kHYS/GlBhYpqim7G2Z
        6fF0RcSdCi+wd29M+iMYWQUg5
X-Received: by 2002:a05:620a:f03:b0:67e:1e38:3a90 with SMTP id v3-20020a05620a0f0300b0067e1e383a90mr10906171qkl.442.1650913227369;
        Mon, 25 Apr 2022 12:00:27 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJysUK0+Y5yn9Be8Tckv3kv/cNzzWDG3BSxM5NdR773RfhPy1SUZWHcctVRgFRbzM8SsxuS4Kg==
X-Received: by 2002:a05:620a:f03:b0:67e:1e38:3a90 with SMTP id v3-20020a05620a0f0300b0067e1e383a90mr10906156qkl.442.1650913227153;
        Mon, 25 Apr 2022 12:00:27 -0700 (PDT)
Received: from [192.168.138.203] (76-230-233-110.lightspeed.miamfl.sbcglobal.net. [76.230.233.110])
        by smtp.gmail.com with ESMTPSA id c136-20020a379a8e000000b0069e5df9d953sm5307449qke.34.2022.04.25.12.00.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Apr 2022 12:00:26 -0700 (PDT)
Message-ID: <19303483-5700-fb6e-ba4a-398913370100@redhat.com>
Date:   Mon, 25 Apr 2022 15:00:24 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [RFC 3/3] exit: Check for MMF_OOM_SKIP in exit_mmap
Content-Language: en-US
To:     Michal Hocko <mhocko@suse.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        David Rientjes <rientjes@google.com>,
        Andrea Arcangeli <aarcange@redhat.com>
References: <20220421190533.1601879-1-npache@redhat.com>
 <20220421190533.1601879-4-npache@redhat.com>
 <YmLMBDkHmcjf9Nem@dhcp22.suse.cz>
From:   Nico Pache <npache@redhat.com>
In-Reply-To: <YmLMBDkHmcjf9Nem@dhcp22.suse.cz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/22/22 11:38, Michal Hocko wrote:
> On Thu 21-04-22 15:05:33, Nico Pache wrote:
>> The MMF_OOM_SKIP bit is used to indicate weather a mm_struct can not be
>> invalided or has already been invalided. exit_mmap currently calls
>> __oom_reap_task_mm unconditionally despite the fact that the oom reaper
>> may have already called this.
>>
>> Add a check for the MMF_OOM_SKIP bit being set in exit_mmap to avoid
>> unnessary calls to the invalidate code.
> 
> Why do we care about this?
Is there no cost to the MMU/TLB invalidation? The MMU notifier contains a lock
too so perhaps we can also avoids some unnecessary MMU notifier lock contention.
>  
>> A slight race can occur on the MMF_OOM_SKIP bit that will still allow
>> this to run twice. My testing has shown an ~66% decrease in double calls
>> to _oom_reap_task_mm.
>>
>> Fixes: 27ae357fa82b ("mm, oom: fix concurrent munlock and oom reaper unmap, v3")
> 
> I do not see this would be fixing anything.
Ok im just trying to make sure we are keeping an eye on what introduced this
double call. Davids commit above is what introduced the oom_reap_task_mm in the
exit_mmap code. It goes along with some other changes that I dont fully
understand without more studying, so that's why I was hoping he could provide
some input around that CVE (the main thing im concerned about re-introducing).
> 
>> Cc: David Rientjes <rientjes@google.com>
>> Cc: Michal Hocko <mhocko@suse.com>
>> Cc: Andrea Arcangeli <aarcange@redhat.com>
>> Signed-off-by: Nico Pache <npache@redhat.com>
>> ---
>>  mm/mmap.c | 3 ++-
>>  1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/mm/mmap.c b/mm/mmap.c
>> index a2968669fd4e..b867f408dacd 100644
>> --- a/mm/mmap.c
>> +++ b/mm/mmap.c
>> @@ -3113,7 +3113,8 @@ void exit_mmap(struct mm_struct *mm)
>>  	/* mm's last user has gone, and its about to be pulled down */
>>  	mmu_notifier_release(mm);
>>  
>> -	if (unlikely(mm_is_oom_victim(mm))) {
>> +	if (unlikely(mm_is_oom_victim(mm)) &&
>> +			!test_bit(MMF_OOM_SKIP, &mm->flags)) {
>>  		/*
>>  		 * Manually reap the mm to free as much memory as possible.
>>  		 * Then, as the oom reaper does, set MMF_OOM_SKIP to disregard
>> -- 
>> 2.35.1
> 

