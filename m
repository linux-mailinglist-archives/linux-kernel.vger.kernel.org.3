Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F4B549E7F1
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 17:45:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244107AbiA0Qpq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 11:45:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244108AbiA0Qpm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 11:45:42 -0500
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 580DAC061714
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jan 2022 08:45:42 -0800 (PST)
Received: by mail-pg1-x536.google.com with SMTP id e9so2745917pgb.3
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jan 2022 08:45:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=gMvA+LEF6J0Vd7330fPeMtBj4PtlF4ym+zZnuV1hMIY=;
        b=WJyruaqE04yhV8H9pIUz1qDfxbpzvKPhKrpFoBxx8Xk2EfHoNjh+X9DXblrkRz8r6Y
         zENczqt4XwD34HLrkEZRFUwNbLF8TW37hbhCLFSi8KhxVlK/2MFZ7D0z+ekJlnN2Lfy/
         30k6GZz29wX54+yDX/ok3geEnRn7VaqkW5VDk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=gMvA+LEF6J0Vd7330fPeMtBj4PtlF4ym+zZnuV1hMIY=;
        b=NC8oRKiDpz8qDn+bot2MFy39J2jMAimofh9lTHAoz3kq9SzCI+h3qVqZ0p4tHX0ILd
         Mmt+Pnr4Y/GBe9mCgLZYtXOlkp+2Giv6IkcGGKCwpdVunnHcYMpioitSB/zKnPYhlx7g
         eBwPHbN2eU3/MOg+IPvW/5XAW/pXZr4o8UiWibfeklpse9CASYJz0oVbvtpOpADYg5hY
         5hRvMSrm+J1GU8595gawkHiEOBXHOqq3hdXnaOcCra+uQyU3s3DZKA0vY9V/WyhZdIV6
         vTaJGD1i1mehwLBdTI8AUJmbZ1D7SOYWv9D6uOUqpFkGfOza7V565n7MVzuAiFeklvgz
         mqlw==
X-Gm-Message-State: AOAM532RMRYi3Ncf99FmJcP9x6tb065yZJ7Mt1vHennWNN1B0wLquRZS
        +F3k78RrVmyLTgDJsx7JseJHAg==
X-Google-Smtp-Source: ABdhPJzavQdSUBf5gNVJDgqdke2zsz8+HMxl/mEOCAV6Fn50B+zuI/BnYx8eyflwlv4yD3r3yjGP2A==
X-Received: by 2002:a05:6a00:2343:: with SMTP id j3mr3620484pfj.7.1643301941894;
        Thu, 27 Jan 2022 08:45:41 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id f9sm19614558pgf.94.2022.01.27.08.45.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jan 2022 08:45:41 -0800 (PST)
Date:   Thu, 27 Jan 2022 08:45:40 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Muhammad Usama Anjum <usama.anjum@collabora.com>
Cc:     Eric Biederman <ebiederm@xmission.com>,
        Shuah Khan <shuah@kernel.org>, kernel@collabora.com,
        Shuah Khan <skhan@linuxfoundation.org>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] selftests/exec: Remove pipe from TEST_GEN_FILES
Message-ID: <202201270844.660E5394C@keescook>
References: <20220127163346.653546-1-usama.anjum@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220127163346.653546-1-usama.anjum@collabora.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 27, 2022 at 09:33:45PM +0500, Muhammad Usama Anjum wrote:
> pipe named FIFO special file is being created in execveat.c to perform
> some tests. Makefile doesn't need to do anything with the pipe. When it
> isn't found, Makefile generates the following build error:
> 
> make: *** No rule to make target '/linux_mainline/tools/testing/selftests/exec/pipe', needed by 'all'.  Stop.

Ah, good catch. However, I think this should be moved to EXTRA_CLEAN instead of
only removed from TEST_GEN_FILES. (i.e. "pipe" is created by
tools/testing/selftests/exec/execveat.c and should be removed.

-Kees

> 
> Fixes: 61016db15b8e ("selftests/exec: Verify execve of non-regular files fail")
> Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
> ---
>  tools/testing/selftests/exec/Makefile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/exec/Makefile b/tools/testing/selftests/exec/Makefile
> index dd61118df66ed..12c5e27d32c16 100644
> --- a/tools/testing/selftests/exec/Makefile
> +++ b/tools/testing/selftests/exec/Makefile
> @@ -5,7 +5,7 @@ CFLAGS += -D_GNU_SOURCE
>  
>  TEST_PROGS := binfmt_script non-regular
>  TEST_GEN_PROGS := execveat load_address_4096 load_address_2097152 load_address_16777216
> -TEST_GEN_FILES := execveat.symlink execveat.denatured script subdir pipe
> +TEST_GEN_FILES := execveat.symlink execveat.denatured script subdir
>  # Makefile is a run-time dependency, since it's accessed by the execveat test
>  TEST_FILES := Makefile
>  
> -- 
> 2.30.2
> 

-- 
Kees Cook
