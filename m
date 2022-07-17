Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B3AB5773B0
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Jul 2022 05:24:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232191AbiGQDXM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Jul 2022 23:23:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231661AbiGQDXJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Jul 2022 23:23:09 -0400
Received: from mail-oa1-x2c.google.com (mail-oa1-x2c.google.com [IPv6:2001:4860:4864:20::2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12DA9175BF
        for <linux-kernel@vger.kernel.org>; Sat, 16 Jul 2022 20:23:07 -0700 (PDT)
Received: by mail-oa1-x2c.google.com with SMTP id 586e51a60fabf-10bffc214ffso15703549fac.1
        for <linux-kernel@vger.kernel.org>; Sat, 16 Jul 2022 20:23:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=wBkLRgjEotsUbsEV/WXpCbdlza5I+wukQF1G+BQqqFc=;
        b=OYEgZ/sRk/sQvSBklVHUHlhfYdatW9LTmiPXcZVnu6U25sZDoycnGIOdMFqnw8ffTQ
         rqp0krL6ls6pwDVk+ni1YQXCjjjGJf7WBrh70I5GR0OCmWxovgIpzVbeTa+HSvMimKPd
         oKWdOnorHMDGBg+5IO7UHujjazBdpKkg+uFtPFz7TmxIt5Vt4aXVYP9F+1S/eN5mbCAl
         vxTZ02WljjhDEsmHGj/M4civNb9DXHz9ifl/Vq8vnZE9D2/jJpbJZM/AomFJUTT96Wpk
         h2g4xVPe5w6QmI3RF6hn8oN/hG8ULJFK1ZKctu8Y2yGVX+R9X85w/OSlt+gCTqqVR7G/
         fa9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=wBkLRgjEotsUbsEV/WXpCbdlza5I+wukQF1G+BQqqFc=;
        b=jaj8hQ5Fk5bD7BlLcn1lslji05rkMdB9KbsdF1ceZpSGdzh7F86q4ydAKyrAejpPrz
         pRlohqJspf6tre8VuIh1QYnOz631d+cGSIZfiqJ3GubmVftnzcbYxXzbeE5XFgSH4uxZ
         WVnQ/pEe8vWkxfnKjLpyrwm2ig1hted6y1KD+z+U7GCmXYZZO6vla3kka0kLnFwgAW94
         9fuCeeMxVOUTyGK8XkjZBf3lRHIRIjYp3Kq6fV3+/3O5Oj+G895WJ0LPh1ETIqzgskBw
         FgEMHF+uXGNyFqsW9nnOOKdBdlNms8rkMnSiLMTaY5/ORy8GLmSbcr++XVDBOoZe9tL0
         qtjw==
X-Gm-Message-State: AJIora93iRLH6eeqgjK84Sgs3ZHUf8YixbW/UmYkrJUqSmU10hGiNDop
        aZSQofYJuF2H8vqxMrFzJg58Mw==
X-Google-Smtp-Source: AGRyM1v1Stxdl8VNeJVtgXV2l39ZP8xoTOYGVkJ8DCaYpxX/MQ/0PgziElmPV0A/eeOYW5/9wPmUgw==
X-Received: by 2002:a05:6871:8b:b0:fe:3656:9071 with SMTP id u11-20020a056871008b00b000fe36569071mr14877980oaa.230.1658028185999;
        Sat, 16 Jul 2022 20:23:05 -0700 (PDT)
Received: from builder.lan (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id r14-20020a9d750e000000b0061c144e8ca2sm3645762otk.30.2022.07.16.20.23.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Jul 2022 20:23:05 -0700 (PDT)
Date:   Sat, 16 Jul 2022 22:23:03 -0500
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Sibi Sankar <quic_sibis@quicinc.com>
Cc:     arnd@arndb.de, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, sboyd@kernel.org, agross@kernel.org,
        linux-remoteproc@vger.kernel.org, mathieu.poirier@linaro.org,
        mka@chromium.org
Subject: Re: [PATCH v2] remoteproc: qcom_q6v5_mss: map/unmap metadata region
 before/after use
Message-ID: <YtOAlzgexiwz1D5J@builder.lan>
References: <1652248625-990-1-git-send-email-quic_sibis@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1652248625-990-1-git-send-email-quic_sibis@quicinc.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 11 May 00:57 CDT 2022, Sibi Sankar wrote:

> The application processor accessing the dynamically assigned metadata
> region after assigning it to the remote Q6 would lead to an XPU violation.
> Fix this by un-mapping the metadata region post firmware header copy. The
> metadata region is freed only after the modem Q6 is done with fw header
> authentication.
> 
> Signed-off-by: Sibi Sankar <quic_sibis@quicinc.com>

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

> ---
> 
> V2:
>  * Fix error when MSS is built as a module [Kernel Test Bot]
>  * Fixup cleanup errors
> 
>  drivers/remoteproc/qcom_q6v5_mss.c | 38 ++++++++++++++++++++++++++++++++------
>  1 file changed, 32 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/remoteproc/qcom_q6v5_mss.c b/drivers/remoteproc/qcom_q6v5_mss.c
> index af217de75e4d..4b37e11fbb03 100644
> --- a/drivers/remoteproc/qcom_q6v5_mss.c
> +++ b/drivers/remoteproc/qcom_q6v5_mss.c
> @@ -10,6 +10,7 @@
>  #include <linux/clk.h>
>  #include <linux/delay.h>
>  #include <linux/devcoredump.h>
> +#include <linux/dma-map-ops.h>
>  #include <linux/dma-mapping.h>
>  #include <linux/interrupt.h>
>  #include <linux/kernel.h>
> @@ -932,27 +933,52 @@ static void q6v5proc_halt_axi_port(struct q6v5 *qproc,
>  static int q6v5_mpss_init_image(struct q6v5 *qproc, const struct firmware *fw,
>  				const char *fw_name)
>  {
> -	unsigned long dma_attrs = DMA_ATTR_FORCE_CONTIGUOUS;
> +	unsigned long dma_attrs = DMA_ATTR_FORCE_CONTIGUOUS | DMA_ATTR_NO_KERNEL_MAPPING;
> +	unsigned long flags = VM_DMA_COHERENT | VM_FLUSH_RESET_PERMS;
> +	struct page **pages;
> +	struct page *page;
>  	dma_addr_t phys;
>  	void *metadata;
>  	int mdata_perm;
>  	int xferop_ret;
>  	size_t size;
> -	void *ptr;
> +	void *vaddr;
> +	int count;
>  	int ret;
> +	int i;
>  
>  	metadata = qcom_mdt_read_metadata(fw, &size, fw_name, qproc->dev);
>  	if (IS_ERR(metadata))
>  		return PTR_ERR(metadata);
>  
> -	ptr = dma_alloc_attrs(qproc->dev, size, &phys, GFP_KERNEL, dma_attrs);
> -	if (!ptr) {
> +	page = dma_alloc_attrs(qproc->dev, size, &phys, GFP_KERNEL, dma_attrs);
> +	if (!page) {
>  		kfree(metadata);
>  		dev_err(qproc->dev, "failed to allocate mdt buffer\n");
>  		return -ENOMEM;
>  	}
>  
> -	memcpy(ptr, metadata, size);
> +	count = PAGE_ALIGN(size) >> PAGE_SHIFT;
> +	pages = kmalloc_array(count, sizeof(struct page *), GFP_KERNEL);
> +	if (!pages) {
> +		ret = -ENOMEM;
> +		goto free_dma_attrs;
> +	}
> +
> +	for (i = 0; i < count; i++)
> +		pages[i] = nth_page(page, i);
> +
> +	vaddr = vmap(pages, count, flags, pgprot_dmacoherent(PAGE_KERNEL));
> +	kfree(pages);
> +	if (!vaddr) {
> +		dev_err(qproc->dev, "unable to map memory region: %pa+%zx\n", &phys, size);
> +		ret = -EBUSY;
> +		goto free_dma_attrs;
> +	}
> +
> +	memcpy(vaddr, metadata, size);
> +
> +	vunmap(vaddr);
>  
>  	/* Hypervisor mapping to access metadata by modem */
>  	mdata_perm = BIT(QCOM_SCM_VMID_HLOS);
> @@ -982,7 +1008,7 @@ static int q6v5_mpss_init_image(struct q6v5 *qproc, const struct firmware *fw,
>  			 "mdt buffer not reclaimed system may become unstable\n");
>  
>  free_dma_attrs:
> -	dma_free_attrs(qproc->dev, size, ptr, phys, dma_attrs);
> +	dma_free_attrs(qproc->dev, size, page, phys, dma_attrs);
>  	kfree(metadata);
>  
>  	return ret < 0 ? ret : 0;
> -- 
> 2.7.4
> 
