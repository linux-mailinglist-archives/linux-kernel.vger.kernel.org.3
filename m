Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B50A646A5EF
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 20:47:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348660AbhLFTus (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 14:50:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245093AbhLFTuq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 14:50:46 -0500
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com [IPv6:2607:f8b0:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3ACFC061746;
        Mon,  6 Dec 2021 11:47:17 -0800 (PST)
Received: by mail-ot1-x32b.google.com with SMTP id n17-20020a9d64d1000000b00579cf677301so15022283otl.8;
        Mon, 06 Dec 2021 11:47:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ZjMX59TZl+IZdSPIF13WgBTxn1jh0xqEwJKqI52GXbs=;
        b=Zu+amLxtSQRw6oTxIou7Qt08C6PLYYSQBz0iDwv5xQQ9FRia/6bhtu+gtHE/zwt+jG
         K4jVHBy/aHDrbmkf46sjC8QvtVgzj2IcedhRmQ3RGbUhKOYt1GVA+tirQkpZSrE7inU6
         Jl4vQkr+xBwbt1r4i4lVxeqRQhWq/JuWu8DEGXqccQNC5NXpRP+3u1DbfMJBSyeRLMG0
         YYI+cqVagq8aXKoRqJz9v0zfGMiPUNyUroEFNnT3PBwBCNiwJrXhFDzUm7FF5R+0OTyg
         a9fzewNKP4pU1uoYzBbrsJmv1ytCyl0ONm9BU+M383RPAMZJf6pYR9scUYTE7kE47EZ7
         7WkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=ZjMX59TZl+IZdSPIF13WgBTxn1jh0xqEwJKqI52GXbs=;
        b=wHcc6wcfadubITn7JHx+NgLQ7RHdvjiUtJTsg0WglDPriKqxHGmNS4TdSIYGe8N+Tu
         rQqkljOXKearoF3nCMknFABR8uSgmo+e8w0eXzBdiklBBk//kBLYWnCRdj7WUSFibmtj
         GiC8FqZYHxAvoJvtiHRNDV9IbS8z1vM9Bhem63UamqXrGw+YCO9Tzm9imzvAWCR8TGN2
         XHByXiSMEjlKZ/omQsc/15013G7tVgtXRz9W3Phgz62uaS7dm7NJaRtUQJ8vcZKcsfAE
         hkNaFhX6J/ZZEnsbHcPDTne3jyJMyRZzWZbbZU3Sl6hSf5y2pXvh3TkGIZQeEI++nLMj
         C6Ow==
X-Gm-Message-State: AOAM532G3OcgOy9+96H7Mu+aO4IEXJGCf52YtJCpXrCt5jUrS11P91M+
        e/HctYKL0lb7IxBxFv/pUJI=
X-Google-Smtp-Source: ABdhPJz7gzlopL79PfntoWQuiNa+c1A/Yin3bo8Av4Xlda/EZ0dm8aohXFx8817kx7sZUnM7hrRi6A==
X-Received: by 2002:a05:6830:3155:: with SMTP id c21mr31066592ots.7.1638820037271;
        Mon, 06 Dec 2021 11:47:17 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id a16sm2363306otj.79.2021.12.06.11.47.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Dec 2021 11:47:16 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Mon, 6 Dec 2021 11:47:15 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Rob Herring <robh@kernel.org>
Cc:     Wim Van Sebroeck <wim@linux-watchdog.org>,
        Tero Kristo <t-kristo@ti.com>, devicetree@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>,
        linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: watchdog: ti,rti-wdt: Fix
 assigned-clock-parents
Message-ID: <20211206194715.GA3759192@roeck-us.net>
References: <20211206174028.2294330-1-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211206174028.2294330-1-robh@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 06, 2021 at 11:40:28AM -0600, Rob Herring wrote:
> With 'unevaluatedProperties' support implemented, the ti,rti-wdt example
> has the following warning:
> 
> /home/rob/proj/git/linux-dt/.build-arm64/Documentation/devicetree/bindings/watchdog/ti,rti-wdt.example.dt.yaml: watchdog@2200000: Unevaluated properties are not allowed ('assigned-clock-parents' was unexpected)
> 
> The problem is the schema has a typo in 'assigned-clocks-parents'. As
> it is not required to list assigned clocks in bindings, just drop the
> property definitions to fix this.
> 
> Cc: Wim Van Sebroeck <wim@linux-watchdog.org>
> Cc: Guenter Roeck <linux@roeck-us.net>
> Cc: Tero Kristo <t-kristo@ti.com>
> Cc: linux-watchdog@vger.kernel.org
> Signed-off-by: Rob Herring <robh@kernel.org>

Acked-by: Guenter Roeck <linux@roeck-us.net>

... assuming you want to carry this and the following patch through
your tree. If not, please let me know.

Thanks,
Guenter

> ---
>  Documentation/devicetree/bindings/watchdog/ti,rti-wdt.yaml | 6 ------
>  1 file changed, 6 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/watchdog/ti,rti-wdt.yaml b/Documentation/devicetree/bindings/watchdog/ti,rti-wdt.yaml
> index 054584d7543a..2f33635876ff 100644
> --- a/Documentation/devicetree/bindings/watchdog/ti,rti-wdt.yaml
> +++ b/Documentation/devicetree/bindings/watchdog/ti,rti-wdt.yaml
> @@ -34,12 +34,6 @@ properties:
>    power-domains:
>      maxItems: 1
>  
> -  assigned-clocks:
> -    maxItems: 1
> -
> -  assigned-clocks-parents:
> -    maxItems: 1
> -
>  required:
>    - compatible
>    - reg
> -- 
> 2.32.0
> 
