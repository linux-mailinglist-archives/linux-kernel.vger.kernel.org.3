Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7360757465A
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 10:10:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229955AbiGNIKP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 04:10:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229913AbiGNIKN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 04:10:13 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6F4F2B1A0
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 01:10:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1657786210; x=1689322210;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=Esh5Fy977fyg1Iw27cEx9kLphIoOSnERX/oz7eCNax8=;
  b=As7+WJh31lW28ghFw0TU9CaxyvjX+CofQuBONU3CnFOMdc6hrHVkoSRz
   YR4UZrF7ktGSEz65BXN2bkhzotokPWGlw65XfDR75kthLRycAGGZ/IMZm
   +8WqIhwpUvNARQiBRISw7/UengJeGB6pZ+bR0J516R1YlkFAbpBNRCsRh
   Kgg7ceI+KAsDyfcnv6/ECLarsDZs/BvWLPvJPI9xxQlSULLJ7R8Wx71yA
   KsTvz3SmTFuBmHvQO3mYnOx5WiMNzuK/TXvGZJGhJaRzKe0l/9fLJvyQs
   B+gAr8jel644k0DPjI12ABScvg+2+xLFI/BTNE4vaWGfekvOM7UfAmU4C
   A==;
X-IronPort-AV: E=Sophos;i="5.92,269,1650956400"; 
   d="scan'208";a="167790770"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 14 Jul 2022 01:10:10 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Thu, 14 Jul 2022 01:10:09 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17 via Frontend Transport; Thu, 14 Jul 2022 01:10:08 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lNqPSd//b5DTBk9RE1gNxhVF3vYGk2LbrSfRZ6G6+3xuzusxsQ50rF407aqCw8kcj2u/oLPGl0aK0V7/uET1apQh5buYG7t3zzngxCVGtvPcVyr0VYEzD1GK8zwQazqqonJTjKqPo1RhRtDj21Hw90xrv7nof6jsiYCfoGV3NKFJlaxlGvbLG3+vxCAFBy7QHPNkBU8jS5BupPO5PAWdm09SAHrpOnNfjV+LtktKB+i5SG2q62E5R5CTIIyXk2Rn+2fucf7MSB8OQCQmsdpIpbA7qD+L3rHVJUdl2g+WuS/gJSLNkaG1fIfQNpOOkiglz0JOi97IeYFF3ic/GGD8tA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Esh5Fy977fyg1Iw27cEx9kLphIoOSnERX/oz7eCNax8=;
 b=NPwEejxJPXXyTYtJXE2hz0VHhFbvvx87H//q1qr/1S8DNOE59YaBXvaxKYHZFTAD6RgC9JGo2AebgjGMMHhEduOvJzoe4JZszvPhfV2xWR2s2zo5cEnAaWY9W+LKBlU4GxeEL3VQ3YXYaCZU4JW8ej4XlnwJ2+2L2AYxhwROYo13VXOigAJjbKbn9Br21u48hFHASaIa7vVos04ZI4YSUTVDuecnawRXbndRMnJlALPS6FMQCBvUJMXUdEk3w6GSXZvPpLYg70h9xpn2BCxyuqz1NjdfocW75mAHLuR+nJt/4VGgBiuRdiZErc9n4ar8qdqtxNHM3NiHlM1Szei4mQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Esh5Fy977fyg1Iw27cEx9kLphIoOSnERX/oz7eCNax8=;
 b=uM4e49tQIftVyNN/IhohtBJqTKyyCBQNncfGZ0SZzhPLOO3scrJfqZriz6AGXz8wkvme7KSalJFGkVZw+BLyJNMx+Wz5tYBHMNNHUTxadnX4mZrkaSzAd0zRDrkl7B10DOCBetM5/xKm432z0jAnybEeXyvjnLaCPCIZq6TCRKE=
Received: from CO1PR11MB5154.namprd11.prod.outlook.com (2603:10b6:303:99::15)
 by PH0PR11MB5125.namprd11.prod.outlook.com (2603:10b6:510:3e::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.20; Thu, 14 Jul
 2022 08:10:04 +0000
Received: from CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::357a:acc9:829e:bf7b]) by CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::357a:acc9:829e:bf7b%7]) with mapi id 15.20.5438.014; Thu, 14 Jul 2022
 08:10:04 +0000
From:   <Conor.Dooley@microchip.com>
To:     <ben.dooks@sifive.com>, <linux-kernel@vger.kernel.org>
CC:     <sudip.mukherjee@sifive.com>, <jude.onyenegecha@sifive.com>
Subject: Re: [PATCH] kernel/hung_task: fix address space of
 proc_dohung_task_timeout_secs
Thread-Topic: [PATCH] kernel/hung_task: fix address space of
 proc_dohung_task_timeout_secs
Thread-Index: AQHYl1kfrOP0UPBSyE2rMtpWiD5qiw==
Date:   Thu, 14 Jul 2022 08:10:04 +0000
Message-ID: <aa78a638-a201-1a58-f168-f36a9f272fbb@microchip.com>
References: <20220714074744.189017-1-ben.dooks@sifive.com>
In-Reply-To: <20220714074744.189017-1-ben.dooks@sifive.com>
Accept-Language: en-IE, en-US
Content-Language: en-IE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c43feaf6-12c6-45a1-8bf8-08da657041d0
x-ms-traffictypediagnostic: PH0PR11MB5125:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: upZ+LZBHqkSyC7VNgF3yRZ4EH9js9miyggKTskLYy9FIqwPvk8MowossJi3ZdSCAabhRWByxnWJ/eyEEsR+rE8L00P8tfg0xYDgd5N77OTS+zdIKDN4uewkvr7x7J8ownKCh3LqHpiR/A6sGv4vXtacqU6I6DDmtbpYh9+fP7N3nsMKj3yQYHT3OmS9aYfzJ0bJgkFnSH2Xb38xc7izAFfsv158yasLjINy2lwfMhiNGtlepNgfZrRocAu527r/u5OpjLL/JzWZISmiZz0LAdTW/cMZGtIVdaPy5arG58GWWAXRUhs1VvfdAPmAAZ67FG88IfnOJ9qaKOWTVbFtwj7knvoC5jIP8/yTZ0fXGlChhABkXhiSPTdlgp3MOXjArQ5FDhNTpe7V6nskgSPNMGcINzs+HSp3i3f2sorGJPaDw4YLRP60leCMeuczkzK9NqvZDBDk61MW/qQBUS9ZmZ7EhM0y6D4V3M3iVAn5EtzR+Xz7glMZ92BbC1or3P9SY6dP7k0iXa2yG0gih4pbeagJrPcfWBLN6B2mI96BLd03yl6XYbIkMmpwgJmxkkgN95gW4J7SgEGQTP6qv8Okh2Hn4LOumxh8yGRB9z3SEX0FUbmM/qgQh6da/uSCEU0gCXYqwvflbwlFAlORrONIkTgs1A8PjpmEpfB7x0MDIoeUeymtkr8/l5lB4AIaly/jWZNqB0nlvr3JPS5hykDVnhIX1Ov6tkGOF82yiRdIbm2jfjDnkoB5lQ9cEBmZbLUhwwBdFAXFEiEnugjW4ADvqEcA/qoM+ecJuc2wnz4aybIJGBsbNCAiKWDoeYzk2B+dBa4I53huG6e4Z7e7qkY1eRxVtdS2cozRFXHkeADUzMJ3hsRY2csQ0Q4TiXzynHU2G
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5154.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(136003)(366004)(346002)(396003)(39860400002)(376002)(31686004)(41300700001)(478600001)(66946007)(38100700002)(38070700005)(36756003)(8936002)(2906002)(2616005)(6486002)(91956017)(86362001)(122000001)(186003)(53546011)(6506007)(83380400001)(110136005)(8676002)(64756008)(26005)(66556008)(316002)(31696002)(54906003)(66446008)(4326008)(66476007)(71200400001)(5660300002)(6512007)(76116006)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?M2RvV09EVUpmTVdMYkhEVGdnNDBaVVpLUklIUlUzWnlsK0dONU85eWk5ZHpq?=
 =?utf-8?B?alVtS29nejZZcUlzekd4aTdpTXdwRHhvVDJ2cW1kRGpaMExWSnRxZWR6eU95?=
 =?utf-8?B?WkNvNjNNRXltUVluaUtCVUpmdU9XM3JDRWk4d0l3SU8rcHFmbTE5bUFuUklG?=
 =?utf-8?B?VjlMYnpxTkZxNXlpVEN1U3ZlWWNYVEtOZVRGblpNVTQ4d3NmbitNUDk1ZDhy?=
 =?utf-8?B?a2JqQmN3a0xZUW1uNXNSUW1GcEx2bkF4dEt0RFFDYXptK0VJa0RsRGlGZFlw?=
 =?utf-8?B?bDRUTkFCbE5FYUhVbm9zUXVVNXptOWV0ME5BQlIyYnRpSWtROEVzTGgxT2py?=
 =?utf-8?B?R2JZQnlhMDQvaWJKZFc4MjR6UzVHb0RGSDRySjN4RDZzUEU4dDRTS1VaNWdY?=
 =?utf-8?B?eUVrZ1ViT1VqMVVqenRpQXhtWWEvNjViMys3OXR0anVRdXFKSmJoQ2NXMEc5?=
 =?utf-8?B?NXlnYm9McTJRVUs1dlFDMkV1K3M5VnNnQ2x0WnVHQmpmd0JjOW1FZVpkZy9n?=
 =?utf-8?B?d3JINzd3TlNjV0wrajB4ZFNHZDZyZDVEL3JscHpRTVY2QmgzZVA2NnE5a3A0?=
 =?utf-8?B?emZkUDJRSndZYkJ0SWZta1Jpa1hMVHZBRVlOU2U3bitwR21nSUp1ZTEvdkgw?=
 =?utf-8?B?OUROblc5WEQzcXVpa1BHeVdHczlCSVNIcnpxblJ6NkFrTlJrWC9ENk1BSVF0?=
 =?utf-8?B?T3M0UHBRRW5HUG9SbFp1R3JwYVFuQlRpRW80ZnRlWXJwMDFGdGd4YlB0R2xZ?=
 =?utf-8?B?bzhnT29lSUVDK21xMkZSZzZxZlNvOUFaUnk0d0N6RklrWmNxbnVZcXZ6NElF?=
 =?utf-8?B?TUl6a2owZjl1SzB2OHVFRzVpcERqdWliWXdJME5zMm9sb0ZVK0dydk0xVGMy?=
 =?utf-8?B?VkNRM1VZaGRtWnA2VjNmclJ3bGJmTjlaemFyZENxY1pZazgyb24zK1hoODRi?=
 =?utf-8?B?U3VCZWgzSVJMN1ljcHYwNHBaVWhmL291VDh0d2g3U25DTkI5bk5TSjBpd3da?=
 =?utf-8?B?MEV3SEVMek91Vk9Sc3dsSkcrSGxSQ1ZUdTM3OTBBZkp5Q2dzM01DcmxjaFlu?=
 =?utf-8?B?UGlEWVJLalF4M0Vpb0NCaGcxVDlLdXRGWG5lZ3JENmh6SWtqbjBQY1RscUMv?=
 =?utf-8?B?ZUhzdWhGT2cyd3hZV3dSMUdCeUF2eksyaXdITjQyVHVnQlR2MnpHUXNIWUtK?=
 =?utf-8?B?Q3JRZW1mVWlxTlB2MitXQ2IwUHBlWHFuL0RQWTFiMFk5RlcycklpOWgxTHBK?=
 =?utf-8?B?ekpMNG1lbjZ4aHNCZzdyekpYRWQvbk5pOUY2ak0yUHNKbFJLYzBlMWc5Y3Fu?=
 =?utf-8?B?VDVJZ2hSZDlUQ0l5MnhxZlRCV2VMdWluTUpVbXhUSDJnYmNnMmV1QncwNzFr?=
 =?utf-8?B?T1A2c3NrekJuNWZ4M1NXS1NOcWFVTDZoNVBmaDZiQTJaS2V2dmw2b3NMWmho?=
 =?utf-8?B?M2xJeEhsOEd5b0hLQ1lmWUVQTmtNbjQwcHRaQmpUMTJwOE1JSHFhSGFQOUVV?=
 =?utf-8?B?eDBkQWI2dzdoY2d0S3dWcmNJd1RrNkxiWVJhekY3UVZ2MHlQc2puVTZzYkdx?=
 =?utf-8?B?ZS9hQXFlcEFkTjkxYmFzWnRMYzBZaGo4U254T2sxWnh5ZmRFS0N4cm9TR21T?=
 =?utf-8?B?VzEzcjMwMFNXY1JKZFIvVVBSc2U1Tk82WDlmZ0QrcXpnQmd1ZjNPVFp0M1J5?=
 =?utf-8?B?b3RXRE1aRFFqOXR3TzRqLzhzT0dieHJmajZBUDBNMUxlRHdGYm8zck05YjBI?=
 =?utf-8?B?dUJza01aNGp1TWZUYTBDUWdld2tianBpNVlzaUY4aHNvcllWclU1RDJtNXpj?=
 =?utf-8?B?UkRPQUs2WW90eWY1Y2E5ekZvZWJTN29SZnVWZm8vNXI2ZUtEbmhzbHRkUzFi?=
 =?utf-8?B?NnhyMERhMzRQU2hzdmZWbUhrWThObm5PUWpXMEdMcHNSZWRhWFF0VW1XSzQ2?=
 =?utf-8?B?RDBmc050REFXVVNVMi91eDAxMXUwWWxnSHpJRUNTaHlkZUU1QlZTeUZYQmYz?=
 =?utf-8?B?STRBQ1N0TXMvZU1URVFtVHlVd3kwTU9xcm1DWFpCQVloY0pWQ3ZGbmxuTXlt?=
 =?utf-8?B?L2E1QUdKeHpyVUV4Wm0zNXZhTEptMUZHemJnMkZ4Tm90RW5wMjNuK2NIano1?=
 =?utf-8?Q?uDf4zlaIs5ZfUf8haipgrQamN?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <BE8ED5E43BD3834BA7E2B42275068D82@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5154.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c43feaf6-12c6-45a1-8bf8-08da657041d0
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jul 2022 08:10:04.0807
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: z9ts4qh5tTHdt7j9zIqaRzxRbUCE7NqzPiGXl7kra4hbfcNx/K0Dp/yJK77sxsuesrfiOR9JuwmwRHdWPzqMAEWt9Ej1Xkomj/eyP68te0U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5125
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMTQvMDcvMjAyMiAwODo0NywgQmVuIERvb2tzIHdyb3RlOg0KDQpIZXkgQmVuLA0KT2RkIEND
IGxpc3QgaGVyZT8gSSBhc3N1bWUgeW91J3JlIHBpcGluZyBnZXRfbWFpbnRhaW5lciBpbnRvDQpz
ZW5kLWVtYWlsIG9yIHNvbWV0aGluZywgYnV0IGlkayB3aG8gaXMgZ29pbmcgdG8gc2VlIG9yIGFw
cGx5DQp0aGlzIHBhdGNoISBEaXR0byB5b3VyIG90aGVyIG9uZSBmb3IgdGhpcyBmaWxlLg0KDQpN
aWdodCBiZSB3b3J0aCBhZGRpbmcgc29tZSBvZiB3aGF0IGdldF9tYWludGFpbmVyIHNwaXRzIG91
dDoNClBldHIgTWxhZGVrIDxwbWxhZGVrQHN1c2UuY29tPiAoY29tbWl0X3NpZ25lcjo0LzQ9MTAw
JSxhdXRob3JlZDoxLzQ9MjUlLHJlbW92ZWRfbGluZXM6MTAvMTU9NjclKQ0KQW5kcmV3IE1vcnRv
biA8YWtwbUBsaW51eC1mb3VuZGF0aW9uLm9yZz4gKGNvbW1pdF9zaWduZXI6Mi80PTUwJSkNClJh
c211cyBWaWxsZW1vZXMgPGxpbnV4QHJhc211c3ZpbGxlbW9lcy5kaz4gKGNvbW1pdF9zaWduZXI6
MS80PTI1JSxhdXRob3JlZDoxLzQ9MjUlLHJlbW92ZWRfbGluZXM6MS8xNT03JSkNCkpvaG4gT2du
ZXNzIDxqb2huLm9nbmVzc0BsaW51dHJvbml4LmRlPiAoY29tbWl0X3NpZ25lcjoxLzQ9MjUlLGF1
dGhvcmVkOjEvND0yNSUsYWRkZWRfbGluZXM6MTAvOTA9MTElLHJlbW92ZWRfbGluZXM6MS8xNT03
JSkNCktlZXMgQ29vayA8a2Vlc2Nvb2tAY2hyb21pdW0ub3JnPiAoY29tbWl0X3NpZ25lcjoxLzQ9
MjUlKQ0KWGlhb21pbmcgTmkgPG5peGlhb21pbmdAaHVhd2VpLmNvbT4gKGF1dGhvcmVkOjEvND0y
NSUsYWRkZWRfbGluZXM6NzgvOTA9ODclLHJlbW92ZWRfbGluZXM6My8xNT0yMCUpDQoNClRoYW5r
cywNCkNvbm9yLg0KDQoNCj4gVGhlIHByb2NfZG9odW5nX3Rhc2tfdGltZW91dF9zZWNzKCkgZnVu
Y3Rpb24gaXMgaW5jb3JyZWN0bHkgbWFya2VkDQo+IGFzIGhhdmluZyBhIF9fdXNlciBidWZmZXIg
YXMgYXJndW1lbnQgMy4gSG93ZXZlciB0aGlzIGlzIG5vdCB0aGUNCj4gY2FzZSBhbmQgaXQgaXMg
Y2FzaW5nIG11bHRpcGxlIHNwYXJzZSB3YXJuaW5ncy4gRml4IHRoZSBmb2xsb3dpbmcNCj4gd2Fy
bmluZ3MgYnkgcmVtb3ZpbmcgX191c2VyIGZyb20gdGhlIGFyZ3VtZW50Og0KPiANCj4ga2VybmVs
L2h1bmdfdGFzay5jOjIzNzo1Mjogd2FybmluZzogaW5jb3JyZWN0IHR5cGUgaW4gYXJndW1lbnQg
MyAoZGlmZmVyZW50IGFkZHJlc3Mgc3BhY2VzKQ0KPiBrZXJuZWwvaHVuZ190YXNrLmM6MjM3OjUy
OiAgICBleHBlY3RlZCB2b2lkICoNCj4ga2VybmVsL2h1bmdfdGFzay5jOjIzNzo1MjogICAgZ290
IHZvaWQgW25vZGVyZWZdIF9fdXNlciAqYnVmZmVyDQo+IGtlcm5lbC9odW5nX3Rhc2suYzoyODc6
MzU6IHdhcm5pbmc6IGluY29ycmVjdCB0eXBlIGluIGluaXRpYWxpemVyIChpbmNvbXBhdGlibGUg
YXJndW1lbnQgMyAoZGlmZmVyZW50IGFkZHJlc3Mgc3BhY2VzKSkNCj4ga2VybmVsL2h1bmdfdGFz
ay5jOjI4NzozNTogICAgZXhwZWN0ZWQgaW50ICggW3VzZXJ0eXBlXSAqcHJvY19oYW5kbGVyICko
IC4uLiApDQo+IGtlcm5lbC9odW5nX3Rhc2suYzoyODc6MzU6ICAgIGdvdCBpbnQgKCAqICkoIC4u
LiApDQo+IGtlcm5lbC9odW5nX3Rhc2suYzoyOTU6MzU6IHdhcm5pbmc6IGluY29ycmVjdCB0eXBl
IGluIGluaXRpYWxpemVyIChpbmNvbXBhdGlibGUgYXJndW1lbnQgMyAoZGlmZmVyZW50IGFkZHJl
c3Mgc3BhY2VzKSkNCj4ga2VybmVsL2h1bmdfdGFzay5jOjI5NTozNTogICAgZXhwZWN0ZWQgaW50
ICggW3VzZXJ0eXBlXSAqcHJvY19oYW5kbGVyICkoIC4uLiApDQo+IGtlcm5lbC9odW5nX3Rhc2su
YzoyOTU6MzU6ICAgIGdvdCBpbnQgKCAqICkoIC4uLiApDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBC
ZW4gRG9va3MgPGJlbi5kb29rc0BzaWZpdmUuY29tPg0KPiAtLS0NCj4gICBrZXJuZWwvaHVuZ190
YXNrLmMgfCAyICstDQo+ICAgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0
aW9uKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEva2VybmVsL2h1bmdfdGFzay5jIGIva2VybmVsL2h1
bmdfdGFzay5jDQo+IGluZGV4IGNmZjNhZThjODE4Zi4uYmIyMzU0ZjczZGVkIDEwMDY0NA0KPiAt
LS0gYS9rZXJuZWwvaHVuZ190YXNrLmMNCj4gKysrIGIva2VybmVsL2h1bmdfdGFzay5jDQo+IEBA
IC0yMjksNyArMjI5LDcgQEAgc3RhdGljIGxvbmcgaHVuZ190aW1lb3V0X2ppZmZpZXModW5zaWdu
ZWQgbG9uZyBsYXN0X2NoZWNrZWQsDQo+ICAgICogUHJvY2VzcyB1cGRhdGluZyBvZiB0aW1lb3V0
IHN5c2N0bA0KPiAgICAqLw0KPiAgIHN0YXRpYyBpbnQgcHJvY19kb2h1bmdfdGFza190aW1lb3V0
X3NlY3Moc3RydWN0IGN0bF90YWJsZSAqdGFibGUsIGludCB3cml0ZSwNCj4gLQkJCQkgIHZvaWQg
X191c2VyICpidWZmZXIsDQo+ICsJCQkJICB2b2lkICpidWZmZXIsDQo+ICAgCQkJCSAgc2l6ZV90
ICpsZW5wLCBsb2ZmX3QgKnBwb3MpDQo+ICAgew0KPiAgIAlpbnQgcmV0Ow0K
