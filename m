Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30EC84D7520
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Mar 2022 13:15:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233502AbiCMMNg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Mar 2022 08:13:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230181AbiCMMNf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Mar 2022 08:13:35 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAA25156C40
        for <linux-kernel@vger.kernel.org>; Sun, 13 Mar 2022 05:12:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647173545; x=1678709545;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=fqV3XTUxaNHAlByDDkpAbl0c9ugFmb6vSh70VPVlFpg=;
  b=g0kCFTq4Eef/5nG+DOKt6ZsZY+D7vD+wd5UywhmmQ8AClVuB1OXNE4mM
   XqqaB0XBoEqe5v18q8UiQmoe9JlkTFEV58zmbpDBgA2RSIQCz8U3HExU8
   A1JQf9elMFuz6eQHeVXrxscl4oplZ9iAO9AQLh0yweQFT3MX6DBsDorNd
   +fm24m61iDsAuGKmHJ2zPDM64Tr8EGlaTYLhfBZN7yIoGtKv6q+yaWHtO
   lVoDu4rRVNFRAcWN2Ys23oVha4h2bOFf4odelIXF4didkfEMuNb8GrbR3
   viCtdHUP78C0DejUxzluNX7TzgsK8qtzfizz5ZROO7i2LInnoLSPAQzPh
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10284"; a="238036014"
X-IronPort-AV: E=Sophos;i="5.90,178,1643702400"; 
   d="scan'208";a="238036014"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2022 05:12:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,178,1643702400"; 
   d="scan'208";a="645460268"
Received: from orsmsx606.amr.corp.intel.com ([10.22.229.19])
  by orsmga004.jf.intel.com with ESMTP; 13 Mar 2022 05:12:25 -0700
Received: from orsmsx608.amr.corp.intel.com (10.22.229.21) by
 ORSMSX606.amr.corp.intel.com (10.22.229.19) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Sun, 13 Mar 2022 05:12:24 -0700
Received: from orsmsx608.amr.corp.intel.com (10.22.229.21) by
 ORSMSX608.amr.corp.intel.com (10.22.229.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Sun, 13 Mar 2022 05:12:24 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx608.amr.corp.intel.com (10.22.229.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21 via Frontend Transport; Sun, 13 Mar 2022 05:12:24 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.168)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.21; Sun, 13 Mar 2022 05:12:24 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oJQ4B39Fa1M4uLjWi9IUGWyhK5xP5zTqmN41G1ZGJ2hSPcrADw4QsY2C57bTpwQzGLfZXVCLouzXK3TM0h+j3L8hCnd8T/ERt6pSWjKCp3v8HOKTG0gHfg0RvMoqycPw05nHGsKWhNzubFx9Y4BxjA2SBrMkmx3bRsUBTPSLuCShrKFIcDi3/PLEgAEXEW4odUaCmvuHS4JT/e1ad4FoNVIHsdqIKyh9UheLeSiRHm4i21x3tHPvvC6t0TS0ECp5VlICYAvBqGS9GDi9M8173CGLS6H6fbx6smm5JVWzhWxomMW89zQ+CE3gPDpONQzIVblsMjlWmvljUSmBykJ9ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fqV3XTUxaNHAlByDDkpAbl0c9ugFmb6vSh70VPVlFpg=;
 b=f4lTC4PpQFJDrtvbGCRSDNp0+eei5FEMOUr0qDSDW99+12rruivwP5z6FCjvEJAxPcPO3Dk4o3tlqfjHp4D3jDH06PRbD6qV0Sj2AVVyTU2hPk4kdqYoujme+iNP/o4jWuanSZWNQ3kTqfPjlKmRjsYGdvWEVX6jbn1xr2o5YpMef2JSXiB3wK3BUSebRKfuvULcjEYOb+nW43mvvaBQsIIWImJDw28Gqivs/G1CH3pqBT5iab+sjm1CTxAW6T5Z8PpKBZgORZnP+2fEE8Vpa+O4wI9029ITy8s7kE6c8bRP8hvdrSiQRCOXCgqcoO7mdMr7xzXp0l10Mv+f28LW9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MW3PR11MB4651.namprd11.prod.outlook.com (2603:10b6:303:2c::21)
 by MWHPR1101MB2317.namprd11.prod.outlook.com (2603:10b6:301:5b::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.25; Sun, 13 Mar
 2022 12:12:22 +0000
Received: from MW3PR11MB4651.namprd11.prod.outlook.com
 ([fe80::b03c:fa42:ac18:7fc3]) by MW3PR11MB4651.namprd11.prod.outlook.com
 ([fe80::b03c:fa42:ac18:7fc3%7]) with mapi id 15.20.5061.026; Sun, 13 Mar 2022
 12:12:21 +0000
From:   "Usyskin, Alexander" <alexander.usyskin@intel.com>
To:     "Ceraolo Spurio, Daniele" <daniele.ceraolospurio@intel.com>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        "Vivi, Rodrigo" <rodrigo.vivi@intel.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        "Tvrtko Ursulin" <tvrtko.ursulin@linux.intel.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Winkler, Tomas" <tomas.winkler@intel.com>,
        "Lubart, Vitaly" <vitaly.lubart@intel.com>,
        "intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>
Subject: RE: [Intel-gfx] [PATCH v10 3/5] mei: gsc: setup char driver alive in
 spite of firmware handshake failure
Thread-Topic: [Intel-gfx] [PATCH v10 3/5] mei: gsc: setup char driver alive in
 spite of firmware handshake failure
Thread-Index: AQHYMwr2NdfBBCVjMkaZRBOpwGWhEqy3xW+AgAV653A=
Date:   Sun, 13 Mar 2022 12:12:21 +0000
Message-ID: <MW3PR11MB4651F1ABDD3C5A838A6A8440ED0E9@MW3PR11MB4651.namprd11.prod.outlook.com>
References: <20220308163654.942820-1-alexander.usyskin@intel.com>
 <20220308163654.942820-4-alexander.usyskin@intel.com>
 <8a8f7205-32c1-0618-a29a-c3ef66357681@intel.com>
In-Reply-To: <8a8f7205-32c1-0618-a29a-c3ef66357681@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-reaction: no-action
dlp-version: 11.6.401.20
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: fbb3a64f-a357-474a-699d-08da04eaba27
x-ms-traffictypediagnostic: MWHPR1101MB2317:EE_
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-microsoft-antispam-prvs: <MWHPR1101MB2317B631707A8091B2039D96ED0E9@MWHPR1101MB2317.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Lc8B3M8fz+6gXGp2a0vW0gqabKL2lvogrLY2z6gnY9Jp8r1un5qgTqkbEvMd1qw4r1QOBNwMd+Y2mA3V2dsEW73QcMtLk2hSgMCGnpUw5HUUdzGVnNQ4+R2HWMgYLXlLmbfhYRQOPFz3+F1XomNO/+2ab3URx7nMLm/CgyRadcKjsRCbGqDNcYgppnsTiibUPHq7HvODypZtLicst9ilpU1f8cuIzEg+dZullzDDktSwn6fa/8Lb6Psz2KwXe02AFrrvev5a5x3OHSJvjZE5paGUQp2/vVRLraiFGvnMGCpuRNtACcFdFyIYdK5Kl5ipS0Ogh+GvVEL66Ap9DKlF7ZsfMc79GFYD1+pThEokCwaEXPRCPs5G2eRnS7PQH9JHxW/txlxrK+Rd5mKRvB0FlWmI7tGm7spG8xWpM0OMMrbyvg6vkxr+n68OPDu5MJUVBi9VGUGwR59JkHihXgS7HZ4vmGq8tgbS3e1BzN9GNn/pHs4mTuU/9Q0F6rIwupKTJzetV2NmNlrt9YGEdyZ+PhigEnSsdntjhoGgvQXmcNLtS0GofzJ9/rUB8g1bFvsGDe66zzGGtl8OQ2s7cWVg0WAFEOIk+unPO/AUqOgs+/Eyrzx3F6mZszMnbO1Bbv44IbZ+ygqxOzGVcoJ4+eFrTpZo04DZHoNxb3kLFgAXLjZYs/56ZyWmoKdIoaQDW8l3qWCkY6lFdMpvXSjDKvmTaL4iKwTA9OwoWMHkocnrTIg=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR11MB4651.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(9686003)(53546011)(54906003)(83380400001)(7696005)(6506007)(33656002)(110136005)(508600001)(71200400001)(8676002)(82960400001)(186003)(26005)(66476007)(64756008)(122000001)(66946007)(66556008)(921005)(66446008)(4326008)(38100700002)(76116006)(55016003)(38070700005)(8936002)(52536014)(86362001)(5660300002)(2906002)(316002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aGlMMkxSWGNqclZEUnVWZ3loRjZsUjN1Y1Z2Ylcya0ZQazZSR2d5dFFUV0RY?=
 =?utf-8?B?SFRSKzBaY25uWVd4S0JJVm4rcUE0TVNFOU00bUxvcFFEUnFlcVRKbXlxSmdZ?=
 =?utf-8?B?dE01cGQvZTEvOTYwR3FleDFMZHp0dVpIdnRMbmR0MHFxTjFGSThENUd6RmRt?=
 =?utf-8?B?ODliYmJMUk10NFVBRGlBSWpFZkJuRExHVUdJUTNOZlNzM3NyZXFYdU5PbUx2?=
 =?utf-8?B?N0RFZ0QrYm9FajlvaGhuR3ErcXhXWll1RFZFMXBiclZnTVJlc1BhN2dRdEpw?=
 =?utf-8?B?d0pVNEQ4NkRGZlFqUllLbkx1c0hUZWFIbEMrMmM2aTRwOW0zRWR6S3pZSkZK?=
 =?utf-8?B?RzRoSFZORnF5UXNGVFJYa1dHOTM2TlNZelRUZmwxOWtnbmZDL1MrUk5zWGRp?=
 =?utf-8?B?RG9lY1F3cHRXSlA5dytRcnNzbFpMWDgxamc5VWtGT3dsd2g1L09iV0QycjMv?=
 =?utf-8?B?SHZ5bUd4bUd5MVpLdWw2eldmK2tVZU5BRldDa2NrbDd0UStzVkpNYVRUSlVv?=
 =?utf-8?B?RUJ4cno3a1lsYnd6TUh3K1VDV00rNmY5TERCRGtrQ3RqUmtDS243c05qWFNG?=
 =?utf-8?B?cWI5WlZQSVBYbVpuS2hmaUtxdTMzMXBxTHNUTElQZkhKSmd2V3Urb3R0UTly?=
 =?utf-8?B?RXo0ODJxYjNmclJQTUF0QXV0VW9jZDFpZXlaK0kvSy9ZYURMK2xGWVVmdEoz?=
 =?utf-8?B?ZkthQlJoMEpQdXNuaDYvYXMxMzJIVkxzck1kYVdLQkpzSWl1dzBKb3F5WHp5?=
 =?utf-8?B?eGtnelpCbTh0M0xRTWpaczJMd1dQOWNQYThBQnNxSGpxdUIvaWhuN2pKSy9i?=
 =?utf-8?B?TXFzVmtqMUFwZ0EwUHI5YWdiSE9hL0ljY05HUmJQWWFJN3l4Z3dyY1JtOGp6?=
 =?utf-8?B?c3hTMVNuU2Q1Y2lXczZSd3d6NzF6dCtGODZYNTdObm1mWEZWY1FHZTN5bnc3?=
 =?utf-8?B?dzlYdnpZVVUrdGNKd210Y0VVckFWQTZvUWcvT3gwaGNtMk1nU3hsbjJYMmo5?=
 =?utf-8?B?TVA2TFJjRDVxc1VuRzFvd21rV3M5SDg4ckRUU1lNSEVDMkgyOVljcldlODQz?=
 =?utf-8?B?dVpSdnpDUFV6M0trc29wM21mSzBHWDY3UHc5d1VCa0pER0NvZWZYbVd0MnFP?=
 =?utf-8?B?L3ZIV3BsR1dXSWlYVHlVaEIwZFV3NVF1MFovMXd2MXpQNVNNQzI3K0drNGo1?=
 =?utf-8?B?UDJUMkMvQmZNRUZrUmRaWWswMm1KMWJMYisxY2Z0dXhRYStPUm5lUDVOcGZW?=
 =?utf-8?B?SEVBaHBUSkNuYVRyMnV5ejJHZFN1WGIralhkS1JyVDRObS9kdGlmeVd1ZUJR?=
 =?utf-8?B?NGNmVGFyQ3F3YytTdzltQjBLSVhVWVF3aUJlSy91MG1sRGVaamVvMlpnVGVK?=
 =?utf-8?B?VTFlajFQNVFsU0lqL1N0MzVuaXZBTWcrNUk3M2M4UW1MYUxkZlZGZW1lRWZI?=
 =?utf-8?B?K055d3R4VzA3VnJRalNsR0V5eVdtNnAyNStUL1o2WnIrdEVRRy9DTkJ4UCt1?=
 =?utf-8?B?T0F0aDB6RTUyOFlvdlJxYldjNmIybmFINXdwdDNselVnczdPWmN6TGRmd0Q2?=
 =?utf-8?B?cHdIWnhPYWJhTjNxVFJ2OFBRMUdZSHFoaHp3VDduNVdOMXB3U1BsVFNVYnVv?=
 =?utf-8?B?OHZrc3hiZjBYZlpxR0ZobzNyUW5pUU1MN211NlkyNEsrVHkyYUVYckFUUGJK?=
 =?utf-8?B?K3RwM3ZWNHRFQ3BDS2hGU0sxRkJFUk9xd3VsWG5GVG15VlJYV0I3cnlFcmtu?=
 =?utf-8?B?aEtHUkxvY0xEY2ZpSEZFV3FGVlFiYXVrdzF3dk9sOHE1c1NiVSsxSVkwOXM3?=
 =?utf-8?B?VURYUUxWTWlBOUViVFVvYzdUZEdqUUw4cW9zcno3T0xJYzNHY2YvOFZIRFcx?=
 =?utf-8?B?QWlDWVNZQkxvUGhnL29yUHhQdDhsMjEra0VDaHpab3FpV2tpYWxjSndVMHRX?=
 =?utf-8?B?aDM1Z09ZQnR6eUhwQmw5dVlCd1d2aFA1RHFoUWtPV0dBV1hOZXYyTnEzZ1Y4?=
 =?utf-8?B?TkhiNUd6YnhRPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW3PR11MB4651.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fbb3a64f-a357-474a-699d-08da04eaba27
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Mar 2022 12:12:21.6944
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: F74q/HsMP2gqQSfBs+7vXPFRapweWaBdOiIbj3/tUkGv6vg8b82lg/eI/x+n8mcvxLHhN6QXLsTSx5GhKBdyx+NuNW6c1IS8oSLtjT/WvwQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1101MB2317
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogQ2VyYW9sbyBTcHVyaW8s
IERhbmllbGUgPGRhbmllbGUuY2VyYW9sb3NwdXJpb0BpbnRlbC5jb20+DQo+IFNlbnQ6IFRodXJz
ZGF5LCBNYXJjaCAxMCwgMjAyMiAwMjoyOA0KPiBUbzogVXN5c2tpbiwgQWxleGFuZGVyIDxhbGV4
YW5kZXIudXN5c2tpbkBpbnRlbC5jb20+OyBHcmVnIEtyb2FoLQ0KPiBIYXJ0bWFuIDxncmVna2hA
bGludXhmb3VuZGF0aW9uLm9yZz47IEphbmkgTmlrdWxhDQo+IDxqYW5pLm5pa3VsYUBsaW51eC5p
bnRlbC5jb20+OyBKb29uYXMgTGFodGluZW4NCj4gPGpvb25hcy5sYWh0aW5lbkBsaW51eC5pbnRl
bC5jb20+OyBWaXZpLCBSb2RyaWdvIDxyb2RyaWdvLnZpdmlAaW50ZWwuY29tPjsNCj4gRGF2aWQg
QWlybGllIDxhaXJsaWVkQGxpbnV4LmllPjsgRGFuaWVsIFZldHRlciA8ZGFuaWVsQGZmd2xsLmNo
PjsgVHZydGtvDQo+IFVyc3VsaW4gPHR2cnRrby51cnN1bGluQGxpbnV4LmludGVsLmNvbT4NCj4g
Q2M6IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IFdpbmtsZXIsIFRvbWFzDQo+IDx0b21h
cy53aW5rbGVyQGludGVsLmNvbT47IEx1YmFydCwgVml0YWx5IDx2aXRhbHkubHViYXJ0QGludGVs
LmNvbT47IGludGVsLQ0KPiBnZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnDQo+IFN1YmplY3Q6IFJl
OiBbSW50ZWwtZ2Z4XSBbUEFUQ0ggdjEwIDMvNV0gbWVpOiBnc2M6IHNldHVwIGNoYXIgZHJpdmVy
IGFsaXZlIGluDQo+IHNwaXRlIG9mIGZpcm13YXJlIGhhbmRzaGFrZSBmYWlsdXJlDQo+IA0KPiAN
Cj4gDQo+IE9uIDMvOC8yMDIyIDg6MzYgQU0sIEFsZXhhbmRlciBVc3lza2luIHdyb3RlOg0KPiA+
IFNldHVwIGNoYXIgZGV2aWNlIGluIHNwaXRlIG9mIGZpcm13YXJlIGhhbmRzaGFrZSBmYWlsdXJl
Lg0KPiA+IEluIG9yZGVyIHRvIHByb3ZpZGUgaG9zdCBhY2Nlc3MgdG8gdGhlIGZpcm13YXJlIHN0
YXR1cyByZWdpc3RlcnMgYW5kIG90aGVyDQo+ID4gaW5mb3JtYXRpb24gcmVxdWlyZWQgZm9yIHRo
ZSBtYW51ZmFjdHVyaW5nIHByb2Nlc3MuDQo+IA0KPiBJTU8gdGhpcyBwYXRjaCBzaG91bGQgYmUg
bW92ZWQgdG8gYWZ0ZXIgdGhlIHBhdGNoIHRoYXQgYWRkcyB0aGUgbG9naWMgdG8NCj4gZmV0Y2gg
dGhlIEZXIHZlcnNpb24sIGFzIHRoYXQgaXMgaW50ZXJlc3RpbmcgaW5mbyBmb3Igc3lzZnMuIE5v
dCBhIGJsb2NrZXIuDQo+IA0KDQpBY3R1YWxseSwgdGhlIEZXIHZlcnNpb24gaXMgZmlsbGVkIG9u
bHkgaWYgdGhlcmUgaXMgYW4gZXN0YWJsaXNoZWQgY2hhbm5lbCB3aXRoIEZXLg0KRmlybXdhcmUg
c3RhdHVzIHJlZ2lzdGVycyBhcmUgdGhlIGNydWNpYWwgaW5mb3JtYXRpb24gZm9yIGRlYnVnLCBh
bmQgaXQgZmlsbGVkDQppbiBwcmV2aW91cyBwYXRjaGVzLg0KDQotLSANClRoYW5rcywNClNhc2hh
DQoNCg0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogQWxleGFuZGVyIFVzeXNraW4gPGFsZXhhbmRl
ci51c3lza2luQGludGVsLmNvbT4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBUb21hcyBXaW5rbGVyIDx0
b21hcy53aW5rbGVyQGludGVsLmNvbT4NCj4gDQo+IFJldmlld2VkLWJ5OiBEYW5pZWxlIENlcmFv
bG8gU3B1cmlvIDxkYW5pZWxlLmNlcmFvbG9zcHVyaW9AaW50ZWwuY29tPg0KPiANCj4gRGFuaWVs
ZQ0KPiANCj4gPiAtLS0NCj4gPiAgIGRyaXZlcnMvbWlzYy9tZWkvZ3NjLW1lLmMgfCAxMSArKysr
KystLS0tLQ0KPiA+ICAgMSBmaWxlIGNoYW5nZWQsIDYgaW5zZXJ0aW9ucygrKSwgNSBkZWxldGlv
bnMoLSkNCj4gPg0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL21pc2MvbWVpL2dzYy1tZS5jIGIv
ZHJpdmVycy9taXNjL21laS9nc2MtbWUuYw0KPiA+IGluZGV4IDBhZmFlNzBlMDYwOS4uY2Y0Mjdm
NmZkZWM5IDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvbWlzYy9tZWkvZ3NjLW1lLmMNCj4gPiAr
KysgYi9kcml2ZXJzL21pc2MvbWVpL2dzYy1tZS5jDQo+ID4gQEAgLTc5LDExICs3OSwxMiBAQCBz
dGF0aWMgaW50IG1laV9nc2NfcHJvYmUoc3RydWN0IGF1eGlsaWFyeV9kZXZpY2UNCj4gKmF1eF9k
ZXYsDQo+ID4gICAJcG1fcnVudGltZV9zZXRfYWN0aXZlKGRldmljZSk7DQo+ID4gICAJcG1fcnVu
dGltZV9lbmFibGUoZGV2aWNlKTsNCj4gPg0KPiA+IC0JaWYgKG1laV9zdGFydChkZXYpKSB7DQo+
ID4gLQkJZGV2X2VycihkZXZpY2UsICJpbml0IGh3IGZhaWx1cmUuXG4iKTsNCj4gPiAtCQlyZXQg
PSAtRU5PREVWOw0KPiA+IC0JCWdvdG8gZXJyOw0KPiA+IC0JfQ0KPiA+ICsJLyogQ29udGludWUg
dG8gY2hhciBkZXZpY2Ugc2V0dXAgaW4gc3BpdGUgb2YgZmlybXdhcmUgaGFuZHNoYWtlDQo+IGZh
aWx1cmUuDQo+ID4gKwkgKiBJbiBvcmRlciB0byBwcm92aWRlIGFjY2VzcyB0byB0aGUgZmlybXdh
cmUgc3RhdHVzIHJlZ2lzdGVycyB0byB0aGUNCj4gdXNlcg0KPiA+ICsJICogc3BhY2UgdmlhIHN5
c2ZzLg0KPiA+ICsJICovDQo+ID4gKwlpZiAobWVpX3N0YXJ0KGRldikpDQo+ID4gKwkJZGV2X3dh
cm4oZGV2aWNlLCAiaW5pdCBodyBmYWlsdXJlLlxuIik7DQo+ID4NCj4gPiAgIAlwbV9ydW50aW1l
X3NldF9hdXRvc3VzcGVuZF9kZWxheShkZXZpY2UsDQo+IE1FSV9HU0NfUlBNX1RJTUVPVVQpOw0K
PiA+ICAgCXBtX3J1bnRpbWVfdXNlX2F1dG9zdXNwZW5kKGRldmljZSk7DQoNCg==
