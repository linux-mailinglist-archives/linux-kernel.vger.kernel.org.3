Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 031A749C3C5
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 07:42:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229699AbiAZGms (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 01:42:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236251AbiAZGmn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 01:42:43 -0500
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93E6FC061744
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jan 2022 22:42:43 -0800 (PST)
Received: by mail-pf1-x42c.google.com with SMTP id p37so21858005pfh.4
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jan 2022 22:42:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=0ofuiDQxT3viLHxb0SsXLCvrM+uOJBkwjSJ8TanyCGI=;
        b=NSictfKEBnOoZC55NLB6SdZ0LVDTTW+TIVcMxFVdoxgS9KsTUzsiPV8pKLovLcd7L2
         dv6dCOCXNBDMJQneaXVP1kC3SKFWVWmjfjHun+ifEfHN99c7AacvwDfBCvIuiu2uQV1c
         Cf48QexiTeu/T7oDxgQsJdJ9qp8Wr4uArrL7k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=0ofuiDQxT3viLHxb0SsXLCvrM+uOJBkwjSJ8TanyCGI=;
        b=VxNiH7b9h5HoismEIEe6QXvo/knoiwZE3j9wDpv3Dbw5qzP6cEKLlCqwZ9fE/w/ZCL
         3Hnqz2l5yChhpv8Oexlp5kEuCtUu2FotwH7ga93simNA3I9YCtkrGfoTGV5veSDFSeok
         FHinMuCSgRn9eBlJ1M/mM+P9H/Nwh32rWuzGzZKIjDKeIPab84HSnvAhwfYXcaQAg6kh
         vZNTyjJQtDQ14kD+dhVr1gsvdmAk7txudUrQ1duRStjxqs0YZpMtMVsGen+fWOaMuFcm
         eYl8fAeca8aKcgS8gFN4/5pLksJu9DguZIFAfkS0ssjfZJQRV1tw9oCF90LJqiUaNtkF
         t6hg==
X-Gm-Message-State: AOAM533LBx+jqq+2m9hQxnxwcHTunuZw23JD3wyxjwtIuLu2/ecUKgO/
        Jjj6zJt7bS+ahgMogK5LPIEwTWWTd3zkQw==
X-Google-Smtp-Source: ABdhPJyE1srlWbFIBCylAE+gwhA+uGdMAIYjm6odIm46bv4p5aqwZ+FkWDDGqz2YD4Gs2lQ52tFNcw==
X-Received: by 2002:a63:b905:: with SMTP id z5mr17918282pge.245.1643179363112;
        Tue, 25 Jan 2022 22:42:43 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id pc7sm2200755pjb.0.2022.01.25.22.42.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jan 2022 22:42:42 -0800 (PST)
Date:   Tue, 25 Jan 2022 22:42:41 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Ariadne Conill <ariadne@dereferenced.org>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Eric Biederman <ebiederm@xmission.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH] fs/exec: require argv[0] presence in do_execveat_common()
Message-ID: <202201252241.7309AE568F@keescook>
References: <20220126043947.10058-1-ariadne@dereferenced.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220126043947.10058-1-ariadne@dereferenced.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 26, 2022 at 04:39:47AM +0000, Ariadne Conill wrote:
> The first argument to argv when used with execv family of calls is
> required to be the name of the program being executed, per POSIX.
> 
> By validating this in do_execveat_common(), we can prevent execution
> of shellcode which invokes execv(2) family syscalls with argc < 1,
> a scenario which is disallowed by POSIX, thus providing a mitigation
> against CVE-2021-4034 and similar bugs in the future.
> 
> The use of -EFAULT for this case is similar to other systems, such
> as FreeBSD and OpenBSD.
> 
> Interestingly, Michael Kerrisk opened an issue about this in 2008,
> but there was no consensus to support fixing this issue then.
> Hopefully now that CVE-2021-4034 shows practical exploitative use
> of this bug in a shellcode, we can reconsider.
> 
> Signed-off-by: Ariadne Conill <ariadne@dereferenced.org>

Yup. Agreed. For context:
https://www.qualys.com/2022/01/25/cve-2021-4034/pwnkit.txt

> ---
>  fs/exec.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/exec.c b/fs/exec.c
> index 79f2c9483302..de0b832473ed 100644
> --- a/fs/exec.c
> +++ b/fs/exec.c
> @@ -1897,8 +1897,10 @@ static int do_execveat_common(int fd, struct filename *filename,
>  	}
>  
>  	retval = count(argv, MAX_ARG_STRINGS);
> -	if (retval < 0)
> +	if (retval < 1) {
> +		retval = -EFAULT;
>  		goto out_free;
> +	}

There shouldn't be anything legitimate actually doing this in userspace.

-Kees

>  	bprm->argc = retval;
>  
>  	retval = count(envp, MAX_ARG_STRINGS);
> -- 
> 2.34.1
> 

-- 
Kees Cook
