Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1046656BDB9
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jul 2022 18:08:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238801AbiGHPQa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jul 2022 11:16:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238786AbiGHPQ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 11:16:27 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F68D61D5D;
        Fri,  8 Jul 2022 08:16:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1657293386; x=1688829386;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=yDXyZLAulAeOLO2xTFLJ+aZaG907LlglodqklX4aqm0=;
  b=rYDCAJOI2ikujklhGxYWl+AubK+16ZxhyqL9v55ijFDlqyH6SdRysVaW
   caWGZ2k92T0ZxQemPqos0ysye2eCbOaNh7XAKXO+2zExNyv2J5WMbRHb1
   vBFLATxvyqZbYSenq4dR0cFTKrWwchWlUV3GCvMAYRHI1kZoffb56UoIs
   fNpbf5XfgO178EBRHzRXwlq75KSmimm74SrxW7Uby5h/vfmEKpNBrsHqk
   b1wbmheWYw4iurtQkdpvMCeBIJaJ+imc2OjyXkD6vfPyAkooeZTpJ7HIf
   qauX31hDBoBWLlhhW7h4tP8W+rk0iCgWukeSS+gh7ZAxnhaHIk6fZ2j3T
   Q==;
X-IronPort-AV: E=Sophos;i="5.92,256,1650956400"; 
   d="scan'208";a="181349444"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 08 Jul 2022 08:16:26 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Fri, 8 Jul 2022 08:16:26 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17 via Frontend
 Transport; Fri, 8 Jul 2022 08:16:26 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=li+3niGRvP0uWJQzgOqoLdYxM+6bTvVxDEZvpni4YZ7ihPyGOFRUqtKWfRoES2wCt+WVIjhK8K9oq9z7Tux5DTCw88jSJxq+0MyZte3dzGJY0aGOtTo3xUzCHgKg53Kj9JkuzBbfYBLCZVe9l2tw37q4ZZTOT6xRwUV0SdQgA6p2Md1KheyxM9P4CDxr1E0Jegqxf1DSIPMkovaQo4g39kERWjIk4GkiGVkfUSUXwZtvlzG5lgO594eMNtBn8UeUKFn2js6GdEA1GTIFJoMY+YCwVmgu7fBxxD2hNhgrO87ufn99NzWUgIv4DrAguGu5TVQ0Ke3dfPC4VDtcyvxnfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yDXyZLAulAeOLO2xTFLJ+aZaG907LlglodqklX4aqm0=;
 b=DmTjCOULn2WGH7PifLrr2HqYRh1O4nbv1KLu4C/UENHtZyoUi5jggYnEPVxzApX38w9qPCrpRnf9EsL2RuTXVN9U+7yOiNXCNXReqrMYiQBOMuQFVuGj1z+cWgJPZAC97qPnIi0Wk9ul7onVs2DvnACSbDEjzafbJf4SVQ8+Z2Ev23Qg/fHUc87Sgbt/QLCARSNJRpht08LJyNkKi1ZhwinqG28ZdD8M4vu8CH9me64Rea35pfnWJpINSUGVJ5xP86WZCZcIUzVQ/ZsWg5utxIz1ThJgOhAC4lXyT+Cw0p8Z+lj95GEF5S5mhzN/PNSKOWb038oR2V9nQZnbi4thjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yDXyZLAulAeOLO2xTFLJ+aZaG907LlglodqklX4aqm0=;
 b=p19wLSo7jqvVwpK4GhO0oJ/vkcITrlP6bLJ5OikX9aGeVyZ4nkxiphkYgNb4zcZguKd+CFCQVlYzgt1X4C+XMb96fvjc0kboBqLmMjZOlWdG1l1fdRkbj61RBl7lWaE6omy9/ic8Oum8hHR1H5q4VgOwUG4tJgTvbJHk2ySCpBk=
Received: from BN6PR11MB1953.namprd11.prod.outlook.com (2603:10b6:404:105::14)
 by DM4PR11MB5357.namprd11.prod.outlook.com (2603:10b6:5:394::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.15; Fri, 8 Jul
 2022 15:16:25 +0000
Received: from BN6PR11MB1953.namprd11.prod.outlook.com
 ([fe80::5c8c:c31f:454d:824c]) by BN6PR11MB1953.namprd11.prod.outlook.com
 ([fe80::5c8c:c31f:454d:824c%8]) with mapi id 15.20.5417.016; Fri, 8 Jul 2022
 15:16:24 +0000
From:   <Claudiu.Beznea@microchip.com>
To:     <Ryan.Wanner@microchip.com>, <Nicolas.Ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3] ARM: dts: at91: sama5d2: Fix typo in i2s1 node
Thread-Topic: [PATCH v3] ARM: dts: at91: sama5d2: Fix typo in i2s1 node
Thread-Index: AQHYkt2wetVyiLm2tEKO8zMKBhm7hQ==
Date:   Fri, 8 Jul 2022 15:16:24 +0000
Message-ID: <26218d0c-4e90-2f14-5b65-9632bb21971f@microchip.com>
References: <20220707215812.193008-1-Ryan.Wanner@microchip.com>
In-Reply-To: <20220707215812.193008-1-Ryan.Wanner@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3c9b1d8a-33cb-4126-7dcd-08da60f4d2b1
x-ms-traffictypediagnostic: DM4PR11MB5357:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: mDCNVHo7XrraK1+VAP78XBiN2LyDCkFt7qrO4xSYnMKoSXled842fAcv3oA9gOxKR9viteLBjTwfoGeDCFmXxngryGozbrYQ/XlRhLrlI8h35e687o/X2RgD8TxnpkrqzCVwyFWxapFdu5RvlQ3sRVioPU8o3v66QDkRkfCJuGYIf6tHyEJbE9uelCj6dt+BkQygLorvVICSlSxGJXK9qa4lUN3vWSjZ+tSs6PKvNEhW6DP6uskAhcYwRuH98hq5zxY5ASgHOt8tcwTm6wx5hFcgoPIYYJGZ7AqJ3qM7bi+H/MWd/nq6F9SDww9k8SlKK2PZz1NITUpMA5LguSDwqIK4e1ge5ectPfmeuUCo5Ty13XheyTbePkYBnFEWXnj0FgmR2yQQNte+kxzTx3tnSPtSj2HQK04mbpPdUUFkDXOh4e2LD9+aKWwmGjZm1clfH4oQ34dPfTxLYisd7vZBAkc+zcNzEhXlbX9u2d3p8a58wA3PRaekMC4ThY1OeKAaliRleXxWa4HxoXvtkmjR+HwwQ2EUXlQHkN/oTAaUFIiGjMOkIMMDQHd5uCjzVyXMIMOnwWyx6al0a3uGnr8HnSFQDTi+j5yXMvw95KQQaQKbAaHFKPNj8e3ir83FVMEahgGyxHUEouEQJ5OkGfp1eyQNt3373tgIfJq46GjUHodmHVHYCPgOd+GrHgefqjKt/aZkwdQPy+4GYC7dkyQkvf9sLsYv6LYM2EmAHBlJXdNuhbQlgaM9AUKP9PO0BOww/7QsoHfI0IDGDKyNYhpc3C8Suu3WHVu9OPVNR7rtGq1666V8K+jJSjY65meay4CGB9KcpiTr01xl/0RHg6G7ybMoTgr05dkaj0H+FUmXnNE4n/NytaMMcoiKltO7iK9I
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR11MB1953.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(39860400002)(346002)(136003)(396003)(366004)(376002)(6506007)(122000001)(36756003)(316002)(31696002)(31686004)(38070700005)(54906003)(2906002)(53546011)(86362001)(110136005)(38100700002)(2616005)(71200400001)(91956017)(6486002)(66556008)(83380400001)(66446008)(41300700001)(66946007)(64756008)(6512007)(26005)(8936002)(186003)(478600001)(5660300002)(4326008)(8676002)(76116006)(66476007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OUUvTjRZNDNpYmFVd3FXS1NkRlF3MlJmTkJsS1F4SU1PVnUvK00zQUdDMVEy?=
 =?utf-8?B?TWJKeGgzMVZZMnczb1VXYlA0UEkwZCttR3RHcS90bGRLTEJnZ0VkTDBmcjdl?=
 =?utf-8?B?WkR2L2hFa1VBWDV6Ynd1ZG5QM2VCeUx2NFdlR1Q5SkxnU2ZKL0FvMVRKS0dk?=
 =?utf-8?B?Ynkvem9tQW5zajJSR1JOalZFVWtXV2xHWTB5ZTNzaHRPdTVhMnkwcWJBRTFz?=
 =?utf-8?B?aUJRNE5OOUpBaXVnS0lqM21UTG9wVzNZRGx6ZUJqSjl1UlE2MnlEOWJTOEJL?=
 =?utf-8?B?UUJjaHVGcHhyV3BmbUVVam85Nk4vSXczeEpIWFFzRURrSWRSd3NtYXkyN01R?=
 =?utf-8?B?bHBnS3pRTUJEMHpDbnpRMmFxWElHN1hlUkw0ZTh1UEFCQUhFeC93Qk5VQVFC?=
 =?utf-8?B?SEExWWhzclVEOEN5bHVkYjc4bWFZQnVKeUNzNHhCZVF4cTcycnh4NEZIcFd1?=
 =?utf-8?B?cjVvd2l4RkpOYnREY3NzNWZ4TWgwSjBkWU9TazgzM3Jhb0dzc2cvSUVQNHMw?=
 =?utf-8?B?QzlsUjhEVjNsK3llRjd6TVZmNWxxcHArWlZVQldxaGJWcmxVZi82Qm9rVFA1?=
 =?utf-8?B?aVB2R3E1ZmN4dmFJQUJvNXd6b1ZCbHpIOTVLelUySTBsdjlFLzdQbkNaOEs2?=
 =?utf-8?B?VVdqdk5YMmI5L3BkY09WaThkdW1TNXZKZVJEVllQNHRsbUM5K0pLT3FoUVYw?=
 =?utf-8?B?ZHVOeDQvSFRrK2R3ZEtyMGhMSEVUQ2d2c2tWUWNtT3hMMXN3cGptM3lDQnhn?=
 =?utf-8?B?bmxJdjNOQ2cvL3l0VjNoQldBa3YyeDFrTlVYc0VGbWFJelVuUDEwWmtkcHYv?=
 =?utf-8?B?ei9ycEprdmR6cWlzN1c3eTBYU1l1dGkxRHcvbEcwOEN5WmFuYUlaQzhaTmxi?=
 =?utf-8?B?OVAzRDQ3clJDR2VkRFNZNjFONTAyMzN5c1BWcEhVZGVqeXQ4cHF4ZFhlOFF1?=
 =?utf-8?B?OFA2d0lvbE9oQU5tYzVxNklISGJUQkxCL2o3UnBxMmtSMmNpdDFUOXBUcWxO?=
 =?utf-8?B?WkVaUUU5ZFVXUm9GZVhGZGEzWVVxa2ZjUTE3Vk4zb3hreWdiYXBoL3A1MzZF?=
 =?utf-8?B?UkFIL0w0ZU9jQ283d0ZweVl1N1hIU2pIWFI1anRBbUQ3Qy96L3E1Mkt3RDFK?=
 =?utf-8?B?WnRCbmpMRnBZUUI0NlBobXN1eFBnS2REd1pHN1I5RGRldlduLzlDOTZlVmNU?=
 =?utf-8?B?L21PbnVENElRZ3k1SlpZL3k4cm5xQVd5RlM2c3EwZEVQSGV0RkZ1ZlBtWmJx?=
 =?utf-8?B?ZG5tWU14bTZPOUp0OFd1VTk5RWpQdXVtdVI0ZXdicHVvSFJzVnp2WE5WSXVE?=
 =?utf-8?B?QXUxZXd5eFpCUkppWnY1VjZ0UmtXbjIvY0Q1NzlPb0lOUzlxdGEvNmdydXRY?=
 =?utf-8?B?N0MyMTVMWTBvWVNZNEo0QjN6UjVEd1JpRHlJNDFCeTlMK0szUU1kNFJxTG9w?=
 =?utf-8?B?Z2tvRVBqOTFONzRBSndCTUdwdVRqRnhBRjVtRkp0SzkzdU9OZkkweDlCQVpB?=
 =?utf-8?B?S25RNGJLYnVKdUVtaGZMUVVBc2tBVGMyZURzWUpFajhORXl5Wi9WZVh3ODlx?=
 =?utf-8?B?NitPT2k1RTVCcmk3U244NDgxQnlLK2lTYTVvbWx4NXJaekpoaXNKdDlBVVY3?=
 =?utf-8?B?RkNYcVhUcnRMOHlwRGRJdWhFMDVMS3h4MUErT0N2MW9xR0hRSWZpUE1Dd0gz?=
 =?utf-8?B?M0EvSUl2ZWIzNHFEVTVQTWczbUkrSnRZSG9MbW9USnE1Tk1HZitYN0hnK3Jq?=
 =?utf-8?B?RnlKWk9lYU1jckIrbEZmclhaMFk1OHNJRDdHbngyUTVLaFZmQ2lsbHhVL2Rv?=
 =?utf-8?B?cm1CVUlYNXlQbThWcy9TTEllSDZkVlVKK3BUT2Y2enlrT1NnV3ZaaVVLc2VT?=
 =?utf-8?B?cmZRdk9IenZHRGdXSnM5MUxWZWxZQWdBVFV3cm8xWjNvbnpudzk3Z1dmZldy?=
 =?utf-8?B?MEEvUkdsVUllOWxwbEcvZXA1TURoOUcwMkZDUWlnS3pFenVXQ29yTHpRU1JB?=
 =?utf-8?B?d05ONHIvZks1bnk2RmR4MHNTdEs4dDgraGNBR1dVQXRwTCtoUVRVM0NuSDdz?=
 =?utf-8?B?UG82Q3Z5UGkyUUYvQkRjc2lGaGRzWkRYUkJFT0FLcjZ5V0Z5VnM1Q285L3dn?=
 =?utf-8?B?bkJkTFM4cm1OWktuRzVTeC9yeWsySVhySGpsWHZDaTJucVorZWhwOTlIVmVH?=
 =?utf-8?B?UUE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <BDE7A88E3F3464429C1B926D20CE0462@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN6PR11MB1953.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c9b1d8a-33cb-4126-7dcd-08da60f4d2b1
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jul 2022 15:16:24.9324
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UzN5Hj+OCftsRddU3GoT464imdATuMwF4CoURH2og5r0mX/xW0L1k+ZGN+pmuV4D8LXxH5H+de5oOcUu/7ydA+wHUtSAYlmffo9t6H0uTHE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB5357
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMDguMDcuMjAyMiAwMDo1OCwgUnlhbi5XYW5uZXJAbWljcm9jaGlwLmNvbSB3cm90ZToNCj4g
RnJvbTogUnlhbiBXYW5uZXIgPFJ5YW4uV2FubmVyQG1pY3JvY2hpcC5jb20+DQo+IA0KPiBUeXBv
IGluIGkyczEgY2F1c2luZyBlcnJvcnMgaW4gZHQgYmluZGluZyB2YWxpZGF0aW9uLg0KPiBDaGFu
Z2VkIGFzc2lnbmVkLXBhcmVucyB0byBhc3NpZ25lZC1jbG9jay1wYXJlbnRzIGFuZA0KPiB0byBt
YXRjaCBpMnMwIG5vZGUgZm9ybWF0dGluZy4NCj4gDQo+IEZpeGVzOiAxY2E4MTg4M2M1NTcgKCJB
Uk06IGR0czogYXQ5MTogc2FtYTVkMjogYWRkIG5vZGVzIGZvciBJMlMgY29udHJvbGxlcnMiKQ0K
PiANCj4gU2lnbmVkLW9mZi1ieTogUnlhbiBXYW5uZXIgPFJ5YW4uV2FubmVyQG1pY3JvY2hpcC5j
b20+DQoNCkFwcGxpZWQgdG8gYXQ5MS1maXhlcywgdGhhbmtzIQ0KDQo+IC0tLQ0KPiBjaGFuZ2Vz
IGluIHYyOg0KPiAtY29ycmVjdGVkIHN1YmplY3QgYW5kIHRhZ3MNCj4gY2hhbmdlcyBpbiB2MToN
Cj4gLWNvcnJlY3RlZCBmb3JtYXR0aW5nIGlzc3Vlcw0KPiANCj4gIGFyY2gvYXJtL2Jvb3QvZHRz
L3NhbWE1ZDIuZHRzaSB8IDIgKy0NCj4gIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwg
MSBkZWxldGlvbigtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2FyY2gvYXJtL2Jvb3QvZHRzL3NhbWE1
ZDIuZHRzaSBiL2FyY2gvYXJtL2Jvb3QvZHRzL3NhbWE1ZDIuZHRzaQ0KPiBpbmRleCA4OWM3MWQ0
MTlmODIuLjY1OWExN2ZjNzU1YyAxMDA2NDQNCj4gLS0tIGEvYXJjaC9hcm0vYm9vdC9kdHMvc2Ft
YTVkMi5kdHNpDQo+ICsrKyBiL2FyY2gvYXJtL2Jvb3QvZHRzL3NhbWE1ZDIuZHRzaQ0KPiBAQCAt
MTEyNCw3ICsxMTI0LDcgQEAgQVQ5MV9YRE1BQ19EVF9QRVJJRCgzMykpPiwNCj4gIAkJCQljbG9j
a3MgPSA8JnBtYyBQTUNfVFlQRV9QRVJJUEhFUkFMIDU1PiwgPCZwbWMgUE1DX1RZUEVfR0NLIDU1
PjsNCj4gIAkJCQljbG9jay1uYW1lcyA9ICJwY2xrIiwgImdjbGsiOw0KPiAgCQkJCWFzc2lnbmVk
LWNsb2NrcyA9IDwmcG1jIFBNQ19UWVBFX0NPUkUgUE1DX0kyUzFfTVVYPjsNCj4gLQkJCQlhc3Np
Z25lZC1wYXJyZW50cyA9IDwmcG1jIFBNQ19UWVBFX0dDSyA1NT47DQo+ICsJCQkJYXNzaWduZWQt
Y2xvY2stcGFyZW50cyA9IDwmcG1jIFBNQ19UWVBFX0dDSyA1NT47DQo+ICAJCQkJc3RhdHVzID0g
ImRpc2FibGVkIjsNCj4gIAkJCX07DQo+ICANCg0K
