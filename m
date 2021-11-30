Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8F374641B8
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 23:44:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345419AbhK3WrU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 17:47:20 -0500
Received: from mail-ot1-f43.google.com ([209.85.210.43]:40682 "EHLO
        mail-ot1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345332AbhK3WrC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 17:47:02 -0500
Received: by mail-ot1-f43.google.com with SMTP id v15-20020a9d604f000000b0056cdb373b82so32365560otj.7;
        Tue, 30 Nov 2021 14:43:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=bgNkZ9Km7uslGW9spgB64Ff0uwinA/sUJ4dW12Hx5NQ=;
        b=7zoMPYl4UsYVZuIdiuSm7NYTRxnoAoz/NRA6kHnoPzIf2eOIjKEwqmKIH9vcdS0NJL
         D/nE/lpVz/0cXzyEuMSpepnyak8Voz9wcjC98CXS0XG88XsKv7j9E0ajxAA1qxJ5wCw1
         fT93G4+mjN/qNE0Oa8LvUPPCAdhqyQ7W5KyFAWCQnA94PgCYgX7GCsHpUVbxpkipMDU3
         Hc7/6PosrS3vhFilA0pbtBnv+jJKiosGeFxBJ3m9miUC709XF7txUCAok8hmKG5F1Swp
         hYfL2+1Jlws5SGu1B7UXFBVHCW4MszsnAIGyDi89n4iKB4OX5ezYCB4zSxOiJySKxVM+
         jgCw==
X-Gm-Message-State: AOAM533zmPdHw7sNvm2oQO9ZfhAfJwYI1dkCLki2SRU0f5ir8wEVwB5l
        GvgoieBr1ncb5UT767yFmQ==
X-Google-Smtp-Source: ABdhPJzzNxeCz/g28KThw4laZ7VZ4CBNkktlUh1TUdViKWztFqJrvQFOHaXnbD/wHUUc+yOXcVd/+Q==
X-Received: by 2002:a9d:364b:: with SMTP id w69mr2131689otb.18.1638312212779;
        Tue, 30 Nov 2021 14:43:32 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id g1sm2943995ooq.2.2021.11.30.14.43.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Nov 2021 14:43:31 -0800 (PST)
Received: (nullmailer pid 3146302 invoked by uid 1000);
        Tue, 30 Nov 2021 22:43:31 -0000
Date:   Tue, 30 Nov 2021 16:43:31 -0600
From:   Rob Herring <robh@kernel.org>
To:     Calvin Zhang <calvinzhang.cool@gmail.com>
Cc:     Frank Rowand <frowand.list@gmail.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] of: unmap memory regions in /memreserve node
Message-ID: <YaapE8oys5zQEdD5@robh.at.kernel.org>
References: <20211124133347.3861391-1-calvinzhang.cool@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211124133347.3861391-1-calvinzhang.cool@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+linuxppc-dev

On Wed, Nov 24, 2021 at 09:33:47PM +0800, Calvin Zhang wrote:
> Reserved memory regions in /memreserve node aren't and shouldn't
> be referenced elsewhere. So mark them no-map to skip direct mapping
> for them.

I suspect this has a high chance of breaking some platform. There's no 
rule a region can't be accessed.

> 
> Signed-off-by: Calvin Zhang <calvinzhang.cool@gmail.com>
> ---
>  drivers/of/fdt.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
> index bdca35284ceb..9e88cc8445f6 100644
> --- a/drivers/of/fdt.c
> +++ b/drivers/of/fdt.c
> @@ -638,7 +638,7 @@ void __init early_init_fdt_scan_reserved_mem(void)
>  		fdt_get_mem_rsv(initial_boot_params, n, &base, &size);
>  		if (!size)
>  			break;
> -		early_init_dt_reserve_memory_arch(base, size, false);
> +		early_init_dt_reserve_memory_arch(base, size, true);
>  	}
>  
>  	fdt_scan_reserved_mem();
> -- 
> 2.30.2
> 
> 
