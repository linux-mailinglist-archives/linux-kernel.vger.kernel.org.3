Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D25C49EEA8
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 00:12:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235188AbiA0XL7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 18:11:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229608AbiA0XL5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 18:11:57 -0500
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9893EC061714
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jan 2022 15:11:57 -0800 (PST)
Received: by mail-io1-xd2b.google.com with SMTP id y84so5707183iof.0
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jan 2022 15:11:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=aT9qZCD/r6lIpUikPXbdoH9+ikbx9vSepHUfRfOtdds=;
        b=LSn/yZBj7+lTfmY6hiqcaiFaNFi+v72l93gi29lMMuhQ9SW6uOpcWk+VK+UOJP/T6b
         kHPh4X7Ril+8AIOz+ZhXymZTeCFr0g8bX+YW7y3Xh7KEEnck/Xk/WZ/9J7tZl39ZJ3a4
         lNmO8x49n+pJGtcwS48lHZUdvUKoU/vHVSNSg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=aT9qZCD/r6lIpUikPXbdoH9+ikbx9vSepHUfRfOtdds=;
        b=YaK1p6x9p7chTuPLdG0i9vHmFGcVTrzTr76uexm3uA+dIqXzDOz8fVAGkwyGevSCO1
         QHZaPgIM6wV6JaMNB5CPE7yCIocCttGWNv/MSb2M3wVZ/1wRbDn4bAw8HOQ7Nr67mp+r
         AOW6ysxJvammAHFHL5fS35Tsdnx4eUAwOfKx34syMSrNYvZ/8lEZ2/q35tX69LYdvTg9
         VJgrMdOavsLrJQ7j7fHaDKKF6KaURqXEg8Zz+K0ChkkeexPacDXLe+7A0hg2fZmfaXM4
         RCfikGqCviNO5im0Wmz7/dNbWW8Ettyml3E0P5+UoQlR5YqAb0WYYO/p28qE2jdrSEiU
         vsCQ==
X-Gm-Message-State: AOAM531inuqQ8U5vPFh/vK7ZFFvf2du3iMIWGwOZ42SjHKOGbveXondG
        rB7NOP4T9vVGQyixRWAalfubxiHx485CtQ==
X-Google-Smtp-Source: ABdhPJxFxOmg9wE7I//aW4Nh2f7O8J9072xtlARw6DKGFD6PUvV6iORgesAqCo1BWVwn8EM1dVes3g==
X-Received: by 2002:a05:6602:2492:: with SMTP id g18mr3598869ioe.24.1643325117014;
        Thu, 27 Jan 2022 15:11:57 -0800 (PST)
Received: from ?IPv6:2601:282:8200:4c:fcdb:3423:ed25:a583? ([2601:282:8200:4c:fcdb:3423:ed25:a583])
        by smtp.gmail.com with ESMTPSA id h13sm13271677ili.31.2022.01.27.15.11.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Jan 2022 15:11:56 -0800 (PST)
Subject: Re: [PATCH 3/5] selftests: openat2: Print also errno in failure
 messages
To:     Cristian Marussi <cristian.marussi@arm.com>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     shuah@kernel.org, Aleksa Sarai <cyphar@cyphar.com>,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20220126102723.23300-1-cristian.marussi@arm.com>
 <20220126102723.23300-4-cristian.marussi@arm.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <9152aeab-6f89-7825-3705-e358a2106662@linuxfoundation.org>
Date:   Thu, 27 Jan 2022 16:11:56 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20220126102723.23300-4-cristian.marussi@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/26/22 3:27 AM, Cristian Marussi wrote:
> In E_func() macro, on error, print also errno in order to aid debugging.
> 
> Cc: Aleksa Sarai <cyphar@cyphar.com>
> Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
> ---
>   tools/testing/selftests/openat2/helpers.h | 11 ++++++-----
>   1 file changed, 6 insertions(+), 5 deletions(-)
> 
> diff --git a/tools/testing/selftests/openat2/helpers.h b/tools/testing/selftests/openat2/helpers.h
> index a6ea27344db2..ad5d0ba5b6ce 100644
> --- a/tools/testing/selftests/openat2/helpers.h
> +++ b/tools/testing/selftests/openat2/helpers.h
> @@ -62,11 +62,12 @@ bool needs_openat2(const struct open_how *how);
>   					(similar to chroot(2)). */
>   #endif /* RESOLVE_IN_ROOT */
>   
> -#define E_func(func, ...)						\
> -	do {								\
> -		if (func(__VA_ARGS__) < 0)				\
> -			ksft_exit_fail_msg("%s:%d %s failed\n", \
> -					   __FILE__, __LINE__, #func);\
> +#define E_func(func, ...)						      \
> +	do {								      \
> +		errno = 0;						      \
> +		if (func(__VA_ARGS__) < 0)				      \
> +			ksft_exit_fail_msg("%s:%d %s failed - errno:%d\n",    \
> +					   __FILE__, __LINE__, #func, errno); \
>   	} while (0)
>   
>   #define E_asprintf(...)		E_func(asprintf,	__VA_ARGS__)
> 

Looks good. Will apply to linux-kselftest rc3

thanks,
-- Shuah

