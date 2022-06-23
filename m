Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F215455711B
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 04:36:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231694AbiFWCg1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 22:36:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229615AbiFWCgZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 22:36:25 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF7C43BF91
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 19:36:24 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id d5so16936794plo.12
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 19:36:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=ap/l5/DtRvj53V2CP02OCV8Y9yv6B47W9rFtmSDPxls=;
        b=FpOyHo8x4jGy05YG6pNB+UTP0d2tDbI8uK8nVnAfyLYHadT0jVXhh164JY6S+Y4Ets
         StuLbjcpbIXgQfPPKNHjHdrFuZxp/1vsrAwNf+MIRPoxcw2kOtZI+0qyHYG4PtWf4EGZ
         4YX3AIDmZ0EnsgevwSnayUEl1nJyIOGwjXbMlMLWZ8+We04oQ2oKyh0YzlwFBT2uW/5m
         sW28f3aZPh+rREYYdhaXmB1yj66IS6Pe9Nx5ez8jz2nMgKIo8SrdNIPH5bvcUB5LURHZ
         klTqDnqyx8w+fAKTMzbI11ocnkMFpG+Hji/l7D7R1aVizV0BooQ27c5D+vlP5GNpleON
         NAIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=ap/l5/DtRvj53V2CP02OCV8Y9yv6B47W9rFtmSDPxls=;
        b=VfWfIHoW5QJH91XQBh1OlHy4W3Kww4Mo3zKq2WOMImKN3kn8Ovpn+Ag1lhsdA0+Jbl
         OPjMjGG4Minqj1Onti9J/7jsRNQIXuBxIaeskmGBsOMvGzmo+2slbyjgbIOLerrKVU4U
         QZH9s58zBf1suNjRe/3MkfTrGo5YE9gm10M2yNTTxe+Zntfr6CqJyjZZsY9H1o1H+43L
         YahNRPGmavuc5EDDsezVKYQ+l8Qfc3WDWbkrmPWVA8qfRJCXBBNkhhoQccYrGw1AO0Ad
         IperJ9SpDcN8d5OnT2EsRpbGvy4trYRYSYPcU0FfPQP7rqR/BtptxmnHupu70e7bWhXO
         ImDA==
X-Gm-Message-State: AJIora/X3xrdxr1+bzx2b23x9xiXA3fddzaseXWeWoZO2oFvbEtS/42I
        mz+kf/lgvwomH01yai1ofuFhuw==
X-Google-Smtp-Source: AGRyM1vpifYz050GyEzWzRjhQy8/6B2veXLZvJ6SBiX5HXPWJbx+e9VN+j5wuu1AX6XUoLZCOJnVtA==
X-Received: by 2002:a17:902:f60d:b0:16a:1a7f:a22f with SMTP id n13-20020a170902f60d00b0016a1a7fa22fmr21280279plg.13.1655951784244;
        Wed, 22 Jun 2022 19:36:24 -0700 (PDT)
Received: from [10.4.214.173] ([139.177.225.237])
        by smtp.gmail.com with ESMTPSA id a13-20020a1709027e4d00b0015e8d4eb26csm13583831pln.182.2022.06.22.19.36.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Jun 2022 19:36:23 -0700 (PDT)
Message-ID: <2d607f47-71fa-9505-b355-7203eb327bab@bytedance.com>
Date:   Thu, 23 Jun 2022 10:36:10 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.10.0
Subject: Re: [PATCH v12 12/14] mm: multi-gen LRU: debugfs interface
Content-Language: en-US
To:     Yu Zhao <yuzhao@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Andi Kleen <ak@linux.intel.com>,
        Aneesh Kumar <aneesh.kumar@linux.ibm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Hillf Danton <hdanton@sina.com>, Jens Axboe <axboe@kernel.dk>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Mel Gorman <mgorman@suse.de>,
        Michael Larabel <Michael@michaellarabel.com>,
        Michal Hocko <mhocko@kernel.org>,
        Mike Rapoport <rppt@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Tejun Heo <tj@kernel.org>, Vlastimil Babka <vbabka@suse.cz>,
        Will Deacon <will@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        Kernel Page Reclaim v2 <page-reclaim@google.com>,
        Brian Geffon <bgeffon@google.com>,
        Jan Alexander Steffens <heftig@archlinux.org>,
        Oleksandr Natalenko <oleksandr@natalenko.name>,
        Steven Barrett <steven@liquorix.net>,
        Suleiman Souhlal <suleiman@google.com>,
        Daniel Byrne <djbyrne@mtu.edu>,
        Donald Carr <d@chaos-reins.com>,
        =?UTF-8?Q?Holger_Hoffst=c3=a4tte?= <holger@applied-asynchrony.com>,
        Konstantin Kharlamov <Hi-Angel@yandex.ru>,
        Shuang Zhai <szhai2@cs.rochester.edu>,
        Sofia Trinh <sofia.trinh@edi.works>,
        Vaibhav Jain <vaibhav@linux.ibm.com>
References: <20220614071650.206064-1-yuzhao@google.com>
 <20220614071650.206064-13-yuzhao@google.com>
 <214db251-827c-715c-54cf-9c0e9bb5fe30@bytedance.com>
 <CAOUHufZ8xaVKZD7LNeo8AZv_xywvwef4P8CjdO+npijLHEUfWg@mail.gmail.com>
From:   Qi Zheng <zhengqi.arch@bytedance.com>
In-Reply-To: <CAOUHufZ8xaVKZD7LNeo8AZv_xywvwef4P8CjdO+npijLHEUfWg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2022/6/23 03:13, Yu Zhao wrote:
> On Wed, Jun 22, 2022 at 3:16 AM Qi Zheng <zhengqi.arch@bytedance.com> wrote:
> 
>>> +static ssize_t lru_gen_seq_write(struct file *file, const char __user *src,
>>> +                              size_t len, loff_t *pos)
>>> +{
>>> +     void *buf;
>>> +     char *cur, *next;
>>> +     unsigned int flags;
>>> +     struct blk_plug plug;
>>> +     int err = -EINVAL;
>>> +     struct scan_control sc = {
>>> +             .may_writepage = true,
>>> +             .may_unmap = true,
>>> +             .may_swap = true,
>>> +             .reclaim_idx = MAX_NR_ZONES - 1,
>>> +             .gfp_mask = GFP_KERNEL,
>>> +     };
>>> +
>>> +     buf = kvmalloc(len + 1, GFP_KERNEL);
>>> +     if (!buf)
>>> +             return -ENOMEM;
>>> +
>>> +     if (copy_from_user(buf, src, len)) {
>>> +             kvfree(buf);
>>> +             return -EFAULT;
>>> +     }
>>> +
>>> +     if (!set_mm_walk(NULL)) {
>>
>> The current->reclaim_state will be dereferenced in set_mm_walk(), so
>> calling set_mm_walk() before set_task_reclaim_state(current,
>> &sc.reclaim_state) will cause panic:
>>
>> [ 1861.154916] BUG: kernel NULL pointer dereference, address:
>> 0000000000000008
> 
> Thanks.
> 
> Apparently I shot myself in the foot by one of the nits between v11 and v12.
> 
>>> +             kvfree(buf);
>>> +             return -ENOMEM;
>>> +     }
>>> +
>>> +     set_task_reclaim_state(current, &sc.reclaim_state);
>>> +     flags = memalloc_noreclaim_save();
>>> +     blk_start_plug(&plug);
>>> +
>>> +     next = buf;
>>> +     next[len] = '\0';
>>> +
>>> +     while ((cur = strsep(&next, ",;\n"))) {
>>> +             int n;
>>> +             int end;
>>> +             char cmd;
>>> +             unsigned int memcg_id;
>>> +             unsigned int nid;
>>> +             unsigned long seq;
>>> +             unsigned int swappiness = -1;
>>> +             unsigned long opt = -1;
>>> +
>>> +             cur = skip_spaces(cur);
>>> +             if (!*cur)
>>> +                     continue;
>>> +
>>> +             n = sscanf(cur, "%c %u %u %lu %n %u %n %lu %n", &cmd, &memcg_id, &nid,
>>> +                        &seq, &end, &swappiness, &end, &opt, &end);
>>> +             if (n < 4 || cur[end]) {
>>> +                     err = -EINVAL;
>>> +                     break;
>>> +             }
>>> +
>>> +             err = run_cmd(cmd, memcg_id, nid, seq, &sc, swappiness, opt);
>>> +             if (err)
>>> +                     break;
>>> +     }
>>> +
>>> +     blk_finish_plug(&plug);
>>> +     memalloc_noreclaim_restore(flags);
>>> +     set_task_reclaim_state(current, NULL);
>>> +
>>> +     clear_mm_walk();
>>
>> Ditto, we can't call clear_mm_walk() after
>> set_task_reclaim_state(current, NULL).
>>
>> Maybe it can be modified as follows:
>>
>> diff --git a/mm/vmscan.c b/mm/vmscan.c
>> index 2422edc786eb..552e6ae5243e 100644
>> --- a/mm/vmscan.c
>> +++ b/mm/vmscan.c
>> @@ -5569,12 +5569,12 @@ static ssize_t lru_gen_seq_write(struct file
>> *file, const char __user *src,
>>                   return -EFAULT;
>>           }
>>
>> +       set_task_reclaim_state(current, &sc.reclaim_state);
>>           if (!set_mm_walk(NULL)) {
>>                   kvfree(buf);
>>                   return -ENOMEM;
>>           }
>>
>> -       set_task_reclaim_state(current, &sc.reclaim_state);
> 
> We need a `goto` because otherwise we leave a dangling

Yes, right. With this:

Reviewed-by: Qi Zheng <zhengqi.arch@bytedance.com>

> `current->reclaim_state`. (I swear I had one.)

(I believe :))

-- 
Thanks,
Qi
