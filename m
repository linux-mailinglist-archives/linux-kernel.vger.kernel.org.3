Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37BE24B5AAD
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 20:50:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229578AbiBNTpm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 14:45:42 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:51336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbiBNTpj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 14:45:39 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4780A15338C;
        Mon, 14 Feb 2022 11:45:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644867922; x=1676403922;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=UFh2ex0enLPfhBFBVqPZf4oDIyOQ9S3EEM3bpw9Z6nM=;
  b=ah60Jpul/mP+vKtDVDfh3/Qo01aiec+4iZ9MuA8R6mDyBvTmEItpr4C9
   Vj4ajOfjOawzS77KKxz/OAC3JkDqEQ+CRNiWmsRBHtUaYgNoALAzEzJ9S
   Iafx3r366qM7JFWfE59FnXqs4W8w0FyKCsar+n2XwIx3Np0r6j2Ymym2E
   r7r+PmPyWDTU1EaTsMKEU/LBvCwX1n0b8j+iFGzloEt81RYlIis3rFGWI
   WdKECGfG98hxWiNegzCIu1YfynYgoenm7qrKdQ7JewTGHjiiVwLqh6WIu
   dZCZn/+EsEKP2vu3bauBwZWV3xxy83Gcq3uPqcKDlC3mA8geAwY41QIVn
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10258"; a="249916148"
X-IronPort-AV: E=Sophos;i="5.88,368,1635231600"; 
   d="scan'208";a="249916148"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2022 11:34:17 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,368,1635231600"; 
   d="scan'208";a="632307063"
Received: from orsmsx606.amr.corp.intel.com ([10.22.229.19])
  by fmsmga002.fm.intel.com with ESMTP; 14 Feb 2022 11:34:17 -0800
Received: from orsmsx604.amr.corp.intel.com (10.22.229.17) by
 ORSMSX606.amr.corp.intel.com (10.22.229.19) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Mon, 14 Feb 2022 11:34:16 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx604.amr.corp.intel.com (10.22.229.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20 via Frontend Transport; Mon, 14 Feb 2022 11:34:16 -0800
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.44) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.20; Mon, 14 Feb 2022 11:34:16 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=adF8pVgiyyKuendezYaqJjIhuDDkrnGkIhF5EmWHac+zBS6UKhAjgyXpX9xMywTa3pFMYSTso4jz7ij4S/O6Y5j9lC0CtpXa8rwWWZKmkGKRC08rPZ/O+TY5pUnEYgQMr5MHldvo3OnUblCxscViDZ74kjKRU//btL8yhGLlnyRL7J078LSfbXkB5DP1HzcRXq5zhu6mEMXTATOgsbZdfpfWGvyv1eOr7Dcil5x08OolqLQVXsSDKhNhwpwwnBp4rY/hDvfx6hovbCXpJbAsuiCZlNk/ETIC8wolv+HOr/nz0Q6XTdVv3Q/DVTObcW+a0q68CCRgwS1feIeWsS9v0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O6bUKuL8hN70vGLuwdXGaoXpbZR6uwAIb7YfRS0QjRQ=;
 b=XlwxGUi7LeCpjeIHXg8u7VBE4Y6JK2TNAx0PPCdXqs5c6Y1EqXbv5cXqFC62R+eGmSdEaT39pRrpsYB3lwg0m2iMOorspZdrBNbn4egPT2frnnbwCeVn1lOwBCrYfwl1qSkSgVz70K6bnX1MMYGVIHwB8r/A72D+kTFROeYqnKuTKSec76b4cEvLCcE0vjm6fEkUQSdtaMUT/twK0sKj+dxG/OiuHfF4Zqlv/9pMIEteeIWPHTVaW2FUDdo6MNbJ4iWSzeM1OgbTScE14TqqEILokR6QcdHbjugRwtCXUWdLwoaCSZQKH30GzDSzj8gkyj5G7yjDH5AnJPSSp6rhMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MW5PR11MB5810.namprd11.prod.outlook.com (2603:10b6:303:192::22)
 by BN6PR1101MB2243.namprd11.prod.outlook.com (2603:10b6:405:50::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.12; Mon, 14 Feb
 2022 19:34:14 +0000
Received: from MW5PR11MB5810.namprd11.prod.outlook.com
 ([fe80::1419:964a:8506:5420]) by MW5PR11MB5810.namprd11.prod.outlook.com
 ([fe80::1419:964a:8506:5420%5]) with mapi id 15.20.4951.018; Mon, 14 Feb 2022
 19:34:14 +0000
Message-ID: <59ef4cd5-5703-2356-c893-9858985f91e0@intel.com>
Date:   Mon, 14 Feb 2022 20:34:07 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.6.0
Subject: Re: [PATCH] x86: Preserve ACPI memory area during hibernation
Content-Language: en-US
To:     =?UTF-8?Q?Amadeusz_S=c5=82awi=c5=84ski?= 
        <amadeuszx.slawinski@linux.intel.com>, <x86@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H . Peter Anvin" <hpa@zytor.com>
CC:     <linux-kernel@vger.kernel.org>,
        Cezary Rojewski <cezary.rojewski@intel.com>,
        Linux PM <linux-pm@vger.kernel.org>
References: <20220121103938.2602637-1-amadeuszx.slawinski@linux.intel.com>
From:   "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Organization: Intel Technology Poland Sp. z o. o., KRS 101882, ul. Slowackiego
 173, 80-298 Gdansk
In-Reply-To: <20220121103938.2602637-1-amadeuszx.slawinski@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR0P281CA0003.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:15::8) To MW5PR11MB5810.namprd11.prod.outlook.com
 (2603:10b6:303:192::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c8d55944-b29e-4666-ca04-08d9eff0fb76
X-MS-TrafficTypeDiagnostic: BN6PR1101MB2243:EE_
X-Microsoft-Antispam-PRVS: <BN6PR1101MB2243EE54333DDBB1E8F5DE78CB339@BN6PR1101MB2243.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:154;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sp038G4R1hbkZ1rjv7yjBktS5a+aFjJEwTPn3zHuefx2hI25a+aNruGO7PYQDsgcc6Q+BXzXCGdHCfaS39cYtRLyHPzvtINjYuiDLeXLkQIEyW7IUODc1DxJeAljGTISxYDUpmSrAm6B3hsYIU1p9gQqf1nY4xFxjuL8U3VfQVLVGTDBIMyYjAmIZTh3kJX+xhWWNblWiG1HkhgBXlhqRKN9Pk0hwKy7uYda2/l3DlnjHsczxsu9WF2bmYW4kTx7QRgbOhylDKV1tF9oPvq7DGBewXVJx76Yt1LoWmRwUFn4eiEdkzHQs6CsOd/4Pesy/ZD8PbYxbV/X0O61/i80hzvIaPo/YDL3gTDtuMZ0UXFMSJQ2+pyG849XFleSVCSYInOEMzmLpoejS1hWAasW3TxO+px/Uj9TblTJtzbA4l2uDY+hw/8rRQjZkI1IrdTADP6i7b4TD/BImhmSNwff2BNNF9C9nq5cLLR9ArIHXc85W2uh1m9ZdE4mMSrZaqt0+DP/soEOiGvQfNiz2NWAM4swkgkKIzPxf8li+g0PNIkaGEdAsFhl8mZRDL94iev7xzoeg2L+cZ7lZBzc4owgnCvdF2jOFLiQm5rARw37BOPcHDYlTc9p+TCZWMNIUONWVzpLX+RtxlbLos+/90h1Hs6rQaT7jUq8iaKYEAlHNndcvXt4+2xooBUJ2tmlnFCpz9sReshGipbM23490qJZM3hV1lrCvm66ksDzCnMH0ro=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW5PR11MB5810.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(6506007)(6512007)(2616005)(53546011)(66946007)(8676002)(66476007)(66556008)(26005)(110136005)(36916002)(54906003)(508600001)(6486002)(86362001)(6666004)(316002)(31696002)(82960400001)(83380400001)(66574015)(4326008)(38100700002)(8936002)(36756003)(5660300002)(31686004)(2906002)(186003)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?N0tzUXNOZTJjV0ZhQnpKV3JYd2Y2Y2tHZVorMDRZc0ErTEg0c3NoZUFQZlFl?=
 =?utf-8?B?TTdENlNDWTdMZFk1TjlQVHBCbyt5U2p3dmcvNTlrM0dwenZSRXZJTkNtUk9R?=
 =?utf-8?B?M2NMWHZVUUJycFdWS2J0RWNCUm9EbzBwL2psbGhtVkM3VFJ4OEpqdU5TNVFY?=
 =?utf-8?B?dUFyYlRLOE5mN0tFSlJqZ042ejd5YzZuZ1BGWFhFaDBkZFNRS0tjUTZ0bjlm?=
 =?utf-8?B?TndWbUg5ME1TMFVNam1yNXp0WnQ1ZVJTT0dOQVEySlFDQU9mdUc5OUpReTRP?=
 =?utf-8?B?STBUN1gzeFprY3JkQmxmQjJxL2NTRHYyQTBtMnpPTW1pN1g0OVlycndYSkoz?=
 =?utf-8?B?R3g1ajhKWWRzWDdtT2xxaUdheExzR1pONENEMG1RUHV0TGFVdGpmbTRwSFF0?=
 =?utf-8?B?UXpiU0NnV2YzM3o0MlFPUkVyUFJmc1lRUXgyVEdZWVYvMzU3OFk1YmREYlpJ?=
 =?utf-8?B?NG8vMEp1aWU0M3g0UnJLcExMVUkxUzMvTjJJcUt3dGc0VjRvdVlIT3pTSEEx?=
 =?utf-8?B?KytoMWp1MS9CT0g0aU5URThWUkZvZkdLSFgwdUc2dzJEN0Fmd1Fyc0R6Q3R1?=
 =?utf-8?B?ekNJTFhKd2UySWl2d2tyd0dCNUg5aXRBU0xqS0VaK1BxajNUNEZ3TzhDbGpz?=
 =?utf-8?B?Qll1R21maWYwejBrNXRGVkxmaWt4NFRieCtiWGkrc3VTbUI0dmFxVnBVTmw4?=
 =?utf-8?B?Q3AreXJvV3B1S3pGK2htUm5lRk14d2Z6QmZFK1ViY003L1VmV1R5NWJ3SWNj?=
 =?utf-8?B?TTkxdUlSNjRZbzhUbXpBZWlPNGc4YWh4QXBMZDNzNXBrUkgvQkhQb3JFOG5D?=
 =?utf-8?B?VXpGczNQc1NOWWNvSEdXOTNoZFozTUVLa0VnOUxyVEk2UkdGOFcrQUdTcFFV?=
 =?utf-8?B?Q1c0cGhRaTIwNE9SS1pXWFE4UzZqVkZ0c240Y0dwbC9RRHVOZ3FTM0hPUmg2?=
 =?utf-8?B?YVFwanJ0ZkZYclRMRUQ1MExVM2R2dkVvM0NMYnRRbGsvS1F4aDU3cERvZGZ5?=
 =?utf-8?B?MDFnVGFSNnZuK1NUeDJuUW15QmRaUm04V3JDcGgzemo4SkNuWDdQZDc3Qmwx?=
 =?utf-8?B?QU5wWllYUFc4ZFlCc2ljbk9qSHpEc2lGQjFoV2VlWXpFaEpHWElYY2VPT01x?=
 =?utf-8?B?Ni9qd0xobWNNMm5LS3VRSjUzUE1UMnRtK3lndnkxQkpnQi9FYW9XMDI2S1lI?=
 =?utf-8?B?bFRXY1l4Slh0TlRIS0N5andvYXcveDdoSEkzQ1dES0ZnQ2JHMTJDL3FvSWJk?=
 =?utf-8?B?RlN3dEpnQnJVTTdpWW5hMGhPYmFNVkd0ZWVpcVB6enAyMGx2Y1pZOEQ4RGN4?=
 =?utf-8?B?cVBPUTZPdkJKRlVnVEtoVGpWRzYxd2VGNTNvTHZvQ1ZjT3pMTC9qWE84eTdD?=
 =?utf-8?B?SVVTbFlKcEtyYnU5RFovYkFabTVmWDdFZ1BQbUozb1BGa0NWVERRellCbGZm?=
 =?utf-8?B?TG1GUWNjbnRlWkZ3SkZlMVJidzhVNzY1MG9yUjFNRmpHOXA2NVZpemlCMDRQ?=
 =?utf-8?B?Ulpyc2YvMmw5bUlEdDhXSUNsVTB1ZFNoQmNOVWtXbnVmc212LzAybEdmZWFZ?=
 =?utf-8?B?QW00UGZyY0laME15QnJCbzFBME1OYkNBWHlhcWhzWjdvN2YzRXJhNFNqSDNk?=
 =?utf-8?B?ZVgrdVJzT3J2MnpRd1NmbXZtRzhIcEJKMTFOeEorQVFNdTByVW51OHlYYWg5?=
 =?utf-8?B?dTBHQWExa2MxQ1JJN2R0bExHTHBNaSt5UW5tR0w1amp5MG9RdVAwNVcwOWp3?=
 =?utf-8?B?OG5NWmNROEtrREZ1QTR4MlJaZVJLTjM4cUFXRkpkMHczQTdzMEZwOEJvTkFI?=
 =?utf-8?B?NFVYd2NkcExLdnNBNE5rWXJLSlJkNDJMcEFqdkxPd29DcWNrL3Q3U3FhSUpr?=
 =?utf-8?B?NUc4aHVNanFwYmNwRFBGdFJsSVdodzdRaXNrUzROZmJNNU5EOHFhdUtZMVBi?=
 =?utf-8?B?eXlheUNQbzV3N0tyWlNDR3ZWVk1qZExzYTRSNllLcmh1bkRFMTBselpIMWdp?=
 =?utf-8?B?RnN1eDhOUGdQblE3U1FPOWl4LzYrcmxFMEFiMmJ6d3hXa1RkQ1VOSWhxajBL?=
 =?utf-8?B?aE1zRUVWQzg2ZFc1TDJhVWhhNG91cENyWDhBNGNnN29BeG95LzVBMUZRUUNG?=
 =?utf-8?B?OWdVd2Y1Q2R5UjB5WExoMnIrenQ5andsaGpueFVkRWFqSnJwVmp6SmY1RC9I?=
 =?utf-8?B?TnZUQ093WHZ6MTNaL3NVeUpZWnhUTkJDZ0FCOWZWaXBkS1gxb29zS1VGNXlV?=
 =?utf-8?Q?osxOpbYJq3vokWY8Rnfl0PL5taGuYOVkNKDOq8fNtc=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c8d55944-b29e-4666-ca04-08d9eff0fb76
X-MS-Exchange-CrossTenant-AuthSource: MW5PR11MB5810.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2022 19:34:14.2361
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9GjmOj5ms06eUqz53acBEWREvxtjfmFqwkSmw9A0XzXaPMHvB9qBPoTMmHRZcEN12+E8p0iQsTfxmGErICFNzW0IWOVR80N728mF3JzNRks=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR1101MB2243
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/21/2022 11:39 AM, Amadeusz Sławiński wrote:
> When overriding NHLT ACPI-table tests show that on some platforms
> there is problem that NHLT contains garbage after hibernation/resume
> cycle.
>
> Problem stems from the fact that ACPI override performs early memory
> allocation using memblock_phys_alloc_range() in
> memblock_phys_alloc_range(). This memory block is later being marked as
> ACPI memory block in arch_reserve_mem_area(). Later when memory areas
> are considered for hibernation it is being marked as nosave in
> e820__register_nosave_regions().
>
> Fix this by skipping ACPI memory area altogether when considering areas
> to mark as nosave.

This patch looks correct to me and I'm going to apply it as 5.18 
material unless there are any objections or concerns (in which case 
please let me know).


> Signed-off-by: Amadeusz Sławiński <amadeuszx.slawinski@linux.intel.com>
> Reviewed-by: Cezary Rojewski <cezary.rojewski@intel.com>
> Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>   arch/x86/kernel/e820.c | 12 ++++++++++++
>   1 file changed, 12 insertions(+)
>
> diff --git a/arch/x86/kernel/e820.c b/arch/x86/kernel/e820.c
> index bc0657f0deed..88c1b785ffe4 100644
> --- a/arch/x86/kernel/e820.c
> +++ b/arch/x86/kernel/e820.c
> @@ -758,6 +758,18 @@ void __init e820__register_nosave_regions(unsigned long limit_pfn)
>   	for (i = 0; i < e820_table->nr_entries; i++) {
>   		struct e820_entry *entry = &e820_table->entries[i];
>   
> +		/*
> +		 * Areas containing ACPI tables should be preserved during
> +		 * hibernation to prevent potential problems caused by BIOS
> +		 * upgrades when offline, as well as to preserve initrd
> +		 * ACPI tables overrides which are applied on boot.
> +		 * See also acpi_table_upgrade() & arch_reserve_mem_area()
> +		 */
> +		if (entry->type == E820_TYPE_ACPI) {
> +			pfn = PFN_UP(entry->addr + entry->size);
> +			continue;
> +		}
> +
>   		if (pfn < PFN_UP(entry->addr))
>   			register_nosave_region(pfn, PFN_UP(entry->addr));
>   


