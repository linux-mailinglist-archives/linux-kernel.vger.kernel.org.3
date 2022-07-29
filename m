Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05984585037
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jul 2022 15:00:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234096AbiG2M7u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jul 2022 08:59:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230438AbiG2M7r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jul 2022 08:59:47 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2079.outbound.protection.outlook.com [40.107.220.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 921EF4F183;
        Fri, 29 Jul 2022 05:59:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BmGS0hd9IBlY8KVWKzqoozP6JAk0pC+pQMGjAdsHuH3UTIrLSZLkwGaFHsI6UEIjA+YZYMoHB4mQvT0kClj6BAKd1ZmeV2oiAziLNsfloKQpVjwWyiTwXhsfG3WatrRslc66tF3phJHFTJ9mK64rEB0jy/dIhZuK8cZKvJF7Ym3ip09eQXtA6NtuEalmXDnRlGY9H8WuZ0SU0dP+WuPBpUTfNbb1Ccws5s0cKenx1PQCSh4Mod+1YEPcqrTuwryE5Tmgi3+AEpAP9k93dEzOyHErWRxvJ0CX6GXG1S8i5ggw8bow28S1OSkPi63wnSQhAgemwPrKmiRpbV7TsztEdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jg5enGrYOxBAoHGjrpTvNcRXeIvRhu2u17BJqjc1m10=;
 b=Xu8t67Ceb5Q8QX8Ufr/IJu2jYr2ImuSQupoFsgfBSsj1gcnY21wwXSkPc9BKKdQlzqtZgHFpn/9ZBtP1UoBS0Fv/6u95WVk4ovlFQs94s1KrdJApm/w3qyfdQxuKwqXPQVzlhvX331sNBzHqB2xzSR3gQ5jKvT1uB2PIOK3hyZCnjSRrc4qFejViFJ+BKBjmZTBUQ0G8HkX4lGuob6MEIQnjN5FkNj9sEgKFxKgg/MmOdGqiJGVDISNFud6qjFyyWYr+Lr+BcEPdXcP4X3lz9E7QRur9HKnNGPnc+CkrC3WnqtiPFnu53p5zo1RwMM7yGCERpz7q9btzqLCfQGC65A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jg5enGrYOxBAoHGjrpTvNcRXeIvRhu2u17BJqjc1m10=;
 b=gc6iL+wngktTJRm6EkRGMA8smiZiq4nA80p3JTcc7FIBbeBJjrNtk2EX+Anp30zrcDFPcAvJoeOAXU45UiEvNGA9bNVYbxgl2RsHt9PhakcW5Az4GENlhhfv9qxEGh6/WwauqlNKB+9DBRc8mhdkWVncm2dkFxtiMOg4aCSKO5M=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5229.namprd12.prod.outlook.com (2603:10b6:5:398::12)
 by DM6PR12MB4075.namprd12.prod.outlook.com (2603:10b6:5:21d::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5482.6; Fri, 29 Jul
 2022 12:59:44 +0000
Received: from DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::1dac:1301:78a3:c0d0]) by DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::1dac:1301:78a3:c0d0%4]) with mapi id 15.20.5482.012; Fri, 29 Jul 2022
 12:59:44 +0000
Message-ID: <7da72334-f3ea-fe73-b4b4-bec97ae15946@amd.com>
Date:   Fri, 29 Jul 2022 07:59:42 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] docs: embargoed-hardware-issues: remove bouncing AMD
 contact info
Content-Language: en-US
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     linux-doc@vger.kernel.org,
        linux-doc-tw-discuss@lists.sourceforge.net,
        Jonathan Corbet <corbet@lwn.net>, Alex Shi <alexs@kernel.org>,
        Yanteng Si <siyanteng@loongson.cn>,
        Hu Haowen <src.res@email.cn>
References: <20220729100745.2225558-1-gregkh@linuxfoundation.org>
 <YuO0bY7xMqFtrKCj@kroah.com>
From:   Tom Lendacky <thomas.lendacky@amd.com>
In-Reply-To: <YuO0bY7xMqFtrKCj@kroah.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN7PR04CA0018.namprd04.prod.outlook.com
 (2603:10b6:806:f2::23) To DM4PR12MB5229.namprd12.prod.outlook.com
 (2603:10b6:5:398::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 559bf85b-3806-478f-6c17-08da71623540
X-MS-TrafficTypeDiagnostic: DM6PR12MB4075:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rne5lwYgklt4oGEcCBa3bnHAUD71xfFBLOl6YSmr3ejC0ELMrgjoBEpzVxp6GBdPa011TjRt5OcD/pAfZUrEcXLvaNsPsYo5NKCQ19LxiExvGHglNFkQ5nPm9jgIb7RiVk9qgGoN0e6uHEm94XisMkb1d7c9WWT0t+xvRWstNzBRwZuhlKgXq6AbgYRrL1vmxwzfu4ODZBsNtQ/uwPpCE6T0cmQB/1TctY96V+lyLqYB0cRrOcNP584DNNiGEwmD+5vJf4NSICF8srGdMdpry673yvB0uu3rg+ZIgkdt0IjpEYhvbSQKr33/lK4nFx/TtZYI/vaonD4Yc1nyGrEuBuxTcy6A29l268SFjWIAx0TfWTRoX49hLBwb8Kh2m0JjAHxAqtKXcTdy20VPKYuviFNmCv/8DOGF18y6SkOmK2QmGqmURFde0szgcdvpjIeq6Tqfc/WHXNGTAbUF4hOekob718xXFRbnlDjYWo9CiDohsTRsmk1fZoYCsRdebBn2Nr7cXumG/JpQC0h5kggDTFerz+t9+q0EdLSAx/nc/QWiSsf5dW6p3wm/nWuLzf0+oRS3WdNzeEeKJgC7sqnbcNZ80ds8WreBSYqDd3E4iJnFTlR8JxH1pqjT0bGAyc3AKYyvc3bxJvf5CGUIrejHogrfETrpKtQJrWzv4Y2hAiE+QbovDoi88yZmRm507i20QaGB9/YSHijdTMOF6akimDEt8v+kohfr+BZjgDeospcewuzM/QF0e7CZWO/ct95QnQEKxUw9+H8SjXkS17LGKOFmOR2Y3MK6ixObmXDUmFqDZvzaUrkc+j7amJ5Dx6awNdViSS/u5Qe6cP/YGh5V2A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5229.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(396003)(376002)(346002)(136003)(366004)(66946007)(316002)(54906003)(6486002)(478600001)(38100700002)(31686004)(31696002)(86362001)(36756003)(186003)(83380400001)(26005)(53546011)(41300700001)(6512007)(2616005)(6506007)(5660300002)(8936002)(2906002)(66556008)(66476007)(8676002)(4326008)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UmlucmI1VzMyWC9ZSlZYWXlBVGZWQjU1RzJNVVVzNmdZNHlCQVlORGZ6ZU51?=
 =?utf-8?B?RXJMb3hkdW12QWpxcmZ5SHlGMEIxVFVoTFRISjNiLytYeTV6R2Q0dTE2TVo1?=
 =?utf-8?B?aUZTaEMxQitndWx1eGNmcjBuT2NQSkg1bXp2NW54U2ZQU1B6L0M4TmpBWnpa?=
 =?utf-8?B?eTZCWG54OVJyS244MklmYkZoaURld0J0L2tua2dZQzdhZEdkRnZ6eXcyamJE?=
 =?utf-8?B?MC82WDBqQUlyc20vc3c5S3NqdFd6Q2gydWo3eEZpM0QzS3MyYjFGVUc5SzlO?=
 =?utf-8?B?c2tkMG9yWTJjZEF6YjFyYU1HTDdkNjY5TVZ6MVVFTmNGRmx5UVI1WnhBbEZl?=
 =?utf-8?B?cVNhSElQRXp6SlRpQTNVNCtNM2JGb2ZiemZxN2JXV3JSNnF0TzZrbDJzUkVY?=
 =?utf-8?B?VG9QQjZLRHhReHNDRlJpckdGUUQzUk5SS1dtd1RnOWwreWo1T0tpVzZ6eVBu?=
 =?utf-8?B?VHFZRVdrSjAxV3R4a2xaNGdBK0hyUlJoYXdySW9YSzF1MGVFVzlvbkJjS1I2?=
 =?utf-8?B?d3N0NFh2S0srOXc5V2JBdlcwZlJsdWhGdklNT3R5Z2xjblJiOUQ3RWJoVHlX?=
 =?utf-8?B?L3RyaUFMVTJuclNNL3hVTkowQ3NpOWw1NFlYUTEybHBHc1dscDFJbFA1OVBx?=
 =?utf-8?B?dnFzbFlWYUZBZVBOanJ2bDJWY3BhRllidzJHTUx2MUNwNmRiVDZIZmZwUC9S?=
 =?utf-8?B?QzVkZjg5Mml4dG9MNHBtTS9VVExGYkNiSlVwWWI1VnM3cXBlLzRSMUtuZlIv?=
 =?utf-8?B?c0tVWWF6clBMQmhEUy96QjFuQXR5amFXaFNEWmY4OUM3MDNzMG53MDUxOVM1?=
 =?utf-8?B?c3I3Zko3dDgzN2JGR00xRkd4Z3VVL2NDK1kvU0hFbVdvRHRrYVpsc1VJcWRY?=
 =?utf-8?B?NGVUU0o0T2dhM1pDSzl1YURVVUZIWGFjQnZOdk1ZY2pDT3F1WmpON280WFBB?=
 =?utf-8?B?SnpZZ3pNbzd5dWZzQmxQRmF2LzZSS2lINlNKbEIrK3J6K1VGcnozRlVtdko5?=
 =?utf-8?B?M2MzcFdsN3BSVDV0d1JCQXJaRUZFZDFzbTNzeW5DdVcvUmNkL3ZtOE1NMVhs?=
 =?utf-8?B?c3A4LytKQjZxZmFjdVJNV2dwNzMzYWs3b0JkV1Y4U3pDUXJBMU9kdllPdEtS?=
 =?utf-8?B?V1g2K2cxY0RINnBVTlN2VU9nandWSFJUVHhtWFhJNnNEQVJHcDIwbEdXR2Ra?=
 =?utf-8?B?OStiaDRKOFlDZkI1ekhsMjEyQ1RMdTg2T2xvd1BvVFNtUjVDZXlYbHlXcGEz?=
 =?utf-8?B?bTYvRVBLc2d0YWI2RVpJa2plT0JVWkhzSTdEZ29EVHZDM3ZxbURGa2oveTZw?=
 =?utf-8?B?b0p3N2FiUDNZelZzV3ZWVjJkSDRBdks0Q1Iyd2M2YTR5YkVjTDhNUnBoU3FV?=
 =?utf-8?B?d2hYU1hYd3hYNWVSQ1crNGNqTVZKTUVYMWtFMGNvSDdzWHVyYnRLV2d6TFZO?=
 =?utf-8?B?RE05M2VHTDF2TDV3NUxySjI5WVllVDUzNW00eldLYmJWcnVRb2lMNkNybmlS?=
 =?utf-8?B?WndNQnlGWThGUzNYNHYveEFpMXRtT2UrWXpuTG1EYW1oeW9ZYlpVZkl3VDd2?=
 =?utf-8?B?Y1c2eDlqekQzUFYyNElGVkRHUk9teEpUT3ROcHZqRldpdmhvTDZZdzVIczFy?=
 =?utf-8?B?UXhlOFJnOW5NK29TTDBIVUxiallxTVBweUYwem9oQjFjUG1pZTByT25Zakx1?=
 =?utf-8?B?VVc1Yk00cEw5UW42dEF0OXo5RHFLelBpaHREdkpWN3RhM1F3TTlJeS9IUVBu?=
 =?utf-8?B?cVNGZXVVcjIzNHpEM09sVGpCTEJieW9YNTJBYTVVNmh2U2F3dVdSbnZ3aENk?=
 =?utf-8?B?cHZraHRvWnZHanVGL0RPRU1ZdWpRY3UwK2s5VEF3MlBGbkI1QlJQTGQ3azNO?=
 =?utf-8?B?bEtaSjdCQ01Bd2ZrdXY1TTM2aUF3N3dZKzdDcVlzZFB0THl6Tnkwby84Q09h?=
 =?utf-8?B?R3FaUGxaVHJ4aS9RTXNpcDkwVG1KaEdvRFh4TmZhclJxNXh2Y1N6NE1pUFU1?=
 =?utf-8?B?NG9Rd3NYdlhzelhTVEh6WVRsOStsN0w4VTFzc3oySlBoRnY0dlc3R0diMUEx?=
 =?utf-8?B?UDRSYjh2MlJFZ2NSVFhTWVIxZTFUOFhPM3R1WmdQRFJwbGpoQjBpL3hJdHhX?=
 =?utf-8?Q?O2tnXLnwPf2M415HfnAh4Srpc?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 559bf85b-3806-478f-6c17-08da71623540
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5229.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2022 12:59:44.2680
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DeuRqEFPeyEdJDAfC+vPVumt/77e2CrAFzvmXMxHawaxnJ2WhOKiLyscNnglzHzlkDIqznaJJWdUhC4S5vlnWg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4075
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/29/22 05:20, Greg Kroah-Hartman wrote:
> On Fri, Jul 29, 2022 at 12:07:45PM +0200, Greg Kroah-Hartman wrote:
>> The current AMD contact info in the embargoed-hardware-issues.rst file
>> is bouncing as an invalid address, so remove it from the documentation.
>>
>> At this point in time, the kernel community has no way to contact AMD
>> for any hardware-specific problems.  Hopefully they can resolve this
>> issue soon, or maybe they just don't have any hardware bugs and do not
>> need to worry about this.
>>
>> Cc: Jonathan Corbet <corbet@lwn.net>
>> Cc: Alex Shi <alexs@kernel.org>
>> Cc: Yanteng Si <siyanteng@loongson.cn>
>> Cc: Hu Haowen <src.res@email.cn>
>> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>> ---
>>   Documentation/process/embargoed-hardware-issues.rst             | 2 +-
>>   .../translations/zh_CN/process/embargoed-hardware-issues.rst    | 2 +-
>>   .../translations/zh_TW/process/embargoed-hardware-issues.rst    | 2 +-
>>   3 files changed, 3 insertions(+), 3 deletions(-)
>>
>> diff --git a/Documentation/process/embargoed-hardware-issues.rst b/Documentation/process/embargoed-hardware-issues.rst
>> index 95999302d279..a8c38e1c40dc 100644
>> --- a/Documentation/process/embargoed-hardware-issues.rst
>> +++ b/Documentation/process/embargoed-hardware-issues.rst
>> @@ -244,7 +244,7 @@ disclosure of a particular issue, unless requested by a response team or by
>>   an involved disclosed party. The current ambassadors list:
>>   
>>     ============= ========================================================
>> -  AMD		Tom Lendacky <tom.lendacky@amd.com>
>> +  AMD
> 
> Wait, Tom, is this just the wrong email address for you?  And the one
> above I used in the To: the correct one?

Wow, yes, I can't believe I made that mistake and haven't noticed it! You 
are correct, it should be thomas.lendacky@amd.com.

Thanks,
Tom

> 
> confused,
> 
> greg k-h
