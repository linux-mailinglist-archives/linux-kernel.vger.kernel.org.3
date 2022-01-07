Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1595487F65
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jan 2022 00:32:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231545AbiAGXcX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jan 2022 18:32:23 -0500
Received: from mail-ot1-f51.google.com ([209.85.210.51]:38862 "EHLO
        mail-ot1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231465AbiAGXcW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jan 2022 18:32:22 -0500
Received: by mail-ot1-f51.google.com with SMTP id r7-20020a05683001c700b005906f5b0969so8280269ota.5;
        Fri, 07 Jan 2022 15:32:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=R3ENkgab0e+SbdBFwrmJdaPjCH96xjKxzUurbk8Ebuc=;
        b=F25JiNa5e5kXbBaWw5IIM84481zGRaBm65SRLIuNu16BwnHOTnh4jBhq1jq8gTg+rF
         cd0Z0ataHBWIX/Zmc+5ylvTxJQvPFxZEKp+4Q2P5Ce3S0Yi/v7H+8W99K7oMiYRrYiJT
         IWVxuQbTH0+UXrtrXLzgX/Vz2diXZJC0ZJygIROSH5paRTTTClZ1bdg1k2ySJq76B7Yl
         tS9dEV0BW/hEW1pfrgrGGDYtQ8O9acxEUAyQr/sKdQYirqn6JXTKRZKp/r7v15T8cfbN
         C0r+rMKUvhhSUYNegIjC07FcnqBMSvtfaMEhuFQPRB9YQq993RXqGiGUviL0yDATevir
         nrrA==
X-Gm-Message-State: AOAM530KsloJRbw8PTp2kO00tgOBkYaGtSHqNtczefQT3kVBGiVWCRZS
        vGZnOyT+3EFGN1/zzigJQw==
X-Google-Smtp-Source: ABdhPJzw5D6DhWLfA91rZQrCqQmdnXJDFDoWEkx7U43DnC2SwAL28W6/9qzugOjavPvwuX64myseUQ==
X-Received: by 2002:a9d:6351:: with SMTP id y17mr46724234otk.105.1641598341642;
        Fri, 07 Jan 2022 15:32:21 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id t26sm21410oic.51.2022.01.07.15.32.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jan 2022 15:32:21 -0800 (PST)
Received: (nullmailer pid 4142582 invoked by uid 1000);
        Fri, 07 Jan 2022 23:32:20 -0000
Date:   Fri, 7 Jan 2022 17:32:20 -0600
From:   Rob Herring <robh@kernel.org>
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     devicetree@vger.kernel.org, Quentin Perret <qperret@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Jan Kiszka <jan.kiszka@siemens.com>,
        linux-kernel@vger.kernel.org,
        Nicolas Boichat <drinkcat@chromium.org>,
        Mike Rapoport <rppt@kernel.org>,
        Douglas Anderson <dianders@chromium.org>
Subject: Re: [PATCH v4] of/fdt: Don't worry about non-memory region overlap
 for no-map
Message-ID: <YdjNhIs9/GH3YJ0P@robh.at.kernel.org>
References: <20220107194233.2793146-1-swboyd@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220107194233.2793146-1-swboyd@chromium.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 07 Jan 2022 11:42:32 -0800, Stephen Boyd wrote:
> In commit 8a5a75e5e9e5 ("of/fdt: Make sure no-map does not remove
> already reserved regions") we returned -EBUSY when trying to mark
> regions as no-map when they intersect with reserved memory. The goal was
> to find bad no-map reserved memory DT nodes that would unmap the kernel
> text/data sections.
> 
> The problem is the reserved memory check will still trigger if the DT
> has a /memreserve/ that completely subsumes the no-map memory carveouts
> in the reserved memory node _and_ that region is also not part of the
> memory reg property. For example in sc7180.dtsi we have the following
> reserved-memory and memory node:
> 
>       memory@80000000 {
>           /* We expect the bootloader to fill in the size */
>           reg = <0 0x80000000 0 0>;
>       };
> 
>       smem_mem: memory@80900000 {
>               reg = <0x0 0x80900000 0x0 0x200000>;
>               no-map;
>       };
> 
> and the memreserve filled in by the bootloader is
> 
>       /memreserve/ 0x80800000 0x400000;
> 
> while the /memory node is transformed into
> 
>       memory@80000000 {
>           /* The bootloader fills in the size, and adds another region */
>           reg = <0 0x80000000 0 0x00800000>,
>                 <0 0x80c00000 0 0x7f200000>;
>       };
> 
> The smem region is doubly reserved via /memreserve/ and by not being
> part of the /memory reg property. This leads to the following warning
> printed at boot.
> 
>  OF: fdt: Reserved memory: failed to reserve memory for node 'memory@80900000': base 0x0000000080900000, size 2 MiB
> 
> Otherwise nothing really goes wrong because the smem region is not going
> to be mapped by the kernel's direct linear mapping given that it isn't
> part of the memory node. Therefore, let's only consider this to be a
> problem if we're trying to mark a region as no-map and it is actually
> memory that we're intending to keep out of the kernel's direct mapping
> but it's already been reserved.
> 
> Acked-by: Mike Rapoport <rppt@kernel.org>
> Cc: Douglas Anderson <dianders@chromium.org>
> Cc: Nicolas Boichat <drinkcat@chromium.org>
> Cc: Quentin Perret <qperret@google.com>
> Cc: Jan Kiszka <jan.kiszka@siemens.com>
> Fixes: 8a5a75e5e9e5 ("of/fdt: Make sure no-map does not remove already reserved regions")
> Signed-off-by: Stephen Boyd <swboyd@chromium.org>
> ---
> 
> Changes from v3 (https://lore.kernel.org/r/20211215195354.634746-1-swboyd@chromium.org):
>  * Even more details in commit text
> 
> Changes from v2 (https://lore.kernel.org/r/20211215072011.496998-1-swboyd@chromium.org):
>  * More details in commit text
> 
> Changes from v1 (https://lore.kernel.org/r/20210520012731.3731314-1-swboyd@chromium.org):
>  * Use memblock_overlaps_region instead of memblock_is_region_memory()
>  * Add more details to commit text
> 
>  drivers/of/fdt.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 

Applied, thanks!
