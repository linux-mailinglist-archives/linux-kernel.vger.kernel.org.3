Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23AAE4E6648
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Mar 2022 16:48:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351394AbiCXPtj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Mar 2022 11:49:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237234AbiCXPte (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Mar 2022 11:49:34 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 418471151
        for <linux-kernel@vger.kernel.org>; Thu, 24 Mar 2022 08:48:01 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id t13so2911198pgn.8
        for <linux-kernel@vger.kernel.org>; Thu, 24 Mar 2022 08:48:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=KBPHNydxkVOhAgb/0ZNhj4nD6oSionADdioTArt1Vl8=;
        b=xw1s632XXfTZ+5aXkE0y1UEz+Ir37tpKZWDkoT/TcfGPX0DKhVylkGrYSnUzMbSwkS
         vzzKz/uO1E2KxTteAPN24oQAxIz46AIsneTL7AEt+T0y7aiePJu6iQ3/C5Xcw6qJT6t+
         feeV6yAW+u6RVJX8Hh6nJmi/pQ2dGRnVjeL/kdwhOS+fqOU3gSPrflinFVKbIj+vZ7IZ
         FgSBIodB6z+YLl1FcIOjVYIfSzljeYzQkgplupAm7c+3wxqXvPLF1zOQPAgdJs81O+EM
         7ALH7gKP81Rc7tW5SDc/Gamo95QS85ultjQQ/pMmBRPRnE2N1flo1XC7Jrms5aYxPo7a
         waBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=KBPHNydxkVOhAgb/0ZNhj4nD6oSionADdioTArt1Vl8=;
        b=q5exJU/bvoDnRh0QPJ9HfUJkQIB2CaTHOk04Ucs/C8YmvGaXG3oC89a9TqVqZQT/MW
         HGduT5hBSfunFEFC8utUYSw2zi9qyD2dWY9nN4l7gPJd8g6TztUQQBdz7NbiEeG7Zzzg
         IOs7AYd93uskhBkKfU1siBMF3FFWAC8fx5WOVoQq6nklh/5p4cCxiK1/n4Vnm8FfidKb
         W4auws/CvOG2lPhODR73bLEUc9A3iiT2RVr7b3/2rJ9/xknaQAekzd2dI+VuJGRwQ0ZW
         xM9Rfoo85MeoqWa3OizCDLscUDFA1yUZCAQ7hzZ682hc5nRomWDg50Hg/p4KZp+DiLSz
         3jeg==
X-Gm-Message-State: AOAM53194i2R+ouu4wuKIr9GFVtWo37kXqvCSY2G4WiXQSUXuO1suqbt
        zC3pnqfmd3sg7qOfrYOKWH6s7LAAyJRCZA==
X-Google-Smtp-Source: ABdhPJxdBKbzy5qcZZECB2sC1zChNs+gKDcohpC+PFNEsG6p3/ykvZBoaVIy22uw3tFP1RXAM443rA==
X-Received: by 2002:a05:6a00:2310:b0:4fa:7eb1:e855 with SMTP id h16-20020a056a00231000b004fa7eb1e855mr5808228pfh.14.1648136880523;
        Thu, 24 Mar 2022 08:48:00 -0700 (PDT)
Received: from p14s (S0106889e681aac74.cg.shawcable.net. [68.147.0.187])
        by smtp.gmail.com with ESMTPSA id y3-20020a17090a8b0300b001c735089cc2sm3231580pjn.54.2022.03.24.08.47.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Mar 2022 08:47:59 -0700 (PDT)
Date:   Thu, 24 Mar 2022 09:47:57 -0600
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Shengjiu Wang <shengjiu.wang@nxp.com>
Cc:     bjorn.andersson@linaro.org, linux-remoteproc@vger.kernel.org,
        linux-kernel@vger.kernel.org, shengjiu.wang@gmail.com
Subject: Re: [PATCH] remoteproc: core: check rproc->power value before
 decreasing it
Message-ID: <20220324154757.GB3514576@p14s>
References: <1647597096-5480-1-git-send-email-shengjiu.wang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1647597096-5480-1-git-send-email-shengjiu.wang@nxp.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Shengjiu,

On Fri, Mar 18, 2022 at 05:51:36PM +0800, Shengjiu Wang wrote:
> There are possibility that two 'stop' operation happen
> in parallel, then the rproc->power may be decreased to
> -1, that this reference count will be in wrong state.
> So check rproc->power to make sure it is larger than
> zero before decreasing it.
> 
> Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
> ---
>  drivers/remoteproc/remoteproc_core.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/remoteproc/remoteproc_core.c b/drivers/remoteproc/remoteproc_core.c
> index c510125769b9..84e065ad8743 100644
> --- a/drivers/remoteproc/remoteproc_core.c
> +++ b/drivers/remoteproc/remoteproc_core.c
> @@ -2075,6 +2075,9 @@ int rproc_shutdown(struct rproc *rproc)
>  		return ret;
>  	}
>  
> +	if (atomic_read(&rproc->power) <= 0)
> +		goto out;
> +

Although the proposed solution will likely work, I think it is best to use
rproc->state for this.  Simply do the same test as in state_store()[1] and exit
if the conditions are not satisfied.  Please do the same thing for
rproc_detach().

Thanks,
Mathieu

[1]. https://elixir.bootlin.com/linux/v5.17/source/drivers/remoteproc/remoteproc_sysfs.c#L205

>  	/* if the remote proc is still needed, bail out */
>  	if (!atomic_dec_and_test(&rproc->power))
>  		goto out;
> -- 
> 2.17.1
> 
