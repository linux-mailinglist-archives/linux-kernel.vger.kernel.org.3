Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4685B5B148A
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 08:18:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230252AbiIHGSP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 02:18:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbiIHGSL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 02:18:11 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D3819FAA6;
        Wed,  7 Sep 2022 23:18:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662617891; x=1694153891;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=24iOP2YnwoIF+pIPvSI8dzmoRDK0eMymx6S/PBO8ovw=;
  b=nxZIG4zJCQ/FtmqW3EUJg+xDGli1zxOTn092Q8pWA3RZRw/SoMOhWeqW
   Gbk7+6pjVUPw1neg7yzpEbzaVOPS3Spw/OapvUapvs+pvH5joYvobFVPn
   Kd+2ZFkvwmQglBGWsQ0L5nxiuOQHarf3YBEoLdKr2wxce5BQypDZzdKtc
   m4wnfaKTJac4DQQlmIKSixl3sLJ9nhfGxmIEu7dlscE/gQdHPzgsKS79z
   1fLN7SYKuXQUxQt20fw3P4BPYByjZ5OZKMfLuMB6Qgik6Zh/EQyuG53As
   bzEQImcQ4x75rwxry1ZIL2yxGko31tQYF0iG94Qh4Frd0G4tA0DhNoRCa
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10463"; a="295814251"
X-IronPort-AV: E=Sophos;i="5.93,299,1654585200"; 
   d="scan'208";a="295814251"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Sep 2022 23:18:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,299,1654585200"; 
   d="scan'208";a="790320778"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga005.jf.intel.com with ESMTP; 07 Sep 2022 23:18:10 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 7 Sep 2022 23:18:09 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 7 Sep 2022 23:18:09 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Wed, 7 Sep 2022 23:18:09 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.45) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Wed, 7 Sep 2022 23:18:08 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Uko0oGeR2pZ53S39mEF2sXKXUoVIgX2XiTsz57YGpV18WZrmRIafs/jpYo6bq8mnv24MJQ5neh8jADUk/qSKwPvoIPBnXPL4HCzsr6pdf+/YrXhxN3FjUSMSfi/5jnghSDVYMUXJE9EVK2W/cSN0P5WEzZU4S8CUBKep1eUoTS072WQJJm+gGFRVf0bRiR9oWIucru01MRrfCVvdUfvuFmEEupiVY/pSoZPMq+kh59eqpN7unLB/YDxjEwKTUFFnbj3C19Sl0JtL0Ihj1u/UIVaNo8L0J9iKlTwuc+mZ7S6ZXgDLD5vwC5UdtsS1bp+aHVTvKSPnX2B6upNi6yOXAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mrPXru65kzUr/4NhieI1xp0vehiBkeBP2/yNTB9gNis=;
 b=ji2IZv29Gsmfdx+4Oovo1U4tD8MvWC5b+RkFs88jaL4yqBsK/WZXyTTsWEuVhbj7iiXqR0e4yx8mx3/BL70FZg+k3GAwQ/ZO4KYcFrwatozR/HElOZnAg7+de/XfimiBUmrhdamXKDFja7rppbtKizq4GcIX7i875vmP/5hsoKarMO6O1bzow7ddDTt5fWuwa8Gvt7GvSi3yinn67SG9sHgBkDIHm5oU2LuO378HXKi1iRjQ8n2xvoVPgF4JE5y47L+qqJZFu8Rz8Vs7+aiMBsrzXn7BxA6EbHq4NFrsw27A/ydLwWZ1tD9Mv8TopudIvCDmcFv0Juhzthf+XGx8HQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20) by SJ0PR11MB5789.namprd11.prod.outlook.com
 (2603:10b6:a03:424::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.15; Thu, 8 Sep
 2022 06:18:07 +0000
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::9847:345e:4c5b:ca12]) by MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::9847:345e:4c5b:ca12%6]) with mapi id 15.20.5588.017; Thu, 8 Sep 2022
 06:18:06 +0000
Date:   Wed, 7 Sep 2022 23:18:03 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     Robert Richter <rrichter@amd.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        "Ira Weiny" <ira.weiny@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        "Dan Williams" <dan.j.williams@intel.com>
CC:     <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>, Robert Richter <rrichter@amd.com>
Subject: RE: [PATCH 08/15] cxl/acpi: Check RCH's CXL DVSEC capabilities
Message-ID: <6319891ba810b_58016294a1@dwillia2-xfh.jf.intel.com.notmuch>
References: <20220831081603.3415-1-rrichter@amd.com>
 <20220831081603.3415-9-rrichter@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20220831081603.3415-9-rrichter@amd.com>
X-ClientProxiedBy: BYAPR21CA0024.namprd21.prod.outlook.com
 (2603:10b6:a03:114::34) To MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c1b47cbe-d35d-4d29-34a6-08da9161e500
X-MS-TrafficTypeDiagnostic: SJ0PR11MB5789:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Xazz6jhMFo8yXAYFJMD0pNNxUngRjBET/uzbRkX3Z4Jy5H3WxTsTMDF+peBmcLOmWYvDIFHh/k+7hsbcwWCL7gJOi6w3Hg08Ju3OUJvMFY4mkRkt4pAbvfEgNihGskI+FIXkzWs/yg5u59IpgaT5x2Z2xAAulxPJfo8ZDzfu1RQ+mZWwfrVYoE1xNEcvtr6jyObLZ3bE9CfkLN0wteJ2RigKiaQUpvLf7vSzdLYEpzLM+xvJd8rMbyMFi52KmM9QJ4mLywfyN7Sa2Bnc32eaoPvXWBhUnhSzvLk5bseQxXOS7FJE6gUZPN4UVoTI01nTWjcwbuCAnP37KeaFxSNUBni7D1wRb+FoZpI/CF0PJtqI3SnRmXULbirKu3hjsZkDOtWMlJZvJd0JY837/XaVeBvhnGhvpnuKnz8H63NyaKLu4y+60MjSI4Y8YUjK8Nmhywi/lqNlYg+mFBzmpGyV6ErWkHuPo+UQImK3vkRfxsWJRFy5493xNFzQFms1ymUhynr9aDwViHxYrmj2oIwZJPnxkOLXrlA+B/aMHDv6YWTl/1DDSEQz3jpzvwr4a2cdgwKgA6p5LJwi1P4Kp5LeMeEk7bCyTBlUcy/zUozZZD+uFXAn4oJ9JXGYMrY2JP90778fvWuCxiHqb47tJNqG+hhtnYpXWSzRmVgbKtyE0FSv+6Mrl7kdXJj60ZWcDgl8aj+AAjmfmKOt/mP4g6pHkA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1101MB2126.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(376002)(396003)(366004)(39860400002)(136003)(346002)(316002)(82960400001)(6506007)(83380400001)(4326008)(8676002)(66556008)(66476007)(66946007)(110136005)(38100700002)(2906002)(54906003)(8936002)(26005)(186003)(5660300002)(478600001)(6486002)(6666004)(86362001)(9686003)(6512007)(41300700001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?D+ihIb4MjLX9Wwq0std8VPXXTSrSbLBlMJPyVm4Mhy6jI5oOibf6NZD7Y8A2?=
 =?us-ascii?Q?ELDBQGK2xxUQ/bsxwEWIIIE62Q/BB+BnRnazN1GNdRBq2GtGsD0KoOuKe6by?=
 =?us-ascii?Q?HF280s++1OxF0pySZvGTzZhe7890NbUoUunheHVcJsBu8F2ezIKqYWZ/tBuP?=
 =?us-ascii?Q?qWqxLdBTrbbp6yJy/cwnhHJd2Pr8eKHCW6Jqm94r95QwwFZX4ABVQ23vSWrZ?=
 =?us-ascii?Q?XHObry7OPs5YOxfwx6MVU8pncXLP2oPrauAiq5UX/ezOxFzHG/ikOKuN8p9P?=
 =?us-ascii?Q?bTBY7ouRlFDXDjQ+HB8I8Aj6HyyjpY9GPB51qvq5yknKCQprTDbDcor8nQEC?=
 =?us-ascii?Q?OHhRIOVuA3pdBVwKXyTTQSvt0a5BQ9FA/5J2jU2CBhp/AXHHi7m3r247ets2?=
 =?us-ascii?Q?/gDQxlwb5hLF9Z9FzIRfK3gcjkVT0kQT741daZm5HllKiGoPMjN40WDhJhRq?=
 =?us-ascii?Q?c88exipzaIslhroWgR0hp8GrM0XFBnuOERGxZ+GibTFjGtntOJoPQA6vluqr?=
 =?us-ascii?Q?ecu6fuv+F2UVWDoen6tdMZXUrB26F2NydqX4hGUsxkMDgAf6sPi+3BEs+Fli?=
 =?us-ascii?Q?7XH7r3ubfx+7GwhDO7pzWX+rJAAbU+7CnrS0mSyBLM57gpWQeGIXAsu5poMc?=
 =?us-ascii?Q?b3RJghhRnKpwPirz5r4xEK366mfLPOxpTWjAAOWDMqPSaIQVUibjbZO2ImYd?=
 =?us-ascii?Q?h885gPUeVY3FBfncTVhdDyqxos8WZNOY4UrchmUqo+W/tT2XHOQrxiK3dhvp?=
 =?us-ascii?Q?a8VLBWcSpqdCKkq4VtTd/+m9faGopMvHXgYhyWbIYIoH4v5xjbAZ8Hca82Mg?=
 =?us-ascii?Q?Dq6AtfyHa8XFlO0+YXuNo8B8jDO8YCsvpnrQbM8jAhzIvkhVCjdVcSE1RZuJ?=
 =?us-ascii?Q?JnX4IL5G4O8LFz4xUpS3rBmGD2On79rQsflLdlBOyVnz0mmg92XqN8mdu6cS?=
 =?us-ascii?Q?zrJ/BDPA3ygZ0sAzclpkjSFCHij7PxYTtBs1pOrQW6JaU7gJTUh23iEGcvPT?=
 =?us-ascii?Q?m3RzRUMF9RMKvOXzm/kOu6euCOLpXt7YZA8vy1r2WknozPBS3whBFkA5chz8?=
 =?us-ascii?Q?0w8jpbd0Wjh3wjcfLT/IaPpx9vEnkaWybFx5K1g2Jbpwrb2eqsDgmPAHzEEz?=
 =?us-ascii?Q?UlS2opXlz8dwzLPp7YfC3mzgExjpw3k+N7H92Z9/QSEnycFgnMjckNOAU8GX?=
 =?us-ascii?Q?HpNcv3B9kyOQektl41gTdF3OK9awE0wwWL6OxjOYg8CQKrLTLOjWc5SXPfQL?=
 =?us-ascii?Q?pXsZKvd9PTYvRQ8kh8UpAd27O4VsGW3Qluil+VO0VWEY9E8/6KQJjpKWTt//?=
 =?us-ascii?Q?GlbKI/BZbmXcCEyB72g7i0tKVWHNZGtvcL0ucCxcKzMLfzB6KsKJp6RAnYOs?=
 =?us-ascii?Q?PHteWlMKCZgzYJiRM5tfNRpRdhWpE5dXS/DDzJHR9U+ev/FL7fcJkitv+/Je?=
 =?us-ascii?Q?6GuyCwLDJKSTHrM9l69YRS3HmcNsuS/OJ2FjzjR5CAV2dSmyRzRBqGVpFxRK?=
 =?us-ascii?Q?JgVgDljMUI4/BGIZgsTDncXHe/zmtAxSK8KnguNMRpm1P3BNn8k+VvRfpblr?=
 =?us-ascii?Q?xB2ku6bO3QfZEMowouhPG7N6iegslx9475C3RhSXGoj/7LbUoNitI81bY4B8?=
 =?us-ascii?Q?MA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c1b47cbe-d35d-4d29-34a6-08da9161e500
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1101MB2126.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2022 06:18:06.7135
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LYTGTM6FJJVCUbuu65XR6NDWGVsXnj7uoYHdKLX1oKLYeuayomNn58lSsbBM4FuS+GU6+NWQvnJvGQyC8L04Pr3smVgh8vUYtBHN38jI9MM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5789
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Robert Richter wrote:
> An RCH has an RCiEP connected to it with CXL DVSEC capabilities
> present and the CXL PCIe DVSEC included. Check this.
> 
> Signed-off-by: Robert Richter <rrichter@amd.com>
> ---
>  drivers/cxl/acpi.c | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
> 
> diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
> index ffdf439adb87..f9cdf23a91a8 100644
> --- a/drivers/cxl/acpi.c
> +++ b/drivers/cxl/acpi.c
> @@ -322,6 +322,8 @@ struct pci_host_bridge *cxl_find_next_rch(struct pci_host_bridge *host)
>  {
>  	struct pci_bus *bus = host ? host->bus : NULL;
>  	struct acpi_device *adev;
> +	struct pci_dev *pdev;
> +	bool is_restricted_host;
>  
>  	while ((bus = pci_find_next_bus(bus)) != NULL) {
>  		host = bus ? to_pci_host_bridge(bus->bridge) : NULL;
> @@ -343,6 +345,20 @@ struct pci_host_bridge *cxl_find_next_rch(struct pci_host_bridge *host)
>  		dev_dbg(&host->dev, "PCI ACPI host found: %s\n",
>  			acpi_dev_name(adev));
>  
> +		/* Check CXL DVSEC of dev 0 func 0 */
> +		pdev = pci_get_slot(bus, PCI_DEVFN(0, 0));
> +		is_restricted_host = pdev
> +			&& (pci_pcie_type(pdev) == PCI_EXP_TYPE_RC_END)
> +			&& pci_find_dvsec_capability(pdev,
> +						PCI_DVSEC_VENDOR_ID_CXL,
> +						CXL_DVSEC_PCIE_DEVICE);

The check looks good, just the matter of integrating it into the
existing ACPI0016 device detection.
