Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3141749494C
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jan 2022 09:20:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359151AbiATIUG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jan 2022 03:20:06 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:33880 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231338AbiATIUE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jan 2022 03:20:04 -0500
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20K639oo014094;
        Thu, 20 Jan 2022 08:19:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : content-transfer-encoding :
 mime-version; s=corp-2021-07-09;
 bh=XRxYmOWoo7H1yyg0lFkdT9b220d/Rrqokxk5Bb+BLT4=;
 b=TKZEQyqLhdaRET8VSQAF2jaLnK9UNjkYqFID93+2hRDljyg9KbgvkdGzRfiUcXjMSn40
 ZnLPzC1ovguohw/LNGn9hPlw4FZEd1xD6tgYsaNReVIXeGP5+J91a9+lo9q3F8qsIi/S
 EhpRQyuP/ZO98OGZ922MF3PQ03yawTWPfPPjJAlBLF1iazHf8lh11uAKYQXql+58emSY
 lAgs1FAEmftYYFWkuAXZF1IkjcrlH21y4a/o+i3VbHvTSzuVlvq0cpoDuj8EG54/fj5X
 Z5+yZdp9xGGO7llvH21M2dkV7bdNcm4FOLL6PewZN/1MFSghX+D8xg++C+He6E7DyTK2 ZQ== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3dnc51fb0d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 20 Jan 2022 08:19:27 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 20K8GwNd150614;
        Thu, 20 Jan 2022 08:19:26 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2103.outbound.protection.outlook.com [104.47.58.103])
        by aserp3030.oracle.com with ESMTP id 3dpvj1rkyp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 20 Jan 2022 08:19:25 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gg8qlH4ZuzpjBMm5KsYQCTE+myISDq802yHPgqkjuVNmsShpiJoQ8B4UpXoaBjPrU/zVp91BA4wlYwn74s0lFCnNfGhY9MVct9KkVhAIbAMO/OrJZ5bGH5ImBvQXPIpykLyxRYxzVdU72DVhtp0iNmwkvZJQf6nYXXns3LSmfs9/dq8rN67HMrPGH6Z4dOsqk5adf6jJO8pzuqRkKSyE6MNq10C9cM23v07Yo63KpP5PnyvnnC9tDCFQ1VDd+2C9isukZHWIy2Jx9VAPkjoMpmCkyTyyrx+Oj9bDXZ7HcTVSpoNHmgV9gvRU3fMDp7YcErefy4jnon96rk1PwX6vqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XRxYmOWoo7H1yyg0lFkdT9b220d/Rrqokxk5Bb+BLT4=;
 b=LOXqzSj29tvU8r5y952kNZ7yUZjHMefdcf3gGWARJTeuAF1OyZUpHqHp9Kpcss89UVPJVytxYlf0xHsD5aYzYfSl7y2AvFh3+iTVQmN4aGrOStEWYBuDRcVZUyBIvQ5Aeum31cXKSA8F3q/ll8emMxAn+8dJwa8jR0fPDWbWZczviT7YpnCndF/4jjI6ucyIs8qbqJ0LeM6Uu5Nqfko4zqboE6cJhHQvyXo36gf7hyOKw8eSaKJFthDwsm3tV4sVBzDhY0+u9ZWOov0/4PlyGW102wLrJavdJPT46rbkznEAJAlFTXJEKWPQvObZRWqMJamWqz6Nr8AwNUZ8mjH15g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XRxYmOWoo7H1yyg0lFkdT9b220d/Rrqokxk5Bb+BLT4=;
 b=NxytWB61Cx38DKl/q02STf4jjitiZDJnGFemHXoRB1um4w6CvuLIzDADyW95QEndPtM2He7hYHLYbG8uB3pkiZyxgmw/uaauSe4ur6ANdEw9+XTJqEnR31AMnKrhBn7qwbLQadfOhylLxabTF/0H+GBHEwLbShYS7ewIIWwlevA=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by DS7PR10MB5327.namprd10.prod.outlook.com
 (2603:10b6:5:3b1::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.8; Thu, 20 Jan
 2022 08:19:23 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::c13b:5812:a403:6d96]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::c13b:5812:a403:6d96%6]) with mapi id 15.20.4909.008; Thu, 20 Jan 2022
 08:19:24 +0000
Date:   Thu, 20 Jan 2022 11:19:11 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     kbuild@lists.01.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     lkp@intel.com, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: sound/soc/qcom/qdsp6/topology.c:336 audioreach_parse_sg_tokens()
 error: potentially dereferencing uninitialized 'sg'.
Message-ID: <202201201534.RoB5fAbP-lkp@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: MR1P264CA0077.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:501:3f::9) To MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 152dd2f0-c57e-4eb2-a760-08d9dbed9115
X-MS-TrafficTypeDiagnostic: DS7PR10MB5327:EE_
X-Microsoft-Antispam-PRVS: <DS7PR10MB5327A8B2C9024C2CD3893C258E5A9@DS7PR10MB5327.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:826;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: c7fRRXjqhegVc4ksZVUUgrmHvSLMtKjdsu/RCSzA8d4YwxZT/FhZXrlOQIg5zRNOGbjQzt2up7mJP34Ta3tOcIQIxD5Uz0AQLJ+tYIAzdaY7+EKU2LDHigfqwxeeqGI9iShkfPWkBToZ+HbyiLi9MroVMVqjVvlVZvl+qVPr0xyzCg/YRKJ3RTYjegubyC1CaEOE4+e7XuEMb8uIGLPDcU4WQ+Gte7cqakK6QGXmLOPIZjkRz8DPxApY8WfBwQeL8HmKlYZU12AkfEoCQumSnUjIhfhjbeO9NvmgWQVr2VF3kwdZSgtqg/O5Aay7XL3wKjEvQPpcvJrXWFQq+XBYNCjzoYzjivRD2msp8vagsGKnV8yYnSoL7ACKHpHwuXhSOdDOwyjfjDpnBERL5OnsiU4I2aogPV3fghufvgmI32AB1S/U1MHNbgABjQ5vEFmSGyYC2lQJJZyqFn19uJqZzPxM3KDUUkZqxc8IVEw6Ni+9TRRcq3gJiHCoBRpsGKkU0miPiwGEz2XRiHwf4iWjnDoNt+MasPAZ3raPibAQA/AppkamfpWalWepYMAkwOgMIYluBMGxG0yxSfY63t2Gk7Sw6wWjrTbT1LAZjeAbhm4cMQYJ1jU9qvoXTyWQOqHGQ0TMGYHxEqmdgO0uR7zDdL8Rqgm0DeUN48DAZDpklOCCIquvS2mByBgO38MHHhmWOhASBTjIAxAF/0bI7SccP0ESuzx+u4EKHT0T4fx+6fSSGfoD6GhxS6eB8JyLW5GoKhYnbmOyY2e1/O2A+XO/byddZf/n4WgXnl2Tvi4l6MbqcFob8bJhYrddxxAoLJJWHOG8FH/4YUEltLKV6P6C2g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(83380400001)(8676002)(8936002)(186003)(36756003)(966005)(6666004)(66946007)(54906003)(9686003)(6512007)(2906002)(6916009)(6486002)(86362001)(4001150100001)(508600001)(52116002)(4326008)(66556008)(66476007)(38100700002)(6506007)(38350700002)(44832011)(26005)(30864003)(1076003)(5660300002)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WWYzTEZDVHM3dWRTZytQQ2w1SjVKYjI0VnFic0VKd1BmY1o4bGpDRDNlWlJt?=
 =?utf-8?B?NGFPam81dVZ4NTE2c051VFRnRU5rYWxwL1M5akVlWDVsS1ZNb2ZXN29QS3M1?=
 =?utf-8?B?M0paTUQzRFFmWVl1cTRZSEIrT0FWeEZqUmllQzk4N0JBaUM1SGVkVVlBcC9n?=
 =?utf-8?B?MHVYMUtEdzJvYzFycCtkOURhaUNRUUY3OXlGUWNmRWxWUjdHZ1RzOG1ETUF2?=
 =?utf-8?B?NjVSYnZNV3MwMUNsVFBXRVV4aXkvUmkxWTNML0xsbGtrMzl2dm1yQjNmSjhF?=
 =?utf-8?B?cUQ4NXNMWUFMc1Z3QXF5MmwzVGlPbHZsUm54Y3g2VFAxSHMzYmw4d3NvWE9x?=
 =?utf-8?B?b3RHWmVJVlNNRTc1L0pLeUg4YkgyakMrdHQ1MWJGQ2ZRb0loYmszWXRNOWNV?=
 =?utf-8?B?eFNpUm9wSUJLYnBOVTE1UytLVW5XSnVIa3dJbzVZdTdIQjhHMk0yanlkOXNT?=
 =?utf-8?B?dlZreHFTbU5UVno3M25qUDNsUUpjTEFJQ0psbEt0d2ViNFNJMHpTVnA3S004?=
 =?utf-8?B?Z09wSE9zQjNKTjhMNll0UGVTUEx6UXZyU2FzZHlCZlNvVmJ2Q05Ma0tTNEl2?=
 =?utf-8?B?VUtEUWUyeXRZVHBZWStSK2t3M3l2ZWdWVnY5cThBQ1puZDN5aUIzQXRmNkhw?=
 =?utf-8?B?UkFKVGFEeVNEb2hqMEE2aE11VEdOei96d3l4eHp0YlFTTjRIa05oNnpxMDlU?=
 =?utf-8?B?VEk3Uld4WTJQUzkvU0gzSjNSRjRNVlg0S055TzA5Vk02bWRoSi9YZWhGWUY3?=
 =?utf-8?B?YW1jZERGSXBpc1gvb2MrMEFnSmE2dnRTa1VFNCtmRk0vVVhQVXlsKzd4L29h?=
 =?utf-8?B?dlpQSjA1L0lHYlNpL3g0OCt0ZStGeEZoVVhHZDRQK0xHMFZIejdrOXJES3lS?=
 =?utf-8?B?NXErc1h3U2JQa044dXhNR0wrb2YwZTZXLzBRQWhnc1RwMUdQQUQvMU9Bdkdl?=
 =?utf-8?B?WVlNaVBPT0NCK25xNjhLWHR4eVFaSDFHY3Bua0VMVVA1TEhWKzhzTCtqQURN?=
 =?utf-8?B?czlKcENoUGRHTmxxSEU5UXk2VEtoMXJyUEw5THJQUGs2UXFHclhVYkpEd1d6?=
 =?utf-8?B?SWRvVzJyY3ZwUGVlZVFMZmdraDFRZElzMmlXM2pWNlBWYkJrTm5BWjE3NFlK?=
 =?utf-8?B?WktZRXdLSnpJaEFaRGE1cVRLU1RXWm9uNkZhandQV2tKOTVNUXdHRk90cTlL?=
 =?utf-8?B?WHcrOHlDQ0JqYlo3OGM0cVBjVmF4NHJDcHhDSU5QMzNnYUFZYk1tQ3VIeXkw?=
 =?utf-8?B?YytpMC8zRFhMQ2dxbVQ0SzNxdTZzZ3YrcGE3UWFDUURvd0ltUXkvd2wrNlkz?=
 =?utf-8?B?MEZsKy9mdUk1SEhGNSt3VytUYUR0aUFvcDdRUmpwRGxHZW9BYlpUNHpNa0c4?=
 =?utf-8?B?ejlxaTlBZ0tOY3NLLzI3cVMvNWUyS3hhc01SM0t1M1hURTJ0RWVQR3o0eWJG?=
 =?utf-8?B?cmJCdlE4M0xmUndNTFBHWW5XWUdmY3FsQXFrckliU3MrTzJ5L1ZTekgySzFz?=
 =?utf-8?B?L3IyQjVFTjcwQjMxM3drYVN6ck5kdHdSWDc2aUJTeWNSc0NxbER0cDBtUnRo?=
 =?utf-8?B?V2xDRm9KZmpCaUpkc3k4Z2xKUWp0NmZsMmhQcFpnRkdFK0g5dkhvK1ppTHFp?=
 =?utf-8?B?Rk45WHB5T1BNdVVEc0VFQVMrVHUyS1ZJWTMvRmRpVGhpazkxQlhzNjRNQVJW?=
 =?utf-8?B?UFBVK01lK1ZiY2JucTBObDFEQytYUlkyZjJEaW9pZ1krd2ZmT3gxTjY4L2hl?=
 =?utf-8?B?MjVnRHQxa0dxVWJHZnR2bjFyaUFqMnhHNVJZWU5lY1R0SG05a1dWMk0vQWlY?=
 =?utf-8?B?aUlGTTVvMDhjY2pnVDkyZW9JYTlSUlZvWlJER2RaL0tIcHNZeURiOGxjUSta?=
 =?utf-8?B?YkM3SUdPUHBUZC9Qb0J4NzNIa3A1VEJTczZibmpjTWdEQkJCY205Qjk4c2hZ?=
 =?utf-8?B?SzRiZXVucjgvRjRmK1E4YkdyTUlZOXNzL1ZoWGlvSUV1L3FBUFM5b0pYNkV6?=
 =?utf-8?B?ZXdlcmN4anZ4SldrMm1rc2hmNEVoamJGMG9kNVhrSEJOS01nUHU5QTRQdjJ3?=
 =?utf-8?B?ZEhMMm91OHgxUnIwT2FpTi9KUWlZdmF4amN3VGg4Y1duYktBZG9Ob01TK3RE?=
 =?utf-8?B?MFhaanplckE4dzhMSEhaT1VNTlNPV3VuaVFqY1FGU3BEcTQzVDZURUlWMU9y?=
 =?utf-8?B?Q2JKMVErSUVsRjE3U2RaY3RzcytIRkE1MzEwQnBsVXNDZGtBRW5oc2I4UTdE?=
 =?utf-8?Q?Y1hrQ6vabLiLPEYBBCZXgg+b0nNXgoPaJLfZMj5kzQ=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 152dd2f0-c57e-4eb2-a760-08d9dbed9115
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2022 08:19:23.9514
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GqAorSw6/Q5ML7UA07H0O7wkRcGFVNViSUHjE+opDSexeGhqnukSq0BNx62C5+4U53gsDNtZQyRc1qNkxWF4JDlafOKXxjanZ21j3IMep2U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5327
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10232 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 spamscore=0 malwarescore=0
 mlxlogscore=999 bulkscore=0 adultscore=0 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2201200043
X-Proofpoint-GUID: 5Au9dSh9t-jW-z6e6uLOvZH7waWG9oPV
X-Proofpoint-ORIG-GUID: 5Au9dSh9t-jW-z6e6uLOvZH7waWG9oPV
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   1d1df41c5a33359a00e919d54eaebfb789711fdc
commit: 36ad9bf1d93d66b901342eab9f8ed6c1537655a6 ASoC: qdsp6: audioreach: add topology support
config: arc-randconfig-m031-20220117 (https://download.01.org/0day-ci/archive/20220120/202201201534.RoB5fAbP-lkp@intel.com/config)
compiler: arceb-elf-gcc (GCC) 11.2.0

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>

New smatch warnings:
sound/soc/qcom/qdsp6/topology.c:336 audioreach_parse_sg_tokens() error: potentially dereferencing uninitialized 'sg'.
sound/soc/qcom/qdsp6/topology.c:355 audioreach_parse_sg_tokens() error: uninitialized symbol 'sg'.
sound/soc/qcom/qdsp6/topology.c:382 audioreach_parse_cont_tokens() error: potentially dereferencing uninitialized 'cont'.
sound/soc/qcom/qdsp6/topology.c:402 audioreach_parse_cont_tokens() error: uninitialized symbol 'cont'.

Old smatch warnings:
sound/soc/qcom/qdsp6/topology.c:339 audioreach_parse_sg_tokens() error: potentially dereferencing uninitialized 'sg'.
sound/soc/qcom/qdsp6/topology.c:342 audioreach_parse_sg_tokens() error: potentially dereferencing uninitialized 'sg'.
sound/soc/qcom/qdsp6/topology.c:357 audioreach_parse_sg_tokens() error: uninitialized symbol 'sg'.
sound/soc/qcom/qdsp6/topology.c:385 audioreach_parse_cont_tokens() error: potentially dereferencing uninitialized 'cont'.
sound/soc/qcom/qdsp6/topology.c:388 audioreach_parse_cont_tokens() error: potentially dereferencing uninitialized 'cont'.
sound/soc/qcom/qdsp6/topology.c:391 audioreach_parse_cont_tokens() error: potentially dereferencing uninitialized 'cont'.

vim +/sg +336 sound/soc/qcom/qdsp6/topology.c

36ad9bf1d93d66 Srinivas Kandagatla 2021-10-26  303  static struct audioreach_sub_graph *audioreach_parse_sg_tokens(struct q6apm *apm,
36ad9bf1d93d66 Srinivas Kandagatla 2021-10-26  304  						       struct snd_soc_tplg_private *private)
36ad9bf1d93d66 Srinivas Kandagatla 2021-10-26  305  {
36ad9bf1d93d66 Srinivas Kandagatla 2021-10-26  306  	struct snd_soc_tplg_vendor_value_elem *sg_elem;
36ad9bf1d93d66 Srinivas Kandagatla 2021-10-26  307  	struct snd_soc_tplg_vendor_array *sg_array;
36ad9bf1d93d66 Srinivas Kandagatla 2021-10-26  308  	struct audioreach_graph_info *info = NULL;
36ad9bf1d93d66 Srinivas Kandagatla 2021-10-26  309  	int graph_id, sub_graph_id, tkn_count = 0;
36ad9bf1d93d66 Srinivas Kandagatla 2021-10-26  310  	struct audioreach_sub_graph *sg;
36ad9bf1d93d66 Srinivas Kandagatla 2021-10-26  311  	bool found;
36ad9bf1d93d66 Srinivas Kandagatla 2021-10-26  312  
36ad9bf1d93d66 Srinivas Kandagatla 2021-10-26  313  	sg_array = audioreach_get_sg_array(private);
36ad9bf1d93d66 Srinivas Kandagatla 2021-10-26  314  	sg_elem = sg_array->value;
36ad9bf1d93d66 Srinivas Kandagatla 2021-10-26  315  
36ad9bf1d93d66 Srinivas Kandagatla 2021-10-26  316  	while (tkn_count <= (le32_to_cpu(sg_array->num_elems) - 1)) {
36ad9bf1d93d66 Srinivas Kandagatla 2021-10-26  317  		switch (le32_to_cpu(sg_elem->token)) {

This code is very trustful of endian data.  Probably that means it comes
from the firmware or something?  People will file for CVEs when they
find that we're trusting firmware to be correct...

Also I really wish that some day we will be able to turn on GCC's
unitialized variable checking again.  There is no way I'm going to put
up with looking through these warnings for year after year.  At least
fix the W=2 uninitialized variable warnings.

sound/soc/qcom/qdsp6/topology.c:342:20: warning: ‘sg’ may be used uninitialized in this function [-Wmaybe-uninitialized]
    sg->scenario_id = le32_to_cpu(sg_elem->value);
sound/soc/qcom/qdsp6/topology.c:310:31: note: ‘sg’ was declared here
  struct audioreach_sub_graph *sg;
                               ^~
36ad9bf1d93d66 Srinivas Kandagatla 2021-10-26  318  		case AR_TKN_U32_SUB_GRAPH_INSTANCE_ID:
36ad9bf1d93d66 Srinivas Kandagatla 2021-10-26  319  			sub_graph_id = le32_to_cpu(sg_elem->value);
36ad9bf1d93d66 Srinivas Kandagatla 2021-10-26  320  			sg = audioreach_tplg_alloc_sub_graph(apm, sub_graph_id, &found);
36ad9bf1d93d66 Srinivas Kandagatla 2021-10-26  321  			if (IS_ERR(sg)) {
36ad9bf1d93d66 Srinivas Kandagatla 2021-10-26  322  				return sg;
36ad9bf1d93d66 Srinivas Kandagatla 2021-10-26  323  			} else if (found) {
36ad9bf1d93d66 Srinivas Kandagatla 2021-10-26  324  				/* Already parsed data for this sub-graph */
36ad9bf1d93d66 Srinivas Kandagatla 2021-10-26  325  				return sg;
36ad9bf1d93d66 Srinivas Kandagatla 2021-10-26  326  			}
36ad9bf1d93d66 Srinivas Kandagatla 2021-10-26  327  			break;
36ad9bf1d93d66 Srinivas Kandagatla 2021-10-26  328  		case AR_TKN_DAI_INDEX:
36ad9bf1d93d66 Srinivas Kandagatla 2021-10-26  329  			/* Sub graph is associated with predefined graph */
36ad9bf1d93d66 Srinivas Kandagatla 2021-10-26  330  			graph_id = le32_to_cpu(sg_elem->value);
36ad9bf1d93d66 Srinivas Kandagatla 2021-10-26  331  			info = audioreach_tplg_alloc_graph_info(apm, graph_id, &found);
36ad9bf1d93d66 Srinivas Kandagatla 2021-10-26  332  			if (IS_ERR(info))
36ad9bf1d93d66 Srinivas Kandagatla 2021-10-26  333  				return ERR_CAST(info);
36ad9bf1d93d66 Srinivas Kandagatla 2021-10-26  334  			break;
36ad9bf1d93d66 Srinivas Kandagatla 2021-10-26  335  		case AR_TKN_U32_SUB_GRAPH_PERF_MODE:
36ad9bf1d93d66 Srinivas Kandagatla 2021-10-26 @336  			sg->perf_mode = le32_to_cpu(sg_elem->value);
36ad9bf1d93d66 Srinivas Kandagatla 2021-10-26  337  			break;
36ad9bf1d93d66 Srinivas Kandagatla 2021-10-26  338  		case AR_TKN_U32_SUB_GRAPH_DIRECTION:
36ad9bf1d93d66 Srinivas Kandagatla 2021-10-26  339  			sg->direction = le32_to_cpu(sg_elem->value);
36ad9bf1d93d66 Srinivas Kandagatla 2021-10-26  340  			break;
36ad9bf1d93d66 Srinivas Kandagatla 2021-10-26  341  		case AR_TKN_U32_SUB_GRAPH_SCENARIO_ID:
36ad9bf1d93d66 Srinivas Kandagatla 2021-10-26  342  			sg->scenario_id = le32_to_cpu(sg_elem->value);
36ad9bf1d93d66 Srinivas Kandagatla 2021-10-26  343  			break;
36ad9bf1d93d66 Srinivas Kandagatla 2021-10-26  344  		default:
36ad9bf1d93d66 Srinivas Kandagatla 2021-10-26  345  			dev_err(apm->dev, "Not a valid token %d for graph\n", sg_elem->token);
36ad9bf1d93d66 Srinivas Kandagatla 2021-10-26  346  			break;
36ad9bf1d93d66 Srinivas Kandagatla 2021-10-26  347  
36ad9bf1d93d66 Srinivas Kandagatla 2021-10-26  348  		}
36ad9bf1d93d66 Srinivas Kandagatla 2021-10-26  349  		tkn_count++;
36ad9bf1d93d66 Srinivas Kandagatla 2021-10-26  350  		sg_elem++;
36ad9bf1d93d66 Srinivas Kandagatla 2021-10-26  351  	}
36ad9bf1d93d66 Srinivas Kandagatla 2021-10-26  352  
36ad9bf1d93d66 Srinivas Kandagatla 2021-10-26  353  	/* Sub graph is associated with predefined graph */
36ad9bf1d93d66 Srinivas Kandagatla 2021-10-26  354  	if (info)
36ad9bf1d93d66 Srinivas Kandagatla 2021-10-26 @355  		audioreach_tplg_add_sub_graph(sg, info);
36ad9bf1d93d66 Srinivas Kandagatla 2021-10-26  356  
36ad9bf1d93d66 Srinivas Kandagatla 2021-10-26  357  	return sg;
36ad9bf1d93d66 Srinivas Kandagatla 2021-10-26  358  }
36ad9bf1d93d66 Srinivas Kandagatla 2021-10-26  359  
36ad9bf1d93d66 Srinivas Kandagatla 2021-10-26  360  static struct audioreach_container *audioreach_parse_cont_tokens(struct q6apm *apm,
36ad9bf1d93d66 Srinivas Kandagatla 2021-10-26  361  							 struct audioreach_sub_graph *sg,
36ad9bf1d93d66 Srinivas Kandagatla 2021-10-26  362  							 struct snd_soc_tplg_private *private)
36ad9bf1d93d66 Srinivas Kandagatla 2021-10-26  363  {
36ad9bf1d93d66 Srinivas Kandagatla 2021-10-26  364  	struct snd_soc_tplg_vendor_value_elem *cont_elem;
36ad9bf1d93d66 Srinivas Kandagatla 2021-10-26  365  	struct snd_soc_tplg_vendor_array *cont_array;
36ad9bf1d93d66 Srinivas Kandagatla 2021-10-26  366  	struct audioreach_container *cont;
36ad9bf1d93d66 Srinivas Kandagatla 2021-10-26  367  	int container_id, tkn_count = 0;
36ad9bf1d93d66 Srinivas Kandagatla 2021-10-26  368  	bool found = false;
36ad9bf1d93d66 Srinivas Kandagatla 2021-10-26  369  
36ad9bf1d93d66 Srinivas Kandagatla 2021-10-26  370  	cont_array = audioreach_get_cont_array(private);
36ad9bf1d93d66 Srinivas Kandagatla 2021-10-26  371  	cont_elem = cont_array->value;
36ad9bf1d93d66 Srinivas Kandagatla 2021-10-26  372  
36ad9bf1d93d66 Srinivas Kandagatla 2021-10-26  373  	while (tkn_count <= (le32_to_cpu(cont_array->num_elems) - 1)) {
36ad9bf1d93d66 Srinivas Kandagatla 2021-10-26  374  		switch (le32_to_cpu(cont_elem->token)) {
36ad9bf1d93d66 Srinivas Kandagatla 2021-10-26  375  		case AR_TKN_U32_CONTAINER_INSTANCE_ID:
36ad9bf1d93d66 Srinivas Kandagatla 2021-10-26  376  			container_id = le32_to_cpu(cont_elem->value);
36ad9bf1d93d66 Srinivas Kandagatla 2021-10-26  377  			cont = audioreach_tplg_alloc_container(apm, sg, container_id, &found);
36ad9bf1d93d66 Srinivas Kandagatla 2021-10-26  378  			if (IS_ERR(cont) || found)/* Error or Already parsed container data */
36ad9bf1d93d66 Srinivas Kandagatla 2021-10-26  379  				return cont;
36ad9bf1d93d66 Srinivas Kandagatla 2021-10-26  380  			break;
36ad9bf1d93d66 Srinivas Kandagatla 2021-10-26  381  		case AR_TKN_U32_CONTAINER_CAPABILITY_ID:
36ad9bf1d93d66 Srinivas Kandagatla 2021-10-26 @382  			cont->capability_id = le32_to_cpu(cont_elem->value);
36ad9bf1d93d66 Srinivas Kandagatla 2021-10-26  383  			break;
36ad9bf1d93d66 Srinivas Kandagatla 2021-10-26  384  		case AR_TKN_U32_CONTAINER_STACK_SIZE:
36ad9bf1d93d66 Srinivas Kandagatla 2021-10-26  385  			cont->stack_size = le32_to_cpu(cont_elem->value);
36ad9bf1d93d66 Srinivas Kandagatla 2021-10-26  386  			break;
36ad9bf1d93d66 Srinivas Kandagatla 2021-10-26  387  		case AR_TKN_U32_CONTAINER_GRAPH_POS:
36ad9bf1d93d66 Srinivas Kandagatla 2021-10-26  388  			cont->graph_pos = le32_to_cpu(cont_elem->value);
36ad9bf1d93d66 Srinivas Kandagatla 2021-10-26  389  			break;
36ad9bf1d93d66 Srinivas Kandagatla 2021-10-26  390  		case AR_TKN_U32_CONTAINER_PROC_DOMAIN:
36ad9bf1d93d66 Srinivas Kandagatla 2021-10-26  391  			cont->proc_domain = le32_to_cpu(cont_elem->value);
36ad9bf1d93d66 Srinivas Kandagatla 2021-10-26  392  			break;
36ad9bf1d93d66 Srinivas Kandagatla 2021-10-26  393  		default:
36ad9bf1d93d66 Srinivas Kandagatla 2021-10-26  394  			dev_err(apm->dev, "Not a valid token %d for graph\n", cont_elem->token);
36ad9bf1d93d66 Srinivas Kandagatla 2021-10-26  395  			break;
36ad9bf1d93d66 Srinivas Kandagatla 2021-10-26  396  
36ad9bf1d93d66 Srinivas Kandagatla 2021-10-26  397  		}
36ad9bf1d93d66 Srinivas Kandagatla 2021-10-26  398  		tkn_count++;
36ad9bf1d93d66 Srinivas Kandagatla 2021-10-26  399  		cont_elem++;
36ad9bf1d93d66 Srinivas Kandagatla 2021-10-26  400  	}
36ad9bf1d93d66 Srinivas Kandagatla 2021-10-26  401  
36ad9bf1d93d66 Srinivas Kandagatla 2021-10-26 @402  	return cont;
36ad9bf1d93d66 Srinivas Kandagatla 2021-10-26  403  }

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

