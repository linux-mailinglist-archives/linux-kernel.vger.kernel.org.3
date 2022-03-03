Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E0744CC2B6
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Mar 2022 17:28:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234982AbiCCQ3A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Mar 2022 11:29:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234144AbiCCQ2z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Mar 2022 11:28:55 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E8B56EB31
        for <linux-kernel@vger.kernel.org>; Thu,  3 Mar 2022 08:28:09 -0800 (PST)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 223F69Me011457;
        Thu, 3 Mar 2022 16:27:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2021-07-09;
 bh=OQiGBRf+ZVCt4a8iE/TWa0Xn5XcM7fw0NAf4mMchLKs=;
 b=z7DFvOwKMelszwUEq+68Z3byDpZyVQRUZth2nDxb8b06t8jJQ6HCirFKu12OT6SrMAQ2
 bXlcZNBUN842yTc0zHXWkGLpOKJpT32fw4PW5Ccv3b+LlgAdf76z16P3+V3lcQWdqjIk
 ww4SH9Kka/Qg4Vx5ftk/9cU1jwQvw75mcQXXTepjMALITunapr4PsETyZWRcDzE1qccx
 +HkvO0Sn0U1tgHF+nVqdsOoxXFItIXMvKB++0f9+/G2tKVWs6AQwOeGYy8IVyn99i299
 toj+0r4T8+xNiBsRoKBwVEirjSlAwqduA/eiz/1cgzXYH/meu+K9d+GO0/CdGnMOVZ2B +Q== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3ehdayymyk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 03 Mar 2022 16:27:44 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 223GG6X7119064;
        Thu, 3 Mar 2022 16:27:43 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2173.outbound.protection.outlook.com [104.47.56.173])
        by userp3030.oracle.com with ESMTP id 3ef9b3she9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 03 Mar 2022 16:27:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YP0NDddd9qENTeRfeUNlIh5US+b99REDmDmNOjpG3mBGJUNWqcH7FhcF+nBFUIsutImBX7qwQW/NWGLKFkiBSdpQRSkrjrfr4F5YhcO2L1GvmZcuODnyS4B2GLUhbfOADptPBg2sf/5BpBhsZI7UlGzL89Oe3F6wjCsoSUJMf9gx2IZBKh4fcEAHe+oLGSVhFRfWVheftxXe5/qy74bix2iX6aQvPV42cLEuDjtIFbe1z+2cMPGcZICfS/An/AJInbc8WRAE/lM8V2eeVt6F1myQjxjnsA01S9VrjmL1azR4E4xu9HEmfhe3P9mZL0vt/fLYKtSbbzbc1PSPytMBeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OQiGBRf+ZVCt4a8iE/TWa0Xn5XcM7fw0NAf4mMchLKs=;
 b=AkjoF5HEsHR2K9REbAdmGvw7jR3klJoNHLUMmW15q8NlXLnhgW2IkECvn17R3ltD3tCLaOZ7KxqAhoqxxeTitptBo7Gd9f/Op00zcgK92L0j2gPoVQrDsd1MFVAc0QrK5phijx+qLywhRN3iufjI2wbDSuWWbPdkPgAi8boi9MZzbgY0lA6xuo61nfCXEb7AEjhBk2+zmumodhAlwqssDcWmqbwPSWeHMy+tuykWV+8CsH14no/1yekfFIlRhTQATZiiQwgI5yFGt7EJGa6t3RWaym182fA7oCkDQUWLdTceXRqk/0RhCds0HkD+sa9gQMTtjMPsoMBKSt9U1NPfOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OQiGBRf+ZVCt4a8iE/TWa0Xn5XcM7fw0NAf4mMchLKs=;
 b=AdVTzDrajEwXKAn4FRxdIKExj5FgaqwbnOJDUQf67vFcdqICtgVzycw4ikvZ6wq6SWo2m4HwbImovWU8vtMJq5BfXoe+ipdM9zfOZsufDoBFHutZnUdXv0tsXea8COIZM3eiwMg0MymdOykmJ3yiZwEjMvYPfw2NkkkY69Pz0cY=
Received: from CO1PR10MB4531.namprd10.prod.outlook.com (2603:10b6:303:6c::22)
 by DM5PR1001MB2155.namprd10.prod.outlook.com (2603:10b6:4:2d::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.21; Thu, 3 Mar
 2022 16:27:40 +0000
Received: from CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::3188:fe86:1d6f:53ac]) by CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::3188:fe86:1d6f:53ac%7]) with mapi id 15.20.5038.015; Thu, 3 Mar 2022
 16:27:40 +0000
From:   Eric DeVolder <eric.devolder@oracle.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org,
        kexec@lists.infradead.org, ebiederm@xmission.com,
        dyoung@redhat.com, bhe@redhat.com, vgoyal@redhat.com
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com,
        nramas@linux.microsoft.com, thomas.lendacky@amd.com,
        robh@kernel.org, efault@gmx.de, rppt@kernel.org, david@redhat.com,
        konrad.wilk@oracle.com, boris.ostrovsky@oracle.com,
        eric.devolder@oracle.com
Subject: [PATCH v5 0/8] crash: Kernel handling of CPU and memory hot un/plug
Date:   Thu,  3 Mar 2022 11:27:17 -0500
Message-Id: <20220303162725.49640-1-eric.devolder@oracle.com>
X-Mailer: git-send-email 2.27.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SN7PR04CA0214.namprd04.prod.outlook.com
 (2603:10b6:806:127::9) To CO1PR10MB4531.namprd10.prod.outlook.com
 (2603:10b6:303:6c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a9f6e19c-7e19-4b97-c6ed-08d9fd32bc52
X-MS-TrafficTypeDiagnostic: DM5PR1001MB2155:EE_
X-Microsoft-Antispam-PRVS: <DM5PR1001MB2155DA18A59C35281943C93897049@DM5PR1001MB2155.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 22nWaPPxlmqBf1nfF1qDJ4F/B+JIgwytpt7sQyUlrM1YLuHKEmc2Kpc2v67l4KPhv7q+TC3Y2uGqEBXcbKeuYK7S2/rF/cnvDYCteUfdg7EcLydT0XK45EtDuyyCzZLAld3wI8gGTGe35hRTNwOt7pXEj0zIFQtj+/+KzjavkFYH5KwC7BU857oHEzpcXxIveN9ENoIj9FbsiDNsxbr0QlnG92Vm7vBPfBIKbFlW0FTbD0KxWVPkVWwmPdRX05dKfS0rr/gYpPOeMm4YcNok8vcGjv2gQ8nak6LC2n7Iz5Xv6DuVblifUxX+zvd14dYZJOn++LgGj2pEz91kKg3TbYpiFYS5wy/DeVL/rLoNHEsgtmJSrLqSQMUYrbU7xJKXwPEZb3hNHV5c0VCMVnzVuP0HWdaACrg+zawBeioZPkyuVi3iaFenFlNdV/hSd7Qb1DbXMaoLnC3/M8Dr5UUzNXqeHrqIC1xR+L9kR/jptWvf0SmWLDQWMaTUXICLJHcVADcifeGOAj6EkPw/TSXsrZKSgIK+1hhWLuzMu3K5Ghfm8cqnA3g1P2qenNKOrpYBtfRizr7aq8uZ3CkZPctARZlD9Hp3a784jxFtWc/amQTh8TpSlSGuNExQRumeZJ5cWIvzRhZboWFsYPS6HDMT2L73//TXybyt+UAyS/bMFNH4ENr6iHuY+JSemqvJ+DFh+BoybOGRMEo8J6L35aQFg2bIt1n1tdHRj+pQml81PIfiwnc6rWV8ChPHZG+Y5382RvdsffYr9c+wp9g8xRWwCqEuJ0dX5suv3z5UpEDSKuxGRL6+nELXnRM2e4ISWiOAGQMgV+sovHRsjlg4eqawGQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4531.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(38100700002)(38350700002)(86362001)(316002)(2906002)(6506007)(6512007)(6666004)(52116002)(83380400001)(36756003)(508600001)(6486002)(966005)(8936002)(7416002)(5660300002)(26005)(186003)(2616005)(1076003)(107886003)(66946007)(4326008)(66476007)(66556008)(8676002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ouEUIPxikCQ5FmYYRDmFjpkA+402qwhy6DveOL2dVGArmtjeBUYYmEW0kFVA?=
 =?us-ascii?Q?vPHZMZSjXXwzlxwCKyUmBA9ZTVlPOo13uGmV9RFNdhmTslFt528/zFyyhlE+?=
 =?us-ascii?Q?sQfHpfq8GEjoCyUr3XL98ZNZgaQGb0SjrBXXDucsJLq92m6EI5G90AHSJYp4?=
 =?us-ascii?Q?1PU+w71XAdQ9RpQ2fVJuQGYkCMRBhuPVbVF5scM3oLlruT9mo3nj8trxwsMD?=
 =?us-ascii?Q?Y6qgGmyqfaH/4Mi4r999qlCcEVc214zwD7w/JRCv2uXhJYELbo2my3QbQlcZ?=
 =?us-ascii?Q?uxLDefQWZfVxd4rBNs3T+trBkAd+ncc4NzBk37C6ytOKv3OUbYJOeYi7mtim?=
 =?us-ascii?Q?pWKQmJpl5DhCfFVMIEHgEElwbDnaBW1w/wqFr83vMlzqFFknRWVBngr1hvgn?=
 =?us-ascii?Q?rNEewbo0Kzt2QgxLsnV9iQ+j85aEq7nRBULHOn8Hgq1ARgjkphiuzuwFQR6B?=
 =?us-ascii?Q?JohwRgDIz9Lbq9I5zVhtB9vWE/+SbHPkubCl70v/9XXfAfNDdBkUU3gvfHCf?=
 =?us-ascii?Q?C1ajes4tb1tBvx742awReasOOVP4ddOml1/hHltyvrBYSBrjsdIjp0ncKbmz?=
 =?us-ascii?Q?8YCJQg5RrLvIHPwovChwHwtaDSQ4ZB8KUR5mLnFUtJD3L/qXk+FcUdELa8T+?=
 =?us-ascii?Q?1a0IUn5Wq6dTzzd16KNdSCt8anYa0ECcqsJaWjM3edFIGo5ylzRvR8FCuvEE?=
 =?us-ascii?Q?OsoL+QAWGfzA9Tv13vJgOLfRhUgFed37OMmDi0u3tATwTlJVTbe1PblGQlA0?=
 =?us-ascii?Q?dQD2B6ZaD2CMmEJnYr7myZTkR7pAuEuM5jrhylpz1p3DHpTCOwPhE9ms4YNg?=
 =?us-ascii?Q?8azKvSoN+IjRFJj0J0BUOe8VBolA+8gU9dXkFp2spemxBMpdqIa8bT/Yrc4k?=
 =?us-ascii?Q?Fm5TwTnu13a7SlayT13DpSZZXfXrj/GWVNjIqppxPHh1jXBG1bEMbciPRkH+?=
 =?us-ascii?Q?HtRcooyykPwtNEhtvqLz6Zwoah4mDJ3h+NKbQiD6IZRRLDZxGsK6oC/s4uEE?=
 =?us-ascii?Q?yCXocK0RyzM9PZyUvehswecVfPyIYlFlPcI7yhWCeHltAYUgRpPPsbxs8M/T?=
 =?us-ascii?Q?tHXract1JOVqouYvh7rst1tk95VYJB1hUFmba0DV977fn2RYIZlSHc8MUysU?=
 =?us-ascii?Q?Hs5gg+le4dUqV0k0PL2GeZt3TmeW1kjpeWN7PbtSGQ6mRwUtYkoDHyh03IZR?=
 =?us-ascii?Q?DkrhXDtHTl8nZuWsm39QLNXwRkYRtcD4BLAGXrTwDBvFkTWeGCk4aKveVAZf?=
 =?us-ascii?Q?dNdBRrj/QhxM+9hwcxvdsS/CrWA6nuFm5kywlLEdzQdwylm5TIcy7VNZ7F85?=
 =?us-ascii?Q?wu8mxSOoL87137UR4lW/izQDX5S1Jofgr1v1A/T+mIKI75YEimrlq0m2c/Bh?=
 =?us-ascii?Q?M8hDzn4D44zdcqGWfMRbAQHr+Z9wliPmF0tD5sV8A4QFiAbJEhbh5sxfITFZ?=
 =?us-ascii?Q?A/S4s8vAAY/p04XPDUNiYJUjOIMvchvWQt3fxCBsrGYVcF0q02WAMAYFj4Ex?=
 =?us-ascii?Q?MRHIRW4Bmi3ataZ0dVA9wh1P0wkqnGEWe0y/lxi2nnbOprEUjf2RkkCVXLmy?=
 =?us-ascii?Q?S30X9jYG9Hj2O+D1WplWsM3a3/+T9hdTNkUGRdeVdwN31l+dr5mgUC94d2gy?=
 =?us-ascii?Q?Jo559GqxFtNFhH4SaMyQkDJCIGAKmb3upmUnJiaBa8Sl21v+HgMtI0kqqPBS?=
 =?us-ascii?Q?8wzdiQ=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a9f6e19c-7e19-4b97-c6ed-08d9fd32bc52
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4531.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2022 16:27:40.2650
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZylwTgoa+UH6xGLXbQ5VbNV2F/ZiAQOHFP3J3ipCan9pQK8ysWfWITxz4YwsOimBy2/RldJLF8JwQp4q4NUpsguX/RsuaL8lPnzPA0hYsJ4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1001MB2155
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10275 signatures=686983
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 malwarescore=0
 mlxscore=0 phishscore=0 suspectscore=0 adultscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2203030079
X-Proofpoint-GUID: CvDGdGHy7xy-NJZZAaPJd6GlH0p-KTGX
X-Proofpoint-ORIG-GUID: CvDGdGHy7xy-NJZZAaPJd6GlH0p-KTGX
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
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
utility, and a working changeset to the kexec userspace utility
is provided here (and to use, the above change to standard_kexec_args
would be, for example, to append --hotplug-size=262144 instead of -s).

 diff --git a/kexec/arch/i386/crashdump-x86.c b/kexec/arch/i386/crashdump-x86.c
 index 9826f6d..06adb7e 100644
 --- a/kexec/arch/i386/crashdump-x86.c
 +++ b/kexec/arch/i386/crashdump-x86.c
 @@ -48,6 +48,7 @@
  #include <x86/x86-linux.h>
  
  extern struct arch_options_t arch_options;
 +extern unsigned long long hotplug_size;
  
  static int get_kernel_page_offset(struct kexec_info *UNUSED(info),
  				  struct crash_elf_info *elf_info)
 @@ -975,6 +976,13 @@ int load_crashdump_segments(struct kexec_info *info, char* mod_cmdline,
  	} else {
  		memsz = bufsz;
  	}
 +
 +    /* If hotplug support enabled, use that size */
 +    if (hotplug_size) {
 +        memsz = hotplug_size;
 +    }
 +
 +    info->elfcorehdr =
  	elfcorehdr = add_buffer(info, tmp, bufsz, memsz, align, min_base,
  							max_addr, -1);
  	dbgprintf("Created elf header segment at 0x%lx\n", elfcorehdr);
 diff --git a/kexec/kexec.c b/kexec/kexec.c
 index f63b36b..9569d9a 100644
 --- a/kexec/kexec.c
 +++ b/kexec/kexec.c
 @@ -58,6 +58,7 @@
  
  unsigned long long mem_min = 0;
  unsigned long long mem_max = ULONG_MAX;
 +unsigned long long hotplug_size = 0;
  static unsigned long kexec_flags = 0;
  /* Flags for kexec file (fd) based syscall */
  static unsigned long kexec_file_flags = 0;
 @@ -672,6 +673,12 @@ static void update_purgatory(struct kexec_info *info)
  		if (info->segment[i].mem == (void *)info->rhdr.rel_addr) {
  			continue;
  		}
 +        /* Don't include elfcorehdr in the checksum, if hotplug
 +         * support enabled.
 +         */
 +        if (hotplug_size && (info->segment[i].mem == (void *)info->elfcorehdr)) {
 +			continue;
 +		}
  		sha256_update(&ctx, info->segment[i].buf,
  			      info->segment[i].bufsz);
  		nullsz = info->segment[i].memsz - info->segment[i].bufsz;
 @@ -1504,6 +1511,17 @@ int main(int argc, char *argv[])
  		case OPT_PRINT_CKR_SIZE:
  			print_crashkernel_region_size();
  			return 0;
 +		case OPT_HOTPLUG_SIZE:
 +            /* Reserved the specified size for hotplug growth */
 +			hotplug_size = strtoul(optarg, &endptr, 0);
 +			if (*endptr) {
 +				fprintf(stderr,
 +					"Bad option value in --hotplug-size=%s\n",
 +					optarg);
 +				usage();
 +				return 1;
 +			}
 +			break;
  		default:
  			break;
  		}
 diff --git a/kexec/kexec.h b/kexec/kexec.h
 index 595dd68..b30dda4 100644
 --- a/kexec/kexec.h
 +++ b/kexec/kexec.h
 @@ -169,6 +169,7 @@ struct kexec_info {
  	int command_line_len;
  
  	int skip_checks;
 +    unsigned long elfcorehdr;
   };
  
  struct arch_map_entry {
 @@ -231,7 +232,8 @@ extern int file_types;
  #define OPT_PRINT_CKR_SIZE	262
  #define OPT_LOAD_LIVE_UPDATE	263
  #define OPT_EXEC_LIVE_UPDATE	264
 -#define OPT_MAX			265
 +#define OPT_HOTPLUG_SIZE	265
 +#define OPT_MAX			266
  #define KEXEC_OPTIONS \
  	{ "help",		0, 0, OPT_HELP }, \
  	{ "version",		0, 0, OPT_VERSION }, \
 @@ -258,6 +260,7 @@ extern int file_types;
  	{ "debug",		0, 0, OPT_DEBUG }, \
  	{ "status",		0, 0, OPT_STATUS }, \
  	{ "print-ckr-size",     0, 0, OPT_PRINT_CKR_SIZE }, \
 +	{ "hotplug-size",     2, 0, OPT_HOTPLUG_SIZE }, \
  
  #define KEXEC_OPT_STR "h?vdfixyluet:pscaS"
 

Regards,
eric
---
v5: 3mar2022
 - Reworded description of CRASH_HOTPLUG_ELFCOREHDR_SZ, per
   David Hildenbrand.
 - Refactored slightly a few patches per Baoquan recommendation.

v4: 9feb2022
 https://lkml.org/lkml/2022/2/9/1406
 - Refactored patches per Baoquan suggestsions.
 - A few corrections, per Baoquan.

v3: 10jan2022
 https://lkml.org/lkml/2022/1/10/1212
 - Rebasing per Baoquan He request.
 - Changed memory notifier per David Hildenbrand.
 - Providing example kexec userspace change in cover letter.

RFC v2: 7dec2021
 https://lkml.org/lkml/2021/12/7/1088
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

Eric DeVolder (8):
  x86/crash: fix minor typo/bug in debug message
  x86/crash hp: Introduce CRASH_HOTPLUG configuration options
  crash: prototype change for crash_prepare_elf64_headers
  crash: generic crash hotplug support infrastructure
  kexec: exclude elfcorehdr from the segment digest
  kexec: exclude hot remove cpu from elfcorehdr notes
  x86/crash: Add x86 crash hotplug support for kexec_file_load
  x86/crash: Add x86 crash hotplug support for kexec_load

 arch/arm64/kernel/machine_kexec_file.c |   6 +-
 arch/powerpc/kexec/file_load_64.c      |   2 +-
 arch/x86/Kconfig                       |  26 +++++
 arch/x86/kernel/crash.c                | 151 ++++++++++++++++++++++++-
 include/linux/kexec.h                  |  21 +++-
 kernel/crash_core.c                    | 118 +++++++++++++++++++
 kernel/kexec_file.c                    |  15 ++-
 7 files changed, 329 insertions(+), 10 deletions(-)

-- 
2.27.0

