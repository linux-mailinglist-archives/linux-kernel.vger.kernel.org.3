Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 781DD470604
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 17:41:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243822AbhLJQpa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Dec 2021 11:45:30 -0500
Received: from mail-oi1-f174.google.com ([209.85.167.174]:37645 "EHLO
        mail-oi1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231180AbhLJQp3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 11:45:29 -0500
Received: by mail-oi1-f174.google.com with SMTP id bj13so13995991oib.4;
        Fri, 10 Dec 2021 08:41:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=mzRHekSe+1ItE0g/B1/sdKOqQcFEHI9ComSVVLd1nlI=;
        b=TTEWzUZowR8hAXZcifoY53v6LZGp/anjN7BQ6eVa5ypdPPwVeH6szjYg36BvKRHl3D
         d5SCIknGTgOFhKCEwhc78XBSiKDPXAmXrIiP/TsrPpIl/0KqUyADalWHOMqGlItyEuNa
         y//0cYtzSguMxqWoDQRRZSC7hvr9dO8qNxAsnBPkcMpga+s9AWZTinW8vsVLuKSIu3qB
         Y3Kn3+8O9jfXpuJnZn68BCAOafdBzaRr8n4VSR3zD6mO//HbPydIcikF6heoAmT+5Uk/
         FsB9qdMTcMWkNHK2Wh7qPu4ATVGvTYetAT7TIsn4CICCNqXz0mzLJE8wzRGw04kIaFai
         Tf3w==
X-Gm-Message-State: AOAM532ssIjzgNXG24AAXExx1VNozB6bJcJs4JPel6shKMnnX+MjTygv
        WeWzqjDPqoJlzEwgSX/4WQ==
X-Google-Smtp-Source: ABdhPJwRv+kMCf78RcI/EgKRH+ISPL3AxEehRdB9Ai5HD06TXa1RnLKZV2R7Cgi/ZzR5zEXSnPJELw==
X-Received: by 2002:a05:6808:649:: with SMTP id z9mr12919308oih.125.1639154514388;
        Fri, 10 Dec 2021 08:41:54 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id m12sm600169ots.59.2021.12.10.08.41.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Dec 2021 08:41:53 -0800 (PST)
Received: (nullmailer pid 1495271 invoked by uid 1000);
        Fri, 10 Dec 2021 16:41:52 -0000
Date:   Fri, 10 Dec 2021 10:41:52 -0600
From:   Rob Herring <robh@kernel.org>
To:     Oleksandr Tyshchenko <olekstysh@gmail.com>
Cc:     devicetree@vger.kernel.org,
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
        Rob Herring <robh+dt@kernel.org>,
        xen-devel@lists.xenproject.org, Julien Grall <julien@xen.org>,
        Stefano Stabellini <sstabellini@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V4 6/6] dt-bindings: xen: Clarify "reg" purpose
Message-ID: <YbODUP7jnSWffumD@robh.at.kernel.org>
References: <35ee3534-9e24-5a11-0bf1-a5dd0b640186@gmail.com>
 <1639136201-27530-1-git-send-email-olekstysh@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1639136201-27530-1-git-send-email-olekstysh@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 10 Dec 2021 13:36:41 +0200, Oleksandr Tyshchenko wrote:
> From: Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>
> 
> Xen on Arm has gained new support recently to calculate and report
> extended regions (unused address space) safe to use for external
> mappings. These regions are reported via "reg" property under
> "hypervisor" node in the guest device-tree. As region 0 is reserved
> for grant table space (always present), the indexes for extended
> regions are 1...N.
> 
> No device-tree bindings update is needed (except clarifying the text)
> as guest infers the presence of extended regions from the number
> of regions in "reg" property.
> 
> Signed-off-by: Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>
> ---
> Changes V2 -> V3:
>    - new patch
> 
> Changes V3 -> V4:
>    - add Stefano's R-b and Rob's A-b
>    - remove sentence about ACPI for "reg" and "interrupts"
>      properties
> 
> Changes V4 -> V4.1
>    - bring the mentioning of ACPI back which, as was pointed out by Julien,
>      fits in the context:
>      https://lore.kernel.org/xen-devel/9602b019-6c20-cdc7-23f3-9e4f8fd720f6@xen.org/T/#t
>      so technically restore V3 state
>    - remove Stefano's R-b and Rob's A-b as I am not 100% sure they are
>      happy with that
> ---
>  Documentation/devicetree/bindings/arm/xen.txt | 12 ++++++++----
>  1 file changed, 8 insertions(+), 4 deletions(-)
> 

Acked-by: Rob Herring <robh@kernel.org>
