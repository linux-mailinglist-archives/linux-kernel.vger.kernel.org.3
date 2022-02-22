Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACCD24BFFE8
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 18:15:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234570AbiBVRPY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 12:15:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231236AbiBVRPW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 12:15:22 -0500
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2057.outbound.protection.outlook.com [40.107.223.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1354108568;
        Tue, 22 Feb 2022 09:14:56 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K0mWR0YYWm3t+ILz0QLdbHdkc5Yc0HsQmDuAkaNQ0y7yBCgT2GJ0kX/MWy+PRtR9CdaWPaeMjwvuqUlZNzHonZUnn/0wd2QpuQaCgHTDR5n1wdKB+OjPptSe6IU9Unkgsqxu2lT7hcG3fjqjL3qflVPihUbuOEeiw6hQWwYGVnhdojv5kldbV9PlY3kAT7QBIX4m6B2bEByT/wgHpeyPKlVw8VThoU7o1Y//dmTOh8tvQKwbv8JM5FL4vTEEbaDktATr5KRtByXy6d9VnP+UuxFqpSISy7d0gCmY/L/caknENEHWiMfMwTnPG1AaBwVTjp9vX1eBK1EYCwBhVtJuzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+mdjuYu52ojCU6QKUV+g/QoGg4f+DeGAmWEiBuAJhfY=;
 b=hcl6Su0QXEmpuqGdm8/FPGesIo/3+YnKOxK9m7bKm7jjxwCc4mu653TF6i8iGcUb+mP1/5IiS+F/jNeERoi46/HjdVlnStMW/NCsRk4SmJVlK1ZryP7ZFMceuhKOwYMhmyyMpJjTRroLreTh773wtVdo/jePlIkbEdvKJGoUCv1SKIqMApSKAflZm/yVdbUPoTlz4aAYfWrjeqH6mm0WyBd4EjWG3F0bX3hF1djP0xaMaHvvnqvelyW64kOv+aV9xmyVb89+k2waX2ORIrC7IZqjGn3/9PlkpR9XR5rMPYJviimKuUjcUELHbDxeq5/87686gcG6Rmq4rZbGn+3yTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+mdjuYu52ojCU6QKUV+g/QoGg4f+DeGAmWEiBuAJhfY=;
 b=jYgKQUHXXQ31WUDTqm6kFUC2AGFYVTEzZweRNg4bHOxEgPYkpemt+BjZ5c0g6g3f1nN25Bc8enbu8HoOMMxADcm8hOjskrf0rLanb3jUUrdOEKkZqaJmGXSqsfvmvcY75DCUiF8/DG9EI9n5f4YI+ld25etnCUwXvmbdxbktSKt8cKvHn9RSTAn7+sgmm5+Osu3h03kWH/wUOgMGs8hNMwGETnTvh6cFk9va0UhYKPlRzHVsfyj3AcjRENljVK+6XuCvCt+xJeNDHxUCdX9fwM9M/bhSAOWCAzkwVkWhlHSs9s9yPx1fjW25Vazx6oLHm0ZEVEdJNmQwlFBs7THdgw==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by BN8PR12MB4626.namprd12.prod.outlook.com (2603:10b6:408:72::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.21; Tue, 22 Feb
 2022 17:14:54 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::204b:bbcb:d388:64a2]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::204b:bbcb:d388:64a2%4]) with mapi id 15.20.4995.027; Tue, 22 Feb 2022
 17:14:54 +0000
From:   Chaitanya Kulkarni <chaitanyak@nvidia.com>
To:     Christoph Hellwig <hch@lst.de>, Joe Perches <joe@perches.com>
CC:     Keith Busch <kbusch@kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        "colyli@suse.de" <colyli@suse.de>,
        Bart Van Assche <bvanassche@acm.org>
Subject: Re: [PATCHv3 04/10] linux/kernel: introduce lower_48_bits macro
Thread-Topic: [PATCHv3 04/10] linux/kernel: introduce lower_48_bits macro
Thread-Index: AQHYKAnT3qhQXFzrb0qMggW0v7q9UKyfyKidgAAGrwA=
Date:   Tue, 22 Feb 2022 17:14:54 +0000
Message-ID: <5fa37a9c-d190-6af3-beaa-e8b50f11bc16@nvidia.com>
References: <20220222163144.1782447-1-kbusch@kernel.org>
 <20220222163144.1782447-5-kbusch@kernel.org>
 <66a0c8210cf9e7dfcc3fa2d247de1eebd5a8acb7.camel@perches.com>
 <20220222165045.GA14168@lst.de>
In-Reply-To: <20220222165045.GA14168@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: fc9aef3f-3eb8-4e42-b92b-08d9f626d845
x-ms-traffictypediagnostic: BN8PR12MB4626:EE_
x-microsoft-antispam-prvs: <BN8PR12MB462674C653A29391EEB5F5F3A33B9@BN8PR12MB4626.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ob0LSz8PbEYdHRVjqbJAw7Jon5sLnKvM2B+v5+6EsmXoN04o5mVqC3DIj1Aw0cihJmBcQxRF15usobMdl5lZFKp0Nrp0QHpYlVfcPJy/XTuCfoqptQnBTBSlG6jN8ZGHe73LnmxVtKFBVZNwC2QgKZl6gLwBYAAHvfUlcZse1pJb46oo0FTOTQ7ZAfP17GXrk0S1JQy7HcM26zwm7nAjOs9hrP+iGsrRZ/CeW9xkDshIikNYDzGxx3aoLsZeIL3mqZNs/n45vU6Ean7w4+nqKb4kewz7AlAvidx2syiRCamU9eK2HGgK5Co9e5ccbabOpe8WHAWH2chCewdglkn6JcNs/RBeWSNwrMtyTDUNEhFndOYhc5ECObpEgT4Q/Eqy5Mnq+vKRG2C6LrVKWt9NxqqdeWUVXP7kvVhQ69X2DsshNsQ+0QVqgfRUv1rwDVu7wl/IIH43368OqlT06oS/xNqcJTJtuXoSHpSZp88SzB2D+XF/HSy+JEL/VJd5rFcKvPVsXpntQ/NMpA6o8QfbviCTR51bcWN+wiLwd6jKt4F7GCOicu2KrZR1jVMAuWOeTXCGGpntUcux48riFjXsAjWI3JzHDZxD6Mz2j68OYBnmLXDov6In2sKaEHrVMRfalS6nTp3yBGRjeZSN23j7xyFdbQrE36xpjXDXLwuTg2pwNtXNPxjEm0k8BtM7HfrEVHAWI7GLZnoXbkMvgfni+bfx7Qn04R2MdhQKvuaqNGXZwcP0EQfzbe8wcf+AKQdGtCGzjrmrtsY3klDz0bGM1Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(186003)(71200400001)(91956017)(31696002)(4326008)(8676002)(2906002)(36756003)(2616005)(76116006)(5660300002)(86362001)(316002)(122000001)(31686004)(6486002)(110136005)(8936002)(53546011)(7416002)(66476007)(66446008)(38070700005)(64756008)(66556008)(66946007)(38100700002)(6512007)(6506007)(83380400001)(4744005)(508600001)(54906003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?U0lkaHFtbEtwR0pReGNYU2lPa1pnY1Jqb0NhQjRNM1EyMkRUNzRyaFA3MTEw?=
 =?utf-8?B?bjlMdnRGbitPTVVsdGhaaHpESGtVbjEvZFVsREpDbjlodFZsUStOQjV2aHBL?=
 =?utf-8?B?RGNEQ0xiSjRmMlVxelZNdXcwZ3pRaFhIcEFlbFVSMDM0WFgvUmt2TUh1VEdk?=
 =?utf-8?B?NGhMY3JGN2liam9rTWlTREd1Zm1VcG8wa2d0YnpSRm0zN1QzWE9qVXJtdmZa?=
 =?utf-8?B?SU9rbmNJWTIybTQ3elZYbkpSY3R2NlUyNXIvcTVlRGJFSlAxZisrVGFDQ1JS?=
 =?utf-8?B?OGt3Y1JheWFHOVVxTlRMRVBkbFBoeDNYNG5oakt3UDB0bUorNVAxWVowMHk1?=
 =?utf-8?B?MG5RZVhJMDJUMEZhUDMvL2o1S2hLL00wRW5hM3BjWkJEdzJTNTZyT1AxNno1?=
 =?utf-8?B?VlZsSjlwb2piYU9LUVcvZWVqWGtWTlFNYnUzVVlSaWhUT3FaMTU4djR1M0dC?=
 =?utf-8?B?MlRELzRwN2FVOVJBRzBzTjNYcnBldi9iRUFRdGMrSFZOOEdiYjVscTlzeUor?=
 =?utf-8?B?b3VpN1VSZjNtUmZ2T0RJa3N1d2Mrb1E5UnNPZmEvdVJtRUJ4Q2tQanJCQmM3?=
 =?utf-8?B?cXQ0ckVsVE00aUw5VHhyTndwRVkvbzhIa1lzTFpaVCtNU1V6QnY5UVUwRjZt?=
 =?utf-8?B?anVVQWlvWXhIcm9iang2ZERxSU93MVJ5eitRVGU1ZHRqQklrUmxpRnB6Rkxu?=
 =?utf-8?B?a2g4amtCYytXL2w2OGJ2cmwveEtQSjZwT3FIUDFmSGhiYTBJVm11aHJscVdP?=
 =?utf-8?B?S3A4anBQcXNDekdDZWo3T1dDakxZNDJPQ0RpVGE4Um56M0tKb0Q3ZnZYcHJQ?=
 =?utf-8?B?Y1RWblVseW8rS0RIK2Y1MnBoMmFMak5wTWJyS0l1YTg4dnNleldScnhidkhp?=
 =?utf-8?B?ZFB2Y0F2d2JLb0hwUXg0TmF6TmRhYTltWjNPY0VCbDFWUG4vSVVGZ3RTU0Vs?=
 =?utf-8?B?WklOdzhFSGRXNldJZWNPRkVYSjgrU29NNVExVzJickI4dENCN2x4c0t3d1Vo?=
 =?utf-8?B?a041R2IxS1FxUE1ZRGtCeVE3Z3ZBUXZuV0JDaWR2cGYzUTVkbnhqeFd3cU0y?=
 =?utf-8?B?TEpsQ1FyQTlhU3ArK0tWSVhFQnpvR0ltaFdDWXoxS3JsbmthTUxVMllSN3JV?=
 =?utf-8?B?U0tUc3dYOG5RekJmbXVSczR1d2NyUkdsU1hDWll1UmMwaXY3UW5xSUdLdk5P?=
 =?utf-8?B?Q21GRmh2VVdzRWRXZzU4aVNhNVB4T29GdFdZeERCU0g0NDBjdFhBTXBqdnZr?=
 =?utf-8?B?WkZaVWR3dWVvVWxmbkdxcENsUXprVC8ydkJadk1OMy81MDZ0RW1YSlJDcVBB?=
 =?utf-8?B?ckpiN0xWYUtCN1ZMRjQ0Y1Z3TkdDQWlMaDNTUnVMSktxSzFCa1MvQWsvenBp?=
 =?utf-8?B?NngwRnkvV2hjUUVtT3dicVRjbCtlYkkyZ2RFSzAwU0FSaXpwTzdEa1B2R0py?=
 =?utf-8?B?L29RMjF0M3RxVG1xVGkzM2IycFlLNjRLakY3cXRuZmdTV1pkZ0xGK21jK2k3?=
 =?utf-8?B?QzM5L0hlamQ0V2VFNzhWUW1td0xNbWJCNktJRHJSZGxVcnhpamVRNnJwRHU5?=
 =?utf-8?B?TytXNzZWWE4yRGJBOGV3dG5oQWtZZ3RDd1kyWS9kNHhoQ1REclNYZklZMk1Z?=
 =?utf-8?B?OEI2aFRZM2VRWUt5RFdSc0RXcjNERVpKRUc4bFArUjU4L0FheS95YU5ZeGZD?=
 =?utf-8?B?bkZLSG4zUVErS1BsVjhEOHVQK1Yra0NRb1hwS0pqMVpZUnFlNTZvbXZiUVBY?=
 =?utf-8?B?M3pnT1JTQjNMMUhQVnlVdVZLdHFucTRHMmVkRUdpQnM5bzF3K0VrVHFQcjAx?=
 =?utf-8?B?K0drajhYUnhtSkFMSFFlZFJ4Rlo3aXBlUGpScFpJR1JZZ0N2R1ptelRkUlVR?=
 =?utf-8?B?R2JHQVBmTmNmcFMrdERtbGtmclRERjIrL05CMmNBM09zajJGTEc0cHFKbUZB?=
 =?utf-8?B?aFlIc0hWTWxvY2JkZjdpL2J0MWlUWW5NRnFtV1FqdmhJL0o3TDBQSjYrSnI1?=
 =?utf-8?B?OVlneUE4TGlUNmZMb1V3Ri9maUVWUVNmck90TFBZb0lvcmdhdVU2c2xvS1ZH?=
 =?utf-8?B?a1h6SjUrMFhLUkdLZTlNdzdMSm9UUXZVU3orN0laWlRQYlJKTEVKT3hRa2xl?=
 =?utf-8?B?R3dlSDdKeU1JeXhpcnBqRjAySkt2dmhkRFhleFVGbG9VMG1GZ0xiUzhFUi9M?=
 =?utf-8?B?VE9qTmRuZ2FxRHYzRlZwY1BRcXRleTdtaXplZk5ZZFdMTGhwMjZBdmxhM2pz?=
 =?utf-8?Q?2TLN2f0gGDDk1EKimC7FrHDxQn5dP2iSnngRwPdxVU=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F70453559A864442850EFD08CBD0FC93@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fc9aef3f-3eb8-4e42-b92b-08d9f626d845
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Feb 2022 17:14:54.6492
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qKBcDKP0Zx17xo341deLtBGLDANrCagGW5JMZh9zr6rESNR7EUoHEZ1cfS2JvCsPsAejNKQVqSIypgIGHiNm3w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB4626
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMi8yMi8yMiAwODo1MCwgQ2hyaXN0b3BoIEhlbGx3aWcgd3JvdGU6DQo+IE9uIFR1ZSwgRmVi
IDIyLCAyMDIyIGF0IDA4OjQ1OjUzQU0gLTA4MDAsIEpvZSBQZXJjaGVzIHdyb3RlOg0KPj4gT24g
VHVlLCAyMDIyLTAyLTIyIGF0IDA4OjMxIC0wODAwLCBLZWl0aCBCdXNjaCB3cm90ZToNCj4+PiBS
ZWNlbnQgZGF0YSBpbnRlZ3JpdHkgZmllbGQgZW5oYW5jZW1lbnRzIGFsbG93IDQ4LWJpdCByZWZl
cmVuY2UgdGFncy4NCj4+PiBJbnRyb2R1Y2UgYSBoZWxwZXIgbWFjcm8gc2luY2UgdGhpcyB3aWxs
IGJlIGEgcmVwZWF0ZWQgb3BlcmF0aW9uLg0KPj4gW10NCj4+PiBkaWZmIC0tZ2l0IGEvaW5jbHVk
ZS9saW51eC9rZXJuZWwuaCBiL2luY2x1ZGUvbGludXgva2VybmVsLmgNCj4+IFtdDQo+Pj4gQEAg
LTYzLDYgKzYzLDEyIEBADQo+Pj4gICB9CQkJCQlcDQo+Pj4gICApDQo+Pj4gICANCj4+PiArLyoq
DQo+Pj4gKyAqIGxvd2VyXzQ4X2JpdHMgLSByZXR1cm4gYml0cyAwLTQ3IG9mIGEgbnVtYmVyDQo+
Pj4gKyAqIEBuOiB0aGUgbnVtYmVyIHdlJ3JlIGFjY2Vzc2luZw0KPj4+ICsgKi8NCj4+PiArI2Rl
ZmluZSBsb3dlcl80OF9iaXRzKG4pICgodTY0KSgobikgJiAweGZmZmZmZmZmZmZmZnVsbCkpDQo+
Pg0KPj4gd2h5IG5vdCBtYWtlIHRoaXMgYSBzdGF0aWMgaW5saW5lIGZ1bmN0aW9uPw0KPiANCj4g
QWdyZWVkLg0KPiANCg0KDQpBbGwgdGhlIGJpdCBtYXNrZCBtYWNyb3MgaW4gdGhlIHNhbWUgZmls
ZSBuZWVkcyB0byBiZSBjb252ZXJ0ZWQgaW50bw0Kc3RhdGljIGlubGluZSB0byBoYXZlIHRoZSBy
aWdodCBkYXRhIHR5cGUsIGhvd2V2ZXIgdGhhdCBuZWVkcyB0byBiZQ0KZG9uZSBvbmNlIHRoaXMg
c2VyaWVzIGlzIGluLCBzaW5jZSBjbGVhcmx5IG9iamVjdGl2ZSBvZiB0aGlzIHNlcmllcw0KaXMg
ZGlmZmVyZW50IHRoYW4gY2xlYW51cCBvZiBpbmNsdWRlL2xpbnV4L2tlcm5lbC5oIGJpdCBtYWNy
b3MuDQoNCi1jaw0KDQoNCg==
