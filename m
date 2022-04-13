Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F5F44FF792
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 15:25:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235739AbiDMN11 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 09:27:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235728AbiDMN1Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 09:27:25 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0338152B12
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 06:25:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649856302;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=X4mDClISUBAr0O67B/LksnVAGP1eJFmEICVY8cBIZy0=;
        b=OZZr7GPfKId2rWhIeC2ddMbr3gXcZlRfYLtNkMWQgXbFl5kLT66toRlGoXAXSDWx/4NKPm
        eUdskKSJ9isRyB0rf8+2JEZ6YS8glU/YS0u5VWb1zPyNKggfxG+aVrVeVj/G0qfuRsgG/G
        tIhaVMLnxIwlWaEnE1aKGPFacbgXrxc=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-108-JssMX-eJPV6qodjEdwpUeg-1; Wed, 13 Apr 2022 09:24:58 -0400
X-MC-Unique: JssMX-eJPV6qodjEdwpUeg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3A93D1066559;
        Wed, 13 Apr 2022 13:24:57 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.40.193.165])
        by smtp.corp.redhat.com (Postfix) with SMTP id 0A2D0404776F;
        Wed, 13 Apr 2022 13:24:53 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Wed, 13 Apr 2022 15:24:56 +0200 (CEST)
Date:   Wed, 13 Apr 2022 15:24:52 +0200
From:   Oleg Nesterov <oleg@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     rjw@rjwysocki.net, mingo@kernel.org, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, mgorman@suse.de,
        ebiederm@xmission.com, bigeasy@linutronix.de,
        Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
        tj@kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH 2/5] sched,ptrace: Fix ptrace_check_attach() vs PREEMPT_RT
Message-ID: <20220413132451.GA27281@redhat.com>
References: <20220412114421.691372568@infradead.org>
 <20220412114853.842942162@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220412114853.842942162@infradead.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.84 on 10.11.54.2
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter,

I like 1-2 but I need to read them (and other patches) again, a
couple of nits right now.

On 04/12, Peter Zijlstra wrote:
>
> +static int __ptrace_freeze_cond(struct task_struct *p)
> +{
> +	if (!task_is_traced(p))
> +		return -ESRCH;

	if (!task_is_traced(p) || p->parent != current)
		return -ESRCH;

we should not spin/sleep if it is traced by another task

> +static int __ptrace_freeze(struct task_struct *p, void *arg)
> +{
> +	int ret;
> +
> +	ret = __ptrace_freeze_cond(p);
> +	if (ret)
> +		return ret;
> +
> +	/*
> +	 * Task scheduled between __ptrace_pre_freeze() and here, not our task
> +	 * anymore.
> +	 */
> +	if (*(unsigned long *)arg != p->nvcsw)
> +		return -ESRCH;
> +
> +	if (looks_like_a_spurious_pid(p))
> +		return -ESRCH;

Oh, I do not think __ptrace_freeze() should check for spurious pid...
looks_like_a_spurious_pid() should be called once in ptrace_check_attach()
before task_call_func(__ptrace_freeze).

Oleg.

