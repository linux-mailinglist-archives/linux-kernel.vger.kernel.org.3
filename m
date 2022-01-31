Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E56334A4F57
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jan 2022 20:23:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359577AbiAaTX2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jan 2022 14:23:28 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:26855 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1359382AbiAaTX1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jan 2022 14:23:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643657006;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=I2d3efJ/j6K/4OXgLFwPh7lzFbfhPa/UEhDGGQxVReg=;
        b=B9SSVPFd00w0kxMdkRoikASbaADrycncZXM5Bu99ilsqlAcr6qvhOY/qjsuH6j4rJtNhRb
        7DT0g3ONbOUpRSN+x4CmWnu0wcW+qLEvfpdlrpudl/KzI7piymzX+X+Y2rrw6T1SK/hLcn
        75edg3e1EwJKDTHE9yBz057LM1xQgEw=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-611-vPV3DCPsP6KXvYDAG_kHyg-1; Mon, 31 Jan 2022 14:23:24 -0500
X-MC-Unique: vPV3DCPsP6KXvYDAG_kHyg-1
Received: by mail-wm1-f70.google.com with SMTP id z2-20020a05600c220200b0034d2eb95f27so36827wml.1
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jan 2022 11:23:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=I2d3efJ/j6K/4OXgLFwPh7lzFbfhPa/UEhDGGQxVReg=;
        b=8A4tyRa0Vl9RU5T5uCh6MaMuzTIR7MqgMOC1558mevxSQUa9VhbUSrBwqoKC2NlQSb
         LxUV773YSNu01L0HV1H7k7OrgseKR7onRQ7bc0fYBZNd85H4Uw/qcY5V9jPk7wLPhMsl
         D9XVWYhuwqHByLRvBRd/qegBqywnGMqUEVVKt0kgUPu8o0BkGlmRl9DqPAENgoKzDRcq
         BgZLD7FIvKFXuDWpiv7Ik22LFQDQVhNs+XhMV/c31iEDcJBlp5yA5xwI96XT9/EfBxNL
         T+f3fnv4Ea7yk8KtG+tAV1LtyL8NHh2tWaEs8BwLXMDG8mrPXvPDnjEbd/0BfTWwaAIm
         wetg==
X-Gm-Message-State: AOAM533u6mlIuR46PT/mLJolx2clXmMhC5V0IFGVPWKlyAQWDVdEzvBo
        8pzIaAR6Zn2A6q5FhYayd4ryJPU20KXSuD0hNMlmNfEN4+xNAklNL80VcAtxH3JP/hckvV39Vuk
        KgNU5OGJ1q/SL0mjddZzwS1ij
X-Received: by 2002:a1c:f210:: with SMTP id s16mr19914704wmc.99.1643657003424;
        Mon, 31 Jan 2022 11:23:23 -0800 (PST)
X-Google-Smtp-Source: ABdhPJw4YAsMahzu4M2yqMQCjOrz2F/+9X2UxqE8g/ewaMUTrvblT0lO2OjsUepkGdDK6wSrJPyoAg==
X-Received: by 2002:a1c:f210:: with SMTP id s16mr19914690wmc.99.1643657003234;
        Mon, 31 Jan 2022 11:23:23 -0800 (PST)
Received: from krava (nat-pool-brq-u.redhat.com. [213.175.37.12])
        by smtp.gmail.com with ESMTPSA id u7sm181957wmc.11.2022.01.31.11.23.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Jan 2022 11:23:22 -0800 (PST)
Date:   Mon, 31 Jan 2022 20:23:21 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Ian Rogers <irogers@google.com>
Subject: Re: [PATCH 3/3] perf annotate: Try chroot filename for objdump
Message-ID: <Yfg3KXNcyUPaRebE@krava>
References: <20220128203950.3371061-1-namhyung@kernel.org>
 <20220128203950.3371061-4-namhyung@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220128203950.3371061-4-namhyung@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 28, 2022 at 12:39:50PM -0800, Namhyung Kim wrote:
> Likewise, it should use a proper name in case the task runs under
> chroot.  The child_process.err was needed to set to -1 to show error
> messages properly in TUI.
> 
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> ---
>  tools/perf/util/annotate.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
> index 01900689dc00..e4c641b240df 100644
> --- a/tools/perf/util/annotate.c
> +++ b/tools/perf/util/annotate.c
> @@ -33,6 +33,7 @@
>  #include "string2.h"
>  #include "util/event.h"
>  #include "arch/common.h"
> +#include "namespaces.h"
>  #include <regex.h>
>  #include <pthread.h>
>  #include <linux/bitops.h>
> @@ -1696,6 +1697,15 @@ static int dso__disassemble_filename(struct dso *dso, char *filename, size_t fil
>  		 * DSO is the same as when 'perf record' ran.
>  		 */
>  		__symbol__join_symfs(filename, filename_size, dso->long_name);
> +
> +		if (access(filename, R_OK) && errno == ENOENT && dso->nsinfo) {
> +			char *new_name = filename_with_chroot(dso->nsinfo->pid,
> +							      filename);
> +			if (new_name) {
> +				strlcpy(filename, new_name, filename_size);
> +				free(new_name);
> +			}
> +		}
>  	}
>  
>  	free(build_id_path);
> @@ -2036,6 +2046,7 @@ static int symbol__disassemble(struct symbol *sym, struct annotate_args *args)
>  	memset(&objdump_process, 0, sizeof(objdump_process));
>  	objdump_process.argv = objdump_argv;
>  	objdump_process.out = -1;
> +	objdump_process.err = -1;

is this unrelated fix?

otherwise the whole patchset looks good to me

I guess we'd need to add something like PERF_RECORD_CHROOT to
handle and instrument sys_chroot to handle this completely?

Acked-by: Jiri Olsa <jolsa@kernel.org>

thanks,
jirka

>  	if (start_command(&objdump_process)) {
>  		pr_err("Failure starting to run %s\n", command);
>  		err = -1;
> -- 
> 2.35.0.rc2.247.g8bbb082509-goog
> 

