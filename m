Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FEB94FE774
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 19:48:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358530AbiDLRuV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 13:50:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244731AbiDLRuU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 13:50:20 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9910461A0D
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 10:48:02 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id b15so18147619pfm.5
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 10:48:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=kBQhwTh4wGFWQQwe4mM4wltP+peU9rNcUNkHbTMG0qg=;
        b=oM7dH7p7ixQjtv91MZcAmU9zCDwrKw6QynMRiSX5QxutMf0ZdCJgbAgDI3wJL5UPpr
         6FNHRy3Pr24OYLzFQqtgyX6b4MNf3y71tgLfbqW0trh7/KnJE/0HQAploRCAyFaZYvM8
         tw4EdzYpXIYkg4ExyuFf3MB5rg8/wUR31ymFufKgvNZDXMx+s4ypDJfnPQjaYCcRXB9g
         SQ/Z28O0piaUYOJ3l4THQfw26JLJwXgZEP271PAEgipV9/Ot8KaQrsUgIvOsxvU/cdXX
         L1B/z6tDEFv9hPe1xt8fkP7DujOqR4Jz+vP3s0wHPv7PzwlDtqw0eJ1B+O1cSEfek26o
         T66A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=kBQhwTh4wGFWQQwe4mM4wltP+peU9rNcUNkHbTMG0qg=;
        b=5kDrO1bXykzELgJtN8iXkXalDb+VVlG94nC4FI0FjvE7NzR+4CxOeFxReFBzz15531
         bun1pmt9LTuQ9EJEjx2qr2Ac77Iz6lw3B5jUh7O/DNHsFHKNKqzQXQ/drukK6VogUyHl
         BqjakUz1dFpmEd6p7NYTaLO0Q3DRhpbKMX6LNhtTm8jxzTDxfcES8v7wyd6TsfaIn4T9
         ogr9fiiYDjpmYCYjZI9IML5ltfona1PVg6VWCcRQApQytmz0rD3NXGP4U9as0yiapodv
         YdJQ05VxSPfs/PBjbVRL2SHQ+cTYSz12Os0qBPXKE2MC81iDI11BZgigD72eigtBYlqs
         H19Q==
X-Gm-Message-State: AOAM530xoZhV2lybhfzdK4481zgdOTA76tNQWFJXzVL0eMkI6YiPT4eo
        +DGf08IBqPrc76AKi8agVKzX6w==
X-Google-Smtp-Source: ABdhPJy0V0sgG6uM7pznulDzc1E8eQeVDwDpFM11r3aOV36Hr5GwPLKpjkcmRjXwpK47iDiMzaJ6dg==
X-Received: by 2002:a63:ec0c:0:b0:39d:3aa6:4513 with SMTP id j12-20020a63ec0c000000b0039d3aa64513mr11851204pgh.391.1649785682142;
        Tue, 12 Apr 2022 10:48:02 -0700 (PDT)
Received: from p14s (S0106889e681aac74.cg.shawcable.net. [68.147.0.187])
        by smtp.gmail.com with ESMTPSA id 13-20020a17090a0ccd00b001cb8984dc28sm137579pjt.22.2022.04.12.10.48.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Apr 2022 10:48:00 -0700 (PDT)
Date:   Tue, 12 Apr 2022 11:47:58 -0600
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc:     bjorn.andersson@linaro.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, shengjiu.wang@nxp.com,
        linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        linux-arm-kernel@lists.infradead.org, Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH 1/2] remoteproc: elf_loader: skip segment with memsz as
 zero
Message-ID: <20220412174758.GB465495@p14s>
References: <20220323064944.1351923-1-peng.fan@oss.nxp.com>
 <20220323064944.1351923-2-peng.fan@oss.nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220323064944.1351923-2-peng.fan@oss.nxp.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peng,

On Wed, Mar 23, 2022 at 02:49:43PM +0800, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> Per elf specification,
> p_filesz: This member gives the number of bytes in the file image of
> the segment; it may be zero.
> p_memsz: This member gives the number of bytes in the memory image
> of the segment; it may be zero.
> 
> There is a case that i.MX DSP firmware has segment with PT_LOAD and
> p_memsz/p_filesz set to zero. Such segment needs to be ignored,
> otherwize rproc_da_to_va would report error.
> 
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>  drivers/remoteproc/remoteproc_elf_loader.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/remoteproc/remoteproc_elf_loader.c b/drivers/remoteproc/remoteproc_elf_loader.c
> index d635d19a5aa8..cb77f9e4dc70 100644
> --- a/drivers/remoteproc/remoteproc_elf_loader.c
> +++ b/drivers/remoteproc/remoteproc_elf_loader.c
> @@ -181,7 +181,14 @@ int rproc_elf_load_segments(struct rproc *rproc, const struct firmware *fw)
>  		bool is_iomem = false;
>  		void *ptr;
>  
> -		if (type != PT_LOAD)
> +		/*
> +		 *  There is a case that with PT_LOAD type, the
> +		 *  filesz = memsz = 0. If memsz = 0, rproc_da_to_va
> +		 *  should return NULL ptr, then error is returned.
> +		 *  So this case should be skipped from the loop.
> +		 *  Add !memsz checking here.

There are several architecture where XYZ_da_to_va() does not return a NULL
pointer when @len is 0, making this comment inaccurate.  Please remove that
part.

> +		 */
> +		if (type != PT_LOAD || !memsz)
>  			continue;

I have reflected long and hard on this one...

If @memsz is 0 then @filesz _has_ to be 0, otherwise rproc_elf_load_segments()
returns -EINVAL.  If @filesz is also 0 then nothing gets copied (for
architectures where XYZ_da_to_va() doesn't return a NULL pointer when @len is
0), which is exactly the same as what the above change does. 

As such I am inclined to view this set favourably.  That being said we will
have to proceed cautiously.  If something breaks we will have to revert it.

Please send another revision as quickly as possible so that it can stay in
linux-next long enough to, hopefully, catch any problems.

With the above and for this set:

Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>
 
>  
>  		dev_dbg(dev, "phdr: type %d da 0x%llx memsz 0x%llx filesz 0x%llx\n",
> -- 
> 2.25.1
> 
