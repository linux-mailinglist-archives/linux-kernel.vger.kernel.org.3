Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EFDA0472CCA
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 14:06:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237094AbhLMNGk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 08:06:40 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:57384 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231837AbhLMNGj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 08:06:39 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E5B19B80ED5;
        Mon, 13 Dec 2021 13:06:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2BA89C34601;
        Mon, 13 Dec 2021 13:06:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639400796;
        bh=5DDNREbgZYf2Wb465q9DL6mzRWB+Z8LHhxEBmfk3qrk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SpMRuR5JGp88zDszictVmc1bG5OG3CEMB/w7h+X8vGUA7ZjqJy6ZMHSo3sYLCxomL
         aP955FXE0g5iEXRHKjyB3+W2QMszHm14s6qstnxKCj1iqR5VS47Ta15MrivV72/JRy
         GUmfh6nhgyHBqWhWUIsKaV0LyQnVGIrFHCIehvkZTJdH56pOiLLkOc5JL6Btjm99eZ
         CyV5gYHBWuHnbewpcz0ZTbRgIVufLZqJsVKFY6XfaKJGoo6jaUXamIKwUvc/ZXOY/E
         VHc8dczIB864pWVeUuF4YS4UhP94Brto0O9mqhNX0k/y5IXWdI2taWAfLzSpbegdGb
         nwDT5hRpEl3Kw==
Date:   Mon, 13 Dec 2021 14:06:33 +0100
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Neeraj Upadhyay <quic_neeraju@quicinc.com>
Cc:     paulmck@kernel.org, dwmw@amazon.co.uk, josh@joshtriplett.org,
        rostedt@goodmis.org, mathieu.desnoyers@efficios.com,
        jiangshanlai@gmail.com, joel@joelfernandes.org,
        rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        urezki@gmail.com, boqun.feng@gmail.com
Subject: Re: [PATCH] rcu: Make rcu_state.n_online_cpus updates atomic
Message-ID: <20211213130633.GC782195@lothringen>
References: <20211213070059.6381-1-quic_neeraju@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211213070059.6381-1-quic_neeraju@quicinc.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 13, 2021 at 12:30:59PM +0530, Neeraj Upadhyay wrote:
> To support onlining multiple CPUs concurrently,
> change rcu_state.n_online_cpus updates to be atomic.
> Note, it's ok for rcu_blocking_is_gp() to do a
> atomic_read(&rcu_state.n_online_cpus), as the
> value of .n_online_cpus switches from 1->2, in
> rcutree_prepare_cpu(), which runs before the new
> CPU comes online. Similarly 2->1 transition happens
> from rcutree_dead_cpu(), which executes after the
> CPU is offlined, and runs on the last online CPU.
> 
> Signed-off-by: Neeraj Upadhyay <quic_neeraju@quicinc.com>

That's a step but I can imagine much more complications to handle while looking
at rcutree_dead_cpu() VS rcutree_dead_cpu() (or other hotplug operations)
inside the same rnp calling rcu_boost_kthread_setaffinity() concurrently
or more generally rcu_boost_kthread_setaffinity() against concurrent onlining/offlining.

This function fetches the online CPUs to decide the affinity of boosting.
This can go quite wrong if CPUs can be concurrently onlined/offlined.

And I don't know how such problems are going to be solved in the future
but some new CPU hotplug concurrency primitives will be needed...

That's one more reason why I think it is a bit early to handle this wide problem...

Thanks.
