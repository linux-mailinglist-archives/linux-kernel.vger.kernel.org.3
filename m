Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3BC2E48EC03
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jan 2022 15:50:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242081AbiANOul (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jan 2022 09:50:41 -0500
Received: from mail-ot1-f54.google.com ([209.85.210.54]:43785 "EHLO
        mail-ot1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242055AbiANOui (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jan 2022 09:50:38 -0500
Received: by mail-ot1-f54.google.com with SMTP id i5-20020a05683033e500b0057a369ac614so10270160otu.10;
        Fri, 14 Jan 2022 06:50:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=+ZMcnyq4Kk1QBLF/cyPIuwPjo5svsETQ8AvzdBLgmtY=;
        b=KkQ8PbOh6Sk8cy/2W9jezFkvDNaaoj+cWe44KDt4WhFx6c/X+h42rSoR/sjhCwJ3ma
         mDkK3kMGAGfTzLye+/DTaLj5NoYnmYgPuDHLSI4bAYNPY9Ou+I5ypG8KIIkRiS+RVoiW
         SFe5NZrnV5aK4EOFywl+km0ovzopmQQ17OxYx606z2jnctIlanxWgYcyhxfX8mwSn5VX
         oXk6UpdGMM/8X6SyZVS8vytsfnHJoIQJfrlSZJIp5DQB6RND5QETdz5CV2qXgCCZ20rf
         UjJ9FIEJhdlcf3xsXtsCgXJii/ebZKSHPByLAA7Mpsr2sX3+UDBUWjAFtBVA7EaPtxKd
         Tq2Q==
X-Gm-Message-State: AOAM531WT1s8QcC17M1BwFQ4lg4ux5+3ikZ5ehlw5yg+ACLVYLHAQkHd
        FSp0uH74JVCK9jrMZ1A5y7W5T7riDw==
X-Google-Smtp-Source: ABdhPJz8+2tiU5iD7jFQuLkH89Yi8FrmtFPu369HrmdCSAUznCBlN+QVpFPT4Zn4QHfDS2Ghb31IPQ==
X-Received: by 2002:a9d:5549:: with SMTP id h9mr7150513oti.36.1642171837665;
        Fri, 14 Jan 2022 06:50:37 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id r30sm1929838otv.48.2022.01.14.06.50.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jan 2022 06:50:36 -0800 (PST)
Received: (nullmailer pid 1868117 invoked by uid 1000);
        Fri, 14 Jan 2022 14:50:35 -0000
Date:   Fri, 14 Jan 2022 08:50:35 -0600
From:   Rob Herring <robh@kernel.org>
To:     Michael Walle <michael@walle.cc>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Frank Rowand <frowand.list@gmail.com>
Subject: Re: [PATCH v2 0/5] of: base: small cleanups
Message-ID: <YeGNuwyenYcr3X2O@robh.at.kernel.org>
References: <20220114120723.326268-1-michael@walle.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220114120723.326268-1-michael@walle.cc>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 14, 2022 at 01:07:18PM +0100, Michael Walle wrote:
> This series is a result of the discussion in [1]. Rob suggested to convert
> the index parameter to unsigned int and drop the check for negative values
> and make them static inline.
> 
> It will also introduce a new variant of the function, although it is unused
> for now. They will be needed when nvmem phandles are modified to take
> additional arguments and need to retain backwards compatibility with older
> device trees.
> 
> Finally, define of_property_read_u{8,16,32,64}_array() unconditionally,
> these are the last ones, which were defined static inline and had an empty
> stub if CONFIG_OF wasn't set.
> 
> [1] https://lore.kernel.org/linux-devicetree/20211228142549.1275412-1-michael@walle.cc/
> 
> Michael Walle (5):
>   of: base: convert index to unsigned for of_parse_phandle()
>   of: base: make small of_parse_phandle() variants static inline
>   of: base: add of_parse_phandle_with_optional_args()
>   of: property: define of_property_read_u{8,16,32,64}_array()
>     unconditionally
>   of: property: use unsigned index for of_link_property()
> 
>  drivers/of/base.c     | 137 +------------
>  drivers/of/property.c |  27 ++-
>  include/linux/of.h    | 446 +++++++++++++++++++++++++-----------------
>  3 files changed, 294 insertions(+), 316 deletions(-)

I've applied the series and plan to send for v5.17-rc1.

Rob
