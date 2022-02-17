Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B61DB4BA255
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 15:03:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241145AbiBQOD4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 09:03:56 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:48582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229938AbiBQODy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 09:03:54 -0500
Received: from EUR02-AM5-obe.outbound.protection.outlook.com (mail-eopbgr00078.outbound.protection.outlook.com [40.107.0.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0649F11C20;
        Thu, 17 Feb 2022 06:03:40 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Al4TR/D4nfkeqGpsizKo3c7meTa3gUAQWOneoxWW5rieuoHhJNUCxFXDFKVHOAL/4CsY7WUSFTrrktkpGpBGPjVKq3IM4P4fhR8D0/nmMdaOwL9j11XZAhZRrxh/fNBNSaKOVS4iF3PHCVMYKb4nuZ37QG2BitsVt5zatr/d0Q87FdsRQuqaZKHOW2RETQ/YiFmOw2N30Szj7lnlgGj4Mv8CBAd3iJpt2x4qpYZOp/X/f37oqyJLk/yTOHma75didqJOFGH0GfNcdUvPuGOnPwLXAu5IpNo8JP/uhmZcYlnYem3tCwFjpO7SHz+pxgmyyWFcyZcw1PXU2+MzH+Qlvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q79a2yx+2Y4zLiLUKC+nhrh0SoH1cyW2JOrKnTpllTI=;
 b=HrdAEKr/iWepPRWV2bcE5coWOuwmdJ9XicBYZWvoj8JJW/6tFAoGaR+nFmmBqaspgv2V5FTJineMOojXCPYBh+ONnuQQZB+S39plhdRryPR7Vj0OOGhmsVihcnkb7z4TIKJpTQHrI7K/B5+r0fcN8xHVYv2xeEf3r1x9mkxgYymzwe/BB1nFYgSW1E6yCyzL/Et66G7pkPR5wVT8lAbRNw5feazzb+igILHcM0f4YhwVSAqAD4CJZRJUkZW8dFjzWpJVqpNXMaiy5cqEmZ0A2g5VkcE0y52qu1aJ3JmHWeybFan7CD/ict1HN6r/qrZjknsgO/QF+hESr+L+uB2ZPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q79a2yx+2Y4zLiLUKC+nhrh0SoH1cyW2JOrKnTpllTI=;
 b=y5pryNpuPiW62oIEu4KKdV0r1EIzxkFElDoahEmrZtorQ/JMSsq8vUJNepDlja3+fJ3Q1sSbxh/xxT5DSmGQrnEAjA4IsZIc/UKjfao+oBhH/Rwe/H7HtVLKAGwyNcd2XQxARHLfUUJqbMk4Acy72GCpJLtZoAsP83mE1UaCVHIhrZacUw3Npzx+/B8SQKS0aRlEqpUtYGmauXVLlROrUht+nY3YfiMNwyTyI+0INkXc+fflsiebyGbF6O+nTeD4uneeTCAStEBT41tzSqIfW0ql+i3Iz85kCLLwb19B004v2Uxu62tsZXc37JCguHfsDseZsr+l/M2ZNq8Wu6lPyg==
Received: from AM4PR1001MB1378.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:200:98::12) by AM6PR10MB1864.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:209:34::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.14; Thu, 17 Feb
 2022 14:03:37 +0000
Received: from AM4PR1001MB1378.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::f909:2310:3487:4150]) by AM4PR1001MB1378.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::f909:2310:3487:4150%6]) with mapi id 15.20.4995.017; Thu, 17 Feb 2022
 14:03:37 +0000
From:   "Starke, Daniel" <daniel.starke@siemens.com>
To:     Greg KH <gregkh@linuxfoundation.org>
CC:     "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        "jirislaby@kernel.org" <jirislaby@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 1/1] tty: n_gsm: fix encoding of control signal octet bit
 DV
Thread-Topic: [PATCH 1/1] tty: n_gsm: fix encoding of control signal octet bit
 DV
Thread-Index: AdgkBkuodpJ0h7OBQUuC7gVGsZUEiA==
Date:   Thu, 17 Feb 2022 14:03:37 +0000
Message-ID: <AM4PR1001MB137883EF5392EE25ED70A912E0369@AM4PR1001MB1378.EURPRD10.PROD.OUTLOOK.COM>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: fc71e639-98de-4eba-5716-08d9f21e4b70
x-ms-traffictypediagnostic: AM6PR10MB1864:EE_
x-microsoft-antispam-prvs: <AM6PR10MB186441F38FBD74799457F45AE0369@AM6PR10MB1864.EURPRD10.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: LOxX7WFoDEruafn2FOgV00yALthHEtb/KH4XP5fc3veUTECS64I0tgsHQMVjmknzaFv/Aw37yGlXfaDOxcw4VgdgOlDfax1mPl0HmNg2XOI2ioolyWq2/tOt8bzaIPdhBNzRA6owqpgN6x4/UTAdV5lDaEBpSpuPYRs0CL9vj8eUPjALOl2hubW5eUo+M27dD/7s7xeQ0GeVClk8SnHRunPX2dZUaY8nkVAzQoxNlX6gkKF4IFPg/m1tRuN9e8tuymoJ1p+7FZDUajl3v75bB7BwjvCHLHyDyjaXct3zxUvBybxuglnRxgMlwCSFAKPtOfWuBDPPGLkt5AVCzYcqcvncjf19OHf1uEoBActrlubi+qW1SuFIiGo5oHPvhTodTY6pdEdXJtGUbihJtD1iUTaM7HmflIuFZdL8Mbafn4KRc3Y7DFPB6U/Hz0UkBaPHVeAItXCsiz4rUlrkHeqFlO32AunDWagGWELzoIfiIwiirmmqLkrqlLvxnVtSUkhcQSoOXUKGkgsX/l6VgYbJuqc84AEkE0ESGFUra7966ytXQbBcTqdZN5AtrxXuzvHFbJ5l4fedSob8oMlF1/9616holHbErXa6Xnzw1WxApNKFUWmbcSP3z0R12gDe1UGYdxMeV9aCwX97TcEUIUAq3cRjwAf7TQvytTp/E6atXhaUjwxyNqhEVCJQWdS604/xbxXZBmop9lJkuwDwsim+7w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM4PR1001MB1378.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(7696005)(33656002)(9686003)(5660300002)(52536014)(8936002)(6506007)(26005)(508600001)(55236004)(64756008)(66946007)(186003)(86362001)(66556008)(76116006)(38070700005)(4326008)(8676002)(66476007)(2906002)(66446008)(122000001)(82960400001)(38100700002)(71200400001)(83380400001)(55016003)(54906003)(6916009)(316002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OTIxRXRXNm5xRDh5RWRGZUJZaDBGV1owN0ppL0pSWVpUa3NSM3M0RE44dWs4?=
 =?utf-8?B?Mk1mTmxaMkMzRU5NdHRYOEwxSVluZ2lwem9zdDdnampUQzdsZUtRYzcxOEh0?=
 =?utf-8?B?YkNyT1hrWlQyazROME1PV1h1OVMwc3lmbjJmT1VzZ2N5SjQ0MXFGeG9idVR3?=
 =?utf-8?B?czJ5R0t6Z1pZLzFrU1lqOW0vYWFzWUxER3hWVjZUTEc2UFhKQVEzekJZeTFx?=
 =?utf-8?B?WTBRNXZOSWt0RXg1QnBveWl2ZHk1NkpQWmdFYTNiUFdFeWh5Z3JDVWI5eHp5?=
 =?utf-8?B?VXF2Wi9NN3R2NW1hRStUWmNhaHd3SUIzYVNuUnFFbzUrS2d3SU9HQnVLQlVW?=
 =?utf-8?B?SDRtUGU4WnpUNWMrOXVDZldTMkxiNkh2Tkl3WW9XalB3TUJrWERLY2xtOURo?=
 =?utf-8?B?azJ4bHRydmF1S3RoalA5ekxTS09sMjZGMmRCQys1QkRjZlg3UDBWclRMcEcx?=
 =?utf-8?B?cldlRFRYR2lyK2FhS3NlWnp6eWZsb1FiOUZQS3BHMGV4eWNtMmF2QzFJZWcz?=
 =?utf-8?B?dWo2aEY5VXBJQU5kMHdNaUxWd2o4OXMrTlBhYmtRSE5ucUFRcHhYYmNNSlFR?=
 =?utf-8?B?Z1FUcE1rbDR3VjJMNUNTZ3R5M0tIK1N4dkxBRURibEttc3E0K0FFNmgyeDFF?=
 =?utf-8?B?SWptSmd5UFhKc0x3dVc0azFZemVUUFJFQkpiRkprT3Q5djg0Mm9LY3Z0MHo3?=
 =?utf-8?B?ZHFtZzBGYklRWm94c2hMcFN2dldIWFlnQSs2UDlRMzczalNnUUpQRnVvYS9F?=
 =?utf-8?B?MHFqRWhwakxDYUordi9mMUpXZVE3R1MvNVlXcmNpZ2ZJeGMwNWpYQXZmblZ0?=
 =?utf-8?B?UUxTWVNhWjdvaW03bGFxazF5L3pyQkRTTzlqVlcvdURDVG5WTk82d0JGYTNr?=
 =?utf-8?B?Rktwd1UxMVB0QytvWXNxWG1qOFZjV0hpdk84UHlHblF0V3hHVEl4eC85SEk1?=
 =?utf-8?B?aUFVbUp1Slg5dmFJZXlVa3FhVzV6M1RYa25keksvSXhNYWpEM3dsZWpBSTQ2?=
 =?utf-8?B?ZHJ3VGovaEJMVW5ENjQzK0greEVrVzU4WURnUitlTTNJRW81SmxBeit3Tm0v?=
 =?utf-8?B?VTFzZkVxQk1IMnJWS1JhZUJ5NkFTY0Jpc1NzQTFrR1NTUWxJaUVBZHhNT3o2?=
 =?utf-8?B?S0VjQjl1NFlxRFVlRTZWZW1zQjhqTmw2YVdFS3QyVVRZNzl5U0hGQlovczdF?=
 =?utf-8?B?NFlsbU5Kb2RBYnZXTjhxKzJTYXhqbktldEVqQ0lXYm9PVXExQlJFNlJ0c1hW?=
 =?utf-8?B?L085bi9CVVNTQ0RaMHR0V1ZIODVySitpWDg4R053YW5RQ0Vldm5ZTGFlZ1dC?=
 =?utf-8?B?KzZwK2xMRmV3QmVsb21PYjk2ZCtoWnZ2blUreWRqQmI4djA0NXk1N0tLclhJ?=
 =?utf-8?B?dldPQWo0Nnp2S0cxUjBFSzROdlJFbDdRcjFIUmQxWS9MVUVHUFpJS1NoSm5y?=
 =?utf-8?B?anhnZDFRN1JybEEyOWlUUU1wUWg2Sm5rN1ZoSW1tYU9PVHBGajNiTmdzK1Vn?=
 =?utf-8?B?OGVybkZXWVdCc3U2WVczTHp5WW5WdUI5cGVPcFlQK0FmY3Nkb3JHb2hqL3B6?=
 =?utf-8?B?amJadUc4Y2svVWk5QWJ5U3BhOU4xTW9GSmJUZkI4c2JkNER6eUErU1RCLzRY?=
 =?utf-8?B?Rm1IZStiQ09QeU1wUmRRNURUVUU1Qys2cGZsa2krVHk3OFdXOEtBbDJPVzZ3?=
 =?utf-8?B?NnBrWkJXU3h4L0V6SzMzVzh4MEZwS1NWUUh0eGt5SzYyQ2NkRm14MHZJUFFY?=
 =?utf-8?B?NmxFaDJWVk9td2pJZXVLamc2cktKa2k2RnhEYlZadXZqaitwb0FLWjl1cFFR?=
 =?utf-8?B?MkxQZU40Wk5VNmEwL0EwWVl1KzRJKzlRRnorQXhwb21nWGNhN3FMV05xbzFw?=
 =?utf-8?B?MjlnMG1FUEtsNXdCbXFHODhwZE5OQk9LaGw5ZDZNbFlrUmlFWTlTYmhlTk9w?=
 =?utf-8?B?T3JOcWxwYm11aVVkL0lHaVJRdUFiNmlSNHowcXVucnRDc0xFTTN3dDNsU2Jx?=
 =?utf-8?B?M1VJSzdob1Y3YU5zejRna09zZ25tRGNTVEpLOHgrSnVMVE5XSWJFUlBnOEJP?=
 =?utf-8?B?dWxBYk1kQlhpMm11Uzh3dERQSUFTUnNtOUNNYTljVFROeS9iTFpvOTZYbFQ1?=
 =?utf-8?B?dXJLVHBZQldDcXRXSVc3VjFqZTNkNTZGZDMzZllNeTlWUnZVcWtMMkE5VmU0?=
 =?utf-8?B?bzNMdDBVSldUa2cyMHhGSEdTaEFOM1JnRmcrU0JvVGUxb2V3UnZwM1hhT2h3?=
 =?utf-8?B?cHlaSFJ2cm9UTVNoeWZHTTM2bDRnPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM4PR1001MB1378.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: fc71e639-98de-4eba-5716-08d9f21e4b70
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Feb 2022 14:03:37.7761
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aXVT35zSyX9efkhPxF5kWNFVkptfXxu/A1i5snwse/TolkbJmoRwGpDAJM3gOoNpmD8YgT1q72ciIuP9AUqgtwk565ueLx4U5qn2iD5YqfA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR10MB1864
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiA+ID4gQWxsIG9mIHRoZXNlIGFyZSBwYXRjaCAxLzEsIHdoaWNoIGlzIG9kZCA6KA0KPiA+ID4g
DQo+ID4gPiBQbGVhc2UgcmVudW1iZXIgdGhlbSBwcm9wZXJseSBhbmQgcmVzZW5kLg0KPiA+IA0K
PiA+IEFsbCB0aGVzZSBwYXRjaGVzIGFyZSBiYXNlZCBvbiB0aGUgY3VycmVudCB2ZXJzaW9uIG9m
IHR0eS1uZXh0IGFuZCBhcmUgDQo+ID4gY29tcGxldGVseSBpbmRlcGVuZGVudCBmcm9tIGVhY2gg
b3RoZXIuIFRoZSBvbmx5IGNvbW1vbiBwYXJ0IGlzIHRoZSANCj4gPiBmaWxlIHRoZXkgYXBwbHkg
dG8uIFRoZXJlZm9yZSwgdGhpcyBpcyBub3QgYSBwYXRjaCBzZXJpZXMuIFdvdWxkIHlvdSANCj4g
PiBzdGlsbCBzdWdnZXN0IHRvIGFwcGx5IGEgZGlmZmVyZW50IG51bWJlcmluZz8NCj4gDQo+IFll
cywgcGxlYXNlIHNlbmQgdGhlbSBhcyBhIHBhdGNoIHNlcmllcywgbnVtYmVyZWQgY29ycmVjdGx5
LCBhcyBhIHdob2xlDQo+IHNlcmllcyBvZiBwYXRjaGVzLCBhbGwgbGlzdGVkIGFzIDEvMSBkb2Vz
IG5vdCBkbyBnb29kIHRoaW5ncyBmb3Igb3VyDQo+IHRvb2xzLg0KDQpJIGhhdmUgbm90aWNlZCB0
aGF0IGFsbCBwYXRjaGVzIGhhdmUgYmVlbiBzZW50IGluIG9uZSB0aHJlYWQuIFRoaXMgd2FzIG5v
dA0KbXkgaW50ZW50aW9uLiBJIHNlZSB0d28gb3B0aW9ucyBoZXJlIG5vdzoNCjEuIFJlc2VuZCBh
bGwgcGF0Y2hlcyBvbmUgYnkgb25lIGFzIHRoZXkgYXJlIGNvbXBsZXRlbHkgaW5kZXBlbmRlbnQu
DQoyLiBDcmVhdGUgYSBwYXRjaCBzZXJpZXMuDQoNCkFuZCB0aGUgZm9sbG93aW5nIHR3byB2YXJp
YW50cyBpbiBjYXNlIG9mIG9wdGlvbiAyOg0KYS4gSnVzdCByZW51bWJlciB0aGUgc3ViamVjdHMg
YW5kIHJlc2VuZCBhbGwgKGkuZS4gd2l0aG91dCBhIGNvdmVyIGxldHRlcikuDQpiLiBDcmVhdGUg
YSBwYXRjaCBzZXJpZXMgZnJvbSBjb21taXRzIHRoYXQgZGVwZW5kIG9uIGVhY2ggb3RoZXIuIFNl
bmQgdGhpcw0KICAgdG9nZXRoZXIgd2l0aCBhIGNvdmVyIGxldHRlci4NCg0KUGxlYXNlIGxldCBt
ZSBrbm93IHdoYXQgeW91IHByZWZlci4NCg0KV2l0aCBiZXN0IHJlZ2FyZHMsDQpEYW5pZWwgU3Rh
cmtlDQo=
