Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5001C49A88E
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 05:13:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1319414AbiAYDIu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 22:08:50 -0500
Received: from mga04.intel.com ([192.55.52.120]:35763 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1355137AbiAYCSj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 21:18:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643077114; x=1674613114;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ysCdau5dfWoCYdKfXE6D2rnxKwA3nLjvIEkQ5UFTDO0=;
  b=faCWLxH419WUSzxj7cLKwT2/lM+OgTM+rRR8cC61BsrUJuGhVYepHJWg
   V5ek375lLNNiFC0V/dz3X8PbyzkQqI75VQMNmdV5HhCfom1XhhYEpzH38
   lyMRhsQ/7hlzfjN+aeZsqo5HoGRbhKzXwQ9qd1tHa4f1M+KP42eg/lAPL
   e1PeAMzdfBchrMahlAfOoRE8PLe3xIpN8dX6o26sDcT8Okif3z8ng7WmA
   vE1ffJsaSKbugfp+30ZI6kZiugL0Xylss1c1Qkl6GM3OXKtxE1Uv3hND2
   7gUP/AmEpWbvG0rdRHAf9srmby7OGN1UN+kxYvvxhlezxeE5XPThrdVbL
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10237"; a="245023604"
X-IronPort-AV: E=Sophos;i="5.88,313,1635231600"; 
   d="scan'208";a="245023604"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jan 2022 17:11:04 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,313,1635231600"; 
   d="scan'208";a="532265181"
Received: from fmsmsx604.amr.corp.intel.com ([10.18.126.84])
  by fmsmga007.fm.intel.com with ESMTP; 24 Jan 2022 17:11:04 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx604.amr.corp.intel.com (10.18.126.84) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Mon, 24 Jan 2022 17:11:04 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20 via Frontend Transport; Mon, 24 Jan 2022 17:11:04 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.177)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.20; Mon, 24 Jan 2022 17:11:04 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m31iZO2y/lMub1hKdK0M8WDlg5EnP3xagxme7n8+sQwHqqJqWKNg2oFQvO5N7biX5dAQg16mAIofBYOO/0zx6MvgKOjdGHomLe8fS7MqmTlkV7AZgJJm0q9VOVUbKonAMKRMIHHlYs5v61h9RQQQE47DdKaFcLmdIXlrV1rU8It5fuw52iiAUhCp/36q0ZR1tw9X9yCs3bukihSSy3qWOHvOElEJm2bwIfG1V47xZaqtu83QPiXt4jsTjfUrWL5qGmfrwWFSsJDIJZQtTLE58RtWp4y9JyPEQbhzCN9HJ4Eq4rpEP96f0+SMNZMzARfbVWgW0nnLkghlfjcXjS6uTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=or7mcvbCLZco9G19PQobCSITQBKP7ViYJuRbDDS7phQ=;
 b=JPtRBBhM0mb73ZW9mDzMQQJpW0uFk/5r7SdnC0E6OluE64ChJDOb6YnXHMTqf2X4ko9CSh+PahHLsJY+5aRudcQ4hD3LYSRpdGaQj/7yviFd8vs8GoyWKE7mPJa4LAzdc5BOPjRhhohpbn2U/xNoJoX8MKvx7JbRtaFbQWP51ePT+AF8ttIsKp23+RgLoE4qx3cz92A+LD+Wdec8o5KFXd+zrtvPauqbO/AzUAqFj2OAR4Eoz8u65QzPtzI/dSB98BD1mwIvGHpi0wLWfS/ChUmBzPV0Yr+85vvtkLi+hvyUB+a7FDlZymj6qQKX+cFp2ab8o7j/NvK3H/8NVa5wqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by DM5PR11MB1724.namprd11.prod.outlook.com (2603:10b6:3:e::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4909.12; Tue, 25 Jan 2022 01:11:01 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::e46b:a312:2f85:76dc]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::e46b:a312:2f85:76dc%5]) with mapi id 15.20.4909.017; Tue, 25 Jan 2022
 01:11:01 +0000
From:   "Tian, Kevin" <kevin.tian@intel.com>
To:     Jason Gunthorpe <jgg@nvidia.com>,
        Lu Baolu <baolu.lu@linux.intel.com>
CC:     "Raj, Ashok" <ashok.raj@intel.com>,
        David Airlie <airlied@linux.ie>,
        Robin Murphy <robin.murphy@arm.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Christoph Hellwig <hch@infradead.org>,
        "Alex Williamson" <alex.williamson@redhat.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Ben Skeggs <bskeggs@redhat.com>,
        Daniel Vetter <daniel@ffwll.ch>, Will Deacon <will@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Pan, Jacob jun" <jacob.jun.pan@intel.com>
Subject: RE: [PATCH 6/7] iommu: Use right way to retrieve iommu_ops
Thread-Topic: [PATCH 6/7] iommu: Use right way to retrieve iommu_ops
Thread-Index: AQHYEPHSpa6rqOl4/k+RfGCHsL5bBqxycAsAgAB8WRA=
Date:   Tue, 25 Jan 2022 01:11:01 +0000
Message-ID: <BN9PR11MB5276232DDAFC8041D5E795DE8C5F9@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20220124071103.2097118-1-baolu.lu@linux.intel.com>
 <20220124071103.2097118-7-baolu.lu@linux.intel.com>
 <20220124173650.GF966497@nvidia.com>
In-Reply-To: <20220124173650.GF966497@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b93f7806-13a2-4ffc-af94-08d9df9f8d7f
x-ms-traffictypediagnostic: DM5PR11MB1724:EE_
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-microsoft-antispam-prvs: <DM5PR11MB172435153CD77E1698A7D4AC8C5F9@DM5PR11MB1724.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: cWzTO2VHl1lNL1HcjE+uArfJZy3Ei6yGzXBCR4wXsydicxBxFJO1lEOwMSxv5xZBWfWIY/q3LSMYVDLfs27cC/6Le9ceNVhdBXQnPnFJB64XC1QKOjW9iJkcHQhWK3CkFsKqN9s3tXm9REm1632VVA05voX2oOZok3GYP7fTy1Vl2UI05TNjNWIIM6KVN6onBH7mFwZnYwWIokUjif+OemZXin5RL04QJ49KWLbbr5u2t6vOACX97gZGzA9hP/ZzOgjy58yjpOo5YEyqcdRfsioeaCjPxL74QMXDLS5KFs0d6pcHk4RdRvmPWumclNgvb0n7gLYL8Ns1FP9DvxhH4k8ezA3hPqgpUKE2QTD7c4iWXheOaSt9ZWzMHcIYg5Cz5f9Lzkq6QPrPEhf9xLVvjxlTuMHHXR1xWhbbir1pgdA83cwoMvLzWTrbKq2uBYWsvj63NbzeOYgSys3j6Urq79DauLXRLT6tFAxbUJRFt7+P+n5Dr8IszhuHLqdOuDOM5bJd8nZDb/Zk9fLKbBrmkcTEsjHtNOmnU8kChjJIFmDbDYDrdwE7OC2FBUJV+FjTfbAj+1KVUj/6HLb3jgI5iDrNCaL+rE/JI2jiDVY9Gx3v53xWwd6WmFBb88gG6fDjn2eRntjJsrys7l7o5wQL3cOk6evbIL/Y/97AvzL0Vq9LFSPCuKmEKtTdub+cDdt/apvrC5ybr6I9fTq+gly3U1MvqhmDm82QPPeJh+AYh/U=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(38070700005)(86362001)(6506007)(64756008)(8936002)(38100700002)(316002)(508600001)(52536014)(110136005)(7696005)(33656002)(9686003)(7416002)(2906002)(186003)(4326008)(54906003)(71200400001)(66556008)(66946007)(8676002)(5660300002)(122000001)(4744005)(82960400001)(66476007)(66446008)(76116006)(55016003)(26005)(43043002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?eZvf0qAB0m3+WkmEdlTnYH/3K6emlpn4GbX1y9NjA6sPpUkAWR0p/m+IcV6C?=
 =?us-ascii?Q?yeJJ7vr+ZE1+qtGeydNqmLFRXkiTEGkGfh/NWpY0oNCRRGPKBVctos51KbSE?=
 =?us-ascii?Q?oT8JNwl6HgnyruHc8/SyK0gdz2yofJ0s/5/LiKvkn9+IJwasCtCu+RkoGTEj?=
 =?us-ascii?Q?xBlTo0ySr0svHFKdGFa88chifF/vS4lyvVuG2X8j53aHNZ1MUgo4/S4UO+/a?=
 =?us-ascii?Q?Z9YgoOIqHLfuk/JtJow/OdoaW0AIcXZ7vVPOOLarUlZZ/IH3btZNdyZG8Iab?=
 =?us-ascii?Q?3Klwb5LrWUV58iMZfAOTL9IKxkzWMy1MvzSqdZEC/x8e7yf2RkzgMvLzoKx+?=
 =?us-ascii?Q?PabvA+n0Hkm305THe5Xn1nv1eLYTOr8O/HaNpCkC6NP6mEckbKvXiJBbRM61?=
 =?us-ascii?Q?Jh7eNI2HGNSNdOjCvlJQnUkfeBxChnV7eehENg1Z3ztu+RbvfODnr2y8xL4X?=
 =?us-ascii?Q?/OCfIUCUBxyBmAIgiUPlLW2LZDKwlr8EXXb7sGmZhT9fyhlWP04upFFwE6ux?=
 =?us-ascii?Q?XtpoJ9ceaFNGolvmSgoBlzu3027uiWoOf5qG2Bc6aUhb1cEyuamMeosYTcvq?=
 =?us-ascii?Q?T/60AwvukovSA58R2fgQExat0LmbrwiXpD/ibz6pIvFTeX42kXcWaoEwgy3l?=
 =?us-ascii?Q?4QdVvzAEdq14aZAe42c1mcztT0XuBXYIxIZC6X9ixcotE6m2hbMptY+mRYXQ?=
 =?us-ascii?Q?I8UZn0yy38kZ80qT6wut8qLphqso1DAIG65UmbxNqBW1gK+MzpZoHjWbXC/x?=
 =?us-ascii?Q?rnNeky07YoSxTqUwb5lvK0mXO1rqrAF35EcB6btM6doy54smnuDol5sTcLAT?=
 =?us-ascii?Q?1JBrvueDzNDCjgKaaCahoOJ42ZfQHj+SQ2CwTfofkOKUwsjv4vCh6hgZrPaB?=
 =?us-ascii?Q?B8/8awhXIoWAFWv891vpgw+1X0NovuPxbxHfC89HYcxUbjvstkYWjYQ6WT8i?=
 =?us-ascii?Q?M3gi6K0jUmQf4hXIVVYJ3vyp/2fWYoPYTDbp5HDozv7m1I1ZndudVZhJN8kp?=
 =?us-ascii?Q?8YhMliElWXj3xBwf646AEN01gX9O/S20VkgHcAG0RruH1Mexxvh1a1LIPaV+?=
 =?us-ascii?Q?ZC/JK4uS7Tnc0r62Ksp5nHXEuMf9WkSedEdBVT6Vx1wLsKhxjjCDSgZJxs3U?=
 =?us-ascii?Q?qaaLinvx6aKdyZb8nFcROG/GdzITJm37CbGZS0Qv/rrGuldVFwGFWCvbxr7v?=
 =?us-ascii?Q?uRJLfvaJGf5p+bOXoJNhNNtxpCGV48T2xG3/Zf6HYtzaRc995CzEVfOZ4Uth?=
 =?us-ascii?Q?qH59nUVywp6Lh+lKCgOaGzB1PyyEk60CQWhxQTNiU6P8JUZ2WetT+smvbOlu?=
 =?us-ascii?Q?D+zTs8VUT/+2oamPI2r5MmpuNPIu0kfAcm5dhLf7cc8j//jXx20nXOpmJKOU?=
 =?us-ascii?Q?BngAFjHWE4+SU/uQGDBVbHxS1LI21ytcg4eTa3s1UXS5zJPGOjzV4I67Ssy4?=
 =?us-ascii?Q?6uexye0murKfGvNPZZlHLc9I9/bgL+Y+dNaNqav09NURMP9DW7gPgV/p1LcY?=
 =?us-ascii?Q?GSeJrO0A3b4xYIALQupGYkt9y+jUZ7XE+OCJi4BuJRTj3iAI1iC3qYCYXV4M?=
 =?us-ascii?Q?WzRCfuYmuibxO0PGgK6vk/nYNdShdpyTzmvpy7AmOPKsuiGgkdO7SP/NbasF?=
 =?us-ascii?Q?6qvskmV7Q+ZY+3+kzIntdK0=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b93f7806-13a2-4ffc-af94-08d9df9f8d7f
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jan 2022 01:11:01.4879
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Y05rF5TGtqjpafwGclvkszUYCLjJzh7lOpQlmPMCKqXJF82bpiHzPNj8yM4+WdtsL8zc/q92Z8N6XzDL0Jt+qw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR11MB1724
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Jason Gunthorpe via iommu
> Sent: Tuesday, January 25, 2022 1:37 AM
> > @@ -1295,7 +1298,7 @@ int iommu_page_response(struct device *dev,
> >  			msg->pasid =3D 0;
> >  		}
> >
> > -		ret =3D domain->ops->page_response(dev, evt, msg);
> > +		ret =3D ops->page_response(dev, evt, msg);
> >  		list_del(&evt->list);
> >  		kfree(evt);
> >  		break;
>=20
> Feels weird that page_response is not connected to a domain, the fault
> originated from a domain after all. I would say this op should be
> moved to the domain and the caller should provide the a pointer to the
> domain that originated the fault.
>=20

In concept yes.=20

But currently the entire sva path is not associated with domain. This was
one mistake as we discussed in the cover letter. Before extending iommu
domain to cover CPU page tables we may have to leave it in iommu_ops=20
given this series is just for cleanup...

Thanks
Kevin
