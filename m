Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FDD75842AB
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jul 2022 17:12:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229736AbiG1PMe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jul 2022 11:12:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229629AbiG1PM3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jul 2022 11:12:29 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30C03657C;
        Thu, 28 Jul 2022 08:12:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659021148; x=1690557148;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=kuo0161XvxaAialrEaRB3P7uWXI7TpDr/+0kQ1rG2/s=;
  b=Pgt2jrdODIpWQpncVIDP0cBHkibzzTnhlRLrlP+32eqsV83myIIC5qml
   JyO+ZHfifKLxUbqxY6lBzYm1Iha1NEOGPA1EnsteslUtwPmPNQM9nLG1G
   qndmfiQQcw/4R6GbjRH7ujVeeBxlxIRHG8Tsyqjgdasl3hyZpsw6jDENy
   LHMVeWV/vY2NnMGcL+bn3VZCX9J8nfOZveKxEqpED5eVrZiqswye0WFsU
   DlxzTdViKJ9IIvKI4wQ6Z4DV5Ec3ZDR/FYG5GuGf1Ju5AnrZxsfjDLC/2
   9sXo/jdmMm5xIfk0Oq9bqNkNZHoemIIZNLpU3bf0e+0CUVm/xapclGaiM
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10422"; a="289733144"
X-IronPort-AV: E=Sophos;i="5.93,198,1654585200"; 
   d="scan'208";a="289733144"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jul 2022 08:12:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,198,1654585200"; 
   d="scan'208";a="690356618"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by FMSMGA003.fm.intel.com with ESMTP; 28 Jul 2022 08:12:27 -0700
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Thu, 28 Jul 2022 08:12:27 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28 via Frontend Transport; Thu, 28 Jul 2022 08:12:27 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.40) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.28; Thu, 28 Jul 2022 08:12:26 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dc/Zx1hBX+bKYC0Xp9Plax8TgaU1mSX8GjK4vExex27BV9Ol82CGe3Qpyu1Ctdc9Qn6Tk7TSkMQ1lWZuWT9gjcCHuc9jYAgSXuC2ytR1IrkvFYmaWtotbyox9ybiqK0vgiCl6P4lMwFusWfj13pB8Z+87d23ELt5rrV08VzZLGiMI8Te+OJCwjMVlKo4RklneE3H/jnoExk0+IsxWvfV3zfj4323+UU5fq4XBX5qm3EExItwtssZ3Vax46JgC8uNPYKeoNDSRhqN5gdF2vughQcuvXDDYbGKqj7OH6yVsKB/RyqTYSOSJIxAcioaJl5FtRU0M5bOy+VBtKVyvdyR+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kuo0161XvxaAialrEaRB3P7uWXI7TpDr/+0kQ1rG2/s=;
 b=GWrfuvEedk7oYozmsBdYSH26WLqSOo6dsNYLHdC223XZxYva6Tju2hJPf1ikftJNLSACTBcXRWTMdUbWent2xfN4LoPhNbsgKG1Un/LL5CrYZDtdQsZtsX4I9y6GbqIaixCO/vUtw8VcQAkZ+Dgnn/FzYQPs5KM+J2q/hpjMbsUDBStfJVy7XHlUmXZmuboYM/r3sebwM1ZrmQKbc7RjphCoD6upDxLgzCReQOcQgMpP0KAQy7UfA11CzpbVjJsgvmWb5LHhLXNmV2EOjwBHckCPaB4T3go+lxD7yhU3zoWpqEw+kK2lFA/460lDslBG+5dxc8Qm39N5/7TsQt7Itw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com (2603:10b6:a03:48a::9)
 by DM6PR11MB4644.namprd11.prod.outlook.com (2603:10b6:5:28f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5482.6; Thu, 28 Jul
 2022 15:12:25 +0000
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::7c8a:9ebc:e674:796e]) by SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::7c8a:9ebc:e674:796e%8]) with mapi id 15.20.5458.025; Thu, 28 Jul 2022
 15:12:25 +0000
From:   "Luck, Tony" <tony.luck@intel.com>
To:     Hans de Goede <hdegoede@redhat.com>,
        Greg KH <gregkh@linuxfoundation.org>
CC:     "Joseph, Jithu" <jithu.joseph@intel.com>,
        "markgross@kernel.org" <markgross@kernel.org>,
        "Raj, Ashok" <ashok.raj@intel.com>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>,
        "patches@lists.linux.dev" <patches@lists.linux.dev>
Subject: RE: [PATCH v2] platform/x86/intel/ifs: Allow non-default names for
 IFS image
Thread-Topic: [PATCH v2] platform/x86/intel/ifs: Allow non-default names for
 IFS image
Thread-Index: AQHYlHZbTsHW5cJt6UuNd+Rjz+PPqK14SWOAgBuAF4CAAALRAIAADHYAgAACDoCAAAUugIAAB86Q
Date:   Thu, 28 Jul 2022 15:12:25 +0000
Message-ID: <SJ1PR11MB6083263E8EEBF106B6B61B24FC969@SJ1PR11MB6083.namprd11.prod.outlook.com>
References: <20220710160011.995800-1-jithu.joseph@intel.com>
 <YssFjbveghDLNn4N@kroah.com>
 <55368a65-c536-93c7-c501-9f6086e308d2@redhat.com>
 <YuJ8Ah37WAHGTJlV@kroah.com>
 <39b47ca8-1d25-0e60-d326-ad627541fe36@redhat.com>
 <YuKIL4QkC25h6RF8@kroah.com>
 <1ea8a38f-538c-43ed-c4dc-bc3722c03489@redhat.com>
In-Reply-To: <1ea8a38f-538c-43ed-c4dc-bc3722c03489@redhat.com>
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
x-ms-office365-filtering-correlation-id: 965955c8-a95c-4349-950a-08da70ab9421
x-ms-traffictypediagnostic: DM6PR11MB4644:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: iZ3622qIb6Z3UsrtP8NZOUpuU9hMt+8Zz5MZaNnRjmCLOjf5GcgADkQr6e3GGrkQkX1sN0f3YM/E68hWy9eE3z9CjK4nwOoZxShoXyLRtZ7ASpQ5ogQz5o2jpQnwP6IzOd05XdYn9Ocsfai/Qmojg2T7teIueH9vPPc1KkLR9TKggr0rUsrvWxkUGCQJPGYOTyvUCE3t+W/INm4s6KVpxw+X0v7jxPnv5e6g+2jMou06kisf4Yqf71byLFZ2evN2VurViN0BPCcQ3FlZMPwNkcUrRQISwPnnhrdudsahDCGk1xm487fSlJXdMEXKhqn2kQUmSTcuSAISnBBHab7MpdN7I+BzojPGHo8ndm1e+01QPFpx6NnziCZIDAYf7Tgxr7Q6jlgJUMsYm1nIzdJFbpI090877t1t25bOLMAzkrB2qK6dO/x0f0mF9tY3xAoiY5K0g09WQo2e2yP8glVtwfZyEJHhqSeV63LvsHBBdxt2qhk1BIOpzDztggOLVjNdZO/QsJr52UG57NPYsRmBrrpUUGDURuH0F9COMUWiO76tEIvniBqZXoeTqPCI1QO6zhrDkxv8gxul4IBMu0TpSqrq6yF2OGmGiSLFlrng/yJ3BvGrge1AOhxHuX62dmF4fWaiP35pFhWIhtmiWnilIVQzjAorRknaKQexKER+ES1OgFTRb4dR6pGsqc68mToa88idIZWgod1N1mN4CcVkq1Z3YiZMAiUF62NFe5b9vurupcBBZA/07jf7XlMVqPYcr7WoOq6BoqssBi6Fj9WZv9tb5wTHQiCnRCvF9vSgde0AhM3Zfp1cODEUDfDEba67
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6083.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(396003)(376002)(366004)(39860400002)(346002)(136003)(7696005)(122000001)(82960400001)(38070700005)(38100700002)(41300700001)(2906002)(86362001)(186003)(33656002)(83380400001)(55016003)(26005)(6506007)(9686003)(66446008)(8676002)(66946007)(76116006)(66556008)(66476007)(64756008)(4326008)(71200400001)(110136005)(54906003)(316002)(52536014)(5660300002)(478600001)(8936002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZVNFRHBLejlZSmRPOTdCWjRTVy8wMDRnbVZBdHZiOXcxZWhuK3Z5cVhnU2Iy?=
 =?utf-8?B?aXFWeFlVR0YrVTZqQVdvMlFCUDJoeUU1Y3J3VUhJN01GZFhLb3pOUG1SUy9U?=
 =?utf-8?B?WkdLdVM2LzMyTE9DaC83bXhIVk5OaElQTDljQTJhSHgrZzU1dEd4M2RYTVN6?=
 =?utf-8?B?VG4ya0I5M1Yxd0hyNWJCQityTTZOTjEzYkRSa0ppdXFTQS94OE43Yk9GVEwv?=
 =?utf-8?B?UXRCcStCK05KVDZqTjY5U3E3a1I3ajNhTGl6Zkx5alVyaG81bWZYNjIzMGFT?=
 =?utf-8?B?TVNwaXZFOWg2dTJwVE5VbEFRMTM5UnhtZ3ByMHplQnlyLzFEK2JWNTFUVjRG?=
 =?utf-8?B?dm1tUWZSUDlHQ0JteHc1TXdCQVdJbStiTGh4aFU4ekQ2U3RVN3lqeGpMTFJJ?=
 =?utf-8?B?akV0dkIrVFV4UGZ1UzV6Tm5HcU5oNXplYXB5SEthTStvQUY1OG1BS1MyWGpr?=
 =?utf-8?B?WDR4R3ZCSU41cGEwT1pPK21aSDNESm4yUW1xOVpNVWFvTEtXZFFmMGc4R3Zk?=
 =?utf-8?B?TGY2Mi9EN3RVcmk1YUdBdWVvKzlqbjdLTjRGanJjTlJCR3crcmdKbmhYb0Rz?=
 =?utf-8?B?VCtuVmgwanpyeEt0bUdHNjR1NkZ6MGc4VXg1Um0zS1Vmd1dENDh3VUYrZVU2?=
 =?utf-8?B?aW1FMXZJS1g4SUtoRTQxKytjaVd6eU00eENmSTl5bWlaSmxxbnk0c1RPVEhW?=
 =?utf-8?B?SHJNTGo1WDkrcmtVZXRPcWFnOVB4dVhNTGwrdDIwY1h6eFE2MTVrTlc2UnJJ?=
 =?utf-8?B?SklOYmEyM2NNUy9XczhIaThkYmxtK040cTR1bTBHbW8zUnBkallIK2xDQnIx?=
 =?utf-8?B?UmZnMy9hV2k2MXhyNmhPUWZJdHd4YUlYbmo3WkVpWjhwYkxiUTdTTGVVL2dO?=
 =?utf-8?B?Z3BvWUphSWxxOFF1RFlHdUZsaTlNTHNpR3hUaitqcmltYzBRbzE0UVhmQzFh?=
 =?utf-8?B?Wkd6S0NXcGJ5eTV5NERGUDhGR1dkVkRTQmg1Vm5VQnpGZ1NFRktkRmJHVWd4?=
 =?utf-8?B?eUl5K3N3WVY5MVJ5ZlpCMWxwSGxvY0daN2V2REJWaFNxVHN1ay8zMmpzNlA4?=
 =?utf-8?B?V0hORTVMM2Z0eHlQWTJnc25pL2JxelJ2dm5oM29IS29pSE5DVnd2S1VucndK?=
 =?utf-8?B?bkVmTGRoK0ZDS3lsUCt1WkFaSXN2Z0tqdDQ3ZDJ3d0U0WWhHMFVJaFZYRUJ6?=
 =?utf-8?B?YmhJa1B1RDU1YkN1ZkgvbnZFVWQ5YmVHVGhMTDJlWlNheXR3YTYyWHpiSjNs?=
 =?utf-8?B?dzBCTVpnRWVFWmt6TnJ2UHRhTTJVZWtVdDY2Z2NTWWkweWhpNFhOWmdaVHBR?=
 =?utf-8?B?NUJBbEJ5VjF5K2tHZ3BkRkR3dTZ5M1RqMjR6Nkh3bHI5WTdFTmhpczU0cENE?=
 =?utf-8?B?bnZRenpoUDhjejFncEgrbS8yeWNKTkcxa3E5SVdsY0xObENZemQ0dC9BYkVn?=
 =?utf-8?B?c0E0aFUzQUhSUCtuRmxmbWhoVUpwOXorQVBQWjc1Z3V2V3RsVVhDTnVmNk5o?=
 =?utf-8?B?TFlOQWZLNFVMUzNYUmFmN0FjVmMva0dOVXR1cDhPOEJFQnZWODFGbGRzWlNN?=
 =?utf-8?B?T2Z2RXVnWml3LzJMK3FIQ080ellQWnArQVNBQVdCRTNEek9VNFZlYmVtMEhr?=
 =?utf-8?B?RE1VUWVWQWhCVEQwbXlVRXJZdU8zQnNkdER1TXR4WksxSGhJWVZyeGxDQWNE?=
 =?utf-8?B?bkswNVhUQTBGaG1vQUhrUDR5UlJnSzFKb3FvakZGcitKeWFDMDNCTW5oQ3hr?=
 =?utf-8?B?eUdockNwcWlZZDU0ZXRzbHdpNFkrWjB6eDQvWDJabTNISVQvK04zSENxOXJ6?=
 =?utf-8?B?YjBjQm8weWQ5VVlvTVJIMnU2QW5YVUVCaUM4UlJXQkZRZ0I5VHRpTWVTaS9k?=
 =?utf-8?B?NkN5WnBPeFJqcWVIMDg1bXlYK1IvckhrcFRMNW5PTUVhMXBodTNBOUFMUmF2?=
 =?utf-8?B?ZjBUaDIvd3VCUjk4UHZ3SGlVM3psRVdNd1dHTmhMNXZxRDBNbTQ4cG5SOFJq?=
 =?utf-8?B?YTd0L3YyaVhFajluV01yU3JhYzMrSlhhMk1xSVpXY0VEbWNmYnY4TVhtazVQ?=
 =?utf-8?B?eFF2S2xOV0lLbEhyRUxmVUZqTVlEYmV2Y0hYOHFFTGc1Q3FqbC9ESkVGbldu?=
 =?utf-8?Q?Z63k2cDy4Hb4zqlpWp2Jhe5gg?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6083.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 965955c8-a95c-4349-950a-08da70ab9421
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jul 2022 15:12:25.2825
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VZ6wN3yAlilfMqBGg+hV8da3i0Q+rYjQTQQS7nn3nV/nM2WC9as2k/XcD4EbX33LMDQViFtyvSHb3A1IkLEF4g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4644
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Pj4+IFNwZWN1bGF0aW5nIG15c2VsZiBhcyBmYXIgYXMgSSB1bmRlcnN0YW5kIElGUyBpcyBub3Qg
Zm9yIGZhY3RvcnkNCj4+PiB0ZXN0cyBidXQgZm9yIHRlc3RpbmcgaW4gdGhlIGZpZWxkcyBzaW5j
ZSBiaWcgY2xvdWQgdmVuZG9ycyBoYXZlDQo+Pj4gZm91bmQgdGhhdCBzb21ldGltZXMgdGhlcmUg
YXJlIGhhcmQgdG8gY2F0Y2ggQ1BVIGRlZmVjdHMgd2hpY2gNCj4+PiB0aGV5IG9ubHkgZmluZCBv
dXQgYnkgcnVubmluZyBzdGF0aXN0aWNzIHdoaWNoIHNob3cgdGhhdCBjZXJ0YWluDQo+Pj4gdGFz
a3Mgb25seSBjcmFzaCB3aGVuIHJ1biBvbiBtYWNoaW5lIGEsIHNvY2tldCBiLCBjb3JlIGMuDQo+
Pg0KPj4gV2hvIGtub3dzLCBJbnRlbCBkb2Vzbid0IHNheSBzbyB3ZSBjYW4ndCByZWFsbHkgZ3Vl
c3MgOigNCj4NCj5SaWdodCwgZm9yIHZlcnNpb24gMyB0aGUgY29tbWl0IG1lc3NhZ2UgYW5kIEFC
SSBkb2N1bWVudGF0aW9uIGNoYW5nZXMNCj5yZWFsbHkgbmVlZCB0byBjbGFyaWZ5IHdoeSBtdWx0
aXBsZSB0ZXN0LXBhdHRlcm4gZmlsZXMgbWF5IGJlIG5lZWRlZA0KPm11Y3kgYmV0dGVyLiBJZiBw
b3NzaWJsZSBwbGVhc2UgYWxzbyBpbmNsdWRlIDEgb3IgMiBfY2xlYXJfIGV4YW1wbGVzDQo+b2Yg
Y2FzZXMgd2hlcmUgbW9yZSB0aGVuIDEgdGVzdC1wYXR0ZXJuIGZpbGUgbWF5IGJlIHVzZWQuDQoN
ClNvcnJ5IGZvciB0aGUgcmFkaW8gc2lsZW5jZS4gV2UgdG9vayBHcmVnJ3Mgc3VnZ2VzdGlvbiB0
byBnbyBiYWNrIGFuZA0KdGhpbmtzIHRoaXMgb3V0IGNvbXBsZXRlbHkgdG8gaGVhcnQuIEFzIGhl
IHNhaWQsIHRoZXJlIGlzIG5vIHJ1c2ggdG8gZ2V0DQp0aGlzIGluLiBXZSBuZWVkIHRvIGRvIGl0
IHJpZ2h0Lg0KDQpZb3VyIHN1bW1hcnkgYWJvdmUgb24gaG93IHRoaXMgd29ya3MgaXMgY29tcGxl
dGVseSBjb3JyZWN0Lg0KDQpUaGUgcmVhc29uIGZvciBhZGRpbmcgbW9yZSBmaWxlcyBpcyB0byBj
b3ZlciBtb3JlIHRyYW5zaXN0b3JzIGluIHRoZQ0KY29yZS4gVGhlIGJhc2UgZmlsZSB0aGF0IHdl
IHN0YXJ0ZWQgd2l0aCBnZXRzIG11bWJsZS1tdW1ibGUgcGVyY2VudA0Kb2YgdGhlIHRyYW5zaXN0
b3JzIGNoZWNrZWQuIEFkZGluZyBhIGZldyBtb3JlIGZpbGVzIHdpbGwgaW5jcmVhc2UgdGhhdA0K
cXVpdGUgc2lnbmlmaWNhbnRseS4NCg0KU28gdGVzdGluZyBhIHN5c3RlbSBtYXkgbG9vayBsaWtl
Og0KDQoJZm9yIGVhY2ggc2NhbiBmaWxlDQoJZG8NCgkJbG9hZCB0aGUgc2NhbiBmaWxlDQoJCWZv
ciBlYWNoIGNvcmUNCgkJZG8NCgkJCXRlc3QgdGhlIGNvcmUgd2l0aCB0aGlzIHNldCBvZiB0ZXN0
cw0KCQlkb25lDQoJZG9uZQ0KDQpPdXIgaW50ZXJuYWwgZGlzY3Vzc2lvbnMgb24gbmFtaW5nIGFy
ZSBmb2xsb3dpbmcgdGhlIHNhbWUgZGlyZWN0aW9uIHRoYXQNCnlvdSBzdWdnZXN0ZWQsIGJ1dCBs
aWtlbHkgZXZlbiBtb3JlIHJlc3RyaWN0aXZlLiBUaGUgInN1ZmZpeCIgbWF5IGp1c3QgYmUNCmEg
dHdvLWRpZ2l0IGhleCBudW1iZXIgKGFsbG93aW5nIGZvciB1cCB0byAyNTYgZmlsZXMgLi4uIHRo
b3VnaCBmb3IgU2FwcGhpcmUNClJhcGlkcyB3ZSBhcmUgbG9va2luZyBhdCBqdXN0IDYpLg0KDQpT
byBvdXIgY3VycmVudCBkaXJlY3Rpb24gaXMgdG8gbmFtZSBzaXggInBhcnRzIiBzb21ldGhpbmcg
bGlrZSB0aGlzOg0KDQoJMDYtOGYtMDYtMDAuc2Nhbg0KCTA2LThmLTA2LTAxLnNjYW4NCgkwNi04
Zi0wNi0wMi5zY2FuDQoJMDYtOGYtMDYtMDMuc2Nhbg0KCTA2LThmLTA2LTA0LnNjYW4NCgkwNi04
Zi0wNi0wNS5zY2FuDQoNCmJ1dCB3ZSBhcmUgc3RpbGwgY2hlY2tpbmcgdG8gbWFrZSBzdXJlIHRo
aXMgd2lsbCB3b3JrIGZvciBmdXR1cmUgQ1BVcy4gT25jZQ0Kd2UgaGF2ZSBzb21ldGhpbmcgc29s
aWQgd2Ugd2lsbCBjb21lIGJhY2sgdG8gdGhlIG1haWxpbmcgbGlzdC4NCg0KQXMgYWxzbyBzdWdn
ZXN0ZWQgaW4gZWFybGllciB0aHJlYWQgd2Ugd2lsbCBjaGFuZ2UgdGhlIG5hbWUgb2YgdGhlICJy
ZWxvYWQiDQpmaWxlIChzaW5jZSBza2lwcGluZyB0byBhIG5ldyBmaWxlIGlzbid0IGEgInJlbG9h
ZCIpLiBUaGUgImxvYWQgYSBzY2FuIGZpbGUiIHdpbGwNCndyaXRlIHRoZSAicGFydCIgbnVtYmVy
IHRvIHRoaXMgbmV3IGZpbGUuDQoNCi1Ub255DQoNCg0KDQo=
