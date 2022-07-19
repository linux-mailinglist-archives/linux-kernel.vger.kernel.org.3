Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23F44578F94
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 03:08:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236480AbiGSBIX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 21:08:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233670AbiGSBIU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 21:08:20 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2055.outbound.protection.outlook.com [40.107.94.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F13C09D;
        Mon, 18 Jul 2022 18:08:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZgG+nOr+q3pYg/Zu4fb4hdtlCPm128mzXPRxbivTCBauyPALheegQkmXbmwF64IiWSe6U2dTtCobs9h9yRQsNHcDo8TiT82K2lLwZ94rHvXEhA6jclrqT2ZJpxEqh7o/wvmQe6hoWoMxUwxXMSpda6vYo2yYUihKSJYeFwMehLe0WXDintPpBU3zwdDqsbJ7yH/fKP8R+WX+73jqanYoiBpb8SWZLbOFCM4ivulkdKnSA+aZrLiZvJwZVhecqVDkIfj1xiVCVC33SCVRT/KbJCn+TaYdB32Ejw4dVd5+9e3E0tIYSHxwSW9o95fNIih9exgrOXHxp17/uOf40LMKKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mhCRgaBSCgretwY5zy3wseRZpaiwHGF1ZHdbZV3c57A=;
 b=SHcBbga/8yjbp7PGGZzmUZqp6icD4DO8VItZ+BIsuxFmZdEbMry0W7GrDRP69D8b2/FtOV9ZnnXcL2nEEK6qTL5LZ4Lyh4MXTq0+CAf6Axdc2xtr4jxjV5J0hDx9Oag0omoLmtYMMrzd3eJl3ounBROrCk/XNKAe83+13RGX1OEEa3fJZkX57ttf5HnT6CHgprbBm+RvmsCZ4m4dK6cxxQ7U8jucr/LCAsb3riUuPDZrh+UiwFgNwB+iEi7kHrw+xLqgu2Mt8OHiLbTFwmc+F3l/NBhnNgoWTa8aj5zbGCIr5+j2cTurLzuSJlrkzeaNHz8VN6pq5mGLOWDdh0Ziaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mhCRgaBSCgretwY5zy3wseRZpaiwHGF1ZHdbZV3c57A=;
 b=cZp/qkeiqTj/aD+JThoqGkun6I4lYbC/tG91xRGAPnPKaU1DhBegYupYZM4kRXsvyHcgXu6r1ynphvSf57aQ2S8FmQ1Q3H0xgoPD5WkGwVle5ggxiJvRREtIjKPiAcmHioYAE/djJGKyFnwn2P7sFgwTiedLFQg+dVCMNvrbE24=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB2504.namprd12.prod.outlook.com (2603:10b6:4:b5::19) by
 MWHPR1201MB0253.namprd12.prod.outlook.com (2603:10b6:301:52::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.15; Tue, 19 Jul
 2022 01:08:17 +0000
Received: from DM5PR12MB2504.namprd12.prod.outlook.com
 ([fe80::ec80:e3fd:e3e2:605d]) by DM5PR12MB2504.namprd12.prod.outlook.com
 ([fe80::ec80:e3fd:e3e2:605d%5]) with mapi id 15.20.5438.023; Tue, 19 Jul 2022
 01:08:17 +0000
Date:   Tue, 19 Jul 2022 09:07:53 +0800
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
Subject: Re: [PATCH v4 13/13] cpufreq: CPPC: remove the acpi_disabled check
Message-ID: <YtYD6bRaFxby2KBW@amd.com>
References: <cover.1657876961.git.Perry.Yuan@amd.com>
 <da43e5feeb246c02ba4ce6ffb5fbd35fe7bd9f14.1657876961.git.Perry.Yuan@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <da43e5feeb246c02ba4ce6ffb5fbd35fe7bd9f14.1657876961.git.Perry.Yuan@amd.com>
X-ClientProxiedBy: SG2PR02CA0091.apcprd02.prod.outlook.com
 (2603:1096:4:90::31) To DM5PR12MB2504.namprd12.prod.outlook.com
 (2603:10b6:4:b5::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cc1db5e5-d15c-41e5-53ef-08da692329b3
X-MS-TrafficTypeDiagnostic: MWHPR1201MB0253:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YdbQT/GQX/vAIo203twcdDBxoKFzXBTznNrvurKAJt701x2p4LIc5oMGZjgcaxOGqVn4vh3vuj//X3zhvjSreFI5SlN9oP7g7TsfcNBtfsZIdiwkVgiT72kLfH2vJnykVDNOwbtxrQtDJ2cxINRYnJS9ELHt4rscjBL28r7qRMeVgj/E7Gqz1R/haVXPHOMrrPW5D48HUYxT6Zlg0hfP9vm6VjITkeG3+pYgHIUC2QoIOrvZrS57QeCyB3EAnGLK4zJvgsVCdC1+4X8PUbYZOFGIove9ZvN9XEgpVuzwH6btKpXRrSZ+vQlmOwwQVaGuwG+9BRawJw1tNfsxsogcVVmOyrhWKH6w/NBM7ysa6ElVnj1uTYl6xgy9D8LsNs6vDt/8HbVTbS3pOX/K9/ECITrSJSpS8jXEGspQsRkSe9GGBRfTl5rcfW4M1+jHYHeq0n55s9CCcKnuN7nIHg1yHvQPMzDvSWRiejqYJZDqKMWsqjMmlDXfVaOWom3UOHoZE99ybD0RcLFpxiJOV1P8hCpoOGmtdmrciIDbO37JkegPFxlyn0WUsQbNz6WktyLa1QmwUMW00YVjuMvAqVz4d5ZnAiQmpfD4uryOBzh8da8R0cEovJQgEay8iqurAsMepkx6XVVlwqPvVksIYB3vN+UMzUoY+hp4dJczbLSTKCZkjiBWYajdrNrMus3yeMDNIwv/KrmOYBcZShwE8RngjZ2Bpp422wQgNthR8HwdS8Pp4SJnZ+Tr4dIIeKkN26pp
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR12MB2504.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(376002)(136003)(346002)(366004)(396003)(39860400002)(8676002)(66476007)(66556008)(66946007)(8936002)(4326008)(316002)(6636002)(37006003)(54906003)(86362001)(36756003)(6862004)(2906002)(38100700002)(2616005)(186003)(26005)(478600001)(41300700001)(6666004)(6506007)(6486002)(4744005)(6512007)(5660300002)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?iTIqHZ6DJAMwP4EI6siyU88qHLpppXj03TCmg/tflKBAoJYc1s7xR2L4AhWR?=
 =?us-ascii?Q?+oFVjs/UehfROfYEPgTs47fLFGR4yn1F6xiZSKDTVIokIy+rDpUL+ePQYX7N?=
 =?us-ascii?Q?djF82sT9WRWYjLSt/IrH0/f/OJyiN0M5HRtkPQPxMmM212n+VyJ9RNDHiPAf?=
 =?us-ascii?Q?43dUc60Xesb99HEIsRc6crhVCLcM6ru89j17vOAzt5POKPwbdGUq7Zz1PR9D?=
 =?us-ascii?Q?0R8TG70YBwlraMLDQwcpTKgo0s+lJy83vG1p26ymE3bce7EcuLQQWNc806AU?=
 =?us-ascii?Q?XiTA7boc5zw6YBecwlILfMTecK439m7hQLBmC2L9TPA0PAE2NwJs7tmOfgnU?=
 =?us-ascii?Q?3Snse93Qfb18suPquK+ePXLsGgv2mRh9LNJGMd317B9pRr2cX8V2G3bCcs6Q?=
 =?us-ascii?Q?oTft+F0TBAlykU0WehBzVsvDkmdyQCexO2KMHn/QujiiwozAzZsXXG00aJt+?=
 =?us-ascii?Q?C9MeDhhIzbO1jyBqJXGyGadrTjIY0cCznc0R8BnOXoHKPS0dvc08slJjhwNz?=
 =?us-ascii?Q?cLLQVzTdew59ykQVzAbdVpcaWJ7aOs7thPk2bvtLi9W3/E2rgZWMyRbxFK6F?=
 =?us-ascii?Q?gKw6orYku4qx8wtDcS0SGdXQXKNr5iis3ogzwxAsrS8l5W0gsXEe3kW7w7AE?=
 =?us-ascii?Q?SJecsiH1JLqPvrjkU2t9wPwpcDtDcCxGX2j2mGKXDgSncGOt7+7Q0JruNhlh?=
 =?us-ascii?Q?ATLILKaLaJ2bOQHLlTSVH+U6a7VBvLOsQZFVHokLWzAM2BXKjZYXCshUS6iR?=
 =?us-ascii?Q?QDJTNdApVUi05IqBOn2L619N0y3iPgPgyNwzQtDjC2rRYFsAALOXekm74x6W?=
 =?us-ascii?Q?4CCLL/WRj6tYAth1ljclhtzFe7Xefh3/xtR7OrqFymR4Fwlunit++yLwLLeg?=
 =?us-ascii?Q?Y3XaEbuUyTwX5Rqnrm8GDSGSeNDlIyS7aW/QlCOkp7P3eubPZHvVekr0esq0?=
 =?us-ascii?Q?irlf34OF/qebcH77dKiYccPlXziMa89y0FmnSYYgR1pbPRVSIMptzsmDpUWU?=
 =?us-ascii?Q?ufVpv+5ZkUcG2Q48srrU56u7+gPoTBusvxQUjGF9/G8dchNnEbLTOnJR4CTe?=
 =?us-ascii?Q?P1HC9YY9jT7QKaCvRD+vatuWf7nLtJSoTjWisySKM+yydWf0amK2oDflZ/8s?=
 =?us-ascii?Q?BTJfdQOe6fOVGmvpOiFRvoO5eb9u8uVY4rvNbzadcFu2Ql1ym0GRh374yCK+?=
 =?us-ascii?Q?oqk+qoUlk+HCH1y/SC9jzEw814DWh3yVa7PizTz0rptU60alRzPrHIqvWK9o?=
 =?us-ascii?Q?bWlGSzVdY1JHy8D+ClPdAF0vMdWu0bHExsXwp0LfkYcZjNEY0z42TqMNDUMG?=
 =?us-ascii?Q?pPwcGIDeW44wPAunNjsyfZlg5eLja00wnyMYwW2Z8iq8blxg2HyDxkXlRZi1?=
 =?us-ascii?Q?0UeT5B0GiiWS403idQ5m6lksQ28iXYbdZVjm35TKJ2mYdC44kk7B2XQAZxkj?=
 =?us-ascii?Q?m1kNxo+5aZR36s3tNuTbLAQBTvFRyD+lytQpnNjPVBWRDCP0YCq+ec2AuBKf?=
 =?us-ascii?Q?KE7bffoojM8Mxurk3zYai50wZABw7fmZwjCfTIupB15CRS65+0oU4tkSGlrg?=
 =?us-ascii?Q?S74pxnTJu7GKjwLQc9byGFHajls+4NQ7wvDOkie+?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cc1db5e5-d15c-41e5-53ef-08da692329b3
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB2504.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2022 01:08:17.1830
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wihGuIleXO+05eo2PuYBWRgdUTbbT0vjF0Nae0M4FnlmX13LHjLpTvU9Fn9yRn6opRbiekCw+ILzMBxx1eHZoA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1201MB0253
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 15, 2022 at 06:04:32PM +0800, Yuan, Perry wrote:
> "acpi_cpc_valid" function already includes the acpi_disabled check and we can
> remove the duplicated check here
> 
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
> Signed-off-by: Perry Yuan <Perry.Yuan@amd.com>

Patch 10, 12, and 13 should be one function update to move the
acpi_disabled check into acpi_cpc_valid(), should we squeeze them as one
patch?

Thanks,
Ray

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
>  		return -ENODEV;
>  
>  	cppc_check_hisi_workaround();
> -- 
> 2.32.0
> 
