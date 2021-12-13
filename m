Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2DE01472F96
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 15:41:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234501AbhLMOlt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 09:41:49 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:44551 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233094AbhLMOls (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 09:41:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1639406508;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7pRXXV0v9giuYsYC3tANypl3E9qVvVmrrv2MfnznAFU=;
        b=Num+ODX2Qyv6G7GeWMm1//vDkim3rLSVWPNDStYxpAxzl2sA4hzgkDV1IuslW1PQgk08pF
        o4qYa2j9aBReau/UJ6AkgSzHf3P77ONYs8NnpM6sjadDnG+ZamXMRFRDlh2c4ickuryHdK
        uLgbDm4NFk9xdw1PLv6TyhP8gGuNSRw=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-552-P_TLF7I1MqSYwAiE8Pbxnw-1; Mon, 13 Dec 2021 09:41:46 -0500
X-MC-Unique: P_TLF7I1MqSYwAiE8Pbxnw-1
Received: by mail-wm1-f71.google.com with SMTP id k25-20020a05600c1c9900b00332f798ba1dso11672894wms.4
        for <linux-kernel@vger.kernel.org>; Mon, 13 Dec 2021 06:41:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=7pRXXV0v9giuYsYC3tANypl3E9qVvVmrrv2MfnznAFU=;
        b=GcDSq+UlUkcxLVzHnvQPqXnuwIvCrQrdGSsX10mJDt/xZPEpL7gow2U0do9sUwXxrJ
         7fTcquZMSGXH3RBJLI2RXd8e5+spA6gf5R9yfyhpdLoItQOumKTwUykbua5jypqrZdUs
         CilBgGvwVIHVqApPD90WzmqeJnUGHuN7SmfO2myamh73DTxx77zBbU00/UqVeQ5mpVlr
         tDdyRKKM++Sl3MXgHq3k6coFMZoSjBcKHFC6OuarPCUX1Bpzb/Ll/ruyxdu/HGhGZWF3
         qxtNhK1Uum6HveHjALwWYULlb45qGj1KSxMN/PBRBsA7oJYwnSirJOO4aJ5QvfHOV1sm
         BivQ==
X-Gm-Message-State: AOAM533CoHNUJvdhwGkjrOQU/TNjUrUfHPSbTlkKGAV/+tpNEKOspQLC
        +cuCm+cX1R15YcSjNrSdeRLt92FKqcyLpizMt3r0nb27KU+xw2Gkvv849blbVl0mJ5hZHTH+qQm
        lutYcvT+iplogbp/riHAoEvNV
X-Received: by 2002:a5d:58c5:: with SMTP id o5mr32290713wrf.15.1639406505604;
        Mon, 13 Dec 2021 06:41:45 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxPAxLL4xqt1e2lYLjiNAvw/yEFjfmet00BfOTBtz3NKFTpNLzYP5C8W/QeX/MZCf+tcLiyLA==
X-Received: by 2002:a5d:58c5:: with SMTP id o5mr32290677wrf.15.1639406505341;
        Mon, 13 Dec 2021 06:41:45 -0800 (PST)
Received: from [192.168.3.132] (p5b0c6276.dip0.t-ipconnect.de. [91.12.98.118])
        by smtp.gmail.com with ESMTPSA id u13sm8658152wmq.14.2021.12.13.06.41.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Dec 2021 06:41:44 -0800 (PST)
Message-ID: <b0539137-c91d-0787-721e-c6ed4ced69ec@redhat.com>
Date:   Mon, 13 Dec 2021 15:41:43 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH -mm v2 1/3] elfcore: replace old hard-code 16 with
 TASK_COMM_LEN_16
Content-Language: en-US
To:     Yafang Shao <laoar.shao@gmail.com>, akpm@linux-foundation.org,
        rostedt@goodmis.org, keescook@chromium.org, pmladek@suse.com,
        arnaldo.melo@gmail.com, andrii.nakryiko@gmail.com,
        alexei.starovoitov@gmail.com
Cc:     linux-mm@kvack.org, bpf@vger.kernel.org,
        linux-perf-users@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Michal Miroslaw <mirq-linux@rere.qmqm.pl>,
        Peter Zijlstra <peterz@infradead.org>,
        Matthew Wilcox <willy@infradead.org>,
        Al Viro <viro@zeniv.linux.org.uk>
References: <20211211063949.49533-1-laoar.shao@gmail.com>
 <20211211063949.49533-2-laoar.shao@gmail.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20211211063949.49533-2-laoar.shao@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11.12.21 07:39, Yafang Shao wrote:
> A new macro TASK_COMM_LEN_16 is introduced for the old hard-coded 16 to
> make it more grepable. As explained above this marco, the difference
> between TASK_COMM_LEN and TASK_COMM_LEN_16 is that TASK_COMM_LEN_16 must
> be a fixed size 16 and can't be changed.
> 
> Suggested-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
> Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
> Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> Cc: Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
> Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>
> Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>
> Cc: Michal Miroslaw <mirq-linux@rere.qmqm.pl>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Steven Rostedt <rostedt@goodmis.org>
> Cc: Matthew Wilcox <willy@infradead.org>
> Cc: David Hildenbrand <david@redhat.com>
> Cc: Al Viro <viro@zeniv.linux.org.uk>
> Cc: Kees Cook <keescook@chromium.org>
> Cc: Petr Mladek <pmladek@suse.com>
> ---
>  include/linux/elfcore-compat.h | 8 ++------
>  include/linux/elfcore.h        | 9 ++-------
>  include/linux/sched.h          | 5 +++++
>  3 files changed, 9 insertions(+), 13 deletions(-)
> 
> diff --git a/include/linux/elfcore-compat.h b/include/linux/elfcore-compat.h
> index 54feb64e9b5d..69fa1a728964 100644
> --- a/include/linux/elfcore-compat.h
> +++ b/include/linux/elfcore-compat.h
> @@ -5,6 +5,7 @@
>  #include <linux/elf.h>
>  #include <linux/elfcore.h>
>  #include <linux/compat.h>
> +#include <linux/sched.h>
>  
>  /*
>   * Make sure these layouts match the linux/elfcore.h native definitions.
> @@ -43,12 +44,7 @@ struct compat_elf_prpsinfo
>  	__compat_uid_t			pr_uid;
>  	__compat_gid_t			pr_gid;
>  	compat_pid_t			pr_pid, pr_ppid, pr_pgrp, pr_sid;
> -	/*
> -	 * The hard-coded 16 is derived from TASK_COMM_LEN, but it can't be
> -	 * changed as it is exposed to userspace. We'd better make it hard-coded
> -	 * here.
> -	 */
> -	char				pr_fname[16];
> +	char				pr_fname[TASK_COMM_LEN_16];
>  	char				pr_psargs[ELF_PRARGSZ];
>  };
>  
> diff --git a/include/linux/elfcore.h b/include/linux/elfcore.h
> index 746e081879a5..d3bb4bd3c985 100644
> --- a/include/linux/elfcore.h
> +++ b/include/linux/elfcore.h
> @@ -65,13 +65,8 @@ struct elf_prpsinfo
>  	__kernel_gid_t	pr_gid;
>  	pid_t	pr_pid, pr_ppid, pr_pgrp, pr_sid;
>  	/* Lots missing */
> -	/*
> -	 * The hard-coded 16 is derived from TASK_COMM_LEN, but it can't be
> -	 * changed as it is exposed to userspace. We'd better make it hard-coded
> -	 * here.
> -	 */
> -	char	pr_fname[16];	/* filename of executable */
> -	char	pr_psargs[ELF_PRARGSZ];	/* initial part of arg list */
> +	char	pr_fname[TASK_COMM_LEN_16];	/* filename of executable */
> +	char	pr_psargs[ELF_PRARGSZ];		/* initial part of arg list */
>  };
>  
>  static inline void elf_core_copy_regs(elf_gregset_t *elfregs, struct pt_regs *regs)
> diff --git a/include/linux/sched.h b/include/linux/sched.h
> index c79bd7ee6029..8d963a50a2a8 100644
> --- a/include/linux/sched.h
> +++ b/include/linux/sched.h
> @@ -279,6 +279,11 @@ struct task_group;
>   * BPF programs.
>   */
>  enum {
> +	/*
> +	 * For the old hard-coded 16, which is exposed to userspace and can't
> +	 * be changed.
> +	 */
> +	TASK_COMM_LEN_16 = 16,
>  	TASK_COMM_LEN = 16,
>  };
>  
> 

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb

