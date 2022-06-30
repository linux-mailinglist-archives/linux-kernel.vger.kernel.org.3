Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A16A561F77
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jun 2022 17:38:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235846AbiF3PiW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jun 2022 11:38:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235832AbiF3PiT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jun 2022 11:38:19 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94B55186F2;
        Thu, 30 Jun 2022 08:38:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656603498; x=1688139498;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=45IX1NmAR/l93yNshwOh9zbtNH1ZggqGsElGbDbm90E=;
  b=FlJjWVpuSOONOj1T906juOmL9glXzDjODmqpTtPssXG+/+gs34N8l48O
   wIXtlBXu6OfF6dEnR8qUTeNXnUqEnDQYbRYo9Z/zeacQWflrGQaMC68VK
   BG/Y/8BiLoI7mxXyzdjHpx3PUfuZ/v/Z/lKTuNiY/76J2n0uq+B3c2bcG
   SEb8IhfXCA0sBIaMNOdYX8iKcYwT4Lawd09eENGjbw1nHb+IwJvCswBRA
   KdaK1HEx/JlR7p9t1eedn1EzFRZ31hcoGbuwPJtUXTZLnffE1NLgIjdvO
   EbcYEyRS2ypbYhgGHeIIAyXRCI0d/p4OJRtItfQ35UkYYNny4A3fzXfRD
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10393"; a="262784341"
X-IronPort-AV: E=Sophos;i="5.92,234,1650956400"; 
   d="scan'208";a="262784341"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2022 08:38:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,234,1650956400"; 
   d="scan'208";a="681016909"
Received: from fmsmsx606.amr.corp.intel.com ([10.18.126.86])
  by FMSMGA003.fm.intel.com with ESMTP; 30 Jun 2022 08:38:18 -0700
Received: from fmsmsx609.amr.corp.intel.com (10.18.126.89) by
 fmsmsx606.amr.corp.intel.com (10.18.126.86) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Thu, 30 Jun 2022 08:38:17 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx609.amr.corp.intel.com (10.18.126.89) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Thu, 30 Jun 2022 08:38:17 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Thu, 30 Jun 2022 08:38:17 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.44) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Thu, 30 Jun 2022 08:38:17 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FD4r87rnfTB0Zb9h+xT+7E46XOOuGXejggTlUESvtiRU176yuxqv/uZ4LWtkBWCA+ucDNXb6zYUYGUXXWiIrLdw9YYOmbsGeNTR8vKmAq1/C78uJXY25G8x/Vs2XStpTdedxeeF21LETLpHlsjxZI+7hoERhEPAlCzm3ez3eqhX6k6q9BPD58TGmJONynNyTWJyhG4ImPAyxTL2XXaq4u8PtLGBNIAG0ErZdEGNv9dk4MC9s5L2cexNtQ2U9QjO8fO/K3mUKN3yvJmpkzQhyZuPP2mvFS6bYdEoW9R4zkrhDsKSwBKVjolCnO8lkL6NRravblEVvnpw/Cavw1C02mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+iR/l82qpiL2M133GrovALVU13FeGihj3hbFfGZVn/0=;
 b=WCXRrQza3KNTYNYW1YYg39brmz7OlXV0ZdHoemFqlizN2AKt3zgCxr8pFeWbf8mwUzdxgD757ml196abEn86iVMdKaJP0FMdnipLzwbWpa+Em90HK0wNpOLTQvIhC6J9e0veNy1t6oclYg89K2/c9CQWaW95dyw3aC8MCHLGXST7yq3NpTBW9dl3H0X6DM3cPPj20tLrYkxXO1VYkQlrY1MWid0fatgIU7hHXXyo1V2kt9cfozGyrA+eIWAiSRMkkpEWDkQ7oFTzIvRbRrHopn1AqJT0eWe7wuYrC44l8BU/c8j4GJvG0VEzl5xuZ0w4Or49AT8fum9N8sCARsILGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB4855.namprd11.prod.outlook.com (2603:10b6:510:41::12)
 by MN2PR11MB4493.namprd11.prod.outlook.com (2603:10b6:208:190::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.14; Thu, 30 Jun
 2022 15:38:15 +0000
Received: from PH0PR11MB4855.namprd11.prod.outlook.com
 ([fe80::95a9:2d1d:b36e:4319]) by PH0PR11MB4855.namprd11.prod.outlook.com
 ([fe80::95a9:2d1d:b36e:4319%5]) with mapi id 15.20.5395.015; Thu, 30 Jun 2022
 15:38:15 +0000
Message-ID: <1a489a64-a56b-525e-4a77-583c2eeb4935@intel.com>
Date:   Thu, 30 Jun 2022 08:38:13 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v2 1/1] Documentation/x86: Add the AMX enabling example
Content-Language: en-CA
To:     Bagas Sanjaya <bagasdotme@gmail.com>, <dave.hansen@intel.com>,
        <len.brown@intel.com>, <tony.luck@intel.com>,
        <rafael.j.wysocki@intel.com>, <reinette.chatre@intel.com>,
        <dan.j.williams@intel.com>
CC:     <corbet@lwn.net>, <linux-doc@vger.kernel.org>,
        <linux-man@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20220629224235.20589-1-chang.seok.bae@intel.com>
 <20220629224235.20589-2-chang.seok.bae@intel.com>
 <8607c3ab-ef68-a782-e53d-86f5cde70559@gmail.com>
From:   "Chang S. Bae" <chang.seok.bae@intel.com>
In-Reply-To: <8607c3ab-ef68-a782-e53d-86f5cde70559@gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PH0P220CA0016.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:510:d3::19) To PH0PR11MB4855.namprd11.prod.outlook.com
 (2603:10b6:510:41::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 19012efe-9d33-4e90-e30a-08da5aae8c7d
X-MS-TrafficTypeDiagnostic: MN2PR11MB4493:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EOd8FzmYFu9wn5mTZWhSgNTUiom68an41fSzv7Gj9xX42CvmaR5AO7Bosy9eJ6V63JclCXaBa2Kg/b9zsAzLUDDBl/cPjZ1hYRj4cFGKyXZ9LZePU6blYc6voJNBNcgIDZycLXy3F8moNYgpYqb0kHDZPsBJe/cii5nDLed/eXJ38Ku1LckuHyOXcY3vOiQd6lNSUWS+Bz0MbKMaF9cPM+VlIzd6xpQaRbrxjHoXdI8NYT+9BpzZlVY7nyALdz01cVhmK2aSK6MASuyEEsAzWeRhe0+Vx4+GWkRqN/V7aflZ3GyF6Z7LK0glE4a1+p1ozXEDPvSMGG27hscz7+HrJPWQm9YW/68jHKWFdLwaZ+teyda1TMONQiwzq/8K4w5ecqy6/WDrv+hto0Da0ypF8MjSH4BbtLePKH3li2fpDFI7Duy0g5nAbWJxEN2Lm5PgmBMVIMzDWePDjnF1t/fw65jEzq7LKvYITU3yN/BaWJJ3CJzEiQ+5DcmA82566nkNl25Mq4RMkIAMaYV3wsyXI2QX02A3AF5kFrOAvvwVb2cJ0JOj/OaOyD8jxZ9bDgdhjMHO9IU9Z0ozB+fv/dLSB0Za2lk1Iu0ikKbybPkVvRVm0cv0/flKRkC0U+82bcO0SXjY6EokDH9asq5pmVO4e1Sn27Uaj8radXGpTErWPltkggl8U3oOeA2oZO9m6//MYasd3lwct9RjCLw2tgoanoszZf+kwjcy38PfTFE0KsrghBVzwBEm9v75oj5kJGKoU1cmTrBRYdeLSCUJ1mi2H8eWRR4QBWjJ8cKN2Xh4EzarO8HOD1i2OrojGz5t8rwiBAL0OwtdU3rBuB3LGhCaORw2Me9PND8oxR5MhvRiZ6M=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB4855.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(376002)(39860400002)(346002)(136003)(366004)(396003)(186003)(4326008)(6636002)(53546011)(66556008)(66476007)(6512007)(26005)(2616005)(8676002)(6506007)(66946007)(2906002)(31686004)(36756003)(38100700002)(558084003)(82960400001)(31696002)(86362001)(316002)(41300700001)(8936002)(5660300002)(6486002)(478600001)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?L0FLR0lxUTlXNStORXBNZlhYVjJSTDhNL1dTV0ExamdWdUMvQUsybjh1ZGVs?=
 =?utf-8?B?OEFEWkdnSUpmdXVxdVE5UG8vWUFBMlpsdlJyanJGOVZjbzAvRXBIR3JzMVgx?=
 =?utf-8?B?NDl0Si8rSWEwMFhyZzFsLzlVQzdKVTdIUzRlNXRDcVZLbDV1S1J2eDlWa2hq?=
 =?utf-8?B?WE9RNVlQYSsvUWF0ZU4wQnJmc2Z6R3o0WU02QVU2RVhOc3NHd0hGbE9SS1Nz?=
 =?utf-8?B?UXZKbXYxa2VhNWN1YmhNWlBsUGFjU1JaWDcxclJEWU5yMGo1d3RoeGc5ZkdJ?=
 =?utf-8?B?N1BWREYwZGp6MTMrSUcwczhwNVNBNkdtWk9qT0t5b3o3amxlWmNXUml1TS85?=
 =?utf-8?B?SWVVRGZ0NHVjU1V6WkJPV1A0MWdJTmhid0hHb0VqOFdiWGlxT3BnQ0hWVndp?=
 =?utf-8?B?WUtFVXpjTE9JTE8xcVFwelNmVFBmMXpzSUtFVWl4cVdZVnlKZjlSQ3dQdjhX?=
 =?utf-8?B?Zks5d2RLYjhmczJzdUtIaDVKNnBDZUJRNzZkQ05PQTlOSHcvcEthNEZwUm8z?=
 =?utf-8?B?NEJSY2tDZDRxaStLczRHQnlZTnVFY2ZZVlRWZng2RTRuc3hpR3J0S29pakp3?=
 =?utf-8?B?MFRmMlV6UHVLbkhETUVPdmYvbE40TmFSVnYvOFNLUXNpeFVmUFlmQWhOZ01G?=
 =?utf-8?B?R0ZYdjJmNktBRlVyZUxsc3M1YTR5bFpHeUM1M1lzL3dZc1hvMTBXM0VEOE13?=
 =?utf-8?B?MjJNVTQyWGplampkbllxaGkrOXNMRlpTcVh3endqRXV5U210cW1GNEduOVZs?=
 =?utf-8?B?SjF1VTFGUGdVYXpaTzNpNzJhWWZmSlJ2UmllTy94cm9iZWJKUTBLNVI0VUxS?=
 =?utf-8?B?NVA3eWFvRitZd2cwNjVSWmlMMElKZk9hU080elppWVYrSWZJM0lsZm9IZ1lo?=
 =?utf-8?B?enBUQ0hsV1FTOEJ4RGwxUWswMTdqRDF4TnFCejF6R2NpTGVOcGxObWRjbi9m?=
 =?utf-8?B?VDZHMGttc2poWU90Vjl4NFNUOENsUE55QzZHaG40WmpyRXpMRHdsTmcveGMy?=
 =?utf-8?B?WDcwOGtOY1NyaTl4OTRzOUNIQ2xSNm5TTDMzTHNoOVlKenlPV0czaVRwQ3Fw?=
 =?utf-8?B?bmh4MkFRTGZYZVV0c2g0MGVCcXdHQk9KVWV0dFY1a1VjUktmdG1WV01ZcmdN?=
 =?utf-8?B?SktzRGFuN3hONmRYdk9iWjVkTHd1SUlidmRlQTkwdTVCS20zdFg1TTRYakwz?=
 =?utf-8?B?VzhBYnRGa3picTVhRW9HYldtR2RxYW1MK0I5a2IvMSsybFdtbldITFpibHJU?=
 =?utf-8?B?dHZKZnhBYVNiZXc3aG9RSkpYMlJiNVVvSzNqRU8xNFNFZjh1NndOVWtPUUtW?=
 =?utf-8?B?cTJjd2tvN1ZZV29JTFpMTTlSRjB4cTRjZ2dPYjkzNDZkbnA3WHUvMjd2NUEw?=
 =?utf-8?B?NXVNVHFPKzdvQkQ4UFYwZFZjWkNBRmZBa3NWT0dIR0pXakhUTEFwNzV0WkQ1?=
 =?utf-8?B?cjFUbk56ZXB6b3lCeW4wNExOcUtpMGF0YzNjbEh1cXJIOUF0cFIrSG5kTUMx?=
 =?utf-8?B?QitlTXBVMlRiQ1hGcHp2a3kvVGdHcDhqK25GMkJuOWJ5aHJxMTIrS3BmZ1gz?=
 =?utf-8?B?RnVWb1NDbHRQU3lUbDM3SllnM0FXbGxUTGlPYzkxTFY4Z05QWHkxZWJUM2dj?=
 =?utf-8?B?R05MZ294K2E0WUh6WVZ4WXFuMkgvemVsRzhwWGxSMjhZOXFtQUJlT1IxTzg0?=
 =?utf-8?B?Ym1tVlpQaFZ0VkxaYnI1Zm0wdHI4V2RBdXpjcDJ3aWxJYzBCa2pNaDVkN3NT?=
 =?utf-8?B?akRUM1UzWENXMlJwRTZxQk9peTc5QnlDR3JZY0NlczhaaXBSc3c2R3pyWitU?=
 =?utf-8?B?cmZPZXNhQ1FORFo0Zi9XZTRKNjVaYWpxeWtWQUoxUVBOc1h5TW91UTRSWWhH?=
 =?utf-8?B?ZzNpZkxSMU1WNEwxRE8yK3paL2pzcndtTHpLNElFdkJHWTBxRGhiVFVGY1BE?=
 =?utf-8?B?STUyVDhzaDFYNXZZSEk1YmtNSkdHd016SDMrUWxLLy8vc29uNWkrZ0l1NWZO?=
 =?utf-8?B?ejBvYjlmZWw3OEVGS3plc0FuSVpVRzB0Y3VKVHVlem1pWDR3ZndMY3JrRGdy?=
 =?utf-8?B?WUtCNCtndHNyd2dQTTJZVER6allrbmFwMkRxTDRiKytiVFpDQ0hCeDNEdys1?=
 =?utf-8?B?K3dLUVdpVWxwdVZQUDFidVdDL0V4ZXFDMHJRWEFyV3ZOUElVbzNxb2lvSHZm?=
 =?utf-8?B?dkE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 19012efe-9d33-4e90-e30a-08da5aae8c7d
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB4855.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2022 15:38:15.5778
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QT52KqNlJMzYK8phIeCNsOWxFfJUg0RmECbBHE+UkFPWXb4eipFbqyh6REna0J2zB5+MLL7gLuDWcGIRolmoNRLiNYRQqx9UoZ4EAdLPi58=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4493
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

On 6/29/2022 8:03 PM, Bagas Sanjaya wrote:

<snip>
> 
> I guess "application" here means userspace application, right?

Yes.

Thanks for the review! Will pick your sentences.

Chang
