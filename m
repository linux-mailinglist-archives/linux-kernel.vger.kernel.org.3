Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EC1055DFA4
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:31:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232667AbiF0HHj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 03:07:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232593AbiF0HHf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 03:07:35 -0400
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on2088.outbound.protection.outlook.com [40.107.113.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AACFB5F8C
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 00:07:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XIXmUYk3bHVAwZl+dqZBT8uHA2jB4SHnMEQaj39Iy3fIokZhP/9EcYHpuezHCJo2nKG0kESxABHmsIXL/pfouPpx0wyTr+SmLo1y8k6MQ4W+GLkQyi4WqZZSV8TMUIQxO/gW2WcjdcCvUAHZRntId53bPXSowJA2TAiyYTCBYA1GQp3SyGc0XH9JlF7L5ye7lp8IuCXfQtDdRgxLVBX7whVg5l38ZDfkD5jqIGw2AYPt5cABdpd9xwcVLO3520pqsI1qMyugqiGzSch0jH6bi4NclZyR8WJc+yIH74OJdNA4x4tQVWj0spi5SXM3QRS0iIVOub7n2xxX7Aj2ZxSgfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=93IJwSQO5voGjUCEIdXobnUR8sy5HPvDR0Um4MIzrlI=;
 b=arxFv96CXsqAIYATaV1sqwSTAy5YhVl3FDtlWxg11RYC+IGsu0eZ2MKTn7YVA4pLa4ztKLrW3m0Nd40DwXarx1799UWii4ado5BJprSMysMELT7LPaUNSOlSi4lNZwUYqh0uKJ40++eR/RDqCTuMI93bwa39BxgRZhH6k3eKPNbVO77rJin4DZYQ41kQSBI1MPyASza9R7WyFyHvWtT0zgoKL8Bo+u5jdi4hW2DPEU+Bpy1mmo3gsqxm21NKJ1KEAILik3b794/J45/k7BFB+NgWoSUI81hDpVPKsfR23RHHw/yC9cGIH8cIq8G+9Q5QnKP1le8qPvBdcgqg/Zstcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nec.com; dmarc=pass action=none header.from=nec.com; dkim=pass
 header.d=nec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nec.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=93IJwSQO5voGjUCEIdXobnUR8sy5HPvDR0Um4MIzrlI=;
 b=dqeGD4qXDOsThJRaN1T5h66vK7NNv957yQt0eJ+XXNrXMLHzDSYraAvPyv59Qg9bsPbO5KKBkI2Gaf/y5ZQXV+HP0Lrs+1GXNqHDJ9bK/hhvuS4QZ8Hu3b8A4j3f1JHe5UJse/Ifv7foKnoWXeh9C9IEJaPVFOqyC3M2k98fx1M=
Received: from TYWPR01MB8591.jpnprd01.prod.outlook.com (2603:1096:400:13c::10)
 by TYAPR01MB3952.jpnprd01.prod.outlook.com (2603:1096:404:c7::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.15; Mon, 27 Jun
 2022 07:07:31 +0000
Received: from TYWPR01MB8591.jpnprd01.prod.outlook.com
 ([fe80::5d07:3dbc:2b8c:d836]) by TYWPR01MB8591.jpnprd01.prod.outlook.com
 ([fe80::5d07:3dbc:2b8c:d836%7]) with mapi id 15.20.5373.018; Mon, 27 Jun 2022
 07:07:31 +0000
From:   =?utf-8?B?SE9SSUdVQ0hJIE5BT1lBKOWggOWPo+OAgOebtOS5nyk=?= 
        <naoya.horiguchi@nec.com>
To:     Mike Kravetz <mike.kravetz@oracle.com>
CC:     Naoya Horiguchi <nao.horiguchi@gmail.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Liu Shixin <liushixin2@huawei.com>,
        Yang Shi <shy828301@gmail.com>,
        Oscar Salvador <osalvador@suse.de>,
        Muchun Song <songmuchun@bytedance.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 3/9] mm/hugetlb: make pud_huge() and huge_pud() aware
 of non-present pud entry
Thread-Topic: [PATCH v2 3/9] mm/hugetlb: make pud_huge() and huge_pud() aware
 of non-present pud entry
Thread-Index: AQHYh1xVdMLvq+UuwkSi6Bx3h6yk0q1fPt6AgAObigA=
Date:   Mon, 27 Jun 2022 07:07:31 +0000
Message-ID: <20220627070730.GD2159330@hori.linux.bs1.fc.nec.co.jp>
References: <20220623235153.2623702-1-naoya.horiguchi@linux.dev>
 <20220623235153.2623702-4-naoya.horiguchi@linux.dev>
 <YrZQeWnjQlWSjP3b@monkey>
In-Reply-To: <YrZQeWnjQlWSjP3b@monkey>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nec.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8b7fe39e-f6d3-4745-220d-08da580bb3db
x-ms-traffictypediagnostic: TYAPR01MB3952:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: QfDwIbRkEzpdo7csZHvfGeGnXL1Tjpo2vOaxwPVsQE2jxvkFrrqX2b+DsA3RJeW7Pixdzn24jdjRSsQa86rxQMjUu7/vEIRUhiZoTaOYc6/lkMCf2e693SJXU8cY4BNcofk6PA4Q4LyAAp/xPitxS7OAQG1fUnBrRJjOH7t4/OxDBcuLj/kL6JhXy+3M2Hsot6WMxthj2StRPJzRBlr4yGt70q5bJ4EFMDwJCpuSJ6Zky/eQ1vS46f2oZJvc1wxBIkzofvbUoIaiUmt0NeIoaa78yu6obEMuWAg6t4WpNztukSHbEedBwHWwVDrdNyGzQR5aS0eurhEslG+WRXYrtpwhPZc8Vq0swGzxMI5k7aC/MNySE+4A1RPCPKhGzsSKrF2xc5FKrem8ccpFH5PU5/RjXEmKKWZyD8FuGyJf/hb0/4e0oRRWWREvJItS2RqrzhdMYDqay+AsK3sA4Bzj8HpF/6TYjZSggwFTvhf/uw4HiitSg9ZjaMoa2WD9bbtV8F+AweEYa7I4AnAqbVUMkCnrt+aP1rlxdkU9uM5BGHyrDbeopy36EghDYCZyIvg1YmvPqaFPz2lRlbTlClbEYo8L6nD9q9SECMxzVHHphR0SSIaXTs/KaGNX4XuWMEtBhUZv2lr80I0BVDi7v9Yf4HGIoxEQPE/BnJkl4+EyozQvUZxW7APZpedcyfnnxd1y5yJommd8rWnwQBazRVVnd1UmBgvWvxqrFcIlpnR/9V8l7MP+NtSp6Dh86NifEkRcLOLZYzcVssdqGIPiOml7SFLLnEeE9bobY5mHsGnXMFgof4l1iWfM70LTvttoljJm
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYWPR01MB8591.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(346002)(366004)(376002)(39860400002)(396003)(136003)(9686003)(53546011)(41300700001)(8936002)(76116006)(316002)(66476007)(6512007)(82960400001)(6486002)(38070700005)(6506007)(66946007)(1076003)(186003)(66556008)(122000001)(55236004)(85182001)(83380400001)(86362001)(2906002)(8676002)(5660300002)(7416002)(478600001)(71200400001)(54906003)(64756008)(66446008)(6916009)(4326008)(33656002)(38100700002)(26005)(14583001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NFREUzVvbmd6Vy9TQWNXUUN4M2VrblphaDV3cFEwanVxa3B4YnJlb3hoL3NS?=
 =?utf-8?B?bXQ1QnlGOEt3Y3lFY04yUSs2bVFYMHF0TnB2RVRPZk5RSURIdW9ZV3Y4SGFL?=
 =?utf-8?B?eWFiNWcyVkFXcFY5U2RLZitzRzdiNWNBT3JrVTJMMjNBbEkwN3pFUXh6Q3da?=
 =?utf-8?B?b2hXTjdQaEZ3c3BlVWMrdmFFWDFNNjFkU01LZlZNWGxxYzVuTHFqVkVDS1Nr?=
 =?utf-8?B?bExBMzZMZ082NFROVTQ3Ym43ejRTODdZK2pCRnd4OE1FNW84bTdmdzNPRmhC?=
 =?utf-8?B?Y3VaellLSlNTakdQV3YvU2lrcTY5QXd3Q1JuTXVpam9kMnQrRk43bnBPN3Jp?=
 =?utf-8?B?Q2RzcnJha3pLTnQ5LzhVVUUxSGIrTWtXZUVnQmFKNUQ0K0ZLMzRMYnhRaE52?=
 =?utf-8?B?amg0ZktiSlZWL1FEQUR5OXpaL3l5ZXptZlVwRzZhMVN2SHZmb2kvMDZ2dmh3?=
 =?utf-8?B?Z21lN21kNXdZVXpVM3JXLzhHWlpISHdZc1lTUzBCNVVyTHBtZkxjWmZJazM4?=
 =?utf-8?B?cURub01qa05HZjMxRmF4TmwyN0M2SGdsbXNCbE1OVVBsTDJVMHNncmFQVERq?=
 =?utf-8?B?VHJUZ2FpU1NrMCthWWd6aGY2RnZ3Z0krOVo2cjV2VHNBWHVxbUlLL3FPMVY0?=
 =?utf-8?B?Z09WMkVSWjVQa0Faa3JWLzR2U29YcWIzR2c4Z3pyVkJDbTRtbEljRENSOUYv?=
 =?utf-8?B?WWdnM3h3UHBmb3VKS3E5R01MenNaclVheHk5UVVieWFlWGU5YXdKL25pSnJN?=
 =?utf-8?B?V0dvRFpsUGJON0hlZjNsZXdRT25JS3pVZG5NUzY5YllKZ2FvdFpYMVdTR1ky?=
 =?utf-8?B?ZDIrNGRZVVpCaWJFZjVSdUJwSXQxb2dTWFlJUzJTNFBMOXdBa29ndXgwanA5?=
 =?utf-8?B?MlNuL1M0VE1wSmdNRC9lbDdTaU90OWNNSWNITGpEZnJQSTVWL0owRTJENTBh?=
 =?utf-8?B?ZUJ1aEVwSHlBMFZCbERxUm9vLy83a21WS3VucnI5dGNUdzEzamFFY1BGSUd4?=
 =?utf-8?B?dGRvUHJmWEtUOWx4Q2NGYjkwQ3lMWWVsdVI1UFh4d1hHUmVnQ1gydksrc0k5?=
 =?utf-8?B?ZFE0TGdFMnpOZjg4VXNaL2thN1hBdW15MUJzanFKS1JWbFdlc2lteUhLVWNU?=
 =?utf-8?B?VExacnNETzNnWElhNXpuOE5oVk1hc0pneHMyRm1jVXJjR2Y2YTJLOVlSU0ww?=
 =?utf-8?B?OW1GZHZ5aHE1YXdHVDVKR1RjTk8yMG8vVkpPdHZpVEtlSVVpcEo4NXFGc0hL?=
 =?utf-8?B?TTR5eEkyR1Fkcit3dng1akkzZVJiSUU1aFN5ZVFQaGIyKzQ5YnhKOTMzSm8x?=
 =?utf-8?B?bWtmRWc4eEZsdDBkdElEelphMjdXcHBKbXZQRFVERkY0NGlRSUJmeWRxSHhR?=
 =?utf-8?B?eWVERHRVRTJ6NXlwRTZVMWx2TDBrT0FBZ2tPVU9qSXlNQXMwc2tNS3pReXpT?=
 =?utf-8?B?MHVYMWxRVFIyMi8wS3BpL1p6YVhEaS9MYzQxWDQzK2Z1M0J3SCtzVjB5WGhW?=
 =?utf-8?B?MHdmbkFnRnlZc2Erb01iblBQT2x0OXBka2x3S2FqbUh6cTV4Nm5sRkFaclg4?=
 =?utf-8?B?K3FicFA2SUlxRitqdkhIQlc3dFFxWDY4dmFnT1FCSE5xZVpVRXJVaXRYZjNU?=
 =?utf-8?B?TU5MMlAwc1F0UENFbWdnaHFWdGtzcjB5SWd1aldIVEZ3QnRycVAvdEc4aGha?=
 =?utf-8?B?ZkhaTEhDQXRQd1J4Z0trbGJ1c29qK09rM3RZVVhiczRsTXRUdzJONUVVVnVl?=
 =?utf-8?B?K1J4OE5hSmU0SXREM2o1NFpRRld1d2ZTSlRTU1l1MWROekw5cXk0c3RsVzIz?=
 =?utf-8?B?VHl0MzljdXVMRFF2YnpyUXdBNW5lV3FRdWtuRXJIbERqVVpKMmhtZVNIbGI5?=
 =?utf-8?B?QW40MklUZXdzeXZacnc3NE05UFBaOElRSDg2bzZHUFlOWVM4Z2JINmFJdGFh?=
 =?utf-8?B?eFhZd2d5ZnNMTGZKL0MzYmE5ZjJ6RkQ1QVB0dUFQcTFJbzdLbUlLaEJZd2FT?=
 =?utf-8?B?MUREWVhQYjhSVzRiWitrTTZXazdTRWQvS3VTalNESVRCbVdlZUZnS1JpQ0FN?=
 =?utf-8?B?enFOc0M1SUIyd3B0ZTN2bnZIRk0yeC9PUkRqbUkrZlR2WHNsbmQyUkdwVlE5?=
 =?utf-8?B?dFpBYS8rZTUxSlhoNFpuQWI1N3dsMFh3dEhrWUhEUUR6OFcyYVk0by9PYXNK?=
 =?utf-8?B?UHc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <7CF292973DFB314AB56DFFB43F3F20B6@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nec.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYWPR01MB8591.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b7fe39e-f6d3-4745-220d-08da580bb3db
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jun 2022 07:07:31.1401
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e67df547-9d0d-4f4d-9161-51c6ed1f7d11
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KCl0IuDhvxtUZKw4EBZgE/9vMW628iOxUfWCWguU6P7sMHaO8BDBem2D4PEZ4Y8W202ta9wd0lT2XYhJER14iw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR01MB3952
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gRnJpLCBKdW4gMjQsIDIwMjIgYXQgMDU6MDI6MDFQTSAtMDcwMCwgTWlrZSBLcmF2ZXR6IHdy
b3RlOg0KPiBPbiAwNi8yNC8yMiAwODo1MSwgTmFveWEgSG9yaWd1Y2hpIHdyb3RlOg0KPiA+IEZy
b206IE5hb3lhIEhvcmlndWNoaSA8bmFveWEuaG9yaWd1Y2hpQG5lYy5jb20+DQo+ID4gDQo+ID4g
Zm9sbG93X3B1ZF9tYXNrKCkgZG9lcyBub3Qgc3VwcG9ydCBub24tcHJlc2VudCBwdWQgZW50cnkg
bm93LiAgQXMgbG9uZyBhcw0KPiA+IEkgdGVzdGVkIG9uIHg4Nl82NCBzZXJ2ZXIsIGZvbGxvd19w
dWRfbWFzaygpIHN0aWxsIHNpbXBseSByZXR1cm5zDQo+ID4gbm9fcGFnZV90YWJsZSgpIGZvciBu
b24tcHJlc2VudF9wdWRfZW50cnkoKSBkdWUgdG8gcHVkX2JhZCgpLCBzbyBubyBzZXZlcmUNCj4g
PiB1c2VyLXZpc2libGUgZWZmZWN0IHNob3VsZCBoYXBwZW4uICBCdXQgZ2VuZXJhbGx5IHdlIHNo
b3VsZCBjYWxsDQo+ID4gZm9sbG93X2h1Z2VfcHVkKCkgZm9yIG5vbi1wcmVzZW50IHB1ZCBlbnRy
eSBmb3IgMUdCIGh1Z2V0bGIgcGFnZS4NCj4gPiANCj4gPiBVcGRhdGUgcHVkX2h1Z2UoKSBhbmQg
aHVnZV9wdWQoKSB0byBoYW5kbGUgbm9uLXByZXNlbnQgcHVkIGVudHJpZXMuICBUaGUNCj4gPiBj
aGFuZ2VzIGFyZSBzaW1pbGFyIHRvIHByZXZpb3VzIHdvcmtzIGZvciBwdWQgZW50cmllcyBjb21t
aXQgZTY2ZjE3ZmY3MTc3DQo+ID4gKCJtbS9odWdldGxiOiB0YWtlIHBhZ2UgdGFibGUgbG9jayBp
biBmb2xsb3dfaHVnZV9wbWQoKSIpIGFuZCBjb21taXQNCj4gPiBjYmVmODQ3OGJlZTUgKCJtbS9o
dWdldGxiOiBwbWRfaHVnZSgpIHJldHVybnMgdHJ1ZSBmb3Igbm9uLXByZXNlbnQgaHVnZXBhZ2Ui
KS4NCj4gPiANCj4gPiBTaWduZWQtb2ZmLWJ5OiBOYW95YSBIb3JpZ3VjaGkgPG5hb3lhLmhvcmln
dWNoaUBuZWMuY29tPg0KPiA+IC0tLQ0KPiA+ICBhcmNoL3g4Ni9tbS9odWdldGxicGFnZS5jIHwg
IDMgKystDQo+ID4gIG1tL2h1Z2V0bGIuYyAgICAgICAgICAgICAgfCAyNiArKysrKysrKysrKysr
KysrKysrKysrKysrLQ0KPiA+ICAyIGZpbGVzIGNoYW5nZWQsIDI3IGluc2VydGlvbnMoKyksIDIg
ZGVsZXRpb25zKC0pDQo+IA0KPiBUaGFua3MuICBPdmVyYWxsIGxvb2tzIGdvb2Qgd2l0aCB0eXBv
cyBjb3JyZWN0ZWQgdGhhdCB5b3UgYWxyZWFkeSBub3RpY2VkLg0KPiBPbmUgcXVlc3Rpb24gYmVs
b3cuDQo+ID4gDQo+ID4gZGlmZiAtLWdpdCBhL2FyY2gveDg2L21tL2h1Z2V0bGJwYWdlLmMgYi9h
cmNoL3g4Ni9tbS9odWdldGxicGFnZS5jDQo+ID4gaW5kZXggYTBkMDIzY2I0MjkyLi41ZmI4NmZi
NDliYTggMTAwNjQ0DQo+ID4gLS0tIGEvYXJjaC94ODYvbW0vaHVnZXRsYnBhZ2UuYw0KPiA+ICsr
KyBiL2FyY2gveDg2L21tL2h1Z2V0bGJwYWdlLmMNCj4gPiBAQCAtNzAsNyArNzAsOCBAQCBpbnQg
cG1kX2h1Z2UocG1kX3QgcG1kKQ0KPiA+ICANCj4gPiAgaW50IHB1ZF9odWdlKHB1ZF90IHB1ZCkN
Cj4gPiAgew0KPiA+IC0JcmV0dXJuICEhKHB1ZF92YWwocHVkKSAmIF9QQUdFX1BTRSk7DQo+ID4g
KwlyZXR1cm4gIXB1ZF9ub25lKHB1ZCkgJiYNCj4gPiArCQkocHVkX3ZhbChwdWQpICYgKF9QQUdF
X1BSRVNFTlR8X1BBR0VfUFNFKSkgIT0gX1BBR0VfUFJFU0VOVDsNCj4gPiAgfQ0KPiA+ICAjZW5k
aWYNCj4gPiAgDQo+ID4gZGlmZiAtLWdpdCBhL21tL2h1Z2V0bGIuYyBiL21tL2h1Z2V0bGIuYw0K
PiA+IGluZGV4IGY1OWY0M2MwNjYwMS4uYjdhZTVmNzNmM2IyIDEwMDY0NA0KPiA+IC0tLSBhL21t
L2h1Z2V0bGIuYw0KPiA+ICsrKyBiL21tL2h1Z2V0bGIuYw0KPiA+IEBAIC02OTQ2LDEwICs2OTQ2
LDM0IEBAIHN0cnVjdCBwYWdlICogX193ZWFrDQo+ID4gIGZvbGxvd19odWdlX3B1ZChzdHJ1Y3Qg
bW1fc3RydWN0ICptbSwgdW5zaWduZWQgbG9uZyBhZGRyZXNzLA0KPiA+ICAJCXB1ZF90ICpwdWQs
IGludCBmbGFncykNCj4gPiAgew0KPiA+ICsJc3RydWN0IHBhZ2UgKnBhZ2UgPSBOVUxMOw0KPiA+
ICsJc3BpbmxvY2tfdCAqcHRsOw0KPiA+ICsJcHRlX3QgcHRlOw0KPiA+ICsNCj4gPiAgCWlmIChm
bGFncyAmIChGT0xMX0dFVCB8IEZPTExfUElOKSkNCj4gPiAgCQlyZXR1cm4gTlVMTDsNCj4gPiAg
DQo+ID4gLQlyZXR1cm4gcHRlX3BhZ2UoKihwdGVfdCAqKXB1ZCkgKyAoKGFkZHJlc3MgJiB+UFVE
X01BU0spID4+IFBBR0VfU0hJRlQpOw0KPiA+ICtyZXRyeToNCj4gPiArCXB0bCA9IGh1Z2VfcHRl
X2xvY2soaHN0YXRlX3NpemVsb2coUFVEX1NISUZUKSwgbW0sIChwdGVfdCAqKXB1ZCk7DQo+ID4g
KwlpZiAoIXB1ZF9odWdlKCpwdWQpKQ0KPiA+ICsJCWdvdG8gb3V0Ow0KPiA+ICsJcHRlID0gaHVn
ZV9wdGVwX2dldCgocHRlX3QgKilwdWQpOw0KPiA+ICsJaWYgKHB0ZV9wcmVzZW50KHB0ZSkpIHsN
Cj4gPiArCQlwYWdlID0gcHVkX3BhZ2UoKnB1ZCkgKyAoKGFkZHJlc3MgJiB+UFVEX01BU0spID4+
IFBBR0VfU0hJRlQpOw0KPiA+ICsJCWlmIChXQVJOX09OX09OQ0UoIXRyeV9ncmFiX3BhZ2UocGFn
ZSwgZmxhZ3MpKSkgew0KPiANCj4gVGhlIGNhbGwgdG8gdHJ5X2dyYWJfcGFnZSgpIHNlZW1zIGEg
Yml0IHN0cmFuZ2Ugc2luY2UgZmxhZ3Mgd2lsbCBub3QgaW5jbHVkZQ0KPiBGT0xMX0dFVCB8IEZP
TExfUElOIGFzIHRlc3RlZCBhYm92ZS4gIElzIHRyeV9ncmFiX3BhZ2UoKSBhbHdheXMgZ29pbmcg
YmUgYQ0KPiBub29wIGhlcmU/DQoNClRoYW5rcywgeW91J3JlIHJpZ2h0LiAgImZsYWdzICYgKEZP
TExfR0VUIHwgRk9MTF9QSU4pIiBjaGVjayBzaG91bGQgYmUNCnVwZGF0ZWQuICBQcm9iYWJseSBp
dCdzIHRvIGJlIGFsaWduZWQgdG8gd2hhdCBmb2xsb3dfaHVnZV9wbWQoKSBjaGVja3MgZmlyc3Qu
DQoNClRoYW5rcywNCk5hb3lhIEhvcmlndWNoaQ0KDQo+IA0KPiAtLSANCj4gTWlrZSBLcmF2ZXR6
DQo+IA0KPiA+ICsJCQlwYWdlID0gTlVMTDsNCj4gPiArCQkJZ290byBvdXQ7DQo+ID4gKwkJfQ0K
PiA+ICsJfSBlbHNlIHsNCj4gPiArCQlpZiAoaXNfaHVnZXRsYl9lbnRyeV9taWdyYXRpb24ocHRl
KSkgew0KPiA+ICsJCQlzcGluX3VubG9jayhwdGwpOw0KPiA+ICsJCQlfX21pZ3JhdGlvbl9lbnRy
eV93YWl0KG1tLCAocHRlX3QgKilwdWQsIHB0bCk7DQo+ID4gKwkJCWdvdG8gcmV0cnk7DQo+ID4g
KwkJfQ0KPiA+ICsJfQ0KPiA+ICtvdXQ6DQo+ID4gKwlzcGluX3VubG9jayhwdGwpOw0KPiA+ICsJ
cmV0dXJuIHBhZ2U7DQo+ID4gIH0NCj4gPiAgDQo+ID4gIHN0cnVjdCBwYWdlICogX193ZWFrDQo+
ID4gLS0gDQo+ID4gMi4yNS4xDQo+ID4g
