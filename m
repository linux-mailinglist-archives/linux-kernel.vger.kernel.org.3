Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D2655B1475
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 08:12:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230220AbiIHGM2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 02:12:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229546AbiIHGMU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 02:12:20 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A90AAC24D;
        Wed,  7 Sep 2022 23:12:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662617539; x=1694153539;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=Jq5nUqdDY0XiptJAM8OXI3H4HoMKjBo5Oa1FLNzCMr4=;
  b=C7G6081ogh0/ZIkJWe+WS62r8hGQevIjBX1PCi/e02vN3mBJx59wb5LG
   J2IogSxLocuDu09PJDHVrUVUSLz/RqW6p5607CWC/XPAnxWW2kYqZJSON
   7+OA1//0xV+c0XYsBUHnwRcSQjUcgL/V3ZzlIbE1feze9A/zE0b+QcU2u
   2XTjHHgdhZQ5t5y6PPtxkYXdw0btxmO/zt9L674gVw6ToMC+JXoRVlcPG
   TNuW2ZQQJf9w69r4ksPlGjA21t3Nu6TscJl+UiNc0NIlh7oCCU5+vM62J
   1CPPKdw9gUU8Oxr29uL9MQFBAg/v3AuS+evxIuAopJGcWR9wP6Jm/C4PE
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10463"; a="323269924"
X-IronPort-AV: E=Sophos;i="5.93,299,1654585200"; 
   d="scan'208";a="323269924"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Sep 2022 23:12:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,299,1654585200"; 
   d="scan'208";a="565813288"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga003.jf.intel.com with ESMTP; 07 Sep 2022 23:12:18 -0700
Received: from orsmsx608.amr.corp.intel.com (10.22.229.21) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 7 Sep 2022 23:12:17 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX608.amr.corp.intel.com (10.22.229.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 7 Sep 2022 23:12:17 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Wed, 7 Sep 2022 23:12:17 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.168)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Wed, 7 Sep 2022 23:12:16 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Vh5Padfx/iIAvkVvhVkHzUIHfiBgIm9C3oW5RJ310Q+Gzj8Nm6KMpzJm3C3sR6JoLk1kFgtzIa/YjL+OPIzGMgHp0jpqgKS9vudz1UafXAGVNEMifepxUFhrduswbg0vOfEHSkCbSD8jHtP+N1KaCn3bwLZl6q43NViTXJO4zgQb2Ha6km01P6TEpEf++JttJlh8yBBQ/Kb+PSNYGpPyLDvdFyiDe/Kx1U0Zn3axG4oap3mvtsKquZChK2klEmZIdXMUJFcxRNiSY58a+len5DNWENOU43eilIBfVYyyACBf7xBAjeVeRHi5+iFzS6La6v5xakpTrkeVBL9y0D6cNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xuv+Nn3LEIZQABIghHD5kffD3q2HpSbHBMjyiyTLz3M=;
 b=HIsoLmhc4LvMuaId2kkVnjSiOo70bUD+haZeVCsaIpQo/qJxZ4F/Ki68sEHiTb+o1I/m8FcYaML+dP7J1WIYEJrMQuSPNdLej1XYx9624+nX7/Cbn4PTGwb5bKJJYSl1EecRC1Ip4dmOfHc1/gbFkztjMOQYM6ZGHuppjiLj7z3TMYOexTcUy+qp4HhEftSM9AL0hVVqRbe1qyTsYYxTd7dL8gL1L4OgJrCBmrAOoLnPImLYJl2oHt+T0xdVd/lA0pYTxn5BYdRUjD+4Eh9ZJVKAGwGP0SHbDND9FESF6gQqZdQy8eZ9floKOnO7P7r/8ozoxAenXs3ZpeT1LzVHmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20) by SN6PR11MB3056.namprd11.prod.outlook.com
 (2603:10b6:805:d4::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.14; Thu, 8 Sep
 2022 06:12:01 +0000
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::9847:345e:4c5b:ca12]) by MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::9847:345e:4c5b:ca12%6]) with mapi id 15.20.5588.017; Thu, 8 Sep 2022
 06:12:01 +0000
Date:   Wed, 7 Sep 2022 23:11:58 -0700
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
Subject: RE: [PATCH 07/15] cxl/acpi: Check RCH's PCIe Host Bridge ACPI ID
Message-ID: <631987aedd464_580162945b@dwillia2-xfh.jf.intel.com.notmuch>
References: <20220831081603.3415-1-rrichter@amd.com>
 <20220831081603.3415-8-rrichter@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20220831081603.3415-8-rrichter@amd.com>
X-ClientProxiedBy: BYAPR07CA0002.namprd07.prod.outlook.com
 (2603:10b6:a02:bc::15) To MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 41f51791-7bc0-4d65-9326-08da91610b55
X-MS-TrafficTypeDiagnostic: SN6PR11MB3056:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: i24CzOInPYT7y/wsP6E5NmZk4NiUNxv0IZp8QemM7Ul6qChlUh8nn4WHf7mpwb3UYLRV2CA0wlyGcFtjfLOM628M5DSmiJF0rCvxEZSen3FirhqT6b+jQWZgjgHhb6i9NzJpUIVSbCVQyycJ6Eo1v3ATGqFUNm0Q4RTB/1856OfeNQXDij+zG8Ei+63j33B35Ca2bJW5DZTyok3l2syEMP1hqUyAqXGQ0F+VAA8ezwBkkxAx3hnI8L0szB+PDIFQ1WSXJ+WxGV+XsEMjsq4kl2CBL5U/PQGd7UWTuCuqxao8yCnhjURlU6nTY4ZYNX5crYWefP46QW+Nt2cOptmM3hRdKHs6YHE20iB8cN0LzpFUYhJTMkufQ5HPSj7O0oa+Q0wEl4nK2MIpx1ZvJWxxiGCL7PtbMdiCRafz4nm1AGkU8mZqZHFtr30Py5wECIpE2ppMLtmAMUFIlh3SxzEMJqkbPxbFHXBqMIDpz8RgU9zilHUe7r4x/2srUl5Rrt46o0Ay/TqVbQtgs4zDAYhSUDxKr7gsEYJBP7+ZfGAfzhaRM8n73tJat3xeLjgrJ+v0RgWL6g1gijz5gtYY4JORNkCogAlj5yzwQ9MYWpXLdjZQXoAOc02irVCYZja0njsxe17CXmK1S4rJ5vkPVkHU0EMMZu4IjRSeOnWvdvdZGDO4MxLpOT9R/gqCzHy8tMmhGn8PHKl9QS9pUn/ybr2jKg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1101MB2126.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(136003)(39860400002)(366004)(396003)(376002)(346002)(82960400001)(38100700002)(316002)(110136005)(54906003)(5660300002)(8936002)(8676002)(2906002)(66946007)(66556008)(66476007)(4326008)(186003)(41300700001)(6666004)(478600001)(6486002)(6506007)(9686003)(6512007)(86362001)(26005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?iLwn9pOHIVObIZpMRHbixAnwFEtt3zIuQR40DLJP1exjjbjqGVHguJC7JynZ?=
 =?us-ascii?Q?tP0g5GQ41NJ5IRTmg+zJmmEvSbzUa8kGl3AX6sVzZCYiLsJx/Rn74Z+nMyTP?=
 =?us-ascii?Q?sPmskDTbvzqNtYCxs0M8s5E7icsutFuqS0uIfrmh2MIZbEyDl2WuWhdd6Cx4?=
 =?us-ascii?Q?+jpRrLWXegi/gXroQJoA7gDjSf47iK68KfKavIvtcWVclrgzZXWtuajpXpGr?=
 =?us-ascii?Q?S+PDyw3ItZIir5aXY0gkF+ieYkPy+WHMp5A6ItohzDLRSysM6133UWaYupyT?=
 =?us-ascii?Q?oRhlPBYs7QiDEkNCPMEJBfeSzAYxNu8dm/0VbFtx3AAYJgPr2vzoazv5MDic?=
 =?us-ascii?Q?ZEtKKFOI4oAMMKvAIOORcdGJge9CjH82rUJtcPRYrif5CA/GXYbnGCncs6gM?=
 =?us-ascii?Q?34ByKQYPHhs05ZsgAIN2rWyonulP18pYdD9eUlWTPKlzLfgn1T4o1qgwkCFa?=
 =?us-ascii?Q?sOLcyY7z8RL7bibjQJpMGVB829BfNOXXK6QiZqfCTt6glIP6yvD+rwLlogQP?=
 =?us-ascii?Q?UGa0H6jirmBMvErOP+3KzJ4vzKSqp1bGiu6dgAIGf7SBXxecmfTb/IZyoGPm?=
 =?us-ascii?Q?7mlEEyICWuAjuC2EA1oaj14Q0V2DOxgf4ohRutzd9OLQpzVYylOL8HlsO3zi?=
 =?us-ascii?Q?hVmDI0trVA1o3LYvBxKFXEqhDzVLk29u+sbe5OcByVrSHoh15XXSS+sfIJ4u?=
 =?us-ascii?Q?PWIdqpETZzMgWM0wA6xKQkODIs7rxDG31PMSSBNlU6tVCfmXihl8wyjeVCp2?=
 =?us-ascii?Q?aXFU+dxmDq3xgT9Q6Kvsfvm8eyT3ANi4Uwrj4EMBDJp4EdCvAyqOdsjRkCs+?=
 =?us-ascii?Q?p4AgVL0dFrtph8xMmAyCxzQ4q5/ZgTj/dnksZ7aF66Gmn46U4wolN28PcDT+?=
 =?us-ascii?Q?DeXjJA+ZfovWIuCHz7DxNmtL0N99M0jmukojfG5hzrvpyerMVknCIPuxrqYY?=
 =?us-ascii?Q?YtGAzIft848MOgJM9BTN4abSCjAl2emWHyvfOJ946fQdjY3pSrXoNjs3+b6E?=
 =?us-ascii?Q?bIVfwfqxOLsKi+cqHma6ylGfVxbNY+20eD98WxQi0vGLf+PEpU0dRpsa4HFv?=
 =?us-ascii?Q?+8UdfsEaZTkAOZ2lpHAYzA2LsCTdAvGn1XjO76cuFKUFHCZ7RYqkq8HnaYjg?=
 =?us-ascii?Q?kSuVpOyKA8JtwnieNg4XXL/baSY/uPIwzVAyxnPhJOWWLFyuzLd/AkFC+ZuX?=
 =?us-ascii?Q?IGe7mq3BjfYPA7G2I6Dszet0lF5dRIY/WAI7GaxZoJrtXfKr6WvLfX9SY24S?=
 =?us-ascii?Q?yg1H57MGFbILhmJ825OH2t4fuRaWKZXH3f+xcMwJmxIMuUYqEJ/LyPyCaYly?=
 =?us-ascii?Q?MrvbdLWOOjLOavB5JK0Neiqysnh76EYIEn0ZyB3cNmQIXZoU1cazHmD9v3la?=
 =?us-ascii?Q?1CcgTc/oUvWtncPIIwhs91YdKsAUSazKXU5NdXVdzb/xsjbpgYCbbQiUUX+F?=
 =?us-ascii?Q?+mHLpzk0Tmx77a0T0DTkKJzaWrrgfhDQ3j85i/UVqyAwc0EnNCmf3BgybIU/?=
 =?us-ascii?Q?e1P9t6mse7MEKYRhKd+TEUQWOsfi5/qHezyOFysTAXo4ogwAju5sPndoyzFj?=
 =?us-ascii?Q?vt3VLsW3SBFh2q1g86iAm9kFsel6zgyeTR3torX9OMGS10B0k/0x27QlvxFi?=
 =?us-ascii?Q?TQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 41f51791-7bc0-4d65-9326-08da91610b55
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1101MB2126.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2022 06:12:01.5452
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1y0GNhl29rf0Zm6HgOQgG/2t0zibZLDRsJ80hLZohIbfMhWWllNZ5oUhLPm3hs9mwwE6yibhuVgB9inGvXHWdChrtfMV9uOhV9arA5xgSn4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR11MB3056
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Robert Richter wrote:
> An RCH is a root bridge and has "PNP0A08" or "ACPI0016" ACPI ID set.
> Check this.
> 
> Signed-off-by: Robert Richter <rrichter@amd.com>
> ---
>  drivers/cxl/acpi.c | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
> 
> diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
> index a19e3154dd44..ffdf439adb87 100644
> --- a/drivers/cxl/acpi.c
> +++ b/drivers/cxl/acpi.c
> @@ -312,9 +312,16 @@ static int add_root_nvdimm_bridge(struct device *match, void *data)
>  	return 1;
>  }
>  
> +static const struct acpi_device_id cxl_host_ids[] = {
> +	{ "ACPI0016", 0 },
> +	{ "PNP0A08", 0 },
> +	{ },
> +};
> +
>  struct pci_host_bridge *cxl_find_next_rch(struct pci_host_bridge *host)
>  {
>  	struct pci_bus *bus = host ? host->bus : NULL;
> +	struct acpi_device *adev;
>  
>  	while ((bus = pci_find_next_bus(bus)) != NULL) {
>  		host = bus ? to_pci_host_bridge(bus->bridge) : NULL;
> @@ -323,6 +330,19 @@ struct pci_host_bridge *cxl_find_next_rch(struct pci_host_bridge *host)
>  
>  		dev_dbg(&host->dev, "PCI bridge found\n");
>  
> +		/* Must be a root bridge */
> +		if (host->bus->parent)
> +			continue;
> +
> +		dev_dbg(&host->dev, "PCI bridge is root bridge\n");
> +
> +		adev = ACPI_COMPANION(&host->dev);
> +		if (acpi_match_device_ids(adev, cxl_host_ids))
> +			continue;
> +
> +		dev_dbg(&host->dev, "PCI ACPI host found: %s\n",
> +			acpi_dev_name(adev));
> +

Again, finding all the ACPI0016 devices is add_host_bridge_dport()
already does.
