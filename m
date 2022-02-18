Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 291494BAEA1
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Feb 2022 01:40:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230111AbiBRAks (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 19:40:48 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:49466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230257AbiBRAkq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 19:40:46 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BF653631B
        for <linux-kernel@vger.kernel.org>; Thu, 17 Feb 2022 16:40:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645144830; x=1676680830;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=kVEbEnRXGxoIugCxrQSaxK88JU/sH06cBpEd2L3RHUk=;
  b=P3pLl/6rJ0WAKwMNBAOLaUhA08PN+KQm3CbAKfrEWsNssBPdGQ3tcKQs
   xs6XyXU++R3WagoWOveneyR+pA1cg6fUnuyDH6MPgiIoFi+zOGmwfz63A
   k+MN1SkgZBWSgptq20U6pUeaQLZKp0aQRPUGB4xFR05wRRMOaJhPoDq+F
   vnVevFtUgSBV5ZGb1i4KZaqVbEHCYD41XR5KpUYwAaVWaV3q+rlit2hIN
   tdGeg2xboV9vcn3pGXL3aosMA6sohlMt2bnxOy6Q9FJl5JX33qPDdTYHu
   D48dTQa0CncrNk3uCo7CkBo6obuFnT2aFc7r5gUhUqEUQjLHH2fR0GTzf
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10261"; a="231651073"
X-IronPort-AV: E=Sophos;i="5.88,377,1635231600"; 
   d="scan'208";a="231651073"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Feb 2022 16:40:29 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,377,1635231600"; 
   d="scan'208";a="635303586"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga002.fm.intel.com with ESMTP; 17 Feb 2022 16:40:29 -0800
Received: from fmsmsx608.amr.corp.intel.com (10.18.126.88) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Thu, 17 Feb 2022 16:39:59 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx608.amr.corp.intel.com (10.18.126.88) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20 via Frontend Transport; Thu, 17 Feb 2022 16:39:58 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.173)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.20; Thu, 17 Feb 2022 16:39:57 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EOjss7TQv9jusx8ORfjjRwPq6TexKe34ololExCHX8WR+HPdIGuSDWHgjcrXc3/EFJX3kRDh8mEElczTa9wBlCYkxfc0Dp+BJCY4ugAJmsawWcNeE5danw5NpFRllaa8GWcXzjHmdW0Kx21tzQTw5h8jEJgFZAxLst7HV0NngEUmKCjRfvSPOQTS5ipoESzIWkso3R3CiqEWZaNQi1ZQ9Up+NhXOBAZdkpaUf4dDdOO9k1yvVg7PGSOePfBqADXbaZl4VMyjTbLgE/QBzzAydO87kHvTmi5jC2BKJuO5pauAHEJIM1imhlyG9dN1v6DLABztfMHTr1IVl6il9OoJQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SDIRd/Grmu98kYC2pdxXJGBB+6mi0b4u4cZMd/DZLmw=;
 b=Gkk8qXwapuIagF8F7e5I0wz7SpQujQg8mNs8SHMyeaBvUUlRdzlm8kn0oNYEdIUNXJxoIcjBKKNUbxGZFaKY2/9iett11nIbDIdRxR2IL2NJObsoPnXdT2z2+8o+1aCnKiaC/fmELqf6o3WAQOzgWbfdAuGRI9GyEUsoIwIJeGv40gOLgQKuFcnC+4OmuwvNTYnasja7f2CWaDoBbkFz67Quk5FiCb1QFFdkzduBlDrXngJbGNCsg9pCSkZ6IbRAW0LmrhCxKX7r0giBKkc/JcpYm2EhA/9uMyjXYTPFCe+cbTE6nh/hls1LwmgOhHVJWYB1wzwgfFsjFmW0APdMAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB4820.namprd11.prod.outlook.com (2603:10b6:303:6f::8)
 by BYAPR11MB2806.namprd11.prod.outlook.com (2603:10b6:a02:c7::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.14; Fri, 18 Feb
 2022 00:39:54 +0000
Received: from CO1PR11MB4820.namprd11.prod.outlook.com
 ([fe80::586f:a77f:238a:ab8]) by CO1PR11MB4820.namprd11.prod.outlook.com
 ([fe80::586f:a77f:238a:ab8%2]) with mapi id 15.20.4995.016; Fri, 18 Feb 2022
 00:39:54 +0000
Message-ID: <e4d6dc06-30cb-1f92-32a9-d9057bcbf6b0@intel.com>
Date:   Fri, 18 Feb 2022 08:39:44 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.6.0
Subject: Re: [PATCH v3 1/3] mm: enable MADV_DONTNEED for hugetlb mappings
Content-Language: en-US
To:     David Hildenbrand <david@redhat.com>,
        Mike Kravetz <mike.kravetz@oracle.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>
CC:     Naoya Horiguchi <naoya.horiguchi@linux.dev>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Mina Almasry <almasrymina@google.com>,
        "Michal Hocko" <mhocko@suse.com>, Peter Xu <peterx@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Shuah Khan <shuah@kernel.org>, Mike Rapoport <rppt@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
References: <20220215002348.128823-1-mike.kravetz@oracle.com>
 <20220215002348.128823-2-mike.kravetz@oracle.com>
 <57fa170a-253b-932f-0261-b4905881d888@intel.com>
 <fad42051-6816-08cf-1430-ad4da5dbc951@redhat.com>
From:   Yin Fengwei <fengwei.yin@intel.com>
In-Reply-To: <fad42051-6816-08cf-1430-ad4da5dbc951@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: HK2PR0401CA0008.apcprd04.prod.outlook.com
 (2603:1096:202:2::18) To CO1PR11MB4820.namprd11.prod.outlook.com
 (2603:10b6:303:6f::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c7ed650a-0a90-4041-f643-08d9f2772df7
X-MS-TrafficTypeDiagnostic: BYAPR11MB2806:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-Microsoft-Antispam-PRVS: <BYAPR11MB2806964B5F3C88B68113DC61EE379@BYAPR11MB2806.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: S5/FFqrJcwOSc2OvuXE/5wvRgkEicR8aWKvisqcLaVorDsK24NlKqEM/PF8M/Y1gsudmbN9GqCHO/iMLHj7Gkb9e3TNqV1Cxgzol6HOrnExdJs74zCbad8AxIzf8gRMGX99D7S7cJShYBbNCzvWCDSdOeKzAUeKdC9N/GYtbVJnjEk44e0g4SK+P4kimL4v5LtS9S7Z+XYmhxSh5w6fTL9d+vyN20nd0sxVCtZJP8kbGBcxVKIHm4lmydC8xHCKYCDmarORpyviJu2+vLaWJrlBTw3LFXbry1nfhMGL0tA/ipPSxIBsyT65w1iBZcwHzTKNrJztRPPYuZptqGsCM2HfZkaiZL//8LVv+KOKPHzKqtYA2cy024sQKrksO1eq7FxmqcoXAefGzh5bZv3fmJr5EzcDI9xNTfc8EtXPn7nlEyTrmIA+i341aQ8bgRb8WGTRPpF/MEWy9sgGYeztioRzQY7SxMA1NIsuyTfBPy2s6FTWWedcHc9yeTbioKfHJewoZ7WkPjV4Dfb70wD4lhdIiwFzt9lzoClJV4md3G6LMLdeunCO7JfyareYGuvrvQsRVAajfKY1LzRtNv593NU7TwrtMQ+Grg1b1gTu4OddHuZalRedKcpr5iSUbARsuCtpKA+TVHwrzyYscIF8bSNGOCITBP5smUIIwFAVPVrWV2PA4M9CAKIJr2plw5G/YF1BwBOGbkf5pkird0h8ZaKfKVHhBgp4BTNr/IjcbhzrRg7l3FNb2lU0pWXi8hgUb
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB4820.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(36756003)(26005)(4744005)(2906002)(31686004)(66946007)(2616005)(186003)(8676002)(66556008)(66476007)(82960400001)(38100700002)(54906003)(110136005)(53546011)(86362001)(31696002)(7416002)(5660300002)(6506007)(6666004)(6486002)(508600001)(316002)(6512007)(4326008)(8936002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YllhcG53UTAxU0Z1dEZiUk9LQW1JSXM4TEpTMGJzQlBXdm1MbENkNUNTSGRX?=
 =?utf-8?B?cUd2bUdyZytNNzhib090WDBhY0JrWWh3UjBQM3ZrV0g2VmVVVkRQcHd0WlA5?=
 =?utf-8?B?SE1ZYVVJaGJJTzVRU0dMZWNKYWNDQmd2Zk1kbFRUeXJsc0pyMUJXTzdFaG9w?=
 =?utf-8?B?VmNvUXdJYk1qbmtWd2dYMER1cWdOcUpCcHdjeWNrMzdqN05VR3dCS0w1NXll?=
 =?utf-8?B?aldBWUNYcXp0NVV5Vmp6MlRkeFE0eFVBZG1WNXdxM0tLM0lqckJCdksxUXJh?=
 =?utf-8?B?cEhZTG1STFhsUHMxcG9ka3JQL3hjN0JndTZqbHRPUFFTaWE3R0Z5ajdMZVh0?=
 =?utf-8?B?SzJPOW94S1pkUUM5dEI3TjQrdENNVTF4VGcraVFucTRPTk5qZWxHZkJWeHRk?=
 =?utf-8?B?THVrNUlJOVQ3amp3amkvZWNKaTAwalBEZDVYdUtLUFhQZ3BoYlY2YmYrKzZp?=
 =?utf-8?B?azdCbFFkOFJGSnN5NXdIN3V6d1dDeEdMcnMzWGF0S2ZiemMyNlVZdDJFRnhC?=
 =?utf-8?B?MjVWTzBOTjZHVEI1Y2J4Qm9BSGZoNHVPdVFDb0lDb1BKUE9FaFNTb1ZWUWlr?=
 =?utf-8?B?bXN6NXR6anNycEdaSnhqUFpsSWVUV3h6RkJlQllRbHg5dGFjRlA3SW1vL1pW?=
 =?utf-8?B?bG5EbnlncE5YQ05TSStxY0FOcFY2eFhaWXpNR04wM2hvanByazVLZDZKZ1dv?=
 =?utf-8?B?UTlDMGJKUFFBUnBmTE1wNUtJNzR1RGJCYlFjdnY3VVVKMVVGcnkzQWdTTDlM?=
 =?utf-8?B?N2M4TUVhWk1nSE5YSWtRZ25NaVBKREEzcXhiSDU0T3FNOHFLNHc3c3V2WVky?=
 =?utf-8?B?RXE2amtwaDdLZ2V3UWdHWUsvTmZvSDEvUkhIckRteHp0anFuTlgzcURSL0tM?=
 =?utf-8?B?TTJEalRnMHU3QStUNHBDeUdzWEJEcXBMOVpaUHZ1Ry9jNEh6UWJDS2REUzAv?=
 =?utf-8?B?VlUvejNtRXVzWG9BczZFRmdya1J5MFE4ZTRFaDJVMmxyRzgwcmRNbkFmaEh0?=
 =?utf-8?B?dlM5QTJJME9zb2lmcXlaaTJpVGNwZ3NhR0dBNllHNDVIWGVOM01yeG1xTWdD?=
 =?utf-8?B?WTNhV3Z0eVdGY1pYNlBKeG5namFvSkpNUUNXS0hTM1NvbCtiL050dmVPZWNG?=
 =?utf-8?B?Umk5d2s0YmRkMmJaK3g3YmxBVjVZL1hCN0N4SmlaOVhXSGovUCt4U1hObUYz?=
 =?utf-8?B?Vk1TdWhDN3l5Wnh2RnFqZExjcjJmNmltZlZkYW13Y2kxdFcvVXFvajU3S1lt?=
 =?utf-8?B?dzV3cEZDeXEwY2FubVQ2T2hDU0FQckJzYjZQdUpDZUlVQWR5aWdsMnVlbjQy?=
 =?utf-8?B?dlVua2lEb05pN29NUk96ZVJjQnBDTmxhdHRRcmVwWE9taFZ3ZUlKQWpyOFd6?=
 =?utf-8?B?QkVpdlhGU3pBWXNmeE1vQ0R4Q0NzZnMzSjU5bVlUcFlXSTN3ZW5mNzFsU2N4?=
 =?utf-8?B?MjFZUlpkTXd0TjB1L2F0RXBmTzB6Y2ZHWjE1RTVhVkxDMjM0SkRCKzdVWVBI?=
 =?utf-8?B?aFBneXdZU01BVTlmUXRZTThiNzF6c2o5a2UvOHJiQXlOeXlINTE3R2FrMWsx?=
 =?utf-8?B?ek12NDRIL3dpQXpjWWd6bXloL29EeXdFWjlaV3RJeHdUMVhIc0thT3R4aURy?=
 =?utf-8?B?aWhRUzgzWFBVWW01Mk5mL0svU2JST2NpSGdmNEhpRThxNVVRbGdVbGhRdm04?=
 =?utf-8?B?NTlFNE13dlFTc1plTkgzQjVWRGw4dzRzMEloWHZwNW96dllOcnJvSi92QWJz?=
 =?utf-8?B?NWwvYWQvNkVLczhKajFUQlowSDJzV1BOUDUvQkordE9WWjJUL0JVWkIvYVMx?=
 =?utf-8?B?MUxNUmpMS2JZYVhNTnQyNnN2Vkh2ZGtyTE5EMXRxcDU0NEIvaDlsV0NaR2Ft?=
 =?utf-8?B?Uit1emtHeWsxZHhHWFBrSTZYQmYyY0t1aFlOZm43T0JtRk55cCs2MHBiQWVp?=
 =?utf-8?B?UTdFcVBVcytScXBHeDJJc3B4NjdYbXFNcUhKeTd0MWNrZzJyWVpGWXlQeEg5?=
 =?utf-8?B?QnNNSHR6aDNyZHl1NjNBUEdjVEtENnRjS3VSdlpzL09aRXJIRWN5UHJyQmdw?=
 =?utf-8?B?RldyeEgyenRPekZOTzlCWTcyRHFGTitYYzYvU3VTMXFFZi9uSmt6eXpHYmhV?=
 =?utf-8?B?b05SekpiUXQyWklaZ1A1bDV2cEtTaEtBRW44eXFrTnVEQm9hSUNMZXpkdTZI?=
 =?utf-8?Q?VYULAWoor3Yk7x6puTDIi1k=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c7ed650a-0a90-4041-f643-08d9f2772df7
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4820.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2022 00:39:53.9810
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CIVQpnRB1yGIMY7cHfWboHc5olP979aD2N62RUPQo97zsj1NfGyURLF6Y9mhL4RxvImiKo1LZD6bYsgXBqsB5w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR11MB2806
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/17/2022 4:58 PM, David Hildenbrand wrote:
>> In man page of mmap, NOTE for "Huge page (Huge TLB) mappings":
>>
>> "For munmap(), addr, and length must both be a multiple of the 
>> underlying huge page size."
>>
>> Should we apply same rule to MADV_DONTNEED? Thanks.
> madvise() already has different rules than mmap() for ordinary pages, so
> we'd much rather try staying consistent with madvise() rules.

Thanks for clarification.

Regards
Yin, Fengwei
