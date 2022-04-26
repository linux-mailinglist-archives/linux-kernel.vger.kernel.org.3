Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5710350EE6E
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 04:01:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242423AbiDZCDr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 22:03:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242041AbiDZCD1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 22:03:27 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2440A185;
        Mon, 25 Apr 2022 19:00:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650938418; x=1682474418;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ArqQbWAeL3VMlb0NxZ2q61Zmwb6hxUKVbjTvm+7jXHk=;
  b=Kcmhx2jEtitWXTYFdOC9N0vnN1eaRGGAhXI8f7p7WA3AmhAbAi5c/2L8
   2Bob18DYC8SGDADLx7q8pU+0tXaLmt5kgV7t3BDMrOKs3GTHe9A2c1zQ1
   N/eLCBFlTHkB6a0dcJLRUic1+0SzLINmUEzqLb+O2dT00FXvNzPTuh9fy
   yEUkXP6gbSMhUlQcfvmdAjIZIyTSVPbds814b9KnJoRa76PVMz31yw0cZ
   AWfLTH/XAMvOyENq+WB9sgA5di9J1Ieh7OnExjEyDLvbtuo3uLAYTPFiP
   /lC4YnLdiJ3tZR6ogK+7YSLFJlDt7+HDtpp2155cnvjBhsNCuDZ3Ft1SY
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10328"; a="245343834"
X-IronPort-AV: E=Sophos;i="5.90,289,1643702400"; 
   d="scan'208";a="245343834"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Apr 2022 19:00:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,289,1643702400"; 
   d="scan'208";a="730008148"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga005.jf.intel.com with ESMTP; 25 Apr 2022 19:00:15 -0700
Received: from fmsmsx609.amr.corp.intel.com (10.18.126.89) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Mon, 25 Apr 2022 19:00:15 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx609.amr.corp.intel.com (10.18.126.89) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Mon, 25 Apr 2022 19:00:15 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.48) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Mon, 25 Apr 2022 19:00:14 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lvA1dHRkbOcZy/KXrPejhBcUYwyxW5yytzq6wZfzNOZ1kwf2RIzTEMkJ7U/3B8LJmkTjyrq7xY0EceBLoEk1buBHFAFYvaDd7KUS9tcEPe30rqm5aFbIOixL0w8DG0SwSpILf+PqSK0C2x0pwLPVjDtERT2tIsCr0ENBE9mwrOphff3j00SzTFcDjRAnGPbv6w8Aupk+DJRQoNxmVLr/pQ5qzTXtwtL5kP4yBUPVnwW2g1zD/cYNjj8MkWV3nS/aD43JYvmvhbRRm+xfglgkkvyjcU5YXRrrVPgDjWuwukszmPN7TOEpF1Oq4BGySMCj3ox36p/HH8UrxU2eVUbhsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h61Zol0GmKDK8FlY4p9B/bgnrTENXDQQkqz6uNmCPk4=;
 b=Ly8s72GA+YmMktLX9D7M5aPbmtrLlq1VyHOKZt8/WNuf0lPEnV0k3kAjv18RW47slN263jb/QFDlTDjTP3JmBylm+XOLelkKg5S5KCTc2Vd8aDFpiJKy5J+kZ29Po06Pv0Z8Z0w8UtuCi4OJTTPjJ/8nWSYa+DDmdaH6OF69yAZOO40gmb5s74tuqSKxT4s85p3WfBls+gAmMMovYbC/+wWdBC2EVMaTeDBsAFMvNoo8RXl5/DaBpERkVjSz++xVU8/M7if+P5bwr13JNR85uGJYAXiiW9pDVZbiB+1uRC0vEqLChOtEG96sCKJCmt7Pf8/Qvk5RJF/EhgFuUG4fkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM6PR11MB3819.namprd11.prod.outlook.com (2603:10b6:5:13f::31)
 by CO1PR11MB5171.namprd11.prod.outlook.com (2603:10b6:303:94::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.14; Tue, 26 Apr
 2022 02:00:10 +0000
Received: from DM6PR11MB3819.namprd11.prod.outlook.com
 ([fe80::4838:60ae:b637:3fc0]) by DM6PR11MB3819.namprd11.prod.outlook.com
 ([fe80::4838:60ae:b637:3fc0%7]) with mapi id 15.20.5186.021; Tue, 26 Apr 2022
 02:00:10 +0000
From:   "Wu, Hao" <hao.wu@intel.com>
To:     "Weight, Russell H" <russell.h.weight@intel.com>,
        "mdf@kernel.org" <mdf@kernel.org>,
        "linux-fpga@vger.kernel.org" <linux-fpga@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "trix@redhat.com" <trix@redhat.com>,
        "marpagan@redhat.com" <marpagan@redhat.com>,
        "lgoncalv@redhat.com" <lgoncalv@redhat.com>,
        "Xu, Yilun" <yilun.xu@intel.com>,
        "matthew.gerlach@linux.intel.com" <matthew.gerlach@linux.intel.com>,
        "Zhang, Tianfei" <tianfei.zhang@intel.com>
Subject: RE: [PATCH v1 1/1] fpga: dfl: fix the kernel warning when
 release/assign ports for SRIOV
Thread-Topic: [PATCH v1 1/1] fpga: dfl: fix the kernel warning when
 release/assign ports for SRIOV
Thread-Index: AQHYWMy1sPClzZ7G3EKCG4O5Lrzpy60BYROw
Date:   Tue, 26 Apr 2022 02:00:10 +0000
Message-ID: <DM6PR11MB3819F9CCD0A6126B55BCB47685FB9@DM6PR11MB3819.namprd11.prod.outlook.com>
References: <20220425174827.89819-1-russell.h.weight@intel.com>
In-Reply-To: <20220425174827.89819-1-russell.h.weight@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-reaction: no-action
dlp-version: 11.6.401.20
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e5eca1bc-fe1d-461d-d93d-08da27287ee0
x-ms-traffictypediagnostic: CO1PR11MB5171:EE_
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-microsoft-antispam-prvs: <CO1PR11MB51712DFD3F725706FDAAD34185FB9@CO1PR11MB5171.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: yiFHJEwEkWvOYFDx+dU4th2sfYJgcOt5t2G5myJqw4semO88xaaaro/WgG9dqgafjpUoOwl/eXeSirelYfN7JigNFiMyw7wxFhH61No+hCHrXsbwnHMh+of9f3Cv+7s8+B8FZTgxZt8/TiM7dL5yrZQZ2cWf+Qc2XKBtahetpCkvq4H0OcwUF2jZ88ObFYq9q4VGaBfcB3vH7BcaHLYNnQb66RmwTHVqiQoVJoLVIwzgMZI3oVR5Gko/JFW2SLaHEHd3xc8ypgbLPd9Wo32REdxBoX4vbPoSnKxEkoOlSDmFZoLLjlcUAM4hwj2atRhOVRtzIZKCOHIlNJXzmC3wsVLELOY2HZRDSck7LJ6yme8Yes71of1fcIyL3w1RpG++sPTJg1zDOkyIF9IebOMZf6kBz7Xk2FA9w9i0qQZFgzajuusoDJjj+AIlcUO0v6JAjZA5f3jjUALqqS0xEhawF6i77BiwxUEginxvjXYk7yB3nONNFBkDHzWAxCI7XF8OFp0wgSwP9XDKJ1ObuMBrSpdIdmCcUnbFb8gjqN0qQVObAKqkzJCLJex/UI37TpU24814Tv2D/cMJLLt6lACeF+k2+s1WKenzTwsXwSYrYXmnbjrfJFvHjB3AmBT3bw95gGDFLUdevI7BbUdnsKZyW8ieE8M0n698fwYbW2EYb2Ty6riOwWX0VWbV0qo86gzH8aXpcsbmCQiV7FyqBWIHzOSNUG/kKwAoeP5i85cy86o=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3819.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(316002)(38100700002)(66556008)(38070700005)(86362001)(508600001)(30864003)(110136005)(54906003)(26005)(9686003)(71200400001)(76116006)(66946007)(122000001)(82960400001)(4326008)(8676002)(33656002)(66476007)(64756008)(53546011)(66446008)(52536014)(8936002)(5660300002)(7696005)(6506007)(83380400001)(2906002)(186003)(55016003)(579004)(559001)(309714004);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?mofxRqqPyQYkZJUgTHQkcoTFhjPEEdf0UdBWImj2EQEp9g4YnU4djMjO64RK?=
 =?us-ascii?Q?nlKg45cSEmE0RGgumFuL0msTdVlqUej2IT10nuXdxTtwp4DkwagIo+xZSk2X?=
 =?us-ascii?Q?K4hSDbBAT2X2ax77IsEhlwLQfBzSrDZ0RKycJmYJrZOVWntNFcbfSOFVJGfH?=
 =?us-ascii?Q?5GWPAbF6v0kSxC3JJA1duNzmQPxAOdo927yepYLIsvN6yZajQ/M+S6nEhU+g?=
 =?us-ascii?Q?gyYsL66bd3tA3UE2vAIsKE4xez6Rh2JZHvqvIsVvSQbHmEZuMJXnGRVA+nJF?=
 =?us-ascii?Q?/tPJKpITIixqv5NPBAZobBGxu3f1H9kVr/cYN4XaKePw2mFvatdPlpKdwKW8?=
 =?us-ascii?Q?TO2lIpN0jx6haUBINvm60OBqS3vzevMuXbX0C8xicB2T5E8O7vggjxVOGXap?=
 =?us-ascii?Q?PTZbmPUwO4nwchRLjjlQ0a575CqVDoU4zy63n6b5kkotuKFJqCC9MijsHy4Q?=
 =?us-ascii?Q?G2Hr3CAN7t0GG8u8LL9d3OGUtFAW8N8v8IKKUZsgCt9bM+6CzWGiEJM1S4jk?=
 =?us-ascii?Q?n36zWlKT2D04NGDcxMJcGRcSsfv6MQmB3/gWm0hSxrKk+gBqby4IgfgMiGeJ?=
 =?us-ascii?Q?kz/hogLC36pgecpTl3XoR6wJSrOJtlhiWGlkmwE3y1E8iMJnHVZ+VnpiA336?=
 =?us-ascii?Q?m1sEGdnMLauCKRakTdGiTRZkrHFqPQHkhXjTlF0lqQOA7EguJ8wiPjGzT11t?=
 =?us-ascii?Q?2G11pvrq5xlPSHHJ9xC8n3dEL+OBvO7AMd7kMfzq4uBLmN52iMeNOoA19KaE?=
 =?us-ascii?Q?6lF3eMnyYj321CK2ctHhS2ELmtmrHS6FkQh3IXVqAI8EVre+qIE6FInfJg1V?=
 =?us-ascii?Q?lu+prlsOT+mKD1h3y88D/F3gH9EYK5HRv1PZ82vRRrGky6X7+OAZbz/rQna9?=
 =?us-ascii?Q?69yjaeKBHv+SAlYeC3MzmjiQvK1Za1Azc87QPF5X0vycWLBUB804ivWYvBZP?=
 =?us-ascii?Q?zKguiKxbk/GwNNw7MD5BXUS/QsgHSsouzIWnfAgT0SDoSB7jg0CBV8ev4VcA?=
 =?us-ascii?Q?8gKBk9A4ypvYIUwtYv2oFOgGumfFbA/lmy3lg7EE7PgxnIZk94OYqbh9H2tR?=
 =?us-ascii?Q?1AkOCtxFrUG9Am0Zt/hqSHq8exwfBc3NIne+lr+iE0oBWXr4AXywB0ImNn6T?=
 =?us-ascii?Q?vrgSah3NwhXNFNnfqceudLzu4rH9YWtxTy4mm72/Yt8iYhy84b8qK61Y0CiB?=
 =?us-ascii?Q?lgyqUhpH0ljScuh+hncXRAAZloX3TZH3yc95jn6ip18+Vc5x4el2odwFIa1g?=
 =?us-ascii?Q?50jpOcBtcJf6i5lpPGxmAkXk+Tpw7NmizSICSPuJYFgq02ovSTULMBkEFuTe?=
 =?us-ascii?Q?RsWAPubgi2KC6IpaBu986DiVAd/2N5n63z8z2kYY7CV/AHSQyZl+lbLX3d1d?=
 =?us-ascii?Q?5Ks5AibUp1o+YnIsYyUbrkL6ajPoC8LsPLw8Qf1GRCmueM05tTwcymfLWbZs?=
 =?us-ascii?Q?I5fQwv92HUflbmLOCH7D3gKki1PZkva4yJaBmAzHeSR4GePXszKq+Nu4+S6n?=
 =?us-ascii?Q?+vt2chdaSOlDLqo6SKB70hbfo2gUjTTvWgvlKqIwq685+DqhUkLRypskkHgc?=
 =?us-ascii?Q?BJQNhEPHwyxFsHuAWOkXRvx7q1NefvLdIxag1trXPF5GLafD/gU+nZwDDy1v?=
 =?us-ascii?Q?kke2mKk+Nfs0hrP9ahzLSj/K6xfa7XJdvpIFVzpfIaLiOs7A6hY4uFPPJgRZ?=
 =?us-ascii?Q?/K+daWpmu7lCr28DFpCeft4dXbV15gGn6gp93PkF1cuaLIXbYrBQe8H2/2hY?=
 =?us-ascii?Q?fSNDWZ9FiQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3819.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e5eca1bc-fe1d-461d-d93d-08da27287ee0
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Apr 2022 02:00:10.6874
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nbYfPQZqltlep7WC4K65os1YZRVPyDTclHcJWMBnuX7+it+SmA4RWD9LEpofrEu5fW3NTbnYoAtvxblfrO3m4w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB5171
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> -----Original Message-----
> From: Weight, Russell H <russell.h.weight@intel.com>
> Sent: Tuesday, April 26, 2022 1:48 AM
> To: mdf@kernel.org; linux-fpga@vger.kernel.org; linux-kernel@vger.kernel.=
org
> Cc: trix@redhat.com; marpagan@redhat.com; lgoncalv@redhat.com; Xu, Yilun
> <yilun.xu@intel.com>; Wu, Hao <hao.wu@intel.com>;
> matthew.gerlach@linux.intel.com; Zhang, Tianfei <tianfei.zhang@intel.com>=
;
> Weight, Russell H <russell.h.weight@intel.com>
> Subject: [PATCH v1 1/1] fpga: dfl: fix the kernel warning when release/as=
sign
> ports for SRIOV
>=20
> From: Xu Yilun <yilun.xu@intel.com>
>=20
> The dfl ports are registered as platform devices in PF mode. The port
> device should be removed from host when the user wants to configure the
> port as VF and pass through to VM. The FME dev ioctls
> DFL_FPGA_FME_PORT_RELEASE/ASSIGN are designed for this purpose.
>=20
> In previous implementation, the port platform device is not completely
> destroyed on port release. It is removed from system by
> platform_device_del(), but the platform device instance is retained.
> When the port assign ioctl is called, it is added back by
> platform_device_add(). It conflicts to the comments of device_add():
> "Do not call this routine more than once for any device structure",
> and will cause kernel warning at runtime.
>=20
> The patch tries to completely unregisters the port platform device on
> release and registers a new one on assign. But the main work is to
> remove the dependency of struct dfl_feature_platform_data for many
> internal DFL APIs. This structure holds many DFL enumeration info for
> feature devices. Many DFL APIs are expected to work with these info even
> when the port platform device is unregistered. But with the change the
> platform_data will be freed in this case. So this patch introduced a new
> structure dfl_feature_dev_data for these APIs, it acts similarly as the
> previous dfl_feature_platform_data. The dfl_feature_platform_data then
> only needs a pointer this dfl_feature_dev_data to make feature device
> driver work.

Just did a quick look, I didn't see any problem on the idea of this fixing.
But is it possible to split this big patch into several steps, e.g. some
preparation work and then key logic for the fixing?=20

>=20
> Signed-off-by: Xu Yilun <yilun.xu@intel.com>
> Signed-off-by: Russ Weight <russell.h.weight@intel.com>
> ---
>  drivers/fpga/dfl-afu-dma-region.c | 119 +++++----
>  drivers/fpga/dfl-afu-error.c      |  59 +++--
>  drivers/fpga/dfl-afu-main.c       | 254 +++++++++---------
>  drivers/fpga/dfl-afu-region.c     |  50 ++--
>  drivers/fpga/dfl-afu.h            |  26 +-
>  drivers/fpga/dfl-fme-br.c         |  24 +-
>  drivers/fpga/dfl-fme-error.c      |  98 +++----
>  drivers/fpga/dfl-fme-main.c       |  70 +++--
>  drivers/fpga/dfl-fme-pr.c         |  84 +++---
>  drivers/fpga/dfl.c                | 427 +++++++++++++++---------------
>  drivers/fpga/dfl.h                | 138 ++++++----
>  11 files changed, 696 insertions(+), 653 deletions(-)
>=20
> diff --git a/drivers/fpga/dfl-afu-dma-region.c b/drivers/fpga/dfl-afu-dma=
-
> region.c
> index 02b60fde0430..d85c41435b39 100644
> --- a/drivers/fpga/dfl-afu-dma-region.c
> +++ b/drivers/fpga/dfl-afu-dma-region.c
> @@ -16,26 +16,26 @@
>=20
>  #include "dfl-afu.h"
>=20
> -void afu_dma_region_init(struct dfl_feature_platform_data *pdata)
> +void afu_dma_region_init(struct dfl_feature_dev_data *fdata)
>  {
> -	struct dfl_afu *afu =3D dfl_fpga_pdata_get_private(pdata);
> +	struct dfl_afu *afu =3D dfl_fpga_fdata_get_private(fdata);
>=20
>  	afu->dma_regions =3D RB_ROOT;
>  }
>=20
>  /**
>   * afu_dma_pin_pages - pin pages of given dma memory region
> - * @pdata: feature device platform data
> + * @fdata: feature dev data
>   * @region: dma memory region to be pinned
>   *
>   * Pin all the pages of given dfl_afu_dma_region.
>   * Return 0 for success or negative error code.
>   */
> -static int afu_dma_pin_pages(struct dfl_feature_platform_data *pdata,
> +static int afu_dma_pin_pages(struct dfl_feature_dev_data *fdata,
>  			     struct dfl_afu_dma_region *region)
>  {
>  	int npages =3D region->length >> PAGE_SHIFT;
> -	struct device *dev =3D &pdata->dev->dev;
> +	struct device *dev =3D &fdata->dev->dev;
>  	int ret, pinned;
>=20
>  	ret =3D account_locked_vm(current->mm, npages, true);
> @@ -73,17 +73,17 @@ static int afu_dma_pin_pages(struct
> dfl_feature_platform_data *pdata,
>=20
>  /**
>   * afu_dma_unpin_pages - unpin pages of given dma memory region
> - * @pdata: feature device platform data
> + * @fdata: feature dev data
>   * @region: dma memory region to be unpinned
>   *
>   * Unpin all the pages of given dfl_afu_dma_region.
>   * Return 0 for success or negative error code.
>   */
> -static void afu_dma_unpin_pages(struct dfl_feature_platform_data *pdata,
> +static void afu_dma_unpin_pages(struct dfl_feature_dev_data *fdata,
>  				struct dfl_afu_dma_region *region)
>  {
> +	struct device *dev =3D &fdata->dev->dev;
>  	long npages =3D region->length >> PAGE_SHIFT;
> -	struct device *dev =3D &pdata->dev->dev;
>=20
>  	unpin_user_pages(region->pages, npages);
>  	kfree(region->pages);
> @@ -133,20 +133,21 @@ static bool dma_region_check_iova(struct
> dfl_afu_dma_region *region,
>=20
>  /**
>   * afu_dma_region_add - add given dma region to rbtree
> - * @pdata: feature device platform data
> + * @fdata: feature dev data
>   * @region: dma region to be added
>   *
>   * Return 0 for success, -EEXIST if dma region has already been added.
>   *
> - * Needs to be called with pdata->lock heold.
> + * Needs to be called with fdata->lock held.
>   */
> -static int afu_dma_region_add(struct dfl_feature_platform_data *pdata,
> +static int afu_dma_region_add(struct dfl_feature_dev_data *fdata,
>  			      struct dfl_afu_dma_region *region)
>  {
> -	struct dfl_afu *afu =3D dfl_fpga_pdata_get_private(pdata);
> +	struct dfl_afu *afu =3D dfl_fpga_fdata_get_private(fdata);
> +	struct device *dev =3D &fdata->dev->dev;
>  	struct rb_node **new, *parent =3D NULL;
>=20
> -	dev_dbg(&pdata->dev->dev, "add region (iova =3D %llx)\n",
> +	dev_dbg(dev, "add region (iova =3D %llx)\n",
>  		(unsigned long long)region->iova);
>=20
>  	new =3D &afu->dma_regions.rb_node;
> @@ -177,50 +178,51 @@ static int afu_dma_region_add(struct
> dfl_feature_platform_data *pdata,
>=20
>  /**
>   * afu_dma_region_remove - remove given dma region from rbtree
> - * @pdata: feature device platform data
> + * @fdata: feature dev data
>   * @region: dma region to be removed
>   *
> - * Needs to be called with pdata->lock heold.
> + * Needs to be called with fdata->lock held.
>   */
> -static void afu_dma_region_remove(struct dfl_feature_platform_data *pdat=
a,
> +static void afu_dma_region_remove(struct dfl_feature_dev_data *fdata,
>  				  struct dfl_afu_dma_region *region)
>  {
> +	struct device *dev =3D &fdata->dev->dev;
>  	struct dfl_afu *afu;
>=20
> -	dev_dbg(&pdata->dev->dev, "del region (iova =3D %llx)\n",
> +	dev_dbg(dev, "del region (iova =3D %llx)\n",
>  		(unsigned long long)region->iova);
>=20
> -	afu =3D dfl_fpga_pdata_get_private(pdata);
> +	afu =3D dfl_fpga_fdata_get_private(fdata);
>  	rb_erase(&region->node, &afu->dma_regions);
>  }
>=20
>  /**
>   * afu_dma_region_destroy - destroy all regions in rbtree
> - * @pdata: feature device platform data
> + * @fdata: feature dev data
>   *
> - * Needs to be called with pdata->lock heold.
> + * Needs to be called with fdata->lock held.
>   */
> -void afu_dma_region_destroy(struct dfl_feature_platform_data *pdata)
> +void afu_dma_region_destroy(struct dfl_feature_dev_data *fdata)
>  {
> -	struct dfl_afu *afu =3D dfl_fpga_pdata_get_private(pdata);
> +	struct dfl_afu *afu =3D dfl_fpga_fdata_get_private(fdata);
>  	struct rb_node *node =3D rb_first(&afu->dma_regions);
>  	struct dfl_afu_dma_region *region;
>=20
>  	while (node) {
>  		region =3D container_of(node, struct dfl_afu_dma_region, node);
>=20
> -		dev_dbg(&pdata->dev->dev, "del region (iova =3D %llx)\n",
> +		dev_dbg(&fdata->dev->dev, "del region (iova =3D %llx)\n",
>  			(unsigned long long)region->iova);
>=20
>  		rb_erase(node, &afu->dma_regions);
>=20
>  		if (region->iova)
> -			dma_unmap_page(dfl_fpga_pdata_to_parent(pdata),
> +			dma_unmap_page(dfl_fpga_fdata_to_parent(fdata),
>  				       region->iova, region->length,
>  				       DMA_BIDIRECTIONAL);
>=20
>  		if (region->pages)
> -			afu_dma_unpin_pages(pdata, region);
> +			afu_dma_unpin_pages(fdata, region);
>=20
>  		node =3D rb_next(node);
>  		kfree(region);
> @@ -229,7 +231,7 @@ void afu_dma_region_destroy(struct
> dfl_feature_platform_data *pdata)
>=20
>  /**
>   * afu_dma_region_find - find the dma region from rbtree based on iova a=
nd
> size
> - * @pdata: feature device platform data
> + * @fdata: feature dev data
>   * @iova: address of the dma memory area
>   * @size: size of the dma memory area
>   *
> @@ -239,14 +241,14 @@ void afu_dma_region_destroy(struct
> dfl_feature_platform_data *pdata)
>   *   [@iova, @iova+size)
>   * If nothing is matched returns NULL.
>   *
> - * Needs to be called with pdata->lock held.
> + * Needs to be called with fdata->lock held.
>   */
>  struct dfl_afu_dma_region *
> -afu_dma_region_find(struct dfl_feature_platform_data *pdata, u64 iova, u=
64
> size)
> +afu_dma_region_find(struct dfl_feature_dev_data *fdata, u64 iova, u64 si=
ze)
>  {
> -	struct dfl_afu *afu =3D dfl_fpga_pdata_get_private(pdata);
> +	struct dfl_afu *afu =3D dfl_fpga_fdata_get_private(fdata);
>  	struct rb_node *node =3D afu->dma_regions.rb_node;
> -	struct device *dev =3D &pdata->dev->dev;
> +	struct device *dev =3D &fdata->dev->dev;
>=20
>  	while (node) {
>  		struct dfl_afu_dma_region *region;
> @@ -276,20 +278,20 @@ afu_dma_region_find(struct
> dfl_feature_platform_data *pdata, u64 iova, u64 size)
>=20
>  /**
>   * afu_dma_region_find_iova - find the dma region from rbtree by iova
> - * @pdata: feature device platform data
> + * @fdata: feature dev data
>   * @iova: address of the dma region
>   *
> - * Needs to be called with pdata->lock held.
> + * Needs to be called with fdata->lock held.
>   */
>  static struct dfl_afu_dma_region *
> -afu_dma_region_find_iova(struct dfl_feature_platform_data *pdata, u64 io=
va)
> +afu_dma_region_find_iova(struct dfl_feature_dev_data *fdata, u64 iova)
>  {
> -	return afu_dma_region_find(pdata, iova, 0);
> +	return afu_dma_region_find(fdata, iova, 0);
>  }
>=20
>  /**
>   * afu_dma_map_region - map memory region for dma
> - * @pdata: feature device platform data
> + * @fdata: feature dev data
>   * @user_addr: address of the memory region
>   * @length: size of the memory region
>   * @iova: pointer of iova address
> @@ -298,9 +300,10 @@ afu_dma_region_find_iova(struct
> dfl_feature_platform_data *pdata, u64 iova)
>   * of the memory region via @iova.
>   * Return 0 for success, otherwise error code.
>   */
> -int afu_dma_map_region(struct dfl_feature_platform_data *pdata,
> +int afu_dma_map_region(struct dfl_feature_dev_data *fdata,
>  		       u64 user_addr, u64 length, u64 *iova)
>  {
> +	struct device *dev =3D &fdata->dev->dev;
>  	struct dfl_afu_dma_region *region;
>  	int ret;
>=20
> @@ -323,47 +326,47 @@ int afu_dma_map_region(struct
> dfl_feature_platform_data *pdata,
>  	region->length =3D length;
>=20
>  	/* Pin the user memory region */
> -	ret =3D afu_dma_pin_pages(pdata, region);
> +	ret =3D afu_dma_pin_pages(fdata, region);
>  	if (ret) {
> -		dev_err(&pdata->dev->dev, "failed to pin memory region\n");
> +		dev_err(dev, "failed to pin memory region\n");
>  		goto free_region;
>  	}
>=20
>  	/* Only accept continuous pages, return error else */
>  	if (!afu_dma_check_continuous_pages(region)) {
> -		dev_err(&pdata->dev->dev, "pages are not continuous\n");
> +		dev_err(dev, "pages are not continuous\n");
>  		ret =3D -EINVAL;
>  		goto unpin_pages;
>  	}
>=20
>  	/* As pages are continuous then start to do DMA mapping */
> -	region->iova =3D dma_map_page(dfl_fpga_pdata_to_parent(pdata),
> +	region->iova =3D dma_map_page(dfl_fpga_fdata_to_parent(fdata),
>  				    region->pages[0], 0,
>  				    region->length,
>  				    DMA_BIDIRECTIONAL);
> -	if (dma_mapping_error(dfl_fpga_pdata_to_parent(pdata), region->iova))
> {
> -		dev_err(&pdata->dev->dev, "failed to map for dma\n");
> +	if (dma_mapping_error(dfl_fpga_fdata_to_parent(fdata), region->iova))
> {
> +		dev_err(dev, "failed to map for dma\n");
>  		ret =3D -EFAULT;
>  		goto unpin_pages;
>  	}
>=20
>  	*iova =3D region->iova;
>=20
> -	mutex_lock(&pdata->lock);
> -	ret =3D afu_dma_region_add(pdata, region);
> -	mutex_unlock(&pdata->lock);
> +	mutex_lock(&fdata->lock);
> +	ret =3D afu_dma_region_add(fdata, region);
> +	mutex_unlock(&fdata->lock);
>  	if (ret) {
> -		dev_err(&pdata->dev->dev, "failed to add dma region\n");
> +		dev_err(dev, "failed to add dma region\n");
>  		goto unmap_dma;
>  	}
>=20
>  	return 0;
>=20
>  unmap_dma:
> -	dma_unmap_page(dfl_fpga_pdata_to_parent(pdata),
> +	dma_unmap_page(dfl_fpga_fdata_to_parent(fdata),
>  		       region->iova, region->length, DMA_BIDIRECTIONAL);
>  unpin_pages:
> -	afu_dma_unpin_pages(pdata, region);
> +	afu_dma_unpin_pages(fdata, region);
>  free_region:
>  	kfree(region);
>  	return ret;
> @@ -371,34 +374,34 @@ int afu_dma_map_region(struct
> dfl_feature_platform_data *pdata,
>=20
>  /**
>   * afu_dma_unmap_region - unmap dma memory region
> - * @pdata: feature device platform data
> + * @fdata: feature dev data
>   * @iova: dma address of the region
>   *
>   * Unmap dma memory region based on @iova.
>   * Return 0 for success, otherwise error code.
>   */
> -int afu_dma_unmap_region(struct dfl_feature_platform_data *pdata, u64 io=
va)
> +int afu_dma_unmap_region(struct dfl_feature_dev_data *fdata, u64 iova)
>  {
>  	struct dfl_afu_dma_region *region;
>=20
> -	mutex_lock(&pdata->lock);
> -	region =3D afu_dma_region_find_iova(pdata, iova);
> +	mutex_lock(&fdata->lock);
> +	region =3D afu_dma_region_find_iova(fdata, iova);
>  	if (!region) {
> -		mutex_unlock(&pdata->lock);
> +		mutex_unlock(&fdata->lock);
>  		return -EINVAL;
>  	}
>=20
>  	if (region->in_use) {
> -		mutex_unlock(&pdata->lock);
> +		mutex_unlock(&fdata->lock);
>  		return -EBUSY;
>  	}
>=20
> -	afu_dma_region_remove(pdata, region);
> -	mutex_unlock(&pdata->lock);
> +	afu_dma_region_remove(fdata, region);
> +	mutex_unlock(&fdata->lock);
>=20
> -	dma_unmap_page(dfl_fpga_pdata_to_parent(pdata),
> +	dma_unmap_page(dfl_fpga_fdata_to_parent(fdata),
>  		       region->iova, region->length, DMA_BIDIRECTIONAL);
> -	afu_dma_unpin_pages(pdata, region);
> +	afu_dma_unpin_pages(fdata, region);
>  	kfree(region);
>=20
>  	return 0;
> diff --git a/drivers/fpga/dfl-afu-error.c b/drivers/fpga/dfl-afu-error.c
> index ab7be6217368..0f392d1f6d45 100644
> --- a/drivers/fpga/dfl-afu-error.c
> +++ b/drivers/fpga/dfl-afu-error.c
> @@ -28,37 +28,36 @@
>  #define ERROR_MASK		GENMASK_ULL(63, 0)
>=20
>  /* mask or unmask port errors by the error mask register. */
> -static void __afu_port_err_mask(struct device *dev, bool mask)
> +static void __afu_port_err_mask(struct dfl_feature_dev_data *fdata, bool
> mask)
>  {
>  	void __iomem *base;
>=20
> -	base =3D dfl_get_feature_ioaddr_by_id(dev, PORT_FEATURE_ID_ERROR);
> +	base =3D dfl_get_feature_ioaddr_by_id(fdata,
> PORT_FEATURE_ID_ERROR);
>=20
>  	writeq(mask ? ERROR_MASK : 0, base + PORT_ERROR_MASK);
>  }
>=20
>  static void afu_port_err_mask(struct device *dev, bool mask)
>  {
> -	struct dfl_feature_platform_data *pdata =3D dev_get_platdata(dev);
> +	struct dfl_feature_dev_data *fdata =3D to_dfl_feature_dev_data(dev);
>=20
> -	mutex_lock(&pdata->lock);
> -	__afu_port_err_mask(dev, mask);
> -	mutex_unlock(&pdata->lock);
> +	mutex_lock(&fdata->lock);
> +	__afu_port_err_mask(fdata, mask);
> +	mutex_unlock(&fdata->lock);
>  }
>=20
>  /* clear port errors. */
>  static int afu_port_err_clear(struct device *dev, u64 err)
>  {
> -	struct dfl_feature_platform_data *pdata =3D dev_get_platdata(dev);
> -	struct platform_device *pdev =3D to_platform_device(dev);
> +	struct dfl_feature_dev_data *fdata =3D to_dfl_feature_dev_data(dev);
>  	void __iomem *base_err, *base_hdr;
>  	int enable_ret =3D 0, ret =3D -EBUSY;
>  	u64 v;
>=20
> -	base_err =3D dfl_get_feature_ioaddr_by_id(dev,
> PORT_FEATURE_ID_ERROR);
> -	base_hdr =3D dfl_get_feature_ioaddr_by_id(dev,
> PORT_FEATURE_ID_HEADER);
> +	base_err =3D dfl_get_feature_ioaddr_by_id(fdata,
> PORT_FEATURE_ID_ERROR);
> +	base_hdr =3D dfl_get_feature_ioaddr_by_id(fdata,
> PORT_FEATURE_ID_HEADER);
>=20
> -	mutex_lock(&pdata->lock);
> +	mutex_lock(&fdata->lock);
>=20
>  	/*
>  	 * clear Port Errors
> @@ -80,12 +79,12 @@ static int afu_port_err_clear(struct device *dev, u64=
 err)
>  	}
>=20
>  	/* Halt Port by keeping Port in reset */
> -	ret =3D __afu_port_disable(pdev);
> +	ret =3D __afu_port_disable(fdata);
>  	if (ret)
>  		goto done;
>=20
>  	/* Mask all errors */
> -	__afu_port_err_mask(dev, true);
> +	__afu_port_err_mask(fdata, true);
>=20
>  	/* Clear errors if err input matches with current port errors.*/
>  	v =3D readq(base_err + PORT_ERROR);
> @@ -102,28 +101,28 @@ static int afu_port_err_clear(struct device *dev, u=
64
> err)
>  	}
>=20
>  	/* Clear mask */
> -	__afu_port_err_mask(dev, false);
> +	__afu_port_err_mask(fdata, false);
>=20
>  	/* Enable the Port by clearing the reset */
> -	enable_ret =3D __afu_port_enable(pdev);
> +	enable_ret =3D __afu_port_enable(fdata);
>=20
>  done:
> -	mutex_unlock(&pdata->lock);
> +	mutex_unlock(&fdata->lock);
>  	return enable_ret ? enable_ret : ret;
>  }
>=20
>  static ssize_t errors_show(struct device *dev, struct device_attribute *=
attr,
>  			   char *buf)
>  {
> -	struct dfl_feature_platform_data *pdata =3D dev_get_platdata(dev);
> +	struct dfl_feature_dev_data *fdata =3D to_dfl_feature_dev_data(dev);
>  	void __iomem *base;
>  	u64 error;
>=20
> -	base =3D dfl_get_feature_ioaddr_by_id(dev, PORT_FEATURE_ID_ERROR);
> +	base =3D dfl_get_feature_ioaddr_by_id(fdata,
> PORT_FEATURE_ID_ERROR);
>=20
> -	mutex_lock(&pdata->lock);
> +	mutex_lock(&fdata->lock);
>  	error =3D readq(base + PORT_ERROR);
> -	mutex_unlock(&pdata->lock);
> +	mutex_unlock(&fdata->lock);
>=20
>  	return sprintf(buf, "0x%llx\n", (unsigned long long)error);
>  }
> @@ -146,15 +145,15 @@ static DEVICE_ATTR_RW(errors);
>  static ssize_t first_error_show(struct device *dev,
>  				struct device_attribute *attr, char *buf)
>  {
> -	struct dfl_feature_platform_data *pdata =3D dev_get_platdata(dev);
> +	struct dfl_feature_dev_data *fdata =3D to_dfl_feature_dev_data(dev);
>  	void __iomem *base;
>  	u64 error;
>=20
> -	base =3D dfl_get_feature_ioaddr_by_id(dev, PORT_FEATURE_ID_ERROR);
> +	base =3D dfl_get_feature_ioaddr_by_id(fdata,
> PORT_FEATURE_ID_ERROR);
>=20
> -	mutex_lock(&pdata->lock);
> +	mutex_lock(&fdata->lock);
>  	error =3D readq(base + PORT_FIRST_ERROR);
> -	mutex_unlock(&pdata->lock);
> +	mutex_unlock(&fdata->lock);
>=20
>  	return sprintf(buf, "0x%llx\n", (unsigned long long)error);
>  }
> @@ -164,16 +163,16 @@ static ssize_t first_malformed_req_show(struct
> device *dev,
>  					struct device_attribute *attr,
>  					char *buf)
>  {
> -	struct dfl_feature_platform_data *pdata =3D dev_get_platdata(dev);
> +	struct dfl_feature_dev_data *fdata =3D to_dfl_feature_dev_data(dev);
>  	void __iomem *base;
>  	u64 req0, req1;
>=20
> -	base =3D dfl_get_feature_ioaddr_by_id(dev, PORT_FEATURE_ID_ERROR);
> +	base =3D dfl_get_feature_ioaddr_by_id(fdata,
> PORT_FEATURE_ID_ERROR);
>=20
> -	mutex_lock(&pdata->lock);
> +	mutex_lock(&fdata->lock);
>  	req0 =3D readq(base + PORT_MALFORMED_REQ0);
>  	req1 =3D readq(base + PORT_MALFORMED_REQ1);
> -	mutex_unlock(&pdata->lock);
> +	mutex_unlock(&fdata->lock);
>=20
>  	return sprintf(buf, "0x%016llx%016llx\n",
>  		       (unsigned long long)req1, (unsigned long long)req0);
> @@ -191,12 +190,14 @@ static umode_t port_err_attrs_visible(struct kobjec=
t
> *kobj,
>  				      struct attribute *attr, int n)
>  {
>  	struct device *dev =3D kobj_to_dev(kobj);
> +	struct dfl_feature_dev_data *fdata;
>=20
> +	fdata =3D to_dfl_feature_dev_data(dev);
>  	/*
>  	 * sysfs entries are visible only if related private feature is
>  	 * enumerated.
>  	 */
> -	if (!dfl_get_feature_by_id(dev, PORT_FEATURE_ID_ERROR))
> +	if (!dfl_get_feature_by_id(fdata, PORT_FEATURE_ID_ERROR))
>  		return 0;
>=20
>  	return attr->mode;
> diff --git a/drivers/fpga/dfl-afu-main.c b/drivers/fpga/dfl-afu-main.c
> index 7f621e96d3b8..eccbb407082d 100644
> --- a/drivers/fpga/dfl-afu-main.c
> +++ b/drivers/fpga/dfl-afu-main.c
> @@ -26,7 +26,7 @@
>=20
>  /**
>   * __afu_port_enable - enable a port by clear reset
> - * @pdev: port platform device.
> + * @fdata: port feature dev data.
>   *
>   * Enable Port by clear the port soft reset bit, which is set by default=
.
>   * The AFU is unable to respond to any MMIO access while in reset.
> @@ -35,18 +35,17 @@
>   *
>   * The caller needs to hold lock for protection.
>   */
> -int __afu_port_enable(struct platform_device *pdev)
> +int __afu_port_enable(struct dfl_feature_dev_data *fdata)
>  {
> -	struct dfl_feature_platform_data *pdata =3D dev_get_platdata(&pdev-
> >dev);
>  	void __iomem *base;
>  	u64 v;
>=20
> -	WARN_ON(!pdata->disable_count);
> +	WARN_ON(!fdata->disable_count);
>=20
> -	if (--pdata->disable_count !=3D 0)
> +	if (--fdata->disable_count !=3D 0)
>  		return 0;
>=20
> -	base =3D dfl_get_feature_ioaddr_by_id(&pdev->dev,
> PORT_FEATURE_ID_HEADER);
> +	base =3D dfl_get_feature_ioaddr_by_id(fdata,
> PORT_FEATURE_ID_HEADER);
>=20
>  	/* Clear port soft reset */
>  	v =3D readq(base + PORT_HDR_CTRL);
> @@ -60,7 +59,8 @@ int __afu_port_enable(struct platform_device *pdev)
>  	if (readq_poll_timeout(base + PORT_HDR_CTRL, v,
>  			       !(v & PORT_CTRL_SFTRST_ACK),
>  			       RST_POLL_INVL, RST_POLL_TIMEOUT)) {
> -		dev_err(&pdev->dev, "timeout, failure to enable device\n");
> +		dev_err(fdata->dfl_cdev->parent,
> +			"timeout, failure to enable device\n");
>  		return -ETIMEDOUT;
>  	}
>=20
> @@ -69,22 +69,21 @@ int __afu_port_enable(struct platform_device *pdev)
>=20
>  /**
>   * __afu_port_disable - disable a port by hold reset
> - * @pdev: port platform device.
> + * @fdata: port feature dev data.
>   *
>   * Disable Port by setting the port soft reset bit, it puts the port int=
o reset.
>   *
>   * The caller needs to hold lock for protection.
>   */
> -int __afu_port_disable(struct platform_device *pdev)
> +int __afu_port_disable(struct dfl_feature_dev_data *fdata)
>  {
> -	struct dfl_feature_platform_data *pdata =3D dev_get_platdata(&pdev-
> >dev);
>  	void __iomem *base;
>  	u64 v;
>=20
> -	if (pdata->disable_count++ !=3D 0)
> +	if (fdata->disable_count++ !=3D 0)
>  		return 0;
>=20
> -	base =3D dfl_get_feature_ioaddr_by_id(&pdev->dev,
> PORT_FEATURE_ID_HEADER);
> +	base =3D dfl_get_feature_ioaddr_by_id(fdata,
> PORT_FEATURE_ID_HEADER);
>=20
>  	/* Set port soft reset */
>  	v =3D readq(base + PORT_HDR_CTRL);
> @@ -99,7 +98,8 @@ int __afu_port_disable(struct platform_device *pdev)
>  	if (readq_poll_timeout(base + PORT_HDR_CTRL, v,
>  			       v & PORT_CTRL_SFTRST_ACK,
>  			       RST_POLL_INVL, RST_POLL_TIMEOUT)) {
> -		dev_err(&pdev->dev, "timeout, failure to disable device\n");
> +		dev_err(fdata->dfl_cdev->parent,
> +			"timeout, failure to disable device\n");
>  		return -ETIMEDOUT;
>  	}
>=20
> @@ -118,34 +118,36 @@ int __afu_port_disable(struct platform_device *pdev=
)
>   * (disabled). Any attempts on MMIO access to AFU while in reset, will
>   * result errors reported via port error reporting sub feature (if prese=
nt).
>   */
> -static int __port_reset(struct platform_device *pdev)
> +static int __port_reset(struct dfl_feature_dev_data *fdata)
>  {
>  	int ret;
>=20
> -	ret =3D __afu_port_disable(pdev);
> +	ret =3D __afu_port_disable(fdata);
>  	if (ret)
>  		return ret;
>=20
> -	return __afu_port_enable(pdev);
> +	return __afu_port_enable(fdata);
>  }
>=20
>  static int port_reset(struct platform_device *pdev)
>  {
> -	struct dfl_feature_platform_data *pdata =3D dev_get_platdata(&pdev-
> >dev);
> +	struct dfl_feature_dev_data *fdata;
>  	int ret;
>=20
> -	mutex_lock(&pdata->lock);
> -	ret =3D __port_reset(pdev);
> -	mutex_unlock(&pdata->lock);
> +	fdata =3D to_dfl_feature_dev_data(&pdev->dev);
> +
> +	mutex_lock(&fdata->lock);
> +	ret =3D __port_reset(fdata);
> +	mutex_unlock(&fdata->lock);
>=20
>  	return ret;
>  }
>=20
> -static int port_get_id(struct platform_device *pdev)
> +static int port_get_id(struct dfl_feature_dev_data *fdata)
>  {
>  	void __iomem *base;
>=20
> -	base =3D dfl_get_feature_ioaddr_by_id(&pdev->dev,
> PORT_FEATURE_ID_HEADER);
> +	base =3D dfl_get_feature_ioaddr_by_id(fdata,
> PORT_FEATURE_ID_HEADER);
>=20
>  	return FIELD_GET(PORT_CAP_PORT_NUM, readq(base +
> PORT_HDR_CAP));
>  }
> @@ -153,7 +155,8 @@ static int port_get_id(struct platform_device *pdev)
>  static ssize_t
>  id_show(struct device *dev, struct device_attribute *attr, char *buf)
>  {
> -	int id =3D port_get_id(to_platform_device(dev));
> +	struct dfl_feature_dev_data *fdata =3D to_dfl_feature_dev_data(dev);
> +	int id =3D port_get_id(fdata);
>=20
>  	return scnprintf(buf, PAGE_SIZE, "%d\n", id);
>  }
> @@ -162,15 +165,15 @@ static DEVICE_ATTR_RO(id);
>  static ssize_t
>  ltr_show(struct device *dev, struct device_attribute *attr, char *buf)
>  {
> -	struct dfl_feature_platform_data *pdata =3D dev_get_platdata(dev);
> +	struct dfl_feature_dev_data *fdata =3D to_dfl_feature_dev_data(dev);
>  	void __iomem *base;
>  	u64 v;
>=20
> -	base =3D dfl_get_feature_ioaddr_by_id(dev, PORT_FEATURE_ID_HEADER);
> +	base =3D dfl_get_feature_ioaddr_by_id(fdata,
> PORT_FEATURE_ID_HEADER);
>=20
> -	mutex_lock(&pdata->lock);
> +	mutex_lock(&fdata->lock);
>  	v =3D readq(base + PORT_HDR_CTRL);
> -	mutex_unlock(&pdata->lock);
> +	mutex_unlock(&fdata->lock);
>=20
>  	return sprintf(buf, "%x\n", (u8)FIELD_GET(PORT_CTRL_LATENCY, v));
>  }
> @@ -179,7 +182,7 @@ static ssize_t
>  ltr_store(struct device *dev, struct device_attribute *attr,
>  	  const char *buf, size_t count)
>  {
> -	struct dfl_feature_platform_data *pdata =3D dev_get_platdata(dev);
> +	struct dfl_feature_dev_data *fdata =3D to_dfl_feature_dev_data(dev);
>  	void __iomem *base;
>  	bool ltr;
>  	u64 v;
> @@ -187,14 +190,14 @@ ltr_store(struct device *dev, struct device_attribu=
te
> *attr,
>  	if (kstrtobool(buf, &ltr))
>  		return -EINVAL;
>=20
> -	base =3D dfl_get_feature_ioaddr_by_id(dev, PORT_FEATURE_ID_HEADER);
> +	base =3D dfl_get_feature_ioaddr_by_id(fdata,
> PORT_FEATURE_ID_HEADER);
>=20
> -	mutex_lock(&pdata->lock);
> +	mutex_lock(&fdata->lock);
>  	v =3D readq(base + PORT_HDR_CTRL);
>  	v &=3D ~PORT_CTRL_LATENCY;
>  	v |=3D FIELD_PREP(PORT_CTRL_LATENCY, ltr ? 1 : 0);
>  	writeq(v, base + PORT_HDR_CTRL);
> -	mutex_unlock(&pdata->lock);
> +	mutex_unlock(&fdata->lock);
>=20
>  	return count;
>  }
> @@ -203,15 +206,15 @@ static DEVICE_ATTR_RW(ltr);
>  static ssize_t
>  ap1_event_show(struct device *dev, struct device_attribute *attr, char *=
buf)
>  {
> -	struct dfl_feature_platform_data *pdata =3D dev_get_platdata(dev);
> +	struct dfl_feature_dev_data *fdata =3D to_dfl_feature_dev_data(dev);
>  	void __iomem *base;
>  	u64 v;
>=20
> -	base =3D dfl_get_feature_ioaddr_by_id(dev, PORT_FEATURE_ID_HEADER);
> +	base =3D dfl_get_feature_ioaddr_by_id(fdata,
> PORT_FEATURE_ID_HEADER);
>=20
> -	mutex_lock(&pdata->lock);
> +	mutex_lock(&fdata->lock);
>  	v =3D readq(base + PORT_HDR_STS);
> -	mutex_unlock(&pdata->lock);
> +	mutex_unlock(&fdata->lock);
>=20
>  	return sprintf(buf, "%x\n", (u8)FIELD_GET(PORT_STS_AP1_EVT, v));
>  }
> @@ -220,18 +223,18 @@ static ssize_t
>  ap1_event_store(struct device *dev, struct device_attribute *attr,
>  		const char *buf, size_t count)
>  {
> -	struct dfl_feature_platform_data *pdata =3D dev_get_platdata(dev);
> +	struct dfl_feature_dev_data *fdata =3D to_dfl_feature_dev_data(dev);
>  	void __iomem *base;
>  	bool clear;
>=20
>  	if (kstrtobool(buf, &clear) || !clear)
>  		return -EINVAL;
>=20
> -	base =3D dfl_get_feature_ioaddr_by_id(dev, PORT_FEATURE_ID_HEADER);
> +	base =3D dfl_get_feature_ioaddr_by_id(fdata,
> PORT_FEATURE_ID_HEADER);
>=20
> -	mutex_lock(&pdata->lock);
> +	mutex_lock(&fdata->lock);
>  	writeq(PORT_STS_AP1_EVT, base + PORT_HDR_STS);
> -	mutex_unlock(&pdata->lock);
> +	mutex_unlock(&fdata->lock);
>=20
>  	return count;
>  }
> @@ -241,15 +244,15 @@ static ssize_t
>  ap2_event_show(struct device *dev, struct device_attribute *attr,
>  	       char *buf)
>  {
> -	struct dfl_feature_platform_data *pdata =3D dev_get_platdata(dev);
> +	struct dfl_feature_dev_data *fdata =3D to_dfl_feature_dev_data(dev);
>  	void __iomem *base;
>  	u64 v;
>=20
> -	base =3D dfl_get_feature_ioaddr_by_id(dev, PORT_FEATURE_ID_HEADER);
> +	base =3D dfl_get_feature_ioaddr_by_id(fdata,
> PORT_FEATURE_ID_HEADER);
>=20
> -	mutex_lock(&pdata->lock);
> +	mutex_lock(&fdata->lock);
>  	v =3D readq(base + PORT_HDR_STS);
> -	mutex_unlock(&pdata->lock);
> +	mutex_unlock(&fdata->lock);
>=20
>  	return sprintf(buf, "%x\n", (u8)FIELD_GET(PORT_STS_AP2_EVT, v));
>  }
> @@ -258,18 +261,18 @@ static ssize_t
>  ap2_event_store(struct device *dev, struct device_attribute *attr,
>  		const char *buf, size_t count)
>  {
> -	struct dfl_feature_platform_data *pdata =3D dev_get_platdata(dev);
> +	struct dfl_feature_dev_data *fdata =3D to_dfl_feature_dev_data(dev);
>  	void __iomem *base;
>  	bool clear;
>=20
>  	if (kstrtobool(buf, &clear) || !clear)
>  		return -EINVAL;
>=20
> -	base =3D dfl_get_feature_ioaddr_by_id(dev, PORT_FEATURE_ID_HEADER);
> +	base =3D dfl_get_feature_ioaddr_by_id(fdata,
> PORT_FEATURE_ID_HEADER);
>=20
> -	mutex_lock(&pdata->lock);
> +	mutex_lock(&fdata->lock);
>  	writeq(PORT_STS_AP2_EVT, base + PORT_HDR_STS);
> -	mutex_unlock(&pdata->lock);
> +	mutex_unlock(&fdata->lock);
>=20
>  	return count;
>  }
> @@ -278,15 +281,15 @@ static DEVICE_ATTR_RW(ap2_event);
>  static ssize_t
>  power_state_show(struct device *dev, struct device_attribute *attr, char=
 *buf)
>  {
> -	struct dfl_feature_platform_data *pdata =3D dev_get_platdata(dev);
> +	struct dfl_feature_dev_data *fdata =3D to_dfl_feature_dev_data(dev);
>  	void __iomem *base;
>  	u64 v;
>=20
> -	base =3D dfl_get_feature_ioaddr_by_id(dev, PORT_FEATURE_ID_HEADER);
> +	base =3D dfl_get_feature_ioaddr_by_id(fdata,
> PORT_FEATURE_ID_HEADER);
>=20
> -	mutex_lock(&pdata->lock);
> +	mutex_lock(&fdata->lock);
>  	v =3D readq(base + PORT_HDR_STS);
> -	mutex_unlock(&pdata->lock);
> +	mutex_unlock(&fdata->lock);
>=20
>  	return sprintf(buf, "0x%x\n", (u8)FIELD_GET(PORT_STS_PWR_STATE, v));
>  }
> @@ -296,18 +299,18 @@ static ssize_t
>  userclk_freqcmd_store(struct device *dev, struct device_attribute *attr,
>  		      const char *buf, size_t count)
>  {
> -	struct dfl_feature_platform_data *pdata =3D dev_get_platdata(dev);
> +	struct dfl_feature_dev_data *fdata =3D to_dfl_feature_dev_data(dev);
>  	u64 userclk_freq_cmd;
>  	void __iomem *base;
>=20
>  	if (kstrtou64(buf, 0, &userclk_freq_cmd))
>  		return -EINVAL;
>=20
> -	base =3D dfl_get_feature_ioaddr_by_id(dev, PORT_FEATURE_ID_HEADER);
> +	base =3D dfl_get_feature_ioaddr_by_id(fdata,
> PORT_FEATURE_ID_HEADER);
>=20
> -	mutex_lock(&pdata->lock);
> +	mutex_lock(&fdata->lock);
>  	writeq(userclk_freq_cmd, base + PORT_HDR_USRCLK_CMD0);
> -	mutex_unlock(&pdata->lock);
> +	mutex_unlock(&fdata->lock);
>=20
>  	return count;
>  }
> @@ -317,18 +320,18 @@ static ssize_t
>  userclk_freqcntrcmd_store(struct device *dev, struct device_attribute *a=
ttr,
>  			  const char *buf, size_t count)
>  {
> -	struct dfl_feature_platform_data *pdata =3D dev_get_platdata(dev);
> +	struct dfl_feature_dev_data *fdata =3D to_dfl_feature_dev_data(dev);
>  	u64 userclk_freqcntr_cmd;
>  	void __iomem *base;
>=20
>  	if (kstrtou64(buf, 0, &userclk_freqcntr_cmd))
>  		return -EINVAL;
>=20
> -	base =3D dfl_get_feature_ioaddr_by_id(dev, PORT_FEATURE_ID_HEADER);
> +	base =3D dfl_get_feature_ioaddr_by_id(fdata,
> PORT_FEATURE_ID_HEADER);
>=20
> -	mutex_lock(&pdata->lock);
> +	mutex_lock(&fdata->lock);
>  	writeq(userclk_freqcntr_cmd, base + PORT_HDR_USRCLK_CMD1);
> -	mutex_unlock(&pdata->lock);
> +	mutex_unlock(&fdata->lock);
>=20
>  	return count;
>  }
> @@ -338,15 +341,15 @@ static ssize_t
>  userclk_freqsts_show(struct device *dev, struct device_attribute *attr,
>  		     char *buf)
>  {
> -	struct dfl_feature_platform_data *pdata =3D dev_get_platdata(dev);
> +	struct dfl_feature_dev_data *fdata =3D to_dfl_feature_dev_data(dev);
>  	u64 userclk_freqsts;
>  	void __iomem *base;
>=20
> -	base =3D dfl_get_feature_ioaddr_by_id(dev, PORT_FEATURE_ID_HEADER);
> +	base =3D dfl_get_feature_ioaddr_by_id(fdata,
> PORT_FEATURE_ID_HEADER);
>=20
> -	mutex_lock(&pdata->lock);
> +	mutex_lock(&fdata->lock);
>  	userclk_freqsts =3D readq(base + PORT_HDR_USRCLK_STS0);
> -	mutex_unlock(&pdata->lock);
> +	mutex_unlock(&fdata->lock);
>=20
>  	return sprintf(buf, "0x%llx\n", (unsigned long long)userclk_freqsts);
>  }
> @@ -356,15 +359,15 @@ static ssize_t
>  userclk_freqcntrsts_show(struct device *dev, struct device_attribute *at=
tr,
>  			 char *buf)
>  {
> -	struct dfl_feature_platform_data *pdata =3D dev_get_platdata(dev);
> +	struct dfl_feature_dev_data *fdata =3D to_dfl_feature_dev_data(dev);
>  	u64 userclk_freqcntrsts;
>  	void __iomem *base;
>=20
> -	base =3D dfl_get_feature_ioaddr_by_id(dev, PORT_FEATURE_ID_HEADER);
> +	base =3D dfl_get_feature_ioaddr_by_id(fdata,
> PORT_FEATURE_ID_HEADER);
>=20
> -	mutex_lock(&pdata->lock);
> +	mutex_lock(&fdata->lock);
>  	userclk_freqcntrsts =3D readq(base + PORT_HDR_USRCLK_STS1);
> -	mutex_unlock(&pdata->lock);
> +	mutex_unlock(&fdata->lock);
>=20
>  	return sprintf(buf, "0x%llx\n",
>  		       (unsigned long long)userclk_freqcntrsts);
> @@ -388,10 +391,12 @@ static umode_t port_hdr_attrs_visible(struct kobjec=
t
> *kobj,
>  				      struct attribute *attr, int n)
>  {
>  	struct device *dev =3D kobj_to_dev(kobj);
> +	struct dfl_feature_dev_data *fdata;
>  	umode_t mode =3D attr->mode;
>  	void __iomem *base;
>=20
> -	base =3D dfl_get_feature_ioaddr_by_id(dev, PORT_FEATURE_ID_HEADER);
> +	fdata =3D to_dfl_feature_dev_data(dev);
> +	base =3D dfl_get_feature_ioaddr_by_id(fdata,
> PORT_FEATURE_ID_HEADER);
>=20
>  	if (dfl_feature_revision(base) > 0) {
>  		/*
> @@ -456,21 +461,21 @@ static const struct dfl_feature_ops port_hdr_ops =
=3D {
>  static ssize_t
>  afu_id_show(struct device *dev, struct device_attribute *attr, char *buf=
)
>  {
> -	struct dfl_feature_platform_data *pdata =3D dev_get_platdata(dev);
> +	struct dfl_feature_dev_data *fdata =3D to_dfl_feature_dev_data(dev);
>  	void __iomem *base;
>  	u64 guidl, guidh;
>=20
> -	base =3D dfl_get_feature_ioaddr_by_id(dev, PORT_FEATURE_ID_AFU);
> +	base =3D dfl_get_feature_ioaddr_by_id(fdata, PORT_FEATURE_ID_AFU);
>=20
> -	mutex_lock(&pdata->lock);
> -	if (pdata->disable_count) {
> -		mutex_unlock(&pdata->lock);
> +	mutex_lock(&fdata->lock);
> +	if (fdata->disable_count) {
> +		mutex_unlock(&fdata->lock);
>  		return -EBUSY;
>  	}
>=20
>  	guidl =3D readq(base + GUID_L);
>  	guidh =3D readq(base + GUID_H);
> -	mutex_unlock(&pdata->lock);
> +	mutex_unlock(&fdata->lock);
>=20
>  	return scnprintf(buf, PAGE_SIZE, "%016llx%016llx\n", guidh, guidl);
>  }
> @@ -485,12 +490,15 @@ static umode_t port_afu_attrs_visible(struct kobjec=
t
> *kobj,
>  				      struct attribute *attr, int n)
>  {
>  	struct device *dev =3D kobj_to_dev(kobj);
> +	struct dfl_feature_dev_data *fdata;
> +
> +	fdata =3D to_dfl_feature_dev_data(dev);
>=20
>  	/*
>  	 * sysfs entries are visible only if related private feature is
>  	 * enumerated.
>  	 */
> -	if (!dfl_get_feature_by_id(dev, PORT_FEATURE_ID_AFU))
> +	if (!dfl_get_feature_by_id(fdata, PORT_FEATURE_ID_AFU))
>  		return 0;
>=20
>  	return attr->mode;
> @@ -504,9 +512,11 @@ static const struct attribute_group port_afu_group =
=3D {
>  static int port_afu_init(struct platform_device *pdev,
>  			 struct dfl_feature *feature)
>  {
> +	struct dfl_feature_dev_data *fdata =3D
> +					to_dfl_feature_dev_data(&pdev->dev);
>  	struct resource *res =3D &pdev->resource[feature->resource_index];
>=20
> -	return afu_mmio_region_add(dev_get_platdata(&pdev->dev),
> +	return afu_mmio_region_add(fdata,
>  				   DFL_PORT_REGION_INDEX_AFU,
>  				   resource_size(res), res->start,
>  				   DFL_PORT_REGION_MMAP |
> DFL_PORT_REGION_READ |
> @@ -525,9 +535,11 @@ static const struct dfl_feature_ops port_afu_ops =3D=
 {
>  static int port_stp_init(struct platform_device *pdev,
>  			 struct dfl_feature *feature)
>  {
> +	struct dfl_feature_dev_data *fdata =3D
> +					to_dfl_feature_dev_data(&pdev->dev);
>  	struct resource *res =3D &pdev->resource[feature->resource_index];
>=20
> -	return afu_mmio_region_add(dev_get_platdata(&pdev->dev),
> +	return afu_mmio_region_add(fdata,
>  				   DFL_PORT_REGION_INDEX_STP,
>  				   resource_size(res), res->start,
>  				   DFL_PORT_REGION_MMAP |
> DFL_PORT_REGION_READ |
> @@ -596,21 +608,19 @@ static struct dfl_feature_driver port_feature_drvs[=
] =3D
> {
>  static int afu_open(struct inode *inode, struct file *filp)
>  {
>  	struct platform_device *fdev =3D dfl_fpga_inode_to_feature_dev(inode);
> -	struct dfl_feature_platform_data *pdata;
> +	struct dfl_feature_dev_data *fdata;
>  	int ret;
>=20
> -	pdata =3D dev_get_platdata(&fdev->dev);
> -	if (WARN_ON(!pdata))
> -		return -ENODEV;
> +	fdata =3D to_dfl_feature_dev_data(&fdev->dev);
>=20
> -	mutex_lock(&pdata->lock);
> -	ret =3D dfl_feature_dev_use_begin(pdata, filp->f_flags & O_EXCL);
> +	mutex_lock(&fdata->lock);
> +	ret =3D dfl_feature_dev_use_begin(fdata, filp->f_flags & O_EXCL);
>  	if (!ret) {
>  		dev_dbg(&fdev->dev, "Device File Opened %d Times\n",
> -			dfl_feature_dev_use_count(pdata));
> +			dfl_feature_dev_use_count(fdata));
>  		filp->private_data =3D fdev;
>  	}
> -	mutex_unlock(&pdata->lock);
> +	mutex_unlock(&fdata->lock);
>=20
>  	return ret;
>  }
> @@ -618,24 +628,24 @@ static int afu_open(struct inode *inode, struct fil=
e
> *filp)
>  static int afu_release(struct inode *inode, struct file *filp)
>  {
>  	struct platform_device *pdev =3D filp->private_data;
> -	struct dfl_feature_platform_data *pdata;
> +	struct dfl_feature_dev_data *fdata;
>  	struct dfl_feature *feature;
>=20
>  	dev_dbg(&pdev->dev, "Device File Release\n");
>=20
> -	pdata =3D dev_get_platdata(&pdev->dev);
> +	fdata =3D to_dfl_feature_dev_data(&pdev->dev);
>=20
> -	mutex_lock(&pdata->lock);
> -	dfl_feature_dev_use_end(pdata);
> +	mutex_lock(&fdata->lock);
> +	dfl_feature_dev_use_end(fdata);
>=20
> -	if (!dfl_feature_dev_use_count(pdata)) {
> -		dfl_fpga_dev_for_each_feature(pdata, feature)
> +	if (!dfl_feature_dev_use_count(fdata)) {
> +		dfl_fpga_dev_for_each_feature(fdata, feature)
>  			dfl_fpga_set_irq_triggers(feature, 0,
>  						  feature->nr_irqs, NULL);
> -		__port_reset(pdev);
> -		afu_dma_region_destroy(pdata);
> +		__port_reset(fdata);
> +		afu_dma_region_destroy(fdata);
>  	}
> -	mutex_unlock(&pdata->lock);
> +	mutex_unlock(&fdata->lock);
>=20
>  	return 0;
>  }
> @@ -650,6 +660,7 @@ static long afu_ioctl_check_extension(struct
> dfl_feature_platform_data *pdata,
>  static long
>  afu_ioctl_get_info(struct dfl_feature_platform_data *pdata, void __user =
*arg)
>  {
> +	struct dfl_feature_dev_data *fdata =3D pdata->fdata;
>  	struct dfl_fpga_port_info info;
>  	struct dfl_afu *afu;
>  	unsigned long minsz;
> @@ -662,12 +673,12 @@ afu_ioctl_get_info(struct dfl_feature_platform_data
> *pdata, void __user *arg)
>  	if (info.argsz < minsz)
>  		return -EINVAL;
>=20
> -	mutex_lock(&pdata->lock);
> -	afu =3D dfl_fpga_pdata_get_private(pdata);
> +	mutex_lock(&fdata->lock);
> +	afu =3D dfl_fpga_fdata_get_private(fdata);
>  	info.flags =3D 0;
>  	info.num_regions =3D afu->num_regions;
>  	info.num_umsgs =3D afu->num_umsgs;
> -	mutex_unlock(&pdata->lock);
> +	mutex_unlock(&fdata->lock);
>=20
>  	if (copy_to_user(arg, &info, sizeof(info)))
>  		return -EFAULT;
> @@ -691,7 +702,7 @@ static long afu_ioctl_get_region_info(struct
> dfl_feature_platform_data *pdata,
>  	if (rinfo.argsz < minsz || rinfo.padding)
>  		return -EINVAL;
>=20
> -	ret =3D afu_mmio_region_get_by_index(pdata, rinfo.index, &region);
> +	ret =3D afu_mmio_region_get_by_index(pdata->fdata, rinfo.index,
> &region);
>  	if (ret)
>  		return ret;
>=20
> @@ -708,6 +719,7 @@ static long afu_ioctl_get_region_info(struct
> dfl_feature_platform_data *pdata,
>  static long
>  afu_ioctl_dma_map(struct dfl_feature_platform_data *pdata, void __user *=
arg)
>  {
> +	struct dfl_feature_dev_data *fdata =3D pdata->fdata;
>  	struct dfl_fpga_port_dma_map map;
>  	unsigned long minsz;
>  	long ret;
> @@ -720,16 +732,16 @@ afu_ioctl_dma_map(struct
> dfl_feature_platform_data *pdata, void __user *arg)
>  	if (map.argsz < minsz || map.flags)
>  		return -EINVAL;
>=20
> -	ret =3D afu_dma_map_region(pdata, map.user_addr, map.length,
> &map.iova);
> +	ret =3D afu_dma_map_region(fdata, map.user_addr, map.length,
> &map.iova);
>  	if (ret)
>  		return ret;
>=20
>  	if (copy_to_user(arg, &map, sizeof(map))) {
> -		afu_dma_unmap_region(pdata, map.iova);
> +		afu_dma_unmap_region(fdata, map.iova);
>  		return -EFAULT;
>  	}
>=20
> -	dev_dbg(&pdata->dev->dev, "dma map: ua=3D%llx, len=3D%llx, iova=3D%llx\=
n",
> +	dev_dbg(&fdata->dev->dev, "dma map: ua=3D%llx, len=3D%llx, iova=3D%llx\=
n",
>  		(unsigned long long)map.user_addr,
>  		(unsigned long long)map.length,
>  		(unsigned long long)map.iova);
> @@ -751,7 +763,7 @@ afu_ioctl_dma_unmap(struct
> dfl_feature_platform_data *pdata, void __user *arg)
>  	if (unmap.argsz < minsz || unmap.flags)
>  		return -EINVAL;
>=20
> -	return afu_dma_unmap_region(pdata, unmap.iova);
> +	return afu_dma_unmap_region(pdata->fdata, unmap.iova);
>  }
>=20
>  static long afu_ioctl(struct file *filp, unsigned int cmd, unsigned long=
 arg)
> @@ -785,7 +797,7 @@ static long afu_ioctl(struct file *filp, unsigned int=
 cmd,
> unsigned long arg)
>  		 * handled in this sub feature, and returns 0 and other
>  		 * error code if cmd is handled.
>  		 */
> -		dfl_fpga_dev_for_each_feature(pdata, f)
> +		dfl_fpga_dev_for_each_feature(pdata->fdata, f)
>  			if (f->ops && f->ops->ioctl) {
>  				ret =3D f->ops->ioctl(pdev, f, cmd, arg);
>  				if (ret !=3D -ENODEV)
> @@ -817,7 +829,8 @@ static int afu_mmap(struct file *filp, struct
> vm_area_struct *vma)
>  	pdata =3D dev_get_platdata(&pdev->dev);
>=20
>  	offset =3D vma->vm_pgoff << PAGE_SHIFT;
> -	ret =3D afu_mmio_region_get_by_offset(pdata, offset, size, &region);
> +	ret =3D afu_mmio_region_get_by_offset(pdata->fdata, offset, size,
> +					    &region);
>  	if (ret)
>  		return ret;
>=20
> @@ -852,6 +865,7 @@ static const struct file_operations afu_fops =3D {
>  static int afu_dev_init(struct platform_device *pdev)
>  {
>  	struct dfl_feature_platform_data *pdata =3D dev_get_platdata(&pdev-
> >dev);
> +	struct dfl_feature_dev_data *fdata =3D pdata->fdata;
>  	struct dfl_afu *afu;
>=20
>  	afu =3D devm_kzalloc(&pdev->dev, sizeof(*afu), GFP_KERNEL);
> @@ -860,11 +874,11 @@ static int afu_dev_init(struct platform_device *pde=
v)
>=20
>  	afu->pdata =3D pdata;
>=20
> -	mutex_lock(&pdata->lock);
> -	dfl_fpga_pdata_set_private(pdata, afu);
> -	afu_mmio_region_init(pdata);
> -	afu_dma_region_init(pdata);
> -	mutex_unlock(&pdata->lock);
> +	mutex_lock(&fdata->lock);
> +	dfl_fpga_fdata_set_private(fdata, afu);
> +	afu_mmio_region_init(fdata);
> +	afu_dma_region_init(fdata);
> +	mutex_unlock(&fdata->lock);
>=20
>  	return 0;
>  }
> @@ -872,27 +886,27 @@ static int afu_dev_init(struct platform_device *pde=
v)
>  static int afu_dev_destroy(struct platform_device *pdev)
>  {
>  	struct dfl_feature_platform_data *pdata =3D dev_get_platdata(&pdev-
> >dev);
> +	struct dfl_feature_dev_data *fdata =3D pdata->fdata;
>=20
> -	mutex_lock(&pdata->lock);
> -	afu_mmio_region_destroy(pdata);
> -	afu_dma_region_destroy(pdata);
> -	dfl_fpga_pdata_set_private(pdata, NULL);
> -	mutex_unlock(&pdata->lock);
> +	mutex_lock(&fdata->lock);
> +	afu_mmio_region_destroy(fdata);
> +	afu_dma_region_destroy(fdata);
> +	dfl_fpga_fdata_set_private(fdata, NULL);
> +	mutex_unlock(&fdata->lock);
>=20
>  	return 0;
>  }
>=20
> -static int port_enable_set(struct platform_device *pdev, bool enable)
> +static int port_enable_set(struct dfl_feature_dev_data *fdata, bool enab=
le)
>  {
> -	struct dfl_feature_platform_data *pdata =3D dev_get_platdata(&pdev-
> >dev);
>  	int ret;
>=20
> -	mutex_lock(&pdata->lock);
> +	mutex_lock(&fdata->lock);
>  	if (enable)
> -		ret =3D __afu_port_enable(pdev);
> +		ret =3D __afu_port_enable(fdata);
>  	else
> -		ret =3D __afu_port_disable(pdev);
> -	mutex_unlock(&pdata->lock);
> +		ret =3D __afu_port_disable(fdata);
> +	mutex_unlock(&fdata->lock);
>=20
>  	return ret;
>  }
> diff --git a/drivers/fpga/dfl-afu-region.c b/drivers/fpga/dfl-afu-region.=
c
> index 0804b7a0c298..b11a5b21e666 100644
> --- a/drivers/fpga/dfl-afu-region.c
> +++ b/drivers/fpga/dfl-afu-region.c
> @@ -12,11 +12,11 @@
>=20
>  /**
>   * afu_mmio_region_init - init function for afu mmio region support
> - * @pdata: afu platform device's pdata.
> + * @fdata: afu feature dev data
>   */
> -void afu_mmio_region_init(struct dfl_feature_platform_data *pdata)
> +void afu_mmio_region_init(struct dfl_feature_dev_data *fdata)
>  {
> -	struct dfl_afu *afu =3D dfl_fpga_pdata_get_private(pdata);
> +	struct dfl_afu *afu =3D dfl_fpga_fdata_get_private(fdata);
>=20
>  	INIT_LIST_HEAD(&afu->regions);
>  }
> @@ -39,6 +39,7 @@ static struct dfl_afu_mmio_region
> *get_region_by_index(struct dfl_afu *afu,
>  /**
>   * afu_mmio_region_add - add a mmio region to given feature dev.
>   *
> + * @fdata: afu feature dev data
>   * @region_index: region index.
>   * @region_size: region size.
>   * @phys: region's physical address of this region.
> @@ -46,14 +47,15 @@ static struct dfl_afu_mmio_region
> *get_region_by_index(struct dfl_afu *afu,
>   *
>   * Return: 0 on success, negative error code otherwise.
>   */
> -int afu_mmio_region_add(struct dfl_feature_platform_data *pdata,
> +int afu_mmio_region_add(struct dfl_feature_dev_data *fdata,
>  			u32 region_index, u64 region_size, u64 phys, u32 flags)
>  {
> +	struct device *dev =3D &fdata->dev->dev;
>  	struct dfl_afu_mmio_region *region;
>  	struct dfl_afu *afu;
>  	int ret =3D 0;
>=20
> -	region =3D devm_kzalloc(&pdata->dev->dev, sizeof(*region),
> GFP_KERNEL);
> +	region =3D devm_kzalloc(dev, sizeof(*region), GFP_KERNEL);
>  	if (!region)
>  		return -ENOMEM;
>=20
> @@ -62,13 +64,13 @@ int afu_mmio_region_add(struct
> dfl_feature_platform_data *pdata,
>  	region->phys =3D phys;
>  	region->flags =3D flags;
>=20
> -	mutex_lock(&pdata->lock);
> +	mutex_lock(&fdata->lock);
>=20
> -	afu =3D dfl_fpga_pdata_get_private(pdata);
> +	afu =3D dfl_fpga_fdata_get_private(fdata);
>=20
>  	/* check if @index already exists */
>  	if (get_region_by_index(afu, region_index)) {
> -		mutex_unlock(&pdata->lock);
> +		mutex_unlock(&fdata->lock);
>  		ret =3D -EEXIST;
>  		goto exit;
>  	}
> @@ -79,37 +81,37 @@ int afu_mmio_region_add(struct
> dfl_feature_platform_data *pdata,
>=20
>  	afu->region_cur_offset +=3D region_size;
>  	afu->num_regions++;
> -	mutex_unlock(&pdata->lock);
> +	mutex_unlock(&fdata->lock);
>=20
>  	return 0;
>=20
>  exit:
> -	devm_kfree(&pdata->dev->dev, region);
> +	devm_kfree(dev, region);
>  	return ret;
>  }
>=20
>  /**
>   * afu_mmio_region_destroy - destroy all mmio regions under given featur=
e dev.
> - * @pdata: afu platform device's pdata.
> + * @fdata: afu feature dev data
>   */
> -void afu_mmio_region_destroy(struct dfl_feature_platform_data *pdata)
> +void afu_mmio_region_destroy(struct dfl_feature_dev_data *fdata)
>  {
> -	struct dfl_afu *afu =3D dfl_fpga_pdata_get_private(pdata);
> +	struct dfl_afu *afu =3D dfl_fpga_fdata_get_private(fdata);
>  	struct dfl_afu_mmio_region *tmp, *region;
>=20
>  	list_for_each_entry_safe(region, tmp, &afu->regions, node)
> -		devm_kfree(&pdata->dev->dev, region);
> +		devm_kfree(&fdata->dev->dev, region);
>  }
>=20
>  /**
>   * afu_mmio_region_get_by_index - find an afu region by index.
> - * @pdata: afu platform device's pdata.
> + * @fdata: afu feature dev data
>   * @region_index: region index.
>   * @pregion: ptr to region for result.
>   *
>   * Return: 0 on success, negative error code otherwise.
>   */
> -int afu_mmio_region_get_by_index(struct dfl_feature_platform_data *pdata=
,
> +int afu_mmio_region_get_by_index(struct dfl_feature_dev_data *fdata,
>  				 u32 region_index,
>  				 struct dfl_afu_mmio_region *pregion)
>  {
> @@ -117,8 +119,8 @@ int afu_mmio_region_get_by_index(struct
> dfl_feature_platform_data *pdata,
>  	struct dfl_afu *afu;
>  	int ret =3D 0;
>=20
> -	mutex_lock(&pdata->lock);
> -	afu =3D dfl_fpga_pdata_get_private(pdata);
> +	mutex_lock(&fdata->lock);
> +	afu =3D dfl_fpga_fdata_get_private(fdata);
>  	region =3D get_region_by_index(afu, region_index);
>  	if (!region) {
>  		ret =3D -EINVAL;
> @@ -126,14 +128,14 @@ int afu_mmio_region_get_by_index(struct
> dfl_feature_platform_data *pdata,
>  	}
>  	*pregion =3D *region;
>  exit:
> -	mutex_unlock(&pdata->lock);
> +	mutex_unlock(&fdata->lock);
>  	return ret;
>  }
>=20
>  /**
>   * afu_mmio_region_get_by_offset - find an afu mmio region by offset and=
 size
>   *
> - * @pdata: afu platform device's pdata.
> + * @fdata: afu feature dev data
>   * @offset: region offset from start of the device fd.
>   * @size: region size.
>   * @pregion: ptr to region for result.
> @@ -143,7 +145,7 @@ int afu_mmio_region_get_by_index(struct
> dfl_feature_platform_data *pdata,
>   *
>   * Return: 0 on success, negative error code otherwise.
>   */
> -int afu_mmio_region_get_by_offset(struct dfl_feature_platform_data *pdat=
a,
> +int afu_mmio_region_get_by_offset(struct dfl_feature_dev_data *fdata,
>  				  u64 offset, u64 size,
>  				  struct dfl_afu_mmio_region *pregion)
>  {
> @@ -151,8 +153,8 @@ int afu_mmio_region_get_by_offset(struct
> dfl_feature_platform_data *pdata,
>  	struct dfl_afu *afu;
>  	int ret =3D 0;
>=20
> -	mutex_lock(&pdata->lock);
> -	afu =3D dfl_fpga_pdata_get_private(pdata);
> +	mutex_lock(&fdata->lock);
> +	afu =3D dfl_fpga_fdata_get_private(fdata);
>  	for_each_region(region, afu)
>  		if (region->offset <=3D offset &&
>  		    region->offset + region->size >=3D offset + size) {
> @@ -161,6 +163,6 @@ int afu_mmio_region_get_by_offset(struct
> dfl_feature_platform_data *pdata,
>  		}
>  	ret =3D -EINVAL;
>  exit:
> -	mutex_unlock(&pdata->lock);
> +	mutex_unlock(&fdata->lock);
>  	return ret;
>  }
> diff --git a/drivers/fpga/dfl-afu.h b/drivers/fpga/dfl-afu.h
> index e5020e2b1f3d..a712cf6d6a04 100644
> --- a/drivers/fpga/dfl-afu.h
> +++ b/drivers/fpga/dfl-afu.h
> @@ -79,27 +79,27 @@ struct dfl_afu {
>  	struct dfl_feature_platform_data *pdata;
>  };
>=20
> -/* hold pdata->lock when call __afu_port_enable/disable */
> -int __afu_port_enable(struct platform_device *pdev);
> -int __afu_port_disable(struct platform_device *pdev);
> +/* hold fdata->lock when call __afu_port_enable/disable */
> +int __afu_port_enable(struct dfl_feature_dev_data *fdata);
> +int __afu_port_disable(struct dfl_feature_dev_data *fdata);
>=20
> -void afu_mmio_region_init(struct dfl_feature_platform_data *pdata);
> -int afu_mmio_region_add(struct dfl_feature_platform_data *pdata,
> +void afu_mmio_region_init(struct dfl_feature_dev_data *fdata);
> +int afu_mmio_region_add(struct dfl_feature_dev_data *fdata,
>  			u32 region_index, u64 region_size, u64 phys, u32 flags);
> -void afu_mmio_region_destroy(struct dfl_feature_platform_data *pdata);
> -int afu_mmio_region_get_by_index(struct dfl_feature_platform_data *pdata=
,
> +void afu_mmio_region_destroy(struct dfl_feature_dev_data *fdata);
> +int afu_mmio_region_get_by_index(struct dfl_feature_dev_data *fdata,
>  				 u32 region_index,
>  				 struct dfl_afu_mmio_region *pregion);
> -int afu_mmio_region_get_by_offset(struct dfl_feature_platform_data *pdat=
a,
> +int afu_mmio_region_get_by_offset(struct dfl_feature_dev_data *fdata,
>  				  u64 offset, u64 size,
>  				  struct dfl_afu_mmio_region *pregion);
> -void afu_dma_region_init(struct dfl_feature_platform_data *pdata);
> -void afu_dma_region_destroy(struct dfl_feature_platform_data *pdata);
> -int afu_dma_map_region(struct dfl_feature_platform_data *pdata,
> +void afu_dma_region_init(struct dfl_feature_dev_data *fdata);
> +void afu_dma_region_destroy(struct dfl_feature_dev_data *fdata);
> +int afu_dma_map_region(struct dfl_feature_dev_data *fdata,
>  		       u64 user_addr, u64 length, u64 *iova);
> -int afu_dma_unmap_region(struct dfl_feature_platform_data *pdata, u64 io=
va);
> +int afu_dma_unmap_region(struct dfl_feature_dev_data *fdata, u64 iova);
>  struct dfl_afu_dma_region *
> -afu_dma_region_find(struct dfl_feature_platform_data *pdata,
> +afu_dma_region_find(struct dfl_feature_dev_data *fdata,
>  		    u64 iova, u64 size);
>=20
>  extern const struct dfl_feature_ops port_err_ops;
> diff --git a/drivers/fpga/dfl-fme-br.c b/drivers/fpga/dfl-fme-br.c
> index 808d1f4d76df..fed9bc903f7a 100644
> --- a/drivers/fpga/dfl-fme-br.c
> +++ b/drivers/fpga/dfl-fme-br.c
> @@ -22,34 +22,34 @@
>  struct fme_br_priv {
>  	struct dfl_fme_br_pdata *pdata;
>  	struct dfl_fpga_port_ops *port_ops;
> -	struct platform_device *port_pdev;
> +	struct dfl_feature_dev_data *port_fdata;
>  };
>=20
>  static int fme_bridge_enable_set(struct fpga_bridge *bridge, bool enable=
)
>  {
>  	struct fme_br_priv *priv =3D bridge->priv;
> -	struct platform_device *port_pdev;
> +	struct dfl_feature_dev_data *port_fdata;
>  	struct dfl_fpga_port_ops *ops;
>=20
> -	if (!priv->port_pdev) {
> -		port_pdev =3D dfl_fpga_cdev_find_port(priv->pdata->cdev,
> -						    &priv->pdata->port_id,
> -						    dfl_fpga_check_port_id);
> -		if (!port_pdev)
> +	if (!priv->port_fdata) {
> +		port_fdata =3D dfl_fpga_cdev_find_port_data(priv->pdata->cdev,
> +							  &priv->pdata-
> >port_id,
> +
> dfl_fpga_check_port_id);
> +		if (!port_fdata)
>  			return -ENODEV;
>=20
> -		priv->port_pdev =3D port_pdev;
> +		priv->port_fdata =3D port_fdata;
>  	}
>=20
> -	if (priv->port_pdev && !priv->port_ops) {
> -		ops =3D dfl_fpga_port_ops_get(priv->port_pdev);
> +	if (priv->port_fdata && !priv->port_ops) {
> +		ops =3D dfl_fpga_port_ops_get(priv->port_fdata);
>  		if (!ops || !ops->enable_set)
>  			return -ENOENT;
>=20
>  		priv->port_ops =3D ops;
>  	}
>=20
> -	return priv->port_ops->enable_set(priv->port_pdev, enable);
> +	return priv->port_ops->enable_set(priv->port_fdata, enable);
>  }
>=20
>  static const struct fpga_bridge_ops fme_bridge_ops =3D {
> @@ -85,8 +85,6 @@ static int fme_br_remove(struct platform_device *pdev)
>=20
>  	fpga_bridge_unregister(br);
>=20
> -	if (priv->port_pdev)
> -		put_device(&priv->port_pdev->dev);
>  	if (priv->port_ops)
>  		dfl_fpga_port_ops_put(priv->port_ops);
>=20
> diff --git a/drivers/fpga/dfl-fme-error.c b/drivers/fpga/dfl-fme-error.c
> index 51c2892ec06d..f00d949efe69 100644
> --- a/drivers/fpga/dfl-fme-error.c
> +++ b/drivers/fpga/dfl-fme-error.c
> @@ -42,15 +42,15 @@
>  static ssize_t pcie0_errors_show(struct device *dev,
>  				 struct device_attribute *attr, char *buf)
>  {
> -	struct dfl_feature_platform_data *pdata =3D dev_get_platdata(dev);
> +	struct dfl_feature_dev_data *fdata =3D to_dfl_feature_dev_data(dev);
>  	void __iomem *base;
>  	u64 value;
>=20
> -	base =3D dfl_get_feature_ioaddr_by_id(dev,
> FME_FEATURE_ID_GLOBAL_ERR);
> +	base =3D dfl_get_feature_ioaddr_by_id(fdata,
> FME_FEATURE_ID_GLOBAL_ERR);
>=20
> -	mutex_lock(&pdata->lock);
> +	mutex_lock(&fdata->lock);
>  	value =3D readq(base + PCIE0_ERROR);
> -	mutex_unlock(&pdata->lock);
> +	mutex_unlock(&fdata->lock);
>=20
>  	return sprintf(buf, "0x%llx\n", (unsigned long long)value);
>  }
> @@ -59,7 +59,7 @@ static ssize_t pcie0_errors_store(struct device *dev,
>  				  struct device_attribute *attr,
>  				  const char *buf, size_t count)
>  {
> -	struct dfl_feature_platform_data *pdata =3D dev_get_platdata(dev);
> +	struct dfl_feature_dev_data *fdata =3D to_dfl_feature_dev_data(dev);
>  	void __iomem *base;
>  	int ret =3D 0;
>  	u64 v, val;
> @@ -67,9 +67,9 @@ static ssize_t pcie0_errors_store(struct device *dev,
>  	if (kstrtou64(buf, 0, &val))
>  		return -EINVAL;
>=20
> -	base =3D dfl_get_feature_ioaddr_by_id(dev,
> FME_FEATURE_ID_GLOBAL_ERR);
> +	base =3D dfl_get_feature_ioaddr_by_id(fdata,
> FME_FEATURE_ID_GLOBAL_ERR);
>=20
> -	mutex_lock(&pdata->lock);
> +	mutex_lock(&fdata->lock);
>  	writeq(GENMASK_ULL(63, 0), base + PCIE0_ERROR_MASK);
>=20
>  	v =3D readq(base + PCIE0_ERROR);
> @@ -79,7 +79,7 @@ static ssize_t pcie0_errors_store(struct device *dev,
>  		ret =3D -EINVAL;
>=20
>  	writeq(0ULL, base + PCIE0_ERROR_MASK);
> -	mutex_unlock(&pdata->lock);
> +	mutex_unlock(&fdata->lock);
>  	return ret ? ret : count;
>  }
>  static DEVICE_ATTR_RW(pcie0_errors);
> @@ -87,15 +87,15 @@ static DEVICE_ATTR_RW(pcie0_errors);
>  static ssize_t pcie1_errors_show(struct device *dev,
>  				 struct device_attribute *attr, char *buf)
>  {
> -	struct dfl_feature_platform_data *pdata =3D dev_get_platdata(dev);
> +	struct dfl_feature_dev_data *fdata =3D to_dfl_feature_dev_data(dev);
>  	void __iomem *base;
>  	u64 value;
>=20
> -	base =3D dfl_get_feature_ioaddr_by_id(dev,
> FME_FEATURE_ID_GLOBAL_ERR);
> +	base =3D dfl_get_feature_ioaddr_by_id(fdata,
> FME_FEATURE_ID_GLOBAL_ERR);
>=20
> -	mutex_lock(&pdata->lock);
> +	mutex_lock(&fdata->lock);
>  	value =3D readq(base + PCIE1_ERROR);
> -	mutex_unlock(&pdata->lock);
> +	mutex_unlock(&fdata->lock);
>=20
>  	return sprintf(buf, "0x%llx\n", (unsigned long long)value);
>  }
> @@ -104,7 +104,7 @@ static ssize_t pcie1_errors_store(struct device *dev,
>  				  struct device_attribute *attr,
>  				  const char *buf, size_t count)
>  {
> -	struct dfl_feature_platform_data *pdata =3D dev_get_platdata(dev);
> +	struct dfl_feature_dev_data *fdata =3D to_dfl_feature_dev_data(dev);
>  	void __iomem *base;
>  	int ret =3D 0;
>  	u64 v, val;
> @@ -112,9 +112,9 @@ static ssize_t pcie1_errors_store(struct device *dev,
>  	if (kstrtou64(buf, 0, &val))
>  		return -EINVAL;
>=20
> -	base =3D dfl_get_feature_ioaddr_by_id(dev,
> FME_FEATURE_ID_GLOBAL_ERR);
> +	base =3D dfl_get_feature_ioaddr_by_id(fdata,
> FME_FEATURE_ID_GLOBAL_ERR);
>=20
> -	mutex_lock(&pdata->lock);
> +	mutex_lock(&fdata->lock);
>  	writeq(GENMASK_ULL(63, 0), base + PCIE1_ERROR_MASK);
>=20
>  	v =3D readq(base + PCIE1_ERROR);
> @@ -124,7 +124,7 @@ static ssize_t pcie1_errors_store(struct device *dev,
>  		ret =3D -EINVAL;
>=20
>  	writeq(0ULL, base + PCIE1_ERROR_MASK);
> -	mutex_unlock(&pdata->lock);
> +	mutex_unlock(&fdata->lock);
>  	return ret ? ret : count;
>  }
>  static DEVICE_ATTR_RW(pcie1_errors);
> @@ -132,9 +132,10 @@ static DEVICE_ATTR_RW(pcie1_errors);
>  static ssize_t nonfatal_errors_show(struct device *dev,
>  				    struct device_attribute *attr, char *buf)
>  {
> +	struct dfl_feature_dev_data *fdata =3D to_dfl_feature_dev_data(dev);
>  	void __iomem *base;
>=20
> -	base =3D dfl_get_feature_ioaddr_by_id(dev,
> FME_FEATURE_ID_GLOBAL_ERR);
> +	base =3D dfl_get_feature_ioaddr_by_id(fdata,
> FME_FEATURE_ID_GLOBAL_ERR);
>=20
>  	return sprintf(buf, "0x%llx\n",
>  		       (unsigned long long)readq(base + RAS_NONFAT_ERROR));
> @@ -144,9 +145,10 @@ static DEVICE_ATTR_RO(nonfatal_errors);
>  static ssize_t catfatal_errors_show(struct device *dev,
>  				    struct device_attribute *attr, char *buf)
>  {
> +	struct dfl_feature_dev_data *fdata =3D to_dfl_feature_dev_data(dev);
>  	void __iomem *base;
>=20
> -	base =3D dfl_get_feature_ioaddr_by_id(dev,
> FME_FEATURE_ID_GLOBAL_ERR);
> +	base =3D dfl_get_feature_ioaddr_by_id(fdata,
> FME_FEATURE_ID_GLOBAL_ERR);
>=20
>  	return sprintf(buf, "0x%llx\n",
>  		       (unsigned long long)readq(base + RAS_CATFAT_ERROR));
> @@ -156,15 +158,15 @@ static DEVICE_ATTR_RO(catfatal_errors);
>  static ssize_t inject_errors_show(struct device *dev,
>  				  struct device_attribute *attr, char *buf)
>  {
> -	struct dfl_feature_platform_data *pdata =3D dev_get_platdata(dev);
> +	struct dfl_feature_dev_data *fdata =3D to_dfl_feature_dev_data(dev);
>  	void __iomem *base;
>  	u64 v;
>=20
> -	base =3D dfl_get_feature_ioaddr_by_id(dev,
> FME_FEATURE_ID_GLOBAL_ERR);
> +	base =3D dfl_get_feature_ioaddr_by_id(fdata,
> FME_FEATURE_ID_GLOBAL_ERR);
>=20
> -	mutex_lock(&pdata->lock);
> +	mutex_lock(&fdata->lock);
>  	v =3D readq(base + RAS_ERROR_INJECT);
> -	mutex_unlock(&pdata->lock);
> +	mutex_unlock(&fdata->lock);
>=20
>  	return sprintf(buf, "0x%llx\n",
>  		       (unsigned long long)FIELD_GET(INJECT_ERROR_MASK, v));
> @@ -174,7 +176,7 @@ static ssize_t inject_errors_store(struct device *dev=
,
>  				   struct device_attribute *attr,
>  				   const char *buf, size_t count)
>  {
> -	struct dfl_feature_platform_data *pdata =3D dev_get_platdata(dev);
> +	struct dfl_feature_dev_data *fdata =3D to_dfl_feature_dev_data(dev);
>  	void __iomem *base;
>  	u8 inject_error;
>  	u64 v;
> @@ -185,14 +187,14 @@ static ssize_t inject_errors_store(struct device *d=
ev,
>  	if (inject_error & ~INJECT_ERROR_MASK)
>  		return -EINVAL;
>=20
> -	base =3D dfl_get_feature_ioaddr_by_id(dev,
> FME_FEATURE_ID_GLOBAL_ERR);
> +	base =3D dfl_get_feature_ioaddr_by_id(fdata,
> FME_FEATURE_ID_GLOBAL_ERR);
>=20
> -	mutex_lock(&pdata->lock);
> +	mutex_lock(&fdata->lock);
>  	v =3D readq(base + RAS_ERROR_INJECT);
>  	v &=3D ~INJECT_ERROR_MASK;
>  	v |=3D FIELD_PREP(INJECT_ERROR_MASK, inject_error);
>  	writeq(v, base + RAS_ERROR_INJECT);
> -	mutex_unlock(&pdata->lock);
> +	mutex_unlock(&fdata->lock);
>=20
>  	return count;
>  }
> @@ -201,15 +203,15 @@ static DEVICE_ATTR_RW(inject_errors);
>  static ssize_t fme_errors_show(struct device *dev,
>  			       struct device_attribute *attr, char *buf)
>  {
> -	struct dfl_feature_platform_data *pdata =3D dev_get_platdata(dev);
> +	struct dfl_feature_dev_data *fdata =3D to_dfl_feature_dev_data(dev);
>  	void __iomem *base;
>  	u64 value;
>=20
> -	base =3D dfl_get_feature_ioaddr_by_id(dev,
> FME_FEATURE_ID_GLOBAL_ERR);
> +	base =3D dfl_get_feature_ioaddr_by_id(fdata,
> FME_FEATURE_ID_GLOBAL_ERR);
>=20
> -	mutex_lock(&pdata->lock);
> +	mutex_lock(&fdata->lock);
>  	value =3D readq(base + FME_ERROR);
> -	mutex_unlock(&pdata->lock);
> +	mutex_unlock(&fdata->lock);
>=20
>  	return sprintf(buf, "0x%llx\n", (unsigned long long)value);
>  }
> @@ -218,7 +220,7 @@ static ssize_t fme_errors_store(struct device *dev,
>  				struct device_attribute *attr,
>  				const char *buf, size_t count)
>  {
> -	struct dfl_feature_platform_data *pdata =3D dev_get_platdata(dev);
> +	struct dfl_feature_dev_data *fdata =3D to_dfl_feature_dev_data(dev);
>  	void __iomem *base;
>  	u64 v, val;
>  	int ret =3D 0;
> @@ -226,9 +228,9 @@ static ssize_t fme_errors_store(struct device *dev,
>  	if (kstrtou64(buf, 0, &val))
>  		return -EINVAL;
>=20
> -	base =3D dfl_get_feature_ioaddr_by_id(dev,
> FME_FEATURE_ID_GLOBAL_ERR);
> +	base =3D dfl_get_feature_ioaddr_by_id(fdata,
> FME_FEATURE_ID_GLOBAL_ERR);
>=20
> -	mutex_lock(&pdata->lock);
> +	mutex_lock(&fdata->lock);
>  	writeq(GENMASK_ULL(63, 0), base + FME_ERROR_MASK);
>=20
>  	v =3D readq(base + FME_ERROR);
> @@ -240,7 +242,7 @@ static ssize_t fme_errors_store(struct device *dev,
>  	/* Workaround: disable MBP_ERROR if feature revision is 0 */
>  	writeq(dfl_feature_revision(base) ? 0ULL : MBP_ERROR,
>  	       base + FME_ERROR_MASK);
> -	mutex_unlock(&pdata->lock);
> +	mutex_unlock(&fdata->lock);
>  	return ret ? ret : count;
>  }
>  static DEVICE_ATTR_RW(fme_errors);
> @@ -248,15 +250,15 @@ static DEVICE_ATTR_RW(fme_errors);
>  static ssize_t first_error_show(struct device *dev,
>  				struct device_attribute *attr, char *buf)
>  {
> -	struct dfl_feature_platform_data *pdata =3D dev_get_platdata(dev);
> +	struct dfl_feature_dev_data *fdata =3D to_dfl_feature_dev_data(dev);
>  	void __iomem *base;
>  	u64 value;
>=20
> -	base =3D dfl_get_feature_ioaddr_by_id(dev,
> FME_FEATURE_ID_GLOBAL_ERR);
> +	base =3D dfl_get_feature_ioaddr_by_id(fdata,
> FME_FEATURE_ID_GLOBAL_ERR);
>=20
> -	mutex_lock(&pdata->lock);
> +	mutex_lock(&fdata->lock);
>  	value =3D readq(base + FME_FIRST_ERROR);
> -	mutex_unlock(&pdata->lock);
> +	mutex_unlock(&fdata->lock);
>=20
>  	return sprintf(buf, "0x%llx\n", (unsigned long long)value);
>  }
> @@ -265,15 +267,15 @@ static DEVICE_ATTR_RO(first_error);
>  static ssize_t next_error_show(struct device *dev,
>  			       struct device_attribute *attr, char *buf)
>  {
> -	struct dfl_feature_platform_data *pdata =3D dev_get_platdata(dev);
> +	struct dfl_feature_dev_data *fdata =3D to_dfl_feature_dev_data(dev);
>  	void __iomem *base;
>  	u64 value;
>=20
> -	base =3D dfl_get_feature_ioaddr_by_id(dev,
> FME_FEATURE_ID_GLOBAL_ERR);
> +	base =3D dfl_get_feature_ioaddr_by_id(fdata,
> FME_FEATURE_ID_GLOBAL_ERR);
>=20
> -	mutex_lock(&pdata->lock);
> +	mutex_lock(&fdata->lock);
>  	value =3D readq(base + FME_NEXT_ERROR);
> -	mutex_unlock(&pdata->lock);
> +	mutex_unlock(&fdata->lock);
>=20
>  	return sprintf(buf, "0x%llx\n", (unsigned long long)value);
>  }
> @@ -295,12 +297,14 @@ static umode_t fme_global_err_attrs_visible(struct
> kobject *kobj,
>  					    struct attribute *attr, int n)
>  {
>  	struct device *dev =3D kobj_to_dev(kobj);
> +	struct dfl_feature_dev_data *fdata;
>=20
> +	fdata =3D to_dfl_feature_dev_data(dev);
>  	/*
>  	 * sysfs entries are visible only if related private feature is
>  	 * enumerated.
>  	 */
> -	if (!dfl_get_feature_by_id(dev, FME_FEATURE_ID_GLOBAL_ERR))
> +	if (!dfl_get_feature_by_id(fdata, FME_FEATURE_ID_GLOBAL_ERR))
>  		return 0;
>=20
>  	return attr->mode;
> @@ -314,12 +318,12 @@ const struct attribute_group fme_global_err_group =
=3D
> {
>=20
>  static void fme_err_mask(struct device *dev, bool mask)
>  {
> -	struct dfl_feature_platform_data *pdata =3D dev_get_platdata(dev);
> +	struct dfl_feature_dev_data *fdata =3D to_dfl_feature_dev_data(dev);
>  	void __iomem *base;
>=20
> -	base =3D dfl_get_feature_ioaddr_by_id(dev,
> FME_FEATURE_ID_GLOBAL_ERR);
> +	base =3D dfl_get_feature_ioaddr_by_id(fdata,
> FME_FEATURE_ID_GLOBAL_ERR);
>=20
> -	mutex_lock(&pdata->lock);
> +	mutex_lock(&fdata->lock);
>=20
>  	/* Workaround: keep MBP_ERROR always masked if revision is 0 */
>  	if (dfl_feature_revision(base))
> @@ -332,7 +336,7 @@ static void fme_err_mask(struct device *dev, bool mas=
k)
>  	writeq(mask ? ERROR_MASK : 0, base + RAS_NONFAT_ERROR_MASK);
>  	writeq(mask ? ERROR_MASK : 0, base + RAS_CATFAT_ERROR_MASK);
>=20
> -	mutex_unlock(&pdata->lock);
> +	mutex_unlock(&fdata->lock);
>  }
>=20
>  static int fme_global_err_init(struct platform_device *pdev,
> diff --git a/drivers/fpga/dfl-fme-main.c b/drivers/fpga/dfl-fme-main.c
> index 77ea04d4edbe..967c40debfdb 100644
> --- a/drivers/fpga/dfl-fme-main.c
> +++ b/drivers/fpga/dfl-fme-main.c
> @@ -27,10 +27,11 @@
>  static ssize_t ports_num_show(struct device *dev,
>  			      struct device_attribute *attr, char *buf)
>  {
> +	struct dfl_feature_dev_data *fdata =3D to_dfl_feature_dev_data(dev);
>  	void __iomem *base;
>  	u64 v;
>=20
> -	base =3D dfl_get_feature_ioaddr_by_id(dev, FME_FEATURE_ID_HEADER);
> +	base =3D dfl_get_feature_ioaddr_by_id(fdata,
> FME_FEATURE_ID_HEADER);
>=20
>  	v =3D readq(base + FME_HDR_CAP);
>=20
> @@ -46,10 +47,11 @@ static DEVICE_ATTR_RO(ports_num);
>  static ssize_t bitstream_id_show(struct device *dev,
>  				 struct device_attribute *attr, char *buf)
>  {
> +	struct dfl_feature_dev_data *fdata =3D to_dfl_feature_dev_data(dev);
>  	void __iomem *base;
>  	u64 v;
>=20
> -	base =3D dfl_get_feature_ioaddr_by_id(dev, FME_FEATURE_ID_HEADER);
> +	base =3D dfl_get_feature_ioaddr_by_id(fdata,
> FME_FEATURE_ID_HEADER);
>=20
>  	v =3D readq(base + FME_HDR_BITSTREAM_ID);
>=20
> @@ -64,10 +66,11 @@ static DEVICE_ATTR_RO(bitstream_id);
>  static ssize_t bitstream_metadata_show(struct device *dev,
>  				       struct device_attribute *attr, char *buf)
>  {
> +	struct dfl_feature_dev_data *fdata =3D to_dfl_feature_dev_data(dev);
>  	void __iomem *base;
>  	u64 v;
>=20
> -	base =3D dfl_get_feature_ioaddr_by_id(dev, FME_FEATURE_ID_HEADER);
> +	base =3D dfl_get_feature_ioaddr_by_id(fdata,
> FME_FEATURE_ID_HEADER);
>=20
>  	v =3D readq(base + FME_HDR_BITSTREAM_MD);
>=20
> @@ -78,10 +81,11 @@ static DEVICE_ATTR_RO(bitstream_metadata);
>  static ssize_t cache_size_show(struct device *dev,
>  			       struct device_attribute *attr, char *buf)
>  {
> +	struct dfl_feature_dev_data *fdata =3D to_dfl_feature_dev_data(dev);
>  	void __iomem *base;
>  	u64 v;
>=20
> -	base =3D dfl_get_feature_ioaddr_by_id(dev, FME_FEATURE_ID_HEADER);
> +	base =3D dfl_get_feature_ioaddr_by_id(fdata,
> FME_FEATURE_ID_HEADER);
>=20
>  	v =3D readq(base + FME_HDR_CAP);
>=20
> @@ -93,10 +97,11 @@ static DEVICE_ATTR_RO(cache_size);
>  static ssize_t fabric_version_show(struct device *dev,
>  				   struct device_attribute *attr, char *buf)
>  {
> +	struct dfl_feature_dev_data *fdata =3D to_dfl_feature_dev_data(dev);
>  	void __iomem *base;
>  	u64 v;
>=20
> -	base =3D dfl_get_feature_ioaddr_by_id(dev, FME_FEATURE_ID_HEADER);
> +	base =3D dfl_get_feature_ioaddr_by_id(fdata,
> FME_FEATURE_ID_HEADER);
>=20
>  	v =3D readq(base + FME_HDR_CAP);
>=20
> @@ -108,10 +113,11 @@ static DEVICE_ATTR_RO(fabric_version);
>  static ssize_t socket_id_show(struct device *dev,
>  			      struct device_attribute *attr, char *buf)
>  {
> +	struct dfl_feature_dev_data *fdata =3D to_dfl_feature_dev_data(dev);
>  	void __iomem *base;
>  	u64 v;
>=20
> -	base =3D dfl_get_feature_ioaddr_by_id(dev, FME_FEATURE_ID_HEADER);
> +	base =3D dfl_get_feature_ioaddr_by_id(fdata,
> FME_FEATURE_ID_HEADER);
>=20
>  	v =3D readq(base + FME_HDR_CAP);
>=20
> @@ -137,7 +143,7 @@ static const struct attribute_group fme_hdr_group =3D=
 {
>  static long fme_hdr_ioctl_release_port(struct dfl_feature_platform_data
> *pdata,
>  				       unsigned long arg)
>  {
> -	struct dfl_fpga_cdev *cdev =3D pdata->dfl_cdev;
> +	struct dfl_fpga_cdev *cdev =3D pdata->fdata->dfl_cdev;
>  	int port_id;
>=20
>  	if (get_user(port_id, (int __user *)arg))
> @@ -149,7 +155,7 @@ static long fme_hdr_ioctl_release_port(struct
> dfl_feature_platform_data *pdata,
>  static long fme_hdr_ioctl_assign_port(struct dfl_feature_platform_data *=
pdata,
>  				      unsigned long arg)
>  {
> -	struct dfl_fpga_cdev *cdev =3D pdata->dfl_cdev;
> +	struct dfl_fpga_cdev *cdev =3D pdata->fdata->dfl_cdev;
>  	int port_id;
>=20
>  	if (get_user(port_id, (int __user *)arg))
> @@ -410,14 +416,14 @@ static int power_hwmon_read(struct device *dev,
> enum hwmon_sensor_types type,
>  static int power_hwmon_write(struct device *dev, enum hwmon_sensor_types
> type,
>  			     u32 attr, int channel, long val)
>  {
> -	struct dfl_feature_platform_data *pdata =3D dev_get_platdata(dev-
> >parent);
> +	struct dfl_feature_dev_data *fdata =3D to_dfl_feature_dev_data(dev);
>  	struct dfl_feature *feature =3D dev_get_drvdata(dev);
>  	int ret =3D 0;
>  	u64 v;
>=20
>  	val =3D clamp_val(val / 1000000, 0, PWR_THRESHOLD_MAX);
>=20
> -	mutex_lock(&pdata->lock);
> +	mutex_lock(&fdata->lock);
>=20
>  	switch (attr) {
>  	case hwmon_power_max:
> @@ -437,7 +443,7 @@ static int power_hwmon_write(struct device *dev,
> enum hwmon_sensor_types type,
>  		break;
>  	}
>=20
> -	mutex_unlock(&pdata->lock);
> +	mutex_unlock(&fdata->lock);
>=20
>  	return ret;
>  }
> @@ -599,19 +605,21 @@ static int fme_open(struct inode *inode, struct fil=
e
> *filp)
>  {
>  	struct platform_device *fdev =3D dfl_fpga_inode_to_feature_dev(inode);
>  	struct dfl_feature_platform_data *pdata =3D dev_get_platdata(&fdev-
> >dev);
> +	struct dfl_feature_dev_data *fdata;
>  	int ret;
>=20
>  	if (WARN_ON(!pdata))
>  		return -ENODEV;
>=20
> -	mutex_lock(&pdata->lock);
> -	ret =3D dfl_feature_dev_use_begin(pdata, filp->f_flags & O_EXCL);
> +	fdata =3D pdata->fdata;
> +	mutex_lock(&fdata->lock);
> +	ret =3D dfl_feature_dev_use_begin(fdata, filp->f_flags & O_EXCL);
>  	if (!ret) {
>  		dev_dbg(&fdev->dev, "Device File Opened %d Times\n",
> -			dfl_feature_dev_use_count(pdata));
> +			dfl_feature_dev_use_count(fdata));
>  		filp->private_data =3D pdata;
>  	}
> -	mutex_unlock(&pdata->lock);
> +	mutex_unlock(&fdata->lock);
>=20
>  	return ret;
>  }
> @@ -619,19 +627,20 @@ static int fme_open(struct inode *inode, struct fil=
e
> *filp)
>  static int fme_release(struct inode *inode, struct file *filp)
>  {
>  	struct dfl_feature_platform_data *pdata =3D filp->private_data;
> -	struct platform_device *pdev =3D pdata->dev;
> +	struct dfl_feature_dev_data *fdata =3D pdata->fdata;
> +	struct platform_device *pdev =3D fdata->dev;
>  	struct dfl_feature *feature;
>=20
>  	dev_dbg(&pdev->dev, "Device File Release\n");
>=20
> -	mutex_lock(&pdata->lock);
> -	dfl_feature_dev_use_end(pdata);
> +	mutex_lock(&fdata->lock);
> +	dfl_feature_dev_use_end(fdata);
>=20
> -	if (!dfl_feature_dev_use_count(pdata))
> -		dfl_fpga_dev_for_each_feature(pdata, feature)
> +	if (!dfl_feature_dev_use_count(fdata))
> +		dfl_fpga_dev_for_each_feature(fdata, feature)
>  			dfl_fpga_set_irq_triggers(feature, 0,
>  						  feature->nr_irqs, NULL);
> -	mutex_unlock(&pdata->lock);
> +	mutex_unlock(&fdata->lock);
>=20
>  	return 0;
>  }
> @@ -639,7 +648,8 @@ static int fme_release(struct inode *inode, struct fi=
le
> *filp)
>  static long fme_ioctl(struct file *filp, unsigned int cmd, unsigned long=
 arg)
>  {
>  	struct dfl_feature_platform_data *pdata =3D filp->private_data;
> -	struct platform_device *pdev =3D pdata->dev;
> +	struct dfl_feature_dev_data *fdata =3D pdata->fdata;
> +	struct platform_device *pdev =3D fdata->dev;
>  	struct dfl_feature *f;
>  	long ret;
>=20
> @@ -657,7 +667,7 @@ static long fme_ioctl(struct file *filp, unsigned int=
 cmd,
> unsigned long arg)
>  		 * handled in this sub feature, and returns 0 or other
>  		 * error code if cmd is handled.
>  		 */
> -		dfl_fpga_dev_for_each_feature(pdata, f) {
> +		dfl_fpga_dev_for_each_feature(fdata, f) {
>  			if (f->ops && f->ops->ioctl) {
>  				ret =3D f->ops->ioctl(pdev, f, cmd, arg);
>  				if (ret !=3D -ENODEV)
> @@ -672,6 +682,7 @@ static long fme_ioctl(struct file *filp, unsigned int=
 cmd,
> unsigned long arg)
>  static int fme_dev_init(struct platform_device *pdev)
>  {
>  	struct dfl_feature_platform_data *pdata =3D dev_get_platdata(&pdev-
> >dev);
> +	struct dfl_feature_dev_data *fdata =3D pdata->fdata;
>  	struct dfl_fme *fme;
>=20
>  	fme =3D devm_kzalloc(&pdev->dev, sizeof(*fme), GFP_KERNEL);
> @@ -680,9 +691,9 @@ static int fme_dev_init(struct platform_device *pdev)
>=20
>  	fme->pdata =3D pdata;
>=20
> -	mutex_lock(&pdata->lock);
> -	dfl_fpga_pdata_set_private(pdata, fme);
> -	mutex_unlock(&pdata->lock);
> +	mutex_lock(&fdata->lock);
> +	dfl_fpga_fdata_set_private(fdata, fme);
> +	mutex_unlock(&fdata->lock);
>=20
>  	return 0;
>  }
> @@ -690,10 +701,11 @@ static int fme_dev_init(struct platform_device *pde=
v)
>  static void fme_dev_destroy(struct platform_device *pdev)
>  {
>  	struct dfl_feature_platform_data *pdata =3D dev_get_platdata(&pdev-
> >dev);
> +	struct dfl_feature_dev_data *fdata =3D pdata->fdata;
>=20
> -	mutex_lock(&pdata->lock);
> -	dfl_fpga_pdata_set_private(pdata, NULL);
> -	mutex_unlock(&pdata->lock);
> +	mutex_lock(&fdata->lock);
> +	dfl_fpga_fdata_set_private(fdata, NULL);
> +	mutex_unlock(&fdata->lock);
>  }
>=20
>  static const struct file_operations fme_fops =3D {
> diff --git a/drivers/fpga/dfl-fme-pr.c b/drivers/fpga/dfl-fme-pr.c
> index d61ce9a18879..1cfcb06cf0d1 100644
> --- a/drivers/fpga/dfl-fme-pr.c
> +++ b/drivers/fpga/dfl-fme-pr.c
> @@ -65,7 +65,7 @@ static struct fpga_region *dfl_fme_region_find(struct
> dfl_fme *fme, int port_id)
>=20
>  static int fme_pr(struct platform_device *pdev, unsigned long arg)
>  {
> -	struct dfl_feature_platform_data *pdata =3D dev_get_platdata(&pdev-
> >dev);
> +	struct dfl_feature_dev_data *fdata =3D to_dfl_feature_dev_data(&pdev-
> >dev);
>  	void __user *argp =3D (void __user *)arg;
>  	struct dfl_fpga_fme_port_pr port_pr;
>  	struct fpga_image_info *info;
> @@ -87,8 +87,7 @@ static int fme_pr(struct platform_device *pdev, unsigne=
d
> long arg)
>  		return -EINVAL;
>=20
>  	/* get fme header region */
> -	fme_hdr =3D dfl_get_feature_ioaddr_by_id(&pdev->dev,
> -					       FME_FEATURE_ID_HEADER);
> +	fme_hdr =3D dfl_get_feature_ioaddr_by_id(fdata,
> FME_FEATURE_ID_HEADER);
>=20
>  	/* check port id */
>  	v =3D readq(fme_hdr + FME_HDR_CAP);
> @@ -123,8 +122,8 @@ static int fme_pr(struct platform_device *pdev,
> unsigned long arg)
>=20
>  	info->flags |=3D FPGA_MGR_PARTIAL_RECONFIG;
>=20
> -	mutex_lock(&pdata->lock);
> -	fme =3D dfl_fpga_pdata_get_private(pdata);
> +	mutex_lock(&fdata->lock);
> +	fme =3D dfl_fpga_fdata_get_private(fdata);
>  	/* fme device has been unregistered. */
>  	if (!fme) {
>  		ret =3D -EINVAL;
> @@ -156,7 +155,7 @@ static int fme_pr(struct platform_device *pdev,
> unsigned long arg)
>=20
>  	put_device(&region->dev);
>  unlock_exit:
> -	mutex_unlock(&pdata->lock);
> +	mutex_unlock(&fdata->lock);
>  free_exit:
>  	vfree(buf);
>  	return ret;
> @@ -170,10 +169,10 @@ static int fme_pr(struct platform_device *pdev,
> unsigned long arg)
>   * Return: mgr platform device if successful, and error code otherwise.
>   */
>  static struct platform_device *
> -dfl_fme_create_mgr(struct dfl_feature_platform_data *pdata,
> +dfl_fme_create_mgr(struct dfl_feature_dev_data *fdata,
>  		   struct dfl_feature *feature)
>  {
> -	struct platform_device *mgr, *fme =3D pdata->dev;
> +	struct platform_device *mgr, *fme =3D fdata->dev;
>  	struct dfl_fme_mgr_pdata mgr_pdata;
>  	int ret =3D -ENOMEM;
>=20
> @@ -211,9 +210,9 @@ dfl_fme_create_mgr(struct dfl_feature_platform_data
> *pdata,
>   * dfl_fme_destroy_mgr - destroy fpga mgr platform device
>   * @pdata: fme platform device's pdata
>   */
> -static void dfl_fme_destroy_mgr(struct dfl_feature_platform_data *pdata)
> +static void dfl_fme_destroy_mgr(struct dfl_feature_dev_data *fdata)
>  {
> -	struct dfl_fme *priv =3D dfl_fpga_pdata_get_private(pdata);
> +	struct dfl_fme *priv =3D dfl_fpga_fdata_get_private(fdata);
>=20
>  	platform_device_unregister(priv->mgr);
>  }
> @@ -221,15 +220,15 @@ static void dfl_fme_destroy_mgr(struct
> dfl_feature_platform_data *pdata)
>  /**
>   * dfl_fme_create_bridge - create fme fpga bridge platform device as chi=
ld
>   *
> - * @pdata: fme platform device's pdata
> + * @fdata: fme feature dev data
>   * @port_id: port id for the bridge to be created.
>   *
>   * Return: bridge platform device if successful, and error code otherwis=
e.
>   */
>  static struct dfl_fme_bridge *
> -dfl_fme_create_bridge(struct dfl_feature_platform_data *pdata, int port_=
id)
> +dfl_fme_create_bridge(struct dfl_feature_dev_data *fdata, int port_id)
>  {
> -	struct device *dev =3D &pdata->dev->dev;
> +	struct device *dev =3D &fdata->dev->dev;
>  	struct dfl_fme_br_pdata br_pdata;
>  	struct dfl_fme_bridge *fme_br;
>  	int ret =3D -ENOMEM;
> @@ -238,7 +237,7 @@ dfl_fme_create_bridge(struct
> dfl_feature_platform_data *pdata, int port_id)
>  	if (!fme_br)
>  		return ERR_PTR(ret);
>=20
> -	br_pdata.cdev =3D pdata->dfl_cdev;
> +	br_pdata.cdev =3D fdata->dfl_cdev;
>  	br_pdata.port_id =3D port_id;
>=20
>  	fme_br->br =3D platform_device_alloc(DFL_FPGA_FME_BRIDGE,
> @@ -274,11 +273,11 @@ static void dfl_fme_destroy_bridge(struct
> dfl_fme_bridge *fme_br)
>=20
>  /**
>   * dfl_fme_destroy_bridge - destroy all fpga bridge platform device
> - * @pdata: fme platform device's pdata
> + * @fdata: fme feature dev data
>   */
> -static void dfl_fme_destroy_bridges(struct dfl_feature_platform_data *pd=
ata)
> +static void dfl_fme_destroy_bridges(struct dfl_feature_dev_data *fdata)
>  {
> -	struct dfl_fme *priv =3D dfl_fpga_pdata_get_private(pdata);
> +	struct dfl_fme *priv =3D dfl_fpga_fdata_get_private(fdata);
>  	struct dfl_fme_bridge *fbridge, *tmp;
>=20
>  	list_for_each_entry_safe(fbridge, tmp, &priv->bridge_list, node) {
> @@ -290,7 +289,7 @@ static void dfl_fme_destroy_bridges(struct
> dfl_feature_platform_data *pdata)
>  /**
>   * dfl_fme_create_region - create fpga region platform device as child
>   *
> - * @pdata: fme platform device's pdata
> + * @fdata: fme feature dev data
>   * @mgr: mgr platform device needed for region
>   * @br: br platform device needed for region
>   * @port_id: port id
> @@ -298,12 +297,12 @@ static void dfl_fme_destroy_bridges(struct
> dfl_feature_platform_data *pdata)
>   * Return: fme region if successful, and error code otherwise.
>   */
>  static struct dfl_fme_region *
> -dfl_fme_create_region(struct dfl_feature_platform_data *pdata,
> +dfl_fme_create_region(struct dfl_feature_dev_data *fdata,
>  		      struct platform_device *mgr,
>  		      struct platform_device *br, int port_id)
>  {
>  	struct dfl_fme_region_pdata region_pdata;
> -	struct device *dev =3D &pdata->dev->dev;
> +	struct device *dev =3D &fdata->dev->dev;
>  	struct dfl_fme_region *fme_region;
>  	int ret =3D -ENOMEM;
>=20
> @@ -353,11 +352,11 @@ static void dfl_fme_destroy_region(struct
> dfl_fme_region *fme_region)
>=20
>  /**
>   * dfl_fme_destroy_regions - destroy all fme regions
> - * @pdata: fme platform device's pdata
> + * @fdata: fme feature dev data
>   */
> -static void dfl_fme_destroy_regions(struct dfl_feature_platform_data *pd=
ata)
> +static void dfl_fme_destroy_regions(struct dfl_feature_dev_data *fdata)
>  {
> -	struct dfl_fme *priv =3D dfl_fpga_pdata_get_private(pdata);
> +	struct dfl_fme *priv =3D dfl_fpga_fdata_get_private(fdata);
>  	struct dfl_fme_region *fme_region, *tmp;
>=20
>  	list_for_each_entry_safe(fme_region, tmp, &priv->region_list, node) {
> @@ -369,7 +368,8 @@ static void dfl_fme_destroy_regions(struct
> dfl_feature_platform_data *pdata)
>  static int pr_mgmt_init(struct platform_device *pdev,
>  			struct dfl_feature *feature)
>  {
> -	struct dfl_feature_platform_data *pdata =3D dev_get_platdata(&pdev-
> >dev);
> +	struct dfl_feature_dev_data *fdata =3D
> +			to_dfl_feature_dev_data(&pdev->dev);
>  	struct dfl_fme_region *fme_region;
>  	struct dfl_fme_bridge *fme_br;
>  	struct platform_device *mgr;
> @@ -378,18 +378,17 @@ static int pr_mgmt_init(struct platform_device *pde=
v,
>  	int ret =3D -ENODEV, i =3D 0;
>  	u64 fme_cap, port_offset;
>=20
> -	fme_hdr =3D dfl_get_feature_ioaddr_by_id(&pdev->dev,
> -					       FME_FEATURE_ID_HEADER);
> +	fme_hdr =3D dfl_get_feature_ioaddr_by_id(fdata,
> FME_FEATURE_ID_HEADER);
>=20
> -	mutex_lock(&pdata->lock);
> -	priv =3D dfl_fpga_pdata_get_private(pdata);
> +	mutex_lock(&fdata->lock);
> +	priv =3D dfl_fpga_fdata_get_private(fdata);
>=20
>  	/* Initialize the region and bridge sub device list */
>  	INIT_LIST_HEAD(&priv->region_list);
>  	INIT_LIST_HEAD(&priv->bridge_list);
>=20
>  	/* Create fpga mgr platform device */
> -	mgr =3D dfl_fme_create_mgr(pdata, feature);
> +	mgr =3D dfl_fme_create_mgr(fdata, feature);
>  	if (IS_ERR(mgr)) {
>  		dev_err(&pdev->dev, "fail to create fpga mgr pdev\n");
>  		goto unlock;
> @@ -405,7 +404,7 @@ static int pr_mgmt_init(struct platform_device *pdev,
>  			continue;
>=20
>  		/* Create bridge for each port */
> -		fme_br =3D dfl_fme_create_bridge(pdata, i);
> +		fme_br =3D dfl_fme_create_bridge(fdata, i);
>  		if (IS_ERR(fme_br)) {
>  			ret =3D PTR_ERR(fme_br);
>  			goto destroy_region;
> @@ -414,7 +413,7 @@ static int pr_mgmt_init(struct platform_device *pdev,
>  		list_add(&fme_br->node, &priv->bridge_list);
>=20
>  		/* Create region for each port */
> -		fme_region =3D dfl_fme_create_region(pdata, mgr,
> +		fme_region =3D dfl_fme_create_region(fdata, mgr,
>  						   fme_br->br, i);
>  		if (IS_ERR(fme_region)) {
>  			ret =3D PTR_ERR(fme_region);
> @@ -423,30 +422,31 @@ static int pr_mgmt_init(struct platform_device *pde=
v,
>=20
>  		list_add(&fme_region->node, &priv->region_list);
>  	}
> -	mutex_unlock(&pdata->lock);
> +	mutex_unlock(&fdata->lock);
>=20
>  	return 0;
>=20
>  destroy_region:
> -	dfl_fme_destroy_regions(pdata);
> -	dfl_fme_destroy_bridges(pdata);
> -	dfl_fme_destroy_mgr(pdata);
> +	dfl_fme_destroy_regions(fdata);
> +	dfl_fme_destroy_bridges(fdata);
> +	dfl_fme_destroy_mgr(fdata);
>  unlock:
> -	mutex_unlock(&pdata->lock);
> +	mutex_unlock(&fdata->lock);
>  	return ret;
>  }
>=20
>  static void pr_mgmt_uinit(struct platform_device *pdev,
>  			  struct dfl_feature *feature)
>  {
> -	struct dfl_feature_platform_data *pdata =3D dev_get_platdata(&pdev-
> >dev);
> +	struct dfl_feature_dev_data *fdata =3D
> +			to_dfl_feature_dev_data(&pdev->dev);
>=20
> -	mutex_lock(&pdata->lock);
> +	mutex_lock(&fdata->lock);
>=20
> -	dfl_fme_destroy_regions(pdata);
> -	dfl_fme_destroy_bridges(pdata);
> -	dfl_fme_destroy_mgr(pdata);
> -	mutex_unlock(&pdata->lock);
> +	dfl_fme_destroy_regions(fdata);
> +	dfl_fme_destroy_bridges(fdata);
> +	dfl_fme_destroy_mgr(fdata);
> +	mutex_unlock(&fdata->lock);
>  }
>=20
>  static long fme_pr_ioctl(struct platform_device *pdev,
> diff --git a/drivers/fpga/dfl.c b/drivers/fpga/dfl.c
> index 599bb21d86af..4f36152f4ab6 100644
> --- a/drivers/fpga/dfl.c
> +++ b/drivers/fpga/dfl.c
> @@ -118,17 +118,6 @@ static void dfl_id_free(enum dfl_id_type type, int i=
d)
>  	mutex_unlock(&dfl_id_mutex);
>  }
>=20
> -static enum dfl_id_type feature_dev_id_type(struct platform_device *pdev=
)
> -{
> -	int i;
> -
> -	for (i =3D 0; i < ARRAY_SIZE(dfl_devs); i++)
> -		if (!strcmp(dfl_devs[i].name, pdev->name))
> -			return i;
> -
> -	return DFL_ID_MAX;
> -}
> -
>  static enum dfl_id_type dfh_id_to_type(u16 id)
>  {
>  	int i;
> @@ -160,7 +149,8 @@ static LIST_HEAD(dfl_port_ops_list);
>   *
>   * Please note that must dfl_fpga_port_ops_put after use the port_ops.
>   */
> -struct dfl_fpga_port_ops *dfl_fpga_port_ops_get(struct platform_device
> *pdev)
> +struct dfl_fpga_port_ops *
> +dfl_fpga_port_ops_get(struct dfl_feature_dev_data *fdata)
>  {
>  	struct dfl_fpga_port_ops *ops =3D NULL;
>=20
> @@ -170,7 +160,7 @@ struct dfl_fpga_port_ops *dfl_fpga_port_ops_get(struc=
t
> platform_device *pdev)
>=20
>  	list_for_each_entry(ops, &dfl_port_ops_list, node) {
>  		/* match port_ops using the name of platform device */
> -		if (!strcmp(pdev->name, ops->name)) {
> +		if (!strcmp(fdata->pdev_name, ops->name)) {
>  			if (!try_module_get(ops->owner))
>  				ops =3D NULL;
>  			goto done;
> @@ -226,22 +216,21 @@ EXPORT_SYMBOL_GPL(dfl_fpga_port_ops_del);
>   *
>   * Return: 1 if port device matches with given port id, otherwise 0.
>   */
> -int dfl_fpga_check_port_id(struct platform_device *pdev, void *pport_id)
> +int dfl_fpga_check_port_id(struct dfl_feature_dev_data *fdata, void *ppo=
rt_id)
>  {
> -	struct dfl_feature_platform_data *pdata =3D dev_get_platdata(&pdev-
> >dev);
>  	struct dfl_fpga_port_ops *port_ops;
>=20
> -	if (pdata->id !=3D FEATURE_DEV_ID_UNUSED)
> -		return pdata->id =3D=3D *(int *)pport_id;
> +	if (fdata->id !=3D FEATURE_DEV_ID_UNUSED)
> +		return fdata->id =3D=3D *(int *)pport_id;
>=20
> -	port_ops =3D dfl_fpga_port_ops_get(pdev);
> +	port_ops =3D dfl_fpga_port_ops_get(fdata);
>  	if (!port_ops || !port_ops->get_id)
>  		return 0;
>=20
> -	pdata->id =3D port_ops->get_id(pdev);
> +	fdata->id =3D port_ops->get_id(fdata);
>  	dfl_fpga_port_ops_put(port_ops);
>=20
> -	return pdata->id =3D=3D *(int *)pport_id;
> +	return fdata->id =3D=3D *(int *)pport_id;
>  }
>  EXPORT_SYMBOL_GPL(dfl_fpga_check_port_id);
>=20
> @@ -348,10 +337,10 @@ static void release_dfl_dev(struct device *dev)
>  }
>=20
>  static struct dfl_device *
> -dfl_dev_add(struct dfl_feature_platform_data *pdata,
> +dfl_dev_add(struct dfl_feature_dev_data *fdata,
>  	    struct dfl_feature *feature)
>  {
> -	struct platform_device *pdev =3D pdata->dev;
> +	struct platform_device *pdev =3D fdata->dev;
>  	struct resource *parent_res;
>  	struct dfl_device *ddev;
>  	int id, i, ret;
> @@ -377,10 +366,10 @@ dfl_dev_add(struct dfl_feature_platform_data *pdata=
,
>  	if (ret)
>  		goto put_dev;
>=20
> -	ddev->type =3D feature_dev_id_type(pdev);
> +	ddev->type =3D fdata->type;
>  	ddev->feature_id =3D feature->id;
>  	ddev->revision =3D feature->revision;
> -	ddev->cdev =3D pdata->dfl_cdev;
> +	ddev->cdev =3D fdata->dfl_cdev;
>=20
>  	/* add mmio resource */
>  	parent_res =3D &pdev->resource[feature->resource_index];
> @@ -423,11 +412,11 @@ dfl_dev_add(struct dfl_feature_platform_data *pdata=
,
>  	return ERR_PTR(ret);
>  }
>=20
> -static void dfl_devs_remove(struct dfl_feature_platform_data *pdata)
> +static void dfl_devs_remove(struct dfl_feature_dev_data *fdata)
>  {
>  	struct dfl_feature *feature;
>=20
> -	dfl_fpga_dev_for_each_feature(pdata, feature) {
> +	dfl_fpga_dev_for_each_feature(fdata, feature) {
>  		if (feature->ddev) {
>  			device_unregister(&feature->ddev->dev);
>  			feature->ddev =3D NULL;
> @@ -435,13 +424,13 @@ static void dfl_devs_remove(struct
> dfl_feature_platform_data *pdata)
>  	}
>  }
>=20
> -static int dfl_devs_add(struct dfl_feature_platform_data *pdata)
> +static int dfl_devs_add(struct dfl_feature_dev_data *fdata)
>  {
>  	struct dfl_feature *feature;
>  	struct dfl_device *ddev;
>  	int ret;
>=20
> -	dfl_fpga_dev_for_each_feature(pdata, feature) {
> +	dfl_fpga_dev_for_each_feature(fdata, feature) {
>  		if (feature->ioaddr)
>  			continue;
>=20
> @@ -450,7 +439,7 @@ static int dfl_devs_add(struct
> dfl_feature_platform_data *pdata)
>  			goto err;
>  		}
>=20
> -		ddev =3D dfl_dev_add(pdata, feature);
> +		ddev =3D dfl_dev_add(fdata, feature);
>  		if (IS_ERR(ddev)) {
>  			ret =3D PTR_ERR(ddev);
>  			goto err;
> @@ -462,7 +451,7 @@ static int dfl_devs_add(struct
> dfl_feature_platform_data *pdata)
>  	return 0;
>=20
>  err:
> -	dfl_devs_remove(pdata);
> +	dfl_devs_remove(fdata);
>  	return ret;
>  }
>=20
> @@ -493,11 +482,12 @@ EXPORT_SYMBOL(dfl_driver_unregister);
>  void dfl_fpga_dev_feature_uinit(struct platform_device *pdev)
>  {
>  	struct dfl_feature_platform_data *pdata =3D dev_get_platdata(&pdev-
> >dev);
> +	struct dfl_feature_dev_data *fdata =3D pdata->fdata;
>  	struct dfl_feature *feature;
>=20
> -	dfl_devs_remove(pdata);
> +	dfl_devs_remove(fdata);
>=20
> -	dfl_fpga_dev_for_each_feature(pdata, feature) {
> +	dfl_fpga_dev_for_each_feature(fdata, feature) {
>  		if (feature->ops) {
>  			if (feature->ops->uinit)
>  				feature->ops->uinit(pdev, feature);
> @@ -568,12 +558,13 @@ int dfl_fpga_dev_feature_init(struct platform_devic=
e
> *pdev,
>  			      struct dfl_feature_driver *feature_drvs)
>  {
>  	struct dfl_feature_platform_data *pdata =3D dev_get_platdata(&pdev-
> >dev);
> +	struct dfl_feature_dev_data *fdata =3D pdata->fdata;
>  	struct dfl_feature_driver *drv =3D feature_drvs;
>  	struct dfl_feature *feature;
>  	int ret;
>=20
>  	while (drv->ops) {
> -		dfl_fpga_dev_for_each_feature(pdata, feature) {
> +		dfl_fpga_dev_for_each_feature(fdata, feature) {
>  			if (dfl_feature_drv_match(feature, drv)) {
>  				ret =3D dfl_feature_instance_init(pdev, pdata,
>  								feature, drv);
> @@ -584,7 +575,7 @@ int dfl_fpga_dev_feature_init(struct platform_device
> *pdev,
>  		drv++;
>  	}
>=20
> -	ret =3D dfl_devs_add(pdata);
> +	ret =3D dfl_devs_add(fdata);
>  	if (ret)
>  		goto exit;
>=20
> @@ -683,7 +674,7 @@ EXPORT_SYMBOL_GPL(dfl_fpga_dev_ops_unregister);
>   * @nr_irqs: number of irqs for all feature devices.
>   * @irq_table: Linux IRQ numbers for all irqs, indexed by local irq inde=
x of
>   *	       this device.
> - * @feature_dev: current feature device.
> + * @type: the current FIU type.
>   * @ioaddr: header register region address of current FIU in enumeration=
.
>   * @start: register resource start of current FIU.
>   * @len: max register resource length of current FIU.
> @@ -696,7 +687,7 @@ struct build_feature_devs_info {
>  	unsigned int nr_irqs;
>  	int *irq_table;
>=20
> -	struct platform_device *feature_dev;
> +	enum dfl_id_type type;
>  	void __iomem *ioaddr;
>  	resource_size_t start;
>  	resource_size_t len;
> @@ -724,50 +715,51 @@ struct dfl_feature_info {
>  	unsigned int nr_irqs;
>  };
>=20
> -static void dfl_fpga_cdev_add_port_dev(struct dfl_fpga_cdev *cdev,
> -				       struct platform_device *port)
> +static void dfl_fpga_cdev_add_port_data(struct dfl_fpga_cdev *cdev,
> +					struct dfl_feature_dev_data *fdata)
>  {
> -	struct dfl_feature_platform_data *pdata =3D dev_get_platdata(&port-
> >dev);
> -
>  	mutex_lock(&cdev->lock);
> -	list_add(&pdata->node, &cdev->port_dev_list);
> -	get_device(&pdata->dev->dev);
> +	list_add(&fdata->node, &cdev->port_dev_list);
>  	mutex_unlock(&cdev->lock);
>  }
>=20
> -/*
> - * register current feature device, it is called when we need to switch =
to
> - * another feature parsing or we have parsed all features on given devic=
e
> - * feature list.
> - */
> -static int build_info_commit_dev(struct build_feature_devs_info *binfo)
> +static struct dfl_feature_dev_data *
> +binfo_create_feature_dev_data(struct build_feature_devs_info *binfo)
>  {
> -	struct platform_device *fdev =3D binfo->feature_dev;
> -	struct dfl_feature_platform_data *pdata;
> +	enum dfl_id_type type =3D binfo->type;
>  	struct dfl_feature_info *finfo, *p;
> -	enum dfl_id_type type;
> +	struct dfl_feature_dev_data *fdata;
>  	int ret, index =3D 0, res_idx =3D 0;
>=20
> -	type =3D feature_dev_id_type(fdev);
>  	if (WARN_ON_ONCE(type >=3D DFL_ID_MAX))
> -		return -EINVAL;
> +		return ERR_PTR(-EINVAL);
>=20
> -	/*
> -	 * we do not need to care for the memory which is associated with
> -	 * the platform device. After calling platform_device_unregister(),
> -	 * it will be automatically freed by device's release() callback,
> -	 * platform_device_release().
> -	 */
> -	pdata =3D kzalloc(struct_size(pdata, features, binfo->feature_num),
> GFP_KERNEL);
> -	if (!pdata)
> -		return -ENOMEM;
> +	fdata =3D devm_kzalloc(binfo->dev, sizeof(*fdata), GFP_KERNEL);
> +	if (!fdata)
> +		return ERR_PTR(-ENOMEM);
> +
> +	fdata->features =3D devm_kcalloc(binfo->dev, binfo->feature_num,
> +				       sizeof(*fdata->features), GFP_KERNEL);
> +	if (!fdata->features)
> +		return ERR_PTR(-ENOMEM);
> +
> +	fdata->resources =3D devm_kcalloc(binfo->dev, binfo->feature_num,
> +					sizeof(*fdata->resources),
> GFP_KERNEL);
> +	if (!fdata->resources)
> +		return ERR_PTR(-ENOMEM);
> +
> +	fdata->type =3D type;
>=20
> -	pdata->dev =3D fdev;
> -	pdata->num =3D binfo->feature_num;
> -	pdata->dfl_cdev =3D binfo->cdev;
> -	pdata->id =3D FEATURE_DEV_ID_UNUSED;
> -	mutex_init(&pdata->lock);
> -	lockdep_set_class_and_name(&pdata->lock, &dfl_pdata_keys[type],
> +	fdata->pdev_id =3D dfl_id_alloc(type, binfo->dev);
> +	if (fdata->pdev_id < 0)
> +		return ERR_PTR(fdata->pdev_id);
> +
> +	fdata->pdev_name =3D dfl_devs[type].name;
> +	fdata->num =3D binfo->feature_num;
> +	fdata->dfl_cdev =3D binfo->cdev;
> +	fdata->id =3D FEATURE_DEV_ID_UNUSED;
> +	mutex_init(&fdata->lock);
> +	lockdep_set_class_and_name(&fdata->lock, &dfl_pdata_keys[type],
>  				   dfl_pdata_key_strings[type]);
>=20
>  	/*
> @@ -776,25 +768,15 @@ static int build_info_commit_dev(struct
> build_feature_devs_info *binfo)
>  	 * works properly for port device.
>  	 * and it should always be 0 for fme device.
>  	 */
> -	WARN_ON(pdata->disable_count);
> -
> -	fdev->dev.platform_data =3D pdata;
> -
> -	/* each sub feature has one MMIO resource */
> -	fdev->num_resources =3D binfo->feature_num;
> -	fdev->resource =3D kcalloc(binfo->feature_num, sizeof(*fdev->resource),
> -				 GFP_KERNEL);
> -	if (!fdev->resource)
> -		return -ENOMEM;
> +	WARN_ON(fdata->disable_count);
>=20
>  	/* fill features and resource information for feature dev */
>  	list_for_each_entry_safe(finfo, p, &binfo->sub_features, node) {
> -		struct dfl_feature *feature =3D &pdata->features[index++];
> +		struct dfl_feature *feature =3D &fdata->features[index++];
>  		struct dfl_feature_irq_ctx *ctx;
>  		unsigned int i;
>=20
>  		/* save resource information for each feature */
> -		feature->dev =3D fdev;
>  		feature->id =3D finfo->fid;
>  		feature->revision =3D finfo->revision;
>=20
> @@ -810,19 +792,22 @@ static int build_info_commit_dev(struct
> build_feature_devs_info *binfo)
>  			feature->ioaddr =3D
>  				devm_ioremap_resource(binfo->dev,
>  						      &finfo->mmio_res);
> -			if (IS_ERR(feature->ioaddr))
> -				return PTR_ERR(feature->ioaddr);
> +			if (IS_ERR(feature->ioaddr)) {
> +				ret =3D PTR_ERR(feature->ioaddr);
> +				goto err_free_id;
> +			}
>  		} else {
>  			feature->resource_index =3D res_idx;
> -			fdev->resource[res_idx++] =3D finfo->mmio_res;
> +			fdata->resources[res_idx++] =3D finfo->mmio_res;
>  		}
>=20
>  		if (finfo->nr_irqs) {
>  			ctx =3D devm_kcalloc(binfo->dev, finfo->nr_irqs,
>  					   sizeof(*ctx), GFP_KERNEL);
> -			if (!ctx)
> -				return -ENOMEM;
> -
> +			if (!ctx) {
> +				ret =3D -ENOMEM;
> +				goto err_free_id;
> +			}
>  			for (i =3D 0; i < finfo->nr_irqs; i++)
>  				ctx[i].irq =3D
>  					binfo->irq_table[finfo->irq_base + i];
> @@ -835,55 +820,90 @@ static int build_info_commit_dev(struct
> build_feature_devs_info *binfo)
>  		kfree(finfo);
>  	}
>=20
> -	ret =3D platform_device_add(binfo->feature_dev);
> -	if (!ret) {
> -		if (type =3D=3D PORT_ID)
> -			dfl_fpga_cdev_add_port_dev(binfo->cdev,
> -						   binfo->feature_dev);
> -		else
> -			binfo->cdev->fme_dev =3D
> -					get_device(&binfo->feature_dev->dev);
> -		/*
> -		 * reset it to avoid build_info_free() freeing their resource.
> -		 *
> -		 * The resource of successfully registered feature devices
> -		 * will be freed by platform_device_unregister(). See the
> -		 * comments in build_info_create_dev().
> -		 */
> -		binfo->feature_dev =3D NULL;
> -	}
> +	fdata->resource_num =3D res_idx;
>=20
> -	return ret;
> +	return fdata;
> +
> +err_free_id:
> +	dfl_id_free(type, fdata->pdev_id);
> +
> +	return ERR_PTR(ret);
>  }
>=20
> -static int
> -build_info_create_dev(struct build_feature_devs_info *binfo,
> -		      enum dfl_id_type type)
> +/*
> + * register current feature device, it is called when we need to switch =
to
> + * another feature parsing or we have parsed all features on given devic=
e
> + * feature list.
> + */
> +static int feature_dev_register(struct dfl_feature_dev_data *fdata)
>  {
> +	struct dfl_feature_platform_data pdata =3D { 0 };
>  	struct platform_device *fdev;
> +	struct dfl_feature *feature;
> +	int ret;
>=20
> -	if (type >=3D DFL_ID_MAX)
> -		return -EINVAL;
> -
> -	/*
> -	 * we use -ENODEV as the initialization indicator which indicates
> -	 * whether the id need to be reclaimed
> -	 */
> -	fdev =3D platform_device_alloc(dfl_devs[type].name, -ENODEV);
> +	fdev =3D platform_device_alloc(fdata->pdev_name, fdata->pdev_id);
>  	if (!fdev)
>  		return -ENOMEM;
>=20
> -	binfo->feature_dev =3D fdev;
> -	binfo->feature_num =3D 0;
> +	fdata->dev =3D fdev;
>=20
> -	INIT_LIST_HEAD(&binfo->sub_features);
> +	fdev->dev.parent =3D &fdata->dfl_cdev->region->dev;
> +	fdev->dev.devt =3D dfl_get_devt(dfl_devs[fdata->type].devt_type,
> +				      fdev->id);
> +
> +	dfl_fpga_dev_for_each_feature(fdata, feature)
> +		feature->dev =3D fdev;
>=20
> -	fdev->id =3D dfl_id_alloc(type, &fdev->dev);
> -	if (fdev->id < 0)
> -		return fdev->id;
> +	ret =3D platform_device_add_resources(fdev, fdata->resources,
> +					    fdata->resource_num);
> +	if (ret)
> +		goto err_put_dev;
> +
> +	pdata.fdata =3D fdata;
> +	ret =3D platform_device_add_data(fdev, &pdata, sizeof(pdata));
> +	if (ret)
> +		goto err_put_dev;
>=20
> -	fdev->dev.parent =3D &binfo->cdev->region->dev;
> -	fdev->dev.devt =3D dfl_get_devt(dfl_devs[type].devt_type, fdev->id);
> +	ret =3D platform_device_add(fdev);
> +	if (ret)
> +		goto err_put_dev;
> +
> +	return 0;
> +
> +err_put_dev:
> +	platform_device_put(fdev);
> +	fdata->dev =3D NULL;
> +
> +	return ret;
> +}
> +
> +static void feature_dev_unregister(struct dfl_feature_dev_data *fdata)
> +{
> +	platform_device_unregister(fdata->dev);
> +	fdata->dev =3D NULL;
> +}
> +
> +static int build_info_commit_dev(struct build_feature_devs_info *binfo)
> +{
> +	struct dfl_feature_dev_data *fdata;
> +	int ret;
> +
> +	fdata =3D binfo_create_feature_dev_data(binfo);
> +	if (IS_ERR(fdata))
> +		return PTR_ERR(fdata);
> +
> +	ret =3D feature_dev_register(fdata);
> +	if (ret)
> +		return ret;
> +
> +	if (binfo->type =3D=3D PORT_ID)
> +		dfl_fpga_cdev_add_port_data(binfo->cdev, fdata);
> +	else
> +		binfo->cdev->fme_dev =3D get_device(&fdata->dev->dev);

Should we have the same way to handle both port and fme?

> +
> +	/* reset the binfo for next FIU */
> +	binfo->type =3D DFL_ID_MAX;
>=20
>  	return 0;
>  }
> @@ -892,22 +912,11 @@ static void build_info_free(struct
> build_feature_devs_info *binfo)
>  {
>  	struct dfl_feature_info *finfo, *p;
>=20
> -	/*
> -	 * it is a valid id, free it. See comments in
> -	 * build_info_create_dev()
> -	 */
> -	if (binfo->feature_dev && binfo->feature_dev->id >=3D 0) {
> -		dfl_id_free(feature_dev_id_type(binfo->feature_dev),
> -			    binfo->feature_dev->id);
> -
> -		list_for_each_entry_safe(finfo, p, &binfo->sub_features, node)
> {
> -			list_del(&finfo->node);
> -			kfree(finfo);
> -		}
> +	list_for_each_entry_safe(finfo, p, &binfo->sub_features, node) {
> +		list_del(&finfo->node);
> +		kfree(finfo);
>  	}
>=20
> -	platform_device_put(binfo->feature_dev);
> -
>  	devm_kfree(binfo->dev, binfo);
>  }
>=20
> @@ -1068,7 +1077,7 @@ static int parse_feature_port_afu(struct
> build_feature_devs_info *binfo,
>  	return create_feature_instance(binfo, ofst, size, FEATURE_ID_AFU);
>  }
>=20
> -#define is_feature_dev_detected(binfo) (!!(binfo)->feature_dev)
> +#define is_feature_dev_detected(binfo) ((binfo)->type !=3D DFL_ID_MAX)
>=20
>  static int parse_feature_afu(struct build_feature_devs_info *binfo,
>  			     resource_size_t ofst)
> @@ -1078,12 +1087,11 @@ static int parse_feature_afu(struct
> build_feature_devs_info *binfo,
>  		return -EINVAL;
>  	}
>=20
> -	switch (feature_dev_id_type(binfo->feature_dev)) {
> +	switch (binfo->type) {
>  	case PORT_ID:
>  		return parse_feature_port_afu(binfo, ofst);
>  	default:
> -		dev_info(binfo->dev, "AFU belonging to FIU %s is not supported
> yet.\n",
> -			 binfo->feature_dev->name);
> +		dev_info(binfo->dev, "AFU belonging to FIU is not supported
> yet.\n");
>  	}
>=20
>  	return 0;
> @@ -1124,6 +1132,7 @@ static void build_info_complete(struct
> build_feature_devs_info *binfo)
>  static int parse_feature_fiu(struct build_feature_devs_info *binfo,
>  			     resource_size_t ofst)
>  {
> +	enum dfl_id_type type;
>  	int ret =3D 0;
>  	u32 offset;
>  	u16 id;
> @@ -1145,10 +1154,13 @@ static int parse_feature_fiu(struct
> build_feature_devs_info *binfo,
>  	v =3D readq(binfo->ioaddr + DFH);
>  	id =3D FIELD_GET(DFH_ID, v);
>=20
> -	/* create platform device for dfl feature dev */
> -	ret =3D build_info_create_dev(binfo, dfh_id_to_type(id));
> -	if (ret)
> -		return ret;
> +	type =3D dfh_id_to_type(id);
> +	if (type >=3D DFL_ID_MAX)
> +		return -EINVAL;
> +
> +	binfo->type =3D type;
> +	binfo->feature_num =3D 0;
> +	INIT_LIST_HEAD(&binfo->sub_features);
>=20
>  	ret =3D create_feature_instance(binfo, 0, 0, 0);
>  	if (ret)
> @@ -1366,13 +1378,10 @@
> EXPORT_SYMBOL_GPL(dfl_fpga_enum_info_add_irq);
>=20
>  static int remove_feature_dev(struct device *dev, void *data)
>  {
> -	struct platform_device *pdev =3D to_platform_device(dev);
> -	enum dfl_id_type type =3D feature_dev_id_type(pdev);
> -	int id =3D pdev->id;
> -
> -	platform_device_unregister(pdev);
> +	struct dfl_feature_dev_data *fdata =3D to_dfl_feature_dev_data(dev);
>=20
> -	dfl_id_free(type, id);
> +	feature_dev_unregister(fdata);
> +	dfl_id_free(fdata->type, fdata->pdev_id);
>=20
>  	return 0;
>  }
> @@ -1424,6 +1433,7 @@ dfl_fpga_feature_devs_enumerate(struct
> dfl_fpga_enum_info *info)
>  		goto unregister_region_exit;
>  	}
>=20
> +	binfo->type =3D DFL_ID_MAX;
>  	binfo->dev =3D info->dev;
>  	binfo->cdev =3D cdev;
>=20
> @@ -1465,25 +1475,10 @@
> EXPORT_SYMBOL_GPL(dfl_fpga_feature_devs_enumerate);
>   */
>  void dfl_fpga_feature_devs_remove(struct dfl_fpga_cdev *cdev)
>  {
> -	struct dfl_feature_platform_data *pdata, *ptmp;
> -
>  	mutex_lock(&cdev->lock);
>  	if (cdev->fme_dev)
>  		put_device(cdev->fme_dev);
>=20
> -	list_for_each_entry_safe(pdata, ptmp, &cdev->port_dev_list, node) {
> -		struct platform_device *port_dev =3D pdata->dev;
> -
> -		/* remove released ports */
> -		if (!device_is_registered(&port_dev->dev)) {
> -			dfl_id_free(feature_dev_id_type(port_dev),
> -				    port_dev->id);
> -			platform_device_put(port_dev);
> -		}
> -
> -		list_del(&pdata->node);
> -		put_device(&port_dev->dev);
> -	}
>  	mutex_unlock(&cdev->lock);
>=20
>  	remove_feature_devs(cdev);
> @@ -1507,23 +1502,21 @@
> EXPORT_SYMBOL_GPL(dfl_fpga_feature_devs_remove);
>   *
>   * NOTE: you will need to drop the device reference with put_device() af=
ter use.
>   */
> -struct platform_device *
> -__dfl_fpga_cdev_find_port(struct dfl_fpga_cdev *cdev, void *data,
> -			  int (*match)(struct platform_device *, void *))
> +struct dfl_feature_dev_data *
> +__dfl_fpga_cdev_find_port_data(struct dfl_fpga_cdev *cdev, void *data,
> +			       int (*match)(struct dfl_feature_dev_data *,
> +					    void *))
>  {
> -	struct dfl_feature_platform_data *pdata;
> -	struct platform_device *port_dev;
> -
> -	list_for_each_entry(pdata, &cdev->port_dev_list, node) {
> -		port_dev =3D pdata->dev;
> +	struct dfl_feature_dev_data *fdata;
>=20
> -		if (match(port_dev, data) && get_device(&port_dev->dev))
> -			return port_dev;
> +	list_for_each_entry(fdata, &cdev->port_dev_list, node) {
> +		if (match(fdata, data))
> +			return fdata;
>  	}
>=20
>  	return NULL;
>  }
> -EXPORT_SYMBOL_GPL(__dfl_fpga_cdev_find_port);
> +EXPORT_SYMBOL_GPL(__dfl_fpga_cdev_find_port_data);
>=20
>  static int __init dfl_fpga_init(void)
>  {
> @@ -1557,33 +1550,29 @@ static int __init dfl_fpga_init(void)
>   */
>  int dfl_fpga_cdev_release_port(struct dfl_fpga_cdev *cdev, int port_id)
>  {
> -	struct dfl_feature_platform_data *pdata;
> -	struct platform_device *port_pdev;
> +	struct dfl_feature_dev_data *fdata;
>  	int ret =3D -ENODEV;
>=20
>  	mutex_lock(&cdev->lock);
> -	port_pdev =3D __dfl_fpga_cdev_find_port(cdev, &port_id,
> -					      dfl_fpga_check_port_id);
> -	if (!port_pdev)
> +	fdata =3D __dfl_fpga_cdev_find_port_data(cdev, &port_id,
> +					       dfl_fpga_check_port_id);
> +	if (!fdata)
>  		goto unlock_exit;
>=20
> -	if (!device_is_registered(&port_pdev->dev)) {
> +	if (!fdata->dev) {
>  		ret =3D -EBUSY;
> -		goto put_dev_exit;
> +		goto unlock_exit;
>  	}
>=20
> -	pdata =3D dev_get_platdata(&port_pdev->dev);
> -
> -	mutex_lock(&pdata->lock);
> -	ret =3D dfl_feature_dev_use_begin(pdata, true);
> -	mutex_unlock(&pdata->lock);
> +	mutex_lock(&fdata->lock);
> +	ret =3D dfl_feature_dev_use_begin(fdata, true);
> +	mutex_unlock(&fdata->lock);
>  	if (ret)
> -		goto put_dev_exit;
> +		goto unlock_exit;
>=20
> -	platform_device_del(port_pdev);
> +	feature_dev_unregister(fdata);
>  	cdev->released_port_num++;
> -put_dev_exit:
> -	put_device(&port_pdev->dev);
> +
>  unlock_exit:
>  	mutex_unlock(&cdev->lock);
>  	return ret;
> @@ -1603,34 +1592,30 @@
> EXPORT_SYMBOL_GPL(dfl_fpga_cdev_release_port);
>   */
>  int dfl_fpga_cdev_assign_port(struct dfl_fpga_cdev *cdev, int port_id)
>  {
> -	struct dfl_feature_platform_data *pdata;
> -	struct platform_device *port_pdev;
> +	struct dfl_feature_dev_data *fdata;
>  	int ret =3D -ENODEV;
>=20
>  	mutex_lock(&cdev->lock);
> -	port_pdev =3D __dfl_fpga_cdev_find_port(cdev, &port_id,
> -					      dfl_fpga_check_port_id);
> -	if (!port_pdev)
> +	fdata =3D __dfl_fpga_cdev_find_port_data(cdev, &port_id,
> +					       dfl_fpga_check_port_id);
> +	if (!fdata)
>  		goto unlock_exit;
>=20
> -	if (device_is_registered(&port_pdev->dev)) {
> +	if (fdata->dev) {
>  		ret =3D -EBUSY;
> -		goto put_dev_exit;
> +		goto unlock_exit;
>  	}
>=20
> -	ret =3D platform_device_add(port_pdev);
> +	ret =3D feature_dev_register(fdata);
>  	if (ret)
> -		goto put_dev_exit;
> -
> -	pdata =3D dev_get_platdata(&port_pdev->dev);
> +		goto unlock_exit;
>=20
> -	mutex_lock(&pdata->lock);
> -	dfl_feature_dev_use_end(pdata);
> -	mutex_unlock(&pdata->lock);
> +	mutex_lock(&fdata->lock);
> +	dfl_feature_dev_use_end(fdata);
> +	mutex_unlock(&fdata->lock);
>=20
>  	cdev->released_port_num--;
> -put_dev_exit:
> -	put_device(&port_pdev->dev);
> +
>  unlock_exit:
>  	mutex_unlock(&cdev->lock);
>  	return ret;
> @@ -1640,10 +1625,11 @@ EXPORT_SYMBOL_GPL(dfl_fpga_cdev_assign_port);
>  static void config_port_access_mode(struct device *fme_dev, int port_id,
>  				    bool is_vf)
>  {
> +	struct dfl_feature_dev_data *fdata =3D
> to_dfl_feature_dev_data(fme_dev);
>  	void __iomem *base;
>  	u64 v;
>=20
> -	base =3D dfl_get_feature_ioaddr_by_id(fme_dev,
> FME_FEATURE_ID_HEADER);
> +	base =3D dfl_get_feature_ioaddr_by_id(fdata,
> FME_FEATURE_ID_HEADER);
>=20
>  	v =3D readq(base + FME_HDR_PORT_OFST(port_id));
>=20
> @@ -1667,14 +1653,14 @@ static void config_port_access_mode(struct device
> *fme_dev, int port_id,
>   */
>  void dfl_fpga_cdev_config_ports_pf(struct dfl_fpga_cdev *cdev)
>  {
> -	struct dfl_feature_platform_data *pdata;
> +	struct dfl_feature_dev_data *fdata;
>=20
>  	mutex_lock(&cdev->lock);
> -	list_for_each_entry(pdata, &cdev->port_dev_list, node) {
> -		if (device_is_registered(&pdata->dev->dev))
> +	list_for_each_entry(fdata, &cdev->port_dev_list, node) {
> +		if (fdata->dev)
>  			continue;
>=20
> -		config_port_pf_mode(cdev->fme_dev, pdata->id);
> +		config_port_pf_mode(cdev->fme_dev, fdata->id);
>  	}
>  	mutex_unlock(&cdev->lock);
>  }
> @@ -1693,7 +1679,7 @@
> EXPORT_SYMBOL_GPL(dfl_fpga_cdev_config_ports_pf);
>   */
>  int dfl_fpga_cdev_config_ports_vf(struct dfl_fpga_cdev *cdev, int num_vf=
s)
>  {
> -	struct dfl_feature_platform_data *pdata;
> +	struct dfl_feature_dev_data *fdata;
>  	int ret =3D 0;
>=20
>  	mutex_lock(&cdev->lock);
> @@ -1707,11 +1693,11 @@ int dfl_fpga_cdev_config_ports_vf(struct
> dfl_fpga_cdev *cdev, int num_vfs)
>  		goto done;
>  	}
>=20
> -	list_for_each_entry(pdata, &cdev->port_dev_list, node) {
> -		if (device_is_registered(&pdata->dev->dev))
> +	list_for_each_entry(fdata, &cdev->port_dev_list, node) {
> +		if (fdata->dev)
>  			continue;
>=20
> -		config_port_vf_mode(cdev->fme_dev, pdata->id);
> +		config_port_vf_mode(cdev->fme_dev, fdata->id);
>  	}
>  done:
>  	mutex_unlock(&cdev->lock);
> @@ -1845,6 +1831,7 @@ long dfl_feature_ioctl_set_irq(struct platform_devi=
ce
> *pdev,
>  			       unsigned long arg)
>  {
>  	struct dfl_feature_platform_data *pdata =3D dev_get_platdata(&pdev-
> >dev);
> +	struct dfl_feature_dev_data *fdata =3D pdata->fdata;
>  	struct dfl_fpga_irq_set hdr;
>  	s32 *fds;
>  	long ret;
> @@ -1864,9 +1851,9 @@ long dfl_feature_ioctl_set_irq(struct platform_devi=
ce
> *pdev,
>  	if (IS_ERR(fds))
>  		return PTR_ERR(fds);
>=20
> -	mutex_lock(&pdata->lock);
> +	mutex_lock(&fdata->lock);
>  	ret =3D dfl_fpga_set_irq_triggers(feature, hdr.start, hdr.count, fds);
> -	mutex_unlock(&pdata->lock);
> +	mutex_unlock(&fdata->lock);
>=20
>  	kfree(fds);
>  	return ret;
> diff --git a/drivers/fpga/dfl.h b/drivers/fpga/dfl.h
> index 53572c7aced0..f8ba28079fc3 100644
> --- a/drivers/fpga/dfl.h
> +++ b/drivers/fpga/dfl.h
> @@ -17,6 +17,7 @@
>  #include <linux/bitfield.h>
>  #include <linux/cdev.h>
>  #include <linux/delay.h>
> +#include <linux/dfl.h>
>  #include <linux/eventfd.h>
>  #include <linux/fs.h>
>  #include <linux/interrupt.h>
> @@ -169,6 +170,8 @@
>  #define PORT_UINT_CAP_INT_NUM	GENMASK_ULL(11, 0)	/* Interrupts
> num */
>  #define PORT_UINT_CAP_FST_VECT	GENMASK_ULL(23, 12)	/* First Vector
> */
>=20
> +struct dfl_feature_dev_data;
> +
>  /**
>   * struct dfl_fpga_port_ops - port ops
>   *
> @@ -182,15 +185,16 @@ struct dfl_fpga_port_ops {
>  	const char *name;
>  	struct module *owner;
>  	struct list_head node;
> -	int (*get_id)(struct platform_device *pdev);
> -	int (*enable_set)(struct platform_device *pdev, bool enable);
> +	int (*get_id)(struct dfl_feature_dev_data *fdata);
> +	int (*enable_set)(struct dfl_feature_dev_data *fdata, bool enable);
>  };
>=20
>  void dfl_fpga_port_ops_add(struct dfl_fpga_port_ops *ops);
>  void dfl_fpga_port_ops_del(struct dfl_fpga_port_ops *ops);
> -struct dfl_fpga_port_ops *dfl_fpga_port_ops_get(struct platform_device
> *pdev);
> +struct dfl_fpga_port_ops *
> +	dfl_fpga_port_ops_get(struct dfl_feature_dev_data *fdata);
>  void dfl_fpga_port_ops_put(struct dfl_fpga_port_ops *ops);
> -int dfl_fpga_check_port_id(struct platform_device *pdev, void *pport_id)=
;
> +int dfl_fpga_check_port_id(struct dfl_feature_dev_data *fdata, void *ppo=
rt_id);
>=20
>  /**
>   * struct dfl_feature_id - dfl private feature id
> @@ -256,26 +260,32 @@ struct dfl_feature {
>  #define FEATURE_DEV_ID_UNUSED	(-1)
>=20
>  /**
> - * struct dfl_feature_platform_data - platform data for feature devices
> + * struct dfl_feature_dev_data - dfl enumeration data for dfl feature de=
v.
>   *
> - * @node: node to link feature devs to container device's port_dev_list.
> - * @lock: mutex to protect platform data.
> - * @cdev: cdev of feature dev.
> - * @dev: ptr to platform device linked with this platform data.
> + * @node: node to link the data structure to container device's port_dev=
_list.
> + * @lock: mutex to protect feature dev data.
> + * @dev: ptr to the feature's platform device linked with this structure=
.
> + * @type: type of DFL FIU for the feature dev. See enum dfl_id_type.
> + * @pdev_id: platform device id for the feature dev.
> + * @pdev_name: platform device name for the feature dev.
>   * @dfl_cdev: ptr to container device.
> - * @id: id used for this feature device.
> + * @id: id used for the feature device.
>   * @disable_count: count for port disable.
>   * @excl_open: set on feature device exclusive open.
>   * @open_count: count for feature device open.
>   * @num: number for sub features.
>   * @private: ptr to feature dev private data.
> - * @features: sub features of this feature dev.
> + * @features: sub features for the feature dev.
> + * @resource_num: number of resources for the feature dev.
> + * @resources: resources for the feature dev.
>   */
> -struct dfl_feature_platform_data {
> +struct dfl_feature_dev_data {
>  	struct list_head node;
>  	struct mutex lock;
> -	struct cdev cdev;
>  	struct platform_device *dev;
> +	enum dfl_id_type type;
> +	int pdev_id;
> +	const char *pdev_name;
>  	struct dfl_fpga_cdev *dfl_cdev;
>  	int id;
>  	unsigned int disable_count;
> @@ -283,55 +293,68 @@ struct dfl_feature_platform_data {
>  	int open_count;
>  	void *private;
>  	int num;
> -	struct dfl_feature features[];
> +	struct dfl_feature *features;
> +	int resource_num;
> +	struct resource *resources;
> +};
> +
> +/**
> + * struct dfl_feature_platform_data - platform data for feature devices
> + *
> + * @fdata: dfl enumeration data for the dfl feature device.
> + * @cdev: cdev of feature dev.
> + */
> +struct dfl_feature_platform_data {
> +	struct dfl_feature_dev_data *fdata;
> +	struct cdev cdev;
>  };
>=20
>  static inline
> -int dfl_feature_dev_use_begin(struct dfl_feature_platform_data *pdata,
> +int dfl_feature_dev_use_begin(struct dfl_feature_dev_data *fdata,
>  			      bool excl)
>  {
> -	if (pdata->excl_open)
> +	if (fdata->excl_open)
>  		return -EBUSY;
>=20
>  	if (excl) {
> -		if (pdata->open_count)
> +		if (fdata->open_count)
>  			return -EBUSY;
>=20
> -		pdata->excl_open =3D true;
> +		fdata->excl_open =3D true;
>  	}
> -	pdata->open_count++;
> +	fdata->open_count++;
>=20
>  	return 0;
>  }
>=20
>  static inline
> -void dfl_feature_dev_use_end(struct dfl_feature_platform_data *pdata)
> +void dfl_feature_dev_use_end(struct dfl_feature_dev_data *fdata)
>  {
> -	pdata->excl_open =3D false;
> +	fdata->excl_open =3D false;
>=20
> -	if (WARN_ON(pdata->open_count <=3D 0))
> +	if (WARN_ON(fdata->open_count <=3D 0))
>  		return;
>=20
> -	pdata->open_count--;
> +	fdata->open_count--;
>  }
>=20
>  static inline
> -int dfl_feature_dev_use_count(struct dfl_feature_platform_data *pdata)
> +int dfl_feature_dev_use_count(struct dfl_feature_dev_data *fdata)
>  {
> -	return pdata->open_count;
> +	return fdata->open_count;
>  }
>=20
>  static inline
> -void dfl_fpga_pdata_set_private(struct dfl_feature_platform_data *pdata,
> +void dfl_fpga_fdata_set_private(struct dfl_feature_dev_data *fdata,
>  				void *private)
>  {
> -	pdata->private =3D private;
> +	fdata->private =3D private;
>  }
>=20
>  static inline
> -void *dfl_fpga_pdata_get_private(struct dfl_feature_platform_data *pdata=
)
> +void *dfl_fpga_fdata_get_private(struct dfl_feature_dev_data *fdata)
>  {
> -	return pdata->private;
> +	return fdata->private;
>  }
>=20
>  struct dfl_feature_ops {
> @@ -361,30 +384,29 @@ struct platform_device
> *dfl_fpga_inode_to_feature_dev(struct inode *inode)
>=20
>  	pdata =3D container_of(inode->i_cdev, struct dfl_feature_platform_data,
>  			     cdev);
> -	return pdata->dev;
> +	return pdata->fdata->dev;
>  }
>=20
> -#define dfl_fpga_dev_for_each_feature(pdata, feature)			    \
> -	for ((feature) =3D (pdata)->features;				    \
> -	   (feature) < (pdata)->features + (pdata)->num; (feature)++)
> +#define dfl_fpga_dev_for_each_feature(fdata, feature)			    \
> +	for ((feature) =3D (fdata)->features;				    \
> +	   (feature) < (fdata)->features + (fdata)->num; (feature)++)
>=20
> -static inline
> -struct dfl_feature *dfl_get_feature_by_id(struct device *dev, u16 id)
> +static inline struct dfl_feature *
> +dfl_get_feature_by_id(struct dfl_feature_dev_data *fdata, u16 id)
>  {
> -	struct dfl_feature_platform_data *pdata =3D dev_get_platdata(dev);
>  	struct dfl_feature *feature;
>=20
> -	dfl_fpga_dev_for_each_feature(pdata, feature)
> +	dfl_fpga_dev_for_each_feature(fdata, feature)
>  		if (feature->id =3D=3D id)
>  			return feature;
>=20
>  	return NULL;
>  }
>=20
> -static inline
> -void __iomem *dfl_get_feature_ioaddr_by_id(struct device *dev, u16 id)
> +static inline void __iomem *
> +dfl_get_feature_ioaddr_by_id(struct dfl_feature_dev_data *fdata, u16 id)
>  {
> -	struct dfl_feature *feature =3D dfl_get_feature_by_id(dev, id);
> +	struct dfl_feature *feature =3D dfl_get_feature_by_id(fdata, id);
>=20
>  	if (feature && feature->ioaddr)
>  		return feature->ioaddr;
> @@ -393,15 +415,18 @@ void __iomem *dfl_get_feature_ioaddr_by_id(struct
> device *dev, u16 id)
>  	return NULL;
>  }
>=20
> -static inline bool is_dfl_feature_present(struct device *dev, u16 id)
> +static inline struct dfl_feature_dev_data *
> +to_dfl_feature_dev_data(struct device *dev)
>  {
> -	return !!dfl_get_feature_ioaddr_by_id(dev, id);
> +	struct dfl_feature_platform_data *pdata =3D dev_get_platdata(dev);
> +
> +	return pdata->fdata;
>  }
>=20
>  static inline
> -struct device *dfl_fpga_pdata_to_parent(struct dfl_feature_platform_data
> *pdata)
> +struct device *dfl_fpga_fdata_to_parent(struct dfl_feature_dev_data *fda=
ta)
>  {
> -	return pdata->dev->dev.parent->parent;
> +	return fdata->dev->dev.parent->parent;
>  }
>=20
>  static inline bool dfl_feature_is_fme(void __iomem *base)
> @@ -483,26 +508,23 @@ struct dfl_fpga_cdev *
>  dfl_fpga_feature_devs_enumerate(struct dfl_fpga_enum_info *info);
>  void dfl_fpga_feature_devs_remove(struct dfl_fpga_cdev *cdev);
>=20
> -/*
> - * need to drop the device reference with put_device() after use port pl=
atform
> - * device returned by __dfl_fpga_cdev_find_port and dfl_fpga_cdev_find_p=
ort
> - * functions.
> - */
> -struct platform_device *
> -__dfl_fpga_cdev_find_port(struct dfl_fpga_cdev *cdev, void *data,
> -			  int (*match)(struct platform_device *, void *));
> +struct dfl_feature_dev_data *
> +__dfl_fpga_cdev_find_port_data(struct dfl_fpga_cdev *cdev, void *data,
> +			       int (*match)(struct dfl_feature_dev_data *,
> +					    void *));
>=20
> -static inline struct platform_device *
> -dfl_fpga_cdev_find_port(struct dfl_fpga_cdev *cdev, void *data,
> -			int (*match)(struct platform_device *, void *))
> +static inline struct dfl_feature_dev_data *
> +dfl_fpga_cdev_find_port_data(struct dfl_fpga_cdev *cdev, void *data,
> +			     int (*match)(struct dfl_feature_dev_data *,
> +					  void *))
>  {
> -	struct platform_device *pdev;
> +	struct dfl_feature_dev_data *fdata;
>=20
>  	mutex_lock(&cdev->lock);
> -	pdev =3D __dfl_fpga_cdev_find_port(cdev, data, match);
> +	fdata =3D __dfl_fpga_cdev_find_port_data(cdev, data, match);
>  	mutex_unlock(&cdev->lock);
>=20
> -	return pdev;
> +	return fdata;
>  }
>=20
>  int dfl_fpga_cdev_release_port(struct dfl_fpga_cdev *cdev, int port_id);
> --
> 2.25.1

