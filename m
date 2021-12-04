Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 118E846876E
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Dec 2021 21:15:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344739AbhLDUTF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Dec 2021 15:19:05 -0500
Received: from mail-oi1-f170.google.com ([209.85.167.170]:43661 "EHLO
        mail-oi1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346078AbhLDUPF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Dec 2021 15:15:05 -0500
Received: by mail-oi1-f170.google.com with SMTP id o4so13108904oia.10;
        Sat, 04 Dec 2021 12:11:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7uBiY0w9jiQz0c0CTtMivsvO3pUqW3Akp5HFrz8N4Is=;
        b=8QQB3sLuBIWm6ICScZhR5YJpdFmN+3n5RZoFe/xsx796acCfMfJ+Z0qpSyWAsrUh3+
         iyAWt7UbSFgex6DnQw2ejogfO95o6gst26FMshWUQwbMFW5UIHqLVvBFk9oz+ghKqcWO
         tphGilXmGweTJcaSGsbnmcrY84Al6Wn8+NcHEXu8UiVJtFQNCKd8E1G8skX0nIOYMpp3
         8wqurhQDkD4sV0TwFtxjXRC0mdAAdu1NTPWfgLWchDm+5LR8tkvf3MagrkwZy7AhRdHZ
         AxrTGgCE9YmVkqybJMeuY5QUHK9Wldech3EkbKgUKh3kkjBFcJFoOMVvn3txiZufpf0E
         4MHA==
X-Gm-Message-State: AOAM530ubWYfaLSTtZNTXV1knw2M5CTk53siSRBVmfvcj9GNCgeX/uin
        YmmB/hvzjCdAF0eaC6+yh8xwO4aU8Amk2XH7bKw=
X-Google-Smtp-Source: ABdhPJyVdRH8ISLGx6EwWm+K33JXVkBn3dtEGv1vaDd624Yo2W4EWD95gRtwXAK5BHi/KWthgHd4+0aEY4Na+z4iet4=
X-Received: by 2002:a05:6808:14c2:: with SMTP id f2mr16123105oiw.154.1638648699091;
 Sat, 04 Dec 2021 12:11:39 -0800 (PST)
MIME-Version: 1.0
References: <CAJZ5v0hQaF-ANLc4JO=Ub_JMsqLFpZev_gmpb=NPpg=zmqcauA@mail.gmail.com>
 <CAHk-=wiGbtmc+FoUjcgaQRavL=B=rfTmA_VhTtGpmhmk2873cA@mail.gmail.com>
In-Reply-To: <CAHk-=wiGbtmc+FoUjcgaQRavL=B=rfTmA_VhTtGpmhmk2873cA@mail.gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Sat, 4 Dec 2021 21:11:27 +0100
Message-ID: <CAJZ5v0janj--CTeVndJAwiaset5tP8XYdXmeW1hHREcO4BefZw@mail.gmail.com>
Subject: Re: [GIT PULL] ACPI fixes for v5.16-rc3
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 4, 2021 at 6:04 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Fri, Nov 26, 2021 at 11:38 AM Rafael J. Wysocki <rafael@kernel.org> wrote:
> >
> >  git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
> >  acpi-5.16-rc3
>
> Hmm. This may be unrelated, but I don't think I've seen this before..

No, this is not related.  It shows up because of the drain_workqueue()
in __acpi_ec_flush_work().

> On my laptop, I get
>
>   WARNING: CPU: 4 PID: 95940 at kernel/workqueue.c:1441 __queue_work+0x2f9/0x3b0
>   Workqueue: kec_query acpi_ec_event_processor
>   ..
>   Call Trace:
>    <TASK>
>    queue_work_on+0x20/0x30

So this tries to add work to ec_wq while it is draining AFAICS.

>    advance_transaction+0x1a1/0x500
>    acpi_ec_transaction+0x15c/0x410
>    acpi_ec_space_handler+0xd2/0x270
>    acpi_ev_address_space_dispatch+0x216/0x2a3
>    ? acpi_ec_resume+0x20/0x20
>    acpi_ex_access_region+0x1dc/0x255
>    ? acpi_os_wait_semaphore+0x48/0x70
>    acpi_ex_field_datum_io+0xfd/0x178
>    acpi_ex_read_data_from_field+0x12e/0x171
>    acpi_ex_resolve_node_to_value+0x1fe/0x281
>    acpi_ds_evaluate_name_path+0x75/0xe9
>    acpi_ds_exec_end_op+0x8f/0x411
>    acpi_ps_parse_loop+0x495/0x5bc
>    acpi_ps_parse_aml+0x94/0x2c2
>    acpi_ps_execute_method+0x15e/0x193
>    acpi_ns_evaluate+0x1c6/0x25d
>    acpi_evaluate_object+0x12e/0x226
>    acpi_ec_event_processor+0x63/0x90
>    process_one_work+0x217/0x3c0
>
> and it seems to be happening at resume time.
>
> This was when running a51e3ac43ddb, so not the very latest git tree,
> but recent.
>
> Maybe I've missed a report of this?

It's not been reported or at least I can't recall that, but it is not
a new issue.

There is a commit to address this in my linux-next branch:

https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git/commit/?h=linux-next&id=4a9af6cac050dce2e895ec3205c4615383ad9112

but it is interesting that you can reproduce it.  I thought it would
be rather theoretical.
