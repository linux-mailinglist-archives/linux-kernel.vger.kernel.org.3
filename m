Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49E9F585161
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jul 2022 16:15:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236927AbiG2OPx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jul 2022 10:15:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236483AbiG2OPv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jul 2022 10:15:51 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A8DCA79EC8
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jul 2022 07:15:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1659104149;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=rFA+uxNGNsudolD18ZmOlov1noIaWvtogHjG67RGCQY=;
        b=AoFFYk9aGKHH9UjwkvrbkdA9164xIah9vbHb0oZ7hxbbbbxCZ0dar1ZNXmZ9/hXw0Qm0Qt
        T2X8naO+qd1y/8sJBEkRFOXL9fIrf92Mwu2GdjeMszxXku3yfD+m5bQ5CgTpTL/Thukq3R
        Fo74Mz3t57N83S/M7lMgj0W149xOGBM=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-626-Wb4umgugPXqogFhzQf3MXw-1; Fri, 29 Jul 2022 10:15:48 -0400
X-MC-Unique: Wb4umgugPXqogFhzQf3MXw-1
Received: by mail-wr1-f70.google.com with SMTP id h9-20020adfa4c9000000b0021ee4a48ea7so1246241wrb.10
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jul 2022 07:15:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc;
        bh=rFA+uxNGNsudolD18ZmOlov1noIaWvtogHjG67RGCQY=;
        b=FVRVwzwtwd/dsRljbnbwo8irMuR9W+H3f5knZKBumPO0nDaOyPeKt8z83lvPSFIZdn
         mZhp/zbZ+Q3wnv1U2D8XnhIzLAZ/yue8j2YZTHJUL4b8JE7Ql5gP6trLHaZPupqgc6X0
         fM/fAae7ZfAmEkSoMJM4zD/EQyXjN693amkeXk4bRPiYD/dTxx5cetj4ic7g0iooBPVk
         /FT7oQa6iAL8WVHJhRuqr2VPaiX77g/zqsKAR6QwbaeOE4P62jE70uJVURxKvi3/oKBP
         PGUeE5KhEwtosXv8xDcfL5BpW52hRDkzcZ4inDdprl2Y/xUcKrMyIn94GYLDUK9+QsaA
         U8PA==
X-Gm-Message-State: AJIora+CEL3UJOCUCN2uNPrjOGbDLmIux+rFPey6KP2bkgvPB7aftuO5
        BlumhR0bxm8JrdGXoST+3AfsJ49Zffpka2FxsaPY8my5CpO+KBcbmLY2ywmNr5y02HGvr38AtIB
        qfOdYNcQvK2oa6xjkNlV4vydc0Bl8PDz+rh/W1WZSM3X156Qn3p8/aPz2ZUIx2/oxyuDWoDK9aB
        wk
X-Received: by 2002:a05:600c:1e8a:b0:3a3:20fc:a651 with SMTP id be10-20020a05600c1e8a00b003a320fca651mr2700422wmb.39.1659104147139;
        Fri, 29 Jul 2022 07:15:47 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1u/OiyyNpQFBL5eR2cI25OBjX69l2o77DctSBOzjH5C7szig2PiUhKPK6V052IXgZtMuA1mQA==
X-Received: by 2002:a05:600c:1e8a:b0:3a3:20fc:a651 with SMTP id be10-20020a05600c1e8a00b003a320fca651mr2700386wmb.39.1659104146777;
        Fri, 29 Jul 2022 07:15:46 -0700 (PDT)
Received: from vschneid.remote.csb ([185.11.37.247])
        by smtp.gmail.com with ESMTPSA id l21-20020a05600c1d1500b003a326b84340sm9677332wms.44.2022.07.29.07.15.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Jul 2022 07:15:46 -0700 (PDT)
From:   Valentin Schneider <vschneid@redhat.com>
To:     Tejun Heo <tj@kernel.org>, Waiman Long <longman@redhat.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] cgroup/cpuset: Keep current cpus list if cpus
 affinity was explicitly set
In-Reply-To: <YuMCB86fH2K3NcqM@slm.duckdns.org>
References: <20220728005815.1715522-1-longman@redhat.com>
 <YuLF+xXaCzwWi2BR@slm.duckdns.org>
 <1ae1cc6c-dca9-4958-6b22-24a5777c5e8d@redhat.com>
 <YuLdX7BYGvo57LNU@slm.duckdns.org>
 <606ed69e-8ad0-45d5-9de7-48739df7f48d@redhat.com>
 <YuL1NijxSEv2xadk@slm.duckdns.org>
 <c470d3f7-f0f8-b8e6-4a95-7b334f0a824b@redhat.com>
 <YuMCB86fH2K3NcqM@slm.duckdns.org>
Date:   Fri, 29 Jul 2022 15:15:45 +0100
Message-ID: <xhsmhy1wcc8dq.mognet@vschneid.remote.csb>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/07/22 11:39, Tejun Heo wrote:
> Hello, Waiman.
>
> On Thu, Jul 28, 2022 at 05:04:19PM -0400, Waiman Long wrote:
>> > So, the patch you proposed is making the code remember one special aspect of
>> > user requested configuration - whether it configured it or not, and trying
>> > to preserve that particular state as cpuset state changes. It addresses the
>> > immediate problem but it is a very partial approach. Let's say a task wanna
>> > be affined to one logical thread of each core and set its mask to 0x5555.
>> > Now, let's say cpuset got enabled and enforced 0xff and affined the task to
>> > 0xff. After a while, the cgroup got more cpus allocated and its cpuset now
>> > has 0xfff. Ideally, what should happen is the task now having the effective
>> > mask of 0x555. In practice, tho, it either would get 0xf55 or 0x55 depending
>> > on which way we decide to misbehave.
>>
>> OK, I see what you want to accomplish. To fully address this issue, we will
>> need to have a new cpumask variable in the the task structure which will be
>> allocated if sched_setaffinity() is ever called. I can rework my patch to
>> use this approach.
>
> Yeah, we'd need to track what user requested separately from the currently
> effective cpumask. Let's make sure that the scheduler folks are on board
> before committing to the idea tho. Peter, Ingo, what do you guys think?
>

FWIW on a runtime overhead side of things I think it'll be OK as that
should be just an extra mask copy  in sched_setaffinity() and a subset
check / cpumask_and() in set_cpus_allowed_ptr(). The policy side is a bit
less clear (when, if ever, do we clear the user-defined mask? Will it keep
haunting us even after moving a task to a disjoint cpuset partition?).

There's also if/how that new mask should be exposed, because attaching a
task to a cpuset will now yield a not-necessarily-obvious affinity -
e.g. in the thread affinity example above, if the initial affinity setting
was done ages ago by some system tool, IMO the user needs a way to be able
to expect/understand the result of 0x555 rather than 0xfff.

While I'm saying this, I don't think anything exposes p->user_cpus_ptr, but
then again that one is for "special" hardware...

> Thanks.
>
> --
> tejun

