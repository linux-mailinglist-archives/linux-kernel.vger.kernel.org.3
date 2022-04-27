Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CF08512129
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 20:40:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239545AbiD0PSX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 11:18:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239505AbiD0PSU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 11:18:20 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 43DA4393CA
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 08:15:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1651072508;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=GWGAlXr9U9I9b8PILStOY8my0whIfEaiTQGIvHoKm5A=;
        b=cBZ3EaP7yUi+X11YKCIpS8rJAiMXM9IHFCDO9kkRwzOTPlFP1G5TaL5BOOuLMxYakGLaiN
        7Ynp4OP0WUw1Wp328Gnc+Y5YpVkHGVi2BuZRpZ33QsVg2Qt6edv1h//EkIqWldqZOy6Ryu
        UJgAEUXKQ6pu+yFPrJ1mSKWJOagmn/s=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-518-tTNuTEbENbOC2yYU8Sfwqw-1; Wed, 27 Apr 2022 11:15:05 -0400
X-MC-Unique: tTNuTEbENbOC2yYU8Sfwqw-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E04B018E0042;
        Wed, 27 Apr 2022 15:15:02 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.40.192.128])
        by smtp.corp.redhat.com (Postfix) with SMTP id 247EB580464;
        Wed, 27 Apr 2022 15:14:57 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Wed, 27 Apr 2022 17:15:02 +0200 (CEST)
Date:   Wed, 27 Apr 2022 17:14:57 +0200
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
        inux-xtensa@linux-xtensa.org, Kees Cook <keescook@chromium.org>,
        Jann Horn <jannh@google.com>
Subject: Re: [PATCH 7/9] ptrace: Simplify the wait_task_inactive call in
 ptrace_check_attach
Message-ID: <20220427151455.GE17421@redhat.com>
References: <878rrrh32q.fsf_-_@email.froward.int.ebiederm.org>
 <20220426225211.308418-7-ebiederm@xmission.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220426225211.308418-7-ebiederm@xmission.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.9
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/26, Eric W. Biederman wrote:
>
> Asking wait_task_inactive to verify that tsk->__state == __TASK_TRACED
> was needed to detect the when ptrace_stop would decide not to stop
> after calling "set_special_state(TASK_TRACED)".  With the recent
> cleanups ptrace_stop will always stop after calling set_special_state.
>
> Take advatnage of this by no longer asking wait_task_inactive to
> verify the state.  If a bug is hit and wait_task_inactive does not
> succeed warn and return -ESRCH.

ACK, but I think that the changelog is wrong.

We could do this right after may_ptrace_stop() has gone. This doesn't
depend on the previous changes in this series.

Oleg.

