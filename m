Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F00004D0C20
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 00:39:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343920AbiCGXkO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 18:40:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239664AbiCGXkH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 18:40:07 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9ED8B54;
        Mon,  7 Mar 2022 15:39:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646696351; x=1678232351;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=FCN3oIlGDJneLrErVhyLCqE/qFAeWXpXpQm0zSToHO8=;
  b=ATho64VcHbETJ6jKcsLzt4FpmrwKSw3stsvKKAkqa3a3v4pNUSPX8qqs
   d5Xj1b5KhMW7oYOO2s/sHlVUkeQoUYn4UJIzu3cdH8v+2EA90JKkmvFwD
   NbzJCgbFjZySHQTpXxXE1W/dlAFXB3aGdwbkogYLighYPWaSHfX8TZ30n
   sFgaosbD7cwjOuBIMuPk0wCwpB2kU6DloEOlVLaTqVnehkUEqMc+dXKXU
   MdvapaQNLtw3A//jjagByV2VRd/97ofPlperX9xjTDyfCLsovEaGEAGQu
   qnET/11r/Z+2QEuKHLLT/EMv3tlmgOJGYbtKU7uGhuIBo2WRNREQR2Pww
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10279"; a="252109611"
X-IronPort-AV: E=Sophos;i="5.90,163,1643702400"; 
   d="scan'208";a="252109611"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2022 15:39:08 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,163,1643702400"; 
   d="scan'208";a="577785778"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga001.jf.intel.com with ESMTP; 07 Mar 2022 15:39:08 -0800
Received: from orsmsx609.amr.corp.intel.com (10.22.229.22) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Mon, 7 Mar 2022 15:39:08 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx609.amr.corp.intel.com (10.22.229.22) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21 via Frontend Transport; Mon, 7 Mar 2022 15:39:08 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.103)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.21; Mon, 7 Mar 2022 15:39:07 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TMo9kjznSS+aZYTGUhWN2skSt1B9fieMHLwDYuhpGga52ZiblIoe+0FjXSJMJEbUucVxfnZC+tJKrJ6S3VVpYyELV/sIQC2yLRyJnvD7kDydFKE+hP+xiQHSrtsMXiEDKFi8dlqEYfZMLgcWAC3iKBvKFIiPHomwfoka2L4C6cY5BRMw07OqUHhHfQCKZZ6iSLQNdgjZ0ldLD3ORQTKVA2v2HzEfXOUYTph5SIChQVbMrb+59vKKyKdHzszfs7fgWbqW9F2ZAsR1svDZ0WrlyxOd+wPZj2MxoQWnUZTT+1c27ymXpAWaFp5P0rekr9Pqfne1SFp73fI4F48WNNJ3gA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BaSx8VjaT+zp+OI1UQUdZCfGNXxZ5RYBuyQdtSHVmo4=;
 b=SOrlqFTVA8GajtFLiSWGW6JeBCjPW/clZjL2poGcgp1VeVt+Yx6DhuSCytZJ+6hNwZ5faMJ2oAudAmaGz7T23wVGyM7LM0W/AXUjVQRe3Za7dfMz6hXq/e9fmrYp1quYwc+5sXkchcWA2z756R5CDbmjkLErTLEd4Kws9A6KWE8Zpx0RVGp4BNXgK/hwvHubvMHoeGi10jOAqi1qVwIH1o99RWanDjthdFVFbSCiLjwOLCvLelS5bwfv0B2x6HZGfVlMzbWvPAzN14fODSkSCFKhAgID2VvdICjk1Tw4p8aj6pCcrhXV/gYszZuhq0LXi7RydjXoKVuKWuC/LlbMYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BN0PR11MB5744.namprd11.prod.outlook.com (2603:10b6:408:166::16)
 by CH2PR11MB4325.namprd11.prod.outlook.com (2603:10b6:610:3e::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14; Mon, 7 Mar
 2022 23:39:05 +0000
Received: from BN0PR11MB5744.namprd11.prod.outlook.com
 ([fe80::55e4:9a32:8e6f:4774]) by BN0PR11MB5744.namprd11.prod.outlook.com
 ([fe80::55e4:9a32:8e6f:4774%5]) with mapi id 15.20.5038.027; Mon, 7 Mar 2022
 23:39:05 +0000
Message-ID: <f4352558-4329-81c8-1f97-29fcd4d37f8a@intel.com>
Date:   Mon, 7 Mar 2022 15:39:01 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.6.1
Subject: Re: [PATCH] x86/sgx: Enable PROT_EXEC for EAUG'd pages
Content-Language: en-US
To:     Jarkko Sakkinen <jarkko@kernel.org>
CC:     <linux-sgx@vger.kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Nathaniel McCallum <nathaniel@profian.com>,
        "H. Peter Anvin" <hpa@zytor.com>, <linux-kernel@vger.kernel.org>
References: <20220307153504.198112-1-jarkko@kernel.org>
 <YiYseF3aKI70x3d8@iki.fi> <YiYuH95wps+yHDk1@iki.fi>
 <fd560bc9-cb0b-0f7d-9a60-76735bc55c5e@intel.com> <YiY/aWW25Ix2375q@iki.fi>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <YiY/aWW25Ix2375q@iki.fi>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0071.namprd04.prod.outlook.com
 (2603:10b6:303:6b::16) To BN0PR11MB5744.namprd11.prod.outlook.com
 (2603:10b6:408:166::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bb0f2f02-4707-4602-a006-08da0093aaaa
X-MS-TrafficTypeDiagnostic: CH2PR11MB4325:EE_
X-Microsoft-Antispam-PRVS: <CH2PR11MB4325C31B22A5EB7554CA8ED8F8089@CH2PR11MB4325.namprd11.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zG09iSF+ujWSrCkL9zkNrqkVg3iRImFrVoCkKQIIFZgpX7cfjXUVq9jKVeg1sSI3yUqigAVyyS2rGmRDDgBrR+yiKyxiU3nuUZCkYnv3CKXa6SNZZKhIBPaTqa8buozYBBMbSaLnRZ4Cerr+zUS+LxGi8A2f6wBLTHF+fRTFCcbwiydRUUWQE01MNjZkObwk4PjUkbhNlGM9dalatuybxdX1lqqxYYVyXbd5/dfejK1kOneIBKJOd+T68GHRkTWDoh2xFz01KIOXDXMROrAH3LyP/+v591yfI/8il3AsrC1/hJGBaxnRHr9c1vk3kZs5gqlqZ+pkkK68lWJMkgWEQufF6Q+LHLkjcglVNSXaNKfIehrDNcfbT3q90TMx25hn0Ij00djudtimI8taXtBOJU1SAWJUo4FuXuTvXDDQLQ3kb3zHIhepduTnbPWobhrQrOf4mh6NFiCKoS3JtTg3DZ/WbXeAFFY7g2q06tpQIM8oF/d92otGiIfG58K+Ga6wUluuggXUti55xCP0V1IQFWP8aAIbQBBkFDKwo7fWWUt/SI6IAsHfy7BWnr10ihW0z8+EraC2mXw9qBcNaE/v1/kvbxmqUaRmZa/9Dq5DxmfxEC+h2rDZ5XyfANehJAp7r1/o9DSYjR8l6yzNmK+r9Gw4SXopr/PwTeCNOeglo8ZMtFeoaYyn1xx4MvdxIXG5mYwP2EyAsn+WVPn11EOl95Rvks1+30oLKC5KV4Ti3/o=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR11MB5744.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(44832011)(6512007)(86362001)(4326008)(508600001)(26005)(36756003)(6666004)(83380400001)(66946007)(53546011)(2906002)(8676002)(6506007)(5660300002)(66476007)(66556008)(6486002)(8936002)(6916009)(54906003)(38100700002)(31686004)(2616005)(31696002)(82960400001)(316002)(186003)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cjBTMUhrTE9kMUoxeWVGTlc0TlZZWEM4M054NjNRSmwvNG9la0hEL1lvVzk4?=
 =?utf-8?B?UkRCMHdXQXVaWFJ0TlVPczlNQnY4cndENlVEclBQaVBkSWxOS1h3cXhRbFpX?=
 =?utf-8?B?TEJZMFQzWGplY3JIM244K2J2RmM0NFFkKzV6Y2Z4Rlh1NlNpTDk3TEhvcWpn?=
 =?utf-8?B?S2ZzMXgwSUp3dTZ2cytlM1V2OHJyanlPR1JZellJd2lQQzZtRzJPUUhzeHpz?=
 =?utf-8?B?TEF2dE9Gc1JHNllKWFg1UElDbkg0blk0Zk5tWUtvclVHSWx0aVJMMGk1eHZM?=
 =?utf-8?B?MC9NalpkS0VGdkgwMnczMTY4QTYvdDIwZ053WnU2NGpFajVCdkQyZkcvTWNV?=
 =?utf-8?B?VzNXOGN4TWY3Q2tFRDRndVRzZHFiQTJmZ2hkQXVna0VLZ0ZVRlJXN044blJZ?=
 =?utf-8?B?Vmp5dHZvUktOZm1tRTFjYnBxUTcyelBJMThKdjlEdEVINFdwTTdOWURDZHF6?=
 =?utf-8?B?R285andPbEozeURsbHV2MS9HbXdpQi9ZV0kwMFBQR3lVSWtLb1lHNHN3V2Fm?=
 =?utf-8?B?RmxTeWg5dytDSE11Ynd6T0o0YklXT2RRbnhqWHNROFZmU3l4cGcxbEVTcHZH?=
 =?utf-8?B?ekZ5RTRta1FZaU5jQ2xzVkZucHlQa1NWL013MXp0ZDZDcG1lYnBTbHBVSjZm?=
 =?utf-8?B?bTR2V1J3dFhmUzErOC9uM3ZIYTRkZ0tEeUdQTTRlM1lVa0dFemNEbGYvNzA1?=
 =?utf-8?B?QVl6eTZBY2FOR3RqdytZTGI5ZmZnSWNHRmtNSm1ja3o2SFdmcDZJWVhyRTg4?=
 =?utf-8?B?UVRqaGVvNE9JN2wrSUp5WWIwYm1EbnNrWHVyaDhvZ0ZrTGR3V3MvNWFoVUpK?=
 =?utf-8?B?Q2lQNGQxSXNRV2ZzaWJuOFFUd3dsTGh5ZnZsVS9kcXJ2N3RQWnQzUFM4eEFw?=
 =?utf-8?B?c3J5M2ExYjE3TnhLTzR1TTZPM1NtM0xTNmZUbEl2VUdaR2I4QXR2MkNHSFM2?=
 =?utf-8?B?eHJqVFRxNXdoS280MXlDUUQxN2hmbWsvbVVmWUJLeGRPa2ZzQ2U3blJ0Y08x?=
 =?utf-8?B?Vmt2OFpFSFpZSFZFRGlwalU2Mk5VQWpCcWc0Z3hQTks4Zkk1amo2a3hqbmVC?=
 =?utf-8?B?ZWFONC9mTFJPWW1YYnlRdDc3bk9HN2d0djVRVFR1c1BvRWwwSy9yMGk1VEJH?=
 =?utf-8?B?NGJhc1NkUU5ERVN2aWdzNkp6THFFcXh2RzZYQmlFaGlzSzBLTndiZkxuSG5D?=
 =?utf-8?B?QnAyeFAwKzF1dlpxRnhXbm8yNnIwd2JQYU1sV2FPdjg0TDdMQTFmaWU3UHdR?=
 =?utf-8?B?aTZyMXRzYjRxbHRMby9RWXFJSEo4T0R0b1dzM0xPRkx3MitxMWlqV1BXcU1l?=
 =?utf-8?B?UzNKdFBqeEVza2NWcExKNzVPNkYwSUU3cDJHenBqbGIyWDBxbnE4T3pPeFpP?=
 =?utf-8?B?bkM0a0lGcndpZDVWTGpHNm14OVAyUHJmNkdIT3NpNXBRYXVWc2ltOWZnNGVm?=
 =?utf-8?B?cmUyUlU4SS9OTU1lbXRHalU0YjhHd2JpdUk5RDlkL2huTmR5T2lNeFkrSEQr?=
 =?utf-8?B?RUtJNTBxZFpFZ2tlV0orWlk4RU5McEt3OFVONVFqbEZHWUVHODUwcmg1TFR6?=
 =?utf-8?B?WGNJMkxHRzVKdWdlSmV3cCtnZ2x0M0J3dGxRTHMxeVd1RXNsTWRGb2ptR2FY?=
 =?utf-8?B?dW1lcHRTdHpVWWFiejN0Wi9vcnc1K0ExVDMyQmd5ejZXem1ZeW9jZmpmbFB4?=
 =?utf-8?B?MzNaN1NJbU1jYWJENS8yV014QVgvNkZKRU5UYURGM0phS0pnSUVxa1N2QmFj?=
 =?utf-8?B?MDRuMGhrNGprZm04dGQ1R041ZHd2T1h5MEtuamdsNFBvaVpZcG0xcFFjN1dh?=
 =?utf-8?B?ZG85WUs5VG50R0xiYVd2K0pqQlpIQ3VDZWx4VWw1RWZaNmNrc2p0YVpuYnpl?=
 =?utf-8?B?aGNpc1grUU0vVi80UjJWK1pPcTBoWjQwN2hOYzN4V1craWpIRFU3YUNHTkxN?=
 =?utf-8?B?LytjMHhpcWlCWVd3OEtjN0FjalJBS1NlN2FUYnZCTEsydXhhM1RtbTY2MWFj?=
 =?utf-8?B?NENZUXVhTks5TVBsQ3RlL2lvV0RlUHVETGl6aks3bXg2YVYwdUZGbnN0OW4z?=
 =?utf-8?B?NDhZY2IvbXY0MkRKMC85WGF3dzVjRWpOcUl3SVJIaXBFWXlQZExRRjBFZTlv?=
 =?utf-8?B?aDFOaGVsYUFVV2p4cWsvZ0RaWHlLSnpQaW9hOGJOTjJMRjVCelZteTV3WFZZ?=
 =?utf-8?B?M3hiYURHNDVmTW9rdE1TSFZsRzQycFJpeXF5SGFTd0tmT2FZalB6eEdtdWtj?=
 =?utf-8?B?OHFZWE1rL1ZIRWxDUys0MlFsUVlRPT0=?=
X-MS-Exchange-CrossTenant-Network-Message-Id: bb0f2f02-4707-4602-a006-08da0093aaaa
X-MS-Exchange-CrossTenant-AuthSource: BN0PR11MB5744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2022 23:39:05.3909
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ujXKzs29dspGaQ4kMk75QekJY2kqV1HE9CzJGIb3hskdFCl0d/OIA4jmDog28wSaNoLlrMR88+jg37820KrkrBZEwbe+sz0Bfvoa44nyBAs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR11MB4325
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jarkko,

On 3/7/2022 9:22 AM, Jarkko Sakkinen wrote:
> On Mon, Mar 07, 2022 at 09:13:48AM -0800, Reinette Chatre wrote:
>> Hi Jarkko,
>>
>> On 3/7/2022 8:09 AM, Jarkko Sakkinen wrote:
>>> On Mon, Mar 07, 2022 at 06:02:03PM +0200, Jarkko Sakkinen wrote:
>>>> On Mon, Mar 07, 2022 at 05:35:04PM +0200, Jarkko Sakkinen wrote:
>>>>> vm_max_permissions was created to control the pre-initialization content
>>>>> that contributes to MRSIGNATURE. It was never meant to be as a limit to
>>>>> dynamically added pages.
>>>>>
>>>>> E.g. static content could be used as a hook for LSM's to decide whether
>>>>> certain signature is qualified for EINIT. Dynamic content has nothing to
>>>>> do with that. The current mechanisms only add to the complexity on how
>>>>> to control PTE and EPCM permissions, and do not add anything else than
>>>>> obfuscity to security side of things.
>>
>> Linux has mechanisms to enforce what can be executed. For example, with SELinux
>> a process can be required to have PROCESS__EXECHEAP or PROCESS__EXECSTACK 
>> before it can be allowed to execute writable memory.
>>
>> A few SGX runtimes enables unmodified executables to be run within SGX enclaves.
>>
>> Does a change like this not enable executables prevented by existing 
>> security mechanisms to circumvent such restrictions by running within
>> a SGX enclave?
> 
> It does not open any extra exposure as the existing policies apply for
> the enclave content created before initialization.
> 
> And I'm not sure what kind of circumvention scenario we are talking
> about.
> 
>>>>> Thus add PROT_EXEC to the permissions assigned by the #PF handler.
>>>>>
>>>>> Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
>>>>> ---
>>>>>  arch/x86/kernel/cpu/sgx/encl.c | 9 ++++-----
>>>>>  1 file changed, 4 insertions(+), 5 deletions(-)
>>>>>
>>>>> diff --git a/arch/x86/kernel/cpu/sgx/encl.c b/arch/x86/kernel/cpu/sgx/encl.c
>>>>> index 79e39bd99c09..0256918b2c2f 100644
>>>>> --- a/arch/x86/kernel/cpu/sgx/encl.c
>>>>> +++ b/arch/x86/kernel/cpu/sgx/encl.c
>>>>> @@ -160,12 +160,11 @@ static vm_fault_t sgx_encl_eaug_page(struct vm_area_struct *vma,
>>>>>  	encl_page->encl = encl;
>>>>>  
>>>>>  	/*
>>>>> -	 * Adding a regular page that is architecturally allowed to only
>>>>> -	 * be created with RW permissions.
>>>>> -	 * TBD: Interface with user space policy to support max permissions
>>>>> -	 * of RWX.
>>>>> +	 * Dynamic pages do not contribute to MRSIGNATURE, i.e. they are
>>>>> +	 * controlled only by PTE and EPCM permissions. Thus, the no limit
>>>>> +	 * is set here.
>>>>>  	 */
>>>>> -	prot = PROT_READ | PROT_WRITE;
>>>>> +	prot = PROT_READ | PROT_WRITE | PROT_EXEC;
>>>>>  	encl_page->vm_run_prot_bits = calc_vm_prot_bits(prot, 0);
>>>>>  	encl_page->vm_max_prot_bits = encl_page->vm_run_prot_bits;
>>>>>  
>>>>> -- 
>>>>> 2.35.1
>>>>>
>>>>
>>>> This is really a show stopper. I think here's a logical mistake on for what
>>>> purpose vm_max_prot_bits are used for. They are meant for the static and
>>>> also signed content of the enclave.
>>>>
>>>> These changes in the patch set that are related to vm_max_prot_bits only
>>>> messes up what already exists, and make incredibly hard to implement
>>>> anything decent on top of SGX2 features.
>>>
>>> I.e. once signed content has passed EINIT ioctl, and whatever checks
>>> there are now or in future (e.g. LSM hooks), the system has accepted
>>> the enclave behaviour, and it includes also the use of EACCEPT opcode.
>>>
>>> It's the exec or no-exec decision point. The thing that these patches
>>> do is making an obfuscated mess of all this. When EINIT has passed,
>>> it has been decided that the enclave can do its workload. Let's not
>>> throw stick in front of it, and make everyones life misserable.
>>
>> A common use for these dynamically added pages is to increase the heap
>> and stack. Always allowing PTEs of RWX on these pages irrespective
>> whether it will be used for heap, stack, or relocatable code does
>> not match with how the kernel manages protections.
>>
>> As I said before I am not comfortable with such a change and cannot
>> sign off on this. I would defer to the maintainers to choose the
>> direction.
>>
>> Reinette
> 
> My choice is to not use this existing mechanism for dynamically created
> pages because otherwise the implementation overally is just crippled.
> 
> Something unusable is for sure as secure as you can get.
> 

ok, I will proceed with your guidance here and include your snippet from
this patch into the next version.

One question, regarding "MRSIGNATURE" - did you perhaps mean "MRENCLAVE"?

Reinette
