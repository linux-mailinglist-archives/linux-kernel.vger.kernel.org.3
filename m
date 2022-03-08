Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82B8A4D1E51
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 18:15:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348705AbiCHRQn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 12:16:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344409AbiCHRQg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 12:16:36 -0500
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2041.outbound.protection.outlook.com [40.107.244.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90D9A52E0B
        for <linux-kernel@vger.kernel.org>; Tue,  8 Mar 2022 09:15:38 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Eoqs97/ey/WgymX9lfo6sE4ldk9FEy7FCvpTj6h56hC3czd8UlPLkvavDRZOM324Ap9Cy1rMaX3kdaSaOIpQtT6yrQ51FFtyQIuFGp23QYVJ/QiYoKEDjau2qyVDfI53FCti3OHKnIeFL6dXRjqMkQL5crT631ThX0DBGtZrHu8nSDFhRIYIWTNM0pHLdTu0CqUPiiP4QHGr5agZBRNpzM8i262X9vTFW2wcE90ZjUd/Z+PNMWaRLB6Ho4Ql+AXbfBfSIcgXrw3plHFtYfJDTmvyKRG34gRj10+6+dest69JaWRgwAHU1DgsnvQNw8nZwrKG8lNorYswvy8TEeEc0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yYK//rvoZx6EhrmEov28vVH5TqciWjcoouKjytmw4xw=;
 b=IBIwsMAH62UF0q5phZPAfMTyqanUijCkyD26LnHTy60Z9B/LF158APRNx2ZRYsqza1zUH3E0g11epcJvrtcx2vK4ccilNxEsBHvRF7D+/QFikw1zcmTIJTpXCkAdxOA1Ye35YqXqumBi5lGJHYLDv5/kHDq+HLli0wogZEx1+kGQ5SxlIm0GATpHTyzeXVscC8kkNdmvH164DqUBWP9GSJPkqpXD3FASWAIBuEfDItbhhB76sx7wlEpLPPKSJP8KC+ad/G7byAEh7zhns4qYaKUZUopvQ/lE4IMSrvdX4FkBDRECGhqJNcNdqQ5cbL4pE0Y0Ao6Rlyxk0smeTxuvVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vmware.com; dmarc=pass action=none header.from=vmware.com;
 dkim=pass header.d=vmware.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yYK//rvoZx6EhrmEov28vVH5TqciWjcoouKjytmw4xw=;
 b=aBfmEA7K4XOPl0oOdXrmGLHnLElOFua2kCrL0gZmD5jufYmwclpaNLlBa6HTmSYPD5g9x9g3QDBB+7lHASjS5jZlGkAop3QETZWnyOk33LSUlISDcsl/l5NcRLG3ccTaj1+abHb52tTwth361qhJ7KtBhTV8usscNsxCovBPu64=
Received: from BY3PR05MB8531.namprd05.prod.outlook.com (2603:10b6:a03:3ce::6)
 by BL0PR05MB6627.namprd05.prod.outlook.com (2603:10b6:208:92::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.10; Tue, 8 Mar
 2022 17:15:36 +0000
Received: from BY3PR05MB8531.namprd05.prod.outlook.com
 ([fe80::7856:d027:55:4db6]) by BY3PR05MB8531.namprd05.prod.outlook.com
 ([fe80::7856:d027:55:4db6%2]) with mapi id 15.20.5061.018; Tue, 8 Mar 2022
 17:15:36 +0000
From:   Nadav Amit <namit@vmware.com>
To:     David Hildenbrand <david@redhat.com>
CC:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        David Rientjes <rientjes@google.com>,
        Shakeel Butt <shakeelb@google.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Yang Shi <shy828301@gmail.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
        Michal Hocko <mhocko@kernel.org>,
        Rik van Riel <riel@surriel.com>,
        Roman Gushchin <guro@fb.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Peter Xu <peterx@redhat.com>,
        Donald Dutile <ddutile@redhat.com>,
        Christoph Hellwig <hch@lst.de>,
        Oleg Nesterov <oleg@redhat.com>, Jan Kara <jack@suse.cz>,
        Liang Zhang <zhangliang5@huawei.com>,
        Pedro Gomes <pedrodemargomes@gmail.com>,
        Oded Gabbay <oded.gabbay@gmail.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>
Subject: Re: [PATCH v1 05/15] mm/rmap: convert RMAP flags to a proper distinct
 rmap_t type
Thread-Topic: [PATCH v1 05/15] mm/rmap: convert RMAP flags to a proper
 distinct rmap_t type
Thread-Index: AQHYMvdPNK2hKChpFkCilWEFljuBd6y1ulCA
Date:   Tue, 8 Mar 2022 17:15:36 +0000
Message-ID: <D7AB3A84-3FFB-4E8D-9E68-BF721CC4C6FC@vmware.com>
References: <20220308141437.144919-1-david@redhat.com>
 <20220308141437.144919-6-david@redhat.com>
In-Reply-To: <20220308141437.144919-6-david@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3693.60.0.1.1)
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vmware.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c40bcfd2-4b2f-497c-ee21-08da01274323
x-ms-traffictypediagnostic: BL0PR05MB6627:EE_
x-ms-exchange-atpmessageproperties: SA|SL
x-microsoft-antispam-prvs: <BL0PR05MB6627980ACED09E425593F6AED0099@BL0PR05MB6627.namprd05.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 5N/iYX4TXDhqHaW70AMv8h67vvy54+/nja01Mrgcj8lF2iP86gCtRCIb69VQkqAHMHPUptHZYOYKzulohn5cVj4+fyqZuMkroRU6H5IZ7Q2VdaECwr4c/l+r0JSZl5GM0d8n3NfCV0MBrLbQjtt5FUdQvDrrIvIcDzU7PkG3oIn4XbZNwHYBpIOY53MGGLdQZGOUSJ4lCwxq8kxkHNpHpBgjbWPWXN9QzvishWZaCk0gUtc5FvcTn5YuNT4X2AQXHa5DZ0tE7IkotAL/HLG+eih6G4m3z50Ih1BYaJUldGgAWbfXTGFLhSh0EVDz2G9LV1+Eq20EEFngKkt6UbjR/wTPQrmNnlzovxNh8ejg/PLU97JhvdVMIKRCOo25OvrKF/sIcyI/9+qVLxOnUo+6bGxbvJPymd15oKslSvKbfZL4aqnZwpIVmRnjn1L4P4h3rGpyADjBPBHsgWaDOD+HFBBmveWsSJcOVdXi0+fiam4ok6dRfx2N2h/iWDG8K2YDTDpiMyVN0SwcBzXXG1DtpzFaWkOYXbP1y1wlSeWRKKR66v4x+IRPw21OGDJhEJL7BG7jDVLUFtcJUtXB62aI8Bn8YUq1tXKTz/e7wwn3vAeOFd/bOWYSX+3rJ/fppvs9cpJ7o5aAJ8aeBt8geuDeV5fzByXHKmdfL72vfBxw8iKqU2j3M4zXwtbUm6dr9nmrtCIVqd6i74kzd2CDBJZkP2Tk3GFttmP9muffckdPTMiepsduUCoPrDF3K0p8wQ+M
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY3PR05MB8531.namprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(54906003)(6916009)(64756008)(66446008)(66476007)(66556008)(66946007)(76116006)(71200400001)(6486002)(316002)(33656002)(508600001)(122000001)(83380400001)(2906002)(36756003)(2616005)(26005)(186003)(38070700005)(38100700002)(53546011)(86362001)(5660300002)(4326008)(8676002)(6506007)(6512007)(7416002)(8936002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Z0UzOU1hRnFSSGZ1RVljOGNGL1U4Q2JQQ1ljY3pncHBCMURmSFdnVDl6NC9j?=
 =?utf-8?B?N0FpSlVPbkxhVnlaRTlMMW9Wb1QydW9ybWNMZFpLanN2QkMvbXFHSmh1aWVs?=
 =?utf-8?B?L0JwKzhYM0FRcUZWaDFXZkllZE1ZYWRKL0JERWg0T2hrTmQzTmZBb21YeWY0?=
 =?utf-8?B?M2FtdlA2dllndUJvSUZmOGRtdFY2UVFpWWRzQ3pwbmlaK0xyZnNGSk8rNGdT?=
 =?utf-8?B?Vy9ka052V1ROSDNWU1RhcGFHWlhYaElXT3FnUVg2dW9qcDB2aXRUVitQdjVI?=
 =?utf-8?B?VldtRjVZSkw4cmlYVGhMdS9BMjhtbzh1bC96aUoveUdnMFk3WWEyMlkxTnZH?=
 =?utf-8?B?clU2WSt1UGhLbW51NHlHYU1yVDdhRkNHOXYvMk56VVpVQlgxWTluSWxzenRU?=
 =?utf-8?B?MVJGN3RKODBqQUMyR2l2cXRqM2tIaDQvelVBOFBQMUhRcFRtZGxNZkh4WGM5?=
 =?utf-8?B?blloVGZwM0V6RmRaaVlsMXRlUXUxSStWNU01Q2FtVHU4d3BQVzNRMUtFcXlz?=
 =?utf-8?B?NUQ0NjNDVWFodTJxR1R5ZERTcFJxSHBRY1dkZ3ppYk9rT1NtdmxUNkZ4d3px?=
 =?utf-8?B?N3dVcXhRZGFzR0gvdUFZODZGQVRFY2xvUUlqdmtaRHBsQVB5ZmplSFMxQ2I1?=
 =?utf-8?B?bExWc3BKYWtJVVE0elAxNk9HVlZFcmkzSEZwZWR1NGs2aDZQVm8zc0pxMUdy?=
 =?utf-8?B?WXhQVVRJdlc0cTFFdWtOTG1SU2Fsb0RkNEM5M002QkVHMWlKUVFyR1Jnd0ZV?=
 =?utf-8?B?eGZuejJSTDFnL2hkc2szNEJISS9rTVNVSFlSU3lZWXIxdzFyTUo3N0lnaXRu?=
 =?utf-8?B?aGZQZXY2RnlLSDdzVTRuQWF0S2R0U1ZPT0NDc0NSNTNTSmU5dFhFN2JpZ0Y0?=
 =?utf-8?B?emd1TmlQdlV3NDdCZDNOeEdGL3d2R1JZZklCUDVXOTJlTWVNNHdiT1YvaFZt?=
 =?utf-8?B?VGQ2UTF1aFkwSXZVMUwxMDgxRk4rZ0lPS3o4eGdiMmg5M285My9CNFQrQ2sy?=
 =?utf-8?B?MkoyWmVITUZVbWM1NG1hUXVCV1VBOVlkVlcvb3FwZjlPaDFCelBCdkErU05v?=
 =?utf-8?B?NzNsZHJGay9hSGxFLy9QcEJOMHpIM3d6Z2RTMGtMMEZ6bEVtdUplSmxYQTQx?=
 =?utf-8?B?dTVSaXhBaWREeHd3cFVJelV1SkloTENxK0xTY0grdXhhYys5ODNObE1UTUkz?=
 =?utf-8?B?cmY0Yjc1RzFPNzB3MTh6Q1lOSng2WFZ4eDVOYkd1TVkzVWxyNlZBN2EvaGd6?=
 =?utf-8?B?bERSdmxaZUp6d2Z1N2xmWUZMNzRsejVYc1hTR0JGR0FGWkpDRXowVUZ6Y1oz?=
 =?utf-8?B?SjdTNVlTOTdHTFQydmtFdjd0dFhBWTB3UkRHWmhTY25mdGMycEVKZEJxeUxX?=
 =?utf-8?B?cmZPMEk2VThLVGl4SmYxTEFGQzhiRnc4Yy9BeUc1dU0rSVZhYWVOeTU1NnBN?=
 =?utf-8?B?SEMxaGpzNWEwaExWYmI3NEJyZndRWUhaSjN1cG1NZjMra21YazhtUGJvZnZJ?=
 =?utf-8?B?WUx2dzlQMWxQL3FKbTdXdElNS0p5SWxoMG9KNFA4aDRXZ3NpQlZ0L0pubUpy?=
 =?utf-8?B?UFl1UTFUMEZTODV0bHpjOGpBZCtKeXhQOVN2bmlIeFBBdEFpTmkyQUQ2MWE3?=
 =?utf-8?B?S3pFV1kzTS9QOFA1NkhTc2tzWnRpVm5udU9qQkpEK3pmMzZ6Q0l0UWh3V3RI?=
 =?utf-8?B?cTVkRm1pSW5FMVRKSXJzdkQyVEVkSGRHTlZickJBS3ErKzRKSmNzSmIzL3Bu?=
 =?utf-8?B?VHB6NXpSVFBLZnIwTDRqbDZ1UlBpWHdidGRBRGV6eFhUTjJmVFpuMjFjQlJK?=
 =?utf-8?B?OWd3dkxkSmlvdmFIc2NLQUNxSytvdm12M0diUVhsT0Y4eVFwWmN4czY3SkdU?=
 =?utf-8?B?THhBR3BzOWpuZURDQzZBdS9rOGdFcTMxdDRQeHgwRWxRR0ZucWZCT1lRRjQz?=
 =?utf-8?Q?06p7H0xOzGAnq63Mw41W3P7jJqSzNRBe?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <5F6A6871CF041F449ACA1F240DE33D65@namprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY3PR05MB8531.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c40bcfd2-4b2f-497c-ee21-08da01274323
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2022 17:15:36.6408
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: P+8E06mpO7cFyJGJwAh9vfNq25kus99NEXlMGAhH8+dmRrE6+5ek87xhBA0ecPqGivXwhgbpkOCWjVipuz+5EA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR05MB6627
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gT24gTWFyIDgsIDIwMjIsIGF0IDY6MTQgQU0sIERhdmlkIEhpbGRlbmJyYW5kIDxkYXZp
ZEByZWRoYXQuY29tPiB3cm90ZToNCj4gDQo+IFdlIHdhbnQgdG8gcGFzcyB0aGUgZmxhZ3MgdG8g
bW9yZSB0aGFuIG9uZSBhbm9uIHJtYXAgZnVuY3Rpb24sIGdldHRpbmcNCj4gcmlkIG9mIHNwZWNp
YWwgImRvX3BhZ2VfYWRkX2Fub25fcm1hcCgpIi4gU28gbGV0J3MgcGFzcyBhcm91bmQgYSBkaXN0
aW5jdA0KPiBfX2JpdHdpc2UgdHlwZSBhbmQgcmVmaW5lIGRvY3VtZW50YXRpb24uDQo+IA0KPiBT
aWduZWQtb2ZmLWJ5OiBEYXZpZCBIaWxkZW5icmFuZCA8ZGF2aWRAcmVkaGF0LmNvbT4NCj4gLS0t
DQo+IGluY2x1ZGUvbGludXgvcm1hcC5oIHwgMjIgKysrKysrKysrKysrKysrKysrLS0tLQ0KPiBt
bS9tZW1vcnkuYyAgICAgICAgICB8ICA2ICsrKy0tLQ0KPiBtbS9ybWFwLmMgICAgICAgICAgICB8
ICA3ICsrKystLS0NCj4gMyBmaWxlcyBjaGFuZ2VkLCAyNSBpbnNlcnRpb25zKCspLCAxMCBkZWxl
dGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9pbmNsdWRlL2xpbnV4L3JtYXAuaCBiL2luY2x1
ZGUvbGludXgvcm1hcC5oDQo+IGluZGV4IDkyYzM1ODViOGM2YS4uNDlmNmIyMDg5MzhjIDEwMDY0
NA0KPiAtLS0gYS9pbmNsdWRlL2xpbnV4L3JtYXAuaA0KPiArKysgYi9pbmNsdWRlL2xpbnV4L3Jt
YXAuaA0KPiBAQCAtMTU4LDkgKzE1OCwyMyBAQCBzdGF0aWMgaW5saW5lIHZvaWQgYW5vbl92bWFf
bWVyZ2Uoc3RydWN0IHZtX2FyZWFfc3RydWN0ICp2bWEsDQo+IA0KPiBzdHJ1Y3QgYW5vbl92bWEg
KnBhZ2VfZ2V0X2Fub25fdm1hKHN0cnVjdCBwYWdlICpwYWdlKTsNCj4gDQo+IC0vKiBiaXRmbGFn
cyBmb3IgZG9fcGFnZV9hZGRfYW5vbl9ybWFwKCkgKi8NCj4gLSNkZWZpbmUgUk1BUF9FWENMVVNJ
VkUgMHgwMQ0KPiAtI2RlZmluZSBSTUFQX0NPTVBPVU5EIDB4MDINCj4gKy8qIFJNQVAgZmxhZ3Ms
IGN1cnJlbnRseSBvbmx5IHJlbGV2YW50IGZvciBzb21lIGFub24gcm1hcCBvcGVyYXRpb25zLiAq
Lw0KPiArdHlwZWRlZiBpbnQgX19iaXR3aXNlIHJtYXBfdDsNCj4gKw0KPiArLyoNCj4gKyAqIE5v
IHNwZWNpYWwgcmVxdWVzdDogaWYgdGhlIHBhZ2UgaXMgYSBzdWJwYWdlIG9mIGEgY29tcG91bmQg
cGFnZSwgaXQgaXMNCj4gKyAqIG1hcHBlZCB2aWEgYSBQVEUuIFRoZSBtYXBwZWQgKHN1YilwYWdl
IGlzIHBvc3NpYmx5IHNoYXJlZCBiZXR3ZWVuIHByb2Nlc3Nlcy4NCj4gKyAqLw0KPiArI2RlZmlu
ZSBSTUFQX05PTkUJCSgoX19mb3JjZSBybWFwX3QpMCkNCj4gKw0KPiArLyogVGhlIChzdWIpcGFn
ZSBpcyBleGNsdXNpdmUgdG8gYSBzaW5nbGUgcHJvY2Vzcy4gKi8NCj4gKyNkZWZpbmUgUk1BUF9F
WENMVVNJVkUJCSgoX19mb3JjZSBybWFwX3QpQklUKDApKQ0KPiArDQo+ICsvKg0KPiArICogVGhl
IGNvbXBvdW5kIHBhZ2UgaXMgbm90IG1hcHBlZCB2aWEgUFRFcywgYnV0IGluc3RlYWQgdmlhIGEg
c2luZ2xlIFBNRCBhbmQNCj4gKyAqIHNob3VsZCBiZSBhY2NvdW50ZWQgYWNjb3JkaW5nbHkuDQo+
ICsgKi8NCj4gKyNkZWZpbmUgUk1BUF9DT01QT1VORAkJKChfX2ZvcmNlIHJtYXBfdClCSVQoMSkp
DQoNCkkgd2FzIG9uY2Ugc2hvdXRlZCBhdCBmb3IgYSBzaW1pbGFyIHN1Z2dlc3Rpb24sIGJ1dCBJ
IGFtIGdvaW5nIHRvIHRyeQ0Kb25jZSBtb3Jl4oCmIElmIHlvdSBhbHJlYWR5IGRlZmluZSBhIG5l
dyB0eXBlLCB3aHkgbm90IHRvIHVzZSBiaXRmaWVsZHM/DQoNCkl0IHdvdWxkIGJlIG11Y2ggZWFz
aWVyIHRvIHJlYWQuIFRoZSBsYXN0IHRpbWUgSSBtYWRlIHN1Y2ggYSBzdWdnZXN0aW9uLA0KSW5n
byBzYWlkICJJIHBlcnNvbmFsbHkgbGlrZSBiaXRmaWVsZHMgaW4gdGhlb3J5IOKApiBbYnV0XSBv
bGRlciB2ZXJzaW9ucyBvZg0KR0NDIGRpZCBhIHJlYWxseSBwb29yIGpvYiBvZiBvcHRpbWl6aW5n
IHRoZW0u4oCdIEF0IHRoZSB0aW1lICgyMDE0KSwgSSBsb29rZWQNCmF0IEdDQy00LjQgYW5kIEdD
Qy00LjggYW5kIHRoZXJlIHdlcmUgc29tZSBkaWZmZXJlbmNlcyBpbiB0aGUgcXVhbGl0eSBvZg0K
dGhlIGdlbmVyYXRlZCBjb2RlLiBJcyBpdCBzdGlsbCB0aGUgY2FzZT8NCg0K
