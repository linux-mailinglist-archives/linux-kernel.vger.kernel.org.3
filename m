Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DEE2E49EEAD
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 00:13:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241122AbiA0XN2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 18:13:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236221AbiA0XN1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 18:13:27 -0500
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51114C06173B
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jan 2022 15:13:27 -0800 (PST)
Received: by mail-io1-xd33.google.com with SMTP id c188so5629237iof.6
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jan 2022 15:13:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=SvzGEzXCgYvi7KPAaNkjO5kx4yEHKrTk8YbZP5vcMi8=;
        b=ZXy2ZZD933LCjsLUvzp2HQvQr72/Pq2wXG1LcB4Pd6PNZypi/e9UkaYO0RRoKyLliK
         tmUBma7OUtig4xYUUuHZH4qb9aNw1tm2YCikBKhSywp99wsQfbKFpzrmJlZrMNehCvUi
         t7z6UVMVatLVOb5h982vL8wbSZ57U0xuK6nTI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=SvzGEzXCgYvi7KPAaNkjO5kx4yEHKrTk8YbZP5vcMi8=;
        b=eQQWKT0saxzpUEYwnUkmSQNBmBJPwiJJLMx9/tblTa2+7jmCn9o9F1hmXvHKz3q8/q
         ZvY1At4qmWpdu9K6JMIKhS3LW6EnGK9uqSZ3ct4rm6TeJc04BlAX10kd26EpGP7Sr+9f
         P2rnWAlnZ7p0OujUOhrklC7LpKgGBXmsvPN5PFWJcTNiRO6cwCypmOV2jgcV1DKYx7Oc
         6RKWafUloYuhB/Z22msBynq9on4iR62UKJ9oKx/nVB9u7ax1vCGs8mlPVrx2Z4ytYT81
         jYupU4PhvQXZ0ft4x0YL1MHYnl2vX8tawYouGUCdpVN971gG3SBxSKakj0mQtmTakUkd
         yHQw==
X-Gm-Message-State: AOAM533PDXR+UxAFwExzqUUTgXSq7NJ/PjAc5+/Xo+DU0ZsX1UVh1IXw
        riCQ/LEKr7ZphCEk3wN94etoMQ==
X-Google-Smtp-Source: ABdhPJwztLJgROQr4nSM8S7baq26zTq5Jpg1LlIpBGUDyn28P60KUahFDNbmlWw5ghXepXWBoV/ANA==
X-Received: by 2002:a5d:8419:: with SMTP id i25mr3512622ion.163.1643325206599;
        Thu, 27 Jan 2022 15:13:26 -0800 (PST)
Received: from ?IPv6:2601:282:8200:4c:fcdb:3423:ed25:a583? ([2601:282:8200:4c:fcdb:3423:ed25:a583])
        by smtp.gmail.com with ESMTPSA id k8sm13571589ilu.57.2022.01.27.15.13.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Jan 2022 15:13:26 -0800 (PST)
Subject: Re: [PATCH 5/5] selftests: openat2: Skip testcases that fail with
 EOPNOTSUPP
To:     Cristian Marussi <cristian.marussi@arm.com>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     shuah@kernel.org, Aleksa Sarai <cyphar@cyphar.com>,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20220126102723.23300-1-cristian.marussi@arm.com>
 <20220126102723.23300-6-cristian.marussi@arm.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <865de7a6-20fc-09ba-1687-b08fdd9610f5@linuxfoundation.org>
Date:   Thu, 27 Jan 2022 16:13:25 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20220126102723.23300-6-cristian.marussi@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/26/22 3:27 AM, Cristian Marussi wrote:
> Skip testcases that fail since the requested valid flags combination is not
> supported by the underlying filesystem.
> 
> Cc: Aleksa Sarai <cyphar@cyphar.com>
> Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
> ---
>   tools/testing/selftests/openat2/openat2_test.c | 12 +++++++++++-
>   1 file changed, 11 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/openat2/openat2_test.c b/tools/testing/selftests/openat2/openat2_test.c
> index 1bddbe934204..7fb902099de4 100644
> --- a/tools/testing/selftests/openat2/openat2_test.c
> +++ b/tools/testing/selftests/openat2/openat2_test.c
> @@ -259,6 +259,16 @@ void test_openat2_flags(void)
>   		unlink(path);
>   
>   		fd = sys_openat2(AT_FDCWD, path, &test->how);
> +		if (fd < 0 && fd == -EOPNOTSUPP) {
> +			/*
> +			 * Skip the testcase if it failed because not supported
> +			 * by FS. (e.g. a valid O_TMPFILE combination on NFS)
> +			 */
> +			ksft_test_result_skip("openat2 with %s fails with %d (%s)\n",
> +					      test->name, fd, strerror(-fd));
> +			goto next;
> +		}
> +
>   		if (test->err >= 0)
>   			failed = (fd < 0);
>   		else
> @@ -303,7 +313,7 @@ void test_openat2_flags(void)
>   		else
>   			resultfn("openat2 with %s fails with %d (%s)\n",
>   				 test->name, test->err, strerror(-test->err));
> -
> +next:
>   		free(fdpath);
>   		fflush(stdout);
>   	}
> 

Thanks for the patch. Will apply to linux-kselftest fixes branc for rc3

thanks,
-- Shuah
