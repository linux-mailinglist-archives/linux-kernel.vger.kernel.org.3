Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0305952890C
	for <lists+linux-kernel@lfdr.de>; Mon, 16 May 2022 17:39:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234163AbiEPPjP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 11:39:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245335AbiEPPjL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 11:39:11 -0400
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com [IPv6:2607:f8b0:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39BC93C729
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 08:39:09 -0700 (PDT)
Received: by mail-ot1-x329.google.com with SMTP id k25-20020a056830169900b00605f215e55dso10298470otr.13
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 08:39:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=KvJtfzxWZsNiNR7EF144SM6SIftj1CmtnD8p12jdtQk=;
        b=Q868IUzJ6Thv/YSXCG69E42/kNk75UsDN3kgljwgJX+lfkMRHX7a6ja7KYAsTSJEJQ
         n48WeJYNQExb3z2R3T2ZHjBobxZIEo8oztoHXWrg54pdSWqN/W9w6gZ0k4Cn8AtolwV6
         mgG7IJ1NYZTIm5VKW4k7GHLcWfTRG66IZXEzw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=KvJtfzxWZsNiNR7EF144SM6SIftj1CmtnD8p12jdtQk=;
        b=xHST+C91EDqiFRj3r7HxR6Dhm5zL1zBilfqW9dUwnNRCGI6MNI7eq4CURD88c5To8G
         6an2I8zCTK+dOuVmz/OoaFrfGIrYKTL4THYlBflRRGUamwGmpfTeShxJNFEDSqHp+bT1
         OD8n77BngQLUChuTJYVCjXr4GI6SExMpLan4cmA3HzbchBWlaVLcELXZL/+gartiVyKK
         JZ60jq01PP9m/YU4tqtIIiSc3e6J6q7v/KVlXyBcS+pknrrwrqVfTgqj1Z7vcpCXShx8
         Nq8lw6T3R3hSekswK5CZl2iSh3joWaNhFG6KjQAwGi8GU5lcXx0ifyiSbvfgW7Cn60HH
         AuHQ==
X-Gm-Message-State: AOAM530FFAX4SSK118LdHKSWSmLoYRNXHuWT4+McAUVixS3l6892nSJg
        eRko1F+r7z9QPG6kZaGPNKonDG6kXcHIRw==
X-Google-Smtp-Source: ABdhPJyiT60xfgWiumqIr8pk98YB/qUqT7UnyA1whM1ug0bSh+dTiIBzUraZ2dkbEh/rn9GfknjLaA==
X-Received: by 2002:a05:6830:151a:b0:606:765d:c6da with SMTP id k26-20020a056830151a00b00606765dc6damr6166236otp.227.1652715548497;
        Mon, 16 May 2022 08:39:08 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id a14-20020a05680804ce00b00325cda1ffbasm3870233oie.57.2022.05.16.08.39.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 May 2022 08:39:08 -0700 (PDT)
Subject: Re: [PATCH v2 1/1] sign-file: Do not attempt to use the ENGINE_* API
 if it's not available
To:     Lee Jones <lee.jones@linaro.org>,
        Salvatore Bonaccorso <carnil@debian.org>
Cc:     Kees Cook <keescook@chromium.org>,
        David Howells <dhowells@redhat.com>,
        David Woodhouse <dwmw2@infradead.org>,
        keyrings@vger.kernel.org, Adam Langley <agl@google.com>,
        linux-kernel@vger.kernel.org, Eric Biggers <ebiggers@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20211005161833.1522737-1-lee.jones@linaro.org>
 <Yicwb+Ceiu8JjVIS@google.com> <202203100851.C00D9AB73@keescook>
 <YoCoySEUSzu9zthg@eldamar.lan> <YoDKiAfcFiyFRyQT@google.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <f3ca4041-df33-493e-96a9-4bf40498ebff@linuxfoundation.org>
Date:   Mon, 16 May 2022 09:39:07 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <YoDKiAfcFiyFRyQT@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/15/22 3:40 AM, Lee Jones wrote:
> On Sun, 15 May 2022, Salvatore Bonaccorso wrote:
> 
>> Hi,
>>
>> On Thu, Mar 10, 2022 at 08:51:56AM -0800, Kees Cook wrote:
>>> On Tue, Mar 08, 2022 at 10:31:11AM +0000, Lee Jones wrote:
>>>> OpenSSL's ENGINE API is deprecated in OpenSSL v3.0.
>>>>
>>>> Use OPENSSL_NO_ENGINE to ensure the ENGINE API is only used if it is
>>>> present.  This will safeguard against compile errors when using SSL
>>>> implementations which lack support for this deprecated API.
>>>
>>> On Fedora rawhide, I'm still seeing a bunch of warnings:
>>>
>>> scripts/sign-file.c: In function 'display_openssl_errors':
>>> scripts/sign-file.c:89:9: warning: 'ERR_get_error_line' is deprecated: Since OpenSSL 3.0 [-Wdeprecat
>>> ed-declarations]
>>>     89 |         while ((e = ERR_get_error_line(&file, &line))) {
>>>        |         ^~~~~
>>> In file included from scripts/sign-file.c:29:
>>> /usr/include/openssl/err.h:411:15: note: declared here
>>>    411 | unsigned long ERR_get_error_line(const char **file, int *line);
>>>        |               ^~~~~~~~~~~~~~~~~~
>>> scripts/sign-file.c: In function 'drain_openssl_errors':
>>> scripts/sign-file.c:102:9: warning: 'ERR_get_error_line' is deprecated: Since OpenSSL 3.0 [-Wdepreca
>>> ted-declarations]
>>>    102 |         while (ERR_get_error_line(&file, &line)) {}
>>>        |         ^~~~~
>>> /usr/include/openssl/err.h:411:15: note: declared here
>>>    411 | unsigned long ERR_get_error_line(const char **file, int *line);
>>>        |               ^~~~~~~~~~~~~~~~~~
>>
>> FWIW, we are seeing the same now on Debian as Debian unstable is
>> moving to OpenSSL 3.0.
>>
>> https://lists.debian.org/debian-release/2022/05/msg00070.html
> 
> Did this patch help?
> 
> We've had a few confirmed reports now.
> 
> My guess is the maintainers are not currently monitoring.
> 
> With some more {Reviewed,Tested}-bys I'd be prepared to submit this
> via other means.  Either via my own repository or via Greg's.
> 
  
I am seeing the same issue on my test system after upgrading to
Ubuntu 22.04 LTS. This patch didn't fix the problem.

Please cc me on your future patches and I can test them.

thanks,
-- Shuah
