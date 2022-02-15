Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BC884B6BCC
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 13:13:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235758AbiBOMNP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 07:13:15 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:43000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232311AbiBOMNO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 07:13:14 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 65DCF1074C0
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 04:13:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1644927180;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=dYhGXns40WKrb1dRr7VTeOa9TxUg7lSt7cFUIfXHiJU=;
        b=VT0XkWkGVklSHhrz1ruuiUJfBrwnIdXSFc7roImIprJTWCFj43s2poV9QVAoKMaxD4hgAt
        u/8ngiDhqdp8vIsGRv8TZTeu/K+ihqg2bmswdH+xlluBi9fOrJjdBe1HRDcBw3HLi8/LEw
        CBp0bMInwP1/G45+rrJ77dPbkTSg1jg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-661-ddxMi8VAOSSWAXeAhiIzXw-1; Tue, 15 Feb 2022 07:12:57 -0500
X-MC-Unique: ddxMi8VAOSSWAXeAhiIzXw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0AA31108087A;
        Tue, 15 Feb 2022 12:12:55 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.40.192.154])
        by smtp.corp.redhat.com (Postfix) with SMTP id F078B7B9E0;
        Tue, 15 Feb 2022 12:12:51 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Tue, 15 Feb 2022 13:12:54 +0100 (CET)
Date:   Tue, 15 Feb 2022 13:12:50 +0100
From:   Oleg Nesterov <oleg@redhat.com>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     Paul Menzel <pmenzel@molgen.mpg.de>,
        "Theodore Y. Ts'o" <tytso@mit.edu>,
        LKML <linux-kernel@vger.kernel.org>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Jann Horn <jannh@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Marco Elver <elver@google.com>,
        Nicolas Pitre <nico@fluxnic.net>,
        Rik van Riel <riel@redhat.com>
Subject: Re: BUG: KCSAN: data-race in add_device_randomness+0x20d/0x290
Message-ID: <20220215121250.GA15119@redhat.com>
References: <e10b79cf-d6d5-ffcc-bce4-edd92b7cb6b9@molgen.mpg.de>
 <CAHmME9pktmNpcBS_DJhJ5Z+6xO9P1wroQ9_gwx8KZMBxk1FBeQ@mail.gmail.com>
 <5b3d6ad6-a506-7dae-0eb7-b7da080f6454@molgen.mpg.de>
 <CAHmME9rgBJx+-wy-_GXPRMYEuTNyaa7SAr+nVOPh-Am2k6A2CA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHmME9rgBJx+-wy-_GXPRMYEuTNyaa7SAr+nVOPh-Am2k6A2CA@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,T_SCC_BODY_TEXT_LINE,T_SPF_TEMPERROR autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/15, Jason A. Donenfeld wrote:
>
> void release_task(struct task_struct *p)
> {
> [...]
>         cgroup_release(p);
>
>         write_lock_irq(&tasklist_lock);
>         ptrace_release_task(p);
>         thread_pid = get_pid(p->thread_pid);
>         __exit_signal(p);
> [...]
> }
> static void __exit_signal(struct task_struct *tsk)
> {
> [...]
>        add_device_randomness((const void*) &tsk->se.sum_exec_runtime,
>                              sizeof(unsigned long long));
> [...]
> }
>
> Apparently the data that is being read by add_device_randomness() is
> being modified while it's being read. This would be whatever is in
> `tsk->se.sum_exec_runtime`.
>
> I'm not sure what's happening there, if this is "normal" and the task
> can be scheduled out while exiting, causing the schedule to add to
> sum_exec_runtime, or what.

Yes, this is normal.

The parent can call release_task(child) right after the child has passed
exit_notify(), the exiting child still runs and can be scheduled out until
it does the last schedule from do_task_dead().

Oleg.

