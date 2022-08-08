Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6953258C364
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Aug 2022 08:38:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236814AbiHHGij (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Aug 2022 02:38:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236421AbiHHGia (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Aug 2022 02:38:30 -0400
Received: from AUS01-ME3-obe.outbound.protection.outlook.com (mail-me3aus01olkn2162.outbound.protection.outlook.com [40.92.63.162])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D988B11C10;
        Sun,  7 Aug 2022 23:38:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hnP0W7mEXasexPP6P1T2ueDpyEljgGjwTSEDTNMD6ry1PPuOjIQKrl/7vLIp3qfbteeEr/gZx4YLfnT7J0ASIUOrOcBpuTrVLggHMy2Cysm3nMg3mRsNFd/leQDarVoS70PzdE+yhQErZhu36+/hqq5tF9loWw2I/zjRLeklngkYtecsYPFkp5tUM6tPs2L85QJ2OrmWV4RmbdTH8tZioDf9xFDfBLUnwAthzk8py/65We9OzI2k4880xJ+YZ0lEgG3FI7ZOhuYXhTiac83C8cBIS2Z6zk+zIxATIcz/oE8WaltxDLhL6k9ozZSnoX1ygAHIR9MYr5DujxFlpgwVjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vLPiZg1lSA9UNpv6Qk6ETk/zumj0PN+/hrwSbvlTJbw=;
 b=SK0hxAtImUxwwtkBAjEv3oEJNE+Mt8uSTAsxn330/bKqFhPd9lULeJixQG6HeK8yeFH40PDNcWyDnwpetDT15fBBHSWVTt1tHCksc1oAGv2zTkuMo1IXfzUCmD3yj4348yH+MSJ7dzl1q9PcEELa0rExdpnAkMIoqA2Bsy21Jq49P0v+ViBGj2tzU7+Tss2E6krOIq1TSjEP5UunK5AqRoqVZfnhTpQsdoP2RFPVIIvufnM8W51hhB0mwIq6ohoUFJOXueTv1ycrT0sny41iYdLRkNl3bZmGwNIhsqI+XUgdEeuNx8JBmYJbrjNKPEISBDFfeqMuaqGm1uTFLuDZCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vLPiZg1lSA9UNpv6Qk6ETk/zumj0PN+/hrwSbvlTJbw=;
 b=dbNI/DosqVRnrD0JFn96GU4iXu9N+SJ+TIrtFz2XPLAEx2+saySGgClJ08+NKvlx32j1WlPO2/xDgIoE1MXFnyng2dpCB8YSE+gVyLPymEXAiqrwYW7xwc6VwcMoSxsMQ+Tf7ov04e44L8M/8JS+WOqgB9gFcI1QrNd7DSGLsWMj6djAN5Ml4Js3kIyjm5aFF1W8M+lFBXWPJ/woGaY6s34VVna62gYL6iF0qvO4OCHHFtNwtWvGWPXi/M4bSvOe4PemsYM/R30jltny70rzBO1iXbyYvPIF4NjScGbra+LhSSSpYCIsfS0ma1oWbHhSicfHLLuoKzhhRrtOU1k4mQ==
Received: from MEYP282MB2374.AUSP282.PROD.OUTLOOK.COM (2603:10c6:220:113::14)
 by MEAP282MB0501.AUSP282.PROD.OUTLOOK.COM (2603:10c6:220:6f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.15; Mon, 8 Aug
 2022 06:38:25 +0000
Received: from MEYP282MB2374.AUSP282.PROD.OUTLOOK.COM
 ([fe80::c41b:d5b5:34ae:589e]) by MEYP282MB2374.AUSP282.PROD.OUTLOOK.COM
 ([fe80::c41b:d5b5:34ae:589e%7]) with mapi id 15.20.5504.020; Mon, 8 Aug 2022
 06:38:25 +0000
From:   =?utf-8?B?6LCtIOawuOaelw==?= <yonglin.tan@outlook.com>
To:     Johan Hovold <johan@kernel.org>
CC:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: =?utf-8?B?5Zue5aSNOiDlm57lpI06IFtQQVRDSF0gVVNCOiBzZXJpYWw6IG9wdGlvbjog?=
 =?utf-8?Q?add_Quectel_EM060K_modem?=
Thread-Topic: =?utf-8?B?5Zue5aSNOiBbUEFUQ0hdIFVTQjogc2VyaWFsOiBvcHRpb246IGFkZCBRdWVj?=
 =?utf-8?Q?tel_EM060K_modem?=
Thread-Index: AQHYm2KhAS3C3XZt+EKChgLsF2Qvi62NO3AAgAlYx8CABljJgIAHvbHg
Date:   Mon, 8 Aug 2022 06:38:25 +0000
Message-ID: <MEYP282MB237442B77909EB1FEC56AA2BFD639@MEYP282MB2374.AUSP282.PROD.OUTLOOK.COM>
References: <MEYP282MB23740DC78FB0DE954C59D3DEFD8F9@MEYP282MB2374.AUSP282.PROD.OUTLOOK.COM>
 <Yt0FnnVh47y8aMtn@hovoldconsulting.com>
 <MEYP282MB237488A1AB2C7A9B4DA7B880FD989@MEYP282MB2374.AUSP282.PROD.OUTLOOK.COM>
 <Yuovy5ukT9V1ydKS@hovoldconsulting.com>
In-Reply-To: <Yuovy5ukT9V1ydKS@hovoldconsulting.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-tmn:  [FT9r37dDq/aTbjfXYzg4TueRSkCm4Ope]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0121fbd9-f2bb-4c5d-b441-08da7908989c
x-ms-traffictypediagnostic: MEAP282MB0501:EE_
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: OZIPiMayQ/bfzE4BE+RN1fu+Q8pX+E4a+wEiCrGqS34YwBMFmGCbDf1hdAlYM0exDc4IVipVZcZRzRSg4Ybfc2OhL4vBgfjZ3vKMrGu8rqMGAc7FiBA6KAAhh+Xwj8beTliIiRRf6JqcoPKyCh3Kl7CwRYzMRY2i+NOTa+fNYMuJ5Uh5DdNRsdqjFlK8lLGiU1PkdKuinAy+eQIZEW42i4oiB+zFxdJr0CsLscCbFBIt+ryKNhOBRtbH2CLaWj5WftfqBdPOlwH1Az4UyE4/gSNveu4SgHSN0iKbY9vrNZCLrq7GNT1AaOgUhFjAY9k1Ck79sJp6gecYzWsyfqaql1oODi/0gV/ncY+sX71IDEdhpvaK7qZiBo5nNEQ7ZHfZ3tPacl++1d1vl0ordsyfTF2UC1h+jWCrG537Ra7gZZlNRmVlk2zWVq7TwR26Akg0x6FW4plAwzlBBEUy20Ftd5M0ytfKlzGPdf2BbJz8XQQxKYX1D8OP8NfVjmEUPURRe7bRSixhOImda5OHu6yPUrWbQ+SWwcJaQuyHQTU8QWxqG9wwJnw/lElQlaukivgc+7151FTDLLIbYc7GmYF0vc2DDgkswFGdPVDQIUrHvdXjs5vHobqnoHHUm0fbZ1aKifLCqIBa6Vtt5C1FN76GGw==
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?U1ZEK2FxNFltZ1JHbFRuNUtoOHU3RytmL0Q1cDJ1THF1RVB6V3lEeU1SQTJq?=
 =?utf-8?B?cXIzRlJkUWZsT09hOFRWZzdTZWZJOEI5RVRnMjNJS2trVU14RHA2b0hFYjRR?=
 =?utf-8?B?K1MvMkprRkdKb0hUZGMxV3hiV3lwQUxEcVpiSVVZUGFIbCt4bi9nOE96NytH?=
 =?utf-8?B?VHRmQ2JmZHV2MEVyUDdQSWl5ZWZkUmNCaEs3eDFrOTlnNTRsVnhQY01Ndnoy?=
 =?utf-8?B?bzVXRVZtTmRIRXB0blo5Q0VmMkZ5cmJiNFZhUlhZWWVoeHdaNzBIUFc1S3I1?=
 =?utf-8?B?aHk4MUJmOE84WVRicnI2RzNzaTVsS25vQ2EveUIvVVJteFFYSDhvRjY0cXZE?=
 =?utf-8?B?YU0vemZ4WnJpTkUrNVQvSFZuS1M4N0hneDE4MlJEbGsvSXFFbVVsVGFtQUhv?=
 =?utf-8?B?aG55ZkJDaVg1WWZBZXN1QzFlY2Y1YjRBYTJFMUZCK09yTW91a0hhUk82WUNW?=
 =?utf-8?B?K3l5b3AyZlUvUEdCNDhEVWJmc1kyMXdRRFFjM1NqYllOWnZuY3R2eC9PWGY0?=
 =?utf-8?B?U1BHUWQ4aWs5a2hYd01UNzMrNzlTU1RJWVNXMHlNeWQ4SkEvNDY2Y0x2cWk4?=
 =?utf-8?B?YnJnL3lBaWY5MC9IRXN1SUQ2RUVzczRtZm9HckhsYXZ3M0Y3bXR5VURCUGpS?=
 =?utf-8?B?MHJrMHp6UUEzcmU2c3RSNlkvRmhBaHJnT2tjRVJSbmUwMkhja0NsTFZMZFFV?=
 =?utf-8?B?SWZrdFIwdVdMZEllRW5zSHF5RDRjS0NiajluRldmWS9kTWs3Y0xrSVFkNkdP?=
 =?utf-8?B?dTlPZ1hSVU80Q1VISXVOOENuczRNUEE5aXhwWFVkd0NDenB1YkVwUjJnTDR0?=
 =?utf-8?B?b2tLSmFIUDRUM1Y3MWh4ZEpUbU0xdFQzRlduME9tL1JXRHhRN1hCMHcxOThN?=
 =?utf-8?B?d2FBT1JQK0xDR08zQ0xMNEdWUDBPR2I0by9TOEloVGswc0hZbzRyUnFTUzlC?=
 =?utf-8?B?Tzg2d0NnMTB5WU9jMDY0RlNWVldXeStGTGkxL00wc294UFR6c2J2SmZ4MVJw?=
 =?utf-8?B?b3JFSVVRK2Mvd0RiY093Z1plamorT2hPZnc3TkowNG1Zai9NMlA2a2d1d3RX?=
 =?utf-8?B?cE0zWXBOSHpzTk9ZQ21IanZPUHR6TFlFczRYcW9xcUlvQ1NCRG9JRTgrLzdt?=
 =?utf-8?B?QzJyTHpYNWQ0RW9tVWZvaHAvQWptelZ6Z09qby9aR2xqcnJoWXRkZTN3OW5s?=
 =?utf-8?B?eTh5SVd4MVY3TlNmL1BHVEhFUlBYS3BVdTluZ1c4eXdWMmhZOFIvaEhpUllW?=
 =?utf-8?B?Qm4yUXNSbWZySTgvek1LV3pBcEFybDNRcm1CQ1kzYVZWOVJ2aVArY1J1NFdm?=
 =?utf-8?B?Zkl1OUZheTFad3gxbklXdmgzNkVnYlU4RWJFNWtUWkhGMlk1blpjaXpkVzVX?=
 =?utf-8?B?a3NYMUdUQ1Nyc1lvZXhHNlNTa0w1dmUvb0Y0UnVkZDlRV0tLYXI1N0IxSE03?=
 =?utf-8?B?RWhjdzA4RjRaSTYxUnlJK2M0QitYcFl2WmZwN21xeFN0bU9QMm9iWDc4TkFj?=
 =?utf-8?B?Sk4vQ1NqaWoyalViMHc2NVpObjlZYjhobkt6WjdlRGd0aG9SUUo3Y2pXMm9n?=
 =?utf-8?B?eWJreU85VWgzamtBdnl5WktCcEN3NDlPcTAzbG0ySnh3NjJTK1N3cDREQmd0?=
 =?utf-8?B?MENwWlhJU3pPWExXR2VES1dDZ1hmd1hnMFlvYkZ6RjhWSmFHMldhODVsL0o5?=
 =?utf-8?B?cnYzUG01M0FndFFjN0duQmdXNDNUWUxUWjVnWXMxYmswcDVJcHY2eFl3PT0=?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MEYP282MB2374.AUSP282.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 0121fbd9-f2bb-4c5d-b441-08da7908989c
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Aug 2022 06:38:25.2827
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MEAP282MB0501
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RGVhciBKb2hhbiwNCg0KVGhlIFFEU1MgcG9ydCBvbmx5IGJlIHVzZWQgZm9yIGNhcHR1cmluZyBt
b2RlbSdzIGxvZy4gVGhlIHVzZXIgYXBwbGljYXRpb24gYWNxdWlyZXMgdGhlIG1vZGVtJ3MgbG9n
IGJ5IGFjY2Vzc2luZyB0aGUgQlVMS19JTiBFUC4gQW5kIG5vIG90aGVyIG9wZXJhdGlvbiByZXF1
aXJlbWVudHMgb24gdGhpcyBpbnRlcmZhY2UuIA0KDQpCZXN0IFJlZ2FyZHMuDQoNCi0tLS0t6YKu
5Lu25Y6f5Lu2LS0tLS0NCuWPkeS7tuS6ujogSm9oYW4gSG92b2xkIDxqb2hhbkBrZXJuZWwub3Jn
PiANCuWPkemAgeaXtumXtDogMjAyMuW5tDjmnIgz5pelIDE2OjIwDQrmlLbku7bkuro6IOiwrSDm
sLjmnpcgPHlvbmdsaW4udGFuQG91dGxvb2suY29tPg0K5oqE6YCBOiBncmVna2hAbGludXhmb3Vu
ZGF0aW9uLm9yZzsgbGludXgtdXNiQHZnZXIua2VybmVsLm9yZzsgbGludXgta2VybmVsQHZnZXIu
a2VybmVsLm9yZw0K5Li76aKYOiBSZTog5Zue5aSNOiBbUEFUQ0hdIFVTQjogc2VyaWFsOiBvcHRp
b246IGFkZCBRdWVjdGVsIEVNMDYwSyBtb2RlbQ0KDQpPbiBTYXQsIEp1bCAzMCwgMjAyMiBhdCAw
NzozMjo0N0FNICswMDAwLCDosK0g5rC45p6XIHdyb3RlOg0KDQo+IFRoZSBsYXN0IGludGVyZmFj
ZSBpcyB1c2VkIGZvciBRdWFsY29tbSBXV0FOIG1vZHVsZSdzIFFEU1MoUXVhbGNvbW0gDQo+IERl
YnVnIFN1Yi1TeXN0ZW0pIHBvcnQuIFVzZXJzIHVzZSB0aGUgUURTUyBpbnRlcmZhY2UgdG8gYWNx
dWlyZSBNb2RlbSANCj4gc3Vic3lzdGVtIGxvZy4gSXQgaXMgdXNlZCB0byB3b3JrIHdpdGggRElB
RyBwb3J0LiBUaGVyZWZvcmUsIHdlIGRvbid0IA0KPiBoYXZlIHRvIGJpbmQgdGhpcyBpbnRlcmZh
Y2Ugd2l0aCBhbnkgZHJpdmVyLg0KDQpUaGFua3MgZm9yIHRoZSBkZXRhaWxzIChJIGNhbiBhZGQg
UURTUyB0byB0aGUgc3VtbWFyeSBvZiB0aGUgaW50ZXJmYWNlIGxheW91dCBpbiB0aGUgY29tbWl0
IG1lc3NhZ2Ugd2hlbiBhcHBseWluZykuDQoNCkJ1dCBhcmUgeW91IHNheWluZyB0aGF0IGl0J3Mg
bm90IG5lZWRlZCBiZWNhdXNlIHRoYXQgZGF0YSBpcyBhdmFpbGFibGUgYWxzbyBvdmVyIHRoZSBE
SUFHIHBvcnQ/IE9yIGlzIHRoZXJlIHNvbWUgbGlidXNiIGRyaXZlciB0aGF0IHNob3VsZCBiZSB1
c2VkIHRvIGFjY2VzcyB0aGUgUURTUyBwb3J0Pw0KDQpKb2hhbg0K
