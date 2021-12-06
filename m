Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30BFA46A18B
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 17:38:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376273AbhLFQlb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 11:41:31 -0500
Received: from mail-eopbgr60058.outbound.protection.outlook.com ([40.107.6.58]:28228
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1359684AbhLFQlX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 11:41:23 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HyNGjlPxWeair6SCG3MI/Lu1Sd9Ea2/J43vtDKXENYdsRpzmY+t9+NIBzecLsUiAchmvWS0qieQwUkq6KQRCX90kRXHKmDi6aRpZZJmzch4PdYCl74UlQgSOnp6sbCKiLTpxKJdENYSgH+q8vpq/kGFP6xfpWL1AQLh0RFV7BBb6Jb+XFBL19Hmp5B6peyKxq2Go6rBAxMSDWF+eM+FDhhKxL2FMrPWJTUVtMGKVkkoVPX9KIBigm/JCAEa7zrnZSfo6bL+0KruOqQg5bJEbq4Cp5s66z8dA6FpeNniqQhQTQiG0qdbukPJKmi9O5bC15GigP3nGvWY5JGRmrU5xVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dMYbIJpM1n35OXMvmpcyfXZ5nkXw5mVOVh0FJjNmuXs=;
 b=MvyPA/lF/TxJxsDSubi5zsplzzEtW9D95Bu+mESDYBBRuRWrenPLOd29nxsjpzbH5PrHSDWN2/I0ctXLsxT6Lw2joPtd0jNhbcXwxzczQNjSt8Yt+p1EeK6oqmt3elq8c2uosb3YC3rgsb17b5E0+fsUNc9ASw+bBflUWRDjBvKqJvV+ZSNpQGYrBzthG7NcMWetpU9OgiJORjplqukVqxS66aj8hZrR9Oxk+cX6QJYsdJqoY6FtqgQ7i134a1mqCPxzlOav75NVlfTi2tNB9/otdtkss/ZZCi0w0R7gwXd4YrK84t93xhTmKOSFvNUd/PTiX7FlArXIx/Kt61LTqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=diasemi.com; dmarc=pass action=none header.from=diasemi.com;
 dkim=pass header.d=diasemi.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=dialogsemiconductor.onmicrosoft.com;
 s=selector1-dialogsemiconductor-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dMYbIJpM1n35OXMvmpcyfXZ5nkXw5mVOVh0FJjNmuXs=;
 b=Us8IVGpm7hXFHIlP3ep+hz+EiyKehvR7vR0qmFG5pFcjxqiSYRn6LicvIfqHjZU2PKEXefchPbGmvPKSCIcr1xzxB4XNVEfXuvdvMy9aYxXZHlRj6zVJL1w1NODARdfGegl62zexg+7rQP/Mt7XZTGsAgllaP1OgLeALihrJ930=
Received: from DB9PR10MB4652.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:255::23)
 by DB6PR1001MB1208.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:4:65::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.21; Mon, 6 Dec
 2021 16:37:47 +0000
Received: from DB9PR10MB4652.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::852d:c54f:8414:3276]) by DB9PR10MB4652.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::852d:c54f:8414:3276%4]) with mapi id 15.20.4755.021; Mon, 6 Dec 2021
 16:37:47 +0000
From:   Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
To:     Christoph Niedermaier <cniedermaier@dh-electronics.com>,
        Andrej Picej <andrej.picej@norik.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
CC:     Support Opensource <Support.Opensource@diasemi.com>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        "linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Guenter Roeck <linux@roeck-us.net>
Subject: RE: [RFC PATCH] watchdog: da9062: Correct the timeout values
Thread-Topic: [RFC PATCH] watchdog: da9062: Correct the timeout values
Thread-Index: AQHX6GQVSRJT+VH2+kivjEaaOFFj8Kwg+3QAgAAK4wCABA7FAIAABT+AgACSa/A=
Date:   Mon, 6 Dec 2021 16:37:47 +0000
Message-ID: <DB9PR10MB4652589534582A3F917E4165806D9@DB9PR10MB4652.EURPRD10.PROD.OUTLOOK.COM>
References: <20211203163539.91870-1-cniedermaier@dh-electronics.com>
 <dc6a432c-79a3-881c-eac4-32620040d11b@roeck-us.net>
 <4bfb6ab512cd45ee81c55361525987b7@dh-electronics.com>
 <a0b6a801-f911-3371-1067-479b66240bdc@norik.com>
 <46136729bb564aa6b9f332fa584b2575@dh-electronics.com>
In-Reply-To: <46136729bb564aa6b9f332fa584b2575@dh-electronics.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=diasemi.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4c8a015d-fdb6-451a-8c68-08d9b8d6bc8d
x-ms-traffictypediagnostic: DB6PR1001MB1208:EE_
x-ms-exchange-sharedmailbox-routingagent-processed: True
x-microsoft-antispam-prvs: <DB6PR1001MB120898356600A0DD4D5F768EA76D9@DB6PR1001MB1208.EURPRD10.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: x01dKNEhDZ8sjAnhqHeaQ1wsp/MuCLiwg91hUu83wMXpw59Qi0W/PBwErzs8wkG5CDcZnBYzF8rJ9McTLkNbeXhjk29tZvNDPQctAqAe68kE22yGhP01cXc64G1r7gyuZbGrT9SZMuNopHmrN5S0t/GxbDz+PK3lRsmYBTPI1hxs533n/G5Lk2iGhSRZ/MBICxBvazaZKGmHGQ+aV/HC3aA3RY/u8NVM9e3qNhuqCnQsaDUWiuF1xW2VunBdPIJXgoVE3xBIzWT6gkJws+jxkNqooT0mXlPYHXmHcFCYH1XoffCuakVV/4MF95Jb+8jVHV11dCN/0mmAA5ito34RqRFCfPuhNG8BelrqPCvvVOSnpW7K3SpaCnVPLXX0DK6chFZbpEaqna4Hu7jViHnkSggWthikF+pm/4pUJ2lKAwxTk3XXQlxWo+EDq04km4Zk4UKszgPRKVjSe6XtPE70CLQMmTRB1FebOM0ncQjrLeniCtV0uKiY5s1CdK3Zbvrn6SNZO38IoakDShz1OWKyasA7t5ztE+5C8OryZbvW/qe1IJelyxK4zEC3uv0d4pyreAgpqTxfUgz64+8pVoqO4QIlIdf9oND+K1BXGSgZxmAeQWuLh2APCcAE4js8eUxQxejfG8THYh5oEkzQUwCNhSQDi6XSqQYd2ujpQfAp7ERqodeoud87eRCQC2ihThc3/fsZAJmMwT+n1CxvYcky7w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR10MB4652.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(4636009)(366004)(71200400001)(508600001)(33656002)(38100700002)(122000001)(7696005)(66446008)(64756008)(38070700005)(8676002)(316002)(66556008)(52536014)(66476007)(66946007)(26005)(5660300002)(86362001)(2906002)(8936002)(76116006)(9686003)(4326008)(55236004)(186003)(55016003)(6506007)(110136005)(54906003)(83380400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZzVOM21IYUsvckFVdGFGMGU3MXdIU0ZkeCtORDhPU0pIR0NiajA1ajNZZlRN?=
 =?utf-8?B?cjNpY2dwclNVVzIzRDExbkFrSXdlZ3ozei9DRURWclk5SjVFY3NmRlNMZFJQ?=
 =?utf-8?B?Q2I4MHVNVUkyM1pTQUE3dFBDYjhLeVdRVmprbG1LbDhLVHpkUGNaVUxCOEFt?=
 =?utf-8?B?ekRON3hvRnRKUHU0ak52VnBvalhOOVFRVlMvQWF2a0preDBJWlR6SjB3ZGow?=
 =?utf-8?B?YWMrL1dZUWVxQitzK3ZTSU95bWR2SFBPZDBobm9vN20wWllDT0JYcys4ZGlw?=
 =?utf-8?B?WmRoaVNIVUhCemtqTUtuTlR5Umc1VGt4OG5NWENWVzNtYUo2MDdVTlkrU3Er?=
 =?utf-8?B?Vm5jWTdRMmY2aFdPQXlzK0Q3a2FYOEJ4MzBXbXozdHlhVnFSeHlnK2xRYXRJ?=
 =?utf-8?B?dUhwUDR3ZmJpS2ZBdm1xcXZNRFMrcG9EOVUzaXN1QmRXVlFyM3RXUUxVT1ZZ?=
 =?utf-8?B?TnpWcW9jcjdKMmRaZHRYYVU3K3VzS1JNYndtTUVSZS9lbTh3R1IxZ0lLZDlm?=
 =?utf-8?B?NTFBbGtvYWJEQ1I5VWVXdGdISVMzVWkxMGc2ZEFWd0c1ZytZUThiMGpiQkhH?=
 =?utf-8?B?czREVDJNRmlMUkRkNUIzSlY0RkJvYVR5QXhqd3RCb0VORTZvalMxbzhxcEZE?=
 =?utf-8?B?aHArOE1MT1pVMUVQbXdrbmh5QWNsNWFwVEZQRnFwK2J0TnpwQ2RzMldjblNp?=
 =?utf-8?B?NVcrNlFUOWx1YnRNWEdjTEdCWVJZbXhqajhJa2N6MXlBR3dQc29vRlBhaEI3?=
 =?utf-8?B?amt4bDJDditkbmtTVkEyS0tLOTJkOVU5bDk0MHdJV2NjRGVRN3U4bUhsdjZq?=
 =?utf-8?B?RkUvWDVzcWdSRWhZUno5L2E5TWFtODlZSEIra1ljK29meFdvTVE2NXlodEtI?=
 =?utf-8?B?MmtGN0g5RzZoVlFqd2R4ZTFpMWlSNDZHNW8vNGpmdVJLOENOT0F2ZHNKeWVu?=
 =?utf-8?B?UXloSDViNzNQREtMSnZyZjg2UjE0REl2VXdRSHBmM3ZtS1dMRlU5L3FtN1px?=
 =?utf-8?B?K2dTenZOMmkraHMxNU5JMFpWMk51d1o2NThhV1AxcXFkRENZbkxIMis0N3ps?=
 =?utf-8?B?eXhGUzZPQ3V6U0R2OW9xV1AzNUJpODZJc2I0SG9mRWFSWXcwRkJwcllic1ha?=
 =?utf-8?B?OC9oc3JXTnJuWnZWdVh4UDY0YWtSZjByU2ZzTW15U1MySnlTbG9KSHJVR1o0?=
 =?utf-8?B?RVhYVkFTS2hXaDBRcWF6c1pzQ3RiYUxvbTNPcE1BSG91d041bkhQazBIWmdM?=
 =?utf-8?B?bUVKdHYwekNqbFp1QVdtRTBEclMzTnF3dkRXcStEc3hTZXNqMERhTXhoZk9L?=
 =?utf-8?B?bWYzQTROVmp3TFcxbElQV1NvaXc0cHFacm5hdFdwS0U5SVBscTU4WE83ZnlY?=
 =?utf-8?B?UVZwU3QrWllIb1N1bDcvdm9oZ1VJM093MjVGYzdvS044TGdoRHhPTnk2djM3?=
 =?utf-8?B?Y0tqMHRBRnpXVXBDTlpRWGFIOGJ4UDZ2NDlXazFZQzgyRkFCclpqKzRKcFF6?=
 =?utf-8?B?cTJBcEVveEFGSnBDaWFtOWkyVTk3T0ZFQlhCZVEzTkxKNHNzODRCVmorZnZU?=
 =?utf-8?B?a0NxSk9nb3FYNDcwY29peW9Ldnh6SlU0bVRFUmlsNUMyM3c0cDcrNXhxTkxK?=
 =?utf-8?B?TmV1MGQ5ZDZGYUp4UUFFT3Bxc0duNjJONUpoREJWeEdURzd6UUl5d2JlN2dv?=
 =?utf-8?B?S2RhSjVVaFdad1VMRTlFSjNCenpCcVZRb0x0SDJKYWUwcFoxZGI3djlvTUNF?=
 =?utf-8?B?UTJYQ1FQTjk0SktOQk15dWlSZXJvY3piUkZjUkJxd1JaeER0NlFiZ3M2WXRn?=
 =?utf-8?B?QzRqb2IxUk1yckI0VzNaWTRRaDh1QnpLNzVpT2NKVjFKMjh5Q3lzUWVVaGR4?=
 =?utf-8?B?VExvZE00cFkxNzN6R1FxbUlKTjljdnFWbW9QU1lUVHB4VXU3b1cwZ0hYU3kx?=
 =?utf-8?B?eUh2YisvYXRWNlQ0Z2pYS01GcDNJa2FraUcrbTdQMTdmSFY3Y3l1UDc3d1p3?=
 =?utf-8?B?QndTYml2QVVhc0I1UGllWWsxVERxSG90eDlQYTFxZFd5dUovVmFoeks5RmR3?=
 =?utf-8?B?dUQrQW4xckdneWhaQlRYZm9lc2FsYm8xNzJJRjU3eG5SMFREWUJGSFJEemxB?=
 =?utf-8?B?bTZ6aHUxbk80dU92Q3NReUIvNmJWWWE5M0JFUWVJcVBuWldha1FPRkIyZ0lH?=
 =?utf-8?B?cGpVcWpjUk5EeXFLeG5HY2lsRVFjbmg5dmNJQ3VRNmZTUks1WDBjOHF2V0Ny?=
 =?utf-8?B?UkhLUmJQeDZUeVE2RHBXa0VQMzNnPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: diasemi.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB9PR10MB4652.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c8a015d-fdb6-451a-8c68-08d9b8d6bc8d
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Dec 2021 16:37:47.3649
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 511e3c0e-ee96-486e-a2ec-e272ffa37b7c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: stWp9gY5nbbImsMMRB1k8FaU7NeN4/QMA/fSU3PscNboo6tI1zjE53718+aldHj2sy2r4Bn5IR+eRwXcUG+G2xqZJLjbb30VQaLmrjyjCGQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR1001MB1208
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBUaGFua3MgYW55d2F5LCBzbyBub3cgSSBrbm93IGl0IG11c3QgYmUNCj4gcHJvYmxlbSB3aXRo
IG15IERBOTA2MSBjaGlwLg0KPg0KPiBAQWRhbQ0KPiBXaGVyZSBjYW4gaXQgY29tZSBmcm9tPw0K
PiBDYW4geW91IGdpdmUgd2UgYSBoaW50IHdoYXQgdG8gY2hlY2s/DQoNCkkndmUgc3Bva2VuIGlu
dGVybmFsbHkgYW5kIGhhdmUgYmVlbiBpbmZvcm1lZCB0aGF0IHRoaXMgaXMgZG93biB0byB0aGUg
ZmFjdCB0aGF0DQpEQTkwNjEgcnVucyBvbmx5IGZyb20gYW4gaW50ZXJuYWwgb3NjaWxsYXRvciB3
aGljaCBtYXkgYmUgc2xvd2VyLiBUaGUgaW5kaWNhdGlvbg0KaXMgdGhhdCB0aGUgdmFsdWVzIGZv
ciBUV0RTQ0FMRSBkZXNjcmliZSB0aGUgd2luZG93IHdoZXJlIGlmIGEga2ljay9waW5nIG9jY3Vy
cw0Kd2l0aGluIHRoYXQgcGVyaW9kIHRoZW4gdGhlIHdhdGNoZG9nIGlzIGd1YXJhbnRlZWQgKm5v
dCogdG8gdGltZW91dC4gVGhlIGFjdHVhbA0KdGltZW91dCB3b3VsZCBiZSBhdCBzb21lIHBvaW50
IGFmdGVyIHRoZSBzZWxlY3RlZCB0aW1lb3V0IHBlcmlvZCwgYXNzdW1pbmcgbm8NCnBpbmcva2lj
ayBvY2N1cnJlZC4NCg0KVGFibGUgOCBpbiB0aGUgZGF0YXNoZWV0IHNwZWNpZmllcyBhIG1pbmlt
dW0gd2F0Y2hkb2cgdGltZW91dCBvZiAyLjVzICh0V0RNQVgpDQp1bmRlciBzcGVjaWZpYyBvcGVy
YXRpbmcgY29uZGl0aW9ucywgc28gaWYgdGhlIG1pbmltdW0gMnMgd2luZG93IHdhcyBjaG9zZW4N
CihUV0RTQ0FMRSA9IDEpIHRoZW4gZWFybGllc3QgdGhlIHdhdGNoZG9nIHdvdWxkIGFjdHVhbGx5
IHRpbWVvdXQsIGZvbGxvd2luZyBhDQpwaW5nLCBpcyAyLjVzLCBhc3N1bWluZyB0aGUgY29uZGl0
aW9ucyBtYXRjaGVkIHRob3NlIGRlc2NyaWJlZC4NCg0KSWYgeW91IGhhdmUgZnVydGhlciBxdWVz
dGlvbnMgaXQgcHJvYmFibHkgbWFrZXMgc2Vuc2UgdG8gY29udGFjdCBEaWFsb2cvUmVuZXNhcw0K
c3VwcG9ydCBhcyB0aGV5IHdpbGwgYmUgYWJsZSB0byBwcm92aWRlIG1vcmUgZGV0YWlsZWQgaW5m
byBvbiB0aGlzLg0K
