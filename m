Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0925758EF6B
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Aug 2022 17:25:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232645AbiHJPZX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Aug 2022 11:25:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233439AbiHJPZL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Aug 2022 11:25:11 -0400
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B35D978237
        for <linux-kernel@vger.kernel.org>; Wed, 10 Aug 2022 08:25:09 -0700 (PDT)
Received: by mail-qt1-x832.google.com with SMTP id y18so1324503qtv.5
        for <linux-kernel@vger.kernel.org>; Wed, 10 Aug 2022 08:25:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=XKSHwFSFM1Cfz7cdR5obhEJYaVPc+IY05aklvSLeQmw=;
        b=e25AVASdPskhVxulzpOYgaM3vGiYCxw8t0zkJEcYGUk7Fx/Mq8TE82UTUMm1fMJjVJ
         +eQqkzIQtuQ3Xt94VFmavIu2BAbiC/+oGnTH5+DCvd3jY+Tqabjep1pmpm/SXb8nex/A
         /j6SqUkQQs2pAQbRfRMOyQOcuQgo77JpaJjLIvmv7AVsaBadJL1snWWmn0oQ7Z9bDpLN
         K9GiCya8kI8O2Ly2d26O96W/pja52lx6vvKnqSoq5WH1mypXZrvJnWZ9g3p3L8ZdIPTU
         YYXBaxvP1uUq0TSvFpBrEt3YPzMVQjZZ5RhrUlBB9wTSOKi3mTgDWCYXz8j3nkwzOy+f
         g1JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=XKSHwFSFM1Cfz7cdR5obhEJYaVPc+IY05aklvSLeQmw=;
        b=JEkSbTjoynBWDDPnURudw4P20l5KS48mK8TdhKM7toa+WbMg/dBc6wPuc/wI4nJAH0
         uDjAeefwyttsB0DgawuHTHqD9RR1rv0zLWo0NiimN0IJTObAtW5cS9IdFiD2bgJpSGyq
         puz8SmKbYC7KRNXu7qwGEeG7i8wLztEN5UF6Yra+bZTe6HsVkfv1v7xqW/yM2AnmhKgJ
         V0S+t27syBjN5T73OM1oV/TjqH7FAwEF7nLvwLixOQedDGa4YUnYzzyf0A7HOQMLEieC
         uj67h3lQR/URVoxLT0COItpfrDk2PrsOvvXVs2KxyiABKEdoVo4kXD9yXWF2zpTle92a
         T76g==
X-Gm-Message-State: ACgBeo1dCdcrwnkM/lkp3KjIDIB7u20y9IFP4lGPqXo2kdAeQDJc7aCL
        ZvIpSbqE1FQ0RqwQXx89h2koowCzcqXRXMZq
X-Google-Smtp-Source: AA6agR46ug8UE3bYlB04A3SaIp/ibz+lpypnAxWFbEaslJRTYlIrUQVKmD1HMBGmneR10958O2lyjw==
X-Received: by 2002:a05:622a:1c4:b0:342:f653:bdb with SMTP id t4-20020a05622a01c400b00342f6530bdbmr14334728qtw.31.1660145108572;
        Wed, 10 Aug 2022 08:25:08 -0700 (PDT)
Received: from localhost (2603-7000-0c01-2716-00ea-7f88-5fd9-01cd.res6.spectrum.com. [2603:7000:c01:2716:ea:7f88:5fd9:1cd])
        by smtp.gmail.com with ESMTPSA id f7-20020a05622a114700b0033c36ef019esm11938634qty.63.2022.08.10.08.25.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Aug 2022 08:25:08 -0700 (PDT)
Date:   Wed, 10 Aug 2022 11:25:07 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Chengming Zhou <zhouchengming@bytedance.com>
Cc:     Tejun Heo <tj@kernel.org>, corbet@lwn.net, surenb@google.com,
        mingo@redhat.com, peterz@infradead.org, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        cgroups@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, songmuchun@bytedance.com
Subject: Re: [PATCH v2 09/10] sched/psi: per-cgroup PSI stats
 disable/re-enable interface
Message-ID: <YvPN07UlaPFAdlet@cmpxchg.org>
References: <20220808110341.15799-1-zhouchengming@bytedance.com>
 <20220808110341.15799-10-zhouchengming@bytedance.com>
 <YvKd6dezPM6UxfD/@slm.duckdns.org>
 <fcd0bd39-3049-a279-23e6-a6c02b4680a7@bytedance.com>
 <b89155d3-9315-fefc-408b-4cf538360a1c@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b89155d3-9315-fefc-408b-4cf538360a1c@bytedance.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 10, 2022 at 09:30:59AM +0800, Chengming Zhou wrote:
> On 2022/8/10 08:39, Chengming Zhou wrote:
> > On 2022/8/10 01:48, Tejun Heo wrote:
> >> Hello,
> >>
> >> On Mon, Aug 08, 2022 at 07:03:40PM +0800, Chengming Zhou wrote:
> >>> So this patch introduce a per-cgroup PSI stats disable/re-enable
> >>> interface "cgroup.psi", which is a read-write single value file that
> >>> allowed values are "0" and "1", the defaults is "1" so per-cgroup
> >>> PSI stats is enabled by default.
> >>
> >> Given that the knobs are named {cpu|memory|io}.pressure, I wonder whether
> >> "cgroup.psi" is the best name. Also, it doesn't convey that it's the
> >> enable/disable knob. I think it needs a better name.
> > 
> > Yes, "cgroup.psi" is not good. What abort "pressure.enable" or "cgroup.psi_enable"?
> 
> Doesn't look good either, what do you think of "cgroup.pressure.enable"?

How about just cgroup.pressure? Too ambiguous?

cgroup.pressure.enable sounds good to me too. Or, because it's
default-enabled and that likely won't change, cgroup.pressure.disable.
