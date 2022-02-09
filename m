Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1598D4AF680
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 17:25:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236815AbiBIQZ2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 11:25:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236801AbiBIQZZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 11:25:25 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D01DFC061355
        for <linux-kernel@vger.kernel.org>; Wed,  9 Feb 2022 08:25:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1644423927;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=U2UGaBijIxRE44n1fVKzxpivW+ch5MCUy66hzNFFtU0=;
        b=BaJVB3ftuc/TeDVEkToLkkpich0l4/qIaPtESys2SG6JZru5lVOwmMHn5WU3W9LGptjvMl
        0Se+70TsVpY6obWxJ4ec0qYiGbZf6nXc8A1EE5D+30IH+MAIf2IzhKtLUGVfiTPKFIKyfE
        HTiZFeEqeyNGoOlsOrxR8tXXkXnRl8w=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-110-3I4lEYmZMP6JoO_1rqQMAw-1; Wed, 09 Feb 2022 11:25:23 -0500
X-MC-Unique: 3I4lEYmZMP6JoO_1rqQMAw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C2C7D814264;
        Wed,  9 Feb 2022 16:25:21 +0000 (UTC)
Received: from [10.22.18.180] (unknown [10.22.18.180])
        by smtp.corp.redhat.com (Postfix) with ESMTP id AB8277D3CC;
        Wed,  9 Feb 2022 16:25:20 +0000 (UTC)
Message-ID: <c99b49a3-263a-f0b4-de3c-3271153a5208@redhat.com>
Date:   Wed, 9 Feb 2022 11:25:20 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH] copy_process(): Move fd_install() out of sighand->siglock
 critical section
Content-Language: en-US
To:     "Eric W. Biederman" <ebiederm@xmission.com>,
        Al Viro <viro@zeniv.linux.org.uk>
Cc:     Christian Brauner <brauner@kernel.org>,
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
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <874k59f2ad.fsf@email.froward.int.ebiederm.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/8/22 16:59, Eric W. Biederman wrote:
> Al Viro <viro@zeniv.linux.org.uk> writes:
>
>> On Tue, Feb 08, 2022 at 01:51:35PM -0500, Waiman Long wrote:
>>> On 2/8/22 13:16, Al Viro wrote:
>>>> On Tue, Feb 08, 2022 at 11:39:12AM -0500, Waiman Long wrote:
>>>>
>>>>> One way to solve this problem is to move the fd_install() call out of
>>>>> the sighand->siglock critical section.
>>>>>
>>>>> Before commit 6fd2fe494b17 ("copy_process(): don't use ksys_close()
>>>>> on cleanups"), the pidfd installation was done without holding both
>>>>> the task_list lock and the sighand->siglock. Obviously, holding these
>>>>> two locks are not really needed to protect the fd_install() call.
>>>>> So move the fd_install() call down to after the releases of both locks.
>>>> 	Umm... That assumes we can delay it that far.  IOW, that nothing
>>>> relies upon having pidfd observable in /proc/*/fd as soon as the child
>>>> becomes visible there in the first place.
>>>>
>>>> 	What warranties are expected from CLONE_PIDFD wrt observation of
>>>> child's descriptor table?
>>>>
>>> I think the fd_install() call can be moved after the release of
>>> sighand->siglock but before the release the tasklist_lock. Will that be good
>>> enough?
>> Looks like it should, but I'd rather hear from the CLONE_PIDFD authors first...
>> Christian, could you comment on that?
> The tasklist_lock and the siglock provide no protection against
> being looked up in proc.
>
> The proc filesystem looks up process information with things only
> protected by the rcu_read_lock().  Which means that the process
> will be visible through proc after "attach_pid(p, PIDTYPE_PID".
>
> The fd is being installed in the fdtable of the parent process,
> and the siglock and tasklist_lock are held to protect the child.
>
>
> Further fd_install is exposing the fd to userspace where it can be used
> by the process_madvise and the process_mrelease system calls, from
> anything that shares the fdtable of the parent thread.  Which means it
> needs to be guaranteed that kernel_clone will call wake_up_process
> before it is safe to call fd_install.
>
>
> So it appears to me that moving fd_install earlier fundamentally unsafe,
> and the locks are meaningless from an fd_install perspective.
>
> Which means it should be perfectly fine to move the fd_install outside
> of the tasklist_lock and the outside siglock.
>
>
> I don't see how we could support the fd appearing in the fdtable sooner
> which seems to make the question moot as to weather userspace in some
> odd corner case expects the fd to appear in the fdtable sooner.
>
> So I say move fd_install down with proc_fork_connector and friends.

Right. Keeping fd_install() inside of tasklist_lock may also be 
problematic as a read lock can be taken at interrupt context which may 
cause similar lockdep splat. So I am keep this patch as is.

Cheers,
Longman

