Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5694C486A7B
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jan 2022 20:29:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243322AbiAFT3D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jan 2022 14:29:03 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:57696 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243311AbiAFT3C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jan 2022 14:29:02 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CA23D61D04;
        Thu,  6 Jan 2022 19:29:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15BFCC36AE3;
        Thu,  6 Jan 2022 19:29:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641497341;
        bh=4dACT1YiyrLoTMnDe9Pfe4GUDI9p9TWgn8eh3hZZYt8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pPz0uTv0mj4fW/scrxYWxmBCiD52nudsZ9w31/nNUcexDZ8LBghe0if4NZFFDNm6t
         hCFKLRHwnkiVmje3RL/PsgxhY7zPLoUGL7EavmjwXWXdKtZ7kj3DEDO93o6pP9uRIk
         dlSkzP/kTqoywKBb1+InBbo6EdZBmvCuFg7YmZddu5l9d2yUhrPELFmW+9EGB8ffyf
         1zZ2b6rvmSG+kFenMVTOZvRXSdQkxFilCNjzfb5iXMegafyjjdiCO0pp+YCPTQDhEI
         VvTxlIWq5RcG1icSxdFVGqlyt5hFP5WqUTqqwctqvxARA50modgJnNO0eyRIydZ6cX
         NAF/WtD5uMdng==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 2131040B92; Thu,  6 Jan 2022 16:28:58 -0300 (-03)
Date:   Thu, 6 Jan 2022 16:28:58 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ian Rogers <irogers@google.com>
Cc:     Jiri Slaby <jirislaby@kernel.org>,
        linux-trace-devel@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tzvetomir Stoyanov <tz.stoyanov@gmail.com>,
        torvalds@linux-foundation.org, eranian@google.com
Subject: Re: [PATCH] perf build: Lower the priority of tools/lib includes
Message-ID: <YddC+lzAO1Urj0TF@kernel.org>
References: <20220106072627.476524-1-irogers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220106072627.476524-1-irogers@google.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, Jan 05, 2022 at 11:26:27PM -0800, Ian Rogers escreveu:
> tools/lib has a 1.1.0 copy of libtraceevent. If a newer system
> version is installed then its headers will go in /usr/include. As -I has
> priority over system headers the 1.1.0 version gets used in preference
> to the system one, which isn't what is wanted. To make the behavior
> match expectations use -idirafter so that any system headers have priority
> over the tools/lib version.
> 
> Fixes: 08efcb4a638d ("libtraceevent: Increase libtraceevent logging when verbose")

Hi,

	You forgot to add your Signed-off-by:, I'm adding it as you
usually provide it, ok?

- Arnaldo

> ---
>  tools/perf/Makefile.config | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
> index 96ad944ca6a8..0627286380fa 100644
> --- a/tools/perf/Makefile.config
> +++ b/tools/perf/Makefile.config
> @@ -346,7 +346,7 @@ endif
>  
>  INC_FLAGS += -I$(src-perf)/util
>  INC_FLAGS += -I$(src-perf)
> -INC_FLAGS += -I$(srctree)/tools/lib/
> +INC_FLAGS += -idirafter$(srctree)/tools/lib/
>  
>  CORE_CFLAGS += -D_LARGEFILE64_SOURCE -D_FILE_OFFSET_BITS=64 -D_GNU_SOURCE
>  
> -- 
> 2.34.1.448.ga2b2bfdf31-goog

-- 

- Arnaldo
