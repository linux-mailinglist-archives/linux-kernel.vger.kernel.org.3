Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3F7657D812
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jul 2022 03:45:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232840AbiGVBpm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 21:45:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229660AbiGVBpj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 21:45:39 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9BDE24F12;
        Thu, 21 Jul 2022 18:45:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658454338; x=1689990338;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=1eKkSBwzzNQgwDRKqOIzES264zFMvc6kxQYEow0hZcQ=;
  b=BhSSOBccofifm1H0l6vXb56GGsOqJ9AYUFMYVVHMV/pDg4M1xFUSi0Te
   C1vlRqxNW5FhxyQveXwp6Zy/F7LcdUPg1YgYoi8q4mRnY74fpJrUxdEOK
   AtI5kXFppdAnrrIxDLY5eriNzm8eSHeixD7/boZ7/0mb2qfWncoQSjxTw
   MO8YPM+/YPRIwdRGf+M7oq4WHtRqaHVRXIYJpyo1FRPLGjXmaLTJtklJj
   9+kA3J2YIkuyxC2/9W81r/DRrfHNE8HsoYAvkOh8ZCT+uwBEBi29nODXj
   SaUiOHA+TSkZ7adD6fFLVsYofIbQiNZoOuTocErFKBK/BoS2LD9bZzjkv
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10415"; a="287220341"
X-IronPort-AV: E=Sophos;i="5.93,184,1654585200"; 
   d="scan'208";a="287220341"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2022 18:45:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,184,1654585200"; 
   d="scan'208";a="666511204"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga004.fm.intel.com with ESMTP; 21 Jul 2022 18:45:38 -0700
Received: from orsmsx605.amr.corp.intel.com (10.22.229.18) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Thu, 21 Jul 2022 18:45:37 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx605.amr.corp.intel.com (10.22.229.18) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28 via Frontend Transport; Thu, 21 Jul 2022 18:45:37 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.169)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Thu, 21 Jul 2022 18:45:36 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gNw7851OWaY54dYXGCYOw6cr2YWwVy7DJ/hDvSq1V6SCxRsQBfPwTgFrbT04CeMsVozuLyr7f9Xh3GW7T2R2BabccGHqru5VqraFhqakPZjPjJnWYmGsvBhKk+sxOVmrRpmITb7axobQHWOIMVfSsILhhHd+EUg3CVBZ3ua4wRu6SAg85EPmlmSU/GWOUuGFO7hTdj4xeTpa/xx40TfDS/undpOb0Fl3gj8ECT2wDLBt+HrHv0SNgSOjiiWg2kITOH3aX+CswuWpYB6PPy8YFps97CReSb/3lbJDn54f09IVj5NbtELM52s0/3DgkHJi7nJWTimnbAdMUGB4jtPO2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1eKkSBwzzNQgwDRKqOIzES264zFMvc6kxQYEow0hZcQ=;
 b=aQJv9WwynE2NPTiRQoRdlXYlROGGgV7v/m0NRlrl6PVMKGvkysyQ7laSPn+nIOlb5MDdPLDbzfIDnHGENd/Ai6UbUgGxEG43UGTGGimxkd+420BbBaXd7hr4CCrzz7+Y6JRN13Ql9Cxr1f6pNZnjL4qzgwrJST2ZrJ0RIxD3M8DvRNjkoXIWCZRwnbHJKcYULsFETBJKKOF3HPzc6/XNl/2tQYW0RqcdNc/CEtNkQ1O/biVOU+6Czef5nizv59oOEmqNkIvVSKuB0j2GwknGQ0nQDZR8dsEC7m9PqeihnydU0q5ZbmJEcjLvarit0E7bvYs4nUrSb27weMwCVwNCXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB5880.namprd11.prod.outlook.com (2603:10b6:510:143::14)
 by PH0PR11MB4870.namprd11.prod.outlook.com (2603:10b6:510:34::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.20; Fri, 22 Jul
 2022 01:45:36 +0000
Received: from PH0PR11MB5880.namprd11.prod.outlook.com
 ([fe80::7545:d213:733f:4ad1]) by PH0PR11MB5880.namprd11.prod.outlook.com
 ([fe80::7545:d213:733f:4ad1%4]) with mapi id 15.20.5458.019; Fri, 22 Jul 2022
 01:45:36 +0000
From:   "Zhang, Qiang1" <qiang1.zhang@intel.com>
To:     "paulmck@kernel.org" <paulmck@kernel.org>
CC:     "frederic@kernel.org" <frederic@kernel.org>,
        "quic_neeraju@quicinc.com" <quic_neeraju@quicinc.com>,
        "rcu@vger.kernel.org" <rcu@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] rcu: Only check tasks blocked on leaf rcu_nodes for
 PREEMPT_RCU
Thread-Topic: [PATCH] rcu: Only check tasks blocked on leaf rcu_nodes for
 PREEMPT_RCU
Thread-Index: AQHYnWSsl2MjeOL47EmrLVIbb+0fMa2JlnaAgAAG9RA=
Date:   Fri, 22 Jul 2022 01:45:35 +0000
Message-ID: <PH0PR11MB58803E1D411353640320C196DA909@PH0PR11MB5880.namprd11.prod.outlook.com>
References: <20220722005213.3511188-1-qiang1.zhang@intel.com>
 <20220722011609.GD1790663@paulmck-ThinkPad-P17-Gen-1>
In-Reply-To: <20220722011609.GD1790663@paulmck-ThinkPad-P17-Gen-1>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.6.500.17
dlp-reaction: no-action
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a066f484-bf89-494d-05e2-08da6b83df6e
x-ms-traffictypediagnostic: PH0PR11MB4870:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: KX+1xVjlmtsXX+Xu8vzE/0oPLg07nknq6t3uBKs3lMj/k9/tKi80IDsM3SKJUcWoIx/+1u2gTqfbS7CElAkCrKeG7XHEWXw3GEJ0BZ6fq8PdSFLbHW/wxCBMcd0ErQvCCuuF8/eVD41pepl24dC67BBoXV+DO29SMprwEwrz2XZ8HP3Enj1CSO34TcES2Hacvvpkx+H2BQndb5HMAY+a852EuO76KG7B8r/pJ5dNxJDUeQ5WWQdNFQ6sdZmdkgl4Rn+5mUx7L06AKKgjI/m9RmhIZcazr7P6jdkfLgy3wPfzIFOGvln0xEfkqebK8KRFnzwDu6EURTr+IEnyMzy6XBYGbdit6F6MEnTaEYHfMjbjjmSzVHq9oW0n3zrUlDwRsBrZm/osqkgx3nUqIQTxUTPwuaEQzEL1mcQmnbA6eE5OsP1FY1lN1IGDVSsUWsMD4H29NpAa2i+X6SSWGfCts5I5JdgRarFrprcm5zryZz3If/5pPo6KsR0Wffkw4vaQ+HuawJ2H1TwWEb1WvKbdbHOL6MNb55HS/p1hz7jIS+IoDYIUaSCIUir+AAWWYNhZUDlbKoP65GkXKbN18qRnAgDDRjyFW4oSJoFCPXFZ2hFzvEHzLyswO0G6qaIKtLePBxpzooLO9Q6SIkEAn7xrRfJ3FUoRi6zc9xFqBMeQazBTzkcR1Gi6vq33SyAcw/Z3xBVsTHQzhf4swsV1zHRJzMplvPnwJMYCdn1DV87erqk8AkwoIQEtafb0bVyozZInJAYO+Bs8tawmTDNY0lrORpIV8ZU84Dzd33es12PCKMSSxmgEUnoEnEDafueoBxzC
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5880.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(396003)(136003)(376002)(346002)(39860400002)(366004)(2906002)(5660300002)(86362001)(4326008)(186003)(478600001)(52536014)(64756008)(66446008)(76116006)(66556008)(8936002)(316002)(66476007)(8676002)(6916009)(26005)(66946007)(7696005)(41300700001)(9686003)(54906003)(38100700002)(6506007)(55016003)(71200400001)(38070700005)(122000001)(33656002)(83380400001)(82960400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RjdyMWJLWFFGMkg0RDZPclJQcm81U2RJV04vM1h3cXo5SDhvNlp4ai9RbEFo?=
 =?utf-8?B?YTJ0NWJBUURwMUo0NEFJajU1U25OSmtSRXJJcU40dFc0eGdPMjFMZUk5eGs5?=
 =?utf-8?B?eU5BUXBnZWhMUjBPY0xaK25jQnFPNmFkWmtma0NBZ1hVcjRXdStXVkR1Y0lh?=
 =?utf-8?B?RzVsYXllOWJVTlIwVXBQeEdXSWk3aXR4WXd1czFtblZ6RGg1T2lkZlJUdU5T?=
 =?utf-8?B?WFovSmhtZEZ0UG4wTEhqMDFZd3ZyM0txdEtEQTN2T0QyZkpJT1UxaTFwblNn?=
 =?utf-8?B?UWVZQkN2a28yK1FyRDJLVkhDUUhNUkYyQ2V5QzdJTFAvbjdjVlN3V2NNbVlV?=
 =?utf-8?B?MEJzanRkS0o5T2NXeHp1RlpSSlRhQ1lDcllFSER0dW0vUVl5QzhxMlZPVWts?=
 =?utf-8?B?WU4zaklLNklvK0ZuSlE5eGhrOWM4TlBqZVFKMlR3Mk9OY0ZkVklQcmY3czFN?=
 =?utf-8?B?N0dvOVc1SlJ4ZEFBMUN1bHJzaTd6Mnd5QnNNalRoVlZhTU5vV0FrTTdBYlpI?=
 =?utf-8?B?amhvK2RoWkhBMnBBZTdRbmlIcUZnU0xxQTFUc2RVNld6c2MyWC92bVFUVGNG?=
 =?utf-8?B?T3hqTVBYSjYvRCt1ZUJUNDd2U0ZlekdzYUpNYTR1OGpOMjU1SGpwNjV0UWt6?=
 =?utf-8?B?M0VXTFB4eXlmM2ZqK0U5MGhCQXdxU0VFZ2gzMmc2RTNzaXc0RG5EWFkwZ3o4?=
 =?utf-8?B?Wi9jZ2IrOWtDeXJVL0UzdEFVUnNpVlp6QUwzc0kvbi9LQXZVUjBRTkw1MWhS?=
 =?utf-8?B?dlMveWVhd1kybStwbjM0bHZSa01zbXIyUC9WbG1QQW56NWJCMVRGVzR4MlVM?=
 =?utf-8?B?M1E4aDNnWFhmN1pBTTlqWTdVbEowczRvQnNYeXQ3TDVjSWUvVHVvMGFJUytl?=
 =?utf-8?B?a3JRTFRrMXNXTXNnQkhIMWc3NHptTEFZRnpNd0xmR01ZS2dNd09CUllrSWZa?=
 =?utf-8?B?M3N0d0NudWdNOHdxQzVKNWNTdysyc2p2NTk1ajdBNnBGUGpMVWVkbi9BNkw1?=
 =?utf-8?B?ZHAyd1JnNzkva1JkVE5CL2JYdmd4Q0F2TzFYZWJCUGdFOXdRdHMvc1NxczE3?=
 =?utf-8?B?Q0Y2T3g5UzF5dE1Pa01IRk1tWjlVRklzSVpKUzRqUUdYQ1FLZ25menRQNkZ5?=
 =?utf-8?B?U1ltMmpPckUzYXY4UlVwSW94OGRUbEVCNnhFaXEreVg5b0hEZnpjT3pmdEE4?=
 =?utf-8?B?L0ExS0dieFhrbXYzeHBXdUs3L2ZjdThycGcrd2x4dUdhUkRQMDRDM0pmNnFE?=
 =?utf-8?B?WVM0QUxxUWlxcXRNWmNObVZIOVNzMFp0eEhRcTF1cE1LKy84a2E4QWlNQm1D?=
 =?utf-8?B?a2t5QlQwY0RyWEUwWjFKS3c1L0pTOG0xSUd5VDVvak13MjBaZjc5UXN1ckZW?=
 =?utf-8?B?UVBtK0drTURzMkRraVFxSnhCNmVTUDgxbk1tRE02Q0IrS0tMT2w5T09uQzdM?=
 =?utf-8?B?MXVmQ3ZWemJxMXh1Z3VweXFQRlpZaGlDbVB5K3cyUG96OW5xWDFLbGpGOGVy?=
 =?utf-8?B?eW9rRm93TUN0amh0WnNvbTh1M0ZXQktpaS9ZM3QreFd0bWxQVTlrN0xOV3hI?=
 =?utf-8?B?WldmZlRtMm53WTNkYmNCUUljSEpQb1lpa24xcDg2ZllNZm1WMWt0RTViZ3BD?=
 =?utf-8?B?K0d1Um1jcXpuWVNNTXg0U2gyV2VvaXVqeGRwbEs5ay9TQ1ZGZEx5MmNkQXRx?=
 =?utf-8?B?VTdEOVNvUmV5Q2M0djJBcmpheUx4RDNETHFsTEZWeERLd0tmeUhHUGFxd3Iw?=
 =?utf-8?B?dHlSSE50cXJvNzNhNUNJR2Y4TVFsbFZSM3A2TFJWVVdYN3M3eTcyQTl5TlhB?=
 =?utf-8?B?cGtrc2tTK0RoL2VwNGREZGM5VDJPTlJ5THZscEtKQWE3a0c3eklRaVR2bExv?=
 =?utf-8?B?RmNldGlaczVLOGtIYU1mbExxdTl3cGtxMUZhbzdlM2dvNm4yWDM4bFZvNU80?=
 =?utf-8?B?ZDA4RlIrNXJuM3FyOU51eGFielIrcWpSOFY4MVUrYk01YXFCTUN4R005ZWtv?=
 =?utf-8?B?ZHJSMzVjSzFyOTA1aCtuY1UrNlZjYzJFUUV3WXBuaDI4eVF2K0NIc0Z6N0Ir?=
 =?utf-8?B?YU5uOHRGdmdSWjNxdzNtUWx6TjhCdW1VREllUUNDZDFTMyt6Um1Gb2tndDY4?=
 =?utf-8?Q?AIn+il/O+BjgqOmFO77gKVyOE?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5880.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a066f484-bf89-494d-05e2-08da6b83df6e
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jul 2022 01:45:35.9450
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zpIk7wlOZppVXgJ4dcSZVU1RbSNPcce7RbDF548IOQdNxxslr3aLMogNRcIL81Vy4Ur2Ck3nKMUZD2VIr34z2A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4870
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gRnJpLCBKdWwgMjIsIDIwMjIgYXQgMDg6NTI6MTNBTSArMDgwMCwgWnFpYW5nIHdyb3RlOg0K
PiBJbiBQUkVFTVBUX1JDVSBrZXJuZWwsIGZvciBtdWx0aS1ub2RlIHJjdSB0cmVlLCBpZiB0aGUg
UkNVIHJlYWQNCj4gY3JpdGljYWwgc2VjdGlvbiBpcyBwcmVlbXB0ZWQsIHRoZSBjdXJyZW50IHRh
c2sgYXJlIG9ubHkgcXVldWVkDQo+IGxlYWYgcmN1X25vZGUgYmxrZCBsaXN0LCBmb3Igc2luZ2xl
LW5vZGUgcmN1IHRyZWUsIHRoZSByb290IG5vZGUNCj4gaXMgYWxzbyBsZWFmIG5vZGUuDQo+IA0K
PiBUaGlzIGNvbW1pdCBhZGQgcmN1X2lzX2xlYWZfbm9kZSgpIHRvIGZpbHRlciBvdXQgY2hlY2tz
IGZvciBub24tbGVhZg0KPiByY3Vfbm9kZS4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IFpxaWFuZyA8
cWlhbmcxLnpoYW5nQGludGVsLmNvbT4NCj4NCj5GaXJzdCwgdGhhbmsgeW91IGZvciBkaWdnaW5n
IGludG8gdGhpcyENCj4NCj4gLS0tDQo+ICBrZXJuZWwvcmN1L3RyZWVfcGx1Z2luLmggfCA2ICsr
KysrLQ0KPiAgMSBmaWxlIGNoYW5nZWQsIDUgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQ0K
PiANCj4gZGlmZiAtLWdpdCBhL2tlcm5lbC9yY3UvdHJlZV9wbHVnaW4uaCBiL2tlcm5lbC9yY3Uv
dHJlZV9wbHVnaW4uaA0KPiBpbmRleCBiMjIxOTU3N2ZiZTIuLmE5ZGYxMWVjNjVhZiAxMDA2NDQN
Cj4gLS0tIGEva2VybmVsL3JjdS90cmVlX3BsdWdpbi5oDQo+ICsrKyBiL2tlcm5lbC9yY3UvdHJl
ZV9wbHVnaW4uaA0KPiBAQCAtNjkzLDYgKzY5Myw4IEBAIHN0YXRpYyB2b2lkIHJjdV9wcmVlbXB0
X2NoZWNrX2Jsb2NrZWRfdGFza3Moc3RydWN0IHJjdV9ub2RlICpybnApDQo+ICANCj4gIAlSQ1Vf
TE9DS0RFUF9XQVJOKHByZWVtcHRpYmxlKCksICJyY3VfcHJlZW1wdF9jaGVja19ibG9ja2VkX3Rh
c2tzKCkgaW52b2tlZCB3aXRoIHByZWVtcHRpb24gZW5hYmxlZCEhIVxuIik7DQo+ICAJcmF3X2xv
Y2tkZXBfYXNzZXJ0X2hlbGRfcmN1X25vZGUocm5wKTsNCj4gKwlpZiAoIXJjdV9pc19sZWFmX25v
ZGUocm5wKSkNCj4gKwkJZ290byBlbmQ7DQo+ICAJaWYgKFdBUk5fT05fT05DRShyY3VfcHJlZW1w
dF9ibG9ja2VkX3JlYWRlcnNfY2dwKHJucCkpKQ0KPiAgCQlkdW1wX2Jsa2RfdGFza3Mocm5wLCAx
MCk7DQo+ICAJaWYgKHJjdV9wcmVlbXB0X2hhc190YXNrcyhybnApICYmDQoNCj5TbyB5b3UgYXJl
IGFkZGluZyBhIHNpbXBsZSBjaGVjayBmb3IgYWxsIHJjdV9ub2RlIHN0cnVjdHVyZXMNCj50aGF0
IHJlbW92ZXMgdHdvIHNpbXBsZSBjaGVja3MgZm9yIG5vbi1sZWFmIHJjdV9ub2RlIHN0cnVjdHVy
ZXMuDQo+DQo+QXNzdW1pbmcgdGhhdCB0aGUgY29zdHMgb2YgYWxsIHRoZXNlIGNoZWNrcyBpcyBy
b3VnaGx5IHRoZSBzYW1lIChidXQNCj5wbGVhc2UgZmVlbCBmcmVlIHRvIGFjdHVhbGx5IG1lYXN1
cmUgdGhlbSBvbiByZWFsIGhhcmR3YXJlKSwgd2hhdCB3aGF0DQo+ZnJhY3Rpb24gb2YgdGhlIHJj
dV9ub2RlIHN0cnVjdHVyZXMgbXVzdCBiZSBub24tbGVhZiBmb3IgdGhpcyBjaGFuZ2UgdG8NCj5i
ZSBhIHdpbj8gIFRoZW4gZm9yIHdoYXQgY29uZmlndXJhdGlvbnMgdXNpbmcgZGVmYXVsdCBmYW5v
dXRzIGlzIHRoaXMNCj5mcmFjdGlvbiBleGNlZWRlZD8NCj4NCj5UaGUgZGVmYXVsdCBmYW5vdXQg
aXMgMTYgZnJvbSBub24tbGVhZiB0byBsZWFmIGFuZCA2NCBmcm9tIG5vbi1sZWFmDQo+dG8gbm9u
LWxlYWYgKDMyIGZvciBub24tbGVhZiB0byBub24tbGVhZiBvbiAzMi1iaXQgc3lzdGVtcykuDQoN
ClRoYW5rcyBmb3IgcmVtaW5kaW5nLCBJIG9ubHkgY29uc2lkZXJlZCB0aGUgbG9naWMgaW4gdGhl
IGNvZGUsIA0Kbm90IHRoZSBhY3R1YWwgcmVhbCB1c2FnZSBzY2VuYXJpb3MuIEkgd2lsbCBkbyBz
b21lIHRlc3RzIG9uIHRoZQ0KYWN0dWFsIGhhcmR3YXJlLiDwn5iKDQoNClRoYW5rcw0KWnFpYW5n
DQoNCj4NCj5IZXksIHlvdSB3YW50ZWQgc29tZSBhbGdlYnJhIHByYWN0aWNlIGFueXdheS4gIDst
KQ0KDQo+IEBAIC03MDMsNiArNzA1LDcgQEAgc3RhdGljIHZvaWQgcmN1X3ByZWVtcHRfY2hlY2tf
YmxvY2tlZF90YXNrcyhzdHJ1Y3QgcmN1X25vZGUgKnJucCkNCj4gIAkJdHJhY2VfcmN1X3VubG9j
a19wcmVlbXB0ZWRfdGFzayhUUFMoInJjdV9wcmVlbXB0LUdQUyIpLA0KPiAgCQkJCQkJcm5wLT5n
cF9zZXEsIHQtPnBpZCk7DQo+ICAJfQ0KPiArZW5kOg0KPiAgCVdBUk5fT05fT05DRShybnAtPnFz
bWFzayk7DQo+ICB9DQo+ICANCj4gQEAgLTExNzgsNyArMTE4MSw4IEBAIHN0YXRpYyB2b2lkIHJj
dV9pbml0aWF0ZV9ib29zdChzdHJ1Y3QgcmN1X25vZGUgKnJucCwgdW5zaWduZWQgbG9uZyBmbGFn
cykNCj4gICAqLw0KPiAgc3RhdGljIHZvaWQgcmN1X3ByZWVtcHRfYm9vc3Rfc3RhcnRfZ3Aoc3Ry
dWN0IHJjdV9ub2RlICpybnApDQo+ICB7DQo+IC0Jcm5wLT5ib29zdF90aW1lID0gamlmZmllcyAr
IFJDVV9CT09TVF9ERUxBWV9KSUZGSUVTOw0KPiArCWlmIChyY3VfaXNfbGVhZl9ub2RlKHJucCkp
DQo+ICsJCXJucC0+Ym9vc3RfdGltZSA9IGppZmZpZXMgKyBSQ1VfQk9PU1RfREVMQVlfSklGRklF
UzsNCj4NCj5BbmQgaGVyZSB5b3UgYXJlIGFkZGluZyBhIGNoZWNrIG9uIGFsbCBub2RlcyB0byBl
bGltaW5hdGUgYW4gYWRkaXRpb24NCj5hbmQgYSBzdG9yZSBvbiBub24tbGVhZiBub2Rlcy4gIFNh
bWUgcXVlc3Rpb25zIGFzIGFib3ZlLCB3aXRoIHRoZSBzYW1lDQo+aW52aXRhdGlvbiB0byBhY3R1
YWxseSBtZWFzdXJlIHRoZSBjb3N0cyBvZiB0aGVzZSBvcGVyYXRpb25zLg0KPg0KPgkJCQkJCVRo
YW54LCBQYXVsDQo+DQo+ICB9DQo+ICANCj4gIC8qDQo+IC0tIA0KPiAyLjI1LjENCj4gDQo=
