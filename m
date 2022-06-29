Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5566C55FB91
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 11:16:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232558AbiF2JOa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 05:14:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229534AbiF2JO2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 05:14:28 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A69927B36
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jun 2022 02:14:27 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id v9so5835912wrp.7
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jun 2022 02:14:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=U+mKfaGXoONCznFgzmYIZny9AKkMWKoWt6b7S8f60RM=;
        b=fEDY3d9nvND9FB+yUl1AlWKqmdRimCwOi50i1qa9A3DKppiVdL0evazSl+CYovnpPb
         +xe7MhtHEIdRd/hU3l/ogn7sAWDlJUBLc392CjdJtrSQfAf0m+yIkjQ5Ga6atX/HRS7q
         yWgmVnPRgemnHBcUGxlhsY3DN9UnUcJt1/h9p3fpOkxCpxOj0Ckew4iqSSylcCqnElDa
         AVau4GSEu7q/4s2ZTilxBRERa7+HplvcEVjMmlivdXoSG5lnUC7moEqfpj1JhEbdYSXx
         6MUxFw9BPh4JT9OYAiLOGKncNm/n7RARaGhuCY/YcqnhEA2h4qe0OikedNdDbvVg1I8b
         JqNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=U+mKfaGXoONCznFgzmYIZny9AKkMWKoWt6b7S8f60RM=;
        b=CYXWKz5gBuX96xIjFg5BmoT4JgpRk6xJ7LBG1XXFU1JA5Vo+xQs8isY0YMOIE8huzK
         7H/3Gw02fN6gRHNeVwVAAb9z2MUJ+qFjNdIrO3ax1GYgdKXCbTF4xPf04UyHJ0azlWpG
         zXdvjTTsfHbLmlw3JtPYtjPWiiFbljHaEXamL+RSch12LIvd65QCBVVoVFEy2OLJDdIZ
         iYF8kX/rf9JaJ7KwQFO9P9de+XobGWVUbZy4oLI3TSnE47LzaGO1MFn9LvzgNJNdlhDv
         QV3JQ2MjgLXSLEFFCHnwzqZpFY1L3uoUa3Ff/8x0qdAG/j5wQfG+wdeEumna90q5UDIo
         Ljcg==
X-Gm-Message-State: AJIora8Fie6supqqY0Rpa2P0sAuj1pybmLN2U4PLfV6XNMT7DvZuaueg
        o0l7hC4oDmhCH0Ga4KG9CbgLjg==
X-Google-Smtp-Source: AGRyM1uss6yL9ryGiFhRNXcrE8eBDDu99NbY6sECQMgnEwKtRLT98HuE31fmJMfucgcPw940Fu+20A==
X-Received: by 2002:a5d:4352:0:b0:213:4910:6616 with SMTP id u18-20020a5d4352000000b0021349106616mr2022060wrr.226.1656494065746;
        Wed, 29 Jun 2022 02:14:25 -0700 (PDT)
Received: from myrica (cpc92880-cmbg19-2-0-cust679.5-4.cable.virginm.net. [82.27.106.168])
        by smtp.gmail.com with ESMTPSA id z18-20020a05600c0a1200b0039c45fc58c4sm2440202wmp.21.2022.06.29.02.14.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jun 2022 02:14:25 -0700 (PDT)
Date:   Wed, 29 Jun 2022 10:14:01 +0100
From:   Jean-Philippe Brucker <jean-philippe@linaro.org>
To:     Eric Auger <eric.auger@redhat.com>
Cc:     eric.auger.pro@gmail.com, jroedel@suse.de,
        linux-acpi@vger.kernel.org, iommu@lists.linux-foundation.org,
        rafael@kernel.org, lenb@kernel.org, linux-kernel@vger.kernel.org,
        iommu@lists.linux.dev
Subject: Re: [PATCH] ACPI: VIOT: Fix ACS setup
Message-ID: <YrwX2U48HOC+UF07@myrica>
References: <20220627125534.1035912-1-eric.auger@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220627125534.1035912-1-eric.auger@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Eric,

On Mon, Jun 27, 2022 at 02:55:34PM +0200, Eric Auger wrote:
> Currently acpi_viot_init() gets called after the pci
> device has been scanned and pci_enable_acs() has been called.
> So pci_request_acs() fails to be taken into account leading
> to wrong single iommu group topologies when dealing with
> multi-function root ports for instance.
> 
> We cannot simply move the acpi_viot_init() earlier, similarly
> as the IORT init because the VIOT parsing relies on the pci
> scan. However we can detect VIOT is present earlier and in
> such a case, request ACS. Introduce a new acpi_viot_early_init()
> routine that allows to call pci_request_acs() before the scan.
> 
> Fixes: 3cf485540e7b ("ACPI: Add driver for the VIOT table")
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> Reported-by: Jin Liu <jinl@redhat.com>

Thanks for the fix, the patch makes sense and fixes the issue.

I wondered whether we should keep the logic where we only request ACS if
an IOMMU is found to manage a PCI range, but I can't see any harm in
requesting it regardless (plus there is a precedent with AMD IOMMU).
I could imagine some VMM wanting to only put an IOMMU in front of its MMIO
devices and leave PCI to roam free, but that seems like a stretch.

There is another issue with the existing code, though: we can't call
pci_request_acs() when CONFIG_PCI is disabled because no stub is defined.
Could you wrap the call in an #ifdef?

> ---
>  drivers/acpi/bus.c        |  1 +
>  drivers/acpi/viot.c       | 23 +++++++++++++++++------
>  include/linux/acpi_viot.h |  2 ++
>  3 files changed, 20 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/acpi/bus.c b/drivers/acpi/bus.c
> index 86fa61a21826..906ad8153fd9 100644
> --- a/drivers/acpi/bus.c
> +++ b/drivers/acpi/bus.c
> @@ -1400,6 +1400,7 @@ static int __init acpi_init(void)
>  
>  	pci_mmcfg_late_init();
>  	acpi_iort_init();
> +	acpi_viot_early_init();
>  	acpi_hest_init();
>  	acpi_ghes_init();
>  	acpi_scan_init();
> diff --git a/drivers/acpi/viot.c b/drivers/acpi/viot.c
> index d2256326c73a..3c1be123e4d6 100644
> --- a/drivers/acpi/viot.c
> +++ b/drivers/acpi/viot.c
> @@ -248,6 +248,23 @@ static int __init viot_parse_node(const struct acpi_viot_header *hdr)
>  	return ret;
>  }
>  
> +/**
> + * acpi_viot_early_init - Test the presence of VIOT and enable ACS
> + *
> + * If the VIOT does exist, ACS must be enabled. This cannot be
> + * done in acpi_viot_init() which is called after the bus scan
> + */
> +void __init acpi_viot_early_init(void)
> +{
> +	acpi_status status;
> +	struct acpi_table_header *hdr;
> +
> +	status = acpi_get_table(ACPI_SIG_VIOT, 0, &hdr);
> +	if (!ACPI_FAILURE(status))
> +		pci_request_acs();
> +	acpi_put_table(hdr);

I'd rather not call acpi_put_table() in case of failure. I know it is
handled but it looks fragile and I couldn't find any other user of
acpi_get_table() doing this.

> +}
> +
>  /**
>   * acpi_viot_init - Parse the VIOT table
>   *
> @@ -319,12 +336,6 @@ static int viot_pci_dev_iommu_init(struct pci_dev *pdev, u16 dev_id, void *data)
>  			epid = ((domain_nr - ep->segment_start) << 16) +
>  				dev_id - ep->bdf_start + ep->endpoint_id;
>  
> -			/*
> -			 * If we found a PCI range managed by the viommu, we're
> -			 * the one that has to request ACS.
> -			 */
> -			pci_request_acs();
> -
>  			return viot_dev_iommu_init(&pdev->dev, ep->viommu,
>  						   epid);
>  		}
> diff --git a/include/linux/acpi_viot.h b/include/linux/acpi_viot.h
> index 1eb8ee5b0e5f..e58d60f8ff2e 100644
> --- a/include/linux/acpi_viot.h
> +++ b/include/linux/acpi_viot.h
> @@ -6,10 +6,12 @@
>  #include <linux/acpi.h>
>  
>  #ifdef CONFIG_ACPI_VIOT
> +void __init acpi_viot_early_init(void);
>  void __init acpi_viot_init(void);
>  int viot_iommu_configure(struct device *dev);
>  #else
>  static inline void acpi_viot_init(void) {}
> +static inline void acpi_viot_early_init(void) {}

nit: different declaration order

Thanks,
Jean


>  static inline int viot_iommu_configure(struct device *dev)
>  {
>  	return -ENODEV;
> -- 
> 2.35.3
> 
