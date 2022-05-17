Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9998652A7BE
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 18:19:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350812AbiEQQTe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 12:19:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230062AbiEQQTa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 12:19:30 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC9083A716
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 09:19:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652804369; x=1684340369;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=URyIEGimmFAH22gQbZDvDrfkgc9XfITldggBfu8ZcLM=;
  b=DSJkrWbKBMEnDykbpHcePQjz9zsNGVn5mAQQ7VcKs5A7uYUvftORySG/
   NobuSEZBLrpklmCynLrGE2ZZ/7MWZU3MUgm99hXZamYXxkOGL7ZXYnS7x
   bmTYy5gvJShFmcdW7YSU48uusCNPq8jdn2h5aTfjchFSJk+IBaBFZumNn
   hQm5V4IQD6+EFvIdZbWV5zMN0ztJM9q7iof0UIorDG7g9eodsA75URa4g
   MpGOimrVikBMIzeDDXvpo2zWB0K08owKCiVTEQIe0jx2sYj+Ta+qu5RT7
   QvETQ5gc/h7Pwht1F6DazOobdrdo5betERsrI5EPc7V9ebvFUzM7hqreX
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10350"; a="334281724"
X-IronPort-AV: E=Sophos;i="5.91,233,1647327600"; 
   d="scan'208";a="334281724"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2022 09:19:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,233,1647327600"; 
   d="scan'208";a="660681940"
Received: from fmsmsx606.amr.corp.intel.com ([10.18.126.86])
  by FMSMGA003.fm.intel.com with ESMTP; 17 May 2022 09:19:29 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx606.amr.corp.intel.com (10.18.126.86) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Tue, 17 May 2022 09:19:28 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Tue, 17 May 2022 09:19:28 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Tue, 17 May 2022 09:19:28 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.100)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Tue, 17 May 2022 09:19:28 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hBUvCeawMtQ73/QTGOy+DZJ+KLf4rSptU6ZtWgD13LAV0McnyAxkA3O+oGuiUdH1mfPaW8c0X8zdJDgtju4EEZovUq3dHCsqgMBF6vHEbWeUsEzgYut5t/OP4LoI6B2x305sJyTTfmYSpcfECjfdhFiBMiqzbOWiWxz6A4RkmwCMbcE6izvwW0HL+AbM2Gh1Y9MMaJFRlBLfooOVbQAxEagVKk7hE8YnL2o9Y1YG98qFDsudZ6QxHxTkF1AmrBKJ0pMrKoMD64zxjQMl/ViIxxHEuFZziR0qiwbxmyo6lHyiK/dvdDKR60LtGCQESBN34tgNJWQFR9TdWULmzzcLSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PDdia3otQ3WCm7P+oWbBWkgRPXbQOGi3yAqCdzWFX2c=;
 b=XV9wr070IzpCQNxxZ748OWWtlTOCMc9AmGibn8hO4KEv2f7pCp3S+rajHhIEB7sGObrJdIXm/FNnSUcmcXJQqhTeOuqqrNsLLws1uN5YU2oTTaJvFd1Bmhe4cfIbvZQKsq8H+td1LGhX0IY5SiSifiWYFI+hLi+uE/31/YTZ9fSYWN9QywxaErRNGED1seV5Gdg9E8kRGJ9Ns9iG5C3/5B8G586YGU3+iR+E6WVws/UrT4jVqpFHpZCFAQowugh6LlkYKdABmGbMpPm2H9hr8fJHPRw9larrr3qYlzcz41ithdPa/o8u5eViSLnnbjGr1jOXtDRU4MWMClzrran+mQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BN0PR11MB5744.namprd11.prod.outlook.com (2603:10b6:408:166::16)
 by PH0PR11MB4853.namprd11.prod.outlook.com (2603:10b6:510:40::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.13; Tue, 17 May
 2022 16:19:26 +0000
Received: from BN0PR11MB5744.namprd11.prod.outlook.com
 ([fe80::5459:7151:e684:6525]) by BN0PR11MB5744.namprd11.prod.outlook.com
 ([fe80::5459:7151:e684:6525%2]) with mapi id 15.20.5250.018; Tue, 17 May 2022
 16:19:26 +0000
Message-ID: <93459560-0740-57f3-ed15-caae370aa80a@intel.com>
Date:   Tue, 17 May 2022 09:19:21 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.9.0
Subject: Re: [PATCH v4 08/21] x86/resctrl: Switch over to the resctrl mbps_val
 list
Content-Language: en-US
To:     James Morse <james.morse@arm.com>, <x86@kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     Fenghua Yu <fenghua.yu@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        H Peter Anvin <hpa@zytor.com>,
        Babu Moger <Babu.Moger@amd.com>,
        <shameerali.kolothum.thodi@huawei.com>,
        D Scott Phillips OS <scott@os.amperecomputing.com>,
        <lcherian@marvell.com>, <bobo.shaobowang@huawei.com>,
        <tan.shaopeng@fujitsu.com>, Jamie Iles <quic_jiles@quicinc.com>,
        Cristian Marussi <cristian.marussi@arm.com>,
        "Xin Hao" <xhao@linux.alibaba.com>, <xingxin.hx@openanolis.org>,
        <baolin.wang@linux.alibaba.com>
References: <20220412124419.30689-1-james.morse@arm.com>
 <20220412124419.30689-9-james.morse@arm.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <20220412124419.30689-9-james.morse@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR02CA0030.namprd02.prod.outlook.com
 (2603:10b6:a02:ee::43) To BN0PR11MB5744.namprd11.prod.outlook.com
 (2603:10b6:408:166::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c8fd6c3a-eec6-4e73-7c04-08da382102b0
X-MS-TrafficTypeDiagnostic: PH0PR11MB4853:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-Microsoft-Antispam-PRVS: <PH0PR11MB485356157F5F240E781696B9F8CE9@PH0PR11MB4853.namprd11.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6haGT5HLmYVV1x+h0VAOYeEroYGEtqrjvAhcKpnPIUZT5VcLzy/rGjNxygwb5UzVBZ5WW0mspcPJs1UPmM+1Dj0QJvdbWicAhGgWjmlT95gnnkn8zCv495rfNXvqf+27a3budc1Y8kFK4h+ADxXya9+6l/stvVr3un4Pp1zJh2sdbB/FGJgvxmw6aixEjjkyCdLwYSbAztzlDeQudkTpt1LrNmGrz+/+uBsK3wXYfo/sIYCXnSDgK1khYNHM9e3RbNTbKhUqu8qjnnYuZLQSd+fF/YpM6NyWJYjjusyQAumqyATnXUobpbisqQM6ybNgZ9b1EPRkitRra10lRE158KCnzVZvNEK7vdKpYcJMlsjGeRt8w0QRs7ZLBMFysi8JQbbx3dCs0kBWpHK12yIXyk7sMM1/TZlc0IiOq+A1EPlHV6U7eUAgqVGitwjL78fiT+VFRbtLjmy8Eg304lqH0CwpFDMqApcPqoNspUYkDl+9VmwYnH5FZ4hBGCp6j7zZNgR8x8eWbZth/tibJ6Ekc9RVf25ZgJ9T4mqDH3fgSNiSQ5h17HXdDs7aS+NvLzfTomMbuoKUJIls3RX/3/zVftuZtvkMLSEjFwzKVpdzzuMlS0jeKypp4Gq07qRMBlHLrqxLprx0OSZSbBN1FDYGQzyhuGzKNGpJIDyB6sRmr5/XDFjcTdTRKFOlvFHSb6BwPlw6NcfXGp5AYudSyPzr803Y4RllHy4BAJ46NxBe/4U=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR11MB5744.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(316002)(38100700002)(6512007)(54906003)(31696002)(86362001)(186003)(66556008)(66476007)(83380400001)(53546011)(26005)(6506007)(44832011)(8676002)(5660300002)(66946007)(4326008)(6666004)(8936002)(31686004)(2616005)(82960400001)(6486002)(7416002)(2906002)(508600001)(36756003)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RlNUTS9XNmgxbHFzWUVPc3JCRmh0SDRnYmxTVUZGNXpndGloNzkyRGdLdkNJ?=
 =?utf-8?B?RjlySC9EMVRreUZnSWg3bUZCREFya25zNUhjcGxJTTNldTEva0lQM29SWnhQ?=
 =?utf-8?B?c2NlV2pRNFNEZTB1TTJXQS9hcFIrdS9WQ2s3cU1abG9rNkZkV3k4emt1cE0y?=
 =?utf-8?B?b1k2M3QyRkN3T1Y1dVBuNytWRWFsdm9oN3NpWXZyc0hSaUdLOU5WSmlOcWox?=
 =?utf-8?B?b3M3d09HU2hqY3RHNDI0TitraUFpUzh0Z05aTDRMc0ZPSUh3aFdUUEVURjNy?=
 =?utf-8?B?dkRNVzNwQjdrdkJ2ZXB4TEt2MzNkWXVOOGc1NGlRWkxyWjYvdDBnMjNCejJu?=
 =?utf-8?B?THMxMTBUVFVLbEw4dHlzc1hMc0NwS0FHaTZJUUNGR20xV2pjNXlvSXNURzIy?=
 =?utf-8?B?NWhOak5tYXgyWFh6RUtEK2JNWlNRL2dtMVpQSFZJbTlpM0hocXpjOCtMb3dH?=
 =?utf-8?B?Uk1iNU84ckZvMW1hYUpGME0rYjZMRC9xODhwcU5xcnFueTdNT3FmdGJ1NW9p?=
 =?utf-8?B?dDBDcUU0blFEclBlVDVRQklIcjVlOXdlYjV0M2tYZ0l1VmkvSGxSdkRZSXZh?=
 =?utf-8?B?akp5L0tHNzNyNCsxbjIvL2I3WEQ2WVVkNmFEamVueTRQRTAyWlFCUW51UlAw?=
 =?utf-8?B?Z3Bac0U2cUlvZE9wK1FLaTVhUGtDZjYrMENmOVl0N280N1ltd2VLYUtlM1k3?=
 =?utf-8?B?RUlEYXFvckd3VlVYSlI0R3dJdVFzYjVpNlFOQ0ZlWi9IWXpuZ3RiRk9hUGRi?=
 =?utf-8?B?S2VDLzlDa1lOS0g1U2x3dzdpRm1OZTY5OFZ1dVg4TFl5a3RnRWtTOUU4Q0xt?=
 =?utf-8?B?UnZjdWh5bnJMa1l0NHRVS2pISDV1RnpwQmJLYUJjQWxXdjh2YTEvL3BmRlZy?=
 =?utf-8?B?V1JrUWFYdi9YK1ZJam9hZ3ZVNDBYOEFhUWluSGR6U3pSSm02Z1JTTTZXM0pD?=
 =?utf-8?B?dkJ0akdQRGg4QzBxTzdiVHlGSHg5am1lczRxd3VicndNNnRjMU01QS94SzRr?=
 =?utf-8?B?YzFreVpyV3VJMWJmL2ZZSkRBNUliYWg5MVRKN3ZRQURGS2NoL0ZtMm5MdlIr?=
 =?utf-8?B?eHJSRWlUM0JHVXErUGhiM2tXU2V2TC9jU29DVTNSNXEydWZPaitFb1lWQlRa?=
 =?utf-8?B?OTQ0SXJOQVpQZVBJOUxXNWZUMldHVWlmWThuTDFwVUpQRGhLTjJ2dFNaMXZZ?=
 =?utf-8?B?MFlWb1ZNcmNBYStXcHBiZktMdnBOVmM2disvSnIzanVjWDBudnFrbWJOR0dl?=
 =?utf-8?B?TVVQWjdIajZsZ3VsL2RSOVhGUWhnc3hTbFkwb0llS2xkNi9DZWlBL0xobGdB?=
 =?utf-8?B?dTZOOTVJY0xVSXdGcDFzNW9BWWMvcFhLYm5yamhNem4rYTNDRjQ0U0w0YnUw?=
 =?utf-8?B?TjczZDVoSFVFWHA1KzhKWW5Ib0FNZFV5QlVyK2htbndxcktMc0pmd3VISGc3?=
 =?utf-8?B?UE4wLzZyN2F6VmxWeFJwUUxWTUVEa2lqV21mTXp4MTh2aEQ1RjY3clhqWkh5?=
 =?utf-8?B?QktYL005TWRWNWFGcGtFbnIxRDgzMDNNWk1UWFdubC9mZHQ5OXpwcTlPOTF1?=
 =?utf-8?B?a1NYMCtMUkV0KzQ5RnA4UGRuclBFVGRNRGE3alNyc09xV0hOUU0zUVREdEdo?=
 =?utf-8?B?NjRoMzRpVWJxaGZlRkNMd2xML3ZQek9OQkZwWlJXVHYybExaWnMzbThvVm5t?=
 =?utf-8?B?NnBZdjZVQ0V5YTBXTlMyT04rREFzNGJFNlFWdytpWG1SVzFsbWgzSmZSK3d1?=
 =?utf-8?B?RWh4Tytuck9JejhDVHBRWUFqZUs3NHQyQUx6My93b2FoQ0cwREFuSnk0bDBV?=
 =?utf-8?B?MkNFUFdtUkgvZ041NlZIaXBmbEhDTkNOYVh5ZnFqeHpSZEJoTk0zRDMwMjJF?=
 =?utf-8?B?RmhwWWlMMEJ3Z2hITzJ6VnVzOWZzT2ZjLzc2cDVRLy91Nkl4cmZVMzZEZ2Fk?=
 =?utf-8?B?YUdQTmZuZ3kxQjcvSmFEVlhidkVpYW55OHNJREY5dDVzbmpoZmZteXlmVS9V?=
 =?utf-8?B?dVZaWk9iK0E1Nyt1cFdGemlGOGFVZUtPK09TVkZlVEROalU4NldnZHNERXJV?=
 =?utf-8?B?dWFGQi9MQXEyRVg0eW05dmFvUjF5Qy9aMzJzUE5icGxtSEZrV1VwRlk2QWdt?=
 =?utf-8?B?M1NOKzJGZmczbGhmMzNEcG1aQUVLSjNrcFg4QmZWQmJuY2pFbzR3N2IzUFV4?=
 =?utf-8?B?ejBzTm11SWRySEhydklkLzZEZ1hyd0REQUxxcDcxYzNMOXYrak5XUWovZ3pY?=
 =?utf-8?B?VHVRQ0pIekdqenUvbUUvS3JhVDJSbFNJVlZZMWFxMlRwcDk1Rlg5Z1NxTkpX?=
 =?utf-8?B?VUZqeVlRc0NXNms5NGpDWGVGNTJrVktHRjd6KzdPNFhDNWgrZjVLb3hxbWhY?=
 =?utf-8?Q?6s8Zr4BnJn1s3/PE=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c8fd6c3a-eec6-4e73-7c04-08da382102b0
X-MS-Exchange-CrossTenant-AuthSource: BN0PR11MB5744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 May 2022 16:19:26.3573
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: U2nn1lDG1zfox3JYlnCRE1xS0Lj871CSKUnuf9cZFrdUoKISG3gTal7wR/hbtYW9E7BdM+vL7ZWxpUoBwpIJfPLR3b0dlu7/02XbJOEEZe4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4853
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi James,

On 4/12/2022 5:44 AM, James Morse wrote:
> Updates to resctrl's software controller follow the same path as
> other configuration updates, but they don't modify the hardware state.
> rdtgroup_schemata_write() uses parse_line() and the resource's
> parse_ctrlval() function to stage the configuration.
> resctrl_arch_update_domains() then updates the mbps_val[] array
> instead, and resctrl_arch_update_domains() skips the rdt_ctrl_update()
> call that would update hardware.
> 
> This complicates the interface between resctrl's filesystem parts
> and architecture specific code. It should be possible for mba_sc
> to be completely implemented by the filesystem parts of resctrl. This
> would allow it to work on a second architecture with no additional code.
> resctrl_arch_update_domains() using the mbps_val[] array prevents this.
> 
> Change parse_bw() to write the configuration value directly to the
> mbps_val[] array in the domain structure. Change rdtgroup_schemata_write()
> to skip the call to resctrl_arch_update_domains(), meaning all the
> mba_sc specific code in resctrl_arch_update_domains() can be removed.
> On the read-side, show_doms() and update_mba_bw() are changed to read
> the mbps_val[] array from the domain structure. With this,
> resctrl_arch_get_config() no longer needs to consider mba_sc resources.
> 

This sounds like a good cleanup and I understand it to not intend 
functional change, so a bit more information is needed on the change
in rdtgroup_init_alloc(). More below.

> diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resctrl/monitor.c
> index 497cadf3285d..5cc1e6b229d4 100644
> --- a/arch/x86/kernel/cpu/resctrl/monitor.c
> +++ b/arch/x86/kernel/cpu/resctrl/monitor.c
> @@ -447,13 +447,11 @@ static void update_mba_bw(struct rdtgroup *rgrp, struct rdt_domain *dom_mbm)
>  	hw_dom_mba = resctrl_to_arch_dom(dom_mba);
>  
>  	cur_bw = pmbm_data->prev_bw;
> -	user_bw = resctrl_arch_get_config(r_mba, dom_mba, closid, CDP_NONE);
> +	user_bw = dom_mba->mbps_val[closid];
>  	delta_bw = pmbm_data->delta_bw;
> -	/*
> -	 * resctrl_arch_get_config() chooses the mbps/ctrl value to return
> -	 * based on is_mba_sc(). For now, reach into the hw_dom.
> -	 */
> -	cur_msr_val = hw_dom_mba->ctrl_val[closid];
> +
> +	/* MBA monitor resource doesn't support CDP */

MBA resource does not support monitoring. Perhaps instead:
/* MBA resource doesn't support CDP. */

> +	cur_msr_val = resctrl_arch_get_config(r_mba, dom_mba, closid, CDP_NONE);
>  
>  	/*
>  	 * For Ctrl groups read data from child monitor groups.
> diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> index 9d5be6a73644..07904308245c 100644
> --- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> +++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> @@ -1356,11 +1356,13 @@ static int rdtgroup_size_show(struct kernfs_open_file *of,
>  			      struct seq_file *s, void *v)
>  {
>  	struct resctrl_schema *schema;
> +	enum resctrl_conf_type type;
>  	struct rdtgroup *rdtgrp;
>  	struct rdt_resource *r;
>  	struct rdt_domain *d;
>  	unsigned int size;
>  	int ret = 0;
> +	u32 closid;
>  	bool sep;
>  	u32 ctrl;
>  
> @@ -1386,8 +1388,11 @@ static int rdtgroup_size_show(struct kernfs_open_file *of,
>  		goto out;
>  	}
>  
> +	closid = rdtgrp->closid;
> +
>  	list_for_each_entry(schema, &resctrl_schema_all, list) {
>  		r = schema->res;
> +		type = schema->conf_type;
>  		sep = false;
>  		seq_printf(s, "%*s:", max_name_width, schema->name);
>  		list_for_each_entry(d, &r->domains, list) {
> @@ -1396,9 +1401,12 @@ static int rdtgroup_size_show(struct kernfs_open_file *of,
>  			if (rdtgrp->mode == RDT_MODE_PSEUDO_LOCKSETUP) {
>  				size = 0;
>  			} else {
> -				ctrl = resctrl_arch_get_config(r, d,
> -							       rdtgrp->closid,
> -							       schema->conf_type);
> +				if (is_mba_sc(r))
> +					ctrl = d->mbps_val[closid];
> +				else
> +					ctrl = resctrl_arch_get_config(r, d,
> +								       closid,
> +								       type);
>  				if (r->rid == RDT_RESOURCE_MBA)
>  					size = ctrl;
>  				else
> @@ -1922,9 +1930,6 @@ static void mba_sc_domain_destroy(struct rdt_resource *r,
>  static int set_mba_sc(bool mba_sc)
>  {
>  	struct rdt_resource *r = &rdt_resources_all[RDT_RESOURCE_MBA].r_resctrl;
> -	u32 num_closid = resctrl_arch_get_num_closid(r);
> -	struct rdt_domain *d;
> -	int i;
>  
>  	if (!is_mbm_enabled() || !is_mba_linear() ||
>  	    mba_sc == is_mba_sc(r))
> @@ -1932,11 +1937,6 @@ static int set_mba_sc(bool mba_sc)
>  
>  	r->membw.mba_sc = mba_sc;
>  
> -	list_for_each_entry(d, &r->domains, list) {
> -		for (i = 0; i < num_closid; i++)
> -			d->mbps_val[i] = MBA_MAX_MBPS;
> -	}
> -
>  	return 0;
>  }

With this removed, where is rdt_domain->mbps_val reset on remount of resctrl?

>  
> @@ -2809,15 +2809,18 @@ static int rdtgroup_init_cat(struct resctrl_schema *s, u32 closid)
>  }
>  
>  /* Initialize MBA resource with default values. */
> -static void rdtgroup_init_mba(struct rdt_resource *r)
> +static void rdtgroup_init_mba(struct rdt_resource *r, u32 closid)
>  {
>  	struct resctrl_staged_config *cfg;
>  	struct rdt_domain *d;
>  
>  	list_for_each_entry(d, &r->domains, list) {
>  		cfg = &d->staged_config[CDP_NONE];
> -		cfg->new_ctrl = is_mba_sc(r) ? MBA_MAX_MBPS : r->default_ctrl;
> +		cfg->new_ctrl = r->default_ctrl;
>  		cfg->have_new_ctrl = true;
> +
> +		if (is_mba_sc(r))
> +			d->mbps_val[closid] = MBA_MAX_MBPS;
>  	}
>  }
>  
> @@ -2831,7 +2834,7 @@ static int rdtgroup_init_alloc(struct rdtgroup *rdtgrp)
>  	list_for_each_entry(s, &resctrl_schema_all, list) {
>  		r = s->res;
>  		if (r->rid == RDT_RESOURCE_MBA) {
> -			rdtgroup_init_mba(r);
> +			rdtgroup_init_mba(r, rdtgrp->closid);
>  		} else {
>  			ret = rdtgroup_init_cat(s, rdtgrp->closid);
>  			if (ret < 0)

What follows this hunk and continues to be called is:

	ret = resctrl_arch_update_domains(r, rdtgrp->closid);

before this patch resctrl_arch_update_domains() would just have updated
the mbps_val but not made any configuration changed if is_mba_sc() is true.
Before this patch configuration changes done in
resctrl_arch_update_domains() is omitted when is_mba_sc() is true
but after earlier change in this patch it proceeds and will result in
configuration change.

Reinette
