Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C877563F4F
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Jul 2022 11:44:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232079AbiGBJob (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Jul 2022 05:44:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232033AbiGBJo3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Jul 2022 05:44:29 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 37C9013E98
        for <linux-kernel@vger.kernel.org>; Sat,  2 Jul 2022 02:44:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1656755067;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EkncoZo4fSfWKZyfeSpaR0K8SUXZs4qQntp3fAHOyD0=;
        b=KwWQrEyDzUinFPlS2s0bkpo9eAQw70t7O4+rmsSxGIyrSnVUTif6haJoqu5la1Ql1UyVaH
        YB7/asmVwHmiAteZK+tGobJK2arm9eD71SeelJfaFacwT+wSv1O0x+JliUZaTISjCpLDV5
        c8iH7xlHENlmS9FFg0kqY8dsUsAoJIM=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-627-AHZeDQLtO0GaKTsxV4TdFQ-1; Sat, 02 Jul 2022 05:44:26 -0400
X-MC-Unique: AHZeDQLtO0GaKTsxV4TdFQ-1
Received: by mail-ed1-f69.google.com with SMTP id i9-20020a05640242c900b004373cd1c4d5so3394913edc.2
        for <linux-kernel@vger.kernel.org>; Sat, 02 Jul 2022 02:44:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=EkncoZo4fSfWKZyfeSpaR0K8SUXZs4qQntp3fAHOyD0=;
        b=OtGBs5klDEseLdNWZLR5SJRI6P/Z9bqcqZCTvAUjG7ev1BxCNgyEuPF/dJAmKJC/BC
         uokaV8CHOHlLqLsbebFPZgqkigFDhey6P8mCYNDgccYHh1o4vihbbiXSmS6308lDGQHJ
         YIjjOicn+BVkpouecsKoITpQk7vZAO+Wo/E9Ccj66//Tl+PAthG5InPvEtLPrq55YEos
         0xwmGmArd59yK0CkAQeZyqKKIWuAmDHpuOK/a3mV2lL67jhoU40Fz/T0f91oZU9sVeTi
         +HKmb+yWT/svRsulGEjFlfhMBk1i6+nRWMZ4Rlg0e9wJjKqJwJt5X2Ph0Gnj56nyPFqm
         giYg==
X-Gm-Message-State: AJIora+nzxs9cG5w+T02N7NAz2WPw3Dgueppfg8VCVPz1aEMTl4liBxK
        YWVbcv2f43Ih/G1P13/WTAw93WuTkZUlLq1UloqHP/islID3pNWdpl3uh2HGwdNAUoAOyuDhJ8N
        KT4oml1RjRXSF+CSZ42wB0cC9
X-Received: by 2002:a17:907:3f8d:b0:726:2ab9:f2fc with SMTP id hr13-20020a1709073f8d00b007262ab9f2fcmr18725099ejc.313.1656755064922;
        Sat, 02 Jul 2022 02:44:24 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1s8sw6ek35qgaYjnBW4sVHkV40TbvJjgm7Y3qBTfseFvTQVsPB2spIQ604ZBmJyjulhxK7lug==
X-Received: by 2002:a17:907:3f8d:b0:726:2ab9:f2fc with SMTP id hr13-20020a1709073f8d00b007262ab9f2fcmr18725084ejc.313.1656755064675;
        Sat, 02 Jul 2022 02:44:24 -0700 (PDT)
Received: from [192.168.43.127] ([109.38.147.70])
        by smtp.gmail.com with ESMTPSA id b3-20020a17090636c300b00726b8e84c1asm6994694ejc.21.2022.07.02.02.44.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 02 Jul 2022 02:44:23 -0700 (PDT)
Message-ID: <2604d622-08b7-e517-b423-73e38dc5b286@redhat.com>
Date:   Sat, 2 Jul 2022 11:44:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v2] platform/x86: ISST: PUNIT device mapping with Sub-NUMA
 clustering
Content-Language: en-US
To:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        markgross@kernel.org
Cc:     platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220629194817.2418240-1-srinivas.pandruvada@linux.intel.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20220629194817.2418240-1-srinivas.pandruvada@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 6/29/22 21:48, Srinivas Pandruvada wrote:
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
> While here, use defines for max bus number instead of hardcoding.
> 
> Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

Thank you for your patch, I've applied this patch to my review-hans 
branch:
https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git/log/?h=review-hans

Note it will show up in my review-hans branch once I've pushed my
local branch there, which might take a while.

Once I've run some tests on this branch the patches there will be
added to the platform-drivers-x86/for-next branch and eventually
will be included in the pdx86 pull-request to Linus for the next
merge-window.

Regards,

Hans


> ---
> v2
> - Use #define for max bus number and use
> 
>  .../intel/speed_select_if/isst_if_common.c    | 39 +++++++++++++++----
>  1 file changed, 32 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/platform/x86/intel/speed_select_if/isst_if_common.c b/drivers/platform/x86/intel/speed_select_if/isst_if_common.c
> index e8424e70d81d..fd102678c75f 100644
> --- a/drivers/platform/x86/intel/speed_select_if/isst_if_common.c
> +++ b/drivers/platform/x86/intel/speed_select_if/isst_if_common.c
> @@ -277,29 +277,38 @@ static int isst_if_get_platform_info(void __user *argp)
>  	return 0;
>  }
>  
> +#define ISST_MAX_BUS_NUMBER	2
>  
>  struct isst_if_cpu_info {
>  	/* For BUS 0 and BUS 1 only, which we need for PUNIT interface */
> -	int bus_info[2];
> -	struct pci_dev *pci_dev[2];
> +	int bus_info[ISST_MAX_BUS_NUMBER];
> +	struct pci_dev *pci_dev[ISST_MAX_BUS_NUMBER];
>  	int punit_cpu_id;
>  	int numa_node;
>  };
>  
> +struct isst_if_pkg_info {
> +	struct pci_dev *pci_dev[ISST_MAX_BUS_NUMBER];
> +};
> +
>  static struct isst_if_cpu_info *isst_cpu_info;
> +static struct isst_if_pkg_info *isst_pkg_info;
> +
>  #define ISST_MAX_PCI_DOMAINS	8
>  
>  static struct pci_dev *_isst_if_get_pci_dev(int cpu, int bus_no, int dev, int fn)
>  {
>  	struct pci_dev *matched_pci_dev = NULL;
>  	struct pci_dev *pci_dev = NULL;
> -	int no_matches = 0;
> +	int no_matches = 0, pkg_id;
>  	int i, bus_number;
>  
> -	if (bus_no < 0 || bus_no > 1 || cpu < 0 || cpu >= nr_cpu_ids ||
> -	    cpu >= num_possible_cpus())
> +	if (bus_no < 0 || bus_no >= ISST_MAX_BUS_NUMBER || cpu < 0 ||
> +	    cpu >= nr_cpu_ids || cpu >= num_possible_cpus())
>  		return NULL;
>  
> +	pkg_id = topology_physical_package_id(cpu);
> +
>  	bus_number = isst_cpu_info[cpu].bus_info[bus_no];
>  	if (bus_number < 0)
>  		return NULL;
> @@ -324,6 +333,8 @@ static struct pci_dev *_isst_if_get_pci_dev(int cpu, int bus_no, int dev, int fn
>  		}
>  
>  		if (node == isst_cpu_info[cpu].numa_node) {
> +			isst_pkg_info[pkg_id].pci_dev[bus_no] = _pci_dev;
> +
>  			pci_dev = _pci_dev;
>  			break;
>  		}
> @@ -342,6 +353,10 @@ static struct pci_dev *_isst_if_get_pci_dev(int cpu, int bus_no, int dev, int fn
>  	if (!pci_dev && no_matches == 1)
>  		pci_dev = matched_pci_dev;
>  
> +	/* Return pci_dev pointer for any matched CPU in the package */
> +	if (!pci_dev)
> +		pci_dev = isst_pkg_info[pkg_id].pci_dev[bus_no];
> +
>  	return pci_dev;
>  }
>  
> @@ -361,8 +376,8 @@ struct pci_dev *isst_if_get_pci_dev(int cpu, int bus_no, int dev, int fn)
>  {
>  	struct pci_dev *pci_dev;
>  
> -	if (bus_no < 0 || bus_no > 1 || cpu < 0 || cpu >= nr_cpu_ids ||
> -	    cpu >= num_possible_cpus())
> +	if (bus_no < 0 || bus_no >= ISST_MAX_BUS_NUMBER  || cpu < 0 ||
> +	    cpu >= nr_cpu_ids || cpu >= num_possible_cpus())
>  		return NULL;
>  
>  	pci_dev = isst_cpu_info[cpu].pci_dev[bus_no];
> @@ -417,10 +432,19 @@ static int isst_if_cpu_info_init(void)
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
> @@ -433,6 +457,7 @@ static int isst_if_cpu_info_init(void)
>  static void isst_if_cpu_info_exit(void)
>  {
>  	cpuhp_remove_state(isst_if_online_id);
> +	kfree(isst_pkg_info);
>  	kfree(isst_cpu_info);
>  };
>  

