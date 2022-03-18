Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DE4F4DDED4
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Mar 2022 17:25:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239137AbiCRQ0x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Mar 2022 12:26:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239071AbiCRQ0i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Mar 2022 12:26:38 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B89AF37021;
        Fri, 18 Mar 2022 09:23:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647620639; x=1679156639;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=L1zjfClBdcdV1aAHQRlphN4nhbMgJwbbhdDQ9DNtm9U=;
  b=BBM200KfdwILFqgf1DiV/BLPGBnHcOfpyZxyl6K/BGA5uKu5Nt+1RclZ
   m8beJMykpN7Hfa7xCU7MbxP5cEh5NwjIrxIhLRsXvLQQUtzr1JE+YkZqW
   a4ibx1gL7tO7wOWwkqHMouULyEeP5YBoVo6l+jCynOGXk1EpmafA58ptp
   2M2sSLTJzfIagQsxY6BkRUelBjZ9usFw2jcGrnPWGu3BSmc0a9yH1krvl
   4kTIBKJcIZnvWndg7MthDWVvEf0tLQl0sgcKSVzzHn17yiOk3oYKebgnv
   AcA+82lECfj/Ok4ARpDsncyhxttVthsEcfUGv9IbWT2x57uJmdOmhXSks
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10290"; a="239329809"
X-IronPort-AV: E=Sophos;i="5.90,192,1643702400"; 
   d="scan'208";a="239329809"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2022 09:23:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,192,1643702400"; 
   d="scan'208";a="517287915"
Received: from orsmsx606.amr.corp.intel.com ([10.22.229.19])
  by orsmga006.jf.intel.com with ESMTP; 18 Mar 2022 09:23:56 -0700
Received: from orsmsx607.amr.corp.intel.com (10.22.229.20) by
 ORSMSX606.amr.corp.intel.com (10.22.229.19) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Fri, 18 Mar 2022 09:23:56 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx607.amr.corp.intel.com (10.22.229.20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21 via Frontend Transport; Fri, 18 Mar 2022 09:23:56 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.173)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.21; Fri, 18 Mar 2022 09:23:55 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VZi4MDMLpxUf/ZEeH/s+irZiGZwWlL2h72EsbjdiERzLs3cp66jY57k173Kwy+ByAl+CrTq+dHFvAmX9ds/QADI7Jx1QxI5TgKRT8FpAqMxfuQin6437qtqcohWJu06YIpTFPdLie0SxEjjFSguVv2KedAJZjInJl7FITS1+Sa9RuPdulUxIFQ270fWafPfDB9BEw74leG2hdZ0x0IrVtjiH2cer7rd+DNXCY8c7An5X/ZV8L+kPYdJrKlkk0imjy4KV9mF/7PmAHL9JkJJIao72Jgrf5FcwUDJxnTVTKe96+lTnkt88hmu8bDkcJB3P4RZ5hG/5jj1RwazliL5/Sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5FgMTp88ArzLTwDRWAHpSPqhXbWF9GXjbLZE2Xt0yfc=;
 b=ExsOW6D8+ni2Gc/hBDo8Q5bqHOR3Vk8TItGEltmdxGlNAwk4g6CxDKkUolI4jpZ4KhGO/GMS2YwAgGTZx6InjvYdVVUFeDr/UmMKysmvPd1uIDiFEh4uvZnrN/Tvu0P7hXTecv1PpdFKzx9LGrqzngUXShizwurLiDh3Ejw9z5PuQKlpF2bHCycbFE9bEY9zhIvVjNGMDuHKfUm+KaMWwS51QH/tygxP+pa/cja0cWSgTMzUbi64S6Li7QmN0kqsPJS2Vrk9C8aLCvbCz5I0imfLbNEajNLtV7kBdPQYYI0oGybAm7nX/LBFzfP6OSpcsT0/tE7pe4uaYhEpKIYWsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BN0PR11MB5744.namprd11.prod.outlook.com (2603:10b6:408:166::16)
 by MWHPR11MB1997.namprd11.prod.outlook.com (2603:10b6:300:2a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.14; Fri, 18 Mar
 2022 16:23:51 +0000
Received: from BN0PR11MB5744.namprd11.prod.outlook.com
 ([fe80::ec9a:f02a:6fc1:c6c]) by BN0PR11MB5744.namprd11.prod.outlook.com
 ([fe80::ec9a:f02a:6fc1:c6c%6]) with mapi id 15.20.5081.018; Fri, 18 Mar 2022
 16:23:51 +0000
Message-ID: <a68d6089-8d86-8c85-3bf4-6e3bf0791dc1@intel.com>
Date:   Fri, 18 Mar 2022 09:23:45 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.7.0
Subject: Re: [RFC PATCH v2 01/10] x86/sgx: Introduce mechanism to prevent new
 initializations of EPC pages
Content-Language: en-US
To:     "Zhang, Cathy" <cathy.zhang@intel.com>,
        Jarkko Sakkinen <jarkko@kernel.org>
CC:     "linux-sgx@vger.kernel.org" <linux-sgx@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        "Raj, Ashok" <ashok.raj@intel.com>
References: <20220315010300.10199-1-cathy.zhang@intel.com>
 <20220315010300.10199-2-cathy.zhang@intel.com> <YjK1PtnutmiSgE6f@kernel.org>
 <86c945969e674be18abfb6c2a5f16701@intel.com> <YjODhqZZjAkXuScd@iki.fi>
 <f773ff19583b42e79c83dc9570313b03@intel.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <f773ff19583b42e79c83dc9570313b03@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CO2PR04CA0126.namprd04.prod.outlook.com
 (2603:10b6:104:7::28) To BN0PR11MB5744.namprd11.prod.outlook.com
 (2603:10b6:408:166::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a836ed63-752e-41e1-572a-08da08fbafef
X-MS-TrafficTypeDiagnostic: MWHPR11MB1997:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-Microsoft-Antispam-PRVS: <MWHPR11MB19971C58FC94F8FD48A3A4B7F8139@MWHPR11MB1997.namprd11.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9HQMJoedmOFIS1DUA/vqQJEusZoOlFz7lYPb/w0qZFyhzcDsOlh22KQZ36iosT/vZXxTly/q/0sM/Wd1oRSvsPm89TeGcylDJFspvHIWJoDj/ciZy+bW5PO6QkGPhuz+bzn7J8LUl85FegWIcqoaX/AIamypTd+EOns/b3mUFr09dAi1PhnsY+IWGwSvniPOe951TypB49C+ibRYjlTKwzixk2tvDYZtRTMQNGqRJsWrzWEz/dav2g2uC92N7vKB+RV5rsiOtVvG4misKxP4klVSYn9OLpsKw9SbJ8lS9HHzLJQz7dWhIqwW8gGtBLGFMYp6H3Y7JrNyuFSmXhgRJ+/o/jKQugySe42UjhG4g4c6DiL3tI9nAq+A5etKuWB/Atj7uRmZGwjpsol+wNcpqAPf20j/+2wR2uYPu77PSDmhQLXF/XGp/qkhXjTeOVrCE7wFQzNz/eMCaCmWXmvUVT+Nu2ten4TrqIrlxxdhSGhVjB9fWyYxmN60ESFATS1ca78KyVcLtVrz0ThtmUhQ9NMhmc+bYdxQv2i/7r8AnWGUuA9Yt+3ML6rHkaC759yZG7+ilR+YKNMHPOUyARxtoF9ll66ouLWQr/BaP54MELTw97WAmgrHYA+e7rpoCkFm3nbz91IamFDCPHEbU8DudomohWyAMose2smfvttNhsSIpaGwBeWdaV9Pg+1KnQxV5feH53dkk0k2DYD778u3hUnBqL6VNL4nRcnc6O6bvI5++r9Eg3Ragq+IugHuAv3L5DL20gdFh8y44priJAw1qWq6U0ZWEQGvVLcrjhw+GeinVRFRii4LX4DhDLGZ5Rabh2EzO5HIQ/VIAfgdaY1aUevvqxyWJblpgy0cXpGR7Bo=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR11MB5744.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(6506007)(44832011)(508600001)(31696002)(2906002)(6666004)(6486002)(966005)(86362001)(316002)(36756003)(4326008)(8676002)(82960400001)(186003)(107886003)(66476007)(26005)(66946007)(66556008)(2616005)(38100700002)(8936002)(6512007)(5660300002)(53546011)(110136005)(31686004)(83380400001)(54906003)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?c1I4MDkzZDkxK2c3ei9ZMHoxR1VBaUxHM3pueWUrdU56K25OS3llbkt1K0Qw?=
 =?utf-8?B?M1h3elRCckpWczNzMWRMQ2NFRVVhL3RCOEM0ekNGZVRTOXk2c3NjWW56UEFh?=
 =?utf-8?B?MGZuazhFVWJBVjZZYkdyY21IbEdsbkVEd3RoTEMxaXVoWmpsZ1JRcys1UTBL?=
 =?utf-8?B?SE03dHFNcmdtRzhiSGx6a21lNUFhU085VzlGY01GZWhsVXQ4MGsyMGhKRkZX?=
 =?utf-8?B?dWhlTFhxUmZwNkE4MWRxclBXWmtSbWtYbkM1TjhhK2tHS1dCMTNHTTRnMTZm?=
 =?utf-8?B?Y01wY1MyUnpTV3J1bzdLUkhPNkVrU0owOThYbFdXSFBmWWtOY2l3QjM2cDFj?=
 =?utf-8?B?SEdFZVUrdTV5RllDTHVmWTYraWcvaVNNclBSNjI0L3VSM3FjRVQxdVR1UEhI?=
 =?utf-8?B?akpUZU50TVJFWGNJVXhFMDJpV21PTUdKRHl2dk5uTnpYTjNJdUdNdEhQc0ZO?=
 =?utf-8?B?d2dNUWgwK2ZUbVVpM1g3RWFDbTVTUnE1TXQ0a0piUDZFUTFkdFBwWFZOd0Qv?=
 =?utf-8?B?bVAxNE1UZ1dDRGFQbjBsN3lmaDByR1JKOExXU0VRSW1ZaUdXd254ZUpHVXMz?=
 =?utf-8?B?dU5FVkRkRXhZSU00ZWJwOEM0cU1MRDZUREVpb1hJY0lFTWtaaU92OG9veGt6?=
 =?utf-8?B?akdHdE8wQ1YzR1JYd2pkaE9OVktaSWhkOENkQUFQR0xjTHo2V2czREt5MVdt?=
 =?utf-8?B?d1YzOGRIWVVWb2hvU2djbWZXa2hjNUJWTjk4QnV4TE11c1FpUURJMDhRUkRo?=
 =?utf-8?B?cnF4bk83MVVvSmR5cDRSVjUvVXFIbzlGdGErakNGbk1mT3RmVHQyUEdua3d1?=
 =?utf-8?B?VlpzVzlLclNhNU91T25ZUCs1UXVlTDJHTUR6SUh1ZlA0RWNPNG5DY0lmL3NT?=
 =?utf-8?B?OGNqVUxlOEljYmNQdGZZeS9QS0pSVFRoWDgxZGNNZW5pMFd4OFhmTzRrSjU0?=
 =?utf-8?B?c0tKcHcwcGhPQVhLdG1QVHZUQjhVZHU3aUVzdUhOUUJZdUlISGh0QmNpaEND?=
 =?utf-8?B?WGtIbWowaExnUERpNjRZUEpra09lVm9NTUx0L1lnS0pBdWJWUGtra21WQXBJ?=
 =?utf-8?B?azhmelFnbWNWcjRKendkRGZ3U282SXh5c2ZCbm5aOXQzQjFGUUlJODIzWjBH?=
 =?utf-8?B?U1kxbSt1cTU5SzdwZmZZUEtHS3ExVElFSUNSYWEyeldQbU53ajAvYWd1cUNl?=
 =?utf-8?B?dlJlUU1uRVFTSXJSQ3JQSkFJVkZrRXBPem5wOVIrZ3Q2b0xlWnRjNEovekwr?=
 =?utf-8?B?TmIzNDZiYXZmbUdiQXhjV1U1Qld1S1pnNS9JZVozVU5lUUJvbC9wZEY1YUMw?=
 =?utf-8?B?dUxjMWRzS2Y0Z1QzbWtDTlJ5UWhNSTlrZGdWVlN1K3EwUjJtTHRmbnN3NFE1?=
 =?utf-8?B?RWtEWnRCWUVqeGh1bHY1SlFvRzA0aVNTL2d5QWVuSGVacXhtUTdRcVRwMzdF?=
 =?utf-8?B?V1Vrd3Y2Q0F1VmE1aldkR004eDEyVDNUWFVpUTNDak5CWjBzUlZUV3YvSHpD?=
 =?utf-8?B?RWJNUmwxRzUxNXJ4eFNVaklEdkYvZ1Z3TWpqVFZibUVJdWd5b29qSkw0SVRp?=
 =?utf-8?B?KzFocTE5NVp5cUxCb3BhVHVZbmg5Zmh2aUFDZ3FHelIxQThiNFdMa2Joc3h1?=
 =?utf-8?B?dFJIRi81Y1NvRFp2NXN1RWs1K2RtSGZUWVlLM2grYm9Xa3paLy9FV2FrVStl?=
 =?utf-8?B?a2NjeXA1bHhoZHVmejBCajlqeFBNL09xekw4QWRXYmZ6WmZGOHo3Z0grc211?=
 =?utf-8?B?TW11RzVRa1Evd09PSkxnbWVkT01ScGJqMHduWldDK1pveGxKclZEQytJUkFK?=
 =?utf-8?B?Q3BBZEIrTFFvd0F6QXVXT2pEV3JPaFpLSVA4bTc4c1IzVlhrdGQzY1RKV2xl?=
 =?utf-8?B?Mkk4Wng5MW5iSzl2MElUNHZiNkFMcHpTZmRreVIyaU11MDU0ZjJPU2VwK0Qy?=
 =?utf-8?B?aitHT1UvYkQ3LzVVUUs3OC9CS1FmQ3FHbG4xU0ttSWs5YzZjeUFvb2ErUGhu?=
 =?utf-8?B?ODVheGlUNi9nPT0=?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a836ed63-752e-41e1-572a-08da08fbafef
X-MS-Exchange-CrossTenant-AuthSource: BN0PR11MB5744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2022 16:23:51.0357
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mnSiqvodv0HuRMHHl8+DhHFAgyZsHWlrOgP9sPRBb3JWlY+R7NJYzMbCLtfa9ygqu9Tz8V/TlWgvMtAh9ucQa4yUsurrXyXn0q4Gl2t1ZZM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB1997
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Cathy,

On 3/17/2022 7:33 PM, Zhang, Cathy wrote:
> Hi Jarkko,
> 
>> -----Original Message-----
>> From: Jarkko Sakkinen <jarkko@kernel.org>
>> Sent: Friday, March 18, 2022 2:53 AM
>> To: Zhang, Cathy <cathy.zhang@intel.com>
>> Cc: linux-sgx@vger.kernel.org; linux-kernel@vger.kernel.org; Hansen, Dave
>> <dave.hansen@intel.com>; Raj, Ashok <ashok.raj@intel.com>
>> Subject: Re: [RFC PATCH v2 01/10] x86/sgx: Introduce mechanism to prevent
>> new initializations of EPC pages
>>
>> On Thu, Mar 17, 2022 at 02:08:21PM +0000, Zhang, Cathy wrote:
>>> Hi Jarkko,
>>>
>>>> -----Original Message-----
>>>> From: Jarkko Sakkinen <jarkko@kernel.org>
>>>> Sent: Thursday, March 17, 2022 12:13 PM
>>>> To: Zhang, Cathy <cathy.zhang@intel.com>
>>>> Cc: linux-sgx@vger.kernel.org; linux-kernel@vger.kernel.org; Hansen,
>>>> Dave <dave.hansen@intel.com>; Raj, Ashok <ashok.raj@intel.com>
>>>> Subject: Re: [RFC PATCH v2 01/10] x86/sgx: Introduce mechanism to
>>>> prevent new initializations of EPC pages
>>>>
>>>> On Tue, Mar 15, 2022 at 09:02:51AM +0800, Cathy Zhang wrote:

...

>>> Yes, it requires to apply the following SGX2 v2 patches to
>>> tip/x86/sgx, prior to this series. As I mentioned in cover letter,
>>> SGX2 introduces new SGX instructions and flows, which should be handled
>> during SVN update.
>>>
>>> The v2 of SGX2 support patch set, with 32 patches in total, refer to the
>> cover letter:
>>> https://lore.kernel.org/lkml/cover.1644274683.git.reinette.chatre@inte
>>> l.com/ The two additional patches SGX2 support requires:
>>> "x86/sgx: Add poison handling to reclaimer"
>>>
>>> https://lore.kernel.org/linux-
>> sgx/dcc95eb2aaefb042527ac50d0a50738c7c16
>>> 0dac.1643830353.git.reinette.chatre@intel.com/
>>> "x86/sgx: Silence softlockup detection when releasing large enclaves"
>>>
>>> https://lore.kernel.org/linux-
>> sgx/b5e9f218064aa76e3026f778e1ad0a1d823e
>>> 3db8.1643133224.git.reinette.chatre@intel.com/
>>
>> Why don't you pick the dependent patches from that patch set and put them
>> to this one? It does not matter if two patch sets contain same patches. If this
>> gets merged first, then Reinette's job will be easier, and vice versa.
>> Tags make sure that everyone gets what they deserve from their contribution.
> 
> For easy to discuss, I split the SGX2 support patches into the following two parts:
> 
> 1. auxiliary changes:
> [V2,09/32] x86/sgx: Export sgx_encl_ewb_cpumask()
> https://lore.kernel.org/lkml/cover.1644274683.git.reinette.chatre@intel.com/T/#m44e2b931e82a87a8b2c80058130182eb747fbcf0
> [V2,10/32] x86/sgx: Rename sgx_encl_ewb_cpumask() as sgx_encl_cpumask()
> https://lore.kernel.org/lkml/cover.1644274683.git.reinette.chatre@intel.com/T/#mf6268a66b5c48ca9a18a772b6eaea097c315dc1d
> [V2,12/32] x86/sgx: Make sgx_ipi_cb() available internally
> https://lore.kernel.org/lkml/cover.1644274683.git.reinette.chatre@intel.com/T/#ma3330f8ee8136aa084d0a2b5f110331e37f44c52
> [V2,14/32] x86/sgx: Keep record of SGX page type
> https://lore.kernel.org/lkml/cover.1644274683.git.reinette.chatre@intel.com/T/#m4ae80fdf67ad330119bfc2abaea845baa24ed14c
> 
> 2. The other SGX2 support patches.
> 
> For #1, we can put them into this series. But regarding #2, it introduces EAUG/EMODPR/EMODT and the related flows, it seems not sensible to pick up only some of the patches, it will be not convenient to run the related test while doing SVN update.
> 
>>
>> Otherwise for instance giving a tested-by is impossible. You have to root this
>> to the mainline, or at least to x86 tip.git.
> 
> Put this series on top of SGX2 support is based on the assumption that SGX2 will get merged first. If it's required to make this series independent of SGX2, we need to pick up the above #1, and make change in patch " x86/sgx: Introduce mechanism to prevent new initializations of EPC pages" to remove the handling on SGX2 flows. Once SGX2 gets merged, provide the changes in following patches.
> 
> How do you think, Jarkko? And I also would like to get suggestion from @Chatre, Reinette for this.

Is it possible to factor out the changes to the SGX2 flows into separate patches?

This should continue to support the testing you mentioned and the patches could
then be dropped from your series and moved to the SGX2 series if the EUPDATESVN
work is merged first. I am not sure about the testing though because I did not
notice a selftest as part of the series. How can I test this work if/when it
moves to the SGX2 series?

Reinette
