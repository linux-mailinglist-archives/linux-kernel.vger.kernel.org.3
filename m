Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 229464E4973
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Mar 2022 00:01:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232739AbiCVXCe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Mar 2022 19:02:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233369AbiCVXCb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 19:02:31 -0400
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D872D6D962
        for <linux-kernel@vger.kernel.org>; Tue, 22 Mar 2022 16:01:02 -0700 (PDT)
Received: by mail-io1-xd34.google.com with SMTP id 125so8672361iov.10
        for <linux-kernel@vger.kernel.org>; Tue, 22 Mar 2022 16:01:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=/RA0zMxg2qHyle/ngnbNKGikQM+syZF+MIij4IWINF4=;
        b=CBTib+nNJp48NWWSyN8Bco5RiYepejZPI2/UzByVFig6DIaLLcPp7hK+42Zk1apm+y
         Hg7ixQuGFoEBYk3Fe5AimptWv1d4PRMV0c+OKqhbY6CYYVYhje88+kjhb0Q/b/rg/56N
         BOOcitPIKOoKWUUkFQgJdiGPGH0qh7nvfOj7I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=/RA0zMxg2qHyle/ngnbNKGikQM+syZF+MIij4IWINF4=;
        b=RXDWZsfe8ijZYqzNKYxs8jAZpDkez0PTp+D6ETLObEIbhHpgDpKkxLRo4yY/vY2cwt
         DBInIwa9K4ED89ZciXsrmM3wqwGHOmptSaotwI8ewDEc3OXGVhZrM8S1toOt9CieD7PW
         thydPIAwyMNO1T7BQnls9/8mYkj+S0CG1RJjlAH5TREzf0sA5Eyo0OpawMYuVpfZqGl1
         NEh9C8cP1zfqHuO3zrtCDk/hGZiM3RIEkGtiXHWda0jLlyQ6bsThNfMV7OCr/zSS9r4k
         aYZJW10IVeUfvW6jM7z/Wb3BaqcKRSS6eEz1SzZNx2X1xNLXeCVeZBdVvNY30RfoR1Ma
         9g2Q==
X-Gm-Message-State: AOAM533Du2lA6dqCnIR77EpRShbL+xkeFGpZUBPip3PYtcWOJyLbmQVi
        5LVnNbuUoIQ1xwbnw5mK7nmo1Q==
X-Google-Smtp-Source: ABdhPJyNeIkOpBixGpJLyZZLahbs114gK58mt0ku1BpbbERVZWBn4gkawAtf8QLCn9J8GwzqJcEK/A==
X-Received: by 2002:a05:6638:4781:b0:31a:6f26:e8a7 with SMTP id cq1-20020a056638478100b0031a6f26e8a7mr12423629jab.33.1647990062219;
        Tue, 22 Mar 2022 16:01:02 -0700 (PDT)
Received: from [192.168.1.128] ([71.205.29.0])
        by smtp.gmail.com with ESMTPSA id v5-20020a92c6c5000000b002c821b1c5f9sm4496509ilm.21.2022.03.22.16.01.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Mar 2022 16:01:01 -0700 (PDT)
Subject: Re: [PATCH linux-next] selftests/vDSO: fix array_size.cocci warning
To:     Guo Zhengkui <guozhengkui@vivo.com>, Shuah Khan <shuah@kernel.org>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     zhengkui_guo@outlook.com, Shuah Khan <skhan@linuxfoundation.org>
References: <20220321052757.10918-1-guozhengkui@vivo.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <489c8759-27c6-c71f-987d-3fc6d255f3b8@linuxfoundation.org>
Date:   Tue, 22 Mar 2022 17:01:01 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20220321052757.10918-1-guozhengkui@vivo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/20/22 11:27 PM, Guo Zhengkui wrote:
> Fix the following coccicheck warning:
> 
> tools/testing/selftests/vDSO/vdso_test_correctness.c:309:46-47:
> WARNING: Use ARRAY_SIZE
> tools/testing/selftests/vDSO/vdso_test_correctness.c:373:46-47:
> WARNING: Use ARRAY_SIZE
> 
> It has been tested with gcc (Debian 8.3.0-6) 8.3.0 on x86_64.
> 
> Signed-off-by: Guo Zhengkui <guozhengkui@vivo.com>
> ---
>   tools/testing/selftests/vDSO/vdso_test_correctness.c | 9 +++------
>   1 file changed, 3 insertions(+), 6 deletions(-)
> 
> diff --git a/tools/testing/selftests/vDSO/vdso_test_correctness.c b/tools/testing/selftests/vDSO/vdso_test_correctness.c
> index c4aea794725a..e691a3cf1491 100644
> --- a/tools/testing/selftests/vDSO/vdso_test_correctness.c
> +++ b/tools/testing/selftests/vDSO/vdso_test_correctness.c
> @@ -20,6 +20,7 @@
>   #include <limits.h>
>   
>   #include "vdso_config.h"
> +#include "../kselftest.h"
>   
>   static const char **name;
>   
> @@ -306,10 +307,8 @@ static void test_clock_gettime(void)
>   		return;
>   	}
>   
> -	for (int clock = 0; clock < sizeof(clocknames) / sizeof(clocknames[0]);
> -	     clock++) {
> +	for (int clock = 0; clock < ARRAY_SIZE(clocknames); clock++)
>   		test_one_clock_gettime(clock, clocknames[clock]);
> -	}
>   
>   	/* Also test some invalid clock ids */
>   	test_one_clock_gettime(-1, "invalid");
> @@ -370,10 +369,8 @@ static void test_clock_gettime64(void)
>   		return;
>   	}
>   
> -	for (int clock = 0; clock < sizeof(clocknames) / sizeof(clocknames[0]);
> -	     clock++) {
> +	for (int clock = 0; clock < ARRAY_SIZE(clocknames); clock++)
>   		test_one_clock_gettime64(clock, clocknames[clock]);
> -	}
>   
>   	/* Also test some invalid clock ids */
>   	test_one_clock_gettime64(-1, "invalid");
> 

Looks good to me. I will apply this once merge window closes.

thanks,
-- Shuah
