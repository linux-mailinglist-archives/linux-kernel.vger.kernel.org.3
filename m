Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F8EB4867E8
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jan 2022 17:50:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241443AbiAFQuI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jan 2022 11:50:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241433AbiAFQuH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jan 2022 11:50:07 -0500
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A787DC061201
        for <linux-kernel@vger.kernel.org>; Thu,  6 Jan 2022 08:50:07 -0800 (PST)
Received: by mail-yb1-xb2f.google.com with SMTP id d201so9104675ybc.7
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jan 2022 08:50:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WzPx2KD6yStcW6nRPoF0Fgqsc5KQDTzeS8k9qPSrfEI=;
        b=OH9W6LBtCG37NkHK6GpDpHDcEo81EoyG/qeL+Mrh8imbEAQgT+CbZDpKWDw5VN7WQA
         Sg9njO7IjbAzzrztX4Y2viSJF6FWiq7UBNj/VBtMZlvcycQh8gkSXN63xvjinOyGVlep
         PIHmpXjyt+qX53Jbg376VARVEusuisI9S+rdeP2r+2Uf6Beq7vQlOxUVA6t6azgkGxd9
         nnvLWrGKUyp7Ay+60vdm3OXGHVKh+lPbd8maPGsBaT7yI4+FbIxsenCaViResYZQYZnA
         7UES+4Gvv6UZ2Y9GEPHJYPLiJn1IDwmXcitUCgkN3FD0SzGDZvUvuXtbv2vO3RvFhLnF
         B4Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WzPx2KD6yStcW6nRPoF0Fgqsc5KQDTzeS8k9qPSrfEI=;
        b=8Chs6LGYJ3V1wBHut6bdmeDHIDk7iFB/FqarpAsUGbGTutrdBP4X+LLDTXyLOkIWHH
         W+6DyNksvdrqw3UeSjErKrLtKLCWEQlHyrLvypv2Rep9+yk12UcP6yxlaMXA8CAKjhOn
         O50wSSVcHLAj/Wem7ORzzr7thjnApccINYI3Oi52XvE3DhJ9OiZwQ6t+qfbgX1U1MO+x
         3Abfn85PwB3Ta8U5BPhweKh/zUYzEZLF1pc/4zFkHtawVQJteIWZntJnCwDDR8wIT7nu
         60GGQ08RCr28hI6fm8BOCHmLXQVYyjuXhJlikTnqy9hjkiHwMKc/wsXR+BdZeSe7uMiL
         /qUA==
X-Gm-Message-State: AOAM5322+SjDq9K7GxUp2j8dYUzamq4FFy7M7Qy/j7x8WGR5+3kZwLnG
        oCmjOrLmkxRfW7wbOXaDfVWB+H/0IVyDCcXM9wk=
X-Google-Smtp-Source: ABdhPJznAFEAcdv14txnSN76RN7NFQyxcPEpL12uDYscup8TH0C4bfwnhxPPbMUBiD/e29JLTuZ3T3jof3Yp5enmM88=
X-Received: by 2002:a05:6902:1549:: with SMTP id r9mr37910993ybu.190.1641487806785;
 Thu, 06 Jan 2022 08:50:06 -0800 (PST)
MIME-Version: 1.0
References: <1641483250-18839-1-git-send-email-quic_pintu@quicinc.com> <YdcUttZWaqYQpR1K@grain>
In-Reply-To: <YdcUttZWaqYQpR1K@grain>
From:   Pintu Agarwal <pintu.ping@gmail.com>
Date:   Thu, 6 Jan 2022 22:19:55 +0530
Message-ID: <CAOuPNLifYFPU4Gt2+1sOSsYNNLQq7U2aGVaYknrhaMc-CVx8vg@mail.gmail.com>
Subject: Re: [PATCH] sysinfo: include availram field in sysinfo struct
To:     Cyrill Gorcunov <gorcunov@gmail.com>
Cc:     Pintu Kumar <quic_pintu@quicinc.com>,
        open list <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-mm <linux-mm@kvack.org>, ebiederm@xmission.com,
        christian.brauner@ubuntu.com, sfr@canb.auug.org.au,
        legion@kernel.org, sashal@kernel.org, chris.hyser@oracle.com,
        ccross@google.com, pcc@google.com, dave@stgolabs.net,
        caoxiaofeng@yulong.com, david@redhat.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 6 Jan 2022 at 21:41, Cyrill Gorcunov <gorcunov@gmail.com> wrote:
>
> On Thu, Jan 06, 2022 at 09:04:10PM +0530, Pintu Kumar wrote:
> > The sysinfo member does not have any "available ram" field and
> > the bufferram field is not much helpful either, to get a rough
> > estimate of available ram needed for allocation.
> >
> > One needs to parse MemAvailable field separately from /proc/meminfo
> > to get this info instead of directly getting if from sysinfo itself.
> >
> > Thus, this patch introduce a new field as availram in sysinfo
> > so that all the info total/free/available can be retrieved from
> > one place itself.
> >
> > There are couple of places in kernel as well where this can be improved.
> > For example:
> > In fs/proc/meminfo.c:
> > meminfo_proc_show:
> >    si_meminfo(&i);
> >    available = si_mem_available();
> > Now with this change the second call be avoided.
> > Thus, we can directly do:
> > show_val_kb(m, "MemAvailable:   ", i.availram);
> >
> > Note, this also requires update in procfs for free and other commands.
> > Like in free command as well we frist call sysinfo then again parse
> > /proc/meminfo to get available field.
> > This can be avoided too with higher kernel version.
> >
> > A sample output with single sysinfo call is shown below:
> > Total RAM: 248376 kB
> >  Free RAM: 231540 kB
> > Avail RAM: 230448 kB
> >
> > Signed-off-by: Pintu Kumar <quic_pintu@quicinc.com>
> > Signed-off-by: Pintu Agarwal <pintu.ping@gmail.com>
> > ---
> >  include/uapi/linux/sysinfo.h | 1 +
> >  kernel/sys.c                 | 4 ++++
> >  mm/page_alloc.c              | 2 ++
> >  3 files changed, 7 insertions(+)
> >
> > diff --git a/include/uapi/linux/sysinfo.h b/include/uapi/linux/sysinfo.h
> > index 435d5c2..6e77e90 100644
> > --- a/include/uapi/linux/sysinfo.h
> > +++ b/include/uapi/linux/sysinfo.h
> > @@ -12,6 +12,7 @@ struct sysinfo {
> >       __kernel_ulong_t freeram;       /* Available memory size */
> >       __kernel_ulong_t sharedram;     /* Amount of shared memory */
> >       __kernel_ulong_t bufferram;     /* Memory used by buffers */
> > +     __kernel_ulong_t availram;      /* Memory available for allocation */
> >       __kernel_ulong_t totalswap;     /* Total swap space size */
> >       __kernel_ulong_t freeswap;      /* swap space still available */
> >       __u16 procs;                    /* Number of current processes */
>
> Hi! Sorry, but I don't understand -- the sysinfo structure seems to
> be part of user API, no? Don't we break it up here?

Yes, the corresponding user space header /usr/include/linux/sysinfo.h
also needs to be updated.
When we generate the kernel header it will be updated automatically.
