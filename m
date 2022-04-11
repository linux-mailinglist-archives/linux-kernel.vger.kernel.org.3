Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B90004FC03C
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 17:19:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347762AbiDKPUZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 11:20:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347608AbiDKPUV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 11:20:21 -0400
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5015326E4
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 08:18:06 -0700 (PDT)
Received: by mail-io1-xd30.google.com with SMTP id p21so19110305ioj.4
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 08:18:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Qxxqdzsm5NNvKuddue8zfK73fgd0MVUdg9etiRzf7DY=;
        b=gOztIOTJCTDJDS0gZRh6PiXx3DtEHbXV0VsbvU5swCYUaAQYltS3JN/06k00LN+Wfp
         Q3AeuhuUlXCCgShBxW2ELxPF/Q20PTQpuLzhwQRCIdkti08VI+7tVafICMNE2B2P7Ysb
         4hc3a2NrVX4muD6KhVlsiEhObJYy/cJUnJJtY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Qxxqdzsm5NNvKuddue8zfK73fgd0MVUdg9etiRzf7DY=;
        b=hW5EHvyBCxbHmD/vTkzu316PLMUXB0ICaF94ycm2ZAcvIdHrNegD///brMKuvq++6Y
         kmv1BzxR1GKXNX05lsAKWNiisEzDIyupzL+3/MM5AetQq2WrUYpgP22RiY+u6ykFPdGd
         DTYYF7yHpJjfItKcrYZ6tA65uDYuPNbNdvPfQJFFTyaZi8WndNSI1kewe4XjeVWhNpx0
         cqVmkzhd36VGXZ2cs6Yth4Y8LweOwide0wsjS8dWH5UTy6PjztiZFVFvZIO5FNc5LW60
         FyWzlzUZd9Bhjq79l25ZZLuoxUNLIL9kGIKkx5T4Q6TJiNafgq8Dcf5Mbb6FVuYh619Y
         4+2g==
X-Gm-Message-State: AOAM531UIpQ0eN41aJnIJYQiWj0xvtvheXf239i9XhAiNfDTrbhHyeeR
        aONyzQ2idlPtGoTwJHxhazUpUrxcoMZj0tRu7js/Sw==
X-Google-Smtp-Source: ABdhPJyTacRRyhXpUmMsFf0hOhTvn/aPNyPMKJSLnnAgP89m51SL+egsDhPkNYhtboj1sxiUJnHKWrhMT7chg4SYG9s=
X-Received: by 2002:a5d:94c2:0:b0:60b:bd34:bb6f with SMTP id
 y2-20020a5d94c2000000b0060bbd34bb6fmr13306775ior.32.1649690285953; Mon, 11
 Apr 2022 08:18:05 -0700 (PDT)
MIME-Version: 1.0
References: <20220407210734.2548973-1-joel@joelfernandes.org> <YlQx0rZzrdWIA5w+@pc638.lan>
In-Reply-To: <YlQx0rZzrdWIA5w+@pc638.lan>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Mon, 11 Apr 2022 11:17:56 -0400
Message-ID: <CAEXW_YRu8z0tHn0nOpzd4PtsL0vKpgSuN86CgwXeWCEEiXbaog@mail.gmail.com>
Subject: Re: [PATCH RFC] rcu/nocb: Provide default all-CPUs mask for RCU_NOCB_CPU=y
To:     Uladzislau Rezki <urezki@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        "Paul E. McKenney" <paulmck@kernel.org>, rcu <rcu@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 11, 2022 at 9:49 AM Uladzislau Rezki <urezki@gmail.com> wrote:
>
> Hello, Joel.
>
> > On systems with CONFIG_RCU_NOCB_CPU=y, there is no default mask provided
> > which ends up not offloading any CPU. This patch removes yet another
> > dependency from the bootloader having to know about RCU, about how many
> > CPUs the system has, and about how to provide the mask. Basically, I
> > think we should stop pretending that the user knows what they are doing :).
> > In other words, if NO_CB_CPU is enabled, lets make use of it.
> >
> Could you also please modify the documentation accordingly and send v2?

Yes good point, I can go clean that up in v2.

 - Joel

> <snip>
> urezki@pc638:~/data/raid0/coding/linux-rcu.git$ grep -rn RCU_NOCB_CPU ./Documentation/
> ./Documentation/timers/no_hz.rst:188:using the CONFIG_RCU_NOCB_CPU=y Kconfig option.  The specific CPUs to
> ./Documentation/admin-guide/kernel-parameters.txt:4380:                 In kernels built with CONFIG_RCU_NOCB_CPU=y,
> ./Documentation/admin-guide/kernel-parameters.txt:4507:                 When RCU_NOCB_CPU is set, also adjust the
> ./Documentation/admin-guide/kernel-per-CPU-kthreads.rst:311:3.  Build with CONFIG_RCU_NOCB_CPU=y and boot with the rcu_nocbs=
> ./Documentation/admin-guide/kernel-per-CPU-kthreads.rst:331:2.  Build with CONFIG_RCU_NOCB_CPU=n, which will prevent these
> ./Documentation/RCU/Design/Requirements/Requirements.rst:1424:``CONFIG_RCU_NOCB_CPU=y`` and booted with ``rcu_nocbs=1-63``, where
> urezki@pc638:~/data/raid0/coding/linux-rcu.git$ grep -rn RCU_NOCB_CPU ./kernel/rcu/
> ...
> ./kernel/rcu/Kconfig:198:config RCU_NOCB_CPU
> ..
> <snip>
>
> --
> Uladzislau Rezki
