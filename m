Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A25A4CEFCC
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 03:52:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234866AbiCGCx2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Mar 2022 21:53:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231821AbiCGCxZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Mar 2022 21:53:25 -0500
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35A7B633E
        for <linux-kernel@vger.kernel.org>; Sun,  6 Mar 2022 18:52:30 -0800 (PST)
Received: by mail-pf1-x443.google.com with SMTP id g1so12545493pfv.1
        for <linux-kernel@vger.kernel.org>; Sun, 06 Mar 2022 18:52:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=Ke3d+rcxPqYaHipRSyN8yz8qMw+s7G4gf9p9GSWU0jA=;
        b=ehd1auyNauHQc0rQhmzW8q7qh6pZOJsbjKfg3IPqyyjqx8C9vZnGUmBhM/DQ2q+tcU
         DldtGmTqhNJ5fPdK2zz80IHgowfZxrPU8a6t3VK6dmZoGisoa7yegGLPb2PArx9DpIJS
         tL0BMaR8McbckQ2izeZ3q8a9S151TPGcAKZr6d8VxdwKhK7zd4oIriuug9Yzqo8vGz2L
         80XfS0UxIpOdqEEI/Se1dPjUMAnGKViT56g/qGAyUFgl2m5Q9Sv4s1d7/6ByQskaKxN+
         Jguex9GpdWNls6Pu0W2EfrNERq4h5iTUNGzfUmyj3/CPsDHXJ8rBVc8ERe2BlAY6iJk9
         ANfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Ke3d+rcxPqYaHipRSyN8yz8qMw+s7G4gf9p9GSWU0jA=;
        b=u+qHa9uYFYqPpO7r/OQHXKCILpM8VGl0oqGrEyQrS/BWmXmwR9GcNHm0ZUv4SGSVN+
         xoU/NkjWXja6zkia6GFj9Kcq5rhUKrRRg1e7qq01K+ahNxfS+iz1UmkVmR2+XcRuXyZF
         /C/AI8+KgPSAQpi+VfNKxNwcV9oYQrYtTtF0+3TzvOc6X2zdOuwpwgvKIMuFG38WZKS6
         r2+tUbcwWtOH0OZTvMz8+9cHWixKCvRohgsMwBbWWzFsAPwRVkQrU8R310a16vPU3PO0
         TQ1DCqbPaVSR1DOGQXPjk9thh3PTo0JhK/hSBKqEA9AvywX/jVcumvpcEPUcRkMLxVr2
         JUZA==
X-Gm-Message-State: AOAM530yXmTDGirABXfU4SpjZu+sRn6bwsfE3ZwJz4co3KYS+9qy45WJ
        eMbjJcf0yLH1ddexbJzipsotevqtAsw8gg==
X-Google-Smtp-Source: ABdhPJw3sxr6LJUr9bSYxUY5oJICYTMxsi1JzMcM6eYWmFK1guMpEsTSDqHwJJ9OX7nMKYoyzwNpvg==
X-Received: by 2002:a63:5124:0:b0:375:9f87:f881 with SMTP id f36-20020a635124000000b003759f87f881mr7871229pgb.578.1646621549707;
        Sun, 06 Mar 2022 18:52:29 -0800 (PST)
Received: from [10.11.37.162] ([103.84.139.53])
        by smtp.gmail.com with ESMTPSA id g15-20020a056a0023cf00b004e17e11cb17sm14109144pfc.111.2022.03.06.18.52.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 06 Mar 2022 18:52:29 -0800 (PST)
Message-ID: <a044e19d-4996-ab16-785f-e8e87e6c05a8@gmail.com>
Date:   Mon, 7 Mar 2022 10:52:25 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v2] powerpc: kernel: fix refcount leak in format_show()
Content-Language: en-US
To:     mpe@ellerman.id.au, benh@kernel.crashing.org, paulus@samba.org,
        tyreld@linux.ibm.com
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
References: <20220302021959.10959-1-hbh25y@gmail.com>
From:   Hangyu Hua <hbh25y@gmail.com>
In-Reply-To: <20220302021959.10959-1-hbh25y@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Any further suggestions for this patch? guys.

Thanks.

On 2022/3/2 10:19, Hangyu Hua wrote:
> Refcount leak will happen when format_show returns failure in multiple
> cases. Unified management of of_node_put can fix this problem.
> 
> Signed-off-by: Hangyu Hua <hbh25y@gmail.com>
> ---
> 
> v2:
> 1. change the title and description information.
> 2. fix all possible refcount leak.
> 
>   arch/powerpc/kernel/secvar-sysfs.c | 9 ++++++---
>   1 file changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/powerpc/kernel/secvar-sysfs.c b/arch/powerpc/kernel/secvar-sysfs.c
> index a0a78aba2083..1ee4640a2641 100644
> --- a/arch/powerpc/kernel/secvar-sysfs.c
> +++ b/arch/powerpc/kernel/secvar-sysfs.c
> @@ -26,15 +26,18 @@ static ssize_t format_show(struct kobject *kobj, struct kobj_attribute *attr,
>   	const char *format;
>   
>   	node = of_find_compatible_node(NULL, NULL, "ibm,secvar-backend");
> -	if (!of_device_is_available(node))
> -		return -ENODEV;
> +	if (!of_device_is_available(node)) {
> +		rc = -ENODEV;
> +		goto out;
> +	}
>   
>   	rc = of_property_read_string(node, "format", &format);
>   	if (rc)
> -		return rc;
> +		goto out;
>   
>   	rc = sprintf(buf, "%s\n", format);
>   
> +out:
>   	of_node_put(node);
>   
>   	return rc;
