Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07D674D42B7
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Mar 2022 09:37:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240478AbiCJIiW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Mar 2022 03:38:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240454AbiCJIhz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 03:37:55 -0500
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2058.outbound.protection.outlook.com [40.107.21.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CB00136ECC;
        Thu, 10 Mar 2022 00:36:54 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=coWLcReerGr2N2+gLZMSoYrqa6GkVA1oPexybWQv7VvNsDvyprjXn+9ARKmk8NoPzTUh+zziGXrIiZsYCDzThRqnUFE0xppo4J4YpV26tGfWVqiUKww8EGKlEmP/otSK37k0GWKmJdFiAYFVUZq3chiApYeDTpmupO8KZXgwcJLglGnWXzWq097Cq4xNjx5XsA0SKyg9NwOdfNHjvL5xR3rTAUV5aDNVIRyTUvrE+jiNfwBdn60CmWr169m6Xhc5cRaGaYjrYZ+jwYKEU3wU47QKzQUSKdrOYEDRroFqXh+i68TsmezYtnTee0d8W1gYPGC0vwzY8VulbAgUp/pHjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UdmRXDIOsO4owTJrZ5oModdGFSdfmdq5Vm5XHfe7Avc=;
 b=CvE3Q8P2oXxFyMNnDLCMmM8qUjSS8VV3DhjIsQIvYJnFM/JvJZkeoNqURi9BjK4By/NtmTorRF1xzPck9u7qCmRHi4T2w58m9LHYBRkNIeCCHoUxbS43WSrF+5qpbHSERO2eiwSuCgJusMfuN86EhWyLdCPR4Kwev93tAnrt2nG5sWA6SuQjtOed7KlRJy4UReI829278jk71/PF6lx6mD7GsTjMIe0nShUEBPDm6CQdUCbVp3/t/OQwmxI8nYIk0OyqknKVl9YnSY3BdHOyKGqk6Z1WAwI0Vm2L+xyUc7Tosm6Rv9yUI2kEnBMaw5uiujdxRcad9600IB0qy2UWhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UdmRXDIOsO4owTJrZ5oModdGFSdfmdq5Vm5XHfe7Avc=;
 b=mr67bkyxBq7bnj4/smR51vYiI/EQpFqc980fWFhmA42F4Fv3M4zZp3l5d9J1YR8GdevDEp/8WbIXxwxSX6mHIwa0NDCJLeNjwuCCkCgeHKzt7fYo3d6OD3ekAkYBo/lWDsJDX25scIyZ4o3rcREQ/N6JllbLYGymIdqMY+xOCm8=
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com (2603:10a6:20b:d8::14)
 by AS8PR04MB8008.eurprd04.prod.outlook.com (2603:10a6:20b:2a7::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.29; Thu, 10 Mar
 2022 08:36:52 +0000
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::c39:69cf:c4ea:967]) by AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::c39:69cf:c4ea:967%5]) with mapi id 15.20.5038.027; Thu, 10 Mar 2022
 08:36:52 +0000
From:   Ming Qian <ming.qian@nxp.com>
To:     David Laight <David.Laight@ACULAB.COM>,
        "mchehab@kernel.org" <mchehab@kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>
CC:     "hverkuil-cisco@xs4all.nl" <hverkuil-cisco@xs4all.nl>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: RE: [EXT] RE: [PATCH] media: amphion: fix some error related with
 undefined reference to __divdi3
Thread-Topic: [EXT] RE: [PATCH] media: amphion: fix some error related with
 undefined reference to __divdi3
Thread-Index: AQHYM3L1b6GUtwI3e0GOXsa95t9Coay3C94AgAFAbMA=
Date:   Thu, 10 Mar 2022 08:36:51 +0000
Message-ID: <AM6PR04MB63417FD1C3EE77BBE1649B47E70B9@AM6PR04MB6341.eurprd04.prod.outlook.com>
References: <20220309050221.971-1-ming.qian@nxp.com>
 <ab877a4470324d20b558538b52f69391@AcuMS.aculab.com>
In-Reply-To: <ab877a4470324d20b558538b52f69391@AcuMS.aculab.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: af8f848f-7957-445c-05a9-08da0271202e
x-ms-traffictypediagnostic: AS8PR04MB8008:EE_
x-microsoft-antispam-prvs: <AS8PR04MB800850D84BF51F6D7A5D376BE70B9@AS8PR04MB8008.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Sx7h9moU7lkTXVtKcnYI8+DcXtaF6Vy0VSgDR4x8m/DGT9qQ1WvL4QMpRBsVEq6lU24qivEiW14+NVOagTZVeYRDPXX/mKCs7n2cRhZBpjDFO0orUlbdvatXktZK0l2eYPU6GDUAknAZ3D/n3r/5uHLS3vj9lZ3RT+AT58GyCiB9G3S3XgB5uw08TqG4qX8Opyaw7vJsgc6x4S0NfqrSSC07Yn6BGaMCpM1yoqGEwczDBcMFIsZvFLoCt4Ny9VeFJBkMXRiw18UVrtOEwSGnxtDCizX8b9zFhk4g7UzAy+Dn5fVzsBfcIzN8Ty0mIJp01xZ533JUQKimAxDrFD6UpsMBOVG+vCXFKySX2yFzAUkzmFPFUWzVEcv9lVbn3xrguu6q25olgXiI+64Txdl6cq05tcXEWlToy/doVsTPr1Ld+tw54XXo6MGXcuPkTDafOdEI0aI4hrJ8yvTS0kXBdG4faerRKqfqQ9sSpf8RWqCMmnr+GiNedmticS1OmlwAzM2sEsUgOYJR4ArvYmEcFRR2EVNbxxh36PbAWbOVdSyNNR1ZW+faE/iyk6C8lseD4h0DIq0qLmyjsvRSB8VvDx8XYiL58rSsUr+rS8n+p8Zwt0p+C2tZZn9oWcrwHGbyrG11FyD8KqDgHPM4f31KnHRdtjjrVbiRveu1wkPlMHqvbEceF6cfa0PDLqrS2HzqATV8ILj0aESUW3kGUrlNNw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB6341.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(508600001)(9686003)(186003)(44832011)(52536014)(7416002)(26005)(5660300002)(8936002)(122000001)(55016003)(33656002)(83380400001)(2906002)(38070700005)(38100700002)(110136005)(8676002)(4326008)(86362001)(54906003)(71200400001)(316002)(64756008)(66946007)(53546011)(66446008)(66556008)(76116006)(66476007)(7696005)(6506007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TFFPS1dKK0tyNmZrdFp2Mk5zWUpkQzZvMXBWZjBHYmxoaTFuelRXTkM3NGlZ?=
 =?utf-8?B?S1hoekhUQ1hlSGI5NGpEa25ndkhRWU5aTnVESXp4Tk9CN2xFNW1ua2JvMTE1?=
 =?utf-8?B?ZjF5cEh3RXZ2Yi9tNzV4aDBkUkR2WU11Z1J5QnovazJEZlE5b3VZK0t2d2t6?=
 =?utf-8?B?V0Y4MmlOTjBtN3RUanMzUzlCdXNDRXNON2pIbFdhN3hVQ0owYjErZW9Xa3Fs?=
 =?utf-8?B?KzQ1ZE91TnhYN2k4QndwWGVrVHBpOEdLcWNFcnphVEFRamVhenpXK3JJL1Jy?=
 =?utf-8?B?bitid0srQlZ2WkxCMnFhQ3JHUjloR3hRQkhQUVpDTDIyM2xFL1pDVGY1TGgv?=
 =?utf-8?B?OGRQZmdwWklhenhyeTRrZmpjbjBhUllXaWMweVpTNGV3cmxwVWU5TzFvdktI?=
 =?utf-8?B?cExvMW0zWU0yVzdMdFlzS1ZYZDhxM2FhV2U4azlDQlhzV2htVy9RY2pCeFZM?=
 =?utf-8?B?QWdDMGU5UExTVnRLbWhEbDJVWUY2bnhzcnNtOS9jWlp5dFFkcXdWRmZOYTFt?=
 =?utf-8?B?Zy9EUGRGSExFVW9yZGxueGNzdWhzd2I3NHZJNDRhdVhTVnhVVDZwMTB6cFlh?=
 =?utf-8?B?VmhNVjc5ZzhSQ3hyMkFDNXBHZWNrMFVmcXlHV292bk1DZW9uWHBZTjdJUkZq?=
 =?utf-8?B?TUNUaUh2dDByTk53M0U4WE9nKzZmN0FibHBnZ2ZPMm9LUmZGeWdiUG5QcHJz?=
 =?utf-8?B?WXhhSVZ1a1BycnBKUkl4VTluZExwOHdYbG43Rlh0eHc4endFVmpaZ0FGQnNS?=
 =?utf-8?B?WDE1bElUWk4wMk5TamVocks0OUcyY3BnbDdVUGRESFdrdUI5Z2EyQjF3SlBm?=
 =?utf-8?B?RGF4eVNadHNkWERmbDczTG5vZXBacTdUWmpFcUF2bHB2MlpCSitaZ2l0emJJ?=
 =?utf-8?B?QmpBYXh6dVpXM2I0b0RHN3F1OGlnVTNDMHQxcFdSMktLdGJUdU5nYThJV1l3?=
 =?utf-8?B?ZjhxWG5oL1dvTTFZSlJTeVZGamJWV2JoVkQ3c0hnaGMxWE1CT3JvRm03WWJt?=
 =?utf-8?B?R1ltczBLaXp2elJocVk4WWhkVXVHKzdkczJEb0RwSVhtT3I5eFBBZG0wbmtr?=
 =?utf-8?B?bFhMOUtDUTZjTHd3aHFES0Y1VWJvU25WeWYyNGU3Rkl1UVNFMm84WHMrdnRV?=
 =?utf-8?B?SlY3K3FQNVNSYm93bithVmpwL0Q3bStYZ0ZyZC91ZVlIVG8raGpnRlJiQ0lL?=
 =?utf-8?B?dmZKdHlMZjZDbC9NQ1Q3akVKVGR1bGxpaDlhYVRXb1V5US9hLzB6NVk0cjI3?=
 =?utf-8?B?djhPVlIwcXhUVStMOC9qVG5MYy9ibXlyT1Q4UmZhanZCTDNFbkFGNjc1NHJO?=
 =?utf-8?B?L1Z3Tno3VkNQT2pxbHpBRTN4VWhFZVBhYVFKL0lFUHhiSEhkQjF0djFHait2?=
 =?utf-8?B?V0RvaXNqZ2JLaEQ4MlhwZmZuYUhQNVVSeFpsTkZZOC8zRTJWTmk5b29DUlZm?=
 =?utf-8?B?V1d2V2tubEtRWjQxZ0xqT3hkU0NFZnkxMmJmT2RueUVKc1A2U3NZdGFtOEI1?=
 =?utf-8?B?ZHRLNzhhb051MVZlMHFUZFNpYkpvZUxpUTNET2I5QWhIYTljM3c5UGF4cUJE?=
 =?utf-8?B?TnM5NmQyYkdIU3ZmRElPUi8ySW5KQkhtOWNRZXdpUzZUYW5Sa2VvaWdMQW9W?=
 =?utf-8?B?SHhucnF4cVVDa1hJOEtGNThwYTZGSGo4aHJoeFowbmlia1p3ZDdCT2NKZG1P?=
 =?utf-8?B?OGdRK1JrbjF4MEZHVkZWcW5PK09EazlQZ0hrcGVzV1dtbEd5NXFtRGdTN0h6?=
 =?utf-8?B?cjVmOUtCSm0zb1o3VERmdWcxK040eHZzeXY3cW4wV0NMenNzY1lUenRPcmVV?=
 =?utf-8?B?ai9PejJvV3VPTWlJTDFmSzdIdVpMYzNLTERIcXlrV1NJSW5KYWpEMmtTeEox?=
 =?utf-8?B?SHR3aS8wNHVVazRtenhXR1ZvOWc2NkpySVFOWDhtdmVDNHJMZjJ6c1JxTGhB?=
 =?utf-8?B?VjBuRUhOTVVJRnZWNlF6VHVycUx1UGpDdWNSUm1VbVVva0Rqa3FwNUQ4Uzkv?=
 =?utf-8?B?bjVQNHdSZmRrZ3FvQ0MzM2h0R2d2dDNpY3hZdkE5cXZoUTVyb1ZNSGdzK0FO?=
 =?utf-8?B?aW9pMGVkMTJ1aDQyNkJETlR1cHl3N2hTb1JIUXNCbDhTUjJCQTN5K3BJTmNl?=
 =?utf-8?B?bmtwQVI0bERYSEtQWDE2Q0tnODN2SStwdnowR1VaWWE3TGFpTkdvNXkzWmQ3?=
 =?utf-8?B?SlE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB6341.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: af8f848f-7957-445c-05a9-08da0271202e
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Mar 2022 08:36:51.9699
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1AUcivvUy8AtvXyvSJFRm4TovxyM7XHHJpasoXf+/G6zhX3/lzk3QxS4Wp4m0MOfvzRkjZvHgRL6vVZeABG9hg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8008
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBEYXZpZCBMYWlnaHQgW21haWx0
bzpEYXZpZC5MYWlnaHRAQUNVTEFCLkNPTV0NCj4gU2VudDogV2VkbmVzZGF5LCBNYXJjaCA5LCAy
MDIyIDk6MjcgUE0NCj4gVG86IE1pbmcgUWlhbiA8bWluZy5xaWFuQG54cC5jb20+OyBtY2hlaGFi
QGtlcm5lbC5vcmc7DQo+IHNoYXduZ3VvQGtlcm5lbC5vcmc7IHJvYmgrZHRAa2VybmVsLm9yZzsg
cy5oYXVlckBwZW5ndXRyb25peC5kZQ0KPiBDYzogaHZlcmt1aWwtY2lzY29AeHM0YWxsLm5sOyBr
ZXJuZWxAcGVuZ3V0cm9uaXguZGU7IGZlc3RldmFtQGdtYWlsLmNvbTsNCj4gZGwtbGludXgtaW14
IDxsaW51eC1pbXhAbnhwLmNvbT47IEFpc2hlbmcgRG9uZyA8YWlzaGVuZy5kb25nQG54cC5jb20+
Ow0KPiBsaW51eC1tZWRpYUB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5l
bC5vcmc7DQo+IGRldmljZXRyZWVAdmdlci5rZXJuZWwub3JnOyBsaW51eC1hcm0ta2VybmVsQGxp
c3RzLmluZnJhZGVhZC5vcmcNCj4gU3ViamVjdDogW0VYVF0gUkU6IFtQQVRDSF0gbWVkaWE6IGFt
cGhpb246IGZpeCBzb21lIGVycm9yIHJlbGF0ZWQgd2l0aA0KPiB1bmRlZmluZWQgcmVmZXJlbmNl
IHRvIF9fZGl2ZGkzDQo+IA0KPiBDYXV0aW9uOiBFWFQgRW1haWwNCj4gDQo+IEZyb206IE1pbmcg
UWlhbg0KPiA+IFNlbnQ6IDA5IE1hcmNoIDIwMjIgMDU6MDINCj4gLi4uDQo+ID4gMy4gdXNlICd2
YWwgPj4gMScgaW5zdGVhZCBvZiAnIHZhbCAvIDInDQo+IA0KPiBUaGUgY29tcGlsZXIgc2hvdWxk
IGRvIHRoYXQgYW55d2F5Lg0KPiANCj4gRXNwZWNpYWxseSBmb3IgdW5zaWduZWQgdmFsdWVzLg0K
PiBBbmQgaXQgaGFzIHRoZSB3cm9uZyAoZGlmZmVyZW50KSByb3VuZGluZyBmb3IgbmVnYXRpdmUg
dmFsdWVzLg0KPiANCj4gICAgICAgICBEYXZpZA0KPiANCg0KSGkgRGF2aWQsDQogICAgWWVzLCB5
b3UgYXJlIHJpZ2h0LCBpZiB0aGUgdmFsdWUgaXMgbmVnYXRpdmUsIHRoZSBiZWhhdmlvciBpcyB3
cm9uZy4NCiAgICBCdXQgaGVyZSwgdGhlIHZhbHVlIHR5cGUgaXMgdTMyLCBzbyBJIHRoaW5rIGl0
J3MgT0suDQoNCk1pbmcNCg0KPiAtDQo+IFJlZ2lzdGVyZWQgQWRkcmVzcyBMYWtlc2lkZSwgQnJh
bWxleSBSb2FkLCBNb3VudCBGYXJtLCBNaWx0b24gS2V5bmVzLCBNSzENCj4gMVBULCBVSyBSZWdp
c3RyYXRpb24gTm86IDEzOTczODYgKFdhbGVzKQ0KDQo=
