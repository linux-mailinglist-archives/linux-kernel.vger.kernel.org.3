Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 300FA5667A9
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 12:19:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230004AbiGEKTD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 06:19:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231341AbiGEKS5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 06:18:57 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD3EC13F7C
        for <linux-kernel@vger.kernel.org>; Tue,  5 Jul 2022 03:18:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657016336; x=1688552336;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=senRGKfokGLcehzCP8pe8uwCxo9HIY9B3AQDTe8bQxU=;
  b=J2SACfPBSYYNXDU4ujc73vZzeOYRP3JVpxZoUBI+A5RPo0ocUmZawtO1
   EnxsyqnUA972Gzd72SCjmU4GyPWr0zeSD0N3jaOamT/LySvOBYUMe/qvM
   pWcrYjz2ZZGx3LggKVpzAoK/ylONt3rovcH5l9wDbIp8382R6DKGzrg8k
   18hdwyQOhSbn/Yz8VqPTmKGb3HeycvYXc8lVsjTvRd8J9ZtZQEyND4jbc
   Z8nDXrpYcJfn3vjwlkkb9O66h6fJkGlOjFcJ3zJdrnI+xEbpJlzHQTlra
   Gf4Ih+dux2Uf0E1PEnojnjkteBfqFrF+OWpnATuKt9m67IPHXw/46HZ6d
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10398"; a="308854503"
X-IronPort-AV: E=Sophos;i="5.92,245,1650956400"; 
   d="scan'208";a="308854503"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jul 2022 03:18:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,245,1650956400"; 
   d="scan'208";a="695609471"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga002.fm.intel.com with ESMTP; 05 Jul 2022 03:18:56 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Tue, 5 Jul 2022 03:18:55 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Tue, 5 Jul 2022 03:18:52 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Tue, 5 Jul 2022 03:18:52 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.170)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Tue, 5 Jul 2022 03:18:52 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ggQDk1as43YRNlV7moopFmh2gnW3tFyVM5FbwTTxpvLIeEuOIsZNkAH1ZnDsmzl0joSS4yeYqNKuOrMdo0gEV+5lR1a52su9xbHZosAMFX0/S7nME9M1G3MQjXmw7nCl8WbhaP1WQ5q1bRNV8UrN/8Ofb8ao7b+/VXGErKDkTrLfGmD4BD0fYAegP1bf5SM2S+VUffW4dTr3FV6O2mippZWzQmWuOQc4FEHOPbKB5FtgQqgz+Kv1WWTPgS1TNMYr30YXtPJ2Q1Sj66DMt4eHh8nhDX/Wi+Uc+GOSeu4uIo/iq1CSC4S/yrqoTPA2vtg6yFgSvfMzkDoLGWhYgg53Vg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=senRGKfokGLcehzCP8pe8uwCxo9HIY9B3AQDTe8bQxU=;
 b=oFa3iwUATFqDRKo9aMURKLQ8N6x/AU5uCR+riluXIFSGwJQRDoJW8/nuyrAKGIOruxTNC+99YOzZwYim5Jp0ufieI361WO0F0JL7tb3djUu46XRkqO43bP5kq4yLvobzAStcNIBj8sfQwQhNIZIKPbk9zI1GsdIC9spSeAAiXED55Mh6HIk4mXBb+NMmLHC4Bi5YtpLeSyDvWdfIUOm9m5MT7P+OcM5Pt/V7V8y3Xd2hAy+cZ6hQFU1SkSPCvIoHpH1mAD8kq2huwk1WTh7No/wQGRruvcGum7uUiFfR056GFGOX3ntczWouorPcUsXEV5oC9NVuesaIwzUYVb7oMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MW4PR11MB5823.namprd11.prod.outlook.com (2603:10b6:303:186::12)
 by CH0PR11MB5250.namprd11.prod.outlook.com (2603:10b6:610:e1::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.14; Tue, 5 Jul
 2022 10:18:51 +0000
Received: from MW4PR11MB5823.namprd11.prod.outlook.com
 ([fe80::50de:adf:cccd:f38e]) by MW4PR11MB5823.namprd11.prod.outlook.com
 ([fe80::50de:adf:cccd:f38e%7]) with mapi id 15.20.5395.017; Tue, 5 Jul 2022
 10:18:51 +0000
From:   "Winiarska, Iwona" <iwona.winiarska@intel.com>
To:     "niejianglei2021@163.com" <niejianglei2021@163.com>
CC:     "openbmc@lists.ozlabs.org" <openbmc@lists.ozlabs.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] peci: fix potential memory leak in devm_adev_add()
Thread-Topic: [PATCH] peci: fix potential memory leak in devm_adev_add()
Thread-Index: AQHYj6X5XZR0daxPV0yVs6gADiT+LK1vkfCA
Date:   Tue, 5 Jul 2022 10:18:51 +0000
Message-ID: <d4bfcbfa4fbbb1acdd8110287744a39d6525306d.camel@intel.com>
References: <20220704125922.2240585-1-niejianglei2021@163.com>
In-Reply-To: <20220704125922.2240585-1-niejianglei2021@163.com>
Accept-Language: en-US, pl-PL
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.44.2 (3.44.2-1.fc36) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d209270d-85ee-43cc-a850-08da5e6fc1ea
x-ms-traffictypediagnostic: CH0PR11MB5250:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: sV/ZckNaCdnjFAcv2E0bP+LOf8qcw9fFBGQSxSVpNqfUqKE+cZ89eqhaeUhmOGzD6B/gcVSAcBDpK5ks7yijmP578obhoT/0aNdXoLR8eS0RONx57aufDHmdiMkrfX2hOVktg8DpfTl38hlDKh+xYgIA1qTgYPzAMOqTqKu8f0PgOnisvJaNlXJ/AICXX72grPxu0v9S5OWhA41ISrOlEy04UfMARRtPPaeN8sOU8bwekni6LqvDJAl/wwn1Ys7aTv7+YHCHVdgt/TP0EoGrXu9QhUmZ8Zx/ZSAMyfRLs042jKtsrmzBVyNB3moqM85ui3WHOqExxli9kYB4XmyDR+3HpF4QPJW1sTusYFyiBauqQT/lRsypeYVM8MxvO1FkdC9nGJDpY1HNzl6ezAFGrZNbeKuhdbJ2ILfB+CIDKiguW9cMrYHxuFGw8wqUXnXNvalQSA168N2v4ASPPuW8SkbXIcUk0Vz1ungUh6h246AMiNP2qEZFnLioJR/KTqxVY6rZzs3KPApqS5/gLRTk9bnwXJ2u8eObON7GpT/o7laPQDbOuIRaT+cRRClIDM2Ei5CWmtsfqYt+fh+Zcqf4DTkEYIFYcJr33hEyXV69qz8C5ZoGUmfvI+JGFfJef7uvtMkDlEehp+rccOdD97XXfyVRAxAEpXqfdR2zljNxOpFzBI7xqlFbQWp4J2fUv41YhUQW7WYYZkawkpIHgnY04nY26K3DaE5dW445vDNu/DZD+GpSC7eem9tS189R0Ht21cEJAIACPPekdfSBhkm7Ku7N0bWHOZxoo72/1evxeVHyJK66ZGwXVa6UvWwncn4rZkLSICN8pp1I6N7ySZAKLQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR11MB5823.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(376002)(366004)(396003)(136003)(39860400002)(346002)(8936002)(38100700002)(966005)(6486002)(86362001)(478600001)(76116006)(122000001)(66946007)(6512007)(4326008)(8676002)(64756008)(66446008)(66476007)(66556008)(82960400001)(5660300002)(2616005)(71200400001)(91956017)(26005)(186003)(316002)(36756003)(6916009)(54906003)(2906002)(41300700001)(6506007)(83380400001)(38070700005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UVlYbEpSRTRkSzV2OVhZRko2NXVCbStGKzFLTVcvRVZ6bEg2cXJZVEdWLzhB?=
 =?utf-8?B?NklWT3BQb2JqOSt6WEo0ZG1lQm9zdDhqK1M4VWo5ekNNY1ZXRTNiMDdnNGdm?=
 =?utf-8?B?cjBlZVlFUkZrSG9WSzFPbkRCYWZyTlpWMlZpamRiWUw5akFOYnhQOWhpR0lh?=
 =?utf-8?B?ODNaZko1ZGY5UlJ4VWtnc1RQTGlCMlNxWmNaQmIwdlhrRjZ1cXBSOCt5OUpL?=
 =?utf-8?B?ZFBlaXpwTVVZNFZHaHUwNU8vNjhkbjJZQXo3d3FreWE5YlZhUE5DN0wzZ2cy?=
 =?utf-8?B?amwvQ2IrOW95czRUMUZFcVJ6RWVVTmtiQnpiOWZYb0NxbVZhQ3dBNkxaQ2xh?=
 =?utf-8?B?d2FzNlFCT1VHWWo1VnA0Rmg1Vmd4cU1ZZnpCd0tLb1pOQ3JobDJqRkM1dG14?=
 =?utf-8?B?R1RWZS9Ed0FMV0NtYk5EdERNQkQxdUJJRXdLdU90MUI0T0VLNkRIK3diOWJO?=
 =?utf-8?B?aUNWdFE3c2xnaUR5WmFlbTBzd2hMYXZKNk5IV0FKZ3ZqQ2NnT25aVWUyNEJs?=
 =?utf-8?B?bmVjQ3V4OENRMVdNMTJHc3pEZzFZT0Z0dTZzMzBGSFRqUk1LdkNIeEpuVHFx?=
 =?utf-8?B?UjN1ZVRWS3pmQ0pkb0dJZ3Z2MVVHeXRSUHQ3Y0ZnU2R5ck0xWVc2MGs3R1NT?=
 =?utf-8?B?aUU4S1J1WE9tSnpTaFNPdlNLNG9hRkdGTDYxUVJJUEw2a2tLdkYvMVBaSStZ?=
 =?utf-8?B?WXNmbkZjYkFuSnFGdGRXMisydXl1Y2x2dXV4dWFZdG9SaDhhWTdvUjlPUVV5?=
 =?utf-8?B?YzdvNVFON1FNNzNVbEpiM0xMVktvUURCdW5lQlRaeGYvRnh4N1c5em51ZDY3?=
 =?utf-8?B?K3ljd3hXNE5ha3NLQndwUHZhSHVsdWhQY1g5dGhmMjRIS0sxQldNeW1tRkZT?=
 =?utf-8?B?bjNrb05GTlV4SC9LU2IzRy9MQzJBNEpJUFZ2ZGFjQk8wOFVGVXlTeE5waC9O?=
 =?utf-8?B?a3RoVTJTcmNHL0pqZWxIeXozVWVhK2tvaml6MWJOSnBLOE5uVGZMdU1lNGU0?=
 =?utf-8?B?Wkl0bVJDUHlLTEkwMHZXdFJUVDVFNlRJRm9Pa21Xc0lWVWwzY0lOdU54QW1V?=
 =?utf-8?B?c2gwSEh5VlAxamg3S3JicWNnSjBObXQ1VWdtRHJmQjBaZE1KVi9sVS9RNkNZ?=
 =?utf-8?B?UzgrL1JWa3Y2Zy9wQktWR3VOcjFVY0h5QVBML0lPQk95WFdmcks2OGNiQ2tz?=
 =?utf-8?B?M3J4M1BLZ0c2Mm9wMTExSzFlWmxEQXhvU2ZEZ0RlVnhUa3drVmJpd3RaTFJX?=
 =?utf-8?B?MDJud1lVenlGVmhjcGxaeC9qbVd0OXl2MDNndTFFR0w3MTVwUkZjYVVGVVA3?=
 =?utf-8?B?RTFXMGE5bzEyN0FwcU5uQldjcmVGSGQvWUN0ZzE2WVNJenc4Tk9jdlpFT1cy?=
 =?utf-8?B?VTBUZjVQY1FQY0dHVGcxaFhHdjBjalRJbEV4TVZiZzlUaWVsSTl2SzEzMU5C?=
 =?utf-8?B?RXFUWkRtMjhqZXNVNjhpc09tNFZjZU9qTWl1UmdtUTlISVI4L1R6UW1zdTUv?=
 =?utf-8?B?L0ZGWjN6aFJXR1g0ZmlEbmRQRzN2WC96bjFTalB1c3FxaVRTUm9NaHZKSmFn?=
 =?utf-8?B?TXl4ZERXQ3BSdUEwc0lTQ0VxV0FwVnlIZ3FEcldiZnJTTGV0WUF3M2tCdzdK?=
 =?utf-8?B?d0tKM3RxdE1lOU55YUJpeDQ4dlhKZHV6MW5ObzJPWEcwSWpRSUlJUytuVXdh?=
 =?utf-8?B?ekFrZDR1Wmhsck1VYjJ6emh5dXkxcEZGRldBVmxVUWtzNVRhK3hwYVMvZWNh?=
 =?utf-8?B?SlpoNEl5Z2FiTWVVbjZCbk1VZWlCZzRGbXJhMi9ob2dDT2NnNDM3RDVjNTZF?=
 =?utf-8?B?WWM2MzVpME1wL1JQeGhTaXluMVdjTURNV2RqZlhRUHJoYkJLbmZvc3N0WUJw?=
 =?utf-8?B?WDFpeFBBWjJtSk9YZTIyVXR5MkJkVGhZRDBZLzluUTR1TGtLY3ViVG1hc0Zj?=
 =?utf-8?B?cmRvNnRERjI2dFZPZjNKY0xvNExTU0tUaENXY0J2c3phNHFEOGNHWDFnTGFJ?=
 =?utf-8?B?RVpnaVYzTmptNDRkdCs5ZnNjMmxJbWtjaHNxd1VWZENDTWFoSVpGUkpUdlo4?=
 =?utf-8?B?ZE9WdjFIQy9pT1gvbDVMdURLYTViQmZuREt0WXJtTFdSK2RYREpVWmhFNHcr?=
 =?utf-8?B?RlQ4dGlFNEFvZGdUYUFtaEF1dkhZV0FKYVNFdzZrbW9VUmZuNWpTRG0yNXpB?=
 =?utf-8?B?QWc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <1E769FA38157E748BE3BA00A0F4D2CC6@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW4PR11MB5823.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d209270d-85ee-43cc-a850-08da5e6fc1ea
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jul 2022 10:18:51.3483
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bK6QUeSW1ZYSk6R88z6csT3qHRF5FTfVLgTGAGG/pJkpIiAneBeY61ZBHeziEgwA3/S/5fbJCMHiCJayKg/LfWmam20jk8GfAxMK+BitCTw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB5250
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gTW9uLCAyMDIyLTA3LTA0IGF0IDIwOjU5ICswODAwLCBKaWFuZ2xlaSBOaWUgd3JvdGU6DQo+
IGRldm1fYWRldl9hZGQoKSBhbGxvY2F0ZXMgYSBtZW1vcnkgY2h1bmsgZm9yICJhZGV2IiBhbmQg
ImFkZXYtPm5hbWUiDQo+IHdpdGggYWRldl9hbGxvYygpLiBXaGVuIGF1eGlsaWFyeV9kZXZpY2Vf
YWRkKCkgZmFpbHMsIHRoZSBmdW5jdGlvbiBjYWxscw0KPiBhdXhpbGlhcnlfZGV2aWNlX3VuaW5p
dCgpLCB3aGljaCBkb2Vzbid0IHJlbGVhc2UgdGhlIGFsbG9jYXRlZCAiYWRldiINCj4gYW5kICJh
ZGV2LT5uYW1lIiwgdGh1cyBsZWFkaW5nIHRvIGEgbWVtb3J5IGxlYWsgYnVnLg0KPiANCj4gV2Ug
c2hvdWxkIGNhbGwgYWRldl9yZWxlYXNlKCkgaW5zdGVhZCBvZiBhdXhpbGlhcnlfZGV2aWNlX3Vu
aW5pdCgpIHRvDQo+IHJlbGVhc2UgdGhlICJhZGV2IiBhbmQgImFkZXYtPm5hbWUiLg0KPiANCj4g
U2lnbmVkLW9mZi1ieTogSmlhbmdsZWkgTmllIDxuaWVqaWFuZ2xlaTIwMjFAMTYzLmNvbT4NCj4g
LS0tDQo+IMKgZHJpdmVycy9wZWNpL2NwdS5jIHwgMiArLQ0KPiDCoDEgZmlsZSBjaGFuZ2VkLCAx
IGluc2VydGlvbigrKSwgMSBkZWxldGlvbigtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMv
cGVjaS9jcHUuYyBiL2RyaXZlcnMvcGVjaS9jcHUuYw0KPiBpbmRleCA2OGViNjFjNjVkMzQuLmRl
ODY1OTk3Y2NkZSAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9wZWNpL2NwdS5jDQo+ICsrKyBiL2Ry
aXZlcnMvcGVjaS9jcHUuYw0KPiBAQCAtMjQ4LDcgKzI0OCw3IEBAIHN0YXRpYyBpbnQgZGV2bV9h
ZGV2X2FkZChzdHJ1Y3QgZGV2aWNlICpkZXYsIGludCBpZHgpDQo+IMKgDQo+IMKgwqDCoMKgwqDC
oMKgwqByZXQgPSBhdXhpbGlhcnlfZGV2aWNlX2FkZChhZGV2KTsNCj4gwqDCoMKgwqDCoMKgwqDC
oGlmIChyZXQpIHsNCj4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGF1eGlsaWFyeV9k
ZXZpY2VfdW5pbml0KGFkZXYpOw0KPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgYWRl
dl9yZWxlYXNlKCZhZGV2LT5kZXYpOw0KPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oHJldHVybiByZXQ7DQo+IMKgwqDCoMKgwqDCoMKgwqB9DQo+IMKgDQoNCldoZW4gd2UgY2FsbCBh
dXhpbGlhcnlfZGV2aWNlX3VuaW5pdCgpIHRoZSAucmVsZWFzZSBjYWxsYmFjayAoYWRldl9yZWxl
YXNlKCkpDQp3aWxsIGJlIHRyaWdnZXJlZCwgc28gdGhlcmUncyBubyBtZW1vcnkgbGVhayBoZXJl
Lg0KDQpCdXQgdGhhbmsgeW91IGZvciBwb2ludGluZyB0byB0aGlzIC0gaXQgbWFkZSBtZSByZWFs
aXplIHRoYXQgd2UgaGF2ZSBhIGJ1ZyBpbg0KYWRldl9yZWxlYXNlKCksIGJlY2F1c2Ugd2UgY2Fs
bCBhdXhpbGlhcnlfZGV2aWNlX3VuaW5pdCgpIHRoZXJlLCB3aGljaCB3aWxsDQpjYXVzZSBhIHVz
ZS1hZnRlci1mcmVlIHdpdGggcmVmY291bnQgdW5kZXJmbG93IGluIHRoaXMgY2FzZS4NCg0KSSdk
IGFwcHJlY2lhdGUgaWYgeW91IGNvdWxkIHJldmlldyBpdDoNCmh0dHBzOi8vbG9yZS5rZXJuZWwu
b3JnL2xrbWwvMjAyMjA3MDUxMDE1MDEuMjk4Mzk1LTEtaXdvbmEud2luaWFyc2thQGludGVsLmNv
bS8NCg0KVGhhbmtzDQotSXdvbmENCg==
