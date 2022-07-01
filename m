Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7617562D09
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jul 2022 09:51:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234906AbiGAHuu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Jul 2022 03:50:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230525AbiGAHur (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jul 2022 03:50:47 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 925931EC7F;
        Fri,  1 Jul 2022 00:50:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1656661846; x=1688197846;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=c5ECrdpL3f4PkZc7aQyj1GpfyUlLs/Bj4rBFRxF2clU=;
  b=lmK8jhzYJMa8vd4Kcjfc4E1aVdc7gc6ChAF5sKhNjq99W+qnFyE1xyV/
   IrsBGt57UcVfe1DQyI8lMQRrvapnZsF61ylZ8LIQNvfWHO5/rYvv51m1L
   1toIXHI74tqLs2FyraiSTMXBF8Djau6fQOwy03ELcV9QSnJXLdYymobYQ
   ggKsJfq+Tst9YQLJEF7jBOTK732ZjTbczsi35q/8mT2U7pX8GI6w0YlzC
   UwhwFeJqPrvxknjhvO8sn29nKH5R1Hv1h6nGu7Rzwpg55WDbWC4siU5kr
   /kuE7qoCiDMkt5CjjeG8JJPN7hHumrHo9mnqusZV2TsH+1VPOyUzKD3Ge
   g==;
X-IronPort-AV: E=Sophos;i="5.92,236,1650956400"; 
   d="scan'208";a="165967751"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 01 Jul 2022 00:50:45 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Fri, 1 Jul 2022 00:50:45 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17 via Frontend Transport; Fri, 1 Jul 2022 00:50:45 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ARsGAFGiHAgkwlrwt6PQd1DJIyQr3lNNqyzHp6r1enW6cHWnbo6S9gxZfjMg0JVNLNbMELzZv8bRhLNnoGItFVvtjg98o4BO+TE/B4xgGIO6R1Actgd/kIHsjHEbMzbCkSNFiu5Y0FRt1oqz4Ed60lPRraQ2swgiq/GWlvBHHgn7LRC4xuB2yOsoAjCKVnTnJHQRifDgHlombyYsa1a3gJFWobTnKldSg1WMf0N0ZcYa9KSlYrugdYPUmtwQ/DYmCDA5vnxB3b9WgOHA7oYjfnRDZt4hNulP1k7FK7RX5c9/+EVF4DTdgHNKBide8VHyUxp7hNvfxQHKNMY1HboKiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c5ECrdpL3f4PkZc7aQyj1GpfyUlLs/Bj4rBFRxF2clU=;
 b=A09P+vLFTOS5CyZ71uQMAMfC/cbpDodlvFRubpS0r6l+TM3blP2M9WCWVm1O4PxCoBkUpRyxkowdbhDEB93HKjcTHKdL4vp+BEeYHWofrAy17DSAFCJ9BL3blQ6I8bGr82yNn0Rgva8anAZjs83sLj7m+cc9ZIgNCHPS3YzN3P+okIwSSZOBZHgK7L4QMOd805MP2KwmO5EqG/7uSML88CP76QD8WBPfRk+Z04z4NaYZJVmH+uTCnfNAHUny3T3jXxYGV8dBhTWhPNe3HpAKPPta5CKZWyYgzg9bTpctpkyYEgWzbcJGsZGdV3Gq6sZeu2BeZ993IW/1UDilHxjK9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c5ECrdpL3f4PkZc7aQyj1GpfyUlLs/Bj4rBFRxF2clU=;
 b=MiqxgYFzpaKi4L4hUhW6OTA02Ee6ZxgB9VALUP6iHU6BHesnMOsdhhfvJ0xDOsY1IYoj2ol+cHLL3BO0g4k2E2GtTd48ZMnlzUsxdgZ+KFrcmafYQZBTqXsM86AQIPveb284nu/ESMeouJT5+N5z8Zg3SLT+LbOhDUfA8+v5dQU=
Received: from CO1PR11MB5154.namprd11.prod.outlook.com (2603:10b6:303:99::15)
 by CY5PR11MB6318.namprd11.prod.outlook.com (2603:10b6:930:3e::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.14; Fri, 1 Jul
 2022 07:50:40 +0000
Received: from CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::699b:5c23:de4f:2bfa]) by CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::699b:5c23:de4f:2bfa%4]) with mapi id 15.20.5395.015; Fri, 1 Jul 2022
 07:50:40 +0000
From:   <Conor.Dooley@microchip.com>
To:     <Nicolas.Ferre@microchip.com>, <robh@kernel.org>,
        <Sergiu.Moga@microchip.com>
CC:     <Claudiu.Beznea@microchip.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <UNGLinuxDriver@microchip.com>, <linux-spi@vger.kernel.org>,
        <robh+dt@kernel.org>, <broonie@kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>,
        <Kavyasree.Kotagiri@microchip.com>,
        <alexandre.belloni@bootlin.com>, <devicetree@vger.kernel.org>
Subject: Re: [PATCH] dt-bindings: spi: convert spi_atmel to json-schema
Thread-Topic: [PATCH] dt-bindings: spi: convert spi_atmel to json-schema
Thread-Index: AQHYjAnpJ9RPijNCmEOYEPo+O29OJq1pI/YAgAACdoA=
Date:   Fri, 1 Jul 2022 07:50:40 +0000
Message-ID: <671850a1-8a87-b15b-c776-c0dbbc9de38e@microchip.com>
References: <20220629125804.137099-1-sergiu.moga@microchip.com>
 <1656542219.625404.1042476.nullmailer@robh.at.kernel.org>
 <8191d9e3-88e9-c8fb-2544-d25d3a93d0a8@microchip.com>
 <a85357c2-a2f6-472e-50a8-2dcf41217ac1@microchip.com>
In-Reply-To: <a85357c2-a2f6-472e-50a8-2dcf41217ac1@microchip.com>
Accept-Language: en-IE, en-US
Content-Language: en-IE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 400d2e81-7fdc-4593-fb11-08da5b3664ea
x-ms-traffictypediagnostic: CY5PR11MB6318:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: iC7lGx25ccQV3uVK3ewTNkM1clYjBRdS3mO/CsPB6Mfkgqu+K3wI8ndv1I+/d4VUA/9kFet4Uk/RxyzyxHEHm97Iu/9y+EDJejDyfNwsgczz1tZzoMAeufPTOFmeSWErI3cL2kmubvP39NyEERGb9Tty+7kp3eXUQH3cz5hAgUIGvRTxyfZ1jU7neC26m7MPFOa5VTxlYzz0zgjAoHO4mb6z4Zgl7a7tEaNgg0McQlBtgVhvyuVMZ2kMeXk746WihJYFiRzMwFHNRfG0zuj5FyGG4DIqhIwf0H9UABM81i06CkppL9q8c769pvRgrM4I1m3H6e8sLg+ziJkdHck3Ug8AovDRHcBZEbD1FhK4qHqSNUo9fn31HGZmPiMKDJu5/kJ3boRqlx7lw3m2Q1jAG+mt4y94JqtwWKEdpsFTtTnrdvwqa1r5D1CLJbVBKgYmF+6/glLDI0ApD3mBhKM+rHmqrvA+641vvSddq8Q9ZmPinX3bdRRdbay4axw9qSF2U98KYtGdDHRCh8BTAdQp2NHbukJ8JFI0rSSaztF6h89sVBP02PiPzuETeS3KvSPOQW+71L3lTAO6ULEL+lzTU4RCE+dlK9t0Dh2Lba5r1btxeA+Sjn0XU//RELFcg5ZoBfitjELl4FDxPOa+TQ+8qqGbLx5gt0mhnEKahEzxdG3gsfvcqbb1DyaHAOCuTT512Usp5vFaMAgUkyqaAEEM0AEtimPcFY6dU1clbdRWKJuqsXlLd/fJsTe9iHr8KZAY/P7f84G9FeziYtiqpHtoyuKJuKeMdj/gxyR+uQNvBUOysHisHKbMDbUgxgg2Yp02eKVnRIzIB3ZqARVM32ZE4ixjz6lLH6oqxBlCSBvKbII+uj8vZlYNaGKqobUOYsIy
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5154.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(396003)(376002)(39860400002)(366004)(136003)(346002)(8936002)(66476007)(6486002)(2906002)(91956017)(5660300002)(66446008)(66946007)(8676002)(66556008)(478600001)(6636002)(71200400001)(316002)(31686004)(4326008)(54906003)(76116006)(110136005)(36756003)(64756008)(26005)(2616005)(38100700002)(38070700005)(186003)(6506007)(6512007)(41300700001)(53546011)(86362001)(83380400001)(122000001)(31696002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?R2w0d2FQK0tLYXphdTV1Z285aWVFakJHWGtKVHZVL0tjSDZCMjB5bWFEb3hm?=
 =?utf-8?B?Q3RQdjFZMjQ5YzNiRGU0RExzd0pRZXVTZFI3SWNpa05mRjNmUWgzVzBlNUpR?=
 =?utf-8?B?N01tZ2w2dFZGb3VKKzJialQrY1Mrc3NoWE5TNkpRZ2FrbVZqSFNtdjdZanZ1?=
 =?utf-8?B?M0FCRHU3d3AyRkgwZTgyUTFWRjNwZzNCTHJSRlZVOUNBNDExd1RUemI4SDMw?=
 =?utf-8?B?NE5pcC9vVlNLYURiWTNYcWZBMXlLL1JHYWxXSDl0ZjBjemxiV296blBLMmIz?=
 =?utf-8?B?bWNmTlpqckFreTRBVEM3Zk05aEdiaURCeUR6Z3o4UHhSV2xVZmhaNGxYMnd4?=
 =?utf-8?B?Yy9FUW9EQU5UN3NNRE8ydEExNFVkZjVrOGNqWjBlaWR4UStDVFk4ZDFUV2xI?=
 =?utf-8?B?OGxoVEVmUHlJeEEwWkN1b0wySHRvNk9nNzZaZkFJZmY1N3ZSZFBWNllaT3JK?=
 =?utf-8?B?bGhEck4zbE5RVHd0S2ZiOXRwV2ZFcCtLK2lsZVFVSCtmZ0tDRWpDeGppdytP?=
 =?utf-8?B?Ym9iblVUTXlqeWV1TWtybWUzUU5IZmJtRFJZMkxvYVRKNnE4WHRHT3B1RnN6?=
 =?utf-8?B?MEp6QXBXcHFzR2ZnVW5sdTR0N0wrbTdZMlRCRHZPYXNmTzRZSmhxa0R2NS84?=
 =?utf-8?B?cGIrZGcwQ2QwQnVsc1F0NjJpR3ZZOWRxajlKNEwydEliK25acVFkTnNNajVk?=
 =?utf-8?B?cmlOV0tBVks1NWdVRjBYQW1FTDhSWW9LdHV0ZS9TU2FwWTNiZWJOcXRrK3pM?=
 =?utf-8?B?YkY4QlJlSmYzRDFteWRSR2Zvbkt2SWFjZ005ODBXc2hVQkpPR3dqUmJITWVJ?=
 =?utf-8?B?TEc1WDBkUTBmUDlXenRoWE44NTl2Qm1tWFZOZitDK0VrNDNVMWxKQ2ZsendK?=
 =?utf-8?B?QkdyZDk0TTFOUE84cHo0Q3BwRTVhUkNlTThWbTYrNVNIaHRTRGk5Z1RnZnhu?=
 =?utf-8?B?N0ZXMFlqNW5MVjRSNTRpRHp4dzNYYjkweWYzZ3h0UzR2cytSOUtlY3U5VnJw?=
 =?utf-8?B?R2VMOE5DcmVYWW4xMktUcHhQTDZveFMzM2ZmUG11VGNPTE9RQ2lNS0Z5TnVn?=
 =?utf-8?B?cmRqdDArZHN2OW1IalFZelpPQ0NnQW9vN1B4VDEzeW5abUlva3plN2hTOWlB?=
 =?utf-8?B?WXR5Qk8vRG50OG9RbmtibC9WNWgzN053VEFiM293cCtsVjhHL054VWw3a0tT?=
 =?utf-8?B?cDRBV1VPY3Z4S21QYWVOaGZvQ3JINmlIelZ3VExLSnJGNVkwUjFOb0w4SDdy?=
 =?utf-8?B?eXlHWFhJOGZTb1FzL0M1MjIxSnEwZjhSbWVKYWxNTGUyRlU3S0taLzBKWlQv?=
 =?utf-8?B?U0dTVjRjcDNadkhYcGtYakkyK0RwTGFhRnVRakZaNUlQTGFuamVOM0tKWHJU?=
 =?utf-8?B?TGU0OWFGR3VkWTQ1UUFNbjBrbmRES3BWM1FHMnJqUytsNHJBTHJPYVlGNVgv?=
 =?utf-8?B?RGEwWkp3RitHSmczUzJlaEJuMGUwR1c3Tm8vS1A1QTNaSXpZeCtnQmhZdU12?=
 =?utf-8?B?eSs5MDZPM2FtSkRHRzg4SHY3d3pUK1doREVvMVRuVUs1NXVTTTkzelRaNG4w?=
 =?utf-8?B?Z1c2TGFaNkQ5WGxLTWZkck5xRUFxUUlyWXQ1NHpEcEFLSVZWUW91c1hyZnpw?=
 =?utf-8?B?WVV0dy9aSzNPalp5aEg5dk5uakJnNklSVy9JUDBXeEFHWEZDZ3FieWx4c0VP?=
 =?utf-8?B?UlQvdERUemVNVnNHTlc0Y2JWTlFvTmpvSThUTk1WVHdveTVYQUJCTk9YTm1L?=
 =?utf-8?B?bWVVZHl5d1ZIYmgxck4wSEF0T2ZUSkRJRDBUT2k4T1pvYVYrYVBmSUlhNS9O?=
 =?utf-8?B?WW9ESW1GRkdNV2pLQjFpdERORGZNaTFYMmFIdkUwL3hNa3p6NjNpdFNzbjE3?=
 =?utf-8?B?MDBUVFJjejRtRjZGQXJuK0hkU2JWK2dTSmpwaWN0ZWVEajdURThjWFAzZEp0?=
 =?utf-8?B?emJQbUUyVzNrMWpiR1haOTV5dGtyblJ5ajJkeGxvZlR1TG9IZHJVSlZtMnc0?=
 =?utf-8?B?YUthaEFZdncxMCs0aXJTWmV5bFBObmlEckU1QlRiZGhORElWT1JJRFJZT1FH?=
 =?utf-8?B?alZoYmVYYlZkeEJoMVZMQTlMTE14M2c4MmZIL1JjZGJ5YUNlNVl0SzBsYU5t?=
 =?utf-8?Q?zvjtFrjYp7fv4GU+FxDwC5R++?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F4A70901B4DA3840BFF68706281827A8@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5154.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 400d2e81-7fdc-4593-fb11-08da5b3664ea
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Jul 2022 07:50:40.5204
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zKfN3ejQGjTRc3ILLpbYwOHgTYi16XRZQ4ZVRr4MxAjaOdGBK3n/W2u6y9hJ2pwwZmCNOefxuAfV90q2HO61pmDuJpgmrzbUEemyiZ12VjQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6318
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMDEvMDcvMjAyMiAwODo0MSwgTmljb2xhcyBGZXJyZSB3cm90ZToNCj4gSGkgQ29ub3IsDQo+
IA0KPiBPbiAzMC8wNi8yMDIyIGF0IDAwOjQ1LCBDb25vciBEb29sZXkgLSBNNTI2OTEgd3JvdGU6
DQo+PiBPbiAyOS8wNi8yMDIyIDIzOjM2LCBSb2IgSGVycmluZyB3cm90ZToNCj4+PiBPbiBXZWQs
IDI5IEp1biAyMDIyIDE1OjU4OjA0ICswMzAwLCBTZXJnaXUgTW9nYSB3cm90ZToNCj4+Pj4gQ29u
dmVydCBTUEkgYmluZGluZyBmb3IgQXRtZWwvTWljcm9jaGlwIFNvQ3MgdG8gRGV2aWNlIFRyZWUg
U2NoZW1hDQo+Pj4+IGZvcm1hdC4NCj4+Pj4NCj4+Pj4gU2lnbmVkLW9mZi1ieTogU2VyZ2l1IE1v
Z2EgPHNlcmdpdS5tb2dhQG1pY3JvY2hpcC5jb20+DQo+Pj4+IC0tLQ0KPj4+PiDCoCAuLi4vZGV2
aWNldHJlZS9iaW5kaW5ncy9zcGkvYXRtZWwsc3BpLnlhbWzCoMKgwqAgfCA4MiArKysrKysrKysr
KysrKysrKysrDQo+Pj4+IMKgIC4uLi9kZXZpY2V0cmVlL2JpbmRpbmdzL3NwaS9zcGlfYXRtZWwu
dHh0wqDCoMKgwqAgfCAzNiAtLS0tLS0tLQ0KPj4+PiDCoCAyIGZpbGVzIGNoYW5nZWQsIDgyIGlu
c2VydGlvbnMoKyksIDM2IGRlbGV0aW9ucygtKQ0KPj4+PiDCoCBjcmVhdGUgbW9kZSAxMDA2NDQg
RG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3NwaS9hdG1lbCxzcGkueWFtbA0KPj4+
PiDCoCBkZWxldGUgbW9kZSAxMDA2NDQgRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdz
L3NwaS9zcGlfYXRtZWwudHh0DQo+Pj4+DQo+Pj4NCj4+PiBNeSBib3QgZm91bmQgZXJyb3JzIHJ1
bm5pbmcgJ21ha2UgRFRfQ0hFQ0tFUl9GTEFHUz0tbSBkdF9iaW5kaW5nX2NoZWNrJw0KPj4+IG9u
IHlvdXIgcGF0Y2ggKERUX0NIRUNLRVJfRkxBR1MgaXMgbmV3IGluIHY1LjEzKToNCj4+Pg0KPj4+
IHlhbWxsaW50IHdhcm5pbmdzL2Vycm9yczoNCj4+Pg0KPj4+IGR0c2NoZW1hL2R0YyB3YXJuaW5n
cy9lcnJvcnM6DQo+Pj4gRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3NwaS9hdG1l
bCxzcGkuZXhhbXBsZS5kdGI6MDowOiAvZXhhbXBsZS0wL3NwaUBmZmZjYzAwMC9tbWNAMDogZmFp
bGVkIHRvIG1hdGNoIGFueSBzY2hlbWEgd2l0aCBjb21wYXRpYmxlOiBbJ21tYy1zcGktc2xvdCdd
DQo+Pg0KPj4gTXkgY29udmVyc2lvbiBvZiB0aGlzIHNob3VsZCBiZSBpbiAtbmV4dCByaWdodD8N
Cj4gDQo+IEFyZW4ndCB5b3UgdGFsa2luZyBhYm91dA0KPiBEb2N1bWVudGF0aW9uL2RldmljZXRy
ZWUvYmluZGluZ3Mvc3BpL21pY3JvY2hpcCxtcGZzLXNwaS55YW1sIG9yIERvY3VtZW50YXRpb24v
ZGV2aWNldHJlZS9iaW5kaW5ncy9mcGdhL21pY3JvY2hpcCxtcGYtc3BpLWZwZ2EtbWdyLnlhbWwN
Cj4gcmF0aGVyIHRoYW4gYXRtZWwsc3BpLnlhbWwgPw0KDQpOb3BlLCBJIGNvbnZlcnRlZCBtbWMt
c3BpLXNsb3QgOikNCkFuZCBJIGNoZWNrZWQsIGl0IGlzIGluIC1uZXh0IDIyNmUwOWRlMGFjZCAo
ImR0LWJpbmRpbmdzOiBtbWM6DQpjb252ZXJ0IG1tYy1zcGktc2xvdCB0byB5YW1sIikpDQpXYXMg
anVzdCBwb2ludGluZyBvdXQgdGhhdCB0aGlzIGVycm9yIGZyb20gdGhlIGJvdCBpcyBub3QgcmVh
bGx5DQphIHByb2JsZW0uDQoNCg0K
