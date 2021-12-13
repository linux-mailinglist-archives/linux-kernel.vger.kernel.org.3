Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E3F5472CEB
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 14:12:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237226AbhLMNMG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 08:12:06 -0500
Received: from sin.source.kernel.org ([145.40.73.55]:58480 "EHLO
        sin.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237214AbhLMNME (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 08:12:04 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 519C6CE1022
        for <linux-kernel@vger.kernel.org>; Mon, 13 Dec 2021 13:12:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E56DC34601;
        Mon, 13 Dec 2021 13:12:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639401121;
        bh=Ldk5aawEBt05Rt5Zj73/pDE3fNQ6YAH7tObHThHCRvA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jlDdLW/xlJuucvOBEYFSQR84dqifK6xxJHMydwALBFSW0huXIybHJvxeDFnZyU7K+
         gOIs/ePm1OVd5tprotzXq/wcM10KWVKVpJOecOP+dQKd4uhWVllgPZvdIBMAULQImX
         dYOsW/9yL5paro4auuOahq8xiKEC1U55tvDtcRQmDcBr8/eYe4r5+uN9KYCYaMLAf/
         e9YPG71zxPKA1KIkU/KGnbgR0HAL/Is1puBfysJNIjL+4n0A4f16x1JmShARjn5Nfr
         wQ/Aqz7oHM7pePC0vyfDbXHdXXHYA8RUZ0eVEDR8OiA30A/Mu1eCTms5PIxfmbCDkA
         W0LfNuZ6y9p4A==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 61EAD405D8; Mon, 13 Dec 2021 10:11:59 -0300 (-03)
Date:   Mon, 13 Dec 2021 10:11:59 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Jiri Olsa <jolsa@redhat.com>, linux-kernel@vger.kernel.org,
        Riccardo Mancini <rickyman7@gmail.com>,
        Namhyung Kim <namhyung@kernel.org>
Subject: Re: [PATCH 1/2] perf inject: Fix segfault due to close without open
Message-ID: <YbdGn89u/HXXvfwo@kernel.org>
References: <20211213084829.114772-1-adrian.hunter@intel.com>
 <20211213084829.114772-2-adrian.hunter@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211213084829.114772-2-adrian.hunter@intel.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, Dec 13, 2021 at 10:48:28AM +0200, Adrian Hunter escreveu:
> The fixed commit attempts to close inject.output even if it was never
> opened e.g.
> 
>  $ perf record uname
>  Linux
>  [ perf record: Woken up 1 times to write data ]
>  [ perf record: Captured and wrote 0.002 MB perf.data (7 samples) ]
>  $ perf inject -i perf.data --vm-time-correlation=dry-run
>  Segmentation fault (core dumped)
>  $ gdb --quiet perf
>  Reading symbols from perf...
>  (gdb) r inject -i perf.data --vm-time-correlation=dry-run
>  Starting program: /home/ahunter/bin/perf inject -i perf.data --vm-time-correlation=dry-run
>  [Thread debugging using libthread_db enabled]
>  Using host libthread_db library "/lib/x86_64-linux-gnu/libthread_db.so.1".

Thanks, applied.

- Arnaldo

 
>  Program received signal SIGSEGV, Segmentation fault.
>  0x00007eff8afeef5b in _IO_new_fclose (fp=0x0) at iofclose.c:48
>  48      iofclose.c: No such file or directory.
>  (gdb) bt
>  #0  0x00007eff8afeef5b in _IO_new_fclose (fp=0x0) at iofclose.c:48
>  #1  0x0000557fc7b74f92 in perf_data__close (data=data@entry=0x7ffcdafa6578) at util/data.c:376
>  #2  0x0000557fc7a6b807 in cmd_inject (argc=<optimized out>, argv=<optimized out>) at builtin-inject.c:1085
>  #3  0x0000557fc7ac4783 in run_builtin (p=0x557fc8074878 <commands+600>, argc=4, argv=0x7ffcdafb6a60) at perf.c:313
>  #4  0x0000557fc7a25d5c in handle_internal_command (argv=<optimized out>, argc=<optimized out>) at perf.c:365
>  #5  run_argv (argcp=<optimized out>, argv=<optimized out>) at perf.c:409
>  #6  main (argc=4, argv=0x7ffcdafb6a60) at perf.c:539
>  (gdb)
> 
> Fixes: 02e6246f5364d ("perf inject: Close inject.output on exit")
> Cc: stable@vger.kernel.org
> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
> ---
>  tools/perf/builtin-inject.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/perf/builtin-inject.c b/tools/perf/builtin-inject.c
> index b9d6306cc14e..af70f1c72052 100644
> --- a/tools/perf/builtin-inject.c
> +++ b/tools/perf/builtin-inject.c
> @@ -1078,7 +1078,8 @@ int cmd_inject(int argc, const char **argv)
>  	zstd_fini(&(inject.session->zstd_data));
>  	perf_session__delete(inject.session);
>  out_close_output:
> -	perf_data__close(&inject.output);
> +	if (!inject.in_place_update)
> +		perf_data__close(&inject.output);
>  	free(inject.itrace_synth_opts.vm_tm_corr_args);
>  	return ret;
>  }
> -- 
> 2.25.1

-- 

- Arnaldo
