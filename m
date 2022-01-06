Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B2E22486661
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jan 2022 15:57:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240257AbiAFO5S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jan 2022 09:57:18 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:47292 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240245AbiAFO5P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jan 2022 09:57:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1641481035;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=WyQPJI+hEo4Yj1jUmLhmtNkYsUJguWTxcYd9w3Q6E2E=;
        b=Hj3M9L31BkQmB+oQQpWAw4pWvQ8hoDBzORVWL/T6G9+JZPOupNzpKqDahSttJFe9SgnbQk
        7iNOxLNnMkTq+Suvh5lGBiyN8iJYRO/v5gRxzP+toWlApNoaSlW1DRorOYSgbLu/+SXojw
        Qty/zYogpL+ae+CVhqlw6irNeHx2IQ0=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-75-GyBpHlYmNsS3UzW6Pv4z0g-1; Thu, 06 Jan 2022 09:57:14 -0500
X-MC-Unique: GyBpHlYmNsS3UzW6Pv4z0g-1
Received: by mail-ed1-f70.google.com with SMTP id y18-20020a056402271200b003fa16a5debcso2125500edd.14
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jan 2022 06:57:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=WyQPJI+hEo4Yj1jUmLhmtNkYsUJguWTxcYd9w3Q6E2E=;
        b=Agho+WvRs0yI3qPlXHXHxTZHZgDXU2POMYbH1WE//yJNBUFb/rt2c9Sh1ZxZUPY/+R
         q8CU0llm1q2faaqbw+yuWdPrJkqBGlQv+9wYayMF8AzPy1k59wlDYdbJNTxDxcckI9Kr
         s7Z0G6TOgylyaVPuD7JutHpZqXrNfr0gHs0vckrRsj/gLZHg5zFtbUdPKF7kDSmBruqA
         m/Gp5yzs27yeNrFAQ3PK2jkxPvUyxmHxuv0vKwnxvjVmB3X4fvTSiBtyJzncmRHDnZD+
         IRLiEhWlyGHEZKEtFd3V67SogYyj2+5kYWZNXwsMFMToC6amoLYYETv/9DlVWUiVYkmv
         iVvA==
X-Gm-Message-State: AOAM532ifRFZTtpQYjeCYMWyxtHzUluWWT6CwAt30mm9LUJc8ceuMyT2
        zmhXYU5tl5lSJ1X8Zkivx07kru5VRIVK1FpqkIGAatceQFoHsPJmOCxwbtr1ROTL5RU528sQ0pO
        kwuRk+/GtNQWJDCh29Rco4DXF
X-Received: by 2002:a17:907:628d:: with SMTP id nd13mr5474694ejc.431.1641481032747;
        Thu, 06 Jan 2022 06:57:12 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyoyE70BXRIKkWTb3eHQNX6/HYfwE4FUA5F++leaCr2dgmba8ya+07Av/6pViQ02HNwmLs5Ig==
X-Received: by 2002:a17:907:628d:: with SMTP id nd13mr5474680ejc.431.1641481032497;
        Thu, 06 Jan 2022 06:57:12 -0800 (PST)
Received: from krava (nat-pool-brq-u.redhat.com. [213.175.37.12])
        by smtp.gmail.com with ESMTPSA id o25sm804427edr.20.2022.01.06.06.57.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jan 2022 06:57:12 -0800 (PST)
Date:   Thu, 6 Jan 2022 15:57:10 +0100
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
        "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>,
        Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: Re: [RFC 00/13] kprobe/bpf: Add support to attach multiple kprobes
Message-ID: <YdcDRqmgOeOMmyoM@krava>
References: <20220104080943.113249-1-jolsa@kernel.org>
 <20220106002435.d73e4010c93462fbee9ef074@kernel.org>
 <YdaoTuWjEeT33Zzm@krava>
 <20220106225943.87701fcc674202dc3e172289@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220106225943.87701fcc674202dc3e172289@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 06, 2022 at 10:59:43PM +0900, Masami Hiramatsu wrote:

SNIP

> > > 
> > > Hmm, I think there may be a time to split the "kprobe as an 
> > > interface for the software breakpoint" and "kprobe as a wrapper
> > > interface for the callbacks of various instrumentations", like
> > > 'raw_kprobe'(or kswbp) and 'kprobes'.
> > > And this may be called as 'fprobe' as ftrace_ops wrapper.
> > > (But if the bpf is enough flexible, this kind of intermediate layer
> > >  may not be needed, it can use ftrace_ops directly, eventually)
> > > 
> > > Jiri, have you already considered to use ftrace_ops from the
> > > bpf directly? Are there any issues?
> > > (bpf depends on 'kprobe' widely?)
> > 
> > at the moment there's not ftrace public interface for the return
> > probe merged in, so to get the kretprobe working I had to use
> > kprobe interface
> 
> Yeah, I found that too. We have to ask Steve to salvage it ;)

I got those patches rebased like half a year ago upstream code,
so should be easy to revive them

> 
> > but.. there are patches Steven shared some time ago, that do that
> > and make graph_ops available as kernel interface
> > 
> > I recall we considered graph_ops interface before as common attach
> > layer for trampolines, which was bad, but it might actually make
> > sense for kprobes
> 
> I started working on making 'fprobe' which will provide multiple
> function probe with similar interface of kprobes. See attached
> patch. Then you can use it in bpf, maybe with an union like
> 
> union {
> 	struct kprobe kp;	// for function body
> 	struct fprobe fp;	// for function entry and return
> };
> 
> At this moment, fprobe only support entry_handler, but when we
> re-start the generic graph_ops interface, it is easy to expand
> to support exit_handler.
> If this works, I think kretprobe can be phased out, since at that
> moment, kprobe_event can replace it with the fprobe exit_handler.
> (This is a benefit of decoupling the instrumentation layer from
> the event layer. It can choose the best way without changing
> user interface.)
> 

I can resend out graph_ops patches if you want to base
it directly on that

> > I'll need to check it in more details but I think both graph_ops and
> > kprobe do about similar thing wrt hooking return probe, so it should
> > be comparable.. and they are already doing the same for the entry hook,
> > because kprobe is mostly using ftrace for that
> > 
> > we would not need to introduce new program type - kprobe programs
> > should be able to run from ftrace callbacks just fine
> 
> That seems to bind your mind. The program type is just a programing
> 'model' of the bpf. You can choose the best implementation to provide
> equal functionality. 'kprobe' in bpf is just a name that you call some
> instrumentations which can probe kernel code.

I don't want to introduce new type, there's some dependencies
in bpf verifier and helpers code we'd need to handle for that

I'm looking for solution for current kprobe bpf program type
to be registered for multiple addresses quickly

> 
> Thank you,
> 
> > 
> > so we would have:
> >   - kprobe type programs attaching to:
> >   - new BPF_LINK_TYPE_FPROBE link using the graph_ops as attachment layer
> > 
> > jirka
> > 
> 
> 
> -- 
> Masami Hiramatsu <mhiramat@kernel.org>

> From 269b86597c166d6d4c5dd564168237603533165a Mon Sep 17 00:00:00 2001
> From: Masami Hiramatsu <mhiramat@kernel.org>
> Date: Thu, 6 Jan 2022 15:40:36 +0900
> Subject: [PATCH] fprobe: Add ftrace based probe APIs
> 
> The fprobe is a wrapper API for ftrace function tracer.
> Unlike kprobes, this probes only supports the function entry, but
> it can probe multiple functions by one fprobe. The usage is almost
> same as the kprobe, user will specify the function names by
> fprobe::syms, the number of syms by fprobe::nsyms, and the user
> handler by fprobe::handler.
> 
> struct fprobe = { 0 };
> const char *targets[] = {"func1", "func2", "func3"};
> 
> fprobe.handler = user_handler;
> fprobe.nsyms = ARRAY_SIZE(targets);
> fprobe.syms = targets;
> 
> ret = register_fprobe(&fprobe);
> ...
> 
> 
> Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
> ---
>  include/linux/fprobes.h |  52 ++++++++++++++++
>  kernel/trace/Kconfig    |  10 ++++
>  kernel/trace/Makefile   |   1 +
>  kernel/trace/fprobes.c  | 128 ++++++++++++++++++++++++++++++++++++++++
>  4 files changed, 191 insertions(+)
>  create mode 100644 include/linux/fprobes.h
>  create mode 100644 kernel/trace/fprobes.c
> 
> diff --git a/include/linux/fprobes.h b/include/linux/fprobes.h
> new file mode 100644
> index 000000000000..22db748bf491
> --- /dev/null
> +++ b/include/linux/fprobes.h
> @@ -0,0 +1,52 @@
> +#ifndef _LINUX_FPROBES_H
> +#define _LINUX_FPROBES_H
> +/* Simple ftrace probe wrapper */
> +
> +#include <linux/compiler.h>
> +#include <linux/ftrace.h>
> +
> +struct fprobe {
> +	const char		**syms;
> +	unsigned long		*addrs;

could you add array of user data for each addr/sym?

SNIP

> +static int populate_func_addresses(struct fprobe *fp)
> +{
> +	unsigned int i;
> +
> +	fp->addrs = kmalloc(sizeof(void *) * fp->nsyms, GFP_KERNEL);
> +	if (!fp->addrs)
> +		return -ENOMEM;
> +
> +	for (i = 0; i < fp->nsyms; i++) {
> +		fp->addrs[i] = kallsyms_lookup_name(fp->syms[i]);
> +		if (!fp->addrs[i]) {
> +			kfree(fp->addrs);
> +			fp->addrs = NULL;
> +			return -ENOENT;
> +		}
> +	}
> +
> +	return 0;
> +}
> +
> +/**
> + * register_fprobe - Register fprobe to ftrace
> + * @fp: A fprobe data structure to be registered.
> + *
> + * This expects the user set @fp::syms or @fp::addrs (not both),
> + * @fp::nsyms (number of entries of @fp::syms or @fp::addrs) and
> + * @fp::handler. Other fields are initialized by this function.
> + */
> +int register_fprobe(struct fprobe *fp)
> +{
> +	unsigned int i;
> +	int ret;
> +
> +	if (!fp)
> +		return -EINVAL;
> +
> +	if (!fp->nsyms || (!fp->syms && !fp->addrs) || (fp->syms && fp->addrs))
> +		return -EINVAL;
> +
> +	if (fp->syms) {
> +		ret = populate_func_addresses(fp);
> +		if (ret < 0)
> +			return ret;
> +	}
> +
> +	fp->ftrace.func = fprobe_handler;
> +	fp->ftrace.flags = FTRACE_OPS_FL_SAVE_REGS;
> +
> +	for (i = 0; i < fp->nsyms; i++) {
> +		ret = ftrace_set_filter_ip(&fp->ftrace, fp->addrs[i], 0, 0);
> +		if (ret < 0)
> +			goto error;
> +	}

I introduced ftrace_set_filter_ips, because loop like above was slow:
  https://lore.kernel.org/bpf/20211118112455.475349-4-jolsa@kernel.org/

thanks,
jirka

> +
> +	fp->nmissed = 0;
> +	ret = register_ftrace_function(&fp->ftrace);
> +	if (!ret)
> +		return ret;
> +
> +error:
> +	if (fp->syms) {
> +		kfree(fp->addrs);
> +		fp->addrs = NULL;
> +	}
> +
> +	return ret;
> +}
> +
> +/**
> + * unregister_fprobe - Unregister fprobe from ftrace
> + * @fp: A fprobe data structure to be unregistered.
> + */
> +int unregister_fprobe(struct fprobe *fp)
> +{
> +	int ret;
> +
> +	if (!fp)
> +		return -EINVAL;
> +
> +	if (!fp->nsyms || !fp->addrs)
> +		return -EINVAL;
> +
> +	ret = unregister_ftrace_function(&fp->ftrace);
> +
> +	if (fp->syms) {
> +		/* fp->addrs is allocated by register_fprobe() */
> +		kfree(fp->addrs);
> +		fp->addrs = NULL;
> +	}
> +
> +	return ret;
> +}
> -- 
> 2.25.1
> 

