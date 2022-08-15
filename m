Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 793635927A0
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Aug 2022 03:56:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229590AbiHOB4A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Aug 2022 21:56:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbiHOBz6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Aug 2022 21:55:58 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 250B662ED
        for <linux-kernel@vger.kernel.org>; Sun, 14 Aug 2022 18:55:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660528557; x=1692064557;
  h=message-id:date:subject:references:to:cc:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Q+YFeVgd2QeTLlsaCCJ1bHPICHeF+q4z1NIn2iqyyh8=;
  b=alJ0UInKjKukgE5WeOE+be+8RgYSCJlMIDhovTHXOjxK91j/k3eG+PaK
   pHLjmk6C0yduPipDt+Bi7JuxvR5x3Tgayz/4txR/3mM9J2iKNX5T8NW6T
   KMhLB3Hzohp6Q5VvxEu/A9xzL7lDs7KgTUXCGMepSFFtpcaQG8qqeh4J4
   n61BiqT1+YAqCTilUQuxdX00uk3iZrA3fYgPGipW8I8MAkTVVGDpsAdCY
   ucxzyVrSnYX7V/1aEfYtRGtjP/VC1afoTjAwyP+ZxQq442S1hdPEAwBZW
   C+5niL7SjmYNB3fTMxulRa5numWI3E1uZVj/InxKYQX9imgWsVzjrXxMM
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10439"; a="292667222"
X-IronPort-AV: E=Sophos;i="5.93,237,1654585200"; 
   d="scan'208";a="292667222"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Aug 2022 18:55:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,237,1654585200"; 
   d="scan'208";a="606501471"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga002.jf.intel.com with ESMTP; 14 Aug 2022 18:55:51 -0700
Received: from orsmsx608.amr.corp.intel.com (10.22.229.21) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Sun, 14 Aug 2022 18:55:51 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx608.amr.corp.intel.com (10.22.229.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28 via Frontend Transport; Sun, 14 Aug 2022 18:55:51 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.109)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.28; Sun, 14 Aug 2022 18:55:51 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hqYUtzeX3/kgJ91tl2G/1ZjrUQO/298PuAbZATqePfoChbDFwvSK2QwfuspEA596kdddeDZIfSANyNyakpGvNlo6Frk/6W+U7yrdNN9YxJsWRtoUzyZTQE4RrUEEdUgDRLJevtwFdFWsbs0OV0ItO2bqun+7XCNCqAY1gk8mOoSuKEN1fSGKW4AqPq0whTiaeyOayxMNn8xppb9vwQdZO5qCl7Gga5ycZ/WDXZ4XtNV6e2JrjGYr0y+t+wV/IRzAVFag59aPx+ZQIoFpLzBzDyTHS0eoalEOrGHIZ08+HRaR+tKVrUM/3ftG50KX/MWEnTyEUVKL8Q3Bm1cd84X86Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ha+ZalyytA1CkXH6ZBCTDKvfJq+F7S2iMjdNf1CdTCA=;
 b=NK6AmgS/CqND0CczoD4tWDEJphXiwTGEZWq7t6Wf154i6TviQUUbFeOhuYmVD3XARYBqVJ+GOCoALMXcNlBieoS3w6GCvb3s1tXLwOojROq0vLKb0AlVttN/h+86e/t+Q3IB6SN335NCJzC6tPV6iS9NRQxXBwOegsayPrYoj/7Dm2ihYOYWCma6wlcSeJ3t7NfKRRUZ7LQn2QpHuZHOpD0C5Y38HxGc9CdV5nx20aXURB76N3x4g2CSiAaNeq6uHc3pBetwlqbTQevzerwsSEIFIih8tMmb/9XFn5b/RIrAAjqCD3/sL6w6j1MkLYRVJuqQAQWcXMXXeY1DAHzQzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MW4PR11MB5933.namprd11.prod.outlook.com (2603:10b6:303:16a::15)
 by CY4PR11MB1352.namprd11.prod.outlook.com (2603:10b6:903:2a::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.25; Mon, 15 Aug
 2022 01:55:48 +0000
Received: from MW4PR11MB5933.namprd11.prod.outlook.com
 ([fe80::5d19:fbdf:562:ac80]) by MW4PR11MB5933.namprd11.prod.outlook.com
 ([fe80::5d19:fbdf:562:ac80%6]) with mapi id 15.20.5525.010; Mon, 15 Aug 2022
 01:55:48 +0000
Message-ID: <25d3bff8-4331-73be-f1ff-8c922f5028c5@intel.com>
Date:   Mon, 15 Aug 2022 09:55:40 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.12.0
Subject: [hverkuil-media-tree:tegrav8 2/7]
 drivers/media/i2c/tc358840.c:1647:3: warning: Value stored to 'have_hdcp' is
 never read [clang-analyzer-deadcode.DeadStores]
References: <202208131429.45nzEuBD-lkp@intel.com>
Content-Language: en-US
To:     Hans Verkuil <hverkuil@xs4all.nl>
CC:     <llvm@lists.linux.dev>, <kbuild-all@lists.01.org>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
From:   kernel test robot <yujie.liu@intel.com>
In-Reply-To: <202208131429.45nzEuBD-lkp@intel.com>
X-Forwarded-Message-Id: <202208131429.45nzEuBD-lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR01CA0110.apcprd01.prod.exchangelabs.com
 (2603:1096:4:40::14) To MW4PR11MB5933.namprd11.prod.outlook.com
 (2603:10b6:303:16a::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 825b1b38-8b3c-4c97-4721-08da7e614653
X-MS-TrafficTypeDiagnostic: CY4PR11MB1352:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qi3UPmBI6OHhIxdqiwYLhieLs5+2eWq66KZRRrWovupCdGGKP2SDi1zenTlme4/U0WArczFXn1Jpr7t4NNQhs4cxs2cEsRbhOBDhP3DUuac5Ee0zWqg4912ekhnbxbr8D5lH7yPzlJNWQNvP/MOUDmCwHVtwf+YUyPccCT3wN+Dbu4DW9URPQk0mILYfnoOQ7R9RAac5Cli+ULKfBNMeHuQg5LIGRwe6lcP8SyCYNi67q6hQcj7YWTHtBUudCcplse1px6UfUavnqTOMJV9htVuHWjYCmH+yLZnm/WpVOQNaoJG9dp9o5GyumaO9Lx7E+WDtIciKmDxlP+EiR7vevGkifRsk2peC5BTd8Sz+Y3Iy6n5PqzpZaH0jxlCirnTArZq1YUyTjdZ2sHaikxN9qq+Lf7h8LaSiq86sFXRkZWPLZE60KhqYE9ivXTt1zyID5OEkqFvE0pM3wvxhHHp+40Er36SmEQ+ejaBcYrtHQi050P7wphypjAos9HOz323CntoNrUMzCBSN3wnlXHMNABkpLFaBQrynP/tYpxVPFub3D61Xtq0zmg5Gn082CaHDmmW0X42kk2meqp0aZIRVSQPBI0vKuQCdM58pB9qP+J+WOKxZt7Nx4I4iCzIvloW03ONOoiE6/s2ea9AGEiVWqn5byGLOt/K2U1uQ3XseF8dC6OUiHNf+wER5HHma3UL0TnGMqwGaIWu0h94duCS+Z8OkURqEiAnDlR6WaxejRD/y9QGtuJ7+MWiun4mfHMiRXc2jozOJsxi/a73AxQ33BUorn9nXLMfzCIdbNDBKDgu+4Qs8Zj0+8aKwsth1S725a+ONyCF9Hs8ZW2IJfrJh4ppCxpDXIuJdicHIHsZFnHMUSA8BPYogJTGIHE3wMwgoQNBMrMy+cHM9R1PM7QiWuA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR11MB5933.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(346002)(366004)(376002)(136003)(396003)(39860400002)(8936002)(83380400001)(8676002)(6512007)(26005)(478600001)(186003)(6486002)(2616005)(4326008)(6916009)(316002)(36756003)(31686004)(66556008)(66476007)(66946007)(30864003)(82960400001)(5660300002)(2906002)(41300700001)(966005)(31696002)(6506007)(6666004)(86362001)(38100700002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Q2Y1c0ppQlBneHN3eGFmUVlsQkc2aWpIZ09JUlloNGcrMDlmbDNXRnNvMnRV?=
 =?utf-8?B?U2wxbnRTSXVPcHNZZ2dDMUxiVTNnV2tFVjc0UmNpUjJWWjhsZDBtVkxZa1gz?=
 =?utf-8?B?TThoaTM0WDNJcllYR3dKNVZkbTNRUHZhVDZ3SXVkanUwb29WODdIL2hmTXEr?=
 =?utf-8?B?aGVjWEw3ZWJPclBYeW41ZzlITzZCVFVKbnBBdUx1UGdIWGVmZHRLdlNidjU3?=
 =?utf-8?B?WnFWaEhVUDJFbXZGZzdxU1pPRzFNbU1nMjNTa3NDbUNLeDJUdDRSWWxCZWhQ?=
 =?utf-8?B?M0hVdll4QXhWcGhweUJUZHhpVjBkWGFaTzR5K3lScXlUZCtldVlXVHRuOXJ6?=
 =?utf-8?B?SmdxQWN4WVhaSU1wN25OZkQxSnZwUVprOTUySFlNWFI5MjQ5MVozNzB3SnNj?=
 =?utf-8?B?VjdBU203RENLVU80Qzh4NEhCaFQ5MjJDT0Z5dFY1dHMxSzFTcmJWeEZuUWIv?=
 =?utf-8?B?b0J5MmFxVXhMa1RVTW1UMmEvTEZOVWJNYXBKeUk2N0VRazJQNGxRcXhRVVBR?=
 =?utf-8?B?U0lrSzcvelQ0Tmo2SjYwcEhEa28vdklmc2lReWcrd2haV1p5K1NnMUp3RWhz?=
 =?utf-8?B?WGFUcmp2YzRQSTRCaXNyTXZwdTFVY0pxcmlDaVJ3bXRXMWxCaHloQ0hJU1c5?=
 =?utf-8?B?SEtRVGQ0Yy85bnNHR28veG9adTRFd3BJMHVFNklnVW1xQmlzVkRoWnpUYllZ?=
 =?utf-8?B?WkRZYkkza2ljcDFCRDBqWjU3Vkk1MUgrTmdoYjBrbFNpQTRKSFRKVktQU0pr?=
 =?utf-8?B?RTg3SjVKUlRSWEdsQkRYS3pjeGovUjFZeitFc3lUd2d3SWRBalE3OThsQ2dS?=
 =?utf-8?B?Y2hiZ3lWcCszcWdvaXp4blJna293N3lGakZUQUlzVXhQSHd6QW5vQmR5blVS?=
 =?utf-8?B?U3E4bk5MTDg5WXRKNEZTSEthRHVDV0REQXJ0UjlmSVV1cnZkWUxKcjQzZm1a?=
 =?utf-8?B?Q3lpcW50WnROY1NjektTUi8vSU90dGd0V2NvYUg4N0V3emc5TXdVaDM4am9t?=
 =?utf-8?B?WGxhSFpkT3hsaERadkFMOUJyWVVVZjhQUm15TVZoWmxRTzA3dGJkZHRMcWtQ?=
 =?utf-8?B?N3RuNm9TTDJseHdTcGFOUGxscmk0d0lobUlZcTcra0NGT3VPMFVQRDc5Mm5Z?=
 =?utf-8?B?clVFek1Sek1HaHVVWExKbnNxeW5MREZmWnRFc29RMXpkY2xLcnhmb3pPaTd0?=
 =?utf-8?B?L3hxRkUzRmJ4OEpRSHJMVlVBRkkrbkNrWDhnZmlFdzVxajRVR1N4bGN1Rkln?=
 =?utf-8?B?Q3BGMU1uRWE1WVlKVWdnYUNvT0JQU1ZvSVlXdWRFRlpyeE0wVHJXUFM4T3Bz?=
 =?utf-8?B?NWVlNjMyRFBLbUZmQjVKUGt2Tk14NndJZzVESUhKV3l0bG5BclJiM2NSaHJ1?=
 =?utf-8?B?ZTR2KzZaUXhBend2b0ZBWEl2U0k0eEFFUEU3UkFnTkFjVXFBZml1U0lNdnJW?=
 =?utf-8?B?MVZtNXZVTkpwaU1vS0ZpNkh1YmxtK2lmN3BIL0xuL3Uyc04xRWFxb2w4V1NX?=
 =?utf-8?B?QVN2WjZGMytoYm14UnQ1WEZVUXRJTXJjb0Mwc3JVYmRYQXVkOFYxcG44NnVv?=
 =?utf-8?B?Q1NpOWhtU2o5UDhPcnlFeVR6enhQRm5oTXhBOXpGY2pXd3V2QnF4YTVCSnNq?=
 =?utf-8?B?aTJEcWJpYmNsQVgrQmNvdk5JWkd6VlVsSzJJS0NnLzM3L1VXUTg1WXBoTjhH?=
 =?utf-8?B?RmZMMTVVZFZYMk9sYS9IL0lmSUFWZ083Skh3TjRpeDVjVmM3L1o2bjRneWRB?=
 =?utf-8?B?YkExMlNCTGVxYWxveG1TZkxCVzl3QjNSdGM4Q3E0cW9Hci9NMVppZm51aytB?=
 =?utf-8?B?U1hETkFTZWNvUlZZZXUxTmhXTFpTUUdSL1RQT1BxSWcrRXgzYnBteTNCZ3BI?=
 =?utf-8?B?em5xREhFajRBdTdobWg2RGNrdUdla0orS0hsb0wzTU9Jb2VTTzQweWpseUVs?=
 =?utf-8?B?cVQwMzlDRGVRcCtpekdJaFpIdkllL0xRQkl0UWhZcEwxTzJmUlpQS3JZTU1S?=
 =?utf-8?B?Nnp0aTh2V1p1VXh6SmlZT09WQy84NXh5N2ZXOFNlQ2lFOEpjRTA4TnByVEdq?=
 =?utf-8?B?N0ZjQld2eXZHOHE4NkVHZWY2MUF5a2pTMmF6NmZ4Q1JycmlqY3VscHZsRTk1?=
 =?utf-8?Q?nsNXEUvtgXogY4XemM+0e/QuU?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 825b1b38-8b3c-4c97-4721-08da7e614653
X-MS-Exchange-CrossTenant-AuthSource: MW4PR11MB5933.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2022 01:55:48.6429
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qqkHeAubYwBLRMXk9rU7QNDohKrwYpZGeBFqwcrARI41aPDbZOgfJweQc2o1LcwcQt8aELp+6AtikcPUQt0czg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR11MB1352
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   git://linuxtv.org/hverkuil/media_tree.git tegrav8
head:   386823032a34ce7926c18033b0ca34de9145a206
commit: f51f9140626da0e72ade6bd437ac2fe13e9b0425 [2/7] tc358840: add Toshiba tc358840 HDMI-to-CSI bridge.
config: mips-randconfig-c004-20220808 (https://download.01.org/0day-ci/archive/20220813/202208131429.45nzEuBD-lkp@intel.com/config)
compiler: clang version 16.0.0 (https://github.com/llvm/llvm-project 5f1c7e2cc5a3c07cbc2412e851a7283c1841f520)
reproduce (this is a W=1 build):
         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
         chmod +x ~/bin/make.cross
         # install mips cross compiling tool for clang build
         # apt-get install binutils-mipsel-linux-gnu
         git remote add hverkuil-media-tree git://linuxtv.org/hverkuil/media_tree.git
         git fetch --no-tags hverkuil-media-tree tegrav8
         git checkout f51f9140626da0e72ade6bd437ac2fe13e9b0425
         # save the config file
         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross ARCH=mips clang-analyzer

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <yujie.liu@intel.com>

clang-analyzer warnings: (new ones prefixed by >>)

 >> drivers/media/i2c/tc358840.c:1647:3: warning: Value stored to 'have_hdcp' is never read [clang-analyzer-deadcode.DeadStores]
                    have_hdcp = !(i2c_rd8(sd, HDCP_MODE) &
                    ^           ~~~~~~~~~~~~~~~~~~~~~~~~~~

vim +/have_hdcp +1647 drivers/media/i2c/tc358840.c

f51f9140626da0 Hans Verkuil 2020-02-21  1608
f51f9140626da0 Hans Verkuil 2020-02-21  1609  static void tc358840_delayed_work_poll(struct work_struct *work)
f51f9140626da0 Hans Verkuil 2020-02-21  1610  {
f51f9140626da0 Hans Verkuil 2020-02-21  1611  	struct delayed_work *dwork = to_delayed_work(work);
f51f9140626da0 Hans Verkuil 2020-02-21  1612  	struct tc358840_state *state = container_of(dwork,
f51f9140626da0 Hans Verkuil 2020-02-21  1613  		struct tc358840_state, delayed_work_poll);
f51f9140626da0 Hans Verkuil 2020-02-21  1614  	struct v4l2_subdev *sd = &state->sd;
f51f9140626da0 Hans Verkuil 2020-02-21  1615  	u8 sys_status;
f51f9140626da0 Hans Verkuil 2020-02-21  1616  	bool have_5v;
f51f9140626da0 Hans Verkuil 2020-02-21  1617  	bool have_tmds;
f51f9140626da0 Hans Verkuil 2020-02-21  1618  	bool have_sync;
f51f9140626da0 Hans Verkuil 2020-02-21  1619  	bool have_signal;
f51f9140626da0 Hans Verkuil 2020-02-21  1620  	bool have_hdcp;
f51f9140626da0 Hans Verkuil 2020-02-21  1621  	unsigned int format_change = 0;
f51f9140626da0 Hans Verkuil 2020-02-21  1622
f51f9140626da0 Hans Verkuil 2020-02-21  1623  	mutex_lock(&state->lock);
f51f9140626da0 Hans Verkuil 2020-02-21  1624
f51f9140626da0 Hans Verkuil 2020-02-21  1625  	sys_status = i2c_rd8(sd, SYS_STATUS);
f51f9140626da0 Hans Verkuil 2020-02-21  1626  	have_5v = state->test_pattern || (sys_status & MASK_S_DDC5V);
f51f9140626da0 Hans Verkuil 2020-02-21  1627  	have_tmds = state->test_pattern || (sys_status & MASK_S_TMDS);
f51f9140626da0 Hans Verkuil 2020-02-21  1628  	have_sync = state->test_pattern || (sys_status & MASK_S_SYNC);
f51f9140626da0 Hans Verkuil 2020-02-21  1629  	have_signal = have_5v && have_tmds && have_sync;
f51f9140626da0 Hans Verkuil 2020-02-21  1630  	have_hdcp = have_signal ? (sys_status & MASK_S_HDCP) : false;
f51f9140626da0 Hans Verkuil 2020-02-21  1631
f51f9140626da0 Hans Verkuil 2020-02-21  1632  	tc358840_check_5v(sd, have_5v);
f51f9140626da0 Hans Verkuil 2020-02-21  1633  	if (have_hdcp) {
f51f9140626da0 Hans Verkuil 2020-02-21  1634  		/*
f51f9140626da0 Hans Verkuil 2020-02-21  1635  		 * MASK_S_HDCP can be 1 for a short time when connecting
f51f9140626da0 Hans Verkuil 2020-02-21  1636  		 * or disconnecting: the HDCP authentication will kick in
f51f9140626da0 Hans Verkuil 2020-02-21  1637  		 * when that happens and thus MASK_S_HDCP becomes 1 until
f51f9140626da0 Hans Verkuil 2020-02-21  1638  		 * the authentication fails and it is cleared again.
f51f9140626da0 Hans Verkuil 2020-02-21  1639  		 *
f51f9140626da0 Hans Verkuil 2020-02-21  1640  		 * So if it is set, then double check that the HDCP_MODE
f51f9140626da0 Hans Verkuil 2020-02-21  1641  		 * is in manual authentication mode, because then we know
f51f9140626da0 Hans Verkuil 2020-02-21  1642  		 * the authentication will fail and this is just a glitch.
f51f9140626da0 Hans Verkuil 2020-02-21  1643  		 *
f51f9140626da0 Hans Verkuil 2020-02-21  1644  		 * Don't rely on some global setting, actually read the
f51f9140626da0 Hans Verkuil 2020-02-21  1645  		 * register here. This in case someone has been hacking.
f51f9140626da0 Hans Verkuil 2020-02-21  1646  		 */
f51f9140626da0 Hans Verkuil 2020-02-21 @1647  		have_hdcp = !(i2c_rd8(sd, HDCP_MODE) &
f51f9140626da0 Hans Verkuil 2020-02-21  1648  			      MASK_MANUAL_AUTHENTICATION);
f51f9140626da0 Hans Verkuil 2020-02-21  1649  	}
f51f9140626da0 Hans Verkuil 2020-02-21  1650
f51f9140626da0 Hans Verkuil 2020-02-21  1651  	if (!have_5v) {
f51f9140626da0 Hans Verkuil 2020-02-21  1652  		state->invalid_eq_bypass[0] = false;
f51f9140626da0 Hans Verkuil 2020-02-21  1653  		state->invalid_eq_bypass[1] = false;
f51f9140626da0 Hans Verkuil 2020-02-21  1654  	}
f51f9140626da0 Hans Verkuil 2020-02-21  1655  	if (state->test_pattern) {
f51f9140626da0 Hans Verkuil 2020-02-21  1656  		state->found_stable_signal = true;
f51f9140626da0 Hans Verkuil 2020-02-21  1657  		state->status = STATUS_STABLE_SIGNAL;
f51f9140626da0 Hans Verkuil 2020-02-21  1658  	} else {
f51f9140626da0 Hans Verkuil 2020-02-21  1659  		u8 sys_int = i2c_rd8(sd, SYS_INT);
f51f9140626da0 Hans Verkuil 2020-02-21  1660  		u8 clk_int = i2c_rd8(sd, CLK_INT);
f51f9140626da0 Hans Verkuil 2020-02-21  1661  		u8 misc_int = i2c_rd8(sd, MISC_INT);
f51f9140626da0 Hans Verkuil 2020-02-21  1662  		bool was_stable = state->found_stable_signal;
f51f9140626da0 Hans Verkuil 2020-02-21  1663
f51f9140626da0 Hans Verkuil 2020-02-21  1664  		i2c_wr8(sd, MISC_INT, 0xff);
f51f9140626da0 Hans Verkuil 2020-02-21  1665  		i2c_wr8(sd, CLK_INT, 0xff);
f51f9140626da0 Hans Verkuil 2020-02-21  1666  		i2c_wr8(sd, SYS_INT, 0xff);
f51f9140626da0 Hans Verkuil 2020-02-21  1667  		v4l2_dbg(2, debug, sd,
f51f9140626da0 Hans Verkuil 2020-02-21  1668  			 "%s: sys_stat: %02x misc_int: %02x clk_int: %02x sys_int: %02x eq_byps: %s\n",
f51f9140626da0 Hans Verkuil 2020-02-21  1669  			 __func__, sys_status, misc_int, clk_int, sys_int,
f51f9140626da0 Hans Verkuil 2020-02-21  1670  			 state->eq_bypass ? "on" : "off");
f51f9140626da0 Hans Verkuil 2020-02-21  1671
f51f9140626da0 Hans Verkuil 2020-02-21  1672  		if (!have_sync)
f51f9140626da0 Hans Verkuil 2020-02-21  1673  			format_change |= 1;
f51f9140626da0 Hans Verkuil 2020-02-21  1674  		if (sys_int & (MASK_DVI | MASK_HDMI))
f51f9140626da0 Hans Verkuil 2020-02-21  1675  			format_change |= 2;
f51f9140626da0 Hans Verkuil 2020-02-21  1676  		if (clk_int & (MASK_IN_DE_CHG))
f51f9140626da0 Hans Verkuil 2020-02-21  1677  			format_change |= 4;
f51f9140626da0 Hans Verkuil 2020-02-21  1678  		if (misc_int & (MASK_SYNC_CHG))
f51f9140626da0 Hans Verkuil 2020-02-21  1679  			format_change |= 8;
f51f9140626da0 Hans Verkuil 2020-02-21  1680
f51f9140626da0 Hans Verkuil 2020-02-21  1681  		if (sys_int & MASK_HDMI) {
f51f9140626da0 Hans Verkuil 2020-02-21  1682  			v4l2_dbg(1, debug, sd, "%s: DVI->HDMI change detected\n",
f51f9140626da0 Hans Verkuil 2020-02-21  1683  				 __func__);
f51f9140626da0 Hans Verkuil 2020-02-21  1684
f51f9140626da0 Hans Verkuil 2020-02-21  1685  			i2c_wr8(sd, APPL_CTL, MASK_APLL_CPCTL_NORMAL | MASK_APLL_ON);
f51f9140626da0 Hans Verkuil 2020-02-21  1686  		}
f51f9140626da0 Hans Verkuil 2020-02-21  1687  		if (sys_int & MASK_DVI) {
f51f9140626da0 Hans Verkuil 2020-02-21  1688  			v4l2_dbg(1, debug, sd, "%s: HDMI->DVI change detected\n",
f51f9140626da0 Hans Verkuil 2020-02-21  1689  				 __func__);
f51f9140626da0 Hans Verkuil 2020-02-21  1690  		}
f51f9140626da0 Hans Verkuil 2020-02-21  1691  		if (!have_signal) {
f51f9140626da0 Hans Verkuil 2020-02-21  1692  			if (state->status != STATUS_FIND_SIGNAL)
f51f9140626da0 Hans Verkuil 2020-02-21  1693  				v4l2_info(sd, "no signal for EQ_BYPS %d\n",
f51f9140626da0 Hans Verkuil 2020-02-21  1694  					  state->eq_bypass);
f51f9140626da0 Hans Verkuil 2020-02-21  1695  			state->status = STATUS_FIND_SIGNAL;
f51f9140626da0 Hans Verkuil 2020-02-21  1696  			state->found_signal_cnt[0] = 0;
f51f9140626da0 Hans Verkuil 2020-02-21  1697  			state->found_signal_cnt[1] = 0;
f51f9140626da0 Hans Verkuil 2020-02-21  1698  			if (state->enabled)
f51f9140626da0 Hans Verkuil 2020-02-21  1699  				enable_stream(sd, false);
f51f9140626da0 Hans Verkuil 2020-02-21  1700  			if (state->found_stable_signal) {
f51f9140626da0 Hans Verkuil 2020-02-21  1701  				state->found_stable_signal = false;
f51f9140626da0 Hans Verkuil 2020-02-21  1702  				v4l2_subdev_notify_event(sd, &tc358840_ev_fmt);
f51f9140626da0 Hans Verkuil 2020-02-21  1703  				v4l2_info(sd, "event: no signal (SYS_STATUS 0x%02x)\n",
f51f9140626da0 Hans Verkuil 2020-02-21  1704  					  sys_status);
f51f9140626da0 Hans Verkuil 2020-02-21  1705  			}
f51f9140626da0 Hans Verkuil 2020-02-21  1706  			state->detected_timings.bt.width = 0;
f51f9140626da0 Hans Verkuil 2020-02-21  1707  		}
f51f9140626da0 Hans Verkuil 2020-02-21  1708  		/*
f51f9140626da0 Hans Verkuil 2020-02-21  1709  		 * Reset the HDMI PHY to try to trigger proper lock on the
f51f9140626da0 Hans Verkuil 2020-02-21  1710  		 * incoming video format. Erase BKSV to prevent that old keys
f51f9140626da0 Hans Verkuil 2020-02-21  1711  		 * are used when a new source is connected.
f51f9140626da0 Hans Verkuil 2020-02-21  1712  		 */
f51f9140626da0 Hans Verkuil 2020-02-21  1713  		if (have_5v && (format_change & 0xa) && !have_signal) {
f51f9140626da0 Hans Verkuil 2020-02-21  1714  			if (have_tmds)
f51f9140626da0 Hans Verkuil 2020-02-21  1715  				v4l2_dbg(was_stable ? 0 : 1, debug, sd,
f51f9140626da0 Hans Verkuil 2020-02-21  1716  					 "reset due to format_change (%x)\n",
f51f9140626da0 Hans Verkuil 2020-02-21  1717  					 format_change);
f51f9140626da0 Hans Verkuil 2020-02-21  1718  			tc358840_reset_phy(sd);
f51f9140626da0 Hans Verkuil 2020-02-21  1719  		}
f51f9140626da0 Hans Verkuil 2020-02-21  1720  	}
f51f9140626da0 Hans Verkuil 2020-02-21  1721
f51f9140626da0 Hans Verkuil 2020-02-21  1722  	if (have_signal) {
f51f9140626da0 Hans Verkuil 2020-02-21  1723  		struct v4l2_dv_timings timings = { };
f51f9140626da0 Hans Verkuil 2020-02-21  1724
f51f9140626da0 Hans Verkuil 2020-02-21  1725  		/*
f51f9140626da0 Hans Verkuil 2020-02-21  1726  		 * If we don't have detected_timings, or something changed, then
f51f9140626da0 Hans Verkuil 2020-02-21  1727  		 * detect timings.
f51f9140626da0 Hans Verkuil 2020-02-21  1728  		 */
f51f9140626da0 Hans Verkuil 2020-02-21  1729  		if (format_change || !state->detected_timings.bt.width)
f51f9140626da0 Hans Verkuil 2020-02-21  1730  			tc358840_get_detected_timings(sd, &timings);
f51f9140626da0 Hans Verkuil 2020-02-21  1731  		else
f51f9140626da0 Hans Verkuil 2020-02-21  1732  			timings = state->detected_timings;
f51f9140626da0 Hans Verkuil 2020-02-21  1733
f51f9140626da0 Hans Verkuil 2020-02-21  1734  		/*
f51f9140626da0 Hans Verkuil 2020-02-21  1735  		 * Store newly detected timings (if any) if we detect timings
f51f9140626da0 Hans Verkuil 2020-02-21  1736  		 * for the first time, or if the sync toggled, or if the
f51f9140626da0 Hans Verkuil 2020-02-21  1737  		 * DVI/HDMI mode changed.
f51f9140626da0 Hans Verkuil 2020-02-21  1738  		 */
f51f9140626da0 Hans Verkuil 2020-02-21  1739  		if (!state->detected_timings.bt.width || (format_change & 3)) {
f51f9140626da0 Hans Verkuil 2020-02-21  1740  			state->detected_timings = timings;
f51f9140626da0 Hans Verkuil 2020-02-21  1741  		/*
f51f9140626da0 Hans Verkuil 2020-02-21  1742  		 * Silently accept SYNC/DE changes if the timings stay the same,
f51f9140626da0 Hans Verkuil 2020-02-21  1743  		 * i.e. if only blanking changed.
f51f9140626da0 Hans Verkuil 2020-02-21  1744  		 */
f51f9140626da0 Hans Verkuil 2020-02-21  1745  		} else if (format_change &&
f51f9140626da0 Hans Verkuil 2020-02-21  1746  			   tc358840_match_dv_timings(&state->detected_timings,
f51f9140626da0 Hans Verkuil 2020-02-21  1747  						     &timings, 250000)) {
f51f9140626da0 Hans Verkuil 2020-02-21  1748  			v4l2_dbg(1, debug, sd, "ignore timings change\n");
f51f9140626da0 Hans Verkuil 2020-02-21  1749  			format_change = 0;
f51f9140626da0 Hans Verkuil 2020-02-21  1750  		} else {
f51f9140626da0 Hans Verkuil 2020-02-21  1751  			state->detected_timings = timings;
f51f9140626da0 Hans Verkuil 2020-02-21  1752  		}
f51f9140626da0 Hans Verkuil 2020-02-21  1753  		have_signal = state->detected_timings.bt.width;
f51f9140626da0 Hans Verkuil 2020-02-21  1754  	}
f51f9140626da0 Hans Verkuil 2020-02-21  1755
f51f9140626da0 Hans Verkuil 2020-02-21  1756  	if (!state->test_pattern && have_5v) {
f51f9140626da0 Hans Verkuil 2020-02-21  1757  		switch (state->status) {
f51f9140626da0 Hans Verkuil 2020-02-21  1758  		case STATUS_FIND_SIGNAL:
f51f9140626da0 Hans Verkuil 2020-02-21  1759  			tc358840_find_signal(sd, have_signal);
f51f9140626da0 Hans Verkuil 2020-02-21  1760  			break;
f51f9140626da0 Hans Verkuil 2020-02-21  1761  		case STATUS_FOUND_SIGNAL:
f51f9140626da0 Hans Verkuil 2020-02-21  1762  			tc358840_found_signal(sd, have_signal, format_change);
f51f9140626da0 Hans Verkuil 2020-02-21  1763  			break;
f51f9140626da0 Hans Verkuil 2020-02-21  1764  		case STATUS_STABLE_SIGNAL:
f51f9140626da0 Hans Verkuil 2020-02-21  1765  			tc358840_format_change(sd, have_signal, format_change);
f51f9140626da0 Hans Verkuil 2020-02-21  1766  			break;
f51f9140626da0 Hans Verkuil 2020-02-21  1767  		}
f51f9140626da0 Hans Verkuil 2020-02-21  1768  	}
f51f9140626da0 Hans Verkuil 2020-02-21  1769  	mutex_unlock(&state->lock);
f51f9140626da0 Hans Verkuil 2020-02-21  1770  	v4l2_ctrl_s_ctrl(state->tmds_present_ctrl, have_signal);
f51f9140626da0 Hans Verkuil 2020-02-21  1771  	v4l2_ctrl_s_ctrl(state->detect_tx_5v_ctrl, have_5v);
f51f9140626da0 Hans Verkuil 2020-02-21  1772  	v4l2_ctrl_s_ctrl(state->audio_present_ctrl, audio_present(sd));
f51f9140626da0 Hans Verkuil 2020-02-21  1773
f51f9140626da0 Hans Verkuil 2020-02-21  1774  	if (have_signal)
f51f9140626da0 Hans Verkuil 2020-02-21  1775  		v4l2_ctrl_s_ctrl(state->audio_sampling_rate_ctrl,
f51f9140626da0 Hans Verkuil 2020-02-21  1776  				 get_audio_sampling_rate(sd));
f51f9140626da0 Hans Verkuil 2020-02-21  1777
f51f9140626da0 Hans Verkuil 2020-02-21  1778  	if (!state->delayed_work_stop_polling)
f51f9140626da0 Hans Verkuil 2020-02-21  1779  		schedule_delayed_work(&state->delayed_work_poll, POLL_PERIOD);
f51f9140626da0 Hans Verkuil 2020-02-21  1780  }
f51f9140626da0 Hans Verkuil 2020-02-21  1781

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
