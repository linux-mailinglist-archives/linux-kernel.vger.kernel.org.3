Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89E2746BD2B
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 15:03:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237510AbhLGOGp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 09:06:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237429AbhLGOGn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 09:06:43 -0500
Received: from mail-ua1-x92a.google.com (mail-ua1-x92a.google.com [IPv6:2607:f8b0:4864:20::92a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D99EC061574
        for <linux-kernel@vger.kernel.org>; Tue,  7 Dec 2021 06:03:13 -0800 (PST)
Received: by mail-ua1-x92a.google.com with SMTP id p2so26712717uad.11
        for <linux-kernel@vger.kernel.org>; Tue, 07 Dec 2021 06:03:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iv4MZHpg9+XiA+tVT8cP5y6XOJdTeoCNwCFRc76ApJA=;
        b=RvdI66/PlmYiW3OYZ4zWhMExkYLm/bPVKAd5DnJ4M6MujtrN2QDr4Jx/PmbKzgBmXS
         xNDJnQ0igFy8HS1lh+Rqcw+usDz+njpuY2iE6JPb0fLAAfryL9Lx84RFFrmdGtBgvPvM
         xS4BrwCv2sMVFTLf2OvByd5+YQvKUUlzIDOgw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iv4MZHpg9+XiA+tVT8cP5y6XOJdTeoCNwCFRc76ApJA=;
        b=lj+Irumy9enXty9j2377NA5X+9qdEgnsDdn/dDZkX4awcmpqWsMjaDyAAG8aQt4KVT
         KaJ+9t390CJ22Rm9XUcblGdGo9/lr6ZMHPQ1mWoBwWO5g/JBb5zF9HtBEO6EAeE130rh
         G3KUcscdWa+xVmmTdLVH5cUFUCvkKZCoGJeXNgO9w45NusdHwQiq10tIFNkk8LqGKVZU
         1upKvCVG0h4PQIfikblSnRtv7fHjXL5c0EYGeWzdydQS/Rhkpfd1R5+V2SKA60YXlEbZ
         pRNzNUxZeGOwOnzf+mlDCYcDsT94IPnGWRbd1IMx6yk++qeI3FPyivk6ninH8gQTJKLL
         P0dA==
X-Gm-Message-State: AOAM533UxjU+gd85O4w/W/cFUJBMPmlvHLRFoAqz/Sk1v1suUKQUWqK5
        peMhqtN7IwaUFAtJ0arFWXg3eh7IUCINSWefNWZvIg==
X-Google-Smtp-Source: ABdhPJyPF+G2PUMHKn04AcAEdLaHfZHTeFcCVEZ7VRllfqBvl9kNcGrASgqyIE4cXjsBVALJhAsHoZmB3Bl1SX9iTs4=
X-Received: by 2002:a05:6102:c4e:: with SMTP id y14mr47053652vss.61.1638885792380;
 Tue, 07 Dec 2021 06:03:12 -0800 (PST)
MIME-Version: 1.0
References: <1638780405-38026-1-git-send-email-quic_pragalla@quicinc.com>
 <CAJfpegvDfc9JUo6VASRyYXzj1=j3t6oU9W3QGWO08vhfWHf-UA@mail.gmail.com>
 <Ya8ycLODlcvLx4xB@hirez.programming.kicks-ass.net> <CAJfpegsVg2K0CvrPvXGSu=Jz_R3VZZOy49Jw51rThQUJ1_9e6g@mail.gmail.com>
 <Ya86coKm4RuQDmVS@hirez.programming.kicks-ass.net> <CAJfpegumZ1RQLBCtbrOiOAT9ygDtDThpySwb8yCpWGBu1fRQmw@mail.gmail.com>
 <Ya9ljdrOkhBhhnJX@hirez.programming.kicks-ass.net> <Ya9m0ME1pom49b+D@hirez.programming.kicks-ass.net>
In-Reply-To: <Ya9m0ME1pom49b+D@hirez.programming.kicks-ass.net>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Tue, 7 Dec 2021 15:03:01 +0100
Message-ID: <CAJfpegt2x1ztuzh0niY7fgx1UKxDGsAkJbS0wVPp5awxwyhRpA@mail.gmail.com>
Subject: Re: [PATCH V1] fuse: give wakeup hints to the scheduler
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@redhat.com>, quic_stummala@quicinc.com,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        quic_pkondeti@quicinc.com, quic_sayalil@quicinc.com,
        quic_aiquny@quicinc.com, quic_zljing@quicinc.com,
        quic_blong@quicinc.com, quic_richardp@quicinc.com,
        quic_cdevired@quicinc.com,
        Pradeep P V K <quic_pragalla@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 7 Dec 2021 at 14:51, Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Tue, Dec 07, 2021 at 02:45:49PM +0100, Peter Zijlstra wrote:
>
> > > What would be much nicer, is to look at all the threads on the waitq
> > > and pick one that previously ran on the current CPU if there's one.
> > > Could this be implemented?
> >
> > It would violate the FIFO semantics of _exclusive.
>
> That said, look at
> kernel/locking/percpu-rwsem.c:percpu_rwsem_wake_function() for how to do
> really terrible things with waitqueues, possibly including what you
> suggest.

Okay, so it looks doable, but rather more involved than just sticking
that _sync onto the wake helper.

FIFO is used so that we always wake the most recently used thread, right?

That makes sense if it doesn't involve migration, but if the hot
thread is going to be moved to another CPU then we'd lost most of the
advantages.  Am I missing something?

Thanks,
Miklos
