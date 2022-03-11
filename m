Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 943164D6376
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 15:29:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349255AbiCKOag (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 09:30:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234520AbiCKOad (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 09:30:33 -0500
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63689E338F;
        Fri, 11 Mar 2022 06:29:30 -0800 (PST)
Received: by mail-lj1-x229.google.com with SMTP id z26so12239061lji.8;
        Fri, 11 Mar 2022 06:29:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=nJkLUw2fF6Q/1cDr2N/dQ7NtiGvkifC2ibZYvvSHEdU=;
        b=Pk99k1lsqIqmRCLmWCf1DH3Xp4lMUs5Q+riC9rSNZtZi5L9Y938iWzsP+Gyix81pmx
         sVAKbQKdb4iyCo5/xHq7bH33Yvig5qKWrJjlafZ9HEZVrUiFJwqjNYyjdCXEpaw14tNr
         WpsQ1GBzWISh/swMZF9rnymWuVeIz82eh58D6hzzyLCaPJOkOEJYuXYnK4sP6nr/x7Uz
         ZODEwWNDfkYRvTJSgP5h/Oagz6saJxAGbGszVQiV+obGhhgq3SLY4zidV8NAYKXAJZBH
         CfOGJ4hXk5b1KfkD86g5GgTFVsbD4bvoaVQATcQnqwOZLIyRsE6HQqc++dCTmCTk8YNF
         gWBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=nJkLUw2fF6Q/1cDr2N/dQ7NtiGvkifC2ibZYvvSHEdU=;
        b=QEsoIfEmcD2HFG5Jo9vfvUArjofgHVCMMUR/UchYLkbuMWQOIWl/vTeMz2e7PLmDdQ
         IH6iW2FETU21cDVSrKHHm7z6Dn9Akb3g0nHLe9EMlruiENJB1xDespGiNCDOdhvAAIip
         l60l4TtNqxChS6hir+nEU+Pf9V4WgDPc28zj97ZdDPCsknGFDKUco9SH8kE/PT8JQt3u
         h7PS4BXP4UtdRnXNK2JsG3vOH86rqIupLc1MkmIWJpFFkilLL96n/yPTrNPCdiYEYmEw
         1Lotsy5iGBcqVE/ytG45PyzFdRgJ732YdS2tKmrNfk+yqKyJmb9qKAfe7NwBTRsSrthv
         uiuQ==
X-Gm-Message-State: AOAM532TjsA1xzIqZypuAJEcXZ0Irp5gEh0xDEfpTbjYo2UDII0NrU2R
        G+mqCoCgHjiyQUooi2fKfH4wxi246rvHuQ==
X-Google-Smtp-Source: ABdhPJyLxuyTh4KFNJvSOCfo8f+yr0SH0ahlebWO9xiK91FVHP0Hildk3KX0+Nkqf7PVNtdflPtZOg==
X-Received: by 2002:a05:651c:1209:b0:244:b99d:8902 with SMTP id i9-20020a05651c120900b00244b99d8902mr6024821lja.185.1647008968755;
        Fri, 11 Mar 2022 06:29:28 -0800 (PST)
Received: from mobilestation ([95.79.188.22])
        by smtp.gmail.com with ESMTPSA id n13-20020a056512388d00b00443d9064160sm1629495lft.125.2022.03.11.06.29.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Mar 2022 06:29:27 -0800 (PST)
Date:   Fri, 11 Mar 2022 17:29:26 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Miaoqian Lin <linmq006@gmail.com>
Cc:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mips: cdmm: Fix refcount leak in mips_cdmm_phys_base
Message-ID: <20220311142926.czypl55ni6wpqpjm@mobilestation>
References: <20220309091711.3850-1-linmq006@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220309091711.3850-1-linmq006@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 09, 2022 at 09:17:10AM +0000, Miaoqian Lin wrote:
> The of_find_compatible_node() function returns a node pointer with
> refcount incremented, We should use of_node_put() on it when done
> Add the missing of_node_put() to release the refcount.
> 
> Fixes: 2121aa3e2312 ("mips: cdmm: Add mti,mips-cdmm dtb node support")

Nice catch. Thanks.

Acked-by: Serge Semin <fancer.lancer@gmail.com>

> Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
> ---
>  drivers/bus/mips_cdmm.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/bus/mips_cdmm.c b/drivers/bus/mips_cdmm.c
> index 626dedd110cb..fca0d0669aa9 100644
> --- a/drivers/bus/mips_cdmm.c
> +++ b/drivers/bus/mips_cdmm.c
> @@ -351,6 +351,7 @@ phys_addr_t __weak mips_cdmm_phys_base(void)
>  	np = of_find_compatible_node(NULL, NULL, "mti,mips-cdmm");
>  	if (np) {
>  		err = of_address_to_resource(np, 0, &res);
> +		of_node_put(np);
>  		if (!err)
>  			return res.start;
>  	}
> -- 
> 2.17.1
> 
