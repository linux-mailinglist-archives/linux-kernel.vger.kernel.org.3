Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 245824B8A7D
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 14:42:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234650AbiBPNmU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 08:42:20 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:47766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234649AbiBPNmR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 08:42:17 -0500
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2059.outbound.protection.outlook.com [40.107.244.59])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E68DA8093F
        for <linux-kernel@vger.kernel.org>; Wed, 16 Feb 2022 05:42:04 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YmrrvS43mSz5mbrN1wtWL4DcOZAe7dIZzTrN47HTVVX/9QDAISoy82wcxOOuZ7WXd0CglhucthPEVx/HwpmOxqvl/V5aw4QXi0TTsEA+bSfMIdSM1TCGL7Vs8jn1ZUUBjNee3F4qVsuHOJZQPzNfEGJY9A1SY5Z8E/ckT54NtESt78AJpLnIWeEdJCEyufmtIYjiDaFGj3H/G3RO5PxxCICBDLoiDT3ldDW4JDeh360cYFaKJ0QBcwsR1SFQhO1GwIKoJz7/AU7usy42YSVnpxNbF0vLkjgchfGBUR9+IMT5Qy8MDml9OYB5OaV+sHw8hGuCmjJc4a/q2CXCUrdJRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MRvHex/P6+IYRzQ+iKoeMyW8iy32HcnEXkeklbzf7rs=;
 b=HHFtSKX+Jm8vV5I8v0k2EFK8LB3IhsSkDXw0Oluwk7AWw0VlcvAmMgtv+bLZylwdoUdR55ytavB0hvkb8MOlfGarrmyln95WQKC5NoV091P50KQPkY1HHf1i+/4mept9fbeseOHLOnucXtjqFIzswCQY/dbkY09dO53hDLyc8YSC5miiJ/6KVZcpMsn94cHMgbMx5OCnoYJtY2ni0kRhS6GptYWywrzK8Es1grJggls0dQ1l9nhzd1r1RWaOqh4Vk59FBMBypE7+4OyALXSVo8qRqjiFd4jxSbMT2vaa3dwMOUGz8+2uLfzn2lve/+dYe3San+POYj0TKocjJpT9Iw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MRvHex/P6+IYRzQ+iKoeMyW8iy32HcnEXkeklbzf7rs=;
 b=bfeWC+YojsRi1H19p9/ZLKan14F4OKkr30tYRhsDFAjUKzLzIfRydFMNGeYzqQIZ7xQE9S1AzAxdqyc4DyndUbCQxgLtFkPvDxSN22bd8a1rZ97lw4Vzeuk+EVfIpBMj+8GsuYSlEQQsi77Muosfywrk+Xv/+7z7prHuyEFCQ5c=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5157.namprd12.prod.outlook.com (2603:10b6:208:308::15)
 by CH0PR12MB5042.namprd12.prod.outlook.com (2603:10b6:610:e1::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.15; Wed, 16 Feb
 2022 13:42:02 +0000
Received: from BL1PR12MB5157.namprd12.prod.outlook.com
 ([fe80::692d:9532:906b:2b08]) by BL1PR12MB5157.namprd12.prod.outlook.com
 ([fe80::692d:9532:906b:2b08%4]) with mapi id 15.20.4995.014; Wed, 16 Feb 2022
 13:42:02 +0000
Message-ID: <579aec6b-78d1-57af-8e17-59cbe59f168a@amd.com>
Date:   Wed, 16 Feb 2022 07:41:59 -0600
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.0
Subject: Re: [PATCH v4] x86/cpu: clear SME feature flag when not in use
Content-Language: en-US
To:     Borislav Petkov <bp@alien8.de>
Cc:     "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Thomas Lendacky <Thomas.Lendacky@amd.com>, hughsient@gmail.com,
        Martin Fernandez <martin.fernandez@eclypsium.com>,
        linux-kernel@vger.kernel.org, Brijesh Singh <brijesh.singh@amd.com>
References: <20220216034446.2430634-1-mario.limonciello@amd.com>
 <YgzTCtlMq9+4IsZ4@zn.tnic>
From:   "Limonciello, Mario" <mario.limonciello@amd.com>
In-Reply-To: <YgzTCtlMq9+4IsZ4@zn.tnic>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR19CA0009.namprd19.prod.outlook.com
 (2603:10b6:610:4d::19) To BL1PR12MB5157.namprd12.prod.outlook.com
 (2603:10b6:208:308::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 36ad91ea-8c51-4bea-9920-08d9f1521cf9
X-MS-TrafficTypeDiagnostic: CH0PR12MB5042:EE_
X-Microsoft-Antispam-PRVS: <CH0PR12MB50422D59F02441C45B1CEF9EE2359@CH0PR12MB5042.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1360;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: J1lZvbsdlP0zxe73h5GjhLsSvA/rxqFhoFUzO1/OMsHakYVWMes6gvBlQAHyRj59QsnrLOeYqVnNSCH2mSG0t3y4WGNxeebldeAD/k8ahxKsKIXjNjYqJCYP948emtIMaYYGbYLH+U5VTJc0luzxi6iIjr8YMcpj6XPHiEpKak8GXVxulSp4H2OJeL/C+ibt6C6M9HiI8g4+9NiWFA5SFmCllbn+8HJ6RC7/sQE7dBCboGxvvuxazjNWCOJm723CE7qr+0qiRx2KmDvvSLNXq3OcbOR9zpov7diTvQURLPIxv1Zf+oY2B3sfVlW4Bn0iaBRUYDMqYeitdLHeJkFsPoJmVav6dQqKYn2e5jzWzcLVRwmUH/BFyM4Y/p4f3e8cS6ZF9+HyzLAjb5kVKWg+5YFqmBhStJzv3BvO945Y/NxLIQ2FfqzoQKLA2/fkraRpOPMlfQBCwpJvY++cJA7XoT5piccBlP8J+WDL6gHSxVUDxbQAUexBaXXQ+czFIiTzKfMt51i5o/ibwsLqMve34aYK5DU4TYo40a62ydyweHALrryAjmmK5Yf5cBn/tJJzgjX9aUznLRHmZ0SZp6jS7d0m8MUugzzauBXRUmfibQVp8q/E8EWJsmFidEpMZrRMSfe5NF6u/c0hPidNQE3yyThrkOU0alFjfM2Mjs+rwZYSTi4qdeeOA7LWL7yXV0ORazl5BqRFZLfRiHhJpqoSt5y1UO4I/dxaeaUpo8EC7LGmWdk8ECtxerhzH9JBR+Ul
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5157.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(66946007)(8676002)(6486002)(66556008)(4744005)(4326008)(6666004)(31686004)(6506007)(36756003)(66476007)(83380400001)(5660300002)(38100700002)(8936002)(31696002)(2906002)(86362001)(316002)(26005)(508600001)(54906003)(6916009)(2616005)(53546011)(6512007)(186003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UHNCWEpjS2Q5cDExYTZYWm9aMmQ5b0RpSnVscFoxQnp3VHdmTU5KN0xjTWo1?=
 =?utf-8?B?RnhvSHZ3S0d3QkRnaFJWVW5BbkdORkc3MXBxSiszSDJnQTdDSW1HWkJReDVa?=
 =?utf-8?B?ZEs1UzN3S2VZcU1adlRkYWNQTEVPWVkrNnBCWU5yMUxTR2hpUlFFUHZaQUNz?=
 =?utf-8?B?T0t3TnlmblRnbVhFQjE2TG0rYm0ydEo3T0dWREd6dEVpQkpqckwyd0RtWE9y?=
 =?utf-8?B?WHVzaVd0eVN5U0JudFBoNDdpanRvdDUrS1kzWWJWeEduVmJRaUluSkJsWEFv?=
 =?utf-8?B?LytUNmZ6aUVCTVdERGdQV2lvcStPVlJFbm0vWUdmTFlpU0QyRVZTREJLdEh0?=
 =?utf-8?B?SlVBZlovbnlablQycTF4NUs3ZkJmTzc1aklWTEIxQmpHS0FMUWRvQm5MNWFh?=
 =?utf-8?B?TGwyOVQzMDBXQlgxNXBVcWl6Q3ppRW1mMnNsK0FZT2pXWEFpRzRuWFRoN1lY?=
 =?utf-8?B?ZFFVakdkSmk0QVVQRVd6ZHFFN0pYYzNzN2ljVHJUMU5nM2EwaUlTM3RBYkxn?=
 =?utf-8?B?YnlhK2x2QXFZVUFudlJ6NkZKYWFsVXN6SXpHeFZ3NlR6RzZ3Z05wdFFOWE5i?=
 =?utf-8?B?dHVqSGM2eHgzT2dMOU5EdmUrNFFQR2svV3VBa0lKTFlHaHE3WHBlZlh1bXJX?=
 =?utf-8?B?SmFrTFR5ZWtvLytmVGtwRkZ3NFZnTWhZTktaMEFtR01vc2RxdnA2aThvSFNF?=
 =?utf-8?B?VDA3WGZtMzVIWWlsOWQ0dWJ3NklIUldMMVNWRlo0VjJaRXpBd295WkxtSGQx?=
 =?utf-8?B?eUZXZzFGbXJ5ZTlwbnpHNGpuc0JBWVZtR2RPdVlNaXJFQ3VBcWxZWUVldTFR?=
 =?utf-8?B?MkloTno3M2dWVkVsTU9ka0E1bHYvbGFydnp5dS9iSmVUQ05QRUdBYkVYUSs1?=
 =?utf-8?B?OEhxYU9aTGlLaWJSeWFybU4vUUh3cndpNklkNUk0Nm02aXdmSWRXTkZFS0cy?=
 =?utf-8?B?Zy9PR2JQVkZrMktFeVNjSTdyaGRBZEhOQnNmRlhITEI5M2M3Nk5yVkJSbTQv?=
 =?utf-8?B?czlFQzEwNFAxdEVuWXViMCtHMnllbGRWYUVjRGU2cHR3VWJWSzh2OUlKWXVp?=
 =?utf-8?B?Wmd5N09pa1FMc1FCRkRvQVUyTktTcHNuWHdId3BpMmlhQzFBeTVnY0h1ODNJ?=
 =?utf-8?B?dTFnR3dkSkwzeWJCUldRL254bEozdE02aDFMU2NpN3FaNUFKTzNPVDdTNUZF?=
 =?utf-8?B?dW5qanlDMkJHUTBFbGVXTk14MHJRQUxuM0FzU0c2K3lUY2xsN0NPVERGZWJN?=
 =?utf-8?B?M25DR3ExOFd5bStKTUhEellJL2szWS9zOE1DSDZETnpjRnhhRzFJMU15QXVq?=
 =?utf-8?B?UTNjdGVGNTFSMk9sZmk2NlM0YWxqeFFKUUgrZWZnbVdvL0VmTU1HdzVrYW0y?=
 =?utf-8?B?REhVbFVpUDZmWXMvdWpPak4zVmpVQTd1aDFaYThVK1ZQS1JLUy9FT3dodVFj?=
 =?utf-8?B?SDlyR3NsZVRCc2p5NHFjWnRSaTFJUVFkZVVHcXh0S3h0NlRpS3dYbzdKZHVm?=
 =?utf-8?B?a0JtSmZkUURUcDJBNytHSjUvUlVsVU5qaXkwR1ZWN0VZVWUyNCsrYnFRc1lv?=
 =?utf-8?B?TStna1ZpTzEwN1dEOEt2MXkvRm0rdlFHSmFKRUZVZVZlVkpVUDZsVkw0SUpp?=
 =?utf-8?B?VzVtTjU0NkIxMVgwTG1TN2o3Z21FaDRGTlovOGQyMXQ4UDdYVEJSREZjUTZN?=
 =?utf-8?B?SnA4M0pyeVRJVmVFeXJ0NTVIM2Y2L28zUUdEZk9Kd2s4b3JyYk5UcmtkWVpp?=
 =?utf-8?B?MjYzTHV2a21jbm1kcWdGQzZmdGZ5TTU0cUpmbmtmMWwrTU1GekFZQ0NFMkdm?=
 =?utf-8?B?VDNoejl1anRmNHRjMHdaVWhYWEZzYUthT0JaR291VjlWUnE0QnZzZlhNeFY1?=
 =?utf-8?B?Mkg2Rk13WUlrOFM4czFBT3VjRHpRVEMwbStVSnc4MWVnS3piNS85eFVkU2sy?=
 =?utf-8?B?RTllRURkcWtRYnNLbTd6QXcxNlhIVFVWcVhUSXBjUDVySkpKV3NBUlIyUG53?=
 =?utf-8?B?dFNpdlZ1RGFoWWJIbU1tQ2VTRmZCaEhvOFRhVFVUd0ZYOEtVU1k3bS95cUpm?=
 =?utf-8?B?dXB0RTJmcFJpYXd6THlsa3NIS0luc1R2S09wK3Bod0JFYmgyL0l6b3pmc0w5?=
 =?utf-8?B?SmtYWTJpT1JSY2VxY28xR3VMNlpvUy9BU0NqUTBTellmUzBZMmExam9ZQklI?=
 =?utf-8?Q?9yvWvHe//UX1Xa/+LFkyTWc=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 36ad91ea-8c51-4bea-9920-08d9f1521cf9
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5157.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Feb 2022 13:42:02.7242
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6W51ekiI0ase7Qrbtuuk7sTFULH7al+XCUd0lYQt+0GdC9U/CMw+SfwUBg0GPE9XTWbqpK1JNiqtUX/EOixerg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5042
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/16/2022 04:33, Borislav Petkov wrote:
> On Tue, Feb 15, 2022 at 09:44:46PM -0600, Mario Limonciello wrote:
>> @@ -607,6 +609,9 @@ static void early_detect_mem_encrypt(struct cpuinfo_x86 *c)
>>   		if (IS_ENABLED(CONFIG_X86_32))
>>   			goto clear_all;
>>   
>> +		if (!sme_me_mask)
>> +			setup_clear_cpu_cap(X86_FEATURE_SME);
> 
> Why not "goto clear_all;" ?
> 

"clear_all" clears SEV and SEV_ES as well which as pointed out in v2 is 
incorrect.
