Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A09D355FCBF
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 12:01:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232223AbiF2KBB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 06:01:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231942AbiF2KA6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 06:00:58 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3B9523DA69
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jun 2022 03:00:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1656496854;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=w5t2VUZwsXFY0k3oH1xTiBRVlbwES5cmjy0YTjX97qU=;
        b=A2VzX3hoq6wh9QJ4cHBcYN00VO+LIIV6KAe/mMZdEn4zq6VWWeT8OfcX0seB9dMc4vwz5e
        FkK8M4dE4x9uQ6ovQPKGUd3z2xagYEf5tdi9xY8XIylRzI2v0CdDGgl61eK/HtEDqtrDBA
        56o4FQgVlIKxjOBQvwwZChDOJTDhrTI=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-640-QtBvwQyENfS7r5GjVI1CVA-1; Wed, 29 Jun 2022 06:00:53 -0400
X-MC-Unique: QtBvwQyENfS7r5GjVI1CVA-1
Received: by mail-ed1-f69.google.com with SMTP id n8-20020a05640205c800b00434fb0c150cso11468687edx.19
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jun 2022 03:00:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:from
         :subject:to:cc:references:content-language:in-reply-to
         :content-transfer-encoding;
        bh=w5t2VUZwsXFY0k3oH1xTiBRVlbwES5cmjy0YTjX97qU=;
        b=P8nEdJ6j8V1tSH/p2syHi6kMgjBrFT6ZLKsspQwXUFAuN8yIxdILX9H9on99+aPvPX
         bTbCH7ESrDvoHcKf3gul/CqqiL7coBDIpmW3KnYwl9K1aBW2SfEXrUECL9xn+8i5ena2
         obF5pmWEdEkd+hNk6rn1BXn5vysKjbaZIH+F44NMko9UI+3cwaMog9/NWi/NIFt3wpct
         Y5W7hoyVdiItmUGk9gJEm1rBm7CsCqHgwjFUIk3JdmWXNNg8nvKgQAoPf13peK5Hmcbw
         cgunV4l6qCwYQPrJQWMiOTXmtyNNWXAxVpEwXoiUlaJZlpF+EixR2frjBMGx0h6R+ziO
         raAw==
X-Gm-Message-State: AJIora+rjX44p3rHm6/YqXv75Uvb1ekHo6QzPQ4QMXvLNNLGgUj5T7H0
        eSKN1hc6ceLVfo+KocUW2g6Em81fqfSw0SYL4gR+C+DhQ/fbdG5sRcyPp+bEBJ1/Q56L+6+nHkG
        ox1TCpaQ4Q+yOmncEiTVyF2Xi
X-Received: by 2002:a17:907:6e90:b0:726:a767:e542 with SMTP id sh16-20020a1709076e9000b00726a767e542mr2494683ejc.746.1656496851907;
        Wed, 29 Jun 2022 03:00:51 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1tNLYNaiC/3EpWcFKIqQEyZzV9a1LOWijci1Fy3ZSisNtP7NU03Ket7XZxbKIjhAdvso3tk5g==
X-Received: by 2002:a17:907:6e90:b0:726:a767:e542 with SMTP id sh16-20020a1709076e9000b00726a767e542mr2494667ejc.746.1656496851697;
        Wed, 29 Jun 2022 03:00:51 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c1e:bf00:d69d:5353:dba5:ee81? (2001-1c00-0c1e-bf00-d69d-5353-dba5-ee81.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:d69d:5353:dba5:ee81])
        by smtp.gmail.com with ESMTPSA id s1-20020aa7c541000000b004357171dcccsm11065514edr.12.2022.06.29.03.00.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Jun 2022 03:00:51 -0700 (PDT)
Message-ID: <55a6470c-1ce5-b237-d3be-1b98e4dbe3ce@redhat.com>
Date:   Wed, 29 Jun 2022 12:00:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
From:   Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH] platform/x86: ISST: PUNIT device mapping with Sub-NUMA
 clustering
To:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        markgross@kernel.org
Cc:     platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220627215031.2158825-1-srinivas.pandruvada@linux.intel.com>
Content-Language: en-US
In-Reply-To: <20220627215031.2158825-1-srinivas.pandruvada@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 6/27/22 23:50, Srinivas Pandruvada wrote:
> On a multiple package system using Sub-NUMA clustering, there is an issue
> in mapping Linux CPU number to PUNIT PCI device when manufacturer decided
> to reuse the PCI bus number across packages. Bus number can be reused as
> long as they are in different domain or segment. In this case some CPU
> will fail to find a PCI device to issue SST requests.
> 
> When bus numbers are reused across CPU packages, we are using proximity
> information by matching CPU numa node id to PUNIT PCI device numa node
> id. But on a package there can be only one PUNIT PCI device, but multiple
> numa nodes (one for each sub cluster). So, the numa node ID of the PUNIT
> PCI device can only match with one numa node id of CPUs in a sub cluster
> in the package.
> 
> Since there can be only one PUNIT PCI device per package, if we match
> with numa node id of any sub cluster in that package, we can use that
> mapping for any CPU in that package. So, store the match information
> in a per package data structure and return the information when there
> is no match.
> 
> Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> ---
>  .../intel/speed_select_if/isst_if_common.c    | 22 +++++++++++++++++++
>  1 file changed, 22 insertions(+)
> 
> diff --git a/drivers/platform/x86/intel/speed_select_if/isst_if_common.c b/drivers/platform/x86/intel/speed_select_if/isst_if_common.c
> index e8424e70d81d..f3cd1be3283a 100644
> --- a/drivers/platform/x86/intel/speed_select_if/isst_if_common.c
> +++ b/drivers/platform/x86/intel/speed_select_if/isst_if_common.c
> @@ -286,11 +286,18 @@ struct isst_if_cpu_info {
>  	int numa_node;
>  };
>  
> +struct isst_if_pkg_info {
> +	struct pci_dev *pci_dev[2];

This and (continued below) ...

> +};
> +
>  static struct isst_if_cpu_info *isst_cpu_info;
> +static struct isst_if_pkg_info *isst_pkg_info;
> +
>  #define ISST_MAX_PCI_DOMAINS	8
>  
>  static struct pci_dev *_isst_if_get_pci_dev(int cpu, int bus_no, int dev, int fn)
>  {
> +	int pkg_id = topology_physical_package_id(cpu);
>  	struct pci_dev *matched_pci_dev = NULL;
>  	struct pci_dev *pci_dev = NULL;
>  	int no_matches = 0;
> @@ -324,6 +331,8 @@ static struct pci_dev *_isst_if_get_pci_dev(int cpu, int bus_no, int dev, int fn
>  		}
>  
>  		if (node == isst_cpu_info[cpu].numa_node) {
> +			isst_pkg_info[pkg_id].pci_dev[bus_no] = _pci_dev;
> +

This and ...

>  			pci_dev = _pci_dev;
>  			break;
>  		}
> @@ -342,6 +351,9 @@ static struct pci_dev *_isst_if_get_pci_dev(int cpu, int bus_no, int dev, int fn
>  	if (!pci_dev && no_matches == 1)
>  		pci_dev = matched_pci_dev;
>  
> +	if (!pci_dev)
> +		pci_dev = isst_pkg_info[pkg_id].pci_dev[bus_no];
> +

This assumes that bus_no is never > 1, is this assumption enforced somewhere?

Also maybe make the 2 in:

> +struct isst_if_pkg_info {
> +	struct pci_dev *pci_dev[2];

a #define ?

Regards,

Hans


>  	return pci_dev;
>  }
>  
> @@ -417,10 +429,19 @@ static int isst_if_cpu_info_init(void)
>  	if (!isst_cpu_info)
>  		return -ENOMEM;
>  
> +	isst_pkg_info = kcalloc(topology_max_packages(),
> +				sizeof(*isst_pkg_info),
> +				GFP_KERNEL);
> +	if (!isst_pkg_info) {
> +		kfree(isst_cpu_info);
> +		return -ENOMEM;
> +	}
> +
>  	ret = cpuhp_setup_state(CPUHP_AP_ONLINE_DYN,
>  				"platform/x86/isst-if:online",
>  				isst_if_cpu_online, NULL);
>  	if (ret < 0) {
> +		kfree(isst_pkg_info);
>  		kfree(isst_cpu_info);
>  		return ret;
>  	}
> @@ -433,6 +454,7 @@ static int isst_if_cpu_info_init(void)
>  static void isst_if_cpu_info_exit(void)
>  {
>  	cpuhp_remove_state(isst_if_online_id);
> +	kfree(isst_pkg_info);
>  	kfree(isst_cpu_info);
>  };
>  

