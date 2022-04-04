Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81C664F0F2C
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Apr 2022 08:19:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377409AbiDDGVY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 02:21:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240468AbiDDGVV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 02:21:21 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E26112748
        for <linux-kernel@vger.kernel.org>; Sun,  3 Apr 2022 23:19:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1649053165; x=1680589165;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=HmgsyUl/5T9mEVVYFHjbKFjRqNfJIVqBrPIYw8PPOpk=;
  b=t0hViy750qDwABKjPWypp2AotmP1l6N02fzmhvTDtmvNFc/9Xftw7GXm
   Xf21Et7GcaS4sFRE37Vnn+ZQVIYwgtoZckUVzGLkuBbic2yhwFJEG7zA1
   dgtxk/sJgA2BWIoJ7fEeH14djh7TUKKaOwKLGXenowViGvxF/QSKOQ32B
   GyVQU6d7NPCI0apjAcDEZg3eDwGtdXYuwin5NO497G4AuWpqBj1jks25Y
   DTv68Bscj0HSI9xxc3ppZisk9DXVbvVoaU13A+Wl+S7XHI2VIJXKwuPjt
   vFcaLjQn8Jb8Ivg7GYaQFa1TPLBbF0Bbbb4HBmCAAwIuic/j3Pxe5y9Mj
   g==;
X-IronPort-AV: E=Sophos;i="5.90,233,1643698800"; 
   d="scan'208";a="154248050"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 03 Apr 2022 23:19:24 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Sun, 3 Apr 2022 23:19:24 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17 via Frontend
 Transport; Sun, 3 Apr 2022 23:19:24 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ffKlqUBbYlQslxmCcx25DYVjdiYkUKFjbVV4bDtcMm040VZJs0X4HhiF4afsi1G1aUAabAXhmUBvfAOoH3DWOi4yiJKUirgoI/LWFp9OfnhrVsxcSfw7rWVA8BkF95SgrEX3Wd2Slmi3dS+UMl6YW6MIgTWNhpxObi8gDX2KL6+ZzZQvmmfHYNcjUAtKnjeh9Zb8ahekk4jq9o0HP0RrRChdK3z+/W8vBVz00wIyXcc61+fWaf4XkEUrb6ZyWebg/LKrPUdeHp5bIXLMiWW3bKFAM4nG/p9xpVQDBZNvE7//3Uy32O6VSD010ku4E7BrHaehjE4uu5ItN62BJVJlAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HmgsyUl/5T9mEVVYFHjbKFjRqNfJIVqBrPIYw8PPOpk=;
 b=IxHidf2BnYrWNVU1uqMik/CnJPMU8ZLCpWGxYytukLcqjmha60XdsKHTGZTt1iedLR6t5d3J4BFhlI6DASt0lqjUznU795ZicxLtgkZtLeSc8uHklRga8N94rHMQIfBXpIgeYm4lY/yrj5mduieYpCZTqBK+skVVM/Ngqy5GER2ckONBzzVCstjpnwv3gUtxWCAkEe9d+nxMTYUjyvmrnH4ooqDtbdjnUECjwmNazR0VruH9cqOwm7zqFhdpYuAkmjhnSiIswL3duRO3EoOPg9YjoYopBpXhCtHddDsfxPyBRgKvdyWkRRjfy1WDyRg18j991yJmRd/zE/6gimtdow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HmgsyUl/5T9mEVVYFHjbKFjRqNfJIVqBrPIYw8PPOpk=;
 b=swUTz5Hu3UbhqVjswU7XQSRKqrTLgJn0sabwAiqZEc2+lHEhXyB3uk+clqZz9wYmCByiYFh3v5UoxlFKa0/4LpmHM9n8skHL4RmodWy+ABB0OecrRkPl6Ig5hfL11SUU0Qvk0P6fH+ugKRwzmKcAdgAyKgPzqy3CFLuTJhQQsSk=
Received: from SA2PR11MB4874.namprd11.prod.outlook.com (2603:10b6:806:f9::23)
 by BYAPR11MB3830.namprd11.prod.outlook.com (2603:10b6:a03:fc::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.31; Mon, 4 Apr
 2022 06:19:22 +0000
Received: from SA2PR11MB4874.namprd11.prod.outlook.com
 ([fe80::7cb5:d2dd:7e5:c812]) by SA2PR11MB4874.namprd11.prod.outlook.com
 ([fe80::7cb5:d2dd:7e5:c812%9]) with mapi id 15.20.5123.031; Mon, 4 Apr 2022
 06:19:22 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <p.yadav@ti.com>
CC:     <michael@walle.cc>, <miquel.raynal@bootlin.com>, <richard@nod.at>,
        <vigneshr@ti.com>, <linux-mtd@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <Nicolas.Ferre@microchip.com>
Subject: Re: [PATCH v2 4/4] mtd: spi-nor: sfdp: Keep SFDP definitions private
Thread-Topic: [PATCH v2 4/4] mtd: spi-nor: sfdp: Keep SFDP definitions private
Thread-Index: AQHYR+vsffORZWT/aUyo+hhCPMlSjA==
Date:   Mon, 4 Apr 2022 06:19:22 +0000
Message-ID: <ed093fa5-b514-b0a6-166f-ecf117582b0b@microchip.com>
References: <20220309144215.179449-1-tudor.ambarus@microchip.com>
 <20220309144215.179449-5-tudor.ambarus@microchip.com>
 <20220401200133.gyyvoe7xdbsww7cv@ti.com>
In-Reply-To: <20220401200133.gyyvoe7xdbsww7cv@ti.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0735237d-f4e0-48e7-f36e-08da16030f48
x-ms-traffictypediagnostic: BYAPR11MB3830:EE_
x-microsoft-antispam-prvs: <BYAPR11MB38301118BC693B3BA5AEE90DF0E59@BYAPR11MB3830.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: cykdfdHhSWKr4lPl8PYny6Wk9nnOgTjA0bbqdGW8jIKt+km41pTFZmgutLxG/VrA4stqBXF8Gh6fthaZcKDnGFUAjeaku4md8v5Ms0eFpjypIXjlRXZ7nPWrIzY8b5Q312CBV4g0NKoEwlxYE1aGHudnZrVAbzslzanJ1hxF7C/ALfSbd6iJxpcN84yRzwRyrF+BevY4/eKNPejEBR1JFAXG1u0Iu9C/sm6RlKamwKm55dhWlKzpjHIKE/AUsjNVwGw+ZqrnG1pFdJj/mcC2ktk7eQTC2nHnCUNMt5K3t2O2A802fhZOJNB4MeTPukEPWJSu0QMd8tS/7XW5BjLmMGh79lJftCMLvqNILkBP9JIB9h9QoLJs7+9GrTMChhyFRhX1YIkMTKTYXlVocunYYLKXAFzi3jOtzkbBzS0pBUEBVSHsaiARf8tQhYCsae9S926AwLzY8wA0UF1jmUVryErj6Zbd6iyI8/td/fAIbeeEkAtfWaOXT35aXgj7JiQ+Vf02yWg6bP6mw/zdCq/APT/foXW/bxREKhA4VmNBfaoYUoi9npZvhygEhGgPQk1uCZFG3ltrnYOnObX3gEPNYXpSXxrd6+ZtTktW/P1MKEH75NzS6aQtzW8IBM48S82uHDg0/FcgCzkf1qq6EVx6gue9wRGixFL0yRD7UqTvIL2Hlzw7ukW/DVOZ5gwW6kmrMUvI0V22IWO6TO/QZtcJQtqv/e74YHgj/lAfQJrAw25Yq/97fup+U/nuECJpS/iRIS2Jit+XSAah9MipENG9Lw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA2PR11MB4874.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(38070700005)(86362001)(107886003)(6486002)(66946007)(31696002)(38100700002)(76116006)(71200400001)(508600001)(122000001)(2616005)(26005)(186003)(6512007)(66556008)(6916009)(54906003)(91956017)(66446008)(64756008)(66476007)(8676002)(316002)(4326008)(31686004)(6506007)(36756003)(8936002)(2906002)(53546011)(5660300002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YmpqaHBtUVJYWmpkV3ZQeUhRZDh6bG9QWTFIY29pZVVqbnJoamJjbmh2RmhN?=
 =?utf-8?B?Z0JldzcvOEovYUxkUmtqSGMxeHVYNk92SkJaSndyYVQ1V1VIRjdYckZnSFM4?=
 =?utf-8?B?dHhaRmdWTzV2SHQxNHpUbUVvUFV4UlVzQ2R3UDFTWThtalllM2dCVWRGWU9Q?=
 =?utf-8?B?MFYzNXZLTVZVSWFZMGZITGF4ZTNRZ3lrcmliRUdYNXdWYTdZV0cvZEtuMXRN?=
 =?utf-8?B?cXVheTBIV1BER2Nqek02MThXTGl6RkhsTVB5M0xLWTljZklQdnlqK3NBRXBJ?=
 =?utf-8?B?cVZhd1BlNTd5NE45cDBVWlI3NUZnb25hWHc0MG5ZcjBYbU81ME9vdmNMV0Nt?=
 =?utf-8?B?dkxlYysyOG1MT3VKTnRkNTdvS3F2ZXgxdkt0cm83OTdPYzNUWjBMRHNGRkc1?=
 =?utf-8?B?RHVpeDJLcEZKK1FhYnFldk43NW5MOFlXOFpsTTRnKzVhSHc1OG94WEVwaEJw?=
 =?utf-8?B?WEVoZytUNWk2eS9jdSt5eTBDaGRlR1VsOG1WSlQ4UlpIY1FGUWpGb2VNOGpB?=
 =?utf-8?B?UlZPb3h5TDV4M2JocG1NWGJub3NDdWliSjlBOGpjSytzanYwMXUybzlQRnMr?=
 =?utf-8?B?OC9YalpZY0h6SXdtNVZJdTJsSWlJTENyRjE0S2VlN1NPRUdBbTVFUEQraC9B?=
 =?utf-8?B?WldtWXQ1WTZtWmRla2VObkxPeXJNdnM0b2VEb2tnQXB2MkhIUFVLUnZIV3dH?=
 =?utf-8?B?c21MVnBvemhsMzZCUWIwYzhQTkFDY3R1MzkveEhwa3FReWF3UGwxZ3hZdjJS?=
 =?utf-8?B?Z0x0enNoRm9OZ24vd09VWWZkcVQvVGU5a2FhRnRycms1dW13M0h4SmFYNjhn?=
 =?utf-8?B?NTNHNVYyVWhzaUZObytueUU3S0s4bStEblF1bGJHcHVsVGtMSFcyTFVRSy9E?=
 =?utf-8?B?VWxLQnBYczNsSlcwMTVURUdETy9tT2ZxZWdkb0JHb3d1bG5xRG9DMDU0VlpS?=
 =?utf-8?B?dGRVL0RCZzBDUmcxdS9jYWZhK0s3V0hNaG4rQkl5MDBkenhqT08vczE3UmZt?=
 =?utf-8?B?NjRzZXhWbEN4azFKOHZpc0F3bTFOTDJLenh3NTdrSG5wSml5bk80bkhrUnll?=
 =?utf-8?B?RzYrSElEelE5aG80K0ZNNTgyejVjbU0wQXMrNjMrTE9rMmdJSy9BQXFPZmVN?=
 =?utf-8?B?Qy9pMVROUzRwRFl5TUlod1Bka2RROFhWRGlIVUxidGdaL3hWUzJJZ1c3Z2V2?=
 =?utf-8?B?MFQxdEE2bmJkdVRvSW5sUTByc1czcTNLZm5rbVBiWERNNW9veUpzZjZISytG?=
 =?utf-8?B?cE10T0NXWElXeHBndVlzN3ZSMmxoQTdabFpFMFJNNld3VFhoQWVXaEFSZWc0?=
 =?utf-8?B?R3FWeTNWZzVud25BYTZEZ2RHN1U0V1VJbWVsTkFPOTJUOWFCSlhlLzc1RnlU?=
 =?utf-8?B?MXFzbTEvMnFjMDRlMnIzWWpSWWdiVzRQeE1iUGFMYUpPRnUvUlZTdFcxc0o0?=
 =?utf-8?B?ODg4dVBVN1RyclJ6S3JMbTQ2cno0SERNYjRvWjBrR1N4azdHdERDdW11YS9M?=
 =?utf-8?B?cDh0Q1lDSysva211bzdzMy8wTisyd3VXQmJKd0R6S2JZOHZTbUNMVW13dWJj?=
 =?utf-8?B?NkYraXhBRGpuSVJFYmo4TmtoRzczTFNvZHdrdzM0NXF5bHFuY3NQNXJaRzdH?=
 =?utf-8?B?UFVEb3M5UDJtQmVFd2RIMkFQVjVUd0Z4b29pZHVGK0R1cDF1M3lhckxmblZr?=
 =?utf-8?B?WHhQUFlNb1hIWWFOUHFUTFVjSU4rdm40d0hrVHhaNXpHVmhiRVhGSi9Bd1cy?=
 =?utf-8?B?UE43ZFlTcHRZNlNKZGtRcW9vYmVNUE9GQzVMMGgxMG42MWc4Y1BnTSs4K2Nk?=
 =?utf-8?B?ajRxdXdoV25vdEVZZGtJdmFJRnZ1S2MvMFJDOFY3Z3h5ZXc4ZWV6R0JiZmpa?=
 =?utf-8?B?K2xxY014TjBYc2VUVVg4VmkybjJqUVJITWVNbmxodjd4UThiVzB4ZndZVkg5?=
 =?utf-8?B?eXNtbHNIenpDdHh6NTJyMENEQ2RXMWJ3Q0FlVFEwa25hOEFROGE2blB6OENR?=
 =?utf-8?B?elFIRzRyNmJBdUV0U2pzVFJJWHVwL2RxcTF1L1NoTWxVK1JEVTNWMktBK1Nl?=
 =?utf-8?B?eWRJNmwxVHF2MmV6UWpWWWlmNlpJSHlpcXNxQVI3dldyclFxS29QOTQrZzMz?=
 =?utf-8?B?S3huUDJDTWVHcUhNU2V2N0EwdjBDUCtTWE1yQWxYL3JTZ3MycHFzUE5kenRq?=
 =?utf-8?B?YmVxa1hhSDMweTJXNWhMOUxLQjdYY3ZENEVCdEVOYzM5eGJVQk5OWXBMWjJC?=
 =?utf-8?B?clZkdEphbjVWRlljbVJ5bWtYaHcvN292dE1rbzlibWkwYjI0dHB2SWo1dWhJ?=
 =?utf-8?B?bkxDU2dmeGt5THlmNlBsbTQwSlJSREE2MkUxbmdlWjFzcGxoMFJ3bktwbUVX?=
 =?utf-8?Q?G8phk4zN0Cqn2C4s=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A1597F992BE1CC4E9205B3813CA73FD0@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA2PR11MB4874.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0735237d-f4e0-48e7-f36e-08da16030f48
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Apr 2022 06:19:22.2873
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hDXHDi05QIW8NDE0Z5fqewbfEMsHF4TiZHKoa0jI/OIdI65uHhEiStmHFH7V5EhA7zaO6Z+m3DDZ/ol8iEPvqAnB2Y5kNMTBtrCmKzlzE6A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR11MB3830
X-Spam-Status: No, score=-9.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gNC8xLzIyIDIzOjAxLCBQcmF0eXVzaCBZYWRhdiB3cm90ZToNCj4gRVhURVJOQUwgRU1BSUw6
IERvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVubGVzcyB5b3Uga25vdyB0
aGUgY29udGVudCBpcyBzYWZlDQo+IA0KPiBPbiAwOS8wMy8yMiAwNDo0MlBNLCBUdWRvciBBbWJh
cnVzIHdyb3RlOg0KPj4gS2VlcCB0aGUgU0ZEUCBkZWZpbml0aW9ucyBwcml2YXRlIGFuZCBleHBv
c2UganVzdCB0aGUgZGVmaW5pdGlvbnMgdGhhdCBhcmUNCj4+IHJlcXVpcmVkIGJ5IHRoZSBjb3Jl
IGFuZCBtYW51ZmFjdHVyZXIgZHJpdmVycy4NCj4gDQo+IEkgYW0gbm90IHNvIHN1cmUgYWJvdXQg
dGhpcy4gU2luY2UgdGhlIHBvc3RfYmZwdCBob29rIHBhc3NlcyBpbiB0aGUgYmZwdA0KPiB0YWJs
ZSB0byBmbGFzaCBkcml2ZXJzLCB0aGV5IG1pZ2h0IGVuZCB1cCB3YW50aW5nIHRvIHVzZSB0aGVz
ZSBmb3Igc29tZQ0KPiBjaGVja3MgbGlrZSBpc3NpLmMgZG9lcyBmb3IgRFdPUkQgMS4gVGhleSB3
b3VsZCBoYXZlIHRvIG1vdmUgdGhlbSBiYWNrDQo+IHRvIHNmZHAuaCBmb3IgdGhhdCwgd2hpY2gg
anVzdCBjYXVzZXMgZXh0cmEgY2h1cm4sIGFuZCBhbHNvIHB1dHMgc29tZQ0KPiBCRlBUIHJlbGF0
ZWQgZGVmaW5lcyBpbiBzZmRwLmggYW5kIHNvbWUgaW4gc2ZkcC5jLg0KPiANCg0KVGhhdCdzIGNv
cnJlY3QsIGJ1dCBJIHRoaW5rIGV4cG9zaW5nIGp1c3QgdGhlIHB1YmxpYyBkZWZpbmVzIGluIHNm
ZHAuaCBpcw0KdGhlIHBhdGggdG8gZm9sbG93LiBXZSBzaG91bGQga2VlcCBwcml2YXRlIGFsbCB0
aGUgZGVmaW5pdGlvbnMgdGhhdCB3ZSBjYW4NCnByaXZhdGUgaW4gc2ZkcC5jIGFuZCBleHBvc2Ug
cHVibGljbHkgaW4gc2ZkcC5oIGp1c3QgdGhlIG9uZXMgdGhhdCBhcmUgc2hhcmVkLg0KRmxhc2gg
Y29sbGlzaW9ucywgYW5kIGltcGxpY2l0bHkgdGhlIG5lZWQgb2YgcHVibGljIFNGRFAgZGVmaW5p
dGlvbnMsIHNob3VsZCBiZQ0KYW4gZXhjZXB0aW9uLCBzbyBJIGV4cGVjdCBzZmRwLmggdG8gYmUg
c2hvcnQgaW4gc2l6ZS4NCg0KQ2hlZXJzLA0KdGENCg==
