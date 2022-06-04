Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF95C53D65F
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Jun 2022 12:14:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234549AbiFDKOn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Jun 2022 06:14:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230482AbiFDKOl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Jun 2022 06:14:41 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD1562C66C
        for <linux-kernel@vger.kernel.org>; Sat,  4 Jun 2022 03:14:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654337679; x=1685873679;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=5LUpzMSJijEEONy0DD3d7qFngDAS7gLVbhZnKuXnQjI=;
  b=Q3tTcDLnuDvjLUBmbxgRIYq9VNWeHWLMVyvCklxlQwgUglvO7K0vsUw9
   p8V8asGcm6UsFHPBdtpiet/3/Cz20Hs2dMZEdLiiReGR0jYh3ieqfr7F5
   K2ZjOWoqFwkf0MlYmN0ooJL4m4W2Q3gZbDxsQPyoy9ScaULeAVgGvuIy+
   wO4Fsq3KvwBNo5UoMBPJALKTZTPXTa7L5LNtNo1LzLm6e8hDRR7w+NY7T
   BVsL4NoQ44A4Ud8Jqla6qc8eavfgUridAZ/JY76TGy7AtQG9sHd18FOJU
   uiBTfFRA+8ZggrnEdx0Dpq73drWNvMYcQcMeQU3Aey7jWLlUiPOcQe/YI
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10367"; a="276485393"
X-IronPort-AV: E=Sophos;i="5.91,277,1647327600"; 
   d="scan'208";a="276485393"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2022 03:14:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,277,1647327600"; 
   d="scan'208";a="634896012"
Received: from orsmsx605.amr.corp.intel.com ([10.22.229.18])
  by fmsmga008.fm.intel.com with ESMTP; 04 Jun 2022 03:14:39 -0700
Received: from orsmsx608.amr.corp.intel.com (10.22.229.21) by
 ORSMSX605.amr.corp.intel.com (10.22.229.18) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Sat, 4 Jun 2022 03:14:38 -0700
Received: from orsmsx605.amr.corp.intel.com (10.22.229.18) by
 ORSMSX608.amr.corp.intel.com (10.22.229.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Sat, 4 Jun 2022 03:14:38 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx605.amr.corp.intel.com (10.22.229.18) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Sat, 4 Jun 2022 03:14:38 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.169)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Sat, 4 Jun 2022 03:14:37 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XANXt4BNUjIJ8olIqMpnY1W5MPcB2ghcasR+LHQlwuKTZhnGbQHY5Wa5OMhsHHssVXpPDI9JcGVYIUW1pc97KHpNoIWGBGTqEnqRAGXr9UJYfthafDvGRH6XnPpFuB9BAIc4zjO0mYCTtFlTORryxu706SlmMlUi3ICL1R864D1xUIIJza1kZYCLL4Y9kz8dTRwP0nUdCLkSk3VoHcDziRNJExxlM5jVFgDJzNVjEgDEZWAkaL3KSQEcXBNoTE3Qg80wWqpnIPWDbyAJnpp99TC6rSEqQDoq6KLljzFF2TITTJNEmLVg91++AOjVLiKqHtrYN998uV69CdQmU+WD1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DkUIUYmzfWi0hNZM3H4oTM0KzPgRj3hyM6yIStqzyQM=;
 b=dAW8zDIxyz8H+0rq7Zn/YKRIioC0ynt18YbTMmCQLBAh7hEWanuvqv8cZPrQ9DZvZsA8rhCF+wxDMjw8KkYgeFQiGpHKAZcc+NbXsAg4FjZqQC82Z+9uX8Bpg276CngeJ91hGg23joEU5qeestzIoL1/cSbC16stFtoT/BPGjRYBcw1pHX7jWQP1rvBrYLpy3lycIJoikQINOcPDfswmrcWx09a1gInLN3kuW8QdbJjvIhaTswUVkq3iJDvJmrJN1olKqVQebnXD6tEBLJEHcIqES/8nyGsdGKtachKjg/YErTcZ0CGYvuKx5jXpT4Pl5lmOHvWIeWKpSKlHsXiJAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MW4PR11MB5933.namprd11.prod.outlook.com (2603:10b6:303:16a::15)
 by SN6PR11MB3310.namprd11.prod.outlook.com (2603:10b6:805:b9::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.13; Sat, 4 Jun
 2022 10:14:36 +0000
Received: from MW4PR11MB5933.namprd11.prod.outlook.com
 ([fe80::1169:fc9:c1ef:248e]) by MW4PR11MB5933.namprd11.prod.outlook.com
 ([fe80::1169:fc9:c1ef:248e%9]) with mapi id 15.20.5293.019; Sat, 4 Jun 2022
 10:14:36 +0000
Message-ID: <d4c31c67-de25-ac88-7115-4872e31f8bdf@intel.com>
Date:   Sat, 4 Jun 2022 18:14:27 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.9.1
Subject: Re: [rust:rust-next 2/24] ld.lld: error:
 kernel/built-in.a(kallsyms.o):(function get_symbol_offset: .text+0x5f0):
 relocation R_RISCV_PCREL_HI20 out of range: -524435 is not in [-524288,
 524287]; references kallsyms_names
Content-Language: en-US
To:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
CC:     Miguel Ojeda <ojeda@kernel.org>, <kbuild-all@lists.01.org>,
        <llvm@lists.linux.dev>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <202205240321.sb0gX2mq-lkp@intel.com>
 <cdd02535-b446-5547-4fdd-6deaf3fba6a6@intel.com>
 <CANiq72k69wUZxvCeJFH3=9LsyjT76XFcfbf5aKZbb-u91wMmkQ@mail.gmail.com>
From:   Yujie Liu <yujie.liu@intel.com>
In-Reply-To: <CANiq72k69wUZxvCeJFH3=9LsyjT76XFcfbf5aKZbb-u91wMmkQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR02CA0019.apcprd02.prod.outlook.com
 (2603:1096:3:17::31) To MW4PR11MB5933.namprd11.prod.outlook.com
 (2603:10b6:303:16a::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b7de7ecc-49bf-48bf-e2b3-08da461306cd
X-MS-TrafficTypeDiagnostic: SN6PR11MB3310:EE_
X-Microsoft-Antispam-PRVS: <SN6PR11MB3310039D68E891DB6132DFBEFBA09@SN6PR11MB3310.namprd11.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IDB+gxYxkYDe7NOTusmw7KRxZPOsPS2/zAnimw+I+D7PiMbMT1tEuOW0O2yYiDJW3E+KfMM1mWIzejvaGx4NHVoGZuNSA+Ph0JVxzGvIadyACi7wAx2PSlhVdm2r+vMfcAoF6MEJtSxBY4VXrbI8iaGnJ52/JPlr0DmsStDtuElUUsk4Ix3YtC+ars/Y3N1AV0rxDDflyNShh01RDXY+GOKclfOfcpOUGSP+FHTtQDS8dtSa23qxky2hwvJM+coYWeoTooyxVa/ecJeNjWCPGaTX04Pcxr674O9RnEdF21WhMEeDgR4WiTSZdwj8HASS/2jklL93WbmlTjDwjlQNAYYzbe8bvL2F9znz6YJmoeMjDU2G0oGMX7LzuFTe5UUUyNnQOBUAc0Zx8FDpzt7h12btlz0TRSJ2EhRwKqnCipov+HZbGmI8jZMOu4BDfVxgBqDWcSztiWGsXHKPZUsrRRJ6lvaIw7dNQMQT82cnBjjqWBuqWMGiZCoJIf7wiAeZgQ7xjSH2FoTKqccSrBvZCHy8IoxSjsJZnMIZbOuBoEBoUY2mwogtSoQlex0Fpx415d42tdsdPXdvHE3CaiF8TrQ3k14BfpWx9c/5+vFaan7A1cMH+ffz9eZtZn4EwlQfYOiMIQUQRZlf6lgzv9L/6LZjKspZazP+inAHWpP11lMgu/9liMm+QRTrmYx2222VQTEGOAIGRZujcjHGFJuoC2p2U9W7VxNpVVeX/HDr7vnLF2n8VfEf+Hlmto9MTk+ydgljexo5/5vIKARUWdxfiQLoVEa2YqZnmO41ILG+7yXztYdVgYHzUJYx7CRiRPCeeKQArRHatUmURKEgd93MsgnTR3b1GLnnvtO5v7b1/2I=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR11MB5933.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(66946007)(66556008)(966005)(186003)(5660300002)(508600001)(8676002)(66476007)(316002)(38100700002)(4326008)(2906002)(31686004)(82960400001)(8936002)(6486002)(2616005)(36756003)(44832011)(31696002)(6506007)(53546011)(6512007)(26005)(6666004)(6916009)(86362001)(54906003)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QlFSUXdmNXpJSGlOelBhMndyMTVsRkNLNklUMDlxVnZVbitGZmNmc0wxQkpG?=
 =?utf-8?B?cGR6dzhGWTZBL0dRWnI1cE5BUnZ5c0dVNGFSVmo5anoyQTJwSUtZT3lVdDNw?=
 =?utf-8?B?dCtpUFArUEQ4elNwQ2YvRXViTmlPcVN3cER2ZEV4ZEV5WGhISVlsSmlXODdr?=
 =?utf-8?B?VmwydzR1MUJXZVFDeC9rSzluWVlTdkVqN1NGRlByU2orMjhWMDNabzNxSmpN?=
 =?utf-8?B?UUl6NVdXWmUyVEo0RXlxWVFIZGNXRzFOVHNEN2Y0V2dKclI5aGVSVjVvQkhV?=
 =?utf-8?B?b0R3VVphNFBiUWVSQnI0WDk0MlBWTTBuM0NGVGF1ME1TZmdhTy8vNE92b0t2?=
 =?utf-8?B?YVZObkpLTHFaR0dldmQ5TVBFd3lXclRKbTFKNFhPeEsrZ04zNDhxSVorRlUr?=
 =?utf-8?B?V3JoeHVuc0VYZ05jYmpXYXdzcExhdnJxa3AxaGIrWlRxOERpbUR4b3R2RDVr?=
 =?utf-8?B?ZUxlWUtidkhoWnhPcFM5S1d6TktMV1MvMVpvNDZkWUtSMzZHSUE3R3U1dVZS?=
 =?utf-8?B?Zm14K05ER3FvaTBUWG1QbUppVmRYVyt5empsazdFUU5hVmluaWExRU1kdmk4?=
 =?utf-8?B?anNnb2pWdGgzdU10aU1zM255VUdTOEZERHNmajkrWkRTVFV2bUFKbDlZUUM2?=
 =?utf-8?B?aTMzcE42S2RSN0FVRDhHdXA0Yi9BN2ZPaGdoWmxmVStzZk5HQVJ4SHpCSFkv?=
 =?utf-8?B?Unh0NHF1TGR2Uk00eUJrVmVBT3p5L1JDTmRPTGgvdEQ5MUFWWDBFUERhN3dx?=
 =?utf-8?B?b0poWms2NWViMUxLelRra3dFbkFaMktkNFNhd1I0aHdXS3R4ODV6Y29WTDVl?=
 =?utf-8?B?MHlzNmFSVnAvdy9RVDNYL1ZvVHNjenBnQmF2WHNEV01Yd0sycDZFNXlzSzE1?=
 =?utf-8?B?clNnNWJJV1NsRDByRVVnT1gwUnpZZ200UEpHYlZoNzA2WWJmRkZzL0N0RGMy?=
 =?utf-8?B?NUFkK2c5ekE1eEtvdVpYQi9tblJLelgyUzZSK1AxVDkyQllLa0RoaVczZUVW?=
 =?utf-8?B?alU5V2wwTS93RGZ4R3dPdlJ6ZFg1RDVybCs3eVRmVTFOYWVLaW1NRS9IRTdS?=
 =?utf-8?B?WTFSazNERVcrU0xyWTVGTExWeGRCSW1mdmE1YWx5bnJyZG1oQ01KdHZQT0JF?=
 =?utf-8?B?eEdKUjBXQWRESlVrYndGek0rM2JQNGJPZnJsVldZc1QwdHhFOTdhRVVzU05w?=
 =?utf-8?B?THVsVy9ON0RlR1k3MVlQSTdDY0I1MDZhMm11YmQ1S29Rdll3czcxellrVVQr?=
 =?utf-8?B?Z0UrSnluU2lCNTZCMlB0VElCUXM0V0x6a3RFYWxSS3hQaXVHcEJTN0xMNWkw?=
 =?utf-8?B?NlBCWW9DdXdCNVBuRldIOHF0THhRWW9QQXdmVGpHdENhTnZCNUpGSnV1bGx5?=
 =?utf-8?B?ZW5MejdndmhBTVdDdlhkVnAyTG5jU2gydVgvL3M2cFZoSGZ6Y21oVVlEMVBS?=
 =?utf-8?B?LytSb2xQeUYrclUwUUo1YXRYbE1sQjJ2ZUJpVXBQbENjWEZLTE5ja1hZTVVl?=
 =?utf-8?B?cXNBQS9rRUVIUHExVVlQc0pzNm4xN01ra3ovSEM5Vmg4R0tBMHhyWnU4U0tr?=
 =?utf-8?B?RGd0eUtnYm1KK0lHb2JqbFJ3d2tVdTA0YkVQVmphNjZQWG1xcElCdjEzNjBx?=
 =?utf-8?B?MThIQm5wQkVSMUpmb1A1WnVNd2RFNXRDSHVua3ZxSDZrWjlJSGNDdXVyN2kx?=
 =?utf-8?B?Qld6R2dkaUVHR3hYTTl2NXByWU8vUUNQRHo3RVBhUjNWT2ZOQTdYcnlMWktp?=
 =?utf-8?B?SVZ0WkxKV1VDY2ZnZys0b2Nrd1JMdjhtdkJZeW5XQ0RBaUxEQ3BlT040MS9j?=
 =?utf-8?B?aWxSZ2luZE1ueE1EbnhTVk04a1oxbnJEMks1UUxFdkJrdDVXdFpEdGxIUEtn?=
 =?utf-8?B?M25oN0dVckM3YitFK2V5dzVFa3ltVEsvTG1RL3g3S3UxVkpTRGZLeWJtdlpN?=
 =?utf-8?B?VHUzY1M1RVVwTXBocURWM2hDYTdrYWxEYkRBQ0UxdXRvUTcyQVVJOHczYVBq?=
 =?utf-8?B?OXVzakV2Nitod0cwTzV3VDRQcml3SFlNTmJuRktpYWJFS0FITEN6Y0dRKzlG?=
 =?utf-8?B?UU5PUzJSOEhNVU1hUjR2VVhBejI4M0RiVVN3b1c0a0JFR1VwbXpzSTZaWnpn?=
 =?utf-8?B?cW14MWF4TTdKVFBwc05IVC9raU9WeklWb014cTZ0U25YL1A4SmVVTngydXd6?=
 =?utf-8?B?QndGV3MvWlI1eEpCSTFEQnRCSkJJWGZyK1g2YmhHVW9NU0dDbFViN2FaT21i?=
 =?utf-8?B?d25GdTlhNDUwQmpQQlZPRXY3cXJYZ3B2L1FVdW9kVTFYREQyRHRQT3V2TUZX?=
 =?utf-8?B?L1VqMk1RakFpMVBRNkxoMnhnN09BSE1Dd2J4VVlsNDdxQ1FCUE1sdz09?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b7de7ecc-49bf-48bf-e2b3-08da461306cd
X-MS-Exchange-CrossTenant-AuthSource: MW4PR11MB5933.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2022 10:14:36.1635
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qKcM3Ek0XxFyZeRnSv03yvOPqj9dvL0FjoTELxSBb+9Y1BY2ACZTzH8DSEtL6Dv+ZBrx96fdzNbADQ8xDkcFpg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR11MB3310
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-9.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/3/2022 19:01, Miguel Ojeda wrote:
> On Fri, Jun 3, 2022 at 12:32 PM kernel test robot <yujie.liu@intel.com> wrote:
>>
>>   >> ld.lld: error: kernel/built-in.a(kallsyms.o):(function get_symbol_offset: .text+0x5f0): relocation R_RISCV_PCREL_HI20 out of range: -524435 is not in [-524288, 524287]; references kallsyms_names
>>      >>> referenced by kallsyms.c
>>      >>> defined in kernel/built-in.a(kallsyms.o)
> 
> There are similar reports for the same relocation type in trees
> without Rust support merged, so this might not be being triggered by
> Rust itself, e.g.:
> 
>      https://lore.kernel.org/llvm/202206010956.rOpdU4dr-lkp@intel.com/
>      https://lore.kernel.org/llvm/202205280837.PPVZBhXr-lkp@intel.com/

Thanks for the info, it looks like an existing relocation issue in
kallsyms under riscv arch.

commit 2087d6ac3567b (kallsyms: support "big" kernel symbols) changed
some code of kallsyms to support long Rust symbols, so it exposed that
relocation issue and triggered this report.

We'll do more checks next time to ensure the reported issue is indeed
Rust related.

Thanks,
Yujie

> 
> Cheers,
> Miguel
