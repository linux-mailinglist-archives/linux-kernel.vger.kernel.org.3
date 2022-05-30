Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57BF95386AA
	for <lists+linux-kernel@lfdr.de>; Mon, 30 May 2022 19:17:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239715AbiE3RRh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 May 2022 13:17:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234420AbiE3RRf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 May 2022 13:17:35 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDB2057139
        for <linux-kernel@vger.kernel.org>; Mon, 30 May 2022 10:17:33 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id j6so11024745pfe.13
        for <linux-kernel@vger.kernel.org>; Mon, 30 May 2022 10:17:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=v32XyTzYwEZ6CcA55bpkB++VCp4n/aQDrKIUuhlqtLw=;
        b=u8TAtGuCUdK5voRyLmSukH8SoKS84J0lPAzQOXpDnxNjtGSZx/CKLZoB1SKoIiLm/f
         3ayEBaewDh2Z/9oyMweEy7IIRXL0/ESm4yT4+SecscYeXmjCMz8RRZiA5UoYRRBnnsbk
         wVvx9+KOQ21oyra6V3KMk+gXh+ugrpxAwlYZ/Fn4pybFHLYnR+x26JOnkurJfLYg13WX
         MIRhlS6alU+wurnKCOTj5JfIMP5JBzG43jvpsVVDCyDXQnoKWfL6i+J22mb0zd4M5ZlR
         5Wu1lY3zCyzdQ+x8sHB5w3MwQNnDwU2l8K51shptwZtFLg0TqfDYiPN+gxT3WHUYCO1G
         W+1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=v32XyTzYwEZ6CcA55bpkB++VCp4n/aQDrKIUuhlqtLw=;
        b=apn6SGdHj66ScXtsyWbxoOYBveLbLl+uDFpiHpaGI+67mjBMi4c3bm+uY8SIXXZybR
         wmpuxLtntSwS6bSNPUyT1GCU0oAxNVM309sLouDFeDK9DIqfbgKBrX0u41RRFiT/2R3i
         +YiMYJcZyIV0Tw0bPWlfnxQfiLuutIOFTcpbrOCtgBF965qQUnfGG1cwCZeFuEXLotRu
         m2CsQqtLKIV++ncEtgJNbZgiRtlENqdTZQdAaR5nccvKoZu1rccxzT3pqJpHoyWbr/mN
         xBo23Oc/8CzZnFicTlD2ybCbEUaFWYmBlGMTqbXOcGWftQcVQ5vqPVN2WhyNKfCb7nGj
         eAKA==
X-Gm-Message-State: AOAM531S88/HyEE4eqBuDxO7q7UIf3jddEbTDzCRmFS1TM0IrU226BjL
        gHH6tJMvSkoAg7hLU4qkZuIYRg==
X-Google-Smtp-Source: ABdhPJwCr4F4DOh6HBx4KBklJyG6sO2vY56x0JQAK8vbbspV4akagYbYnfnULot7a4R+5hXyEDDnJg==
X-Received: by 2002:a63:63c7:0:b0:3f5:faf8:c45e with SMTP id x190-20020a6363c7000000b003f5faf8c45emr49893892pgb.234.1653931053461;
        Mon, 30 May 2022 10:17:33 -0700 (PDT)
Received: from p14s (S0106889e681aac74.cg.shawcable.net. [68.147.0.187])
        by smtp.gmail.com with ESMTPSA id h22-20020a170902ac9600b00163ed0931b7sm1855644plr.302.2022.05.30.10.17.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 May 2022 10:17:31 -0700 (PDT)
Date:   Mon, 30 May 2022 11:17:28 -0600
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc:     bjorn.andersson@linaro.org, arnaud.pouliquen@foss.st.com,
        linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        peng.fan@nxp.com
Subject: Re: [PATCH V4 1/2] remoteproc: introduce rproc features
Message-ID: <20220530171728.GA482330@p14s>
References: <20220323034405.976643-1-peng.fan@oss.nxp.com>
 <20220323034405.976643-2-peng.fan@oss.nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220323034405.976643-2-peng.fan@oss.nxp.com>
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

On Wed, Mar 23, 2022 at 11:44:04AM +0800, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> remote processor may support:
>  - firmware recovery with help from main processor
>  - self recovery without help from main processor
>  - iommu
>  - etc
> 
> Introduce rproc features could simplify code to avoid adding more bool
> flags
> 
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>  drivers/remoteproc/remoteproc_internal.h | 10 ++++++++++
>  include/linux/remoteproc.h               |  7 +++++++
>  2 files changed, 17 insertions(+)
> 
> diff --git a/drivers/remoteproc/remoteproc_internal.h b/drivers/remoteproc/remoteproc_internal.h
> index 72d4d3d7d94d..e9ae743c5587 100644
> --- a/drivers/remoteproc/remoteproc_internal.h
> +++ b/drivers/remoteproc/remoteproc_internal.h
> @@ -24,6 +24,16 @@ struct rproc_debug_trace {
>  	struct rproc_mem_entry trace_mem;
>  };
>  
> +static inline bool rproc_has_feature(struct rproc *rproc, unsigned int feature)
> +{
> +	return test_bit(feature, rproc->features);
> +}
> +
> +static inline void rproc_set_feature(struct rproc *rproc, unsigned int feature)
> +{

I would expect this function to return -EINVAL if feature is >
RPROC_MAX_FEATURES.

> +	set_bit(feature, rproc->features);
> +}
> +
>  /* from remoteproc_core.c */
>  void rproc_release(struct kref *kref);
>  irqreturn_t rproc_vq_interrupt(struct rproc *rproc, int vq_id);
> diff --git a/include/linux/remoteproc.h b/include/linux/remoteproc.h
> index 7c943f0a2fc4..7847c6b10a69 100644
> --- a/include/linux/remoteproc.h
> +++ b/include/linux/remoteproc.h
> @@ -489,6 +489,11 @@ struct rproc_dump_segment {
>  	loff_t offset;
>  };
> 

Please add proper kernel documentation.

> +enum rproc_features {
> +	RPROC_FEAT_ATTACH_RECOVERY,

s/RPROC_FEAT_ATTACH_RECOVERY/RPROC_FEAT_ATTACH_ON_RECOVERY

> +	RPROC_MAX_FEATURES,
> +};
> +
>  /**
>   * struct rproc - represents a physical remote processor device
>   * @node: list node of this rproc object
> @@ -530,6 +535,7 @@ struct rproc_dump_segment {
>   * @elf_machine: firmware ELF machine
>   * @cdev: character device of the rproc
>   * @cdev_put_on_release: flag to indicate if remoteproc should be shutdown on @char_dev release
> + * @features: indicate remoteproc features
>   */
>  struct rproc {
>  	struct list_head node;
> @@ -570,6 +576,7 @@ struct rproc {
>  	u16 elf_machine;
>  	struct cdev cdev;
>  	bool cdev_put_on_release;
> +	DECLARE_BITMAP(features, RPROC_MAX_FEATURES);
>  };
>  
>  /**
> -- 
> 2.25.1
> 
