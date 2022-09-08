Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 370105B1440
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 08:00:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229614AbiIHGAn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 02:00:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229773AbiIHGAd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 02:00:33 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F387375FC4;
        Wed,  7 Sep 2022 23:00:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662616831; x=1694152831;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=gPw8oRyHsg0GPKcLgHDSL2cvKC7yXJ8EUpAcJpFLCVI=;
  b=Yf4L6VIM8uiH47wXuYi0b7sUMnZyJsPo2INWelgS8mrFDtZdt9jVNSYc
   XhqlLhMsv0bjd8PFVBa4ZfO3euHY02dtvUePKouFson8IFuYoIp62utXD
   vtDwkxuGbrcQVlAsFmYjflJMX7YVqvJTlNYQVrDNoE+TUeDTpzLxYcGoB
   gyfVZAAdoanTXq/T7S1oMFuXrhr8qG8mMs8BNzmgpTrTt89GGsD/+6nQ6
   IZXhYVwuFPbbmkxM2dDNtuIUjZrnI0xLnyX/D0GDrLaHE76a30hHCdF2G
   nRUWTaaL9Wrwc44nRrTu7nDgBdLU7CE2jC0sZD6zgKbnyKXaMbkuAOma5
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10463"; a="280105109"
X-IronPort-AV: E=Sophos;i="5.93,299,1654585200"; 
   d="scan'208";a="280105109"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Sep 2022 23:00:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,299,1654585200"; 
   d="scan'208";a="757066725"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmsmga001.fm.intel.com with ESMTP; 07 Sep 2022 23:00:29 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 7 Sep 2022 23:00:28 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Wed, 7 Sep 2022 23:00:28 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.101)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Wed, 7 Sep 2022 23:00:27 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S0koEK16CxCaorxKOoWdx9dJ4CSAPmqGmz2dgzvHbN9jqg+l6XHbs5wVTxh6uYbs0xzS8VU2OJnubVintt6QJ0V3vGuQrpx8mQNy4YX+WzmGPIh3Y8NO6idDkIULhiuWMlq0vwr8oXT2MqiNnrC104VMtXSDsVtjQIFBvGBijhSWlT5B14FTm5dwKwZaSSkioB89dbTdq/y+SnInK11jHuG8BA2poQzEkhN5ggpeNWQX4RAmSK/cy7VNKwS/51FPJIevXYe7fhSJYrYRp2CB+XIjmLRn0tEhQPayk9KtXBRkQVcbNKsL+IlQHzIyKvRX5snjEFO7a7fA86gxWtEsuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Na6HzgAzEsFX/Vz4SxuiiyFWrgJo6Ijk/XFtMAlFmN8=;
 b=hZ3cIkC+u6lJNONC8yA415JW/ujj0L9KuoO/akxa9/X7U6ofve+2VvDXQ4U/bZLcPleZ36ZgLleLZUqSNOVBIUDW4D9AVhy2+gfQPjHo+AFU0g+RZhbY7cs5t1q2NxVdyDwuyz2HzujBONjrxCPH/aSTzxtmYNtKnI5JmTMYOEJobDYkDdzj6dgFn01xNuhKG03dtQBncUlTqiXw9Z7j4iyxzv0jfoNAwQQrvEzuiBKHWaW6/QTKvH5zbVwjtSG2OML+amgJWYiV+EsRHc+jn8+h6fGOOplqoERCxuub+Vtxk/VkTgiGVvqL0cf5gxfS1Lvo7xDvo6C8DF5AoHXrCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20) by DM6PR11MB4426.namprd11.prod.outlook.com
 (2603:10b6:5:1d8::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.12; Thu, 8 Sep
 2022 06:00:25 +0000
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::9847:345e:4c5b:ca12]) by MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::9847:345e:4c5b:ca12%6]) with mapi id 15.20.5588.017; Thu, 8 Sep 2022
 06:00:25 +0000
Date:   Wed, 7 Sep 2022 23:00:22 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     Robert Richter <rrichter@amd.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        "Ira Weiny" <ira.weiny@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>
CC:     <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>, Robert Richter <rrichter@amd.com>
Subject: RE: [PATCH 05/15] cxl/acpi: Add probe function to detect restricted
 CXL hosts in RCD mode
Message-ID: <631984f6d7c92_58016294e6@dwillia2-xfh.jf.intel.com.notmuch>
References: <20220831081603.3415-1-rrichter@amd.com>
 <20220831081603.3415-6-rrichter@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20220831081603.3415-6-rrichter@amd.com>
X-ClientProxiedBy: BYAPR06CA0009.namprd06.prod.outlook.com
 (2603:10b6:a03:d4::22) To MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d27ad818-dcd4-4f0f-9a4f-08da915f6c7a
X-MS-TrafficTypeDiagnostic: DM6PR11MB4426:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: O6tI9mpTydUCr2lxEEFxTYQtRH8a9oGD357D/deEVvuZmDtWnMtlGyRozdlMsjluusdnh+nyacgOcHs3p6nqin28pGhyEq+2DljXiixWGsjpaXWNAi+S5LmXRu7Nn4JoYdbZdV6MhrP+4rk4G2RK+NRgheheecX/D14mWsNBYp/kytySptlbi/TlbN2EV7HjyKWHHB5BcvBnzZjeXBd/btknAOB/u7OF9W0E1SpzPjMpkjldzAfvabQXna1e/PZOkeplDIhy2ATc//IU3MER6yjyGPLIHQqLEWG1e+Iy06Ty/7IAGft/Bbhj1Ure9J3DHttiBIey0oJGZ3CCFo9TetWJT7TNGkOUTxRV3XKuibfjbw7WMk8cBVvRK/RwQWFMyfkkbyQtWrvwyUO4F3m4TuCXYYPu5XHmnTr+MIzdJcvm6seKm1DD/itSB8O1cVQSfcouO9jp3vSjTWDymNbhI1WKNG2sdKPkOkyQYeS9ziDFw6Dhq8oadi0Mjk4rzlMhOrxJjxn0FrJLUf0EhJ4RwwcT2a6wxizBMNHFv2FASsabivqfXZbkGkkUZdXIKhl5A5a6rGGsDEvviCKfA2C79mU0OuE2jAsqJUdhEiJahwqRp5ZLM6Tqo+4UnHGZ4d1Fi+ZuNomiXQh8f8ofwmsJgT9Pp9A6c1AQvCX1LqxYvcz4piXFgUu1hwa0zcu+hX22uUVmVdExjptDXOFOSpeQqQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1101MB2126.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(39860400002)(346002)(136003)(366004)(396003)(376002)(6506007)(41300700001)(26005)(478600001)(6666004)(6486002)(83380400001)(186003)(8936002)(9686003)(2906002)(5660300002)(6512007)(110136005)(54906003)(66946007)(316002)(4326008)(66556008)(8676002)(66476007)(82960400001)(38100700002)(86362001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?HDFNWexxM5QGEpRJmtZQ7xKVW809VOaWC/24cIFOZE5cYL8rk398Ar4xJa+s?=
 =?us-ascii?Q?ANsjRveSkTif7KaKqS3mks4E5KhayNgG4EdHIPrkjhPeiFasMBlgyMQkZx17?=
 =?us-ascii?Q?r8qQ6r9blGZv0yR7lw2KceWuBpfuUgV1yeDd4FzTvSjlKqweWboIfhXGcEMo?=
 =?us-ascii?Q?bkUdPcwscjOyrJsIuNK+g5ALnmptmCP5ke5H/n6eHSQQf2O3CLBhuyzSIG/C?=
 =?us-ascii?Q?pgprrxcvq/zzcpGXHKximodLq56XWqVe+noxauP8w5ddkUzk5HhfhiSZ7c/5?=
 =?us-ascii?Q?W55Zy3udcHkmVybx0urmgNQHRw9ZR5Pp/9TkCMzRPMIz8ggrg7+jJE2TIc87?=
 =?us-ascii?Q?znWLTv1JzqqStmiHQwJPwHm+P3qTqV6wM4un3IC8n6OqpCOSay3Hai2qbahD?=
 =?us-ascii?Q?wIjL3o1dfh3M6sXD6TO7dhXbv9s8gXNWp5G+0mxIyJl+sAcFnqeezlHd7X/H?=
 =?us-ascii?Q?eOEDkPspCnLXCxMpoOsvJxVLIorFbbpqLakXGFi1nqVcOQc0O8YM+XcuhKxF?=
 =?us-ascii?Q?d6r6wXyhBHPHIZdjUxGENtuIKeF4GMD1jjvLJ/MX2xJOfqKkMmHhnkYg/g3i?=
 =?us-ascii?Q?c3DjnN9P2CXXuQSsGg04sdOwZTxBtA7lXVhR+LCdhx0/h9S/TjXjHB6T5PoJ?=
 =?us-ascii?Q?hcuowE/adPLBfp05qAEQy6OlkFtY8D3ybQkE1bzE94svL4z4kpP7yDp+e1tG?=
 =?us-ascii?Q?KZDBzL1Ei4H52OPuRq0uM9dspooGzjudS3sN9qcMfD1chHML/FgmPQzBSubq?=
 =?us-ascii?Q?hGVhUI3gITDVkQ2HUb/b7uLmplK7O9j30/NgeeJqepSHuPtBFQMDnh+E9xsG?=
 =?us-ascii?Q?G8/QuRwPIT8T0jY6D7ppki0a7JgGdQpdggBUDDYf1NpE67n1lK+Was26dO0c?=
 =?us-ascii?Q?VTlQzZxfPShFoEFbYXOXyXiE4UuUlJYv9muZk4bTBPUBwxDFfg8gItY3g0FE?=
 =?us-ascii?Q?9IKnaCoq/lm6DpkQ7UrqC4ky3XnxAvEwo83znsrz3E2PCAXUnhed8dGmfOru?=
 =?us-ascii?Q?hLxSAtbEI44ZWZ2XBySuszBTkA5d/OBL+dWNhoRytolfRwO7IsD+/xxyPaTO?=
 =?us-ascii?Q?hG1c3i9RWzcm0mbUmpB3IkbfaaNx/Qxy3AgBtBS5fMyoSvU1Mr0rZ3qm6iiD?=
 =?us-ascii?Q?RacHJWbCUzWC7RRWPX7ct09NFs9I5sFYXs9nuzfPcqZAyAIPYrIDljHcdwWt?=
 =?us-ascii?Q?D1hfp2T9+vkE+PyBlxo//KciwZ3n+6jghto5Kiv6BboXgMl54ZDTOMAYmPm0?=
 =?us-ascii?Q?dnw3R2Y1qx05cQGXsSXKXHokHUHg9dJ5zfiXiC1msNQp0foBJ4Z0Horph90a?=
 =?us-ascii?Q?SimxtRAfv1R9645wRfcHGLbi81X7baVA5QnvPC4pKkcOZVJF+KgKcxJnzixR?=
 =?us-ascii?Q?1WDKQPLcxWGUcJhG9FxIudJH3Ysh3LwK+MFLKvJXcu6Ketk1NNTGhyy8cy4x?=
 =?us-ascii?Q?UuHZHo20HS7sUKutCSIv/HYTifBSnPVp2l1jhx/9xgKRXQJTlmkgvOQRUAUm?=
 =?us-ascii?Q?fxGGnFiKEIzH7g6Xc510XxffL4EPgotb1OMSa56fIjeJnWJZU07Y+8u9Wxmx?=
 =?us-ascii?Q?LXqDm0KFdgDo/nvzGNP1lQJV6HJOMXRDNLHegp3bg4p3gQ1E9zgKNNmLXhqq?=
 =?us-ascii?Q?Ng=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d27ad818-dcd4-4f0f-9a4f-08da915f6c7a
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1101MB2126.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2022 06:00:25.5178
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wQ/jObE8M2QyhEA4HWoZ1mSYck9G2ZGmaxQEEv/42pTYnuwMcjOw5fPMTDzYV5/MeTIxDbninp9RZV4SJkuTw7uxX+3we8Vn0At14niHHms=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4426
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Robert Richter wrote:
> Restricted CXL device (RCD) mode (formerly CXL 1.1) uses a different
> enumeration scheme other than CXL VH (formerly CXL 2.0). In RCD mode a
> host/device (RCH-RCD) pair shows up as a legal PCIe hierarchy with an
> ACPI host bridge ("PNP0A08" or "ACPI0016" HID) and RCiEP connected to
> it with a description of the CXL device.
> 
> Add function cxl_restricted_host_probe() to probe RCD enumerated
> devices. The function implements a loop that detects all CXL capable
> ACPI PCI root bridges in the system (RCD mode only). The iterator
> function cxl_find_next_rch() is introduced to walk through all of the
> CXL hosts. The loop will then enable all CXL devices connected to the
> host. For now, only implement an empty loop with an iterator that
> returns all pci host bridges in the system.
> 
> The probe function is triggered by adding an own root device for RCHs.
> This is different to CXL VH where an ACPI "ACPI0017" root device
> exists. Its detection starts the CXL host detection. In RCD mode such
> a device does not necessarily exists, so solve this by creating a
> plain platform device that is not an ACPI device and is root only for
> RCHs.

As I mentioned in the cover letter a BIOS that does not provide an
ACPI0017 device is opting out of the possibility OS first error handling
and other OS CXL services. ACPI0017 is mandatory.

Otherwise, its odd to have a module create the device that its driver is
going to drive. That's a backwards driver model and why we proposed
ACPI0017 in the first instance.

> 
> Signed-off-by: Robert Richter <rrichter@amd.com>
> ---
>  drivers/cxl/acpi.c | 71 +++++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 70 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
> index 31e104f0210f..a19e3154dd44 100644
> --- a/drivers/cxl/acpi.c
> +++ b/drivers/cxl/acpi.c
> @@ -312,6 +312,33 @@ static int add_root_nvdimm_bridge(struct device *match, void *data)
>  	return 1;
>  }
>  
> +struct pci_host_bridge *cxl_find_next_rch(struct pci_host_bridge *host)
> +{
> +	struct pci_bus *bus = host ? host->bus : NULL;
> +
> +	while ((bus = pci_find_next_bus(bus)) != NULL) {
> +		host = bus ? to_pci_host_bridge(bus->bridge) : NULL;
> +		if (!host)
> +			continue;
> +
> +		dev_dbg(&host->dev, "PCI bridge found\n");
> +
> +		return host;
> +	}
> +
> +	return NULL;
> +}
> +
> +static int __init cxl_restricted_host_probe(struct platform_device *pdev)
> +{
> +	struct pci_host_bridge *host = NULL;
> +
> +	while ((host = cxl_find_next_rch(host)) != NULL) {
> +	}
> +
> +	return 0;
> +}
> +
>  static struct lock_class_key cxl_root_key;
>  
>  static void cxl_acpi_lock_reset_class(void *dev)
> @@ -445,6 +472,13 @@ static int cxl_acpi_probe(struct platform_device *pdev)
>  	struct acpi_device *adev = ACPI_COMPANION(host);
>  	struct cxl_cfmws_context ctx;
>  
> +	/*
> +	 * For RCH (CXL 1.1 hosts) the probe is triggered by a plain
> +	 * platform dev which does not have an acpi companion.
> +	 */
> +	if (!adev)
> +		return cxl_restricted_host_probe(pdev);
> +
>  	device_lock_set_class(&pdev->dev, &cxl_root_key);
>  	rc = devm_add_action_or_reset(&pdev->dev, cxl_acpi_lock_reset_class,
>  				      &pdev->dev);
> @@ -518,6 +552,7 @@ MODULE_DEVICE_TABLE(acpi, cxl_acpi_ids);
>  
>  static const struct platform_device_id cxl_test_ids[] = {
>  	{ "cxl_acpi" },
> +	{ "cxl_root" },
>  	{ },
>  };
>  MODULE_DEVICE_TABLE(platform, cxl_test_ids);
> @@ -531,7 +566,41 @@ static struct platform_driver cxl_acpi_driver = {
>  	.id_table = cxl_test_ids,
>  };
>  
> -module_platform_driver(cxl_acpi_driver);
> +static void cxl_acpi_device_release(struct device *dev) { }
> +
> +static struct platform_device cxl_acpi_device = {
> +	.name = "cxl_root",
> +	.id = PLATFORM_DEVID_NONE,
> +	.dev = {
> +		.release = cxl_acpi_device_release,
> +	}
> +};
> +
> +static int __init cxl_host_init(void)
> +{
> +	int rc;
> +
> +	/* Kick off restricted host (CXL 1.1) detection */
> +	rc = platform_device_register(&cxl_acpi_device);
> +	if (rc) {
> +		platform_device_put(&cxl_acpi_device);
> +		return rc;
> +	}
> +	rc = platform_driver_register(&cxl_acpi_driver);
> +	if (rc)
> +		platform_device_unregister(&cxl_acpi_device);
> +	return rc;
> +}
> +
> +static void __exit cxl_host_exit(void)
> +{
> +	platform_driver_unregister(&cxl_acpi_driver);
> +	platform_device_unregister(&cxl_acpi_device);
> +}
> +
> +module_init(cxl_host_init);
> +module_exit(cxl_host_exit);
> +
>  MODULE_LICENSE("GPL v2");
>  MODULE_IMPORT_NS(CXL);
>  MODULE_IMPORT_NS(ACPI);
> -- 
> 2.30.2
> 



