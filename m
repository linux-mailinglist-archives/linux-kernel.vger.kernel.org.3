Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A14564A6400
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Feb 2022 19:35:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241884AbiBASfc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 13:35:32 -0500
Received: from mga17.intel.com ([192.55.52.151]:42965 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241827AbiBASfZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 13:35:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643740525; x=1675276525;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=JikI3ObyfMkssXSRIYZMtW0FkgUeKpD7BAZ3FEeGAHI=;
  b=K0PmVhZToFieaxYxj5bLob6pQ9HE8vxGfqr9ZDJXLZLo5mzUXmmdvEHs
   HcQpCf45OJz5YP5lqnWIkRLTFV6ydlqVLvtBzRTMwcPmsN1LsxqWkbqN6
   aWF7ia+nkHI7ZXBnK2bM23hAa7yvKzrPZh5gYWyvIUmDZSUJyY5SG+1GT
   mQBf+4pcS6YHjhrdIhoh6YYjzN08rNdoe1lg1DTwgktfLScW2p5ZFtR6h
   AHtTxhb7dYlJaW369sD93PCtDOZCxvqeqkcGffru3/j2Xy5rYClUZ1xZW
   PABzyKKTGXUfryAqJfZCUJgBxO1iaRdCUQ8105xaGNkpIn2NAbK8sOzGX
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10245"; a="228416770"
X-IronPort-AV: E=Sophos;i="5.88,334,1635231600"; 
   d="scan'208";a="228416770"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2022 10:35:25 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,334,1635231600"; 
   d="scan'208";a="771199135"
Received: from orsmsx606.amr.corp.intel.com ([10.22.229.19])
  by fmsmga005.fm.intel.com with ESMTP; 01 Feb 2022 10:35:25 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX606.amr.corp.intel.com (10.22.229.19) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Tue, 1 Feb 2022 10:35:24 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20 via Frontend Transport; Tue, 1 Feb 2022 10:35:24 -0800
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.44) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.20; Tue, 1 Feb 2022 10:35:24 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fzFQyeR+WutmXJv9wvSwweS+tWOSL08Kpp/5FPEuqmaj7aaokxlkoVchM3Ey0+JPr2qxsuo5+8nbNyYC4JQVtgWbxuGlHyc21evZKAyVLagrJpo0FFhQPCjkJUiaWttezB9roqjIeow7kCTMaK+8eQUrjuu74lKlOf+Kj2zmwITa81r4sIIiYpiEVlqYR8OPRw2gURN+Zjp1YYX0eOVitebdPrDRfiNtMCzPlIOJX4JjoEn+CzxvqZ3gxOP9oHhwYG15dcFa9MDtWnaWgVHHkh78cVUjlYqlBp/3t357IsgKMsbup6xaYTrsyYNXwUv3kivtIWHvzTkqM0bqCf+wFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JikI3ObyfMkssXSRIYZMtW0FkgUeKpD7BAZ3FEeGAHI=;
 b=Srr6Lk3VUyupLE8bVuLOGZmcMHx4O9HKBDSYNDBG/xncWRXcVvTNQFhxbjZ90HeCFyzxxX27P8GeIesyrPRn1SUvY0h6tA1AEIJrjEyT26N7rf1/xNiYt3tI3PNXbKdyartJ34EvnQT5+K8ZEM+YNDy27hIaQ/df7abfObglKrclR1kr/nvw5tKC9YiHLNpCQaaF5oweP8XFAmWr4epnerl6970A0APGfKZ3yOWmC2iCMvGsUBF+JpFPS4ZKPovL7aNbKXMhQT27kjwzN8ZSORLsQPzgM+7E2G5UpVCX4j5uBvu2sh8dhILT1OxTJvI9UCoLkgEOoGTT+CdOBgczUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from MWHPR11MB1392.namprd11.prod.outlook.com (2603:10b6:300:24::14)
 by CO1PR11MB4900.namprd11.prod.outlook.com (2603:10b6:303:9e::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.11; Tue, 1 Feb
 2022 18:35:21 +0000
Received: from MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::7053:5a70:1fec:345f]) by MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::7053:5a70:1fec:345f%7]) with mapi id 15.20.4930.022; Tue, 1 Feb 2022
 18:35:21 +0000
From:   "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To:     "hpa@zytor.com" <hpa@zytor.com>,
        "Williams, Dan J" <dan.j.williams@intel.com>,
        "Weiny, Ira" <ira.weiny@intel.com>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>
CC:     "Yu, Fenghua" <fenghua.yu@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH V8 36/44] memremap_pages: Reserve a PKS PKey for eventual
 use by PMEM
Thread-Topic: [PATCH V8 36/44] memremap_pages: Reserve a PKS PKey for eventual
 use by PMEM
Thread-Index: AQHYE6cRFQ2lSx3rbUCc745tsMboB6x/DaAA
Date:   Tue, 1 Feb 2022 18:35:21 +0000
Message-ID: <2193142f0cf3785a4225e0393eace397cbbe86e6.camel@intel.com>
References: <20220127175505.851391-1-ira.weiny@intel.com>
         <20220127175505.851391-37-ira.weiny@intel.com>
In-Reply-To: <20220127175505.851391-37-ira.weiny@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c96290d6-a75a-497a-0dd5-08d9e5b19ad1
x-ms-traffictypediagnostic: CO1PR11MB4900:EE_
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr,ExtFwd
x-microsoft-antispam-prvs: <CO1PR11MB4900FA0F22697976E192A3EDC9269@CO1PR11MB4900.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: y1Cms+4Y5I9fdYnYZ8C3ppdcaOdfKR19NrgZpaf2NClSnrpc/S6KMdpXj7dhEjFM+PacEyl1v0xY57slv9mso2zdZKGput/biwwhjjvTYCFPcHpMQ3P54jSHrxkAwE0mICGoI3s0SkTkacXgEvegxM2eVwAYs64bxvqEJl8GK06Xynv3fSE+fQZN/c/+dZ+WM9YH28C8fGSzQMnBeOTXJCdGEEpewr0RsTLw9H3mLHK7ueMP4OsH49C/CvDa99BXxRlxC3ttrCNhCUBw+mbfWRIUZ8mq3YlKc9PiJ00fj3eS+TGZLrf75WaJJjwAfj3v75bzmJs17V69kwzEYjahpHWUrOnSIcWcg0/Nwq6YfM8GhMWBjb1JaMxrcCbNjZE9HpPxE+74i1bOeQ8+gkDrAd7kZnwvnHMz3+gxNabguLvpuFO5S5KWP+vTkF6Rlmwbg2h82Cd9kvMk1xFJtHf30FfmCLQPETENIDu/IIBq26905cZvsNa1seYbSCr5WG1VERoxCXhEWueshEGpVxAa4arimjIXSgVXVig2cfoLJ16wIh80UAbruFCdT6UO/lWc67kmr/wTyrm16iTJ2CUquCpa/U5d/1ACaBNOaq567l/WFHcuUvUF4Cbr9Ne4qkexfvSDxl6fkgbNfNDgcqotSTjlum/YJww2ke5ckr7vfbkT2L9M2w5/+dLOuwFFZHxH1F8K6t1pHZ3nf9tV5Zkbe/gICLRTVdWp51kiyXc+i1A=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR11MB1392.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(36756003)(71200400001)(2616005)(508600001)(6486002)(26005)(6506007)(6512007)(186003)(2906002)(54906003)(82960400001)(4326008)(38070700005)(8676002)(8936002)(4744005)(66446008)(64756008)(110136005)(5660300002)(38100700002)(122000001)(76116006)(86362001)(66946007)(66556008)(316002)(66476007)(99106002)(20210929001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?K2s4dHo3UnRhdEE4S29wKzB6Y0s3ZTJkaGg0VVlydHpqMTVIWFJkUFpWUGdR?=
 =?utf-8?B?ZDFOZHBPLzBjSFVMNzB2MEVkNmROc1M0YXVYNUJMZkozT3BsbC9YMUNnMlhS?=
 =?utf-8?B?SW5UY2lrSHBXN1lleS82MkpIOWxOSVA2QVdLVWY0RE80ZVd4THU0OTFsa2xU?=
 =?utf-8?B?Q20ycnpwNld3TVdzZGdud2FscjJRUWRvLzRFcFpnVmZEbkpxY3YyUEU4eGYr?=
 =?utf-8?B?dGdLS01GME0wS3JpL2lYZWdBSHRxWFVQeDJ4N2V1SlVHcDF6SGVYU1VzZkdy?=
 =?utf-8?B?Tkp2RGN1bnh2bTQ3YUV2dGsxRkNqditXOC95SWEyS3ZVUnB2NnYrTWU2azZP?=
 =?utf-8?B?L0hQMVJpQXJCNWdOc1JVbmNlZWZ4U3BKSFVPVzBaUFQyVytLeUl0eUttV1VI?=
 =?utf-8?B?dDVvejd4eWs4YnQyT3RNZUN0Wnd5aHhaWTlSR054Sk5UVlR6MVp4bWFzclpp?=
 =?utf-8?B?U0F1LzRNeHVHRWpTdGJZNng3aEF3WFlaVFZvTHdRdWQ5WndmK2JrcktwNUU3?=
 =?utf-8?B?czZVQmQ5UmJSLzI2aWNYeWVDem0vTVhJZjVhYlJnc2EvRWtzNERRR3d0RUlk?=
 =?utf-8?B?M0VuS1NXSHh0S21UdVZkTDhMOWtJcldxMlM0NGE5TExxUEFKeElBeURuSmZo?=
 =?utf-8?B?dkxUUGRGYVhNRVhWWDZ0MHFHQWJvcE81Y2hlNDY4djB1NjBUaHFIeUJDcFFj?=
 =?utf-8?B?TjQ3V3JsZzc5T0JPenlPM1c2ZE8xQ2FUbDJsV1ZSUk40QnFmZWQ2TGlEWWh6?=
 =?utf-8?B?RElySVZnNXNWYm5OYlFXU1BtRW5LQW9uUEY0bE9OL1B3L0gxdHdOVDJXWTdR?=
 =?utf-8?B?eEZBSnB5L0xyZkZFd3RYazlXbkpzYy9pdFYvL2szQTRVYnV5cXNQZ1NuMC8x?=
 =?utf-8?B?aEtwTlM4QVNXaTZjVXpDcStHWXl6bjJWODRNNldEZTR6K0tpd0pVY1FNZEZY?=
 =?utf-8?B?dS84SFFZNEFDYTVoQnEvL2EyTTdCOGtVSmR0YmFLYzBlNEV6QTNTL2wvcE1F?=
 =?utf-8?B?MlFDVlNPckJVVEoxbXhUVkFhRDZTVkxuY3RzUSsvYnZjamFGQ0x4OXo0QjI3?=
 =?utf-8?B?VzNFQXBGUmJHcnJCdlRSRmhkSlkzV2NYRzNOWlEvRytheGZWU2Z0aUV2MzJK?=
 =?utf-8?B?M1pGdHFKeDFtWkJUYzZYeG9FdlBiOU5raG13WmcwOGtVTFYrUmxpUXN2Mzls?=
 =?utf-8?B?QkNLQkFMamVMU1IvSklNTG02UE1ZM292VnMzcVB4TjBqVnpIR2E5OVRsbTdQ?=
 =?utf-8?B?dy9oWFFaRmc0NWx3bnJEZzJKNEVFeExXN3AzZTVveU85SGlBdlZxSWdrM3NW?=
 =?utf-8?B?aTdveXYrUk5BRWNxY3pMOWRwd1BOdE1jUmp5b05tWWpRTDhUTlEwcTRrbVN5?=
 =?utf-8?B?MDVLR0d6QUJNUEVxMFl3SUhzZHp1dCtyOGFDY3I0aUJybE1jZGhYeG1YNzVP?=
 =?utf-8?B?WTRkVHJqT3Fhd0YwKzFHWmdlc0x4NjhDV2Y4M2NoVUV4L2RNZXpHSmUzZ2d1?=
 =?utf-8?B?VEJEaDNnWmx5Rk1RaVRwaS9mZlNmbXUwWFRGVFFuVG9tZSt3Z01aKzZTRzEw?=
 =?utf-8?B?Z2w1c3B0b3kwN3FzbjAzNW9oVVdLRzAyb2cvSnZaRDRvd2Z1UVVkejl1UUY0?=
 =?utf-8?B?VFFkcEQwQ21LNDRxZmsza0tLNnZFVDlZZnFCaHNkT1ZTZGRXa0FLc2xxM1Rv?=
 =?utf-8?B?WDU2Wkw4UG9zZTJXTTN0WGtpaUFITURIVWdIMTRIRTJrd21sbm5sUjZ0anZU?=
 =?utf-8?B?cVA5VHQ1TDB1QU5aQWhQY1ZRcXpGUHlEZjkyeVV5a1RGaXkzMmdQRXR4dXp4?=
 =?utf-8?B?M2dCa1c3RWI4UjR6ODJnMFlzSG01TmpIeUN3VG1lcWMzK0loTHF2ODZxNHUw?=
 =?utf-8?B?eldVNGRTRWJtd0c2U1dzZFRIYk5reDQ1SSt0SjArb0s5YVRjWmtXa1FJdmdW?=
 =?utf-8?B?QmkwcjR2cHBuOTBKbWV0YU9iN1VNcGt4UURGUE8yN0xnenVObjN4MDlvWjVp?=
 =?utf-8?B?TGVZWVVYWW4yREt0b093NXNDVndSakxnWlJMa0VCc3lENWkrc3ByOE9mYWZo?=
 =?utf-8?B?Tk1XOXdlbVpUVitzdzAzWm9mL0ZnV3Yyd3lIbkQ1UW14UGFqZm9Kd1kwd25s?=
 =?utf-8?B?N3M1bUZoNkcwVVBhVEQrdTJaM1hGaDZYN2NtaHcvd2NCR2lKRGV0WURwWk5p?=
 =?utf-8?B?SVZMMm9EY0xra1lOS3BRQ21SZHhnbkFzQ2EyRkNOVkxITlROalUyUTVaS0Yx?=
 =?utf-8?Q?4O4fh8lsd/l17Yu8/e0GiImlXByBPZh3D/VkU3Y4S0=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <9C13E09D78265147A2ADF9351F43941E@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR11MB1392.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c96290d6-a75a-497a-0dd5-08d9e5b19ad1
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Feb 2022 18:35:21.3843
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: atqVi23nB+jyWumemtyPF0o0q7G5U03cZS3uVqWR5H33jcDDMVHqYE8x1dYd6uS9KSQOCA6ms4EEumNHceQxC2SY4gW4JCM+xasx/6kaErQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB4900
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVGh1LCAyMDIyLTAxLTI3IGF0IDA5OjU0IC0wODAwLCBpcmEud2VpbnlAaW50ZWwuY29tIHdy
b3RlOg0KPiAgZW51bSBwa3NfcGtleV9jb25zdW1lcnMgew0KPiAtICAgICAgIFBLU19LRVlfREVG
QVVMVCAgICAgICAgID0gMCwgLyogTXVzdCBiZSAwIGZvciBkZWZhdWx0IFBURQ0KPiB2YWx1ZXMg
Ki8NCj4gLSAgICAgICBQS1NfS0VZX1RFU1QgICAgICAgICAgICA9IDEsDQo+IC0gICAgICAgUEtT
X0tFWV9OUl9DT05TVU1FUlMgICAgPSAyLA0KPiArICAgICAgIFBLU19LRVlfREVGQVVMVCAgICAg
ICAgICAgICAgICAgPSAwLCAvKiBNdXN0IGJlIDAgZm9yIGRlZmF1bHQNCj4gUFRFIHZhbHVlcyAq
Lw0KPiArICAgICAgIFBLU19LRVlfVEVTVCAgICAgICAgICAgICAgICAgICAgPSAxLA0KPiArICAg
ICAgIFBLU19LRVlfUEdNQVBfUFJPVEVDVElPTiAgICAgICAgPSAyLA0KPiArICAgICAgIFBLU19L
RVlfTlJfQ09OU1VNRVJTICAgICAgICAgICAgPSAzLA0KPiAgfTsNCg0KVGhlIGMgc3BlYyBzYXlz
IHRoYXQgYW55IGVudW0gbWVtYmVyIHRoYXQgZG9lc24ndCBoYXZlIGFuICI9IiB3aWxsIGJlDQpv
bmUgbW9yZSB0aGFuIHRoZSBwcmV2aW91cyBtZW1iZXIuIEFzIGEgY29uc2VxdWVuY2UgeW91IGNh
biBsZWF2ZSB0aGUNCiI9IiBvZmYgUEtTX0tFWV9OUl9DT05TVU1FUlMgYW5kIGl0IHdpbGwgZ2V0
IGF1dG8gYWRqdXN0ZWQgd2hlbiB5b3UgYWRkDQptb3JlIGxpa2UgdGhpcy4NCg0KSSBrbm93IHdl
J3ZlIGdvbmUgYXJvdW5kIGFuZCBhcm91bmQgb24gdGhpcywgYnV0IHdoeSBhbHNvIHNwZWNpZnkg
dGhlDQp2YWx1ZSBmb3IgZWFjaCBrZXk/IFRoZXkgc2hvdWxkIGF1dG8gaW5jcmVtZW50IGFuZCB0
aGUgZmlyc3Qgb25lIGlzDQpndWFyYW50ZWVkIHRvIGJlIHplcm8uDQoNCk90aGVyd2lzZSB0aGlz
IGRvZXNuJ3QgdXNlIGFueSBvZiB0aGUgZmVhdHVyZXMgb2YgImVudW0iLCBpdCdzIGp1c3QgYQ0K
dmVyYm9zZSBzZXJpZXMgb2YgY29uc3QgaW50J3MuDQoNCg==
