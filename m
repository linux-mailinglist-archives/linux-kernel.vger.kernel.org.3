Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 910964AE181
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 19:52:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1385393AbiBHSvp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 13:51:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239019AbiBHSvn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 13:51:43 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 93941C0612C0
        for <linux-kernel@vger.kernel.org>; Tue,  8 Feb 2022 10:51:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1644346301;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Y1o+F3uoG0nYTsfwRI5MWuT5Nxk+PO/5jW+NV0SQ7s4=;
        b=VIB6Z+Oc+2jCOBfPZNC9eAnuhIWYvadgnV68imPxe5n1yxrpC/zmYXEosJea8TthVSjZk/
        qXepdk2kK9jActw0qsiOTZrzJv4qSMyV+wcVGgdN1NnIW+RdidgvMk7u1P6o/LHstoOmXa
        z5FkFX7f9ObpgsdaWZlck4Ktc70gchU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-148-XzfkwCTPPWyAKnAO9UKWdA-1; Tue, 08 Feb 2022 13:51:38 -0500
X-MC-Unique: XzfkwCTPPWyAKnAO9UKWdA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 090A3100C661;
        Tue,  8 Feb 2022 18:51:37 +0000 (UTC)
Received: from [10.22.35.8] (unknown [10.22.35.8])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9B367753DB;
        Tue,  8 Feb 2022 18:51:35 +0000 (UTC)
Message-ID: <bd83aca3-059f-92dd-e094-b27f51f9481a@redhat.com>
Date:   Tue, 8 Feb 2022 13:51:35 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH] copy_process(): Move fd_install() out of sighand->siglock
 critical section
Content-Language: en-US
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Christian Brauner <brauner@kernel.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jens Axboe <axboe@kernel.dk>,
        Alexey Gladkov <legion@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Jann Horn <jannh@google.com>, linux-kernel@vger.kernel.org
References: <20220208163912.1084752-1-longman@redhat.com>
 <YgKziblMKsmHkP4f@zeniv-ca.linux.org.uk>
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <YgKziblMKsmHkP4f@zeniv-ca.linux.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/8/22 13:16, Al Viro wrote:
> On Tue, Feb 08, 2022 at 11:39:12AM -0500, Waiman Long wrote:
>
>> One way to solve this problem is to move the fd_install() call out of
>> the sighand->siglock critical section.
>>
>> Before commit 6fd2fe494b17 ("copy_process(): don't use ksys_close()
>> on cleanups"), the pidfd installation was done without holding both
>> the task_list lock and the sighand->siglock. Obviously, holding these
>> two locks are not really needed to protect the fd_install() call.
>> So move the fd_install() call down to after the releases of both locks.
> 	Umm... That assumes we can delay it that far.  IOW, that nothing
> relies upon having pidfd observable in /proc/*/fd as soon as the child
> becomes visible there in the first place.
>
> 	What warranties are expected from CLONE_PIDFD wrt observation of
> child's descriptor table?
>
I think the fd_install() call can be moved after the release of 
sighand->siglock but before the release the tasklist_lock. Will that be 
good enough?

I am afraid that I am not knowledgeable enough to talk about the 
CLONE_PIDFD expectation. May other people chime in on this?

Cheers,
Longman


