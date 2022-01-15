Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C25A48F8F9
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jan 2022 20:10:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233524AbiAOTKE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Jan 2022 14:10:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230456AbiAOTKD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Jan 2022 14:10:03 -0500
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1EC1C061574
        for <linux-kernel@vger.kernel.org>; Sat, 15 Jan 2022 11:10:01 -0800 (PST)
Received: by mail-lf1-x12d.google.com with SMTP id x11so16070137lfa.2
        for <linux-kernel@vger.kernel.org>; Sat, 15 Jan 2022 11:10:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=references:user-agent:from:to:cc:subject:in-reply-to:date
         :message-id:mime-version;
        bh=5Wi+6MmSkY2OW0q/hS2GC39OxWrOREADF/T3XkKj5H0=;
        b=Y7mlO/lle1fDQL/M2XmqVRnPG4OUPB5oAqzNOwLfc18XLzt0Cm9gaOP1pEuMxXqN/n
         bsmV2iTIfWXQ0EPYBfGMEXxbjuQxrqkNxnPLq6pwZSYKHErNIym3qFDN+tABKsIoRq8Z
         3Vg825EJRjV3NfXgTjGOklQW0JkPHw/WFlFos=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject
         :in-reply-to:date:message-id:mime-version;
        bh=5Wi+6MmSkY2OW0q/hS2GC39OxWrOREADF/T3XkKj5H0=;
        b=Uz8Gd3aF0nbr8+cvMQkstIGA4OaFWbZCsHl/2tWjIxydFE6WPumybcrlLN9SvpJ8xN
         /9kgx3gWFsJWFRLbsZb6HQYnmwLYtGbLlZ55+aJ0RCXE9GlNVpyu+X0NuIrulaRJKL0u
         VvI9WM3zvt3TQVbtHydKF1cy/ZUUqZp/65mA6HBRbfXk11DYb9gHxEMp6LW5sD6aMnRV
         S2EM8sxRJvUqcmyynt4mEs4rNpOobCXo4YAVnrVtsYTzX/gTK/POs2y4jso/rJkMNPa8
         VX37QYZys3fx/PWIQPoEtzKGqWuuBwKWwpDwd+YERJCgnqt/Vrxv4zVfLqe7OD52KGLV
         lLnA==
X-Gm-Message-State: AOAM5338gMBvuoj6KyGZMotNeM74jdyFCeq5NWc9JE/WtCBuRnqX7k0U
        wXDASrvQsaKSGqOB2YhSD+Cncg==
X-Google-Smtp-Source: ABdhPJzxaqY34Kakyt9o4SKHw0EixMc4Z9ioWCbRGwBrXBmS5vlbItTFdpWETX9bK6C/zzwv+crqEA==
X-Received: by 2002:a2e:a4a7:: with SMTP id g7mr9959770ljm.59.1642273799972;
        Sat, 15 Jan 2022 11:09:59 -0800 (PST)
Received: from cloudflare.com ([2a01:110f:4809:d800::e00])
        by smtp.gmail.com with ESMTPSA id i6sm238875lfb.76.2022.01.15.11.09.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Jan 2022 11:09:59 -0800 (PST)
References: <58661dd93a834a2abbe42dd16da93e0b@huawei.com>
 <CAEf4Bzax8aWb68favtYGUUYS0BshMAJNy+0Mj0GHNXxDZY2KCA@mail.gmail.com>
User-agent: mu4e 1.1.0; emacs 27.2
From:   Jakub Sitnicki <jakub@cloudflare.com>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     "zhudi (E)" <zhudi2@huawei.com>,
        Alexei Starovoitov <ast@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, Martin Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        john fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>, bpf <bpf@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        "Luzhihao (luzhihao, Euler)" <luzhihao@huawei.com>,
        "Chenxiang (EulerOS)" <rose.chen@huawei.com>
Subject: Re: [PATCH bpf-next v5 1/2] bpf: support BPF_PROG_QUERY for progs
 attached to sockmap
In-reply-to: <CAEf4Bzax8aWb68favtYGUUYS0BshMAJNy+0Mj0GHNXxDZY2KCA@mail.gmail.com>
Date:   Sat, 15 Jan 2022 20:09:59 +0100
Message-ID: <871r18q0hk.fsf@cloudflare.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 15, 2022 at 03:53 AM CET, Andrii Nakryiko wrote:
> On Fri, Jan 14, 2022 at 6:38 PM zhudi (E) <zhudi2@huawei.com> wrote:
>>
>> > On Thu, Jan 13, 2022 at 8:15 AM Jakub Sitnicki <jakub@cloudflare.com> wrote:
>> > >
>> > > On Thu, Jan 13, 2022 at 10:00 AM CET, Di Zhu wrote:

[...]

>> > > > +int sock_map_bpf_prog_query(const union bpf_attr *attr,
>> > > > +                         union bpf_attr __user *uattr)
>> > > > +{
>> > > > +     __u32 __user *prog_ids = u64_to_user_ptr(attr->query.prog_ids);
>> > > > +     u32 prog_cnt = 0, flags = 0, ufd = attr->target_fd;
>> > > > +     struct bpf_prog **pprog;
>> > > > +     struct bpf_prog *prog;
>> > > > +     struct bpf_map *map;
>> > > > +     struct fd f;
>> > > > +     u32 id = 0;
>> > > > +     int ret;
>> > > > +
>> > > > +     if (attr->query.query_flags)
>> > > > +             return -EINVAL;
>> > > > +
>> > > > +     f = fdget(ufd);
>> > > > +     map = __bpf_map_get(f);
>> > > > +     if (IS_ERR(map))
>> > > > +             return PTR_ERR(map);
>> > > > +
>> > > > +     rcu_read_lock();
>> > > > +
>> > > > +     ret = sock_map_prog_lookup(map, &pprog, attr->query.attach_type);
>> > > > +     if (ret)
>> > > > +             goto end;
>> > > > +
>> > > > +     prog = *pprog;
>> > > > +     prog_cnt = !prog ? 0 : 1;
>> > > > +
>> > > > +     if (!attr->query.prog_cnt || !prog_ids || !prog_cnt)
>> > > > +             goto end;
>> > > > +
>> > > > +     id = prog->aux->id;
>> > >
>> > > ^ This looks like a concurrent read/write.
>> >
>> > You mean that bpf_prog_load() might be setting it in a different
>> > thread? I think ID is allocated and fixed before prog FD is available
>> > to the user-space, so prog->aux->id is set in stone and immutable in
>> > that regard.
>>
>> What we're talking about here is that bpf_prog_free_id() will write the id
>> identifier synchronously.
>
> Hm.. let's say bpf_prog_free_id() happens right after we read id 123.
> It's impossible to distinguish that from reading valid ID (that's not
> yet freed), returning it to user-space and before user-space can do
> anything about that this program and it's ID are freed. User-space
> either way will get an ID that's not valid anymore. I don't see any
> use of READ_ONCE/WRITE_ONCE with prog->aux->id, which is why I was
> asking what changed.
>

You're right, READ_ONCE/WRITE_ONCE is not improving anything here.

I've suggested it not to make the query op more reliable, but rather to
mark the shared access.

But in this case annotating it with data_race() [1] would be a better
fit, I think, because we don't care if we get the old or the new value.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/tools/memory-model/Documentation/access-marking.txt#n58

>>
>> >
>> > >
>> > > Would wrap with READ_ONCE() and corresponding WRITE_ONCE() in
>> > > bpf_prog_free_id(). See [1] for rationale.
>> > >
>> > > [1]
>> > https://github.com/google/kernel-sanitizers/blob/master/other/READ_WRITE_O
>> > NCE.md
>> > >

[...]
