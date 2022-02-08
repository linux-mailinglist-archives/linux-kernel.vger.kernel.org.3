Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6A514AE4C8
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 23:37:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1386236AbiBHWhR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 17:37:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1388500AbiBHWdC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 17:33:02 -0500
Received: from out02.mta.xmission.com (out02.mta.xmission.com [166.70.13.232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06373C01CB14
        for <linux-kernel@vger.kernel.org>; Tue,  8 Feb 2022 14:25:12 -0800 (PST)
Received: from in02.mta.xmission.com ([166.70.13.52]:50410)
        by out02.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1nHYv9-00DAOc-CY; Tue, 08 Feb 2022 15:25:11 -0700
Received: from ip68-227-174-4.om.om.cox.net ([68.227.174.4]:41898 helo=email.froward.int.ebiederm.org.xmission.com)
        by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1nHYv7-00CSCi-GT; Tue, 08 Feb 2022 15:25:10 -0700
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
        <874k59f2ad.fsf@email.froward.int.ebiederm.org>
        <YgLr2GEXgz/TxdUA@zeniv-ca.linux.org.uk>
Date:   Tue, 08 Feb 2022 16:25:02 -0600
In-Reply-To: <YgLr2GEXgz/TxdUA@zeniv-ca.linux.org.uk> (Al Viro's message of
        "Tue, 8 Feb 2022 22:16:56 +0000")
Message-ID: <87czjxdmip.fsf@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1nHYv7-00CSCi-GT;;;mid=<87czjxdmip.fsf@email.froward.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.174.4;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX182oeJyc/2QUC0MDFcVTea6z+qieDuOmFk=
X-SA-Exim-Connect-IP: 68.227.174.4
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-DCC: XMission; sa06 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ;Al Viro <viro@zeniv.linux.org.uk>
X-Spam-Relay-Country: 
X-Spam-Timing: total 361 ms - load_scoreonly_sql: 0.04 (0.0%),
        signal_user_changed: 12 (3.4%), b_tie_ro: 10 (2.9%), parse: 1.07
        (0.3%), extract_message_metadata: 14 (3.8%), get_uri_detail_list: 1.36
        (0.4%), tests_pri_-1000: 14 (3.9%), tests_pri_-950: 1.71 (0.5%),
        tests_pri_-900: 1.40 (0.4%), tests_pri_-90: 100 (27.7%), check_bayes:
        98 (27.3%), b_tokenize: 6 (1.8%), b_tok_get_all: 7 (1.9%),
        b_comp_prob: 2.6 (0.7%), b_tok_touch_all: 79 (21.8%), b_finish: 0.87
        (0.2%), tests_pri_0: 204 (56.4%), check_dkim_signature: 0.50 (0.1%),
        check_dkim_adsp: 2.6 (0.7%), poll_dns_idle: 0.56 (0.2%), tests_pri_10:
        2.1 (0.6%), tests_pri_500: 8 (2.2%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH] copy_process(): Move fd_install() out of
 sighand->siglock critical section
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Al Viro <viro@zeniv.linux.org.uk> writes:

> On Tue, Feb 08, 2022 at 03:59:06PM -0600, Eric W. Biederman wrote:
>
>> The fd is being installed in the fdtable of the parent process,
>> and the siglock and tasklist_lock are held to protect the child.
>> 
>> 
>> Further fd_install is exposing the fd to userspace where it can be used
>> by the process_madvise and the process_mrelease system calls, from
>> anything that shares the fdtable of the parent thread.  Which means it
>> needs to be guaranteed that kernel_clone will call wake_up_process
>> before it is safe to call fd_install.
>
> You mean "no calling fd_install() until after we are past the last possible
> failure exit, by which point we know that wake_up_process() will eventually
> be called", hopefully?  If so (as I assumed all along), anything downstream
> of
>         if (fatal_signal_pending(current)) {
> 		retval = -EINTR;
> 		goto bad_fork_cancel_cgroup;
> 	}
>
> should be fine...

Except for the problems of calling fd_install under siglock, and
tasklist_lock, which protect nothing and cause lockdep splats.

There may also be assumptions on the task actually being fully setup,
if not today then in a future use pidfd.  So I am not particularly
comfortable with fd_install coming before we drop tasklist_lock.

I was pointing out that to resolve the locking issue we fundamentally
can not move the fd_install earlier, to resolve the locking issues.

Eric
