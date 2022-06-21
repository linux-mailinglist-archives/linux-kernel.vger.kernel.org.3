Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AEC9553CB9
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 23:10:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355889AbiFUVKA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 17:10:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357021AbiFUVJ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 17:09:27 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E51DB3819D;
        Tue, 21 Jun 2022 13:56:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655845006; x=1687381006;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=DMLu8GyqYFep9IZls6TVhw57TxeiDFtrj/EX+006c/U=;
  b=TuPJT2wC5tsen/wlCE7JFZ6mSaoNkqDBzmupD+3RWMBfd0sdy4yC/nFc
   JIUsNakjVn7UYdftfDfnmUeg4799skAfPphd/Md6lt+EOkKdcSCoUJI+T
   TdwESxOe3dYHTBvLFueswdrwCHbE0TWNBulIJ/k4NDhWm/kKzvbDuvquj
   kgmCLvmx/ztYLzdGjHKU0fpuGbSBTTaZHaiNkpaJmiHPGYeDY2Aazd7Pu
   prCjTuFHM8C49sgRxa9msZbrfMokLjajhdcWPqC7YMgfAPIKxmTEVKpkX
   2wMmvl5zaaZDWwlEr+ewR2OEfuJvhKC/3WMnx8alTIwBRMF+jL6yy5m5F
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10385"; a="344227227"
X-IronPort-AV: E=Sophos;i="5.92,210,1650956400"; 
   d="scan'208";a="344227227"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jun 2022 13:56:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,210,1650956400"; 
   d="scan'208";a="715126024"
Received: from orsmsx606.amr.corp.intel.com ([10.22.229.19])
  by orsmga004.jf.intel.com with ESMTP; 21 Jun 2022 13:56:44 -0700
Received: from orsmsx609.amr.corp.intel.com (10.22.229.22) by
 ORSMSX606.amr.corp.intel.com (10.22.229.19) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Tue, 21 Jun 2022 13:56:43 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx609.amr.corp.intel.com (10.22.229.22) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Tue, 21 Jun 2022 13:56:43 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.108)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Tue, 21 Jun 2022 13:56:43 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aenk+LltRzE9aoxtdCz+0+/Rb0OaAkI2128ZdiCb6aPwq3j7nyVS02TYrNIBET3Ix96JX5nGmEVkE7Fh+drGhcRlvce8kFdfXSE6kNgyJw/HWZ/pbhayPxiMTU5YuYH/O2P3/kbAB5anEh1e4jt+/aDoKKL6zsuvvoVY3rUSmEtwPAY9d506tS7y6ontQ4+VNbC85wupJbOADMhTYwrUhm2kgfnTwiALeK1CL6bzRe1LT/DSkGNsZJXO0+7Y8yWdl8XMa1HOzXPcZl9w53z/JugmQjaa8XDu8vyt/j1hEU211Dh0P1E+zzzU4NqPnDUl/2nAwatmAZUZNwdSpCB35w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Wc5sBW8uMpMgxsvLrUCy1GQwPNlNF2Ief29KI0eF0eI=;
 b=IBiGlWkpOmcymP/5qxKuVat6nhmrF5HkFCWd0C0gJ8JUO0Ng0vXXqoGPEso4WdPzilrqfrjDVLKiurAeQDmdyJf/oJCDrM2qx4g8qLX8K+jBzy3lbe+CKYz0TylZtSj8EP4pTTUhUubZG+VAO/tBYKV/0Dm+XwvGpTobzr5lJr101OAuOZHYWSUsx5agy/n9iQSVwfo1LGJnQeZDeTEYiMlZKlS5NrDzUJkKG284IKF3xhLoe3PPHWs0kS2oMr32BrW+NNawQBWI6Li2LfHqzWnOBHPK6t0hhLbSmE+j4hPnXdR5mT46RyX1kQSBZUIuqS77ywLU+u9sDSlNUmxV3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20) by BL1PR11MB5254.namprd11.prod.outlook.com
 (2603:10b6:208:313::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.15; Tue, 21 Jun
 2022 20:56:41 +0000
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::f50c:6e72:c8aa:8dbf]) by MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::f50c:6e72:c8aa:8dbf%7]) with mapi id 15.20.5353.022; Tue, 21 Jun 2022
 20:56:41 +0000
Date:   Tue, 21 Jun 2022 13:56:40 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     Davidlohr Bueso <dave@stgolabs.net>, <linux-cxl@vger.kernel.org>
CC:     <dan.j.williams@intel.com>, <alison.schofield@intel.com>,
        <bwidawsk@kernel.org>, <ira.weiny@intel.com>,
        <vishal.l.verma@intel.com>, <a.manzanares@samsung.com>,
        <dave@stgolabs.net>, <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] cxl/acpi: Verify CHBS consistency
Message-ID: <62b230881a77_8920729456@dwillia2-xfh.notmuch>
References: <20220621201259.1547474-1-dave@stgolabs.net>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20220621201259.1547474-1-dave@stgolabs.net>
X-ClientProxiedBy: MWHPR10CA0008.namprd10.prod.outlook.com (2603:10b6:301::18)
 To MWHPR1101MB2126.namprd11.prod.outlook.com (2603:10b6:301:50::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6cfbc711-5061-4d8e-9c76-08da53c88af3
X-MS-TrafficTypeDiagnostic: BL1PR11MB5254:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-Microsoft-Antispam-PRVS: <BL1PR11MB5254710E9D72A4C174563F75C6B39@BL1PR11MB5254.namprd11.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: a07HkUCg609ztVNEMwAaF59PVRr1IhJm1a+NSdqJ2wBop/+su13lA4F+mV2izPh1GI3LOmB2vuIXRmTZBxOmAHYpexH6VXw6isv/ddVe8ccxbrzNTBMxiXQpNPcYHOjAXLkRTdmDEYdO4TrQ2kC40bGsRTos/hJi6hMnZbC3EBdamZHl1wN6UDLD6fAAx+pcNlxLuFg2/+tGpWv1gsiwiPt4vD7E1OT6DGbzjLpuDcbkkzVRFNPLIhKbI58OhDT3apmFZ5esfoZrGHqfqHKXbJZu5+U6E3iYR4OyaGBAK1Dmxtz9o70LqfhvrcigZkGhG4lVwFXWlyCnCldqC0aqdvVAEcKiaSXXj024lCFz6mQjVhV1xU6pOeQNMkwZPziVeBJZ1VFLTlezjLX86+utvFzX8Ig5yt/7ldVZTnGEmOm+iSQKAkr15YLEzCq8t2B2TMDFRP68cQqeDd0SbfZmn3ZxCY/sE38txWOkQdgT+XYZPKTEGd+AuOWpy5YpxDxq1YHV5RYWaPZnXLoBfOUzKkEencxm2wrrNWfRc2zAIWB6FxIkLELaHrYV18xIWbwgjW8Rxcj/vTj1nf2a9rV/BiuNg9FGTQWWEGkxRtAZbhuTYPr9IbeJ8cTN8wy/0E0maEv3GRaFzp7eJ68feKhD3w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1101MB2126.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(346002)(136003)(376002)(396003)(39860400002)(366004)(26005)(9686003)(8676002)(82960400001)(5660300002)(86362001)(41300700001)(6512007)(15650500001)(38100700002)(83380400001)(2906002)(478600001)(66946007)(186003)(6506007)(316002)(8936002)(4326008)(6486002)(66476007)(66556008);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?j6WEm/tFzQiTn6xDbOxTtbwd3aERToqzHCMvHymaJSqX2zYuMUOn0RgNX/9w?=
 =?us-ascii?Q?lWhpzE4OmhiGMZTgOAiOQA9Nsy/200Ijn5AF1ClPYTU9lnMWDAtc7JICRH+A?=
 =?us-ascii?Q?GwNjUmtafDtn7HeK1+v0AEIJbyv3JIpuVo2kaKE690gUjO5lmuYENyAXCN4S?=
 =?us-ascii?Q?UXmZLrAvwzibdJ5h9ntL8fRgWWiSqcY6AEnxwgl692k1uHGnuU54b6dUppRd?=
 =?us-ascii?Q?ba1jBVaL7LgQtQ9Irc3WP9NTOGGiptUy7DUEOwkEvd4jdm5XnfjAQ7Tqj17v?=
 =?us-ascii?Q?rrRBi4ehW59A32pfZcIiEekHczWv2RIiUV1fOHr6hLcZqjljs6fkWgF3QMrW?=
 =?us-ascii?Q?K2X6STcgTnFgfQ6rFzV1iLk4gnK3U6oIXpHGApd5lyxn4sAiQMAI4U/kDupf?=
 =?us-ascii?Q?WYa8Au0ROKwnop4vuyb/RGl7TsEQbjeo0nd5Kg905nozG0Vb1VZ/f0e/Zc69?=
 =?us-ascii?Q?u48V2lQWkFCxPm6WOGy+opZMYU6P6ZeiKj8cg2dK+w/TYMjXiwLTWSzp5/mj?=
 =?us-ascii?Q?9Zsc1BSFxaXHNJCUWR4PUJC+vI2Lj6xB7Qx1hPVds2lw96fHxp3nGEbS56aF?=
 =?us-ascii?Q?yemumaNPIpfmM2dEl91aHhFVYBoQ3k82lO5rtJzsaw0KwcLHfaLfOi35qTxo?=
 =?us-ascii?Q?T+fhcPytDuuJJPkPMWNA0+sfrFZwU0Ax6eDl8DAFhEBs2YsCqlKxF/baeohi?=
 =?us-ascii?Q?8P1DOlZfAwqTWxgNY9Ah4Cqf/mGFPJl3inBlu9LdVeH3/FxT7Lb49NDXVxxB?=
 =?us-ascii?Q?iOoNmcvbYhwvmzG/Z7MBGJSSywbfQVK/rxUyCzLZsOyaCaosDSuFM9mGX4F3?=
 =?us-ascii?Q?p4N3sYDlVrPZU1PTV9RpXt393zBVLAeXxLl22q3wJNv5i6+OPNcUZndNxgkQ?=
 =?us-ascii?Q?f7Idve71X5rABGWAcGQUyWjWeSMI4FKiZHz0iD4skYCWteughVjQfA1CN5vu?=
 =?us-ascii?Q?DtjhNNVSnKzE/SgAoSocpjvR55px98yTo6djFIBu79i4glz9XSzGm43Ma98d?=
 =?us-ascii?Q?8t35Sy7I5nnQrLk9uTN/IaCkq/Gq0Sa0kzn7s/b7X6P2tFh6ex8H2SQjnsu8?=
 =?us-ascii?Q?VeqjcviV+YERus9VFtRblWE5pTJAW6QeFC+Nj61uv2tx22YKIHRiGHwfhpUR?=
 =?us-ascii?Q?B56xXMPFGfdJSC7jcuVD42+6wj9CDR8shMS7MF6hu21O2AK+Zca9n9qi3lM1?=
 =?us-ascii?Q?Fjqh8Xk+PNlkbAlHhpPRn6UOVf9USp4iXwNxW4Af1D6thnVgpCrcO5janyfG?=
 =?us-ascii?Q?aaO7t7vYXT/wpgb/5STm5KOdcWG2iE8XCXwzjZILCsi3fM/fU++HgHgH0Hka?=
 =?us-ascii?Q?sAvDfqwwH/w1J8rgp2lwaV1KI9xGtWNFWs8qb3+uMW5Z932VLRM0SDAkFUVK?=
 =?us-ascii?Q?XETs65u7WhOop3khmYe6uIGTG9Un4j2qxW3nTBtIXwPc2+U810p/yr9Yti8a?=
 =?us-ascii?Q?DsPePwHMZ/1IpNPqt1CkOdqcy8JOlI/CjYxXwNAsBBAYAUNeqfP/yKjnE2Az?=
 =?us-ascii?Q?x6nNch5UrK095kCcQY5I6uWh+la8OF3iMRm8QrIKjl7ZnKHsKa25zbvLknY+?=
 =?us-ascii?Q?paGLtMCC5xucWzRLd0dJVLglgxma5VbRYO203ogmDuDr7WC2AdqHwc4aS8Ba?=
 =?us-ascii?Q?PRTdR3kQvpxQetkBGAfhQHhLCNy4UOzflOYZqxiB7Fe6rZxqCYU/TLSpBTDu?=
 =?us-ascii?Q?4PoOf74qrdPNAF4nCwxPudRAWZbYhOHkDIpw7KRryWcxX3FGptQSufLrHO5J?=
 =?us-ascii?Q?ZcRRwaz33vUjeBKg6lSSQslzRI6gRgw=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6cfbc711-5061-4d8e-9c76-08da53c88af3
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1101MB2126.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2022 20:56:41.7538
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BJTTPDd96l013pPwhNPPhbyKI8BGeDL/L9mFwSsLDXnFmhC6KUuLxr5Ds1uQV4jiGUYXD2k+Gz4I9D6l5nc0P2jKPUX98ROM0p5n1mAzOC0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB5254
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Davidlohr Bueso wrote:
> Similarly to verifying the cfwms, have a cxl_acpi_chbs_verify(),
> as described by the CXL T3 Memory Device Software Guide
> for CXL 2.0 platforms.
> 
> Also while at it, tuck the rc check for nvdimm bridge into
> the pmem branch.
> 
> Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
> ---
> 
>  drivers/cxl/acpi.c | 64 +++++++++++++++++++++++++++++++++++++++++++---
>  1 file changed, 61 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
> index 40286f5df812..33b5f362c9f1 100644
> --- a/drivers/cxl/acpi.c
> +++ b/drivers/cxl/acpi.c
> @@ -187,14 +187,65 @@ static int add_host_bridge_uport(struct device *match, void *arg)
>  struct cxl_chbs_context {
>  	struct device *dev;
>  	unsigned long long uid;
> +	struct cxl_port *root_port;
>  	resource_size_t chbcr;
>  };
>  
> +static inline bool range_overlaps(struct range *r1, struct range *r2)
> +{
> +	return r1->start <= r2->end && r2->start <= r1->end;
> +}
> +
> +static int cxl_acpi_chbs_verify(struct cxl_chbs_context *cxt,
> +				struct acpi_cedt_chbs *chbs)
> +{
> +	struct device *dev = cxt->dev;
> +	struct cxl_dport *dport;
> +	struct cxl_port *root_port = cxt->root_port;
> +	struct range chbs_range = {
> +		.start = chbs->base,
> +		.end = chbs->base + chbs->length - 1,
> +	};
> +
> +	if (chbs->cxl_version > 1) {
> +		dev_err(dev, "CHBS Unsupported CXL Version\n");
> +		return -EINVAL;
> +	}
> +
> +	if (chbs->cxl_version == ACPI_CEDT_CHBS_VERSION_CXL11)
> +		return 0;
> +
> +	if (chbs->cxl_version == ACPI_CEDT_CHBS_VERSION_CXL20 &&
> +	    (chbs->length != ACPI_CEDT_CHBS_LENGTH_CXL20)) {
> +		dev_err(dev, "Platform does not support CXL 2.0\n");
> +		return -EINVAL;
> +	}
> +
> +	device_lock(&root_port->dev);
> +	list_for_each_entry(dport, &root_port->dports, list) {
> +		struct range dport_range = {
> +			.start = dport->component_reg_phys,
> +			.end = dport->component_reg_phys +
> +			CXL_COMPONENT_REG_BLOCK_SIZE - 1,
> +		};
> +
> +		if (range_overlaps(&chbs_range, &dport_range)) {
> +			device_unlock(&root_port->dev);
> +			dev_err(dev, "CHBS overlapping Base and Length pair\n");
> +			return -EINVAL;
> +		}

For cxl_port objects this happens "for free" as a side effect of the:

        crb = devm_cxl_iomap_block(dev, port->component_reg_phys,
                                   CXL_COMPONENT_REG_BLOCK_SIZE);

...call in devm_cxl_setup_hdm(), where it tries to exclusively claim the
component register block for that cxl_port driver instance.

I.e. if the CHBS provides overlapping / duplicated ranges the failure is
localized to the cxl_port_probe() event for that port, and can be
debugged further by disabling one of the conflicts.

> +	}
> +	device_unlock(&root_port->dev);
> +
> +	return 0;
> +}
> +
>  static int cxl_get_chbcr(union acpi_subtable_headers *header, void *arg,
>  			 const unsigned long end)
>  {
>  	struct cxl_chbs_context *ctx = arg;
>  	struct acpi_cedt_chbs *chbs;
> +	int ret;
>  
>  	if (ctx->chbcr)
>  		return 0;
> @@ -203,6 +254,11 @@ static int cxl_get_chbcr(union acpi_subtable_headers *header, void *arg,
>  
>  	if (ctx->uid != chbs->uid)
>  		return 0;
> +
> +	ret = cxl_acpi_chbs_verify(ctx, chbs);
> +	if (ret)
> +		return ret;
> +
>  	ctx->chbcr = chbs->base;
>  
>  	return 0;
> @@ -232,6 +288,7 @@ static int add_host_bridge_dport(struct device *match, void *arg)
>  	ctx = (struct cxl_chbs_context) {
>  		.dev = host,
>  		.uid = uid,
> +		.root_port = root_port,
>  	};
>  	acpi_table_parse_cedt(ACPI_CEDT_TYPE_CHBS, cxl_get_chbcr, &ctx);
>  
> @@ -321,11 +378,12 @@ static int cxl_acpi_probe(struct platform_device *pdev)
>  	if (rc < 0)
>  		return rc;
>  
> -	if (IS_ENABLED(CONFIG_CXL_PMEM))
> +	if (IS_ENABLED(CONFIG_CXL_PMEM)) {
>  		rc = device_for_each_child(&root_port->dev, root_port,
>  					   add_root_nvdimm_bridge);
> -	if (rc < 0)
> -		return rc;
> +		if (rc < 0)
> +			return rc;
> +	}

No need to move this inside the "if (IS_ENABLED(CONFIG_CXL_PMEM))" that
I can see.
