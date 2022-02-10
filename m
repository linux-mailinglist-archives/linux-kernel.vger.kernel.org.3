Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 900DD4B07B2
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 09:01:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236853AbiBJH7j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 02:59:39 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:43794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235869AbiBJH7h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 02:59:37 -0500
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A7A51089
        for <linux-kernel@vger.kernel.org>; Wed,  9 Feb 2022 23:59:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644479979; x=1676015979;
  h=message-id:date:subject:references:to:cc:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Y+Yor8Yo55cJRS6BjiQH11/0uCI/NT7r+VFuQvMiMxk=;
  b=HdVwvFIg9aja29pSMF4rUYzVcX+cowh5wQNIhPjYnJ6DOmDcMR7vbUx1
   miUdGc9gaxjAc/1Cr2yrtl92kQ1zS6TZle7BIyuKqJXBZKM7s75XD6nOy
   hy25QYl2hAa6FaYvJRsMkJYebUDPXYWZD6orwIzgZUotIyN3yx9grTYc3
   skxX/hwQ0ifWPXi5UZ3lv0JjIVK8pNQNvBlMfwKYje91L5URaycfS7WyG
   ERbx/6dJtr6p1ySEvIgQvBegwxs5NIEHpBGV5eBqNXYxqv6T7KzTM4LGV
   4kFzITh71n1jf51rzYnPThzbNTo6r0FWnEhxt0XMB42ziKhIBrzHEDGIF
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10253"; a="310174928"
X-IronPort-AV: E=Sophos;i="5.88,358,1635231600"; 
   d="scan'208";a="310174928"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2022 23:59:38 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,358,1635231600"; 
   d="scan'208";a="622586107"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by FMSMGA003.fm.intel.com with ESMTP; 09 Feb 2022 23:59:38 -0800
Received: from orsmsx607.amr.corp.intel.com (10.22.229.20) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Wed, 9 Feb 2022 23:59:38 -0800
Received: from orsmsx604.amr.corp.intel.com (10.22.229.17) by
 ORSMSX607.amr.corp.intel.com (10.22.229.20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Wed, 9 Feb 2022 23:59:37 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx604.amr.corp.intel.com (10.22.229.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20 via Frontend Transport; Wed, 9 Feb 2022 23:59:37 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.174)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.20; Wed, 9 Feb 2022 23:59:37 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PSZmmmfaE80StmQZ96OB5dohGKpA1lAZBOvVrJRO+jihXzLe61QgFaHEJoS13aq0F70JrpnxDqldFVP70VVtTf02FihOyOGq4P80tRFIwsWM7B7/VvZxq/2nVYtd+OyPKzmannRJlLzJbtzgOaegwUqiVIDI57bXU74X7QLf2YBDvXMUOihqYpletGQZXmhJAfL5FfL1AN7rbMFvha29DVjiQDWvX0aLRDVsVeQAW0YMqcELgcKPkSueFgKBNDOkHF2UPRsHCWgJv3yxuaT4mzzedCeu/XMKkz/L992uOImtEyOSa/7RA1jG0K1tBEebxAxIvMaySu9i3k9Hkh5eEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+k0ro3BJdXTRq2qwDYX2cXpLqZDDJh+/4RPaFHpLbNY=;
 b=Y0rnajiykghx8ZN0OQk7Zlr9NkAMy5djgfyO1aHzn8MtchLhZG5ooqLhG4/7aC7fn/C/Wvj1gCKjaqlILknkARQcDsxL/yNfv+9JPuAki/k12AoA2+1NarG4cGx8DqvLemrXAE5/x8lLUkbXIXcJlgbGgUOyYqEDcgyQIsoDPoDxqqN0o4CVc8YemUVXxzZCyyNyGyCJR9zjEnuVk4/yohchAfT5zp7sI2sBCBnFavfG7hjL3Wi3cy9DYFpFpB7PKL8/EQMF3vs+SjoLwJCevpi7RdUIVWKVzysSFJzkJ5ZWram6U1Yh7RMEnN9vCqjPXT/rrUTltdqg8dfbm0ZhVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ0PR11MB5598.namprd11.prod.outlook.com (2603:10b6:a03:304::12)
 by DM6PR11MB3867.namprd11.prod.outlook.com (2603:10b6:5:4::27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4951.14; Thu, 10 Feb 2022 07:59:35 +0000
Received: from SJ0PR11MB5598.namprd11.prod.outlook.com
 ([fe80::c4a2:d11d:cb7b:dc8d]) by SJ0PR11MB5598.namprd11.prod.outlook.com
 ([fe80::c4a2:d11d:cb7b:dc8d%7]) with mapi id 15.20.4951.019; Thu, 10 Feb 2022
 07:59:35 +0000
Message-ID: <0e8851a1-e3bc-b8ed-6e48-02215edb2f6c@intel.com>
Date:   Thu, 10 Feb 2022 15:59:28 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.5.1
Subject: [oracle-dtrace:v2/5.17-rc2 8/10] fs/eventpoll.c:1224:3: warning:
 Assignment of function parameter has no effect outside the function. Did you
 forget dereferencing it? [uselessAssignmentPtrArg]
References: <202202060630.0kkTUrko-lkp@intel.com>
Content-Language: en-US
To:     Nick Alcock <nick.alcock@oracle.com>
CC:     <kbuild-all@lists.01.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
From:   kernel test robot <yujie.liu@intel.com>
In-Reply-To: <202202060630.0kkTUrko-lkp@intel.com>
X-Forwarded-Message-Id: <202202060630.0kkTUrko-lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: HK2PR02CA0209.apcprd02.prod.outlook.com
 (2603:1096:201:20::21) To SJ0PR11MB5598.namprd11.prod.outlook.com
 (2603:10b6:a03:304::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: eb3ba719-3037-4470-b2fc-08d9ec6b477f
X-MS-TrafficTypeDiagnostic: DM6PR11MB3867:EE_
X-Microsoft-Antispam-PRVS: <DM6PR11MB386741F97E4EEC05AA1DD8EEFB2F9@DM6PR11MB3867.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3276;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: x/qirGHsFiBkGMGgpXNj3qFe6EXmOQoirGTGpxPl9dSZYzxAUp7rujNbI3BGys3IQ+jWjPy4xwA5uy5DrGAWUnsNpsTq/BnX2a2Ar8MkkCQ4UPlEFl3whnlMfwynySCHIEOkWLGoGNatFolc22NwbbIYrDQqeIj94JPq8a/U22IOuQfjBdhty1rtRanM/mSlG0sBbaS2kXgNDQ02/CuzzfUJEAwd4l2asfDdRwuZoI2ysK7l3wAX1vMX9oodPwG5uJrSRW8pRUdidRqMr2KGtKaanGTe0bFY8WFlwm2cdzU3HbuqT86I6b1exgEdRcU58NIx+Hgy4irBiWpllZqBseBdbPti2MsO0quAecGLIs0sa3+dM/BdlsgO/SOaBLD0aJzq2a5lVmr6e9Oaqa3Pk+UDxsKpdfOpVIDhaZL6heBZLdXB5Ar50k3S6oH7chdZQfj1H4lnuX47KGm+jI7RErA/Amk0D7TFUglckqXLz3luW805WUry+0NpWnAowYXzFjRvArvnQx2fpSwBGt4vEZzc0niiRhlhw+7ySrC8FLJGmgaGqZfCMDRkn/9Llj9QFhwigUfgubw6zC8+oVUJFCnmxT3Q7Cv3c5RbJW3/UkReVfyOt9a1bP3PwSWOXz3bp9YzkDQ6tDDd16sH0OUcS7CHdp4d65zMBOKZWZ7/QyhVnREAfbLaOHOg7UsG9XWiTBwkAniEyMSxw9maH8WPLHm3rl/FRZJR70l4zC8/5ybzJEeNs3x8RUpy5rgHu6wPLtk6ZQBCez4OAaG1tdZL12jSN+p8sRBBdPeONDIr7JmxH80Jb92MgJuwP3GmB+7hAnN0tWA/3jJ37OJ5ZkKQTf2Ow2NlX97PHqaccPN/mhM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB5598.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(66574015)(6916009)(508600001)(2906002)(30864003)(31686004)(966005)(6486002)(2616005)(82960400001)(4001150100001)(186003)(6506007)(5660300002)(86362001)(6512007)(38100700002)(26005)(66476007)(4326008)(6666004)(8676002)(66556008)(66946007)(83380400001)(8936002)(316002)(31696002)(36756003)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VjdreEduRXFsNVdTUTBUOXhLTS9qcTVSR3JkMFVOOG4wWWhsM3BnUm9xTllJ?=
 =?utf-8?B?WkgzdWtPR1hwQUNFd0YvYnFaT2dIOXkraWdwT09HUy82WGxqMXBvYndYR21i?=
 =?utf-8?B?a3BSUThxVlMzMGFra29UbExXMHRUbmhuM3VRMWE5UU04RnFCeVpEWVhMYTFU?=
 =?utf-8?B?UWMzZnFMYnYzdzR3MVpRNnNVYzVvdkVoSmFPNHNiRCtnUlZMVFJTOTNRemZM?=
 =?utf-8?B?Zmg0elg4VU1DbU5lazI2ZVcwRXo5U0VhTWpJc0E4TldBVERUaTFRNmF6N01L?=
 =?utf-8?B?NU1nQmMvQWIrdUVNMnFGNFpBVW40Y21oZEJrMDdMR1J5aUZ6MVJQK2FwR0F1?=
 =?utf-8?B?c2NOV1RtOXhrZ3ZiVURBS2N5MGV2cUIvaXE0VGVndG1SOTlCaVhGWTYxK1Y3?=
 =?utf-8?B?Vjg2Wk93MEFkYXNZdzM3ZSthbFU2YTZnYVBHUDgxZWZvK0NBY3ZNTStlaGw5?=
 =?utf-8?B?VlF3L1lDRitIamMwRzR2WHo1d1Z2TkxuL3JCRnJSTHIzbExEdU1GQ3VRUXBH?=
 =?utf-8?B?NVpmM0FDakZnZjM3aFJXT0N2TGRnN3dET1dsdlVtTFF4eHdTL1JCdWt4eFVT?=
 =?utf-8?B?R0hiK1QxOEppZ0kwUkNzTjhqcUZqck5hclUvQWQ5Z0lteHRtcFVITjlFYVpz?=
 =?utf-8?B?bHpYaXRhb2IrbFlqaXRkNXRrTFhiWkVXV0xXQlFuaWhHMStzZnpCQVZNQWFx?=
 =?utf-8?B?alArWDVBeklEdUN2eGUyeGE2TG9waE14OHYxTi9ZbjhsTFJlalpQelplNHpS?=
 =?utf-8?B?MllRNUZUWm4wYTBjYzQ1RmxYZVZKQlJwZWZ4bko2N0ZjUXhLVWs4aHBESnpG?=
 =?utf-8?B?SmEyTHo1eVJQTmk4K3dhSWJBMmlVeXdCYVQ3YzdlN1VNNGFwcTBEYVRzczl0?=
 =?utf-8?B?VlN0RVFQRjFKS2UwZk1ocVpkMHlHK0dvTUg2MGlBMVVnUEo5UVBpTmhVSU5H?=
 =?utf-8?B?ZDB0SFdDOWw1ZklqRkd6RzNKU1p6dTBDRVhjTkVtR2YxeXYzZkRBeGRhOHBx?=
 =?utf-8?B?aWM0NlgzQ2FGSjlvSGdZcDN1Qko4eVEvRzQ0N3lNdDlPMHBuR21KSzVsU0Vo?=
 =?utf-8?B?T2pMWU92T1dGNTNDTEUvRUhkU3M3c3hWYWljR0d4dTY2K3Y3bXluRHVrSHg4?=
 =?utf-8?B?dTdNdmJEUjdDalpOVG00dy80cHoxdkN3VndtNDdIcDdBellJWTRxSU4zVk0r?=
 =?utf-8?B?VXNkSnd3allabFdJWFlCZ01CR1RSWmVMb3Q2U3VwS1EvTE9DL0RlMXdxQklX?=
 =?utf-8?B?dVpkdEZKT1V0YjgzMlVHY2JidnR6WTM1Wk1RYXFoMzh0dTFTbzh5R2Z1RTdx?=
 =?utf-8?B?a3lPUFJIdGpwK0Z0U01MN1BLTmlEYTRFemxqTHgyZXlxZ28zTmd5N2JRN0Nj?=
 =?utf-8?B?QVB4Rm5JaGo2YUVULzkrQlNLdzByVVVvWUZ5KzNDYUtac2JHbDZVS3ltNkxj?=
 =?utf-8?B?dGt4eDRTNHhzL0NyNXRHR0JhSldXVWJlNGsvdWcyQ0REUm4rNDArVXEwNjBP?=
 =?utf-8?B?K1N6eU51OUUrYkI4azBtald5Z2dSRmZ5Smw5OE1NMWI4cDlZSWRvenh3SWRG?=
 =?utf-8?B?Mnl5WHNzMUtLRDQvYUNzdVpqQlNFakUvSjVHcHlxS3lwbE1BN3FNVjdMOEVq?=
 =?utf-8?B?RklSeTJSTjUzWjZyelZvem5NNU5GQ2Q1MzA5QlVRM3dkT09ySk0vK2RCOFhk?=
 =?utf-8?B?dEpuTHlTc256Zm8rMk5mQVVPRDVmK3M2Y3NnU3ByanVMd0NUU0tCYmZjS0hU?=
 =?utf-8?B?UVg4OFZKSGx5cmVSVnZKMzdZQXZlVU4vOGo4ejdmYml0M2JDcFRWdE9KOFdt?=
 =?utf-8?B?Ty9vdzFBd1dkOHY0TkZHZUQvTmZDTVZyTkZtOHdvcm5VYis3dWliZWtsZHFw?=
 =?utf-8?B?SnYvQnlPdFl0TC9yQ2tHV2tYbTEvNm9DNWdIMFJ0QnpsRWJsN0hDSDdFbU1S?=
 =?utf-8?B?Z25sKzVGek15cUJQUGZKR1JDRGx0ZThOTkYzYlJaSzd0TmhJZUp1alk4QWN5?=
 =?utf-8?B?djc3T2F0dXZ6aGt0eHJka2NFQnQ1ZG5XaUprSGxJSGcvS0VreWliNUhnSDE0?=
 =?utf-8?B?TlZlYmJ2UmVJemNOYktFSnNJY2pCUThjdXU0KzN1Y3MwYndBbm1XczlneWlM?=
 =?utf-8?B?amVLR053eUg1dDVEaUpjWlBBUzVUVEV4dFV5SWdNTmF2dHlzdzdQaEpGVmY5?=
 =?utf-8?Q?m1XCRqI3IPDbCb2XnxEN8U4=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: eb3ba719-3037-4470-b2fc-08d9ec6b477f
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB5598.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2022 07:59:35.8435
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UnREByC5OxebNWMDYoe6r+oQXO/RthCM2+lgrBZstG0qRcvpmLjP0pDJR/2wOjj/UzND45s7cK9ZNf4/PuhWTQ==
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

tree:   https://github.com/oracle/dtrace-linux-kernel v2/5.17-rc2
head:   47946e7b2e2319f39cbb7f8aaa294298c2dec5b4
commit: 16ad67b61ac4f3dd93b3fa6875a011fff7b88500 [8/10] waitfd: new syscall implementing waitpid() over fds
compiler: or1k-linux-gcc (GCC) 11.2.0

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


cppcheck possible warnings: (new ones prefixed by >>, may not be real problems)

 >> fs/eventpoll.c:1224:3: warning: Assignment of function parameter has no effect outside the function. Did you forget dereferencing it? [uselessAssignmentPtrArg]
      key = (void *)epi->fixed_event;
      ^

vim +1224 fs/eventpoll.c

a218cc4914209a Roman Penyaev      2019-03-07  1118
^1da177e4c3f41 Linus Torvalds     2005-04-16  1119  /*
7699acd1341c63 Davide Libenzi     2007-05-10  1120   * This is the callback that is passed to the wait queue wakeup
bf6a41db7726e6 Daniel Baluta      2011-01-30  1121   * mechanism. It is called by the stored file descriptors when they
7699acd1341c63 Davide Libenzi     2007-05-10  1122   * have events to report.
a218cc4914209a Roman Penyaev      2019-03-07  1123   *
a6c67fee9cf095 Randy Dunlap       2021-03-01  1124   * This callback takes a read lock in order not to contend with concurrent
a6c67fee9cf095 Randy Dunlap       2021-03-01  1125   * events from another file descriptor, thus all modifications to ->rdllist
a218cc4914209a Roman Penyaev      2019-03-07  1126   * or ->ovflist are lockless.  Read lock is paired with the write lock from
a218cc4914209a Roman Penyaev      2019-03-07  1127   * ep_scan_ready_list(), which stops all list modifications and guarantees
a218cc4914209a Roman Penyaev      2019-03-07  1128   * that lists state is seen correctly.
a218cc4914209a Roman Penyaev      2019-03-07  1129   *
a218cc4914209a Roman Penyaev      2019-03-07  1130   * Another thing worth to mention is that ep_poll_callback() can be called
a218cc4914209a Roman Penyaev      2019-03-07  1131   * concurrently for the same @epi from different CPUs if poll table was inited
a218cc4914209a Roman Penyaev      2019-03-07  1132   * with several wait queues entries.  Plural wakeup from different CPUs of a
a218cc4914209a Roman Penyaev      2019-03-07  1133   * single wait queue is serialized by wq.lock, but the case when multiple wait
a218cc4914209a Roman Penyaev      2019-03-07  1134   * queues are used should be detected accordingly.  This is detected using
a218cc4914209a Roman Penyaev      2019-03-07  1135   * cmpxchg() operation.
^1da177e4c3f41 Linus Torvalds     2005-04-16  1136   */
ac6424b981bce1 Ingo Molnar        2017-06-20  1137  static int ep_poll_callback(wait_queue_entry_t *wait, unsigned mode, int sync, void *key)
^1da177e4c3f41 Linus Torvalds     2005-04-16  1138  {
7699acd1341c63 Davide Libenzi     2007-05-10  1139  	int pwake = 0;
7699acd1341c63 Davide Libenzi     2007-05-10  1140  	struct epitem *epi = ep_item_from_wait(wait);
7699acd1341c63 Davide Libenzi     2007-05-10  1141  	struct eventpoll *ep = epi->ep;
3ad6f93e98d6df Al Viro            2017-07-03  1142  	__poll_t pollflags = key_to_poll(key);
a218cc4914209a Roman Penyaev      2019-03-07  1143  	unsigned long flags;
df0108c5da561c Jason Baron        2016-01-20  1144  	int ewake = 0;
^1da177e4c3f41 Linus Torvalds     2005-04-16  1145
a218cc4914209a Roman Penyaev      2019-03-07  1146  	read_lock_irqsave(&ep->lock, flags);
^1da177e4c3f41 Linus Torvalds     2005-04-16  1147
bf3b9f6372c45b Sridhar Samudrala  2017-03-24  1148  	ep_set_busy_poll_napi_id(epi);
bf3b9f6372c45b Sridhar Samudrala  2017-03-24  1149
^1da177e4c3f41 Linus Torvalds     2005-04-16  1150  	/*
7699acd1341c63 Davide Libenzi     2007-05-10  1151  	 * If the event mask does not contain any poll(2) event, we consider the
7699acd1341c63 Davide Libenzi     2007-05-10  1152  	 * descriptor to be disabled. This condition is likely the effect of the
7699acd1341c63 Davide Libenzi     2007-05-10  1153  	 * EPOLLONESHOT bit that disables the descriptor when an event is received,
7699acd1341c63 Davide Libenzi     2007-05-10  1154  	 * until the next EPOLL_CTL_MOD will be issued.
^1da177e4c3f41 Linus Torvalds     2005-04-16  1155  	 */
7699acd1341c63 Davide Libenzi     2007-05-10  1156  	if (!(epi->event.events & ~EP_PRIVATE_BITS))
d47de16c722196 Davide Libenzi     2007-05-15  1157  		goto out_unlock;
d47de16c722196 Davide Libenzi     2007-05-15  1158
2dfa4eeab0fc7e Davide Libenzi     2009-03-31  1159  	/*
2dfa4eeab0fc7e Davide Libenzi     2009-03-31  1160  	 * Check the events coming with the callback. At this stage, not
2dfa4eeab0fc7e Davide Libenzi     2009-03-31  1161  	 * every device reports the events in the "key" parameter of the
2dfa4eeab0fc7e Davide Libenzi     2009-03-31  1162  	 * callback. We need to be able to handle both cases here, hence the
2dfa4eeab0fc7e Davide Libenzi     2009-03-31  1163  	 * test for "key" != NULL before the event match test.
2dfa4eeab0fc7e Davide Libenzi     2009-03-31  1164  	 */
3ad6f93e98d6df Al Viro            2017-07-03  1165  	if (pollflags && !(pollflags & epi->event.events))
2dfa4eeab0fc7e Davide Libenzi     2009-03-31  1166  		goto out_unlock;
2dfa4eeab0fc7e Davide Libenzi     2009-03-31  1167
d47de16c722196 Davide Libenzi     2007-05-15  1168  	/*
bf6a41db7726e6 Daniel Baluta      2011-01-30  1169  	 * If we are transferring events to userspace, we can hold no locks
d47de16c722196 Davide Libenzi     2007-05-15  1170  	 * (because we're accessing user memory, and because of linux f_op->poll()
bf6a41db7726e6 Daniel Baluta      2011-01-30  1171  	 * semantics). All the events that happen during that period of time are
d47de16c722196 Davide Libenzi     2007-05-15  1172  	 * chained in ep->ovflist and requeued later on.
d47de16c722196 Davide Libenzi     2007-05-15  1173  	 */
c5a282e9635e9c Davidlohr Bueso    2019-01-03  1174  	if (READ_ONCE(ep->ovflist) != EP_UNACTIVE_PTR) {
0c54a6a44bf3d4 Khazhismel Kumykov 2020-05-07  1175  		if (chain_epi_lockless(epi))
c3e320b61581ef Roman Penyaev      2019-03-07  1176  			ep_pm_stay_awake_rcu(epi);
0c54a6a44bf3d4 Khazhismel Kumykov 2020-05-07  1177  	} else if (!ep_is_linked(epi)) {
0c54a6a44bf3d4 Khazhismel Kumykov 2020-05-07  1178  		/* In the usual case, add event to ready list. */
0c54a6a44bf3d4 Khazhismel Kumykov 2020-05-07  1179  		if (list_add_tail_lockless(&epi->rdllink, &ep->rdllist))
eea1d585917c53 Eric Wong          2013-04-30  1180  			ep_pm_stay_awake_rcu(epi);
4d7e30d98939a0 Arve Hjønnevåg     2012-05-01  1181  	}
7699acd1341c63 Davide Libenzi     2007-05-10  1182
7699acd1341c63 Davide Libenzi     2007-05-10  1183  	/*
7699acd1341c63 Davide Libenzi     2007-05-10  1184  	 * Wake up ( if active ) both the eventpoll wait list and the ->poll()
7699acd1341c63 Davide Libenzi     2007-05-10  1185  	 * wait list.
7699acd1341c63 Davide Libenzi     2007-05-10  1186  	 */
df0108c5da561c Jason Baron        2016-01-20  1187  	if (waitqueue_active(&ep->wq)) {
b6a515c8a0f6c2 Jason Baron        2016-02-05  1188  		if ((epi->event.events & EPOLLEXCLUSIVE) &&
3ad6f93e98d6df Al Viro            2017-07-03  1189  					!(pollflags & POLLFREE)) {
3ad6f93e98d6df Al Viro            2017-07-03  1190  			switch (pollflags & EPOLLINOUT_BITS) {
a9a08845e9acbd Linus Torvalds     2018-02-11  1191  			case EPOLLIN:
a9a08845e9acbd Linus Torvalds     2018-02-11  1192  				if (epi->event.events & EPOLLIN)
b6a515c8a0f6c2 Jason Baron        2016-02-05  1193  					ewake = 1;
b6a515c8a0f6c2 Jason Baron        2016-02-05  1194  				break;
a9a08845e9acbd Linus Torvalds     2018-02-11  1195  			case EPOLLOUT:
a9a08845e9acbd Linus Torvalds     2018-02-11  1196  				if (epi->event.events & EPOLLOUT)
b6a515c8a0f6c2 Jason Baron        2016-02-05  1197  					ewake = 1;
b6a515c8a0f6c2 Jason Baron        2016-02-05  1198  				break;
b6a515c8a0f6c2 Jason Baron        2016-02-05  1199  			case 0:
df0108c5da561c Jason Baron        2016-01-20  1200  				ewake = 1;
b6a515c8a0f6c2 Jason Baron        2016-02-05  1201  				break;
b6a515c8a0f6c2 Jason Baron        2016-02-05  1202  			}
b6a515c8a0f6c2 Jason Baron        2016-02-05  1203  		}
a218cc4914209a Roman Penyaev      2019-03-07  1204  		wake_up(&ep->wq);
df0108c5da561c Jason Baron        2016-01-20  1205  	}
7699acd1341c63 Davide Libenzi     2007-05-10  1206  	if (waitqueue_active(&ep->poll_wait))
7699acd1341c63 Davide Libenzi     2007-05-10  1207  		pwake++;
^1da177e4c3f41 Linus Torvalds     2005-04-16  1208
d47de16c722196 Davide Libenzi     2007-05-15  1209  out_unlock:
a218cc4914209a Roman Penyaev      2019-03-07  1210  	read_unlock_irqrestore(&ep->lock, flags);
7699acd1341c63 Davide Libenzi     2007-05-10  1211
7699acd1341c63 Davide Libenzi     2007-05-10  1212  	/* We have to call this outside the lock */
7699acd1341c63 Davide Libenzi     2007-05-10  1213  	if (pwake)
efcdd350d1f8a9 Jason Baron        2020-04-06  1214  		ep_poll_safewake(ep, epi);
7699acd1341c63 Davide Libenzi     2007-05-10  1215
138e4ad67afd5c Oleg Nesterov      2017-09-01  1216  	if (!(epi->event.events & EPOLLEXCLUSIVE))
138e4ad67afd5c Oleg Nesterov      2017-09-01  1217  		ewake = 1;
138e4ad67afd5c Oleg Nesterov      2017-09-01  1218
16ad67b61ac4f3 Nick Alcock        2018-11-14  1219  	/*
16ad67b61ac4f3 Nick Alcock        2018-11-14  1220  	 * If this fd type has a hardwired event which should override the key
16ad67b61ac4f3 Nick Alcock        2018-11-14  1221  	 * (e.g. if it is waiting on a non-file waitqueue), jam it in here.
16ad67b61ac4f3 Nick Alcock        2018-11-14  1222  	 */
16ad67b61ac4f3 Nick Alcock        2018-11-14  1223  	if (epi->fixed_event)
16ad67b61ac4f3 Nick Alcock        2018-11-14 @1224  		key = (void *)epi->fixed_event;
16ad67b61ac4f3 Nick Alcock        2018-11-14  1225
3ad6f93e98d6df Al Viro            2017-07-03  1226  	if (pollflags & POLLFREE) {
138e4ad67afd5c Oleg Nesterov      2017-09-01  1227  		/*
138e4ad67afd5c Oleg Nesterov      2017-09-01  1228  		 * If we race with ep_remove_wait_queue() it can miss
138e4ad67afd5c Oleg Nesterov      2017-09-01  1229  		 * ->whead = NULL and do another remove_wait_queue() after
138e4ad67afd5c Oleg Nesterov      2017-09-01  1230  		 * us, so we can't use __remove_wait_queue().
138e4ad67afd5c Oleg Nesterov      2017-09-01  1231  		 */
138e4ad67afd5c Oleg Nesterov      2017-09-01  1232  		list_del_init(&wait->entry);
138e4ad67afd5c Oleg Nesterov      2017-09-01  1233  		/*
138e4ad67afd5c Oleg Nesterov      2017-09-01  1234  		 * ->whead != NULL protects us from the race with ep_free()
138e4ad67afd5c Oleg Nesterov      2017-09-01  1235  		 * or ep_remove(), ep_remove_wait_queue() takes whead->lock
138e4ad67afd5c Oleg Nesterov      2017-09-01  1236  		 * held by the caller. Once we nullify it, nothing protects
138e4ad67afd5c Oleg Nesterov      2017-09-01  1237  		 * ep/epi or even wait.
138e4ad67afd5c Oleg Nesterov      2017-09-01  1238  		 */
138e4ad67afd5c Oleg Nesterov      2017-09-01  1239  		smp_store_release(&ep_pwq_from_wait(wait)->whead, NULL);
138e4ad67afd5c Oleg Nesterov      2017-09-01  1240  	}
df0108c5da561c Jason Baron        2016-01-20  1241
138e4ad67afd5c Oleg Nesterov      2017-09-01  1242  	return ewake;
7699acd1341c63 Davide Libenzi     2007-05-10  1243  }
^1da177e4c3f41 Linus Torvalds     2005-04-16  1244

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
