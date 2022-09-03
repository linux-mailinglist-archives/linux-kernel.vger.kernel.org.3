Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7ABF5ABE66
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Sep 2022 12:07:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230329AbiICKFS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Sep 2022 06:05:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229694AbiICKFP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Sep 2022 06:05:15 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63A3F28709
        for <linux-kernel@vger.kernel.org>; Sat,  3 Sep 2022 03:05:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662199513; x=1693735513;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=/yDD8b3a24ikPTNLN6+8WpxVNZI+iJY46wh8uCr5S9I=;
  b=Nl7o1HJCbmCzOxDYEczEJhWQpy9PGPOlJRH5LCaESL8av9XKsJOTGLI8
   0+pxfhS63U9BPyWuCFOm48ZKir+jriAB519PQf6GJv6dFhk/qWxnpU2bF
   /KuKKByadsracHiVnQyPTx9hnzcvRuhlJMnvDh8SHHjAIfdmZHVbwqqYl
   FCwbOba+MygLIEWtvY79n8TvzK0nSPGG6YmUA98MAkqvpAYBYXQ5gtGos
   xdNfVOGRMDCacC6lzWCQytIUtM90apbudhpnqNt+qzvFrs/ORTV0EVuWw
   RiwP/2TJN+xEcwYIE1DtC5WHmhqOnfj2iieDlWp+T9gasXhkNR1H+GL/w
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10458"; a="296152572"
X-IronPort-AV: E=Sophos;i="5.93,287,1654585200"; 
   d="scan'208";a="296152572"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2022 03:05:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,287,1654585200"; 
   d="scan'208";a="788915270"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga005.jf.intel.com with ESMTP; 03 Sep 2022 03:05:12 -0700
Received: from orsmsx608.amr.corp.intel.com (10.22.229.21) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Sat, 3 Sep 2022 03:05:12 -0700
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX608.amr.corp.intel.com (10.22.229.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Sat, 3 Sep 2022 03:05:12 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Sat, 3 Sep 2022 03:05:12 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.104)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Sat, 3 Sep 2022 03:05:12 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ff0yjqHvEuDr+HvgntnqM7Ppqa4Sa23ggMSS47cwvilGVvdREa9m4IhhYV4BZmqwIMpKtvUotfz2aOV3Kgogjdf+gwRA/Uw8dgKN+ItVMpcpHiNqfHGeHJihPsNIkw3nFOdFBdpmZhHlhGWEmr3nA7qD+GXB3XNIa2q/CUAeveu8Toii8ZIKmODE5lw/F3WuyUaql3YOv9GEWsN7EX3qhieEpFwgTWiYCf0VNwUkTewqFxLYy0GGqKgMGObRn7PBFW+hODCaXk3ZyRZH75H3xpuSw4m1QQaHAXdZBrFbkILW0/fW9AV80ArpXIiIs8dl0nRYHNolkRvROerOsoRjGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/yDD8b3a24ikPTNLN6+8WpxVNZI+iJY46wh8uCr5S9I=;
 b=FDRhaNiz9xRmxCnzM8AWXC2RDmBPxnXD7ATvdr+j1YQwZQO3aDUzQYOwDHo/ISLxnbXJFXHUiAioc06JrfJAsKTH0HNyU+GfdNZC9osDha5Olo5JJ5D9ESipQk9UBvfiL+7EUtmXZ2IeIK8a7UTRF0UWgVyxjyNUjyIcv+UzP521UyhvINQMaDGIcyFynn+IV3jPVNvqE8K8jW/SXOEZuVPb5P5NhDYQk5OhtOV/kfVgXakL6fEDoCXOPAHYXIUZgrmApqpXFVjBPdoiK6rOHUXhKxMjdvJ00sj22VDm2HobAZZcBWKnJmrOsHHBfFcYaIYkJxRpJYoXEMD1EwPZoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN2PR11MB4093.namprd11.prod.outlook.com (2603:10b6:208:13f::21)
 by DS7PR11MB5967.namprd11.prod.outlook.com (2603:10b6:8:72::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.14; Sat, 3 Sep
 2022 10:05:10 +0000
Received: from MN2PR11MB4093.namprd11.prod.outlook.com
 ([fe80::f18d:2e17:c60e:5aa3]) by MN2PR11MB4093.namprd11.prod.outlook.com
 ([fe80::f18d:2e17:c60e:5aa3%5]) with mapi id 15.20.5588.015; Sat, 3 Sep 2022
 10:05:10 +0000
From:   "Winkler, Tomas" <tomas.winkler@intel.com>
To:     "Ceraolo Spurio, Daniele" <daniele.ceraolospurio@intel.com>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
CC:     "intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>,
        "Usyskin, Alexander" <alexander.usyskin@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Vivi, Rodrigo" <rodrigo.vivi@intel.com>,
        "Lubart, Vitaly" <vitaly.lubart@intel.com>
Subject: RE: [Intel-gfx] [PATCH v7 09/15] mei: bus: export common mkhi
 definitions into a separate header
Thread-Topic: [Intel-gfx] [PATCH v7 09/15] mei: bus: export common mkhi
 definitions into a separate header
Thread-Index: AQHYqY/0w8b4vsRH7UuJIH4xXhnFQa3LNu8AgAJuTWA=
Date:   Sat, 3 Sep 2022 10:05:10 +0000
Message-ID: <MN2PR11MB4093E5E9A25685F80AA961BCE57D9@MN2PR11MB4093.namprd11.prod.outlook.com>
References: <20220806122636.43068-1-tomas.winkler@intel.com>
 <20220806122636.43068-10-tomas.winkler@intel.com>
 <502899ee-07a7-cebb-b730-7c5888de2ce9@intel.com>
In-Reply-To: <502899ee-07a7-cebb-b730-7c5888de2ce9@intel.com>
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
x-ms-office365-filtering-correlation-id: 26de6385-0d0e-4cd9-d0d8-08da8d93c930
x-ms-traffictypediagnostic: DS7PR11MB5967:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: GU19InQpVpMqDlIIxWK8yICcAPzGMf7LIevNEFx2lArCZgWIzdaNdjV6Xa6X5qjx0n81ECsJ+Un4HV56TWawIQ8mXPhPqSmTUtQOUQE+gQhRD+I+APkgoMjbr3jfmudBGN/Q+gAsJ/RfgdypWdnGdEaAWyIEJ6Ekaa3WT1IlZoqbHDmrJoXd4uCiywxV2UDLCqr/xOOiQl4Nw/n4YDtRP845XpdMTk53fljeQ7EvaZnELAYGE7YGq4uieHsgNHELUkdTrmotexz7Pyqqv5C3ZsDYRe1hojK/h+W435/HfBAC6Qx+kKIGS9HxgH8VIvl5EEfn1W1w8Hf/mnRvZ2fvf55BbT/Bi3lKETRMNcgn+viitWFl7ExUhTEtuUjG0n4tCDfMijkyNwPpKWujXyBwy2AJagOQkGJNI7ua9ZVKJ9cHiUcd6Sin9Zsoz3ddQEAl0/NV5sA181f9svG0hOtKjSIVDV55lE3kXWrvc2mqmN1lfKzGoE4TCuYxsQa/eB7vVXEqvdIg1/SZLemZwsPERwHVccXHG1KI/q2Nzqu3nNW1DYn/u8GsArQ+p4ZNKgAjSB+B80YakLrADL77zYaQYHRbcAriNySHTE4fxduLDAbkyHnc7f/MciGIulxXBvM7zgznjT/Hbu0ETk2CyA4oFCOzz+8QmxnpLACnXRcjJRYzJx56XuQH8Iz1qRU1JN4HU+g7KfQKOd8+pNZTxfKj/PaKDWrUBkiAFg+R13HnnNE6OW/Sxj0+p0L34WwFh6GSdZzNB/sEi2B5YBqdQq/PZA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR11MB4093.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(366004)(136003)(376002)(346002)(396003)(39860400002)(55016003)(26005)(83380400001)(38070700005)(33656002)(82960400001)(66446008)(122000001)(478600001)(66476007)(38100700002)(4326008)(76116006)(8676002)(64756008)(86362001)(71200400001)(8936002)(52536014)(5660300002)(41300700001)(53546011)(66946007)(110136005)(54906003)(6506007)(66556008)(316002)(7696005)(186003)(107886003)(9686003)(2906002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ckdudlFpam9VcDB6SE9JVVRaY0lnVkN0QzRNRmloQzEyT0p6dU9EaTJkSVc4?=
 =?utf-8?B?ZFRIOVNhR0NoK3JQaHBsT2svMUE5WkJDdno5cDB6bURnQnp3c0lDOVh2TERW?=
 =?utf-8?B?c1hOMGc2aE8vZHdxU2NhRDVlblU5K3BIWTVyak96QnJIbkhTQlROQlRYUk1W?=
 =?utf-8?B?enFPdEs2aER3T0FpOFExWUZsOEQ1RWVIanI4ZWYvaDc2a3ZTNCs4eWdUVFQy?=
 =?utf-8?B?NXlFMjdwWmpsYUhCZkh1RWZnaWRtSzBHQlNxa1JGZkdacWl6REVMM2laODR3?=
 =?utf-8?B?N2hHb3BGajNKL3NyaXlpVS9SNnBuNzB1QlFwWGQxWW9SK2lrWmNhNjlqelox?=
 =?utf-8?B?QmRXbkl5c3ViSmRKbm4raGJSTUtLL1JUM0cxMzZFQjkvODJUNVdPUm5SMHlm?=
 =?utf-8?B?TjZLdC9OUjlRU0JNRXhHVjY3K2QwQWN4OExDN1ZDbmgzUk10bmxOWVRySnBP?=
 =?utf-8?B?dmJMVW1MNVROajFVYXJZeGFkZ0pXczdWZms2emZwcWNxRUFoNWZadnVaNkxB?=
 =?utf-8?B?THp3dDl2SC9RZUQ3VDZPeFJTYVBDQW84TnFBNSszaXBtcldqRWhMSXQrd0dY?=
 =?utf-8?B?L0F4TDBoUkdpaWJQWmViUFdNSjF5emt2eTYxamUwb0VhTG1PeTZQeDhpZlVL?=
 =?utf-8?B?TXl0YmNRYTlKb0FsYWNib3Q5WkhwdHlLREhudHJnSmo0SENkYWN4cjB2SE8y?=
 =?utf-8?B?V0NkV2Q1YVhJci8zajhQVUpHOWl3M09uN0xVUm4yY0lPOWF4ckZqNGczU1lD?=
 =?utf-8?B?V3p5R3VtNTNvb0xIUnRwL1hpYWNkeDk1WmRyYWcyRFNqNVo2UEdONkJ6czZI?=
 =?utf-8?B?NVJUckNxTzMrS1MxNVo0TlFuUDIwR083MnBrY0U3RC9wMEVwRzEzV2RKSUlH?=
 =?utf-8?B?ZWNXZ1VwM1F3QWRJa0FZSE1BRlBCcFlSYzgrTkIxZkNSYUpoMjQzbVY4Y0FV?=
 =?utf-8?B?czJRUFlDcmN0WjdUa1BVOUgwQzRybTZkUnQxcFlaR2ltQytyeU1sMjFncGhx?=
 =?utf-8?B?TkErcEJPOVoySnpaUG41L3FXOWN0Z3d4a1NpU1VGVTlZTDJXTDQ5dHpnQjRX?=
 =?utf-8?B?NDFYVzhDU1J6ZWZqdkxxblhVZUJHYnA2V2IyZnRQQVF2OTd5NzdlNG1KMEtP?=
 =?utf-8?B?dmdGWlJTVTRUWFFyMHZoaWNHYzgyNEJDenpESy82ZURZVkxvY3BtYVVMSG52?=
 =?utf-8?B?L041Qm9yRm55U3VWTzlMQXVPYTRPZ1dhbmFxbzdNYnE4eVpYTkVkMmJIMVk2?=
 =?utf-8?B?NHYxMUs5My9adHNPcXpka3Z6bEgvM2JzSTRUMVFWL012QVpySmhidVV3QU9X?=
 =?utf-8?B?cUNBNjF4b29xMHlybnliZ0lVOVc1Z3dLQXI2ZUxjNjFPajQ2cEpiR3lySjRL?=
 =?utf-8?B?Ty9OaVU4NlZPRGk1blNTU3FnbUlyeWNJLzNGK05Odk8rR0I0TFd0QjVGRHNn?=
 =?utf-8?B?N3JUbzhVcFNqaWZDNFpKV01NZ0YxRTJpTU5TUE9xQTJkbVE0VlowTTloK0JZ?=
 =?utf-8?B?YkVxRm1nckRienVEZWhiZE1HbEdvZlBTbTZNTnNOWnZhUEhYSHN1R3l5dndU?=
 =?utf-8?B?OGlaN1pTU3EzclR2a3p3c2psTENMQzdaWVV6MVhydyt4aEpuYzFPSUVTbkJQ?=
 =?utf-8?B?RVoxZG1PamszQ01CYjY2RVN6a2lybnBQYmJqOE5aWUlZU3hVM1JSVkxTc3ZD?=
 =?utf-8?B?bGU5OWJhOEpCaStxSGdVcEVyRXA1WURpdFNtNFdJSk1Ya0tUSWVRZUhCeUlJ?=
 =?utf-8?B?RFVHVkUrRUJJcGdyS3hoS213a3cyUmpzMldnV0E0OVNWZXFmOUZaQkh5L2RU?=
 =?utf-8?B?Yis2NzFTdEdGaGxPZE9zL3pwbmg4N0dZUDU0VE0zcEpCcWxHeUtMVzZBYitM?=
 =?utf-8?B?SGtmeDhxR21pTXVzTi9tWW9Hb3Q5cmJlSi8yM0JnQ0k1c0owK0wxNkE3K21k?=
 =?utf-8?B?OFRYeDBOTUgyTDRrLy91N1hGQ1lZZ2VhWk16V0JFNnNIYmpVQ2VjZzFsZkRS?=
 =?utf-8?B?aWYvL1RqMGUrZXhxZzlNdDFzQTRYR0pyZ2dUWnR1VGVxZDM2aHdpZmtXM3Jq?=
 =?utf-8?B?cnlLTDZ4aVZKT3ZPOHhxQUpTWSs1UkJ3aWI1RVpjL0RYNVdnK3R5aDJUU01T?=
 =?utf-8?Q?EUX9684YhgTpBzvYU4v4JEITt?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR11MB4093.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 26de6385-0d0e-4cd9-d0d8-08da8d93c930
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Sep 2022 10:05:10.1318
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /lA373oy2CFvOfVS6dTeA/ILsDXapGTzwiGZ698Yoq4XPONQAjd0/lvZVkP+xsEMXdYuHgjIqoOK6tFdDVGIyQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB5967
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQo+IA0KPiANCj4gT24gOC82LzIwMjIgNToyNiBBTSwgVG9tYXMgV2lua2xlciB3cm90ZToNCj4g
PiBGcm9tOiBWaXRhbHkgTHViYXJ0IDx2aXRhbHkubHViYXJ0QGludGVsLmNvbT4NCj4gPg0KPiA+
IEV4cG9ydGVkIGNvbW1vbiBta2hpIGRlZmluaXRpb25zIGZyb20gYnVzLWZpeHVwLmMgaW50byBh
IHNlcGFyYXRlDQo+ID4gaGVhZGVyIGZpbGUgbWtoaS5oIGZvciBvdGhlciBkcml2ZXIgdXNhZ2Uu
DQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBWaXRhbHkgTHViYXJ0IDx2aXRhbHkubHViYXJ0QGlu
dGVsLmNvbT4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBUb21hcyBXaW5rbGVyIDx0b21hcy53aW5rbGVy
QGludGVsLmNvbT4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBBbGV4YW5kZXIgVXN5c2tpbiA8YWxleGFu
ZGVyLnVzeXNraW5AaW50ZWwuY29tPg0KPiA+IC0tLQ0KPiA+ICAgZHJpdmVycy9taXNjL21laS9i
dXMtZml4dXAuYyB8IDMxICstLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0NCj4gPiAgIGRyaXZlcnMv
bWlzYy9tZWkvbWtoaS5oICAgICAgfCA0NQ0KPiArKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysNCj4gPiAgIDIgZmlsZXMgY2hhbmdlZCwgNDYgaW5zZXJ0aW9ucygrKSwgMzAgZGVs
ZXRpb25zKC0pDQo+ID4gICBjcmVhdGUgbW9kZSAxMDA2NDQgZHJpdmVycy9taXNjL21laS9ta2hp
LmgNCj4gPg0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL21pc2MvbWVpL2J1cy1maXh1cC5jDQo+
ID4gYi9kcml2ZXJzL21pc2MvbWVpL2J1cy1maXh1cC5jIGluZGV4IDI0ZTkxYTllYTU1OC4uODEx
Yzk0ZWJmMjUwIDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvbWlzYy9tZWkvYnVzLWZpeHVwLmMN
Cj4gPiArKysgYi9kcml2ZXJzL21pc2MvbWVpL2J1cy1maXh1cC5jDQo+ID4gQEAgLTE1LDYgKzE1
LDcgQEANCj4gPg0KPiA+ICAgI2luY2x1ZGUgIm1laV9kZXYuaCINCj4gPiAgICNpbmNsdWRlICJj
bGllbnQuaCINCj4gPiArI2luY2x1ZGUgIm1raGkuaCINCj4gPg0KPiA+ICAgI2RlZmluZSBNRUlf
VVVJRF9ORkNfSU5GTyBVVUlEX0xFKDB4ZDJkZTE2MjUsIDB4MzgyZCwgMHg0MTdkLCBcDQo+ID4g
ICAJCQkweDQ4LCAweGE0LCAweGVmLCAweGFiLCAweGJhLCAweDhhLCAweDEyLCAweDA2KSBAQCAt
DQo+IDg5LDIwICs5MCw2DQo+ID4gQEAgc3RydWN0IG1laV9vc192ZXIgew0KPiA+ICAgCXU4ICBy
ZXNlcnZlZDI7DQo+ID4gICB9IF9fcGFja2VkOw0KPiA+DQo+ID4gLSNkZWZpbmUgTUtISV9GRUFU
VVJFX1BUVCAweDEwDQo+ID4gLQ0KPiA+IC1zdHJ1Y3QgbWtoaV9ydWxlX2lkIHsNCj4gPiAtCV9f
bGUxNiBydWxlX3R5cGU7DQo+ID4gLQl1OCBmZWF0dXJlX2lkOw0KPiA+IC0JdTggcmVzZXJ2ZWQ7
DQo+ID4gLX0gX19wYWNrZWQ7DQo+ID4gLQ0KPiA+IC1zdHJ1Y3QgbWtoaV9md2NhcHMgew0KPiA+
IC0Jc3RydWN0IG1raGlfcnVsZV9pZCBpZDsNCj4gPiAtCXU4IGxlbjsNCj4gPiAtCXU4IGRhdGFb
XTsNCj4gPiAtfSBfX3BhY2tlZDsNCj4gPiAtDQo+ID4gICBzdHJ1Y3QgbWtoaV9md192ZXJfYmxv
Y2sgew0KPiA+ICAgCXUxNiBtaW5vcjsNCj4gPiAgIAl1OCBtYWpvcjsNCj4gPiBAQCAtMTE1LDIy
ICsxMDIsNiBAQCBzdHJ1Y3QgbWtoaV9md192ZXIgew0KPiA+ICAgCXN0cnVjdCBta2hpX2Z3X3Zl
cl9ibG9jayB2ZXJbTUVJX01BWF9GV19WRVJfQkxPQ0tTXTsNCj4gPiAgIH0gX19wYWNrZWQ7DQo+
ID4NCj4gPiAtI2RlZmluZSBNS0hJX0ZXQ0FQU19HUk9VUF9JRCAweDMNCj4gPiAtI2RlZmluZSBN
S0hJX0ZXQ0FQU19TRVRfT1NfVkVSX0FQUF9SVUxFX0NNRCA2IC0jZGVmaW5lDQo+ID4gTUtISV9H
RU5fR1JPVVBfSUQgMHhGRiAtI2RlZmluZQ0KPiBNS0hJX0dFTl9HRVRfRldfVkVSU0lPTl9DTUQg
MHgyDQo+ID4gLXN0cnVjdCBta2hpX21zZ19oZHIgew0KPiA+IC0JdTggIGdyb3VwX2lkOw0KPiA+
IC0JdTggIGNvbW1hbmQ7DQo+ID4gLQl1OCAgcmVzZXJ2ZWQ7DQo+ID4gLQl1OCAgcmVzdWx0Ow0K
PiA+IC19IF9fcGFja2VkOw0KPiA+IC0NCj4gPiAtc3RydWN0IG1raGlfbXNnIHsNCj4gPiAtCXN0
cnVjdCBta2hpX21zZ19oZHIgaGRyOw0KPiA+IC0JdTggZGF0YVtdOw0KPiA+IC19IF9fcGFja2Vk
Ow0KPiA+IC0NCj4gPiAgICNkZWZpbmUgTUtISV9PU1ZFUl9CVUZfTEVOIChzaXplb2Yoc3RydWN0
IG1raGlfbXNnX2hkcikgKyBcDQo+ID4gICAJCQkgICAgc2l6ZW9mKHN0cnVjdCBta2hpX2Z3Y2Fw
cykgKyBcDQo+ID4gICAJCQkgICAgc2l6ZW9mKHN0cnVjdCBtZWlfb3NfdmVyKSkNCj4gPiBkaWZm
IC0tZ2l0IGEvZHJpdmVycy9taXNjL21laS9ta2hpLmggYi9kcml2ZXJzL21pc2MvbWVpL21raGku
aCBuZXcNCj4gPiBmaWxlIG1vZGUgMTAwNjQ0IGluZGV4IDAwMDAwMDAwMDAwMC4uMjdhOWI0NzY5
MDRlDQo+ID4gLS0tIC9kZXYvbnVsbA0KPiA+ICsrKyBiL2RyaXZlcnMvbWlzYy9tZWkvbWtoaS5o
DQo+ID4gQEAgLTAsMCArMSw0NSBAQA0KPiA+ICsvKiBTUERYLUxpY2Vuc2UtSWRlbnRpZmllcjog
R1BMLTIuMCAqLw0KPiA+ICsvKg0KPiA+ICsgKiBDb3B5cmlnaHQgKGMpIDIwMDMtMjAyMCwgSW50
ZWwgQ29ycG9yYXRpb24uIEFsbCByaWdodHMgcmVzZXJ2ZWQuDQo+IA0KPiAyMDIyIChjYW4gZml4
IHdoZW4gbWVyZ2luZykNCj4gDQo+ID4gKyAqIEludGVsIE1hbmFnZW1lbnQgRW5naW5lIEludGVy
ZmFjZSAoSW50ZWwgTUVJKSBMaW51eCBkcml2ZXIgKi8NCj4gPiArDQo+ID4gKyNpZm5kZWYgX01F
SV9NS0hJX0hfDQo+ID4gKyNkZWZpbmUgX01FSV9NS0hJX0hfDQo+ID4gKw0KPiA+ICsjaW5jbHVk
ZSAibWVpX2Rldi5oIg0KPiANCj4gQW55IHJlYXNvbiB5b3UgbmVlZCB0aGUgZnVsbCBtZWlfZGV2
LmggYW5kIG5vdCBqdXN0IGxpbnV4L3R5cGVzLmggPw0KPGxpbnV4L3R5cGVzLmg+IGlzIGVub3Vn
aCANCj4gDQo+ID4gKw0KPiA+ICsjZGVmaW5lIE1LSElfRkVBVFVSRV9QVFQgMHgxMA0KPiA+ICsN
Cj4gPiArI2RlZmluZSBNS0hJX0ZXQ0FQU19HUk9VUF9JRCAweDMNCj4gPiArI2RlZmluZSBNS0hJ
X0ZXQ0FQU19TRVRfT1NfVkVSX0FQUF9SVUxFX0NNRCA2ICNkZWZpbmUNCj4gPiArTUtISV9HRU5f
R1JPVVBfSUQgMHhGRiAjZGVmaW5lDQo+IE1LSElfR0VOX0dFVF9GV19WRVJTSU9OX0NNRCAweDIN
Cj4gPiArDQo+ID4gKyNkZWZpbmUgTUNISV9HUk9VUF9JRCAgMHhBDQo+IA0KPiBUaGlzIGlzIG5l
dyBhbmQgZG9lc24ndCBzZWVtIHRvIGJlIHVzZWQgaW4gZm9sbG93LXVwIHBhdGNoZXMuIEFueSBy
ZWFzb24gZm9yDQo+IGFkZGluZyBpdCBpbj8NCg0KDQpXaWxsIGRyb3AuIA0KDQo+IA0KPiBEYW5p
ZWxlDQo+IA0KDQo=
