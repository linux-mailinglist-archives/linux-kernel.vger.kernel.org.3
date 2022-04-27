Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8934C511069
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 07:08:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357823AbiD0FMA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 01:12:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357810AbiD0FL7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 01:11:59 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5935D986DA
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 22:08:48 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id v10so569100pgl.11
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 22:08:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iIs67QnNUNxaSSEjZH8MNbvcuJ7fdQbyxSnWaC1EAwA=;
        b=EMXbacDFYEoeKbtEYuaHWu1PzMxGnjYKjYtKgtv3mNi2ppYS4/qeGGGiy3zPOmgYjB
         ZYC6jwDIEmpNN2xdQgsl0G9BtZY00K6RZR1Bk4PU1Vt2IxXEOlFQyJc9Ue2T1cf0WUoH
         BUFpgwcgEMesC0MatONa8YJZtdKXAwCot8fpHvpab2+Lgt6Jw3zbpOdo/F2eIqS+Fycl
         Zl3nXlnZktIxrrLsgnKu9cZgx+U5ejgVMub/8bMG3ylP8zIcWwao3O7pEWfTGWXK1JZl
         hvn7ej/edU9tLcY0JoGaOLOAScgMdfcTGOCGIbBQyvpRnybY7VFo5UW279ik8PhbcWWh
         ZW9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iIs67QnNUNxaSSEjZH8MNbvcuJ7fdQbyxSnWaC1EAwA=;
        b=itxRefwcrTPVFXfkRX/LSmXi3ImtpGtzmErGiO6Qr1cpwfujOVBuAACRr1AkSq9BhM
         fj93+vZZJxb9YVlG/97oKlo/0CPm2twksqj8OyqDYUiuMZBn9Kz4GfXDp3KYz5FqpVKL
         ZB+YryUJZ+R7J4bSa7e69MuJQ7dbIDdZK02rVuMyIPWRooywAaRLOw9NNu6gfNZY0x2x
         sNE3Rp6ut1iZJ+KLyJf23hYcyoJ2S6Dkn0TPV2YtpihuCUAEaYeJ28CXeBM3XIXYOJ+J
         vRrwUU7ZbTUEtGVd9gG1UbCcvuX3YkMrYkrfKr/2WglbgC3o3uz4aE7gX1jpisstiUBw
         dHGw==
X-Gm-Message-State: AOAM533/wU7lJJOSxfA5GZ/hs8Lfn+p/6wJ9ttRiL0dUV89CjaSPCJT6
        1d1tvdZOGrexmj+6SsoZXRorYMCyzCHIh4tL8AyOkg==
X-Google-Smtp-Source: ABdhPJxI2Hw5fxOipcGA6wsjKPwWy6dJzhp10FX65lvdpgeLTaXtyT/cOLs96fF+u2LVONtZGmh4eZtuxyT2n6a27qY=
X-Received: by 2002:a05:6a00:238b:b0:50d:7e99:86d4 with SMTP id
 f11-20020a056a00238b00b0050d7e9986d4mr2147908pfc.8.1651036127629; Tue, 26 Apr
 2022 22:08:47 -0700 (PDT)
MIME-Version: 1.0
References: <20220420055807.GA16310@xsang-OptiPlex-9020> <43598597-72e1-6750-9bee-031fd463fc3b@intel.com>
 <CAJD7tkaDWtgy3Ckhgo+vcbM7oYA8saPCVRvXLDKYHvRGYkKvoQ@mail.gmail.com>
In-Reply-To: <CAJD7tkaDWtgy3Ckhgo+vcbM7oYA8saPCVRvXLDKYHvRGYkKvoQ@mail.gmail.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Tue, 26 Apr 2022 22:08:36 -0700
Message-ID: <CALvZod4CZt6oSdyC1xZzWOj2nDCdhk0Qn6Ux1UjNmH9Oe7ukrg@mail.gmail.com>
Subject: Re: [memcg] a8c49af3be: hackbench.throughput -13.7% regression
To:     Yosry Ahmed <yosryahmed@google.com>
Cc:     Yin Fengwei <fengwei.yin@intel.com>,
        kernel test robot <oliver.sang@intel.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Muchun Song <songmuchun@bytedance.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org,
        kernel test robot <lkp@intel.com>,
        Ying <ying.huang@intel.com>, Feng Tang <feng.tang@intel.com>,
        Xing Zhengjun <zhengjun.xing@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 26, 2022 at 9:34 PM Yosry Ahmed <yosryahmed@google.com> wrote:
>
[...]
>
> The only seemingly expensive operation in the mod_memcg_state() path
> is the call to cgroup_rstat_updated() (through memcg_rstat_updated()).
> One idea off the top of my head is to batch calls to
> cgroup_rstat_updated(), similar to what 11192d9c124d ("memcg: flush
> stats only if updated") did on the flush side. I am interested to see
> what memcg maintainers think about this problem (and the proposed
> solution).
>

I am suspecting this is some code alignment changes which is causing
this difference. Let's first confirm the issue before thinking about
the optimizations.
