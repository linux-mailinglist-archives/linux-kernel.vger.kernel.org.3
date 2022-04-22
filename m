Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DEF050AE56
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 05:06:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443649AbiDVDIr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 23:08:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349869AbiDVDIp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 23:08:45 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1FB639164
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 20:05:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650596753; x=1682132753;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=l1wn49GwoxIFFvFwkNhWJqdxc34NTXHeSsUYWY63eT8=;
  b=aG1lyVjFMlWnoZ5Pj8ZFKwMyFFW0rsoQbnae/fCdvmRXKvlMGan79S8i
   x3BKooPCNC8CHjFtws2WlZm/MWAAl9p44VKIyylxQomhRkl8BsOZXCzvs
   1rkgBP/IcpAbeGRQ10HYg0riektzoqmQSIlmWZ1z/7zoP9YwwRF1Oui6B
   m/CqvApSmaXT7rKSiBsTUJG6ZjlwlsIgjWmciMHOC3s0on7wMxS952zHE
   COma9C2iRbBLKJpG8TjF0uaUSVa+76PXTHcuTAZv7IpFXY6UxGK0Thj2P
   R0vxEie30ba+7mWbY9jxiVjyNhmA+++lTuJZMFjYwq8Mp1isG9kwMnozC
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10324"; a="325001893"
X-IronPort-AV: E=Sophos;i="5.90,280,1643702400"; 
   d="scan'208";a="325001893"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Apr 2022 20:05:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,280,1643702400"; 
   d="scan'208";a="562859996"
Received: from orsmsx605.amr.corp.intel.com ([10.22.229.18])
  by fmsmga007.fm.intel.com with ESMTP; 21 Apr 2022 20:05:53 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX605.amr.corp.intel.com (10.22.229.18) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Thu, 21 Apr 2022 20:05:52 -0700
Received: from orsmsx606.amr.corp.intel.com (10.22.229.19) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Thu, 21 Apr 2022 20:05:52 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx606.amr.corp.intel.com (10.22.229.19) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Thu, 21 Apr 2022 20:05:52 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.172)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Thu, 21 Apr 2022 20:05:51 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DR5oaeojNcse3RdJnKZQvBJ76g58IXOSTedXC8myD5paKP8J0skBifOnXUE3d6fcq0xTRlHbDvO46Ti1SvMaHqGVTNn2aeVk5MWik3Gs3/vKFsQBJT59m5QLpN97y050MPQ4oW/nrv7trWp4AxVo3Z35CtyvBb0ptfkuivvoF+tuUZ+JemsEnBUuaXQ/gq3WGtkMkhkpSruWt9IYkr6a7CB230+Nsyi9qHRTVex4onZEgnZ6HqMJytWwU6OVk1on9/Nt1Z99fxBobvarDPauDoYbXlM8MKhQC6ywVB1yvI6IFn8dW4cz2mAiBWG7Zx9CLpAr9tAlDagT07uFt93hhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oDghYXKTMS3tMacLRAYHQpI9TNvU2FcX0aEgTZPUj1k=;
 b=lOvGgizvwryMhI4YUH7WaLor0brQwaA/CAmTWkv8xCTqMXOkk8ko4Sg7Q58fqAxcqwDFPfyTBSTbMm0nomRMMxHjJBxvZBcq0Q7jwMvsa2DKi7txH0fpdvcU0Hq78LDwLn/D5ZnlxfX6A3ftE2ySD0rBED3w0fS074csPqGzDc6xG8MgkQlN3HWl+vux2ZyJkvyHL6q9MkbeC6pqD4Y860Oj5Wr3pWM0EoXAc2XMAKVRfFF/Q4WGbfhIHYz8eKoL1IWtn+DGikIc5LOBUXew46c0sx4LOjlNmX+WnGUFc9wFEMwL1fTBjqCoqedYojspYg/d0uSa1/sF7u/9GkysYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by SN6PR11MB2606.namprd11.prod.outlook.com (2603:10b6:805:55::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.13; Fri, 22 Apr
 2022 03:05:50 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::24dd:37c2:3778:1adb]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::24dd:37c2:3778:1adb%2]) with mapi id 15.20.5186.015; Fri, 22 Apr 2022
 03:05:50 +0000
From:   "Tian, Kevin" <kevin.tian@intel.com>
To:     Lu Baolu <baolu.lu@linux.intel.com>,
        "Pan, Jacob jun" <jacob.jun.pan@intel.com>,
        "Raj, Ashok" <ashok.raj@intel.com>,
        "Liu, Yi L" <yi.l.liu@intel.com>
CC:     "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: RE: [PATCH v2 3/4] iommu/vt-d: Drop stop marker messages
Thread-Topic: [PATCH v2 3/4] iommu/vt-d: Drop stop marker messages
Thread-Index: AQHYVXRh1RpkwrJZ6ky57IukWbPb+Kz7QLQQ
Date:   Fri, 22 Apr 2022 03:05:50 +0000
Message-ID: <BN9PR11MB5276D83DF086871587743E378CF79@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20220421113558.3504874-1-baolu.lu@linux.intel.com>
 <20220421113558.3504874-4-baolu.lu@linux.intel.com>
In-Reply-To: <20220421113558.3504874-4-baolu.lu@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e5b07c59-492b-422c-ff48-08da240d0199
x-ms-traffictypediagnostic: SN6PR11MB2606:EE_
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-microsoft-antispam-prvs: <SN6PR11MB2606C5742196C71236F86EF98CF79@SN6PR11MB2606.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: nVmjrvqEdTbjl+IyuTnfVsctwUXmUEOhgwXgXG6tQ138ztAqMsPMXySJqgCDyGXYXkHUL3hlCxKAiB2MGsYGiZeKVybtdsiyvJ31rynDl1mbW9b7gADQKnogtKDNyEycOPMLKNlYRbRMneolNoUEhZP/lNRKt2Tf59YTCpI0JEdcT03nBQjwg4NcciUHImAisdUL4SE2K96TAXoEWGvIrwk3gov1Bdhb9ZmmKxblu9APmW2Bdm1O8rFWqYMwdmGnwWUFAHYGROrTfP4mIwDxF4elfGFrJ6ffEY7BoLqkeVsqgQ450fsIywHFerggQp1teyGIJ+na/V02gusqiv1ja1oEEMlPLlBAj9/y2dVfAsfFCA+To08Vy3n4kspVyslfJmkf9zXPG6ednA4bwivlHtfM2SOLK5x5FpxsSM5/GSeqMsMdyeIWF8MLxLRQ5AYn146QCGHOJOHDSIc0Sa6zGl7wnCizyoEfx9CAZc80MW3nkR+dMoj3empAJ1NuLHAE11jQrUazDWFgyyZ4EzTg9OR/XIcg/WhZ+17t5FZVe/J+W+kQqOqL+ITvisVUY7/z7xC+VrfK+Gasw367rbfHBn6RbkWnSR81bkZQPlDOa0gvi96xI9iqETc7vcSEcb+O4I2mFkmyV6MTYeWUsqIpoFzcu2HKynNRJhfwFPHYm8dl95nGUpgjj27GsgZPmRN+JG730shuhug7/G0cA0ARxQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(8936002)(55016003)(508600001)(186003)(8676002)(5660300002)(33656002)(66946007)(66556008)(66476007)(110136005)(6636002)(54906003)(83380400001)(66446008)(76116006)(64756008)(316002)(26005)(71200400001)(15650500001)(38070700005)(86362001)(38100700002)(4326008)(9686003)(122000001)(52536014)(82960400001)(6506007)(7696005)(2906002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?m3mw7wNiFDicxAmVyeMEXCH6DZiBqXhf3XcInUGBUqI3Q1YPKWodDDtUgk47?=
 =?us-ascii?Q?/lbGDEMpBllAhyIJcvER8Pb0PaBf0cjrj7GPqRhaIeN7Som8h8xVeVxy51YE?=
 =?us-ascii?Q?EX5LkElIcMUB8sgfGQ248LjBgUwILI2+uOalgvFQrvSYgeRvOoHp9c3T4Cnr?=
 =?us-ascii?Q?xQcW/jQ395tmLQqDBl9AOutuOzgmvmrBvwcjCDsigykq6PPRA2XPJlYkQn82?=
 =?us-ascii?Q?iWsuL2ChNhajCUUv/U6aTeROrM+Lu+fIxnrokf/jU8N0G9IHBVhVOWsrs3gs?=
 =?us-ascii?Q?nShDmwcfWiKByycujFIKmLe97gQn8sULmQG70IYuXK99cvahYUZtQCGer6RK?=
 =?us-ascii?Q?cfJzhuFxeviY/Pay81F0Wzo+mqimyevRZjm/Cv7Zq4N5w/2OOG4PsiFVHR8c?=
 =?us-ascii?Q?nW28GQhmelhj8VNhzkOJOaoxRRIfAHe9/8BlMnrZebsNuPWfnCojv3LS0x8p?=
 =?us-ascii?Q?Wv5TIfb+7DZvw6SweRtsJGgMgfxLNl3xTFULTfPPCdhgW2mODNtvvlZH3nm6?=
 =?us-ascii?Q?PXdTwZ9mJp+QtLpMrp7Xe7Wicd1xXRGtJ97RokKUvdYOP1jkmfQpCh9guQB9?=
 =?us-ascii?Q?rqS5hb0jIrZgHjGUK8pRkr+Tq6F4RMPd3yBVAuzzT/Jpt9EuAUyE2ccNnKOp?=
 =?us-ascii?Q?5QBclhhlpnPJFE0W5bOvstfdV5BMpnUaOfDLnmI3nwgEDTap+GP3XinUA+xQ?=
 =?us-ascii?Q?jSTgIz0IU5VdrcY0QLXaSQhL/iN4XXakfBmrfgXFBe6q7UNiZuxxRLeWSOQT?=
 =?us-ascii?Q?j+Cwi5mp/mGE1f/TuvEptWomT/J1pG/XAQUgcuhp4WLu36wKTIKQ56OeCuW2?=
 =?us-ascii?Q?BR8FY9GM5P+r/ArCqnQdLyTGksWcQuBWbTE6sWFypSxJNDiimRooOnfnNiZu?=
 =?us-ascii?Q?d16tu710ViW9FbDdqQykCko+AXL2kp8kmo9TbGHcAbx0FqZvOo0vY5o4buuv?=
 =?us-ascii?Q?12EET+/TqqwnQ+Bv/neTJnMkYUcyM9+7JbdHQDaYJ/0x1knGlGhR5nvIQSSK?=
 =?us-ascii?Q?wxHMm/kQbCZS/7KjB3BK5zfrqD3K1bRQX/8U+vQZcZkEtOnjO0SPVtIB/xJX?=
 =?us-ascii?Q?K1q7/TD27GHujgmY3LUA4q1Wsuju1us4qS8AHILimmNRaOPUETzN+nsvYHvT?=
 =?us-ascii?Q?VGc6bT/5MuqpyEXwlvCGpyI5IGC7dwSlalY+GcRWxeqlkww2XQuGiNsFo1V7?=
 =?us-ascii?Q?BjAeUFPmw5EF1u5FnPlPuFSTKVB+FLCr80FTWzxR+EkJnXutwGgKtL6kVhGI?=
 =?us-ascii?Q?jnOB2Zq+qSbx9tXULNDSp2tQWr7WJbkUaGjrLuvplEeJwixvcrvI79/G1QoW?=
 =?us-ascii?Q?0k0CDIlM1d4eFK8R4b+BPpcETVCNPWP8Z1duOBulUp4YjW3H2tXJSedHAA68?=
 =?us-ascii?Q?jF/6c+qZNgunLeNg7R0KCQ+DgdYSnPtr3IF2yBuIsO9wtNpnFunIpXxuu9Yl?=
 =?us-ascii?Q?EmbpIIFzNTj7EC4pIfz509LhatVog0OsZhhmJt5mo3Sni3mJBvZRAgNo5p+2?=
 =?us-ascii?Q?zJM2lLUsnm2NqP25OigKnwl2X4uBWETeiYiJvAzgWIHzDixyPcjO5aM02n4B?=
 =?us-ascii?Q?1hbBpQbrqOLzK7I4WP8nUmJy8L/67TvpxvgfIAYVz4LRN1xUBfmTNh1dxn5F?=
 =?us-ascii?Q?7b6rAAo6DGOUMyHCyZ2LW1hRv5+FD5nJRspvld38Bnqk1Zp1Q83YDjBzT785?=
 =?us-ascii?Q?Qu3d4jkKv+9W/iRWV+uAXWfXAS+LdlxgghZAOb3LdBmIWmKZyuGwA7OpzmPG?=
 =?us-ascii?Q?94Y5Wnw9MQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e5b07c59-492b-422c-ff48-08da240d0199
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Apr 2022 03:05:50.5921
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8EDzV/KiPbuYxMetZereKB/mwwlzcecIdLgX+2yVdlU29Twimt606URnZGefuohsP7my/axpPc9tnhgQVWr3wA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR11MB2606
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Lu Baolu <baolu.lu@linux.intel.com>
> Sent: Thursday, April 21, 2022 7:36 PM
>=20
> The page fault handling framework in the IOMMU core explicitly states
> that it doesn't handle PCI PASID Stop Marker and the IOMMU drivers must
> discard them before reporting faults. This handles Stop Marker messages
> in prq_event_thread() before reporting events to the core.
>=20
> The VT-d driver explicitly drains the pending page requests when a CPU
> page table (represented by a mm struct) is unbound from a PASID according
> to the procedures defined in the VT-d spec. The Stop Marker messages do
> not need a response. Hence, it is safe to drop the Stop Marker messages
> silently if any of them is found in the page request queue.
>=20
> Fixes: d5b9e4bfe0d88 ("iommu/vt-d: Report prq to io-pgfault framework")
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> Reviewed-by: Jacob Pan <jacob.jun.pan@linux.intel.com>

Reviewed-by: Kevin Tian <kevin.tian@intel.com>

> ---
>  drivers/iommu/intel/svm.c | 4 ++++
>  1 file changed, 4 insertions(+)
>=20
> diff --git a/drivers/iommu/intel/svm.c b/drivers/iommu/intel/svm.c
> index c720d1be992d..0741ec165673 100644
> --- a/drivers/iommu/intel/svm.c
> +++ b/drivers/iommu/intel/svm.c
> @@ -760,6 +760,10 @@ static irqreturn_t prq_event_thread(int irq, void *d=
)
>  			goto bad_req;
>  		}
>=20
> +		/* Drop Stop Marker message. No need for a response. */
> +		if (unlikely(req->lpig && !req->rd_req && !req->wr_req))
> +			goto prq_advance;
> +
>  		if (!svm || svm->pasid !=3D req->pasid) {
>  			/*
>  			 * It can't go away, because the driver is not
> permitted
> --
> 2.25.1

