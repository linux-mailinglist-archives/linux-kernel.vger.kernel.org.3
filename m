Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC0BC540261
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 17:27:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344052AbiFGP1c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 11:27:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344031AbiFGP10 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 11:27:26 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4AF2135243
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jun 2022 08:27:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1654615643;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=j2QP74kmyLRjPfaslomjwazE8bxfaKWf8AzgM5WImZE=;
        b=QnAPkHHbMeyjIPK2YmKCjUQbyw+bebTItkhXqjm6b3gVPrAhD6DMt/3Su64ZUnoDTvGVd8
        9K0hnmHB8kr6OBiOubTHUhBNpsc0XjslSiAucl7mk8WoDuVE+EpwtDV+6Ni7t/LDN2eIzc
        JnY7+RD2b8w/viRYUqRbkH6BN/70dwk=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-470-ppflYsfZM8qOHDXTPBRCHg-1; Tue, 07 Jun 2022 11:27:20 -0400
X-MC-Unique: ppflYsfZM8qOHDXTPBRCHg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 911C3968EEB;
        Tue,  7 Jun 2022 15:27:18 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.40.192.101])
        by smtp.corp.redhat.com (Postfix) with SMTP id DF67DC27E92;
        Tue,  7 Jun 2022 15:26:58 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Tue,  7 Jun 2022 17:27:15 +0200 (CEST)
Date:   Tue, 7 Jun 2022 17:26:54 +0200
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
        Jann Horn <jannh@google.com>, linux-ia64@vger.kernel.org,
        Robert OCallahan <roc@pernos.co>, Kyle Huey <khuey@pernos.co>,
        Richard Henderson <rth@twiddle.net>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>,
        Jason Wessel <jason.wessel@windriver.com>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Douglas Anderson <dianders@chromium.org>,
        Douglas Miller <dougmill@linux.vnet.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH 07/16] signal: Wake up the designated parent
Message-ID: <20220607152627.GA10192@redhat.com>
References: <871qwq5ucx.fsf_-_@email.froward.int.ebiederm.org>
 <20220518225355.784371-7-ebiederm@xmission.com>
 <20220524132553.GD14347@redhat.com>
 <20220524162808.GF14347@redhat.com>
 <20220525142845.GA2687@redhat.com>
 <87a6ap30lh.fsf@email.froward.int.ebiederm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87a6ap30lh.fsf@email.froward.int.ebiederm.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.8
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/06, Eric W. Biederman wrote:
>
> Which if I have had enough sleep reduces this patch to just:
>
> diff --git a/kernel/exit.c b/kernel/exit.c
> index f072959fcab7..c8156366b722 100644
> --- a/kernel/exit.c
> +++ b/kernel/exit.c
> @@ -1431,8 +1431,10 @@ static int child_wait_callback(wait_queue_entry_t *wait, unsigned mode,
>         if (!eligible_pid(wo, p))
>                 return 0;
>
> -       if ((wo->wo_flags & __WNOTHREAD) && wait->private != p->parent)
> -               return 0;
> +       if ((wo->wo_flags & __WNOTHREAD) &&
> +           (wait->private != p->parent) &&
> +           (wait->private != p->real_parent))
> +                       return 0;
>
>         return default_wake_function(wait, mode, sync, key);
>  }
>
>
> I think that solves the issue without missing wake-ups without adding
> any more.

Agreed, and looks much simpler.

> For the same set of reasons it looks like the __wake_up_parent in
> __ptrace_detach is just simply dead code.  I don't think there is a case
> where when !ptrace_reparented the thread that is the real_parent can
> sleep in do_wait when the thread that was calling ptrace could not.

Yes... this doesn't really differ from the case when one thread reaps
a natural child and another thread sleep in do_wait().

> That needs a very close look to confirm.

Yes.

Oleg.

