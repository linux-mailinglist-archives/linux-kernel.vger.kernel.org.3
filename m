Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4131E554BF1
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 15:59:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358001AbiFVN7B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 09:59:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357800AbiFVN6f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 09:58:35 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2067.outbound.protection.outlook.com [40.107.94.67])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDDB5DFFB;
        Wed, 22 Jun 2022 06:58:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k+xa7V2WJKSh4WjBVoFzStTQLbgobZxreJafcD80PdgcTnMhhuS8dPQPtOgeLrZv8FrPIG+vhQRMDodxrLW2lnNd33avlKR+RF5F39gG0Y2Z3sS66N988Y0gwpsnKVmdo9YAX1UGFSUnsYCeXrzBeWsez2Hz1fiT6b1kwe8q6LahfE4hzeDRFtbwn+nUjEhHcs0FKZ3Rt2JzHlzAiDIpEenWEFNwL6d+hgOfG2QUkhanmyDtujgg3QhnhsTKR+tOM1c2RtCukrCG5mZxSmmS4MmfP9262d3tt8U3Qq+9PG+AlY02d7FqWucVTeonHMobvHmbUy37Ms5AkssKo9l63Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7fyr5VRSwvevMp4UBL/ZIBYsmkut/bRRvYD0PmM+ABs=;
 b=GFH+LmoxqJWN4mdoq0DG0sw2RLjwDKFI+XvZVgXF43uFR9CeyuPw5ai1WX07+eL5Vys5+y4GqZ7bxxke1whQ0F1KSWmGf+5Fdg6mUPRYZPp5vakX8cbaYjYE8YVNQ2bs2IHIQ6g9tszXAn6kJspoQMM3USvhySBlIK8Yg/6ai6SD4vGtOfx66XaDyKMEVWXlF3BwVvemhQZl9+0gnv53/N3xsqhXB6lenGTkVEeycjWX0yFgYdC51jsgqeZyACANob00DLqtQuqWabLEnlwBJWiBn38W/+G42p9L4wqUi1O+PJc0iKdl1NRPnZkRfaDeygVa5AZPqPUitZJncFseTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7fyr5VRSwvevMp4UBL/ZIBYsmkut/bRRvYD0PmM+ABs=;
 b=QSSkNTv0x15BX620XnbRvmsYlPlBASNs8GhOMqnnmeSMZgLYjw6Z+5Xm6wHpW9qf6FJpIlmRzDXSkfO/yYRuw68HTI7Hq7fOCLEpJ6zxgUHT+ZC7Ur/nh2Wz1lH6nd04iIYoZ2Ek0b/ZXg8a7rN1NUCJqwLmHQ6KowYoAK7xGtSv5JSXd2CB0CzcdwZdaoORbc+XdwYCADQHpaVoM8nTt52xN2pKFRqowUhAi9hlxMZdszmLjI5tBHbJHZVAMtHkRHAo6aY3DJ+EtjFGwwf8vqS1Z7/ANDFijlu0s5uSNIwnkxIYcluJ/NgJt2uOdoA3pwUZVgCQ58EEVT2frB60wA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CO6PR12MB5444.namprd12.prod.outlook.com (2603:10b6:5:35e::8) by
 MWHPR12MB1920.namprd12.prod.outlook.com (2603:10b6:300:10e::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.15; Wed, 22 Jun
 2022 13:58:32 +0000
Received: from CO6PR12MB5444.namprd12.prod.outlook.com
 ([fe80::190c:967c:2b86:24a8]) by CO6PR12MB5444.namprd12.prod.outlook.com
 ([fe80::190c:967c:2b86:24a8%4]) with mapi id 15.20.5373.015; Wed, 22 Jun 2022
 13:58:32 +0000
Message-ID: <eb9558fd-4f2d-4e83-f9a3-86ff5dd51784@nvidia.com>
Date:   Wed, 22 Jun 2022 14:58:25 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH 3/8] OPP: Reuse _opp_compare_key() in _opp_add_static_v2()
Content-Language: en-US
To:     Viresh Kumar <viresh.kumar@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>
References: <cover.1654849214.git.viresh.kumar@linaro.org>
 <2e335a6c263704a8d465bd02896fc5fff0533fdc.1654849214.git.viresh.kumar@linaro.org>
From:   Jon Hunter <jonathanh@nvidia.com>
In-Reply-To: <2e335a6c263704a8d465bd02896fc5fff0533fdc.1654849214.git.viresh.kumar@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P123CA0227.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1a6::16) To CO6PR12MB5444.namprd12.prod.outlook.com
 (2603:10b6:5:35e::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b8718871-ea83-4305-9631-08da54574ab8
X-MS-TrafficTypeDiagnostic: MWHPR12MB1920:EE_
X-Microsoft-Antispam-PRVS: <MWHPR12MB192095D6CE4056CAEE87F765D9B29@MWHPR12MB1920.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rqstaUALIMwbR2xTKUZxJUEzIWMVN3smFfc/MIWky4KZ8v20VhhlOfa5QhTZgG+12VV6nNfIkgM5BfrlXbG5tPqSQ+xSb8U2NpVmcopqw2POEHG10u7nNTHzCv/smEU+Ey8cvZi011nJa+dhm0sNre2myxTAon3Bf1AFkf6jWZszOM55SZcSuSXVkY53s7GSfngy8mZNhCUtXn2yMmW32q/hKMkgHVu0o80kBAiRlGzfXVwKOh+jH/869FQt6Gao6TzVv+mk/x0j97iGirQrZCCKmykJOTWxlpuT8ZSoJLcof4R6brWPQ3v0QloKnza5BRA2BD3SEo88Q6FmVn36vKhSrjKgHmdYhLA1aJyAYBGbZ+pQDHQqXPQL+nB+etCFO1gse7Sx7IFNKXDT459fB7MgDoOXUMvDIY0PnxdNP0zBkq26ZpzCROaW87CQnPITmTnFhYQsv0gs01+l0HM61FjnnCXEpmt3O791RaJvHulIEuYjKxE3Wo87py/9PLuAJZiTdSz/ne+nYMqHw89cV+Fqb09Mpq8Kj4HcPRXFF2l7vE2J6A2zNSTBIDfXkqKC3TPppP8+M6CjyXHRpYwF1zSH4qmTQkjvJdWvO0N3ZgC+c1uH48OEoNIGraPqIxzwgU5BQc99quj0mZtIeTOprVZ5A436QS4WhbppuSf3iWvSKYmCsurQ8UxVubvpgHkriBj5AYjkhd+MliIE1wjibrpqBDuCjrrI8/tRr1Bb7qUpoPDs1nB9y35zOIlRJAj6ZytIaG5WD8T0O+LA9ncXvo7LzJ3+8VticejLgqz1iLA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR12MB5444.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(136003)(346002)(39860400002)(376002)(396003)(366004)(478600001)(66476007)(54906003)(4326008)(2906002)(110136005)(8676002)(186003)(83380400001)(66556008)(31696002)(6486002)(66946007)(38100700002)(31686004)(6666004)(41300700001)(86362001)(6506007)(53546011)(2616005)(55236004)(36756003)(5660300002)(7416002)(8936002)(316002)(6512007)(26005)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?T1RpNU4wN3JuN09pd3VONmY4ZHRnc1N4YmJ6amJnRS9ZajV3UExyd2ZNdjdv?=
 =?utf-8?B?bVZ0bU9sVW1UeUVZakFYZmlxbUlHeU1HREF6UHVJRk1IaUxIUmIySnd2Yi9I?=
 =?utf-8?B?a01oekp2QkhEQ2QzMHNTUnJhVEd5cHY5Z04zeVFhNnU2ZHMwRTBYZ1lnajli?=
 =?utf-8?B?azlqdFp6a2dhRkVwK2RLWVMwTFBQei84WW8zNlQ5aXFkck8xbVRIc0NVcDRI?=
 =?utf-8?B?ZTdrQnhrd1lib3pBbTZhUk9EUEpkdDh5NU9mMEI5eEtTSUF4aFBwYVBJa0xy?=
 =?utf-8?B?MDVEUnRyMkhTOGJRdEhDQlRMYnZpMzJ0bzhYYW9pNlFYNlBpcGg1SU9jamN1?=
 =?utf-8?B?WlVZYXhTcmtjTWVFMzhibkhsNkxlRHJldmNiZkhtNnhxdVYvSDFvdGVwOHdD?=
 =?utf-8?B?dUJabTA1a1NERHoramVKaVFTRktDOW9TengwM2JSOFZqWkdhZ2MwMnVlQ0Vj?=
 =?utf-8?B?YTAwaEVmTmhiU1p1M1Ara01mNmJ6QTdyOWk4RE1ITi9MSi9DSjg2YlpoTXgy?=
 =?utf-8?B?STBld0N6UUo4RWZQR3FoaFZ4MHNqaUxtYjQvR0JFYUMwL3pTTTdSWFl3eGcy?=
 =?utf-8?B?cG51bjlod1VjRXU4RS8rNG13SW5sRVA4enUyV2dWK3JEcnhaa2U5UjArRUN5?=
 =?utf-8?B?dmw5L0tMSkpVNy9iZlEyWjYvSXdFYnBFSHIyUnFsZ0ZEY1J6Y1lLZWVUd3c3?=
 =?utf-8?B?S3ZxL3Bqbkd5aEV3QVowc0hUZGtIZ29jUklQK1dxQzN3Y2o2dy9VbjU5Yk1P?=
 =?utf-8?B?VjhsR0U3cGRUUGdwdjhrTU1lRFZFOHQxcmVHcTY2MDl2R09Nd2tJS3JZVHA3?=
 =?utf-8?B?akRsMG1OY0sxQk9XMndHblBGQzdDK1lMNUxHbzB4dDJMZFY3eThNZEhUb2hX?=
 =?utf-8?B?bTdwcURkejU1ak1ORUxpbEhQOTE1ZUpSMjlxcEJvRnR0Tkk2RGNqdVVpYTF1?=
 =?utf-8?B?N05yOUdzRTlOS3FrWVhNUWxMV2VDUVFJTDdLNDIyMER3cjFsU1ZnbmU1dlBs?=
 =?utf-8?B?UWd6Y0tkVVpSR2czdlF1ZHFhR21BR2phNnA5ZlBjQzd0Z0YrZTJ6dTNlMHFD?=
 =?utf-8?B?cllTY2lIQ2dUVnI2cDN6WXEwWnc1ZzNySlQ5d29Ud2FWYkNCWlpsSVU2WDB1?=
 =?utf-8?B?N3BBbEVvampFdzF2c1BwZmFQdVliREhReFBqcnh0cmIyOGs2Q0l6R3M5bVVX?=
 =?utf-8?B?Tm1YWS9Qdjl0Y3lhQURiUGxuTys1bVd6UldrQitHalRMODlWaWRSYXlWUllM?=
 =?utf-8?B?Q0Vzd2xicjZFSFBLSTN1SkQzcU5DN2tlMDJLRVE0UWhTNitWNG5mUEdKdjUr?=
 =?utf-8?B?UmMrYmVHK0doZDRDalhqYXliZUU2dEVtZmZXVTBnMng0M0RjK3RGM3poL05x?=
 =?utf-8?B?OFkzSDV0dk1lMitSQWh1aTNSSHVSdklhTmxndHZxK1hCWUVBWDNWRjJ3UmV5?=
 =?utf-8?B?OW9BUEMwais0dWR6QVVrejB4T05wREQ3M0ZoRUVEb2E4MitwZlRWVWFFWnd1?=
 =?utf-8?B?MjlldkVwQU9QeXJ5bjNJR3hyN1ZGbGVYZ0dyRDRxQ042cEYxSnBoQktPcHIr?=
 =?utf-8?B?UXdFNDk2dUtGaUNjVU90b3lYdTVXN2dtSDdVTVBtVUNOZzBvNlFFUWQzb0Iz?=
 =?utf-8?B?SmlmWlJuMUlYZTRPNDBMd0ZadXBDcm5kVVhDYnRPRW1CdjRXVlRodlZPeWU2?=
 =?utf-8?B?NnRtL3dNMFgreE5ZVmRNd2RhQ1BsMklIYVhpSXFxaG5hR2tuZGxmNDk5eHll?=
 =?utf-8?B?V0twWjByamdFdG00RDFnUG40R25LWmIvR3N2NWZXNXdETzMyenlJQzVnRzBI?=
 =?utf-8?B?TnFRNS9ERDB4REY5dnE4TjM5Z3NrOFBWMTBBWWJKNUpkUCt2Z3VENWJhVDlY?=
 =?utf-8?B?bnlFMGxuQ0dIdkVRTk5wUVdhbzBWY1NwSkRocXlkU3BXb2EzWlR1TGwvY0cr?=
 =?utf-8?B?WHNKYjhlYWVuTERXV2FmYjdkZXo4MVZHL3hCaHBwN0hISnR0NE44Ylk3Ny9N?=
 =?utf-8?B?eUh4czl2bW5VOUVKdlhrQVYzQXBnWDNhOUtlTElXV1p1eUpYeVByS21YQWg3?=
 =?utf-8?B?SGYvMGVIbGdTZDlYZHk0Vm9vdFlSaGUrMzN1TXJQMHhPbCsxeW1NRE5SNU8x?=
 =?utf-8?B?cSs3cy9NaWZNU1RTV1pBYWxVNFJmVkxrcjNmYmRoZUFyRm1DNlM3TFhmYm9y?=
 =?utf-8?B?M25La3o1TksrRTFsZjhTSlo1UHFSMWJ1eHI0TmdmVFdaSGdidnY1UTVlaUJE?=
 =?utf-8?B?U0lrZk5VdXJVTWFIcVdmRUZDdFEvY0MwSExKeGY5Y1lpU1NnMytnejgwZURv?=
 =?utf-8?B?TmJ4eGcvdSsrcGtmVWhteDErNGVJRndlYVZQYWhoTlpuSE9BTjVVOGJqN3A1?=
 =?utf-8?Q?jcX3HiDydh6m2lIk=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b8718871-ea83-4305-9631-08da54574ab8
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5444.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2022 13:58:32.1657
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SvL4A8p98HliUdO2k4F0K6MLVE5qWF8mX+ufpnK33Cvm3LUiL0o7xWRuqIGVRajwk+dDZ0S4kgAfYyUZri5lJw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1920
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 10/06/2022 09:20, Viresh Kumar wrote:
> Reuse _opp_compare_key() in _opp_add_static_v2() instead of just
> comparing frequency while finding suspend frequency. Also add a comment
> over _opp_compare_key() explaining its return values.
> 
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>   drivers/opp/core.c | 6 ++++++
>   drivers/opp/of.c   | 4 ++--
>   2 files changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/opp/core.c b/drivers/opp/core.c
> index fe447f41c99e..9f284dc0d9d7 100644
> --- a/drivers/opp/core.c
> +++ b/drivers/opp/core.c
> @@ -1618,6 +1618,12 @@ static bool _opp_supported_by_regulators(struct dev_pm_opp *opp,
>   	return true;
>   }
>   
> +/*
> + * Returns
> + * 0: opp1 == opp2
> + * 1: opp1 > opp2
> + * -1: opp1 < opp2
> + */
>   int _opp_compare_key(struct dev_pm_opp *opp1, struct dev_pm_opp *opp2)
>   {
>   	if (opp1->rate != opp2->rate)
> diff --git a/drivers/opp/of.c b/drivers/opp/of.c
> index bec9644a7260..843923ab9d66 100644
> --- a/drivers/opp/of.c
> +++ b/drivers/opp/of.c
> @@ -929,8 +929,8 @@ static struct dev_pm_opp *_opp_add_static_v2(struct opp_table *opp_table,
>   	/* OPP to select on device suspend */
>   	if (of_property_read_bool(np, "opp-suspend")) {
>   		if (opp_table->suspend_opp) {
> -			/* Pick the OPP with higher rate as suspend OPP */
> -			if (new_opp->rate > opp_table->suspend_opp->rate) {
> +			/* Pick the OPP with higher rate/bw/level as suspend OPP */
> +			if (_opp_compare_key(opp_table, new_opp, opp_table->suspend_opp) == 1) {
>   				opp_table->suspend_opp->suspend = false;
>   				new_opp->suspend = true;
>   				opp_table->suspend_opp = new_opp;


FYI ... if I checkout commit 00d776d33da9 ("OPP: Reuse
_opp_compare_key() in _opp_add_static_v2()") from next-20220622
it does not compile ...

drivers/opp/of.c: In function ‘_opp_add_static_v2’:
drivers/opp/of.c:933:25: error: passing argument 1 of ‘_opp_compare_key’ from incompatible pointer type [-Werror=incompatible-pointer-types]
     if (_opp_compare_key(opp_table, new_opp, opp_table->suspend_opp) == 1) {
                          ^~~~~~~~~
In file included from drivers/opp/of.c:22:0:
drivers/opp/opp.h:228:5: note: expected ‘struct dev_pm_opp *’ but argument is of type ‘struct opp_table *’
  int _opp_compare_key(struct dev_pm_opp *opp1, struct dev_pm_opp *opp2);
      ^~~~~~~~~~~~~~~~
drivers/opp/of.c:933:8: error: too many arguments to function ‘_opp_compare_key’
     if (_opp_compare_key(opp_table, new_opp, opp_table->suspend_opp) == 1) {
         ^~~~~~~~~~~~~~~~
In file included from drivers/opp/of.c:22:0:
drivers/opp/opp.h:228:5: note: declared here
  int _opp_compare_key(struct dev_pm_opp *opp1, struct dev_pm_opp *opp2);
      ^~~~~~~~~~~~~~~~

This breaks bisecting -next and so would be good to fix this.

Cheers
Jon

-- 
nvpublic
