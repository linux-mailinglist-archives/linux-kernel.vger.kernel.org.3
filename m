Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC9215AFCEF
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 08:57:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229670AbiIGG5s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 02:57:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbiIGG5q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 02:57:46 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6465883F5;
        Tue,  6 Sep 2022 23:57:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1662533865; x=1694069865;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=YfKvJ6KZhdYnLWX5TjQ0LLIyrRzffZNMZCucNWOQlwU=;
  b=hHvd8JE6TGoIZ4iHW04+7Yyu6LoXX3o3xXCKmHl5k5uNF1STMtGuSPYA
   t6D1TGp8RfhWPXukst/SKWddapGNbba0zMfsXz/3ViEeebYDU4j0s5A4A
   irNbKxtseAfQmobAjrm8yS12y5bgesjc22AZq0IdAhJZqbu7twVT/S8oF
   Zj96kx7tK7aH77Aj3jr4PlE9GbgbARXxnrMeMgYVzcLcYHv07MyJUxEyo
   74S6qtHgBD7UrgRL4LdqxnhuU3wRo8ptUT8x19HL5FOC8p3yYHE3HS6w3
   N1kR79mdWVZ3Ieq6OrRAg3f169U2Xs7G2Jr1aPuVnTUYTbNLAx0D9wzxb
   g==;
X-IronPort-AV: E=Sophos;i="5.93,296,1654585200"; 
   d="scan'208";a="189745848"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 06 Sep 2022 23:57:44 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Tue, 6 Sep 2022 23:57:44 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12 via Frontend Transport; Tue, 6 Sep 2022 23:57:44 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n7A+hXz5abqQ739WsXFUEmQ60SeRohl6PzkZn64IQksHZUdBcOaf/8vgT77tq5nNkml70vH1yo2lCaW6lv93Ax7BXurk3Bf4uQrdOZxVfwa0fgRu0u6nuDYlM6O19zfUbcz0lyvcHfXgyds0JcDnAQ9uccB6py714XGA4zrdoxMbFUunz5JhOkDcWGAKVdH/mEXz0OfgyUT3Jxwhu4CjeFL4WyoLqFQbV6VfjOjIxKFt8SK9J/2lP8BkazQHCf8q0turYtANJuWDzf6BvAi0cKB+yKYjVRga0QVGq2a3LcFwb/ESQm8//KfyXMUSwk8ugr64/03Emp8i10XmYJnd7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YfKvJ6KZhdYnLWX5TjQ0LLIyrRzffZNMZCucNWOQlwU=;
 b=Tx4Hw09r6XSP1hA5xse2S22OZcFD8UINr4cX/6U8jqEXeNZNFhLqSmK8yfikVlVPPwYlkbz+uwYuF6cs75UNKqVLmcZFxAHYp/0KHPQ+wEwOlRjEU/7Hs9oyuaxnVRPb26mPSOkVfK4NjzZz2b4PJPBtlxuCvIl0sl1jt/b/KeLC3Vrjt8eF5ZMKr+oTbBH7k17XxSpIBLrAGZJ1WhkzMm+XqDxyxEMLPjavRJh2qnzsaPIDutYkxLm1tXaRKg1SsEkkFyijhI87635B9GLo2xsn7UyJY4HNHXB+VKAnMCZwOh0Ph0t8XK2DpyZr9iQsDSS2+uUczReFZ/4xZrdCdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YfKvJ6KZhdYnLWX5TjQ0LLIyrRzffZNMZCucNWOQlwU=;
 b=P5bH5e2vykSVgt++BKOez/8sM5ZZmSkEfXN3wI5KBA8ViZbEoh2NsquLBAJO2xXyMe0pkMBsWOse5nWk8TNzmqTcj3PnRb14en+9+WwTH2x+FtDUXq1aZKSHesPL3ND8u767jeKZOG7Zc+CLzwH/nHwbO4og9S7zgJM+LjNIJ+k=
Received: from BN6PR11MB1953.namprd11.prod.outlook.com (2603:10b6:404:105::14)
 by SA2PR11MB5164.namprd11.prod.outlook.com (2603:10b6:806:f9::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.11; Wed, 7 Sep
 2022 06:57:43 +0000
Received: from BN6PR11MB1953.namprd11.prod.outlook.com
 ([fe80::a159:97ec:24bc:6610]) by BN6PR11MB1953.namprd11.prod.outlook.com
 ([fe80::a159:97ec:24bc:6610%11]) with mapi id 15.20.5588.014; Wed, 7 Sep 2022
 06:57:43 +0000
From:   <Claudiu.Beznea@microchip.com>
To:     <richard.genoud@gmail.com>, <13667453960@163.com>,
        <gregkh@linuxfoundation.org>
CC:     <jirislaby@kernel.org>, <Nicolas.Ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>, <linux-serial@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <yijiangshan@kylinos.cn>,
        <kernel-bot@kylinos.cn>
Subject: Re: [PATCH] tty: serial: atmel: fix spelling typo in comment
Thread-Topic: [PATCH] tty: serial: atmel: fix spelling typo in comment
Thread-Index: AQHYwocgxf3h2G4UQ0inKUTO6oPI7A==
Date:   Wed, 7 Sep 2022 06:57:43 +0000
Message-ID: <3dfc28ba-b73e-0174-4b5d-a80eb259028a@microchip.com>
References: <20220906063957.2951323-1-13667453960@163.com>
 <c7d0dc8a-f12b-d586-c7ce-10e329fdac2f@gmail.com>
In-Reply-To: <c7d0dc8a-f12b-d586-c7ce-10e329fdac2f@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 02fe9f4e-30e3-4d30-2e16-08da909e431c
x-ms-traffictypediagnostic: SA2PR11MB5164:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: M1z59nYmfUR/yM/vsrTHffSYf+n1ehfQeIpoxS330rBlmiFfvM4GELBtXDCl574d7t5FV0t5n7+eFu9UsfrLDsRujFOkAxZHsGtLsNibJX2uyRiMqvVBvpPMxurgnS9ueN6gY54q0VinFnbDTKL6XY3npUuDKXcZjuOojqwxpn/lVih0ahVsA3JLbSRnmdUtbDMFlqpsI/ctXLpk0FIYDK1OTsJ20Jgd8mt8u4S4J52kApxjjOREEX8ruFi8O2Tps2CCJO0z3JM66XavG3sTmFak77ddLGuhgMgy8b3OKeD+vIlfMkblZMNvVnek9jbtpbu7IgT439KxVXrCI2rfryAVWgzkraaduH7vbvAuiAcGZZ9xxQP2v4GTcB3YbSoWN4ibKLPhabz8vjiFtH6wfp1aNLXvnxrmmN3q0hLzzXulvs6MnGINPPus2u3an55JVm36PzO76q5v2BW40AR3g3o36JCEONIP1r8HWIfC4Xkdxn6rvb4Sr01WVpSkyxqShII3VlHy4oQjsoxWeeW0lvu1nqJH70kg8v18xcYyflLjtFkFFUa7Ks1ot8Z4JZsWIYT47M+prTu/ANTO3YeTC8lQ6C5SadSvQzYIKwSbY9+C+Gh9cYYds50Ca6dYM9vrHgAaKQwM38u/42g7NFlLdnzIg5vkdjDOmqbPA1VH+ccoybyijuxlDRtlnnEQQMlLgeMeKcmVtgIrSC1upoaugv5ExJANHhaO2R2LvSzTsTUIaqJkfekUrLeakSwxNFEQulc3Vg9uAs6Lbrvg3wbXt/0KbKffDsQsGUKn6p/QNZ3M8IrQ7GFjjwVH00lBy+d8hYIe9WDmlA280betvnLJrA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR11MB1953.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(39860400002)(396003)(366004)(376002)(136003)(346002)(8936002)(2616005)(41300700001)(26005)(186003)(66574015)(5660300002)(31696002)(7416002)(53546011)(86362001)(6506007)(2906002)(6512007)(38100700002)(83380400001)(122000001)(38070700005)(54906003)(91956017)(316002)(66556008)(478600001)(76116006)(31686004)(64756008)(66946007)(8676002)(4326008)(36756003)(66476007)(66446008)(110136005)(71200400001)(6486002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WGJ4SzdqYS9QMTNSMDZEMjZNc2xZNmNxNzBOd1NBWStjMHJ2RHE4RTNDZTFK?=
 =?utf-8?B?L2Zjb2MyZiszblRrWjRrOVFtN0pQcDYyQzh0d2dqbTlZcUJzL1lUTkVKUHdX?=
 =?utf-8?B?VGl5MEtjUjhyR1BwTHVRNm5OQWhRelR5bHgrQ0xCSXRTR3BQNXo0RWkzVjZP?=
 =?utf-8?B?Q1F0Yi92Qy90WUtkUy9kQjZjdGZBTTlkYUVlcVJDY1BzTW9tZFB3cGM2UFZH?=
 =?utf-8?B?Q09XdnlSUUtyQmExSVJEbXZJUGNxWTlCTjV5RFJIeFRTK2lHbjU2aWxkbEZC?=
 =?utf-8?B?NG5kZlRnQWE4R09sdmd5U0t2WnFnaXZHUWx6YTdJdUF5YXAzQnoyR1M1Zyt4?=
 =?utf-8?B?a2xZTW1qdEJzV0oxUjhBK01NYzRjQTdLUUlZcDFtVFRpK3NuNXRsa254U2pN?=
 =?utf-8?B?QklzM0xib2d3NTYvenpaYmpZdVdhUStEN2loSnNleGNyYmlpUW9RMTFaQjhw?=
 =?utf-8?B?eDc3Z2o1VUZ4V2gyU0dNMjQ2K2FXUURQclVYL0FtTmhPNDRCT3drNWZaMGVa?=
 =?utf-8?B?dW1DMUdoaXNRYVNtS1hESEtWdHkxZHhtNDVOYnFPd1lJK3pySG5kUGtETDJt?=
 =?utf-8?B?a2NpaFFnQUpXazlRNnJ5bXM4cTJxMi9HcVBieVl4MGZnVDk4b2QycmVncGRP?=
 =?utf-8?B?NU8wSjYreEIwaHpSLzhVNllzN0t1V25LR2N0U0liejV3ZGJySndGMHpjLzBW?=
 =?utf-8?B?eVNHZGRRZk1MMVgvcnI0L25Zb0s0T1dtYU9PN1p2Q1p6UGdvSW02L1JPN2l1?=
 =?utf-8?B?ejdkOWtsWXBVazBYVG1yWHBBVmhJdDdOcStSajRmK09WNTlKZnROZ0RMQjc4?=
 =?utf-8?B?cGk4N1c3Y0s1NnBQSE1kanlCK093WjFoTktrMk4xNkxGYjU0ZnZyN1BXQnRx?=
 =?utf-8?B?UUFWZkZGSDNYM1BSSDdyS0pwUTRiU3FPbEdISFdmZWErbkVhcGFwSFU3dkF1?=
 =?utf-8?B?eHNZNWMyeFRsRkNsY3hBMlFnSmdiYVdhaGZjM2IzdEdSbC85YS82bkRUbi9P?=
 =?utf-8?B?RmN3Z1cycWUxMTc5Nyttd2oyWlZ5T3VFUzNpZVNoTXVaL0NPYS9YWDVQb0dh?=
 =?utf-8?B?U1FDcFNXYTg0U0ozYWdTYmVsNmdDSzdleEtBbXNscU9DOEtjblZPdElrekxX?=
 =?utf-8?B?K3hmcy9LQTJXNXNQMUhFMnVHWlNvT1NiaXNpMHkzbU10VTVaUy85aGgzQWcw?=
 =?utf-8?B?M3krTTdNTWNnSlZWaGNTeld0T29pQ29GNTAya1pWbUIwb0ZsY3VpNjgxckdn?=
 =?utf-8?B?THlpWG1JdFhZSkpzWFVySnZzZHI1Um4rVERXS0VZV09nbkZNM2ZsNWhuYWhL?=
 =?utf-8?B?cDRGVHVrdFZvSnN6MkExVjVsUUdkYld0cUZ3Vzd4aUFjVHU4VTBoa2ZwSGNt?=
 =?utf-8?B?aEdBNW1ZTDZFbno1b09EaEVXdnMrUDdIU2ozMGZNc1g4ekN2bU5sOE9pOVN2?=
 =?utf-8?B?NTZPdnNkSUhmNkppVHQvekJpZ1hIc1dvOE1LRHpJUTdkb1J3aXcxRFA3OXk0?=
 =?utf-8?B?YU4rbkNCZy9xWjdOekt3ekFXS0xaelNkbDhDa2Qzckp4SkgxSWxYWE0zVFNi?=
 =?utf-8?B?UFVWajAvQS8ra0VkZVQrZjlVTnlGdmZ5ek0rMWZRRVJqcW5JS051RTJPcVdT?=
 =?utf-8?B?YzF3aXZJa1dwLzFDOWZpY3NWN3RRa0tLSjY4amladkZEbXN3d1pGTTRxUUtQ?=
 =?utf-8?B?WFR4MHh0RjkrOU5qVG1xNUE4YXNLL2NWRnZ5Q2JVamZsQk01Z0FBYWZqYTVE?=
 =?utf-8?B?R1F4NXJxRlJVYURROTRWMmFDMzRtd1JTMkprelhqZkpOenZ6RTVIcHRlQmt0?=
 =?utf-8?B?MWc4VmJGK0o1TWxXQ1ByYVpRRUl0QnhHbWw2UnBTY21SU1o5RHdjWXlPdmV2?=
 =?utf-8?B?dmVhSXIwcXQvd3VGTzJPWHNBdW13dUt6d05yWkZldERvS3VJK29kRGFKenNq?=
 =?utf-8?B?YytoUDhHQWczQzdING9JV29Dd2NaY3RZcHZUZ3FYRGtWYjVYMnlCUGlvdGhY?=
 =?utf-8?B?VG5pSW5XSlBWNnN0SHJYUlRWUWVITmZ1OC9Vcnl0MmZvbWxkZnp3TnZKUzZj?=
 =?utf-8?B?RVRCYnVrLzlubUM1dVhWYy9YV3hlQXdZNUh4dlE0TW4zRjlvZ0lKbjZsYnRt?=
 =?utf-8?B?TE04aWNlOXNvZWx1MXVjZEIvLzhRQndKT0t6SkM3c1NweGpqOUIxMDArU09P?=
 =?utf-8?B?NkE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <FCCABB36D702D744B73B4E8CEF412DC3@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN6PR11MB1953.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 02fe9f4e-30e3-4d30-2e16-08da909e431c
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Sep 2022 06:57:43.1030
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: g3zV0gVuYxTBdW8+P3o0lxg72VulU10okriEAXSiRrMGXwR8emVjzo7NI6438SqG4f8RQHUU/kgbOkA36t5GgTMQ1iS/MeghaJvKn5yhpUs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB5164
X-Spam-Status: No, score=-6.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMDYuMDkuMjAyMiAxMzoyMSwgUmljaGFyZCBHZW5vdWQgd3JvdGU6DQo+IEVYVEVSTkFMIEVN
QUlMOiBEbyBub3QgY2xpY2sgbGlua3Mgb3Igb3BlbiBhdHRhY2htZW50cyB1bmxlc3MgeW91IGtu
b3cgdGhlIGNvbnRlbnQgaXMgc2FmZQ0KPiANCj4gTGUgMDYvMDkvMjAyMiDDoCAwODozOSwgSmlh
bmdzaGFuIFlpIGEgw6ljcml0IDoNCj4+IEZyb206IEppYW5nc2hhbiBZaSA8eWlqaWFuZ3NoYW5A
a3lsaW5vcy5jbj4NCj4+DQo+PiBGaXggc3BlbGxpbmcgdHlwbyBpbiBjb21tZW50Lg0KPj4NCj4+
IFJlcG9ydGVkLWJ5OiBrMmNpIDxrZXJuZWwtYm90QGt5bGlub3MuY24+DQo+PiBTaWduZWQtb2Zm
LWJ5OiBKaWFuZ3NoYW4gWWkgPHlpamlhbmdzaGFuQGt5bGlub3MuY24+DQo+IEFja2VkLWJ5OiBS
aWNoYXJkIEdlbm91ZCA8cmljaGFyZC5nZW5vdWRAZ21haWwuY29tPg0KDQpSZXZpZXdlZC1ieTog
Q2xhdWRpdSBCZXpuZWEgPGNsYXVkaXUuYmV6bmVhQG1pY3JvY2hpcC5jb20+DQoNCg0KPiANCj4g
DQo+PiAtLS0NCj4+ICBkcml2ZXJzL3R0eS9zZXJpYWwvYXRtZWxfc2VyaWFsLmMgfCAyICstDQo+
PiAgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pDQo+Pg0KPj4g
ZGlmZiAtLWdpdCBhL2RyaXZlcnMvdHR5L3NlcmlhbC9hdG1lbF9zZXJpYWwuYyBiL2RyaXZlcnMv
dHR5L3NlcmlhbC9hdG1lbF9zZXJpYWwuYw0KPj4gaW5kZXggNzQ1MGQzODUzMDMxLi43ZjhhZjJl
YTNmYTUgMTAwNjQ0DQo+PiAtLS0gYS9kcml2ZXJzL3R0eS9zZXJpYWwvYXRtZWxfc2VyaWFsLmMN
Cj4+ICsrKyBiL2RyaXZlcnMvdHR5L3NlcmlhbC9hdG1lbF9zZXJpYWwuYw0KPj4gQEAgLTQwLDcg
KzQwLDcgQEANCj4+ICAvKiBSZXZpc2l0OiBXZSBzaG91bGQgY2FsY3VsYXRlIHRoaXMgYmFzZWQg
b24gdGhlIGFjdHVhbCBwb3J0IHNldHRpbmdzICovDQo+PiAgI2RlZmluZSBQRENfUlhfVElNRU9V
VCAgICAgICAgICAgICAgICgzICogMTApICAgICAgICAgICAgICAgIC8qIDMgYnl0ZXMgKi8NCj4+
DQo+PiAtLyogVGhlIG1pbml1bSBudW1iZXIgb2YgZGF0YSBGSUZPcyBzaG91bGQgYmUgYWJsZSB0
byBjb250YWluICovDQo+PiArLyogVGhlIG1pbmltdW0gbnVtYmVyIG9mIGRhdGEgRklGT3Mgc2hv
dWxkIGJlIGFibGUgdG8gY29udGFpbiAqLw0KPj4gICNkZWZpbmUgQVRNRUxfTUlOX0ZJRk9fU0la
RSAgOA0KPj4gIC8qDQo+PiAgICogVGhlc2UgdHdvIG9mZnNldHMgYXJlIHN1YnN0cmFjdGVkIGZy
b20gdGhlIFJYIEZJRk8gc2l6ZSB0byBkZWZpbmUgdGhlIFJUUw0KPiANCg0K
