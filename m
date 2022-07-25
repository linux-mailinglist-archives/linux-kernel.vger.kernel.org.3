Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FDB2580719
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jul 2022 00:08:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237115AbiGYWIb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jul 2022 18:08:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237058AbiGYWI1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jul 2022 18:08:27 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12olkn2031.outbound.protection.outlook.com [40.92.21.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFD5524940
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jul 2022 15:08:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Np73W3J9JPRz1WX7hNI7LYhS5mSYh+KSPz1TyGqx1EcduD4dVWUVy5NtI7qyZK3iabuaf8Tnpt5tPjL1rndmp66HKqFOElFAhONOnEr64oxuzS/NFCEgKbL+/IIINapWFZklpE0i/YHvy5SkCZDNUGPyiknZl41uttIGoryNGdx9qRWsk2Vc9Bak3xJ7vNcXCo+fjo3Zrw3n9B/4tGjqCzapk/1DGKnxgclEA7WrPsBMDkodgEGDmQO6z6GALaaN56PfP/JaMowameJ24VvsX1jtqd6LZ573POcZcoZpx+mNj/0S+r9UXx0RQLVjpj0TDVmhwH4Hi6dIEX/iSSF5ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I/9h8x2oej+GL2Bez5wkglfn33VrJOpv3U7lqprb9uM=;
 b=d0tQbILcl6/3DJUraPWnvTW94SEuz/xmHdEdyhXAxcwaNpFVA9m/cXJosorNq21+9RxlI2BqZWpADg6Rm5Vv9HFKT8lb134EgE8qpYbz2yHrrLYm0xDLZIgxZSYFiruHH8R9xST/y2hgDnfRmdAXvA2IQ05+Sjjq6HrGZb2wACDqHtJtzMqekzxeNXVM6qptfHQQdL/lLUgZzeFyrdSzgnvWbc+DaiRvNs7cshlZ2nydFBqNPJcx+8esmnejzcUhUL7PIpa0C4Jvn6ndYcYoH130ieDmR+nEON6RbvN/occTQ3Ol31ILjnzpXYL1VR03S12Hy5mPTDh0mQmtxNYpZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I/9h8x2oej+GL2Bez5wkglfn33VrJOpv3U7lqprb9uM=;
 b=KP9Ojk1Jx18zl4uMy5Dp+7Eu+1N6akVdxKzE3khlxgBgt2B3mBHGWu55rG6f2euaxzZlG+2lF3EjJqnDqGg8GSp9rWfYM/7Fe1c+2QJY7RIzPNi0nFbgRxcPrY61q0iH4xGgq1XQsVDSADjaRlFUxhMIHwJo5PSuLZ3v2A3fPRb4x7VKpRiO/BlaT+znCLCN3UclfSE2HvMUViNYQZLOR8YMnnuJwbG422rfqXSd2DXf/nvHuiy6M7ZPvQgkDCNgUOjH02kmbMOmWo7gvmRfyIrvxgyKR7dCNbCeZ6SStjQt81up9lMAQvvbmjQZKywPvdzvGxLVtDuncFDeF8DHkw==
Received: from MN2PR17MB3375.namprd17.prod.outlook.com (2603:10b6:208:13c::25)
 by BL0PR1701MB2547.namprd17.prod.outlook.com (2603:10b6:208:7e::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.24; Mon, 25 Jul
 2022 22:08:22 +0000
Received: from MN2PR17MB3375.namprd17.prod.outlook.com
 ([fe80::3409:88f8:6069:ccba]) by MN2PR17MB3375.namprd17.prod.outlook.com
 ([fe80::3409:88f8:6069:ccba%3]) with mapi id 15.20.5458.024; Mon, 25 Jul 2022
 22:08:22 +0000
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
Thread-Index: AQHYn+OlL8EDeVsAXEe8Sw4ix6TwWa2OiB5VgAEeNi0=
Date:   Mon, 25 Jul 2022 22:08:22 +0000
Message-ID: <MN2PR17MB3375E27C3B75D6AB9F856409B8959@MN2PR17MB3375.namprd17.prod.outlook.com>
References: <20220725045830.11502-1-yifeliu@cs.stonybrook.edu>
 <MN2PR17MB337506A10F6AF87BBC514F97B8959@MN2PR17MB3375.namprd17.prod.outlook.com>
In-Reply-To: <MN2PR17MB337506A10F6AF87BBC514F97B8959@MN2PR17MB3375.namprd17.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-tmn:  [BaSOaL3PHfYPXtKX86oVqA4PtlAhF+R1LitW95dW/EefcJfhLFyxj6+LJp6gWIH3]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ea6242a8-286f-4e39-2a92-08da6e8a3076
x-ms-traffictypediagnostic: BL0PR1701MB2547:EE_
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +dBNUAvIz4c+PO8OpIaKS+kkIdt9F8tN3g+Qt4bVCw45XSn5IudfEPzfb7IlqouKqpjbB74f//r8stBunYZipJoPsTo2l5lJ9RUf5r3x9Ah8qsh5gE9xlN3sLlnwgqSHsbC/sGg7PtH7jv7SLz+JQ5qCN44hxwznkzPIXc4wOOEKaneF4pGmF72qhR905MYBqcoIq20pg6CYjfxuqPsTSvOWoOtUTMZTG7NvKgt8q5gUwt5kzmDPFPeWYcEJrgxTiwqLeJOqSeNozWDQcEmr5xTx7AYH+44VScd7hs3s1Bld40JN4zRZrQ+AZ7ypaH6YucTuoZ4nKY0MhDYu+PBMg7vfFdD4+/dlnXJzAS7x6NQFOUqYMc6c/NrQLxqT/h/hGHbdfg6TQyxezZq2EInLk/enImrqsyrXz+3FnJhmjhRW8ww8ODgjAI+MkZISjcorN81YtDLOSE47eI1HPQZsXjo8ID9JtrLEhyG6b2oBrFHhxnNgA+7sRCojWb+xmW5FTuJHcWRqnTETQuKDrAm0ZvrgM6dfi8cYrLUOZKWiLlzf7YQXthTsYGs5Q9MFYjyzKqQh8jTCI6VVmqPcbWns/WplQExhJrhBdS2BTojFhNltI9yYw839WmYw3RobDZpp35t3H3u7mgwSAKKbV07qFG21wBU/OSWiCAhHetbiFbkneet9j3C9JcRNxVUgzEZl
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RExnOFBQSXJBNWZ4UE81aytRNGdmckNPSzhqMUlqNERiS2xSZlZIV3ZZSmd1?=
 =?utf-8?B?c01mT25sa3ZCU214RzZrNGdOeGRITGxwbUlWSVBsRitzS0tBOWhZaFVvS2hp?=
 =?utf-8?B?QWI5M2ozTWNESUFTRjcvVDF5OXIwUmIzY1NTRkViSFhtOU1Ic3ljVXVXRVBS?=
 =?utf-8?B?dkFLbkMwMUYvYkFZZG80MEJuUnkvYWhWNmZFMUJUczcwOTg1Lzhldk4vbUgw?=
 =?utf-8?B?WERvRUdMbmhSRHZJYjZpV0wzYnFmZnZraGZPV0FzUHFDR3pGYi9ZNmk1T1Nj?=
 =?utf-8?B?dmdnQzkrUHJJVVBsM0VFUFhXbVByT3ptZURpeHlVZUhxK0xJRFB0ckpPNXhE?=
 =?utf-8?B?OHUwVEpWM2p6NVNBSWRyOXJyTDd1Ukx6bzFvZVNoajRNdXViR3ppMGl2cGlY?=
 =?utf-8?B?NlF1bThuRUVpYnhjQ3lmR05YTFV6ZlRPRllwalNnSTdWeXUzcGY2RlQyeW04?=
 =?utf-8?B?elcvVnI5Q3o2Z3M1MnBFQkFvUUdDdXY3ZXRWL2tnSjNmRVNyelZRVDZHYlVO?=
 =?utf-8?B?MHY5Z0dXMjk5SGxiQlRwU0xYTjJGby8wd21iVDdTMytmWUt1TExRd0RpeGRl?=
 =?utf-8?B?SmE2NTZvSHB1Z2pXeUxnWERhRkpaWk0zOXJhbU1PSERrSjU1NDBoa0krZGRE?=
 =?utf-8?B?Y0Z5RVVhMzlsWXVPelMwbnRSUzg1OGZEbVpCSmo4Tm9sS1NySi9uNy8yVWtB?=
 =?utf-8?B?RW5DU293SXFhblluUjIwUm4vaHU2TC9WT1o3OWV1SUthcVRNZ1hab2c0azhV?=
 =?utf-8?B?MlM2OXlxUWJFZ2Q5T29xYXg0RUlocXVyNjk0N3FxUzdUYnpQOHdkMGJTN01Z?=
 =?utf-8?B?SW9qbVB0MjB1U0orMjdEYjNkQVdEMnJGUEkxRUxmUyt1NjRSaHZiR0NpaTRt?=
 =?utf-8?B?N2UvMmN5aktyZ2JJYVpBMjhEZkhJMXZHRUltVEpoK0oxTXIwOVR2cUlaQWNT?=
 =?utf-8?B?NnM2T1NScExzOEVvMW9DYTdVTWRtdSt2SWp1K0pXbEZoT29UVUkxQzBMZi9M?=
 =?utf-8?B?dS9Kbmp5aytSMjNnMk9yQXNuUFo1SWpIU0pVem5VQmU5bUtJeDUySGl5RGEx?=
 =?utf-8?B?dGFiemFLeGNNSXFGTllzakVxcVhRWUdKSUNWZFV5RldYcjQrdjZXbjRwTzMx?=
 =?utf-8?B?VHVuTXhWM0puSGdmS3JiWmNOWVpWRWt4WkYrNmJ5SVlVUlNPUXVUZFFueEFI?=
 =?utf-8?B?eW0yTEVCdVRYZVRLTk9ZTDlmc0VMbHBpQWZKRC83UjJoZEVZOW1YMVRBR0Jt?=
 =?utf-8?B?QWN6S3BQOGhKZE5jMndKd1luOVZMNGFpRUxPSXJUUHptdFZsOUptMUMvdjNF?=
 =?utf-8?B?amlKR0VHY01sR014YzZ5VjBleUZZUk1iRG9tN1BPVlRUWDVLMWdBUkZnOWV4?=
 =?utf-8?B?RkJha0RhK0FuckRlV0VIQ2RDMlExOVg2UGdpR3J4SGJBTG1xR2hNTVo2UW5r?=
 =?utf-8?B?c0Y0ZXVkSkFZSGVyck4rUEFDYUZiZUJNdFhOSkZBTkVDRmsyT0toVTNBRGN3?=
 =?utf-8?B?YWlEeXd0dDJUa0hMM0ZqOTl6UXNoa0N2Q0pySVlLVzRZZkZWdTFpVzl2WC9L?=
 =?utf-8?B?UDlEWnlRQXVLL2RoUnRxVlBkUFd3NGVFaVQ0QkZUaGNNNi9YbFRzSmlQZ1VC?=
 =?utf-8?B?STgzQkpFV3VQcWhuQjU0N0toZGYrVHF0Rm5YczhiYzRXUlVwSGVIdXN6SkRs?=
 =?utf-8?B?VmdDcEZCRnlqTlVJTU0yWEcxdDJrdlQzMUJNSTZtYkh6ZVpZaHJWN3lMK0cr?=
 =?utf-8?B?S3Y3cERJdTBVcTdiRjVSc0hMRWUybm5LcHE3L0czUEkrenFlTTBvUlRtYzli?=
 =?utf-8?B?TDFZTnUyd3k3RWFCYVEwZz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR17MB3375.namprd17.prod.outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: ea6242a8-286f-4e39-2a92-08da6e8a3076
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jul 2022 22:08:22.3470
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR1701MB2547
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
koDwn5KA4pig77iP4pig77iP4pig77iP4pig77iPDQoNClNlbnQgZnJvbSBteSBpUGhvbmUNCg0K
PiBPbiBKdWwgMjUsIDIwMjIsIGF0IDE6MDQgQU0sIFZhbmVzc2EgUGFnZSA8VmVicGVAb3V0bG9v
ay5jb20+IHdyb3RlOg0KPiANCj4g77u/8J+lsPCfpbDwn6Ww8J+lsPCfpbDwn6Ww8J+lsPCfpbDw
n6Ww8J+YjfCfkYzwn5iN8J+RjPCfmI3wn5iN8J+YjfCfmI3wn5iN4pi677iP4pi677iP4pi677iP
4pi677iP4pi677iP8J+SlfCfkpXwn5ia8J+YmvCfmJrwn5ia8J+lsPCfmJrwn5iN8J+YjfCfmI3w
n5ia8J+YmvCfmI3imLrvuI/imLrvuI/imLrvuI/wn5iN8J+SlfCfmJrwn6Ww8J+lsPCfmI3imLrv
uI/imLrvuI/wn5ia8J+lsPCfmI3imLrvuI/wn5iN8J+lsPCfmI3imLrvuI/imLrvuI/wn5KV8J+l
sPCfpbDwn5iN4pi677iP4pi677iP8J+Yig0KPiANCj4gU2VudCBmcm9tIG15IGlQaG9u4pyM77iP
DQo+IA0KPj4gT24gSnVsIDI1LCAyMDIyLCBhdCAxOjAxIEFNLCBZaWZlaSBMaXUgPHlpZmVsaXVA
Y3Muc3Rvbnlicm9vay5lZHU+IHdyb3RlOg0KPj4gDQo+PiDvu79CdWcgZGVzY3JpcHRpb24gYW5k
IGZpeDoNCj4+IA0KPj4gMS4gV3JpdGUgZGF0YSB0byBhIGZpbGUsIHNheSBhbGwgMXMgZnJvbSBv
ZmZzZXQgMCB0byAxNi4NCj4+IA0KPj4gMi4gVHJ1bmNhdGUgdGhlIGZpbGUgdG8gYSBzbWFsbGVy
IHNpemUsIHNheSA4IGJ5dGVzLg0KPj4gDQo+PiAzLiBXcml0ZSBuZXcgYnl0ZXMgKHNheSAycykg
ZnJvbSBhbiBvZmZzZXQgcGFzdCB0aGUgb3JpZ2luYWwgc2l6ZSBvZiB0aGUNCj4+IGZpbGUsIHNh
eSBhdCBvZmZzZXQgMjAsIGZvciA0IGJ5dGVzLiAgVGhpcyBpcyBzdXBwb3NlZCB0byBjcmVhdGUg
YSAiaG9sZSINCj4+IGluIHRoZSBmaWxlLCBtZWFuaW5nIHRoYXQgdGhlIGJ5dGVzIGZyb20gb2Zm
c2V0IDggKHdoZXJlIGl0IHdhcyB0cnVuY2F0ZWQNCj4+IGFib3ZlKSB1cCB0byB0aGUgbmV3IHdy
aXRlIGF0IG9mZnNldCAyMCwgc2hvdWxkIGFsbCBiZSAwcyAoemVyb3MpLg0KPj4gDQo+PiA0LiBm
bHVzaCBhbGwgY2FjaGVzIHVzaW5nICJlY2hvIDMgPiAvcHJvYy9zeXMvdm0vZHJvcF9jYWNoZXMi
IChvciB1bm1vdW50DQo+PiBhbmQgcmVtb3VudCkgdGhlIGYvcy4NCj4+IA0KPj4gNS4gQ2hlY2sg
dGhlIGNvbnRlbnQgb2YgdGhlIGZpbGUuICBJdCBpcyB3cm9uZy4gIFRoZSAxcyB0aGF0IHVzZWQg
dG8gYmUNCj4+IGJldHdlZW4gYnl0ZXMgOSBhbmQgMTYsIGJlZm9yZSB0aGUgdHJ1bmNhdGlvbiwg
aGF2ZSBSRUFQUEVBUkVEICh0aGV5IHNob3VsZA0KPj4gYmUgMHMpLg0KPj4gDQo+PiBXZSB3cm90
ZSBhIHNjcmlwdCBhbmQgaGVscGVyIEMgcHJvZ3JhbSB0byByZXByb2R1Y2UgdGhlIGJ1Zw0KPj4g
KHJlcHJvZHVjZV9qZmZzMl93cml0ZV9iZWdpbl9pc3N1ZS5zaCwgd3JpdGVfZmlsZS5jLCBhbmQg
TWFrZWZpbGUpLiAgV2UgY2FuDQo+PiBtYWtlIHRoZW0gYXZhaWxhYmxlIHRvIGFueW9uZS4NCj4+
IA0KPj4gVGhlIGFib3ZlIGV4YW1wbGUgaXMgc2hvd24gd2hlbiB3cml0aW5nIGEgc21hbGwgZmls
ZSB3aXRoaW4gdGhlIHNhbWUgZmlyc3QNCj4+IHBhZ2UuICBCdXQgdGhlIGJ1ZyBoYXBwZW5zIGZv
ciBsYXJnZXIgZmlsZXMsIGFzIGxvbmcgYXMgc3RlcHMgMSwgMiwgYW5kIDMNCj4+IGFib3ZlIGFs
bCBoYXBwZW4gd2l0aGluIHRoZSBzYW1lIHBhZ2UuDQo+PiANCj4+IFRoZSBwcm9ibGVtIHdhcyB0
cmFjZWQgdG8gdGhlIGpmZnMyX3dyaXRlX2JlZ2luIGNvZGUsIHdoZXJlIGl0IGdvZXMgaW50byBh
bg0KPj4gJ2lmJyBzdGF0ZW1lbnQgaW50ZW5kZWQgdG8gaGFuZGxlIHdyaXRlcyBwYXN0IHRoZSBj
dXJyZW50IEVPRiAoaS5lLiwgd3JpdGVzDQo+PiB0aGF0IG1heSBjcmVhdGUgYSBob2xlKS4gIFRo
ZSBjb2RlIGNvbXB1dGVzIGEgJ3BhZ2VvZnMnIHRoYXQgaXMgdGhlIGZsb29yDQo+PiBvZiB0aGUg
d3JpdGUgcG9zaXRpb24gKHBvcyksIGFsaWduZWQgdG8gdGhlIHBhZ2Ugc2l6ZSBib3VuZGFyeS4g
IEluIG90aGVyDQo+PiB3b3JkcywgJ3BhZ2VvZnMnIHdpbGwgbmV2ZXIgYmUgbGFyZ2VyIHRoYW4g
J3BvcycuICBUaGUgY29kZSB0aGVuIHNldHMgdGhlDQo+PiBpbnRlcm5hbCBqZmZzMl9yYXdfaW5v
ZGUtPmlzaXplIHRvIHRoZSBzaXplIG9mIG1heChjdXJyZW50IGlub2RlIHNpemUsDQo+PiBwYWdl
b2ZzKSBidXQgdGhhdCBpcyB3cm9uZzogdGhlIG5ldyBmaWxlIHNpemUgc2hvdWxkIGJlIHRoZSAn
cG9zJywgd2hpY2ggaXMNCj4+IGxhcmdlciB0aGFuIGJvdGggdGhlIGN1cnJlbnQgaW5vZGUgc2l6
ZSBhbmQgcGFnZW9mcy4NCj4+IA0KPj4gU2ltaWxhcmx5LCB0aGUgY29kZSBpbmNvcnJlY3RseSBz
ZXRzIHRoZSBpbnRlcm5hbCBqZmZzMl9yYXdfaW5vZGUtPmRzaXplIHRvDQo+PiB0aGUgZGlmZmVy
ZW5jZSBiZXR3ZWVuIHRoZSBwYWdlb2ZzIG1pbnVzIGN1cnJlbnQgaW5vZGUgc2l6ZTsgaW5zdGVh
ZCBpdA0KPj4gc2hvdWxkIGJlIHRoZSBjdXJyZW50IHBvcyBtaW51cyB0aGUgY3VycmVudCBpbm9k
ZSBzaXplLiAgRmluYWxseSwNCj4+IGlub2RlLT5pX3NpemUgd2FzIGFsc28gc2V0IGluY29ycmVj
dGx5Lg0KPj4gDQo+PiBUaGUgcGF0Y2ggYmVsb3cgZml4ZXMgdGhpcyBidWcuICBUaGUgYnVnIHdh
cyBkaXNjb3ZlcmVkIHVzaW5nIGEgbmV3IHRvb2wNCj4+IGZvciBmaW5kaW5nIGYvcyBidWdzIHVz
aW5nIG1vZGVsIGNoZWNraW5nLCBjYWxsZWQgTUNGUyAoTW9kZWwgQ2hlY2tpbmcgRmlsZQ0KPj4g
U3lzdGVtcykuDQo+PiANCj4+IFNpZ25lZC1vZmYtYnk6IFlpZmVpIExpdSA8eWlmZWxpdUBjcy5z
dG9ueWJyb29rLmVkdT4NCj4+IFNpZ25lZC1vZmYtYnk6IEVyZXogWmFkb2sgPGV6a0Bjcy5zdG9u
eWJyb29rLmVkdT4NCj4+IFNpZ25lZC1vZmYtYnk6IE1hbmlzaCBBZGthciA8bWFka2FyQGNzLnN0
b255YnJvb2suZWR1Pg0KPj4gLS0tDQo+PiBmcy9qZmZzMi9maWxlLmMgfCAxNSArKysrKysrLS0t
LS0tLS0NCj4+IDEgZmlsZSBjaGFuZ2VkLCA3IGluc2VydGlvbnMoKyksIDggZGVsZXRpb25zKC0p
DQo+PiANCj4+IGRpZmYgLS1naXQgYS9mcy9qZmZzMi9maWxlLmMgYi9mcy9qZmZzMi9maWxlLmMN
Cj4+IGluZGV4IGJhODZhY2JlMTJkMy4uMDQ3OTA5NmI5NmU0IDEwMDY0NA0KPj4gLS0tIGEvZnMv
amZmczIvZmlsZS5jDQo+PiArKysgYi9mcy9qZmZzMi9maWxlLmMNCj4+IEBAIC0xMzcsMTkgKzEz
NywxOCBAQCBzdGF0aWMgaW50IGpmZnMyX3dyaXRlX2JlZ2luKHN0cnVjdCBmaWxlICpmaWxwLCBz
dHJ1Y3QgYWRkcmVzc19zcGFjZSAqbWFwcGluZywNCj4+ICAgc3RydWN0IGpmZnMyX2lub2RlX2lu
Zm8gKmYgPSBKRkZTMl9JTk9ERV9JTkZPKGlub2RlKTsNCj4+ICAgc3RydWN0IGpmZnMyX3NiX2lu
Zm8gKmMgPSBKRkZTMl9TQl9JTkZPKGlub2RlLT5pX3NiKTsNCj4+ICAgcGdvZmZfdCBpbmRleCA9
IHBvcyA+PiBQQUdFX1NISUZUOw0KPj4gLSAgICB1aW50MzJfdCBwYWdlb2ZzID0gaW5kZXggPDwg
UEFHRV9TSElGVDsNCj4+ICAgaW50IHJldCA9IDA7DQo+PiANCj4+ICAgamZmczJfZGJnKDEsICIl
cygpXG4iLCBfX2Z1bmNfXyk7DQo+PiANCj4+IC0gICAgaWYgKHBhZ2VvZnMgPiBpbm9kZS0+aV9z
aXplKSB7DQo+PiAtICAgICAgICAvKiBNYWtlIG5ldyBob2xlIGZyYWcgZnJvbSBvbGQgRU9GIHRv
IG5ldyBwYWdlICovDQo+PiArICAgIGlmIChwb3MgPiBpbm9kZS0+aV9zaXplKSB7DQo+PiArICAg
ICAgICAvKiBNYWtlIG5ldyBob2xlIGZyYWcgZnJvbSBvbGQgRU9GIHRvIG5ldyBwb3NpdGlvbiAq
Lw0KPj4gICAgICAgc3RydWN0IGpmZnMyX3Jhd19pbm9kZSByaTsNCj4+ICAgICAgIHN0cnVjdCBq
ZmZzMl9mdWxsX2Rub2RlICpmbjsNCj4+ICAgICAgIHVpbnQzMl90IGFsbG9jX2xlbjsNCj4+IA0K
Pj4gLSAgICAgICAgamZmczJfZGJnKDEsICJXcml0aW5nIG5ldyBob2xlIGZyYWcgMHgleC0weCV4
IGJldHdlZW4gY3VycmVudCBFT0YgYW5kIG5ldyBwYWdlXG4iLA0KPj4gLSAgICAgICAgICAgICAg
KHVuc2lnbmVkIGludClpbm9kZS0+aV9zaXplLCBwYWdlb2ZzKTsNCj4+ICsgICAgICAgIGpmZnMy
X2RiZygxLCAiV3JpdGluZyBuZXcgaG9sZSBmcmFnIDB4JXgtMHgleCBiZXR3ZWVuIGN1cnJlbnQg
RU9GIGFuZCBuZXcgcG9zaXRpb25cbiIsDQo+PiArICAgICAgICAgICAgICAodW5zaWduZWQgaW50
KWlub2RlLT5pX3NpemUsICh1aW50MzJfdClwb3MpOw0KPj4gDQo+PiAgICAgICByZXQgPSBqZmZz
Ml9yZXNlcnZlX3NwYWNlKGMsIHNpemVvZihyaSksICZhbGxvY19sZW4sDQo+PiAgICAgICAgICAg
ICAgICAgICAgIEFMTE9DX05PUk1BTCwgSkZGUzJfU1VNTUFSWV9JTk9ERV9TSVpFKTsNCj4+IEBA
IC0xNjksMTAgKzE2OCwxMCBAQCBzdGF0aWMgaW50IGpmZnMyX3dyaXRlX2JlZ2luKHN0cnVjdCBm
aWxlICpmaWxwLCBzdHJ1Y3QgYWRkcmVzc19zcGFjZSAqbWFwcGluZywNCj4+ICAgICAgIHJpLm1v
ZGUgPSBjcHVfdG9famVtb2RlKGlub2RlLT5pX21vZGUpOw0KPj4gICAgICAgcmkudWlkID0gY3B1
X3RvX2plMTYoaV91aWRfcmVhZChpbm9kZSkpOw0KPj4gICAgICAgcmkuZ2lkID0gY3B1X3RvX2pl
MTYoaV9naWRfcmVhZChpbm9kZSkpOw0KPj4gLSAgICAgICAgcmkuaXNpemUgPSBjcHVfdG9famUz
MihtYXgoKHVpbnQzMl90KWlub2RlLT5pX3NpemUsIHBhZ2VvZnMpKTsNCj4+ICsgICAgICAgIHJp
LmlzaXplID0gY3B1X3RvX2plMzIoKHVpbnQzMl90KXBvcyk7DQo+PiAgICAgICByaS5hdGltZSA9
IHJpLmN0aW1lID0gcmkubXRpbWUgPSBjcHVfdG9famUzMihKRkZTMl9OT1coKSk7DQo+PiAgICAg
ICByaS5vZmZzZXQgPSBjcHVfdG9famUzMihpbm9kZS0+aV9zaXplKTsNCj4+IC0gICAgICAgIHJp
LmRzaXplID0gY3B1X3RvX2plMzIocGFnZW9mcyAtIGlub2RlLT5pX3NpemUpOw0KPj4gKyAgICAg
ICAgcmkuZHNpemUgPSBjcHVfdG9famUzMigodWludDMyX3QpcG9zIC0gaW5vZGUtPmlfc2l6ZSk7
DQo+PiAgICAgICByaS5jc2l6ZSA9IGNwdV90b19qZTMyKDApOw0KPj4gICAgICAgcmkuY29tcHIg
PSBKRkZTMl9DT01QUl9aRVJPOw0KPj4gICAgICAgcmkubm9kZV9jcmMgPSBjcHVfdG9famUzMihj
cmMzMigwLCAmcmksIHNpemVvZihyaSktOCkpOw0KPj4gQEAgLTIwMiw3ICsyMDEsNyBAQCBzdGF0
aWMgaW50IGpmZnMyX3dyaXRlX2JlZ2luKHN0cnVjdCBmaWxlICpmaWxwLCBzdHJ1Y3QgYWRkcmVz
c19zcGFjZSAqbWFwcGluZywNCj4+ICAgICAgICAgICBnb3RvIG91dF9lcnI7DQo+PiAgICAgICB9
DQo+PiAgICAgICBqZmZzMl9jb21wbGV0ZV9yZXNlcnZhdGlvbihjKTsNCj4+IC0gICAgICAgIGlu
b2RlLT5pX3NpemUgPSBwYWdlb2ZzOw0KPj4gKyAgICAgICAgaW5vZGUtPmlfc2l6ZSA9IHBvczsN
Cj4+ICAgICAgIG11dGV4X3VubG9jaygmZi0+c2VtKTsNCj4+ICAgfQ0KPj4gDQo+PiAtLSANCj4+
IDIuMjUuMQ0KPj4gDQo+PiANCj4+IF9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fXw0KPj4gTGludXggTVREIGRpc2N1c3Npb24gbWFpbGluZyBsaXN0
DQo+PiBodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LW10
ZC8NCg==
