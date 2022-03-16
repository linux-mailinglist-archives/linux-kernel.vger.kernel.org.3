Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C4054DAE49
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Mar 2022 11:33:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355150AbiCPKeR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Mar 2022 06:34:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237750AbiCPKeO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Mar 2022 06:34:14 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECAC2BC2A
        for <linux-kernel@vger.kernel.org>; Wed, 16 Mar 2022 03:32:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647426777; x=1678962777;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=sabdMcTrDC4nyTcHRlGybdxbVvSgnRYSHZqMVHP42UQ=;
  b=RBEHTK5o9dF9mbvvUWWo8OTrHoVYMG3xO3ZsHFIX1MpZuNo+sdLt+7XK
   3SPFkDjwjXiQKe62FClYD1FsBocmXsybi1Fhl0mTvR6C5EBIz+uKAC6ut
   ANfmCl1T+brs68eBR/ovaxhOtj3tBBBTG+2yy/dV5vNSAeQ6NOKXFB26E
   5ufRcWP+QuOn/plZ/yCUxob8HSHt4Eg8YxIQkWRXkWUXguxxbR1feGHIh
   /Zrht3sWGRyKAdC0Q1W0Zkaayp/tYPHeDznbFERwoltqL2TYoBTYL0zkG
   y5+sqYcjblj2uA6FuPQ5DKYOCLUtJJ+TcKXCMdgSx4YqLdiuHW5tEPVHw
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10286"; a="281324965"
X-IronPort-AV: E=Sophos;i="5.90,186,1643702400"; 
   d="scan'208";a="281324965"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2022 03:32:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,186,1643702400"; 
   d="scan'208";a="580857915"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga001.jf.intel.com with ESMTP; 16 Mar 2022 03:32:56 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Wed, 16 Mar 2022 03:32:56 -0700
Received: from orsmsx606.amr.corp.intel.com (10.22.229.19) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Wed, 16 Mar 2022 03:32:55 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx606.amr.corp.intel.com (10.22.229.19) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21 via Frontend Transport; Wed, 16 Mar 2022 03:32:55 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.174)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.21; Wed, 16 Mar 2022 03:32:55 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PKc+S9nTiW6ylA0vaV7Y0hzi37uH20n3tzDynh9wVeyv/9uYN/N3DgdGsfBNb4OxTv7IN1hy28kDIoHB9h2T4QWEM6Tb7ynJNpJHHik2Rbk8PRT2jcXN7FZCK5mUIHJImP7kFfVJQswSvmnhTt4iEu4RFidFPq8yFMLQ0rMGb/6A6MaNXwyIKYgV7yk1e21R0kLfrdid2P1YWgPdT/g8THv3NgPlK7g+FKuTIaOuBR4kBPG2Pad5BrVFuryquinDoZCwNuPyRXjul7s7se3L9xDjaT+yT2E5BpYiYXhArifhUhchi+76CP4yGpEePg6fl0S1T+9t4mq9mTja8qK9QQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sabdMcTrDC4nyTcHRlGybdxbVvSgnRYSHZqMVHP42UQ=;
 b=ka1Ojtq4W5TFsqRLgnn24KBnCquuubhTMP2EridiqPWTICMrs6XP0y11wikiK7/vrYBgMb1zm4gzMq4T39byLWl2dw8YjMQeCx6Kf5lq6K8OeHzqs+4a9GDHJ5pZ2chKdsuVrgOcocrHf7NNV0mQBS3GenTh1S7NqIi0yAM2QlPDgtcjWAmBGjJ1a/gfoypNjHdp0iNn5d89ct6yd8jjkdLCK0LS4NJcHyj7HEdlDep6Jmik9LfyV8p2VMbxf2Ly6jEzjUV6pALZuilVReKyXJNItuidZ9ZIeh0jNkzCLlFYPrXREn+BvVLFwJm+mDpRUhTKSYOOb+/ZHUgXbX66zg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by BL1PR11MB5496.namprd11.prod.outlook.com (2603:10b6:208:314::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.14; Wed, 16 Mar
 2022 10:32:53 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::c8aa:b5b2:dc34:e893]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::c8aa:b5b2:dc34:e893%8]) with mapi id 15.20.5081.014; Wed, 16 Mar 2022
 10:32:53 +0000
From:   "Tian, Kevin" <kevin.tian@intel.com>
To:     Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Jason Gunthorpe <jgg@nvidia.com>
CC:     Robin Murphy <robin.murphy@arm.com>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Joerg Roedel <joro@8bytes.org>,
        Christoph Hellwig <hch@infradead.org>,
        "Lu Baolu" <baolu.lu@linux.intel.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>,
        "Luck, Tony" <tony.luck@intel.com>,
        "Jiang, Dave" <dave.jiang@intel.com>,
        "Raj, Ashok" <ashok.raj@intel.com>,
        "Zanussi, Tom" <tom.zanussi@intel.com>,
        "Kumar, Sanjay K" <sanjay.k.kumar@intel.com>,
        "Pan, Jacob jun" <jacob.jun.pan@intel.com>,
        "Williams, Dan J" <dan.j.williams@intel.com>
Subject: RE: [PATCH v2 5/8] iommu: Add PASID support for DMA mapping API users
Thread-Topic: [PATCH v2 5/8] iommu: Add PASID support for DMA mapping API
 users
Thread-Index: AQHYOCoa8qozHAC5REKbTKib7rW4dazAS/aAgAAz2gCAACQhgIAACV+AgABIdYCAANPX0A==
Date:   Wed, 16 Mar 2022 10:32:52 +0000
Message-ID: <BN9PR11MB527628E067B47D499EA167228C119@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20220315050713.2000518-1-jacob.jun.pan@linux.intel.com>
        <20220315050713.2000518-6-jacob.jun.pan@linux.intel.com>
        <00286dbb-fe73-3604-4dec-340eb91912c3@arm.com>
        <20220315142216.GV11336@nvidia.com>     <20220315093135.5c11066d@jacob-builder>
        <20220315170507.GH11336@nvidia.com> <20220315142427.21687ac2@jacob-builder>
In-Reply-To: <20220315142427.21687ac2@jacob-builder>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e1d84f5b-ef11-4a81-b883-08da073853d3
x-ms-traffictypediagnostic: BL1PR11MB5496:EE_
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr,ExtFwd
x-microsoft-antispam-prvs: <BL1PR11MB5496F693E026A7479E6B2D658C119@BL1PR11MB5496.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: DQ7UMbL7Y/uQtfQpWU66aQ3/iPOCGPg09MTVlQKWOR3JVjrs8zV/+5ugi8LkU+n5M227lX0FZ4PrR6Fxj3Oy+xOQIL6P1l+OgxDnc+ESR9qxs1D5K9mQElaR+oRe6sMfrqTZv4lVqW4jI9T5GbOOMKQrJI9BVWOHaQALkcgF4oE9ExiSSNDhW4P9A2QFPqTvYDnr/tHmHPKlnq1T+QV1wEru7Jo6SgUCm68en0mAxy606ZjLjENc4DCHQXoRl/OumOLhbrLc/5ZzPqxLfbIcuiabFbtXkzhmDV/XNVlq996PmcbIIeCj67+DyJuHnIi0UyDDUWeDBTEzjtLn2S60vegVmJUeP0Y3r9yYDjwzTqyYXyn5zLqZR8N/+SuIaV3N5wSadpKh4yN0+jto4EEagZKYq+jXkfH9QQIPwHH/rWMhfwA5P7293JjYcU6xguaIHxTk9BsTojclrJtdWzEbRuUtxoutJp/LYhANQGVRkcSyarfN/XvCZu30kA7vxFkNZEvyMun+AVaMTT//fI7mcTsOSYw1yAIvjcWlrcHeTHtGl4Ry3Mab+YHRamuQGYgV0ZR5pDFA36yBsqKpnh/2wDW5GMvBMGHkEz5EAnqEkv+rus1mycfwQwn56/s4u8z10yifNhNgvMXlctKpusXbNUYQwxBHjH3aTWZA56YwIMnO1E88Xu/aX59zUKt2h8NNINqjyb7eegSFUqn7prqM27ut239IFdXfci9O/CXarItBwIh+tHoqKjn5eX+L/3aSylD4Vs9gPmPRD2r6r25tMw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(86362001)(33656002)(82960400001)(122000001)(7696005)(6506007)(38070700005)(4326008)(76116006)(8676002)(55016003)(66476007)(66946007)(66446008)(66556008)(83380400001)(38100700002)(64756008)(54906003)(110136005)(316002)(9686003)(26005)(186003)(2906002)(71200400001)(508600001)(52536014)(8936002)(5660300002)(7416002)(26730200005)(19860200003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MExxNVp4K0N0NW10ZWxNaXRpSkRtUkROUXJnRDBCRTVGOEp5Q3oxRlRYeW1z?=
 =?utf-8?B?SW83cFJGS0VwRTI0TXpiVkxYdWhuSDFUNnJyWmhHZDhvaUs5eUdQMkJWd1FY?=
 =?utf-8?B?eDZVWitMNVdxbld1RVM2Q2Zad3d3UjhyN2cxWHQ2QzhZM1JRdi9OZFd3cmgv?=
 =?utf-8?B?SXdHSkJETzhyTkcrYzJzaEg4bHo1alQvcE9RR0o5S3FHWExmT3RCZGtSaW9G?=
 =?utf-8?B?c3U0NUo2SVdGSWtwQTdtZDNDZmdLWUViVFRJRGthNjVVRzJFV2p3S0pGM0Vn?=
 =?utf-8?B?TVRLNG8ySkdIZ2NjSWx2cjVScFlYVE82a1k1RUp0VU1qSktHWkJaU0pTK21B?=
 =?utf-8?B?LzJQVlJCckpYQTd1UzRFQXhzUTM0WUdLVVJseGpkUVlqTEtQaHJZaFpUSUtT?=
 =?utf-8?B?Rll3RVJzUmhGeFM1ZmdXS3VjQVBaNGxEV3YxR0FZVk9MWUxDVk1sbnl2VkJo?=
 =?utf-8?B?VzFlY3NIRFhkOWJ3TG1CdFllbDN0akNQTHZDbGRDWnAweDRUQXlvU2RHeUdm?=
 =?utf-8?B?ZEd4aXlQY2Y5QmRtd21HOGZGdGJnWHF3SFdOM3ZxWEFFL0R2SlpqdVk3OHBL?=
 =?utf-8?B?Mm9nNVpyaERtelFlQ2pnWEVqVFQwN0k2R2J0WU5mbGdTcjNlSU1LZHdqN3Yv?=
 =?utf-8?B?YktjekJHQjV1TVQ1eEJuL2hmL3ZKbFZMQWFCb0VJZEZZQUZjeVlEaFM5NEZt?=
 =?utf-8?B?ZnFhVnB3TFpsV21JVGs4UDNETW9CWUptNFZ5czBoVzY2S3RzTERteUVXdERq?=
 =?utf-8?B?Sm1rb25iSHVhZytPeUZERkRjbjFTOHo5MWJ3WDd3TndLQWlXMDZVdCtWUEla?=
 =?utf-8?B?MGhmV0ZRSzZkNXRPd0UvRmk0NFFLODAyWlJheHVKWURmOUNZWTRiRDhsQlRE?=
 =?utf-8?B?Zy9JT2NwckRiZDVUR3RtbTcrSkNsT2JYbTNvZms2WklYZFVUU2Q0ZGdZOGI4?=
 =?utf-8?B?UUxGejkwVjFyMFJ3cG8zM0F4bHZrQ09Vb3hENnEvWi9GMkRDQks4WFV3UXYx?=
 =?utf-8?B?WUUwM2JFQnhkRDdGYTVHUW1tMGhXQXlCZGJqVlg0a1pvTXlJSFBZOGV0UzR4?=
 =?utf-8?B?ZEVIVFh2VzNkMUZyaHc5Q3pYUVJWcGtCRnNLNk9lNWRYYVc0Q002TmtQdGdD?=
 =?utf-8?B?WGRmTXFlVzRmSHVlS1k3YUhucWQwVVVjZTBsZ0Z0NTlCaDlsZDRPSXZkRndF?=
 =?utf-8?B?WUwwSWFnVVduaEp2NGovTDQ2Q0RuTitaY3ZxVHUzSEhJNFhQWjE3c2g1c01Y?=
 =?utf-8?B?TUNPVXZhNm8vdHdoZXRzOVBWSi9MUElDWkEwSkM5Z3ZTR3ZEekdiWEEyek9t?=
 =?utf-8?B?ZlgvbjdnSm9ieGF4RUEzZ052L3gxZVdKOE45VVpybElKNTYvRXZXNXRZREFM?=
 =?utf-8?B?UW9DZUw0UHYxa2NVQlRCeDh2YzVMM3ltQVoxZWxWM3BvVDc5NkFIMlg1M1pr?=
 =?utf-8?B?ZUFZZjdyTWV3L0NaaXE5SmxQeWFDejJwenRPWi9TTE1xQ0UzNkhibFZzT2JC?=
 =?utf-8?B?Ri9lZEY1bWt2NEQ5YnVsL1JPZFgvT3lFZFpHUTZDOUZvbG16UitiWi92aVpr?=
 =?utf-8?B?cVNKRlUwMjAvcjBsK2VuOWFYR2ZOTGZJS2wreG9INDJZVnZqWnR1WjhLdFhX?=
 =?utf-8?B?VlhuYXQrNVRoR2VJeEtLNzAxaTVYVEtnZjRIVmFWNlJVVWFJYkVXMW5WVnQ3?=
 =?utf-8?B?bUNIWTFVY3d2S2VPMHh1M1hTS0l3RFhrRXFwZUpOWlFRdU5PbDFEN1VmNXJt?=
 =?utf-8?B?THJ5UFArRmNkRlkxOUV2aXh3VGVYNFVDcGNRMFJwVU1nanhjUi9jc0E4bFY0?=
 =?utf-8?B?ZmZ3UzNSc3NueExIU0lFVldxUjMwNHJVRFFQcVRUQXdIVEpvdVJ1UkR2endE?=
 =?utf-8?B?Yis5aDJ4enMvTm50LzZNbEJVS3VhNUk0L09vZnVmeUZGWlFHc2llS3BEL1VL?=
 =?utf-8?Q?ehf79LoaNbxrxdDtccdM9gFovSOgTvUF?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e1d84f5b-ef11-4a81-b883-08da073853d3
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Mar 2022 10:32:53.1031
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: y52vuLnbsh9QTfJFb7ThHL4ezldlv2yvD1nn966VjJAmZrlQ4923vPQKDhwrmbmZu7+8WYgcfOb1oOFiViNhAA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB5496
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBGcm9tOiBKYWNvYiBQYW4gPGphY29iLmp1bi5wYW5AbGludXguaW50ZWwuY29tPg0KPiBTZW50
OiBXZWRuZXNkYXksIE1hcmNoIDE2LCAyMDIyIDU6MjQgQU0NCj4gDQo+IEhpIEphc29uLA0KPiAN
Cj4gT24gVHVlLCAxNSBNYXIgMjAyMiAxNDowNTowNyAtMDMwMCwgSmFzb24gR3VudGhvcnBlIDxq
Z2dAbnZpZGlhLmNvbT4NCj4gd3JvdGU6DQo+IA0KPiA+IE9uIFR1ZSwgTWFyIDE1LCAyMDIyIGF0
IDA5OjMxOjM1QU0gLTA3MDAsIEphY29iIFBhbiB3cm90ZToNCj4gPg0KPiA+ID4gPiBJTUhPIGl0
IGlzIGEgZGV2aWNlIG1pcy1kZXNpZ24gb2YgSURYRCB0byByZXF1aXJlIGFsbCBETUEgYmUgUEFT
SUQNCj4gPiA+ID4gdGFnZ2VkLiBEZXZpY2VzIHNob3VsZCBiZSBhYmxlIHRvIGRvIERNQSBvbiB0
aGVpciBSSUQgd2hlbiB0aGUgUENJDQo+ID4NCj4gPiA+IElEWEQgY2FuIGRvIERNQSB3LyBSSUQs
IHRoZSBQQVNJRCByZXF1aXJlbWVudCBpcyBvbmx5IGZvciBzaGFyZWQgV1ENCj4gPiA+IHdoZXJl
IEVOUUNNRFMgaXMgdXNlZC4gRU5RQ01EUyBoYXMgdGhlIGJlbmVmaXQgb2YgYXZvaWRpbmcgbG9j
a2luZw0KPiA+ID4gd2hlcmUgd29yayBzdWJtaXNzaW9uIGlzIGRvbmUgZnJvbSBtdWx0aXBsZSBD
UFVzLg0KPiA+ID4gVG9ueSwgRGF2ZT8NCj4gPg0KPiA+IFRoaXMgaXMgd2hhdCBJIG1lYW4sIGl0
IGhhcyBhbiBvcGVyYXRpbmcgbW9kZSB5b3Ugd2FudCB0byB1c2UgZnJvbSB0aGUNCj4gPiBrZXJu
ZWwgZHJpdmVyIHRoYXQgY2Fubm90IGRvIFJJRCBETUEuIEl0IGlzIGEgSFcgbWlzLWRlc2lnbiwg
SU1ITy4NCg0KV2VsbCwgdGhhdCBtb2RlIGlzIGNvbmZpZ3VyZWQgcGVyIHdvcmsgcXVldWUgYW5k
IHRoZSBkZXZpY2UganVzdCBwcm92aWRlcw0KZmxleGliaWxpdHkgZm9yIHRoZSBzb2Z0d2FyZSB0
byB1c2UgaXQgZm9yIGEgcG90ZW50aWFsIHZhbHVlIChzY2FsYWJpbGl0eSkuIFNvIGluIA0KdGhl
IGVuZCBpdCBpcyBhIHNvZnR3YXJlIHF1ZXN0aW9uIHdoZXRoZXIgd2UgY2FuIGZpbmQgYSBjbGVh
biB3YXkgdG8gbWFuYWdlDQp0aGlzIG1vZGUgKGZvcnR1bmF0ZWx5IHdpdGggeW91ciBwcm9wb3Nh
bCBpdCBkb2VzIPCfmIopLiBGcm9tIHRoaXMgYW5nbGUgSSdkDQpub3QgY2FsbCBpdCBhIG1pcy1k
ZXNpZ24gYmVjYXVzZSB0aGUgc29mdHdhcmUgaGFzIG90aGVyIG9wdGlvbnMgaWYgdGhlcmUgaXMg
bm8NCndpbGxpbmcgb2YgdXNpbmcgdGhhdCBtb2RlLiBFdmVuIGluIHRoZSB2aXJ0dWFsIElEWEQg
Y2FzZSB0aGF0IEkgZXhwbGFpbmVkIGluDQphbm90aGVyIHRocmVhZCwgdGhlIGFkbWluIHNob3Vs
ZCBub3Qgc2hhcmUgd29yayBxdWV1ZSBiZXR3ZWVuIFZNcyB1bmxlc3MNCmhlIGtub3dzIHRoYXQg
Z3Vlc3QgY2FuIHN1cHBvcnQgaXQuIE90aGVyd2lzZSB0aGUgYWRtaW4gc2hvdWxkIGp1c3QgZGVk
aWNhdGUNCmEgd29ya3F1ZXVlIHRvIHRoZSBndWVzdCBhbmQgdGhlbiBsZXQgdGhlIGd1ZXN0IGl0
c2VsZiB0byBkZWNpZGUgd2hldGhlciB0bw0KdXNlIHRoZSBzaGFyZWQgbW9kZSBjYXBhYmlsaXR5
IGZvciBpdHMgb3duIHB1cnBvc2UuDQoNCkFsc28gaW4gY29uY2VwdCB0aGUgSU9WQSBzcGFjZSBj
cmVhdGVkIHdpdGggRE1BIEFQSSBpcyBub3QgZGlmZmVyZW50IGZyb20NCm90aGVyIEkvTyBhZGRy
ZXNzIHNwYWNlcy4gVGhlcmUgaXMgbm8gYXJjaGl0ZWN0dXJhbCByZXN0cmljdGlvbiB3aHkgdGhp
cyBzcGFjZQ0KY2Fubm90IGJlIGF0dGFjaGVkIGJ5IFBBU0lELg0KDQo+ID4NCj4gPiBTb21ldGhp
bmcgbGlrZSBQQVNJRDAgaW4gdGhlIEVOUUNNRFMgc2hvdWxkIGhhdmUgdHJpZ2dlcmVkIFJJRCBE
TUEuDQo+ID4NCj4gVGhhdCB3b3VsZCBzaW1wbGlmeSB0aGluZ3MgYSBsb3QsIGl0IHdvdWxkIGJl
IGp1c3QgYSBkZXZpY2UgY2hhbmdlIEkgdGhpbmsuDQo+IEZyb20gSUEgcG92LCBvbmx5IEVOUUNN
RCB3aWxsICNHUCBpZiBQQVNJRD09MC4gSSB3aWxsIGJyaW5nIHRoaXMgYmFjayB0byBIVw0KPiB0
ZWFtIHRvIGNvbnNpZGVyIGZvciBmdXR1cmUgZ2VuZXJhdGlvbnMuDQo+IA0KDQpNYXliZSB5b3Ug
Y2FuIGhhdmUgYSBxdWljayB0cnk/DQoNClBlciBTRE0gQ1BVIGRvZXNuJ3QgI0dQIG9uIFBBU0lE
MCBmb3IgRU5RQ01EUy4NCg0KQWxzbyBJIGRvbid0IHRoaW5rIHRoZSBkZXZpY2Ugc2hvdWxkIGRv
IHN1Y2ggY2hlY2sgc2luY2Ugd2l0aCBSSUQyUEFTSUQNCnRoZSBhY3R1YWwgUEFTSUQgdmFsdWUg
dXNlZCB0byBtYXJrIFJJRCByZXF1ZXN0cyBpbiB0aGUgSU9NTVUgaXMgDQpjb25maWd1cmVkIGJ5
IHRoZSBpb21tdSBkcml2ZXIuIEluIHRoYXQgcmVnYXJkIGl0IGlzIG5vdCBjb3JyZWN0IGZvciBh
bnkgDQpoYXJkd2FyZSBvdXRzaWRlIG9mIHRoZSBpb21tdSB0byBhc3N1bWUgdGhhdCBQQVNJRDAg
aXMgZm9yIFJJRC4NCg0KVGhlbiB0aGUgb25seSB1bmNlcnRhaW4gdGhpbmcgaXMgd2l0aGluIFZU
LWQuIEluIGEgcXVpY2sgY2hlY2sgSSBkaWRuJ3QgDQpmaW5kIGFueSBWVC1kIGZhdWx0IHNwZWNp
ZmljYWxseSBmb3IgYSBETUEgcmVxdWVzdCB3aGljaCBjb250YWlucw0KYSB2YWx1ZSBzYW1lIGFz
IFJJRDJQQVNJRC4JDQoNClRoZXJlIGlzIG9uZSBpbnRlcmVzdCBwYXJhZ3JhcGggaW4gNi4yLjEg
KFRhZ2dpbmcgb2YgY2FjaGVkIHRyYW5zbGF0aW9ucyk6DQoNCiAgSW4gc2NhbGFibGUgbW9kZSwg
cmVxdWVzdHMtd2l0aG91dC1QQVNJRCBhcmUgdHJlYXRlZCBhcyByZXF1ZXN0cy13aXRoLQ0KICBQ
QVNJRCB3aGVuIGxvb2tpbmcgdXAgdGhlIHBhZ2luZy1zdHJ1Y3R1cmUgY2FjaGUsIGFuZCBQQVNJ
RC1jYWNoZS4NCiAgU3VjaCBsb29rdXBzIHVzZSB0aGUgUEFTSUQgdmFsdWUgZnJvbSB0aGUgUklE
X1BBU0lEIGZpZWxkIGluIHRoZQ0KICBzY2FsYWJsZS1tb2RlIGNvbnRleHQtZW50cnkgdXNlZCB0
byBwcm9jZXNzIHRoZSByZXF1ZXN0LXdpdGhvdXRQQVNJRC4NCiAgUmVmZXIgdG8gU2VjdGlvbiA5
LjQgZm9yIG1vcmUgZGV0YWlscyBvbiBzY2FsYWJsZS1tb2RlIGNvbnRleHQtZW50cnkuDQogIEFk
ZGl0aW9uYWxseSwgYWZ0ZXIgdHJhbnNsYXRpb24gcHJvY2VzcyB3aGVuIHN1Y2ggcmVxdWVzdHMg
ZmlsbCBpbnRvDQogIElPVExCLCB0aGUgZW50cmllcyBhcmUgdGFnZ2VkIHdpdGggUEFTSUQgdmFs
dWUgb2J0YWluZWQgZnJvbSBSSURfUEFTSUQNCiAgZmllbGQgYnV0IGFyZSBzdGlsbCBtYXJrZWQg
YXMgZW50cmllcyBmb3IgcmVxdWVzdHMtd2l0aG91dC1QQVNJRC4NCiAgVGFnZ2luZyBvZiBzdWNo
IGVudHJpZXMgd2l0aCBQQVNJRCB2YWx1ZSBpcyByZXF1aXJlZCBzbyB0aGF0IA0KICBQQVNJRC1z
ZWxlY3RpdmUgUF9JT1RMQiBpbnZhbGlkYXRpb24gY2FuIGNvcnJlY3RseSByZW1vdmUgYWxsIHN0
YWxlDQogIG1hcHBpbmdzLiBJbXBsZW1lbnRhdGlvbiBtYXkgYWxsb3cgcmVxdWVzdHMtd2l0aC1Q
QVNJRCBmcm9tIGEgZ2l2ZW4NCiAgUmVxdWVzdGVyLUlEIHRvIGhpdCBlbnRyaWVzIGJyb3VnaHQg
aW50byBJT1RMQiBieSByZXF1ZXN0cy13aXRob3V0LVBBU0lEDQogIGZyb20gdGhlIHNhbWUgUmVx
dWVzdGVyLUlEIHRvIGltcHJvdmUgcGVyZm9ybWFuY2UuDQoNClRoZSBsYXN0IHNlbnRlbmNlIGdp
dmVzIG1lIHRoZSBpbXByZXNzaW9uIHRoYXQgdGhlcmUgaXMgbm8gcHJvYmxlbSBmb3INClZULWQg
dG8gcmVjZWl2ZSBhIHJlcXVlc3Qgd2hpY2ggaGFwcGVucyB0byBjb250YWluIFJJRDJQQVNJRCBl
eGNlcHQNCnRoZXJlIG1pZ2h0IGJlIGEgcGVyZm9ybWFuY2UgaXNzdWUgKGlmIGR1cGxpY2F0ZWQg
ZW50cmllcyBhcmUgY3JlYXRlZCkuDQoNClRoYW5rcw0KS2V2aW4NCg==
