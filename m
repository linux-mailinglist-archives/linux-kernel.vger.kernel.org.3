Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2F274D8FB3
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Mar 2022 23:42:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245699AbiCNWnu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Mar 2022 18:43:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245670AbiCNWns (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Mar 2022 18:43:48 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AE7C3EBA9;
        Mon, 14 Mar 2022 15:42:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C5CC9B81082;
        Mon, 14 Mar 2022 22:42:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03AADC340EC;
        Mon, 14 Mar 2022 22:42:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647297755;
        bh=JUEwcNiK+49zfPIzDPSmMO7E/urjuArgsOTyuH002kA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=iRIgugiEgu4wfyJ7ZXyXUXw6nf8ah8EpDGWAfepghHf3EwkwlrCA9uJRPRZTHpjIA
         A/twyEwyPMksx0drjwCuanq/LCIN7ieEiFQ2LFLtg/3ytAS40yOQVn5Z/yVPZk4iRL
         eJw4FsrzHH1Fk5FoTFjxbGGreT1FhfUKErbZxjy20aAa1IVnupe57hxG/dc/wMz51G
         OJgGZNG2kqwuNBDZHFP8KwLm2F+qOFYxYaqpIVwCMw9FF5qpkTyVsHIaVvC1F6BD5R
         10RlnjZM/4bqJCjrqGVZApJX16mecAbJzwEtCAgDKwuABltwb903t0sUhFg9SpbwCh
         n6YhpwgehobVw==
Date:   Mon, 14 Mar 2022 23:42:32 +0100
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Valentin Schneider <valentin.schneider@arm.com>
Cc:     linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com,
        linux-kbuild@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>, Mike Galbraith <efault@gmx.de>,
        Marco Elver <elver@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>
Subject: Re: [PATCH v3 0/4] preempt: PREEMPT vs PREEMPT_DYNAMIC configs fixup
Message-ID: <20220314224232.GA274290@lothringen>
References: <20211112185203.280040-1-valentin.schneider@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211112185203.280040-1-valentin.schneider@arm.com>
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 12, 2021 at 06:51:59PM +0000, Valentin Schneider wrote:
> Hi folks,
> 
> This v3 is mostly about the naming problem - get your paintbrushes ready!
> 
> Patches
> =======
> 
> o Patch 1 is the meat of the topic - note that it's now in tip/sched/urgent
> o Patch 2 introduces helpers for the dynamic preempt state
> o Patches 3-4 make use of said accessors where relevant.
> 
> Testing
> =======
> 
> Briefly tested the dynamic part on an x86 kernel + QEMU.
> Compile-tested the kcsan test thingie as a module.
> 
> Revisions
> =========
> 
> v1: http://lore.kernel.org/r/20211105104035.3112162-1-valentin.schneider@arm.com
> v1.5: http://lore.kernel.org/r/20211109151057.3489223-1-valentin.schneider@arm.com
> 
> v2 -> v3
> ++++++++
> 
> o Turned is_preempt_*() into preempt_model_*() (Frederic)
>   It breaks my rule of "booleans must answer a yes/no question" but is the best
>   I could come with using a "preempt_" prefix
>   
> o Added preempt_model_preemptible() (Marco)
>   Now used in kcsan_test.c
>   
> o Dropped powerpc changes
> 
> Cheers,
> Valentin
> 
> 
> Valentin Schneider (4):
>   preempt: Restore preemption model selection configs

Seems like this one has been applied from the previous series.

>   preempt/dynamic: Introduce preemption model accessors
>   kcsan: Use preemption model accessors
>   ftrace: Use preemption model accessors for trace header printout

So for the rest:

Acked-by: Frederic Weisbecker <frederic@kernel.org>

Thanks!
