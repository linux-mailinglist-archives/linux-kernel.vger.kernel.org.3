Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9CFF53C757
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Jun 2022 11:20:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242983AbiFCJUG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Jun 2022 05:20:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233674AbiFCJUE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jun 2022 05:20:04 -0400
Received: from FRA01-MR2-obe.outbound.protection.outlook.com (mail-eopbgr90082.outbound.protection.outlook.com [40.107.9.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF0A839BB5;
        Fri,  3 Jun 2022 02:20:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=juXN4Oev5xLskTprHD1uNotFSVYbFX78Ic2inKMr26Iu3G7nDy/LaSH7HBQt7p1jvA7zhYCOUDwO3yzDqy5bmgBK0pGD+blGfANsYnQUGZu63K6oBQ27/dxhEjNmyIEUvZjkF6Nyz8Z3bYZH4viItKQhry0wdDHrViBsGBusb7dXj0h9B4by5cG4RKDfhJWbWDqX+SUrvXFc3z1zuWJlcVqwMlh8xKWDr5DSxmx39XkbobBZuw1ziQUBBVeagXRt7+QLVn1Uf8KBFhNtRAw/LWQ+uqyilmEhUkt+0Gz/rj+HzlWbF058DyijiYXXFr4NSr1MnmkrUNqlwjF5w1UvGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kVYPtyKUGVyCEVjeOCPJaLVllonbm6xt3ZkBW5MNCys=;
 b=YH0n5eP75+iz2o69yBQchMkJlFgGGt7qNWudDcyp4hyCYUby90LPwYQBiFyy3Ho4zYj1DgTQw78KUVrV7J0Fc+O/ZtOSRrHqQo5oKMUgz6405kD+1S9UT8Rn/ZbSnfnWRo9vnt0qOAE7prmdOWu4gf92ufqh/DMwTeCi4S03rYoQCM41J9LWxP5uu00HXNzIFcpSyghmfjRNSBGWnKMhB4TFr3RukdHNY8WDhMXxQ+XaiZKv/sNTnKxYK/7R2D2GT2NjscSfqAXyLFEeGRyGkr4QMO4fPqKh66QQF8Bz6kza+DbIwWxJ/i2qqWpWqGo5FA9qeDX0fRDUMIZL7GEmxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=csgroup.eu; dmarc=pass action=none header.from=csgroup.eu;
 dkim=pass header.d=csgroup.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=csgroup.eu;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kVYPtyKUGVyCEVjeOCPJaLVllonbm6xt3ZkBW5MNCys=;
 b=gnTQlODYRvBTL4lHRK8zkQZLC35jJ/ubn6bTCDFLLnkHj5QZuGlBs0i8A976PM4FXbPs0OCjaP1P+69F8i0mf26rahgGgIhoBe6ivYI7nmTgML4sqgI6qN5yPnHHb+woHYYRjUZOX64+pHQC3/ZDW0QqP8AeD7q7xPqtftLG3+6qZZydO1hmFE8RVWePRot6yHb/HiWEiysfYzNNXq4/xpmfWn1jB2F+uIsicDwNIzmBqPl8G3K8X4bLRUCBgg12h5204xtQb08nvAm0iVcI5JukwdbvEGI/o2baWzT8EPEEc89li8WIw1yCyr1PKuaDbESFssBgpcDVgSBiT4mLiQ==
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:31::15)
 by PR1P264MB3420.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:183::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5293.13; Fri, 3 Jun
 2022 09:19:59 +0000
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::b15e:862f:adf7:5356]) by MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::b15e:862f:adf7:5356%6]) with mapi id 15.20.5314.013; Fri, 3 Jun 2022
 09:19:59 +0000
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     "Manoj N. Kumar" <manoj@linux.ibm.com>,
        "Matthew R. Ochs" <mrochs@linux.ibm.com>,
        Uma Krishnan <ukrishn@linux.ibm.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Subject: Re: [PATCH] scsi: cxlflash: Prepare cleanup of powerpc's asm/prom.h
Thread-Topic: [PATCH] scsi: cxlflash: Prepare cleanup of powerpc's asm/prom.h
Thread-Index: AQHYRnqjfQxr7Zz2vE+soo3FVwv1h609yTsA
Date:   Fri, 3 Jun 2022 09:19:58 +0000
Message-ID: <4c590993-0d7e-07ca-5ac6-f5c7ec135a84@csgroup.eu>
References: <ac126862e2c2801335cded5c0cf7f5d3ea9cdd53.1648833424.git.christophe.leroy@csgroup.eu>
In-Reply-To: <ac126862e2c2801335cded5c0cf7f5d3ea9cdd53.1648833424.git.christophe.leroy@csgroup.eu>
Accept-Language: fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=csgroup.eu;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1b82b7e8-a930-446b-eefb-08da45423b35
x-ms-traffictypediagnostic: PR1P264MB3420:EE_
x-microsoft-antispam-prvs: <PR1P264MB3420DE64BD76F781699FCA1FEDA19@PR1P264MB3420.FRAP264.PROD.OUTLOOK.COM>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: e0n5JzUzUuypj5xcmWJPbSIAlnXKbuD29FA/HPj6pxxb4fjozzfrkhS59bvCclB8xliCNzSzxEENo2EC0g97uoW5JDWP4hTW4F2UwgkZqSGxIeY13KS6+Mpd0K7R8HzLMZvHnBuJ8A7ylLIKLefyK/VzJ6GUFjJrvAwu42eY+3PZOh5uDlK8kbj0YBGwVyTq6bUpzivO4WsCcA0YNPI/JjFEylvFuW487r/P+4XFNvf410I+GHaH4PYknDBmYMFQ8oicXgy89k5eKqn9XEm8uOx6PD5MkPifhRckc86npxRLYusMPhiolMaDMTPY7l3pY0pxb4eYtgmqB97PNEfRtH7TxqRbCJ3zmeTYREqBKjjv05CsMz0FiJ+gkqMj9jcad5CZCqIu+38kP8d6KcWOG4sPyxEWQZZ93fnb5iqYxhRJ58HzTwSPu4lkcnaJTSmH1aeeDykKrU5MuTUahMuS288II8jjcQ7fm4esCh4SsCbJ+SE25Gxzf9Z67XWYNngUPW2AhbqUohslJnkuCgs6vl7kHCXv72xZH7gfekH2d/MKnWRNNMardC3IztxwESkhEpDdEjs9IcGEfWuMh6e8asgllsDFl9Eq/JC3YM1hvyHsrFJap2AXLeoT4mFriII/uTjAShAN612/jPJe7GFi51tBvaqhz39kY5mEA4F4+FYYEfMq0Ln/o3fgL7NDX4JQ679RSPGLre5ycrMwXlt3FoG519kIO9q23NB4a7JLxVEqOrFLK8grmwbqiZaBWdKz6jD63iQVZ6MJLZuYl+1otQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(66574015)(6506007)(71200400001)(6512007)(26005)(31686004)(4326008)(316002)(66556008)(54906003)(8676002)(4744005)(8936002)(6486002)(5660300002)(44832011)(66946007)(508600001)(66476007)(36756003)(76116006)(91956017)(110136005)(31696002)(64756008)(2616005)(2906002)(86362001)(38100700002)(83380400001)(122000001)(38070700005)(66446008)(186003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?S0l1Z2N6M3gvWm90bGhOdVFZNC9TZW5HQWxzYllZUWxVbUthelBFWmMxenF0?=
 =?utf-8?B?enJkSmV4MG5LNk8wRlJOMkVyaXJxN1ljZzNKV1l4Q1pjTEhtdzlUNmpsNFdU?=
 =?utf-8?B?Y2FmcE5rbjZ0WFhQT28xYXZ2M1ZGUndnT003V1IrVmZENWJMdXcwbnFqVmty?=
 =?utf-8?B?VWNUamlOZ0lQbS9BcExFWDBueGppU1pWampFc3p3MzlBZ3BlclRvQ0dXcVJU?=
 =?utf-8?B?Z0F5WFlXUEV6bFdWK0lwKyt3Nnp6YWlocU1rdFJ4YUZueW5INCtZNzVUNyt4?=
 =?utf-8?B?UVcrU3ROWFdjeGpKbVpZT2ZnS1d0MytOVmFKaWZLSC9uc01BLzJJLzE3a0hC?=
 =?utf-8?B?REVkVmZNZHB0TUd1WmVMK3pNTDBuekorL01NenZMMGNwQnFPQTJ5WVhFcHB4?=
 =?utf-8?B?M0x5RWdmNW81YldvcU9IN1RIRElONHYzT0ZwQ2o4bnJ0V1BSQUJsK2haV1Bl?=
 =?utf-8?B?ckpzUE1XdWlvOVlSMnIwdkRxRHhnTGdVM1JDUTFNbkI0UnZPcGVpUWxodjUw?=
 =?utf-8?B?aG1zN2Q4Wkl6SlRST0djTGJLN0tIK1RMWC95eTJqVHpOaUVabFNrdjdqVlhI?=
 =?utf-8?B?Uy82UHY1RklTYi9McTE0aGtOZXVOUFlRb3pkSHMzVlNudnZjaDREaGlHdHlE?=
 =?utf-8?B?UFd6WmRGRjIraHd5TEFsS3ZGN09WcHU3VUxHeERMU1NlTG5BWlpNMWdVUk5v?=
 =?utf-8?B?NzFieFo4ZmtwTyttU3dVK0g4UGwvakk3eVdYdE1pb1ZLV09YZW9uNUwvVmFB?=
 =?utf-8?B?d28rT0dFWUJaWkN5NVF3TldxZS90TjUrRWdIeTZ4a1Vmb29yTVk3dDZET1hX?=
 =?utf-8?B?ZFJkY3BvcWZGWWhNWGdSTkZNa3hCODVyOUo0YU9IaUFlVmhjZ2Z3MEw1RWRo?=
 =?utf-8?B?a1AyanlVZUtxeTFVdG03TjFFOFRRU1VFcmZkUGxVNmdYYzc1S0lDekFRWWQx?=
 =?utf-8?B?WlFLaWR6TVZqSmkrVDEwaXI1R0FaZ0tTQ3VvZWtXcCtKSHB4RHU4L3ZLTk5O?=
 =?utf-8?B?UFFwb1F0b0Z5N0V0cnlJTi9lN0NYT283S1F2amtnR3ZGR0dndHFma1Z3M0c3?=
 =?utf-8?B?YVYydlBuSXNtek1KOTRKaENvNG9IeXJSUHUxSmJhd256VWdTY2JwTWJtc0pV?=
 =?utf-8?B?MC9LTDJsY2NwMGE1dkZ1MGxnMkVDSjZVSWdXZkZOUlJIbDhiUHZmODdEQUJR?=
 =?utf-8?B?eEVUcXdKcHRBcENDaDR2eXBSZVhpOW41L3J3UDFSUmU4REJwanh0SjUxRVVO?=
 =?utf-8?B?Zk5NSmp0M01hcjM0amU4Y1U1RDZKL3ZUV2tuUnNvZEJXUFJiQ2p3REo2WU42?=
 =?utf-8?B?RHZEWjhYcWZrZytOSTB1NUNTaWQ1MTE0R01TVE1qOE5ZZURGU3IwRGNCeUd2?=
 =?utf-8?B?WTdRT1ZWakJ3aWlpaURzbFNjQVdFQ1hyMnk2ZUdXakNqaTZJU3RxOHo4VTN2?=
 =?utf-8?B?L3EyVzBEdkJ5alRPRjVvWlUvSmZBVkIrUWZ4dHZabVdRbkxGckwzS3RhNXll?=
 =?utf-8?B?aFpWUWt6YTJDLzdhL3Z5SDZnS2NUZTVoOWI2MnVxSDRkTXk4TS95QWg5WkFC?=
 =?utf-8?B?VkJjdlVHVzFod1o5S0p4YUttTnNaRXRyd0hhREY4N0pncTViZmxCRDVWdXM5?=
 =?utf-8?B?TlhuenFRYjV6UndDSWVoeTVyUzFuUTBBUGU0cjhrZlFGM0VDck80YnRQNGYz?=
 =?utf-8?B?RVVVZUxMTFJWVDJxSkhuQXUwRHdkbXltWmhGL0FCb1kwTjdkNWV1MDJmbHEz?=
 =?utf-8?B?a3JLdURIaXNMak0wOHYrLzUxR1BLUDE1bnFNVW0xZjA1SlN2bUJseVZRMDQ2?=
 =?utf-8?B?K1ROeXJGc1ByUkJ2L1ZIaWI3U0FNMG1WQ29pSldKYWZqV3RaMXJBRHVxazFR?=
 =?utf-8?B?UVpxMldLd0FSdGNsOE9IVEdsZENKTVhuZW5MMm5FYXRBNWFEY0c3aTlEZ3Rl?=
 =?utf-8?B?Z2I3Y1RLWHh3YUFpS2Mzbi9ad0xFVzN4N25EaXFCZlNQRDArS1owVUw1WXFr?=
 =?utf-8?B?S2I2ay9LRnREdGtkQkw3TGdDUi85KzQ3UGxzOGIvREpoWlhiZzYvUldKbGMw?=
 =?utf-8?B?V0ViWnZFa0xtRFo2a0IxeGp2dGRrcy9MVXdiMlY2bnVrays2Z3dEM1JnZUJl?=
 =?utf-8?B?UkNlTlp3c3hBZHEyLzlvNFN6UXFhTXRzMmc4NDYvSEJmR0xSdGtOWWx5R3Y4?=
 =?utf-8?B?WU1KbXJDV3pvbTBpclQ1NTBVZW13YjAvZHZIRWxFUVhpSWllWlZSdi9PdEdB?=
 =?utf-8?B?dWttdTlHbjhjRGhzZnZuc0lIZ1QzaWVvL0t2MVVWS2dBUy9PVkVXM1BtZ3My?=
 =?utf-8?B?ZUdTSFVpRCtsQ1NUeXZJWStYNWltM094ellzcEYrYzVqZFN2Q2ZCWlJQWncr?=
 =?utf-8?Q?11oa7NN7vzg+6irc3A+F2Tp6NwgjY1+L6MDUg?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <764B424C4F9B1E4089281C75B8A9C25E@FRAP264.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: csgroup.eu
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b82b7e8-a930-446b-eefb-08da45423b35
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jun 2022 09:19:58.9426
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9914def7-b676-4fda-8815-5d49fb3b45c8
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Zi3od+fk1UnGnPA4m8APTk8aHiNLPqMN0vXLBtdl0sLR6yd213wrM7svZZDaXGZNhrA+gdBukpivkmhay1kPnN9FaaVVyyoAVnN/jQmzu44=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR1P264MB3420
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

R2VudGxlIHBpbmcuDQoNCklzIHRoaXMgZml4IGdvaW5nIGludG8gNS4xOSA/DQoNClRoYW5rcw0K
Q2hyaXN0b3BoZQ0KDQpMZSAwMi8wNC8yMDIyIMOgIDEyOjE1LCBDaHJpc3RvcGhlIExlcm95IGEg
w6ljcml0wqA6DQo+IHBvd2VycGMncyBhc20vcHJvbS5oIGJyaW5ncyBzb21lIGhlYWRlcnMgdGhh
dCBpdCBkb2Vzbid0DQo+IG5lZWQgaXRzZWxmLg0KPiANCj4gSW4gb3JkZXIgdG8gY2xlYW4gaXQg
dXAsIGZpcnN0IGFkZCBtaXNzaW5nIGhlYWRlcnMgaW4NCj4gdXNlcnMgb2YgYXNtL3Byb20uaA0K
PiANCj4gU2lnbmVkLW9mZi1ieTogQ2hyaXN0b3BoZSBMZXJveSA8Y2hyaXN0b3BoZS5sZXJveUBj
c2dyb3VwLmV1Pg0KPiAtLS0NCj4gICBkcml2ZXJzL3Njc2kvY3hsZmxhc2gvb2N4bF9ody5jIHwg
MSArDQo+ICAgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspDQo+IA0KPiBkaWZmIC0tZ2l0
IGEvZHJpdmVycy9zY3NpL2N4bGZsYXNoL29jeGxfaHcuYyBiL2RyaXZlcnMvc2NzaS9jeGxmbGFz
aC9vY3hsX2h3LmMNCj4gaW5kZXggMjQ0ZmMyNzIxNWRjLi42MzFlZGEyZDQ2N2UgMTAwNjQ0DQo+
IC0tLSBhL2RyaXZlcnMvc2NzaS9jeGxmbGFzaC9vY3hsX2h3LmMNCj4gKysrIGIvZHJpdmVycy9z
Y3NpL2N4bGZsYXNoL29jeGxfaHcuYw0KPiBAQCAtMTYsNiArMTYsNyBAQA0KPiAgICNpbmNsdWRl
IDxsaW51eC9wb2xsLmg+DQo+ICAgI2luY2x1ZGUgPGxpbnV4L3NjaGVkL3NpZ25hbC5oPg0KPiAg
ICNpbmNsdWRlIDxsaW51eC9pbnRlcnJ1cHQuaD4NCj4gKyNpbmNsdWRlIDxsaW51eC9pcnFkb21h
aW4uaD4NCj4gICAjaW5jbHVkZSA8YXNtL3hpdmUuaD4NCj4gICAjaW5jbHVkZSA8bWlzYy9vY3hs
Lmg+DQo+ICAg
