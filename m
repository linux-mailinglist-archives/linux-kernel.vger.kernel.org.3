Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2ACC350EEDB
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 04:40:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242189AbiDZCny (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 22:43:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231448AbiDZCnw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 22:43:52 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2059.outbound.protection.outlook.com [40.107.237.59])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C4F626FA;
        Mon, 25 Apr 2022 19:40:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DfYuIcPrERXi414LeDyunesIWlE9Q63o2Q80JRY5PLHSxVnn8JxsPuikRaifQanOPq14a2twONmM+kXb7+/gYnO/c3ZABphs59HYgwLTEY2tywTV35rT0dyWdaCFONgXChkqd58eJINQPEqMO57ROXLR5qz0A8INuDEQNfGRVWQ9UaESkS/DOz5AG+ajGc/KG/twlGQ7Ma3eqkkH6wwNR2AXwLw3rdZ/g6N0RRu09ZravaJD+svxLLLguiAJ0afuTOh5fKGXe3uKbxCKX93tnc2h543cUkAaNj/6oGYs9QGQ/iQZiOIFoR2QuoBez/GdlZ2T79wOJ8wELm43BQp1LQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/Io3DPK36WCdwFoG4U0r0CNaJfxB2tNOG+PYz0YnHeA=;
 b=mETIN5TdIzZ/CbRaws1B8qv2h99LEx0H4aw81zsnlpMjqh5D6Vh2TiCPg+MhEe7avmHLSjPdfCoFKrx2vBBiV3S2KZ0xUPqARU5aS4qetF1++8YvWKNNBC985LzAPXK7yMlEI8KpY62FR8aUCkbHEbRcPRhUY/DLDOpNInRiEfkbRw4o8Ln9eUA9D8URBc7/i7gFOPeUxA4cGAdeaHRynFrnYS6Tqy1MmmCeo9ysBWrL/8IyaNm8hEAL+uAB7cfHq0oovuw8npRM6gL23/rhNWdVKDhWRiFJuR6+nrXDue8XY3Vr0eflWosiVq5UQDCn/6aYGC5CjmrTE302tuTxmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vmware.com; dmarc=pass action=none header.from=vmware.com;
 dkim=pass header.d=vmware.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/Io3DPK36WCdwFoG4U0r0CNaJfxB2tNOG+PYz0YnHeA=;
 b=LJ6SRUIWpkgYHhEPp1GndPQPlzhlKGzcTM19iH48WGHEF0XM0DcKsB54+YjLUth8nFapRYiyWsZZUEkDnN/nBmyAcJVctALxhIYmHSfE1ea6BcnRRCkxQ0gAPTEBaHpqWlQ8WRruXl9S02C+G11TOzXSxHSTq4i/VHbSyggnQRc=
Received: from BN8PR05MB6611.namprd05.prod.outlook.com (2603:10b6:408:57::15)
 by DM6PR05MB4027.namprd05.prod.outlook.com (2603:10b6:5:82::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.6; Tue, 26 Apr
 2022 02:40:39 +0000
Received: from BN8PR05MB6611.namprd05.prod.outlook.com
 ([fe80::2cee:3759:958:cf21]) by BN8PR05MB6611.namprd05.prod.outlook.com
 ([fe80::2cee:3759:958:cf21%7]) with mapi id 15.20.5206.012; Tue, 26 Apr 2022
 02:40:39 +0000
From:   Zack Rusin <zackr@vmware.com>
To:     "dmitry.torokhov@gmail.com" <dmitry.torokhov@gmail.com>,
        Pv-drivers <Pv-drivers@vmware.com>,
        "zhouzongmin@kylinos.cn" <zhouzongmin@kylinos.cn>,
        Linux-graphics-maintainer <Linux-graphics-maintainer@vmware.com>
CC:     "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] input/vmmouse: Add vmmouse_reset() function to disable
 vmmouse before entering suspend mode
Thread-Topic: [PATCH] input/vmmouse: Add vmmouse_reset() function to disable
 vmmouse before entering suspend mode
Thread-Index: AQHYPZIhp4Xw4mjhjEmAZM3inmskm60BsuCA
Date:   Tue, 26 Apr 2022 02:40:39 +0000
Message-ID: <167fdac46012b58d3180b2ea73ee27e13d03473f.camel@vmware.com>
References: <20220322021046.1087954-1-zhouzongmin@kylinos.cn>
In-Reply-To: <20220322021046.1087954-1-zhouzongmin@kylinos.cn>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.40.4-1ubuntu2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vmware.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c98a7525-3097-4a62-83e2-08da272e2688
x-ms-traffictypediagnostic: DM6PR05MB4027:EE_
x-ld-processed: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0,ExtAddr
x-microsoft-antispam-prvs: <DM6PR05MB402708E29B46CAA8B8231623CEFB9@DM6PR05MB4027.namprd05.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +OZHo5IuqT878OPk4uZh/Xjg8lqRGiFr/D6Jt4oUpj2HTALYEx2NIzm5oF7r2didZ1mwDdOcreqgFGbliuZkg1LOKOiuv6ZjK+REqSvfVOTvLfJu8ZgfWBZFtLUyxXxl3V5dQS0K4dDOSC0LUxP7xdv2CpoG7N3P4LsacxSTajZTTg1m515wlkk0cwZQ12oroz1MwMp6lR9p0PRfLRIXwS9tP76tubE8YkT8TkTX57onKhPR+mBlEPYnXRz48JiUFPTMMktZfWkOBWjHjoYaUFs3ltXc7+J5ColC/ZNnSkHLEeQdSqKOIqs+V7Pso7l5sGa84/4PUU8+yy2IqgaxfImAxQuudQ0nApK9To7b61VyuH2cA354Vq5EWep8DM9t3LQIR7gv5qfPD1tsATwhSyavoLyYSNYb499AsYb+7U96peDg9fvwrRDQ7o7RRSW0w6ohcfhZXLGLm8mFpdIugMkcldu7xjFpqgOlkrZ+u3LB1qyG2Qsc6XoPPh6dZ7cMhbXTIlVNRO48kQmvVmdcvXH6cD59u/Dk8OYvo1dXgtqkOrQLYBuwLiQESVQdIKixZxdgG+WSnC4LD3DoQcT8zIwpCvn7OR3GCzKyoFNXEmtmb7LUhX8+cTUFGwJWz1i5KabOp3SxPQ4O5m7osIvORVJMUjCpVb/FAwAbGDG115Ox90qGHtwNTaocekEbfZI+hi+L96D1ekQwk7pxPS2SQg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR05MB6611.namprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(86362001)(26005)(6512007)(6506007)(83380400001)(54906003)(186003)(2616005)(8936002)(66556008)(66476007)(4326008)(64756008)(15650500001)(66446008)(8676002)(38070700005)(38100700002)(71200400001)(2906002)(5660300002)(66946007)(36756003)(122000001)(110136005)(6486002)(508600001)(76116006)(91956017)(316002)(6636002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WW1ZMFFNNnJQZjJacjQ1YU8vOU5zeVA2dVk5UGpCdGtnZ09WT0RjNmxzdHdE?=
 =?utf-8?B?SmphQzd1ME9adXVuUVJEMlF6dXV6VG0rLzFETjRCdVFIa292NzN1RjdDNDJ2?=
 =?utf-8?B?MlV0NW0vRzFoREhndmhqTFZwTXp3RjMxczJWMmVrWmx4b2Mrb3ZGTVFnZjVa?=
 =?utf-8?B?RmJZb05hcVJPMEFGL3VreHc0UUZLQmVXSWdTanV4dEZ4Qk1zdnlPQ0hYRXJn?=
 =?utf-8?B?Sm5kdzN3MUUzSUhoOW9yNmxaYkZmZi9TaGVUTXUwRWd1YzQ4RFR3TklTU3Bj?=
 =?utf-8?B?UGFXMitVdUFvVFZTOVFMM3VjalQ4aU9UYy9mNXhKNzBlNnBEVHllbmg5L2Jh?=
 =?utf-8?B?Z0tVQS80d0FzYkY0bGtoWXBqeC94dkJBS25BZktCSWZ6K09RZXFPZkppZjJX?=
 =?utf-8?B?SlhiL3pvNm5SNVhpdmZ5N2tKZ3h2OXdTZm1lNmswZllTL2R0UEtoZERzVjFo?=
 =?utf-8?B?SXhubzhkMnp3YWI1M1BVT0UvRVI5d0NwVi8zUTZTZXJrUGczekhVbnFib1h2?=
 =?utf-8?B?Q0h6Wm5oejhhMStEN1ovODdVcEVsaUs1NmZHVFR6dDhTb1FOT29HM29WZ25P?=
 =?utf-8?B?SSs3VVBkYlFXKzBrejZwNGtJQmhtZmQ2WGJ6ODBWMU5NN0dUU2N0RzlvQkpP?=
 =?utf-8?B?dTdDV2NTSU5YeVpaMHpmN3VuNUxKamhrQ3creHlSTjZkSXBsRmcwU2I0ZHF6?=
 =?utf-8?B?QllxUmUvYjRoc2RJejcxa0wrR0hJZ1JNWU5QcHloekIrOENjSTZ2MFV6QWpH?=
 =?utf-8?B?bjFBVmpkQWxXRGJ5cXFpQXJYYmFETTVnU1FSWURpODJFQ0h3RTQ4MDJpd0tQ?=
 =?utf-8?B?dmpMdjR1anNRNElQRVg2Y2hDV01DTWRwS0toK1haOFp2bjQzRWo2ZTRxWVNx?=
 =?utf-8?B?Wi9ZNEFIMnlIeFJmK0lydXpoSkhKOWF2Q0NJRjNaYitBUFRWWGh6bTkyTmVs?=
 =?utf-8?B?UkkwUjM1RUUxaDkwczA0bW0ySVFRZnc3c3ZNa1g2dXFtbFpoVHdGYWd1ZVdp?=
 =?utf-8?B?Y3BCUElyWFdXcGpBd29tb1paMjJUc3JZeDhPMTZZT1ZFbFFpOTgwWEFuUTBh?=
 =?utf-8?B?OTRobkhJQTVJVnpZbi92UGJPMmxoWE5mYnpKdG5tWStKcE5tSFpMU0hSN1NI?=
 =?utf-8?B?N3lKL3dSNldEN2JzNmlVM29TTHdrQllxSmh0bzF2UVcvSW5iVDBaVWN6Vndm?=
 =?utf-8?B?bEpCb0NFdVczTS9WRG9BRmdZd3d0STBrYTNKazFPV0dQWFJLcjRackN4bFBW?=
 =?utf-8?B?T1E3S0xQYWhQT0VuazJVRUpMdnRWWlNOM3RZYzdHYzlidnFlUS9rSGxtTDZL?=
 =?utf-8?B?cmRwdnc3RGtNTE0xU241bnFuTCtzT2JCWXp1amFGWHk1M3FlL3RTNFNUN21t?=
 =?utf-8?B?TlQvdS9HZHhPbUlkOHZKeFlNSEVuZTQ5T0pYRkhIY0pvR2VaU0J0TWNZV010?=
 =?utf-8?B?RERUMGlpbEVhdTRkZ0VpWDFUSk9OZytqYk9lR1F0OHVzeDdCTXE4RGE0UFU5?=
 =?utf-8?B?a3ZPbEZGOFJXemdKZTdjeldsWUZZakxUZVBWQmxvSE1Tck12TGxyajhpMFd3?=
 =?utf-8?B?OTVMZy9KbDk3RGFwdUhKT3Vuei9RSk1sRDZLcWxrdldGUS9HYy9GZFlRYmxQ?=
 =?utf-8?B?TVRhOXJnOUo4Uk5lUXdOUzZ5SnczMEpNeEZBQ1lBM0k2YmI5R3dtVGtzTExP?=
 =?utf-8?B?WUhTNFJLbjB1cmJIVWNDS3RZOVZqdEVTQlY4UzFZQldleUcvQlliTEx6dVd0?=
 =?utf-8?B?UHN4czhLNEsrZDF3RStlV3ZrOERRelFpVjBlYWQ2VXRzejczaXJ4S2xVeFVx?=
 =?utf-8?B?THpZeXA0VGM2MGxaZHlkTkNvY0doMGdZcnFZR3lGbUZlaXRraDhkdUJaZ3J0?=
 =?utf-8?B?YWdBbFNPTGFiN2VZMW5xdEdkczc5ZjlQZ2E4Mlc3UXcwNGpjcWU5OVRjdElQ?=
 =?utf-8?B?N3U4eXBqaC8zYXBnU24yZEsxRHRZaXhteXl2Q28rUHladkJkRmg5ZnlBSVVF?=
 =?utf-8?B?VDlCRE9pMlAwcjZLWWM4ZkFYaWZJWnNDQjI2ZUxnVjFrVUF5c2hlVStjRDR0?=
 =?utf-8?B?cmdGNDZ5Z1o4V3Jmc3BMNWI5THpLNXNESFJXMmJhcTYydzNuV0kvcEZtdnJ2?=
 =?utf-8?B?ZzBrbnpyUDRlL2VZckc4SDhCditRRWlZeUtNUEZLcnNOTElReDJuYnJHdHVK?=
 =?utf-8?B?ZmpRYXp0emdqamNQSW1DMm5oMG5rQ01PUEN4Z2hyNk54SHJ0eE9Ld3l4bGVW?=
 =?utf-8?B?ajVVTWhzblAvdDI3NFdNRUhtTHBMbS92L0VLS214T21KWlVBMlVJM2JZelp0?=
 =?utf-8?B?aC8reVBjTmlhVUlJK3BTNERHdE9FNGkyWm5LOENQZ1V5OG9kSEFGdz09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6F1FEEA0BEF9E34B9684386C15305746@namprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN8PR05MB6611.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c98a7525-3097-4a62-83e2-08da272e2688
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Apr 2022 02:40:39.4493
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Pb+vSgb6Nh+XTu9wpuXRdS2oaTrEovjtHOEx2Ooxn3ZmAqHc0jkz0Qc+LlZZtDANVFAEDmfZQgEehXFt/+4Dbw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR05MB4027
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVHVlLCAyMDIyLTAzLTIyIGF0IDEwOjEwICswODAwLCBab25nbWluIFpob3Ugd3JvdGU6DQo+
IOKaoCBFeHRlcm5hbCBFbWFpbDogVGhpcyBlbWFpbCBvcmlnaW5hdGVkIGZyb20gb3V0c2lkZSBv
ZiB0aGUNCj4gb3JnYW5pemF0aW9uLiBEbyBub3QgY2xpY2sgbGlua3Mgb3Igb3BlbiBhdHRhY2ht
ZW50cyB1bmxlc3MgeW91DQo+IHJlY29nbml6ZSB0aGUgc2VuZGVyLg0KPiANCj4gRGV0YWlsczoN
Cj4gV2hlbiBJIHVzZSBWaXJ0dWFsUFMvMiBWTU1vdXNlIG9uIHZpcnR1YWwgbWFjaGluZSxUaGVy
ZSB3aWxsIGJlIGFuDQo+IGVycm9yIG1lc3NhZ2UgYWZ0ZXIgcmVzdW1lIGZyb20gc3VzcGVuZCBt
b2RlLg0KPiBsaWtlIGJlbG93Og0KPiBwc21vdXNlIHNlcmlvMTogdm1tb3VzZTogVW5hYmxlIHRv
IHJlLWVuYWJsZSBtb3VzZSB3aGVuIHJlY29ubmVjdGluZywNCj4gZXJyOiAtNg0KPiBBbmQgdm1t
b3VzZSB3aWxsIGJlIHVudXNhYmxl77yMc28gaGF2ZSB0byBkbyBmdWxsIHJlc2NhbiB0byBmaW5k
IGENCj4gYW5vdGhlciBkcml2ZXIgdG8gdXNlIGZvciB0aGUgcG9ydC4NCj4gDQo+IFRoaXMgZXJy
b3IgaXMgZHVlIHRvIFFFTVUgc3RpbGwgZ2VuZXJhdGUgUFMyIGV2ZW50cyB0byBub3RpZnkga2Vy
bmVsDQo+IGRyaXZlciB0byByZWFkIGZyb20gcXVldWUsDQo+IGJ1dCBrZXJuZWwgY2FuJ3QgcHJv
Y2VzcyB0aGUgZGF0YSBpbiBzdXNwZW5kIG1vZGUsIHJlc3VsdGluZyBhIHN1cmdlDQo+IG9mIHMt
Pm5iX3F1ZXVlIHZhbHVlLA0KPiB3aGljaCB1bHRpbWF0ZWx5IGxlZCB0byBhbiBlcnJvciBnZXR0
aW5nIFZNTU9VU0VfVkVSU0lPTl9JRCBhZnRlcg0KPiByZXN1bWUuDQo+IA0KPiBUZXN0IHNjZW5h
cmlvOg0KPiAxKXZpcnR1YWwgbWFjaGluZSBzdGFydGVkIHdpdGggcWVtdSBjb21tYW5kICJ2bXBv
cnQ9b24iLGl0IHdpbGwgdXNlDQo+IFZpcnR1YWxQUy8yIFZNTW91c2UNCj4gMiljbGljayBzdXNw
ZW5kIGJvdHRvbiB0byBlbnRlciBzdXNwZW5kIG1vZGUNCj4gMylyZXN1bWUgYW5kIHdpbGwgZ2V0
IHRoZSBlcnJvciBtZXNzYWdlIGZyb20gZG1lc2cNCj4gDQo+IEZpeGVkIGJ5Og0KPiBEaXNhYmxp
bmcgdGhlIHZtbW91c2UgaW4gaXRzIHJlc2V0IGhhbmRsZXIsSXQgd2lsbCBub3RpZnkgcWVtdSB0
bw0KPiBzdG9wIHZtbW91c2UgYW5kIHJlbW92ZSBoYW5kbGVyLg0KDQpUaGFuayB5b3UgZm9yIHRo
ZSBjbGFyaWZpY2F0aW9uLiBMb29rcyBnb29kLg0KDQpSZXZpZXdlZC1ieTogWmFjayBSdXNpbiA8
emFja3JAdm13YXJlLmNvbT4NCg0K
