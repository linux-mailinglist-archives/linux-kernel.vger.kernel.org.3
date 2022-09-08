Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 540CA5B1433
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 07:56:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230023AbiIHFz4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 01:55:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbiIHFzx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 01:55:53 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86171A1A5F;
        Wed,  7 Sep 2022 22:55:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662616552; x=1694152552;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=WG1dhv4TNkkMiXMPJSgTUql/DTBS12ytL9TvSNY/6LA=;
  b=Oik3lkULBKHU38tOWiJQcPaYSypaPFolYPcoeHkkXrulZQ6vJMnF/IYK
   HG/WzfWpBhcLXyiIoDIz8PdHSToy9qKfFpZ4viYuqg8ork81asfDHyXF2
   Zj1ZqywYya8TqGNvjGVH6NO1LLSzQjSr9dFC84QUa4JAUxEL6/Qyfutcj
   67v5n4dQfteXA2yATJ4yfy6Jx+73gxIjamsjDPIrz3QnvQA0ibRdgatDG
   bR9QIrbVhADcLi2bRhZCbhUq457Yw+QbAgvSyFFmgEmJox7wHM4X+u26t
   jMbPUndGUS5fYnH2nBmfZVgtb0pZNUzpTxulq5TwHHGKqMBjIZaAijQ/W
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10463"; a="298412963"
X-IronPort-AV: E=Sophos;i="5.93,299,1654585200"; 
   d="scan'208";a="298412963"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Sep 2022 22:55:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,299,1654585200"; 
   d="scan'208";a="614766069"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga002.jf.intel.com with ESMTP; 07 Sep 2022 22:55:52 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 7 Sep 2022 22:55:51 -0700
Received: from orsmsx608.amr.corp.intel.com (10.22.229.21) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 7 Sep 2022 22:55:51 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx608.amr.corp.intel.com (10.22.229.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Wed, 7 Sep 2022 22:55:51 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.104)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Wed, 7 Sep 2022 22:55:51 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TC3eLfZjOmWXjfQvhjkX29yGQpGTiY1HXIH/epZaHuRQtSmXXgUv+VWE8EeUNtg5i8/6rsiYKGS50Vnh7r1BZ3iFyrlciHSs3jougTwL0VOeDV7ZVuFKm6FG6CAYqfjnPZP9O7zcPK/hU531M4+GalyLEtC6nc8pbGMnISCq8LfYg7nUNQQ4IVa2wNsiZsO+z1dcuaXPVedEtg0qtTY9r+bDYuXQcm2CONdgrsHYtPtgcjRDTXvQ0EqXTNpRHBmAqa147BlQhz5PZVCaAe1Qc4u5/frkVoLRHc6ZLoQkUow5OuDhElGQO1YjMOw0HBMdVnMWiiqiG5+l0FHiak9mNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZVG/NFI99oMAe9RtT3DWSmYyKh+ypddLijqqNyftnFY=;
 b=MC6/bFHnyUADRY4jcoW7szCRs5yeaarMErwZBdFPvQiIQzghs4v+mPHufUH++M4xDl97IaevcY+dYpfeKiflppKKFByyufEVrsoYqmJmtDzfD93101mJJpdVnCpzW8ulKIPgNty27znFJIUTDUuhi9y37Umf0e/6aL6wX8BJh1rep1VPSRKx8etEVk/kMu3NEZrhwUi6DnG1sffVDFTeKrpkvwCE9XNBTSBHMU1wRfTpJzxgQUbiSnQTo30fS8mY8Filc5uAvcgnGTLmxU/juY0LoxvmYpJXkvHjfXEGav99y9wmhyDhxFXBKa/uNQlG8GQzVkrgbj4Ma9DUdnnUJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20) by DM6PR11MB4426.namprd11.prod.outlook.com
 (2603:10b6:5:1d8::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.12; Thu, 8 Sep
 2022 05:55:49 +0000
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::9847:345e:4c5b:ca12]) by MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::9847:345e:4c5b:ca12%6]) with mapi id 15.20.5588.017; Thu, 8 Sep 2022
 05:55:49 +0000
Date:   Wed, 7 Sep 2022 22:55:46 -0700
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
Subject: RE: [PATCH 04/15] cxl: Unify debug messages when calling
 devm_cxl_add_dport()
Message-ID: <631983e2bc50f_58016294a3@dwillia2-xfh.jf.intel.com.notmuch>
References: <20220831081603.3415-1-rrichter@amd.com>
 <20220831081603.3415-5-rrichter@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20220831081603.3415-5-rrichter@amd.com>
X-ClientProxiedBy: SJ0PR05CA0172.namprd05.prod.outlook.com
 (2603:10b6:a03:339::27) To MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 59925a12-23d1-4eb0-aec6-08da915ec7cc
X-MS-TrafficTypeDiagnostic: DM6PR11MB4426:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: umzuqTTychzx1NxZbm27hdvc9+A3M1v0qUxiMycMgvGu3OPtqCwMyPBUnKigvyleMasNbvA5K1+I9hHJnty90ZEv84XFjND/6fuV2gA/USdRL1K8y6W2h0r0W+ZNUWuH4tkf/TqTb5aow6e/LPiebJmcp7ZuLK/T3UhfZwnDUmV8Dpk6+mpEGrtr+pld0ERAqn2y3TX71IDuHyMo/3fJh57qS2QspHTW1rKJFrqNaNtnjgi41rLwcXGbzsLpIdSWAFJuAyWM5tGt/X5mWWw1aXZtLy2k9GYaPV9DlwkX0vbwx9mixGoARD3MdUq2ysw/dMOrNiB6BgiIL6ud7jAuHnJvFMPwPyj5LoKqWzGdi0Au58HzsWnDxaI3/z1qwgs6ig75lqJdFeMS1IpzYRn4QdhiqK6i4Asm+rOozEtrKLpE2pq3L86NXBkfRZmUnGbdxen6gGNlYEFFuiqlxd5RoidFIxJfTn0lcNUkG4m9gHksNespf/TKmSCy1sopyt3YR5njFcHbm42Sls8HPRjVIqI7tObKUPNcQg8/fU4Z30AdZHqtDh3g0o7QmRlJhGb87Zh4ODDV1I8g1HDnBsEagvRCWeHedL+vdZ/GanDQ8q+8Sy913UaSDBZzRjYTOBa0tes+6S2HB5kJlhc512tgAHLqdCa3DU0gg6p5Dk/8Na3iDuMepCuJB8jEHPErfufCVbGLhYXBKvXCy/lT24khgg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1101MB2126.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(39860400002)(346002)(136003)(366004)(396003)(376002)(6506007)(41300700001)(26005)(478600001)(6666004)(6486002)(83380400001)(186003)(15650500001)(8936002)(9686003)(2906002)(5660300002)(6512007)(110136005)(54906003)(66946007)(316002)(4326008)(66556008)(8676002)(66476007)(82960400001)(38100700002)(86362001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?PELTG2ErZlcSNLh0g+XODx3SWvxiXwzmF2K1lbOPuHKBjYuwd6L4jv75/uD5?=
 =?us-ascii?Q?UZ5x2/IpdVuxzhxdmG298y2Wj6Hl1eAzVPnGx4v5N8qpSvoYMS6k4Aw85lVe?=
 =?us-ascii?Q?2uBL+nccSl1chQFQ0adAlkwih0LR+3/KnYGox2Y/uiMWck59LQ6aHlOqfuWZ?=
 =?us-ascii?Q?sB5yU4hJ9XQLnteQSWEN6n2SDgCCGTDV4WjsIa/x206pLwpm7AaYTjxYhJgU?=
 =?us-ascii?Q?KlvlUZG8Xo1KxZNFsVDOOgA3btXxHEd6XiCVhb5UTzquhojtVQNWHeT40GIP?=
 =?us-ascii?Q?6aIJTLcbwA7Xum5kb/GoAXIKRnBkCJblORqFPBol4TQmHZqKmt7coq0BXhCX?=
 =?us-ascii?Q?5D2SLOUjM1eez7TfTHm4EQs7qD1NES/Cy3EVX4n4fTYEYeo5vE37nQNjEdd2?=
 =?us-ascii?Q?wZdRqn8PaiJC81rM0FUUWGKEHklx3QI8cnUX0KzmXgCamTMi2CCdL226x3Ex?=
 =?us-ascii?Q?H+zbr7HlLz6Ryx3kd64vFwO1S5l/TQJmWt7uINUoxfexwu1nfHJQ2E1qOPx2?=
 =?us-ascii?Q?KcmbL4pJcN6J5XonUR3M3QAahc3trTuXPsyBapM0iT2SB+q/OsANqELbMWjg?=
 =?us-ascii?Q?Cwh5uqDmn7937XB0LwdOcI9c/ZgJbUGiSjWsnjF1rqJMw/+WWpnuWttabdkr?=
 =?us-ascii?Q?G31VNN4AeGnNLhTlNSj2CA/DnsKFsTNbtR0Pd+r7Hn/dQQiLcAU5KeXOcKoX?=
 =?us-ascii?Q?0OqVl3exGRTYUs0YurJsOi4aihQFIJdK6qJU3Y/uKk+gzjkkmevkaMsbs4Vb?=
 =?us-ascii?Q?EyQL+usGBxjqx58bUDAhVXwI19GMBvMYU/FApiydvJy/mAFhSKr2usVj/fJS?=
 =?us-ascii?Q?xfjrPsL2whr5g5y7DpmR5xRAyy6ObasVOPvnf+jgPnbLYF2Km5n77dlssghv?=
 =?us-ascii?Q?tT5PuEWlXQ+elgwg8OSVs4/CYEc2VNF90EruM03DrDDkHF/bs9JMWYZF1f9c?=
 =?us-ascii?Q?j9U3wezo15rc6GyT9FCKv+GjVaJaGtIyZrh+xNBAeDJnCEYgnH0U/TqNeVKv?=
 =?us-ascii?Q?bNutGJoZ5SCM2ZeWNx3SuNrBzWrSpB7bW8A0pPLu2NrSuZRbCIpJj3HcRv92?=
 =?us-ascii?Q?VGlQMp6ipLU4DHOqB/jRaInivoODPBO614vskOZtpAjCwSBJIqkSxWalOjof?=
 =?us-ascii?Q?HDcSOLG7PRMcmOXjYbgPd97bmCi6GvZ7yRk9VfevFrzKSVuBI+/Tp1zrh2pM?=
 =?us-ascii?Q?0wM6xOkKj3ev0m4wXv4bGi08i2PyrMW/1iWrERakEf/9Z0ijqLbG8xXU1aF5?=
 =?us-ascii?Q?N3XkAaRCBoT+DS5Mhyhh2wcmg/zjXuREoMRmcAvY4ajZCt0GihyeTApstU7T?=
 =?us-ascii?Q?pn7RZ0aRNMnRbdYyF5vE0cMmToCL9Ir/CvnD7+I0p33ZbgvE/4AHBNSVNYXl?=
 =?us-ascii?Q?uuemP4G5nQjAeDUWR14A1lGseE0l9aPNYTbL4D6z4ZzMNlQRDcfkf3DOFC0g?=
 =?us-ascii?Q?L5m3uX8VSTua6/CW65qkiw79qlOVHu7Un0c1yBb9D/ou12qdF2h8jVGDuNqI?=
 =?us-ascii?Q?lUtHRiTaayiN4vrasYxu/7WOi+U02zQXaIJXe+h2rZDgtIMCpCzppdEFQ6Ie?=
 =?us-ascii?Q?R/4iXhA19XZxmcIe8xOaosxgnLXkIXZfLuGkUburBA2yo9OxDVTvFhnj1W2T?=
 =?us-ascii?Q?Sw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 59925a12-23d1-4eb0-aec6-08da915ec7cc
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1101MB2126.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2022 05:55:49.2786
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: X4UctMp1GE/2xyAbeTy1ptWUyhW0iXC7bIo4sIuZN4+j7/ZkczyXVjR36eEhVd06ICCUn+DFLzcg+wa9yfDrlqreNRv2mluNFPX072TJLdY=
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
> CXL dports are added in a couple of code paths using
> devm_cxl_add_dport(). Debug messages are individually generated, but
> are incomplete and inconsistent. Change this by moving its generation
> to devm_cxl_add_dport(). This unifies the messages and reduces code
> duplication. Also, generate messages on failure.
> 
> Signed-off-by: Robert Richter <rrichter@amd.com>
> ---
>  drivers/cxl/acpi.c           |  7 ++-----
>  drivers/cxl/core/pci.c       |  2 --
>  drivers/cxl/core/port.c      | 28 ++++++++++++++++++++--------
>  tools/testing/cxl/test/cxl.c |  8 +-------
>  4 files changed, 23 insertions(+), 22 deletions(-)
> 
> diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
> index 767a91f44221..31e104f0210f 100644
> --- a/drivers/cxl/acpi.c
> +++ b/drivers/cxl/acpi.c
> @@ -282,12 +282,9 @@ static int add_host_bridge_dport(struct device *match, void *arg)
>  	}
>  
>  	dport = devm_cxl_add_dport(root_port, match, uid, ctx.chbcr);
> -	if (IS_ERR(dport)) {
> -		dev_err(host, "failed to add downstream port: %s\n",
> -			dev_name(match));
> +	if (IS_ERR(dport))
>  		return PTR_ERR(dport);
> -	}
> -	dev_dbg(host, "add dport%llu: %s\n", uid, dev_name(match));
> +
>  	return 0;
>  }
>  
> diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
> index 9240df53ed87..0dbbe8d39b07 100644
> --- a/drivers/cxl/core/pci.c
> +++ b/drivers/cxl/core/pci.c
> @@ -62,8 +62,6 @@ static int match_add_dports(struct pci_dev *pdev, void *data)
>  	}
>  	ctx->count++;
>  
> -	dev_dbg(&port->dev, "add dport%d: %s\n", port_num, dev_name(&pdev->dev));
> -
>  	return 0;
>  }
>  
> diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
> index 8604cda88787..61e9915162d5 100644
> --- a/drivers/cxl/core/port.c
> +++ b/drivers/cxl/core/port.c
> @@ -914,12 +914,16 @@ struct cxl_dport *devm_cxl_add_dport(struct cxl_port *port,
>  	}
>  
>  	if (snprintf(link_name, CXL_TARGET_STRLEN, "dport%d", port_id) >=
> -	    CXL_TARGET_STRLEN)
> -		return ERR_PTR(-EINVAL);
> +	    CXL_TARGET_STRLEN) {
> +		rc = -EINVAL;
> +		goto err;
> +	}
>  
>  	dport = devm_kzalloc(host, sizeof(*dport), GFP_KERNEL);
> -	if (!dport)
> -		return ERR_PTR(-ENOMEM);
> +	if (!dport) {
> +		rc = -ENOMEM;
> +		goto err;
> +	}

Similar comment as before of using a goto just to ensure the log message
is called, I suspect a wrapper to do the logging ends up with less code
thrash.
