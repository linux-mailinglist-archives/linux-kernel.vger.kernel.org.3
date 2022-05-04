Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FFC951979D
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 08:51:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345088AbiEDGzJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 02:55:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345049AbiEDGzG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 02:55:06 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07BCD205F9;
        Tue,  3 May 2022 23:51:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1651647091; x=1683183091;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=KJGek/6Fj/cA9LzPuwsgNg9IypPOebLscLoe8xMNKFA=;
  b=gnjQOoIYhe5I1t1fOMSP1XZDWWJzmN3WUPlvONUosBEKfULLp60cet8l
   wCbDqu1pzKFdOfbaq0yY8qSHxTBMGwl/KXSiD/RVB60QsOm30tZmvZt3M
   awKLSDT9agA7b5TVu9v9deuJNswlARixKKuTRW9o1PpTlpelOFGUcEghi
   TsfIgjqHiSMORoZIhVQ81zr6uwMG790obfmtDPqhnQCk5zt24YIliK59W
   WPfrp/wS8066tXl+zv9bLR4m0OQLZyGsA6sIpV1wvg+qMXhvtuqjat/3a
   d2fHIhfWnBkspcudipP5s/qS/DTYLIPucSC4K/I1UBXCtw+s8einQZvdU
   Q==;
X-IronPort-AV: E=Sophos;i="5.91,197,1647327600"; 
   d="scan'208";a="162662590"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 03 May 2022 23:51:31 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Tue, 3 May 2022 23:51:31 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17 via Frontend
 Transport; Tue, 3 May 2022 23:51:31 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VVLfJCqILKmiPevTgocxnWmXdVXNz+rTeHKdzqcV6E04tOTw7DFvRvqfU9uCqJHBGoKSCvjTmmd5pCqb8kd6AevJcWxIf8PlED//vIltSWoMvapUxXWF22aQJOF0kBEo9BN/H5t58vcXIs2pcB20HTJg7OZdSWw3ZpPuBkUogX7VkKD0aSu+gnnp+sXoIM3jQLwJGb4aOnK2Evc0QGYY0jl5qFtcdeKQVUTLtjS/NIcM0mOm+sL93sqshTDBT+DUTf9PNNX0Ya5bHJ8uiP/qKeft35sTCKVBq63vNBrcCCUtuzf/DAS2dgMp5jhY6pN4zcCAal5OP0URbB/GRywrCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KJGek/6Fj/cA9LzPuwsgNg9IypPOebLscLoe8xMNKFA=;
 b=LkkINqLY5W0cpfCzboJbmvM1N5iAM5RGDRyRnGsIHlLP7LyJzNYXb4t61FH0zpo/S6q3gUK6BKWEIrnMr/HeoFKI/rYclwvYho39uYhBRcJMlH9aJUl81OWzZ5SXSJ6VwvovnONwfbUn2tqYANFzrwLh42B09G0xa+xnAFZprJ9LZtGv9Iq7e+52iiSgN5S6A/wVWl/hwkHMoliq2IfAIeILHgfvxEeoxKt1r8LSAhMvHRm6ntBy146eL8UhqIvcy1bMUWySv3bWgsU6Awk5phMf3YbYjhQmqDzSjS2h+h1MORYRI7d88x8r11jRmfeMMipt8hO4McNjFQqb2FgEbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KJGek/6Fj/cA9LzPuwsgNg9IypPOebLscLoe8xMNKFA=;
 b=fWxJrvWeDqVcxWwF5MW1jKozh07jbaJDD6vP89pytZHbEivvG2o5kakB9Bn+XOlU0tiAr/hw5RMmuRojchveQZgauUJRs0Smo+I5Jw2jgAluLHH0F6Uabor1LmMBp8eN8U160qPC8qjdEf/frxpsGoQeRV13d7zspUEyf4JsV+c=
Received: from CO1PR11MB5154.namprd11.prod.outlook.com (2603:10b6:303:95::7)
 by MWHPR11MB1453.namprd11.prod.outlook.com (2603:10b6:301:c::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.24; Wed, 4 May
 2022 06:51:16 +0000
Received: from CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::fcd4:8f8a:f0e9:8b18]) by CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::fcd4:8f8a:f0e9:8b18%9]) with mapi id 15.20.5206.025; Wed, 4 May 2022
 06:51:16 +0000
From:   <Conor.Dooley@microchip.com>
To:     <heiko@sntech.de>, <krzk+dt@kernel.org>, <palmer@dabbelt.com>,
        <robh+dt@kernel.org>, <linux-riscv@lists.infradead.org>
CC:     <Cyril.Jean@microchip.com>, <Daire.McNamara@microchip.com>,
        <paul.walmsley@sifive.com>, <aou@eecs.berkeley.edu>,
        <palmer@rivosinc.com>, <arnd@arndb.de>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <mail@conchuod.ie>
Subject: Re: [PATCH v3 8/8] riscv: dts: microchip: add the sundance polarberry
Thread-Topic: [PATCH v3 8/8] riscv: dts: microchip: add the sundance
 polarberry
Thread-Index: AQHYXZF5fIfQ0jWbJEK3P2cnEzmA3q0N13UAgAB0AwA=
Date:   Wed, 4 May 2022 06:51:16 +0000
Message-ID: <b9b30e83-4f9e-e26d-56aa-446d33f422ac@microchip.com>
References: <20220501192557.2631936-1-mail@conchuod.ie>
 <20220501192557.2631936-9-mail@conchuod.ie> <3101012.5fSG56mABF@phil>
In-Reply-To: <3101012.5fSG56mABF@phil>
Accept-Language: en-IE, en-US
Content-Language: en-IE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: cd9b8d07-c15d-4dac-ab66-08da2d9a7caa
x-ms-traffictypediagnostic: MWHPR11MB1453:EE_
x-microsoft-antispam-prvs: <MWHPR11MB14533A17A5D082563F8C1E8798C39@MWHPR11MB1453.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 5oX4vVDYAAQdzxQLqiW5TQcR3gI+gWAeUZz6BvkfDtSH4qRcWADycpDP6OousUVOCRmu4r79z29Cc1d69MrPliTuiaRuKbJuE2xJvVCiIG11W6JUjEWYmCGlkY4FxQ9d4XpA4fvE2rCZlE8A5bLLgilPweoedCKcl/Jfepio9A2hDDOuFBRpLUEmp++BjzRXBUa22xTPhcAR9s3FbNYezL/DnBxiYW8128gRq0txMak1fjOM2B2/EEAP+6eHtzI5cclgtFlFLTFZK7wtP3RnIAEFtuUkqDoentxMLKsllf1vBpZlmBqjSrl/EMFWZaYmLj5hjrf/jgtYmTtbGQcCSmfp4pk6tMn8WqWA3ZB2XNK56lQcaaDM9fjVqmb406djssygSYJvWxoFDMwCf60g3g58Cb5L0lc+Jey9EhRRI5DfqBMC4a21AvwuTe0Ku7nPCG4TCMoGYE/4R3LhJTED3hhW0BDQ9XDAGrScuKc1nZWZ6qU4BY+BIluT8FDCZ5uy1/eRhlCmoxGOfIFlgcTRDar0wqetYVJj6wTjEJpC3xNRisFx1naW1cbFfnazGZ+qj8RHlgaMBcwkDW047XhDJEc7giMUeAtnSdZ18F/m2bAPZdu7ELY5zIpc9JhGQkNnLhXgdB86nMRUIQIEou4fHS0VbD1nhKaAr3Ks+9zu+yxs3s3DmVXFa+xapYz1YJR5M8/Aax+75KmTWCcTgj3yx9ohaqhBm6yuV59Dv7Qx9P/biAXc/M4Sg8CIc5lYrHXQulsso10ETD9PA2wAOWNl1g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5154.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(66946007)(71200400001)(76116006)(66446008)(66556008)(64756008)(66476007)(8676002)(4326008)(6486002)(54906003)(31696002)(8936002)(36756003)(2906002)(31686004)(186003)(316002)(91956017)(110136005)(38100700002)(6506007)(5660300002)(38070700005)(7416002)(508600001)(53546011)(122000001)(86362001)(26005)(6512007)(83380400001)(2616005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?N2dsRG9oVVg4a0crOGRCVDBnMkZNcCt2dmFRUWNaRitwZTBRZ2lmZzJEUUtK?=
 =?utf-8?B?d2lTRGN2L2VESFVLc3J3bVdVL2J1UXY2TVZDa21rc2NHU2tWSFB2ZDFyYXJ4?=
 =?utf-8?B?QVNUU1hnWmdTSjJ0Z2xySkY5MDZDNkJqanMrc3N6VHJGYmxtYVFrK3BmQ3Bi?=
 =?utf-8?B?VWl5SWVRK1VrZmZWdXJWRThMalcwU0Fna2NEcGJmcUVhN0NOQzBCTU5QQ2RY?=
 =?utf-8?B?WUpjZzZMdUYva253N2NSQmdqc05Dd1RUalNXUDdQMmlpeEZiS3RLaU5RR2FG?=
 =?utf-8?B?UW5LY205R1JxcG1LMVJmaWxOM0pDdE1Zc1hGWXFrTkhpR3M3TXFaRGI3M3ZI?=
 =?utf-8?B?b3lickxJYVNsM3cvTGxsR1VkQllEeGJkczNlRC9kWGJvWW5NM3FvdjVvY29R?=
 =?utf-8?B?aTIxU2ZLUFdLSVVtQVUvS1pPeEZVMW5YTjZyd29IYmZRdWZXZmdwU1Q2OVNi?=
 =?utf-8?B?YzUySzJzOVFtSjZSdFFheTRUYlBBTWxuN2xwams2Nm5jTHlyY2w0N3I0M2Yy?=
 =?utf-8?B?cGl6NlA4RjdoaWFDalZYUDZ5WmhZUlF5YTI3V0lkVVl3ZGpacWhDeTBiNEU3?=
 =?utf-8?B?c0VMVTJjS2JQUmZUVmVFT2p3ZzFBYlhuWHNMZmZKZSsveXF2eUdGZWE4RzBQ?=
 =?utf-8?B?UjNTSnV5OTl1aDRFQ1ZESTNmcUdQNEwxZmtNeGVMaENNbXVoaDhoSXN6YXZB?=
 =?utf-8?B?amNtMVNwV3R5bkpTb0xqZU96bmM2enpZRWEyQXBoZEZTRGpiNDVPUE8rSS9N?=
 =?utf-8?B?U2JUdkJWeE9Ud2hPd3RSYjVzZlBXcGEybmw4UUtxVHpTbXl6aURvK3g0YzJs?=
 =?utf-8?B?Uzl4V0ZQdzdORnkrTHd5UThJckFsblhuSXdjeFRrbWtTeTBEQ3oxWlQyTEpt?=
 =?utf-8?B?UUJFNXlacVZNM1hxR0N6UzFRSTR1dVRJRXkwNVgyOW9uM2k1YWpaV1hxS3Mw?=
 =?utf-8?B?NlNhZEk2eDhRek9vaS9Mb001RXNDallaRFdsM1NpUkFhdnhUSUVTbjcvVHFk?=
 =?utf-8?B?U1ZCVjQrenhTUmN1U1BvU1N0NVl6Y0JMSkE3cWE0OWhOYTBpMlhTUWptNmlm?=
 =?utf-8?B?SXdmYVNESjYyc2xsUHhhRE1ZSHQ5Snl2QkNZdm9ML0RwYXIrVENmaVJpL0VE?=
 =?utf-8?B?d08zNmpmTVhBbzArK3VhT3pic1ozVmtZem12eHhlSC9heXBBM0FvdS9udjJl?=
 =?utf-8?B?NWVQVWNJUFAyMFV1STQvTDN6T3VOMmh6cDZKd3owUitoL0U4ejE0aTFxTUlN?=
 =?utf-8?B?N1E3NVBNbDdzbEU2K1liRWhrd3BKWkRJU2VLMUlzV2pxVnpMR1QyWHJBTXJy?=
 =?utf-8?B?SzQ1N20xWXdVOVJCWnhKOTcxV0J1bWVCcm4rVW5NQnhNL0F6YlduOXZFZ3hx?=
 =?utf-8?B?SFRrY1ZCOFhBRWcwd2dBNjBaMU1qb3drU2djUHpSZzZyOHpkaTc3MkZNOGo0?=
 =?utf-8?B?WFpjclpKUXpqNUNOcit6c0hnNVp1LzN0M3hwb2c2UFRReG5ZbFdZbUQ2NWFU?=
 =?utf-8?B?WVlqTlFIckVtR2RnbFc1MUR2UjFiTW03SlNMSDlERXFYWHIrN1BCclRiSFJ6?=
 =?utf-8?B?VEJOaWhmK2czV2FUSnNTWFNnZHhJQytpem1PYUxBNENqckJ6K1pBQ05XM2hl?=
 =?utf-8?B?U2hnQTFmRitaN2g2bHNFV2NHam1lU21jTW9uTDlJZGtWNytscmNxTnhJQWJh?=
 =?utf-8?B?Qjk0VURYWGJRaUJONURGMllYTGo3VnpnUWVKWkI1NU1rWG1xV2pzdUlHZzVm?=
 =?utf-8?B?YXpzdVpsdTZjMjh6dVJ0bzFaQ1lQZFF2QldFZGtKMzBDRkErTFR2VDRadGtH?=
 =?utf-8?B?ekxwVGhGcEJoRjBrTzZEYjFRRlQvTlVmek0zbjVyMmp2bzA4L0VOWjVIYnc3?=
 =?utf-8?B?UW1HWjZ6U3hJa3FzYVhldnNYc3F2QThlTmFCcmVpdmdzVmFvTkdDaXIrb3RI?=
 =?utf-8?B?enl4VGc1Y2xKRVZ2U0hFN21udURHbkFjeDlrcDUxQVZVTzRxaFMxbHpQN0di?=
 =?utf-8?B?cnpOU0cwT295b3RJeEJ1NFhBV0pzWGtveDd4U0JaRGZGb0VxaWZrbFByRmtv?=
 =?utf-8?B?ZlJFeUN3dEN2TUFMVVVyaGdOWmJ3REZQS2FjZFA3NW5xWkZEWU1pS01xeGFN?=
 =?utf-8?B?dnc2RWswTnBtcjZaRk0rUDJ6emNVWnBMRmJsNjRacy9FQ1AyL3hYNGQzOFRB?=
 =?utf-8?B?SDA2Tk82Z1BOT2FZU3RTZHlRWkFpZUMzem82bDM1bnZJUTJkTno1aTgxa0t4?=
 =?utf-8?B?YnhHb2xpWFVmREppSVdvTWRaVmk4OVU1UXRGVkxXaFliNXRWWUpoRzUwRmVu?=
 =?utf-8?B?OGZNd1VqeStUNzJMdkt0aG5JYnZ5VEFjOHdyb0UxeVVtMFBrdk9zbURlYVRK?=
 =?utf-8?Q?kw7Twm76DiGXzmo4=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <2429B67A5B97954F9CEB6F0FEAAE21EB@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5154.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cd9b8d07-c15d-4dac-ab66-08da2d9a7caa
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 May 2022 06:51:16.5494
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hUeepGMqFG9WYEwag7oOFOqkL4+TiURCzuHzSIcp3cJ7f+0wc90nD5uiEXs5K96y0Ul0WQMfpnvTKp2zub+FPhKTfPPtbrZTCOoRN7rcZWE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB1453
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMDQvMDUvMjAyMiAwMDo1NSwgSGVpa28gU3R1ZWJuZXIgd3JvdGU6DQo+IEVYVEVSTkFMIEVN
QUlMOiBEbyBub3QgY2xpY2sgbGlua3Mgb3Igb3BlbiBhdHRhY2htZW50cyB1bmxlc3MgeW91IGtu
b3cgdGhlIGNvbnRlbnQgaXMgc2FmZQ0KPiANCj4gQW0gU29ubnRhZywgMS4gTWFpIDIwMjIsIDIx
OjI1OjU5IENFU1Qgc2NocmllYiBDb25vciBEb29sZXk6DQo+PiBGcm9tOiBDb25vciBEb29sZXkg
PGNvbm9yLmRvb2xleUBtaWNyb2NoaXAuY29tPg0KPj4NCj4+IEFkZCBhIG1pbmltYWwgZGV2aWNl
IHRyZWUgZm9yIHRoZSBQb2xhckZpcmUgU29DIGJhc2VkIFN1bmRhbmNlDQo+PiBQb2xhckJlcnJ5
Lg0KPj4NCj4+IFNpZ25lZC1vZmYtYnk6IENvbm9yIERvb2xleSA8Y29ub3IuZG9vbGV5QG1pY3Jv
Y2hpcC5jb20+DQo+IA0KPiBbLi4uXQ0KPiANCj4+IGRpZmYgLS1naXQgYS9hcmNoL3Jpc2N2L2Jv
b3QvZHRzL21pY3JvY2hpcC9tcGZzLXBvbGFyYmVycnkuZHRzIGIvYXJjaC9yaXNjdi9ib290L2R0
cy9taWNyb2NoaXAvbXBmcy1wb2xhcmJlcnJ5LmR0cw0KPj4gbmV3IGZpbGUgbW9kZSAxMDA2NDQN
Cj4+IGluZGV4IDAwMDAwMDAwMDAwMC4uOTZlYzU4OWQxNTcxDQo+PiAtLS0gL2Rldi9udWxsDQo+
PiArKysgYi9hcmNoL3Jpc2N2L2Jvb3QvZHRzL21pY3JvY2hpcC9tcGZzLXBvbGFyYmVycnkuZHRz
DQo+PiBAQCAtMCwwICsxLDk1IEBADQo+PiArLy8gU1BEWC1MaWNlbnNlLUlkZW50aWZpZXI6IChH
UEwtMi4wIE9SIE1JVCkNCj4+ICsvKiBDb3B5cmlnaHQgKGMpIDIwMjAtMjAyMiBNaWNyb2NoaXAg
VGVjaG5vbG9neSBJbmMgKi8NCj4+ICsNCj4+ICsvZHRzLXYxLzsNCj4+ICsNCj4+ICsjaW5jbHVk
ZSAibXBmcy5kdHNpIg0KPj4gKyNpbmNsdWRlICJtcGZzLXBvbGFyYmVycnktZmFicmljLmR0c2ki
DQo+PiArDQo+PiArLyogQ2xvY2sgZnJlcXVlbmN5IChpbiBIeikgb2YgdGhlIHJ0Y2NsayAqLw0K
Pj4gKyNkZWZpbmUgTVRJTUVSX0ZSRVEgIDEwMDAwMDANCj4+ICsNCj4+ICsvIHsNCj4+ICsgICAg
IG1vZGVsID0gIlN1bmRhbmNlIFBvbGFyQmVycnkiOw0KPj4gKyAgICAgY29tcGF0aWJsZSA9ICJz
dW5kYW5jZSxwb2xhcmJlcnJ5IiwgIm1pY3JvY2hpcCxtcGZzIjsNCj4+ICsNCj4+ICsgICAgIGFs
aWFzZXMgew0KPj4gKyAgICAgICAgICAgICBzZXJpYWwwID0gJm1tdWFydDA7DQo+PiArICAgICAg
ICAgICAgIGV0aGVybmV0MCA9ICZtYWMxOw0KPiANCj4gSSBndWVzcyB5b3UgY291bGQgc29ydCB0
aGVtIGFscGhhYmV0aWNhbGx5IChldGhlcm5ldCBhYm92ZSBzZXJpYWwwKQ0KPiANCg0KSSBzdXBw
b3NlIHNvLiBJIGhhZCBqdXN0IG1hdGNoZWQgdGhlIG9yZGVyIGluIHRoZSBpY2ljbGUgYnV0IHN1
cmUuDQoNCj4+ICsgICAgIH07DQo+PiArDQo+PiArICAgICBjaG9zZW4gew0KPj4gKyAgICAgICAg
ICAgICBzdGRvdXQtcGF0aCA9ICJzZXJpYWwwOjExNTIwMG44IjsNCj4+ICsgICAgIH07DQo+PiAr
DQo+PiArICAgICBjcHVzIHsNCj4+ICsgICAgICAgICAgICAgdGltZWJhc2UtZnJlcXVlbmN5ID0g
PE1USU1FUl9GUkVRPjsNCj4+ICsgICAgIH07DQo+PiArDQo+PiArICAgICBkZHJjX2NhY2hlX2xv
OiBtZW1vcnlAODAwMDAwMDAgew0KPj4gKyAgICAgICAgICAgICBkZXZpY2VfdHlwZSA9ICJtZW1v
cnkiOw0KPj4gKyAgICAgICAgICAgICByZWcgPSA8MHgwIDB4ODAwMDAwMDAgMHgwIDB4MmUwMDAw
MDA+Ow0KPj4gKyAgICAgICAgICAgICBzdGF0dXMgPSAib2theSI7DQo+IA0KPiAib2theSIgaXMg
aW1wbGllZCBJIHRoaW5rLCBzbyB3aGVuIHlvdSBvbmx5IGFkZCB0aGUgbm9kZQ0KPiBoZXJlLCB5
b3UgcHJvYmFibHkgZG9uJ3QgbmVlZCB0byBzcGVjaWZ5IHRoZSBzdGF0dXMuDQo+IA0KDQpHb29k
IHBvaW50Lg0KDQo+PiArICAgICB9Ow0KPj4gKw0KPj4gKyAgICAgZGRyY19jYWNoZV9oaTogbWVt
b3J5QDEwMDAwMDAwMDAgew0KPj4gKyAgICAgICAgICAgICBkZXZpY2VfdHlwZSA9ICJtZW1vcnki
Ow0KPj4gKyAgICAgICAgICAgICByZWcgPSA8MHgxMCAweDAwMDAwMDAwIDB4MCAweEMwMDAwMDAw
PjsNCj4+ICsgICAgICAgICAgICAgc3RhdHVzID0gIm9rYXkiOw0KPj4gKyAgICAgfTsNCj4+ICt9
Ow0KPj4gKw0KPj4gKyZyZWZjbGsgew0KPj4gKyAgICAgY2xvY2stZnJlcXVlbmN5ID0gPDEyNTAw
MDAwMD47DQo+PiArfTsNCj4+ICsNCj4+ICsmbW11YXJ0MCB7DQo+PiArICAgICBzdGF0dXMgPSAi
b2theSI7DQo+PiArfTsNCj4+ICsNCj4+ICsmbW1jIHsNCj4+ICsgICAgIHN0YXR1cyA9ICJva2F5
IjsNCj4gDQo+IGhhdmluZyB0aGUgc3RhdHVzIHByb3BlcnR5IGxhc3QgKGJlbG93IHNkLXVoc3Nk
cjEwNCkgY2FuIGJlIGhlbHBmdWwNCj4gZm9yIHJlYWRhYmlsaXR5LCBhcyByZWFkZXJzIHdvdWxk
IGtub3cgd2hlcmUgdG8gZXhwZWN0IGl0Lg0KDQpEaXR0bw0KDQo+IA0KPj4gKyAgICAgYnVzLXdp
ZHRoID0gPDQ+Ow0KPj4gKyAgICAgZGlzYWJsZS13cDsNCj4+ICsgICAgIGNhcC1zZC1oaWdoc3Bl
ZWQ7DQo+PiArICAgICBjYXAtbW1jLWhpZ2hzcGVlZDsNCj4+ICsgICAgIGNhcmQtZGV0ZWN0LWRl
bGF5ID0gPDIwMD47DQo+PiArICAgICBtbWMtZGRyLTFfOHY7DQo+PiArICAgICBtbWMtaHMyMDAt
MV84djsNCj4+ICsgICAgIHNkLXVocy1zZHIxMjsNCj4+ICsgICAgIHNkLXVocy1zZHIyNTsNCj4+
ICsgICAgIHNkLXVocy1zZHI1MDsNCj4+ICsgICAgIHNkLXVocy1zZHIxMDQ7DQo+PiArfTsNCj4+
ICsNCj4+ICsmbWFjMSB7DQo+PiArICAgICBzdGF0dXMgPSAib2theSI7DQo+PiArICAgICBwaHkt
bW9kZSA9ICJzZ21paSI7DQo+PiArICAgICBwaHktaGFuZGxlID0gPCZwaHkxPjsNCj4+ICsgICAg
IHBoeTE6IGV0aGVybmV0LXBoeUA1IHsNCj4+ICsgICAgICAgICAgICAgcmVnID0gPDU+Ow0KPj4g
KyAgICAgICAgICAgICB0aSxmaWZvLWRlcHRoID0gPDB4MDE+Ow0KPj4gKyAgICAgfTsNCj4+ICsg
ICAgIHBoeTA6IGV0aGVybmV0LXBoeUA0IHsNCj4+ICsgICAgICAgICAgICAgcmVnID0gPDQ+Ow0K
Pj4gKyAgICAgICAgICAgICB0aSxmaWZvLWRlcHRoID0gPDB4MDE+Ow0KPj4gKyAgICAgfTsNCj4+
ICt9Ow0KPj4gKw0KPj4gKyZtYWMwIHsNCj4+ICsgICAgIHN0YXR1cyA9ICJkaXNhYmxlZCI7DQo+
IA0KPiBtYWMwIGlzIGFscmVhZHkgZGlzYWJsZWQgaW4gdGhlIG1wZnMuZHRzaSwgc28geW91IGVp
dGhlciBkb24ndA0KPiBuZWVkIHRvIGR1cGxpY2F0ZSBpdCBoZXJlLCBvciBpZiBpdCdzIGEgcmVt
aW5kZXIgb2Ygc29tZXRoaW5nLA0KPiBJIGd1ZXNzIGEgY29tbWVudCBmb3IgdGhlICJ3aHkiIHdv
dWxkIGJlIGhlbHBmdWwuDQoNCkl0J3MgYSByZW1pbmRlciB0aGF0IHRoZSBTb00gZG9lcyBub3Qg
aGF2ZSBhIHNlY29uZCBldGhlcm5ldA0KcG9ydCBidXQgdGhlIHBoeSBpcyB3aXJlZCB1cCAoYW5k
IHVzYWJsZSB3aXRoIHRoZSBjYXJyaWVyKS4NCkkgd2lsbCBhZGQgYSBjb21tZW50Lg0KDQo+IA0K
Pj4gKyAgICAgcGh5LW1vZGUgPSAic2dtaWkiOw0KPj4gKyAgICAgcGh5LWhhbmRsZSA9IDwmcGh5
MD47DQo+PiArfTsNCj4+ICsNCj4+ICsmcnRjIHsNCj4+ICsgICAgIHN0YXR1cyA9ICJva2F5IjsN
Cj4+ICt9Ow0KPj4gKw0KPj4gKyZtYm94IHsNCj4+ICsgICAgIHN0YXR1cyA9ICJva2F5IjsNCj4+
ICt9Ow0KPj4gKw0KPj4gKyZzeXNjb250cm9sbGVyIHsNCj4+ICsgICAgIHN0YXR1cyA9ICJva2F5
IjsNCj4+ICt9Ow0KPiANCj4gTXkgcGVyc29uYWwgcHJlZmVyZW5jZSB3b3VsZCBiZSBhbHBoYWJl
dGljYWwgc29ydGluZyBhbHNvIGZvcg0KPiBwaGFuZGxlcywgc28NCj4gDQo+ICZtYWMwIHt9DQo+
ICZtYWMxIHt9DQo+ICZtYm94IHt9DQo+ICZyZWZjbGsge30NCj4gJnJ0YyB7fQ0KPiANCj4gZXRj
IC0gbWFrZXMgZmluZGluZyB0aGluZ3MgYSBsb3QgZWFzaWVyIGluIHRoZSBsb25nIHJ1bg0KPiBl
c3BlY2lhbGx5IHdoZW4gZmlsZXMgZ2V0IGxvbmdlci4NCg0KU3VyZSwgd2h5IG5vdC4NCg0KVGhh
bmtzIGZvciB0aGUgcmV2aWV3LA0KQ29ub3IuDQoNCg==
