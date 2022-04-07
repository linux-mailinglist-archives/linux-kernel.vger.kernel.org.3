Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF6DB4F885A
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 22:32:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229687AbiDGUac (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 16:30:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229580AbiDGUaI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 16:30:08 -0400
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCBAC488599
        for <linux-kernel@vger.kernel.org>; Thu,  7 Apr 2022 13:14:18 -0700 (PDT)
Received: by mail-qk1-f176.google.com with SMTP id bk12so3154347qkb.7
        for <linux-kernel@vger.kernel.org>; Thu, 07 Apr 2022 13:14:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=i3fjMxeOPzHLoYAHKb6PCBhzmcPMnM/TNC6V6L/f24Q=;
        b=L9BQgrut1xgORokDDOEvWbzPG40wzWB5zAc2yAy0bfZ57OqWIQpvwPhDv5vFzkJ+XZ
         nXuvZEZOl1r9c1aYtIiNNAZUI5EDU+My2YHPu3W1Ym3hc7leujWnDF49vAVi4FyAoigt
         DMshxcOJ+pJ+7DPgn0bI1hYDchvscZuqdpcSU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=i3fjMxeOPzHLoYAHKb6PCBhzmcPMnM/TNC6V6L/f24Q=;
        b=ITD7ov1cdnHFpvpKPpBDZYKpgEMPin6eXRTfNlmRnW7wxo1eUE/N7THG3+cDlnAU8C
         27zt+VZE+WHVPE9+aeLRJJlxC6biKcHoaoISv6s4EUaAKH0UbJDmDdls89uHwVM1gnQn
         Zk20Spq+sNLEzTaO4bvRvs+IdbHfwtj1ohbbC1Z4KPuNCX8Gd5qfV+Dps8Zb/uMsMLbH
         OgsEVpykQKV0fxckhJXxtGdGT/uc8k8lQoKNIdIMY40fMlmvLpOkWwProLSWXHx4i8pB
         +4zQrFPlIfWUViWViL6LzwvlMX0YHr2rTmEpT7HscfhLAGthzykGbuKuWBETxJeLzJeT
         pKUw==
X-Gm-Message-State: AOAM531lxdTezrsjLlQzr0rnIHcgoCtu41tSTGeokp5Er4++F2B+rDy4
        n1J9UGRgDZNSAnPgT+HonolAX4mXKJf0gA==
X-Google-Smtp-Source: ABdhPJz5DaqOGFttJNDDRdIHIC2g5QjLHBA0/lVe6+h70wF2TjnZ2c0JyqQ+8l7gPYd9sMtMCz+cew==
X-Received: by 2002:a02:6a6b:0:b0:323:fcf9:2227 with SMTP id m43-20020a026a6b000000b00323fcf92227mr7585831jaf.137.1649361799653;
        Thu, 07 Apr 2022 13:03:19 -0700 (PDT)
Received: from [192.168.1.128] ([71.205.29.0])
        by smtp.gmail.com with ESMTPSA id m9-20020a0566022ac900b0064cf3d9f35fsm8870151iov.35.2022.04.07.13.03.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Apr 2022 13:03:19 -0700 (PDT)
Subject: Re: [PATCH 4/4] selftests/memfd: add tests for MFD_NOEXEC
To:     Daniel Verkamp <dverkamp@chromium.org>, linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>,
        Mattias Nissler <mnissler@chromium.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20220401220834.307660-1-dverkamp@chromium.org>
 <20220401220834.307660-5-dverkamp@chromium.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <c8114977-a757-60d0-d6b7-9d3f91568019@linuxfoundation.org>
Date:   Thu, 7 Apr 2022 14:03:18 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20220401220834.307660-5-dverkamp@chromium.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/1/22 4:08 PM, Daniel Verkamp wrote:
> Tests that ensure MFD_NOEXEC memfds have the appropriate mode bits and
> cannot be chmod-ed into being executable.
> 
> Signed-off-by: Daniel Verkamp <dverkamp@chromium.org>
> ---
>   tools/testing/selftests/memfd/memfd_test.c | 34 ++++++++++++++++++++++
>   1 file changed, 34 insertions(+)
> 
> diff --git a/tools/testing/selftests/memfd/memfd_test.c b/tools/testing/selftests/memfd/memfd_test.c
> index fdb0e46e9df9..a79567161cdf 100644
> --- a/tools/testing/selftests/memfd/memfd_test.c
> +++ b/tools/testing/selftests/memfd/memfd_test.c
> @@ -32,6 +32,10 @@
>   #define F_SEAL_EXEC	0x0020
>   #endif
>   
> +#ifndef MFD_NOEXEC
> +#define MFD_NOEXEC	0x0008U
> +#endif
> +
>   /*
>    * Default is not to test hugetlbfs
>    */
> @@ -959,6 +963,35 @@ static void test_seal_exec(void)
>   	close(fd);
>   }
>   
> +/*
> + * Test memfd_create with MFD_NOEXEC flag
> + * Test that MFD_NOEXEC applies F_SEAL_EXEC and prevents change of exec bits
> + */
> +static void test_noexec(void)
> +{
> +	int fd;
> +
> +	printf("%s NOEXEC\n", memfd_str);
> +
> +	/* Create with NOEXEC and ALLOW_SEALING */
> +	fd = mfd_assert_new("kern_memfd_noexec",
> +			    mfd_def_size,
> +			    MFD_CLOEXEC | MFD_ALLOW_SEALING | MFD_NOEXEC);

Don't we need to check fd here?

> +	mfd_assert_mode(fd, 0666);
> +	mfd_assert_has_seals(fd, F_SEAL_EXEC);
> +	mfd_fail_chmod(fd, 0777);
> +	close(fd);
> +
> +	/* Create with NOEXEC but without ALLOW_SEALING */
> +	fd = mfd_assert_new("kern_memfd_noexec",
> +			    mfd_def_size,
> +			    MFD_CLOEXEC | MFD_NOEXEC);

What happens when mfd_assert_new() fails - don't we need to check fd?

> +	mfd_assert_mode(fd, 0666);
> +	mfd_assert_has_seals(fd, F_SEAL_EXEC | F_SEAL_SEAL);
> +	mfd_fail_chmod(fd, 0777);
> +	close(fd);
> +}
> +
>   /*
>    * Test sharing via dup()
>    * Test that seals are shared between dupped FDs and they're all equal.
> @@ -1132,6 +1165,7 @@ int main(int argc, char **argv)
>   
>   	test_create();
>   	test_basic();
> +	test_noexec();
>   
>   	test_seal_write();
>   	test_seal_future_write();
> 

fd isn't checked in the other test F_SEAL_EXEC in the 3/4 patch.

thanks,
-- Shuah
