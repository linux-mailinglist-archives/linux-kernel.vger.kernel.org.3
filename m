Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A12944CDF22
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 22:00:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230122AbiCDUep (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Mar 2022 15:34:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231417AbiCDUdD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 15:33:03 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 009512129AC;
        Fri,  4 Mar 2022 12:31:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646425914; x=1677961914;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=gAJgyTXNvatpeZna47K/7UYkFqWIZkGBGh80Q/4+8jM=;
  b=gz9O3kmADvVxB/93N9ckW0vr3bAn+F8e0iCUfj+YsIn7tnKIs34ZdBRZ
   FZP1zZLtMdR1INuPacPAvP2sIaI4UqCKGkP8tAGoGanX5ZRBgEs8ULSwV
   xZUMtgOXHqE7x5oIG1cbdwppZSjGzuCkRumLK1Z1sDrOjO3ldRE6S+xDH
   NWc5vab3P160j10JWT5Dr2glU6sLsEP6AaXENB60zlXeEXcRZLXF60Ajy
   58+wxDtvONNHAAfpvgLwTzSf0tAoBDckHZ+OgK/CidUaFTzuAHxleCCWq
   I868yG5hGVd3kGyGvE1AT7UsbDb+jA//teuYo6GsWQ5p3PRmPlHQK32wu
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10276"; a="234651235"
X-IronPort-AV: E=Sophos;i="5.90,155,1643702400"; 
   d="scan'208";a="234651235"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2022 11:20:19 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,155,1643702400"; 
   d="scan'208";a="509072719"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga002.jf.intel.com with ESMTP; 04 Mar 2022 11:20:19 -0800
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Fri, 4 Mar 2022 11:20:18 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21 via Frontend Transport; Fri, 4 Mar 2022 11:20:18 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.104)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.21; Fri, 4 Mar 2022 11:20:18 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F1yyAANOO5sLLld0iOhVjqLZGjpzLedqeZ473WFgGfFcH2buG8buqj3aWvxtZhIrHY8VRgKwEv2BaR3hzkkwsDtIrZnrZYAAFmnDUhtaaP8J9IBVPaIbjiSWF+wFR3ayGNzvWhaE8iDjZSLOonxeMf4dvxA0hzfi+t1clkR2RHlR/Mv1tczBaT8Odi+LGs6ZcZYUO3xom9JIfzqv2mEBMrq/0+uIeUJyJft0KlfPQyvFJXYO0s+YuO3T2Wl+1/MjpjiK0oFBK/+2g4jjJNLwnYOQCxScHVPNrwfNhzlZ0Sc3FYuX0YC3c2HJP532iFdd2n+BIT98BFpWDwD2HlKnEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8e0+QFAw1BfxGWJ4tueUe9p6d2jV5M2r6MgpK7pmGac=;
 b=SghOcaMU/TS+phWv1/0f1EC02//mZRhZJmxSBeO8IjBRAmjV/86cBKS5qH18ebWgUfMZh/2qEWF1LkyDpkRt/0sCTFnLcHh9qNwWWaawbLU0pr/e5YCiTN3ghXIa+yWt5/hFIEfpHrxyLxYPa0D8MgLPnxGJdhc+BOhzOBOZz/eNZOJF16y/3xsABbovMJkn4xN9XZtwhlmygT3RDuwdjyBP2KyXX5fIyxWh77MjZXGDuYYbfbOaDn8jDpP8nL9NMN37Sl2dCOgyvqo3UNiGP1aGw7gqUlBj/EgLd3SwQaS+2BXQRT/1H+xko3VRhRtAi1hRswIPNd2+UhZKWIoV8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BN0PR11MB5744.namprd11.prod.outlook.com (2603:10b6:408:166::16)
 by SA0PR11MB4574.namprd11.prod.outlook.com (2603:10b6:806:71::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14; Fri, 4 Mar
 2022 19:19:55 +0000
Received: from BN0PR11MB5744.namprd11.prod.outlook.com
 ([fe80::55e4:9a32:8e6f:4774]) by BN0PR11MB5744.namprd11.prod.outlook.com
 ([fe80::55e4:9a32:8e6f:4774%5]) with mapi id 15.20.5038.017; Fri, 4 Mar 2022
 19:19:55 +0000
Message-ID: <5bd4208d-4e82-cfc9-a050-3fdb9bdfeb3d@intel.com>
Date:   Fri, 4 Mar 2022 11:19:50 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.6.1
Subject: Re: [PATCH V2 08/32] x86/sgx: x86/sgx: Add
 sgx_encl_page->vm_run_prot_bits for dynamic permission changes
Content-Language: en-US
To:     Jarkko Sakkinen <jarkko@kernel.org>
CC:     <dave.hansen@linux.intel.com>, <tglx@linutronix.de>,
        <bp@alien8.de>, <luto@kernel.org>, <mingo@redhat.com>,
        <linux-sgx@vger.kernel.org>, <x86@kernel.org>, <seanjc@google.com>,
        <kai.huang@intel.com>, <cathy.zhang@intel.com>,
        <cedric.xing@intel.com>, <haitao.huang@intel.com>,
        <mark.shanahan@intel.com>, <hpa@zytor.com>,
        <linux-kernel@vger.kernel.org>
References: <cover.1644274683.git.reinette.chatre@intel.com>
 <5136c1984544a18aadf17df040dfd8c846a22f18.1644274683.git.reinette.chatre@intel.com>
 <YiHT9f+NQG2pcukg@iki.fi>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <YiHT9f+NQG2pcukg@iki.fi>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0328.namprd04.prod.outlook.com
 (2603:10b6:303:82::33) To BN0PR11MB5744.namprd11.prod.outlook.com
 (2603:10b6:408:166::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5a6419a4-e2cf-403c-45dc-08d9fe13f71b
X-MS-TrafficTypeDiagnostic: SA0PR11MB4574:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-Microsoft-Antispam-PRVS: <SA0PR11MB457480DECFB7E4C8DF72909EF8059@SA0PR11MB4574.namprd11.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jsXd4oS9zDu1nCoPqPjb5+qKlkFpXF2W3KDi1+om6uFy3dpgWlGu08n/ev9XXDtAz5RvD503oTJfHzL1fkp3Sfx+qijD86DnsnLAs0+53FYrR9KIrpF5IXn22NhHHZVZrJGdtAjaQDWvpmgcyOSOd6QCHhl9LnG41SY48v/149ZgJWTdxmNSYrF31BWcD8y7gI9eWA56E87I67TCjLuOQe8v7eqljOXDBwjMGGclpNY0lOtnSa/d5qJIjZpqTIBKpvvvYCEL3sV/hXPjb3JNz1lGa4igc9X/MTaHNMyUM9yMQ/JisrzFnIChzJPo4+UwRzJNpjeufdLlVb1ly4BvThHi2XwD6CSaZzH0uJfL5Mxf2RRrkvNjwfNZO1ifxl16qoZ0TqtTDYS5G1DpR9NcV2o0oohx2Rj/PWSXO3c51NFGpEdfh9nOvE2twFXaLruSpJaA6o1D4SP1ixjz3e+h/1CEw9DzDRMAl5onWI/5iE5cxYCsNLfXldH7TMgzj/wjwYqo+hB15NF+D8FVTD/bdbzdV2r4nMqM9yPTfjtzBQoJditRTCJigHMVisTgQi618WHb9hgCrkw9xJ4aLD5z4lcTc1sLgmd8qrRqdCuIJHnTgSYuGqjvoDXxKsYvscfZWxxuAiu9n9hyYKmy5vxLU3fZIIBxeZDVTLJtwQ1WzntX2n8/mv3RDkhjkxVeJ9m30rpjVHH/bnTW6tAKoSQ9SvB4nK62GQfiW//HCa5zsEY+ztInnrfdyXB1w39SBerXyIi1NEt5I73laF6I7JVNf5m5vlv4dlvZmdVdYSjRLf6GJpVaI9ps4tCu/8Y+0k7JQyUuj8ZtliGpn4UarwjMJRWX0v4KM9qUyOuyNJSzd/dgZ3wD0P7pg7YK7SxqFXGh
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR11MB5744.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(26005)(5660300002)(7416002)(36756003)(86362001)(31696002)(82960400001)(8676002)(186003)(2616005)(38100700002)(83380400001)(6486002)(966005)(31686004)(8936002)(44832011)(508600001)(2906002)(316002)(6916009)(6512007)(53546011)(4326008)(66476007)(66556008)(6506007)(66946007)(6666004)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TEpwTGdOZ3lzdzUrRXBvN2gwczZMTklCUUNpMGIvMmdKQzJaU0tZQ2lqbkRu?=
 =?utf-8?B?Vkw1SDRVbTNuTjdnQzZ1QXFlYWRKM3B6MU5GT014Z3VKSi9OWlg4Z1JENXVn?=
 =?utf-8?B?OTQ0eWh3ZGh5Vmg4dTBtbW1jTHd4eVNTbGtmWk10QkIvNVhEN3FFcDJjNGJW?=
 =?utf-8?B?RllQR2tFOEViOGU5QnNLOHV3QkMyZkZCVzNvM2tOSk5vZmJDL0VlK2x3aDJQ?=
 =?utf-8?B?ME9kQTF3ZlY1eWpHQWkrSnBlR0xacm41QnN6QmFVdWkyS0Ntemt2dk9Kajhp?=
 =?utf-8?B?NEpyWEVnM2FncW52cEkvT2tDTjJqMTV1cVN5b3JhYkhpZXR5cHZQenJJaVgy?=
 =?utf-8?B?Q2VuTGZweXc4WE9uN3FJQVJCVElWdkpSWlNySkZvUEVTYWRjcUVQMlIzU0l5?=
 =?utf-8?B?S2lvWS94WTdLV2Z5NG9rZU1rMHRpVGhTWlhPU1BKdkxoVzJ2STU0MFpIU2F3?=
 =?utf-8?B?RkxvN0RFQnBQR205M0t1bzFnNU9lMGE4bFQ1ZWFIN3Q3TlRHTXEzNFZIZnpj?=
 =?utf-8?B?RWtPaGl1OFFWQklKbVByai9CQnBqWURCZHNXT2c2YWZCS2VrOTdhZ2g3bXZw?=
 =?utf-8?B?ZXNRWFJxNGNDQk9PMWU1YVpLekVlVEttaXVJRzlQK2pQVzFrWTBhUFVpcmxH?=
 =?utf-8?B?Ui9NVCtKWmcvMVpvWnFqeGZ4Z3VNME5ZZjF0TGtpNW5kTEZrQWJ2ajJZbExn?=
 =?utf-8?B?amwxSEdsU2RudkVEczVmR2ZFM2lBZjhlL2hvMDZsU2gwN25vT1grMmdPdVZz?=
 =?utf-8?B?VWl3RUJZQ3FIUzdiVExYTDFRVGkwQ1docm1rb0pWRWZMbVAwNG5VRWVIdTY4?=
 =?utf-8?B?QUprekt2Mks1R2x4elZxR1Y4a1ljU1p1aXlvOHA3VXU3Y1hLQyt5VTZuNEha?=
 =?utf-8?B?d2hjNEorU00xdzV5Nm1yL2hBYldBbWJNUGp1Q1FvbzRZVGhqaHZRWUV2ZTJi?=
 =?utf-8?B?S2FFbHh3cTBkMERiL25QOHI2QTZyVXhJRzFnQkNDajZ5L1BpYktSOTBPN0Z3?=
 =?utf-8?B?Tm82a1RrWndxckNEaFhPTDR4dndkYnNJcldEdGtjb3d5djc0bWEwQjlBTndB?=
 =?utf-8?B?WlgwdEFpZjRVUUthbWVwZ1lpUHRPeXpzVVZ3UUo3aXpCR0RKOVhBVVVzQ1VQ?=
 =?utf-8?B?dElNOFpmMkhRSGJLcWZjRVRlZWZSSklHN2ZZcDBBRnBtOEpaSE9mbzFuYmdt?=
 =?utf-8?B?OC9zUXR3N01IZFByM3VES3FqbERyUGtGMjFHYUZZMW9SZnVQeDRRanZ1c0J5?=
 =?utf-8?B?aE1WR3Q5L1NqS0Iwd2JJQWFiZVR4YW5WV1IwWVZHQ3NKbkIwb0ZrT25VNWQ4?=
 =?utf-8?B?RUxIQ2h4MjhUSkpCVmU1UUJKYnBEK3dwd042L1NDaWZGRjlkQlNSdHoxdzk5?=
 =?utf-8?B?VDFGdTRKY1BEMXhxazNkb2xSSnFpdjhiRDZ5YnkwLzFFa3lCNjJYVWxXUEN0?=
 =?utf-8?B?a2tTWGttOFBjY3hXaDZIRXFFZk5WRzdZelMxbnBCWjN1YmdFRWRwZjIyeEkr?=
 =?utf-8?B?UFJoUm4valZLS3hkMll2MEFUSU9SM1E0cHhCdkdlZTBaVGFMZHp6VjBSZ0pI?=
 =?utf-8?B?MDcrNTFHRDlHeW1Ud3o4bklhNmdrSjFXS2lQYW1XdWFOdEJkck10cFpQenNS?=
 =?utf-8?B?d08yYVovK0ltQm5vZHlBWjhGcWpSb0EwYzBNOFgwSm1ObWtqU0d5ZlkzTXRD?=
 =?utf-8?B?QzBIMm9PeE1uZFJzUlVvbFM3RC9OMmJCaEdzL1JGR3JWdkRXdm1FSU5vNlVq?=
 =?utf-8?B?WGQ4d3R5S3F0OHRaZVJjMnZPbmFOTThBN3VvREUzRGVvWEYrdEJ0Y21ESDRC?=
 =?utf-8?B?eEFpU054NVhLb2VBcTRJREV6Ky9QVStBYkpFUDZhU0REb3dSNTlVTEw2enU2?=
 =?utf-8?B?bmFXUkEwcmp6SXZZRlJqZEZMMGlZYnd2TUlFTXJCRElkRzBRTGRkUEVQYmpM?=
 =?utf-8?B?a25yM21aZTRLbFdzUngwcWpoN0tkeWZVTC9mckpuU3ZEY2dZTTdENmxwSmRJ?=
 =?utf-8?B?M293bGYwdEdsK29DNXBYcENrbUJ3bktXbkwwWWtqYVV1Q3JnbHMwZ2hlYUdZ?=
 =?utf-8?B?aTNhanc5UDk1VzRkbXNsazI4UHo3YWpqOVNiRmdqbjUrK3dNakVmTDYrNytT?=
 =?utf-8?B?WmRvcG9KcEd6Q1A5UVB3dDZNYjBSaS9ZSzhyRVc4SHlGOHdaMlBUWWE0aWFH?=
 =?utf-8?B?eERsb3oxV1hBM1VrdkpKTTZvS0p5WlhXVnN2Unk5RzNqZkpvYmRsR3JTUWxi?=
 =?utf-8?Q?7KPS5FIsy0591FY8bP0g99CVjzYn8QpL7LundaajQM=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a6419a4-e2cf-403c-45dc-08d9fe13f71b
X-MS-Exchange-CrossTenant-AuthSource: BN0PR11MB5744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2022 19:19:55.5572
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MxCpF1sQXxCtuskdRIZ8kZks8eyyrln3iHNso75Pr9QiRyN2B2MXnwDAEeGb5vPX8ExHf13zvzOMFgPKbHNRPPRvHq3IdrQNP2OpT/S4mU8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4574
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jarkko,

On 3/4/2022 12:55 AM, Jarkko Sakkinen wrote:
> On Mon, Feb 07, 2022 at 04:45:30PM -0800, Reinette Chatre wrote:
>> Enclave creators declare their enclave page permissions (EPCM
>> permissions) at the time the pages are added to the enclave. These
>> page permissions are the vetted permissible accesses of the enclave
>> pages and stashed off (in struct sgx_encl_page->vm_max_prot_bits)
>> for later comparison with enclave PTEs and VMAs.
>>
>> Current permission support assume that EPCM permissions remain static
>> for the lifetime of the enclave. This is about to change with the
>> addition of support for SGX2 where the EPCM permissions of enclave
>> pages belonging to an initialized enclave may change during the
>> enclave's lifetime.
>>
>> Support for changing of EPCM permissions should continue to respect
>> the vetted maximum protection bits maintained in
>> sgx_encl_page->vm_max_prot_bits. Towards this end, add
>> sgx_encl_page->vm_run_prot_bits in preparation for support of
>> enclave page permission changes. sgx_encl_page->vm_run_prot_bits
>> reflect the active EPCM permissions of an enclave page and are not to
>> exceed sgx_encl_page->vm_max_prot_bits.
>>
>> Two permission fields are used: sgx_encl_page->vm_run_prot_bits
>> reflects the current EPCM permissions and is used to manage the page
>> table entries while sgx_encl_page->vm_max_prot_bits contains the vetted
>> maximum protection bits and is used to guide which EPCM permissions
>> are allowed in the upcoming SGX2 permission changing support (it guides
>> what values sgx_encl_page->vm_run_prot_bits may have).
>>
>> Consider this example how sgx_encl_page->vm_max_prot_bits and
>> sgx_encl_page->vm_run_prot_bits are used:
>>
>> (1) Add an enclave page with secinfo of RW to an uninitialized enclave:
>>     sgx_encl_page->vm_max_prot_bits = RW
>>     sgx_encl_page->vm_run_prot_bits = RW
>>
>>     At this point RW VMAs would be allowed to access this page and PTEs
>>     would allow write access as guided by
>>     sgx_encl_page->vm_run_prot_bits.
>>
>> (2) User space invokes SGX2 to change the EPCM permissions to read-only.
>>     This is allowed because sgx_encl_page->vm_max_prot_bits = RW:
>>     sgx_encl_page->vm_max_prot_bits = RW
>>     sgx_encl_page->vm_run_prot_bits = R
>>
>>     At this point only new read-only VMAs would be allowed to access
>>     this page and PTEs would not allow write access as guided
>>     by sgx_encl_page->vm_run_prot_bits.
>>
>> (3) User space invokes SGX2 to change the EPCM permissions to RX.
>>     This will not be supported by the kernel because
>>     sgx_encl_page->vm_max_prot_bits = RW:
>>     sgx_encl_page->vm_max_prot_bits = RW
>>     sgx_encl_page->vm_run_prot_bits = R
>>
>> (3) User space invokes SGX2 to change the EPCM permissions to RW.
>>     This will be allowed because sgx_encl_page->vm_max_prot_bits = RW:
>>     sgx_encl_page->vm_max_prot_bits = RW
>>     sgx_encl_page->vm_run_prot_bits = RW
>>
>>     At this point RW VMAs would again be allowed to access this page
>>     and PTEs would allow write access as guided by
>>     sgx_encl_page->vm_run_prot_bits.
>>
>> struct sgx_encl_page hosting this information is maintained for each
>> enclave page so the space consumed by the struct is important.
>> The existing sgx_encl_page->vm_max_prot_bits is already unsigned long
>> while only using three bits. Transition to a bitfield for the two
>> members containing protection bits.
>>
>> Signed-off-by: Reinette Chatre <reinette.chatre@intel.com>
>> ---
>> Changes since V1:
>> - Add snippet to Documentation/x86/sgx.rst that details the difference
>>   between vm_max_prot_bits and vm_run_prot_bits (Andy and Jarkko).
>> - Change subject line (Jarkko).
>> - Refer to actual variables instead of using English rephrasing -
>>   sgx_encl_page->vm_run_prot_bits instead of "runtime
>>   protection bits" (Jarkko).
>> - Add information in commit message on why two fields are needed
>>   (Jarkko).
>>
>>  Documentation/x86/sgx.rst       | 10 ++++++++++
>>  arch/x86/kernel/cpu/sgx/encl.c  |  6 +++---
>>  arch/x86/kernel/cpu/sgx/encl.h  |  3 ++-
>>  arch/x86/kernel/cpu/sgx/ioctl.c |  6 ++++++
>>  4 files changed, 21 insertions(+), 4 deletions(-)
>>
>> diff --git a/Documentation/x86/sgx.rst b/Documentation/x86/sgx.rst
>> index 5659932728a5..9df620b59f83 100644
>> --- a/Documentation/x86/sgx.rst
>> +++ b/Documentation/x86/sgx.rst
>> @@ -99,6 +99,16 @@ The relationships between the different permission masks are:
>>  * PTEs are installed to match the EPCM permissions, but not be more
>>    relaxed than the VMA permissions.
>>  
>> +During runtime the EPCM permissions of enclave pages belonging to an
>> +initialized enclave can change on systems supporting SGX2. In support
>> +of these runtime changes the kernel maintains (for each enclave page)
>> +the most permissive EPCM permission mask allowed by policy as
>> +the ``vm_max_prot_bits`` of that page. EPCM permissions are not allowed
>> +to be relaxed beyond ``vm_max_prot_bits``.  The kernel also maintains
>> +the currently active EPCM permissions of an enclave page as its
>> +``vm_run_prot_bits`` to ensure PTEs and new VMAs respect the active
>> +EPCM permission values.
>> +
>>  On systems supporting SGX2 EPCM permissions may change while the
>>  enclave page belongs to a VMA without impacting the VMA permissions.
>>  This means that a running VMA may appear to allow access to an enclave
>> diff --git a/arch/x86/kernel/cpu/sgx/encl.c b/arch/x86/kernel/cpu/sgx/encl.c
>> index 1ba01c75a579..a980d8458949 100644
>> --- a/arch/x86/kernel/cpu/sgx/encl.c
>> +++ b/arch/x86/kernel/cpu/sgx/encl.c
>> @@ -164,7 +164,7 @@ static vm_fault_t sgx_vma_fault(struct vm_fault *vmf)
>>  	 * exceed the VMA permissions.
>>  	 */
>>  	vm_prot_bits = vma->vm_flags & (VM_READ | VM_WRITE | VM_EXEC);
>> -	page_prot_bits = entry->vm_max_prot_bits & vm_prot_bits;
>> +	page_prot_bits = entry->vm_run_prot_bits & vm_prot_bits;
>>  	/*
>>  	 * Add VM_SHARED so that PTE is made writable right away if VMA
>>  	 * and EPCM are writable (no COW in SGX).
>> @@ -217,7 +217,7 @@ static vm_fault_t sgx_vma_pfn_mkwrite(struct vm_fault *vmf)
>>  		goto out;
>>  	}
>>  
>> -	if (!(entry->vm_max_prot_bits & VM_WRITE))
>> +	if (!(entry->vm_run_prot_bits & VM_WRITE))
>>  		ret = VM_FAULT_SIGBUS;
>>  
>>  out:
>> @@ -280,7 +280,7 @@ int sgx_encl_may_map(struct sgx_encl *encl, unsigned long start,
>>  	mutex_lock(&encl->lock);
>>  	xas_lock(&xas);
>>  	xas_for_each(&xas, page, PFN_DOWN(end - 1)) {
>> -		if (~page->vm_max_prot_bits & vm_prot_bits) {
>> +		if (~page->vm_run_prot_bits & vm_prot_bits) {
>>  			ret = -EACCES;
>>  			break;
>>  		}
>> diff --git a/arch/x86/kernel/cpu/sgx/encl.h b/arch/x86/kernel/cpu/sgx/encl.h
>> index fec43ca65065..dc262d843411 100644
>> --- a/arch/x86/kernel/cpu/sgx/encl.h
>> +++ b/arch/x86/kernel/cpu/sgx/encl.h
>> @@ -27,7 +27,8 @@
>>  
>>  struct sgx_encl_page {
>>  	unsigned long desc;
>> -	unsigned long vm_max_prot_bits;
>> +	unsigned long vm_max_prot_bits:8;
>> +	unsigned long vm_run_prot_bits:8;
>>  	struct sgx_epc_page *epc_page;
>>  	struct sgx_encl *encl;
>>  	struct sgx_va_page *va_page;
>> diff --git a/arch/x86/kernel/cpu/sgx/ioctl.c b/arch/x86/kernel/cpu/sgx/ioctl.c
>> index 83df20e3e633..7e0819a89532 100644
>> --- a/arch/x86/kernel/cpu/sgx/ioctl.c
>> +++ b/arch/x86/kernel/cpu/sgx/ioctl.c
>> @@ -197,6 +197,12 @@ static struct sgx_encl_page *sgx_encl_page_alloc(struct sgx_encl *encl,
>>  	/* Calculate maximum of the VM flags for the page. */
>>  	encl_page->vm_max_prot_bits = calc_vm_prot_bits(prot, 0);
>>  
>> +	/*
>> +	 * At time of allocation, the runtime protection bits are the same
>> +	 * as the maximum protection bits.
>> +	 */
>> +	encl_page->vm_run_prot_bits = encl_page->vm_max_prot_bits;
>> +
>>  	return encl_page;
>>  }
>>  
>> -- 
>> 2.25.1
>>
> 
> This patch I can NAK without 2nd thought. It adds to the round-trips of
> using ENCLU[EMODPE].
> 
> A better idea is the one I explain in
> 
> https://lore.kernel.org/linux-sgx/20220304033918.361495-1-jarkko@kernel.org/T/#u
> 
> The only thing this patch is doing is adding artifical complexity when
> we already have somewhat complex microarchitecture for permissions.

The motivation of this change is to ensure that the kernel does not allow
access to a page that the page does not allow. For example, this change
ensures that the kernel will not allow execution on an enclave page that
is not executable. 

In your change this is removed and the kernel will, for example, allow
execution of enclave pages that are not executable.

It could be seen as complex, but it is done out of respect for security.

> 
> Please just drop this patch from the next version and also ioctl for relax.
> 

I responded with more detail to your proposal in:
https://lore.kernel.org/linux-sgx/684930a2-a247-7d5e-90e8-6e80db618c4c@intel.com/

Reinette

