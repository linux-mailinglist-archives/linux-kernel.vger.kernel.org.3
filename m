Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A711A58F5D5
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Aug 2022 04:23:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233751AbiHKCXm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Aug 2022 22:23:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233743AbiHKCXc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Aug 2022 22:23:32 -0400
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A157188DD1
        for <linux-kernel@vger.kernel.org>; Wed, 10 Aug 2022 19:23:27 -0700 (PDT)
Received: by mail-qk1-x72d.google.com with SMTP id t11so1829402qkt.6
        for <linux-kernel@vger.kernel.org>; Wed, 10 Aug 2022 19:23:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=KeCtfJVGipygRLI4b2K/87eW4TfAIQBTxBLgAlvv57E=;
        b=XlT8SMVpqRixhv9RUiLUONNOpM0V4QREHr9wR0M3Gu8njAL5HK2ZHjLcT4xuZ+aIWp
         NNJ/k6NH2PhQpQrR6RNp//YWhGF5VSyNKknwQKxHCxDOTnEbqaxUOlRMqRiEXMPXSGDH
         s7nhvvgWXrqtv2YooI33AFmqGeR2V9Js0MBsc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=KeCtfJVGipygRLI4b2K/87eW4TfAIQBTxBLgAlvv57E=;
        b=MpXftOpSWrHi1BEQbCD1lT3dsCAuoYD4LmiN2lMtZsV4gfioKVjSABe8yafWSCg/NO
         HGwsHdA7D9G77+Hs9N1ne5alzhuTxA2L3U34XCKwSWwwsVBI2p4htvssw+ly0mdJ/GjN
         aiWlg6t6B/cYvKml46IYSK7Lvt+upRwaqBzr/wmog915Dgn2PK+THO8898v5jDje/hYJ
         uzY2Bn+gMbSp6hzZAggb/qZ4dXIKZHk0Gc7KU2Ald+9mhouiF4Hdae8bAVes80wtD5a9
         HGMPvOLc8w7YqIKtf/G/PJaMHdvEDs6EsYwlpsMiIz46dNyOC27zMBhWXRSTmPJKj2Mu
         iPYQ==
X-Gm-Message-State: ACgBeo3f8VAdA29niaDloPRu4iYWdRVPxmiC/lHWu9O64b/c1+ij+uUp
        cuMBjAx9k8XZcxIy0Rli34yiDHm4rC0L0A==
X-Google-Smtp-Source: AA6agR6/554YftGgl4/zNuuoj6JeA7z++IJojImf7c63cJx7/nqpF0XLCLo0oG8SqKHTg40yH7hiAA==
X-Received: by 2002:a05:620a:1a26:b0:6b5:cd80:a627 with SMTP id bk38-20020a05620a1a2600b006b5cd80a627mr23301150qkb.145.1660184606537;
        Wed, 10 Aug 2022 19:23:26 -0700 (PDT)
Received: from [10.0.0.40] (c-73-148-104-166.hsd1.va.comcast.net. [73.148.104.166])
        by smtp.gmail.com with ESMTPSA id m7-20020a05622a054700b0031ea864d3b2sm976134qtx.30.2022.08.10.19.23.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Aug 2022 19:23:26 -0700 (PDT)
Message-ID: <308db02b-b56d-2df1-ee33-7f66e6a85f63@joelfernandes.org>
Date:   Wed, 10 Aug 2022 22:23:23 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.0.2
Subject: Re: [PATCH v3 resend 0/6] Implement call_rcu_lazy() and miscellaneous
 fixes
Content-Language: en-US
To:     linux-kernel@vger.kernel.org
Cc:     rushikesh.s.kadam@intel.com, urezki@gmail.com,
        neeraj.iitr10@gmail.com, frederic@kernel.org, paulmck@kernel.org,
        rostedt@goodmis.org, rcu@vger.kernel.org
References: <20220809034517.3867176-1-joel@joelfernandes.org>
From:   Joel Fernandes <joel@joelfernandes.org>
In-Reply-To: <20220809034517.3867176-1-joel@joelfernandes.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/8/2022 11:45 PM, Joel Fernandes (Google) wrote:
> Just a refresh of v3 with one additional debug patch. v3's cover letter is here:
>  https://lore.kernel.org/all/20220713213237.1596225-1-joel@joelfernandes.org/
> 
> I just started working on this again while I have some time during paternity
> leave ;-) So I thought I'll just send it out again. No other changes other
> than that 1 debug patch I added on the top.
> 
> Next I am going to go refine the power results as mentioned in Paul's comments
> on the last cover letter.

Side note: Here is another big selling point for call_rcu_lazy().
Instead of _lazy(), if you just increased jiffies_till_first_fqs, and
slowed *all* call_rcu() down to achieve the same effect, that would
affect percpu refcounters switching to atomic-mode, for example.

They switch to atomic mode by calling __percpu_ref_switch_mode() which
is called by percpu_ref_switch_to_atomic_sync().

This will slow this call down for the full lazy duration which will slow
down suspend in blk_pre_runtime_suspend().

This is why, we cannot assume call_rcu() users will mostly just want to
free memory. There could be cases just like this, and just blanket slow
down of call_rcu() might bite at unexpected times.

I am going to add this as a selling point for selective lazyfication
(hey I get to invent words while I'm inventing new features), to my
cover letter and slides.

 - Joel



> 
> Joel Fernandes (Google) (5):
> rcu: Introduce call_rcu_lazy() API implementation
> rcuscale: Add laziness and kfree tests
> fs: Move call_rcu() to call_rcu_lazy() in some paths
> rcutorture: Add test code for call_rcu_lazy()
> debug: Toggle lazy at runtime and change flush jiffies
> 
> Vineeth Pillai (1):
> rcu: shrinker for lazy rcu
> 
> fs/dcache.c                                   |   4 +-
> fs/eventpoll.c                                |   2 +-
> fs/file_table.c                               |   2 +-
> fs/inode.c                                    |   2 +-
> include/linux/rcu_segcblist.h                 |   1 +
> include/linux/rcupdate.h                      |   6 +
> include/linux/sched/sysctl.h                  |   3 +
> kernel/rcu/Kconfig                            |   8 +
> kernel/rcu/rcu.h                              |  12 +
> kernel/rcu/rcu_segcblist.c                    |  15 +-
> kernel/rcu/rcu_segcblist.h                    |  20 +-
> kernel/rcu/rcuscale.c                         |  74 +++++-
> kernel/rcu/rcutorture.c                       |  60 ++++-
> kernel/rcu/tree.c                             | 131 ++++++----
> kernel/rcu/tree.h                             |  10 +-
> kernel/rcu/tree_nocb.h                        | 246 +++++++++++++++---
> kernel/sysctl.c                               |  17 ++
> .../selftests/rcutorture/configs/rcu/CFLIST   |   1 +
> .../selftests/rcutorture/configs/rcu/TREE11   |  18 ++
> .../rcutorture/configs/rcu/TREE11.boot        |   8 +
> 20 files changed, 536 insertions(+), 104 deletions(-)
> create mode 100644 tools/testing/selftests/rcutorture/configs/rcu/TREE11
> create mode 100644 tools/testing/selftests/rcutorture/configs/rcu/TREE11.boot
> 
> --
> 2.37.1.559.g78731f0fdb-goog
> 
