Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 625B048A099
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 20:59:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245237AbiAJT7U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 14:59:20 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:50916 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S243444AbiAJT7M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 14:59:12 -0500
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20AJlgoC011397;
        Mon, 10 Jan 2022 19:57:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2021-07-09;
 bh=LXFY5/xM3WqItTa1I8MmjJiP0E8/Y8347YhaINJvc54=;
 b=NxeUk3XOnKbrE5V6F5By5zfbWHYpkhVBJm0WZLpB04d47bx2I5Vlsn+xxv4fddY8hCPS
 cTkNl0ze3su83rujVxEmmZdFUe28FhfKp3oAhMtDSNXpSqSpTYUo/n3xFBslKHAV2A88
 NbPZMqaXZZau9SUh7V8nd0dgwKuLkJ6B/WpJDBut6bAYPQ8Iw+Z8TgNACKBywNyXohLQ
 kwktNUJ3IBjedAwhG5bit074bXSkT6qTzLKQkyle1N39fd852CsCOlDwsfYdF+5P45rR
 AzvFl5LGf4jwE242QuvQXr76392OO4DDsh2t4m7EqFzBZyP5ax26JQ/vrNM4DJJvBOa2 sA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3dgjdbshnc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 10 Jan 2022 19:57:46 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 20AJtveE110333;
        Mon, 10 Jan 2022 19:57:45 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2101.outbound.protection.outlook.com [104.47.70.101])
        by aserp3020.oracle.com with ESMTP id 3df2e3ratv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 10 Jan 2022 19:57:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZAnFvVFtY6JAnlgK6QwkJlnkJ4JWlAZ0UyyF5n0FoPRWuDx0Q5q8k/YbdU+ycOyYO+2rQVHEa+YKSEj/F/ZRckUKxWvGfiw3GGdTYHH5ooUz8A+ta4cvCzUltOhNG1cAXBIn8ia5VONZu9Trs4qRqGCPXGQo40zj59lPvRojMWK7qOc0Ex8SsVUvtWtze7WwSdapZl+0iKLmfNH+QhHGCifUS4bAG1JN7hzaLez+CkBr/Nbi8T0+fRVwCReICrrGKEnZcXDU9nHiNCCQXFue9/ppHHX/SxclG5dg2SAJ0FR+JsbxNGfklZGQ9/AT36psSud13rZWTuxqNwPdHrPp8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LXFY5/xM3WqItTa1I8MmjJiP0E8/Y8347YhaINJvc54=;
 b=hQ8wq/hdh2DqVZqIK0hvIewrrUB6Zda/emd/BjzOLTgtUZUtZkdulfqv8kv1JvhzP+OmuD1jrWomCoAua0pJ1tGTjEU54NASAh2pbyOV2EYkdfXO1eVZCBznGX7o2ozjMvqvTrAcz2l76pMcK9DOI/Yi3wW6xqJ/qoJoVjeVWM3jQo7NBvmhCRkFS6Mh7WMdpgVHQi9xHSb2bFNl7goFUErlakAR03irt4q8wRji5uW0UFXNMO29zAJGCjY8rkXE4L+58p5kYj4faDIeuHLUy/ra2WPjR17ZdqZuHRPMxdwbMSTumnw8/tAWVT3wyT9NRetBvjVil99E7B2JbtwG4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LXFY5/xM3WqItTa1I8MmjJiP0E8/Y8347YhaINJvc54=;
 b=QwXMRFA5tYFNPNWYH68GvWbJAvx4HElAT5rheF5bGi8HzBIe+judPPxpmt33/Y1RU/VWwKCTeFmb4uOSaRbJM43dQ24zhPepshYtFBxVN+FybiV22f2e80QnuAuvdYoyY2Kpoxq7N0IsbeXoPCdPhUJ9J/hBIWJ6lT2jxb+s2Zk=
Received: from CO1PR10MB4531.namprd10.prod.outlook.com (2603:10b6:303:6c::22)
 by MWHPR10MB1711.namprd10.prod.outlook.com (2603:10b6:301:a::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.11; Mon, 10 Jan
 2022 19:57:43 +0000
Received: from CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::d573:6cc0:c616:6f2c]) by CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::d573:6cc0:c616:6f2c%6]) with mapi id 15.20.4867.012; Mon, 10 Jan 2022
 19:57:43 +0000
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
Subject: [PATCH v3 0/6] crash: Kernel handling of CPU and memory hot un/plug
Date:   Mon, 10 Jan 2022 14:57:21 -0500
Message-Id: <20220110195727.1682-1-eric.devolder@oracle.com>
X-Mailer: git-send-email 2.27.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SA0PR11CA0149.namprd11.prod.outlook.com
 (2603:10b6:806:131::34) To CO1PR10MB4531.namprd10.prod.outlook.com
 (2603:10b6:303:6c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 69037337-b543-4670-bca0-08d9d47376ed
X-MS-TrafficTypeDiagnostic: MWHPR10MB1711:EE_
X-Microsoft-Antispam-PRVS: <MWHPR10MB1711E01BF43A3A932F69988D97509@MWHPR10MB1711.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2657;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Jf6pT0xbVOOiL5tKlhKoIM6GzfQwz7sPQRRRBq5eR88vp8kQme9qbjSB28U0IgAT/7XFNKA6nIjD8mhDsTtIMuGzpuI85IKzu6ZjYVVQ3Uu7Aesb3SPsfl0s8eYyBsWZznH5U7LDaqODLSKnV3vkpQp+M0I5Lwk+iiQlfxGAaTHBoMgLPPu5gi3bWgCFYUk+5TYNqPP6RiOh7/xe10H42Zwou4kSVAxxzcAGMW72Ypsxggp9ugKPyPNctvqXRZ2eSMM3MuGH7uTrW+Xo90RJAWuS6JbkYsKUOiPTtHP2uI49eM8/nVhyrdVtRPXSTG16rUlnEzUN6G4nWCkJOn4vMM0NoTEm1zhVyOwOXEvNvxwlJYTkKZc3s2aVKmOyc5/07k4laSlmIQ3O4nlYlw3ImPo3gILUWUwOwKy5DIQMcl3t6+mNx2u+DKIgRdny0DJYrsrc2KhWmVr+Q4kaCW2MWN59KGHmx3wNao8VEXJpVqEpF4K21xJfW/tTja86QcyDlrrokQNWsgxrbjx5auT7HybVA/V8X52jIji2DuyPsXb5yWXKULL55dVGrJ81ZZSkLcyAPIssZnW3dsTy6OdiZ05hyl2HloTCev6u6LRtW8CplADUY/lFmExL8mUDMGBS8+sQEteDmow3e3c5QqSRB5+iND6nBoBE2wfG4XdXeeBRm7jFg+2YxRHcTgOEKIoDnIKDkZ9o1DU7sbAqAjAinzhO8zI5UFra5akhaS6QbCbs/PzVRVrf50iOYyFXdhFncHWWGWhybltfTR3bIAvg21u01npO7bfpV/I7N1QjF2wYjF7ioxMnO2PvWEI1iY3O
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4531.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(2616005)(8936002)(4326008)(66946007)(6486002)(1076003)(38350700002)(83380400001)(508600001)(5660300002)(6666004)(66556008)(86362001)(38100700002)(316002)(6506007)(26005)(186003)(7416002)(52116002)(2906002)(966005)(36756003)(66476007)(107886003)(6512007)(8676002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?xkPnz5dlmlcnD1hOSiuCgu5qoDBrNCPxgi5GFCLdbmZqeym/gmPl33BOXhKq?=
 =?us-ascii?Q?uxaOnAdJWFrAPYibViC2ejePAGmd13y9sJlS9z0b+9yqcBxAlZjWWvhqnnsS?=
 =?us-ascii?Q?LqJF6dzdxTIConq9bNI2tRyv82NNyh+kbfuyfSmrm67SEBoL5V9zPNAw1VQW?=
 =?us-ascii?Q?uTJMp+dbz+FuHW/AczyHPwxtffyisT/IfBt5EIgyhJPvtvWdzVLnr2b/V9RO?=
 =?us-ascii?Q?2JbIqWYvbhVrdaxyOaDwbtWieLXJk3KHPaTKjGikKku0LBDLAnFW6FSsw0sU?=
 =?us-ascii?Q?anIyJHcYxGCYvgaMKRNiHIEZyPf/zIPUHbO3/JO0AfqAjy1U2enyx2S382py?=
 =?us-ascii?Q?aQ2t3NVE94rqxkwg58oc1PS3NfQ4/gtuAHY7xtoy2WZMIYI7wuV4xzqoAg8C?=
 =?us-ascii?Q?4WzIV27U36bIbF++Z01V+sCe9//whJyedPU0yvX0HQDD7257iFyQtmt6domh?=
 =?us-ascii?Q?pkEht+qLwh/pnprvTJVf2dx9HPfFiqR3Q3wTJ8WK0hUCbG9X2QjcS+rl3D6B?=
 =?us-ascii?Q?OCjVt/y6N98lwDDsscDQwdonqJfSZOOzmYr4DPSC6ZPzfib57oYJ1WhTqAVP?=
 =?us-ascii?Q?8zNBKaJ4EBTidd6Po1aghAoazOOOoyFxhCq8VDsMCStwyNyP5pGky2D2nhIy?=
 =?us-ascii?Q?9QAmf3TgtypVpzGy/Su3hZoaYEEg5l/ygiQl3hXJX7csU6x1WVAxSVyr42lZ?=
 =?us-ascii?Q?LIPYmYOoODZWEWlo0mvieC27I032bq5cjotV0WiBJttRmT/UOspxinR5oJYM?=
 =?us-ascii?Q?ceuv4kPdzD36TofD3vznijclhi56h6LYftmAp+tsHAWE25lT0btubTrgITBp?=
 =?us-ascii?Q?/iboEy+ytywRJFrL/UcgKTbY9UgG3VTMqsCQ2/WabQ+B12+rXECE2pmAdblG?=
 =?us-ascii?Q?uRY/m96ZKJ6hq1xhdlWtdr+gwAuxyriy55yRuNGURFqXv6klQfUkkT569RFE?=
 =?us-ascii?Q?axDYX32jO9AnvklK3E6TD5o/xlywh2ucLhh2ExjXgYhn3SsrSwzHP/gxelYZ?=
 =?us-ascii?Q?+BUEQJzDReVU6IcMGK13Hx9+0iirR+wxxYUiI50HVoP9lQUti70qHmoWv6IV?=
 =?us-ascii?Q?WV+CykFhOiVtkyTVOzmDGQnfKb1dZg1UcLoZkvbjbBGFgXT92xhNgZHOCSry?=
 =?us-ascii?Q?gBv4SBKyiT8WQh9+hVRfs0BLODiKZDOHvWOfAOkkfa/sZxqIspeg0QxzMx36?=
 =?us-ascii?Q?BwD53Qdz1PEwdvCyVh/Tso0l2n9r4vBn3o3Mf9q1ORwMA5IKNvKdT04BPrlV?=
 =?us-ascii?Q?dhQsvn3JdKqHws8zYXHJ9hp7c+BEGzi+IQxbbz8ExUEp0l1pL2428x9Hmgqo?=
 =?us-ascii?Q?gc8tApoLzhHagnnFpJrhJPyf/9E7MXhx9Spuyr6JxsL3pVmS+1Dw6Biumi/9?=
 =?us-ascii?Q?ns2e0kRJ+4Z64vMGP8aAzhOCOOfOXpTbTaKexYFyjmQgrxHAl8fRnTNUv1mK?=
 =?us-ascii?Q?gPQdJqWwSr4SkpqYcoVGmaCTcBPzdezk2ahDLx4Pnz3QAhQ0JshLDw8ACg4f?=
 =?us-ascii?Q?YmpFVSZ78OmuHdhgKnO8yOf5l8lVSvlDTiQDwLWjA81V3a1LLHvbGOWP1yqM?=
 =?us-ascii?Q?J68FNDeEqNb7Ecr70J/pkUDhNXBO3vz8If8x0UscJPnC9sQiv9M+yyAMiJ9w?=
 =?us-ascii?Q?JBulEGZu29+F0j352FUrtI5q8X4vTx0KbIgetT6IEqF9dNKeEn5P8f0a9bi3?=
 =?us-ascii?Q?eLKusQ=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 69037337-b543-4670-bca0-08d9d47376ed
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4531.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2022 19:57:43.4535
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Isg7igtrsyh4ImnSgdvwvbwG0Gf0xP+p3cToDmPZz1U362whTD4uyk0M9ANj3bE7fSoywYo4yp9SeJhvtUwZcTgGdYBmqjJw5ld9zQSeYhs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR10MB1711
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10223 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxscore=0 adultscore=0
 suspectscore=0 mlxlogscore=999 bulkscore=0 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2201100136
X-Proofpoint-GUID: N-0ATodMinnAzDVi_qkEuSsK-mhRYqR4
X-Proofpoint-ORIG-GUID: N-0ATodMinnAzDVi_qkEuSsK-mhRYqR4
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
v3: 10jan2022
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
 kernel/crash_core.c     | 117 +++++++++++++++++++++++++++++++++
 kernel/kexec_file.c     |  15 ++++-
 5 files changed, 313 insertions(+), 6 deletions(-)

-- 
2.27.0

