Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1145252C72C
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 01:02:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231256AbiERXAk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 19:00:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231267AbiERXAb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 19:00:31 -0400
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com [IPv6:2607:f8b0:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7A4F2375DD
        for <linux-kernel@vger.kernel.org>; Wed, 18 May 2022 15:59:04 -0700 (PDT)
Received: by mail-ot1-x330.google.com with SMTP id m6-20020a05683023a600b0060612720715so2383668ots.10
        for <linux-kernel@vger.kernel.org>; Wed, 18 May 2022 15:59:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=kygPfhyErW7dvKH17CTT82TgIAgiLDQSd48duVgDxwo=;
        b=O+ofcjZ731KvhGfJgQg10ps3UVFNc6LwD7fN9G3r2I0CQAE3XPw6a11H//xfRSdxMm
         66tzSgCDJFgHSJGAf7O7bPtOVatqDLOsVQSAtuX7kalYG3WQ60yI1pdJ5HD/ZL1EYoZX
         KnnLxumJcG4Y1voi72hkujqfGvIpVkEwo2KRk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=kygPfhyErW7dvKH17CTT82TgIAgiLDQSd48duVgDxwo=;
        b=sQnOwzXMMEvxSxTYsCu5/X84jFUrVcG4Gvq5SEOf+wWPhrdYXN92+6RbbRSnwOtC9+
         nJLRq/p0Lkphiu24Wd+Mi8Vr/rKJXAZkyqe5lBRXXNVTWIezSOfr5/xEFc8o0qEIaQeo
         U2yl7hVDX9A/f1hWBY46KsTR5swFPfDaQamraNhJYbqpyN51BLGzj7QHxwhXE6q8RmrO
         5mmyZix+G1JuW8UQGI63lSLu2fIloiFPqnBa+09JZmGiK4+7e9bfLEfzcrcHETJr2ttR
         w1R9EcdvRkhHnA6RzEqPAKUjQcGdQwssUxTrp3QAlHdQZZXiszWSpAr6m2/yoTv5guHV
         dqig==
X-Gm-Message-State: AOAM532jT+FtDNr/3w+OGqABEgTbfbjQSrYFJzxkpRrjJuDpW42lz2Ci
        194IfUrVmMqhqPhHJrTkFbEG4g==
X-Google-Smtp-Source: ABdhPJzcao+B0GJgFE10anN4Ws1SW5llNsEaaFkNV2yF+gALlyuED9RalqIh/OVY9Ws71U5cIpeNyA==
X-Received: by 2002:a9d:34b:0:b0:605:f0f1:e28e with SMTP id 69-20020a9d034b000000b00605f0f1e28emr835845otv.304.1652914743981;
        Wed, 18 May 2022 15:59:03 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id d188-20020acab4c5000000b00325f4f40f9esm1274522oif.22.2022.05.18.15.59.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 May 2022 15:59:03 -0700 (PDT)
Subject: Re: [PATCH v2] sign-file: Convert API usage to support OpenSSL v3
To:     Kees Cook <keescook@chromium.org>,
        David Howells <dhowells@redhat.com>
Cc:     David Woodhouse <dwmw2@infradead.org>,
        Eric Biggers <ebiggers@kernel.org>,
        Salvatore Bonaccorso <carnil@debian.org>,
        keyrings@vger.kernel.org, Adam Langley <agl@google.com>,
        Lee Jones <lee.jones@linaro.org>, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20220518215129.264872-1-keescook@chromium.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <9e9a687e-3c72-fdf9-eb64-6be7b60b9706@linuxfoundation.org>
Date:   Wed, 18 May 2022 16:59:02 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20220518215129.264872-1-keescook@chromium.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/18/22 3:51 PM, Kees Cook wrote:
> OpenSSL's ENGINE API is deprecated in OpenSSL v3.0, along with some
> other functions. Remove the ENGINE use and a macro work-around for
> ERR_get_error_line().
> 
> Cc: David Howells <dhowells@redhat.com>
> Cc: David Woodhouse <dwmw2@infradead.org>
> Cc: Eric Biggers <ebiggers@kernel.org>
> Cc: Shuah Khan <skhan@linuxfoundation.org>
> Cc: Salvatore Bonaccorso <carnil@debian.org>
> Cc: keyrings@vger.kernel.org
> Suggested-by: Adam Langley <agl@google.com>
> Co-developed-by: Lee Jones <lee.jones@linaro.org>
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
> v1: https://lore.kernel.org/lkml/20211005161833.1522737-1-lee.jones@linaro.org/
> v2: https://lore.kernel.org/lkml/Yicwb+Ceiu8JjVIS@google.com/
> v3:
>   - Eliminate all the build warnings with OpenSSL 3
>   - Fully remove ENGINE usage, if it can be optional, just drop it.
> ---
>   scripts/sign-file.c | 49 ++++++++++-----------------------------------
>   1 file changed, 11 insertions(+), 38 deletions(-)

Worked for me on OpenSSL v3 and older version .

Tested-by: Shuah Khan <skhan@linuxfoundation.org>

thanks,
-- Shuah
