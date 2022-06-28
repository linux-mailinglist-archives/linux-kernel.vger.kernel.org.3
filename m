Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4CBD55DACF
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:23:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243213AbiF1Bt1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 21:49:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240857AbiF1BtX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 21:49:23 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C117B12
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 18:49:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656380963; x=1687916963;
  h=message-id:date:subject:references:to:cc:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Gldzo3dePEKhPPvyfmDc8sjqn6I0RAfRG+Is22Hto6w=;
  b=aV3YNi7N2u2XO6NoVqTySTXx/rP3sqkDyRuJo9LnNzEzFq9SSotUYl8b
   BpIqligr5Vu9zKQeWiwR4YS6EzWO1UOBZqnTqHpv2aqL4uSGH8pMJZh9o
   1SvjDV7D76L00Q8TgI6z/zkfacG2LnF4wKIdU0I2KFMPyt4GTa2N5RhJd
   VAbN9Zj8+gkCNvkCpYcFUtNkPDNE3KnwzUEwSail8AljpMdxA9lMNvX6X
   WrgBQt1EE2miHqXKeQ6Xg7XS+VATwYJaPeaYi6HDx38+gW7WCYNJmOKwH
   1E5F4KFaFw3fkmZ7fpWd4Yx3amvOPzhEYDcb8gQSOuuNl7IhvdWNpw8Xj
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10391"; a="367919621"
X-IronPort-AV: E=Sophos;i="5.92,227,1650956400"; 
   d="scan'208";a="367919621"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jun 2022 18:49:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,227,1650956400"; 
   d="scan'208";a="646684373"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga008.fm.intel.com with ESMTP; 27 Jun 2022 18:49:22 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Mon, 27 Jun 2022 18:49:21 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Mon, 27 Jun 2022 18:49:21 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Mon, 27 Jun 2022 18:49:21 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.170)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Mon, 27 Jun 2022 18:49:21 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SoPUoG8sp1QObzpr8fxihVAN96a8mLcKWO6jQUcJTYcCP412xrUUt6vOUSmsLhDhXlFaTvVqnsEwKhHpro+HYu49U9oRGogkDz2Qc0x2c48QVUvrh1IeYCWBG7leDFUWdHR7a8xyVVtIfkEUH7+B3+j6AdtPGcAK8hc5uUTGX4eRXEPt4FM94jsfdiuXuJj+KIBKwvrIuaYYYtgZcgtmSpjg/iphr69SwDI4Ga5q5YX1Vk7TRDjo8XK8HMiiXO/ZJ+cOmluICfeWPMNKzUvZBsU7nv8Lf5B5rVvO+TFy5xw2LLaf3ErwxgL+jqr3Jc2hevGazB81PHa5+8EWxMYu+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ri3TudtIg82ToItGaBWyEVUpaYZkgNlvOHTpEOe0VoM=;
 b=L4C+q/3Agzm919e01QPLcxaOYll762Fq9o9k4OwLVaxjwY/f/hqzJC8KVxQkkn6PXC5Is1yQL2+Z2P3h5D39Hbo4Alfzf6p9Si127UhCGJSEJqL/0EDcESa9ZHn2cJfAxnIM1cNzCVjN7KkAU5Kq9xQTgr8sYSlW7sUaPlf/+KnLU+Qh2lkQNNuJVQBxnawZZuYrIyrN76HNXJC4J7OKbEOOTOEA+f4Kuoq9xHHPuR2aQQl44zSItVxUF/Gx1QWoTyjUtHZ4tSrbSFAjd7mFvLQE5+XwWoap5aWEx+3PqwJP7KqHq48tA9bJmX2ypPfBlzUF/Gc6YD1RoqdL0nAIdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MW4PR11MB5933.namprd11.prod.outlook.com (2603:10b6:303:16a::15)
 by DM5PR11MB1385.namprd11.prod.outlook.com (2603:10b6:3:9::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5373.18; Tue, 28 Jun 2022 01:49:17 +0000
Received: from MW4PR11MB5933.namprd11.prod.outlook.com
 ([fe80::71d0:716c:7d6d:94c4]) by MW4PR11MB5933.namprd11.prod.outlook.com
 ([fe80::71d0:716c:7d6d:94c4%3]) with mapi id 15.20.5373.018; Tue, 28 Jun 2022
 01:49:17 +0000
Message-ID: <3c50dc7a-748b-6931-4c96-84970d2ec3b3@intel.com>
Date:   Tue, 28 Jun 2022 09:49:09 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.10.0
Subject: [jirislaby:lto 40/48] arch/x86/events/amd/core.c:696:23: warning: no
 previous prototype for 'amd_pmu_test_overflow_topbit'
References: <202206271846.ABXxrU2T-lkp@intel.com>
Content-Language: en-US
To:     Andi Kleen <ak@linux.intel.com>
CC:     <kbuild-all@lists.01.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        "Martin Liska" <mliska@suse.cz>
From:   kernel test robot <yujie.liu@intel.com>
In-Reply-To: <202206271846.ABXxrU2T-lkp@intel.com>
X-Forwarded-Message-Id: <202206271846.ABXxrU2T-lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR02CA0068.apcprd02.prod.outlook.com
 (2603:1096:4:54::32) To MW4PR11MB5933.namprd11.prod.outlook.com
 (2603:10b6:303:16a::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3fdc13e3-f895-4afa-0c67-08da58a8694d
X-MS-TrafficTypeDiagnostic: DM5PR11MB1385:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ddJi7tvQEaMH+m5KC4upKuaoPkvlNTSqBW+hHrRs5IVmuYnJjEkeUuklxv/3DjMnOBhHkweqyRpAf6QxZo5AhCZJL0IpbzvQZogfOtwLD90pLqtfh9zMDej5Vlg5CU2Tu2FA74H8fc4GT1CiwI6DzNe0Q7mnZ/CwiqVP4vo5JCFRsedGkxGWcjRXH79eQ0nDXA9f425Mq3u6AgH7YgUa75EfSYivQhb2DUlkg3KeCQ4NQOPBlt9Nw3sswjWmvb5ju8mZU39OFbNWOhrWYFYgZHWDzgmFN2W8xOwz1RcaukYsLzkVoYqzi6glxae/F/dlqegXOZAznRgrtUJih9NVQw7HNS2Dj2PqHD9Ci80kwhBRg27cgN6zoURoGk5j/F/c11QKk5ecO+gvf2UjVHK3AByNpAMyjSJ6BNA7iaJDa6HSoN4CvzlaItwPbYwM6j3APyktV/qd7Whsk/dIUMH8znciw0A1Sh9eoI9tRTffepe9nk7lU6Zxg9jwmTvJDdUPIr7J6i2dQWWryEdM6bDBq/uIl+/RFm7PMAsRuO4RGrW84ulr7O8zKrYE5GPcj2Mpm9wb6Vq/G35rypY6O6ehkOlmtINvZyiVjFEBk0Gd68MFFNG3pANZW2fkctqCizf6R64CVuuJ/ijn0KAPASvDwg3HGVVPyJAksQ/ps2NQoHl3BLnw6SqqmoMD+tnsdkQ4L4HCeQt610UcVK1NlTiQ3hyhieRmn/mdlsqSzEU1qgXtJjS4h+hfHe55g4RvHunn/aeBHZ6coDYnPSWwNoJi9Jw6ERYmrVxRpcMNx6v9TFf2zaUF/Ua6I4X9+t2MPHiBC+7FfqhwiQ4svYx18xvcpLFsBwjjgMHrho9X3Hku1YqCJCB07NimxeLoMylIljvs6TKixYJ5LKa8EFQ8M+w+fQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR11MB5933.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(39860400002)(396003)(366004)(376002)(346002)(136003)(31696002)(86362001)(5660300002)(8936002)(66556008)(6512007)(26005)(4326008)(6506007)(6666004)(2906002)(41300700001)(8676002)(66946007)(66476007)(38100700002)(54906003)(6486002)(36756003)(31686004)(82960400001)(83380400001)(966005)(2616005)(478600001)(316002)(186003)(6916009)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YnVNNy9RREVKNmpsbTBZaXAxSDlEZUt0dU9HN1BpakJETHo0bHh6S05JNnNL?=
 =?utf-8?B?ZHVSQ2c0endKTEk4NENYTUlhMmsvZ0Y4WXVHVE10MTFyRlA0VTZDYUUvdHli?=
 =?utf-8?B?SGdnVXhIdkN6N0JXUFRWRmNmZ1EwMjJlRmtWU1dtWnpuYklRenNiL29VaGcz?=
 =?utf-8?B?emtLRldRcTBxWmE4eEtJQ1l3clFLU3BaWWkvMzdNUTB4aVA4WGc0SWpiQkZm?=
 =?utf-8?B?bTZjMGVCTUxnc2NoR3k5aFdvVkJaOGxoSjQ1ZjltME56TXkrTEVxdFBOVEh3?=
 =?utf-8?B?M2ZPL1RVSEVLNG5wemY1ZFRRZ1JlaDZzVEVHalRUUDlTcnl0NXZsc0VuZDl4?=
 =?utf-8?B?cjl1ZnpOdUVlSndrWDRXWlBCZFkzTUZRTzc0VlJ6bXhzY3hvSjNlSkp2QUxE?=
 =?utf-8?B?dGpPb3N4a3Bna1RwQmhSZ1hEVFRUS2daUjgrWW9lUUtUemhRbjI2NHg4bnd2?=
 =?utf-8?B?N2xOR1c1allxL29OUjBObGhYSXR3M1YxenNlNEZvbjhneitzTjIzdVViWWM1?=
 =?utf-8?B?TnFhQVpmcS9iUVY2SC84ZGM2dFpjKzVBNkJpTzVJOURJZWkyeFBleHdLaTZt?=
 =?utf-8?B?ZElZUXJOWkoxTEtVZWVBNTNwK1hFekl5dlM4YmtmQTV2V1RLQkNkdUFLQXJL?=
 =?utf-8?B?ZURJYmR1QURJVmdXaHUvV2oxdW5jcmxpQVBsQkR0R3lSODl4V3BTLzR1NjJP?=
 =?utf-8?B?MWtOSGpKUmJjWlVSWWJnelNVNGpTbzRlVFFaaDk3Uml4aUpEZlRBY056QmJv?=
 =?utf-8?B?TkZYSjNmTitVUXhzOXVEQmFRamNVa3p2SkZSajdYdGFOZG8xQis4M3hsMm1t?=
 =?utf-8?B?cm5hTVJaTHBnR0JjMkI3U1d3bnl0WEJtVEdGYmFDQlBRN3pIUjdiRlA1cjMv?=
 =?utf-8?B?NUpiU2hRZy9ZQkNwR0tIOWhZSVgzb2VXWXduRWpYNU9TSldKM3didHV6UmVS?=
 =?utf-8?B?UDdPb1J1ZkRtQ3pjSzhidk8wOENKbWNOcVFpQTYvVTFBRk9KbTlMUnZLbGxr?=
 =?utf-8?B?c1lNUEp0akIyMEk4OUI3V1hDVWE3RkpSM3EyVHBEUzEyUnFTaUVEc21LeVpi?=
 =?utf-8?B?UFpEcUtKQk4xSU81TFNja21TS3BrZWlVenpMcTRBK1ViWnliNFdpeTY0eVBy?=
 =?utf-8?B?eG1XcVhKNjBtdExoRlVyTmhvM1RuYVFNaEcvNGgwWkh6WnNYY2xYWHZDUVNr?=
 =?utf-8?B?cWtCa0t6TEN0WTdMS3d3aUxweS9MMDcvSkNxNEtBSjV4bmhlWElWOVVzRUE0?=
 =?utf-8?B?UFlHT1RHaytmNUpueHZJblRxU1JzMWRvVnNJM3lHTm5ybnZNWkJ5ZkVJRldH?=
 =?utf-8?B?MjcxakZxdXVBTWoxZDFxeUcrUVhiUHU3TkFHRzFHbkh3ZDh6Um5PcnErcWZv?=
 =?utf-8?B?VDFuZDUyRWcwM1NFbjdJMUlwQXdtblVTYlIzUklHQVJ0K1JzWTduVXRXZnpH?=
 =?utf-8?B?OWxIWERnUVJIemlzclRJaXJyZ2d6ckpIbDJLRUJGVnBObktObjBadmpxbjR3?=
 =?utf-8?B?QVhaNWpOaytoSVVza0NDMWhRZVlXUnpuWmZESVdBcDc3SndtMytES3I2NTNm?=
 =?utf-8?B?Sy8zK2dBemVUVW13S0pOUmx4dTIvZkdqS2htTkExTFJ3QSthaUQwUEJrbHVt?=
 =?utf-8?B?OXdYMEh4a3E2M0RHOEs4dzZKcEVqZ2lxY1JLaU9aZWhvYjhEbGpSaWhQb0tW?=
 =?utf-8?B?cjNaZm5POUxFc1llSDFTV3RKSzhWRGtYRi9sM0FQRWEzQjNsODlDeDI1amk0?=
 =?utf-8?B?YjhldVNHTGpQSHN4Y2RTVk94RFljaDJEYmtZeElkdy81NzZhaFZRa2drQWxN?=
 =?utf-8?B?M1RxV2pWdWMxclVXT1dUQ0ovNDRsWGhCNnRaTStUNFVHd09xR0FyQWxOR29s?=
 =?utf-8?B?YllzVmgxbGczWTNsajljWnVqS242ZlRubkdITmh3ZjBLeE9oeDRJREl5UHVi?=
 =?utf-8?B?WFdtUW94UWh5aTNWSGNxUVp5N1dWTWNSOGU4UVUyWHdvL2ZKdW5aQVJET1d3?=
 =?utf-8?B?blhIbkljU3FGczE2MDRXc3VTcTJIWFQwR09FYXRYWHNLM2ZDTklObHBzQzZF?=
 =?utf-8?B?RHgwT0RMNjFvUXkrcENqMzlmc3E4ZHBDMWNmbWZpcFQxYTRLLytZOE1wN1dm?=
 =?utf-8?Q?bE5W3ZmwBQpszIcLN+Eb58hJC?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 3fdc13e3-f895-4afa-0c67-08da58a8694d
X-MS-Exchange-CrossTenant-AuthSource: MW4PR11MB5933.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jun 2022 01:49:17.3409
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nGGbY11rDn/GhegbTS3F42kfde8r6uQY4CptirOKbjpm7TTIS/QE8DTwi7Ffjd1GznCWZc0vCGEj2FhyEGylHg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR11MB1385
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/jirislaby/linux.git lto
head:   b5ee1c28376713353cb5355716949d9c6d9b416b
commit: 37d6f8c7840982bb452f8bb411fba6a7f4f0e8e9 [40/48] cpufreq, amd-pstate, lto: Fix for gcc LTO
config: i386-defconfig (https://download.01.org/0day-ci/archive/20220627/202206271846.ABXxrU2T-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-3) 11.3.0
reproduce (this is a W=1 build):
         # https://git.kernel.org/pub/scm/linux/kernel/git/jirislaby/linux.git/commit/?id=37d6f8c7840982bb452f8bb411fba6a7f4f0e8e9
         git remote add jirislaby https://git.kernel.org/pub/scm/linux/kernel/git/jirislaby/linux.git
         git fetch --no-tags jirislaby lto
         git checkout 37d6f8c7840982bb452f8bb411fba6a7f4f0e8e9
         # save the config file
         mkdir build_dir && cp config build_dir/.config
         make W=1 O=build_dir ARCH=i386 SHELL=/bin/bash arch/x86/events/amd/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <yujie.liu@intel.com>

All warnings (new ones prefixed by >>):

 >> arch/x86/events/amd/core.c:696:23: warning: no previous prototype for 'amd_pmu_test_overflow_topbit' [-Wmissing-prototypes]
      696 | __visible_on_lto bool amd_pmu_test_overflow_topbit(int idx)
          |                       ^~~~~~~~~~~~~~~~~~~~~~~~~~~~


vim +/amd_pmu_test_overflow_topbit +696 arch/x86/events/amd/core.c

7685665c390dc6 Sandipan Das 2022-04-21  695
37d6f8c7840982 Andi Kleen   2022-02-18 @696  __visible_on_lto bool amd_pmu_test_overflow_topbit(int idx)
7685665c390dc6 Sandipan Das 2022-04-21  697  {
7685665c390dc6 Sandipan Das 2022-04-21  698  	u64 counter;
7685665c390dc6 Sandipan Das 2022-04-21  699
7685665c390dc6 Sandipan Das 2022-04-21  700  	rdmsrl(x86_pmu_event_addr(idx), counter);
7685665c390dc6 Sandipan Das 2022-04-21  701
7685665c390dc6 Sandipan Das 2022-04-21  702  	return !(counter & BIT_ULL(x86_pmu.cntval_bits - 1));
7685665c390dc6 Sandipan Das 2022-04-21  703  }
7685665c390dc6 Sandipan Das 2022-04-21  704

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
