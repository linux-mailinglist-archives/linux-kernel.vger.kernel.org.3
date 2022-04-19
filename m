Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E431050655F
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 09:11:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349085AbiDSHNc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 03:13:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229941AbiDSHN2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 03:13:28 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2047.outbound.protection.outlook.com [40.107.22.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D4022C66C;
        Tue, 19 Apr 2022 00:10:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XPoESuKbpxDtYHdVCCXoInmbePO9FCKUQmrlaP9tBh9p660dIg4+DcSPcDxRcxSFhgnPV3yksclGXy9mAWoKajPidF3KV/0Z+N/THE8xFvw/ZhwiJyI1yFh2UknAykuSOuLWANTyXsRBNuWLtkfVt8s9t4xLJHgEa1CneCWtkbCKMsWGjllrZ+2gsqpZJ1pBrGemxHlvIW9fF/ykh7pjY/KwJThOOieBly5U+aLDlBWy2pKw05+3bEtyj9C564WLYcdssCfQ68GVAMpgd0EKu17vplcpZHiOVPZfxfBB5jvIaT+wxDch/m6M18Qu3Bf2ceisQaEyk3SgjjZp5z9f8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BLFjJu1a9qmcF/ooUlhmxQtK9tk4YfIw7heB1m4KTd4=;
 b=GbzCwKbHQcNVR84yFrkA9OT8Dkzg3Y+6Qo2smXgEiEcC3wnvzHeDHiKpxo0L1JwwMAhHiC7kU65sDxgSqgkkuUTGDasQbzoIFkzVZNlq5yCC+B4Xn6K0VGReVckiBGAlwrSzG+lMkAkbH4Usog/3k1hUrFjjJO0TzoQlZQJ0FQWRwHWlDPeZt6pC7KsknO/ArqFmhkxzfsej84WakkloOhHpbAZ06rUatuYf4+66xVcxUF6f2KMWa9V53re8VD44RhngeqX9ki5bfLphoZOlKHw7atvz0m2SDDTCCc/1MzV/k+dp3rgSFFTcLTzFHa2fEojOAEbXFYrLKYrlYKXVMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BLFjJu1a9qmcF/ooUlhmxQtK9tk4YfIw7heB1m4KTd4=;
 b=gkD31ibD9uK2JTkxLjTxYVoIR05xiqweXIqfite/TdoFcdNhEH0FfoTL6RfT1+B0Z7RSFJnRhKGGG3Wg/cMEP/QhYsqFdZlGw4AguglLZgF19Ee5PjQY3iEQmI29Hq4V7rsWjFNCJVjtrbXaZ5Efi+R0SlkPJs9H/rkWQarQNmckwm3xRFlGoxuZKqD6yYl29VlirK9QPbGmGIOHND2XC5HbZEm7J3XfVVrfai+7e06JUnrm3G3HTHWxvhnVnULRFgVch50S4XJWQ1MutSHyqUxLw5uF1ViX2Gh9jzUrPpKVZRK6Bq7k0gdZL3ZKb/TOdOc3huMOQmFLTvwNaKI1fg==
Received: from AM4PR1001MB1378.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:200:98::12) by VI1PR1001MB1456.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:800:e5::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.20; Tue, 19 Apr
 2022 07:10:43 +0000
Received: from AM4PR1001MB1378.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::750a:d1ed:d78b:5fa2]) by AM4PR1001MB1378.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::750a:d1ed:d78b:5fa2%3]) with mapi id 15.20.5186.013; Tue, 19 Apr 2022
 07:10:43 +0000
From:   "Starke, Daniel" <daniel.starke@siemens.com>
To:     Greg KH <gregkh@linuxfoundation.org>
CC:     "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        "jirislaby@kernel.org" <jirislaby@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 16/20] tty: n_gsm: fix invalid command/response bit check
 for UI/UIH frames
Thread-Topic: [PATCH 16/20] tty: n_gsm: fix invalid command/response bit check
 for UI/UIH frames
Thread-Index: AdhTvA6cW5ImLmcCQemjxAtTv3hl/w==
Date:   Tue, 19 Apr 2022 07:10:43 +0000
Message-ID: <AM4PR1001MB1378879B82FF126255EFB099E0F29@AM4PR1001MB1378.EURPRD10.PROD.OUTLOOK.COM>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_a59b6cd5-d141-4a33-8bf1-0ca04484304f_Enabled=true;
 MSIP_Label_a59b6cd5-d141-4a33-8bf1-0ca04484304f_SetDate=2022-04-19T07:10:41Z;
 MSIP_Label_a59b6cd5-d141-4a33-8bf1-0ca04484304f_Method=Privileged;
 MSIP_Label_a59b6cd5-d141-4a33-8bf1-0ca04484304f_Name=restricted-default;
 MSIP_Label_a59b6cd5-d141-4a33-8bf1-0ca04484304f_SiteId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;
 MSIP_Label_a59b6cd5-d141-4a33-8bf1-0ca04484304f_ActionId=baeb3ede-ecd9-49a2-aeb0-7fcb9b08f7ac;
 MSIP_Label_a59b6cd5-d141-4a33-8bf1-0ca04484304f_ContentBits=0
document_confidentiality: Restricted
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2d0c01aa-6e82-488f-13aa-08da21d3b815
x-ms-traffictypediagnostic: VI1PR1001MB1456:EE_
x-microsoft-antispam-prvs: <VI1PR1001MB1456FE5BC72084853EE2E406E0F29@VI1PR1001MB1456.EURPRD10.PROD.OUTLOOK.COM>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 6WvKESVteWLSxCFSWE1qVgNxBoWQ/iXXzs5ajEPJMhaISpeyHShBOBNwvw/aZGYOVZ5HvnQWRtMjZLCqTDtc586WQClcOQ7Zs9mdmkmlkwaHYR0lWqUwLWLT9f2svDq3d3MCtuhzEYxWmyrN+0GIIZ0hFVU8N0bvkD5AVTZgzM7y0OqAU+mb/TeUKshuIlEKp37uOALE6ZlEFFTKRRsBFLmzEVtaPixHcQYsUHr9UQ6Bk9GESiI2kgpO3VsXqftGlGSwMahB86fRDBbNZvuylYGrqkFPLzkaXp4RTATJA81cVZkrXcbOhuiqt2/aW3MSG8hmZF2yJxlQVC/Gv7yvOwEi3yhdhVTYYaOSpdWfP1QPSfXn3WjQ2soFALR/LPLdkt3or9NAFMKsSBFsTRo66PbOebFOoQjbX3Qmf1YUkRqm2tteDXuBfyuhNCZbS1h0G+ngyVGcfIimvGrYGjDuikK+8VDpt6I9ikXI2YBSjx2TxJZ4SfJ5Pzn8FZ6AQosXqBlRJ1BGOhxb9VDV6fBqMbE67ZboMfxDz9xscSBbhaWsECeRc6XQaMjc9W8N09GMW/UYj4xtkCyvVT+e7AdjKEFBONqWpUzBB40aBPaOZ6gEqiXTAwywc3aSPa3daRO3EPt5v+NC5vdhFP5AlCXcyMeHVmz34c+io3hEbdxu1F+HMdKnPULhs0Cmva9hRbIbZxvteCBehiGnHaX0lJ8WLJLxTiXONzW20WRmGgi5N/jb5mj0hqD4Wa19esAM+Cib6/SLLDfGAdpzUi2S9md+nHBV5/GoZeudEzbhWAv802o=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM4PR1001MB1378.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(66476007)(66446008)(7696005)(26005)(6506007)(966005)(71200400001)(186003)(6916009)(83380400001)(86362001)(55016003)(33656002)(64756008)(66946007)(66556008)(76116006)(4326008)(8676002)(122000001)(498600001)(82960400001)(52536014)(2906002)(54906003)(55236004)(9686003)(8936002)(5660300002)(38070700005)(38100700002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eXN5d0RhL29wby9MRDZMcUN6amtkbm5QcVdWeFBONGxUanFNTk1GaG5zTmRV?=
 =?utf-8?B?a1I0b0NvaDBUN1YrUHlNN1pTZWc5NEJ4Zmk3UmM3R0VRakE0MWREWUI3QnVo?=
 =?utf-8?B?TnpRSGI2YTBTQ1J5M2FpYnZJc1dkVWR3Z0ZYUE14WGxGNUExUGFyY0xUK3hD?=
 =?utf-8?B?SnZQeFhkM3ZScHFnMUNFZjBBdmpaeVgzc3lZaFhMZVQxamQ0L3JSblBrbWUx?=
 =?utf-8?B?RlJNOVNMRFMwZHVvbFJXWEZDNVY4U3ZHenVDQ1kybnc0MUQ3NE5oUXdPZTlj?=
 =?utf-8?B?c0pWWVNFQyt0RFhSRFFCb1Uybms1YVFiT05ZSjI5YTBSZUpMZHd2UWpBR1Zo?=
 =?utf-8?B?cHV1dWxub0lwSTNycTRaa3B2VGpzRHIvMkl2cXlGeDZuSWRVVlVabDVOM2xk?=
 =?utf-8?B?SHBpdjdlMUorTW1EWEphWURIUjIydGE1Q212dldQNGJPSGNZSHk1MURqTjd1?=
 =?utf-8?B?SGNnc2N6bU40QmpUUThpbmFBZ096SU9nTkpNeEc3UW4xRzBSUEZDeDN4a1pB?=
 =?utf-8?B?UE9RblkzWnVwcDUvMzdkQ1RTaDhKRll4UzJneTY3VnhiL0FoQmZOM201Sk9Z?=
 =?utf-8?B?MGVQUytGVzZaRXVqRFRTWUEwSkJObUNKTHk1Tm82VGpaeGJ1MHl1WmROZ1RC?=
 =?utf-8?B?QlppWmQ2MkhlUkVvQkl1QzcvOU8xdzZZNEFXUzR1M0pxZE45MDRDUkxOVXE4?=
 =?utf-8?B?QzdxeFRpMEtuSjVIa0lUVWdzN2JRNzN6Sm1vcHBCKzZXZkZDY2JKd3VOS25v?=
 =?utf-8?B?NnNseVJQSXB0SHBzS1lkMWd1djFCU1hiVm1xNWV3a0h4S2Zyd0FwbGJDK2ov?=
 =?utf-8?B?S0p2bHdJTmNCb29hbVZxZG1jTURndE8wZUZWVktlSkxVNXZJWEFUTk1vNk9K?=
 =?utf-8?B?T1VUdlFwUWU3bm0xckltMlh1dXVyNFhLaHdrb0svMjBnQnArTEI1bUtFNTNt?=
 =?utf-8?B?bGZtSzF3N3lZSUxXOXl2T2ZkMktyZm43VzRac3JkS2tBcGhBNXNVTXRhbXdx?=
 =?utf-8?B?bk1vUEE2a001S0kxRDE3TEFGRW01SUZtbVVVcHpCdnY2b2VwOFNIM3FXL1pD?=
 =?utf-8?B?bGl3cHZUc0ZVUCtSdC9rQVh6MytFbmU4Y0EvQ0lIM3hTbXR4MUs4K3dtY0xE?=
 =?utf-8?B?ak84Mkl2NFdDSjV5Mms0VmszVzBpYnAySDRpQzEyYTZibnFXaXU5VEcvVHBZ?=
 =?utf-8?B?NFhraVcrYmhBdkRIU0Y2L2dva0lGOHcvWTZtemZRMy8zekUyTXVzN2dhMFJw?=
 =?utf-8?B?dzllZm1tc2trY1lLZGs1a3g5WkdkbjlxMVQ4dDRib0hWa1B3MVhpZ1JFNHNw?=
 =?utf-8?B?dXc0R203aU1jWGNBTTVkRWtuVGxPNE5YNTB6R1hMRGExajlOTnR4eWpqc2NV?=
 =?utf-8?B?N2J1TU9UekpzLzQ0aFducXBuMFdYVUlpWU9HMU4wN01nbVQvNHllQjVNeW4r?=
 =?utf-8?B?U2Y2STMrbHRRTUdZTjRoWFhLdXdidi8zaTBweWtwVTVza1B2UDhwd0dkQUJ4?=
 =?utf-8?B?eFpnOXoxNTQ2QzNUbzdpbU1idjU1VU5acXpjdldCMk41V0RWRnlDZFM2ZXMy?=
 =?utf-8?B?RVY0Q1J2UGl0b1hyUWh5VlV3bVo3MTJEZ2xnUUY0NDVkMlNwV0pKK3FCWnpM?=
 =?utf-8?B?azB3ek81ODN0VVdHNnkyb2E5V09GbVJDamlwdTcyVmJLNXovbUlIc0xOZ0RP?=
 =?utf-8?B?S2liaVVRYUdnbTNZdnB6K1dJNkU3SFJkZTA4eVpLdE5Semd1eCs5Q25LZVVp?=
 =?utf-8?B?cmNUQmVKaVlFSkNnclB4TmlrRitrNXQ1QWd5VktYMWVDaStjYWpFLzhOOGVx?=
 =?utf-8?B?dmpYRXRHYUY4eFhrZXBYb2VLOTAvQmF5ejdWR1hqNkdMeGRJZ25IVWpHUFRV?=
 =?utf-8?B?SjEzRXd0V2lLenlzS3VwSW00VlUzZ0Z1NWkrbDNWZld2YXFJbkJOUnJrcU1Q?=
 =?utf-8?B?cWZJSkhNd3RqVlJGQ1NCQTZrU2pUVUhoQzVZQ3MzMGttTG5PQklKNUZNNWxB?=
 =?utf-8?B?YnRTeFRYL2RNaFRIQUlvOEtZb05oZGJiSi96eDNndmFtRHZtK2E3cGJSVllS?=
 =?utf-8?B?U0NUdlIxQWs2NnF5UHZwZWtzSnBxUmkxbjlpY3BVa1ozd1hzTmk3a2tobTNk?=
 =?utf-8?B?SHFxYUpMMTlNZHVzY255VEdLOG1odjFoZkEzbVA5U2l0WDVrZ1BRM0VqVm5j?=
 =?utf-8?B?M3d5S0dCRG4rWDAxdStlTnd1RUxUaHViWEVzandSMFF2WXVHckc1b0FSSVNo?=
 =?utf-8?B?NHZPbjdkN25GYTJJREk4YnAyTEhweDgvTXZqVnhvRTNjVHJaM1FGeFRVaVA3?=
 =?utf-8?B?MmswSnhqY0UreEJ2NWtuMmVvQ2xqNFk3NjFkL294R0NVaURwcUtlM09VZ3NS?=
 =?utf-8?Q?3vFsBvSkVaZJ8Gug=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM4PR1001MB1378.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d0c01aa-6e82-488f-13aa-08da21d3b815
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Apr 2022 07:10:43.6395
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: STP4SqqIFBi9C1gdsUK5m3FE/qIFOB4xCcrPcksj9MFZlKJuh5nnaHwSveJ7lwAKQnYgcWznflY88V2iMS2i8AZyJ4+/qozSUuSeQMwfp6Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR1001MB1456
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiA0MjoyMUFNIC0wNzAwLCBELiBTdGFya2Ugd3JvdGU6DQo+ID4gRnJvbTogRGFuaWVsIFN0YXJr
ZSA8ZGFuaWVsLnN0YXJrZUBzaWVtZW5zLmNvbT4NCj4gPiANCj4gPiBuX2dzbSBpcyBiYXNlZCBv
biB0aGUgM0dQUCAwNy4wMTAgYW5kIGl0cyBuZXdlciB2ZXJzaW9uIGlzIHRoZSAzR1BQIDI3LjAx
MC4NCj4gPiBTZWUgaHR0cHM6Ly9wb3J0YWwuM2dwcC5vcmcvZGVza3RvcG1vZHVsZXMvU3BlY2lm
aWNhdGlvbnMvU3BlY2lmaWNhdGlvbkRldGFpbHMuYXNweD9zcGVjaWZpY2F0aW9uSWQ9MTUxNg0K
PiA+IFRoZSBjaGFuZ2VzIGZyb20gMDcuMDEwIHRvIDI3LjAxMCBhcmUgbm9uLWZ1bmN0aW9uYWwu
IFRoZXJlZm9yZSwgSSANCj4gPiByZWZlciB0byB0aGUgbmV3ZXIgMjcuMDEwIGhlcmUuIENoYXB0
ZXIgNS40LjMuMSBzdGF0ZXMgdGhlIENSIGJpdCBpbiANCj4gPiBVSSBhbmQgVUlIIGZyYW1lcyBz
aGFsbCBhbHdheXMgYmUgc2V0IDEgYnkgdGhlIGluaXRpYXRvciBhbmQgMCBieSB0aGUgcmVzcG9u
ZGVyLg0KPiANCj4gVGhpcyBoYXMgbm90aGluZyB0byBkbyB3aXRoIHRoZSBjaGFuZ2UgeW91IG1h
ZGUgaGVyZS4NCj4gDQo+IA0KPiA+IEN1cnJlbnRseSwgZ3NtX3F1ZXVlKCkgaGFzIGEgcHJlLXBy
b2Nlc3NvciBnYXRlZCAoZXhjbHVkZWQpIGNoZWNrIA0KPiA+IHdoaWNoIHRyZWF0cyBhbGwgZnJh
bWVzIHRoYXQgY29uZm9ybSB0byB0aGUgc3RhbmRhcmQgYXMgbWFsZm9ybWVkIGZyYW1lcy4NCj4g
PiBSZW1vdmUgdGhpcyBvcHRpb25hbCBjb2RlIHRvIGF2b2lkIGNvbmZ1c2lvbiBhbmQgcG9zc2li
bGUgYnJlYWtpbmcgDQo+ID4gY2hhbmdlcyBpbiBjYXNlIHRoYXQgc29tZW9uZSBpbmNsdWRlcyBp
dC4NCj4gDQo+IEFnYWluLCBub3RoaW5nIHRvIGRvIHdpdGggdGhlIGNvZGUgY2hhbmdlLg0KDQpJ
bmNsdWRpbmcgdGhpcyBjb2RlIChpLmUuIHdpdGggI2lmIDEpIHdpbGwgdHJlYXQgZXZlcnkgY29y
cmVjdCBVSS9VSUggZnJhbWUNCmFzIGludmFsaWQsIGJlY2F1c2UgdGhlIGNyIGZsYWcgaXMgYWx3
YXlzIHNldCB0byAxIGZvciB0aG9zZSBmcmFtZXMNCihhcyBtZW50aW9uZWQgaW4gY2hhcHRlciA1
LjQuMy4xIG9mIHRoZSBzdGFuZGFyZCkuIFRoaXMgaXMgb2J2aW91c2x5IHdyb25nLg0KDQo+ID4g
DQo+ID4gRml4ZXM6IGUxZWFlYTQ2YmI0MCAoInR0eTogbl9nc20gbGluZSBkaXNjaXBsaW5lIikN
Cj4gDQo+IFRoaXMgImZpeGVzIiBub3RoaW5nIDooDQoNCldoYXQgaXMgdGhlIGNvcnJlY3Qgd2F5
IHRvIGhhbmRsZSB0aGUgcmVtb3ZhbCBvZiBzdWNoIGRlYWQgYW5kIG9idmlvdXNseQ0Kd3Jvbmcg
Y29kZT8NCg0KPiA+IENjOiBzdGFibGVAdmdlci5rZXJuZWwub3JnDQo+IA0KPiBIb3cgaXMgY29t
bWVudGluZyBvdXQgdW51c2VkIGNvZGUgYSBzdGFibGUgYmFja3BvcnQgcmVxdWlyZW1lbnQ/DQoN
ClRydWUsIGl0IGRvZXMgbm90IGNoYW5nZSB0aGUgYmVoYXZpb3IgYnV0IGl0IGZpeGVzIGEgY29t
bWl0IHdoaWNoIGlzIGFsc28NCnByZXNlbnQgaW4gdGhlIGN1cnJlbnQgc3RhYmxlIHJlbGVhc2Uu
IEkgd2FzIHVuc3VyZSBob3cgdG8gaGFuZGxlIHRoaXMNCmNhc2UuIEkgd2lsbCByZW1vdmUgdGhl
IGJhY2twb3J0IHJlbWFyay4NCg0KPiA+IFNpZ25lZC1vZmYtYnk6IERhbmllbCBTdGFya2UgPGRh
bmllbC5zdGFya2VAc2llbWVucy5jb20+DQo+ID4gLS0tDQo+ID4gIGRyaXZlcnMvdHR5L25fZ3Nt
LmMgfCA0IC0tLS0NCj4gPiAgMSBmaWxlIGNoYW5nZWQsIDQgZGVsZXRpb25zKC0pDQo+ID4gDQo+
ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvdHR5L25fZ3NtLmMgYi9kcml2ZXJzL3R0eS9uX2dzbS5j
IGluZGV4IA0KPiA+IGU5YTdkOTQ4M2MxZi4uZjRlYzQ4YzBkNmQ3IDEwMDY0NA0KPiA+IC0tLSBh
L2RyaXZlcnMvdHR5L25fZ3NtLmMNCj4gPiArKysgYi9kcml2ZXJzL3R0eS9uX2dzbS5jDQo+ID4g
QEAgLTE4OTYsMTAgKzE4OTYsNiBAQCBzdGF0aWMgdm9pZCBnc21fcXVldWUoc3RydWN0IGdzbV9t
dXggKmdzbSkNCj4gPiAgCWNhc2UgVUl8UEY6DQo+ID4gIAljYXNlIFVJSDoNCj4gPiAgCWNhc2Ug
VUlIfFBGOg0KPiA+IC0jaWYgMA0KPiA+IC0JCWlmIChjcikNCj4gPiAtCQkJZ290byBpbnZhbGlk
Ow0KPiA+IC0jZW5kaWYNCj4gDQo+IEFsbCB5b3UgYXJlIGRvaW5nIGlzIGNsZWFuaW5nIHVwIGRl
YWQgY29kZS4gIE5vdCBhIGJpZyBkZWFsLCBhbmQgbm90DQo+IHdvcnRoIGFsbCB0aGUgdGV4dCBh
Ym92ZSB0byBjb25mdXNlIHBlb3BsZSA6KA0KDQpBcyBtZW50aW9uZWQgYWJvdmUsIHRoaXMgaXMg
bm90IG9ubHkgZGVhZCBidXQgYWxzbyB3cm9uZyBjb2RlLiBJIHRyaWVkIHRvDQplbGFib3JhdGUg
dGhlIHJlYXNvbiBmb3IgaXQgYmVpbmcgd3JvbmcgY29kZSBpbiB0aGUgdGV4dCBhYm92ZS4NCg0K
QmVzdCByZWdhcmRzLA0KRGFuaWVsIFN0YXJrZQ0K
