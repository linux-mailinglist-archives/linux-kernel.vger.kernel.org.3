Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E562569A8B
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 08:31:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234944AbiGGGbh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 02:31:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234887AbiGGGbg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 02:31:36 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AD5410559;
        Wed,  6 Jul 2022 23:31:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657175495; x=1688711495;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=F8f7pWii0lIE2gA/9gl7pQ3Y5Xm7SYT7oe57sDk/YX0=;
  b=fbMae7iNRS5E7bG7zLW4y3uquzfFnHryoniG1guUgbw7leD2lp7VvzKR
   KuJgTyslxc0tQ96T1MEu3F2BFX6rAk/pye1uMV+QrHv34wrmYiEhEjDmz
   3WfTBCZX/0ZT5SgU9Jd6AkVR1e99L5ZR456wmYLHqFvLP1mz8x2adRQPr
   9AwnXIj2IONEPWdQZGIIuhC5qo+JZS7c3wnBmlSROye44lbd0dnWxdy6Z
   OnTyKztavgvB4R3Ka7tUkvgdjQ0ujIPU7vHMtFO9T7XKaz0G+HxcKmYid
   9BV0LdwAnXfvwo1L/FRHjJ/AtC+6UNtc+XP5LB4ZszxGNYH/0JYctY33z
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10400"; a="272737229"
X-IronPort-AV: E=Sophos;i="5.92,252,1650956400"; 
   d="scan'208";a="272737229"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2022 23:31:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,252,1650956400"; 
   d="scan'208";a="661259772"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmsmga004.fm.intel.com with ESMTP; 06 Jul 2022 23:31:34 -0700
Received: from orsmsx607.amr.corp.intel.com (10.22.229.20) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Wed, 6 Jul 2022 23:31:34 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX607.amr.corp.intel.com (10.22.229.20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Wed, 6 Jul 2022 23:31:33 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Wed, 6 Jul 2022 23:31:33 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.168)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Wed, 6 Jul 2022 23:31:33 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fysSzdTZml4Nux5IDfYHa1VyzYBkYaaZSc5M7ACsxkGxQ/ACyNH03sar1SPwzkfi265lwQlk5An1X4LSW6VKQAScjqsDNd1GsR1yuwT1OW8r1BJ4lQyN52gmLMZIJ0dDXjLW0hke/DddAlvcSrfB+qmHUe5z6fQW8EXYM9SPJY/Y6HpHWo0KmysRW5O5LcOorP7cMm/gr19hT9aGhJU3aYgJNSeFxIFMhqS6PuGJd4rPjGSzo3OeklSq1gVfN/9uM2izpf8nBYT/ew7Hh+6b3AzZG6jprIY0t+8kNauLrRFFGLTNKsbmtoRzOWpOr2wEfAPQb6N7wh4UyF7NCVDHHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mf2S35jLYSz87j/P0dLygZvs89Q603YPw+yLtFpb9yM=;
 b=nDX6HlnXadepqIXr4WP/Q4L52T8kUFTYqNrynpXPAquCO3UIRqzQNvd6YgpkljxCue8lqjCooeN730jWpgJFG12PSDHVXxFC2H8B2OKub7PmXOSnBzbokv1I4+cXfYWLAcqCOwl0Dwm5DJSXb+iWHduCJ7psklm48U8PzCx7kkceUHW2M6hz1ILV7P3LsvX9Kfr9qXrlxrtJlKRSt8R0Sxr7h1UpeSGrwXcBXA9IHObvP9DbrWm+pKuOEd1rDK9G2WTK0SGHAWURvXDy7tsN0rlYeq4ZIOklwRPDrjWFCd2L3V5w+uChxCROnLpMb3/T1VOVm5ZjkyJRBhUZ3W/uQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by SJ0PR11MB4991.namprd11.prod.outlook.com (2603:10b6:a03:2df::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.15; Thu, 7 Jul
 2022 06:31:31 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::8435:5a99:1e28:b38c]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::8435:5a99:1e28:b38c%2]) with mapi id 15.20.5395.021; Thu, 7 Jul 2022
 06:31:31 +0000
From:   "Tian, Kevin" <kevin.tian@intel.com>
To:     Robin Murphy <robin.murphy@arm.com>,
        "joro@8bytes.org" <joro@8bytes.org>
CC:     "will@kernel.org" <will@kernel.org>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>,
        "suravee.suthikulpanit@amd.com" <suravee.suthikulpanit@amd.com>,
        "vasant.hegde@amd.com" <vasant.hegde@amd.com>,
        "mjrosato@linux.ibm.com" <mjrosato@linux.ibm.com>,
        "gerald.schaefer@linux.ibm.com" <gerald.schaefer@linux.ibm.com>,
        "schnelle@linux.ibm.com" <schnelle@linux.ibm.com>,
        "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v3 03/15] iommu: Always register bus notifiers
Thread-Topic: [PATCH v3 03/15] iommu: Always register bus notifiers
Thread-Index: AQHYkJHsAUneNaK+AUyHBuGFcsQDbq1ycmEw
Date:   Thu, 7 Jul 2022 06:31:31 +0000
Message-ID: <BN9PR11MB5276B6689D88D3D5D57915908C839@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <cover.1657034827.git.robin.murphy@arm.com>
 <8c380309f264cd0dfc73ba2ec060adc9515af2f2.1657034828.git.robin.murphy@arm.com>
In-Reply-To: <8c380309f264cd0dfc73ba2ec060adc9515af2f2.1657034828.git.robin.murphy@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e7611ac6-8611-41cc-82b9-08da5fe254cf
x-ms-traffictypediagnostic: SJ0PR11MB4991:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: MRWpqZdaIAhZmmbj1pL1spdk9C9Crn6vkzUt4fe8BDTn8GFguM9DvhxdomMV7BIL2Xv75uwClW08wxvh/hBSJiJ4i94p0rS+H5dcJTYqUdS9uoQYvc3iQYo1nGKiQ0/BNwX6k5WlbRKNPShq6trlQQhoF8jLNxWzfn2KV0XVU+igF57WDzE/mOq/SnLWQNrAUHaQNo5nAQp+4nRM02mdOGQTiQbuDxchkOyy74D35V5soOaaqov4JhB5Ex0OQDe9Pwf2DxMHFARYiS6wVDX+1DhMZenUQM/s0Sy/OinOk6TAgX+AXEEnyAjHGoNp4Zk/O+jgJeEIm3fu/+1lrlS0ECASHdQtMdHDqM9mU2dgLwia7V6XZ8pVsxVPOd1fMEsG05xgGRzu3oQtdz0mLpt5b9E/fDizPdknklrqtDIzRmIRSaHC5+45PQcykAmbE1MAflA0xy5P2Clu2kai3+LMmz08NxSnZr97MrrMqwAlqbKVKOW1+OvW24KvkKpWlpUdOzVdduecQsR0lr64MK8BK0wGSm7c8ihVtktTLNvyXAh5sC6GbMzKhgJhGj2ZMt2HJvWx/sNDMo7zcXWtjQJwfHzKe676cBclhBhP884XKoHu9cswUYKdlp5/xG3Q00orsvMQsDyDA+NWWWiOlADcz1PkyXexR87t1i3RNlLFV5isdz80RgRIYxlFKnl7dyCIjdqCNygBuHZ6l/RlmYp3FORDmR2Jbo7/2mdEf0RZlanzVd8npvlUVAWs9T6KVVctasAebBjU+Rtzusa55mvwNNQrzfywstYONgpuaVns7sTmRhiP2rTzIorrcOE3KmW1
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(366004)(136003)(346002)(376002)(396003)(39860400002)(26005)(478600001)(6506007)(82960400001)(8676002)(122000001)(7416002)(41300700001)(4744005)(9686003)(2906002)(5660300002)(83380400001)(7696005)(38070700005)(54906003)(33656002)(76116006)(66476007)(66556008)(110136005)(66446008)(52536014)(4326008)(8936002)(38100700002)(64756008)(186003)(55016003)(66946007)(71200400001)(86362001)(316002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?5JeeuEj6SYkbkcN5S49en6UmEnuLBBqevOSuCBSfJHnCIiGEnatZuH0qp0iJ?=
 =?us-ascii?Q?jytS0KHWv/7GNfTTLBi89ym9QJIwUuCefNHTGByCQNe+abk1Wa6zvK6Dxuoc?=
 =?us-ascii?Q?knw62zFyC5/wK/YI8NBpi+X4+0Z+LfXbfuF4bzf23C6KaUoPW2KBeDcx2Aul?=
 =?us-ascii?Q?qgPtHfclNcVAXnUocZ9ijrTlx1YbKnT6nPrUOoi1IU3rebvWdDJA4WB1qxbC?=
 =?us-ascii?Q?Hi7XYPFkiAOBtx5XYyLa6g6psCv2XkaTsr42c6yF06QokQRpo47W7u9sXjfx?=
 =?us-ascii?Q?KuV+0W0iZmUPXhQSXNGbKu8fWJdXHjjbXIk2qq6iiFrtGEcnFEwP8FcBlD1Y?=
 =?us-ascii?Q?0kW+XFobqDH/cMpzCc4pmXtGwxHKekLbLeduf/Sg8sGhlO8/Zp1M+FaZKodT?=
 =?us-ascii?Q?CxYUbiW7qOCtg3pU9AAlvRYAYb7rYzSdkfrwWhUj8a8Y5HKPcDid+885nVYY?=
 =?us-ascii?Q?Xg58iR9lCI2f9d+iinAbb3R9jQX4Hx26U3fbbD2JYinLnNvHE+SN9mMp9X2y?=
 =?us-ascii?Q?5Vnd0mXLrK/4Rf7/MgjnIfr7iD9Zf9aaxlGFIN/r4KvmR7Tj0WtmLqt1aB1p?=
 =?us-ascii?Q?PGwq3232H0yaMuHRk2IkaVdVHRvxcMZzhjwlo7uTn3mvIKvQcbu+HqONu5a0?=
 =?us-ascii?Q?SMaYwvhIfF3jBXseRrXihLdwD4LIJizVooq92bWj5CLfDT/mgutSbhIYpbfW?=
 =?us-ascii?Q?CXGOyVtKSPIpNdfYYUX/FYV2zNulOcSI1rMmDbjQJytWP1l4XfwwtADQWJ/R?=
 =?us-ascii?Q?kbw5imtoou86bzUeiHhFw2WIojjPt4qJTyw7DHMAJu59MAzF5ray4DFLoZB6?=
 =?us-ascii?Q?RLRZMsPEYsoaJaJKuQ3mXLQFuON9KrwtIR4MJGmuYGmjYfN7xgmM+FT+Wv/S?=
 =?us-ascii?Q?T4vfN1RVDsDl8ECGs03Z3JbgE3bfbFr8gLSBCoKKf4GZnzyl8rQLHzTP7jE9?=
 =?us-ascii?Q?nA5ib6qh48s3unu7dEC/aODtLGwsdCwrOAFY6Mhl0K7vtSvvIIwngQ01+WYI?=
 =?us-ascii?Q?PAVE+fLgYyN8XtJpVk8ZvqcOTNmvm/aP97WR5rEm3Uw2CrKZ4BA+1Lx1z6pa?=
 =?us-ascii?Q?Sc35l3sgN14E5U1LtNK/Zfj7q8K+eqgmC9UBnEchxZrL8+dSn8a3RNzfrR7a?=
 =?us-ascii?Q?lGFQx/AiTp6b2rwFrDjd3KX5fiEYDKhRCas11glTXxu3CZ/jVCAvw9HFj/j5?=
 =?us-ascii?Q?kks9zlD1zBzccAF40R4DVB34aHKf6D+6ZNZ9LfIDKqHVC2dxOAaT5nnDCiQv?=
 =?us-ascii?Q?sYKPwtVVBl6tkkBSRvcnEJh4IxlkIsaeaGetUMdtv4jh3+9hsmIo1PIAqHU5?=
 =?us-ascii?Q?JAHdHtD6m3eox/i0YZquo99mASPmrBDV3nEZe/S9CoUjHc+pJi+E4aun/9bO?=
 =?us-ascii?Q?ucIroFK7ePxh+F+AoLSZrhIkbOYHgPICNfNx31xG38Nw1NBPQH5KmRbUi7m4?=
 =?us-ascii?Q?sRmoeIHRq6jHa1oKx/UIXp7PMXbjKDfyZZkgSrfiemyLJJBuTX4+C1YH0JvR?=
 =?us-ascii?Q?dmxBj9VhMWELwRKlFSB7J8swtlnC5HN2kY2ExU1FktbFKBPeT+wCcMFs0mDg?=
 =?us-ascii?Q?Xyg00VGhm64xPRtjzqK1Ik2tJW4mYX2bLqnhmiOn?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e7611ac6-8611-41cc-82b9-08da5fe254cf
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jul 2022 06:31:31.6167
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Nnm568O62DTTBjkekJ2IfogyJcrXYLpp0Q6eOcRYVDXhvAI+SQNgFt0ktbn9fPNAAhMZ5MZcPriGd5rj3Zfi9g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB4991
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Robin Murphy <robin.murphy@arm.com>
> Sent: Wednesday, July 6, 2022 1:08 AM
>=20
> The number of bus types that the IOMMU subsystem deals with is small and
> manageable, so pull that list into core code as a first step towards
> cleaning up all the boilerplate bus-awareness from drivers. Calling
> iommu_probe_device() before bus->iommu_ops is set will simply return
> -ENODEV and not break the notifier call chain, so there should be no
> harm in proactively registering all our bus notifiers at init time.
>=20

Suppose we miss a check on iommu ops in iommu_release_device():

	if (!dev->iommu) <<<<<<<
		return;

	iommu_device_unlink(dev->iommu->iommu_dev, dev);

	ops =3D dev_iommu_ops(dev);
	ops->release_device(dev);

following the rationale in patch01 a device could be removed when
it's associated with a known but not registered instance.
