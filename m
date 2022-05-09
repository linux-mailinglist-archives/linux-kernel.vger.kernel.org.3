Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 354AD51FA9A
	for <lists+linux-kernel@lfdr.de>; Mon,  9 May 2022 12:56:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230095AbiEIK7b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 06:59:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229833AbiEIK7X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 06:59:23 -0400
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-eopbgr140080.outbound.protection.outlook.com [40.107.14.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 630AB197F7F;
        Mon,  9 May 2022 03:55:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ciPaIgcRtrIJo7S8C2/l/xtf94beVGfxt05yGtqX+G2WdGZ2JaI4KYF6FyTVifrost8avA8JLOkW4G+1r3M4UI1jEK7rZShxOIxpUtUXgDcL22tcTFMmDzn7DjLBeUNrxq5L6gGhPUk7Gqnkl9u4SUzu2uHPJ7jkxh8ox9piibQLxCTsjMeof/BJp6ca/HCw559hzYmRjNYOFKLThFJEU5PtzapdhXb/ydsA50fdjYlRh8aAeTGhMrhtY4dDXwacxPFRscuWMeXnCadV8VrJoJpVDYN9F8XaRbJ8tug2UG593a/wZ4Y/hygGYppR5VcQ+FLM1YmWJR8uVsf/0DrbKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AjMpURF4hbOmIZmfEGvYSt5p7SYCrwRFMkeahY8GxwY=;
 b=NB/wdCHaQ0qlwP+kxjWGwynJFeYgnFkrGCs9xweg/66954u3vmNR53bC8afnEgmPCcl9DRXGH/6JNNJGbD7tXkKW2iqpuqcu5ejtX4NdXtMiBpQRKSYTt5Ozdu8sz0fe+yam27z1PJY5D2z4R8piURO+lXfqWA6wdaWniuI8VnZ3NBhFHybCvt/JKyWFGnyacFF1128MsPjnPlr4X+/c5U+zsiINNUeu/KNwCYCekCUkmzGouNrr4tl0RQIF57BwpP5nV6JJy8mmdV0oEHwfkYv58u8fU93jYQAuAWuoQaRhtxJ83ej23Je0P41m4iOIJOmodqP835xb4ZN69jZ4Ng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AjMpURF4hbOmIZmfEGvYSt5p7SYCrwRFMkeahY8GxwY=;
 b=tOQp/Qa9c38VY1ad0ion5h4Cp8+hwB17lEN6ccP0inXaq/Z6DtPpfYzSIvOSnhdwWOQo9fpaj29Io1tIzOX0XWFBIHU8aH2a2TjzCtFzEbJJ2MFKzOBtqjQtRieT3h7t/SmURStCLSLmsmDj5BZWvlHayuoK4CD82ZCKPOOwB8vU8uUr6nF5iqoskbSqfSAYMIZ3eDhK6wa7GfyHz+ehRzDhmsRxZrN4RCsiqF0Me24TJ0BffzMzWfX5z4E6lB071AJ19Y0Zk9vMyOnE3Zi98195C5paO52LgFbs4FTiEl0bBAA/97D8i3bcobHAAXJDuWefyFbn5EneH8gqsPBX5w==
Received: from DB9PR10MB5881.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:395::21)
 by VI1PR10MB2622.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:803:e6::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.18; Mon, 9 May
 2022 10:55:27 +0000
Received: from DB9PR10MB5881.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::99a1:b485:c2b1:7ee0]) by DB9PR10MB5881.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::99a1:b485:c2b1:7ee0%3]) with mapi id 15.20.5227.023; Mon, 9 May 2022
 10:55:26 +0000
From:   "Starke, Daniel" <daniel.starke@siemens.com>
To:     Jiri Slaby <jirislaby@kernel.org>,
        "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 1/3] tty: n_gsm: fix buffer over-read in gsm_dlci_data()
Thread-Topic: [PATCH 1/3] tty: n_gsm: fix buffer over-read in gsm_dlci_data()
Thread-Index: Adhjkzv52f69hDsVRdyr3WU2S61DFA==
Date:   Mon, 9 May 2022 10:55:26 +0000
Message-ID: <DB9PR10MB58811C7FBE7EB0600151A6D8E0C69@DB9PR10MB5881.EURPRD10.PROD.OUTLOOK.COM>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_a59b6cd5-d141-4a33-8bf1-0ca04484304f_Enabled=true;
 MSIP_Label_a59b6cd5-d141-4a33-8bf1-0ca04484304f_SetDate=2022-05-09T10:55:24Z;
 MSIP_Label_a59b6cd5-d141-4a33-8bf1-0ca04484304f_Method=Privileged;
 MSIP_Label_a59b6cd5-d141-4a33-8bf1-0ca04484304f_Name=restricted-default;
 MSIP_Label_a59b6cd5-d141-4a33-8bf1-0ca04484304f_SiteId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;
 MSIP_Label_a59b6cd5-d141-4a33-8bf1-0ca04484304f_ActionId=7c1e7dfa-a841-44ee-9b9c-7d7c36eb76e7;
 MSIP_Label_a59b6cd5-d141-4a33-8bf1-0ca04484304f_ContentBits=0
document_confidentiality: Restricted
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 686c5ed0-512e-4ece-c89c-08da31aa6ce8
x-ms-traffictypediagnostic: VI1PR10MB2622:EE_
x-microsoft-antispam-prvs: <VI1PR10MB26227342C88ED27EAEF62189E0C69@VI1PR10MB2622.EURPRD10.PROD.OUTLOOK.COM>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 1mm0MFRvrrepuxTX3m40Q3QMsWP8zBaCbdPf2thnwzjcmFkswQGGx+JvlS6ToRA0L8fDWoj0KJCmNf2ZvrwpQk7lD/kdh8G0oCLOkpswX49Kboriw8wGzMRr8PI7e4DyV2lfZLeiCJDuQTIgy7fO96SWKNYPxE5+TYCyIWQ1qic52yXgIemJ62GzH/7Y7JqkU0BKzWBdAR0Ge4tQsMhrzEEyLTWyPGKwHlz6r86hucIDFiyfgpxW/mLpK2IVIDTQNVw3Z3Na4uyoqRVw9we/E+zjasBMYLKMSV9shpmF3Kaflpr4FMOMo+BwVI3tytUVpg8fI0M3pihiaAZ263vVxCnpbNH7GgQ8aO659fbZqpAamQrWjbokK+OEjW+9p3MoUR6V9Ud/cyidPyhBYjUREV/SrjhbO+zRYxjMh+2KTLR/HsHCNxy88VdbwGAZlpAk/sxWORcORDKdzw84r9aLD51sVT2p/N7K8Uc65P9PehGH5gHfNR2ax6cRMPF6yzSSISXhQZRfkF0eyLnlH9hnwLM5iK3lq8x538eIW5RUOaaZH02bG6zIiTz2xe6GB5TOvORoNZERQDd2+Wu4eIIQMlY0G6sUxCinqgzYb2LfMCCm1JqAWbv+H7WDVIHHM99a7oX25a44F48EFJxFa2NOkIbgdpn2Et67BTB/s6qNs3iJ06RNUXLOkV87FT/JuUs6irq2r+UT0xnFAJiIlQP2MQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR10MB5881.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(316002)(8936002)(66556008)(64756008)(66446008)(8676002)(4326008)(55016003)(110136005)(4744005)(2906002)(66476007)(6506007)(5660300002)(52536014)(76116006)(66946007)(55236004)(7696005)(71200400001)(26005)(33656002)(9686003)(186003)(508600001)(86362001)(82960400001)(38100700002)(38070700005)(122000001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WWlGcFJGSzNwUDFtek4zNEFPVkdsZHlrZUM4M0NwSGx1TjBuVGl4WGx4VDRy?=
 =?utf-8?B?TjY0R2k3RlA5RDlrR1N6OFlSYlhjMWFSZjdwVDlCeisyeHZCckxaT1pmVjc3?=
 =?utf-8?B?WkNJSDNDd0ZzSkpBZGFaVFVvdGxpUm1DRC92RlA4N2dNTlZyNFdGa0FCYTQw?=
 =?utf-8?B?OXBiUDRLY3Z0NnVlNkpQMWFSWkRieWlzQ3JnUVFYaXBRWmdVM2FFSVdUUjBs?=
 =?utf-8?B?SU1UVVBCRWJId0cwNmthc2Jmc0l3ZXdWQ00xc29iTGMvNEdDNWczT213TUFu?=
 =?utf-8?B?aHNqWkNFY0pJVEdLRUZXaENReFo4WXVUU0d0TG52dTlCaU90MjRhTnl4L3Mv?=
 =?utf-8?B?Mmp5dWUyRmd2MHp0YnFabEdPUlBheFprNEJIdVE0S0NkSVhQR0NLTHJkb29X?=
 =?utf-8?B?QjM0SUhIVEt3cXJFZGppMGc2T0s1bmtHcWpaVnZpeml5U2xFSks4N0IyaVhO?=
 =?utf-8?B?L3Y0SjArZ25IdmpwS1RGTDZLTnVNRDhGUitiUm5EVVJYa2k0b1NqZVgwZmZr?=
 =?utf-8?B?R0lJN1pQd0dWWFFyUFlQQ3V6TVZZK010QVpHYVYzOTRRcEh5MnV3RmQzT2dl?=
 =?utf-8?B?Mk5NOEZ5YTcyREovQmhSMGQwZ3NLVUdWVDZCMnJRT3RVWXBzOTVqTWtTZncw?=
 =?utf-8?B?ZG9OZjVqYzVud25scWo5Njdnd0tvS2E4b2pDd2NaWFJkWTlLL0JBVHBxVUJ5?=
 =?utf-8?B?UngvNjNRS2JzQzYrblNnenlTUldmVzI4SW5lc3IyNWZ4VCtaM2F1TkhabmpM?=
 =?utf-8?B?ZjBwZVU1K2Vta1JMdTB3eXVKU2JQdGtWcTRDeEVJeFN4eEFQMiszVkYyL2hq?=
 =?utf-8?B?TUVQb05sRFF0cGFTTTJ2RjZILzNaSTB4NUhXRjNZbGVBazhjcDAxc283T3dj?=
 =?utf-8?B?dEhRUXhCbzhIeWtlZ0ZwZVRQNERHQnBkRTZENDV1NTMrRkFmaE5sRmRldnhq?=
 =?utf-8?B?a2x0bGNYUjlEQXE2anJEK2NJMmMyTmhnNzh3R2xoNWxjWEx1R0pBd1Z2bjls?=
 =?utf-8?B?djRCZHo2U3IyUFA0UTRTY01KanhPdU82UFNLc3V5UlVoeHhtbDF2Q2NhNW4y?=
 =?utf-8?B?dkV4Z3F4SThack8xSFo0bTdrcWhkNTdiM0M3OXlmenVoWjA5Q3VjMllZTVJa?=
 =?utf-8?B?VCtmbDQxQnlxRHliaFgyL2pjWEJOQWwyNzkrSGZNU0phbTd6aytaWFFQRzNZ?=
 =?utf-8?B?cWpYUmR2aU10ZlpzdW5oOHZTRldNODhnTnRmdTJVTzZjNFpIdDhnbHB5cGJX?=
 =?utf-8?B?T3VoM055ei9LYUd2d1NyT05EVjZjVDc3QzBibHAvNGY0SnhhUmNsOHVmTkFQ?=
 =?utf-8?B?eEJSbDhHVkpveGJZY1pSYUo2T3VxdWlHcWRiOHpiL1NxM3IxZmh0Y3dtb1po?=
 =?utf-8?B?ZHVTT0ZqcTNMUXZmbzdFVXVDRGNJVTlQTG9XOXpiN2lsaDFPNk9mNnQvaStU?=
 =?utf-8?B?czFVM3RIT3B0b3J2Tk1RVkxVaDhZRGFiT2sxTU54OUY0bUlzY1hOY3hOMU9h?=
 =?utf-8?B?K2hGcWVtOVJJSmtPemIya2svdlVYVDFkM1hvT1drVkkyOURIMDM3M0pQV1Vj?=
 =?utf-8?B?NEt5TUoxb0Q4UTkrYTFSdkEvUVVEZE9RZ21LSnRZcE1oSkxyYmE1ZCtMTTJm?=
 =?utf-8?B?Y1dYVGFVam5ybmk0Q0ZBT3NUUzlidEdvd1FSTzVscENnWjVqZzBickhZaWxq?=
 =?utf-8?B?MEdJdjJuWVVDK2JIVFZXMEk4RGpkUWpqV3pDa216aWpuOUl3a2tGSEtPeDZO?=
 =?utf-8?B?czBUQy9RbGh6eElvbzhLUjJheExqUlE2em11Qk9YRlF1RWZlRlV3YlYyV1Fa?=
 =?utf-8?B?YWp6b1djNnA2NUVSUy94bnc0amRneU40STNoaDMxMG96THBPdGRIaUM0UDdE?=
 =?utf-8?B?UzRBYWFBUGNZWFVQNmJad3ByM09GWDVmT2drU3FXVERneWNZbzhlODJSSE8x?=
 =?utf-8?B?VTBvbGpLTVBxMGcwK0xhcDRxVlZEOVhrTEtaMm5GUVhPY0g1cDBIRG0yQmk0?=
 =?utf-8?B?ckhrcTNNOU92eWZEKzF1OW9ubld4amJ2RnB4R3MwT1dUSmRLbDVlU0RlbHRE?=
 =?utf-8?B?cTRYVUFsdlRkTDRkeUhDU3lCQUc0UFJ6ekw3NGVrVHUyRDdhMWR5NkZJU1l4?=
 =?utf-8?B?MzVZS1NpeEJLOFZvTXVKYmsvWDNhN1hiTmVYMlBEWFd1TUg0MzBUd2tCQmE3?=
 =?utf-8?B?Ujh5Y0pEVE5pT3hxeURZSE9ockZrbk9RS1liZUhBTmlQa3RzMjdyUG9rR2JZ?=
 =?utf-8?B?bXlpcWpzNnJ3dk1CczYrYmpDcURaT2NNaE5HNFk3elBNTnppdCtidDBFOS8v?=
 =?utf-8?B?V3VEN1Z2cVpyRHpncmIycWozVW51a1pUWC9MUXgva29obVFYa05DTTRDc3dU?=
 =?utf-8?Q?8AkimlrIa7phazv8=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB9PR10MB5881.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 686c5ed0-512e-4ece-c89c-08da31aa6ce8
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 May 2022 10:55:26.7274
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: J4UPR6gja/5IYQbUDcjcPsge/kiofVM73UesmMeMGo2BDnCPKCUbCQMx1GPFHxoKk+xWoaU6lZXktbn/ZjnP/f3mMnZ1W6Xc+OFvKzHyCTc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR10MB2622
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBPbiAwNC4gMDUuIDIyLCAxMDoxNywgRC4gU3RhcmtlIHdyb3RlOg0KPiA+IEZyb206IERhbmll
bCBTdGFya2UgPGRhbmllbC5zdGFya2VAc2llbWVucy5jb20+DQo+ID4gDQo+ID4gJ2xlbicgaXMg
ZGVjcmVhc2VkIGFmdGVyIGVhY2ggb2N0ZXQgdGhhdCBoYXMgaXRzIEVBIGJpdCBzZXQgdG8gMCwg
DQo+ID4gd2hpY2ggbWVhbnMgdGhhdCB0aGUgdmFsdWUgaXMgZW5jb2RlZCB3aXRoIGFkZGl0aW9u
YWwgb2N0ZXRzLiBIb3dldmVyLCANCj4gPiB0aGUgZmluYWwgb2N0ZXQgZG9lcyBub3QgZGVjcmVh
c2VzICdsZW4nIHdoaWNoIHJlc3VsdHMgaW4gJ2xlbicgYmVpbmcgDQo+ID4gb25lIGJ5dGUgdG9v
IGxvbmcuIEEgYnVmZmVyIG92ZXItcmVhZCBtYXkgb2NjdXIgaW4gDQo+ID4gdHR5X2luc2VydF9m
bGlwX3N0cmluZygpIGFzIGl0IHRyaWVzIHRvIHJlYWQgb25lIGJ5dGUgbW9yZSB0aGFuIHRoZSBw
YXNzZWQgY29udGVudCBzaXplIG9mICdkYXRhJy4NCj4gPiBEZWNyZWFzZSAnbGVuJyBhbHNvIGZv
ciB0aGUgZmluYWwgb2N0ZXQgd2hpY2ggaGFzIHRoZSBFQSBiaXQgc2V0IHRvIDEgDQo+ID4gdG8g
d3JpdGUgdGhlIGNvcnJlY3QgbnVtYmVyIG9mIGJ5dGVzIGZyb20gdGhlIGludGVybmFsIHJlY2Vp
dmUgYnVmZmVyIA0KPiA+IHRvIHRoZSB2aXJ0dWFsIHR0eS4NCj4gPiANCj4gPiBGaXhlczogMmUx
MjRiNGEzOTBjICgiVFRZOiBzd2l0Y2ggdHR5X2ZsaXBfYnVmZmVyX3B1c2giKQ0KPg0KPiBUaGF0
IGNvbW1pdCBiYXJlbHkgaW50cm9kdWNlZCB0aGUgcHJvYmxlbS4NCg0KWW91IGFyZSByaWdodC4g
SXQgd2FzIGludHJvZHVjZWQgaW4NCmNvbW1pdCBlMWVhZWE0NmJiNDAgKCJ0dHk6IG5fZ3NtIGxp
bmUgZGlzY2lwbGluZSIpDQoNClRoaXMgcGF0Y2ggd2FzIGFscmVhZHkgaW5jbHVkZWQgaW4gdGhl
IHR0eS1saW51cyBicmFuY2guIFNoYWxsIEkgcmVzdWJtaXQgaXQgbmV2ZXJ0aGVsZXNzPw0KDQpC
ZXN0IHJlZ2FyZHMsDQpEYW5pZWwgU3RhcmtlDQo=
