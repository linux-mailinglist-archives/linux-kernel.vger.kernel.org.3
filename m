Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3AF24E2760
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 14:20:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347820AbiCUNVX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 09:21:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244257AbiCUNVU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 09:21:20 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 683C866213
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 06:19:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1647868795; x=1679404795;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=VQJRVVd3i4TMRj3eRaiaxsQccMYIoShQeBfggDiXu3M=;
  b=rMIOhZTb8nY2SYxQP5ICydChEIwLnY58yXFOMr7M+dzpUnDaFDZ0s4ho
   6FXt0gaJaVcyrd4gjeW2bejPVcJebv9cMkvxYZex1/EqGBcaFnVcnLhtw
   q5OkTIlhXij6JDraCFBO9jxi0UstU0pvDsDPE3I5Y/+4kWA7/UeJMPXOb
   6ok4hApGJqbRIF60ynY6G59VrdMQXa2GDpNslzVH0nqqOdCIwPlfPzyV/
   FysvAWGonDAT6kba0/RpzddL1mUR4fd2/jbFe5+3Vqe8xSR4f6jtawRuq
   OiTU9TQdopEQRI+8iPByYU0tThth3Q0A+hvEer1KYazhKdN8Dsxi2917J
   w==;
X-IronPort-AV: E=Sophos;i="5.90,198,1643698800"; 
   d="scan'208";a="152685192"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 21 Mar 2022 06:19:54 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Mon, 21 Mar 2022 06:19:54 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17 via Frontend
 Transport; Mon, 21 Mar 2022 06:19:54 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ACpuB1cRN/xAlcNIM5RufI4Mx5PiPqLzXaB9EGsEK7QCI3f7ykVtdodw3r1WoSqnIDIc0roWzQVisgv8VLnz1kJUjwmozJL1QZdEpWzs0D8v007I/dw+9bGqCFJwCjts/SmfvE/7Cktbr7TsXwbXi3k/03owZWFLzWIAVhotUdoQFqmYy68WLXIrrgxTb+Vo+1BatRSeyjl7zZ81U+OJo2Ut/ezUw32hWBskgphinfwbIyP4N7132J2MASx9YRxw/Mn8aQChEDPP4/UuyxRNi1/LKBY8EAXEA07en7Dvr4mPt5G/IZP5rVGfPb0dqqRRTQ+j0xqF+OEUHKNfbZs3mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VQJRVVd3i4TMRj3eRaiaxsQccMYIoShQeBfggDiXu3M=;
 b=UvL/FTHoWa5/zmSGvtQu0hLpUEDs8jci5h3F+Ck/a4+ZqhzvNHh5/+HoabtPnxN1JrppogiE7Ce6dn61rAu0mD9BHHx0hyIFCLcXLppMF0V4qptpsQ2w0Dq2WqGtlpnEuGQLkAmn7AuQeSXvexRrTkiyB8by/G+U8ykUPSKP8oczefuXtUxuoH8xYZJ/StCVGIWIOgcm8ab4awRkT8NO4GjIFCJ7E9MUfEcl6qzHDpXs297nVbRjTmLNlFOuCyYw+3vTL7vMKZogBHRmR3FvMQ+QhCj4gvOi7Vv61qgrfzgv1YHPUbZXPYZ50Q6GEHsmmqdQYx5ddGf1IC1erT7QVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VQJRVVd3i4TMRj3eRaiaxsQccMYIoShQeBfggDiXu3M=;
 b=q/x13mlNvXyBmAOWJNKeHCrwQ2SrCSvsuxaD9acmat4F3rZTF+Gk0SdYaulEKlhV2v22ET4ujO5YDFUnfX3pAD2lGnXTL3mQgp1/TBV+JObRtQLgf1jN06oAT6XBDzxKMvygpVZojEPb16//q9V0Jl3jfovFBnQjKluJX7q0hIo=
Received: from SA2PR11MB4874.namprd11.prod.outlook.com (2603:10b6:806:f9::23)
 by SA2PR11MB4969.namprd11.prod.outlook.com (2603:10b6:806:111::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.17; Mon, 21 Mar
 2022 13:19:53 +0000
Received: from SA2PR11MB4874.namprd11.prod.outlook.com
 ([fe80::b828:b4ef:5cb:e551]) by SA2PR11MB4874.namprd11.prod.outlook.com
 ([fe80::b828:b4ef:5cb:e551%4]) with mapi id 15.20.5081.023; Mon, 21 Mar 2022
 13:19:53 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <p.yadav@ti.com>
CC:     <michael@walle.cc>, <miquel.raynal@bootlin.com>, <richard@nod.at>,
        <vigneshr@ti.com>, <linux-mtd@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <Nicolas.Ferre@microchip.com>
Subject: Re: [PATCH v2 8/8] mtd: spi-nor: spansion: Rework
 spi_nor_cypress_octal_dtr_enable()
Thread-Topic: [PATCH v2 8/8] mtd: spi-nor: spansion: Rework
 spi_nor_cypress_octal_dtr_enable()
Thread-Index: AQHYPSZZkeqWLY2ynUiCYPoYjOQUsA==
Date:   Mon, 21 Mar 2022 13:19:52 +0000
Message-ID: <2e458565-f077-c009-3dc8-11862ffd621e@microchip.com>
References: <20220228111712.111737-1-tudor.ambarus@microchip.com>
 <20220228111712.111737-9-tudor.ambarus@microchip.com>
 <20220321123440.prhhkzvgvgao2fqr@ti.com>
In-Reply-To: <20220321123440.prhhkzvgvgao2fqr@ti.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c542519d-5bcb-4429-c1d6-08da0b3d7c28
x-ms-traffictypediagnostic: SA2PR11MB4969:EE_
x-microsoft-antispam-prvs: <SA2PR11MB496965F3B5E9D640B7F634ABF0169@SA2PR11MB4969.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ZvCzn9vUCS4ITLMzOWYYvGuvBYzs6cSkvNMuiGrDiI3vqpcktKRnoy6WATPYCTFP8p35QqF1NZ62BtGVJ56ySwTqvP1OGY+iCmKJ2ZBGGgrSlJtDstmRkLW/A04uPno+DNY+GxPignp6FKjQEer/LqRiPvvLxYR3p6CoqWjA1KbWUD337T8l9MHYA8pw7aT1liHYEQuvw0yyRFN2bttwaZJKkAdV7OkmDSWCqtGayyUXbDF8f/490j/8HvDKL+k+SGfoqlBnN7UBQ4X9S+LgMie9KJWnXtG6iWo4lKgOOIdScYAYiplIDY+eq+Vdzx9TuvdXJ1EI8z452djR8MnGYKUdWDCwJKesBX6DuMo8Xhlrz5Jnyv30AsNC8ghkDcQB0uKeQ8WsGb45EoClT1qCzI85Ea7eF6JZ4+KwLOxTPsm5vq5iTqwihUV44hVCM+jXC8avnBh35dDwkrbWuUIcJJh7EPZT3IDxXdh0Rut9bCv66RDrxDBMIQ4uekz8ki6MXU9PxJ+9JogOmhjhm7+RHlwOCuoy9GT2iChQV7mBoJyyCjInhIlrIo0ogdh/S8PHe3mN9EKbPgM8L/At0budHU0IIU+tH7j2y2n6ljf5rrdM3FiUMImLRl6n405apLC/T//uAghql7MFpwCiay5Pbcz6Nrq+SrOdtsaNadb0/JpKfSMzyQq+3Ox9FJWE+dP7Ko/OhvULUQHl16ZwNHr0P9Vd58nauwazcmRGVaN8cxV4w3iHC/CiMvE7zYk8fqWwXa1AutbwnfWKiMbf8/lHvA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA2PR11MB4874.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(6506007)(2906002)(2616005)(53546011)(26005)(186003)(38070700005)(6512007)(107886003)(122000001)(38100700002)(316002)(4744005)(91956017)(8936002)(76116006)(8676002)(5660300002)(4326008)(66556008)(66476007)(71200400001)(64756008)(66446008)(36756003)(86362001)(66946007)(31686004)(508600001)(6486002)(6916009)(31696002)(54906003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?K1AzRVUvSzhPcEw0QlR2RjVFN2RtRnlNSXJXY1BVM2haMlFBaFlVZFluQVJy?=
 =?utf-8?B?M3luVDY1Z2k0anZxeDNZTkRqYzFoZFRYV1B2cUY4WkE5MmRCckZKek5UY2xR?=
 =?utf-8?B?S3BBQVNaSHBSc0tlNkhwd1k4NHlFU3pSK1R6MEU0SVhSMHhVeDU1bVFuZkhv?=
 =?utf-8?B?bll4UktiNk5aNmNNY3VzSE5vYWpDNWpJTVI1WEVvVUYwM0xjaEYySkNlcGVU?=
 =?utf-8?B?OXljNlFDNCt2S0VBU2JGbXRhQ1l0VEMxUTljdm96b2VUOUFtc1hHUWt1dXZS?=
 =?utf-8?B?TnluT3hPVHVRT1ZlZWlhcmFXclBDN3h0T3NYc1FsVCtENHJUNXcwUHd2MkRO?=
 =?utf-8?B?anlRZmdWQUFnVGMya2NQMEUzVGlJdGttRTlmZTNYUDl1YlV2YXhZWUhjUHBY?=
 =?utf-8?B?SXhzMFp6bm1aRkRheFZGQnFablQyc0tMZ3FqUSs1WmtWUSsvS2QzTEw2WUNx?=
 =?utf-8?B?NmVML3RCd3BQb2VTSFJVakIwTGJ0VUZzdTgvRlpzQ2JBb05nejBiMG5PbnEr?=
 =?utf-8?B?MGNPVEhpTVcwYXM3U2JQL3FvQS9IUDE5bnJmSnRyODd6SzJPa0hCbU1HOXVX?=
 =?utf-8?B?TlF6ZGpXOUNmVUVJVTBmZVJZNVphU2kwVmdaL3YvUmhOZWMwWVd4K3JqOEI3?=
 =?utf-8?B?ZnFFNFpNU2poeENlVWlwTGMrejhZZWEzamZ2bnV3Z3lCeE54QUJYWEs3SStW?=
 =?utf-8?B?VTVUejRIS2drRnFKV3NmWXlqdGhkTWhickxybXZUM3ExUlJmR0dPM2x3OFNO?=
 =?utf-8?B?M09UMmxwSjhqUVFmYnNCelpuUDBLVHRGUE1obFlUV2JlRkhpaThuL3k0Vnhh?=
 =?utf-8?B?UUo1UW9DdUhuVmJRODRQSGc4dnVzT0h5N0Nmd1JjcVJTeU52dWNPblBMeVFp?=
 =?utf-8?B?dG91NEtMMW10ekdsQmRUQlpacTBQVTdwSWROcUwzQVZ6YkV6NFJqSnhzL3FV?=
 =?utf-8?B?aHNlNmhaaFhHVnEzT1lPckdCSEJpUXUxS2l0M2Z0dmZpM2RwbHBKZVpYelNQ?=
 =?utf-8?B?ZnpHUmpnTEMrWlRKTUoySzFoUGVBS2p2enp5RXNNbWk5bzJZRUxTeGxzTjdt?=
 =?utf-8?B?Ly9QSTFCLzNYRytyZytiVk5yT3VIMXN0YjM3R2RKMFdMTFBHeTBDN0l0aDEw?=
 =?utf-8?B?R0wxNTVFL3BxNVorbkFSSjRrK3FwSFZQODlEZWxvcVlaRGZleTVTdENBaFRI?=
 =?utf-8?B?NXBlUG9LVDkzTzJoZTdiRXhNcndDcWNoZXVCTWFPQUN3ZUtBYURLS3ZIRHRM?=
 =?utf-8?B?dHJFcFJUeDhaeGJwTFQ1WS82d0xIejE3Q1JyWk1DQ2cxUkV2L1pjcWsySDJp?=
 =?utf-8?B?QWJlbm5tRVFsQit0QzhSaVVBcHRpV2RwQmV4UlZVN0luemNtamhVaGd5THRo?=
 =?utf-8?B?NUZGNzY0OU9OQ2pabFcwUlE1RDNIak5Tb0svc0I0MTZDSVVpNkNFTEN2eWMy?=
 =?utf-8?B?SFo2NWFUak1jRkhuZUp2MGtpdUZ5WjZkVWJ6V1c5QUVCRDd5WGNDeS9HUGlw?=
 =?utf-8?B?N0lrR2JLeDRYTHA4NUZEYUdEZVFlQlQ1VEdmM25pcjZUbjBRZCttK2tTcmlm?=
 =?utf-8?B?ME13Rkd5OFhPVVQ2MjlXYW44dzRIWmhjaExsZ0JFVE1ZaG1PaFpra1FWbXRB?=
 =?utf-8?B?eDlBOWtKMEtGM0ZuZXVnZ0ZNZDdYc3hoSjV4dFo5bVJyRGUwOStVMnY1VzNv?=
 =?utf-8?B?MmRnQXkwQ1JqWGVMemtqdGZYaHl4L1hyM05VZytKTHNUSWYvcER3Z3BFYnRE?=
 =?utf-8?B?TVFOWGxpaUpieTRvRmY0NTFKdFNzOWlKajdDUlZHN0szWWxUT1lHY1ZRM1Rx?=
 =?utf-8?B?K0dUcjVPMnNJcFFTTkkxY1F1WnFqa1ZXTkJEMnBkcHpFUC9DTGJvbWRIcWly?=
 =?utf-8?B?U0h1OEcwTjRNV05HRWkxYzlYZHEvbUJxN0xmamZIY2hsRTFlR2Z4eW9vdTIr?=
 =?utf-8?B?aEpJUGpZeWswUWtaa0JSQ3FtTGhncWM5THdRczRMV0xIMHJWSXlTR0VKeXpu?=
 =?utf-8?B?ejZTeXVsVlhBPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A57036EC0F3E334B90732FE779D11838@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA2PR11MB4874.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c542519d-5bcb-4429-c1d6-08da0b3d7c28
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Mar 2022 13:19:52.9990
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xAnO3bWVsCIuD7iCaMRYE6h7nDLaPNTYZjUsXghM5cKEb7aTXEB6G15i6/4E0S5Ona0zahKqB3W8/K1uvBrvNogPbCamI/R6dUwuAe6zfG4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB4969
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMy8yMS8yMiAxNDozNCwgUHJhdHl1c2ggWWFkYXYgd3JvdGU6DQo+IEVYVEVSTkFMIEVNQUlM
OiBEbyBub3QgY2xpY2sgbGlua3Mgb3Igb3BlbiBhdHRhY2htZW50cyB1bmxlc3MgeW91IGtub3cg
dGhlIGNvbnRlbnQgaXMgc2FmZQ0KPiANCj4gT24gMjgvMDIvMjIgMDE6MTdQTSwgVHVkb3IgQW1i
YXJ1cyB3cm90ZToNCj4+IEludHJvZHVjZSB0ZW1wbGF0ZSBvcGVyYXRpb24gdG8gcmVtb3ZlIGNv
ZGUgZHVwbGljYXRpb24uDQo+PiBTcGxpdCBzcGlfbm9yX2N5cHJlc3Nfb2N0YWxfZHRyX2VuYWJs
ZSgpIGluDQo+PiBzcGlfbm9yX2N5cHJlc3Nfb2N0YWxfZHRyX2VuYSgpIHNwaV9ub3JfY3lwcmVz
c19vY3RhbF9kdHJfZGlzKCkgYXMgaXQgbm8NCj4+IGxvbmdlciBtYWRlIHNlbnNlIHRvIHRyeSB0
byBrZWVwIGV2ZXJ5dGhpbmcgYWxsdG9nZXRoZXI6IHRvbyBtYW55DQo+PiAiaWYgKGVuYWJsZSki
IHRocm91Z2hvdXQgdGhlIGNvZGUsIHdoaWNoIG1hZGUgdGhlIGNvZGUgZGlmZmljdWx0IHRvIHJl
YWQuDQo+Pg0KPj4gU2lnbmVkLW9mZi1ieTogVHVkb3IgQW1iYXJ1cyA8dHVkb3IuYW1iYXJ1c0Bt
aWNyb2NoaXAuY29tPg0KPiANCj4gUmV2aWV3ZWQtYnk6IFByYXR5dXNoIFlhZGF2IDxwLnlhZGF2
QHRpLmNvbT4NCj4gDQo+IFdpbGwgc2VuZCBteSB0ZXN0ZWQtYnkgc2VwYXJhdGVseSBvbmNlIEkg
Z2V0IGEgY2hhbmNlIHRvIHRlc3QgdGhpcy4NCj4gDQoNClRoYW5rIHlvdSENCg==
