Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA0E85B1432
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 07:53:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229956AbiIHFxV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 01:53:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbiIHFxU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 01:53:20 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF1DD9E2E7;
        Wed,  7 Sep 2022 22:53:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662616398; x=1694152398;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=hmIxEfu9I/7XCWHoTFufXVtKxPncBkH1V3JRcrBbGv4=;
  b=aeK4wNZivJy76Nvs8XeYzBog3tXTfRavORcWXNEz+6327mjAgx/eJBg4
   X2Syo3Rfom3GbMWJt1489HnTI5ZaH8kHoM2wTVX43C5Kjo5CrofvPYVh1
   BJ7PS8MCDanBKW0SJnFYMi/jl7LlU6SvkNC09khh3QxztJZ4F2pzx5LI6
   4e7R4XXpr5KY0kec3WhFpPvJDDDGcpoJ4qfvHJYFpyVzOj1S0s4dwT4j5
   /lv5BGU8bT9eECMKFjqkT1s+F3aLE9v2qXV60bjqQen2fYdwu4Cd4zM+a
   uxWlsvE6DlPm5mvmLrn5+OUfHWxAb9ZnaBX9I7qegAKlOOx+HJCa+GbSc
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10463"; a="298412518"
X-IronPort-AV: E=Sophos;i="5.93,299,1654585200"; 
   d="scan'208";a="298412518"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Sep 2022 22:53:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,299,1654585200"; 
   d="scan'208";a="565808480"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga003.jf.intel.com with ESMTP; 07 Sep 2022 22:53:18 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 7 Sep 2022 22:53:17 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 7 Sep 2022 22:53:17 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Wed, 7 Sep 2022 22:53:17 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.102)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Wed, 7 Sep 2022 22:53:16 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nO0iJdkolc/MAYupcg7bNJhy39E8KEHgine1xZ0eQCVi8tlHgLlGBPxUjAEoWzVUdW+BoIhAvqEyzRcJbXOs5iNGdUos73Zbz9ffD0B5bkqrcK30S0ozzZUXqdkcnNVg9cSCIRf+XrfzSlmC9zxK8445jErKMUXjsVrghHyc4M6ZYmVAx5p83ARDuq+j65jRsNpPmmvpyzXKNAvfUUbd1lvIiKemqzIKSbIq0PPPyL9pigJT3Wb/TGDUGrXI7wwmtN93cii+E9ASqAUHiL8OQppS9xcq6GymGHzzLIuzl+7V4fIlqq+tRogQ0yjd9KYbmKG377uxX4NkcZOBP9/2lw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jekewYQVQKuxcnKSURUUKFSgS76ZWOe0WDzNRu1qktM=;
 b=FZbySX+Qef5NJtYS/ditNJISMn/67QS65al/kbjaPfGWwC+4qTTCMxVB8Pexcy/PzQRKot5c0SyuNyKgloF3uGFgVe+D4V9VQ498KBByv34F3Eoi2/l1Yo6r3w7S7FMKwBpl5QW/YJUI0m/Y+U+5KMWw7bEwEJAdHNy4Ok09lTaP3ymKTqZx3C5WQ/PRpyVLUOysqoPfXTDEnDWBXUiJK6XLEOUGHcu/QvdV1ScksRuewt2XfzkXCXq0HWrdzNfTAVUVmol26jjFsD5FLWPtwxCLqXljDXkgWGxB4lOygCOHlX6KOrIUab1WfFzazzpXxfx/srZ/xt8kL6WNTFYsAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20) by DM6PR11MB4426.namprd11.prod.outlook.com
 (2603:10b6:5:1d8::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.12; Thu, 8 Sep
 2022 05:53:15 +0000
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::9847:345e:4c5b:ca12]) by MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::9847:345e:4c5b:ca12%6]) with mapi id 15.20.5588.017; Thu, 8 Sep 2022
 05:53:14 +0000
Date:   Wed, 7 Sep 2022 22:53:12 -0700
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
Subject: RE: [PATCH 03/15] cxl: Unify debug messages when calling
 devm_cxl_add_port()
Message-ID: <631983487d3d3_5801629418@dwillia2-xfh.jf.intel.com.notmuch>
References: <20220831081603.3415-1-rrichter@amd.com>
 <20220831081603.3415-4-rrichter@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20220831081603.3415-4-rrichter@amd.com>
X-ClientProxiedBy: BYAPR04CA0034.namprd04.prod.outlook.com
 (2603:10b6:a03:40::47) To MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 57b1964b-401d-43af-cb96-08da915e6bc8
X-MS-TrafficTypeDiagnostic: DM6PR11MB4426:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Lh/zMpKQ/THn5z3XYO0VMGbB7zSqDxEPX1dHiNjj/vUUsOLLCYHH8b9Srz3rn5VA//7RCuWmywmXo2pOt61ukd74391mEnaiMegwQA4fQl8N/OQWOgCkG9RsPXTN6QKzPQbmTlbNVbzguTaHlHloZc9FJULCAea+cRxHApgJXImhvsp76C+jWd8f8Xzgbv1hdLh+Pf/xLDrVqi3ZRsHoMOFbFMg4yjPmrjo9Zt63RHYkgGx9RtEmKZk5uV2tnRZy8uqmDbMJTqkh+nKS1VUiOyYvU6fawRLvsWB6E8PNb8GmuJbgi6DJgJr+DqYfPPJ0J06UdDA+5pxhZN+wJMkSbxy8mrJ6YWrgujVfoUwcuxkzJFDxKQaRCBveKBBR8n/4Oa1qDeWaKYV8hx/PdyD2xdtSLSjyK2D5wS2azLCWUZUeT1hLRq8LvXsZ+j3+0Rivw80LQ9hPOH0ZJjCXWZBO7wwLWoizby+6hrtU5QoBZaQXPdwy3eOFUXNwNZId39d+cyWFkz698khKyxGYt6ACjLXsaIpebhj8OgZJmF9gtnK0/G3iWtEPBf5PIPRJ4rxpA22r9D5NsVh5ZNx1degJX5wth5DR5/8IkgV4wbImGijJqfjVFe82ZWcYD4VLx6zTH6sTGBmPaFoHcvxmyAvzvWqkcnPT/lfJyrtni0hINzCygLhgHND7pSRUqQX27akfe6o+6pE2o/RgFYqsnTMmrQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1101MB2126.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(39860400002)(346002)(136003)(366004)(396003)(376002)(6506007)(41300700001)(26005)(478600001)(6486002)(83380400001)(186003)(15650500001)(8936002)(9686003)(2906002)(5660300002)(6512007)(110136005)(54906003)(66946007)(316002)(4326008)(66556008)(8676002)(66476007)(82960400001)(38100700002)(86362001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?SjMJyUigfNLHlLCii/nanSajCcSdkrHL9lI4yyot/Abr8TaAm8e2UyH0jkCM?=
 =?us-ascii?Q?YOvlS7seSMQpUiAojNDVYblunnBXYnX5TVRQctz9wbP/GAhp1c8KHmVMlF50?=
 =?us-ascii?Q?qyyERWNBpKGgVw1X5qM2ewamwd8Fm6SbhLoKK3pmXTNKxsMTY73+s4aZzxeX?=
 =?us-ascii?Q?cpTnO7UXu7PndhB67dQPyvIeaxkIjf9fWG+pyPqPpwf9rIENIBVnnz4PwcnB?=
 =?us-ascii?Q?17LsQ63tDUMQXwuUJ+x0zTyxC2Lc8oShFON3TgQijUI1K9gKW57wxLhmYtAH?=
 =?us-ascii?Q?cd+nZdtUotS4tGJB0azab5iyFmo3E+T3YV8mcIJynQlzKrNu2NfyLcs7yZUS?=
 =?us-ascii?Q?UXkspLUdzCdQcgWO8JdLDcNaC/1cEn3UrHRgCbpRvxOZH4KSH/xtJeQQ7mGL?=
 =?us-ascii?Q?WvqxcUq2x4IMSJIJ/RKE+jp1peMvRzjy0Q8ZxIr583ZxPuUw/fiWMncNF0xV?=
 =?us-ascii?Q?4n06aaxP0wSAfv19SV6I4zc8ZNsM88IjL44ks2JqhT76eDrAuP0gDAZxEjFD?=
 =?us-ascii?Q?0TO6NqtCGdbNidrf3Cb0F6F3odgPVxhJdjHRzrYqVq0N7EJ9OI+dcpIJFhbz?=
 =?us-ascii?Q?ghgswhG08jwh2/JbFRD/OQ3j5QoAW8FDzksaSod5WrA4oR/VE6CHZX8ufXEO?=
 =?us-ascii?Q?c8f3jLWO0Hcb9DTljX6QIP7uwtJLDdUWYnwQ6gW/h+VyxQ22dF3t0YY2OF83?=
 =?us-ascii?Q?2EAMqJI2EBBCLf8X9P8dv6TdJBtSnKT12yi3VfStJBpv7n+0ZWuy0ofzb9EN?=
 =?us-ascii?Q?7CTAzNqB5psqxbIKO/8GcVUB+koX1NbKwVcPmUtEiRir8ibLIzkPoykXbR5N?=
 =?us-ascii?Q?gCqvC0bDtxHnDOigD9DPRItzHAugNkOLTmvxfc3J4GQIQLwCUByDSIa1pPZP?=
 =?us-ascii?Q?vyk8xxixWNIN5knfUqX8FeWaLaYDr0tiBg6vll2Y/91gNHxryNb5srZ0fgMt?=
 =?us-ascii?Q?dAhzUgMNFUe1X4duV0UiKcqd+zUNTfHdlucMxrS87rjgnaelRXHrSrsa7Jzo?=
 =?us-ascii?Q?u0qfQ8GEyoufYkmooyvM08ADsSJIGgYBWZAStm3y8MNAS1grkrFJkB03TLLr?=
 =?us-ascii?Q?c5xai/Du2R9iffTWyzgPz/Mz2o7MI3rCWCuumPcMi1AjnZl9mX2hD4jYDiKM?=
 =?us-ascii?Q?bLD6YwLiTB3jV6D2RCsoyMzBBs9tfoK4mWDDsuBciRYYA5OCDvzu1eSyUk5d?=
 =?us-ascii?Q?+yiqxy9tRPB83kJVQIauAepD8NK3E7k+X8VH/WsHoYAUlRVPY0/nqRq5bleY?=
 =?us-ascii?Q?5GrW+MAjdobnXdomt33IqNudfuDdS0EwranmM+eAOJ8p6Jpl7NTGz2I7nlzP?=
 =?us-ascii?Q?kCB8185n6T1qVoaS1h28lxuldrKoh7wLXMyveQmmOxI8c1o0ytzKWXeEmDbO?=
 =?us-ascii?Q?PQle0wLRjngrEjdVb2Lf6kMs7Mk4rlCde72npxSnak2NFufW1ACRxgMC7MJM?=
 =?us-ascii?Q?Co7zgoLvV3xB8Pp6eA64MvPzYCjL2OAQmKlILmfz0myvH8egLbH0ODLDOSF5?=
 =?us-ascii?Q?yAl/arP6npW3wA+qhDxX2At1zvmvQN0F07YuF0YPTZJfJ+K+XooGoOQaVNow?=
 =?us-ascii?Q?jdxKnC3cnRULyuDeiuZXTamcypCm4pIdn9TlbqhIjt4sgggNkOoJ8NrrIhHa?=
 =?us-ascii?Q?Ow=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 57b1964b-401d-43af-cb96-08da915e6bc8
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1101MB2126.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2022 05:53:14.8714
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vsXIOCRW9/zsc7dYQauD3SK2qm8Mba5Q9efpU8i+xQ2WmQC2lflTWe/XLZc/vB/K6+Wt0bxWZQbbdCyUnYhdlh32/jmG/qu/S46F0luPGQ8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4426
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
> CXL ports are added in a couple of code paths using
> devm_cxl_add_port(). Debug messages are individually generated, but
> are incomplete and inconsistent. Change this by moving its generation
> to devm_cxl_add_port(). This unifies the messages and reduces code
> duplication. Also, generate messages on failure.
> 
> Signed-off-by: Robert Richter <rrichter@amd.com>
> ---
>  drivers/cxl/acpi.c      |  2 --
>  drivers/cxl/core/port.c | 39 ++++++++++++++++++++++++++++-----------
>  2 files changed, 28 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
> index fb649683dd3a..767a91f44221 100644
> --- a/drivers/cxl/acpi.c
> +++ b/drivers/cxl/acpi.c
> @@ -220,7 +220,6 @@ static int add_host_bridge_uport(struct device *match, void *arg)
>  	port = devm_cxl_add_port(host, match, dport->component_reg_phys, dport);
>  	if (IS_ERR(port))
>  		return PTR_ERR(port);
> -	dev_dbg(host, "%s: add: %s\n", dev_name(match), dev_name(&port->dev));
>  
>  	return 0;
>  }
> @@ -466,7 +465,6 @@ static int cxl_acpi_probe(struct platform_device *pdev)
>  	root_port = devm_cxl_add_port(host, host, CXL_RESOURCE_NONE, NULL);
>  	if (IS_ERR(root_port))
>  		return PTR_ERR(root_port);
> -	dev_dbg(host, "add: %s\n", dev_name(&root_port->dev));
>  
>  	rc = bus_for_each_dev(adev->dev.bus, NULL, root_port,
>  			      add_host_bridge_dport);
> diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
> index bffde862de0b..8604cda88787 100644
> --- a/drivers/cxl/core/port.c
> +++ b/drivers/cxl/core/port.c
> @@ -666,13 +666,17 @@ struct cxl_port *devm_cxl_add_port(struct device *host, struct device *uport,
>  				   resource_size_t component_reg_phys,
>  				   struct cxl_dport *parent_dport)
>  {
> -	struct cxl_port *port;
> +	struct cxl_port *port, *parent_port;
>  	struct device *dev;
>  	int rc;
>  
> +	parent_port = parent_dport ? parent_dport->port : NULL;
> +
>  	port = cxl_port_alloc(uport, component_reg_phys, parent_dport);
> -	if (IS_ERR(port))
> -		return port;
> +	if (IS_ERR(port)) {
> +		rc = PTR_ERR(port);
> +		goto err_out;

While I agree this unifies the error messaging I am not a fan of what
this does to the readability of the error exits. What about a compromise
of renaming devm_cxl_add_port to __devm_cxl_add_port() and add back a
new devm_cxl_add_port that does the unified debug messaging?
