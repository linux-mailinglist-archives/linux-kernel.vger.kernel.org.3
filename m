Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E253A484FDB
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jan 2022 10:15:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238788AbiAEJPi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jan 2022 04:15:38 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:49379 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230249AbiAEJPd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jan 2022 04:15:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1641374133;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=zs9UnLFawAb7gPF1KC4jejgVgEkRNOfBcosm2G8tD/M=;
        b=iTH5PffhCRJNKzCeQPoilchEJ07B2VqVnZht/f/XaAyYxv7/YrNvaENtI7EtDryskxeS8s
        IjVwFkMGxUpI1nJdTQU1EW6kqHpvY4Fc/SKp2vpYylLbFWV/7gqrz3tVSzyoPpm19aHmjK
        7U+o2O+tlYv+JhW6ev4TgGFhuemjM88=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-595-HpEVmjFsMems9N8mbqeSsA-1; Wed, 05 Jan 2022 04:15:32 -0500
X-MC-Unique: HpEVmjFsMems9N8mbqeSsA-1
Received: by mail-wr1-f71.google.com with SMTP id v15-20020adf8b4f000000b001a24c46d6ceso12361868wra.15
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jan 2022 01:15:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=zs9UnLFawAb7gPF1KC4jejgVgEkRNOfBcosm2G8tD/M=;
        b=TRE2R3z5Uc259bGaLb01/AMKI/SGkrhj0M/TiIXStCDAMc4OfwCXt3cxopfN7qHdpm
         BAmuj12nxo30rRRtHwJXxq/J3TFV6WT097WvfsYnwJXizttI/Q1iNbL3pIon9FTSwCLA
         rMSqjRSimagbN8p87MJJ/win+hWGuk7cr5HHA7owkJIXG1NojRM1gCqKtkqDUN4UYnkG
         03OVo1yuckcnwGW9HNMJkHOD2CFOwHsNcFf2JjN57uyk2IjTyuRd07btOhRtrKJATnsw
         n6KBED0McEMH4orxA4zbZwuiXH+1TnMrk7xuvw4DWf82qZS/9y8jJUb7+534QRSsMMPZ
         u1BA==
X-Gm-Message-State: AOAM531G0/naGKOFv0+Hqh0boz4YD6R3ULnq9Et4sty0T3cObO8BYIzI
        VTrQU/jDuOvF8ZHbbob5yNw+rLCSsBXosI3ym2HTpTSC3Ed/4lueRP767Ih4ZuVHwQTT56Oh17H
        u7c7+UanbXrMub1uQA6UqzzXZ
X-Received: by 2002:a05:6000:1088:: with SMTP id y8mr47129181wrw.53.1641374129200;
        Wed, 05 Jan 2022 01:15:29 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyg51pB/qlWWM/KTBbkLIt4pYvbcDuWcb2J6gVBoBFT3Tn8ol1dLD7f5r6KB0jtjN7A+yrFcw==
X-Received: by 2002:a05:6000:1088:: with SMTP id y8mr47129148wrw.53.1641374128959;
        Wed, 05 Jan 2022 01:15:28 -0800 (PST)
Received: from krava (nat-pool-brq-u.redhat.com. [213.175.37.12])
        by smtp.gmail.com with ESMTPSA id n12sm44918147wrf.29.2022.01.05.01.15.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Jan 2022 01:15:28 -0800 (PST)
Date:   Wed, 5 Jan 2022 10:15:27 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Network Development <netdev@vger.kernel.org>,
        bpf <bpf@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>,
        Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: Re: [RFC 00/13] kprobe/bpf: Add support to attach multiple kprobes
Message-ID: <YdVhrzn8NqsR4Pq5@krava>
References: <20220104080943.113249-1-jolsa@kernel.org>
 <CAADnVQKZcr38aXwN6DyV7C9Ernfwkz5nsx8pXapKGNmnZ1JMDQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAADnVQKZcr38aXwN6DyV7C9Ernfwkz5nsx8pXapKGNmnZ1JMDQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 04, 2022 at 10:53:19AM -0800, Alexei Starovoitov wrote:
> On Tue, Jan 4, 2022 at 12:09 AM Jiri Olsa <jolsa@redhat.com> wrote:
> >
> > hi,
> > adding support to attach multiple kprobes within single syscall
> > and speed up attachment of many kprobes.
> >
> > The previous attempt [1] wasn't fast enough, so coming with new
> > approach that adds new kprobe interface.
> >
> > The attachment speed of of this approach (tested in bpftrace)
> > is now comparable to ftrace tracer attachment speed.. fast ;-)
> 
> What are the absolute numbers?
> How quickly a single bpf prog can attach to 1k kprobes?
> 

I'd need to write special tool for 1k kprobes exactly,
we could do some benchmark selftest for that

I tested following counts with current bpftrace interface for now
(note it includes both attach and detach)


2 seconds for 673 kprobes:

	# perf stat -e cycles:u,cycles:k ./src/bpftrace  -e 'kprobe:kvm* {  } i:ms:10 { printf("KRAVA\n"); exit() }' 
	Attaching 2 probes...
	Attaching 673 functions
	KRAVA


	 Performance counter stats for './src/bpftrace -e kprobe:kvm* {  } i:ms:10 { printf("KRAVA\n"); exit() }':

	     1,695,142,901      cycles:u                                                    
	     1,909,616,944      cycles:k                                                    

	       1.990434019 seconds time elapsed

	       0.767746000 seconds user
	       0.921166000 seconds sys


5 seconds for 3337 kprobes:

	# perf stat -e cycles:u,cycles:k ./src/bpftrace  -e 'kprobe:x* {  } i:ms:10 { printf("KRAVA\n"); exit() }' 
	Attaching 2 probes...
	Attaching 3337 functions
	KRAVA


	 Performance counter stats for './src/bpftrace -e kprobe:x* {  } i:ms:10 { printf("KRAVA\n"); exit() }':

	     1,731,646,061      cycles:u                                                    
	     9,815,306,940      cycles:k                                                    

	       5.196176904 seconds time elapsed

	       0.780508000 seconds user
	       4.078170000 seconds sys


lot of the time above is spent in kallsyms:

	    42.70%  bpftrace  [kernel.kallsyms]     [k] kallsyms_expand_symbol.constprop.0
	     5.11%  bpftrace  [kernel.kallsyms]     [k] insn_get_prefixes.part.0
	     3.91%  bpftrace  [kernel.kallsyms]     [k] insn_decode
	     3.09%  bpftrace  [kernel.kallsyms]     [k] arch_jump_entry_size
	     1.98%  bpftrace  [kernel.kallsyms]     [k] __lock_acquire
	     1.51%  bpftrace  [kernel.kallsyms]     [k] static_call_text_reserved


by checking if the address is on the kprobe blacklist:

	    42.70%  bpftrace  [kernel.kallsyms]     [k] kallsyms_expand_symbol.constprop.0
		    |
		    ---kallsyms_expand_symbol.constprop.0
		       |          
			--42.22%--kallsyms_lookup_name
				  within_kprobe_blacklist.part.0
				  check_kprobe_address
				  register_kprobe
				  bpf_kprobe_link_attach
				  __sys_bpf
				  __x64_sys_bpf
				  do_syscall_64
				  entry_SYSCALL_64_after_hwframe
				  syscall
				  bpftrace::AttachedProbe::attach_kprobe


I could revive that patch that did bsearch on kallsyms or we could
add 'do-not-check-kprobe-blacklist' unsafe mode to get more speed

jirka

