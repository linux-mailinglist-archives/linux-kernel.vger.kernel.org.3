Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C99855EF2E
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 22:20:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231921AbiF1UU0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 16:20:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229732AbiF1UUG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 16:20:06 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 302D2393C7
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 13:16:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1656447396;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=w5t2VUZwsXFY0k3oH1xTiBRVlbwES5cmjy0YTjX97qU=;
        b=K+1U+4CQypAxFvnLnZHElrxZCpictsJPxww0OLkzeIiB1ecjKBGTcFDpW5gVwFpIRk6oh9
        90UNJe7otB3U+EYVXAD5VgNAur38o23LttwaGlac4AirT7dY3ZV6NJI9ftJXO48JEACQJz
        J7l1EdsN4UZRemLbMCY+huLTHjzku4Q=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-650-xiaalK1LMjSBDmgNyNO1cg-1; Tue, 28 Jun 2022 16:16:35 -0400
X-MC-Unique: xiaalK1LMjSBDmgNyNO1cg-1
Received: by mail-ed1-f69.google.com with SMTP id h4-20020a056402280400b00435abcf8f2dso10312611ede.3
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 13:16:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=w5t2VUZwsXFY0k3oH1xTiBRVlbwES5cmjy0YTjX97qU=;
        b=X8Dp0KLhgWMsm/xDIIff3O3EhJ5yGppDXD5lMBS9UfBrjlAbwkPfGJvS4JcVpo2vpm
         aOkT6yzSMHq/8cOOk6Uhotj0EDi2L3NNzucsqlXd/ddhpvfElPop484St14UzYN4ofGX
         phLXX94tlRMHqmmX4ktKHjtvSgTcng9OIvltZMTYoaGVa0w6Hicm60wPQjx6N3X8hCKd
         EF2P3TdrM3Bd3qZ8RTsyZxjsfKzum7pi1KYb1pcZP21aK4dk1ei055FXOlYIJB24DtqI
         tO0ug6RwXYbdFjz5GvT6fjVOAAX0ayxUElTraNibHc51kC5nkCwEcar5+NlJmWg2oDk2
         S9mg==
X-Gm-Message-State: AJIora8eCmB4clr6kL/sgofCiYwP2LqiJ3ShFCb2Mp43fJGIpjuqQvl4
        9/CLw0bGUsYDeS8Y0B320r0LOVZvdwKQsAC331lvpWKYh/mEEb2lP6ioS1suKfayZtmxmQuC9jT
        JFFsU/LgELpLrGf954JzrXV/5
X-Received: by 2002:a17:906:478e:b0:722:fc31:aa13 with SMTP id cw14-20020a170906478e00b00722fc31aa13mr19710299ejc.84.1656447393683;
        Tue, 28 Jun 2022 13:16:33 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1vhAi45OuzkkoS/wShPDoNWffVDzr7aH4KbVApKSA+zXAsAoWeU15s+bMfn/r9ynQUhwNmp/g==
X-Received: by 2002:a17:906:478e:b0:722:fc31:aa13 with SMTP id cw14-20020a170906478e00b00722fc31aa13mr19710277ejc.84.1656447393398;
        Tue, 28 Jun 2022 13:16:33 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c1e:bf00:d69d:5353:dba5:ee81? (2001-1c00-0c1e-bf00-d69d-5353-dba5-ee81.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:d69d:5353:dba5:ee81])
        by smtp.gmail.com with ESMTPSA id h26-20020aa7c61a000000b00435cfa7c6f5sm9979349edq.46.2022.06.28.13.16.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Jun 2022 13:16:32 -0700 (PDT)
Message-ID: <b292bb64-edf9-81b3-b66d-b6c696b8deec@redhat.com>
Date:   Tue, 28 Jun 2022 22:16:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH] platform/x86: ISST: PUNIT device mapping with Sub-NUMA
 clustering
Content-Language: en-US
To:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        markgross@kernel.org
Cc:     platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220627215031.2158825-1-srinivas.pandruvada@linux.intel.com>
From:   Hans de Goede <hdegoede@redhat.com>
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

