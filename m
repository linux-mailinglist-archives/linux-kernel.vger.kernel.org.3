Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A01F75710AC
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 05:10:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230293AbiGLDKh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 23:10:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbiGLDKe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 23:10:34 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E9F22B619
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 20:10:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657595433; x=1689131433;
  h=message-id:date:subject:references:to:cc:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=5bC3fXAc4C4F9/nuPqvP4HOt/oWX6CsZKUhD72N1KHE=;
  b=YmwfZKlgPYD+1W9G8bW3b75RDQDovf/XZggxuULdgT1HxJAhdlYwtDYF
   gnLUu7jICAkpvJ6lWutWv2ddlyzOQDj06/px1r9dtqWGjJG8dYO/mzmKq
   xhnn1AggleRcOqb1lfJtRdU6ZojTuBh1eprwsiJOrFA1HBzzi6kqOFqA3
   gufzrTYtPlsCLzz9+lg1bugEERmTyb6bEy9vCF5iemErT/o/gzn7vmFyc
   VNH5SnVHI2tCFUY1wMgOlGTKxk0AwynMk3ZU9ek6OjUeuyfasEgdKvIHy
   bDPcr74rHUPJfT+To3wUAs3bZtv7y0q1yeW3DGXvuwl+/BlJBiNyyGJNv
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10405"; a="310437900"
X-IronPort-AV: E=Sophos;i="5.92,264,1650956400"; 
   d="scan'208";a="310437900"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2022 20:10:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,264,1650956400"; 
   d="scan'208";a="595131288"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga002.jf.intel.com with ESMTP; 11 Jul 2022 20:10:32 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Mon, 11 Jul 2022 20:10:32 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Mon, 11 Jul 2022 20:10:31 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Mon, 11 Jul 2022 20:10:31 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.46) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Mon, 11 Jul 2022 20:10:31 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MKRKWsd4RLhOydjxnIFmkpAH1YU8cQxpVS4/mFoSOzPECsNqwErQM1aB/QY2l1S+PgXejV7qriwdioSmuD9h6Y9sQowa1nUUiK6+n/YA6NsRJ9BtYfbWxfhHW454b4Rc7Xgnf5XDjujqrCEgKMmnDnbZxEMZSvANoZRA5QrjzmZc0py36+a9e9phNZyDtR9S5VdHXLgtCVHCpwaR4P2BU9OIYmKqT/I8594zK2tu9Na/EGMbZMX/BHL3rgYNV9YXM+rF8KG3DIWOJqRxoGThhaudqzwhzKMG3driiAeuNq+cyggsvnRXbh8JK5SowV0+SG/TNT8ZihBxtoZmIHfbbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CeoH+fyDn4jJ+KldRj96+v31dFqDQGuzo1RJNoY2yMc=;
 b=kLt2hJTawBRiH3VtgIoxRnC75JLUsISLZhw9uOKeg3Ad+HpiltbUA+m5n0jLFefzWWFKPsZpYPzU8N61r5vjfxVS6Lql4r7AEJV6NMneTWIrZgmQqKE1Xa+5Xqh2ynh+TscMqgtF/oi5bKa6ZfC876mfwyOUOHpKkaVFw0SWxgKj9QQ+fvB/8ldaacIjISWtrySRbt0GUqNq0LLK+pDLJ/DjpVt7TUKOHG8SjLd7sQabcIoMZ3HHqxORJz8PgImrCgdlRoKP9EskDe5YFWoQ780ZgRu1CJ0rI+TZ9OTFXe0YPIr66slkSJxMMAqoM1NtNKQs2Ygi0Uz/dZEhz8V9ig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MW4PR11MB5933.namprd11.prod.outlook.com (2603:10b6:303:16a::15)
 by CH2PR11MB4392.namprd11.prod.outlook.com (2603:10b6:610:3e::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.15; Tue, 12 Jul
 2022 03:10:29 +0000
Received: from MW4PR11MB5933.namprd11.prod.outlook.com
 ([fe80::71d0:716c:7d6d:94c4]) by MW4PR11MB5933.namprd11.prod.outlook.com
 ([fe80::71d0:716c:7d6d:94c4%3]) with mapi id 15.20.5417.026; Tue, 12 Jul 2022
 03:10:29 +0000
Message-ID: <c8073b8e-7b9e-0830-4177-87c12f16349c@intel.com>
Date:   Tue, 12 Jul 2022 11:10:20 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.11.0
Subject: lib/kunit/executor.c:80:10: warning: Potential leak of memory pointed
 to by 'copy' [clang-analyzer-unix.Malloc]
References: <202207120840.9F6TBqZD-lkp@intel.com>
Content-Language: en-US
To:     Daniel Latypov <dlatypov@google.com>
CC:     <llvm@lists.linux.dev>, <kbuild-all@lists.01.org>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Brendan Higgins <brendanhiggins@google.com>
From:   kernel test robot <yujie.liu@intel.com>
In-Reply-To: <202207120840.9F6TBqZD-lkp@intel.com>
X-Forwarded-Message-Id: <202207120840.9F6TBqZD-lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2P153CA0008.APCP153.PROD.OUTLOOK.COM (2603:1096::18) To
 MW4PR11MB5933.namprd11.prod.outlook.com (2603:10b6:303:16a::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d9897dd1-ed1a-4672-a727-08da63b412d8
X-MS-TrafficTypeDiagnostic: CH2PR11MB4392:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NDkaWHfxAw3r6uo46k5IkT5uSi24/gof64EZAe+wtRPx3GRZLJpYX/p7OLICyyCYqPSwOxMC19BfugUV6RqngH4gghh97ITEfQYJlFU+PhVXPYfQWOpcLMaDUzi1DMSIQzGfBd10F/fGJVn4HY0pTmLk6GFMM/UxT/fYFT0dDZeh5oJCGnyUJxEONi8m70PC5BHVWIRSgBs5pr1dvZQg2z4oOCUxuTIdSF2+tvZubXBsFd3B7dhmd/FKI/x5JWsjn+Xtaphl+p33CPX1dfkqucFQQXIRf6R7eWBEFSMhwhCVEjGScH1gfD//gVavri3v2xEPpw86JT0uHwyhkx0X1sTk47rfe6B4O4qbib4LZr+T/sSH7WClGMBwlesK2+PbynwvkxNHo7ydCdZkWJbBtHL/qQzWszKkev60N7nCL60n9SXRo3MnQ/2fUFrEhYmRt0AeWqpJCnZLJsIyWF2njSQEccmOFtX50jTRZYs2z4wRYKmhQob9iLWRM5wR/mgCOlI4+Iduqu+Un/LYDvQOReK+O5unZRulFAdt7flseyQiA1A0TLCJanLcOep9kK5AOrwbrhsTMtsTl0xLxqBvcK/KD06Y0OB55hGgWdz1idQXRPaUmwWBylfRqgSEHvMbCSkbPbG2SdXxaOffmeJzagOoY22na8FH1totINXl8OnO7AMWmUp+/N0dc3pVJhPzfGLRKWdG1qe9OjJPuUMlCx9pvnoLjzRpQ/Z2YARWa/1Z3MQNKT5s5k8LcKSPXt7Msvm15I2GumMtY96iIeQqK9N8JfkDuiX3AvL+JD4CtfCnTigzmKGEop/bZI0rop3ohYu0R6aUKLrxghVaj/KSUNvFA4cfrVz2s4nwWXCSs4y18ZfPun9pXZnzsG9nxiKpaONXVCzEuMRQBUJ4513K4I3+w5y0d7fkTn/2YK0bJ08=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR11MB5933.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(136003)(39860400002)(366004)(346002)(396003)(376002)(26005)(6512007)(186003)(6506007)(66556008)(66476007)(82960400001)(2616005)(38100700002)(2906002)(86362001)(31696002)(8676002)(966005)(66946007)(83380400001)(6486002)(478600001)(6666004)(31686004)(5660300002)(8936002)(6916009)(4326008)(36756003)(41300700001)(54906003)(316002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VVVTV1VZL09qMDN3MEdRdlJTOVVUTjREbU9LcXRjWFlJZTM3UWh5WUgyOHR2?=
 =?utf-8?B?a0t0dXZYY3lXR0g0cXFOTFI4c0dhM1lZQmc5VXdqb0QyMU1CSmlMM21MQms2?=
 =?utf-8?B?RVVDb2todm9UVExPZm56ZjZzYzhiVlcwSWlIN2FmRTYyakZCVFp3R0doUVRq?=
 =?utf-8?B?eUlIU3M1MUl4VDVoWnJaS1ZZTE0yWWltaHNSSnd5RjR4elRsMDZ6YWQra2Fm?=
 =?utf-8?B?M0svVm9kdGJOZEhzVTd5bVduZFZFN08ydkY3VmNWRm5YYkdrQ3NSRjZyQVFt?=
 =?utf-8?B?bXllZlZUc05CaEg5eTdYYzNDaUhOYldFaUhYRzVXbm1pUGJlVDE2dTVxOFNX?=
 =?utf-8?B?SDNEeUNIR3ozOE14bHpDOGg1UXhBZlg3dk82bmQrSjBYWjU3ZlhvVG9aV2tW?=
 =?utf-8?B?R3FzcDZjYnMrdW9lYVlmRnFyZVd1UHJKb2d5RXZUZlpqZGszRnpwY2RZeEVh?=
 =?utf-8?B?SFdLTUovR242OHNKbGNKR2R1eFdGM2J2Yzc4RHV1UlZERjZITVB1N3ZMM2px?=
 =?utf-8?B?SUpRYnlERWVScHM1K1lsYmEwS0JYeGkwT1RGY1ZhUTJTWnJnNklpdHZoUFpD?=
 =?utf-8?B?TEJLeGVPbkpEZ0piUWdYWVJPaXBBRC8xeVlkWHRWTmV5QlJvODdlSG4xNjBi?=
 =?utf-8?B?Tm1Sakg2N2wxN0ora2hmZVM2SU1vNklNMFN2ZjcyUTFTSFdqMjZ2c3BRdS9o?=
 =?utf-8?B?aCtLckZhQmRJcDI2ZzV1ajFzcU9KQU95Kzh6T291dWh5eEIrcEJPQ1BEbWM1?=
 =?utf-8?B?ZEE4emxGL1NNZkszVkJnaEVTcWNjcys2ZCtTc1hiRVhoS1Nuak8xMTlnY2Zh?=
 =?utf-8?B?L2g5UjhkZnU2YVZhU09KVmt3cmVFL3FHRkkxandrcW5iWnJJUGVlMGlHeVNu?=
 =?utf-8?B?UFgxWEpYSlQ2a2FZMjczR0l1RTg2SlQrSjJiYmcrM3FTS3p0WFZEZStHVVFo?=
 =?utf-8?B?bUNVdWJnRk5xTGhGdWsvRnFPeTVvR2ZqRzVlTFZhQ3BnalJ5WUpFU2FrSEdC?=
 =?utf-8?B?dUVCUWEwZDN1Z213RlhlVTM1emJ1RDJEaXZ0MVFnQ0ptUExxSlczOFFMekJ4?=
 =?utf-8?B?TUFCcFY1NjhnTWd6L2JIaWpZVUV1Z3lzM3hHNkNlTElWSzhMT1VyYkNvcVZ3?=
 =?utf-8?B?STBDeWNCOGp3UmFuRzAxQ2hzeWxCOFhTUmx3cXVxZTJka2JCS1pHaFJGeGR4?=
 =?utf-8?B?U0o0aE15eFVhU1o3WkZodlBuRFUrT1RsYTFqcTRXSlJwT0Q1c3hONnNGdGlw?=
 =?utf-8?B?R2J0SnR1MU9PU2txelF6N2VBRStlaXpOMC9oSlkxQlZJMGgyVGJHclZxYVJF?=
 =?utf-8?B?N2RHYlNZM3pYOWErZC9WRG4zdGp4MzNDY1dlcjZaQjFuTWJqR0ZKMm9wS1NB?=
 =?utf-8?B?Z04xU1hoWjBDM2t6eHAreGZNMWs4Q2FHUEUzdzBsT2twd3VSa3lqdnlUdUN1?=
 =?utf-8?B?eHp1QTVHZmZ1bWlrY00wbnUzNlpIMitBY1gvRnBUMG42WFN0ci8vT2hIVHBr?=
 =?utf-8?B?YWxKd1g3UlZGTkwzUS80N09teUNMUnZ2WU9yUFI4Y2VtZXc4VmRMd3o2a2pF?=
 =?utf-8?B?eGFwQUdKRjZSWEI1cXBka2hjVFJmS21KMzlPaEpxV0JGTFpkckVERCs0Vkhu?=
 =?utf-8?B?V2MrVmFzbVJvelI0ZVJhYUtlZGtHYUh0MXhSd2xCT2ZmRUxwamxIMFUybjRY?=
 =?utf-8?B?dzVjOGR6TFhva1d5aHYxM3Q3Ynp0WTVsdHB1czNMVlUwMmU3bGp5N3RKT0Y5?=
 =?utf-8?B?cVd0anVIc0ZzVjJlY2ZDQzFYVFhhYzJSMHlIRjEzTkllNExndVU2QUpDTlZF?=
 =?utf-8?B?UkZUYk93eWI3NU1YcUhyNDFqeTNrK2JzSVVVVHE0M0VvRVo0ano3MUJNS3Fk?=
 =?utf-8?B?bnEzVjh4R2JDcHVPUEVFU0FVZEdyMDJWVnN6SzJLM0kyN3V1Y20rSEdUWG5T?=
 =?utf-8?B?QlIraXFEZFJDSmcweklOUEMrNDZTV0FXelY4U1Q2dXM0eG5lMWI4VldkZ04x?=
 =?utf-8?B?RFBMbStQdTVzOVhTRk5UbTFyY0lXMXUwTjkvMmlZRERWdHpicUpPemFiTS81?=
 =?utf-8?B?T0h1L0pIazUrMUkyUlFqYSs2eGs2ZDJpREhBRmgzLzhYVUtyY3BtL1dWNXUy?=
 =?utf-8?Q?WBMD3z6T546k74c8nBxyG4Oe0?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d9897dd1-ed1a-4672-a727-08da63b412d8
X-MS-Exchange-CrossTenant-AuthSource: MW4PR11MB5933.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2022 03:10:29.5765
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AYlQARUVQyWFRMKsGTyw3rQIWfIiT+knA0QG9xWgsSflyHICJUWUO9CrfwexMfKxqthMBCjfYsQe4+dDM87kDA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR11MB4392
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   5a29232d870d9e63fe5ff30b081be6ea7cc2465d
commit: a02353f491622e49c7ddedc6a6dc4f1d6ed2150a kunit: bail out of test filtering logic quicker if OOM
date:   9 weeks ago
config: riscv-randconfig-c006-20220707 (https://download.01.org/0day-ci/archive/20220712/202207120840.9F6TBqZD-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 77a38f6839980bfac61babb40d83772c51427011)
reproduce (this is a W=1 build):
         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
         chmod +x ~/bin/make.cross
         # install riscv cross compiling tool for clang build
         # apt-get install binutils-riscv-linux-gnu
         # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=a02353f491622e49c7ddedc6a6dc4f1d6ed2150a
         git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
         git fetch --no-tags linus master
         git checkout a02353f491622e49c7ddedc6a6dc4f1d6ed2150a
         # save the config file
         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross ARCH=riscv clang-analyzer

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <yujie.liu@intel.com>


clang-analyzer warnings: (new ones prefixed by >>)

 >> lib/kunit/executor.c:80:10: warning: Potential leak of memory pointed to by 'copy' [clang-analyzer-unix.Malloc]
                    return ERR_PTR(-ENOMEM);
                           ^

vim +/copy +80 lib/kunit/executor.c

a127b154a8f231 Daniel Latypov 2021-09-14  55
a127b154a8f231 Daniel Latypov 2021-09-14  56  /* Create a copy of suite with only tests that match test_glob. */
a127b154a8f231 Daniel Latypov 2021-09-14  57  static struct kunit_suite *
a127b154a8f231 Daniel Latypov 2021-09-14  58  kunit_filter_tests(struct kunit_suite *const suite, const char *test_glob)
a127b154a8f231 Daniel Latypov 2021-09-14  59  {
a127b154a8f231 Daniel Latypov 2021-09-14  60  	int n = 0;
a127b154a8f231 Daniel Latypov 2021-09-14  61  	struct kunit_case *filtered, *test_case;
a127b154a8f231 Daniel Latypov 2021-09-14  62  	struct kunit_suite *copy;
a127b154a8f231 Daniel Latypov 2021-09-14  63
a127b154a8f231 Daniel Latypov 2021-09-14  64  	kunit_suite_for_each_test_case(suite, test_case) {
a127b154a8f231 Daniel Latypov 2021-09-14  65  		if (!test_glob || glob_match(test_glob, test_case->name))
a127b154a8f231 Daniel Latypov 2021-09-14  66  			++n;
a127b154a8f231 Daniel Latypov 2021-09-14  67  	}
a127b154a8f231 Daniel Latypov 2021-09-14  68
a127b154a8f231 Daniel Latypov 2021-09-14  69  	if (n == 0)
a127b154a8f231 Daniel Latypov 2021-09-14  70  		return NULL;
a127b154a8f231 Daniel Latypov 2021-09-14  71
a127b154a8f231 Daniel Latypov 2021-09-14  72  	/* Use memcpy to workaround copy->name being const. */
a127b154a8f231 Daniel Latypov 2021-09-14  73  	copy = kmalloc(sizeof(*copy), GFP_KERNEL);
a02353f491622e Daniel Latypov 2022-05-11  74  	if (!copy)
a02353f491622e Daniel Latypov 2022-05-11  75  		return ERR_PTR(-ENOMEM);
a127b154a8f231 Daniel Latypov 2021-09-14  76  	memcpy(copy, suite, sizeof(*copy));
a127b154a8f231 Daniel Latypov 2021-09-14  77
a127b154a8f231 Daniel Latypov 2021-09-14  78  	filtered = kcalloc(n + 1, sizeof(*filtered), GFP_KERNEL);
a02353f491622e Daniel Latypov 2022-05-11  79  	if (!filtered)
a02353f491622e Daniel Latypov 2022-05-11 @80  		return ERR_PTR(-ENOMEM);
a127b154a8f231 Daniel Latypov 2021-09-14  81
a127b154a8f231 Daniel Latypov 2021-09-14  82  	n = 0;
a127b154a8f231 Daniel Latypov 2021-09-14  83  	kunit_suite_for_each_test_case(suite, test_case) {
a127b154a8f231 Daniel Latypov 2021-09-14  84  		if (!test_glob || glob_match(test_glob, test_case->name))
a127b154a8f231 Daniel Latypov 2021-09-14  85  			filtered[n++] = *test_case;
a127b154a8f231 Daniel Latypov 2021-09-14  86  	}
a127b154a8f231 Daniel Latypov 2021-09-14  87
a127b154a8f231 Daniel Latypov 2021-09-14  88  	copy->test_cases = filtered;
a127b154a8f231 Daniel Latypov 2021-09-14  89  	return copy;
a127b154a8f231 Daniel Latypov 2021-09-14  90  }
5d31f71efcb6bc Daniel Latypov 2021-02-05  91

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
