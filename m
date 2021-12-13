Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6853A473743
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 23:11:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243505AbhLMWLf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 17:11:35 -0500
Received: from mga12.intel.com ([192.55.52.136]:37950 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240548AbhLMWLe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 17:11:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1639433494; x=1670969494;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=i6h/Y7JejyNsuy3My7cSxetjpUuoa8SIxX6+unWzoi8=;
  b=dhCz84R6mdecccOrQjZrM6qKPiU9xXBR5exgslPHNC4YTCSWuBRQT2Pq
   0Qaojm+R9QDQtijto1D4WBqX7X3Z+7E1tTX00OsXgQwCPwC1io74oYW+U
   azvfDVClkyhPfX7QSDbS28iXHFSRuDh5J1iNSWHIBxi0wRMUCM4tmL2tY
   Afsk+bGDxhBKupu3DgAvAuPWmBKtUVVGVfbKFUcF+oyQ8oJPS73GmpUd6
   lds2whC069Rc63lmysX4R3cQ4gXwlaC2BLQLcvynQ2TGnJ2yKwin0WXia
   w+1tfXW26tSsMtPxYebW2RPXTI++9NOM6aYFSGY8I6fIewU+RpicLVPMP
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10197"; a="218856421"
X-IronPort-AV: E=Sophos;i="5.88,203,1635231600"; 
   d="scan'208";a="218856421"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2021 14:11:34 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,203,1635231600"; 
   d="scan'208";a="464819087"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga006.jf.intel.com with ESMTP; 13 Dec 2021 14:11:33 -0800
Received: from fmsmsx606.amr.corp.intel.com (10.18.126.86) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Mon, 13 Dec 2021 14:11:33 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx606.amr.corp.intel.com (10.18.126.86) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20 via Frontend Transport; Mon, 13 Dec 2021 14:11:33 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.168)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.20; Mon, 13 Dec 2021 14:11:32 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RcL5cP+RpH42r7IZfIHAaQLWu84lCSM/t9GZZC4EKDHjMSr0la8hkP6qoI9YmOZMYSAVDxqIc2za4AFToQn/3R9TQWoRwdqsSuQ5WcH6NK9mDbrqhYG7SJUdZjRL0MQgQ3F3xCNqvbe7rDI9Y1N/hjamALgbwxrYxD/Zu+AcFtUMmJeqE9CBhuIlZbmqofWCpNJ2FZFZW6VCqR6yR35P7lIv0ir1g89wcGTA5w1gyysXil6n/GAtqLXSKVAFnzYvsXbzRoGQ3c3JEaE4IXJGDfjy3HeyXAb66pETfRQyYQ92ll9MPwSQANC/dK6f/14HCl7VbGzfhIm/5tosz4DJaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Irg8vyod2bokMB7hV2yQ7wq4PFT7Kk2I1GPSpS/ltf8=;
 b=klaX9bUffuZqIisfNmmqx+l1rXXMEHo+EQzgzaXHHtE4tey0LzntpcBILrWRL2l+vqnhAioQWbjdVb2PMJTGQGEBwh/EurhLcFvFML+L4X1OqIzBw1F7rRO4JKPQaVMJG+4j5kn/X73DWQWMEC/etG0o18aKELqP8/pkABNmpdGKt7w5DcT2ImnIe0lTtH+AcaaAwcid1pTqCT3ORHPV/h5SuihczVrkxeNema0QZfcF61uafSSpQ1oWVbfWzuvVmFvYwAJtDliDYM7Mng5dDpsR74unF9wr6PYreqaEhA8Z64Y1o2L+f75lI7To/Ab0OhOKkmLA5VCX364Pl/bRjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Irg8vyod2bokMB7hV2yQ7wq4PFT7Kk2I1GPSpS/ltf8=;
 b=T9uc0gmMqcoez+jGz30bLt7X3tKfUGnYt0Rt5VWNOXHFhbHNxYiSOMcU/8jnJz6sqi/R+agV8x3Q8s/UC075/v+tlBVeZE4CDVH/oEMroTJFWA2l3rGTSJYE2zZmUx8Js9gTPCo922wXEFSGI/WaVbadWU2NdNfRFG6veiYjID4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BN0PR11MB5744.namprd11.prod.outlook.com (2603:10b6:408:166::16)
 by BN0PR11MB5742.namprd11.prod.outlook.com (2603:10b6:408:162::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.13; Mon, 13 Dec
 2021 22:11:30 +0000
Received: from BN0PR11MB5744.namprd11.prod.outlook.com
 ([fe80::bcd0:77e1:3a2e:1e10]) by BN0PR11MB5744.namprd11.prod.outlook.com
 ([fe80::bcd0:77e1:3a2e:1e10%3]) with mapi id 15.20.4778.018; Mon, 13 Dec 2021
 22:11:30 +0000
Message-ID: <192e252a-653f-2221-73dd-99894c134a37@intel.com>
Date:   Mon, 13 Dec 2021 14:11:26 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.4.0
Subject: Re: [PATCH 07/25] x86/sgx: Move PTE zap code to separate function
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
 <bd228c90c139437bb4fcc4b7b99063bfd3eb1439.1638381245.git.reinette.chatre@intel.com>
 <Yavy5JTYAkdZjnK2@iki.fi> <66151f3a-0e32-fc57-cb54-5b714588389b@intel.com>
 <917c53ff755d9a20e1f4bcb48c70add8364d1065.camel@kernel.org>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <917c53ff755d9a20e1f4bcb48c70add8364d1065.camel@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0022.namprd03.prod.outlook.com
 (2603:10b6:303:8f::27) To BN0PR11MB5744.namprd11.prod.outlook.com
 (2603:10b6:408:166::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 67115069-8eb0-43e1-8d57-08d9be8583be
X-MS-TrafficTypeDiagnostic: BN0PR11MB5742:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-Microsoft-Antispam-PRVS: <BN0PR11MB57427A2D2C6304B7D18FCBADF8749@BN0PR11MB5742.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2449;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: egbXB/77rylvv9xSoOHtIca50pTarkx+odbOYv5MmuvfrWmE/1TyU1pxxfj2eOIQooFDNALHbBCWK+dXOvD/yf2um+HXyomtng6e14YinPy6/xe8/FuPOcxtJRw1JSlNF4Mbo98iDINyh1QwPG3U4Ik3vi4WZs3t1ORkkatFvLtNAPn8vzYcLd17YFN2x+Rgt2CaCy9vtPHpfNWN2B+zAvWQVTq+UsP7/KSZ/i7i+/kbeMrM9nLLalZ2mS1c+yxTO2uahYIipJxynJCg057pHTysvkGuo0QIfdAllvKrboVQcPx+Yt+1MJwzLwMQnbDtjlnd3Wtfp+0PNckH6GNkXyxb6q1c+cTj+LTkX+9X6Se1nqZCNAwvAWrkNYFATZ7y0YeZd4yo1LAbUKQluWagGCYOsJads/2qIDvj0CO+FbIMoj0VbWA1q4MojOOe4/TwihPryoQVFwsUwjeo2vBGkkOeYyoxJjZuPN1nawvqAzadU9FFk/zW1t0PbaZBePY8U+GPaWoxwOa74+vsYtfZcM+pEWCch6ghhWwEiB9g23aQidTojEenpSVEohbk7zBjV9dx4g7+ruUWIYg8AKG6KLpBw7+8TmJABg/B6KkuJES7ND42ruvy2903N3WoWJdAsQUEkjyH7QCbkLpeNZa4RDoMl1r0KTXLXTC2UV4GPh7WKMIVCTvvYw7RA+fIpx5zPGPxNVl2iFTWS+XdxQnDNWngKrdUaxh0IjLqZl1G0BRadhGtXei8tsJvGmVxHIwu
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR11MB5744.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(6916009)(7416002)(86362001)(66476007)(316002)(4326008)(31696002)(26005)(6666004)(186003)(2616005)(2906002)(6512007)(6506007)(8676002)(6486002)(44832011)(36756003)(82960400001)(5660300002)(8936002)(66556008)(38100700002)(66946007)(53546011)(31686004)(508600001)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cXVBYzVtSHU5Tjg4Vm1ScWpaeFZ0RWtBaGJJLzFuWVIxdUs2ZHdxNm5oY0ND?=
 =?utf-8?B?NmF6RW1IMEIwOHpsalRWVzVqWUhDdnU4RkJ6Q3IwL2hpOGxCSnRYck9rUzRD?=
 =?utf-8?B?VVdZYjRreWVHdXJ1UlQ3Vk1WSDF4WVZWV1lGS05qNFkzWHZyQ3JNOVRIMWJX?=
 =?utf-8?B?c0pGenZOUm5yZEwzYi9RVnE2ekdzc3pvL1BEV0d1c241cjZkTkg3Yk9XK092?=
 =?utf-8?B?SzV2YmF5RjdZazg3WlFHNTB4Y1QwY1FHRnR3WGd5V1ZZSjF2MWtFSCtTVDdM?=
 =?utf-8?B?REJuSUxJbkNLYjZGbWFPd0tSbmFaZXM3OFI1WmVsWjhwMHdZeUR0VEJwWDgv?=
 =?utf-8?B?eDY4d0VDVnU4UWw1N2JZdG0vRFdIVHBEY3I5ZWJEQkRqZUZvSFR1YkQrTEdW?=
 =?utf-8?B?KytnbHJqM09vL3pMcHc5cnhneklFT0pjL052MlVyUCtPNWlKTlFOWGJZaklC?=
 =?utf-8?B?eEE4LzZWTmFma0ZqR3pyQzd5TVZrcjR5MkowV0tYQ1M3RnVWOEJwVkYrZisw?=
 =?utf-8?B?L2VrTm9BdDVjNXZTNjFxQmNVMGRHaUgwM1NqaWlSRlJiZkdNcHFWakV1SUZP?=
 =?utf-8?B?K0dtNUtPN0YxdHBncVVPTzhCR3FTNU5panVIR3BUL0w0UkdiRDZrUHJIWjJ2?=
 =?utf-8?B?NytNY29QMWJrSnZPQm1FWTdDWk1IZElYd2lGZGJ4a2JqL1BWR3VXaG1Fa3gw?=
 =?utf-8?B?WmI2a0Y0dlFXVFJvckpONXBkMHdPSlhpRVdzbnpPWUFQc3c4NGtseENDalFh?=
 =?utf-8?B?aGRMQVRzZDhWRjEvdlJ6aWx1dms3YWNTYmFKQU9PUjc4VXZCWTNWbzljQzBa?=
 =?utf-8?B?VmhUam1OaUlISzNTZjZLMkY2NzYzT0h0RDVIUVprbnRiZUpyYnhQRHB2eVNC?=
 =?utf-8?B?T0pTc2k1R3J0MXQ3U1cybDN2V0xjanpDNS9ZL1VqYnVzYUZFblJkY2ZqVFRy?=
 =?utf-8?B?cENGUW1pZ1dMajY2Q0U1UmtrNzhPNW5QOWFYWDJZeTBwNDhWSkpZNmFzb1la?=
 =?utf-8?B?RUU3MitaR1ZSc2VZRlkvaURMdkdKWG96RUZNUFhNUml6M3dpc0NqN0RpRTNn?=
 =?utf-8?B?SEFtOVIvVW92Q25yRmpnN0ZoOGtUVFV0cUVoL0w1bWJOdWh5K0Fua285NU9p?=
 =?utf-8?B?Qitib0dTUENoRnhiTnpMTzBDcEFuaFplVC9LRHVDeS83NENKV2lwOWpzQTNt?=
 =?utf-8?B?UThKTzZTSDNtQjFGWlJxKzZ5bDl2ZGhVeG9IaHVjQWg3MnZUQUZUT2F1YTNJ?=
 =?utf-8?B?ODNEQ3FNOE5jdnZ5WVhVWnZqRlIvc212UnVTTFl1aDN2Yk1zL2xZUlhTTWNa?=
 =?utf-8?B?Q3FxNnhiUkEyaEQ0S21XWXFZSkNzaS8xUFVSUTRkRDhrZUUvUGFuRC9GU3BM?=
 =?utf-8?B?MlhtcmNPTGtiWVExTHBUbVpRc1ZPRzBOamxJZGVEeDJ4VThPZUlFenFUeEV2?=
 =?utf-8?B?S0ZkMFBpZUo1d0RmMWRTVVlNOUZHVnJNNnVSTk1XZ1doY0VxLzBRZmk1VzZY?=
 =?utf-8?B?SkJkZEJDNzFua2JZSEhqWE5CcWdBR0xpc2ZJWmJ0Ujh6RW9oRXFkV2R2MG52?=
 =?utf-8?B?TjVQWkVPUHdoY0dxdjdFQm9LcFVKdHg0R0xZbUVCR2tTSVpsWnhHc1JDVVVp?=
 =?utf-8?B?clpJNFV0KzFIajBHOUdKVkhncmFGMFBpSlR4b3F1TWVlS0JXcWdab0VLQlMz?=
 =?utf-8?B?QlVlMmpCQUJvb2wvcWR3UGVIVlk0dlZlZjk0d2cyVStCZkVnbVNPZm1ORlJX?=
 =?utf-8?B?OUx1Z3R2L2dsR1hMd1d1VlRsTU8vV2U3N05nSkU4eW5uSENjajgrejhYTUxI?=
 =?utf-8?B?OWhwVjJHcWpsMysweVVFWVFIZUhNbzRzeXZ2d2Y1VWJSMU5HMHFBbnRpT25Z?=
 =?utf-8?B?bXlPNE1qdFlTck1EUVQ5d2dPc3U5MEx1aUU4M2RxQ20xTkRDd1c0RnMrcXlq?=
 =?utf-8?B?VjJIQ1RFenRFNFlOMUZyQm1la2FsdU5WaUYwQjRYQ0NiaXRGS09STTBMcjkv?=
 =?utf-8?B?VVVGd1kyV2xVaGhWeXpTaWFPU1ErWUJNcS9JWnVsWDRKVzZYRFhrU2I5Y2xN?=
 =?utf-8?B?RVhsZ0Z2a3ZnWENnbWVQc0dyRkhTRVVMWlRoYVY4YVprSSt1RDFDRFVZSlV5?=
 =?utf-8?B?OWpZaCtlRVdBNEJ5Yk1TZVFReFNWdG9OWUdMRWpUNjVOTm5rUTJVeDVIS0RD?=
 =?utf-8?B?cGVubjcwRHAxZHFDazQwQ1FmZGZ2K2tKREtidFhrcGI5ek1jNW52QlpDU3pZ?=
 =?utf-8?Q?l0qTOlTMWq0OiC70LUCz5QWKhLJQ9CsAXwXbCaintA=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 67115069-8eb0-43e1-8d57-08d9be8583be
X-MS-Exchange-CrossTenant-AuthSource: BN0PR11MB5744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2021 22:11:30.2236
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jUWWQNwVwybrTJ8XCGLO3sFPuwdWI4VG/BUSKqvvdWTuaWECiXFjlAbTSXeUasFpqzDf6neuMTEockqEoDu2lYfP7h3ijWdoOTaSogC9JgM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR11MB5742
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jarkko,

On 12/10/2021 11:52 PM, Jarkko Sakkinen wrote:
> On Mon, 2021-12-06 at 13:30 -0800, Reinette Chatre wrote:
>> Hi Jarkko,
>>
>> On 12/4/2021 2:59 PM, Jarkko Sakkinen wrote:
>>> On Wed, Dec 01, 2021 at 11:23:05AM -0800, Reinette Chatre wrote:
>>>> The SGX reclaimer removes page table entries pointing to pages that are
>>>> moved to swap. SGX2 enables changes to pages belonging to an initialized
>>>> enclave, for example changing page permissions. Supporting SGX2 requires
>>>> this ability to remove page table entries that is available in the
>>>> SGX reclaimer code.
>>>
>>> Missing: why SGX2 requirest this?
>>
>> The above paragraph states that SGX2 needs to remove page table entries
>> because it modifies page permissions. Could you please elaborate what is
>> missing?
> 
> It does not say why SGX2 requires an ability to remove page table entries.

Are you saying that modification of EPCM page permissions is not a 
reason to remove page table entries pointing to those pages?

Reinette
