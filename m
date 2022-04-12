Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C71664FE22E
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 15:19:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355440AbiDLNUG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 09:20:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356251AbiDLNS3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 09:18:29 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8033FDFD8;
        Tue, 12 Apr 2022 06:05:41 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id bn33so23974930ljb.6;
        Tue, 12 Apr 2022 06:05:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=eyx7jx3Bxa8aJ84dmQEsWoZnHMTKlMH7KFc98MfZ1Ew=;
        b=etUELTtc7ZUzwQYlTZcXQTuS1XTRZ9jSEwK2mb9O3YgUGFPbgaCbOkiCnBPYsOpY8S
         qJuHsUiwXS8UletsDtxfI/OhIoSTNIk2tBrz90OKIImhygl8dx3rgOLra4VQqHauj+Ro
         b3yGYKbdK+kIh1SMq8BAdDObgPTePZSuK1g5PqKmu0iAReixQAKcYH1VcC4KNZyjCLFW
         UjUxpNf25i9VlmVkDojOGyVs+iVSPg8XoOFnjFX20p0xPVTblEM625/VBs5l1TFQrwIS
         LPbLQzl9+W1eXEQN/LAGjM/dL87GxdhIRpT2g0Uvbx5hnKMTnBNHUXdx0UYZND5fqxfW
         sFRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=eyx7jx3Bxa8aJ84dmQEsWoZnHMTKlMH7KFc98MfZ1Ew=;
        b=X5twpXaEsf5o5a34kx7GhmGLr4vAes3TGkAa60kbaIUbMuv4yJWI/OK8tRBgXXKPlu
         wfOlNB/b5sF2Ta4I5/ywjqxduxKmRJypJFRMBaHTPlQ3P0NsWfLEV/EDoFCBIJLAUBHb
         0Jzv7P/z4AtfL0iTmGxu46DkYXEfrZyZ85sG508Uoi5aT0WBS0uSY39AcUDyxaR792mL
         NEEWm5NwXEQPCMiHbvjcrlILxE0Tvw2Lpv5TptmDp3fccvGzsAXU1qewVs39Ns43ZY8n
         OdpZiK/nvjMvbL9jzSSCtac2g+JHahoHrX+HA9cLkqevF4kc6O/hRAcvcZ2LuJBcaEfY
         dP/A==
X-Gm-Message-State: AOAM532Bg0ofIwLyNl72zPMqjkg2dI5sZ46SrgWsUtdC3et0KSO0zOhb
        lYEmH9Yj52hpjiLevtyQRlY=
X-Google-Smtp-Source: ABdhPJwC56MTs9uBvmSVaRYYFXWBu0GjZz04pY3OLyb9pqq9TRVOWO3jO5XgPA5PR1F54IvOkM8D+g==
X-Received: by 2002:a2e:a4a8:0:b0:249:6444:d29a with SMTP id g8-20020a2ea4a8000000b002496444d29amr23826825ljm.447.1649768739813;
        Tue, 12 Apr 2022 06:05:39 -0700 (PDT)
Received: from mobilestation ([95.79.134.149])
        by smtp.gmail.com with ESMTPSA id m13-20020ac2424d000000b0044859fdd0b7sm3641431lfl.301.2022.04.12.06.05.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Apr 2022 06:05:39 -0700 (PDT)
Date:   Tue, 12 Apr 2022 16:05:37 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Yuanjun Gong <ruc_gongyuanjun@163.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Florian Fainelli <f.fainelli@gmail.com>,
        linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] mips: cpc: Fix refcount leak in
 mips_cpc_default_phys_base
Message-ID: <20220412130537.j4mlsz2xzuk4t3lw@mobilestation>
References: <20220407042657.28614-1-ruc_gongyuanjun@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220407042657.28614-1-ruc_gongyuanjun@163.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To += @Thomas

On Thu, Apr 07, 2022 at 12:26:57PM +0800, Yuanjun Gong wrote:
> From: Gong Yuanjun <ruc_gongyuanjun@163.com>
> 

> Add the missing of_node_put() to release the refcount incremented
> by of_find_compatible_node().

Right, the same bug was fixed in the CDMM driver:
https://lore.kernel.org/linux-mips/20220309091711.3850-1-linmq006@gmail.com/

Good catch. Thanks.
Reviewed-by: Serge Semin <fancer.lancer@gmail.com>

-Sergey

> 
> Signed-off-by: Gong Yuanjun <ruc_gongyuanjun@163.com>
> ---
>  arch/mips/kernel/mips-cpc.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/mips/kernel/mips-cpc.c b/arch/mips/kernel/mips-cpc.c
> index 17aff13cd7ce..3e386f7e1545 100644
> --- a/arch/mips/kernel/mips-cpc.c
> +++ b/arch/mips/kernel/mips-cpc.c
> @@ -28,6 +28,7 @@ phys_addr_t __weak mips_cpc_default_phys_base(void)
>  	cpc_node = of_find_compatible_node(of_root, NULL, "mti,mips-cpc");
>  	if (cpc_node) {
>  		err = of_address_to_resource(cpc_node, 0, &res);
> +		of_node_put(cpc_node);
>  		if (!err)
>  			return res.start;
>  	}
> -- 
> 2.17.1
> 
