Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 268AB465F9C
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 09:38:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345544AbhLBImD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Dec 2021 03:42:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230054AbhLBImC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Dec 2021 03:42:02 -0500
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4532CC061574
        for <linux-kernel@vger.kernel.org>; Thu,  2 Dec 2021 00:38:40 -0800 (PST)
Received: by mail-lf1-x130.google.com with SMTP id c32so69767320lfv.4
        for <linux-kernel@vger.kernel.org>; Thu, 02 Dec 2021 00:38:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=gzuYTHikBe26I+lZwL81eSuxVz26qz/YlIXM31Ln6EI=;
        b=Lgus0m/stliOjA3sXKPX3rz6SfPPwsbK9f3zkWF7l2U001fYRg2xWti2N18mQOyk6u
         R4nm0u6YyQlcxj8rotcePby74gjzAPhBXfnZTr3tOkg/RUJuWAJMOpFhu8rNL/i7M4jK
         aSp+ETEdAYIk9LX6W5WeiryQPnPKBXMqIJww8PR8dANL6Vg3wEopLJwTAt4CUniDwuyq
         ihfSBzj3dJkwzLV2r+8efgFkzbK1YKA/ei1vvL2NBDrMPPRgGCAAesdEnU6s9vhS+Y0A
         ximJxMG1hfRIRoUpwQHiG1ZOZ0oYKjQWs94zVeSvvIwE7FequCP+m5M9oqCHAqGdE0Hb
         GMbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=gzuYTHikBe26I+lZwL81eSuxVz26qz/YlIXM31Ln6EI=;
        b=C/azBcZfDBTJ1oVtalg3gFOMHbCCLS+eRYXeamU38riVU5h+V0Rm15B0bDn9SMuzFj
         JBsVnb8IqBXL2sUqNcDvQFSZfPVeqSlUnJD/+VLd4pVQyQxBISiBVO11BpvNqf7uM+0M
         ceBXcOt2TszohUDTeBPgzBhTMJoOEuRiMiT4M97VpB3D6mnQ7k4m8l4j7bCNaUvVWf4C
         HXBWhTCa+JLo017+ZJqtnSGKZQtO/CAIEb7v9IwkdlZd99nk4nPnwOQrG49ubZRBJvWY
         MTMDLVeTC18eMP4/0vyczwHMohSWjl9K8EjiSRJ/lopcMr+342bJm5BQEgbeBB50yh+c
         7w7Q==
X-Gm-Message-State: AOAM531kATvp7cxFOy1yma9rQdqvT3iJ3m5aGTtSrhqkqyAv+Zr783GB
        jABRKex9vJ+YyN721LNr7DuBHFMkCv0VQA==
X-Google-Smtp-Source: ABdhPJyr8Plxv0vgsC3vzC/FNnMnMOxWWH+gB39YilTAybkuEcGavqE69DGb/gQVFQesy1jnlfu2FQ==
X-Received: by 2002:a05:6512:239d:: with SMTP id c29mr11229926lfv.454.1638434318432;
        Thu, 02 Dec 2021 00:38:38 -0800 (PST)
Received: from [192.168.1.11] ([94.103.229.236])
        by smtp.gmail.com with ESMTPSA id l16sm291157lfg.90.2021.12.02.00.38.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Dec 2021 00:38:37 -0800 (PST)
Message-ID: <2f238cca-e609-f98c-41cd-6eb19adffbd8@gmail.com>
Date:   Thu, 2 Dec 2021 11:38:35 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH -next v4 0/3] some fix and cleanup for rtl8192e
Content-Language: en-US
To:     Yang Yingliang <yangyingliang@huawei.com>,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev
Cc:     gregkh@linuxfoundation.org, dan.carpenter@oracle.com
References: <20211202030704.2425621-1-yangyingliang@huawei.com>
From:   Pavel Skripkin <paskripkin@gmail.com>
In-Reply-To: <20211202030704.2425621-1-yangyingliang@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/2/21 06:07, Yang Yingliang wrote:
> v4: Fix crypt_info leak. Add fix tags for patch #1 and #2.
> v3: Fix more leaks.  Break it up into multple patches.
> v2: Make rtllib_softmac_init() return error codes.
> 
> patch #1, #2:
>    fix error handle case in alloc_rtllib()
> 
> patch #3:
>    remove unnecessary assignment
> 
> Yang Yingliang (3):
>    staging: rtl8192e: return error code from rtllib_softmac_init()
>    staging: rtl8192e: rtllib_module: fix error handle case in
>      alloc_rtllib()
>    staging: rtl8192e: rtllib_module: remove unnecessary assignment
> 
>   drivers/staging/rtl8192e/rtllib.h         |  2 +-
>   drivers/staging/rtl8192e/rtllib_module.c  | 17 ++++++++++++-----
>   drivers/staging/rtl8192e/rtllib_softmac.c |  6 ++++--
>   3 files changed, 17 insertions(+), 8 deletions(-)
> 

Thank you!

Reviewed-by: Pavel Skripkin <paskripkin@gmail.com>



With regards,
Pavel Skripkin
