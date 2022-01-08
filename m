Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB49B4884BD
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jan 2022 17:53:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234772AbiAHQx1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Jan 2022 11:53:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231398AbiAHQx0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Jan 2022 11:53:26 -0500
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com [IPv6:2607:f8b0:4864:20::b35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2FA3C06173F;
        Sat,  8 Jan 2022 08:53:25 -0800 (PST)
Received: by mail-yb1-xb35.google.com with SMTP id i3so25986971ybh.11;
        Sat, 08 Jan 2022 08:53:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wRueC447D4PZrB32erkJF3XwhKSeC1rTxvcavGyEUwk=;
        b=ZrVqbaPjn7kIDuXaAq+QHRgZEfEXSm7q2xeT9TzSeiG9qyNBaZP/pT58cJuw+YpbNd
         oir+ZzEBgOrjXyFlJoGojSQQT1mLfJjsufsu7juL7AzWmzB/W460pLiAHR5MrSQ/xou4
         7e/POZbW9uwsiZB9s8aOb4G72BM8ou89f21nuT1FjPGeFtFxjDq6HDZcvQ7u9edPPXe0
         4FeUk55iNhv2lwwcbfBO+UOv39L1K/WtMo5gIumbiGeKoD2uuLRm3KyTgJxJqgh5e6Rz
         WEdc2HwC2ON3ERih1nMOxyFT+mZdUbvwzh+OMVemtgqkpn40BF1foSUlvUPv9Zlz4+6a
         V0cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wRueC447D4PZrB32erkJF3XwhKSeC1rTxvcavGyEUwk=;
        b=P2xIgBux8hZeRHJE3pdD0EC8fe2zR4L/UpJCYyeHvZGOrp5nySIFNo/ySsHKm9oaVS
         Ha1gbGdn8FnVk0SR6UJiikGDRwFCwbaaF9pMe4ObWxNw9/wGy2jC3oso6aFehx5zqvSQ
         VHEYTgknDcUZmPQh5DYbVkjh5nQ+7X6jtk4IPnzoo0ouJEb3DjV95hXKWpeNpxdQIQ82
         /YlcrsGT8kmhDcoJX2jhxXWS61vjB09KX9Q0y1nkv539Zol3YyzQe/nfCsNiQujJKpBP
         QIZIoREwKwbyt2mDQhNqz+06eGbiVTYzyI5y8Z5iEtjiMIm12gu8YA1bX8LXXBud93ee
         qx2g==
X-Gm-Message-State: AOAM533p+SPDFrF4BCZNIlyC5dmLysyO90QKvut0xRs+yZfBjZB52JE8
        30k/U27vbJiv2yi7bAhSz9qrcaxKxQPF2BKd3eP4NvsKSMO4Bw==
X-Google-Smtp-Source: ABdhPJzxEId/ef5PfNvO/2kgKT3ZEILPu/ThbMWisj0D2vBTpaNodUYRbNAlgHFENDIUk1FfCydjmJYQIOm3ixIiokw=
X-Received: by 2002:a25:e647:: with SMTP id d68mr73393299ybh.591.1641660805023;
 Sat, 08 Jan 2022 08:53:25 -0800 (PST)
MIME-Version: 1.0
References: <1641483250-18839-1-git-send-email-quic_pintu@quicinc.com>
 <1641578854-14232-1-git-send-email-quic_pintu@quicinc.com> <19cce51e24584c2a8090b618c580a0bd@AcuMS.aculab.com>
In-Reply-To: <19cce51e24584c2a8090b618c580a0bd@AcuMS.aculab.com>
From:   Pintu Agarwal <pintu.ping@gmail.com>
Date:   Sat, 8 Jan 2022 22:23:13 +0530
Message-ID: <CAOuPNLh-WLxJ7w=_C7zKXArgZLbO7OahHHhuwAyN9E1yZvNTdQ@mail.gmail.com>
Subject: Re: [PATCH v2] sysinfo: include availram field in sysinfo struct
To:     David Laight <David.Laight@aculab.com>
Cc:     Pintu Kumar <quic_pintu@quicinc.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "ebiederm@xmission.com" <ebiederm@xmission.com>,
        "christian.brauner@ubuntu.com" <christian.brauner@ubuntu.com>,
        "sfr@canb.auug.org.au" <sfr@canb.auug.org.au>,
        "legion@kernel.org" <legion@kernel.org>,
        "sashal@kernel.org" <sashal@kernel.org>,
        "gorcunov@gmail.com" <gorcunov@gmail.com>,
        "chris.hyser@oracle.com" <chris.hyser@oracle.com>,
        "ccross@google.com" <ccross@google.com>,
        "pcc@google.com" <pcc@google.com>,
        "dave@stgolabs.net" <dave@stgolabs.net>,
        "caoxiaofeng@yulong.com" <caoxiaofeng@yulong.com>,
        "david@redhat.com" <david@redhat.com>,
        "vbabka@suse.cz" <vbabka@suse.cz>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        dhowells@redhat.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 8 Jan 2022 at 03:52, David Laight <David.Laight@aculab.com> wrote:
>
> From: Pintu Kumar
> > Sent: 07 January 2022 18:08
> >
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
> ...
> > diff --git a/include/uapi/linux/sysinfo.h b/include/uapi/linux/sysinfo.h
> > index 435d5c2..fe84c6a 100644
> > --- a/include/uapi/linux/sysinfo.h
> > +++ b/include/uapi/linux/sysinfo.h
> > @@ -19,7 +19,8 @@ struct sysinfo {
> >       __kernel_ulong_t totalhigh;     /* Total high memory size */
> >       __kernel_ulong_t freehigh;      /* Available high memory size */
> >       __u32 mem_unit;                 /* Memory unit size in bytes */
> > -     char _f[20-2*sizeof(__kernel_ulong_t)-sizeof(__u32)];   /* Padding: libc5 uses this.. */
>
> There are 4 pad bytes here on most 64bit architectures.
>
> > +     __kernel_ulong_t availram;      /* Memory available for allocation */
> > +     char _f[20-3*sizeof(__kernel_ulong_t)-sizeof(__u32)];   /* Padding: libc5 uses this.. */
> >  };
>
> You've not compile-time tested the size of the structure.
>
With "32" instead of "20" in padding I get these size of sysinfo:
In x86-64 kernel, with app 64-bit: Size of sysinfo = 128
In x86-64 kernel, with app 32-bit:: Size of sysinfo = 76
In arm-64 kernel, with app 32-bit: Size of sysinfo = 76

Okay the sys robot reported some issue in 64-bit build.
{{{
>> include/uapi/linux/sysinfo.h:23:14: error: size of array '_f' is too large
>>    23 |         char _f[20-3*sizeof(__kernel_ulong_t)-sizeof(__u32)];   /* Padding: libc5 uses this.. */
>>       |              ^~
}}}

Also, I got the same issue while building for arm64, so I tried to
adjust like this:
char _f[32-3*sizeof(__kernel_ulong_t)-sizeof(__u32)];

With this the build works on both 32/64 but output fails when running
32-bit program on 64-bit kernel.
Also, the free command on 64-bit reports "stack smashing error"..

How do we resolve this issue to make it work on both arch ?
Also, I don't really understand the significance of that number "20"
in padding ?

Thanks,
Pintu
