Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AECB257D52D
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 22:53:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230428AbiGUUxk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 16:53:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229613AbiGUUxh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 16:53:37 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D26E8FD52;
        Thu, 21 Jul 2022 13:53:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658436816; x=1689972816;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=s0Et3cQbwG0yBZtPgoFYO7VSwsUhLX6CVSLqS3VIZEs=;
  b=BKHxRyqyHQj7EUp9B7bD4ZxRSzLII3Sc6y2sVH7943jYgmlz/V/S4kMW
   Bc1TOCu0DMgIqOr7AUEyT2hdiSm4Y4S9nTMK9xwtUvqFKtsR3W/6DmjCN
   Pb58rSyp1n+M5XacVAgZisoGyqKNgYfHqCcknHPL9niGNfeb6VxA5Lsu+
   0LxhgTqRGCkG6ePA7fvsNaTbsjLIEM9iklk3NSgN3TRKKv3bt3VcqyU2X
   g2uTsAH4OpipZod8dN8lLlG02cjfhrEapvTIM0YR/XQ4avl6eQfqwsTgX
   2AG16e4NlwXKmZLpai0flGoOOZbUL3++ilVUhQZOEBYNw9O4xlsvBi9Db
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10415"; a="348870503"
X-IronPort-AV: E=Sophos;i="5.93,183,1654585200"; 
   d="scan'208";a="348870503"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2022 13:53:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,183,1654585200"; 
   d="scan'208";a="656918543"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga008.fm.intel.com with ESMTP; 21 Jul 2022 13:53:35 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Thu, 21 Jul 2022 13:53:35 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28 via Frontend Transport; Thu, 21 Jul 2022 13:53:35 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.176)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Thu, 21 Jul 2022 13:53:34 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eDOqZI5qhJc3BtCoVbFohUKRHrJgURC1EjEzTyVHRV/RfypRjKGgqv0YN+mI0ki5zjhDrbPLIm7KtdvVQopIY58AEPfYN/Lcokoo78G8lFh03gaVW6Hzr1K160IkKb3aPQ9EU1+vSFTIvHvE7L7mDlY4UepdcoxekHJgm7SE/ISoqdW603tYM3PckST0LC4ZY8YNW7kn/1IqTIY2hunkX/hJE/7GSoY1me/cVS6sDn1NEZwC+b4I29k/FTLzSTEt1Qu7E0RPAXD30f3ve9oiKUZhty3LIKWHA177HnTdP08DqkYjF7KhTa93FfdMDQDbh911BObGl94PBRizOuhrSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s0Et3cQbwG0yBZtPgoFYO7VSwsUhLX6CVSLqS3VIZEs=;
 b=A+n2yA9jW8eVSDeET96rRqp88NXZRqVDkKUG6SXod/Ktv9Z+3ZZ563w0RrbH9yh1B2idimo2DKxIXfvhQI6IpCjt6ptz97QT8n9biPyf9Ex1+z/2zsWBdumI4IG523uzfycM4MlBfw3jvz9xz4kJyu6/hT4+0/ZRXfskJYHm5fIo/StrPfBG/8JUjLeva/L8K1LBYPAET1LjucLYUeqtDC2tD/gznBYmZTh/E7qYVPAl1j9bgKknZoqxdBMsT4hcFGvX5dPKperlIjk4jz1lOtEeFX8+ANBbuDZDTawaXLnO/TuPR9YcEbdCTRZ8F9R2aXrnaxPdiLnwzlHCvHVm2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com (2603:10b6:a03:48a::9)
 by SA1PR11MB6806.namprd11.prod.outlook.com (2603:10b6:806:24d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.18; Thu, 21 Jul
 2022 20:53:33 +0000
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::7c8a:9ebc:e674:796e]) by SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::7c8a:9ebc:e674:796e%8]) with mapi id 15.20.5458.019; Thu, 21 Jul 2022
 20:53:33 +0000
From:   "Luck, Tony" <tony.luck@intel.com>
To:     "Bae, Chang Seok" <chang.seok.bae@intel.com>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        "Brown, Len" <len.brown@intel.com>,
        "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>,
        "Chatre, Reinette" <reinette.chatre@intel.com>,
        "Williams, Dan J" <dan.j.williams@intel.com>
CC:     "bagasdotme@gmail.com" <bagasdotme@gmail.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-man@vger.kernel.org" <linux-man@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v3 0/2] x86: AMX enabling example with new constants
Thread-Topic: [PATCH v3 0/2] x86: AMX enabling example with new constants
Thread-Index: AQHYlUrhIQgalduo5UyxpDNPXhizuK2JXENw
Date:   Thu, 21 Jul 2022 20:53:33 +0000
Message-ID: <SJ1PR11MB6083E042762320A642D1FC5AFC919@SJ1PR11MB6083.namprd11.prod.outlook.com>
References: <20220711171347.27309-1-chang.seok.bae@intel.com>
In-Reply-To: <20220711171347.27309-1-chang.seok.bae@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-reaction: no-action
dlp-version: 11.6.500.17
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c0b4b1f1-f319-4853-110e-08da6b5b1307
x-ms-traffictypediagnostic: SA1PR11MB6806:EE_
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: fHtiIxksxB/nwGATDFMqWzmLRORlV0hmAKzgcMapyFbGkOqvVC9p+KdBscmOUQ7upQTaUYAsYzAOm8kpVhsSI9DTdgWZEycBv2hoIzis1CgmUYyAt5+1Tcw1pg5oiXAU7RNAMP+tSfBbDEGTE9KFNjz6aw4x2vnTZ4uLrWDuiRSgSy09hzK0v1PlMRctcqCaicimvTdXBItBbOwu0T8F66Ov2N2ytnFgoItlpOuOOr1LjLQNxfcn17FW/FT9fYYwQViMFkNwzv6mxF1bFyy4XSub+JZQzLl4VtEpTdtWrArPXsLpKJ3gQp342OSumPdrkKgat2JJXgD3UT5uoZJgUO4xSZwaRIsUqYOJykRIzWrxCBXuNB5wP7XpezjcwLlDCQRxSUT/mldanK3wCpBVEgrk6gV+YHrHdvg7tDMZ/65/U5UHlT+wwAp67OQfBWuRZtQe9W9JWYLrcsL/tA1KBTCn1CDTfVl/pekaPUKWi1VgjMZ57xSKDi0HtYLPkVqTtI5ld9+8mKxcm7nXiVPrpGgnbA28sbesVr8T+zUAPp9a7bsejOINy+3/IhZN5VsunZwsH8pmDzzhkZ3a6XqJd6By9wuKwEKDHpXVyxqvlxIE29qYnIfSHikBBqpffxiyN3mRxHRH7p3Imlf6IEJajnUO8hFmVBVu43qMn+GdqsCyukFofL1SA9TNtaBveNCSx3J8NUV7nO6fjnu69KsYAiUXyB5wkQRyMn2+NautsUcw7sbWMRq5X2Smp4nvCyFwFtN+gjTn0keCm8nIAD23vekvgNLvHVZ0UkExY+fGt+jT+jYUzb6y8mokzF3FdKxXxenFovjaZbjOB2ROc5RvF9wIvX0QmxAncP5S82UsebI=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6083.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(366004)(39860400002)(396003)(376002)(346002)(136003)(38100700002)(4326008)(66946007)(8676002)(33656002)(76116006)(7696005)(66446008)(122000001)(66556008)(66476007)(64756008)(41300700001)(26005)(966005)(86362001)(6506007)(55016003)(478600001)(71200400001)(38070700005)(52536014)(316002)(9686003)(83380400001)(921005)(5660300002)(6636002)(82960400001)(186003)(2906002)(8936002)(4744005)(110136005)(54906003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?7tNrEXHqsDw4ld2EO7mXnAxnSzL98gFF6MC3ZNi851IbumIxVDVhjBOAImjD?=
 =?us-ascii?Q?F5MVbvjsblEu2oL7PyGPdZMpxT+R1RzVk6ERXxeQKIHanAiKLjyTgjnQKrLh?=
 =?us-ascii?Q?3Ntzga4K/XQ+faPGBL4cshcNUR+E7Nf0mt6T2D5rs6V5X0QjI76ZYD/rJ7LO?=
 =?us-ascii?Q?JDBTYb9iN1IhzqOxw1weE1DeZF6x32NO1wVrz3xankNeskSDfFrPLH6/r3AH?=
 =?us-ascii?Q?iQChhBLOxeszLzfEU0PVLoGHMkUv/VE7BY+OV75Nf48q4UQ6wQrTZB/u8e1n?=
 =?us-ascii?Q?iF4zP8ILhXJwjcsq0LK7duKsQVG3a5YBOIKAuyoBr6QnET4ssFNNPuwLIYEQ?=
 =?us-ascii?Q?XqkifLd+tgg476GRYrEBWijSFvMPsoUMunuMfOWx9y2fTf5NmH1Z6AscdmTU?=
 =?us-ascii?Q?EZTG8XY4Pe5CY09IFlAy55KAQtdqnOOrLzZQ7HlcQvDGk3/X5iPXMkgE5gRk?=
 =?us-ascii?Q?x92AmPFfvJML8gjX3DX4nSYNAe0//p/iIYJDKTumVKiVV8xAHjZFea57JJB4?=
 =?us-ascii?Q?vyF4hSBmsZW+22+kAfxcJuBIhmwZtbsrbzfakcXHpauLMA+5U4a+LmmJQzwq?=
 =?us-ascii?Q?0a3duHX81k9ptWxuZSEipRGiscuoLJeF4REKQW7C8q4WNzi3tHI2oxxP9Q/m?=
 =?us-ascii?Q?1jxH3U1nDlxkS2Eq7R/yCLNJarJMoHgjLmLWbL5YiLUXlYLT7e2k151+8svm?=
 =?us-ascii?Q?R2xE5QPevgOlTjvUETzqJ4Ij+bK4FBaLB9rfD5zy9VfVT63erFDF99mMVlda?=
 =?us-ascii?Q?yox5YkzXLyXz/sXr5UkY6VkQhm58Rrcz898fPpu3g41su3sc6h7nNDBZOnEc?=
 =?us-ascii?Q?UcEwEPVhk9358lprPwZ3RbzfTbcXqCAtLphuMta3g6p/8D7G2aha7jcrN/Dq?=
 =?us-ascii?Q?cbO3DkmTj80dpeT9oJQ7539oe3P61ZdQqWwxxoS3IAdVqORNabGRcMD/flmc?=
 =?us-ascii?Q?R8k7jEclkCFy+bgEQOEYeEoNEbbP8ws7TZyPM4YAi7gltllmXPH0Me3YfyEM?=
 =?us-ascii?Q?PiO2RRruqx6FsZJz0b3FQ/UfY06fhl04Z+QEkisdV6xEYIvtxDuqszX1w/AG?=
 =?us-ascii?Q?CoiGPAieNNdqDRRdbByk395NTIFplvY6QXECGROOaIDKUhRAgGzYQlbAC0Gj?=
 =?us-ascii?Q?ZXvjuFPzJQ8D93Ovcwxf4EjLPedzTReN4j4tVJm1swzyx694QTZUJ3xh9eOi?=
 =?us-ascii?Q?BJaWFeUVlC5S1WyPo6ym4jVplfU7/sgl1kmmnsYYUdyuyVgIQFfvKfRlNrsK?=
 =?us-ascii?Q?B30wUxP2QYU/JbhPezZ9Qnbx0fKXERSR9VdzX4SX3TJ/HpCfsC/liNgDnAPq?=
 =?us-ascii?Q?F3fwCvEi2XZscMsBmiT9W/8OF07OTbPsBhlRHgkbewGDxWZMzBT6jYq/kX6u?=
 =?us-ascii?Q?zek3DpafrcL2fqYMV+1QmCmXRUNf49ZVezDX5RYUZxRVQOxdCA2ddh/3ViO6?=
 =?us-ascii?Q?wlQkgWrqjv3lGjjy2JuQIUqD8LHjRnxMcoZ/O0i4wXvi2oFvD4G3/6lH062D?=
 =?us-ascii?Q?XHvUam18e/CbZAGyZoMLrSBIVvDn1rXlpdqQragSAxUwwOoRCT2H6sylYOFw?=
 =?us-ascii?Q?wWRYs3zPqY1RUCxsV7guz82BSw3hODEBe5PQ6pFg?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6083.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c0b4b1f1-f319-4853-110e-08da6b5b1307
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jul 2022 20:53:33.1304
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 89yUJDbdAq0QFOB/941zRzp4dmIYgIoguJiY2hSOPfkKBeVzZpz/Xsrap4RJ5UPXfYp7/QxwKPWPuxKdKvhDyg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB6806
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> The arch_prctl(2) manual page [2] is missing these new options. Perhaps,
> the man-page update follows up along with this.

This isn't the right process to get a manual page updated.

See:

https://www.kernel.org/doc/man-pages/contributing.html

then log a bug, write a patch, and submit it to add the AMX options.

-Tony
