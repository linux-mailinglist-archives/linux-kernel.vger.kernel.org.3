Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A29834610F8
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Nov 2021 10:19:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243630AbhK2JXB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Nov 2021 04:23:01 -0500
Received: from mga03.intel.com ([134.134.136.65]:44465 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243631AbhK2JVB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Nov 2021 04:21:01 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10182"; a="235862778"
X-IronPort-AV: E=Sophos;i="5.87,272,1631602800"; 
   d="scan'208";a="235862778"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Nov 2021 01:13:26 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,272,1631602800"; 
   d="scan'208";a="499254944"
Received: from fmsmsx604.amr.corp.intel.com ([10.18.126.84])
  by orsmga007.jf.intel.com with ESMTP; 29 Nov 2021 01:13:26 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx604.amr.corp.intel.com (10.18.126.84) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Mon, 29 Nov 2021 01:13:26 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20 via Frontend Transport; Mon, 29 Nov 2021 01:13:26 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.102)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.20; Mon, 29 Nov 2021 01:13:25 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JCCRvNZmQnTsRMRt3Sh2fcJEixyTrzDC+bocBe0S4WCX1TlS8IubBYV0r5/knJYT7M2JTxLKuvHJhUspwYsYt51IV8dSBQFqRsi/7V9fb5ZGrsZ6DjEABzBnK68Pwp2yfXO1c6w247uOljCBY3fUvADjkAiLmmkTrZaykc0D8OcS/eaZcQNFLHGPEriszNakMMFXe8vdI/NTm05QmkUzl548jiIkoX40GRsETu87Yc74na//Fm7vd/0wNjH1B9LXAhD+HHlSmCA3Uk/BMLL6DPb7suNg1o3rMPYgubp9DvFg26nwm6Np776JjCeE1IaC3VT6SOkSBUPOU8FXD/k3lA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gBHSi+0QilrZfQSiEz2xW/RPRGC0VkDp1k20YUxW6AM=;
 b=fRLCrsk8odmmm2ALYi0tKBJDWE3nP8LIWXQI6aa4nZgy7aBi/ID/n+/LNZx1M0A3IT0EyEiWyd75mRd0O95Pif/nt+Mck++ZZRG6DCG9rN3oCW1bNWXhTO6RiVcXZTK4sKFCd4SYK1LNPFoT2DzCVKlGFtHEFn/vYQyNdMpWO+yn22BeXu+/ejvd1+6S1Un20iajBNnkVEgiq4/7lVeaNl/RicGzVHFWOY8amJST3yBZ7ZoDyUr2pPMQw16lQFUr6fvpithitabZnMVevU/bFt1k5LU24GOlyQvJv3HjMzefT2ttnamoDJHXljZkRppcv7xpBJ1HzrCQbWLJiwVO/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gBHSi+0QilrZfQSiEz2xW/RPRGC0VkDp1k20YUxW6AM=;
 b=Sy1OR/EsSk36ARgM9HZ0ceB8UvSm6RmBKUjTQwQUx1pYQ1+9w8DAoIGZkBj5nAqdbd0WTDgkQ1Shw6pIOZfXrCItgsrxX/QjIbd0Sddly3jdIui9IAI2IJWsXKaKWPXirUOUq23Swd9EP/eXNq8VO65aM2FYW9q9p0rHcWu3xWc=
Received: from BYAPR11MB3207.namprd11.prod.outlook.com (2603:10b6:a03:7c::14)
 by SJ0PR11MB5119.namprd11.prod.outlook.com (2603:10b6:a03:2d6::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.22; Mon, 29 Nov
 2021 09:13:24 +0000
Received: from BYAPR11MB3207.namprd11.prod.outlook.com
 ([fe80::f0a6:e61:94db:53b3]) by BYAPR11MB3207.namprd11.prod.outlook.com
 ([fe80::f0a6:e61:94db:53b3%6]) with mapi id 15.20.4734.024; Mon, 29 Nov 2021
 09:13:23 +0000
From:   "Coelho, Luciano" <luciano.coelho@intel.com>
To:     "johannes@sipsolutions.net" <johannes@sipsolutions.net>,
        "sedat.dilek@gmail.com" <sedat.dilek@gmail.com>
CC:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Ben Ami, Golan" <golan.ben.ami@intel.com>
Subject: Re: [Linux v5.15 final] Call-trace iwlwifi and/or mac80211 (was
 [Linux v5.15-rc6] mac80211 warnings with iwlwifi)
Thread-Topic: [Linux v5.15 final] Call-trace iwlwifi and/or mac80211 (was
 [Linux v5.15-rc6] mac80211 warnings with iwlwifi)
Thread-Index: AQHXzv1HdCkjW88YWkyWTtmG9YLVQKwYCVqAgAJbYgA=
Date:   Mon, 29 Nov 2021 09:13:23 +0000
Message-ID: <18efeb0222687d9886b2b83eb4090f08d0493d9f.camel@intel.com>
References: <CA+icZUXzoQ4Rkms6WbLnnY7WSbcgt9t4vNTu17qyTQTLr6d1sw@mail.gmail.com>
         <CA+icZUUqw-LSJOrGYbmjMv8tHEN_eoq4nbgr8BxspQRFxNjVrA@mail.gmail.com>
         <CA+icZUUWj_-jgiA=NCmSP5zgk_fcEFN5+vKn7jLOFpbdQepSyw@mail.gmail.com>
In-Reply-To: <CA+icZUUWj_-jgiA=NCmSP5zgk_fcEFN5+vKn7jLOFpbdQepSyw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.42.1-1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: eb011e54-f690-4491-2ed8-08d9b3187ef0
x-ms-traffictypediagnostic: SJ0PR11MB5119:
x-microsoft-antispam-prvs: <SJ0PR11MB511912BE875D429E2D9E29F590669@SJ0PR11MB5119.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1060;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: q+n6Y0vLqzHMjmRbi7/Stx15B+xltonlOR/MlIWP0OqUFFBNIMxWiFsCnFiLot68CiYoZ9zsRnczRArhd4jMyAbiUlEHbxNSmvYhghOYuF+2bOOdCyEEpo6pE0Mn2BjrCBJ14teF9QXfvj3Cz4JsoLrxg6k/GiQ8Quml0vUnSnvw6XQABJlEqwKyxUJGkUXLr1O0EUgGo2KlqecjCPTIg431GlRrhahvOxCbByZMvjnJOYyjngySoWR5yMYKphmPGqdmP0cac4LClganWGanMd3u+m/S3h8xAUSwbU95TAb6DhWnXsZa61mJRvQ9s1rd11WWBIXH6++gUSigSCafEfCkeI+qUKa61viCdlzWcflWpgLMohQRVspV0p6nOAu9UZjLqbTnfmm5hCMNEqCFQ23XlKrRGlxiNl0UoGNTCDgxIXOMl4boxCNk6uo8uyiqFM4v19TKKrCaBkwhWnE4GBeNgN+XRaL/hjBeCRSMMOJ8m6Cso1lUBkAwLjgxACB3axJ3sNaSGB3bmBmWNAXyc0Ev1gDDyGXfqyf8Rf5O5tX55vbh3x+EUH3g510qu5FgRDzdiNvaHf889qWh2kMQIoiJ1fZSs1NzZsDv5s+wFBKaNZbHW4usqlNV49vbIhwjL/0SlckQZ5m/SJwqD1z25I2OvmBU8fnEGRSHdoxIvTuSBZHG23cZ2xZWbt7mupT3KSM1fdbjTsVQUoyx1IRu5g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3207.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(2906002)(4326008)(86362001)(6512007)(66476007)(122000001)(76116006)(26005)(54906003)(91956017)(66556008)(6486002)(64756008)(66946007)(4001150100001)(316002)(8676002)(107886003)(38070700005)(38100700002)(71200400001)(508600001)(110136005)(36756003)(2616005)(186003)(6506007)(82960400001)(8936002)(5660300002)(66446008)(83380400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NGF1dnFBeXlGRmJsbWtkMURxeGhrd1NiMERKQWkxU3lZS3ZVcUZ3T0F0Z09Z?=
 =?utf-8?B?RnVpcjVkc1NGQzJaNzBIRlN4eVM2a0llUGJpbDMzU3NiNTRjZmlkSmxrb3Vt?=
 =?utf-8?B?d0YrUEg0V3N3UGJnbkJjWEo5c1dRVUFETXFYZkJpOXlxVXh6TlhTZ0hiVVFk?=
 =?utf-8?B?N1FPeVlZUG8yZFJvb0RUUWF5ZDQybFhZeWtTN2pndkV3a3NKOEllcEozSnhS?=
 =?utf-8?B?OXlvUnZuSGZtTW5Tam5meHJWaUhEVk1LOTJQK0pPdExrdzhPdUl0THZlS3Vh?=
 =?utf-8?B?NTFQYWlZQ3FuMzVFN3JGMm5KNEwwa1lMYksrZ2hGUTBqa0cydHBDN1U4K3lx?=
 =?utf-8?B?M0dUejFLM1FMQW5zZUMvN3BzNGVZSTNBSXJvV0JvaFBYV2JXenp6bFRvSXE0?=
 =?utf-8?B?elV4TWU5SFJ6OXJpMTJ1eVFQZnBicExaMEk1VXg0SzRvS3RxRUh0NUQzUkNh?=
 =?utf-8?B?ZFNpM3hMcmU2NC9NTlh4aFhQMVUvNkpFdWZySDArQkVKdHIrRGtOVWUvd0E1?=
 =?utf-8?B?eVpsNlZzd0hvTXBNVlA3VkhaYmZwTk9aSnFrQm9rTVNmQ1BFMXkzRVJYQS9P?=
 =?utf-8?B?T0FvVmdoby9aZDVmWUtxaHFRK2pMcnNVSDFIU2F3cnJIMi9YNGNzZXB2azRI?=
 =?utf-8?B?eDlQV1E2K0toeW5yV0VuWXc0TEQ2VklOWlVtdGo3cFNYeGNraEVIb2FTNlNJ?=
 =?utf-8?B?UDg1RFJOSktKT1FXbEV3OWNqY0x4R3lZM0hZYmVkU2tnZ1NYM1dzQlh4Z2lp?=
 =?utf-8?B?b1YyL1NiVCs4WlpOd1hOUXpFMGVlaXM5UU5lbjlJUmdnbkMwbDhnOXR6eVhv?=
 =?utf-8?B?bnNIMThybUk5eVRKMS9BL3Q1RlRvME9ibVlmL1gxdUFST0RrNXMvcGcvUEdD?=
 =?utf-8?B?YmRtUFVVNlZ6NEY1UTlZa0huVzlHQjFlR25sVDlaWVhQUktaVmF6ODdCM0c2?=
 =?utf-8?B?OVJuanJBVTIzYitqdVlId3NVemFYcWprSGxjSUJ1YnA3Q25TbFVRMlJrL0or?=
 =?utf-8?B?VGF4TEY4SXhTcEtrcktnd1NLNjdMWm1tcERhYzNhQ1Avb2tYRkxQVVk3YkVP?=
 =?utf-8?B?STFPRGVYdVJ1TGJabGxBdXBEK2ZsYXcvNXFJbm1xM3g5RXZSYkYyZzlMZko3?=
 =?utf-8?B?QTJIKzhsd1UyQy9PQXR0M2Fqai9pWXZtNmNxUVB5djhINDU0cXF0OERoeVV4?=
 =?utf-8?B?eHIxQmV0ZXcvSTNRR3RtU0sxTWYxUSttcDlvVHBsTUpVUWhLRVlNYjlZNlM1?=
 =?utf-8?B?bjlWUE8rVnVZTkNYU2xXRDNrQUtRbGFtYlRTdjVBZ0ZMbExHMnh4aEdydWk5?=
 =?utf-8?B?L1B5aE5CWE5CVGhyeE9OZGlVTFI2ZmFUQnZtS3k3ZGFzR3RwMjlBdzlmSkZC?=
 =?utf-8?B?NlpTOG9rcDAxKzZDMmRGMEdpVFJRWkdSeUJ4U0NUWHRkOWQrWDR5Rm1TZmpJ?=
 =?utf-8?B?YjkwaWhVZlZ5UmtkQmtlVnFRQ2ZvanhWemROQjcwSlBNZDU0Zm8rNHBZZVNx?=
 =?utf-8?B?cmY4czFlM3pnQ3A2MkFOYmplSEJFNkc1SnVyK2prS1pONEI3cjBIRzJrbWo3?=
 =?utf-8?B?RjdoeTdpN2QxOWs4ZmxmRmZtRjhSV3ZzTzAvTUNoVFpvWTZpaER2VGVVdmd2?=
 =?utf-8?B?R3hQRDl1emIyU29TdlEzRWpON3phSjQvQ2tTQklWV1BKUHB1d3pib1BhNmVI?=
 =?utf-8?B?UFhRSFR2eUFLUGt0VHJaN0NtakVKTlhwclJva050T09ucC9wQm9MRldmekFB?=
 =?utf-8?B?Q202dnBBNU94R1NxNnFVT25QL0Iwd1E1ODh4RXB1YUNnUGF1YklKcWMwWkpy?=
 =?utf-8?B?SXJYaTg2ZDd6VnFoazkxYmNjZEZsTVd1VFgrQzk1V29qclZCT2NLS3RTbEc2?=
 =?utf-8?B?SlpQa1RNayt5UzFEVGx0ckVkSE9LSExQL0phRllQcEgzaUxxeWwyaVdxMXF4?=
 =?utf-8?B?Y3hDZ3U0dkd0TGpRcUg4eWR4a3Bqd1dxcGNiZ201SGpvQ1B3VmkwMkE0TTVG?=
 =?utf-8?B?WklxM0JXRzh3QTcrZTdtbWJCVnR0V0VxaHJWMFRCd3Q3TlZZOHBvcnJvbFVK?=
 =?utf-8?B?UjB1Q0VFeUs2OHdOZ3Y0Szg1aWY0dnJZK0pZUmluTjFCaUYyWENKd1E4b0xI?=
 =?utf-8?B?Zm4ybUFsRzVGZmtwZ3c2STNsdHFYYmRPN3lmVU40eEd6T3krVEkwYUtlKzdm?=
 =?utf-8?B?Q3ZEKzdVQW9LOWM3YXFFamo0RlVZMnBraUk2YmxmYTJNYmdCeGNTM3poVGlx?=
 =?utf-8?Q?UkZas0Qab8gfH+hFLyQRwVBoKLB75BRR3he9ZWlLs4=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D355CC2A9B461340A21A7CDAB3A608A7@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3207.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eb011e54-f690-4491-2ed8-08d9b3187ef0
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Nov 2021 09:13:23.9063
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: S2RZVkg4oz55V9zbLtrs2GniTqfae3kA1KfD/8xV/pB4Gx2fZXsdoxZ1Mv+JmZUdOs1NVNU1wTbbyZbkUBNMVgBaF+DL/AdBCAo90WbvLYc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5119
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gU2F0LCAyMDIxLTExLTI3IGF0IDIyOjEzICswMTAwLCBTZWRhdCBEaWxlayB3cm90ZToNCj4g
SGksDQo+IA0KPiBKdXN0IGp1bXBlZCB0byB0aGUgbGF0ZXN0IERlYmlhbi1rZXJuZWwuLi4NCj4g
DQo+ICQgY2F0IC9wcm9jL3ZlcnNpb24NCj4gTGludXggdmVyc2lvbiA1LjE1LjAtMi1hbWQ2NCAo
ZGViaWFuLWtlcm5lbEBsaXN0cy5kZWJpYW4ub3JnKSAoZ2NjLTExDQo+IChEZWJpYW4gMTEuMi4w
LTEyKSAxMS4yLjAsIEdOVSBsZCAoR05VIEJpbnV0aWxzIGZvciBEZWJpYW4pIDIuMzcpICMxDQo+
IFNNUCBEZWJpYW4gNS4xNS41LTEgKDIwMjEtMTENCj4gLTI2KQ0KPiANCj4gLi4uYW5kIHN0aWxs
IHNlZSB0aGVzZSBpc3N1ZXM6DQo+IA0KPiBbU2F0IE5vdiAyNyAyMTo1NzoyMCAyMDIxXSBpd2x3
aWZpIDAwMDA6MDE6MDAuMDogUkZfS0lMTCBiaXQgdG9nZ2xlZA0KPiB0byBlbmFibGUgcmFkaW8u
DQo+IFtTYXQgTm92IDI3IDIxOjU3OjIwIDIwMjFdIGl3bHdpZmkgMDAwMDowMTowMC4wOiByZXBv
cnRpbmcgUkZfS0lMTA0KPiAocmFkaW8gZW5hYmxlZCkNCj4gW1NhdCBOb3YgMjcgMjE6NTc6MjAg
MjAyMV0gaXdsd2lmaSAwMDAwOjAxOjAwLjA6IFJhZGlvIHR5cGU9MHgxLTB4Mi0weDANCj4gW1Nh
dCBOb3YgMjcgMjE6NTc6MjAgMjAyMV0gaXdsd2lmaSAwMDAwOjAxOjAwLjA6IFJhZGlvIHR5cGU9
MHgxLTB4Mi0weDANCj4gW1NhdCBOb3YgMjcgMjE6NTc6MjcgMjAyMV0gaXdsd2lmaSAwMDAwOjAx
OjAwLjA6IEVycm9yIHNlbmRpbmcNCj4gUkVQTFlfU0NBTl9BQk9SVF9DTUQ6IHRpbWUgb3V0IGFm
dGVyIDIwMDBtcy4NCj4gW1NhdCBOb3YgMjcgMjE6NTc6MjcgMjAyMV0gaXdsd2lmaSAwMDAwOjAx
OjAwLjA6IEN1cnJlbnQgQ01EIHF1ZXVlDQo+IHJlYWRfcHRyIDM1IHdyaXRlX3B0ciAzNg0KPiBb
U2F0IE5vdiAyNyAyMTo1NzoyNyAyMDIxXSBpd2x3aWZpIDAwMDA6MDE6MDAuMDogTG9hZGVkIGZp
cm13YXJlDQo+IHZlcnNpb246IDE4LjE2OC42LjEgNjAwMGcyYi02LnVjb2RlDQo+IFtTYXQgTm92
IDI3IDIxOjU3OjI3IDIwMjFdIGl3bHdpZmkgMDAwMDowMTowMC4wOiBIQ01EX0FDVElWRSBhbHJl
YWR5DQo+IGNsZWFyIGZvciBjb21tYW5kIFJFUExZX1NDQU5fQUJPUlRfQ01EDQo+IFtTYXQgTm92
IDI3IDIxOjU3OjI3IDIwMjFdIGl3bHdpZmkgMDAwMDowMTowMC4wOiAweDAwMDAwMDAwIHwgT0sN
Cj4gW1NhdCBOb3YgMjcgMjE6NTc6MjcgMjAyMV0gaXdsd2lmaSAwMDAwOjAxOjAwLjA6IDB4MDAw
MDAwMDAgfCB1UGMNCj4gW1NhdCBOb3YgMjcgMjE6NTc6MjcgMjAyMV0gaXdsd2lmaSAwMDAwOjAx
OjAwLjA6IDB4MDAwMDAwMDAgfCBicmFuY2hsaW5rMQ0KPiBbU2F0IE5vdiAyNyAyMTo1NzoyNyAy
MDIxXSBpd2x3aWZpIDAwMDA6MDE6MDAuMDogMHgwMDAwMDAwMCB8IGJyYW5jaGxpbmsyDQo+IFtT
YXQgTm92IDI3IDIxOjU3OjI3IDIwMjFdIGl3bHdpZmkgMDAwMDowMTowMC4wOiAweDAwMDAwMDAw
IHwgaW50ZXJydXB0bGluazENCj4gW1NhdCBOb3YgMjcgMjE6NTc6MjcgMjAyMV0gaXdsd2lmaSAw
MDAwOjAxOjAwLjA6IDB4MDAwMDAwMDAgfCBpbnRlcnJ1cHRsaW5rMg0KPiBbU2F0IE5vdiAyNyAy
MTo1NzoyNyAyMDIxXSBpd2x3aWZpIDAwMDA6MDE6MDAuMDogMHgwMDAwMDAwMCB8IGRhdGExDQo+
IFtTYXQgTm92IDI3IDIxOjU3OjI3IDIwMjFdIGl3bHdpZmkgMDAwMDowMTowMC4wOiAweDAwMDAw
MDAwIHwgZGF0YTINCj4gW1NhdCBOb3YgMjcgMjE6NTc6MjcgMjAyMV0gaXdsd2lmaSAwMDAwOjAx
OjAwLjA6IDB4MDAwMDAwMDAgfCBsaW5lDQo+IFtTYXQgTm92IDI3IDIxOjU3OjI3IDIwMjFdIGl3
bHdpZmkgMDAwMDowMTowMC4wOiAweDAwMDAwMDAwIHwgYmVhY29uIHRpbWUNCj4gW1NhdCBOb3Yg
MjcgMjE6NTc6MjcgMjAyMV0gaXdsd2lmaSAwMDAwOjAxOjAwLjA6IDB4MDAwMDAwMDAgfCB0c2Yg
bG93DQo+IFtTYXQgTm92IDI3IDIxOjU3OjI3IDIwMjFdIGl3bHdpZmkgMDAwMDowMTowMC4wOiAw
eDAwMDAwMDAwIHwgdHNmIGhpDQo+IFtTYXQgTm92IDI3IDIxOjU3OjI3IDIwMjFdIGl3bHdpZmkg
MDAwMDowMTowMC4wOiAweDAwMDAwMDAwIHwgdGltZSBncDENCj4gW1NhdCBOb3YgMjcgMjE6NTc6
MjcgMjAyMV0gaXdsd2lmaSAwMDAwOjAxOjAwLjA6IDB4MDAwMDAwMDAgfCB0aW1lIGdwMg0KPiBb
U2F0IE5vdiAyNyAyMTo1NzoyNyAyMDIxXSBpd2x3aWZpIDAwMDA6MDE6MDAuMDogMHgwMDAwMDAw
MCB8IHRpbWUgZ3AzDQo+IFtTYXQgTm92IDI3IDIxOjU3OjI3IDIwMjFdIGl3bHdpZmkgMDAwMDow
MTowMC4wOiAweDAwMDAwMDAwIHwgdUNvZGUgdmVyc2lvbg0KPiBbU2F0IE5vdiAyNyAyMTo1Nzoy
NyAyMDIxXSBpd2x3aWZpIDAwMDA6MDE6MDAuMDogMHgwMDAwMDAwMCB8IGh3IHZlcnNpb24NCj4g
W1NhdCBOb3YgMjcgMjE6NTc6MjcgMjAyMV0gaXdsd2lmaSAwMDAwOjAxOjAwLjA6IDB4MDAwMDAw
MDAgfCBib2FyZCB2ZXJzaW9uDQo+IFtTYXQgTm92IDI3IDIxOjU3OjI3IDIwMjFdIGl3bHdpZmkg
MDAwMDowMTowMC4wOiAweDAwMDAwMDAwIHwgaGNtZA0KPiBbU2F0IE5vdiAyNyAyMTo1NzoyNyAy
MDIxXSBpd2x3aWZpIDAwMDA6MDE6MDAuMDogMHgwMDAwMDAwMCB8IGlzcjANCj4gW1NhdCBOb3Yg
MjcgMjE6NTc6MjcgMjAyMV0gaXdsd2lmaSAwMDAwOjAxOjAwLjA6IDB4MDAwMDAwMDAgfCBpc3Ix
DQo+IFtTYXQgTm92IDI3IDIxOjU3OjI3IDIwMjFdIGl3bHdpZmkgMDAwMDowMTowMC4wOiAweDAw
MDAwMDAwIHwgaXNyMg0KPiBbU2F0IE5vdiAyNyAyMTo1NzoyNyAyMDIxXSBpd2x3aWZpIDAwMDA6
MDE6MDAuMDogMHgwMDAwMDAwMCB8IGlzcjMNCj4gW1NhdCBOb3YgMjcgMjE6NTc6MjcgMjAyMV0g
aXdsd2lmaSAwMDAwOjAxOjAwLjA6IDB4MDAwMDAwMDAgfCBpc3I0DQo+IFtTYXQgTm92IDI3IDIx
OjU3OjI3IDIwMjFdIGl3bHdpZmkgMDAwMDowMTowMC4wOiAweDAwMDAwMDAwIHwgaXNyX3ByZWYN
Cj4gW1NhdCBOb3YgMjcgMjE6NTc6MjcgMjAyMV0gaXdsd2lmaSAwMDAwOjAxOjAwLjA6IDB4MDAw
MDAwMDAgfCB3YWl0X2V2ZW50DQo+IFtTYXQgTm92IDI3IDIxOjU3OjI3IDIwMjFdIGl3bHdpZmkg
MDAwMDowMTowMC4wOiAweDAwMDAwMDAwIHwgbDJwX2NvbnRyb2wNCj4gW1NhdCBOb3YgMjcgMjE6
NTc6MjcgMjAyMV0gaXdsd2lmaSAwMDAwOjAxOjAwLjA6IDB4MDAwMDAwMDAgfCBsMnBfZHVyYXRp
b24NCj4gW1NhdCBOb3YgMjcgMjE6NTc6MjcgMjAyMV0gaXdsd2lmaSAwMDAwOjAxOjAwLjA6IDB4
MDAwMDAwMDAgfCBsMnBfbWh2YWxpZA0KPiBbU2F0IE5vdiAyNyAyMTo1NzoyNyAyMDIxXSBpd2x3
aWZpIDAwMDA6MDE6MDAuMDogMHgwMDAwMDAwMCB8IGwycF9hZGRyX21hdGNoDQo+IFtTYXQgTm92
IDI3IDIxOjU3OjI3IDIwMjFdIGl3bHdpZmkgMDAwMDowMTowMC4wOiAweDAwMDAwMDAwIHwgbG1w
bV9wbWdfc2VsDQo+IFtTYXQgTm92IDI3IDIxOjU3OjI3IDIwMjFdIGl3bHdpZmkgMDAwMDowMTow
MC4wOiAweDAwMDAwMDAwIHwgdGltZXN0YW1wDQo+IFtTYXQgTm92IDI3IDIxOjU3OjI3IDIwMjFd
IGl3bHdpZmkgMDAwMDowMTowMC4wOiAweDAwMDAwMDAwIHwgZmxvd19oYW5kbGVyDQo+IFtTYXQg
Tm92IDI3IDIxOjU3OjI3IDIwMjFdIGl3bHdpZmkgMDAwMDowMTowMC4wOiBTdGFydCBJV0wgRXZl
bnQgTG9nDQo+IER1bXA6IG5vdGhpbmcgaW4gbG9nDQo+IFtTYXQgTm92IDI3IDIxOjU3OjI3IDIw
MjFdIGl3bHdpZmkgMDAwMDowMTowMC4wOiBDb21tYW5kIFJFUExZX1JYT04NCj4gZmFpbGVkOiBG
VyBFcnJvcg0KPiBbU2F0IE5vdiAyNyAyMTo1NzoyNyAyMDIxXSBpd2x3aWZpIDAwMDA6MDE6MDAu
MDogRXJyb3IgY2xlYXJpbmcNCj4gQVNTT0NfTVNLIG9uIEJTUyAoLTUpDQo+IFtTYXQgTm92IDI3
IDIxOjU3OjI3IDIwMjFdIGllZWU4MDIxMSBwaHkwOiBIYXJkd2FyZSByZXN0YXJ0IHdhcyByZXF1
ZXN0ZWQNCj4gW1NhdCBOb3YgMjcgMjE6NTc6MjcgMjAyMV0gaXdsd2lmaSAwMDAwOjAxOjAwLjA6
IFJhZGlvIHR5cGU9MHgxLTB4Mi0weDANCj4gW1NhdCBOb3YgMjcgMjE6NTc6MjcgMjAyMV0gaXds
d2lmaSAwMDAwOjAxOjAwLjA6IFJhZGlvIHR5cGU9MHgxLTB4Mi0weDANCj4gW1NhdCBOb3YgMjcg
MjE6NTc6MjcgMjAyMV0gaXdsd2lmaSAwMDAwOjAxOjAwLjA6IFJhZGlvIHR5cGU9MHgxLTB4Mi0w
eDANCj4gW1NhdCBOb3YgMjcgMjE6NTc6MzIgMjAyMV0gaXdsd2lmaSAwMDAwOjAxOjAwLjA6IEZh
aWxlZCB0byBsb2FkIGZpcm13YXJlIGNodW5rIQ0KDQpbLi4uXQ0KDQo+ID4gPiBDYW4geW91IG1h
YzgwMjExIGFuZC9vciBpd2x3aWZpIG1haW50YWluZXJzIGxvb2sgYXQgdGhpcywgcGxlYXNlPw0K
PiA+ID4gDQo+ID4gPiBBdHRhY2hlZCBhcmUgbXkga2VybmVsLWNvbmZpZyBhbmQgZnVsbCBkbWVz
Zy1sb2cuDQo+ID4gPiANCj4gPiA+IElmIHlvdSBuZWVkIGZ1cnRoZXIgaW5mb3JtYXRpb24sIHBs
ZWFzZSBsZXQgbWUga25vdy4NCg0KQ2FuIHlvdSBwbGVhc2UgZmlsZSBhIGJ1ZyBpbiBidWd6aWxs
YSBhYm91dCB0aGlzPyBUaGVuIGl0J3MgZWFzaWVyIGZvcg0KdXMgdG8gdHJhY2sgYW5kIGFzc2ln
bi4NCg0KVGhhbmtzIGZvciByZXBvcnRpbmchIFdlJ2xsIHRyeSB0byBjb21lIHVwIHdpdGggYSBm
aXggYXNhcC4NCg0KLS0NCkNoZWVycywNCkx1Y2EuDQo=
