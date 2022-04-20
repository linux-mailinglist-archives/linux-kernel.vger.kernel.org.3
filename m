Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AF03508D1E
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 18:21:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380503AbiDTQXb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 12:23:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380499AbiDTQX3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 12:23:29 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 538DD3BBD5;
        Wed, 20 Apr 2022 09:20:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650471642; x=1682007642;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=+aWTgi5DgGviEJ08xSd1qOzQ7Yl/YK1Q0kLau0AdjRk=;
  b=Ndeah5ewsh3ZpVvAy45OCNfRVPKvghubhnmaQvqioUroRDFBaX758xE9
   QxXzz5aUiDQk+tJOKHyJmQsNICn2cV+AxP9xRvDXObS0ENmwkvBEqZOhe
   Qb0qIkqJ4G/1Te5CNGgtosigrAKjnKWt47+s7xTfJYmqhQuVYsKXeWnG4
   PWQ/iaKP+rveOlBAHRSpSjjewbTteaH31wpIOCQnWswTKVM6Vrh54urUg
   ezQwEGkH8DISAqozplaMdtYRqcqd5eon0aPO7SvgE4wjt/1z4bZ4cILgK
   Ezr36xzkHpF2qcXF2VnnBA72O+7L9ufTI+bJNjj//r5ccBk0/SuNH9HMM
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10323"; a="263839430"
X-IronPort-AV: E=Sophos;i="5.90,276,1643702400"; 
   d="scan'208";a="263839430"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2022 09:15:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,276,1643702400"; 
   d="scan'208";a="576663608"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga008.jf.intel.com with ESMTP; 20 Apr 2022 09:15:03 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Wed, 20 Apr 2022 09:15:03 -0700
Received: from orsmsx604.amr.corp.intel.com (10.22.229.17) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Wed, 20 Apr 2022 09:15:03 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx604.amr.corp.intel.com (10.22.229.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Wed, 20 Apr 2022 09:15:03 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.169)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Wed, 20 Apr 2022 09:15:02 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kgIlYXWSO/CK/+4R6SsQ1ltwEsk4CJyhsQp6Qg0A4/KTrlFrKrcVUJIgRHs6Kltq32dusJGvSsNELf2vqBBXfPSk8u0/rlPtTsGC7vIfM6bZkN8ep3iK3cNVtGDB8EArj+aKhNrW8ORGShkhIOvYddjUoy62SMooRJkCvsPakLKbQbhv2Tdkg3LjDJTrUjx27oOokhhwbsT3ww19idyHdnv/W63I9rxjILPX1QG8XteM9P/QMZwlk3OJORDE3HRZ8nt2+/eHS4JBsG6t1uXTGs2qLQGl2QjWj+x8xAHBZ6ub5oqcc7Qe02C6dpWbSLEs5JM2Bb+v+kBsemtYiAAduw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q9+HoYmFp1uYXrokAbYoHpOuhsVWfk+2Vix96E6OQe4=;
 b=krOTGhWFrhPYzlqnlnPGdPwPv1xNOum7RED7OZTCv+UmNM3k+NFOh/QK6ktHPqigs0+Xx4lyFMMCh1DGkCxlLwaXEWdppjd1CNxghgorm86bSI8qbDfwzzJi4NCJTo3rvV6RiayP3PLtAFmidQJBBp9xoKAhgJMQJMtp+jc8OugGXwJYyrlAs4ZrIRqUqeEdQkw6/9htEVeFPH2is4kmeVB7YWuBxFztirdO0/usddDWc3oHhRZ5E6pT612uw3Jg5Bau27LADJpF5fICH27hvmPSYIEySKD7/vMmEy39qidRE9x139LCKZzXl+CoR/bcdvNkubz3JrIR/cyVPYWUuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MW5PR11MB5810.namprd11.prod.outlook.com (2603:10b6:303:192::22)
 by CY4PR11MB1928.namprd11.prod.outlook.com (2603:10b6:903:11e::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.14; Wed, 20 Apr
 2022 16:15:00 +0000
Received: from MW5PR11MB5810.namprd11.prod.outlook.com
 ([fe80::98d8:aa81:9f56:c36a]) by MW5PR11MB5810.namprd11.prod.outlook.com
 ([fe80::98d8:aa81:9f56:c36a%9]) with mapi id 15.20.5186.014; Wed, 20 Apr 2022
 16:15:00 +0000
Message-ID: <78b6d874-905a-0c84-bdaa-a9ffe6c2cbf4@intel.com>
Date:   Wed, 20 Apr 2022 18:14:53 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.8.1
Subject: Re: [PCI] 62d528712c:
 BUG:KASAN:slab-out-of-bounds_in_acpi_power_up_if_adr_present
Content-Language: en-US
To:     kernel test robot <oliver.sang@intel.com>
CC:     Bjorn Helgaas <bhelgaas@google.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        <lkp@lists.01.org>, <lkp@intel.com>,
        Linux PM <linux-pm@vger.kernel.org>
References: <20220420064725.GB16310@xsang-OptiPlex-9020>
From:   "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Organization: Intel Technology Poland Sp. z o. o., KRS 101882, ul. Slowackiego
 173, 80-298 Gdansk
In-Reply-To: <20220420064725.GB16310@xsang-OptiPlex-9020>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR3P281CA0030.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1c::16) To MW5PR11MB5810.namprd11.prod.outlook.com
 (2603:10b6:303:192::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 036694b3-60f4-465a-541a-08da22e8eb20
X-MS-TrafficTypeDiagnostic: CY4PR11MB1928:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-Microsoft-Antispam-PRVS: <CY4PR11MB1928FB4A68016C8FC7E321EFCBF59@CY4PR11MB1928.namprd11.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qK9gcUkHZ1tleEJRExvS0vSGulazG9t/MUt21flXdPg0BCviZCP7IeuL4yaGGEXWKKBT7+erA2ILZVQoVz4EsxT0ZUSjyZ1gMzGcsA00BcJ1A2/uKHkyWH6bgsWHzLZGamZUncUpHeF1hrVRorR1qBMrMPLT9B2GA7pkHCUg5r8Wi6HJ0sY5pGIE6EmPyxAEDgycs+qNI0nFVaCndkJckWb7gFAgxIhrK5hBvRiGwty2eYiIozbh+YhUwRG/IaQyUgoJiY5e8x2+66E9FaNIjGmCp5bEAtTL2UG00dQKzJ+qBe8fy6KrXCcWsBsGmy6k6DPh4Zh4Y6WjAmnEQqc60oA8D5j1XNTbtNYq3e3z4Qj2wvj4aSlm/6G9xOK024OjHMsHc2lYUUz7MMoP0uO9yHjAmWOS9eUgSoIrNNd59H3puhVoY6BqKy8PBN6DQz6WOuf8CtCVDQ077ev9MBrPQl8NXH0tHqepgixo8Q8kUJWWVA+JHS2YfkbPmKrI+TdIY94MQVQSbK6eWQO6Q/cBebe64gLqlRlx75GU0Z+MsjRQzVVAPKzDkxSCr/BBlD4OCPOStZoSJvTfUjswK3IB4EmflMQwqv56nbCy1KH+rMK8J4nLVghsYM0TKpb+cuFV0NIqx+4KmoKmLPkWXNTORJ+6zzSIji6O1CMR1bIqb7lTo1RKICoHrcIv3pItlT1Ut/DWroH1EJG1mEtnXJCSLKkh8IaczYb2s7FS/JCQ44dHKbBxs4m68RuAlIeQlRR1Cucu+dDQoFDQ/7QWsYHwzdY412IfzMXiATxVwGXM1TjLQTZUkwbdR87BSExw8d8vYp+vWKQINAdxRdLpX0aItBtT8IJG7nD8+iTTNo7sKAA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW5PR11MB5810.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(316002)(6636002)(82960400001)(37006003)(38100700002)(54906003)(30864003)(66556008)(66476007)(66946007)(5660300002)(966005)(6486002)(6862004)(4326008)(31696002)(8936002)(86362001)(8676002)(83380400001)(2906002)(6666004)(6512007)(6506007)(31686004)(36916002)(36756003)(26005)(53546011)(508600001)(186003)(2616005)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NkUyQmIwczNhTERQM21oeGQwWGM5SC9zS3E1dVk1Y01xSGN1VlNNamZpRzBs?=
 =?utf-8?B?WUhLUDJlTjhFb2pNbFJ3Z2JSMy9PbFBUZEl3dUtPWFZObUFZYTJibjZPbHNq?=
 =?utf-8?B?MHdPMkNWRjFOekZEb2dvbDVTcmpJQmo2M3NFc3BqcTRMWUhTSHpWL04xYmll?=
 =?utf-8?B?RWp3WmljWGRpRThiZ3FJZ0x4QnNIQk44eTByNEkwY08zYkdEdTB4WkVTWTAx?=
 =?utf-8?B?bVNud25zam5SYWo1bVUydVo0MWdYTkY2Mm1VSnY2OFhBbDh5cUlZbzBKc2JM?=
 =?utf-8?B?Qjh4V0VEYkVpQ2xtbm5meEx5UjBiWnp4UU9CcVNpb0NVa2RzaUErNG5NblBE?=
 =?utf-8?B?WU13Rzl1SHNUejFTN2FSM2hVeEFOK3dqTzRhaW95aFZZNVdyNkdWWlNQT3lZ?=
 =?utf-8?B?V05MRjhMK3hYZnYvOXZoU09DWWtKQVNNRkZFSVhmdlFlaWVBU1l6YVg2UGFD?=
 =?utf-8?B?UkxpM1hJVkh2b0N6SFFTenNTN0E1dTR3NWZ6NGJ5dHR2djRFa253bWw4RGpm?=
 =?utf-8?B?VVdFUzF0eE5ZaytuekdYTm54TU9VeVJzRkFzd1pLYVp4T0Y0L2VKc0N6ZVdm?=
 =?utf-8?B?UEsxdEpMWUJabVJ3MldMMFptd2FiVE5RYWgrMUdnVFFDZVQ3cWRIanBybnJI?=
 =?utf-8?B?Mmd2OHZab0ZsTlZRRFd3OE56Rm9ZT2U3NXJqTzJpTFF3Z1ZncXVWU2EvQ2tu?=
 =?utf-8?B?SzVkcmlUbXdMTFZLcUsvV3k0b3FlUzBGRHA3SmNNcTdpeE9ESFpGZmRvRE05?=
 =?utf-8?B?VjV2Z2FtWERaRXpoMXVWaTgvc2daSm5HeWszWVJUYXdwNXJ4VklwbFRxeDZV?=
 =?utf-8?B?ay9OUzRweVppKzRxdE10L09CUFY0dTFBK1VHS0FhRWtEQjMvSWRBV0pRcFZr?=
 =?utf-8?B?K3Iyd1NEVkQwaTZYamIzUXFSOWFGaWs1dXJCcHRVWVJvelJVOUErek9SQ2hr?=
 =?utf-8?B?TDhGbTBUaXU5akU4UWt4Uno2ZDllM2lqVlNWaytqejNDSENsYXBjQW12Vnh3?=
 =?utf-8?B?WEVmUy9WaXJvQ25WbGpIR1AxWktXdW93WS95azZiY2RUYXljVUxRMERtY3ha?=
 =?utf-8?B?WTJLYWJaNUN3WFhIM0JLNGhRRFlES05OM3BSaWYrYjF1RW8xYmZqaE0xQS9T?=
 =?utf-8?B?aDZ1UWVrM1lZNm1FdzdpL2JDNVF4Ry9vQmlwTHA2a1hlRkNqQkFrTDFRWjBy?=
 =?utf-8?B?T1JncytNVThxbStkbTdhK0d6ZTlhSnJhNU0rWXN3ZWNTWmdEL2RnaDdhY0FW?=
 =?utf-8?B?TStVay9TLzRRcmZkeDJWdndrQjZEbmJwV0ZIejdoNDJnTFo4UEYyWHg2NndE?=
 =?utf-8?B?Q3JQcjZTZ0drVkJVSFpoTml1UFFNb1hQN1FIZUFRMDA4SFN3L1RGeUpUdFRt?=
 =?utf-8?B?bldQVzlUM0tqOTFGSlhWSkZqSnc5SWl4dVd3MWhJd3BCNzRlUXFNL21hUWR6?=
 =?utf-8?B?bFRaRmZTaHRPempveUkzV3I2RXpjcEpTZG1IR3hGVEJla2tvRUtkVzgyd3A5?=
 =?utf-8?B?b2d2WHd3RzJTSFUxUlZMbk9sUlBoaHI1Zkc2NzBDV3ZTNnZjRTRmY2RCbW1T?=
 =?utf-8?B?c3RhckZNaFZtdVlQVnJ2eldKd1VBcmNmZVVXWVNoRStQTVBjdWVMeGtSSmNP?=
 =?utf-8?B?YUx5eGowWDcwelR6SldOS2lXbzdvL1UyRDFVenZ1SVlMdEhkdnBlMEI5VGtj?=
 =?utf-8?B?eXFqRDgyRmdXaWFnU2xzdDVPVjN2UEVqQzM0ajhCUzMzUmx0OTFmTjhDY05Q?=
 =?utf-8?B?TTVBbGVkdnhQdnNoZ1hoZ0YvWUpKOEFaYkJ2U0dIYWFVb2tFcXdadEFxVXRh?=
 =?utf-8?B?NjcrbERuV0g0SEo5SzBMUVR3b2c4ZldLcjc4cUxYY01FalBqYmZjTTJQSUxM?=
 =?utf-8?B?alpkVXlWL09MWThNdXVkMndwTVd4YXUzTFB5UzZhRFVaTTFFeWVmWXBRMWlF?=
 =?utf-8?B?L1A4eFZzNXRYUk1oR002TUpqa0NaR3BUTFY4dFBRczRpTkl4VkhpdlI4NHFC?=
 =?utf-8?B?K2NmVmo5S2xhWEhCTHJyQ25VQ2hqY1dzallXemx2OFptR1lYeUgwUkNTdFB2?=
 =?utf-8?B?dFIzQzU2Uk9ES05jUENFYXdYYTBNdVN5NStERWZNa2Q5NVB6eFBSVlE2cjRM?=
 =?utf-8?B?RVdXUXc2VVlIZ2crMzFTN0x6Tk9VOEFnYXYvZTczWUpxWmUwVGFKQmRoRGZJ?=
 =?utf-8?B?UTYxcWxacm0xQWRxRnFaOU14RFhuQWxhdmc5WlFJaThFK2I3SEN1SW1iWUZy?=
 =?utf-8?B?QVgrU2VOT3RXRDFLY2d6NmVqdGJqZEtjNkw2WEJBZDg4UkJCQlNOWXJBK1ZC?=
 =?utf-8?B?d2NiSTlqZjVNcXE4aG9HclVRd0JlKzl3d1MwekFpYW1ramhsbFJ1enhTV1BQ?=
 =?utf-8?Q?kJctgG8CpnuH4id4=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 036694b3-60f4-465a-541a-08da22e8eb20
X-MS-Exchange-CrossTenant-AuthSource: MW5PR11MB5810.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Apr 2022 16:15:00.1849
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cLTppNOjF/Zkb/MsCzaLl2bCHTkUCea2GS1wBhuAlIaUQi/Cmo+rHcMP+QePqfSWbCvk2FJRI0TwQHBRBDx0D/HyRz+vT//wMTMpqx+uiIg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR11MB1928
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-9.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/20/2022 8:47 AM, kernel test robot wrote:
>
> Greeting,
>
> FYI, we noticed the following commit (built with gcc-9):
>
> commit: 62d528712c1db609fd5afc319378ca053ac9247e ("PCI: ACPI: PM: Power up devices in D3cold before scanning them")
> https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git master
>
> in testcase: kernel-selftests
> version: kernel-selftests-x86_64-a17aac1b-1_20220417
> with following parameters:
>
> 	group: resctrl
> 	ucode: 0xb000280
>
> test-description: The kernel contains a set of "self tests" under the tools/testing/selftests/ directory. These are intended to be small unit tests to exercise individual code paths in the kernel.
> test-url: https://www.kernel.org/doc/Documentation/kselftest.txt
>
>
> on test machine: 96 threads 2 sockets Ice Lake with 256G memory
>
> caused below changes (please refer to attached dmesg/kmsg for entire log/backtrace):
>
>
>
> If you fix the issue, kindly add following tag
> Reported-by: kernel test robot <oliver.sang@intel.com>
>
>
> [ 35.970292][ T1] BUG: KASAN: slab-out-of-bounds in acpi_power_up_if_adr_present (drivers/acpi/device_pm.c:433)

I don't know how this is possible.

The only memory accessed by acpi_power_up_if_adr_present() is the ACPI 
device object passed to it by acpi_dev_for_each_child() and it cannot go 
away while acpi_power_up_if_adr_present() is running because of the 
reference counting in device_for_each_child().

There are also suspicious items in the call trace below.  For example, 
it is unclear why acpi_pci_remove_bus() is present there or why 
acpi_bus_set_power() is present there.

> [   35.970292][    T1] Read of size 1 at addr ff1100014215fe0c by task swapper/0/1
> [   35.970292][    T1]
> [   35.970292][    T1] CPU: 49 PID: 1 Comm: swapper/0 Not tainted 5.18.0-rc2-00003-g62d528712c1d #1
> [   35.970292][    T1] Call Trace:
> [   35.970292][    T1]  <TASK>
> [ 35.970292][ T1] dump_stack_lvl (lib/dump_stack.c:107)
> [ 35.970292][ T1] print_address_description.constprop.0.cold (mm/kasan/report.c:314)
> [ 35.970292][ T1] ? acpi_power_up_if_adr_present (drivers/acpi/device_pm.c:433)
> [ 35.970292][ T1] ? acpi_power_up_if_adr_present (drivers/acpi/device_pm.c:433)
> [ 35.970292][ T1] print_report.cold (mm/kasan/report.c:430)
> [ 35.970292][ T1] ? do_raw_spin_lock (arch/x86/include/asm/atomic.h:202 include/linux/atomic/atomic-instrumented.h:543 include/asm-generic/qspinlock.h:82 kernel/locking/spinlock_debug.c:115)
> [ 35.970292][ T1] kasan_report (mm/kasan/report.c:162 mm/kasan/report.c:493)
> [ 35.970292][ T1] ? acpi_power_up_if_adr_present (drivers/acpi/device_pm.c:433)
> [ 35.970292][ T1] ? acpi_bus_set_power (drivers/acpi/device_pm.c:429)
> [ 35.970292][ T1] acpi_power_up_if_adr_present (drivers/acpi/device_pm.c:433)
> [ 35.970292][ T1] ? acpi_bus_set_power (drivers/acpi/device_pm.c:429)
> [ 35.970292][ T1] device_for_each_child (drivers/base/core.c:3724)
> [ 35.970292][ T1] ? device_platform_notify_remove (drivers/base/core.c:3714)
> [ 35.970292][ T1] pci_acpi_setup (drivers/pci/pci-acpi.c:1379)
> [ 35.970292][ T1] ? acpi_pci_remove_bus (drivers/pci/pci-acpi.c:1354)
> [ 35.970292][ T1] ? lockdep_init_map_type (kernel/locking/lockdep.c:4812)
> [ 35.970292][ T1] acpi_device_notify (drivers/acpi/glue.c:317)
> [ 35.970292][ T1] device_add (drivers/base/core.c:2046 drivers/base/core.c:3347)
> [ 35.970292][ T1] ? __fw_devlink_link_to_suppliers (drivers/base/core.c:3287)
> [ 35.970292][ T1] ? up_write (arch/x86/include/asm/atomic64_64.h:172 include/linux/atomic/atomic-long.h:95 include/linux/atomic/atomic-instrumented.h:1348 kernel/locking/rwsem.c:1318 kernel/locking/rwsem.c:1567)
> [ 35.970292][ T1] ? pci_init_reset_methods (drivers/pci/pci.c:5384)
> [ 35.970292][ T1] pci_device_add (drivers/pci/probe.c:2559)
> [ 35.970292][ T1] pci_scan_single_device (drivers/pci/probe.c:2578 drivers/pci/probe.c:2562)
> [ 35.970292][ T1] ? pci_device_add (drivers/pci/probe.c:2563)
> [ 35.970292][ T1] ? _raw_spin_unlock_irqrestore (arch/x86/include/asm/irqflags.h:45 arch/x86/include/asm/irqflags.h:80 arch/x86/include/asm/irqflags.h:138 include/linux/spinlock_api_smp.h:151 kernel/locking/spinlock.c:194)
> [ 35.970292][ T1] pci_scan_slot (drivers/pci/probe.c:2652)
> [ 35.970292][ T1] pci_scan_child_bus_extend (drivers/pci/probe.c:2868)
> [ 35.970292][ T1] ? pci_create_root_bus (drivers/pci/probe.c:3041)
> [ 35.970292][ T1] acpi_pci_root_create (drivers/acpi/pci_root.c:933)
> [ 35.970292][ T1] pci_acpi_scan_root (arch/x86/pci/acpi.c:368)
> [ 35.970292][ T1] ? pci_acpi_root_init_info (arch/x86/pci/acpi.c:327)
> [ 35.970292][ T1] ? decode_osc_bits+0x18a/0x18a
> [ 35.970292][ T1] ? acpi_pci_find_companion (drivers/pci/pci-acpi.c:108)
> [ 35.970292][ T1] acpi_pci_root_add.cold (drivers/acpi/pci_root.c:602)
> [ 35.970292][ T1] ? get_root_bridge_busnr_callback (drivers/acpi/pci_root.c:522)
> [ 35.970292][ T1] ? acpi_pnp_match (drivers/acpi/acpi_pnp.c:323 drivers/acpi/acpi_pnp.c:341)
> [ 35.970292][ T1] ? acpi_bus_get_status_handle (drivers/acpi/bus.c:98)
> [ 35.970292][ T1] acpi_bus_attach (drivers/acpi/scan.c:2177 drivers/acpi/scan.c:2225)
> [ 35.970292][ T1] ? acpi_generic_device_attach (drivers/acpi/scan.c:2191)
> [ 35.970292][ T1] ? __device_attach (drivers/base/dd.c:941)
> [ 35.970292][ T1] ? device_bind_driver (drivers/base/dd.c:941)
> [ 35.970292][ T1] acpi_bus_attach (drivers/acpi/scan.c:2245 (discriminator 3))
> [ 35.970292][ T1] ? acpi_generic_device_attach (drivers/acpi/scan.c:2191)
> [ 35.970292][ T1] ? __device_attach (drivers/base/dd.c:941)
> [ 35.970292][ T1] ? device_bind_driver (drivers/base/dd.c:941)
> [ 35.970292][ T1] acpi_bus_attach (drivers/acpi/scan.c:2245 (discriminator 3))
> [ 35.970292][ T1] ? acpi_generic_device_attach (drivers/acpi/scan.c:2191)
> [ 35.970292][ T1] ? _raw_spin_unlock_irqrestore (arch/x86/include/asm/irqflags.h:45 arch/x86/include/asm/irqflags.h:80 arch/x86/include/asm/irqflags.h:138 include/linux/spinlock_api_smp.h:151 kernel/locking/spinlock.c:194)
> [ 35.970292][ T1] ? acpi_os_signal_semaphore (drivers/acpi/osl.c:1308)
> [ 35.970292][ T1] ? acpi_ut_release_read_lock (drivers/acpi/acpica/utlock.c:111)
> [ 35.970292][ T1] ? acpi_bus_check_add_2 (drivers/acpi/scan.c:2113)
> [ 35.970292][ T1] ? acpi_walk_namespace (drivers/acpi/acpica/nsxfeval.c:616 drivers/acpi/acpica/nsxfeval.c:554)
> [ 35.970292][ T1] acpi_bus_scan (drivers/acpi/scan.c:2438)
> [ 35.970292][ T1] ? acpi_bus_check_add_1 (drivers/acpi/scan.c:2420)
> [ 35.970292][ T1] acpi_scan_init (drivers/acpi/scan.c:2600)
> [ 35.970292][ T1] ? acpi_match_madt (drivers/acpi/scan.c:2550)
> [ 35.970292][ T1] acpi_init (drivers/acpi/bus.c:1368)
> [ 35.970292][ T1] ? acpi_bus_init (drivers/acpi/bus.c:1342)
> [ 35.970292][ T1] ? rcu_read_lock_bh_held (kernel/rcu/update.c:120)
> [ 35.970292][ T1] ? acpi_bus_init (drivers/acpi/bus.c:1342)
> [ 35.970292][ T1] do_one_initcall (init/main.c:1298)
> [ 35.970292][ T1] ? trace_event_raw_event_initcall_level (init/main.c:1289)
> [ 35.970292][ T1] ? rcu_read_lock_sched_held (include/linux/lockdep.h:283 kernel/rcu/update.c:125)
> [ 35.970292][ T1] ? rcu_read_lock_bh_held (kernel/rcu/update.c:120)
> [ 35.970292][ T1] ? __kmalloc (include/linux/kasan.h:234 mm/slub.c:4414)
> [ 35.970292][ T1] kernel_init_freeable (init/main.c:1370 init/main.c:1387 init/main.c:1406 init/main.c:1613)
> [ 35.970292][ T1] ? console_on_rootfs (init/main.c:1584)
> [ 35.970292][ T1] ? rwlock_bug+0xc0/0xc0
> [ 35.970292][ T1] ? rest_init (init/main.c:1494)
> [ 35.970292][ T1] kernel_init (init/main.c:1504)
> [ 35.970292][ T1] ret_from_fork (arch/x86/entry/entry_64.S:298)
> [   35.970292][    T1]  </TASK>
> [   35.970292][    T1]
> [   35.970292][    T1] Allocated by task 0:
> [   35.970292][    T1] (stack is not available)
> [   35.970292][    T1]
> [   35.970292][    T1] The buggy address belongs to the object at ff1100014215f800
> [   35.970292][    T1]  which belongs to the cache kmalloc-1k of size 1024
> [   35.970292][    T1] The buggy address is located 524 bytes to the right of
> [   35.970292][    T1]  1024-byte region [ff1100014215f800, ff1100014215fc00)
> [   35.970292][    T1]
> [   35.970292][    T1] The buggy address belongs to the physical page:
> [   35.970292][    T1] page:0000000091ef2032 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x142158
> [   35.970292][    T1] head:0000000091ef2032 order:3 compound_mapcount:0 compound_pincount:0
> [   35.970292][    T1] flags: 0x17ffffc0010200(slab|head|node=0|zone=2|lastcpupid=0x1fffff)
> [   35.970292][    T1] raw: 0017ffffc0010200 0000000000000000 dead000000000122 ff1100010003d080
> [   35.970292][    T1] raw: 0000000000000000 0000000080100010 00000001ffffffff 0000000000000000
> [   35.970292][    T1] page dumped because: kasan: bad access detected
> [   35.970292][    T1]
> [   35.970292][    T1] Memory state around the buggy address:
> [   35.970292][    T1]  ff1100014215fd00: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
> [   35.970292][    T1]  ff1100014215fd80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
> [   35.970292][    T1] >ff1100014215fe00: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
> [   35.970292][    T1]                       ^
> [   35.970292][    T1]  ff1100014215fe80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
> [   35.970292][    T1]  ff1100014215ff00: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
> [   35.970292][    T1] ==================================================================
> [   36.528345][    T1] Disabling lock debugging due to kernel taint
> [   36.540420][    T1] pci 0000:00:1c.5: [8086:a215] type 01 class 0x060400
> [   36.547403][    T1] pci 0000:00:1c.5: PME# supported from D0 D3hot D3cold
> [   36.562298][    T1] pci 0000:00:1f.0: [8086:a245] type 00 class 0x060100
> [   36.571590][    T1] pci 0000:00:1f.2: [8086:a221] type 00 class 0x058000
> [   36.578311][    T1] pci 0000:00:1f.2: reg 0x10: [mem 0x92480000-0x92483fff]
> [   36.587589][    T1] pci 0000:00:1f.4: [8086:a223] type 00 class 0x0c0500
> [   36.594320][    T1] pci 0000:00:1f.4: reg 0x10: [mem 0x200ffff54000-0x200ffff540ff 64bit]
> [   36.602321][    T1] pci 0000:00:1f.4: reg 0x20: [io  0x4000-0x401f]
> [   36.608859][    T1] pci 0000:00:1f.5: [8086:a224] type 00 class 0x0c8000
> [   36.615313][    T1] pci 0000:00:1f.5: reg 0x10: [mem 0x90000000-0x90000fff]
> [   36.623196][    T1] pci 0000:01:00.0: working around ROM BAR overlap defect
> [   36.630295][    T1] pci 0000:01:00.0: [8086:1533] type 00 class 0x020000
> [   36.637335][    T1] pci 0000:01:00.0: reg 0x10: [mem 0x92100000-0x9217ffff]
> [   36.644337][    T1] pci 0000:01:00.0: reg 0x18: [io  0x3000-0x301f]
> [   36.650324][    T1] pci 0000:01:00.0: reg 0x1c: [mem 0x92180000-0x92183fff]
> [   36.657546][    T1] pci 0000:01:00.0: PME# supported from D0 D3hot D3cold
> [   36.665073][    T1] pci 0000:00:1c.0: PCI bridge to [bus 01]
> [   36.670302][    T1] pci 0000:00:1c.0:   bridge window [io  0x3000-0x3fff]
> [   36.677300][    T1] pci 0000:00:1c.0:   bridge window [mem 0x92100000-0x921fffff]
> [   36.685514][    T1] pci 0000:02:00.0: [1a03:1150] type 01 class 0x060400
> [   36.692466][    T1] pci 0000:02:00.0: supports D1 D2
> [   36.697295][    T1] pci 0000:02:00.0: PME# supported from D0 D1 D2 D3hot D3cold
> [   36.704955][    T1] pci 0000:00:1c.5: PCI bridge to [bus 02-03]
> [   36.711300][    T1] pci 0000:00:1c.5:   bridge window [io  0x2000-0x2fff]
> [   36.717300][    T1] pci 0000:00:1c.5:   bridge window [mem 0x91000000-0x920fffff]
> [   36.725359][    T1] pci_bus 0000:03: extended config space not accessible
> [   36.732395][    T1] pci 0000:03:00.0: [1a03:2000] type 00 class 0x030000
> [   36.738318][    T1] pci 0000:03:00.0: reg 0x10: [mem 0x91000000-0x91ffffff]
> [   36.745309][    T1] pci 0000:03:00.0: reg 0x14: [mem 0x92000000-0x9201ffff]
> [   36.752309][    T1] pci 0000:03:00.0: reg 0x18: [io  0x2000-0x207f]
> [   36.759461][    T1] pci 0000:03:00.0: supports D1 D2
> [   36.764294][    T1] pci 0000:03:00.0: PME# supported from D0 D1 D2 D3hot D3cold
> [   36.771558][    T1] pci 0000:02:00.0: PCI bridge to [bus 03]
> [   36.777305][    T1] pci 0000:02:00.0:   bridge window [io  0x2000-0x2fff]
> [   36.784302][    T1] pci 0000:02:00.0:   bridge window [mem 0x91000000-0x920fffff]
> [   36.791322][    T1] pci_bus 0000:00: on NUMA node 0
> [   36.801723][    T1] ACPI: PCI Root Bridge [PC01] (domain 0000 [bus 16-2f])
> [   36.808305][    T1] acpi PNP0A08:01: _OSC: OS supports [ExtendedConfig ASPM ClockPM Segments MSI HPX-Type3]
> [   37.091596][    T1] acpi PNP0A08:01: _OSC: platform does not support [SHPCHotplug AER]
> [   37.105600][    T1] acpi PNP0A08:01: _OSC: OS now controls [PCIeHotplug PME PCIeCapability LTR]
> [   37.115792][    T1] PCI host bridge to bus 0000:16
> [   37.120298][    T1] pci_bus 0000:16: root bus resource [io  0x5000-0x6fff window]
> [   37.128297][    T1] pci_bus 0000:16: root bus resource [mem 0x9b800000-0xa63fffff window]
> [   37.136296][    T1] pci_bus 0000:16: root bus resource [mem 0x201000000000-0x201fffffffff window]
> [   37.145295][    T1] pci_bus 0000:16: root bus resource [bus 16-2f]
> [   37.151345][    T1] pci 0000:16:00.0: [8086:09a2] type 00 class 0x088000
> [   37.158525][    T1] pci 0000:16:00.1: [8086:09a4] type 00 class 0x088000
>
>
> To reproduce:
>
>          git clone https://github.com/intel/lkp-tests.git
>          cd lkp-tests
>          sudo bin/lkp install job.yaml           # job file is attached in this email
>          bin/lkp split-job --compatible job.yaml # generate the yaml file for lkp run
>          sudo bin/lkp run generated-yaml-file
>
>          # if come across any failure that blocks the test,
>          # please remove ~/.lkp and /lkp dir to run from a clean state.
>
>
>

