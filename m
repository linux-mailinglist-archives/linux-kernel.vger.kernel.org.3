Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 827D9571253
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 08:38:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231858AbiGLGix (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 02:38:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229846AbiGLGip (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 02:38:45 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD5A265A5;
        Mon, 11 Jul 2022 23:38:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657607923; x=1689143923;
  h=message-id:date:subject:references:to:cc:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=S44imiRBf5+e3zNgw/jao40V2AX9Qgyc+6H+9uxNsaM=;
  b=deJOP3RbeRhw5ljGWfBLTMB80hpHdlGUL8z/83av3jGKeMrVIVZiq5sX
   tEKvJCplLVU4JXzChdiSRDOwrb1abKXyDE5Ol+XtrWIJNiZ6eSlyR46OJ
   OP6H4drd9miHn98PwLJdMx73o/JDq+ArHTNPYJcqu4wIWDivQv6Ol23KV
   hMrckXMwVklPQXtaKYc2rJzSVOMd7prL4GWWrrBrYi0kv0+Kj2xwP1HBJ
   jMg/68P6dpHORrCAj09rL8n2pZevTx+EHFpDs9iNXfis5tb6L7jhhad9B
   WLVDxPAuczXhKxx2L+FEDZf7nqmue/0RYWuS8Nyb5dGfY637qkcJiMeb5
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10405"; a="264641958"
X-IronPort-AV: E=Sophos;i="5.92,265,1650956400"; 
   d="scan'208";a="264641958"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2022 23:38:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,265,1650956400"; 
   d="scan'208";a="599282578"
Received: from orsmsx604.amr.corp.intel.com ([10.22.229.17])
  by fmsmga007.fm.intel.com with ESMTP; 11 Jul 2022 23:38:40 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX604.amr.corp.intel.com (10.22.229.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Mon, 11 Jul 2022 23:38:40 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Mon, 11 Jul 2022 23:38:39 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Mon, 11 Jul 2022 23:38:39 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.173)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Mon, 11 Jul 2022 23:38:39 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Xfh35KTTBE20vH/SQ1WlLvG3v9x+TQoV+04j5Rq8gkk1OKbGBfVUHCW9qVL+deklT6RIdwPWxN3C1BRrQlF79GOoS122k5520h+DElQ6NvRosekgtMjjRxONc+HLOYEDv6DJQp37E1NF6Qa5k7422+xJcJ62l4XISSo7oZ6GBZRFWmDklmsgs3IJahH/tAI5aLpmqrwJVa2Hd3YCnjVOQYhSoWtvmyDcO6QslArGL0Eo+BudeU4FYL5QeV8wj2PSubR/esn+dHeW/+2ePnPM23UwNwdquvHTQjbpfrIiMuKBID8YJp8vXVcvTP631zRCbn56oaQWVIW4HGoN97Eg2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z7ygzHSVVWdspKXD/gd/nVnZvAT5523qeW0ZHA3a2gg=;
 b=UWBJJILBmDMxEcKQapSGjqlFfyunroGSthb0qz5n2+gHZxee6KEYoxbSGvuWBveZSuS15Cz4GiFz51T0Xz3Pz+s5iGvffJWo7lspYpWYBYhOOHcfhHhlJpPw7T7rD3hc7pKotFDq+UpfZyuyulqZ7SEqTi4Soe0E6Z0Nat8Pop/HTL0UbQG3fmT6xQyfR/9VHRLZSns1juGs8j8UP9wFZ47R13tbhyRbr0qK/Gy4EsEbceJ2fbt4TgFlnPc2HXviZLrppO4giMEJMNcIdP4HkhDE4GmGJdoVAZPJbIeqt4Ii/v54N6yrbMFXNgSscA1HtizPy+x+hgFNq9HM/ySIZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MW4PR11MB5933.namprd11.prod.outlook.com (2603:10b6:303:16a::15)
 by SN6PR11MB3120.namprd11.prod.outlook.com (2603:10b6:805:d6::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.16; Tue, 12 Jul
 2022 06:38:37 +0000
Received: from MW4PR11MB5933.namprd11.prod.outlook.com
 ([fe80::71d0:716c:7d6d:94c4]) by MW4PR11MB5933.namprd11.prod.outlook.com
 ([fe80::71d0:716c:7d6d:94c4%3]) with mapi id 15.20.5417.026; Tue, 12 Jul 2022
 06:38:37 +0000
Message-ID: <abfd747c-42e9-61df-f48d-73ded65989e3@intel.com>
Date:   Tue, 12 Jul 2022 14:38:29 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.11.0
Subject: [kvms390:pci 13/21] arch/s390/kvm/pci.h: linux/kvm_host.h is included
 more than once.
References: <202207102117.Guvcj88e-lkp@intel.com>
Content-Language: en-US
To:     Matthew Rosato <mjrosato@linux.ibm.com>
CC:     <kbuild-all@lists.01.org>, <linux-s390@vger.kernel.org>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Pierre Morel <pmorel@linux.ibm.com>
From:   kernel test robot <yujie.liu@intel.com>
In-Reply-To: <202207102117.Guvcj88e-lkp@intel.com>
X-Forwarded-Message-Id: <202207102117.Guvcj88e-lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR04CA0173.apcprd04.prod.outlook.com (2603:1096:4::35)
 To MW4PR11MB5933.namprd11.prod.outlook.com (2603:10b6:303:16a::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e7840175-5ee1-4662-c605-08da63d12684
X-MS-TrafficTypeDiagnostic: SN6PR11MB3120:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: STI0JGlQ33JLUggvXJ5kAqPtBRkaSMMevTBB4+2TraNwOtEIOpb1rkTSGfFdQxy+JNxIyhpvNSrgw+8AoubOcczS5nTrDvn9TQKyNXMX8DIRhu2V563+4jS3M2nFP7L/kBQbSaU4DPapFFxySg/lrSkwaxmNbiIzhH+yVQOHS1ukLeQQMqb5TsQ3GvBOXJq1M/p+hErSS7XGtXVbI73+AgrZLKJksVOSrqzhcgOZ5/XnrLXO2gSEfLx3tOVuR2UUgEAMKjM1CNeLQfDjR73ONqCxaiVwb7WWP9UyxxxCGPXHQQI+z9CwhZNQh3r+nTURlFrbQdEuw/vgZOtI+2+FHIPbqvugp440A9hPYMdASfp0+VhPjf3w0U8h8R++go0ma1s+FcqtAzE2YeleD5SyU2171hIwbw67STJYkpWyc5tCFHFgBG8fQRKnezfFgxrKnOjuYOlMhxaeckg7MctrZEatbwn1YZ7ZHLv/X6o+ijBoOnKU+HuYQFeOs4CX7439DSUhnsVe0Q2jIrEW5qs6RyfIVAhJelTozzkS7QkcXOW3CjS8TPEV2DvL1VQfNiox64QsplaUjMat+/ZNeFsNCT/quSg9rlcN99qDHEVF9so9Y+9YrlL4FTpWF/83+PvM0RiN9Kv3OLmwn3j1M8Q0H4zi4v7vNJYwLLf5mo6ypFh0NulwjyCICmT7O3cxFSaTU0bA5uDeQPpzen1VH3VrUb7n60AaolAQ512My+oc754RSxhBmwVpw4B2wkbKreJMMJcyffX/lKr+VXMw6AVWyoN3dBQxtE556I6ITmZRdTBky6eOf0Wh/UxNvFl6JUxTt/Swsq4lWYTamMGp00mBlvfHmUSiORZ6KURIurSwguqZyh5RVYewu25rOzNXB7qq0Kj3yMBfoMY8eKXtNqQzhr1+tsVA1EYyqL/nmihDT0o=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR11MB5933.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(136003)(39860400002)(376002)(366004)(396003)(346002)(31686004)(82960400001)(38100700002)(8936002)(6916009)(4326008)(54906003)(66946007)(8676002)(316002)(66476007)(66556008)(36756003)(31696002)(83380400001)(2906002)(478600001)(186003)(966005)(41300700001)(6486002)(26005)(6506007)(6512007)(6666004)(5660300002)(86362001)(2616005)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dmdTQit4R25BRHZQR29mamUxb1JTS2xDSjR3emc4NVp4QSszczR2ZkxnUytr?=
 =?utf-8?B?UHE0M2NWTmllRWt2cjV6OFNpbGZZKzh2ODJBU1Fyc25TMnRTNlNuUDFVZDBI?=
 =?utf-8?B?R3Q5a3VHSWtqUlVvNTRIaTBBaTVwU1htMDQrbnMxd1BKdEtxb0xlQiswY0Vx?=
 =?utf-8?B?ZzRvWTEwT1Q3dEF2MkJzK3M3Nk95Q0FWK2FtSFZFZTh0MGlvUXh4ZnlibjJo?=
 =?utf-8?B?NGI4QWY2VmMvd2xKS1BIWG5md00wU1BIODBJS1JuRXNIeTljaEVZWDR1bGtv?=
 =?utf-8?B?VktyNFZ0SkE5TFlwQ3kxR2txY3RpaUVSOWFZdVdadHZsdWpqV09GVEsxRGdy?=
 =?utf-8?B?U1Nlb0h6YjQ1RTZpb1ZSc0U3TmNGZVJySnllR3dwV3hESEpjNnlOeTNHTEI0?=
 =?utf-8?B?dG9lSTF3Y1pEdzM2NWo1cDBLbCtSb01nc0lKQ0FlamdPYUhaemNQVm5NSUI5?=
 =?utf-8?B?alBWbytKUXZycVQxbkJnQ3lwL3dnNmJoT1V0RmwxWjdrWnlaUEJzcTNiVDA0?=
 =?utf-8?B?LzFYU24xc1c0UXNaaVIrOWkyMStRZkZISUkwSktZWUJvc0wwRFdmamxqUm1V?=
 =?utf-8?B?Z0ZTUWRQWkRTTnJZZUZjSUZvZU1HcjNFQlV6TTlOVU41TXR1ekJaSnJpM2xN?=
 =?utf-8?B?dFdBSXVXUjZkNnJBYk1pT1pnOHAxcEk3cTZOeGo0aEJXMUhZa1hFSDYzZzNP?=
 =?utf-8?B?YU82d0dBOWVyWW1WWHoxWXp0YUtuNjNHLzV1aUFXNFlNcDRyb2FGKzE3OHE2?=
 =?utf-8?B?VFhxdnoyZnFEaEhxVCtWWEhqYi9Takx5ZkNBaC9qTVZwcmtlSlNqbHNZRUdv?=
 =?utf-8?B?NFdraEM2VWhkQldkeUFJY1NXdGcwM2drN0FIcWRNT3k4bXMyMVdEMWhSMy9a?=
 =?utf-8?B?ZXc1QjZqUHozY01xeVM5UGZqU1QvVmJFZUdBUjRvWG0rSDhaSFNXcDFpZ2ZZ?=
 =?utf-8?B?VjRibXM1TGVwVFNWbTZNVDlQRWF1Wk51ZElTRG4rL1hVR2ErRFBnMHBLLzlF?=
 =?utf-8?B?M0lRcnZQdFlsbkVGR21CR2hPTzRzQWUzTlBESDI3NXRIck0vVGkwbnRkU0dG?=
 =?utf-8?B?MTZvcWtGdnhIVUU1eGFOSTBveWhRUVpNU2pyM05JdG15dlE3Yjd5RWJKZnVo?=
 =?utf-8?B?SjlENGxHUlFWUHBmNXlCZThlMmJKUTh4cDMyeEl3TUVyejJQelRrV3V4WC9u?=
 =?utf-8?B?OHRKdndzSGExMmNXT2htejNqcWZBa0VWZFRuQnN2MmRmZGtxOE9sNWo0UlhQ?=
 =?utf-8?B?OHFjb20xckhibE9rQUNFd1B3eWZYbENHdXV6bTEzNHBzV1h1aUNIdXZpaEMx?=
 =?utf-8?B?OGhjQjFYSDJBZndpem9paFRhUWJxakd1VjNnWE9XNFNlSnRYME9SVTY5QXFm?=
 =?utf-8?B?SGptTkptQVh3a2wyZGFpR3RBaWFUQXJGMTQvU1laT2FiT3dZYUsrWFlpVjRD?=
 =?utf-8?B?T1RueUluaUhnckE2dWlpa1BaZ3JCdHFRRit6cEhFaW5DSExRZzhJcTN6N25Z?=
 =?utf-8?B?MkZtd2xoc3BwRTRnZitIbndOR3ZEdHEzbEtPT0p0K1ZISG1NQmhObmp0SjhS?=
 =?utf-8?B?aFFaWkFsTkxpdDl4S05kRnY3WHY0c1k2ZmtmcE0zT05vUlJITXN6Q3ZvbHpU?=
 =?utf-8?B?cXVMU2taNWpOOFlSY0FmZXNmMW8vNmtNa3A0bVU2Nkkxb1RyMGxiTXVXcEJU?=
 =?utf-8?B?b0ZrSURSNlFlaTUyODg0Qkx6ODd3Y0tPaFV0OWRvQzJDN3kyU2Y3dWs2R1FX?=
 =?utf-8?B?R1o1dUl4TzRST2MxUld4dlNyQVROSlpoTzJSMTZ5VGVhcmJqVExyOUtaZUpm?=
 =?utf-8?B?QXdSUmdscE9sYi9LN1RGSmFnVGx5a01BY2FnelZCSUpPdFlRUzBycmZCOHZz?=
 =?utf-8?B?anRQRUdpWnY2TUZKa2pwdm1OWEVYZ3JPdUJQMU0xU1B3ZlMxTUlaSTROK0Rh?=
 =?utf-8?B?TGs2T2lmYnl4U1lhRHFZRHdwWDROVGROajBmS0RzQnFMOCtCbnFDbXBRTXJQ?=
 =?utf-8?B?OUk3SzcyS0tsRnd0UWoxU1Q4WDhCaWF4OEQvakx6OW0vMW5QVmE0cndRdzBy?=
 =?utf-8?B?b29XU1QyVjdkS1JQSWp0WlZscDBjT3ZtNzU4R05RZlN3Yk52MWR2NEZORGJ6?=
 =?utf-8?Q?1jVsp1XGtw9/nVAOPd1CW5Vg6?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e7840175-5ee1-4662-c605-08da63d12684
X-MS-Exchange-CrossTenant-AuthSource: MW4PR11MB5933.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2022 06:38:37.8468
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ql4ZS2NB4GwUrlaMSBobV/4GwGtfdTdOQkqollhnhbw7ZteBLHT4SpvrlwfY5m9DfpP99xvekNgZi9LnjGXV7Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR11MB3120
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/kvms390/linux.git pci
head:   4ac34b94a5342544baa72ce09fc5e825a9d35070
commit: 73f91b004321f2510fa79e66035dbbf1870fcf56 [13/21] KVM: s390: pci: enable host forwarding of Adapter Event Notifications
compiler: gcc-11 (Debian 11.3.0-3) 11.3.0

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <yujie.liu@intel.com>


includecheck warnings: (new ones prefixed by >>)
 >> arch/s390/kvm/pci.h: linux/kvm_host.h is included more than once.

6438e30714abd (Matthew Rosato 2022-06-06 16:33:15 -0400 @13) #include <linux/kvm_host.h>
6438e30714abd (Matthew Rosato 2022-06-06 16:33:15 -0400  14) #include <linux/pci.h>
98b1d33dac5fd (Matthew Rosato 2022-06-06 16:33:16 -0400  15) #include <linux/mutex.h>
09340b2fca007 (Matthew Rosato 2022-06-06 16:33:20 -0400  16) #include <linux/kvm.h>
73f91b004321f (Matthew Rosato 2022-06-06 16:33:17 -0400 @17) #include <linux/kvm_host.h>
98b1d33dac5fd (Matthew Rosato 2022-06-06 16:33:16 -0400  18) #include <asm/airq.h>
98b1d33dac5fd (Matthew Rosato 2022-06-06 16:33:16 -0400  19) #include <asm/cpu.h>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
