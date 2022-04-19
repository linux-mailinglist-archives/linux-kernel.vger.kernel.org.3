Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBBD5506BFD
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 14:12:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352033AbiDSMOm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 08:14:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352402AbiDSMNJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 08:13:09 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF93637AB5
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 05:08:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1650370106; x=1681906106;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=ao2lpUbTzPu9bXctBW/VTjT1RGKwTvZ11Cx6m9gRCsQ=;
  b=GX3b4aWZKGS7mOoc5WH/EX+OVEeo9AtIjVAk2pPZETwhv4j2ZKEhdF+a
   zsPL03A/OiOhbkwenJkt/dDGAvWpep/u7JupACoEh3YP1ovs4fmMwf1F0
   pzcXeKNYnoAf4wcgiraX0F5bTbhiSqZ+7poac7sMchuzW5Ndga0AB1YLy
   CNR159Bta0VKS/wh9g8zTksf2wXoA6hkxJqGiw8Pig0+UjP0lVFvZ67Gj
   aUkMehMOotOn6bMtesixvdKGW1vIAN7tjrh9O/fa4UYv6IELErhJvTwyQ
   vKI7rzfll0zP9EeI9glWelz78UkpsZ9W170W/hz3NPR3zvrHHyFQzLjsa
   w==;
X-IronPort-AV: E=Sophos;i="5.90,272,1643698800"; 
   d="scan'208";a="155988994"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 19 Apr 2022 05:08:24 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Tue, 19 Apr 2022 05:08:24 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17 via Frontend Transport; Tue, 19 Apr 2022 05:08:24 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Rk5SD/nUZOHs7l0u+Pct2eElpmVNmIjbOP2KqJBDqNeC+WWxZIvn3iDbcdwilWI9uvewPidYPLLQNabUX5rlOH295oSCR5W0SlCkcE7LPbLmG3jK9LfHHLsEA8ph3ySiBuuRUOE8H/bIyoQVYa2nKQXc7xQQGdWGX/ekm1jGTSU3zagluxsOoU2P8FZIK7fCN21zbxyex8aJ+yryc318q3ARk78jN0xphduvpYyVyo+4YEvxH+CX7vy0u6lskSrxEwkesu8+AXgQMy2mouxLnxNVT+wAG5wXEb11vz2y60B62CiNP9AQZSqxm/ZqAfpevxxmmKg0IW2fha8ar/Fxiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ao2lpUbTzPu9bXctBW/VTjT1RGKwTvZ11Cx6m9gRCsQ=;
 b=Wvk7umfr4a6habcRCC5FPdQeSd7y6kzRuofQElUZz8Ry98I/M99qzv5HPyLlE1CAJe+zWNCB0bDQ7A1S73UltFmDC66L3m1aTMVUS2OgFbjdP1cv4Q6LrBHXO/fTsgrw1aNn3fOrkf9I9d2rHyysJ86Xv7kxlR7kExFchcDGyyFMXmvqgXm199OXW+4CZLgpbi1PQ+0StGxB4/n9tMlCdhFtzoPq4bRnQDj1Kufc2xwaN5CYjQkYzO7IURttNe/2UC5VFTusUakJdltLc1CIqOMnWJs9MnzqC+WpabydnZXA7lQqVoWlP9Gz8gy9rBoCXz/Uq4+f4hzhGON2LxYXHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ao2lpUbTzPu9bXctBW/VTjT1RGKwTvZ11Cx6m9gRCsQ=;
 b=dS1a405niJhNobfwFVzAIXD5Jo4kwLn57pjGZRBX9a3BV0HkV2gbnLQ6nxsYDRoqOZdcwMeM+I9DVnoGTcNu/NdyOHve6Y7CLGj1P9Tx4pRJgDSUWE8RUvc23rUfpP9e6vwdFOtolna1Fzpm79cyHb4950ZVrBBms0DISwlJmuI=
Received: from SA2PR11MB4874.namprd11.prod.outlook.com (2603:10b6:806:f9::23)
 by SN6PR11MB3392.namprd11.prod.outlook.com (2603:10b6:805:c5::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.20; Tue, 19 Apr
 2022 12:08:09 +0000
Received: from SA2PR11MB4874.namprd11.prod.outlook.com
 ([fe80::3414:43b2:d8a:bc00]) by SA2PR11MB4874.namprd11.prod.outlook.com
 ([fe80::3414:43b2:d8a:bc00%7]) with mapi id 15.20.5186.013; Tue, 19 Apr 2022
 12:08:09 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <michael@walle.cc>
CC:     <p.yadav@ti.com>, <miquel.raynal@bootlin.com>, <richard@nod.at>,
        <vigneshr@ti.com>, <linux-mtd@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <Nicolas.Ferre@microchip.com>,
        <Takahiro.Kuwano@infineon.com>
Subject: Re: [PATCH v3 6/9] mtd: spi-nor: core: Add helpers to read/write any
 register
Thread-Topic: [PATCH v3 6/9] mtd: spi-nor: core: Add helpers to read/write any
 register
Thread-Index: AQHYU+YijgcwOSWAuEOiQaxrAfyzHw==
Date:   Tue, 19 Apr 2022 12:08:09 +0000
Message-ID: <f318dbd9-d4bf-301a-b5c9-556d04d5bfe6@microchip.com>
References: <20220411091033.98754-1-tudor.ambarus@microchip.com>
 <20220411091033.98754-7-tudor.ambarus@microchip.com>
 <0e4ec58c21490dcd9cf82ab89bd8c34c@walle.cc>
 <e21b0d76bf778f78f432ba27a673222d@walle.cc>
In-Reply-To: <e21b0d76bf778f78f432ba27a673222d@walle.cc>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0091835c-8ba2-4f33-29ff-08da21fd4537
x-ms-traffictypediagnostic: SN6PR11MB3392:EE_
x-microsoft-antispam-prvs: <SN6PR11MB33923C6C8BD8A6E6B1A7AEE7F0F29@SN6PR11MB3392.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ZNxRtyT5rqGjJjsq6ulOtYCdhBpAV0F2Of6iaowF811zTzf/Q4n0bdg7jy9R8HFwpgGOHq4nSlKz2Yz1KgjcUS3y86pU81OjQ7ebvRV+gGX8Xjzf+njZa+F13ONL0XssJTkerlkDU8XNEC23fEoSwhPmSDOaPx+JjDgQAQVLJGODUyApIZ70Rywf0c4nyR7KjgEbmWM2pHDsJt+8S7mX9I9daLHWHrHkEtbn9P31g74L4pHPEQvjAk2Ou934SGVex8UCwC4wF4BivgZ2l016oBgsrNG1XjFkTDC1VYQN9I1Xwnmkk0owhkgI+gBbYN5ULh1r9kWCW/F/CHF0BVdbaUziH0fbxAgkaEU8vNP5q0jKguVWC9KGa3fmJ2GR61vfHXLQUQ3rJ+qa4GETzTGvkDtXWtNTUZySthzEiAofzuc0dx8F8Vpd1NnLgGwDZHJAnKMurR6Ein5bi9RtQeUSEXTLSa5Fw97lKD9j2A2siuZ/pVgwdpxBBBaSEjc29l0orj/hqj0+anqDwxuhe0jg9dBYRySO4Ax8hSv15CDuRDL7SqCNOst1dy0AHAd3nqjdbEY5KM8T8dyubmxWLKbhpN6cJ8OPwfYgxf8EMhpggVC7CDpWt7rDQzm6mT5pUd8/5wTIXlYChlWUy0Muq6iriTgH0d8/vPhqVjT3WYlYLSNHc3d6VtNl5lbsabypU2dhdZdbcZzVZ1Q/0nTfuowo4Kp97CtuZwxMouBciA5UB/dYwQW6L9+kgVlWChEnOvYn7+IXEOzORTqmu/vQzNG97A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA2PR11MB4874.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(6512007)(6486002)(122000001)(2616005)(53546011)(71200400001)(186003)(2906002)(6506007)(5660300002)(38100700002)(38070700005)(508600001)(8936002)(26005)(86362001)(31696002)(31686004)(36756003)(316002)(54906003)(6916009)(76116006)(8676002)(66946007)(91956017)(66556008)(66446008)(64756008)(4326008)(66476007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ckZCd0hySUNHWEhUcEhlbkkzUVdMamtYMm9FVU12eHo0VC9QM3hFRkM3RGxW?=
 =?utf-8?B?S2hjUE13aSt1dWp6WldUQlFBQ0wwV2NJTHlFdTFjYkNtejBrRWJZSGdTU1hF?=
 =?utf-8?B?c2swSUYwdlhmaFc4U29IZ1J4M1lianJWbmNLWlJYcFpDeU9KWDYybFE1ZWxr?=
 =?utf-8?B?Vzl4ZmI1dkwrQld2dCtkRExROW90alpXMk9GeUdZeEE3TzZiT0ZLWXpJbGYr?=
 =?utf-8?B?ZEZTWWMrZERCR2FSMjV2RDQ3Z24vUTMyWWRESjYzbisvalk0eUhnU2hmWlk2?=
 =?utf-8?B?dFFOaFR1cVVHdEQ0eEVHZjFLalFMaUI0a0MyVTdndGFCbUl3STFUV3QrUVRt?=
 =?utf-8?B?enkvUDJ2MXhWMWNxZ09xczIrRVV0S2hXNUxSdWY1KzBQaTh6K1FzNmtneS9p?=
 =?utf-8?B?NnU4U1F4K1FlSUFvaHMrR3BZUCtVWlRTV0x6N21LdWhnOFYxdVRtNUc2MzBP?=
 =?utf-8?B?ckJWaC9uZGJoL2NPZ2k0eThYcTJuWGJoNjFPUjR1NG1xRzh6elJKaytwMFlo?=
 =?utf-8?B?c25qeHIvZ2J3RENVY2tHbVpuY1JaQWNsSzROZjNsaExZcFh1TlBUekR4VTRz?=
 =?utf-8?B?L21aRS90OUxoRDQxdG96YkIxRHBlQ1RMZTRSWVFEVCt5Vm9lcGpmTkRsZEdZ?=
 =?utf-8?B?UkQ1TGhLZXhjdFo3bjY0U2lKWE5XQUZDcVF6dnpSanM4N3QrQjB5UHhHMmVK?=
 =?utf-8?B?MS9Xa2dMUS9PZVcxSzBITCtIdnpmbUN2YkhJb3gvdGJkbmxNNGtOOXhVWEFH?=
 =?utf-8?B?QlErM2kwQXM0N3RMQjZWRHFRYVVRSjJJc1JHd1JzNlE2VjAyQlRqekczUWFT?=
 =?utf-8?B?cXdKOWJRMVdzcE9ObEphTVN1b1RCUkx1MzdXMXBjdGQyMjJIMVZseWZhUG5o?=
 =?utf-8?B?ZiszQVJXQ0JDNmtkZWxzeXV5QmdHRFZMc200YU1Kdy9ONU1SeFpad21EL0lU?=
 =?utf-8?B?QlhXU0lEL2NoOEsvc2xGSm9MM2ZUUXM4V293bnJPY3c2RkdzVGlHa0o4eGg1?=
 =?utf-8?B?bUN6dUorNWF3c3BJaFgyR1FoSEpiWThJYkZNZTFjY09IOVFSUFU4YVZBQ2NV?=
 =?utf-8?B?cjRSRzBrSHlUajdtQnp4NHBoUGkwRVZRWjhkckwxSkNTNG5pbDFFRHkwRGd1?=
 =?utf-8?B?RjdOUUNIbHpOYjFNOGVnRmgvZ0w1b25WRDQrTklacGdkemx3U3Vqc3J5TEdy?=
 =?utf-8?B?SWtURjJkczVNKzVSd1dOdTVDd09sSGNOY251NlZPNmZIdk15RlBlejAvQXNS?=
 =?utf-8?B?QkRXSkxUUGhRK0pwTCtYZytxTnBUSE9ZTUFDaGFlcC95T1J5czd4VFdsaE1H?=
 =?utf-8?B?QXBwSDYyWlQ0T3BZdjZPQjFEUzVwUWJjRTZuUitaRmpQbjF6NVBjRHU5NnJ5?=
 =?utf-8?B?MmhkWWdPSXVxc0crRXhFRy9GOWFidCt3a3FnQmV4ckJXd0ZlaE1nNkxNcVhx?=
 =?utf-8?B?V0pEVm1EclVncFAzU0dtY0o4M2xwbk8vaHhYc3pFdXpyZU5weEI1OFM5Qmhz?=
 =?utf-8?B?ZHRjbnk4UElhTk5UNGVYbzBUaWxmRUxaZVNIaThsVE9adlhQbzNXT3cwOXBj?=
 =?utf-8?B?UUZEQ2RPUTJIZ1c4TXJLVWxCUktGeVhZaXQ4SmJnOEYvWmVPM0liUHZGQWRI?=
 =?utf-8?B?YnBuMkVtWVQxTjZubFo1U1B0Uk12d3RpUHgyTGhHODFkbnJJYmhETnRRZE9E?=
 =?utf-8?B?KzFOdFNnWkYzbUhNTnREMGZNVGZkakNHbUZDeUJEUzduK0llMUFQTVQ0aHpx?=
 =?utf-8?B?UXNaQUJESTZXVkNMYjNWQWdYWUJYZkp0RWdoL1JTVmxyNEwzQldvRHAyaXNF?=
 =?utf-8?B?ZW96L0IxSWpqNzFGeHorT3FldUZ4M3dpOE1wZGZELzJGSXJMbXF0YTB6N3p0?=
 =?utf-8?B?VHhvcXYzOGs4TkVaVVNmSTBjNzNkSkJ4Mjh0c3lFNk9SOWpvUTY2czZDMnZ2?=
 =?utf-8?B?NkUxR015Ynh4cEJaNzdOVVI4aWNNaTdVbWVwQXpyc1VnUEZvcWRjY3J1dUsz?=
 =?utf-8?B?dGZzVmxycXJvWHNTWVo4ZENNRW1pd29mUW5ScWwrTDNsc3pEMG8rQWpuN2o1?=
 =?utf-8?B?QkR5USt5eUJLZWFsN0ZCQllxNjZTWkxmYlNyZk1WS2RjOHBDU01Gb2o2QTE4?=
 =?utf-8?B?TXluMDJkMDFWOWVMZElKcXlQNDAxa25KcllhUmNLV3NJb1pZT0JKajU2cjI4?=
 =?utf-8?B?dXhBMzRNUzlFT0hIblFZMU1jUms3WjAwWXh2VXVNdUhiY3NNM2p2SjdKbXhN?=
 =?utf-8?B?U1ZudEpNeXV2VEo1RWo3M2p0VHRRcHIxaHJ0TmpvQ2dmTFpnVmxtRWwwM3RQ?=
 =?utf-8?B?VzMzQ3FsUmNaWjRaRmFlcjlMNUpqYW1aUHNxb2NHNTdzS1JJU01MRjdhd2pi?=
 =?utf-8?Q?QwtVZ434rvt5j30U=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <7837DE061AB4D940BE7CFE83DA6717F7@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA2PR11MB4874.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0091835c-8ba2-4f33-29ff-08da21fd4537
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Apr 2022 12:08:09.7876
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vMNkip/2OIgBCK0w6U5Cxr+kmTArxAw5ecvjTODF5orjmEDoa+hJJrl9BsSWK8gfDYVoH9OyPAMHMDPDzeKbYF7kUzhg5cCfEWpCxUjIy5Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR11MB3392
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gNC8xOS8yMiAxNDo0NiwgTWljaGFlbCBXYWxsZSB3cm90ZToNCj4gRVhURVJOQUwgRU1BSUw6
IERvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVubGVzcyB5b3Uga25vdyB0
aGUgY29udGVudCBpcyBzYWZlDQo+IA0KPiBBbSAyMDIyLTA0LTE5IDEzOjE5LCBzY2hyaWViIE1p
Y2hhZWwgV2FsbGU6DQo+PiBBbSAyMDIyLTA0LTExIDExOjEwLCBzY2hyaWViIFR1ZG9yIEFtYmFy
dXM6DQo+Pj4gVGhlcmUgYXJlIG1hbnVmYWN0dXJlcnMgdGhhdCB1c2UgcmVnaXN0ZXJzIGluZGV4
ZWQgYnkgYWRkcmVzcy4gU29tZSBvZg0KPj4+IHRoZW0gc3VwcG9ydCAicmVhZC93cml0ZSBhbnkg
cmVnaXN0ZXIiIG9wY29kZXMuIFByb3ZpZGUgY29yZSBtZXRob2RzDQo+Pj4gdGhhdA0KPj4+IGNh
biBiZSB1c2VkIGJ5IGFsbCBtYW51ZmFjdHVyZXJzLiBTUEkgTk9SIGNvbnRyb2xsZXIgb3BzIGFy
ZQ0KPj4+IGludGVudGlvbmFsbHkNCj4+PiBub3Qgc3VwcG9ydGVkIGFzIHdlIGludGVuZCB0byBt
b3ZlIGFsbCB0aGUgU1BJIE5PUiBjb250cm9sbGVyIGRyaXZlcnMNCj4+PiB1bmRlciB0aGUgU1BJ
IHN1YnN5c3RlbS4NCj4+Pg0KPj4+IFNpZ25lZC1vZmYtYnk6IFR1ZG9yIEFtYmFydXMgPHR1ZG9y
LmFtYmFydXNAbWljcm9jaGlwLmNvbT4NCj4+PiBUZXN0ZWQtYnk6IFRha2FoaXJvIEt1d2FubyA8
VGFrYWhpcm8uS3V3YW5vQGluZmluZW9uLmNvbT4NCj4+PiBSZXZpZXdlZC1ieTogUHJhdHl1c2gg
WWFkYXYgPHAueWFkYXZAdGkuY29tPg0KPj4NCj4+IEkgc3RpbGwgZG9uJ3QgbGlrZSBpdCBiZWNh
dXNlIHRoZSBmdW5jdGlvbiBkb2Vzbid0IGRvDQo+PiBhbnl0aGluZyB3aGF0IHRoZSBmdW5jdGlv
biBuYW1lIG1pZ2h0IHN1Z2dlc3QuIFRoZSByZWFkDQo+PiBqdXN0IGV4ZWN1dGVzIGFuIG9wLCB0
aGUgd3JpdGUgZXhlY3V0ZXMgYW4gb3Agd2l0aCBhDQo+PiB3cml0ZSBlbmFibGUgYmVmb3JlLiBB
bGwgdGhlIGJlaGF2aW9yIGlzIGRldGVybWluZWQgYnkgdGhlDQo+PiAnb3AnIGFyZ3VtZW50Lg0K
Pj4NCj4+IEFueXdheSwNCj4+IFJldmlld2VkLWJ5OiBNaWNoYWVsIFdhbGxlIDxtaWNoYWVsQHdh
bGxlLmNjPg0KPj4NCj4+PiAtLS0NCj4+PiB2Mzogbm8gY2hhbmdlcw0KPj4+DQo+Pj4gwqBkcml2
ZXJzL210ZC9zcGktbm9yL2NvcmUuYyB8IDQxDQo+Pj4gKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysNCj4+PiDCoGRyaXZlcnMvbXRkL3NwaS1ub3IvY29yZS5oIHzCoCA0ICsr
KysNCj4+PiDCoDIgZmlsZXMgY2hhbmdlZCwgNDUgaW5zZXJ0aW9ucygrKQ0KPj4+DQo+Pj4gZGlm
ZiAtLWdpdCBhL2RyaXZlcnMvbXRkL3NwaS1ub3IvY29yZS5jIGIvZHJpdmVycy9tdGQvc3BpLW5v
ci9jb3JlLmMNCj4+PiBpbmRleCA2MTY1ZGM3YmZkMTcuLjQyNzk0MzI4ZDNiNiAxMDA2NDQNCj4+
PiAtLS0gYS9kcml2ZXJzL210ZC9zcGktbm9yL2NvcmUuYw0KPj4+ICsrKyBiL2RyaXZlcnMvbXRk
L3NwaS1ub3IvY29yZS5jDQo+Pj4gQEAgLTMwNyw2ICszMDcsNDcgQEAgc3NpemVfdCBzcGlfbm9y
X3dyaXRlX2RhdGEoc3RydWN0IHNwaV9ub3IgKm5vciwNCj4+PiBsb2ZmX3QgdG8sIHNpemVfdCBs
ZW4sDQo+Pj4gwqDCoMKgwqAgcmV0dXJuIG5vci0+Y29udHJvbGxlcl9vcHMtPndyaXRlKG5vciwg
dG8sIGxlbiwgYnVmKTsNCj4+PiDCoH0NCj4+Pg0KPj4+ICsvKioNCj4+PiArICogc3BpX25vcl9y
ZWFkX3JlZygpIC0gcmVhZCByZWdpc3RlciB0byBmbGFzaCBtZW1vcnkNCj4+PiArICogQG5vcjrC
oMKgwqDCoMKgwqDCoCBwb2ludGVyIHRvICdzdHJ1Y3Qgc3BpX25vcicuDQo+Pj4gKyAqIEBvcDrC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgU1BJIG1lbW9yeSBvcGVyYXRpb24uIG9wLT5kYXRhLmJ1
ZiBtdXN0IGJlIERNQS1hYmxlLg0KPj4+ICsgKiBAcHJvdG86wqAgU1BJIHByb3RvY29sIHRvIHVz
ZSBmb3IgdGhlIHJlZ2lzdGVyIG9wZXJhdGlvbi4NCj4+PiArICoNCj4+PiArICogUmV0dXJuOiB6
ZXJvIG9uIHN1Y2Nlc3MsIC1lcnJubyBvdGhlcndpc2UNCj4+PiArICovDQo+Pj4gK2ludCBzcGlf
bm9yX3JlYWRfcmVnKHN0cnVjdCBzcGlfbm9yICpub3IsIHN0cnVjdCBzcGlfbWVtX29wICpvcCwN
Cj4+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgZW51bSBzcGlfbm9yX3Byb3Rv
Y29sIHByb3RvKQ0KPj4+ICt7DQo+Pj4gK8KgwqDCoCBpZiAoIW5vci0+c3BpbWVtKQ0KPj4+ICvC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgIHJldHVybiAtRU9QTk9UU1VQUDsNCj4+PiArDQo+Pj4gK8Kg
wqDCoCBzcGlfbm9yX3NwaW1lbV9zZXR1cF9vcChub3IsIG9wLCBwcm90byk7DQo+Pj4gK8KgwqDC
oCByZXR1cm4gc3BpX25vcl9zcGltZW1fZXhlY19vcChub3IsIG9wKTsNCj4+PiArfQ0KPj4+ICsN
Cj4+PiArLyoqDQo+Pj4gKyAqIHNwaV9ub3Jfd3JpdGVfcmVnKCkgLSB3cml0ZSByZWdpc3RlciB0
byBmbGFzaCBtZW1vcnkNCj4+PiArICogQG5vcjrCoMKgwqDCoMKgwqDCoCBwb2ludGVyIHRvICdz
dHJ1Y3Qgc3BpX25vcicNCj4+PiArICogQG9wOsKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBTUEkg
bWVtb3J5IG9wZXJhdGlvbi4gb3AtPmRhdGEuYnVmIG11c3QgYmUgRE1BLWFibGUuDQo+Pj4gKyAq
IEBwcm90bzrCoCBTUEkgcHJvdG9jb2wgdG8gdXNlIGZvciB0aGUgcmVnaXN0ZXIgb3BlcmF0aW9u
Lg0KPj4+ICsgKg0KPj4+ICsgKiBSZXR1cm46IHplcm8gb24gc3VjY2VzcywgLWVycm5vIG90aGVy
d2lzZQ0KPj4+ICsgKi8NCj4+PiAraW50IHNwaV9ub3Jfd3JpdGVfcmVnKHN0cnVjdCBzcGlfbm9y
ICpub3IsIHN0cnVjdCBzcGlfbWVtX29wICpvcCwNCj4+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoCBlbnVtIHNwaV9ub3JfcHJvdG9jb2wgcHJvdG8pDQo+Pj4gK3sNCj4+PiAr
wqDCoMKgIGludCByZXQ7DQo+Pj4gKw0KPj4+ICvCoMKgwqAgaWYgKCFub3ItPnNwaW1lbSkNCj4+
PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCByZXR1cm4gLUVPUE5PVFNVUFA7DQo+Pj4gKw0KPj4+
ICvCoMKgwqAgcmV0ID0gc3BpX25vcl93cml0ZV9lbmFibGUobm9yKTsNCj4+PiArwqDCoMKgIGlm
IChyZXQpDQo+Pj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqAgcmV0dXJuIHJldDsNCj4+PiArwqDC
oMKgIHNwaV9ub3Jfc3BpbWVtX3NldHVwX29wKG5vciwgb3AsIHByb3RvKTsNCj4+PiArwqDCoMKg
IHJldHVybiBzcGlfbm9yX3NwaW1lbV9leGVjX29wKG5vciwgb3ApOw0KPiANCj4gQWZ0ZXIgc2Vl
aW5nIHlvdXIgbmV4dCB0d28gcGF0Y2hlcy4gU2hvdWxkbid0IHRoZQ0KPiBzcGlfbm9yX3dhaXRf
dW50aWxfcmVhZHkoKSBjYWxsIGJlIGhlcmUgdG9vPw0KPiANCg0KSSB0aG91Z2h0IG9mIHRoaXMg
dG9vLCBidXQgc2VlbXMgdGhhdCBmb3IgYSByZWFzb24gdGhhdCBJIGRvbid0DQpyZW1lbWJlciwg
d2UgZG9uJ3QgY2FsbCBmb3Igc3BpX25vcl93YWl0X3VudGlsX3JlYWR5IGFmdGVyIHdlDQp3cml0
ZSB0aGUgb2N0YWwgRFRSIGJpdC4gUHJhdHl1c2gsIGRvIHlvdSByZW1lbWJlciB3aHk/DQoNClRo
YW5rcywNCnRhDQo=
