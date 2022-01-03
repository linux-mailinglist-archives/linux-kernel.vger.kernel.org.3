Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0BA17483735
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jan 2022 19:52:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235886AbiACSwa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jan 2022 13:52:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235519AbiACSw3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jan 2022 13:52:29 -0500
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 428BDC061784
        for <linux-kernel@vger.kernel.org>; Mon,  3 Jan 2022 10:52:29 -0800 (PST)
Received: by mail-pg1-x52d.google.com with SMTP id l10so30737628pgm.7
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jan 2022 10:52:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ONYoM4nDQsIA7mznU72gMUeFPTXFAj5C9CW6VGSESrk=;
        b=Hf7AkW1QAwTzTewECAKmSm6LlHGP00oyD7XnvSz4seRg2ZdY5/itwHinZziYD/MfHt
         M64iNV4jrFAiqN2SqEc7rVX/wVmLjfDCTMnwhOweeD/DwwrWIF3/1aQvc6WrCJ6jL1d0
         tzwEyUSOFiVzxSGyr71pcoRk4RgjFsnCaaLkCF19yGKjDogfkTTqwFSyobddhaorzGkl
         KBYOoOPkx5Igovy34FnxYVhrtoQ4n92SfSHwDPsvBMl73jF1+VL5i1TMgZHuXPsWLthe
         2DcXOr2RH689WsqV5cmk6Fv13YjumplMKk0OTuOF9jbRz0MufSZf9eCVNkgaJo1DzHAo
         TV3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ONYoM4nDQsIA7mznU72gMUeFPTXFAj5C9CW6VGSESrk=;
        b=03K1Oe5sBjsP8pWr8PKslfHSB8FCXg8phquc+AXWk51eU+YiHT3AUE11b2sPG5dts/
         LtbgDnGWmwkSs+85LxeWUy6RzHfZ2JbhPd0/u57xbEjq/0Th0iwfX8FS2XNtSCqEGNjT
         7P9VOUvfZV8pc4jUT6O+oJxw7suzGgfI125wVKMKUpriz5gciCsdrjaT3f+siQ1vBdWG
         g6GVlGIhv4KCoOF1PE5bpaHv0Yut2MIsWik0Rj2zuOkhbhEJlBKEPuLBjQcurpN9UM5h
         hAIfyHg0CW/neuPF9VrKjR+sTv3GFAku5NFNsQaHtxgGMja6xoXm28txZuyGYBSy8Pc3
         DpGg==
X-Gm-Message-State: AOAM533ssIAmxwL8KRl2jqnW7sY+TOSCzyAqfIUaNulchIg+1A5NljPT
        JmBeQbkUd6uwwYw56qWzKYNTdg==
X-Google-Smtp-Source: ABdhPJwbX9j4B8ej5E9mvcco173VYrTP4qxMohlGi8VtFXAL0mV0StTKkLR9VOKTdo0DBeGPwq3rTQ==
X-Received: by 2002:a63:e449:: with SMTP id i9mr40900087pgk.561.1641235948595;
        Mon, 03 Jan 2022 10:52:28 -0800 (PST)
Received: from p14s (S0106889e681aac74.cg.shawcable.net. [68.147.0.187])
        by smtp.gmail.com with ESMTPSA id f7sm38756123pfe.71.2022.01.03.10.52.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Jan 2022 10:52:27 -0800 (PST)
Date:   Mon, 3 Jan 2022 11:52:25 -0700
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com
Subject: Re: [PATCH] remoteproc: stm32: Improve crash recovery time
Message-ID: <20220103185225.GB398730@p14s>
References: <20211221143129.18415-1-arnaud.pouliquen@foss.st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211221143129.18415-1-arnaud.pouliquen@foss.st.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 21, 2021 at 03:31:29PM +0100, Arnaud Pouliquen wrote:
> When a stop is requested on a crash, it is useless to try to shutdown it
> gracefully, it is crashed.
>

Right

> In this case don't send the STM32_MBX_SHUTDOWN mailbox message that
> will block the recovery during 500 ms, waiting an answer from the
> coprocessor.
> 
> Signed-off-by: Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>
> ---
>  drivers/remoteproc/stm32_rproc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/remoteproc/stm32_rproc.c b/drivers/remoteproc/stm32_rproc.c
> index b643efcf995a..7d782ed9e589 100644
> --- a/drivers/remoteproc/stm32_rproc.c
> +++ b/drivers/remoteproc/stm32_rproc.c
> @@ -494,7 +494,7 @@ static int stm32_rproc_stop(struct rproc *rproc)
>  	int err, idx;
>  
>  	/* request shutdown of the remote processor */
> -	if (rproc->state != RPROC_OFFLINE) {
> +	if (rproc->state != RPROC_OFFLINE && rproc->state != RPROC_CRASHED) {
>  		idx = stm32_rproc_mbox_idx(rproc, STM32_MBX_SHUTDOWN);
>  		if (idx >= 0 && ddata->mb[idx].chan) {
>  			err = mbox_send_message(ddata->mb[idx].chan, "detach");

I have applied this patch.

Thanks,
Mathieu

> -- 
> 2.17.1
> 
