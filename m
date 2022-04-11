Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41BCC4FBDC2
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 15:49:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346728AbiDKNve (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 09:51:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346713AbiDKNv3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 09:51:29 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 748BBE9E;
        Mon, 11 Apr 2022 06:49:11 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id j9so18674166lfe.9;
        Mon, 11 Apr 2022 06:49:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=PkN/YPLKEZdAM9V2FBeosmLHfRbFWABiz3XxuNQjD+Q=;
        b=SUa8CsoXr03RR4kN8/AInlQTgRpEOGYqWTb9Zxb7/5p/yEUdMM2fjjjPyPAKoIpIJg
         EV9HX17csYvmT0J64+tSBnfWSnykGRbwpwYRn1EcXEM/xcsIILq+mtPCUzoZSx4iKYPM
         GjsVzngnHmg++K80BJyPFdTYu5pOQv4JHK3rjB3mlfnqMrFicLj5TZccQthnyfeKJd38
         KAQ77FFjemO+SqXEmCupiq829SKgmu9eh/Rwed1izkYr1hDhuR9OYmaTm3xHUdblIkEy
         a1KVa+8thyl4t6inpPBxz31Pi5XfiyDfnCMdd3PWd9DDAwUNLHZEE4Rt1lLp1LYgCauN
         rv/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=PkN/YPLKEZdAM9V2FBeosmLHfRbFWABiz3XxuNQjD+Q=;
        b=0YK49eyfXeWpyAkel+NmVAb5kpcdgEgljus4Eq/mwxrJSVqZWJzvOKUwfCGIUMKJL7
         qc8/gLQWwzWluvbGg5EQUpeNQBATNKMNxh/cZHb7gC8wUlpBMfjb9jJsYUSETZPCTFOJ
         SBon+ssnjELpEnCwu+hujTbRcOH6rkYKthZOdvdTUKtzh+bOcKiqhP5KLfyZbQ6eE93v
         qqaKnBAZ1DCGyR4bEg+Z8zVfnl226s59SNr5K4bEYQ9D6cf5lYPag5EnrGML0JqJ8Rah
         e0hDSTgczF985K20P1E2T+C1+bDi+FWwHMcwCLzf23rIAreOx4bNXJHRgO6iZgcms/Q+
         CA8w==
X-Gm-Message-State: AOAM531Saa2HaW5VwyD7QQHEOrgvqrI7iwf+Bbk84ULj2xIl25KrAVPJ
        v+rgjClaRc4e7f6bJvB7vFJ46ZRofxFOqQ==
X-Google-Smtp-Source: ABdhPJxYxVWC7yPU+iEIvG36S2hNqTVv6gc7ajosdoq3FqOkz7lrnRoqMCiDKXtlA1Yql4QYfLl1cQ==
X-Received: by 2002:a05:6512:13a3:b0:44a:6ac3:754d with SMTP id p35-20020a05651213a300b0044a6ac3754dmr20912101lfa.92.1649684949553;
        Mon, 11 Apr 2022 06:49:09 -0700 (PDT)
Received: from pc638.lan ([155.137.26.201])
        by smtp.gmail.com with ESMTPSA id f20-20020a056512229400b0044a6ac1af69sm3323340lfu.181.2022.04.11.06.49.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Apr 2022 06:49:08 -0700 (PDT)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc638.lan>
Date:   Mon, 11 Apr 2022 15:49:06 +0200
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     linux-kernel@vger.kernel.org,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        "Paul E. McKenney" <paulmck@kernel.org>, rcu@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH RFC] rcu/nocb: Provide default all-CPUs mask for
 RCU_NOCB_CPU=y
Message-ID: <YlQx0rZzrdWIA5w+@pc638.lan>
References: <20220407210734.2548973-1-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220407210734.2548973-1-joel@joelfernandes.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, Joel.

> On systems with CONFIG_RCU_NOCB_CPU=y, there is no default mask provided
> which ends up not offloading any CPU. This patch removes yet another
> dependency from the bootloader having to know about RCU, about how many
> CPUs the system has, and about how to provide the mask. Basically, I
> think we should stop pretending that the user knows what they are doing :).
> In other words, if NO_CB_CPU is enabled, lets make use of it.
> 
Could you also please modify the documentation accordingly and send v2?

<snip>
urezki@pc638:~/data/raid0/coding/linux-rcu.git$ grep -rn RCU_NOCB_CPU ./Documentation/
./Documentation/timers/no_hz.rst:188:using the CONFIG_RCU_NOCB_CPU=y Kconfig option.  The specific CPUs to
./Documentation/admin-guide/kernel-parameters.txt:4380:                 In kernels built with CONFIG_RCU_NOCB_CPU=y,
./Documentation/admin-guide/kernel-parameters.txt:4507:                 When RCU_NOCB_CPU is set, also adjust the
./Documentation/admin-guide/kernel-per-CPU-kthreads.rst:311:3.  Build with CONFIG_RCU_NOCB_CPU=y and boot with the rcu_nocbs=
./Documentation/admin-guide/kernel-per-CPU-kthreads.rst:331:2.  Build with CONFIG_RCU_NOCB_CPU=n, which will prevent these
./Documentation/RCU/Design/Requirements/Requirements.rst:1424:``CONFIG_RCU_NOCB_CPU=y`` and booted with ``rcu_nocbs=1-63``, where
urezki@pc638:~/data/raid0/coding/linux-rcu.git$ grep -rn RCU_NOCB_CPU ./kernel/rcu/
...
./kernel/rcu/Kconfig:198:config RCU_NOCB_CPU
..
<snip>

--
Uladzislau Rezki
