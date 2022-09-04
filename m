Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A5EF5AC4D4
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Sep 2022 16:38:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234366AbiIDOif (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Sep 2022 10:38:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229997AbiIDOia (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Sep 2022 10:38:30 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B953A3341B;
        Sun,  4 Sep 2022 07:38:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662302309; x=1693838309;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=zFZ/pbv82HYfG3nbjI4+m8H3K6RHec9Ji/lLFJt5bj4=;
  b=GL7fNga/SjfHbLDLtMnpQgkkwZVGJgsFoLxLwL/fPB17k70vNB6VDEhc
   E3CBVrT6D3fqAIYjtjpPWuMq80v7Vy0KjTQnl4BRD00jUpQTjhN7IcJvI
   I4z6x8bZL9GI9uSCLCZBs3glVd8vPCH/F78VZYceXG0PMbyACkw/Z7dLM
   kBzn9kXusJh8qnDXrqwXYQ/NeK0f3QsNyObwn0eHkbBcgVXkKLXdTSQhc
   T4we02anUE3M8D+KRh7+jf9cLhr6L0aLtF41d1poiXKU+u+0O2JvMvAHb
   yl3dIqhPqIVZUvTjUCWKV9Yjv9nYmJ89IeqKr+8lKIodKpPEgas3pp9Gq
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10460"; a="382544729"
X-IronPort-AV: E=Sophos;i="5.93,289,1654585200"; 
   d="scan'208";a="382544729"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Sep 2022 07:38:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,289,1654585200"; 
   d="scan'208";a="616166440"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmsmga007.fm.intel.com with ESMTP; 04 Sep 2022 07:38:29 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Sun, 4 Sep 2022 07:38:28 -0700
Received: from orsmsx607.amr.corp.intel.com (10.22.229.20) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Sun, 4 Sep 2022 07:38:28 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx607.amr.corp.intel.com (10.22.229.20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Sun, 4 Sep 2022 07:38:28 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.168)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Sun, 4 Sep 2022 07:38:28 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JNmiL8W3noGUcfuIuDC9INT80MGj68b52nzYDqHDIY/rDHkJ/1+ZZnaSjr2GmucJmp10CSHJvUKBq2iDbeoBXGPCP7IVqRmA/Y5/C8ycJ41qHs1tD60TpGNPTozWfX+uQzS04O1n1s4yzR5ylKyCUlhpHoUchXroAzi8Y6zJ7AjETtS1D3kKXEh0koI0P8nxlIvvLlfzbsyNNqnWRo+JZWOJ37mIVLz79glQtA1uYm4IxXfqUmeD0uVOzCtld7TSVPp+G7y4RH1aH+Yvyuv62cU0vHMRkawCOTBk4rNew2JqTqvvoJfxqGv+htycNmpEfl36PCQ/eVbMZx5sDquGFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oZbYLpgUujnSKGPdAijrsaHXVERzxOt410A6AAI2aXI=;
 b=dt5NRHxutiWLMn4ZK1Xa90nZcB5ao33DqlK7J9lgT/3pYnDNzvZPeEX4sMlN9r9yTNI2OGZBxq8XXVPmi0wb8la/7BC+tT9arZP7xCDag+kvWw5sN0P5bcjULh+iLTr2ggowO77DxCr/R7D02OSvD9CiEHc7f39WLVvAs2HHRXBuCIBv2gaNO/bRVBZu/ulJ6LyyyEweVlwbPpfu6zNilSDQ36V4dElj0cVQOgG3JWyeuRZ7OTw6TBoIC1dkCXqrqo4M07GKE1ifcU0CNJxnLRf3wgsauCGXuKnTWfwcxlA7b1+QRThnTD+eBq+FVbhgZpnjpubOk6ySyHGAeJcxpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20) by DM5PR11MB1305.namprd11.prod.outlook.com
 (2603:10b6:3:13::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.18; Sun, 4 Sep
 2022 14:38:20 +0000
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::9847:345e:4c5b:ca12]) by MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::9847:345e:4c5b:ca12%6]) with mapi id 15.20.5588.017; Sun, 4 Sep 2022
 14:38:20 +0000
Date:   Sun, 4 Sep 2022 07:38:17 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        "Dave Jiang" <dave.jiang@intel.com>,
        Ira Weiny <ira.weiny@intel.com>
CC:     <linux-kernel@vger.kernel.org>, <kernel-janitors@vger.kernel.org>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        <nvdimm@lists.linux.dev>
Subject: RE: [PATCH] nvdimm: Avoid wasting some memory.
Message-ID: <6314b859df5e2_2202c6294f5@dwillia2-xfh.jf.intel.com.notmuch>
References: <8355cb2b720f8cd0f1315b06d70b541ba38add30.1662299370.git.christophe.jaillet@wanadoo.fr>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <8355cb2b720f8cd0f1315b06d70b541ba38add30.1662299370.git.christophe.jaillet@wanadoo.fr>
X-ClientProxiedBy: BYAPR01CA0014.prod.exchangelabs.com (2603:10b6:a02:80::27)
 To MWHPR1101MB2126.namprd11.prod.outlook.com (2603:10b6:301:50::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 179ab892-64bc-44d0-044c-08da8e831cb7
X-MS-TrafficTypeDiagnostic: DM5PR11MB1305:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: g/e1fNtqCHliOvXqIfOJhE3bBwhRD4CVYV0wd99CHtWN4YnchMMcznyPHgUgdEjAwhG/A3e7ASmYIymiNleeVeqtJK7JIZHo+IGnUWRGH1V3123tatEQXRVgMDbaxswp2DUrqMMVuokOxWHvQUApcLGcHayNMP9kqffWeegmzM4rE4iWi8H4gcivUgf5NBGYIH21y5BKyPEq1kb6Bn2UeM/0P37ppOAIexvpKctpLh0sGw4Sy9xsO4PvvhG6AIFm86/HxVSU8oII8ny/izKuw9Chk/s52EsJmry40PQNibUKI9SqxZoq4duL31dflr+XXePRjNp/CJPQcCJIDW7shqOxlMDIcQVI4choXB3+G7UI3Mcmsl18D8v53uOl2Bs0EXCS4kfjpJyMhfG7ANw0Rs5kK4P+LWzh3Z+Dr1xLs4kK5gBvoTUCKwNmjuBepj30KQJX1X3bI1N6abQQ8O+N2stVPw384Jr/U5r1i8WkWvSRsBECz8WG2YPPwhwzD8Sac365IFp6XmNha0RF7u7MPv7EQk9EKNxmJXvFmEKDmSml88jKDgwlvxvaZVP+edqoHYXH6wZ0VPqbzUMF8o5JoY5UbCa42/g5dkaz3nqsmZ+UWAOucfZx09ncHKxfxgHFClhEdgzEwCRfZqZSJuAlKGhKllADNMuZfHZHv3A6oqDwaWhHDLKEy8LPR9d8RWaSnydSF1dkEAFff7d0uZi9yg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1101MB2126.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(39860400002)(136003)(376002)(366004)(396003)(346002)(66476007)(83380400001)(8676002)(4326008)(66556008)(66946007)(8936002)(5660300002)(6506007)(478600001)(26005)(6486002)(41300700001)(6666004)(186003)(6512007)(9686003)(316002)(110136005)(86362001)(6636002)(38100700002)(82960400001)(2906002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?YmDewM41pOCB9HE9mn9jikTDoMtJhNshSuHzQZYv/BmyO7JzAx6uboe6iNRa?=
 =?us-ascii?Q?pg469NDkFHLpZd3Ay8Qbm1jjWqgyvFrm0I7Z++qGwnKNHEruZ1F90ODzl/W7?=
 =?us-ascii?Q?37f5XJkhE3/tqZLd6tuFr3YLStR47vKBEgzhixRt9OXRwoY3iSkOnGvAmulI?=
 =?us-ascii?Q?YJ6qQeHYCorAy44hgSKsly4vuEEbuqafPLiZL728os3WX3xXR9vKeQfNahrl?=
 =?us-ascii?Q?ulHU4o+FZNnL2EjqNWiY9Mm4oV0LpBLZ7waNlEzdtaO5eQXcsw7+BxaPEIPJ?=
 =?us-ascii?Q?Ic+M9oZw9NHIuALQBIGXWFE1fZDo0DVqZTEI8EaRaAJvGkbBLFv4g+hJCicA?=
 =?us-ascii?Q?foUcinqEAML3FszbtiKb8O02TOefCafCH949HhJ4dmDH5n4nmlSwaLqOb/pc?=
 =?us-ascii?Q?netTbFcZXXdTbaII5MQvGW+leCwXQL2oHJja3pulbf9T3PJdXMYYO9df3ZxS?=
 =?us-ascii?Q?qEz8idou75/mWylA7Nxg63LqIsLc1hvuHmBsmcZFSeHzfdgDlFziZYOAGFY/?=
 =?us-ascii?Q?igKLWWaRq4RhZ07v6xvEZNHY5pHfS2JRcbTFSxZ8mc8aKXZ9DnKUYnbeoQXi?=
 =?us-ascii?Q?eCs2zwwwVBAJp9w72DZ+4AEY6761ji3l6Gp8RAixsnFxFG45nbe47UUOjYAm?=
 =?us-ascii?Q?gqa/8Bz5WlYBCr4exVMi8eUoUP4JXVVXq9XtbdpPEfQsMtS80PVJhGFv992Y?=
 =?us-ascii?Q?6C7WBVEquPYjO5n9vOr/jbkVCZF+ps533i45Ysfztrgb/4jfyKbl5puNlw/x?=
 =?us-ascii?Q?eCzdPTgSvVpEEEfSA05/LbKXYSVTvYJ/P2T+FUV5f5KxOU1IE9jd1xUWQC/8?=
 =?us-ascii?Q?ohujQ+6TygitxZTtjMKXjBU6E2x2SmgfelzGyh7y8s2m8em1KhQ5hP+lSKre?=
 =?us-ascii?Q?jB0lVvqNP1iODSII/prMyQ0lXMN9iSzjt2OZts8LfW+RZRFanSGAHg+MWC9f?=
 =?us-ascii?Q?pWEQBLUAXFbGN/cZghxMoyMSdocq9zANtlBwlpDsHkm63/BzoT872exQmpzR?=
 =?us-ascii?Q?7LuoVS7LYxEiZ+z2deiCfUCvdbYb38aicnbrujn6ttcIMyUrLl8YToz4DyVc?=
 =?us-ascii?Q?ZIaR3qiNDIKcDv4saJ4ChglwtB6F2O42Cku177AmWWAZFGFmhtBKv7NTwF5V?=
 =?us-ascii?Q?fFIZcGkyzNG6gQHyCX7Bvy+tKl7Te6BPv/Gvb9tsMy2/lfaUehAwxjKsPfHP?=
 =?us-ascii?Q?hw6XBMSTGrPPBcKSCA0wFRhBRQSXo44MZRWfowbkitYxXJKnnaUIDVYuJ8Lg?=
 =?us-ascii?Q?AfedXV3E/YELnsFqtN4k8G/C+zYlhWapT3KygrZ9Dbft5BMeWWdJVRSN5O/5?=
 =?us-ascii?Q?BpJJMIm+KiWrX4L9dvARsHoQgbipyX7t2HvV9j/aczLTkh6DUSgh4rN5sjsg?=
 =?us-ascii?Q?oLmZGrkXNv8XcUzTOtvrxDolDDmQ0YY0iIRDDCzULrzfFHf/Sml1OAy3K5b7?=
 =?us-ascii?Q?BsoIj6MYuYQCrZr6+hUMbvvKo3pIaaBOObUsZPcDASSMzxtl39MDqHs3zQXH?=
 =?us-ascii?Q?gJus0QacZnRznirao9dsZNKYcJyzkP0q+wuNvZICATVpLv1UuTUWRwJ+/85Y?=
 =?us-ascii?Q?tOXOy00gBo4pGtqaLu2P0YxJQRs3UU7BGU98Rt49+Z0WHb/Pr/1vEoY3OSwN?=
 =?us-ascii?Q?6w=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 179ab892-64bc-44d0-044c-08da8e831cb7
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1101MB2126.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2022 14:38:20.2306
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Pbj69Gf2+QOBphhCxhnQ6A1/oXFkCZyNUJGP+mW+jgLDg/mBseGuyVi5TxJ7179RrnX7/7URxG6ImvbmlxkmAQCQnqo+5fxBys7QfWa6Cuc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR11MB1305
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

Christophe JAILLET wrote:
> sizeof(struct btt_sb) is 4096.
> 
> When using devm_kzalloc(), there is a small memory overhead and, on most
> systems, this leads to 40 bytes of extra memory allocation.
> So 5036 bytes are expected to be allocated.
> 
> The memory allocator works with fixed size hunks of memory. In this case,
> it will require 8192 bytes of memory because more than 4096 bytes are
> required.
> 
> In order to avoid wasting 4ko of memory, just use kzalloc() and add a
> devm action to free it when needed.
> 
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
>  drivers/nvdimm/btt_devs.c | 17 ++++++++++++++++-
>  1 file changed, 16 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/nvdimm/btt_devs.c b/drivers/nvdimm/btt_devs.c
> index fabbb31f2c35..7b79fb0b0338 100644
> --- a/drivers/nvdimm/btt_devs.c
> +++ b/drivers/nvdimm/btt_devs.c
> @@ -332,6 +332,11 @@ static int __nd_btt_probe(struct nd_btt *nd_btt,
>  	return 0;
>  }
>  
> +void nd_btt_free(void *data)
> +{
> +	kfree(data);
> +}
> +
>  int nd_btt_probe(struct device *dev, struct nd_namespace_common *ndns)
>  {
>  	int rc;
> @@ -356,7 +361,17 @@ int nd_btt_probe(struct device *dev, struct nd_namespace_common *ndns)
>  	nvdimm_bus_unlock(&ndns->dev);
>  	if (!btt_dev)
>  		return -ENOMEM;
> -	btt_sb = devm_kzalloc(dev, sizeof(*btt_sb), GFP_KERNEL);
> +
> +	/*
> +	 * 'struct btt_sb' is 4096. Using devm_kzalloc() would waste 4 ko of
> +	 * memory because, because of a small memory over head, 8192 bytes
> +	 * would be allocated. So keep this kzalloc()+devm_add_action_or_reset()
> +	 */
> +	btt_sb = kzalloc(sizeof(*btt_sb), GFP_KERNEL);
> +	rc = devm_add_action_or_reset(dev, nd_btt_free, btt_sb);
> +	if (rc)
> +		return rc;

Thanks for the analysis and the patch. However, shouldn't this be
something that is addressed internal to devm_kzalloc() rather than
open-coded at every potential call site?
