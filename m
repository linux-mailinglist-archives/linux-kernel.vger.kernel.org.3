Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D7A95425E1
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 08:55:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443321AbiFHCCN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 22:02:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1588592AbiFGXyt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 19:54:49 -0400
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on2067.outbound.protection.outlook.com [40.107.113.67])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B8EE1124FD
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jun 2022 16:43:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nJX3q5GxbvpwUUwIEFwFk0QJo0nou3uXGXS2DN1VyfcaChuqv1fElImrxXfW8RNiAltkQuZJxzXE5Q2PBPB8G2CCXvTwC4ugZbPemKO0swGkU5d4slQGEwjh/wD+1M2wiWieKtkUagwAay5UJA39ybXnQ04YFv2IKHjI8+YzEKfgkI6WCulheJyO2eVoIVnCpS1mjY+YEQus7v7MsakgzhUy0pTkmpK8BOJ1zpWJ7C15oZIwtfSF0vSf7amWONu7z7PANHZ7Su6a4euWunIxd3SJ5tDHQtqeObOK89m0b3wW6aQFEoB3vB2TjANpZ1WK1BPitIcpcPEA0CNS3lbN4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dznJVNgrtaKWFJbmzpB+GsrA7TUUYDvssb8RbmB/V58=;
 b=gQMQBYZkKYpzlXLAJ52NvHi0mRUxEFk9BVb5kRprasXcKy3vEurVM4BBYvsOPK4ap1UP32UgFOawCXbsJ/WRWcHSdLeu/LebO/acwePoqm/Fk0j+12EL85WtyShcfd7LKLrOI964n2/wr2CYcjbqorQjt7pYcU8jNqZSEnMZsSceeZhSVIkcSH5EyePKSMXrUMvYM/XwESL1xT4sm1Y8/eUnEyePqrWKzMQV56n+2yRoHzdkRkbyMD7YZBKYY8VSDO/gV2hGh7jC+RoLdshut2jN6/uDykCgACy8RDGYCp30EOibhLxn4Z7UHW/Jz7h8ZEM/wm1FtJilXwVOpxxPgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nec.com; dmarc=pass action=none header.from=nec.com; dkim=pass
 header.d=nec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nec.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dznJVNgrtaKWFJbmzpB+GsrA7TUUYDvssb8RbmB/V58=;
 b=ef6YBLKNW5eUYV9P16PfWldXQBV78UO6GFK3hQ9OR2m8m/zS1Ggu0oKNfijD2+brWmJeoar6eSn8Wsawf99VAnzflC7sEf3sqBRRjuUYZZ1mgU4lxQLTjjWolMDtFufIzhazLPn2o3OifHA7eIkyDd/a8IBWGYwpCRccPDxq8SY=
Received: from TYWPR01MB8591.jpnprd01.prod.outlook.com (2603:1096:400:13c::10)
 by OS3PR01MB8257.jpnprd01.prod.outlook.com (2603:1096:604:174::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.12; Tue, 7 Jun
 2022 23:43:07 +0000
Received: from TYWPR01MB8591.jpnprd01.prod.outlook.com
 ([fe80::246b:9355:73ad:b995]) by TYWPR01MB8591.jpnprd01.prod.outlook.com
 ([fe80::246b:9355:73ad:b995%2]) with mapi id 15.20.5314.019; Tue, 7 Jun 2022
 23:43:07 +0000
From:   =?utf-8?B?SE9SSUdVQ0hJIE5BT1lBKOWggOWPo+OAgOebtOS5nyk=?= 
        <naoya.horiguchi@nec.com>
To:     Andrew Morton <akpm@linux-foundation.org>
CC:     David Hildenbrand <david@redhat.com>,
        zhenwei pi <pizhenwei@bytedance.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        Wu Fengguang <fengguang.wu@intel.com>
Subject: Re: [PATCH] mm/memory-failure: don't allow to unpoison hw corrupted
 page
Thread-Topic: [PATCH] mm/memory-failure: don't allow to unpoison hw corrupted
 page
Thread-Index: AQHYemstq5wHVjl6QUaJLwHj8eeeeK1EfwWAgAAc0AA=
Date:   Tue, 7 Jun 2022 23:43:07 +0000
Message-ID: <20220607234306.GA1400839@hori.linux.bs1.fc.nec.co.jp>
References: <20220604103229.3378591-1-pizhenwei@bytedance.com>
 <20220604115616.b7d5912ac5a37db608f67b78@linux-foundation.org>
 <584eedd3-9369-9df1-39e2-62e331abdcc0@bytedance.com>
 <20220606043202.GA1328953@hori.linux.bs1.fc.nec.co.jp>
 <3b58adbf-a8b2-8dba-71a7-123ba3850c10@bytedance.com>
 <20220606091503.GA1337789@hori.linux.bs1.fc.nec.co.jp>
 <5e7abb3f-56e7-0343-a678-749b6f5238a2@redhat.com>
 <20220607145959.785e54c752f373bcc283732b@linux-foundation.org>
In-Reply-To: <20220607145959.785e54c752f373bcc283732b@linux-foundation.org>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nec.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: bdd909c8-1155-4a5d-9bcf-08da48df78f9
x-ms-traffictypediagnostic: OS3PR01MB8257:EE_
x-microsoft-antispam-prvs: <OS3PR01MB825757E6CAAFAE4DB21AFC55E7A59@OS3PR01MB8257.jpnprd01.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: RcINxxyI+2sJdjrxWbSLEUypwkZ+WQSNy+6qYDHsWi9Wypt5+m7EIF9ncxFD3E07pHqbStUACKnlkxDxog5KLkKht1eAnAGkIfs7rjSqZEoDMBOggsbr17aMEFyi5Al+FRDmz43vVHXUy0Ca/CA6aSpp9QZ3v6zCimj0uwgf/PIgjdlfqgr3NEXinwiD9WxRnl9xvdTac40xl4vAYERODFWFqEQt9KOZLCiGP9GjPmuYzjyHfmmrN4EtJXDWcRGWyT4SPZtZkcp+dT48U6+wegllgAw1TwKBQW9grABd2s+ruVz+fW3/d532b5Po0BSPlF9q7jNUKj6vImj+8kx+ron12dcAzEdw2RwHxKEq/iW+xzTMS0PixQ+cPD6WyzeHdtHwDhJ3Jj/iAHuimFZV5kY2a23KGx9UouMqsAuU2ESk6BH9vgAuoHfpWC/ZzkuzfMMQanIwRh02XxAdjB0DQp4KwEJFuUb0nUwo0XyYLpXXuCtYaGkH0C7/SG5lToGBR4NtwIPrtnj9j5XTacocPtuaZPfhM6c/q0psfrBtNmJxe5j6Yg0sJDQ/aDjh4etwMZFf8ZdNJ8wMsIp+knuNH8pgoGyuflwHn17M9YctPolZr/b96O7rauH1OcM2agpmvkVXOVC0oCSUCg9yT9G8ICcE9Y0qw+Zy8CldUU54m19dcDQCSO/MF7Xd+g8JJLVl2URCLVXgQJ3uIfAhdB4HlQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYWPR01MB8591.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(6486002)(2906002)(4326008)(38100700002)(33656002)(508600001)(186003)(6506007)(26005)(71200400001)(86362001)(66946007)(66446008)(55236004)(9686003)(1076003)(8936002)(5660300002)(83380400001)(6512007)(76116006)(54906003)(316002)(122000001)(6916009)(82960400001)(85182001)(8676002)(66476007)(64756008)(38070700005)(66556008)(53546011);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TGJCblUyZThlRzdJbndsM2tDSTU0aUxWTXp3ZjJoRjdCU0p0NkdiL1BHeGRy?=
 =?utf-8?B?WUIrZ0JvV2FQMEtsa0phQzE1UFhxZVdkVUJ6cWM1SVV0UFVDUmFTeG5iamxl?=
 =?utf-8?B?Y0MrNGdxcWpxTlhWRVd0b052bjFyWitjQ2dqa1dPVDhXS3J1aXgrMWlwUzBp?=
 =?utf-8?B?ZGpvYmtxSlgwb3drRWpCaExYUGxQZFluVURRcEtseWtmeE1aMm00a3dQK2Ix?=
 =?utf-8?B?cnFMQ29nK1lLMWl5R2JLL28zYXhOcjBiRnA0MEpGS0pEZ1JiejhlTDB4V0ZX?=
 =?utf-8?B?VklPNVM4RFJsWW9kMjIyNE85cmdFSmVObG0xbXhjLzNwdFZ6SU43S2JvRWhE?=
 =?utf-8?B?dnd4N2pWcDduVEZjb1p0V1RGTGxvMVlQWE9vUTNYd2hoTlk3aERPQzB2YU16?=
 =?utf-8?B?QURzWTRzVWNLR0RTdjBDbUQySlBpbW1mZ054eU9DNjJyUlR2VTNWbnhsem05?=
 =?utf-8?B?MThqVjNiSnlkZFJBVWlDc0hxRDJBMVoyandaM2xlNEV4V2RGc1hBN212OGlt?=
 =?utf-8?B?QVorZXJ4d3k5SWZOWGlUNGY4QzB3dytPUkxHMDZsU3d3RHBMSTZIR3hiZmQr?=
 =?utf-8?B?VXlIVkkwR1BidGdzT2RIQ2gvNXRxaVE5UGpPZ0dEZ2daL0ZNQyt6S0NxcnF5?=
 =?utf-8?B?dTJNNjg4TlM4aHRQWjYreVo5NmtGTDFsbkx0Z1pzanBlL0NLQmcxYnN6QVBN?=
 =?utf-8?B?L1VxUzhQOFUyRmpWRDVYTUdBeU9uZUhYNkJhZTduR09ia2lMd2JVQnNiY3pU?=
 =?utf-8?B?OUlCaFJVSmhRdURiS0Z5ZlE0TG9FNHpGb2E4c1pkTExzbE5HNkxQZlk5NkJv?=
 =?utf-8?B?VDRJZVRzT1VkZGtaVlVhTWtqd1dEVS9WWVFOSTU0ZGk3aW1OWHBPa2JLdmcz?=
 =?utf-8?B?Y2NraG9KWDdvazlMSytFc1VTRERTQXV1WkowYUJ2MVhvY0VsTDhDTkZ2OWUx?=
 =?utf-8?B?Wm9PTU9kekJHaC9uM2JablFXNFN3KzR0K0QrdWdxSTNWSTBWRGQycGRuT2FJ?=
 =?utf-8?B?ZVZoTTVUY3I4ckxxeGRrazdDNkFHZXljaHd4U1AzZ3JuK2Q3QXRkNVh0cDdv?=
 =?utf-8?B?K3lqNnY2NmprZDJhL0R0bG5xUXJlMXY2bFF1WW1lNWpBV1BEYU9KdEJHbUxj?=
 =?utf-8?B?UE50b0ZKcVI4NHF3VGk1b2J1aE02RkEvV1E5TGFwc0w0MGJaZE4xL0FWdlNs?=
 =?utf-8?B?QlFJYTk4OVR1bWRuOEd1RlVhbzJML3FGajdSQjdSOHVKZUVrNTdtR2dtczV4?=
 =?utf-8?B?UTQ1VjJhL2d4YjJGcFA5VmtFcm5CWmgrYzlxM3FMUEx3c3ZwV1Y2aHR6dnA1?=
 =?utf-8?B?cERtZlpWZTVqdmtKZ1Y3UHRYZjBKSEZzenVnczdSZmhsa1hhNHJCd3lsdzRm?=
 =?utf-8?B?RWdUYTlreElTckxzOEg4cmNFSTVuYk82ekV1QmEvaGNyVDZ5RklmbTlMdTVO?=
 =?utf-8?B?UTRxZ2dESHFuc2ZEN0E5RmtqZlRxY0pHb0VZTUlTeVZJTEhJdE1BVXdwN0Zu?=
 =?utf-8?B?QUhHL3dpZVVod3FWYVFTNk9OYWhMenFwSnlkUllOeHAzWjVpOGZ6bktWR0Zx?=
 =?utf-8?B?cGVPQ2VzUGVVcUV6L0RiaThWVk1peCtyVHdJSUVnQzF0NDhZYzVtRzYrYTRi?=
 =?utf-8?B?TlcrM2dlbzY2R01ZSXhJQTRSam1oekJqVDNKZURTc29hcjh2dVdOejIwQnU3?=
 =?utf-8?B?Y0ZLYkI4UTBlMGZBZGU5V3pFdm0vUlByb0Z2VkVXRUh2SGJVc3ZHOVlYVlVj?=
 =?utf-8?B?VU9WZUQ0ekYvR0srbWJIL3Zzbm5pQ2NMdFhnd1BwR2UzNEhhRDdYd1FOM1Ev?=
 =?utf-8?B?Z0pMYUlLc29lNFhFRGdPVE1KT2dsSWFFT24vRFNxZW45eWVDRGJicHc4emdK?=
 =?utf-8?B?NHFFRjZrd2t0SUwxeEo0N1F1UTN6b2RqQXZSWXZKTzJLbkVCOW5OWkpKSnQz?=
 =?utf-8?B?UzhXdkZ1ZGppMjBFVk8vZkM2S3RPN1lSMGNDVmdVb1NYZ3BhaE5VY1p6c1R3?=
 =?utf-8?B?dGhwaUtnL0YyR05RRFRDTVVqOFdXbno5dXJOVktsSmtNWWh3clY0T0hWYW93?=
 =?utf-8?B?MUtMZDRtUDNybjE5c2diQ2E2UTlnMmU0MVNNUitLN056U0pIa2I3d01EVEFz?=
 =?utf-8?B?TkJIVVdZejVldjZnWEpkeXloTE50QTA2WElSUzkxRWhqVGlLUm1GeFp3ZVhy?=
 =?utf-8?B?V3lqdEo3ek8wODNVMmlJTXlIUFo0c1hoTmZ0djFCYmN1Um0ra3ZSTUV1eVEw?=
 =?utf-8?B?ZFZUbXZlSkJLbERkVlQ1eHNleDR0VGhGVlpCZTlFMVhxT2tEVzdIOTFLRklE?=
 =?utf-8?B?TUtqWStaZmxnQzkyS0VmaGdkTnIwNjdLR1Y4LzB4QkszMW9mSzFOdEhQOXFx?=
 =?utf-8?Q?QXAFvcBlgq1qpi7g=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <330AC2DE4B759D4392D45024273A6310@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nec.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYWPR01MB8591.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bdd909c8-1155-4a5d-9bcf-08da48df78f9
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jun 2022 23:43:07.0565
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e67df547-9d0d-4f4d-9161-51c6ed1f7d11
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Nz/9gRV7Aq8QNtLRAPwhgXv6nVthiW+SG/9ROTsDcSMnm3/cCws2Z266E99esRnhB5aFDbqLOIATgBVkvTreoA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB8257
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVHVlLCBKdW4gMDcsIDIwMjIgYXQgMDI6NTk6NTlQTSAtMDcwMCwgQW5kcmV3IE1vcnRvbiB3
cm90ZToNCj4gT24gVHVlLCA3IEp1biAyMDIyIDE0OjM2OjAwICswMjAwIERhdmlkIEhpbGRlbmJy
YW5kIDxkYXZpZEByZWRoYXQuY29tPiB3cm90ZToNCj4gDQo+ID4gT24gMDYuMDYuMjIgMTE6MTUs
IEhPUklHVUNISSBOQU9ZQSjloIDlj6Mg55u05LmfKSB3cm90ZToNCj4gPiA+Pj4gICAgWyAgOTE3
Ljg2NDI2Nl0gIDxUQVNLPg0KPiA+ID4+PiAgICBbICA5MTcuODY0OTYxXSAgY2xlYXJfaHVnZV9w
YWdlKzB4MTQ3LzB4MjcwDQo+ID4gPj4+ICAgIFsgIDkxNy44NjYyMzZdICBodWdldGxiX2ZhdWx0
KzB4NDQwLzB4YWQwDQo+ID4gPj4+ICAgIFsgIDkxNy44NjczNjZdICBoYW5kbGVfbW1fZmF1bHQr
MHgyNzAvMHgyOTANCj4gPiA+Pj4gICAgWyAgOTE3Ljg2ODUzMl0gIGRvX3VzZXJfYWRkcl9mYXVs
dCsweDFjMy8weDY4MA0KPiA+ID4+PiAgICBbICA5MTcuODY5NzY4XSAgZXhjX3BhZ2VfZmF1bHQr
MHg2Yy8weDE2MA0KPiA+ID4+PiAgICBbICA5MTcuODcwOTEyXSAgPyBhc21fZXhjX3BhZ2VfZmF1
bHQrMHg4LzB4MzANCj4gPiA+Pj4gICAgWyAgOTE3Ljg3MjA4Ml0gIGFzbV9leGNfcGFnZV9mYXVs
dCsweDFlLzB4MzANCj4gPiA+Pj4gICAgWyAgOTE3Ljg3MzIyMF0gUklQOiAwMDMzOjB4N2YyYWVi
OGJhMzY3DQo+ID4gPj4+DQo+ID4gPj4+IEkgZG9uJ3QgdGhpbmsgb2YgYSB3b3JrYXJvdW5kIGZv
ciB0aGlzIG5vdyAuLi4NCj4gPiA+Pj4NCj4gPiA+Pg0KPiA+ID4+IENvdWxkIHlvdSBwbGVhc2Ug
dGVsbCBtZSBob3cgdG8gcmVwcm9kdWNlIHRoaXMgaXNzdWU/DQo+ID4gPiANCj4gPiA+IFlvdSBh
cmUgZmFtaWxpYXIgd2l0aCBxZW11LW1vbml0b3ItY29tbWFuZCwgc28gdGhlIGZvbGxvd2luZyBw
cm9jZWR1cmUNCj4gPiA+IHNob3VsZCB3b3JrIGZvciB5b3U6DQo+ID4gPiANCj4gPiA+ICAgLSBy
dW4gYSBwcm9jZXNzIHVzaW5nIGh1Z2VwYWdlcyBvbiB5b3VyIFZNLA0KPiA+ID4gICAtIGNoZWNr
IHRoZSBndWVzdCBwaHlzaWNhbCBhZGRyZXNzIG9mIHRoZSBodWdlcGFnZSAocGFnZS10eXBlcy5j
IGlzIGhlbHBmdWwgZm9yIHRoaXMpLA0KPiA+ID4gICAtIGluamVjdCBhIE1DRSB3aXRoIHZpcnNo
IHFlbXUtbW9uaXRvci1jb21tYW5kIG9uIHRoZSBndWVzdCBwaHlzaWNhbCBhZGRyZXNzLCB0aGVu
DQo+ID4gPiAgIC0gdW5wb2lzb24gdGhlIGluamVjdGVkIHBoeXNpY2FsIGFkZHJlc3MuDQo+ID4g
DQo+ID4gVGhhdCdzIHRyaWdnZXJlZCB2aWEgZGVidWdmcyAvIEhXUE9JU09OX0lOSkVDVCwgcmln
aHQ/DQo+ID4gDQo+ID4gVGhhdCdzIGEgREVCVUdfS0VSTkVMIG9wdGlvbiwgc28gSSdtIG5vdCAx
MDAlIHN1cmUgaWYgd2UgcmVhbGx5IHdhbnQgdG8NCj4gPiBjYyBzdGFibGUuDQoNClN1cmUsIHRo
ZSBpbXBhY3Qgb2YgdGhlIGJ1ZyBpcyBsaW1pdGVkLg0KDQo+IA0KPiBTdXJlLCBpdCdzIGhhcmRs
eSBhIG11c3QtaGF2ZS4gIEJ1dCBsZXQncyBhbHNvIHRha2UgdGhlIHBhdGNoDQo+IGNvbXBsZXhp
dHkmcmlzayBpbnRvIGFjY291bnQuICBUaGlzIGlzIG9uZSBkYW5nIHNpbXBsZSBwYXRjaC4NCj4g
DQo+IE9yIGlzIGl0LiAgU2hvdWxkIHRoZXNlIHRoaW5ncyBiZSBoYXBwZW5pbmcgb3V0c2lkZSBt
Zl9tdXRleD8gIFdoYXQgdGhlDQo+IGhlY2sgaXMgdGhlIHJvbGUgb2YgbWZfbXV0ZXggYW55d2F5
Pw0KDQptZl9tdXRleCBpcyB0byBlbnN1cmUgdGhhdCBvbmx5IG9uZSBlcnJvciBoYW5kbGluZyB0
aHJlYWQgY2FuIGhhbmRsZQ0KdGhlIHBmbiBhdCBvbmUgdGltZSwgYnV0IHNldF9tY2Vfbm9zcGVj
KCkgaXMgY2FsbGVkIG91dHNpZGUgaXQgbm93Lg0KU28gaWYgd2Ugd2FudCB0byBwcmV2ZW50IHRo
ZSByYWNlIHdpdGggdW5tYXAsIGJvdGggb2Ygc2V0X21jZV9ub3NwZWMoKQ0KYW5kIHRoZSBuZXcg
a3B0ZSBjaGVjayBtaWdodCBuZWVkIHRvIGJlIGRvbmUgaW4gbWZfbXV0ZXguDQoNCi0gTmFveWEg
SG9yaWd1Y2hp
