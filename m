Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BFEDD46E0B4
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 03:06:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229838AbhLICKM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Dec 2021 21:10:12 -0500
Received: from mga03.intel.com ([134.134.136.65]:21765 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229534AbhLICKL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Dec 2021 21:10:11 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10192"; a="237938075"
X-IronPort-AV: E=Sophos;i="5.88,190,1635231600"; 
   d="scan'208";a="237938075"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Dec 2021 18:06:38 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,190,1635231600"; 
   d="scan'208";a="564468852"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga008.fm.intel.com with ESMTP; 08 Dec 2021 18:06:29 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Wed, 8 Dec 2021 18:06:29 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20 via Frontend Transport; Wed, 8 Dec 2021 18:06:29 -0800
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.168)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.20; Wed, 8 Dec 2021 18:06:29 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dIdqCg0lQmhV3MypuQCCV0AVvjGR10s5U42+mN4PcvfHixMJgvyz73F58MpPXXd/V8wiwm+K53uMg4KlKtWzRrm+OzeTnmjCXLnjHzo30LzH8kJQ5/lKFMKVf4sRxw415HT7F9eaQjldVbC8MiJbPAjAn8/RUjlFc3fpEZM9zzbk3U1KrcWCuaOBN7VQl7UrGE8ckG/+IRM9liN5yTkgLL51xiIoARtkcLd3Cr8f5MfNK76NUWsMFHBCTWicY7nSI3NtkLuuzMAMUWiWED0ZmJIQKGx0R6NwnGJdlGSy3CyahxL7nsm8FEdfNKbTvnRKvNkcRyRDt3MECpf9coDcGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pG+fKV2HcQK0ODa2mdmQv/dHBXHLsLQhS8p3gG+Q72Y=;
 b=ZhhD1lEjX+1OgNemX/dbaA6GsxOBKtCSzmbFQ7u3rGua5qLBY0vjzAkG7QKYe/zstuXUQPquU7Z4FwXFvNli3V20RR/w1ef3CocgbI64XGjZKLaXKO2XzPHanC0rc2zuakJWoZdQCqBdziiVCxgmWFcKv7J1hK23lIzHzRWA8AR8YYymonHsf1SfuIB12mDPUafmSksLdu2nsDN+yawkF2GO95Zx7vB8YPwW8Cy5EupVRfm81d9DK0pWWtBwkJctx5mXgaHyoIxYsZpLlGkxz0ZKmr0ygzUkjRRQflwles/CaZl+wRj0qXISLowvf8/BBH6Q2fguLXDMWjm8Q576pQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pG+fKV2HcQK0ODa2mdmQv/dHBXHLsLQhS8p3gG+Q72Y=;
 b=pQTB0kRQCfjK28PrgFQiGbeR68upA4LavnJVI7qEzsuwnlGNmRX1rnle961+Np3gNQino+SjJnM9fOuxOKfTFClvbghm6S9VGDE77akeCI9GfOvDlGbrDoxXRQu/Jsz6RPNagucwmnTciqfPwe/TfkqNUekEt20aEDh2ybvh4aM=
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by BN6PR11MB1747.namprd11.prod.outlook.com (2603:10b6:404:102::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.14; Thu, 9 Dec
 2021 02:06:27 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::5c8a:9266:d416:3e04]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::5c8a:9266:d416:3e04%2]) with mapi id 15.20.4755.016; Thu, 9 Dec 2021
 02:06:27 +0000
From:   "Tian, Kevin" <kevin.tian@intel.com>
To:     "Jiang, Dave" <dave.jiang@intel.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>
CC:     "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Joerg Roedel <joro@8bytes.org>,
        Christoph Hellwig <hch@infradead.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>,
        "Pan, Jacob jun" <jacob.jun.pan@intel.com>,
        "Lu Baolu" <baolu.lu@linux.intel.com>,
        "Raj, Ashok" <ashok.raj@intel.com>,
        "Kumar, Sanjay K" <sanjay.k.kumar@intel.com>,
        "Luck, Tony" <tony.luck@intel.com>,
        "Liu, Yi L" <yi.l.liu@intel.com>, Barry Song <21cnbao@gmail.com>,
        "Zanussi, Tom" <tom.zanussi@intel.com>,
        "Williams, Dan J" <dan.j.williams@intel.com>
Subject: RE: [PATCH 4/4] dmaengine: idxd: Use DMA API for in-kernel DMA with
 PASID
Thread-Topic: [PATCH 4/4] dmaengine: idxd: Use DMA API for in-kernel DMA with
 PASID
Thread-Index: AQHX67qzSUJug20b70uAfG58CL05gawok3UAgABwHwCAAAnPAIAAGPmAgAAb5gCAAAkpgIAAHjqw
Date:   Thu, 9 Dec 2021 02:06:27 +0000
Message-ID: <BN9PR11MB5276EE8617A721EF20B07BCD8C709@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <1638884834-83028-1-git-send-email-jacob.jun.pan@linux.intel.com>
 <1638884834-83028-5-git-send-email-jacob.jun.pan@linux.intel.com>
 <20211208131358.GR6385@nvidia.com> <20211208115516.1d36fed9@jacob-builder>
 <20211208203022.GF6385@nvidia.com> <20211208135945.6d0a3b69@jacob-builder>
 <20211208233936.GI6385@nvidia.com>
 <5fec4e7e-be37-193b-b4ab-dd1bbdb589d1@intel.com>
In-Reply-To: <5fec4e7e-be37-193b-b4ab-dd1bbdb589d1@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a62f81e9-8a0f-4fee-202b-08d9bab8829a
x-ms-traffictypediagnostic: BN6PR11MB1747:EE_
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr,ExtFwd
x-microsoft-antispam-prvs: <BN6PR11MB1747338F7D5D79F0089C00908C709@BN6PR11MB1747.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1923;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +moudEGrHC2sxxtQUtOUwGFQbmP9bwl7jOdOdKzcc4glyBnP5WqQQZhy5Vv+NgvISNPXnkM9iexUY+dWJWrUTwv7HIj8ZT4qSrBp9kfhBG+4IXeNv+6LwHPNS1cX69AevbTNkXD7T1FWgwOm5HItvWHye8b2neZwlzVdwk0btK3okks4enZzl4jAp2SJTd1UPXyuKlUusczcWbf63slkNJ+UlHYe+kNzxz7kolOjF1xaTFJFfiyo7W8avsXGr6d06jTXFkSzcWd2CYFS/6zl6+8ZZZGOaGjPZItT9jvVC/OrM+gQJ1kG/o/IiXNUad4RqpXRDXCzy/W0FinaFx3AFm1vi1bJf9kYma+P5EALYLUK0MYcNOKPi9tq1W785ClvFWSMu3H3cbb1ouUfgB7k6DnEMMyUHSQ6pZfATP7IiRmewVwFfHO9VSVD4hazgYXI26pGXK22NPKWV2l+9cE//lt/WnRt1NOomTyHj5l61z6XjBvMsCd7eqan+fDTUPpbep64ISGnOp52P+n4wfhKkCXHEZA/RPtBaW88lNvnZ2PwKsoXPsIdy7mxOENXzi78lx/LCruLNQIUN0CjNwdP8lQQdLMGTfqPXzZ3thgin/NULlKwlZDS7I0Xb//A+fwYI362XBgO0sgJqSRxXPwI4hi2VmWV8Oz+DcVtppMrXPxv65VQ7/AtQOLD/n3nBT8HjicmleCjG4+Qs+v2WzZb1Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(316002)(38100700002)(122000001)(7416002)(33656002)(8936002)(4326008)(9686003)(110136005)(86362001)(54906003)(76116006)(38070700005)(6506007)(8676002)(186003)(2906002)(82960400001)(64756008)(66946007)(66556008)(55016003)(66446008)(66476007)(5660300002)(508600001)(7696005)(26005)(71200400001)(52536014)(4744005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?R2dWS09PcDVaVkJoUWNZaG83WWFVRDl4cnkzNjhvZWZTcjNJTHVjYmZRa3Jh?=
 =?utf-8?B?Y1pCcmVIaUhmMTJsTXQ5bU00c2k0OXI5Y0puQVAzOUUvdnVVRURyUnQxdWVm?=
 =?utf-8?B?SlNkQml0emtsZnlNWXZsVG1uUVFCdkh4S2k0NjdrN0dDd0pwSWRESE1JYVlh?=
 =?utf-8?B?WW9lZDd3L1pZbnpRNzJmeS9BSGY1Z0xaK25BSWVoeTFzTGJ6V3h6VEt2TEZF?=
 =?utf-8?B?WlNIZFE0a1A5OGxVZmh0dTJpMXJJQVZBZmZVN2s1N1VnaHhBbEE4SEl2ZVZE?=
 =?utf-8?B?WHd0SHoreFRiZ3kzVSt4WFQ5dkZUUmZuMmFURVIrZVpSajIyT1IwWC9SaEpO?=
 =?utf-8?B?ekhueFhWSUxEUi9uSEdheC9nSDFDTU9zR0syWEkrTk9QcE43UmtXV1JoY09x?=
 =?utf-8?B?SGI5RFVpRm14cjBHUkxlWHBxK0pzWGJ0d1hnalZkTnBoaUhTUm5wb0p5WTVp?=
 =?utf-8?B?Nk1tVzVmOG5QZUFyNkc0MG5FekNYUmFpUml3bHdBbFk5T0p6SEpTWkQ1Z1dx?=
 =?utf-8?B?c0ZjQTFqeVRzQzR1TDF4SGJ4WkN0dDRqbm5EMzF2M0RPM1JjaGRMTEhFNW9F?=
 =?utf-8?B?Tkt5bmEzS0JxbHlSenNQbU1YWXBQbExyWE1LQU9jZ0lkOHF4TVlDSmtheDlx?=
 =?utf-8?B?NStsM2FwbVMrVGc2ZjhScHFEV2Z0Z0dwU25SbVdBaGtPOVJXNS8zb1RaTjlv?=
 =?utf-8?B?eEdwZVE5dVJyLzNyT3hjWWoycVNOYkxWd3NNYTlPS3ZnVmR4c1VUZGh3QWpV?=
 =?utf-8?B?elpwRkFndGVyVWFOMU5uZ0JPV3pFU2s3anNXN3czOWZiM2pMQnFkZVY2V3JP?=
 =?utf-8?B?MWEza3NpcFlTMVcyZ3FzNzUwbW5Lc3F4Tk84b1hIb1lIaFRNQ3hDUW9ZaXZi?=
 =?utf-8?B?eEh0dW0xV3I3ZHpSZnFhTkpTYmk3N3dOV1hBakt0dVVnZ2xQc2o1b1puTEY4?=
 =?utf-8?B?VDJtU0luMWYvYWRvQkIwK1RoSVdzenFRTzRZb0NzaEMxdzRjeTBSZW1CQm9V?=
 =?utf-8?B?bzh3cnpoSXRieXM4V1ZCM09ERmdJeU5zbE04Y1pENlBxMlV0V1VsYUIvUlFr?=
 =?utf-8?B?WENOaVlxWXlnYkZsdGJ4QXpvU0p3WVQ3dlRwamlaZWZHOUpxYUJXV2RHUm93?=
 =?utf-8?B?MnBmdXBiSDhodHhpRzBqR242R0pjV2JvR2FTSUlocGE5RWcwKzZYeGRaTFF4?=
 =?utf-8?B?a0pieTVUTS96Tzk0TE52amNGdUNXeHVTK3Jqb3NyMkFXWkVjdjBETG0wQkpJ?=
 =?utf-8?B?ZTF5aGVVbDFKWG01bnc0ZGd3dExFSFVxMU85Qlpqb0dya1NWTXI4WEtOcE4y?=
 =?utf-8?B?UmFYQU1sRVF6enRYS2crUlltZisxRkZHYlJZUVVnM0hqNysxcUpoZ0JEQ2JS?=
 =?utf-8?B?NEJ4OHphL3N6WjRwS3hxUGJvNEJMR0JyekZBbXc0SCtoNElQcVJ2NXhIa0ZT?=
 =?utf-8?B?c3FkYUxwTm13VHA0NG5kY2hkOUFZSkZvRWlHNzBpbm5ZMWd6aWRONVhMblIw?=
 =?utf-8?B?V0pKSk5nYStsT1E4L2o2MEphbjVaQjY1cVpsVGw5WFBtYWROQUpqSy9lQXZB?=
 =?utf-8?B?NEV6c01zaXNTTlFJQTh3S00xaDdrVmEyaHlvMmd1N1pCajR4bjhvMnhCdGdh?=
 =?utf-8?B?TUx1L2srU0ZQdWtZd21MMlUwRlFOcWxmNFpRQjF5MDNPZVYwYTdXZ3ROaDVr?=
 =?utf-8?B?UjMxeTc0TmJ5anFEamdRZGFMQWJISHFNUmFNZ1FTd1FqNnkzWTJZSWh1a1Bp?=
 =?utf-8?B?RXNJMWdjTllhK3dUY0hnOFltdjh1WkJGNWMzNjFoaFQycXR3TUo1WWVvTm9Z?=
 =?utf-8?B?ellMWlV2T1ZVYzh3ZlJ4UzhoNHpsVnp5K3BiR21LeWxrLzV6QWR3SExLcW5y?=
 =?utf-8?B?MmVyYmpSMERsVkI1cXNCZG5CbExtdm5RcFI2dk56UG54aHhoMkNVZThUSmpD?=
 =?utf-8?B?RGZQeS9EUGdadFJsVjVoaC9GNXc5QmJ1QTd2Q3V2dFdpSEZzY1dGWTlwY3lS?=
 =?utf-8?B?Wmp0a3VYNzZQaDBGL3lieXFISHBVeW1DT0NiVk1XK3djdklwMVpPMlU5VFhU?=
 =?utf-8?B?V05IWFl2R2RnbEdoRlJTdVdhYXZ4RzNXc0R6Nm9saTNUNnQ5Ry8wWng4cUFU?=
 =?utf-8?B?ckE1RnFHRGlUTU9HVnN3UzNWeDVIMys0RVovOTU0Nms4bUNpRDJMN3M4VXFn?=
 =?utf-8?Q?yap2fyXWqJLavxWPPHxUY54=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a62f81e9-8a0f-4fee-202b-08d9bab8829a
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Dec 2021 02:06:27.5193
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YarLTwm4DOFLYAY8q3F3Yqa8JFU4tgzYL3R34UAKFqTb3EGEBRxhwW5t8btYYYpyk7UYtX+ZCCA0Q14tV5kQog==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR11MB1747
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBGcm9tOiBKaWFuZywgRGF2ZSA8ZGF2ZS5qaWFuZ0BpbnRlbC5jb20+DQo+IFNlbnQ6IFRodXJz
ZGF5LCBEZWNlbWJlciA5LCAyMDIxIDg6MTIgQU0NCj4gPj4+DQo+ID4+IERvIHlvdSBtZWFuIHdx
IGNvbXBsZXRpb24gcmVjb3JkIGFkZHJlc3M/IEl0IGlzIGFscmVhZHkgdXNpbmcgRE1BIEFQSS4N
Cj4gPj4gCXdxLT5jb21wbHMgPSBkbWFfYWxsb2NfY29oZXJlbnQoZGV2LCB3cS0+Y29tcGxzX3Np
emUsDQo+ID4+ICZ3cS0+Y29tcGxzX2FkZHIsIEdGUF9LRVJORUwpOw0KPiA+PiAJZGVzYy0+Y29t
cGxfZG1hID0gd3EtPmNvbXBsc19hZGRyICsgaWR4ZC0+ZGF0YS0+Y29tcGxfc2l6ZSAqIGk7DQo+
ID4gSSB3b3VsZCBoYXZlIGV4cGVjdGVkIHNvbWV0aGluZyBvbiB0aGUgcXVldWUgc3VibWlzc2lv
biBzaWRlIHRvbz8NCj4gDQo+IERTQSBpcyBkaWZmZXJlbnQgdGhhbiB0eXBpY2FsIERNQSBkZXZp
Y2VzIGluIHRoZSBwYXN0LiBJbnN0ZWFkIG9mIGENCj4gc29mdHdhcmUgZGVzY3JpcHRvciByaW5n
IHdoZXJlIHRoZSBkZXZpY2UgRE1BIHRvIGZldGNoIHRoZSBkZXNjcmlwdG9ycw0KPiBhZnRlciB0
aGUgc29mdHdhcmUgcmluZ2luZyBhIGRvb3JiZWxsIG9yIHdyaXRpbmcgYSBoZWFkIGluZGV4LCB0
aGUNCj4gZGVzY3JpcHRvcnMgYXJlIHN1Ym1pdHRlZCBkaXJlY3RseSB0byB0aGUgZGV2aWNlIHZp
YSBhIENQVSBpbnN0cnVjdGlvbg0KPiAoaS5lLiBNT1ZESVI2NEIgb3IgRU5RQ01EKFMpKS4gVGhl
IENQVSB0YWtlcyB0aGUgS1ZBIG9mIHRoZSA2NEINCj4gZGVzY3JpcHRvciBhbmQgd3JpdGVzIHRv
IHRoZSBkZXZpY2UgYXRvbWljYWxseS4gTm8gRE1BIG1hcHBpbmcgaXMNCj4gbmVjZXNzYXJ5IGlu
IHRoaXMgY2FzZS4NCj4gDQoNClRvIGJlIGFjY3VyYXRlLCB0aGUgY3B1IHJlYWRzIHRoZSA2NEIg
ZGVzY3JpcHRvciBmcm9tIEtWQSBhbmQNCnRoZW4gd3JpdGUgdGhlIGRlc2NyaXB0b3IgdG8gdGhl
IGRldmljZSBhdG9taWNhbGx5LiANCg==
