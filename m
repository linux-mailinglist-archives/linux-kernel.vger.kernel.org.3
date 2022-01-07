Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8924D4870FD
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jan 2022 04:06:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345713AbiAGDGC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jan 2022 22:06:02 -0500
Received: from mga05.intel.com ([192.55.52.43]:54675 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1345733AbiAGDGA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jan 2022 22:06:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1641524760; x=1673060760;
  h=message-id:date:subject:references:to:cc:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=uRQFDiWAmOYcUZywP31naZZrNWuJ6IjGqTTQsE1J+Ro=;
  b=jRUMroDR2R6yQ3hqWDMfsND4DDdgLwfaNasowG9GkiLS6YY4pimO/UMd
   hhunYPzz84ekT3BOuPgZoQ6uY02u17ecicpT6JaGvXr4qm8pa4PAWBa7r
   Xgt3P2SFvDz6Qi8nNfBBypVJLmQ43kv2HBEfau/neGvNsm/yc9x8TaLgs
   Apeb2W/ovSu0TEu970VakCXOJKMa8bod7pYVKDyx2UKN7bsHbb86HLeuy
   o69GkOF3G/HDpcHtYG9JdkWhZWHI8IgHDkoVzXH0CTchl6P9+R2xcZ8w1
   E/RG6+ywnGdgp7xLDrnycZTDOZKA3322BYtO2TURKhmWoV6zBpeREAnxr
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10219"; a="329140294"
X-IronPort-AV: E=Sophos;i="5.88,268,1635231600"; 
   d="scan'208";a="329140294"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jan 2022 19:05:51 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,268,1635231600"; 
   d="scan'208";a="621751679"
Received: from fmsmsx606.amr.corp.intel.com ([10.18.126.86])
  by orsmga004.jf.intel.com with ESMTP; 06 Jan 2022 19:05:51 -0800
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx606.amr.corp.intel.com (10.18.126.86) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Thu, 6 Jan 2022 19:05:50 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20 via Frontend Transport; Thu, 6 Jan 2022 19:05:50 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.171)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.20; Thu, 6 Jan 2022 19:05:50 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cv/J4oGJ1y30/bV3hoIN75YDOL+Ympo7aKy8QbDBOWNu2rChKcTVFk5dPgmdn8qdSIxgIBy89UmgmNhNg3trHeU3Q0UVoAfi9NGSlFvY4W+XxcvqHAmlzVmL/Vop+17c7wwsQLbi+Z6w7VcVyrzcePtnD0Rp3iVPPUcWG9yoz8jKH1Ot0fno4wZht6bgFvimh3bm12qlgsE9DbbmFiQI0Llv04DGbuiFAHycKX6zg7+WDRDLEn1ERiuewrWfTZGM5aFa+cNe3zfzlRGubYsfcM0o3q8frdHQ3cWFW4fiwHNQqLAhAvlfoW95I+EygJ/gcPDkW5FiwuZ+2z6ydSLDUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UQGP/LRi2JbJoR3lvzEisHQL3FBBdTKjsbvyJaDZxls=;
 b=LyRqVugqADv6ylGl/cIQyvtG8+GLZEEqNmsH4uQkFAVSrwEg3ekSu+EzBMD5q/hlS+erOcMXf5y62SzmajSV3dOW64MrigGhrjhQJwiHkNQtV/P5kWNknF5/KFiKVjP5+KaozAqjJBlT91K4GmmOApFaXWBtqdAYRzU4DpSXRmd8AfModR82YlnimQdXPxzFRQdXupkOu6VKRAq15dBAO9zvSqKWt3hzU11JT+jBrzH+p4kmXwv3vTlHvzzRsnsSE+6oCBiC2gvDazYd+0DbjxoDRHEu9X/cxWbrQR8d7HYYnhm9oNoksRBMc22lrSps2L8QfAX4BFBm2xCsr6dEgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ0PR11MB5598.namprd11.prod.outlook.com (2603:10b6:a03:304::12)
 by SJ0PR11MB5662.namprd11.prod.outlook.com (2603:10b6:a03:3af::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.7; Fri, 7 Jan
 2022 03:05:49 +0000
Received: from SJ0PR11MB5598.namprd11.prod.outlook.com
 ([fe80::741a:c47f:a4:bff5]) by SJ0PR11MB5598.namprd11.prod.outlook.com
 ([fe80::741a:c47f:a4:bff5%6]) with mapi id 15.20.4844.017; Fri, 7 Jan 2022
 03:05:49 +0000
Message-ID: <b95a8286-e1a4-e71a-aea2-503e1bf9459e@intel.com>
Date:   Fri, 7 Jan 2022 11:05:41 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.4.1
Subject: drivers/net/ethernet/intel/i40e/i40e_main.c:4643:2: warning: Value
 stored to 'pf_q' is never read [clang-analyzer-deadcode.DeadStores]
References: <202201040200.QGI49OIz-lkp@intel.com>
Content-Language: en-US
To:     Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
CC:     <llvm@lists.linux.dev>, <kbuild-all@lists.01.org>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
        Tony Nguyen <anthony.l.nguyen@intel.com>,
        Aleksandr Loktionov <aleksandr.loktionov@intel.com>
From:   kernel test robot <yujie.liu@intel.com>
In-Reply-To: <202201040200.QGI49OIz-lkp@intel.com>
X-Forwarded-Message-Id: <202201040200.QGI49OIz-lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: HK2PR02CA0167.apcprd02.prod.outlook.com
 (2603:1096:201:1f::27) To SJ0PR11MB5598.namprd11.prod.outlook.com
 (2603:10b6:a03:304::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 36db68a6-3e00-4e0e-a488-08d9d18a9b17
X-MS-TrafficTypeDiagnostic: SJ0PR11MB5662:EE_
X-Microsoft-Antispam-PRVS: <SJ0PR11MB5662D390D252639BE5FDACC4FB4D9@SJ0PR11MB5662.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:188;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TVneTqBBoRED7J/d86yvAypaz57hHUWu0uAbfPgwXt8HLGpIq2Yuoo4b+5BlJnAAWodJg+udCUgy0BBI7EShHZlGtVzBQEYKhgWUC85GUttWMOOeUF5PFjjzz2aNKfHTe660Z6ARYw1SstmefC9g+3cmcA2UREFRtX4HsykJJYx9++9I0i+QOuvFb2SMPhBGODOFqLmL43Bh01U4K6kG1mct4MzhLI4iILRvA9CPLMe3pmeNtM9ryT6yNhYo26LYTvVyaNYJ436Lt+CbJMvf9UpKk/rlaJevfIQRcVUseMwmdWwjcUvZwx3ksciOY3ZKQIB7XBM8f7oBxgfVVkXYSRSM0o9b2Jm3wlvh3fhzgDGheXGxaM+NWngK+HZIabFvdtQRLnIffDr8zbCfuG8ZrEnllELt5LAx3AYE82NCZj4XLQydQH4mGWa9DYVTDoLCL4mK1kKvn6PIHcVtEyA5mcuROwb4hqUd/j4F9Psx9smp8bN9Gg6HKK660LvwUxXz2Z8nccaNnHO7EugsWXBAabRUka8almTaAzt39BaWK3eB7GBRn7Jb34wkGA26uU7cvYcI7kxdGf/DyHv1dCaJJ24Jjl6cdXlWfLga950vFFP22xvII2FcyChRPnI0d8zJcpH5/7sE2OMAxM/pYpqgPRl0io51ycEZne695Nze51N81jiF1U5bYg1yTN/CSif8uSitVkRafyO2j8v/E4vKwDgUO8HCpKW6QGd/B/gK03fxz0onxxnsr2gRNCygt7m/BZCM7Ebt4Ukr3GIZiKDROTpY5GAEGrB7UGy7IZh/9996KAtoVMMRLRxihFtZb9HWiKGpTyT73qsRKa7VotYHYXMaDmkr57QujpR1gViLVDQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB5598.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(66946007)(966005)(8936002)(54906003)(66476007)(37006003)(66556008)(6512007)(8676002)(6506007)(316002)(508600001)(4326008)(6486002)(38100700002)(86362001)(36756003)(31696002)(31686004)(5660300002)(82960400001)(2616005)(26005)(107886003)(186003)(83380400001)(2906002)(4001150100001)(6666004)(6636002)(6862004)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ckJOQ2JMSDBmWEhKNkFtRlJ4bWNpeXRibitBRlNPNVFITGVxK3poN2o0czRM?=
 =?utf-8?B?NEdOOHZBZUJsbEtPYS9aRFdDSG82Z3h4UDZaQnU5S2p0aUhvRTVhNU12dUwx?=
 =?utf-8?B?Sy9IS0VqQlFIVEVIS1RmM0VhYzVvT2x3eWZBd0VlbGNGSDh3MVcyRVRnTFRp?=
 =?utf-8?B?QWNyaDFiVjVxRGZDRml5K0lpWjdTTDUxb0MyVjJ0RGt1TXUvbHIzcXdkdVl1?=
 =?utf-8?B?V0loTzVtOFdEZkkxUTc4KzhWZWdSWU1sa0xvbW1KU1BOWlBQZjBtWHdCbmJR?=
 =?utf-8?B?c1lMaDhNU2NSNWptTldwTzF2S3F2QkU2MDZkdzFoMjh4V2o3UnNPa0RrWFZY?=
 =?utf-8?B?MXFqWXJBaGd5K0prSG5tNzhkOFJVS2hQdFlWWEFVMEtVVmtIcUxLSWFsVUg4?=
 =?utf-8?B?MTNZa1dIeGRZbUZ6QVhwZkJ0V016S3RQUUZ3MVR6Y1gvWk9OS20yeHdiNjl2?=
 =?utf-8?B?U0NzeklaaEQ2bmUrUlFZU2xmYk9XcUdkbmRpTEdpbWlidGYrbUVzcVNBL3pS?=
 =?utf-8?B?dE0rYU5tNEoyYzJIQjZIMkRtVjVVUnI2Y0tWZlZuc2dVTzVMYXFVQjNOYXQ1?=
 =?utf-8?B?dlFmT0NKSnNMclVZMFo3TkhXTGZCTFFkWjNNeEZUVU80SHpUK2Q5NFBpam5y?=
 =?utf-8?B?SVVOMTlnWkQrMGVoTk5VNHZTdnpTSmlTS1NPemR4RVRlYXZRM1kzQmtyV05p?=
 =?utf-8?B?cExwSDJYeWRVOEkrVFRHUDBlMFFnem1RYmxWa0J3OHFUVml2RExsRjRUZmF0?=
 =?utf-8?B?SW1qaXpDRTNYRWJKMzVTTWFEMXRpdTFqTUlwMG96UDlyaWI0cG5hWmpxd3Rz?=
 =?utf-8?B?WUFFVG1FZ0V2M3dmek9yOWo3ZXBOZTZsMFZCcTJOQlg3dVo5QnJIUXgzY3ZD?=
 =?utf-8?B?T1pOeXV1TGVhUUtoVEZzcXZROFBKT2ZaUmxRdW5HNHRXUkE2OFY4MXZwTEU0?=
 =?utf-8?B?aVpFaHRQbHZ6NzlKOXNCNzJyeGJ4Mmc5Zy9GQS85eFdpQWo2bXUyZXlYMURq?=
 =?utf-8?B?RVBCRlJ4N1BVdVpjWFRUWUVrdDBLK0xkMEh4cjdlbWtKbk5icjM2ZzVGVTY0?=
 =?utf-8?B?MnZ1NUlGV1djRkFqNnBTeHNqSzNQOEJrWTJMZUhVUEpTZTN2ZzFwcGN4ZWJY?=
 =?utf-8?B?VTdmS0pMZzNuT3FHOFdOaC8zeDZUQzRyV2Z1WmszS21pbFpuNnpVUy8yMmY5?=
 =?utf-8?B?dFR0N1c5TmV1TlVzR3NqNmtFZkY5d1FHT3kycGhXOEZzYWRwZGtEQUIvZksy?=
 =?utf-8?B?MFozSVM5b0ZzdElEdTdQSEwrTVdLTnlLVUZLSis2cjkxZGk4Z1NaY1A5WHZl?=
 =?utf-8?B?WDBXNzdOZWtRLzN5ZVBZdXJ5QzFGVTU5ckRVbTVnUkhwdmx6N3FmMnk4RGdI?=
 =?utf-8?B?dlZMalZrSFJKanN6ejJQUEMvTHc3bzgyc0h1K3BHbDhhNzB1cUlPSitsRDYv?=
 =?utf-8?B?Q3o3UHc3RDcyM3l6VHN4YUpDY2lJS2xSK1pTYUtqMlRQU09zQmlMbkRNdHda?=
 =?utf-8?B?S2JqdlFKU05RNGhwcktzQy9VSUVjK3NMRy8zb2FOalVwUWpDZjdwRnYvSkZ2?=
 =?utf-8?B?c0xkQlROcGUzWXUxUzR1Z2VWY2VLZmpKOXZFTlgwMGhoSlZRaTMxanpKNFpU?=
 =?utf-8?B?MVZsN0xzeE9XMTBUZkVBdDJCOFV4Q1VtUWs5a05oelBPY2haT1F5Vzh1Zjdh?=
 =?utf-8?B?d0lUSW5Ib0pEUGFqMENzdEIzMzlsdnVLR3FBYWZ6WUxWcUVzVWNEcWx1Tk5V?=
 =?utf-8?B?R0pHU1g4UEpNQlJuZU5ZSVoxdUxxNDdQUmtHVDBxVnY5eXdMbU93YXYrb1NR?=
 =?utf-8?B?V0FoNzl0N1VIVjJYQ0E3L2lGYTNxV2xTWTJCaU81QVJDNWZaQ2pPa09mZnFC?=
 =?utf-8?B?TU94L2RmNU5leHpoV2xvYjVpT1ZtTDloQ0hZaGVtaFFZRGwrTGczSjdkNFI1?=
 =?utf-8?B?RlFKRzNpKy8xM2tUcXFZWDFjZEYweG4xaFFXRU1Dc2ZudlpmM2szb3huaVls?=
 =?utf-8?B?K3NJTWtCWHd0L2ROVGhYRXBQeHdiWndrYStra0czbnphbUpEMzBJcjV6ZnR3?=
 =?utf-8?B?WGVqTDdFTkFxc0d2WDJ1bW5zYWVqdGY5VUxKNFZkZGQvWGwzNHkya2F6YVdM?=
 =?utf-8?B?ekNVWi9EbmZBaHlrNjZ1VXlQc1pVdnBSM1ZYc3JXM2V0SU9IM0hDTVgxbXV1?=
 =?utf-8?Q?D4OUkzdAtOn/ovUHKSw8NMk=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 36db68a6-3e00-4e0e-a488-08d9d18a9b17
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB5598.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jan 2022 03:05:49.0782
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HD24VtZTuBYtGegB/bwnHarrBBlKG+voull79U7FzgxMTjo/wcAlcNMAbYPIR5Bd/eNZtby1K90PQLnm33QGeA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5662
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   c9e6606c7fe92b50a02ce51dda82586ebdf99b48
commit: 65662a8dcdd01342b71ee44234bcfd0162e195af i40e: Fix logic of disabling queues
date:   5 months ago
config: x86_64-randconfig-c007-20220101 (https://download.01.org/0day-ci/archive/20220104/202201040200.QGI49OIz-lkp@intel.com/config)
compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project c054402170cd8466683a20385befc0523aba3359)
reproduce (this is a W=1 build):
         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
         chmod +x ~/bin/make.cross
         # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=65662a8dcdd01342b71ee44234bcfd0162e195af
         git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
         git fetch --no-tags linus master
         git checkout 65662a8dcdd01342b71ee44234bcfd0162e195af
         # save the config file to linux build tree
         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross ARCH=x86_64 clang-analyzer

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


clang-analyzer warnings: (new ones prefixed by >>)

 >> drivers/net/ethernet/intel/i40e/i40e_main.c:4643:2: warning: Value stored to 'pf_q' is never read [clang-analyzer-deadcode.DeadStores]
            pf_q = vsi->base_queue;
            ^      ~~~~~~~~~~~~~~~

vim +/pf_q +4643 drivers/net/ethernet/intel/i40e/i40e_main.c

65662a8dcdd013 Arkadiusz Kubalewski 2021-04-29  4616
3aa7b74dbeedfb Filip Sadowski       2016-10-11  4617  /**
3aa7b74dbeedfb Filip Sadowski       2016-10-11  4618   * i40e_vsi_stop_rings - Stop a VSI's rings
3aa7b74dbeedfb Filip Sadowski       2016-10-11  4619   * @vsi: the VSI being configured
3aa7b74dbeedfb Filip Sadowski       2016-10-11  4620   **/
3aa7b74dbeedfb Filip Sadowski       2016-10-11  4621  void i40e_vsi_stop_rings(struct i40e_vsi *vsi)
3aa7b74dbeedfb Filip Sadowski       2016-10-11  4622  {
65662a8dcdd013 Arkadiusz Kubalewski 2021-04-29  4623  	struct i40e_pf *pf = vsi->back;
65662a8dcdd013 Arkadiusz Kubalewski 2021-04-29  4624  	int pf_q, err, q_end;
65662a8dcdd013 Arkadiusz Kubalewski 2021-04-29  4625
3480756f2cb93c Jacob Keller         2017-04-13  4626  	/* When port TX is suspended, don't wait */
0da36b9774cc24 Jacob Keller         2017-04-19  4627  	if (test_bit(__I40E_PORT_SUSPENDED, vsi->back->state))
3480756f2cb93c Jacob Keller         2017-04-13  4628  		return i40e_vsi_stop_rings_no_wait(vsi);
3480756f2cb93c Jacob Keller         2017-04-13  4629
65662a8dcdd013 Arkadiusz Kubalewski 2021-04-29  4630  	q_end = vsi->base_queue + vsi->num_queue_pairs;
65662a8dcdd013 Arkadiusz Kubalewski 2021-04-29  4631  	for (pf_q = vsi->base_queue; pf_q < q_end; pf_q++)
65662a8dcdd013 Arkadiusz Kubalewski 2021-04-29  4632  		i40e_pre_tx_queue_cfg(&pf->hw, (u32)pf_q, false);
65662a8dcdd013 Arkadiusz Kubalewski 2021-04-29  4633
65662a8dcdd013 Arkadiusz Kubalewski 2021-04-29  4634  	for (pf_q = vsi->base_queue; pf_q < q_end; pf_q++) {
65662a8dcdd013 Arkadiusz Kubalewski 2021-04-29  4635  		err = i40e_control_wait_rx_q(pf, pf_q, false);
65662a8dcdd013 Arkadiusz Kubalewski 2021-04-29  4636  		if (err)
65662a8dcdd013 Arkadiusz Kubalewski 2021-04-29  4637  			dev_info(&pf->pdev->dev,
65662a8dcdd013 Arkadiusz Kubalewski 2021-04-29  4638  				 "VSI seid %d Rx ring %d dissable timeout\n",
65662a8dcdd013 Arkadiusz Kubalewski 2021-04-29  4639  				 vsi->seid, pf_q);
65662a8dcdd013 Arkadiusz Kubalewski 2021-04-29  4640  	}
65662a8dcdd013 Arkadiusz Kubalewski 2021-04-29  4641
65662a8dcdd013 Arkadiusz Kubalewski 2021-04-29  4642  	msleep(I40E_DISABLE_TX_GAP_MSEC);
65662a8dcdd013 Arkadiusz Kubalewski 2021-04-29 @4643  	pf_q = vsi->base_queue;
65662a8dcdd013 Arkadiusz Kubalewski 2021-04-29  4644  	for (pf_q = vsi->base_queue; pf_q < q_end; pf_q++)
65662a8dcdd013 Arkadiusz Kubalewski 2021-04-29  4645  		wr32(&pf->hw, I40E_QTX_ENA(pf_q), 0);
65662a8dcdd013 Arkadiusz Kubalewski 2021-04-29  4646
65662a8dcdd013 Arkadiusz Kubalewski 2021-04-29  4647  	i40e_vsi_wait_queues_disabled(vsi);
3aa7b74dbeedfb Filip Sadowski       2016-10-11  4648  }
3aa7b74dbeedfb Filip Sadowski       2016-10-11  4649

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
