Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 809C749A89D
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 05:14:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1319726AbiAYDJ1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 22:09:27 -0500
Received: from mga02.intel.com ([134.134.136.20]:47768 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1313432AbiAYCsc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 21:48:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643078907; x=1674614907;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=5NCnJZ7QGpnsfbx4Qz/bXOdmTAxIE00c1mccThSa/6Y=;
  b=NLdaVOuhNiKiUTBkNtX3ytB2PRJZtonSqX/zqf4QNGdlyTrSx4h74wH8
   7y5420/b/I1By8Er52IUIWWHT3itjY/pZuXw9Fg4M/G3uwUzHWLYjz/GN
   1iaQcYmCfn6ooozGne974G7xxv900GrbsxwxoZCSaXf34yIbM34T24PGS
   UWzG3S//TUHag4gsqSGGAlu0kKkxNTFkrSCBVI45okMqvOZ4NwFupGMNA
   EWXC0EtKO2GeoIl6Cys/9j3dD5qInbQ0ZAg31UGpGYPyRKeU7fqS7RnPs
   AJQbGYkYepg1G3ewH7v2BscLYaKp0CP+6rislA5MayqogTU4wrSd6FfzL
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10237"; a="233567380"
X-IronPort-AV: E=Sophos;i="5.88,313,1635231600"; 
   d="scan'208";a="233567380"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jan 2022 18:25:10 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,313,1635231600"; 
   d="scan'208";a="596984951"
Received: from orsmsx605.amr.corp.intel.com ([10.22.229.18])
  by fmsmga004.fm.intel.com with ESMTP; 24 Jan 2022 18:25:09 -0800
Received: from orsmsx608.amr.corp.intel.com (10.22.229.21) by
 ORSMSX605.amr.corp.intel.com (10.22.229.18) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Mon, 24 Jan 2022 18:25:09 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx608.amr.corp.intel.com (10.22.229.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20 via Frontend Transport; Mon, 24 Jan 2022 18:25:09 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.171)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.20; Mon, 24 Jan 2022 18:24:54 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HmCUmLxE73LrvWe2ufwdo5MYmQjNt5TQybBXuGEv7H7bMx94rDYej6eRtmIDhH6JzaxTstn2QfGtWkNTJmppFfuiukpM8GVfV7SN6vfLDHku5mHrYdx3gNmJm42GLyUkgVKQu//TaEnRwer8XPGKaizKBUKszpfvkwUB596BiLvVTVtgqolQU9P5gSpVdwXAUZ/ZXLGSvsmzS3uXLjbBn7w+weqCtUs+epvjxHPOuSAeCHlj2td51tQjY4FnJBhstdRfr4hw1RcKmpq8bfTlNNRmOMH7Ym4gTF574phPN/Ehcu+SQ/6Z8/KcEpS32kUYa2kPttmBYGRn/aiAS4a6AA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5NCnJZ7QGpnsfbx4Qz/bXOdmTAxIE00c1mccThSa/6Y=;
 b=PIhY/zjqbA8u6R1q5RG6FETouepsUPbDKrSA1nU9Zda5ywE+yGC301peZuNk2j/7olqBQIBr1O1xt6APQFHfM0PFigb0kAi1FGTWjpGX6tZGfsfgazMnr5qxVNVDJI30MJf8amvuUVQ2E92oSzCTfuCFIvW5KZdOIExY93o++onHCNru9ksCHXOZ1MwgFqh3VkNCRGObsUzDWGfRdKPd4BZmvMFe0FdaHrVh5DqvDELS3TRJWJm9rkYUWAVB2R0cgF55oCRRGjw5r+bE4tTqnzCgJ+1l9+PGNkTA/F0x4dEGjvRwQ6M3mahlTSV9lxnweO9B16rKijZ01kZpv4F8lQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from PH0PR11MB5880.namprd11.prod.outlook.com (2603:10b6:510:143::14)
 by DM6PR11MB4187.namprd11.prod.outlook.com (2603:10b6:5:19e::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.12; Tue, 25 Jan
 2022 02:24:48 +0000
Received: from PH0PR11MB5880.namprd11.prod.outlook.com
 ([fe80::ed1b:85d3:1ae7:a4e9]) by PH0PR11MB5880.namprd11.prod.outlook.com
 ([fe80::ed1b:85d3:1ae7:a4e9%8]) with mapi id 15.20.4909.017; Tue, 25 Jan 2022
 02:24:47 +0000
From:   "Zhang, Qiang1" <qiang1.zhang@intel.com>
To:     Ammar Faizi <ammarfaizi2@gnuweeb.org>,
        "paulmck@kernel.org" <paulmck@kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2] rcu: Add per-CPU rcuc task info to RCU CPU stall
 warnings
Thread-Topic: [PATCH v2] rcu: Add per-CPU rcuc task info to RCU CPU stall
 warnings
Thread-Index: AQHYEMs9kUJf3YC5T0CuSTeASDid96xx+2yAgABl14CAAFr8gIAARpfQ
Date:   Tue, 25 Jan 2022 02:24:47 +0000
Message-ID: <PH0PR11MB588099DBA57F16345037C348DA5F9@PH0PR11MB5880.namprd11.prod.outlook.com>
References: <20220124103637.4001386-1-qiang1.zhang@intel.com>
 <e7d56d70-3750-b83a-8c1c-99878722c805@gnuweeb.org>
 <20220124164251.GF4285@paulmck-ThinkPad-P17-Gen-1>
 <3f08b8cf-a1dc-4d83-0de2-94203dff9a4c@gnuweeb.org>
In-Reply-To: <3f08b8cf-a1dc-4d83-0de2-94203dff9a4c@gnuweeb.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.6.200.16
dlp-reaction: no-action
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 849a8458-f24c-4f27-ed4d-08d9dfa9dbb6
x-ms-traffictypediagnostic: DM6PR11MB4187:EE_
x-microsoft-antispam-prvs: <DM6PR11MB4187CBD70CB04560FB031EB2DA5F9@DM6PR11MB4187.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5516;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 5PcJxNKmGUY0ah63qWv40dOsS4IMoZG9P5ygZfk7essKSa1E61kZsGjVgIx1HgyvJdiqabGD0NbxJ1E75tzyHm9pV45XcJiYXXbKqrkx+nG3S3fak84E5paqCQJc5AJWog4namlzYWpFBXNfufyapheF5EwNfSfXrvt8zne1dLm7PHlP0dpmPxp7uVCB/RhERbQVTm4+mQ8KKoturMKPKza5lg84up6VZQ3/ngA43TKT4xFaVLAMyct4PalSHafhkdO3plUpEJ/EitQAybyv9cFWSAAYotDOlROhZNQjZaJGWgUMMYNEGefZrpWlN+p+GX9Fn+H68fGlzILLLqf+3UCQspl9z+cs+WGspn62HoCoTDrI5gaKcfkNwWo5hSEwGs469yok88G2aiJ1z3mLctpRf8EAgnmdH6ydiHXOdj/EaLM1yVVpP/q/HzISKjJxzU0+pCpdUhCmwEoGUQETiTz1v1L320bviujhBY3Uu/kCkTbl5Q7L5XZRqRlSVQqOvCWUxrkeNonUGQhUdD8uPtYTfFrSIu/SnXE/5NalV7UkeX1eEJ3XoeCnXrlg2e0B8it4xmCDdFCX+++zOZZj3ZWocl5IZdKYi+XopvF2/oSI72mtGqoSioNYM31ltjdbduusPBUgX/3+lLho9WIkoDimBnpnNAgb9VGb2rMARYYF6YzihdrX8BfWyjoYsu2KzfBgB2rMHp3qW/kLcdbJqg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5880.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(9686003)(8936002)(38070700005)(55016003)(110136005)(316002)(7696005)(82960400001)(33656002)(8676002)(26005)(66574015)(5660300002)(52536014)(2906002)(76116006)(186003)(66476007)(83380400001)(122000001)(66556008)(71200400001)(66946007)(38100700002)(64756008)(508600001)(86362001)(53546011)(6506007)(4326008)(66446008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dEdJRE1qcVUwVGxZRG5nbmVVcWEyNmRZZWJXaTg2M2ZuQWJzK1JSYmh3ekd4?=
 =?utf-8?B?cWZWZmhjUGwwREljQ3lIZ0V2Q09CVUh2UUo0WnVpRGF3b2d5dGgxNzBTR0pm?=
 =?utf-8?B?Tk1HMzc4eXFoUDFKZ01YckJLOVo4YTNGdnQzUk1JMEtZaGpZQk5YVDl0emMy?=
 =?utf-8?B?SzZuekJ3bFNKOWFmUXNheGlmZk03UEJ4VEd0TDJQQWQwVEU2US9VcDBRaFBo?=
 =?utf-8?B?WHZ5UWMyUDlGdEhQYXo1cjhmMi93M2Q5NUhmeGdLUHBodmFJZWtYbkdCZ1Vx?=
 =?utf-8?B?K2JYd3I1a0ZtL1FQODVjNDJjeDRHdEJhbVpIYnZqeCtWejBHMHpWMFVOSGV1?=
 =?utf-8?B?bzEzTmRneE44WWROVXBNMlRFUUw4VmtNVXNORUxkenFYTzlKclNlaXdObDV2?=
 =?utf-8?B?ZjE1cVFHWEpsWFF4Mnh0cE1ITjI5UmNZRjQ2aWxhdHdyTlI1T2tkWW5TNzMx?=
 =?utf-8?B?NmxaSmZtUXRVc29sTEFPa0hENjlobjZISlNSQmZ1SzAvekVQdnVjaVYrK2VO?=
 =?utf-8?B?ZTVDMUdQN0d5TTV0Zkw5MTlDUEowOFBkak5KWWNZVUIzaDVzWXhuNzRpajhL?=
 =?utf-8?B?dlYyZ0lyY1FlaFcwTTNydzk2Ui81Sy81a3hBU0VkZ1AwamxoVGdNbkR0MFBq?=
 =?utf-8?B?R1BNcEM2T2VFbzZnUEpwL2ZLdUZXUm96em5sV2lnNmpzZEJzNW5oeU9kVFVa?=
 =?utf-8?B?L2ttK2h1c3ZBWkJvOU8raENZSHM3Qm5hQ3BOdk5sRnVBbzh6MFRvbGVEb3NU?=
 =?utf-8?B?VzczZkxZdGw0SWtaeTErbDBCSUg2NHBaY09Wb2trWDQvN09XSHBEWWQ0amZU?=
 =?utf-8?B?YlA5WWdqZjUydk15T0VFZ3dUemNvVklSWEtETGNydGlCbEVRTkEzRUI3QU9S?=
 =?utf-8?B?dHN5STM4b0luT2tFekI1Nk9ucXU5K3FNdGVrYkVTSkRtdzZDNTQ2OHg2dURz?=
 =?utf-8?B?WXRSTjJCeEY3azJrR3RtWmJ2RDlVeUpONC9PTTh4K3VxUmlGaUFhNncvbGQy?=
 =?utf-8?B?anlVb0swM1FyTmdUZjhrUVN5dlhlRW1COTd2NnF3YTRKeUFzNmw0NVVRaTVp?=
 =?utf-8?B?bWhUY1EyS3Jxd0wzYytRWUtTbFV3SnVVL0gwU0t0ZXlJcVN2L0FGL04vM3pV?=
 =?utf-8?B?VkZpZVRGSm5NeGJvVUlPQ2lQQW8wYzZ0WXRxWFlnYkFJWUgvTlV1RStXVHEv?=
 =?utf-8?B?d21UajlTQWxIclJxTXFuTzkzeEEzYWdad1hCM0xBOGdSRzhuWUc0d2Q5R2ow?=
 =?utf-8?B?VGE0dFNySTRSRTAxSkN0ckJuMytwVHNkcDJDdG5NRTFycUh4Z3gzS0x5eFlI?=
 =?utf-8?B?NWYyQWVualJmRjRrSGxUVkxCVGFkSTJUSUppaGRpWHZYVUhOVFZjWVhjRitG?=
 =?utf-8?B?ZnMvQzQ4Q2laTkJKZHRScm9pSUJ5U1lNaktkeXpITGRyM2R4UmxJb2RabUVj?=
 =?utf-8?B?dnBaTEZmWE4vSGlZZ2VPLzNVQzJ4azhiNFhybmIrR2RzNjhydlN4TTR2cFJE?=
 =?utf-8?B?RVZ2L2tBaFY0eWRySy9uRzJJVTNNTm4vbFFrNCs1SVJmR3MxTXFzWC9sQWpW?=
 =?utf-8?B?V1NZTUNVdC9IVnNCdDZhaWdZT3N4bDlBbDVudXFlOHh3VWpCeVBLaUtIeXhE?=
 =?utf-8?B?WDhFSzhNYlpuZU96SDJhY200SzVtZDNxRjRUN29uUjBvRVo3MmZ5RWhFN1J4?=
 =?utf-8?B?OXgvbWpVOWtBYUdDZGJKTlErc3dqc1dScE51VThNQVQ0VklrTjV2M291czgx?=
 =?utf-8?B?amtFWk5nR09sK2IyR2dNSWFiY1k0SHZZdTFhVGdyMzNrbUhLSXE5dHJNaGlE?=
 =?utf-8?B?MG5TcEM5ZGd0Q0dKWG1oNDBGNTVUMmkwczFRSTgrbWpRdm5EMmZUTXJJRE12?=
 =?utf-8?B?RUtBZEdGSlJoc0Z3TWFwR0xPdERjU1hQWFMxdE5adWt4bjFvWjBrcGNSMndh?=
 =?utf-8?B?Qm4xc0x6N3VrRkFFd2hXUDczdDUyd1JQa3gwK0o2aDd5ZEFEYmVyeHZBbzQy?=
 =?utf-8?B?ZWZxSmp0NjNGNzhkSjVUWEMrcSt0MFlyWUJrUmFHcTRBN1ppUWk5SXZ1MFU3?=
 =?utf-8?B?ZWRhR1hWdU1iQ0QwZHVzcVhvRHB5KzU2REw3RHZUTkNmZ0t3eFlTV2dmdi9k?=
 =?utf-8?B?WVMxR2xlTUx1TTVTZWx6VHVOa2xSWjNiU2RvRmRyZG1tWkpReHZnc1pRbmkr?=
 =?utf-8?B?L0E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5880.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 849a8458-f24c-4f27-ed4d-08d9dfa9dbb6
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jan 2022 02:24:47.6571
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +57XrvNrHxRxDue469vtou8AkRv43M7f6W3Gel4c+jg3xgb8aNk3l920R17FGpTrM1pZD8pMPS4MQ73caNBURA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4187
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQpPbiAxLzI0LzIyIDExOjQyIFBNLCBQYXVsIEUuIE1jS2VubmV5IHdyb3RlOg0KPiBPbiBNb24s
IEphbiAyNCwgMjAyMiBhdCAwNTozODoyMVBNICswNzAwLCBBbW1hciBGYWl6aSB3cm90ZToNCj4+
IFtzbmlwLi4uXQ0KPj4gRldJVywgdGhpcyBvbmUgbWFrZXMgbW9yZSBzZW5zZToNCj4+IGBgYA0K
Pj4gc3RhdGljIHZvaWQgcmN1Y19rdGhyZWFkX2R1bXAoc3RydWN0IHJjdV9kYXRhICpyZHApIHsN
Cj4+IAkgaW50IGNwdTsNCj4+IAkgdW5zaWduZWQgbG9uZyBqOw0KPj4gCSBzdHJ1Y3QgdGFza19z
dHJ1Y3QgKnJjdWM7DQo+Pg0KPj4gCSBpZiAoIXJjdV9pc19yY3VjX2t0aHJlYWRfc3RhcnZpbmco
cmRwLCAmaikpDQo+PiAJCSByZXR1cm47DQo+Pg0KPj4gCSByY3VjID0gcmRwLT5yY3VfY3B1X2t0
aHJlYWRfdGFzazsNCj4+IAkgaWYgKCFyY3VjKQ0KPj4gCQkgcmV0dXJuOw0KPj4NCj4+IAkgcHJf
ZXJyKCIlcyBrdGhyZWFkIHN0YXJ2ZWQgZm9yICVsZCBqaWZmaWVzLCBzdGFjayBkdW1wOlxuIiwg
DQo+PiByY3VjLT5jb21tLCBqKTsNCj4gDQo+IFRoYW5rIHlvdSBmb3IgbG9va2luZyB0aGlzIG92
ZXIgYW5kIGZvciB0aGUgZ3JlYXQgZmVlZGJhY2ssIEFtbWFyIQ0KPiANCj4gSSBhbSBhbHNvIHdv
bmRlcmluZyB3aHkgdGhlIGFib3ZlIG1lc3NhZ2Ugc2hvdWxkIGJlIHByaW50ZWQgd2hlbiB0aGUg
DQo+IGNvcnJlc3BvbmRpbmcgQ1BVIGlzIG9mZmxpbmUgb3IgaWRsZS4gIFdoeSBub3QgbW92ZSB0
aGUgYWJvdmUgcHJfZXJyKCkgDQo+IGxpbmUgZG93biB0byByZXBsYWNlIHRoZSBwcl9lcnIoKSBs
aW5lIGJlbG93Pw0KPiANCj4gCQkJCQkJCVRoYW54LCBQYXVsDQoNCj4+SGkgUGF1bCwgVGhhbmsg
eW91IGZvciB0aGUgcmV2aWV3LiBBZ3JlZSB3aXRoIHRoYXQuDQo+PkhvcGVmdWxseSB0aGlzIG9u
ZSBsb29rcyBiZXR0ZXIgKHVudGVzdGVkKToNCj4+YGBgDQo+PnN0YXRpYyB2b2lkIHJjdWNfa3Ro
cmVhZF9kdW1wKHN0cnVjdCByY3VfZGF0YSAqcmRwKSB7DQo+PglpbnQgY3B1Ow0KPj4JdW5zaWdu
ZWQgbG9uZyBqOw0KPj4Jc3RydWN0IHRhc2tfc3RydWN0ICpyY3VjOw0KPj4NCj4+CXJjdWMgPSBy
ZHAtPnJjdV9jcHVfa3RocmVhZF90YXNrOw0KPj4JaWYgKCFyY3VjKQ0KPj4JCXJldHVybjsNCj4+
DQo+PgljcHUgPSB0YXNrX2NwdShyY3VjKTsNCj4+CWlmIChjcHVfaXNfb2ZmbGluZShjcHUpIHx8
IGlkbGVfY3B1KGNwdSkpDQo+PgkJcmV0dXJuOw0KPj4NCj4+CWlmICghcmN1X2lzX3JjdWNfa3Ro
cmVhZF9zdGFydmluZyhyZHAsICZqKSkNCj4+CQlyZXR1cm47DQo+Pg0KPj4JcHJfZXJyKCIlcyBr
dGhyZWFkIHN0YXJ2ZWQgZm9yICVsZCBqaWZmaWVzXG4iLCByY3VjLT5jb21tLCBqKTsNCj4+CXNj
aGVkX3Nob3dfdGFzayhyY3VjKTsNCj4+CWlmICghdHJpZ2dlcl9zaW5nbGVfY3B1X2JhY2t0cmFj
ZShjcHUpKQ0KPj4JCWR1bXBfY3B1X3Rhc2soY3B1KTsNCj4+fQ0KPj5gYGANCg0KPj5SZWNhbGwg
dGhhdCBkdW1wX2NwdV90YXNrIGxvb2tzIGxpa2UgdGhpczoNCj4+YGBgDQo+PnZvaWQgZHVtcF9j
cHVfdGFzayhpbnQgY3B1KQ0KPj57DQo+Pglwcl9pbmZvKCJUYXNrIGR1bXAgZm9yIENQVSAlZDpc
biIsIGNwdSk7DQo+PglzY2hlZF9zaG93X3Rhc2soY3B1X2N1cnIoY3B1KSk7DQo+Pn0NCj4+YGBg
DQo+PndoaWNoIGFscmVhZHkgdGVsbHMgdXMgaXQncyBhIGR1bXAsIHNvICJzdGFjayBkdW1wIiBp
biB0aGUgcHJfZXJyKCkgY2FuIGJlIG9taXR0ZWQuIEFueSBjb21tZW50LCBacWlhbmc/DQoNClRo
YW5rcyBBbW1hciwgdGhpcyBsb29rIGxpa2UgbW9yZSBjb21wYWN0LCBJIHdpaWwgcmVzZW5kLg0K
DQpUaGFua3MNClpxaWFuZw0KDQo+Pj4+DQo+Pi0tDQo+PkFtbWFyIEZhaXppDQo=
