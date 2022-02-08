Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E7D84AE446
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 23:30:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1387478AbiBHWYS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 17:24:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1387124AbiBHV7a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 16:59:30 -0500
Received: from out02.mta.xmission.com (out02.mta.xmission.com [166.70.13.232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE4DAC0612B8
        for <linux-kernel@vger.kernel.org>; Tue,  8 Feb 2022 13:59:29 -0800 (PST)
Received: from in01.mta.xmission.com ([166.70.13.51]:35296)
        by out02.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1nHYWF-00D3Sx-RE; Tue, 08 Feb 2022 14:59:27 -0700
Received: from ip68-227-174-4.om.om.cox.net ([68.227.174.4]:40330 helo=email.froward.int.ebiederm.org.xmission.com)
        by in01.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1nHYWE-002oBP-Rc; Tue, 08 Feb 2022 14:59:27 -0700
From:   "Eric W. Biederman" <ebiederm@xmission.com>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Waiman Long <longman@redhat.com>,
        Christian Brauner <brauner@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jens Axboe <axboe@kernel.dk>,
        Alexey Gladkov <legion@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Jann Horn <jannh@google.com>, linux-kernel@vger.kernel.org
References: <20220208163912.1084752-1-longman@redhat.com>
        <YgKziblMKsmHkP4f@zeniv-ca.linux.org.uk>
        <bd83aca3-059f-92dd-e094-b27f51f9481a@redhat.com>
        <YgK/fdYWi0wWysci@zeniv-ca.linux.org.uk>
Date:   Tue, 08 Feb 2022 15:59:06 -0600
In-Reply-To: <YgK/fdYWi0wWysci@zeniv-ca.linux.org.uk> (Al Viro's message of
        "Tue, 8 Feb 2022 19:07:41 +0000")
Message-ID: <874k59f2ad.fsf@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1nHYWE-002oBP-Rc;;;mid=<874k59f2ad.fsf@email.froward.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.227.174.4;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX19ah3ujpA0uSRXc7hWxYjEDlJ9CtDrmagE=
X-SA-Exim-Connect-IP: 68.227.174.4
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-DCC: XMission; sa06 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: *;Al Viro <viro@zeniv.linux.org.uk>
X-Spam-Relay-Country: 
X-Spam-Timing: total 421 ms - load_scoreonly_sql: 0.04 (0.0%),
        signal_user_changed: 11 (2.5%), b_tie_ro: 9 (2.2%), parse: 0.93 (0.2%),
         extract_message_metadata: 12 (2.9%), get_uri_detail_list: 1.71 (0.4%),
         tests_pri_-1000: 7 (1.8%), tests_pri_-950: 1.25 (0.3%),
        tests_pri_-900: 1.01 (0.2%), tests_pri_-90: 84 (20.0%), check_bayes:
        82 (19.6%), b_tokenize: 7 (1.8%), b_tok_get_all: 7 (1.7%),
        b_comp_prob: 2.5 (0.6%), b_tok_touch_all: 61 (14.6%), b_finish: 0.97
        (0.2%), tests_pri_0: 289 (68.6%), check_dkim_signature: 0.62 (0.1%),
        check_dkim_adsp: 2.7 (0.6%), poll_dns_idle: 0.39 (0.1%), tests_pri_10:
        2.2 (0.5%), tests_pri_500: 9 (2.2%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH] copy_process(): Move fd_install() out of
 sighand->siglock critical section
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Al Viro <viro@zeniv.linux.org.uk> writes:

> On Tue, Feb 08, 2022 at 01:51:35PM -0500, Waiman Long wrote:
>> On 2/8/22 13:16, Al Viro wrote:
>> > On Tue, Feb 08, 2022 at 11:39:12AM -0500, Waiman Long wrote:
>> > 
>> > > One way to solve this problem is to move the fd_install() call out of
>> > > the sighand->siglock critical section.
>> > > 
>> > > Before commit 6fd2fe494b17 ("copy_process(): don't use ksys_close()
>> > > on cleanups"), the pidfd installation was done without holding both
>> > > the task_list lock and the sighand->siglock. Obviously, holding these
>> > > two locks are not really needed to protect the fd_install() call.
>> > > So move the fd_install() call down to after the releases of both locks.
>> > 	Umm... That assumes we can delay it that far.  IOW, that nothing
>> > relies upon having pidfd observable in /proc/*/fd as soon as the child
>> > becomes visible there in the first place.
>> > 
>> > 	What warranties are expected from CLONE_PIDFD wrt observation of
>> > child's descriptor table?
>> > 
>> I think the fd_install() call can be moved after the release of
>> sighand->siglock but before the release the tasklist_lock. Will that be good
>> enough?
>
> Looks like it should, but I'd rather hear from the CLONE_PIDFD authors first...
> Christian, could you comment on that?

The tasklist_lock and the siglock provide no protection against
being looked up in proc.

The proc filesystem looks up process information with things only
protected by the rcu_read_lock().  Which means that the process
will be visible through proc after "attach_pid(p, PIDTYPE_PID".

The fd is being installed in the fdtable of the parent process,
and the siglock and tasklist_lock are held to protect the child.


Further fd_install is exposing the fd to userspace where it can be used
by the process_madvise and the process_mrelease system calls, from
anything that shares the fdtable of the parent thread.  Which means it
needs to be guaranteed that kernel_clone will call wake_up_process
before it is safe to call fd_install.


So it appears to me that moving fd_install earlier fundamentally unsafe,
and the locks are meaningless from an fd_install perspective.

Which means it should be perfectly fine to move the fd_install outside
of the tasklist_lock and the outside siglock.


I don't see how we could support the fd appearing in the fdtable sooner
which seems to make the question moot as to weather userspace in some
odd corner case expects the fd to appear in the fdtable sooner.

So I say move fd_install down with proc_fork_connector and friends.

Eric
