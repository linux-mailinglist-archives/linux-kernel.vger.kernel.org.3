Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 527BF522DC1
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 09:59:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243231AbiEKH6w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 03:58:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231703AbiEKH6t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 03:58:49 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5BF95EBEE
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 00:58:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652255927; x=1683791927;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=uOjf+5jSoDCSUmDC7Up1kIIyF7xTq7kU0+iv3n7OS/M=;
  b=I/WnYP0SE91NiFpNUTeyWyLZv0IcZfOwpGvOkd/GSzK27E6rsd6Guq6+
   SzT5RcO3RfWDOfTuWNKpiXgS0YI+ZJ1l7YuZw0+NNTIp5VjowXkq8Pd7W
   YAuAIKdejixgJFAl8wz9ieLT58DUQED8lr4h/a3bOu3OF5D5vOtp3kUfb
   MYjxUZrs+LZ+LApo4e76lk17u1bcMKGvFkCkYxFR112M3awEpfye/O0Mr
   ZaR9KJz8QRkOCpGrn0b6MkSGN5h8WHo2XRLKF3aI0zquxwM7EbMzVWj83
   9Xdz0qBr9llKVsZsRi72z4J+00BO6MO2rBKQoPDDHPlZlQ0nhBx03yOyG
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10343"; a="332662129"
X-IronPort-AV: E=Sophos;i="5.91,216,1647327600"; 
   d="scan'208";a="332662129"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2022 00:58:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,216,1647327600"; 
   d="scan'208";a="593996084"
Received: from orsmsx606.amr.corp.intel.com ([10.22.229.19])
  by orsmga008.jf.intel.com with ESMTP; 11 May 2022 00:58:43 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX606.amr.corp.intel.com (10.22.229.19) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Wed, 11 May 2022 00:58:43 -0700
Received: from orsmsx608.amr.corp.intel.com (10.22.229.21) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Wed, 11 May 2022 00:58:42 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx608.amr.corp.intel.com (10.22.229.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Wed, 11 May 2022 00:58:42 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.104)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Wed, 11 May 2022 00:58:42 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KVUzWgxVjxLWhgDpJXknWP65Vaey1oOj6E+gGA7Uun5Is6dQLlso+DEy5ggckYtrJ7QYOsYJN9B5SPUb+IoUduQuFkgiicI1Z0lazIu6izpUxAMmlfFzLiFh2oaW7TfbqiEmhzIUupordd+JWy+w2+ZV8Fy1GNkPBx6iXIzQ+EHbQgK35PF2dOaJ5kiL0BxUfS4yv7ItRD4Jz0QfFbb7kp8z9aDCqedHB3ZuUrDuqJocbOTZZqberCa8/BwO7VsO0XZsYTKKTK74Evb0Yqb400xedoYRyg1Qa2f8NwH2oUxCb7Six+lNkAU3bCscwewza/6keUCjl1mPPhjUB+EnEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NnLN1h/91zkumgs5IKhbg8IhfVZTW7yZ2huHc9/ABIE=;
 b=k/rY1EVMKgTkCiTOPhY+fz3Z7fgPDRdUefgNNLNnMS2UZQFaGkkhmcZEh7TVrcNHYEPA0U8XDcyqOHdtPzfwV7TXb5l9HUjnR8IbtTpfni8xOwghv7mUz53Z/0DzEMSOdiAkgxNA7Wbjyieafr4zwebRCqTAJLRGEuK9dQaNKPYDu7iLABkO3UeatKeTZ0QgJlISiSLcffBUFCicQYlpdS+4gBFX3rpAusWid+vKZJmcaX0df2/nH8WUxg6yTj0rntZGTlY4S/Xay/OLFGadHxVmBxmslfJIvJsA8eKIdFSeWxQknxpE1jT3lRNzvfZW/Q5QayiuuU5+wsiEXSlK8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB6375.namprd11.prod.outlook.com (2603:10b6:8:c9::21) by
 BN6PR11MB1794.namprd11.prod.outlook.com (2603:10b6:404:104::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5227.21; Wed, 11 May 2022 07:58:41 +0000
Received: from DS0PR11MB6375.namprd11.prod.outlook.com
 ([fe80::7910:3e1e:c6db:8b41]) by DS0PR11MB6375.namprd11.prod.outlook.com
 ([fe80::7910:3e1e:c6db:8b41%6]) with mapi id 15.20.5227.023; Wed, 11 May 2022
 07:58:41 +0000
Message-ID: <08a90cbf-eacf-7087-d944-8fea217f0a36@intel.com>
Date:   Wed, 11 May 2022 09:58:34 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.9.0
Subject: Re: [v5] ASoC: Intel: sof_cs42l42: adding support for ADL
 configuration and BT offload audio
Content-Language: en-US
To:     Terry Chen <terry_chen@wistron.corp-partner.google.com>,
        <alsa-devel@alsa-project.org>
CC:     <pierre-louis.bossart@linux.intel.com>,
        <liam.r.girdwood@linux.intel.com>, <yang.jie@linux.intel.com>,
        <broonie@kernel.org>, <perex@perex.cz>, <tiwai@suse.com>,
        <brent.lu@intel.com>, <cujomalainey@chromium.org>,
        <seanpaul@chromium.org>, <casey.g.bowman@intel.com>,
        <mark_hsieh@wistron.corp-partner.google.com>,
        <vamshi.krishna.gopal@intel.com>, <mac.chiang@intel.com>,
        <kai.vehmanen@linux.intel.com>, <linux-kernel@vger.kernel.org>
References: <20220511075522.1764114-1-terry_chen@wistron.corp-partner.google.com>
From:   Cezary Rojewski <cezary.rojewski@intel.com>
In-Reply-To: <20220511075522.1764114-1-terry_chen@wistron.corp-partner.google.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO3P123CA0017.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:ba::22) To DS0PR11MB6375.namprd11.prod.outlook.com
 (2603:10b6:8:c9::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fd29b9e1-44ea-45ea-517b-08da33241025
X-MS-TrafficTypeDiagnostic: BN6PR11MB1794:EE_
X-Microsoft-Antispam-PRVS: <BN6PR11MB1794DE353B1C10B43DCEB63FE3C89@BN6PR11MB1794.namprd11.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hYXUMWr8jGELKqoOE4FhTu3JabxkXDr5+D1qG90pILrqK3NjRvGlR8W2+qxQnIrmnUpaazdimsfhASNeCWrAVZ76S2xbHVQZ55u69/aGLeY83z2HmVSaozhyRA1M+Y216svzumLTehT5OW6Vr1vZdD+ONqkYX38w9F+v7Tl2VgI/iQKLNUgF39jsksKN8/vjBGXTKSW1jYPnxqwr/pBKAjVFT/b0q7P2wS2SHOaVL/SqFl7aQLFvh0Ii69ppn4CrXE0iS2ZKkY0kG9YMx0t4665PVkwhl78w6S+FXEQQ+xO3TMX+jJUzg4fQ/JuQtJbqfFU5uD4x0s2tdsneFdYb9AMlLGbLuLFs9+NRXk2p0ywUWFO5TMw5007F9n7ruR2xEfkIIywFU4CSJp5PHv6zZWYQxKyZxWufeTdP52kmbscPQRs/dUAvqfFdeBN1k218S2Kpi0ilW+sZUyzYpkKrinR4pN8gIE3ZMXAL0oWjyhQ7edKN0BfMxjaCLDo0GDIXVtcSsdQmOvYRaJebNTovsssVnAf3dlaytlPKjQPoABNGSrLRzF4vfItIRKBXLSWqTNma6ObZqrcb3IkgfEkWlUmKS3LwxiXshGbtIBd5dVf4LDfFeRnLoVwCMQrP5SzDCFvHJoKhT8yVPFTpnLgq8B9a4WNy7ySbEhmDEqx8hPkb2ojbbufLNrFr0tY7YxCJnJntByp/liZ6tOyhVg3SOdkLNRexfN5bwv9CbwglWhI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB6375.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(6512007)(26005)(508600001)(316002)(6486002)(86362001)(186003)(6666004)(6506007)(31696002)(2616005)(5660300002)(2906002)(7416002)(36756003)(82960400001)(44832011)(4744005)(53546011)(66556008)(4326008)(8676002)(66476007)(66946007)(38100700002)(31686004)(8936002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WUNHUHdOQVJncXZ2ZnNPU1FQOXYzc3JaZFpDcjRxUEtVYUFzdVhBZisrWnU5?=
 =?utf-8?B?VUtEQnNrTWFEUEZSTFh6NVJFb2NYMWh3RU9UVnNjNEZOVUdQa056WXJQQ0o1?=
 =?utf-8?B?TkRtd2hiT2xPUENIdkZOM2VZYVF2RCtZb1YveTQyRk5nZnh6ZnNTTkRYWm9s?=
 =?utf-8?B?bU91eVR2eWJsZEFFZFZ3MENqcjg5aWZQMjl4NFpwN21lOWVSVGc3eDlRUXZG?=
 =?utf-8?B?R1JkK1BUbTQ1ZXc0R1NySEJHUEhKS3Fpc214ZEpTcC9VMVRReVdQaGxrSFBU?=
 =?utf-8?B?S3A3UWUvZ1ZxRHFCemxBc0tncEd2Y1V2a1ZWUUN2YjdtUmVPQTBHUjRwZUpR?=
 =?utf-8?B?ZURQNVVlaWhTUkFtUG85S1RNYVhLdWtybzM5N1BVdWc3Y0NiTVlpMG1ZRWl0?=
 =?utf-8?B?R29TdHhWZnNjMTFBdjQ4NDIycDJDV25UUkJoSmhETUdXa1I5UTdJa3RjNlY2?=
 =?utf-8?B?QlAxbjVhWktJNWZTU3JkT0pKK0FJd1ZxUExIZU4veHAxSEk0UW9xaFgvTFBp?=
 =?utf-8?B?Y1NTZldsRnBoWFZZSlFBSEhJOE4rZGlhMTR5N1FGZTY1TUFybTRlVGYvem9k?=
 =?utf-8?B?aU96R1RlTHpaeGZ1OXdsajVvTE9kOHVCbzljS0pnTHl1Ti9EVFNXanRlS2VZ?=
 =?utf-8?B?VGNiQVFvQjkwUkk0SzcxUnA5eWpuSzZtNk5YeWIyUVlDa1E2MzViaElTcHVo?=
 =?utf-8?B?Uk9keGlzNFYweE9TWWNMeEx6UElySStWN2gvV0tsNklvZTRCOGRmSDhuZ1lF?=
 =?utf-8?B?b21GYk1BSGovRFJyK3dDL1ltb1luRVlKTEZueGEydExjMEhmOVdwQ1JmU0Y3?=
 =?utf-8?B?YVltcWdObkVwZzB6clo0eXQ1M3lQOGdXWG1jVlZXdkFYRy9GNE0xQVNnVFg5?=
 =?utf-8?B?bUtzWVJQNFJQYkMzNlBVQ2FWQjU1TU1qeTdSYk82ZVNKQkpLSFZNajJCYnBE?=
 =?utf-8?B?N1dJU0pBaEsxbDd2eGtCNnJUN3ZZK2ZIWmR6bkxpLzhwbks5aTRsTktnUGN5?=
 =?utf-8?B?bjNpbXdXYk1KYllFc0UydVZvVk94R0VxejVFS3pMa1AyWnkzYzJ1MFp4cG12?=
 =?utf-8?B?R0oyb2VvcU85RDRnNlBtRVN5eGdPcktIc1dyQkgvdUJaeFg3UnVrOHZmMWk1?=
 =?utf-8?B?UkI3dm1GNG1TZ0NkYlRtTDltSk51d3FHL2FKTkdBTVRjU2FKZWhTZ3RZYm1w?=
 =?utf-8?B?aDNOOENOSWRweE1lRnd0dTdjcTR6YlBZd2dkRnU2QmI5WHIxU3JDeENnZDRK?=
 =?utf-8?B?ejRFZzdONWprbjk3ckJMUjNpZmtJRVltYWgwNCszSG9TTEU1WkdGeTY5NmRK?=
 =?utf-8?B?QkR4NUJNK0RLbWJCTTVQNVhIYzA5VGtrcE53NnlUaXdyTGRPTiszc0JNZGRP?=
 =?utf-8?B?bkdjTlNRUzNzQTJZLzFtYU84eTNia1QxMEQ5LzUzaVRkSXdtcE9CNCtON2Vy?=
 =?utf-8?B?OXZINDBTdWNScjZMZDN2NExyVnc2ajIvc2VqaCtQUml4cXFmdmpSSW9nSmdv?=
 =?utf-8?B?RDBQOTd3Y1ZSOFIxUllwWCtWN2JZUnlMREV4SVIxVDhaZVh5QUpIcHF2QlAr?=
 =?utf-8?B?V3g0SmRVNmNwVDNPMXNLQmg3N09yZXNHcFNqeXBEK3p5M3M1ZnV5WE9oY0Jt?=
 =?utf-8?B?Y0NyZ20rMVp1VDBTUzQ2MEYyTVpHZGc5dGE1ejlteUo3WEt3cm8rVkxJb0xi?=
 =?utf-8?B?YzlSTU1FbzhwMUZyc1NXczJnRm1Td1cybkZCeUk4RXB5b1ZiclkxRldkWXZE?=
 =?utf-8?B?VEdURU5UbFg5K3JrRk1SK2VIc2FMZ25IVThPUUcvTVpzTko3aUtZQWdrenlL?=
 =?utf-8?B?Qk9jTmZhZ3dYeXRZWW90MjhuM25HQVRmUDlzQ0xaUFVPbmY5WmNjOHdySHA1?=
 =?utf-8?B?VnFyUDNGak1SNlFoQ0sydkJOL05UKzhmbmlZNmxWY3dQczQ3RUJPYTluTGNC?=
 =?utf-8?B?alg5T01DVjFVYzZ3ME80bVRVNnA1cEdmVGRJZDh4VXNuUHJJVnF2NXBDck5Z?=
 =?utf-8?B?eXdnWm1FTFFkaVdobEk1RVNjTGVnZ2hXblJCZGh1N0J5V2c4VHgzbjdweXdt?=
 =?utf-8?B?K3hHaHVXWWFvMkI0YUlJSDhxN3RzcVNqM2NJOFREY1NkYk56OUF6YzRPYnk1?=
 =?utf-8?B?MUhsT2J1RitQSXJqeWdVM3Joeis4S2VsYUFIV1RoUUN3K3cyWmY4ajlJZGtQ?=
 =?utf-8?B?ekxSNHNIZWQ5M0o0MUNmTHk1RnJhbm1QR1pEa01mc3A2MXdUU0JqTWRqalpw?=
 =?utf-8?B?NmF3NklzeHphV0NWYWxRMytLcFVHQVgzYmdKNlpUZktUY1ljdFhYdjhrY2Fy?=
 =?utf-8?B?Ri8wQ2x3dTg3cVFWcVplcjcwZ0dzSlFsc0hLOVFmMHZsKy83VnNqYk15NXlN?=
 =?utf-8?Q?n/Yb+Va0tDjUPHGU=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: fd29b9e1-44ea-45ea-517b-08da33241025
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB6375.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2022 07:58:41.0472
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RGd4Hltlq97rGMzSuLM6ytyjR4Jf2AI2cvIQUar+57WjQXwDiqyJXQuPPsZ/RSuqfbO4zR6ebPKUax6P9ik9P66qlspQfNQkSc7YVJ+tDfM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR11MB1794
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-05-11 9:55 AM, Terry Chen wrote:
> To be able to do  driver data for adl_mx98360a_cs4242 which supports
> two max98360a speaker amplifiers on SSP1 and cs42l42 headphone codec
> on SSP0 running on ADL platform. Also add the capability to machine driver
> of creating DAI Link for BT offload. Although BT offload always uses SSP2
> port but we reserve the flexibility to assign the port number in macro.
> 
> Signed-off-by: Terry Chen <terry_chen@wistron.corp-partner.google.com>


Please give reviewers time for review rather than sending revisions in 
such a quick succession. Or, at least state what has changed between the 
revisions.


Regards,
Czarek
