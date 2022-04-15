Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6CF4502E7B
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Apr 2022 19:56:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344776AbiDOR6B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Apr 2022 13:58:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344553AbiDOR56 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Apr 2022 13:57:58 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1277D3968F
        for <linux-kernel@vger.kernel.org>; Fri, 15 Apr 2022 10:55:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650045330; x=1681581330;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=nR+Dy7d8u7411AJeEKjJAnv8dPAbEYqrgiM8+hlgMeY=;
  b=HLVD/GA3qbAwfPGzRdhaq0kCD5EeivPuOl0NLc4xbvDeq4RqLSaQwbEO
   gOxBhctdxBpykOrW9SUWmetkHURZygQ98K/wA4ISJawNvDg4aCPrexf6g
   mP4u3rzgKDkR0cNWukbZbKbqwa0CCMxLt9mixmftbNvsIhX6Tq/+StxF5
   FUwa828WK1EGg8ez6jygzA2Yen5hJfsANaN9NFk5p/dqHp2tEJWRYr7wg
   lzTFJ0MNNfFgAyIGL2KHkxDIPDauoEw7AOtg9I5pGYd3uWaW4CimUBitG
   rcvbCGtxUppL8ihT7SpVcqQvnBxbsiHb0Czdj13D/naDYaNQW6aVlXmI0
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10318"; a="288266499"
X-IronPort-AV: E=Sophos;i="5.90,263,1643702400"; 
   d="scan'208";a="288266499"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2022 10:55:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,263,1643702400"; 
   d="scan'208";a="574460202"
Received: from orsmsx606.amr.corp.intel.com ([10.22.229.19])
  by orsmga008.jf.intel.com with ESMTP; 15 Apr 2022 10:55:29 -0700
Received: from orsmsx608.amr.corp.intel.com (10.22.229.21) by
 ORSMSX606.amr.corp.intel.com (10.22.229.19) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Fri, 15 Apr 2022 10:55:29 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx608.amr.corp.intel.com (10.22.229.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Fri, 15 Apr 2022 10:55:29 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.43) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Fri, 15 Apr 2022 10:55:28 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B8qQ42YdDxWNTnMqa8yYODPoy+FlAlPxKNjEfEwV1/44zJoDuqjq5xyKg3C+Tf9VoaRRgiaMOEAMRkR7U8jS5J62Cf9gFS8scImel7RenfJm3VpZZekX89+XQu3y6bBa6VzCzOmM3fCTgamoxJ91lHrZXTHCwPZuv4gEXwdRclUyvmJTeQbjHzyYY9I2zRB0cPBcSLf8ANKx3nYEtGKAgtvThl7PuTQYboueWz9p3YQQOX8v7/R2q5zrvVf2K/W4SFUiKkFVZAav0OMsboKOaujz+QVjhWFr97Z1siJLsd7ap6CtxTPS840XDIKcP5HikVCCiap3rrI2ORfI8idBYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nR+Dy7d8u7411AJeEKjJAnv8dPAbEYqrgiM8+hlgMeY=;
 b=Qoq/LYb8w0WVxJotDQmaPQ9HgsBqbOCE8y07HYXTC/iL60RbjmVKFRqUTLWBT20VSLlfisoesOUM9opcPsrle+Sk3JlWAEryOCOYQPtz/MJuKbV+csxgGa5rG8EZ14YE0QMKEg13vERPle2vof/msZVCWEbC99k4HGXgCtuXxwWv8CzmSF2gbzU1E2NCPL5I8XF+7mE8CJ4wxKoJ5hEjyT9gpkxydOADwFDrbLq08fMrLXRb9qFgwyXK5TNXrDJpPPlVqFIdlzHkUHAaT5ylgh5hWp+r8G0wJopTHjF2n49yLLBoOTfVwkB+6svXmN07GdG4MDTFDmMfo70cTynqTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB5078.namprd11.prod.outlook.com (2603:10b6:510:3e::10)
 by CH0PR11MB5564.namprd11.prod.outlook.com (2603:10b6:610:d7::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.18; Fri, 15 Apr
 2022 17:55:26 +0000
Received: from PH0PR11MB5078.namprd11.prod.outlook.com
 ([fe80::f169:317d:51aa:6225]) by PH0PR11MB5078.namprd11.prod.outlook.com
 ([fe80::f169:317d:51aa:6225%8]) with mapi id 15.20.5164.020; Fri, 15 Apr 2022
 17:55:26 +0000
From:   "Moreira, Joao" <joao.moreira@intel.com>
To:     Nick Desaulniers <ndesaulniers@google.com>,
        Sami Tolvanen <samitolvanen@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Mark Brown <broonie@kernel.org>
CC:     "Jose E. Marchesi" <jemarch@gnu.org>,
        clang-built-linux <llvm@lists.linux.dev>,
        LKML <linux-kernel@vger.kernel.org>,
        "Poimboe, Josh" <jpoimboe@redhat.com>
Subject: RE: plumbers talk on kCFI, BTI, & IBT?
Thread-Topic: plumbers talk on kCFI, BTI, & IBT?
Thread-Index: AQHYUEaVjvSr7ym/Q0KgphPxLde+fazxQvPA
Date:   Fri, 15 Apr 2022 17:55:26 +0000
Message-ID: <PH0PR11MB507871A2E984E6AD0D2C600E85EE9@PH0PR11MB5078.namprd11.prod.outlook.com>
References: <CAKwvOdkyMyE0ZRUU9Rh4qTxpOseD=fydo-FB9kdd7zRo7nVreg@mail.gmail.com>
In-Reply-To: <CAKwvOdkyMyE0ZRUU9Rh4qTxpOseD=fydo-FB9kdd7zRo7nVreg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a3232ebc-4144-4272-b18e-08da1f091f70
x-ms-traffictypediagnostic: CH0PR11MB5564:EE_
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-microsoft-antispam-prvs: <CH0PR11MB556448E1CECF61603A06A81D85EE9@CH0PR11MB5564.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ZG5N7PzhhFKjfrQPUlArJzchac9AI1OMVFieh2QKqsJOrZnCJ58yI9drOh2hfKqnCuXfj2sgION1lop/m9OOHc4QgKObTZcpyOwGYbzdIDJvZL5WQ0Lu53r2eS0C4lKH1cGd5qHjjPbqVjP6gHYXKTQsQCklLX2SmCGuBXv0Y5oavsJpIX0KEmnmyhL4IoBLAbIgK9KRw3Rq9TC7qw6PChqvxMP2XxJULy3EDzonTL3oFWG+OeSKSKXybMGFUB2nd9hydG3f+TsvgRQ1kn8BAZZ+KFQJSPs/TlUpMAbsALioAM5X6KLNGywXn1W5WvDZFGRvqHfV/NUq8OkRGHgB3RGmt3TyjxDJEn9snvJOSj2JrtZfee7P3LPMlxb2B6spzTDuHe/D0H8F0oYKs23ZOsWO0dKfgYsTN8hWZkNoI9HHBA3fqyW0eNeXVXvARvswIzK5bV9CBpEF26v6Vr1DO+msHlXIrgGt4At035GDK481eS44IyI8I0WLENXuv1I/NuqnXoopCufthgHOCu4sgqDocwpUloNsKz1sB6doHOa5R64wwdDcozwyhe9grPTJjHM/vpQX8MABCOqu4Y3jZCFTOY44CC4+hKFEoYRoiNPJhysbNvjGPKGVBaNhEFQUdu71F1USxyxOAl/awjJ0b8CVMCrTzhjcnEFHolXIVjsxkIqFX+AWKGuW5NquJFkxzGXLCtoLNlkr/Ipucgq1PA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5078.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(122000001)(26005)(38100700002)(186003)(38070700005)(7696005)(82960400001)(5660300002)(8936002)(4744005)(52536014)(2906002)(55016003)(64756008)(66476007)(83380400001)(66446008)(66556008)(508600001)(6506007)(9686003)(53546011)(8676002)(66946007)(316002)(4326008)(76116006)(71200400001)(54906003)(110136005)(86362001)(33656002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bFdySk1qZ1huNHZDYXFYMGRqU2NBY0svaktGUnF0M0hnTy93ZDdjR0VrZjVK?=
 =?utf-8?B?d1gxeEFtZnNjL3VFRDRXb1QzdXpIRU1XbENBeVFxTVJHdm4wSFI5SmtNRWo1?=
 =?utf-8?B?NU9ZM3ZOL0lYVm9HTjNFb3p0WVpUWk82Z2pLNnRKMXIzS1dzcmhEVmZrZ3Vl?=
 =?utf-8?B?a01yeWNoZ2JiTzQzWWFLWDZYb285TyswVFMvUHB4aExYT1c2NkxZOGRBZGx6?=
 =?utf-8?B?MUdPLzJ2YU9UTVFkUDVKNmJON0dpdGp5WUppalNQK09aZ1d0ZFI1VkM1UWpG?=
 =?utf-8?B?YWxnT2tXZUJKNWxCbzhKeWdFbjcxbFVtTlZud200cDdlMDQxSUdpU1d6bDhw?=
 =?utf-8?B?cHg5aXQ5cDdFTklUV1lKcWNpZ1RKOUluM3ZuZlByWDErMHhiT3prNnE4YU1x?=
 =?utf-8?B?WHdWY0xNUTFyWEdESTlJY3k0Nm8vOENwY1dJYTZTS0dWRXEyUGhESE1sd3Nh?=
 =?utf-8?B?R3MzY0NQWVlNZmRTZnVQWUtMWXFucFFTT1AzOVFOM0pPRDVQMS92Tjc0dTVh?=
 =?utf-8?B?cjliUDF5UG9BUnIyZnFvWFM4aDY5ZDRKK2g1NW9rZmVaTXp3aXhJdk9NTDg2?=
 =?utf-8?B?cjlrYkxIQ01ucnYxMncxbXBMbXRtN2U0V1JMQlh0T05HS29aTW5laVV4Y3FX?=
 =?utf-8?B?VnZocWxwMFlBVGN2a2xlanFTQVdaRldHdnJmczd3SnNOU3M2MGVlelVuOFA2?=
 =?utf-8?B?WCs2Mk43ak9meUpoTHplTk1sRVhEMzhacmhRY051TzN5czlld2YxMTBydmJx?=
 =?utf-8?B?WE9WUTZ1UlJxRlBIN2dtc0J5Z0pESlpjaXJHSmgvZThpQmdGVXJJWHg2RWkv?=
 =?utf-8?B?VWxCTlR0U2FhVzZrOUV1RVQ2ZGxlZWlxRDIyc3lyelVTOGlKeE9zN2UrdW03?=
 =?utf-8?B?T1UwajVDL1hzMHpaRDVaZ0RjYjE5ZTkzVjBhS1E2M2s0bnZDaXFBbCtUVS9t?=
 =?utf-8?B?MkZ5NEFic2ZwVHBjV25SS3RVdXdnNXRGSGh4YStHbmgzVWJXSno5R1F2a2Nt?=
 =?utf-8?B?bU9rWkdNS0dOWlVEeFBtME0rTXpTdU1TbG9YbW1TRTRWc1lpbTMrVFN2ZzJV?=
 =?utf-8?B?WThHcUhQWDRtdk9sZTNmbE01d3lweVlWM0oxVUR5ZE9xcDVXUVZTUmVFRGVr?=
 =?utf-8?B?R05VODZiUlQ4WGc4Rm1Dd0R3cDJYbHVjQmJ3M1ltNUR3YkVaTUlXSm1XKytC?=
 =?utf-8?B?YTRjZTNmR3NRZnUzM3pJLzIzV3l5S3FNbU1VMzl1R0hVTUl3dTJmVXJkWWRG?=
 =?utf-8?B?RzdaMlc2OHRRZzlFbUdoVmpjZHE0bC9mYkEvdTg2WTJjSm5sU2RlS3RJRVZw?=
 =?utf-8?B?T1F1MUQ5NTRCVUoyb1gvK1hQR2dpblJ5eUtaKytpS3J1OForUVZsN0I1UkhQ?=
 =?utf-8?B?VEdQUmY2UDBHUW1JVVBDUjdLQjU1Ty8xQTVXRmxyeFN2MTZrVllRWU9ha2JP?=
 =?utf-8?B?cG93RkVhNDJ1S2R2RXV0QUxSWUZrRHhqQUlUYmxjMkk3dkF3Wm1vNXN0bzFp?=
 =?utf-8?B?TVdjUngreVdoNXZxRElGaFlKT0JFRG9RZWkzcHF4aXlsNk5TU0c1VnJCUHda?=
 =?utf-8?B?RjF3Nzdza1lzaGRUYmhtWDQvYm1EOVNOT3NONGpJVW8vN1kzcHJJRjcrb2hV?=
 =?utf-8?B?VE5TQjhwSTdFbE50djM4WXdMSTBCa3dNUDA1R2ZpaFAzRWd6dHFKL2EwRGgx?=
 =?utf-8?B?bDJRbEtHZGpDTjdod3lVZWEyMkQ0NlVtaWp3M2JqSmt6SDZ4TFRrbTRMZXhS?=
 =?utf-8?B?cnBwRU9uaHBVTndCeUdLcWtoUFJ6cXVBdC9oS1JMelJHMlpxbTAzQkR3UEcx?=
 =?utf-8?B?OWpTbjMyQjZZZTYza09sU05lVko4TmhIdmZEMFllV0Zmd3ZBbFB5RTVNQU5E?=
 =?utf-8?B?L2tSZzlNVUlFekl4U1JoK2NYL2hkN3dXdmU1Sk5BQ0lFNmhaLzYrc3NDblY0?=
 =?utf-8?B?VEpFRnRienBrMWZKQWFFMXVzZi9VVHgvendqcGhEOUNvOHFEYjZ1SXZBdERa?=
 =?utf-8?B?UnhMZUtvekRTNHR0STZ0aHpwMVJmcXYrTUF2MXZTYlhDMEZrUmV5NWcweDNx?=
 =?utf-8?B?VEVFR1JxYXBMcWNKWVJQK05xTk1VYjVhNHczODhEUVdWYmxKVnNMYU1NYXFY?=
 =?utf-8?B?MVNrbTJpVUl0Y1U5TXhZL0JXc0RJdDNyaXpMaXJPYWo4Q3U3UnpXZjJkeW1Q?=
 =?utf-8?B?akdwNWlVaEFYallTU3dEOGZ0dnNMS3puOTNiZmpkUkx1VWg2UGZHZUNIaXg5?=
 =?utf-8?B?VENJRnU4VURHdEJGSlFXeVh4RjBmWXNxMXhyeFhoZHJSWWxQaExmQVZlSEZp?=
 =?utf-8?B?Z0hZS0xxYllscm1NL0d5Z2RhQTlUQm9HeXRUNGh5bk8zTm96NXp2UT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5078.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a3232ebc-4144-4272-b18e-08da1f091f70
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Apr 2022 17:55:26.7742
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AjQbtnGumYR9rk3b4yOE568PeUlU1paifVKChmLHj93zqsxVDGwzok6LxENH1Y1CQJ77GN0JCcLu7Qm92VKr+A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB5564
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

U291bmRzIGdvb2QuIEknbGwgZG8gbXkgYmVzdCB0byBiZSBhcm91bmQuDQoNClRrcywNCkpvYW8N
Cg0KLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCkZyb206IE5pY2sgRGVzYXVsbmllcnMgPG5k
ZXNhdWxuaWVyc0Bnb29nbGUuY29tPiANClNlbnQ6IFRodXJzZGF5LCBBcHJpbCAxNCwgMjAyMiAy
OjI4IFBNDQpUbzogU2FtaSBUb2x2YW5lbiA8c2FtaXRvbHZhbmVuQGdvb2dsZS5jb20+OyBQZXRl
ciBaaWpsc3RyYSA8cGV0ZXJ6QGluZnJhZGVhZC5vcmc+OyBNb3JlaXJhLCBKb2FvIDxqb2FvLm1v
cmVpcmFAaW50ZWwuY29tPjsgTWFyayBCcm93biA8YnJvb25pZUBrZXJuZWwub3JnPg0KQ2M6IEpv
c2UgRS4gTWFyY2hlc2kgPGplbWFyY2hAZ251Lm9yZz47IGNsYW5nLWJ1aWx0LWxpbnV4IDxsbHZt
QGxpc3RzLmxpbnV4LmRldj47IExLTUwgPGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc+OyBQ
b2ltYm9lLCBKb3NoIDxqcG9pbWJvZUByZWRoYXQuY29tPg0KU3ViamVjdDogcGx1bWJlcnMgdGFs
ayBvbiBrQ0ZJLCBCVEksICYgSUJUPw0KDQpIaSBTYW1pLCBQZXRlciwgSm9hbywgYW5kIE1hcmss
DQpKb3NlIGFuZCBJIGFyZSBjdXJyZW50bHkgaW4gdGhlIHBsYW5uaW5nIHByb2Nlc3MgdG8gcHV0
IHRvZ2V0aGVyIGENCktlcm5lbCtUb29sY2hhaW4gbWljcm9jb25mZXJlbmNlIHRyYWNrIGF0IExp
bnV4IFBsdW1iZXJzIENvbmZlcmVuY2UNCnRoaXMgeWVhciAoU2VwdCAxMi0xNCkgaW4gRHVibGlu
LCBJcmVsYW5kLiAgV291bGQgeW91IGFsbCBiZSBpbnRlcmVzdGVkIGluIGEgc2Vzc2lvbiBvbiBD
b250cm9sIEZsb3cgSW50ZWdyaXR5IGluIHRoZSBrZXJuZWw/DQpNaXRpZ2F0aW9ucyBpbiBoYXJk
d2FyZSwgc29mdHdhcmUsIG9yIGJvdGggbWlnaHQgYmUgb2YgaW50ZXJlc3QgdG8gZGlzY3VzcyBt
b3JlIGluIHBlcnNvbj8NCi0tDQpUaGFua3MsDQp+TmljayBEZXNhdWxuaWVycw0K
