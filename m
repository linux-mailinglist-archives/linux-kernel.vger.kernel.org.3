Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F69A46C402
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 20:53:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241015AbhLGT4r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 14:56:47 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:10266 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240660AbhLGT41 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 14:56:27 -0500
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1B7I4QS6028649;
        Tue, 7 Dec 2021 19:52:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2021-07-09;
 bh=RXinOU6aJm65fhuG2toJ2vplIKaXv/Ub/zuTeEuK9To=;
 b=O339m+b1CmqDQ138hQgqlN5NlHxuMjzGk8RxGTlmcyV9cmTY+WNV7/7OTIaNGBP52LuV
 VHNQ8ivFmNo7Cp6YxoKjFY8rqakh/SXQGXI6rr0Pe4swSCk3aTXjaOKcqxH3SuFj+Gsp
 4XGqVpZpVZpPkGmRni70XO0l7OLARcI5S86TXlVhpXDQJN+A1+OUQTg0kFZcAc4h3IO2
 /hYVus1y60v6M3BvIyAubOioZti4GBmyRWOdMo5qi7ee5s1B04DBdWxISbMDysFpk982
 vcZqnAfqLH76J2WMOncWi/ECg1LjvEMDryBrrZI6MNfjFZJdYOfnm+xPSh+8/SwN3zLM 4A== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3cscwcemf2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 07 Dec 2021 19:52:21 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1B7JjGb6044940;
        Tue, 7 Dec 2021 19:52:20 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2045.outbound.protection.outlook.com [104.47.66.45])
        by aserp3030.oracle.com with ESMTP id 3csc4trbnc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 07 Dec 2021 19:52:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Bt03RKpcSa9VPjcPhWrW3c03d6fG0tGvk9NzknuC3ARtzZMRX4DC8uhomhwUZewMDSP6SLmMHaO5FzAENroebRvaO2xeWUmzsBiui44MO/mvtIntAUfvXTG/GSmyd84hlpMhKZ+VARXVgJf4qFCHFK28Hqbfwzvaxsjp8v0/gOVdBNQY8fvppk+zDEREFoOjlKQhXqsWEVkLj3g3xhBIKmVzznH3Tfg71mD0r+YbP2TEO5vd0UrlHWpD3FqgW07CoWefBscV5vl3Anl2Ld9+Fl4Cmh/VvOz91I5oYTMb9AhU3d8s3DXwFmBlNOnmRcMogqvvTeGY+26HD0Wo8SeDdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RXinOU6aJm65fhuG2toJ2vplIKaXv/Ub/zuTeEuK9To=;
 b=XbVZ1I/a0eShVpEzQAykoTx/jvRj2cKc8wyHeQ79ZGBG3DwfrDLPSrguN+j0dM7Z8ZMAfdlXuWNhmY7/mTYuP74HLHwGOmf2Te/c7EphCV8nz2GZuDxSJzobuCsBEM+M21/1U6pN0IgEEkJQTbdhpXkvRAEv9jTBABu+K/zhdCYf1ch0ivkuWLQswEmZiuSvNCVyZ48/hz7C2NwnWtipNAZjKlCma6gDKEwLtsHsR7j5QcaAm9iwI8FtDnZTxZaAIh4uopUerfAbLA0tsYfvkcep3vtnhZhSYIves44QYHUR1NmlSt+x/w7FuJmS6C/3dBr1m9M7iP09QbQZKd7A8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RXinOU6aJm65fhuG2toJ2vplIKaXv/Ub/zuTeEuK9To=;
 b=OAhi76x/2bQmNO4PBvlXqaJEh/xCmepf2xDXGuqkFiXoUTu3cFt4M+nip0neUjcaAcaumxfDFozWMBxMk/gd98BE9jvdhexvSiiZy7SrRh4Wb9l1eNtnldtyWUzl0YkzNe3WSFH6cDrrFZ7Xd2cPJmmHOtq0hP78NzrhEZiVKuc=
Received: from CO1PR10MB4531.namprd10.prod.outlook.com (2603:10b6:303:6c::22)
 by MWHPR10MB1695.namprd10.prod.outlook.com (2603:10b6:301:7::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.21; Tue, 7 Dec
 2021 19:52:18 +0000
Received: from CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::143c:ea64:7017:19f]) by CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::143c:ea64:7017:19f%4]) with mapi id 15.20.4755.022; Tue, 7 Dec 2021
 19:52:18 +0000
From:   Eric DeVolder <eric.devolder@oracle.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org,
        kexec@lists.infradead.org, ebiederm@xmission.com,
        dyoung@redhat.com, bhe@redhat.com, vgoyal@redhat.com
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com,
        nramas@linux.microsoft.com, thomas.lendacky@amd.com,
        robh@kernel.org, efault@gmx.de, rppt@kernel.org,
        konrad.wilk@oracle.com, boris.ostrovsky@oracle.com,
        eric.devolder@oracle.com
Subject: [RFC v2 0/6] crash: Kernel handling of CPU and memory hot un/plug
Date:   Tue,  7 Dec 2021 14:51:58 -0500
Message-Id: <20211207195204.1582-1-eric.devolder@oracle.com>
X-Mailer: git-send-email 2.27.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SA0PR11CA0210.namprd11.prod.outlook.com
 (2603:10b6:806:1bc::35) To CO1PR10MB4531.namprd10.prod.outlook.com
 (2603:10b6:303:6c::22)
MIME-Version: 1.0
Received: from localhost.localdomain (138.3.201.23) by SA0PR11CA0210.namprd11.prod.outlook.com (2603:10b6:806:1bc::35) with Microsoft SMTP Server (version=TLS1_2, cipher=) via Frontend Transport; Tue, 7 Dec 2021 19:52:15 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4239e9ca-1522-4aca-0b95-08d9b9bb12fe
X-MS-TrafficTypeDiagnostic: MWHPR10MB1695:EE_
X-Microsoft-Antispam-PRVS: <MWHPR10MB169502CF1FD040B4184628F1976E9@MWHPR10MB1695.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2657;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oWD5pQHIp1qDdvrllFvw182Uz+VNqUdYB8cQtyPPPnJJ0ehSdMyAThjibJ2lNCLyLPjEyg9S3aK7VQ3QLte+WxjVkZAtPUb8qtNBPpimV+C51KWWZG4A95c5WM2Ci+ADTiCeBAw6DovTlq6IdOSD/7JMlWYdc5Wx9ycvMgQW9hDB5myPLg7in/68jtWgrf71TRNVXFNXpgLQQYYbWIUn3gLUV270N//JOFiN9zHYWoKjnukTzEvGUxRFMAMvonCFSbaIDJ3SAJIbMV0upoE3wo/ZWWvfqLBRaTqaPfDVobtlr7HN2bg5iyY06V/O74NleDjlrW82HSMtH3P+mm4SE1pHQRAkJphKrSR0/2i7Qt6sRFBIC8itXvegT789mQCu834ujLiJMvVBstroYZ2cp1ZyctPf35Oq/HzKdaIZ+SKfai1ldoox8jgesZh2uy95s9QIZXkPh2gaFYemfm1qc1KSdvvUavUjCGQHEWUjv01PoGzmNeYsYeSKHqr2e4ko/tKddSi+lglWwfSX/7ObtPbPKSrDYA6RLoKv7kyaRJmFCpNjGb9q7xf7pPclJ773tPb+IMZtQdHNZPTnqQkZcGnCCkrRPmOpDcKo1kgI0J4f/B3RSpMG8eTOLqv52BO3AQJXPFFE6/gaT06k2qcPont+KN5bfKXiOYdrJM53Az88921BnfLslbUoPM5SiAS2x6l10gFvGNpr95KlV6VtaJyRkVPyYsZXFIncqLSBa+jFe67Q4Ah6iqE0FEyNnSLLgGNkFdq+bUdSy43+3/PdD4Xw85Pp74Y0916hOZC4F77Vo/6dh5T7lbd/AdglDs+Wkr3j1FxCG3fswrXW1akXvw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4531.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(316002)(966005)(508600001)(7416002)(6486002)(36756003)(4326008)(6512007)(6506007)(8936002)(66556008)(38100700002)(2616005)(52116002)(38350700002)(26005)(186003)(6666004)(2906002)(86362001)(956004)(107886003)(66476007)(5660300002)(66946007)(1076003)(83380400001)(8676002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?q+Nu1Rmt1YuvzbYj0xhwn/VHi+uwqceOUREZY0nf/UWwS1uHAHtZdpE/B3Jp?=
 =?us-ascii?Q?wkOLPMhqgixuHi0hgJtxjc6erVZ9+lXU9xYZWSDO/oEHausR+AoEzGtE0ll2?=
 =?us-ascii?Q?UfFfsfZ5ylbpc7Z+TcsCGtUpiT8tTNWZg3bgo8QY2lKYmiSVhokXtv8a7yQM?=
 =?us-ascii?Q?onHN5P47zyECTTkuVBqgF66bbvtS1smbgNY1V3s6K1jPlJfz+i5Ljdd7jpYN?=
 =?us-ascii?Q?GUUIILopzFR5rRfvfx+Gc6hj2z42WvEjfQWG+MSDYgbhNWK/CtpcK5lQ8zXk?=
 =?us-ascii?Q?rRAR2XAOubbfRca9hj8jboKIDTRHMPrfQzM7hqCQS5BCgN5nhr4WxNSyHKMT?=
 =?us-ascii?Q?2EsoB+BD/O+PlYYk0ZtQ+JpGKOxI5WW7pltjJWLiWD2UDywT9HF/2APmP4ng?=
 =?us-ascii?Q?GDm4ZPlxW4KDNZcZBaVOBdZU3dLAQeAW0iwae3HaIuuddj95lEW7JegVXQ1z?=
 =?us-ascii?Q?B3A+MJqQzZB7r1CJa7zozkWOfgtiGlBPEyu8rOg+yGvNsBrfHUGzr4p5u91E?=
 =?us-ascii?Q?3UzQYQhqf1tRB6Hz0W5GzBZ/AKwYS/kZxQxgZqoRyRWEAcumBp+Ysfzunva4?=
 =?us-ascii?Q?EqM825QYHX9EK+alOKoFDo7PdV68ifQeOtxek4Cu/F1hNe7ytuyTAIN397XK?=
 =?us-ascii?Q?VIglIlWyvUdkoufYFOVVFHIpwC00w6kfIJaHl6PvWGlaxql+kNK19MNOk5aa?=
 =?us-ascii?Q?OVZhXxNSObH8SvCyQ9HDahvaCoJLZOLj6lk1jGPrglNXljYBevWg7UqEiVbU?=
 =?us-ascii?Q?bf7Ixd6XuWAMwRScxwsMQHard+jwBQTU0zT9Cg7mwZnD7oLXG7Et2b5vALXY?=
 =?us-ascii?Q?5er8SjZsX1I4jd46EqENkkwdfIbbh+7MK26s4x/hZp4VmteEa7gQGN/Bj6iz?=
 =?us-ascii?Q?BgPpJ9/aGj5vNZ6apfVWtYBS6yc2zwnbN3vHAWwjAZtY1RkJxkcNybzm2NMz?=
 =?us-ascii?Q?VZMbNDl/pp/V4FkXhUoHLExB/8r+HJYrx+9Wz434wCvlToH4YH+oGKyUnn1Q?=
 =?us-ascii?Q?oxA5MG5cUQ8nS1QzaZyY7P3TftWxuVvalOk7n+AvL29tsVp+H1WSDoTtHAs1?=
 =?us-ascii?Q?vn+XQd6B5rI/1EAybFsw2HtZj54CqqJVFlahq3lt4+Il3f319WSiXQ6JIM3l?=
 =?us-ascii?Q?KjGUIbn7JwDOts9rSWG3ur9jJYW8R2uqTnu2bEunTnM4RvFPzK1TaITkZHVC?=
 =?us-ascii?Q?rBEQHQvolhZyNQg4jvDa9N8s7Fap83DcM1WxyKB0FIp9JV7IF3eOajLXVbkj?=
 =?us-ascii?Q?3cyrKD3/Ks8N5Xneyf9YaJUslRUOYrLH+zlfVzVZSslRJYyIsGzEs5URo/dv?=
 =?us-ascii?Q?H5eUvgFEgdAuu12MXnJcGqdLPhA7bj1TejGectOcyn/f2fQlD/EB/OAI5Ka9?=
 =?us-ascii?Q?Tqa04OQQ0/OnAJ6rwaotsD5IMfpwOB0WEG3Th7C7AX4YgVy2N4Krp5ss5jSE?=
 =?us-ascii?Q?XFwq6WtGQWNAu1Bnjgp/aziDAeL9I3u52ssrz8fACLkI/5RvoXKXw6IMSZZT?=
 =?us-ascii?Q?z+GoPsWWy3IRT4eWKo6GNZmSf7ofEOtMFFzV243zSdn6Flq0zHKgpKBadWkL?=
 =?us-ascii?Q?1IUP7BpKfIoZIxmsfBxkEsRkIQFRAr5hCX2q/nNKe6wj6EOMP6IariufP8a3?=
 =?us-ascii?Q?kT9X/Ek6F1urfK/ZmolEiAwkRpNCbOYk7DBA1EHiCBWydX/gJq4pxGn/Qdbw?=
 =?us-ascii?Q?bOK8kA=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4239e9ca-1522-4aca-0b95-08d9b9bb12fe
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4531.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Dec 2021 19:52:18.1109
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YcCDl5Z/V/6ffl4epkuhz8F4P4wfuAFoSssB5civunqe2nWc9P2eJDfZG9fWX4QXWamEvABLKy5od/3+Gh2volmeiFKdPLvFKznRVr3j49c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR10MB1695
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10191 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxlogscore=999
 phishscore=0 bulkscore=0 malwarescore=0 spamscore=0 suspectscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2112070124
X-Proofpoint-ORIG-GUID: zaIUsnndBwSH3fJlwZud6udGqpeqYx9z
X-Proofpoint-GUID: zaIUsnndBwSH3fJlwZud6udGqpeqYx9z
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When the kdump service is loaded, if a CPU or memory is hot
un/plugged, the crash elfcorehdr (for x86), which describes the CPUs
and memory in the system, must also be updated, else the resulting
vmcore is inaccurate (eg. missing either CPU context or memory
regions).

The current solution utilizes udev to initiate an unload-then-reload
of the kdump image (e. kernel, initrd, boot_params, puratory and
elfcorehdr) by the userspace kexec utility. In previous posts I have
outlined the significant performance problems related to offloading
this activity to userspace.

This patchset introduces a generic crash hot un/plug handler that
registers with the CPU and memory notifiers. Upon CPU or memory
changes, this generic handler is invoked and performs important
housekeeping, for example obtaining the appropriate lock, and then
invokes an architecture specific handler to do the appropriate
updates.

In the case of x86_64, the arch specific handler generates a new
elfcorehdr, and overwrites the old one in memory. No involvement
with userspace needed.

To realize the benefits/test this patchset, one must make a couple
of minor changes to userspace:

 - Disable the udev rule for updating kdump on hot un/plug changes
   Eg. on RHEL: rm -f /usr/lib/udev/rules.d/98-kexec.rules
   or other technique to neuter the rule.

 - Change to the kexec_file_load for loading the kdump kernel:
   Eg. on RHEL: in /usr/bin/kdumpctl, change to:
    standard_kexec_args="-p -d -s"
   which adds the -s to select kexec_file_load syscall.

This patchset supports kexec_load with a modified kexec userspace
utility, on which I am current working to provide separately.

Regards,
eric
---
RFC v2: 7dec2021
 - Acting upon Baoquan He suggestion of removing elfcorehdr from
   the purgatory list of segments, removed purgatory code from
   patchset, and it is signficiantly simpler now.

RFC v1: 18nov2021
 https://lkml.org/lkml/2021/11/18/845
 - working patchset demonstrating kernel handling of hotplug
   updates to x86 elfcorehdr for kexec_file_load

RFC: 14dec2020
 https://lkml.org/lkml/2020/12/14/532
 - proposed concept of allowing kernel to handle hotplug update
   of elfcorehdr
---


Eric DeVolder (6):
  crash: fix minor typo/bug in debug message
  crash hp: Introduce CRASH_HOTPLUG configuration options
  crash hp: definitions and prototype changes
  crash hp: generic crash hotplug support infrastructure
  crash hp: kexec_file changes for crash hotplug support
  crash hp: Add x86 crash hotplug support

 arch/x86/Kconfig        |  26 ++++++++
 arch/x86/kernel/crash.c | 140 +++++++++++++++++++++++++++++++++++++++-
 include/linux/kexec.h   |  21 +++++-
 kernel/crash_core.c     | 118 +++++++++++++++++++++++++++++++++
 kernel/kexec_file.c     |  15 ++++-
 5 files changed, 314 insertions(+), 6 deletions(-)

-- 
2.27.0

