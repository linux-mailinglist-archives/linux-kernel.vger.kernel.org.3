Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F11B546BB8E
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 13:45:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236589AbhLGMsh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 07:48:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236579AbhLGMsb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 07:48:31 -0500
Received: from mail-ua1-x92a.google.com (mail-ua1-x92a.google.com [IPv6:2607:f8b0:4864:20::92a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCA0FC061574
        for <linux-kernel@vger.kernel.org>; Tue,  7 Dec 2021 04:45:00 -0800 (PST)
Received: by mail-ua1-x92a.google.com with SMTP id 30so7650730uag.13
        for <linux-kernel@vger.kernel.org>; Tue, 07 Dec 2021 04:45:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3ChVHxxOxhIGs4rdOWG75rsbNvdLDYwE9pw3zOgGr8M=;
        b=cagc1Fsf3e3/RtlMkfBVVOFkZIH9p/PFEuLPjNipBOP0t1oa1QC8YVzGB+j92EPAwe
         6DTlD2JOtMKDSlPhKnOM/oxgdUt/VXmnnMYFugCOVpgB0FnYTJy1E6vbsmqTHC0EmMFK
         nWgrrOt3CxGahgD0XTFo6KthaMQ6T+bGXHxJg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3ChVHxxOxhIGs4rdOWG75rsbNvdLDYwE9pw3zOgGr8M=;
        b=ZqPP5KMi90IqCiIirAa/A+utQL4YPYX4xxwONwZKcvk4QxmANGxHd2prDJ9sMSEMS6
         zh9YXOhmbiha2e0XDlEF2pVSDkBEWYNJ40Qnj09eqzJZvrG0jjggX9jsZBS2vMvm/S3n
         jKUAV9htSMgV9IjA0sdaKX1y2cOId0qghsoinkkwSdCThI8hhE5aFw8ntZTKbzl4i61X
         0CCHxPI1fHhg/JYOkKXr7jXvi1SSxWpLDER7EhytrricW14ZUJNloVIw4m6Xxvk3m4Js
         lnk8qkKSMoysLd3cSEdoVy5+TtB8yiqfoA8cT56l6PwI97GSfjqWqKvC9M6o8joOCOwC
         +UKg==
X-Gm-Message-State: AOAM533z19n+AMo0QANcS5TTcT6yulws/S5TR4MkmKjyj6cgLgSD5eK9
        HKOv5ZosByY8sSa8hPmJ0PtGqledUi+FK+eLc5sSOPafemJKjQ==
X-Google-Smtp-Source: ABdhPJy6rksSBimk0QbT52WvsQczQrLRNltJbKL+leXstLsmKjLOHPKljfGjuHPqEwiWodirXVF16UvBFmqK2b8HX34=
X-Received: by 2002:a05:6102:945:: with SMTP id a5mr44302178vsi.87.1638881099983;
 Tue, 07 Dec 2021 04:44:59 -0800 (PST)
MIME-Version: 1.0
References: <1638780405-38026-1-git-send-email-quic_pragalla@quicinc.com>
 <CAJfpegvDfc9JUo6VASRyYXzj1=j3t6oU9W3QGWO08vhfWHf-UA@mail.gmail.com>
 <Ya8ycLODlcvLx4xB@hirez.programming.kicks-ass.net> <CAJfpegsVg2K0CvrPvXGSu=Jz_R3VZZOy49Jw51rThQUJ1_9e6g@mail.gmail.com>
 <Ya86coKm4RuQDmVS@hirez.programming.kicks-ass.net>
In-Reply-To: <Ya86coKm4RuQDmVS@hirez.programming.kicks-ass.net>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Tue, 7 Dec 2021 13:44:49 +0100
Message-ID: <CAJfpegumZ1RQLBCtbrOiOAT9ygDtDThpySwb8yCpWGBu1fRQmw@mail.gmail.com>
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

On Tue, 7 Dec 2021 at 11:42, Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Tue, Dec 07, 2021 at 11:20:59AM +0100, Miklos Szeredi wrote:

> > That may be good for fuse as the data is indeed shared.  It would be
> > even better if the woken task had already a known affinity to this
> > CPU, since that would mean thread local data wouldn't have to be
> > migrated each time...   So I'm not sure sync wakeup alone is worth it,
> > needs real life benchmarking.
>
> Hard affinities have other down-sides.. occasional migrations shouldn't
> be a problem, constant migrations are bad.

Currently fuse readers are sleeping in
wait_event_interruptible_exclusive().  wake_up_interruptible_sync()
will pick the first thread in the queue and wake that up.  That will
likely result in migration, right?

What would be much nicer, is to look at all the threads on the waitq
and pick one that previously ran on the current CPU if there's one.
Could this be implemented?

Thanks,
Miklos
