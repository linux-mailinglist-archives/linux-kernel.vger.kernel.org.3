Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C37835018DC
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 18:39:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237137AbiDNQls (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 12:41:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239700AbiDNQlW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 12:41:22 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 498A6AC047
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 09:10:09 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id h5so5138188pgc.7
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 09:10:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=++TmBWO1YM92e9/sGWADvMXzGuWQuA2AD0SMUsAqv+Q=;
        b=JoUoj8n/GW9gkKQC1j6p3chTuhXkvPltZdV1WwSw3ET/WW2qintUx7JYtkS0C+Dn/n
         ns41TCv2Olei9/sxo0eUZ6hHo9JfC+Trb6vcLuwZh6A7JSmFouitlK62Cb5YStHALyFh
         1VNfCeG6hcoCkRApyt101mCwSPXCqKHG3qS8sqybkuQ12StcZEU88yEQ7V1/f6dG8muy
         juNzghTVH02wdgsShkpXvpNZkhU1aGjLJglQ5xXIixshsCHv3ihuCBu1AHfggTZGnHua
         keDc8HOIKevZPwnSlFBnU4Jae0ocHwcMypk++/5KUNdSzXOJyS01Mrmj/w92B5fDvTSH
         ZWcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=++TmBWO1YM92e9/sGWADvMXzGuWQuA2AD0SMUsAqv+Q=;
        b=lO3bIqSd5yARvqOVQyZiA9CeQQCdtvevl83k9d/9HDOzVoV0FMGRKx3rrJNQ0F44zY
         ++Y69KOVvQhRPsE5RtxAnpF6dCoisDfxel1JRqF3YxkQqZea81+z2do+EH583BRK2ew8
         ETMVcWRuHOCVrbIYnTl2kQlfhBU2VPceX/rCZgQC9pyjSfiRMv/vyniX3jHqYE7ZCogk
         3bYIkuqMPejRAkcH0sk0SEmxDD1qnvM0NdrnzbVUVjZBlJCnvUHCcnrKeg7uDCZInccb
         W6yJhyms0Gcj9Ek3WqJtJEUPKiHk+bG2wG1WioSHwmxr9gMy7W7ipkn286028RJ3HOn/
         qwww==
X-Gm-Message-State: AOAM530fIMoV+j1TrtSbBerpmHfTYkm6FzhrYc3snRBFYDba0W+DuLk2
        18uHTZgKoike4c9kcz20VOVEuw==
X-Google-Smtp-Source: ABdhPJwvTXSLjFWKJT2b2kUclniIMf+jXP1VUhMPADLUMQgcA+BzmtbVUrDr4ZpIjDVNMHi3GupQLQ==
X-Received: by 2002:a63:310f:0:b0:39d:90e3:6a44 with SMTP id x15-20020a63310f000000b0039d90e36a44mr2847254pgx.281.1649952608633;
        Thu, 14 Apr 2022 09:10:08 -0700 (PDT)
Received: from p14s (S0106889e681aac74.cg.shawcable.net. [68.147.0.187])
        by smtp.gmail.com with ESMTPSA id m21-20020a17090a7f9500b001c97c6bcaf4sm6336845pjl.39.2022.04.14.09.10.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Apr 2022 09:10:06 -0700 (PDT)
Date:   Thu, 14 Apr 2022 10:10:03 -0600
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc:     bjorn.andersson@linaro.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, linux-remoteproc@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com,
        linux-arm-kernel@lists.infradead.org, Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH V3] remoteproc: imx_rproc: Ignore create mem entry for
 resource table
Message-ID: <20220414161003.GA698343@p14s>
References: <20220331084007.2323377-1-peng.fan@oss.nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220331084007.2323377-1-peng.fan@oss.nxp.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 31, 2022 at 04:40:07PM +0800, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> Resource table is used by Linux to get information pubished by

s/pubished/published

> remote processor. It should be not be used for memory allocation, so
> not create rproc mem entry.
> 
> Fixes: b29b4249f8f0 ("remoteproc: imx_rproc: add i.MX specific parse fw hook")
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
> 
> V3:
>  Update commit log
>  Update Fixes tag
> 
> V2:
>  Add Fixes tag
>  Separate the patch from https://patchwork.kernel.org/project/linux-remoteproc/patch/20220111033333.403448-7-peng.fan@oss.nxp.com/
>  Address typo
> 
>  drivers/remoteproc/imx_rproc.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/remoteproc/imx_rproc.c b/drivers/remoteproc/imx_rproc.c
> index 7a096f1891e6..f2bfc9077c19 100644
> --- a/drivers/remoteproc/imx_rproc.c
> +++ b/drivers/remoteproc/imx_rproc.c
> @@ -423,6 +423,9 @@ static int imx_rproc_prepare(struct rproc *rproc)
>  		if (!strcmp(it.node->name, "vdev0buffer"))
>  			continue;
>  
> +		if (!strncmp(it.node->name, "rsc-table", strlen("rsc-table")))
> +			continue;
> +

Any reason the handling of vdev0buffer is using strcmp() and the resource table
strncmp()?

Thanks,
Mathieu

>  		rmem = of_reserved_mem_lookup(it.node);
>  		if (!rmem) {
>  			dev_err(priv->dev, "unable to acquire memory-region\n");
> -- 
> 2.25.1
> 
