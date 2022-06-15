Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DA8954C34F
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 10:14:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244868AbiFOIOj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 04:14:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344148AbiFOIOh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 04:14:37 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id DF2883701B
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 01:14:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1655280869;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=YJSmIjchRt0MiM65IzYG4GVOYlEijEmaflQlPrsPyMM=;
        b=Kl1qQ2tslKnYsXlbSWTaWUF7dtbrxfu42kw8zq2iBvKzukm4Wqu+MxXU5kt9tPZL+mt+JH
        Nn3y+ZC4syXPc5c+4MYe0jeuwg63iMzQLcDQCC/Lp79q1RgXfhb/v9YG5R7Y+pt0jAsD51
        MQbXm7r+x2TkOuGenv19eUe+eRxWUiY=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-191-QGzFYCVkM9mCn86h-ASu1g-1; Wed, 15 Jun 2022 04:14:22 -0400
X-MC-Unique: QGzFYCVkM9mCn86h-ASu1g-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 52AC93802B91;
        Wed, 15 Jun 2022 08:14:22 +0000 (UTC)
Received: from oldenburg.str.redhat.com (unknown [10.39.192.90])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id D9380492CA5;
        Wed, 15 Jun 2022 08:14:20 +0000 (UTC)
From:   Florian Weimer <fweimer@redhat.com>
To:     Christian Brauner <brauner@kernel.org>
Cc:     Kees Cook <keescook@chromium.org>, Andrei Vagin <avagin@gmail.com>,
        linux-kernel@vger.kernel.org,
        Dmitry Safonov <0x7f454c46@gmail.com>, linux-mm@kvack.org,
        Eric Biederman <ebiederm@xmission.com>
Subject: Re: [PATCH 1/2] fs/exec: allow to unshare a time namespace on
 vfork+exec
References: <20220613060723.197407-1-avagin@gmail.com>
        <202206141412.2B0732FF6C@keescook>
        <874k0mqs5i.fsf@oldenburg.str.redhat.com>
        <20220615080000.qtxeosohhyfabzmg@wittgenstein>
Date:   Wed, 15 Jun 2022 10:14:19 +0200
In-Reply-To: <20220615080000.qtxeosohhyfabzmg@wittgenstein> (Christian
        Brauner's message of "Wed, 15 Jun 2022 10:00:00 +0200")
Message-ID: <87zgiepcmc.fsf@oldenburg.str.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.9
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Christian Brauner:

> For pid namespaces one problem would be that it could end up confusing a
> process about its own pid. This was a more serious problem when the pid
> cache was still active in glibc; but fwiw systemd still has a pid cache
> afair.

Right.  glibc still has a TID cache, mainly for use with recursive
mutexes (where we need a 32-bit thread identifier and can't perform a
system call on every locking operation for performance reasons).
Assuming that a non-delayed CLONE_NEWPID would also change the TID
underneath us, we'd have subtly broken recursive mutexes.

vfork gets away with not updating the TID cache (which is shared with
the parent process) because the parent process is suspended while the
new subprocess is still running and has not execve'ed yet.

Now one could argue that calling unshare automatically means that you
must not call any glibc functions afterwards (similar to thread-creating
clone), or at least that you cannot call any functions which are not
async-signal-safe, but that does not match existing application
practice.  And I think we actually prefer that file servers call chroot
after unshare(CLONE_FS), rather than trying to reimplement restricted
pathname lookup in userspace.

Thanks,
Florian

