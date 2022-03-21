Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40AC84E2342
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 10:25:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345845AbiCUJ01 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 05:26:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345781AbiCUJ0W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 05:26:22 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69B044DF70
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 02:24:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647854697; x=1679390697;
  h=message-id:date:subject:references:to:cc:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=1ZNZ/wAx6hIbsFWX4YpOQjODzHTXpRqdfrhqT8cuRs4=;
  b=GCs/08+pjlNjbSbRHI11ok4v4D4SkCYlqLXT2GOPRvJ3qG+PPX3f9BYF
   SHMt4pR4L0nV3bYOweeWV3Er5exCGfysXie3dR/cHvwkQmE8xZ1fzuv3D
   5ovg2UIP2ot0oAxeJbp19K+CaEbcfWqvCpCFkLofNkLP81v7PBLXad2jP
   NLbu63ZlDnRw8tiAoImzMFpDfqRLVI8GQ0OIXqMqyai4Ya+bqWUf8A1qM
   nUtR5EgZ4Otnqo+zjgG1+DLcpcmFOlVWbqLpwI8f7/U228BMLLQJgkejC
   JvrN+pnXWaMTC96bnjwQgsLc4yUtu+aWb4thV7J8POvWZnhCW6vFvC9yv
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10292"; a="282333640"
X-IronPort-AV: E=Sophos;i="5.90,198,1643702400"; 
   d="scan'208";a="282333640"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2022 02:24:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,198,1643702400"; 
   d="scan'208";a="824304486"
Received: from orsmsx605.amr.corp.intel.com ([10.22.229.18])
  by fmsmga005.fm.intel.com with ESMTP; 21 Mar 2022 02:24:57 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX605.amr.corp.intel.com (10.22.229.18) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Mon, 21 Mar 2022 02:24:56 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Mon, 21 Mar 2022 02:24:56 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.173)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.21; Mon, 21 Mar 2022 02:24:56 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fDr2EU7whfybJtZYif36rR4aQekw/2+ZSRRQP6f7LASMuyXjwxUyG1+s0LdnmpsHpitun5FSO6/aUZO1suaxUjO4rVk07kzL4KaffvQllQ70qRI/jxcILLzkPyGc6/WVkD5ibw6RKLA7B6ALs7ruMyvJ709/Z0NCLOmoT/MvavG3xN+NdwZEQ9l6KNpnvavKRzwRqOrKAMlbCJTQmlMdY0yymcBogirSYKd24KEZjvadwwURa2HB9kcrcoAtcpKxjJrEnA/tvDdv1vNkon/mRzSS91ZA5sj9dBTaaW1zT9CEhVui9z69O9pACjrdU5ITaNFRakxuDZRI9u+G6YEylg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CbBx/yHXw3q3CQw1vsDlQ7Pz6WrJI22PYduFdKNWmIw=;
 b=D8aDYIGLoB5I2pXovDBPPhzEtZ2BK+eczPAcJhc4qDEttRl7TKw+3fLref0vIisa+Pn9DF78id38c02wq1bzqOBJB7cy8d0UpCqi2dP6l4jTzDmjZZcc+b2dXe9J5LwuPBkzEhnS1dc6ntXEUt7Tc7pDla2SfRSNGOXsIUuOvf+yhaNpQ0dGqpExHLjrGEy0JhUplh6UXlQBkWnqJ41IAgE7kSkgtvI+nQPjrwbME2Duj85xuatDTdP/uabdFsvhtU9jBy/Ho9CL9mLJuray2XSwtxYPgixaCeJViIu/zaLoGlElaKhTD+TZr+E4KXUhQCWfsFDlYCrehlqWxTypug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ0PR11MB5598.namprd11.prod.outlook.com (2603:10b6:a03:304::12)
 by MN2PR11MB4464.namprd11.prod.outlook.com (2603:10b6:208:188::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.15; Mon, 21 Mar
 2022 09:24:53 +0000
Received: from SJ0PR11MB5598.namprd11.prod.outlook.com
 ([fe80::90bc:9408:541e:5b94]) by SJ0PR11MB5598.namprd11.prod.outlook.com
 ([fe80::90bc:9408:541e:5b94%8]) with mapi id 15.20.5081.022; Mon, 21 Mar 2022
 09:24:53 +0000
Message-ID: <af19bca5-7ae6-afb7-6f2e-57c67fb6d9b4@intel.com>
Date:   Mon, 21 Mar 2022 17:24:44 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.7.0
Subject: [amir73il:fsnotify-volatile 8/9]
 fs/notify/fanotify/fanotify_user.c:1202:2: warning: Value stored to 'ret' is
 never read [clang-analyzer-deadcode.DeadStores]
References: <202203211233.Vk5Tdqt8-lkp@intel.com>
Content-Language: en-US
To:     Amir Goldstein <amir73il@gmail.com>
CC:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        <llvm@lists.linux.dev>, <kbuild-all@lists.01.org>
From:   kernel test robot <yujie.liu@intel.com>
In-Reply-To: <202203211233.Vk5Tdqt8-lkp@intel.com>
X-Forwarded-Message-Id: <202203211233.Vk5Tdqt8-lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: HK2PR0401CA0017.apcprd04.prod.outlook.com
 (2603:1096:202:2::27) To SJ0PR11MB5598.namprd11.prod.outlook.com
 (2603:10b6:a03:304::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8ecaa3c6-c740-459d-486d-08da0b1ca829
X-MS-TrafficTypeDiagnostic: MN2PR11MB4464:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-Microsoft-Antispam-PRVS: <MN2PR11MB4464BBB38405950CE2E86A0EFB169@MN2PR11MB4464.namprd11.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aV+VKV9SlMZ+XgOcW8gAoTn3jnw5hMBoCYHmUh7X6rc6tt//RMQ3OowMvTembXVX4yWWU01Eu76bdjqtCkjZng/baiNiAecfc3bl5gHTU/VilvpjO5JaRVizQk80eBE+82tyVUme85UPaz2vzafyDSAF/9xGCGYSei+bv4GRjZukIvSY+SmX4hA3HJQ4TtszoO1h9VCZkZ5uLC974KSAcXhRyyMPxc9ahHUkr6O3zMyq2HKpOQ5NMLQhjE9rDJ5BjGd0rDNw2ctPzvyksozxC+7YN6MR4PUieki3qVfvnT0NGiuGGD7OwEedHUXqKyFWoMEELqVM129HXWTwOkRLDi7wrUi2mAzwl8WA483FByHV9kJNh1Af+ch/x7picHvlV8pAKibAD7dnWl52sqLMU6vSL0K6AApL0sXc6Dqj7xyvfU332cHG4EdpeFcSq4tXsMlSBDN7oZsTpYY+KrMjG678Y5M6mc1Zf6RBDC376mNXHbATIlyVrs9B57P2PouhXvUUE6MfTwrVTpGRuz7h54qc1ytKfcDGFCsoSYQFm9cFao/KgoKyvr+pijqwQ4Vipg0LlIg0S0AG33TOHy9PoCNCR4WrLB/48dLlW5r2EMOxOgt8tCg2fcnlyjV/gVDTMceyz9tAg8ZQMtAhDKj+DVsm3X8rqd0TnHd/GV5PGwpx97D0TEVi30s4BAZxzbZJWu09H0tgJKSrV4x65tWSMzT/fA6qRGPhvPQbwcAG17yghCkKCH6aelsxfyeoxZx9rBfkg0OJMS0sHpwmUICVjBFXGm7wEWiO+GRtA7e3Gx571Wgq2FM3GKOVRibUTcbk9uQXdbEmSEUH3LiAgRWGjJCt+nAlL+e7mpu/sSJy6Wo=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB5598.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(66476007)(66556008)(66946007)(2906002)(8676002)(4326008)(82960400001)(4001150100001)(38100700002)(36756003)(83380400001)(31686004)(6666004)(6512007)(508600001)(6506007)(6486002)(966005)(186003)(26005)(6916009)(5660300002)(316002)(86362001)(31696002)(2616005)(8936002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Q0RBK3R5di9tL3lYM0YveEQrVzJZWmY5RDVxUk9xdVhLNnlNUEpVSWZKUTVk?=
 =?utf-8?B?eGFENXMvdHpJdmFLL28wV3dlemRCN09qNHZsVFMvejdKVVdPZER5U2trMVlS?=
 =?utf-8?B?bDdqdXp5cFA5d3JGZVlwTVF4SnFXcGN4MkhYSlgwM1hCOVNMOWxUK2ZUOUVz?=
 =?utf-8?B?M0taZk1TNTdiWnhyRjNXYW8vdE5Od25Qc1g1b3J6bUVMMFhQVlBrdllnanh0?=
 =?utf-8?B?TWFXb3JJUkJ0RlhJOWw0QVBJWU92bXV5eW1jYmFHMzI5YUNkTmFkY3RTNy9m?=
 =?utf-8?B?aXR3QXdWU3VFUURCczlvSGFNSlR0TSt4eHI2VG5ycDI4Y3JncThEaXBVZUZ4?=
 =?utf-8?B?SnFLclQ4VTU5bnhRaGZsN1NudXRkL3JZVWc0cmozMVpZZ1pCZzZYWi9pMkNO?=
 =?utf-8?B?VHo5WDRTbVFiRlRQa2ExYnBISCtvY0MrMXAzZVNWRExiWThveDFOV3VmMWZN?=
 =?utf-8?B?akd6ekJ6Y2RFZ2huS1dteU1hdDdid2hqamZUdDJxNmdVdnIzZDNRbzd6bW1O?=
 =?utf-8?B?WXNkb2ZCSWF5b0lxV2JzaXpscHdoSmtkMkJLd3NBNTVHVmlDTEpLV1p5ODYr?=
 =?utf-8?B?V3FvZ05iVExROFhodFZBeGpUNEdnRW1lclFLeS96NHE1d3VYay9JbUxLTEtJ?=
 =?utf-8?B?NUhLWGYvb1Zya0h4MEpJTjV5Nzl2eFJ0VFRYSmlUN25ORSsxNjdZOC9KL2FX?=
 =?utf-8?B?dTZpVnllVGd6NGtxclJPSldmQWVzZkN3TlJ6RitPL2hzZXdTRUVGWHRUaXJj?=
 =?utf-8?B?Y3ZMU1d6WXhnOUpGVExsWVZOTGpHbXRscG0yWWtmcmVtZ3htUjVadzZqSDBN?=
 =?utf-8?B?L3h5SGRGcVAwR05MY0ZzMTd2azlyVE9PbzJSeUJLbVpWTDM5dzRQbFJRZUx3?=
 =?utf-8?B?VFJsUDBqM2oyM0tweDFLQ3krTkZoWE9NVStSbGFRSHpvWXF6eGlFTmlYR3BG?=
 =?utf-8?B?TkZoZUZuTHlST1paaEFsOG1sdjdCbnNqZGJJVnV6eUFDQU9ETkpqOThhVW4z?=
 =?utf-8?B?Q3AyU21jSzMzYnNCYzVUUlZKU01qc2tROXNrUHF6UTRJMlpxWTcxSGp2TWE3?=
 =?utf-8?B?bmdkY1B5Yzc2V2J3STlwTWg0cXcvUFE4QWloempPSWgxN3FhdGNBSkxwc0xR?=
 =?utf-8?B?NDBrelhTWUlocWRNanNWT2pHeHRiQjhISEFYTVN1Y1B0MDJMdkZCWXZZakdW?=
 =?utf-8?B?cWVLOTd6WXdiWWVZMVB1N0Y5b3ZvWWJFamQ3NG9FaVZrMm81ODQrUkh1ei9Z?=
 =?utf-8?B?WEZkRytJaHRjelByWWdPa0o4UEh5STZKNUJpVzhTUHAyaWZIMUFCMmRqRGJv?=
 =?utf-8?B?RmdDa3l4blVJOUFrNXd5Wm8ydmNVcFJ0SFhvWUhKQzgrTUZmaWpzMytXbVRh?=
 =?utf-8?B?Vjljc2t5MGRXNytDQk0vR1VIWXVLVDNqdnlNUmQ2U1F4ZDg4QTlRQitiZkx2?=
 =?utf-8?B?ZTVzU3k5TE1uV2dHbU9aUEhBQ0h6K2QvUXJEODgwYjBJalN4UHEzVzY5WTNh?=
 =?utf-8?B?TXBXdXkrRmVJMGlQVS9IRVB3ejNERitreTI3WjF1OGNYU3Q5QjFTVjZEOURJ?=
 =?utf-8?B?YXBnWmN3STMrbFJQbXp4bVIrNUxKYTRubjhyNVZjTGh1OTBFSWRJRGhNbHpj?=
 =?utf-8?B?ZDdKZTdFS0FHOHo0RFBqZzMrQTRDbmdQUll2cHo0b0VTU0NaaTJPZVVvckYz?=
 =?utf-8?B?UnI5UkU4L2MrVVowMHM2cnhOV25sUkNRWFZBaGtuNmVKeHRYeEQwdU55c2J6?=
 =?utf-8?B?bEVZTGp0UlA0b1JxMmdUeWFJY3Fyam05cCtNZHVSdmE0bjZIWXE1c0ljQjNV?=
 =?utf-8?B?d3FSNVlHVEJvWHJ1REtiKzlVanJJNW1SVHRhNUQ5Mk90QitqbXg3UU9VN0xr?=
 =?utf-8?B?WXpGUk16cnFleUFYeVVORUVZVVlESWQ0UXF1RlBhQ2MrTFJaclVFajAzbDFO?=
 =?utf-8?Q?kHhDcmazNprSyXdVLrU/ay36wXfPbnLN?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ecaa3c6-c740-459d-486d-08da0b1ca829
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB5598.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2022 09:24:53.7648
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GGoF+vhpP3etArhK06O9PQbYwUlmiVhua5qPB06jOFX0ILU3ENCNvH9oJNtuFgA7hIIgYmvfyrW9g5V4duA6xQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4464
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/amir73il/linux fsnotify-volatile
head:   20c431f640f13d125fa3d80fde9ae4a28892a029
commit: 068909e55d92d27d6c7e5688b4689235707613ba [8/9] fanotify: factor out helper fanotify_mark_update_flags()
config: x86_64-randconfig-c007 (https://download.01.org/0day-ci/archive/20220321/202203211233.Vk5Tdqt8-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 85e9b2687a13d1908aa86d1b89c5ce398a06cd39)
reproduce (this is a W=1 build):
         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
         chmod +x ~/bin/make.cross
         # https://github.com/amir73il/linux/commit/068909e55d92d27d6c7e5688b4689235707613ba
         git remote add amir73il https://github.com/amir73il/linux
         git fetch --no-tags amir73il fsnotify-volatile
         git checkout 068909e55d92d27d6c7e5688b4689235707613ba
         # save the config file to linux build tree
         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross ARCH=x86_64 clang-analyzer

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <yujie.liu@intel.com>


clang-analyzer warnings: (new ones prefixed by >>)

 >> fs/notify/fanotify/fanotify_user.c:1202:2: warning: Value stored to 'ret' is never read [clang-analyzer-deadcode.DeadStores]
            ret = 0;
            ^     ~

vim +/ret +1202 fs/notify/fanotify/fanotify_user.c

5e9c070ca08543 Lino Sanfilippo         2013-07-08  1178
eaa2c6b0c9181c Amir Goldstein          2018-06-23  1179  static int fanotify_add_mark(struct fsnotify_group *group,
ad69cd9972e79a Amir Goldstein          2021-11-29  1180  			     fsnotify_connp_t *connp, unsigned int obj_type,
77115225acc67d Amir Goldstein          2019-01-10  1181  			     __u32 mask, unsigned int flags,
77115225acc67d Amir Goldstein          2019-01-10  1182  			     __kernel_fsid_t *fsid)
2a3edf86040a7e Eric Paris              2009-12-17  1183  {
40822e8f3f162d Amir Goldstein          2022-03-20  1184  	struct fsnotify_mark *fsn_mark = NULL;
40822e8f3f162d Amir Goldstein          2022-03-20  1185  	void *prealloc_conn = NULL, *prealloc_mark = NULL;
40822e8f3f162d Amir Goldstein          2022-03-20  1186  	int ret = -ENOMEM;
40822e8f3f162d Amir Goldstein          2022-03-20  1187
40822e8f3f162d Amir Goldstein          2022-03-20  1188  	fsn_mark = fsnotify_find_mark(connp, group);
40822e8f3f162d Amir Goldstein          2022-03-20  1189  	/* Preallocate new mark and connector outside of group lock */
40822e8f3f162d Amir Goldstein          2022-03-20  1190  	if (!fsn_mark) {
40822e8f3f162d Amir Goldstein          2022-03-20  1191  		prealloc_conn = fsnotify_conn_alloc(GFP_KERNEL);
40822e8f3f162d Amir Goldstein          2022-03-20  1192  		if (!prealloc_conn)
40822e8f3f162d Amir Goldstein          2022-03-20  1193  			goto out;
40822e8f3f162d Amir Goldstein          2022-03-20  1194
40822e8f3f162d Amir Goldstein          2022-03-20  1195  		prealloc_mark = kmem_cache_alloc(fanotify_mark_cache,
40822e8f3f162d Amir Goldstein          2022-03-20  1196  						 GFP_KERNEL);
40822e8f3f162d Amir Goldstein          2022-03-20  1197  		if (!prealloc_mark)
40822e8f3f162d Amir Goldstein          2022-03-20  1198  			goto out;
40822e8f3f162d Amir Goldstein          2022-03-20  1199  	}
88826276dcaf4c Eric Paris              2009-12-17  1200
7b18527c4a9539 Lino Sanfilippo         2013-07-08  1201  	mutex_lock(&group->mark_mutex);
40822e8f3f162d Amir Goldstein          2022-03-20 @1202  	ret = 0;
40822e8f3f162d Amir Goldstein          2022-03-20  1203  	/* Check again under lock - if found will not use preallocated mark */
40822e8f3f162d Amir Goldstein          2022-03-20  1204  	if (!fsn_mark)
b812a9f5896379 Amir Goldstein          2018-06-23  1205  		fsn_mark = fsnotify_find_mark(connp, group);
88826276dcaf4c Eric Paris              2009-12-17  1206  	if (!fsn_mark) {
40822e8f3f162d Amir Goldstein          2022-03-20  1207  		fsn_mark = fanotify_add_new_mark(group, connp, obj_type, fsid,
40822e8f3f162d Amir Goldstein          2022-03-20  1208  						 &prealloc_mark,
40822e8f3f162d Amir Goldstein          2022-03-20  1209  						 &prealloc_conn);
5e9c070ca08543 Lino Sanfilippo         2013-07-08  1210  		if (IS_ERR(fsn_mark)) {
40822e8f3f162d Amir Goldstein          2022-03-20  1211  			ret = PTR_ERR(fsn_mark);
40822e8f3f162d Amir Goldstein          2022-03-20  1212  			fsn_mark = NULL;
40822e8f3f162d Amir Goldstein          2022-03-20  1213  			goto out_unlock;
88826276dcaf4c Eric Paris              2009-12-17  1214  		}
7b18527c4a9539 Lino Sanfilippo         2013-07-08  1215  	}
734a1a5eccc5f7 Gabriel Krisman Bertazi 2021-10-25  1216
734a1a5eccc5f7 Gabriel Krisman Bertazi 2021-10-25  1217  	/*
734a1a5eccc5f7 Gabriel Krisman Bertazi 2021-10-25  1218  	 * Error events are pre-allocated per group, only if strictly
734a1a5eccc5f7 Gabriel Krisman Bertazi 2021-10-25  1219  	 * needed (i.e. FAN_FS_ERROR was requested).
734a1a5eccc5f7 Gabriel Krisman Bertazi 2021-10-25  1220  	 */
734a1a5eccc5f7 Gabriel Krisman Bertazi 2021-10-25  1221  	if (!(flags & FAN_MARK_IGNORED_MASK) && (mask & FAN_FS_ERROR)) {
734a1a5eccc5f7 Gabriel Krisman Bertazi 2021-10-25  1222  		ret = fanotify_group_init_error_pool(group);
734a1a5eccc5f7 Gabriel Krisman Bertazi 2021-10-25  1223  		if (ret)
40822e8f3f162d Amir Goldstein          2022-03-20  1224  			goto out_unlock;
734a1a5eccc5f7 Gabriel Krisman Bertazi 2021-10-25  1225  	}
734a1a5eccc5f7 Gabriel Krisman Bertazi 2021-10-25  1226
068909e55d92d2 Amir Goldstein          2022-03-20  1227  	ret = fanotify_mark_add_to_mask(fsn_mark, mask, flags);
734a1a5eccc5f7 Gabriel Krisman Bertazi 2021-10-25  1228
40822e8f3f162d Amir Goldstein          2022-03-20  1229  out_unlock:
c97476400d3b73 Jan Kara                2016-12-14  1230  	mutex_unlock(&group->mark_mutex);
5e9c070ca08543 Lino Sanfilippo         2013-07-08  1231
40822e8f3f162d Amir Goldstein          2022-03-20  1232  out:
40822e8f3f162d Amir Goldstein          2022-03-20  1233  	if (fsn_mark)
fa218ab98c31ee Lino Sanfilippo         2010-11-09  1234  		fsnotify_put_mark(fsn_mark);
40822e8f3f162d Amir Goldstein          2022-03-20  1235  	if (prealloc_mark)
40822e8f3f162d Amir Goldstein          2022-03-20  1236  		kmem_cache_free(fanotify_mark_cache, prealloc_mark);
40822e8f3f162d Amir Goldstein          2022-03-20  1237  	if (prealloc_conn)
40822e8f3f162d Amir Goldstein          2022-03-20  1238  		fsnotify_conn_free(prealloc_conn);
40822e8f3f162d Amir Goldstein          2022-03-20  1239
734a1a5eccc5f7 Gabriel Krisman Bertazi 2021-10-25  1240  	return ret;
88826276dcaf4c Eric Paris              2009-12-17  1241  }
88826276dcaf4c Eric Paris              2009-12-17  1242

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
