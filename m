Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D352C4D0AD0
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 23:17:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239416AbiCGWSb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 17:18:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343730AbiCGWSF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 17:18:05 -0500
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-eopbgr70117.outbound.protection.outlook.com [40.107.7.117])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88DAB7DAA3;
        Mon,  7 Mar 2022 14:17:09 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ip6r7+Tj8jJ7GU/JVzfV0GVmQsxQVaLA9P0SezwUY+lv/hoN67NOMrqTkFWC0YOANK7rC6fFdL2bS4r7HAMS022RsNY1HuvX6+yjV9V0smvlDLEGYA7ZqYd80xzehe0E59BluaqaBa996r1e3OifqRV+UqXBcK18Q6Ymf3P5kTcihK+vIg8VfNEfMtUXK96RmL2OvqSXibN20kk38C8KabUrIK2AXvYIVUcu3PFOEX4GsoPrSUpk7l7ENu/JS0UWobWCrZvqB4vPaDRU9ZPBx9CnUCQZCPxPtIzCQqE44Wvl0Kg43gnXB34gZw9bmsNApVFmupmulIpHPQaAGEQJVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pThASW7EkSheM3hCgws9OtDCJMlusjf5ZI0ar8AoNiI=;
 b=dCnpECmxpA+ubCV/iAUw4nYvIzyMlWMfYHe7KWex3q/7emZmHygkOHdKohrI4Sp+zDYAUEjMgpIpu9zt0iXRgSeMLqA/Lp3N4lGy3lomE7Or2PLeLYdP/lMp4zcM0V1x6LhMPGHRp5HJo2oBvXQmoT7kinlNo3sXb7eSJH5SSgxLY7tGQfBmyJF4MLDj5vvTkUtzilF4rdwlFMdfman/vcvRMMt3Y4DfFk99gph0pbDhp5O0XxyFpG7CyrGMQMzmyA3DRBumkrltyJyVzoi4nmjZ3h1yXzMcFIwmz3Kk0VOr72alt50L7XuYFkGceFzNihsGDFq5wW8ulyxMUEALJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bang-olufsen.dk; dmarc=pass action=none
 header.from=bang-olufsen.dk; dkim=pass header.d=bang-olufsen.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bang-olufsen.dk;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pThASW7EkSheM3hCgws9OtDCJMlusjf5ZI0ar8AoNiI=;
 b=dvqpgofNdriOsUvAa8cS2FailNyfimLuB9qHoiEeqpRuL147K9yxB6OqvfqM4yMV+rC8PQq2UNTsgiVzeHr0m/DMWM0NGLQou0b/C3bU1YaVu551gubE3P1znuGwUdMHP638PHD5PJkx10t+BahcfYDJs52QA9i5ouQ84r7Zf+k=
Received: from AM6PR03MB3943.eurprd03.prod.outlook.com (2603:10a6:20b:26::24)
 by AM9PR03MB6964.eurprd03.prod.outlook.com (2603:10a6:20b:2de::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14; Mon, 7 Mar
 2022 22:17:05 +0000
Received: from AM6PR03MB3943.eurprd03.prod.outlook.com
 ([fe80::6123:22f6:a2a7:5c1e]) by AM6PR03MB3943.eurprd03.prod.outlook.com
 ([fe80::6123:22f6:a2a7:5c1e%5]) with mapi id 15.20.5038.026; Mon, 7 Mar 2022
 22:17:04 +0000
From:   =?utf-8?B?QWx2aW4gxaBpcHJhZ2E=?= <ALSI@bang-olufsen.dk>
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>
CC:     =?utf-8?B?QWx2aW4gxaBpcHJhZ2E=?= <alvin@pqrs.dk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 3/4] usb: typec: add TUSB320xA driver
Thread-Topic: [PATCH 3/4] usb: typec: add TUSB320xA driver
Thread-Index: AQHYLW8v7KcQSACO90u5wFrwbstD/Q==
Date:   Mon, 7 Mar 2022 22:17:04 +0000
Message-ID: <87lexlcsrj.fsf@bang-olufsen.dk>
References: <20220301132010.115258-1-alvin@pqrs.dk>
        <20220301132010.115258-4-alvin@pqrs.dk> <YiYYa7GkknJ+CAuL@kuha.fi.intel.com>
In-Reply-To: <YiYYa7GkknJ+CAuL@kuha.fi.intel.com> (Heikki Krogerus's message
        of "Mon, 7 Mar 2022 16:36:27 +0200")
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bang-olufsen.dk;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 74162d58-6b7b-4298-f149-08da00883616
x-ms-traffictypediagnostic: AM9PR03MB6964:EE_
x-microsoft-antispam-prvs: <AM9PR03MB6964F7E0D7CEF53E2D01A1AC83089@AM9PR03MB6964.eurprd03.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ZEHBssoY71PD2g6Ddh41JwZa/LfqHD32zvLovOvX5Rc/pP4YdaRpa4o0govxsdXPlBwihMGADajC1Ji1E9OUSwTzsYZ9OTMBnQWR+V2P6YtJCJN5fEdYmSXt0enfSDnal9amTThATBYtIh6E7x8dy5nTt3p1/Ia3nBY94G/mkUv1xxZt2leCRyfu6fsU3ccCv/OViWsuPHPTXVc+ajrEwgr+lO7TxnmGNJeJbS9Mmh2+rfBs0jf4+/qupO/LqaTPS76Ge8S0EVoTSCyGnxzA0LQM6++9scXM110LRTNvAe5Hio3NdvT9JWpBVzN1ssRxL0dKPTNQkW9djjNk7WLuBUXJSJSV9fn4R9U01MMgkpZakpV9JdTfPtPz1mIEmag9Unc0shnJp6SrTowPjJqxI9IK+HZ86hLWCEcSuBIjerXY/WezqX0zn0wP4BcNCicrIvPvumj5/Zd20WB6UJbnpnka5rdFxdaMpHQMvFwdlUXMQdgUQmg+MBQLjw9fsyi5DdwrbHjdZBN3T+R+65nJKsKNp2zEG+4rkDp0vpd+BMqdgQXgsFIdeHPEQzo1dKj40Qh+1hO8cNKsNbvXF+JfLlf/ncCXwk5ilsJLAqEfz09cacBRb/3Px1vej96nDAqHh1M7lBCffMjwjqZs19mRFisnuHCKLf7sSUH08/IpVSt6qpS8hteQpVi2nugFHekRGUTC4usAFWuX5E4zBKKZSA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR03MB3943.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(64756008)(66446008)(66476007)(66556008)(8676002)(316002)(76116006)(66946007)(4326008)(6916009)(91956017)(54906003)(36756003)(85182001)(85202003)(86362001)(2906002)(38070700005)(38100700002)(5660300002)(8976002)(8936002)(122000001)(6512007)(71200400001)(6486002)(6506007)(508600001)(186003)(26005)(2616005)(66574015)(83380400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?b2Z1VkxYaG9qWm1Sdm92UkMyNUhKcWhOUndDK3NsallLN3hMUzE0YzNtdlFt?=
 =?utf-8?B?UDZFVC9rbUtWaXRxTmRMSGJYWmlWakphcEZKQk1GcHFaWUxFdDRhTUFLbTFY?=
 =?utf-8?B?N1VnK0lKbWlWeW9pSHJwOXdUS1IzOWhNaGpZVDBlRXNjKy9WQStqa2l4Snhq?=
 =?utf-8?B?U2ZBK0RBOVdsUWVZKzMwWFk3b1dia21QblBCZUJkR2hiNXhXNnJYN0xYMk1P?=
 =?utf-8?B?WWUxdVlvVFNwbXNTZU96bG1IZWZBTkJRODU0UTdaOFNpdkJwdkJ5V0h5NWMx?=
 =?utf-8?B?L3p1bmdheng4SWdFM1gvSkl4MFZ2ZDlTUUo4a2VnbnI3QzVTT3NnSFJYWXpY?=
 =?utf-8?B?MU95Wm1qWWRjQ241MGVvZnFjY1RUUGJtbHY5ODhRaHFVYkllQjRrUnRaZ1J3?=
 =?utf-8?B?Zk9uTklacTduZkRQRlgzQzBtSGovVC9ibk11ZklaenNSK1hlYitPWHVVTzJT?=
 =?utf-8?B?dXBzcXovaW5nL3QxZVRQdFpoSzgyajE3a3dwSVBjVXR3aDdrUS9NK1RpdTlN?=
 =?utf-8?B?am83TU56ZHpjdUVaTzFlUU5xc0NZUTRvZzBZeUpadlcxUVVScEtTaWpMN1FH?=
 =?utf-8?B?SmtkWm5qdUtHOWZYU3J4Y09MbU04VHlFNkJVRjdkM29zQ2VpalJxT2R2Q1Qy?=
 =?utf-8?B?RUowcURsbVJEMGQ3ekVoVFBxNEZiUi8veVg5TGs0TXpFYmJhUVFWYnVieUtr?=
 =?utf-8?B?VDh2NkR4S2hmNEo3cTNYZDFlT3VobXBxSlRtY2p2VzlFNkNlVUtsUmdDLzdV?=
 =?utf-8?B?d2ZMc1plcFlEczQzVWd4ZDZZQjMyOW1zSmZWODh3NCs3NS94R2FmejJvV3Vo?=
 =?utf-8?B?cFRyYzNqb01LYXF1alRHYjhYcTlxTGhsYXk3OTlFY2FlUUY1TE1lRkJ3Ykwv?=
 =?utf-8?B?bWd1dmEzZC9qTEVBT0ZReWlKQzRnQjhQWElVaVI1bmhaaktpZmtJdWdRc242?=
 =?utf-8?B?a2pIN1ZuRHVmVjBlc1lyaW0wOTFWeGl3ck5PNitQWTNsYzM0enZMK1BseWE2?=
 =?utf-8?B?MnhRdXNxRzhsYnFkcGoxTjMzTWVxRUgyQk5yRXd3bGpYS0RkS2lxR2ZSOTJJ?=
 =?utf-8?B?eXNNMWhRSGRTRlN6N0ZtSFF3SjBPc3N6MlJXMEttUllkL1EzSlN4RHppM2hn?=
 =?utf-8?B?WjhBeDlnMjYrNVlTNUd4UkdOdmVPSW1semhkNCtEbU5TQWtVd3dUSnd5aXV1?=
 =?utf-8?B?dk55L1N2NFdmaklCUjVydjBicFNFN0hSUnZtOE1VZ2JVQm41Q2FRTDE3KzNB?=
 =?utf-8?B?bzc0WXpmWlgrbUtxSFVha2xFRlE3TXlzZURxQm5NVGZpVGZXRDRWdGdrVk9i?=
 =?utf-8?B?VjFBdHE2d2tkZlNmb3kwZDhGUHJnZHdIN1VESmdyOSt4LzBub29vZDJxeDlj?=
 =?utf-8?B?TzNiMDEwYUlvaDdBcS9qWjc5ZnJZOWErWmdtbUZhY3MydlVoLzhkT0xmRFZJ?=
 =?utf-8?B?NWh1NmlWNTJtOXlONDNuM1VHak5jUHdHNkdrRmJwMW5acjRmcXhaUG9EcE1k?=
 =?utf-8?B?T1Uyc0RtR3JNREJvYTE3eEp4ZDdrVlp5S3hsQ1dqMjczcHJaV3IwUFdScTRM?=
 =?utf-8?B?USt4eVJ6dEhYTEg5NUozbk0zM1J3SkNmQXdTQzEzYkVIK1RSWUFFTGdHTWtE?=
 =?utf-8?B?NHlPZ0NLTW9pL3NkOGFYV0VDVWZDbTF3b3JUanN0T0tYRHh1VlI1UHVjN0pi?=
 =?utf-8?B?T1gxUkFMd3Qyc2NSdjZBR1dsOUI2QUV6clE5YkI5Z0dwL3NyVkxqcWp1OWlx?=
 =?utf-8?B?eHJRWlhJV1BOZzlQVGZUbFNhVC8xK0hhTHlwc0hxaHpKbEdNc1RxRVU4SFBO?=
 =?utf-8?B?ME5ZcGxmc1hOOVJFQlNOdFZaMmdsV0tEam9vakN5TUxsUW5qOEgrUDBvYmFh?=
 =?utf-8?B?UEpVYnI3amxWN1dvTWlZdS9IcG5QMGhraTIzRDZIQlpyRUpZdzROMFZESXV6?=
 =?utf-8?B?ODZxRTFIcTlGcGc0OWpPNkQvUi9KMk1xdjZkNkFCa2ZIWWlQbWpNUDBEZGlC?=
 =?utf-8?B?YUVHZEFFa1NDcHBZWERCYTVvRDV3KzA1ZjNFK3Q3V2lOU2NscFZhcVV4b2lX?=
 =?utf-8?B?c0R1Z0VqcnhzN201ZWgycVB3MldKMThiZjVXdjNaSEpqRFhLbmJRL3l5T3ZV?=
 =?utf-8?B?MnRKdnJNakRsaDNhWkVDdlJSbXFGTVU4ZU5veGwwYWdMT25VVXI2U3p5VWZB?=
 =?utf-8?Q?sHREgxitbJUOS/4OynAlAWY=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <892BC636A7A22B48A473D815F5A47D97@eurprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: bang-olufsen.dk
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM6PR03MB3943.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 74162d58-6b7b-4298-f149-08da00883616
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Mar 2022 22:17:04.8434
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 210d08b8-83f7-470a-bc96-381193ca14a1
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LaIDiKQnOOlSG5l9+LXh1l/Wbr6wJmQzoOV88DYDKbaIbyNM23wQVEmaHCYMJPi8PXhrZKzo2vukvun5qhMl0Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR03MB6964
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgSGVpa2tpLA0KDQpIZWlra2kgS3JvZ2VydXMgPGhlaWtraS5rcm9nZXJ1c0BsaW51eC5pbnRl
bC5jb20+IHdyaXRlczoNCg0KPiBIaSwNCj4NCj4gT24gVHVlLCBNYXIgMDEsIDIwMjIgYXQgMDI6
MjA6MDdQTSArMDEwMCwgQWx2aW4gxaBpcHJhZ2Egd3JvdGU6DQo+PiBGcm9tOiBBbHZpbiDFoGlw
cmFnYSA8YWxzaUBiYW5nLW9sdWZzZW4uZGs+DQo+PiANCj4+IFRoZSBUVVNCMzIwTEEgYW5kIFRV
U0IzMjBIQSAob3IgTEFJLCBIQUkpIGNoaXBzIGFyZSBJMkMgY29udHJvbGxlZA0KPj4gbm9uLVBE
IFR5cGUtQyBwb3J0IGNvbnRyb2xsZXJzLiBUaGV5IHN1cHBvcnQgZGV0ZWN0aW9uIG9mIGNhYmxl
DQo+PiBvcmllbnRhdGlvbiwgcG9ydCBhdHRhY2htZW50IHN0YXRlLCBhbmQgcm9sZSwgaW5jbHVk
aW5nIEF1ZGlvIEFjY2Vzc29yeQ0KPj4gYW5kIERlYnVnIEFjY2Vzc29yeSBtb2Rlcy4gQWRkIGEg
dHlwZWMgY2xhc3MgZHJpdmVyIGZvciB0aGlzIGZhbWlseS4NCj4+IA0KPj4gTm90ZSB0aGF0IHRo
ZXJlIGFscmVhZHkgZXhpc3RzIGFuIGV4dGNvbiBkcml2ZXIgZm9yIHRoZSBUVVNCMzIwIChhDQo+
PiBzbGlnaHRseSBvbGRlciByZXZpc2lvbiB0aGF0IGRvZXMgbm90IHN1cHBvcnQgc2V0dGluZyBy
b2xlIHByZWZlcmVuY2Ugb3INCj4+IGRpc2FibGluZyB0aGUgQ0Mgc3RhdGUgbWFjaGluZSkuIFRo
aXMgZHJpdmVyIGlzIGxvb3NlbHkgYmFzZWQgb24gdGhhdA0KPj4gb25lLg0KPg0KPiBUaGlzIGxv
b2tlZCBtb3N0bHkgT0sgdG8gbWUuIFRoZXJlIGlzIG9uZSBxdWVzdGlvbiBiZWxvdy4NCj4NCj4g
PHNuaXA+DQo+DQo+PiArc3RhdGljIGludCB0dXNiMzIweGFfY2hlY2tfc2lnbmF0dXJlKHN0cnVj
dCB0dXNiMzIweGEgKnR1c2IpDQo+PiArew0KPj4gKwlzdGF0aWMgY29uc3QgY2hhciBzaWdbXSA9
IHsgJ1wwJywgJ1QnLCAnVScsICdTJywgJ0InLCAnMycsICcyJywgJzAnIH07DQo+PiArCXVuc2ln
bmVkIGludCB2YWw7DQo+PiArCWludCBpLCByZXQ7DQo+PiArDQo+PiArCW11dGV4X2xvY2soJnR1
c2ItPmxvY2spOw0KPj4gKw0KPj4gKwlmb3IgKGkgPSAwOyBpIDwgc2l6ZW9mKHNpZyk7IGkrKykg
ew0KPj4gKwkJcmV0ID0gcmVnbWFwX3JlYWQodHVzYi0+cmVnbWFwLCBzaXplb2Yoc2lnKSAtIDEg
LSBpLCAmdmFsKTsNCj4+ICsJCWlmIChyZXQpDQo+PiArCQkJZ290byBkb25lOw0KPj4gKw0KPj4g
KwkJaWYgKHZhbCAhPSBzaWdbaV0pIHsNCj4+ICsJCQlkZXZfZXJyKHR1c2ItPmRldiwgInNpZ25h
dHVyZSBtaXNtYXRjaCFcbiIpOw0KPj4gKwkJCXJldCA9IC1FTk9ERVY7DQo+PiArCQkJZ290byBk
b25lOw0KPj4gKwkJfQ0KPj4gKwl9DQo+PiArDQo+PiArZG9uZToNCj4+ICsJbXV0ZXhfdW5sb2Nr
KCZ0dXNiLT5sb2NrKTsNCj4+ICsNCj4+ICsJcmV0dXJuIHJldDsNCj4+ICt9DQo+DQo+IENvdWxk
bid0IHRoYXQgYmUgZG9uZSB3aXRoIGEgc2luZ2xlIHJlYWQ/DQo+DQo+ICAgICAgICAgY2hhciBz
aWdbOF07DQo+ICAgICAgICAgdTY0IHZhbDsNCj4NCj4gICAgICAgICBzdHJjcHkoc2lnLCAiVFVT
QjMyMCIpDQo+DQo+ICAgICAgICAgbXV0ZXhfbG9jaygmdHVzYi0+bG9jayk7DQo+DQo+ICAgICAg
ICAgcmV0ID0gcmVnbWFwX3Jhd19yZWFkKHR1c2ItPnJlZ21hcCwgMCwgJnZhbCwgc2l6ZW9mKHZh
bCkpOw0KPiAgICAgICAgIC4uLg0KPiAgICAgICAgIGlmICh2YWwgIT0gY3B1X3RvX2xlNjQoKih1
NjQgKilzaWcpKSB7DQo+ICAgICAgICAgLi4uDQo+DQo+IFNvbWV0aGluZyBsaWtlIHRoYXQ/DQoN
CkkgdGhpbmsgaXQncyBhIGJpdCBjcnlwdGljIC0gYXJlIHlvdSBzdXJlIGl0J3Mgd29ydGggaXQg
anVzdCB0byBzYXZlIDgNCm9uZS1vZmYgcmVnbWFwX3JlYWQoKXM/IEkgY291bGQgYWxzbyBqdXN0
IHJlbW92ZSB0aGlzIGNoZWNrLi4uIEkgc2VlIGl0DQptb3N0bHkgYXMgYSBjb3VydGVzeSB0byB0
aGUgdXNlciBpbiBjYXNlIHRoZSBJMkMgYWRkcmVzcyBpbiBoaXMgZGV2aWNlDQp0cmVlIG1pc3Rh
a2VubHkgcG9pbnRzIHRvIHNvbWUgb3RoZXIgdW5zdXNwZWN0aW5nIGNoaXAuDQoNCkJUVywgZG8g
eW91IGhhdmUgYW55IGZlZWRiYWNrIG9uIHRoZSBkZXZpY2UgdHJlZSBiaW5kaW5ncyBvZiB0aGlz
DQpzZXJpZXM/IFJvYiBoYWQgc29tZSBxdWVzdGlvbnMgYW5kIEkgYW0gbm90IHN1cmUgdGhhdCBt
eSBwcm9wb3NlZA0KYmluZGluZ3MgYXJlIGZ1bGx5IGFsaWduZWQgd2l0aCB0aGUgdHlwZWMgc3Vi
c3lzdGVtIGV4cGVjdGF0aW9ucy4gQW55DQpmZWVkYmFjayB3b3VsZCBiZSB3ZWxjb21lLg0KDQpJ
IHdpbGwgd2FpdCBmb3IgbW9yZSBjb21tZW50cyBhbmQgc2VuZCBhIHYyIGluIH5hIHdlZWsuDQoN
CktpbmQgcmVnYXJkcywNCkFsdmluDQoNCj4NCj4gdGhhbmtzLA==
