Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 143E153E96E
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 19:08:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241535AbiFFQSI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 12:18:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241512AbiFFQSE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 12:18:04 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8C1F1AF6FF
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jun 2022 09:17:59 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id d14so11527076wra.10
        for <linux-kernel@vger.kernel.org>; Mon, 06 Jun 2022 09:17:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=RaQhq4KYkeTpBP9+9/YIEr0G6PjvF+TDJNb+GzMN8pE=;
        b=HCzloWuy8I0Pmkrc7dz8TytjmK6UWi8puFvzfUR+KM+5a651GzRP7FiAcVbTbXc5aF
         RpSyHIBoUAGSSTyLU1+2UgnXIGQ3x2Ml+503h9bYVrx10KgYl/iVV1rIvGsH8yz4fMrW
         THxdwFoza4sqeOLwiNooiNIHwvyWq++PCiYnhvUEsxQp5wyUKi3onG8GkasksmAj6W91
         T3dcgZOBFYHLdWRP3bupBiooLri+byrfeV7Qpi+zmlI+Bqps8LbOk5k+rrYQk6R7ObDI
         yohDP+sRBKbbIFKO51mIv+NPs8E47vrNQey39aELE8uZoBYAOvtLXVa2kdC3jzl57ldc
         DTIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=RaQhq4KYkeTpBP9+9/YIEr0G6PjvF+TDJNb+GzMN8pE=;
        b=QXvKt37krWFBkkrxxV1rWn8Uz3+aP9TLZOH9TYfVekW6gwUfdMiGdXyLZftZREIBcd
         2w32LdCW5LrOWQ6TLlbpHaFouPer5/M3Jd2dXfviu1sLHU0VF6TfgdVoK8FX1GZkWMRO
         ql2l2uVa2RBlRNq5a8SsROX4P9gnk/q3RZ1gSIGC08tpMLitDAbpAyx+a1VpeUFzj5QD
         kK0qpxGXwuwaLnDmkBpNyx1Q1xyEEO9A78Laf1Qf4MEcfug3iL6zxIG63XTCvZRo1qO2
         XrP8qSRO8YMmqwf4m+XmugguRRc7+tktR7+cnas52iXmDkyM5s4esfLhuNDzcqE5C7sY
         wnKg==
X-Gm-Message-State: AOAM532oYgTc66ZJy5w/vSZew4CGnsXF7z6dqLA7c0cBe5Y0uREbZqH+
        pCzQ6ZNNfZSnRonSdaQJrBfam0ZLJrI=
X-Google-Smtp-Source: ABdhPJyubms71mI0yq0O8eaFjibbBPQLqWwuuEbqo88skGsbrd3DUTneQb2KakphwFPQ3zQZUIvfJg==
X-Received: by 2002:adf:a3d3:0:b0:213:baff:7654 with SMTP id m19-20020adfa3d3000000b00213baff7654mr17611749wrb.158.1654532277594;
        Mon, 06 Jun 2022 09:17:57 -0700 (PDT)
Received: from [192.168.1.7] ([212.22.223.21])
        by smtp.gmail.com with ESMTPSA id l9-20020a7bc349000000b0039746638d6esm17590755wmj.33.2022.06.06.09.17.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Jun 2022 09:17:57 -0700 (PDT)
Subject: Re: [PATCH] xen: unexport __init-annotated
 xen_xlate_map_ballooned_pages()
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
        moderated for non-subscribers <xen-devel@lists.xenproject.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Julien Grall <julien.grall@arm.com>,
        Shannon Zhao <shannon.zhao@linaro.org>,
        linux-kernel@vger.kernel.org
References: <20220606045920.4161881-1-masahiroy@kernel.org>
From:   Oleksandr <olekstysh@gmail.com>
Message-ID: <20c9cd23-429f-896c-b59b-c518ff2562e2@gmail.com>
Date:   Mon, 6 Jun 2022 19:17:56 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20220606045920.4161881-1-masahiroy@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 06.06.22 07:59, Masahiro Yamada wrote:

Hello

> EXPORT_SYMBOL and __init is a bad combination because the .init.text
> section is freed up after the initialization. Hence, modules cannot
> use symbols annotated __init. The access to a freed symbol may end up
> with kernel panic.
>
> modpost used to detect it, but it has been broken for a decade.
>
> Recently, I fixed modpost so it started to warn it again, then this
> showed up in linux-next builds.
>
> There are two ways to fix it:
>
>    - Remove __init
>    - Remove EXPORT_SYMBOL
>
> I chose the latter for this case because none of the in-tree call-sites
> (arch/arm/xen/enlighten.c, arch/x86/xen/grant-table.c) is compiled as
> modular.

Good description.


>
> Fixes: 243848fc018c ("xen/grant-table: Move xlated_setup_gnttab_pages to common place")
> Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>

I think the patch is correct.

Reviewed-by: Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>

> ---
>
>   drivers/xen/xlate_mmu.c | 1 -
>   1 file changed, 1 deletion(-)
>
> diff --git a/drivers/xen/xlate_mmu.c b/drivers/xen/xlate_mmu.c
> index 34742c6e189e..f17c4c03db30 100644
> --- a/drivers/xen/xlate_mmu.c
> +++ b/drivers/xen/xlate_mmu.c
> @@ -261,7 +261,6 @@ int __init xen_xlate_map_ballooned_pages(xen_pfn_t **gfns, void **virt,
>   
>   	return 0;
>   }
> -EXPORT_SYMBOL_GPL(xen_xlate_map_ballooned_pages);
>   
>   struct remap_pfn {
>   	struct mm_struct *mm;

-- 
Regards,

Oleksandr Tyshchenko

