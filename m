Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 553F3568655
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 13:04:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231986AbiGFLEt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 07:04:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbiGFLEr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 07:04:47 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 82ED0248F3
        for <linux-kernel@vger.kernel.org>; Wed,  6 Jul 2022 04:04:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1657105485;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=DjtM+f09ajeL/816t4d2wj4ORuro3gmTYQVu2O16CSU=;
        b=QlWw8dJiLS7TgVU2ELGIbJ2PuMM506akCxPx8zzXD+MYJL5w3hDU9fzj/CNy0/6ny6H7zQ
        X6W8n9+N5od9pkR678BoFQXEdiVtO365PjZ+9mkgoIIWQzKR4ZLhsKlLN33uD7vFWpxkzp
        HvRks/MFRXq92/XU26Kk7GujVSOPSdo=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-26-clXenRyRON-rALO6U4ju_A-1; Wed, 06 Jul 2022 07:04:42 -0400
X-MC-Unique: clXenRyRON-rALO6U4ju_A-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B1C9C296A62F;
        Wed,  6 Jul 2022 11:04:41 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.40.192.253])
        by smtp.corp.redhat.com (Postfix) with SMTP id ED8A4C44AE3;
        Wed,  6 Jul 2022 11:04:39 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Wed,  6 Jul 2022 13:04:41 +0200 (CEST)
Date:   Wed, 6 Jul 2022 13:04:38 +0200
From:   Oleg Nesterov <oleg@redhat.com>
To:     Sven Schnelle <svens@linux.ibm.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Kees Cook <keescook@chromium.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ptrace: fix clearing of JOBCTL_TRACED in
 ptrace_unfreeze_traced()
Message-ID: <20220706110438.GB9868@redhat.com>
References: <20220706101625.2100298-1-svens@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220706101625.2100298-1-svens@linux.ibm.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.8
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/06, Sven Schnelle wrote:
>
> --- a/kernel/ptrace.c
> +++ b/kernel/ptrace.c
> @@ -222,7 +222,7 @@ static void ptrace_unfreeze_traced(struct task_struct *task)
>  	if (lock_task_sighand(task, &flags)) {
>  		task->jobctl &= ~JOBCTL_PTRACE_FROZEN;
>  		if (__fatal_signal_pending(task)) {
> -			task->jobctl &= ~TASK_TRACED;
> +			task->jobctl &= ~JOBCTL_TRACED;

Heh. I have read this code many times, but I'm afraid I could read it
1000 times more and didn't notice the problem ;)

Thanks!

Oleg.

