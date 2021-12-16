Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 751C1477ED6
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 22:30:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241571AbhLPVa1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 16:30:27 -0500
Received: from mail-oi1-f174.google.com ([209.85.167.174]:37639 "EHLO
        mail-oi1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbhLPVaZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 16:30:25 -0500
Received: by mail-oi1-f174.google.com with SMTP id bj13so794288oib.4;
        Thu, 16 Dec 2021 13:30:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=xQLFTn5sOGEEmLerVKH572h9vk+6RxOTr235biGe564=;
        b=ydGEFoJUh397mc7Y+J/E/uDm2LnqHeNkj/8Erjuhy1PyLuKr0jrWMI3Omg/5YojtIM
         Tt27K/yXCPyzjDZtJW30NZB63HcoSnQdtx7xbm1ssrMkGpfP4CIBXLT7nJZvT3rDqT2r
         90fQZHkbasXFEdJyAcyaGroTX2mgrVM729Jm+u4J6gdKEGUMk2LR625S1GFq2nPwJo0/
         YWGmSbRnKsiSi8I3UNQU8Vrh4tDXvThV1IV/5fkTmhYAG1DxWeTweOwGbp8Jqqx4z/ZA
         axFrm+LwleDfLMShe2vo2W39CW80K+kkFN2kdRCoX+aOBYzNVuQ5RI0e9H0x9/B7VDCL
         zVgA==
X-Gm-Message-State: AOAM532/2L3QlP7inoUg3SU0xp5J4uhlvdnkiOiHZaJWkMhwRPlyExOe
        uZbM7Er2dxFLDJkgCRmX1Q==
X-Google-Smtp-Source: ABdhPJzUo9Ri1qNW0PL/FnJB/g+cONcHN/H/7uk4i9o4D+VheVbl/XNnwO+1pldebFqsoNQkzwWWQw==
X-Received: by 2002:a05:6808:15a:: with SMTP id h26mr5576944oie.36.1639690225385;
        Thu, 16 Dec 2021 13:30:25 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id x13sm1239730otr.58.2021.12.16.13.30.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Dec 2021 13:30:24 -0800 (PST)
Received: (nullmailer pid 799173 invoked by uid 1000);
        Thu, 16 Dec 2021 21:30:24 -0000
Date:   Thu, 16 Dec 2021 15:30:24 -0600
From:   Rob Herring <robh@kernel.org>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        linux-riscv@lists.infradead.org,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Palmer Dabbelt <palmer@dabbelt.com>,
        Anup Patel <anup.patel@wdc.com>
Subject: Re: [PATCH v2 1/2] dt-bindings: timer: sifive,clint: Fix number of
 interrupts
Message-ID: <Ybuv8I1TW54i0NDm@robh.at.kernel.org>
References: <cover.1639662093.git.geert@linux-m68k.org>
 <d66c5aa3744c877e43fe93537b03ed9fbb2642c0.1639662093.git.geert@linux-m68k.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d66c5aa3744c877e43fe93537b03ed9fbb2642c0.1639662093.git.geert@linux-m68k.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 16 Dec 2021 14:43:47 +0100, Geert Uytterhoeven wrote:
> The number of interrupts lacks an upper bound, thus assuming one,
> causing properly grouped "interrupts-extended" properties to be flagged
> as an error by "make dtbs_check".
> 
> Fix this by adding the missing "maxItems".  As the architectural maximum
> is 4095 interrupts, using that as the limit would be unpractical.  Hence
> limit it to 10 interrupts (two interrupts for a system management core,
> and two interrupts per core for other cores).  This should be sufficient
> for now, and the limit can always be increased when the need arises.
> 
> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
> ---
> v2:
>   - Split in two patches,
>   - Improve patch description and document limit rationale.
> ---
>  Documentation/devicetree/bindings/timer/sifive,clint.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
