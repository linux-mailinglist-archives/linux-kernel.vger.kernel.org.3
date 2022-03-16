Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C9604DAACC
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Mar 2022 07:40:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351667AbiCPGlX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Mar 2022 02:41:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348607AbiCPGlU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Mar 2022 02:41:20 -0400
Received: from FRA01-MR2-obe.outbound.protection.outlook.com (mail-eopbgr90048.outbound.protection.outlook.com [40.107.9.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80DCC5AEC8;
        Tue, 15 Mar 2022 23:40:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RUExo2dtTMNJqzXIZYx+CiTNc9iGjkrk2xDOjlJi3JdfHip1x9YeaZOK6HDGh6WbJm6msuiMaWjbKFXBdTEYAhh3Iw97LcptwUMvqcB8EJKxhIOC9REEA4WebkInB3Nu+luuIG11h676UsAcloG+4+VeS5xmuYt9SabM4d0SeKinKtbwysabJaFwaoo1PSx9qHG4GhGg51vU3i/bQQwe1hgVOeI93O7i+E+Nf6wvzwuWfjewzkusUd9ZGjgOxs5Nu841kFZf1sSGJuQVbuQWOnI31+mINYg0MzrCZVs2NjX77VPeODUxiTkdVE5Iv+f4pDLyMlFLgOuhdy98JqgGRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7+wfMDWzev/652jrNREtKksVyn+0NHzoWSv5h03ddkE=;
 b=nXizahvaY2KwTYyP4KWsD2EZTiRvCXnX8vNI4hyKK/CnLK3ool95fgZT9fK+MQjTtuGFlXcCGTP3sM5HMJGvshUWZrwDjylDal4W0IGboZ7LNIDy60Ib9Xn1hC2eps/Ly+kEfUlQVmA75ytQ70qrjGoT05mZNYs3FtmPuw0cg84ntNQGVpFhKAD3OZ7fjM0o+RTwXQYARo7G+AYhtt3uA33GBWyBoUoWS49y2qzACI/CrS+NnELaZ7dheGwL8pmiwqJ5Rhd6qZKjmmqGPy102CkJHOs6IOauQV48FEeo9Fxy0chXAPg0KBP9YcwKIUrc3IZBh1mowTDLrBrm08O6KQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=csgroup.eu; dmarc=pass action=none header.from=csgroup.eu;
 dkim=pass header.d=csgroup.eu; arc=none
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:31::15)
 by PR1P264MB4343.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:256::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.24; Wed, 16 Mar
 2022 06:40:03 +0000
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::cd2f:d05d:9aa3:400d]) by MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::cd2f:d05d:9aa3:400d%6]) with mapi id 15.20.5081.014; Wed, 16 Mar 2022
 06:40:02 +0000
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     Luis Chamberlain <mcgrof@kernel.org>,
        Maninder Singh <maninder1.s@samsung.com>
CC:     "pmladek@suse.com" <pmladek@suse.com>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "senozhatsky@chromium.org" <senozhatsky@chromium.org>,
        "andriy.shevchenko@linux.intel.com" 
        <andriy.shevchenko@linux.intel.com>,
        "linux@rasmusvillemoes.dk" <linux@rasmusvillemoes.dk>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "wangkefeng.wang@huawei.com" <wangkefeng.wang@huawei.com>,
        "v.narang@samsung.com" <v.narang@samsung.com>,
        "swboyd@chromium.org" <swboyd@chromium.org>,
        "ojeda@kernel.org" <ojeda@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-modules@vger.kernel.org" <linux-modules@vger.kernel.org>,
        "avimalin@gmail.com" <avimalin@gmail.com>,
        "atomlin@redhat.com" <atomlin@redhat.com>
Subject: Re: [PATCH v3] kallsyms: enhance %pS/s/b printing when KALLSYSMS is
 disabled
Thread-Topic: [PATCH v3] kallsyms: enhance %pS/s/b printing when KALLSYSMS is
 disabled
Thread-Index: AQHYOIYIvWnstbkCdEiBL58y/A/yY6zAueoAgADWXQA=
Date:   Wed, 16 Mar 2022 06:40:02 +0000
Message-ID: <62c74547-deb0-539a-c1cc-64b2ac334c94@csgroup.eu>
References: <CGME20220315155109epcas5p249963f50d68ee368edb569b1a9e7d63c@epcas5p2.samsung.com>
 <20220315155100.516107-1-maninder1.s@samsung.com>
 <YjDScHjMUbqYV4s4@bombadil.infradead.org>
In-Reply-To: <YjDScHjMUbqYV4s4@bombadil.infradead.org>
Accept-Language: fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=csgroup.eu;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 708f8ebd-fdb2-4d7a-6568-08da0717cce4
x-ms-traffictypediagnostic: PR1P264MB4343:EE_
x-microsoft-antispam-prvs: <PR1P264MB4343C75935CB3B0E0CD47338ED119@PR1P264MB4343.FRAP264.PROD.OUTLOOK.COM>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: F1v9czoGxr4uINgZWWHxD+ebyPpJrWk1Purt1aXyMsZJgyVX8wZuERGIyALGatlvgY4Je9d216xNtcyGFE9hiUaAfasjJq76eHzvmcSOvB8+n9BVDs7iKlnHrvYqcWnvODc9KEc5kt98m5FoiuiExDXcTdtulAVrVrMr9w13YDUEKVUVl183U6emirNWtggEd6Wcwyp0fyRlxW6AJ++C8H/nt11djxyHlI0Zt0YiHcZlc93V87tLjmyHQK9wMcwLh67XfWCOLHJmA78ddVmFHetMjcUVirKJJdxWM5DVZVJrH4AauKz3Rnn3KwhwSmqTD7+DWS8ZUftNioufi2HcjaCC6yX1Bdk56oLJbgg6Tl9fRTMmZfAquse3J/nJj49AXHQaINQXHbgBS17iXvWQ/YwbEqLhgh66iZmyuD6/TKYsjpy6TC1xEVOgTP6a32xt7wW9lRFVTXrtQkAL3Mv6h/+uOKmy4em6PU8/u4qrsR51DlWIA5R86LODnmo3gqhLWwWsd4v8/258NP9ZjnAXmmIPtZ1uFfay9L5E/5EQEiGS+vyA/hj1LL1XDjAvo2xxTIfffs9dU/MiiO/C5pFCigJhxpy7MoTKlo8ybYVlGEPJATJ70CouiHsgxy6zMnC5E4OwEH5ZvD5Df/2tPVwie/nDvVc3Hsk7kWBm6vywwl87Dj//P/Ni2qoTgIgYkmdWfVNcOKO6qRrFwlw6vC12hF8fwPejuNRMONL7i+yXzobJpRffHbT/I7QgOe6SoGRr+i6E9lLCJCbQt57gJj55rWFhOtR5KwX0IkmvXoaX8El0Cmw/2Xd4M+kZYjA+hqCqNdI6w15J5hu/cwSTWRjUlz/AjFWC812PaNG45rMsU3A=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(26005)(186003)(2616005)(966005)(6486002)(508600001)(6512007)(6506007)(38070700005)(71200400001)(122000001)(38100700002)(86362001)(7416002)(316002)(31696002)(2906002)(5660300002)(36756003)(66476007)(64756008)(8936002)(4326008)(66446008)(66556008)(91956017)(31686004)(66946007)(76116006)(54906003)(8676002)(110136005)(44832011)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?S2R2NFB4eHY2VHhBWFZBZXFhV2IyWmJacktxcmFxMDVkV3BrZURqVFJQSjJS?=
 =?utf-8?B?U25IWmZGRWs4L0pTLzFIREdsbUxPOFIvcmVYUlBUYW1rSWZoMEJxaTR0SEJw?=
 =?utf-8?B?TWxqR3pGU0Z1NExlMU84N1NtMng4aUlBQmNsSnU5T2szaVFRd3NRS292bFhY?=
 =?utf-8?B?Z2haWlhIaVJDQnNOaElOU3hWTkJVTHFRV0lGZC8xc1FRU0hyaVpyK3ZSOEZ4?=
 =?utf-8?B?dVdxTk90TlVabEJCRkpjeGdzeVIxcStQYThLWGNtdkorTXcvdXExQ2FMdlhq?=
 =?utf-8?B?NDI2aEtLdWx5cFpKREZhL0xOUmIvMGhZRUtCQzlnS043aXlKdFlQNlB6Ni9I?=
 =?utf-8?B?L3F0Sjc3YmdLaWdiZEx3bndXOGNCNzJ3RDMxL0RMZkNNTmlXbm5WS2p4NHhG?=
 =?utf-8?B?MHU0c3pjNGd4Vms4cDZKWFpwNlVNMElLcXZEZkdMQTZqNlN2K2tCUllUdEla?=
 =?utf-8?B?V2tJVlhCZVBiYXRhUkwrL1ppSndnVmU5VGoydmZIY0w5eVBiZ09keU0yZEhz?=
 =?utf-8?B?N1h5cldFRTg5bUZpOFgveElEVUFINVFWeVRTN3lEV3ZUMVFkQXVMRUpEQVYz?=
 =?utf-8?B?T1R3QWFUYlErSGpTZSszWnpRdk1pRWIrOURwWWhtcXcvVEZwY0t2Q0IvU3M2?=
 =?utf-8?B?QmFlVStQa1h6VFNSdEFwTncvVXRjWXRrVFRUR3ltNHdOeEFDaGZXKzUySWJD?=
 =?utf-8?B?QThKWDF6UnJSUDNvT25wYVNMVHI5WmVIRnhJQ3diM2hqYkgrUU1IaUxDRU1S?=
 =?utf-8?B?MWZsVEtJYm0yc0ROaUlxZ2luSXgxTEtjMXo2QWNHa21vT1BhT1BySEQxWlJ1?=
 =?utf-8?B?ZkJETm9Gc0lKOUNHWUZaRlM3ajBJaW13UXIxR1J2dVJXSHB6a0RnVUxMVHYv?=
 =?utf-8?B?TGk0SmFqeGdQcjhlNXNWWXUrLy8yRkRIU3BzdnpMRUhPUmNNSElTWnlJZUd2?=
 =?utf-8?B?Z0ZSekc1UjBMR2xJWjBGVkQ5V0VkcllGVStNS25VeXNTTHdjeXdmVWc0V0tz?=
 =?utf-8?B?SXJrTC80SkNyT2FFVlFNREdGYjE4ZHViYnhFUXMvOUM4YmtpNDdyTS9yNTlz?=
 =?utf-8?B?N0w2K0VnMUw5Y3VPeUpBZjhvLy9YcWg0K3o1L3BWWnJVREJPQ3VKOXB1eWdZ?=
 =?utf-8?B?TVhiVFBLNXF1b2dZdUhhSlhvSDhDNVFOSnRiWmk3ZmNnZmpVb2hQMk5CamlU?=
 =?utf-8?B?aUtNV2VKNHV4RGJKNWgySVlTblNQVnd3clg0QnZxcmxyMGh5T05YTFhBUW1L?=
 =?utf-8?B?NDVoMFk2NllkYkdZa0liZWJJMlZXb3ZRM0tOeEVpSktxRjdDcWVVNTVnRzFI?=
 =?utf-8?B?WW5IZFp3ZnprQXYvUjdDYU9UaFoxSzEzSmVqWXY3eHRKT0ZWZmNmM09GcTFT?=
 =?utf-8?B?bjNqZWlxcjFYMVRESXlxTm9TOUdvcitzTTEvOU9SR2U1cGpIbnFpRHBCZHpF?=
 =?utf-8?B?TTVpWmY2MkExejV2OXkyYVk4VmMrMm04ZkFnWEpXZ21tbFRsZWlDYk5JVHBR?=
 =?utf-8?B?bWNQTDFNWE1BTjFWV053R0xVY3VZdGkvb2lFcFlDRjk1RDVUU2ExQ2FqZFdo?=
 =?utf-8?B?QTlMUUxVZUt3VTd0MTVnbGFpR1phMWNYdXo1NWlXR2laV3FwY0NONVNTVFZE?=
 =?utf-8?B?SitpUTl2ZUI1UmlaWmtYSitlREp1aktwK2d2RlZiUGVBY2xzdDZrTnVOeFQw?=
 =?utf-8?B?WGpiUFBjNCtISzFrbWRIYjNnS3o3RUVsYkZORjBRN2hhcTVhNVJrbE5OOWRT?=
 =?utf-8?B?UXRLV0U4YmJNNHVVL21WK2VrWW9PR1Zoc3NFaklCKzU4am5EM1I1cFhhcW5D?=
 =?utf-8?B?aUJjd2xSOFVQL29vUTQ2aVkweXpkekVhd0N4WFdVNk1aSlpVandBeTFRSE1z?=
 =?utf-8?B?U1hmU3FrTDFoWEt4eFhvNVZSb1RmZzdHTnJzemZjUDZUaGhWTHNPbDRMaUZQ?=
 =?utf-8?B?eHFVSEYxS215Zmlqdk1vMDNVdlFHeXUzWU1wVkRmMGMvQlp1NVVKRVg4SFhj?=
 =?utf-8?Q?M7fwj/mQZ8XuBXvCuikTFOwQqacdDk=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <24DD333A9B4E10438E7E3934285636DE@FRAP264.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: csgroup.eu
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 708f8ebd-fdb2-4d7a-6568-08da0717cce4
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Mar 2022 06:40:02.8727
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9914def7-b676-4fda-8815-5d49fb3b45c8
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: It8XmvSfxOINl9moaXxvj2+jRIPGjH768YUpLof27WdMtdFo5xIgOu50lNV7Z+1fx8NS/849f3ldTzmkdQnY9VbscJVbLxtXLIMSm7nukqs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR1P264MB4343
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgTHVpcw0KDQoNCkxlIDE1LzAzLzIwMjIgw6AgMTg6NTIsIEx1aXMgQ2hhbWJlcmxhaW4gYSDD
qWNyaXTCoDoNCj4gT24gVHVlLCBNYXIgMTUsIDIwMjIgYXQgMDk6MjE6MDBQTSArMDUzMCwgTWFu
aW5kZXIgU2luZ2ggd3JvdGU6DQo+PiAgIGluY2x1ZGUvbGludXgva2FsbHN5bXMuaCB8ICAyICsN
Cj4+ICAgaW5jbHVkZS9saW51eC9tb2R1bGUuaCAgIHwgMjAgKysrKysrKysrKw0KPj4gICBrZXJu
ZWwva2FsbHN5bXMuYyAgICAgICAgfCAyNyArKysrKysrLS0tLS0tDQo+PiAgIGtlcm5lbC9tb2R1
bGUuYyAgICAgICAgICB8ICA0ICstDQo+PiAgIGxpYi92c3ByaW50Zi5jICAgICAgICAgICB8IDg1
ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKystLS0tLS0NCj4gDQo+IEhleSBNYW5p
bmRlciwgdGhhbmtzIGZvciB5b3VyIHBhdGNoIQ0KPiANCj4gU2luY2UgdGhpcyB0b3VjaGVzIGtl
cm5lbC9tb2R1bGUuYyBhbmQgaW5jbHVkZS9saW51eC9tb2R1bGUuaCBJJ2QgcHJlZmVyDQo+IHRo
aXMgZ28gdGhyb3VnaCBtb2R1bGVzLW5leHQgWzBdLCBhbmQgYXMgeW91IHdpbGwgc2VlIHRoYXQn
cyBhIGRpZmZlcmVudA0KPiB3b3JsZCByaWdodCBub3cuIEkgYWxzbyBoYXZlIGEgc2V0IG9mIGF0
IGxlYXN0IDIgb3RoZXIgcGF0Y2ggc2V0cyB0bw0KPiBtZXJnZSB0aGVyZSBiZWZvcmUgeW91cnMu
DQo+IA0KPiBBbHNvLCB3aGF0IGlzIG9uIG1vZHVsZXMtbmV4dCBpcyBub3QgaW50ZW5kZWQgdG8g
Z28gdG8gTGludXMgZm9yIHRoZQ0KPiBuZXh0IG1lcmdlIHdpbmRvdyBhcyB0aGUgY2hhbmdlcyB0
aGVyZSBnb3QgbWVyZ2VkIG9ubHkgbGF0ZSwgYW5kIEkgd2FudA0KPiBhdCBsZWFzdCAyIG1vbnRo
cyBvZiB0ZXN0aW5nIG9uIGxpbnV4LW5ld3QgYmVmb3JlIGFueSBwdWxsIHJlcXVpZXN0IGlzDQo+
IHNlbnQgdG8gTGludXMuDQo+IA0KPiBDYW4geW91IHJlYmFzZSB0byBtb2R1bGVzLW5leHQ/IEkg
Y2FuIGV2YWx1YXRlIHRoZSBwYXRjaGVzIHRoZW4gZm9yDQo+IGludGVncmF0aW9uIHRoZXJlIG9u
Y2UgdGhlIG90aGVyIHN0dWZmIGdldHMgbWVyZ2VkIGludG8gdGhhdCB0cmVlIHRvby4NCj4gDQo+
IFswXSBodHRwczovL2dpdC5rZXJuZWwub3JnL3B1Yi9zY20vbGludXgva2VybmVsL2dpdC9tY2dy
b2YvbGludXguZ2l0L2xvZy8/aD1tb2R1bGVzLW5leHQNCj4gDQoNCkkgY2FuJ3Qgc2VlIEFhcm9u
J3Mgc2VyaWVzIG9uIG1vZHVsZXMtbmV4dCB5ZXQsIGRvIHlvdSBwbGFuIHRvIG1lcmdlIGl0IA0K
YW55dGltZSBzb29uID8NCg0KQXMgeW91IHNheSwgaXQgd2lsbCBiZSBhIGRpZmZlcmVudCB3b3Js
ZCBieSB0aGVuLg0KDQpJIGhhdmUgbXkgc2VyaWVzIHJlYmFzZXMgb24gdG9wIG9mIGxhdGVzdCBB
YXJvbidzIHNlcmllcywgYnV0IEkgd2FzIA0Kd2FpdGluZyB0aGF0IGl0IGxhbmRzIGluIG1vZHVs
ZXMtbmV4dC4gSG93IGRvIHlvdSBwbGFuIHRvIHByb2NlZWQgPw0KDQpUaGFua3MNCkNocmlzdG9w
aGU=
