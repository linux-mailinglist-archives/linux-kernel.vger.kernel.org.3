Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A1D35330BC
	for <lists+linux-kernel@lfdr.de>; Tue, 24 May 2022 20:56:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240479AbiEXS4Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 May 2022 14:56:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240536AbiEXS4X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 May 2022 14:56:23 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C3041AF2E
        for <linux-kernel@vger.kernel.org>; Tue, 24 May 2022 11:56:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1653418581; x=1684954581;
  h=message-id:date:subject:to:references:from:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=/ud2ljbWz1juW25ZocVlXUxIWifMZ+mstkPTobHAg6g=;
  b=Z2aW4mLJy76J0uJqjR1hYC5EsSzofZMr9rHaVqcwZ0Nx2ldULgeSfhuN
   vj4Lv9+N3X0C67+Wh3SN6NYcKIVs4uxG9QE5hcEF8ZJvf5s0x+ROOYY7N
   GylfXlb0O7R6tlaUM/L74BiMnnxLx5sB+NMmgDstd7WL8zo+VFmuq75Yw
   QM+YDaU04Ct5NkgNU3rw0kbAOYXwd6VDmsEHom7AWyWldfZ8LH2fR5e4x
   KqnaSaPFgw01+65eK4tSAb4N8TTo7tGJLpTpQzXajDlv4mFq+OSZrVbdY
   +g4B2Ib7utO6aAIvsSu2wdSdNb3iQ2NsVCyy4V5SM16y562fr38Y8BDVN
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10357"; a="255689286"
X-IronPort-AV: E=Sophos;i="5.91,250,1647327600"; 
   d="scan'208";a="255689286"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 May 2022 11:56:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,250,1647327600"; 
   d="scan'208";a="578024125"
Received: from fmsmsx604.amr.corp.intel.com ([10.18.126.84])
  by fmsmga007.fm.intel.com with ESMTP; 24 May 2022 11:56:20 -0700
Received: from fmsmsx607.amr.corp.intel.com (10.18.126.87) by
 fmsmsx604.amr.corp.intel.com (10.18.126.84) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Tue, 24 May 2022 11:56:20 -0700
Received: from fmsmsx606.amr.corp.intel.com (10.18.126.86) by
 fmsmsx607.amr.corp.intel.com (10.18.126.87) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Tue, 24 May 2022 11:56:19 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx606.amr.corp.intel.com (10.18.126.86) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Tue, 24 May 2022 11:56:19 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.175)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Tue, 24 May 2022 11:56:19 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VW1xBevSQXbgICW03Jp7lF7KSUKKjL8ZFO8384yr8tCkvMfs2sU2jhKFWTW7HdKyH/CJcWZusahOEHinwTeKpH//+DF5L2HTXDIF4R9RcBt36IqQjZr/ZV46qGWK6F1kKIyh0WqaVUQRRktlPrUF3gt45dPxkVQU3eCxxeJ/Z5QMEDkYtmwdgwmJcC3/yZkOGfrHSOIYAlizuWpx9g8VB+wCYebWmzu3JAo6CX1paWKTBBVUXweY1ADN01cex4x9zJLixngPItHJ+WIot0ifgRcX2BGPf/0CGTdjVHdGS/kgvX7dE7kl9glVo+OMVfZ8rRzRjoomWZ5VvJdK/mflFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NfEnW9h9d2wfOy+qEqo4W21gwq+dwiSB+5+T2PiatOg=;
 b=fIJ8hs+f776LTFku7VpSjZ/SGfFaqYCt6oASAhf/MN4jYxiQQ37gIMdN/BME7IntiX7egrDHlMg87CgzvXi5+npukPaNjdj/GfjG7D/jjQLpOxu26Qp7nhZqrgchRjxf+TuHr93aVT9/agszbVYe3SZksB6Rc8x0dX8ofKA1KmD1/icel76AkMOFuCOQKNnxcMHytl4nICTAHAyb7kil0VCKjwqj14LmUMphJHk2dbIrKBpl0W2a4U59wBdIZKKNX6PA8i+TfUDkVzXYGvATAEcgDL64DmgTpD0rnakXZ3NqQ8BULqqbfmIsbYkB2ovWgh04B+93um+W0mFLKD6ihA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BN0PR11MB5744.namprd11.prod.outlook.com (2603:10b6:408:166::16)
 by DM6PR11MB2970.namprd11.prod.outlook.com (2603:10b6:5:65::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.13; Tue, 24 May
 2022 18:56:17 +0000
Received: from BN0PR11MB5744.namprd11.prod.outlook.com
 ([fe80::5459:7151:e684:6525]) by BN0PR11MB5744.namprd11.prod.outlook.com
 ([fe80::5459:7151:e684:6525%2]) with mapi id 15.20.5293.013; Tue, 24 May 2022
 18:56:17 +0000
Message-ID: <31b76df0-1b90-6494-57e7-fc9099c68e24@intel.com>
Date:   Tue, 24 May 2022 11:56:13 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.9.0
Subject: Re: [PATCH] x86/resctrl: Fix to restore to original value when
 re-enabling hardware prefetch register
Content-Language: en-US
To:     Dave Hansen <dave.hansen@intel.com>,
        Kohei Tarumizu <tarumizu.kohei@fujitsu.com>,
        <fenghua.yu@intel.com>, <tglx@linutronix.de>, <mingo@redhat.com>,
        <bp@alien8.de>, <dave.hansen@linux.intel.com>, <x86@kernel.org>,
        <hpa@zytor.com>, <linux-kernel@vger.kernel.org>
References: <20220518045517.2066518-1-tarumizu.kohei@fujitsu.com>
 <bc5e9175-e609-d5f8-da33-65e97d4fd813@intel.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <bc5e9175-e609-d5f8-da33-65e97d4fd813@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CO2PR04CA0191.namprd04.prod.outlook.com
 (2603:10b6:104:5::21) To BN0PR11MB5744.namprd11.prod.outlook.com
 (2603:10b6:408:166::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fdbaca17-4f21-48d5-6eba-08da3db71554
X-MS-TrafficTypeDiagnostic: DM6PR11MB2970:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-Microsoft-Antispam-PRVS: <DM6PR11MB2970CD58462382A5D33DC313F8D79@DM6PR11MB2970.namprd11.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +FZhvh33SScQoF6pWxkajQfNloI2YdvHoMMLsU3VQrML7vrHPPVFUq3DL6A7RIxLE30fazyxXjXDaG/E4XQa7fmqt1zPK6iNwWfgH2BIlFVbchITRE3P3d3Dr5uxErwUZYG8wP03yqFaqq8wpN5IMlPTh+vCMUi7UOyXQu1Qbp4DIpxsHygO1KWeFKks0DEgRQcHZLMdZCYazPQYHlraxFL5r2PGhVxJRcrc7nJ6ubRDAo0llvo4YLeavgM0Z7WXP9AsIAa1C/FJhIkLPjIp8epOWrsK9AOXFDqmWarMWPzbE9ZUgbpPcwyBB1WIbmwG7c8nVAifAZSg0vUEj3rG7vaDA0+q/0OyGpdLBD7+nH9Jns8pUvan1R6lotNJHzzRTSmiF9Nznvq00eDnStSs90lChP+BYRkjBvcDyyPO+k+ibNrWZF1ucO09ml1I/PW7fTChFLe3jRS5cxFJgABlpN1iuSPHvaOBdxqV6Q8GXTsfYmyM635PMuhsQM711TLVjZpB6k5l0SpahjjnTivkYwsKkW/y75XtSnFsnqnw8r+HqGBRKlNNwzADWtgy5VFOE9wHncRPW8f4stI8ELqfa+mRPv+Tf4/8u3EGub7W4JIlzV261Hch8+8HisF2B7SEUKv+WA3bIXs6LPd+1JhOVushVrizkkZwUfgEdI2m2jEyjBIrGMd5MAtgWIpfYAywsOnEsR+8BlvueWaIT9oQuU30J9Nf6ZzR7O+BYscXX3e/Jg5VmBqEQpN8MIfU/bdKXu/hFiy8jyFoA6XuC18tqA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR11MB5744.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(6486002)(6512007)(508600001)(26005)(31686004)(36756003)(5660300002)(2906002)(8936002)(53546011)(44832011)(6666004)(6506007)(316002)(8676002)(921005)(82960400001)(83380400001)(38100700002)(110136005)(186003)(66946007)(66476007)(31696002)(66556008)(86362001)(2616005)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WGJ6QWdSbDdnY1VBQnlQdVZkZEZRL3o5STBCN0hGZmd2cFk5disvS1BnNnBC?=
 =?utf-8?B?TXJxOS9DOWFKNEsxb09zZENKM3FBZk5jNThUbGFJMlJMcURWS2dpbjBSTzJE?=
 =?utf-8?B?d3F5QVZmZXRWb3pSUjJ0cnZockwwSFVhWWJKNW51Z3B3STNkaExENitOWDlW?=
 =?utf-8?B?bTVGSFlpWGk2Z0F0dm1kS2k3aWJKb1dhK1IzVkZmeHJPRWlQWVdGSjAxNW1D?=
 =?utf-8?B?MnVwYldIR25GdWhwUHY0dzJiYUV4eFZ6ZlZaRjI3alhhVVEvK0JOa016M1dZ?=
 =?utf-8?B?WnROdS9Oa3FDdE1kMmJWSS80SG1ZM0JkdW9xR1Z2dGlHMkdTQTJqMG9YeWJy?=
 =?utf-8?B?dytRK1hxMnlxZlkweGVnVnJpZGU0VjlSNkw3TzhOUHA4RWNsWllIWkRLN2N4?=
 =?utf-8?B?VW0rNVg5Y3NRcE81SnFET0gxUmtRNDI1RUlDWUZ1ZzFrTHM4UTk0eFdCRGNu?=
 =?utf-8?B?dVFHR09TNGRWbXdvYW51bUROUXN6U1EyWExUTndpdjNsRDJTbFUwZUMyck1Q?=
 =?utf-8?B?U0ExZVF1QlRHMzZ6WWNFS1pNYnFiVW1EMXBuSnlmekZTbTRWc0IzYjNUUFNu?=
 =?utf-8?B?NjRvbmdDUFU5TnAxdE1pa2JzWDVYRmJMRTlGemUrYUhpTnlqRlREQzh2SUZj?=
 =?utf-8?B?QzlFbm54c3JrT2pjeXdORi9OQjA1MUJNc2hQTEk5blR2VUY4SkRGQkpVUHls?=
 =?utf-8?B?WGNqaDVQaXhINENGMkh1aW43L1N6TU5rcWRJZGlPd0lTSzBhUjlnYWIvVmlz?=
 =?utf-8?B?UWtoV05zYlptWUJiTTdXVERwQUdIdm5jTk5tSlVJSHdUY0ZLei8ySm1oV1Bw?=
 =?utf-8?B?UGY2NE50T2NoTUFjd01STGlGN1dxUk1wYlJ0SVgyU3ZjZ3duMjIvUFVnbVlu?=
 =?utf-8?B?SDdKMXF6T2hZZmNyK0VFRDdJcUdDWVVTVGs2ZG5FaVcvOEh6eHFMME9WT2Z0?=
 =?utf-8?B?aURhU0ZLWU5rZ2pPTHdEZXU2Zm8xaExlS1pCUnBuaGtERDRkck00TkVkSHY3?=
 =?utf-8?B?dklERmgvVGRJcEt4Mm5hS3Mwa3pKYUQ5ZndtUUZ6Y2hEbUtpeWRDMnU0S0dD?=
 =?utf-8?B?cGZWZ3Z6NnRzb3V4bkp5cEFiOVhMdVdvYkE5bU1WTUVIcmVlYnNqWms1ZTAy?=
 =?utf-8?B?dlFaL3d2eEVLZlFYS1FtVE1ZL3lIb1BrV1ZXSHZtU0Rma1FDTkN6QXlxUENs?=
 =?utf-8?B?a2J5VmtsazhEWXpZNkx1N25rODFoai9EenlJaUEyNUZEc3hCTWhRbmhWeTVJ?=
 =?utf-8?B?UVlrVkxiZlhNS2NPWWhteGp6TWhZSGNJNlE5L0Q3RFhhZTdSQjF6RVJDaFpl?=
 =?utf-8?B?eklZWlkzRFo2NUUvR2dBM1RQTkZjSXZ0clN2eGtZekRMckE1Y1VrQzRwVnpJ?=
 =?utf-8?B?NHcyejNXU0M1dmJneTF3Z3hmRVZkRkp5UjBnRGZFeVNBVWZBSWgxMGxvV3VU?=
 =?utf-8?B?RWR2Y2dFcnNpckp5eXV2aG04ZEljMmhkY3Z4a1gwSUh4MnFLNVoxNXNKNWFQ?=
 =?utf-8?B?SEVrdElIZSt6WWY4VFl5TlBvQUdoZHUxcTM3L1dISzRENnhRZkpIMHI5ZHh2?=
 =?utf-8?B?ME5WdlJEbkhUK0xUOUxBM0N1dkZxd090YnY5S1VhelBkWERIeWNsRHhZVjFm?=
 =?utf-8?B?aWVpa0RFcmNGU3NQYkhnTitYSmIxZ1daQW00TWRzRngzbk80NjRkQTYyN2ZL?=
 =?utf-8?B?UUhNZFVDSlplbjlDSm5yOHRUQUtWN3RCbW9KdzBVbkN3WEk2bEU4UWlPM2FE?=
 =?utf-8?B?Qkh1b3Q3NmVqNW9YY3A4NUMzOG5keGxvN29pd2tsUVhSQVM5a2w3emZXeXY5?=
 =?utf-8?B?cmFzM2JybGpFZzUrS3hkMHZLTVl5YlZET3g0bEpubGd1OG45RVErRFh2WkFU?=
 =?utf-8?B?MTJ6dlVxbnY5NWJycEErbmFrTnpQdjE3NHF3alBENmV0UUFFVnNRamlJL1Jo?=
 =?utf-8?B?VjlmMWYzNlJKYlYxbWFzL1ZkQkxVd1o3OGhJQ0NnTFNLVlg0MmZBbThvNnFY?=
 =?utf-8?B?azE3ZXUxSGh1MUpWWWVxMkw5OHptSzlkbjBLNTFkZzRzQTJ6L1ZEUnAzN2dU?=
 =?utf-8?B?V3R6Rkd1ZFBQY1dRMmYrejRnNW1kb1RPTUVGaE9JRnFSbk9pSFJWbGpXUGRV?=
 =?utf-8?B?Q3owVXAvMUNpc1VLd0VFdUsybU1TVmRURDd3eGZlblVWaGhyVkZBYTVSVE9O?=
 =?utf-8?B?ek1oSVhmU1YyUk1OSlZMY255QUZrbklwQUhOWUE2WjFIdFBIcVVyZXpuOTdT?=
 =?utf-8?B?aVF0UnV5d3BiSHcxSVJaQTc2bnJwbCtxN0hTQ1V5WlRWbFBnc2ZobXNhSStX?=
 =?utf-8?B?cVQ3ZjZ0QUZrRXpDSWZIMllVZ1ZadFhZWGxTNzB0SlprSWh1OXdUWU5pdFMr?=
 =?utf-8?Q?GQyzjz8nldEtKJuI=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: fdbaca17-4f21-48d5-6eba-08da3db71554
X-MS-Exchange-CrossTenant-AuthSource: BN0PR11MB5744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 May 2022 18:56:17.4698
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Rx5MeGfw5RU4TX7+Vi5UxUubqVXTHWTTI15LO3xPdgfSyJfiTd8VQQcgD/OgjzXMjhAdKTf21kzGHIdEoM1D1HffHe++YT9LcI94Rm4sSB8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB2970
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-6.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dave,

On 5/24/2022 11:41 AM, Dave Hansen wrote:
> On 5/17/22 21:55, Kohei Tarumizu wrote:
>> The current pseudo_lock.c code overwrites the value of the
>> MSR_MISC_FEATURE_CONTROL to 0 even if the original value is not 0.
>> Therefore, modify it to save and restore the original values.
>>
>> Fixes: 018961ae5579 ("x86/intel_rdt: Pseudo-lock region creation/removal core")
>> Fixes: 443810fe6160 ("x86/intel_rdt: Create debugfs files for pseudo-locking testing")
>> Fixes: 8a2fc0e1bc0c ("x86/intel_rdt: More precise L2 hit/miss measurements")
>> Signed-off-by: Kohei Tarumizu <tarumizu.kohei@fujitsu.com>
> 
> Those commits are pretty old.  Is there any reason this is not stable@
> material?

While those commits are old the backport will not be trivial since some
lines affected did change since these original patches. I did not think it would
be worth the effort considering (1) the niche usages of this code, and (2) while these
patches can be found since v4.19 this code remains the only place in the kernel
that modifies this MSR (until the rest of Kohei's series lands). Apart from this
there is no particular reason why it cannot go to stable, we can surely make the
adjustments to make it palatable for v4.19.

Reinette

