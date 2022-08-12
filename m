Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23B5E5910D2
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Aug 2022 14:36:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237926AbiHLMgk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Aug 2022 08:36:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237472AbiHLMgj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Aug 2022 08:36:39 -0400
Received: from mail-vs1-xe34.google.com (mail-vs1-xe34.google.com [IPv6:2607:f8b0:4864:20::e34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CA41A0259
        for <linux-kernel@vger.kernel.org>; Fri, 12 Aug 2022 05:36:36 -0700 (PDT)
Received: by mail-vs1-xe34.google.com with SMTP id c3so648195vsc.6
        for <linux-kernel@vger.kernel.org>; Fri, 12 Aug 2022 05:36:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=O6llZjz916kr3/4GBc6iVNzZiFC/Zr060/Yj38d12js=;
        b=YGjUxVC/qz3HPVaxeDzBzYHlVqNLt6RJ5F9ItloKWXzWnnI9/MmOEAmhzytYYUehWb
         h7EpbFp8PpGO37viHcMFJCWEe0/kEcA35jUP92VQwxw2mcovAC1Y46LAKi2zQj1mHA1I
         IvSaDmF6rimwod4kWDowrskOK8Tr4pFsc/7ZRNhHs2SZskf15TaNEI+S0GBTmPRjdCPy
         8Vw8vrI/tJ2QSCzyjLl00Om78JuIB1piwLplcb95f5WAnMjDA9HJc0G1emJ1mQwdUgcC
         tot3J+MTymr9NutitLYM3WhGJgQqWoKVZSErRKMOa2KIQlNpChqxExgN4dmJcmknkAjA
         T4Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=O6llZjz916kr3/4GBc6iVNzZiFC/Zr060/Yj38d12js=;
        b=ZbP+OSJeofs5+sEcwkS9rP+oxBOt3PiiLZVqoEbUseGobL74z2uFMZ8S1MiOBcKlrX
         b7EVFfpKWxHGmokK9B6XFcpT9wUAiR7OFfnA9uArX9/h/bmSnl5a04x/nL/AJd0NyqlB
         RsNEyvAftfag9bfQhOPTD1cfDVb80rzdU3Q4+FMQ6YB14iGjbtnqnqmf9TMbDTphe++H
         jVIa+xRNHa+tWosJce4ZBUVvZumL8uomTFNcgEDMwo2xGY+yyHWXD+pZtLmpXbGU+ENa
         X/14P/9WuqmKoHqgd4Eg7Sel3ZhGUNOd1xXiVz5S5zidXvjKhlcQjgD7JbW1SVx4BR+o
         kjug==
X-Gm-Message-State: ACgBeo2rStNXuFzqCRYX+Pvj1LIPWYnvpznjt6Dd0SWl+MlghI/npxce
        XRBOTDpquPzKfpnK/2Evt7cMKcx2tctlQg==
X-Google-Smtp-Source: AA6agR55Ww9WZWxXef6+yPYU8XXvvlAQk6+qyLaJ9O19hLC6D7fIjiq4vuYXZcM+CMkJ5yZVw/HZaw==
X-Received: by 2002:a17:902:c602:b0:170:bf85:8ccb with SMTP id r2-20020a170902c60200b00170bf858ccbmr3702642plr.38.1660307784103;
        Fri, 12 Aug 2022 05:36:24 -0700 (PDT)
Received: from [10.70.253.98] ([139.177.225.246])
        by smtp.gmail.com with ESMTPSA id 125-20020a620683000000b0052d3ea78858sm1479149pfg.127.2022.08.12.05.36.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Aug 2022 05:36:23 -0700 (PDT)
Message-ID: <5ce118b3-bf3b-d9a4-004c-a5a355984b0f@bytedance.com>
Date:   Fri, 12 Aug 2022 20:36:17 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.1.0
Subject: Re: [PATCH v2 09/10] sched/psi: per-cgroup PSI stats
 disable/re-enable interface
Content-Language: en-US
To:     =?UTF-8?Q?Michal_Koutn=c3=bd?= <mkoutny@suse.com>
Cc:     hannes@cmpxchg.org, tj@kernel.org, corbet@lwn.net,
        surenb@google.com, mingo@redhat.com, peterz@infradead.org,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, cgroups@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        songmuchun@bytedance.com
References: <20220808110341.15799-1-zhouchengming@bytedance.com>
 <20220808110341.15799-10-zhouchengming@bytedance.com>
 <YvYoFNDMdg6mdFbU@blackbook>
From:   Chengming Zhou <zhouchengming@bytedance.com>
In-Reply-To: <YvYoFNDMdg6mdFbU@blackbook>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/8/12 18:14, Michal Koutný wrote:
> Hello Chengming.
> 
> On Mon, Aug 08, 2022 at 07:03:40PM +0800, Chengming Zhou <zhouchengming@bytedance.com> wrote:
>> diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/admin-guide/cgroup-v2.rst
>> index dd84e34bc051..ade40506ab80 100644
>> --- a/Documentation/admin-guide/cgroup-v2.rst
>> +++ b/Documentation/admin-guide/cgroup-v2.rst
>> @@ -968,6 +968,13 @@ All cgroup core files are prefixed with "cgroup."
>>  	killing cgroups is a process directed operation, i.e. it affects
>>  	the whole thread-group.
>>  
>> +  cgroup.psi
>> +	A read-write single value file that allowed values are "0" and "1".
>> +	The default is "1".
>> +
>> +	Writing "0" to the file will disable the cgroup PSI stats accounting.
>> +	Writing "1" to the file will re-enable the cgroup PSI stats accounting.
>> +
> 
> I'd suggest explaining here explicitely, this control attribute is not
> hierarchical (i.e. PSI accounting in a cgroup does not affect accounting
> in descendants and doesn't need pass enablement via ancestors from
> root). And the purpose that it "saves" cycles (where).

Thanks for the suggestion and explanation!

Could you help take a look if there is anything to improve?


--- a/Documentation/admin-guide/cgroup-v2.rst
+++ b/Documentation/admin-guide/cgroup-v2.rst
@@ -968,6 +968,23 @@ All cgroup core files are prefixed with "cgroup."
        killing cgroups is a process directed operation, i.e. it affects
        the whole thread-group.

+  cgroup.pressure
+       A read-write single value file that allowed values are "0" and "1".
+       The default is "1".
+
+       Writing "0" to the file will disable the cgroup PSI accounting.
+       Writing "1" to the file will re-enable the cgroup PSI accounting.
+
+       This control attribute is not hierarchical, so disable or enable PSI
+       accounting in a cgroup does not affect PSI accounting in descendants
+       and doesn't need pass enablement via ancestors from root.
+
+       The reason this control attribute exists is that PSI accounts stalls for
+       each cgroup separately and aggregates it at each level of the hierarchy.
+       This may cause non-negligible overhead for some workloads when under
+       deep level of the hierarchy, in which case this control attribute can
+       be used to disable PSI accounting in the cgroups.
+
