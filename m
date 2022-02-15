Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC07E4B6B5A
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 12:44:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237297AbiBOLoh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 06:44:37 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:40142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237269AbiBOLof (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 06:44:35 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C38046665
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 03:44:26 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9B6A861531
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 11:44:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE9E8C340F1
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 11:44:24 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="LLDRF7jD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1644925462;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=M7vQFkgBPGDNm8u1wax1fxZ6IkrG5kOgjZ40Apa3KAA=;
        b=LLDRF7jDzNSg5Q245I4UnYzQ3ihtYgXlW9gofs7NY7aAN+Ywe099eA+VjvU9z5MSsG11MR
        Hoi0w2Zw/dzxZmsIPAsMPg/BzxuoMbEMn5izUZP80NfY76/3oo/CptqQXnEff11J4nE26a
        CZ9+r2gzkhR61s7EgceA3YUVQ+cm5IY=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 825a92ff (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO)
        for <linux-kernel@vger.kernel.org>;
        Tue, 15 Feb 2022 11:44:22 +0000 (UTC)
Received: by mail-yb1-f177.google.com with SMTP id y129so55077825ybe.7
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 03:44:21 -0800 (PST)
X-Gm-Message-State: AOAM530yqmQY6ePPuw4gp5vkbZj9S8nyYLgUYTtQyz/ePekrx1VICO7j
        e8VidqOTNkvUaRMEI/SPFFUwge1aCQDZ5Naf3bE=
X-Google-Smtp-Source: ABdhPJxS/J+sngu3tvw5JTP9HuPLh+DTZybeRrL6Z1zsz2+8uc6JZw6bYGtN3AHjF8OvwLY1Pn/JnCUvODaK5BWQCe0=
X-Received: by 2002:a25:4144:: with SMTP id o65mr3138730yba.113.1644925460415;
 Tue, 15 Feb 2022 03:44:20 -0800 (PST)
MIME-Version: 1.0
References: <e10b79cf-d6d5-ffcc-bce4-edd92b7cb6b9@molgen.mpg.de>
 <CAHmME9pktmNpcBS_DJhJ5Z+6xO9P1wroQ9_gwx8KZMBxk1FBeQ@mail.gmail.com> <5b3d6ad6-a506-7dae-0eb7-b7da080f6454@molgen.mpg.de>
In-Reply-To: <5b3d6ad6-a506-7dae-0eb7-b7da080f6454@molgen.mpg.de>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Tue, 15 Feb 2022 12:44:09 +0100
X-Gmail-Original-Message-ID: <CAHmME9rgBJx+-wy-_GXPRMYEuTNyaa7SAr+nVOPh-Am2k6A2CA@mail.gmail.com>
Message-ID: <CAHmME9rgBJx+-wy-_GXPRMYEuTNyaa7SAr+nVOPh-Am2k6A2CA@mail.gmail.com>
Subject: Re: BUG: KCSAN: data-race in add_device_randomness+0x20d/0x290
To:     Paul Menzel <pmenzel@molgen.mpg.de>
Cc:     "Theodore Y. Ts'o" <tytso@mit.edu>,
        LKML <linux-kernel@vger.kernel.org>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Jann Horn <jannh@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Marco Elver <elver@google.com>,
        Nicolas Pitre <nico@fluxnic.net>,
        Rik van Riel <riel@redhat.com>,
        Oleg Nesterov <oleg@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Paul,

Thanks for the new report. This looks like likely the same sort of
issue as before -- it's on a 1 byte read of the data that's being
passed to add_device_randomness by release_task(). It looks like there
might be a race in release_task():

void release_task(struct task_struct *p)
{
[...]
        cgroup_release(p);

        write_lock_irq(&tasklist_lock);
        ptrace_release_task(p);
        thread_pid = get_pid(p->thread_pid);
        __exit_signal(p);
[...]
}
static void __exit_signal(struct task_struct *tsk)
{
[...]
       add_device_randomness((const void*) &tsk->se.sum_exec_runtime,
                             sizeof(unsigned long long));
[...]
}

Apparently the data that is being read by add_device_randomness() is
being modified while it's being read. This would be whatever is in
`tsk->se.sum_exec_runtime`.

I'm not sure what's happening there, if this is "normal" and the task
can be scheduled out while exiting, causing the schedule to add to
sum_exec_runtime, or what. CCing some people who seem to have touched
this code, and maybe that'll help illuminate things.

Thanks,
Jason
