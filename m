Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CE6E4CBB3A
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Mar 2022 11:24:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232305AbiCCKYm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Mar 2022 05:24:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232295AbiCCKYd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Mar 2022 05:24:33 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DD5FCCC61;
        Thu,  3 Mar 2022 02:23:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646303028; x=1677839028;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=HQgw0C8K6dcej6IDXp8XJXkQNrkuzEJyn3NmO0tvjPs=;
  b=GpwiobShmFX+c5MdUjrxfwoNp0y3FHdLTN8xwEW9UjcJ9E8vsVQwOHdb
   k2TQ4/DvnrxqVFJcxhRpJ6DQra5URJhWg8hGZVQsfCJwBy450nVU/iPuU
   dyEtnQ5fYgieZLzqtgbNdrc7SoDZ5wtRQDF+KKX8nWA5iI2PVu7kuXqHY
   6cXX2EB3SqoGWmH15h7lNp1iXM+W6GyRYahRnLXRj+4dF07bd0+Ld3iIr
   ZjQp29RFs4A8WFrHH78mWdO9XZZwM0jjW1Wc0tAu+SNz+2OoNAgoTQX3V
   LcHInfg9iOS+/Jhph/rhfpLDPWmHANEg5Y7C7x+ehHQBWLjfh5SLchv+e
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10274"; a="253368536"
X-IronPort-AV: E=Sophos;i="5.90,151,1643702400"; 
   d="scan'208";a="253368536"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2022 02:23:47 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,151,1643702400"; 
   d="scan'208";a="640130264"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga002.fm.intel.com with ESMTP; 03 Mar 2022 02:23:47 -0800
Received: from orsmsx607.amr.corp.intel.com (10.22.229.20) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Thu, 3 Mar 2022 02:23:46 -0800
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX607.amr.corp.intel.com (10.22.229.20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Thu, 3 Mar 2022 02:23:46 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21 via Frontend Transport; Thu, 3 Mar 2022 02:23:46 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.171)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.21; Thu, 3 Mar 2022 02:23:46 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LPczDsZ2bZwifYCYIVyNVgHdkb96lgkuJ5w/B9a1I/vfPzcEjNVLCiyT8DO/f0s3P4WpDwQ6NlVk96TC5CXFnkdKaGXD/nPWsl2sBLK4AVa2eOYq04h43CgSWwfmDs14L8O+YwfDDDu805POH6AzRAE45/0LNSItAaej9UhbySKrAD7wrsvL6RoxsgceMfK/sZjyOTapRVPFEMZxudRjjHqsdJc/rwaPbTGWPDVO6TnjZqSxvToNGAkdQa+gmVbtt9WnMmKuJIM9zOVfp47iybjhmOl2KqQ2iqQPJYzHYkFs2Y7Q3sxKYtI7fTuAQTLaHlrEpd6zKWGPrFieDrSwUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HQgw0C8K6dcej6IDXp8XJXkQNrkuzEJyn3NmO0tvjPs=;
 b=fWecskamMASc+l4eOaUDHOBZk8AwuEdLNTc/rGGsKv1F94VmiRQLrdLEpvNSP2naQq2PPWIsskdfr5do60UBwwefM4KBt6U5fvefeE8v7nMthzYn9gpXYFKT4IVm1Ym38f16gTSFmQy2HZfVdOWnOO5xI9RZQ+FvcHuxhAw2mH9IhUQP6zUN61T2dRt50cE2j1tVftSfzXfTXVYVLD8E6MsN6E2/uNMtz8ulKJP2q2G836QFuwet0EpN3RfzPy8TFrspGLnZ9DTbLC5PZj76mRF6RkOM5bKm78h0rRMkTyWqSQaejFEbyVb4aaHm5lhq1EAaTPGb2XneAra49C717Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM4PR11MB5549.namprd11.prod.outlook.com (2603:10b6:5:388::7) by
 BY5PR11MB4322.namprd11.prod.outlook.com (2603:10b6:a03:1ce::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14; Thu, 3 Mar
 2022 10:23:44 +0000
Received: from DM4PR11MB5549.namprd11.prod.outlook.com
 ([fe80::d4c9:5841:3761:6945]) by DM4PR11MB5549.namprd11.prod.outlook.com
 ([fe80::d4c9:5841:3761:6945%4]) with mapi id 15.20.5038.016; Thu, 3 Mar 2022
 10:23:44 +0000
From:   "Sanil, Shruthi" <shruthi.sanil@intel.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
CC:     "andriy.shevchenko@linux.intel.com" 
        <andriy.shevchenko@linux.intel.com>,
        "mgross@linux.intel.com" <mgross@linux.intel.com>,
        "Thokala, Srikanth" <srikanth.thokala@intel.com>,
        "Raja Subramanian, Lakshmi Bai" 
        <lakshmi.bai.raja.subramanian@intel.com>,
        "Sangannavar, Mallikarjunappa" 
        <mallikarjunappa.sangannavar@intel.com>
Subject: RE: [PATCH v8 2/2] clocksource: Add Intel Keem Bay timer support
Thread-Topic: [PATCH v8 2/2] clocksource: Add Intel Keem Bay timer support
Thread-Index: AQHYJ9KVLj3sL+vmrk6q1BhORuJTLayrEYYAgADLt6CAABJ2AIAAXvPggAAGSICAAOWKwIAARa2AgAABJkA=
Date:   Thu, 3 Mar 2022 10:23:43 +0000
Message-ID: <DM4PR11MB5549B22251EDF0D6D5800932F1049@DM4PR11MB5549.namprd11.prod.outlook.com>
References: <20220222095654.9097-1-shruthi.sanil@intel.com>
 <20220222095654.9097-3-shruthi.sanil@intel.com>
 <91653d8d-1dc6-0170-2c3c-1187b0bad899@linaro.org>
 <BN9PR11MB55451DB929086919F8D06390F1039@BN9PR11MB5545.namprd11.prod.outlook.com>
 <23f86de0-3869-ee22-812d-ba610bac48b3@linaro.org>
 <BN9PR11MB55458A882EB4A681C4A63B26F1039@BN9PR11MB5545.namprd11.prod.outlook.com>
 <3ff11b85-249f-2f47-cbc4-41d2ab6d168f@linaro.org>
 <DM4PR11MB554994532B3D128F85553C38F1049@DM4PR11MB5549.namprd11.prod.outlook.com>
 <ce516de7-f1cf-c614-f9ff-439626dfafea@linaro.org>
In-Reply-To: <ce516de7-f1cf-c614-f9ff-439626dfafea@linaro.org>
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
x-ms-office365-filtering-correlation-id: e78573fe-1fb1-4f84-8acc-08d9fcffe542
x-ms-traffictypediagnostic: BY5PR11MB4322:EE_
x-microsoft-antispam-prvs: <BY5PR11MB43228080DC389405138C33B9F1049@BY5PR11MB4322.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: MuarqG7zRLdieJqpyvmf6587iqT/C3WO12vgDwj8sTNiskUHOQ3vpgWiBYDmVtFbNLpaA91KLR0/q0OrRGd91wFt9H4DBd6l333JuMWI4zBy3YTHPPsQj00UgnzaFeqVJ8mBDlo2+P7etk702IVyOEyBMAFw8pTaNsr4jcTCOzKE4x0INxrvjVhVFIlFQIbabn4sETE2eouiNK0oqYfi9eQ6JuXmLzx1zTScaL5l8VJnMD8j85V5AHg40NOeil5S6KGhOuzqWERoqK72+7kp5H+tjWpMvZ/g3C3YqCKg9E+Yo/UUBce9AYmJdLQepESj6DRhac4Ntu/NvHneNm7KJgafHlIYdpvQOe77+YtQI5HICvykDmOVRiBTXPpAPHWNAtLJMaVclzE6XcP08y7PtUpKDtEdD9IX3vjg7GBs6ericp4bpCUNZRhdCv+mhrCNjAcA6z5jfWki2MoJh5yqMtjabGKR7uvB39QCojOQ5+1CJW9Zkc1E+kjOOCjmA4M2GFM/aL2EK0pmzGOUiNHm5MJ1tTAA0Jy6G1tMLm66/RgnKP2pt3PJ+9a1A7ldNQvZdhnPtetjVB6oBrpiu//RnoaRBB6msuZ1KUiJ/MXNuWdgPYxkukNcFtl1kfj+P4AjdDDqy64NGZGDd1SGy8l92RUyOY59u/t/s+sNH3jVtYst7iId65x7WNK5lA0Ms+Z5TORstRyFdRYksL7Z7pINqU8ApWM/Tf8Y9lOxp5ZmM5NUVujC5JmX7Eg992dfYAx2dzeYSt1C+rUly4+hLL6083wTh4i+Q9VOksc8a/a7plm1GVymaInSVB/9P1w80MceT6lrAb28PZrTCo6A9wFO2A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB5549.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(7696005)(38070700005)(83380400001)(2906002)(6506007)(508600001)(54906003)(110136005)(38100700002)(9686003)(4326008)(186003)(316002)(55016003)(122000001)(26005)(71200400001)(66946007)(52536014)(66556008)(76116006)(82960400001)(64756008)(86362001)(5660300002)(8676002)(33656002)(53546011)(8936002)(66446008)(66476007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WTg3VmE5dWNtZGZVUVRjSmJmSXB6TjRVVStKZjJkRlEyODVuVVdhYjNhT3VM?=
 =?utf-8?B?bHNjN25sZHRQdHhvYlFmaWV3SHZPa1BhUzVCc1A3b1ljZjlaWk5IbFNqQjNj?=
 =?utf-8?B?WFZ4ZzcvYlErVXhIVlFUUGlRSkVwbkxjdlk0bHRPZG5KcXFwQnpQS0UvYnFn?=
 =?utf-8?B?QVRUby84d0VsTzlZMEFUMUhEa1I0R3ZBSkdCLzBzSU1ySnozbVdPQkNkL0cx?=
 =?utf-8?B?YWE1eEQzbmVYMG0zVUtocHV0Y0U0SXZGczg5dUdKSHVaUVIwcnFrZkgwT0Fa?=
 =?utf-8?B?YTVUM2lsbHdvRm80SWdtaGF4QmluSVRKVFMyVnVhU0NuWXd4U0dFMU1DRFJW?=
 =?utf-8?B?L3RJS3d6UEk4VWpzNGZjUkVYT3VmcXdQTkZEVitSdW82Ri9ZREtHRGxRQUZR?=
 =?utf-8?B?M3QrbzRwM29OVzdiSitRZXd6djlNQzBCOWR4R3YvaGxMZXFYc3ByM25BaVNP?=
 =?utf-8?B?TEMrbVk0d1ljbkdHZDFFRWhSd3IzbnRXdkN6R0VPSGE4NHVtQ2VDajJsb09o?=
 =?utf-8?B?clcxK1NaTVBWZnhISFNuY0VxRE5LVXhuVE5zY3dlaEswejloL3dibGJyUlBH?=
 =?utf-8?B?S2lUSWdHY3N0Y2FEeUl6YUNocXRqNjVEZnh1ckdaUnBHQkc5UlFKWWlSL25n?=
 =?utf-8?B?ZE11MDU5a25NeHRZV1JRbVJRZlI5SFR4YjJRTXVmcEhwSVN5RnB0MHhSOFQv?=
 =?utf-8?B?K3ljdUJuTW84eUFuT0lGaXl0MUpGa1NmMklmNkpvYWw5YjFEZnlLNi9od0RX?=
 =?utf-8?B?Sy9reStCWmtzUVMrcDJEMTA1RUpSR0l4YnZpdCtHZGFxVDk4UjBOeDhqalo3?=
 =?utf-8?B?VGNLRkRSeWl4QVdKWVBOTVJBbXc5Y3FBYjEvMGVsaEU1bUsyTEhnOTAyNmgz?=
 =?utf-8?B?NkVxcXZTcDJPZ20xcVFKWnh4QW5lMTYxOVBRWGFOM1A2WWRVcS9SNjlwSTN5?=
 =?utf-8?B?aWlNWVU4Y0I0elJ1NXplem9aanpQRDdWQUh1cEJoa1VCdGZYL0ZDUnRjbHlj?=
 =?utf-8?B?SmlNTjFQRTZINjJ5VEpiME43MERXZlBLMkl0Wnh3OG42Nm4xdVpTSHJFd0NO?=
 =?utf-8?B?bVZJR0UwSUppSVo1Y1g0c1hiQ21odk5VNytGUjlrbms3R0w3eFU5SlYwMmhx?=
 =?utf-8?B?ZmttZjFwWHRIMGlZWXB3NjhqY3J1VGRaOVNzeVk3R0ZxbkRCbUJuM3BCVXVD?=
 =?utf-8?B?NnU3TjRuOFZuUmFHM2pNeHFXeTJ4T09GRThmS3M1bCt6M3BwdDBETU8vRVo1?=
 =?utf-8?B?TG5hcGIvdkx1dGZ3VmFSWmVEdDRnaGdWVnJCTVduUjdLZk81d2lWTnNWRjBN?=
 =?utf-8?B?TDBpSjh4NmZVQkRsNXdzWVNsVGdWUXR1YUppdUE4Qnp0OW5ZcGF4RFhDYUFM?=
 =?utf-8?B?MDlDSG9mT05ndUhWSDQyUjFJZHkyYS9BYlNlaytvb1hZYVNoTEtxZEFQVkJx?=
 =?utf-8?B?bHZHb0ZuVzdVenpLMlV3T1hEU2hLbHZnRUdRVHNoNHlFeklWQzVMY0hnNVRQ?=
 =?utf-8?B?RytsbTJnN3l4dEw3US9ZYWZoRk9zOUY1eENmK29GMW5meHp6Z0krSzM2SWFG?=
 =?utf-8?B?NDJqazFacjNqdkJUTVpQaSt5eVJ3UkEwNEFCQTM2Y3A1aHBNa1dhNlNRU0h0?=
 =?utf-8?B?QU5adXBFVDZmdmVtV2FHSVhJdG1WV01jOWdBM3JEVGt4aEg4dWhCSHRQZVkw?=
 =?utf-8?B?bS8wVkxzb1VhcUpZNGdtZW0xakxhNkZ1TWZ5bFZxTDR6Tm9rWW1zS2I1am5a?=
 =?utf-8?B?ekswR0l5VWEzT0FPem14MXovcHErY1ozUldaRW1HRmVkSDdVZDMrc094QkdX?=
 =?utf-8?B?Y2I2MmJtSm5DekNiK3NkVGEwUkZIalRpeFg0MXdlS0pnQ213OWNBQnhuOURT?=
 =?utf-8?B?OW5xTmxZeVJRcnB6eTlDUkYvNnpTcjRpckc5MEdkRFF4NTlHWnlqTjVjdHFX?=
 =?utf-8?B?clFVMC9LL2RwQmNSbFc0ZTF2NVlldWVRL21NaEVRUE1qbnEyaXhlVHpRaC9x?=
 =?utf-8?B?Nk1iV0w4emVtK2ZWT0cwZVlkaHdKS2FUYW50N0ZOMGNIU1dHU21yVlR6UElG?=
 =?utf-8?B?N1lrOTZuTEVMVVkrVVlMWFI1TGhKek5WMjRvY3VoN1M3QmJSdCszM3VGeG9X?=
 =?utf-8?B?VEhEU2l0RXdSRHhORzlNSVNjSWRDcWIzTkh6WVJkb3Y3eC9vWE1OcDg5eGtU?=
 =?utf-8?Q?AWoB0UHr2fVil3YyEiKkDR0=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB5549.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e78573fe-1fb1-4f84-8acc-08d9fcffe542
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2022 10:23:44.1745
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rGYpgeD/H765wkaD6XB3uA1ssOlxQVwP8ZnmY5KEbdGdgxRoksmCC6lUAMPe88aIiBaeRclfbC/5hxdck38Avg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR11MB4322
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBEYW5pZWwgTGV6Y2FubyA8ZGFu
aWVsLmxlemNhbm9AbGluYXJvLm9yZz4NCj4gU2VudDogVGh1cnNkYXksIE1hcmNoIDMsIDIwMjIg
Mzo0OCBQTQ0KPiBUbzogU2FuaWwsIFNocnV0aGkgPHNocnV0aGkuc2FuaWxAaW50ZWwuY29tPjsg
dGdseEBsaW51dHJvbml4LmRlOw0KPiByb2JoK2R0QGtlcm5lbC5vcmc7IGxpbnV4LWtlcm5lbEB2
Z2VyLmtlcm5lbC5vcmc7DQo+IGRldmljZXRyZWVAdmdlci5rZXJuZWwub3JnDQo+IENjOiBhbmRy
aXkuc2hldmNoZW5rb0BsaW51eC5pbnRlbC5jb207IG1ncm9zc0BsaW51eC5pbnRlbC5jb207IFRo
b2thbGEsDQo+IFNyaWthbnRoIDxzcmlrYW50aC50aG9rYWxhQGludGVsLmNvbT47IFJhamEgU3Vi
cmFtYW5pYW4sIExha3NobWkgQmFpDQo+IDxsYWtzaG1pLmJhaS5yYWphLnN1YnJhbWFuaWFuQGlu
dGVsLmNvbT47IFNhbmdhbm5hdmFyLCBNYWxsaWthcmp1bmFwcGENCj4gPG1hbGxpa2FyanVuYXBw
YS5zYW5nYW5uYXZhckBpbnRlbC5jb20+DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjggMi8yXSBj
bG9ja3NvdXJjZTogQWRkIEludGVsIEtlZW0gQmF5IHRpbWVyIHN1cHBvcnQNCj4gDQo+IE9uIDAz
LzAzLzIwMjIgMDc6MTgsIFNhbmlsLCBTaHJ1dGhpIHdyb3RlOg0KPiANCj4gWyAuLi4gXQ0KPiAN
Cj4gPj4+Pj4+PiArCWlmICghKHZhbCAmIFRJTV9DT05GSUdfUFJFU0NBTEVSX0VOQUJMRSkpIHsg
Kw0KPiA+Pj4+Pj4+IHByX2VycigiJXBPRjogUHJlc2NhbGVyIGlzIG5vdCBlbmFibGVkXG4iLCBu
cCk7ICsJCXJldCA9DQo+ID4+Pj4+Pj4gLUVOT0RFVjsgKwl9DQo+ID4+Pj4+Pg0KPiA+Pj4+Pj4g
V2h5IGJhaWwgb3V0IGluc3RlYWQgb2YgZW5hYmxpbmcgdGhlIHByZXNjYWxhciA/DQo+ID4+Pj4+
DQo+ID4+Pj4+IEJlY2F1c2UgaXQgaXMgYSBzZWN1cmUgcmVnaXN0ZXIgYW5kIGl0IHdvdWxkIGJl
IHVwZGF0ZWQgYnkgdGhlDQo+ID4+Pj4+IGJvb3Rsb2FkZXIuDQo+ID4+Pj4gU2hvdWxkIGl0IGJl
IGNvbnNpZGVyZWQgYXMgYSBmaXJtd2FyZSBidWcgPw0KPiA+Pj4NCj4gPj4+IE5vLiBUaGlzIGlz
IGEgY29tbW9uIGRyaXZlciBhY3Jvc3MgcHJvZHVjdHMgaW4gdGhlIHNlcmllcyBhbmQNCj4gPj4+
IGVuYWJsZW1lbnQgb2YgdGhpcyBiaXQgZGVwZW5kcyBvbiB0aGUgcHJvamVjdCByZXF1aXJlbWVu
dHMuIEhlbmNlIHRvDQo+ID4+PiBiZSBzdXJlIGZyb20gZHJpdmVyLCB3ZSBhZGRlZCB0aGlzIGNo
ZWNrIHRvIGF2b2lkIGluaXRpYWxpemF0aW9uIG9mDQo+ID4+PiB0aGUgZHJpdmVyIGluIHRoZSBj
YXNlIHdoZXJlIGl0IGNhbm5vdCBiZSBmdW5jdGlvbmFsLg0KPiA+Pg0KPiA+PiBJJ20gbm90IHN1
cmUgdG8gZ2V0IHRoZSBtZWFuaW5nIG9mICdwcm9qZWN0IHJlcXVpcmVtZW50cycgYnV0IChmb3Ig
bXkNCj4gPj4gdW5kZXJzdGFuZGluZykgd2h5IG5vdCBkZXNjcmliZSB0aGUgdGltZXIgaW4gdGhl
IERUIGZvciBzdWNoDQo+ID4+IHByb2plY3RzPw0KPiA+Pg0KPiA+DQo+ID4gT0ssIEkgdW5kZXJz
dGFuZCB5b3VyIHBvaW50IG5vdy4gV2UgY2FuIGNvbnRyb2wgdGhlIGRyaXZlcg0KPiA+IGluaXRp
YWxpemF0aW9uIGZyb20gZGV2aWNlIHRyZWUgYmluZGluZyByYXRoZXIgdGhhbiBhZGQgYSBjaGVj
ayBpbiB0aGUNCj4gPiBkcml2ZXIuIEJ1dCBpc24ndCBpdCBnb29kIHRvIGhhdmUgYSBjaGVjaywg
aWYgZW5hYmxpbmcgb2YgdGhlIGJpdCBpcw0KPiA+IG1pc3NlZCBvdXQgaW4gdGhlIEZXPyBUaGlz
IGNhbiBoZWxwIGluIGRlYnVnZ2luZy4NCj4gDQo+IFNvIGlmIHRoZSBkZXNjcmlwdGlvbiBpcyBp
biB0aGUgRFQgYnV0IHRoZSBwcmVzY2FsZXIgYml0IGlzIG5vdCBlbmFibGVkIHRoZW4gdGhlDQo+
IGZpcm13YXJlIGlzIGJ1Z2d5LCBJSVVDLiBZZWFoLCB0aGlzIGNoZWNrIHdvdWxkIGhlbHAsIG1h
eSBiZSBhZGQgbW9yZQ0KWWVzLCByaWdodC4gSXQgd291bGQgbWVhbiB0aGUgRlcgaXMgYnVnZ3ku
DQoNCj4gY29udGV4dCBpbiB0aGUgZXJyb3IgbWVzc2FnZSwgZWcuICJGaXJtd2FyZSBoYXMgbm90
IGVuYWJsZWQgdGhlIHByZXNjYWxlcg0KPiBiaXQiIG9yIHNvbWV0aGluZyBsaWtlIHRoYXQNCj4g
DQo+IFRoYW5rcyBmb3IgdGhlIGNsYXJpZmljYXRpb24NCg0KWWVzLCBTdXJlLiBJJ2xsIHVwZGF0
ZSB0aGUgY29tbWVudCBhY2NvcmRpbmdseS4NClRoYW5rIHlvdSDwn5iKDQoNCj4gDQo+ICAgIC0t
IEQuDQo+IA0KPiANCj4gDQo+IC0tDQo+IDxodHRwOi8vd3d3LmxpbmFyby5vcmcvPiBMaW5hcm8u
b3JnIOKUgiBPcGVuIHNvdXJjZSBzb2Z0d2FyZSBmb3IgQVJNIFNvQ3MNCj4gDQo+IEZvbGxvdyBM
aW5hcm86ICA8aHR0cDovL3d3dy5mYWNlYm9vay5jb20vcGFnZXMvTGluYXJvPiBGYWNlYm9vayB8
DQo+IDxodHRwOi8vdHdpdHRlci5jb20vIyEvbGluYXJvb3JnPiBUd2l0dGVyIHwgPGh0dHA6Ly93
d3cubGluYXJvLm9yZy9saW5hcm8tDQo+IGJsb2cvPiBCbG9nDQo=
