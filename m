Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7274A5855D9
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jul 2022 21:59:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238704AbiG2T7Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jul 2022 15:59:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238877AbiG2T7V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jul 2022 15:59:21 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 443F189E90;
        Fri, 29 Jul 2022 12:59:20 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id e16so5507993pfm.11;
        Fri, 29 Jul 2022 12:59:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc;
        bh=NFtB5w26t9HkZR90SOzX7+kqkeWvxLjJ+yXgD8mSTL8=;
        b=kYJpRYXcs0BpAHRthkEYWwoGTDm3mg2IhTCkR4+pXmWwRer4oCgrbsopCkvHq0LM29
         R/83JZRdkn01R58g0pun57DqbGSYw/HZH1VPOvwZguT3WhbOKxdAQrlLPudpkgUqKcwM
         WzvRgiACgv3i83PuAZchchg6PFEqawodFoJeoEVyghiIc1F5a7pLEjjNEM3XkTOVl6QM
         3lyw72Of/gic7WcjSDol9kK6p4YGueioQV8Eqa7bbnberY3hawUOz4M0w90Bq+/utMej
         iszxVewnyBQJJcRcNwtR64xGDAU2crr4BOE2aGQmVfUSc7PpzAPLxangktQU2zOfNI5c
         2sTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc;
        bh=NFtB5w26t9HkZR90SOzX7+kqkeWvxLjJ+yXgD8mSTL8=;
        b=aS9wDDVLZ3YQvHLCkfC59vpOQOzqRHW98U+88N0AX0O22oWlaqTIp5IbZKtQS+d08g
         8H0mBZ35Me3DgLakak6X8vv6E+RkFdCGgvPTMyzbMtGJPgWa2VQxsde7oONEvKBNuk8+
         N2NjHMul6O12oTU5PjZ4EZJOrOKluIUvfvrETSM3CNU3fFsTqZQTWFY4yEV6qDDCXsRL
         UBrsFDLvyamYM8KvFY0oduUfvHLSW1SzdMjTPYRn4ogZEsCrvbIHhBvmrGOSrvJUhlsk
         jBMZkjhshIvFA6hFxgseyuki8ZjQbrmQSDM29XKQ0DdxhhYgB30Wwi2ReZmncBra00jo
         tWoA==
X-Gm-Message-State: AJIora/mVHG6h5mT+Y+9E0FnWhdHNZBTsNoU9cOp0eRFdaZa9VYOzLMC
        QwMOAzgCea17wYYxsjZ9nHI=
X-Google-Smtp-Source: AGRyM1uAAqMmy0cDuYbePTOONdKdGb8DK8kbeNWw8zXcD7zczWYEGqsXxWFAC4hJ/HSCcYOpu9fDUg==
X-Received: by 2002:a63:2205:0:b0:417:61fd:cd35 with SMTP id i5-20020a632205000000b0041761fdcd35mr4065690pgi.544.1659124759663;
        Fri, 29 Jul 2022 12:59:19 -0700 (PDT)
Received: from localhost ([2620:10d:c090:400::5:df80])
        by smtp.gmail.com with ESMTPSA id d8-20020a17090a7bc800b001f2ef3c7956sm6269020pjl.25.2022.07.29.12.59.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Jul 2022 12:59:18 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Fri, 29 Jul 2022 09:59:17 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Qais Yousef <qais.yousef@arm.com>
Cc:     Xuewen Yan <xuewen.yan94@gmail.com>,
        Waiman Long <longman@redhat.com>,
        Xuewen Yan <xuewen.yan@unisoc.com>, rafael@kernel.org,
        viresh.kumar@linaro.org, mingo@redhat.com, peterz@infradead.org,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, linux-kernel@vger.kernel.org,
        ke.wang@unisoc.com, xuewyan@foxmail.com, linux-pm@vger.kernel.org,
        Lukasz Luba <Lukasz.Luba@arm.com>, pengcheng.lai@unisoc.com
Subject: Re: [PATCH] sched/schedutil: Fix deadlock between cpuset and cpu
 hotplug when using schedutil
Message-ID: <YuQ8FWtrMsgDmGAr@slm.duckdns.org>
References: <20220705123705.764-1-xuewen.yan@unisoc.com>
 <20220711174629.uehfmqegcwn2lqzu@wubuntu>
 <YsyO9GM9mCydaybo@slm.duckdns.org>
 <c1426573-92a7-9f0d-a6b8-aa612248b9a9@redhat.com>
 <Ys41ZF5TmSnLLNRB@slm.duckdns.org>
 <CAB8ipk-8cbur-m733py-cw4bXCt7gkd8gAOXtKO+-fV1B2EeZw@mail.gmail.com>
 <YuGbYCfAG81mZBnN@slm.duckdns.org>
 <CAB8ipk_gCLtvEahsp2DvPJf4NxRsM8WCYmmH=yTd7zQE+81_Yg@mail.gmail.com>
 <20220729083949.6uaojl3vqyvwpkuk@wubuntu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220729083949.6uaojl3vqyvwpkuk@wubuntu>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 29, 2022 at 09:39:49AM +0100, Qais Yousef wrote:
> I *think* it's because we haven't removed cpus_read_lock() from
> cpuset_attach(). So we end up holding the lock twice in the same path. Since we
> hold it unconditionally now, we should remove cpuset dependency on
> cpus_read_lock() I believe.

Ah, yeah, that's because pending write locker makes future reader lockers
wait, so even if we're holding read lock, if we try to read lock again, we
end up waiting. I'll make the cpus_read_lock() unconditional in cgroup core
and drop it from cpuset's attach operation.

Thanks.

-- 
tejun
