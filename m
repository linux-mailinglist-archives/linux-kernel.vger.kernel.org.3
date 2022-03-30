Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0736F4ECB53
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 20:07:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349786AbiC3SIf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 14:08:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349674AbiC3SI0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 14:08:26 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26D4D3E0EF
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 11:06:32 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id h16so12785285wmd.0
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 11:06:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pTP84B9dyVZKfwd8drRl3JKw0QWiCFZoPqYYt5GdqCE=;
        b=AxlFincx379rRIVIadN5ztg//O5QPtJoihKSTzi1aqCGOqjTBcfglKR2zwT17QzWsN
         aTG7BboIk2UPwEM4mpIyBd6mIKkzQK3kzpBhw2sq5BTWCEBNOCGRfwTU8IbsPqDZJUzf
         drJ/Ho3TMY6tWgXHbxKT9BB5BpW5aNrsWRcpigV6MZue7/2e7/8LPKIJVFirQPBCJ85T
         O34cbD0qhU6uYotQRhWN+eoutFkKNR7UcNa+df/D5wE0ZNX++iQV8t09i7TQPb77bqF3
         swuJvtSm76VwIL9DV8PydNg8cIuqg1E56J+VV57RP0M4+S0oDgKXfXJy1sIPGwYCpyL9
         ftUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pTP84B9dyVZKfwd8drRl3JKw0QWiCFZoPqYYt5GdqCE=;
        b=UvwA2L1VzoVIAJWxDGnDa6RA5KSl+FCW5LXCi2BAixkPl5GU3BL01vrNAALQBoJBOT
         e70v2Yw2NLmaQLlYB3MoJZtwq5lwOCiFzsUhFocsCVswFTuwH387f1PdTck32AJGZain
         5WORxx0dV9d5kvD/wCf7aajJNir1j1ZyawWEk0U3Pg5i+94Pq0Hi79UbeO4x+CSsxrIU
         CvfybHAGFdfMgXSjttEvjn6Fp/0u5RWEoSWWhDFdz7kMKRcR5kMKkkHzzctXfI39TDhx
         IPr3wpGrZDXwZmFOEQQXyLI/xVZkZKOl3K/lDoz3wn5rABdqq042iiRTZVHoXuD4PDhJ
         vE6w==
X-Gm-Message-State: AOAM532GFIDqYfds4MTN+irnynDjJKfJHBqEyAsxKluyxONK9RlcN6Ir
        S3HsKBmysfNaNf0EQdexexOUmI27u/HTS7+wmCqCxw==
X-Google-Smtp-Source: ABdhPJxG6w+8THuSQkBR1uxz7ylmfLzImaV8nRMbUG1IKFnRnhkQ9Sqsojtip3/71qEPWhpgcrn0cxaKpaQEd9fev0o=
X-Received: by 2002:a05:600c:3b89:b0:38c:c9d6:ff0e with SMTP id
 n9-20020a05600c3b8900b0038cc9d6ff0emr652574wms.77.1648663590454; Wed, 30 Mar
 2022 11:06:30 -0700 (PDT)
MIME-Version: 1.0
References: <20220324234123.1608337-1-haoluo@google.com> <9cdf860d-8370-95b5-1688-af03265cc874@fb.com>
 <CA+khW7g3hy61qnvtqUizaW+qB6wk=Y9cjivhORshOk=ZzTXJ-A@mail.gmail.com>
 <CA+khW7iq+UKsfQxdT3QpSqPUFN8gQWWDLoQ9zxB=uWTs63AZEA@mail.gmail.com>
 <20220329093753.26wc3noelqrwlrcj@apollo.legion> <CA+khW7jW47SALTfxMKfQoA0Qwqd22GC0z4S5juFTbxLfTSbFEQ@mail.gmail.com>
 <20220329232956.gbsr65jdbe4lw2m6@ast-mbp>
In-Reply-To: <20220329232956.gbsr65jdbe4lw2m6@ast-mbp>
From:   Hao Luo <haoluo@google.com>
Date:   Wed, 30 Mar 2022 11:06:19 -0700
Message-ID: <CA+khW7jyvp4PKGu5GS8GDf=Lr4EdRUz8kraaTfiZ2oGm704Cpw@mail.gmail.com>
Subject: Re: [PATCH RFC bpf-next 0/2] Mmapable task local storage.
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Kumar Kartikeya Dwivedi <memxor@gmail.com>,
        Yonghong Song <yhs@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        KP Singh <kpsingh@kernel.org>, Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 29, 2022 at 4:30 PM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Tue, Mar 29, 2022 at 10:43:42AM -0700, Hao Luo wrote:
> > On Tue, Mar 29, 2022 at 2:37 AM Kumar Kartikeya Dwivedi
> > <memxor@gmail.com> wrote:
> > >
> > > On Mon, Mar 28, 2022 at 11:16:15PM IST, Hao Luo wrote:
> > > > On Mon, Mar 28, 2022 at 10:39 AM Hao Luo <haoluo@google.com> wrote:
> > > > >
> > > > > Hi Yonghong,
> > > > >
> > > > > On Fri, Mar 25, 2022 at 12:16 PM Yonghong Song <yhs@fb.com> wrote:
> > > > > >
> > > > > > On 3/24/22 4:41 PM, Hao Luo wrote:
> > > > > > > Some map types support mmap operation, which allows userspace to
> > > > > > > communicate with BPF programs directly. Currently only arraymap
> > > > > > > and ringbuf have mmap implemented.
> > > > > > >
> > > > > > > However, in some use cases, when multiple program instances can
> > > > > > > run concurrently, global mmapable memory can cause race. In that
> > > > > > > case, userspace needs to provide necessary synchronizations to
> > > > > > > coordinate the usage of mapped global data. This can be a source
> > > > > > > of bottleneck.
> > > > > >
> > > > > > I can see your use case here. Each calling process can get the
> > > > > > corresponding bpf program task local storage data through
> > > > > > mmap interface. As you mentioned, there is a tradeoff
> > > > > > between more memory vs. non-global synchronization.
> > > > > >
> > > > > > I am thinking that another bpf_iter approach can retrieve
> > > > > > the similar result. We could implement a bpf_iter
> > > > > > for task local storage map, optionally it can provide
> > > > > > a tid to retrieve the data for that particular tid.
> > > > > > This way, user space needs an explicit syscall, but
> > > > > > does not need to allocate more memory than necessary.
> > > > > >
> > > > > > WDYT?
> > > > > >
> > > > >
> > > > > Thanks for the suggestion. I have two thoughts about bpf_iter + tid and mmap:
> > > > >
> > > > > - mmap prevents the calling task from reading other task's value.
> > > > > Using bpf_iter, one can pass other task's tid to get their values. I
> > > > > assume there are two potential ways of passing tid to bpf_iter: one is
> > > > > to use global data in bpf prog, the other is adding tid parameterized
> > > > > iter_link. For the first, it's not easy for unpriv tasks to use. For
> > > > > the second, we need to create one iter_link object for each interested
> > > > > tid. It may not be easy to use either.
> > > > >
> > > > > - Regarding adding an explicit syscall. I thought about adding
> > > > > write/read syscalls for task local storage maps, just like reading
> > > > > values from iter_link. Writing or reading task local storage map
> > > > > updates/reads the current task's value. I think this could achieve the
> > > > > same effect as mmap.
> > > > >
> > > >
> > > > Actually, my use case of using mmap on task local storage is to allow
> > > > userspace to pass FDs into bpf prog. Some of the helpers I want to add
> > > > need to take an FD as parameter and the bpf progs can run
> > > > concurrently, thus using global data is racy. Mmapable task local
> > > > storage is the best solution I can find for this purpose.
> > > >
> > > > Song also mentioned to me offline, that mmapable task local storage
> > > > may be useful for his use case.
> > > >
> > > > I am actually open to other proposals.
> > > >
> > >
> > > You could also use a syscall prog, and use bpf_prog_test_run to update local
> > > storage for current. Data can be passed for that specific prog invocation using
> > > ctx. You might have to enable bpf_task_storage helpers in it though, since they
> > > are not allowed to be called right now.
> > >
> >
> > The loading process needs CAP_BPF to load bpf_prog_test_run. I'm
> > thinking of allowing any thread including unpriv ones to be able to
> > pass data to the prog and update their own storage.
>
> If I understand the use case correctly all of this mmap-ing is only to
> allow unpriv userspace to access a priv map via unpriv mmap() syscall.
> But the map can be accessed as unpriv already.
> Pin it with the world read creds and do map_lookup sys_bpf cmd on it.

Right, but, if I understand correctly, with
sysctl_unprivileged_bpf_disabled, unpriv tasks are not able to make
use of __sys_bpf(). Is there anything I missed?
