Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EA144BECB0
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Feb 2022 22:39:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232270AbiBUVjW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Feb 2022 16:39:22 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:53112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231829AbiBUVjO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 16:39:14 -0500
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com [IPv6:2607:f8b0:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36BB122BC3
        for <linux-kernel@vger.kernel.org>; Mon, 21 Feb 2022 13:38:51 -0800 (PST)
Received: by mail-oi1-x22e.google.com with SMTP id p15so12366798oip.3
        for <linux-kernel@vger.kernel.org>; Mon, 21 Feb 2022 13:38:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=DH+E+GQLJh3PXZfDVsV9DfIgpd7CIImULQ6NoMbcQBc=;
        b=hl5jgh2sciQ1NduFDYG2pSAYc7PDiCiXqB2WpN60JZfDOZrCry8BY4D6pWOSk1uLzH
         vYomP+7cxVGdiH7jz8QCAIpMBhyebHBsL1Czw8mq3pou2vHAQn9F5y/+BPj16gUZB2Gf
         i/colj2fanCJz0kOCevLCFgWi+8n0foQEbU6s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=DH+E+GQLJh3PXZfDVsV9DfIgpd7CIImULQ6NoMbcQBc=;
        b=EQYrtph1iz9zNVLbHvhUHABT1AirHKEN8inK1y1AEs/jh7gZSM6NzMZ0NbbX/RLK2g
         sas1bf4xUU0syKgEEqakzYliHh0Pmorwa/NubFRxwfJ73gWSrxvJpIJpo6wWKW1a3+DA
         2AmxYWl8/uh4wUdm1z9wR6wt0QkufDRCsFOGd0O3KGeKDIHOJsTZydnatosYfayiWuGw
         bHhM+lC8i8msNgUcBTrv2H3L0TbFheutRlDDLGKu2cvbyWzuJ4g+QmWZS5b+dmklqxR5
         QUgk5ZjBsL/UFZvAhnvEBkeuNjvkwGyQrbtfYeXu/9uXSdCzIoIE4t516fdl6ZGiuSV1
         Bf4Q==
X-Gm-Message-State: AOAM533c3tR7fZN3AdZqkf9SenV9p5FpJ2TxtcAKlHcwqGste5hiHEO2
        arfjFhHg83ZssXu61O7TfUM/NA==
X-Google-Smtp-Source: ABdhPJyj6AUooBmh+4FtClImkRMTf5U2AxKRIxpWEvJXdo6Ad4EKOCjyEZuscejUho30aPMJq0jRyQ==
X-Received: by 2002:aca:5903:0:b0:2d4:f329:67f9 with SMTP id n3-20020aca5903000000b002d4f32967f9mr496367oib.284.1645479530544;
        Mon, 21 Feb 2022 13:38:50 -0800 (PST)
Received: from [192.168.1.128] ([71.205.29.0])
        by smtp.gmail.com with ESMTPSA id w16sm5390764ooq.8.2022.02.21.13.38.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Feb 2022 13:38:50 -0800 (PST)
Subject: Re: [PATCH 5.4 00/80] 5.4.181-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     stable@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
        jonathanh@nvidia.com, f.fainelli@gmail.com,
        sudipm.mukherjee@gmail.com, slade@sladewatkins.com,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20220221084915.554151737@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <ef8e606f-4466-585e-8c05-6a27d7544a7b@linuxfoundation.org>
Date:   Mon, 21 Feb 2022 14:38:49 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20220221084915.554151737@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/21/22 1:48 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.4.181 release.
> There are 80 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 23 Feb 2022 08:48:58 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.4.181-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.4.y
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
