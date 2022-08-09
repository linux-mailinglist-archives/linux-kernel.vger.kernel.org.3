Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEC7C58D1E2
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Aug 2022 04:03:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231569AbiHICDC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Aug 2022 22:03:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229593AbiHICC6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Aug 2022 22:02:58 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73884183B3;
        Mon,  8 Aug 2022 19:02:57 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id l21so154901ljj.2;
        Mon, 08 Aug 2022 19:02:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=+8W2Pk4vFE/5ScoPdt7aCafH2GFjYqFQgAnxxqtg8nw=;
        b=V+H30AgvA9w6ZWfKURgwUBwd3mxfGB1HsOf7idEhywJMyyh3aV0tnyni06iUAzLPCs
         BnScYAvMxuuj+s0sP3f0iDwjh2lLFJPWfe9HN8lVY1BHFywuBcaUr97Ja2iHvFx5fwAx
         OWzLsVRRbu3SOT7zmz1rL81aFE9dp9y2sdNVYHC20w6FIggNtAU7d66h+mlMs3JmvKO8
         d/+NX0Bu+A4eaex1LqPvFRQ4NBgmni0HZWqMUeeDvsBd7sjLv5Rnw38KF7ArKl3/8bIb
         4t/Fk98LLTEIehXxSOuWaJmZadkN7reRaAW563HuxbYD60AHjwPJCIn9Z9DGtjvvz+88
         FU9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=+8W2Pk4vFE/5ScoPdt7aCafH2GFjYqFQgAnxxqtg8nw=;
        b=sN5J/pBzyrMFW8nqhuR/op3SvtOWkbWT3+777HssoVVHvxmQrpvz1YSyE6VgQrujzK
         a+KcAMj5H88yFn4CK6AmQ/q1wl+FaW5z3am2dCNtUN7rbJKOg57UkCMLrH0IArFoX50x
         0rE8n14NKAq6E9wwmEmGI1vYm51EDmhcUwqENV646LFobCk5postTh/6/DrGN/vmGDa7
         4qLxeiWxAJbHm3Bw1gkX0+ElIqW9yaPeRCNfzaslSgnFkyuM75J8VsgpdeK5QvcWw0RW
         RZtV/omHEGpXX8MeHRzU9ur4lNhVFEtilcYAc1xr4qaJXPAloEICpUQOD/4IkECQE5rH
         kN2Q==
X-Gm-Message-State: ACgBeo1DjT4V7efsUQsXpUJcWxzI478sb/ubVOKz6fevTBWH3f2+OsyO
        pX8RTSkhARdNPtHnAYVpP19OqR1aF026DzOC+fs=
X-Google-Smtp-Source: AA6agR4cSDsPkAq9s1iwskF2crqiYCzQwV2sc4qthBN0wuBQl1UDXVpFMKlEgYYj8bhAsv34ytI25n3p6gjO4Cnkqbk=
X-Received: by 2002:a2e:a587:0:b0:25f:e6ac:c287 with SMTP id
 m7-20020a2ea587000000b0025fe6acc287mr1723207ljp.416.1660010575748; Mon, 08
 Aug 2022 19:02:55 -0700 (PDT)
MIME-Version: 1.0
References: <20220705123705.764-1-xuewen.yan@unisoc.com> <20220711174629.uehfmqegcwn2lqzu@wubuntu>
 <YsyO9GM9mCydaybo@slm.duckdns.org> <c1426573-92a7-9f0d-a6b8-aa612248b9a9@redhat.com>
 <Ys41ZF5TmSnLLNRB@slm.duckdns.org> <CAB8ipk-8cbur-m733py-cw4bXCt7gkd8gAOXtKO+-fV1B2EeZw@mail.gmail.com>
 <YuGbYCfAG81mZBnN@slm.duckdns.org> <CAB8ipk_gCLtvEahsp2DvPJf4NxRsM8WCYmmH=yTd7zQE+81_Yg@mail.gmail.com>
 <20220729083949.6uaojl3vqyvwpkuk@wubuntu> <YuQ8FWtrMsgDmGAr@slm.duckdns.org>
In-Reply-To: <YuQ8FWtrMsgDmGAr@slm.duckdns.org>
From:   Xuewen Yan <xuewen.yan94@gmail.com>
Date:   Tue, 9 Aug 2022 10:02:44 +0800
Message-ID: <CAB8ipk-72V-bYRfL-VcSRSyXTeQqkBVj+1d5MHSVV5CTar9a0Q@mail.gmail.com>
Subject: Re: [PATCH] sched/schedutil: Fix deadlock between cpuset and cpu
 hotplug when using schedutil
To:     Tejun Heo <tj@kernel.org>
Cc:     Qais Yousef <qais.yousef@arm.com>,
        Waiman Long <longman@redhat.com>,
        Xuewen Yan <xuewen.yan@unisoc.com>, rafael@kernel.org,
        viresh.kumar@linaro.org, mingo@redhat.com, peterz@infradead.org,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, linux-kernel@vger.kernel.org,
        ke.wang@unisoc.com, xuewyan@foxmail.com, linux-pm@vger.kernel.org,
        Lukasz Luba <Lukasz.Luba@arm.com>, pengcheng.lai@unisoc.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tejun

On Sat, Jul 30, 2022 at 3:59 AM Tejun Heo <tj@kernel.org> wrote:
>
> On Fri, Jul 29, 2022 at 09:39:49AM +0100, Qais Yousef wrote:
> > I *think* it's because we haven't removed cpus_read_lock() from
> > cpuset_attach(). So we end up holding the lock twice in the same path. Since we
> > hold it unconditionally now, we should remove cpuset dependency on
> > cpus_read_lock() I believe.
>
> Ah, yeah, that's because pending write locker makes future reader lockers
> wait, so even if we're holding read lock, if we try to read lock again, we
> end up waiting. I'll make the cpus_read_lock() unconditional in cgroup core
> and drop it from cpuset's attach operation.

I revert the following patch which add the cpus_read_lock() in
cpuset's attach and have test for a while. And the deadlock has not
reproduced.

https://lore.kernel.org/all/20220121101210.84926-1-zhangqiao22@huawei.com/

But I do not know the risk with reverting the patch..

Thanks!
BR
-- 
xuewen

>
> Thanks.
>
> --
> tejun
