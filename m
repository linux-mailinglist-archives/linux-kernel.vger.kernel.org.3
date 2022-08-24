Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 009685A000F
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Aug 2022 19:07:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239854AbiHXRHV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Aug 2022 13:07:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238460AbiHXRHQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Aug 2022 13:07:16 -0400
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1811E4CA2E
        for <linux-kernel@vger.kernel.org>; Wed, 24 Aug 2022 10:07:12 -0700 (PDT)
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27OH79rV013621
        for <linux-kernel@vger.kernel.org>; Wed, 24 Aug 2022 10:07:11 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : mime-version; s=facebook;
 bh=vA+niSGESq2uTnRBTt1RlA9dzrcheDRPnU1n1UjcRd8=;
 b=frAnmV0aCm5xcYwPPYwdmos1cwancEiUqjSNPPsRTGroBw0ufdkrgQThFBETWTyDAh0V
 lL2ElpwoVygB5EU5NFpyvtM9aJu16BM9zCgh0QJxRZtpsC++wv22l7s4uQ4S/Wzjcbcy
 MeYtKP4xXNhpRiduyNYQrtFI90UlQi9AqdM= 
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2042.outbound.protection.outlook.com [104.47.56.42])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3j5ab0mu6a-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 24 Aug 2022 10:07:10 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a3nQx1MnIxKO+yb0DxqqDDbx8nqf3u+FkP0GFypr2gFc6+Ndyrkdh6R+KbVEyTyqHdlrcVd3BT5CdBr0kJoLS4pepLNfXzJsqfZn+WrZ8qk1psnWujpOwXrYj53ZQO/rxAdNpyyYkP+nj/no07NEHfcbOdQQ8YEowzX7ay6UaAnq22xWLckYHg0sHmrwWpuNppJepLYR9gWgA1xzP4UQsFc1BKk3yywHLTebx2VpG0aP3JL2YA9Nz3cbopKUCsv7HPK2E6rxxvGiH5Xi0zxQaZyzxZ7u9vS34EiNPRw3sTXUjxuKwds56kcl1nwyBBmjtQ0Sq0J6W2CVAF/UwED8Mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vA+niSGESq2uTnRBTt1RlA9dzrcheDRPnU1n1UjcRd8=;
 b=m9l36rBDVN2v924vkmDvhC4rQuM05UdVU+ZU3tF4/bTMnV2pmwHNKQP+8d/XDe1VmL7Jk8L2oEr2n1wU0JAkv7rpuT2Xbe/TAFno/dpS9Jjl2kj930fMcc6Xh6G8njtG+C6Y4oeNDPTVGgE2VNrWAxkrfRp9nJ0sNqmNM41fem55otxHfdfyc1FmRVrmvKAx61NcGQvFLYheKx5i/2PiPcS7AbA/r3n/YJO/Sr+OOEZBDTOBvQprGI3i6ruSVxdn+TSq42kTC9U1pcnVr4LCIutLlI0VsYB5VZSzgxthRuhZchGS6uF+AupBKLHfz7WrT6igGBW3MS9ddVYTXCgbsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SA1PR15MB5109.namprd15.prod.outlook.com (2603:10b6:806:1dc::10)
 by SA1PR15MB4628.namprd15.prod.outlook.com (2603:10b6:806:19f::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.15; Wed, 24 Aug
 2022 17:06:58 +0000
Received: from SA1PR15MB5109.namprd15.prod.outlook.com
 ([fe80::c488:891f:57b:d5da]) by SA1PR15MB5109.namprd15.prod.outlook.com
 ([fe80::c488:891f:57b:d5da%9]) with mapi id 15.20.5566.015; Wed, 24 Aug 2022
 17:06:58 +0000
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
Thread-Index: AQHYs1RC3fzFDgbD7kKge/abI0eC0q27FhIAgAANe4CAAAYdAIADJ4CA
Date:   Wed, 24 Aug 2022 17:06:58 +0000
Message-ID: <CC86FB2B-DC83-4A74-9C52-1CBE6EF5E502@fb.com>
References: <20220818224218.2399791-1-song@kernel.org>
 <4D089469-B32B-4347-A811-B1E5EE011307@fb.com>
 <YwOwLYUXuSn5acIG@worktop.programming.kicks-ass.net>
 <7621DE6E-D71D-45D1-BAFA-46E882451DD9@fb.com>
In-Reply-To: <7621DE6E-D71D-45D1-BAFA-46E882451DD9@fb.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.120.41.1.1)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9cc7ed6a-735e-4aab-56d5-08da85f30de6
x-ms-traffictypediagnostic: SA1PR15MB4628:EE_
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Wqrn2VYJ/dZGcxLyAv7RZCY+5PMDscw1rYQtXMTSkMFCGcsYDmyxItRSanxMQN77AMLezqYZej+ejTZ4NCwLZCmtCPdUv9rzecMfssekIXeY+P7mEL/aSVrbdqVBqUmwhXCgXWHvVmOCCMQn2fDvjdDzM4P3SQ/wpb88KD/UhusJjdRnVqj6UBnVas1J+8x9cDYEiCtrSZYPX0iK8B9YQe1/vNe3OZZK81fCwMRUTZxH5wqgt5zDIFVqOi9cBX1r0J70fXEtkflXHJw4c++SLPiolLStCCQ+w6kKSvoTPbBPyr7C4XocT71B6bnMFCoqFYe8Sa+eNBG6AtoMUcxgy19/k992Cj1kZFZAjrEAixtpPpQolv9KZOyV5022Bi5LDX7LIB+iTQqvvbp3mzv0uwJObwHy0d9Jpn2lpBWnFsNez5nofx612w/LpvBe4GbN4lY6y03ARrfa1Th9mGCfHXQGSoLE2I2pAEbFSwxrLYNAQGuCF/B1pxPngV0VhlGbwNwEKIxpsXj3aQ0Ap9++j4oEGiLngIR+U6JHpe9Dj0Rh6336sdwpRO8NGriVUZz+Jz+Pgd3a6zkXqD9Kc6OiKiE+5soA5MqrYQz9vHpQ8v1Fbarw45gNFHE+JxyDxuur03PmtpWZRlQXz+4DYpuR5b9whev47GirLjWdriyXQkDFtNLmsNYXOR9n8bgyklQRrBt4LF6YT84knAxhySr/QliLJGkUzkcxOxsPwSR+YQ/yakR/Wow0z+8e4//ntzMwETQFhzPVAldAiKBElw6Wcl8mcScOIWR2IHZ+xP1q6KY=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5109.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(136003)(39860400002)(376002)(346002)(396003)(366004)(83380400001)(186003)(2616005)(36756003)(33656002)(122000001)(478600001)(41300700001)(6512007)(2906002)(53546011)(6506007)(71200400001)(7416002)(6486002)(66946007)(5660300002)(38100700002)(8936002)(6916009)(54906003)(316002)(8676002)(4326008)(66476007)(66446008)(64756008)(38070700005)(76116006)(86362001)(91956017)(66556008)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?3ix4voKJD/WSNcxJx6mMw+XBT7CCiMuMuREorC3zfWDMSfUEERP+apAgi9zQ?=
 =?us-ascii?Q?dPqBU+m5s2ONiEh3YOmvuBBH9tVW5Pun6v/DcGx3Cz1+kLqnNHgBnmBiH0ik?=
 =?us-ascii?Q?9TQblpIHYHMANV3y8g0lAISg8ZlfHzwKxQd/h+QWBIjY1ePc9tG7faCbp+TX?=
 =?us-ascii?Q?Ri50Jx3dkef88E5v6CggROXRcm9nAiLYiFQl/Apn9u19jlCtaqbLPmULocir?=
 =?us-ascii?Q?k6gfzkVOyOirDrOMW2IBYolQArH7LMuXEtvSmRm8DItEIxSyUNwSt+8VHqFR?=
 =?us-ascii?Q?etG9oP+Y9shoJaswVkcAyOfTbx2hIwgf3erivuH1QajgP1ch+L5mbsIc3uEe?=
 =?us-ascii?Q?Iq6Uc1cBEu9k6WqeYdQPSwEatTNmF++PmDuu0dMPjKO7IGr9E+z8JmuQHhNW?=
 =?us-ascii?Q?4E6m7wCpcvO8GkMqENHnnmwjXbTFBR1hy9lPTr1A+IRbD7OMUfdF+F1cvjNg?=
 =?us-ascii?Q?gUiSc70+/gQshgxYGJWl9PdQv8Zl47vdGg+l2B9kskhmqnLJe4G5vJ9h0QeY?=
 =?us-ascii?Q?39wKQryyC8PFOqeDy6LxyFP6yoL2D2X9f4k2a/KaHqTfqTaFpJyTPSKIhtBl?=
 =?us-ascii?Q?An4kxedTX65vzlbI6Y2ugmRjSeSo1g/N6/YlK5gpKBgegmUEua56eFjcALoo?=
 =?us-ascii?Q?l1eNtS4+TzT2b4dxdrWxdn4QZTTcotDKGxEX/O0lmXLUgkVBPZrhJp5BLsif?=
 =?us-ascii?Q?Fiy5yuo1RhzYFLGNieRm6I4UjrVu7aBl7xtiIoNk++9jV8cs7RbjpQT/bwvw?=
 =?us-ascii?Q?VKLhbR2xGLxo///DqjuerPkCS3mYMhCrLJb1P0+yGkgrQaDu++wzgpgOL1r/?=
 =?us-ascii?Q?dlSJ14cbWu0lS+pBrp2cBbXj6nn748WQAoX3gqpuWGSahDrbBwFMWg0v8JAC?=
 =?us-ascii?Q?SkSgywI8S9lfzb7hhNqZobb7E8+0RMbtCr4f3wYSxmzG5AtTRVczL5WMd8w0?=
 =?us-ascii?Q?LQliZiVF/6MCm9eSV0kOWoQqg7Mygr1nIRBJX+4t6xj8ZkTPaNicNlzsBRQ/?=
 =?us-ascii?Q?hl8vVYAKB0C6/gnxXwmG8QJGa1edn8HTeXj6iUI0MddFxEuOAP1cU20qsVJn?=
 =?us-ascii?Q?n31ZoDXEcEqdbd9ILyhcm5/iaMCwXRsYz7vgZwiHpsXwJGf9Vzk8QnIfR4tN?=
 =?us-ascii?Q?p8G+g7l+LPzsuGMlb02FKon7/HaY9zB9O2XRvwT8tRyOzFh7/GjMHBkuXtNg?=
 =?us-ascii?Q?VpTLe9c86srVOyZSFslQRFYsuIqrHWLuz7d0JIcs7ZpfrtuapHOmB8Lj3bEh?=
 =?us-ascii?Q?63EQiMJ/kVYj3fSj+0oPGRJfT0UBlCKhoHlsDQHXoPSwshz4sXT7iivI7LXi?=
 =?us-ascii?Q?Mh7u4/gupHG6kQFHqWiLYnz6q1h8DkLFXVU6oyZnpIZjCGznwFp8Iwq40n2W?=
 =?us-ascii?Q?+JKjEyV7WWIXRUh65rbEupd4c25OZpEQmIOj/MmwF77UOBZMPbMuzqKG5zj5?=
 =?us-ascii?Q?XT4ZxMn8d+fLBcJQ3PBJFfascc3GVV4K/iebQxCoTmKDKVQUq7IITg/D4Voi?=
 =?us-ascii?Q?Ej20L09AlMyamVIWeJSd224k8BZVarxYZ0qLBA1nZm+R/lYYOEEonfkX+gpv?=
 =?us-ascii?Q?+4x2iA/+fE/h57f2X6tBciFvgzOSpBzJZgocNR3iyrd7zGGZwheWEUVuCwaN?=
 =?us-ascii?Q?iKGqIe5Sn3obG/IDudNCvgE=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <5E182DB9F54CA1419CE5B1DDB76C92D9@namprd15.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB5109.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9cc7ed6a-735e-4aab-56d5-08da85f30de6
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Aug 2022 17:06:58.2780
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EsJCimz5Jguk4PJwGlFEUm4U88/pkmG9VK2TAWoqb12j8Kufdm5VBoMzbw0Vwdm5HQ5/ipGh0A2eoHkm+Fz5Jg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR15MB4628
X-Proofpoint-ORIG-GUID: qFcQD4PGP54I4TBwRs0-e1jZF2zMV1eU
X-Proofpoint-GUID: qFcQD4PGP54I4TBwRs0-e1jZF2zMV1eU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-24_09,2022-08-22_02,2022-06-22_01
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter, 

> On Aug 22, 2022, at 9:56 AM, Song Liu <songliubraving@fb.com> wrote:
> 
>> On Aug 22, 2022, at 9:34 AM, Peter Zijlstra <peterz@infradead.org> wrote:
>> 
>> On Mon, Aug 22, 2022 at 03:46:38PM +0000, Song Liu wrote:
>>> Could you please share your feedback on this? 
>> 
>> I've looked at it all of 5 minutes, so perhaps I've missed something.
>> 
>> However, I'm a little surprised you went with a second tree instead of
>> doing the top-down thing for data. The way you did it makes it hard to
>> have guard pages between text and data.
> 
> I didn't realize the importance of the guard pages. But it is not too
> hard to do it with this approach. For each 2MB text page, we can reserve
> 4kB on the beginning and end of it. Would this work?
> 
> There are a couple benefits from a second tree:
> 
> 1. It allows text allocations to go below PAGE_SIZE granularity, while 
>   data allocations would still use PAGE_SIZE granularity, which is the
>   same as current code. 
> 2. Text allocate requires mapping one vm_struct to many vmap_area. Putting
>   text allocations in a separate tree make it easier to handle this. 
>   (Well, I haven't finished this logic yet). 
> 3. A separate tree makes it easier to use text tail page, 
>   [_etext, roundup(_etext, PMD_SIZE)], for modules and BPF programs. 
> 
> Does this make sense? Do you see other downsides with a second tree?

Did these make sense? Do you have future comments that I would address in 
future versions?

Thanks,
Song

