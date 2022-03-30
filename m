Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5E314EBFB9
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 13:22:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343597AbiC3LYg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 07:24:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237302AbiC3LYf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 07:24:35 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2084.outbound.protection.outlook.com [40.107.92.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDD3714FFF0;
        Wed, 30 Mar 2022 04:22:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fYnxAc31dbFtiAa1/u+czKlpgiSp4yws7J/TT+4C6RPj7FYaqB4WjeoKGLRMzXxzRiYzy1/uoJw3yAapxFOQUTMm5VLNBNKP+DFpjekFrH1Y/Mdl7MiwGbcrAFSXvjh44W+JbOGTdvvj5cx0Y5sIWPFWsqXTvpD1hzfflnuUxcBSQEfE7m9ry14viGKy4vnFqWIpGKx6R/pCnKVg1ScDsb3TqpmKgtKCo3oaIKcyma4tpioe/bgYColPh2fO3W7pwac4XE6i4N7HksVXTfUSCvmUvjEAJmKurltVfmUU/eaIyTTSJnuKmpVRge23Oh9VOsOH7H59nu4hX8bt3mFyYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Jca7/nWqrY2FfognAbafcWTksVsN4DYLeEMnhSQCYF8=;
 b=kkQ1zjZyrbsIaud5zlLKz/fFkC5MP1JFtzteTgN84btpNzaMeKg+tA1879A3fWHpwUGGt22UOq70C7rAbaiFF9WsLuxNA0Pb1TIrPw/GfYLepKiNy9tJNC1NJRaz6+BzVBZBJ1RD9WH9Zma+n2HFGfw4WzuSIkt/Sb1k/5y/ycbyE0IccfcsUO7eHr39tSCwMj8/qivG1U4VbTe9Lt4t4IRXmzWqKsmURp3gwUGspxkK6BnY60VX7iEtl9bid+cuzM2yJO07r+vihvbPJJCCp9T8wQHOT68xbEBwjgTd/VwdtxTfwSH6jZn3IuPr02d1PKE12kQl71/X6aUUsp/JRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Jca7/nWqrY2FfognAbafcWTksVsN4DYLeEMnhSQCYF8=;
 b=k9Oet20rdTcBxizYAVh/4SNJKSgWcjNqmrDIifX/lYjbgM+7ZO8yXtWBs7FRlKOyFw2WjnkwNah6KOeTAYqCu6r/X/VNWk8JsactrJ9CXTYYfnzSlWNKB1ODrwFbgDCbAqkiO/9MNbruzg0jFYvdSpKVGlyhe1Wbh1fG3/5h0mYheTktBsWROVSk0W4jRetBhAQnWLXVUGb7NJ2EVpTKmcBQsLc9T6olgRzBYopf5/pwrl8M5yJSoSDl9/b9dJhr7BcHb+OqlQtYiGTtTorKBz5Hh18QsIgK1os5jhrNmUdhozEcYlcU5a1CepfcWuAls4zDd+Xnh91rWQhpS4bC9w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA0PR12MB4349.namprd12.prod.outlook.com (2603:10b6:806:98::21)
 by CH2PR12MB3735.namprd12.prod.outlook.com (2603:10b6:610:25::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.19; Wed, 30 Mar
 2022 11:22:44 +0000
Received: from SA0PR12MB4349.namprd12.prod.outlook.com
 ([fe80::e15c:41ca:1c76:2ef]) by SA0PR12MB4349.namprd12.prod.outlook.com
 ([fe80::e15c:41ca:1c76:2ef%3]) with mapi id 15.20.5102.023; Wed, 30 Mar 2022
 11:22:44 +0000
Message-ID: <06174428-edb1-6478-1b2c-ede83c4bfa87@nvidia.com>
Date:   Wed, 30 Mar 2022 16:52:29 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [Patch v5 2/4] memory: tegra: Add MC error logging on tegra186
 onward
Content-Language: en-US
To:     Dmitry Osipenko <dmitry.osipenko@collabora.com>,
        Dmitry Osipenko <digetx@gmail.com>,
        krzysztof.kozlowski@canonical.com, robh+dt@kernel.org,
        thierry.reding@gmail.com, jonathanh@nvidia.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org
Cc:     vdumpa@nvidia.com, Snikam@nvidia.com
References: <20220316092525.4554-1-amhetre@nvidia.com>
 <20220316092525.4554-3-amhetre@nvidia.com>
 <9ab1a77c-82e6-39be-9b90-b394037fb574@gmail.com>
 <a62bb479-fed4-ada0-ac61-fb67a663a998@nvidia.com>
 <4ea801f4-7929-148d-4e69-d4126a9dfbf7@collabora.com>
 <44235c65-160c-04c7-294d-16b13d25605c@nvidia.com>
 <bf851834-7812-13f1-a382-1f64078ff2a5@collabora.com>
From:   Ashish Mhetre <amhetre@nvidia.com>
In-Reply-To: <bf851834-7812-13f1-a382-1f64078ff2a5@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MAXPR01CA0101.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:5d::19) To SA0PR12MB4349.namprd12.prod.outlook.com
 (2603:10b6:806:98::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f700769f-14d7-4c80-392a-08da123f9c55
X-MS-TrafficTypeDiagnostic: CH2PR12MB3735:EE_
X-Microsoft-Antispam-PRVS: <CH2PR12MB3735C6CF8B0D7867953D0C85CA1F9@CH2PR12MB3735.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DyTtFvCrXjM8ZfTwkcFjPw2RAlU/ay5Kb7G1V8i68LYF5o2A3EANXvtfQp97hwolBJ02TOL98hglSvdmYfDdEOOgCAxXPnZLy7p1A2jV/vZXkHdT5MNfEYKARVYJphgJPDBIp7SMXer/BPqvvv4U64+3rQdnJdjkMdjvn988k4eB4pByyFFzMFUfib7wYTkBOq/KRVFdIibp62M8oqG3rYvYWkJD8QMfhspIaoWe33zpoDaCLd/iD2i7FvFUzgxJWypXwdHz4q2LrbJIO1CteeE/+7yoWf8Ldc87DY674IGwQMd6ifgUmPEC3fBFXliiOU56hDzzpyV3jS8bjfgFdg30o/V8lEqdYolKRUSty+3hJ9QtzGhIX6FCLBjfMrX9c2Qgnx9c3mTxL47xXrEsn1etgcKBtWLkuU8QaVMXGEgZVgp7a15Kh/Nv0F18n2XLwzVcXilzoHRE+PcERVwQ51g5Tk//ekE1XQ4RAr1o+R6jM5CB7gSl0NxUD8Rv/PY/mPZfkrXDg9g7bWg/u7f3ucumhb47439tjZUnVuCutPxHIS1CAPkwC99AAYG2wvl9awPI6J7R6O4fAge99P9MJbFUNwarfUJ/h5ZaIRps/9EOPItW+YKqyJKdvqADtBoqg/qnXnXJsE+2qGRmKkPFi7DJAXnxsX7eg7AKb/ZYdXk1D7lbEy9y+pXLwqcxZ4xBkfefOYkJm2hZiZrPFjTKAg2VpWzuvKbwIbgPGV2BTVEkAmHBpV8bikImfJmMYVEd
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR12MB4349.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(316002)(26005)(86362001)(110136005)(2906002)(186003)(53546011)(6506007)(55236004)(107886003)(2616005)(6666004)(6486002)(508600001)(31686004)(31696002)(6512007)(66476007)(36756003)(8676002)(5660300002)(38100700002)(66556008)(66946007)(83380400001)(4326008)(8936002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?T2U3SG9Nc3FjaE5lL0NQUnlrbHB0THZSbVgveStYUVJET3YrZ0UxbFhwNDN6?=
 =?utf-8?B?RFlEcmx1WTRXMSsvYWpDV2VEdFYyMU4vMi9lOVp4eElVRTVwVnF3cDZTN3cr?=
 =?utf-8?B?a3ZvL2ZRTFlOZVpoN2QrRzh0RFNsUGxiMklSS1lVSFpIajA2d1V5VUFUajlO?=
 =?utf-8?B?bHZLR0owcDBzTmpSZVVObGl4dXBpMkl1MmFTT3ZRd3VkU09OWlhSek9uMFpw?=
 =?utf-8?B?WDhTSlRpVUlrT3Z5SmxXUGZhQTZmcTNqOEdSQ1RBcjEvbndscy8yVHh0YUVq?=
 =?utf-8?B?c3ZvNXNicDNYUWUvMzNRNG5aWm5id0RkelNlNkNKUGo4N2FjRUsyWHFpK2J5?=
 =?utf-8?B?NDVnVDdSMSs5d1JuSzVZWms3c1ZLM1pQKzNpUzlvWmxBY0t6ZWdWWWVZRThK?=
 =?utf-8?B?OTl3SHhud2d3dlJoTXBPM1pRZ2FyUjJFRlpuSjVBTjNXR0tXV3dwQUdxY3BX?=
 =?utf-8?B?YWZLbmlDSk8xUGVGQ0tYN3hsNkRhclJvSDY0am5HMncwN3dlS25WT2ZXTmVF?=
 =?utf-8?B?QUNwL2N0QTVaYXlXWnlEV0ZLK29lM1pKSXFTRmc0bzQ5dDhKQ3dsVnJIUmQ2?=
 =?utf-8?B?TVR6S3hVNEZiWTlwdUR5T25iL3lzN3BSTisrR3U5eGJWVW9rR0FLbjZIWDcx?=
 =?utf-8?B?bW5YTjhlWEFyUjFBYUptTTFyd0VzR1I4a3h2dkJTVWIwNVBSMUR6ZlRPSWdV?=
 =?utf-8?B?OFk2TDdMa1I2dC9lZlVLWkQ1Y1padk9tUk5hYnhYRkE2YzlnZ0x1ZUVFdFFx?=
 =?utf-8?B?YmRqRWFxdnhLZUIrL2ZlM1pwN3lXeHhRUG1UY0VoSDlSbXZxTGl1Vkk3VnBl?=
 =?utf-8?B?VWlMQ1ZCRG1kVWlUdXN4bC91S3JVSHpaNHRiNE0vc0t1MkRvc0VOTzk5TVlr?=
 =?utf-8?B?R2NidkJZZ3F4dS9KbkRFd1NhVWxNOHErb0Z3SXU2bXloVlRPR3pWKzh3M1N0?=
 =?utf-8?B?czVVdy9tZzdkODRVN3E1RkFWcGRaaSt4YXZnQW1LZlhWMmorQU9QaSttVWQr?=
 =?utf-8?B?VDBjS3BUQzNabmVURTJCNU1kcXBqVzdOd1U0c211aW1Vd3gxVUllUXJiRmty?=
 =?utf-8?B?NE14WXdTSFBQakx2SmJkZ0FxVjYzSUlBNnJ3ZjhOMUdXb0dBcHlLaDZuTXZ3?=
 =?utf-8?B?ak1sRkgrdzhlQXpNMXZldzk1TkNVTjVDcGJETXlKMGhxeDNqUDNCMnR5S1R3?=
 =?utf-8?B?bWFkQlZXcjJteFhoT0tBZnRqTWExNnlKWnNaU1NLT1h2QXRWL1l4VG0yOWgw?=
 =?utf-8?B?d3VlZ09FbnMxUDN6RWxoVjd2VXJxL1VKRkFCZ3ZjVWl1eElSN3FQTm1ucUVI?=
 =?utf-8?B?Vk1kcXdQQThBQkNuM1NnOW5kVjhZenc1bTFDSEltYS9WNThDOU12SjBDQUxS?=
 =?utf-8?B?ZzZXZm53eU1kYU55Rmp4YnVZOFNEaC9DMVREeFpmVnl2ektCQW1XemVWQmxy?=
 =?utf-8?B?UjdnTTVjQW5TWlEzaGJ0VDYvM1dVMExHeGNnM1Z2b3k3NVNvTUFPVWtJaU5X?=
 =?utf-8?B?RDJXejUxbEFGb0hqZVIvY1E2bzNobVk4SVc1b0ZMYVdOdXd5Wk9EdmJRU0Q2?=
 =?utf-8?B?blNCcEpQUVlHOWN0NVNEUnhWM2wvc2JLVXdpNkx4U2NxTS9RVzQ2a2VHQ2h6?=
 =?utf-8?B?bEk0V3d6NDhNSW1nRHdXZHZRa2ZDNEgzZ2VQSENYZWlHOWptSUNSMEdIaDg4?=
 =?utf-8?B?ZWxrbUtCRHlCb25pQXM1VTB1MERuQnVJT2E1b0M3aWRldXNqUkEva2tkOEpS?=
 =?utf-8?B?ZTM3M2Y2cEx0aldZZEdzVUEvd09pSjBPM2owWVdEeEpEMWttUGxRUDNZWG1r?=
 =?utf-8?B?RU1zcHBSRE90OWRDKzJJTC9QTHhWVVl0bElVQnNUUWpLZ1lzbEFKaGkxSmE1?=
 =?utf-8?B?aVdzNE5xeWRjcjhFVjZ3dmRKSVVUbTFNRkhGL25RZnNiQnkxaXd2bjNFQ3hz?=
 =?utf-8?B?b1BiYVBFK1JRUU00SVdFZy9zQUY2b0lUb0JTdnNJRHYvTWVRVGQwWFduTU83?=
 =?utf-8?B?OHRYT2tzT2lNR0srVE16VDhieGNqR0VuTEpPbXk1M0xCWkk1Wnk1SlJQNWpn?=
 =?utf-8?B?NUJFcUJoQ1lNTFJQeENUcDRFK0hKOUVxMWR1bnRUdUMyVDhaZmNnY3cyclFv?=
 =?utf-8?B?ZVF2bFZWcHYzaVc5aXJYVFAvVitPQ1VJZEdBZWdwQ0JESXN4UU9LUlJsUE9J?=
 =?utf-8?B?dU9sZjhXYzZMcHJyTlpVSzIxVTVOWlpRdGFIcGsvNnFFc1hzVDYyVkZTcUsx?=
 =?utf-8?B?K2FLdWk3ZmMxSjB6U1ZiT2FwSVNFc3Z6RUZ6Nm0rd0FidUwvRS93UHgvdVpV?=
 =?utf-8?B?bjBZQkpDem9Qa3c3NG5ZSldMSHZvTUlWQnlhYUxXRDZ3aWh6dHFhdz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f700769f-14d7-4c80-392a-08da123f9c55
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB4349.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2022 11:22:44.5322
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cCB7s5/0vg1eTAHpFPVN4+zJFPRBElea0pcSQmVpWjiihZ68+HVG4/CX2L4X6yo+mlYpcizbWruPgE+Z2Xzffg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB3735
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/30/2022 4:06 PM, Dmitry Osipenko wrote:
> External email: Use caution opening links or attachments
> 
> 
> On 3/30/22 13:16, Ashish Mhetre wrote:
>>
>>
>> On 3/30/2022 5:31 AM, Dmitry Osipenko wrote:
>>> External email: Use caution opening links or attachments
>>>
>>>
>>> On 3/22/22 20:34, Ashish Mhetre wrote:
>>>>>> +     switch (status & mc->soc->int_channel_mask) {
>>>>>> +     case BIT(0):
>>>>>> +             *mc_channel = 0;
>>>>>> +             break;
>>>>>> +
>>>>>> +     case BIT(1):
>>>>>> +             *mc_channel = 1;
>>>>>> +             break;
>>>>>> +
>>>>>> +     case BIT(2):
>>>>>> +             *mc_channel = 2;
>>>>>> +             break;
>>>>>> +
>>>>>> +     case BIT(3):
>>>>>> +             *mc_channel = 3;
>>>>>> +             break;
>>>>>> +
>>>>>> +     case BIT(24):
>>>>>> +             *mc_channel = MC_BROADCAST_CHANNEL;
>>>>>> +             break;
>>>>>> +
>>>>>> +     default:
>>>>>> +             pr_err("Unknown interrupt source\n");
>>>>>
>>>>> dev_err_ratelimited("unknown interrupt channel 0x%08x\n", status) and
>>>>> should be moved to the common interrupt handler.
>>>>>
>>>> So return just error from default case and handle error in common
>>>> interrupt handler with this print, right? I'll update this in next
>>>> version.
>>>
>>> Yes, just move out the common print.
>>>
>>> Although, you could parameterize the shift per SoC and then have a
>>> common helper that does "status >> intmask_chan_shift", couldn't you?
>>
>> Do you mean shift to get the channel, like
>> "channel = status >> intmask_chan_shift"?
>> So to get rid of this callback completely and adding a variable in
>> tegra_mc_soc for intmask_chan_shift, right? Or compute shift in this
>> callback and use it in common handler?
> 
> Add variable to tegra_mc_soc.
> 
> The intmask_chan_shift is a misnomer, perhaps something like
> status_reg_chan_shift will be a better name.
> 
Okay, I will do this.

>> If we are to remove this callback then how to handle unknown interrupt
>> channel error?
> 
> Create a common helper function that returns ID of the raised channel or
> errorno if not bits are set.
> 
So something like this:

int status_to_channel(const struct tegra_mc *mc, u32 status,
		      unsigned int *mc_channel)
{
	if ((status & mc->soc->ch_intmask) == 0)
		return -EINVAL;

	*mc_channel = __ffs((status & mc->soc->ch_intmask) >>
			     mc->soc->status_reg_chan_shift);

	return 0;
}

Correct?

>> Also we want to handle interrupts on one channel at a time and then
>> clear it from status register. There can be interrupts on multiple
>> channel. So multiple bits from status will be set. Hence it will be
>> hard to parameterize shift such that it gives appropriate channel.
>> So I think current approach is fine. Please correct me if I am wrong
>> somewhere.
> 
> You may do the following:
> 
> 1. find the first channel bit set in the status reg
> 2. handle that channel
> 3. clear only the handled status bit, don't clear the other bits
> 4. return from interrupt
> 
> If there are other bits set, then interrupt handler will fire again and
> next channel will be handled.

For clearing status bit after handling, we can retrieve channel bit by
something like this:

ch_bit = BIT(*mc_channel) << mc->soc->status_reg_chan_shift;

Correct?
