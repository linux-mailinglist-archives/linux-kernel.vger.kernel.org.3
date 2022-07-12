Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85B54571208
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 07:57:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231690AbiGLF5l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 01:57:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229542AbiGLF5k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 01:57:40 -0400
Received: from FRA01-PR2-obe.outbound.protection.outlook.com (mail-eopbgr120080.outbound.protection.outlook.com [40.107.12.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD18F3134F;
        Mon, 11 Jul 2022 22:57:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kWpme3uzngYOQJsLzDtPjw0gJNkUKp3DYML1b+1WWqCsS7xXOfw9EkEbh+HxXjzcifpuIGn5i3qMYhRua5+5DcC+wJyScL3Qe+6hCjHLpjUdSMa+i0gVm3myhKRTro6FlV5q9xCBOlyEFlwc24S1a3tB9TIzpHKctilYyLJ3/dIORNVQUzqKJyMufshzAAWjVH2SfWMPZoaSCdl2bpNXYUE2sNrprpQcnbLh8Jz7auJcUAIThplU14nQ5iMJop/hZBVO79l9AMSHCb5RibLMQw7EKNIM0Ll6bsk486h4oH/lzKJ4jGnYH+cCHEcLx0bFlpHXShz4ARZO8MVuEYxCsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KNd5OHDFOMyAcA35nrGpwtC7HP6yS4SAiBAZrWlRNKQ=;
 b=Q9kXdiFemuQZIvbCmHfkL0tNYElG0P9dMbSbWxr9kwzCt2q7Y0LsCYSJxG8La0C4aH2phCKRcgYMrnxJVWW6qCOE75nCKlJ4oxV8r61Lj4WW18IUzs/Uz7P5oh5DoBrGcCCqDl4xI9ZGA/hlTvqUzafSQbOu+JJe1nKUFPtmPmxQgDonnAs7umdt3b7tQYlkKzCdFbzw1epfvkvwGiwczOF3neCB/jcCyjJk3dEGzVjDfafcl9PoHZ9mKtPcsNX3mYXyd2xZmm7w/7AlVfp/3NwoYsjT5TW9fjWVLnilbso+fvbj428rOFJ6AIX61jR8Vj3mGW9EZO41tVJ2nie9EQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=csgroup.eu; dmarc=pass action=none header.from=csgroup.eu;
 dkim=pass header.d=csgroup.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=csgroup.eu;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KNd5OHDFOMyAcA35nrGpwtC7HP6yS4SAiBAZrWlRNKQ=;
 b=sNug10HQWLtza7cxm0nXOL/EOAPMu4D/id1v6LeKIHoHhQNfJwGdoC929t0OTreHRz/gbgSaWMwb5l90tBKpDvUblexKo0Y5v5P5mP3+Pr0w8IF6Z8mFOqO+tOlAdeAum+kxiN/mZKnhGkO+2LV1eKiGz1EjI8fTruxNS/vm9np3P1jl8h9m/b57jQee5K5FZ3JX+gmC5wuicbT+4KZykemYZiPHANzDJO3oRBfGmEaYXlV/hVof2L+dsH3huOA84YHdsn01/rDxm+HN4KSU78OWYoijZkqXzjIpVeGvomPJNb0Qtahj/BVvphafFlq1tfnY0HMEIj2VL2dK0qN/Vg==
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:31::15)
 by MR1P264MB4195.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:25::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.16; Tue, 12 Jul
 2022 05:57:35 +0000
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::e063:6eff:d302:8624]) by MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::e063:6eff:d302:8624%6]) with mapi id 15.20.5417.026; Tue, 12 Jul 2022
 05:57:35 +0000
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     Luis Chamberlain <mcgrof@kernel.org>
CC:     "linux-modules@vger.kernel.org" <linux-modules@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "atomlin@redhat.com" <atomlin@redhat.com>
Subject: Re: [PATCH] modules: move module symbols from init/Kconfig
Thread-Topic: [PATCH] modules: move module symbols from init/Kconfig
Thread-Index: AQHYlUI0lS17lhNdbEioFe+q7QTC9q15fs+AgAAJuYCAALWEgA==
Date:   Tue, 12 Jul 2022 05:57:35 +0000
Message-ID: <09f3ec9a-3a8e-d116-d38a-2fdb55f125c6@csgroup.eu>
References: <20220711162049.761342-1-mcgrof@kernel.org>
 <74dcc785-f3e7-6832-9af3-e0a0f69c58c9@csgroup.eu>
 <Ysx1C9IkJiFL+OH5@bombadil.infradead.org>
In-Reply-To: <Ysx1C9IkJiFL+OH5@bombadil.infradead.org>
Accept-Language: fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=csgroup.eu;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0ab642ab-d5a9-48ab-8ef2-08da63cb6b2f
x-ms-traffictypediagnostic: MR1P264MB4195:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Z3cHYuqdQ98r+ds+N1d9IVsHo/elp1pmvp+DsK5sUSkc7pMrSwjL97/YV8D8ETAZvFQTmHqGrwOciKk1/O5oQ32zAY99wgAodjrYKUE7AnlvwGAmspcE1RUE1gNALfxPrPACq4SG9yJ8selOopfjiawpQGOUNRm2abjgLec/s8j09wWe/YrOtBkF+dttMitMXPqpNKrzBaEeBEPIoA/Otqr359t/gupkrEY9qWyVqjT77VCg+dpXMtt3CpOO36iHB4MXMWGU9eUxXltV10/AiemwMhnpC3zNCN2xeYQ5DGVFzSayqCEo8ra18m7jRSWFl0IZRnCiEUA2/dIr7ieZjIVJQUPMrI9M16vbhVpGn0AHWQJRMehHOPwUaNEf/pa2Y2n6zN7VoyBPowFnZQnzfsCjnRspffLfuWNcc2EE1abEUlFxhG/JgKUTRRtdAT61w1313pxlmClBAaPXej5WCk4npUZXBooK5J59wqBuVnZ9GFmtDCpTUrRKxBm9ENiLbhc8S9GhAIRPts6XwuVT8o+Qw11UgVEunRXiT/eu0D9kZbLZn+LXoqD+0OGMB1Ax++nL0/rS89hMGKHeYOLTzsrWUzZoKrKHZhj1tDz3uNn4r6Z5U1Sb67LacirQLqPROyLBShnq+KVCG5tp7TjnCjIQ47hGgukf/07lQOvBnIg9QTdyMs/qVybCQodfYa9M5ZwvvkHg3WvVKLS1Hxlwo5O1bWXK+kTTUZDqtpWj9RLGXLWTsDQ8Ypv/voRBvPYkDTNco+mAhwCnlT1TueEPtqye3YxrGIgO3arkB1rOZUOOvaCC6IOu7mqp48DQr1mrhdLIUxSairpFHwS5Cckawjia0SV83cNAbofqEjAUZbteAcpYDipudz1uCHlVsK8RaF2PwJKKhX1VDxm8rZVXDrhILVHe8I+woGHmRaoc3mY=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(346002)(396003)(376002)(366004)(136003)(44832011)(186003)(316002)(478600001)(54906003)(71200400001)(8936002)(26005)(6486002)(5660300002)(2616005)(122000001)(8676002)(38070700005)(86362001)(6916009)(6506007)(38100700002)(31696002)(41300700001)(2906002)(64756008)(76116006)(66556008)(66446008)(66476007)(31686004)(91956017)(6512007)(66946007)(36756003)(4326008)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QWM2VUZ0c0M2bjkvek85WW5oUkIvaFlKdmhnMWoyZi9MYTlnMUI0ZStnSW8r?=
 =?utf-8?B?a2d6UFBDK0pCWElMWlo0VE9HcU1oRlZlVmlndS9DQ0wvbmhPak1LeWwxL0JI?=
 =?utf-8?B?TGhzWXlDZXJKUXd6Nkx4YlNldGVlS2VlUFhDaUdoNC9OQmlWYmlKVVVSZ1Qz?=
 =?utf-8?B?VGxTVE9sempVVTRtYllFNWVwUCs3YzZmN2hpZHJJWmlDVmdxN0w2T0RCTEZJ?=
 =?utf-8?B?eWNzcVh5Y1QzM2s5dnh0Z0tXRklwcUZqbjJQWjJLVFU0N0tSaE9aWk9ZTURw?=
 =?utf-8?B?aWFFdWVScnpoZDQ1QTRNU0Q0NWpWdXliTDBUejBlekt6dVhMUjNuVHZaY25O?=
 =?utf-8?B?SFphWVdEMjRzZlBock5XTjZYbGdDOENrTmErNkxDNGxxSVd1L1UxcEkxQytN?=
 =?utf-8?B?UHpvVUprbmlSL1ZBVWowY3RTTGhhOXYwRU1CY21yV1Ixd1hhWWc1bER4dkpJ?=
 =?utf-8?B?YXFrMnRJT0JmUUtpRXBrNVR1TDhWckNKTFQ2TnZWa05ueGFvRkdmanRKYXBS?=
 =?utf-8?B?SDJRRjYrRFB3dWhOUUFLVlB2aEplRlBXemQvaGZxN1I2YUVBZk9vUjMzZzEy?=
 =?utf-8?B?N1ZXb2hVNW9GR0phaGxIZGdCRnBDN0JESnQybDkwYWIzYmVNSGJaU0pxSXZX?=
 =?utf-8?B?Ym54MmszWExOa1Y0RFpxdVJjazdtVHBaMTh4MTJMa1Fzb2NxcFJOc2pTNGVX?=
 =?utf-8?B?aW0zNjVQcElERGx1Q0I0RlMvQTI2L3J2L2RabHZMV1l5dVBOQmpITFpabjdI?=
 =?utf-8?B?OTlRVWQ0UmY3ejZrektSM1VqYUxqZVJSTWpPY2JndGs0b0U0eTROeTBnbURV?=
 =?utf-8?B?bklsNWJOREszRE5LaGtOUExIRWx5WXVNcmlZSGdqZlgyOFpZR1ZwVHRKV2VX?=
 =?utf-8?B?UmlkQjFlZTZwSFpVOWEraWpxRDIxNjlsVzQ0RTYwKy9tOGtYSjV1OVIwZ3hJ?=
 =?utf-8?B?eHBpTEhPQWhVZEwxdlRLVGpMRVpsbGduQVEwODJNd2pPbGNnNnlPaWkycDRo?=
 =?utf-8?B?V3FLRXdFcDNlbzEyck5zQ2hyZ1Z5NUdYNU5pSDdod1VKMFNQVUthNUovdWdl?=
 =?utf-8?B?RmxZZnF1QmtvcktqYzd1Sno5QUlGQ2F2Y1hKODF5M090U216UklybGpOYmFx?=
 =?utf-8?B?Z0xQekU1c3ZaNFlGQXVmZ2F6U1JPWEw5QUVRbm9MUStYZzNyQ01QV2pOejB2?=
 =?utf-8?B?c3pZalR5M29xVnBkMUF0YTRRR25CTnlzNkZpb0hSSkZ5TkdNT2NDR1htakl3?=
 =?utf-8?B?aG5OcmVUcnNtU3N4Tm5XSi8yUTZtc0tCa2ZNeW9xQmpiTytYT1N5bU1Ha05y?=
 =?utf-8?B?WWJ2U2lCVENhcnk2QU0vSjlrZkxWSEMwMklvaWNsMnJWWWNEa0MwMm0yZWRC?=
 =?utf-8?B?TlpPU0ZGUEdNRzhFSmkwVGlQbjVrTURySUFCc2NyWUlQTmVXWTJ0YWFXeFk1?=
 =?utf-8?B?WTFMU3BXWDBBZ0o0Z2VYT21kdkpLMmFnUmpNcDBxRjVIRjVZTmZuWVd1bFZU?=
 =?utf-8?B?TUdYbVBOOTgwTXBManZVVzM2bmx1UjQ4YTFVczRTcHJpb2N0VGVpTjNNT0Zo?=
 =?utf-8?B?d3FWVTVVUWJIQkM3TkFZNEs3NmpITk1wRjVITVVFb05sd3Y3OWxXTGF4TFQ4?=
 =?utf-8?B?UnRndDZGS2d3RXFjT3Z4eGo1UmcwUVQyNXhrLy84elM5NGFWTnBJWlVqcmhH?=
 =?utf-8?B?dWtmQ0liSnJlejdDZ1hQbXVVa2lDYkZneGxSTDhKWmR2OWZUK2tWL2hGUCtE?=
 =?utf-8?B?TWJlUGRSWmRBNVZaMnFHY0lJdHplVmkxRWw1Z0xEYTZXb1VYcWdqNy9Bblpj?=
 =?utf-8?B?QVpwTUUrNVAydFVCZm1xZzVBRFdWMFdUMVN4NHFJcWNQSVFFUG5JVVpkRnVL?=
 =?utf-8?B?V2lOdyszYmlPVjBrRzhmL3o2YmhBTTJGYTNURFpsWEZmdXRtM1c5NUhRblpu?=
 =?utf-8?B?aCtCV0preWlwV2QxRlBab2RnUFJHb1hlQW5wSUxIb1BPWVFqbjlxc1RCaFNt?=
 =?utf-8?B?cXdnanZyanYyS1B6Tzl5c2wzT0trKzFtTjdNaTJCdjZLY2xhVVdBb1lGZHZk?=
 =?utf-8?B?bFNWQXVZSHVPTkZLNTk5bEk0TnFKZ3oyZ1ZsNG1MTzl2Q2dJV0ZETEwrZ1V1?=
 =?utf-8?B?SXB4T2M0RUUyTjBXMXV1T0kraGw5SVppcysrbEdDa3dkcWF3Q0FxSUxpOWtw?=
 =?utf-8?Q?2cy7wUDbLUpdgd4vT89KGvY=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <27B39F3EA58C5E40955E9C5CA65BCA55@FRAP264.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: csgroup.eu
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ab642ab-d5a9-48ab-8ef2-08da63cb6b2f
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jul 2022 05:57:35.3667
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9914def7-b676-4fda-8815-5d49fb3b45c8
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KER9KVv0iVcFPr2oHu59VbdZHXb70hwSIgkP218MLSX5Qwin8L6c39zV2HTkCZdo7oNYR2bJe0oNAH9U1M99Jxl15Ag5bp0TiG7cSDWnqOg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MR1P264MB4195
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCkxlIDExLzA3LzIwMjIgw6AgMjE6MDcsIEx1aXMgQ2hhbWJlcmxhaW4gYSDDqWNyaXTCoDoN
Cj4gT24gTW9uLCBKdWwgMTEsIDIwMjIgYXQgMDY6MzM6MDhQTSArMDAwMCwgQ2hyaXN0b3BoZSBM
ZXJveSB3cm90ZToNCj4+DQo+Pg0KPj4gTGUgMTEvMDcvMjAyMiDDoCAxODoyMCwgTHVpcyBDaGFt
YmVybGFpbiBhIMOpY3JpdMKgOg0KPj4+IFRoaXMgbW92ZXMgYWxsIHRoZSBtb2R1bGUgc3ltYm9s
cyBmcm9tIGluaXQvS2NvbmZpZyB0byBpdHMNCj4+PiBvd24gZGVkaWNhdGVkIGZpbGUgbm93IHRo
YXQgd2UgaGF2ZSBhbGwgb2YgdGhlIG1vZHVsZSBjb2RlIGluDQo+Pj4gaXRzIG93biBkaXJlY3Rv
cnkuDQo+Pj4NCj4+PiBUaGlzIGRvZXMgbm90IGludHJvZHVjZSBhbnkgZnVuY3Rpb25hbCBjaGFu
Z2VzLg0KPj4+DQo+Pj4gU2lnbmVkLW9mZi1ieTogTHVpcyBDaGFtYmVybGFpbiA8bWNncm9mQGtl
cm5lbC5vcmc+DQo+Pg0KPj4gSXQgaXMgc2ltaWxhciB0byB0aGUgcGF0Y2ggSSBzZW50IGluIEZl
YnJ1YXJ5LCBpc24ndCBpdCA/DQo+PiAoaHR0cHM6Ly9wYXRjaHdvcmsua2VybmVsLm9yZy9wcm9q
ZWN0L2xpbnV4LW1vZHVsZXMvcGF0Y2gvNDA0MjcxMjk2MWQ0MjE4NmM0NDk3MzRjMjUzNTExZWE3
MDc2Yzc4MC4xNjQ1NTQzMTA1LmdpdC5jaHJpc3RvcGhlLmxlcm95QGNzZ3JvdXAuZXUvKQ0KPiAN
Cj4gU29ycnksIEkgaGFkIG1pc3NlZCB0aGF0LiBDYW4geW91IHNlbmQgYSBuZXcgdjIgYmFzZWQg
b24gdG9kYXkncw0KPiBtb2R1bGVzLW5leHQ/IEFuZCBJJ2xsIGp1c3QgZHJvcCBteSBwYXRjaD8N
Cj4gDQoNCkkgc2VudCBvdXQgdjIgcmViYXNlZCBvbiB0b2RheSdzIG1vZHVsZXMtbmV4dCANCihj
NzY2NTRlMjJkYTFlMGNiODMwYmQwZWI1ODMyMDcyZmI3NmRmMzU4KQ0KDQpJIHNlZSBhbGwgbXkg
cGF0Y2hlcyBzdGlsbCBoYXZlIHN0YXR1cyAnbmV3JyBpbiBtb2R1bGVzJ3MgcGF0Y2h3b3JrIA0K
KGh0dHBzOi8vcGF0Y2h3b3JrLmtlcm5lbC5vcmcvcHJvamVjdC9saW51eC1tb2R1bGVzL2xpc3Qv
P3N1Ym1pdHRlcj0xOTIzNjMpLg0KDQpEb24ndCB5b3UgbWFpbnRhaW4gaXQgPw0KDQpUaGFua3MN
CkNocmlzdG9waGU=
