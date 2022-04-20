Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 861DB508E50
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 19:19:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381048AbiDTRWB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 13:22:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381041AbiDTRV5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 13:21:57 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B147846150
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 10:19:10 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id bn33so2678470ljb.6
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 10:19:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QDx0+OI/qSjmxfaZ2RU746dMr9V2CB+G11HI7Wlu0nQ=;
        b=gFbmnqStrskqts56tcXSCl54ZClNg5uAYTF7SaMt/Zlt9oxJv2OxrK3KNVEG7TvsUi
         qD2/0TsE6N0l5L7bbw6eJSPiAfsNsRkgwpmGHC5sSpSF03qH5pz8eKIBfSGByVjxUW8I
         0Mi3Qalz7MwAsj/D1nTunBvDc9+7ikclPw6SZqwZ1XZEJ+dB/2TYyZ8xWOG//mXBPA/M
         R0bEmog7Dc141NWbOkoSlntwYZG3eMH0w60QXw7OBRod2TN5Bnuq/usT/k6HheHtULiI
         hqQXhkXo6GmrledqMohi5AlKGKxsKlzxwPY/GNZLvbXwYtJFOPUXXh+gCh8RIAtPzneK
         LVoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QDx0+OI/qSjmxfaZ2RU746dMr9V2CB+G11HI7Wlu0nQ=;
        b=GINVCJVyC//7OXvjPS+pWDshG/Zfvi3B0PTJQOBoHQ8+mosd2udmv4q7UlqIVe9NaN
         1ndk94VGlAFGUndDGpDrtO8/oWHDJYRcCPYRtjfBKQzuYkFasqRnRBeHM6FvdOKNWRS1
         goC0nGOnDhL5U3sHhVNNB3J4IjwsDFXdTa77AQf0Nxbwy9XMLtej2Pze68+9NxET/aP4
         aDwQVugZlpBiv+g87LdNOI7tEcqA3PNx5f+zmtTIJAS73Lfw68adsReMd74VZ7K+B6Qb
         rxBkbu0PFNAM37gFrzYIBXj5RPX3Tt0pwJZxTSCzZ9omeEXCYvWt4oiRdG+MDfe6zq2e
         rz7Q==
X-Gm-Message-State: AOAM531oyBbOydJSy9bEfvc/nISHJ5okuDu0P0rPFIZQIzt9JQv/SyLJ
        wJ+1d+Jk58KzLRO3rwj8KzScRBuj2Y8KgwIw5LfqlA==
X-Google-Smtp-Source: ABdhPJwRetxn/IgYVS6GD+Q9qLe4SykXWoh+uPF7wEP3xag79my4A9VOvbV3gygmnNUeMfeBLvBh/SjUq7BN5tgb1LM=
X-Received: by 2002:a05:651c:1204:b0:24e:e127:f509 with SMTP id
 i4-20020a05651c120400b0024ee127f509mr1374221lja.459.1650475148777; Wed, 20
 Apr 2022 10:19:08 -0700 (PDT)
MIME-Version: 1.0
References: <874k2nhgtg.fsf@catern.com>
In-Reply-To: <874k2nhgtg.fsf@catern.com>
From:   Jann Horn <jannh@google.com>
Date:   Wed, 20 Apr 2022 19:18:32 +0200
Message-ID: <CAG48ez1PcDV5LvUomM6MsoA0pbg_7oJyfBLt6M2e3541gxx-LA@mail.gmail.com>
Subject: Re: Explicitly defining the userspace API
To:     Spencer Baugh <sbaugh@catern.com>
Cc:     linux-api@vger.kernel.org, linux-kernel@vger.kernel.org,
        marcin@juszkiewicz.com.pl, torvalds@linux-foundation.org,
        arnd@arndb.de
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 20, 2022 at 6:30 PM Spencer Baugh <sbaugh@catern.com> wrote:
> Linux guarantees the stability of its userspace API, but the API
> itself is only informally described, primarily with English prose.  I
> want to add an explicit, authoritative machine-readable definition of
> the Linux userspace API.
>
> As background, in a conventional libc like glibc, read(2) calls the
> Linux system call read, passing arguments in an architecture-specific
> way according to the specific details of read.
>
> The details of these syscalls are at best documented in manpages, and
> often defined only by the implementation.  Anyone else who wants to
> work with a syscall, in any way, needs to duplicate all those details.
>
> So the most basic definition of the API would just represent the
> information already present in SYSCALL_DEFINE macros: the C types of
> arguments and return values.

FWIW, I believe ftrace already gets that basic information from the
SYSCALL_DEFINE macros via struct syscall_metadata, and exports it to
root-privileged userspace (although I think it won't actually tell you
what the syscall number is that way):

# cat /sys/kernel/debug/tracing/events/syscalls/sys_enter_epoll_wait/format
name: sys_enter_epoll_wait
ID: 902
format:
field:unsigned short common_type; offset:0; size:2; signed:0;
field:unsigned char common_flags; offset:2; size:1; signed:0;
field:unsigned char common_preempt_count; offset:3; size:1; signed:0;
field:int common_pid; offset:4; size:4; signed:1;

field:int __syscall_nr; offset:8; size:4; signed:1;
field:int epfd; offset:16; size:8; signed:0;
field:struct epoll_event * events; offset:24; size:8; signed:0;
field:int maxevents; offset:32; size:8; signed:0;
field:int timeout; offset:40; size:8; signed:0;

print fmt: "epfd: 0x%08lx, events: 0x%08lx, maxevents: 0x%08lx,
timeout: 0x%08lx", ((unsigned long)(REC->epfd)), ((unsigned
long)(REC->events)), ((unsigned long)(REC->maxevents)), ((unsigned
long)(REC->timeout))

You could probably also get that data from DWARF somehow.
