Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BEEE4B6741
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 10:16:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235786AbiBOJQY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 04:16:24 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:40912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232969AbiBOJQX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 04:16:23 -0500
Received: from EUR03-DB5-obe.outbound.protection.outlook.com (mail-eopbgr40044.outbound.protection.outlook.com [40.107.4.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21B6C2610A;
        Tue, 15 Feb 2022 01:16:14 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GBBlTlMYqSe1CQqsZNFyvI36xBatMVdOvHNxDZJIwwfy0zOrnt4w6XHQyYEo8zGPM4ApJqn6CwoJPnkKY5/sfF7byxZPqVv8j0an7Pfej7hfIq9PQTlUAYFIYjZQCknxDvTiEHy+4uwCEcbNeD961uNuHyWVU2F9vyQhZDrHRuRijAQJlIkLolK9DHXIRvbAu3pLJ12rv0JrnS6rcwgZlhVy3ytWYMioBVzyH8tNKgO8qFPxR7Pz9YFJIMJuG11lkJSnE6v0m0c5kFX7C7AFunJoJtpKCPVdArUAU4ka01YQQqaKOvYJwPcf0GhqAl4rENGKbwUS7aBtpmb/GYdbOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9OYgpU3hdV2y074zIHXdp2fjap3mVGn+hcLPuXn8Bqc=;
 b=NRzl5FrtzIpPlnSqopvQDtKpiz0Yb+BZBf4h88irjaLCTR/YhIJXINUOv234f/P7WMBKVK2wb5KiV8/XeAC9glkvAw3GmfKCKK19QZhLeWUZq7p0UwSt7GDzzxwb0n85PLTnu3httlw5EauNzmCNuuBhmhUIf7clru58TxuWlciY+4Fk90Lf94erCh6sUB6rXkBfVEWbHGtkTX67r+5ONfzKi31UxCAuxRlP5qTxAaqQQjswyHm0OUmiGRdWfDvmcyDP49JBp6KrDNGmPbeTP+pJDybpAmoZCFjWhqnPQA/apDLcAhNvEMGmGnoDyDeOLannB7rmE934prfnj2dXAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=dialogsemiconductor.onmicrosoft.com;
 s=selector1-dialogsemiconductor-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9OYgpU3hdV2y074zIHXdp2fjap3mVGn+hcLPuXn8Bqc=;
 b=zxhmETIEjtnb7S9IzKRULI6p03mfyaR9auv3S/1MlS4pbzzeMncLHF9HapZbrhgg24kLCueOEBt+zyd9H7pngPby3pnRX240IV81/q941snsbGex4pyH1KDkXjDqIQYdvk2BH+r9Ic3DyrUN5SWc2cD5hg3VPRMXth8FUrfM/e0=
Received: from DB9PR10MB4652.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:255::23)
 by AS8PR10MB4903.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:349::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.15; Tue, 15 Feb
 2022 09:16:10 +0000
Received: from DB9PR10MB4652.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::d165:b00:9d96:599d]) by DB9PR10MB4652.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::d165:b00:9d96:599d%5]) with mapi id 15.20.4909.019; Tue, 15 Feb 2022
 09:16:10 +0000
From:   Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
To:     Christoph Niedermaier <cniedermaier@dh-electronics.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Adam Thomson <Adam.Thomson.Opensource@diasemi.com>,
        Andrej Picej <andrej.picej@norik.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
CC:     Support Opensource <Support.Opensource@diasemi.com>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        "linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [RFC PATCH] watchdog: da9062: Correct the timeout values
 [Klartext]
Thread-Topic: [RFC PATCH] watchdog: da9062: Correct the timeout values
 [Klartext]
Thread-Index: AdfwANztWgHN3oJ0TZqwlPeCV8dlmAAIEJYAAALaKlAAD68ZMAxWZv9gACHQ5CA=
Date:   Tue, 15 Feb 2022 09:16:10 +0000
Message-ID: <DB9PR10MB46529728D2574AE35CB84D3680349@DB9PR10MB4652.EURPRD10.PROD.OUTLOOK.COM>
References: <4254747d8cde4c5dbcbfdd00a3ecf701@dh-electronics.com>
 <03871bd3-ea78-52e1-f57b-3e35724c8934@roeck-us.net>
  <a065a23625404ca9853354f9d367a09c@dh-electronics.com>
 <3bb120e2fcb649f09cf0f8c881f442ff@dh-electronics.com>
In-Reply-To: <3bb120e2fcb649f09cf0f8c881f442ff@dh-electronics.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=diasemi.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 04c6740e-4eb8-4eb3-e16b-08d9f063ce58
x-ms-traffictypediagnostic: AS8PR10MB4903:EE_
x-ms-exchange-sharedmailbox-routingagent-processed: True
x-microsoft-antispam-prvs: <AS8PR10MB4903D0ED1179D74DA43A8E87A7349@AS8PR10MB4903.EURPRD10.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: JjIAyIBsrJzGZgIbD4lHU/U4/fEP0UUSTyCwbm0t0sFuCp6MS09FALIMsZpjVyLyL3FPULRf5y5N3hqsDAQ+k7RMKolw7o7GXniMzLRxg3knCCwnR8mVBh6nAC9KCPmEXEGN2rb7mk4oc+2iEz4aSjaQu3ZQJtcMikrjC/aSw2KcvpHVgEame07+0iJ2vQR2hCneCRKWgBYg0mLg6UOffZwOFsNFaMigTrYfuxQHb/L6HYRqLSi+FhPU0cQhLE7xfVVqkBYKtMvESEkvmSbDAgvLusAV9sX9KZufcfunCUY/epSLa/bAR24yj0brheZRCF1HXPCCWZ5+Xk8vW1lNPG66GGRWt+vFjFurInsrS5E3/r+DfhluiKzdqwAjGt2BtPgfvR4qCJGkWT2m9AfaJ99kbMW3JTqDKGJ9RcPoFw8fGOhD/jndVUiHgBsuwuDJZrGySrzD3WzXuUWtlsXst8T0GyDRDeIZze6Li/qYM9+ImoZIfoflPnf/CBO3QbAStvJvf+U2XwDgV7ron0Li/qUObG3aSO7YeBAgYj/eTNYgHwKWKmEOfVvYJMRPMvki7MRAACQVzmKyLWgQWWDNFjmdg4cvO9Eub//51fv48SHW6ZmUFy8DBCNERgqZuBn40cmYjxsiBj0NVlIsQ7r15VJ/h0whYaMvanUfB7cao2WgR/DQltumgqRNmOpynZ+lfYKb++Pilgp98+tF2KjF8A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR10MB4652.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(76116006)(8676002)(64756008)(66556008)(66946007)(54906003)(110136005)(38070700005)(316002)(66476007)(66446008)(4326008)(33656002)(2906002)(83380400001)(8936002)(4744005)(86362001)(26005)(186003)(5660300002)(7696005)(6506007)(71200400001)(55016003)(55236004)(122000001)(52536014)(508600001)(9686003)(53546011)(38100700002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RlhXRHJuZGtUSEt4MVAvSWVNSjR1dkFaTys2NHdKdWtXSkY0ZVk3WWIza2Qx?=
 =?utf-8?B?bXFqS2NyVm9mUm9taXJrK1cvbUVMcTE0SmFuMHloUjRrTG5lS3lROXFVenNn?=
 =?utf-8?B?cXEyTjNmTXpjL0s2WGQ2KzdaeHJZdktlbHMzQ0NBVFozUmw0MGtJRmRpUUxx?=
 =?utf-8?B?ZDFIUVNCVkVJbEJRNnBER3hsUE5KWUQ2eklURGd2cW1lMUFNV1Bma0Y5V2g1?=
 =?utf-8?B?bmNXanJsMy9jZkhZOUdxSnFVU3dlcVk1cTRZdWVscTVkcldLYURqekxBM1Ix?=
 =?utf-8?B?Nk1La25CVkRiZHVnM0FubVdseVMzQVcveGRYZGVRbXRjSnc0aEpuQVVHYnl3?=
 =?utf-8?B?YS9ibVovMng0ZnRLdGhKTnZVb0lVWlZnYUlIYlVXdmg3aStWWDBYQ29Edmd5?=
 =?utf-8?B?bXg1WkJUMFNRWmpnKzN5aitHd2xXYVFJak53Z1NKM1hWeE43MTFtVlBMRUF5?=
 =?utf-8?B?cy96Z1JXWC9EbVZuSEtlbXN4OE5PcmV5MTVqVERRaldRVW5lWmkzaysyQzZ5?=
 =?utf-8?B?enF4dDI0RmZ2ZVJlSDBLSEhRTjlmbGEwNmtrT1JCbWVVRTU3OElFb1Eva2dx?=
 =?utf-8?B?dm0veVNJWFFkZ1lNWitYM0VtRFB5TDAwZm50Q3hITURmenU4MmdKaldmQTNT?=
 =?utf-8?B?RTVZUExpU1NtMTAvQXZxZzV5Ly9CNWI3ZThocXNFWDZKc3E4NW1YYXJPU0RP?=
 =?utf-8?B?cExVMTV1MHVNa1FldTU2am1NbC9BanUwS3c1QytiY0NaYTE4R2tMODBvR1Bm?=
 =?utf-8?B?WEhMTWtobkYvQU8xRkdCaWsxOXZWVGdaV2EydGtoellLQzFjc2dkTGVzNEFo?=
 =?utf-8?B?Qk1NMExkTVFLUGgraXlLN0VQbGNRWXcyT2p4Yy9lTk5DcHNLRVN2T1pwamNl?=
 =?utf-8?B?NCtWRVZLMlNLOVpFK1ZScCtmR2Nidys5SEhYWXRPVE0ycStDTnd2V1lsT0cy?=
 =?utf-8?B?bmZvdThPK2twQTRaOFNGclVoSmc4T2xMSTdwcWtQRnF2RXRYQXB4V2VxOWlC?=
 =?utf-8?B?cGpWaHdKREtCSEFPWkE5dDdrNE1qK0ZJbEZQOEZTZFM4eFhZVDhpNVhaZFk4?=
 =?utf-8?B?VEZicklvK3RLSEMwOEMwMkFTdGtFa2lITkZsVjR0M2VkK2h3eklWUDdXczhR?=
 =?utf-8?B?UmpkT1hmVVNTcHdJMU5neDZQV0dqcWxlK3BrTEtReTN5K21IRk5HQzRFcFlL?=
 =?utf-8?B?Z2daRDloaWJJQzVzMXVpUXFOaU5BRSs5L3Y3L1ZHWjNXRnNZaEFMclpCWjBt?=
 =?utf-8?B?MVJRT2VBRHhacFk3ZXpaNUJtTkVaODVkVkpmSUJiY3BkN3FESFZjMjg4cDJT?=
 =?utf-8?B?M0RUZENHRHBiSWs2ZmxOdUZSNDc1VTdIa1lSdE53d0dmcVMvbWlpcmZvSGRJ?=
 =?utf-8?B?dVdUZlQxUVMvNCs3TnRIaUtYUnI3blM3bDJiK3duY3VFdkZTSnFGenB4QUdD?=
 =?utf-8?B?Wnc5NVh1bm11YVYrd2pQVmJqME40L0tBdGN1MHB0aDBUa21hOXhPVlpYTVVw?=
 =?utf-8?B?U3NLSFVsMHZ6c1pIeDV3MnBaRXU3ZWZYbkxQUFVnc2ZLcm1uMlAxTDBRWXRC?=
 =?utf-8?B?OFBidU42azZqT285VmNnUFFKekN0NExyVjYvelArSkw0S3MydDZ2UEpRTFRI?=
 =?utf-8?B?UFk5aWc4a3dSY1BBc2JvMDRSaXQ5RDlGWjJYTWhtMXFudjVOMGZueTQrb2Ru?=
 =?utf-8?B?M0NjdlV0RkZXdDZjNjZmOVdKM3pXRDJTRVRnVVJFa0tVemo0R1pBei9IdWN4?=
 =?utf-8?B?ZTQ0dTlpNUdHb3pwbkJySGcySkR1eUJqNHdWZGtSUDc2T0NzNUZ6bXI3UWds?=
 =?utf-8?B?QVFIMjlnRVhDaEMwbXloQkY2S3ZWaTlmQzE0cDBVSURKbEsyVWo1WmdHNUVJ?=
 =?utf-8?B?WCs5SCtJcERyelAzRUtUd0dSanJWeFIxTmVlQlhzV2VnQjVQeklGSHoyWFlY?=
 =?utf-8?B?aEt4b1F1Q2NrWFRvNGwydGpJbmRYakFsQU5hVzVBcU1TWUpsQVBiRE5yb1NX?=
 =?utf-8?B?eGRDeWhrek9yYWQxUHorSklSQUlhQi8yTnZ5T1R2SGs3MnFnQjd1UFJMdlFh?=
 =?utf-8?B?ZDBOSnpNbndscU1GdnhvSzlzZ243YVBLS2RjaTJhT0NRWHJwRHI0aUZtVHlz?=
 =?utf-8?B?NFg4Si9reEQrSDhrMXdtQ0gxb0NyTWE3ZjZKNnZQaDJIbEtMc2t0eVFiUUxG?=
 =?utf-8?B?T2k0cDBuWDNoSEkraFhLYnlST3NpYmhLRXlJTlgySVN6SWEzMndpN0ZkVVly?=
 =?utf-8?B?YkUxVVRSMkxrRDl4cGxUSWlrcEx3PT0=?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: diasemi.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB9PR10MB4652.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 04c6740e-4eb8-4eb3-e16b-08d9f063ce58
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Feb 2022 09:16:10.1964
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 511e3c0e-ee96-486e-a2ec-e272ffa37b7c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nFlIbJoibdvfNRxYH4BUbVnd72LBQLCjA1bCC1cGOaHCv73TonBtEYzmyOdFhPHjOn1FGmK0ITPP4/xGLoOvv1dlyqbPqfGoiKOvpQTjjGk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR10MB4903
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMTQgRmVicnVhcnkgMjAyMiAxODowMywgQ2hyaXN0b3BoIE5pZWRlcm1haWVyIHdyb3RlOg0K
DQo+IEkgY29tZSB0byB0aGUgY29uY2x1c2lvbiB0aGF0IHVuZGVyIG5vcm1hbCBjb25kaXRpb24g
KHJvb20gdGVtcGVyYXR1cmUpIHRoZQ0KPiB0aW1lb3V0IHZhbHVlcyBjb3VsZCBiZSBpbXByb3Zl
ZCwgYnV0IGR1ZSB0byB0aGUgdXNlZCBpbnRlcm5hbCByaW5nIG9zY2lsbGF0b3INCj4gb24gdGhl
IERBOTA2MSBjaGlwIHVuZGVyIGV4dHJlbWUgY29uZGl0aW9ucyBsaWtlIGF1dG9tb3RpdmUgKDEy
NSBkZWdyZWVzKSB0aGUNCj4gdmFsdWVzIGNvbWUgY2xvc2UgdG8gdGhlIERBOTA2MiB0aW1lb3V0
IHZhbHVlcywgaWYgYW4gZXh0ZXJuYWwgb3NjaWxsYXRvcg0KPiBpcyB1c2VkLiBJbiBvcmRlciBu
b3QgdG8gdHJpZ2dlciB0b28gZWFybHkgaW4gZXh0cmVtZSBzaXR1YXRpb25zLCB0aGUgdmFsdWVz
DQo+IG11c3QgYmUgbGVmdCBhcyB0aGV5IGFyZS4gQnV0IEkgdG9sZCBEaWFsb2cgdG8gYWRkIGEg
bm90ZSBpbiB0aGUgZGF0YSBzaGVldA0KPiBleHBsYWluaW5nIHRoZSBkZXZpYXRpb24gd2hlbiB0
aGUgaW50ZXJuYWwgb3NjaWxsYXRvciBpcyB1c2VkIChEQTkwNjEpLg0KPiANCj4gVGhhbmtzIGZv
ciBoZWxwaW5nIG1lIGFuZCBiZXN0IHJlZ2FyZHMNCj4gQ2hyaXN0b3BoDQoNClRoYW5rcyBmb3Ig
dGhlIHVwZGF0ZS4gSSdsbCBhbHNvIHB1c2ggaW50ZXJuYWxseSBmb3IgdGhlIERhdGFzaGVldCB1
cGRhdGUNCnNvIHRoaXMgaXMgY2xlYXJlciBpbiB0aGUgZnV0dXJlLCB0byBhdm9pZCBhbnkgbWlz
dW5kZXJzdGFuZGluZ3MuDQo=
