Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FA364D6D33
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Mar 2022 08:10:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231216AbiCLHLh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Mar 2022 02:11:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231208AbiCLHLf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Mar 2022 02:11:35 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 402A24B873
        for <linux-kernel@vger.kernel.org>; Fri, 11 Mar 2022 23:10:29 -0800 (PST)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 22C48u6c006085;
        Sat, 12 Mar 2022 07:10:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=MGbXTU+RoMpdnyEYQ/SEjM7TwFkAKO6u7ODYWLKpI+w=;
 b=CK3KkF5/i5tbKc9JCEkKnX9Mbytlvek2QwE+krfTfGGNhxufVTGXChqtQGDvdzBtzY04
 Zk+yEtmfcmkSEVBqyQR/mppHVrQY0syVT/A9mEduW3FOSWrs0Ns1laOCSP2JNtZbNrOY
 XbWOgPcxgobKVrRnHT8nsDeaznLmQuTMBRW5oyZpGHM43sn8tQFtr22J+Z5qJgNJ4gus
 vfNmaQJYVvKRPbgL9B6nuVw7zym79DpY65J1clFTf5EYLKLPgkb4+lN6m/+FkNgVPFaA
 b8M4gkab+lAKt9f4Jxpcz2qM5Gg+Tzr6u3JGXx5gUxW9gJlmL1fkJofhdSXVF/dggcWb Sg== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3erj4207gm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 12 Mar 2022 07:10:04 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 22C75KAb079610;
        Sat, 12 Mar 2022 07:10:03 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2100.outbound.protection.outlook.com [104.47.70.100])
        by aserp3020.oracle.com with ESMTP id 3erkayj00s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 12 Mar 2022 07:10:03 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XRoE/SvQta8PKo7Yqpc25FZCMnpNEGdNldQkWBGYlNeuJg1yPQl/rgeWZt2n8VyarLC4WiTKspbBOx9Q41QVG07cokKHxyTBkhfNz9dD9EzWENmo586SoIBZCjgznkysZotEOj59TaNSnjwS6q13VMp00VF/oG0pCHrLpc1B3F4BvWqZCTodaY5AvM12PFvTdu8mzn4mkM9FzfcbpN56lsIZOZMOSeeDB/xWfSPCbC2GE382OwHG4x/o9NxFgUsWKB8nKlmp+erCF7z4GLXl8nl2Ja1CfOZuFTfCkNDc7hNpRxebp54HhoLWYG0IqWWbFx538gZ7YufSuAhrNIORaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MGbXTU+RoMpdnyEYQ/SEjM7TwFkAKO6u7ODYWLKpI+w=;
 b=aqPZaGYjaTvPV8tHd7fQjgwO1W6Ntq8ymnx2VyG+zXC7iNExBL29du8tPj+RnnkP1df/jjDNoNcVOCORY78DmkYV9CUpKq/xejuCKbyv5zPGkLWKpUpPV/J3r/U2o1q7fXONPTkVF1hySYNGPW+TJfgdYO6dzUOEFFY5g8ugw/RrSrD04K6WgFv7B0Duyr+PK8Ih7N15LnkIDuF+WEfKZy+pxuAWduCpNnGo1z7jDOpOMocKNV1uZ9vOrlhQBy7TDJoVxq2iyfEkYS2ny41/pBtTVT6n6WMffc7MpuHzFXazhvQWLge1EnpVcTxiriqMyy8sy3mFzoHsgoEvhZYldw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MGbXTU+RoMpdnyEYQ/SEjM7TwFkAKO6u7ODYWLKpI+w=;
 b=FTwf+ScpzvMkv3vXibcmkDaL0zHVF6VjAzgfsBJs9eKJ+HOqEmZm9/fN/1/f2i8pxATy3AEiGMas+g5avo2KHulFFHJ2crP7RjYw2PJP+tmeyAqqWQ8R9QuGsLrRuZuRL7ZlZv3iW8pc4XGI3YAXiFch3iMKDPR2gRCEGJ11xO0=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by DM5PR1001MB2218.namprd10.prod.outlook.com
 (2603:10b6:4:35::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.26; Sat, 12 Mar
 2022 07:10:00 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::2c3d:92b5:42b3:c1c5]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::2c3d:92b5:42b3:c1c5%4]) with mapi id 15.20.5061.022; Sat, 12 Mar 2022
 07:10:00 +0000
Date:   Sat, 12 Mar 2022 10:09:41 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     linux-kernel@vger.kernel.org, patches@lists.linux.dev,
        John Stultz <john.stultz@linaro.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH] clocksource: acpi_pm: fix return value of __setup handler
Message-ID: <20220312070941.GP3315@kadam>
References: <20220309040301.25087-1-rdunlap@infradead.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220309040301.25087-1-rdunlap@infradead.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JN2P275CA0036.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:2::24)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: abbe1274-da02-45a5-d3e3-08da03f752bf
X-MS-TrafficTypeDiagnostic: DM5PR1001MB2218:EE_
X-Microsoft-Antispam-PRVS: <DM5PR1001MB2218E2FD1229409FAA838DD88E0D9@DM5PR1001MB2218.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0JNYgpvnl7EEqW2sEvxnLI6+NHVlxRwzx7DFV98qFMx0/Zz6A50n4msaJYvFxLQ5r7/8obDfPck3NEx4uDaqAarDhis/2w5w4d45Sr1RHWvtBWLe+aQmDBFjIth+ISXBPFUGKMIVscQO7srRHVXdIXg7D9t05ujuy2EadU4dul2A7n0f/3W6MO60Ok8NfruKsRM4M/ZWP9th3ZzsPvJEs0FUftPg2iwBSoPwMB8SI2NuBE/WSf8HhrkCb6bhe1qyT7XrtUgBrfHXi14hr3Amzkjz42sHm1eL02HuB97KR5rXV3DWFfkxKXhn8dKj5GB92nTDEw2YSfTu/zq7nJ58bx1X5CqS0p8Zrg9l/tNF9KETCFx5F59DLjjwz6h+LOtNT8NrCUIYWkjSPIcfKGli+5Dpcx3W9mADlxAwWZ03LuLfcPbSrCHrRQEiAkbOtUHBcbrIoNVh1yPwCrV2b0o9YnCZNu+wZUq+eZRkR/3uc+vdIXqiBn3Ua2SI8kfjtizgftpM7sVROmxcanDI1ZawoRvFHpRYmGZqa6iqCAKQXLDjoh1CPKbXbU9lEzgHIi8cgpBGzIab6HBqsPuJUh40+u0pc7COAz+2vnjBaQL47yIOZSxyzdq/+kFSMSJTt7R1hOzjhYv+oQuMIeCWO28rnvr6kyyHtxLdlXuFBptCtpqpZdLTjctQdgoYT6s5QxXEpJkRf8XZeqw4rtrPhgUIJA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(8676002)(38100700002)(6916009)(54906003)(38350700002)(86362001)(33716001)(316002)(5660300002)(44832011)(8936002)(4744005)(66556008)(66476007)(4326008)(66946007)(186003)(1076003)(26005)(6486002)(83380400001)(6666004)(52116002)(508600001)(33656002)(6512007)(9686003)(2906002)(6506007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?L8AvmtdTpz9WO2YEoiN57Bxf0BPdeQnxXWiLcJLcxCMqESnXlePEdZU51HK2?=
 =?us-ascii?Q?LKg3A376eaVqMcxpyfdkxsKrUd/fRjXmcEHSmDA9guXXZmEBSxZwnrwCjixe?=
 =?us-ascii?Q?4tpbGAyvw/W5+/iHWc3Uv/fj2D4+/4JyRFTwiEJvCfvU5zOWYc4Wop/yIEHo?=
 =?us-ascii?Q?84Pi2ZaTJkpM/UVFZwupiM3dKks953YO0QIL0M+v0He6CLBBEfTnD6ybraN5?=
 =?us-ascii?Q?srudpOkSCNvvE9DSh09BFjHKtXe26REEG7QY8kNCKT2nuceq6hKfLM7gfdV4?=
 =?us-ascii?Q?Taqr/mB4lFKSlHYIXvXYUsC4vdDBeLxN2X2Qt+t2L6SPk70vxNKRbThcmdKH?=
 =?us-ascii?Q?50F6vc+v/xeIDvYAtVhnmYs4e71wA2YYOBhnTAdHNukoC/ho5wO8mYBa9TRa?=
 =?us-ascii?Q?wOByAJMop9w8udI6RzQI94pEwbg3s7Gxe1nXVHXGhP7bVCScL8sq8HVO6pfn?=
 =?us-ascii?Q?3zWsdmDjNPF0gkKNRe36MFIUn4tLfyM1KSXrmfugcgoYGg51Q/gapQPEYDI8?=
 =?us-ascii?Q?5Y7QgTEWRyamBDryGdJ8XAlhAewlk23iN5POCWVSLIc4UkAsQUdjg3EWLzRs?=
 =?us-ascii?Q?4qfiSHcPC1+JkXkcSitgs14ArL+zHUSZBrHe/Bk+KzOndncrvIMQCYIhAlna?=
 =?us-ascii?Q?AQZH4fSV0Q7lCcQBKBCHJjzbpsF90EDqwwGVVlFsPbjFyvWcV4sGesT39jdv?=
 =?us-ascii?Q?VGAmSPYIHEfpiyeYSuFMO8Dcgv6t6ltlZ7Wd/9ZDgnpOolVN7FW5/SkZaSWT?=
 =?us-ascii?Q?x4TeH4FjR6pd6Pw0m9zr+8EBuwIDt99jv0CwaisIGEybgKYKvftwMUDJgDMZ?=
 =?us-ascii?Q?8EVZwF+2hTLss3PEkoxQF5H17zWC0n82KQp9Hhy0Bt5O79dLvUttiZayjiSW?=
 =?us-ascii?Q?szpFBmzZK7QMcaVRpsUzaKKdl5wKAp83BTfg9sLVJ3wSqpQbJYcnZ6lHxbVb?=
 =?us-ascii?Q?bf7pE4agBXn95C7cqG6v2JIq+KtQ/rw+psx2FGHkHxsy4HYfZKzFAQWhVPXY?=
 =?us-ascii?Q?CICwk4in3eJu3AgNndNKaZVhI6lQICSEy5mW7o/4TjpDGCm1H0PhsTu7rNEq?=
 =?us-ascii?Q?FHmfe9f1DV1G4v8cvV10K0Y9b2P1XrXRme5wvfgH5Dx8YeNn8CFPGbG+fe62?=
 =?us-ascii?Q?vPs2g4x1ukNsIVGUJF2aVuRbVMBwlfAcGpcjLTQPY0qAA/M2P47JMTwsVYxS?=
 =?us-ascii?Q?8cOpTz/kcO35cFIjEWrpN6gQ+6NllWNUNZw2k6wDqvMIJM2M2ZILSxyf2434?=
 =?us-ascii?Q?y25S+SYCKwB3N2ExpvklGeYwwPVkPOGR6GZDT5xqBaE4uTM5qn1h1NtJcnRX?=
 =?us-ascii?Q?Zpbw88arLAM0cjRkaGSUEursQMPfflgBhaChHuTx1jFyzOvq8Kwjfak1L/4k?=
 =?us-ascii?Q?t8lxMG84U7yWOs/Mb6YLXyTXJ4bmh14riKop7+yDZbslHh5AOVMWPQiz+BLI?=
 =?us-ascii?Q?c3godF9ATA5iIc9SMPQyesBuqzRLxSjiq0uwRRIA5OW9P0cF/msYbln8GYFQ?=
 =?us-ascii?Q?iRyLb4b4DgAv2hhMndWtRRmd0Lf/WS+3p+2MlxYQoLgsTvePfhB2kwVKIFq7?=
 =?us-ascii?Q?047Q0g9t8jn1iCaQtHdgBI3ZWgEflICNsyLOlUNcKu3KgLSm4k9SLnRvXisF?=
 =?us-ascii?Q?Ym47byk+RS+AcAo9Q2FZnc3DwWTrclYjNj6/cjqvUq4GZYIvAE+PH+3wrnuk?=
 =?us-ascii?Q?KOheiA=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: abbe1274-da02-45a5-d3e3-08da03f752bf
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2022 07:10:00.7861
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +IzTAOYaDavIWJ8QbQM7HOYLhxls/6a96XyfGzuwgNCWBBP+0ljwxeB4yyNIz6Aj2P2thwiv2s4tHOPOvDTxv0ajseGZbIOjytfEHQpi2A4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1001MB2218
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10283 signatures=693140
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=872 spamscore=0
 phishscore=0 suspectscore=0 adultscore=0 mlxscore=0 bulkscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2203120041
X-Proofpoint-GUID: GqwFF8HtVNyOsDKIrfmmWYHZmsflVAVv
X-Proofpoint-ORIG-GUID: GqwFF8HtVNyOsDKIrfmmWYHZmsflVAVv
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 08, 2022 at 08:03:01PM -0800, Randy Dunlap wrote:
> __setup() handlers should return 1 to obsolete_checksetup() in
> init/main.c to indicate that the boot option has been handled.
> A return of 0 causes the boot option/value to be listed as an Unknown
> kernel parameter and added to init's (limited) environment strings.
> 
> The __setup() handler interface isn't meant to handle negative return
> values -- they are non-zero, so they mean "handled" (like a return
> value of 1 does), but that's just a quirk. So return 1 from
> parse_pmtmr(). Also print a warning message if kstrtouint() returns
> an error.
> 
> Fixes: 60e3bf14d4e2 ("clocksource: clean up parse_pmtmr()")

I was wondering why I was CC'd on this.

This fixes tag is wrong...  My patch just cleaned up the function.
The original code returned negative error codes already.

regards,
dan carpenter

