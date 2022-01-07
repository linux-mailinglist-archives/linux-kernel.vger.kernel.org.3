Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD899487BCD
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jan 2022 19:06:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240570AbiAGSGx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jan 2022 13:06:53 -0500
Received: from mga02.intel.com ([134.134.136.20]:24041 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230138AbiAGSGv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jan 2022 13:06:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1641578811; x=1673114811;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=hvsMwYgX4i5eMi3wwMHa4cl3kWBNxnhx3rRMqSI9ZWQ=;
  b=c5QBYFo8ZdCVgaKclIEK3AIcMo1lylmXVkSQiKey4dCgy8u8H7m0CyC8
   aZKA0Ck+yP3dyBY0YFL74MjEXKk8TMbhKll3K3GtjRX0QsbxHoC0Ni5/U
   eBUhbyaQ4rJtLN9NjV2o6qXCKvQ3QFiB7AlB1JtriWYrgJ13pBV38dy89
   tI6/Fx/Dgcu42onEL0A0IlCfpGh49cudyiZlbsJoZceDGf19MFNLq5M4r
   e6z9jZuraMFMZx94PYxBZGYCNs1gJDL1nUb1WEUsgx8Ap+jQtUyL8hgyg
   BqG30nGzmskrtSSy47gte4PjI4j5DGZgwEcppWa2VDicfNBFnO3cfyO+f
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10219"; a="230251726"
X-IronPort-AV: E=Sophos;i="5.88,270,1635231600"; 
   d="scan'208";a="230251726"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jan 2022 10:06:28 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,270,1635231600"; 
   d="scan'208";a="527450801"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga008.jf.intel.com with ESMTP; 07 Jan 2022 10:06:27 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Fri, 7 Jan 2022 10:06:27 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20 via Frontend Transport; Fri, 7 Jan 2022 10:06:27 -0800
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.49) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.20; Fri, 7 Jan 2022 10:06:27 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jkETLZ7MerBAl0t+GwbEs3S/ZJqBqVcmJIMT+aQFj164/DtrCD5PfkR76ReBtXZ6/ixTv/h+m5aoPDzZZ5VlCF+Cjsew7VnrEJdJIhr8zK8I0RVvDAaSIusNAmeqCuatXaHy1LvfgIWWA7qSLsBDy5Q17dovFIitWd7msuni1LR3abrKC7qpUfNHR6oDoREzbgs8IJnFLRQo9YceAeuI2VHQkbNIzmwXYda+ypk/OCcMXPfGDSvpqd0AO5kq01PGpgcl2oTKFAVINFCUwDHsL4FTk7pAlb2DzKfHkOCFwIxXUj3eavbjlycgxffhzHoegNTEC/XeSRw6otp99hCN7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hvsMwYgX4i5eMi3wwMHa4cl3kWBNxnhx3rRMqSI9ZWQ=;
 b=fikVlZGZps7LT7xnZnphaiHviIwmrsjQhJPKSFnW8p91ZpOm5yKbmIDY6z9sCF0xLCZ07ET4brIKVrAcN/Pc1FlwiZdL/dxmhTGUnmwQyt1iu2hIthX8E+Dm3f78m2zOir5KfmOp5K7DlEYf/cI1SA4Yc/TjlH8dflXGUq9tFyex0Rgv2S0L3DEx8kPd70UHlcdsZsKgYH2tbdsqluP3tgfzK1+iWAy8it31usV/yEiw/Gc9ZcWcHvl044fTnoNokvzVvAYrkULRJGwtv8sE4ksqoVSKJROVnYdJEal8ezWAZ4oEnsM09eondN88l+Dsx1HfyHqIJbdknZ0dfSxdXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB4855.namprd11.prod.outlook.com (2603:10b6:510:41::12)
 by PH0PR11MB5830.namprd11.prod.outlook.com (2603:10b6:510:129::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.7; Fri, 7 Jan
 2022 18:06:26 +0000
Received: from PH0PR11MB4855.namprd11.prod.outlook.com
 ([fe80::38cc:22c0:928a:95b7]) by PH0PR11MB4855.namprd11.prod.outlook.com
 ([fe80::38cc:22c0:928a:95b7%9]) with mapi id 15.20.4844.019; Fri, 7 Jan 2022
 18:06:26 +0000
From:   "Bae, Chang Seok" <chang.seok.bae@intel.com>
To:     "Lutomirski, Andy" <luto@kernel.org>
CC:     Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@suse.de>,
        "Dave Hansen" <dave.hansen@linux.intel.com>,
        Ingo Molnar <mingo@kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        "herbert@gondor.apana.org.au" <herbert@gondor.apana.org.au>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        "ebiggers@kernel.org" <ebiggers@kernel.org>,
        "Williams, Dan J" <dan.j.williams@intel.com>,
        "Gairuboyina, Charishma1" <charishma1.gairuboyina@intel.com>,
        "Dwarakanath, Kumar N" <kumar.n.dwarakanath@intel.com>,
        "Krishnakumar, Lalithambika" <lalithambika.krishnakumar@intel.com>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>
Subject: Re: [PATCH v4 11/13] crypto: x86/aes-kl - Support AES algorithm using
 Key Locker instructions
Thread-Topic: [PATCH v4 11/13] crypto: x86/aes-kl - Support AES algorithm
 using Key Locker instructions
Thread-Index: AQHX8IXqtkcMtyZtMkmGZeGWOjOYXqxB+j6AgBYHRYA=
Date:   Fri, 7 Jan 2022 18:06:26 +0000
Message-ID: <5BAC2E0A-63C9-4671-AB69-693F9C874395@intel.com>
References: <20211214005212.20588-1-chang.seok.bae@intel.com>
 <20211214005212.20588-12-chang.seok.bae@intel.com>
 <75ec3ad1-6234-ae1f-1b83-482793e4fd23@kernel.org>
In-Reply-To: <75ec3ad1-6234-ae1f-1b83-482793e4fd23@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3608.120.23.2.7)
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 32d2f931-b631-41ca-7bdb-08d9d2086bf6
x-ms-traffictypediagnostic: PH0PR11MB5830:EE_
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr,ExtFwd
x-microsoft-antispam-prvs: <PH0PR11MB583072D7298DCAB5A2EACDD2D84D9@PH0PR11MB5830.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: VNQ7wkwjdnQPYFRJy7/HqmYckTTu/MzmcMqT4V8CutJWfuNc0HKFSQNiHR+LQefMeCLh7AL0yHpRy4/DLCn7VVtQtDN+yQgM/MOeGOUAv6m6wzIY6jqMY3oGGZ7qF+E84HJp7F9FWkxxqLrgUZv2uQOgnI2kmW8FAeu/Y3bnnJNVtkHRigqcCnrPH4hKjYQsTBrb3UWx1EPaGzq4fpaNVPVJswe+iCuZBw19XGxpa6JTAUbJOMbS7zyIvP9H84ZHcJ6TW3XlBr58G+v1yCxOJSRJ5dxH7XXvNWhpxObuiLt5iyXZt4erScfi8yfv0FgamJ7giQ3v3nS22xSZW56jWJ64WVVDghGC3iJgAspLBEXgmj/JxXxT4uD30Ql4lHyl/ATrphiFdFiRmoU0Mm18zT7C0ynWxyw/yf3B14Kfhtj89qIC6kRs678cokLusmzWJVgXL3w7fOwRACiGlvOjXetsBYE3I9zywVs+LusmU40oxLRn19TTaCFGeZoeiHd4CfAiOcEnTglSUWhGZUNdIWZmRMG/Hipg6/3nLMZZHhg8c05/xFfhMGIWSoH16cKppfwyH3KZnxwdffz1xptTj1apgeuhx5Yn9xMjJ4wWbfyTi3EHYxYnL6iMI5UOzPbWUri8m/EZ6eyOVn1tcTHIv7bSbHq2PEcFs3zSHwzdyy5PrKk4STBgj9Cjg4MdoHlxgBMmoV3Y+tv4Ubj4p/ILkqSqn+Pr0te7liKOvY2fNdOceZMvkak7/xDO92L1h3prF4tdIJUxhD99piE6QLzbucYrsvpWqz4JpXHsxHTn9AL1L1pJSrIplLvvoqbi8Ewb
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB4855.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(54906003)(6512007)(33656002)(83380400001)(8936002)(966005)(71200400001)(6506007)(2616005)(36756003)(508600001)(6916009)(82960400001)(38070700005)(5660300002)(2906002)(316002)(76116006)(66946007)(66556008)(66476007)(64756008)(4326008)(86362001)(186003)(26005)(53546011)(7416002)(8676002)(122000001)(6486002)(66446008)(38100700002)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aWVFaTBoSVlqZ0ZNNDh4QVBYZWVEMnpaQkgyZFQwd001cjdSSEJ4SHo4K25E?=
 =?utf-8?B?Rk1UMFZEdnV5YllsVk9JWVBZUVF5MEVCWWh2Z2prOGhyVnRnbWZlK2pLdnQr?=
 =?utf-8?B?MGZIdExoY2RoQVM5UVNIVUNWRTl6SEQ4RTlXMnhydVpiNWlyWHY4TzdaYnBt?=
 =?utf-8?B?bVQ1ODRnU2w4RmhmV01KUG90Q0dmbDRtdGlwY3BNd2p5Q0N0NlpGRTAyVXk3?=
 =?utf-8?B?aElTb2lDQmhnVzlwN0hvVTZaZWhOM0xsYURUem12UmNGaEluTHF0ZDQ0Zll0?=
 =?utf-8?B?Y2JoeXo2YlFkV056bGczcjl2N3ZDemFqQXJsTkZ5MC9FZ3Z3aHVMTW8xaXY3?=
 =?utf-8?B?N2RoMS9TbmlFMnFOa0UwblduNkM2NEcyejFzS3BLYVJnMVpuWUlqTnozWTJV?=
 =?utf-8?B?L2paUUhCN1oya2NxaXBRd0xpMVZ1b3dodnNCYkNpYU1qOEtURHM3WTJEWUls?=
 =?utf-8?B?Z3pETmxMWDBtcThmUnc1cThLa2hlNUh0VzFlWk9icHJ4N2txNFVNT1czL25p?=
 =?utf-8?B?TUdhMnJsOVpVUXNYRjg5cG9PYTlXeERaN3NJblJnZURuZ3VqMyt2SkVtTExk?=
 =?utf-8?B?NXVUeHljTmNSRHorbHlPbUtFQTJsNFZjc1NZVXJXMnFBYVpZaFUyNGdGV0JI?=
 =?utf-8?B?bXdkdW0rTStjaHlMditIendmc011NzlOZ00wUzF5QlNoNmhOMzJESUNhb04y?=
 =?utf-8?B?VXU1SEpTUTNoQStwR2lBMnVmaGRBWE1RdW5RcUIrcE9NWE5RQ3MrQmpqWTcv?=
 =?utf-8?B?cU8yREdxS2pheVBQMEZEcmZDQjBkTkJkZ3Q4Qlp6NE9XT1FJbHppSmxrNU9H?=
 =?utf-8?B?RGROZEZZNmpTSjFYTHRkeDlnZmFqMm54UFJoaUpvS0VaNG1kREY2VEdVUnAw?=
 =?utf-8?B?WlE5Mmx5cnl5UUxhaFk2OWFzZjNmSzhtZ0hESTl2Q24rRCt5WmdYUE9vZWdz?=
 =?utf-8?B?bU1VdXE4VE1rZVFlTzQzK0s1U0tvdnUxaTBSMy90WS9WTTFZTlN3NGpxN3M1?=
 =?utf-8?B?TFhnWVJPdXBUT3FRTVl0RWFTemlqQzZEMHN0UVlzT2NRanYzV3QweVJjU2Vj?=
 =?utf-8?B?MExjMlkxRGczL01pTFlGd0tMVlg0NDVRTVNxUUVaNzgreCtkSUhnVTBjM1pD?=
 =?utf-8?B?NzEvZjMwdDZJT0xPMGlEZldpaGl5cHJEN2Vqc3NDdXZzdUxRc3E0eUhkZS8x?=
 =?utf-8?B?Zyt1NytwdStoUHdZYWp5OEgxbFJUemFQbnJIM3B2clU4VWMwUGFFZlUwbjJl?=
 =?utf-8?B?bFdVUXRHZkd2cEhMSUIrc0hjVXhrOWNiMUthY0Y1Wi8xL1VnblI1L0RVR3U4?=
 =?utf-8?B?bWhoSHpmWnhrMFk4SG5ydnR2TzBMRlBKbGJBWjZDSk9Wa0VUdWZKY3FOSE5M?=
 =?utf-8?B?a29qeXB4dGoyWk56Mk9FYm5MNDBMb0JDVy96WVZUVXF4VGN3YTRrcjRBWUJr?=
 =?utf-8?B?T2hnaGYxZlJtS1drelFSbzduMHEzZVM3aWxmdTNtT1ZIemFxZEVaZUlqQTdy?=
 =?utf-8?B?enhXWW80ZU5FRU5KK3dBajdzZlQ4U3puTVIrOG5vSDV5anB5TkxkRjlHQWRk?=
 =?utf-8?B?enBDNkM3MXIvbTZsME9Xdm5aTzIxNlM4WlFHNGxqM0lMSEpCZHBKZVpxNkFZ?=
 =?utf-8?B?cHNMbGtQejFvK0tMTmtZVE9OL0ovNjBtTDE1amZQK2hjZ1BrQ2hGRFN2dGcr?=
 =?utf-8?B?Z0lWejZGNGx1MmJhQXUzTk1QdG1VUXBJM01YK1lQckEvTmZzakxZenVVRDVQ?=
 =?utf-8?B?UE1DdTBXZHppNk1samFsVFlhclNOaDNUWnZYWVNjVjRYUWNQaUlhWGo4eTJl?=
 =?utf-8?B?WDFVNkxsTmR2YjNZclRXZEcwRDJsYml1NVVZTm5Xb1k5TkgrL2w1ekIzSW1G?=
 =?utf-8?B?U0JJRVdpS2RFaitDb3BMZXNaOEF5cGtMSUNtVnVVdHBDSDI2UVJDOVplOU9p?=
 =?utf-8?B?a28zUmduVDU3cURuSW5xTU53THRBM1dOMmh3WkdkSG9Mc281ZTJLR3dzV2FW?=
 =?utf-8?B?WDRkMmFvVlFVa1AvQ3UrWmxMMk1wb0lSNEhBWnFIODExbWJTRWtZNlA2QjlJ?=
 =?utf-8?B?TFNyVm9UT0lxZW9VLzdZKzRDTERwSnRqRERVRy9rU3krQjcxS1ZvaU81NEd5?=
 =?utf-8?B?ajQ1YWZvV2lZY3ZZQkdkaTBiSHZXNFNIL1BndUN1Zy9aa0IzZld5R2p3TUJB?=
 =?utf-8?B?VFpwSm84cU85QTlVVzZ1MFRHellHdDlSeUxmaGxLR2hzUjkxdWd5VnJoa2Vk?=
 =?utf-8?Q?3p2IGNWN2iA6r56m3vQ51C82q6ZDXlOZSRBpfosY3k=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <DAEAD973D291214498C28AB3E2783279@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB4855.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 32d2f931-b631-41ca-7bdb-08d9d2086bf6
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jan 2022 18:06:26.1429
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SwLzqCffO+JCQwE/Wer1yNbpqjDSdbJqKWiaFM19Ixcfdp3BGeJ3l8FJhsgkjUNqR/Q5J1sf2oLkI1mHCdGaGWPT8h58imm0trC9UB1v2zM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5830
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gRGVjIDI0LCAyMDIxLCBhdCAwOTo0MiwgQW5keSBMdXRvbWlyc2tpIDxsdXRvQGtlcm5lbC5v
cmc+IHdyb3RlOg0KPiANCj4gSSBmaW5kIGl0IGEgYml0IGJpemFycmUgdGhhdCB0aGlzIHRyaWVz
IHRvIGJlIGEgZHJvcC1pbiByZXBsYWNlbWVudCBmb3Igbm9ybWFsDQo+IEFFUy4gIElzIHRoaXMg
YWN0dWFsbHkgd2hhdCB3ZSB3YW50LCBvciBkbyB3ZSB3YW50IHVzZXJzIHRvIG9wdCBpbiB0byB0
aGUgS0wNCj4gaW1wbGVtZW50YXRpb24/DQo+IA0KPiBJdCBzZWVtcyBsaWtlIGl0IG1pZ2h0IG1h
a2UgbW9yZSBzZW5zZSBmb3IgdG9vbHMgbGlrZSBjcnlwdHNldHVwIChvciBkbS1jcnlwdA0KPiAt
LSB0aGUgYWN0dWFsIGxheWVyIGlzIHN1YmplY3QgdG8gc29tZSBkZWdyZWUgb2YgZGViYXRlKSB0
byBleHBsaWNpdGx5IGNyZWF0ZQ0KPiBhIGtleSBoYW5kbGUgYW5kIHRoZW4gYXNrIHRoZSBrZXJu
ZWwgdG8gdXNlIHRoYXQga2V5IGhhbmRsZSwgbm90IGZvciB0aGUNCj4ga2VybmVsIHRvIGRvIHRo
aXMgYnkgbWFnaWMuDQoNClllYWgsIGl0IGlzIGlkZWFsIHRvIGVuY29kZSBhIGtleSBlYXJseSBi
dXQgaXQgd2FzIGNvbnNpZGVyZWQgbGVzcyBzaWduaWZpY2FudA0KaW4gdGVybXMgb2Yga2V5IHBy
b3RlY3Rpb24gdmVyc3VzIGRvaW5nIGl0IHZpYSBzZXRrZXkoKS4NCg0KVGhpcyBvcHQtaW4gbG9v
a3MgdG8gYmUgdGhlIC0tY2lwaGVyIG9wdGlvbiBzcGVjaWZpYyBhbmQgY3J5cHRzZXR1cCBldmVu
DQphbGxvd3MgdXNlcnMgdG8gZGlyZWN0bHkgY2hvb3NlIGtlcm5lbOKAmXMgY3J5cHRvIEFQSSB2
aWEg4oCcY2FwaTrigJ0uDQoNCkkgc3VzcGVjdCBpbiBjYXNlIGEgdXNlciB3YW50cyB0byBwaWNr
IGEgc3BlY2lmaWMgY3J5cHRvIGltcGxlbWVudGF0aW9uIHZpYQ0K4oCcY2FwaTrigJ0sIG9uZSBz
aG91bGQgaGF2ZSBzdHVkaWVkIGl0Lg0KDQpCdXQgaW5kZWVkLCBzdWNoIHF1ZXN0aW9uIGRlc2Vy
dmVzIG1vcmUgZGlzY3Vzc2lvbiBoZXJlLg0KDQo+IFdoYXQgaGFwcGVucyB3aGVuIHNvbWVvbmUg
YXBwbGllcyB5b3VyIHBhdGNoZXMgYW5kIHJ1bnMgZG1zZXR1cCB0YWJsZQ0KPiAtLXNob3drZXlz
Pw0KDQoiZG1zZXR1cCB0YWJsZSAtLXNob3drZXlzIiBbMV0gc2hvd3MgVVVJRCB0aGF0IGNvdWxk
IGJlIGZvdW5kIHdoZW4gZHVtcGluZyB0aGUNCm1hc3RlciBrZXkgYnkgZ2l2aW5nIHRoZSBwYXNz
cGhyYXNlLCBsaWtlIFsyXS4gVGhlIHZvbHVtZSBrZXkgaW4gTFVLUyBoZWFkZXINCmlzIHVuZGVy
IHRoZSB1c2VyIGtleS4NCg0KPiBXaHkgc2hvdWxkIHRoZSB1c2Ugb2Yga2V5bG9ja2VyIGJlIHBh
cnQgb2YgdGhlIGx1a3NGb3JtYXQgb3BlcmF0aW9uPyBTdXJlbHkgYQ0KPiBub24tS0wgbWFjaGlu
ZSBzaG91bGQgc3RpbGwgYmUgYWJsZSB0byBkZWNyeXB0IGEgbm9taW5hbGx5IEtMLXVzaW5nIHZv
bHVtZSBpbg0KPiBhIHBpbmNoLCBmb3IgcmVjb3ZlcnkgcHVycG9zZXMgaWYgbm90aGluZyBlbHNl
Lg0KDQpJIHdhcyB0cnlpbmcgdG8gZGlyZWN0bHkgdXBkYXRlIGNpcGhlciBpbmZvcm1hdGlvbiBp
biBMVUtTLiBCdXQgaXQgd2FzIG5vdA0KdGhhdCBzbW9vdGguIEJ1dCBpZiBpdCBpcyBwb3NzaWJs
ZSBpbiBhbiBhY2NlcHRhYmxlIHdheSwgZGVjb2RpbmcgS0wtdm9sdW1lDQp3aXRoIGEgZ2VuZXJp
YyBBRVMgKG9yIHZpY2UgdmVyc2EpIHNob3VsZCB3b3JrLiANCg0KVGhleSBib3RoIGFyZSBBRVMg
ZGF0YSB0cmFuc2Zvcm1hdGlvbnMgc28gY29tcGF0aWJsZSB3aXRoIGVhY2ggb3RoZXIuIFRoaXMg
d2FzDQphbHNvIHRlc3RlZCBieSBzZXR0aW5nIHRoZSBkZWZhdWx0IEFFUyBjaXBoZXIgaW4gdGhl
IExVS1MgdGhlbiBzd2l0Y2hpbmcgZWFjaA0Kb3RoZXIgYnkgdHdlYWtpbmcgdGhlIHByaW9yaXR5
Lg0KDQpPbiB0aGUgYm90dG9tLCB0aGUgInJlZW5jcnlwdCIgb3B0aW9uIFszXSBhbGxvd3MgdXBk
YXRpbmcgYSBjaXBoZXIgaW4gdGhlIExVS1MNCmZvcm1hdC4gQnV0IG1heWJlIGEgYmV0dGVyIG9w
dGlvbiBsaWtlIHRoZSBhYm92ZSBpcyBwb3NzaWJsZS4NCg0KVGhhbmtzLA0KQ2hhbmcNCg0KWzFd
DQokIHN1ZG8gZG1zZXR1cCB0YWJsZSAtLXNob3drZXlzIC9kZXYvbWFwcGVyL3ZvbHVtZQ0KMCA0
OTE1MjAgY3J5cHQgY2FwaTp4dHMtYWVzLWFlc2tsLXBsYWluNjQgOjMyOmxvZ29uOmNyeXB0c2V0
dXA6OGMxMmJmZGEtMzU3MC00MDZhLWI0ZmUtNWVjZjFlOTFlZWNkLWQwIDAgNzoxNyAzMjc2OA0K
DQpbMl0gDQokIHN1ZG8gY3J5cHRzZXR1cCBsdWtzRHVtcCAgLS1kdW1wLW1hc3Rlci1rZXkgLi90
ZXN0DQoNCldBUk5JTkchDQo9PT09PT09PQ0KSGVhZGVyIGR1bXAgd2l0aCB2b2x1bWUga2V5IGlz
IHNlbnNpdGl2ZSBpbmZvcm1hdGlvbg0Kd2hpY2ggYWxsb3dzIGFjY2VzcyB0byBlbmNyeXB0ZWQg
cGFydGl0aW9uIHdpdGhvdXQgcGFzc3BocmFzZS4NClRoaXMgZHVtcCBzaG91bGQgYmUgYWx3YXlz
IHN0b3JlZCBlbmNyeXB0ZWQgb24gc2FmZSBwbGFjZS4NCg0KQXJlIHlvdSBzdXJlPyAoVHlwZSB1
cHBlcmNhc2UgeWVzKTogWUVTDQpFbnRlciBwYXNzcGhyYXNlIGZvciAuL3Rlc3Q6DQpMVUtTIGhl
YWRlciBpbmZvcm1hdGlvbiBmb3IgLi90ZXN0DQpDaXBoZXIgbmFtZTogICAgY2FwaTp4dHMNCkNp
cGhlciBtb2RlOiAgICBhZXMtYWVza2wtcGxhaW42NA0KUGF5bG9hZCBvZmZzZXQ6IDMyNzY4DQpV
VUlEOiAgICAgICAgICAgOGMxMmJmZGEtMzU3MC00MDZhLWI0ZmUtNWVjZjFlOTFlZWNkDQpNSyBi
aXRzOiAgICAgICAgMjU2DQpNSyBkdW1wOiAgICAgICAgM2EgNTEgMzcgNjAgMzcgZDIgNTggOWYg
NDggYTcgY2UgNDQgZjcgZmYgZGUgMzQNCiAgICAgICAgICAgICAgIDRkIGI5IDZmIGViIGYyIGU3
IGQ2IGJjIGUwIGM5IDc2IGI2IDNkIGIxIGU2IDI0DQoNClszXSBodHRwczovL21hbjcub3JnL2xp
bnV4L21hbi1wYWdlcy9tYW44L2NyeXB0c2V0dXAtcmVlbmNyeXB0LjguaHRtbA==
