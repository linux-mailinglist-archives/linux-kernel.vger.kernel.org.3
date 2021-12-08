Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79EF346DBC9
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Dec 2021 20:06:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239563AbhLHTJt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Dec 2021 14:09:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239539AbhLHTJl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Dec 2021 14:09:41 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56017C061746
        for <linux-kernel@vger.kernel.org>; Wed,  8 Dec 2021 11:06:09 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id gx15-20020a17090b124f00b001a695f3734aso2914937pjb.0
        for <linux-kernel@vger.kernel.org>; Wed, 08 Dec 2021 11:06:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=NGA2q2VsUM2cI5mDY1kVnR2zsJ+ewtF8ziLdmNVyVXs=;
        b=Dmz8TDvJFvsFXcsGhw9rz1QO91aJZsstFvBKgCmtwmm919aOwE6XE26qOh8ivQX653
         2+fgikF2daf5zELtpZauMcnttE0cqfhv81pbGYuVFv+G4PM1mZd5/uScM3+kroYxaYoO
         iSiowsr2/3ilutM6RBZIYde8W+ZekKvyP/A4F6iKNPEHxRaeRV2yVO7PGXmi8qzDg9k7
         4jEDKyA8KjZKyloW0tUwFvUY6ymKRt6Ccgi+EIcX6HrhmnNcSSMGrV+cyDJUUuNzx4Q9
         wjqByiON8NotJdaB2dmw6/U2jw0n7AJkzRHigh9JvhveBb8um/TIyvxaK2KqK5h9Sdfi
         D1fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=NGA2q2VsUM2cI5mDY1kVnR2zsJ+ewtF8ziLdmNVyVXs=;
        b=OKBmpHLsMd53l8wOIDa9aWVfrFtDJVbBSgDpndhDygfN5tM+buzzh31mStlW5S6whc
         BTY9M6ttq3ZckwSwOScYu/8RlJhGTixy2LNvfxZ8ZtVzINxXJ+nWHWdKJnAD2wxqLYzN
         VZ5KjLXYw1QXZTOZiV9kI+/KGQ0wTptOu6OhroyCHDl3ry+1WlkEwv/0XuwZfEl5sQvS
         skU/KlRMbQp3/k4H699oMWMllOkC56/gqMZUFx81LMvMPAV/jb1NDudnZ0ZUSIsINrUd
         5Vn02ypwuK83qGtTHWFnwD5J42rnGO1m86wIS9XisFHPpToTPk6Eb7rWMcZ8nxKAdvm5
         iLug==
X-Gm-Message-State: AOAM5337Uuh+FlgSW9gEKYW19RVzsHb3iEYDW7dKQWQRNF+PFtTqlAI2
        n9W/cv5QcSOFfOWL3XMLAI8=
X-Google-Smtp-Source: ABdhPJwVbRUOa5O3ZZoJhqnVAQ5IX3x60YM4KrjeoqsLJ6H7+AggK42TIJmXNCnHAIya6WlxTt2EvQ==
X-Received: by 2002:a17:90a:2fc7:: with SMTP id n7mr9385097pjm.141.1638990368667;
        Wed, 08 Dec 2021 11:06:08 -0800 (PST)
Received: from localhost (2603-800c-1a02-1bae-e24f-43ff-fee6-449f.res6.spectrum.com. [2603:800c:1a02:1bae:e24f:43ff:fee6:449f])
        by smtp.gmail.com with ESMTPSA id mr2sm3432626pjb.25.2021.12.08.11.06.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Dec 2021 11:06:08 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Wed, 8 Dec 2021 09:06:06 -1000
From:   Tejun Heo <tj@kernel.org>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
        linux-kernel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Kees Cook <keescook@chromium.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jim Newsome <jnewsome@torproject.org>,
        Alexey Gladkov <legion@kernel.org>, security@kernel.org,
        Andy Lutomirski <luto@amacapital.net>,
        Jann Horn <jannh@google.com>
Subject: Re: [PATCH] exit: Retain nsproxy for exit_task_work() work entries
Message-ID: <YbECHjMLPEHO0vqA@slm.duckdns.org>
References: <20211208180501.11969-1-mkoutny@suse.com>
 <87sfv3540t.fsf@email.froward.int.ebiederm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87sfv3540t.fsf@email.froward.int.ebiederm.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, Eric.

On Wed, Dec 08, 2021 at 12:45:54PM -0600, Eric W. Biederman wrote:
> Permission checks on files need to happen at open time, not at
> write time.  It is all too easy to confuse something that writes
> to stdout to write to a file of your choosing to make permission
> checking at write time a good idea.

Whether a given operation is allowed or not is dependent on the content of
the write. I don't see how it can be moved to open time. I'm not a fan of
the fs based interface but they're not real files and it has been like this
from the beginning.

> That said I can't quite tell if the test should be moved into
> cgroup_file_open or if there is a permission entry that would work.

It can't.

> I may be wrong but at first glance this looks like the cgroup code is
> going to need significant surgery to get the permission checks happening
> at open time where they belong.

There's no way to change that without changing the interface drastically.

> Please don't apply this patch.
> 
> exit_task_work running after exit_task_namespaces is the messenger
> that just told us about something ugly.

I don't see good alternatives here. You got any?

Thanks.

-- 
tejun
