Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3E894BBE69
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Feb 2022 18:29:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238591AbiBRR3X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Feb 2022 12:29:23 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:60470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234314AbiBRR3V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Feb 2022 12:29:21 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A6DF2A64F2
        for <linux-kernel@vger.kernel.org>; Fri, 18 Feb 2022 09:29:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645205343; x=1676741343;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=2FYa3Z2Z1p5i07xv/TKktHyLQt1G7cNlm63euFfk0EQ=;
  b=GNFqy7BQsQ9KPFBJQkjKiF0MSaCiozeCcLUGPV3LkUPtWocyxB7WKzFx
   wj+3L0u6TurJBDtHOIg3sDWJqdDKIULmCVOt4oWrhdBj4I0CVT1d3W6tW
   AuJrU65hgjBYEQZ69zGC2zPcG3AdJSYtuqOsA3hBWtDNCMmMgrUOTIyHK
   Tc5/OxruaE9+2WbJuQ88M6ZHDN8MgLKRI8qncERgkw2vgfpadLoxAqVoS
   03PLdxwuvnVCRE4UqTgCnCSozIBEAUiyFlig/WhVXoyldE8EPRDeolPaD
   qNb46opOtSQog1IvoY2kCcUnSu9IX5n+LQrTcV525IPIAeaZIRdNBHvlK
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10262"; a="248768255"
X-IronPort-AV: E=Sophos;i="5.88,379,1635231600"; 
   d="scan'208";a="248768255"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Feb 2022 09:29:02 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,379,1635231600"; 
   d="scan'208";a="506374913"
Received: from fmsmsx604.amr.corp.intel.com ([10.18.126.84])
  by orsmga006.jf.intel.com with ESMTP; 18 Feb 2022 09:29:01 -0800
Received: from fmsmsx607.amr.corp.intel.com (10.18.126.87) by
 fmsmsx604.amr.corp.intel.com (10.18.126.84) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Fri, 18 Feb 2022 09:29:01 -0800
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx607.amr.corp.intel.com (10.18.126.87) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Fri, 18 Feb 2022 09:29:01 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20 via Frontend Transport; Fri, 18 Feb 2022 09:29:01 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.177)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.20; Fri, 18 Feb 2022 09:29:01 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LcnSGDLXiRY996juCy1c3X+9n01qWe3Ygr2QDEtVJqVQ60SEqQSNFz57eRjT18hqx8GyqHM/O6rGFY4Ua0eHTM6+R/JwK1zAL15ZYYa6qDNeWtRAatJojyqQ4jI9fSwWv7xyI2HKwVf39CTIHboeGDzCOp+HAXf8V8oo+mob32jvUhUbITOoSyKctsBGpidWlGyCmGnhwC+FoxTiVRDp1g9nGdXhMyKjUnC6/9s1SiDI6jSJeTxqXz/OVVaeniYWMwfmO/JdDuDZRCFZMCxK2fBLAA4zXUbs4VxfHjWHAgRRpzvwvAB7TnyGfwWduMAoig/bo4DtMCrLYoB2vr/Ewg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2FYa3Z2Z1p5i07xv/TKktHyLQt1G7cNlm63euFfk0EQ=;
 b=QoKaCsZEo4BbriocpZJuSPTxy64aiQK/7zh45N3jjHEVkQZJInayTWCo4PTPt7sDAjmo8+PtKTJpPYwFiBwkb7IIqaxbd67A8zKbiqvaMj0bfaXWVd32ISZ6c+Xq/iqYH4rc+lsbQf43xxCFzZ7Xz2hPSOFk7N09mgb2sx/mfUQAxsezD6CKEVTd7ux1JHT8WIuSUpfuR/FC8VKmcfKDlFolqABiYc4VoIUM0JmLUhjyRbMP5sHUlFZEhRBObGA/JJlpRMKvA+Rc683YIpfpU1He9azTG2W5NwWtm+0VSJJ2Vt1q4CRDrtnUJwV4pVGc+Hoe82yA16ikd/HH4stlbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MWHPR11MB1392.namprd11.prod.outlook.com (2603:10b6:300:24::14)
 by MN2PR11MB4141.namprd11.prod.outlook.com (2603:10b6:208:13b::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.16; Fri, 18 Feb
 2022 17:28:59 +0000
Received: from MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::250a:7e8f:1f3d:de15]) by MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::250a:7e8f:1f3d:de15%4]) with mapi id 15.20.4975.021; Fri, 18 Feb 2022
 17:28:58 +0000
From:   "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To:     "Weiny, Ira" <ira.weiny@intel.com>
CC:     "hpa@zytor.com" <hpa@zytor.com>,
        "Williams, Dan J" <dan.j.williams@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Yu, Fenghua" <fenghua.yu@intel.com>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>
Subject: Re: [PATCH V8 26/44] x86/fault: Print PKS MSR on fault
Thread-Topic: [PATCH V8 26/44] x86/fault: Print PKS MSR on fault
Thread-Index: AQHYE6cSvAinJ1PkIkSVk8TPjaDgIqx/B5GAgBnrBYCAAMAggA==
Date:   Fri, 18 Feb 2022 17:28:58 +0000
Message-ID: <d94be5f21bf18c844d7088a96ae35aa209a0ef4e.camel@intel.com>
References: <20220127175505.851391-1-ira.weiny@intel.com>
         <20220127175505.851391-27-ira.weiny@intel.com>
         <2a919d9ed8ed874f8b89014c0b42cbadb44d837b.camel@intel.com>
         <Yg82L5ibjbn15AHO@iweiny-desk3>
In-Reply-To: <Yg82L5ibjbn15AHO@iweiny-desk3>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 74e60c94-eb39-4cb5-4af5-08d9f30425bb
x-ms-traffictypediagnostic: MN2PR11MB4141:EE_
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr,ExtFwd
x-microsoft-antispam-prvs: <MN2PR11MB414162898D8AFDA207CE0713C9379@MN2PR11MB4141.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: TmXE/Y4FYMf0ed1uhZ37AcXwpCwLN3wsQEqitEAckbOwDe8WWdKitzK4Oq/q10X651+xYbqQHul5W8Sx0ZuJPO2LPwf4Chob7q6JmVGQYTXqFfD26VrBYHQXK2Om8T2GCWREHqAJkD/vqLbrxmL9Kg98HhDxv9y5+8Ih6u8SEXGHunV1CfA8fzP+1tJ1d/50aGBDyvap7V0gCYhRWKWtzOQsQSdLor2FjfXPfah8xw97sPNrrQ74KPpA695Ug5Ri3cv+rc3hOzVNT2oAjbvDTWmajvi/TyY5ikppKN+A5jJ5KjyRqsjmBJpcGbbqOaX/trKaTxOZxhGORdYF7LsrF98TWBGdGMxbJRaq11rC4k3s1rYgBnw+TTBHN48nX1y8RdCQixUeva8m5PfVPaV7jSOToLOn7/PI8m5prFzIB2/X5w2e8W10bwFgMVOun9vPdPomZIJkI6cm43fkciEPSFNo1zA6COeJpUYqGYcWfoQ9hQ7L3uPAxeu2KoM7nzApp3UUzeQiCePmnW/MZi21iud07Ctc5to2Ai7hM6EthBhcPAMNz9iRyT/j9y2UlkocaeQYWVnyaanULJAy4/BZM5QFyPyxcOOxG3vD9QkdCwA5sxngtmysRkqfuNSVU0sfGz4vw7yy3ZCXgRtmWaqY9zk3FL9EZOidu5apuIu68HYYRs9/LiDN//VN/x8IMr1m9W32Gf3+VUmfbUczeiOYYAmhGFI515NFJJJrhbUr4m4=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR11MB1392.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(6486002)(2906002)(86362001)(38100700002)(6506007)(37006003)(83380400001)(508600001)(8676002)(66946007)(66446008)(76116006)(38070700005)(66476007)(4326008)(66556008)(64756008)(6512007)(71200400001)(316002)(2616005)(6862004)(8936002)(186003)(122000001)(26005)(54906003)(5660300002)(6636002)(36756003)(82960400001)(99106002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SGgvUGphN2hqSnE2UWk0b0lnd1o3bUI1L0Vmd3FIWVlGUzRBUDhaa044akEy?=
 =?utf-8?B?Q2UrM21aQjRrdTZWZU5Zc0kvcnhTRkU5bDI4Z2ZtRy9zdFkySkptUXptK0Jq?=
 =?utf-8?B?R2I2ejZkbks2YW1tMGFPekhEWUUyV1VFSUNxUit0S2JWb2Y2QlhlVVcyZTRh?=
 =?utf-8?B?ZGhxdTNBTVdPbkdkTmk1MnZ0SCtrQkxpdG1VNjI5Z0dnUCtKdWw4SUJaL2Fx?=
 =?utf-8?B?Sm1LRHBCVXBDR01UbEFtSVVmSFNodUw3T3ZsZnJzTzEzamlRQ09hTnF5aTJV?=
 =?utf-8?B?T0M5VS9Zekgza3JmMXZLL3dkclNQbzFlY3ZLVWZXeHpCRFEza3V4MEQvZlhm?=
 =?utf-8?B?ckFBU005SkhKTnJUMmlTVVZRRUhHN0JzVlFMRTFuR1ZqWUp6SC9aaVlxdDBD?=
 =?utf-8?B?OXJuS3JEUnpqdW9NaEZqdmk3bmtLREFKZkp1NjQ3M1UxSER3V3pnNUhnWVhw?=
 =?utf-8?B?OEplZkZtQnB0RnNpUVowWXU1VUEvMFFMaktLS1FJdEZ0VEpQTS9xNGV1Q0p0?=
 =?utf-8?B?cFQ5QjVCT3ZTMWl4anlMYjJkUFFmMDlDNTBjejhwTGh4U1lUd2x1aUdoT1pK?=
 =?utf-8?B?S3g1OWVGVHZjUHl6OFU2N044V2N0emo5N3gxLy9ocVBCOUdRam9odnY1aU9q?=
 =?utf-8?B?MXFIQzk5M011ZEN2U0pGVGZjWTZraXRZNXVNRlVXOW9OWWppSCtoRHp0b1Z6?=
 =?utf-8?B?SFcvb29kbVY5aWhxTEVRelZ4V1VHUUdKTVAxSUdBcDlHaE1CTDdHd2RjZFlo?=
 =?utf-8?B?d0kxNTRpenppdGJKOGlsazVpZHczNU5jZzlhMTNGSUY3eU9Tekd5OExWbGtp?=
 =?utf-8?B?ZWNMem9SWThraUErVVpKZHRJMmltdXhRMEJhYVBidUlYTmhpaGF1REljTHJl?=
 =?utf-8?B?cjAxMEFrcy9Ob0VGMCtsV29jVzhPVkkyVGtndUg3Y0pKcFNJeE90L3dSendU?=
 =?utf-8?B?bXVUSW5VZVc1MmcxYlA4UFVBaGpLeHliWVN6Q1NjaStSWVRWM2VDREJGWTdZ?=
 =?utf-8?B?SEdEUDVHanR3Z0pQTE9QWnMyRGdWS0dpbWhQcVRjeWdKTUI5R2tQcVMwQWdP?=
 =?utf-8?B?Q2V1TWJFTlVFY3k1ZWJHelRuSXdvT0IwMWRGYTNNeHBZSXJERzdJaDV4MFhR?=
 =?utf-8?B?UWovYkM3RlJveU83dkVyanNmNTVNS0x4RWl1d3hIWjFKT2czUGlMYjVTWTc4?=
 =?utf-8?B?S3FiNzQ5YW5mOXBXTVFycFlkM0lHcXhmM1JONXk2MTF0M1B5bHBUeENlOXh3?=
 =?utf-8?B?eE1pRGhtblEyZC9OdUVSYVJVU000ekVvRkJTZEFGTzVhUUJ5SnRHN0tsNTJy?=
 =?utf-8?B?U29ySkZXSnpTMEtkbThNenE3ZGFlQ0dMU0JMR1Y1TzlMS1RyQ0lQcU1nQ3M5?=
 =?utf-8?B?ZkhWbXR3c3U5dVB0YkRpZnN2QkUxdXpKQVNOUUgvWFVmSURZdlVhOG1CNWhG?=
 =?utf-8?B?SGIyWWJVMzVENWxpK2xtcHB2ajhScU9IcmxmSU9UUEY5S0FiWVJjSnYwT3VS?=
 =?utf-8?B?S2Zwb3R4RmhCUlNTcDBTL3IrRVBCNGc4V3hyUDBZU2xPYjEwVlNBNHpBU2tL?=
 =?utf-8?B?WGJ5MEs3Y3k2QXJNV3NmQzNudHJjRjRvZFg1ejgwQ3l5bjJwVW5ZQmlYUlZP?=
 =?utf-8?B?RzkyNjRRVHpGbDR5Y3dHWW5DdzJwWTZpUlZkaGdyM1JmbFRUUXRYZ2l3N1Az?=
 =?utf-8?B?KzR5akdxYk9raVkvelRvVlVKRDBPQ1JGcDAwU3d6MFQyZTFEZ2RqR083Y010?=
 =?utf-8?B?czRPZ04ySnV1bzF3U2RIZlZxRXY1OGZzOVRDT29wOE1UMlp5M1MrVTkvcGRL?=
 =?utf-8?B?T3JlYTFORHhQQnZ4VlRPUHNPZnNsVXFiaWFJakJxWWJEZVpyNFFsU2QzTDFI?=
 =?utf-8?B?cHFhdGIxZ0N5WE1YeENDajF2S0JNdGs1Tm4xcEJLOUxLMkRudHYrUUlJVFZP?=
 =?utf-8?B?UG94ZmQ5QUp4T1BHQThlTmV5Tjd6WVArV1JHRmRDRUJ6NUluc0NiK0JELzNo?=
 =?utf-8?B?eVBEVlJTUW01QSswTEFoU2NuTDBNZjlZSzhjNjZTT0Z6aUs5ZDJjRW92MUtm?=
 =?utf-8?B?TWtWaUNNWjdHa3pORFRlZFRqaFpxeXlyZ1Z0bzlPczFxd1NzeFVhVVNqUTBN?=
 =?utf-8?B?bnl6NkcxNmxHN1VndDNFTm5YV3hIWmZqQ2hzeVVtYWVKWTAydWVIVWRFYVZZ?=
 =?utf-8?B?ZXhMekRqVkdrN0NXOS9OUHF1SmFMdHZmOCtUZzdodTRIbDFTUHF5a0Q3RURP?=
 =?utf-8?Q?TyQ4IYtlwIgQ/n9sZ0LNsg6pAa4Ju2FytzR7a1YBBU=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D02B1A647D6DF846BAD1CEA09AE71F53@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR11MB1392.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 74e60c94-eb39-4cb5-4af5-08d9f30425bb
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Feb 2022 17:28:58.6836
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TNZb3LAp2fgE4ItAXZ/7Df3RA7SFf9QLkeyC/GsfE58HJx4mOY9Tph2t2kIesLWS6ZjIGNTb7nY8SQhmnJLXYpQ++IIvl8/82Uu/nIFmFuw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4141
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVGh1LCAyMDIyLTAyLTE3IGF0IDIyOjAxIC0wODAwLCBJcmEgV2Vpbnkgd3JvdGU6DQo+IEFy
ZSB5b3Ugc3VnZ2VzdGluZyB0aGUgUEtSVSBzaG91bGQgYmUgcHJpbnRlZCBpbnN0ZWFkIG9yIGlu
IGFkZGl0aW9uDQo+IHRvIHRoZQ0KPiBQS1M/DQoNCldlbGwgSSB3YXMganVzdCB0aGlua2luZyB0
aGF0IFBLUlMgc2hvdWxkIG9ubHkgYmUgcHJpbnRlZCBpZiBpdCdzIGFuDQphY2Nlc3MgdmlhIGEg
c3VwZXJ2aXNvciBwdGUuIEkgZ3Vlc3MgcHJpbnRpbmcgUEtSVSBmb3IgdXNlciBmYXVsdHMNCmNv
dWxkIGJlIG1vcmUgY29tcGxldGUuIEknbSBub3Qgc3VyZSBob3cgUEtSVSBjb3VsZCBiZSB1c2Vm
dWwgdGhvdWdoLCBJDQpjYW4gb25seSB0aGluayBpZiBzbWFwIHdhcyBkaXNhYmxlZCBhbmQgdGhl
cmUgd2FzIGFuIGVycmFudCBhY2Nlc3MuDQoNCj4gDQo+IEFGQUlDUyB0aGlzIHJlYWxseSBzaG91
bGQgbm90IHByZXNlbnQgYSBwcm9ibGVtIGV2ZW4gaWYgdGhlIGZhdWx0IGlzDQo+IGR1ZSB0byBh
DQo+IHVzZXIgcGtleSB2aW9sYXRpb24uICBJdCBpcyBzaW1wbHkgZXh0cmEgaW5mb3JtYXRpb24u
DQoNClllYSB0aGVyZSBpcyBzdGlsbCBlbm91Z2ggaW5mb3JtYXRpb24gdG8gZGVjb2RlIHRoZSBm
YXVsdCwgYnV0IGl0IGNvdWxkDQpiZSBtaXNsZWFkaW5nIGF0IGEgZ2xhbmNlLiBZb3UncmUgcmln
aHQgaXQncyBub3QgYSBiaWcgZGVhbCwgYnV0IGlmIGl0DQp3ZXJlIG1lIEkgd291bGQgZml4IGl0
Lg0KDQpKdXN0IGxvb2tpbmcgbW9yZSwgeW91IHdvdWxkIGhhdmUgdG8gbG9vayB1cCB0aGUgUFRF
IGxpa2UgaXMgaGFwcGVuaW5nDQpmb3IgUEZfSU5TVFIuIFRoYXQgY29kZSB3b3VsZCBuZWVkIHRv
IGJlIHR3ZWFrZWQgYSBsaXR0bGUgdG8gYWxzbw0KaW5jbHVkZSBYODZfUEZfUEsuDQoNCk9uIHRo
ZSBvdGhlciBoYW5kLCBzb21lb25lIG9uY2UgdG9sZCBtZSB0byBhdm9pZCB0b3VjaGluZyB0aGUg
b29wcyBjb2RlDQpiZWNhdXNlIGlmIGl0IGdldHMgYnJva2VuIGl0IG1ha2VzIGRlYnVnZ2luZyB2
ZXJ5IGhhcmQuIEl0J3MgYmV0dGVyIHRvDQpiZSByZWxpYWJsZSB0aGFuIGZhbmN5IGZvciB0aGF0
IHN0dWZmLg0K
