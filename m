Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C9AA4AF580
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 16:38:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236040AbiBIPhs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 10:37:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235864AbiBIPhq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 10:37:46 -0500
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam08on2086.outbound.protection.outlook.com [40.107.100.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42FF3C0612BE
        for <linux-kernel@vger.kernel.org>; Wed,  9 Feb 2022 07:37:49 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IdR4D2L/IKqnXg75x9tixFj7FPafo9DADgFH4OMFAzOXbTCfPuOHgxN7Rj7Kz8enhQDXkRmlNxe/ZtfhxABAayq1lcVGYp63Rh+a0+fQJUiR5KY9CgCpbjZe/q8qKi4O+x3m5JZUUK//oeBYP+awcUiXCKXx9e6pJCSfPe30mZ9498tEmjjmGFwC/oWR7BpZ3IjT1AzRL7BnY8EtRp8rr/FuAsVhmMYKyscnue37I3eprCK2rhHQdnfPZDC820z+Eo/95fx0fWCEO1QHjj74vTj5L1rByT2mWDcOhCCjNe3zl3BXyYObJrj1oqGlKIfOJf2O5lrud14o1kqe+cTIQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R4Wt9EJZfqJHDbQ8pJy34u+KsH1VdKL3onbGo/RldC4=;
 b=brDOSFrBsAbD5Rcbft6OFFU38pfqDrKlRFb+IOi3ewblGM5tNSgFFLm18e4849FTOo4rOlHoCzZVQCZUj23Y058da4ZBvJQNDcAYh7c9vjNGbLbwXx1H9sgDnkp0BRfq0T7ExQEJAMjFWccePoRNT5F0kYPROGM8REU3bWe25TML8r+mrVZ2OJrObToRPF4yvCdRII2oPlvK1D4SPL5dn++KiI1ZjueZ4QpCL3h1kDY3WlGrYqYmi+Q5o1310e2dJ2FEfHCD1UxSoh5kRxbrJEPCE+4nHns3v6oHlIdfW+f04/fPrd+D2Y3negvEhk5GcB5ZfCVpdzPLrvFSWPydUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R4Wt9EJZfqJHDbQ8pJy34u+KsH1VdKL3onbGo/RldC4=;
 b=we2FgfDzp7U4JYI/8Gcr6q+Msscpw10BNjvYDtsoLNqHrtl4VpBE1wvotF5BOumzSiColG72MZVfqZofJeRqO5xNGnZVxaa3Go+z4TnnXdZZugZ/EZClX9QtS6bNxR2nlybwzFO+VrrPumZyhjy/7JJ5AawMGhdfPiHJHnO9+pI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW2PR12MB2379.namprd12.prod.outlook.com (2603:10b6:907:9::24)
 by BY5PR12MB3873.namprd12.prod.outlook.com (2603:10b6:a03:1a3::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.17; Wed, 9 Feb
 2022 15:37:46 +0000
Received: from MW2PR12MB2379.namprd12.prod.outlook.com
 ([fe80::c90d:9f80:a049:b432]) by MW2PR12MB2379.namprd12.prod.outlook.com
 ([fe80::c90d:9f80:a049:b432%2]) with mapi id 15.20.4951.019; Wed, 9 Feb 2022
 15:37:46 +0000
Message-ID: <26d2f9c1-ba97-8b44-18bc-68b371742b83@amd.com>
Date:   Wed, 9 Feb 2022 21:07:36 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: Recall: [PATCH] sched/fair: Consider cpu affinity when allowing
 NUMA imbalance in find_idlest_group
Content-Language: en-US
From:   K Prateek Nayak <kprateek.nayak@amd.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     "aubrey.li@linux.intel.com" <aubrey.li@linux.intel.com>,
        "efault@gmx.de" <efault@gmx.de>,
        "Shenoy, Gautham Ranjal" <gautham.shenoy@amd.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "mgorman@techsingularity.net" <mgorman@techsingularity.net>,
        "mingo@kernel.org" <mingo@kernel.org>,
        "song.bao.hua@hisilicon.com" <song.bao.hua@hisilicon.com>,
        "srikar@linux.vnet.ibm.com" <srikar@linux.vnet.ibm.com>,
        "valentin.schneider@arm.com" <valentin.schneider@arm.com>,
        "vincent.guittot@linaro.org" <vincent.guittot@linaro.org>
References: <MW2PR12MB2379057ECD44ADAC2BEC971F982E9@MW2PR12MB2379.namprd12.prod.outlook.com>
In-Reply-To: <MW2PR12MB2379057ECD44ADAC2BEC971F982E9@MW2PR12MB2379.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BMXPR01CA0014.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:d::24) To MW2PR12MB2379.namprd12.prod.outlook.com
 (2603:10b6:907:9::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b2f6ba97-591f-4823-4264-08d9ebe21e6c
X-MS-TrafficTypeDiagnostic: BY5PR12MB3873:EE_
X-Microsoft-Antispam-PRVS: <BY5PR12MB3873238DF597833A34ED41FD982E9@BY5PR12MB3873.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xAjhf73B3GrHpi59gzyVKrW7D2QSN+GX0n3nhEi+Ak9XVggn20zjUyu+38ya081Qwt4ER6gFwW2MrGBa7hc2qnvpv+OnDHblG1u5uFnGt53iqT+6AdyxSw1Dr6a5Kc8k2d6sHEyqBJ7OzCKCaG4HeR8lZPombcS/3aIT+5+dYOTaUIWSj2UPy7knHBRlqJNusW9kgtTzuwukJ3nqVBxUX3GNUOP5lJAbU0fw/2T9llVxJ7rRODpg8eecBdo/ZFF1PX1XyeDTfhH/NXXU4ZjK5oP12IVuRoNDur6UQqnncwLiQr8O7GZdoYNzHePsKtKZwiUy0T8C/BOpLXfHyZX3ERJxl5DyIak/5CIIMee8FTxFuHPwX0CtfPHrsQGEAI535JtWcWvA7Tz7XlCCBfGHHTIG5AQtzSNTuddDhKkGJKncmpCzNpMGqZupMMYAjNbjYxAZYaSps07iDAT5iVekC29OdCCe93IwkSXHvdcb3iC5tFvop9FDKLRp03VtOspILFsmWGA0dqJ0sEBiM+TPfzYUikjGyq1S4dofmsSePEHMQs0+nuio+ZD/9sPqKnE+OF2wp+s9YbNi2/H0aO9irqDmR97kgJGT9YxyCZLdAsvTel6lV+2Sj6n4Zm/KfmSxq8cUU4hnOaSq3VTpRqr9TmOJNtKWzBOraSr57mX5kuGKk5XzcGT0nEMGoFz/OzgKXNHOx5JW8OA+hwbELg/5VoPrzWCX8PktWrTdDQPvuic=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB2379.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(186003)(55236004)(6666004)(316002)(66476007)(66946007)(2906002)(6506007)(7416002)(66556008)(8936002)(86362001)(4326008)(26005)(8676002)(83380400001)(31696002)(6512007)(5660300002)(6916009)(6486002)(31686004)(54906003)(36756003)(508600001)(38100700002)(53546011)(2616005)(4744005)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?b0dUek9lZ29FcGNMNEtNZjZ3RjFNcURDTnQva0JUdjR1SHc2STFubnBSTU4v?=
 =?utf-8?B?d05tb2doZS9mVUpRWFJPTXdGVkgwZi9lMEcrSURwbkw5UXFqcUx1UkE4N0Y3?=
 =?utf-8?B?R1lpMU1GNWc3MHdTelNHM0NNdVBVU096eEV0MFR1eUowMlpMQzVnVUhITHhN?=
 =?utf-8?B?Vk8vZTZwSVRlV01JakgzWWpTMmlTR0hmaTY2cXI2ZXFxa0pNRERhSmNiY1R0?=
 =?utf-8?B?T215TE5aMW9TVXU1QmVEL0lYRGlwaCtnakM0SjdjWGtZaVc3VDFIbHgvUFhy?=
 =?utf-8?B?Mys5UWx3OHdrTzFwd3VNUVJwVUpIV0R3YkxIQXJlTlhpeDVqOW5PK1NVeGk5?=
 =?utf-8?B?Q1NKSkFNNGlmZWZIdmZtZXdXZ3hWZFlMNzZrNFN0M1Njc0ZHZnU1Y1Fzb0JC?=
 =?utf-8?B?M0JFWnFlTVJEbDhCWkJSektmSUwzbjB5c3VZMTV6OU1IMGZueUhVeFNzbjFH?=
 =?utf-8?B?anoyN2U2dXkrNGF6cHB0eXlPRlpxWCtiTHlmaXY3aGFWWlA2V0twOGgyYXZs?=
 =?utf-8?B?STFicXFBM0dvMTl4amUrQ2RkSTRoa1E2eTNBbjZKNmJxSi84R2N5a2NaYURm?=
 =?utf-8?B?SXRaejMyL292Ykk5VU5sbWxJamd1N25VcjY0aG1FSFB4YTRKSTU5NFhleTUx?=
 =?utf-8?B?WmdnVDdJZCs0RENrVFRBOE9XRVUrdXAvd2YxOU9OeSs2cjNGTjlaQytaais4?=
 =?utf-8?B?SG1Db1BNRFpYbFlQSHdhaWtHYlJNcWNTb1dYTGt5bjZsV2hkdEZKOEZGRVhV?=
 =?utf-8?B?VnY4aEV4T2JLS1JmdDB6VUM4dVhsNmxnZ3kvTjU5UUFUYm1mbEVhditvclpY?=
 =?utf-8?B?MTJHS2xGYXMvNUlzaFA2NkZrdXNlRkkvZXpZS1B5TlFDOGZ4L1dMWXR1SjNM?=
 =?utf-8?B?bjYyR1ZWa3dqWStkNFVqRFVLSlVFWG8zSmZIY2txR2g4Y0p1cG5JM0txY213?=
 =?utf-8?B?R09ReFpzcWN6cXNFQ1ROcUpzcExTdWpsNTdCU1lvTHRhQzBNdVY1dTRuZHBt?=
 =?utf-8?B?RExyRVFMREZJTElueTd3TEU5QzZ0dGc4TVdtWkZRbWtKbWVBa3FjWnJUSHha?=
 =?utf-8?B?SldMbjFHLyswZjQ3cXNKMEdwdE5sWUsvditXRGp1cnlRUmFtM1FxZlAvTGRE?=
 =?utf-8?B?czdHZUkwakJaSHFUdHY5c2kzSGtjSkptdTZIWUpTNVJqU3lmY0pLdmd4bzU4?=
 =?utf-8?B?QUwzdjlqRmlqaDZQYThxY3F6cFljM09OdkdVa3l0MXdweVRmbzdQdEhydVR5?=
 =?utf-8?B?NmJnRzBUdGJhdTd4RmNGRi8wdTZEdzFYQndGNzRoNEh3OFFUQWh0b0U0cDQ1?=
 =?utf-8?B?SVdtWHo4NkFTN292L3JZZGFQcnpVZWRMcWNqZkQwNEtzNmdaaEdsZjFzUElK?=
 =?utf-8?B?TUtmaEswbVEwc0tSNTB4RjREUGl0eTdkaElJTXpWUGtnVjBlcXpQSUliaHlC?=
 =?utf-8?B?c3d4TWVVMWU1aWFOeTB2SHZSQzhtYkZvaDZ4NndydWNvZ2gwdTgyL2Y5SmxH?=
 =?utf-8?B?WTZ3SEZrdUFVcVVvOTJpbm1uaHZMcXp0anBoZkkxcFZkckRXQ2NaYlNrUnMw?=
 =?utf-8?B?Ni9rYVU4aFZYWFpqTEsvQWNpS0RsS3pkNkxIYm1wajY1azl2SHVjdi9TbGlG?=
 =?utf-8?B?UUNDTTRIdHhjbGhsUldPQklLRlJZRmJUQnlVdUNxODN5UkhvZ2crSUtGRkl4?=
 =?utf-8?B?RjNYdGY3Z2dScW4ySU5LOUpqQW1SdWNYZ1Y3TjNucGdnbVFVQ0wwbEp3Mzl6?=
 =?utf-8?B?blVXamNRSnpldkFoMEQ3dG5UMjV0QzVzcEtyTTc0bVBUTWI4TElXbjJlZVFG?=
 =?utf-8?B?cDAySVROWTIrNVkzazdNUFRlQStwK01pbUluZEp5V0tYYmgzN1BKUlJEb1JT?=
 =?utf-8?B?UWxCYThTaEpaeDRZV3c2dmo5VndMNkJ6WGZpbjB4MFpaYlBMYjFRRmNOUmJu?=
 =?utf-8?B?MUErVFM3Y1A5MkdkUWFGUjgrcnl5QzFDWUdFV2lTRnAwaVhveWx5M0FRaHFG?=
 =?utf-8?B?a2NoaFNVZ05WcjI4NFVtYm5KS3lXaXY4UVU3ZExaSTFaYmtZZ0VoWnFGUXBX?=
 =?utf-8?B?VEZuY1NOSG15eERWdGpYQVZWU0xCU2Q0M3UzV2o2SS9lTWhPM25nYlVqRGM5?=
 =?utf-8?B?eTF3VU1yR1pwVzNRcHdyRFZaR25hZkYzNTg3MmlIRnZsWVJWaiszZDZzdFha?=
 =?utf-8?Q?SWbahPJv7WOMVK4p+ajW5xo=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b2f6ba97-591f-4823-4264-08d9ebe21e6c
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB2379.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2022 15:37:46.0808
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dfWcIkMjquA2foIbWytOSg6Hyg+UeRvPvfdtcEt4ZKy6b3GhZr/Vew0tCIxYxjRmf+yX8ggpGXN9qQHzsDta4A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB3873
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry everyone,

On 2/9/2022 8:46 PM, Nayak, K Prateek wrote:
> K Prateek Nayak would like to recall the message, "[PATCH] sched/fair: Consider cpu affinity when allowing NUMA imbalance in find_idlest_group".

Misclicked on a draft and tried to recall.
Newbie error. Sorry about that.

--
Thanks and Regards
Prateek
