Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF49A494C03
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jan 2022 11:45:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376374AbiATKpC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jan 2022 05:45:02 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:43789 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1376373AbiATKpA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jan 2022 05:45:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1642675499;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=kX+pu+Lp5VnrEzf41aOccHYagPzdKOujjotR8Q1un+c=;
        b=cTsR47lRXNSvLbEQZJd0Y5WAeEaQySKBo5HOGinlBs5W/e25y42jSV51hjs6PzGjil5/DT
        vQFicFCirj93wO6QcXdTGyHH04+iIsc3//3St14xW4MYKuMRpna+VRd2Mh6kxNnbj7WneN
        KaRt3av+Li/QTWcconO8VregSapBMzk=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-411-Qs-YU4YAOeeMn_7bbUK7Zw-1; Thu, 20 Jan 2022 05:44:58 -0500
X-MC-Unique: Qs-YU4YAOeeMn_7bbUK7Zw-1
Received: by mail-ed1-f71.google.com with SMTP id cf15-20020a0564020b8f00b0040284b671c6so5501301edb.22
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jan 2022 02:44:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=kX+pu+Lp5VnrEzf41aOccHYagPzdKOujjotR8Q1un+c=;
        b=2b+6RD/uGN3nR2UyFX04Swc1ragzEpDi98rRi0uQ9feLJBSOLsQz6uXptK7v9kCg2O
         kWkzogdbSeGOaaLUFmxHVQx/f111k1lNJX/nZafeJIpJdDLF4wV+tOzii1/MxfE1P+jg
         AhF2yZFoJHxLLKim3W6+/bbdmh3XFE3ZCGDoEwfAvGoSXBxWFp9ZDMxJRYPFzrzATHKx
         t9A6DgG1k7mBmytWiguwOXcjKwsgrw6aTvc3fCw86udWS60QnTb8ZZ9ae4KQJN3ZJ2xC
         LT61Mo4W/F+LGr2Gs6uVzyQlP1J8kCu95TtVFZzD/QsAC5/ku9Ut5iQsesbv9VsWKLCy
         OgSw==
X-Gm-Message-State: AOAM530XHl43JxK79VSHsLRnUokd2AJcjCt3gWY+pNlbNbRZyDEexa2b
        CSHXa87niC5/oeTqiq+0ppFvXpdFjCTA260I48wntCD4jURH0gi0GB8xA7ujppA5gXD3+MbsY5y
        nawLliSJJ+JNHnDFVEVamK3qx
X-Received: by 2002:a05:6402:2803:: with SMTP id h3mr36105225ede.241.1642675497196;
        Thu, 20 Jan 2022 02:44:57 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyjARLhfYm29sjlnTYujKowEOv25kxTDg3c9udfzGwVbNwty28AzlkAFfqoo+s+jkviUx9CjA==
X-Received: by 2002:a05:6402:2803:: with SMTP id h3mr36105201ede.241.1642675497034;
        Thu, 20 Jan 2022 02:44:57 -0800 (PST)
Received: from krava (nat-pool-brq-u.redhat.com. [213.175.37.12])
        by smtp.gmail.com with ESMTPSA id l3sm843873ejg.44.2022.01.20.02.44.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jan 2022 02:44:56 -0800 (PST)
Date:   Thu, 20 Jan 2022 11:44:54 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, netdev@vger.kernel.org,
        bpf@vger.kernel.org, lkml <linux-kernel@vger.kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        "Naveen N . Rao" <naveen.n.rao@linux.ibm.com>,
        Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
        "David S . Miller" <davem@davemloft.net>
Subject: Re: [RFC PATCH v3 7/9] bpf: Add kprobe link for attaching raw kprobes
Message-ID: <Yek9Jq1UVa8fq91n@krava>
References: <164260419349.657731.13913104835063027148.stgit@devnote2>
 <164260427009.657731.15292670471943106202.stgit@devnote2>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <164260427009.657731.15292670471943106202.stgit@devnote2>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 19, 2022 at 11:57:50PM +0900, Masami Hiramatsu wrote:

SNIP

> +static int kprobe_link_prog_run(struct bpf_kprobe_link *kprobe_link,
> +				struct pt_regs *regs)
> +{
> +	struct bpf_trace_run_ctx run_ctx;
> +	struct bpf_run_ctx *old_run_ctx;
> +	int err;
> +
> +	if (unlikely(__this_cpu_inc_return(bpf_prog_active) != 1)) {
> +		err = 0;
> +		goto out;
> +	}
> +
> +	old_run_ctx = bpf_set_run_ctx(&run_ctx.run_ctx);
> +	run_ctx.bpf_cookie = kprobe_link->bpf_cookie;
> +
> +	rcu_read_lock();
> +	migrate_disable();
> +	err = bpf_prog_run(kprobe_link->link.prog, regs);
> +	migrate_enable();
> +	rcu_read_unlock();
> +
> +	bpf_reset_run_ctx(old_run_ctx);
> +
> + out:
> +	__this_cpu_dec(bpf_prog_active);
> +	return err;
> +}
> +
> +static void kprobe_link_entry_handler(struct fprobe *fp, unsigned long entry_ip,
> +				      struct pt_regs *regs)
> +{
> +	struct bpf_kprobe_link *kprobe_link;
> +
> +	/*
> +	 * Because fprobe's regs->ip is set to the next instruction of
> +	 * dynamic-ftrace insturction, correct entry ip must be set, so
> +	 * that the bpf program can access entry address via regs as same
> +	 * as kprobes.
> +	 */
> +	instruction_pointer_set(regs, entry_ip);

ok, so this actually does the stall for me.. it changes
the return address back to repeat the call again

bu I think it's good idea to carry the original ip in regs
(for bpf_get_func_ip helper) so I think we need to save it
first and restore after the callback

I'll make the fix and add cookie change Andrii asked for
on top of your ftrace changes and let you know

thanks,
jirka

> +	kprobe_link = container_of(fp, struct bpf_kprobe_link, fp);
> +	kprobe_link_prog_run(kprobe_link, regs);
> +}
> +

SNIP

