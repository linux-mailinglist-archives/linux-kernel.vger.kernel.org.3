Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFD06580714
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jul 2022 00:07:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236900AbiGYWH0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jul 2022 18:07:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236905AbiGYWHX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jul 2022 18:07:23 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10olkn2025.outbound.protection.outlook.com [40.92.40.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D178C22BD9
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jul 2022 15:07:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Bc3tJ2yspX6BzO8OFhabVVniGsqlAKOJNfce49BwQzTQNBO3QUzE5XSdDuKuzuvUJ+lg6+E3fdq/U7E+3Qr3cYXKkJZ+1WCCJItopik6GKtWtdFtzQj53rLDKo6kZZjrtnHx+bgAXqKS19yQc668yBFafpNlatW61FcUF+9Lsjlh+osXHKcDV8LDKil9kYBSCrk/k4pFkh0aDhhA2YUcLRmtmjMRyrmnOl/D1LD2cONVtudtM7KoxuPVyDLPsTdPRCnKwgH1/G0kF6iRdx/XND1N/BQFtPqP1qedCwGNCkaPkaxUKI4twtDqZzkwFPnVq7XpJ/v6KWn+YRgTHNA89Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cQJo1SHHKfT1ehQNuc7nJiv4go4Lp7N42aTvyJDGHDk=;
 b=N25ASobymh6SSlj7qQXjpuP4Jtb0H8fJGzkIzaquWszstgm+ZAhv7ApZ72kSCfyusyy+OXTkSMbn8zJqgDs+lfq5JL2u8rR+pQJP8LNjkzFuM0HnDFPlxicXAt64bxzt3tR5jpE/2auPYiw4vvrySYW/pXSah70F2yISZxXbGJEVIHqr+/LUeeyE9DLE0qaRcvnVoFBFjBqmnEQgL9HtVnAx9Vm9MHbQ5tueLCdVEOW6kjYoj/IfCnfSswLJf1YLjp8Wi+XmslQjU4ZO9n53dPQm1jezzq2HVhyMl11MGQJwIFd55kFal4WXlYQaX2UVNJtzHPbpI+yxGePEAtSlJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cQJo1SHHKfT1ehQNuc7nJiv4go4Lp7N42aTvyJDGHDk=;
 b=nFZxMirHRBcd3guMr+6si5pcvK0QmjqJyCEPifN6BkRGckt0V8iDbac9a+HSt7z+knLdO15vB8lSV2t4ODhSQZRCrsVblaLhwuiTUVoauDbPP9+2zNYsnoRudlJ1BKJuhgZp798G00mN8nDYdP384yyeeXe3C5jvZN1ub+c01+Y4Q2sQrLwsz7jik9hHc9iUI1B9JI3rSygj7DlLPRxzMsjC9ZSFUC6VViXlWEdBByLkzV9oquPYJtl6tIKfWouCedGh8rz+I3RCZFNXxzydqHEVw8uxgxkunyKXxXaG/vY91fFzpMkj779Xpug/hPeTQo4D2y2zcaOr90fQKTqMYw==
Received: from MN2PR17MB3375.namprd17.prod.outlook.com (2603:10b6:208:13c::25)
 by MWHPR1701MB1791.namprd17.prod.outlook.com (2603:10b6:301:24::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.26; Mon, 25 Jul
 2022 22:07:18 +0000
Received: from MN2PR17MB3375.namprd17.prod.outlook.com
 ([fe80::3409:88f8:6069:ccba]) by MN2PR17MB3375.namprd17.prod.outlook.com
 ([fe80::3409:88f8:6069:ccba%3]) with mapi id 15.20.5458.024; Mon, 25 Jul 2022
 22:07:18 +0000
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
Thread-Index: AQHYn+OlL8EDeVsAXEe8Sw4ix6TwWa2OiB5VgAEU05eAAAkWvg==
Date:   Mon, 25 Jul 2022 22:07:17 +0000
Message-ID: <MN2PR17MB3375CA88F933233FC8126784B8959@MN2PR17MB3375.namprd17.prod.outlook.com>
References: <20220725045830.11502-1-yifeliu@cs.stonybrook.edu>
 <MN2PR17MB337506A10F6AF87BBC514F97B8959@MN2PR17MB3375.namprd17.prod.outlook.com>
 <MN2PR17MB33751E0A2DFD72AA5E774DF5B8959@MN2PR17MB3375.namprd17.prod.outlook.com>
In-Reply-To: <MN2PR17MB33751E0A2DFD72AA5E774DF5B8959@MN2PR17MB3375.namprd17.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-tmn:  [9vmAYNnJu2dDoeEHU0FSheK6ZvhCtHgZH1eINUEQ2W+LuwVD+9IIeGHR7b1sTwMt]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: bb3253ca-6edc-496a-a9d4-08da6e8a0a15
x-ms-traffictypediagnostic: MWHPR1701MB1791:EE_
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: aTrlUxQYVzwUkrB/lHWpUZ55oh/3isbFKZTZ1x2q/YeVbC6gPpPdcwVzE09XGEhQ1ccecA8uAwLGba/Kb4W6yUWDxEy7SGZr41X9yYtz3l43zOscvoBqlfCol6kfVJQJ0OwwpcQr9lWuLNz8HlBh/aEvk2xrqdMnAlJM//0kfvKBc9oqqLflfIqKmfqo78aiJgXreGHykH2CbEKEeXm7ne0d8Phi2qf+DScEbc7L9s7hvlFPAvhdzDLFKAWtR5oXnYuNtkqNTq8jUQET3rF+kCpGQXP5mJhxy1hhk4KbjSwYpkKl1OL3sJhwN5LNSbOQNpLsy1fT8g8UQUCjsj2YlO4R199H6vA7CBIxfPHk/WhpA8bOKs/RWwkh4bT/FtrPHMepmhhgsuF6iPp8q5sehX4HfAaces3xuuwZWxbZu5pzbWprGIT8jEK0q223gAJF9KmNMm8uYJVYYJ2KATT9z/sDjHzB7172N6ECGogoQcBRUB0XLeBbXTCvSDogdj0U8sC5jWs2OFAw3ryFU4MgYes9epdXOdUCQVNAMyhUSP7WSPS3y7p2ZI5NOlrit9TVvw6CD9kDKTtrOLt3eVh+A3J1Dq6Ic8BZzbH5XFY2jn8sJO1i9+04ceRvKFsD21qtx/hhjr9Sd9myPksn2PyOHra0shcrSC6DVaEB//J5P+0Ge0CWRsL51Pk7ReZHRIM9
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ckhZWHZjRjJoYmJVV0k0OG16aGZXU2hDQzhwL0oyRkpsd0xUU0d2Y2R1UG9I?=
 =?utf-8?B?YXJoY0JEUk9hYkhNZmUzWWg0RGUya1BNWnExbmZxcTFwejkrMm9aQlNzWnRw?=
 =?utf-8?B?NmJ1eElCSHBuck80REtqSVA1Z25FcU5SRUZzOXROeWhKOXl2RmFNYlFGRHJS?=
 =?utf-8?B?NWNPM1lmNlVKb29iN0VCSkorYmdHZFpqMzlmNytqVTdxK2NSbi8rS1Z2b3h5?=
 =?utf-8?B?RFVrb3g4aEdtMWZuY0R5VEZCYWlzaHNmSWJUSGhPN2o0dUNtU010WWxKbTh0?=
 =?utf-8?B?MlpiSmFGSnFOblJwbjlaQ1Q3UDZhbGtjVlN2NzJTMlBOSzVvaHRhZlZlS3cy?=
 =?utf-8?B?TEE5di9ocCsrSkJBMTFTZkMrYjBIbW1LaVpLcndtb015OGdNamwwREZQNUdE?=
 =?utf-8?B?ZWwvMHJTcFV3Tkt2dUxEYUZpTnR0dGgwaERlejFBZWNZNlRqSzRiYU92bk5H?=
 =?utf-8?B?T3RBenRudXU0eU5wTmh3RlBjNkRnQitPOWtDMmF1MmNuNHlnbldYVkI0eWZn?=
 =?utf-8?B?NUlvcWFBOHFUU2hRR2hJSys3Z2FKK0gvdU5KdmJDSDhVUXJPZDBRQmNBK2Vi?=
 =?utf-8?B?RU4rT2tyUWx6VlNGemxZQUJhOXk5T2diQjNpaW8xZWxibTRIQ3BMdkxjNTRy?=
 =?utf-8?B?bUNybVdlQmRkb3FOQk9OZmpsWTJqL09wajh4RlF0SGNvQ1NScEhUakVTUCtk?=
 =?utf-8?B?Z21Mc29seGRQMit2aTBZekFvdkRYNEMxRW5vVlhFSGRjaWNPTnpBc2Z5VGdh?=
 =?utf-8?B?SnVLdFRmOERwSVBiNFdhWVptUUpNeU5hR0Y1eUFTZkJuaGJ4citzeHFRS0tB?=
 =?utf-8?B?NEdxUUNKV05tZTdHTkkvemdkeFlENDNTcVRseVlWSVdvbWlSVHVYQTNZejRD?=
 =?utf-8?B?SElCVkxhOE9pUjg2M3NzVjVtWmZ2ZnRCdDJqNjJ5UUhzdXpGVzl5Mk44ZEN2?=
 =?utf-8?B?R3YyaWlnWHIzcXM5ZzU3ZWxxQ2xPWUZQVXJGQVliM3pPSWEyZVFraWFraFVE?=
 =?utf-8?B?QlFiZzZweFhSS3FpSlR2WE0xYmJGSVE5NEpZdWd2dXJMQk01WjI0UmhOaksy?=
 =?utf-8?B?bkkzajBZK3U2dFNIS0psWDkrVHRmRW1PemhiN2lSbXBSeHZCaklkcm5FVE5q?=
 =?utf-8?B?czArTkhtUUVrakorRlNlWkNIQVo2a01PeThCL3FIUy9Ka01KeGwrLy9YS1BU?=
 =?utf-8?B?SHZ2UEQ3eWJIdHlBbjgvMGNjQVhCc3BraURtKzdobkhyR3JsOFlWQ2JrMnow?=
 =?utf-8?B?V1V3MU1BQ3dxRVNjQVZod1o5Z0hueFIxTk1lSnpPYWR1eVphcjJjMUJxeUx5?=
 =?utf-8?B?SWV1d014dHNKaSs2THhkT0E0SUhQZUNWaWwxUDc5RjBDdS82aER1N0hZN2o0?=
 =?utf-8?B?Y3dKTFJia0VUbTEzcnhvU3VpVVMyazBGNGRoQ0J4a1YxYjY1bE9CcVkwNk8x?=
 =?utf-8?B?SFBSZnlWU0hQcGtRVzgrMnk2RExpVHRTd095SUNmQ05TK0JvdlpTSUtvN0ow?=
 =?utf-8?B?Wm40a085c3BKMitWNi9JQ1M2dUFGN3p4MnhNbDdldXlRSzd4SllQb2JLWmtY?=
 =?utf-8?B?Uk16V0FZZXpPRndvR3pCd1IyV3VDMXFxcDl3eE93NFhJdHh5UVpGV2dUcDBT?=
 =?utf-8?B?d1JWUkZJeGMrWnliTXAxVzBibkhaR2dXbEhGbDl3WHJIQ3R5MUFjd2o3Y1Jv?=
 =?utf-8?B?cjVVY29TRjJLVjczaTNabnBKT28vM1JIZDM3OFhZRVhFTDd6TFhrcFdYamhM?=
 =?utf-8?B?dTlZMFBkMFJsQ0VKNTBZTlNwSktCNDYrWERxRzFSc2R3dFJ1SHZxcU9FNS9M?=
 =?utf-8?B?SWlmT2tvODh3RDB1Y2ZvZz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR17MB3375.namprd17.prod.outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: bb3253ca-6edc-496a-a9d4-08da6e8a0a15
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jul 2022 22:07:17.9924
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1701MB1791
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
PiBPbiBKdWwgMjUsIDIwMjIsIGF0IDU6MzcgUE0sIFZhbmVzc2EgUGFnZSA8VmVicGVAb3V0bG9v
ay5jb20+IHdyb3RlOg0KPiANCj4gS29vcPCfmILwn5iC8J+YkfCfmJHwn5iR8J+YjvCfmITwn5iE
8J+YtPCfmLTwn5GA8J+RgPCfkoHwn5mI8J+ZiPCfmYjwn5mI8J+SgfCfkYDwn5GA8J+YkfCfkoHw
n5iB8J+Ys/CfmI7wn5i08J+YkfCfkYDwn5iR8J+YhPCfpKPwn6Sj8J+YgPCfmIPwn5iR8J+YtPCf
mITwn6Sl8J+kq/CfmKXwn5iw8J+ltfCfpbXwn5ih8J+YofCfpKzwn6Sv8J+YrfCfmK3wn5if8J+Y
n/CfpbPwn6Sp8J+luPCfpbjwn6W48J+ZgfCfmKnwn6W64pi577iP8J+Yo/CfmJTwn5iU8J+YlPCf
mJbwn5ij8J+YovCfmKHwn6W28J+YsPCfmLDwn5il8J+YpfCfmLbigI3wn4yr77iP8J+krPCfpKzw
n6Ss8J+kr/CfmLbigI3wn4yr77iP8J+ltvCfmLDwn5iw8J+kq/CfpKvwn5iT8J+kr/CfpK/wn6Sv
DQo+IE9vaWdndmtscG91cmXwn6Ss8J+krPCfpKzwn6Ss8J+krPCfpKzwn6Ss8J+krPCfpKzwn6Ss
8J+kr/CfpK/wn6Sv8J+kr/CfpK/wn6Sv8J+kr/CfpK/wn6Sv8J+kq/CfmJPwn6Ss8J+kr/CfpK/w
n6Ss8J+krPCfmYHwn5iS8J+YjfCfmJLwn5iS8J+YjvCfpbjwn6Sp8J+ls/CfmJ/wn5iW8J+luvCf
mKnwn5ip8J+kqfCfpbPwn6Wz8J+Yn/CfmJbwn5ij8J+ZgfCfmKnimLnvuI/wn5if8J+Yq/CfmKTw
n5it8J+krPCfpKnwn6Sp8J+luPCfmI7wn5mB8J+YqfCfmKHwn5i18J+YqvCfmKfwn6Sl8J+kpfCf
mK/wn5i18J+krvCfmKzwn6Sl8J+Yk/CfpJfwn6SX8J+YtvCfmLLwn6Sk8J+kkPCfpJLwn6SV8J+Y
teKAjfCfkqvwn5i14oCN8J+Sq/CfmLXigI3wn5Kr8J+YteKAjfCfkqvwn5i14oCN8J+Sq/CfmLXi
gI3wn5Kr8J+YteKAjfCfkqvwn5i14oCN8J+Sq/CfmLXigI3wn5Kr8J+YteKAjfCfkqvwn5i14oCN
8J+Sq/CfpJHwn5i88J+YveKYoO+4j/CfkoDwn5KA8J+Ru/Cfkbvwn5G78J+RufCfkbnwn5G68J+R
vfCfkb3wn5KA8J+SgPCfkbvwn5KA8J+SgPCfkoDimKDvuI/imKDvuI/imKDvuI/imKDvuI8NCg==
