Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 258994DE1EF
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Mar 2022 20:44:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240402AbiCRTpN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Mar 2022 15:45:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230302AbiCRTpL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Mar 2022 15:45:11 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2BF5B149263
        for <linux-kernel@vger.kernel.org>; Fri, 18 Mar 2022 12:43:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1647632629;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Q9Mnz9taMYW93CxRZtU6P5G6RYdc1RWMDXaAEv6M17c=;
        b=PQ67UkWK2MfDd2R+z2mPa60/MdIc/1P2PU56sX5m1PzVldN0D0rqIZ6HYYN6Vm2HordH7n
        EEj3tRAZheTzyEgpFtHFixb0dyA4B8dvDv7+4ere8INup+OKpfES5k17ZV+Kz6CFWEUEdh
        olXE9LHwemFVteLoCDEw8QVM95W5Gpg=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-528-_2RjurlxPXqy19kcbfmzBg-1; Fri, 18 Mar 2022 15:43:43 -0400
X-MC-Unique: _2RjurlxPXqy19kcbfmzBg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id DD17B85A5A8;
        Fri, 18 Mar 2022 19:43:42 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.40.192.97])
        by smtp.corp.redhat.com (Postfix) with SMTP id C9C7133250;
        Fri, 18 Mar 2022 19:43:40 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Fri, 18 Mar 2022 20:43:40 +0100 (CET)
Date:   Fri, 18 Mar 2022 20:43:37 +0100
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
Message-ID: <20220318194337.GA17638@redhat.com>
References: <87a6ha4zsd.fsf@email.froward.int.ebiederm.org>
 <87bl1kunjj.fsf@email.froward.int.ebiederm.org>
 <87r19opkx1.fsf_-_@email.froward.int.ebiederm.org>
 <87o82gdlu9.fsf_-_@email.froward.int.ebiederm.org>
 <87tubyx0rg.fsf_-_@email.froward.int.ebiederm.org>
 <875yoe7qdp.fsf_-_@email.froward.int.ebiederm.org>
 <20220317180856.GB13318@redhat.com>
 <871qz04eht.fsf@email.froward.int.ebiederm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <871qz04eht.fsf@email.froward.int.ebiederm.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.79 on 10.11.54.5
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/17, Eric W. Biederman wrote:
>
> Oleg Nesterov <oleg@redhat.com> writes:
>
> > OK, I like it... but can't we remove the ugly "int clear_code" arg?
>
> The flag clear_code controls what happens if a ptrace_stop does not
> stop.  In particular clear_code means do not continue with
> a signal if we can not stop.
>
> For do_jobctl_trap calling ptrace_stop it clearly does not matter.
>
> For ptrace_signal it would be a change in behavior, that would
> cause the signal not to be delivered.

Well I meant that "clear_code" should be false, iirc only
ptrace_report_syscall() should be updated to void the spurious
send_sig() if debugger exits... Nevermind, pleasee forget, this is
not as trivial as I thought.

Acked-by: Oleg Nesterov <oleg@redhat.com>

