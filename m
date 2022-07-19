Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8056F578F77
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 02:56:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233995AbiGSA4s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 20:56:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229533AbiGSA4q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 20:56:46 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A724DE9A;
        Mon, 18 Jul 2022 17:56:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jB0qby9+sJO5AgKZCoyj4VqbX4x8EkUCwo+t0VjdIHPevblPJ9ForNlYU87DOS62vt1Ygn+Xdq5IUnCPsSpdDn3XbRkfFy4GUSuYffeDV1HOOtfZFoL2E+FP31KwXv9fAqNC/O8AyKcAk6yTVXZgC6dIZmr+gVKkKam1n7Dan1UK2S9RzRNl/VlmQ5JZ/s0LKp8zqstp9bPnXPGr8OfafP7p3EXZKDoo0QNoqGonhB+uFd4UfYcmxr9rgkLbN6K/98IaqyfJHAwx7XSvMbdJqrz/XcgeMVoEqin7vG2Oi2OnxSmVxSMDdZezrir+I0+OgyY5hKXNxDh4A5RBPAjqNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BX8vnWZ/E9ZXKsgOTYz1n2udMGrC1l/AiHslPgz+u/k=;
 b=OZXMe2zETRgUzezOxjZThKExKZgHDBU4dsu+HbwN+mN2kFz45C+eBlpBPuWH89ICoEr0S4GjU5/yC4cCQV9n/Kg1zKyaQ9w4EX3dmLjVqsbWeBs3SPqoGTbamHrUckrnQ/Wwc1uXXYbl6z4ERSS1Zo738VrLrLE6tNhR0FRqOI/osevd/5L4ip2hC/hpTCA3fbJh4zblF5aVzHIhcYMb8wMB1sFMxyrZmB/7Uui1uOie7k47THH8Nf4NfpyPCDDqaizAfJ2kzd0ILE19R2iKEUIXAJQhs040wseE7RClFkRXIYWJZCLHKPPR1LLgoVFmfMiJAjmYsInSfunMm0AEWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BX8vnWZ/E9ZXKsgOTYz1n2udMGrC1l/AiHslPgz+u/k=;
 b=i02wP7QG2s7UErx30n/KHLXd0YbcmHHcfoJmyDWRJ2IMDLKNjIcsZCMghndgz43g2pwVS0I/RQWMshCTRd2TvtzjuHK7/iQVduus/V2mv/qi6XdPAmxZ0I2O8J71vjEhrpRkx7i/7LhCiWGlCeOBYIiupp3BiIbipKLIi+W/Cdc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB2504.namprd12.prod.outlook.com (2603:10b6:4:b5::19) by
 BN8PR12MB2850.namprd12.prod.outlook.com (2603:10b6:408:95::25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5438.20; Tue, 19 Jul 2022 00:56:42 +0000
Received: from DM5PR12MB2504.namprd12.prod.outlook.com
 ([fe80::ec80:e3fd:e3e2:605d]) by DM5PR12MB2504.namprd12.prod.outlook.com
 ([fe80::ec80:e3fd:e3e2:605d%5]) with mapi id 15.20.5438.023; Tue, 19 Jul 2022
 00:56:42 +0000
Date:   Tue, 19 Jul 2022 08:56:19 +0800
From:   Huang Rui <ray.huang@amd.com>
To:     "Yuan, Perry" <Perry.Yuan@amd.com>
Cc:     "rafael.j.wysocki@intel.com" <rafael.j.wysocki@intel.com>,
        "viresh.kumar@linaro.org" <viresh.kumar@linaro.org>,
        "Sharma, Deepak" <Deepak.Sharma@amd.com>,
        "Limonciello, Mario" <Mario.Limonciello@amd.com>,
        "Fontenot, Nathan" <Nathan.Fontenot@amd.com>,
        "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        "Su, Jinzhou (Joe)" <Jinzhou.Su@amd.com>,
        "Huang, Shimmer" <Shimmer.Huang@amd.com>,
        "Du, Xiaojian" <Xiaojian.Du@amd.com>,
        "Meng, Li (Jassmine)" <Li.Meng@amd.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 07/13] cpufreq: amd_pstate: map desired perf into
 pstate scope for powersave governor
Message-ID: <YtYBM17yO8X66Qva@amd.com>
References: <cover.1657876961.git.Perry.Yuan@amd.com>
 <e6fd9622e2316cb32a39f8ceb8102336cf79a37b.1657876961.git.Perry.Yuan@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e6fd9622e2316cb32a39f8ceb8102336cf79a37b.1657876961.git.Perry.Yuan@amd.com>
X-ClientProxiedBy: SI2PR01CA0031.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::11) To DM5PR12MB2504.namprd12.prod.outlook.com
 (2603:10b6:4:b5::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 45e1c339-2436-4c1c-1e10-08da69218b74
X-MS-TrafficTypeDiagnostic: BN8PR12MB2850:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ro5OoOTxdIHc+iXNRKKSm7dGnHgTBQVhZK9BTUKJEoEMMDFrSCZ/vcWLNIWJAQ/vU9nwAuk2hr0c9R9ase3E/1p5/rIWzdwHq0YMOD863alldUTtmnzoU8cgbdJdLeRl6EWtis2PSfFmPcOFH4U5b0Iw/KX2AfTUQCZWOwynbICh31fuXdWB2WMYAoDVpB45X/5RfbAugTOSGMdTottvHAGNC8aAlb508NOmbXk8Q1PFu3jp9HxNouwKjdoxTtw8VWB0m39Ykfbk22EBSdk/75Cocy2LkYIl3+mDdLgcAWJV/CpcV/Rh37SnQtQwKa8F2oC9XQbQZxgKWdjEp4PtJQdqwuYRYAbe9+WTQVseXNHQEBsWD9QQLCey63NNvkUb2kTjgddH9n9Q8grCwz3wCm8KM1cFBaad9Sm9wavwiOc0XAqlWzX1cyANs3a3WoEDwQe4AynoTjrXGFtyNrESJhEDXs/c7qgUe2KT+pPVrBXL6pwpUEA8Gr9fEeiU1OGapa0Bpci2tAZMiqB4lynjK6hAKuJb2CTG2jmlKVikeCEiN5W7SnJ29MYAMzrJ2A8xFvFfm9/W8BJm8HLYKBVW796ZA5pJf8nkWpWwSs/Q/c8sTglOL188FmlKzjJQYqLZfl4E/aSBNKMxvYwFCfeLjzp1Gi9QNrvql7Crw+objV3I6KEd+/jIT1BBIHz3X67uLoc6wk6zpAu3RTp8MSPDsJdK0RhLsHhZbhRlKIgZXMXWXUYEYB3Iu08IxK54sWjx
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR12MB2504.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(396003)(136003)(39860400002)(366004)(376002)(346002)(4326008)(54906003)(37006003)(5660300002)(6636002)(66946007)(316002)(2906002)(66556008)(66476007)(6862004)(8936002)(8676002)(83380400001)(36756003)(38100700002)(86362001)(6666004)(41300700001)(26005)(186003)(6506007)(478600001)(2616005)(6486002)(6512007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?3ilVOJJbtMGkL6LJQ4YPuG4H0DUhTpRgV+G3zC4zsaKtvG/MCErUU8dcmSD7?=
 =?us-ascii?Q?S4WWA67ppORKdX//o1FZhbldJ7qdMK5Wj7FrkczFQHhYC+e5Grwaz52C1MWp?=
 =?us-ascii?Q?yig55GB+qO56w19XU+j8dPVw50FdoCG1cDoNo7VURFo5FEZQEgB3PC1IlUcE?=
 =?us-ascii?Q?KpIMsYnCylb02MEX/dUP2ScTKg2fa58LXON9JtoO9pCZEkfSyiyvkAy6ISGX?=
 =?us-ascii?Q?dBAEFe65b0Ju/JYJe1Nur6PB8XdEMMkjE+zkPshyOCnJdy0oYsvc8MXFm5n0?=
 =?us-ascii?Q?X4RqqLOsvIJ+lZf9aBo46uqQMhzYc18v50TTEyd/GwFZRJndFfruB6Zyh0H9?=
 =?us-ascii?Q?PWCa+iOCv2VYHL7dT0xihOO799J4TQdCXK1Zm24wYbt7lVrxDi4cj30Q1v7r?=
 =?us-ascii?Q?3qV7ew7mx8azXIjOJ9QeZDKRiWo805mUNq2hjQc5KN01P0r5lvd3V4FcbZ8n?=
 =?us-ascii?Q?TPf1xE2b7XX8mLtca5G5i27jV6VdhZeXhFYgRrNa2QkZhPEtFAe3u+t/xum7?=
 =?us-ascii?Q?akHhPoYLrw/E3Yqi2l5pPyWPijoGZiZQBqRqmQy6qlPdQmKx/weeFrXsJEBo?=
 =?us-ascii?Q?fPvdAWvdCDZvCtuIoFeWUW0QackO3IzYidvKloT/e01rK6AiFDfsYm4tDCVn?=
 =?us-ascii?Q?w2EaHc2ykWR+Q0frX9K69RCqJ4PRB2E49FjWw4C8BcMFx+SkXoQOQ2/9HoOE?=
 =?us-ascii?Q?nXghusHyu+tfAd2RORbDzWzKwl4GN6f2luIw/tI+npsrOFXbJQWSUtDvSS8X?=
 =?us-ascii?Q?8FOR64Befsv/iuLfmbZiyjz83OQFBeBgnKrjw259spYoXZGqOJ8yg/QMJd0p?=
 =?us-ascii?Q?CRHNslSXCSmEXjRg0+Bdy1yTRB0iY20t90OM+8tFY8Xgfh/xy4X5S+7WdT5E?=
 =?us-ascii?Q?uGrhM8/7e6pCKfFYScJJOH1RUAoUimaSj1xlf4QbLJYE2PZDjLjFWlKcvIr/?=
 =?us-ascii?Q?m/xMSakId1gwxUA3PzLrwDgAiCULPn8mEPtdzN+pbxNqSLkDrKPzqYxDKlYc?=
 =?us-ascii?Q?tAU3tfoY16drXzPFd/3fEEnQHvCtpjYNOTRugPc+JIWb/eYmDzQe822bzmNt?=
 =?us-ascii?Q?B8d+xhRm3rCRQbeO2xnw2u+3X27RN+ypF+Y+f6omX2oDsSQyixnfGMnIhT6+?=
 =?us-ascii?Q?biG2Hy3OuWsC7MSYZesfOZPhQAsSXQEBXWNB5Bb5fPLfQiQnpD0zvwAbDRWI?=
 =?us-ascii?Q?vy0FjJCHiI7BIypQ7SmT9KhQm7ZlH3O+QDlgSV90Bb4mRplbdIC5NHwGgj9G?=
 =?us-ascii?Q?oCtqc/wfk4wk2ojJHiN0AmQA5SMa8uSj2o2249pUkeyq0+6V/V9vQ6iQgMtf?=
 =?us-ascii?Q?Eb+cWoGQ3ov9FNGJvIv2g5RC9kuN9HzcglCxorthrOB6/4ED3ScK3UJMXVLr?=
 =?us-ascii?Q?ehyYykKetKxTrVBl0wEbczw+/8TkyjxIEqAwZQ5cK+bWgqIxmD3/YP+j2QnR?=
 =?us-ascii?Q?02q562mKi1GX+iFQi9/Fc0U9682gnllgVISnWigMQzV+5YvDa7K3Gt8N6h7m?=
 =?us-ascii?Q?7nOhWqzS4XUTWVFpWiJ0PTA4WrVBI60mNWTt+0e3iT1JfsnWbGFbeIBqAUmj?=
 =?us-ascii?Q?o0dl/7R8JA+DwXME0ai8R0MEhx2bY4LPTj6oNKCB?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 45e1c339-2436-4c1c-1e10-08da69218b74
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB2504.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2022 00:56:42.2232
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 974pvoELwoM5fAtpaQ3sikJDsb7SryxkdzGLaTwvsiLah2he8eDWbqB/8Krnuu4wOC0b7QIfUGxlZMRCRymnzw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB2850
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 15, 2022 at 06:04:26PM +0800, Yuan, Perry wrote:
> The patch will fix the invalid desired perf value for powersave
> governor. This issue is found when testing on one AMD EPYC system, the
> actual des_perf is smaller than the min_perf value, that is invalid
> value. because the min_perf is the lowest_perf system can support in
> idle state.
> 
> Signed-off-by: Perry Yuan <Perry.Yuan@amd.com>

Reviewed-by: Huang Rui <ray.huang@amd.com>

> ---
>  drivers/cpufreq/amd-pstate.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
> index 4b764870035e..ebc7c6d389be 100644
> --- a/drivers/cpufreq/amd-pstate.c
> +++ b/drivers/cpufreq/amd-pstate.c
> @@ -268,6 +268,7 @@ static void amd_pstate_update(struct amd_cpudata *cpudata, u32 min_perf,
>  	u64 prev = READ_ONCE(cpudata->cppc_req_cached);
>  	u64 value = prev;
>  
> +	des_perf = clamp_t(unsigned long, des_perf, min_perf, max_perf);
>  	value &= ~AMD_CPPC_MIN_PERF(~0L);
>  	value |= AMD_CPPC_MIN_PERF(min_perf);
>  
> @@ -356,8 +357,6 @@ static void amd_pstate_adjust_perf(unsigned int cpu,
>  	if (max_perf < min_perf)
>  		max_perf = min_perf;
>  
> -	des_perf = clamp_t(unsigned long, des_perf, min_perf, max_perf);
> -
>  	amd_pstate_update(cpudata, min_perf, des_perf, max_perf, true);
>  }
>  
> -- 
> 2.32.0
> 
