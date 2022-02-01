Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5EB274A6533
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Feb 2022 20:53:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233781AbiBATxA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 14:53:00 -0500
Received: from mga18.intel.com ([134.134.136.126]:65454 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233014AbiBATw7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 14:52:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643745179; x=1675281179;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=3mReF+XSk/YXczaN0YwB/FQN3PqtCbrCtyArGzWpHEo=;
  b=itcVueXoaVLcjqkbPOUH5pDAax5SeumwLNK2mLvePFC6JfTJXsvADo5/
   vVRLyKJgUZi+cR7dsinh9R8Og/keUcmG5SwwfaB/I9BByS9CQGEv8tyS/
   h+aA1ahZNmZCDeXMouR2+b4eYx5mhKzDvGHAnbUYzcaCyZVz/EZULHrWH
   yakdPMT7cLievmLw5JE9lwhAo93JJ9O14NKl+MKOcUDMR8udtW8Gv3lpy
   HN5fZH57/yYZ13/VFxYszD87bYC9zgKIOIkWpSvJRvdMdE/09lW0VQMWv
   hln9XTL/20U7nnOejCcZ+9rsQtiSHZuMSXstxEYgUvKHZ1ioY1Dzf7cje
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10245"; a="231343253"
X-IronPort-AV: E=Sophos;i="5.88,334,1635231600"; 
   d="scan'208";a="231343253"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2022 11:52:49 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,334,1635231600"; 
   d="scan'208";a="626840020"
Received: from orsmsx606.amr.corp.intel.com ([10.22.229.19])
  by fmsmga002.fm.intel.com with ESMTP; 01 Feb 2022 11:52:48 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX606.amr.corp.intel.com (10.22.229.19) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Tue, 1 Feb 2022 11:52:48 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20 via Frontend Transport; Tue, 1 Feb 2022 11:52:48 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.171)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.20; Tue, 1 Feb 2022 11:52:47 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NWHqOwiuIX8gps6wQG2/b6yiZdy6EqfsBGCFh6VbycoPY9YigWv5IZlpbRvTwzui3p51FoZmvo4QspViYV9KJrlzTVZKPYgSoilBbDPLB0AIIQYi0t58mj5hF9ZWVu5hSZZKRHUDCsPrTkqxLr7Cg2TWEMIGht+FZhyazugSWVpSEBbDmZfDzUJu0J4SBpCgtkxqiBihtcIi3Imhm2VsJvidEMWg5TjjQ1heO5elBNNQ/Cdb2o9MxB4p8GQUfcl4RvPBS2l7RX3mMBE9LBo0bDfV9ItC4jidaqx+2SzgTaTu4D+rzmvYa85qEC3ZFcFucbKbk8TNex4X1epUy0lvIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3mReF+XSk/YXczaN0YwB/FQN3PqtCbrCtyArGzWpHEo=;
 b=fvHOSMd0KtY/tsND4HwSIypjYclZHm9j+Ds0ifSvvR6aJRUnvbZzHFvR7PKM7V1VjkJF94Z5n63fgic05a+rqIJTS6IGUO5oO3PM99xuYRbDcsh+FeyKxx7M3o1mhyeNaRUjndtW5rYADzVaMuhlXKnO+EPcjPwXwHx7wgb2GDTZKKCz1nU19ZTJk6tGx/m9tbG1EW3uOm6dOdGLu0RFCvkvLP53he3WD73S4snOVO4GNN+oo940AOmEuz6RRrZgrYgahHCcZYGVs4xcR0rRvmGeGRbP3lpEibb85fgwm+6CVjFSlD9P5VCKqbXFT2ESoa/u16LFScySA4Iws5ataw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from MWHPR11MB1392.namprd11.prod.outlook.com (2603:10b6:300:24::14)
 by BYAPR11MB3093.namprd11.prod.outlook.com (2603:10b6:a03:88::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.17; Tue, 1 Feb
 2022 19:52:45 +0000
Received: from MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::7053:5a70:1fec:345f]) by MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::7053:5a70:1fec:345f%7]) with mapi id 15.20.4930.022; Tue, 1 Feb 2022
 19:52:44 +0000
From:   "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To:     "hpa@zytor.com" <hpa@zytor.com>,
        "Williams, Dan J" <dan.j.williams@intel.com>,
        "Weiny, Ira" <ira.weiny@intel.com>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>
CC:     "Yu, Fenghua" <fenghua.yu@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH V8 20/44] mm/pkeys: Add PKS test for context switching
Thread-Topic: [PATCH V8 20/44] mm/pkeys: Add PKS test for context switching
Thread-Index: AQHYE6cS1JgGONNff02sCQH7fdYxhqx/AC6AgAAjEgA=
Date:   Tue, 1 Feb 2022 19:52:44 +0000
Message-ID: <ecafd25c10b50846b24dfad370539f0a1f803672.camel@intel.com>
References: <20220127175505.851391-1-ira.weiny@intel.com>
         <20220127175505.851391-21-ira.weiny@intel.com>
         <da79f69a41925f26d810f42f34dd149f5ea69d5c.camel@intel.com>
In-Reply-To: <da79f69a41925f26d810f42f34dd149f5ea69d5c.camel@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4165bf92-dec1-4514-72cf-08d9e5bc6a42
x-ms-traffictypediagnostic: BYAPR11MB3093:EE_
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr,ExtFwd
x-microsoft-antispam-prvs: <BYAPR11MB309345371832CFA86B500595C9269@BYAPR11MB3093.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0T0/8LIjxZ+ElT7pCvQZuhiw5bO5YNDZ5jzIJm32u5rAbmyzLeI7qxO3XQNV5x54H3rq8m96ShaKnLI3o0mC4A1biuXnBfP9EVFO1nEOD1Dw3DjNoO18H8ve50b/4XWuYf+kxdsiymGtZbHJAdxJ9itnQyevSaX8roGjmMFwvyIPWUQ97zy4wtrJH5uY4y0yxPOvWvREoNWGUr2q2s+9T6jC4L1LE1V3MdJXk0VBXPxD68xFzwLBKdsB7aMH5/uigukX9bLdwCdXccBBvsvxRYAxBg+vTYMYrYovlsIwneM+apo0end2923difEgJiYPj6cUFiJVwS+oTrs4oclJiFHS5FUXK6TKCpwUOEbptDHUXyaiCUNp1pLTG4qA8Y5pRm8g+m+4KOSnEAL5oQleXoKg6Bc+YvYwRIAAzJ0TeAU3TsF2V9H6rZz6cVPwgdW5/BLPfJwnBXzfuXlMo5PbW2D1wa0g/dM0T6C53P3lad+gX8o4lFvQJ0WQ3gj3O1fe3oy48nwpdv/+cHdwKFmcYvsajIBk+mqmlrHrWnvx8mzE4SKJPcSRgP+Csg6QM0fx6rTjBBuJkfT5ZC9sVC3KVMTz6ZDLgIH6rdcyMNIDtiM5n8ZQ7t8zQO9ek0SRfUywzgg1PmqAeE0FXe7gm5Z1JddtBmpRxYW7fj1AiBzyMj8+WzLdxDWjtmqfYc6id16qKZpUdwsE8/z7NEVuY/dmm5ynaN06wuYSN2ndqA3wNIU=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR11MB1392.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(26005)(186003)(508600001)(38100700002)(71200400001)(2616005)(5660300002)(6486002)(86362001)(6512007)(6506007)(316002)(38070700005)(66946007)(122000001)(8936002)(8676002)(4326008)(66446008)(54906003)(110136005)(76116006)(64756008)(2906002)(66556008)(66476007)(36756003)(82960400001)(4744005)(99106002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NnR0a0J2eHdEWEtoOXFKOXVXZENyYU1zRzBrYk1SSzlHY0U4QS9CRVJyK0hI?=
 =?utf-8?B?d0E0bFA4WUZabUlSTFhUZlZxcUFzMFByWTJkYlN0V3BrN1NXOHkvZzd0NkhT?=
 =?utf-8?B?NC93cXp5S0EzU1g4c0wwWmY5WUVMNWFkeXVNS056eEsvMGo0NERmUFM1aWw3?=
 =?utf-8?B?eVpIdW1RMExNRnd0V3pkUTVnNHBxR1oreUJ5enpia1BPcFV1Q2VjaTJKR3dU?=
 =?utf-8?B?YmtMSFhiKzJISWhYTnlnL1hSdUlLMzJBTkRsSHg2WHJKTVl4MW5JZmlXd3ZE?=
 =?utf-8?B?OUExVzdDMk1ielIyUmJNQXRjRFl4VkVNTmIvL0tHVjNhUTg4OE10ZHl3dXBJ?=
 =?utf-8?B?TUJqS0NCdWloV2JlVFlTVmJGQ1RBTkdHTFU4T1Q4WWdGbjhCeS91OWpib3Fz?=
 =?utf-8?B?cHZuTDBSelNDMDd3VDVFV3JPVVN1MWo1M3lnT2JjTVExWEloTG5sUE5yN3d3?=
 =?utf-8?B?clE3KzRSaVJMOG9kdkdESi92cDh0MVhQK2RPT1pyT25VUTNRaUIyZ216VE05?=
 =?utf-8?B?b1dQMVdQN3l4b0M3T0NHS1NKaUNJazR6Unh5WTlNa3B0aGpqK3hWSnJXeWd6?=
 =?utf-8?B?Z0tad2tJeEpQMkZCMFdwNnBCOE9hNTNCV3BicktCbnorVzdVMEJSRTRxZGVF?=
 =?utf-8?B?ZUpwTHZjZlJ1VkhNdkFLUUovTlJFWnMxa2RnblFhTldWOFlKcERTNjFzaFMr?=
 =?utf-8?B?akdJYnNyUUpIcHlVa2lsOE1FUHJNWHR0VENDTm1SV0NjYTNhV3lmRDRZd0NS?=
 =?utf-8?B?dlZJN3ZrWHV4V1ZGVWdDbmxwdnozR0s4dDBRME5OdjVGeEh1UUVYbWNFUHpZ?=
 =?utf-8?B?dmgzU1d1OU9uZFBqcFhPWk5TQlFkTHptWXVQMFBIYy9weTRBalhnV2lPMjdH?=
 =?utf-8?B?TVNpcjNCNk5YY1pFelFHZnhUcEM4cUwydHc0WTZOOURYbW5xVWFsU1A5cURx?=
 =?utf-8?B?UjBjODB4U3JQUEQvZDVHdjc1SGpmN0JrVE9iOXBGOTh6UnpabDc0TXFJUUY2?=
 =?utf-8?B?MTFHUFdsSEZhcjUyRDJveCtjSlplS09XbG9NTHlQRTR2U3dGSzJlNmNMUVJm?=
 =?utf-8?B?MDU2QUtMWXl2SmdrMkNaclJvb0FWNFdWUWNWTTk4NTdBVERQRm5VcGw5dlpG?=
 =?utf-8?B?RE50ZG82d2RqZnc2dXZuRlV6Z1Z3cHRScTdaWmNWbGxxMDI2WXhCTnZtWXlY?=
 =?utf-8?B?bHpOUzRHbC9JNHZNRERoSWhMS1pZMEg1SnUvZGZEWHNjVXFmd0FDMjhrNFlL?=
 =?utf-8?B?NC9OcDlqcEs4SHBXUlg5cjVDZEN3QnNCYWY3TnZOZGw5NjZGTEdleTljZk5M?=
 =?utf-8?B?NXdoUmowTjBDcTZWeGRLeVBOTTZiekt3Q1I2dEpKZXpOUDB1aVhvMGpvZEp2?=
 =?utf-8?B?MFJKL0ZERmJLTGI4RUJoeTlkdUdlWGFJVzhuL2tkK2JZMkxpSUNZajdYZ1JO?=
 =?utf-8?B?NDVQeGJtRGdRcVg4N2ZqOG9VUU1YYzBvNUYvWWpXLzQzK053SEx4cEhsQStl?=
 =?utf-8?B?MThOdjdObVVqUTRRbGdmajdJdVhJbFl0OTJMcUM4dlM1MndGVVF1UWUwRXZL?=
 =?utf-8?B?VjFqR0dCRVJwd1hDd0E2dTg4VzVBYnhMUDU4bTZhN3ZFWGp3MXZXb1Z2SlhZ?=
 =?utf-8?B?Z2hWSEl4QmxndnFOdndmYkJNUENzbmlkT3VpampBOWM3UmdCdkg1dHVZM2VZ?=
 =?utf-8?B?TTZobHE5emNYUWUvRWhXUWZOVTFaTUZlU2NyVGkxcEkvclpSUzg4M3RKVDU5?=
 =?utf-8?B?Qm1DU1NCZkFBVzNhL1NVVjlxcUFiZ2lrN2RBNHUrNEt0bE5GKzBWdFVFUVVv?=
 =?utf-8?B?VXdxeUlxZ3B0MU9oVmxyZVB0M044ZDg5dWZRM0tFd3F5U0M2Z01BZ01Tc2FK?=
 =?utf-8?B?UWY2Z2NaaHlVZlFoRVY2SG1UVmtYaHExVUVvektvUnc0STlIbER6czNyaGcz?=
 =?utf-8?B?d2MxVTZ1dDMxenMyemhLZCtUZUZGWXFXbFdXSmU2aW5UVEZFY2pWUnc0cXdn?=
 =?utf-8?B?clBBcEdNdFFQY09oUUd0RmlJNytXeXBLVFVzeHhRaEZXbWExT2dIeStrSGhW?=
 =?utf-8?B?MzZpMEh4ak16Vk1GVW5HMVRBU1d5bWNkTHIyMG1UWnJjVHc4VlV4aE9ULzAv?=
 =?utf-8?B?Z2dYQ2RZM251N0lMb0M3OXZqVEVGRGp0ZTRVa2dxNlVmaGZmSDZPakZuTGNG?=
 =?utf-8?B?ZFZDYlVqUGlDb1h4UVBjeTFkeUZkVVhmMVY2Y291UU9qTktzTXhxU0ROZVhy?=
 =?utf-8?Q?zjU1YQJfsOSFngs5b0D1ab/m7rWi2r84WPKnP6KhcM=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <0632C8A991476B47828A591957B5F41D@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR11MB1392.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4165bf92-dec1-4514-72cf-08d9e5bc6a42
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Feb 2022 19:52:44.7737
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0pgVM+4AnRl7VMhI3pEKX3CJDm/JCl9iImfVyBBtmmB3vLVDMrfwtypy/arPvMcbAX3ApToyEsG7yW0AwYCVQfmciN02jQu7X3oYeZOopWY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR11MB3093
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVHVlLCAyMDIyLTAyLTAxIGF0IDA5OjQ3IC0wODAwLCBFZGdlY29tYmUsIFJpY2hhcmQgUCB3
cm90ZToNCj4gT24gVGh1LCAyMDIyLTAxLTI3IGF0IDA5OjU0IC0wODAwLCBpcmEud2VpbnlAaW50
ZWwuY29tIHdyb3RlOg0KPiA+ICBsaWIvcGtzL3Brc190ZXN0LmMgICAgICAgICAgICAgICAgICAg
ICB8ICA3NCArKysrKysrKysrKw0KPiANCj4gU2luY2UgdGhpcyBvbmx5IHRlc3RzIGEgc3BlY2lm
aWMgb3BlcmF0aW9uIG9mIHBrcywgc2hvdWxkIGl0IGJlIG5hbWVkDQo+IG1vcmUgc3BlY2lmaWNh
bGx5PyBPciBpdCBtaWdodCBiZSBoYW5keSBpZiBpdCByYW4gYWxsIHRoZSBQS1MgdGVzdHMsDQo+
IGV2ZW4gdGhvdWdoIHRoZSBvdGhlcnMgY2FuIGJlIHJ1biBkaXJlY3RseS4NCg0KT29wcywgSSBt
ZWFudCAidG9vbHMvdGVzdGluZy9zZWxmdGVzdHMveDg2L3Rlc3RfcGtzLmMiDQo=
