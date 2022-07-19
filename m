Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A752578F69
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 02:47:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236386AbiGSArD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 20:47:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233338AbiGSArC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 20:47:02 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2089.outbound.protection.outlook.com [40.107.237.89])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EAC327FDD;
        Mon, 18 Jul 2022 17:47:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YE9Mwd21sbvPAlnSAsAb//sgu322Wo1ZlGJ9Yo5ymieN5/3tO2o5PSp3grZKROr0urw3r/cJ6v2muq7J5BS8FvilWAM/P9lo6rk/I3XwrdqMEzTpzXeu9pAJzNeZmWmuGHM1akUp3EcUav1DSZJXXcxSgll+nYuQ0dBW6thw4b49PogBeeRETBae9oeyhFnYHkUjigubAycVqToL+VXAIWfJdTOed32zGM+ift96zHw9rMIFEMb/g8UN6tl8YzPELVMlPdg+OOCfByKZpIVc4KhJdf90ySU5JmPgBRhHzQwPkFmyYZOA0xCCRmg+ek3ykQqwIBeKr0tlLDnCESz1Yg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f9ETuGCOXvyeStNcOToLiS+FmeE40IoqKwf9revQ04w=;
 b=Z0UJxHm7hOdC73mqB3t9ZGD9vAc5SToCtw518ja/W/3b4eMnSTLei5m6vTcP9iQBUE/Cq4N3o4wc7Yvms+/je0lRDU+y6IFOuOPLaWMKp7GsgyrF94elgn2p4iWAvxPIRjQZ0vBJhXqzlYfUY64OK6Lxn7L0xiIgK/CfmSHNYZLDovIvU/GdCiYE3zNRof9Y9309Ysn1zPequP94nfq5i4W2P1HD0MpQbLURKeRunh18uJR5ynh62i20xGHvBKDhLWAtIrceKOnZpjhVWBihWEIYcw4xNLLHNUFWuO1WGf4/9gPYEWo4ay32h6ZGwh58LHa0cEhGSFcdKinufbsN4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f9ETuGCOXvyeStNcOToLiS+FmeE40IoqKwf9revQ04w=;
 b=hx/OqBH99fWURFavUQHZ+fjVJXHS0tnalgZfa4qieI2q6pTKCQaxi3Q03TSF/Ri6jcX2yzTPuOMJLO6/xdvkV22jEh6dW6m4fQn6A8NduXXSYwJbs8q5T3J4Tz+kN9rQnCwUADi3ZUh8nU4myUoozIL8BfuV9XHnPu6ODddMn0w=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB2504.namprd12.prod.outlook.com (2603:10b6:4:b5::19) by
 DM6PR12MB4826.namprd12.prod.outlook.com (2603:10b6:5:1fd::30) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5438.21; Tue, 19 Jul 2022 00:46:58 +0000
Received: from DM5PR12MB2504.namprd12.prod.outlook.com
 ([fe80::ec80:e3fd:e3e2:605d]) by DM5PR12MB2504.namprd12.prod.outlook.com
 ([fe80::ec80:e3fd:e3e2:605d%5]) with mapi id 15.20.5438.023; Tue, 19 Jul 2022
 00:46:58 +0000
Date:   Tue, 19 Jul 2022 08:46:34 +0800
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
Subject: Re: [PATCH v4 03/13] cpufreq: amd-pstate: cleanup the unused and
 duplicated headers declaration
Message-ID: <YtX+6kOF3ERNoLhN@amd.com>
References: <cover.1657876961.git.Perry.Yuan@amd.com>
 <6fed848fc6694074ceca16a9a45e4084fa33b511.1657876961.git.Perry.Yuan@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6fed848fc6694074ceca16a9a45e4084fa33b511.1657876961.git.Perry.Yuan@amd.com>
X-ClientProxiedBy: SI2P153CA0019.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:190::10) To DM5PR12MB2504.namprd12.prod.outlook.com
 (2603:10b6:4:b5::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f20b042d-87da-46ab-4191-08da69202f8f
X-MS-TrafficTypeDiagnostic: DM6PR12MB4826:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aFiuzJLQIt8pDtImeKM+eq4Sc7J1S2or6PkRBt6H49PV6+bl4dLlKxgiJJ0PQ6hXL+kclPaJwyJERgFvnWzo1zRiBR+C+w5CGO1+7M1nOZlYLQVhnAfW8SxmTQ4ZCbKse3ClITC6TC1e4UTdPYwOlPI/ejEqE0uVE/BxTCa7sjHqfsV+dmno9oADEHuIQKRPlPxZcYIHT/5RmZCus4hpq7mDILuWMjYgpYVPE780Zsec948pAh5kK3OE4Sh4lRBOli19GVEVPC7yt7DfdzHWkk7038gZcWS/aFy9hWRbUvwJGDnQ5IH/zx+t3KvcwUYRiXMcBKHIJn9FaWEaugzN73xxt8wLfHMqCOBouf4oDTwbd9/N1YYEtRorjb86dsw8mXVPz6DOP1SxxkRTQrNSw6xVWwBpWI7BUXjIZqHKgDra5z0OQ0QXj4VzZnCSl0ddVNWeLeyT9EyVbYjmdBWbucYSOTlp0cBG00QI4aKmI/jH2SxTTTIrUOSdkWrTU6T0P2uhZDh++6tbmxJU6/J4Wsx8bBVz/Z6/C/qUzunm1DtyB72TyWy400u3cqBPXHIvtIW54QnhQPSN8Fv2pCoczm/pkxmbnCSoXpVLMrWHrTBTBWEbXsIjTbZO+tnqqAOMGqPmVVSmt/8qkQLYmqUh+SYsut7pvIzJekQgqqL7YKNrd/Mbqezhr4zUdmaAD/KMSYREIcy/1XSywiHHlZjTODTYxwSV+Y/lpbtB+MiSsMPTimWxO/t+W0Zy+KGkXhvuyw/tiu7GvJNpva0dZesaYLdRO5JVDUQNvDp1WYwTFic=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR12MB2504.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(396003)(346002)(376002)(136003)(39860400002)(4326008)(8936002)(5660300002)(8676002)(66946007)(66556008)(66476007)(6862004)(316002)(36756003)(2906002)(6636002)(86362001)(478600001)(38100700002)(6486002)(41300700001)(37006003)(54906003)(26005)(186003)(6666004)(6512007)(83380400001)(2616005)(6506007)(67856001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?V7gftysk8IwYAdFIgsqg+4XgcvK0VSrFOJS/MvaZp8ktgnIf6gSNMfKdTqQO?=
 =?us-ascii?Q?mwiDxuRRdQtFSdSmAOqyAoSwTxgEt9FS5D7REE5WgHffKsOLgHDeu0GCjTIF?=
 =?us-ascii?Q?dMGCw3+USDb2xzFS1a8rBhTWL4+UKaFR3pGzt+g+p0xtwxKtGtbHKjdSe8E9?=
 =?us-ascii?Q?Ho7r+0AEiMF94Gf4bYkIQMVX41tny+TDVV1E/kxclLSvAXCytsEqSHm2gyRD?=
 =?us-ascii?Q?F3wds15waKo8U6GYt7K+WGvPU1lAeATRy2fBxcRj2MCpkUNy+zuxLC2y+/oO?=
 =?us-ascii?Q?YkVToQjBPexY1EPnMyPrjlIZylMbX2kZNHUf3MyJvwHjEDcvdkcvAggLjLzX?=
 =?us-ascii?Q?IgIGzcqn63YfOz5oaGT/XqYvslQAvkAQQPLiWODwtSa+W2z5Lx/NJI4nwqxj?=
 =?us-ascii?Q?DGN7rUeHOkB03VV/FSehU1xZJRquQmV/vGpZKrQa5IQu3tKewvL8qx+u99/F?=
 =?us-ascii?Q?Y4cTkhA62tsybnPcA+pAPzFfZasIA6jAeNMX6gkheOa/wsJUDF1VSbCFfHPb?=
 =?us-ascii?Q?fbvaRnCGUMylmWaWhmxw1SHD6TRxXk8jaD8dWgLnSekoPMjpl/RXoE/3Kzmt?=
 =?us-ascii?Q?GzbujhRno2Vw4BHgNTJK4HOgOwFra7Or3QBAMeUlvBI/VBHWknsEtiuzNWxo?=
 =?us-ascii?Q?THYRl1zSQ2LKJ2aAU6sj2VGIgcAk00h0Avh5OH8mbr9ESjP9RzAsvJ7Ct9Jb?=
 =?us-ascii?Q?raoKfKy490NFoE6jYKcS153aLdqeWuyJfUEHHoZiQRmTPLG9TUu/iyMcZb70?=
 =?us-ascii?Q?DEXAtpHDd0ifZnNOFeoFq7NvzxbeyfJx3CO4tgx0GWos8WLX9gTsu8FGFDGY?=
 =?us-ascii?Q?4Ov+CXVhvYWm8STJrlPZZDkUO5QierW0Wty8YLcIDSc5sc9fki62n76irAnU?=
 =?us-ascii?Q?Kx0OPgg1JYgyN4HC1bSrcXCE6ViIs/sLJbNl5RNVFcAPP8E6I+ChEJi82WGU?=
 =?us-ascii?Q?RZEhUJx7SQduchujfD0cCjFlELOZ2XBUEG1WElTTqcFPaqu8JMGMrW5WPafA?=
 =?us-ascii?Q?3YdI03d+xMVmkVbYq8KNYffjxk8ODBOYf7IG4ax1K4+7tyRMyvuuU6Mk0CXp?=
 =?us-ascii?Q?hhK5a2W7VKe/23XL1QBjq9MlRJhm4yhWbojH4bkljcKLJSPdl3v82arCNDdt?=
 =?us-ascii?Q?+vhZAqUVujpOFxUhNu3y6YOd6+llEPd9wSEEmmyjGpZnTZNq7WiZcmax5lV+?=
 =?us-ascii?Q?9pB/74YzzDYLeqjkdHbfD/8nhXY2nl0riO+dUkjSrtAIIeWkUdrz26QEjIP3?=
 =?us-ascii?Q?HjxNj/AWT8fvb9zHtaKr1qrdLC5M/jn0Gae6y8g4Zq3fd6qfwKMkCajqNi/m?=
 =?us-ascii?Q?Zx6rihEj/6aNwwqqqA5xRyWMTOk+ubFTLQTtUN5FNpOUnNjZexZx9KVbtmvY?=
 =?us-ascii?Q?4t7ug78UKfWkfE/sfpN+Np1X6SXFFaW2++oCzezWeR/6r9tw/V3ijNr6NA1r?=
 =?us-ascii?Q?GNkHPUQsyGZeecrP+IGOz7p5kMdmM41xBhf5U9TwrnrjEoZl3znPXGA6cDj6?=
 =?us-ascii?Q?4IyR32COcnQF9Q7ggE+QyKPkLc9nRAovlyGytNvoZ9vtZpN1HJF+2G07Q6v8?=
 =?us-ascii?Q?dMcSKpFfOoTyYJ2F65m3nDgOTeGjDvhUN9Tydmhs?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f20b042d-87da-46ab-4191-08da69202f8f
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB2504.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2022 00:46:58.5383
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: d9KeG23Zndgerw95l9NAa0z4xQwWjf5bvuo0dFymgLTxFywBcoNwH0L4IycyYlepDbMndVJBLd+TSgvQSFZPug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4826
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 15, 2022 at 06:04:22PM +0800, Yuan, Perry wrote:
> Cleanup the headers declaration which are not used
> actually and some duplicated declaration which is declarated in some
> other headers already, it will help to simplify the header part.
> 
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
> Signed-off-by: Perry Yuan <Perry.Yuan@amd.com>

Reviewed-by: Huang Rui <ray.huang@amd.com>

> ---
>  drivers/cpufreq/amd-pstate.c | 5 -----
>  1 file changed, 5 deletions(-)
> 
> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
> index 188e055e24a2..43e6df9f67f6 100644
> --- a/drivers/cpufreq/amd-pstate.c
> +++ b/drivers/cpufreq/amd-pstate.c
> @@ -31,19 +31,14 @@
>  #include <linux/compiler.h>
>  #include <linux/dmi.h>
>  #include <linux/slab.h>
> -#include <linux/acpi.h>
>  #include <linux/io.h>
>  #include <linux/delay.h>
>  #include <linux/uaccess.h>
>  #include <linux/static_call.h>
>  
> -#include <acpi/processor.h>
>  #include <acpi/cppc_acpi.h>
>  
>  #include <asm/msr.h>
> -#include <asm/processor.h>
> -#include <asm/cpufeature.h>
> -#include <asm/cpu_device_id.h>
>  #include "amd-pstate-trace.h"
>  
>  #define AMD_PSTATE_TRANSITION_LATENCY	0x20000
> -- 
> 2.32.0
> 
