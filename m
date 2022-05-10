Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EAF05226D2
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 00:26:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236232AbiEJW0u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 18:26:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229956AbiEJW0s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 18:26:48 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE6AF50041;
        Tue, 10 May 2022 15:26:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652221606; x=1683757606;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=Zrru0xb1mWpOlxCOag9SEgoKIrTbUk923t5gkDtCX/o=;
  b=QhdsmSfRUeWNwmzqSUw0wQfyVaoO9I3VFWr4NY7leGnNUcEZZ3UduvwA
   NsUPjhyXoJze3u8pA6y6i50Ni0AeIUodg2vtCYcB0aPZoxnJtSe3gdxcY
   e9EKgGWx/NgiUt3v0NBtsb9M2L3tqGbijtT4c9PAtiLgZWqUsFYnGsxdb
   FgE1lGqMMLkQ3+NcIcKHWL5IwKHb2OhXWAKzquNOL1qbmTVtcB3sUwMhA
   PQALGBE60nJhzwJp+kQnnRMbc5wqM8zVX/flBsMtuLKgOFQ2nAN/d3oEw
   BA6BegKDW7+7WeQ4/NdyEXbtEt+9VZKmWhOG+jX4ee7Zjpnb/eUPwcBGk
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10343"; a="355945376"
X-IronPort-AV: E=Sophos;i="5.91,215,1647327600"; 
   d="scan'208";a="355945376"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2022 15:26:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,215,1647327600"; 
   d="scan'208";a="623678503"
Received: from orsmsx606.amr.corp.intel.com ([10.22.229.19])
  by fmsmga008.fm.intel.com with ESMTP; 10 May 2022 15:26:46 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX606.amr.corp.intel.com (10.22.229.19) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Tue, 10 May 2022 15:26:46 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Tue, 10 May 2022 15:26:45 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Tue, 10 May 2022 15:26:45 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.169)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Tue, 10 May 2022 15:26:45 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hFVaZV9CsBTpwGvXIlc77n3/WZnYLZuiYcT5S54SVmuDxSsjzi9rr3pcwsV3BNKdngNNf7QBBnRA/nU9nv8nxxn9UgLcs+wznS9+XwCagE0jGgcGCWCl1xlryGe9VszwH4Rz8slmKs8edSvnC5YC5prb2PGV9wn6ZEgBQIP8UbhJ/gf11Gqa3YKDsOk5fbCI80b/okXMPl1N6Ov6tKRXAhJu4ype74Ru0dShO4U/3xBx5mY1l8oN1jQa52x4eV/rMNmN5TP6K87FHeCiCbCgnC1BCMKFrVEfYcPRJ7oqnNxASpa+6c9TOnTO43Qu5217QezTDKmXj7AeDwKEGZgtsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Zrru0xb1mWpOlxCOag9SEgoKIrTbUk923t5gkDtCX/o=;
 b=Fwt0T5VjYYQ4CNrWeyICVFuS4YT14AkOIQbooUmv8pN76tcY62hLR27REr/fJaUUQ+ms9a0xdzBKFgVYsizzO9CgBRLPX8+elhKJGYmqJJ5ZfpSjWVj4SxQvIWZsGE0Opwyk2DBMTc6X9+Sx7O+SnvXsS+VlYVjrabyRUtN9rtuQSlh6lN2SO1qn8KyiZC9YHY4HxEWc31DdfmewH9oNwxp9+gGV3JyZAf9GLaVgDNPHG7o/G45tTTBD9dyPtyLjIXnv41kCc2uzB0127HNadI2F1rWNMz0JNxMc75rcOL/W0/eKjig9kfdDWn9Es8z7U0qnZC7YN6c6EK1vPY6iow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MWHPR11MB1392.namprd11.prod.outlook.com (2603:10b6:300:24::14)
 by MWHPR1101MB2288.namprd11.prod.outlook.com (2603:10b6:301:53::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.20; Tue, 10 May
 2022 22:26:44 +0000
Received: from MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::34f6:8e1d:ac6b:6e03]) by MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::34f6:8e1d:ac6b:6e03%12]) with mapi id 15.20.5227.023; Tue, 10 May
 2022 22:26:43 +0000
From:   "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To:     "keescook@chromium.org" <keescook@chromium.org>,
        "Weiny, Ira" <ira.weiny@intel.com>
CC:     "hpa@zytor.com" <hpa@zytor.com>,
        "Williams, Dan J" <dan.j.williams@intel.com>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        "Yu, Fenghua" <fenghua.yu@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "linux-hardening@vger.kernel.org" <linux-hardening@vger.kernel.org>
Subject: Re: [PATCH V10 14/44] mm/pkeys: Introduce pks_set_readwrite()
Thread-Topic: [PATCH V10 14/44] mm/pkeys: Introduce pks_set_readwrite()
Thread-Index: AQHYVA/qzv8aaz4L2Eyl6f9A+nubZK0XMikAgAGQxYCAAAoHAIAABPcA
Date:   Tue, 10 May 2022 22:26:43 +0000
Message-ID: <76ee55622592d531c82cb42b96d4bb27deb26287.camel@intel.com>
References: <20220419170649.1022246-1-ira.weiny@intel.com>
         <20220419170649.1022246-15-ira.weiny@intel.com>
         <202205091304.434A9B45@keescook> <YnraD8URWxWtaltF@iweiny-desk3>
         <202205101504.5B5C693F7C@keescook>
In-Reply-To: <202205101504.5B5C693F7C@keescook>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ea11b26f-dfef-414d-71a3-08da32d4299a
x-ms-traffictypediagnostic: MWHPR1101MB2288:EE_
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr,ExtFwd
x-microsoft-antispam-prvs: <MWHPR1101MB2288061ADF085BB2BCCD020AC9C99@MWHPR1101MB2288.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: jgS4pxCqHlic+fKMd/NrxY2YhNRAh2Mxi6lAIC5uQtRht/ua+0mzTDCqqplOcCYpNErcw3EzOLe8DR2hV3A2VE4WRQVRFa+8C0kH5xrMOG1FkXXMwmsNLqcbNaZIP0Wrx+DnpGzVvZURYaC8Yx970M5780LgbQDPVUzKgjmEPa0DhbP1cPF+377pJtCsNFnPRx7AYW8j7rs3r4BmNpg5bct6MxXw/xkNzD6UL1JxIzWh6OejxjJHLoT1xPg7C68wg4qsA5Vij0cWjWHeK5WQOKga/eNZh9CiqpaL2g6l3WatKM/j7P/DtlBpOlCRFwcCztu/1idFeDmuOgJYJ4m0xQ/EMDH9tNaK8XcLvXfPy+F61OzvzAAn2y8LQXRAWAGQCkSmu5GSfzmah2BgSyhab1k86ZG84CK3JNIdk6YPjHY8FVF/30c9iy7nvWavkIsypGNvhDfCoZGlsKWHLK/yuZZEKEG70/7qJDjSgyiych86HSvZv/cZwfb+tB85+6lMalmE7WpsNtsBtfigccR5I0PLyFw1JPolNxqU1op5CHykB5hNZldNpGXMbqfi9z5BZAqzDnyG253FkR1fy3INwM2CkMwzYp0GoadBfbW6Z8w4g4by29Ro+DsSfBzW+Q4PL1FXGMlBd8KXeSn3fk4O7jPGhOCx/Wh56EyVBAfHsKuz3ThgM/sFEXwTng89KuAnR4kAttsjEOrNvUYIvlXEkXHcgXlYC6fCV615yzZxoEeICG+5kkO3124LDojdezz+dCNCWm/kMBeteFX9M2rt34K/7k2RRSXYyFFmQ9SXobrvaS6sSinUPnif2pdMkeywhj8NV/ytPGzWuI/N8zo7N+bi3uuPcRE0kiX5xb+L3rg=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR11MB1392.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(91956017)(316002)(508600001)(82960400001)(6486002)(76116006)(38070700005)(38100700002)(8936002)(966005)(110136005)(54906003)(66556008)(6636002)(8676002)(86362001)(4326008)(66476007)(64756008)(66946007)(66446008)(26005)(122000001)(71200400001)(6512007)(6506007)(186003)(2616005)(2906002)(36756003)(5660300002)(99106002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UDRYMlR5U3ZNWVlWYTE4M3RoTVUwcHFMWkVhdFFkQmNKbzFXNk9zTHJXUDZv?=
 =?utf-8?B?SEFuemxuMXA4WndZZXNHT003WmxLdEx0V2NqeW15T2s5NG1ESDRJbjBFMXV5?=
 =?utf-8?B?L1VROHpqUld4QU5DMm1rL0ZsWXlNckkxczA5WXZZRUtwMFNjMERkazExQ1FV?=
 =?utf-8?B?U3RYcmtmOEp0Y3dXcXJhUHZZS3dud0JCcDBxV0tCa2FUY2ZaNlB4VVp3MlFt?=
 =?utf-8?B?V1p3bmZWZHYvZ1FCY04ydksxNWdVL2NRbVpTZEVIazduT1ZQVDJEdVZiQ0hW?=
 =?utf-8?B?QnNDaTRMN0lqYXN3K2h6MC9iaDMwckFvWklkNVVpV3lwLy83Qit3ajh2WmZu?=
 =?utf-8?B?Qjc4VGM3WTFvbjJCRlI4dE9uN1BuRnN1SGZoU09ydjN0amFKM3FyK215U3Rk?=
 =?utf-8?B?RVpFWkQyOEZrMXV3V25zc3JMOW1zNFZsN2NhM01Tay9aSUFyMFBrRllmQlhI?=
 =?utf-8?B?cWRGVi82eEJaa3ZwU1o4TWN6alFvR2w0YVVEVmZnS2RlUTRFY2FzQjRkOGFJ?=
 =?utf-8?B?WCtML3UwSlQrTXJSVWJFVERKc3RobnVvNHFEK296QTFJeWVZd0liZDI3NUlz?=
 =?utf-8?B?KzVpRHZSWHpuQ3RaV2x2aWFETFMzMm5KUUx1MVozNzlzMmQ5MlczN093RVlo?=
 =?utf-8?B?MStxNEUyN0ZyZjlhQXZiVjNGbEN6NTVEczVhVkFxZHVXRW9Gajl1aVc1eERI?=
 =?utf-8?B?OXR6N2w5VDdiVVFpK2p3TlR2VVM4dm85QkVGT0o3VVRnMUI2c2NqSzlTNWUw?=
 =?utf-8?B?Ym5QMjFndzVwL3QrTEJSSlAzdFp6Nk9IcENWZUphazBpYUdpTnZrb01UTExz?=
 =?utf-8?B?amE0OWVwWnQvQ0RLVWYrRENWbXBVTk1vOVFFM3Bkd1pNVm15bWxKZGRIdk5l?=
 =?utf-8?B?S3NHTmllN3VWdk5JZitabWhDQVE3eWFEY3UwWkp6dFNmbEtCSUl4RjY0SkE5?=
 =?utf-8?B?Q1h6d2hsWU9CYlhpSGNpSklsbzVJRnNpR1E3QWN1WUcvTHBIb0JCR2J6T0Mr?=
 =?utf-8?B?UzNIeFVXdGpkMDFEaHRtVkR3UzNZYjhocUlZRzF0ZEVnd0ljYmY5K0xwemVm?=
 =?utf-8?B?VjNCL2FWRk13NWlsUlNPMHpyLzl5aEpUUTVxNzMwYkVuWnhUbWZwV3o0Q0pV?=
 =?utf-8?B?YWxzdWVRdTVTa1hpYlp0M2tjVHpFdHpKZEpMdFBTdzJjTmhpVmhjSDVHSzNs?=
 =?utf-8?B?SCtPYnlaRENRT1VIZTMzVzE1VHJKL05sQzdlVGNORnpteWRnN0VYSnVSSisr?=
 =?utf-8?B?OVI2aHVSWXVSOVZJdHZIQ2JxdzFCajdSSDl2UVZSL2REUmI4ZUZySTZhdnVv?=
 =?utf-8?B?cDR6bnZtZERsMW0xRVhiVERSM2hkbEk5bEJDUk41TDR6SXZCWUkyY0xrZ1Jw?=
 =?utf-8?B?c25OZ1ZndllKRm40UXZHT0tXRExTMU5LSVNvOXp1dDNYaEt3MXNkOGNINkRK?=
 =?utf-8?B?aG9wMlRWMUh2QWpkTFQ3SWRyWnErTHJtSndYbU96aWlQenRBbHpZMVEvT1Rx?=
 =?utf-8?B?aGpYeExqV2lOSW13bC93bTFzRjR5bUZmRVRhVi93dHUzK0JZS1RLRWRKYlFD?=
 =?utf-8?B?SXQrRFlHWWpudDVBdzJwMXhtcTV1ZnQzTGNKUVVLYWEvNUkvU3h6ZXVJZ1lt?=
 =?utf-8?B?TmJKSGhwVlhwcFNzSlBOY2xxR21BcmN2Y2s5MmZkYU0wbWcwT1VJQ0ZqNWZ5?=
 =?utf-8?B?eGZab1Jla0RNblFiL0tsY05ub1JWYTBHL0d4YUJpNHFUbkVWQkl4T1Y2MnRQ?=
 =?utf-8?B?U2d2TzArejVGZFJ1UmRycWFkY3c4V2hDR0Fva1MzOHlpY25xRmlkMHlsdEVR?=
 =?utf-8?B?bSt4TDVqb3kzeUdGSDhrN0VuaUUrNStDMitaZm8rVlh1cEd4ejFSNEdmV1Jm?=
 =?utf-8?B?VGlSZHVzMVcwT2VhYnpmWStOVVN6aFFBV1N5Q0xVZjhjS2YzQ0ZKN3ZkWGRQ?=
 =?utf-8?B?WE42R09Qa2lqeHBPejdYcG1QZnVQdEEwaFpRL0ZPZlJDeTlWd3VPS2s4SEFK?=
 =?utf-8?B?T3NkWEcwZG5FbGRRR3hXTXcxL0NYdU5obmNCY05hNUdLa3RhclJSVWNJRWVV?=
 =?utf-8?B?NDdxZml4QW0rVWQ0aWI0eUptUS9BZ2pHdTdjdTFCUWt3bnNxVUVNbWpNMVR2?=
 =?utf-8?B?Sm9MbXBSSjBFck1ZR3dodURoSUQ4c0VvZEVCTzV0eWpuWk5yUWpiSUdzTTM3?=
 =?utf-8?B?WEo5Ukgrb3lKYXZ6UE9Nc1ZmcWpCby82MW9hS3Jhd0NtN3UwT1BaMHE4OGRR?=
 =?utf-8?B?ZjFYT2VhK1crRVYwalZNNjFuUm56OWdrVWRsUDZOTW53NlJPYkJMY3dyQnFM?=
 =?utf-8?B?L0hjUzZKR1U5Sis1NktWNGw0dFk2bU5sbWFhbHVkVTZ4UmNGbCtEUVpCUTJ1?=
 =?utf-8?Q?7u1tXs9Kf6hTbs1/Tpun0REiMQDiYP1YGL5Yz?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6A999B6DDF19E944B0586110DE0F676E@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR11MB1392.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ea11b26f-dfef-414d-71a3-08da32d4299a
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 May 2022 22:26:43.8633
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 66afERucquAmKW/dKl5M6Qm9PUZkNWc9Rmv5kdjnzerCwS4Fez6IxphRWuosmO+Io+YobVqnnrVACke3XHDF4l7jyvu3L/AwfxA5PYO+6SY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1101MB2288
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVHVlLCAyMDIyLTA1LTEwIGF0IDE1OjA4IC0wNzAwLCBLZWVzIENvb2sgd3JvdGU6DQo+ID4g
S2VlcyB3b3VsZCB5b3UgcHJlZmVyIHBrc19zZXRfbm93cml0ZSgpIGFzIGEgbmFtZT8NCj4gDQo+
IEkgdGhpbmsgbm93cml0ZSBpcyB0aGUgYmV0dGVyIG5hbWUgKGluIHRoZSBzZW5zZSB0aGF0ICJy
ZWFkLW9ubHkiIGNhbg0KPiBzb21ldGltZXMgaW1wbHkgbm9uLWV4ZWN1dGFibGUpLg0KDQpJIGFn
cmVlIHdpdGggdGhpcyBoZXJlLiBSZWFkLW9ubHkgaXMgYSBiYWQgbmFtZSBmb3Igbm90IHdyaXRh
YmxlLg0KRXNwZWNpYWxseSBpZiB5b3UgdHJ5IHRhbGtpbmcgYWJvdXQgImV4ZWN1dGUtb25seSIg
bWVtb3J5IHdoaWNoIGlzDQoicmVhZC1vbmx5IiAobm90IHdyaXRhYmxlKSBhbmQgIm5vdCByZWFk
YWJsZSIuIFZlcnkgY29uZnVzaW5nLg0KDQo+IA0KPiA+ID4gDQo+ID4gPiBXaXRoIHRoZXNlIGNo
YW5nZXMgaXQgc2hvdWxkIGJlIHBvc3NpYmxlIHRvIHByb3RlY3QgdGhlIGtlcm5lbCdzDQo+ID4g
PiBwYWdlDQo+ID4gPiB0YWJsZSBlbnRyaWVzIGZyb20gInN0cmF5IiB3cml0ZXMuIDopDQo+ID4g
DQo+ID4gWWVzLCBSaWNrIGhhcyBkb25lIHNvbWUgZ3JlYXQgd29yayBpbiB0aGF0IGFyZWEuDQo+
IA0KPiBPaCEgSSB3b3VsZCBfbG92ZV8gdG8gc2VlIHRoaXMgc2VyaWVzLiBJIHdhcyB0cnlpbmcg
dG8gc2NvcGUgdGhlIHdvcmsNCj4geWVzdGVyZGF5IGJ1dCBnYXZlIHVwIGFmdGVyIEkgY291bGRu
J3QgZmlndXJlIG91dCB0aGUgcWVtdSBQS1MgdHJpY2suDQo+IDopDQoNCkkgd291bGQgc3RpbGwg
bGlrZSB0byBnZXQgYmFjayB0byBpdCwgYnV0IG90aGVyIHdvcmsgaGFzIGJ1bXBlZCBpdCBmb3IN
Cm5vdy4NCg0KdjE6IA0KaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbGttbC8yMDIxMDUwNTAwMzAz
Mi40ODkxNjQtMS1yaWNrLnAuZWRnZWNvbWJlQGludGVsLmNvbS8jcg0KDQp2MjogDQpodHRwczov
L2xvcmUua2VybmVsLm9yZy9sa21sLzIwMjEwODMwMjM1OTI3LjY0NDMtMS1yaWNrLnAuZWRnZWNv
bWJlQGludGVsLmNvbS8jcg0KDQpNb3N0bHkgaXQgZml0IHRvZ2V0aGVyIHByZXR0eSBlYXNpbHks
IGJ1dCB0aGVyZSB3YXMgbWVtb3J5IG92ZXJoZWFkDQpyZXF1aXJlZCB0byBwcm90ZWN0IHRoZSBw
YWdlIHRhYmxlcyB0aGF0IG1hcCB0aGUgZGlyZWN0IG1hcCBmdWxseQ0KKHVubGVzcyBhIGJldHRl
ciBzb2x1dGlvbiBjYW4gYmUgZm91bmQpLg0K
