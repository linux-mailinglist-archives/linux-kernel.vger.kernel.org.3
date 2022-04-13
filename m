Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E51194FF7A0
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 15:29:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234449AbiDMNcB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 09:32:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231168AbiDMNbz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 09:31:55 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 38E2D13D50
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 06:29:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649856572;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=jVR0xl04hcA0VacEWvnMSieahQrpEf55RjhFHPhdvDg=;
        b=cQBPk+f+u4IGlBfWWD2W31dwmoJSgrpAnVBZJ9G2enyan3oEvm0ZtBIRWvDhgjpPOnaf9m
        usQ6vvf8iLrA/oHtLocJZFtZNgIMHL4UVsTDQBEHTgUd9EnoVDs9PZr0REQLgM3lVAUrez
        y+WyjwbHbTeaIuC5RdySWJbT0Ke5pD0=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-614-XIU68xWAMwayjNqMiYJaHA-1; Wed, 13 Apr 2022 09:29:27 -0400
X-MC-Unique: XIU68xWAMwayjNqMiYJaHA-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 26BEA86B8A3;
        Wed, 13 Apr 2022 13:29:27 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.40.193.165])
        by smtp.corp.redhat.com (Postfix) with SMTP id 115A2403151;
        Wed, 13 Apr 2022 13:29:23 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Wed, 13 Apr 2022 15:29:26 +0200 (CEST)
Date:   Wed, 13 Apr 2022 15:29:22 +0200
From:   Oleg Nesterov <oleg@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     rjw@rjwysocki.net, mingo@kernel.org, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, mgorman@suse.de,
        ebiederm@xmission.com, bigeasy@linutronix.de,
        Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
        tj@kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH 1/5] sched,signal,ptrace: Rework TASK_TRACED,
 TASK_STOPPED state
Message-ID: <20220413132922.GB27281@redhat.com>
References: <20220412114421.691372568@infradead.org>
 <20220412114853.782838521@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220412114853.782838521@infradead.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.10
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/12, Peter Zijlstra wrote:
>
> @@ -475,8 +483,10 @@ static int ptrace_attach(struct task_str
>  	 * in and out of STOPPED are protected by siglock.
>  	 */
>  	if (task_is_stopped(task) &&
> -	    task_set_jobctl_pending(task, JOBCTL_TRAP_STOP | JOBCTL_TRAPPING))
> +	    task_set_jobctl_pending(task, JOBCTL_TRAP_STOP | JOBCTL_TRAPPING)) {
> +		task->jobctl &= ~JOBCTL_STOPPED;
>  		signal_wake_up_state(task, __TASK_STOPPED);

OK, but just for record before I forget...

It seems that we can s/JOBCTL_STOPPED/JOBCTL_TRACED/ instead, and kill the
nasty wait_on_bit(JOBCTL_TRAPPING_BIT) along with JOBCTL_TRAPPING_BIT. Sure,
this doesn't belong to this series.

Oleg.

