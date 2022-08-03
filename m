Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23071589113
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Aug 2022 19:15:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236466AbiHCRPA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Aug 2022 13:15:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231966AbiHCRO5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Aug 2022 13:14:57 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82C0452DF1
        for <linux-kernel@vger.kernel.org>; Wed,  3 Aug 2022 10:14:56 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id i128-20020a1c3b86000000b003a3a22178beso1242844wma.3
        for <linux-kernel@vger.kernel.org>; Wed, 03 Aug 2022 10:14:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=/3dZwuNcVuE6d4zZ4aeM7vczIq122Gxcmf/snpYWoTY=;
        b=mPMYv2iq+jQ125BM8udKcXg+4UXDUxtCzILO4KDgG2s/BTserP7tB3r3NA5sSNeF8s
         rk6+S5fx5uPlv3ra/ZnGdMNnTlQNdGFBpfJ41cJOOW2aMpTr/iYT39Xm3EX/TR7Bo4lL
         KnmmITXsvrMEmT1q3pMchyeyttE7Mrr7bmPKq91MNTApqCV21DIfuCNmU5UBdhgyxmZc
         yFrvKwYcu+g2e7uz9Cs3Or45aP1Wm7zvr+hFyDAGklIcXAgEIAJLUo9EnvpdtipC9+Fp
         Ggg0A6FSa7vcTAQhiC3yU3PMjRmcyYxH7L0YP7+coxzPBaavyoCIz/n2eHitOO7QHOcO
         1xoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=/3dZwuNcVuE6d4zZ4aeM7vczIq122Gxcmf/snpYWoTY=;
        b=UvKMzxPWQmUcZ45qQ7kowTQPYpQpqIaa5kUGyUteRTeDCV1XRuxo5XAOXBkjO4puqY
         LqpCpPHW0/4a2EwaXXgWiRS8YT0d9v5YQlKq3fxq0StYeguy8qM+a2YrEru97QPub2DA
         BzFYNj/q2dfQmVv1+j7qyvZrJafaMVQUmBOzLzID/pko/KECqKocgBQ0rn4HjjBRn++C
         NWDZq9L+5dA2jh0lVhQiVKi0MuIPeEchcZMB+g0drkSxN5GzJ3LTwtXtBVnNrpDEMt6x
         yn2dvcZjhFmvjuA4YbvmWA74eK7rdzhE3TIX7SPQXI2EnAvFparWyPm/H4OtkDZlt57u
         uiQg==
X-Gm-Message-State: ACgBeo3nigL8r31H95cQuPOTb0FsNc6LknNNqS5xSs1V0PGrICfX4aF3
        1w292KK0CtEkxIBwmZprfZE=
X-Google-Smtp-Source: AA6agR5+RQSgYBJ0NnS/al6TqBCjjlkbnQCxVl7Uvy5WWLOldcxAvdFQeWzPgyNRhGVwpiqbpD8hTQ==
X-Received: by 2002:a05:600c:1d1b:b0:3a3:e2:42d1 with SMTP id l27-20020a05600c1d1b00b003a300e242d1mr3547004wms.137.1659546895132;
        Wed, 03 Aug 2022 10:14:55 -0700 (PDT)
Received: from gmail.com (84-236-113-167.pool.digikabel.hu. [84.236.113.167])
        by smtp.gmail.com with ESMTPSA id u11-20020a05600c19cb00b003a302fb9df7sm3438954wmq.21.2022.08.03.10.14.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Aug 2022 10:14:54 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Wed, 3 Aug 2022 19:14:52 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Liu Song <liusong@linux.alibaba.com>, mingo@redhat.com,
        peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        bsegall@google.com, mgorman@suse.de, bristot@redhat.com,
        vschneid@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sched/debug: avoid executing show_state and causing rcu
 stall warning
Message-ID: <YuqtDA4NY/8Z22aK@gmail.com>
References: <1659489525-82994-1-git-send-email-liusong@linux.alibaba.com>
 <20220803084235.5d56d1e4@gandalf.local.home>
 <20220803140653.GD2125313@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220803140653.GD2125313@paulmck-ThinkPad-P17-Gen-1>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Paul E. McKenney <paulmck@kernel.org> wrote:

> There is an rcu_sysrq_start() and rcu_sysrq_end() to suppress this.  
> These are invoked by __handle_sysrq().  The value of 
> rcu_cpu_stall_suppress should be non-zero during the sysrq execution, and 
> this should prevent RCU CPU stall warnings from being printed.
> 
> That said, the code currently does not support overlapping calls to the 
> various functions that suppress RCU CPU stall warnings.  Except that the 
> only other use in current mainline is rcu_panic(), which never 
> unsuppresses.
> 
> So could you please check the value of rcu_cpu_stall_suppress? Just in 
> case some other form of suppression was added somewhere that I missed?

So instead of supressing the (justified!) RCU stall messages, I'd much 
rather we apply only the minimal locking necessary for this debug printout.

That should also solve the stall warnings as a side effect.

Thanks,

	Ingo
