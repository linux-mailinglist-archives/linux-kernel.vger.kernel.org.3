Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 636A74B144B
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 18:33:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242643AbiBJRds (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 12:33:48 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:44332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233508AbiBJRdr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 12:33:47 -0500
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com [IPv6:2607:f8b0:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 154FEE70;
        Thu, 10 Feb 2022 09:33:48 -0800 (PST)
Received: by mail-oi1-x230.google.com with SMTP id y23so6643215oia.13;
        Thu, 10 Feb 2022 09:33:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:message-id:date:mime-version:user-agent:content-language:to
         :cc:references:from:subject:in-reply-to:content-transfer-encoding;
        bh=KMEH/WwrMTO8SB+tWGZXeyDvufP5xxavynCuOn8K7Ys=;
        b=YCEqlJ+9TYFApFkJLrmIOSZzCOc29d8N5EvQNRs74d9k7HElCLmo1jcQmtStV20ZkL
         J7U27fObb1bsFJOzpnDwlrZRslvVGC3uJnXjXEgfZJBsINnPYN+8UFN4yX9vFYs/VdNd
         0Bd2tLD8U7nesctTXfqxt1oJBXWLRuSJRcLrLFa3gAwjVxGKfyJNruVaA5cjMC1pwymc
         zdqlu4J1rA/3pThJF7SMIltlMWvX1M/+7zVqWMO/pPlD0aRVB7RqPAOiPWVfCwLDXOwu
         bx4UzEQgfX97XclsS96JfSu0KaVT4s5w67I3UMN8aswJyETNzXDVt7SEWlcTuJapnAw1
         wsUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:message-id:date:mime-version:user-agent
         :content-language:to:cc:references:from:subject:in-reply-to
         :content-transfer-encoding;
        bh=KMEH/WwrMTO8SB+tWGZXeyDvufP5xxavynCuOn8K7Ys=;
        b=TB8w/S4/7OqY/GAqLMGNgxD+eH3Uc5Nt0pkZ4CKFv5bUmCAV4sJvBYP3eMoxbgH6v2
         9V2mmqQYeMbkg77AJOfzzMqVANgO4XJAcCGDWf6ozfvuZOsp+XOyMWVp3N9qeigzqKO0
         /OCzAN26+50KqwwBJg15BtBnhpVe+cabsHF+9A7X6iLRWAMrb0X5b3TWiCsDP1m8y1UO
         V48mLWZAn2QGo4+Aq/RWjwgUts+dtUSDkchkYoufqWGW/TK1yrcXvtyggV9C/sy2PwkH
         9RMnb1S3fIS0+g+9ljzkWyDt046aIt/V+N/ist2XqYVwaHqIP+WnlYAD7lyYUMESJmjR
         oy4w==
X-Gm-Message-State: AOAM531VoNrfsenI9fCn/SY2yG768hWQeBB7cU4h1pr/MsOj6IjdUxkm
        Van9oHsZHohs/7Yq0bjpXRYs1QzS5FDw4A==
X-Google-Smtp-Source: ABdhPJyCMmnHC2t+9dIbQSBDeDn+YlRHt7bFTkL5b4YJ6Zjfx2oSqYlxbRcoL39ZAvj10ocxKRgYLg==
X-Received: by 2002:a05:6808:1415:: with SMTP id w21mr1575387oiv.170.1644514427409;
        Thu, 10 Feb 2022 09:33:47 -0800 (PST)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id s3sm8116049otg.67.2022.02.10.09.33.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Feb 2022 09:33:46 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <af550a8a-9fd8-9292-4179-4d7b74fdacfc@roeck-us.net>
Date:   Thu, 10 Feb 2022 09:33:45 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Content-Language: en-US
To:     Lee Jones <lee.jones@linaro.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Alistair Francis <alistair@alistair23.me>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
References: <20220210185123.4d39766c@canb.auug.org.au>
 <YgTRu7iLgJMymeT5@google.com>
From:   Guenter Roeck <linux@roeck-us.net>
Subject: Re: linux-next: build warning after merge of the hwmon-staging tree
In-Reply-To: <YgTRu7iLgJMymeT5@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Lee,

On 2/10/22 00:50, Lee Jones wrote:
> On Thu, 10 Feb 2022, Stephen Rothwell wrote:
> 
>> Hi all,
>>
>> After merging the hwmon-staging tree, today's linux-next build (htmldocs)
>> produced this warning:
>>
>> Documentation/hwmon/sy7636a-hwmon.rst:4: WARNING: Title underline too short.
>>
>> Kernel driver sy7636a-hwmon
>> =========================
>>
>> Introduced by commit
>>
>>    de34a4053250 ("hwmon: sy7636a: Add temperature driver for sy7636a")
> 
> Oh wow, that's new (to me), and a little petty, no?
> 
> Would you like me to apply this patch to my branch Guenter?
> 

It would be great if you can do that since you already wrote it.

> I can either send out a new PR, or let it wallow.
> 
Wallow is fine with me; that can go in through your branch.

Actually, I wonder if I should just drop your immutable branch from
my tree and let it go in through your tree. The hwmon patch has my Acked-by:
already, and there are no further dependencies, so it isn't really necessary
for both of us to carry it. What do you think ?

Thanks,
Guenter

> -------- 8< --------
> 
> From: Lee Jones <lee.jones@linaro.org>
> 
>   Documentation/hwmon/sy7636a-hwmon.rst:4: WARNING: Title underline too short.
> 
>   Kernel driver sy7636a-hwmon
>   =========================
> 
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
> ---
>   Documentation/hwmon/sy7636a-hwmon.rst | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/hwmon/sy7636a-hwmon.rst b/Documentation/hwmon/sy7636a-hwmon.rst
> index 5612079397d52..c85db7b329415 100644
> --- a/Documentation/hwmon/sy7636a-hwmon.rst
> +++ b/Documentation/hwmon/sy7636a-hwmon.rst
> @@ -1,7 +1,7 @@
>   .. SPDX-License-Identifier: GPL-2.0-or-later
>   
>   Kernel driver sy7636a-hwmon
> -=========================
> +===========================
>   
>   Supported chips:
>   

