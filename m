Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D61C575AA6
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jul 2022 06:55:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229801AbiGOEtq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jul 2022 00:49:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229765AbiGOEto (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jul 2022 00:49:44 -0400
Received: from na01-obe.outbound.protection.outlook.com (mail-bgr052101064008.outbound.protection.outlook.com [52.101.64.8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD5E73C156;
        Thu, 14 Jul 2022 21:49:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TV45UeEEtOU2fMVIdSEnyQRVVBEq4qlOnT+TiBUrTMNknaRwXhmJtbelEPAxcN65tUYyvVpBV6n/W9m0ypwYGCOp9OiKPOTOhQM62Lk64F7Kd5/C/4vyYsd2zl8gebryKtsjZE+SqNp0rVmiI4099o0OwL6btL/Eiw79FvZys5SM2RUzINhZu4zSMoMS8lfBnfUWHctID4kRfyStp9HjpmtJd9G0J+KRDjLhsUgtqUdkw4y1Drhd7qWqmVzUPU6RFQxZJjjTei5ri+08lzH6O8ZpBI++5Rf9HmUoPEJc2J5UFQ2LSysVyClMZG+6sGqCr2XOGG9//qya/PkV4Rs+CQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6d/wRUwLE6e2ThHyqniyzDFvwdBvlZEgz6+iDZz6qVo=;
 b=M8LlEIwRVwVn8Dh7VSRHykUrhLq/9+YEVwRS2lnnD3qKbEhxABlCAUK2euxH50CfGGFhGFQynJSu7ZQLF97um0seOcBocwckfD2PgNa2i+9VR7Tbr+R+ZrswjGOR+fumA2cwA3qEm76M+3fjsRzzVf3ltJMPnYoPWArUY748l5c/MjZ75zKhLg7lKpN/qDVP3eCWZbkKGNBbkGdLBv1odXlv+p4qrjzvRyJDFs44sytpYo1S5TXhkXpljtW+gE+ExYt26JPpYGRvionBtyvaOH//8dEKEu3SCq6Ns6vokpPgRt8gSgZ9wrHfgkhesJyItKxCFNsc0Dk69XSD7J+F1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vmware.com; dmarc=pass action=none header.from=vmware.com;
 dkim=pass header.d=vmware.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6d/wRUwLE6e2ThHyqniyzDFvwdBvlZEgz6+iDZz6qVo=;
 b=NHXqCzzKSxSRG+amn8nx3Zwz32iIIyIZRREGqKemJCnlm8neEhaXPG7MAkbtnk9VOrQzDsw9vJl4XBrOyXk5kM1eRsTXcv+3uaFfM/fGzwcoufe0lD90ym2mazPeJbHqd1OFZxADisBM6WQYc5l8krj32XCuYo86YDLyUI7ZrvM=
Received: from SA1PR05MB8311.namprd05.prod.outlook.com (2603:10b6:806:1e2::19)
 by BY5PR05MB7170.namprd05.prod.outlook.com (2603:10b6:a03:1bd::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.10; Fri, 15 Jul
 2022 04:49:36 +0000
Received: from SA1PR05MB8311.namprd05.prod.outlook.com
 ([fe80::4841:cc3c:63a9:28c2]) by SA1PR05MB8311.namprd05.prod.outlook.com
 ([fe80::4841:cc3c:63a9:28c2%6]) with mapi id 15.20.5438.013; Fri, 15 Jul 2022
 04:49:36 +0000
From:   Ankit Jain <ankitja@vmware.com>
To:     Juri Lelli <juri.lelli@redhat.com>
CC:     "srivatsa@csail.mit.edu" <srivatsa@csail.mit.edu>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Sharan Turlapati <sturlapati@vmware.com>,
        Him Kalyan Bordoloi <bordoloih@vmware.com>,
        Keerthana Kalyanasundaram <keerthanak@vmware.com>,
        Anish Swaminathan <anishs@vmware.com>,
        Srivatsa Bhat <srivatsab@vmware.com>
Subject: Re: [PATCH] sched/deadline: Fix BUG_ON condition for deboosted tasks
Thread-Topic: [PATCH] sched/deadline: Fix BUG_ON condition for deboosted tasks
Thread-Index: AQHYlv/naTAeq6v5SkONmwFBTShmLq19eIcAgAFmCIA=
Date:   Fri, 15 Jul 2022 04:49:36 +0000
Message-ID: <D5F4086A-AD87-4CCB-B926-25713BBF00ED@vmware.com>
References: <20220713075014.411739-1-juri.lelli@redhat.com>
 <806a86d3-5204-145e-af46-023bf0142aa8@csail.mit.edu>
 <Ys/FiJ3tgc0CYDcu@localhost.localdomain>
In-Reply-To: <Ys/FiJ3tgc0CYDcu@localhost.localdomain>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vmware.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e2b0f654-9956-43f4-b812-08da661d6b5d
x-ms-traffictypediagnostic: BY5PR05MB7170:EE_
x-ld-processed: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: M6IALffwBPo3NtDuJ0MnZm07GP06/clJ4ATDxR87+u03O5jr4jzLJYnxrlXfxdHOCUgHJ40NPINagBbM4JSqO0OY3XRAitZI1MOf1oSwT9pGURRqNkIaeP3JUnntvWSzqneEgs8ex4BLxF95gOtAPfsmEXSXmACOpWyvBsIWjblEAu7nFQRg3Svm/bpir7mJyXSsn0aLCvwB8P5/Aqha0rDkHAC5Lm9JeARUlgRZBuQAxT59jvfevU1W6UGnHAphkfMgpuMJ78Fq9XrIgslPSr1cRYT9vxQwCtl4TF706ErEU+lVq5bRijNJEERFgueJJPYcYQi0cszOS5tk3DHYZvoIkFhIUTAZy9ERS6ZbGaT8PzrFaJT0LI62kCYJZD54+3SEh3FCKpg209TdLdBieeSHJX9uboFLMob6wpyGXtfgv1+rhv8pJTdG8rluMgQio4YePS72sZIWBswA99BnqzXYh0gcUpx3Uepy1COIWwYwHlH0HdDWxNW6vR4obLez7jJXRt57y53Y+XqwCzW8p0xO3pkZpqoxW8W/DY55o00eBzFvzM2nnP/+A7n2m3BhiSmUO0YtYmRvkFZJPYw5ld2FsLlivlotUmbwBGq8GVpH+j/C3qeiv82rtXcfa2L8ukmx01Twz8sbR+1jFz/7hps961KX3gy1ODx2maFLBIFlVfQiTY4kxNpVw21iqL0BoBhkRX3paw52iyneJuxy68cZTjEtDIMmLQodDJYJQefhxd+WpWpZ6PBG/mIhnSlB0RG1ircAyVQjgw9ki0xyK8Sq1p0G5xwVFvvk/sT/Ga81zNZpiAbavbnPqCvzv3yYafRFn+qVJRQOACpSxvDiBKjFc3lP4gkKwbWO+RnvnXc=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR05MB8311.namprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(376002)(346002)(136003)(366004)(39860400002)(396003)(71200400001)(186003)(66446008)(83380400001)(41300700001)(6512007)(76116006)(8676002)(6506007)(64756008)(53546011)(91956017)(26005)(66556008)(66946007)(38100700002)(2906002)(54906003)(6916009)(2616005)(36756003)(33656002)(122000001)(4326008)(478600001)(66476007)(5660300002)(107886003)(7416002)(8936002)(38070700005)(316002)(86362001)(45080400002)(6486002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VFcrTFpMaHZNLy93Z29BTENMNmZKR2tVTlkzdEN3TE9hTnVmdjRPQWlrUUNo?=
 =?utf-8?B?WCttYUFnVFc3MDlZdm9lL09aWkxNWmlyRGZVWHUxa3VKY3JpRmlLaGllK2xS?=
 =?utf-8?B?QXFnd3A5MlMzekRibFcrZXJReGFUMnhWOWk2TXMvWE5LZkhaWVRtRzE2SjFr?=
 =?utf-8?B?bGd0SVRqbnZPREZpbHN3a05PeXF3ZFZpNkp6NFcya2JYRjhMM25aSnNoRTFi?=
 =?utf-8?B?TkVQMEs3QlB2UVFsUXRkN00zMW5QTXBJS2k4ckZWcXVHeFVadWVON0xIMEdI?=
 =?utf-8?B?ZHFyTWhXWHBvN09lb3huU2JxQk0xbUc0UUoxVGFheWVrNVowSHBFZmpjWFZD?=
 =?utf-8?B?c05KZkZpL2lkM1RvaE9tWmtjUHVmd0dDZ3ZVd2tjTUxNdGwweTh1THRYZnZI?=
 =?utf-8?B?TysrNXBMY0FKSUVMNjN2YWJNampXUisyLytMdmhhOUkwY3lpejJtWEJJSWJH?=
 =?utf-8?B?OXI4d09iUFJCOGRpRXZnWnpOTzBLd01paTg3VTFOaWxaaTg3cU02Q0srYU9R?=
 =?utf-8?B?a3R3R2Z1SnhFcEpVSXZycGFrUGRIY0dvZkk1OWl5U3RoU0NUaFUwd00wV1Vk?=
 =?utf-8?B?amdVUjV6amZtUFVPQzZkYnRuSkZyN1JBNk9RSU9RYXlOSE1talI5UU1GRTRi?=
 =?utf-8?B?cTdTUjVlU0h6QWF2a1puekZxdmEydFBDcEV2c25xdjIraVA5aG9BNE1YVllj?=
 =?utf-8?B?L0d5ODZmbGY2UTJRaTNUYWVJOHEwYUlxeUJXb3VlQTg3WVhOekRxQW84NitR?=
 =?utf-8?B?SVpmaGVlcDJCRXl3Wkd4M01LZ2IwN00zQzFGWWJHZEZYN2NmUlpqcS9kNlMw?=
 =?utf-8?B?N3lzSHJ4czltL1I4WHRnV3o3SnJTem5HODYwMG4yemw2ZFZOazVOblhFM0ZK?=
 =?utf-8?B?YlQ0cWFnR3hQTWVYcFQ2M2p0Tk9LRURYUERickJuTm1NRDJGNlAxQlBmRS9L?=
 =?utf-8?B?NnVtQTlmTUIzczNnYkdNTksrZkN5ZFhIVHR2MFhYSk5xazBiU0VPRWVDKy9O?=
 =?utf-8?B?RGZDTmtqRFZTNjdNRjdXMDEyajErY2R2OEZsZzA2MHdmWlB5OTZwNUc0TGVa?=
 =?utf-8?B?aXMvdVo2UW9MWTczWFpib1RhcTRGRGVRSjZvVEVRMzVqQ3lvNVowdld4VU5S?=
 =?utf-8?B?eDJuM0lOSkJQT09mcFFlTkY4YzVTTUExUkJwb3JIb1pNV2V2OWRqRUsyLzJO?=
 =?utf-8?B?Sk13YzVPR0dmV1BmMkhGdHJTZXZUNG5VbWNFWEkxN3ZDUXBZbVc1MHRwZE5E?=
 =?utf-8?B?cUl5RXdoaTVrcmtkMzlLMnNPUHNqWjI0d2lud2pJWXhKaTlPeExOYUkxTEV1?=
 =?utf-8?B?RzV1TE8vc3R0WTJrYkR1Ri9lUDN3VHR5MGViMHNnR1ZIaDRuTm1GMTB1aW5z?=
 =?utf-8?B?WTZqQS9Yb01mNzZhejJDMVh4QzNlM3ZOQS9aZnhNS1oxL2hwR3RJb1ZXRGs4?=
 =?utf-8?B?d2d2SlFQNEl4dUVtREJhUFMwUXRvaVV6QmR6dGxQQUtqN0hPZ3U4RURBTThX?=
 =?utf-8?B?ZVVva1VZRXBud0Ntd0RZUTNiZmlOeGJNbjlZblhocVhFMElmSUN1bzBZYXFu?=
 =?utf-8?B?UlhZcVN5SG9iQ0c3RVlCUWZReUN3YlVjV1BUSmJQRlA3VHJhWnRRb2t3V1F1?=
 =?utf-8?B?aStKMDVWbG9QMGM1SWdSU25BaWhSU0cvUmNweE93OU4xdWdlbzk2SEhkWXA4?=
 =?utf-8?B?MjVST3QxakdmTUVDdnJHdlY2ZW5jS29XZXJJdlBmRFZ2Sk5LZUtUN282VnNY?=
 =?utf-8?B?WmNWOTN3dkhJMGFEZ1YwZFVVQ1RaV2xTZjNzR0FNUlZxdE5DRk53ZFFiTVJY?=
 =?utf-8?B?SWdSUDVPTmpXR0xlZWJmaVdEekQvSGhSRU12aFdzcnNDanRJWXptV3RPY1g5?=
 =?utf-8?B?SG1iYVZPZVV1cDc3SjJRczJVV0VnSWh3dGxrbHcrZWdUZFc2ZG9ZZ2RFTnNm?=
 =?utf-8?B?cG96TmFHM0xmZ1p2Z3NEaDBiaStPZHNmOXhoVVRNWWdZOHJiVGhrS05aV3l0?=
 =?utf-8?B?dTNKT0wvVXlZemZDQklGTWF2YW4xcHZlVEh6RktCdmYwUHRJdlEwa3hVVFI5?=
 =?utf-8?B?S0J4V0JnMVlGQ01DelBCSVNNNW50SHFiSjI5eEZOMlhuY0dNd0tyVVNDUnl4?=
 =?utf-8?B?NFVuZHZkdDJwcFQ0UVpsdXl1Yzk5TTlsVTdpcmNRdnNKbjhGSUNTZnk1VXRC?=
 =?utf-8?B?Z2c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <FBF6DA1B985E4E4D950CF3CB87E97D4B@namprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR05MB8311.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e2b0f654-9956-43f4-b812-08da661d6b5d
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jul 2022 04:49:36.7422
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HzMZtc2lxmSpeBYk9JtBBInbo1ran7QbKXKARFK3h/gD88lFe8c/ZbLOfYr/W4daDXOniWdWld36RAD8Bp7WSA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR05MB7170
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

W1Jlc2VuZGluZyBteSBwcmV2aW91cyBlbWFpbCBpbiBwbGFpbnRleHRdDQoNCj4gT24gMTQtSnVs
LTIwMjIsIGF0IDEyOjU4IFBNLCBKdXJpIExlbGxpIDxqdXJpLmxlbGxpQHJlZGhhdC5jb20+IHdy
b3RlOg0KPiANCj4g4pqgIEV4dGVybmFsIEVtYWlsDQo+IA0KPiBIaSwNCj4gDQo+IE9uIDEzLzA3
LzIyIDE0OjMxLCBTcml2YXRzYSBTLiBCaGF0IHdyb3RlOg0KPj4gDQo+PiBIaSBKdXJpLA0KPj4g
DQo+PiBPbiA3LzEzLzIyIDEyOjUwIEFNLCBKdXJpIExlbGxpIHdyb3RlOg0KPj4+IFRhc2tzIHRo
ZSBhcmUgYmVpbmcgZGVib29zdGVkIGZyb20gU0NIRURfREVBRExJTkUgbWlnaHQgZW50ZXINCj4+
PiBlbnF1ZXVlX3Rhc2tfZGwoKSBvbmUgbGFzdCB0aW1lIGFuZCBoaXQgYW4gZXJyb25lb3VzIEJV
R19PTiBjb25kaXRpb246DQo+Pj4gc2luY2UgdGhleSBhcmUgbm90IGJvb3N0ZWQgYW55bW9yZSwg
dGhlIGlmIChpc19kbF9ib29zdGVkKCkpIGJyYW5jaCBpcw0KPj4+IG5vdCB0YWtlbiwgYnV0IHRo
ZSBlbHNlIGlmICghZGxfcHJpbykgaXMgYW5kIGluc2lkZSB0aGlzIG9uZSB3ZQ0KPj4+IEJVR19P
TighaXNfZGxfYm9vc3RlZCksIHdoaWNoIGlzIG9mIGNvdXJzZSBmYWxzZSAoQlVHX09OIHRyaWdn
ZXJlZCkNCj4+PiBvdGhlcndpc2Ugd2UgaGFkIGVudGVyZWQgdGhlIGlmIGJyYW5jaCBhYm92ZS4g
TG9uZyBzdG9yeSBzaG9ydCwgdGhlDQo+Pj4gY3VycmVudCBjb25kaXRpb24gZG9lc24ndCBtYWtl
IHNlbnNlIGFuZCBhbHdheXMgbGVhZHMgdG8gdHJpZ2dlcmluZyBvZiBhDQo+Pj4gQlVHLg0KPj4+
IA0KPj4+IEZpeCB0aGlzIGJ5IG9ubHkgY2hlY2tpbmcgZW5xdWV1ZSBmbGFncywgcHJvcGVybHk6
IEVOUVVFVUVfUkVQTEVOSVNIIGhhcw0KPj4+IHRvIGJlIHByZXNlbnQsIGJ1dCBhZGRpdGlvbmFs
IGZsYWdzIGFyZSBub3QgYSBwcm9ibGVtLg0KPj4+IA0KPj4+IEZpeGVzOiAyMjc5ZjU0MGVhN2Qg
KCJzY2hlZC9kZWFkbGluZTogRml4IHByaW9yaXR5IGluaGVyaXRhbmNlIHdpdGggbXVsdGlwbGUg
c2NoZWR1bGluZyBjbGFzc2VzIikNCj4+IA0KPj4gSXQgbG9va3MgbGlrZSB0aGlzIHByb2JsZW0g
Z29lcyBmdXJ0aGVyIGJhY2sgdGhhbiB0aGUgYWJvdmUgY29tbWl0DQo+PiAod2hpY2ggd2FzIG1l
cmdlZCBpbiB2NS4xMCkuDQo+PiANCj4+IEV2ZW4gdGhlIG9sZGVzdCBMVFMga2VybmVsICg0Ljkp
IGhhcyBjb2RlIGxpa2UgdGhpczoNCj4+IA0KPj4gaWYgKC4uLiAmJiBwLT5kbC5kbF9ib29zdGVk
ICYmIC4uLikpIHsNCj4+ICAgICAgLyogY29kZSAqLw0KPj4gDQo+PiB9IGVsc2UgaWYgKCFkbF9w
cmlvKHAtPm5vcm1hbF9wcmlvKSkgew0KPj4gDQo+PiAgICAgIEJVR19PTighcC0+ZGwuZGxfYm9v
c3RlZCB8fCBmbGFncyAhPSBFTlFVRVVFX1JFUExFTklTSCk7DQo+PiAgICAgIHJldHVybjsNCj4+
IH0NCj4+IA0KPj4gQW5kIHdlIGhhdmUgb2JzZXJ2ZWQgY3Jhc2hlcyBpbiB0aGUgNC4xOSBrZXJu
ZWwgc2VyaWVzIHRvbyAoQ0MnZWQNCj4+IEFua2l0IEphaW4gYW5kIEhpbSBLYWx5YW4gd2hvIGhh
dmUgcmVwcm9kdWNlZCB0aGlzIGlzc3VlKS4NCj4+IA0KPj4gSSBiZWxpZXZlIGNvbW1pdCA2NGJl
NmYxZjVmNzEgKCJzY2hlZC9kZWFkbGluZTogRG9uJ3QgcmVwbGVuaXNoIGZyb20gYQ0KPj4gIVND
SEVEX0RFQURMSU5FIGVudGl0eSIpIGludHJvZHVjZWQgdGhlIHByb2JsZW0sIHdoaWNoIGRhdGVz
IGJhY2sgdG8NCj4+IHYzLjE4Lg0KPj4gDQo+PiBXb3VsZCB5b3UgbWluZCB1cGRhdGluZyB0aGUg
Rml4ZXM6IHRhZyBhbmQgYWRkaW5nIGEgQ0M6IHN0YWJsZSB0YWcgYXMNCj4+IHdlbGwsIHdoZW4g
eW91IHJlc3BpbiB0aGUgcGF0Y2gsIHBsZWFzZT8NCj4gDQo+IEkgdGhpbmsgeW91IGFyZSByaWdo
dC4gV2lsbCBkby4NCj4gDQo+IFRoYW5rcyBmb3IgdGFraW5nIGEgbG9vayENCj4gDQo+IEJlc3Qs
DQo+IEp1cmkNCj4gDQoNCkhpIEp1cmksDQoNCkkgdHJpZWQgdGhlIHBhdGNoIGJ1dCBpdCBzdGls
bCBoaXQgdGhlIEJVR19PTi4NCg0KWyAgMTYzLjA5NDA5NF0gLS0tLS0tLS0tLS0tWyBjdXQgaGVy
ZSBdLS0tLS0tLS0tLS0tDQpbICAxNjMuMDk0MDk1XSBrZXJuZWwgQlVHIGF0IGtlcm5lbC9zY2hl
ZC9kZWFkbGluZS5jOjE1MjUhDQpbICAxNjMuMDk0MTAzXSBpbnZhbGlkIG9wY29kZTogMDAwMCBb
IzFdIFBSRUVNUFQgU01QIFBUSQ0KWyAgMTYzLjA5NDEwNV0gQ1BVOiAwIFBJRDogNTQ5NCBDb21t
OiBzdGFsbGQvMzQgTm90IHRhaW50ZWQgNC4xOS4yNDctcnQxMDgtMTAucGgzLXJ0ICMxLXBob3Rv
bg0KWyAgMTYzLjA5NDEwN10gSGFyZHdhcmUgbmFtZTogVk13YXJlLCBJbmMuIFZNd2FyZSBWaXJ0
dWFsIFBsYXRmb3JtLzQ0MEJYIERlc2t0b3AgUmVmZXJlbmNlIFBsYXRmb3JtLCBCSU9TIDYuMDAg
MDcvMDMvMjAxOA0KWyAgMTYzLjA5NDExM10gUklQOiAwMDEwOmVucXVldWVfdGFza19kbCsweDM1
ZC8weDlkMA0KWyAgMTYzLjA5NDExNV0gQ29kZTogODMgYzQgMTAgNWIgNDEgNWMgNDEgNWQgNDEg
NWUgNDEgNWYgNWQgYzMgOGIgNTYgNzQgODUgZDIgMGYgODggOTEgZmQgZmYgZmYgODAgYTYgMGMg
MDMgMDAgMDAgZmUgNDEgODMgZTUgMjAgMGYgODUNClsgIDE2My4wOTQxMTZdIFJTUDogMDAxODpm
ZmZmOWI5Mjg2NTM3ZTQwIEVGTEFHUzogMDAwMTAwNDYNClsgIDE2My4wOTQxMThdIFJBWDogZmZm
ZmZmZmY4NDBiZGVkMCBSQlg6IGZmZmY4ZGRhMDdjNDgwMDAgUkNYOiAwMDAwMDAwMDAwMDAyMDAw
DQpbICAxNjMuMDk0MTE5XSBSRFg6IDAwMDAwMDAwMDAwMDAwNzggUlNJOiBmZmZmOGRkYTA3YzQ4
MDAwIFJESTogZmZmZjhkZGRiNzlhODdjMA0KWyAgMTYzLjA5NDEyMF0gUkJQOiBmZmZmOWI5Mjg2
NTM3ZTc4IFIwODogMDAwMDAwMDAwMDAwMDAwMCBSMDk6IDAwMDAwMDAwMDAwMDAwN2YNClsgIDE2
My4wOTQxMjFdIFIxMDogZmZmZjliOTI4NjUzN2U2OCBSMTE6IDAwMDAwMDAwMDAwMDAwMDAgUjEy
OiBmZmZmOWI5Mjg2NTM3ZWYwDQpbICAxNjMuMDk0MTIxXSBSMTM6IDAwMDAwMDAwMDAwMDAwMDAg
UjE0OiBmZmZmOGRkZGI3OWE4N2MwIFIxNTogZmZmZjhkZGEwN2M0ODJiOA0KWyAgMTYzLjA5NDEy
M10gRlM6ICAwMDAwN2Y4MWEyN2U0NzAwKDAwMDApIEdTOmZmZmY4ZGRiYjc2MDAwMDAoMDAwMCkg
a25sR1M6MDAwMDAwMDAwMDAwMDAwMA0KWyAgMTYzLjA5NDEyNF0gQ1M6ICAwMDEwIERTOiAwMDAw
IEVTOiAwMDAwIENSMDogMDAwMDAwMDA4MDA1MDAzMw0KWyAgMTYzLjA5NDEyNV0gQ1IyOiAwMDAw
N2Y4NWU2Y2ZjNGMwIENSMzogMDAwMDAwMDIzMzc0NDAwNCBDUjQ6IDAwMDAwMDAwMDA3NjA2YjAN
ClsgIDE2My4wOTQxNzZdIERSMDogMDAwMDAwMDAwMDAwMDAwMCBEUjE6IDAwMDAwMDAwMDAwMDAw
MDAgRFIyOiAwMDAwMDAwMDAwMDAwMDAwDQpbICAxNjMuMDk0MTc3XSBEUjM6IDAwMDAwMDAwMDAw
MDAwMDAgRFI2OiAwMDAwMDAwMGZmZmUwZmYwIERSNzogMDAwMDAwMDAwMDAwMDQwMA0KWyAgMTYz
LjA5NDE3N10gUEtSVTogNTU1NTU1NTQNClsgIDE2My4wOTQxNzhdIENhbGwgVHJhY2U6DQpbICAx
NjMuMDk0MTgzXSAgPyBkZXF1ZXVlX3Rhc2tfZGwrMHgzOC8weDFkMA0KWyAgMTYzLjA5NDE4OF0g
IF9fc2NoZWRfc2V0c2NoZWR1bGVyKzB4MmUyLzB4OGUwDQpbICAxNjMuMDk0MTkxXSAgX194NjRf
c3lzX3NjaGVkX3NldGF0dHIrMHg3NC8weGIwDQpbICAxNjMuMDk0MTk0XSAgZG9fc3lzY2FsbF82
NCsweDYwLzB4MWIwDQpbICAxNjMuMDk0MjAwXSAgZW50cnlfU1lTQ0FMTF82NF9hZnRlcl9od2Zy
YW1lKzB4NDQvMHhhOQ0KWyAgMTYzLjA5NDIwMV0gUklQOiAwMDMzOjB4N2Y4MWI2ZmZlMzE5DQpb
ICAxNjMuMDk0MjAyXSBDb2RlOiAwMCBmMyBjMyA2NiAyZSAwZiAxZiA4NCAwMCAwMCAwMCAwMCAw
MCAwZiAxZiA0MCAwMCA0OCA4OSBmOCA0OCA4OSBmNyA0OCA4OSBkNiA0OCA4OSBjYSA0ZCA4OSBj
MiA0ZCA4OSBjOCA0YyA4YiA0Yw0KWyAgMTYzLjA5NDIwM10gUlNQOiAwMDJiOjAwMDA3ZjgxYTI3
ZTNlMjggRUZMQUdTOiAwMDAwMDIwNiBPUklHX1JBWDogMDAwMDAwMDAwMDAwMDEzYQ0KWyAgMTYz
LjA5NDIwNV0gUkFYOiBmZmZmZmZmZmZmZmZmZmRhIFJCWDogMDAwMDAwMDAwMDAwMTUwYSBSQ1g6
IDAwMDA3ZjgxYjZmZmUzMTkNClsgIDE2My4wOTQyMDVdIFJEWDogMDAwMDAwMDAwMDAwMDAwMCBS
U0k6IDAwMDA3ZjgxYTI3ZTNlNTAgUkRJOiAwMDAwMDAwMDAwMDAxNTBhDQpbICAxNjMuMDk0MjA2
XSBSQlA6IDAwMDAwMDAwMDAwMDE1MGEgUjA4OiAwMDAwMDAwMDAwMDAwMDAwIFIwOTogMDAwMDAw
MDAwMDAwMDAzMA0KWyAgMTYzLjA5NDIwN10gUjEwOiAwMDAwN2Y4MGYwMDAyMDkwIFIxMTogMDAw
MDAwMDAwMDAwMDIwNiBSMTI6IDAwMDA1NTYzMDZkZTdhMjANClsgIDE2My4wOTQyMDhdIFIxMzog
MDAwMDAwMDAwMDAwMDAwMiBSMTQ6IDAwMDA1NTYzMDZiYTM1NzAgUjE1OiAwMDAwN2Y4MWEyN2U0
NzAwDQpbICAxNjMuMDk0MjEwXSBNb2R1bGVzIGxpbmtlZCBpbjogaXB0X01BU1FVRVJBREUgbmZf
Y29ubnRyYWNrX25ldGxpbmsgbmZuZXRsaW5rIHhmcm1fdXNlciB4ZnJtX2FsZ28geHRfYWRkcnR5
cGUgYnJfbmV0ZmlsdGVyIGJyaWRnZSBzdHANClsgIDE2My4wOTk1MTJdIC0tLVsgZW5kIHRyYWNl
IDAwMDAwMDAwMDAwMDAwMDIgXS0tLSANCg0KDQpJbiBlbnF1ZXVlX3Rhc2tfZGwoKToNCg0KfSBl
bHNlIGlmICghZGxfcHJpbyhwLT5ub3JtYWxfcHJpbykpIHsNCiAg4oCmDQogIEJVR19PTighKGZs
YWdzICYgRU5RVUVVRV9SRVBMRU5JU0gpKTsNCiAgcmV0dXJuOw0KfQ0KDQpJIG9ic2VydmUgZmxh
Z3MgdmFsdWUgYXMgKEVOUVVFVUVfUkVTVE9SRSB8ICBFTlFVRVVFX05PQ0xPQ0spDQoNCg0KVGhh
bmtzLA0KQW5raXQNCg0K
