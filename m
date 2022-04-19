Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7DB650666D
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 09:59:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349682AbiDSIBj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 04:01:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239532AbiDSIBf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 04:01:35 -0400
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-eopbgr80059.outbound.protection.outlook.com [40.107.8.59])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 878651B7B0;
        Tue, 19 Apr 2022 00:58:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nqw+mjCkYGSiE36sEfR4tIuFP7rEXHOTQAkzsFxmQShlYPSpAB50Ep9k5PhQChH6LbOHt6uTZSGEWXBh/08G35739SGqTbbgrrUad8CoB8W5PMCygMYcT65/wGO6iMRc7YMN6aLOmUyosAji+kvv4Hh8++yOKlHYKmDAeBdOOumW4wMQtlCcBp+rYZZX/PXp+UZ8DlZG7/N5c6Zu/a4IHLasSssTsCDtsvaK7MjBqteKmjVM6IjtefC8t2hJbsvmaEzSh97Hc4EAfCnE9aEfDAWadKLdh2WW7vCLSZCyQkb6m+1SJG6GvisWEMoqfihQt3tEKw2JAhd0kRL+NPelLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mZEoViXYLecACRJG3bO3qkWvWdoFC5JRovvXgT3veH8=;
 b=EYfiRTFFug1ljYQr+I5AhU0WgYhNDhlQFnVIQKhJWsxlIw3MJkdrRXPV74MPUcmlnjD2MAQnRhJ2deXpoLOtO6gLW7BvGb8cS2Cf7rrh4hmDXOQUSkzskBDZ+1h6NnndGVqxb+lH32YJU1zkjxbthgCUBS0h9pE0+kVORwlitj+/EJ9RzmV438LbPj3KibXdHXf6suxZLoSF0HsD0Z9S69Mny7C+5yiQwrLomMqOhuO4mfbHFBLJwnELybbOFzQgiBRa5r73WFcbR6tduhUq/y1cTh4BZZPTp0fBPsogORr0OpUHADU3Vk2YZpBpR0YSc4osD3nsBgaSf881Du5z3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mZEoViXYLecACRJG3bO3qkWvWdoFC5JRovvXgT3veH8=;
 b=G+SqXPnLqX8ocyle0/B4VJr/8brzvi5+mGi2UGLBqMwq71Q2SY5hGpwaFa4BP3U9Ye55b7Za7D0arhN9+a2SXi+Lm90AlcfTY3IxSVFcHVFdZNt78xLZtLFAL7xohc4LsKL6x3FyH01b5KxPEZhdeWJ+PeHvGKcK0Xm/bn4LRQYrhipCuxV8KGfmvbs9MxBPV4LxXFuXhdK7oPJn8JpaMeBeBvW37S5RpInc/GFoZznWT+HLJKvZe2IwdvOpdXrsdZNiiASco3E4rCis9UgGtKcuVtMaptfVnSCHe6UxnN6nk0OvfI89vWHza5KkMFKTMNLPgVXtJ9lc5UdmVi835A==
Received: from AM4PR1001MB1378.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:200:98::12) by DU0PR10MB5432.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:32b::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.25; Tue, 19 Apr
 2022 07:58:50 +0000
Received: from AM4PR1001MB1378.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::750a:d1ed:d78b:5fa2]) by AM4PR1001MB1378.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::750a:d1ed:d78b:5fa2%3]) with mapi id 15.20.5186.013; Tue, 19 Apr 2022
 07:58:50 +0000
From:   "Starke, Daniel" <daniel.starke@siemens.com>
To:     Greg KH <gregkh@linuxfoundation.org>
CC:     "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        "jirislaby@kernel.org" <jirislaby@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 19/20] tty: n_gsm: fix wrong behavior of
 gsm_carrier_raised() on debug
Thread-Topic: [PATCH 19/20] tty: n_gsm: fix wrong behavior of
 gsm_carrier_raised() on debug
Thread-Index: AdhTwzscyv6z3nbXTuCPn/aeB5TcmA==
Date:   Tue, 19 Apr 2022 07:58:50 +0000
Message-ID: <AM4PR1001MB137887B7DED65A1B360381FAE0F29@AM4PR1001MB1378.EURPRD10.PROD.OUTLOOK.COM>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_a59b6cd5-d141-4a33-8bf1-0ca04484304f_Enabled=true;
 MSIP_Label_a59b6cd5-d141-4a33-8bf1-0ca04484304f_SetDate=2022-04-19T07:58:49Z;
 MSIP_Label_a59b6cd5-d141-4a33-8bf1-0ca04484304f_Method=Privileged;
 MSIP_Label_a59b6cd5-d141-4a33-8bf1-0ca04484304f_Name=restricted-default;
 MSIP_Label_a59b6cd5-d141-4a33-8bf1-0ca04484304f_SiteId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;
 MSIP_Label_a59b6cd5-d141-4a33-8bf1-0ca04484304f_ActionId=8d8bad4c-681c-4af1-abe7-025048d6c277;
 MSIP_Label_a59b6cd5-d141-4a33-8bf1-0ca04484304f_ContentBits=0
document_confidentiality: Restricted
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4a042363-e0c8-4737-5724-08da21da70f9
x-ms-traffictypediagnostic: DU0PR10MB5432:EE_
x-microsoft-antispam-prvs: <DU0PR10MB5432A8E6F0405D299ACF3EA7E0F29@DU0PR10MB5432.EURPRD10.PROD.OUTLOOK.COM>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: e4SqtgQQlbf2ioCFbMAUxYdJmhJXQzAY+lRvkIu9lWvoeSpwl/iWB/8qgMtB2ADMkuTFT8NQfJj4+a/+0zIiobkBjDhcTD+foes4qYHBv423uOHFwVITY+DqNdj1aXnj24DAduxW7Hyum0c+DxX6tPgu+sABGq/u/a/PsyARL1DPYSLMuNSim8hnPRj+GbVndG+rDv63pM7E2Yjhp8pPUjOgMuMATM1hbeC6gYBFfXwJu5hmXKPpZ8Sup7p3yLBX4oUceeka3BHmXxxrl09JzZ69AvNJp8f8Cv6c4dlfL6wOD+7r1Gl1APAdwzKwzdTeqv6BXW88zHadOMLGCQRJy3jMrgPrKzd+gMfLYyaZUb5P7pznZQW9dzH/AKifJ2LtTFJGFX+Zd7+hyVU4PKzfoGNO6X0AdFiw8y6Bor3waW2aWfBIJE81qyyePOIEtUznMKzbcR9fAjdGPHmSknyMcypVyQSIfFd0idpKvyD1WEbVKKrVbwwsqnMHwI/CSTjRhPINtWw6dAJFIIQZZ3RoLzWD1KhSKCfP9Eg3kXObmP6axkG1/whfyAfht9yuu669KdsNLY+HciEY7j0aV13PXUYcu6f35FC7JkLZc9GHXRZ8V1dc4mSxp88PQRW7xRULSQCSNClZFgYWOt/XUyJMNH2rM5V2spRN8uVzgvHWLghkL82rlt0BmBT6gLEAn0507TOj2YfTpD3qyX4Ddd/N8A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM4PR1001MB1378.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(122000001)(52536014)(66556008)(66446008)(76116006)(54906003)(66946007)(66476007)(64756008)(8676002)(4326008)(6916009)(4744005)(6506007)(82960400001)(7696005)(8936002)(9686003)(2906002)(33656002)(71200400001)(55016003)(55236004)(86362001)(26005)(38100700002)(38070700005)(498600001)(5660300002)(186003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MnBDbElmTDNBSWdDVjVyMk9TVDlUdTZHZ0R6eHVheTFwRmYxejlDYkFyVi8y?=
 =?utf-8?B?eis0bkpxVmw0T2xYdWdwUCtOSmE3S1FIbHFER0VMNm9ab1NsUllpU2ZZbG5G?=
 =?utf-8?B?Tzd6cjNNMmc1Q003dWFvVUhwcDRVVDlZWDJsek5MNkEybzZ3WUdmYlRMMEF4?=
 =?utf-8?B?ZEJGVWNVWm1GeGNTWkZDSVBuVVVGazFiRWtEejNzRHpNbnplQ3Z2UHJEdnZl?=
 =?utf-8?B?V3MxQUZldE40aUVyVy9hZEJHS1pjT05sOTlLMzZtTzVNRHdhdytGZ2YzVDNw?=
 =?utf-8?B?WDdCWGFGVVVBVEEyTm1yM3M5TlN0NjVoOWpZZElHcHB0RmgrWkZxSWQxWU1l?=
 =?utf-8?B?YlpnNHppQWoydG9hZ3pxdno1b2tQVXNpbnFwY1R3MnNLeFZyRkUrZlFFRE5w?=
 =?utf-8?B?cm9qekFYQ0QzY2RqaWQ5M1oyWmlMUXhBYjkvK2JaZDBDWXk2dmxqMmRkK2g4?=
 =?utf-8?B?MEttZS9ZbzIvaGY1VFBGZFhtVmNZV05BUmRLdE1lOEQzVkI4YVVrbmhEeFRG?=
 =?utf-8?B?NlVRUURCM0hYQnVxbUpBWmg3TVcvOWthZmVyVW4yMGgxZytGalRHL2pYc0ly?=
 =?utf-8?B?QXBLSHVnYzZKQXBGOEIySkNDelJUZmkxTXdZOXRlYjlUUjM5aGtVQlZVcDVp?=
 =?utf-8?B?cHJCSDJxZk1MNGdSdzNFRGY5cjRsRENrU0NRSXBWSll0aUFUenFHK0YvNWxM?=
 =?utf-8?B?WndhWFBtTG9XUytqRGk0YUtNdW9YYlJFdUFzaXZxeEJUcit2KzNCTEZjSEpQ?=
 =?utf-8?B?OE1ESXZjQXJQOVpDSDZLVExJRHBTUERvNXFpd0pZVjVQNkZyRFl5RnJwQ0Fp?=
 =?utf-8?B?UmFwcCtWbHBVWGxqM0tidllxSFBrWmIzR3R2OWVXWFIxM280VTN4NjdOUEFi?=
 =?utf-8?B?cFpNT1pjdnRiQzdkUDBDdzd2RUNTaE85RmZOQTZ2bXJDOGxmaTlXVFdCdmtX?=
 =?utf-8?B?TTdZUWxmS1NKbWw3Z3MrWit3VkRSSi9sbGlQc0VsTGd4OEtQdGhWRGJ6ZjAx?=
 =?utf-8?B?RFR6MUtONHRCNGttaEp3RlIxekwzSHV3MjFjajdKYTlWd25hTDczU0U5andC?=
 =?utf-8?B?T3R6UG1PbmROZTBnRktmQjdqNEIvbUFvaWl4NWJ3dDB2a1NJSmQzL3F4Mzhy?=
 =?utf-8?B?YzAwNHpBZkJoQlZ6dDJPVmlzZEZPWFVxT05INEJ5SlVMcm55RllpL1EzTGRY?=
 =?utf-8?B?OGs0RzFOYmJHK1I4TlRtVzdwZ0RaZXZCSnVVZCtna3F5cE1hTGVDZXJGNkwz?=
 =?utf-8?B?cXM5cHRGMkNNOGJqV3RzUEpWKzVWdDBLUHlqclA4eEc3VmtpWTBXRVNPUEwz?=
 =?utf-8?B?Z1pFYlM1aUQrOUN4ZVAyZTczbTk1dWhkblIyM2MyWXBicHJ1bzFHK3cySVdi?=
 =?utf-8?B?WG5iN3hPUmlka3p0cTF4RUpWT2Z5cSt0Z1Z5SENFVW80TGQ4cFQyMTNsWTN3?=
 =?utf-8?B?ZjZmVUxDMjdJRm5iU2poWXpvcXpoZVZGc3FHdmNvanRCNmlFRVhZU1ZxNzJ0?=
 =?utf-8?B?MGJXOHRkcW9uRjFWT1k2cWV0UVpCR0hnTHRQaTJlTUtMdmlPQ2xZMHExdDh6?=
 =?utf-8?B?NUZlbjdKd2ttaitVaWE3aE9weVRjZEJFR25YdFBXVUNRQ09UU2dVdkZqVWZX?=
 =?utf-8?B?cjJoUCtKeWhKZ0JONVhrc2JxZDVTUzZab0pGSTR4a2cwT1diV2dJS3dUekNV?=
 =?utf-8?B?N2RqQTVsbEE5djFLWGhFV2daYzIxMWRNRHF5QjU3S2ErWkN5MzFuZWV6WGNU?=
 =?utf-8?B?cEREaGRQd3VibTJOVm9GYnYycFQrZ1c0ZzVwUWR1Ny9mWk5QNDFKVDdyUFJi?=
 =?utf-8?B?ZVBrS3VidEd4Y2xkMjFSL1IrK2JCR0JTdVRCNnZUQm54K1cwSzRJRmpzSGZ1?=
 =?utf-8?B?Q2RYb2pmdndrQlltN21Xd3M0bjJhVXYzOHZXWjJibVR2TFh2TkVLbVdGL3Vu?=
 =?utf-8?B?cEVmTE94T2d2ZDdmS0I0Z0VpaUM0RENUdFNFSEF1ZHFYaE1MalNXRWJrY2NL?=
 =?utf-8?B?WkU2cURTU1RqUkY5cGVrQXZ4T0ErVzJVa2hnZ25zbDl6OEV1S3lQWmEybGV3?=
 =?utf-8?B?N0VHeXpRNlN2dDZYQU82NVp0UE9nMlIremZBMy91Rlk5QVdmbFIwM2xWL2Jw?=
 =?utf-8?B?MG45MkJDQ2N6d0xhS1AwNEZ0Qjhnajd0YU5IcGgxa2dhMVNSM3puRWpJZWJk?=
 =?utf-8?B?MVRKbktkWUUwWTgya1RLeDlIYzZvUHZSUmN4elFlL1B1aGIxZGRTNW5nMzJG?=
 =?utf-8?B?SGk4Zy9CVlFIajgzK2NPQmpmUnI4QWVQaVlucE40V0c5UlVsQ3haSVVqUlRK?=
 =?utf-8?B?N2FqVGhWR0k5WGlZMlp5WmZlN1kzZWtDdnVKNHM1MzJVUTVtbVBkSlBzRTh2?=
 =?utf-8?Q?9gDmC/ijvUQIduis=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM4PR1001MB1378.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a042363-e0c8-4737-5724-08da21da70f9
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Apr 2022 07:58:50.8166
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Xah0+hHicEyhD+9SScjXGJFJ6QU95ajHwPQhlFjN4kly7kDwtr+cYHAWKnMOJ1kJ7OGdy0Y0aMeLBv0R16fSB8FzhsbPSOG1DwNaJGe0C0Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB5432
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiA+IEZyb206IERhbmllbCBTdGFya2UgPGRhbmllbC5zdGFya2VAc2llbWVucy5jb20+DQo+ID4g
DQo+ID4gZ3NtX2NhcnJpZXJfcmFpc2VkKCkgcmV0dXJucyBhbHdheXMgMSBpZiB0aGUga2VybmVs
IG1vZHVsZSBwYXJhbWV0ZXIgDQo+ID4gJ2RlYnVnJyBoYXMgaXRzIHNlY29uZCBsZWFzdCBzaWdu
aWZpY2FudCBiaXQgc2V0LiBUaGlzIGNoYW5nZXMgdGhlIA0KPiA+IGJlaGF2aW9yIG9mIHRoZSBt
b2R1bGUgaW5zdGVhZCBvZiBqdXN0IGFkZGluZyBzb21lIGRlYnVnIG91dHB1dC4NCj4gPiBSZW1v
dmUgdGhpcyAnZGVidWcnIGdhdGVkIGVhcmx5IG91dCB0byBhdm9pZCBkZWJ1ZyBzZXR0aW5ncyBm
cm9tIA0KPiA+IGNoYW5naW5nIHRoZSBwcm9ncmFtIGZsb3cuDQo+ID4gDQo+ID4gRml4ZXM6IGUx
ZWFlYTQ2YmI0MCAoInR0eTogbl9nc20gbGluZSBkaXNjaXBsaW5lIikNCj4gPiBDYzogc3RhYmxl
QHZnZXIua2VybmVsLm9yZw0KPiANCj4gV2h5IGlzIHRoaXMgcmVsZXZhbnQgZm9yIHN0YWJsZSBi
YWNrcG9ydGluZz8gIEl0J3MgYSBkZWJ1Z2dpbmcgZmVhdHVyZQ0KPiBvbmx5LCBhbmQgeW91IGFy
ZSBjaGFuZ2luZyBob3cgaXQgcHJldmlvdXNseSB3b3JrZWQgOigNCg0KWW91IGFyZSByaWdodC4g
VGhpcyB3YXMgYSBtaXN0YWtlIG9uIG15IHNpZGUuIFBsZWFzZSBpZ25vcmUgdGhpcyBjb21taXQN
CmNvbXBsZXRlbHkuDQoNCkJlc3QgcmVnYXJkcywNCkRhbmllbCBTdGFya2UNCg==
