Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5746B533F36
	for <lists+linux-kernel@lfdr.de>; Wed, 25 May 2022 16:30:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240572AbiEYO3c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 May 2022 10:29:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244859AbiEYO3P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 10:29:15 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1EA8FA7747
        for <linux-kernel@vger.kernel.org>; Wed, 25 May 2022 07:29:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1653488953;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=rJXBSsswS1QbSCIORAlXaRxJTnMr6MqFIgMIGnJ+Qao=;
        b=HzzBTY80BSnVxYCIWwCbTcsQzuxpAk3xUvMim/xXm2E/+m5ZU2dVxZ6W+iE1LOKrSXfraR
        /weKm7fYgz5ryMDNlXFdmhGb/EzEUSOrrlnIF8weHckBRmidZL2Tn3mooA5MCClCuSXvyA
        KdDyCXLzL9OOrshVF5wSBl/xJEiWtT8=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-252-YR06shO1OwSFVnlHewrk4w-1; Wed, 25 May 2022 10:29:09 -0400
X-MC-Unique: YR06shO1OwSFVnlHewrk4w-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 1E95485A5BC;
        Wed, 25 May 2022 14:29:08 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.40.193.81])
        by smtp.corp.redhat.com (Postfix) with SMTP id 8E4F5C15E71;
        Wed, 25 May 2022 14:28:47 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Wed, 25 May 2022 16:29:07 +0200 (CEST)
Date:   Wed, 25 May 2022 16:28:46 +0200
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
Message-ID: <20220525142845.GA2687@redhat.com>
References: <871qwq5ucx.fsf_-_@email.froward.int.ebiederm.org>
 <20220518225355.784371-7-ebiederm@xmission.com>
 <20220524132553.GD14347@redhat.com>
 <20220524162808.GF14347@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220524162808.GF14347@redhat.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.8
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/24, Oleg Nesterov wrote:
>
> On 05/24, Oleg Nesterov wrote:
> >
> > I fail to understand this patch...
> >
> > On 05/18, Eric W. Biederman wrote:
> > >
> > > Today if a process is ptraced only the ptracer will ever be woken up in
> > > wait
> >
> > and why is this wrong?
> >
> > > Fixes: 75b95953a569 ("job control: Add @for_ptrace to do_notify_parent_cldstop()")
> >
> > how does this change fix 75b95953a569?
>
> OK, I guess you mean the 2nd do_notify_parent_cldstop() in ptrace_stop(),
> the problematic case is current->ptrace == T. Right?
>
> I dislike this patch anyway, but let me think more about it.

OK, now that I understand the problem, the patch doesn't look bad to me,
although I'd ask to make the changelog more clear.

After this change __wake_up_parent() can't accept any "parent" from
p->parent thread group, but all callers look fine except ptrace_detach().

Oleg.

