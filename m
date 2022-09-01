Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A52D45A8F52
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 09:07:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233642AbiIAHHc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 03:07:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233471AbiIAHGy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 03:06:54 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D13A7E32B;
        Thu,  1 Sep 2022 00:06:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662015992; x=1693551992;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=6fTxHE5m18wlV6eO7gpS+9Mmf8fRd0rUzvLoUezNG/g=;
  b=HrDuDAWMn+kqMZjypIlaoHlPufS7BXGVt6MX0Hl/DNDS/q5x/xVjvfO/
   0+HCll8OwFKYNZMjW44hGd5BLdT7c1GycSVotjguKCU1bmIS+duR/nR6m
   H9DXjmXXeTzxhT1nZLyWjeLxeG24ia6JEXNclHcGAmPw2/c4pYXa/nGf5
   83QypuCxgfwzd9R/Tvm1GOsDOCz8L94cOa6Wc9w/9CnrFdYIt8xzW5DOv
   3QFiZea8P+hYRJqrD+rBt4bCJjjDdZWjiB9wEvoRN0TNGnxIQ8o3cpe8M
   Nq+NYIFGdjRYg7bLGXzunWd6Q/PbX8GpJJFOm9AmUZnOnMp3WB+w9gyWz
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10456"; a="295640738"
X-IronPort-AV: E=Sophos;i="5.93,280,1654585200"; 
   d="scan'208";a="295640738"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2022 00:06:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,280,1654585200"; 
   d="scan'208";a="645530475"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga001.jf.intel.com with ESMTP; 01 Sep 2022 00:06:28 -0700
Received: from orsmsx608.amr.corp.intel.com (10.22.229.21) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 1 Sep 2022 00:06:27 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX608.amr.corp.intel.com (10.22.229.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 1 Sep 2022 00:06:27 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Thu, 1 Sep 2022 00:06:27 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.109)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Thu, 1 Sep 2022 00:06:27 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j56F6qocqcF2sZKhMp5O+O9YzJyfdpAhqhxsIeQGpnmHEV2B5y/naM871sZxxdyubKF7/HplpY3+pRuonHXheXZ6CJZjEGohtYpjSYRZJingq2tQcDYkbwpwPqG1qKn6vhxjVDk0hAduHxN6GHNc7UnP0rI6BQASk1h8PnE5qThOaFqVyJOhWKNmaOXIZvvfjo+sXJ041ye+OxIUuJcRRa6Yi0Wzwc8v4Ii9NUYbSfTX+R7Zwsuhck7wQP8fc2wxY+Ci5RNYaVujUXikwC0MSZWhM17IP6bJHpX/BGU0CeOH3gf+J2Z72NKd7PScgfKkFNGKNUSsT2357kxgXnCqBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ErwuE9CwcwwbfUrsgkV/fX72O3i3onady8HILPm1egc=;
 b=TiNQqW28dJ5WLMnLF1QfVhO8BGwKO05DXAzMRDJe94hR/FpbZ8UaunF5AiEkWv+MNHtMZV7YotOsbQm8Sk06vsKenD1JbEx3RkpSmOefHLsKl0qLypWEOPhSKrYzCBEglrzSlXxbJ/MHE5E7ojNjunh8Qs4hNOi3MRZrCe+4m063KJP1doa3H+0NuBHQA7m1kzG6OCxUQoLepRsQe9B9xHxmetWq5S/GPwaQNnFXdBGIEE5FHOPjsuicFCUCYRx/mWsu1R/KLR7xDFYxQ2IYhbWhtRa09JMu4+521OpE33/r9oOLWPcfsI6czB9VApOM42dIbJsJOfz+QFBWbWUHGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BL0PR11MB2995.namprd11.prod.outlook.com (2603:10b6:208:7a::28)
 by SA1PR11MB7061.namprd11.prod.outlook.com (2603:10b6:806:2ba::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5546.18; Thu, 1 Sep
 2022 07:06:25 +0000
Received: from BL0PR11MB2995.namprd11.prod.outlook.com
 ([fe80::5482:e4d0:c7d9:e8be]) by BL0PR11MB2995.namprd11.prod.outlook.com
 ([fe80::5482:e4d0:c7d9:e8be%4]) with mapi id 15.20.5588.011; Thu, 1 Sep 2022
 07:06:25 +0000
Date:   Thu, 1 Sep 2022 15:06:15 +0800
From:   Philip Li <philip.li@intel.com>
To:     Masahiro Yamada <masahiroy@kernel.org>
CC:     <lkp@lists.01.org>, 0day robot <lkp@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>
Subject: Re: [LKP] Fix make.cross for 0day bot
Message-ID: <YxBZ5wcGUSQ/VeHD@rli9-MOBL1.ccr.corp.intel.com>
References: <CAK7LNATbAVE8QY_QZQkiaNy9UZb2tH30eP50n0TNpgsHVrTKJQ@mail.gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CAK7LNATbAVE8QY_QZQkiaNy9UZb2tH30eP50n0TNpgsHVrTKJQ@mail.gmail.com>
X-ClientProxiedBy: SG2PR04CA0161.apcprd04.prod.outlook.com (2603:1096:4::23)
 To BL0PR11MB2995.namprd11.prod.outlook.com (2603:10b6:208:7a::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7b2a5b26-0fc4-4c3f-1b3a-08da8be87b7d
X-MS-TrafficTypeDiagnostic: SA1PR11MB7061:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QDgD5PLhkwt+Jgucak8Y1RAW++YpafH1q90joRR+DLDHfkzCwolX7y2/WdCZsyEoGKsNE6gtxX8ObFWac+746K0oKB9CwDOc4CJiBbKAf+7Et3My5B7BJc6B4JT3x1R08S6lagL96GmlHAeX/hHPrmG8ZIRbt0J5R3O1047uta90zMBq7Wnx9iXbknElQuUQc9s0M4VHuGwkPl/d8xEnfh7zFf19HghbfoJEfAgt8tMNRjhU80f0jvMhme4qXE0Ec99sEjEvGjhb1+6OAH7tqkWnhzwfe/k9w80o9kE7xzhlmxWfAjnvZjUuOsjxU/ud6Py1Hm7yQsynJaq+REdx9GZ/RlJy22TTCX8s0YBeqB34yeTza6tBk5j9vbs0gDqhNdwjpXsoJGdODfwSs2zSZEDgCDTQ2faTcqQ6XCvCTs4h7yWmgIYZpKKqfz24eqMp58W1wwLCoikqxMdtHDvnTzh4m87oUXF3a+Ar8atR7YMqtvSsVGyuF+pRbCjrJXjnvjSTagiTfUv4Hk5X9IkgyLVDuUNKWCWvMbg1o+ZQNSYfFH38CQC2DIvJ4UJaD8PSu6GEijJ4fl+fj0PGGUqG3tIr1rTJQ4rRphLzUQ57oUqGiO8m2X/S1lIAX8FyNZ7cp63+IPNnyE8elBZW2kRmdQKzaUrTV0rZyF/0EBTSGR+xwDWo6bCtjJpwTmXI8zMhNX+cCt7pBXd6Xw8m7CD3/h/MzCVDIgvEZ26zeEc5PZtX1SsMgGcWnGKxUoRjQL4HBCgaflDxNwaCb8Ax9IWN9g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR11MB2995.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(396003)(136003)(346002)(366004)(39860400002)(376002)(186003)(86362001)(26005)(38100700002)(6506007)(2906002)(83380400001)(316002)(966005)(8676002)(6512007)(6916009)(66946007)(82960400001)(5660300002)(8936002)(66476007)(478600001)(66556008)(6486002)(4326008)(44832011)(54906003)(6666004)(41300700001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?SlYwa10/i+KIHX2ETIWvVMxpYL0LyyvBXIs2YDAk0o8803jaPUBowH1bWYYZ?=
 =?us-ascii?Q?vK5nst4Q9KbqvFZd6ZuOwk2+egp4ZyehcvzFYmIVBI/otokD4zitj+DD/Dvi?=
 =?us-ascii?Q?6OV7tmNHZa7wlMXjIgkHRxcpmp8xD1ocD9sBGmsAHc2IG1o/dQZf1ZO+OW5Y?=
 =?us-ascii?Q?FAmC2/c5n9/Gx0xywACGkcvt8Rf7jJl3IOZ/rNSp7Mlfowgsj/4KG3d5ob9D?=
 =?us-ascii?Q?McnHZUh/GRZYS12OSZivdJoQf5IebwMACP+ga6opAPU/h8kRwj2U1mpR5o8D?=
 =?us-ascii?Q?x5Y5dAnY7ocv7KIwcN2Uqy+yv1it4hZBaehgD8pu3trIW6rbCSyUwQ0OeaVM?=
 =?us-ascii?Q?ao0aU5on57EpA6EhM02E/+uDf9YqWYPDvo28YZ7MFrH5e9iE3Gmvfc1hi9Tv?=
 =?us-ascii?Q?iaZfcxYiGsAcDmaw6RtiydUH+PNTqc5aMwAmWonAqxVFasnDzYFmbZuDBTd8?=
 =?us-ascii?Q?2V06piGXV9sockSo613Rxt8o1fFDsww/lcRQBacThjDBTnkc6tvFf2n/oaCp?=
 =?us-ascii?Q?mWzkaM8K6Psjw6sT4AvpbkskaFCiH3Af+3xUTU8IOSmekcIbEnjJG+P0S1Wq?=
 =?us-ascii?Q?NYiQ+PyTu4YFRmfIr68VVWsLd6I4fbPSDQSQy3fCr1zNuIjFRybgBkmaGQ98?=
 =?us-ascii?Q?wvWub1u6MjGL0Xm97PKkGA1yzcxwJg8qDhdVLA+Ea8+s2jYPSPc97LvrD++j?=
 =?us-ascii?Q?QSGL0VWOIzr3K/mbHtXMOg1CHS3swiZXPRVC3cEvXccIuSOjaCygqPgLQ/3i?=
 =?us-ascii?Q?YT9+dZ8KuYXp7Bs7xHDThZaeFmcbLXPFMExj2JiBGbLvHEL8h0o6Sm91rTKw?=
 =?us-ascii?Q?cyya0zE0dk8bpxvucGMfKq3wKuSW+IkEdxT/8wpG0UT0K6YsEaUtFK9dTCB6?=
 =?us-ascii?Q?l9JshQeQZNpjc+LF7ZBS1h8Tc8VQL/WxGQE6VW+osVkk18fZlx/JnzozGFtE?=
 =?us-ascii?Q?264qbcJM7kPXKx51QFsXXcPf9KMZgZ3uZ4qq91lSHvLAn0OtN7vlC6mBM18+?=
 =?us-ascii?Q?Ej6s6xtirLMru0YltAVz+2gWWDiJQkPFfCIwgyOgSLyLVVusl9Y06Wf2+cXl?=
 =?us-ascii?Q?XRlzw/8Lyez4jYwiXlRs6YBo3J7Ntd9tq0oLi7dfZhunR7TKjjTkCYcEyhP9?=
 =?us-ascii?Q?ZkgBQrPfTwMO4f0mHdTz9bYeYi/TDs0mUMBxlx1NyQWDPQ2qMLwuMMMQVnt1?=
 =?us-ascii?Q?DprcnPDAJlATsJu7vuQYOO6LVKI2tgmisKPd+cY0RB8O8xwrpKVbicbdD70y?=
 =?us-ascii?Q?mP4eWkdItyuw/8UzH4sqRzbGG98x+ZLiM00l2rFL/4+Sik8w3VdYFa5hPTt4?=
 =?us-ascii?Q?BEuWnfzSu1ovccRpth/xEy7oSYB4JzE0bAAgjZ280MIDkpxK7qPuFC+TeENc?=
 =?us-ascii?Q?9QvVYm+JK5C/Pk9KBJakqR7tj/N3o+Lnt/OaS7vvDCzZpLdBCMskor/zplWw?=
 =?us-ascii?Q?KYQ2Nv1VwL/Y8VawYsoLToU4h6QbCB5NcwnKeyZsL1C6M6BfebPauMjpSj7a?=
 =?us-ascii?Q?YW2eDwDDbg0iEsREfcFeUIB9vKdBsoh1XUwiRtABkUyQeI4zDRCqAee+Utv3?=
 =?us-ascii?Q?tFRMsXk9ivziSVztWDiVxoZJQ0BX1pvAcVFgP9+BdU2lT5hvQU4e7AIXn28A?=
 =?us-ascii?Q?7g=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b2a5b26-0fc4-4c3f-1b3a-08da8be87b7d
X-MS-Exchange-CrossTenant-AuthSource: BL0PR11MB2995.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2022 07:06:25.0566
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YxunDQlWauOMId4KnWAHqSXvsxHzgFK5d3y422jay01ma5GANM1HwcKcryq/QlkLXlogpYkSbft7sOZK2ATkpQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB7061
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 01, 2022 at 03:55:52PM +0900, Masahiro Yamada wrote:
> Hello,  maintainers of Intel 0day bot,
> 
> make.cross is supposed to use the latest GCC by default
> (according to the comment "use highest available version")
> but actually chooses GCC 9.3.0 rather than gcc-12.1.0.

thanks a lot for pointing out the issue and fixing it. Do you mind to send
a PR to https://github.com/intel/lkp-tests, or you suggest we composing
a patch based on your fix below?

> 
> If both gcc-9.3.0-nolibc and gcc-12.1.0-nolibc exist
> in COMPILER_INSTALL_PATH, make.cross chooses gcc-9.3.0.
> 
> Likewise, make.cross installs gcc-9.3.0 when no suitable compiler is found.
> 
> 
> This is due the fact that compiler is sorted like follows:
> 
> gcc-10.2.0-nolibc
> gcc-10.3.0-nolibc
> gcc-11.1.0-nolibc
> gcc-11.2.0-nolibc
> gcc-11.3.0-nolibc
> gcc-12.1.0-nolibc
> gcc-4.9.4-nolibc
> gcc-5.5.0-nolibc
> gcc-6.4.0-nolibc
> gcc-6.5.0-nolibc
> gcc-7.5.0-nolibc
> gcc-8.1.0-nolibc
> gcc-9.2.0-nolibc
> gcc-9.3.0-nolibc
> 
> 
> Then, gcc-9.3.0-nolibc is picked up since it is listed at the last.
> 
> 
> 
> 'sort -V' can do natural sort for versions:
> 
> gcc-4.9.4-nolibc
> gcc-5.5.0-nolibc
> gcc-6.4.0-nolibc
> gcc-6.5.0-nolibc
> gcc-7.5.0-nolibc
> gcc-8.1.0-nolibc
> gcc-9.2.0-nolibc
> gcc-9.3.0-nolibc
> gcc-10.2.0-nolibc
> gcc-10.3.0-nolibc
> gcc-11.1.0-nolibc
> gcc-11.2.0-nolibc
> gcc-11.3.0-nolibc
> gcc-12.1.0-nolibc
> 
> 
> 
> 
> One example code change is like follows:
> 
> 
> 
> --- make.cross.old      2022-09-01 12:18:20.933154233 +0900
> +++ make.cross  2022-09-01 15:06:48.995945712 +0900
> @@ -143,7 +143,7 @@
>         local URL='https://download.01.org/0day-ci/cross-package'
>         local list=/tmp/0day-ci-crosstool-files
> 
> -       lftp -c "open $URL && find -d 3 > $list" || return
> +       lftp -c "open $URL && find -d 3" | sort -V > $list || return
> 
>         local file
>         local gcc_arch_pattern=$(echo "${gcc_arch}" | sed 's/*/.*/g')
> @@ -206,7 +206,7 @@
>         }
> 
>         # use highest available version
> -       gcc_exec=${gcc_exec[-1]}
> +       gcc_evec=$(tr ' ' '\n' <<< ${gcc_exec[@]} | sort -V | tail -n1)
>  }
> 
>  update_path_env_for_parisc()
> @@ -340,7 +340,7 @@
> 
>                 # load build-in depends libs
>                 local
> deplibs_path=($COMPILER_INSTALL_PATH/${COMPILER}*/${gcc_arch}/libexec/gcc/${gcc_arch}/*)
> -               deplibs_path=${deplibs_path[-1]}
> +               deplibs_path=$(tr ' ' '\n' <<< ${deplibs_path[@]} |
> sort -V | tail -n1)
>                 [[ -d $deplibs_path ]] && export
> LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$deplibs_path
> 
>                 install_dependence "$gcc_exec" || return
> 
> 
> 
> -- 
> Best Regards
> Masahiro Yamada
> _______________________________________________
> LKP mailing list -- lkp@lists.01.org
> To unsubscribe send an email to lkp-leave@lists.01.org
