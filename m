Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E65D34AFDF8
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 21:04:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231159AbiBIUD0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 15:03:26 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:44136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230452AbiBIUDT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 15:03:19 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5618BE04C3E3
        for <linux-kernel@vger.kernel.org>; Wed,  9 Feb 2022 12:03:14 -0800 (PST)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 219HCcJ0008857;
        Wed, 9 Feb 2022 19:57:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2021-07-09;
 bh=z2hsDjQYKNz0Adpfl6EIhKU3JqJBnqQ1Cl01u55Kc44=;
 b=UTGYMBlMp/3S7xWYmdSQmvSS7KCNaCFaGOLhhSc+YFfiYE9OFhU1xxzXzib/YFlA+C8c
 xtuajiX7XveYgXKxmcP1chyNMKTZRfcwOyANzHRbqgbZQ2prpknlVrJhysppAVSk41UH
 MaofzM3BeDdwz5O33p9fg/en422w/PjOdFQeVuXM65gEURz3i+WybDT1Auy+bTcgX37K
 qd/0i6Mx3LspjKiVWlnnqc5nFsrQWM2HdNyOs6/ROp9hkz5/ks+0BgjqTT+ApfXbjOSm
 4YaQvBV0A7ywUg+ImpeNzMKsC3oaGfpBWwZz7J8YB3w/VN4qlYu12ZXK9WjotUsyLLVK qw== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3e3fpgnu2s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 09 Feb 2022 19:57:23 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 219JtbF5130738;
        Wed, 9 Feb 2022 19:57:22 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
        by aserp3020.oracle.com with ESMTP id 3e1h28vx1c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 09 Feb 2022 19:57:22 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dZ2ficCj4oI+ep2g8xVCNTyUk4s2lriIqnofWOcGVO0hlzxulQJK8iRpPwHKX2NPS+eHD5+JVipTpISiNbEvq6wisTfD9gc6lEKkhmrIi6oU/sRjwUPTvWzecj/VlvjhjXY0EWs8rkpJnfNzpgNjtOqZfd7clwfG2viKvx2X1VnMQ0zIwLXPcOGSgCtpx1R+13Zggo0xPmqdhebX6umASBNcf4RB7frrF1suHgNz5U4xg2UZgaU4lN5Sb6Sf+qXGOEoFnFR3Q6NrV5u9wkIeSpY6yz4EH4BB3gaOcwYj6oxn4zYI4fJUnYcI69Hs4ONjj5g78+0vhwj1IhIZ4yXBLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z2hsDjQYKNz0Adpfl6EIhKU3JqJBnqQ1Cl01u55Kc44=;
 b=mlUFa5BmsZNl664NqGdsO2OEWB/nQMX7pkFhSm+TdvHCBP7vTSPv3+BMmoIWCE2eAIrSw64S6z3IFq7n28CR2wZ+JARQJ3836U/XlW5TSPn/ln5MgRxXPYgBnifWS9aB/4GKLlP2GmUUr1yok4IPCrKXgC2kppBoq+61kp4uDN4zB+uFwF1JiNmU9FQMpNkvYzZLOEbiLnJADTISaoaAnZgSo05nuRpR8FgBezgDod1eS59uA4kb4Rj0q7JcA2BEIJs6GVQDIwvPyDP3ZwnPSW/dTu23H0caz9ZruPeyG6hvYqDwoKjOtXyMtUX8bvvQRO5K5arWNvaYP+6D0tzOXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z2hsDjQYKNz0Adpfl6EIhKU3JqJBnqQ1Cl01u55Kc44=;
 b=chk1dNI6I/JAWT0HWHDXjhCYoDsZSAw1zEO/SrMPF4yZjMFYvCDIDoqIcm1xO1MqjpylHjffN8xE+6TbHmvnjvlhRoKNsdJkiY0Cmz/IO/s3NZlTTQhu1wiWV4mDF/rVfvJl37AL8xcAhL/Tg7Y+HA4NGL9TOVaZGhwEhF8iBAw=
Received: from CO1PR10MB4531.namprd10.prod.outlook.com (2603:10b6:303:6c::22)
 by DM6PR10MB3721.namprd10.prod.outlook.com (2603:10b6:5:156::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.12; Wed, 9 Feb
 2022 19:57:19 +0000
Received: from CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::ac06:be4:5723:771c]) by CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::ac06:be4:5723:771c%5]) with mapi id 15.20.4975.011; Wed, 9 Feb 2022
 19:57:19 +0000
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
Subject: [PATCH v4 00/10] crash: Kernel handling of CPU and memory hot un/plug
Date:   Wed,  9 Feb 2022 14:56:56 -0500
Message-Id: <20220209195706.51522-1-eric.devolder@oracle.com>
X-Mailer: git-send-email 2.27.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: DM6PR05CA0046.namprd05.prod.outlook.com
 (2603:10b6:5:335::15) To CO1PR10MB4531.namprd10.prod.outlook.com
 (2603:10b6:303:6c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b72d88bc-7ff5-4be5-5238-08d9ec066117
X-MS-TrafficTypeDiagnostic: DM6PR10MB3721:EE_
X-Microsoft-Antispam-PRVS: <DM6PR10MB37218A525A38793A16ECB052972E9@DM6PR10MB3721.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2657;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6txokhu6QLsjfX6pzwkCVktK0tLZjklhohl4UORUSy4ufjX3GOjz7+TXTJdK+CQ+l52q4kPDybd8U8cV/RkVjbG+dZ1rsSC9fLc4QMJUstCYc8BjeRWnL+5ahPhP/LypUvl2XNMUVuMk3077RC7N7G3iQA3icwR4ojsWP6jkVdMI5Mm0mKSWNpArocgTB33cComosrZxnRq/ShGHOAsf4ch0kxIVtJafzedldcJbYfBK/RRYL70dMDN+DQPb4scuP0N80oD6pUjfAWskZlioWciXxb6tnFiXu0EI2PboLNlvNS68JvQint9iKs9lfRaefjv6SUxMoPfs+1qAuudZ1lIn/RzE7EeOqv6GhE7zyY2ugVnwCvxMyjBi1A78o8BRBqABYg93JPvNTnpdT0NrRVzv6iukogI3+mi2gbmsTnBi3UlgJedKbDkr0wO5Qza/KD3qc/iMom84AKtJRU6SaObum4bJLD+89LJvZGTGuSdh10pS4xZY2Dg2uXfh9CnrIhiFGkbWGXhzcAqWNuPCAuTDN/2iSZ88KRGzucBiG2+bg/oyfHsh2k6vV11fDGMZztJGTnrfBH35oGuo9XYek+6OUzzJQYBEgoa+44VEXJhn8KpQyyGBNmZVSE35XpBB4s9AsfnP7ZpTlbxEgIjKfEGGLt4W5zvHhDsoIL5mg55kn3rEzoLaFE+6PB98EACeWhXesj3L05f1WcL2ccp2+MW8If8jM9vMgAilIxyFUtrI+2fRtaBDEQMam4RPcwtRf7c/rECKPiUzUBcAz0PiqVUv8OuBHgB7qPQ1rZjjDlHyhGflh6TDxIsfFqecm7Re+qsMEQMmvqV2JohkX41YqA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4531.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(186003)(2616005)(5660300002)(26005)(107886003)(1076003)(2906002)(6666004)(508600001)(36756003)(38350700002)(6486002)(38100700002)(7416002)(6512007)(52116002)(4326008)(966005)(316002)(66946007)(86362001)(8676002)(6506007)(8936002)(66476007)(83380400001)(66556008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?vWoz2T7Dd2DTDEexd1ZVvfbLviSdX/1iEw09pOIboD5qOpwEJwE6V+21t0TA?=
 =?us-ascii?Q?qT9i39GfwdBfQe1rhBajez8hM7J/7cG7TsQU+zXhia99NTrAdjW0eN2K0I6T?=
 =?us-ascii?Q?NiW5WXzWlgeHzIPPK1SU5KzcJe/WO1DlYcYT/APSgeWyWf3xvP5MwxZ8GBKs?=
 =?us-ascii?Q?48g8rMBlcA1CTkhz0nOXAZ4pa/dztHhzQSK2XBWboleNth9BTkWcyLXOXDU1?=
 =?us-ascii?Q?FqFd38CB+K0SOz+YlMGi0C+xIWuQjZv0VdT8/O5UtixOm8rQCf634HemBRIu?=
 =?us-ascii?Q?qp8Q0B0K29LMGB3UWhB1wzDINgt/irxNDhGANceZX0ry4lCs+QxK1mm+dw3H?=
 =?us-ascii?Q?fzC9qI0VwpcpcynfN5IU5mYCDVCsrAc0Kht5wUCWcdnsUmkFWdUF7/Ivx4Wi?=
 =?us-ascii?Q?lxjT9mswnmI9c5EXXWkR4ae8XJDxAsa/LERMpmWC6oFZmlYymtkWwEuElT7T?=
 =?us-ascii?Q?Q5vIj27yxEu7r0o++5jKiupDXxl6aPM2gB5XU+nDPyxmjA4HJg7Ykn7rFsji?=
 =?us-ascii?Q?NrfderMlB+JvHvhKsPlcUIi903eMUaknD5UbWyd3/n9NlRIboTtQd4k0C12q?=
 =?us-ascii?Q?DvDQmTFgKqYkES+Bjr/Y73FqY+3YFnaQGyvGPfhgLLyai74AN6qJWgwYRx05?=
 =?us-ascii?Q?gFQvopFmk6/6Aig6X8YOxJh2JrQOAW9szQT/ayg9WG9gcE3aS0Ka3uV/LA8r?=
 =?us-ascii?Q?sBi01CV0El5I5LflzUWtUHaNmpdwEiXE2KhULweveZyPqkj6VX04uUl1e3OT?=
 =?us-ascii?Q?GfKYD4LACxcZtZicZNuXMAw3r3GV8QtuYaQy+2RPoh/+lBXQwDFQxcoQoD0v?=
 =?us-ascii?Q?3NSGSacN08ID3ldc62iZZ+KTt9t7FMRRpYByx9R09jM9faosBSal8+ymv7SQ?=
 =?us-ascii?Q?o7Z+1j+adLSmFn01dKCC6LulEiDX1gXNhcPg5UCR8CCDtRz946L3m+Wa0i19?=
 =?us-ascii?Q?7bDepSSXRFkR82XD7mfYXuCz29OiCtvm76+5mVitmBQ0yc7Ktd8Rwa09Ovsa?=
 =?us-ascii?Q?bwlFJ2dtSX6GJ7Qz7VIg9o7ZIfkkNlfOeur/FP93Z0ODkT9PmRbx6llxftLN?=
 =?us-ascii?Q?b0V5T2YW5OkG1rX/uCxlYAJ4oBwFa2BnxRqFEk8HhHtyw5I/yVvvKV7pdB3E?=
 =?us-ascii?Q?BrQwQj4hiBrWyMXFFnjK9un2d72CZD3h5Lll244b18w2PO05OvSg1NfnUXtT?=
 =?us-ascii?Q?iajIu7orwGFBjpZlF7sn6jmGsl5OCWG1xG1l0fS8DgpuOMUHCisuhRk+xoYC?=
 =?us-ascii?Q?oVmrh9SFkCdPsbmBypgCXvu7cUG4Tghe3xivJYXA9U7RwmgFulQiQzKTR+Xi?=
 =?us-ascii?Q?0nrzmwXvTRet4NaL9N3qYs5b2RQw5KjG8u4p1mV+qDsEuiQj1cKmXsMBv3WB?=
 =?us-ascii?Q?KGDOSvjjXOHF8hfvAFdKQNiIIQW/owiwGqTY3MjlkKu4p6+mOqjMXHy2jo9O?=
 =?us-ascii?Q?qYxhSK+ey0CM2pUqOL1SoMyI3EGb+SOhBdiKmjvPel5bKEUbV31O9jSCa0Np?=
 =?us-ascii?Q?srtvD8i10ScfyYkgtQFPS/yrV7sDw+JMYJuYoDJknh1wntd22rJgS5TmHBsS?=
 =?us-ascii?Q?3NSDr0cE/D+vPRTTqO6qBwwx4RiDLr6FzC2sbo2dN+EEMIlXvC8GNW/72McU?=
 =?us-ascii?Q?/9yFHll78/AXJKICOzXrOJTdrwW+bpMWO6cETBBaGGoejDO9HpxPKi8xQOs7?=
 =?us-ascii?Q?23hm9A=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b72d88bc-7ff5-4be5-5238-08d9ec066117
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4531.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2022 19:57:19.5168
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BZybKaH9vNJblpYlIA85NoUrgmAykDCaAF/tAv1Rayl2jFRpMpfuv7fXUzci8fwCw05RFYl93juwvE/Vb3kJtVlbxhQHR6kqG+Zq3IO1lPY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB3721
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10253 signatures=673431
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxscore=0 bulkscore=0
 phishscore=0 malwarescore=0 mlxlogscore=999 adultscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2202090106
X-Proofpoint-GUID: m8WafNeUQONJrQ2nhoEJDFHYt92cftG-
X-Proofpoint-ORIG-GUID: m8WafNeUQONJrQ2nhoEJDFHYt92cftG-
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
v4: 9feb2022
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

Eric DeVolder (10):
  crash: fix minor typo/bug in debug message
  crash hp: Introduce CRASH_HOTPLUG configuration options
  crash hp: definitions and prototype changes
  crash hp: prototype change for crash_prepare_elf64_headers
  crash hp: introduce helper functions un/map_crash_pages
  crash hp: generic crash hotplug support infrastructure
  crash hp: exclude elfcorehdr from the segment digest
  crash hp: exclude hot remove cpu from elfcorehdr notes
  crash hp: Add x86 crash hotplug support for kexec_file_load
  crash hp: Add x86 crash hotplug support for kexec_load

 arch/arm64/kernel/machine_kexec_file.c |   6 +-
 arch/powerpc/kexec/file_load_64.c      |   2 +-
 arch/x86/Kconfig                       |  26 +++++
 arch/x86/kernel/crash.c                | 123 ++++++++++++++++++++-
 include/linux/kexec.h                  |  23 +++-
 kernel/crash_core.c                    | 146 +++++++++++++++++++++++++
 kernel/kexec_file.c                    |  15 ++-
 7 files changed, 331 insertions(+), 10 deletions(-)

-- 
2.27.0

