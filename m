Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A95FD54A9EE
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 09:02:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352751AbiFNG52 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 02:57:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237352AbiFNG5Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 02:57:25 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5558F29823
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jun 2022 23:57:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655189845; x=1686725845;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ess8U2d1NVl+JVFMLSvDbG9ncyq9IF3vS/uaxinFRQo=;
  b=BDAfKpeTHlGuNnLzt6U3HdVXwE84PrAxTVvEpX5+vHrQVJZyUwHDaJg5
   sdF3Ynl+PvHiL4W5YQmympk5vJ2iDg0wl0hesBaKnaba0yn2lYdScstmG
   pZ3I8ITvLGcmG1AN4R+P+ZX0phNQFkeQYfmBZm4RsupGxI9elmhm+/Zqm
   nMJMPjd+xYH1gI6Z15tkyr5otFyJYQgw/XgZn6mRlLy6OKP7NCYwHBRRm
   kK/jz1X8wy53oTU6sshrE5CUzyKeDbHqQxa4w4DoXgkra8PzCEM1/bRiR
   8yPPZ2RC1VFkgpbxe6HIdzzK0y7l1iclUhlufWmYNZtPI5w4rtVrBjZ0Y
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10377"; a="267216155"
X-IronPort-AV: E=Sophos;i="5.91,299,1647327600"; 
   d="scan'208";a="267216155"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jun 2022 23:57:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,299,1647327600"; 
   d="scan'208";a="640181142"
Received: from orsmsx604.amr.corp.intel.com ([10.22.229.17])
  by fmsmga008.fm.intel.com with ESMTP; 13 Jun 2022 23:57:24 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX604.amr.corp.intel.com (10.22.229.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Mon, 13 Jun 2022 23:57:24 -0700
Received: from orsmsx604.amr.corp.intel.com (10.22.229.17) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Mon, 13 Jun 2022 23:57:23 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx604.amr.corp.intel.com (10.22.229.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Mon, 13 Jun 2022 23:57:23 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.105)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Mon, 13 Jun 2022 23:57:23 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WeTBW4dTNyvsWa7KCpmLDGD8kgLDSoxPnSuz9njDgJvVj9L13sGWtMv5aVfjUDUVvOG0Stgq+X0yaOlUo6diGTa3+IiNw/lDb9QXdGa/MqxNDyfGmmWyT9ZOURbFnY1QSsJkgg25oRlFh8H/B0wcZVrZLsL9+/gEn86XaRJNzXTjs1oJwBy8Lq3vAlDehb0B0x8CjAUvSlXSWv1BI44ET0OP6B9NiUTnnysn6iXZPn+VHGXEyDf/Gf03LvBbY3KGRBNQdHRCuuu+/w0szzHU3+vzJAc/ixZqtSw0GCfUbFcR2WlVLDIcmUdlvdZN90YvrBefBCIETz4ipOqxFAOGAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ess8U2d1NVl+JVFMLSvDbG9ncyq9IF3vS/uaxinFRQo=;
 b=IuUGQEb1Q5ARes5h41sVHbuVJJQ1LmEvmZ7zZr935DKtfwVnKxqxqq1q2AnFvelU10z6ZuLk0pK7JV/XW6J0dAm+EyBEWkqDvVsk981JTGAtriwOi4KeTDtDWKpQroumRVHl5/e1vJeD5sDf6sxpzVaOR1ZY2HClpA+x1tAqzVl0cmRtsI6eeR5HIh7QNL95XMXGH7q0IxHtUmE9e3IVN/eiYUZgqRhMhxeDMhYkNqxoG1G5c0X6axZMKB0hw52pg97eGR2rd7fn1USgTP0lopKmtRf9HVmYIva/Sumhg6Equj6sH5WFZgxXZOazrhJQFaXLC+F1q916fx5RQctN9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by CH0PR11MB5562.namprd11.prod.outlook.com (2603:10b6:610:d5::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.15; Tue, 14 Jun
 2022 06:57:21 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::3583:afc6:2732:74b8]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::3583:afc6:2732:74b8%4]) with mapi id 15.20.5332.022; Tue, 14 Jun 2022
 06:57:21 +0000
From:   "Tian, Kevin" <kevin.tian@intel.com>
To:     Lu Baolu <baolu.lu@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        "Raj, Ashok" <ashok.raj@intel.com>,
        Christoph Hellwig <hch@infradead.org>,
        "Jason Gunthorpe" <jgg@nvidia.com>
CC:     Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        "Liu, Yi L" <yi.l.liu@intel.com>,
        "Pan, Jacob jun" <jacob.jun.pan@intel.com>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2 09/12] iommu/vt-d: Check device list of domain in
 domain free path
Thread-Topic: [PATCH v2 09/12] iommu/vt-d: Check device list of domain in
 domain free path
Thread-Index: AQHYf5pNiDZRYR4B60m56Ba3CHUqE61OeLAQ
Date:   Tue, 14 Jun 2022 06:57:21 +0000
Message-ID: <BN9PR11MB5276A0A772A7DE19239796B38CAA9@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20220614025137.1632762-1-baolu.lu@linux.intel.com>
 <20220614025137.1632762-10-baolu.lu@linux.intel.com>
In-Reply-To: <20220614025137.1632762-10-baolu.lu@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9f26d807-f7f0-4b05-9b9d-08da4dd32128
x-ms-traffictypediagnostic: CH0PR11MB5562:EE_
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-microsoft-antispam-prvs: <CH0PR11MB556244D2304B04AC2610EC898CAA9@CH0PR11MB5562.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: UdEy5kkTIUnHo5xp86iXb4v3m1rnx0ol5/MgSHi2WInD89msmRJC3+Eah4VXvt1paFtjJpOqazAuRBAl9aQtsSfZ2LBsz/wAyi4020C6zvIzWISlzB653L0TMxEoQS/jaDCRfIzwqcTJBOXovB73d0g7r850j+1foJ99lOHVFYiNsaVn9nlm1AW88Cy5w4BjnPsvOjiKQGhABtCMokxKFIBsjglb44e2rcBIP4eIhd91DxYuvU1uuTtuBwFZI8s1W8TJOjaYBEsQ6lFQlhpA/Jz0wr44YOB0rqZEqa1WbF8YyxZpyl/Ndp3+dBUmFkp4sVUCIGxJ7MJzoSixIOQGFUMQX8f/qjU2F1kbp6LZwywHiuEWN92Edz1tI/GT/fWTrv2uV6zx1WZjHNraISXj1VNWJULemkbs2cqS74zO0p4LCLb2+nAz3Cu2H/LT5yZ/d80nnYQ/L42TVHZk6/gud5zI1EicBpfrCxNsfG+PXpv+E1Y1UXtB9N3M67ghcob+u5MEavULuYH1PkHDxaLNsECEHCMfQCJ2kpQeRbCtkWBZ7iZoojhw1pV5uaH1DVrmyXYwalxhglztc0yXvhauyIB3JhHen4HPYnNvNUzPUjKdpyBNTsuN8yu7iU+Hbw2vtFPELj6ZYjncHJ9chJQf9MBo8MXYlFHqOO0RNrDmKwRa4whCSMeDL/96NBTjLg6k2YUm8j3nGae9dlZjW1EfvA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(366004)(316002)(54906003)(26005)(38100700002)(4744005)(66446008)(508600001)(6506007)(5660300002)(71200400001)(86362001)(110136005)(7696005)(33656002)(8936002)(122000001)(82960400001)(55016003)(9686003)(83380400001)(38070700005)(76116006)(4326008)(66556008)(66476007)(64756008)(52536014)(8676002)(186003)(2906002)(66946007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Z182xrSkxMsb7Rqz/Y2hYFz7prlrjlsS5CT4XCrsxAmp4SUG8uGNQh/8Dzft?=
 =?us-ascii?Q?KVfLBYKPYnvB0vg57gudLJENocqbdeucC0vNCu9JIm0zzFZVIgklXI1f2uxU?=
 =?us-ascii?Q?J18f5BoLT5NC2vuHRINnIIMGTUtVNEj+67ky4kBYccI9QVwDkpFqxW7yBjA/?=
 =?us-ascii?Q?ghm+lSqUnC4qwQhKeTICC+00cyoA3vLoHFAnx5e98VTW95YlWYIHRNxF+wLB?=
 =?us-ascii?Q?JlAaZf44aKd9Nc0Imr8WrKUYnyrVG3BVONfkOIWI/ZF/eYzp2wApZwUCY5K8?=
 =?us-ascii?Q?sYZbqVhkPDQpCxBEnFHGEjY50deLkVwXTlLVjXuoOHzzazcZrXi8q7iHlt/E?=
 =?us-ascii?Q?OyVhiy3yEiphqHqhIowsxTID56GAZ4nVwrXFGtItnqw4FPe7+m4IHNGkNi1u?=
 =?us-ascii?Q?WV6hx6ljvAgFlIwibWxNmfnYYiUVDPeJB3UQjJMJGCaPzfRDoCUox4aaE5yn?=
 =?us-ascii?Q?gR5DpiKKYIG1PK+StYxzYKGyZFh1vKzE+5xHk4LKRiv7fRU2OlR17s53Oj0E?=
 =?us-ascii?Q?Vbeh+JfYvx1Yo0QQJ9ESjjxAk+cPEWlZiMnlVj6BCY9WpWpE8p2//tXZl9tJ?=
 =?us-ascii?Q?TAfXlr0euqhs9ftQZBuMLDSzImCW88LSqgLsMDvsm9EPOqIKnQH/EmDdho5H?=
 =?us-ascii?Q?+4+NJ6PMifxHQeLYGNLI5NULpMQaiLntAsxlXR0DwhQsVwaBxRIIqnc0qENE?=
 =?us-ascii?Q?NzBv4VsZ6tTeBpi0SlYvGPiNQAGlPljNx9zOVpzfHR9EQHE7IqPbHwyma7IF?=
 =?us-ascii?Q?Sw61O1un2rzYOF7oAiHitG4w19+7GKAwm63ijOP42A2UODR64pvec5ZpSsRI?=
 =?us-ascii?Q?5HwLP8T09U1JnnozzNuH7Rbjddo4sHGG6o73OFVkYSYJnwmhrsqJwA7IM30l?=
 =?us-ascii?Q?UO/3Qwi7PPqD9L4zC0Lbs+aTKNFn9w6Mh1nAvO5R+MjRMmdt2ymG9EhedDSr?=
 =?us-ascii?Q?vj2oWSmDV+XjfbboftlgdU2rR8ni9TUsHBfjTzK9aeu7eg4DCAXiK/0rImSc?=
 =?us-ascii?Q?uznr/mXdNnVT92exbjJiCpvI+S8htZyC72hQZEMvRd/IRfwz2BgvmWqllG92?=
 =?us-ascii?Q?cvfwEHxZeP+jz1gkDkXRlTAuOHAsc8uYPTRaJwzp30Mra0gABHA9040nWPID?=
 =?us-ascii?Q?VFWTJnjvro4+Fn4IePCu8DsrxbKsT1KVwAQCuj/idg51DlkCKRvnhG0lC5IT?=
 =?us-ascii?Q?K202W9uJVWUZdIuPPuSr60qPaG//En3jH/99sS2moia8FqUnZ+GgOmwIV7B4?=
 =?us-ascii?Q?yaPSUwcUIfgxJT4qZGEnSygwlXhQh4tTrxW6X8I5IFHBBXpQZAa5XkATPrqT?=
 =?us-ascii?Q?oNB1n6uzAHTjYaYD9oHADNJkNdLHFbnYXDWkFK0o5NWzncurv7Jc1WafLaT5?=
 =?us-ascii?Q?Swfiii3TWVTFFUG2ijmGpwZk+PvAYpYPw+Rp/8emthVlW7/I70HCmHUQBFC2?=
 =?us-ascii?Q?3Ojnmwi4OjkIF38PS49Pm9n7J92LUNNyjsyLssHHzjhkH+Ca5EayGFi19svY?=
 =?us-ascii?Q?ijsQLAnoTbGg+lcR3xzAJsVRbLlFEhaLqIgQ3y0hoMnL72HB9YQYoO1f5U9o?=
 =?us-ascii?Q?MqxivIh2Ye1ihcGqDpKlW0cU2Q7y4YXSJ7ZtMV2rjuwM32Q2bs8Lzuu9Iyei?=
 =?us-ascii?Q?XEE/Ml+VdEnNCXJKzX/hbkNU1ZFKGLZeNYFsIE1Ny6Tz5cUdKjoj11oOPvmD?=
 =?us-ascii?Q?KlxLWw0fVJ0rd849/SYvkoutWF5SWp28kmGaz1eDuQbJctZ8JLdb+Th7GcCJ?=
 =?us-ascii?Q?MEqYpvi8YQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f26d807-f7f0-4b05-9b9d-08da4dd32128
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jun 2022 06:57:21.5782
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BOyUNQTpy/agK24wc/9M0qktHu8E3n4E/xKZKoxspRnxTj49QU4hms+uzPT+huETQuVTp/ZO50/lfeltqjnncw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB5562
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Lu Baolu <baolu.lu@linux.intel.com>
> Sent: Tuesday, June 14, 2022 10:52 AM
>=20
> When the IOMMU domain is about to be freed, it should not be set on any
> device. Instead of silently dealing with some bug cases, it's better to
> trigger a warning to report and fix any potential bugs at the first time.
>=20
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Reviewed-by: Kevin Tian <kevin.tian@intel.com>
