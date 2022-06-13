Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AAFB5494B7
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 18:33:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242801AbiFMPSy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 11:18:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345984AbiFMPSM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 11:18:12 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88098127198
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jun 2022 05:36:21 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1655123778;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=vhsJGvgbTSULjQe9rAN8kAWgucSRuf4nK7/LbKJ59/c=;
        b=I1SKlwy+9Kr7dqrHKzQUy6+PxcNNEYDymTHhdH3g3oaFVGG2Tor/fsRJ7nNSyJmOebK8nY
        Yg+UNT1knFyd4QukEpLSfdHSCYqgoXxtxQs8mVFdtMi4yqieqJiFn8ie/gVJXt7X6V0vvM
        RyM5ZfwiRSOvT8zv9cNMNRFpvBw3ldBFeP4zPkB2uqIh1AHIhdwfbb83KfsE/v15Yvdp/c
        Cc1Fcr0/LQahMBhUfccpbgEmzZZRAc6VWBIXZlWujd59nHYjzxDDAbZFqA6+MaDDungHyS
        q6Ltz9WXAOuvQHkwT9Msmwqx/iBX9HhFsVRK1HcT7pJ8ZYEtgNxfwUVLudwfTA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1655123778;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=vhsJGvgbTSULjQe9rAN8kAWgucSRuf4nK7/LbKJ59/c=;
        b=9MEwiMhM5UEMaUZkRQU35aVcyFuKS9lYU0Z++F6KDQY5asSh4Znd3UPaegf9MOzlwDl/60
        isCCJNyNnuIBbcCA==
To:     Vincent Donnefort <vdonnefort@google.com>, peterz@infradead.org
Cc:     linux-kernel@vger.kernel.org, vschneid@redhat.com,
        kernel-team@android.com, Vincent Donnefort <vdonnefort@google.com>,
        Derek Dolney <z23@posteo.net>
Subject: Re: [PATCH v2] cpu/hotplug: Do not bail-out in DYING/STARTING sections
In-Reply-To: <20220523160536.2889162-1-vdonnefort@google.com>
References: <20220523160536.2889162-1-vdonnefort@google.com>
Date:   Mon, 13 Jun 2022 14:36:18 +0200
Message-ID: <87mteg3flp.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Vincent,

On Mon, May 23 2022 at 17:05, Vincent Donnefort wrote:
> +static int _cpuhp_invoke_callback_range(bool bringup,
> +					unsigned int cpu,
> +					struct cpuhp_cpu_state *st,
> +					enum cpuhp_state target,
> +					bool nofail)
>  {
>  	enum cpuhp_state state;
> -	int err = 0;
> +	int ret = 0;
>  
>  	while (cpuhp_next_state(bringup, &state, st, target)) {
> +		int err;
> +
>  		err = cpuhp_invoke_callback(cpu, state, bringup, NULL, NULL);
> -		if (err)
> +		if (!err)
> +			continue;
> +
> +		if (nofail) {
> +			pr_warn("CPU %u %s state %s (%d) failed (%d)\n",
> +				cpu, bringup ? "UP" : "DOWN",
> +				cpuhp_get_step(st->state)->name,
> +				st->state, err);
> +			ret = -1;

I have a hard time to map this to the changelog:

> those sections. In that case, there's nothing the hotplug machinery can do,
> so let's just proceed and log the failures.

That's still returning an error code at the end. Confused.

Thanks,

        tglx
