Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02DC04DCD2F
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 19:09:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237261AbiCQSKj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 14:10:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237194AbiCQSKW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 14:10:22 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 946C812B749
        for <linux-kernel@vger.kernel.org>; Thu, 17 Mar 2022 11:09:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1647540544;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=qyvEicvZsthPeXhIK1mEJ7p6TnH+7Rc2hbOq6UcgGIo=;
        b=GajNlf5N4ofj0Jnoud0jF2CVeCfivuSnqnx46Lm2gD00LQdKwik2I/ud2Ip0dDBjf5aFHX
        eCghit4Iv5Oems6XzuqCClgDFqDhiKTE5sCHSLYhV1TrumTntQaPNL/sWF49/Cm2OPa6UD
        NPdEY6zjHXGBkouVpHurQb1GPhIo4Io=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-100-mhvfhfvMOraTaGW7IL9Elw-1; Thu, 17 Mar 2022 14:09:01 -0400
X-MC-Unique: mhvfhfvMOraTaGW7IL9Elw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id DA1F31C05152;
        Thu, 17 Mar 2022 18:09:00 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.40.192.69])
        by smtp.corp.redhat.com (Postfix) with SMTP id 98AA140FF40F;
        Thu, 17 Mar 2022 18:08:58 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Thu, 17 Mar 2022 19:09:00 +0100 (CET)
Date:   Thu, 17 Mar 2022 19:08:57 +0100
From:   Oleg Nesterov <oleg@redhat.com>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Alexey Gladkov <legion@kernel.org>,
        Kyle Huey <me@kylehuey.com>, Kees Cook <keescook@chromium.org>,
        Al Viro <viro@ZenIV.linux.org.uk>, linux-api@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH 2/2] ptrace: Return the signal to continue with from
 ptrace_stop
Message-ID: <20220317180856.GB13318@redhat.com>
References: <87a6ha4zsd.fsf@email.froward.int.ebiederm.org>
 <87bl1kunjj.fsf@email.froward.int.ebiederm.org>
 <87r19opkx1.fsf_-_@email.froward.int.ebiederm.org>
 <87o82gdlu9.fsf_-_@email.froward.int.ebiederm.org>
 <87tubyx0rg.fsf_-_@email.froward.int.ebiederm.org>
 <875yoe7qdp.fsf_-_@email.froward.int.ebiederm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <875yoe7qdp.fsf_-_@email.froward.int.ebiederm.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.84 on 10.11.54.2
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Not sure I understand this patch, I can't apply it. I guess I need to
clone your tree first, will do later.

Just one question right now,

On 03/15, Eric W. Biederman wrote:
>
> +static int ptrace_stop(int exit_code, int why, int clear_code,
>  			unsigned long message, kernel_siginfo_t *info)
>  	__releases(&current->sighand->siglock)
>  	__acquires(&current->sighand->siglock)
>  {
>  	bool gstop_done = false;
> +	bool read_code = true;
>  
>  	if (arch_ptrace_stop_needed()) {
>  		/*
> @@ -2305,8 +2307,9 @@ static void ptrace_stop(int exit_code, int why, int clear_code,
>  
>  		/* tasklist protects us from ptrace_freeze_traced() */
>  		__set_current_state(TASK_RUNNING);
> +		read_code = false;
>  		if (clear_code)
> -			current->exit_code = 0;
> +			exit_code = 0;
>  		read_unlock(&tasklist_lock);
>  	}
>  
> @@ -2316,8 +2319,10 @@ static void ptrace_stop(int exit_code, int why, int clear_code,
>  	 * any signal-sending on another CPU that wants to examine it.
>  	 */
>  	spin_lock_irq(&current->sighand->siglock);
> +	if (read_code) exit_code = current->exit_code;

style ;)

>  	current->last_siginfo = NULL;
>  	current->ptrace_message = 0;
> +	current->exit_code = 0;

OK, I like it... but can't we remove the ugly "int clear_code" arg?

Oleg.

