Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9AF454219C
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 08:44:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234268AbiFHFhx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 01:37:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234072AbiFHFhj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 01:37:39 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19ACC2FE620
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jun 2022 20:04:25 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id q12-20020a17090a304c00b001e2d4fb0eb4so22575136pjl.4
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jun 2022 20:04:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=PvefmtAni39GPQod264uoahQOPR8WfahJI2QbCjzRTM=;
        b=57hx7nQGiCeESEFjSgrPinIOOWXEsSI969rKmTYWJy1RRu6mNOSdJzZCEWF47HZNOf
         hUdV1IyWIPzMWs58oyeyoI9tWpZPSaycUQYSrFMJylSd6rjUaUSWfRiTfNEgmMmX1j5e
         2KfqSND7paBMqgGzf3fO6DHAiMHfZQjAVrnujpklKAfXA8g3uFsjdRk+mZ4CwSYKCc0g
         19ToORGsWlL8Kg0rsW9vh5kAawN+k2oL1hvJuM2vEvt58fP6CwF11b08HE5ADiRnJdlH
         3bKMiB0k6BnMqfYO54+lyh23RA0e/EUoQSdKo81wpFqmWJLYcZ/+V3lF3apSkVmr3NGM
         HdLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=PvefmtAni39GPQod264uoahQOPR8WfahJI2QbCjzRTM=;
        b=v2DeXdsCZhRgQUwE1VVvUsmmCFYvsGbrBygQTEMUayldmpBpE2FcHNByJaHnMluBEz
         /a17aKvXw0nwW41PsZ1L4uFeZ7KLz8PLQBCWR/qm7pnZBANpU95ckFnSZoRXMgwUC+GL
         BqHZWZFW3oqRq+Psqmk99LmnWQJXb6Og7wqiHH1+Og7A8jgScFfaX4beZxa1x0jeSFlG
         ZPuheMoDPV+75vK5WYR0sZZI6aQv6glGATIGC7KO3JIIov6lJ+V9NKB5gIOFePBhT2j6
         cFEBqVzU1z0icG9W7hfK8CNZZPT1RW3AlIRyz+x3yhi/reI9853BJUWr9F6rtDPQ4bBi
         gjiw==
X-Gm-Message-State: AOAM53071mz8xLMg/FSGXRn+uewHB9yp88V6xVijWTChfSa5NUgUm+Nm
        n+V0Yebuk9f5edVSN52JnbXUQQ==
X-Google-Smtp-Source: ABdhPJz5zCvKdRhKecsj4KrzcfHj3xEMg8qfrmybU37oEmekmKozELb43gNulVypovZ97PjXyArjfw==
X-Received: by 2002:a17:902:f605:b0:14d:9e11:c864 with SMTP id n5-20020a170902f60500b0014d9e11c864mr32142633plg.54.1654657465075;
        Tue, 07 Jun 2022 20:04:25 -0700 (PDT)
Received: from [10.254.59.177] ([139.177.225.254])
        by smtp.gmail.com with ESMTPSA id fs24-20020a17090af29800b001e02073474csm15085973pjb.36.2022.06.07.20.04.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Jun 2022 20:04:24 -0700 (PDT)
Message-ID: <2f60dbb0-c350-73a1-fd55-b468ec8a0707@bytedance.com>
Date:   Wed, 8 Jun 2022 11:06:45 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: Re: [PATCH] mm/memory-failure: don't allow to unpoison hw
 corrupted page
Content-Language: en-US
To:     =?UTF-8?B?SE9SSUdVQ0hJIE5BT1lBKOWggOWPoyDnm7TkuZ8p?= 
        <naoya.horiguchi@nec.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     David Hildenbrand <david@redhat.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        Wu Fengguang <fengguang.wu@intel.com>
References: <20220604103229.3378591-1-pizhenwei@bytedance.com>
 <20220604115616.b7d5912ac5a37db608f67b78@linux-foundation.org>
 <584eedd3-9369-9df1-39e2-62e331abdcc0@bytedance.com>
 <20220606043202.GA1328953@hori.linux.bs1.fc.nec.co.jp>
 <3b58adbf-a8b2-8dba-71a7-123ba3850c10@bytedance.com>
 <20220606091503.GA1337789@hori.linux.bs1.fc.nec.co.jp>
 <5e7abb3f-56e7-0343-a678-749b6f5238a2@redhat.com>
 <20220607145959.785e54c752f373bcc283732b@linux-foundation.org>
 <20220607234306.GA1400839@hori.linux.bs1.fc.nec.co.jp>
From:   zhenwei pi <pizhenwei@bytedance.com>
In-Reply-To: <20220607234306.GA1400839@hori.linux.bs1.fc.nec.co.jp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/8/22 07:43, HORIGUCHI NAOYA(堀口 直也) wrote:
> On Tue, Jun 07, 2022 at 02:59:59PM -0700, Andrew Morton wrote:
>> On Tue, 7 Jun 2022 14:36:00 +0200 David Hildenbrand <david@redhat.com> wrote:
>>
>>> On 06.06.22 11:15, HORIGUCHI NAOYA(堀口 直也) wrote:
>>>>>>     [  917.864266]  <TASK>
>>>>>>     [  917.864961]  clear_huge_page+0x147/0x270
>>>>>>     [  917.866236]  hugetlb_fault+0x440/0xad0
>>>>>>     [  917.867366]  handle_mm_fault+0x270/0x290
>>>>>>     [  917.868532]  do_user_addr_fault+0x1c3/0x680
>>>>>>     [  917.869768]  exc_page_fault+0x6c/0x160
>>>>>>     [  917.870912]  ? asm_exc_page_fault+0x8/0x30
>>>>>>     [  917.872082]  asm_exc_page_fault+0x1e/0x30
>>>>>>     [  917.873220] RIP: 0033:0x7f2aeb8ba367
>>>>>>
>>>>>> I don't think of a workaround for this now ...
>>>>>>
>>>>>
>>>>> Could you please tell me how to reproduce this issue?
>>>>
>>>> You are familiar with qemu-monitor-command, so the following procedure
>>>> should work for you:
>>>>
>>>>    - run a process using hugepages on your VM,
>>>>    - check the guest physical address of the hugepage (page-types.c is helpful for this),
>>>>    - inject a MCE with virsh qemu-monitor-command on the guest physical address, then
>>>>    - unpoison the injected physical address.
>>>
>>> That's triggered via debugfs / HWPOISON_INJECT, right?
>>>
>>> That's a DEBUG_KERNEL option, so I'm not 100% sure if we really want to
>>> cc stable.
> 
> Sure, the impact of the bug is limited.
> 
>>
>> Sure, it's hardly a must-have.  But let's also take the patch
>> complexity&risk into account.  This is one dang simple patch.
>>
>> Or is it.  Should these things be happening outside mf_mutex?  What the
>> heck is the role of mf_mutex anyway?
> 
> mf_mutex is to ensure that only one error handling thread can handle
> the pfn at one time, but set_mce_nospec() is called outside it now.
> So if we want to prevent the race with unmap, both of set_mce_nospec()
> and the new kpte check might need to be done in mf_mutex.
> 
> - Naoya Horiguchi

OK, I'll sent a v2 patch which includes:
- this change gets protected by mf_mutex
- use -EOPNOTSUPP instead of -EPERM

By the way, I assume that the similar trace(provided by Naoya) is not a 
same issue. It seems undissolved huge page with corrupted KPTE. I'm 
trying to fix it ...

-- 
zhenwei pi
