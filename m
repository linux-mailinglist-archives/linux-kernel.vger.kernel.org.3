Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B22AF570ABF
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 21:29:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231853AbiGKT3s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 15:29:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231757AbiGKT3q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 15:29:46 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2053.outbound.protection.outlook.com [40.107.93.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89C3732BB6;
        Mon, 11 Jul 2022 12:29:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ibJ31sRTx5Qe6BJpgKTJibiqEHjjuYV96XVyskPT2ipTo2zbuMKhQQ6uFcyCvj7guLOqOGWpeYtKX0KlZ3oB5MZ/CDFwb26Kzqr9wMDVUbatYsqWZFS+2ihGpsigZ7roVd4tZFnYXjv7t35QdrnUKJmq6870L2v4x4LcMIJrsXDfvnt+446+qNyeGsBxHQJv4Pl4f46IMClSQeCBdVxToKIubMzVCl1pCswq+9PzWRKVhkODz1gR/HC2wLjI2Q6x2cFiUL+IlpT9aSvECyd0XneqOM6FlTSg5LqziLTjXb8DNY40fRoi4OXJWbJfo+jsgMUnneCNUiz/eWIuW50VUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OmhmeUR/OgAEzDMDNh2WUrhuRwtPbLWvwKrcdUw033I=;
 b=Vok0ARmgHxt2BOa/hVFCkeQnTWhJ0aU7MVRHKBrjnoaWcxzN4Eu5AjRUHsrpAU7s8K3Y7jq2kU2jI/PgXzIZEglN5QOrfKAW7PRGKAsbAHegM3ADchYwe09UzovJ3fmP8FoB54AN5nMXxuFmooSHuyzvjnSgW45/m9WCBDXO1JqvQCu6dMUGcWeGFVfvR+xTyzeXS0JHGP77VkC4KWWV43drnF3QEMGIEmnsUfDWO+tqN+T+/dhWlHo4s/OilwkSHCAfXum0gATF9d1xhPtw/lSOcFcuDVauLR6zOrz085F7mVTGomcVSKLtkBq7OAIYvm6zQcKXxj7aFsCbUpm2SA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OmhmeUR/OgAEzDMDNh2WUrhuRwtPbLWvwKrcdUw033I=;
 b=suqH8XRboPBFtlqGqQGDmH+9de2asWWPTXd/6WQ7C3iItcGqQwd31AKQtuI4ro/2pOStS17Qq9WBfZmMPHknqkwKyMfGjZ7ZFhpPfH63bWvli/frnhhNQxBcum+hJZG9dBg9jvCdbBSK1SNKw0XYD8RsXNN57a74gW/8uRac0hE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6222.namprd12.prod.outlook.com (2603:10b6:208:3c2::19)
 by MN0PR12MB6004.namprd12.prod.outlook.com (2603:10b6:208:380::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.26; Mon, 11 Jul
 2022 19:29:44 +0000
Received: from MN0PR12MB6222.namprd12.prod.outlook.com
 ([fe80::ec96:60a2:ca21:17d1]) by MN0PR12MB6222.namprd12.prod.outlook.com
 ([fe80::ec96:60a2:ca21:17d1%3]) with mapi id 15.20.5417.026; Mon, 11 Jul 2022
 19:29:44 +0000
Message-ID: <4df9485a-4947-6f2c-e3f3-89ff44e12113@amd.com>
Date:   Mon, 11 Jul 2022 14:29:42 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v2 14/14] cpufreq: CPPC: remove the acpi_disabled check
Content-Language: en-US
To:     Perry Yuan <Perry.Yuan@amd.com>, rafael.j.wysocki@intel.com,
        viresh.kumar@linaro.org, Ray.Huang@amd.com
Cc:     Deepak.Sharma@amd.com, Mario.Limonciello@amd.com,
        Nathan.Fontenot@amd.com, Alexander.Deucher@amd.com,
        Jinzhou.Su@amd.com, Xinmei.Huang@amd.com, Xiaojian.Du@amd.com,
        Li.Meng@amd.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220709142032.837089-1-Perry.Yuan@amd.com>
From:   Nathan Fontenot <nafonten@amd.com>
In-Reply-To: <20220709142032.837089-1-Perry.Yuan@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR03CA0307.namprd03.prod.outlook.com
 (2603:10b6:610:118::8) To MN0PR12MB6222.namprd12.prod.outlook.com
 (2603:10b6:208:3c2::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bf975f19-bb1c-4191-74a9-08da6373b53e
X-MS-TrafficTypeDiagnostic: MN0PR12MB6004:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zvUHzgIrDcqChHeI5BgMBsA9zTauNMSofsS7Q5hrqLmhWQnqIT9B14aZuoI5upaU/mIN/nKrVmxY8eHpr/izlvEhUvU18d95D1R2wrFjF5xnQna9I+ocQ//dC8zSPqVf/myJ1isXpMuGlcDMf9KaGM21QYZzdr0iYD0E/se8M1xv01qSsa+IRivGlpnIAc4u6cRzgTZUrV8sm8M0BRH3qcm0zHoUY4Cw3EIons3K9mprOpp5fzzDhZ4Pa5luYMqUN/FneMuUI4hICQnwZDv8dOg0/LFhbtIMyEtdPGGmgJRPCrEZQd2nQZjiaoxtTJSoiXf1B3APvnZLXTIpOFgmHv1sUnugVSTgG/V9HUrueJSdY1V5E6JygN6m8hyfZ6XcWKlGLikt/xdwHXAz3vVXCiv52tbM7l8reXkA6NJaLoIRwxl6YarPwdlolcHQGXQVReatmHrEWnz7W7P9O0IDJFYXQtSERA0QGRTuwhkKnCwStMMwyHNm8m7sRwnwiqXHYJqEem/oPtAh3JBrpYD51q+OnW3gG9ak+wqIh66yvrNnti8YpSynz91OGv9pz//erjmnggeI8z7eK6zCtiOe7pVz7qDOm/RRNvyq2xjw+lYL6vnIAsQ8KCvWSX1nGBIMxKpkeNabIP7l76fHvHHZ/GgMqpcBOqkCIJp2au5XL2YimU/n3J9VLAGdkfBajBrHVV9FROX6MoxJPLZOYF6nalAwavwCCw7SNbW64YDS2fTURhja7keEKwFLaiXxwmDKFooYYtFA+HNGWQtGzb3czGS6zYCUOt7I5qJY4FWxtYT7oF8Ti/jLlCEo8GN9VG2W3WvzmM95FGu9d6iQZba8Wo05yKl98sm1x8BQDIpgMiU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6222.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(346002)(376002)(366004)(136003)(396003)(66946007)(5660300002)(4326008)(4744005)(8676002)(66556008)(66476007)(186003)(6636002)(36756003)(31686004)(478600001)(31696002)(2616005)(6486002)(8936002)(38100700002)(6506007)(6512007)(2906002)(41300700001)(83380400001)(316002)(53546011)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VHloTkFadFIzZUdYVFVzN2c4ZU5ZbkRyR2pOdUJMZU92YWdMMFEvZjN4ZzdK?=
 =?utf-8?B?d2JnNG5wVFJwanJPOWNJemxTMFJueTd5aDNyR0Y5dEdWZmlYcHBiWnBzS0pJ?=
 =?utf-8?B?bGNRS1lwc1h6TnI0RER1c1FzQVFacWdHVlA4dmpsN0dwVGtsRUpMUnYrVmVZ?=
 =?utf-8?B?WlV5aU9UdDBrTzlHWmZZNkQyTmEvd00zbDg3aDU5N3lQeE1wRzRHRUlRM2Nl?=
 =?utf-8?B?QnhNZDVoamJBSXpiSlVsVjdXZjYyS1o1OXN6eHBPOFN0WnJuTStCbGh3ZU9p?=
 =?utf-8?B?WE4zcDRBN2FyTzZmK010ZEladjFFM1pCUjFYY0I1NitKcW0zUDdhaFBEbFlJ?=
 =?utf-8?B?YndFUkZkc3ZMWXpzMzBaRWEvUitEM0Jud1F4czI4UHBkRDRGcStPQnlESWpu?=
 =?utf-8?B?UjlnaHRGZldxR3VRMTZSd0F1dlpVTGJhV2Z3VW9pbUFuTjVXN1BkdTFWTWp5?=
 =?utf-8?B?Tlo3WE9id0J2ZWhwVnNnbDU1Ry92Rzd6TVRwUG1uWjFTbG0rNkY2clFCd1k3?=
 =?utf-8?B?NTBNNmxwR29WS3JkM2ZXV25yL2o2Vm52dTZGUFZ5a0NaejJyQk1mTHdIeFpC?=
 =?utf-8?B?UlFXeEh4VHRHQm4zK1ZpR0pyWHJtNk44QzJ6Tm1LSjl4aGNGY2t1dTVrL2FY?=
 =?utf-8?B?ekE5N01NSEF0UytvendEeWRRVVNzeFpXSmx2ZEpKS0pnQi9ENVg3YllTMkpF?=
 =?utf-8?B?V3RrTHl0cncwQ2w4RWZSZXFWd3NYT2xwL3JkN3VkQ3BEZGJaSitNandnYWdl?=
 =?utf-8?B?UjdtN21UUmFJVUxLY3g5UG5qTHo5V2ZOc3hHbE4vV2ovSitvNFNmV05Wb3dX?=
 =?utf-8?B?a0d4ZE1tMlZmekFtNHhxYUl0SGFLNWt2MDl0M2xXY0J0RFJ0RWZzNk1ESHhG?=
 =?utf-8?B?SXpNMSsraHlFZXRieUtPOGJ1bGVtQVZpOW5NNWNCWHY3enptaTB3UVVSOWFr?=
 =?utf-8?B?UHFWQkprNVlLcWpEM1FHNU9rUmcySGoybjhnYWhPTjdPbGljbVV4Mmx1V2Vx?=
 =?utf-8?B?SFlnTGRSc29xUEwzSXIxYWRRNTZ1WFZEai9LTXkvTm1BVG5pTHpjUkUxOWd6?=
 =?utf-8?B?OUpiVFhzK1J0S09xbWxTd3ZOTHFXL2FUWklwT2RzMzF5VG5kbHNhWElCTS9O?=
 =?utf-8?B?N2VQUlBBU0lmOHFIbUxONkhhUzZWMC9hYktMZW9PWjBCUzlWYTJkLzdOTGQz?=
 =?utf-8?B?cm1UVlhXRW1EV09taUNiQTl4WnJIMklUZ2pLY2dLaUJleDBDckQ4cXpnODdh?=
 =?utf-8?B?Uk1VSUZROTJSaXFpM0RmMEU3bWRYaHlBK1p4TFNmYnlMVEZ0bE9hVHZZWlhv?=
 =?utf-8?B?WEJVN1FiSERwLzlRVzVPVXhQUDAyRVI5RnNCZjlzRGZzVTNMM21uMVRySEdY?=
 =?utf-8?B?VnVXRTd1T2RKTk0xVW9NS25rVFBsdjNNVm5MOHpXNlFFWXIvMW1kSVFpV1NS?=
 =?utf-8?B?U2RxY3g3OWZPYTlDSEZXb1YrcDBDem5mdjJ5d1ZmQ0xjdTVEbWZNMmtYdnFV?=
 =?utf-8?B?ZlNaOS9HRHlUZmgvNDRHdDNyNGx3YlFDSG9NVERlRjdGUVJUY3Fhdmw3SHA1?=
 =?utf-8?B?MFMyVHNDbnBRcEZHVDgxR3BRS0Q1RVdIZW43VnkrcURaRmlxNjJLWUR4ZHFF?=
 =?utf-8?B?TG5KOWE1K3ZUaFduTU1lWEcwM3pUTHpCdUJIdEwySEhiaUhsUEk0cnRxU1N2?=
 =?utf-8?B?bFY3YVVwTTFiM05vdDQwTUgyM29Hd1ZiZjRhdisxZ29Hd3FZNUhkZkppY0hq?=
 =?utf-8?B?cnk2MFN5WjgyYkJZajRQc0JYQ0F0V2Z0L0p6Ymg1UFJVbkMrK3pvaFF6aDdk?=
 =?utf-8?B?SkFyTm0vY1BLL0NsMFJxd2toZEpHQ2RleHpLTTFsR1djaElKU0NnVVdIeU4v?=
 =?utf-8?B?UjlVL0NFWGgvWjVybUg4NGs1dTRtOGZmazh3OXZvZHdZcTFiRlZlTEo2clJt?=
 =?utf-8?B?cmxlSXVZdktOZlV6RG1SczczZXNBTlovb3pyVXJLM0xQKzkvNE1xNlR0cHN6?=
 =?utf-8?B?UmlLRFZpYmdlOHViSXFaMUthL2JQMHlxc2YxK2RqYjdjN3pROHl4TzRkRjEy?=
 =?utf-8?B?bWZ6eVRBbzgzck9tc2IzczFkZ0pnK1VDMlNkamN2K3ZKR1VwUGg5dkUxMTF0?=
 =?utf-8?B?UlVBSlMvd3M5UVZNMEJlRC9zUDg4UHp5V25qekdrQUxoVnNsbloyWlc0eEFu?=
 =?utf-8?Q?Cqn3TAEVQ2gpIlu9MyPG+F7jCvJ0D2hnvW/4AikWVtQ9?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bf975f19-bb1c-4191-74a9-08da6373b53e
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6222.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2022 19:29:44.0610
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: j3vG1m43izPQdyyNUGB0o9K8AdhtU2G6nrCftuRZgYhXop414NbPq6wwKTgAbCzKiF5jfJsd82ZgLWkBkoMUAA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6004
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/9/22 09:20, Perry Yuan wrote:
> "acpi_cpc_valid" function already includes the acpi_disabled check and we can
> remove the duplicated check here
> 
> Signed-off-by: Perry Yuan <Perry.Yuan@amd.com>
> ---
>  drivers/cpufreq/cppc_cpufreq.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
> index 24eaf0ec344d..9adb7612993e 100644
> --- a/drivers/cpufreq/cppc_cpufreq.c
> +++ b/drivers/cpufreq/cppc_cpufreq.c
> @@ -947,7 +947,7 @@ static int __init cppc_cpufreq_init(void)
>  {
>  	int ret;
>  
> -	if ((acpi_disabled) || !acpi_cpc_valid())
> +	if (!acpi_cpc_valid())

Same comment here as for patch 13/14, this change should be part of patch 11/14.

-Nathan

>  		return -ENODEV;
>  
>  	cppc_check_hisi_workaround();
