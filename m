Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 359844C7D21
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 23:15:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231386AbiB1WPl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 17:15:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229545AbiB1WPh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 17:15:37 -0500
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2111.outbound.protection.outlook.com [40.107.244.111])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAF92E3C76;
        Mon, 28 Feb 2022 14:14:56 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dXjLng5Y0TYybZC3TFBU8A76rVcLxWK8XVe3B0FaftoRIV9qMhwciUZ8cWsMtRirDXqNCHp8uL/WaKyqznB77W45uP0NRtYwxZ0m13GHKzSELYts50xOEsaOpAc7ctiLlm6vEVJJYix7MVxTh1bv+1bSQCwgw9DB4wMPlUQgRNQ6a5o2ZpGnHQ51jMldFHujLFRASD3nO0zZbc3nbPBzpTwUc6Kmkvs5KliVis1ds6Fq8vqCcgIWB9SCKs+AhdaNTSmBO1DQRgWl7q1MpXtefXZI38WKSqteSljFPUNXa7nmgRuljxTkVofMOS1eRGTzDFwH7jpYLKJAxwACiQZHqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7F2iEyHwyQVpPwLf2AVOST1L8E2vyw1LM4zp/70bLY0=;
 b=jYSIuXKMhSnz69BuRq6lRRoEhGRYNDpGNUdnhz9JWYSesLsKfGQrt9DTuKrsNwPYFEqmy3uJA3cxYwt2lULer/GEVxMsLXRPuof44QcrvbqgmIQsViHB1GPk6MFxtHR9g14X6nN/Zk4bQaGY5qoxyLYt90qSZ6xZFHAhIL2RGaHFUwozFqy8ZFx9ptn82bAd4VYdO0Tee6LLyWYZYw07btgTHCZhBm85Sfc0zmwIY5AhyBq9W6iLtZjg3py9ulskHNmct658w0DKowd02n1SPYPih8KDantzsubCESuaFWguiO0Vg8RZ3vRviWo7sI32q9CHZ0nIg0hG1uIILw+xWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7F2iEyHwyQVpPwLf2AVOST1L8E2vyw1LM4zp/70bLY0=;
 b=DHXsgw1Ot7pWL9Fom94yLPlzrnsPv+lNZ6kC2x+5TtdiSbOZdBXTcR7cstm4RBiOjWfRgu1d3Ku9kCqy7dnCcjNOb0mGkhd2yTkPw/jretLIaOxTNNZBDCzgrqmB99S0wpUk+75HATUMKP2bXKC376EoTVSA3LlcOGzcaLne4Sc=
Received: from MN0PR21MB3098.namprd21.prod.outlook.com (2603:10b6:208:376::14)
 by DM4PR21MB3227.namprd21.prod.outlook.com (2603:10b6:8:68::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5061.1; Mon, 28 Feb 2022 22:14:53 +0000
Received: from MN0PR21MB3098.namprd21.prod.outlook.com
 ([fe80::69f8:51be:b573:e70c]) by MN0PR21MB3098.namprd21.prod.outlook.com
 ([fe80::69f8:51be:b573:e70c%5]) with mapi id 15.20.5038.006; Mon, 28 Feb 2022
 22:14:53 +0000
From:   "Michael Kelley (LINUX)" <mikelley@microsoft.com>
To:     jason <jason@zx2c4.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
CC:     Ard Biesheuvel <ardb@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-crypto <linux-crypto@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Alexander Graf <graf@amazon.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Len Brown <lenb@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: RE: [PATCH 2/3 v6] ACPI: allow longer device IDs
Thread-Topic: [PATCH 2/3 v6] ACPI: allow longer device IDs
Thread-Index: AQHYLNK4fL59pmJF2Ea4CQMRQ5s3a6ypbsWAgAAEo4CAAAbTAIAAB7CAgAACs/A=
Date:   Mon, 28 Feb 2022 22:14:52 +0000
Message-ID: <MN0PR21MB3098981B77F513976A62CA57D7019@MN0PR21MB3098.namprd21.prod.outlook.com>
References: <CAHmME9qHnvwrxEue4Pdm_E1qZQGXFuR9orJSKCWj8fH5TSh6fA@mail.gmail.com>
 <20220228183355.9090-1-Jason@zx2c4.com>
 <CAHp75VcjrD3kwN1BfWpjKXaVpG7MHfftMUscSGhcJfStm4b-Xg@mail.gmail.com>
 <CAMj1kXFmEAKJRHCiuXyGECCmOs0+xX9AVeBDxfuD0XuX2TQ2Uw@mail.gmail.com>
 <Yh0+LA8B1jw8tnl9@smile.fi.intel.com>
 <CAHmME9qW4EiYU6_kTffMdK5ijJY1DF6YRt=gDjj1vKqDxB0Raw@mail.gmail.com>
In-Reply-To: <CAHmME9qW4EiYU6_kTffMdK5ijJY1DF6YRt=gDjj1vKqDxB0Raw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=27f9db6a-7893-4027-b09e-d1754975a613;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2022-02-28T22:04:18Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2643d493-ec1a-4875-a2d7-08d9fb07be90
x-ms-traffictypediagnostic: DM4PR21MB3227:EE_
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-ms-exchange-atpmessageproperties: SA|SL
x-microsoft-antispam-prvs: <DM4PR21MB32275D81E525C8BB2DAFD83FD7019@DM4PR21MB3227.namprd21.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: kM3cBLhBlpfT3uplDDF5ajGWyZE6v1JVFDe+YudZy6jvw/9e4VC5NKSUpBXAz0rOSnCgEqvnZ5PbX4WO1JT4bdj9feS2h89xNVZ9lqGfHyMwXq+ujiOMBndOmNdXJiIJVNKaO9FFZVrIuRiKFEMfhwuhXj4YHRKXZYSp9mfRTnzUWCuaEvX/yf9605J/W2bAsMeF3hJl7if5wiwjcWJih9HI4w05gPM2vGoAwBjFSbTdr+hls2X7Wbj6WARLmDKvN7dziGpC8IdiFZiXgJ9rkyrgIad/KA4xXskXyYyEy+hR+B0nQeHka+d3qNAe73xs9JvpVfaJTZw3zdN3Bp+0oEwSS2Q27gve2IYJ7RPiv2F94Wo18yun0BFe844z1L9/DAVsBltd3bYju9YyDZdbNXglNU5hl1px5iyjSk/YBxNn3qXuH3ZbgGNHvNtBtw+vIotW/Wa010OvP6nthhSSfBd7AvXEHPu5bdM69lpSReJk27LuuLe3mvGrweXPsHlBp0s9ftMAT/PLeYg456dg+YrZK7NB+srFoI7CPg8U/M1QeUL77Zw49kzcE0mur7bl5YZ1GLSRfldMXZwqd4tb1+PQnOb6ZXzkO65MkW7J8AQxPg/N+yNXlRtH8CjVt2SdjQk/4eqp1igkIFaU9vggL7+c5zvFD/oyC8laLy2/MB8FgGN+vJH0KQz3jSqN3kphmq7pUH7UhBxgPtOeOGYsmMb5EStFWKJxXEOqU15Hk1HHKm8qb+TmbxB3lt3MMza4um1Wp2sP9Ru+zl7DMpx3ng==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR21MB3098.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(66946007)(66476007)(66556008)(52536014)(64756008)(8990500004)(8676002)(76116006)(4326008)(86362001)(33656002)(5660300002)(316002)(71200400001)(110136005)(54906003)(82950400001)(66446008)(508600001)(10290500003)(9686003)(122000001)(38100700002)(2906002)(7696005)(82960400001)(7416002)(38070700005)(6506007)(53546011)(26005)(186003)(55016003)(8936002)(148743002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ek54L0FjZDN5Qi8vRGI1TmJpdUNldWRvNkZTVUIyR2NGRE8vOTZ1Q2tueUky?=
 =?utf-8?B?UnVxMmRYTzF1WS9hUE1RQ25IOCtDeG5OazFRMGFmdkM1UURlR0NSUCtwM0F1?=
 =?utf-8?B?V0NwSVN2bHU1NDFaOUZTVFNaN1JkTHpoeUFvTFdLc0cyK2ZPMWRPOUcvT01t?=
 =?utf-8?B?cXN0UWdVb1dZanJqSXBQZnJNaVkvRGFXRjExanNwdmdXVVRFR3FIVHVreDdz?=
 =?utf-8?B?bnNOWkQxSG14UDEweWVYem9NUCs2RWNpYU5wODc5d3JJQmliSkFweXRpMkt0?=
 =?utf-8?B?Q2dGRkgwcm5rUS9vNjlUNGhIRk4vUlFML0JzVGhLQndicWgwR3c2cTBmbGs0?=
 =?utf-8?B?cVo1d2Y3YVcvR2ZmMFRldFVLUjI4a3h0Q29ianRBSDJ1RkVsOU1hUkYwN2Nm?=
 =?utf-8?B?U2FGT2VBaGFEWld2ckNob3IzVUFKaU1XaVRtNXlwZDUxVENDb0ZERUVNbXYz?=
 =?utf-8?B?Q013VlYwVHg0VkJjaWVPOVZWVHRLUHNoOXgvMFBPeElRZUFQK0JMV2U5eHVo?=
 =?utf-8?B?TkJpckh6MU11Vm15d3ZCc3V6Z1NxSFZGNHlKTHlaZVcxMWUzRXUzMXlJd2ps?=
 =?utf-8?B?QlhsZlhpcUNvUjZOZEhZK3pKOGlMWkxUM25qb2NrUmxrdUIxOTBxWjA2SEpm?=
 =?utf-8?B?QlZ4Y014QnFnVWR5eXpORm5sM1pkZE5nSUU2RHRqWjR6TEFwbVdPN1J6M3FG?=
 =?utf-8?B?NnVJSEtaTUtDM0dyRjFEanRyS2R2U05hN0YxdHpyUkhFTmI1cDRVeml0Q3Vj?=
 =?utf-8?B?dzh1L1lrTzNwWStEMVVsMnk1QU9ueUZEYllnVmVaalpyaStQTGRmUlRyL2s3?=
 =?utf-8?B?YlZUTitrZzM2ZjRBUkpwMjJhYVVJSWo3dXQ3RWNJNEV4UU4zU0l5anl6RTJB?=
 =?utf-8?B?L2ZqRklyU0V4emZpWHFBOTJoS3NVcFdTZ3I0akJYdWNqNWdVZ3F4aWlCT0JU?=
 =?utf-8?B?QTdDdHlMOFk2ZGZmLzVteVdKaXhBa2dYSjRWME1UR3hTVXAzcDlNVlNLRTFv?=
 =?utf-8?B?cDd6dlJSbUpNd1ZtTXZ6WG5xY1JRWnpVa3psSVlvNTJocVlRWTBjS3B5RTB3?=
 =?utf-8?B?b3pKUURCQmt6Yktqd2tFU1VMNXpkeE11Y1RKOExrQm5FN2xZdDc3SmJubnRo?=
 =?utf-8?B?dnEzb1BiVDB1RzBudWpneEtFK0pBSU93K010VU42OGI1aGcwZ2lESzJBKzkz?=
 =?utf-8?B?WHBoOHVtdHBFdlBDRTVxU2wyQkJnWnRUTTFzMnY2dXVFTW94enMzdW83ZUlP?=
 =?utf-8?B?UHlISDVZVWNCMzdYQkUwblF5OWFxdXZVOWxSeTJXaHVqQ1Q5bTltbHVVNTVv?=
 =?utf-8?B?MzBkZTVURmVBc1ovM1lVTStob2NRRVR4L3YrejYrSHNxZWFabTM4Q3l1Z1Rl?=
 =?utf-8?B?TlRFelJ1eElZSlNYOFhZc2l4YkFzMStEb1ZqRkllSnFObzRVbTFlbGxHenZT?=
 =?utf-8?B?ZmladDhYaU1nRHU0QnhzKzRVQXJkait6TXZTM1NPckZZb3M4cThNaUc2Y0RS?=
 =?utf-8?B?cDUzTHF3N0FuNjY5bHZjUTRPSTV1NElUZ3ZSZDJ1SXE4b28zczVFc25MOCsz?=
 =?utf-8?B?c2RSWUpLRERUS284Q2s2S1gzVkxmWDUrTkRubU1TZ2ZPaXZiVStMaDV6VlBh?=
 =?utf-8?B?cXpCazEzdlVQR2xGQUJzclRVZi9hT3B2Z1NMYUFtRlV6VGtqbkRUVEFlYjFN?=
 =?utf-8?B?ejhTam9sR1FkbjRLQXFIalhXdkVuTVlBTnE3Y09HMUp5SWMvM2kzVVc5VGZS?=
 =?utf-8?B?MnNJR3dkdWNOc1ZDMnp4UU52ZjFrT2FWdWc5OElEQXVneEhFQnM0RWV4YVVW?=
 =?utf-8?B?cnU0bmhmcFQ5bk5vSkFINHVVRTJsSm42SlBsaFdrNlRqNmtNMHlScEpPOUZI?=
 =?utf-8?B?TzNySmhhVzlvYkdDWFgzN3pGbDc1disxOEQ1Nm5kc3Urb2lySWNnTHIxZW11?=
 =?utf-8?B?WVRzZFczQU9XalhRT3phbG0vaWU2VXIyYTlHeHdLUEJReEZpNXc0M0M1eEI3?=
 =?utf-8?B?Y0huSU4yZS9BPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR21MB3098.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2643d493-ec1a-4875-a2d7-08d9fb07be90
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Feb 2022 22:14:52.8529
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wz53eH64cfB2do59mpoDh2FQsh5/eOOcl9pqVKKpBsMPfea4PwPIA4l35LsISo4T81VxPnsLoEzD+gKx/VOOazWsDHJZy9taBiMy+x0iepQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR21MB3227
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogSmFzb24gQS4gRG9uZW5mZWxkIDxKYXNvbkB6eDJjNC5jb20+IFNlbnQ6IE1vbmRheSwg
RmVicnVhcnkgMjgsIDIwMjIgMTo1NSBQTQ0KPiANCj4gSGkgQW5keSwNCj4gDQo+IE9uIE1vbiwg
RmViIDI4LCAyMDIyIGF0IDEwOjI4IFBNIEFuZHkgU2hldmNoZW5rbw0KPiA8YW5keS5zaGV2Y2hl
bmtvQGdtYWlsLmNvbT4gd3JvdGU6DQo+ID4gTXkgcG9pbnQgaXMgdGhhdCB0aGlzIGlzIGNsZWFy
IGFidXNlIG9mIHRoZSBzcGVjIGFuZDoNCj4gPiAxKSB3ZSBoYXZlIHRvIGVuYWJsZSB0aGUgYnJv
a2VuLCBiZWNhdXNlIGl0IGlzIGFscmVhZHkgaW4gdGhlIHdpbGQgd2l0aA0KPiA+ICAgIHRoZSBj
b21tZW50IHRoYXQgdGhpcyBpcyBhbiBpc3N1ZQ0KPiA+DQo+ID4gQU5EDQo+ID4NCj4gPiAyKSBp
c3N1ZSBhbiBFQ1IgLyB3b3JrIHdpdGggTVMgdG8gbWFrZSBzdXJlIHRoZXkgdW5kZXJzdGFuZCB0
aGUgcHJvYmxlbS4NCj4gPg0KPiA+IFRoaXMgY2FuIGJlIGRvbmUgaW4gcGFyYWxsZWwuIFdoYXQg
SSBtZWFudCBhcyBhIHByZXJlcXVpc2l0ZSBpcyB0byBzdGFydCBkb2luZw0KPiA+IDIpIHdoaWxl
IHdlIGhhdmUgMSkgb24gdGFibGUuDQo+IA0KPiBPaCwgb2theSwgdGhhdCBtYWtlcyBzZW5zZS4g
SWYgeW91IHdhbnQgdG8gZ2V0ICgyKSBnb2luZywgYnkgYWxsIG1lYW5zDQo+IGdvIGZvciBpdC4g
SSBoYXZlIG5vIGlkZWEgaG93IHRvIGRvIHRoaXMgbXlzZWxmOyBBcmQgc2FpZCBzb21ldGhpbmcN
Cj4gYWJvdXQgam9pbmluZyB0aGUgVUVGSSBmb3J1bSBhcyBhbiBpbmRpdmlkdWFsIHNvbWV0aGlu
ZyBvciBhbm90aGVyIGJ1dA0KPiBJIGRvbid0IHRoaW5rIEknbSB0aGUgbWFuIGZvciB0aGUgam9i
IHRoZXJlLiBJcyB0aGlzIHNvbWV0aGluZyB0aGF0DQo+IEludGVsIGNhbiBkbyB3aXRoIHRoZWly
IGV4aXN0aW5nIG1lbWJlcnNoaXAgKGlzIHRoYXQgdGhlIHJpZ2h0IHRlcm0/KQ0KPiBhdCB0aGUg
VUVGSSBmb3J1bT8gT3IgbWF5YmUgYSBNaWNyb3NvZnQgZW5naW5lZXIgb24gdGhlIGxpc3Q/DQoN
Ck15IHRlYW0gYXQgTWljcm9zb2Z0LCB3aGljaCB3b3JrcyBvbiBMaW51eCwgZmlsZWQgYSBidWcg
b24gdGhpcw0KaXNzdWUgYWdhaW5zdCB0aGUgSHlwZXItViB0ZWFtIGFib3V0IGEgeWVhciBhZ28s
IHByb2JhYmx5IHdoZW4gdGhlIGlzc3VlDQp3YXMgcmFpc2VkIGR1cmluZyB0aGUgcHJldmlvdXMg
YXR0ZW1wdCB0byBpbXBsZW1lbnQgdGhlIGZ1bmN0aW9uYWxpdHkNCmluIExpbnV4LiAgSSd2ZSB0
YWxrZWQgd2l0aCB0aGUgSHlwZXItViBkZXYgbWFuYWdlciwgYW5kIHRoZXkgYWNrbm93bGVkZ2UN
CnRoYXQgdGhlIEFDUEkgZW50cnkgSHlwZXItViBwcm92aWRlcyB0byBndWVzdCBWTXMgdmlvbGF0
ZXMgdGhlIHNwZWMuICBCdXQNCmNoYW5naW5nIHRvIGFuIGlkZW50aWZpZXIgdGhhdCBtZWV0cyB0
aGUgc3BlYyBpcyBwcm9ibGVtYXRpYyBiZWNhdXNlDQpvZiBiYWNrd2FyZHMgY29tcGF0aWJpbGl0
eSB3aXRoIFdpbmRvd3MgZ3Vlc3RzIG9uIEh5cGVyLVYgdGhhdA0KY29uc3VtZSB0aGUgY3VycmVu
dCBpZGVudGlmaWVyLiAgVGhlcmUncyBubyBwcmFjdGljYWwgd2F5IHRvIGhhdmUgSHlwZXItVg0K
cHJvdmlkZSBhIGNvbmZvcm1hbnQgaWRlbnRpZmllciBBTkQgZml4IGFsbCB0aGUgV2luZG93cyBn
dWVzdHMgb3V0IGluDQp0aGUgd2lsZCB0byBjb25zdW1lIHRoZSBuZXcgaWRlbnRpZmllci4gICBB
cyBhIHJlc3VsdCwgYXQgdGhpcyBwb2ludCBIeXBlci1WDQppcyBub3QgcGxhbm5pbmcgdG8gY2hh
bmdlIGFueXRoaW5nLg0KDQpJdCdzIGEgbG91c3kgc3RhdGUtb2YtYWZmYWlycywgYnV0IGFzIG1l
bnRpb25lZCBwcmV2aW91c2x5IGluIHRoaXMgdGhyZWFkLA0KaXQgc2VlbXMgdG8gYmUgb25lIHRo
YXQgd2Ugd2lsbCBoYXZlIHRvIGxpdmUgd2l0aC4NCg0KTWljaGFlbA0KDQo+IA0KPiBGcm9tIG15
IHNpZGUsIHJlZ2FyZGluZyAoMSksIEknbSBiYXNpY2FsbHkganVzdCB3YWl0aW5nIGZvciBSYWZh
ZWwncw0KPiAiQWNrZWQtYnkiIChvciBhbiBleHBsaWNpdCBuYWNrKSBzbyBJIGNhbiBwdXQgdGhp
cyBpbiBteSB0cmVlIGFuZCBtb3ZlDQo+IG9uLg0KPiANCj4gSmFzb24NCg==
