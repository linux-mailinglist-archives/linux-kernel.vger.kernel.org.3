Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B5A3528172
	for <lists+linux-kernel@lfdr.de>; Mon, 16 May 2022 12:07:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238291AbiEPKGw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 06:06:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242328AbiEPKGC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 06:06:02 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 699526381
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 03:05:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652695556; x=1684231556;
  h=message-id:date:subject:references:to:cc:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=0QEC7/bXiQmd0o37EuwZaCg1i8pKDMmxiwcN6+GMDs4=;
  b=MOBl0DuTmq8uJ9U4MAxQm3ZZnNf9BtiSYPmsl78z9vqVQUv4UPFIH9pk
   9UQ82HI0EVJFltA8veil/Tl3HZVPhgenhir3dPGq2wZzDop8la7n2zbhc
   ftK7czPbLmlK2v9xFzabw+3plcBEmopjrRVwKKPdF1HSDTO+j5SaB7qLx
   QDWjWKYI/H9KUi5bztfhQShEyJi9+KDJFMXeYNWH2d4sqW+glN31ZV+HM
   gCs+Yl94b50ZMk9+tnjGuDIg++CG3RG5SrjlLauYmjgdJypoATS4PdjSb
   2NqnoZxrRFRtFOnQL1oyscjItd7fN+4SnlEyqY+P74fytLUJo/PEoMtiy
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10348"; a="268365126"
X-IronPort-AV: E=Sophos;i="5.91,229,1647327600"; 
   d="scan'208";a="268365126"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2022 03:05:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,229,1647327600"; 
   d="scan'208";a="741175715"
Received: from orsmsx606.amr.corp.intel.com ([10.22.229.19])
  by orsmga005.jf.intel.com with ESMTP; 16 May 2022 03:05:55 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX606.amr.corp.intel.com (10.22.229.19) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Mon, 16 May 2022 03:05:55 -0700
Received: from orsmsx606.amr.corp.intel.com (10.22.229.19) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Mon, 16 May 2022 03:05:55 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx606.amr.corp.intel.com (10.22.229.19) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Mon, 16 May 2022 03:05:55 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.172)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Mon, 16 May 2022 03:05:54 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GIdbXVIYhBI/ux4MFISVfagKkUpOjIw79MWgCasgnoENRP7sBbmpKQ8avF5WkfpaF/LzBToVDreiSNyhzVJRzqGwam+pB86QRCxp4g0kh9WVjLFtJ+v9Lns5VLut1a7fMi1+dcBghv498FLq126dDuHqLtbt3hTXuvUzx8MfJvpBz+ydoVKss5qYsX1VOtAfWTAuwvsFym/JCz0pFN6MrJnAnQc7xWRDAq8yiY5WbObLYs1Pv2+C6tmRCIgREEv5SuHDRSCts2OWJUFSrj3xhdR8uAIevYBB6pqXQ+PAIuv5rR2ski2ZWkwPyRi85LY1GGXMsfWZkUyWT8tUW5+S0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MvVhvhUGCnfsMZZZgeTnEFqv5Agkq0fLKlGhOm/ilnM=;
 b=MeuVroclZVLnKdYxdGaA9tsPPhz/jffvhkxYZsLuDnD3399IUOFpAU4nioC+oEpQ/IdN2AwEHenIX0V99Hxjur6MHCt7oAhyLZ9gIaIVmROhRrAgRxwz6tyhbMjBRyLEbLo5X3FT7A9voR2MWaOZ5M8iSXDTQeUDgd88MmC768oZhU2SE9jH0hh0wsQqICd1Mp558DeFRXjONMyLi55z4Yz6eO1RL/gcAlDmZAr3/glLgzEokLM97xawJZBq8RCDFrq67kX67Ch749f7teG3ErIDrTPSgjdANQ0dt+zfj1Qf75E9CvdRJVdj03rDaQAqxM7JXCEJ1iQDQEZjKFauVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MW4PR11MB5933.namprd11.prod.outlook.com (2603:10b6:303:16a::15)
 by CY4PR11MB0023.namprd11.prod.outlook.com (2603:10b6:910:7a::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.18; Mon, 16 May
 2022 10:05:53 +0000
Received: from MW4PR11MB5933.namprd11.prod.outlook.com
 ([fe80::1169:fc9:c1ef:248e]) by MW4PR11MB5933.namprd11.prod.outlook.com
 ([fe80::1169:fc9:c1ef:248e%7]) with mapi id 15.20.5250.018; Mon, 16 May 2022
 10:05:53 +0000
Message-ID: <51039340-74af-e8c5-7b93-b99ec19ccf74@intel.com>
Date:   Mon, 16 May 2022 18:05:39 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.9.0
Subject: [cxl:preview 56/67] drivers/cxl/core/region.c: core.h is included
 more than once.
References: <202205121816.mRTqH43R-lkp@intel.com>
Content-Language: en-US
To:     Ben Widawsky <ben.widawsky@intel.com>
CC:     <kbuild-all@lists.01.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
From:   kernel test robot <yujie.liu@intel.com>
In-Reply-To: <202205121816.mRTqH43R-lkp@intel.com>
X-Forwarded-Message-Id: <202205121816.mRTqH43R-lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR01CA0183.apcprd01.prod.exchangelabs.com
 (2603:1096:4:189::16) To MW4PR11MB5933.namprd11.prod.outlook.com
 (2603:10b6:303:16a::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 052b4945-ab7a-4a9f-73d9-08da3723a918
X-MS-TrafficTypeDiagnostic: CY4PR11MB0023:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-Microsoft-Antispam-PRVS: <CY4PR11MB0023933CD3108B366544490DFBCF9@CY4PR11MB0023.namprd11.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wblbHpp8x3t0abINq1v4KtqKlHb6ij9gPngaXV8b85diAc57l5ZB+wbOZ4u9fGMf0E8shcB1Yhv89dahVmXHu/EjrN68dsJxE3ILq8PPn1WQCyq+L6PKYjbStWUspaXEmlKY0SN1c/x7lbJNnDWQFor2SJusDtAL6TXBd0KC/VyD57vDccOKHKNcfdJG9AgTTchjAxORDLxE1/g0RsHpyC0ZG2yZS7ACgg3H1GB/O7dwUfuNuxuLxIQ3B36dTQ6S9vwfe1kr2G4SZGZXzMlziqRguYAhg10+Ez59GSKowy+3iT64AgkArRWxNetgYM3pzpGgNu84wSA3Up5CwK2w1BfPGhDBow1Lt2T5nC75WKiExDdCNxRRyxVLi8+yg6zxYt/rWFIr/okacE49+ib5ipSOF8dbwOx0zpte6pA3PS77/bqLh5sRWZNCQB+/hqIHmglFkT6/KIEx524wdiqpZEq/PXd0JTuiMH9jLfiA5S3VH5n8FaqnnkvOjJbzH+mOXnvU6SOElZLtdSE0YxO1gCGlDe+VX3FLjNe+n6cii+13kLkXvyXVtESq2IlvmfdQTbURRS8lPxj9yBdDxHuTJY6a6KGyYMyTKjF+RZ4oQQyONmWQbQ4RGSTFUU/TuOanuP/rGwFfTROOW+XaHsG7JPpuaalp6YjOjziJnxrK6yNMas5VfPmRYRMgcjYCdSQeKj+5EjLek3MH7PudZ10bbOVpFZ6DInQLkyWMu5KLxIYh9xc93U5YwfCvLi/K+YmO/97PjBapvKo7vuIqonI7QQQdr2lT9zKa7lPWJnd40KDzCkhPeqMsbC4Sz6i9PqiNPnooBsrDRTv8sEGEvjcyp+HtnE3SyxKi6W81tqidDEE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR11MB5933.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(66556008)(2616005)(31686004)(508600001)(82960400001)(316002)(66476007)(86362001)(4744005)(5660300002)(31696002)(186003)(37006003)(6636002)(66946007)(36756003)(26005)(6512007)(38100700002)(6862004)(8676002)(6486002)(966005)(4326008)(8936002)(6666004)(2906002)(83380400001)(6506007)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NGNtL2IwQ21GWnFUQ3RLYlE1a1NwQ2FXbWs4dHpqY3NJRFBkKzNNRXhEQW5r?=
 =?utf-8?B?V21xVUdjYkRENUNtRVBDS0w3NTh5UzBDMjlPYmhwUEdrTENQbDlXMEpza0o0?=
 =?utf-8?B?T2oxRkh1NlVwSWxUa0VSQjVrOGtGT3RhVmRqdGJnWExNUE1nc3FwSms0T2cr?=
 =?utf-8?B?d1hDcEVpTDVyeHRvOXdKd2QyV1ZxWCtzTk5QWStZQ0FyTFY1NVhjcXJ4OUR6?=
 =?utf-8?B?UStKTG1JOEt2QkdzNUdSVU12dHRWQnNzNDYzUGhhWjJEM2RGV1NILytSOTY5?=
 =?utf-8?B?S04zN3FBbnFxSkJzamhHTjJCenRFOVU1eU5QUVlseVpiOEgzTHRtZlJPaytF?=
 =?utf-8?B?SUJUUHhDLzZqejhFNEpPQ1pDcG13N0NjMFJxbEhtSyt2Ry84dFVkN1VjMkZP?=
 =?utf-8?B?TlFtRTF0UnRSQ0JwZE1GdTdJbmJ1dHlGR3U2TFNlL25rdnU0SCtPckNESFBm?=
 =?utf-8?B?OW5EdDBZR21lTndlNzhWZjkvOTlHMC9ENTRRYWJVVWRub0xFUGRheldjaFhh?=
 =?utf-8?B?YU5pUFkvc1lMS0wxMzN0T3JGc1BSekU0NXhlQzliUTZmUnJoN3pXRTZ5aXpo?=
 =?utf-8?B?bDJIeU83czJvM0txZnhQd2xBYTlmc1FvalJpR3FxZ3NULytUakZuZDlSZXVF?=
 =?utf-8?B?WW9sazdPZVBkeFF6OGptUUxvaXMvcldEVkF3azBET0sxSUhIUmI0dUdIT1p2?=
 =?utf-8?B?a0g3aTBldG9RVkFMRmlaaE5hZTlhQXN5a3BJRnlrV0I0eEkwK3V5L3haUExT?=
 =?utf-8?B?N1BBZnNhUEJySmU3SDBTb2cvajBVOU1VWEUwdkJNNjEzbVVkMHBCQ09IUEhF?=
 =?utf-8?B?TGovQ1NtalBpdnNwQWpIbTFLU0JtOEpQeXo3dzRUMDVqYVpHVjZGZENVOFd1?=
 =?utf-8?B?U0NhaFloWlZSdEdBdHRlL1dtZ3FNZ241d1VhRWpDelNDeHU5djBmdlVMMGRq?=
 =?utf-8?B?OUtlcmNrNk01S2pURTJISW5BQlZUcWxBTXVqeVVld3JqYWh5MnZEMisxQzBa?=
 =?utf-8?B?bUhlYlhvbHFldnlHS0dVMk1KZHBoU1BUQzFhWitRTjZzY1FGV1FjYXpTSVRP?=
 =?utf-8?B?QTJtV2lSR0MzU0RuQXlWMEFySVBSUVZrQVNHTVkrUTNQV2dzU0lhcGVOMFUy?=
 =?utf-8?B?V0JOVDhYYWNEVUtDeW9UTnF1U0RXZ3d3RHpOelhVR3NjM3g2QUZGWkU1VXRH?=
 =?utf-8?B?S3VNZmlZSkhvTlRBUXNMZ2pVQlhDaTdmV29FSzR5Y2JnR1dYL042SDhQSGp1?=
 =?utf-8?B?Q0VLbXR1YXpLcmdKRHBYc3o5Y01iOVhGajJOSEh0ZGo3bEhTTkxPSlVYb2VW?=
 =?utf-8?B?TEdkUzd4TkZOV0FmOHlmeHQ3akV5dlFnUXBIcTBxVTRBSDZRcGYwWnVXTnlR?=
 =?utf-8?B?RWFqMU9JZUwxK01jeGtRSWYwMWFBelJ1dCtDbGJnRjBzZHlrSmQvSUt4b3Iv?=
 =?utf-8?B?MWtlSE5BSGYyb1JoRHNwd3duQlRFc3NBRnk5NDk3MUQ5TFBhbTBZbndob0lt?=
 =?utf-8?B?QnVrQmFkdmRFSjMwc0xGYkRGRGZyY0dLZEpUbjNsZmtFbStQZ1BmKzlsd0FU?=
 =?utf-8?B?ZjlQR2xsc2V1SllZUWdWOTIyeWo3WjFqckZJSllQZkd6Rm1pa3ZVUExwWVlO?=
 =?utf-8?B?WVY4enJqUWFrd09pWDdvT05qWmNVdStuaSttbnRKS3V0cXB1dU5mMFlqMlFm?=
 =?utf-8?B?NEI2d1U2ZkIrRlNaUUhBTFJRenZWZ0ZJbGk0WUM3Tjd0NUxXSGNHNDZzRkw0?=
 =?utf-8?B?VXcySGt4QVU5VHB2Y0g3NG9VNU40VmJCV3RWUC9YaTVqZzBtMklEa2diTWsr?=
 =?utf-8?B?TGIrT2RVREFiaFpyYWVoUXZ5bVp0QmgzRVE4U3ZQWTV2NG9qbi9HeXk0OUpB?=
 =?utf-8?B?dllzSXptcmsvNHZoWTJ1SnJDNVNUUlVJdzRKdE9wTEpDb1dSNlQzNDBzNy9w?=
 =?utf-8?B?aWU4dFg3dWU5aklvay8xanZxMUpJY01pTWZ4T1ZTeDhacnBzVkdRc1BYOUFr?=
 =?utf-8?B?M3U2eDFYeSsxa0kzR3NNcEN5NkJVakNoNGxxMXU4dTlIMERRWmJwOXhpbFhT?=
 =?utf-8?B?QmVPM2xETG0rN1lmd1Q1OW4zdHV1TUYvWWI4VEZKdDArdjRwUlg5YzBkei9x?=
 =?utf-8?B?S2tQcXl5U2o1VDh6UktjTXdFUlNsbXFDS2pFQUhCazVUSmRVRVpsbHhtZGRq?=
 =?utf-8?B?K1lCVUdHU0Y5WWpyaVptZ0dBQW5RV2NIUlFJZ2xwanRid1ZhRWtpY3pRa0hj?=
 =?utf-8?B?RjVTa0ZUV09zTFlvQmFoV2JvYU5wdzB0RjB6NENwYUxQRStXWm1BdzhrUTdU?=
 =?utf-8?B?SExBQXV2UkdLT1ZzKzdnVHdmdnZwcGFmeS9JUXVSUVhFUzkyZkw2QmFxQ1Zn?=
 =?utf-8?Q?dQTq6NSfRzccvPoY=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 052b4945-ab7a-4a9f-73d9-08da3723a918
X-MS-Exchange-CrossTenant-AuthSource: MW4PR11MB5933.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2022 10:05:52.9493
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TROGXfWCOXAOeBkx8t1BmwW1m9kagwz+08XRAOYwaJ2nwCJRuY1rv2bShlH55U4FAyxFN8LJmY6QYbD6PED7DQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR11MB0023
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git preview
head:   9c642abd8b31d895f34186bd72b7360083b58492
commit: e3a336d0e7c1ec862bd7543a81652b6111a00d8e [56/67] cxl/region: Introduce a cxl_region driver
compiler: gcc-11 (Debian 11.2.0-20) 11.2.0

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <yujie.liu@intel.com>


includecheck warnings: (new ones prefixed by >>)
 >> drivers/cxl/core/region.c: core.h is included more than once.

a254c1bc546c6 (Ben Widawsky 2022-02-11 14:51:27 -0800  11) #include <cxlmem.h>
76cc02859aa90 (Ben Widawsky 2022-02-11 14:49:59 -0800  12) #include <cxl.h>
76cc02859aa90 (Ben Widawsky 2022-02-11 14:49:59 -0800 @13) #include "core.h"
76cc02859aa90 (Ben Widawsky 2022-02-11 14:49:59 -0800  14)
e3a336d0e7c1e (Ben Widawsky 2022-02-11 14:52:13 -0800 @15) #include "core.h"
e3a336d0e7c1e (Ben Widawsky 2022-02-11 14:52:13 -0800  16)

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
