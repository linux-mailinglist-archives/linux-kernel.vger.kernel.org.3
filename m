Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA4DB5A8C5B
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 06:22:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232430AbiIAEWF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 00:22:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231717AbiIAEWC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 00:22:02 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CC751114FF
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 21:22:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1662006119;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=neGhyK7pkD6eqSZHik1Qe4PD8FiO+8vxC39rTdxsXS8=;
        b=f56lijXBkJ33/Iib0MZrVBtJGc6TBqDJy6LjQEYdsypMcjo041yMhfQxJz+YCtqTVUSQJy
        jPOItQOyb4Y1Ok23jln977gwNCeEiQv+0LKl7btKXqaKQVGQE8WvVYBm4IyFvK5t2IWDRu
        7T2o2hkAUTziZdSgXxQq2Ik7T099xPY=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-532-MhF9hAKjN_GtuqERlDsDEg-1; Thu, 01 Sep 2022 00:21:56 -0400
X-MC-Unique: MhF9hAKjN_GtuqERlDsDEg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5173E85A58A;
        Thu,  1 Sep 2022 04:21:56 +0000 (UTC)
Received: from oldenburg.str.redhat.com (unknown [10.39.192.37])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 16BDE2166B26;
        Thu,  1 Sep 2022 04:21:53 +0000 (UTC)
From:   Florian Weimer <fweimer@redhat.com>
To:     Andrei Vagin <avagin@gmail.com>
Cc:     Christian Brauner <brauner@kernel.org>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Eric Biederman <ebiederm@xmission.com>,
        Kees Cook <keescook@chromium.org>,
        Alexey Izbyshev <izbyshev@ispras.ru>
Subject: Re: Potentially undesirable interactions between vfork() and time
 namespaces
References: <YxAq2jYvGG8QOypu@gmail.com>
Date:   Thu, 01 Sep 2022 06:21:51 +0200
In-Reply-To: <YxAq2jYvGG8QOypu@gmail.com> (Andrei Vagin's message of "Wed, 31
        Aug 2022 20:45:30 -0700")
Message-ID: <87tu5ru3kw.fsf@oldenburg.str.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.6
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Andrei Vagin:

> On Tue, Aug 30, 2022 at 6:18 PM Andrei Vagin <avagin@gmail.com> wrote:
>>On Tue, Aug 30, 2022 at 10:49:43PM +0300, Alexey Izbyshev wrote:
> <snip>
>>> @@ -1030,6 +1033,10 @@ static int exec_mmap(struct mm_struct *mm)
>>>         tsk->mm->vmacache_seqnum = 0;
>>>         vmacache_flush(tsk);
>>>         task_unlock(tsk);
>>> +
>>> +       if (vfork)
>>> +               timens_on_fork(tsk->nsproxy, tsk);
>>> +
>>> 
>>> Similarly, even after a normal vfork(), time namespace switch could be
>>> silently skipped if the parent dies before "tsk->vfork_done" is read. Again,
>>> I don't know whether anybody cares, but this behavior seems non-obvious and
>>> probably unintended to me.
>> This is the more interesting case. I will try to find out how we can
>> handle it properly.
>
> It might not be a good idea to use vfork_done in this case. Let's
> think about what we have and what we want to change. We don't want to
> allow switching timens if a process mm is used by someone else. But we
> forgot to handle execve that creates a new mm, and we can't change this
> behavior right now because it can affect current users. Right?
>
> So maybe the best choice, in this case, is to change behavior by adding
> a new control that enables it. The first interface that comes to my mind
> is to introduce a new ioctl for a namespace file descriptor. Here is a
> draft patch below that should help to understand what I mean.

Doesn't this bring back the old posix_spawn (vfork) failure?

Thanks,
Florian

