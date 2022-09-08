Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6566F5B11A7
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 02:54:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230313AbiIHAyJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 20:54:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230128AbiIHAyD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 20:54:03 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCA622ED41
        for <linux-kernel@vger.kernel.org>; Wed,  7 Sep 2022 17:54:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662598441; x=1694134441;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=aSv2pGogHFCS0U4i7MCbnmVVbNg3lCqV7sn6cB40JKU=;
  b=AezUJdp5y8p4o+2VVPEFm3yYUffyPQiMS90LFJXFgS+bSrTzJZigfyih
   DmNa5fTxiOPaqpK61pGHaf7QTgRhndnUS1hyAB76veS+FCwr/M5V8g0nO
   +MHkPAQnUGs5SCnePJMl8MWG8D+NDmjOz3lSluBB2727Uw2GksEnQKdy+
   c3Y71l6FPLtLJFguaet+LwCRe7WBv/vFs71ulBTu89StrgB8sHiyGZqRq
   ker6RP12/9cMLkal6mzijztpydlivHDDi7tUXIJFGTC1wxAX8LHfKsbg9
   A0D2OP7ebQvfnhfX8INpaR7TcboobsIAAIqGrmf2UWlbdabAiNQuRktBv
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10463"; a="276769648"
X-IronPort-AV: E=Sophos;i="5.93,298,1654585200"; 
   d="scan'208";a="276769648"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Sep 2022 17:54:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,298,1654585200"; 
   d="scan'208";a="943125544"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga005.fm.intel.com with ESMTP; 07 Sep 2022 17:54:01 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 7 Sep 2022 17:54:00 -0700
Received: from orsmsx607.amr.corp.intel.com (10.22.229.20) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 7 Sep 2022 17:54:00 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx607.amr.corp.intel.com (10.22.229.20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Wed, 7 Sep 2022 17:54:00 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.42) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Wed, 7 Sep 2022 17:54:00 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B/7LC49/i9GapuHJ5mJoO7Mlol9t6eZf1Em85ncfA950/CfAhLpUH/rYdo6gyc1/XE6Pe+UNFm+t6IFBVqH05GuX50IzK2UfC7PL6OINCg8vXxR4fMBdisUIIB0HwfzeE/7K0f1FW3amtocikAFJ3gQBUvThdxlysYLEQUBzJoyo46pQt7vceKwiCM4JP6jY9UjKFnOFUxeBYDWQG4s2SxQmxicgDgGBOi8me/QKNJBpPhc+4OBs3DC9rmyuhzeKysKi99mr3kuV3x3u7mLezPUzNkHrXC58Vr/ir1dUcVO2On/y6GBmYi/hRyrV5yeoQU5DkVMCMOi0MXAhtf7tWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aSv2pGogHFCS0U4i7MCbnmVVbNg3lCqV7sn6cB40JKU=;
 b=Jbfst7B+yqzeUE64Wl9wemFYMjLp8d5uy90Ubx/FXYjMni1nt3s1Rp5kWuBVz5GcExK2T5iGP8BPF3erFe1RwKRSJRHlThL+Ulwmj9ukj9k8y5G+Ub0p+cOkESqv5fXVtPpDUKU0C8G0PW70Di992zMyM3VkazJIKatRQAhLf+GNwlZxlcYy3JGotuRkiBy6XhQl/xvVC+hO83Q7H7Okp4LFH4dW1WW42GtIeEZevXk+i9yEFIvbZyVKNm4fgjdwZULb23L5FRuXqCQSwLuisHXcUp3+G8WhYAH0CuAjT1CG4CWBd12+D12ivBxGwI7b3hatS3a3yTCPiaF9Z8pTaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM8PR11MB5751.namprd11.prod.outlook.com (2603:10b6:8:12::16) by
 MN2PR11MB4367.namprd11.prod.outlook.com (2603:10b6:208:18b::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.10; Thu, 8 Sep
 2022 00:53:55 +0000
Received: from DM8PR11MB5751.namprd11.prod.outlook.com
 ([fe80::6f3a:c6aa:731c:d1fd]) by DM8PR11MB5751.namprd11.prod.outlook.com
 ([fe80::6f3a:c6aa:731c:d1fd%5]) with mapi id 15.20.5612.014; Thu, 8 Sep 2022
 00:53:54 +0000
From:   "Teres Alexis, Alan Previn" <alan.previn.teres.alexis@intel.com>
To:     "daniel@ffwll.ch" <daniel@ffwll.ch>,
        "Winkler, Tomas" <tomas.winkler@intel.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "airlied@linux.ie" <airlied@linux.ie>
CC:     "Vivi, Rodrigo" <rodrigo.vivi@intel.com>,
        "Lubart, Vitaly" <vitaly.lubart@intel.com>,
        "Usyskin, Alexander" <alexander.usyskin@intel.com>,
        "joonas.lahtinen@linux.intel.com" <joonas.lahtinen@linux.intel.com>,
        "intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "tvrtko.ursulin@linux.intel.com" <tvrtko.ursulin@linux.intel.com>,
        "Auld, Matthew" <matthew.auld@intel.com>,
        "Ceraolo Spurio, Daniele" <daniele.ceraolospurio@intel.com>,
        "jani.nikula@linux.intel.com" <jani.nikula@linux.intel.com>
Subject: Re: [PATCH v9 15/16] drm/i915/gsc: allocate extended operational
 memory in LMEM
Thread-Topic: [PATCH v9 15/16] drm/i915/gsc: allocate extended operational
 memory in LMEM
Thread-Index: AQHYwwQj2KiDrOlGrEKrXrwWMx9+iK3UtVcA
Date:   Thu, 8 Sep 2022 00:53:54 +0000
Message-ID: <2c67897f9c4523caefdb8a2358cd38ebf2eb90d3.camel@intel.com>
References: <20220907215113.1596567-1-tomas.winkler@intel.com>
         <20220907215113.1596567-16-tomas.winkler@intel.com>
In-Reply-To: <20220907215113.1596567-16-tomas.winkler@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.36.5-0ubuntu1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR11MB5751:EE_|MN2PR11MB4367:EE_
x-ms-office365-filtering-correlation-id: 9d656e7b-d840-4fb0-ec85-08da91349ad0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: yNUwLyI9hvvMkoSCkeEs+6sNoTFvOTP3hTEj3/uVVVuFnQPxvxQyiw00nqxUVab5x19vqb6fYMe7409Cn0dqM1VrxXwlrghJxLBaxYKgQr+fqIK1zs8hLiK4GdZuBLN/hEweMNgQT4ppww6I1XcHUREJjxdFTXMn2eFYeQD7LOkTGpWhKckIye9emiINayqsgxDqJ0SeG602AJRDI0MjebR6AfIiO0fhXTSgK6fVRvBlN8VoJjjLI6O6ZavzTs750JCXafBwvUB4gzStaGv4H9iFN7Y8Ntthz8wqiEYGSIi2CCEG4FbHKXgGSdKvD9o6BxY4abVQOZBPTIT60JKlExOiGkcsORE8M3n8r92IGmtI0LCVTpdIFsVFjPR9cGu25Ub4xDaWramqYGrOLoTlPTV0k/ihuHamJrAiC1CDaU2tCa1sr6TnVyArg3E6IumJpd0FZrq7lAw3/VHTrBn9uFYwOaf71brwyC3AULuD3lQFNfGGy0jx5c+Vkian4b790NfZlxU503+l3N6xP62yhCAukWOJkHaIx2XAlLZ6S1RQiY7kBPTD1655VeWU6eMiwTKfRr90GeHC5h1x8nS0SmBgSsIaBYBqkQBOPx93Rc2Nq856zMaSqS+/kRKLJmX5cDmmCx7buDqjfVtDkcpPN5OjJR27RDqGqOaTQSOBCkFbZh0pcknyZwY2wTxu6LLPBAqfCpM3fqSeF7OZ+2R1uEYOn8JskHxa77HZayH22860F1fPF1KcYnPjaZ8ALisPqsEkrjN0WjJ0UpgKhw3ENg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR11MB5751.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(346002)(376002)(136003)(39860400002)(396003)(366004)(91956017)(86362001)(6512007)(6506007)(122000001)(26005)(8936002)(76116006)(4326008)(66476007)(5660300002)(36756003)(64756008)(66946007)(38100700002)(66446008)(66556008)(2906002)(316002)(71200400001)(8676002)(41300700001)(54906003)(186003)(6486002)(110136005)(83380400001)(82960400001)(2616005)(38070700005)(478600001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?STkzK09rNmFscWhWRys4aW5vRjMvSXFZUDlNUnE1SGorTjIwK0E3eWkzN0dJ?=
 =?utf-8?B?bnVBb0ZXS3ZIZld2NE0zVFVFeUlCaEJIcjlJQzBZa3o1M2VZQm12d2ZJMjNC?=
 =?utf-8?B?dHZybVVNc3dqQVdjS0xYQmxmeHZLNDVwV3FvbldscTFrSUg5aEh5Y2N2cXBV?=
 =?utf-8?B?SkIxditZd1N5WWxaUTFzSy9RbzlHUWxlYXhmZEJhcjNpV0dEKzBOL0xub3F5?=
 =?utf-8?B?SS82NUNDaEdyekpxVVpNRkFTMmxCSGRYd1dSbk9YYWJjRjUxb1BWRmhxcktQ?=
 =?utf-8?B?a3g5bkxzb01BRS9Tb3hWQTB5c3dSd0JubVlRUlRlUHhsblRpYnVQS2t0N3Y4?=
 =?utf-8?B?N2Q1ZGhTdWRvT3R4NldCVlo5UUpkSENsR3pqOVVLM3NNYm9iRVVwV3Y4ejIx?=
 =?utf-8?B?V0F5enhYcnhUUkFzTnVSWC9USU9iZndreWM4eW84UUM5T2x2eUxFUVdWSGl2?=
 =?utf-8?B?eTR6SWdGaWh2WHVJYzlKN2FZcDdsY2JQbXRXbFRRT1ltWlVHVnpvc0wrWnVi?=
 =?utf-8?B?RXZYYWpmSU1mdlhCTjg2RnRZKytmWWd0QmtIcmF3Y1VRQjVLZVhpdnRLZzQ0?=
 =?utf-8?B?VEVla0lSSEhxSWtIVEdabktaczdjZTBjemFOeDNxblByV2t6ejhaMWd2L2FL?=
 =?utf-8?B?WUFFY1RpQ3RobG03MzlSSk9IYTlPMXpDdnRGLzdRN25vLzVNT0JnelE2OEpK?=
 =?utf-8?B?WHBtaVU0L09kVVFBdWd0MHZXSnRDS1k1ZXlwWVlKZ25EZWZ5TDFOcnkwdUVq?=
 =?utf-8?B?eGljcEdReFRNRFpnVGk2ZXJNY1dId1d6MlRVOWpxKzdFYmxsblNUcjJYOUhU?=
 =?utf-8?B?cW1hd2VDSjlCTUUvcXVEUldxbWQyRmF0UDNJZ0doUW9PV0VPcXM1ZlEvTDFZ?=
 =?utf-8?B?ejVTMGJtSmJkQmt3Tlg5VnFlZjdWTDJkNVFyQVFMSCtPUXBkODBHZXh4eXVK?=
 =?utf-8?B?V3RES1RBeTRqQXZnVmpVdjNBQytqWXJ6N05Cb3ZxalVYL2liclRaamUra2Z6?=
 =?utf-8?B?VFFBQmNzNXNpUk9HLzg3NDlIK2pDMXJKY0QxczJOSk81OXhXbUhLeXFEY2FU?=
 =?utf-8?B?Z3l2Q0hXUTFGTHNMTG9HV3UrelpxMjJOM1RRLy9hbU5RVlJHM1pranU4Yzg1?=
 =?utf-8?B?MndBMVh5Q3ZBcmtWcTdrUk44eSt1eFFreG5LSC9wL0o5c1lGbzV6Umx0OGhm?=
 =?utf-8?B?aHJ3YzBUeVpnWkcza3JsZmFGVUpldVJJS01OMDhneFJIZDd3OW8ybDIzVkZE?=
 =?utf-8?B?Y2pJN0xlb21LbGIxUExtaGtQMFBha1NkdUNGWnNXb0FTaUdGZ3UxOXJtc2Yx?=
 =?utf-8?B?bGZNYitONlUzYjZqMGovZjQ0VWV6TTJCQ0xIemIvTmtnanhjL3NseEVIZDVh?=
 =?utf-8?B?ZE82NWxkSEtVTmh3cHNpeU1QR3N6akxhQlpIbGoybTZ0QzdVM29YMlJMSVgr?=
 =?utf-8?B?T0ZYQkdWUmJtdkUrY2ZSaGVRM3lQK3NrdUI4WWo4OWZKRTlBcEJNS0VHd212?=
 =?utf-8?B?VGZBa0J4eTczdGU1YzA5d0dLSEhaaFVoTzBxWWlVbURvZlZMaWVHMnRSeWl3?=
 =?utf-8?B?WFpFK01uSnQ3d0VORkpWWnNFOFJnb0g2RXRZUEVmZjRQRmozNHlOTXdTa1R6?=
 =?utf-8?B?WWZSalJsdGxkY2t2c0RuQkRibUJRZ1psa2tnV3JXOEZicktteUEwVEpPckdk?=
 =?utf-8?B?cENWc0FhMTdtV3lQdTFLVE9OQ243K3VteFBjTGtHazlReXpxaUNnSmM3Qmcx?=
 =?utf-8?B?L3VvWTlzMlgxRkZ5UVZlSVFxanhodkNzMG53MFFqV1FMNUhJdmpIeW1qeG9l?=
 =?utf-8?B?WWhPeWlRbjR3em85Znc2N2tZOVp1d3FQdGNmMy9OcHc0YVNpK3hmL1czWk1M?=
 =?utf-8?B?THBLcEo3M0RpcXR3dVhrWjBiM0lNSHlFa2JzejMyUXNWZk1LcEZ1UTMrbHZC?=
 =?utf-8?B?L1dUYlFFK1ZseFVWL2FpekZMcXA1Wi9qcUNtWkttcjFJMmpvdnBISDlrMFNJ?=
 =?utf-8?B?VzMrQkdsL2R1YS9uL21FNUg3QldEWFVlU2luQk5YN215OS9rRi9SSmpUVGQ1?=
 =?utf-8?B?RWlMVDlKaVJBbFdpQXpCM0JNNmx6WUpncDBac0xkREl4R2MxUzRVNjhqdHVB?=
 =?utf-8?B?aEM5Z1dQclRVYnlGcHNiYlM1dVdyZVd3TTlkZWh5czBUejFERXFoaFZJWXVt?=
 =?utf-8?Q?j4nj+k+bnwsRxy7t7DVkJec=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <2CD613272CF6A04AB5A9B68300E028EE@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR11MB5751.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d656e7b-d840-4fb0-ec85-08da91349ad0
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Sep 2022 00:53:54.7572
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ASZv9MdYgpa0ji1jFf1YcEgNri/yrO7EDVWS1PFzDNmJfD8CGO081pehlSG5IXZwEXrT4kGac8WoKClNOPIR8tVGAumWQxxKlA+zygu0u5B6mpDzOTCchh2jvCo5Opo6
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4367
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SSBoYWQgcHJvdmlkZWQgcmIgb24gdmVycyA3IGFuZCBpIHNlZSB0aGUgb25seSBkaWZmZXJlbmNl
IGhlcmUgaW4gdjkgaXMgdGhlIHVzYWdlIG9mIEk5MTVfQk9fQUxMT0NfQ1BVX0NMRUFSIGluDQpn
c2NfZXh0X29tX2FsbG9jIHNhdmluZyB1cyBhIGZldyBsaW5lcyBmb3IgZnJlZS4gVGh1czoNCg0K
UmV2aWV3ZWQtYnk6IEFsYW4gUHJldmluIDxhbGFuLnByZXZpbi50ZXJlcy5hbGV4aXNAaW50ZWwu
Y29tPg0KDQoNCg0KT24gVGh1LCAyMDIyLTA5LTA4IGF0IDAwOjUxICswMzAwLCBXaW5rbGVyLCBU
b21hcyB3cm90ZToNCj4gR1NDIHJlcXVpcmVzIG1vcmUgb3BlcmF0aW9uYWwgbWVtb3J5IHRoYW4g
YXZhaWxhYmxlIG9uIGNoaXAuDQo+IFJlc2VydmUgNE0gb2YgTE1FTSBmb3IgR1NDIG9wZXJhdGlv
bi4gVGhlIG1lbW9yeSBpcyBwcm92aWRlZCB0byB0aGUNCj4gR1NDIGFzIHN0cnVjdCByZXNvdXJj
ZSB0byB0aGUgYXV4aWxpYXJ5IGRhdGEgb2YgdGhlIGNoaWxkIGRldmljZS4NCj4gDQo+IENjOiBB
bGFuIFByZXZpbiA8YWxhbi5wcmV2aW4udGVyZXMuYWxleGlzQGludGVsLmNvbT4NCj4gQ2M6IE1h
dHRoZXcgQXVsZCA8bWF0dGhldy5hdWxkQGludGVsLmNvbT4NCj4gU2lnbmVkLW9mZi1ieTogVG9t
YXMgV2lua2xlciA8dG9tYXMud2lua2xlckBpbnRlbC5jb20+DQo+IFNpZ25lZC1vZmYtYnk6IEFs
ZXhhbmRlciBVc3lza2luIDxhbGV4YW5kZXIudXN5c2tpbkBpbnRlbC5jb20+DQo+IFNpZ25lZC1v
ZmYtYnk6IERhbmllbGUgQ2VyYW9sbyBTcHVyaW8gPGRhbmllbGUuY2VyYW9sb3NwdXJpb0BpbnRl
bC5jb20+DQo+IC0tLQ0KPiBWOTogVXNlIEk5MTVfQk9fQUxMT0NfQ1BVX0NMRUFSIHRvIGNsZWFy
IHRoZSBhbGxvY2F0ZWQgbWVtb3J5DQo+ICAgICBpbnN0ZWFkIG9mIGRvaW5nIGEgbWFudWFsIG1l
bXNldCAoTWF0dCkNCj4gDQo+ICBkcml2ZXJzL2dwdS9kcm0vaTkxNS9ndC9pbnRlbF9nc2MuYyB8
IDc5ICsrKysrKysrKysrKysrKysrKysrKysrKysrLS0tDQo+ICBkcml2ZXJzL2dwdS9kcm0vaTkx
NS9ndC9pbnRlbF9nc2MuaCB8ICAzICsrDQo+ICAyIGZpbGVzIGNoYW5nZWQsIDc1IGluc2VydGlv
bnMoKyksIDcgZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJt
L2k5MTUvZ3QvaW50ZWxfZ3NjLmMgYi9kcml2ZXJzL2dwdS9kcm0vaTkxNS9ndC9pbnRlbF9nc2Mu
Yw0KPiBpbmRleCBlMTA0MGM4ZjJmZDMuLjdhZjZkYjMxOTRkZCAxMDA2NDQNCj4gLS0tIGEvZHJp
dmVycy9ncHUvZHJtL2k5MTUvZ3QvaW50ZWxfZ3NjLmMNCj4gKysrIGIvZHJpdmVycy9ncHUvZHJt
L2k5MTUvZ3QvaW50ZWxfZ3NjLmMNCj4gQEAgLTcsNiArNyw3IEBADQo+ICAjaW5jbHVkZSA8bGlu
dXgvbWVpX2F1eC5oPg0KPiAgI2luY2x1ZGUgImk5MTVfZHJ2LmgiDQo+ICAjaW5jbHVkZSAiaTkx
NV9yZWcuaCINCj4gKyNpbmNsdWRlICJnZW0vaTkxNV9nZW1fcmVnaW9uLmgiDQo+ICAjaW5jbHVk
ZSAiZ3QvaW50ZWxfZ3NjLmgiDQo+ICAjaW5jbHVkZSAiZ3QvaW50ZWxfZ3QuaCINCj4gIA0KPiBA
QCAtMzYsMTIgKzM3LDU2IEBAIHN0YXRpYyBpbnQgZ3NjX2lycV9pbml0KGludCBpcnEpDQo+ICAJ
cmV0dXJuIGlycV9zZXRfY2hpcF9kYXRhKGlycSwgTlVMTCk7DQo+ICB9DQo+ICANCj4gK3N0YXRp
YyBpbnQNCj4gK2dzY19leHRfb21fYWxsb2Moc3RydWN0IGludGVsX2dzYyAqZ3NjLCBzdHJ1Y3Qg
aW50ZWxfZ3NjX2ludGYgKmludGYsIHNpemVfdCBzaXplKQ0KPiArew0KPiArCXN0cnVjdCBpbnRl
bF9ndCAqZ3QgPSBnc2NfdG9fZ3QoZ3NjKTsNCj4gKwlzdHJ1Y3QgZHJtX2k5MTVfZ2VtX29iamVj
dCAqb2JqOw0KPiArCWludCBlcnI7DQo+ICsNCj4gKwlvYmogPSBpOTE1X2dlbV9vYmplY3RfY3Jl
YXRlX2xtZW0oZ3QtPmk5MTUsIHNpemUsDQo+ICsJCQkJCSAgSTkxNV9CT19BTExPQ19DT05USUdV
T1VTIHwNCj4gKwkJCQkJICBJOTE1X0JPX0FMTE9DX0NQVV9DTEVBUik7DQo+ICsJaWYgKElTX0VS
UihvYmopKSB7DQo+ICsJCWRybV9lcnIoJmd0LT5pOTE1LT5kcm0sICJGYWlsZWQgdG8gYWxsb2Nh
dGUgZ3NjIG1lbW9yeVxuIik7DQo+ICsJCXJldHVybiBQVFJfRVJSKG9iaik7DQo+ICsJfQ0KPiAr
DQo+ICsJZXJyID0gaTkxNV9nZW1fb2JqZWN0X3Bpbl9wYWdlc191bmxvY2tlZChvYmopOw0KPiAr
CWlmIChlcnIpIHsNCj4gKwkJZHJtX2VycigmZ3QtPmk5MTUtPmRybSwgIkZhaWxlZCB0byBwaW4g
cGFnZXMgZm9yIGdzYyBtZW1vcnlcbiIpOw0KPiArCQlnb3RvIG91dF9wdXQ7DQo+ICsJfQ0KPiAr
DQo+ICsJaW50Zi0+Z2VtX29iaiA9IG9iajsNCj4gKw0KPiArCXJldHVybiAwOw0KPiArDQo+ICtv
dXRfcHV0Og0KPiArCWk5MTVfZ2VtX29iamVjdF9wdXQob2JqKTsNCj4gKwlyZXR1cm4gZXJyOw0K
PiArfQ0KPiArDQo+ICtzdGF0aWMgdm9pZCBnc2NfZXh0X29tX2Rlc3Ryb3koc3RydWN0IGludGVs
X2dzY19pbnRmICppbnRmKQ0KPiArew0KPiArCXN0cnVjdCBkcm1faTkxNV9nZW1fb2JqZWN0ICpv
YmogPSBmZXRjaF9hbmRfemVybygmaW50Zi0+Z2VtX29iaik7DQo+ICsNCj4gKwlpZiAoIW9iaikN
Cj4gKwkJcmV0dXJuOw0KPiArDQo+ICsJaWYgKGk5MTVfZ2VtX29iamVjdF9oYXNfcGlubmVkX3Bh
Z2VzKG9iaikpDQo+ICsJCWk5MTVfZ2VtX29iamVjdF91bnBpbl9wYWdlcyhvYmopOw0KPiArDQo+
ICsJaTkxNV9nZW1fb2JqZWN0X3B1dChvYmopOw0KPiArfQ0KPiArDQo+ICBzdHJ1Y3QgZ3NjX2Rl
ZiB7DQo+ICAJY29uc3QgY2hhciAqbmFtZTsNCj4gIAl1bnNpZ25lZCBsb25nIGJhcjsNCj4gIAlz
aXplX3QgYmFyX3NpemU7DQo+ICAJYm9vbCB1c2VfcG9sbGluZzsNCj4gIAlib29sIHNsb3dfZmly
bXdhcmU7DQo+ICsJc2l6ZV90IGxtZW1fc2l6ZTsNCj4gIH07DQo+ICANCj4gIC8qIGdzYyByZXNv
dXJjZXMgYW5kIGRlZmluaXRpb25zIChIRUNJMSBhbmQgSEVDSTIpICovDQo+IEBAIC03NCw2ICsx
MTksNyBAQCBzdGF0aWMgY29uc3Qgc3RydWN0IGdzY19kZWYgZ3NjX2RlZl9kZzJbXSA9IHsNCj4g
IAkJLm5hbWUgPSAibWVpLWdzYyIsDQo+ICAJCS5iYXIgPSBERzJfR1NDX0hFQ0kxX0JBU0UsDQo+
ICAJCS5iYXJfc2l6ZSA9IEdTQ19CQVJfTEVOR1RILA0KPiArCQkubG1lbV9zaXplID0gU1pfNE0s
DQo+ICAJfSwNCj4gIAl7DQo+ICAJCS5uYW1lID0gIm1laS1nc2NmaSIsDQo+IEBAIC05MCwyNiAr
MTM2LDMyIEBAIHN0YXRpYyB2b2lkIGdzY19yZWxlYXNlX2RldihzdHJ1Y3QgZGV2aWNlICpkZXYp
DQo+ICAJa2ZyZWUoYWRldik7DQo+ICB9DQo+ICANCj4gLXN0YXRpYyB2b2lkIGdzY19kZXN0cm95
X29uZShzdHJ1Y3QgaW50ZWxfZ3NjX2ludGYgKmludGYpDQo+ICtzdGF0aWMgdm9pZCBnc2NfZGVz
dHJveV9vbmUoc3RydWN0IGRybV9pOTE1X3ByaXZhdGUgKmk5MTUsDQo+ICsJCQkgICAgc3RydWN0
IGludGVsX2dzYyAqZ3NjLCB1bnNpZ25lZCBpbnQgaW50Zl9pZCkNCj4gIHsNCj4gKwlzdHJ1Y3Qg
aW50ZWxfZ3NjX2ludGYgKmludGYgPSAmZ3NjLT5pbnRmW2ludGZfaWRdOw0KPiArDQo+ICAJaWYg
KGludGYtPmFkZXYpIHsNCj4gIAkJYXV4aWxpYXJ5X2RldmljZV9kZWxldGUoJmludGYtPmFkZXYt
PmF1eF9kZXYpOw0KPiAgCQlhdXhpbGlhcnlfZGV2aWNlX3VuaW5pdCgmaW50Zi0+YWRldi0+YXV4
X2Rldik7DQo+ICAJCWludGYtPmFkZXYgPSBOVUxMOw0KPiAgCX0NCj4gKw0KPiAgCWlmIChpbnRm
LT5pcnEgPj0gMCkNCj4gIAkJaXJxX2ZyZWVfZGVzYyhpbnRmLT5pcnEpOw0KPiAgCWludGYtPmly
cSA9IC0xOw0KPiArDQo+ICsJZ3NjX2V4dF9vbV9kZXN0cm95KGludGYpOw0KPiAgfQ0KPiAgDQo+
IC1zdGF0aWMgdm9pZCBnc2NfaW5pdF9vbmUoc3RydWN0IGRybV9pOTE1X3ByaXZhdGUgKmk5MTUs
DQo+IC0JCQkgc3RydWN0IGludGVsX2dzY19pbnRmICppbnRmLA0KPiArc3RhdGljIHZvaWQgZ3Nj
X2luaXRfb25lKHN0cnVjdCBkcm1faTkxNV9wcml2YXRlICppOTE1LCBzdHJ1Y3QgaW50ZWxfZ3Nj
ICpnc2MsDQo+ICAJCQkgdW5zaWduZWQgaW50IGludGZfaWQpDQo+ICB7DQo+ICAJc3RydWN0IHBj
aV9kZXYgKnBkZXYgPSB0b19wY2lfZGV2KGk5MTUtPmRybS5kZXYpOw0KPiAgCXN0cnVjdCBtZWlf
YXV4X2RldmljZSAqYWRldjsNCj4gIAlzdHJ1Y3QgYXV4aWxpYXJ5X2RldmljZSAqYXV4X2RldjsN
Cj4gIAljb25zdCBzdHJ1Y3QgZ3NjX2RlZiAqZGVmOw0KPiArCXN0cnVjdCBpbnRlbF9nc2NfaW50
ZiAqaW50ZiA9ICZnc2MtPmludGZbaW50Zl9pZF07DQo+ICAJaW50IHJldDsNCj4gIA0KPiAgCWlu
dGYtPmlycSA9IC0xOw0KPiBAQCAtMTQxLDcgKzE5Myw3IEBAIHN0YXRpYyB2b2lkIGdzY19pbml0
X29uZShzdHJ1Y3QgZHJtX2k5MTVfcHJpdmF0ZSAqaTkxNSwNCj4gIAlpbnRmLT5pcnEgPSBpcnFf
YWxsb2NfZGVzYygwKTsNCj4gIAlpZiAoaW50Zi0+aXJxIDwgMCkgew0KPiAgCQlkcm1fZXJyKCZp
OTE1LT5kcm0sICJnc2MgaXJxIGVycm9yICVkXG4iLCBpbnRmLT5pcnEpOw0KPiAtCQlyZXR1cm47
DQo+ICsJCWdvdG8gZmFpbDsNCj4gIAl9DQo+ICANCj4gIAlyZXQgPSBnc2NfaXJxX2luaXQoaW50
Zi0+aXJxKTsNCj4gQEAgLTE1NSw2ICsyMDcsMTkgQEAgc3RhdGljIHZvaWQgZ3NjX2luaXRfb25l
KHN0cnVjdCBkcm1faTkxNV9wcml2YXRlICppOTE1LA0KPiAgCWlmICghYWRldikNCj4gIAkJZ290
byBmYWlsOw0KPiAgDQo+ICsJaWYgKGRlZi0+bG1lbV9zaXplKSB7DQo+ICsJCWRybV9kYmcoJmk5
MTUtPmRybSwgInNldHRpbmcgdXAgR1NDIGxtZW1cbiIpOw0KPiArDQo+ICsJCWlmIChnc2NfZXh0
X29tX2FsbG9jKGdzYywgaW50ZiwgZGVmLT5sbWVtX3NpemUpKSB7DQo+ICsJCQlkcm1fZXJyKCZp
OTE1LT5kcm0sICJzZXR0aW5nIHVwIGdzYyBleHRlbmRlZCBvcGVyYXRpb25hbCBtZW1vcnkgZmFp
bGVkXG4iKTsNCj4gKwkJCWtmcmVlKGFkZXYpOw0KPiArCQkJZ290byBmYWlsOw0KPiArCQl9DQo+
ICsNCj4gKwkJYWRldi0+ZXh0X29wX21lbS5zdGFydCA9IGk5MTVfZ2VtX29iamVjdF9nZXRfZG1h
X2FkZHJlc3MoaW50Zi0+Z2VtX29iaiwgMCk7DQo+ICsJCWFkZXYtPmV4dF9vcF9tZW0uZW5kID0g
YWRldi0+ZXh0X29wX21lbS5zdGFydCArIGRlZi0+bG1lbV9zaXplOw0KPiArCX0NCj4gKw0KPiAg
CWFkZXYtPmlycSA9IGludGYtPmlycTsNCj4gIAlhZGV2LT5iYXIucGFyZW50ID0gJnBkZXYtPnJl
c291cmNlWzBdOw0KPiAgCWFkZXYtPmJhci5zdGFydCA9IGRlZi0+YmFyICsgcGRldi0+cmVzb3Vy
Y2VbMF0uc3RhcnQ7DQo+IEBAIC0xODgsNyArMjUzLDcgQEAgc3RhdGljIHZvaWQgZ3NjX2luaXRf
b25lKHN0cnVjdCBkcm1faTkxNV9wcml2YXRlICppOTE1LA0KPiAgDQo+ICAJcmV0dXJuOw0KPiAg
ZmFpbDoNCj4gLQlnc2NfZGVzdHJveV9vbmUoaW50Zik7DQo+ICsJZ3NjX2Rlc3Ryb3lfb25lKGk5
MTUsIGdzYywgaW50Zi0+aWQpOw0KPiAgfQ0KPiAgDQo+ICBzdGF0aWMgdm9pZCBnc2NfaXJxX2hh
bmRsZXIoc3RydWN0IGludGVsX2d0ICpndCwgdW5zaWduZWQgaW50IGludGZfaWQpDQo+IEBAIC0y
MjksNyArMjk0LDcgQEAgdm9pZCBpbnRlbF9nc2NfaW5pdChzdHJ1Y3QgaW50ZWxfZ3NjICpnc2Ms
IHN0cnVjdCBkcm1faTkxNV9wcml2YXRlICppOTE1KQ0KPiAgCQlyZXR1cm47DQo+ICANCj4gIAlm
b3IgKGkgPSAwOyBpIDwgSU5URUxfR1NDX05VTV9JTlRFUkZBQ0VTOyBpKyspDQo+IC0JCWdzY19p
bml0X29uZShpOTE1LCAmZ3NjLT5pbnRmW2ldLCBpKTsNCj4gKwkJZ3NjX2luaXRfb25lKGk5MTUs
IGdzYywgaSk7DQo+ICB9DQo+ICANCj4gIHZvaWQgaW50ZWxfZ3NjX2Zpbmkoc3RydWN0IGludGVs
X2dzYyAqZ3NjKQ0KPiBAQCAtMjQxLDUgKzMwNiw1IEBAIHZvaWQgaW50ZWxfZ3NjX2Zpbmkoc3Ry
dWN0IGludGVsX2dzYyAqZ3NjKQ0KPiAgCQlyZXR1cm47DQo+ICANCj4gIAlmb3IgKGkgPSAwOyBp
IDwgSU5URUxfR1NDX05VTV9JTlRFUkZBQ0VTOyBpKyspDQo+IC0JCWdzY19kZXN0cm95X29uZSgm
Z3NjLT5pbnRmW2ldKTsNCj4gKwkJZ3NjX2Rlc3Ryb3lfb25lKGd0LT5pOTE1LCBnc2MsIGkpOw0K
PiAgfQ0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2k5MTUvZ3QvaW50ZWxfZ3NjLmgg
Yi9kcml2ZXJzL2dwdS9kcm0vaTkxNS9ndC9pbnRlbF9nc2MuaA0KPiBpbmRleCA2ODU4MmY5MTJi
MjEuLmZjYWMxNzc1ZTljMyAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2k5MTUvZ3Qv
aW50ZWxfZ3NjLmgNCj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2k5MTUvZ3QvaW50ZWxfZ3NjLmgN
Cj4gQEAgLTIwLDExICsyMCwxNCBAQCBzdHJ1Y3QgbWVpX2F1eF9kZXZpY2U7DQo+ICANCj4gIC8q
Kg0KPiAgICogc3RydWN0IGludGVsX2dzYyAtIGdyYXBoaWNzIHNlY3VyaXR5IGNvbnRyb2xsZXIN
Cj4gKyAqDQo+ICsgKiBAZ2VtX29iajogc2NyYXRjaCBtZW1vcnkgR1NDIG9wZXJhdGlvbnMNCj4g
ICAqIEBpbnRmIDogZ3NjIGludGVyZmFjZQ0KPiAgICovDQo+ICBzdHJ1Y3QgaW50ZWxfZ3NjIHsN
Cj4gIAlzdHJ1Y3QgaW50ZWxfZ3NjX2ludGYgew0KPiAgCQlzdHJ1Y3QgbWVpX2F1eF9kZXZpY2Ug
KmFkZXY7DQo+ICsJCXN0cnVjdCBkcm1faTkxNV9nZW1fb2JqZWN0ICpnZW1fb2JqOw0KPiAgCQlp
bnQgaXJxOw0KPiAgCQl1bnNpZ25lZCBpbnQgaWQ7DQo+ICAJfSBpbnRmW0lOVEVMX0dTQ19OVU1f
SU5URVJGQUNFU107DQo+IC0tIA0KPiAyLjM3LjINCj4gDQoNCg==
