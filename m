Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14A4C523318
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 14:27:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237797AbiEKM1m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 08:27:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233215AbiEKM1j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 08:27:39 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 20A835B3E7
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 05:27:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1652272058;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hUCEDpMcELwjroIKSRZI8OB/5UA+ogwez3KA5XNPQjQ=;
        b=Uv0jQgSBBYzYTD9fivkBz3+wvabC4ZvBqKCobTMgArmk0XBI/wE04iRrGcPdfs5B4EZbW2
        bH6JldM77k0AoZEWqRfV1H6jU2ZmJBDOGuz9U1Vk7ca/cyMk5HCtoE8YhhpI+bI3a6iEkL
        6w/BOxKflUPwdv+FCPG097RLzAaCzlY=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-542-z0tXYCCFO3SyQJ1AgNzBzg-1; Wed, 11 May 2022 08:27:37 -0400
X-MC-Unique: z0tXYCCFO3SyQJ1AgNzBzg-1
Received: by mail-wm1-f72.google.com with SMTP id v124-20020a1cac82000000b003948b870a8dso2773590wme.2
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 05:27:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=hUCEDpMcELwjroIKSRZI8OB/5UA+ogwez3KA5XNPQjQ=;
        b=vKUH0eej0DCVpvrb5n/tp+DTKXGpGPglNDXM6Nf3UNubSUiQih2BxNvifGct0L8x9D
         l9G2PCF6CraRwTeP7olYoKzXgt68/PkSNFMLgOcKH+ZTpXR4vbdTGK0LqjF1HAmE0EhX
         5QXqUR7AXhcwas8YeXtmz+62sL0b4yGXFLVAFjkCYNsSxGJZjUF9G0rpzj0RtuIkRcv3
         +ufuRXUHcnrxEP9qcjUrQAQeqM9hd3LH7o4/Ot3eVphEdxQDo6oUNOrWHC83sYKfF1lZ
         zq7I628SAZ91LH1Uadnh3sQaO7fBszLts1tIXmFRjDwqPiguwq2/HcmOUkQiBwCSm8/t
         nJ3Q==
X-Gm-Message-State: AOAM533q2bmdKd7IGGa0xazb3XGgDE7KYghJ72ieKxbfKqj/DOStaZDW
        32YNKEauhtTqjYemiHHBLHvk9kitgy7KzzJWDhy7sdLGK7ovMurxAsjbwvPOFpKtEOl5QYzmdYt
        cfj//7072cIiis7NkqC3JozED
X-Received: by 2002:adf:f809:0:b0:20a:c40d:ae9a with SMTP id s9-20020adff809000000b0020ac40dae9amr22633087wrp.609.1652272055888;
        Wed, 11 May 2022 05:27:35 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx4vhxqnTmWHdFk3+Z1Bppcfdj6GdhkeCnzL/pWI2XiCnosbdMq+/Y1YjqIsk754DQqSlF42g==
X-Received: by 2002:adf:f809:0:b0:20a:c40d:ae9a with SMTP id s9-20020adff809000000b0020ac40dae9amr22633063wrp.609.1652272055618;
        Wed, 11 May 2022 05:27:35 -0700 (PDT)
Received: from ?IPV6:2003:cb:c701:700:2393:b0f4:ef08:bd51? (p200300cbc70107002393b0f4ef08bd51.dip0.t-ipconnect.de. [2003:cb:c701:700:2393:b0f4:ef08:bd51])
        by smtp.gmail.com with ESMTPSA id u10-20020a5d6aca000000b0020c5253d925sm1534898wrw.113.2022.05.11.05.27.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 May 2022 05:27:35 -0700 (PDT)
Message-ID: <4407c84b-a64f-51b0-fa96-388aaf3b3e35@redhat.com>
Date:   Wed, 11 May 2022 14:27:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH] RISC-V: Remove IORESOURCE_BUSY flag for no-map reserved
 memory
Content-Language: en-US
To:     Xianting Tian <xianting.tian@linux.alibaba.com>,
        paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, akpm@linux-foundation.org,
        anup@brainfault.org, wangkefeng.wang@huawei.com, rppt@kernel.org,
        alex@ghiti.fr, twd2.me@gmail.com, seanjc@google.com,
        petr.pavlu@suse.com, atishp@rivosinc.com
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        guoren@kernel.org, jianghuaming.jhm@alibaba-inc.com,
        Nick Kossifidis <mick@ics.forth.gr>
References: <20220511112413.559734-1-xianting.tian@linux.alibaba.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20220511112413.559734-1-xianting.tian@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11.05.22 13:24, Xianting Tian wrote:
> Commit 00ab027a3b82 ("RISC-V: Add kernel image sections to the resource tree")
> added IORESOURCE_BUSY flag for no-map reserved memory, this casued
> devm_ioremap_resource() failed for the no-map reserved memory in subsequent
> operations of related driver, so remove the IORESOURCE_BUSY flag.
> 
> The code to reproduce the issue,
> dts:
> 	mem0: memory@a0000000 {
>                 reg = <0x0 0xa0000000 0 0x1000000>;
>                 no-map;
>         };
> 
> 	&test {
> 		status = "okay";
> 		memory-region = <&mem0>;
> 	};
> 
> code:
> 	np = of_parse_phandle(pdev->dev.of_node, "memory-region", 0);
> 	ret = of_address_to_resource(np, 0, &r);
> 	base = devm_ioremap_resource(&pdev->dev, &r);
> 	// base = -EBUSY
> 
> Fixes: 00ab027a3b82 ("RISC-V: Add kernel image sections to the resource tree")
> Reported-by: Huaming Jiang <jianghuaming.jhm@alibaba-inc.com>
> Reviewed-by: Guo Ren <guoren@kernel.org>
> CC: Nick Kossifidis <mick@ics.forth.gr>
> Signed-off-by: Xianting Tian <xianting.tian@linux.alibaba.com>
> ---
>  arch/riscv/kernel/setup.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/riscv/kernel/setup.c b/arch/riscv/kernel/setup.c
> index 834eb652a7b9..71f2966b1474 100644
> --- a/arch/riscv/kernel/setup.c
> +++ b/arch/riscv/kernel/setup.c
> @@ -214,7 +214,7 @@ static void __init init_resources(void)
>  
>  		if (unlikely(memblock_is_nomap(region))) {
>  			res->name = "Reserved";
> -			res->flags = IORESOURCE_MEM | IORESOURCE_BUSY;
> +			res->flags = IORESOURCE_MEM;
>  		} else {
>  			res->name = "System RAM";
>  			res->flags = IORESOURCE_SYSTEM_RAM | IORESOURCE_BUSY;

I assume the "Reserved" part is essentially unused by the kernel correct?

-- 
Thanks,

David / dhildenb

