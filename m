Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DD9B4D2729
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 05:06:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231602AbiCIDQ4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 22:16:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231589AbiCIDQy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 22:16:54 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E08FF986EC
        for <linux-kernel@vger.kernel.org>; Tue,  8 Mar 2022 19:15:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646795756; x=1678331756;
  h=message-id:date:subject:references:to:cc:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Xdb145QNbbTq2ecfdKLk5IOI55yBzuHa6YMq46fNAzg=;
  b=Oh8rDLDK1cflNyi/UcPPyODKDjb+0tPvaqweGZDQA7T3Bs7aLcgSJTao
   Eo1ZaEtZmfDcc81MqENkYd55yJAI0Y497ZBxLUTQaeKA6juJO69Sscz91
   PAykqzI6k65T3kTteAfyNGpyXeNI74hbOLqLM07+ZI2vEN/4N1NBGm06l
   l2JOZ3Oq1JFcQbbkyMivL5XNpeVaMwShmuacwnaEYu8LAvRQXmtyRl+zK
   FRnjsPq9EjK//Zsbi6jXMltctFtb2FYMEP3Q0YAIPZXutNnUOHoktWHUN
   wJSZU8JCGJEA0tjYR/K3Q4jDUsSuMnWbdeQDj9RMXFDS9iqQGofhytF3C
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10280"; a="279597072"
X-IronPort-AV: E=Sophos;i="5.90,166,1643702400"; 
   d="scan'208";a="279597072"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2022 19:15:56 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,166,1643702400"; 
   d="scan'208";a="711782938"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga005.jf.intel.com with ESMTP; 08 Mar 2022 19:15:55 -0800
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Tue, 8 Mar 2022 19:15:55 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21 via Frontend Transport; Tue, 8 Mar 2022 19:15:55 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.108)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.21; Tue, 8 Mar 2022 19:15:54 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c66ipB3Nq9kgLsDEfZc1jmlHlLW7rjVxDr/rGVP3R2ECbluVP9uJSz2bSz8vGIYgh47UDGTkx5GspiaN7URKDixj0ClPi9cF+TqWvnmxED9Jho4rOiTnM18WNB92bmMpBLNu59hcSr2MbqLB4c5XOn3KnMV/EqC8/Bfh05lbkt/BZc39VTbep7ElthI7zypozl5kw+REMBrZlO5tQ1gU2BlNnd5wnDXOG6tZnHQnS9pGhUdBGewOhj+to+MY5tFCWo+I2REFS8iG/7bswdcHB3nJJnUIzt69bhxHzjPwTnPWubpb9CAmhAkBVsl5H8C78fetLAaGJKWESXcAqgUsvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7OrjJuSXtZIUnJ5eBCHFujhNPdJm6zLqqZPEszQMgb8=;
 b=IsBwcM60kJMrEtwJ+7o/AXCymXS7dW8/gdTb7B8LWZcfgOabrC/luF+i0hkM9xd08yYxhk+C9gq9xR2hWwIuVyWd+kdyfZjUjhbGLat5KqQN8AShM0bMTD4sPaKvchxC61PPUkuGZfFw2mI3yXhda5j9UoY16hQVbv3L3iDICdDEqs/7s/5O6frxWB1rh3AnALb/ix5lecWMTqc7h0AOFqHPPUWZdDuwrqMQH2ciEtYDZoPd7DwzMVNJTqWbLtD+8lp2QWrWW8DMQFnhdRCjcUhcqpvimcKLvTZXC2zin/pbUGeW+Yn9StseKQ/GItdbC1yjz0QePETaeu5k5XhPoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ0PR11MB5598.namprd11.prod.outlook.com (2603:10b6:a03:304::12)
 by DS7PR11MB5968.namprd11.prod.outlook.com (2603:10b6:8:73::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5038.14; Wed, 9 Mar 2022 03:15:49 +0000
Received: from SJ0PR11MB5598.namprd11.prod.outlook.com
 ([fe80::c4a2:d11d:cb7b:dc8d]) by SJ0PR11MB5598.namprd11.prod.outlook.com
 ([fe80::c4a2:d11d:cb7b:dc8d%9]) with mapi id 15.20.5038.027; Wed, 9 Mar 2022
 03:15:49 +0000
Message-ID: <7c8143fa-3912-5c96-8592-9f94d186e0b0@intel.com>
Date:   Wed, 9 Mar 2022 11:15:43 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.6.2
Subject: drivers/net/ethernet/hisilicon/hns3/hns3_common/hclge_comm_rss.c:199:6:
 sparse: void extern [addressable] [toplevel] hclge_comm_get_rss_indir_tbl(
 ... )
References: <202203031716.K3CfFyZP-lkp@intel.com>
Content-Language: en-US
To:     Jie Wang <wangjie125@huawei.com>
CC:     <kbuild-all@lists.01.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
From:   kernel test robot <yujie.liu@intel.com>
In-Reply-To: <202203031716.K3CfFyZP-lkp@intel.com>
X-Forwarded-Message-Id: <202203031716.K3CfFyZP-lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: HKAPR04CA0012.apcprd04.prod.outlook.com
 (2603:1096:203:d0::22) To SJ0PR11MB5598.namprd11.prod.outlook.com
 (2603:10b6:a03:304::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1ff2e822-7b22-4ffb-18f9-08da017b1c27
X-MS-TrafficTypeDiagnostic: DS7PR11MB5968:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-Microsoft-Antispam-PRVS: <DS7PR11MB59686E6B628760A0900493A1FB0A9@DS7PR11MB5968.namprd11.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sqBqmMzevrbcq0rbklMHBfW5ATPBhasqoFFFUykZd036oljgADPI9Wv2vnuna88zV/7Cr2A7VnwNvgglL3GkosStCTR7pDKt0IdU0+ffyOFrx4PYJMJI2PaygiJzReRzzlDNIJRsJdfGO98zkVlW17ixWWrmMqzZYLLc6nzkPUtKES2bvOaxkI8tmH+20zecf97UpLv+rNgWGhfyoCxcXeu8MB6zz421wIWZCuPuK/x0MZKxHq2RdTp+00Sme3bEKd0TBoSF1Zqfqj+sf/rkQkWiWhGK/Adz+Jjcxm3C4usHyc5ZJ9LGoon4VvN/fUcd166JHzZjy9iSjnulX0vT3ZkBR5iWq2/IGtGH1mtaKdSvVz1xlyzWcYCwjbiaZY9Tqz/6TQBcqEadKzzpoel5Sl1USl7Nv4LgzKAR8v/GBLbdXXZpVvzAjCDVRLUgDRXjqFhu2RCfkbPpix7b6ly4Mn526PQNt+lD6dENbnkPpZjvbthNP4SxPkd/+iXYKsELk+dr3a6UdG+HyI9YHQTxtwNIr1DxoYhNisHBLbSV54Yr5XbS4iS9jnjLFQbjjvIDxurCggF1aFL89cH+pq9ISdpwSeHW3daxC6jPVd1nP3YCWAGi9q4Yd0pzPUUi3vn52x7wI2o4w9g9Q6JODcCl1gvxzGrdkANE5gisbJqIQYM8eHXtAfb9fCcpea/hDGc9BWOvOl4vYvQ7ewx0/nEFt9f4373HQytQecuXIn2n1/uIAvNAY/SUjLQQa2KV9f3sbZOTIIjhG2l2J+sPBed/lBqFAlcMzdjIagJ95/uMd+/5TfqqmkKjgqTSoRXZuc1Z0Yf6drkSIuf09lO9fkFpl84BAcVxlJqQLr48lY6zpxs=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB5598.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(186003)(38100700002)(86362001)(316002)(5660300002)(966005)(6486002)(31696002)(66946007)(66556008)(66476007)(8676002)(4326008)(6666004)(8936002)(26005)(2616005)(82960400001)(508600001)(6506007)(31686004)(36756003)(83380400001)(6916009)(6512007)(2906002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cUU4ekx5clhmRUVaMnVqYndmMXVLU1A4VUs0djQwRWt3R0g4ZzFndE43VlhL?=
 =?utf-8?B?eHhpNFR1REw3aDFnSjE5Mnh6N3ZKeFN3OHAvOE1ZcW00NWhyenlQVzEzR2pU?=
 =?utf-8?B?ZUIxSTBtL1hNZ25oYXppZit5bURvOWo4cUxPMmgxT2pXeEI1dy9XWGRLUFIw?=
 =?utf-8?B?NWg2Zzl2WTVjOHowUGF2ZVQ4cjBIZkNJajFPZXhyRDVmZ2dtK1U0SjNQL0Js?=
 =?utf-8?B?VFpOdU9PcnQ1a2VyU01OMkFYMkRUME1Lb3ZiQUZ5VTN0bGZXa21sOHM1TFQ3?=
 =?utf-8?B?YnRZZGlPbExqVmhJZ0JZSjJuMHhjQnhYQ0duQ2dMTDVYbmt1L0hONmNyd0pw?=
 =?utf-8?B?Rnl3Mlk0YWZTNk1Jd2l4OS9JVjdpRVZaVDhYUVQ0ZDlBYkExdWhZcDJZaG1h?=
 =?utf-8?B?VmNxcU9YYUE2UHF1QTVmLzhST0NnOEdJaXhNakY4enpMS0swUW1qSHg5dWNG?=
 =?utf-8?B?WW0xUEJNbDlsV2lIRnhwUUlvT3FaKzhlMHVGamRUMzFVMDVMdHRseFl2YklP?=
 =?utf-8?B?Y3dCQ1NJUWpwYVlvK3IwcUd6c0VxTDZiek53RWRqU040aEpuMVlkZEJWUjk3?=
 =?utf-8?B?WW53V29COEVBcndhcUxrRXRKYkdRMXhlU2hRaktkQ1RpQkhieXFwa0hXV3BZ?=
 =?utf-8?B?M2VlZ1AzeDcxcTdSRWlaeUYzTU5OWnBlQkMxUUFLczZCUS95K1pqVVpabGtw?=
 =?utf-8?B?L0ovbXR5bFZzeThORXh0MGZmVTh2VFpSbWZqb2Z1UldvcEIwMmgxVkIwMk9N?=
 =?utf-8?B?cUk0YkpEK250UWUvTStSU2x6QWJya0cvWHVIWFR6bDJiZmRXK0tEYVVCRkkr?=
 =?utf-8?B?STJWVHBlOFVzR1Y2d1hYWk5sb2JKOE5mVFVtUEpxVHI3LzgyLzFnM1lwQWZV?=
 =?utf-8?B?TllLZEtpYThYQVlXKzRSNWNNU3pFcUx5QituOEt5Wm9UTjVOZlJqVmFlMzFU?=
 =?utf-8?B?WGxhOVh2T2JWVmxVYUxoNUtpbjRLYU53aTFWRTUzQnJhc2tMc1lCSGErZ242?=
 =?utf-8?B?OFRRUzIvbzJMRENVa2NVY3ljQWsrK2ZTNTNuaThvSlU2a0cyRThIdExUUzlq?=
 =?utf-8?B?bHd6TklkU25wRTBSa0Y4bnRtaUN6TndhRVIvMzZqSkU5WjFDUGlaSm1LeGFK?=
 =?utf-8?B?ZE5WcWQ2Zk82T2pjMDhQNFNJWG42T1NGbytnbFJKUGt3WElyejVnNkh2SXhE?=
 =?utf-8?B?VU9Ic0V1VFpmcFdIcWZBTUhWYUN6aXlSbTZnNlpLOXpzRlE0dHlpTkNRRm9P?=
 =?utf-8?B?Z3NZSHRkV3NTRGwvMmYwc05Hb2wzclkyTHV3ZFB3OEx2S0xVNHpMUWRadTAy?=
 =?utf-8?B?dTVkb2Y0Wkcrc0w4bm5JNzR5RnJ1djFPLzJtT2wxRDBJcW1VbnNTOFB3Wkdz?=
 =?utf-8?B?ejVBOEZYditzYTFWUVZKejc2WVY4VXN6VDBkS1cwU20xRHkrdUJnSlRxZ2pX?=
 =?utf-8?B?VElMcDUwMW9JRzRBTVBST0tLeGExbFZ5YnlwUElHN3BmcVozQVhPRlZydUtv?=
 =?utf-8?B?NkxSNU9ZZ082R29qb2cyUEtQVVgybHlZQWtLaExVcHFVQzRjZHRuSHF4VjJm?=
 =?utf-8?B?OUxKT0dHWFBpeTdZKzM1WS9MVndudmI4SisrbVJUWk41cFN0cXEwMzE3NGxv?=
 =?utf-8?B?OGpldkdHZDJISHdTazJERWFQMVpPNTV6SW5sb2pzblAzQkhyMlBkZUVhbEdk?=
 =?utf-8?B?WXFySTUyRDRnU3VxclpSYnZUdW0vNzNyVHRSTmdCMFN0a1VwNUxxcE1MbnVU?=
 =?utf-8?B?dG1HVXBrY3V1dHFLMnU2VmFMUG1TVkJ5YzIzR09RTklNOVFxazhvWGN1NkQx?=
 =?utf-8?B?NHpGclFmOUdHT3A5WjMxclFaWTdPcytMMEpyazhyN0lhT2ZQdjRvdUhjR0F1?=
 =?utf-8?B?SGNqYllpV3A1OU5EdVBMODVLcG9MOTJ3dXF5V3VhWXk3T1FBOWdjeVhidndl?=
 =?utf-8?B?MkxJSFNuV1lYblQxNFVRcytEZkhTQjd2RXhVbHB2ZmM3aUl4dmx0NnAyYUFq?=
 =?utf-8?B?Q0FnRkFEeTdQaW1XRll1a3VGYzJHeVE5dVdDczNBdVpMNUNXUVZMcGR1R1RM?=
 =?utf-8?B?ZzBMcWZ5cFRuaDdEamFnYys3eUFsUGlab296cnFpL3QwQ3N5RFdCNTBGWDdL?=
 =?utf-8?B?cjFpWDhEV2Mya3J6elFzam1SdzV6Unc4elpzWE54WWlRWUxuS3VtRmFPc1dQ?=
 =?utf-8?Q?KXPopJD7MNmz4VlyWrs3d2o=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ff2e822-7b22-4ffb-18f9-08da017b1c27
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB5598.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2022 03:15:49.7212
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5179OO2OK4GfZVtibYg3PtJPUEAoKHIpCWDWZwIuZa7PAUKIB9RBTVXmQDXE3pRgp7IsNSYePE5uJdATvnoQYg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB5968
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   5859a2b1991101d6b978f3feb5325dad39421f29
commit: 6de06004286798ac4b4b10c8c74a6eb03c5035f2 net: hns3: create new set of common rss set APIs for PF and VF module
date:   8 weeks ago
config: ia64-randconfig-s031-20220303 (https://download.01.org/0day-ci/archive/20220303/202203031716.K3CfFyZP-lkp@intel.com/config)
compiler: ia64-linux-gcc (GCC) 11.2.0
reproduce:
         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
         chmod +x ~/bin/make.cross
         # apt-get install sparse
         # sparse version: v0.6.4-dirty
         # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=6de06004286798ac4b4b10c8c74a6eb03c5035f2
         git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
         git fetch --no-tags linus master
         git checkout 6de06004286798ac4b4b10c8c74a6eb03c5035f2
         # save the config file to linux build tree
         mkdir build_dir
         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=ia64 SHELL=/bin/bash drivers/net/ethernet/hisilicon/hns3/ drivers/net/wwan/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <yujie.liu@intel.com>


sparse warnings: (new ones prefixed by >>)
    drivers/net/ethernet/hisilicon/hns3/hns3_common/hclge_comm_rss.c:199:6: sparse: sparse: symbol 'hclge_comm_get_rss_indir_tbl' redeclared with different type (incompatible argument 3 (different base types)):
 >> drivers/net/ethernet/hisilicon/hns3/hns3_common/hclge_comm_rss.c:199:6: sparse:    void extern [addressable] [toplevel] hclge_comm_get_rss_indir_tbl( ... )
    drivers/net/ethernet/hisilicon/hns3/hns3_common/hclge_comm_rss.c: note: in included file:
    drivers/net/ethernet/hisilicon/hns3/hns3_common/hclge_comm_rss.h:94:6: sparse: note: previously declared as:
 >> drivers/net/ethernet/hisilicon/hns3/hns3_common/hclge_comm_rss.h:94:6: sparse:    void extern [addressable] [toplevel] hclge_comm_get_rss_indir_tbl( ... )

vim +199 drivers/net/ethernet/hisilicon/hns3/hns3_common/hclge_comm_rss.c

1bfd6682e9b5d4 Jie Wang 2022-01-05  198
1bfd6682e9b5d4 Jie Wang 2022-01-05 @199  void hclge_comm_get_rss_indir_tbl(struct hclge_comm_rss_cfg *rss_cfg,
1bfd6682e9b5d4 Jie Wang 2022-01-05  200  				  u32 *indir, u16 rss_ind_tbl_size)
1bfd6682e9b5d4 Jie Wang 2022-01-05  201  {
1bfd6682e9b5d4 Jie Wang 2022-01-05  202  	u16 i;
1bfd6682e9b5d4 Jie Wang 2022-01-05  203
1bfd6682e9b5d4 Jie Wang 2022-01-05  204  	if (!indir)
1bfd6682e9b5d4 Jie Wang 2022-01-05  205  		return;
1bfd6682e9b5d4 Jie Wang 2022-01-05  206
1bfd6682e9b5d4 Jie Wang 2022-01-05  207  	for (i = 0; i < rss_ind_tbl_size; i++)
1bfd6682e9b5d4 Jie Wang 2022-01-05  208  		indir[i] = rss_cfg->rss_indirection_tbl[i];
1bfd6682e9b5d4 Jie Wang 2022-01-05  209  }
1bfd6682e9b5d4 Jie Wang 2022-01-05  210


vim +108 drivers/net/ethernet/hisilicon/hns3/hns3_common/hclge_comm_rss.h

1bfd6682e9b5d (Jie Wang 2022-01-05 22:20:03 +0800 108) void hclge_comm_get_rss_indir_tbl(struct hclge_comm_rss_cfg *rss_cfg,
6de0600428679 (Jie Wang 2022-01-05 22:20:06 +0800 109)                            u32 *indir, __le16 rss_ind_tbl_size);

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
