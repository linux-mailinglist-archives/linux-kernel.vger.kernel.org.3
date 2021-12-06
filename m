Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E333646AA9E
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 22:42:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352315AbhLFVqH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 16:46:07 -0500
Received: from mga06.intel.com ([134.134.136.31]:54154 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1352173AbhLFVqG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 16:46:06 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10190"; a="298211710"
X-IronPort-AV: E=Sophos;i="5.87,292,1631602800"; 
   d="scan'208";a="298211710"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Dec 2021 13:42:25 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,292,1631602800"; 
   d="scan'208";a="462009941"
Received: from fmsmsx604.amr.corp.intel.com ([10.18.126.84])
  by orsmga006.jf.intel.com with ESMTP; 06 Dec 2021 13:42:24 -0800
Received: from fmsmsx606.amr.corp.intel.com (10.18.126.86) by
 fmsmsx604.amr.corp.intel.com (10.18.126.84) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Mon, 6 Dec 2021 13:42:23 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx606.amr.corp.intel.com (10.18.126.86) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20 via Frontend Transport; Mon, 6 Dec 2021 13:42:23 -0800
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.174)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.20; Mon, 6 Dec 2021 13:42:22 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eIoBIgUygcwmOJBl8ruJp4mS+QsafBhFDfopC/giBjetZnyjS4Mq8LWRcPXIE4OHWj7gD1rXBNViAxEvLdiNUjeBnj9JEAFJ6kss//wLXnT5JU3b5VHilPAGtLM0QQ1o9+uAPjs1sdWOa1oeYItEIVWUOlVoOzArymXROn0FfQ6Tg1lJbp03IKHY57Zrw6rD5u94zcOePck5eLAhvT0KxV6HZPF+ObgM1P95Nd3wibQJ3REYVlhlXdVjpFHtIRQn/6vCAy80sjWAp1mWrEHr/33z38kev8w0BwMqMn0V2fw+6z7p1tgMnJIw8BNMXsDaJmnd1mSB9eaWgmKS+fCd1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Od+kGuiV7ffIyKEt/aQp1gFoqwnlJdItBszKe4KtZR4=;
 b=mUiUIIP+BKtzSML214Awrha2I+b3zWi9wGGGD/bOs/orfn6dGLHjJ1D5RLNVVAmFS4PiIExNYkA23/EO9CVVijyxJiOSr0qY9xPAM4URLRba06iK+Zk7VaChzJ9x4lO0wxdRoTppjUyTBx+izPyBL9UoXydkvBB31acDmjIhGoFZmGKlFW5qy2sF8hF4bMAEcJ08Veg6TWALQTxO+Dr5la8i6VJ2NcB7g+KACEMUd+zfHv2W9ifdQA6tb21JudmITAdRMdO7Z6odlZLbLYqs1fEskpCG9FVnWuRDfh3rX6Vum7hQ0uribfWQ5T5ahOD3yLJtmHDvIfgVIyS64jVKMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Od+kGuiV7ffIyKEt/aQp1gFoqwnlJdItBszKe4KtZR4=;
 b=mbKTxiNqifb4aNC7rlUwsAcCYuPfXyTGP3fFv+NQCcxbtciyoRY0dDWmFcK+X5joHW+vAKxCxtmYQDI+o4QjbHxaDh9lK7auk3Wlg/rqzoSmblBUaSY2kg9EnVQA6jeHFsudGf3UlbrJ8vNnxkVenzGQHegEvN60p9QIesav47M=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BN0PR11MB5744.namprd11.prod.outlook.com (2603:10b6:408:166::16)
 by BN6PR11MB1364.namprd11.prod.outlook.com (2603:10b6:404:48::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.20; Mon, 6 Dec
 2021 21:42:13 +0000
Received: from BN0PR11MB5744.namprd11.prod.outlook.com
 ([fe80::bcd0:77e1:3a2e:1e10]) by BN0PR11MB5744.namprd11.prod.outlook.com
 ([fe80::bcd0:77e1:3a2e:1e10%3]) with mapi id 15.20.4755.022; Mon, 6 Dec 2021
 21:42:13 +0000
Message-ID: <fff63bde-94a4-6c0c-3333-4cf392bee50b@intel.com>
Date:   Mon, 6 Dec 2021 13:42:08 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.3.2
Subject: Re: [PATCH 10/25] x86/sgx: Support enclave page permission changes
Content-Language: en-US
To:     Jarkko Sakkinen <jarkko@kernel.org>
CC:     <dave.hansen@linux.intel.com>, <tglx@linutronix.de>,
        <bp@alien8.de>, <luto@kernel.org>, <mingo@redhat.com>,
        <linux-sgx@vger.kernel.org>, <x86@kernel.org>, <seanjc@google.com>,
        <kai.huang@intel.com>, <cathy.zhang@intel.com>,
        <cedric.xing@intel.com>, <haitao.huang@intel.com>,
        <mark.shanahan@intel.com>, <hpa@zytor.com>,
        <linux-kernel@vger.kernel.org>
References: <cover.1638381245.git.reinette.chatre@intel.com>
 <44fe170cfd855760857660b9f56cae8c4747cc15.1638381245.git.reinette.chatre@intel.com>
 <Yav0/3jeJsuT3yEq@iki.fi>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <Yav0/3jeJsuT3yEq@iki.fi>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0274.namprd03.prod.outlook.com
 (2603:10b6:303:b5::9) To BN0PR11MB5744.namprd11.prod.outlook.com
 (2603:10b6:408:166::16)
MIME-Version: 1.0
Received: from [192.168.1.221] (71.238.111.198) by MW4PR03CA0274.namprd03.prod.outlook.com (2603:10b6:303:b5::9) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.21 via Frontend Transport; Mon, 6 Dec 2021 21:42:11 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f8d49f5a-a897-4f01-5654-08d9b90143ee
X-MS-TrafficTypeDiagnostic: BN6PR11MB1364:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-Microsoft-Antispam-PRVS: <BN6PR11MB136492C90A788BB8F7BE0F5AF86D9@BN6PR11MB1364.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RlGZy89FnEpSp+C3h11CHb+yPebKzdCR+JOaGf9tPXBAl2PLDaYTfuG4EtCsC4XYzEJUCOjUiIczpDbGNx96SH12nX1jNb+/qyqkUSLoEMZl2+5Idr2WTZ5T3w8BOWZH0YbJvfvPN+ZhpaVV9enzXVcm9jmKFp4H3E137WNydnfu5VxPqqrNzMGOBnbqAoE2Of7yIxQY8L9mOkOyz70PX+lpXKBYAYgdpBru4uA5qm24RR8UQnwBbEnuHJEjiJhes8tYaI6eIM7KtPQxw0mEyix5Cij1Y60GOPgqtAk7zMGv9yYBr90fUSisrkWn+oo/OUWMAUw7+fMXU87ut2V6Q1LUWI+pXvMjHuZGtsKFqqIYTNYrmAQbV577F32RPPJiWAFEMGD5W+5XooCd+N1GBrS4B3e8ccYUO4j0jKU1aSHfU/o6YeoZKgTI2cJBBTQXMPoc77MbS31ZUV8+sb46N7SZzuOWnXWXBxUdT6QSP0iZC1Mid4fTIfRiWuNXvVOOZaoXnKmsUDiilJejT7mvq1rqieliGHirj5nLxrS/SQ40l4NwINS2TVrKqxn4PnW/xoZQMd7Q3zRGZaeBhxuT+Qvv5+WsiG/0DQ5KAc1cW8EPN1+5vkY6fCfEQTH8PW22i6eRsPTCDKgwOYkIZfMKTUDMBzl6l0Tu6G9nWSkoozRR7bY7CU9dp3xNe6VmGBas0Q11EjTN+WgbGe/XaZixP7HxsLshXUT+KM5obyJEaU0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR11MB5744.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(7416002)(2616005)(83380400001)(316002)(6486002)(6916009)(6666004)(508600001)(38100700002)(82960400001)(86362001)(66946007)(5660300002)(31696002)(44832011)(36756003)(16576012)(8936002)(186003)(31686004)(4326008)(66556008)(8676002)(53546011)(66476007)(956004)(2906002)(26005)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?c2ZuekFzaVgwQWpJZHdrc2MydmRIdC8ra2w2NW5FUll1bUhScUJ5Ym4wVGhM?=
 =?utf-8?B?S1BubjMyb0VaMmcranBFdVVCdElpc0RrNCtnRExoS1Zvc1ZnYmRqaER2NTJs?=
 =?utf-8?B?cnB5SWRSekJFRDZDN0RtbEFudXAzYXZSNHZmVXVSQ0xCRWg2UXYyWm5sVUNm?=
 =?utf-8?B?ZWVRYUQwbWthaGhzNXIzTWxlUGp4Y1JldEkyMWNwTU1PUi9OakthdjVlQ3dV?=
 =?utf-8?B?d1hKYndNeTNBOEtFOXZFVzF6ekJ1Qkd5N1YzSlg4MzZsaUY3bU5ZenoyVGRr?=
 =?utf-8?B?VEZsZWVuSldzbkgveXRWdTBSdkhibWpJT2FPYmUvUWdmbGtSV1RwWGFIQm9F?=
 =?utf-8?B?aTRtM3ZqVTJvRmIza0RpMGI4K3l3NkVjWEpjU05GQ1VjcFdoS1pmMHN0dEd4?=
 =?utf-8?B?MXFkSmI2VEFYTDVScjNHU25vWk51OXVJakYzMWpKcXlsWUp2enhVZ2ZZK09V?=
 =?utf-8?B?SGhCNjRGS1l2SU12T1E0QkZkeXpuMFlCNnRmR0R5ZVNUcGJrajh2MFZFbnRu?=
 =?utf-8?B?Y0tRNjVCL2F2K2s4dHpNYkNrcW5LZmVtZ1J0bUtJa2RQak1BczIxWnFtSllk?=
 =?utf-8?B?Skh3aWViSTlQVjF4TVphdWZvRkNsWXdqQ3QyUnBQWUNyVVpZSjkweGR0VUlB?=
 =?utf-8?B?NkFCUnVQYTJjZ29vc20xcFgrcHdkUDZzc1ZWNkpBUUc1RUFnaEwzeTdwbHlh?=
 =?utf-8?B?R3h2eXpUakR1RUYxQUtPaXRaaVBwRG1FdXpEUVFMcXZBWHBUbGlNS24yY1JQ?=
 =?utf-8?B?UEloVGdGMU5rVS9Lc3NlOTdBTGxldU9aVXFYWXJZMFRvbVVXelZmOGswdUEx?=
 =?utf-8?B?Uzg2UjVXVXpSeG9PTUQ3YUord2hGeVlRdmdISkdicjNkNDlpbWtCN1daY0tU?=
 =?utf-8?B?VXRpdDh0N3hqZU9DRjNxS3dTOXQ2TWJKSmdzOWJDQmpyVXVPOTNCUGtMT3Z0?=
 =?utf-8?B?Wk1FaktyOXNJRzRjQ0NqQ3pZdDA4T0FXZ2lkMEV1TGNpTWUzTGNaK1lSYnhV?=
 =?utf-8?B?ZkpUUHhhVFpweVpxcklEdzczblJYSm1IRHBud0RDampwcjFIcVNkRXptVXVB?=
 =?utf-8?B?dGhuTXZXWWI3OVVxbXBGUit3dVhSd2pjTHZhNE5yNGhIRHlqT3BIZi9NQnN2?=
 =?utf-8?B?M1prUFhKdy9wOThDQXhyc2tNaVExL2JKMHZ4dGhjUjU2eWVJZDVHeEZxUkJn?=
 =?utf-8?B?VEVMbi96SUJvTEFGUk84M29oUUsyT0tlZ3NtMk9oWFVYY1pnMmFZZDA1SlVS?=
 =?utf-8?B?RDlDQklsZzJwRnBMd25ub2JCS0ZoOVlnWXRCUnV0KzdFNEVMNGV3RHowNVZ3?=
 =?utf-8?B?aFZNTG41Qnp0TGl4WmVWTlJXSExEdlFkZThvaVpPaGRSUE5jMExSUTM4YW9Q?=
 =?utf-8?B?Z095cng0Wkp4aDR5by9RTm0rSEJVdDNtVDBFY1ozMkMyd25WNmMvYiswQ2ds?=
 =?utf-8?B?M1NXZDRjMXNkZTFMdWFUalI1MlZueVVkVi9tR2VXNHUvTFBGc2o0Qmw5VWU5?=
 =?utf-8?B?SXE3NzdOZnpWQ2w2b1dZVWZFOHFvSTFUSjBNdFludGZtYkFNamYzYnVnTHFI?=
 =?utf-8?B?NFZjK2ZEeWU3N2FiRGFUZWRZcWI2aURnbUxDSmdwMFhQVEljMDByNDZUb05P?=
 =?utf-8?B?UWVXZFZVKzdyNjhHVUtPU2dKYitTYTA5bzV2dW9QYUd5ejV2aW1Ua1ZIRDRk?=
 =?utf-8?B?bVQrQzdidXJQR01ROS9jNE5kd0tTcmp1bFIxamtGZ2QvaFVJaGFzR1lZS0Fk?=
 =?utf-8?B?a28vcUVkbXVxQ0IvS2RGYkt1RTZTNlZBTHVvR1JhdmgrZ3QxakxnbkJCOVpk?=
 =?utf-8?B?MmJMVUdtL2Z3MFhWd2xNMXM4SlBuNFNEbmMyOUwxUnVxcEtORTBBMkZJMUpp?=
 =?utf-8?B?RWZWNkhEQys0UWxCbjczbWs0VkowTDBLcFJwSGxjcHpGSnNJS0xMS3RRYWRh?=
 =?utf-8?B?YlNZeDczN2g3QnNaYXZ6TGwyUng1RXMzTmowOUJZakFETkYybWlrNGdoVTFp?=
 =?utf-8?B?cnFvUUMzZnNlUm8wRzRHVm5leC9YZC9wL2kxMURrWksrK3ZkeVl6TER0V3ha?=
 =?utf-8?B?bVhMQ21xY3IxdUhvaGRWNEs0aVZNRXc5aVk1SzJRaGtLNkVEWHNCMktSTWVl?=
 =?utf-8?B?Z0M4VUJiRHNmQXRxK1U2eGVYSmNraUE4d2xzYVdzTE8wK2htNUhpQ0ZtVmNL?=
 =?utf-8?B?OFJkNGNRUmJmRVBKUnVEY3ozdGphSFZkQWVlTzRjb21KdTkxajd1KzNrR1NO?=
 =?utf-8?Q?et8cV9plgGsxeXflN8J2TAVeHrLh/cIDRUszNLt1f0=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f8d49f5a-a897-4f01-5654-08d9b90143ee
X-MS-Exchange-CrossTenant-AuthSource: BN0PR11MB5744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2021 21:42:13.7167
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UmcgFaPp9cshi7T6LLajsOBtpYfs36EJfgx8WVAOHjfmAyOfQHfNSMbdF8/LcgUUPoYcJQZ35x6EHuZw8almEFoEmaQhqAr6McUXY9AbBtI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR11MB1364
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jarkko,

On 12/4/2021 3:08 PM, Jarkko Sakkinen wrote:
> On Wed, Dec 01, 2021 at 11:23:08AM -0800, Reinette Chatre wrote:
>> In the initial (SGX1) version of SGX, pages in an enclave need to be
>> created with permissions that support all usages of the pages, from the
>> time the enclave is initialized until it is unloaded. For example,
>> pages used by a JIT compiler or when code needs to otherwise be
>> relocated need to always have RWX permissions.
>>
>> SGX2 includes two functions that can be used to modify the enclave page
>> permissions of regular enclave pages within an initialized enclave.
>> ENCLS[EMODPR] is run from the OS and used to restrict enclave page
>> permissions while ENCLU[EMODPE] is run from within the enclave to
>> extend enclave page permissions.
>>
>> Enclave page permission changes need to be approached with care and
>> for this reason this initial support is to allow enclave page
>> permission changes _only_ if the new permissions are the same or
>> more restrictive that the permissions originally vetted at the time the
>> pages were added to the enclave. Support for extending enclave page
>> permissions beyond what was originally vetted is deferred.
> 
> This paragraph is out-of-scope for a commit message. You could have
> this in the cover letter but not here. I would just remove it.

I think this is essential information that is mentioned in the cover 
letter _and_ in this changelog. I will follow Dave's guidance and avoid 
"deferred" by just removing that last sentence.

> 
>> Whether enclave page permissions are restricted or extended it
>> is necessary to ensure that the page table entries and enclave page
>> permissions are in sync. Introduce a new ioctl, SGX_IOC_PAGE_MODP, to
> 
> SGX_IOC_PAGE_MODP does not match the naming convetion of these:
> 
> * SGX_IOC_ENCLAVE_CREATE
> * SGX_IOC_ENCLAVE_ADD_PAGES
> * SGX_IOC_ENCLAVE_INIT

ah - my understanding was that the SGX_IOC_ENCLAVE prefix related to 
operations related to the entire enclave and thus I introduced the 
prefix SGX_IOC_PAGE to relate to operations on pages within an enclave.

> 
> A better name would be SGX_IOC_ENCLAVE_MOD_PROTECTIONS. It doesn't
> do harm to be a more verbose.

Will do. I see later you propose SGX_IOC_ENCLAVE_MODIFY_TYPE - would you 
like them to be consistent wrt MOD/MODIFY?

Reinette
