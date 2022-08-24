Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E94159F70E
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Aug 2022 12:03:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236044AbiHXKDY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Aug 2022 06:03:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234677AbiHXKDW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Aug 2022 06:03:22 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A83D7962A;
        Wed, 24 Aug 2022 03:03:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1661335400; x=1692871400;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=1hvHrlQTNwAC2QOy3tmcI1i1Us9H5Ik764hl8tC6FHc=;
  b=IHnBvWItvjsi1Z1wPDHF9m/8/pFnUo1qoLcIKfevzCeeC//PJ5+zcpR/
   bPa/E0XDaYpInpvGCa1Xcjm96voCE/lydGd8/8q51OHUMK2qZIGEkbyHC
   /CgVF0z+dzs2QYAjTvP8U1nodK9FOYp9bEA50WNhUDmRUZU5c1VmeZYeq
   DsIk3B4qWR3qm8K3x7HPxVt7NobkJa4AwvhmBlZU2Zq0RK8Y7FBCDo3Qo
   M2WrbVXXqzFr8Jlk7xN7wOpWAAJxcdP8v9pmgxuo7K+rLaWynzdothwSY
   WWoNRM2OlfhhQibJ07CvrShzisgnM0gq2l0kJd8unyHlvS0xyzEHdrWLw
   g==;
X-IronPort-AV: E=Sophos;i="5.93,260,1654585200"; 
   d="scan'208";a="173891712"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 24 Aug 2022 03:03:20 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex02.mchp-main.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Wed, 24 Aug 2022 03:03:20 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.12 via Frontend
 Transport; Wed, 24 Aug 2022 03:03:20 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aOtVBugTm65Tc0U3NT0D+uD+MZVWsnKiewTUmlIwdFexyeMfTrmYoVOHDxrWr85uB3aye/C6FplBsDOG8y8abS/EcjPnuzPyqC1gznxFLgWV4Ukdznh2wtUE+1R2o/AlRok8F/S37yumT6QWIbwDtjPaXqzx3dnVYMIh7heopIyl+OMKs9NiFeuPg2Nu1X/9ZHkaxLr1k/Va+y51qEfBDINUahg2JagVe1UYaaYqtyI/DJ1GybnT8kmWJo5GShg8k610DItwGuioJe2Y/Xk1kW1geJdzvVsKzTDOtRqBEXgUiNnbHvDhJieqsFaT2Y+o5pCY3ycYqqJzOoc2VKfXyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1hvHrlQTNwAC2QOy3tmcI1i1Us9H5Ik764hl8tC6FHc=;
 b=GJUvleSgQ9cXGmTydGfBREYdQUQgRJaj2UAs89q4E8vreoLRkg5Ilk78G7owWwzblYfyATtaCW5xPG2ig4xSKd1miD12NUtABR+Lh1otMjPEyF/NjAc28lrggwyQdl+E+XG5hfnurJbBeco7QhOrxnnwo6Vy+5JlSJClWeuEq0XL4nJBI2H3/wasS9m4BQhv7HePHb7bMa9NXmphX9cZiw3KGQRGX4J9KK3fAGdzDLXioGksZrb19THkmqtMYghvG+QseFFpyptt8RAC1+sDmyRiFsbtPqo7Z1hB5ia1H5iDjJLkIiVBhwPSl8gpbFhrBOuFPm73amNtoSi+PyVZLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1hvHrlQTNwAC2QOy3tmcI1i1Us9H5Ik764hl8tC6FHc=;
 b=FOjyjjfA/NpADIhQFj9EhOiiMACCP9gxBpmdFNoSAOgKwSnbwL69Bpc2hig8ATmWYr1NBhsFvCgzr2+LTAHLcUjupu7x87kMSjRgqIqSV/W8KmA/c9bXgH3+rXtKL3qBd0p269oFX5/BEeekJiQhVWzR3RSWU2HACiSmOzOmKYw=
Received: from BN8PR11MB3668.namprd11.prod.outlook.com (2603:10b6:408:81::24)
 by CO1PR11MB4866.namprd11.prod.outlook.com (2603:10b6:303:91::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.15; Wed, 24 Aug
 2022 10:03:17 +0000
Received: from BN8PR11MB3668.namprd11.prod.outlook.com
 ([fe80::8982:37b8:a755:ace6]) by BN8PR11MB3668.namprd11.prod.outlook.com
 ([fe80::8982:37b8:a755:ace6%4]) with mapi id 15.20.5546.024; Wed, 24 Aug 2022
 10:03:17 +0000
From:   <Kumaravel.Thiagarajan@microchip.com>
To:     <gregkh@linuxfoundation.org>
CC:     <dragan.cvetic@xilinx.com>, <linux-gpio@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <UNGLinuxDriver@microchip.com>,
        <arnd@arndb.de>, <derek.kiernan@xilinx.com>
Subject: Re: [PATCH RFC char-misc-next 1/5] misc: microchip: pci1xxxx: load
 auxiliary bus driver for the PIO function in the multi-function endpoint of
 pci1xxxx device.
Thread-Topic: [PATCH RFC char-misc-next 1/5] misc: microchip: pci1xxxx: load
 auxiliary bus driver for the PIO function in the multi-function endpoint of
 pci1xxxx device.
Thread-Index: AQHYp/GFfIQcB8PREkWNurNJ2Avn2q28demAgAF8B4A=
Date:   Wed, 24 Aug 2022 10:03:17 +0000
Message-ID: <ade486645b0e800afb5478a3e5b4bf853a65cc6a.camel@microchip.com>
References: <20220804163219.921640-1-kumaravel.thiagarajan@microchip.com>
         <20220804163219.921640-2-kumaravel.thiagarajan@microchip.com>
         <YwS46X73H+J0yVJr@kroah.com>
In-Reply-To: <YwS46X73H+J0yVJr@kroah.com>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b710da3a-7e65-4027-0a11-08da85b7ddbb
x-ms-traffictypediagnostic: CO1PR11MB4866:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8NEYwtnPj0bt0XwbNvx7gaoO2B+8TiOqlu1kJN48o5ZSG14A+pRt/6RK1prHSfIDCOjsKFTb0TxRz8JRDw7QYKVnRuz8qgfLpUaiS4omaZsr0Nt64CC45MQvB/TOtjtuRBq8cOqzvtZBBXT6/VyZHP80w97Xdt5fsBj5Jyxxb+/js01ll5Kia39E6u85lvOsv55MXqWKWGfltbWodeF5s5ZhXtKhjAg7UWmQ2HI/TRcZtyi8AklDCrgksmu9srcOn8UD5mCDGy1Mymo+eC64aTjgdvIhmllZf2ARpcL5RettpwNZUv63XJpI5TpkUsvsCuB7XyQfEutzHFKbsNWtpWYsp2G2S/KQMY9I5C9PcO+efmA+IksmDQg9ArEZaWL4X5DaJEKwLC7v5U322R51QTMn9ybpDX6tMzDfc3lwWLKeYmgxr4sXSNvRSAvubbpvLRdrj2V/mW3KQtH5IjKMdDsYGL/u4YrKdxWOxYp27s+fxVTob6OsRQNolA6FwX5QXsQ3aKFfeUFMoG5wJ+VaKRtxnNnQbB5bMjNKMMUH5xzSX98BegJF1eU+We+KxolftI9K5Y2ejHTlpzkxmPETqF3vK5liLt6zSs2j6G2f5phJzITJEgJFDvTE/TE/7mFtFU70EZtg8lRd5hEahQMnICY9ZVJ4pKIH3aCEJMkyhawfDGhNq99dQO5dcNndKFModAMMAZOANAyYn2m2rESK6zYlmgARiNBas1GwJRg5brJSoEgqOnMeeVo1O08Pl6TzYGjUim9bxG38IHZLxwUMueWd48ci/0Fiios1sGs2sSs=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR11MB3668.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(136003)(39860400002)(376002)(346002)(366004)(396003)(186003)(71200400001)(316002)(6506007)(2906002)(8936002)(478600001)(5660300002)(4744005)(86362001)(2616005)(41300700001)(66476007)(66556008)(8676002)(91956017)(66446008)(4326008)(6512007)(26005)(64756008)(36756003)(76116006)(6486002)(122000001)(38100700002)(38070700005)(6916009)(66946007)(54906003)(32563001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QnZYWDhDSEkwa0ZnMHNNVUFxK1Q5Ujd4bkVpbkF2SlNiajI0WDkwNVc5TmEy?=
 =?utf-8?B?VW04MGFmLzRpNzE4eStjNDdMNXE5dDB3TFphSEgyZEx1dy9ETDVuWXhORnFx?=
 =?utf-8?B?UWczWFR0Z1Z3Z0IwSEJsK3FtQ0JIaGk1OFhaVlB1b3F0RGxWc0tiNWlTNzN0?=
 =?utf-8?B?aWhLVFNOSzE3K1NIU1Yvc3VsWkp0cUl2R3BGZ2xJdzZkbm45amJyTE4rRGpG?=
 =?utf-8?B?WnBFNksxZENsdld1M1c4Rm9jR2R1VmNGZXdjU3lVRjFQVGlJZlpFU3dKTzEx?=
 =?utf-8?B?YnlTa29zeitkRTVKd1dudnFIYWtieXFHTXh0cTBncEd5NytOSUlYcHdWZU9E?=
 =?utf-8?B?N0N4VXZQMjl3blZocG9qZG1IelQ5RitKcjd2VXZtSFIwR0cvQWcrM2VCRXBi?=
 =?utf-8?B?c0s3R1lTd1hGdlNOTzVONW8rY0RXN0VaZmpIVkE3VU1ocHdZVDdLUk1rOUl2?=
 =?utf-8?B?QlF4TnJLVEY5dU9FVWdxUUd0NmZjd3BRbDVTeE5lU2I4ZjRMeFBqTjZZaWI5?=
 =?utf-8?B?bk9LYzQ4ZWI2SkhPbHF2ZGl0WnpCeTVIUEhkSmlvUXZmcmh5SDhxa0tvQXF2?=
 =?utf-8?B?bnBZSkRUZmR1ZTFCRldiWElYSEpGeHJRY013c0UwTTJVNTlIVTFPTDF1RFZE?=
 =?utf-8?B?NU05MEJGa2NqS1V3R0xUb2RoSXFVSGQ2a093dHJSL1Zyb2VxdEZpSHRuSWo3?=
 =?utf-8?B?aE03bnNZaVhHWWYyVlJJaW5uVDUrUUFPcGt1ekNYZ3AyaWhSZ1NtT1A2UXky?=
 =?utf-8?B?ZDJHb1Vwd1JPUUQvLzFHdHVkNzJlL29RLzZaRDJJYjFHU2pibmFwOTdWMWtp?=
 =?utf-8?B?dU9XWmZoTWhBdHNNZXllcUJTMUs2OHFLMUg3THBwV3g4eVcxU1l0cTBXSUtu?=
 =?utf-8?B?U0J4RzF4WFJMajFZQkYyQlVGSUM3WnZUQ1dTZlNjZGhVOHowcFI3cGVONGVh?=
 =?utf-8?B?TENDeW5WSDNkZmx5ZnRwUFdTb01RSFhhVGhEU0FlWktLY1BieFpzQWdRd2FM?=
 =?utf-8?B?OThWZFEvNWFkZFVvZWFnUm1sdmtRUDFLZ1UxRVY1ZDU3WXNkOWc0aGlXNHJo?=
 =?utf-8?B?WHhMQ2h4U2N2OUVLSDBSYVV2MTNJdkhYK0lSMkk2eFhSeE94WjFOalpIVkor?=
 =?utf-8?B?YWJycFRZOGhEU2xpdjl0TXRhaW56K0NVUkFITzJHTmsxczRrU2pIQm1FTnZm?=
 =?utf-8?B?OFlsUXRDYUI1Tyt4R0MwbWY0OGhrazlhZ0N3bE1GZnhac0tpM1NKMUZra2JB?=
 =?utf-8?B?UVZhL1RWa1lpcXFBbDdxQzhycElvY1dVUS85NHdkQVFHVmt2R3dmTVM4UG1N?=
 =?utf-8?B?S1piVU8rZDB6TXR4RmoyTS82bTJvTGhFVlFFM1A3VVRPRExBcmozTHVIWXpl?=
 =?utf-8?B?ZUhIOTZORnVOeDlOeHR1d3ZBS3l2azZsNDJjcXVJdUJxTUJnNHNZWTd6Zk0v?=
 =?utf-8?B?T25DbzljT1ovKzZXNFZidGpia2Nvb002aEI2eS9WemVoRGp2ZjI5d3hoNU5F?=
 =?utf-8?B?TXdRNWtwSmltTFk1cnFOQVRFa1ZZQ0pwRmhOaDFhMWdpajBBelNUMSszS0Vn?=
 =?utf-8?B?Y0dER1BjZGU1emJ5SG9kbEtqTFlVbmU5Q2Exb3FpVWZ4VkRHWlEzZXdsR2VD?=
 =?utf-8?B?bm8rOUhUdmRuaDVheGxRNXdtbHN3dXNCYWU4UktBNDA5V3RRMFVLanlHOFlE?=
 =?utf-8?B?aGptZUF4Y3loc2hJQmxXNWc3ZTc2alZUZXNzb1o2VWVGcE85enl3QkgrenJB?=
 =?utf-8?B?K0xWMENOSzA1TW9YUmxNL2ZJc0FsVGxQZ2JnQ1RhbWpuKzdGcXF0U1RydlJB?=
 =?utf-8?B?cVVPTDdIUXZjem5Xb3JWUXFHQlBNbnFpcHljU3pWanJkYzNRbHc1NFM2ZnVB?=
 =?utf-8?B?dDdFNkNsL3hheUVIY3EydEtaUUV0dWp1TWM0Nk5HNUJ4OTRPb1NvM2o0cWlP?=
 =?utf-8?B?MUlZNVFXcUZrMyt0M0xMaVhmbmcvT2F0OUthTVNYT0ZDWndsTEdMYWlTMlhx?=
 =?utf-8?B?ekhFY2VtZ2dhTm9rYmhuNGFGMkd0bkFSQ3hNdGdTMTJ3VE5ydGczbzltR0NM?=
 =?utf-8?B?eGJ5MEZVcTJXUWlhb0pKVmswdEtsN2N3MWNBa1NwSlRZVGIxR3E2WTBBcGp1?=
 =?utf-8?B?MlZyZXdmb2YzQW9qN29FdnFCSGM3T3BmNUpHL25TS0ZFZ2o5d3dudzVpWTFm?=
 =?utf-8?Q?Gk4azKd/i8r2KYMRR0QYBQOuChq+WNvCXTqwrs0u7WB2?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <0C57CBAE90A12C43BAA2235889E44932@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN8PR11MB3668.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b710da3a-7e65-4027-0a11-08da85b7ddbb
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Aug 2022 10:03:17.1722
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: B6Nb+FYVDApMaUmBbt4yr6d0/B1i12UGgkSDbv+pnVmjjEE4IyiYPO8wMWfLK3GD42/Y84ENpJLxSa11iwyc60iAmOLFGn2VDkLBUF/Pg2fsI10tFj1KSxR7frAAM0JI
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB4866
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVHVlLCAyMDIyLTA4LTIzIGF0IDEzOjI0ICswMjAwLCBHcmVnIEtIIHdyb3RlOg0KPiANCj4g
T24gVGh1LCBBdWcgMDQsIDIwMjIgYXQgMTA6MDI6MTVQTSArMDUzMCwgS3VtYXJhdmVsIFRoaWFn
YXJhamFuIHdyb3RlOg0KPiA+ICsvLyBTUERYLUxpY2Vuc2UtSWRlbnRpZmllcjogR1BMLTIuMCsN
Cj4gDQo+IEkgaGF2ZSB0byBhc2ssIGRvIHlvdSByZWFsbHkgbWVhbiAib3IgYW55IGxhdGVyIHZl
cnNpb24iIGxpa2UgeW91IGFyZQ0KPiBzYXlpbmcgaGVyZT8NCg0KSXQgaGFzIHRvIGJlIEdQTC0y
LjAgYW5kIEkgd2lsbCBtb2RpZnkgdGhhdC4NCg0KPiANCj4gPiArLy8gQ29weXJpZ2h0IChDKSAy
MDIyIE1pY3JvY2hpcCBUZWNobm9sb2d5IEluYy4NCj4gPiArDQo+ID4gKyNpbmNsdWRlIDxsaW51
eC9tZmQvY29yZS5oPg0KPiA+ICsjaW5jbHVkZSA8bGludXgvbW9kdWxlLmg+DQo+ID4gKyNpbmNs
dWRlIDxsaW51eC9wY2kuaD4NCj4gPiArI2luY2x1ZGUgPGxpbnV4L3NwaW5sb2NrLmg+DQo+ID4g
KyNpbmNsdWRlIDxsaW51eC9ncGlvL2RyaXZlci5oPg0KPiA+ICsjaW5jbHVkZSA8bGludXgvaW50
ZXJydXB0Lmg+DQo+ID4gKyNpbmNsdWRlIDxsaW51eC9pby5oPg0KPiA+ICsjaW5jbHVkZSA8bGlu
dXgvaWRyLmg+DQo+ID4gKyNpbmNsdWRlICJtY2hwX3BjaTF4eHh4X2dwLmgiDQo+ID4gKw0KPiA+
ICtzdHJ1Y3QgYXV4X2J1c19kZXZpY2Ugew0KPiA+ICvCoMKgwqDCoCBzdHJ1Y3QgYXV4aWxpYXJ5
X2RldmljZV93cmFwcGVyICphdXhfZGV2aWNlX3dyYXBwZXJbMl07DQo+ID4gK307DQo+ID4gKw0K
PiA+ICtERUZJTkVfSURBKGdwX2NsaWVudF9pZGEpOw0KPiANCj4gU2hvdWxkbid0IHRoaXMgYmUg
c3RhdGljPw0KDQpZZXMuIEkgd2lsbCBtYWtlIHRoZSBjb3JyZWN0aW9uLg0KDQpUaGFuayBZb3Uu
DQoNClJlZ2FyZHMsDQpLdW1hcg0K
