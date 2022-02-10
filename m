Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F27664B07BA
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 09:07:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236973AbiBJIHX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 03:07:23 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:47314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234241AbiBJIHV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 03:07:21 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 833D0108D
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 00:07:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644480443; x=1676016443;
  h=message-id:date:subject:references:to:cc:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ciLuY3SQt8jYe8aKhm4JyBNL1+5i3XiUVBqc1Bp8U/g=;
  b=cyyPkL5lzep0VSjSzefk6RY7FBEJcSp3NxUGpUZhfb74/Luv/gz7WuUv
   7A+NKUyoFtRyCDFrO8NZOlMOhh4dLfe31VOUv6yGfuG12g2DuFRZASxnk
   Y9Q0nfbhtmVP1X4bFt3VE26ZMOvw/y1Ni4+PqnyRvvkuy4n5aLNvgYvnS
   tiwgkPedxF5sbjj/VJNjbmUcE0+SkYky4PyIwrmxba0eGQ5+7mKnaAytM
   DHNF2FtXmpK/Hx3IQIcpxDNeTsMQwIhByPPZDi5WzOaT7hrBgsOrEWMmG
   /ZnQ3ein2jVl9BWXgnuSwzYk8+h18YIV2sb6kiP7dVg+9TIAFpphb5LDz
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10253"; a="248269552"
X-IronPort-AV: E=Sophos;i="5.88,358,1635231600"; 
   d="scan'208";a="248269552"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2022 00:07:22 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,358,1635231600"; 
   d="scan'208";a="482663342"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga003.jf.intel.com with ESMTP; 10 Feb 2022 00:07:17 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Thu, 10 Feb 2022 00:07:09 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Thu, 10 Feb 2022 00:07:09 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20 via Frontend Transport; Thu, 10 Feb 2022 00:07:09 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.173)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.20; Thu, 10 Feb 2022 00:07:08 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Boz7KfCWi5zl6xEsf2GWHJHkl0vTPyuokU+JNSTeOeJAzFl/gWCDHo7LyQAK01oNYTBdUu+Isin9Y87zv/OrJ22vuzWURNqqffTzpsS6XH4XGAv96Y+st+lxyHyiHKEGseq6+ueXtg8ZOUIliJfJWU7gmoWdFa6BVOysWFuG8k1YoKmODuTvDG9TgF4x2YXBdAqjC14jk/Bz4RVet34cFPCNZCw5oMhssKw8XqV7dZ1WdC1cXnh7PCI9D7NxQMpyrBVIKegn/2Bfw7EyRXLw3M73F7GtlbQUNFDOg8b3F2Ihl1Py5IcwtLU5kTBddVjkgwK+rCiwPxR0aF77/Rvo0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qmakvB+IIT0k0bruWOsdzn6VYEK4wJeoHfwKNVE2cLE=;
 b=NnIXAq90ThDSuMo0Z6AiSjk4g57Tz3ezv8GRymZtVaBDJ0PbBubtCBiaynT6V+vFu/659C3IX2Cz6KiDKHWsWjd3Yg3bACnXI86Q6BAie7cr71ghHqxlA9yvzB4GqBeFQrZDh33BxncVuhDVv8f9x4k4U3n1oK2tFujrbqybLlPO9AkuTkEX5Sx6tISC6NzeRoe69IaghlUXbhPEM1VmIdy4tA0NVxPRj7KzQXSlTXNPcZnBi1RPEZeUtved6JLWulbszIXRuDdlaMrCNWmWbDqAgYAA9YzEz21d5pBASbE04Fp8RuwhQk2p9C7kP4/BAIJRATcnXy4bV/nG8oAxCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ0PR11MB5598.namprd11.prod.outlook.com (2603:10b6:a03:304::12)
 by DM6PR11MB3867.namprd11.prod.outlook.com (2603:10b6:5:4::27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4951.14; Thu, 10 Feb 2022 08:07:07 +0000
Received: from SJ0PR11MB5598.namprd11.prod.outlook.com
 ([fe80::c4a2:d11d:cb7b:dc8d]) by SJ0PR11MB5598.namprd11.prod.outlook.com
 ([fe80::c4a2:d11d:cb7b:dc8d%7]) with mapi id 15.20.4951.019; Thu, 10 Feb 2022
 08:07:07 +0000
Message-ID: <c418f925-b7df-da46-e4aa-f0d6af128490@intel.com>
Date:   Thu, 10 Feb 2022 16:07:00 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.5.1
Subject: [axboe-block:for-5.18/io_uring 2/5] fs/io_uring.c:9406:9: warning:
 Uninitialized variable: ret [uninitvar]
References: <202202060419.bpwBH36K-lkp@intel.com>
Content-Language: en-US
To:     Usama Arif <usama.arif@bytedance.com>
CC:     <kbuild-all@lists.01.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>
From:   kernel test robot <yujie.liu@intel.com>
In-Reply-To: <202202060419.bpwBH36K-lkp@intel.com>
X-Forwarded-Message-Id: <202202060419.bpwBH36K-lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: HK0PR03CA0114.apcprd03.prod.outlook.com
 (2603:1096:203:b0::30) To SJ0PR11MB5598.namprd11.prod.outlook.com
 (2603:10b6:a03:304::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: eb6adc62-86aa-4625-06c2-08d9ec6c54a6
X-MS-TrafficTypeDiagnostic: DM6PR11MB3867:EE_
X-Microsoft-Antispam-PRVS: <DM6PR11MB38676AE2C9A772444A6D1D31FB2F9@DM6PR11MB3867.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:111;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8INOKzk+n6qIj8x1EQP5GAH17w9RbDxiaX69ZMI8yHEn092czJTUjj3mtG58KOVGrcRMJc9XmE4VnfQFgzyI//VVqwDgwYGhoSly5pZJABmYLKyWzPVck5uHe/pWO2HvdXMojOklHBWzfR1FXxwvrQthieKLZL9e5CtntlF8KWNTKF6OKN5V4mu4d4FbG2vR9A76VkPl2ohK8/D3SO3GVl18/Ts5k44HnjnGpjImx9ptdkajBDE5krGqzB6Uku+W2UH7YxxYFbOKfcuHLiwIc1j8+l94FSr8PWZpZ0qGIXr74SOIc6JJsuxwMyoqFfnPWEb6VOI2Sh1e5Pq8DLJQCM4UyMMo/oO4ZdezgMuYg6qfx4970CzW9aMTJoCk/TPC+0XwjBiqgl2Z6INg5/s+bOfT7GNvUGDnHNvf/QZEkZ2q9780DoX5H9GwT0Z7UQsygITRuhEZzMh5oKq+gLRjAEtmiP7DiNsQbUSb17ub+xtgMe1eLPKeljrtPMyRREf7pHT1qPUkaOD4wH+yygYsSEBHku4jB/JyVbsaxbkETLJw7DcqnEQReDMbjfQTKGqJ4eyDbv1+lBvSTFrmhrd7uhInVToRWeYMKx4L8KVVQw6NWUwniGwbbcQm6yx093vTHdkbYVlNK9mJGUQjNpualHeSE3HvtX8tYH+Ygn65DjUIBv4BfGarhDpVXMzlNeiklQ8GvrHFOqAinYuTFpYIv+bxCw6rdKlrtMc3e2V/OAIKl1JRlbsQBDolAPDZondyfrJunQ9dszhFJwHBWeMn8VwIkEsGHmWmq8DrPclNmVC6Ndn3W2S42wibSKYUHN+iYMAXECfGo/BaMps6UF/rPYCapi9rNzMSazzKqtydyms=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB5598.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(54906003)(86362001)(5660300002)(6506007)(186003)(316002)(31696002)(36756003)(38100700002)(26005)(66476007)(6512007)(4326008)(83380400001)(8936002)(66946007)(6666004)(66556008)(8676002)(6916009)(508600001)(2616005)(82960400001)(31686004)(966005)(2906002)(6486002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MFRIK3VVWWRDYk9xL2lMNEp5aWVTdUFiMWRXaklGNVhDWWwyU3JmL01KaDdo?=
 =?utf-8?B?THA1MTJVb2pmeUFCb3RVMU1EYm95Q2ltWUhoWnVsd0RmOVdTbUJBSWtqNVBk?=
 =?utf-8?B?SGJPS0dLOWlZa3VJWXdJcTV5ZGhZUE92Vmwxc1U3UytZNXlkNCt6bTRNYkpX?=
 =?utf-8?B?RGVzTUxpNUVJZnFPQkhtbjhSdFExbEMyZzhORFR4bCt1Mlk1VEFPRDNsUkNS?=
 =?utf-8?B?ck9QVEdhbXBGajRISGErWExtVVRHWW02c1dscnlpVXFBZFI4WjZMeDd2ZG1N?=
 =?utf-8?B?TXBSUDUwQVVacW1wWGdPMlJabUtuM2lEK1RjbW16N0RZMEczMStZRVpHL3dC?=
 =?utf-8?B?ZmQ3dHJnVTZYRmpsTWRnQWZWVlZCaDJXNmU4MzVFVFNjUUJLWTkzSFJXL2pD?=
 =?utf-8?B?Vy80bG4wa1F1Wm1vM01WaENCU2lIb2ZONUtLYmN4d0g4cERWV3pxSEdkR083?=
 =?utf-8?B?cS8ra3JvV205REt0VGpHQWpWOC9MUHMrMDF6WjloUnhUUHFuSmZTd2NTb2JE?=
 =?utf-8?B?WHFBSG1sOHdYQ0xBTjA1VE9icksxNGNOMlF4SmFSSmlRMTIzT2g4cVVzZHZt?=
 =?utf-8?B?enhuUGkwaEcwRTNkVzM1ZXpOQTNqR2RlWVhQZTJ1V0VFT0VvK2dEdG8xNEd0?=
 =?utf-8?B?TnJ0dDNqRVh6c3kwbUx6M0VxU0d2K2ZHNktlWURSc0hwSnd4L1VHeHFnQmhj?=
 =?utf-8?B?ekJxMXpnTDd0OHpBdXVXSFpFL0pZSVVyeGxZUWlNeXJUUWFudFVjK0U3RGNj?=
 =?utf-8?B?dXRod0hBdEExVzNmTGtrMC9GcU5FSjlhd3FxbFlxU0g2RUFDMkorUzNDU0JG?=
 =?utf-8?B?a2dIMjFiZmZ6ZmNPUU9HTXRKRjR5M01hclIxRDdDa3B1QTlqYWdkWEdpNHJ5?=
 =?utf-8?B?Yk44cmZJcWpOQmJHRzcxK0ZucjgwMFgvNmY3MGl4MFJ1bEptZ3k2VHZCa3I5?=
 =?utf-8?B?YUNqTEovRndpZFIzVEVHRXRUbjF6Wi9UaXhsdDR2UG5CVEQrd3UyUVJlTm1U?=
 =?utf-8?B?RlBMYnpwVDA4c3hzekRjd0g0eE1yaDkxdzJlSW5Nd3lGZlhvVW8zcUg0ZHo5?=
 =?utf-8?B?WkJTMjdBTVlidjhYVmw2YjkxRHJSc3lxWnZMREVDdFFDUnU5MXZJV2pNSFlM?=
 =?utf-8?B?MVZuT3JKTGZnRE9UWllmVUxSVTNkV0lWak41UmJ5VnV1b0EyeHpxWjVpc1dx?=
 =?utf-8?B?S1h2ZWFmanRkN0xxa2pSaUVTaXUxeHp4SW1jczFjQ2V2MVowWHdBNGVoZEdV?=
 =?utf-8?B?R0o3Y0hkYlo0U0pMblByLzJSa0lDZ3lDdEUzVmpWZFFEYU05ZDhTaWIrYXo0?=
 =?utf-8?B?Sm9wQU5ITXB4cWYySUo4RzFZb21VdXQyRWU4dE5LZnY1dmJ5NWFGazJsZDB4?=
 =?utf-8?B?UTF3THdGOEhoTDJOcHdNRnoyYnNxalQvazhMc21zUGVzWENCWU5sdmZ5K3hE?=
 =?utf-8?B?eGJaOXcwSzBuZms5eThxSnRXUGpuOXFrWkV0MHd6YjRSN0lVV3g4UkI5LzlS?=
 =?utf-8?B?OTRtYnZJQktKblRzMy9ES3ZGeW82TjZ1c1lFa2EveE9XN05UTG5yZE1MRElC?=
 =?utf-8?B?ZGpWOEVmODEwNmZEWWFzTXJJdzhZMjR5eE4yVUZzZUdvd0ZSbUprRkpPUWhh?=
 =?utf-8?B?M0Jod1F6Yk5XYnkvSjNzaURSYzV3OGVvNXJBRDYyeW84dDhZampNVUxNMUo0?=
 =?utf-8?B?WDMvR0RMY1czeEN1QzdINnRKaXB0U0doRFRxbTltaHdwUzl4d3I3NU41SklM?=
 =?utf-8?B?TjNUdVVHcnc4OC9aaG5tMDBoSm95Sk9XODVCNUswNEl0MDg4dTY1Z21KMzNi?=
 =?utf-8?B?elg3THl0aUNuc0FnNDBGdjZ3WmlDUDVyQTBJWGlmMStGQTlEZmFWaVhxcUI2?=
 =?utf-8?B?WXo5eTh0ODNKK3VacXNoMmZqY3c2NFlMa2JKZzU3UGhVRDh2eG5tY3JVWTQ1?=
 =?utf-8?B?Z3M0eFczMWswYUdzT2hVb0ltT1RoczZiV3FTVFQ0aFB5TFpQS2s5Y0xPb1Ux?=
 =?utf-8?B?aERRU3EzZ3lBUXl2Zks2aFhPNnMvTXlyaFpYS1JsZVdUVE83M01yRGFkeDBF?=
 =?utf-8?B?aGRocmgrR0loTm9Bd0x2c05mWFFBVzc1VWh4OUxNQnJrR2VmZHhBWmM0SnZh?=
 =?utf-8?B?THpKV2g0bGdTbmhidzR4SlJac2FDZmhUcDVrQldTVDZ6S1ZjeWZneGU2TDJa?=
 =?utf-8?Q?FrA/uOxdST7yZHilBLV1Gbc=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: eb6adc62-86aa-4625-06c2-08d9ec6c54a6
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB5598.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2022 08:07:07.3862
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rG6J//4hqON2g3RfDi9lf5WUnoS87L5TMezI2Ae5s70wEQ9rPAFeQi05xbuo1g8hK6/uYxqRZrIw4occ4ynzzw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB3867
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git for-5.18/io_uring
head:   971d72eb476604fc91a8e82f0421e6f599f9c300
commit: b77e315a96445e5f19a83546c73d2abbcedfa5db [2/5] io_uring: avoid ring quiesce while registering/unregistering eventfd
compiler: riscv64-linux-gcc (GCC) 11.2.0

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <yujie.liu@intel.com>

cppcheck possible warnings: (new ones prefixed by >>, may not be real problems)

 >> fs/io_uring.c:9406:9: warning: Uninitialized variable: ret [uninitvar]
     return ret;
            ^

vim +9406 fs/io_uring.c

634d00df5e1cfc Pavel Begunkov 2021-04-25  9379
9b402849e80c85 Jens Axboe     2019-04-11  9380  static int io_eventfd_register(struct io_ring_ctx *ctx, void __user *arg)
9b402849e80c85 Jens Axboe     2019-04-11  9381  {
b77e315a96445e Usama Arif     2022-02-04  9382  	struct io_ev_fd *ev_fd;
9b402849e80c85 Jens Axboe     2019-04-11  9383  	__s32 __user *fds = arg;
b77e315a96445e Usama Arif     2022-02-04  9384  	int fd, ret;
9b402849e80c85 Jens Axboe     2019-04-11  9385
b77e315a96445e Usama Arif     2022-02-04  9386  	ev_fd = rcu_dereference_protected(ctx->io_ev_fd,
b77e315a96445e Usama Arif     2022-02-04  9387  					lockdep_is_held(&ctx->uring_lock));
b77e315a96445e Usama Arif     2022-02-04  9388  	if (ev_fd)
9b402849e80c85 Jens Axboe     2019-04-11  9389  		return -EBUSY;
9b402849e80c85 Jens Axboe     2019-04-11  9390
9b402849e80c85 Jens Axboe     2019-04-11  9391  	if (copy_from_user(&fd, fds, sizeof(*fds)))
9b402849e80c85 Jens Axboe     2019-04-11  9392  		return -EFAULT;
9b402849e80c85 Jens Axboe     2019-04-11  9393
b77e315a96445e Usama Arif     2022-02-04  9394  	ev_fd = kmalloc(sizeof(*ev_fd), GFP_KERNEL);
b77e315a96445e Usama Arif     2022-02-04  9395  	if (!ev_fd)
b77e315a96445e Usama Arif     2022-02-04  9396  		return -ENOMEM;
fe7e3257502991 Pavel Begunkov 2021-06-24  9397
b77e315a96445e Usama Arif     2022-02-04  9398  	ev_fd->cq_ev_fd = eventfd_ctx_fdget(fd);
b77e315a96445e Usama Arif     2022-02-04  9399  	if (IS_ERR(ev_fd->cq_ev_fd)) {
b77e315a96445e Usama Arif     2022-02-04  9400  		ret = PTR_ERR(ev_fd->cq_ev_fd);
b77e315a96445e Usama Arif     2022-02-04  9401  		kfree(ev_fd);
9b402849e80c85 Jens Axboe     2019-04-11  9402  		return ret;
9b402849e80c85 Jens Axboe     2019-04-11  9403  	}
9b402849e80c85 Jens Axboe     2019-04-11  9404
b77e315a96445e Usama Arif     2022-02-04  9405  	rcu_assign_pointer(ctx->io_ev_fd, ev_fd);
b77e315a96445e Usama Arif     2022-02-04 @9406  	return ret;
b77e315a96445e Usama Arif     2022-02-04  9407  }
b77e315a96445e Usama Arif     2022-02-04  9408

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
