Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 248224AD475
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 10:13:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353181AbiBHJNG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 04:13:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240331AbiBHJNB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 04:13:01 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0F75CC03FEC0
        for <linux-kernel@vger.kernel.org>; Tue,  8 Feb 2022 01:12:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1644311576;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=F+Wu/sGGNFwRVA6o9CxafTUWjc6Pw1cGgpDABPbC3kU=;
        b=gH5poQNAp+psXERXpBdlDDmVN7Wi5FwHHIVbsZJRTY/eKGQVeEI4KMfF5Q9IsfuGexHBsK
        J0gzp7tYhAtAf+XuZhMqjZkvvOLuFS+jCLl9/JI4xhbcPImz8xEf8gvg0wdHLGUp5BO/2c
        oFoxtvJhYAM/sneCGR5/uhPt3ooK+OY=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-37-avGnWjRdOimiTs_D6DsVVg-1; Tue, 08 Feb 2022 04:12:54 -0500
X-MC-Unique: avGnWjRdOimiTs_D6DsVVg-1
Received: by mail-ed1-f70.google.com with SMTP id f9-20020a056402354900b0040fb9c35a02so228204edd.18
        for <linux-kernel@vger.kernel.org>; Tue, 08 Feb 2022 01:12:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=F+Wu/sGGNFwRVA6o9CxafTUWjc6Pw1cGgpDABPbC3kU=;
        b=1xQ87bFMAVKnBGrBGQSohdX2sQwjUuLhpwwkSZE9962yg4Ax0nORYKwKV/98tyXOIz
         LM8u2WZWDzwp0mPLdKSghYRoXzJiHhh9VEgg4oQHCnQUnORIrEynmhw9MFhRhjLBf5XI
         kpnsSLo7IYP72MbpGD++KzdnuK1oLDq9wyvssnP2p5C5B1CxMU5qm+0CuFRZekoX9Dq4
         cu1gTcVLdJNh0L5C1EVGP6cF0QXu2mBAyrr5vyYpAbygan2HXneYGxdivwbxLMvWJcd4
         vMKPiJoCQsRMGR7Y6IEJ8mhVZA49n8vK8jsbVep1O0IKdElht888duHXydY8yeMOHJsy
         gvTg==
X-Gm-Message-State: AOAM5301k6oUccnGtOLRoeEQ0CzhhUgIrJbBMqY6wm8fyw1j2CWDRXYp
        hNZBcb9i4QOpf+m4LPgfJV3x6t44bFSFXJGTPRzug3M4gbb5cVOrzruPy8Ydc3AB0npIgWnzwuX
        +N3wErqAncAHRsmBxzlh4OClI
X-Received: by 2002:a17:906:4fc1:: with SMTP id i1mr2822062ejw.248.1644311573609;
        Tue, 08 Feb 2022 01:12:53 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwYBF44TL/lfB6QHqHH1Nak9YF+ZhC2FLFpMGaXqPMTlTXjPgdPNfD12GOzYHV1JeeVLqiaiA==
X-Received: by 2002:a17:906:4fc1:: with SMTP id i1mr2822039ejw.248.1644311573396;
        Tue, 08 Feb 2022 01:12:53 -0800 (PST)
Received: from krava (nat-pool-brq-u.redhat.com. [213.175.37.12])
        by smtp.gmail.com with ESMTPSA id l7sm5760193edb.53.2022.02.08.01.12.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Feb 2022 01:12:52 -0800 (PST)
Date:   Tue, 8 Feb 2022 10:12:51 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Networking <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Jiri Olsa <olsajiri@gmail.com>
Subject: Re: [PATCH 6/8] libbpf: Add bpf_program__attach_kprobe_opts for
 multi kprobes
Message-ID: <YgI0E1D6v0RZa5/Z@krava>
References: <20220202135333.190761-1-jolsa@kernel.org>
 <20220202135333.190761-7-jolsa@kernel.org>
 <CAEf4BzZPSYzyoxrPC4uNHedhTr_75b2Qa8h3OC7GCK-n6mYrdg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEf4BzZPSYzyoxrPC4uNHedhTr_75b2Qa8h3OC7GCK-n6mYrdg@mail.gmail.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 07, 2022 at 10:59:29AM -0800, Andrii Nakryiko wrote:

SNIP

> > +struct fprobe_resolve {
> > +       const char *name;
> > +       __u64 *addrs;
> > +       __u32 alloc;
> > +       __u32 cnt;
> > +};
> > +
> > +static bool glob_matches(const char *glob, const char *s)
> 
> we've since added more generic glob_match() implementation (see
> test_progs.c), let's copy/paste that one (it's actually shorter and
> doesn't do hacky input args modification). Let's maybe also add '?'
> handling (it's trivial). Both original code in perf and the one in
> test_progs.c are GPL-2.0-only, so let's also get acks from original
> authors.

ok, will check

> 
> > +{
> > +       int n = strlen(glob);
> > +
> > +       if (n == 1 && glob[0] == '*')
> > +               return true;
> > +
> > +       if (glob[0] == '*' && glob[n - 1] == '*') {
> > +               const char *subs;
> > +               /* substring match */
> > +
> > +               /* this is hacky, but we don't want to allocate
> > +                * for no good reason
> > +                */
> > +               ((char *)glob)[n - 1] = '\0';
> > +               subs = strstr(s, glob + 1);
> > +               ((char *)glob)[n - 1] = '*';
> > +
> > +               return subs != NULL;
> > +       } else if (glob[0] == '*') {
> > +               size_t nn = strlen(s);
> > +               /* suffix match */
> > +
> > +               /* too short for a given suffix */
> > +               if (nn < n - 1)
> > +                       return false;
> > +               return strcmp(s + nn - (n - 1), glob + 1) == 0;
> > +       } else if (glob[n - 1] == '*') {
> > +               /* prefix match */
> > +               return strncmp(s, glob, n - 1) == 0;
> > +       } else {
> > +               /* exact match */
> > +               return strcmp(glob, s) == 0;
> > +       }
> > +}
> > +
> > +static int resolve_fprobe_cb(void *arg, unsigned long long sym_addr,
> > +                            char sym_type, const char *sym_name)
> > +{
> > +       struct fprobe_resolve *res = arg;
> > +       __u64 *p;
> > +
> > +       if (!glob_matches(res->name, sym_name))
> > +               return 0;
> > +
> > +       if (res->cnt == res->alloc) {
> > +               res->alloc = max((__u32) 16, res->alloc * 3 / 2);
> > +               p = libbpf_reallocarray(res->addrs, res->alloc, sizeof(__u32));
> > +               if (!p)
> > +                       return -ENOMEM;
> > +               res->addrs = p;
> > +       }
> 
> please use libbpf_ensure_mem() instead

ok

> 
> 
> > +       res->addrs[res->cnt++] = sym_addr;
> > +       return 0;
> > +}
> > +
> > +static struct bpf_link *
> > +attach_fprobe_opts(const struct bpf_program *prog,
> > +                  const char *func_name,
> 
> func_glob or func_pattern?

ok

> 
> > +                  const struct bpf_kprobe_opts *kopts)
> > +{
> > +       DECLARE_LIBBPF_OPTS(bpf_link_create_opts, opts);
> > +       struct fprobe_resolve res = {
> > +               .name = func_name,
> > +       };
> > +       struct bpf_link *link = NULL;
> > +       char errmsg[STRERR_BUFSIZE];
> > +       int err, link_fd, prog_fd;
> > +       bool retprobe;
> > +
> > +       err = libbpf__kallsyms_parse(&res, resolve_fprobe_cb);
> > +       if (err)
> > +               goto error;
> > +       if (!res.cnt) {
> > +               err = -ENOENT;
> > +               goto error;
> > +       }
> > +
> > +       retprobe = OPTS_GET(kopts, retprobe, false);
> > +
> > +       opts.fprobe.addrs = (__u64) res.addrs;
> 
> ptr_to_u64()

ok

> 
> > +       opts.fprobe.cnt = res.cnt;
> > +       opts.flags = retprobe ? BPF_F_FPROBE_RETURN : 0;
> > +
> > +       link = calloc(1, sizeof(*link));
> > +       if (!link) {
> > +               err = -ENOMEM;
> > +               goto error;
> > +       }
> > +       link->detach = &bpf_link__detach_fd;
> > +
> > +       prog_fd = bpf_program__fd(prog);
> > +       link_fd = bpf_link_create(prog_fd, 0, BPF_TRACE_FPROBE, &opts);
> > +       if (link_fd < 0) {
> > +               err = -errno;
> > +               pr_warn("prog '%s': failed to attach to %s: %s\n",
> > +                       prog->name, res.name,
> > +                       libbpf_strerror_r(err, errmsg, sizeof(errmsg)));
> > +               goto error;
> > +       }
> > +       link->fd = link_fd;
> > +       free(res.addrs);
> > +       return link;
> > +
> > +error:
> > +       free(link);
> > +       free(res.addrs);
> > +       return libbpf_err_ptr(err);
> > +}
> > +
> >  struct bpf_link *
> >  bpf_program__attach_kprobe_opts(const struct bpf_program *prog,
> >                                 const char *func_name,
> > @@ -10047,6 +10166,9 @@ bpf_program__attach_kprobe_opts(const struct bpf_program *prog,
> >         if (!OPTS_VALID(opts, bpf_kprobe_opts))
> >                 return libbpf_err_ptr(-EINVAL);
> >
> > +       if (prog->expected_attach_type == BPF_TRACE_FPROBE)
> > +               return attach_fprobe_opts(prog, func_name, opts);
> > +
> >         retprobe = OPTS_GET(opts, retprobe, false);
> >         offset = OPTS_GET(opts, offset, 0);
> >         pe_opts.bpf_cookie = OPTS_GET(opts, bpf_cookie, 0);
> > @@ -10112,6 +10234,14 @@ struct bpf_link *bpf_program__attach_kprobe(const struct bpf_program *prog,
> >         return bpf_program__attach_kprobe_opts(prog, func_name, &opts);
> >  }
> >
> > +static int init_kprobe(struct bpf_program *prog, long cookie)
> > +{
> > +       /* If we have wildcard, switch to fprobe link. */
> > +       if (strchr(prog->sec_name, '*'))
> 
> ugh... :( maybe let's have a separate SEC("kprobe.multi/<glob>") and
> same for kretprobe?

I agree new SEC type is more clear ;-) ok

thanks,
jirka

