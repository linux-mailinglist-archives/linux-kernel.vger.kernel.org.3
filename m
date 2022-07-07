Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 697F7569A8E
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 08:34:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230419AbiGGGen (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 02:34:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231316AbiGGGek (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 02:34:40 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE1A9B8C;
        Wed,  6 Jul 2022 23:34:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657175679; x=1688711679;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=IBWQ38UsyPuzXmNyoYNu1uiekG9H8R4GhNHZGQ1Dz6Y=;
  b=R9ORTNMZienPm3fUjRO6fv+dd7waI6SH4tDTfgJKGEXDZ7UdYkSK1NqM
   +QZqfk0YW6fVefDvjM3r+1Hwhy1/GXglgjHtDBT469aT/t0eEYkHYnfI4
   PAnCkPnGs/b/h/0ngYr/rnS6+y9GaMT63L9c6Hx7fXmAUt3Cj+YZaZ56l
   Xk4DH6TpfvELlxZLJsJMMRnGybzpElgUbXUL2XGxfkcLo3VVc7OJDq2yr
   iWL+/Bns3WcGGhtZTtcYbj2xGbdsP6BnPxxg+6HmVayiJYpglxgz3sXpp
   z3KneCEQHNRgsK0K40u2HvS/K2cVTSgxyyj03+PRYt44mazW67EcRr4li
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10400"; a="281492896"
X-IronPort-AV: E=Sophos;i="5.92,252,1650956400"; 
   d="scan'208";a="281492896"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2022 23:34:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,252,1650956400"; 
   d="scan'208";a="720406268"
Received: from orsmsx604.amr.corp.intel.com ([10.22.229.17])
  by orsmga004.jf.intel.com with ESMTP; 06 Jul 2022 23:34:38 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX604.amr.corp.intel.com (10.22.229.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Wed, 6 Jul 2022 23:34:38 -0700
Received: from orsmsx608.amr.corp.intel.com (10.22.229.21) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Wed, 6 Jul 2022 23:34:37 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx608.amr.corp.intel.com (10.22.229.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Wed, 6 Jul 2022 23:34:37 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.100)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Wed, 6 Jul 2022 23:34:37 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PLoP8gznfWQi2/CJsuNz6VGos9yb53t3AuTTjA37XnIrYk3htFFO0tI6LLK516DjLS+NvsGxGQGeYcoa9Aahh2Yz5ScP4By9UYMnSP1MF9aFfOoKLdtLAU7vhW4BA0kOTlzwUKavJdBSehRbsyxoe799cOVdpPEV2zRBJNG/C8eXx+6aaHMeFieToQiHHZYOAs68sDCBULSZ6qDb/UaggCGosFrq82BdM9W836J2ALdnLS/kn4AmvME67nPsO1J9mPq0/ioJRLIDw40Ah/pKyD3whyF1IM5RVMGdw3/taYNn2MaJ8/czY7IUX8qmQ4kYn+lwz+WybebH8c6I+9ivfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IBWQ38UsyPuzXmNyoYNu1uiekG9H8R4GhNHZGQ1Dz6Y=;
 b=hU028jIj9V8fMlKu2fHGmI3AEsP54flQMF/bxeQZyewWTDu2g9el1vQ0ByZ39viMvfqDEFx0UJ4ljYIkC0zSWpRvsJtsemH1207SpuTo/lhsB3QVwKZU8qMb11y25mKLINN/+9hdfJW4U42pabeCmPu2Xd3jCZTRv5Gx3Cg0lM7Djicfkxop2t70FvgG/WQWq1/5C5/9bcnrHEa+7kWWQdZ3vaZbY8Armeq928bq2YT18xUeEoWX/bInfT+HSp5c4s+zuWX2ByFcVpYTHjx+RKMrfsRzfSLU1foHvnlNCPHHRINm9/x25JuGKdmImhQOEzY08av5L73uGwxfs92s9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by SJ0PR11MB4991.namprd11.prod.outlook.com (2603:10b6:a03:2df::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.15; Thu, 7 Jul
 2022 06:34:36 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::8435:5a99:1e28:b38c]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::8435:5a99:1e28:b38c%2]) with mapi id 15.20.5395.021; Thu, 7 Jul 2022
 06:34:36 +0000
From:   "Tian, Kevin" <kevin.tian@intel.com>
To:     Baolu Lu <baolu.lu@linux.intel.com>,
        Robin Murphy <robin.murphy@arm.com>,
        "joro@8bytes.org" <joro@8bytes.org>
CC:     "will@kernel.org" <will@kernel.org>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "suravee.suthikulpanit@amd.com" <suravee.suthikulpanit@amd.com>,
        "vasant.hegde@amd.com" <vasant.hegde@amd.com>,
        "mjrosato@linux.ibm.com" <mjrosato@linux.ibm.com>,
        "gerald.schaefer@linux.ibm.com" <gerald.schaefer@linux.ibm.com>,
        "schnelle@linux.ibm.com" <schnelle@linux.ibm.com>,
        "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v3 03/15] iommu: Always register bus notifiers
Thread-Topic: [PATCH v3 03/15] iommu: Always register bus notifiers
Thread-Index: AQHYkJHsAUneNaK+AUyHBuGFcsQDbq1wlUkAgADGYACAALHwAIAAZ65g
Date:   Thu, 7 Jul 2022 06:34:36 +0000
Message-ID: <BN9PR11MB527610973C947DBA6B2EA8348C839@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <cover.1657034827.git.robin.murphy@arm.com>
 <8c380309f264cd0dfc73ba2ec060adc9515af2f2.1657034828.git.robin.murphy@arm.com>
 <1fab4c8a-7bc5-9a50-d48a-0dc590cac7a6@linux.intel.com>
 <3d613192-f673-852e-9c52-b8a913d25616@arm.com>
 <28a58a21-a866-b49c-9977-c8d05b320fbd@linux.intel.com>
In-Reply-To: <28a58a21-a866-b49c-9977-c8d05b320fbd@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 22563153-bf8f-4c54-4c6a-08da5fe2c2d2
x-ms-traffictypediagnostic: SJ0PR11MB4991:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: kvO+t9IgGCvvrg0eTWqjeM1hZDAv8TbOSpktnH34ODSwUKQ1tp7GNjmgR1Nkn67yuWwf9oRPccB23v7JRGuFxDVG0U8AfFVJE58+KrI6VJkRzQwQrBAjf6iPCuAfiZbpiAzkv39aOcbkLGnfWhAabhkgqeaD4qBHIBKqTmJZxsGSyBYdrMsU/5X4Olugz43v13sDHviQi90Z4GZ/K6+nzd+6X+Cvxv/I8OGgAqSq+5/IZBQLq7NSBYocmuWA5Vdw/kEldIo+T/Z53okxX3FwgaSev71wXWRgwXx2ovilGNU/8R2CUw2NggbZur7uRXRZvIPPP6azsF456YyFwzYp3o9RrhYMhrR/uSJ05rpBriKoftyOg0A2rMlYhYoqDkj8nKq/lNZXiLRFlcRmmFjB+43BPzgElJd+iZhk+NoP3eTSM2Z6v2dp6Er9Zx1wlSMXKbGGPFaugsQDFLeQ0JfMNcX9cNy5sX3tTL4lo0uiVxdhFJTtxEszRKTXoFGCckf56MFL3MQ27PHg0cjGbm9cNpO2GRfNKbnxGP1iMzlCVLVt/VYyTam6ZIELEYTdPu1yFtPO24FA+56HO0Ez+VwVVHWaC/ulMX2c4VEobwBR4ygKNHGLvNblmo7/jIHTNIKVYOwhebuWphtrnTh0iuzILuVWGClTYttwR8P6xSFwyBMDpiHy5znLVbhINHWc5JIU0u6/bjyY1p8Wz7+dKYMhRPalihVE/T9tinSPIArTHjybndqAZaP7xUxugxKlwpKLpcLT6ezCO4fLN8tPr5eYZosdyqEvCDL/M5hrFxCwdFXhMfzxQLV/I4pau1nHXz33
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(366004)(136003)(346002)(376002)(396003)(39860400002)(26005)(478600001)(6506007)(82960400001)(8676002)(122000001)(53546011)(7416002)(41300700001)(9686003)(2906002)(5660300002)(7696005)(38070700005)(54906003)(33656002)(76116006)(66476007)(66556008)(110136005)(66446008)(52536014)(4326008)(8936002)(38100700002)(64756008)(186003)(55016003)(66946007)(71200400001)(86362001)(316002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cXlPbERiNS9JQzVpUkFGTUZvOS9NWkdDbkJWUmpoUUFDWUVTR0JDS2RNZzJz?=
 =?utf-8?B?M045aXlPdEVhZ24ybVFjR2gzbjdKeEhEQkpuMkpHajYrV2ZmWUFnMVY4a1Mx?=
 =?utf-8?B?MU14c042ZVBBakZRZkNSYjhWTkNRT3ZYM2Fta2swejRKQzZIaUo0ZHVMU3Js?=
 =?utf-8?B?L1VmTXVwV2tBL3lBc081RXNZVFZCckpKOFl5RVpDYTBQL0FZOWlOYWFTU0lY?=
 =?utf-8?B?NEJHNGRuODZlVDUxVlBjejd4dFBsV3U1NW1KSHF6cXVCUjFiVnlsc0ZIRnBK?=
 =?utf-8?B?T2RoRFpsTUN5K0VpY2MveUFZSUxtQStFUDljMHM3c0FOTHpud2ErLzBadXFt?=
 =?utf-8?B?bStBY1FKNHhLaENjeEx0d0E3NVp6SmpXTnFwYW51U05Bd2ZSTm5Gd05oNlZv?=
 =?utf-8?B?M3U4U3pabDE1YXovaHAyWHJ6L3BIYkRjSFhQUWJYSEVsUWxaU29sQk00ZDlo?=
 =?utf-8?B?RWNBSStJYVhMUTl5SWdmWUo0V2VEOEFaWCtyTnlQS1NESXMrK24xZGlpYUMy?=
 =?utf-8?B?SmZydUlwK1ZnV3kwdjMxR1c1SHdPNnVadlRZZHBHNXB5bGkwWUwwd29IU0p2?=
 =?utf-8?B?THZKV2NiK1RiN3cyT0Jxd1dreThUV2p6dkErUzRUSHZmSUhoTERIK0dWalI3?=
 =?utf-8?B?TzFvREJWQ2p4dldlT0V1eVB1b1FXK1VrKytBN3RHbVl2TGJnblI3MWpyYkZE?=
 =?utf-8?B?TVNpaVNKZitSYnVMWTdyMUlkLzdycU1lVnpZYnBFRlEwQXVzQmNhRFBuY3Rh?=
 =?utf-8?B?M1d1N1pVQkhhcGoyZkZPazhLVzh5WTd4YjZzOFJEWU5WN1RzbllvOEhUSk84?=
 =?utf-8?B?QnUyZTdMUk9aTHRjZ0cxQTN3OWVXMVQ5cTUySGhKeU9OZmpnM3FHNXNhdTRJ?=
 =?utf-8?B?ajdobWJUUVp5SG9mVTZQbUJSazlKNUN6MDczcktFUXNrbnB3eWNiUk94N1hz?=
 =?utf-8?B?SXlQaU9vNVB1eG03NXpaLzRzMGFsSkVBQ3JaRlFqd09TUG5KdVVOZjViWEZh?=
 =?utf-8?B?OGtTemtIQmJRenZZNUJHUFpjb0xpa1VNTGRld284K1NXUG8zbEpxSU9lSnA4?=
 =?utf-8?B?eXFGYnFGVExUR3ZPdDVKSjEvYlVBcCtnbFRWbXp2RnVGL1U5a1R1NDJIMGpU?=
 =?utf-8?B?SkMvaHZKVVdvakp1QTdoR1krOUFvQzZGTzBqcmUweWFCVlN1aXlMRHlpQlhL?=
 =?utf-8?B?Mkd1c0x3bWVlTW9mYldURGZFWis1Rm51L0RNMXM5dWljK3VNaTc4eDJ1YXZt?=
 =?utf-8?B?RWw0c3dGMktuNVdjSGRRZUdJYzB5Z0FFaENZWkhBdVpBeE5MdlJoVDEyVkll?=
 =?utf-8?B?b0MwL3NhSTR6YzFGeDA2N1hDUnlzTmV4cXAxL2NidEY2UFFTQzhQMnlxdjN6?=
 =?utf-8?B?MlBPcjZkeEEvYWV6Q0pPT1gvdmxIUVlBUEt3L3RLaGY1VkRGTW9QQytTNzEw?=
 =?utf-8?B?am9waTQ5R1h4WFlvRFVRM3ozSGJjUUc2RURRN3VrT0VicEEzTmEyVDF2S3Fw?=
 =?utf-8?B?R0IwM1V3a0hONm8ybWJFNnNrZWpQMmZRNDk4cW5Id1lSU1FJT3VJS0w2a29Z?=
 =?utf-8?B?U3NiZ2RRUUFRazVRV3FmZzFESVJRa0hwQitoNW51OUx4dCtnNlI3TVYrTk1I?=
 =?utf-8?B?K3N4cjVMbmExZ3FxZHBkUjI2TmU3cHFlM0ZPeUVIbTV5OG51ZFU5WjNIMitu?=
 =?utf-8?B?ckNGOFZwOE4xUUZTREtDVjh6alpqeWlPSzZSZjZvbHRrWlI1dFNRWTZyY2kz?=
 =?utf-8?B?Mi93MTlDUmlTaUU5WWNyNGFsNkhUVzlIcDRYTFY4OFB6ZUJPd3p5SUZPbS85?=
 =?utf-8?B?VUtuaUs1QW9YNXA2WTF6bFdCSjExWDlmUTVyYXhvYWMybFlFbGtTZmNtaWY0?=
 =?utf-8?B?Q1h3eU0xdVI0eHZkL3hZVERDSDBOSWkxSTRSOGhvVTFNYXMyMXBYd1dCb1JM?=
 =?utf-8?B?bFFseUlPUDhHd0dWTzZTOG45LzJFc1FtKy9vOE9sZUtpSXFXcWxjZExxZDA5?=
 =?utf-8?B?L29FeGN1azFsYzNOTHRMbWIzazI3OTU2WkcxVnJlVFRXbk1PQzhMWUZFbFZ3?=
 =?utf-8?B?Z29RaXV3NnQrVUU1bG5hTk93TElwUDU5b0FGWk54Skw0YktxeUtSRzNhbjVV?=
 =?utf-8?Q?xxcsoc9PUgUij8/GpgGJNoePo?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 22563153-bf8f-4c54-4c6a-08da5fe2c2d2
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jul 2022 06:34:36.1843
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XT/JS7P9pY+SVcTbuL+vbdKGcsgg0jYdq24kdv/rYuRoUNyntapeFPpkqLj8Jsp7EubSJvzfXyGHdCVjU75Nrg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB4991
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBGcm9tOiBCYW9sdSBMdSA8YmFvbHUubHVAbGludXguaW50ZWwuY29tPg0KPiBTZW50OiBUaHVy
c2RheSwgSnVseSA3LCAyMDIyIDg6MjEgQU0NCj4gDQo+IE9uIDIwMjIvNy82IDIxOjQzLCBSb2Jp
biBNdXJwaHkgd3JvdGU6DQo+ID4gT24gMjAyMi0wNy0wNiAwMjo1MywgQmFvbHUgTHUgd3JvdGU6
DQo+ID4+IE9uIDIwMjIvNy82IDAxOjA4LCBSb2JpbiBNdXJwaHkgd3JvdGU6DQo+ID4+PiDCoCAv
Kg0KPiA+Pj4gwqDCoCAqIFVzZSBhIGZ1bmN0aW9uIGluc3RlYWQgb2YgYW4gYXJyYXkgaGVyZSBi
ZWNhdXNlIHRoZSBkb21haW4tdHlwZQ0KPiA+Pj4gaXMgYQ0KPiA+Pj4gwqDCoCAqIGJpdC1maWVs
ZCwgc28gYW4gYXJyYXkgd291bGQgd2FzdGUgbWVtb3J5Lg0KPiA+Pj4gQEAgLTE1Miw2ICsxNzIs
MTAgQEAgc3RhdGljIGludCBfX2luaXQgaW9tbXVfc3Vic3lzX2luaXQodm9pZCkNCj4gPj4+IMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIChpb21tdV9jbWRfbGluZSAmIElPTU1VX0NNRF9MSU5F
X1NUUklDVCkgPw0KPiA+Pj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAiKHNl
dCB2aWEga2VybmVsIGNvbW1hbmQgbGluZSkiIDogIiIpOw0KPiA+Pj4gK8KgwqDCoCAvKiBJZiB0
aGUgc3lzdGVtIGlzIHNvIGJyb2tlbiB0aGF0IHRoaXMgZmFpbHMsIGl0IHdpbGwgV0FSTg0KPiA+
Pj4gYW55d2F5ICovDQo+ID4+DQo+ID4+IENhbiB5b3UgcGxlYXNlIGVsYWJvcmF0ZSBhIGJpdCBv
biB0aGlzPyBpb21tdV9idXNfaW5pdCgpIHN0aWxsIHJldHVybg0KPiA+PiBlcnJvcnMuDQo+ID4N
Cj4gPiBJbmRlZWQsIGl0J3MgY29tbWVudGluZyBvbiB0aGUgZmFjdCB0aGF0IHdlIGRvbid0IHRy
eSB0byBjbGVhbiB1cCBvcg0KPiA+IHByb3BhZ2F0ZSBhbiBlcnJvciB2YWx1ZSBmdXJ0aGVyIGV2
ZW4gaWYgaXQgZGlkIGV2ZXIgbWFuYWdlIHRvIHJldHVybg0KPiA+IG9uZS4gSSBmZWFyZWQgdGhh
dCBpZiBJIHN0cmlwIHRoZSBlcnJvciBoYW5kbGluZyBvdXQgb2YgaW9tbXVfYnVzX2luaXQoKQ0K
PiA+IGl0c2VsZiBvbiB0aGUgc2FtZSByZWFzb25pbmcsIHdlJ2xsIGp1c3QgZ2V0IGNvbnN0YW50
IHBhdGNoZXMgZnJvbSB0aGUNCj4gPiBzdGF0aWMgY2hlY2tlciBicmlnYWRlIHRyeWluZyB0byBh
ZGQgaXQgYmFjaywgc28gaXQgc2VlbWVkIGxpa2UgdGhlDQo+ID4gbmVhdGVzdCBjb21wcm9taXNl
IHRvIGtlZXAgdGhhdCBkZWNpc2lvbiB3aGVyZSBpdCdzIG9idmlvdXNseSBpbiBhbg0KPiA+IGVh
cmx5IGluaXRjYWxsLCByYXRoZXIgdGhhbiBpbiB0aGUgaGVscGVyIGZ1bmN0aW9uIHdoaWNoIGNh
biBiZSB2aWV3ZWQNCj4gPiBvdXQgb2YgY29udGV4dC4gSG93ZXZlciwgSSdtIGhhcHB5IHRvIGVp
dGhlciBleHBhbmQgdGhpcyBjb21tZW50IG9yIGdvDQo+ID4gdGhlIHdob2xlIHdheSBhbmQgbWFr
ZSBpb21tdV9idXNfaW5pdCgpIHJldHVybiB2b2lkIGlmIHlvdSB0aGluayBpdCdzDQo+ID4gd29y
dGh3aGlsZS4NCj4gDQo+IFRoYW5rcyBmb3IgdGhlIGV4cGxhbmF0aW9uLiBJdCB3b3VsZCBiZSBo
ZWxwZnVsIGlmIHRoZSBjb21tZW50IGNvdWxkIGJlDQo+IGV4cGFuZGVkLiBJbiB0aGlzIGNhc2Us
IGFmdGVyIGEgbG9uZyB0aW1lLCBwZW9wbGUgd2lsbCBub3QgY29uc2lkZXIgaXQNCj4gYW4gb3Zl
cnNpZ2h0LiA6LSkNCj4gDQoNCkknZCBwcmVmZXIgdG8gbWFraW5nIGlvbW11X2J1c19pbml0KCkg
cmV0dXJuIHZvaWQgcGx1cyBleHBhbmRpbmcNCnRoZSBjb21tZW50IG90aGVyd2lzZSB0aGUgcXVl
c3Rpb24gYXJpc2VzIHRoYXQgaWYgdGhlIG9ubHkgY2FsbGVyDQppcyBub3QgaW50ZXJlc3RlZCBp
biB0aGUgcmV0dXJuIHZhbHVlIHRoZW4gd2h5IGJvdGhlciByZXR1cm5pbmcgaXQNCmluIHRoZSBm
aXJzdCBwbGFjZS4g8J+Yig0K
