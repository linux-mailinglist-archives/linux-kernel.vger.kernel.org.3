Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E06751C3F2
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 17:28:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381360AbiEEPcB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 11:32:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234496AbiEEPb5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 11:31:57 -0400
Received: from us-smtp-delivery-74.mimecast.com (us-smtp-delivery-74.mimecast.com [170.10.129.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D11015BE7B
        for <linux-kernel@vger.kernel.org>; Thu,  5 May 2022 08:28:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1651764496;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=z8QO9rJ6Ts0Rv2clyS7GURk3RsnaSaH+6/9cSSyBhyU=;
        b=FFjXZF5MP++woieIEOoJ6d9SrfLRk06r3a2mE0FeaxbmQS5VPt3ZfK6Jh4Ql/ABBvSAehi
        XynA/4XeLi6OOfczCsFNX2Qxe8bZjal7fzaeXIzW9apfBGzzZH4zwd7dTwUKVlTS8grJob
        XZxGhe+gcR1te3o0I4dQn6MxGGbqzlI=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-561-xGvgZpQGM86kqzNUweA2yQ-1; Thu, 05 May 2022 11:28:13 -0400
X-MC-Unique: xGvgZpQGM86kqzNUweA2yQ-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3ADD885A5A8;
        Thu,  5 May 2022 15:28:12 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.40.192.3])
        by smtp.corp.redhat.com (Postfix) with SMTP id 1A398463EDE;
        Thu,  5 May 2022 15:28:06 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Thu,  5 May 2022 17:28:11 +0200 (CEST)
Date:   Thu, 5 May 2022 17:28:03 +0200
From:   Oleg Nesterov <oleg@redhat.com>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     linux-kernel@vger.kernel.org, rjw@rjwysocki.net, mingo@kernel.org,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, mgorman@suse.de, bigeasy@linutronix.de,
        Will Deacon <will@kernel.org>, tj@kernel.org,
        linux-pm@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
        Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        linux-um@lists.infradead.org, Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>,
        linux-xtensa@linux-xtensa.org, Kees Cook <keescook@chromium.org>,
        Jann Horn <jannh@google.com>, linux-ia64@vger.kernel.org
Subject: Re: [PATCH v3 08/11] ptrace: Admit ptrace_stop can generate spuriuos
 SIGTRAPs
Message-ID: <20220505152801.GC13929@redhat.com>
References: <87k0b0apne.fsf_-_@email.froward.int.ebiederm.org>
 <20220504224058.476193-8-ebiederm@xmission.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220504224058.476193-8-ebiederm@xmission.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.10
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/04, Eric W. Biederman wrote:
>
> -static int ptrace_stop(int exit_code, int why, int clear_code,
> -			unsigned long message, kernel_siginfo_t *info)
> +static int ptrace_stop(int exit_code, int why, unsigned long message,
> +		       kernel_siginfo_t *info)

Forgot to mention... but in general I like this change.

In particular, I like the fact it kills the ugly "int clear_code" arg
which looks as if it solves the problems with the exiting tracer, but
actually it doesn't. And we do not really care, imo.

Oleg.

