Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADF9A51000A
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 16:09:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351441AbiDZOMc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 10:12:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242887AbiDZOMa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 10:12:30 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AAFB1C121
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 07:09:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D106DB81CFE
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 14:09:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97BE5C385AA;
        Tue, 26 Apr 2022 14:09:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650982159;
        bh=cn5vJ91S0B5D1VOlBlyzpD8O4r5FahRLokcLNG4NiEU=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=qe51Zqr8EfwpOPspP4puM0YF+yTOcDUFofezOFFxkzmDbAfD5HQ6tINKn9PDcPl+l
         HdxZpY72ksQYizK32X1LHoNLWHnSpUT9hyshuNlzcQBbs8snG+6T5ZXSpTo8STo4kg
         znnOlHH0k3t8i0wq+r7JlIkSzKFgpV4OvQz7JRS/kTFD+gp8d8BSuwPhwMLlAvvHaW
         E75aeXFN+pf89YLTscUQt81rvwNCSI7gQZaZOlUXTEcJAauk3+kkc+PceoRFKJKil+
         v3NhJozqWFSDwMic4VUhrxr8KyZHtCXM30CxxGE40sfgPzrW9jRCDVdQYrkLNZThk7
         j4uN0TAAziz8g==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 35D495C0460; Tue, 26 Apr 2022 07:09:19 -0700 (PDT)
Date:   Tue, 26 Apr 2022 07:09:19 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Christoph Bartoschek <bartoschek@google.com>
Cc:     Chris Mason <clm@fb.com>, Giuseppe Scrivano <gscrivan@redhat.com>,
        linux-kernel@vger.kernel.org,
        "riel@surriel.com" <riel@surriel.com>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH RFC fs/namespace] Make kern_unmount() use
 synchronize_rcu_expedited()
Message-ID: <20220426140919.GD4285@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <8E281DF1-248F-4861-A3C0-2573A5EFEE61@fb.com>
 <20220426065917.3123488-1-bartoschek@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220426065917.3123488-1-bartoschek@google.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 26, 2022 at 08:59:17AM +0200, Christoph Bartoschek wrote:
> The regression that has been introduced with commit
> e1eb26fa62d04ec0955432be1aa8722a97cb52e7 has hit us when building with Bazel
> using the linux-sandbox
> (https://github.com/bazelbuild/bazel/blob/master/src/main/tools/linux-sandbox.cc).
> The sandbox tries to isolate build steps from each other and to ensure that
> builds are hermetic and therefore sets up new namespaces for each step. For
> large software packages and even with the time spend building we run out of
> namespaces on larger machines that allow for enough parallelism. I have reduced
> the sandbox to a simple test case:
> 
> #define _GNU_SOURCE
> #include <errno.h>
> #include <sched.h>
> #include <stdio.h>
> #include <stdlib.h>
> #include <sys/types.h>
> #include <sys/wait.h>
> 
> int pid1main(void *) {
>    return 0;
> }
> 
> int main(void) {
>   int clone_flags = CLONE_NEWUSER | CLONE_NEWIPC | SIGCHLD;
>   void * stack = malloc(1024*1024);
>   const pid_t child_pid = clone(pid1main, stack + 1024*1024, clone_flags, NULL);
> 
>   if (child_pid < 0) {
>     perror("clone");
>   }
>   int ret = waitpid(child_pid, NULL, 0);
>   if (ret < 0) {
>     perror("waitpid");
>     return ret;
>   }
>   return 0;
> }
> 
> Run it with
> $ gcc clone-test.cc
> $ seq 1 10000000 | parallel --halt now,fail=1 -j32 $PWD/a.out
> clone: No space left on device
> waitpid: No child processes
> parallel: This job failed:
> /usr/local/google/home/bartoschek/linux-sandbox-test/a.out 53070
> 
> I run the test on kernel v5.18-rc4.
> Depending on your configured limits you will soon get an ENOSPC even though
> never more than 32 additional namespaces should be in use by parallel.
> During execution the whole system can become quite unresponsive.
> This does not happen without e1eb26fa62d04ec0955432be1aa8722a97cb52e7.
> 
> I see that the issue was already reported in 2020:
> http://merlin.infradead.org/pipermail/linux-nvme/2020-September/019565.html
> 
> Would it be possible to revert e1eb26fa62d04ec0955432be1aa8722a97cb52e7? It
> seems to make the kernel less deterministic and hard to reason about active
> namespaces.

There were several attempts to fix this:

1. https://lore.kernel.org/lkml/20220214190549.GA2815154@paulmck-ThinkPad-P17-Gen-1/
	Replace a synchronize_rcu() with synchronize_rcu_expedited()

2. https://lore.kernel.org/lkml/20220217153620.4607bc28@imladris.surriel.com/
	Use queue_rcu_work() and streamline things.

3. https://lore.kernel.org/lkml/20220218183114.2867528-1-riel@surriel.com/
	Refined queue_rcu_work() approach.

#1 should work, but the resulting IPIs are not going to make the real-time
guys happy.  #2 and #3 have been subject to reasonably heavy testing
and did fix a very similar issue to the one that you are reporting,
but last I knew there were doubts about the concurrency consequences.

Could you please give at least #3 a shot and see if it helps you?

							Thanx, Paul
