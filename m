Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86E4F58F947
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Aug 2022 10:43:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234613AbiHKInh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Aug 2022 04:43:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234603AbiHKInf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Aug 2022 04:43:35 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 804C890C58
        for <linux-kernel@vger.kernel.org>; Thu, 11 Aug 2022 01:43:34 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id h132so16567421pgc.10
        for <linux-kernel@vger.kernel.org>; Thu, 11 Aug 2022 01:43:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=lPWGy4oKPBEqayKpF00Kr7fLSntX8eH+HLycUNnPzWY=;
        b=TKNAY5DMmWPsUFB1Wa89v8zyOj4EVDpIP4AknSdQfHo9BqyxoEkOJgDNmzNkBQNAMG
         SZfGoH+1RdTVl1vmm+l0PoN12Mtm7fFTQkyBIGIBtS+WQ42FRRHKnNOj+C5C+TksvoAG
         wdrKZTK5/TgqdwKZDZtMiYlyhadrrmObnUKKfDNZtLu6kE+7jkp1hV+Rns1ACIOUIzeo
         CF5V+L1sWU3s88okabfa6IF7mvDqCAY+iCR+VVBhKT4D1oWSg4K+fZAmaQqd97qWalfi
         ycyPIK9oE0ZRsQH2wQkB7aBa4fT4jDn6wiPhgsVmcso9vu0BkoMG161Kd9KZTqFGd3un
         5ICg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=lPWGy4oKPBEqayKpF00Kr7fLSntX8eH+HLycUNnPzWY=;
        b=qneQvKPztHL0Fkw37WszXtAPlobzam+BsIHrjcbq/kI29vBBtyYJaukVAT116KzOZA
         GG+/ZANZO0eKWCrKdg7bvPyA72D9+om73lP1ESioaZ+3ixRfwgtUoqqf3XvHdWYHqfBI
         c5IiengFMEugho2bR/QolM5qTvvXocZkckEMLGk4f6Sf5Oidgq+mtBSZjFRpNPNewzpk
         85MBbUBKD69v3ufwi9aM3wC18i9YJoFsJ/qiHUU8PGG5oMt1gaunIPreWFQhlo1Avuqk
         iFw7ho/MY+liWV2//M0vw4gao48iIQu/TQegAfJxSZw/FpUaL5831mbV28ApgIWUKP4Z
         kMaA==
X-Gm-Message-State: ACgBeo30ouePo3nCOiHzquCX4fwvfqRfxP6QjdBSJgOBpirNbAukb5tq
        ggQfNcCSvg4cc0auK6Vg1KMklg==
X-Google-Smtp-Source: AA6agR4bUxoCD4Nwny0TXSKv5BtfxlGKcb25Zvty6m0u8Irjfklmr9/rDC1JoSk1AZGgHULBU3fFPA==
X-Received: by 2002:aa7:8d04:0:b0:52e:1778:bcde with SMTP id j4-20020aa78d04000000b0052e1778bcdemr31418527pfe.58.1660207413976;
        Thu, 11 Aug 2022 01:43:33 -0700 (PDT)
Received: from [10.94.58.189] ([139.177.225.254])
        by smtp.gmail.com with ESMTPSA id a67-20020a624d46000000b0052d8405bcd2sm3453305pfb.163.2022.08.11.01.43.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Aug 2022 01:43:33 -0700 (PDT)
Message-ID: <7ece0714-2646-4f1a-60b6-aaafc1135b1e@bytedance.com>
Date:   Thu, 11 Aug 2022 16:43:28 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.12.0
Subject: Re: [PATCH] mm/mempolicy: fix lock contention on mems_allowed
Content-Language: en-US
To:     Michal Hocko <mhocko@suse.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Mel Gorman <mgorman@techsingularity.net>,
        Muchun Song <songmuchun@bytedance.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Abel Wu <wuyun.abel@bytedance.com>
References: <20220809104927.44366-1-wuyun.abel@bytedance.com>
 <YvJO5uX0pSAh6weA@dhcp22.suse.cz>
From:   Abel Wu <wuyun.abel@bytedance.com>
In-Reply-To: <YvJO5uX0pSAh6weA@dhcp22.suse.cz>
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

On 8/9/22 8:11 PM, Michal Hocko Wrote:
> On Tue 09-08-22 18:49:27, Abel Wu wrote:
>> The mems_allowed field can be modified by other tasks, so it
>> isn't safe to access it with alloc_lock unlocked even in the
>> current process context.
> 
> It would be useful to describe the racing scenario and the effect it
> would have. 78b132e9bae9 hasn't really explained thinking behind and why
> it was considered safe to drop the lock. I assume it was based on the
> fact that the operation happens on the current task but this is hard to
> tell.
> 

Sorry for my poor description. Say there are two tasks: A from cpusetA
is performing set_mempolicy(2), and B is changing cpusetA's cpuset.mems.

     A (set_mempolicy)		B (echo xx > cpuset.mems)

     pol = mpol_new();
				update_tasks_nodemask(cpusetA) {
				  foreach t in cpusetA {
				    cpuset_change_task_nodemask(t) {
				      task_lock(t); // t could be A
     mpol_set_nodemask(pol) {
       new = f(A->mems_allowed);
				      update t->mems_allowed;
       pol.create(pol, new);
     }
				      task_unlock(t);
     task_lock(A);
     A->mempolicy = pol;
     task_unlock(A);
				    }
				  }
				}

In this case A's pol->nodes is computed by old mems_allowed, and could
be inconsistent with A's new mems_allowed.

While it is different when replacing vmas' policy: the pol->nodes is
gone wild only when current_cpuset_is_being_rebound():

     A (mbind)			B (echo xx > cpuset.mems)

				cpuset_being_rebound = cpusetA;
				update_tasks_nodemask(cpusetA) {
				  foreach t in cpusetA {
				    cpuset_change_task_nodemask(t) {
				      task_lock(t); // t could be A
     pol = mpol_new();
     mmap_write_lock(A->mm);
     mpol_set_nodemask(pol) {
       mask = f(A->mems_allowed);
				      update t->mems_allowed;
       pol.create(pol, mask);
     }
				      task_unlock(t);
				    }
     foreach v in A->mm {
       if (current_cpuset_is_being_rebound())
         pol.rebind(pol, cpuset.mems);
       v->vma_policy = pol;
     }
     mmap_write_unlock(A->mm);
				    mmap_write_lock(t->mm);
				    mpol_rebind_mm(t->mm);
				    mmap_write_unlock(t->mm);
				  }
				}
				cpuset_being_rebound = NULL;

In this case, the cpuset.mems, which has already done updating, is
finally used for calculating pol->nodes, rather than A->mems_allowed.
So it is OK to call mpol_set_nodemask() with alloc_lock unlocked when
doing mbind(2).

Best Regards,
Abel
