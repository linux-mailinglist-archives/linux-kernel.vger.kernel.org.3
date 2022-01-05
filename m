Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA37348547B
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jan 2022 15:27:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240877AbiAEO0r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jan 2022 09:26:47 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:4538 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240690AbiAEO0X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jan 2022 09:26:23 -0500
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 205D4SgT016964;
        Wed, 5 Jan 2022 14:25:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=aMz6iqOwU1npr1CjC/p7NIkvZw29LkoiO5mMa781jIw=;
 b=NYHJOq86wjSWfanduLwYjdUDZW4hlu1Xm0kpzo+f+Ly3bWz12xtF3nsERtHXGs+GN+3Q
 7chBt6A+IoLrV4RUQJDYWZ8odOdh7rnToWR+j556AlKXBzu6CEJfc46rAOIunDN4gTD/
 21TEQBfWwsySlnNaJbmbc8v5Uc92lO0DJhu5xdinTDWMGwCaFH8aI6KX7Kp0fc8yqP6z
 hBxZbkn//PkEduQt8reA2MCImVM9XiKmD5iCUUfRXhJvZSdc9yRWFkZ7JU23zrGycUPU
 Rv0U8U4mExHMyDGSz8zN4qLZL75kc7e+ukeZJhC/e88g+Aq8bQfOTIIbxe7alXBNdMeM kA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3dc8q7v9kd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 05 Jan 2022 14:25:54 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 205EG8DI030174;
        Wed, 5 Jan 2022 14:25:53 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2177.outbound.protection.outlook.com [104.47.59.177])
        by aserp3030.oracle.com with ESMTP id 3dad0f34dt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 05 Jan 2022 14:25:53 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VdebaZjVPqkJXppOtXj7x/czwsAT9O8NlaM/5a/Ya4yFSzG0vUF0ZxcrXleK4fhM4xWwn6BAQ1ykyu1R0pY1Nt0gF2+YJ+DHnUiU+48Qoy2nbi1b5xnAB0m4IDbJfen9eOuErLOPJ+6dxunXuHEkCk3XhidRm4F7CvVzAK3jB/UKUKSnZRuRFK78RLTeopJmrazLhUvsdsPgELT5QWlSoU86PSIaB+mC02i2ndVZthGoUVJl/c+COx/zmqdrR9iNpZEPPUfXUUMNWK+fGYHq3ym7EDhlQPXSajjpEMvaRBoSVL7gcwTXy0PWqg4/QrkJnGc2+4jLLArw0Rn7oMBdwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aMz6iqOwU1npr1CjC/p7NIkvZw29LkoiO5mMa781jIw=;
 b=MfYFlaPA9JdCOIUss0UNg6apaGYWXSeEhgKe7qCQs271/yBNlfyKXGfydp0g6NDnr6Pjewq543HMINwnbmvchfUe/6W0m4AU0mVgR2zcNfOeA6on+cV09LYDx61LlZSwIt7FoVHzSH/9BIRAnra/o/cK6ddEDgh3IyJ8tiHOmEsRWHaEqk4BaxeF7Mq+AcHAEnvlwfvpxT3k2uDZ3YswKuu2fUhZTx3L7IvuyOuSRKHMBnSVBmH9m2RymjRshp2XdGg/JxoskUOLFQUrOGzHGrqrS6B/7NcvGtMogisDdAZLivN1DEIaAOyrDTiRDDKEsxdTeEgIfoyrEAagq7r1GA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aMz6iqOwU1npr1CjC/p7NIkvZw29LkoiO5mMa781jIw=;
 b=U5j5aOtcT8tdRZTYX9cuw1lfI6QY0flnHH2Q+Vn9G8cedFSzP6aBv9iCb7oN+KNJbtMReOqCsa6yLGUKyOF5TEwBpN2edbhFzjPF98eIYZCXAhD/3ZX9v7HGHeO70YshAOIYoJ9CqDOJl5NX/wU3GvEXI0Pa1+cjw5ruiqe6shU=
Received: from CO1PR10MB4531.namprd10.prod.outlook.com (2603:10b6:303:6c::22)
 by CO1PR10MB4596.namprd10.prod.outlook.com (2603:10b6:303:6f::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.7; Wed, 5 Jan
 2022 14:25:51 +0000
Received: from CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::d573:6cc0:c616:6f2c]) by CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::d573:6cc0:c616:6f2c%6]) with mapi id 15.20.4844.016; Wed, 5 Jan 2022
 14:25:51 +0000
Message-ID: <d2d301e2-62df-512d-058a-a9b890e12dfb@oracle.com>
Date:   Wed, 5 Jan 2022 08:25:47 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [RFC v2 0/6] crash: Kernel handling of CPU and memory hot un/plug
Content-Language: en-US
To:     linux-kernel@vger.kernel.org, x86@kernel.org,
        kexec@lists.infradead.org, ebiederm@xmission.com,
        dyoung@redhat.com, bhe@redhat.com, vgoyal@redhat.com
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com,
        nramas@linux.microsoft.com, thomas.lendacky@amd.com,
        robh@kernel.org, efault@gmx.de, rppt@kernel.org,
        konrad.wilk@oracle.com, boris.ostrovsky@oracle.com
References: <20211207195204.1582-1-eric.devolder@oracle.com>
From:   Eric DeVolder <eric.devolder@oracle.com>
In-Reply-To: <20211207195204.1582-1-eric.devolder@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN2PR22CA0026.namprd22.prod.outlook.com
 (2603:10b6:208:238::31) To CO1PR10MB4531.namprd10.prod.outlook.com
 (2603:10b6:303:6c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 07101665-2511-4084-e105-08d9d0574650
X-MS-TrafficTypeDiagnostic: CO1PR10MB4596:EE_
X-Microsoft-Antispam-PRVS: <CO1PR10MB459650737FE057FC53D6D894974B9@CO1PR10MB4596.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2331;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jHlheXcyzpE8Bgv68ETkDcyxztyHWsfVfrRbljhtfmbcl9GsQj3BQkiDnlPcju7CODLX4gwDXajwZUoUkU7QSaOb0shjwOPeeJuJHFWG3SCm0K9f/T4J+KMbnTNyMCuatLb8VeZY/oqSb75j5VP9g14Ho9W3YA/lPYOu517koexXIiC57GDXC5VqixHjh5hlrQDqvvLPqlABdWUtiJHncmQrxhmsci46UOIai8alfzy7Rd7aNRDq7k/AMS+UWjHYt2mFGD6rmV84i5TAs3ZP6GHM+N3z1969Pa6p0p4Tp1YiT+NbS7TIHZjQ8FHknRcEp0nPdfLYHgomT8dJHGXVc7Ygw1xDZFtfYFxDnitvrojsW1QGehQ+IUkNYA5dEjXkMkPV9T2ExdzPpTWNKgRw/hE61UgdKrN5xs42LFpP9+M6fW5ndDaYrVLUuckLDq+pZ+JD5Xc8DzyL8ND6bKSFPitwhvuPcjo0/NhtLZGXQ6IzvjSUXaMcAQ5qXzNyl25yI/7J2XWCf42Ig3SQ0plExpn6Ro5QFH4GQrf3RmxBqncjI4TLwjTKaTf2inVvenNXmnrpW5UQEKjrIg1JpzNz5mq6BBqG0QTtROPVijIaOSrw8gtVNY5UhhwUdSYjrnFzh1JJXxD76/EbagC3/O1Mco90VZ2ovcNl3cQARubk+V4XC8LNP2jvBBmpSFkR6NKnsceAjMANTcGdbzJMk4UHUIbn7Z+yWDNV+TZ2CLql6UWxUrJs5DLTHy2YXsc2LUAuNbsMz1YlUt8azUbbCovoW16rPKptWWI68c9GetvqPpAx3vTlcnZvoYiyk1rsD2jJlyb979SOtpW9YwRjNtKyTaoEz2i1Ga76tqAFstlv2Yw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4531.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(83380400001)(4326008)(316002)(38100700002)(2616005)(8676002)(8936002)(6512007)(6666004)(966005)(31686004)(66476007)(36756003)(66946007)(53546011)(66556008)(7416002)(6486002)(107886003)(186003)(86362001)(2906002)(5660300002)(31696002)(508600001)(6506007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RXIrL2VVeW5Ec1kzYXFGRmpEYUlQL3pkSmljVENUUHpONlBrV0QxbHJRZWV2?=
 =?utf-8?B?cDh0UHMwL0NVZVdQMjNBQkhZY0ljYjBCN2M5anF0N21Lb0NkUi9hS1UwVTJh?=
 =?utf-8?B?Umg4RVg5WEtWMTVMMEp4MjVrb3ZzYkZRdmhTR2ZMd0xCWFZpNDVZa1RiaGUv?=
 =?utf-8?B?akJnNlV0a3VUclRNcmZtNkZnMUU4eEgzblB1VzN2T2t1RCsrRWdudFBINUtq?=
 =?utf-8?B?WHFCenNOM1pRZE1XRHpnbWFOajUzdjBsV0xhZnZDS3YzTStTOG9ueEhEc1Zv?=
 =?utf-8?B?cXhrdU4zV0hZa2JoYWNNSmRNcTRwbnhuMlJNcWFTY3Fyby90WG1abjBESW9C?=
 =?utf-8?B?dVdzZUgzYmVUc0FBd0Fad3F1bEh4azU1SzhiODI4M3FPblVLZXlTQUxKOEdu?=
 =?utf-8?B?VGF6aXVRRGVSOW0ybkpwVmdWU0xmSG1IVFd1WmFkYk1PYzVsdCtmYURiSkwy?=
 =?utf-8?B?K3VNTi9nR2ErYUpiTzcxcHJSQVJ3RXY4NmhQeTdOSW5wdXQ2b3dteTRJMElP?=
 =?utf-8?B?a0YvNjVIQ1Q2SE5MUGlsRjBOZzFWaEdia3JZaWZsSkwzVnNSTU5yWGJ0Vm9K?=
 =?utf-8?B?V2dWczJNWVBNZ3VUbUdDNEdlZitiamliZ09EVk1KeVk2QVEyWjFma3N1cGxr?=
 =?utf-8?B?TlN5UFFMR0FVWjFPS29RckY5ZmtGU0liZXpvWW5BTkZQMzFsbVd1WWUxdU42?=
 =?utf-8?B?T3Y2SStHY0lyT3R5ZlVGQUY2d2h4T3orZVZsMjlqbWtWdFpBUm15cGdrZGhj?=
 =?utf-8?B?Y25tSDhDMWluRWFHMmZraXdyR1R2OUV2bElXTkxHRU9oRC9wdGU2VlNBWCtz?=
 =?utf-8?B?ZTBQWVVzb3hBb0VjWGhOc2k3c1crMGlXL1d6TGpJS0dtejlKelExd1F3Z0xv?=
 =?utf-8?B?Z1F1R1FIK2pMOEI2MnJTTjFQWWt0bzVDcUlRWGoxZ2ZvbkRPSzBrbFA3WEtI?=
 =?utf-8?B?cW4wSW1ESExYZytFb2lIbWtVcEVGK05MZ1JMc2Q5UWRaSi9DSFZnc1dhVHgr?=
 =?utf-8?B?alY3SEd5RFVpckJnRWdkTmg5UE5yOGRLSlA0aW8xUGdkbm0zYkhPdHh3UHZt?=
 =?utf-8?B?QzdWVGRONnRNYlhQd05OS2QwVDY5bFQxV2lFMzBHZWRhRGN5V2dLN1hNV1Vu?=
 =?utf-8?B?NFdIUnUvUnNBdThYNVljZXNOSXFORVBETG14Nis0a1c4cDVBWC8zUkJJNmZE?=
 =?utf-8?B?dzRoQ1VhbGc5c1BJY3BCMUprWFdKU0lXcHAyRjl1MyszTzFHVXZZS1RwNnhv?=
 =?utf-8?B?SHBQY29PTkx5SjVVRzdRTUZTRm82MGxNT080Z3hDM2xUdU4wWUJ5ZUpIWFI5?=
 =?utf-8?B?S2Z4ZXlDdkdZWWc4QmowbHRHVHB4WkZ5b0ZJbVRneWZ4M09yZkVlenBwUUJs?=
 =?utf-8?B?N25pOWRNLzlLaFpVRXZOVFdsc3pZT3VXa2g2Q0V6cmxYWXRLWmthc1VLS2JK?=
 =?utf-8?B?UGZqRkZXdzFRTmV5emMrSU1CbHZmbVNrUm9RaUdpanBoUUNaZHY2S2dYNU5N?=
 =?utf-8?B?U2JKdU5ISThzVTFobmI1MW1rT2dSbGt0TjlucXo0UDQvWlI3OE5IamtYZWNH?=
 =?utf-8?B?WmpydWUvNmtEVDdsYWNnTStzaHB1KzB1VXRjcU5ZVFFINWRVdHNXdjBXL2Vu?=
 =?utf-8?B?RmkySER6MWEzWFh2Wk5hbFVsMzNLOExEWlpjVGx3Z2Z0MTdJSmxXeDEzVXRC?=
 =?utf-8?B?VHgxUmVoSUZ6dDRPYkV1OWZqMU1kTWhKMGhyeldnaTloOTZ6TjV6elhvS002?=
 =?utf-8?B?ZGdOajYzVmRDbVdrUUo3RTk0UEpybFBjUWpRRCtrRWc1YUsxUXRzRGxUSkxC?=
 =?utf-8?B?bGt6TUVTdmRzSTE5VGVXWWEvTnYwd01SbzJuTzZHT1FTb01BVVRDbVBoOFBB?=
 =?utf-8?B?UmNEUUhXREl1K3N4SDJiRks2M0JydUc3TThhZXE5QUdoUm00bS9ubUR3L3p0?=
 =?utf-8?B?SGxkZHdoMDhJVW9kdXpNUDN3YlRQYXUxZzd6VGRMOFp5UWtSMFl1eFl3ejg5?=
 =?utf-8?B?YjQyWW1ydnFib3crNnVCUmlrVTNBQitlWlorVzVEZWlIUm94Wk1ZM2UycDVK?=
 =?utf-8?B?Y05ZcU5ld1ZaeWJ3dStYMzY5eHgvcld5d2Z3RHhJYk9CWFFwY3Nnb0lsK3JE?=
 =?utf-8?B?U1dOeEpBYjlWWnZUUDV5ZHpveDdLRm5reVdCNXp0K2s0UlNmdjFmQjRad2Rj?=
 =?utf-8?B?UlpKUHVpUXM0Z3JlbXdnTjN5NG9NcjVmdEt4YzRsbHFCY3JEenFJTmMyT2xn?=
 =?utf-8?B?MG5NZndZc2p0SHJUM28xcVhWNDdsRGxzemU5VHlvczhlOWxnMnprekd3Q2x4?=
 =?utf-8?Q?ILFm4kG38ezNoLhKP7?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 07101665-2511-4084-e105-08d9d0574650
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4531.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jan 2022 14:25:51.3354
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aHk6ugJy2D365P2eqUvVpdnBlwjsEM9vjfayKMav8GToj6QRPFyUoGspPZQMg1CXtYEp18//X7PB/Q95h9jozosNxMhMARJUUYcgOvsnUlo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4596
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10217 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxscore=0 adultscore=0
 bulkscore=0 suspectscore=0 malwarescore=0 spamscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2201050096
X-Proofpoint-GUID: WRcpOW54aUNiGjw0R7dX6ZIykgF7E-VP
X-Proofpoint-ORIG-GUID: WRcpOW54aUNiGjw0R7dX6ZIykgF7E-VP
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Nudge...

Fwiw, below is a working changeset to kexec userspace utility that allows the kexec_load
path to work similarly to the kexec_file_load path of this RFC. With both the following
userspace kexec patch and this RFC, both kexec_load and kexec_file_load work with changes
due to hotplug *without* unloading-then-reloading the kdump/capture kernel.

eric

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



On 12/7/21 13:51, Eric DeVolder wrote:
> When the kdump service is loaded, if a CPU or memory is hot
> un/plugged, the crash elfcorehdr (for x86), which describes the CPUs
> and memory in the system, must also be updated, else the resulting
> vmcore is inaccurate (eg. missing either CPU context or memory
> regions).
> 
> The current solution utilizes udev to initiate an unload-then-reload
> of the kdump image (e. kernel, initrd, boot_params, puratory and
> elfcorehdr) by the userspace kexec utility. In previous posts I have
> outlined the significant performance problems related to offloading
> this activity to userspace.
> 
> This patchset introduces a generic crash hot un/plug handler that
> registers with the CPU and memory notifiers. Upon CPU or memory
> changes, this generic handler is invoked and performs important
> housekeeping, for example obtaining the appropriate lock, and then
> invokes an architecture specific handler to do the appropriate
> updates.
> 
> In the case of x86_64, the arch specific handler generates a new
> elfcorehdr, and overwrites the old one in memory. No involvement
> with userspace needed.
> 
> To realize the benefits/test this patchset, one must make a couple
> of minor changes to userspace:
> 
>   - Disable the udev rule for updating kdump on hot un/plug changes
>     Eg. on RHEL: rm -f /usr/lib/udev/rules.d/98-kexec.rules
>     or other technique to neuter the rule.
> 
>   - Change to the kexec_file_load for loading the kdump kernel:
>     Eg. on RHEL: in /usr/bin/kdumpctl, change to:
>      standard_kexec_args="-p -d -s"
>     which adds the -s to select kexec_file_load syscall.
> 
> This patchset supports kexec_load with a modified kexec userspace
> utility, on which I am current working to provide separately.
> 
> Regards,
> eric
> ---
> RFC v2: 7dec2021
>   - Acting upon Baoquan He suggestion of removing elfcorehdr from
>     the purgatory list of segments, removed purgatory code from
>     patchset, and it is signficiantly simpler now.
> 
> RFC v1: 18nov2021
>   https://lkml.org/lkml/2021/11/18/845
>   - working patchset demonstrating kernel handling of hotplug
>     updates to x86 elfcorehdr for kexec_file_load
> 
> RFC: 14dec2020
>   https://lkml.org/lkml/2020/12/14/532
>   - proposed concept of allowing kernel to handle hotplug update
>     of elfcorehdr
> ---
> 
> 
> Eric DeVolder (6):
>    crash: fix minor typo/bug in debug message
>    crash hp: Introduce CRASH_HOTPLUG configuration options
>    crash hp: definitions and prototype changes
>    crash hp: generic crash hotplug support infrastructure
>    crash hp: kexec_file changes for crash hotplug support
>    crash hp: Add x86 crash hotplug support
> 
>   arch/x86/Kconfig        |  26 ++++++++
>   arch/x86/kernel/crash.c | 140 +++++++++++++++++++++++++++++++++++++++-
>   include/linux/kexec.h   |  21 +++++-
>   kernel/crash_core.c     | 118 +++++++++++++++++++++++++++++++++
>   kernel/kexec_file.c     |  15 ++++-
>   5 files changed, 314 insertions(+), 6 deletions(-)
> 
