Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 519914CC469
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Mar 2022 18:54:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233213AbiCCRzK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Mar 2022 12:55:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229496AbiCCRzI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Mar 2022 12:55:08 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31B5C149B88;
        Thu,  3 Mar 2022 09:54:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646330062; x=1677866062;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=PSUYa8WUxwLJWexK7gpm59vgTgLXt1xuSrv7ZCF/atE=;
  b=A4B7LfZHHCJOQks1R0b+zZimd+S9ExmG9k+QIUnDSjl1qw7+Bnd7xWUt
   xxN3Ud99/3TB5Na33K4g5tyiq6oTzwsinBpByXApAs9UevJAqlpdXiV2E
   pPzUg+vS0S16RBVN6QbPEUwU4lYVB8NVgzy4/KzxYFxGLBjv2H6xWO6np
   ezu2njM3VQJNKVaa+JAf0PfTxpPExYyGWy3MJWOFMa6msAzw+DA0Dmkh/
   S9U+uc7d7CotohP03d6Me4G71tfl7qIDL0KTGvFOQjc7P9LC/ZyRnenAJ
   8UpjeAqXrbgleSSpfVorFJpcjMqXUOtURnu7EQQRjV1ZjSZmGDnsFg49u
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10275"; a="340183925"
X-IronPort-AV: E=Sophos;i="5.90,151,1643702400"; 
   d="scan'208";a="340183925"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2022 09:49:28 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,151,1643702400"; 
   d="scan'208";a="594480249"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga008.fm.intel.com with ESMTP; 03 Mar 2022 09:49:27 -0800
Received: from orsmsx604.amr.corp.intel.com (10.22.229.17) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Thu, 3 Mar 2022 09:49:27 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx604.amr.corp.intel.com (10.22.229.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21 via Frontend Transport; Thu, 3 Mar 2022 09:49:27 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.177)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.21; Thu, 3 Mar 2022 09:49:27 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nVmu0k7VDZzu0Xain1NvDmNLGFJtjyhGjUHMji8fW0kIhnotY+3JC93QNntXfgAqf1yhsbRxf9lXOzpU5iMM63bq+REE7EqQgxuh06k/3Y4rk1Ss9PBDIsG3uV3k8cr3/NLwqIk0/Cpb9NDKY44Ixv6dyvqXRhdTpK09GBDISkVDpHxLcxvx9fgRi8XYodBBR41tvKukAA/CC69aY6UC6FYxRUthVc89HGJQrPLd0tI22p73sLF9VNlFyxZIEruKx3MpAJoj/B9YzDMp3Y3f5CCcZ132KvvK272TQPIxxdHKfEbvQrVSytTm+FI1c5aJzKp6CUHkSxXohe/Azkxe2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YpRljGnyAYFRDGLuH7rCO/Ku5xOLEMxCj3VoSh7uq0c=;
 b=CPbnPGhhxXSJk+8W7BajKjKA2Zv8kQM7QWDdMU+DSfuhuuN2JhL40Rl/fPwuYL3sz+/sJhXe1whBWNZc9UL48mnnajWT+13OOjsT747FKDgfXCP2mcaOJGx4REVj1R91KJf2xahkDLrDkoi0iOZRgxvC3VhsskNa9+reHIbl1oHjP51IIIoV42cPYDDzNHRVRp18cUISjyCnN365oPw/dTtEWMSuINM7qkMQ+FL5xPFzJhjUsRgIEa0za8HWZDlgkjnrGJEBRfdI+LO1czq0pVG3CTcHRybxaGXL1dn2coeaqWZEsYbaalEJuNWTSZxtCWTNnOY9AtCWoJjN1ofq1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BN0PR11MB5744.namprd11.prod.outlook.com (2603:10b6:408:166::16)
 by BN8PR11MB3636.namprd11.prod.outlook.com (2603:10b6:408:8c::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14; Thu, 3 Mar
 2022 17:49:23 +0000
Received: from BN0PR11MB5744.namprd11.prod.outlook.com
 ([fe80::55e4:9a32:8e6f:4774]) by BN0PR11MB5744.namprd11.prod.outlook.com
 ([fe80::55e4:9a32:8e6f:4774%5]) with mapi id 15.20.5038.015; Thu, 3 Mar 2022
 17:49:23 +0000
Message-ID: <e1c8e8e9-4e56-6df7-c7b0-749a62d1dff2@intel.com>
Date:   Thu, 3 Mar 2022 09:49:18 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.6.1
Subject: Re: [PATCH V2 00/32] x86/sgx and selftests/sgx: Support SGX2
Content-Language: en-US
To:     Nathaniel McCallum <nathaniel@profian.com>
CC:     <dave.hansen@linux.intel.com>, Jarkko Sakkinen <jarkko@kernel.org>,
        <tglx@linutronix.de>, <bp@alien8.de>,
        Andy Lutomirski <luto@kernel.org>, <mingo@redhat.com>,
        <linux-sgx@vger.kernel.org>, <x86@kernel.org>, <seanjc@google.com>,
        <kai.huang@intel.com>, <cathy.zhang@intel.com>,
        <cedric.xing@intel.com>, <haitao.huang@intel.com>,
        <mark.shanahan@intel.com>, <hpa@zytor.com>,
        <linux-kernel@vger.kernel.org>
References: <cover.1644274683.git.reinette.chatre@intel.com>
 <CAHAy0tR-64vxtFo4KXiJP_va2=WF++Q6gDaPksNxiaSB5wWvhA@mail.gmail.com>
 <86495779-a9c5-45d5-0017-c491bf6354ab@intel.com>
 <CAHAy0tQYBD2b0jdim=6Zv+hwskyd1FhpycyGF+1FBHDih9TP3g@mail.gmail.com>
 <e746026c-33f3-fd15-5303-563b3eb761d3@intel.com>
 <CAHAy0tRXxDQSuBVoEW9jzpFaWns4DzWqmFASFNGgGb5vjnYuPw@mail.gmail.com>
 <b2733dba-278a-4574-f7ab-f035e97f762e@intel.com>
 <CAHAy0tRoy=qpn-OqKmEHaWSngO+_Ko+YYd3Aq7WGk+1=n8=2mA@mail.gmail.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <CAHAy0tRoy=qpn-OqKmEHaWSngO+_Ko+YYd3Aq7WGk+1=n8=2mA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0124.namprd04.prod.outlook.com
 (2603:10b6:303:84::9) To BN0PR11MB5744.namprd11.prod.outlook.com
 (2603:10b6:408:166::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6259142e-17b8-4df8-8d8c-08d9fd3e268a
X-MS-TrafficTypeDiagnostic: BN8PR11MB3636:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-Microsoft-Antispam-PRVS: <BN8PR11MB3636FB1198D995E3A00F027DF8049@BN8PR11MB3636.namprd11.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Wl+9vMcwHuYjdpwaZLAhLBroShBDCHfU9A9nDjUZiZYHkkn3XnsdYzpoj1R2M8Zdiujz60dIs+n5h+WLAraBwTN8o0hhYfe2uVoRFlApA60h0Gox0qfrbBcYooL19XUwFMoBWriZQVqVFUgaKiqxvMR7D0KpAujWngt7+iOqsYhlXdcCNXZnfDKBGgE375eDJJo2jCh6Qm5qPnUEU0ht1nZbcaXQKc8wuyBOGL+1KxhH0P1ehD77hPGUbzVFKbqgBGL3fDplCCb5VJJMR83a+LAzsJ17Dv/Vm+cpSBpf4LES/cZJBon7ueKGfVfvh2cSGB5nIxRPrQLdi96tejV+0GJjmuTFgh0W4uhHukNeBGMiM0aEQ2SAnhFqH99W79jEsiKijCmowUXmJ1jfLwRmVPIXZiviQBS6wf3mzYHr+liMbJy+MI+JfHnVeEJhB0khsexQHFqK9UlGyve4KS7x163vcdUCpMubaqXVipMvCwtJpCM20vZMydFZuMs+dammU8YeheDekxhftysUFOdyThbhfdUatO5bK8NILw2NeQe3MPPs+LV9rU5VcggqdKe9EZknkbBs8wvSjOQzHYnz9TNhMiG1j6AJPndambHJlQ8oshYhXzqcSz+9uwTqnoyIck/Z3dlAFQQdLR1+0UOFQXs4HeVqtzHGxiZGmQUGiRIUsZIgg9Gycue4+/w42BJawo6qRmuIWRcoq78+g8SPP05pERh4ImvdHFOPLjC0AE2WMrKOnL8EWQFgGJBuAFcjpHSa+loZkkshcji0glWcFo3CxldYquARdO7QMoEvoawmGFSFidX20eWXVHmrR7iP
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR11MB5744.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(508600001)(8936002)(6486002)(83380400001)(5660300002)(2906002)(82960400001)(7416002)(2616005)(966005)(6512007)(316002)(6506007)(53546011)(31696002)(38100700002)(6916009)(186003)(6666004)(26005)(54906003)(86362001)(4326008)(31686004)(8676002)(66946007)(44832011)(66556008)(36756003)(66476007)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZmZFL0psQzZvNEZUWkJEMVNORWlxckZUQXNkY1Y4bnk2eUt6OW96aGNpOUoy?=
 =?utf-8?B?TFU3TmZ2SENkemVJaEZsc2l3WU1NVTVibmViRW1UczcyTDk2QmpReDN3WFFq?=
 =?utf-8?B?bXRqTlhpVFEzWlViMnFUUUwzZGRGU1dFcjNGa3liTDIwdUpkcWc5SEkvZXVK?=
 =?utf-8?B?ZXMvY2hHVzh5SFIzcGR0cGVpSlpIMnV2SmNhOHFQa1NSRkxSQVdiUjd6OXNL?=
 =?utf-8?B?WmJMU2VVSFZReTNlaFJVUEdWR0FUbldCRUk0aVVlV1RsZjJMQVBkM1c3M25p?=
 =?utf-8?B?cE12cXpjWkNpekYxUjZDNGdWMzh1ZnB4aDFZaVQ2aUNtSllUWEI5a25adjlX?=
 =?utf-8?B?WDM3eWg5Tlg3V3RUZk5KdlVHdTdSZ1MxL2p5NWl4eXUxcGJMdndsQ1JzdVlL?=
 =?utf-8?B?MitSNlQ1TVd6MU5QekJyOThFZ3hiNkhxS0M1Z2VBWXl0V3hBYlg2ZjQ3RGFj?=
 =?utf-8?B?TmRvM2IyOVdkZkxRcnBxaGw1eEZnd0N0MnNkckYxMzVyMGZPL3VzR1Mxa005?=
 =?utf-8?B?UXRYL3pxb1EwOGpBUzRyWm5zY21TKzJ6emluN2pUVGcwdkV4YjlhR1RIbkZ4?=
 =?utf-8?B?VzdORGpidTFFSXhkQnUrY3RuL3ltWFRjTUZTaGQ2Sk9MZ1lzUDhmY2VJRFdB?=
 =?utf-8?B?YmRJOWo5RjBPRllTWHZpMFBtUWU0b2RKdEllbi9yd0gvaVA2Y1oxZ3UyYVEz?=
 =?utf-8?B?VEE0UmhqMTNoNXpwV3g3MG1abEVaN09Zc1hrYkNmOFQ4VDc2TE9BK3A0cTM2?=
 =?utf-8?B?R0pCcy9MY3dBNTNqM3JWUmk5RFZWcVp0Q0hOYW5IckRIdGhTTllqeldIM1lw?=
 =?utf-8?B?QlR5czVrTTgwRlZZemVTRjFHUmZsUUI5ZG45OUFyYXAwWU5qOWFpYW1wM084?=
 =?utf-8?B?Z2xMRlAyNDJEYmtINFZLRkFNRlBYRktpRld2ZzlVaVlsc1hOWm1aaXRtdWta?=
 =?utf-8?B?aHhsclRaWDd0b3dSQkxITTlUNFlZRmZSanJFek41OUUvTVEzRXhUU1hMYm9h?=
 =?utf-8?B?QWpWVHdWUk1VN2Y2dmtKSFFOYVBvWUdMM21MSm5pU0hRbnJCNXZnRzRaMnB3?=
 =?utf-8?B?R0dON0h3bVNEcmVzM0NuWVlFa0FqK2FQbFJIeVA4Y0VJUDF2UE1VUXVzNnUx?=
 =?utf-8?B?L2FrdzlKTlR2SFo2QjZMTGp5a2c0eXNrL3pWR3F5c1ZnNlFBU21ZVkNGVUNS?=
 =?utf-8?B?WlFoZVZWdG1yZWtHaEVGQ0VYWFZlZ0tFdE95eFFzcHRpZEpSdGMvYXpOV2kr?=
 =?utf-8?B?eE9pK1RMUW5IYnhCU3djdEhTOFE0S0N1TGdJUk90UjNiMXM3RkVNc3lLeFRr?=
 =?utf-8?B?Y1liNHk4anV0STRTSHBLSWh1Wko0bGFIcnlmcnhycHZHZzNZamoxZ3gvMlVh?=
 =?utf-8?B?YitHZkVldHBRYTdodStrNnVIRThySk5zd3dvSE9DVitnMHA4eXZZcGwxTGhD?=
 =?utf-8?B?SkhQVXhTQm5mbTB5Zk42UEVNTkkwbStPTDVnNnJKTFpWbll6bjZhcHVsR2JN?=
 =?utf-8?B?MjVFUzYvNVpvTE5vLys0RUJXMmlkeXM0SndUcUpOcnhwR0JyaXBFMEFSRlRh?=
 =?utf-8?B?MW9VaTNoWFpSMWJwMzkraWFLNG81YmpzbE5FTGw0c0tGS2twUnM1S3VsZGli?=
 =?utf-8?B?eWtZUG1tSkwwMjFERE5ocnNFcG5LY1o0dHZ4ejlON2phUjk1RGw0Z0xvNXoz?=
 =?utf-8?B?cW4wQ21VdVJvRDZuLzZqTlNNbkdDdEhEdWlIbHhvQUhYd0hnenRlNzZTOWtr?=
 =?utf-8?B?ZVdXMVczck56OE0zdGR0M1o3bEhPSlpRQ011MGk4QVh3c3huREF6RjR6V0tw?=
 =?utf-8?B?ZW43QWExU0dxazZsZDZCaE9ETDVOZEFHbVB4NjJuSVVQd0JXL08wTjJWdEFn?=
 =?utf-8?B?QjBlcGdGZm51OVpQZlJVMnlEbGRYck1MVzE1WmVRT1VXTDVpTmp3MTIzMlFj?=
 =?utf-8?B?TFFocjhQS3RQcE5nR3JKamxETUZlY3lUdGZET0NxL0FoVTRZMTNDNU8yb25m?=
 =?utf-8?B?bDlLT2RKQzZZRlRZR2hsZ0V3QUZEei9pT0xEYWFpVE11QVlBTlNhcjVTanZ4?=
 =?utf-8?B?czJLZ256TmtsdU56RVV2YjhkVk9NbDl5M3FlODNEQWhnYUk5dlE0R29sbEVq?=
 =?utf-8?B?MTJwY0tTZXdQeDZtQVVMbWZoeXcxa1ZVRWF6YXVWME95Skw5WnpqNlFFQU5N?=
 =?utf-8?B?VVk4YVJqRnFzSDBaM3NIa2YvUmprSUFRbUFpUlFWK0E1dGxCcHU0NFc5WUdV?=
 =?utf-8?B?NUt2Yjl0SHFndmRBdEU1ZlU3b0dBPT0=?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6259142e-17b8-4df8-8d8c-08d9fd3e268a
X-MS-Exchange-CrossTenant-AuthSource: BN0PR11MB5744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2022 17:49:23.1830
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SYyXdPv60AQbSMM3XNwLctk5pHT3Xrvc9U44xGIwneJ1sBXWh4Y7Ck5F3AaIhcgZwueaVROUU2X73MoXvF97Bz9gCTU3ZeesuDywhjHSQiM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR11MB3636
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

Hi Nathaniel,

On 3/2/2022 5:13 PM, Nathaniel McCallum wrote:
> On Wed, Mar 2, 2022 at 4:20 PM Reinette Chatre
> <reinette.chatre@intel.com> wrote:
>>
>> Hi Nathaniel,
>>
>> On 3/2/2022 8:57 AM, Nathaniel McCallum wrote:
>>> Perhaps it would be better for us to have a shared understanding on
>>> how the patches as posted are supposed to work in the most common
>>> cases? I'm thinking here of projects such as Enarx, Gramine and
>>> Occulum, which all have a similar process. Namely they execute an
>>> executable (called exec in the below chart) which has things like
>>> syscalls handled by a shim. These two components (shim and exec) are
>>> supported by a non-enclave userspace runtime. Given this common
>>> architectural pattern, this is how I understand adding pages via an
>>> exec call to mmap() to work.
>>>
>>> https://mermaid.live/edit#pako:eNp1k81qwzAQhF9F6NRCAu1Vh0BIRemhoeSHBuIettYmFpElVZZLQ8i7144sJ8aOT2bmY3d2vT7R1AikjBb4U6JO8UXC3kGeaFI9FpyXqbSgPTmg06j6uiu1lzn2jSKTA2XwD9NEB31uPBLzi-6iMpLnYB8Wn4-kOBYpKBW52iXj8WQSmzEy5Zvt01ewG5HUQN2UEc7nK77YPjdALd64GWih8NpkALGwR_JtzOGAaKXexyTKGEt2pgoMaXahgj5Qgk9nM_6xGvDDJpsmOyiVv0LB62B8un4dBDrLiLPeWciCL9fvvKVQizhSG6stFz9Df7sxUpcYitR-SodFO2A_Vw-7l4nzzduqjX9bKJxOHDDeBB3RHF0OUlS3faq1hPoMqzulrHoVGPZOE32u0NIK8MiF9MZRtgNV4IhC6c3yqFPKvCsxQs3_0VDnfzf-CPg
>>>
>>> This only covers adding RW pages. I haven't even tackled permission
>>> changes yet. Is that understanding correct? If not, please provide an
>>> alternative sequence diagram to explain how you expect this to be
>>> used.
>>
>> Please find my attempt linked below:
>>
>> https://mermaid.live/edit#pako:eNqFUsFqAjEQ_ZWQUwsK7XUPgthQeqiUVang9jAkoxu6m2yzWVsR_72J2WTbKnSOb97MvPeSI-VaIM1oix8dKo4PEnYG6kIRVw0YK7lsQFlSghGfYPCy845GYXWJm05ZWV8ZaEt55QB-IS9UwOfaItF7NGc0I3UNzU3-ekvaQ8uhqiLPd8l4PJnEYxmZsvXm7i20e5B4QlA5rAqMgJJfG9Ixg21X2ctVXn9GGJsvWb65729FSZXWDdlqpxx46Qzu-gB8-cHzhhim2zKdzdjLcuAAt3IPzv6Qkq84EdxGM3492UJS-cdSpLHp6nEgCPz3RjI5NPvAlRisJjspOsbWT8sUyc_MwjuynC1Wzyw9EB3RGk0NUrgvePRYQW2J7tNQd5sKDN5ooU6O2jXCiWZCWm1otoWqxRGFzurFQXGaWdNhJPXfuGedvgFejOuH
>>
>> The changes include:
>> * Move mmap() to occur before attempting EACCEPT on the addresses. This is
>>   required for EACCEPT (as well as any subsequent access from within the enclave)
>>   to be able to access the pages.
>> * Remove AEX[1] to the runtime within the loop. After EAUG returns execution
>>   will return to the instruction pointer that triggered the #PF, EACCEPT,
>>   this will cause the EACCEPT to be run again, this time succeeding.
>>
>> This is based on the implementation within this series. When supporting
>> the new ioctl() requested by Jarkko there will be an additional ioctl()
>> required before the loop.
> 
> https://mermaid.live/edit/#pako:eNp1U9FqgzAU_ZWQpw1a2F6FFaQLYw8ro7asUPeQmWsNNYlL4rZS-u-LRmut1ie953jvOecmR5woBjjABr5LkAk8c7rTVMQSuYeWVslSfIH23wXVlie8oNKijGr2SzUMkT1oCfmwrktpuRj5wWRcDKvwB0ksfX2hLCD1A7quBkgIWtwtP-6ROZiE5nnLq1A0nc5m7bAAhWSzffj0cFNEFaEaGiBCFiuy3D42hKp4gWZUshy6ISOUL6X2e4CCy10rQhUW8dR52QESivGUJ9RyJQ2SAAyYZ_V6ndUSsnldneVca_bJdvY7lkf6vc4haTBlbsdbDmLoaLlSBUqVy5wmWW2nw3rq26Pg-oTzOXlf9Xkt7BfTeqjjSWlP2JWTlkrC9cutlmcLlUlxoRBkE3T9Mrq7KArd0UBPqFDGTpstI2OphSv-jf1cBukPJlmSaP1GXFs8wQK0oJy523Ws-DG2GTiJOHCvDLx3HMuTo5YFc1MJ41ZpHKQ0NzDB1fWLDjLBgdUltKTmhjas0z-kWy8L
> 
> My comments below correspond to the arrow numbers in the diagram.
> 
> 2. When the runtime receives the AEX, it doesn't have enough knowledge
> to know whether or not to ask the kernel for an mmap(). So it has to
> reenter the shim.
> 
> 3. The shim has to handle the syscall instruction routing it to the
> enclave's memory management subsystem.
> 
> 4. The shim has to do bookkeeping and decide if additional pages are
> even needed. If pages are already allocated, for example, it can skip
> directly to step 13. However, if modifications are needed, it will go
> to steps 5-12.
> 
> 5-12. This is the part that represents new code from the kernel's
> perspective for SGX2. It is also in a performance critical path and
> should be evaluated with greater scrutiny. The number of context
> switches is O(2N + 4) for each new allocated block, where N is the
> number of pages: a context switch occurs at step 5, 6, 7,  8, 9/10 and
> 12. However, this can be reduced to O(4) for each new allocated block
> with a simple modification:
> 
> https://mermaid.live/edit/#pako:eNqNk11rwyAUhv-KeLVBC9ttYIXQydjFymhaVmh24fSkkUbN1Gwrpf99pvlsk8G80nMez3l91SNmmgMOsIXPAhSDR0F3hspYIT9o4bQq5AeYap1T4wQTOVUOpdTwb2pgmNmDUZAN46ZQTsiRDTYVchiFH2CxquIL7QDpLzDnaICkpPnN8u0W2YNlNMsarsyi6XQ2a5oFKCSb7d17la6DqATKpgEiZLEiy-19DZTBXjalimfQNRlBPrTe7wFyoXaNCJ07JBJ_lh0gqblIBKNOaGWRAuDAK-qiVquWkM3zqpVzrblytjt-R2Va5yjR3h_K0nPrLleOaudFERKunzoIVE9Xj26VtZYbsEXmxgUOTP2_witfSTifk9fViMDzZPQuoij0V40eUK6tm9a3hqyjDq74P_zuH6V6aGRJovUL8WXxBEswkgruf8ux5GPsUvDvGQd-yiGhpS04ViePFjn3XQkXThscJDSzMMHld4oOiuHAmQIaqP5xNXX6BeBJIEk

Your optimized proposal is possible in the current implementation as
follows:

https://mermaid.live/edit#pako:eNp1k11vgjAUhv_KSa-2RJPtlmQmxvViFzOLuMxEdlHbgzTSlrVlmzH-9xUBUWFclfc8nI-X0wPhRiCJiMOvEjXHZ8m2lqlEQ3hY6Y0u1QZt_V4w6yWXBdMeMmbFD7PYj-zQasz7ui21l2rgA5dJ1VfxF3mia31uPIL5RntSI1CKFXeLj3twe8dZnrdcFYXxeDJpi0Uwpav1w2cdbkSogKpoBJTOl3SxfmyASryIZkyLHLsiA8jGmN0OsZB62zZhCg8yDbNsEZQRMpWceWm0A40oUNTUVa5zt5SuXpbndm57rp3txu-oOnKd62ySRVfmfjhlz4YOy40pIDXBc8az0zhdbMAJOp3N6NuyY1A3o54Og-7F8TT8HHiCwjg_bnwG55nHG_4fhy5HqVeDLmj8_kpDWjIiCq1iUoT9PlR8QnyGYQNJFI4CU1bZQhJ9DGhZiFCVCumNJVHKcocjUl2AeK85ibwtsYWaO9JQxz-gBQs-

You can think of that EACCEPT instruction similar to a current (SGX1)
enclave memory read or write when the enclave page is not currently in
the EPC, for example, if the enclave memory being accessed is swapped
out and need to be decrypted and loaded back. Instead of ENCLS[ELDU]
incorporated to load the enclave page back into EPC, ENCLS[EAUG] is
incorporated to create a new EPC page.

You can find an example of such a flow involving EACCEPT in the
"augment_via_eaccept" test found in "[PATCH V2 21/32] selftests/sgx: Test
two different SGX2 EAUG flows"


> The interesting thing about this pattern is that this can be done for
> all page modification types except EMODT. For example, here's the same
> process for changing a mapping from RW to RX:
> 
> https://mermaid.live/edit/#pako:eNqNk11rwyAUhv-KeLVBC9ttYIVCvdhFu5F0UGh24fSkkUbN1Gwrpf995jttMphXes7jOa-vesZMc8ABtvBZgGKwEvRgqIwV8oMWTqtCfoCp1zk1TjCRU-VQSg3_pgbGmSMYBdk4bgrlhJzYYFMhx1H4ARarOr7RDpD-AlNFAyQlze_C3T2yJ8tolrVcmUXz-WLRNgvQkuz2D-91ugmiEiibBoiQzZaE-8cGKIODbEoVz6BvMoF8aH08AuRCHVoROndIJP4sB0BSc5EIRp3QyiIFwIHX1FWtTi0hu-dtJ-dWc-1sf_yeyrTOUaK9P5SlVes-V45651URsn5ZvYY9BmqgbMB32jrTDdgic9MSR7b-X-ONs5U-MqGvmkxeRhQt_V2jJ5Rr6-bNtSHrqIMb_g_DhyepXxoJSfS2Jr4snmEJRlLB_Xc5l3yMXQr-QePATzkktHQFx-ri0SLnvivhwmmDg4RmFma4_E_RSTEcOFNACzVfrqEuvytQILY
> 
> My point in this thread has always been that it is an anti-feature to
> presume that there is a need to treat EPC and VLA permissions
> separately. This is a performance sink and it optimizes for a use case
> which doesn't exist. Nobody actually wants there to be a mismatch
> between EPC and VLA permissions.

I assume you mean VMA permissions. It is hard for me to trust the statement
that nobody wants there to be a mismatch since VMA permissions being separate
from EPC permissions is an intentional (as documented) and integral part of the
current SGX ABI. Current SGX implementation explicitly checks for and supports
VMA mappings with permissions different from EPC permissions.

This SGX2 implementation follows and respects the current ABI and changing ABI
cannot be taken lightly.
 
Reinette
