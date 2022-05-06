Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 429B351DEA4
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 20:07:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352241AbiEFSL3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 May 2022 14:11:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244654AbiEFSL0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 May 2022 14:11:26 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 382536A071
        for <linux-kernel@vger.kernel.org>; Fri,  6 May 2022 11:07:43 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id e5so6705144pgc.5
        for <linux-kernel@vger.kernel.org>; Fri, 06 May 2022 11:07:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=oeCi0WJlUlmAdUeOo2uz48KTn4E3vAZHoMZo0EAAkuM=;
        b=Gg5ruBm21DzYEMBQr5TEYEc1ZQ7fUIgBCnTB6MXv3XeOLGNCg7AK+0aaUv6X+C40FB
         C1AgAN7/vfAEFz4C/EyjuyR88RWUdMSq/FXBwWFCXhdOWL8IPNPkzGYF+pCIin34BV0Q
         UT8Y3bBcpR7hia7BFnmou2ARRH3YINHkaijaw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=oeCi0WJlUlmAdUeOo2uz48KTn4E3vAZHoMZo0EAAkuM=;
        b=RqhayMVcEaywZClDJPocxFqyVkBFzAvEcs1eyE8N4mNmGKLAj9Wrpo/XGsA/qFQRJe
         Uh8N4Q/2KQv9ZfWvPYzC4YVErXb1f9ayRG0ZQis+8tB0x7ru8gVftz6afB8Ac3Zxyqm1
         AhuG7VlNBs+b0Lp9SdBzE/rDr4qOEsStnpmFq5Ixv2kezvY8+gIvtr6W7dowlufonO4l
         ZqEHG/+TREroUydPIxJfUceq3sxOsfxMlZ159oejmINNMPmycVA2K0kIq0uWtFsU46oa
         573JuuPP43HWEeVaNqfo0z50vbad5TFiBWwqjlz368Qg3CruterkqsjPFOL97iBSle0U
         +42Q==
X-Gm-Message-State: AOAM532vKwePv8g8C6vmT+iorQXvr8takPWqI7IzFh+k6Pwwsk0RtWlE
        ktBjlWmpJUhilcvHWqO05fgeow==
X-Google-Smtp-Source: ABdhPJyUzAvAcObjVB4Zo5k4rHClZd9eDGKJQyfMV136Sx5Gz+UmKUekLEwGYz0lD6keoGn5yEv++A==
X-Received: by 2002:aa7:8888:0:b0:50f:2e7a:76b7 with SMTP id z8-20020aa78888000000b0050f2e7a76b7mr4747567pfe.48.1651860462705;
        Fri, 06 May 2022 11:07:42 -0700 (PDT)
Received: from localhost ([2620:15c:202:201:5605:d5cd:699b:1b26])
        by smtp.gmail.com with UTF8SMTPSA id y10-20020a170902d64a00b0015e8d4eb2d8sm2031674plh.290.2022.05.06.11.07.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 May 2022 11:07:42 -0700 (PDT)
Date:   Fri, 6 May 2022 11:07:41 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Sibi Sankar <quic_sibis@quicinc.com>
Cc:     bjorn.andersson@linaro.org, arnd@arndb.de,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        sboyd@kernel.org, agross@kernel.org,
        linux-remoteproc@vger.kernel.org, mathieu.poirier@linaro.org
Subject: Re: [PATCH] remoteproc: qcom_q6v5_mss: map/unmap metadata region
 before/after use
Message-ID: <YnVj7fxUbTqkJpdz@google.com>
References: <1651845086-16535-1-git-send-email-quic_sibis@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1651845086-16535-1-git-send-email-quic_sibis@quicinc.com>
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 06, 2022 at 07:21:26PM +0530, Sibi Sankar wrote:
> The application processor accessing the dynamically assigned metadata
> region after assigning it to the remote Q6 would lead to an XPU violation.
> Fix this by un-mapping the metadata region post firmware header copy. The
> metadata region is freed only after the modem Q6 is done with fw header
> authentication.
> 
> Signed-off-by: Sibi Sankar <quic_sibis@quicinc.com>

Should this have a 'Fixes:' tag?

> ---
>  drivers/remoteproc/qcom_q6v5_mss.c | 43 +++++++++++++++++++++++++++++++-------
>  1 file changed, 35 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/remoteproc/qcom_q6v5_mss.c b/drivers/remoteproc/qcom_q6v5_mss.c
> index af217de75e4d..eb34a258b67b 100644
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
> -		kfree(metadata);
> +	page = dma_alloc_attrs(qproc->dev, size, &phys, GFP_KERNEL, dma_attrs);
> +	if (!page) {
>  		dev_err(qproc->dev, "failed to allocate mdt buffer\n");
> -		return -ENOMEM;
> +		ret = -ENOMEM;
> +		goto free_metadata;
> +	}
> +
> +	count = PAGE_ALIGN(size) >> PAGE_SHIFT;
> +	pages = kmalloc_array(count, sizeof(struct page *), GFP_KERNEL);
> +	if (!pages) {
> +		ret = -ENOMEM;
> +		goto free_metadata;
>  	}
>  
> -	memcpy(ptr, metadata, size);
> +	for (i = 0; i < count; i++)
> +		pages[i] = nth_page(page, i);
> +
> +	vaddr = vmap(pages, count, flags, dma_pgprot(qproc->dev, PAGE_KERNEL, dma_attrs));
> +	kfree(pages);
> +	if (!vaddr) {
> +		dev_err(qproc->dev, "unable to map memory region: %pa+%zx\n", &phys, size);
> +		ret = -EBUSY;
> +		goto free_metadata;
> +	}
> +
> +	memcpy(vaddr, metadata, size);
> +
> +	vunmap(vaddr);
>  
>  	/* Hypervisor mapping to access metadata by modem */
>  	mdata_perm = BIT(QCOM_SCM_VMID_HLOS);
> @@ -982,7 +1008,8 @@ static int q6v5_mpss_init_image(struct q6v5 *qproc, const struct firmware *fw,
>  			 "mdt buffer not reclaimed system may become unstable\n");
>  
>  free_dma_attrs:
> -	dma_free_attrs(qproc->dev, size, ptr, phys, dma_attrs);
> +	dma_free_attrs(qproc->dev, size, page, phys, dma_attrs);
> +free_metadata:
>  	kfree(metadata);
>  
>  	return ret < 0 ? ret : 0;
> -- 
> 2.7.4
> 
