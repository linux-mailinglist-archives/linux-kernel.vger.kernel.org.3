Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3662D52F0D1
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 18:38:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351709AbiETQiZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 May 2022 12:38:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351701AbiETQiS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 12:38:18 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87E8815EA56
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 09:38:15 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id ev18so8500415pjb.4
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 09:38:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=hoJZvnIpBTxSS+NvK5QFvGTIhA7+7bok5vtz0bhr51E=;
        b=i70QAriHRCuKmzqDL3P9nf1UtjVDnyiDgyTqJejByjqv/L8Kv1qoTJQXvGLfk70yvX
         Oq3Fn4ev9BUK1uwAZzvEgD4JwT4kzpzK/KOTDjiKOA4MGKhFTP998zIlGF6Q0mDo8FBc
         C5VZyhc0chgc8CkuGh/ftwdYcYIhwnIArBem+dV6nAYKmnDexobMoUrcreDmtIgqwY5n
         6kpZoGoU/Cn3ZIJtUS/GZn055YuHPA9mfo195ydq3JYInViEg2HV7BrceTXCH8FpP80r
         xgp9J//goYt1UVD3v1rooCPMmARZ5Ugzm5kOXiik8xylkkOCDax0Fcgdl7NB/oDaxPuU
         nHuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=hoJZvnIpBTxSS+NvK5QFvGTIhA7+7bok5vtz0bhr51E=;
        b=dwv9K1x2Mt+3YjtlXlIH17H2SUGmUSzN8q8zQ8ZJeniJJJ9B7pufTpfF4QfQzUTVDo
         gRxb1t14DM4QcOTY+cnhpTKh0YwU7r7t9+CbcLj0OKE1r1KLGMxGwUmXaT/ZW6atOzJz
         AOG0tYThhHEynErcRSJNTh9fjV2OqNzrFh/FCQvxmpYyMZ5HcH8SD7C3rtK0EJ/Mh6SV
         uV33/Hf1NjN8kqiAPgVDQintTv/zaTcLG88z3E1ey4x7gJTCUUyTYnviwrsUbkHGAL1R
         mpeOdUChIrm6aBldeqCj+nBZPKH2FCslxHSNF/lLbVMdiZKd9Fonz0jR1Hv9YiaYYW4C
         O5IQ==
X-Gm-Message-State: AOAM5303O1k2JdGB+8X93NLV7AL3BFUt7Hhw0IiQTXuvPawo2Jn3SWiy
        pOHvPzNnEBTVQ5y6rDtU+FPvk8+vaSUUxA==
X-Google-Smtp-Source: ABdhPJxzeHy0Jx00QELFfKUnZJ0Mg5mXTsPynx9erbgaKfJ+ckKpAhM3gTGkP0NvpYb65lyR1YbV+Q==
X-Received: by 2002:a17:902:8683:b0:161:e5a5:e388 with SMTP id g3-20020a170902868300b00161e5a5e388mr7046393plo.167.1653064694972;
        Fri, 20 May 2022 09:38:14 -0700 (PDT)
Received: from [192.168.254.17] ([50.39.160.154])
        by smtp.gmail.com with ESMTPSA id s2-20020a17090a1c0200b001dd16b86fc0sm2106194pjs.19.2022.05.20.09.38.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 May 2022 09:38:13 -0700 (PDT)
Message-ID: <489592f6-b783-7bdb-2cc8-0c8e35ebc674@linaro.org>
Date:   Fri, 20 May 2022 09:38:12 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH] cgroup: don't queue css_release_work if one already
 pending
Content-Language: en-US
To:     Tejun Heo <tj@kernel.org>
Cc:     Hillf Danton <hdanton@sina.com>, Michal Koutny <mkoutny@suse.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        syzbot+e42ae441c3b10acf9e9d@syzkaller.appspotmail.com
References: <20220412192459.227740-1-tadeusz.struk@linaro.org>
 <20220414164409.GA5404@blackbody.suse.cz> <YmHwOAdGY2Lwl+M3@slm.duckdns.org>
 <20220422100400.GA29552@blackbody.suse.cz>
 <20220519112319.2455-1-hdanton@sina.com>
 <25fb057a-077f-b601-dcb7-130071c733db@linaro.org>
 <YodNu2C5iHKW3UeZ@slm.duckdns.org>
From:   Tadeusz Struk <tadeusz.struk@linaro.org>
In-Reply-To: <YodNu2C5iHKW3UeZ@slm.duckdns.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/20/22 01:13, Tejun Heo wrote:
> On Thu, May 19, 2022 at 04:26:51PM -0700, Tadeusz Struk wrote:
>> On 5/19/22 04:23, Hillf Danton wrote:
>>> On Wed, 18 May 2022 09:48:21 -0700 Tadeusz Struk  wrote:
>>>> On 4/22/22 04:05, Michal Koutny wrote:
>>>>> On Thu, Apr 21, 2022 at 02:00:56PM -1000, Tejun Heo<tj@kernel.org>  wrote:
>>>>>> If this is the case, we need to hold an extra reference to be put by the
>>>>>> css_killed_work_fn(), right?
>>> That put could trigger INIT_WORK in css_release() and warning [1]
>>> on init active (active state 0) object OTOH as the same
>>> css->destroy_work is used in both kill and release paths.
> 
> Hmm... wouldn't the extra reference keep release from happening?
> 
>> Will this help if there would be two WQs, one for the css_release path
>> and one for the rcu_work?
>>
>> diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
>> index adb820e98f24..a4873b33e488 100644
>> --- a/kernel/cgroup/cgroup.c
>> +++ b/kernel/cgroup/cgroup.c
>> @@ -124,6 +124,7 @@ DEFINE_PERCPU_RWSEM(cgroup_threadgroup_rwsem);
>>    * which may lead to deadlock.
>>    */
>>   static struct workqueue_struct *cgroup_destroy_wq;
>> +static struct workqueue_struct *cgroup_destroy_rcu_wq;
> 
> I don't understand why this would help. Care to elaborate?

I think it will help to solve the list corruption issue:

list_add corruption. prev->next should be next (ffff8881f705c060), but was ffff888113123870. (prev=ffff888113123870).
------------[ cut here ]------------
kernel BUG at lib/list_debug.c:28!

as this is a result of enqueuing the same css->destroy_work onto the same WQ,
one on the rcu path and one on the css_release path.
I will prototype it today and test with syzbot.

-- 
Thanks,
Tadeusz
