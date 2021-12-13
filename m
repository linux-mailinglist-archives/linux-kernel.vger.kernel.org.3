Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E67547213A
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 07:51:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232292AbhLMGvN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 01:51:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232268AbhLMGvM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 01:51:12 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 701E3C061751
        for <linux-kernel@vger.kernel.org>; Sun, 12 Dec 2021 22:51:12 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id gx15-20020a17090b124f00b001a695f3734aso12566676pjb.0
        for <linux-kernel@vger.kernel.org>; Sun, 12 Dec 2021 22:51:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=yMpVC2kpu7YFJ/s6LMhrkQcovk/km/8dHffArUV16q0=;
        b=oPGvhlBLdePFU+vncJhdgAZjBfHeKjhh6MPusmJt+0IB/EJccsFj7zrhUb/Aja+8Zz
         EszcTrfoJLa3TkwV8b+m0u+uOSZh79kVe/lc0vRwoEmRxqeQc4LorXEj7MwmhlPWRUQV
         wIYmWdM/3KTBHocPo0OIzgJ4W/M8jnPKjv+jP+MhKhx9t/mh/A2eH3fZbu96x9o5hREI
         pN2I4c3T/6fYUR2OLSIQaCu9RYxzGOd5rTsYKT+8dnpHQzFFMf3cTp8qq4FyA8z0DjuR
         aid1hpYFQBEWppb66PdvAZ1aJ50d23ValXXxDqMUkJtNDsh5pu6Xwli1somJSt5nQGgv
         zdbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=yMpVC2kpu7YFJ/s6LMhrkQcovk/km/8dHffArUV16q0=;
        b=JeycPOaqU7J8Uo866Z/bnBanVTMVI9R4WgFvRLn40RccQPV37W2tzoyknYeBzXIqf2
         SFn5JcbaTjwwYp3TMpjdezbAJfiBeqrj12tQBAqELYtQgkf6F4gk+tp9rNxW9UvSwmBB
         KF5QnL7sCMqNz9QmoQBmLIlubTcAulmJKn2zAZn/elyQEZjGyELqaBFy6UpTALc2OBW9
         d8tzPcGNNIc+bTM6p4Ujyz4RWVPWxBNKwJxJ9aiIdpUZwzfgAgsEHKWXF+gqlqrZXMVi
         mCNjxLQ6tGhk6RvsIT+FN4pRhhVjI2eiTwqrendG+TPRH4c5QKrU6z7cRVUNlkMWf7+6
         mNXg==
X-Gm-Message-State: AOAM530t/Q/NF7H/pfhHZjYjemcBRGaPl94cXxgx2kKhs3Fs262CyWP4
        nJC+kKyPjEtrdSJRDdtKfhF7Iw==
X-Google-Smtp-Source: ABdhPJw6Ii106D5I9zYxT/oqiqsbsiSwsVIAzMOg3NbCSBjxDSmPtMPSzECMrPXJQBkaBymf7eS8uQ==
X-Received: by 2002:a17:90b:3508:: with SMTP id ls8mr42473847pjb.51.1639378271977;
        Sun, 12 Dec 2021 22:51:11 -0800 (PST)
Received: from [10.76.43.192] ([61.120.150.76])
        by smtp.gmail.com with ESMTPSA id f10sm5904851pjm.52.2021.12.12.22.51.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 12 Dec 2021 22:51:11 -0800 (PST)
Message-ID: <15bbfed1-5b7c-e6ff-07e9-9de3a0ee4728@bytedance.com>
Date:   Mon, 13 Dec 2021 14:49:48 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.4.0
Subject: Re: [PATCH v3] sched/numa: add per-process numa_balancing
Content-Language: en-US
To:     Jonathan Corbet <corbet@lwn.net>, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>
Cc:     linux-api@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org
References: <20211206024530.11336-1-ligang.bdlg@bytedance.com>
From:   Gang Li <ligang.bdlg@bytedance.com>
In-Reply-To: <20211206024530.11336-1-ligang.bdlg@bytedance.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
Any comments plz ;)

On 2021/12/6 10:45, Gang Li wrote:
> This patch add a new api PR_NUMA_BALANCING in prctl.
> 
> A large number of page faults will cause performance loss when numa
> balancing is performing. Thus those processes which care about worst-case
> performance need numa balancing disabled. Others, on the contrary, allow a
> temporary performance loss in exchange for higher average performance, so
> enable numa balancing is better for them.
> 
> Numa balancing can only be controlled globally by
> /proc/sys/kernel/numa_balancing. Due to the above case, we want to
> disable/enable numa_balancing per-process instead.
> 
> Add numa_balancing under mm_struct. Then use it in task_tick_fair.
> 
> Set per-process numa balancing:
> 	prctl(PR_NUMA_BALANCING, PR_SET_NUMAB_DISABLE); //disable
> 	prctl(PR_NUMA_BALANCING, PR_SET_NUMAB_ENABLE);  //enable
> 	prctl(PR_NUMA_BALANCING, PR_SET_NUMAB_DEFAULT); //follow global
> Get numa_balancing state:
> 	prctl(PR_NUMA_BALANCING, PR_GET_NUMAB, &ret);
> 	cat /proc/<pid>/status | grep NumaB_enabled
> 
> Cc: linux-api@vger.kernel.org
> Signed-off-by: Gang Li <ligang.bdlg@bytedance.com>


