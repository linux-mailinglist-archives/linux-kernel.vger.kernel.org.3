Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52A864C34C1
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 19:27:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230366AbiBXS1g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 13:27:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232869AbiBXS1a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 13:27:30 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23F6B8D69E;
        Thu, 24 Feb 2022 10:26:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1645727219; x=1677263219;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=FtVPEu9K3zDch+HaNYmmK1bDFsnb7UYCxwKziwazssg=;
  b=q6GeYPPyE1j9GjId14ZbDRPx5oJplubHV1aK+nsQ0KihbfEKP8LOLY+v
   O41h7rmb16w/FKQVincDbiWLqnC/+p/58E9i2UGu5gUT8W6DUE1JP2ffh
   F7WjY/Jz/qKRiAGZSaqLL+OPYfsEqp0KfwaQh5nZJ46IF8ZV1pZIR+OkB
   TUnpAJxROpocxv+rFP1ruQ/EAyTR8ywVJu33GSY13Owqcvo8bGriORMmH
   +KD1VkXgncAA07jc/7M4rHN3MsmXDLbz0BqQkOpPC4gEdDO4CYm6KOu11
   XqHLblNHy+JQ9GD/f1OdCbXQaN3R3futtIomplF5joF95fRusitBfy6Y7
   w==;
X-IronPort-AV: E=Sophos;i="5.90,134,1643698800"; 
   d="scan'208";a="163540782"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 24 Feb 2022 11:26:58 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Thu, 24 Feb 2022 11:26:58 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17 via Frontend Transport; Thu, 24 Feb 2022 11:26:58 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oFIYlloXpAdlVUuXOf3XRDJNMqk7ohhZF+XqDmClIvvA7lTw2yObUp5SqffEZRFtqUoAVWaoWA1TqUSini1ec+UWAC1GfKLkGSuaExBjfn3PMCfzo94TkV7Rc1v2/qCFwcz9cjuAxtZ8DVEBQ3BmrqKOSGrb99rwyQ4lCMIfBKhvxklurAgYMQ0dlFAdfweGlWzmKXbHaECcCcHG2AYCZ196wO9gT0KUuPay/cTGOfjJcK+szNofVfx2nQcOfuk+hcec9ikwMy3qZp19UhEo6B4c02A6E747Is+/O1Mm0BL2WKSxkGLOAShNqCMHOFIR7ZGYr4pr37Y7MpBTVS8dbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FtVPEu9K3zDch+HaNYmmK1bDFsnb7UYCxwKziwazssg=;
 b=W5b91PXqiUIjrwtsREbZegasr5yiHf1hAfiX1Gd5cW2p55PG0+TWz4Dyj4wRXhklIHJ5+HdAFmH6D22UJ/GO0Rh0EVw9YlNF/zS4YuyihFuT+30VNNLObi+uMtXndSZxirUlCnfau4zw4a11lvrjXyfj6ucxMYIRvKuU0YW8dZf2Ig+RW2j7Tqp3jr+Dyy8VNAU8BMDBT0t76LXTZbTBmGoqvBMFxMRwhm6ogqMurjVgJBRdzUeKHgk09XpuwPnsGg0Tig1ImDeAJFGWaolOdR5tdK0RoF8wfgs4eYVV8l1fiAN/z0bd/Oer6HoLc5WaoZIJ58ccPqaY6Y9eRaKY2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FtVPEu9K3zDch+HaNYmmK1bDFsnb7UYCxwKziwazssg=;
 b=C2uP2TtnIkVMw6Ec0MMKaPfFiZaiojemE+T2uC8B1Izp8o0oFXJP3Z1l1HCoz0bjSxAx4C3Ar5xnhRKPVr0TbRXfPcrLPXp1wN/+wX7AaPVimN5kHUFGjHMk/sdrrtBHtA3WnKDtyxU6Ei4rT6qQrmd2RToT8a6oGu96l/BSHWs=
Received: from SA2PR11MB4874.namprd11.prod.outlook.com (2603:10b6:806:f9::23)
 by MWHPR1101MB2238.namprd11.prod.outlook.com (2603:10b6:301:55::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.22; Thu, 24 Feb
 2022 18:26:53 +0000
Received: from SA2PR11MB4874.namprd11.prod.outlook.com
 ([fe80::dc94:3c7c:8ef8:21b9]) by SA2PR11MB4874.namprd11.prod.outlook.com
 ([fe80::dc94:3c7c:8ef8:21b9%5]) with mapi id 15.20.5017.025; Thu, 24 Feb 2022
 18:26:53 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <Nicolas.Ferre@microchip.com>
CC:     <alexandre.belloni@bootlin.com>, <Ludovic.Desroches@microchip.com>,
        <robh+dt@kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ARM: dts: at91: sama7g5: Add NAND support
Thread-Topic: [PATCH] ARM: dts: at91: sama7g5: Add NAND support
Thread-Index: AQHYKZYciQeyVqGwYkuYkv2qjFZj+Q==
Date:   Thu, 24 Feb 2022 18:26:53 +0000
Message-ID: <647e801b-88d3-6169-0354-ba1cdff8d807@microchip.com>
References: <20220111130556.905978-1-tudor.ambarus@microchip.com>
 <2fa34fae-7736-670a-1d31-7928fbcf95bd@microchip.com>
 <c708f761-aad4-a2f2-9255-01bcb6ad73de@microchip.com>
 <3cd1fd6b-d3a4-5ac5-22fa-c854e2f25a65@microchip.com>
In-Reply-To: <3cd1fd6b-d3a4-5ac5-22fa-c854e2f25a65@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 430bb244-d840-4451-92a7-08d9f7c33b5d
x-ms-traffictypediagnostic: MWHPR1101MB2238:EE_
x-microsoft-antispam-prvs: <MWHPR1101MB22384A38A6EC3F712229C853F03D9@MWHPR1101MB2238.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Jq+qifBrJmBECHBEQFbUnz5zlLB0XOrghSlkJA2aYAVcMtxh20hvzUY/d43w3K5OUWp8IuU3U3ykm9wq50k0a+Ypwm57wcmLCB8gyaytlXcJpZJqSmvfCb1pP8i8JeyfEXaOJ0mtO28dhr96b4/hvkQcuGqn+uQoIWSeZIwV+7DDT/mVUtHKKYj/DxwymH3IZtdzKSQruWqBuKfPkTF0sUxp/0l9Y+2PXMArBueGRjzJbSyBN3IoL8SwfvBV4WXxlSKlmiGN3jVFVgJwZRaP9XtJCQlMyU4/IT5TfOTXwcJmzkTDHuNaqjmcRwNulzKszCmoVmZ0HyOr7BIXV4wDv1Oklcd2NW3yr3I7HZTO+p87SbURWR24BzOEW4ani8Iif1nGj4WM1SzEu2wn7R5skuhh5T08j8ODNP0YtANhotVQQPGLGeZCKfqqPpz5uOJHx+3ACXUSuGgKeaH9sORCLtqeeT+TwsPkrR1CM6PGcn5nzxVxc2V3CJfED74mKVF7tzF+DUeyNs2ixBpdl6vso3uJq1aqMnHui3xVeoWvdQ8xFvFuhUada/fj4olTlJb2y1RypQ03I+wmfQ7k3uM2mRE8yh4Av0DFREtclgCKlju8ejWaJbB0HPGfj7omyEU1uPD3lO7j33jgTBbQPu60qjqBnvf7aP+SyJ0Rgfxzr27FXZgZGwNj1JgluyIpHDGj60Bt/rXY4P4P0YhrA8CnUU+8oDbBqEW4dpBPXP3I//x8EtzDnM2VFxKW8sc2IKx6FoupKT8+U68oqBMAfHGqAkF+ONlSCMP8A6F9LDnqrcCxcIQp2C228Xq3uxqnaucIT001mNJb6GM8LXvoZKTZ5jzWRhAK5AVck3JaijMks04=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA2PR11MB4874.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(2906002)(8936002)(6512007)(6506007)(53546011)(38070700005)(54906003)(37006003)(71200400001)(508600001)(91956017)(316002)(6636002)(66946007)(6486002)(8676002)(966005)(66556008)(64756008)(66446008)(66476007)(76116006)(6862004)(4326008)(5660300002)(186003)(31686004)(38100700002)(2616005)(26005)(36756003)(122000001)(86362001)(31696002)(83380400001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bFN5dFB5MW1zTVVOczlyWlFTZUFkVHRkOFhkRTRWUnpxUnF2cFI5TzA5Vm8w?=
 =?utf-8?B?SlVLUS9MSkp3RXlxT3ZNRWp0eDlNd1J1NVM1TkIxRWlIZUFzSURPMjR5Smk5?=
 =?utf-8?B?ZUFqcmZPaVg1eUl1d1AxQUVxbUJOa21XMzY0Z1FjTnNIVEcyNmxycXZ1ZERi?=
 =?utf-8?B?Qmh4NGdFMjZEOGdkM2h3QWdMdkJFTFpOVStSaUI2NHgxbHY4Vi8xWE8yNWFq?=
 =?utf-8?B?ZC94c2RZaXQ3NDR1Wi8wQW9PNlJpSUxBbiswc0ZMSjVhdzI3eE9SQnp3bi92?=
 =?utf-8?B?QVYwaDQvNGpydldCaUQzSUt0aUgvK3QrRVZxbGVScUs1NzRPdGtPZll6M3lw?=
 =?utf-8?B?aXBJbWphUlc1bUJjRVNGbVJMNFpvU2puSzZVVkhnRVk1TzcwQi8vUC9uNjFo?=
 =?utf-8?B?Y3N0b2ZneXFZZ0NDZlZueGZiN3Q1TkdDT2NnVEY2aWNhMVh2aGt3Vm9XdUVj?=
 =?utf-8?B?azg1eHYrNFNIVERYcmFrY0t4RkxEcmNBV1BBTUdOb2xvL1VtbTNiZUZUZVJ5?=
 =?utf-8?B?M0lJOWZqUWpEYm5LaStNUTQyYzUzWkYzZDhadGlPSHA4ak5Dc1hWak9URDFJ?=
 =?utf-8?B?TDdwSzNnaFJlQ01IMWNsUVc3VnR3Vm12UFhlVVFtVExweDVvTlF4VWt4WUFZ?=
 =?utf-8?B?Uzhna25MQm5IR1p0QmxhcFpSeVp2SUIrYXl3NHhvdHJ1MXhjay9SMENIZlAv?=
 =?utf-8?B?enhNM29RR01FSGNpS05UTEY4VjhrL2d6aXpYVlovTGNKWmNvdVFWcWs1TU90?=
 =?utf-8?B?ZUdXdGJPNHo0RVAyK1ZCVmhteC9mdkxTNTA5TEl1aWx2dER1RGN5b1RXVnp0?=
 =?utf-8?B?NUdRcE9BMURDV0Y5c2dKa2NWNHJYYlpXaFVrbXloSXdPemhyZ2ZaM2lEbE51?=
 =?utf-8?B?WCtwZUl4RTdxZ2Fuc2V3dVhGUlFtUVFDVGJDYXFkbytpWXhTeXJ4Z0t0Y0xi?=
 =?utf-8?B?MjNDVFcwZ21mbTJPYnJCK280bzJJeDFwRjFCK1FXQzg1ajd2SzZEL2pMb1gw?=
 =?utf-8?B?RTIyTUdRRmNkaStkUTU5YUI5TnFLYk9FSDIzVW9ZOHI0QXR0QThSVk9hbU8r?=
 =?utf-8?B?alBqREM1SkY0TThXRzUrSGhUV1B6VFBDZ0pPYjVaV01Ha29FT2lrUldXRWhJ?=
 =?utf-8?B?Ni9JY24rMmh1WDJMSGpnNUU0S3ZPaWZEVHkzaEUwVjZjTEpmZE1QVEwyYmNV?=
 =?utf-8?B?WG1FK0RJeHhEK2lRdFk2djVIYjF0NW50Uzk2bDVtNDJaM2ZWdEhxcjF3RUdY?=
 =?utf-8?B?TGV3NzZ5eDRWM0x2cC95elB5cGtHMmcrUDRIQmNGZTY5aS8za0Y0aG5jZ2VB?=
 =?utf-8?B?dEJtVlB6bU5RdVVjOXlFdEtXUWUrd3JCNFlMMkhHeURGRHJoZmpGTjJOdkNq?=
 =?utf-8?B?NXBFSCtpMFdIWThIcmx6QUhPV3M1ZHYrQ05DVFJ2YlpGUE9RaXB1azIzYWo1?=
 =?utf-8?B?NXNWMlFuYVU1aUtUc1VaUVl3WU1Ja01EZTA1QjQ1WnNrdjR5ZnhINnQ2VWNr?=
 =?utf-8?B?MG5mL0hWUVh2TmxjL0pST2doZ2poczQxNHFidCs2NGlWaWozbUlLbjAwSUI0?=
 =?utf-8?B?YXZxb3dsSmVnTkJId3NYdTRFUkhpaWZWajFKQmtlWTJuZDBNVklEU2RmS1d3?=
 =?utf-8?B?aTNRZ1M5NXRnSHJ6NVh3dGMwc0VUSk5tYXJmV2ZPazJ2cHhQcm4xVGU1R2Zs?=
 =?utf-8?B?U01PK3k5d20vbmY4NytsT0RoWkxTdHpDeFFnM2JqTGZ6V2N5QVV1NUxMbXBD?=
 =?utf-8?B?bGxPVVdLVkRjdS9qZTByeEhwczA5Tm1KSm9nRUl3Si9LdWY1UlNtQXFJRHk4?=
 =?utf-8?B?blN2S3VsNTFCak1aeEYvV2pydXY4UFN0c1N1WEhIeXNBOG15ZkJSZHV3WVVw?=
 =?utf-8?B?ZVhpR0V5cVhLSVNCeEo3M2ZvZWhwRTRJY3ZWY0dRcXFoUU9ZblBLUDdjY3Js?=
 =?utf-8?B?eXk0MGFlM3paWGJUc2FrWnFoOVU1K3pPQ0FHemJsLzVVVG1oWldOQXhCM0cw?=
 =?utf-8?B?QTd2aExpUjFCY1hHL1BuTjNQdVB4eVBxT2YyMXFCNlZxdG9DdEtOV2tVZ2s0?=
 =?utf-8?B?WERkUTdvOEJSREdrOUpyazNGQmhWV2swTGNXNW9SNktNZ2pJaUliZFFVRnMx?=
 =?utf-8?B?R1hyUGtRbzQ2cHJQOG1nV1plOWw5T1VUOWlDY2VZTE12Sk9Rb280WkJ3cFUr?=
 =?utf-8?B?RE9vcVZGM2dwNGlqOFN5M0QzdlFEciswQkU4SXNNS3VGSzJreUM1ZEt5NVly?=
 =?utf-8?B?YnlpUldYVUtqY1hlaEZhVkVBTkx3PT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C6CFC30C75DB9347AB63DCA7E2430720@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA2PR11MB4874.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 430bb244-d840-4451-92a7-08d9f7c33b5d
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Feb 2022 18:26:53.5213
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kGlyEgkjEeFk9jDPYc+6bnVf4ngxCYkRIuXJVTGiZaHqGZresGPXdY4OgceNeoq/JRNCWZUONsxXFsC0W6UlRi3g8R6k/ZCb3674wthCpxE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1101MB2238
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,T_SCC_BODY_TEXT_LINE,T_SPF_PERMERROR autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMi8yNC8yMiAxOTo0NCwgTmljb2xhcyBGZXJyZSB3cm90ZToNCj4gSGkgVHVkb3IsDQoNCkhp
LA0KDQo+IA0KPiBPbiAyNC8wMi8yMDIyIGF0IDE2OjQ5LCBUdWRvciBBbWJhcnVzIC0gTTE4MDY0
IHdyb3RlOg0KPj4gT24gMi8yNC8yMiAxNzowNCwgTmljb2xhcyBGZXJyZSB3cm90ZToNCj4+PiBP
biAxMS8wMS8yMDIyIGF0IDE0OjA1LCBUdWRvciBBbWJhcnVzIHdyb3RlOg0KPj4+PiBBZGQgTkFO
RCBzdXBwb3J0LiBUaGUgc2FtYTdnNSdzIFNNQyBJUCBpcyB0aGUgc2FtZSBhcyBzYW1hNWQyJ3Mg
d2l0aA0KPj4+PiBhIHNsaWdodGx5IGNoYW5nZTogaXQgcHJvdmlkZXMgYSBzeW5jaHJvbm91cyBj
bG9jayBvdXRwdXQgKFNNQyBjbG9jaykNCj4+Pj4gdGhhdCBpcyBkZWRpY2F0ZWQgdG8gRlBHQSB1
c2FnZS4gU2luY2UgdGhpcyBkb2Vzbid0IGludGVyZmVyZSB3aXRoIHRoZSBTTUMNCj4+Pj4gTkFO
RCBjb25maWd1cmF0aW9uLCB0aHVzIGNvZGUgd2lsbCBub3QgYmUgYWRkZWQgaW4gdGhlIGN1cnJl
bnQgbmFuZCBkcml2ZXINCj4+Pj4gdG8gYWRkcmVzcyB0aGUgRlBHQSB1c2FnZSwgdXNlIHRoZSBz
YW1hNWQyJ3MgY29tcGF0aWJsZSBhbmQgY2hvb3NlIG5vdCB0bw0KPj4+PiBpbnRyb2R1Y2UgZGVk
aWNhdGVkIGNvbXBhdGlibGVzIGZvciBzYW1hN2c1Lg0KPj4+PiBUZXN0ZWQgd2l0aCBNaWNyb24g
TVQyOUY0RzA4QUJBRUFXUCBOQU5EIGZsYXNoLg0KPj4+Pg0KPj4+PiBTaWduZWQtb2ZmLWJ5OiBU
dWRvciBBbWJhcnVzIDx0dWRvci5hbWJhcnVzQG1pY3JvY2hpcC5jb20+DQo+Pj4NCj4+PiBBY2tl
ZC1ieTogTmljb2xhcyBGZXJyZSA8bmljb2xhcy5mZXJyZUBtaWNyb2NoaXAuY29tPg0KPj4+DQo+
Pj4+IC0tLQ0KPj4+PiBUaGUgcGF0Y2ggZGVwZW5kcyBvbiB0aGUgZm9sbG93aW5nIHBhdGNoOg0K
Pj4+PiBodHRwczovL2xvcmUua2VybmVsLm9yZy9saW51eC1jbGsvMjAyMjAxMTExMjUzMTAuOTAy
ODU2LTEtdHVkb3IuYW1iYXJ1c0BtaWNyb2NoaXAuY29tL1QvI3UNCj4+Pg0KPj4+IFBhdGNoIHNl
ZW1zIHRha2VuLCBzbyBJIGFkZCB0aGlzIG9uZSB0byBhdDkxLWR0IGJyYW5jaCBmb3IgNS4xOCBt
ZXJnZSB3aW5kb3cuDQo+Pj4NCj4+DQo+PiBJIHRoaW5rIGl0IGRlcGVuZHMgb24gd2hvIGdldHMg
dG8gbmV4dCBmaXJzdC4gSWYgYXQ5MSBnZXRzIGJlZm9yZSBjbGssDQo+PiB0aGVyZSB3aWxsIGJl
IGEgYnVpbGQgZXJyb3IsIGlzbid0IGl0Pw0KPiANCg0KU29ycnksIG5vdCBsaW51eC1uZXh0LCBi
dXQgd2hvc2UgUFIgZ2V0cyBmaXJzdCBhcHBsaWVkIGJ5IExpbnVzLg0KDQo+IENsayBwYXRjaCBp
cyBhbHJlYWR5IGluIGxpbnV4LW5leHQsIHNvIG5vIHdvcnJpZXMuDQo+IE1vcmVvdmVyLCBJIGRv
bid0IGdldCB3aHkgdGhlcmUgY291bGQgYmUgYSBidWlsZCBlcnJvciBhcyB0aGVyZSBpcyBubyBi
dWlsZCBkZXBlbmRlbmN5IGJldHdlZW4gRFQgY2hhbmdlcyBhbmQgQyBjaGFuZ2VzLg0KPiBTb3Jy
eSBidXQgSSdtIHB1enpsZWQuLi4gT3IgSSdtIG5vdCBsb29raW5nIGF0IHRoZSByaWdodCBwYXRj
aC4NCj4gDQoNCllvdSB3b3VsZCBzZWUgdGhpcyBraW5kIG9mIGVycm9yOg0KRXJyb3I6IGFyY2gv
YXJtL2Jvb3QvZHRzL3NhbWE3ZzUuZHRzaToxMDIuMjEtMjIgc3ludGF4IGVycm9yDQpGQVRBTCBF
UlJPUjogVW5hYmxlIHRvIHBhcnNlIGlucHV0IHRyZWUNCm1ha2VbMV06ICoqKiBbc2NyaXB0cy9N
YWtlZmlsZS5saWI6MzQ2OiBhcmNoL2FybS9ib290L2R0cy9hdDkxLXNhbWE3ZzVlay5kdGJdIEVy
cm9yIDENCm1ha2VbMV06ICoqKiBXYWl0aW5nIGZvciB1bmZpbmlzaGVkIGpvYnMuLi4uDQptYWtl
OiAqKiogW01ha2VmaWxlOjEzODU6IGR0YnNdIEVycm9yIDINCm1ha2U6ICoqKiBXYWl0aW5nIGZv
ciB1bmZpbmlzaGVkIGpvYnMuLi4uDQoNClRoaXMgcGF0Y2ggdXNlcyAiUE1DX01DSzEiIHdoaWNo
IGlzIGRlZmluZWQgaW46DQpodHRwczovL2xvcmUua2VybmVsLm9yZy9saW51eC1jbGsvMjAyMjAx
MTExMjUzMTAuOTAyODU2LTEtdHVkb3IuYW1iYXJ1c0BtaWNyb2NoaXAuY29tL1QvI3UNCg0KSWYg
TGludXMgYXBwbGllcyB0aGUgYXJtLXNvYyBQUiBiZWZvcmUgdGhlIGNsayBQUiwgaXQgd2lsbCBz
ZWUgdGhlIHNhbWUgZXJyb3IsIG5vPw0KDQpDaGVlcnMsDQp0YQ0K
