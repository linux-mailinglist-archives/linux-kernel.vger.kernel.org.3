Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFEBC4D8F4F
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Mar 2022 23:09:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238434AbiCNWKs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Mar 2022 18:10:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229659AbiCNWKr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Mar 2022 18:10:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68E70FCC
        for <linux-kernel@vger.kernel.org>; Mon, 14 Mar 2022 15:09:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F3513613F1
        for <linux-kernel@vger.kernel.org>; Mon, 14 Mar 2022 22:09:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E7B2C340E9;
        Mon, 14 Mar 2022 22:09:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647295775;
        bh=DATGvcKeuJiBMjiIBVOZ0c+D8mTGMFNrWwr26FYAG4M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Kp8MYqhE5rvrakeY8pHByKrYBbpS4bE+hgj5S/q+WHuNvCvdrAlqik48uBMprUfnf
         sMR+DXlx7UGfZ3tRnchwAq6vhqkz56ax35reTF3hMjTCPyuAfn4cqZ9PhEC+CkaIxh
         y5iPMxlKlZUTYhqJLxYPlz1SBhx+sG15BJkxfKCsZmLXlv8BYAK+ZdiT/WSzGPCrUf
         yAwXIYGUSmXqYudVY4ysKp2wZrVf5DVoVn701YEBu4FawcKeYGbpZHOUF7RsuyT2tY
         RC+oqAl6wdhtUdHo5xJDFUnwqzh2xghcxSFZ4Cjr9NBQiYDKPcQbWzyG/jS9EgN4nV
         ckSYzIQDPgfXw==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id A361540407; Mon, 14 Mar 2022 19:09:31 -0300 (-03)
Date:   Mon, 14 Mar 2022 19:09:31 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Cc:     cclaudio@linux.ibm.com, Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] perf trace: Fix SIGSEGV when processing augmented args
Message-ID: <Yi+9G1nK1shEIXVN@kernel.org>
References: <20220310104741.209834-1-naveen.n.rao@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220310104741.209834-1-naveen.n.rao@linux.vnet.ibm.com>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, Mar 10, 2022 at 04:17:41PM +0530, Naveen N. Rao escreveu:
> On powerpc, 'perf trace' is crashing with a SIGSEGV when trying to
> process a perf data file created with 'perf trace record -p':
 
>   #0  0x00000001225b8988 in syscall_arg__scnprintf_augmented_string <snip> at builtin-trace.c:1492
>   #1  syscall_arg__scnprintf_filename <snip> at builtin-trace.c:1492
>   #2  syscall_arg__scnprintf_filename <snip> at builtin-trace.c:1486
>   #3  0x00000001225bdd9c in syscall_arg_fmt__scnprintf_val <snip> at builtin-trace.c:1973
>   #4  syscall__scnprintf_args <snip> at builtin-trace.c:2041
>   #5  0x00000001225bff04 in trace__sys_enter <snip> at builtin-trace.c:2319
 
> The size captured in the augmented arg looks corrupt, resulting in the
> augmented arg pointer being adjusted incorrectly. Fix this by checking
> that the size is reasonable.
 
> Reported-by: Claudio Carvalho <cclaudio@linux.ibm.com>
> Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
> ---
> While this resolves the 'perf trace' crash, I'm not yet sure why the
> size for the augmented arg is corrupt. This looks to be happening when
> processing the sample for 'read' syscall. Any pointers?

Strange indeed, the augmented args code should kick in when the payload
for some tracepoint is bigger than what is expected, i.e. more than the
sum of its arguments, in which case it assumes that what is coming after
the expected payload comes with, say, the pathname for an open, openat,
etc syscall, that otherwise would be just a pointer.

This augmentation is done using something like
tools/perf/examples/bpf/augmented_raw_syscalls.c, i.e.:

[root@quaco ~]# perf trace -e openat sleep 1
     0.000 openat(dfd: CWD, filename: 0x1bbb0b6, flags: RDONLY|CLOEXEC) = 3
     0.021 openat(dfd: CWD, filename: 0x1bc8e80, flags: RDONLY|CLOEXEC) = 3
     0.201 openat(dfd: CWD, filename: 0x1b34f20, flags: RDONLY|CLOEXEC) = 3
[root@quaco ~]# perf trace -e ~acme/git/perf/tools/perf/examples/bpf/augmented_raw_syscalls.c,openat sleep 1
     0.000 openat(dfd: CWD, filename: "/etc/ld.so.cache", flags: RDONLY|CLOEXEC) = 3
     0.023 openat(dfd: CWD, filename: "/lib64/libc.so.6", flags: RDONLY|CLOEXEC) = 3
     0.225 openat(dfd: CWD, filename: "/usr/lib/locale/locale-archive", flags: RDONLY|CLOEXEC) = 3
[root@quaco ~]#

So it seems the perf.data file being processed is corrupted somehow...

Perhaps we should check if the syscall has pointer args and if not don't
kick in the augmented code and instead emit some warning about having
more payload than expected.

I'll try to take a look at this tomorrow, sorry for the delay :-\

- Arnaldo
 
> Thanks,
> - Naveen
> 
> 
>  tools/perf/builtin-trace.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
> index 52b137a184a66a..150c9cbe3316b8 100644
> --- a/tools/perf/builtin-trace.c
> +++ b/tools/perf/builtin-trace.c
> @@ -1487,10 +1487,12 @@ static size_t syscall_arg__scnprintf_augmented_string(struct syscall_arg *arg, c
>  	 * So that the next arg with a payload can consume its augmented arg, i.e. for rename* syscalls
>  	 * we would have two strings, each prefixed by its size.
>  	 */
> -	int consumed = sizeof(*augmented_arg) + augmented_arg->size;
> +	int consumed = sizeof(*augmented_arg) + (unsigned int)augmented_arg->size;
>  
> -	arg->augmented.args = ((void *)arg->augmented.args) + consumed;
> -	arg->augmented.size -= consumed;
> +	if (consumed < arg->augmented.size) {
> +		arg->augmented.args = ((void *)arg->augmented.args) + consumed;
> +		arg->augmented.size -= consumed;
> +	}
>  
>  	return printed;
>  }
> 
> base-commit: e314fe9c2ad65adcb62fa98376a5f35502e4f4dd
> -- 
> 2.35.1

-- 

- Arnaldo
