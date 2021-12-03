Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC8E7467D79
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Dec 2021 19:47:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245514AbhLCSvT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Dec 2021 13:51:19 -0500
Received: from mga14.intel.com ([192.55.52.115]:18575 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233187AbhLCSvS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Dec 2021 13:51:18 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10187"; a="237259587"
X-IronPort-AV: E=Sophos;i="5.87,284,1631602800"; 
   d="scan'208";a="237259587"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Dec 2021 10:47:54 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,284,1631602800"; 
   d="scan'208";a="460133485"
Received: from orsmsx604.amr.corp.intel.com ([10.22.229.17])
  by orsmga003.jf.intel.com with ESMTP; 03 Dec 2021 10:47:53 -0800
Received: from orsmsx608.amr.corp.intel.com (10.22.229.21) by
 ORSMSX604.amr.corp.intel.com (10.22.229.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Fri, 3 Dec 2021 10:47:53 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX608.amr.corp.intel.com (10.22.229.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Fri, 3 Dec 2021 10:47:53 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20 via Frontend Transport; Fri, 3 Dec 2021 10:47:53 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.172)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.20; Fri, 3 Dec 2021 10:47:52 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cPk6kZ2buQREk66l10KSMmaJH5mmgZuV1XPWhVsYewSe5a6Vc5ECIjqyxpFNhz8jT51q34O2t+gvWseS+HaBS0irI9Iy3vYs6y7X/HZJDenubIBevzFyoBuPqw7ig/r7shwgIYihYDN4oOn4c9fHHeN9yw5duw22T10NfHRq0nf0KrHAYkQMdNMY29n1iTIFGV4e3s80ygIwJQPiAa6RSEeTGLM5lIDi/MCrXV5AuYnn357qhHPrM4bo4wDYEWyFk8dh7EjIsYCb+pTMSQDIDqfqteDR5NifRWIPU3sm2aTZtyjc8CLKC6ImdVc1KdLutjD11R2JYM2exUkBGirHEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ECRkvOSqkyS8udqGvN088mXTXMhME/msWXPlhUL0zkc=;
 b=Fx4GtwinekvH6IpBer74SUNVSwDNBGvg1jf7rrxAC5DI+xOcSIKr0+0+F1AFVQwK80t4ZGXQobuYJbzwOBewOzABfcOkK/Ubc0gB3cwOuTo/0gYD3C0ihjOzyAnMyNYZB3d5jTcvtqUuOt1W8Z2h52gzGUO/koZlKHGTnOgvJagt21hAFi7WCQYkMZ4eN6hLfS9QUlwS4f3rxAn4cKKI9XnUeh0M4mIkZDDxyhraIkl2P8kDLZNko4kPWNiGHkNOoqh5O+9Fwfq0C7opWvDnDkFqbcUOF45DNsrUEgdWO67C/+Z2P+7RKHKvKUBbJjXqAge4X9FeSZtWGqMxrWq+uA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ECRkvOSqkyS8udqGvN088mXTXMhME/msWXPlhUL0zkc=;
 b=wz2hyI+vQdn0i7zGIEXB1E5RiRERTMn4tow0IAOMKJX4LS9I5oWYv2attUPy074xk1e4CtkLg80MB08fBc2OGAo45eY3o9QCIdRZGa/6hidZaOPwfMGVtddZBifDpo/Go9+c/I9NwwHS6iS3pnBFqd0h5KVGVR5IvOShHrkrRPQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BN0PR11MB5744.namprd11.prod.outlook.com (2603:10b6:408:166::16)
 by BN9PR11MB5514.namprd11.prod.outlook.com (2603:10b6:408:103::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.23; Fri, 3 Dec
 2021 18:47:49 +0000
Received: from BN0PR11MB5744.namprd11.prod.outlook.com
 ([fe80::bcd0:77e1:3a2e:1e10]) by BN0PR11MB5744.namprd11.prod.outlook.com
 ([fe80::bcd0:77e1:3a2e:1e10%3]) with mapi id 15.20.4734.023; Fri, 3 Dec 2021
 18:47:49 +0000
Message-ID: <8e9352ea-b717-05bc-5120-b993605c1e7b@intel.com>
Date:   Fri, 3 Dec 2021 10:47:43 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.3.2
Subject: Re: [PATCH 13/25] x86/sgx: Support adding of pages to initialized
 enclave
Content-Language: en-US
To:     Dave Hansen <dave.hansen@intel.com>, <dave.hansen@linux.intel.com>,
        <jarkko@kernel.org>, <tglx@linutronix.de>, <bp@alien8.de>,
        <luto@kernel.org>, <mingo@redhat.com>, <linux-sgx@vger.kernel.org>,
        <x86@kernel.org>
CC:     <seanjc@google.com>, <kai.huang@intel.com>,
        <cathy.zhang@intel.com>, <cedric.xing@intel.com>,
        <haitao.huang@intel.com>, <mark.shanahan@intel.com>,
        <hpa@zytor.com>, <linux-kernel@vger.kernel.org>
References: <cover.1638381245.git.reinette.chatre@intel.com>
 <9ab661a845d242cb10a90ade997f8ebda33cc7c9.1638381245.git.reinette.chatre@intel.com>
 <1669c1b8-2d68-0d2b-931d-bdbfd9085b0c@intel.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <1669c1b8-2d68-0d2b-931d-bdbfd9085b0c@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MWHPR14CA0028.namprd14.prod.outlook.com
 (2603:10b6:300:12b::14) To BN0PR11MB5744.namprd11.prod.outlook.com
 (2603:10b6:408:166::16)
MIME-Version: 1.0
Received: from [192.168.1.221] (71.238.111.198) by MWHPR14CA0028.namprd14.prod.outlook.com (2603:10b6:300:12b::14) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.17 via Frontend Transport; Fri, 3 Dec 2021 18:47:46 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4b395252-282b-40b6-db53-08d9b68d66f1
X-MS-TrafficTypeDiagnostic: BN9PR11MB5514:
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-Microsoft-Antispam-PRVS: <BN9PR11MB551475FF756A9DCFB93DADC5F86A9@BN9PR11MB5514.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: G+MKZv59CUl7jGgLuLqBnob3ugBp1EwCBUvQ+LrZXB4Hj3dfX3aWen17gIb6Ib7rjZBSq4+5fqMkykTlPp/xc+pojhXNNK7nEhkuo1a0Zh2dig/lbQagfTWNOpL5Yym6nN7oXsbN/ZqiCi5QsnsxTs5kdEule3HrtZ+jUZTfknGht/ADdDquaIYGUHslZ8hw+n2rg0Ncsre7oEoyf7AD4mje+eNX1vwYSIxBq4vlVMOCAtq2KN76pqSD3/c/o0ycHX/Zy/TTIcq4I1SyVgW4OO8yIC8dZQO3acnwWuhMYUMf4dNRQlWwjjnAGNfTODEjukdboxZl1qbzJg7OjhRy/hWNDAhQC6hiqdGEiEH0W29HoPDdyeeuby+e8EF4+jB6ZAMacbSvoReQyFIDgyCL9W4eTzHAjcgOmr1mwSJYMMG6YuIEhvdjiRQqLbwieirc7g6Mqvv+YU/rN6vq4nuifCvIWz7dEtg1uQMHSerBUPYPTac54jxWivbjDXW+piltzkklWiAIHuItMS9ydSCkZVL02uY5s7xaACFbE1I+jJ4uF1mYBZTomAY9jckDHD9qa57KdOuIsV1fP17AyOuEoRV/OU/GEe9LYv9laVVXvH1xfAYQK0+dbl8fwCLi8XdXxTTfryfNUAIphb0jDVrbX54EYK7QeQvaaQIV5tURpK0laKpWNRmGjWVoarNuUWsrMeipLNJI4M71dV7sSCEQz8tfxRFSKQ/MstlIUh0HzXRDKEVn0nAA6OYfCbJ01Hdq
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR11MB5744.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(7416002)(8676002)(66476007)(83380400001)(82960400001)(186003)(508600001)(31696002)(4326008)(316002)(6666004)(53546011)(2616005)(66556008)(6486002)(44832011)(86362001)(5660300002)(36756003)(956004)(38100700002)(31686004)(26005)(66946007)(16576012)(8936002)(2906002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WWVHTEhnR3lBTGZ5ZDhqMUhBcUt0QWJFWUlranZGczdPTFZHMjNiVEkyTEor?=
 =?utf-8?B?Vm5MNGEwalJWTXY1d0wxTVJoWFFhRTB4N0hlVHUyc1AzTXpoR3U0RE53dVBZ?=
 =?utf-8?B?dlg4S2Y0clFxeXBXRUJxZW51Q2tscVhWTVgxWXZ0R1N0NkRZQmxsbEtFTWlG?=
 =?utf-8?B?akx5NzFuSFlONVhiMkdqK2JjSlhLaUk2OEh5SjUwVFphWFllSXZrUys3b1Vi?=
 =?utf-8?B?bXliVngva3JUR3NVcGdENi9NbS9RQzNxVkMvY01QWkJ5SU5jcXhRbDdXemdO?=
 =?utf-8?B?LzBkMHY3bGZwQ3pTSURVSVc1YnF0bHJrcUQ0VThWZ3ZtcU1lZW5xenhMY1dv?=
 =?utf-8?B?WXo5eHFVWUhsQng2NjRVTUo3VEg2TzQ1V0VsK08xZ1pRdVRrU2M1NU14aWNW?=
 =?utf-8?B?MHhOaStFdjUyRk1Za2MyQmFEMm8rZDZrb2hjRllybXJ5Uks1QkVXdEp0S3Rt?=
 =?utf-8?B?NUdPMmZuR3YwMUJMR29Qa2xka0dLT2dVY05ETk02dzJXREZJT0pEelN5Q003?=
 =?utf-8?B?dFk4UDdvcWtsT0ZHOXJjaGZkZ3NvaitQVnJZeVlnczJUays5RmZibk80WGxz?=
 =?utf-8?B?a1l1MWM2bElONDlEWmtvTnZ1RFd3dUp1OFVhTWZqUWdpRDhPKzZyMVBoWkpM?=
 =?utf-8?B?eTVmdWJlVXQvR2ZHSjcrVjJFdTVjMm9zZmJnSndKUHEzZGMrN29hT2NNUUlv?=
 =?utf-8?B?Yy9HQXBHbmM3M1IwbERDUzd1RXFGcnJxMllaTURuWjQwRnlSRlNZRU90TGxD?=
 =?utf-8?B?WTN6T0REUEwwSW4xejY5TUowTHh5Y09wM2xZeGw2dEZiVzJWTXJrVXN1V1Ro?=
 =?utf-8?B?aWxuNHo4TzJFcUJESTdUaTJaYmhHZmxxY2kzeWRlckg5RWlVcHFnL0w3eFBh?=
 =?utf-8?B?V1NPTyttWHhQZUJYbHpZN0IzNGgzaTRSaDVjTFVZTVdTYXl4cXg1NVlpNFkr?=
 =?utf-8?B?VEFqTFhIVjZETG5lM0FPOFFyWmxUUXduY3Y0Y3pGK2xpa3ZQcVB2U2U5SjI5?=
 =?utf-8?B?SXZPSWJDbXRzcVFWem5XNVJ4L0Q0U3IzSmU0SGFKMm9UaUhMS25ad2VrWFdy?=
 =?utf-8?B?a1JaY05rWlI2eE9iQUp3bVNwTHR4M0szVkxjVWdESXRuNjJ0UE5aV0poMjVK?=
 =?utf-8?B?RmZ1MEdHQjJJZnRQbW94cTE3L2tuMEVMUlhVbWZHSGJlbWFRc25jRzBPeTZp?=
 =?utf-8?B?M0NIeG52dGwyeFVwNmpmOSs3cGI3ZDVsTGc1ZVBhY2ZTOFRUUTB1dWZ2aDR2?=
 =?utf-8?B?ZjY0OFBXaDk2OHczQmNQWWlPc1MwZ0pmRko4MmtrNlhNeDFlSTZXemtaUExy?=
 =?utf-8?B?MXlCZ3ZiWEdGa2VLZmlSRVBrYzNBZTE1L0Q3MzlraTNMQ2o2UllMVHRCZHov?=
 =?utf-8?B?N2ZBcXVoc0VFaUQyNnhMSWRMRWw1V3gxQ2tnZk5hckpsYjdtT083VjA5KzhE?=
 =?utf-8?B?TmF0bVpyQ1FNaFFjZlBqMEs2WExxTFJwWlczb0pNTzNwZ2svMlVpdXRKQlBX?=
 =?utf-8?B?S0ZIMm5acms0OXZoVzdVNktpQjRVQUEzSDVWZjZzWWdjQUI0dlVIWXdKODR1?=
 =?utf-8?B?ejYwc3pBOUZGTkw0YW5yOC9KQ283bWlyaUlVdTN6SDkyMXl3VmQ0T24rQUEw?=
 =?utf-8?B?eHIwRzlRZllqdDYwQVpnUEtaZGRER1BZaFBWRSs2UnYwY3dqbFBreWcyUVJE?=
 =?utf-8?B?YVFaUU5rYllkVGtaTjlrVDN6N3IwS2JMVDEwT25qRFU2S25hYlRVcVdOWlpK?=
 =?utf-8?B?b3hCOXkxSEs0OWlMZ2lMMWpLVVZWNTlRbU44d2RuL2NHVGJ3WVJWQmh5NitC?=
 =?utf-8?B?eXB3aG9mN2lIU0JRenJNbVl3SDByckdZMjdmUXNjZDQzR3ZPMnRrT1pVMFFy?=
 =?utf-8?B?NVAzUk8zYmxVZko2KytkeHpFUXZkZlV1Skc0Z1Zmd3lOQVgwVlVIQ0hTYlpi?=
 =?utf-8?B?YnhPTmtBMG1ES3RuZEFybjVmVUhibVJRWjQ0TnRhRUdqd0k4aGpOODhybnE4?=
 =?utf-8?B?WUljS1RzWXRRK3dtbENDTGFYazZqQm9lNjkzbVZuTEZDSmo2NDZLekNxWlhi?=
 =?utf-8?B?NjlNVlMxYmd0SnhBVU8vOTh4aDFtOCtNdUh6czR0MDNsZUduYW5mdSs0aGVv?=
 =?utf-8?B?RXpuOFN6UHlpMmxTRjIva1Q5U0xLSExhemFmUzlVWjRVTEthZTF2NERDOHFC?=
 =?utf-8?B?UlY2NXJZWHU3anR0Sm00ZnpxSTNSaW1WU0FXMWdyd0VHK3dXdWRnSmlNZVZ0?=
 =?utf-8?Q?/O0I6zFwnezI3lbEmaq2sV8U8epDYGawhQwUFIIYSM=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b395252-282b-40b6-db53-08d9b68d66f1
X-MS-Exchange-CrossTenant-AuthSource: BN0PR11MB5744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Dec 2021 18:47:48.9320
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FsED6RsMhsCiMdfNQNnzVJlM8uLNneoD3FkJtCnx6rx+BLWdKFfk0Jyu3mhutB4RICY9XQtMscVGWCEK2hE36pbpv2FzBQQowLyqWNhKZBc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR11MB5514
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dave,

On 12/2/2021 4:38 PM, Dave Hansen wrote:
> On 12/1/21 11:23 AM, Reinette Chatre wrote:
>> +static vm_fault_t sgx_encl_eaug_page(struct vm_area_struct *vma,
>> +				     struct sgx_encl *encl, unsigned long addr)
>> +{
>> +	struct sgx_pageinfo pginfo = {0};
>> +	struct sgx_encl_page *encl_page;
>> +	struct sgx_epc_page *epc_page;
>> +	struct sgx_va_page *va_page;
>> +	unsigned long phys_addr;
>> +	unsigned long prot;
>> +	vm_fault_t vmret;
>> +	int ret;
>> +
>> +	if (!test_bit(SGX_ENCL_INITIALIZED, &encl->flags))
>> +		return VM_FAULT_SIGBUS;
>> +
>> +	encl_page = kzalloc(sizeof(*encl_page), GFP_KERNEL);
>> +	if (!encl_page)
>> +		return VM_FAULT_OOM;
>> +
>> +	encl_page->desc = addr;
>> +	encl_page->encl = encl;
>> +
>> +	/*
>> +	 * Adding a regular page that is architecturally allowed to only
>> +	 * be created with RW permissions.
>> +	 * TBD: Interface with user space policy to support max permissions
>> +	 * of RWX.
>> +	 */
>> +	prot = PROT_READ | PROT_WRITE;
>> +	encl_page->vm_run_prot_bits = calc_vm_prot_bits(prot, 0);
>> +	encl_page->vm_max_prot_bits = encl_page->vm_run_prot_bits;
>> +
>> +	epc_page = sgx_alloc_epc_page(encl_page, true);
>> +	if (IS_ERR(epc_page)) {
>> +		kfree(encl_page);
>> +		return VM_FAULT_SIGBUS;
>> +	}
>> +
>> +	va_page = sgx_encl_grow(encl);
>> +	if (IS_ERR(va_page)) {
>> +		ret = PTR_ERR(va_page);
>> +		goto err_out_free;
>> +	}
>> +
>> +	mutex_lock(&encl->lock);
>> +
>> +	/*
>> +	 * Copy comment from sgx_encl_add_page() to maintain guidance in
>> +	 * this similar flow:
>> +	 * Adding to encl->va_pages must be done under encl->lock.  Ditto for
>> +	 * deleting (via sgx_encl_shrink()) in the error path.
>> +	 */
>> +	if (va_page)
>> +		list_add(&va_page->list, &encl->va_pages);
>> +
>> +	ret = xa_insert(&encl->page_array, PFN_DOWN(encl_page->desc),
>> +			encl_page, GFP_KERNEL);
>> +	/*
>> +	 * If ret == -EBUSY then page was created in another flow while
>> +	 * running without encl->lock
>> +	 */
>> +	if (ret)
>> +		goto err_out_unlock;
>> +
>> +	pginfo.secs = (unsigned long)sgx_get_epc_virt_addr(encl->secs.epc_page);
>> +	pginfo.addr = encl_page->desc & PAGE_MASK;
>> +	pginfo.metadata = 0;
>> +
>> +	ret = __eaug(&pginfo, sgx_get_epc_virt_addr(epc_page));
>> +	if (ret)
>> +		goto err_out;
>> +
>> +	encl_page->encl = encl;
>> +	encl_page->epc_page = epc_page;
>> +	encl_page->type = SGX_PAGE_TYPE_REG;
>> +	encl->secs_child_cnt++;
>> +
>> +	sgx_mark_page_reclaimable(encl_page->epc_page);
>> +
>> +	phys_addr = sgx_get_epc_phys_addr(epc_page);
>> +	/*
>> +	 * Do not undo everything when creating PTE entry fails - next #PF
>> +	 * would find page ready for a PTE.
>> +	 * PAGE_SHARED because protection is forced to be RW above and COW
>> +	 * is not supported.
>> +	 */
>> +	vmret = vmf_insert_pfn_prot(vma, addr, PFN_DOWN(phys_addr),
>> +				    PAGE_SHARED);
>> +	if (vmret != VM_FAULT_NOPAGE) {
>> +		mutex_unlock(&encl->lock);
>> +		return VM_FAULT_SIGBUS;
>> +	}
>> +	mutex_unlock(&encl->lock);
>> +	return VM_FAULT_NOPAGE;
>> +
>> +err_out:
>> +	xa_erase(&encl->page_array, PFN_DOWN(encl_page->desc));
>> +
>> +err_out_unlock:
>> +	sgx_encl_shrink(encl, va_page);
>> +	mutex_unlock(&encl->lock);
>> +
>> +err_out_free:
>> +	sgx_encl_free_epc_page(epc_page);
>> +	kfree(encl_page);
>> +
>> +	return VM_FAULT_SIGBUS;
>> +}
> 
> There seems to be very little code sharing between this and the existing
> page addition.  Are we confident that no refactoring here is in order?
> 

I can understand your concern here because this code looks similar to 
the page addition code. Primarily because it uses the same objects (an 
enclave page, an EPC page, and a VA page).

The flow is different though because (1) the enclave page needs to be 
created differently to handle its static (RW) permissions as opposed to 
the permissions from additional meta data, (2) a different instruction 
(ENCLS[EAUG] vs ENCLS[EADD]) is used, and (3) the page table entries are 
installed which does not form part of the original page addition.

A major complication to factoring out code is that there are (slightly 
different) allocations needed before the mutex is obtained (enclave 
page, EPC page, and VA page) and then different actions taken on these 
individual allocations with the mutex held. With the mutex in the middle 
of difference in allocation and different actions it is not clear to me 
how to refactor this.

Please do let me know if you see any ways in which I can improve this code.

Reinette
