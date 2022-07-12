Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 026B257105A
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 04:39:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231295AbiGLCjo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 22:39:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230097AbiGLCjg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 22:39:36 -0400
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com [IPv6:2607:f8b0:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C9738CCA5
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 19:39:36 -0700 (PDT)
Received: by mail-il1-x12a.google.com with SMTP id u13so4098075iln.6
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 19:39:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=HNSoPZdBVD0hLNcUPHRy/CVz6JFLbt9O+9VfHBukhog=;
        b=DA/GueGeVL+V/YL6lExae0zzAsfmSscA2j9BGofaxp0kltdaA1gs1WA1yjjABAwp6C
         gRwSOXd+82K/iicnwT5sHy5HY8gyaQAMbt53edEqyAfEibSDIohw/8WbmFraUSvdyQDg
         EuatdK/iTrxVr0UAj9uMeaH7yvDJWuyCeRY0k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=HNSoPZdBVD0hLNcUPHRy/CVz6JFLbt9O+9VfHBukhog=;
        b=iOMFF1479iu8eHvjHdR+zAB5wQGcq6Jm6LOL9qS1UiF25N3LgAIo62MXuLHwtEOjId
         KNTcemH4Q6hBs0vpldV8Ls8jMkMh92xgU6vqLSVcwVMsfpcPyoNeNwLZRwTmfEs/V223
         O5PCXoUY58T5TP1wAxbk/3pdI0/2ZJAQrvbkHjeHHUVOtMyf0qTs4sUenhmh0yBFdjN2
         zEWFuPgXhtWp+fgb0saHnSHAWLF/pKYua7Fs2oa9TnNihXOaD6TdNhodLBAiqwnNP5YZ
         XEbJscVgNzwGYa0YU5URDZKEKSevYRiIZyj70HXc1U7kygvrJYebvSduI3cqqCuTxETP
         CC0g==
X-Gm-Message-State: AJIora/ZbYfn9e7YbnexMBrkxMrwN5o9NZMOP8icmRQP0/SOGd4Iq+yL
        EHYMvpbtmqlHOmxfH+s0RkJFWg==
X-Google-Smtp-Source: AGRyM1taBiKM+MvPRiHZOnZWXGfU+m0onqRuI0xdEB1g231+X5ziPLVXmQx1Xchpsd/zXjkKMOj6qw==
X-Received: by 2002:a05:6e02:1846:b0:2dc:9083:e831 with SMTP id b6-20020a056e02184600b002dc9083e831mr206656ilv.100.1657593575672;
        Mon, 11 Jul 2022 19:39:35 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id n12-20020a92d9cc000000b002db4e72ead5sm3306271ilq.50.2022.07.11.19.39.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Jul 2022 19:39:35 -0700 (PDT)
Subject: Re: [PATCH 5.10 00/55] 5.10.130-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     stable@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
        jonathanh@nvidia.com, f.fainelli@gmail.com,
        sudipm.mukherjee@gmail.com, slade@sladewatkins.com,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20220711090541.764895984@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <ee9c73c5-668d-9768-a5fc-f87ca73b3bae@linuxfoundation.org>
Date:   Mon, 11 Jul 2022 20:39:34 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20220711090541.764895984@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/11/22 3:06 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.10.130 release.
> There are 55 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 13 Jul 2022 09:05:28 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.10.130-rc1.gz
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
