Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D27CD4C3102
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 17:10:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229846AbiBXQJy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 11:09:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229581AbiBXQJv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 11:09:51 -0500
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2062e.outbound.protection.outlook.com [IPv6:2a01:111:f400:fe5a::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F2221965EB;
        Thu, 24 Feb 2022 08:09:10 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UEkpGcgjh9JpffU6nHqOR4QNvnXJQDDZZjMN3Y7DlXHKCsBmi6WlHfZ4rrrfMPp8ocPpkP/vIlflAZcWbX1N6MCpdtr8+paG+DqiBUNW+PXq9wcBDRdh+5im9vS1HtrjTEvTO7hXA1ZGRHfQyuUqkCoWYWq/lA/nSvc/pfsOHd2Q6YTTx6pVMm5YDp3K7NWs9VK5Oo+4Y/AVb39ykYdq8pXNGi5D9JWAiCqfnZBl+SMvgC87GQgoiw1QT7ZFy3Om0Fk09r+xFhFrCNMmg15rQY81BW/jA5JSqY77oBwOxgwdliaZRz+M/IWy1S0y3rwG8OrsIv9eWtXm/W0oY8TZPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ge+u1WbVb7+B4FVk8rKtahRGZdxqABpmO3g6jMGBlFg=;
 b=CWKrhU+otWSH49yTb5TjUgPu0TbuGzzYJHJPyQ1pLjI1hEuXXI+xInZDms6y0GxatU4rn0tPLNAHduUY5GmGQomcqA69vs+zg0vWQVXo5W787cgYcyza1pGnk2UFwV7csRr3brnYT3++cg07FkWxn7CPFu806crurMQLTyy5/ujX9X1+dXDeNJ2yWzmpKycLgz/CqViftdhsXb/FID7TTTHT91WcBiFWS9V4yoh9SQIhXowqhnWEnrMzsJjehZv75j5m8asDlH3VEcZumIbChN5b7nfgW16t/K+aB3zFfKCLGD4SqtRBX4yNbnWyyzxmovWx5j2/IIeD4txwfMhhpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vmware.com; dmarc=pass action=none header.from=vmware.com;
 dkim=pass header.d=vmware.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ge+u1WbVb7+B4FVk8rKtahRGZdxqABpmO3g6jMGBlFg=;
 b=Mu6Jfhi8Vh6awDjNFcQIKFif9MBZNT2UEmi8h8oUYXPNFVay7tvEE8FpZQV2zpPe6lhYG+oTydVhN3JvrkU7hKaAdTLiUkpxhyeLnAkrLRwOmWvW4m1+U3pbtO6Bj2HgiFHCsooyfKp6Vde8lsMQncUzrBgj5B8EPdjKFOBw+Wk=
Received: from BYAPR05MB3960.namprd05.prod.outlook.com (2603:10b6:a02:88::12)
 by PH0PR05MB8368.namprd05.prod.outlook.com (2603:10b6:510:c6::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.9; Thu, 24 Feb
 2022 16:08:25 +0000
Received: from BYAPR05MB3960.namprd05.prod.outlook.com
 ([fe80::8587:7d16:1dee:4a4d]) by BYAPR05MB3960.namprd05.prod.outlook.com
 ([fe80::8587:7d16:1dee:4a4d%7]) with mapi id 15.20.5038.009; Thu, 24 Feb 2022
 16:08:25 +0000
From:   Vishnu Dasa <vdasa@vmware.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
CC:     Jorgen Hansen <jhansen@vmware.com>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "dtor@vmware.com" <dtor@vmware.com>,
        Pv-drivers <Pv-drivers@vmware.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>
Subject: Re: [PATCH 3/3] VMCI: Fix some error handling paths in
 vmci_guest_probe_device()
Thread-Topic: [PATCH 3/3] VMCI: Fix some error handling paths in
 vmci_guest_probe_device()
Thread-Index: AQHYHs1qh1rsU2MYvUCsLtTWA1uvXqyOZHUAgABjswCAE5CagIAANS8AgABl9AA=
Date:   Thu, 24 Feb 2022 16:08:25 +0000
Message-ID: <5870CB73-6B33-43D2-926F-188EEB757A41@vmware.com>
References: <cover.1644531317.git.christophe.jaillet@wanadoo.fr>
 <c5c1a5f3547bea3c4a1cfb8474db683d83c0ca1d.1644531317.git.christophe.jaillet@wanadoo.fr>
 <20220211140950.GN1951@kadam>
 <1bc15512-d811-b26a-d4f3-e14b30730c00@wanadoo.fr>
 <85DB8130-D600-464E-9717-1A0AFE795EA7@vmware.com>
 <20220224100330.GO3943@kadam>
In-Reply-To: <20220224100330.GO3943@kadam>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vmware.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 577a7ce1-5427-4d96-873f-08d9f7afe335
x-ms-traffictypediagnostic: PH0PR05MB8368:EE_
x-ld-processed: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0,ExtAddr
x-ms-exchange-atpmessageproperties: SA|SL
x-microsoft-antispam-prvs: <PH0PR05MB83685ACD5025B67700564C50CE3D9@PH0PR05MB8368.namprd05.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: pFmmohnBBo2JocDC1ho2kplHMvPr8popUrwsqqYXuChiAC+hHlfgB4ErT4QRKiAuq0V6VzJuV6SageuDbxWExbyhoXLgPv1cGxc/7OGpJvmPCo0ENLOXf/+OQhdgTJzFVNPzridFPvDyvsnBxJ+0ELjRbMosJJDJRNi8QCCTowfUCnEWUAy/Msf2rmr4RHPi1OnfQUS0PWjw7Sf2AuXUx0kHQi52XrsXWlkWjM1mfvsSz1qHU1EsOU7cf1k3pXrW/aig3n6MOBHKQAHuKx93Yde9o79z/MK79aPyaIHs+qfsfLOb/qWoJoXzd5o/CtiS4kBB8auPQhFklAA+9JFS3jt3OspZCT1dhy7RObybjBWn065vtUH6EjRCWnAefN/fTfYQSrrltucB/wkDx/G3rpVql2ARK/scWjPtpz/WWCZlkYNdN49B7EFyLyN03j0LZP0XaCUbNMnG0fXyi96oylldtHPwXcHldLt4A19AFsG82nrHm0eHlW9BgMsptPbL5kTY+Z8Yr08U4lC8ZRJa62g1yotV/MupfQgzlMHkILgBUAHQvHj/6cvkbIRcNhyUbHDpT9pdmorl5IJCsoycb0vCD+EbwM/foX5kZrOBO6MGBFmdFqMq7S3A9XfWw02sM/KYdDsx/6fAVXQZF6O4xbnXBIlxMjaMr3nSMOXe1IFoBF/j1Y0Ykpa2BXPz6DlSaANtd3eIlPeh3C6VZD9Z9khDiWED442yKKdfAP2/+kmbF7To56bdSSp1PF4a8VM7GbxMcbgdI43OMG5lyLLTyCaBAeLppuTia+jyuVshccA=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR05MB3960.namprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(66946007)(66556008)(53546011)(76116006)(66476007)(6486002)(4326008)(8676002)(64756008)(66446008)(38070700005)(6506007)(316002)(33656002)(2616005)(2906002)(8936002)(38100700002)(6512007)(122000001)(508600001)(5660300002)(71200400001)(86362001)(186003)(66574015)(54906003)(110136005)(36756003)(83380400001)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cklRak50WFduQVhSNmEwSlRlcFA3UHMxYjZPMG9Nc1pZeGQxaURYN1pnRE5T?=
 =?utf-8?B?RVJHTXJjamlMdEZ6NmtlMWp0anQycTRkOGQ5K3BpZFJIcG5FU0d2SEJoWWhQ?=
 =?utf-8?B?OVRiaktzUXBXTkFvWWdYd2Y3eVl0ZFJlaWErcFNvMFJ1YThBQVBtMElXUnZm?=
 =?utf-8?B?eWl3ZUZNZHJiTXpEN25NMXYzMi9hS0F2NHBGekllbGVPR0t4WmRzZ21YVTY2?=
 =?utf-8?B?bDB3ZWtHTFE4Ni9ES2tGYzhSRmdKL0VmZklzZTY0TVFzNmx3MHNWcnl4QlJ0?=
 =?utf-8?B?WHgwclFIRnowS1l0SjdqZWF6MUtxc3VqYVRsOWswNWh6RTVDSXhWd1BBWFJQ?=
 =?utf-8?B?OHZUVnE0ZTBEcEZxcitiTHhBTUQremh0VXFHNWhxcjA5dVVaODJXL2tHWVRX?=
 =?utf-8?B?dFhhNzFlb2RubUw3RVk3ZE4wRmJ1dW53K2pFSlNYdzJNdUlpbm1manFaSzVt?=
 =?utf-8?B?VUtkTkdkcjNEYjV6Tm9vcm9iWFdJZWZRV3d6bVkyYjRCdnZpVDltNlV1R3Zv?=
 =?utf-8?B?WFVsNW9ab1cwNEFwbVhqWEh0dEtFRW8vVGNGNGNTNWRNMitrRW9ibGVyRUZN?=
 =?utf-8?B?WmxjRkV5a1BxaitRbHRxOVV5Z3luL2pWQ3poSGNITlZycjZMc2MydnY0dld1?=
 =?utf-8?B?MWpnK21yRlQ1VDZZV0lGK1c1QU8xdE5ZZ3ZjbWFUK1pzSGNTNGRDNnVtTEc0?=
 =?utf-8?B?RnREYzdDYVRiZDZyYTJUU25JNmtXd25XSlVxdUJPYWhXbHo0WkZvZmpHUHYw?=
 =?utf-8?B?VWlndjI5dWtOT3YxWXA2MVZLcnBJVDlUVG9hYkE2a01yS1FlNUEyUzdzVEFz?=
 =?utf-8?B?QXJnVXh0OTQ4V0ZNNFhySmxIbTArQkltNmI0aHFDR3VmOU1PbVB3WmxGZUE4?=
 =?utf-8?B?OXpxU2xYVlVHNVRGV1VnWlQrOFlJOUtyQm1EMTY1RTJoRVNRekZlVkZ6UWFP?=
 =?utf-8?B?di9UY1ZoK1ZobGllZVVUUlYwQ0xyUXlrUGl3eUVKV054SGRCY1QvZFlHWXE0?=
 =?utf-8?B?K2ZKRy9kclI4UkZOa05QWUN0N3diWEhwbmowbUh5TDNOVHA4Ti9hZEFtTnNK?=
 =?utf-8?B?STdOanR6UE1PWVo3ZlU4bCtDc3ZsVlpXSHMwSE01aVNwY1NjdzRhN1NqbzlO?=
 =?utf-8?B?KzIxVEVab1NYejh1Z09QTEJXWEx0VGdld0lwV1VSZFNTTUN0ZUxCNEQxT05B?=
 =?utf-8?B?QVZxclVPNXBQQS9jTWk0UW9iWENTSEI5cnordzhobFN0RXhKYndVY2pBUDFU?=
 =?utf-8?B?aWVIR3VwY01XNnNFYlBjN3B3UW1IWklaVXpaQ1dVWmtaWmlnNVdoWlRJaTh5?=
 =?utf-8?B?OTMxNVMrakJCeUtSb1UwMlFxbE1CUTRlQlFMQ1RMMW1hVXllbk1XMEtQMU1a?=
 =?utf-8?B?Q2gyQ3U1NWs4NDZiZUNCdUlrVnFTeTVIc296RExBa0dFK0pDVDFhYzNtMjIy?=
 =?utf-8?B?OW5pWHBNODlYNjJ1T28vOWF4SEZaSVp6aENVYVF0eStVQmhrKzN1WTJCVWlL?=
 =?utf-8?B?SWZuOXpIZGQ3TE5WQWxtWm4zOSt2aFpqQmVSNWFNbkF0eXlaQ2FzMEZEUWJu?=
 =?utf-8?B?ckRLMlRKREllcXEwMHJ3aEhuZTJITW9JbStRSUVJMk5mYzJJVDk1TkdHaU94?=
 =?utf-8?B?eVJPeEFxTUN6aWt3K291ZmdlbkZoZGt3QTRFQ2ludzZRYUtNWHdVY2NrdmNQ?=
 =?utf-8?B?N2E5QVBUZ2gwUnRGMUFFZStQeDlkVTJUcStjRnpOMlRNQ0ttRjZFU1I3dlJF?=
 =?utf-8?B?a0tBa1diRHZEbHk5ZWx5NmVRbFBzOWdyb0FoQXlkRmNsTWhmUkp4MTJqSEI0?=
 =?utf-8?B?YmdqU2NocHRJNThoa2NsQVdlaDZhckl4STdoWjlXQ2ZTSjhkQ3hud3FaUGp4?=
 =?utf-8?B?blEvRzFJL3lreEJ6dm9LOFZQbFhhMnovUVJHeUQ5L2tIUDNBSEZkUXp5Nld3?=
 =?utf-8?B?eWg2TloweHFWRlJmNVFMWGU3NzNxWlNnNERtcllkazlNTkdneG9aNWxERzc5?=
 =?utf-8?B?VWtydlAxQXg1Y0NPMjJFWEJtNHNjWFhPNHBndk1tbkZndTVaUTZBNGJUN3lG?=
 =?utf-8?B?YlR6dEFWeHI3ZzZtRy8weUk4V1loYmsvV2l6cmFBbEhHNDFycTNRYVdBSWJy?=
 =?utf-8?B?bmxLeXlheWVvVGsraDRFMGR3TTl0NFJRTWtzYnhaYTE4YnMxS2pJQjVkbG1x?=
 =?utf-8?B?N3gxS0FPZ0xQZEh5UVdvVTJHdW9LQmpHVjNUR1RlU3VTVmEwb2I4VkxoUGVj?=
 =?utf-8?Q?4iz7YVvJQnY2BxLJ7wMGZqPJY6ZbDfXv0HBg14k634=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <659B835C002C624C8CFD5223B95EA89C@namprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR05MB3960.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 577a7ce1-5427-4d96-873f-08d9f7afe335
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Feb 2022 16:08:25.1503
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ktdh0Kx+QoVWHgdafGtIBUkWXsg64neq9CZ+tMxEni6hfssgPxfm0M+jRKiMKIfhZiiHWV5EAGvnsSfEaxUDbQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR05MB8368
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gT24gRmViIDI0LCAyMDIyLCBhdCAyOjAzIEFNLCBEYW4gQ2FycGVudGVyIDxkYW4uY2Fy
cGVudGVyQG9yYWNsZS5jb20+IHdyb3RlOg0KPiANCj4gT24gVGh1LCBGZWIgMjQsIDIwMjIgYXQg
MDY6NTM6MTBBTSArMDAwMCwgVmlzaG51IERhc2Egd3JvdGU6DQo+PiANCj4+PiBPbiBGZWIgMTEs
IDIwMjIsIGF0IDEyOjA2IFBNLCBDaHJpc3RvcGhlIEpBSUxMRVQgPGNocmlzdG9waGUuamFpbGxl
dEB3YW5hZG9vLmZyPiB3cm90ZToNCj4+PiANCj4+PiBMZSAxMS8wMi8yMDIyIMOgIDE1OjA5LCBE
YW4gQ2FycGVudGVyIGEgw6ljcml0IDoNCj4+Pj4gT24gVGh1LCBGZWIgMTAsIDIwMjIgYXQgMTE6
Mjc6MzRQTSArMDEwMCwgQ2hyaXN0b3BoZSBKQUlMTEVUIHdyb3RlOg0KPiANCj4+Pj4gV2hhdGV2
ZXIuLi4gIEJ1dCB3aGVyZSB0aGlzIHJlYWxseQ0KPj4+PiBodXJ0cyBpcyB3aXRoOg0KPj4+PiBB
bGxvYzoNCj4+Pj4gCWlmICh2bWNpX2Rldi0+ZXhjbHVzaXZlX3ZlY3RvcnMpIHsNCj4+Pj4gCQll
cnJvciA9IHJlcXVlc3RfaXJxKHBjaV9pcnFfdmVjdG9yKHBkZXYsIDEpLCAuLi4NCj4+Pj4gRnJl
ZToNCj4+Pj4gCWZyZWVfaXJxKHBjaV9pcnFfdmVjdG9yKHBkZXYsIDEpLCB2bWNpX2Rldik7DQo+
Pj4+IE5vIGlmIHN0YXRlbWVudC4gIEl0IHdvcmtzIGJlY2F1c2UgaXQncyB0aGUgbGFzdCBhbGxv
Y2F0aW9uIGJ1dCBpdCdzDQo+Pj4+IGNvbmZ1c2luZyBhbmQgZnJhZ2lsZS4NCj4+PiANCj4+PiBB
Z3JlZWQuDQo+PiANCj4+IFNvcnJ5LCBJIGhvcGUgSSdtIG5vdCBtaXNzaW5nIHNvbWV0aGluZyBv
YnZpb3VzIG9yIG1pc3VuZGVyc3RhbmRpbmcgdGhlIHBvaW50Lg0KPj4gQnV0IEkgZG9uJ3QgdGhp
bmsgdGhlIHByb2JsZW0gaW1wbGllZCBoZXJlIGV4aXN0cz8NCj4+IA0KPj4gSWYgJ3JlcXVlc3Rf
aXJxKHBjaV9pcnFfdmVjdG9yKHBkZXYsIDApLCAuLi4nIGZhaWxzIHdlIGdvdG8gZXJyX2Rpc2Fi
bGVfbXNpIGFuZCB0aGVyZQ0KPj4gaXMgbm8gZnJlZV9pcnEgaW4gdGhpcyBwYXRoLiAgSWYgJ3Jl
cXVlc3RfaXJxKHBjaV9pcnFfdmVjdG9yKHBkZXYsIDEpLCAuLi4nIGZhaWxzIHRoZW4gd2UNCj4+
IGdvdG8gZXJyX2ZyZWVfaXJxIGFuZCB3ZSBkbyAnZnJlZV9pcnEocGNpX2lycV92ZWN0b3IocGRl
diwgMCksIHZtY2lfZGV2KScuICBOb3RlIHRoYXQNCj4+IHRoaXMgaXMgZm9yIHRoZSBwcmV2aW91
cyBvbmUgd2l0aG91dCB0aGUgY2hlY2sgZm9yIHZtY2lfZGV2LT5leGNsdXNpdmVfdmVjdG9ycy4N
Cj4gDQo+IEl0J3Mgbm90IGEgYnVnLCBidXQgaXQncyBiYWQgc3R5bGUuDQo+IA0KPiBJZGVhbGx5
IHRoZSBhbGxvY2F0aW9uIGNvZGUgYW5kIHRoZSBmcmVlIGNvZGUgc2hvdWxkIG1pcnJvciBlYWNo
IG90aGVyDQo+IGFzIG11Y2ggYXMgcG9zc2libGUuICBJZiB0aGVyZSBpcyBhbiBpZiBzdGF0ZW1l
bnQgaW4gdGhlIGFsbG9jYXRpb24gY29kZQ0KPiB3ZSBzaG91bGQgY29weSB0aGF0IHNhbWUgaWYg
c3RhdGVtZW50IGludG8gdGhlIGZyZWUgY29kZS4gIEV2ZW4gaWYgd2UNCj4gY2FuIGxlYXZlIHRo
ZSBpZiBzdGF0ZW1lbnQgb3V0LCB3ZSBzaG91bGQgc3RpbGwgaW5jbHVkZSBpdCBmb3INCj4gcmVh
ZGFiaWxpdHkuDQo+IA0KPiBBbHNvIGlmIHdlIGFkZCBhbm90aGVyIGFsbG9jYXRpb24gYXQgdGhl
IGVuZCBvZiB0aGUgZnVuY3Rpb24gdGhlbiB3ZQ0KPiB3aWxsIGhhdmUgdG8gYWRkIHRoZSBpZiBz
dGF0ZW1lbnQgYmFjay4gIE1heWJlIHRoZSBwZXJzb24gd2hvIGFkZHMgdGhlDQo+IGlmIHN0YXRl
bWVudCB3aWxsIGZvcmdldC4gIFNvIGl0J3MgZnJhZ2lsZS4NCg0KTm8gZGlzYWdyZWVtZW50cyBh
Ym91dCB0aGF0LiAgTWFraW5nIHN1cmUgSSB3YXNuJ3QgbWlzc2luZyBhbnl0aGluZw0KZWxzZS4N
Cg0KQ291bGQgd2UgaGF2ZSBhIHNlcGFyYXRlIGZpeCBmb3IgdGhpcyB3aGljaCBmaXhlcz8NCiJW
TUNJOiBkbWEgZGc6IHJlZ2lzdGVyIGR1bW15IElSUSBoYW5kbGVycyBmb3IgRE1BIGRhdGFncmFt
cyINCg0KVGhhbmtzIQ==
