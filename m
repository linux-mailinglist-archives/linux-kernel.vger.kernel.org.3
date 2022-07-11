Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2A89570C42
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 22:58:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231638AbiGKU6k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 16:58:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229615AbiGKU6h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 16:58:37 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD821C10;
        Mon, 11 Jul 2022 13:58:31 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id j1-20020a17090aeb0100b001ef777a7befso177642pjz.0;
        Mon, 11 Jul 2022 13:58:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=VtPW/Lt5Z1tr8gm6l2bDv7xPDRY/d3rry0OUzw7TIPc=;
        b=Nbhhl2aSnTEudJCfY9q/OqMf3HdGS3Y67MZiTWFOOLD+oZqbG2/ONfCTHlrefHbI5G
         jxfm72weuCLaP2wFfAB3jRN7qCQVBGKjpnwZAoPchLDeB6dP4otu5zGScji2u9K6fpKb
         WV0lXLz1N/gPWVlD4YNqrA8Nr0NRBK/E7gf5+OkJ+4XbsC25JJ1gmA0VHFDRr226NKFn
         1lPGsdEhX6JTW4O9SPGID4K7yV9oMYhkbEWkomOXvvLiJ6tF6hzRmBqWcwDIXNHl+f2l
         7zzZWhS8law7H7oIcy4SbE2KOVZw/i5JJkIk641uUPgf/F1f3w/qmOHGbSFtvakk/nHd
         XMJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=VtPW/Lt5Z1tr8gm6l2bDv7xPDRY/d3rry0OUzw7TIPc=;
        b=23oPxwItCFxDzNawocvWpIxXn1b7cX3p4YpIQ9JPZgUZa6P+T6G/piT7WN/+TowzU4
         gX8kb8ou70d6spt7zAPj5FaXImQYz7LliBgXZRtYrDCUc/uGMo6f4lqAHEC+MDU1cU/d
         WU/fn/qRzmlr2d4uKCNlAOmdLgOgjso9nfoGIqlVwafLFQ2L/93bmJXFKA+48aV5fCSH
         sILWJ8795iN8hBe7qecQfXsP1hUwnj+DMexYbdSg/RIGljPoCDK3wLzL3W7erH3hAEwt
         ZpRbcMQ95hmfemAzJKbeip/Walq2u/RO+84yDneUDOHnl/rA9sagxbLO5T3jLHf8FAX/
         5IpA==
X-Gm-Message-State: AJIora+RCbqrwVp7XIraKfPW90qUVx4qwdiAqQj5q9ATrPTssbh/1Ut8
        jk/CcC+Jbx4nPfvuf1WO1Ps=
X-Google-Smtp-Source: AGRyM1vn9A15ZlwVHjPMYQdbom4DMItZ7W19yFs6V66bI0PvIZG6FMFMc0rwahiWRD0ZWoLPS2YdRQ==
X-Received: by 2002:a17:90a:6008:b0:1ef:abc7:a740 with SMTP id y8-20020a17090a600800b001efabc7a740mr260728pji.179.1657573111142;
        Mon, 11 Jul 2022 13:58:31 -0700 (PDT)
Received: from localhost (2603-800c-1a02-1bae-a7fa-157f-969a-4cde.res6.spectrum.com. [2603:800c:1a02:1bae:a7fa:157f:969a:4cde])
        by smtp.gmail.com with ESMTPSA id x10-20020a170902a38a00b001678ce9080dsm5112601pla.258.2022.07.11.13.58.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Jul 2022 13:58:30 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Mon, 11 Jul 2022 10:58:28 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Qais Yousef <qais.yousef@arm.com>
Cc:     Xuewen Yan <xuewen.yan@unisoc.com>, rafael@kernel.org,
        viresh.kumar@linaro.org, mingo@redhat.com, peterz@infradead.org,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, linux-kernel@vger.kernel.org,
        ke.wang@unisoc.com, xuewyan@foxmail.com, linux-pm@vger.kernel.org,
        Waiman Long <longman@redhat.com>
Subject: Re: [PATCH] sched/schedutil: Fix deadlock between cpuset and cpu
 hotplug when using schedutil
Message-ID: <YsyO9GM9mCydaybo@slm.duckdns.org>
References: <20220705123705.764-1-xuewen.yan@unisoc.com>
 <20220711174629.uehfmqegcwn2lqzu@wubuntu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220711174629.uehfmqegcwn2lqzu@wubuntu>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

(cc'ing Waiman)

On Mon, Jul 11, 2022 at 06:46:29PM +0100, Qais Yousef wrote:
> Have you tried running with PROVE_LOCKDEP enabled? It'll help print a useful
> output about the DEADLOCK. But your explanation was good and clear to me.

I don't think lockdep would be able to track CPU1 -> CPU2 dependency here
unfortunately.

> AFAIU:
> 
> 
> CPU0                                     CPU1                                   CPU2
> 
> // attach task to a different
> // cpuset cgroup via sysfs
> __acquire(cgroup_threadgroup_rwsem)
> 
>                                          // pring up CPU2 online
>                                          __acquire(cpu_hotplug_lock)
>                                          // wait for CPU2 to come online
>                                                                                 // bringup cpu online
>                                                                                 // call cpufreq_online() which tries to create sugov kthread
> __acquire(cpu_hotplug_lock)                                                     copy_process()
>                                                                                    cgroup_can_fork()
>                                                                                       cgroup_css_set_fork()
>                                                                                       __acquire(cgroup_threadgroup_rwsem)
> // blocks forever                        // blocks forever                            // blocks forever
> 
> 
> Is this a correct summary of the problem?
> 
> The locks are held in reverse order and we end up with a DEADLOCK.
> 
> I believe the same happens on offline it's just the path to hold the
> cgroup_threadgroup_rwsem on CPU2 is different.
> 
> This will be a tricky one. Your proposed patch might fix it for this case, but
> if there's anything else that creates a kthread when a cpu goes online/offline
> then we'll hit the same problem again.
> 
> I haven't reviewed your patch to be honest, but I think worth seeing first if
> there's something that can be done at the 'right level' first.
> 
> Needs head scratching from my side at least. This is the not the first type of
> locking issue between hotplug and cpuset :-/

Well, the only thing I can think of is always grabbing cpus_read_lock()
before grabbing threadgroup_rwsem. Waiman, what do you think?

Thanks.

-- 
tejun
