Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A569E4B5BEE
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 22:02:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229611AbiBNVAT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 16:00:19 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:60822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229882AbiBNVAN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 16:00:13 -0500
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com [IPv6:2607:f8b0:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 373B0163059
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 13:00:03 -0800 (PST)
Received: by mail-il1-x130.google.com with SMTP id o10so13356696ilh.0
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 13:00:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=2wZJbdTfpo7iXD69QMlhy8jUhbjvxJ1xWrqMBSAFcxI=;
        b=RaKgYvDC1w1SCgT1O6gDTYjDDGxquf+UgjnTkl84HMl/FmLZ7hfBAZg6Ef5umJfQ73
         BysBuNsGfvIUTxfTA1H96WsOdUEmauZRBs6TS1AHYHQSjzz+S6SA/UFhNtODJ5+QxAFZ
         UAN3G3kV2O5sG6jntb5tkoB01w1SN13dU/1kI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=2wZJbdTfpo7iXD69QMlhy8jUhbjvxJ1xWrqMBSAFcxI=;
        b=2xqJkTDo3s6HpGvVgQ8shi93gZwsTePIXh1Y18rGs39IBz1WqRhtbrT4n9jS58uocD
         yQLKCEtoFkvyjRGlJnzxodD5/YHGAt63tMCDbOBUDzlhhhmQfsITTgmpggDIOYfFms26
         YIdnsujI7d0lW9+eAMC1uSzE8G8wc9VKx5baQRUYm+kOGnecLJGB+DljaFILkLlKlaLf
         SYOAkNrzneJsyINaJ6oF9qwS1cC+rZMHs7RWfPRWGRW6uS9DP3rYKHrbLRetHkb3ZYGw
         zWIp1zNT2qRzKDCkYJGEs0RRNMiijnxDwbFS2B0zVvzf0LhjdvbMn0N91+b94lDXtvOJ
         yF0Q==
X-Gm-Message-State: AOAM533QvVQ3vJN/l9ycKvWTFEg3jHiZcT3ERI7W9pBppokNZDLzsEwy
        9GqPXNEyZh0WYN8d3WSeWxKIAQ==
X-Google-Smtp-Source: ABdhPJx57do0GjCIjdw2SoDd29KXMYNHF9pvXnPL0FZMgucvaDnLzBZmUu41yHaQT5+YMMjDeqBE0Q==
X-Received: by 2002:a05:6e02:1c08:: with SMTP id l8mr419719ilh.241.1644872402579;
        Mon, 14 Feb 2022 13:00:02 -0800 (PST)
Received: from [192.168.1.128] ([71.205.29.0])
        by smtp.gmail.com with ESMTPSA id n3sm21568919ioz.9.2022.02.14.13.00.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Feb 2022 13:00:02 -0800 (PST)
Subject: Re: [PATCH V2 2/2] selftests: sgx: Treat CC as one argument
To:     Muhammad Usama Anjum <usama.anjum@collabora.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Shuah Khan <shuah@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Jethro Beekman <jethro@fortanix.com>,
        Borislav Petkov <bp@suse.de>,
        "open list:INTEL SGX" <linux-sgx@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        David.Laight@ACULAB.COM
Cc:     kernel@collabora.com, kernelci@groups.io,
        "kernelci.org bot" <bot@kernelci.org>,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20220214184109.3739179-1-usama.anjum@collabora.com>
 <20220214184109.3739179-3-usama.anjum@collabora.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <d6212372-5239-c903-4f0f-9b3bcfc9b52d@linuxfoundation.org>
Date:   Mon, 14 Feb 2022 14:00:01 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20220214184109.3739179-3-usama.anjum@collabora.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/14/22 11:41 AM, Muhammad Usama Anjum wrote:
> CC can have multiple sub-strings like "ccache gcc". For check_cc.sh,
> CC needs to be treated like one argument. Put double quotes around it to
> make CC one string and hence one argument.
> 
> Fixes: 2adcba79e69d ("selftests/x86: Add a selftest for SGX")
> Reported-by: "kernelci.org bot" <bot@kernelci.org>
> Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
> ---
>   tools/testing/selftests/sgx/Makefile | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/sgx/Makefile b/tools/testing/selftests/sgx/Makefile
> index 2956584e1e37f..75af864e07b65 100644
> --- a/tools/testing/selftests/sgx/Makefile
> +++ b/tools/testing/selftests/sgx/Makefile
> @@ -4,7 +4,7 @@ include ../lib.mk
>   
>   .PHONY: all clean
>   
> -CAN_BUILD_X86_64 := $(shell ../x86/check_cc.sh $(CC) \
> +CAN_BUILD_X86_64 := $(shell ../x86/check_cc.sh "$(CC)" \
>   			    ../x86/trivial_64bit_program.c)
>   
>   ifndef OBJCOPY
> 

Looks good to me.

Reviewed-by: Shuah Khan <skhan@linuxfoundation.org>

thanks,
-- Shuah

