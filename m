Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC5B14DBC22
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 02:16:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356141AbiCQBRN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Mar 2022 21:17:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353456AbiCQBRK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Mar 2022 21:17:10 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAF891D326
        for <linux-kernel@vger.kernel.org>; Wed, 16 Mar 2022 18:15:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647479754; x=1679015754;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=CYlKqJNbf6Etus+zXzC/ctirfR6jdDggKgvDEL/BkjQ=;
  b=mTuheNQTbm5NRAPzR28Cs+/Qj+10wXyhbrhFLcBT7U+5x8D6SF7kO7eP
   25QCE93NUVuRbR4Hzsx+qqF2FnZuHdy82guocRPubKFxNWdYez+6hFI69
   nXFj9E/qLjzyJSm8uGZc0LZIb+OHXvby8xFiVjSpJr6do2ortncJ1zkFn
   57zuOI6agey38FyVbPNErGwUvGNTPlacGX6dOcl3RW3V6w7ROUaLm1xzA
   ZIWbnqdpQ9mr/7mxxd09IuKDuo9m1s6sJsL1ssj9cJoQEk8th380jcVL3
   q1Hk/dUZUnLAKrg2C3uo6LasZNF+8E+W5cCjMoFKL7ztwJtuxBqVM00yS
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10288"; a="237360753"
X-IronPort-AV: E=Sophos;i="5.90,188,1643702400"; 
   d="scan'208";a="237360753"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2022 18:15:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,188,1643702400"; 
   d="scan'208";a="646871467"
Received: from fmsmsx606.amr.corp.intel.com ([10.18.126.86])
  by orsmga004.jf.intel.com with ESMTP; 16 Mar 2022 18:15:53 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx606.amr.corp.intel.com (10.18.126.86) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Wed, 16 Mar 2022 18:15:53 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21 via Frontend Transport; Wed, 16 Mar 2022 18:15:53 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.40) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.21; Wed, 16 Mar 2022 18:15:52 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WhKHR/KFd5DWVBvrs28C9tNRuIud+HlVPQ514tqb212vqVlYkzCmEtPq2RUOXDxWnb//5QsCRmnbe7dp6H8w13ux/GR5KOPdCZtDcHvqQrohHu56ViefPMgjNIzd/yUt18bTFgfKzyxH38fMEuvUvkZvctAwcaZUelP8ugBT8Lkot+hGb7G+AMlN5ly8JwsFbSrVrAhmFBY8b5WmA/GSfHI02tLK34DqimIx3SBNLvXFzql1saIjh1tHh8Ach8LLqWsY8UitRqu3z2W+9zpbytRVPl6GJ2yFzQ8IPlvJeq84Tm8jXRs/v90I/rUOpuecqHdi0p7eXCcQYuB19Xrrow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BDMXEU8Q818QqKj7neBdFvQrNr3A4L46YL2oPmoV0VY=;
 b=dAJSBonb6lKpQNz3pdQwMKmlqE7Q7TCvuXI0fP1/rfUnBGbMdpxreRdnVw9br9FYfi2LPFvn8KUJgA4mPQ/mJX7e1me5grPFCsSQvTa/byFaHiCc21zPgTiYP7kRd4kQLVGlQqsjcRb/2+ITCNcPn3DcopNUCu/W0KqystL+abYxhhFrLu6A/YD6a3V5tzsjsn+EKzbsmQeOEt7DpiokVdYqQ6lb6Nrfx3JIPxwTn2IQoniJ/fZCXSXZ/GJgMX834rD5uiLLnp1bCmCPpEa3I1zWVpCVcDeyFiDxdhUljWHBoeBmUn25orEd0JOMnlKoP3kf+cd3ix5j6ZO1eBG69A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB5488.namprd11.prod.outlook.com (2603:10b6:5:39d::5) by
 SN6PR11MB2750.namprd11.prod.outlook.com (2603:10b6:805:54::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5081.15; Thu, 17 Mar 2022 01:15:50 +0000
Received: from DM4PR11MB5488.namprd11.prod.outlook.com
 ([fe80::3c4e:eb25:76ff:a869]) by DM4PR11MB5488.namprd11.prod.outlook.com
 ([fe80::3c4e:eb25:76ff:a869%4]) with mapi id 15.20.5081.016; Thu, 17 Mar 2022
 01:15:50 +0000
Message-ID: <a4a51156-3b82-5048-491c-ecf278609d62@intel.com>
Date:   Wed, 16 Mar 2022 18:15:47 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [Intel-gfx] [PATCH v11 2/5] mei: add support for graphics system
 controller (gsc) devices
Content-Language: en-US
To:     Alexander Usyskin <alexander.usyskin@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>
CC:     <linux-kernel@vger.kernel.org>,
        Tomas Winkler <tomas.winkler@intel.com>,
        Vitaly Lubart <vitaly.lubart@intel.com>,
        <intel-gfx@lists.freedesktop.org>
References: <20220315131157.3972238-1-alexander.usyskin@intel.com>
 <20220315131157.3972238-3-alexander.usyskin@intel.com>
From:   "Ceraolo Spurio, Daniele" <daniele.ceraolospurio@intel.com>
In-Reply-To: <20220315131157.3972238-3-alexander.usyskin@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0113.namprd13.prod.outlook.com
 (2603:10b6:a03:2c5::28) To DM4PR11MB5488.namprd11.prod.outlook.com
 (2603:10b6:5:39d::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 83153d4f-f774-4f40-a001-08da07b3ac8e
X-MS-TrafficTypeDiagnostic: SN6PR11MB2750:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-Microsoft-Antispam-PRVS: <SN6PR11MB2750A7577742A05C5FDFFE04F4129@SN6PR11MB2750.namprd11.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RQ5gN2P7ngzZCFjPP+uNlYhcxlLAMJI4+Cvzi0F66iG2E2FfOqXQGBFugUzwmChyHsm2tTJIjprG8IkR+VOwU6ULh3mJbQheX8qdHUJaooqSwzDiyzsdUzaopFwCtpYPNX1+Xo88uIqJ5fQtwXCpZgGLJ2QaJcNy0wscf2iQmOfUGabpG49TaAeAM0NiYbrXO2oRv1IJFa4/1ywkGGI1Ooge5qeWXNQj2jqw02VQ257rswYa5mO7cOMnJlBMdRYDI4oJ7n0ATEsT1COZo8OBHuINUyZGbM8K4s6aBDOnUXxdntFCf/MZSGbDuMfg5IE4nSqYVkwuUK/TsMEup0azVtpTaEGHCEvtfUkp5gzv4MfCjfD2PLvNVgC+Ie7c1kT1OYx4QPgWsuObsBB/uj6nWy0iRGVF9ncwfyy9IJP1X6a9XlUvQ0SxhZXW7SdEyWi+OGKdE97I+UX5dck6pi9MOP8u+5vkZeOkvAOgkp/AZYxrDDe3cO3EiiC+fKo0UzoPW9X4UDrAtYv/cIWN9MiTV4HofVtGoqbh0BJZrFsSckhY/Ya1e7zq2gctCVE1uIqL02SU7uCjHzTWYmtp8Lw7lmK/UEU+Rl2QZ+R+YM38aGnzx1V0zWbrA5SZAd1CtGkc+SRgR3wLxYeMB358p69GQ3/j2kcmnzRhQDzwlEWLeC6LsSOVbNZesMzWr4Lchvm+lUTDxEOMHQLFf3g9u50bnhy9SO/cLqTbOO0Ff/PJgJxa/hHzovK27DiYPYJHY59r
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB5488.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(38100700002)(316002)(2906002)(31696002)(82960400001)(36756003)(53546011)(86362001)(31686004)(6506007)(2616005)(110136005)(8676002)(6486002)(8936002)(83380400001)(6666004)(26005)(508600001)(186003)(6512007)(54906003)(66946007)(5660300002)(66556008)(4326008)(66476007)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Vmc3alBxVXNIL21qcmY0a1NTcEkzclRVU01kLzlRMGY0aGM4SitBZ1NySExN?=
 =?utf-8?B?QXVjR0NlSm9Zc21IU2NRTklCY25rT3hjK29sUml5U3UwWnJmL2lnNHJuSENu?=
 =?utf-8?B?Y2UyQTJad0d0RkNIZ1k3cFNia3lCYm1QSlhTRis1SXpPbytsS2xDVGc4RUZX?=
 =?utf-8?B?UnMwVzMyaEJ2bEZub1d5OWtEaW1hZllieUhtZmN4a2VBYTM1YWdvUUhKZUZG?=
 =?utf-8?B?Q1haaDczTGt6V00vTjIzMUpJQWZFNXorQ2RTWmVsVnI3cnUxWGlkWHBpRTg2?=
 =?utf-8?B?THo1VzEyRWNnVEE1RmlQN2VEYTl4c04xSS85SHFYL09hdWJtM09rZm04NFBm?=
 =?utf-8?B?L2ZBSXlWUGd4QXgrekZUOENIYjJQME45SUdhL25PSkpZUklzalQ5ak5XbmFl?=
 =?utf-8?B?RWdhUXZCckFvYnhFa2htOXpZNVdyMjdTTWs3VktmMnFteUVlUGs3Nnp5N1FT?=
 =?utf-8?B?VzU3dU45S1RVWWdNenBNWmQ2L2p5TnlJd1d2TVFxcENEb2QrWm56Qm4vdW9l?=
 =?utf-8?B?aFJ3U25XcCtOMWpqYmdlZ2o3VWw3WkYvRlFkbnRJemd1c2VDZklFTTVERC9W?=
 =?utf-8?B?a2hqS2NHdllwWlBUamZvV0tUVlpSa21ycUVPZW1yT2E5eHJQTE1tSXV4Y0t2?=
 =?utf-8?B?QTVqYm4wcG8wakNsSVdQeVo5ZDhGckZyalBzWmlyUmRqNitDN3hFOHppc08z?=
 =?utf-8?B?TzBIVXVYSnRmTmZ0WmFnYkphUUhPNTJtZy9QSUpiY1YwUlhUK0lBRHpUeERy?=
 =?utf-8?B?Z2tyREhVWDNSUzJOWHUyVmd0WU85eVVnZ1dnZ2xaN2FISEFFWFhGcWFpQmdw?=
 =?utf-8?B?OFJJMzF3UzcwSUlvT3VLYWxZTFdZVTJjZjYzRngrM2w0b2ZiSWlndm5TbFQv?=
 =?utf-8?B?TjVTTjZvbmRvV1dhN29lSWdXNHExZkYrMHJObzZLWG5NVlNUWEJwdEQreE0r?=
 =?utf-8?B?WWN5ZUtXakxRNTFSc1NHNzJZdmNBd0NVaWhtVlhEL1BacnJFdEFSMDNoeVdr?=
 =?utf-8?B?aTVITldIQngxczR5aVQwUGxnTzVIa3RJVFpEdEhrVDhSSE52L2l4MEtjV1RT?=
 =?utf-8?B?UXhYTEFJV2N6UkQrZVNFWlBjRUxRell2NUt0V240djViYWVVTjM0RWZ6ODNh?=
 =?utf-8?B?U1ZHNGVuWG1USWFlWjNpRUNWNVB5K2xMNzBjTUdOaFhiRXNFcml3UG9ycDhF?=
 =?utf-8?B?YW5QM2IwQnd5WGcxeGJnR25LMHRiS0E0bnJyUTk5UWJxNE1BSXhuNFd0aE9Z?=
 =?utf-8?B?RDFHNllSQVNwc2FHbnNoU1VGMmt4RWRNcjBDV1J1WWpaa2ViZ2tLYkV2RC9h?=
 =?utf-8?B?ejRJYkEycTBMTXdRWHpiaGtUSngxS1QrZ2xuZGV2eDdPczgzUTVZblZieUtw?=
 =?utf-8?B?VHNkdHUvWTdwcnhSMXE4OURza0JjNzFoQjNKamFlQWJWNkY1QlR4bVBjcHFS?=
 =?utf-8?B?eE9NQTdsTUQ2alZQQm5rUDQvU05vRm0wQ1VkSW02eHdDUzJaZlo4Ky9CRFdy?=
 =?utf-8?B?TXZ0K2liTEltRExZdC85RkxMQlZpc1pJU3lRbmtxZGMwaHRCbFBmdkFMcHNX?=
 =?utf-8?B?TElNd2dOaTR1RFZVMkJDTkVlcnZrTWFFRUlwZGxCdWRjL3pGOWNpakxCTmFD?=
 =?utf-8?B?S0ZBTTBRSndKWlM0WTZaRmtxTGFmNmtZZDQzdzZTWDE0Ym4yblZuR3RINmMx?=
 =?utf-8?B?aEZEMnJDeFdxditaQ3NkQmpQbTB0cHFTZEJLSGp3SUZLSXFTdjVYeTFYOFQr?=
 =?utf-8?B?VURrbVBWeW9FK29mVG1ITXl1MFpaOVZqZCt0M1J4emRZTGsxdUhoRGwyQ3hI?=
 =?utf-8?B?a1Q2V1hFUkdoekl3dDVmbzRwWlJuM09BZFhmTUU4dldmQzJ6LzMvMUpkZVM3?=
 =?utf-8?B?eFV6UXBQSjkyb09YdEFPQzVGQktlbldsY0tldUwweUVRQ0ZmVENaN3Rod3lp?=
 =?utf-8?B?RXZZK2NHUm8rSnQxV2pQVnpXbk5RV1FDdEZENi9PTlQ0UDhoRi9sNWF4Y0FJ?=
 =?utf-8?Q?5cJqqflN87EDB/0vbdJDrnE5QAvNWE=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 83153d4f-f774-4f40-a001-08da07b3ac8e
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB5488.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2022 01:15:50.3622
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KehcoTMfHjO5gawmyG2iLHkGcW0vv/3+ij/fdNNdvlURCeDLV1dackNjnFbrPuYCi+4YCblMh8XKk39ewvEcFnm7I1jT3c4FsOS7qZdRQtk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR11MB2750
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/15/2022 6:11 AM, Alexander Usyskin wrote:
> From: Tomas Winkler <tomas.winkler@intel.com>
>
> GSC is a graphics system controller, based on CSE, it provides
> a chassis controller for graphics discrete cards, as well as it
> supports media protection on selected devices.
>
> mei_gsc binds to a auxiliary devices exposed by Intel discrete
> driver i915.
>
> Signed-off-by: Alexander Usyskin <alexander.usyskin@intel.com>
> Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>

Reviewed-by: Daniele Ceraolo Spurio <daniele.ceraolospurio@intel.com>

Daniele

> ---
> V4: drop debug prints
>      replace selects with depends on in Kconfig
> V5: Rebase
> V6: Rebase
> V7: add Greg KH Reviewed-by
> V8: Rebase
> V9: Rebase
> V11: explicitely call devm_free_irq on error path and remove
> ---
>   drivers/misc/mei/Kconfig  |  14 +++
>   drivers/misc/mei/Makefile |   3 +
>   drivers/misc/mei/gsc-me.c | 194 ++++++++++++++++++++++++++++++++++++++
>   drivers/misc/mei/hw-me.c  |  27 +++++-
>   drivers/misc/mei/hw-me.h  |   2 +
>   5 files changed, 238 insertions(+), 2 deletions(-)
>   create mode 100644 drivers/misc/mei/gsc-me.c
>
> diff --git a/drivers/misc/mei/Kconfig b/drivers/misc/mei/Kconfig
> index 0e0bcd0da852..d21486d69df2 100644
> --- a/drivers/misc/mei/Kconfig
> +++ b/drivers/misc/mei/Kconfig
> @@ -46,6 +46,20 @@ config INTEL_MEI_TXE
>   	  Supported SoCs:
>   	  Intel Bay Trail
>   
> +config INTEL_MEI_GSC
> +	tristate "Intel MEI GSC embedded device"
> +	depends on INTEL_MEI
> +	depends on INTEL_MEI_ME
> +	depends on X86 && PCI
> +	depends on DRM_I915
> +	help
> +	  Intel auxiliary driver for GSC devices embedded in Intel graphics devices.
> +
> +	  An MEI device here called GSC can be embedded in an
> +	  Intel graphics devices, to support a range of chassis
> +	  tasks such as graphics card firmware update and security
> +	  tasks.
> +
>   source "drivers/misc/mei/hdcp/Kconfig"
>   source "drivers/misc/mei/pxp/Kconfig"
>   
> diff --git a/drivers/misc/mei/Makefile b/drivers/misc/mei/Makefile
> index d8e5165917f2..fb740d754900 100644
> --- a/drivers/misc/mei/Makefile
> +++ b/drivers/misc/mei/Makefile
> @@ -18,6 +18,9 @@ obj-$(CONFIG_INTEL_MEI_ME) += mei-me.o
>   mei-me-objs := pci-me.o
>   mei-me-objs += hw-me.o
>   
> +obj-$(CONFIG_INTEL_MEI_GSC) += mei-gsc.o
> +mei-gsc-objs := gsc-me.o
> +
>   obj-$(CONFIG_INTEL_MEI_TXE) += mei-txe.o
>   mei-txe-objs := pci-txe.o
>   mei-txe-objs += hw-txe.o
> diff --git a/drivers/misc/mei/gsc-me.c b/drivers/misc/mei/gsc-me.c
> new file mode 100644
> index 000000000000..64b02adf3149
> --- /dev/null
> +++ b/drivers/misc/mei/gsc-me.c
> @@ -0,0 +1,194 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright(c) 2019-2022, Intel Corporation. All rights reserved.
> + *
> + * Intel Management Engine Interface (Intel MEI) Linux driver
> + */
> +
> +#include <linux/module.h>
> +#include <linux/mei_aux.h>
> +#include <linux/device.h>
> +#include <linux/irqreturn.h>
> +#include <linux/jiffies.h>
> +#include <linux/ktime.h>
> +#include <linux/delay.h>
> +#include <linux/pm_runtime.h>
> +
> +#include "mei_dev.h"
> +#include "hw-me.h"
> +#include "hw-me-regs.h"
> +
> +#include "mei-trace.h"
> +
> +#define MEI_GSC_RPM_TIMEOUT 500
> +
> +static int mei_gsc_read_hfs(const struct mei_device *dev, int where, u32 *val)
> +{
> +	struct mei_me_hw *hw = to_me_hw(dev);
> +
> +	*val = ioread32(hw->mem_addr + where + 0xC00);
> +
> +	return 0;
> +}
> +
> +static int mei_gsc_probe(struct auxiliary_device *aux_dev,
> +			 const struct auxiliary_device_id *aux_dev_id)
> +{
> +	struct mei_aux_device *adev = auxiliary_dev_to_mei_aux_dev(aux_dev);
> +	struct mei_device *dev;
> +	struct mei_me_hw *hw;
> +	struct device *device;
> +	const struct mei_cfg *cfg;
> +	int ret;
> +
> +	cfg = mei_me_get_cfg(aux_dev_id->driver_data);
> +	if (!cfg)
> +		return -ENODEV;
> +
> +	device = &aux_dev->dev;
> +
> +	dev = mei_me_dev_init(device, cfg);
> +	if (IS_ERR(dev)) {
> +		ret = PTR_ERR(dev);
> +		goto err;
> +	}
> +
> +	hw = to_me_hw(dev);
> +	hw->mem_addr = devm_ioremap_resource(device, &adev->bar);
> +	if (IS_ERR(hw->mem_addr)) {
> +		dev_err(device, "mmio not mapped\n");
> +		ret = PTR_ERR(hw->mem_addr);
> +		goto err;
> +	}
> +
> +	hw->irq = adev->irq;
> +	hw->read_fws = mei_gsc_read_hfs;
> +
> +	dev_set_drvdata(device, dev);
> +
> +	ret = devm_request_threaded_irq(device, hw->irq,
> +					mei_me_irq_quick_handler,
> +					mei_me_irq_thread_handler,
> +					IRQF_ONESHOT, KBUILD_MODNAME, dev);
> +	if (ret) {
> +		dev_err(device, "irq register failed %d\n", ret);
> +		goto err;
> +	}
> +
> +	pm_runtime_get_noresume(device);
> +	pm_runtime_set_active(device);
> +	pm_runtime_enable(device);
> +
> +	if (mei_start(dev)) {
> +		dev_err(device, "init hw failure.\n");
> +		ret = -ENODEV;
> +		goto irq_err;
> +	}
> +
> +	pm_runtime_set_autosuspend_delay(device, MEI_GSC_RPM_TIMEOUT);
> +	pm_runtime_use_autosuspend(device);
> +
> +	ret = mei_register(dev, device);
> +	if (ret)
> +		goto register_err;
> +
> +	pm_runtime_put_noidle(device);
> +	return 0;
> +
> +register_err:
> +	mei_stop(dev);
> +irq_err:
> +	devm_free_irq(device, hw->irq, dev);
> +
> +err:
> +	dev_err(device, "probe failed: %d\n", ret);
> +	dev_set_drvdata(device, NULL);
> +	return ret;
> +}
> +
> +static void mei_gsc_remove(struct auxiliary_device *aux_dev)
> +{
> +	struct mei_device *dev;
> +	struct mei_me_hw *hw;
> +
> +	dev = dev_get_drvdata(&aux_dev->dev);
> +	if (!dev)
> +		return;
> +
> +	hw = to_me_hw(dev);
> +
> +	mei_stop(dev);
> +
> +	mei_deregister(dev);
> +
> +	pm_runtime_disable(&aux_dev->dev);
> +
> +	mei_disable_interrupts(dev);
> +	devm_free_irq(&aux_dev->dev, hw->irq, dev);
> +}
> +
> +static int __maybe_unused mei_gsc_pm_suspend(struct device *device)
> +{
> +	struct mei_device *dev = dev_get_drvdata(device);
> +
> +	if (!dev)
> +		return -ENODEV;
> +
> +	mei_stop(dev);
> +
> +	mei_disable_interrupts(dev);
> +
> +	return 0;
> +}
> +
> +static int __maybe_unused mei_gsc_pm_resume(struct device *device)
> +{
> +	struct mei_device *dev = dev_get_drvdata(device);
> +	int err;
> +
> +	if (!dev)
> +		return -ENODEV;
> +
> +	err = mei_restart(dev);
> +	if (err)
> +		return err;
> +
> +	/* Start timer if stopped in suspend */
> +	schedule_delayed_work(&dev->timer_work, HZ);
> +
> +	return 0;
> +}
> +
> +static SIMPLE_DEV_PM_OPS(mei_gsc_pm_ops, mei_gsc_pm_suspend, mei_gsc_pm_resume);
> +
> +static const struct auxiliary_device_id mei_gsc_id_table[] = {
> +	{
> +		.name = "i915.mei-gsc",
> +		.driver_data = MEI_ME_GSC_CFG,
> +
> +	},
> +	{
> +		.name = "i915.mei-gscfi",
> +		.driver_data = MEI_ME_GSCFI_CFG,
> +	},
> +	{
> +		/* sentinel */
> +	}
> +};
> +MODULE_DEVICE_TABLE(auxiliary, mei_gsc_id_table);
> +
> +static struct auxiliary_driver mei_gsc_driver = {
> +	.probe	= mei_gsc_probe,
> +	.remove = mei_gsc_remove,
> +	.driver = {
> +		/* auxiliary_driver_register() sets .name to be the modname */
> +		.pm = &mei_gsc_pm_ops,
> +	},
> +	.id_table = mei_gsc_id_table
> +};
> +module_auxiliary_driver(mei_gsc_driver);
> +
> +MODULE_AUTHOR("Intel Corporation");
> +MODULE_ALIAS("auxiliary:i915.mei-gsc");
> +MODULE_ALIAS("auxiliary:i915.mei-gscfi");
> +MODULE_LICENSE("GPL v2");
> diff --git a/drivers/misc/mei/hw-me.c b/drivers/misc/mei/hw-me.c
> index d3a6c0728645..9748d14849a1 100644
> --- a/drivers/misc/mei/hw-me.c
> +++ b/drivers/misc/mei/hw-me.c
> @@ -1226,6 +1226,7 @@ irqreturn_t mei_me_irq_quick_handler(int irq, void *dev_id)
>   	me_intr_disable(dev, hcsr);
>   	return IRQ_WAKE_THREAD;
>   }
> +EXPORT_SYMBOL_GPL(mei_me_irq_quick_handler);
>   
>   /**
>    * mei_me_irq_thread_handler - function called after ISR to handle the interrupt
> @@ -1320,6 +1321,7 @@ irqreturn_t mei_me_irq_thread_handler(int irq, void *dev_id)
>   	mutex_unlock(&dev->device_lock);
>   	return IRQ_HANDLED;
>   }
> +EXPORT_SYMBOL_GPL(mei_me_irq_thread_handler);
>   
>   static const struct mei_hw_ops mei_me_hw_ops = {
>   
> @@ -1433,6 +1435,12 @@ static bool mei_me_fw_type_sps(const struct pci_dev *pdev)
>   #define MEI_CFG_KIND_ITOUCH                     \
>   	.kind = "itouch"
>   
> +#define MEI_CFG_TYPE_GSC                        \
> +	.kind = "gsc"
> +
> +#define MEI_CFG_TYPE_GSCFI                      \
> +	.kind = "gscfi"
> +
>   #define MEI_CFG_FW_SPS                          \
>   	.quirk_probe = mei_me_fw_type_sps
>   
> @@ -1565,6 +1573,18 @@ static const struct mei_cfg mei_me_pch15_sps_cfg = {
>   	MEI_CFG_FW_SPS,
>   };
>   
> +/* Graphics System Controller */
> +static const struct mei_cfg mei_me_gsc_cfg = {
> +	MEI_CFG_TYPE_GSC,
> +	MEI_CFG_PCH8_HFS,
> +};
> +
> +/* Graphics System Controller Firmware Interface */
> +static const struct mei_cfg mei_me_gscfi_cfg = {
> +	MEI_CFG_TYPE_GSCFI,
> +	MEI_CFG_PCH8_HFS,
> +};
> +
>   /*
>    * mei_cfg_list - A list of platform platform specific configurations.
>    * Note: has to be synchronized with  enum mei_cfg_idx.
> @@ -1585,6 +1605,8 @@ static const struct mei_cfg *const mei_cfg_list[] = {
>   	[MEI_ME_PCH12_SPS_ITOUCH_CFG] = &mei_me_pch12_itouch_sps_cfg,
>   	[MEI_ME_PCH15_CFG] = &mei_me_pch15_cfg,
>   	[MEI_ME_PCH15_SPS_CFG] = &mei_me_pch15_sps_cfg,
> +	[MEI_ME_GSC_CFG] = &mei_me_gsc_cfg,
> +	[MEI_ME_GSCFI_CFG] = &mei_me_gscfi_cfg,
>   };
>   
>   const struct mei_cfg *mei_me_get_cfg(kernel_ulong_t idx)
> @@ -1595,7 +1617,8 @@ const struct mei_cfg *mei_me_get_cfg(kernel_ulong_t idx)
>   		return NULL;
>   
>   	return mei_cfg_list[idx];
> -};
> +}
> +EXPORT_SYMBOL_GPL(mei_me_get_cfg);
>   
>   /**
>    * mei_me_dev_init - allocates and initializes the mei device structure
> @@ -1630,4 +1653,4 @@ struct mei_device *mei_me_dev_init(struct device *parent,
>   
>   	return dev;
>   }
> -
> +EXPORT_SYMBOL_GPL(mei_me_dev_init);
> diff --git a/drivers/misc/mei/hw-me.h b/drivers/misc/mei/hw-me.h
> index 00a7132ac7a2..a071c645e905 100644
> --- a/drivers/misc/mei/hw-me.h
> +++ b/drivers/misc/mei/hw-me.h
> @@ -112,6 +112,8 @@ enum mei_cfg_idx {
>   	MEI_ME_PCH12_SPS_ITOUCH_CFG,
>   	MEI_ME_PCH15_CFG,
>   	MEI_ME_PCH15_SPS_CFG,
> +	MEI_ME_GSC_CFG,
> +	MEI_ME_GSCFI_CFG,
>   	MEI_ME_NUM_CFG,
>   };
>   

