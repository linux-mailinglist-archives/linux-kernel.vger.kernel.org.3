Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31A975428C8
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 10:02:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232388AbiFHH5h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 03:57:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232504AbiFHH4k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 03:56:40 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 887991E0495;
        Wed,  8 Jun 2022 00:25:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1654673129; x=1686209129;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=eh+gIYWoLPJXbI16EJgXutkQz2Qm02eOPiPBDVcsdMY=;
  b=FRdSCJIf6XicY8gCq+YBZM7InQ+ELLZXlhZNtw659mr10i99oUC2Low1
   gvefltOx8ei+66cdXNGANfs8zTmocofSYAweaiqt2SR121FALG6puruvf
   MHrhwaanejYBYlDLRu9l1GRkxwNlCneAkIuuiBQAwxl8wfu+ij/M3RbUG
   Y30Y5XhEQeBulhu8pzzn0pEuIqs0lcGfUFmi8r2Kdy/AdVI0nNEG4cUlQ
   cnbw56H2cYnSz1g1meguCJiEhaXgMyXfhnL0d+ehTeC0PuqHZ5Yjh2H5G
   46KSFoQpMDEY1LKi9djVIMc3Yd2jErT0ugmlGmlMB3+jybIP9x57Bql/C
   A==;
X-IronPort-AV: E=Sophos;i="5.91,285,1647327600"; 
   d="scan'208";a="99066514"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 08 Jun 2022 00:25:09 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Wed, 8 Jun 2022 00:25:08 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17 via Frontend
 Transport; Wed, 8 Jun 2022 00:25:08 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DGwcItb0igjcCY2eD7K620yv4i2EK4l8X9jEcbfmeoyFXV6XZhW+Oth7j2svHncSr9YaaK4hcc2Cmyw8ngQcG00mEfSj0HerZXEalMko6TcN4rpRxm9luPbhakQWNWYb9cGH96C3O1WFXz3HD5udxoG9WHq77lVyZ2fv0WftYAUVQ5BZ7GcL91Q1PX4z+kVjDR3uNVt4WC1MFL1UUAek+63me84OxDL79KUyKrwA5L1QFR1eH08mauJ9CPYPdHRmdhSX4TRLaJ9PTykBVV+RUOah5v8Ny0/yGxTylnOsb4HBLiMBu7v/tQORZLC/1y8Gk3ZE6L6+o5F38uIibEsGew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eh+gIYWoLPJXbI16EJgXutkQz2Qm02eOPiPBDVcsdMY=;
 b=D/3tFyouepmsPWIQ9mymdJxyY5Q+vqrKBsXD+t1bsZAmJrVI5Kgb9PO0DIDOxfUU1/gfsAe5FYXs5Z/23FMgAkWwQxcQ64WXzg6hYunCMtJytFDqT4HZbfhOXwRCeHdiYbxREdhREbkF5E5iMSTdk6sMM0dPJWWYA0s2/vJskqzNwC3zNIA7dJS/o/MP/GGhMrRhFumBSyURWZu1jC6ZCkhjSn7dvqq5b3TP81x2JBcs7ibR8Hvwj8j4ZEKDg0GaGHizy+KIOKS+S2WKlgrr5S0XaccnRuS1PXU8ePkbsBRu31yHolpJVlU+hzTAZtNlpTZ8AWlpmGwhbuVCyIlGEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eh+gIYWoLPJXbI16EJgXutkQz2Qm02eOPiPBDVcsdMY=;
 b=Bp8NF7BcWWMaqgYxK/YA9pCfMkbYMeF9dntvkM2MOXEyNYlKoSaaAk3bd2k29oVAg2Qx0ATZWrIW2/aang0M2gX31rGP/Rb7MFEw+cWQVjhbMF3OQ/VksPXXuweep2ASfDV8f9ov5ATAqnAgsUct7Q/F07m0F7F3j7uHqn/Cb8Q=
Received: from CY4PR11MB1960.namprd11.prod.outlook.com (2603:10b6:903:11d::21)
 by CO1PR11MB5076.namprd11.prod.outlook.com (2603:10b6:303:90::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.12; Wed, 8 Jun
 2022 07:25:02 +0000
Received: from CY4PR11MB1960.namprd11.prod.outlook.com
 ([fe80::457f:8e4d:4bc1:b997]) by CY4PR11MB1960.namprd11.prod.outlook.com
 ([fe80::457f:8e4d:4bc1:b997%12]) with mapi id 15.20.5314.019; Wed, 8 Jun 2022
 07:25:02 +0000
From:   <Claudiu.Beznea@microchip.com>
To:     <Kavyasree.Kotagiri@microchip.com>,
        <krzysztof.kozlowski+dt@linaro.org>, <Nicolas.Ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>
CC:     <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <UNGLinuxDriver@microchip.com>
Subject: Re: [PATCH v2 1/3] dt-bindings: mfd: atmel,flexcom: Convert to
 json-schema
Thread-Topic: [PATCH v2 1/3] dt-bindings: mfd: atmel,flexcom: Convert to
 json-schema
Thread-Index: AQHYewjeFoG3dQb+IEaWiyKT9zvK0w==
Date:   Wed, 8 Jun 2022 07:25:02 +0000
Message-ID: <ab49a5d6-5c38-6d69-b6df-451437b597c7@microchip.com>
References: <20220607144740.14937-1-kavyasree.kotagiri@microchip.com>
 <20220607144740.14937-2-kavyasree.kotagiri@microchip.com>
In-Reply-To: <20220607144740.14937-2-kavyasree.kotagiri@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 97e6fe98-7453-467a-f084-08da4920009b
x-ms-traffictypediagnostic: CO1PR11MB5076:EE_
x-microsoft-antispam-prvs: <CO1PR11MB5076DD886AD4BAEB5922904787A49@CO1PR11MB5076.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: kFjQ/n8B3EPBIqCPI+dmv4Wj6my84M9GU0851Ujmj0TLaclcHDdV/FtBc3EBkUS5lhqf7qtNAfukRon6tYGYEebd2RV9/f1KwmuqhyJQrBJ9M3cQFGyAADsY2XoCugc18TMyA1/wYDro3A3YqayW+7yPOWfhsHnxqgVyagJz6GflSVowgiPTc5ezuM8oKLUaO5AY4E7Yl2cUrdy1i/gAUUZyDQIdGebqKiSb4utx7ZZyhlUOKe3ynAGEHci+Ne3leOdwIVSyh349eSFYBAQ2VdWP6udgHv1TjTjDEwjEng2qlXmOPyG4GoREpeymxZNHfnV/nZ1qn4GptmJzatPA/XdgpDCXzxEYkvk8Yb9+d1AKNFxQQeBbKnbyMPYqcLhbij5ojjdY3FEyTL0fvuyFWQN5ofykusRBHeR2lPiP+30KhM0aZgAh0VThgHgAtQ+S63A1SBqL9E8SvuAKQD4oq8Iq8YPmwPGspE2bQXJqZMsjF9zRl4Wd2eNGhDt+la/dpF8xMXX1cWxJ/hNhHKn8XShRp3MxP3e5F7VEeEWtXbu30si10o6yAdJZvJlcDYW4Le0r/RwSfb9v2U/YUOzgobREnWaw0AxiLDAIiQdsl3ayOCc24arMG/T0L15VOQFJKQV+mg8BXUjbcya5MgZVCg9++yQxg0julyG8dHwUdYIgZSjEI8ZEkZvh89t4f6skuPRXs9XGoJVkFwF1VRMzcjh4O8NJi6x0Lgp4Th/lWVVCVmBuKBsadi6ljMoTWWg9ZKaga1kGViTHDuO9CaKglHY8wA4cxC62y+YH7a+bHIeQbULo4cZsm25Ug74MKmbK/k6le+S61czrEk1N15YpUMBZyWcejQU7rlWkQR43eYJd9YVcat1xOIAyUrTIcCPVEPj6p0c5613lq82Wrykh8w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR11MB1960.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(36756003)(83380400001)(2616005)(107886003)(31696002)(26005)(31686004)(6512007)(2906002)(53546011)(6506007)(54906003)(5660300002)(8936002)(38100700002)(6486002)(966005)(508600001)(316002)(38070700005)(122000001)(186003)(91956017)(86362001)(66476007)(66556008)(76116006)(66446008)(8676002)(71200400001)(4326008)(110136005)(66946007)(64756008)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VHNNdlJ4VktMNmVoMkpqT0pMZlZQRUxNSUt3Z1NJeFdNSUxrWDcxb3dsemxD?=
 =?utf-8?B?NEdXNzI4eklycElEUTcyZUsyYWRHekZlLzVibHJ3cS9QWG1iNFY5c25EU0lX?=
 =?utf-8?B?cE5RNXZ3M1gwa3I1T25LUTdpSDZwdC91TFNUeldKR20zaHNyVnZMMnQwQzMx?=
 =?utf-8?B?Rmx5NVVSd1pnODNrSVZqU0luQkc5S0k5eFlwcmJJalJzaHprcUUvQzhRR1hx?=
 =?utf-8?B?VitxRkdaMENNSU1KZTNnSnI4SXVZWXBHSU56bUJGTXFxR2NzYmNVM3RIT1lT?=
 =?utf-8?B?ZVdLLzk0UVdXVDcrUmV3YnNZYlE1Snk1ampFQ3VIazgyOGVUSGVVbzk3ZTBy?=
 =?utf-8?B?OXhPV1dxU1g0ditlNW5jbzRXSFUvYjJHWFlUWkFxU01neFd4RkhLS0dxb2o2?=
 =?utf-8?B?Q2VoclVCTjlVZ2dkVlhCUWgvbkUyMEovWXhESDZtczc5YktubDZjM2FoVTh2?=
 =?utf-8?B?V1phVlZqRkNDczM3b2ZpZ2l6dkg0SjQrSkg3ZXRFZHNBR2xwYUJ5aFJXUUZp?=
 =?utf-8?B?MEFrRjRaRUx6WmlYS2FpWDdIRXM0MDBqaC9ueE9oTTQ2Z0YrUXh6RHJMZkpu?=
 =?utf-8?B?VFU4bjdWcXZKNjkrckRmSy9mL0tvd0VkM0Z4ZjkxSnJkVHB2S0dwVzNsR2hp?=
 =?utf-8?B?SmNjZ2Z5cnN3NkRjeUlHRzhmM0F3RmVPVjNsbklOSHFYL0M1enUwZURqSDhm?=
 =?utf-8?B?dGhNWmFuOG4rQ096YU9JMzVTMVJ0VTd2OXlzMzZsSERib3l6WkdRVHRSQnRX?=
 =?utf-8?B?cDFSdFRBeUxoalg1dEhXeWFTM09hZlNKYUJEMUZyNE1zQkVCalJKS3dIazRp?=
 =?utf-8?B?d2Y1S2locDNrWlBIcy9RWXZpd29DUFdaNGdTa091YlNCcGpja1BiRThrbmNw?=
 =?utf-8?B?cld4Z3piL2p3blZzTUQ3VHpyenZCSWpVUVZGRTd6ZjJGS2xhZU96NWdId3JS?=
 =?utf-8?B?cUUvNWRiS1dOcytDYmk3SkZwRHRUV2JnRkVNSExPdUJXSCtVbytkMVY5WXVW?=
 =?utf-8?B?WFJSVWxoNXh1UnJGbEwwN05JeWVNTVpaUC9aWkR3MllKRHZaNGF2SWRrSjBl?=
 =?utf-8?B?Nk1QZHVNQVJ1WXROa1htWnl1bFNxMVZNYWI5SjRkaU1QdTJTcXBkbTBtb2hV?=
 =?utf-8?B?R1pmSlJ2eDZlZURCNkNTVy9yOXVoZk5nZkZkTGlHWnpSSXp1TFBWQkJZaTh1?=
 =?utf-8?B?Y2JiSkpCOVJ6bGJnc3ExWlV2b1RJTTB1NkxZZGFyOE56S0NlVDhBYURxMkVl?=
 =?utf-8?B?bGZVZEsrR2psTHlQZGpxbDVJSWJDYTBqSVRQZS9LVU5FdTFSSjNGVFY3a3A4?=
 =?utf-8?B?dkk5NWs5cVlJbkYzVzhRam9OVmpIWWZxQjIwSVRBc3g5M3FWZ2hoekttT2g4?=
 =?utf-8?B?Ny93UU1wWkwyUXMyYnMyckNmUkcvTi9NR1QzNzJOTjFsTzRSVVkzR3IrbGVt?=
 =?utf-8?B?Y3FTVEZ4RURHOG1TZzZYejFNMFUyMnZNZkdxNHlia2VybDQzQXlHYzFBQUdZ?=
 =?utf-8?B?VVcvdFFhV2ZndHlsb2JBSmpvcC9ETUV5QlZDVVVNbU9UME1QSHdOWUx5NW5R?=
 =?utf-8?B?VWJzVk92Mk55R3c2VDN4M1FIdkhYa3c0UjdaalBnNXhzTEV4SGRSb0d0K0I5?=
 =?utf-8?B?MjVoT29BajVJMGZjczlYcm1TS09CUUdjcytsSGRPUGVMbzlPQXB2SkhIZ0Jp?=
 =?utf-8?B?bGF5VFV2WmlNSStHMnE1L2ZsWmFKaU1hb3FIbXhwSmVqT1BGaXFNOEUwN3M5?=
 =?utf-8?B?OUtDeW5wVnpJTmlVU2tGY2lzN1RTVDBVVEZMdXRrU3JERFJ3NE1rcU1zNUkz?=
 =?utf-8?B?TmZFVGdjZlVIczNGc3RzZEYrSXRXSjZSWmZNV0pGK1VoZFpqZTBDYmpPeXVP?=
 =?utf-8?B?emFZYWtoVytyTWI2SHl2UllHa2MwQVN0Vjk0Zm9vUExqRk5NY3Y2dEdhZmNo?=
 =?utf-8?B?RThGVzdrWklGdkR5ZitaNWVBRDY3L3paTXRJRnNiZ0E5TFNqWlRRenBBaDYw?=
 =?utf-8?B?MTNicGxvQ3RvV3htamZkcVlzU3o0ZzVGcnhjdStPT0E3UWp5ZUh4N0ZhOXRM?=
 =?utf-8?B?b3dJT05vb1lmMGhLdnZTc1Jvbm56N2dvbVV3R0k5UUt6RmUzeURkU1EvOTJC?=
 =?utf-8?B?QzhaQ2JqcE80bGJ5MlV2VDltcEM1WE5oWk9WVkJtWm9LWDRGWmV6UGNYbmdI?=
 =?utf-8?B?ekR3b2Ntc0JXU3RqMHN5THNqNWttYW9RN3FYSWVhSmZ0YXJwTExGWkY5eVE3?=
 =?utf-8?B?U3BzTU4vY3Z1bktYNVBoMFpkUU9LZnNwZ0F4VzNIeTZ4ZkVBVjRqZEJtalhC?=
 =?utf-8?B?T1U3eTlrRkxmRXNuUkRVc0NqemVrbUNHejB4NEpLRjk5S25WYzVhbktKZVh0?=
 =?utf-8?Q?/UY1HOjF0bSIV98Y=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <EFF380603B10054ABBA92DF9B9EF6D02@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR11MB1960.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 97e6fe98-7453-467a-f084-08da4920009b
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jun 2022 07:25:02.4034
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uaz+x4RuTgn2p1j+Xq0Utg1kEdXXFHuBMuFNkPdK+nEFWbU6FIFyWFdLKYhz9YIIYhszvhIpE4hBny+kG1ecYlyjNBydGzrabsKg7mkzsAk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB5076
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMDcuMDYuMjAyMiAxNzo0NywgS2F2eWFzcmVlIEtvdGFnaXJpIHdyb3RlOg0KPiBDb252ZXJ0
IHRoZSBBdG1lbCBmbGV4Y29tIGRldmljZSB0cmVlIGJpbmRpbmdzIHRvIGpzb24gc2NoZW1hLg0K
PiANCj4gU2lnbmVkLW9mZi1ieTogS2F2eWFzcmVlIEtvdGFnaXJpIDxrYXZ5YXNyZWUua290YWdp
cmlAbWljcm9jaGlwLmNvbT4NCj4gLS0tDQo+IHYxIC0+IHYyOg0KPiAgLSBGaXggdGl0bGUuDQo+
IA0KPiAgLi4uL2JpbmRpbmdzL21mZC9hdG1lbCxmbGV4Y29tLnlhbWwgICAgICAgICAgIHwgOTcg
KysrKysrKysrKysrKysrKysrKw0KPiAgLi4uL2RldmljZXRyZWUvYmluZGluZ3MvbWZkL2F0bWVs
LWZsZXhjb20udHh0IHwgNjMgLS0tLS0tLS0tLS0tDQo+ICAyIGZpbGVzIGNoYW5nZWQsIDk3IGlu
c2VydGlvbnMoKyksIDYzIGRlbGV0aW9ucygtKQ0KPiAgY3JlYXRlIG1vZGUgMTAwNjQ0IERvY3Vt
ZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9tZmQvYXRtZWwsZmxleGNvbS55YW1sDQo+ICBk
ZWxldGUgbW9kZSAxMDA2NDQgRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL21mZC9h
dG1lbC1mbGV4Y29tLnR4dA0KPiANCj4gZGlmZiAtLWdpdCBhL0RvY3VtZW50YXRpb24vZGV2aWNl
dHJlZS9iaW5kaW5ncy9tZmQvYXRtZWwsZmxleGNvbS55YW1sIGIvRG9jdW1lbnRhdGlvbi9kZXZp
Y2V0cmVlL2JpbmRpbmdzL21mZC9hdG1lbCxmbGV4Y29tLnlhbWwNCj4gbmV3IGZpbGUgbW9kZSAx
MDA2NDQNCj4gaW5kZXggMDAwMDAwMDAwMDAwLi4wNWNiNmViYjRiMmENCj4gLS0tIC9kZXYvbnVs
bA0KPiArKysgYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvbWZkL2F0bWVsLGZs
ZXhjb20ueWFtbA0KPiBAQCAtMCwwICsxLDk3IEBADQo+ICsjIFNQRFgtTGljZW5zZS1JZGVudGlm
aWVyOiAoR1BMLTIuMC1vbmx5IE9SIEJTRC0yLUNsYXVzZSkNCj4gKyVZQU1MIDEuMg0KPiArLS0t
DQo+ICskaWQ6IGh0dHA6Ly9kZXZpY2V0cmVlLm9yZy9zY2hlbWFzL21mZC9hdG1lbCxmbGV4Y29t
LnlhbWwjDQo+ICskc2NoZW1hOiBodHRwOi8vZGV2aWNldHJlZS5vcmcvbWV0YS1zY2hlbWFzL2Nv
cmUueWFtbCMNCj4gKw0KPiArdGl0bGU6IEF0bWVsIEZsZXhjb20gKEZsZXhpYmxlIFNlcmlhbCBD
b21tdW5pY2F0aW9uIFVuaXQpDQo+ICsNCj4gK21haW50YWluZXJzOg0KPiArICAtIEthdnlhc3Jl
ZSBLb3RhZ2lyaSA8a2F2eWFzcmVlLmtvdGFnaXJpQG1pY3JvY2hpcC5jb20+DQo+ICsNCj4gK2Rl
c2NyaXB0aW9uOg0KPiArICBUaGUgQXRtZWwgRmxleGNvbSBpcyBqdXN0IGEgd3JhcHBlciB3aGlj
aCBlbWJlZHMgYSBTUEkgY29udHJvbGxlciwNCj4gKyAgYW4gSTJDIGNvbnRyb2xsZXIgYW5kIGFu
IFVTQVJULiBPbmx5IG9uZSBmdW5jdGlvbiBjYW4gYmUgdXNlZCBhdCBhDQo+ICsgIHRpbWUgYW5k
IGlzIGNob3NlbiBhdCBib290IHRpbWUgYWNjb3JkaW5nIHRvIHRoZSBkZXZpY2UgdHJlZS4NCj4g
Kw0KPiArcHJvcGVydGllczoNCj4gKyAgY29tcGF0aWJsZToNCj4gKyAgICBjb25zdDogYXRtZWws
c2FtYTVkMi1mbGV4Y29tDQo+ICsNCj4gKyAgcmVnOg0KPiArICAgIG1heEl0ZW1zOiAxDQo+ICsN
Cj4gKyAgY2xvY2tzOg0KPiArICAgIG1heEl0ZW1zOiAxDQo+ICsNCj4gKyAgIiNhZGRyZXNzLWNl
bGxzIjoNCj4gKyAgICBjb25zdDogMQ0KPiArDQo+ICsgICIjc2l6ZS1jZWxscyI6DQo+ICsgICAg
Y29uc3Q6IDENCj4gKw0KPiArICByYW5nZXM6DQo+ICsgICAgZGVzY3JpcHRpb246DQo+ICsgICAg
ICBPbmUgcmFuZ2UgZm9yIHRoZSBmdWxsIEkvTyByZWdpc3RlciByZWdpb24uIChpbmNsdWRpbmcg
VVNBUlQsDQo+ICsgICAgICBUV0kgYW5kIFNQSSByZWdpc3RlcnMpLg0KPiArICAgIGl0ZW1zOg0K
PiArICAgICAgbWF4SXRlbXM6IDMNCj4gKw0KPiArICBhdG1lbCxmbGV4Y29tLW1vZGU6DQo+ICsg
ICAgZGVzY3JpcHRpb246IHwNCj4gKyAgICAgIFNwZWNpZmllcyB0aGUgZmxleGNvbSBtb2RlIGFz
IGZvbGxvd3M6DQo+ICsgICAgICAxOiBVU0FSVA0KPiArICAgICAgMjogU1BJDQo+ICsgICAgICAz
OiBJMkMuDQo+ICsgICAgJHJlZjogL3NjaGVtYXMvdHlwZXMueWFtbCMvZGVmaW5pdGlvbnMvdWlu
dDMyDQo+ICsgICAgZW51bTogWzEsIDIsIDNdDQo+ICsNCj4gK3BhdHRlcm5Qcm9wZXJ0aWVzOg0K
PiArICAiXnNlcmlhbEBbMC05YS1mXSskIjoNCj4gKyAgICBkZXNjcmlwdGlvbjogU2VlIGF0bWVs
LXVzYXJ0LnR4dCBmb3IgZGV0YWlscyBvZiBVU0FSVCBiaW5kaW5ncy4NCj4gKyAgICB0eXBlOiBv
YmplY3QNCj4gKw0KPiArICAiXnNwaUBbMC05YS1mXSskIjoNCj4gKyAgICBkZXNjcmlwdGlvbjog
U2VlIC4uL3NwaS9zcGlfYXRtZWwudHh0IGZvciBkZXRhaWxzIG9mIFNQSSBiaW5kaW5ncy4NCj4g
KyAgICB0eXBlOiBvYmplY3QNCj4gKw0KPiArICAiXmkyY0BbMC05YS1mXSskIjoNCj4gKyAgICBk
ZXNjcmlwdGlvbjogU2VlIC4uL2kyYy9pMmMtYXQ5MS50eHQgZm9yIGRldGFpbHMgb2YgSTJDIGJp
bmRpbmdzLg0KPiArICAgIHR5cGU6IG9iamVjdA0KPiArDQo+ICtyZXF1aXJlZDoNCj4gKyAgLSBj
b21wYXRpYmxlDQo+ICsgIC0gcmVnDQo+ICsgIC0gY2xvY2tzDQo+ICsgIC0gIiNhZGRyZXNzLWNl
bGxzIg0KPiArICAtICIjc2l6ZS1jZWxscyINCj4gKyAgLSByYW5nZXMNCj4gKyAgLSBhdG1lbCxm
bGV4Y29tLW1vZGUNCj4gKw0KPiArYWRkaXRpb25hbFByb3BlcnRpZXM6IGZhbHNlDQo+ICsNCj4g
K2V4YW1wbGVzOg0KPiArICAtIHwNCj4gKyAgICBmbHgwOiBmbGV4Y29tQGY4MDM0MDAwIHsNCj4g
KyAgICAgICAgICBjb21wYXRpYmxlID0gImF0bWVsLHNhbWE1ZDItZmxleGNvbSI7DQo+ICsgICAg
ICAgICAgcmVnID0gPDB4ZjgwMzQwMDAgMHgyMDA+Ow0KPiArICAgICAgICAgIGNsb2NrcyA9IDwm
Zmx4MF9jbGs+Ow0KPiArICAgICAgICAgICNhZGRyZXNzLWNlbGxzID0gPDE+Ow0KPiArICAgICAg
ICAgICNzaXplLWNlbGxzID0gPDE+Ow0KPiArICAgICAgICAgIHJhbmdlcyA9IDwweDAgMHhmODAz
NDAwMCAweDgwMD47DQo+ICsgICAgICAgICAgYXRtZWwsZmxleGNvbS1tb2RlID0gPDI+Ow0KPiAr
DQo+ICsgICAgICAgICAgc3BpMDogc3BpQDQwMCB7DQo+ICsgICAgICAgICAgICAgICAgY29tcGF0
aWJsZSA9ICJhdG1lbCxhdDkxcm05MjAwLXNwaSI7DQo+ICsgICAgICAgICAgICAgICAgcmVnID0g
PDB4NDAwIDB4MjAwPjsNCj4gKyAgICAgICAgICAgICAgICBpbnRlcnJ1cHRzID0gPDE5IDQgNz47
DQoNCllvdSBjYW4gc3RpbGwgdXNlIElSUV9UWVBFX0xFVkVMX0hJR0ggaW5zdGVhZCBvZiA0IGFz
IGl0IHdhcyBpbiBwcmV2aW91cw0KYXRtZWwtZmxleGNvbS50eHQuDQoNCj4gKyAgICAgICAgICAg
ICAgICBwaW5jdHJsLW5hbWVzID0gImRlZmF1bHQiOw0KPiArICAgICAgICAgICAgICAgIHBpbmN0
cmwtMCA9IDwmcGluY3RybF9mbHgwX2RlZmF1bHQ+Ow0KPiArICAgICAgICAgICAgICAgICNhZGRy
ZXNzLWNlbGxzID0gPDE+Ow0KPiArICAgICAgICAgICAgICAgICNzaXplLWNlbGxzID0gPDA+Ow0K
PiArICAgICAgICAgICAgICAgIGNsb2NrcyA9IDwmZmx4MF9jbGs+Ow0KPiArICAgICAgICAgICAg
ICAgIGNsb2NrLW5hbWVzID0gInNwaV9jbGsiOw0KPiArICAgICAgICAgICAgICAgIGF0bWVsLGZp
Zm8tc2l6ZSA9IDwzMj47DQo+ICsgICAgICAgICAgfTsNCj4gKyAgICB9Ow0KPiArLi4uDQo+IGRp
ZmYgLS1naXQgYS9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvbWZkL2F0bWVsLWZs
ZXhjb20udHh0IGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL21mZC9hdG1lbC1m
bGV4Y29tLnR4dA0KPiBkZWxldGVkIGZpbGUgbW9kZSAxMDA2NDQNCj4gaW5kZXggOWQ4Mzc1MzU2
MzdiLi4wMDAwMDAwMDAwMDANCj4gLS0tIGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRp
bmdzL21mZC9hdG1lbC1mbGV4Y29tLnR4dA0KPiArKysgL2Rldi9udWxsDQo+IEBAIC0xLDYzICsw
LDAgQEANCj4gLSogRGV2aWNlIHRyZWUgYmluZGluZ3MgZm9yIEF0bWVsIEZsZXhjb20gKEZsZXhp
YmxlIFNlcmlhbCBDb21tdW5pY2F0aW9uIFVuaXQpDQo+IC0NCj4gLVRoZSBBdG1lbCBGbGV4Y29t
IGlzIGp1c3QgYSB3cmFwcGVyIHdoaWNoIGVtYmVkcyBhIFNQSSBjb250cm9sbGVyLCBhbiBJMkMN
Cj4gLWNvbnRyb2xsZXIgYW5kIGFuIFVTQVJULiBPbmx5IG9uZSBmdW5jdGlvbiBjYW4gYmUgdXNl
ZCBhdCBhIHRpbWUgYW5kIGlzIGNob3Nlbg0KPiAtYXQgYm9vdCB0aW1lIGFjY29yZGluZyB0byB0
aGUgZGV2aWNlIHRyZWUuDQo+IC0NCj4gLVJlcXVpcmVkIHByb3BlcnRpZXM6DQo+IC0tIGNvbXBh
dGlibGU6CQlTaG91bGQgYmUgImF0bWVsLHNhbWE1ZDItZmxleGNvbSINCj4gLS0gcmVnOgkJCVNo
b3VsZCBiZSB0aGUgb2Zmc2V0L2xlbmd0aCB2YWx1ZSBmb3IgRmxleGNvbSBkZWRpY2F0ZWQNCj4g
LQkJCUkvTyByZWdpc3RlcnMgKHdpdGhvdXQgVVNBUlQsIFRXSSBvciBTUEkgcmVnaXN0ZXJzKS4N
Cj4gLS0gY2xvY2tzOgkJU2hvdWxkIGJlIHRoZSBGbGV4Y29tIHBlcmlwaGVyYWwgY2xvY2sgZnJv
bSBQTUMuDQo+IC0tICNhZGRyZXNzLWNlbGxzOglTaG91bGQgYmUgPDE+DQo+IC0tICNzaXplLWNl
bGxzOgkJU2hvdWxkIGJlIDwxPg0KPiAtLSByYW5nZXM6CQlTaG91bGQgYmUgb25lIHJhbmdlIGZv
ciB0aGUgZnVsbCBJL08gcmVnaXN0ZXIgcmVnaW9uDQo+IC0JCQkoaW5jbHVkaW5nIFVTQVJULCBU
V0kgYW5kIFNQSSByZWdpc3RlcnMpLg0KPiAtLSBhdG1lbCxmbGV4Y29tLW1vZGU6CVNob3VsZCBi
ZSBvbmUgb2YgdGhlIGZvbGxvd2luZyB2YWx1ZXM6DQo+IC0JCQktIDwxPiBmb3IgVVNBUlQNCj4g
LQkJCS0gPDI+IGZvciBTUEkNCj4gLQkJCS0gPDM+IGZvciBJMkMNCj4gLQ0KPiAtUmVxdWlyZWQg
Y2hpbGQ6DQo+IC1BIHNpbmdsZSBhdmFpbGFibGUgY2hpbGQgZGV2aWNlIG9mIHR5cGUgbWF0Y2hp
bmcgdGhlICJhdG1lbCxmbGV4Y29tLW1vZGUiDQo+IC1wcm9wZXJ0eS4NCj4gLQ0KPiAtVGhlIHBo
YW5kbGUgcHJvdmlkZWQgYnkgdGhlIGNsb2NrcyBwcm9wZXJ0eSBvZiB0aGUgY2hpbGQgaXMgdGhl
IHNhbWUgYXMgb25lIGZvcg0KPiAtdGhlIEZsZXhjb20gcGFyZW50Lg0KPiAtDQo+IC1Gb3Igb3Ro
ZXIgcHJvcGVydGllcywgcGxlYXNlIHJlZmVyIHRvIHRoZSBkb2N1bWVudGF0aW9ucyBvZiB0aGUg
cmVzcGVjdGl2ZQ0KPiAtZGV2aWNlOg0KPiAtLSAuLi9zZXJpYWwvYXRtZWwtdXNhcnQudHh0DQo+
IC0tIC4uL3NwaS9zcGlfYXRtZWwudHh0DQo+IC0tIC4uL2kyYy9pMmMtYXQ5MS50eHQNCj4gLQ0K
PiAtRXhhbXBsZToNCj4gLQ0KPiAtZmxleGNvbUBmODAzNDAwMCB7DQo+IC0JY29tcGF0aWJsZSA9
ICJhdG1lbCxzYW1hNWQyLWZsZXhjb20iOw0KPiAtCXJlZyA9IDwweGY4MDM0MDAwIDB4MjAwPjsN
Cj4gLQljbG9ja3MgPSA8JmZseDBfY2xrPjsNCj4gLQkjYWRkcmVzcy1jZWxscyA9IDwxPjsNCj4g
LQkjc2l6ZS1jZWxscyA9IDwxPjsNCj4gLQlyYW5nZXMgPSA8MHgwIDB4ZjgwMzQwMDAgMHg4MDA+
Ow0KPiAtCWF0bWVsLGZsZXhjb20tbW9kZSA9IDwyPjsNCj4gLQ0KPiAtCXNwaUA0MDAgew0KPiAt
CQljb21wYXRpYmxlID0gImF0bWVsLGF0OTFybTkyMDAtc3BpIjsNCj4gLQkJcmVnID0gPDB4NDAw
IDB4MjAwPjsNCj4gLQkJaW50ZXJydXB0cyA9IDwxOSBJUlFfVFlQRV9MRVZFTF9ISUdIIDc+Ow0K
PiAtCQlwaW5jdHJsLW5hbWVzID0gImRlZmF1bHQiOw0KPiAtCQlwaW5jdHJsLTAgPSA8JnBpbmN0
cmxfZmx4MF9kZWZhdWx0PjsNCj4gLQkJI2FkZHJlc3MtY2VsbHMgPSA8MT47DQo+IC0JCSNzaXpl
LWNlbGxzID0gPDA+Ow0KPiAtCQljbG9ja3MgPSA8JmZseDBfY2xrPjsNCj4gLQkJY2xvY2stbmFt
ZXMgPSAic3BpX2NsayI7DQo+IC0JCWF0bWVsLGZpZm8tc2l6ZSA9IDwzMj47DQo+IC0NCj4gLQkJ
Zmxhc2hAMCB7DQo+IC0JCQljb21wYXRpYmxlID0gImF0bWVsLGF0MjVmNTEyYiI7DQo+IC0JCQly
ZWcgPSA8MD47DQo+IC0JCQlzcGktbWF4LWZyZXF1ZW5jeSA9IDwyMDAwMDAwMD47DQo+IC0JCX07
DQo+IC0JfTsNCj4gLX07DQoNCg==
