Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 607825806DB
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jul 2022 23:35:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236708AbiGYVfH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jul 2022 17:35:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237374AbiGYVey (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jul 2022 17:34:54 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10olkn2048.outbound.protection.outlook.com [40.92.40.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2E79B7E
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jul 2022 14:34:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JTMIa0FBRgqM+OZazkPwZ0KymmTdFS2pRzA/Ws4q8q/QaJ4g/UI9WMH3bX3L9Hz30u/eVnAwDZeB/ZMT5hF6S36IIjQS7dIDOFGZfF4Kyx1wDgKQJYvvOckXXt3KbXfPx7peNlFRzffCGndaQK0P3TUzNNAAnuknw6UYPF7dXILeWMP7cJHnka09RGk74pyKQ/s7VehfzIZjZ1XTtzejBVZIalrOXGLdb2hbQhhv8gRWWTcBXI6AzlrF4utov8EfEEmJMj+K0LHnkhGRTAAvJjtFG8Bog7QlxOjtVN0gKUFefRGRxW9M4DQFNWOmNbzjz0mndZCAPgWebfasIna0lg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u4CWww67eTFBc/sh0ULB4n/rbVfkkbdsro7qmlXd7fg=;
 b=MHL0Jxr9jrzWp4mTdVYTbAQoPnR+RFj2oaW42M3dyEMJZ87XjuKLmXgVZdaWfIMEhOw1+WITRwWV0wY+YNQcT0/kCWxo6N5yGLjZEsNQOARkxcnjuAdoThQ06HfEh/+A8g0rId+zSLyVDUShWsx5TxuuS/U8NOjadlbNC1wMQxq/1TcNDDMli5FHFbPQsOi7hwMMiIHPrmF1er94nEsawsYu/aIhW9/LmFHqFwokvIXYmV+oZhc9pnx/VDZbhbl4/6sz80rE/zh8o4c4urRjwOOgHq7mGKDGk1tGBB3srROCV02CP14uTcEwyZDj3q3FiCiTINs7Kb4FKUJ2eMBTmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u4CWww67eTFBc/sh0ULB4n/rbVfkkbdsro7qmlXd7fg=;
 b=MjDb0qjY6RRV/bU6sLqM0O/Vt+0yyRLZ3FsTUUPqhPI4i/uraLDXBSEXXqFoGZcjDnaIyhNu5GWUO3mkhihlgD5ruuA893qBFm7S7/2RN749jFvoWLUvThcs9iSInfVb+xEtK1IwlT1i9+rL3u6KyX+Zly4v4AMR5+HaoV3UntKy7riQDzTunGcbERKIwNof0dmLn6pjJ+UvXgOYkNEnt1AdkmNweKcQZZu6gH9j5oVgEZmm+qE15N37AtHgYICFI4FuImOBh+SSoWzq6VybO/1HT35DCBKjnQ9alITADZdMetbuKsf8xdISzJiZAguUojAag/r6Mf7eFVVzgBeHnw==
Received: from MN2PR17MB3375.namprd17.prod.outlook.com (2603:10b6:208:13c::25)
 by BN6PR17MB2020.namprd17.prod.outlook.com (2603:10b6:404:81::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.24; Mon, 25 Jul
 2022 21:34:46 +0000
Received: from MN2PR17MB3375.namprd17.prod.outlook.com
 ([fe80::3409:88f8:6069:ccba]) by MN2PR17MB3375.namprd17.prod.outlook.com
 ([fe80::3409:88f8:6069:ccba%3]) with mapi id 15.20.5458.024; Mon, 25 Jul 2022
 21:34:46 +0000
From:   Vanessa Page <Vebpe@outlook.com>
To:     Yifei Liu <yifeliu@cs.stonybrook.edu>
CC:     "ezk@cs.stonybrook.edu" <ezk@cs.stonybrook.edu>,
        "madkar@cs.stonybrook.edu" <madkar@cs.stonybrook.edu>,
        David Woodhouse <dwmw2@infradead.org>,
        Richard Weinberger <richard@nod.at>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Kyeong Yoo <kyeong.yoo@alliedtelesis.co.nz>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] jffs2: correct logic when creating a hole in
 jffs2_write_begin
Thread-Topic: [PATCH] jffs2: correct logic when creating a hole in
 jffs2_write_begin
Thread-Index: AQHYn+OlL8EDeVsAXEe8Sw4ix6TwWa2OiB5VgAEU05c=
Date:   Mon, 25 Jul 2022 21:34:46 +0000
Message-ID: <MN2PR17MB33751E0A2DFD72AA5E774DF5B8959@MN2PR17MB3375.namprd17.prod.outlook.com>
References: <20220725045830.11502-1-yifeliu@cs.stonybrook.edu>
 <MN2PR17MB337506A10F6AF87BBC514F97B8959@MN2PR17MB3375.namprd17.prod.outlook.com>
In-Reply-To: <MN2PR17MB337506A10F6AF87BBC514F97B8959@MN2PR17MB3375.namprd17.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-tmn:  [/GlHU8A3M9gSE3fr4w9rqsiqJCQXAmK72HDz+jGkgVVsx18jquX8cMmDhpFwDCr/]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4083d897-c1f7-4237-d497-08da6e857f16
x-ms-traffictypediagnostic: BN6PR17MB2020:EE_
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: jE72Gi6Z452BXhuiKaT2dGqjE6X77efzDvdDzCwoMhrkDtX+DxG2JAO4YVS5fwq2VBfkMlJbNL+KLaPUSy0HePALKsoxGwkyu+abM70Y62IIgbtdfMRmo/kg8VJKCFTKO355hMYusr6pqUsH9SgOdqlVGgJouLuRPKyoLdecsBCko0URr5sIsm158DkrOXbMTHadlJyqUq4s1j40weukq/GzazzKzgF6ECZ+d1IF73MMseYP7Z9HdeS0n7FjX6rEFtjkksulmZisJD+NFuD/vO9zDZxZ5MZQL7xtWqqnIBahiogR/HisL+HmTD7zVBrpeCVddKcwaubMz3swGu9phJB/n9ePsU75fheRYJzWYieEySZMfZOkXRVqbg4jIlTY+0OkWj2aTLFy35dbIKET1XNFzqyzaIjSy9vWODVrwU5D9fe1Hl+PYig34TIQTVXWJyVfCcQO4VfAqFi2SHzp8Nnjo3/n5s04knGaBDDt6v8tEUrgftLe+7puRZnObZl4AbHJj5x8J7DwoNTJOgWGrW4zQwTgLHDBJaq1daz9QKCLnbM4rWRDX94Wd4u2N7hXCGAM3EgWAjPED+EHHmzlPTiUnJut1bwMHzNpXlA6weEtzoMcdPFbGNBsP17j/rM6QmSIYX89gTDroBS5/16RhiwzhJlatZ5Zq+d/V3HoABlXXbkbWB+g40DdFrD3IF+f
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?M244U2NmN0FKS2FMYVNmVWFkVTg4ekdkZU5TUlNLM0d5WDFKU0o1cy9NTGli?=
 =?utf-8?B?dm5oWVdQa0VFQ0RqcVhBbGFRYVNXQ3NlUTBCd2w3WkZPdFJUdno3Q0pWYVdo?=
 =?utf-8?B?U25NWWczUWhPRkhSK3hDYkdNYnNudXNqek94TzZuZVB4cm9pVVVRZVQ0SGRU?=
 =?utf-8?B?L2JldEhvSXB5aVBOdUVOM1IrMEt0aldXcnQxL0E5K2VsZEc5VHJ5OUpXdjdn?=
 =?utf-8?B?d0NJbzNUOWMwWnlqd0JGSDdSdmFtbjZlNWVxWU5BVDhaTk1MTGQrN2d5Ujlq?=
 =?utf-8?B?QXR4TkIwVWVOK05kbWp3SGE2dWI1RFoxMno2WXUxOUVhRXNuMXFEc0N1VGF5?=
 =?utf-8?B?dFVrSWxKdk90NUpsOU5kN3gyWW1wNjdJeWJRSjdnWW4vNTdZTjladzQyTmdM?=
 =?utf-8?B?dW9XWTdzWHd0WjlGUndrWTExTVZyeFc2TGNONzM2Y014eU5qUVkzbm5uajVX?=
 =?utf-8?B?STREVGQwZUhCRGM5VVFJN2RnZ1dqZ3BkREpTZkFGNG0xNU9EbFR1TzZSZENM?=
 =?utf-8?B?d1Z3UjdwNGVIdXM0d3Z2RGpNR1Y2cDVRNlBwT2VqS09GVndsTTh5aE9MaGhC?=
 =?utf-8?B?VzNhK0prV21hclpnS1BURHc5OXVLTENYYXlhZkYxdHFjVS9BUFY1bDJaOGVN?=
 =?utf-8?B?Wi9JUEFqVEVHdGpnblo3QThIRE5BblVNWGZ5RVFCUEVlU1VvTys5SG43OXNx?=
 =?utf-8?B?Wk5SOUtGUEpaTHJEWmJpKzFCNDVDdkxFTFBYNWZMWDBvd09xY0VoUkYxTHkr?=
 =?utf-8?B?Ry9ZYjZrRDd3aEczeTBsZmRPVnVRWFh1OHlWUkpJc1Q3dFFST2VIYVhjcXVq?=
 =?utf-8?B?c09Cb0ZhVitsMDV4STJ6dHJEMnhqYklCMFErdklPaHF0V3hZRGlNa21IOTFn?=
 =?utf-8?B?SWoxZ3lRbjFjS2pqSmdKVmt3TTlrdXlLYU85MTBjZ0FEQURMWWV1cVNpZEx4?=
 =?utf-8?B?UUI1OG0zRms1enJVZXZTck96NFFtUlovUlRvSXhLSDVIbDdUaHZaVHhCcEFP?=
 =?utf-8?B?NE5wc25MTGhmWWw4dGFZRjUzVHhMZHhNTVRYVkpKanhCMWppMzdBYUJDN21U?=
 =?utf-8?B?c3N3QVJxRXF6S0RqUVRnQWFZbjZnM0x6dUpUc2xnT2VzTE5MUEJ6SFlQS3FV?=
 =?utf-8?B?OTVLOFRvaHNOZ2hreElTM1VDYWJKNzJaUENNa0FZWmpPb3o1TWhYV1lYWEtR?=
 =?utf-8?B?STM2UzhkQitSeUVIK1NJcU5YRkt6eWpFNkZWMHBHamw1bkZBeUNvNDBtNHRl?=
 =?utf-8?B?dFozRk8xTkdPVHN0NlV5WnMxME93dWMrOTRNdno4YjhqZ09Pa1pRU2VQOXRN?=
 =?utf-8?B?aGFrQndZVGwxemtURXA1eGRuVWtaVGdFbUpMeENsMEpnNC9sYzRKTmt2eTJu?=
 =?utf-8?B?UHM0K2FMMGlZVXBaVXdRRTh0VWx4S1dPTnVSTTA3VjNWc2tzZ3FhVnQ0ZjA0?=
 =?utf-8?B?UFY2d3VVc3pVT2VqN0FOVVY1cUFPLzRkNnE2b3hxSVIySTQzV2hZaUFJN3Bo?=
 =?utf-8?B?a29wc3B6czJPTDdNTDdOalBINEI5ckNCNjJYNE5tSE9uU1E0VGhnOC91bjFR?=
 =?utf-8?B?dXRhSjJKRmhjTXRkcjdFaWpxc2xTNzdOeFd4dnZaSUNRUVA3NFhyMGcydkx3?=
 =?utf-8?B?OWZFTmEzSVJhRmpTRDFmK0d4UG85bzNFN3R1U0ViMU9lbkthK1YyV2UvS0xz?=
 =?utf-8?B?K2xjVFVnb3MwVVZ2T1pZcmMyMjVzZllLSGlsZ2dVbmxvWDlYcS9aNEc2K3dO?=
 =?utf-8?Q?nUgxUJSsbLXmQPihyshWf12yBzV+GfIlSQ/CwGJ?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR17MB3375.namprd17.prod.outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 4083d897-c1f7-4237-d497-08da6e857f16
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jul 2022 21:34:46.7629
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR17MB2020
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

S29vcPCfmILwn5iC8J+YkfCfmJHwn5iR8J+YjvCfmITwn5iE8J+YtPCfmLTwn5GA8J+RgPCfkoHw
n5mI8J+ZiPCfmYjwn5mI8J+SgfCfkYDwn5GA8J+YkfCfkoHwn5iB8J+Ys/CfmI7wn5i08J+YkfCf
kYDwn5iR8J+YhPCfpKPwn6Sj8J+YgPCfmIPwn5iR8J+YtPCfmITwn6Sl8J+kq/CfmKXwn5iw8J+l
tfCfpbXwn5ih8J+YofCfpKzwn6Sv8J+YrfCfmK3wn5if8J+Yn/CfpbPwn6Sp8J+luPCfpbjwn6W4
8J+ZgfCfmKnwn6W64pi577iP8J+Yo/CfmJTwn5iU8J+YlPCfmJbwn5ij8J+YovCfmKHwn6W28J+Y
sPCfmLDwn5il8J+YpfCfmLbigI3wn4yr77iP8J+krPCfpKzwn6Ss8J+kr/CfmLbigI3wn4yr77iP
8J+ltvCfmLDwn5iw8J+kq/CfpKvwn5iT8J+kr/CfpK/wn6SvDQpPb2lnZ3ZrbHBvdXJl8J+krPCf
pKzwn6Ss8J+krPCfpKzwn6Ss8J+krPCfpKzwn6Ss8J+krPCfpK/wn6Sv8J+kr/CfpK/wn6Sv8J+k
r/CfpK/wn6Sv8J+kr/CfpKvwn5iT8J+krPCfpK/wn6Sv8J+krPCfpKzwn5mB8J+YkvCfmI3wn5iS
8J+YkvCfmI7wn6W48J+kqfCfpbPwn5if8J+YlvCfpbrwn5ip8J+YqfCfpKnwn6Wz8J+ls/CfmJ/w
n5iW8J+Yo/CfmYHwn5ip4pi577iP8J+Yn/CfmKvwn5ik8J+YrfCfpKzwn6Sp8J+kqfCfpbjwn5iO
8J+ZgfCfmKnwn5ih8J+YtfCfmKrwn5in8J+kpfCfpKXwn5iv8J+YtfCfpK7wn5is8J+kpfCfmJPw
n6SX8J+kl/CfmLbwn5iy8J+kpPCfpJDwn6SS8J+klfCfmLXigI3wn5Kr8J+YteKAjfCfkqvwn5i1
4oCN8J+Sq/CfmLXigI3wn5Kr8J+YteKAjfCfkqvwn5i14oCN8J+Sq/CfmLXigI3wn5Kr8J+YteKA
jfCfkqvwn5i14oCN8J+Sq/CfmLXigI3wn5Kr8J+YteKAjfCfkqvwn6SR8J+YvPCfmL3imKDvuI/w
n5KA8J+SgPCfkbvwn5G78J+Ru/Cfkbnwn5G58J+RuvCfkb3wn5G98J+SgPCfkoDwn5G78J+SgPCf
koDwn5KA4pig77iP4pig77iP4pig77iP4pig77iPDQoNCj4gT24gSnVsIDI1LCAyMDIyLCBhdCAx
OjA2IEFNLCBWYW5lc3NhIFBhZ2UgPFZlYnBlQG91dGxvb2suY29tPiB3cm90ZToNCj4gDQo+IO+7
v/CfpbDwn6Ww8J+lsPCfpbDwn6Ww8J+lsPCfpbDwn6Ww8J+lsPCfmI3wn5GM8J+YjfCfkYzwn5iN
8J+YjfCfmI3wn5iN8J+YjeKYuu+4j+KYuu+4j+KYuu+4j+KYuu+4j+KYuu+4j/CfkpXwn5KV8J+Y
mvCfmJrwn5ia8J+YmvCfpbDwn5ia8J+YjfCfmI3wn5iN8J+YmvCfmJrwn5iN4pi677iP4pi677iP
4pi677iP8J+YjfCfkpXwn5ia8J+lsPCfpbDwn5iN4pi677iP4pi677iP8J+YmvCfpbDwn5iN4pi6
77iP8J+YjfCfpbDwn5iN4pi677iP4pi677iP8J+SlfCfpbDwn6Ww8J+YjeKYuu+4j+KYuu+4j/Cf
mIoNCj4gDQo+IFNlbnQgZnJvbSBteSBpUGhvbuKcjO+4jw0KPiANCj4+IE9uIEp1bCAyNSwgMjAy
MiwgYXQgMTowMSBBTSwgWWlmZWkgTGl1IDx5aWZlbGl1QGNzLnN0b255YnJvb2suZWR1PiB3cm90
ZToNCj4+IA0KPj4g77u/QnVnIGRlc2NyaXB0aW9uIGFuZCBmaXg6DQo+PiANCj4+IDEuIFdyaXRl
IGRhdGEgdG8gYSBmaWxlLCBzYXkgYWxsIDFzIGZyb20gb2Zmc2V0IDAgdG8gMTYuDQo+PiANCj4+
IDIuIFRydW5jYXRlIHRoZSBmaWxlIHRvIGEgc21hbGxlciBzaXplLCBzYXkgOCBieXRlcy4NCj4+
IA0KPj4gMy4gV3JpdGUgbmV3IGJ5dGVzIChzYXkgMnMpIGZyb20gYW4gb2Zmc2V0IHBhc3QgdGhl
IG9yaWdpbmFsIHNpemUgb2YgdGhlDQo+PiBmaWxlLCBzYXkgYXQgb2Zmc2V0IDIwLCBmb3IgNCBi
eXRlcy4gIFRoaXMgaXMgc3VwcG9zZWQgdG8gY3JlYXRlIGEgImhvbGUiDQo+PiBpbiB0aGUgZmls
ZSwgbWVhbmluZyB0aGF0IHRoZSBieXRlcyBmcm9tIG9mZnNldCA4ICh3aGVyZSBpdCB3YXMgdHJ1
bmNhdGVkDQo+PiBhYm92ZSkgdXAgdG8gdGhlIG5ldyB3cml0ZSBhdCBvZmZzZXQgMjAsIHNob3Vs
ZCBhbGwgYmUgMHMgKHplcm9zKS4NCj4+IA0KPj4gNC4gZmx1c2ggYWxsIGNhY2hlcyB1c2luZyAi
ZWNobyAzID4gL3Byb2Mvc3lzL3ZtL2Ryb3BfY2FjaGVzIiAob3IgdW5tb3VudA0KPj4gYW5kIHJl
bW91bnQpIHRoZSBmL3MuDQo+PiANCj4+IDUuIENoZWNrIHRoZSBjb250ZW50IG9mIHRoZSBmaWxl
LiAgSXQgaXMgd3JvbmcuICBUaGUgMXMgdGhhdCB1c2VkIHRvIGJlDQo+PiBiZXR3ZWVuIGJ5dGVz
IDkgYW5kIDE2LCBiZWZvcmUgdGhlIHRydW5jYXRpb24sIGhhdmUgUkVBUFBFQVJFRCAodGhleSBz
aG91bGQNCj4+IGJlIDBzKS4NCj4+IA0KPj4gV2Ugd3JvdGUgYSBzY3JpcHQgYW5kIGhlbHBlciBD
IHByb2dyYW0gdG8gcmVwcm9kdWNlIHRoZSBidWcNCj4+IChyZXByb2R1Y2VfamZmczJfd3JpdGVf
YmVnaW5faXNzdWUuc2gsIHdyaXRlX2ZpbGUuYywgYW5kIE1ha2VmaWxlKS4gIFdlIGNhbg0KPj4g
bWFrZSB0aGVtIGF2YWlsYWJsZSB0byBhbnlvbmUuDQo+PiANCj4+IFRoZSBhYm92ZSBleGFtcGxl
IGlzIHNob3duIHdoZW4gd3JpdGluZyBhIHNtYWxsIGZpbGUgd2l0aGluIHRoZSBzYW1lIGZpcnN0
DQo+PiBwYWdlLiAgQnV0IHRoZSBidWcgaGFwcGVucyBmb3IgbGFyZ2VyIGZpbGVzLCBhcyBsb25n
IGFzIHN0ZXBzIDEsIDIsIGFuZCAzDQo+PiBhYm92ZSBhbGwgaGFwcGVuIHdpdGhpbiB0aGUgc2Ft
ZSBwYWdlLg0KPj4gDQo+PiBUaGUgcHJvYmxlbSB3YXMgdHJhY2VkIHRvIHRoZSBqZmZzMl93cml0
ZV9iZWdpbiBjb2RlLCB3aGVyZSBpdCBnb2VzIGludG8gYW4NCj4+ICdpZicgc3RhdGVtZW50IGlu
dGVuZGVkIHRvIGhhbmRsZSB3cml0ZXMgcGFzdCB0aGUgY3VycmVudCBFT0YgKGkuZS4sIHdyaXRl
cw0KPj4gdGhhdCBtYXkgY3JlYXRlIGEgaG9sZSkuICBUaGUgY29kZSBjb21wdXRlcyBhICdwYWdl
b2ZzJyB0aGF0IGlzIHRoZSBmbG9vcg0KPj4gb2YgdGhlIHdyaXRlIHBvc2l0aW9uIChwb3MpLCBh
bGlnbmVkIHRvIHRoZSBwYWdlIHNpemUgYm91bmRhcnkuICBJbiBvdGhlcg0KPj4gd29yZHMsICdw
YWdlb2ZzJyB3aWxsIG5ldmVyIGJlIGxhcmdlciB0aGFuICdwb3MnLiAgVGhlIGNvZGUgdGhlbiBz
ZXRzIHRoZQ0KPj4gaW50ZXJuYWwgamZmczJfcmF3X2lub2RlLT5pc2l6ZSB0byB0aGUgc2l6ZSBv
ZiBtYXgoY3VycmVudCBpbm9kZSBzaXplLA0KPj4gcGFnZW9mcykgYnV0IHRoYXQgaXMgd3Jvbmc6
IHRoZSBuZXcgZmlsZSBzaXplIHNob3VsZCBiZSB0aGUgJ3BvcycsIHdoaWNoIGlzDQo+PiBsYXJn
ZXIgdGhhbiBib3RoIHRoZSBjdXJyZW50IGlub2RlIHNpemUgYW5kIHBhZ2VvZnMuDQo+PiANCj4+
IFNpbWlsYXJseSwgdGhlIGNvZGUgaW5jb3JyZWN0bHkgc2V0cyB0aGUgaW50ZXJuYWwgamZmczJf
cmF3X2lub2RlLT5kc2l6ZSB0bw0KPj4gdGhlIGRpZmZlcmVuY2UgYmV0d2VlbiB0aGUgcGFnZW9m
cyBtaW51cyBjdXJyZW50IGlub2RlIHNpemU7IGluc3RlYWQgaXQNCj4+IHNob3VsZCBiZSB0aGUg
Y3VycmVudCBwb3MgbWludXMgdGhlIGN1cnJlbnQgaW5vZGUgc2l6ZS4gIEZpbmFsbHksDQo+PiBp
bm9kZS0+aV9zaXplIHdhcyBhbHNvIHNldCBpbmNvcnJlY3RseS4NCj4+IA0KPj4gVGhlIHBhdGNo
IGJlbG93IGZpeGVzIHRoaXMgYnVnLiAgVGhlIGJ1ZyB3YXMgZGlzY292ZXJlZCB1c2luZyBhIG5l
dyB0b29sDQo+PiBmb3IgZmluZGluZyBmL3MgYnVncyB1c2luZyBtb2RlbCBjaGVja2luZywgY2Fs
bGVkIE1DRlMgKE1vZGVsIENoZWNraW5nIEZpbGUNCj4+IFN5c3RlbXMpLg0KPj4gDQo+PiBTaWdu
ZWQtb2ZmLWJ5OiBZaWZlaSBMaXUgPHlpZmVsaXVAY3Muc3Rvbnlicm9vay5lZHU+DQo+PiBTaWdu
ZWQtb2ZmLWJ5OiBFcmV6IFphZG9rIDxlemtAY3Muc3Rvbnlicm9vay5lZHU+DQo+PiBTaWduZWQt
b2ZmLWJ5OiBNYW5pc2ggQWRrYXIgPG1hZGthckBjcy5zdG9ueWJyb29rLmVkdT4NCj4+IC0tLQ0K
Pj4gZnMvamZmczIvZmlsZS5jIHwgMTUgKysrKysrKy0tLS0tLS0tDQo+PiAxIGZpbGUgY2hhbmdl
ZCwgNyBpbnNlcnRpb25zKCspLCA4IGRlbGV0aW9ucygtKQ0KPj4gDQo+PiBkaWZmIC0tZ2l0IGEv
ZnMvamZmczIvZmlsZS5jIGIvZnMvamZmczIvZmlsZS5jDQo+PiBpbmRleCBiYTg2YWNiZTEyZDMu
LjA0NzkwOTZiOTZlNCAxMDA2NDQNCj4+IC0tLSBhL2ZzL2pmZnMyL2ZpbGUuYw0KPj4gKysrIGIv
ZnMvamZmczIvZmlsZS5jDQo+PiBAQCAtMTM3LDE5ICsxMzcsMTggQEAgc3RhdGljIGludCBqZmZz
Ml93cml0ZV9iZWdpbihzdHJ1Y3QgZmlsZSAqZmlscCwgc3RydWN0IGFkZHJlc3Nfc3BhY2UgKm1h
cHBpbmcsDQo+PiAgIHN0cnVjdCBqZmZzMl9pbm9kZV9pbmZvICpmID0gSkZGUzJfSU5PREVfSU5G
Tyhpbm9kZSk7DQo+PiAgIHN0cnVjdCBqZmZzMl9zYl9pbmZvICpjID0gSkZGUzJfU0JfSU5GTyhp
bm9kZS0+aV9zYik7DQo+PiAgIHBnb2ZmX3QgaW5kZXggPSBwb3MgPj4gUEFHRV9TSElGVDsNCj4+
IC0gICAgdWludDMyX3QgcGFnZW9mcyA9IGluZGV4IDw8IFBBR0VfU0hJRlQ7DQo+PiAgIGludCBy
ZXQgPSAwOw0KPj4gDQo+PiAgIGpmZnMyX2RiZygxLCAiJXMoKVxuIiwgX19mdW5jX18pOw0KPj4g
DQo+PiAtICAgIGlmIChwYWdlb2ZzID4gaW5vZGUtPmlfc2l6ZSkgew0KPj4gLSAgICAgICAgLyog
TWFrZSBuZXcgaG9sZSBmcmFnIGZyb20gb2xkIEVPRiB0byBuZXcgcGFnZSAqLw0KPj4gKyAgICBp
ZiAocG9zID4gaW5vZGUtPmlfc2l6ZSkgew0KPj4gKyAgICAgICAgLyogTWFrZSBuZXcgaG9sZSBm
cmFnIGZyb20gb2xkIEVPRiB0byBuZXcgcG9zaXRpb24gKi8NCj4+ICAgICAgIHN0cnVjdCBqZmZz
Ml9yYXdfaW5vZGUgcmk7DQo+PiAgICAgICBzdHJ1Y3QgamZmczJfZnVsbF9kbm9kZSAqZm47DQo+
PiAgICAgICB1aW50MzJfdCBhbGxvY19sZW47DQo+PiANCj4+IC0gICAgICAgIGpmZnMyX2RiZygx
LCAiV3JpdGluZyBuZXcgaG9sZSBmcmFnIDB4JXgtMHgleCBiZXR3ZWVuIGN1cnJlbnQgRU9GIGFu
ZCBuZXcgcGFnZVxuIiwNCj4+IC0gICAgICAgICAgICAgICh1bnNpZ25lZCBpbnQpaW5vZGUtPmlf
c2l6ZSwgcGFnZW9mcyk7DQo+PiArICAgICAgICBqZmZzMl9kYmcoMSwgIldyaXRpbmcgbmV3IGhv
bGUgZnJhZyAweCV4LTB4JXggYmV0d2VlbiBjdXJyZW50IEVPRiBhbmQgbmV3IHBvc2l0aW9uXG4i
LA0KPj4gKyAgICAgICAgICAgICAgKHVuc2lnbmVkIGludClpbm9kZS0+aV9zaXplLCAodWludDMy
X3QpcG9zKTsNCj4+IA0KPj4gICAgICAgcmV0ID0gamZmczJfcmVzZXJ2ZV9zcGFjZShjLCBzaXpl
b2YocmkpLCAmYWxsb2NfbGVuLA0KPj4gICAgICAgICAgICAgICAgICAgICBBTExPQ19OT1JNQUws
IEpGRlMyX1NVTU1BUllfSU5PREVfU0laRSk7DQo+PiBAQCAtMTY5LDEwICsxNjgsMTAgQEAgc3Rh
dGljIGludCBqZmZzMl93cml0ZV9iZWdpbihzdHJ1Y3QgZmlsZSAqZmlscCwgc3RydWN0IGFkZHJl
c3Nfc3BhY2UgKm1hcHBpbmcsDQo+PiAgICAgICByaS5tb2RlID0gY3B1X3RvX2plbW9kZShpbm9k
ZS0+aV9tb2RlKTsNCj4+ICAgICAgIHJpLnVpZCA9IGNwdV90b19qZTE2KGlfdWlkX3JlYWQoaW5v
ZGUpKTsNCj4+ICAgICAgIHJpLmdpZCA9IGNwdV90b19qZTE2KGlfZ2lkX3JlYWQoaW5vZGUpKTsN
Cj4+IC0gICAgICAgIHJpLmlzaXplID0gY3B1X3RvX2plMzIobWF4KCh1aW50MzJfdClpbm9kZS0+
aV9zaXplLCBwYWdlb2ZzKSk7DQo+PiArICAgICAgICByaS5pc2l6ZSA9IGNwdV90b19qZTMyKCh1
aW50MzJfdClwb3MpOw0KPj4gICAgICAgcmkuYXRpbWUgPSByaS5jdGltZSA9IHJpLm10aW1lID0g
Y3B1X3RvX2plMzIoSkZGUzJfTk9XKCkpOw0KPj4gICAgICAgcmkub2Zmc2V0ID0gY3B1X3RvX2pl
MzIoaW5vZGUtPmlfc2l6ZSk7DQo+PiAtICAgICAgICByaS5kc2l6ZSA9IGNwdV90b19qZTMyKHBh
Z2VvZnMgLSBpbm9kZS0+aV9zaXplKTsNCj4+ICsgICAgICAgIHJpLmRzaXplID0gY3B1X3RvX2pl
MzIoKHVpbnQzMl90KXBvcyAtIGlub2RlLT5pX3NpemUpOw0KPj4gICAgICAgcmkuY3NpemUgPSBj
cHVfdG9famUzMigwKTsNCj4+ICAgICAgIHJpLmNvbXByID0gSkZGUzJfQ09NUFJfWkVSTzsNCj4+
ICAgICAgIHJpLm5vZGVfY3JjID0gY3B1X3RvX2plMzIoY3JjMzIoMCwgJnJpLCBzaXplb2Yocmkp
LTgpKTsNCj4+IEBAIC0yMDIsNyArMjAxLDcgQEAgc3RhdGljIGludCBqZmZzMl93cml0ZV9iZWdp
bihzdHJ1Y3QgZmlsZSAqZmlscCwgc3RydWN0IGFkZHJlc3Nfc3BhY2UgKm1hcHBpbmcsDQo+PiAg
ICAgICAgICAgZ290byBvdXRfZXJyOw0KPj4gICAgICAgfQ0KPj4gICAgICAgamZmczJfY29tcGxl
dGVfcmVzZXJ2YXRpb24oYyk7DQo+PiAtICAgICAgICBpbm9kZS0+aV9zaXplID0gcGFnZW9mczsN
Cj4+ICsgICAgICAgIGlub2RlLT5pX3NpemUgPSBwb3M7DQo+PiAgICAgICBtdXRleF91bmxvY2so
JmYtPnNlbSk7DQo+PiAgIH0NCj4+IA0KPj4gLS0gDQo+PiAyLjI1LjENCj4+IA0KPj4gDQo+PiBf
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18NCj4+
IExpbnV4IE1URCBkaXNjdXNzaW9uIG1haWxpbmcgbGlzdA0KPj4gaHR0cDovL2xpc3RzLmluZnJh
ZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1tdGQvDQo=
