Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22A6857417A
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 04:37:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231327AbiGNChJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 22:37:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbiGNChH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 22:37:07 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE1D7240BF;
        Wed, 13 Jul 2022 19:37:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657766226; x=1689302226;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=KGyhlx8ijij6/O83wbDpSxOaAiJ1CoLwfWuzdZ6AXUw=;
  b=dq8clzc8hKwIrLLv9RJuRndKx1xEvatvul6jaRiUdOd5VnCo3AMfYQXm
   jppFv3oQZCqep8Ossc++mk+6sxtqddTfHQTQmCcpCqVLdzvfwWel5CM+v
   C943FtkocVc13FgDhOis0hcIJZZ1D3v9q+mThbNeVPS9KzDXL50VghNtV
   fGvWi+kspkCVUQYsca+04eHfrHqxLkBqSUXjumkgZgIZEBNQ0EZMZ42IA
   yyLuypY4IV0of719TNKB5nCDRn4KqQQAkYYEYKCHEC/vPzwL+pxPMWIE5
   HpyZQXBc840p7MO5cp08c8Fi5BndpUzwSl5YTyLAgI+NQWc3cyMq7eClb
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10407"; a="282950385"
X-IronPort-AV: E=Sophos;i="5.92,269,1650956400"; 
   d="scan'208";a="282950385"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2022 19:36:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,269,1650956400"; 
   d="scan'208";a="628540787"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga001.jf.intel.com with ESMTP; 13 Jul 2022 19:36:54 -0700
Received: from fmsmsx609.amr.corp.intel.com (10.18.126.89) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Wed, 13 Jul 2022 19:36:53 -0700
Received: from fmsmsx605.amr.corp.intel.com (10.18.126.85) by
 fmsmsx609.amr.corp.intel.com (10.18.126.89) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Wed, 13 Jul 2022 19:36:53 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx605.amr.corp.intel.com (10.18.126.85) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Wed, 13 Jul 2022 19:36:53 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.169)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Wed, 13 Jul 2022 19:36:53 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MVfKbuOce3++KcJW8fWEA0B39f8mUecTkX5lJzEK8G9HFL+AXLHm5ibhvfxD5TgWkJJSeQ6Z8JgeYtL6gHMmmQL6pro0gPxNH+l48E7wSzeV43coOFFNBcBYT0DfSYQc0+j27t8GK3dFIH2u8vNeyick0he6ic6cHnFbTu5SS2fSv0ivandQjfE21ePFuulx4eA1DfDq5rvdiljH4Nyi28yx/FAy9KeiTOGG9yqEPtZ95CBRIL2WTk82T9WegIIgMGfQR+EzL3aZ0Hghj5TbWLXHcxb8+ZZG8rYgnonU+1A9Spw8aZ+hMKMztwnqnCvLthuFFH3jPk2cXbQQTwdabA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KGyhlx8ijij6/O83wbDpSxOaAiJ1CoLwfWuzdZ6AXUw=;
 b=EJXulBxsJK1CvdW1t/IDNPYhSuH24ohTCD0P0eRwWLjocyOwYR/GoAJILwTIsGL0LPYAh55qqOzDdS1oit8eoRWOS1lKRLbE62n24Slb2GHIXk/ikxijykUtjHnTHfy5CDTCo4b5WYeSiOyZ11oVnbxNC7kKt8ORgHI/BAMNaSjL+xcQTiDJUsv76t/j8lKCw0EVoO3/s5tNcKPEpfXghxmWIF3W0Qcgns7eoDxGRb0lfYjk5HNi7E8TVTQFlT4sjNp+sjFRFnXk73pHk7gfCbGIHCsFcLS5M6n+jCENmdVy/sb6/m+oNWn1+hfOv+FBx7Svn12b9aMMxYZyr4rJlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB4824.namprd11.prod.outlook.com (2603:10b6:510:38::13)
 by CY4PR1101MB2279.namprd11.prod.outlook.com (2603:10b6:910:17::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.23; Thu, 14 Jul
 2022 02:36:51 +0000
Received: from PH0PR11MB4824.namprd11.prod.outlook.com
 ([fe80::6569:5ac:5138:1bc6]) by PH0PR11MB4824.namprd11.prod.outlook.com
 ([fe80::6569:5ac:5138:1bc6%8]) with mapi id 15.20.5417.026; Thu, 14 Jul 2022
 02:36:50 +0000
From:   "Mi, Dapeng1" <dapeng1.mi@intel.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
CC:     "Michael S. Tsirkin" <mst@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>,
        "Bart Van Assche" <bvanassche@acm.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>
Subject: RE: [PATCH] cpuidle: Move cpuidle driver forward before acpi driver
 in Makefile
Thread-Topic: [PATCH] cpuidle: Move cpuidle driver forward before acpi driver
 in Makefile
Thread-Index: AQHYlpGUKmAjRm9DBkW5CrmRNbrVmq18lbSAgACLrhA=
Date:   Thu, 14 Jul 2022 02:36:50 +0000
Message-ID: <PH0PR11MB4824DAE06FE50711C3252D93CD889@PH0PR11MB4824.namprd11.prod.outlook.com>
References: <20220713082426.850911-1-dapeng1.mi@intel.com>
 <CAJZ5v0gsHPav5Ax6+9OMmeApqn7qdJPQmo5MMh=ba6Rtj5NnQA@mail.gmail.com>
In-Reply-To: <CAJZ5v0gsHPav5Ax6+9OMmeApqn7qdJPQmo5MMh=ba6Rtj5NnQA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-reaction: no-action
dlp-version: 11.6.500.17
dlp-product: dlpe-windows
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 52453988-4e95-4ab5-7a42-08da6541b4ee
x-ms-traffictypediagnostic: CY4PR1101MB2279:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 81obs+TXfIfJRvIMzScBeeMwx81EOut/MWrs/uXZaCiKsaE5Hn1m3Ca54hsH7qw9FTFLianz+/HzEdcEXLosx3pxUIwgHELJZ05BHv+Owf9fqHB4ThjVXqeKG8VR7kTSKw94vtYhgt/VJA8gPPeKuStbrYoNG2mwiA7q5lcNXHDMALSsxNR5MOCoQbqENR3Fl+FvDmRTSv/Ooci+1vcCcvrK02EajVKdCLBsyI5jcMdjCfQ52CJTjCmX5Pqg4+4AbglFys/urDAz+bwToVu0ruDno8B+MasC8s0jQvv12nBQtrWI7k1EYo2anbkAuTDcbBNtRDPS2jOZ7YUkGAL0i7qS3MSIUHVKEb8UvyvVkYP8jn8DN7WloIevsXUUMAIJV9EmxI9SPbQsad6m6uFsElbhibUzOOI2KcrXyjPvQRX2zFv95CqPTVvnT1cGr6Ni5keMkyYq17YELV7Mh0bHG+qi5/J6kZLVnWwLaNMyZF6FmedKSqWeeaoZqg3mNv8ahfw6SmeeJ6sfylRKezLOcRrd4zwI3/qs7xXf/RoqqoRj7GLDDrSsw/KyrpsSO1++LeZgajp01zzCehqr8Y9eRps559fku2T9IycI9ZgUiuVZCAp9UNmrHNHxjvLJOf2xBfBxE2yQ742irIljWnfKtFkYII58culXDpjE/ZZxaxuPh+aq6OSQEsfjpq9QJ4P6RP3JqGXNMuZrdgmikzETP836uCK7qdyEWES89QsCSI5x+d7EUrnprBfNs5Ex4ypCv9UNvXsalaVvwTDHXqMH0m0mdqRl0WtJ09+i3r2/7Hy+MnaUPPk/D7bDBOslTElQ
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB4824.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(396003)(136003)(376002)(346002)(39860400002)(366004)(86362001)(55016003)(33656002)(122000001)(52536014)(82960400001)(38070700005)(53546011)(26005)(316002)(38100700002)(4326008)(76116006)(8676002)(66476007)(71200400001)(54906003)(66446008)(7696005)(66556008)(83380400001)(2906002)(66946007)(41300700001)(9686003)(8936002)(186003)(478600001)(5660300002)(6506007)(64756008)(6916009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QThjVllyOEhGNVcraVllSXZqTDNvd291MFRabytVODBsaWZhQkZtcFhwTTNp?=
 =?utf-8?B?aHRaQ1JmR3h1ME8vRUlhUzlJMU1BZEpnYnBEWTU3eDhPMXZ1SHA3TUdna0w4?=
 =?utf-8?B?ZTExcnRoc1dTWmYrajBSTU5aRDZYQ2FIenV4VUFhQU0xcXc5MVAyTGc5MEhP?=
 =?utf-8?B?ck5oN3JKcWJ2NjhWTmJUVFZoNmNNemlOS0ZhdjBOWGtWWmpZZjFyZHRHN2RT?=
 =?utf-8?B?cE1UZXhIYjFMYm50WkFIS2tWYTQwMFZ3bURERkN2QUtVVlNxVmk2YXlkVTF2?=
 =?utf-8?B?dW41b1BWS3VTSE42aTFXV1lTK1BNSVZQMDRDbTNSaXNLZG96T2RxT0hnNXRz?=
 =?utf-8?B?M3dNdGpqMlJreTd5UzhIMC9rdU9qSUtSU2RTancramwreEJYMHl2SUpYYmpl?=
 =?utf-8?B?TUJoV0dJS2FyeVpBamVNY2RLWE1Bd0VwNmJrMUtoSHgvTWRLbjF0TGtldGpo?=
 =?utf-8?B?by82WkV3dWl4cktVQWxleG9aZm0vWHN5Kzc1TkZ3NGpSVHlMOHYrZFU0R0pT?=
 =?utf-8?B?VzJvcG5yMU84OVhQcm4zL1NVS1UzS0xiM1B5M2pKUFdHWWxRL2VPSWRoTUtY?=
 =?utf-8?B?MFU3a1NzcEMvcTJZWkxFeDhlcmR6TFdzTzhackM2Ky9vYWg0ZkN2VDVyQTlP?=
 =?utf-8?B?VVZJVXJhZmVXelVEZWZuRjRkajJTU05kU0k4UlZGQk1rZC9nNDAvQkF6aFlJ?=
 =?utf-8?B?clZmUTBjdjdacHZ4cjhMVm9vOVFIcFhLVTM5OTVuUWdXN1N1NVltMUl2MjZv?=
 =?utf-8?B?L3R1cCtkbWhhY3JSNnI1aW9HNVFwblg4T1dycHVkc0FGZ0RYS3REcUJtQjd1?=
 =?utf-8?B?OUJWYjMxd1MrT0U0SVMvaDlGZGFCbU45b3NSNmkrOVdpdC9HWFQ2T05kZDNQ?=
 =?utf-8?B?S0VXbTNkaDY1VWJQdWtQOHRWZjlWMG5iRzFDeE4raW5BaEx1SHVLWGZENm5u?=
 =?utf-8?B?dmtScmJyTFN1WkNGVDFFWUVVZXF1eEZSUCt0RmdFSThpZXZZZXJhRDRVUU1F?=
 =?utf-8?B?R0ZVeGVHdy93aCtqNWhsTitBZUxvY1dYL3VXdVpNWEVnSHNoZ0NsTEprOC9N?=
 =?utf-8?B?NUZ5ZlloV2Y2YmJVSXl0dGRjNE9hMG0zRTBKSWFaK2ErejZqRFBhQUJvcDZr?=
 =?utf-8?B?cXdNQ3JxeTVxOXhaclFHZTk4VkJjcURYYXdUZUI2T1NoM09uL1RITitCQ1pH?=
 =?utf-8?B?YjBaVSsxSHZhMFdVV2JocHcxZndCaDFlMmttcjRuVk15eTQxVC9oY1k0cUdp?=
 =?utf-8?B?ZXhIdGZtYUVEcnZtUkZDVVV3WXlZeERSL0oyM2doVFdFRi9UaE5RZUgwQndu?=
 =?utf-8?B?V3JtdTkzVWVQSWwwelQzOGUwYnZocE84NVNZRWp1ZUJGRTBRYmJGUTVVeUJk?=
 =?utf-8?B?UUU1c3VzT2gxakh1aW5DWENNVnkrVnVIMlhBd2xUcTA2emxSYXl1L25XV2Yr?=
 =?utf-8?B?QlJZM09XTkdyTnFUdVdxR1UwblpsRUJTVUN0YzA2ZlBqR0ppQjdTTlZISFg3?=
 =?utf-8?B?ekJTRmFmVW5tV21qNm9oYzZmcE9HMUVNM3I3cWUvVDFobHl4TFE1eVBWUzFM?=
 =?utf-8?B?ZTZRUUhNSHZEVXB0NlIrOExsWTlSUTRBYlR6eCs1V24rUnNJMi9jVkp2U1E0?=
 =?utf-8?B?RXNJYjlYK1NCZnplNEd5aU9vT1pnS0Z3ZHhBdDcvejlDeS9Wd09OZkcvOWFt?=
 =?utf-8?B?VHNFZzhnLzk1Tnd6bk1HRUd3Y2pkSGJhQXZFMXREbFFwUm4wS0RFbWM1OHZ4?=
 =?utf-8?B?QTB4Zm0wN1VpaEFHNkptZk52QnRZNW13aENpTEwvb3ZxdEZtNzBldytZK3Ny?=
 =?utf-8?B?aFZQdXFTczFXbHJrUzNGaE1qSDFuSW5pdnB0MklQL2N4SlV1TFZ1dTJWbTNx?=
 =?utf-8?B?S1RGRmdFVndYbkZiQS85WDhwYnpQTUh6ZEwzMDZmU3Fkd2RwV3lxS1ZmcVJW?=
 =?utf-8?B?UDRoc1JpZDg1LzhPaFV3YlR1MytvSmxZeTlBdjl1aVJUZ1pIWjRVeWxEcVA3?=
 =?utf-8?B?ZlVLT2lzYk9iQUsvOUl6bmxoNnhIR1NOQmFUT09tZlE0RXhTTndrYTA0RHho?=
 =?utf-8?B?RlNzMFNBZ0tVOC8weFFGREY2YmFKVG9ScVlwWWlFbGM0YzVkZUU3VVVpMVZ6?=
 =?utf-8?Q?jdIdsJsayr2omqtU+61lMRTyU?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB4824.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 52453988-4e95-4ab5-7a42-08da6541b4ee
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jul 2022 02:36:50.8841
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hA6OAEpfx/Av0/gaVChyM++TivfEEKFcvnLiV0LiMj5fQpWEccIfuYrR4wH5pK33uhwnbMom7yzUPMMTDiDlZg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1101MB2279
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBGcm9tOiBSYWZhZWwgSi4gV3lzb2NraSA8cmFmYWVsQGtlcm5lbC5vcmc+DQo+IFNlbnQ6IFRo
dXJzZGF5LCBKdWx5IDE0LCAyMDIyIDE6NTMgQU0NCj4gVG86IE1pLCBEYXBlbmcxIDxkYXBlbmcx
Lm1pQGludGVsLmNvbT4NCj4gQ2M6IFJhZmFlbCBKLiBXeXNvY2tpIDxyYWZhZWxAa2VybmVsLm9y
Zz47IE1pY2hhZWwgUy4gVHNpcmtpbg0KPiA8bXN0QHJlZGhhdC5jb20+OyBBcm5kIEJlcmdtYW5u
IDxhcm5kQGFybmRiLmRlPjsgQmFydCBWYW4gQXNzY2hlDQo+IDxidmFuYXNzY2hlQGFjbS5vcmc+
OyBMaW51eCBLZXJuZWwgTWFpbGluZyBMaXN0IDxsaW51eC0NCj4ga2VybmVsQHZnZXIua2VybmVs
Lm9yZz47IExpbnV4IFBNIDxsaW51eC1wbUB2Z2VyLmtlcm5lbC5vcmc+DQo+IFN1YmplY3Q6IFJl
OiBbUEFUQ0hdIGNwdWlkbGU6IE1vdmUgY3B1aWRsZSBkcml2ZXIgZm9yd2FyZCBiZWZvcmUgYWNw
aSBkcml2ZXINCj4gaW4gTWFrZWZpbGUNCj4gDQo+IE9uIFdlZCwgSnVsIDEzLCAyMDIyIGF0IDEw
OjIxIEFNIERhcGVuZyBNaSA8ZGFwZW5nMS5taUBpbnRlbC5jb20+IHdyb3RlOg0KPiA+DQo+ID4g
QXMgbG9uZyBhcyBLY29uZmlnIEFDUElfUFJPQ0VTU09SIGlzIGVuYWJsZWQsIEFDUElfUFJPQ0VT
U09SIHdvdWxkDQo+ID4gc2VsZWN0IEFDUElfUFJPQ0VTU09SX0lETEUgYW5kIGFjcGlfaWRsZSBk
cml2ZXIgaXMgZW5hYmxlZC4gQnV0IGluDQo+ID4gY3VycmVudCBkcml2ZXIgbG9hZGluZyBvcmRl
ciBhY3BpX2lkbGUgZHJpdmVyIGlzIGFsd2F5cyBsb2FkZWQgYmVmb3JlDQo+ID4gY3B1aWRsZV9o
YWx0cG9sbCBkcml2ZXIuIFRoaXMgbGVhZHMgdG8gY3B1aWRsZV9oYXRwb2xsIGRyaXZlciBoYXMg
bm8NCj4gPiBjaGFuY2UgdG8gYmUgbG9hZGVkIHdoZW4gaXQncyBlbmFibGVkLg0KPiA+DQo+ID4g
VGh1cywgbW92ZSBjcHVpZGxlIGRyaXZlciBmb3J3YXJkIGJlZm9yZSBhY3BpIGRyaXZlciBhbmQg
bWFrZQ0KPiA+IGNwdWlkbGUtaGF0cG9sbCBkcml2ZXIgaGFzIGEgY2hhbmNlIHRvIGJlIHJ1biB3
aGVuIGl0J3MgZW5hYmxlZC4NCj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6IERhcGVuZyBNaSA8ZGFw
ZW5nMS5taUBpbnRlbC5jb20+DQo+ID4gLS0tDQo+ID4gIGRyaXZlcnMvTWFrZWZpbGUgfCAyICst
DQo+ID4gIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlvbigtKQ0KPiA+
DQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvTWFrZWZpbGUgYi9kcml2ZXJzL01ha2VmaWxlIGlu
ZGV4DQo+ID4gOWEzMDg0MmIyMmM1Li45MjFlZDQ4MWI1MjAgMTAwNjQ0DQo+ID4gLS0tIGEvZHJp
dmVycy9NYWtlZmlsZQ0KPiA+ICsrKyBiL2RyaXZlcnMvTWFrZWZpbGUNCj4gPiBAQCAtMjYsNiAr
MjYsNyBAQCBvYmoteSAgICAgICAgICAgICAgICAgICAgICAgICArPSBpZGxlLw0KPiA+ICAjIElQ
TUkgbXVzdCBjb21lIGJlZm9yZSBBQ1BJIGluIG9yZGVyIHRvIHByb3ZpZGUgSVBNSSBvcHJlZ2lv
biBzdXBwb3J0DQo+ID4gIG9iai15ICAgICAgICAgICAgICAgICAgICAgICAgICArPSBjaGFyL2lw
bWkvDQo+ID4NCj4gPiArb2JqLSQoQ09ORklHX0NQVV9JRExFKSAgICAgICAgICs9IGNwdWlkbGUv
DQo+ID4gIG9iai0kKENPTkZJR19BQ1BJKSAgICAgICAgICAgICArPSBhY3BpLw0KPiA+DQo+ID4g
ICMgUG5QIG11c3QgY29tZSBhZnRlciBBQ1BJIHNpbmNlIGl0IHdpbGwgZXZlbnR1YWxseSBuZWVk
IHRvIGNoZWNrIGlmIGFjcGkNCj4gPiBAQCAtMTI2LDcgKzEyNyw2IEBAIG9iai0kKENPTkZJR19F
REFDKSAgICAgICAgICArPSBlZGFjLw0KPiA+ICBvYmotJChDT05GSUdfRUlTQSkgICAgICAgICAg
ICAgKz0gZWlzYS8NCj4gPiAgb2JqLSQoQ09ORklHX1BNX09QUCkgICAgICAgICAgICs9IG9wcC8N
Cj4gPiAgb2JqLSQoQ09ORklHX0NQVV9GUkVRKSAgICAgICAgICs9IGNwdWZyZXEvDQo+ID4gLW9i
ai0kKENPTkZJR19DUFVfSURMRSkgICAgICAgICArPSBjcHVpZGxlLw0KPiA+ICBvYmoteSAgICAg
ICAgICAgICAgICAgICAgICAgICAgKz0gbW1jLw0KPiA+ICBvYmoteSAgICAgICAgICAgICAgICAg
ICAgICAgICAgKz0gdWZzLw0KPiA+ICBvYmotJChDT05GSUdfTUVNU1RJQ0spICAgICAgICAgKz0g
bWVtc3RpY2svDQo+ID4gLS0NCj4gDQo+IFdlbGwsIHRoaXMgY2hhbmdlIGRvZXNuJ3QgZ3VhcmFu
dGVlIGxvYWRpbmcgaGFsdHBvbGwgYmVmb3JlIEFDUEkgaWRsZS4NCj4gDQo+IEFsc28gd2hhdCBp
ZiBoYWx0cG9sbCBpcyBlbmFibGVkLCBidXQgdGhlIHVzZXIgd2FudHMgQUNQSSBpZGxlPw0KDQpU
aGFua3MgUmFmYWVsIGZvciByZXZpZXdpbmcgdGhpcyBwYXRjaC4NCg0KYWNwaV9pZGxlIGRyaXZl
ciBhbmQgY3B1aWRsZV9oYWx0cG9sbCBkcml2ZXIgaGF2ZSBzYW1lIGluaXRpYWxpemF0aW9uIGxl
dmVsIGFuZCBib3RoIGFyZSBpbml0aWFsaXplZCBvbiB0aGUgbGV2ZWwgZGV2aWNlX2luaXRjYWxs
LiBTbyB0aGUgYnVpbGRpbmcgb3JkZXIgd291bGQgZGVjaWRlIHRoZSBsb2FkaW5nIHNlcXVlbmNl
LiBKdXN0IGxpa2UgdGhlIGludGVsX2lkbGUgZHJpdmVyIHdoaWNoIGFsc28gaGFzIHNhbWUgaW5p
dGlhbGl6YXRpb24gbGV2ZWwgKGRldmljZV9pbml0Y2FsbCksIGJ1dCBhcyBpdCdzIGJ1aWx0IGJl
Zm9yZSBhY3BpX2lkbGUgZHJpdmVyLCBpdCB3b3VsZCBiZSBsb2FkZWQgZmlyc3QgYmVmb3JlIGFj
cGlfZHJpdmVyIGlmIGludGVsX2lkbGUgZHJpdmVyIGlzIGVuYWJsZWQuDQoNClRoZXJlIGlzIGFu
b3RoZXIgbWV0aG9kIHRvIG1ha2UgY3B1aWRsZV9oYWx0cG9sbCBkcml2ZXIgbG9hZGVkIGZpcnN0
IGJlZm9yZSBhY3BpX2RyaXZlciwgaXQncyBjaGFuZ2UgdGhlIGluaXRpYWxpemF0aW9uIGxldmVs
IHRvIHBvc3Rjb3JlX2luaXRjYWxsLiBJJ20gbm90IHN1cmUgd2hpY2ggb25lIGlzIGJldHRlciwg
YnV0IGl0IHNlZW1zIGN1cnJlbnQgcGF0Y2ggaXMgbW9yZSByZWFzb25hYmxlLg0KDQpUaGVyZSBp
cyBhbiBwYXJhbWV0ZXIgImZvcmNlIiB0byBtYW5hZ2UgdGhlIGhhbHRwb2xsIGVuYWJsaW5nLiBJ
ZiB1c2VyIHdhbnQgdG8gdXNlIEFDUEkgaWRsZSwgaXQgY2FuIGNoYW5nZSB0aGlzIHBhcmFtZXRl
ciB0byBkaXNhYmxlIGhhbHRwb2xsbCBkcml2ZXIuDQo=
