Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C7D84F51BD
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 04:42:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1847148AbiDFCNZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 22:13:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1443818AbiDEUHx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 16:07:53 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 195EEEF782;
        Tue,  5 Apr 2022 12:56:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649188573; x=1680724573;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Fes0ETr8dy4eYFSair9fvNj696JSkolYm+6v6TJWxUA=;
  b=fEVEc38cVZGGktUX7kCOBsiIAuM6S9Aqt618WKH5KXJhMrniuxHLAzFV
   gz51NA1bBWPNReO9mwIzw5kMrig2bvxZnlTgKzB1HRoUxIx/J5C9upu5Z
   1NzNv3wxAWH1O1M+s1yLnWXWzUtEdfQipBCYx6Yu3LLavqqZEYd0Aec39
   bmB9fF+1VMJNXchgqfTLH8oZCiaGR1Ua3kIT/pDmQneDz5yOsezrQoXpL
   Pn6oHG6pa2yuH9SHIy6RXttRkYbdvbSvT+3enVlihixPfZY1V6jKLeOMT
   O8AH+oX8ZLjG0GY/GK/ISX+n+GgVpfVc1AbBlUbKm/DOx1/PCmbw2OPsX
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10308"; a="324022959"
X-IronPort-AV: E=Sophos;i="5.90,238,1643702400"; 
   d="scan'208";a="324022959"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Apr 2022 12:56:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,238,1643702400"; 
   d="scan'208";a="549201602"
Received: from fmsmsx604.amr.corp.intel.com ([10.18.126.84])
  by orsmga007.jf.intel.com with ESMTP; 05 Apr 2022 12:56:12 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx604.amr.corp.intel.com (10.18.126.84) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Tue, 5 Apr 2022 12:56:12 -0700
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Tue, 5 Apr 2022 12:56:11 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Tue, 5 Apr 2022 12:56:11 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.173)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Tue, 5 Apr 2022 12:56:11 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GYWiPZCOktPowQ8sg49jTaCbSeEKlweNa8Rc2wExtpwUdC8Vsiq6tQ3O91RwhvSNDakVaFiWMJK09AoMKzabWMwBzWdJYAGu6TswvdluhMw+RpAA6OX7eiTbmjspDKIvoryZSOgCEUYcH/7jxC0oNLsxNG2yDmCPGkFzWoizCdqZvkBLx+5rrma4YeiLu3nP+PkmLJNhh4/9GDF7uZXw6JszfOEg9n8gKI6kWZ+9+kUG0vbcg+UnSQzu8V1rWPBqkMLV+kpvE3fknUQ0e59OIB66ZjK3/1efSUrhPDaHBkAKu18zlknyKI8LuhTdczGXHalA4diNYpUTQMN38X/uIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bX1T2TSwgyYFWutVg2GfDAuwPhXRLsMA5++amDuEfbc=;
 b=HjIwyyb9bAq2vcFuHWqh62InU7r6jI6OErFZVJsCgMEVbmtOWOwV5ICdRbji2SiTrqm9prAIvQHGurkanMwGWPRFW8DcMsJ4/+43vC7SVovCLK+tQiA5PuoFw2RqhCSv4GkXQRUcePRjEyP/HS/fNSrt5HIbi0hLg4zkBfgS+wzSP6W4ITp6Khp8lgtqGs1lRMVeUHb+5d8SGA+Ayw9cLcVSXtOTz0RuzCY2uotde+j+tMdE3AqVAMnOpAIKGGqqTzOhtMWCdPCvUcmDPzcERXDaheKBwqXPwELWTKSTlPByeSttHRl5Et2CXehVozb4oinZmhwVnLckBGspeiuoFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BN0PR11MB5744.namprd11.prod.outlook.com (2603:10b6:408:166::16)
 by DM6PR11MB4578.namprd11.prod.outlook.com (2603:10b6:5:2a7::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.31; Tue, 5 Apr
 2022 19:56:08 +0000
Received: from BN0PR11MB5744.namprd11.prod.outlook.com
 ([fe80::918d:6022:8ee6:3e36]) by BN0PR11MB5744.namprd11.prod.outlook.com
 ([fe80::918d:6022:8ee6:3e36%2]) with mapi id 15.20.5123.031; Tue, 5 Apr 2022
 19:56:08 +0000
Message-ID: <96d630b3-c2df-99d5-e057-6787bd107d09@intel.com>
Date:   Tue, 5 Apr 2022 12:56:03 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.7.0
Subject: Re: [PATCH V3 19/30] x86/sgx: Free up EPC pages directly to support
 large page ranges
Content-Language: en-US
To:     Jarkko Sakkinen <jarkko@kernel.org>
CC:     <dave.hansen@linux.intel.com>, <tglx@linutronix.de>,
        <bp@alien8.de>, <luto@kernel.org>, <mingo@redhat.com>,
        <linux-sgx@vger.kernel.org>, <x86@kernel.org>, <seanjc@google.com>,
        <kai.huang@intel.com>, <cathy.zhang@intel.com>,
        <cedric.xing@intel.com>, <haitao.huang@intel.com>,
        <mark.shanahan@intel.com>, <hpa@zytor.com>,
        <linux-kernel@vger.kernel.org>
References: <cover.1648847675.git.reinette.chatre@intel.com>
 <b3a17e1ce7bcd14db3c28903e8a97f094998ae74.1648847675.git.reinette.chatre@intel.com>
 <Ykvrk4hYvBEnNOOl@kernel.org>
 <e118f4c6-7216-15f3-2bda-3a5851b0bcb1@intel.com>
 <ddef013dc9ce496ff5840f42cf0651637060b4f2.camel@kernel.org>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <ddef013dc9ce496ff5840f42cf0651637060b4f2.camel@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR04CA0286.namprd04.prod.outlook.com
 (2603:10b6:303:89::21) To BN0PR11MB5744.namprd11.prod.outlook.com
 (2603:10b6:408:166::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f8eb0edf-a48f-4379-1742-08da173e5362
X-MS-TrafficTypeDiagnostic: DM6PR11MB4578:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-Microsoft-Antispam-PRVS: <DM6PR11MB4578E123B416B5A4F900AD79F8E49@DM6PR11MB4578.namprd11.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pvMowj0EUou0s1UxkfpVBUs1Nt534sCChRqN76smCJ9kzkpZclW5LX75Yb+2y8/sG/tpAMnlODdCwQnQtWXpcKU5A+n6ltQKKTOpvVfl8uBOcsCvvNqEg4lmoYdxuNmXpDjHHa3drV3aZk9eUofrV71F91ibbAbzlOSZcOSV/p8IbbctVDQdC+atOaW61k+tJhXja3AysY6BCRgj3a9+Mt4uw3rFv6X0bJJabGTOsHjOc0kNVNqyvemo/k7uksxKT1P5fSc7EDnr+t+WWCRCHO1GgQqoCgKNLXUvVccTW9xO/vBN6jnIhb+t+bSYtvdOTxYN+AVSf7unJM/G4wswSFq6JwJjtqZwetPCK1qWw7/t9RTFOC4VYPA7DZFcb9/YObhKfIMl37zs2dadRl9frvdLbXUr1WsucW21YZIvL9EPvfSZ3Ufo8us/vFpfaX29z2/okH2VV4nrtduJf38Hn1jZZT2xR3+2ZL/LN9g2yFGcXdP0/EVQko6rzl6Ok57K4yHOuiIjx5m1MMaV13/xMtSHYXm7eJcUgBvcOheIWP5ywC8kE5LZWeKYcGF66XRKzpN89C9X+XADI1CDEoyQzgpDADe1gl5X8n2Gw96CZAKCZQXRJtIpxUPSApWRG6jxqD0vSCp3LW/VnBM1RvC67V+DueFz0XY5SXG6wbzGcvlW8mrYIhOuoPDi/D+4/hTeEBXcYgMw6V6AmHVVbmFonUrn6XIpnEcUYxIGSBHElFSRyPzylHd7EBVK+Wz/49XU
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR11MB5744.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(6512007)(26005)(186003)(31686004)(6506007)(36756003)(2906002)(53546011)(44832011)(6666004)(5660300002)(7416002)(6916009)(66476007)(8676002)(8936002)(38100700002)(82960400001)(66556008)(4326008)(66946007)(2616005)(6486002)(316002)(31696002)(86362001)(508600001)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?KzloUklVek54bXdMSnpBZHJwQ053ZXNhTmlSbDgrN3JZZDc5MmwzWlc3eDlW?=
 =?utf-8?B?eUxmU1pJZFRITEZoRGJPOTFENWJaVXdvdlFnQWVSTlBnMmI2bVNhaEd0MlEx?=
 =?utf-8?B?TEtqQnpIcjEyU2FMMFVXM1p1NWo5SkJRTkFRQ1hUL3hWVmpCYy95VnREL3Rn?=
 =?utf-8?B?dHY3RkExVkZLZHhBZ0RtTVRhTUhlVkdwUjQyTHhLYWNWT0FjbTE3bnNjNlJM?=
 =?utf-8?B?ZllUZ3NEMG5pTngrUWZqT3NUM1kvZVRsRXhDUGV5TTdDTG5KdzVaYW45SnBR?=
 =?utf-8?B?Yi84dDNuSHkxUnN1a1NLQk8yYm5DNHB1TWhKa2x1Z1N3a1hxbjJEWDgySjJj?=
 =?utf-8?B?Nlo2NjljTi9iSkd6bVluUTQ2YlMvVXIxUEVnZFllS2trWDYwdWJDUFhlVUlR?=
 =?utf-8?B?a2U1MlpqUm9ybzBCSDVMLzQxaHdONXF4OVpNVW82dDRxd1BVUU9PaCtLSXRU?=
 =?utf-8?B?WVhJWEtYL1NLcURXTlcxayt1QWNPa0M3YUpJT1loQ3NhcHRrVDZ2aTZXaVhI?=
 =?utf-8?B?NTdXVlhEaGNGWDl3MTFoTnZnOHJiL0lWT0g2UUN2UG1NUmExd09RdFY4a2RL?=
 =?utf-8?B?U205TEQ2SEJLSkpsakc0MEp6L04vcytXYmhzRmJaZzYvK0JTN2FvSzY4aitW?=
 =?utf-8?B?R2JKK1pURXo4b0tzdHBITG04Rk4xOFN3QXMrQlAyR2N5MnUrUnNBaG1mZmND?=
 =?utf-8?B?UWYwc09wcGZhdG9nYjBXRWNKZ3ZFdkY1ZUl4VmNydjJ4ZTJjcm5yQWJLWkZS?=
 =?utf-8?B?SVBxaGUybVlHdTF1ZXZIVkI4WjRHUTVIV3pEM2UxczFjWFFxZEVBcHFlZ2xu?=
 =?utf-8?B?bVFFNUJpNXQ3Y2NtY2hCNnk1eFMyTHJkcmw5akE2VDZEb0pVUWNLdk52QkVB?=
 =?utf-8?B?VkZ5WmliUGRjWENzNkE1b2psc1ZZRHl4bnZ5QTcycmc0Y1dROXFEWExWWDFW?=
 =?utf-8?B?NHlQaHJtU1ZJS0s1bEhlYk45YlRldS95NW5UWmx1Z0FDQjBPeHRBZGQzcnV4?=
 =?utf-8?B?N0grd2Evd2hFaTd2YlVVZWh6a0owenNOZUFxS3ZZTjkzQUhYZDBpcjB4Q0NG?=
 =?utf-8?B?VTJocE11MTZHSlU5S0ZkSGUxdFMwQ1kwaGV4aTdybUFwVEZMclRaTEV6cHJW?=
 =?utf-8?B?OXJZZkc2UFZRZzE5TlhMZSs2cFlqWjR3NWdLdGc5UEJsQ1JCeFpRQ3pQK3c5?=
 =?utf-8?B?ZzJGN29Ia2RndDNWWTlreUlLM0krU1c3bldrMk1nRTRMWFluV2RJSTdKQmJF?=
 =?utf-8?B?SkN3UzZvSllVeWppMXhYSUM1Tkp6WTJadlloZ2ZSVGRUek9IMFB1VzZLT3dE?=
 =?utf-8?B?bFNxNTExbkU4L3pVNUVNb2JLcDZUZ2JKRjN2N2dvMnI1M2VpdlI4UFZSRkND?=
 =?utf-8?B?YWw5VlFWZ2VLZ0RrWEx6dUZuS0JEOGw1TzdZQ2p3c2k3Z0RWay9QdHNOYUlH?=
 =?utf-8?B?SGk2NmhXZVkwMGozRmIwVy8zY1VQd2JZZGN4RE9IcDJNNUg2Q01uMytyMmdq?=
 =?utf-8?B?Ynh5Q0gwVzR0Y0lyTFhSZ3NXeHpia0F2VmtPa3RsNEw5c0VMMW5YY1RtcU10?=
 =?utf-8?B?SUtlZ0p2WEwvc2NNYU0rOG5oaEF6d0xvM3hZVXBsMG5ScUpEbE84ZnFVYldU?=
 =?utf-8?B?UnFOaUJvU1lpSVREbFlZVjJlTFQzbDVRZllHbjUwTUgvZU96bkFRc2Ezamdw?=
 =?utf-8?B?Yllxazk3WWNMbXRGRXN0VjRHV200SU4yVWZ1ZDBnZnVQak11MDI0L0YvWFZQ?=
 =?utf-8?B?cnBITURDU1hVeElhYkh2RGdYSjlKbnhPTnVwZVN5WWQ1YzQxNkl5RVpsaEtv?=
 =?utf-8?B?YUxtSVlUdGNZWnVicTZlQmgxaUJ4Nml2UVQrZFliM2tnR2U3U2dXbVFBL0hE?=
 =?utf-8?B?YkVRWkcxcG5zNVN2UUN4S0lYaW8wbzg1MVFkSStoR25qeStzMTBJcHVMYnhk?=
 =?utf-8?B?eUVzZGZMWkJQSzZWUmtvaDR3RVhtNVpzNVdJZ0ROTWxPd2lIVnRGT3VTTmFL?=
 =?utf-8?B?VWVaTDN4dytzMGZSTE1HZG1HRHN5NENMSWRFVkE3eUc1dVluYk1NOWVwNGdi?=
 =?utf-8?B?L2ZWdmY5eVFIcnBVbVBQWFlqL2duYUU1ZVY1a0J6NHI0U081dEhXcE9hZ0xS?=
 =?utf-8?B?V0RvZlVtTWhSampJZTVESG1OS0tESEpxb0hOa3V6akk5VzlKWm5kZFlJTEJj?=
 =?utf-8?B?aC9qMCt4Qk5CMSsxM01NRkJhbjVwYUg4RWVWdzFlSm1EOWlJWU1CSG1ySUwv?=
 =?utf-8?B?Q0JtYjFEeStiMXZiaW9ydnpyU2M3eE0zWjN2OVBnQW1QalVEQXdFQ0lTQ1k2?=
 =?utf-8?B?MHFjbzFCT0U5VEVQSnVSblVIMzJLbERsUFlyQ0YxN1p1VENEeEFLVVZqVCtV?=
 =?utf-8?Q?3xxL03hsVBYgAyu8=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f8eb0edf-a48f-4379-1742-08da173e5362
X-MS-Exchange-CrossTenant-AuthSource: BN0PR11MB5744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Apr 2022 19:56:08.3038
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9h1mhAZK7xQ8iX3EqpFksNk6pohC1pF7DcLQzSWcHVQ2jUakdnWpHBxJBj57VMxG/QyXBmMM7nsbvHFs6miPUlf8WvzKod9U3RWSTlvuBiY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4578
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jarkko,

On 4/5/2022 11:42 AM, Jarkko Sakkinen wrote:
> On Tue, 2022-04-05 at 10:13 -0700, Reinette Chatre wrote:
>> On 4/5/2022 12:11 AM, Jarkko Sakkinen wrote:
>>> On Mon, Apr 04, 2022 at 09:49:27AM -0700, Reinette Chatre wrote:

...

>>>> diff --git a/arch/x86/kernel/cpu/sgx/main.c b/arch/x86/kernel/cpu/sgx/main.c
>>>> index 6e2cb7564080..545da16bb3ea 100644
>>>> --- a/arch/x86/kernel/cpu/sgx/main.c
>>>> +++ b/arch/x86/kernel/cpu/sgx/main.c
>>>> @@ -370,6 +370,12 @@ static bool sgx_should_reclaim(unsigned long watermark)
>>>>                !list_empty(&sgx_active_page_list);
>>>>  }
>>>>  
>>>> +void sgx_direct_reclaim(void)
>>>> +{
>>>> +       if (sgx_should_reclaim(SGX_NR_LOW_PAGES))
>>>> +               sgx_reclaim_pages();
>>>> +}
>>>
>>> Please, instead open code this to both locations - not enough redundancy
>>> to be worth of new function. Causes only unnecessary cross-referencing
>>> when maintaining. Otherwise, I agree with the idea.
>>>
>>
>> hmmm, that means the heart of the reclaimer (sgx_reclaim_pages()) would be
>> made available for direct use from everywhere in the driver. I will look into this.
>>
>> Reinette
>>
> 
> It's a valid enough point. Let's keep it as it is :-)

Will do. I plan to add Dave's suggested comments to sgx_direct_reclaim() that is
introduced in this patch.

> 
> Acked-by: Jarkko Sakkinen <jarkko@kernel.org>

Thank you very much.

Reinette

