Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E3FC4D525E
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Mar 2022 20:44:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343617AbiCJTek (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Mar 2022 14:34:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230272AbiCJTei (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 14:34:38 -0500
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FE5814F29F
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 11:33:33 -0800 (PST)
Received: by mail-io1-xd34.google.com with SMTP id r2so7667443iod.9
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 11:33:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=TjN/XrHvzjuIzLGTgkYjfBEq5EotAmGIX3AzMDA/7ho=;
        b=MmaRL1Rqa5B1Xw+s7VcY1Iq5XME47wvDCfomjkzn+BsFr4eDHSoVCh11D6CVczFJFX
         LxLLjAf3pvC58HEX+F8UmHhmwVMCkrVG86s62st8hUxMMWprFzJIgb688m9Eix4G9hu+
         MvGTRSM8dywO9kFkh45pnh7U907UNzLh//PF0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=TjN/XrHvzjuIzLGTgkYjfBEq5EotAmGIX3AzMDA/7ho=;
        b=B+WuW+k61aPCzC4FjUeP2eaEwGJEH5clIdRpRVti9pUD7csxbstFrzNuNOXXRTqfYL
         jqwU2KQ8k1+ThcpxCdIiHEUNvUyAjm960rsa8Hp8jIDlFHGsSsOq2CLX2KsUqaT/anZi
         si+wvl8mUj7Rwpyp2iVh9UsDc5VbI2q2UB29HqmQFifJQYzzZagSb3B9TBsKGguwoxG+
         GuI+2bDS6X4p/auWppgXLcM4n71FCZ0mcf2TtSRSA/WnwgOFbzdDGVb1n3KRCU4v1de+
         +I0boIx4GvalUJRWUr5OPBQmr5/VZpkKTqDpVt1il3/4RZgvvXfqdZNz6lV8wrUZq6XL
         BvWg==
X-Gm-Message-State: AOAM531HDeLkCU48LPRdKHxniC6ssfOrgSjpN2IPBZ6RAR/X5d1ZLMkT
        x5kKZZ/Yee/7TqOiwTohTrhgCQ==
X-Google-Smtp-Source: ABdhPJxQLuEdTlPfh15yh12C/ToZiiTRe88yc4baJoc7tuv+Ma9oBpabV5xTJ/lNRlfySIUjQPCQPQ==
X-Received: by 2002:a6b:4911:0:b0:646:3a67:397 with SMTP id u17-20020a6b4911000000b006463a670397mr5085659iob.73.1646940812712;
        Thu, 10 Mar 2022 11:33:32 -0800 (PST)
Received: from [192.168.1.128] ([71.205.29.0])
        by smtp.gmail.com with ESMTPSA id g2-20020a056e021a2200b002c662869cb1sm3270566ile.62.2022.03.10.11.33.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Mar 2022 11:33:32 -0800 (PST)
Subject: Re: [PATCH 5.10 00/58] 5.10.105-rc2 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     stable@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
        jonathanh@nvidia.com, f.fainelli@gmail.com,
        sudipm.mukherjee@gmail.com, slade@sladewatkins.com,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20220310140812.869208747@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <39e21359-c94e-1007-cdc9-af4feeea9204@linuxfoundation.org>
Date:   Thu, 10 Mar 2022 12:33:31 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20220310140812.869208747@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/10/22 7:18 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.10.105 release.
> There are 58 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat, 12 Mar 2022 14:07:58 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.10.105-rc2.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.10.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h
> 
Compiled and booted on my test system. No dmesg regressions.

Tested-by: Shuah Khan <skhan@linuxfoundation.org>

thanks,
-- Shuah
