Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A24775990EF
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Aug 2022 01:07:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245047AbiHRXFf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Aug 2022 19:05:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244246AbiHRXFd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Aug 2022 19:05:33 -0400
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 463E6CD7A2
        for <linux-kernel@vger.kernel.org>; Thu, 18 Aug 2022 16:05:32 -0700 (PDT)
Received: by mail-io1-xd35.google.com with SMTP id 10so2202913iou.2
        for <linux-kernel@vger.kernel.org>; Thu, 18 Aug 2022 16:05:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=DEs4QdwBZh24q/YXet07H+yoRoWFt6AeBiWh1qampiM=;
        b=NRf5fd3sxugF1Zngi0c9/hpqIoc552QiPB12KJSFJTFTF7UVI1QeOqUmF5KWIMxnJq
         mBtUqIYHGYxr8OHnH1Yk6aMKEu2+McD7STFeYtAEYlov8ONetZcZAiuRZqUGheH2klwu
         VUNzsd7J7RM218D46GArrQ6WKM+ejqFCQlcpo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=DEs4QdwBZh24q/YXet07H+yoRoWFt6AeBiWh1qampiM=;
        b=Xb/jWBL/kbTmSF+y64ZBo13aEJoMGr7jNkpEpjimVzsLuixRCFmAM11SXu+fPaXavl
         QLTKeBLeRcj8pQ3ap/VynTu7p6C8rv8PpvKeXFg5RllA5dQamXkqpISnUgwPVQD9VK2q
         fuMWcjSILanLAXk5nP+rVywsAqGNBAEQ3HN7PT3eXAPxWYLeBIOfGI8cTz9LVR+R8dsz
         UZWNrBNfAfM7mFHZ7CRm01CsGDqMZiyQ17fRZ3WTQtFaN8KBYym0DqwrEytudGDa1Cr/
         sr/wy3pWUNyYnmX3aeOk+of4VVME04aDIjGj7aj9d5wnXrL/B+ozuICRJtD+eiLMRTvX
         u9Rw==
X-Gm-Message-State: ACgBeo2Arg2BfGP1pABybwRQ8MS+QcJIUCNh+z3x2bcpdX9EdLcbEHbc
        +FGpXHSlhS/1wKXJvgfuAe/GhqX+2DhRGjZtQc2KlclOLq5iIQ==
X-Google-Smtp-Source: AA6agR4gzrzYri2e4hcP+IvTvBPJ90eC8Z8V93sG2S9RPq9wXt+Goc522k09OwM5cnsLYyh5/EuPN7AcGD9grMoP/PQ=
X-Received: by 2002:a05:6638:378c:b0:343:447e:e6e2 with SMTP id
 w12-20020a056638378c00b00343447ee6e2mr1451606jal.118.1660863931374; Thu, 18
 Aug 2022 16:05:31 -0700 (PDT)
MIME-Version: 1.0
References: <20220809034517.3867176-1-joel@joelfernandes.org>
 <20220809034517.3867176-5-joel@joelfernandes.org> <CAEXW_YQuGga9Eivq4G6o1XjvPn-nMMDiM8FOY6HXJTMzwv1Emg@mail.gmail.com>
In-Reply-To: <CAEXW_YQuGga9Eivq4G6o1XjvPn-nMMDiM8FOY6HXJTMzwv1Emg@mail.gmail.com>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Thu, 18 Aug 2022 19:05:19 -0400
Message-ID: <CAEXW_YQOXBRwCLZXjspXttGkNhbJK3HGVDuYj5TcYD=Xj1cK0A@mail.gmail.com>
Subject: Re: [PATCH v3 resend 4/6] fs: Move call_rcu() to call_rcu_lazy() in
 some paths
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Rushikesh S Kadam <rushikesh.s.kadam@intel.com>,
        "Uladzislau Rezki (Sony)" <urezki@gmail.com>,
        Neeraj upadhyay <neeraj.iitr10@gmail.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>, rcu <rcu@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 18, 2022 at 1:23 PM Joel Fernandes <joel@joelfernandes.org> wrote:
>
> [Sorry, adding back the CC list]
>
> On Mon, Aug 8, 2022 at 11:45 PM Joel Fernandes (Google)
> <joel@joelfernandes.org> wrote:
> >
> > This is required to prevent callbacks triggering RCU machinery too
> > quickly and too often, which adds more power to the system.
> >
> > When testing, we found that these paths were invoked often when the
> > system is not doing anything (screen is ON but otherwise idle).
>
> Unfortunately, I am seeing a slow down in ChromeOS boot performance
> after applying this particular patch. It is the first time I could
> test ChromeOS boot times with the series since it was hard to find a
> ChromeOS device that runs the upstream kernel.
>
> Anyway, Vlad, Neeraj, do you guys also see slower boot times with this
> patch? I wonder if the issue is with wake up interaction with the nocb
> GP threads.
>
> We ought to disable lazy RCU during boot since it would have little
> benefit anyway. But I am also concerned about some deeper problem I
> did not catch before.
>
> I'll look into tracing the fs paths to see if I can narrow down what's
> causing it. Will also try a newer kernel, I am currently testing on
> 5.19-rc4.

I got somewhere with this. It looks like queuing CBs as lazy CBs
instead of normal CBs, are triggering expedited stalls during the boot
process:

  39.949198] rcu: INFO: rcu_preempt detected expedited stalls on
CPUs/tasks: { } 28 jiffies s: 69 root: 0x0/.

No idea how/why lazy RCU CBs would be related to expedited GP issues,
but maybe something hangs and causes that side-effect.

initcall_debug did not help, as it seems initcalls all work fine, and
then 8 seconds after the boot, it starts slowing down a lot, followed
by the RCU stall messages. As a next step I'll enable ftrace during
the boot to see if I can get more insight. But I believe, its not the
FS layer, the FS layer just triggers lazy CBs, but there is something
wrong with the core lazy-RCU work itself.

This kernel is 5.19-rc4. I'll also try to rebase ChromeOS on more
recent kernels and debug.

Thanks,

 - Joel
