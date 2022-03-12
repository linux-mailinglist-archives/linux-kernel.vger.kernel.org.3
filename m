Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 649F24D6C29
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Mar 2022 03:57:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230168AbiCLC6j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 21:58:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbiCLC6g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 21:58:36 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1755524F78E;
        Fri, 11 Mar 2022 18:57:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647053852; x=1678589852;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=t21Eq/6KVstMKnNz/aLQ5zSlz3KvvyYMercdJo9gL+4=;
  b=b2DQGgdVbfwX1qxs6iG6KHh/kNikGY2EM0mEvQz91P86vfB1IVqEFvVp
   StAMoe+cl0BIax5qAoFr58MFFugc+cRmQZN+XyzTenXItUA5GQmtsW1Oc
   15gv6euttp+OzKNtaBJwOS/vLbqOcGX9dQlKxXRZZiKd+nbpiiilk4R4R
   IHd/SPxaJowdHuQhN3TkTPToq3D3r8mX0uxCtLcAcT2EnLmcN/jRWDbRm
   xHw1Zq1oeAlDpUDr1zRXZVbKiANlY+rIokp0PmmAcpRek475sJdQWViD3
   5m0zy0G1/ciJfZuoMrKj21M9V75YoZlZ7cXGzyqZ+2ikUyc3lCCMzEgC7
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10283"; a="235676589"
X-IronPort-AV: E=Sophos;i="5.90,175,1643702400"; 
   d="scan'208";a="235676589"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2022 18:57:31 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,175,1643702400"; 
   d="scan'208";a="514741785"
Received: from fmsmsx606.amr.corp.intel.com ([10.18.126.86])
  by orsmga006.jf.intel.com with ESMTP; 11 Mar 2022 18:57:31 -0800
Received: from fmsmsx609.amr.corp.intel.com (10.18.126.89) by
 fmsmsx606.amr.corp.intel.com (10.18.126.86) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Fri, 11 Mar 2022 18:57:30 -0800
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx609.amr.corp.intel.com (10.18.126.89) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Fri, 11 Mar 2022 18:57:30 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21 via Frontend Transport; Fri, 11 Mar 2022 18:57:30 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.169)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.21; Fri, 11 Mar 2022 18:57:26 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fZQ4vzuM8O+b9Ss5GcOn2TtkLoRXelyVG9JBi2PDgfQagytjBBDZSo0UgxFmCATD4v8zk/JXVbakc69YqmD4g6ca7UIviEFSQmgaYXlOe9ZPv5CQ3nun7Ke98bzsVuqubUVRp9EU3YJuCBoUXlKEpGW/xGuyvuPrWu6/gdz0ElMhF/+Zip2O1W83vS+DMLfg7u9B/4gsKg/HkjzpOUQ+nTDbjXkyXlNuyptZnBfP37/RmEtUi9UsynARGwCqyzrm7/wLCEpSwFxmWy3UAchwawkwyC/Ir2g7upkIHkoPY1alfghmEyYiGvTmALM8bRhvRklfs/6zZ4ZoD9A6H6Xh+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t21Eq/6KVstMKnNz/aLQ5zSlz3KvvyYMercdJo9gL+4=;
 b=X4zaByK7KRq6elXRafYEvtSmRdHfo76PknnmqPjS9oF2UbkNaXUxNvIE6OJFRb/VRXEtUiGj5REUKJ3e98zFgJ0bAEuBVZBPTiB4hXbnv6zBPkzhe2E4iEGTnFP9qmS2DtC7PzKcV3rj9pKM2m6X5d/M1GwEpPknucAAZZDM26hFQkMLDBW3kqJrAds14WRZhkachH5gxBD78NL25QN6qkI/CbbOFnxN0m1l8KiDPTvLQPlwZLydQaHNOgp33ZGjvf3jwJuGgjvayxeXmNcHeN0N7leiBD14wUcdWA7DjcBY54A/VbPeOmULgx+guTrLIeVlRxuteK8eMdjiQybXoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB5880.namprd11.prod.outlook.com (2603:10b6:510:143::14)
 by DM6PR11MB4610.namprd11.prod.outlook.com (2603:10b6:5:2ab::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.24; Sat, 12 Mar
 2022 02:57:25 +0000
Received: from PH0PR11MB5880.namprd11.prod.outlook.com
 ([fe80::d90e:5a21:8192:7c54]) by PH0PR11MB5880.namprd11.prod.outlook.com
 ([fe80::d90e:5a21:8192:7c54%5]) with mapi id 15.20.5061.024; Sat, 12 Mar 2022
 02:57:25 +0000
From:   "Zhang, Qiang1" <qiang1.zhang@intel.com>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
CC:     "paulmck@kernel.org" <paulmck@kernel.org>,
        "frederic@kernel.org" <frederic@kernel.org>,
        "urezki@gmail.com" <urezki@gmail.com>,
        "quic_neeraju@quicinc.com" <quic_neeraju@quicinc.com>,
        "josh@joshtriplett.org" <josh@joshtriplett.org>,
        "juri.lelli@redhat.com" <juri.lelli@redhat.com>,
        "rcu@vger.kernel.org" <rcu@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v3] rcu: Only boost rcu reader tasks with lower priority
 than boost kthreads
Thread-Topic: [PATCH v3] rcu: Only boost rcu reader tasks with lower priority
 than boost kthreads
Thread-Index: AQHYNO7gNJl5wtEdME6XCIwd5VJW/6y6BwsAgADvr2A=
Date:   Sat, 12 Mar 2022 02:57:24 +0000
Message-ID: <PH0PR11MB58802B8804EDFFC73BA676F2DA0D9@PH0PR11MB5880.namprd11.prod.outlook.com>
References: <20220311022226.595905-1-qiang1.zhang@intel.com>
 <Yist4IWWR/6BZzeK@linutronix.de>
In-Reply-To: <Yist4IWWR/6BZzeK@linutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.6.401.20
dlp-reaction: no-action
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: cee4aa83-d1af-4837-e817-08da03d40950
x-ms-traffictypediagnostic: DM6PR11MB4610:EE_
x-microsoft-antispam-prvs: <DM6PR11MB4610569C249BD1B82A1407A3DA0D9@DM6PR11MB4610.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: GY3PRfNldBN9Eus/XXt4v9nH2Vv/aaH+SfXi+ukhheMGb61j6j4I/1fWkI1hHEyzGbL9d76TBjYUq7ke1jwy7hco0ZgbPEaF+84GpT9Z2seqsdv4wgBsWubSepBU8UDVsP1j7YYpxmeenFBTjzgadb3/tMpy3L2wkmJTfddzQYfhIJ8Bq+YIOuj0AhSgNNh2TJPRLoi5uhWQcXc9P5bvR2qxP/M+2Fiko8TSf7g6PJwbaMXEEcZwcLkQY3XdHb52E5PP1gbHDug7oui81mflhhsZy13gw/QNpZmaCJ2Nz2EKFL1sgBLGOoqrnAQiz+ELerM512N7fJKqJ+iRmqE8s1wBPT0+beIBkBSTV7eQY2vSSOXessZfyAIUifobQw8UN8XPGgMceoTQogAEBtXspzr6HBN1HDlSRccFZDDjBA4QkLjBd1BiZfjOL/yk7AWRiTC0IJIjGfR9L5TIZB2Z7THU16/qSGI32Grz9a7PiUCTAepKIUiZxYTiri+I8lDx7eU///hPqXqZNDYae2ZAAkkESLPUS1Z6qc6lFU7TZPmy/cUDoI8amcGkjVT7cynYxuOHR2rrnug939gMJ0hpiRRdv2U6octgRd370zlLUpALw6+u5S0yaVGzJ8XsFTjimMKRDLsnPvYlnKe7Yr4aDVAa6l4gBUJvuRwYlJNYJr+j+J8DWlHtZiLdgInq9rAffk/23rFbH0p1oP+ELs2K4Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5880.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(38100700002)(71200400001)(8936002)(52536014)(53546011)(7696005)(6506007)(122000001)(26005)(186003)(508600001)(82960400001)(38070700005)(5660300002)(54906003)(6916009)(4326008)(8676002)(2906002)(33656002)(83380400001)(55016003)(86362001)(76116006)(9686003)(66476007)(64756008)(66446008)(66556008)(316002)(66946007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RkdsL2NCRWxRU3duN2haVit4R2xmbTZkOHk0SlBnTGl0SEgwUHJVdU9UUTNG?=
 =?utf-8?B?YytaNTc3ZW9DUDh3ZmhQRHpBclhVVVR1SDFINkJleERuQzEzNDQ3eXg3ZklS?=
 =?utf-8?B?czlPSXlWaXRTcVBwYTR3ZFJscHQrMnFpSzd0UmxCZUl0RGxlQTU5R2FBS1dZ?=
 =?utf-8?B?a0lEUVF6ZzBCa3hrb3ZUMEhzV0NlM1BKcWFxU0pSTmdmazZGbTRPTVhxci9I?=
 =?utf-8?B?Rk1Hb25lOHU1TzlwY2NwSnozMDZiZEYwMEVwcGtCNE51U0hTL3YybjFKUmJM?=
 =?utf-8?B?Z0VNQ2FTZlY2WTlrREVDMUFoeGcrbTlqUmg5Y2liUXNRa3NPYXcvSzkwZFdk?=
 =?utf-8?B?Wk44YTRxb0dJOG52N0NnTnZJVldNRVI5QzJYcmdaMEZIY1dJWGNjZVd3SDVq?=
 =?utf-8?B?cFF5eU5JUWZmK2hSUDQ5OW9xd25sSTBRVlRBeHo4T2FMLy9xTUdjc2J4UmNw?=
 =?utf-8?B?VkpJRjVWUGIxSzc4aTIyVEo2MW5iUE5QbHpSRGh3SmhaZGR0cEIzNjgzYjFE?=
 =?utf-8?B?K0xPQk95SFN3eTRLQU13aGFpNHNta3JMeDhuYm8yYUV1UXE4bERXdzF3Z3ZV?=
 =?utf-8?B?Q29adjQrWVNWU20rcm1UM2dNNmswcERiYzdSc2VzSDllOWQwN1JtOXhLc05w?=
 =?utf-8?B?ZTNLZlY1N1hVeFEyQ0wzSThmeDBOTEhVTEVRbE53V1RZWG50TUhJWXlxVEYr?=
 =?utf-8?B?OVlUZzVsdHMzYkltT1lUZ1lhMFV6bTlzWm5qbndZZlJHOThuU3o5TVN0UGRB?=
 =?utf-8?B?eXIyb3JNVDBIZ2N1OC9TY24wYzR0SnhwdnJLMDk0MEFFUElHa2NVOHY5MjV3?=
 =?utf-8?B?aHNvVERub2dFVU1NQUkzZHE2V2VVeExLRVlSZ0d1YWlsT2NwQURIY09lWTVC?=
 =?utf-8?B?Qy9LUWdvZ2JBWVI1TjhmeEVHc2FyM3d3WFlyMXlnQkZqdWxIcHpTY28zM3hQ?=
 =?utf-8?B?TkVidVRFRGQ3TWp6TXBLa283V3hubmdTaVArVURJLzd2Uk5LU2VLaFl6dGc3?=
 =?utf-8?B?RzNPV2dFM2lRUlBrQkZpMWJJaUEvcHJ2SzlkbUtiRFJod1lJL1RUN1ZjK2Jk?=
 =?utf-8?B?RExpbm5SUG1uYVRMeTlLS0hGMytMWlk5NTRSTlk2Yk9Ib2NvZ2RUaUNNY1E1?=
 =?utf-8?B?d3dld05VZ1Z6ZlhLVklJNWVVS25rdUxmS0ttVytWNjZFMUFHSHp2UWR4THh2?=
 =?utf-8?B?bHl0RXpKeWdQZWpuN0pDT25kNXRXWFRXOWxxNzlibHNMUk42bmdMK2hhSGNQ?=
 =?utf-8?B?WXY5VXlHdVErWmt4Wk81bkw4MDZyUTJScEZPYlNrU1FkaDduMXgvcERsQm10?=
 =?utf-8?B?bGxoZVRxOGduck5KZmJWNzMwQ2lqT2FsVnVTazVmd01hemdMY0RVMklnN29v?=
 =?utf-8?B?bWNQOTB0RytVVXpOdkdjeWl4NnlRRFZGR3JsenRQdEF1eDFqeUFEcFlaa3Vs?=
 =?utf-8?B?MytJcDBwK1U2K25xbGlTOU1iWWNHUlVNUXFlQzRNTTRnQ2NvcGVHZ3VqWUox?=
 =?utf-8?B?bFVnMjF4QTI5SnozNXZyUGxWQUZoTFcvMFNQUkQzTm1oamNRWjk5MWJ2V3cv?=
 =?utf-8?B?K1VvU0ZRdVRENFZ5OUVzTUt2U0NDQ3JuaS9KUlNLRHU1T2hoNlRZNitVeFk2?=
 =?utf-8?B?MnNsUDNNcFVPU0pLVzVjS1NGMTlOZjRBSlRLTnViMTRUWjNDdzZMN29aR29l?=
 =?utf-8?B?TCs0ZEkzNnNOb29vUkhFelBHS3orQlIvdkNpUW1TOTJZcWlFZVExejZuWlJW?=
 =?utf-8?B?cW42R3NXKytZRXV3aGNMMzlXTGhYUFJTNjR0VlZpazhaTjdIL3ExTDdmd0RH?=
 =?utf-8?B?eUpobFp2QUxtL2QxZk5keDcwVmJPMXNPWkNDMGRMVEdiNGdvZlFhQVYwOEcy?=
 =?utf-8?B?R2RxQ2xmL1hydXZyajEwMEc5Z1MxczdEK3RSZkVPMWpwWk45aTNWSXgvMGZy?=
 =?utf-8?Q?rvCLss6eavQEPeHVIXIxGnsfWzdmFK2A?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5880.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cee4aa83-d1af-4837-e817-08da03d40950
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Mar 2022 02:57:24.9656
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uf9TTyfjri0OFkIAZf65b96qQOHNhhF0Dj1QXt7gXSimnNMFQCAQ6qRT9Z5wX1kI+k//MCV111FAT9d6BIi5JQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4610
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMjAyMi0wMy0xMSAxMDoyMjoyNiBbKzA4MDBdLCBacWlhbmcgd3JvdGU6DQo+IFdoZW4gUkNV
X0JPT1NUIGlzIGVuYWJsZWQsIHRoZSBib29zdCBrdGhyZWFkcyB3aWxsIGJvb3N0aW5nIHJlYWRl
cnMNCj4gd2hvIGFyZSBibG9ja2luZyBhIGdpdmVuIGdyYWNlIHBlcmlvZCwgaWYgdGhlIGN1cnJl
bnQgcmVhZGVyIHRhc2tzDQogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBe
IFBlcmlvZC4NCg0KPiBoYXZlIGEgaGlnaGVyIHByaW9yaXR5IHRoYW4gYm9vc3Qga3RocmVhZHMo
dGhlIGJvb3N0IGt0aHJlYWRzIHByaW9yaXR5DQo+IG5vdCBhbHdheXMgMSwgaWYgdGhlIGt0aHJl
YWRfcHJpbyBpcyBzZXQpLCANCg0KPj5UaGlzIGNvbmZ1c2VzIG1lOg0KPj4tIFdoeSBkb2VzIHRo
aXMgbWF0dGVyDQo+Pi0gSWYgaXQgaXMgbm90IFJUIHByaW8sIHdoYXQgaXMgdGhlbj8gSGlnaGVy
IG9yIGxvd2VyPyBBZmFpayBpdCBpcw0KPj4gIGFsd2F5cyA+PSAxLg0KDQpJZiBpdCBpcyBub3Qg
UlQgcHJpbywgdGhlIHNhbml0aXplX2t0aHJlYWRfcHJpbygpIHdpbGwgbGltaXQgUlQgcHJpbw0K
DQo+IGJvb3N0aW5nIGlzIHVzZWxlc3MsIHNraXANCj4gY3VycmVudCB0YXNrIGFuZCBzZWxlY3Qg
bmV4dCB0YXNrIHRvIGJvb3N0aW5nLCByZWR1Y2UgdGhlIHRpbWUgZm9yIGENCj4gZ2l2ZW4gZ3Jh
Y2UgcGVyaW9kLg0KDQo+PlNvIGlmIHRoZSB0YXNrLCB0aGF0IGlzIHN0dWNrIGluIGEgcmN1X3Jl
YWQoKSBzZWN0aW9uLCBoYXMgYSBoaWdoZXINCj4+cHJpb3JpdHkgdGhhbiB0aGUgYm9vc3Rpbmcg
dGhyZWFkIHRoZW4gYm9vc3RpbmcgaXMgZnV0aWxlLiBVbmRlcnN0b29kLg0KPj4NCj4+UGxlYXNl
IGNvcnJlY3QgbWUgaWYgSSdtIHdyb25nIGJ1dCB0aGlzIGlzIGludGVuZGVkIGZvciAhU0NIRURf
T1RIRVINCj4+dGFza3Mgc2luY2UgdGhlcmUgc2hvdWxkbid0IGEgYmUgUEkgY2hhaW4gb24gYm9v
c3RfbXR4IHNvIHRoYXQgaXRzDQo+PmRlZmF1bHQgUlQgcHJpb3JpdHkgaXMgYm9vc3RlZCBhYm92
ZSB3aGF0IGhhcyBiZWVuIGNvbmZpZ3VyZWQuDQoNClllcywgeW91IGFyZSByaWdodC4gSWYgdGhl
IGJvb3N0aW5nIHRhc2sgd2hpY2ggaXRzZWxmIGFscmVhZHkgYm9vc3RlZCBkdWUgdG8gUEkgY2hh
aW4sDQphbmQgSXRzIHByaW9yaXR5IG1heSBvbmx5IGJlIHRlbXBvcmFyaWx5IGhpZ2hlciB0aGFu
IGJvb3N0IGt0aHJlYWRzLCAgb25jZSB0aGF0DQpQSSBib29zdCBpcyBsaWZ0ZWQgdGhlIHRhc2sg
bWF5IHN0aWxsIGJlIGluIGEgUkNVIHNlY3Rpb24sIGJ1dCBpZiB3ZSBoYXZlIGJlZW4gc2tpcHBl
ZCBpdCwNCnRoaXMgdGFzayBoYXZlIGJlZW4gbWlzc2VkIHRoZSBvcHBvcnR1bml0eSB0byBiZSBi
b29zdGVkLg0KDQo+Pg0KPj5Zb3Ugc2tpcCBib29zdGluZyB0YXNrcyB3aGljaCBhcmUgaXRzZWxm
IGFscmVhZHkgYm9vc3RlZCBkdWUgdG8gYSBQSQ0KPj5jaGFpbi4gT25jZSB0aGF0IFBJIGJvb3N0
IGlzIGxpZnRlZCB0aGUgdGFzayBtYXkgc3RpbGwgYmUgaW4gYSBSQ1UNCj4+c2VjdGlvbi4gQnV0
IGlmIEkgdW5kZXJzdGFuZCB5b3UgcmlnaHQsIHlvdXIgaW50ZW50aW9uIGlzIHNraXAgYm9vc3Rp
bmcNCj4+dGFza3Mgd2l0aCBhIGhpZ2hlciBwcmlvcml0eSBhbmQgY29uY2VudHJhdGUgYW5kIHRo
b3NlIHdoaWNoIGFyZSBpbg0KPj5uZWVkLiBUaGlzIHNob3VsZG4ndCBtYWtlIGEgZGlmZmVyZW5j
ZSB1bmxlc3MgdGhlIHNjaGVkdWxlciBpcyBhYmxlIHRvDQo+Pm1vdmUgdGhlIHJjdS1ib29zdGVk
IHRhc2sgdG8gYW5vdGhlciBDUFUuDQo+Pg0KDQpZZXMsIEl0IG1ha2Ugc2Vuc2Ugd2hlbiB0aGUg
cmN1LWJvb3N0ZWQga3RocmVhZHMgYW5kIHRhc2sgd2hpY2ggdG8gYmUgYm9vc3RpbmcNCnNob3Vs
ZCBydW4gIGRpZmZlcmVuY2UgQ1BVIC4NCg0KPj5BbSBJIHJpZ2h0IHNvIGZhcj8gSWYgc28gdGhp
cyBzaG91bGQgYmUgcGFydCBvZiB0aGUgY29tbWl0IG1lc3NhZ2UgKHRoZQ0KPj5pbnRlbnRpb24g
YW5kIHRoZSByZXN1bHQpLiBBbHNvLCBwbGVhc2UgYWRkIHRoYXQgcGFydCB3aXRoDQo+PmJvb3N0
X2V4cF90YXNrcy4gVGhlIGNvbW1lbnQgYWJvdmUgYm9vc3RfbXR4IGlzIG5vdyBhYm92ZQ0KPj5i
b29zdF9leHBfdGFza3Mgd2l0aCBhIHNwYWNlIHNvIGl0IGxvb2tzIChhdCBsZWFzdCB0byBtZSkg
bGlrZSB0aGVzZSB0d28NCj4+ZG9uJ3QgYmVsb25nIHRvZ2V0aGVyLg0KDQpZZXMsIEkgd2lsbCBh
ZGQgeW91ciBkZXNjcmlwdGlvbiB0byB0aGUgY29tbWl0ICBpbmZvcm1hdGlvbi4NCg0KDQo+IFN1
Z2dlc3RlZC1ieTogVWxhZHppc2xhdSBSZXpraSAoU29ueSkgPHVyZXpraUBnbWFpbC5jb20+DQo+
IFNpZ25lZC1vZmYtYnk6IFpxaWFuZyA8cWlhbmcxLnpoYW5nQGludGVsLmNvbT4NCg0KPlNlYmFz
dGlhbg0K
