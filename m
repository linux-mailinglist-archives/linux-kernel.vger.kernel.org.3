Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFB934BF2E2
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 08:48:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229562AbiBVHrB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 02:47:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229513AbiBVHq4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 02:46:56 -0500
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2129.outbound.protection.outlook.com [40.107.255.129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B427D4C95
        for <linux-kernel@vger.kernel.org>; Mon, 21 Feb 2022 23:37:31 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Aq19KA0EqM3P/ep33wTAx/Lh66pAap9SXmwtl18cf+729H7Yqu+kDP4DmJtJYMvhbME6cHGV4AiVlT/POUGoVWVZvWUAxPnEwBTytsBBm127ARcDAPfAS+i1nAK68Ifqw/abvA3p2QEpT/QFJjHrWUW7og6mmLu25wX7HKnR922Cj+7vn4m/Fi8o/EfTQM4mABe361O0bYVRQXeWxfyn0IS9r3wnyCDMQw+AgIfj5gmVslIUP7adzwVSFfWjG0EumG+vIulCoG4699eZMEawPX/i81875XZgJwTe8STsyoHDPXwlh6kxhnufB3ATg1JR0u/01XXbgucoHE9ZPEY9JA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lYrkk3hfCjr+jVyaDULVAlu2hkQkkTH47Df7VpGNAS4=;
 b=bCEUZXfZLU2PdUnMAIOanWb6e7tAZGhbV99jcggXApWPsJy8upCh64C1a2k29bF4/uB/+a4Vr+aJNmsrs4bX9/VnwKWMLnYtGvHSEktFF4SAM9usw3T4G1uNjURUlt6r3xTpofWs95KPaX7CMKAaevKT5Xiz2G6JsnXINjVa2TMgMUw8R7nrZ997PvUmTdsB+bp9Itub1NQk9Oos6sNzYtg571v6kTD3g+VbPAJH7qTJQ+Ec8nsM4w02H915khf/HWq80/FTj/vwQaQXaVN165OwZwiUXFzmTgU4BaLsPuSNMfRF8Nr9WbZmReQXvXTRU5+t3OmbGRJ8zD2zYr3/ig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=quantatw.com; dmarc=pass action=none header.from=quantatw.com;
 dkim=pass header.d=quantatw.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=quantacorp.onmicrosoft.com; s=selector2-quantacorp-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lYrkk3hfCjr+jVyaDULVAlu2hkQkkTH47Df7VpGNAS4=;
 b=z4CIEBtXg0RWQd/4bM/XjyDPJ4l6UT2VKvOXGiFH4lcwvA14FVLhzi1G4EKMvWn31MFCRAUCoI0wtx2sdNGz4CefYFzCX3IUf7JE4pas7OVhpqEfTuhx8xXg7dCWTb2Ox9jy1IV+fc8i3FKXdEgWefu1AQ8aeOKLUVg1XdpAzGw=
Received: from HK0PR04MB3282.apcprd04.prod.outlook.com (2603:1096:203:89::17)
 by KL1PR0401MB4115.apcprd04.prod.outlook.com (2603:1096:820:27::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.15; Tue, 22 Feb
 2022 07:37:28 +0000
Received: from HK0PR04MB3282.apcprd04.prod.outlook.com
 ([fe80::ec21:c033:761d:3e03]) by HK0PR04MB3282.apcprd04.prod.outlook.com
 ([fe80::ec21:c033:761d:3e03%4]) with mapi id 15.20.4995.027; Tue, 22 Feb 2022
 07:37:28 +0000
From:   =?utf-8?B?UG90aW4gTGFpICjos7Tmn4/lu7cp?= <Potin.Lai@quantatw.com>
To:     Michael Walle <michael@walle.cc>
CC:     Tudor Ambarus <tudor.ambarus@microchip.com>,
        Pratyush Yadav <p.yadav@ti.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Patrick Williams <patrick@stwcx.xyz>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 1/1] mtd: spi-nor: winbond: Add support for w25q01jv-iq
Thread-Topic: [PATCH v2 1/1] mtd: spi-nor: winbond: Add support for
 w25q01jv-iq
Thread-Index: AQHYJ7dmwG617O6k/U+VTXN6SwZzuqyfKwiAgAADnYA=
Date:   Tue, 22 Feb 2022 07:37:28 +0000
Message-ID: <0b619d9e-4ca0-88ae-69a1-4cb07d2aeea4@quantatw.com>
References: <20220222064227.16724-1-potin.lai@quantatw.com>
 <aedb6f8e3d878f487aa7fef147e352b4@walle.cc>
In-Reply-To: <aedb6f8e3d878f487aa7fef147e352b4@walle.cc>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=quantatw.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 05bca052-899f-486f-83ac-08d9f5d62d75
x-ms-traffictypediagnostic: KL1PR0401MB4115:EE_
x-microsoft-antispam-prvs: <KL1PR0401MB411556191E1BD46C742B63008E3B9@KL1PR0401MB4115.apcprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: oC3RjVg0rFq66ehTunSuZ61A9/xgep2hZ95wrrtx22RCJgyvzmJ1DGXHz8o1J0jBncTMKmfCm1FpP3yqJkgMuxVPTMKBuOFtwBqtZuQN4yo1RZKQLYUZDajhYv0ssf2h7TVi31GjlqxvU3GSsuHWgOSyzSqmb+pbRHRwwtH46SlyblTfEaQbJanaDDjCbfQoIJ26biKOxprI8lAAney/3R5vAWX8WQJ5ERpxWYeVdZfp7Pp/CgsCLBTJnUCvPHyOV4XvPI3GPA7CzdW12eJR/ElhFtddt/3eG2CJnXPe0w7JpIZeGii0ZHUDTFlt79zc/nEKDF4tFWnY9QkREXGLkipE66b20bjDcEC4L8bvNRpflgxN7tKe4xzvMo/OTtoA0B+B1b+bJ/J0fPuSRrtglz2qGCCGXJ+Xhr6bTEEd7T5Je14jnOghXY4JqlaFH3UrGvneZKZVuRr/g4cT3VizK1DRhFJH9bsGkFDW9u2dXbE/QxJ/puBFmrI3jmi55WuQtjMmEqLSkWdQ2vlslzRjLyvUOQGEVEDvUN+VlRN4Xqro6gkOw6ICiNNMobkRSJaJMlEPIDUpDLp3o+Rh4IRrOYn9qVsa9oDhMG+d9ttRvjmOGoO+5YoP3IcABLbPPAULtL8hXNpCm3zed8RnDUGLUqLC+97HMZaR7CSwGf6WneG3A13wO05iMXvhpdNQr+rZ6BJA87KqdwX+YR0Mx1AOhkLNnfUTWv/sEW7lYt9ZotouceCaacowUSwfNmGG+uPN5N5qpISQxh9udN9/QD86GA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HK0PR04MB3282.apcprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(86362001)(6486002)(66476007)(31696002)(66556008)(38100700002)(64756008)(38070700005)(66446008)(122000001)(76116006)(8676002)(66946007)(4326008)(5660300002)(6916009)(316002)(54906003)(36756003)(85182001)(83380400001)(8936002)(2906002)(31686004)(6506007)(2616005)(26005)(186003)(71200400001)(508600001)(6512007)(45980500001)(43740500002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VTUzdkhyQm5sWGhsbjkvWHFQUGNiVlZCZ25QeTFvdkx4cG9JdnFLVkQ5azFW?=
 =?utf-8?B?ek1KZFZYNUxVTFpQYmRjOStvaFhlUlJqYWozNjFHZmNMdC9QcWhCOVlzUTFj?=
 =?utf-8?B?TWJDejFoaXB4ZWRNcVFXL0pDNHZrTU9SUlBrWUtWUWsvY0FPbEk3SkZBUTZI?=
 =?utf-8?B?MHcyVlErR0ZlK3BEWkFVak84VHM2UGhnTU5pb1pWMlFVSXBVNzU3S3l1SGU2?=
 =?utf-8?B?ZzhCQ1lZYllJSFdEazBNa09odm84aTRaTStweEh2MkVPckJmM2h5aVl6OHYw?=
 =?utf-8?B?Ykh5NWtFMldPbEo0ajVNVlBBNVV1TW94b2lFbkJhQ3UzL2NuZEdOS1FVYmpn?=
 =?utf-8?B?OHB4ZlJKVnowZW5Ia0lubStOM3k2OENtb1p6YlA0N3E1QTBIcGgvM2VlOFpH?=
 =?utf-8?B?UEs5RVBTbm94cnRSdTRXOTg4bE03Tit6N24yN0p0SGVWRVNwMTlYaUkrSzFr?=
 =?utf-8?B?WmhBVURBVE1JMFZZNmRZWG9zbTNua2l4SU9RVWlLQUw2d21VUlBkN2o0eUtT?=
 =?utf-8?B?S2M1U042QmdMR2J0SzFMYlN6T2pvRGw1WkpzZ0NhdEovREtOTDNLbTY4L0kx?=
 =?utf-8?B?YVVCOFVrOGJKb1FZUjFLSXhUSGNhaVd0N3ZlVXhKc3hoQmVremkyTXpVTmoy?=
 =?utf-8?B?eE9Na0pFK0VsdElldmVVTjM2RkU1WGprZ016OGkrZmpKSFNHZmVBMmtHS0NT?=
 =?utf-8?B?K3kvRHJVN0cwTUpWL3Q3YXpaTXpxYXd1MG9ZeWZZN1hMcjdXQmtWQzhOeUJ1?=
 =?utf-8?B?WE45NUhLK2NJKzFubVNmL3h0RHhPUTRTWlZSdVZ6bXljdEc2U1J0c045S0lm?=
 =?utf-8?B?M1NhNXZKUHAvV3NUQmMvR3Y0OE9MR3Z4K0xZcllEclZ3UHplSlFpZitWNmJK?=
 =?utf-8?B?T0k5NndNKzlkdXJ0Tjk4d1h4Q2NOb21uUFJRbG5xYkR4RFQxUThPWlNnaU9Q?=
 =?utf-8?B?NFJUSnl2K3NGUUZ5cWdFRkJXbWJ1d1NsdDRUZEl2QWFaME9qRDh4ak9URzVC?=
 =?utf-8?B?eXB3S015K05WOFI3L1Q1dlNJTy9OLzBGN25HZmFGSUlyRHQ1NHBFTEZValJ0?=
 =?utf-8?B?Ulh6akZtN2tSNStTSG44RFJFdWp1RUhMTDEzUW8xRzNROUc2UkNjNzZHR0tn?=
 =?utf-8?B?YmdvMEErczYzcEh1eHd5NVI2NWdSOVY3UTIzUGkzYmc4cksyTlpSY2FKbGw5?=
 =?utf-8?B?V29GS3ZjTlRnbVhZYU5IOFdsM3ZudXo4RUxxd1dYV1RBMFdUV1JPRUxqRE12?=
 =?utf-8?B?SDg2OFBJUzJNbDVJSnFlWUNwMXU4QkpBVGY3enVMbnBwZnRDMUYwbU1wWGlD?=
 =?utf-8?B?QzQ0aVlsaEZNcVlEVk5kdmNlaGQ5b1JIZ0RQRFBCaDc0S1NvVWlhVzNHYWFF?=
 =?utf-8?B?QnQvbTE3SzdtVXJWaVhFeE5KYmtaQVR5Vk1yOUd1bmZnZHNxalY0alU1ZmF6?=
 =?utf-8?B?djdvRGRjSkFIdXlyMGdTZFg4ZU9UdUgxaGdMTkFvTzdIYmtKSEF0b1VPNVo3?=
 =?utf-8?B?UWVQWFIxYlV1enBQbW04QTg3dWJ4SmI5WndmdG1waUtLbFFOblJHck1rUUFI?=
 =?utf-8?B?R0IzemhkVk4rRGN0Q25GVnFWaFpZdjVtR2VMN3AvTVhpNHlMOU1UWEx1bVJW?=
 =?utf-8?B?MFB1SGlxMGFwQllYeUpiUVVFaW1kSUtlMDlGcVFpQnVwMjUxVE8rN0VGM3pW?=
 =?utf-8?B?Ulp5ejlWV01XTWd6R3I0cjN2MnN6RGxsWkZSODZQN3ZEeXJMUDJrYXkxRyt1?=
 =?utf-8?B?MnlDN1M4Y24rbUlOTkZZVldzUk9CZko0Sjg5U2t5VURMYjVTRGtDMm5UN0Nv?=
 =?utf-8?B?UmN5bnNyemxBWjFRM0h0UVlTUDUzR0dZWGZmQkk1VHg4Q1ZGQ0N1UkxIZ25k?=
 =?utf-8?B?bXN6dmIyRlBwNzRJczF0UEVJa3NiVjlFRXkzQk00cmMzWUdubkhJU3cycVdI?=
 =?utf-8?B?MFlOZXlDa0xqS3kvUTE1ZnZtMm9sdFhqV3RLNEV1SmkrNmY3WEZHR2dUYVVY?=
 =?utf-8?B?QVhORGNTK2JFSzRWUVZxMmZUM2RqeHJQZXFPMG1zYWxlZjJ2NXcvVUVOM3BV?=
 =?utf-8?B?RXo3R1BxWkZtam5XN1Z2bENUNkRoTUNhZmFrTGJLYU1yZDlmY1M2MUxoWk5J?=
 =?utf-8?B?MmJla2ljZkZVdGNzZ0FiclpoWUExazdpMEJjR0ExS0RNRDk5ckN1QzBad0Fs?=
 =?utf-8?B?c0E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <CE47D1D1108ABC409E2C98683EAE9825@apcprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: quantatw.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: HK0PR04MB3282.apcprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 05bca052-899f-486f-83ac-08d9f5d62d75
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Feb 2022 07:37:28.2712
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 179b0327-07fc-4973-ac73-8de7313561b2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: n6IudrfZOJSu3pDWZoot8eEb8VK8g+RmKKQ+jzjhegSnSDa3xSGVnno0BoKEaTbbFf6JGCdxxbtGQn6yjNOmcA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR0401MB4115
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

TWljaGFlbCBXYWxsZSDmlrwgMjAyMi8yLzIyIOS4i+WNiCAwMzoyNCDlr6vpgZM6DQo+IEhpLA0K
Pg0KPiBBbSAyMDIyLTAyLTIyIDA3OjQyLCBzY2hyaWViIFBvdGluIExhaToNCj4+IEFkZCBzdXBw
b3J0IGZvciB3aW5ib25kIHcyNXEwMWp2LWlxIGNoaXANCj4+DQo+PiByb290QGJsZXRjaGxleTp+
IyBjYXQNCj4+IC9zeXMvZGV2aWNlcy9wbGF0Zm9ybS9haGIvMWU2MjAwMDAuc3BpL3NwaV9tYXN0
ZXIvc3BpMC9zcGkwLjAvc3BpLW5vci9qZWRlY19pZA0KPj4gZWY0MDIxDQo+PiByb290QGJsZXRj
aGxleTp+IyBjYXQNCj4+IC9zeXMvZGV2aWNlcy9wbGF0Zm9ybS9haGIvMWU2MjAwMDAuc3BpL3Nw
aV9tYXN0ZXIvc3BpMC9zcGkwLjAvc3BpLW5vci9tYW51ZmFjdHVyZXINCj4+IHdpbmJvbmQNCj4+
IHJvb3RAYmxldGNobGV5On4jIGNhdA0KPj4gL3N5cy9kZXZpY2VzL3BsYXRmb3JtL2FoYi8xZTYy
MDAwMC5zcGkvc3BpX21hc3Rlci9zcGkwL3NwaTAuMC9zcGktbm9yL3BhcnRuYW1lDQo+PiB3MjVx
MDFqdi1pcQ0KPj4gcm9vdEBibGV0Y2hsZXk6fiMgaGV4ZHVtcCAtQw0KPj4gL3N5cy9kZXZpY2Vz
L3BsYXRmb3JtL2FoYi8xZTYyMDAwMC5zcGkvc3BpX21hc3Rlci9zcGkwL3NwaTAuMC9zcGktbm9y
L3NmZHANCj4+IDAwMDAwMDAwIDUzIDQ2IDQ0IDUwIDA2IDAxIDAxIGZmIDAwIDA2IDAxIDEwIDgw
IDAwIDAwIGZmIHxTRkRQLi4uLi4uLi4uLi4ufA0KPj4gMDAwMDAwMTAgODQgMDAgMDEgMDIgZDAg
MDAgMDAgZmYgMDMgMDAgMDEgMDIgZjAgMDAgMDAgZmYgfC4uLi4uLi4uLi4uLi4uLi58DQo+PiAw
MDAwMDAyMCBmZiBmZiBmZiBmZiBmZiBmZiBmZiBmZiBmZiBmZiBmZiBmZiBmZiBmZiBmZiBmZiB8
Li4uLi4uLi4uLi4uLi4uLnwNCj4+ICoNCj4+IDAwMDAwMDgwIGU1IDIwIGZiIGZmIGZmIGZmIGZm
IDNmIDQ0IGViIDA4IDZiIDA4IDNiIDQyIGJiIHwuIC4uLi4uP0QuLmsuO0IufA0KPj4gMDAwMDAw
OTAgZmUgZmYgZmYgZmYgZmYgZmYgMDAgMDAgZmYgZmYgNDAgZWIgMGMgMjAgMGYgNTIgfC4uLi4u
Li4uLi5ALi4gLlJ8DQo+PiAwMDAwMDBhMCAxMCBkOCAwMCAwMCAzNiAwMiBhNiAwMCA4MiBlYSAx
NCBlMiBlOSA2MyA3NiAzMyB8Li4uLjYuLi4uLi4uLmN2M3wNCj4+IDAwMDAwMGIwIDdhIDc1IDdh
IDc1IGY3IGEyIGQ1IDVjIDE5IGY3IDRkIGZmIGU5IDcwIGY5IGE1IHx6dXp1Li4uXC4uTS4ucC4u
fA0KPj4gMDAwMDAwYzAgZmYgZmYgZmYgZmYgZmYgZmYgZmYgZmYgZmYgZmYgZmYgZmYgZmYgZmYg
ZmYgZmYgfC4uLi4uLi4uLi4uLi4uLi58DQo+PiAwMDAwMDBkMCBmZiAwYSBmMCBmZiAyMSBmZiBk
YyBmZiB8Li4uLiEuLi58DQo+PiAwMDAwMDBkOA0KPg0KPiBDYW4geW91IHBsZWFzZSBwcm92aWRl
IGFuIG1kNXN1bSBvciBzaGEyNTZzdW0gb2YgdGhpcyBmaWxlPw0KDQpyb290QGJsZXRjaGxleTp+
IyBtZDVzdW0gL3N5cy9kZXZpY2VzL3BsYXRmb3JtL2FoYi8xZTYyMDAwMC5zcGkvc3BpX21hc3Rl
ci9zcGkwL3NwaTAuMC9zcGktbm9yL3NmZHANCmE3YjlkYmY3NmU5OWEzM2RiOTllNTU3YjY2NzY1
ODhhwqAgL3N5cy9kZXZpY2VzL3BsYXRmb3JtL2FoYi8xZTYyMDAwMC5zcGkvc3BpX21hc3Rlci9z
cGkwL3NwaTAuMC9zcGktbm9yL3NmZHANCg0KSXMgaXQgcmVxdWlyZWQgaW4gY29tbWl0IG1lc3Nh
Z2UsIGlmIHllcywgSSB3aWxsIHVwZGF0ZSBpdC4NCg0KDQpUaGFua3MsDQpQb3Rpbg0KPg0KPj4N
Cj4+IFNpZ25lZC1vZmYtYnk6IFBvdGluIExhaSA8cG90aW4ubGFpQHF1YW50YXR3LmNvbT4NCj4+
DQo+PiAtLS0NCj4+DQo+PiBDaGFuZ2VzIHYxIC0tPiB2MjoNCj4+IC0gcmV3b3JrIHBhdGNoIHRv
IHdvcmsgd2l0aCBuZXcgZmxhZ3MNCj4+DQo+PiAtLS0NCj4+IMKgZHJpdmVycy9tdGQvc3BpLW5v
ci93aW5ib25kLmMgfCAyICsrDQo+PiDCoDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKykN
Cj4+DQo+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9tdGQvc3BpLW5vci93aW5ib25kLmMgYi9kcml2
ZXJzL210ZC9zcGktbm9yL3dpbmJvbmQuYw0KPj4gaW5kZXggNTlkNTNiNGMzOWM4Li40YzA4ODI1
MGZlOTYgMTAwNjQ0DQo+PiAtLS0gYS9kcml2ZXJzL210ZC9zcGktbm9yL3dpbmJvbmQuYw0KPj4g
KysrIGIvZHJpdmVycy9tdGQvc3BpLW5vci93aW5ib25kLmMNCj4+IEBAIC0xMzEsNiArMTMxLDgg
QEAgc3RhdGljIGNvbnN0IHN0cnVjdCBmbGFzaF9pbmZvIHdpbmJvbmRfcGFydHNbXSA9IHsNCj4+
IMKgwqDCoMKgIHsgIncyNXE1MTJqdnEiLCBJTkZPKDB4ZWY0MDIwLCAwLCA2NCAqIDEwMjQsIDEw
MjQpDQo+PiDCoMKgwqDCoMKgwqDCoMKgIE5PX1NGRFBfRkxBR1MoU0VDVF80SyB8IFNQSV9OT1Jf
RFVBTF9SRUFEIHwNCj4+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBTUElf
Tk9SX1FVQURfUkVBRCkgfSwNCj4+ICvCoMKgwqAgeyAidzI1cTAxanYtaXEiLCBJTkZPKDB4ZWY0
MDIxLCAwLCA2NCAqIDEwMjQsIDIwNDgpDQo+DQo+IG5hbWUgc2hvdWxkIGJlICJ3MjVxMDFqdnEi
LCBzZWUgdGhlIGZsYXNoIG5hbWUgcmlnaHQgYmVmb3JlLg0KPg0KPiBXaXRoIHRoYXQgZml4ZWQs
IGFuZCB0aGUgbWQ1c3VtIGFib3ZlOg0KPg0KPiBSZXZpZXdlZC1ieTogTWljaGFlbCBXYWxsZSA8
bWljaGFlbEB3YWxsZS5jYz4NCj4NCj4+ICvCoMKgwqDCoMKgwqDCoCBQQVJTRV9TRkRQIH0sDQo+
PiDCoH07DQo+Pg0KPg0KPiAtbWljaGFlbA0KDQoNCg==
