Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E305C5770C1
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Jul 2022 20:32:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231490AbiGPScc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Jul 2022 14:32:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbiGPSca (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Jul 2022 14:32:30 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B3C9193D8;
        Sat, 16 Jul 2022 11:32:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1657996346; x=1689532346;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=DBdE/T4jEDXibmfNe9B1Cbvda1zSNYbG+eftQST1O5s=;
  b=nvwTxujHZD94SqI5n+Kw76QrStVqgK3h8e7S38Gi3wxMvCRMznXTfLkb
   ltlbhQEP81HHGZUL4LOvs3ymsIs7RQyIBV2eTO85jXRuVACU5oJ1y4zH8
   oRm8d0pQWPMrEGe4R3Pf6ZMwbD35mhq/2MdHpV9jZDHvpjLxWI3wCv3cN
   zM8Ws3sUhcqqLdKFtoqk7qss3vrRRpnl/iZP/vuiXC/r8JRMXBj0wt1kj
   mSim9Oz7rkClgaNDnl0Enz48gkd5IJAfgNuxTR56yEaR6CNJO7gPHV5Uq
   MQtHRSn6U2A+K5FEiujyUmDc3buJAW3wxEvW/EJL/NJNMb+i79tig2aVV
   g==;
X-IronPort-AV: E=Sophos;i="5.92,277,1650956400"; 
   d="scan'208";a="172418989"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 16 Jul 2022 11:32:26 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Sat, 16 Jul 2022 11:32:25 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17 via Frontend
 Transport; Sat, 16 Jul 2022 11:32:25 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GZ++VIWAVklED7RDzEkrUjx7wzMz99nb5xq982cxvv7PUxBsypORgozpS7mcKbWnKWxGIRkBxWxXYKwFBOHbsnmPiAV3eNvZz6hsywmVQR6B6ABhL1OKwwGAPHlQZ2C1H1w2bCtpP5RYq7k5+Q+47N+lIcZW9E4vMBJDL8NpeKYP6Pxqbupylxh5w6pqPTya7PKqHw1l4l6uWrE1p5VsC3+yqJTDyyc37ZNEP3TsVNFWYDXCVQc6sy+ZO4OyM4q+Wvd8qkYo2WnJWk7mED8peCSdWQ2uCa873IK9IamgytkME6swlO7R723oq+PO7ch2iq+XHlCetDvcLnbKnK/pVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DBdE/T4jEDXibmfNe9B1Cbvda1zSNYbG+eftQST1O5s=;
 b=E3mKSkSlNWSaN9NliY0we6gF/m2VxMirXC8mO5YT9pjhG5pV95gTMxxMSkcoevLZrhrUlmB24JQV4gUxww9tvHksbCzKI9HfYQe7GN0DodbsqPm7RprWKB+jT1JodSHgaYhcDlV3LQ7r9ckU0U2zmfKBG6tZpkG8YUmpo/k66u7Ne2c/2Yw9CWLr4w1cVq8oLmhXZOv1itPGtWLJEnuARrOwLK+FMSlFcwlh1AOiAey4Moip50CxTMN2+0YlJxktDQw0EyfffzINh0zhtKxWKlttvtPg5+aybYvIgPC0MNVm5ySrCsCRotSjho9113PRU1fFj2vkztEsXU9c6MlqEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DBdE/T4jEDXibmfNe9B1Cbvda1zSNYbG+eftQST1O5s=;
 b=B37EO4NVFNlsSpchu/qoubw1hK1AHpNTni6EoBKpaNaJy57xgM3XL5MvJj4nIOwBXrOJsI6dBbhTS5UCB4af1yC07zi0Y/z3J2dZ7+yDAujFl2cn7lMUZxorKiQcRlevElZ2ADh1Qrv17cnW0CXDWAYBwmaIrBGus7kOkFQV/wQ=
Received: from CO1PR11MB5154.namprd11.prod.outlook.com (2603:10b6:303:99::15)
 by CY4PR11MB2039.namprd11.prod.outlook.com (2603:10b6:903:22::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.14; Sat, 16 Jul
 2022 18:32:20 +0000
Received: from CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::357a:acc9:829e:bf7b]) by CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::357a:acc9:829e:bf7b%7]) with mapi id 15.20.5438.021; Sat, 16 Jul 2022
 18:32:20 +0000
From:   <Conor.Dooley@microchip.com>
To:     <maz@kernel.org>, <Lewis.Hanly@microchip.com>
CC:     <linux-riscv@lists.infradead.org>, <Conor.Dooley@microchip.com>,
        <brgl@bgdev.pl>, <linux-gpio@vger.kernel.org>,
        <linus.walleij@linaro.org>, <palmer@dabbelt.com>,
        <linux-kernel@vger.kernel.org>, <Daire.McNamara@microchip.com>
Subject: Re: [PATCH v3 1/1] gpio: mpfs: add polarfire soc gpio support
Thread-Topic: [PATCH v3 1/1] gpio: mpfs: add polarfire soc gpio support
Thread-Index: AQHYmONENpwHvjgotEKXOSINBvKPca2AzRoAgABQpwCAACn4gIAAC0QA
Date:   Sat, 16 Jul 2022 18:32:20 +0000
Message-ID: <a50d0f6e-0b35-4090-2ba6-9de680d23aa2@microchip.com>
References: <20220716071113.1646887-1-lewis.hanly@microchip.com>
 <20220716071113.1646887-2-lewis.hanly@microchip.com>
 <87r12l4aaj.wl-maz@kernel.org>
 <2d7f72d3e89686d3ba5cff5df8cfe443d04fc5f4.camel@microchip.com>
 <87o7xp3pz2.wl-maz@kernel.org>
In-Reply-To: <87o7xp3pz2.wl-maz@kernel.org>
Accept-Language: en-IE, en-US
Content-Language: en-IE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5bee46d8-2c75-44f5-b7b5-08da675984fa
x-ms-traffictypediagnostic: CY4PR11MB2039:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9i8DsdVrMxX5+FbyqggcjUg4J9yoMtLYpvXTYXsMZ/Sm4AgMWt3J62GbHKIj6ftbVGscuqd2GVKfcI2CoiBgoYF+sk1R3aCxoAXEMwviGkw7ZI+7rf3iS6OjFgJ4Txp+iIk1nVdU61A59iKay7265CpOezSW5HmyAf1JYC/JfrtxS/1TyiNjUDcxDjQZYtQE8BAPOx0NBDUcjMw2xQm9LXgPGmLOSdvUMD/grrO/7v47kJ09DvrQJOqk/F3rqsAVqjYhBjoK0OHPEq1NRBa0YchWVvdE93WAhqEc5BKz3FZa7VasyTYJdUuc7/eRzWd9vPYbZdhyp2h93PBSqM8A/cUYLBMbbwjx0oKb5ozHNvBDfKW95Z3qSDotED58/zvajv3oSqf57YZ9HpEWtxHhufny1XQHvAQP8fwJkI+cOC4Fm7ZKC1JJwDhBX0phbnmh9StJzuiAYl6xhXi4AYKXrpQv16wevLfemUO3f21qUzWBVGiBeJ2JghS/N0i+2RIGWymAB1ikb3Wx3sB7dhJiJ/Dpm+uu1BRmiEku2g9mUpjVbkCRpRlTap4e9wtppIlSE6wkTN9HVGIybQrUmMKK2BM8OHQYiqYV58JC+sDFguLzYQfYrQZxaJJDhPo5wDIxBEe7HVLzT7Tsi8bUUHpK6ESlJd4FOBy0TM/fRoL9PCo0swcBn8f1bwTgKzjhoFTYgWhCMpM1jhidvMZhkYQf96Cy+UJ5uF4ZmnXlhaYkVvAlkGxODK//9/awBZorwQZHpCJUT2sGm4xqMc8S+Dm/5rEtuhJnfZC3VEd5pyQUlsAhovNMbGmzVN4c/IugL/5EVU84QzGxs0Ash7uBkQIHlMVDQFD82Vy9fHp2btGwq9LvAijNi7/JCwcXUXxnk0vw
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5154.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(346002)(376002)(366004)(39850400004)(136003)(396003)(6512007)(8936002)(31696002)(6506007)(5660300002)(36756003)(26005)(66476007)(2906002)(64756008)(66556008)(53546011)(4326008)(8676002)(91956017)(38100700002)(66946007)(122000001)(38070700005)(478600001)(76116006)(86362001)(6636002)(31686004)(71200400001)(54906003)(110136005)(316002)(41300700001)(66446008)(6486002)(83380400001)(2616005)(107886003)(186003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bHJqalBFMWVTVXFjcExNY1VWZTFqVnBmOWR2N1ErdkNVWHdwZHdkS0tlSlVh?=
 =?utf-8?B?M0t2MzdzbEtqemhJUFplc0VWNk9ZVkhBUlUzY1V6VzJPZXRzV0ZKQmk3OGo1?=
 =?utf-8?B?MkJpbHN0Wi9lTVU2cmZFSWo4NE9WcEw1Vjl2bnNoVTNKcVlzOVBRV3dLNlhx?=
 =?utf-8?B?TDRVdlVFOVh1cmRONUluMDc2RDVMMDhvdXVyTzdFd3R1dGVKekN3Y3RIZ1A1?=
 =?utf-8?B?bVd3V3I5cENCWW56eG9NVmVJWThkaXkweHZ5aTkrMUZUWWI1SWhGRGIxUGRH?=
 =?utf-8?B?bU9tUFNtNjd2K2hSWU9QeGh4UE5NaVd2dWZSaERPNkJpVUg2Sk5zbnZBKytn?=
 =?utf-8?B?SS9zT2RGU3BTU2dRaGNKVUEvK05oTmVxYmVGMWhWb2JwSmtqSWZsT2tuR3Fh?=
 =?utf-8?B?VktHUzFkUVdCOUhCUFpNNDluRUg2SmdxM2lFamsxalJyV0RzSDBKME5JWE10?=
 =?utf-8?B?NjFOQWRDaVdwbHpHMkkzRklSMkg2ODJTRFFYTlZjeE1mWTNGeEYzL0tkYzJV?=
 =?utf-8?B?Q3ZOanRXMG5KamcvU1AyNnJuRzhwUDViaFcwQmhNUjBOb3FkTzRua05jcy93?=
 =?utf-8?B?YVlwZ0NvSHp1YU9ldlRCMm9qMlUxNSt6OUR3Y1NpdVVSR2xGblRCNXROYWx2?=
 =?utf-8?B?Yy9KSmZadXJtZ1AvTi9LT2prMDc4eDdyM2ZIV09GQ3c5MjNuYWVIU0FNUEZZ?=
 =?utf-8?B?ZXl3WGRPVTVGcGh5STRFL0Qwc3VvVFlBVHRRTEx2VmxORXZsWUdocC9sK0pN?=
 =?utf-8?B?aVpsOGhZaEdBS1Z3RGtkQXZnSGVtMWJzbmF1dVZQNzV0ZFpaOGlLMVlPNjE4?=
 =?utf-8?B?TEdCSUJkVlFBcmlyOHhOR1RyWHlML1ZFbGNBeXY1bkN3bUhRcWFuSElZRExB?=
 =?utf-8?B?RHFzc3pNS2YveWpUb0tCcjQyMnlKbFcyTDVqTlF0TjlYd2V5TFZsY0VGaVlr?=
 =?utf-8?B?anpBY1BMbFVnMDE2akI0TlZLbGxYSFhqZnFKU0FNSkR0aVNrT0MxRmpWRStU?=
 =?utf-8?B?NGdGSEJwY01FQ0UxK2RySWJ6eG5IaVk3TFlVcHp2cFRNY2RreFpFM1k4UHlt?=
 =?utf-8?B?aVA4K3VMbmFHSU0vdGhvSERTMEg5b01jcENVUUlFMnJXcWNFRXFRMk5ickox?=
 =?utf-8?B?ZC96MDdnNmJIbHkrUUEwVmd0Q2RZUFFrSVpwVkhJbjJ5bGdWVzZ2bHVadVRp?=
 =?utf-8?B?aUNDNUsxd3grRTgrQVJseGxrNmI2QkZVdnRqOGRDZVl5YlovdWRqaitISW9n?=
 =?utf-8?B?MExhaDY3MjdjYmRTbEdqd2FJcTJZMWNHZzU4UFc1Um1PaStFbHRyNmVmM1A3?=
 =?utf-8?B?TWV4dFRBdE1yeHFFTzBRTWp5U3owNzBOdVdOMjJ0U01NMEI4SU9YdGpFM2Jl?=
 =?utf-8?B?MEZHQVEzOVVaOVkxVzA2dzIvWlY0WUJlY1NBbXlxa2NReWJYVlIwbVliWWY1?=
 =?utf-8?B?aXgzK3FubjlGTWE2RjdFaEhVQmVCbmRUbWFlenNqSG04WE8yZEZHbFB4S0dH?=
 =?utf-8?B?SjVBUGNSeFQvQWFCNWlFU09lcnE1QVJNUW1MTlUwQ3NKYkZETDhMNlY5d3Ez?=
 =?utf-8?B?c28raExFdmt3eUhrd0FOMFIvajl6TnRLUVFzSDVSY3AyMkw4V1FZVFBYcHk0?=
 =?utf-8?B?RGNTczJkRWwyZGs1anFFdjVhSldQY0ZoMXRzbEoza3BvVFBNb1NJTGp0cEVX?=
 =?utf-8?B?VTk0K1d3d2dMUTFvQmZjeURJaFhmQk9ja2xha3Y3ZnBqVUkvZnJ0eXo4SXRl?=
 =?utf-8?B?UEpBWmZnVTJ4Nm5OYXdJRjFSYmxJWXE4K2FaZml3VFcrZlBEN3lXM0RON0M2?=
 =?utf-8?B?cThaM2REelpJOERKTHZyeTRVMDFlbUZlZVREeHdvMDlVUjF2WXI5bTlHSjMy?=
 =?utf-8?B?WHN3THVGVnRROERYbkV3T2JzbU5iVkYwMzhDbzZsYUdMbGZtMlJtdE5IQmhX?=
 =?utf-8?B?S3VDYkIyWUF3OFFHSzg2SVZHYyt5L1craFVhazdoaldPejAvOTN0RDYwdlY2?=
 =?utf-8?B?WGFqMDN3cGxuUXM1ejcrRGlqOHd0eDlOdWZSckdIY2piNzh2TU44ZWZWNStP?=
 =?utf-8?B?d3Exb0NDV1lxdmo2R3ltVkFpcmFJc0dPMmpiMHRYajZPOGZDNll4U09HT0hJ?=
 =?utf-8?Q?uEpztIoFN33nX3xbklnGisyDz?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <0367F0EF16CA304BB166F1264AEB3C45@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5154.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5bee46d8-2c75-44f5-b7b5-08da675984fa
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jul 2022 18:32:20.6651
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xrHTI+gPadzCd6DcI9MbIAjXusu+ji8f9p663JMyK++D6UMDN1UCNzDB7vQi04OcugeOTNWk7sjpyRCj5ulXF2oj+oX1Qq8itrQdqbZ+mH0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR11MB2039
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMTYvMDcvMjAyMiAxODo1MiwgTWFyYyBaeW5naWVyIHdyb3RlOg0KPiBPbiBTYXQsIDE2IEp1
bCAyMDIyIDE2OjIxOjQ4ICswMTAwLA0KPiA8TGV3aXMuSGFubHlAbWljcm9jaGlwLmNvbT4gd3Jv
dGU6DQo+Pg0KPj4gVGhhbmtzIE1hcmMsDQo+Pg0KPj4gT24gU2F0LCAyMDIyLTA3LTE2IGF0IDEx
OjMzICswMTAwLCBNYXJjIFp5bmdpZXIgd3JvdGU6DQo+Pj4gRVhURVJOQUwgRU1BSUw6IERvIG5v
dCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVubGVzcyB5b3UNCj4+PiBrbm93IHRo
ZSBjb250ZW50IGlzIHNhZmUNCj4+Pg0KPj4+IE9uIFNhdCwgMTYgSnVsIDIwMjIgMDg6MTE6MTMg
KzAxMDAsDQo+Pj4gPGxld2lzLmhhbmx5QG1pY3JvY2hpcC5jb20+IHdyb3RlOg0KPj4+PiBGcm9t
OiBMZXdpcyBIYW5seSA8bGV3aXMuaGFubHlAbWljcm9jaGlwLmNvbT4NCj4+Pj4NCj4+Pj4gQWRk
IGEgZHJpdmVyIHRvIHN1cHBvcnQgdGhlIFBvbGFyZmlyZSBTb0MgZ3BpbyBjb250cm9sbGVyLg0K
Pj4+Pg0KPj4+PiBTaWduZWQtb2ZmLWJ5OiBMZXdpcyBIYW5seSA8bGV3aXMuaGFubHlAbWljcm9j
aGlwLmNvbT4NCj4+Pg0KPj4+IFsuLi5dDQo+Pj4NCj4+Pj4gK3N0YXRpYyBpbnQgbXBmc19ncGlv
X2NoaWxkX3RvX3BhcmVudF9od2lycShzdHJ1Y3QgZ3Bpb19jaGlwICpnYywNCj4+Pj4gKyAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB1bnNpZ25lZCBpbnQgY2hpbGQsDQo+
Pj4+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgdW5zaWduZWQgaW50
IGNoaWxkX3R5cGUsDQo+Pj4+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgdW5zaWduZWQgaW50ICpwYXJlbnQsDQo+Pj4+ICsgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgdW5zaWduZWQgaW50ICpwYXJlbnRfdHlwZSkNCj4+Pj4gK3sNCj4+Pj4g
KyAgICAgc3RydWN0IG1wZnNfZ3Bpb19jaGlwICptcGZzX2dwaW8gPSBncGlvY2hpcF9nZXRfZGF0
YShnYyk7DQo+Pj4+ICsgICAgIHN0cnVjdCBpcnFfZGF0YSAqZCA9IGlycV9nZXRfaXJxX2RhdGEo
bXBmc19ncGlvLQ0KPj4+Pj4gaXJxX251bWJlcltjaGlsZF0pOw0KPj4+DQo+Pj4gVGhpcyBsb29r
cyB0b3RhbGx5IHdyb25nLiBJdCBtZWFucyB0aGF0IHlvdSBoYXZlIGFscmVhZHkgaW5zdGFudGlh
dGVkDQo+Pj4gcGFydCBvZiB0aGUgaGllcmFyY2h5LCBhbmQgaXQgaXMgbGlrZWx5IHRoYXQgeW91
IHdpbGwgZ2V0IG11bHRpcGxlDQo+Pj4gaGllcmFyY2h5IHNoYXJpbmcgc29tZSBsZXZlbHMsIHdo
aWNoIGlzbid0IGludGVuZGVkLg0KPj4NCj4+IFNvbWUgYmFja2dyb3VuZCB3aHkgSSB1c2UgdGhl
IGFib3ZlLg0KPj4gV2UgbmVlZCB0byBzdXBwb3J0IGJvdGggZGlyZWN0IGFuZCBub24tZGlyZWN0
IElSUSBjb25uZWN0aW9ucyB0byB0aGUNCj4+IFBMSUMuIA0KPj4gSW4gZGlyZWN0IG1vZGUgdGhl
IEdQSU8gSVJRJ3MgYXJlIGNvbm5lY3RlZCBkaXJlY3RseSB0byB0aGUgUExJQyBhbmQNCj4+IGNl
cnRhaW5seSBubyBuZWVkIGZvciB0aGUgYWJvdmUuIEdQSU8ncyBjYW4gYWxzbyBiZSBjb25maWd1
cmVkIGluIG5vbi0NCj4+IGRpcmVjdCwgd2hpY2ggbWVhbnMgdGhleSB1c2UgYSBzaGFyZWQgSVJR
LCBoZW5jZSB0aGUgYWJvdmUuDQo+IA0KPiBUaGF0J3MgdW5mb3J0dW5hdGVseSBub3QgYWNjZXB0
YWJsZS4gWW91IG5lZWQgdG8gZGlzdGluZ3Vpc2ggd2hpY2ggb25lDQo+IGlzIHdoaWNoLCBhbmQg
c2VwYXJhdGUgdGhlbS4gWW91ciBub24tZGlyZWN0IG1vZGUgY2VydGFpbmx5IHJlcXVpcmVzDQo+
IHNwZWNpYWwgaGFuZGxpbmcsIGFuZCBpcyBub3QgZml0IGZvciBhIGhpZXJhcmNoaWNhbCBtb2Rl
Lg0KDQpVbmZvcnR1bmF0ZWx5LCB0aGUgY29uZmlndXJhdGlvbiBpcyBub3QgZml4ZWQgb24gdGhl
IHNpbGljb24gbGV2ZWwuIFRoZQ0KU29DIGhhcyAzIEdQSU9zICh3aXRoIDMyIGxpbmVzIGVhY2gp
LiBUaGUgaW50ZXJydXB0IGNvbmZpZ3VyYXRpb24gbG9va3MNCnNvbWV0aGluZyBsaWtlIHRoZSBi
ZWxvdzoNCkdQSU8jICAgICAgICAgICAgIHdpZHRoICAgIElSUSMNCj09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT0NCmdwaW8wLzIgICAgICAgICAgIDE0ICAgICAgIFsyNjoxM10NCmdw
aW8xLzIgICAgICAgICAgIDI0ICAgICAgIFs1MDoyN10NCmdwaW8wX25vbl9kaXJlY3QgIDEgICAg
ICAgICA1MQ0KZ3BpbzFfbm9uX2RpcmVjdCAgMSAgICAgICAgIDUyDQpncGlvMl9ub25fZGlyZWN0
ICAxICAgICAgICAgNTMNCg0KRGVwZW5kaW5nIG9uIHdoYXQgdGhlIGJvb3Rsb2FkZXIvZmlybXdh
cmUgZG9lcywgdGhlc2UgY2FuIGJlIGNvbmZpZ3VyZWQNCmRpZmZlcmVudGx5IChkb25lIHByaW9y
IHRvIGxpbnV4IHN0YXJ0aW5nKS4gQnkgZGVmYXVsdCwgMTQgR1BJT3MgZnJvbQ0KR1BJTzAgYXJl
IGZlZCBpbnRvIHRoZWlyIG93biBpbnRlcnJ1cHQgbGluZXMgJiBkaXR0byBmb3IgMjQgZnJvbSBH
UElPMS4NClRoZSByZW1haW5pbmcgR1BJTzAgJiBHUElPMSBsaW5lcyBnbyBpbnRvIHRoZSBjb3Jy
ZXNwb25kaW5nIG5vbi1kaXJlY3QNCmludGVycnVwdC4gSWYgdGhleSBib290bG9hZGVyL2Zpcm13
YXJlIGNvbmZpZ3VyZXMgc29tZXRoaW5nIGRpZmZlcmVudCwNCmEgImRpcmVjdCIgaW50ZXJydXB0
IGxpbmUgY2FuIGJlIHN3aXRjaGVkIHRvIGEgR1BJTzIgbGluZSBpbnN0ZWFkLg0KDQpTb21ldGhp
bmcgbGlrZSB0aGUgZm9sbG93aW5nICh0aGUgaW50ZXJydXB0cyBhcmUgb2Zmc2V0IGJ5IDEzIGhl
cmUsIGFzDQp0aGUgZ2xvYmFsIGludGVycnVwdHMgZmVlZCBpbnRvIHRoZSBQTElDIGF0IGFuIG9m
ZnNldCk6DQoNCiogZ2xvYmFsIGludCAgR1BJT19JTlRFUlJVUFRfRkFCX0NSDQogICAgICAgICAg
ICAgICAgMCAgICAgICAgICAgICAgIDENCiAgICAwICAgICAgIEdQSU8wIGJpdCAwICAgICBHUElP
MiBiaXQgMA0KICAgIDEgICAgICAgR1BJTzAgYml0IDEgICAgIEdQSU8yIGJpdCAxDQogICAgLg0K
ICAgIC4NCiAgICAxMiAgICAgIEdQSU8wIGJpdCAxMiAgICBHUElPMiBiaXQgMTINCiAgICAxMyAg
ICAgIEdQSU8wIGJpdCAxMyAgICBHUElPMiBiaXQgMTMNCiAgICAxNCAgICAgIEdQSU8xIGJpdCAw
ICAgICBHUElPMiBiaXQgMTQNCiAgICAxNSAgICAgIEdQSU8xIGJpdCAxICAgICBHUElPMiBiaXQg
MTUNCiAgICAuDQogICAgLg0KICAgIC4NCiAgICAzMCAgICAgIEdQSU8xIGJpdCAxNiAgICBHUElP
MiBiaXQgMzANCiAgICAzMSAgICAgIEdQSU8xIGJpdCAxNyAgICBHUElPMiBiaXQgMzENCiAgICAz
MiAgICAgICAgICBHUElPMSBiaXQgMTgNCiAgICAzMyAgICAgICAgICBHUElPMSBiaXQgMTkNCiAg
ICAzNCAgICAgICAgICBHUElPMSBiaXQgMjANCiAgICAzNSAgICAgICAgICBHUElPMSBiaXQgMjEN
CiAgICAzNiAgICAgICAgICBHUElPMSBiaXQgMjINCiAgICAzNyAgICAgICAgICBHUElPMSBiaXQg
MjMNCiAgICAzOCAgT3Igb2YgYWxsIEdQSU8wIGludGVycnVwdHMgd2hvIGRvIG5vdCBoYXZlIGEg
ZGlyZWN0IGNvbm5lY3Rpb24gZW5hYmxlZA0KICAgIDM5ICBPciBvZiBhbGwgR1BJTzEgaW50ZXJy
dXB0cyB3aG8gZG8gbm90IGhhdmUgYSBkaXJlY3QgY29ubmVjdGlvbiBlbmFibGVkDQogICAgNDAg
IE9yIG9mIGFsbCBHUElPMiBpbnRlcnJ1cHRzIHdobyBkbyBub3QgaGF2ZSBhIGRpcmVjdCBjb25u
ZWN0aW9uIGVuYWJsZWQNCg0KU2luY2Ugd2UgY2FuIHRlbGwgYmFzZWQgb24gdGhlIGludGVycnVw
dCBudW1iZXIgaW4gdGhlIGRldmljZSB0cmVlDQp3aGV0aGVyIGEgbGluZSBpcyBpbiBkaXJlY3Qg
bW9kZSAtIGNhbiB5b3Ugc3VnZ2VzdCB3aGF0IHRoZSBtb3N0IA0KYXBwcm9wcmlhdGUgaXJxIHN0
cnVjdHVyZSBmb3IgdGhlIGRyaXZlcj8NCg0KQWx0aG91Z2ggZm9yIGV4dGVuZGluZyB0aGlzIGRy
aXZlciB0byB0aGUgInNvZnQiIElQIGNvcmUsIGl0IG1heSBiZSBlYXNpZXINCnRvIGp1c3QgY3Jl
YXRlIGEgIm1pY3JvY2hpcCxncGlvLWRpcmVjdC1tb2RlLW1hc2siIHByb3BlcnR5IG9yIHNpbWls
YXIgYW5kDQp1c2UgdGhhdCB0byBmaWd1cmUgb3V0IHdoYXQgY29uZmlndXJhdGlvbiBhIGxpbmUg
aXMgaW4uDQoNClRoYW5rcywNCkNvbm9yLg0K
