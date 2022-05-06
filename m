Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEEBC51DB9E
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 17:09:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442755AbiEFPNX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 May 2022 11:13:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442724AbiEFPNF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 May 2022 11:13:05 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8651C6D1A6
        for <linux-kernel@vger.kernel.org>; Fri,  6 May 2022 08:09:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1651849757;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=uan3YSckKD+F0UyoMcwlRwcC7eK4puADfdJggDA8Ug8=;
        b=J4LFNwMTAVdNxv0smgzrWR17rQGXWplFC5KJpNtrOzNuvPgJJF4SYgQSHRiQf/Ot+EKEMT
        zof64U+s/TQLPxWH5uKGQKBPijbJwBL+u01Q91gwEYaCTZRvHbuasv4vgjXfwEHRn8Qsb/
        8asoskWQSARsAPXWYevuNHavPbNdCxM=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-152-9PYLU4-DOXGJvQCz3IoESg-1; Fri, 06 May 2022 11:09:13 -0400
X-MC-Unique: 9PYLU4-DOXGJvQCz3IoESg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 549788039D7;
        Fri,  6 May 2022 15:09:11 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.40.192.95])
        by smtp.corp.redhat.com (Postfix) with SMTP id 91E7440CF8E8;
        Fri,  6 May 2022 15:09:05 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Fri,  6 May 2022 17:09:11 +0200 (CEST)
Date:   Fri, 6 May 2022 17:09:04 +0200
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
Subject: Re: [PATCH v4 10/12] ptrace: Don't change __state
Message-ID: <20220506150903.GB16084@redhat.com>
References: <87a6bv6dl6.fsf_-_@email.froward.int.ebiederm.org>
 <20220505182645.497868-10-ebiederm@xmission.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220505182645.497868-10-ebiederm@xmission.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.84 on 10.11.54.1
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/05, Eric W. Biederman wrote:
>
> --- a/include/linux/sched.h
> +++ b/include/linux/sched.h
> @@ -103,7 +103,7 @@ struct task_group;
>  /* Convenience macros for the sake of set_current_state: */
>  #define TASK_KILLABLE			(TASK_WAKEKILL | TASK_UNINTERRUPTIBLE)
>  #define TASK_STOPPED			(TASK_WAKEKILL | __TASK_STOPPED)
> -#define TASK_TRACED			(TASK_WAKEKILL | __TASK_TRACED)
> +#define TASK_TRACED			__TASK_TRACED

however I personally still dislike this change. But let me read the
code with this series applied, perhaps I will change my mind. If not,
I will argue ;)

Oleg.

