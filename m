Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B63B4DA375
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 20:48:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351472AbiCOTtU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 15:49:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245391AbiCOTtS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 15:49:18 -0400
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56F97DEA0
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 12:48:06 -0700 (PDT)
Received: by mail-qt1-x833.google.com with SMTP id c4so159753qtx.1
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 12:48:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jzTzwH5r+B8zHWp2dL9bIRp+jnDQp4u6qStPolr36JI=;
        b=SVFOtodruKnk3NeRKIG5/VG4myOANEFzk02YEJ0NuwwHWsE4VW6a5bvyR4IHJYh6tI
         qLGRCkAWEu1W3EUTBUpHvk3+xcmTBepwVGz8/ujzD59oWiwx8m1A3KGiIeIyn7PJbr3n
         cjI5Tq52DG0wgeJnFutkLs0F3maHVsyVr/X5u9lk521S/opk+v81JmdUxwNgLKf2tpAl
         OPY6ngods97/J3fjOT8eK1o8F2/Rgkgh5P5e94VScnMUVWoPV8/FsuijXoBvUUqKJnYc
         MTyeXlAe8IEPYmqhRiBfvUoce+l+/IIOq2B35ZPzKtYGeXOCBAjAL1+suZcEXA+xd7+P
         bq2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jzTzwH5r+B8zHWp2dL9bIRp+jnDQp4u6qStPolr36JI=;
        b=yuVq9tCokSH2hr71zynMrnB+ZlTeYwfh2tu2QiSgrJBZbFokHKlgJluo2Y0naq82bs
         mriVv1coyFYRH4Vi5Y9i6WIfbDaSvC6LL92p1e8i035PB1Fn1Xzg7Hnk4IEJ3PjEbRBN
         +zFhRzCtkwM2pORjK9KnE/W/lDo3sUnHNfWAzoec64dLHS4SC3Teq8ItYuHTz0I/L2kv
         uLvwjDSes+iUZ9jOZAqgpDwWhAXOyGrU0y9qLV9Yj5OayxF1Qx9YsciawR1VfFJpO5N3
         UccsA2D8hvKwhNrQra0qQGH3KQKokZ5SBKDL1EJEy33UEK6rqxeE97JK6dUsgpf+oxEl
         w1nA==
X-Gm-Message-State: AOAM531qqLDv19OQQX3HlrebGqa+Itzd6jW3D20V6AgOl8QoO9Vp6bg3
        5lwOMcAlG4DFinPHgR5oySvcNKHBgzzOBFevB3T7Vg==
X-Google-Smtp-Source: ABdhPJyXelC5s4w2x3SOsGNEaEWzPS5GKbL0dBxyHDUfFy3ZT9Bs9ZtipguBQMOUHwLyYFwcDvQ5ZAKqn0tSEJj2osQ=
X-Received: by 2002:a05:622a:170a:b0:2e1:cdae:28df with SMTP id
 h10-20020a05622a170a00b002e1cdae28dfmr10979314qtk.299.1647373685297; Tue, 15
 Mar 2022 12:48:05 -0700 (PDT)
MIME-Version: 1.0
References: <20220225234339.2386398-1-haoluo@google.com> <20220225234339.2386398-2-haoluo@google.com>
 <YiwXnSGf9Nb79wnm@zeniv-ca.linux.org.uk> <CA+khW7g+T2sAkP1aycmts_82JKWgYk5Y0ZJp+EvjFUyNY8W_5w@mail.gmail.com>
 <Yi/LaZ5id4ZjqFmL@zeniv-ca.linux.org.uk> <CA+khW7jhD0+s9kivrd6PsNEaxmDCewhk_egrsxwdHPZNkubJYA@mail.gmail.com>
 <YjDiQbam/P+KkgKE@zeniv-ca.linux.org.uk>
In-Reply-To: <YjDiQbam/P+KkgKE@zeniv-ca.linux.org.uk>
From:   Hao Luo <haoluo@google.com>
Date:   Tue, 15 Mar 2022 12:47:54 -0700
Message-ID: <CA+khW7h=Ykav0c=vZQTMeVumxgNwq-pRgko1VTk4wjzCVnxHFA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1 1/9] bpf: Add mkdir, rmdir, unlink syscalls
 for prog_bpf_syscall
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        KP Singh <kpsingh@kernel.org>,
        Shakeel Butt <shakeelb@google.com>,
        Joe Burton <jevburton.kernel@gmail.com>,
        Tejun Heo <tj@kernel.org>, joshdon@google.com, sdf@google.com,
        bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 15, 2022 at 12:02 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> On Tue, Mar 15, 2022 at 10:27:39AM -0700, Hao Luo wrote:
>
> > Option 1: We can put restrictions on the pathname passed into this
> > helper. We can explicitly require the parameter dirfd to be in bpffs
> > (we can verify). In addition, we check pathname to be not containing
> > any dot or dotdot, so the resolved path will end up inside bpffs,
> > therefore won't take ->i_rwsem that is in the callchain of
> > cgroup_mkdir().
>
> Won't be enough - mount --bind the parent under itself and there you go...
> Sure, you could prohibit mountpoint crossing, etc., but at that point
> I'd question the usefulness of pathname resolution in the first place.

[Apologies for resend, my response did not get delivered to mail list]

I don't see a use case where we need to bind mount the directories in
bpffs, right now. So in option 1, we can also prohibit mountpoint
crossing.

Pathname resolution is still useful in this case. Imagine we want to
put all the created dirs under a base dir, we can open the base dir
and reuse its fd for multiple mkdirs, for example:

Userspace:
  fd = openat(..., "/sys/fs/bpf", ...);
  pass fd to the bpf prog

bpf prog:
  bpf_mkdirat(fd, "common1", ...);
  bpf_mkdirat(fd, "common1/a", ...);
  bpf_mkdirat(fd, "common1/b", ...);
  bpf_mkdirat(fd, "common2", ...);
  ...

It would be very inconvenient if we can't resolve multi-level paths.

As Alexei said, another option is to delegate syscall to a worker
thread. IMHO, we could do that in future if we find there is a need
for the full feature of pathname resolution.

Al, does that sound good?
