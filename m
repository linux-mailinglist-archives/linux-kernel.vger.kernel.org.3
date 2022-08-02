Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18448588213
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Aug 2022 20:49:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229988AbiHBStm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Aug 2022 14:49:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229536AbiHBStj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Aug 2022 14:49:39 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CEE937F9D
        for <linux-kernel@vger.kernel.org>; Tue,  2 Aug 2022 11:49:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659466178; x=1691002178;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Du/Fv8f125pS59xNshz0mNArWAAdeYTMxGAm6qquIwA=;
  b=LveAbwX7JaixjcJ9xG0vagpv16AoR8Z77Up5b4wzElUxCj0DDCooG4An
   UbggAk/SCQpniGw0DWhpmrXNdtlqDH90iK9KBGA8NrH5AcYl7GfjDYvb2
   e7WSbuZhMtop+lDQ4/zj8NdGdURLHUd/Dsw0+kkkDqwoHBCXLkPR8TXRm
   NaI9zMyFZ/fimCLoSK/nDs3iColZ0qF5ViGMudtPY1wk6xC0lv6zkw9w8
   2a6w3N1MUTu0BDb3ufsv4L+iFWpa3vKdo8PncKS9ns2t7B8OYnabZ2nKP
   GlpDLLFVrN6eA4dfvdgrpT9k6Ez3klny4obXRW2yrqRVW7PcipKsI4gK8
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10427"; a="276405022"
X-IronPort-AV: E=Sophos;i="5.93,211,1654585200"; 
   d="scan'208";a="276405022"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Aug 2022 11:49:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,211,1654585200"; 
   d="scan'208";a="670557756"
Received: from fmsmsx606.amr.corp.intel.com ([10.18.126.86])
  by fmsmga004.fm.intel.com with ESMTP; 02 Aug 2022 11:49:37 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx606.amr.corp.intel.com (10.18.126.86) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Tue, 2 Aug 2022 11:49:37 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Tue, 2 Aug 2022 11:49:36 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28 via Frontend Transport; Tue, 2 Aug 2022 11:49:36 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.174)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.28; Tue, 2 Aug 2022 11:49:36 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gWQMe5kvJ6O1/kFrJzMwny+pAAevGGBssOE1KUz+4bP9o5VFlgQVoVpEeoyjMvFMvWwqNynYgRpctLxjUtIX4txOsx1YK/pIOScH2D7MN6DM0ioG8PLINNKCvwDAPJjjc4nwTOWAhBs48KxlBBjDAx1jb7FHbNkleF+czaONeYLucvBUgKZoZCzQZ4lxTAx1R/31JZZe02POVwos1tPN+7xD0sAYohL0ygJVDjy8kO/yjQ5x57+VuPsUwGGtnO7CVjuSB6qCyFCb/KWU+Z+6t3TuwsJxVt0kQy15rH37kyJ8tkPHeDWwpAaaoZuH7j6wclFH+aL0F+oT+cFqfcBEBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Du/Fv8f125pS59xNshz0mNArWAAdeYTMxGAm6qquIwA=;
 b=FgcHaDc/PGXjRNjAVwBC2PNy9bggyEIpIYsjz08/mwp8D/qwaSL8dUp3qysFZSXbWhQYpar5JEr3QhwzM8vIOdVeOwe+Yy7YBceNkHpqpfGmC429t6eDSoKwOQLG47JrUsmCZkYT0HnlkdA7B9fyMjkEE/OAx6C36SjCjBznd8SP0AtlGnamuM7apNMVnw17A7OcIiFrglKhoaoAcOQR2EvnbMYS6kQeQ1enlnMWuNlUGlyW1CeWlu7kyixE8/jQ5Yj+CiSGZHW+y2MFRZtYXbHpR74by8ZQPMHT29YEkBCfJA/7erdQOZgoPOduAdhJ7NyJIuX3eQpVvgb011qI0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN2PR11MB4093.namprd11.prod.outlook.com (2603:10b6:208:13f::21)
 by CY4PR1101MB2327.namprd11.prod.outlook.com (2603:10b6:903:bc::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5482.14; Tue, 2 Aug
 2022 18:49:35 +0000
Received: from MN2PR11MB4093.namprd11.prod.outlook.com
 ([fe80::59bf:4940:8bf:b0b4]) by MN2PR11MB4093.namprd11.prod.outlook.com
 ([fe80::59bf:4940:8bf:b0b4%7]) with mapi id 15.20.5482.016; Tue, 2 Aug 2022
 18:49:35 +0000
From:   "Winkler, Tomas" <tomas.winkler@intel.com>
To:     "Teres Alexis, Alan Previn" <alan.previn.teres.alexis@intel.com>,
        "airlied@linux.ie" <airlied@linux.ie>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "Vivi, Rodrigo" <rodrigo.vivi@intel.com>,
        "joonas.lahtinen@linux.intel.com" <joonas.lahtinen@linux.intel.com>,
        "Usyskin, Alexander" <alexander.usyskin@intel.com>,
        "tvrtko.ursulin@linux.intel.com" <tvrtko.ursulin@linux.intel.com>,
        "daniel@ffwll.ch" <daniel@ffwll.ch>,
        "jani.nikula@linux.intel.com" <jani.nikula@linux.intel.com>
CC:     "intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Lubart, Vitaly" <vitaly.lubart@intel.com>
Subject: RE: [v5,13/14] drm/i915/gsc: allocate extended operational memory in
 LMEM
Thread-Topic: [v5,13/14] drm/i915/gsc: allocate extended operational memory in
 LMEM
Thread-Index: AQHYppVwiR9tbwYQyE+o5Df7bdpCf62b89LA
Date:   Tue, 2 Aug 2022 18:49:35 +0000
Message-ID: <MN2PR11MB409353A658768E0B68CD70BAE59D9@MN2PR11MB4093.namprd11.prod.outlook.com>
References: <20220706114345.1128018-14-alexander.usyskin@intel.com>
 <243c92cee65c256c4c8003052f73944e9486a3ff.camel@intel.com>
In-Reply-To: <243c92cee65c256c4c8003052f73944e9486a3ff.camel@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-reaction: no-action
dlp-version: 11.6.500.17
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a0bcd1d7-c687-4a10-e27e-08da74b7bea6
x-ms-traffictypediagnostic: CY4PR1101MB2327:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: oSwW2CMa7Xu9rE6N/5O1A0RI8uTAKlJaI47KtL6A0m8sUbbcPWvrPNtegIbuPQiXhsNF5VVQv/i68V5Y7gF7wunV1Gs4qRvCguRrR7dKjb9Z6ITXC1DBJfFYqe5Cr2ewBhOn/NnIZy86gK6hYg37O8nFrGAYhzHqdNeioBH4Y43kwbmcrJs2tHsyIWTt9BHTSwt5iJYB0nOmiXL2pYdLPOTkn8gbEZxDRykY4V94jq4NUr/T9C/1+cyBhowK4w+bQKI/Ezv+uC1APQ3lrLoKipBIjd+Mi6K2MO6AbqE2CHl8CD7j/IivPy1NP9eEMhR2qeRpM9oe3D6HbmCWYTg7DkuGKPwq3LBMge7mddNL8VC+4pPlEfgcK18L/+P3RX05nFOAbnLZ8F+aQJ8fb01rviQFQOYDvCt4Oq3UUXmh/b4LJdufKSbFzmwaU+l++/WVsGnZU241axi4UJmfZOQcvDGaIbdjkRSw7COK8ujA43W+4AE86fhEHV4+dp+FxY2tYd1FTgk8kAgFu2UVP4/46FuM5/xuVHMyckTxg2zAq9shDj5MoEhjDF9+1qo1X3R5FbEYoag8HUNltkhQLMUSe8pJzgKyJMpdnQf3aCx+nNA5tELX+K2hrUnNUsxElOaCSPZTSkjn7v1bF4CbptY8jjSBmSPjcmN6yW30vc6vspgvNRl/EVz9bSKzGnjbxj3GKCiX1RSIR+ZHwS1I2cSrF8KZYbGQVVD7XOzlGWSRHSpcE0785g0mroRgO1OK4x7p55TeL8p3vsveLjGimykOBp0E5OtAUNoS3rWAPGbqvS19TZ4b2N2AofBusbCLBhSlasLj3QAAgXBRkOIBR8Xo5A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR11MB4093.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(346002)(136003)(366004)(39860400002)(376002)(396003)(7696005)(6506007)(26005)(9686003)(82960400001)(921005)(38100700002)(122000001)(33656002)(38070700005)(186003)(52536014)(83380400001)(478600001)(316002)(66946007)(86362001)(71200400001)(55016003)(76116006)(4326008)(8676002)(66556008)(66476007)(66446008)(64756008)(41300700001)(5660300002)(2906002)(8936002)(54906003)(110136005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Yi9mamRrMU9VR0tNWEhUS1gxbjExSDRMWk9tTDdaNkZUWEZFWFhMaHFsYTlw?=
 =?utf-8?B?NlFKZDVZbXJUSFducVpJbXdwYmcxM1ZmSTRUVUFpSThKdzhVV3ppRTZkd3FY?=
 =?utf-8?B?OVZWajRTQ3ROVC9RWHpyVTdZN1JXVnoyQUhhd213cllFck1ZdzFvN3VVMVZE?=
 =?utf-8?B?aU9TNWZWekRmbWtqcXZ5clpnU3luMUQzOW9ZSXpZbjVtZ2FCSUVmNlBFYVY5?=
 =?utf-8?B?clg1Vk42K05UeWtBL3gzMFRDQWN2MWtKYklIVVFLNHcxR3RMeTNEd3Qycitw?=
 =?utf-8?B?V2xORG1xek85bmY4eXlrZU1NbWpTekdtTXV6VzkwZi9IbEJReDhBVFU3aGhW?=
 =?utf-8?B?bTM5UXpEcW81ZE5sWU9tZnFqelVpa0kwWDBYRENySnBPVG80RitPNWdUbWRB?=
 =?utf-8?B?cHkyM0k1dlYyN2ppVWNsMmY3V3ZadE95VVlGNlFXTkRNckN0ZFQ3YlpoV0lu?=
 =?utf-8?B?QklNRUxNWUhBS05uU0N5dlFDUmZOcVpuU0pPTXdlSDVXd3RjSWZGSVA2OHR1?=
 =?utf-8?B?WG0rbnVFZXFTcnZxYjltVFIvOGhSN3BtNUFtT3ZiVUlVZlRMNW5QaXV2eCty?=
 =?utf-8?B?TzRkRURIcU51U1hjKzlqcG52RVoydFQvVElVc3FGdHJUYUVFS2NFUlpDZnBm?=
 =?utf-8?B?NmRnK0Rna2U5ZUdUb0lyVjBnV3NEakJPOVY1YWxObnUxK2YzdHFIdkcvL2tt?=
 =?utf-8?B?UVlIdG1pbThTOFpBVHg4UEJZRTVGbjhRd2p5cE1rL3hOd01jOEErQXJqUlFS?=
 =?utf-8?B?ZTdkVnArMW5OeUlGSEhta2o4Nk85aVN3dWUxWUZObFp2YmhyUHQwMjVkY0Mr?=
 =?utf-8?B?L1VDT0tONjlwMnlrVExXU01WS1dJbmRCcFdjQU9rZlZ2UUdFaGRmb2g1T1pT?=
 =?utf-8?B?V0ZlYWgreHZ2K0Fid0UxS2JXRTJsYUNTRXpjZzlWcHlnK0s0Q1lURGNycDky?=
 =?utf-8?B?MXRWdmUzOGxpRXYvR0liVGJ5eW5LRS9MVi9RTTRaMFJrSmMySkVmNzhHU09B?=
 =?utf-8?B?dDhnU0xYUXdRenFkTHVUYytNV1NDcDMrdGRRUmVxYjl6OWd1WGhHRnllVTJi?=
 =?utf-8?B?K0Zab1dzV1RTRHBnZkZIVDJBbDZzSUZzaDRZRUlFNWNQS1ZKQ3k4aTVib3c1?=
 =?utf-8?B?R0ttMEdKdlR0cjkyWDN6TktYcVdrNFcyRU1WTFA5dnhvZWlVc3RtZkJHOXNO?=
 =?utf-8?B?bDAyeGdQZzRSSmhqOTQ0dUNFOHc0YmVUWUFWYlQ5ZWxTdUFkSGRRaHBwbDVI?=
 =?utf-8?B?WkszZytDV0Y0eGpkdnhoRkRyZHIvSGErUXVDcG9OMWlwTndHZjNRdURvMzdP?=
 =?utf-8?B?bFMzeWdiWnRXbjlUdDkvd2Z6MW5XTk8wOHZwZklNWm0xZlJrckVQREFOM2hJ?=
 =?utf-8?B?UURtNk5ZZUhMbXR4d3RIZnU4Y20veUxJb01TYjJ2N1JKcmhtaXUzb2FZUlVw?=
 =?utf-8?B?NkxwNG5CMHo5Y1N2eG1WRFJXRnVKbnZ2SW9vUHhaUnBpNDFhMkZyR1ZpUXM3?=
 =?utf-8?B?dnVzUmUzeWdRcDJJVHdaaVF2Yy9xSzNuMkFlRXRJMHY2L1lWY2gzM05sdWQ1?=
 =?utf-8?B?NXc2TmpEZ1gyTWlSMzF1a1pLL3lJd1ZHbk9LblowRXcvUEZlbEhieEkvQWNX?=
 =?utf-8?B?VG1hQ3NUaHRVbnkzQmlING81MTVaNlY5K1JIc2F6ZFdibmJWNG9iclMxZUxa?=
 =?utf-8?B?bk9hZkhlbTR4UjdWN201K0FleCtwbGJoKzBhYWlDRllEWkZwenpyVVdMMkZw?=
 =?utf-8?B?Vy8yc2dmM3F6R1F2R28wTVc3dzdMRWRndzk4STd0QmNJTGNQTzVmMjhPZzE3?=
 =?utf-8?B?OVh3czZYSDVDOEhlUXRVS0xiYXRUOFZ2QXNVMUoyMEdFQzFvTnJ6QzRkQUVX?=
 =?utf-8?B?RWduZXhUZk1nWGFzbC8zNkxyUWE3N0E5RXNlMnNPYWJnSGcxNHdaQ0JyQm5T?=
 =?utf-8?B?ZnZPdWpnbmRVRjNGN3oyNWJNNmk3dEovZG5NbGtlbnFLenNQRmlFWFFQWVBI?=
 =?utf-8?B?czg5ZFV1eVV1YTc4QUpXbUo5OWk5SDFFOGszRXNxdmFvcS9LSU52NE5ScGE3?=
 =?utf-8?B?K0x5cTJLRjI4U2FMTko5M0FTeVBOZVVVMGlDa0x0WkhZNkJkbEJEdkMzQVk5?=
 =?utf-8?Q?+7x9FUZHwpWAcmfBGIKlkv0pJ?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR11MB4093.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a0bcd1d7-c687-4a10-e27e-08da74b7bea6
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Aug 2022 18:49:35.2322
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: X3l88px/Wb+GJnPPFFrf1O1LwLlZmLH0pXqJoBQDbFucVymLeeG0k34v9vwvJLXYymNOkGLqePPwh5PNWQSF9Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1101MB2327
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiANCj4gTG9va3MgZ29vZCwganVzdCBhIG1pbm9yIG5pdC4NCj4gDQo+IFJldmlld2VkLWJ5OiBB
bGFuIFByZXZpbiA8YWxhbi5wcmV2aW4udGVyZXMuYWxleGlzQGludGVsLmNvbT4NCj4gDQo+IA0K
PiBPbiBXZWQsIDIwMjItMDctMDYgYXQgMTQ6NDMgKzAzMDAsIEFsZXhhbmRlciBVc3lza2luIHdy
b3RlOg0KPiA+IEZyb206IFRvbWFzIFdpbmtsZXIgPHRvbWFzLndpbmtsZXJAaW50ZWwuY29tPg0K
PiA+DQo+ID4gR1NDIHJlcXVpcmVzIG1vcmUgb3BlcmF0aW9uYWwgbWVtb3J5IHRoYW4gYXZhaWxh
YmxlIG9uIGNoaXAuDQo+ID4gUmVzZXJ2ZSA0TSBvZiBMTUVNIGZvciBHU0Mgb3BlcmF0aW9uLiBU
aGUgbWVtb3J5IGlzIHByb3ZpZGVkIHRvIHRoZQ0KPiA+IEdTQyBhcyBzdHJ1Y3QgcmVzb3VyY2Ug
dG8gdGhlIGF1eGlsaWFyeSBkYXRhIG9mIHRoZSBjaGlsZCBkZXZpY2UuDQo+ID4NCj4gPiBDYzog
QWxhbiBQcmV2aW4gPGFsYW4ucHJldmluLnRlcmVzLmFsZXhpc0BpbnRlbC5jb20+DQo+ID4gU2ln
bmVkLW9mZi1ieTogVG9tYXMgV2lua2xlciA8dG9tYXMud2lua2xlckBpbnRlbC5jb20+DQo+ID4g
U2lnbmVkLW9mZi1ieTogRGFuaWVsZSBDZXJhb2xvIFNwdXJpbw0KPiA+IDxkYW5pZWxlLmNlcmFv
bG9zcHVyaW9AaW50ZWwuY29tPg0KPiA+IFNpZ25lZC1vZmYtYnk6IEFsZXhhbmRlciBVc3lza2lu
IDxhbGV4YW5kZXIudXN5c2tpbkBpbnRlbC5jb20+DQo+ID4gLS0tDQo+ID4gIGRyaXZlcnMvZ3B1
L2RybS9pOTE1L2d0L2ludGVsX2dzYy5jIHwgOTINCj4gPiArKysrKysrKysrKysrKysrKysrKysr
KysrKy0tLSAgZHJpdmVycy9ncHUvZHJtL2k5MTUvZ3QvaW50ZWxfZ3NjLmgNCj4gfA0KPiA+IDMg
Kw0KPiA+ICAyIGZpbGVzIGNoYW5nZWQsIDg4IGluc2VydGlvbnMoKyksIDcgZGVsZXRpb25zKC0p
DQo+ID4NCj4gPiArCWlmIChkZWYtPmxtZW1fc2l6ZSkgew0KPiA+ICsJCWRldl9kYmcoJnBkZXYt
PmRldiwgInNldHRpbmcgdXAgR1NDIGxtZW1cbiIpOw0KDQo+ID4NCj4gTklUOiBBbnkgcmVhc29u
IHdlIGFyZSBub3QgYmVpbmcgY29uc2lzdGVudCBhbmQgdXNpbmcgZHJtX2VyciAvIGRybV9kZWJ1
Zw0KPiAoc2FtZSBiZWxvdyk/IGVpdGhlciB3YXksIGVuc3VyaW5nIHdlIGdldCBQQ0kgZGV2aWNl
IGlkIGluZm8gaW4gdGhlIGRtZXNnDQo+IG91dHB1dCB3ZSBhcmUgZ29vZC4NCg0KVGhhbmtzLCB3
aWxsIGZpeC4NCg0KPiA+ICsNCj4gPiArCQlpZiAoZ3NjX2V4dF9vbV9hbGxvYyhnc2MsIGludGYs
IGRlZi0+bG1lbV9zaXplKSkgew0KPiA+ICsJCQlkZXZfZXJyKCZwZGV2LT5kZXYsICJzZXR0aW5n
IHVwIGdzYyBleHRlbmRlZA0KPiBvcGVyYXRpb25hbCBtZW1vcnkgZmFpbGVkXG4iKTsNCj4gPiAr
CQkJa2ZyZWUoYWRldik7DQo+ID4gKwkJCWdvdG8gZmFpbDsNCj4gPiArCQl9DQo+ID4gKw0KPiA+
ICsJCWFkZXYtPmV4dF9vcF9tZW0uc3RhcnQgPQ0KPiBpOTE1X2dlbV9vYmplY3RfZ2V0X2RtYV9h
ZGRyZXNzKGludGYtPmdlbV9vYmosIDApOw0KPiA+ICsJCWFkZXYtPmV4dF9vcF9tZW0uZW5kID0g
YWRldi0+ZXh0X29wX21lbS5zdGFydCArIGRlZi0NCj4gPmxtZW1fc2l6ZTsNCj4gPiArCX0NCj4g
PiArDQo=
