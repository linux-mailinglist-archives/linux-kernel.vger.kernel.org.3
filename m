Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A31D95697B9
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 03:59:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234765AbiGGB6p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 21:58:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234161AbiGGB6n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 21:58:43 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D6E82CDDC
        for <linux-kernel@vger.kernel.org>; Wed,  6 Jul 2022 18:58:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657159122; x=1688695122;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ugTPB8Iea7gUrXWMaXW5LF8X2PTfLkvfauNeZHQrdoQ=;
  b=DBY0yG6Vyi/57BURwzS1skenFJY4HAb21NEELkH/gq1Pqw4lZ0VNRt6A
   GYEAePEc6b86IZm9idt/3APBGkd2X5Se8d3RGCijKtN+JFeAVezK08TQQ
   l2fK+5Cl9lrfAPdjzObzaELL3d8jIzyc+h580uy4hHip9pVxyu3L6b8go
   Jd2N6Vh/vzA/oOOwZJGeMDRmvZvMk0DK/X8NCxEjQbtNCWTTxveqPpWLS
   cUnEkuN+MtqIPBJslQuOQB2KzNPcNenkCMaRI3J55fcBWrQ3oiLDRP9q0
   xqQmrHEcJMX525ZSzotGzwUXcKLEfoWwovwkW4S1Xj2BTO7YOoMneyc/Q
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10400"; a="370226871"
X-IronPort-AV: E=Sophos;i="5.92,251,1650956400"; 
   d="scan'208";a="370226871"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2022 18:58:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,251,1650956400"; 
   d="scan'208";a="650919926"
Received: from orsmsx606.amr.corp.intel.com ([10.22.229.19])
  by fmsmga008.fm.intel.com with ESMTP; 06 Jul 2022 18:58:41 -0700
Received: from orsmsx608.amr.corp.intel.com (10.22.229.21) by
 ORSMSX606.amr.corp.intel.com (10.22.229.19) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Wed, 6 Jul 2022 18:58:40 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx608.amr.corp.intel.com (10.22.229.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Wed, 6 Jul 2022 18:58:40 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.173)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Wed, 6 Jul 2022 18:58:40 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DEXM3KOTrKW4dvcZdAXiHbtyEe4BtTk1haz4K2k3dSKhcz70QKzWBdrsoZOS6CfYyvHo6K/+8cnNDagkYP5ot21PTRcwpNcfdLnhj2tKwgO/7/utr+qmaHvWQDJwmgCrAMy89ivERnmDhleyNLVFGn+ED8BZuV8j8np6VgCU6aZWMJO2W6y4dkXA6Ixzf1K49sbLHJevuMMAaEuRodia44sad1aT34sISHEIxAnzVY2kjX1DHQ+lycw/Gs7Hp37Q6I6qMJNoqUsQTZZiDicNc539TNcusYyoInZJTd7Wbi2gNEAVP07ZxyV/gqLoBwgZvHXqJ2RszkA+GvaVjenWVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ugTPB8Iea7gUrXWMaXW5LF8X2PTfLkvfauNeZHQrdoQ=;
 b=khzdCkPBkMEZ3MU0rn9BjgQp+VcN3tG2Pc5jy/SHbyQdW6BWzpUxnx+x4K2SDr0i1BShtRX5pr/9uvAQ6ak5Mzu2Ye6GxcwnLX3WjGCGUm5bxtSlGXRad2S0Ay3P8sFiwUqXgiicP31u6X764z7BqEt6bEV9nQoWeFeMNSqVEik5mz0zivTfPcsrXSsnb/jedyYt60Kgxha32S5uO/VCbQsPfjNFg35+S65F05mFT06nSj9jCmCb1LPqnXrWczZctdZ96NjqwRKJNoutbHrv7vwB03lO8QGFJ/Q216vR1DJchC8QBuloYncO0onPtYkEyw4O6RlfR+t/YFfA+EbLzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by PH0PR11MB5112.namprd11.prod.outlook.com (2603:10b6:510:3b::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.15; Thu, 7 Jul
 2022 01:58:39 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::8435:5a99:1e28:b38c]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::8435:5a99:1e28:b38c%2]) with mapi id 15.20.5395.021; Thu, 7 Jul 2022
 01:58:39 +0000
From:   "Tian, Kevin" <kevin.tian@intel.com>
To:     Lu Baolu <baolu.lu@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Christoph Hellwig <hch@infradead.org>,
        "Raj, Ashok" <ashok.raj@intel.com>, Will Deacon <will@kernel.org>,
        "Robin Murphy" <robin.murphy@arm.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>,
        "Jiang, Dave" <dave.jiang@intel.com>, Vinod Koul <vkoul@kernel.org>
CC:     Eric Auger <eric.auger@redhat.com>,
        "Liu, Yi L" <yi.l.liu@intel.com>,
        "Pan, Jacob jun" <jacob.jun.pan@intel.com>,
        Zhangfei Gao <zhangfei.gao@linaro.org>,
        "Zhu, Tony" <tony.zhu@intel.com>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Jean-Philippe Brucker" <jean-philippe@linaro.org>
Subject: RE: [PATCH v10 10/12] iommu: Prepare IOMMU domain for IOPF
Thread-Topic: [PATCH v10 10/12] iommu: Prepare IOMMU domain for IOPF
Thread-Index: AQHYkC3X3zhuGv/Z20C4J9a0jjJ5Mq1yKbbA
Date:   Thu, 7 Jul 2022 01:58:39 +0000
Message-ID: <BN9PR11MB52768FB23642CD038DC93B428C839@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20220705050710.2887204-1-baolu.lu@linux.intel.com>
 <20220705050710.2887204-11-baolu.lu@linux.intel.com>
In-Reply-To: <20220705050710.2887204-11-baolu.lu@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6053bdc4-533e-49dd-932c-08da5fbc35fd
x-ms-traffictypediagnostic: PH0PR11MB5112:EE_
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: LssPWWPwv+ng6z2qry3wbgAMMdDLPMIFRVpa0FCg9y8q5JTOGL2nlF1nVrOrrzsA1AdYim4IwrfP2hkGjLk3/Nu7HnU63+1rZRFYy4PhUHv8lAEHBMYo3lYNbvW9MamJBXzL97QeCQbZ6svid0FYX7mZZUmn2djS0JgXee7Qwv/qz1RGJ1Dlsc+6y+irafzL1ngzE/iCVWQanMb6g8hO+9I84iqMhG2mY8r1QOUchY1iZGvc1VmJibG4b0NXV32X4erV0+cFxpZAAO0ccZ7+dPw300uzc8mFO3xU7qQqxhcF8a5YF93D8XbWNLmQf+kcrcQ5FXHbvE/tPKCRnkkNX/JwvE56vaHr+zad9aoVw3h47cGEw4vBeWZAE/j4pBW68FpOjAdixN8YXRnqqidSPEtvSNMwmuIIdMflbgjPRKJMixN/wiuoFo7vdVzQXjcYgBruDW0w+1+7ip+lggaOhG5y+pC0rrXdBjfxsgxyjavOQ4UHC9/Z+egGtmsCc/KT8lpYbIw7/zMxVtboT3lzkFgmqF41eLzLbJyWyJ3BzGr7EFf8luEAJ6Z4RMt/rMrgLQI+cR2hJJlIDcGe9Ai7jJjZFkMOr0yzQMmCdXSLEd+0agECx+l0jvcxfQrcrW/6PUe2YXmPIa3lncc6rBjtQ7XQg68aLWxAgpANQhZgiWWXmsDPOP0bbmqueqEpnZTXtdZWw+ynklwQqCrBMIUs0pTaZWhD+XG+fyCzNvbn0k0pMmzIWahSFH0466Hco70cLqO6Ef/fG6tRp4RsRMRtFknK4mPhfXtLM2bqK2Gh2qBnHXSWiLf5MGC0UihavewA21YbbCoTtspUtyY8nbrk7g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(346002)(396003)(366004)(39860400002)(376002)(136003)(478600001)(38100700002)(2906002)(71200400001)(66446008)(186003)(33656002)(6506007)(110136005)(7696005)(41300700001)(66476007)(4326008)(54906003)(921005)(7416002)(316002)(86362001)(5660300002)(82960400001)(8936002)(38070700005)(26005)(52536014)(83380400001)(64756008)(122000001)(66556008)(66946007)(55016003)(76116006)(8676002)(9686003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?BfgFr9sBaBUHkl7Pq52e5MrD1lAK1eq9RHFeBJlPaDDDaEyJz6f/XQDtYqfq?=
 =?us-ascii?Q?YwzuYhaTshKQdDONSSsPhqME4OCO8OpqMswDJicSHwRQXTp42ou5LRptrsPQ?=
 =?us-ascii?Q?CHrLrUq1fVps9wR24kT0CjdMuBP1RdIeq+sLNzjnsF5Iu0KV6LYkB0LOD7qT?=
 =?us-ascii?Q?AUkfO8/O5hKO1oRe+JoRM6XMRAPaE739UougOFK1w4X+TYufnXphmqBEGsN/?=
 =?us-ascii?Q?gm1dF75WFdSBd2638Q4l7GG/9BcG5V2SMXXB+aHk27IZMOHLuexygVpGBEjx?=
 =?us-ascii?Q?LFj9H2A3CV2SGbtJRLiZoPAUR7wjuTC49AjN2oVkmZ0ynK0m+4ktz/RKDlUm?=
 =?us-ascii?Q?7ItvsbpvNm7BHOGcpD2a9jf7k0+FGGpBLiiCZO7vGKmsZtdEorG6fpxOi4pp?=
 =?us-ascii?Q?09OLICYsOsmDD5RZwTHYGvhUTXdgC2lehlz3YXsseZXMZiEwC/Z6hKNsrKhb?=
 =?us-ascii?Q?mRqhhd8ns7cQEHXUlWVaPd9GEkJQBM9i+O3hKr5NWFUfpQTO06GYXGVnCOcw?=
 =?us-ascii?Q?0JxvN0jG3H0t2D5r/1xSpsMh07G0ohw/Myvbl0ExpE13jEutOtLm+CdMnxir?=
 =?us-ascii?Q?f0A62PpvK8zpjRHKzHvyzLu2fhZ74jPg+EVglVr8JabMb9TVOQQX2PAjF310?=
 =?us-ascii?Q?jgGafuDH2aFY7sjwMwc7FbQFte9nNTmexRXBu99YnDzEgid4xI2+Z3dypV8d?=
 =?us-ascii?Q?TXxtM05XZKqMTuq6v4gdyiifX8SpLAUeuYXhaQYdBLO8R94iXZKjnZRFZgRb?=
 =?us-ascii?Q?HhevDgrEwB/2YA4w6zqP4cJTQpoxM/2GTXC+cJkNX4WqJ3phc47vIsaj1oL0?=
 =?us-ascii?Q?bUZaEABdyvtMNeLlXmr5dpAbPl2vEt/NQ8FosigyJo7E2bsyjQBK/X5T90LC?=
 =?us-ascii?Q?CCxnjSPNpKLJxHbV0wuqJEAf2owXmIpzCbESuRCYgh0m6obGOVamYjCYCrIa?=
 =?us-ascii?Q?UxUsY6CBxOyzpiITpv0FROd66+49vk9HruhoZUzEvAItD34ao6GdjhBIN2U8?=
 =?us-ascii?Q?Mi1nbss3b79uxiL38wLsQr5i2WJpamkuosRFegwioL+638NnVNHX6Sl6Hv3y?=
 =?us-ascii?Q?1MGzKSO1KMB+XR+Jo9mMMZe9850gbZbbCe5zZKjX/L6IPFh7uh7OI8oYfmJG?=
 =?us-ascii?Q?lvbdl3sP+xnGxdhwJzFEZYEAFZXKvTLcLB1pAphFu2fSbtAm7b9xNi37z6Cp?=
 =?us-ascii?Q?TjwwpMco1vX1OSC3UiTbl7nNW0gEHSQXVZe8iHb1OOpDXz4ahKQCQ2CDJ1qn?=
 =?us-ascii?Q?Hbbs1Ci6SC6+boFugUsVXsjvsiAQpo73M0L79veY7HNVzGM+QpPWDObq7173?=
 =?us-ascii?Q?VpU0bl7b5txmoVFsDOBwU+SUGhR9ZjU+RYEbuYFpROmfYEB8EioABC6rgGJC?=
 =?us-ascii?Q?hyJ2QurUbwSKjqF7zKrcUBffIe+6X7qTSJyKdlAtbNE0TDRE7jzFbxQ5h75A?=
 =?us-ascii?Q?XqGLkiicuyqRR3ETepKHZ6sIV+8hWOKnAn8C/8Jr5lCc0HaewpOt9gS9LObU?=
 =?us-ascii?Q?fqMCmSYznXI2au2tdmCgBFASiC1tBnttR7fTp6v3cq5OgBDKYlrGwStLtF7X?=
 =?us-ascii?Q?ysedPRCwL+umjL8Wp2JdYSLRfoCVUpb7gKLRxnzk?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6053bdc4-533e-49dd-932c-08da5fbc35fd
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jul 2022 01:58:39.0491
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AMuVyruaKePfHpO1aRCC9gle8mBXXTaLlNxaJw5OxdS8zwCVBhiCTxuYlPZmlZ/CBFKRPras7U88FKsfcfDcKA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5112
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Lu Baolu <baolu.lu@linux.intel.com>
> Sent: Tuesday, July 5, 2022 1:07 PM
>=20
> This adds some mechanisms around the iommu_domain so that the I/O page
> fault handling framework could route a page fault to the domain and
> call the fault handler from it.
>=20
> Add pointers to the page fault handler and its private data in struct
> iommu_domain. The fault handler will be called with the private data
> as a parameter once a page fault is routed to the domain. Any kernel
> component which owns an iommu domain could install handler and its
> private parameter so that the page fault could be further routed and
> handled.
>=20
> This also prepares the SVA implementation to be the first consumer of
> the per-domain page fault handling model. The I/O page fault handler
> for SVA is copied to the SVA file with mmget_not_zero() added before
> mmap_read_lock().
>=20
> Suggested-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> Reviewed-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
> Tested-by: Zhangfei Gao <zhangfei.gao@linaro.org>
> Tested-by: Tony Zhu <tony.zhu@intel.com>

Reviewed-by: Kevin Tian <kevin.tian@intel.com>
