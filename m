Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A07A59D18D
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 08:57:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240368AbiHWG4E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 02:56:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239227AbiHWG4B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 02:56:01 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00E705D10D
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 23:56:00 -0700 (PDT)
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27N6EqVe029658
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 23:56:00 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : mime-version; s=facebook;
 bh=897BCxuo3q+eIdCKJMrSUu+kyPp1S4zdbBl9ZKIlHZU=;
 b=qcvJUbqtoWKyN47gOa1WqIJUEonEfq2heiH3zC6H26w8g7TqfKNTlKM97pTO75JFtfmt
 miX0oKebckDIO9WXWQyA+PbSUaykoU/HRw7FbMGZ44UScfCOBKaTU5Q2rZ9Kp7kFbscu
 uopVGGq80o7HimSuqyIr2uHyM8tNMg+rIR8= 
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2172.outbound.protection.outlook.com [104.47.59.172])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3j43hpn3f7-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 23:56:00 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hptnPwLeBa4rcI85kx52rkI8Y37ZITnywV4DaysZ/UmxRYOadmj6yQbDOuVHpZQwjeW4sw5tg3xsRSXlRtv4wA4Q6J6jC4o4rXrHDYZfPVBbAk9c+G4xORrswiTpYJGcNe7wWUYvmIhUgNMX6gp+lzUO79pHVgFSGTUf8qnuocyFnePyCRG3rQT8f9sHR84qWutom53rGuAX3y/2JsJkad+BInqEBoaQ2FlwwkbVDUdKHy089+aEYNo4+fB0slgP/lc/Ed3E9bUOewUENke70O8QEhbZe9zNPyPTGP1XUjB24TsCscgUMHtLTqXPGqPm9h6kRJMw/QAclVzXiCDwwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=897BCxuo3q+eIdCKJMrSUu+kyPp1S4zdbBl9ZKIlHZU=;
 b=ajcKYYZAqh+/FWZad3aw2r+5Y4SMGWZd4Ozd+2FD5oAJ7n7GkRz5uFeJCGa0qtVWu4LYlTn6FgEzIgysrhYtM6sdz9Gib6V5a2P6Bbs+lSB+GHqgmb+gRAYBCjQK/tIpltnaBoK7YMW9F2B1PtNzZP9pL8e2mPM/c4xo0+zphl0DF7tSSbEOQHoxjUpgPDkh/W0p/HNOXZNEcYKlwUIkMC05tMzDYhp8/K771RCHpqzIAsdbX/k9sluZ8hfsiA0fJYmyucNl+vEYmmAiAylUGqQarKvtFlD9BZV+xBDz1qf3nwUL5iNdYNOGFCMmxA5HuJIzegxdy7EjcIOuMVSARg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SA1PR15MB5109.namprd15.prod.outlook.com (2603:10b6:806:1dc::10)
 by CH2PR15MB3573.namprd15.prod.outlook.com (2603:10b6:610:e::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5546.23; Tue, 23 Aug
 2022 06:55:57 +0000
Received: from SA1PR15MB5109.namprd15.prod.outlook.com
 ([fe80::c488:891f:57b:d5da]) by SA1PR15MB5109.namprd15.prod.outlook.com
 ([fe80::c488:891f:57b:d5da%8]) with mapi id 15.20.5546.024; Tue, 23 Aug 2022
 06:55:57 +0000
From:   Song Liu <songliubraving@fb.com>
To:     Peter Zijlstra <peterz@infradead.org>
CC:     Linux-MM <linux-mm@kvack.org>, lkml <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        X86 ML <x86@kernel.org>, Christoph Hellwig <hch@lst.de>,
        Kernel Team <Kernel-team@fb.com>,
        "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Dave Hansen <dave.hansen@intel.com>, Song Liu <song@kernel.org>
Subject: Re: [RFC 0/5] vmalloc_exec for modules and BPF programs
Thread-Topic: [RFC 0/5] vmalloc_exec for modules and BPF programs
Thread-Index: AQHYs1RC3fzFDgbD7kKge/abI0eC0q27FhIAgAANe4CAAAYdAIAA1hSAgAAUYgA=
Date:   Tue, 23 Aug 2022 06:55:57 +0000
Message-ID: <0F9AE244-8747-4533-8AFD-6E1810225CD2@fb.com>
References: <20220818224218.2399791-1-song@kernel.org>
 <4D089469-B32B-4347-A811-B1E5EE011307@fb.com>
 <YwOwLYUXuSn5acIG@worktop.programming.kicks-ass.net>
 <7621DE6E-D71D-45D1-BAFA-46E882451DD9@fb.com>
 <YwRo43EBIWh7++Qn@worktop.programming.kicks-ass.net>
In-Reply-To: <YwRo43EBIWh7++Qn@worktop.programming.kicks-ass.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.120.41.1.1)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 191e8857-eac3-4b16-504a-08da84d487fd
x-ms-traffictypediagnostic: CH2PR15MB3573:EE_
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: FRzZQuTQ+UxcHyGXw7pVbtkvreRPDdq7kFtHzEVRsaIqiW8WOCGxY/yzg1SVDmAMziyNNw5qEULkLqyIzfonOQDa3U7JfBbHYrucmTrsZhhDXM3tuVx5E6FfzKcW/fCaJIO8WZ3jdeMtkX3f7zJK7cZNUzHvrLaby+qWQiVTMApQ4ZoUkmZLGkIkBdUBhBJe5IK++fhDAgtcd+nV7l40ZrToVzPo4fYJwsgb39TrAeCM+7nwkS0199Ox605gx4GzuKuqjNcHb698sU3qXeZW5kKZikf2THGzkzMz+YxFWO+noXF3A/pj7saLpRPCAR0s94euCvJe7kRqy64Zc7kmNd3almqDrGaICjaP1ueYf8CN0+ZoIilofF+oLFiHpr+Ih2U4fgjNMRBGUdhhAFTPHaAxA1qtFe9BGw9kUVVz/PkhQF//xTioOGeP5bgi4EtHiwT8IrilBlMW200+HQaDxXOifIdtns+oMEyvdKgOomDae3m9iQaT5/a03WCBM12/MaodsY4ZCTOmvfUUak/syHcMbYSqti2i5YbpHRco9Ur9HovwPD75lNBjbV8rceElLsaGF5a9PcvpVPl/9ieAvs5vLiL+BAcIQGe1fkTw0aH+bW46C3iHJjqGeAOWQ/i+sJA0EGIBZ9TPzBHR/oHnTqVQfov00kcscI568S0V1ctd8LFquCMv8v4Ah4JiGHH16i0KhcOBe8Dn+SAuJ9tbc5J3a4e2barb3jFf7ztzC6XitJRkWAvscOTw55Etv6/SCIfi08VWAUvhnWkgMWpDEbZuoQl5wlAet7+CFK/o7/E=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5109.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(376002)(396003)(346002)(136003)(39860400002)(366004)(2616005)(5660300002)(64756008)(6486002)(4326008)(7416002)(66476007)(91956017)(8936002)(66556008)(76116006)(66446008)(66946007)(478600001)(83380400001)(33656002)(36756003)(53546011)(6506007)(6512007)(186003)(71200400001)(41300700001)(8676002)(122000001)(38070700005)(86362001)(54906003)(316002)(6916009)(2906002)(38100700002)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?v/uX2QKHUIB5+Y1s1auS9EQdehZSgUNJaDG4PNJyW0M4dWXJVBpVefJVec8I?=
 =?us-ascii?Q?eVF+kyPlITwU3lSmYgaqUjH98hSNJbJYYKTuhKgf35DXLKfemt1BuotCXzuc?=
 =?us-ascii?Q?bjWrYGgaM9f3HL7XjgCljJwzKBOyrYE9YBh42CToA8bEG3AdgOkcLhB1U4Vq?=
 =?us-ascii?Q?zSPWfj/m5oLL2nhyTIDpxCiGWyD5KD43cN3lgwSZBbc/jdAg3rjlg4+mCaOp?=
 =?us-ascii?Q?ZVLVVACFGslrhLgGMnpUttNuP2hHlGjLdvgmhpf82jm1ggDP/2MRKis7KRW4?=
 =?us-ascii?Q?FMi4YZX+/kljTVdDWn4pG8Ea1DbIgbMBANFi63/q2oKhW0TeSlr7DHnbfkCO?=
 =?us-ascii?Q?aRtJPJqJem4IL2Gs/U8CuGOW+cEW5F8wVw+CRxNKFZXf5g/hv4IMcDLEgdin?=
 =?us-ascii?Q?mm0XOvfESGmIqp/5myKUoLyAxFcg9Ja0jzqBcu270X2SQGKHqxfzvBeNTpaI?=
 =?us-ascii?Q?iBxChJVYTcfqW7jC8QsVCwGmBAOdpfHA/tudQ54m76+GyNsTzfp1xSrdAhj7?=
 =?us-ascii?Q?FMtqSykMnVl6SOOmxKxGf2he6ZJNjiRQd6XFmQVqZh4IkyGCYLK/B5sJ0FAz?=
 =?us-ascii?Q?i1Ykl3X+IGCvWFAguPZh3bXJt8kLpD7tBII+prBbEh9CbuaWPo1hnbeD8ka2?=
 =?us-ascii?Q?no6wLdL4WEBYcscTfqy2yjga1Z1rqr5cbjJrNjOz1EKNSZdlTPCpPxrB43cd?=
 =?us-ascii?Q?XbyLYnST2fvNj4x3YpUh5G3K2FjRkdWU/DO7OhNg6vOyb7bQ+yPY3I9I4dF7?=
 =?us-ascii?Q?3vEon/JAOO6F2KCZROukYyxNJakDUmhTPHT9vHC9n16wL1Ohv0CEqieotr9f?=
 =?us-ascii?Q?5yk5LOmH6MOowbwHZEZXtgmxSZaBgEJ8p0kKcpe/gCTbfCBsXHdQSXbSHYd+?=
 =?us-ascii?Q?h/7rVuG/7k4DTwdLvT1kywdSI6mokdVIZksTQzRr6goVYs8hDqu57W0PtWkR?=
 =?us-ascii?Q?RVx+NLX91AdXKt04j6qBmJFwMPw2U+4gLIkpyJf8DWRkxFH+NRGdX56bMAIy?=
 =?us-ascii?Q?qHWXZBHsResArS5i27IeRRFXRN3EApqDWiSNftTPueh3mc1dXk/0YV1IGzXY?=
 =?us-ascii?Q?4/j/qPWY3xiSJHUNIQYDoKYsw5EmG3wet4sGj5riESjbkDUPDKkJphcwsn7m?=
 =?us-ascii?Q?BvLIPIC1H6DcUpOfiYccJtx619CUwWMBAPQk/Le9XyyomL8u/FYpZXJjhRT8?=
 =?us-ascii?Q?lQmaFqczOlbcQ4JB6Cj0UrwAI7FZUJ5y5sD3tKiosGkLZqbSob5A7Cz2P71p?=
 =?us-ascii?Q?MVVWQ/kFgBf/yxZ5B0OKZw2yGxOimjHC4oD2XujULU6OvJ0mxAMvbkbdxi7l?=
 =?us-ascii?Q?pQ/QOM+4S4Rj2+nx2f4xx4MF4NzgDNTrY7/bNKFnzr9VgAr85VSOp9NFXAsP?=
 =?us-ascii?Q?QupDCWAvWA/ln3yCC4XdoxV7YbhvknKBEz/bjfqq3iRGeXXwFLpOKb7IVVAq?=
 =?us-ascii?Q?iUOp5Bl6MTbOZKxC4jGmFLhSTPNdjdXjLXKgFqKWihXIGsOq1/lDh0rR1MTE?=
 =?us-ascii?Q?b/Qi5liW0DwQaUHwm7DdNmNc/H0JQ3AlqLZwXV58Y/c/ev4sx4fV8TB+ZjBe?=
 =?us-ascii?Q?CosVbEcKjTTyW6F7oMSEgO/g0awpnRzoATd8Ezd1lGbDR8FBWUj4bSEh8gtT?=
 =?us-ascii?Q?i3KNvHz3p0VbEgVS7M+tD8g=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <D61F0D6FFF7D31478C5B2B3AB787A2E7@namprd15.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB5109.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 191e8857-eac3-4b16-504a-08da84d487fd
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Aug 2022 06:55:57.5492
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ok9Jv5uIpF5GYY263Tf65Gbj71vxxS15do2B9dU6zBuwSwP4v1hL96jwOFnpc42sGEv+IUObsd+lnwtI60clyQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR15MB3573
X-Proofpoint-ORIG-GUID: x080XuXdWerEUB4VMpdYAj66xmF-7EXV
X-Proofpoint-GUID: x080XuXdWerEUB4VMpdYAj66xmF-7EXV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-23_02,2022-08-22_02,2022-06-22_01
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Aug 22, 2022, at 10:42 PM, Peter Zijlstra <peterz@infradead.org> wrote:
> 
> On Mon, Aug 22, 2022 at 04:56:47PM +0000, Song Liu wrote:
>> 
>> 
>>> On Aug 22, 2022, at 9:34 AM, Peter Zijlstra <peterz@infradead.org> wrote:
>>> 
>>> On Mon, Aug 22, 2022 at 03:46:38PM +0000, Song Liu wrote:
>>>> Could you please share your feedback on this? 
>>> 
>>> I've looked at it all of 5 minutes, so perhaps I've missed something.
>>> 
>>> However, I'm a little surprised you went with a second tree instead of
>>> doing the top-down thing for data. The way you did it makes it hard to
>>> have guard pages between text and data.
>> 
>> I didn't realize the importance of the guard pages. But it is not too
> 
> I'm not sure how important it is, just seems like a good idea to trap
> anybody trying to cross that divide. Also, to me it seems like a good
> idea to have a single large contiguous text region instead of splintered
> 2M pages.

A single large contiguous text region is great. However, it is not easy to
keep it contiguous. For example, when we load a big module, and then unload
it. It is not easy to recycle the space. Say we load module-x-v1, which is 
4MB, and uses 2 huge pages. Then we load a small BPF program after it. The 
address space looks like:

MODULE_VADDR to MODULE_VADDR + 4MB:			module-x-v1
MODULE_VADDR + 4MB to MODULE_VADDR + 4MB + 4kB:		bpf_prog_xxxx

When we unload module-x-v1, there will be 4MB hole in the address space. 
If we then load module-x-v2, which is 4.1MB in size, we cannot reuse that
hole, because the module is a little too big for the hole. 

AFAICT, to use the space efficiently, we will have to deal with splintered
2MB pages. 

Does this make sense?

Thanks,
Song

> 
>> hard to do it with this approach. For each 2MB text page, we can reserve
>> 4kB on the beginning and end of it. Would this work?
> 
> Typically a guard page has different protections (as in none what so
> ever) so that every access goes *splat*.

