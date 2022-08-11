Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67CCA58F5B6
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Aug 2022 04:08:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233559AbiHKCIN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Aug 2022 22:08:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229867AbiHKCIK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Aug 2022 22:08:10 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EE3383F35
        for <linux-kernel@vger.kernel.org>; Wed, 10 Aug 2022 19:08:08 -0700 (PDT)
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27B0p1eZ021784
        for <linux-kernel@vger.kernel.org>; Wed, 10 Aug 2022 19:08:08 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=lZUX2bBqwIv0Lm2p2dVR5dvpAbpPiv+EyrG4EJLFV+4=;
 b=Z7MKBLX8RsNH+ZM482TP0Wn6QIXd5ny0MPEPE89l0rlZyfTo40tGhI4F6aEW9EmNBnMn
 NniKdsp0FwyBhRYCaPjxy7hbiI5YxyGj93WeIn7Kphc3qBsgZWdDKJkj7yyNM7KzRp1e
 GKLi4zJlvO0/7Tp3yrIvBTJf0eGlN8victs= 
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2108.outbound.protection.outlook.com [104.47.55.108])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3hvdb1drxm-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 10 Aug 2022 19:08:08 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lyuTN3ZFTO+n4d4wxta62Ga/9SG0/pKppLsn3WcfGGUYzDEwpAbvxeNnf31nlor2vxffT+fd8CGsA2A91jQZGH2uUQAmL1hd5zYBUNm/hd7vfEEJmQsKJMNVNq+iG0jOQz9vKoxoxJZSM9ZYOsTFLzo4oHD7wSvEiRt9FQHrPn/l8aCM9wXrWoDaNzEEmP7G5XlD/mZ9Mt9ReF96HkkKSzO5AmYWgHWRqFbjldsiwY2/fEJSbK3/bERqVS0pyI+0a2r5qHHdr1CFxIMWCcYaO4bJ5u3BbuLQa8td8SWEMF1LJd0M9jIgWooT6ZrO+ChDPGnc2RTUVTv5q+cD8nKI1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lZUX2bBqwIv0Lm2p2dVR5dvpAbpPiv+EyrG4EJLFV+4=;
 b=X/mxEoPYcYR0jNt1FRzgZdTYBKO1hFJvgBaTaAANUqrRh18zjNpS2Ii8huBzCtyEWsLbEIxG1fDCnyADw7vwSuK2Wo2cBWq8F/xEDceJTT+cXO9RBtToPlfnjhulPP6/BGtpjII5725yakJ9tx1rNYaBGztjD9PLwOZG3hdlGctHVOrx9jYYYod8Dc92zrUx/N/R+73P+vD9ZAiFxis/bhwXMEIIlZsQ1nhc4LnjbIwaVl43iqcjCzB8nBruveVGQUquUSPb5gRUce4lQYV7r2GDhW4/B2RxRulZqLbdBCG8PptmlsM6RoEJ5ZsbaTyIjtuhDS/4WEDcaeaY7MqelA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from CY4PR15MB1781.namprd15.prod.outlook.com (2603:10b6:910:1f::13)
 by BYAPR15MB3446.namprd15.prod.outlook.com (2603:10b6:a03:109::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.20; Thu, 11 Aug
 2022 02:08:05 +0000
Received: from CY4PR15MB1781.namprd15.prod.outlook.com
 ([fe80::351d:e6bc:a9e4:4118]) by CY4PR15MB1781.namprd15.prod.outlook.com
 ([fe80::351d:e6bc:a9e4:4118%12]) with mapi id 15.20.5525.011; Thu, 11 Aug
 2022 02:08:05 +0000
From:   "Alex Zhu (Kernel)" <alexlzhu@fb.com>
To:     Yu Zhao <yuzhao@google.com>
CC:     Yang Shi <shy828301@gmail.com>, Rik van Riel <riel@fb.com>,
        Kernel Team <Kernel-team@fb.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "willy@infradead.org" <willy@infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        Ning Zhang <ningzhang@linux.alibaba.com>,
        Miaohe Lin <linmiaohe@huawei.com>
Subject: Re: [PATCH v3] mm: add thp_utilization metrics to
 /proc/thp_utilization
Thread-Topic: [PATCH v3] mm: add thp_utilization metrics to
 /proc/thp_utilization
Thread-Index: AQHYqPrSmG3WqzybNUurgyMbb9mveq2gpnsAgAAD8ACAAAWRgIAAB5EAgASWfICAAAsqAIABevqAgAABMACAAGoqAIABJd4AgAAB+gCAAAsNgIAAPuUAgAAEtACAACLbgIAAFL6AgAAOzQA=
Date:   Thu, 11 Aug 2022 02:08:04 +0000
Message-ID: <DEB2F4F2-7F62-48F0-914D-5F71BFDBCBEE@fb.com>
References: <20220805184016.2926168-1-alexlzhu@fb.com>
 <Yu1mcD6Jp4fCVEMi@casper.infradead.org>
 <0b16dbac6444bfcdfbeb4df4280354839bfe1a8f.camel@fb.com>
 <Yu1uabedm+NYnnAj@casper.infradead.org>
 <CA8C72B6-E509-4FB0-BEAA-C4368EB7A419@fb.com>
 <CAHbLzkp27aP4JYLPLzv2vtyzVe63bkhuZhw1jnxTF1Buvt4rew@mail.gmail.com>
 <fc108f58a4616d5d7d092a7c1f150069a92ee40c.camel@fb.com>
 <CAHbLzkqpn2ExBJuPD8sYJrEDCUU9=FE3GFh8kL3Bmax0KytKPw@mail.gmail.com>
 <1F8B9D85-A735-4832-AD58-CA4BD474248D@fb.com>
 <CAOUHufbGcuvJ8EfBkWrdCgeMCiceP0SxHZzcJnOt1Mw0P2w9kw@mail.gmail.com>
 <CAHbLzkqGq6LDDSCcFTJW9_O8dfAMje8_W6ddpDP9ESDQWUb07w@mail.gmail.com>
 <F28E23D0-C635-4A49-91EE-100AAA8C9EAD@fb.com>
 <CAOUHufYeuMN9As58BVwMKSN6viOZKReXNeCBgGeeL6ToWGsEKw@mail.gmail.com>
 <868F0874-70E8-4416-B39B-DA74C9D76A40@fb.com>
 <CAOUHufas1o1Ez9EDSjjxsO-w6Ph6Km8R8yOX+1_c=4LvG6DEWw@mail.gmail.com>
 <DD679B3A-BDF7-4EBD-AAC2-A663057AC8E3@fb.com>
 <CAOUHufbD-9PpQ+kuD=-8z-ptsrprjyThpkFe+4_NtFnzAjDG9g@mail.gmail.com>
In-Reply-To: <CAOUHufbD-9PpQ+kuD=-8z-ptsrprjyThpkFe+4_NtFnzAjDG9g@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6087dd2c-5837-47e0-9e3a-08da7b3e53c0
x-ms-traffictypediagnostic: BYAPR15MB3446:EE_
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: s7mcyt9YFwwnW8R45FYREi48+f/Il/E6yPSYRTnHbGt6V+tBxFUNd3yEyM4/qRgn8j8rjGnV//U5Es/WxDB5nehXWAZdGTNu7Yb+2I7LKOxBInQi6Q+QbKc+msgXpZun0Td8R79b/sLEQyIa8hbjmjdX/iEmc1ML3bxQQ3LYhPAC0LggVIPhroLAZhIRaFgsLDvhjAA7j7mQ6hXUULThi1bJ5QmA4M8nq/ES/dBY8iu9go47t+j8DuwuBeRg9xlLRy/ijypUDnlNu23ZLyL+GNogZg6/q9rE6PmItZwxcm+7gmnH2khQcZzHYUesy69oJTh/7viCqwT5gBQlMbvfvQo0p5F5uFH2ZzBKylALnvlYI5TzJGLhhfH9HJoVnJAEujxygYZGNxqLC6x4kRtjJ88Zwai2NhP4HraDN8Ls2eAHSPOhKr+GIcL6U4F2xF6tA4kY5gyFropoqvmZEX3bSLLVrUNeEm/2HOn5UgjQlkRkEbapKQZ519/ouVCqkD0iU22urjQbgecKWhauEfkKM0eIdvQpWhvONB27r7jgUPbKOxpZlW0vG35WZxtxXMxk6c+ItYqjSIRmZmI9diS9mTavkzhIB1P1rVyOctU932TQjjdPWSlS2n2MAY3OfQVD8E0gkmOV5NqUkzX9q5+Lp5ZHhH5t6SEJmQpIw0OfsnyhblbmmNVUYm02x6xH3dnbKX5rrprFTZSvZ+RXy+eWLLgwy1QKeVpRFgfDfY4UNVhvQSp5Ty77hL262jVZuOdN9owpBt9gyzwViWwLi0N8NLqibOgib2vFrif9YIqDYrXy7Ra2P+FJQIoy62GDMlSCnuhD6BH7sIXWbTGUguhsdow7/eFizvUmBDdVP9Bgoq0=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR15MB1781.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(376002)(366004)(136003)(346002)(396003)(39860400002)(53546011)(2906002)(6916009)(2616005)(316002)(186003)(41300700001)(6512007)(36756003)(86362001)(33656002)(54906003)(71200400001)(6486002)(6506007)(966005)(8936002)(66476007)(122000001)(76116006)(66946007)(5660300002)(66446008)(478600001)(66556008)(4744005)(64756008)(8676002)(4326008)(38100700002)(91956017)(38070700005)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?K002SVk0aU90N2hKZ0gzSFlGV0NmTkE4c2FJTE41YlJSWkZtSmVyYjVhbWVw?=
 =?utf-8?B?OEkrU0I1a3hlc2FXT2FCd0V3Q3VTYmxCVnFMUDB2MmdYZ1lZanBhbXpGc0lk?=
 =?utf-8?B?NWZEYTREWWRKeERYd2IrQzB0b1NGTEt3WnBPRmdTQjN3TmxLSVIvRDVhRVhj?=
 =?utf-8?B?b0VrMTJ4MWFWZXJwSU9zR3lSNDBCd015MFp3N2phc1lUREF6ajF6elQ4S1JX?=
 =?utf-8?B?SGV4ZDhRaHJBOWY4N3NiNzBGN3ZtTEhiOGMyTzV0VkJod0hRakcrL0FLdlh3?=
 =?utf-8?B?Y3RoaXFoYnUyRktyY0YzZkkwbTFrOS9Id0FQaEhwM1NZZnRzSnB4dEFTSnhO?=
 =?utf-8?B?WmJPWHZjQ1ZsV05hblNZSStnalJDdDIwR3p4WjVpOFNLVDZ0c2lFeG8yZ0VC?=
 =?utf-8?B?ZjRkWlpYMkdXVWNTN1p5bTZaZ1UzVng3RVJ4R2hUekhDSi80MjdFbmxMV3V1?=
 =?utf-8?B?blBxZXpMQ0dRZlhkRVovYU0xRC91TGJkWDZqVERCdFJpZlhvU3F2OVAyTWR1?=
 =?utf-8?B?WStQWm5CQXRpYXRHRHdlYmgwdDhJZDgvcm13b1JFS2JKeG9jeTQ2dFlueTVI?=
 =?utf-8?B?TmZDZVYzaloyelo4TGhTUVgvN0NtR08yWlczNm1zYzBzUFRXUWx3WXgrT3h5?=
 =?utf-8?B?c3hNcGNjalZGVEduaEd2YmNyL1BockQ2ZnFLam1tbWRHRzgva0hGZ29mbWp0?=
 =?utf-8?B?TVlDQmo4S2NzMUlDbzB0dW54bW5uUzRDOW9hMENjTUZCdnVqUGtZeVdXQ05G?=
 =?utf-8?B?YUVUT1ZPMmkrY2NiRGQ2K0lvZHdZNUNCYnU4VEJ4UnNZMUt3cDE2QWxlbXoy?=
 =?utf-8?B?dzdzaWZIdUg4QkVxY3VRbEVWS2xjanEyS3l4RW5iTmk4RWJmS3hmWGZpZWhv?=
 =?utf-8?B?NnM2NjYrYndPMlJiQlJwZjVWbW1aK0FGRjA3enVmTExwTSt5RXlKRGo4K1Vv?=
 =?utf-8?B?enNSMHN3RE1HTWk5ejgwRlY0dnRLdWtHVjBNNlVNMzFwNi9ZcWJFbTJqdElq?=
 =?utf-8?B?amFiTGVHcXdOeVFnTXYyeGY4cHVka1hZZDQwOGNhTzNCVnM1RWxFNXJnS1FJ?=
 =?utf-8?B?K0FRbjNRMHpLVFI3UVZWdVlKUE5vbHNkSzJPZjYxVE00dWR5MUpqNXIyUERv?=
 =?utf-8?B?MnZoVkxnOXVFNjhkU2NJTjZuanhqbEhSM01qMkZFK29rTWM5QnNRLzJVazFz?=
 =?utf-8?B?SCtQQmtuMVdUMFFLZzlucElMNzVzMGdkdURKbXR5ZG8wU2xXeXZYcThoMW1N?=
 =?utf-8?B?dHJxcVZEWWFrR1llSWU5ZmJ6aWd6cytUNTBlU1BSU3IvYU9LZTQ3ZmhmYTlw?=
 =?utf-8?B?a1d0Tis2a0k1OG9saHNMM3dCNTAzSEFtd2ptRUUyK0JkWWhwdFlxWlFSUkYy?=
 =?utf-8?B?a1p5WUU0bDV6bkNodURUUmh4QmpOeS9BbVVhaEJ6ZEdDcXZlNWNKWExpY3dG?=
 =?utf-8?B?bXlVazNubXo4amh2RlN0cCsxM2dBa2k2emoycWpHVzJOZnlFQ3RtQ2dRdGtL?=
 =?utf-8?B?Zkh5U2J2Z0s4bWNYWGxFZUNaZ2lGVXNpaU5ENWk0MDkwV0Rmb2ZJK1R0MEhL?=
 =?utf-8?B?NHdXZlhaUzdmME9GOGVYZEI1Y3paWW53MWhZUWxGOGViUTF4MXN1VTZsR1pG?=
 =?utf-8?B?RU1zaGZ3d3E4NHoxeEhkdXlsWm02Uy9xb2ZzeUR0dEpMUFJVaGxKR2NYLzdJ?=
 =?utf-8?B?T05tYVF2Wk92elFmRmNORHRBc2krQVZQSzN1MGw3SVl1WXNSTDJuZVhRSlgv?=
 =?utf-8?B?cUx2dWZLM0NTRW5kUTdvc2F2YUN4NUJ3RW1lN2lLS1dhVUdSTjJFTS9qY0d6?=
 =?utf-8?B?dzl3UU1qemY0Q2Q3dUJBMjQ1cktkQXpLNmxyVFlYUk1hYlB5UkhpY1pTdm5v?=
 =?utf-8?B?eW1HOTJreFRiREMzSE5ra0FMQmkrRkYvd1pGbGw4V3ZCSDJkWUdjMUJKLy95?=
 =?utf-8?B?WGRjME90TnFtMng3SVV4bWhud1hZcUNjVE93V05LanJRQlpjWTllaXh3ZUts?=
 =?utf-8?B?VGFhSk5Qc2tJcFF0cTRheFM3MHM5c1BpMnA3cnVwYVFYSzdQMzA2bi9uT0FC?=
 =?utf-8?B?T2RoNUdwTkd5b1FoMjJKR1dRamtFQVNXdHlDT0pRbXVWRTV0UHV2YUk2eFJB?=
 =?utf-8?B?TTFrclJGQ0NYeDVKWlRDME0xSkMwV2lnRGJyenJsZWhGRzV4RWdEN3pVNVFI?=
 =?utf-8?B?Nmc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <BBA1CD1A2160274D8D9C8DA799F3F52D@namprd15.prod.outlook.com>
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR15MB1781.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6087dd2c-5837-47e0-9e3a-08da7b3e53c0
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Aug 2022 02:08:04.9511
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vEPiDS25FWLTvLE/Sk/iSF2jIsubHx5T6MZ/SlL6Ygeh2Eq7NLLWn0vq0WWtuG21
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB3446
X-Proofpoint-GUID: 9PIsXsLeeSwbzzCWlCyDFpCCFFS-_L6c
X-Proofpoint-ORIG-GUID: 9PIsXsLeeSwbzzCWlCyDFpCCFFS-_L6c
Content-Transfer-Encoding: base64
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-10_16,2022-08-10_01,2022-06-22_01
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gT24gQXVnIDEwLCAyMDIyLCBhdCA2OjE1IFBNLCBZdSBaaGFvIDx5dXpoYW9AZ29vZ2xl
LmNvbT4gd3JvdGU6DQo+IA0KPiBPbiBXZWQsIEF1ZyAxMCwgMjAyMiBhdCA2OjAwIFBNIEFsZXgg
Wmh1IChLZXJuZWwpIDxhbGV4bHpodUBmYi5jb20+IHdyb3RlOg0KPj4gDQo+PiANCj4+PiBXaGlj
aCBzZXJpZXMgYXJlIHlvdSB0YWxraW5nIGFib3V0PyBJIGxpc3RlZCB0d28gc2VyaWVzIGFuZCB0
aGV5IGFyZQ0KPj4+IHZlcnkgZGlmZmVyZW50IG9uIHRoZSBjb2RlIGxldmVsLg0KPj4+IA0KPj4g
DQo+PiBJIHdhcyByZWZlcnJpbmcgdG8gdGhlIHNlY29uZCBwYXRjaDogaHR0cHM6Ly9sb3JlLmtl
cm5lbC5vcmcvYWxsLzE2MzU0MjIyMTUtOTkzOTQtMS1naXQtc2VuZC1lbWFpbC1uaW5nemhhbmdA
bGludXguYWxpYmFiYS5jb20vLg0KPiANCj4gWW91IG1lYW4gdGhlIHNlY29uZCBwYXRjaCpzZXQq
IG9yIHNlcmllcywgdGhlIGxpbmsgZG9lc24ndCBwb2ludCB0byBhDQo+IHNpbmdsZSBwYXRjaCA6
KSAgInRoZSBzZWNvbmQgcGF0Y2giIGNvdWxkIG1lYW4gdGhlIHNlY29uZCBwYXRjaCBpbg0KPiB0
aGF0IHNlcmllcy4NCg0KWWVzLCB0aGF04oCZcyB3aGF0IEkgbWVhbnQuIFRoYW5rcyA6KQ0KDQo=
