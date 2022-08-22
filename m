Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 032EE59C479
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 18:57:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235353AbiHVQ47 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 12:56:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235410AbiHVQ4x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 12:56:53 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D35A43E769
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 09:56:51 -0700 (PDT)
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27MF8luF024136
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 09:56:51 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : mime-version; s=facebook;
 bh=JHpaGULDJD4jQhDyIkZFPO9A2iur1dNjcWyxyX806sc=;
 b=UQTXMrPkmx3+VbdMYpGfSFaMFBf6BcdsahvseGqB9qwpH3bkDfUIHQUijN3l3HZpywP4
 uPdQNQkEWwZ2Fto9V5Xf85QanrIDqXjr0CKorzhxTwr8fThZO9gLVOGzjsjc4NMUqgWK
 eT1jGiDu8aN3G3uAbalyamEH4aovPbYl4O4= 
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2047.outbound.protection.outlook.com [104.47.74.47])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3j43hpby1t-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 09:56:51 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kNbxvzrYLg/EqCBQaGYZ7e0WGGfGiExHS1HESNDs/QO1aP4YLEFoQQoisA3oxvoQbZoop5mDsfSZWK8ERa3Zqofo1CWKZbE/V/1+r98Ap2spQb6PT10/cOHaCF6SNCrEaALwb5TY/5AVvqtGSOyRtO2q1KI6DFyVFkrJxpHV4dkyJf6ODy+nGuYO95bMaAmwjzJuB0dMA4A92yr59GskYPXWxCPM3n+2nUraMA9DIb7gvime6u7XEAS5GKRpdEDTsYggWm1WxL32hh+MchASdHw0AS0zspc3+CpIE4mIHY9GJln7U1oW31S2cCxd2V43rbHI9V8zkQ++6+4zcFyBOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JHpaGULDJD4jQhDyIkZFPO9A2iur1dNjcWyxyX806sc=;
 b=d+qW8I3taWfLt2/2ZPcxmnzLU/iytwQSKqObgKWprfy7abwOJUre2kh7kmo64qfSppiE1qmkXbHB6Jr5GpXjP4qf5VOZZe/X2GT+BtQJUT60kn5Ca13EDHl27NCmyEtX72Vk/GfJ0aA5vqKqxywkUEZzgZb0R4GyBFQmBjOs5qFQ8iWI3N6QPv6O8HiNvB2H8iqs+5dbtmJytkt27bDXCQRfhz3gbQQNscfMZHEYMIBfY6PWjoCfbmL3pqCh+FIgm2sNrEzRcS/JCtBRdvn5ThjhurTdFWdwQXtskhJdbr7KsBJXxSMQ//3PIZe0QNTcIglsgrY2FRYdBwUCX1h0cQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SA1PR15MB5109.namprd15.prod.outlook.com (2603:10b6:806:1dc::10)
 by MW4PR15MB4425.namprd15.prod.outlook.com (2603:10b6:303:102::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5546.23; Mon, 22 Aug
 2022 16:56:47 +0000
Received: from SA1PR15MB5109.namprd15.prod.outlook.com
 ([fe80::c488:891f:57b:d5da]) by SA1PR15MB5109.namprd15.prod.outlook.com
 ([fe80::c488:891f:57b:d5da%7]) with mapi id 15.20.5546.022; Mon, 22 Aug 2022
 16:56:47 +0000
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
Thread-Index: AQHYs1RC3fzFDgbD7kKge/abI0eC0q27FhIAgAANe4CAAAYdAA==
Date:   Mon, 22 Aug 2022 16:56:47 +0000
Message-ID: <7621DE6E-D71D-45D1-BAFA-46E882451DD9@fb.com>
References: <20220818224218.2399791-1-song@kernel.org>
 <4D089469-B32B-4347-A811-B1E5EE011307@fb.com>
 <YwOwLYUXuSn5acIG@worktop.programming.kicks-ass.net>
In-Reply-To: <YwOwLYUXuSn5acIG@worktop.programming.kicks-ass.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.120.41.1.1)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2f34e7c0-7006-4ae2-5308-08da845f4d24
x-ms-traffictypediagnostic: MW4PR15MB4425:EE_
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: YYzCPzsKbYubg3JdLCbqijLb6IJkce2BT90H0LK1/aMmkDXZK4jx38sEDN+J11igrvYJM58cqKmgrQfWrBgSo8jGE+q+B60SIyVpfHfFDPz3T++Lg1iJEYJbjTSQi8O9PmyZ/t1DC0t/ZqZZkFhjdrtMG3gt/XRCZrSqcwQEIWNxpMJtTjH72Ns9ktEo16tiGdk06dYR5vveAvymNr+idxTiJ7C4Pm1C3vRjGIOiOblorFAsw3LAM58bAaTn3gdyxv9JSpUNh62JHKgwu0ZUOrTdLBVH+bSL40S4ci88+YBVEBvpIUs2t3OXv/B6buv08NNtWTdZTFIzwgN8A3kfwMTZeeRVlKWCyDDmgoCebnSKGZUz3+80kNjejBudV8Bl0Ic0SQMVvRGHreO6ymuVJgL4ouVwKowGzavvzInL20eLiN7EKYxS59n9MtDW6w1vf9dkOw4WLTDWz+hQZICnSy7+QbBHGG/8WHR++BGReucwgMy91Gb0GC4AYq8BgbnvtByIabitU4Y+DM/3L7io0PXSN1l44erRCxTNeShZxVGNW2Zk78hmynT+exaImd+coGcw4sA7t185/3jB4bjxvYXDBvsZa5+CY7eVB80OSs1VWC/BF01oGDTx2AKBaeO2RMb3McrJ/ZWTY5zxWJRPaNyWdHMzKd12JpoEbph5P3142fEovNBaL40OHr7y8Uu7nClF7ScYlIu2348Gu0HPn3DeehlcHu5CUm4BxmTkWU2z+DaCfX1HPuwU4+gsyBgRak6vngiXzNpALRwFmgiEr6pjpxD9g4mdtQ58qGj+9vo=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5109.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(346002)(396003)(376002)(39860400002)(136003)(71200400001)(478600001)(6486002)(316002)(6512007)(54906003)(6916009)(36756003)(33656002)(2616005)(186003)(38070700005)(38100700002)(91956017)(122000001)(8676002)(4326008)(66556008)(66476007)(66446008)(64756008)(76116006)(66946007)(7416002)(2906002)(53546011)(41300700001)(6506007)(86362001)(5660300002)(8936002)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?SHaRzLcunt/C+RrVVd9tAV6VTw9Ld/wx1pC40w78sGttHa5YRcLtUaMUcIH2?=
 =?us-ascii?Q?LgJq9DMqa9+jAOJyce/8wn0TGyuG1ThpUzmp9KCyi+U2qEmOAadiE3ezGNFp?=
 =?us-ascii?Q?tH1iJ34dO9uwet3qzlURJu9oZS1fjvcny6idIx53uJqAMppYCx0zcmi0Xx/r?=
 =?us-ascii?Q?b7KFTc0MXUTJbgQ30JNzXDVpNeFFdDsfK0VrBwNthRpV6IO4KCqo7/VgIUoI?=
 =?us-ascii?Q?2eVlVFMfoYuFlYyXH/J2Tu5iBNAtQPhGMRpLE2AvFk12IsJEUnCgF7ywffpR?=
 =?us-ascii?Q?86nYKW1kBmhk5zvAlE21A8pTppPfDJKe9FpXNH7YgO4dZnKcgG9uStmddw6T?=
 =?us-ascii?Q?KeeDsOtVlaB+2qQn31f2PECjDxzvo7MPTvSoiSxE5tpM0ysBgoJK+JOaxefG?=
 =?us-ascii?Q?rPsN1FiMRXyp6kK1MUPG9iV3Hu4g4tOmLFKRtqQb3AZg5lvVnNDpUSbSyDJ5?=
 =?us-ascii?Q?WItDUSXpzVOAaEUk0Jzw8vb5wcL+MkIjQtIJblH4W/SDkxntbpYlEiQM48s9?=
 =?us-ascii?Q?0HyG2VQxLaFJmgVhS9zaP+QyBYeGEcix3DB38nIzbPtLZRbVgHBsWiC0/sXT?=
 =?us-ascii?Q?5SicqONohxqqVDrYfNEEPkyGY5ufDfPfCK9/PCpfXqj4kMLjFLDbKuQnD8Vk?=
 =?us-ascii?Q?GKHAn7WyoBxsu6725YPdmU75an+IDNqvKFJlHA5uVONFvIGgZLzL5mAabZTp?=
 =?us-ascii?Q?a+Eof8t2s6jz9IycILvNBYeyhEzBhRx2ZHrWOk/nH6qsffSHaxnwtkjnZEVW?=
 =?us-ascii?Q?mlyO8PiEAAqSls3tT4p9EhL16dc2ucL/i55FuJ0G+q1frR5qYLvvsdCDXRII?=
 =?us-ascii?Q?pUu0B8637ZZBarEX1+mO+CPYkKSZPy5rNUFrL7zDU2WlecQNcgaFRZGtbvuL?=
 =?us-ascii?Q?FtSg553HsY+cQ9BQhRm5GYnvfh2JzdOARAj+fZ555l+qBXRH+2whjLn/S7Cj?=
 =?us-ascii?Q?CU6vxv5DLC05mOfGSG31L/+mWh4NeAMs9oMmOjXmSjlF+ug6Khvuk5o6tEvu?=
 =?us-ascii?Q?kGYJs+Fuk/0JNffByHQO5NYZr7aCyg3kGKlU39chrDLVNqMme2ywhWus4VjF?=
 =?us-ascii?Q?TV2pd4v1KbgI2G0K/oj77uwFFet0TK7eCDz1dMpHnJo9OjAwUakU2irbj43v?=
 =?us-ascii?Q?+tHc9g3ty5pOAE+YrzytUJlHmHDn9HKBSNCxaJHSOPDgEx0U9qJjKWTp2+sE?=
 =?us-ascii?Q?/Dk870eagL/KRhKV+dDW090jQ+YRtrdAI/CfydLCCYW1sDGInA056VHf7MYT?=
 =?us-ascii?Q?f2/omhY8nDurkuM29OiP7P2J5dN4uYLed88YSYQbppacTLACNTkgWXpsPN0m?=
 =?us-ascii?Q?9IbI7dY9ZmxOSGktkLXGpzcy0Csqoa3zi4UApCK69A7MWFpZD73tHgKCZ5Vz?=
 =?us-ascii?Q?5JLl3FN8iT6Wckvbhjjhw2Hr5mAIX4ivPXSqfnVyhEIgCLPs3xjtHmDkkcb8?=
 =?us-ascii?Q?pbnoB+CPstIILqYWRZxRJZx6OTCiRQNAZMASvb8TKyzr8/UUICpWBNmR6cXl?=
 =?us-ascii?Q?t76Kojw3lk2BqwUUi4ydGPCOSRDNdPM1d8Nx1MgnJRCEZUj7l1b3a0mRj/8F?=
 =?us-ascii?Q?HN45AK7RcDh9JVzEftiBUhfVW7TbAqmnGWxOWYl+6D3VAhGvuztSTcZSvCLd?=
 =?us-ascii?Q?PH/3P+xW7ekviIZ1SzrEdmg=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <C221B4C5E9ED344CBD836B8AB746E7F5@namprd15.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB5109.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f34e7c0-7006-4ae2-5308-08da845f4d24
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Aug 2022 16:56:47.6707
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lYsrhcjKn2DPwdju4NBzFdGVM/Yu7eG6W8ucBLPVmM8ZSmDOKxbMkPfGngl1nbaxnn+SPlkDobz9ZWlkWWPCeA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR15MB4425
X-Proofpoint-GUID: UI4NuupBbR88NPda3MtRenMrs1-AU5aK
X-Proofpoint-ORIG-GUID: UI4NuupBbR88NPda3MtRenMrs1-AU5aK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-22_10,2022-08-22_02,2022-06-22_01
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Aug 22, 2022, at 9:34 AM, Peter Zijlstra <peterz@infradead.org> wrote:
> 
> On Mon, Aug 22, 2022 at 03:46:38PM +0000, Song Liu wrote:
>> Could you please share your feedback on this? 
> 
> I've looked at it all of 5 minutes, so perhaps I've missed something.
> 
> However, I'm a little surprised you went with a second tree instead of
> doing the top-down thing for data. The way you did it makes it hard to
> have guard pages between text and data.

I didn't realize the importance of the guard pages. But it is not too
hard to do it with this approach. For each 2MB text page, we can reserve
4kB on the beginning and end of it. Would this work?

There are a couple benefits from a second tree:

1. It allows text allocations to go below PAGE_SIZE granularity, while 
   data allocations would still use PAGE_SIZE granularity, which is the
   same as current code. 
2. Text allocate requires mapping one vm_struct to many vmap_area. Putting
   text allocations in a separate tree make it easier to handle this. 
   (Well, I haven't finished this logic yet). 
3. A separate tree makes it easier to use text tail page, 
   [_etext, roundup(_etext, PMD_SIZE)], for modules and BPF programs. 

Does this make sense? Do you see other downsides with a second tree?

Thanks,
Song
