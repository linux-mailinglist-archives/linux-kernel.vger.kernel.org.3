Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FF8F53173A
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 22:52:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238857AbiEWQhj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 12:37:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238830AbiEWQhg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 12:37:36 -0400
Received: from mail-oa1-f54.google.com (mail-oa1-f54.google.com [209.85.160.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08118692B1
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 09:37:36 -0700 (PDT)
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-e93bbb54f9so19092469fac.12
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 09:37:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=1BFgijJ7aszTcHHsd9pAmW3cK000ZbrDTFx/ezp+86o=;
        b=iBr822YvjiANKjvIdeVNyv0eKBOhApGyCRr0cENInFuyGJjZBlYPtAwbSqgXK8UkTU
         vFQz4fQA4ep8vJ85W6AN/2ggvSYc08Cl0h0eb1HUT1qK28sC8M5OHSoJqgtaDJNYrKIE
         9ZisYlSwpAQ5ca5+lZ1oNS/kCVv5dLldwMjFkQU/qqpulbu8pgp1x66RQsfzSPeI3IW2
         xLjWjUeU+PjeUgTlOLdSj+QyINX2MQTQ8NEjTMA079S1Gm1pDlKD0Rn0Hf7uh0osEdp1
         gefzVbEf1KwMI4nloDqzu+F/ZkkWOhp5uWmEKMfea6hiaGF7ByERIT77dqaLW/eCZQ7O
         yXgw==
X-Gm-Message-State: AOAM533YxDcb6TBv1/zD+hpvMy3Wg9CrWINjAgMNTwNDYkPB/qlO+26g
        pF/Vo8jaWBT5ax5wqRPR4A==
X-Google-Smtp-Source: ABdhPJxH6VjjfcO3rS/ZYGupFMMZgZ4XKvxr87yQP/XYRk/Gc4l8E4+ud5ESV/RYisRgIJ/UjILnCw==
X-Received: by 2002:a05:6870:f61a:b0:f1:7484:8eca with SMTP id ek26-20020a056870f61a00b000f174848ecamr12540817oab.107.1653323855185;
        Mon, 23 May 2022 09:37:35 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id q205-20020acad9d6000000b0032b42772ef9sm1212630oig.50.2022.05.23.09.37.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 May 2022 09:37:34 -0700 (PDT)
Received: (nullmailer pid 1722010 invoked by uid 1000);
        Mon, 23 May 2022 16:37:33 -0000
Date:   Mon, 23 May 2022 11:37:33 -0500
From:   Rob Herring <robh@kernel.org>
To:     Tanmay Jagdale <tanmay@marvell.com>
Cc:     will@kernel.org, mark.rutland@arm.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        sgoutham@marvell.com, lcherian@marvell.com, bbhushan2@marvell.com,
        amitsinght@marvell.com
Subject: Re: [PATCH] perf/marvell_cn10k: Add MPAM support for TAD PMU
Message-ID: <20220523163733.GA1712487-robh@kernel.org>
References: <20220523145738.2750368-1-tanmay@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220523145738.2750368-1-tanmay@marvell.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 23, 2022 at 08:27:38PM +0530, Tanmay Jagdale wrote:
> The TAD PMU supports following counters that can be filtered by MPAM
> partition id.

How are you setting the PARTID? There's no support yet in the kernel to 
set it. 

>     - (0x1a) tad_alloc_dtg : Allocations to DTG.
>     - (0x1b) tad_alloc_ltg : Allocations to LTG.
>     - (0x1c) tad_alloc_any : Total allocations to DTG/LTG.
>     - (0x1d) tad_hit_dtg   : DTG hits.
>     - (0x1e) tad_hit_ltg   : LTG hits.
>     - (0x1f) tad_hit_any   : Hit in LTG/DTG.
>     - (0x20) tad_tag_rd    : Total tag reads.
> 
> Add a new 'partid' attribute of 16-bits to get the partition id
> passed from perf tool. This value would be stored in config1 field
> of perf_event_attr structure.
> 
> Example:
> perf stat -e tad/tad_alloc_any,partid=0x12/ <program>

How would userspace get the 0x12 value?

> 
> - Drop read of TAD_PRF since we don't have to preserve any
>   bit fields and always write an updated value.
> - Update register offsets of TAD_PRF and TAD_PFC.
> 
> Signed-off-by: Tanmay Jagdale <tanmay@marvell.com>
> ---
>  drivers/perf/marvell_cn10k_tad_pmu.c | 23 ++++++++++++++++++-----
>  1 file changed, 18 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/perf/marvell_cn10k_tad_pmu.c b/drivers/perf/marvell_cn10k_tad_pmu.c
> index 282d3a071a67..f552e6bffcac 100644
> --- a/drivers/perf/marvell_cn10k_tad_pmu.c
> +++ b/drivers/perf/marvell_cn10k_tad_pmu.c
> @@ -18,10 +18,12 @@
>  #include <linux/perf_event.h>
>  #include <linux/platform_device.h>
>  
> -#define TAD_PFC_OFFSET		0x0
> +#define TAD_PFC_OFFSET		0x800
>  #define TAD_PFC(counter)	(TAD_PFC_OFFSET | (counter << 3))
> -#define TAD_PRF_OFFSET		0x100
> +#define TAD_PRF_OFFSET		0x900
>  #define TAD_PRF(counter)	(TAD_PRF_OFFSET | (counter << 3))
> +#define TAD_PRF_MATCH_PARTID	(1 << 8)
> +#define TAD_PRF_PARTID_NS	(1 << 10)
>  #define TAD_PRF_CNTSEL_MASK	0xFF
>  #define TAD_MAX_COUNTERS	8

Does this h/w block follow the MPAM specification or just uses PARTID in 
its own way?

Rob
