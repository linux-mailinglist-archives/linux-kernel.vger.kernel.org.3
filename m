Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B8CB5773F6
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Jul 2022 06:07:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232572AbiGQEH2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Jul 2022 00:07:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229536AbiGQEH0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Jul 2022 00:07:26 -0400
Received: from mail-oa1-x29.google.com (mail-oa1-x29.google.com [IPv6:2001:4860:4864:20::29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6A591EC58
        for <linux-kernel@vger.kernel.org>; Sat, 16 Jul 2022 21:07:25 -0700 (PDT)
Received: by mail-oa1-x29.google.com with SMTP id 586e51a60fabf-10c0430e27dso15829174fac.4
        for <linux-kernel@vger.kernel.org>; Sat, 16 Jul 2022 21:07:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=7maQPp/4L1DRl1i7L7WTXN1f8HRR3AHs0CFk6kAGA8Q=;
        b=i1XgxSFl0g91RDOuxsh9q01eMgRrA8bv2u7c2UnsQMI5vi4DxPAtRaiEeOUbyTP44p
         tSdWldY8Uz84HdD1Oran6Ckr6GSVx+bnQh79xSSKOzhgYknyul7NwCOWUbksJ5dQKI9O
         cNoWTV0OxpVNeOvL8FL1Wx41LfoVW9ALmGPvuipft/j31vt+xs1OExAYLdk/iMLLo8fl
         GuzU/1mn0+U+G+CdjWXLSaMbajEQEVj2pNkkPkjA3JNuqk2YN64WcyLplcjYzUb8if2d
         llyoNn4PzA98R2PuE2+9G18mWebPGfYMZ4IFms2JMfRfYs0nnGp2D1ClbI5WCdIr7afp
         X/ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=7maQPp/4L1DRl1i7L7WTXN1f8HRR3AHs0CFk6kAGA8Q=;
        b=Z41mymkaExyvKODy5oXFWr97FD51WGT/Mx2K0aXMKu37MWRrIBR9BKvxs5LCSwGcQB
         BQsOAA8OgXTQU2IneHR0h1pnTrQCoby8Ik2ilLkIyhaktKF1lacQpFMPQRdl9NVoSdgc
         hepInnkQfSWbCQwMhiw4A95TMMS5WuI2bMzQJvueFXwEgG+Pfx/bLYnnrRqEjldqVnta
         xqJBPsIHtaCmqRLEF/CsOGRRVOLoYdnSUR3jSr7/kKaPzMF2lR+LfnlUXz7CkcyUIkIo
         Vw0iZ5Z+C4mKEJnovexatPk7p9WU6Yu+L3l8st9c4MY38uG0fYpsZR5KsmpyMQ8VZdXJ
         0Zdw==
X-Gm-Message-State: AJIora9K/xIEcwLraYmYdgJ9wKUfakc6vvnMFs2uU1+UntyvxzGDxARt
        d4YutHarZL9SddCvia5bSGtOPA==
X-Google-Smtp-Source: AGRyM1soOTh116D1hmoH+Xdok8zxWlIALX53UC2OQFWne2aFFcUGrDFbpWfpf6vA0yauAhA8V7maUQ==
X-Received: by 2002:a05:6870:2490:b0:101:d94b:c9fd with SMTP id s16-20020a056870249000b00101d94bc9fdmr10910528oaq.73.1658030845116;
        Sat, 16 Jul 2022 21:07:25 -0700 (PDT)
Received: from builder.lan (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id w21-20020a9d6755000000b0061c9c7813d4sm547368otm.24.2022.07.16.21.07.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Jul 2022 21:07:23 -0700 (PDT)
Date:   Sat, 16 Jul 2022 23:07:21 -0500
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc:     mathieu.poirier@linaro.org, linux-imx@nxp.com,
        linux-remoteproc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH] remoteproc: core: check state in rproc_boot
Message-ID: <YtOK+XU+dtqfnsox@builder.lan>
References: <20220519064111.3244079-1-peng.fan@oss.nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220519064111.3244079-1-peng.fan@oss.nxp.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 19 May 01:41 CDT 2022, Peng Fan (OSS) wrote:

> From: Peng Fan <peng.fan@nxp.com>
> 
> If remote processor has already been in RUNNING or ATTACHED
> state, report it. Not just increment the power counter and return
> success.
> 
> Without this patch, if m7 is in RUNNING state, and start it again,
> nothing output to console.
> If wanna to stop the m7, we need write twice 'stop'.
> 
> This patch is to improve that the 2nd start would show some useful
> info.
> 
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
> 
> Not sure to keep power counter or not.
> 

I did discuss this with Mathieu, whom argued in favor of keeping the
refcount mechanism.

I can see that there could be a scenario where multiple user-space
components keep the remotproc running while they are, and if there is
any such user this ABI change would be a breakage.

That said, it's more than once that I accidentally have bumped the
refcount and then assumed that a single stop would tear down the
remoteproc...

>  drivers/remoteproc/remoteproc_core.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/remoteproc/remoteproc_core.c b/drivers/remoteproc/remoteproc_core.c
> index 02a04ab34a23..f37e0758c096 100644
> --- a/drivers/remoteproc/remoteproc_core.c
> +++ b/drivers/remoteproc/remoteproc_core.c
> @@ -2005,6 +2005,12 @@ int rproc_boot(struct rproc *rproc)
>  		goto unlock_mutex;
>  	}
>  
> +	if (rproc->state == RPROC_RUNNING || rproc->state == RPROC_ATTACHED) {

If we were to do this would it make sense to boot it out of anything but
RPROC_OFFLINE?

Regards,
Bjorn

> +		ret = -EINVAL;
> +		dev_err(dev, "%s already booted\n", rproc->name);
> +		goto unlock_mutex;
> +	}
> +
>  	/* skip the boot or attach process if rproc is already powered up */
>  	if (atomic_inc_return(&rproc->power) > 1) {
>  		ret = 0;
> -- 
> 2.25.1
> 
