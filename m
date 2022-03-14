Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B04494D881E
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Mar 2022 16:32:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242511AbiCNPdw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Mar 2022 11:33:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237307AbiCNPdt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Mar 2022 11:33:49 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1947436B66;
        Mon, 14 Mar 2022 08:32:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647271960; x=1678807960;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=huN9F+BytXCY2WGjhijVnxLO0072WtbDfE3/yP7uK5o=;
  b=A3VGcSV+TEWZcPjRGuewJIxl3Mdt/RzXgqhMCsHU1hqHtUm+W/2a79qT
   4U5V/uU5AqeBzz9MMkF5mDYhBaALGPinUa6wvTQy+aVwfT45OS6RORryb
   3On4jBvNAPezdlsoq4LnfmBbynwOGRQtL1CN4n0HoPIENO4KHNQWm+tFW
   pMUr/Vmbyf4q1BJjo4glhFBNO/hpUIdVkxGLDj6/Ta2h3q1OyTBNCPoPZ
   4JAEv0TFa1vpNUYb8kudGQlbjO5V9jEjZeQ/nq7MrsswfRB5YxOjvM102
   o+F92N+5SdtAZp1fLYb+O+XRlGN+BfVcJaIxDVof0u7rDFK830l/CPzrB
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10285"; a="342486413"
X-IronPort-AV: E=Sophos;i="5.90,181,1643702400"; 
   d="scan'208";a="342486413"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Mar 2022 08:32:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,181,1643702400"; 
   d="scan'208";a="497655591"
Received: from orsmsx605.amr.corp.intel.com ([10.22.229.18])
  by orsmga003.jf.intel.com with ESMTP; 14 Mar 2022 08:32:39 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX605.amr.corp.intel.com (10.22.229.18) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Mon, 14 Mar 2022 08:32:38 -0700
Received: from orsmsx606.amr.corp.intel.com (10.22.229.19) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Mon, 14 Mar 2022 08:32:38 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx606.amr.corp.intel.com (10.22.229.19) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21 via Frontend Transport; Mon, 14 Mar 2022 08:32:38 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.170)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.21; Mon, 14 Mar 2022 08:32:37 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bu0igfYSoaz1OdVN0Uu2F7lOfHCDBiBvMVmoOkcF8wnZ+9OT+JJYUXcBKdhD4FcG0dZH0mVfCFsw++vZRrO6VPgWQ5i4KizddqrkwBc4rXZzz5e+JbSfT8Cu1Z38Rux63sCD7uhIVwTF2eMA2EOWd++qF6KZdh7abB2MCB7bV+5RobmMRwVDXjivqtmOrETFSaVcxzSijVSIFcrD5j1/FLS+2RxuY4OdOxj/mIP59CC/IhGzwl1oogrHmQW47Oq357q9CHK/oUEfVIosBVu+mLpEPX+KX5FmHYpH8DyRUFIciDnj1yxu8GA53QUZ8BoS5k/WhfjTJOk0ROhAn5kUpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gk3J69yyaECKiAvtsNCJiW+7xZs7OUxGEqxLb9VZpE4=;
 b=Sf2pJ6735YR7whe8LmLUvZzkOMfROYc9PocAYu07uh7M927ghE+TgVWXv3E/rRS2fZuUkAVkr81zMfCboRcIBuMSGaaNvbG5TTTUXdG0aooTedp+0hoN3k3Z8olPMLbER4EV675mf73uG7Y5yX0w0BcL9INaE7hsCqqqoXFhfMkp/XncrPL9IwkxBPjIFYcj/MmlMd8QwAsxAujUcvsj0v1ZwQbad2po5o5TNgbp1x6bGNYvKarlWQsoIci95fg5sWsC0xFfvuFJ9RxOxX0pBedu4VwieGKWiAA17Q3hyscPeTcWyE449426GZZtTarJYn/3MBW0t5FST7aDFb7EKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BN0PR11MB5744.namprd11.prod.outlook.com (2603:10b6:408:166::16)
 by BL1PR11MB5335.namprd11.prod.outlook.com (2603:10b6:208:31b::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.21; Mon, 14 Mar
 2022 15:32:34 +0000
Received: from BN0PR11MB5744.namprd11.prod.outlook.com
 ([fe80::ec9a:f02a:6fc1:c6c]) by BN0PR11MB5744.namprd11.prod.outlook.com
 ([fe80::ec9a:f02a:6fc1:c6c%6]) with mapi id 15.20.5061.028; Mon, 14 Mar 2022
 15:32:34 +0000
Message-ID: <7ff5e217-4042-764b-3d32-49314f00ff54@intel.com>
Date:   Mon, 14 Mar 2022 08:32:28 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.7.0
Subject: Re: [PATCH V2 16/32] x86/sgx: Support restricting of enclave page
 permissions
Content-Language: en-US
To:     Jarkko Sakkinen <jarkko@kernel.org>
CC:     Haitao Huang <haitao.huang@linux.intel.com>,
        "Dhanraj, Vijay" <vijay.dhanraj@intel.com>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "bp@alien8.de" <bp@alien8.de>,
        "Lutomirski, Andy" <luto@kernel.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "linux-sgx@vger.kernel.org" <linux-sgx@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "Christopherson,, Sean" <seanjc@google.com>,
        "Huang, Kai" <kai.huang@intel.com>,
        "Zhang, Cathy" <cathy.zhang@intel.com>,
        "Xing, Cedric" <cedric.xing@intel.com>,
        "Huang, Haitao" <haitao.huang@intel.com>,
        "Shanahan, Mark" <mark.shanahan@intel.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <4ce06608b5351f65f4e6bc6fc87c88a71215a2e7.1644274683.git.reinette.chatre@intel.com>
 <YhLhoMFPyOFZ2fsX@iki.fi>
 <DM8PR11MB55917F499CDF4CC7D426B0A7F63C9@DM8PR11MB5591.namprd11.prod.outlook.com>
 <YimWaAqEnXHbLdjh@iki.fi> <op.1itu5vkewjvjmi@hhuan26-mobl1.mshome.net>
 <Yis8LV99mORcLYs6@iki.fi> <Yis9rA8uC/0bmWCF@iki.fi>
 <97565fed-dc67-bab1-28d4-c40201c9f055@intel.com> <YiuQx+X9UQ2l22un@iki.fi>
 <e1c04077-0165-c5ec-53be-7fd732965e80@intel.com> <Yi65sM+yCvZU0/am@iki.fi>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <Yi65sM+yCvZU0/am@iki.fi>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MWHPR13CA0005.namprd13.prod.outlook.com
 (2603:10b6:300:16::15) To BN0PR11MB5744.namprd11.prod.outlook.com
 (2603:10b6:408:166::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c1257725-6965-44d3-bb3b-08da05cfdc79
X-MS-TrafficTypeDiagnostic: BL1PR11MB5335:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-Microsoft-Antispam-PRVS: <BL1PR11MB533578030314AA975F67E354F80F9@BL1PR11MB5335.namprd11.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: w/H8JFIdjgwWoYg25uj6/YkwWVcg22nIvZabIgY906+297V1SsEHYX2/MGPxuRX4qXeYOoxYhcmjuCBjqxmfV9j5PpE2EotgijCpvJ9FafJ2DJ3uX0j01+SxOpFA0/h9daMl1d5gPK4VEo2JqPlEz/gARK6phyYnEhVd+0D63pIbH/b2DLWCc1YJS89LK9duxEVpQmM1c3h/2pLjIUqn2PkSBHQ6vJId04rXRGCGujOSuLwzoeiEVOa/+9MH0qisSncp1juIp0Tne5Tbzy7cw4CeN01Svxc7bCa5TPnem5ipvzDGB8BjYOm+FdzeHWTRurm2QddAT+vMWzpf/YBg7l1y5vS+TthxuqURkn+WRY36gB6I+6KXgR34a0TPCP+/b2FT8QogRzks6TPX5DVe1+4tu/hticNgFxdxashRlub9y+TuTKhEEk9zktzwXMLcoXPt02Zwb62s/zYg5We5PDfY5l3DqQqnXZrpSuYFWaP7di0UGfJACytD87VqMN5XpdxKlrFRm/XmfCpDeHgI3ghnhDNAhjbmemaIYSV/8xitD5XdZwnjhrz1HRZgdgTpe2p6Ji1UNjcmhHe8puMLEwgdSFp27lBlzzkRQu2qV0BdmGP3rIyMMylSo3eha4vAuSUt6Ss1LjpW8hZLg+83tSvxQa994K9ZyxUYuKB6kYTDSeBUskR7smhEgDAYuduOrG19xr7c39kMvkap0TNmHtM9XopN8Z+x8nLn/UdQlcg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR11MB5744.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(2616005)(5660300002)(6512007)(31686004)(2906002)(83380400001)(31696002)(44832011)(36756003)(7416002)(8936002)(6666004)(82960400001)(66476007)(66556008)(4326008)(26005)(186003)(8676002)(38100700002)(66946007)(53546011)(6506007)(86362001)(316002)(54906003)(6916009)(6486002)(508600001)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WWFaQmx5bC8rZVdyRDQvUmVkWFZUa1l3clFuN3hXQTF3TkFsMXYzbnE4N081?=
 =?utf-8?B?TTVjTjh3dTJQSHJ4R0pWV2FRdmZBT1BoKzhWODNYV1g2dUpORHlGQWNlSmZF?=
 =?utf-8?B?cTFTdUVWRUM1OGljdVZDZUMrQ204cnlxR1JIZU5CdHUwY3gwMkVrWjFPYzk2?=
 =?utf-8?B?QmJkaXUzK0Z0TEcxSGt3ZEtKOGp6RVRzWkY4NHoxOHFHT1BZQWtkV1ZxWnc3?=
 =?utf-8?B?ZFpsaDdLSEg2aGl4MkRraE9kbWZtd0dDV3JiRjF3UnEzeER2TGZzSTJOMkFH?=
 =?utf-8?B?bDhZdWFzOUFGUXdIa2pteXlQYnB5Z3YyYzFXNkZSUEJ5K3NjMnJOa2g4bEsv?=
 =?utf-8?B?TzA2OEtsZ0hkb0tZNXVCTlhtb05BTDBVK3V0YUxJSWlOVzZsMGpLSHRYWnQr?=
 =?utf-8?B?VUZhdWlsdkRrUEZtazVCMitGQnJEaUtPM3BtbVpUczlKSFpGRzJoTThwTm83?=
 =?utf-8?B?eUJ4R05JM1VhZmVESS9hQnVwaWN3ZGRzcFZYMDloYWR2aEtvRmhOMCtJM2d2?=
 =?utf-8?B?YlNvNlFLbWQ0Yjh4eDE0S1dobmhaWFdqalFqTWk4cFlCMXFQazRiTmpwRHVJ?=
 =?utf-8?B?U25ieTBnd2IwRUxOQXNHYVVMaFFkUExmRzQ1NklzNWlzTU03ZTRPSDBCWjdF?=
 =?utf-8?B?cEp2aFVYYUFlUVR4VTZrS1VEUjVDbXpSaDBQWHNSMnYzcWU0K1NvN1dSTDkz?=
 =?utf-8?B?NEZJK0R5aVNEcUE2RWVqYU45ZHZXQXdrekoxRWRKUGpCRjhsWmxoZ1ZVTU53?=
 =?utf-8?B?eHZiSXFuOWt6dDJmbHNJTjhEYTJ6aU45OFVCalVTUS9WbnRIOHZLT3dCZjk4?=
 =?utf-8?B?d1R6MEtiSk5wTm9OYUU4QndzV3dRUjY5QmNQZnJBYTJ0THFqZzlSVTA3clY3?=
 =?utf-8?B?cmZvbGVqaHdLcTEvbGo0QnlKNUhKVm1jVE51clRLYnUxTFlaTVNmMFNFVWI5?=
 =?utf-8?B?MFRPc0NpYWJNT3NON3dSTEpYTXQ3M0RZSzRXMjFoZmYydWd4WjJMbXJBM3FR?=
 =?utf-8?B?aFE0VnZNNEplSWVSMzNaWEVnRzhmbDRpWTR3YVVlZkVVMkRpaVN5WkVlc1M4?=
 =?utf-8?B?Q1ZpYWg0ZFVHY21HRDI0b1VhZVU0b3c3aVZMS3NzMTFNUnIyREFIUHFqTlhS?=
 =?utf-8?B?YXNmTCtncEVXZ1RYWTlJY1FoVWlSd3pIanFPdmlaeWpSbGFXa3VOQjVzb0ow?=
 =?utf-8?B?eitzMmdDU1RNWk1SRGxYdmxsVllCMkJpZ0hHM2J6SHU2clZJNDBMSnM2REx0?=
 =?utf-8?B?KzRKdC85UndYUnl4OEVldTZBa0dFN2ZMVmdvMHZ1VFI0UDhHK1FkUUVPZGpX?=
 =?utf-8?B?anF4bmlHK0llbEJ0VklGT01sYklZVXNGbEw2M2FDVGVsVkl4YzZtcG5EWmVa?=
 =?utf-8?B?NHVINHAxdTAxOVVjeU5OQXd2Zk16NUZObXZzSmJNU0w5QVlESnJMLzJ0WTVy?=
 =?utf-8?B?dHE4czZWNFRwZk9YWk9RWUNNL2JNQ0tVMjI5dFJvRnpTV1NmSUNqNWE5NkFm?=
 =?utf-8?B?VXd1ZERMWTZMNmtPRExxY2lOS0pJbnFwNGZtQk1GWFNDZFBaREx6WDNvbGFk?=
 =?utf-8?B?SjJKQXdTaUpOTHMyT2hpR2VDa0FZTGJ1bW9vZkZPVk1MYXBwWjB3eUpoZmM1?=
 =?utf-8?B?b295NEo1dFo1dGRkZ2crNVdUekVmZmhsN3dxN2QvOHN5dCtmQnBqQ3lNTUh3?=
 =?utf-8?B?eUUvQnJFMkQzYjNmdXlqeWZmVlRsWnpBK3pWRENSS21GUDl0STh2ZjJ4dy82?=
 =?utf-8?B?Tk1XaWNUTmZ0Y0VUc2k0cWpEL3ZBKzBEenI3OGVxQ2R2L0FjRExrUVpUWENq?=
 =?utf-8?B?ODY4U1lQVXVpQzcxaVZJeXlSRmVLcFJQQXVIa3ozdHRCdmJTNEt4UGIvUXhh?=
 =?utf-8?B?YlNVS2lnc3hUR1ViM3ljU0E3TGU3cFVIYTJnajliZW8zMHdyNjU2UGFhWVdR?=
 =?utf-8?B?bm9tSFdlbkpLYk12dy9LeDRMSVE0b0JTMHJlVDF4S2gzSVIyeGROOHpjUTNn?=
 =?utf-8?B?UXBUL2NRRjRnPT0=?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c1257725-6965-44d3-bb3b-08da05cfdc79
X-MS-Exchange-CrossTenant-AuthSource: BN0PR11MB5744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Mar 2022 15:32:34.4961
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EV+GDabGbgxqekqHgI2OGNOQgYMnIzE54EjlCvSkNQ8TZwPHJXeiuNzz3ukqExDoqSNfx2w0uWYPTPxw+bRavgwHUCX3CZU3BZVQfR0z0tY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB5335
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jarkko,

On 3/13/2022 8:42 PM, Jarkko Sakkinen wrote:
> On Fri, Mar 11, 2022 at 11:28:27AM -0800, Reinette Chatre wrote:
>> Supporting permission restriction in an ioctl() enables the runtime to manage
>> the enclave memory without needing to map it.
> 
> Which is opposite what you do in EAUG. You can also augment pages without
> needing the map them. Sure you get that capability, but it is quite useless
> in practice.
> 
>> I have considered the idea of supporting the permission restriction with
>> mprotect() but as you can see in this response I did not find it to be
>> practical.
> 
> Where is it practical? What is your application? How is it practical to
> delegate the concurrency management of a split mprotect() to user space?
> How do we get rid off a useless up-call to the host?
> 

The email you responded to contained many obstacles against using mprotect()
but you chose to ignore them and snipped them all from your response. Could
you please address the issues instead of dismissing them? 

Reinette
