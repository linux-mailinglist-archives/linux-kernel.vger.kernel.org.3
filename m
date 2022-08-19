Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 171CF59930D
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Aug 2022 04:32:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230098AbiHSC3H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Aug 2022 22:29:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239874AbiHSC2y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Aug 2022 22:28:54 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD80789825
        for <linux-kernel@vger.kernel.org>; Thu, 18 Aug 2022 19:28:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660876130; x=1692412130;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=VOZgpqmFiTWs+pMKV0vXJwpITjdLUpQ7J51RkCdzMSM=;
  b=L+xtu2OVeodxcQwZ5Lohm4bUfLLASYxbzqve9TlTeCen0Fe47Frt0YEO
   y077NX4nAAxmM4UukNp/RY+yevudE1KpGkFQCvh1O3pXV4XKcsT2VKcZs
   d+bFRZlYc3T4QgD4HnX3J3Acm9m/PMR5OA1mVdjhyia5er6ZJeaB3wIL1
   Qt5kM6ek0LKj4OQmmBVygJMg2MGj7RPXdHAjQ8mOEFLvN7eVJcD0Hjo5z
   Mdtl2ky3d2tMQN/MXUgkZRrDXV1yRfWj6nHR76Pr8cqOSbdpIxdhu+xJB
   4j89v6uWNaf73HPhnZ7a69gY3uNGNbAuNj/ClYdxTFNkMZgjsrHYof6OU
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10443"; a="279879729"
X-IronPort-AV: E=Sophos;i="5.93,247,1654585200"; 
   d="c'?scan'208";a="279879729"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2022 19:28:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,247,1654585200"; 
   d="c'?scan'208";a="711171396"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga002.fm.intel.com with ESMTP; 18 Aug 2022 19:28:49 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Thu, 18 Aug 2022 19:28:49 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Thu, 18 Aug 2022 19:28:48 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28 via Frontend Transport; Thu, 18 Aug 2022 19:28:48 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.47) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.28; Thu, 18 Aug 2022 19:28:48 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k/Wo4WjD04imInF84+N8gzJnZSFrw687frEpV7gOAP7vAuO6YxzUgkGXEZujHRIlqwe5wEjVZE/aGNXu1IEKZJj/XsNq7CpYCn0ux4XKMpEB6dK6DmI3K8jRyZrptR/CD78oJse0N5PYwDKSUNBOsHbaqU8eneIx9OeFxcLfUAVDpoS2Oe8eJrmh3SXV2V33JQH+bD26ZSX3IqbiMtSCMP6Lhvx/VuMY17IlvYfYACx7TEkO3ZYYiaIzwj8O6Pkd6yJFxwhsfPhEMDBuPFZNaGN0ZTV0VecqAJvS8zmJyVkkAQnlB1/TaP5EqpSXNNth/pWdvJ9bL6SnJT2LH44iNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Aa6p1zWRdmiQIaprfbXcUIF2CYnX6x6qqVvJ2lApT50=;
 b=VEAiP2+ARkAjQ72JKKRYCLaAgQ4r29uGmLpYhLNPu/UGRIE1xTMQDO1BVBYpPjwhqlmTuhEGlArJ9sgJ4ey1x9MiCaSaO/4dVcrmt5A7QwwB1ADFwSTjcftKb1umA4eUBU1q8zkJ6gi8afyRv+NcZReRcDnoasbwFOIKE9QsDzNQl0MIHUcoVWRyQ5uAbwBsO8JkKmvW4KyghRj09dPV7fyoVvZR2buxhwAOZ54sulnC2iDu/7iKxu2mOtx2Tr+84L56Dcd6DEnKfZCiayBZyZZlbvj2Wn+Vdy8b/4KRz/uhVE63BH2vARwgN8AM46ejtmuIJFDypNsA/4VtqNa/lg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB3062.namprd11.prod.outlook.com (2603:10b6:a03:92::18)
 by SN6PR11MB2637.namprd11.prod.outlook.com (2603:10b6:805:54::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5525.11; Fri, 19 Aug
 2022 02:28:45 +0000
Received: from BYAPR11MB3062.namprd11.prod.outlook.com
 ([fe80::756c:27f:6d51:bdda]) by BYAPR11MB3062.namprd11.prod.outlook.com
 ([fe80::756c:27f:6d51:bdda%5]) with mapi id 15.20.5525.011; Fri, 19 Aug 2022
 02:28:45 +0000
Date:   Fri, 19 Aug 2022 10:28:36 +0800
From:   Aaron Lu <aaron.lu@intel.com>
To:     <security@kernel.org>, lkml <linux-kernel@vger.kernel.org>
CC:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        Logan Gunthorpe <logang@deltatee.com>
Subject: [PATCH 0/1] Use proper mask when setting PUD mapping
Message-ID: <Yv71VPSjyy26v/Xu@ziqianlu-desk1>
Content-Type: multipart/mixed; boundary="5omX3carWOuFzPxi"
Content-Disposition: inline
X-ClientProxiedBy: SG2PR06CA0248.apcprd06.prod.outlook.com
 (2603:1096:4:ac::32) To BYAPR11MB3062.namprd11.prod.outlook.com
 (2603:10b6:a03:92::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a442948f-e2fe-48d5-3ddb-08da818a8a38
X-MS-TrafficTypeDiagnostic: SN6PR11MB2637:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IO4eNkX9YCDn0h5ow6ospSJgUz7/JukQ0bwRcDO1D2ukLjuVoiHNlPJ/U86DcX/YcHgQ83H8m3h264qVPPvHU9T85cZGZoMS+pl9ZjsQJVzHmru1+AgoU+B6bVSW7cn0SD9CPQv14pKcoTAF1LZPV7ZhPRUDtdYYzP5XVG4Iqn6icAiGWG8KVAXESGo6uGZLcb9DCU1s7/zvWR/APyNknhqta8uOsPjFVWvzuXRWpK6lE3xontU53/aMGB04kpdrA+VzH9lLsebVfUdum+Q98QLTJUxvLaLOyrveGsTEd5Km8D3XFcbYjGJEacVkQOZx4OFYYCc+xQYmTULOj7UsZ1Bwki4p3b5BywDm8zHVQeXP4xdPQmoix8sYwxzBHS7dtMLg8puigodBuZkji03aAjyLbSW7zzKSOrjDHDq+o5XGa5TnXul7zGkxGZ9WxdLJlCGwsJS3nzb7Tn8hQ3mbxfGLP09tFdnjwF4RrHmZR919du/aqc+9pfbgJZe9ApVVp1ArcfKK8M7JCQjEVLOWqgIBzb7+5IT49o7iL3HAZgAnyZY5EXm7FHAtF/rMzdKSAAnRHnm4t1mTA/1fgZ8b0VIhDED6P0ZcFd92RMlB5UrecIy9JuBAFcLmTYwkuE2Ywov0FGgmZFV/WigSSMJGd/sHQuqq9Wn+CeccknjMPK/JE9DyA33Zx5Mnxrn5ltPOvKHFGeVk7mr2myT4BLlRqKvyvxx9XTeBNyITDEEV1joFOr7bgkNA/Vb6kpGMFg1HNwsDjwvKxMgexoTER1DtI/9BuodckcSSjycWHX9hClg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3062.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(346002)(136003)(39860400002)(396003)(366004)(376002)(2906002)(33716001)(7416002)(478600001)(186003)(83380400001)(966005)(6486002)(26005)(86362001)(4326008)(66556008)(38100700002)(44832011)(8936002)(54906003)(6916009)(6512007)(66946007)(82960400001)(6666004)(66476007)(9686003)(5660300002)(316002)(235185007)(6506007)(44144004)(41300700001)(8676002)(2700100001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?zNUR9RHwryqbip6ZCGsjwyFVEAAf75YkV0bYiBvfdYN4ncllN3xePPy1tUim?=
 =?us-ascii?Q?Cf/AQhVx7zzRXyKRJi8MkvRz0u5LVdXs0C+SmXmpcy0edOYD13VPkd8PG1Z/?=
 =?us-ascii?Q?MA1HFSzUY5PeGbDAnsJ5aT5QvdPe0JfMJG+bQlk6UbGQ/UmAHxl79ht77yET?=
 =?us-ascii?Q?Fcac+Q8UX+S/aNbBxExnplR1WvHmE9CcRf5rrZZZYM6T7b+0zSo3qqjJpabY?=
 =?us-ascii?Q?F+0k4+IxY8pNehF7SBCcsZY3AJWXWsw2Z3nsalYPUBlm40NtJbhWKZDXJyCD?=
 =?us-ascii?Q?S3HLorxVywqHPFkJJt360nC3few3ucJg/H/jc+9nfbxbOaHAmUG8YAaTdZId?=
 =?us-ascii?Q?rI+h5sk5eQUq+Fl99nW+tal8duX2QCJXxVz8pCwtiCmVg4R5ZBNBlNousYqG?=
 =?us-ascii?Q?bcJUMcHbmBpdokt6dERWBYp/2UMJROy8hv4M/3WrNr1dayyhvl5zfo920Osa?=
 =?us-ascii?Q?oflvoDeUclswHiDdaM34BYwBGFCVlJbpCaJFwCM3sJSgeXd1uRIoRZkF0swn?=
 =?us-ascii?Q?W4A5uBsjs7lS3/G5iV9JxtabHRUvarZ96ZX+us76k6/imU7TpKs/XgZyammO?=
 =?us-ascii?Q?t/N6nx5e4zsjuibPy1ngXggLHgfajbwq5FrZE2oMu9/YrVX4RvJuh8AsJpCA?=
 =?us-ascii?Q?z5AC/eqhfQuJGzo6WewcgNRGnNWgAj+NWqPhvMt7Dy75WwjbhFlZuT4ouk1f?=
 =?us-ascii?Q?tpi0v2+pHwolRF0MPM+ub4Y5ARJNp3yQOmkWgJFm6HmQw45vs4eLJUoz7Hrh?=
 =?us-ascii?Q?zkGgIaA7uGaFHi2rMkfvK+SXk6g7wDbCscw19l/RUl4JBL0VCHJxTtSooXUs?=
 =?us-ascii?Q?q1vWY0QdLjHTKlsSf3Bp14Ege0r5jUR1i8TcdZ6Oo/D8C2iwzVMT/F/Rl4Om?=
 =?us-ascii?Q?cui+vFLLkg+cXVuVREpLnD0y6B5uKLMJBF+zet76VHX/itjwEXhG4/8s6SMI?=
 =?us-ascii?Q?JlxjkZILaFigqxQRCkQXqxFMhQZ1t6ajSmkIqJssn35aVrkDctGgjucUDhFj?=
 =?us-ascii?Q?Tsd7vjLD9Y/a8qKXjHtM/wDd9Rv4RNiLUPubmjUOd9U3aT7Q3zN1xkGKFofZ?=
 =?us-ascii?Q?+ACDVBBKeodXOG1+pssvwD2TWwpljZ5hZ+oL/JRLCNZbkBbIF+3LuXcFg6Nl?=
 =?us-ascii?Q?p7Oi04aS/nouAqFSXTjqWpVGxYLZ8CeDjF86lN5SGPrw9HC+L4sTddSwTiNk?=
 =?us-ascii?Q?wpkqcfMF+hKgnR3Tdj/vIdacp5oK6+Tgziztdf0lp1bIonTS4y5jnGLafApA?=
 =?us-ascii?Q?MjeLOls2ijPSvobNhqk/Mylbd5CzXQs+w5M7uja/ms5i1sIQTo918XQK0Rni?=
 =?us-ascii?Q?a5oWDJsJUS5wHslpUbfT6u0nk6HGPhXe9qF6+CzJoq31gFmnu7y55fZ60+fh?=
 =?us-ascii?Q?ZF0OMgFpzYHTCOLlDSObG7GU7fD7Y+tY43CjpgeZ+uCxMUoXxRCBkz/iTPHu?=
 =?us-ascii?Q?cwc5CsD83rX0g0LbgUSKifym/M7eHT/8M0KoAulFd4XzIWyfB1xSvRytZb2n?=
 =?us-ascii?Q?0v9ooR9ukGtbJ18ZB3+mwjvnVYIbb299NXM/+Uj0v97bhwiCJkdn60OuXG3Z?=
 =?us-ascii?Q?Yv8Loex23m5YdgWso8q/vARv5ZrWYwBI9Vr7HkeK?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a442948f-e2fe-48d5-3ddb-08da818a8a38
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3062.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2022 02:28:45.2164
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: b4vOHL8oSPCHZTAjel3pwoV7pB0U58b7t8RUhK7DSO7gOXkCE9iMrflY/gfgExTtRu14a6UfTAP2uT8GIXp3xw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR11MB2637
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--5omX3carWOuFzPxi
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline

Hello,

While addressing community's review comments about how PTI treats Global
bit in kernel page table, I noticed most part of the direct mapping in
the kernel page table has the Global bit set, while I think the intent
is to unset Global bit when PTI is on for the majority mappings.

e.g. on my desktop with i7-7700K/32G memory, the following part has
Global bit set according to /sys/kernel/debug/page_tables/kernel:
---[ Low Kernel Mapping ]---
... ...
0xffff888140000000-0xffff888840000000 28G     RW         PSE     GLB NX pud
... ...

There are also many other parts in the direct mapping that have Global
bit set, I just showed the biggest part.

Leaving these entries with Global bit set doesn't look good, as Global
means when switching from kernel to user mode, this entry, if has
been used in kernel mode, can remain in TLB and user can potentially
make use of this entry to speculatively access memory that they shouldn't
access, reducing the effect of clearing kernel part in user page tables.

I tracked this issue to commit c164fbb40c43f("x86/mm: thread
pgprot_t through init_memory_mapping()") where it used
__PAGE_KERNEL_LARGE instead of PAGE_KERNEL_LARGE for PUD mapping.
__PAGE_KERNEL_LARGE is a raw value, it doesn't get the mask of
__default_kernel_pte_mask, hence leaving Global bit on these PUD
mappings(and mappings that are split from these PUD mappings).

While to see if this left Global bit can really make bad things happen,
I wrote a test code based on secret.c from:
https://github.com/IAIK/meltdown.
In less than 10 tries, the physical_reader program can recover the
secret strings set in the secret2.c program so I think this issue should
be fixed. I run the two programs like this:
# start secret2 from one terminal, bind it to cpu2
$ sudo taskset -c 2 ./secret2 
[+] Secret: Burn after reading this string, it is a secret stringce and kernel
[+] Physical address of secret: 0x120121000
[+] Exit with Ctrl+C if you are done reading the secret
# in another terminal, run physical_reader. make sure to bind to the
# same cpu so that it can see the TLB for the page where secret string
# resides:
$ sudo taskset -c 2 ./physical_reader 0x120121000 0xffff888000000000
[+] Physical address       : 0x120121000
[+] Physical offset        : 0xffff888000000000
[+] Reading virtual address: 0xffff888120121000
                           )
Burn after reading this string, it is a secret stringce and kern^C

This patch fixes this problem by using proper mask when setting PUD
mappings.

Aaron Lu (1):
  x86/mm: Use proper mask when setting PUD mapping

 arch/x86/mm/init_64.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

-- 
2.37.1


--5omX3carWOuFzPxi
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: attachment; filename="secret2.c"

#include "libkdump.h"
#include <sched.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <time.h>
#include <fcntl.h>
#include <unistd.h>
#include <sys/mman.h>

const char *strings[] = {
    "If you can read this, this is really bad",
    "Burn after reading this string, it is a secret string",
    "Congratulations, you just spied on an application",
    "Wow, you broke the security boundary between user space and kernel",
    "Welcome to the wonderful world of microarchitectural attacks",
    "Please wait while we steal your secrets...",
    "Don't panic... But your CPU is broken and your data is not safe",
    "How can you read this? You should not read this!"};

int main(int argc, char *argv[]) {
  libkdump_config_t config;
  int fd;
  char *p, *q;
  config = libkdump_get_autoconfig();
  libkdump_init(config);

  srand(time(NULL));
  const char *secret = strings[rand() % (sizeof(strings) / sizeof(strings[0]))];
  int len = strlen(secret);

  fd = open("/home/aaron/test", O_RDWR);
  if (fd == -1) {
	  perror("open");
	  return -1;
  }
  ftruncate(fd, 0x1000);

  p = mmap(NULL, 0x1000, PROT_READ | PROT_WRITE, MAP_SHARED, fd, 0);
  if (p == MAP_FAILED) {
	  perror("mmap");
	  close(fd);
	  return -1;
  }
  memcpy(p, secret, len);

  printf("\x1b[32;1m[+]\x1b[0m Secret: \x1b[33;1m%s\x1b[0m\n", p);

  size_t paddr = libkdump_virt_to_phys((size_t)p);
  if (!paddr) {
    printf("\x1b[31;1m[!]\x1b[0m Program requires root privileges (or read access to /proc/<pid>/pagemap)!\n");
    libkdump_cleanup();
    exit(1);
  }

  printf("\x1b[32;1m[+]\x1b[0m Physical address of secret: \x1b[32;1m0x%zx\x1b[0m\n", paddr);
  printf("\x1b[32;1m[+]\x1b[0m Exit with \x1b[37;1mCtrl+C\x1b[0m if you are done reading the secret\n");
  while (1) {
	  // keeps doing write(2) such that the direct map will stay in TLB
	  write(fd, secret, len);
	  sched_yield();
	  lseek(fd, 0, SEEK_SET);
  }

  libkdump_cleanup();

  return 0;
}

--5omX3carWOuFzPxi--
