Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE1A54D6065
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 12:09:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348131AbiCKLK2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 06:10:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231795AbiCKLK0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 06:10:26 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E065561A26;
        Fri, 11 Mar 2022 03:09:23 -0800 (PST)
Date:   Fri, 11 Mar 2022 12:09:20 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1646996961;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=GK5kqQHemVr2nXivfkjnq6IRlHLXNPENtFaPEUWb0P4=;
        b=ad3UiFEfhH+4RXD/hpf46e5ECQWj/Z1RqlaFGYMMEcYiorHhiGuCryu6thV8/L2uUgxjeL
        42CNfwEsieKykSqNUfvKkYJ83cjHYX5tqNZYKK173NWdf7at/0NPuou15FlEUmEmZVBNtB
        Fk0CAlcKsw08uI5eodJ7Nu5oKtDW/znS6hn9PgPWzhN0qpablQMpRqGk4DF+sNN4N/yznr
        squSQqJnAPJs0DrkYHRq8FSqaIhIbMylP80aus7/DXVV/Gq/kv47ur14Eh/LFii4QQBmjC
        yTv0eVxECi4MjIKQZFYnxdIKSwNwAoZw+51DqJPKI5ahz+DlxW9d4UxHjjAN6Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1646996961;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=GK5kqQHemVr2nXivfkjnq6IRlHLXNPENtFaPEUWb0P4=;
        b=xHH/2VCt8STQSu3zB4FWCZYCKuTMxJ2xW+C6eL9K/PrgA4zapU31shzdqy57OmeQWF3R9g
        OA4PkFL6MlRTsoCw==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Zqiang <qiang1.zhang@intel.com>
Cc:     paulmck@kernel.org, frederic@kernel.org, urezki@gmail.com,
        quic_neeraju@quicinc.com, josh@joshtriplett.org,
        juri.lelli@redhat.com, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] rcu: Only boost rcu reader tasks with lower priority
 than boost kthreads
Message-ID: <Yist4IWWR/6BZzeK@linutronix.de>
References: <20220311022226.595905-1-qiang1.zhang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220311022226.595905-1-qiang1.zhang@intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-03-11 10:22:26 [+0800], Zqiang wrote:
> When RCU_BOOST is enabled, the boost kthreads will boosting readers
> who are blocking a given grace period, if the current reader tasks
                                       ^ Period.

> have a higher priority than boost kthreads(the boost kthreads priority
> not always 1, if the kthread_prio is set), 

This confuses me:
- Why does this matter
- If it is not RT prio, what is then? Higher or lower? Afaik it is
  always >= 1.

> boosting is useless, skip
> current task and select next task to boosting, reduce the time for a
> given grace period.

So if the task, that is stuck in a rcu_read() section, has a higher
priority than the boosting thread then boosting is futile. Understood.

Please correct me if I'm wrong but this is intended for !SCHED_OTHER
tasks since there shouldn't a be PI chain on boost_mtx so that its
default RT priority is boosted above what has been configured.

You skip boosting tasks which are itself already boosted due to a PI
chain. Once that PI boost is lifted the task may still be in a RCU
section. But if I understand you right, your intention is skip boosting
tasks with a higher priority and concentrate and those which are in
need. This shouldn't make a difference unless the scheduler is able to
move the rcu-boosted task to another CPU.

Am I right so far? If so this should be part of the commit message (the
intention and the result). Also, please add that part with
boost_exp_tasks. The comment above boost_mtx is now above
boost_exp_tasks with a space so it looks (at least to me) like these two
don't belong together.

> Suggested-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
> Signed-off-by: Zqiang <qiang1.zhang@intel.com>

Sebastian
