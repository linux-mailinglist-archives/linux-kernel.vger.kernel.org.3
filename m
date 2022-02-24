Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EFD34C3828
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 22:51:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235107AbiBXVwU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 16:52:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235050AbiBXVwO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 16:52:14 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A330D3F329
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 13:51:43 -0800 (PST)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 21OKTCAA026078;
        Thu, 24 Feb 2022 21:51:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-type : mime-version;
 s=corp-2021-07-09; bh=O1gSDQTacDSNjxNoGSWyOCwpiMkubGpkduZAn3weBqk=;
 b=Q7/vh+pJbokaU3xuCplT/nOU46Z3Wt4zt0ks64Blv4DUiZ8m+KhYNCEo5PZjxJNAAb08
 RFwdZf1iN5oWMjb3YU3gTjXstcIeyg68NQL6YM5tsqj8vadfaJsviYS4T069QXRcSSvD
 Jf5wF1EFyGRAgjIejgESU+u/K1EF7qdfyCW8UyGxeFaDoeEwnIHZW+qk2EL0JaU6zOyD
 8xxF30qSfEvvrno8LP926TjA7t9IAvWy3C2nqmrUJxJ8wcGj6f7rftc+Cx20uErFLFYI
 iLMsgzq2epEjrYmaZWZGIyHw0bzebJrcE1wN+AWjojQKaV6ngs0q/e9EvOiqE+G0u7Ei Dw== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3ecvar891r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 24 Feb 2022 21:51:09 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 21OLexQe004512;
        Thu, 24 Feb 2022 21:51:08 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2172.outbound.protection.outlook.com [104.47.56.172])
        by aserp3030.oracle.com with ESMTP id 3eapkkvqpr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 24 Feb 2022 21:51:08 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i8RWz7bXhU6isQ3gtUM/ihv3VbOdEBmlZf1cSyIisEUT795936930GG3U3KxbfiQsUjWKtqf7O4VWJfj/LYNKweJIPCxuwdDT/W7uP7k+hpfClSQ8YGrEa05tx/w0MFgRjH7sAfxtEfY32Ehv4HsoavdZ7WuNF7R7Rv5lqhFs69HcLTFXtmw2U3tzJhlFpxSPV0xmoLiN9LjXhrJUfuWBgriRg8hwkQBjoxkib7/zoM2zHxBdsNzsVC0Te50PBfD84gj+vuCX83wd0TEd2HiZFgCoBLtLjxPiRmb80rY8R/p1FSBIK7+7O38Ws4a8ds99gQBR7yYsCz0pcC8owAx6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O1gSDQTacDSNjxNoGSWyOCwpiMkubGpkduZAn3weBqk=;
 b=Po+aq0eh9mQS/DTuKKuOZN7jEtL32XYB02Wx/KdudK99HrgrT7HMltdPonV18jC27qa/30YgtE7TFG00+tuA/SA6yYVRK4t7y85DXxb+WllmWI2QhqwqFOXzcsAuHJTQtVIaYCNWXrzUPtj8W/aS0PlG5DujqsgaRMsBWmYtKsuhSgWBJqrEwADagEqwE6i9+PGrWCncayumbCZAMTz8gPq6c3UvxiwHozFUY6Nt6zgBt3ZvkxcXi3tYRYXYSV8XjqmkNZuyd3A2wx6nbSN98EKFiu39NZH0gchfOHS6dU4FgL8VH2gXh9a2+755aD80rTVGz2pohNuTRfeGceRtog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O1gSDQTacDSNjxNoGSWyOCwpiMkubGpkduZAn3weBqk=;
 b=Ich7CIfLQjA2kP1/VMbdiP9Hsf0EatO38/NrH28nLhf0chXI5jF8G5O8HThXmdovgRXItw//Ytt/5bPkTZb9jls30mGM5GmXtFptNXmKJCiFwBhZwUhUOBhSO0ZZjlIesfblnlgt20Jy9zCdBwGLk9DDB0mW9p3i389o88StrwA=
Received: from BYAPR10MB2663.namprd10.prod.outlook.com (2603:10b6:a02:a9::20)
 by BN6PR10MB2020.namprd10.prod.outlook.com (2603:10b6:404:100::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.22; Thu, 24 Feb
 2022 21:51:05 +0000
Received: from BYAPR10MB2663.namprd10.prod.outlook.com
 ([fe80::a0d5:610d:bcf:9b47]) by BYAPR10MB2663.namprd10.prod.outlook.com
 ([fe80::a0d5:610d:bcf:9b47%4]) with mapi id 15.20.4995.027; Thu, 24 Feb 2022
 21:51:05 +0000
From:   Dongli Zhang <dongli.zhang@oracle.com>
To:     xen-devel@lists.xenproject.org, x86@kernel.org
Cc:     linux-kernel@vger.kernel.org, boris.ostrovsky@oracle.com,
        jgross@suse.com, sstabellini@kernel.org, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        hpa@zytor.com, joe.jin@oracle.com
Subject: [PATCH v3 0/1] xen: fix HVM kexec kernel panic
Date:   Thu, 24 Feb 2022 13:50:48 -0800
Message-Id: <20220224215049.2845-1-dongli.zhang@oracle.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-ClientProxiedBy: SA9PR13CA0099.namprd13.prod.outlook.com
 (2603:10b6:806:24::14) To BYAPR10MB2663.namprd10.prod.outlook.com
 (2603:10b6:a02:a9::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c8c5c01d-1f74-4a3b-76a5-08d9f7dfc1d2
X-MS-TrafficTypeDiagnostic: BN6PR10MB2020:EE_
X-Microsoft-Antispam-PRVS: <BN6PR10MB2020D15FCE8FCDDFA9266E25F03D9@BN6PR10MB2020.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kenOy3uzedM5w3yIYgEDKiimU1aXoNIgTUQYhRYEuc1BxzNYA92dmEUzZhuBQxNRlVZku25W1PMselnACQfrddnvyxF4A3hCNMzMZ9ybLCGXYIOCgfqzqJbvKwwNwadiJfznmlxp4E3kqMmCBtoH4Xh5pVB7lKd/5qOxhpB+VCVWrKHL1mTGI+pwz9tW4tUrqeWkmdAWE0xitSyaSaLkNDZ2jZOH1s/v804TPvRuLoJqDltQdyuYycZX9ebU4he9Zyb+NtMsI4ed+9AX8xpDR7SG93RFqz4HuyMsZl98zXNW/cfXtoLPa6DQphW4zlbiTOJOSCzE8K9CZS47ZcYmC2lMK6Zr/KBVpVDzDKv0q1t8bVqpx/iB+5xeK6pzbpQWSTLdgwfxEVXcsikMxoqXsKxv/f+DNGrMbIoSxf0ZZN4s59PDJDTD9xL/Xl5nIQPy37EGr7ubWFkMzKfwRquysTzGRogR1ni030NExDdUKh9fGeYlsxJ726KXmXOoKmNvp2iL6SyofT4YzFyc0rgdkjbngRhoChzN3zVPf/8uQEYS7vR9+cdLvaGBrfR90qBCuXnlB8nHItOIosvZ2/wwkj5Kem8WODoK8C13I+OWv2N4MYLrIod/WAi5xFXjPcU3QqDWQqspLS1fbqd7faljLy2ZILQTFm6NKYgIUPykZW132JzsUx/2iocHj0FmyI+pz21fq1Npy7o4Pdzww/tmxMnOp7WixsL37h8JTR06P21e7ZUQqA4eyk/sl1iLlBcwPyheWGdTPlfLP60xgzvDpCv6Z5q3REHlvI6SO+AA46o=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB2663.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(1076003)(44832011)(36756003)(86362001)(2906002)(6512007)(107886003)(186003)(8936002)(2616005)(6506007)(26005)(7416002)(966005)(6486002)(5660300002)(8676002)(66556008)(508600001)(52116002)(83380400001)(66946007)(4326008)(66476007)(6666004)(38100700002)(38350700002)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?gCu7JsHtajKygwliAUDMhkV9vO9s7g4qfMJ/MbXl1DuIdvPYpw90w4+MO0JZ?=
 =?us-ascii?Q?PzaYgT+C99Q9KsqcZMvhZiqeK442yv3I+ZkO3n7G4EDHE4ACLyu/VwzO5uBd?=
 =?us-ascii?Q?h501jKcLsPiEbcUzkUEwMAzv47to0bvnHtD7Gd2tSaE/8ItD92CGwISS7wol?=
 =?us-ascii?Q?qBBmqF0HalOpmQzVzoTEzAMd5N+kMqgWU/Y4hapBaag4ILwM3xH03KVyEgVT?=
 =?us-ascii?Q?cWcQDTq6eSgu/ywM8koaHTOzY7weGnJOFjtaKdatFjuhziHlhiE94h1JIc6f?=
 =?us-ascii?Q?E64PCfPMUKuzDJsnJM12h52x3fN8CJ3zGX4mTGWRvW3CsdyfG5QMtQFgGkDV?=
 =?us-ascii?Q?Qz+k5G/dVn69pOSNyZZrjuyIskkfsMn1r0OGF6cSiqFsboe5Wbp65JCYXO2W?=
 =?us-ascii?Q?vrVDtiqn4ez8KydJiepulwhwC+n3RyXLFIe4RyjgzZAWTerflmXimPwos06L?=
 =?us-ascii?Q?OsPvhw1T/XxjCn06PI7QQ107eArYU2koZlvAhg4xMYv2HAJL8ppO9Uz57seQ?=
 =?us-ascii?Q?ARZc6wrUpggv7q6vcNVLEvSUXqm+viQXHgpI1reMN8QjfDSmVIw0SoQ0/EGW?=
 =?us-ascii?Q?kB+L+E1gyzHXboYzWoXS/rpdeup7PONyWQKoXtMTXmBmoMDPhxhSprB26ht4?=
 =?us-ascii?Q?Abl80EJUjqekYM8x0TMAGYKVXbWJLLy9hvvwAxiG4kqZPPSULe2QKow+hAdK?=
 =?us-ascii?Q?9Du5iCHP0lIg2YNAnLCwHpa805LzhXMtVtebGtUNz1aS1lGGok9HfRRXk7ax?=
 =?us-ascii?Q?xUoOhw31TnxrnZ/ziMpMgen0Xr0rp2y938VnoKzk//YhYmJaEg6bzHxNFFnu?=
 =?us-ascii?Q?xkvr4R08n01FyncN/bJNihFPaq5aISjEA3Sf/aqFYUNeb9ecBf2EC5HeIKd4?=
 =?us-ascii?Q?rYPsDpJ6ejv31N+MrSxmdPzbMwKb1X5c7vQ514+6SnAHq890AakeoWTmL4bk?=
 =?us-ascii?Q?Y2VExAabp3xUjmaJlxjt7SUSy+U3aj4np6RQpKLqUVjlSJyTo0CWp71Leh4R?=
 =?us-ascii?Q?rTrtjbdRXCNIk9Wwhkr+WJwWA0wsF8dteiLkwywahpOb8K7UhbPzRW+vFahO?=
 =?us-ascii?Q?wrc9FRHkaH5sbTItkC97p07geW7zlvVg2m+heatqOGhWAcfFriYp8ycAbfi3?=
 =?us-ascii?Q?jZcGep0/U6WTcdJu4Ktlmmwg9HZGujfgm7d5PpXsmbHEWW0VSNHof7C+KqUs?=
 =?us-ascii?Q?UGztWWoDT8geHDSk+h4rY0Hh4tpGdi3FtBAhAvIOppmLQDikIdr9UBHSKcAn?=
 =?us-ascii?Q?IX+N01y40lyGur2fizt2FVMzDLGZXKlkkmZ0YjNS3HG6DtJ5F/sdZYzpsCWj?=
 =?us-ascii?Q?eiJTkdXRyMM89UfmfulwSs0X/CdEhHpNj6skptuDXzN4OlGhxar1RPTz/hU3?=
 =?us-ascii?Q?DmwnuWT1N1eVOexmCbkiG09NYPU7gGCDdZUkMRGoI6DFdnZeWVx+mTcEzTsQ?=
 =?us-ascii?Q?Rt5w5gxu+crA7asxdXtkaToI+fFBGkJHZuLTPOXU2n3oG5DYIy14FeWgqx9m?=
 =?us-ascii?Q?AZ/lY2Oa56NFQCIFnOme55VdKgoCIdmy5tmJT8aHEDWzyE3eGGLAcKDMgjco?=
 =?us-ascii?Q?okz/3LVgr3HC20UFR1YssulN+4z+ifjc5RFL3wI+0MAIWrKvqvYOtdEra2Jo?=
 =?us-ascii?Q?4CL6tXgBp0DYhJ0qPTx0uHs=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c8c5c01d-1f74-4a3b-76a5-08d9f7dfc1d2
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB2663.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2022 21:51:05.4480
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1pBgUsMJH7+/NB+S7e8c2PEDVh0zBJtDphjdsuccv38DmeMVT+NgX7/rE1wq/SVuulvv7bOVwDmNnXgGggq2og==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR10MB2020
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10268 signatures=684655
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0 mlxscore=0
 spamscore=0 mlxlogscore=999 adultscore=0 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2202240120
X-Proofpoint-GUID: C95S2tNrFwvPWTj3CCXfrYKw8unkJkMx
X-Proofpoint-ORIG-GUID: C95S2tNrFwvPWTj3CCXfrYKw8unkJkMx
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is the v3 of the patch to fix xen kexec kernel panic issue when the
kexec is triggered on VCPU >= 32.

PANIC: early exception 0x0e IP 10:ffffffffa96679b6 error 0 cr2 0x20
[    0.000000] CPU: 0 PID: 0 Comm: swapper Not tainted 5.17.0-rc4xen-00054-gf71077a4d84b-dirty #1
[    0.000000] Hardware name: Xen HVM domU, BIOS 4.4.4OVM 12/15/2020
[    0.000000] RIP: 0010:pvclock_clocksource_read+0x6/0xb0
... ...
[    0.000000] RSP: 0000:ffffffffaae03e10 EFLAGS: 00010082 ORIG_RAX: 0000000000000000
[    0.000000] RAX: 0000000000000000 RBX: 0000000000010000 RCX: 0000000000000002
[    0.000000] RDX: 0000000000000003 RSI: ffffffffaac37515 RDI: 0000000000000020
[    0.000000] RBP: 0000000000011000 R08: 0000000000000000 R09: 0000000000000001
[    0.000000] R10: ffffffffaae03df8 R11: ffffffffaae03c68 R12: 0000000040000004
[    0.000000] R13: ffffffffaae03e50 R14: 0000000000000000 R15: 0000000000000000
[    0.000000] FS:  0000000000000000(0000) GS:ffffffffab588000(0000) knlGS:0000000000000000
[    0.000000] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    0.000000] CR2: 0000000000000020 CR3: 00000000ea410000 CR4: 00000000000406a0
[    0.000000] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[    0.000000] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[    0.000000] Call Trace:
[    0.000000]  <TASK>
[    0.000000]  ? xen_clocksource_read+0x24/0x40
[    0.000000]  ? xen_init_time_common+0x5/0x49
[    0.000000]  ? xen_hvm_init_time_ops+0x23/0x45
[    0.000000]  ? xen_hvm_guest_init+0x221/0x25c
[    0.000000]  ? 0xffffffffa9600000
[    0.000000]  ? setup_arch+0x440/0xbd6
[    0.000000]  ? start_kernel+0x6c/0x695
[    0.000000]  ? secondary_startup_64_no_verify+0xd5/0xdb
[    0.000000]  </TASK>


Changed since v1:
  - Add commit message to explain why xen_hvm_init_time_ops() is delayed
    for any vcpus. (Suggested by Boris Ostrovsky)
  - Add a comment in xen_hvm_smp_prepare_boot_cpu() referencing the related
    code in xen_hvm_guest_init(). (suggested by Juergen Gross)
Changed since v2:
  - Delay for all VCPUs. (Suggested by Boris Ostrovsky)
  - Add commit message that why PVM is not supported by this patch
  - Test if kexec/kdump works with mainline xen (HVM and PVM)


I have delayed the xen_hvm_init_time_ops() for all VCPUs. Unfortunately,
now I am able to reproduce the clock backward as shown below on some old
versions of xen. I am not able to reproduce on most recent mainline xen.

[    0.359687] pcpu-alloc: [0] 16 17 18 19 20 21 22 23 [0] 24 25 26 27 28 29 30 31
[    0.359694] pcpu-alloc: [0] 32 33 34 35 36 37 38 39 [0] 40 41 42 43 44 45 46 47
[    0.359701] pcpu-alloc: [0] 48 49 50 51 52 53 54 55 [0] 56 57 58 59 60 61 62 63

... clock backward after the clocksource is switched from native to xen...

[    0.000004] Fallback order for Node 0: 0
[    0.002967] Built 1 zonelists, mobility grouping on.  Total pages: 3527744
[    0.007129] Policy zone: Normal
[    0.008937] Kernel command line: BOOT_IMAGE=/boot/vmlinuz-5.17.0-rc4xen-00054-gf71077a4d84b-dirty root=UUID=2a5975ab-a059-4697-9aee-7a53ddfeea21 ro text console=ttyS0,115200n8 console=tty1 earlyprintk=tty    S0,115200n8 loglevel=7 no_timer_check reboot=s32 splash crashkernel=512M-:192M vt.handoff=1
[    0.023880] Unknown kernel command line parameters "text splash BOOT_IMAGE=/boot/vmlinuz-5.17.0-rc4xen-00054-gf71077a4d84b-dirty", will be passed to user space.
[    0.032647] printk: log_buf_len individual max cpu contribution: 4096 bytes
[    0.036828] printk: log_buf_len total cpu_extra contributions: 258048 bytes
[    0.041049] printk: log_buf_len min size: 262144 bytes
[    0.044481] printk: log_buf_len: 524288 bytes


Since now I am able to reproduce the clock backward on old xen version,
please let me know if I should re-use the v2 of this patch, as it has been
running well in our env well for very long time.

https://lore.kernel.org/all/20211028012543.8776-1-dongli.zhang@oracle.com/


BTW, I have tested that 'soft_reset' does not work with mainline xen, even
when I directly trigger kexec with below commands.

# kexec -l /boot/vmlinuz-5.17.0-rc4xen-00054-gf71077a4d84b-dirty \
        --initrd=/boot/initrd.img-5.17.0-rc4xen-00054-gf71077a4d84b-dirty \
        --reuse-cmdline
# kexec -e


Thank you very much!

Dongli Zhang


