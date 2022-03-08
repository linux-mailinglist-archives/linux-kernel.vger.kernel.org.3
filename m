Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC7DD4D1FDE
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 19:15:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349204AbiCHSQL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 13:16:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344710AbiCHSQK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 13:16:10 -0500
Received: from mail-oo1-xc2c.google.com (mail-oo1-xc2c.google.com [IPv6:2607:f8b0:4864:20::c2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 929BF43EDB
        for <linux-kernel@vger.kernel.org>; Tue,  8 Mar 2022 10:15:12 -0800 (PST)
Received: by mail-oo1-xc2c.google.com with SMTP id h16-20020a4a6f10000000b00320507b9ccfso23124252ooc.7
        for <linux-kernel@vger.kernel.org>; Tue, 08 Mar 2022 10:15:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=K4GIB1a+cgx4ASeA8RiYFt2Phvx3d2n9qYtTtjZSkjo=;
        b=UuFWGLCWyKSF1937a9Wv2qLhK28Wkbk9bEbbmmrrfvDRJ1Wtzfdj1sks2P69kNILqn
         EPQd5G/VRqb8jjyzV2yyXcuczhNYHyervElZWFcN0DuJdw2O34wuDg6AGovcTtMiCRjr
         PxPxce4e0JuQN4adwPVYMGDm5lUSUNp6hxV2hQBpnRWATRqv8QHWJURKk83phuW448Vb
         NUXR5P8PFZudugMtiyCTu9nfk/2lQ1jwnS06yyX5/MJH9l5qdypLdYhDePlgoTLWudmv
         dQB7ILfS0cZb1jrTD9P7lfXH6OmQOQWT15Fhdbrby8crHAMSNLJi3aCzTz8B36Fo0hb2
         7u4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=K4GIB1a+cgx4ASeA8RiYFt2Phvx3d2n9qYtTtjZSkjo=;
        b=FOOsxRUiI543lpvU/BtQAIbkViaajkvRvr1qiQJcGtgBO+Ci+eD1hGzYtPcSHNsiK8
         Xu5tJd28M9oPO9mKjpIz1boNEIhKCr2uFHQ7J/IxPmokvTUZIDDSTD0YcQXV6v2LVCfG
         XgpVbJVSGcloeUTTYlW2dNIP47+gdbjOpEcAB/qI3uIecUhBavDr3iasNJqA38yoU4Xy
         z3e43oDoRRgieouAgVAT8ctq/SV0tgKsgsAbHz+MGKJDzpyiSS8S8SzB5msx8NklLqIw
         a/mbOMQMyK6aSZjYWMdLEuw9MvfDXkG8hqVhuBC7fmUeWMwFnI13uFLFAmbuj8HPCSIM
         +MIA==
X-Gm-Message-State: AOAM531z0il1KWOkiDWO3oYsH0mWr50D1zahAoOD+E+E6iBtRbJIfY7K
        qCJ9uL/Gm+kltGXbOIP4rWp0Bg==
X-Google-Smtp-Source: ABdhPJxMxiUBjaZfyfik8ZsFdtHh5D/+Th3AexX3SwQukuqx41mBNh7mZv7BtOgxyId3ct0kIoaJlA==
X-Received: by 2002:a05:6870:3049:b0:da:371b:5864 with SMTP id u9-20020a056870304900b000da371b5864mr3179434oau.105.1646763311852;
        Tue, 08 Mar 2022 10:15:11 -0800 (PST)
Received: from ripper ([2600:1700:a0:3dc8:205:1bff:fec0:b9b3])
        by smtp.gmail.com with ESMTPSA id 37-20020a9d0328000000b005b2265711fcsm4672999otv.16.2022.03.08.10.15.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Mar 2022 10:15:11 -0800 (PST)
Date:   Tue, 8 Mar 2022 10:16:54 -0800
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Drew Fustini <dfustini@baylibre.com>
Cc:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Suman Anna <s-anna@ti.com>, Dave Gerlach <d-gerlach@ti.com>
Subject: Re: [PATCH] remoteproc: move rproc_da_to_va declaration to
 remoteproc.h
Message-ID: <YiedlvZWpHd8HP40@ripper>
References: <20220308172515.29556-1-dfustini@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220308172515.29556-1-dfustini@baylibre.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 08 Mar 09:25 PST 2022, Drew Fustini wrote:

> From: Suman Anna <s-anna@ti.com>
> 
> The rproc_da_to_va() API is an exported function, so move its
> declaration from the remoteproc local remoteproc_internal.h
> to the public remoteproc.h file.
> 
> This will allow drivers outside of the remoteproc folder to be
> able to use this API.
> 

Can you explain why drivers outside of the remoteproc folder should be
able to poke straight into the memory of the remoteproc?

Your reasoning makes sense, but we've on purpose kept it out of
remoteproc.h because no one has had a proper reason for it and I sense
that we might open the door for some new creative solutions...

Regards,
Bjorn

> Signed-off-by: Suman Anna <s-anna@ti.com>
> Signed-off-by: Dave Gerlach <d-gerlach@ti.com>
> [adjusted line numbers to apply]
> Signed-off-by: Drew Fustini <dfustini@baylibre.com>
> ---
> Note: I previously posted this patch as part of a series:
> [PATCH 00/11] soc: ti: wkup_m3_ipc: support vtt toggle, io isolation & voltage scaling
> https://lore.kernel.org/linux-omap/20220219215328.485660-1-dfustini@baylibre.com/
> 
> I was advised to break that series up into smaller pieces, so I am
> submitting this patch individually. I will in the future post a series
> to support i2c voltage scaling which will utilize rproc_da_to_va() from 
> drivers/soc/ti/wkup_m3_ipc.c
> 
>  drivers/remoteproc/remoteproc_internal.h | 1 -
>  include/linux/remoteproc.h               | 1 +
>  2 files changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/remoteproc/remoteproc_internal.h b/drivers/remoteproc/remoteproc_internal.h
> index a328e634b1de..72d4d3d7d94d 100644
> --- a/drivers/remoteproc/remoteproc_internal.h
> +++ b/drivers/remoteproc/remoteproc_internal.h
> @@ -84,7 +84,6 @@ static inline void  rproc_char_device_remove(struct rproc *rproc)
>  void rproc_free_vring(struct rproc_vring *rvring);
>  int rproc_alloc_vring(struct rproc_vdev *rvdev, int i);
>  
> -void *rproc_da_to_va(struct rproc *rproc, u64 da, size_t len, bool *is_iomem);
>  phys_addr_t rproc_va_to_pa(void *cpu_addr);
>  int rproc_trigger_recovery(struct rproc *rproc);
>  
> diff --git a/include/linux/remoteproc.h b/include/linux/remoteproc.h
> index e0600e1e5c17..cc9dc9aef0c0 100644
> --- a/include/linux/remoteproc.h
> +++ b/include/linux/remoteproc.h
> @@ -673,6 +673,7 @@ void rproc_shutdown(struct rproc *rproc);
>  int rproc_detach(struct rproc *rproc);
>  int rproc_set_firmware(struct rproc *rproc, const char *fw_name);
>  void rproc_report_crash(struct rproc *rproc, enum rproc_crash_type type);
> +void *rproc_da_to_va(struct rproc *rproc, u64 da, size_t len, bool *is_iomem);
>  void rproc_coredump_using_sections(struct rproc *rproc);
>  int rproc_coredump_add_segment(struct rproc *rproc, dma_addr_t da, size_t size);
>  int rproc_coredump_add_custom_segment(struct rproc *rproc,
> -- 
> 2.32.0
> 
