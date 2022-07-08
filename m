Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2E8256B4C5
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jul 2022 10:51:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237684AbiGHIvO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jul 2022 04:51:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237248AbiGHIvM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 04:51:12 -0400
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02949823A5;
        Fri,  8 Jul 2022 01:51:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1657270271; x=1688806271;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=qRvdSYVm6JNqT11UlZNK/sOd0xR+IfpexH9sAfY88QU=;
  b=hf0PW4k9j9l9AA3hw3iFpQ+mgR2RFXdiQOKTdgcvyHj4O3wPRTS9H5o6
   gnM32KnGHnA2Vytr9R4Y7YKUXMEKNjjWoUL+N08QxbqakkveNv/F+dLpm
   BHLZG5tpUaRPB6d+Y2A4JVOpA45SrKQZHzwqcHNg7qFV906Fdev55ANEG
   MlsDXZGapSgV7wycTu+aCiKENgj5RL0/zz6OGNP94VJJBSZhzPDi5xNEg
   Tnxy78EOBdsPPXFImApe2+wf1v4rQ+TTpoSsYvJ4IizQq1dJxambYSp4s
   OxPCh+pUur31Rx5PsneL3jjuR69slkbsKU/FR3T9yjMv6rx9+w9DdTi4F
   w==;
X-IronPort-AV: E=Sophos;i="5.92,255,1650902400"; 
   d="scan'208";a="205173880"
Received: from mail-bn1nam07lp2042.outbound.protection.outlook.com (HELO NAM02-BN1-obe.outbound.protection.outlook.com) ([104.47.51.42])
  by ob1.hgst.iphmx.com with ESMTP; 08 Jul 2022 16:51:00 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LVAZEcrkNhtBU6r8dOu2cx8pPGuc1S5dKFifoTN2OeIQys8GPsXKVeFG7hLL55dB3+43E+Sd7WL4VVe9vWksgXmdjPmwnpYHHyq5xOyZXOakOPtB0gxMe5SCGoiiO+GhnkQnhKqdA1PAEVUYTkB0rGDduQoWPY/ytcZY5WPnapF6Eoi2nJ4+G1BEkoQ99Vz+jbQ8X+voFIMit2cLdrj7JWbRCtilvwZGEKeNk9coj0RaiqiSC/HtGraNPWfYlx/4tmWC+irXFV1qxaTEjYMOLjhimbDr1qeru1reiBg672j8DnXbYAYxJHAwS2YeeiYSxyKF1kUSlGXDUmkr+IWoRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qRvdSYVm6JNqT11UlZNK/sOd0xR+IfpexH9sAfY88QU=;
 b=nX0YtuLnzhKOeFIoa60Jh16Z+9PkJeh47IpViZRrB667OlvWw0BIs54OqQ0jRYLdtk9RX8h1aVhDGUG7cb2NIItHKjCcZhTpMqfqW/PeDK261yGnUn+LJX2TKK7tsostVHIx2r7wiCnU+gkU8LFlHH/Lx/5/tW6ISKGCKX1xlloEAZA+N1/5QhIz8BemGb8NVJEd0UiciPHEIsuLbBQI1M+vXyix8iz3LzvTo//9XSM8vwNp3Y/1KiihD5kR9SdjbrMoS/q/vsDzdcWSmRTzUF4dP/EAheGbCgcbF4FXZiNb6tdO9kYcxsbkL+ZXeH8uueuuLXqu7+FzVNvEmZ6uEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qRvdSYVm6JNqT11UlZNK/sOd0xR+IfpexH9sAfY88QU=;
 b=k0ls/hqmaAzhP5X6EqcO1gWxyK77gbu/mvG51AM+nTKPkT0HoULjSMzEilC6EaE9ctaRsHr9UZdJ+IN9pfiQHgLaEXddTDE9rv6cfLzb/n0dwcNy96jpvHGhhIF9uxmuXkhnxxn3i/4kt7IdMvY9ahA+eBxrBfLA4HmjpbTlodc=
Received: from DM6PR04MB6575.namprd04.prod.outlook.com (2603:10b6:5:1b7::7) by
 PH0PR04MB7899.namprd04.prod.outlook.com (2603:10b6:510:ee::23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5417.20; Fri, 8 Jul 2022 08:50:57 +0000
Received: from DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::5d26:82d8:6c89:9e31]) by DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::5d26:82d8:6c89:9e31%8]) with mapi id 15.20.5417.016; Fri, 8 Jul 2022
 08:50:57 +0000
From:   Avri Altman <Avri.Altman@wdc.com>
To:     "keosung.park@samsung.com" <keosung.park@samsung.com>,
        ALIM AKHTAR <alim.akhtar@samsung.com>,
        "bvanassche@acm.org" <bvanassche@acm.org>,
        "jejb@linux.ibm.com" <jejb@linux.ibm.com>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        "beanhuo@micron.com" <beanhuo@micron.com>,
        Daejun Park <daejun7.park@samsung.com>,
        "adrian.hunter@intel.com" <adrian.hunter@intel.com>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] scsi: ufs: core: Remove UIC_HIBERN8_ENTER_RETRIES
Thread-Topic: [PATCH] scsi: ufs: core: Remove UIC_HIBERN8_ENTER_RETRIES
Thread-Index: AQHYkopnWVgHGcYWz0qxaJFfhAx70a10KnCg
Date:   Fri, 8 Jul 2022 08:50:57 +0000
Message-ID: <DM6PR04MB6575FFDDA469F747AE0471EEFC829@DM6PR04MB6575.namprd04.prod.outlook.com>
References: <CGME20220708052006epcms2p2d1129dbf95fd77f46906200ccb0a9ccd@epcms2p2>
 <20220708052006epcms2p2d1129dbf95fd77f46906200ccb0a9ccd@epcms2p2>
In-Reply-To: <20220708052006epcms2p2d1129dbf95fd77f46906200ccb0a9ccd@epcms2p2>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c05c2c66-59db-42f6-af88-08da60bef9e0
x-ms-traffictypediagnostic: PH0PR04MB7899:EE_
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: h+BMJXTdY4vJ3E9cYs+gdgLbie02aWYNxH3YcQEkJzWmqxaxakmJ+MKkSak8c1aoWyJsh8F5tavKZl1QXEgkmUzGXBEJhe/WWFzq39P/63RloadydsvUi1gXiQrJhXuaR/A1PdXMo7upl4uTdxl5S13t6uONWNJ77XYDQe0LYcottMrvMqF+jOjx6kyp0TizZOrb0TGeqgs200HZKBR+cFBWLVUriMAsDvFWVRPTpohjpSyu3zM1TxuHlkciCMQbB0/eeY22+1bph6VzvGjSvphwn3PwXA7pyWR8b7v2oCV+JW+C8dhasx1TdcS+XoVquHQmEv3QAB6HFgnBAhtHKKrEfAcW4KlHL/xZycSmSnLUujlyfA58jNVzJ/JMFxBgINyROZr3JWDoKBiEqg1uogzW2qMIcMzzCeYeFcOQdWnipu9orKkRTJ459ZsxKJElHMkrNBltZe+Ly8hncIV3XQqTbFW5o/HgyKXvA9B1eVQWILokKrcIMLhdeVxnAup/lgj9eqy/OV1X56K9QDYA1lWqyb3gPOBkDKWX4EE10wmyHdtkIbgGri2GkVAt9/DaZXt+f9qWI+UrM8frRr+UqaGbzw4bwkkQ6BqNVPmzf+FZX4CD5OUDZwdYCUlNkUjxLaqj6hsn+Zr3g5y4kaFBE8dKLF03y80STIonG7gPV38ziJMGHB9LOoK0XrvdOj9t0b6Azv2iRzDwi9giQaYAyzsFrXCdl14Up05lg/S6L1hIWKOavoZgii9hzvLV15Bd5bsm7zaParOye9J2bfprtBNLFFT+yuTjor4fUb3Li7pZgafcAcgWvKggAKJNztK7QjEtBOL53rNASi+zrD1vgQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR04MB6575.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(39860400002)(346002)(136003)(376002)(396003)(38070700005)(64756008)(82960400001)(66446008)(66476007)(8676002)(66556008)(66946007)(26005)(71200400001)(9686003)(41300700001)(76116006)(7696005)(6506007)(921005)(86362001)(186003)(122000001)(316002)(478600001)(110136005)(2906002)(38100700002)(33656002)(8936002)(7416002)(52536014)(83380400001)(4744005)(5660300002)(55016003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YnZnUVdYNW91Ykp2cEQxVVBVL0dxY3UxTU9hVXBVU3NvL0VWVDdYMkYzRU9Y?=
 =?utf-8?B?MWhwZnp1QzYyT3duVXhBeU1mbGVncWMwQThadFZBcEZnMHpJSXRuNVMwK2JG?=
 =?utf-8?B?RnZjc0QvMG9UVmVhbklYM2RvL0g5Z0NYbGJnUXF3eVlKL2lGVjhFR2NVUUh4?=
 =?utf-8?B?Zk9aV3F3Rm10KzlNb2lnSkNDc0g5NkpMVUV5M0dhRGFiMXU0WE5TUk5ZS0JE?=
 =?utf-8?B?bTV5cEdveWhMOGhNRlhFNnp0UDA3RFJkQU8rN3VGa2xuMGJEYVJPeGxrSGlK?=
 =?utf-8?B?MnRyd1ZUcUVCaHA4TkxWSGtqTEQ2YmFKdTlORHM2UExMb3dlZEpla2hlL05U?=
 =?utf-8?B?K0s1dEJjM2swSVVYY2NRZlpnNWJuY2JDdmtIc3k2elQvWlpmUjBpS1ZDcDFq?=
 =?utf-8?B?cWd6OTVqcWNRVDVnV1YrdVB4dXVFQ2F2Y2NzcUtFMHVCYWdCK01lcjJGTGlp?=
 =?utf-8?B?THkzL1NMVTl3SStMM29TUmhGMFF1MGxLSkgwNmxtWTNSWVBTa09QWk8wRWhV?=
 =?utf-8?B?QkhyYTEyQ0x6MHFaNHRnanhKbm96UWFyZVdzYnR6RlM0akRGcVk2bWc2bS95?=
 =?utf-8?B?MElma1FCaXozN3NETHU1U1dXRlNJTW1ldFhHYjJNOVoybzRvTE9BOUJWbXFR?=
 =?utf-8?B?OVgxU0pqTy9xMWlnR0tsRllCeFJBQkl5b2hranAwd1BJNm9KZ1g0L1g5SlZ3?=
 =?utf-8?B?Q3ppT2FjYit6dWZDblFyVDFQekRycWRxMC9POGVZWUV5MUtiRjNNRUhzdVcr?=
 =?utf-8?B?QXZpMXdpOFlkL1FVbU1oMEZwNVRsZjJ3ZUhJdExSbTZPbFJKMDVrQnNYM1pw?=
 =?utf-8?B?K2NONGtuSVVLQk1GVW5hbnRhbytDUEhGTHlZQm1lTTZ1NHRwOVB5ajhHaFdh?=
 =?utf-8?B?QkpwVTBPcmlNdktPMFdVamgyV1dhcHBPMmR3UTR3MllyM21iMkNOcUptMUJw?=
 =?utf-8?B?V0lyWTRrUENEeS93cWJuUmlTTVZ4OFFvSlY5dlg2eS80ZDZKY1g4WHkrQkFk?=
 =?utf-8?B?MjJhUjhvSGZ5WnJOUGZ3OVAvekZ1dVhud0R6RkxDcG4ySUhuODVLQWVHM3Mx?=
 =?utf-8?B?VzFHWTlkRDZlclNZVnJMRVkzMWJaWERTVVhCVS92UlUxTCttT2IxMlczQThX?=
 =?utf-8?B?bmJsUko4Ymw4OHExTVJjcnNCemx0b0VBbXpjT01vWDh0Qzd2U1hva3hSK1g0?=
 =?utf-8?B?aTQwQnlFT3V6VWw3bkVjbCtxOXJqNEtwcnpyN1RUaW1NNGxBM1FQVFQ1Ykhw?=
 =?utf-8?B?MFlobUh2UGpxMm8rZXU0RG82U09HTGR5QWtxTjRCMnp1UEVBTS94OEszR2M2?=
 =?utf-8?B?YzhPeE9ZVEdWU1JQNDIvZ1VsVkFZVWh6VFNqdDc1OE9vVDlvT21QS0dsVmRV?=
 =?utf-8?B?anJYbk95M0NLS21SY290NmxJb2ZuMGhnaUVVQ2hhUUlqalAydzlRVjI0L1Fm?=
 =?utf-8?B?cG5mY09qcjY4cDZKNFowZkRzbzVwRzc5cURlaFFYOWMrVWdNMU01bmNpNjg3?=
 =?utf-8?B?OVBCcDlmSk1WNFhWYjYrWDR4aFBGeHdBQk5hOS8wc1FYL2VZOVk1V3J5RStT?=
 =?utf-8?B?WEJTa0Q1dDhIb2VUQVEwNW5YUmJibFRIelFOQ2NiSHRQQTZIM0dTb253R041?=
 =?utf-8?B?SVBybXQrSjllZWRFR29hNEhqc0RZa2dhQ3BvTUVVWlJsdkNkWlo1OTFSZHF1?=
 =?utf-8?B?N0ZmN1lQSnhjQTQ4YkYxdjZjZW1FZW53ZmxSQVhGbWlTbFgyVWhUY3FQZFRv?=
 =?utf-8?B?akR4N3k2THFKeWZCSXdNU1RvL3NjV3RFN1pMTlg5WWhNSlZYNFVNeE8wMmpR?=
 =?utf-8?B?VzltNHNYTmhOUXRNKzYrekdSODdUZzNkUC9sK3hia1FBZzkvbEpUc09kaWZF?=
 =?utf-8?B?QWhQdjhrT3REK2dXZWtsd2xVcTMyNERuUWNkayt2UkhzdU9mNmNuU3N3N2E3?=
 =?utf-8?B?Q2FDeDkvWlZlWktFdkUzekYzejB5clJyalp3MVpiSFV2ZEwwek9SWUpUREJr?=
 =?utf-8?B?L0tQOEpKMUsyTzZQY2dCdnZLeEZmdGtJV0dReGQ1V0thY2xOZHJqOXRoQXVk?=
 =?utf-8?B?RGRpN2JBdUlTQzNGZk9zVmhuaGhGZ1dJWG9VcTV6WDNrSi9JWTVSS0hONEhu?=
 =?utf-8?Q?keSe27IX8FkwZerNLbGa6JKy/?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB6575.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c05c2c66-59db-42f6-af88-08da60bef9e0
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jul 2022 08:50:57.8182
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qfoM77Bb9Avh1mGy1E4VV2Gl4ZwneLJ0x6n93h70/7H75mjHwLxIkrdAwvP92QmMGW0xyrknMQDENBgzjrMs5A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR04MB7899
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

IA0KPiBDb21taXQgNGRiN2EyMzYwNTk3ICgic2NzaTogdWZzOiBGaXggY29uY3VycmVuY3kgb2Yg
ZXJyb3IgaGFuZGxlciBhbmQgb3RoZXINCj4gZXJyb3IgcmVjb3ZlcnkgcGF0aHMiKSByZW1vdmVk
IGFsbCBjYWxsZXJzIG9mIFVJQ19ISUJFUk44X0VOVEVSX1JFVFJJRVMuDQo+IEhlbmNlIGFsc28g
cmVtb3ZlIHRoZSBtYWNybyBpdHNlbGYuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBLZW9zZW9uZyBQ
YXJrIDxrZW9zdW5nLnBhcmtAc2Ftc3VuZy5jb20+DQpSZXZpZXdlZC1ieTogQXZyaSBBbHRtYW4g
PGF2cmkuYWx0bWFuQHdkYy5jb20+DQoNCj4gLS0tDQo+ICBkcml2ZXJzL3Vmcy9jb3JlL3Vmc2hj
ZC5jIHwgMyAtLS0NCj4gIDEgZmlsZSBjaGFuZ2VkLCAzIGRlbGV0aW9ucygtKQ0KPiANCj4gZGlm
ZiAtLWdpdCBhL2RyaXZlcnMvdWZzL2NvcmUvdWZzaGNkLmMgYi9kcml2ZXJzL3Vmcy9jb3JlL3Vm
c2hjZC5jIGluZGV4DQo+IDFkMzIxNGU2YjM2NC4uZjZiMzZkMmJmYTIxIDEwMDY0NA0KPiAtLS0g
YS9kcml2ZXJzL3Vmcy9jb3JlL3Vmc2hjZC5jDQo+ICsrKyBiL2RyaXZlcnMvdWZzL2NvcmUvdWZz
aGNkLmMNCj4gQEAgLTY0LDkgKzY0LDYgQEANCj4gIC8qIG1heGltdW0gbnVtYmVyIG9mIGxpbmst
c3RhcnR1cCByZXRyaWVzICovICAjZGVmaW5lDQo+IERNRV9MSU5LU1RBUlRVUF9SRVRSSUVTIDMN
Cj4gDQo+IC0vKiBNYXhpbXVtIHJldHJpZXMgZm9yIEhpYmVybjggZW50ZXIgKi8gLSNkZWZpbmUN
Cj4gVUlDX0hJQkVSTjhfRU5URVJfUkVUUklFUyAzDQo+IC0NCj4gIC8qIG1heGltdW0gbnVtYmVy
IG9mIHJlc2V0IHJldHJpZXMgYmVmb3JlIGdpdmluZyB1cCAqLyAgI2RlZmluZQ0KPiBNQVhfSE9T
VF9SRVNFVF9SRVRSSUVTIDUNCj4gDQo+IC0tDQo+IDIuMTcuMQ0K
