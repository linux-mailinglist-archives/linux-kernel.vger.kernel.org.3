Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2223488481
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jan 2022 17:24:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232122AbiAHQYu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Jan 2022 11:24:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229553AbiAHQYu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Jan 2022 11:24:50 -0500
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0F18C06173F;
        Sat,  8 Jan 2022 08:24:49 -0800 (PST)
Received: by mail-yb1-xb30.google.com with SMTP id e198so3183664ybf.7;
        Sat, 08 Jan 2022 08:24:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FJiGba+y5KGrEUxQgPj+i1n6kxwf6tPsHxl5ZtLV1Jk=;
        b=Er0wHgv/5O39B6X1Eaoa+gOdkArRi0M7BbwKHauENahE6CMrveIBNNesOhCkvScO/A
         i593kkGA/wbBUyW7ckhON+UPpr351NDk24ubAa51UCFmN2/HsQZXpr/a7BQELoRoT/g4
         VfAw0hLKjrJSQMDoAHo3rlddCdqhVIZ/aGGOUSbCjamLuX7byDfb2Dyt8FDxrfEK1N60
         JAQ2uumbdpeZL3j98Tkal2glWYgdHFHxtv7EXNvObkz97OmEh7qdjEG5pLu9jRyKVsCl
         dDt5QD6ZI2OpoVOqqpYUFdxQ2Tt/LMx6jKlPH4oKg90nHegtuqS4EX53456Ig8pDGzwt
         SpGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FJiGba+y5KGrEUxQgPj+i1n6kxwf6tPsHxl5ZtLV1Jk=;
        b=F51dXE7MyRmqkDXHVKgOs0oIMnOrU4W5NAl8MLs3Wbz98lhkxlBJa/32vjWae7wRzb
         UAmuEpJR9qomW4jQ3/FX05lAciWroqPhfEEiYVzyN2L6FPc1tMAKqAq+YBPoTi3e4aLs
         87Pgwdjpj0E32riWVwQ38xGdQSSRAWKZ+XwyzknBN2f7PfWhcVq0c6Keknd+99miK4Kl
         75lW+Qyk+17kWqgI9qpohYmZKsZYY2GpZXsc5CXuzG9xKIrDEcUr/yUg2cthnZi0nmsw
         siFIlUa0hvOwRiKO32+0h3uinxM9lE06bwACKvromkBGtao37GLT+RVhjQ3oXU6Gq5Kr
         cxXQ==
X-Gm-Message-State: AOAM532QqPT49N8wn72VxoGdukIX88Q1HyX9rFF7Bu1NQKMsRFMcpfQg
        YLWX+k6LYZipVxVt9Ripioph5JKMciwcCVTTF6Y=
X-Google-Smtp-Source: ABdhPJx5mT0kNIzk8te7NqOcqysk500acHoavT5wfZvcDgQRdUA4MHK7GEmuQ344scSMOsFJ5FpOveStGfHW2c/Zn8k=
X-Received: by 2002:a25:6c55:: with SMTP id h82mr89848305ybc.214.1641659088758;
 Sat, 08 Jan 2022 08:24:48 -0800 (PST)
MIME-Version: 1.0
References: <1641483250-18839-1-git-send-email-quic_pintu@quicinc.com>
 <1641578854-14232-1-git-send-email-quic_pintu@quicinc.com> <YdiqLKS5Sv9eWwu2@grain>
In-Reply-To: <YdiqLKS5Sv9eWwu2@grain>
From:   Pintu Agarwal <pintu.ping@gmail.com>
Date:   Sat, 8 Jan 2022 21:54:37 +0530
Message-ID: <CAOuPNLhcvbk3-rTPqmJj5LBOh4VaZ+Bc=-_j6xKOLM-kH6jkfw@mail.gmail.com>
Subject: Re: [PATCH v2] sysinfo: include availram field in sysinfo struct
To:     Cyrill Gorcunov <gorcunov@gmail.com>
Cc:     Pintu Kumar <quic_pintu@quicinc.com>,
        open list <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-mm <linux-mm@kvack.org>, ebiederm@xmission.com,
        Christian Brauner <christian.brauner@ubuntu.com>,
        sfr@canb.auug.org.au, legion@kernel.org, sashal@kernel.org,
        chris.hyser@oracle.com, Colin Cross <ccross@google.com>,
        Peter Collingbourne <pcc@google.com>, dave@stgolabs.net,
        caoxiaofeng@yulong.com, david@redhat.com,
        Vlastimil Babka <vbabka@suse.cz>, linux-api@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 8 Jan 2022 at 02:31, Cyrill Gorcunov <gorcunov@gmail.com> wrote:
>
> On Fri, Jan 07, 2022 at 11:37:34PM +0530, Pintu Kumar wrote:
> > The sysinfo member does not have any "available ram" field and
> > the bufferram field is not much helpful either, to get a rough
> > estimate of available ram needed for allocation.
> >
> > One needs to parse MemAvailable field separately from /proc/meminfo
> > to get this info instead of directly getting if from sysinfo itself.
>
> Who exactly needs this change? Do you have some application for which
> parsing /proc/meminfo is a hot path so it needs this information via
> sysinfo interface?
>
Thank you so much for your feedback...
I had a need to get total/free/available memory in my application (on
a memory constraint system).
First I tried to parse these from /proc/meminfo but then I saw sysinfo
already provides some information,
however available field was missing. Just to get available field I
need to again do all the file operations.

Then I saw, even the "free" command doing this redundant work.
Use sysinfo system call to get "total" and "free" memory then again
get "available" memory from /proc/meminfo.
Yet again, I see, even in kernel its reading from two different places
while populating the /proc/meminfo.
Also, I am sure there are plenty of other applications where this can
be improved with this.
Moreover, I think with this field there is not much use of other ram
fields in sysinfo.
Thus I felt a need to introduce this field to ease some operations.

> Don't get me wrong please but such extension really need a strong
> justification because they are part of UAPI and there is not that much
> space left in sysinfo structure. We will _have_ to live with this new
> field forever so I propose to not introduce anything new here until
> we have no other choise or parsing meminfo become a really bottleneck.
>
My guess is that this situation might exist in other places as well ?
How do we handle new field addition to existing system calls ?

> > diff --git a/kernel/sys.c b/kernel/sys.c
> > index ecc4cf0..7059515 100644
> > --- a/kernel/sys.c
> > +++ b/kernel/sys.c
> > @@ -2671,6 +2671,7 @@ static int do_sysinfo(struct sysinfo *info)
> >       info->freeram <<= bitcount;
> >       info->sharedram <<= bitcount;
> >       info->bufferram <<= bitcount;
> > +     info->availram <<= bitcount;
> >       info->totalswap <<= bitcount;
> >       info->freeswap <<= bitcount;
> >       info->totalhigh <<= bitcount;
> > @@ -2700,6 +2701,7 @@ struct compat_sysinfo {
> >       u32 freeram;
> >       u32 sharedram;
> >       u32 bufferram;
> > +     u32 availram;
>
> If only I'm not missing something ovious, this is part of UAPI as well.
Yes, this structure is part of the common UAPI header.
