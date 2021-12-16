Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56164477ED1
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 22:29:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241506AbhLPV3c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 16:29:32 -0500
Received: from mail-ot1-f52.google.com ([209.85.210.52]:39455 "EHLO
        mail-ot1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236940AbhLPV3b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 16:29:31 -0500
Received: by mail-ot1-f52.google.com with SMTP id r10-20020a056830080a00b0055c8fd2cebdso478284ots.6;
        Thu, 16 Dec 2021 13:29:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=oClQu/XAnqP12EjWnF0/gb703c+sK8qST1QKHwTbW4w=;
        b=34cRb0MTdpc+FXolVUgIBoL3JpyJrhg5bd34Y24igGGJvZ4QwyW/ygksh54PYBsNTG
         1T97T6f/YEXLmkHVelzTB3KP7pLVcvmlQRXItfQEe05EvUIw0Kha+753PWKD+A4ef1hI
         RywPYvxJ3qALjMZhxgcJn5KeLQhQjyLSJWK1mN0LvuFMlwhOfI7LZlK++HCdSS4CYiea
         sbeAr2W/UH7wr0mGk+EAqaEGVuJGkum+bL9vWIpizEwTKjYshA+zBKaq3VMgjCA7bhtn
         ZegTbGIJSpJtvS8NIl0N6Wq3J/2Kov6BdmRxjteOmR6lb9rqPV60kWLeGlT7Stu1zLsd
         J6dA==
X-Gm-Message-State: AOAM5339kbCg+QzNjHK/Uq1F1Yfrbfzh3RESpXuP20UWKiihlgl4dMOM
        aX0dBIeJh7b0tNhmuEmgW6Aw3mpqNA==
X-Google-Smtp-Source: ABdhPJz4C9513V1E0wQz2hCoepwe2jn5kkYcmLFvK45y3aa3NlqqO99pTl57rYzU2cZpj/Gtj/biNQ==
X-Received: by 2002:a9d:6a15:: with SMTP id g21mr28980otn.221.1639690170984;
        Thu, 16 Dec 2021 13:29:30 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id g17sm1207408oiy.14.2021.12.16.13.29.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Dec 2021 13:29:30 -0800 (PST)
Received: (nullmailer pid 797576 invoked by uid 1000);
        Thu, 16 Dec 2021 21:29:29 -0000
Date:   Thu, 16 Dec 2021 15:29:29 -0600
From:   Rob Herring <robh@kernel.org>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     linux-riscv@lists.infradead.org,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Sagar Kadam <sagar.kadam@sifive.com>,
        Rob Herring <robh+dt@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Marc Zyngier <maz@kernel.org>
Subject: Re: [PATCH v2 1/2] dt-bindings: interrupt-controller: sifive,plic:
 Fix number of interrupts
Message-ID: <YbuvuVUx3xOhGf1A@robh.at.kernel.org>
References: <cover.1639661878.git.geert@linux-m68k.org>
 <41942eec41ccdf9831648c600d149af5e5f652a2.1639661878.git.geert@linux-m68k.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41942eec41ccdf9831648c600d149af5e5f652a2.1639661878.git.geert@linux-m68k.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 16 Dec 2021 14:41:21 +0100, Geert Uytterhoeven wrote:
> The number of interrupts lacks an upper bound, thus assuming one,
> causing properly grouped "interrupts-extended" properties to be flagged
> as an error by "make dtbs_check".
> 
> Fix this by adding the missing "maxItems".  As the architectural maximum
> is 15872 interrupts, using that as the limit would be unpractical.
> Hence limit it to 9 interrupts (one interrupt for a system management
> core, and two interrupts per core for other cores).  This should be
> sufficient for now, and the limit can always be increased when the need
> arises.
> 
> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
> ---
> v2:
>   - Split in two patches,
>   - Improve patch description and document limit rationale.
> ---
>  .../bindings/interrupt-controller/sifive,plic-1.0.0.yaml         | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
