Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8FAB586330
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Aug 2022 05:57:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239149AbiHAD5M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 31 Jul 2022 23:57:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbiHAD5E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Jul 2022 23:57:04 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 454A912AFE
        for <linux-kernel@vger.kernel.org>; Sun, 31 Jul 2022 20:57:03 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id z17so7840673wrq.4
        for <linux-kernel@vger.kernel.org>; Sun, 31 Jul 2022 20:57:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=7X0qgyXRO7VzjYNJesAxsDfx4rLtSss+PP90OaSq8hM=;
        b=O54pc8Ugfpn3cvZL/zqOZ3WOOh2vMupHh/20CBNKghTGuVjb3GvIkF3XnsPaIJj64r
         zlhh4yPi92FdiRMWEtJDjqdis0N90DM/1JHYxrMZK7ap4d9rkixu7MgqLFbw3oTnuMqZ
         brSkkDqUdyiSgxVyC+qT2crpQNVdkeQW0NLe83SPrR7sVRLjydV7w6KAxraUXpTqdwMH
         ckFYNNdX3kO5+Qx8bMMV6ofQMtXprcOt2/p7IF1QkqKXQoooqOQ7KFRM4kaLL3NIpj4y
         PPM7cguPG2x0ZOvaUgcX6BS0ip/bIvoarA2VSfIDxAQ+s6zjpPk/PaavYiXEkY2nUMZv
         9cRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=7X0qgyXRO7VzjYNJesAxsDfx4rLtSss+PP90OaSq8hM=;
        b=wVVQbiz+MYDgFWrl516PNbpay3iGwLAwGPBbv0oFt+rWDZOeMo5raMpjWVqn0HkUYu
         2umZjXgq3uOnDsjfR4vY/pjfhNUQMq1HYX0OnMP+eyWvEwLoWZ/sZBD+ImDlFnOVpBbB
         bSV7YiGntgO8wQDA8tTIv2hbI4BnGA2kjtcTBh645WKdqQB/eb6At+S/JDVeiZYpd1TW
         J/NVjR/2kAv1nNeCFvp1nPuoghRdTCR/BER3j2KBPA44SliAfMHk1pY4R0xqWVTvh7IM
         6LSVL8Uz8x0bTniNclk6JzfjYXKH7vvG5Gb0XFLIU+JcHDZywnIYviJwsp07ELJMVeyP
         72wA==
X-Gm-Message-State: ACgBeo1cX33JIpk14+yTcSxqYyF/31WoyypC2tyhVQEG4LUwX12q8Pr0
        KrzWFZ20Rx51X4My2xyLLk0hkB1Pkv4WfcURgfLtYgANEhU=
X-Google-Smtp-Source: AA6agR4ZY8zuoeK6b7NO3alXkF0KHcmYx+xNtKM91ract0etlymnIyq4dz5AaG1ZLJz3+BHoeywNaCqJffwKoiUxbAM=
X-Received: by 2002:a5d:5a9a:0:b0:220:6309:5c87 with SMTP id
 bp26-20020a5d5a9a000000b0022063095c87mr1703035wrb.107.1659326221838; Sun, 31
 Jul 2022 20:57:01 -0700 (PDT)
MIME-Version: 1.0
References: <20220707090501.55483-1-schspa@gmail.com> <0320c5f9-cbda-1652-1f97-24d1a22fb298@gmail.com>
 <YtAqsyjlvmfDokH/@worktop.programming.kicks-ass.net> <m2tu6zxme3.fsf@gmail.com>
In-Reply-To: <m2tu6zxme3.fsf@gmail.com>
From:   Lai Jiangshan <jiangshanlai@gmail.com>
Date:   Mon, 1 Aug 2022 11:56:50 +0800
Message-ID: <CAJhGHyBc4HXE8bRFYcqNLoX7oNqdq62tOFWvR0XGCAcBJ9mgsQ@mail.gmail.com>
Subject: Re: [PATCH] workqueue: Use active mask for new worker when pool is DISASSOCIATED
To:     Schspa Shi <schspa@gmail.com>
Cc:     Peter Zijlstra <peterz@infradead.org>, Tejun Heo <tj@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 30, 2022 at 12:19 PM Schspa Shi <schspa@gmail.com> wrote:
>
>
> Peter Zijlstra <peterz@infradead.org> writes:
>
> > On Wed, Jul 13, 2022 at 05:52:58PM +0800, Lai Jiangshan wrote:
> >>
> >>
> >> CC Peter.
> >> Peter has changed the CPU binding code in workqueue.c.
> >
> > [ 1622.829091] WARNING: CPU: 3 PID: 31 at kernel/sched/core.c:7756 sched_cpu_dying+0x74/0x204
> > [ 1622.829374] CPU: 3 PID: 31 Comm: migration/3 Tainted: P           O      5.10.59-rt52 #2
> >                                                                       ^^^^^^^^^^^^^^^^^^^^^
> >
> > I think we can ignore this as being some ancient kernel. Please try
> > something recent.
>
> Hi peter:
>
> I spent a few days writing a test case and reproduced the problem on
> kernel 5.19. I think it's time for us to review the V3 patch for a fix.
>
> The V3 patch is at
> https://lore.kernel.org/all/20220714031645.28004-1-schspa@gmail.com/
> Please help to review it.

Because of the implementation of is_cpu_allowed(),
I am still suspicious about how the newly created worker can be woken
up in the dying cpu since it has no KTHREAD_IS_PER_CPU set.

Is it a dying cpu when onlining a CPU fails?  I think balance_push
is not set in this case when it fails at some point during online.
But I haven't looked into the details and linked the clues.


>
> Test branch as:
> https://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-rt-devel.git/tag/?h=v5.19-rc8-rt8
>

Can it only be triggered in the rt kernel?

> I think this code is new enough to demonstrate that the problem persists.
>
> The log as fellowing:
>
> [ 3103.198684] ------------[ cut here ]------------
> [ 3103.198684] Dying CPU not properly vacated!
> [ 3103.198684] WARNING: CPU: 1 PID: 23 at kernel/sched/core.c:9575 sched_cpu_dying.cold+0xc/0xc3
> [ 3103.198684] Modules linked in: work_test(O)

Could you give me the code of this module?
