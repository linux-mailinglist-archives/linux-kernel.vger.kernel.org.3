Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF4AE47A760
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Dec 2021 10:45:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230002AbhLTJpH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Dec 2021 04:45:07 -0500
Received: from smtprelay-out1.synopsys.com ([149.117.73.133]:51046 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229845AbhLTJpF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Dec 2021 04:45:05 -0500
Received: from mailhost.synopsys.com (badc-mailhost4.synopsys.com [10.192.0.82])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 1C28147889;
        Mon, 20 Dec 2021 09:45:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1639993505; bh=cIPXXyNaIMxaa0cCnHZtTT41la2/o0U+CoWIqWty7sw=;
        h=From:To:Subject:Date:References:In-Reply-To:From;
        b=KGsXS6X8w1045Ruzyf9LuDISwVd6vj/MsHwFvA/0eZcfR4+Lf2Jdbe1kwHqc0NDh2
         zzX9PNHUCgkJ8xok2eq45MPKt+FgIPgSG7VE3QbmvniyPtFq+ANQ4XQz0RDK1IlO/h
         j6SM3ymR/D8vsiepwpNa8ujcGR2zVuIHNa1GwB4WCezK2cjD+c0w8RDAxesOQVCLZ0
         TFR88UUfrjAH0WiJT7J/v3mhurbaOlFBC0R62yynd3ETvuXX1fd4McJHuWsHDlqNoI
         x7TzO8GjNv7R4iK59wGYL9I2KfyjRCqLswujEbjRILwqY8xpdXZj/cNxR+NiVmK80B
         2O+TaPoSScXPQ==
Received: from o365relay-in.synopsys.com (us03-o365relay1.synopsys.com [10.4.161.137])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
        by mailhost.synopsys.com (Postfix) with ESMTPS id CE2F8A006E;
        Mon, 20 Dec 2021 09:45:02 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2045.outbound.protection.outlook.com [104.47.66.45])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id B08238007A;
        Mon, 20 Dec 2021 09:45:01 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=hminas@synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.b="lMDIcrYI";
        dkim-atps=neutral
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PhQTwLXM5GiFqU8B/3wuX+ed9uxYDAjwjS4TXZ43AIWUrfiMrC8rivw3OxQ+7HYg5+irmK4Hnt1/BZvzw2PhJrIYbJGOYxnsq5NCXuWgUMmvxX4Ggrq9h8iEE1272+9LLuDxv9V0wfjIK6hGM9fhS3qIN+C2CNG9CxBAo7+QRxkqnOXyq1khk0Dsk95I5qzpBMsiDJp2XClr681CYl4yEIvKfrvxWRp8y3i83OZkRbQVUotexbHSGSOZZml4Yulmd5OpaUNDxA82SpEFlB/2UcNwGWZRSg1Oti3UwNcBy/fTtpVDDgSyKGI0tm1y4SlPAndMLaP6xTrdI6Tw5AU1dQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cIPXXyNaIMxaa0cCnHZtTT41la2/o0U+CoWIqWty7sw=;
 b=RHbjdvVhUZ97VJAvy7k+pOM5Uhff8xYfoQO5HZIr26Jp7DV/QFehgkqOdj9uL0TPyEfKqMaicZFrejdKjUNhqUPn7RxV2DXCi3YldXBk4D1XL+yubkcqCxgsarnpmYsqw6XogFFJyn/XpZbW7NTGcj2t/bRkfb8q3PDWM6FvrwtDY4p+D8y58TaTeje1oIPQoaiK90bjz0wLGsPSgg0hh4b/9tBJpENHV+wCOBSGN8rBRDzPEok7Dz+y6UXzu48t+VnJtyPlOljpTtBEsGcxBPQByGc62sgRqypYudHJcMTXFsz+jzag9OK1rre+v5BQk51XUQIsNWUSLdhuAUCexg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cIPXXyNaIMxaa0cCnHZtTT41la2/o0U+CoWIqWty7sw=;
 b=lMDIcrYImiCWJAPvQodovXuxM+FfAyGQeQ3Cd0ETX3ML8KN5Nu7A5PMBkOkRPsE+K2rIzJbK6KwKyOPuonc0hRDoqopcWt2ntkrQNNSxOBYyWSZ+VJRmHnaTS6p0pr1mm5ahJWiw14dAMWvyPR2W1o3O22y8bQrOcY7pGaTvUYo=
Received: from DM6PR12MB3419.namprd12.prod.outlook.com (2603:10b6:5:3c::32) by
 DM5PR12MB1692.namprd12.prod.outlook.com (2603:10b6:4:5::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4801.18; Mon, 20 Dec 2021 09:44:59 +0000
Received: from DM6PR12MB3419.namprd12.prod.outlook.com
 ([fe80::e915:32a7:2ec2:ed84]) by DM6PR12MB3419.namprd12.prod.outlook.com
 ([fe80::e915:32a7:2ec2:ed84%5]) with mapi id 15.20.4801.020; Mon, 20 Dec 2021
 09:44:58 +0000
X-SNPS-Relay: synopsys.com
From:   Minas Harutyunyan <Minas.Harutyunyan@synopsys.com>
To:     Jiasheng Jiang <jiasheng@iscas.ac.cn>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] usb: dwc2: Check for null res pointer
Thread-Topic: [PATCH v2] usb: dwc2: Check for null res pointer
Thread-Index: AQHX9Xju8QDCVWBRJkiETkO5q1rDSaw7IY2A
Date:   Mon, 20 Dec 2021 09:44:58 +0000
Message-ID: <7a7df3b5-b059-b109-ab98-8046ce73261d@synopsys.com>
References: <20211220080926.883605-1-jiasheng@iscas.ac.cn>
In-Reply-To: <20211220080926.883605-1-jiasheng@iscas.ac.cn>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=synopsys.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 88319300-6d17-4d75-a149-08d9c39d6308
x-ms-traffictypediagnostic: DM5PR12MB1692:EE_
x-microsoft-antispam-prvs: <DM5PR12MB169271162912A7F54AAD7FBDA77B9@DM5PR12MB1692.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:983;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: GhvoPFtGOJGwc2Y+OSWHlJJFPZT0ISsJ2cMyiNZyk5j+0hFqVOxNnjtaG5dW9W6Roywqso6CwOQwpJs/en9vzwt0jIhuGkGjve/0dNzQZXVbJyqBKubxSGi+PJ8n7JbXvuS3LvbVwVZEsW8VhuZCf1oMko3LtYQWrpmpEhKGWVeMbzHZW6DcVphKNxq7kLzoItPLt6nSp3aIvskC2ErdKJdMPSRWChBv4ah5L8IcMTYyvvJtEiDmmNC0j7BrbMrHpXDsmhX20y97ejwLK7Wr8OhbVm1kw0jwWHajQmqgLt4XQx6NDOGGCND0F3AnDUXDdCb5IqxgoOy52P5/PoWZdbx3iMb33+FmnaabuhTC1gpV6y3NnJVgyw0XtWvmPb3TEPnMxnLwC6J2Eyw5b+7gVRKUjp62VgZf6rpAIkHEWms7d+C7Cwdd07uT6xuMj6VZe3lpcL9TPA7p+643Nlp0zuvpr+qV4JarwjSybUDKiw1MIoo5nK2EGZ2hiQtMKKB0FpM9oRuw9/jePzUJKyaWzg/HksQsJLvV8Rv+zr9BY007JOl+43lK0GsW/aDjqSr35B3NIVxexZLFvkQfoN7NjPJMLnFhDXRpPE/FB79tQtcNPFz5+uxPiAC/SsfiwCSR0hyHZn9lnZc/8mtwsiwjPC7VHFN28VO+bXZWt1PutH1J1M4hKN/SuzRox1NGnEKM40E7dYIzNYJjg/FQg1QREA4AUyvwLtdG/jgmfWFbo0KVMUa6as33wyKawT9b/ZXQWJD9i0RXEwB7g/bcYzoYNw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3419.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(66946007)(76116006)(6486002)(66556008)(66446008)(66476007)(91956017)(38100700002)(83380400001)(8676002)(122000001)(86362001)(64756008)(8936002)(31686004)(5660300002)(2616005)(508600001)(38070700005)(53546011)(6506007)(26005)(186003)(316002)(31696002)(6512007)(71200400001)(110136005)(2906002)(36756003)(43740500002)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Y0hoRUpBaHE1NTIwdDNlckRJNmNRNkJwV3pnbjFkd2tBRm11cFpmYmNDTFRj?=
 =?utf-8?B?eGh4MlNyaDQ4MUtkRVh2TzRuVkltV0lvNkF2S2VzejE1bVpqSFA1TkxCVGF1?=
 =?utf-8?B?NTVzQ3RaNWpIdnpxcUVLbGxOa2JSbnc3QVVMeDFaSjVvLzlZUElkdzBCbSsy?=
 =?utf-8?B?amxSYS9YSGVSQ0loMFNTeFpKclVUSXM5VWNZZWFJL3hvUE1LWTIvc0VmSk00?=
 =?utf-8?B?K2xTNzFoTWVqNXdFOG0rS1R0eGhIcEV6WUV6R3l5SDQzZit1YnMwNDY3Ni92?=
 =?utf-8?B?K0cyMzF0cDVvblNvYzFiaWpSVUdiVmRveGZta2t2Z0NGRkJyNEpRVVJyZjFW?=
 =?utf-8?B?UytKdGU0U1c3QzB5WEZlNmphbzVtTm1FYmxDUlVjL253aEp3K1lzd0hmUlc0?=
 =?utf-8?B?d0wwVEh3cytDaEJrSG90ODlVc1FxUGxub09NMFFnMWVtaTgvRGhEaEl2NjBJ?=
 =?utf-8?B?dGRWQTZCWHhwM0VqUTh2SUp2OHZpMTE4QXpqSXY4RXpPTzQ2UUo5SCt2a09n?=
 =?utf-8?B?cDRRa3NKYUlrT0RkSXcrektvTkNIZVh4dWMyUll2S0JKRjZOYldvT2R4MFlX?=
 =?utf-8?B?NEhpNUd3djJJbWxwUi8za1Z5V3lTcTBFWHhHdzUwYkNCT2s5c0hkU2hxeE51?=
 =?utf-8?B?U3cyZklzYzZBa2RxVHlYU2VLblY4cVlBUFJkLzE1eGtDanh2cCtRejNTWGN0?=
 =?utf-8?B?aWxPNzN3ejhTTnNkYy85L1Z6RnlRK2p2V0xpUmZ3ZEtOQW1zVkdqSitMRkw2?=
 =?utf-8?B?cS85ZlpLT2FjYXZFcXpRM3k5akxsaE4rVnRnTWs2ODhMSWt5T05aczRyK1Mz?=
 =?utf-8?B?eFVRNFB0c2txNWNBa09EN1pyb1JVSGxWM0Q0c2l6aEdycTdpYWlDRW93cjRl?=
 =?utf-8?B?VDFUeGVhay9TU3Z0dlFETExobHM3dVlSb0RibVYwOWxNVnlrZHR5NDAybWdF?=
 =?utf-8?B?dTZWekp4S0U1UEpOMGJiR3MvaWQyS0ZsN1lSajJOeXNLV1FGdUM5MWpOUFhq?=
 =?utf-8?B?OHZSUStNM3hyd0I1ZmZNTzNmSTk4ckp6bVlVaGZ3ek1yblRhZC94SERzcFkz?=
 =?utf-8?B?cENsSEJkZnZmMlhYZnRNNEppcnk4UFdQdEV6VDRwenZFSlBUa2RndHEzWXNM?=
 =?utf-8?B?MVA5Z210T0hzSi93eUxPUCtPcWkvRXU4ZnlUUlhBVVpsTHoybnhZNXlhQjdH?=
 =?utf-8?B?VXFkQ3J2clNDcytZYVlsaEY4RllTWElxS1V0NFJHSXQvQnBabmx1d3A4S0Y3?=
 =?utf-8?B?N0tjN3JrS2VMYnRlQkdoWDhxUE5lUW54MDJQOVFnalczT2kyemZ6UEJ2ZkNP?=
 =?utf-8?B?ck9TSWpvN1hTTXNoRStNYkdVY2lqTWJjYUo5ZHFMRkI5UlhCcThTOTFRNmhQ?=
 =?utf-8?B?TC9aS1MxZkx0ZjBZTDgzZllDRDFTS1hldDFMTG1QYzJFOTd1RnRzaEdxaTlj?=
 =?utf-8?B?amxFdFpwZklyWjB5bWVpcWorRmNFWk9xcWRaTld4Vk5tYnUwa0g1M21MamR0?=
 =?utf-8?B?S2ZmQ1hHZnJIZHdzbWtMSC9GMklXRzh0bmo2Sm1FRXlZaHFoVExlb0dKSXJP?=
 =?utf-8?B?dmdjYVdsWWJJZVZZZVBmL2RPWUxra0dDcjVmTXllenBNOW9EdUxkenRmaEZZ?=
 =?utf-8?B?ZGZ0VDczK1doUXoxc0NBYzBRNFdMNEUySFJaTFAvZ0cyK2NQaHR0MjJtNVJ6?=
 =?utf-8?B?TEl5RmFnRnFycjF1WGNrQ3lrWGs1eVI0ODErSGdUSWVWM1Y2RlZEeUpzWGpH?=
 =?utf-8?B?SWdvSHZGRXY5czhubHBhYUErYjlndWV0VFMrbWhQQ2ZRYXpNaDVodFIrTy8r?=
 =?utf-8?B?RE5ZQVp3bjRWbGxUOHF5ZitCa3VEZENORy9qQkRka0dBZURxaGl6RHR3RytL?=
 =?utf-8?B?akozZDVPU1N1RzF2cUJKbmV1clpqcUFmalRiTDh5ZzJ4VzErL05ES2JCNUVW?=
 =?utf-8?B?WDNOUDRFRzA2Qy81VnluQ05sZ3FvUmd0RjBUbUdyM1huRjE4Zm9VWU85NWxV?=
 =?utf-8?B?STFXSHhUUmVkeFluQzRudkFtWTIxakllSi9ra0xJeTZSa1dUV2hLbXBuNk04?=
 =?utf-8?B?Mlp6N0lETTR3Yy9ON01uN2ZURktkby9vMlIreDQwM05WOUl5VElmTmVWbU05?=
 =?utf-8?B?M1VhcFVUVE1XSjJuSmxlZEp0TEFES0tvaVkzMHJaNVh2aklpNnZTdXBWTnR1?=
 =?utf-8?B?NHc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <ACE3E6CCC1A29945BD08A6C76A77BC99@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3419.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 88319300-6d17-4d75-a149-08d9c39d6308
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Dec 2021 09:44:58.4834
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UT3sBWrVmKfQYThJgu1T1RZPmYWdrtO4a+qh39MVnW7KePgTK2Qz6Ys+3tkYNGjsu53/r05u+PKf2jjYckYygQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1692
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgSmlhc2hlbmcsDQoNCk9uIDEyLzIwLzIwMjEgMTI6MDkgUE0sIEppYXNoZW5nIEppYW5nIHdy
b3RlOg0KPiBUaGUgcmV0dXJuIHZhbHVlIG9mIHBsYXRmb3JtX2dldF9yZXNvdXJjZSgpIG5lZWRz
IHRvIGJlIGNoZWNrZWQuDQo+IFRvIGF2b2lkIHVzZSBvZiBlcnJvciBwb2ludGVyIGluIGNhc2Ug
b2YgdGhlIGZhaWx1cmUgb2YgYWxsb2MuDQo+IA0KPiBGaXhlczogMzQ4YmVjZGNjMzE5ICgidXNi
OiBkd2MyOiBmaXggImlvbWVtIDB4MDAwMDAwMDAiIG1lc3NhZ2UiKQ0KPiBTaWduZWQtb2ZmLWJ5
OiBKaWFzaGVuZyBKaWFuZyA8amlhc2hlbmdAaXNjYXMuYWMuY24+DQo+IC0tLQ0KPiBDaGFuZ2Vs
b2c6DQo+IA0KPiB2MSAtPiB2Mg0KPiANCj4gKkNoYW5nZSAxLiBDb3JyZWN0IHRoZSBjb21taXQg
bWVzc2FnZS4NCj4gLS0tDQo+ICAgZHJpdmVycy91c2IvZHdjMi9oY2QuYyB8IDUgKysrKysNCj4g
ICAxIGZpbGUgY2hhbmdlZCwgNSBpbnNlcnRpb25zKCspDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJp
dmVycy91c2IvZHdjMi9oY2QuYyBiL2RyaXZlcnMvdXNiL2R3YzIvaGNkLmMNCj4gaW5kZXggMmE3
ODI4OTcxZDA1Li41MTc3NDM1NTViOWMgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvdXNiL2R3YzIv
aGNkLmMNCj4gKysrIGIvZHJpdmVycy91c2IvZHdjMi9oY2QuYw0KPiBAQCAtNTE5MSw2ICs1MTkx
LDExIEBAIGludCBkd2MyX2hjZF9pbml0KHN0cnVjdCBkd2MyX2hzb3RnICpoc290ZykNCj4gICAJ
aGNkLT5oYXNfdHQgPSAxOw0KPiAgIA0KPiAgIAlyZXMgPSBwbGF0Zm9ybV9nZXRfcmVzb3VyY2Uo
cGRldiwgSU9SRVNPVVJDRV9NRU0sIDApOw0KPiArCWlmICghcmVzKSB7DQo+ICsJCXJldHZhbCA9
IC1FSU5WQUw7DQo+ICsJCWdvdG8gZXJyb3IxOw0KPiArCX0NCj4gKw0KPiAgIAloY2QtPnJzcmNf
c3RhcnQgPSByZXMtPnN0YXJ0Ow0KPiAgIAloY2QtPnJzcmNfbGVuID0gcmVzb3VyY2Vfc2l6ZShy
ZXMpOw0KPiAgIA0KVGhpcyBwYXRjaCBhbHJlYWR5IGluIGNvZGUuIFBsZWFzZSBjaGVjayBmb2xs
b3cgcGF0Y2g6DQoNCmNvbW1pdCA4NTZlNmU4ZTBmOTMwMGJlZmE4N2RkZTA5ZWRiNTc4NTU1Yzk5
YTgyDQpBdXRob3I6IFlhbmcgWWluZ2xpYW5nIDx5YW5neWluZ2xpYW5nQGh1YXdlaS5jb20+DQpE
YXRlOiAgIFR1ZSBBdWcgMzEgMTY6NDI6MzYgMjAyMSArMDgwMA0KdXNiOiBkd2MyOiBjaGVjayBy
ZXR1cm4gdmFsdWUgYWZ0ZXIgY2FsbGluZyBwbGF0Zm9ybV9nZXRfcmVzb3VyY2UoKQ0KDQpUaGFu
a3MsDQpNaW5hcw0K
