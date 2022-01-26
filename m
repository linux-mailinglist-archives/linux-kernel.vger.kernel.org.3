Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C4AF49D61A
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 00:19:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233208AbiAZXTQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 18:19:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230230AbiAZXTP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 18:19:15 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA752C06161C
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jan 2022 15:19:14 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id c190-20020a1c9ac7000000b0035081bc722dso761391wme.5
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jan 2022 15:19:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=kikE1Jj2G7EPLsPYx9xb/xCzMakjMgP2QJCqWREkHVE=;
        b=CiEkzEJ5k0W6rrqVjCjvD1mK4Xb8x4Ms52Omfleo4l+wsCY6Z/xqLNSLuIdUUOeJJ6
         G9nXWZzMggWr9Do8w3pMNjM1fikwPFv9t/H+AP+S+UL4T7i95IDW7Pm6K31f3jYBUkHv
         IAbXY6q/SW7EI/QK0GCIK/JW99TtwhCUZz4Nr4PJRCQcVe9gwiS61UVlCxAyXRwAvsgL
         RBCt3FcJpr4oWKFOUpN2xDQQvcHW64MJpwSGvjW1L7H+wxxUCGs5vz5tVg1LrVFgqKo/
         t1NHvCEBC5D+5YibHbtcNzs+b48ejlANiH3dpGPMI69jCLjMDRNx+0RHxB/s3kO2OXU9
         mLEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=kikE1Jj2G7EPLsPYx9xb/xCzMakjMgP2QJCqWREkHVE=;
        b=GYI2VuUppdCyRKZxBBYZoHet+sZoPf4Wmjbn16gGaesY0Zryzl9dgMieKT7rcQ0yxs
         B1+cs0ePANGgXP3CUHomJYrF4+Y/0/hkVxwqcIFBbaLKEStEost4ukAI558rkpEf6hu/
         PB59IltmBIS1+4NIs02op04kmLWzSEq6BpNJHSqv7xz3Jk+Z6NvC6+1rlMCeM/GQQL6T
         KiNq3bxqjqSF52raknCTWedDDTGSuSKyKW7dGmIO0mu9hutE+ivop/3euTnbmgj5xmUo
         QuLa2L+UkKSU4HYFj5hGWsVCuRJFw3+Lp3Cov1bF0ogQ19nBxhu3fak1h4We2nN5hTrQ
         g11Q==
X-Gm-Message-State: AOAM530VdFzoV/MdsRnnwXdqNNL0dbj08QDLeN1rLpWnKvXGpL2wUUVJ
        HME4JmNjGZOz4oM+6F8xbu+FIDl2Mfp/uA==
X-Google-Smtp-Source: ABdhPJwzF2w5t1FwlLEYR7BN/Pv7RsstXvmeMREv0+Cr5DON/tZthgyREPg3GzeHxI+rI9yu5AddWg==
X-Received: by 2002:a1c:a9d7:: with SMTP id s206mr848500wme.38.1643239153240;
        Wed, 26 Jan 2022 15:19:13 -0800 (PST)
Received: from google.com ([2a00:79e0:d:209:bd2e:4d3b:b065:fa46])
        by smtp.gmail.com with ESMTPSA id o6sm673724wrc.65.2022.01.26.15.19.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jan 2022 15:19:12 -0800 (PST)
Date:   Wed, 26 Jan 2022 23:19:08 +0000
From:   David Brazdil <dbrazdil@google.com>
To:     Rob Herring <robh+dt@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Frank Rowand <frowand.list@gmail.com>,
        Will Deacon <will@kernel.org>,
        Andrew Scull <ascull@google.com>,
        Wedson Almeida Filho <wedsonaf@google.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v7 1/2] dt-bindings: reserved-memory: Open Profile for
 DICE
Message-ID: <YfHW7GcINVlB/3Ur@google.com>
References: <20220126231237.529308-1-dbrazdil@google.com>
 <20220126231237.529308-2-dbrazdil@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220126231237.529308-2-dbrazdil@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

On Wed, Jan 26, 2022 at 11:12:36PM +0000, David Brazdil wrote:
> Add DeviceTree bindings for Open Profile for DICE, an open protocol for
> measured boot. Firmware uses DICE to measure the hardware/software
> combination and generates Compound Device Identifier (CDI) certificates.
> These are stored in memory and the buffer is described in the DT as
> a reserved memory region compatible with 'google,open-dice'.
> 
> 'no-map' is required to ensure the memory region is never treated by
> the kernel as system memory.
> 
> Signed-off-by: David Brazdil <dbrazdil@google.com>
> ---
>  .../reserved-memory/google,open-dice.yaml     | 46 +++++++++++++++++++
>  1 file changed, 46 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/reserved-memory/google,open-dice.yaml
> 
> diff --git a/Documentation/devicetree/bindings/reserved-memory/google,open-dice.yaml b/Documentation/devicetree/bindings/reserved-memory/google,open-dice.yaml
> new file mode 100644
> index 000000000000..257a0b51994a
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/reserved-memory/google,open-dice.yaml
> @@ -0,0 +1,46 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/reserved-memory/google,open-dice.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Open Profile for DICE Device Tree Bindings
> +
> +description: |
> +  This binding represents a reserved memory region containing data
> +  generated by the Open Profile for DICE protocol.
> +
> +  See https://pigweed.googlesource.com/open-dice/
> +
> +maintainers:
> +  - David Brazdil <dbrazdil@google.com>
> +
> +allOf:
> +  - $ref: "reserved-memory.yaml"
> +
> +properties:
> +  compatible:
> +    const: google,open-dice
> +
> +  reg:
> +    description: page-aligned region of memory containing DICE data
> +
> +required:
> +  - compatible
> +  - reg
> +  - no-map

You already gave this a Reviewed-by in v6. Just want to mention that I
didn't pick it up because I added a required no-map here. It was always
included in our DTs but I made it required because the kernel should
never treat that region as system memory. The kernel will warn when the
driver tries to wipe the memory otherwise.

David
