Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96EBA4D0C34
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 00:46:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343552AbiCGXrk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 18:47:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241573AbiCGXrj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 18:47:39 -0500
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68EFF307
        for <linux-kernel@vger.kernel.org>; Mon,  7 Mar 2022 15:46:44 -0800 (PST)
Received: by mail-io1-xd33.google.com with SMTP id z7so3845819iom.1
        for <linux-kernel@vger.kernel.org>; Mon, 07 Mar 2022 15:46:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=5l8Mv+VO7L1v69d1VI20d5rRtaJKRUTjknw+6a6gucE=;
        b=fiK3nqOujEVvryYXCNsg3cUZfCASccnwl59hZpmQ2LixPspfXYffZdhcMHv1nkrb9R
         qdD2eJTvUM2mWhSTtJs2S9KW8/tYrGMTu7KQS7WtnHHLOseCzxjU073oUud7IFMB0GHZ
         p+Yi7AG0Tr0bsQHqtanJHY3qpGGFHYecD+PSI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=5l8Mv+VO7L1v69d1VI20d5rRtaJKRUTjknw+6a6gucE=;
        b=DHInKczF5a5gaUsBMYXdxYL1Dr3gRWcsEtBykBNF61R9Ld/bVhG7yaspXmYkQr8TPh
         xkaw+z9iZUs9jFeQ6jPsBRYXLjS4d3SiwlrS6r+0msJLITqspR0IVNccE6SWuC4pVZig
         wfI+jhzrfheCyy1k19REsO1enK5n2ZYsBj0D8Uo/HrsniMgw+/oXH667d2raEtr0QsOH
         HmAN03OVq1G0o8eLmzcpr7jGt8CiF+qS0a35hqbmKsL+D4cduTGXhItT5weka1OEO6Qd
         R0QWccmQbXuduE8YLsj5qhz/13eudrZqJROobNY+0VN7OW0SOmNhHaQJwOlVQMDA4Vqx
         1sfw==
X-Gm-Message-State: AOAM5316FcMoeKzDyd9D5xNOrPO7z2o7sajsjn2i39acZQ2xWv3u/PH9
        D55UjaTAmnSeXvgT3uwpRN4dxA==
X-Google-Smtp-Source: ABdhPJxNhHEDriBLH+KK5w44IGI+UjbQQ1DYXEskRkQHId8x++oJRmlfzD37dPR1YYXVoVTaHAk2gg==
X-Received: by 2002:a02:604f:0:b0:30f:e6f1:3883 with SMTP id d15-20020a02604f000000b0030fe6f13883mr13140181jaf.266.1646696803779;
        Mon, 07 Mar 2022 15:46:43 -0800 (PST)
Received: from [192.168.1.128] ([71.205.29.0])
        by smtp.gmail.com with ESMTPSA id 142-20020a6b0194000000b00645b6cda8bfsm3319091iob.17.2022.03.07.15.46.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Mar 2022 15:46:43 -0800 (PST)
Subject: Re: [PATCH 4.9 00/32] 4.9.305-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     stable@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
        jonathanh@nvidia.com, f.fainelli@gmail.com,
        sudipm.mukherjee@gmail.com, slade@sladewatkins.com,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20220307091634.434478485@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <706bdd4e-0466-84de-5a7c-768e67f3b312@linuxfoundation.org>
Date:   Mon, 7 Mar 2022 16:46:42 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20220307091634.434478485@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/7/22 2:18 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.9.305 release.
> There are 32 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 09 Mar 2022 09:16:25 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.9.305-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.9.y
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
