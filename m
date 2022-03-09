Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDFD84D2A5D
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 09:10:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231214AbiCIILI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 03:11:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229601AbiCIILG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 03:11:06 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0985714CDA6;
        Wed,  9 Mar 2022 00:10:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1646813408; x=1678349408;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=8q2wTzPXl4WA7iOodFymsGqJPQE5RwCkQxtdKeUuylI=;
  b=ivZFrBDOTtukqfn7Di1z04pWC2Q0rVJmFKAceGdUYRYnvZArs4PduC3R
   GLUhWzvI0BAEGMFn3zMVa/WAwM7eRGbAFKkCe7iQEgEBrDMAJIEd33NNc
   ndmXTzD2TNDnea8u/f0RQYa5dNwTPxk/nCIKS2kag8tVjwmcDFQ3eEM2t
   YQG9ftJZdmwJdy3PjsDhoSqNjryt1LMHv1shdI0eqdR+JVdCfAu1CtNmQ
   GtxFxs2MKVbxp5uBCKBR7eU1fSYSDiByMYgLMPgCYXl2O7aQLjfI5HtQ3
   7qItqPNVRjWH41l5KPaXUPXy1VJ4l4aF4wNbk95oz0tLt7imFHCE5Fy/T
   w==;
X-IronPort-AV: E=Sophos;i="5.90,167,1643698800"; 
   d="scan'208";a="88325248"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 09 Mar 2022 01:09:52 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Wed, 9 Mar 2022 01:09:51 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17 via Frontend
 Transport; Wed, 9 Mar 2022 01:09:51 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bzIC2PK3+6R/2MtWb1AFmrNa0ZERrWec6VJnPklbG52LopSeFXCVI2fi2gXpULukLsLO73ExzZyWs7nW0cu2dxNhdktz7tWKJo4WmCw+vZtIiDX0bVS40dELfsif3FgPMQOPpWTSD+Ul2G1u0VSu7sPCqmJbgEFJ38/NX7DxOCexDKvkdLJE0ymD3GVWlGqp4Ql0jVrVpvDLhlZtO47mC1n5EJYBZuCJrvSng3MpUjKdYYbvU/5xksmPvzg8mK5WYz7RCguxrstIwa0ENi6FzO42V4Pa6+tZSuW62/UePqQKt3dHf/lU0EIowGaKLgHj3U4uPKOiO7a4ba7UnKS1OA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8q2wTzPXl4WA7iOodFymsGqJPQE5RwCkQxtdKeUuylI=;
 b=Sd14BWzs3oyCQbZDOcaBN1C6Fw3o5fZj/DMT0m7b5XXUisb15PZwdl5HKy6EvdcKxNSLjmScNmL6CaPALlwOkn/qD6dzcvHz9by6Sfrohs/BRl6zRpv1cN89J4J1RYLvYAYM7/M20rJYFG8YBKQflsSx/Q7eR3q5Fe22u1gn22SkzikVq7etmLAJmYviOxw+RFGVNUPSzsFng5T4gHJXAZQiAYMjMufPn306ftbc/TO7Fk1yz1rkhsj+ATSk+Io91pv9qWvZC5+A+X6FVEcaPbWnd+16NopGY6uLrc5wEl59/X4xpbdgC+Y6URqA6y1yj6MayNAg7wnBOqONeAAlHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8q2wTzPXl4WA7iOodFymsGqJPQE5RwCkQxtdKeUuylI=;
 b=H5HLM7irdvgUZaCS/0heUVoyPyn2A6dYpetIGLwnGiiRal+fp5n616i3huBcR8HHlOVNrGzBmfsVQjiM6myZXhmqwjk7mViOI47txANzuJe9mNAcY9TpC2pM8YP6CIHjIsebumuW+Gh7fdf43HW/aSll3edaypc+Q2tp0m67ROs=
Received: from CO1PR11MB5154.namprd11.prod.outlook.com (2603:10b6:303:95::7)
 by BN6PR1101MB2308.namprd11.prod.outlook.com (2603:10b6:405:54::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.29; Wed, 9 Mar
 2022 08:09:49 +0000
Received: from CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::dc95:437b:6564:f220]) by CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::dc95:437b:6564:f220%6]) with mapi id 15.20.5038.027; Wed, 9 Mar 2022
 08:09:49 +0000
From:   <Conor.Dooley@microchip.com>
To:     <linux@dominikbrodowski.net>
CC:     <mpm@selenic.com>, <herbert@gondor.apana.org.au>,
        <Lewis.Hanly@microchip.com>, <linux-kernel@vger.kernel.org>,
        <linux-crypto@vger.kernel.org>, <linux-riscv@lists.infradead.org>
Subject: Re: [PATCH 1/2] hwrng: mpfs - add polarfire soc hwrng support
Thread-Topic: [PATCH 1/2] hwrng: mpfs - add polarfire soc hwrng support
Thread-Index: AQHYMjlJ95Z0rSRlp0SX3uhZT+zi0Ky1H2gAgAGXPQA=
Date:   Wed, 9 Mar 2022 08:09:49 +0000
Message-ID: <d5a29b8e-b847-b176-5e94-720486b6d09e@microchip.com>
References: <20220307154023.813158-1-conor.dooley@microchip.com>
 <20220307154023.813158-2-conor.dooley@microchip.com>
 <YicMBhn81HmtJMiF@owl.dominikbrodowski.net>
In-Reply-To: <YicMBhn81HmtJMiF@owl.dominikbrodowski.net>
Accept-Language: en-IE, en-US
Content-Language: en-IE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b8f7009a-8828-463d-3314-08da01a42e71
x-ms-traffictypediagnostic: BN6PR1101MB2308:EE_
x-microsoft-antispam-prvs: <BN6PR1101MB2308BD6B27804F2F9A59B299980A9@BN6PR1101MB2308.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: I6lEKjxHlO+V6zW8mlummZ55y3jAsuOeZ5CwgRaGdO7Q0ssp0Ymh7bItbT5XAFPbt2SZH/YjhDDGzkEvJdU2InNu0WtmLgrZjsBMCGSPY44gkjcshumJCzhe6WJx17DjbR8AR8ZC+uXjKvbl3l+nLAjeVbn/kDPHooGE+cCY8+4ZwSq3Zvc4poo+Lw0yrLeWxJhg6bo1awUbbRfgd2+1GVVWo5I0E55Fz/g+YHWBjIVsNvMecDoPgIrS25Iw1vEl41RydWDOuL2zSYwROOc7LVNTI3dkVCNhDtfvSgG4/QJcqwfbf3hMtOLgAHvmTmR75sxR4INkmSKfJRJUEK2eauQRrQCoHYXT2tpLqPg5yNEz8jBEFknjM6Q8ThXVRAI7uTHujizuHoloTlv+0FxBvuQa3tlVF+af/MQW+jTgXtxbDCG5csmlXMk65P8wj/KgwRN8JOoqzFokgZ+DhkJWdYtKsmxQ66fZaOn+jvjp7d8xkIuNq3KgqchQes6IQ/8DhzP3VMDpVjnDORLnecP92XjRhn34A5JXdphbnHOBVcSrz1H7QTnzUUlRnbceKhFRasZPAluqVdDfSuSIYKffuiHhVlGxexX+QcgiYJl7MRrKmx5h2F5UI7KwnR0SNPXwZ0o2yTQXQXi/3ke46lG4fPqzQVsnaRUbMMLtdq4eUhOG9pSxQRnv+mus/utT2T4J5I9+rJ4LT6iJN0XVT0b7bKNDSw296LGjqcd3o9ONcgC3EXay9cr49fEogf68OHeJAx05veE6OTKfEr5QDbmmaGqrGlG/5feyZC2kKlj0Arw=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5154.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(508600001)(966005)(31686004)(6486002)(6916009)(54906003)(71200400001)(316002)(38070700005)(76116006)(91956017)(8676002)(66946007)(66556008)(66476007)(66446008)(122000001)(64756008)(4326008)(8936002)(6506007)(5660300002)(2616005)(186003)(26005)(83380400001)(53546011)(36756003)(6512007)(86362001)(2906002)(31696002)(38100700002)(43740500002)(45980500001)(10090945010);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eVhBSEd1NFQrc0tQSW1PQzdmMHdZRXZUTnFxY2lYcDhhejZXVGMyWkZJN1Vm?=
 =?utf-8?B?amp5d0dMV2lmMDlaMjBxNEZuNk93cnZXOEdMVzExUEhlVFk5aXV3TVVGbzBn?=
 =?utf-8?B?d3M5amdGTEUzWnZZQVRQMHJCYXhTcUNJQmR4SktHalFZOWwyQS90NzZtZTQx?=
 =?utf-8?B?akVmTFZaZHVtdm4rUE1LdFY2OW9yUld1VzNObitsMXF0RmNlRjIvamlWRDdW?=
 =?utf-8?B?dkJ5bzFFMkFabXdyTFdKSVkweVIxZFdUQkNmcWI4LzhxSWwvZTIzNFR2U0t2?=
 =?utf-8?B?b2NROG1rRzRyQmVsYnN2SFgwSi9qNlExWVZFS3ZqQ0VTZ2w0cmt1b2JOeUNT?=
 =?utf-8?B?MGNxZStkUUxVcnFIK0diRWlTRjFKT0VWcE12Nkh2SjdJeEJ5UVFHeVQrSlY3?=
 =?utf-8?B?RVFNZHhWRFhTWmNHWndFQXBZUWZGUFdVM1ozam9lVWQ5SzVuSFhNbnNIaVN0?=
 =?utf-8?B?U0pBS2ZzcVhuMlpMRDNoQWFQOFVybUsvSGt2aEdseWx6eWx4NDB4RXQzdlA3?=
 =?utf-8?B?ektSM2dWU3d1K3NSQ3NsYllZSXNCd3llSFhvUzJlMWRFQVFvUks2S1RRZ3hN?=
 =?utf-8?B?RU9kS24rYzJVcW5TQzI0ZmdBeGNLcU56TktCRi96U3lZQXVPTnQxQStONXJp?=
 =?utf-8?B?SDQvTnBZRVAzUzV6Ti9FZjV2VXV4VHB6MWtRK3hvRHRlVEE3YWNMbGlDVjJV?=
 =?utf-8?B?RC9mNFhYYmR4ZDlFTDJIZUZEQTZabUJBd0pzTWNacUhndHlpSm5RK3FWWWpa?=
 =?utf-8?B?a2IzSlQ1SVdUcC9SL0wzWFF3VG5GVHBKWFBWTVEzWWNNSkpodXV0KzVVamoy?=
 =?utf-8?B?OWk1ZDdMMWFXVjNjZVMwY0pCL0FYb1lvMk44RTV4Tnc5VkpkUllFYlBTdERR?=
 =?utf-8?B?WkViUTFCVlNwZ0NEMGNZRnE3bkJJQytvMENzWWpTY1pVaTVvY2NqZHQ2K0xo?=
 =?utf-8?B?TlkvczJYTzZaZlBxWmZFS1VtSzV1bnNDRFlDN2lLcHdzdkVXNlpTaSszeVpV?=
 =?utf-8?B?cXN6Wld2L0QvVEpxQWVpTGt0T3JQNUJ3NWZIRzFWblFtNjdEZldMU3dORzhu?=
 =?utf-8?B?ZnU0Z3p4WXNoREZSL0VVWmVvWDhpMlM0Z2czZmFkQy9rUTc3Yit4U1h4TllJ?=
 =?utf-8?B?TS83REs2ZW5qRzE0OVFNc1BlWEdaTURqQ1U0NkhMZEJMSHNhQzRidzJnSlRh?=
 =?utf-8?B?OHVnRU5GaGlzYzNLM0hLMkRJeGhtUmI0QTlCbThycDI1TnMxV2ZRSGtKYmtt?=
 =?utf-8?B?ZW9qUFN2TUJaYmNFYUxiM1BSWHkxcVkwazFOMTVPclJOSkFXNytZNnFXdEQz?=
 =?utf-8?B?cWlVcE5HRTNkS0RkS2VOeVJQWHB4dHNkUzJxRnA1WUhLYUplZFhYaFMzUGlm?=
 =?utf-8?B?bFF5L3J6SjRod0xXbWVaYU91S0lJMWhMdnlKcC9rcTQ1ZXZ1UElHeWVabGFK?=
 =?utf-8?B?eFlvdldPdUlWL1JnNXBSZVJ6eGtoU1E1SjluY2ZWcmNLb1hNcXRXZkhLNFIv?=
 =?utf-8?B?M1hSTythQzlnZkYyNzRMaE8zT1VzZ0dUeVA3OXErQ2NJTWNKMDB6VlJpeThI?=
 =?utf-8?B?eFk4TjZOaWg1WWx0Mm5BM09zandJVThuMlZ1akQ5Q1A5eE8wRnMreWUvZ3Fq?=
 =?utf-8?B?QzgvdUNiYkJjdlB4aHU4d2s5dkp3N1IxR3orWWVnczlKYldZOFFPK3RhRlRQ?=
 =?utf-8?B?dU9tZ2dwT01COFNJeWlvYWZhb0taeFVWU05DYjJUQklhWVoyZjBEeGtmV1BR?=
 =?utf-8?B?RlowKzgwNFZVbjZ1dGlxMmZMa2pxWDBUUEJPVlJFbVd3UTZCUm0rU1JrRXJN?=
 =?utf-8?B?aG5QcTJrY0FKTG9qWXd0Y08wYXRXcTBWUzA0QVFWMm1lNTFsbUlxdHdmU2hJ?=
 =?utf-8?B?L2lpZ0tDeHcvK2ZWUUIzWG9NczM4T2YwSC82Z1Y3Z0l5MjEwUWVyK2xJdFhn?=
 =?utf-8?B?K0xLRFc5dW13TUMwUkQ4TTBab045ZUsvMHdmSzRSSDQvREhLbHFHMjljbGU4?=
 =?utf-8?B?bS85enBBL1lsNXRnM1hkOTRmNWh1VEY2cVNia3FPckFOOWJTbG1LUUtBdkhk?=
 =?utf-8?B?U0pQbjlXdUhDZnJMb3IxeXZ0cjNzb1d4YjU5Smdvd2ZSMUlyOXZySjlFSnFY?=
 =?utf-8?B?a1NLaHF6UEI5YVFTZFZhMUZsNVRLbGtBTitXdW5DU29VamtNTlhlOVg2VkVD?=
 =?utf-8?B?R0Q5SDVEM05HbER3M0pObkY2UTVrQ1hXbndCblc4MDVhTnZseXhWOWIyUmxJ?=
 =?utf-8?B?NGhERGZMS1NndjRGU2N5SVl3cDlRPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <71D0061DF3997A409EA84F8C1C24A016@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5154.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b8f7009a-8828-463d-3314-08da01a42e71
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Mar 2022 08:09:49.0687
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7JtMangd8mWMbLMEmQNuDwGyfRpuSDhJdhQRKg2JLFRg8hX9c+oe8cuTXUHG/gCIWL7bgn7A+7XWxU2JTN2PCJKhzWdtobFCCdpfK3WfTPA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR1101MB2308
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,T_SCC_BODY_TEXT_LINE,
        T_SPF_PERMERROR autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMDgvMDMvMjAyMiAwNzo1NSwgRG9taW5payBCcm9kb3dza2kgd3JvdGU6DQo+IFtZb3UgZG9u
J3Qgb2Z0ZW4gZ2V0IGVtYWlsIGZyb20gbGludXhAZG9taW5pa2Jyb2Rvd3NraS5uZXQuIExlYXJu
IHdoeSB0aGlzIGlzIGltcG9ydGFudCBhdCBodHRwOi8vYWthLm1zL0xlYXJuQWJvdXRTZW5kZXJJ
ZGVudGlmaWNhdGlvbi5dDQo+IA0KPiBFWFRFUk5BTCBFTUFJTDogRG8gbm90IGNsaWNrIGxpbmtz
IG9yIG9wZW4gYXR0YWNobWVudHMgdW5sZXNzIHlvdSBrbm93IHRoZSBjb250ZW50IGlzIHNhZmUN
Cj4gDQo+IEFtIE1vbiwgTWFyIDA3LCAyMDIyIGF0IDAzOjQwOjIzUE0gKzAwMDAgc2NocmllYiBj
b25vci5kb29sZXlAbWljcm9jaGlwLmNvbToNCj4+IEZyb206IENvbm9yIERvb2xleSA8Y29ub3Iu
ZG9vbGV5QG1pY3JvY2hpcC5jb20+DQo+Pg0KPj4gQWRkIGEgZHJpdmVyIHRvIGFjY2VzcyB0aGUg
aGFyZHdhcmUgcmFuZG9tIG51bWJlciBnZW5lcmF0b3Igb24gdGhlDQo+PiBQb2xhcmZpcmUgU29D
LiBUaGUgaHdybmcgY2FuIG9ubHkgYmUgYWNjZXNzZWQgdmlhIHRoZSBzeXN0ZW0gY29udHJvbGxl
ciwNCj4+IHNvIHVzZSB0aGUgbWFpbGJveCBpbnRlcmZhY2UgdGhlIHN5c3RlbSBjb250cm9sbGVy
IGV4cG9zZXMgdG8gYWNjZXNzIHRoZQ0KPj4gaHdybmcuDQo+Pg0KPj4gU2lnbmVkLW9mZi1ieTog
Q29ub3IgRG9vbGV5IDxjb25vci5kb29sZXlAbWljcm9jaGlwLmNvbT4NCj4+IC0tLQ0KPj4gICBk
cml2ZXJzL2NoYXIvaHdfcmFuZG9tL0tjb25maWcgICAgfCAgMTMgKysrKw0KPj4gICBkcml2ZXJz
L2NoYXIvaHdfcmFuZG9tL01ha2VmaWxlICAgfCAgIDEgKw0KPj4gICBkcml2ZXJzL2NoYXIvaHdf
cmFuZG9tL21wZnMtcm5nLmMgfCAxMDMgKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrDQo+
PiAgIDMgZmlsZXMgY2hhbmdlZCwgMTE3IGluc2VydGlvbnMoKykNCj4+ICAgY3JlYXRlIG1vZGUg
MTAwNjQ0IGRyaXZlcnMvY2hhci9od19yYW5kb20vbXBmcy1ybmcuYw0KPj4NCj4+IGRpZmYgLS1n
aXQgYS9kcml2ZXJzL2NoYXIvaHdfcmFuZG9tL0tjb25maWcgYi9kcml2ZXJzL2NoYXIvaHdfcmFu
ZG9tL0tjb25maWcNCj4+IGluZGV4IDk3MDQ5NjNmOWQ1MC4uNjlmMWZkNTM4NTg5IDEwMDY0NA0K
Pj4gLS0tIGEvZHJpdmVycy9jaGFyL2h3X3JhbmRvbS9LY29uZmlnDQo+PiArKysgYi9kcml2ZXJz
L2NoYXIvaHdfcmFuZG9tL0tjb25maWcNCj4+IEBAIC0zODUsNiArMzg1LDE5IEBAIGNvbmZpZyBI
V19SQU5ET01fUElDMzINCj4+DQo+PiAgICAgICAgICBJZiB1bnN1cmUsIHNheSBZLg0KPj4NCj4+
ICtjb25maWcgSFdfUkFORE9NX1BPTEFSRklSRV9TT0MNCj4+ICsgICAgIHRyaXN0YXRlICJNaWNy
b2NoaXAgUG9sYXJGaXJlIFNvQyBSYW5kb20gTnVtYmVyIEdlbmVyYXRvciBzdXBwb3J0Ig0KPj4g
KyAgICAgZGVwZW5kcyBvbiBIV19SQU5ET00gJiYgUE9MQVJGSVJFX1NPQ19TWVNfQ1RSTA0KPj4g
KyAgICAgaGVscA0KPj4gKyAgICAgICBUaGlzIGRyaXZlciBwcm92aWRlcyBrZXJuZWwtc2lkZSBz
dXBwb3J0IGZvciB0aGUgUmFuZG9tIE51bWJlcg0KPj4gKyAgICAgICBHZW5lcmF0b3IgaGFyZHdh
cmUgZm91bmQgb24gUG9sYXJGaXJlIFNvQyAoTVBGUykuDQo+PiArDQo+PiArICAgICAgIFRvIGNv
bXBpbGUgdGhpcyBkcml2ZXIgYXMgYSBtb2R1bGUsIGNob29zZSBNIGhlcmUuIFRoZQ0KPj4gKyAg
ICAgICBtb2R1bGUgd2lsbCBiZSBjYWxsZWQgbWZwc19ybmcuDQo+PiArDQo+PiArICAgICAgIElm
IHVuc3VyZSwgc2F5IE4uDQo+PiArDQo+PiArDQo+PiAgIGNvbmZpZyBIV19SQU5ET01fTUVTT04N
Cj4+ICAgICAgICB0cmlzdGF0ZSAiQW1sb2dpYyBNZXNvbiBSYW5kb20gTnVtYmVyIEdlbmVyYXRv
ciBzdXBwb3J0Ig0KPj4gICAgICAgIGRlcGVuZHMgb24gSFdfUkFORE9NDQo+PiBkaWZmIC0tZ2l0
IGEvZHJpdmVycy9jaGFyL2h3X3JhbmRvbS9NYWtlZmlsZSBiL2RyaXZlcnMvY2hhci9od19yYW5k
b20vTWFrZWZpbGUNCj4+IGluZGV4IDU4NGQ0N2JhMzJmNy4uM2U5NDhjZjA0NDc2IDEwMDY0NA0K
Pj4gLS0tIGEvZHJpdmVycy9jaGFyL2h3X3JhbmRvbS9NYWtlZmlsZQ0KPj4gKysrIGIvZHJpdmVy
cy9jaGFyL2h3X3JhbmRvbS9NYWtlZmlsZQ0KPj4gQEAgLTQ2LDMgKzQ2LDQgQEAgb2JqLSQoQ09O
RklHX0hXX1JBTkRPTV9DQ1RSTkcpICs9IGNjdHJuZy5vDQo+PiAgIG9iai0kKENPTkZJR19IV19S
QU5ET01fWElQSEVSQSkgKz0geGlwaGVyYS10cm5nLm8NCj4+ICAgb2JqLSQoQ09ORklHX0hXX1JB
TkRPTV9BUk1fU01DQ0NfVFJORykgKz0gYXJtX3NtY2NjX3Rybmcubw0KPj4gICBvYmotJChDT05G
SUdfSFdfUkFORE9NX0NOMTBLKSArPSBjbjEway1ybmcubw0KPj4gK29iai0kKENPTkZJR19IV19S
QU5ET01fUE9MQVJGSVJFX1NPQykgKz0gbXBmcy1ybmcubw0KPj4gZGlmZiAtLWdpdCBhL2RyaXZl
cnMvY2hhci9od19yYW5kb20vbXBmcy1ybmcuYyBiL2RyaXZlcnMvY2hhci9od19yYW5kb20vbXBm
cy1ybmcuYw0KPj4gbmV3IGZpbGUgbW9kZSAxMDA2NDQNCj4+IGluZGV4IDAwMDAwMDAwMDAwMC4u
YTEwM2M3NjVkMDIxDQo+PiAtLS0gL2Rldi9udWxsDQo+PiArKysgYi9kcml2ZXJzL2NoYXIvaHdf
cmFuZG9tL21wZnMtcm5nLmMNCj4+IEBAIC0wLDAgKzEsMTAzIEBADQo+PiArLy8gU1BEWC1MaWNl
bnNlLUlkZW50aWZpZXI6IEdQTC0yLjANCj4+ICsvKg0KPj4gKyAqIE1pY3JvY2hpcCBQb2xhckZp
cmUgU29DIChNUEZTKSBoYXJkd2FyZSByYW5kb20gZHJpdmVyDQo+PiArICoNCj4+ICsgKiBDb3B5
cmlnaHQgKGMpIDIwMjAtMjAyMiBNaWNyb2NoaXAgQ29ycG9yYXRpb24uIEFsbCByaWdodHMgcmVz
ZXJ2ZWQuDQo+PiArICoNCj4+ICsgKiBBdXRob3I6IENvbm9yIERvb2xleSA8Y29ub3IuZG9vbGV5
QG1pY3JvY2hpcC5jb20+DQo+PiArICovDQo+PiArDQo+PiArI2luY2x1ZGUgPGxpbnV4L21vZHVs
ZS5oPg0KPj4gKyNpbmNsdWRlIDxsaW51eC9od19yYW5kb20uaD4NCj4+ICsjaW5jbHVkZSA8bGlu
dXgvcGxhdGZvcm1fZGV2aWNlLmg+DQo+PiArI2luY2x1ZGUgPHNvYy9taWNyb2NoaXAvbXBmcy5o
Pg0KPj4gKw0KPj4gKyNkZWZpbmUgQ01EX09QQ09ERSAgIDB4MjENCj4+ICsjZGVmaW5lIENNRF9E
QVRBX1NJWkUgICAgICAgIDBVDQo+PiArI2RlZmluZSBDTURfREFUQSAgICAgTlVMTA0KPj4gKyNk
ZWZpbmUgTUJPWF9PRkZTRVQgIDBVDQo+PiArI2RlZmluZSBSRVNQX09GRlNFVCAgMFUNCj4+ICsj
ZGVmaW5lIFJOR19SRVNQX0JZVEVTICAgICAgIDMyVQ0KPj4gKw0KPj4gK3N0cnVjdCBtcGZzX3Ju
ZyB7DQo+PiArICAgICBzdHJ1Y3QgbXBmc19zeXNfY29udHJvbGxlciAqc3lzX2NvbnRyb2xsZXI7
DQo+PiArICAgICBzdHJ1Y3QgaHdybmcgcm5nOw0KPj4gK307DQo+PiArDQo+PiArc3RhdGljIGlu
dCBtcGZzX3JuZ19yZWFkKHN0cnVjdCBod3JuZyAqcm5nLCB2b2lkICpidWYsIHNpemVfdCBtYXgs
IGJvb2wgd2FpdCkNCj4+ICt7DQo+PiArICAgICBzdHJ1Y3QgbXBmc19ybmcgKnJuZ19wcml2ID0g
Y29udGFpbmVyX29mKHJuZywgc3RydWN0IG1wZnNfcm5nLCBybmcpOw0KPj4gKyAgICAgdTMyIHJl
c3BvbnNlX21zZ1tSTkdfUkVTUF9CWVRFUyAvIHNpemVvZih1MzIpXTsNCj4+ICsgICAgIHVuc2ln
bmVkIGludCBjb3VudCA9IDAsIGNvcHlfc2l6ZV9ieXRlczsNCj4+ICsgICAgIGludCByZXQ7DQo+
PiArDQo+PiArICAgICBzdHJ1Y3QgbXBmc19tc3NfcmVzcG9uc2UgcmVzcG9uc2UgPSB7DQo+PiAr
ICAgICAgICAgICAgIC5yZXNwX3N0YXR1cyA9IDBVLA0KPj4gKyAgICAgICAgICAgICAucmVzcF9t
c2cgPSAodTMyICopcmVzcG9uc2VfbXNnLA0KPj4gKyAgICAgICAgICAgICAucmVzcF9zaXplID0g
Uk5HX1JFU1BfQllURVMNCj4+ICsgICAgIH07DQo+PiArICAgICBzdHJ1Y3QgbXBmc19tc3NfbXNn
IG1zZyA9IHsNCj4+ICsgICAgICAgICAgICAgLmNtZF9vcGNvZGUgPSBDTURfT1BDT0RFLA0KPj4g
KyAgICAgICAgICAgICAuY21kX2RhdGFfc2l6ZSA9IENNRF9EQVRBX1NJWkUsDQo+PiArICAgICAg
ICAgICAgIC5yZXNwb25zZSA9ICZyZXNwb25zZSwNCj4+ICsgICAgICAgICAgICAgLmNtZF9kYXRh
ID0gQ01EX0RBVEEsDQo+PiArICAgICAgICAgICAgIC5tYm94X29mZnNldCA9IE1CT1hfT0ZGU0VU
LA0KPj4gKyAgICAgICAgICAgICAucmVzcF9vZmZzZXQgPSBSRVNQX09GRlNFVA0KPj4gKyAgICAg
fTsNCj4+ICsNCj4+ICsgICAgIHdoaWxlIChjb3VudCA8IG1heCkgew0KPj4gKyAgICAgICAgICAg
ICByZXQgPSBtcGZzX2Jsb2NraW5nX3RyYW5zYWN0aW9uKHJuZ19wcml2LT5zeXNfY29udHJvbGxl
ciwgJm1zZyk7DQo+PiArICAgICAgICAgICAgIGlmIChyZXQpDQo+PiArICAgICAgICAgICAgICAg
ICAgICAgcmV0dXJuIHJldDsNCj4+ICsNCj4+ICsgICAgICAgICAgICAgY29weV9zaXplX2J5dGVz
ID0gbWF4IC0gY291bnQgPiBSTkdfUkVTUF9CWVRFUyA/IFJOR19SRVNQX0JZVEVTIDogbWF4IC0g
Y291bnQ7DQo+PiArICAgICAgICAgICAgIG1lbWNweShidWYgKyBjb3VudCwgcmVzcG9uc2VfbXNn
LCBjb3B5X3NpemVfYnl0ZXMpOw0KPj4gKw0KPj4gKyAgICAgICAgICAgICBjb3VudCArPSBjb3B5
X3NpemVfYnl0ZXM7DQo+PiArICAgICAgICAgICAgIGlmICghd2FpdCkNCj4+ICsgICAgICAgICAg
ICAgICAgICAgICBicmVhazsNCj4+ICsgICAgIH0NCj4+ICsNCj4+ICsgICAgIHJldHVybiBjb3Vu
dDsNCj4+ICt9DQo+PiArDQo+PiArc3RhdGljIGludCBtcGZzX3JuZ19wcm9iZShzdHJ1Y3QgcGxh
dGZvcm1fZGV2aWNlICpwZGV2KQ0KPj4gK3sNCj4+ICsgICAgIHN0cnVjdCBkZXZpY2UgKmRldiA9
ICZwZGV2LT5kZXY7DQo+PiArICAgICBzdHJ1Y3QgbXBmc19ybmcgKnJuZ19wcml2Ow0KPj4gKyAg
ICAgaW50IHJldDsNCj4+ICsNCj4+ICsgICAgIHJuZ19wcml2ID0gZGV2bV9remFsbG9jKGRldiwg
c2l6ZW9mKCpybmdfcHJpdiksIEdGUF9LRVJORUwpOw0KPj4gKyAgICAgaWYgKCFybmdfcHJpdikN
Cj4+ICsgICAgICAgICAgICAgcmV0dXJuIC1FTk9NRU07DQo+PiArDQo+PiArICAgICBybmdfcHJp
di0+c3lzX2NvbnRyb2xsZXIgPSAgbXBmc19zeXNfY29udHJvbGxlcl9nZXQoJnBkZXYtPmRldik7
DQo+PiArICAgICBpZiAoSVNfRVJSKHJuZ19wcml2LT5zeXNfY29udHJvbGxlcikpDQo+PiArICAg
ICAgICAgICAgIHJldHVybiBkZXZfZXJyX3Byb2JlKGRldiwgUFRSX0VSUihybmdfcHJpdi0+c3lz
X2NvbnRyb2xsZXIpLA0KPj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAiRmFp
bGVkIHRvIHJlZ2lzdGVyIHN5c3RlbSBjb250cm9sbGVyIGh3cm5nIHN1YiBkZXZpY2VcbiIpOw0K
Pj4gKw0KPj4gKyAgICAgcm5nX3ByaXYtPnJuZy5yZWFkID0gbXBmc19ybmdfcmVhZDsNCj4+ICsg
ICAgIHJuZ19wcml2LT5ybmcubmFtZSA9IHBkZXYtPm5hbWU7DQo+IA0KPiBJcyB0aGVyZSBhbHNv
IHNvbWUgcXVhbGl0eSBlc3RpbWF0aW9uLCBvciBzaG91bGQgdGhpcyBod3JuZyBvbmx5IGJlIHRy
dXN0ZWQNCj4gaWYgaXQgcGFzc2VzIHZhbGlkYXRpb24gYnkgdXNlcnNwYWNlPw0KDQpUaGVyZSBz
aG91bGQgYmUgYSBxdWFsaXR5IGVzdGltYXRpb24sIEknbGwgYWRkIG9uZSBpbiB2Mi4NClRoYW5r
cywNCkNvbm9yLg0K
