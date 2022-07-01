Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 574D6562D0F
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jul 2022 09:54:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235076AbiGAHyE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Jul 2022 03:54:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229808AbiGAHyD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jul 2022 03:54:03 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F79C6D545
        for <linux-kernel@vger.kernel.org>; Fri,  1 Jul 2022 00:54:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656662042; x=1688198042;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=AtYoI350RsCg7NrwkGRN+vOVAcwaYZgJXfXKUwZIZgI=;
  b=hCOdPNTp/FWt+ecMeGFp4HxOLZsd76BnbpJI1jd//A6KWCbz50EUh0Az
   6FJLeMuQaf5MH/cGlPC3Vw0WXBWVPZqidfP5tSymCB4NELNkVCosPZWTh
   uvqNUu9AOWVDN/I0pBjTlRAm4tF1XoUuMU237M/kaC6mwiEckMxZZQxis
   wYYOkkdvUAvHLeYDpKhXhJET9t+pzBwI40wuqD6C0V/dv0Skrn3Jmtx3j
   GrYqoBTM35axYMkVtZY4YITPgR7qr453ZDAG37VFC6MopuFlLMTAgwi7b
   Hk+Jvgpq7dzpKzdSIv7YY+echzbBAXITiO/QwWWm6s93PYltc/UTFm545
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10394"; a="283682250"
X-IronPort-AV: E=Sophos;i="5.92,236,1650956400"; 
   d="scan'208";a="283682250"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2022 00:54:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,236,1650956400"; 
   d="scan'208";a="566200909"
Received: from orsmsx604.amr.corp.intel.com ([10.22.229.17])
  by orsmga006.jf.intel.com with ESMTP; 01 Jul 2022 00:54:01 -0700
Received: from orsmsx608.amr.corp.intel.com (10.22.229.21) by
 ORSMSX604.amr.corp.intel.com (10.22.229.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Fri, 1 Jul 2022 00:54:01 -0700
Received: from orsmsx607.amr.corp.intel.com (10.22.229.20) by
 ORSMSX608.amr.corp.intel.com (10.22.229.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Fri, 1 Jul 2022 00:54:00 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx607.amr.corp.intel.com (10.22.229.20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Fri, 1 Jul 2022 00:54:00 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.47) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Fri, 1 Jul 2022 00:54:00 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kScdWM0+HAlFzwR+ZrmtV2dmOyi4+DtdcEQ+nJALY/0CIBlleIrKYlJm1lkzrB71eUJx+ywXLn5jIsUNg8auzD5VAYuLW7IVNYrOYScUCMRzzKYbcXM9hz9pqri7uVsOTavALtFUa8mef1zNLpDV9UtNQUCTdgzYIPM4S8fbTsNBIhtrEFEWuRk0FyG2ePcSZpXeVQzoRGS4urdOOCNtjDcvLFrXnUyuw0DNc3jYi1QMKkaOJh7DydXNa8+LL2Ab6WDLxtkg5rzfNwbc485sIoS6OIrHgeUsVE5NH17qnRNFD0Af/qrMf9HM/NANPy277lHjXryb1Hi1F9gVrgmM2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AtYoI350RsCg7NrwkGRN+vOVAcwaYZgJXfXKUwZIZgI=;
 b=QZzZYMOBtrgb6bx9oj21qxtxJjSS0Y9HPSmt/mb7vQWsf/pGvElGFUPWPUxOi6uhqMbwoTuONmG6EjM7t7wxdFemuA0p+hoA/R5Bp2eeTOx0o8e8wHhyFpPbQcVUSlVmAfpT5BdZCkanPcIrsS1g8N0F7IV282LKSr0LTT3kUHRIcjzB5K439pcd/B/c93x497Dv2runecW8nNWlRWBKbGhQUSkyQuCLwWC/YjY/ubcyqAn509gsIkoETeiQ9lorWBYAIbWdf1cKpltFPUdD4KlLvApnW8sDrs/mNQHzbY+gQ3Iftj+BJH0SqS3jX+t7WA12yJ40tcG5Z/OXpZG/Vw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by MN2PR11MB3822.namprd11.prod.outlook.com (2603:10b6:208:f8::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.15; Fri, 1 Jul
 2022 07:53:53 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::8435:5a99:1e28:b38c]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::8435:5a99:1e28:b38c%2]) with mapi id 15.20.5395.015; Fri, 1 Jul 2022
 07:53:53 +0000
From:   "Tian, Kevin" <kevin.tian@intel.com>
To:     Lu Baolu <baolu.lu@linux.intel.com>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>
CC:     "Raj, Ashok" <ashok.raj@intel.com>,
        "Liu, Yi L" <yi.l.liu@intel.com>,
        "Pan, Jacob jun" <jacob.jun.pan@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v3 00/11] iommu/vt-d: Optimize the use of locks
Thread-Topic: [PATCH v3 00/11] iommu/vt-d: Optimize the use of locks
Thread-Index: AQHYi40cu513zMJJU0+5gNk/q82XNa1pJ19w
Date:   Fri, 1 Jul 2022 07:53:53 +0000
Message-ID: <BN9PR11MB527645CF20DA53BF9009A9118CBD9@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20220629074725.2331441-1-baolu.lu@linux.intel.com>
In-Reply-To: <20220629074725.2331441-1-baolu.lu@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0150c070-b81c-4242-6900-08da5b36d7d3
x-ms-traffictypediagnostic: MN2PR11MB3822:EE_
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: aYRuWFn6dwnOyLvz9BAXkS91XsH23yAIGwdhfLV8JOVQTBr1LMGRkcOxmfPZyER9dettcwR8PICgrDwFUT18e3ow42iLYev0nS7rHSgZTQ8mE2221b4fy2IFJNBTKWgzLnRXloNJoA+ZFSEB3f9hTbU31jiM5LptJpLXOlHggnmyhRwoj4mfPO1gbwtqc529MCx3uDuwPmus5q7PBSFOB5WZEGZA0TDO2CiH6dcct9tU7FNU3+Fo7MeLTJkU9n6A3GgRD82N/570wV7cMBoU+qqmHLkFx06QqjMR0SCqyfXK0wl53egPE1QUqrlWpYxjRWV6fb8s/yE+uIwBP4NA5aG7o8H3qRQ8VNKAjeSVv1/H6/EXf4m6x16zfjCUK4RUq3PdwZC9fEku9EoisyQLvUmjM3Pe/vWDEHWEnzWEVC95+TOQaN6bVJqDTYxHYcBjcxtEH4LROkcCFB/iut0Qendto7s8AjV5W5bLBC23eyrLUxkBAgjaKyM85cpZHaNte0CoEW1ZaCs/NB+tpfCbyQhhu8zavYdh/Ndx3gwPLILOUxZTS+8fWRPlxN701ofqf1VhBPp2hFc5gGtOPeb+Itt4B7JA7VxzMb7snucnJUKZKBhOmzRrwhok6mQj2EGVG1fchbIK7Aey8Hj4J0JpQHW+JhMlPVk0Wrf9R7Nw1e8nypJnXFmJsWFEK+gUxkR7uVBVYDeu9tk2EEqNUz3YKxvi+Kw2v9pXT4MauhgVkv6LgwpG7z4tdYtn69BchMkzbrRjFSdOCg1YTlF43taErBBhUyWcDEzvedtm1j4pZyiS2R7mfRatEl6Smon+PjqiB6EyYV4enJO8CboNGwwS44n5JaN+nUrBOcIdQ8Fzfh8=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(136003)(376002)(396003)(366004)(346002)(39860400002)(26005)(55016003)(6506007)(4744005)(9686003)(7696005)(83380400001)(66946007)(4326008)(8936002)(64756008)(66556008)(66446008)(66476007)(8676002)(5660300002)(2906002)(186003)(52536014)(478600001)(38070700005)(45080400002)(966005)(38100700002)(316002)(76116006)(54906003)(110136005)(33656002)(122000001)(82960400001)(71200400001)(41300700001)(86362001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MTRJSS9ucDd3WS9UYTdxWnJNYnpXQXVERElOVDBxR0ZHekJ4WTZUKzQ0cTY0?=
 =?utf-8?B?MG1qSElTeXEzKzZHVEx0dGNyNnQ5dVhqQjJ4S2J4eXZYWC9OQmdoc05TOUY4?=
 =?utf-8?B?S05ka0t6U0MzQ0dFeU1RMmxycXRONzN0cXZOczk4M0NwOEI1SFN3RGRubEVE?=
 =?utf-8?B?ZUR3RmZqSFdpTnBKaXhHNi9WWGRRVkUyV1RiSTVzSUkvRVRMMmV1a3BiNGdI?=
 =?utf-8?B?S0lHV0dYbkpZK0pNbUtWaFBvZWYydTBXK0w0WVpQYmtrUk82REZ6Z3ZzVnlh?=
 =?utf-8?B?Ui9VMWkzUmlzcVdwNWJITjUxVWpKMTdHd3pDY0FnS2tCY29ZR3gxL2ZlT2V5?=
 =?utf-8?B?RllSOGZFM3I0QndVTlRPcHVZOUIyckdFQmdSRm54RWtIYjFrVXRNVFUvMDAw?=
 =?utf-8?B?S2ppRGtieGowbHFqNDRRcUlEQXEzRFVFSEV1Zms3Snd0M3dqcUUzcnJ4eWtW?=
 =?utf-8?B?ZGpKazVUM2NqeGxIVmdtb096Yll6ZFRnbVN0U2JlNWRMd3Nkb3RNaENrcnNT?=
 =?utf-8?B?b1NCbG0va1Y1Qkkra0lJTGhrWFpaTUp4SFBUZ2NleVhoY0lTMnF3ZGVQMG5l?=
 =?utf-8?B?ejEvWnU0REJRcHdmRkxmdU1DL2F5VUkyL0wyQzM5eHYya1BGdklRemNqWXQ0?=
 =?utf-8?B?OHJBcWV6d1ZnUU9vQWF6VGpVY0o0UUZzdG9ld3JkRHZTTEcwLzRuSmNLYU9D?=
 =?utf-8?B?czBwMUErbDBsVFFhdlIrZEhrMkdtdW1rVnFlRXBqU0Q2VGQ4TXlMTFBOK1ps?=
 =?utf-8?B?eWhvSlpoTEhWa0kzR2diMXJhQytMNnZZNjM0WU90VHBndkV0NVNITE1LamJE?=
 =?utf-8?B?U2JMRndSc01uUnV1T282SlR0OGwvcjBzWUFwTmtmU2d0UHZEQVZISEF3bkk1?=
 =?utf-8?B?cXZ6clhJRzV4TDAyd1hWZkRFdTJSK0o4SXVvMi9mM2tudTYveHFPcDRqdVZx?=
 =?utf-8?B?RkhtS2VoZm5wZ0tQU0xTZ2RudUVFODUwYmpySlFmRW9SWit2N0tNY3NMaFlR?=
 =?utf-8?B?aXpXQTZGZFBCdi95Y3JhbnhTeVUxRzk5WEZueURMTWg1dkhUa1A3T2lHeTA0?=
 =?utf-8?B?SmVFaUpIWnFoZXk2aCtPZThVaXl2WERZVTlXK0hVOEQ3NVhqa0NwRkZzNmN4?=
 =?utf-8?B?Q1dqYTA3MkxnRk8xc0o4amRGUkh6SVUrUkRlU2oxUndGZXRTTlpad1FUK2o2?=
 =?utf-8?B?SzlzUFB4ZVJUMjFEYWFSRGY1cnY4ZjFFd3pRYzl0ZHpialAxeFZ1dGdIQk9P?=
 =?utf-8?B?YWMvWU56REJackF0YzNJQnduakpUQ1VidzQyTTlLNVh0SWhWa0oxOHRzL1Zt?=
 =?utf-8?B?MnM2UDNtUnpVa1pDdzFVVlB2ZjJZWFp1MFZWZG1GRlJLbkpiTUVEaSs4NDVa?=
 =?utf-8?B?NXhEZTBmQmFwZkg0ZGNZa2E0UnR6bzM4VGRQWlhQNWpwelJwaVVzUVBNb3h1?=
 =?utf-8?B?b0pZajVvZW50SjhIeGVKVHFQaG54SmpRZmIzd1NYUTMyOUVGMU55TkU5aEtt?=
 =?utf-8?B?TTNpdUhwaGx5a1JtbzNPeWZORWRtbEJ6REVRNnQwNUs5N1orcjhwTzc2MjhZ?=
 =?utf-8?B?UzJJOTE1Y3BXMDg0cmlMWnlLWDNMelJndEEzN1p5US9hMGF5TDE5NVRscmRl?=
 =?utf-8?B?TXpDSFNvSGpaRDZaS3hJR1NyK1BLMnRJWjVhT29tS29DcVQwVmF6SnJ0Vms0?=
 =?utf-8?B?aVpYTTJjQWRUM0IxQVRTNnpQR2N1Y0w1ZFlYVUpRaDM1TVI1TU1lNG51eGR4?=
 =?utf-8?B?VjJidFVLTy9YRFdDYmhvRUZDcWZVOVVSWXdKQ1pOTW1FVVgzMW9wOU9Eb2dH?=
 =?utf-8?B?S2FlWnQrcm5oYXlENVVTd094WG1LUGdoeVArTlNsR2czWkt0d0I3d3lpdThO?=
 =?utf-8?B?bWlxa2QwYnVXSEhnbWd0U3VHcW8zdS9nNk4vb2ZVVG1RSENoRE5CT1ovWjYv?=
 =?utf-8?B?eFltOU9abU5VVW9ucFZYSm1Wb3JRRWlFRzdFV0FnelRuVlcwOUZHZjJrNGVy?=
 =?utf-8?B?VldySU9oSjJjVnMzRE93RVNlVmxwRS81enJycFFleTl0ZFBxSmt1c2I3elhs?=
 =?utf-8?B?QmpIbW9FWTJZMng5dWozWUxxcnRuSXkvdVhETDliZ3VveTRyaUw3RTc3bmlO?=
 =?utf-8?Q?+s83ial4vJwkWQqwpf3otCfPf?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0150c070-b81c-4242-6900-08da5b36d7d3
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Jul 2022 07:53:53.3508
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: y2cBw9iIPawIUeyG4SeyXSftzOAe/sE9uPt2SY8VVGDllZ2A27PUZ4zpQILX938V6z7+yfSb79VXIIXeEC24TQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB3822
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBGcm9tOiBMdSBCYW9sdSA8YmFvbHUubHVAbGludXguaW50ZWwuY29tPg0KPiBTZW50OiBXZWRu
ZXNkYXksIEp1bmUgMjksIDIwMjIgMzo0NyBQTQ0KPiANCj4gdjM6DQo+ICAtIFNwbGl0IHJlZHVj
dGlvbiBvZiBsb2NrIHJhbmdlcyBmcm9tIGNoYW5naW5nIGlycXNhdmUuDQo+ICAgIGh0dHBzOi8v
bG9yZS5rZXJuZWwub3JnL2xpbnV4LQ0KPiBpb21tdS9CTjlQUjExTUI1Mjc2MEEzRDdDNkJGMUFG
OUM5RDM0NjU4Q0FBOUBCTjlQUjExTUI1Mjc2Lg0KPiBuYW1wcmQxMS5wcm9kLm91dGxvb2suY29t
Lw0KPiAgLSBGdWxseSBpbml0aWFsaXplIHRoZSBkZXZfaW5mbyBiZWZvcmUgYWRkaW5nIGl0IHRv
IHRoZSBsaXN0Lg0KPiAgICBodHRwczovL2xvcmUua2VybmVsLm9yZy9saW51eC0NCj4gaW9tbXUv
Qk45UFIxMU1CNTI3NjREN0NEODY0NDhDNUU0RUI0NjY2OENBQTlAQk45UFIxMU1CNTI3Ni4NCj4g
bmFtcHJkMTEucHJvZC5vdXRsb29rLmNvbS8NCj4gIC0gVmFyaW91cyBjb2RlIGFuZCBjb21tZW50
cyByZWZpbmVtZW50Lg0KPiANCg0KVGhpcyBkb2Vzbid0IHNheSB3aHkgb3JpZ2luYWwgcGF0Y2gy
IHdhcyByZW1vdmVkOg0KDQoJImlvbW11L3Z0LWQ6IFJlbW92ZSBmb3JfZWFjaF9kZXZpY2VfZG9t
YWluKCkiDQoNCkl0IHRvb2sgbWUgYSB3aGlsZSB0byByZWFsaXplIHRoYXQgaXQncyBhbHJlYWR5
IGNvdmVyZWQgYnkgeW91ciBhbm90aGVyDQpwYXRjaCBmaXhpbmcgUklEMlBBU0lELiDwn5iKDQo=
