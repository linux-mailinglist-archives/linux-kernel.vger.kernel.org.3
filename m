Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3CE364894BD
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 10:10:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242205AbiAJJJ5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 04:09:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238722AbiAJJJ4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 04:09:56 -0500
Received: from mail-ua1-x931.google.com (mail-ua1-x931.google.com [IPv6:2607:f8b0:4864:20::931])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 876BAC06173F
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jan 2022 01:09:56 -0800 (PST)
Received: by mail-ua1-x931.google.com with SMTP id u6so22280780uaq.0
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jan 2022 01:09:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lxyrRBORblw0BIzYf45ygoGccnnqJ68ftVE4lqW7LFs=;
        b=aUMRDZywtLHjd2MUlB0CcYcSVqK5GSWBCEeXxh3hqd7JE6yrcm+I2PnEPcqHb7mj7T
         My/v7uGFNXH2yqFfdAUh0z/URTTr0vmSdun62vu/Ec7FppOS7ySyBB6mT9YLKafVNIdG
         iVv5Ud+vqrY9FgY08+mkehFvHXK5VkFRb4JOCE00xY6OcZepptslfyZsGUQmGOMbRDeg
         deK5X8uUD3rcjE4JSl4ochZMyXB8wgZ7PnypxmRs+UfS+fqKlhqWPl7jLSED7pyxTL9/
         j8C8pZU+xRfdsImGMPTmLXQONqVPCLFWIeY2LjKyKgxX6ZUelWBT1VXMjEGv38dw60k2
         qm+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lxyrRBORblw0BIzYf45ygoGccnnqJ68ftVE4lqW7LFs=;
        b=wd5uxXFoefNKJdEhe9JnjaOfZTaQDHJfYiV1FWybuGTPbOziPESZh7pB5JZqovHa3A
         UlyA/wl81L3gFceuC2JgBKy3o2Nsa4DlBK2UZkvMNfIyyLkKMz4HmwYdObLrjrDgZB5G
         Y03Orz+RTtFqp+UawIo9/5uJffweK8lL8KC+ounSP8wFa+CcRuDZzrsI2J0wQFISij8J
         grLR70WCxB5DWWYYSVI/o2rQj34w5WujmxPw/6z20SPEXMVxvvQIakD6qT9cLJT47lVX
         Lw5WwDNHEktaMTPCYZhcqWhCwGes+9HgAMCBqMEW/9z2x+P+MBE4jAPOskQXc0u4T8+M
         BZvw==
X-Gm-Message-State: AOAM530fBqlhMzS6jJ4e8BViiOpgXg42oLMxZNbJIDx+kPlIanqGXOT7
        mifgDYg6W0AvvNpMlQTv+3tv5VWJAdZKh2GRh0+amQ==
X-Google-Smtp-Source: ABdhPJxIXuD0RJUuIyPJdRHEFzWt17OGUmxkn4iNeMnH30r3S67MX7X0e5jl9NHv50y7QOVXek968GzSo9ia7466bNs=
X-Received: by 2002:ab0:2a16:: with SMTP id o22mr26471886uar.36.1641805795365;
 Mon, 10 Jan 2022 01:09:55 -0800 (PST)
MIME-Version: 1.0
References: <58644a55-561d-4a2e-6741-589d013837f1@huawei.com>
In-Reply-To: <58644a55-561d-4a2e-6741-589d013837f1@huawei.com>
From:   Jann Horn <jannh@google.com>
Date:   Mon, 10 Jan 2022 10:09:29 +0100
Message-ID: <CAG48ez0Xz=22u4tCwt9s8WqmOvtFB3ajbaiyt1MWkAtytu0wUQ@mail.gmail.com>
Subject: Re: Questions about the patch 054aa8d439b9 ("fget: check that the fd
 still exists after getting a ref to it")
To:     "libaokun (A)" <libaokun1@huawei.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        mszeredi@redhat.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "zhangyi (F)" <yi.zhang@huawei.com>,
        YueHaibing <yuehaibing@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 22, 2021 at 11:32 AM libaokun (A) <libaokun1@huawei.com> wrote:
> > From: Linus Torvalds <torvalds@linux-foundation.org>
> > Date: Wed, 1 Dec 2021 10:06:14 -0800
> > Subject: fget: check that the fd still exists after getting a ref to it
> >
> > Jann Horn points out that there is another possible race wrt Unix domain
> > socket garbage collection, somewhat reminiscent of the one fixed in
> > commit cbcf01128d0a ("af_unix: fix garbage collect vs MSG_PEEK").
> >
> > See the extended comment about the garbage collection requirements added
> > to unix_peek_fds() by that commit for details.
> >
> > The race comes from how we can locklessly look up a file descriptor just
> > as it is in the process of being closed, and with the right artificial
> > timing (Jann added a few strategic 'mdelay(500)' calls to do that), the
> > Unix domain socket garbage collector could see the reference count
> > decrement of the close() happen before fget() took its reference to the
> > file and the file was attached onto a new file descriptor.
>
> I analyzed this CVE and tried to reproduce it.
>
> I guess he triggered it like the stack below.
>
>
> close_fd                               |
>   pick_file                             |
>                                         | __fget_files
> file = files_lookup_fd_rcu(files, fd); |
>                                         |
> rcu_assign_pointer(fdt->fd[fd], NULL);
>   filp_close                            |
>    fput                                 |
>                                         | get_file_rcu_many // ned ref>=1
>     fput_many(file, 1);                 |
>      file_free(file);                   |
>                                         |  return file
>                                         |  // read-after-free

The race is more complicated than that; you also need to add unix_gc()
to the race. And if you want to get to memory corruption, you need one
or two more races involving unix_stream_read_generic() on top of that.

> If you want to successfully execute the get_file_rcu_many function,
>
> the reference counting of the file is greater than or equal to 1 and
>
> is greater than or equal to 2 after the execution.
>
> However, close releases only one reference count and does not release
> the file,
>
> so read-after-free does not occur. So how is the race triggered here?

This bug does not lead to a UAF of the file, it leads to a locking
inconsistency between the unix stream read path and the GC.

> The question has been pondered for a long time without any results.
>
> Could I get more details (e.g. reproduction methods or stacks) from you ?

See https://bugs.chromium.org/p/project-zero/issues/detail?id=2247 for
the original bug report. I'm also working on a more detailed blog
post, but that isn't finished yet.
