Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 401FA58E825
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Aug 2022 09:48:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231530AbiHJHss (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Aug 2022 03:48:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231582AbiHJHsX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Aug 2022 03:48:23 -0400
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3FB272ED3
        for <linux-kernel@vger.kernel.org>; Wed, 10 Aug 2022 00:48:18 -0700 (PDT)
Received: from pps.filterd (m0250811.ppops.net [127.0.0.1])
        by mx0a-0064b401.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27A6Okfj020601;
        Wed, 10 Aug 2022 07:47:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com; h=subject : from :
 to : cc : references : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=PPS06212021;
 bh=CAqfSEfVa3iLWcEiJ0+1DtskzkPotLXUQHTH/BWkZ5g=;
 b=mhqAX0qJgRGnA5oHCpKqjt8LzusIXOeg/XJmyfXwsmsCtSRgWGLmch2Zrgl0jfAKr/G0
 2GSCMosUvx4DIOtmgEFBknyuuPzOMQ58WZ6JaCS/IcXb2EpjMCByh3shKY2XSdlAHiSq
 xjoRqecd/gfrfrEYaC2mJAOxFlIzGSUpgq3qspGDyl8Lp45R1fteAvtz7C2K1K4tI5Gh
 c3xiIlqQ58kBs5ohRH6keyRnkC6d96EwKI3eeeCpEdA0GVot+eyr/6RJuSJ+fFyIl4Ll
 viJ4PNRCfxpQgnBVdhXKqLsrx4NAC6gVnmIl7asHrQZao5/d7BIzreoVedSPdp5CtkjH RQ== 
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2169.outbound.protection.outlook.com [104.47.57.169])
        by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3huwrd0ccg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 10 Aug 2022 07:47:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VzFDVH21lp6NDBYTJkZbDMzbrArGtU5mQjKhzbWLjhoXRIj8fgc6sXpREzhhlXrjjSriFLqw4stvRZJ6TD+kINEBibvtbYcJmwjQ3GwERkvXy0qyOAcKuhYXZNI5AIbPfdrGA5QqCuFk51/LzQAcOsf+RUyH7vqqnjFsM8aQH0mU2JA58aNjoMncFfsyJv1DsoUlgq0UNpFrVQ2GKJEz5PQ4rQpu3FvFjlE438Y+wIOTlTgxKg7GBhow6yjA/H9MHUeZRXiPrAB8ey8tc0sZz4EjuT92zF0SdiWeES5gYeT6HftBi6z44roR3hp1RvqXL7QusCHVTL2jwXCr7ZpcSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CAqfSEfVa3iLWcEiJ0+1DtskzkPotLXUQHTH/BWkZ5g=;
 b=KUC9iMmF4XPAnvalj2HbeIheCd99WI2VLlnO6RPfQBKB56CnRmnBNNL3poN8mbbMhYuwY2UUKdO5sWZPzOgQehm2fFpkpDG3WRpiTCGDd4QHPWoSpxfRSmPVt0InIRiVOmRHD7J8A2N4pBnXcHlege8b4fSgTJ9ek6C07Hs8I2XfbQNwSvJfvPwt5v1Xot4nQtPZo5V18UJdXQ2hgiiQI17Uuq3V7yJc8EDwlzetYworUWfeVJCMMOr9F2ogrSJ+nysFfW13MUhGmuRXnzgxMosU9sU08Oa8UAL1gDX0igle6K+ffvBSOvLVo88m+Rq0vjU66LmwDQpZw5ZpYiM1IQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from CH0PR11MB5348.namprd11.prod.outlook.com (2603:10b6:610:bb::16)
 by MWHPR1101MB2253.namprd11.prod.outlook.com (2603:10b6:301:52::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.16; Wed, 10 Aug
 2022 07:47:32 +0000
Received: from CH0PR11MB5348.namprd11.prod.outlook.com
 ([fe80::d504:d329:815b:10ba]) by CH0PR11MB5348.namprd11.prod.outlook.com
 ([fe80::d504:d329:815b:10ba%9]) with mapi id 15.20.5525.011; Wed, 10 Aug 2022
 07:47:31 +0000
Subject: Re: [PATCH] mtd_blkdevs: add mtd_table_mutex lock back to
 blktrans_{open, release} to avoid race condition
From:   Liwei Song <liwei.song@windriver.com>
To:     ChristophHellwig <hch@lst.de>
Cc:     MiquelRaynal <miquel.raynal@bootlin.com>,
        RichardWeinberger <richard@nod.at>,
        VigneshRaghavendra <vigneshr@ti.com>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20220809075753.21950-1-liwei.song@windriver.com>
 <20220809080809.GB14727@lst.de>
 <7f925359-69b0-49b1-cdbb-337912da4f9c@windriver.com>
Message-ID: <4910c707-ad97-362f-911a-79e438e6e8ff@windriver.com>
Date:   Wed, 10 Aug 2022 15:47:23 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
In-Reply-To: <7f925359-69b0-49b1-cdbb-337912da4f9c@windriver.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SL2P216CA0160.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:1b::22) To CH0PR11MB5348.namprd11.prod.outlook.com
 (2603:10b6:610:bb::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bce467d8-f49d-4b86-367a-08da7aa494bf
X-MS-TrafficTypeDiagnostic: MWHPR1101MB2253:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zbwG8NT0Ya7xKqB8BBVEd6ercpdZ/rIJGFA9Ct+mtiZAnZA6w1lGuI3gqMY1KmZ60T1Uzp3quFmlXDfvaA6yy+fPJxer5Y3YjAATavtFaM4cve8ngwnt+iKQoMs8APv4GHilDrsvhR147PH4RYshiAqVfUihHStDR16wF+4Ar+2HtLJPebK7weoEte+z0vfoK2CQEQMjlll0oAFejFvR9idbJrUaifEuKW6gXsddNlEfCL+x4IALQUwjDKAKUBCDVgXp7YG9CF+AhRqn6yX1zi/EmryYEk2Jwze+u7ombNdRtayP4iqtZ4U7QHvBu5qkAZIk7sh3iUgOK7IUIOkikKgsHRKB2IebPC0F5Q18qaRwtIhJK7uUpGoGziXBUzjO9QUFnYuHub7AWzmjpycGVgObz+aC1vMiiBVv/1hHxKsWIFq3HY31rFI1BOmts8Utyc9lDazSl5QMmBPatwpo7nCoKWA6WIG982tumTdwnlfFMZZP9y0izuQtLnYRhCGwxBtdYIyYuADN6D0h9jocywl2yFotZgmyDW1+/zfDJlXLN8fVaeHPoWflk05P85ttRDMCAsYlzXMyDqX2/I0X0hS7iDmQKl5cnyfyi/IKoRpzMDulZOJW7XDY4b3WKDW0u9Rr2J7OMfWCXXXe38b6fvkwtB+LOQG2idw8xyvf/V10fjsx2e/4BhewY2ftpj2o+R3GsCMq9kipuZj6ts/F+g/0Ow6ybUsFyO5gygfKbSht24gwgykfwdk/SwObWgvMw+l9iNtjyaZDfgDJm90AgGJGpSPUmIKqd7usZ3UGC8sMMLKyJ34PnKwtL/jQqeib3hrMZEloEi+7kzbSD3AhGQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR11MB5348.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(346002)(39850400004)(136003)(376002)(396003)(366004)(66946007)(45080400002)(83380400001)(186003)(2616005)(36756003)(31686004)(316002)(54906003)(6916009)(6666004)(53546011)(4326008)(6506007)(6486002)(6512007)(31696002)(2906002)(8676002)(86362001)(26005)(478600001)(66476007)(66556008)(8936002)(5660300002)(38100700002)(41300700001)(44832011)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NEdJM0grdVJ3OVZLTnZGODkvbkhud3BiS3dxR2tmNFk5bjJJZ2NmaVJNaHpw?=
 =?utf-8?B?bmN5eDA5OEtQVnBIaEt6cE11bVJXTWtFUkJFMGFFWDhUeVlxbG9qUGVOcUFL?=
 =?utf-8?B?N3R3UWw0a25OYXUzQXJBY2ZLenRZQjZvRUxHa3JwZGFFTW9kUHZWd1pVVTY0?=
 =?utf-8?B?SGlMS0Rmd3I1TE1rK284bW1OemFYSVpXemFUSFA4cy9zSzRVakRYY1lhN2dO?=
 =?utf-8?B?QXFQclRsa0EyWlhTTVBEZko3ZlZaaWFyTTFxYmF6RC91M0FRWEV4WGU5RE1K?=
 =?utf-8?B?NEQvdHBTM0U0aHFuaDVaMGp4bDFBdlFwWFViRjljZXRpSEFycHR2YkNvZkxv?=
 =?utf-8?B?UlpVbkhnTDVkYm5iWFNCa1liVlZaaHRJUXhLRWdiTHYrSmhJRGNPTU5NZkpF?=
 =?utf-8?B?eFJheFRyRHNTQ1V5U09YeEtlREpoSFArQWhpSGkyeXBNamJ3QkxUQWEwOXp2?=
 =?utf-8?B?Yk51ME9GUkFEYllCN2JGR3JvYW4wQjlpTnAxWUw4V1hXMndpa05wSENaTGsv?=
 =?utf-8?B?Z200c0l0WDFwMUNQaWpoZUxnQkVzd283bkg5aEhvK3BDTUVreGI3d1p6N3Ra?=
 =?utf-8?B?SEhPNDFQZFh6TnE2TUlwZHMxS0RxaHZHZ3c5b1lqWDJNMCtJbjNTbUoyWEJE?=
 =?utf-8?B?YUVWTEx0bStTY3plQ1E4VVJzclRXaXltMGZmVHd3Ymd5VFVBNW1JR2QzUnYz?=
 =?utf-8?B?TlhxSmhkNFhtVWlWWVdMQVd3eHdCYnRaL05sMUZrQXpQYkJEZkdsdjFYSW01?=
 =?utf-8?B?OTE2MzFzSWY5U3JYbXFPa0lyNVNIalFqTUpLZmkwYThYeXJONmJJUWQ4alpN?=
 =?utf-8?B?Y3QzZ215Z2tWTXNrVTlaOVY5YkU1bkRwdXZUR0hxTi90bFl3ZlBtazcwVlNY?=
 =?utf-8?B?QXRybUVXM25qTDB3ZjA4blRxd3Q1S1BRZ29uVkFIaGlROVhrQytNUDFXNlpE?=
 =?utf-8?B?NFRsa3gzZzRrL2xNRWc5MnlIaGNZb3oxVllCTWM0SytGZ3VrL05id0cxWDd2?=
 =?utf-8?B?bGJXdzFFWEtMa05jVE1qUThwZkEwZEFtUkdTTGhndDVSK3Z5Y0xoU0JIYld1?=
 =?utf-8?B?dXo5aktkR2hBRzZGMUpIWGYrQ1NDbUNJZ3UwY2VOVDZMTW1QZEZWd2xJSFU5?=
 =?utf-8?B?SHowTzdaS0dmUVhwZnh2cjZuRkZmZ2syYU8wZU4ySm9QR2lqRjhEOUhaUW8z?=
 =?utf-8?B?SmZjU2hoODBWMWFzVXNiUjdWRm5VMk4vMnJQS1pHQlVxUmZoRnJZTmdjcmJr?=
 =?utf-8?B?NjMxdDZYTmh0NmVCWVlGMnVQZ1lZNzJkMWpjVlg4S25qRkZRWFZmdkZZWVpM?=
 =?utf-8?B?QSt0VG5ReU9jZmlINldDbTIwcFFpSWRjWG5GQ1hDMjRldXpjbU9HNncvcXRr?=
 =?utf-8?B?YzkwT2h1dmlGOElDNWFuYWRKdUVaVk1hUjdpb3liMXJSc1pJempva3VIQ1JC?=
 =?utf-8?B?UXgwVmRxVi90emFxVUtUNWdzeFFoaHN3RGxHZmRFUDdsdm1JRVBVbllPdWVE?=
 =?utf-8?B?QXQ5a0JjazMwN3doNWFHYmVqU1ZCY0tBR09oYk9hRFlLQjYxVU93QitPc1lD?=
 =?utf-8?B?ZHFSbHA4eTAwQ0lkVjYwN2x1dDExbnYvZHJVVzJtV3ZEakpyMWcxNlZpeUFF?=
 =?utf-8?B?dnVYR2tnVGFIU2xTV3ppWlNhdHhOSnBudXdHc2dLK2pLRUpmazZ3QWFsQkVv?=
 =?utf-8?B?ZmRmdHk3aGFwRW1NQ0pwbnZ5dUFyamxJVFJhZ3V2b2Y5WXFsbmovWkxzTWVi?=
 =?utf-8?B?UjkzaXdHUitWcFhEVHIyL3hEM2RGQ2xPU01SZXZsRjUrYnlVS2kvSnJoU2Iy?=
 =?utf-8?B?cTduWnBkNFRFUzhydzBJTkh4UzhKdUVjTWEyMnJjSHpqTG5Ld3Ruc1ZLNVlp?=
 =?utf-8?B?cjRDVXB1dzhtZmRtc0JKdUREaExjVVRVdmk5YmluRUxPdjVTeW1EcHpBN3By?=
 =?utf-8?B?bjBZTWdueUsvZ2hnamRRbFl0eXpsNzJLNlRPOGNoK3dZY28yZFB3NjB2aERH?=
 =?utf-8?B?YkQ3UW4wNVZpR0U1d1hFYmRoeFVsRitqSm1HWFVRMkEvRzFnSytqbjNudnRl?=
 =?utf-8?B?TTQ1WDVMRkNBNHVEeEFQaDhDblRTT3l6b0VlSitwNkVwc3QyNUZ6MXI4d3N6?=
 =?utf-8?B?aWFIWnVTZlhlaVg0enJSWXVJWVBLNllpOEtZYnVnMDcrU0dyK3I2VzVyN2lC?=
 =?utf-8?B?TEE9PQ==?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bce467d8-f49d-4b86-367a-08da7aa494bf
X-MS-Exchange-CrossTenant-AuthSource: CH0PR11MB5348.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2022 07:47:31.7786
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oFV21N3RUTu+DNiqehgRLgVfOIGEYQ9ucbFGFDQloCmxfvrFryhKvYlGJ0sHGxzlV9DGeucexVqHAVHtfU0zLrnXKeor3nG+8GDPxyu5KX0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1101MB2253
X-Proofpoint-GUID: PMfRTWq-VlTnKKk3icdDRuXPSR6uN_Ow
X-Proofpoint-ORIG-GUID: PMfRTWq-VlTnKKk3icdDRuXPSR6uN_Ow
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-10_03,2022-08-09_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0
 priorityscore=1501 malwarescore=0 suspectscore=0 impostorscore=0
 bulkscore=0 mlxlogscore=967 mlxscore=0 lowpriorityscore=0 spamscore=0
 phishscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2208100022
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/9/22 17:03, Liwei Song wrote:
> 
> 
> On 8/9/22 16:08, ChristophHellwig wrote:
>> On Tue, Aug 09, 2022 at 03:57:53PM +0800, Liwei Song wrote:
>>> without lock mtd_table_mutex in blktrans_{open, release}, there will
>>> be a race condition when access devices /dev/mtd1 and /dev/mtdblock1
>>> at the same time with a high frequency open and close test:
>>>
>>> kernel BUG at drivers/mtd/mtdcore.c:1221!
>>> lr : blktrans_release+0xb0/0x120
>>
>> This does not seem on a current mainline kernel and seems to be
>> a somewhat incomplete backtrace.  Can you send the full dmesg of
>> a latest mainline run and maybe share the reproducer?
> 
> Yes, the kernel I used is 5.15, unfortunately this is the latest version
> that worked on my board, the whole log is:
> 
> [   31.301343] ------------[ cut here ]------------
> [   31.301343] ------------[ cut here ]------------
> [   31.301365] kernel BUG at drivers/mtd/mtdcore.c:1221!
> [   31.314981] kernel BUG at drivers/mtd/mtdcore.c:1221!
> [   31.329328] Internal error: Oops - BUG: 0 [#1] PREEMPT SMP
> [   31.374117] Modules linked in: 8021q sch_fq_codel openvswitch nsh nf_conncount nf_nat nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 fuse
> [   31.395820] CPU: 2 PID: 390 Comm: a.out Not tainted 5.15.58-yocto-standard #1
> [   31.412672] Hardware name: SoCFPGA Agilex SoCDK (DT)
> [   31.427372] pstate: 60000005 (nZCv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
> [   31.444058] pc : __put_mtd_device+0x4c/0x84
> [   31.457977] lr : put_mtd_device+0x3c/0x5c
> [   31.464122] sp : ffff80000c26bc50
> [   31.466126] x29: ffff80000c26bc50 x28: ffff000285785100 x27: 0000000000000000
> [   31.471945] x26: 0000000045585401 x25: 0000000000000000 x24: ffff000285785768
> [   31.477762] x23: ffff0002803ee520 x22: ffff0002804f8900 x21: ffff000281956800
> [   31.483580] x20: ffff000281956800 x19: ffff000281955080 x18: 0000000000000000
> [   31.489402] x17: 0000000000000000 x16: 0000000000000000 x15: 0000000000000000
> [   31.495219] x14: 0000000000000000 x13: 0000000000000000 x12: 0000000000000000
> [   31.501037] x11: 0000000000000000 x10: 0000000000000000 x9 : ffff8000088a79b0
> [   31.506855] x8 : ffff80000c26bcb0 x7 : 0000000000000000 x6 : 0000000000000001
> [   31.512673] x5 : ffff000280959488 x4 : 0000000000000000 x3 : 0000000000000000
> [   31.518491] x2 : ffff000281956800 x1 : 00000000ffffffff x0 : ffff000281955080
> [   31.524310] Call trace:
> [   31.525450]  __put_mtd_device+0x4c/0x84
> [   31.527979]  put_mtd_device+0x3c/0x5c
> [   31.530333]  mtdchar_close+0x3c/0x84
> [   31.532604]  __fput+0x78/0x220
> [   31.534357]  ____fput+0x1c/0x30
> [   31.536193]  task_work_run+0x88/0xc0
> [   31.538467]  do_notify_resume+0x384/0x12a0
> [   31.541261]  el0_svc+0x6c/0x80
> [   31.543015]  el0t_64_sync_handler+0xa4/0x130
> [   31.545977]  el0t_64_sync+0x1a0/0x1a4
> [   31.548338] Code: b9448841 51000421 b9048841 36ffff41 (d4210000) 
> [   31.553115] ---[ end trace 9652b26ea1d7daa1 ]---
> [   31.556420] Internal error: Oops - BUG: 0 [#2] PREEMPT SMP
> [   31.556420] note: a.out[390] exited with preempt_count 1
> [   31.560588] Modules linked in: 8021q sch_fq_codel openvswitch nsh nf_conncount nf_nat nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 fuse
> [   31.575265] CPU: 3 PID: 391 Comm: a.out Tainted: G      D           5.15.58-yocto-standard #1
> [   31.582466] Hardware name: SoCFPGA Agilex SoCDK (DT)
> [   31.586115] pstate: 40000005 (nZcv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
> [   31.591757] pc : __put_mtd_device+0x4c/0x84
> [   31.594642] lr : blktrans_release+0xb0/0x120
> [   31.597603] sp : ffff80000c22bc20
> [   31.599608] x29: ffff80000c22bc20 x28: ffff000285785e80 x27: 0000000000000000
> [   31.605428] x26: 0000000045585401 x25: 0000000000000000 x24: ffff0002857864e8
> [   31.611247] x23: ffff0002803ee520 x22: ffff0002803e3470 x21: ffff0002803e3400
> [   31.617066] x20: ffff0002803e3020 x19: ffff000281955080 x18: 0000000000000000
> [   31.622884] x17: 0000000000000000 x16: 0000000000000000 x15: 0000000000000000
> [   31.628702] x14: 0000000000000000 x13: 0000000000000000 x12: 0000000000000000
> [   31.634519] x11: 0000000000000000 x10: 0000000000000000 x9 : ffff8000088b0230
> [   31.640337] x8 : ffff80000c22bb90 x7 : 0000000000000000 x6 : 0000000000000001
> [   31.646155] x5 : 0000000000000000 x4 : 0000000000000000 x3 : 0000000000000000
> [   31.651973] x2 : ffff000281956800 x1 : 00000000ffffffff x0 : ffff000281955080
> [   31.657792] Call trace:
> [   31.658933]  __put_mtd_device+0x4c/0x84
> [   31.661462]  blktrans_release+0xb0/0x120
> [   31.664077]  blkdev_put+0xd4/0x210
> [   31.666175]  blkdev_close+0x34/0x50
> [   31.668355]  __fput+0x78/0x220
> [   31.670108]  ____fput+0x1c/0x30
> [   31.671943]  task_work_run+0x88/0xc0
> [   31.674217]  do_notify_resume+0x384/0x12a0
> [   31.677009]  el0_svc+0x6c/0x80
> [   31.678762]  el0t_64_sync_handler+0xa4/0x130
> [   31.681723]  el0t_64_sync+0x1a0/0x1a4
> [   31.684082] Code: b9448841 51000421 b9048841 36ffff41 (d4210000) 
> [   31.688857] ---[ end trace 9652b26ea1d7daa2 ]---
> [   31.692161] note: a.out[391] exited with preempt_count 1
> 
> the testcase  a.out is compiled from below code:
> when run the case /dev/mtd1 and /dev/mtdblock1 will be used for open and close test.
> 
> #include <stdio.h>
> #include <stdlib.h>
> #include <sys/types.h>
> #include <sys/stat.h>
> #include <fcntl.h>
> #include <string.h>
> #include <signal.h>
> #include <unistd.h>
> 
> int main(int argc, char *argv[])
> {
>     pid_t pid, pid1, pid2;
>     int fd,ret = 0;
>     int status = 0;
>     char device_char[12]="/dev/mtd";
>     char device_block[17]="/dev/mtdblock";
> 
>     strcat(device_char, argv[1]);
>     strcat(device_block, argv[1]);
> 
>     pid1 = fork();
>     if(pid1 == 0){
>         while(1){
>             fd = open(device_char, O_SYNC|O_RDWR);
>             ret = close(fd);
>         }
>     }
>     pid2 = fork();
>     if(pid2 == 0){
>         while(1){
>             fd = open(device_block, O_SYNC|O_RDWR);
>             ret = close(fd);
>         }
>     }
>     sleep(10);
>     kill(pid1, SIGKILL);
>     kill(pid2, SIGKILL);
>     pid = wait(&status);
>     pid = wait(&status);
>     return 0;
> } 
> 
>>
>>> diff --git a/drivers/mtd/mtd_blkdevs.c b/drivers/mtd/mtd_blkdevs.c
>>> index b8ae1ec14e17..147e4a11dfe4 100644
>>> --- a/drivers/mtd/mtd_blkdevs.c
>>> +++ b/drivers/mtd/mtd_blkdevs.c
>>> @@ -188,6 +188,8 @@ static int blktrans_open(struct block_device *bdev, fmode_t mode)
>>>  
>>>  	kref_get(&dev->ref);
>>>  
>>> +	if (!mutex_trylock(&mtd_table_mutex))
>>> +		return ret;
>>
>> No, that's not really the solution.
>>
>> Turning the kref_get above into a kref_get_unless_zero might be better
>> path to look into.
> 
> Thanks, I will have a look at this.

Hi Christoph,

It seems this way can not stop the race to decrease/increase mtd->usecount,
the race condition is between mtdchar_{open, close}()->(get)put_mtd_device()->__(get)put_mtd_device()
and blktrans_{open,release}()-> __(get)put_mtd_device(), when operate the same device
as char device(/dev/mtd1) and block device(/dev/mtdblock1), the original fix for
this issue is 073db4a51ee4 ("mtd: fix: avoid race condition when accessing mtd->usecount"),
Could you give some suggestion about this?

Thanks,
Liwei.



> 
> Liwei.
> 
> 
>>
