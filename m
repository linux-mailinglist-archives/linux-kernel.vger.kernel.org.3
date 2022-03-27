Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 564AD4E87DD
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Mar 2022 15:23:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235157AbiC0NZL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Mar 2022 09:25:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232851AbiC0NZJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Mar 2022 09:25:09 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2067.outbound.protection.outlook.com [40.107.92.67])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4D5836E15;
        Sun, 27 Mar 2022 06:23:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d2hqnU83PcfH5XBUsh8+aYKCDKI5rqJvjKGYX/FuI8yZxCT29Ajhr9ryciGNARsAdUDbm1GvNxjUDcTl4dCYXdd0PAIT8jmo//kNp6ix9OOyVH+JPbm6PGkzXcgFcP/vDpc6NdN8O4dMRO5pV3PgleWLOYXQC89Ylc8hbBsULK4AF5YfBc8OE4ZbnGRkbi7JcAYAHIpmcnxEuLkCA8MrgukII9XPzoX+66sQnnJHDBU3UMdTZmUruf4fCQ8ZLq33SdSk59CfDwJGQpTQyBStCjOrk7Tc3jTBm1FxHlcrSV9PbH01NVIzq5YqSnWFB3bakRNyDkI2UFE8psn08FmQLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=agr3zBWf+YCcltbEz1aOmyHgNDfLY06KK/EoeV5LyA4=;
 b=NKSO6qLPqV5WX5bOs+Q2HrqWSP1TcXNgURYZrwJBk1qZXKETyvS/KHXHF/dJC1YOl3xO3yE7ySAuucQ3u8XUoqD/l408r9UDn/aVl2+cZB0gAQWEXwGJR4md+Kmg1/pZWOL4ox0ymy7cID+xEDKCGBtPr1yU8hXUvodG20q6KLchhoLHuZYUnaNSr57rJx/LCJliDbyzddHc1temXmp8XQ+DiCafXLnW1bd8LLqDTd7Fd7MrXS2UmqOXIswKi0DnoEcKtRsXkMwGqmJ98FGSivSUD1SXktTV697+lRnSk65AaUFAuKmqP4MV66Usm0hXW+MTCA7X3scW5eyDaAngKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=agr3zBWf+YCcltbEz1aOmyHgNDfLY06KK/EoeV5LyA4=;
 b=Boarxf6hV+ucy29BVsVza6j2JXyo889mneXVTgHkoVjaVWf/N2Pe8bM6LmFmCbuYW3xJaYwhP2adio5XNBMTIEKhBP6Cwi59NuSxD/itLe/Khfjq+2v3nNuX8dpinU+wolLhztCXxczpFhaoH4RKBLyv7maJnH7O7S/pkVOnBiA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB2504.namprd12.prod.outlook.com (2603:10b6:4:b5::19) by
 BN8PR12MB3235.namprd12.prod.outlook.com (2603:10b6:408:6e::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5102.19; Sun, 27 Mar 2022 13:23:25 +0000
Received: from DM5PR12MB2504.namprd12.prod.outlook.com
 ([fe80::38da:2ef6:d863:3c90]) by DM5PR12MB2504.namprd12.prod.outlook.com
 ([fe80::38da:2ef6:d863:3c90%6]) with mapi id 15.20.5102.022; Sun, 27 Mar 2022
 13:23:25 +0000
Date:   Sun, 27 Mar 2022 21:23:05 +0800
From:   Huang Rui <ray.huang@amd.com>
To:     "Limonciello, Mario" <Mario.Limonciello@amd.com>
Cc:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        "open list:AMD PSTATE DRIVER" <linux-pm@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/3] cpufreq: Allow passing NULL as the argument for
 unregistering a driver
Message-ID: <YkBlOcdjOECMkHmP@amd.com>
References: <20220325054228.5247-1-mario.limonciello@amd.com>
 <20220325054228.5247-2-mario.limonciello@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220325054228.5247-2-mario.limonciello@amd.com>
X-ClientProxiedBy: HKAPR04CA0001.apcprd04.prod.outlook.com
 (2603:1096:203:d0::11) To DM5PR12MB2504.namprd12.prod.outlook.com
 (2603:10b6:4:b5::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 126b4f66-4f11-46e3-5d24-08da0ff4f8e8
X-MS-TrafficTypeDiagnostic: BN8PR12MB3235:EE_
X-Microsoft-Antispam-PRVS: <BN8PR12MB3235A882A4EA783CD19542A9EC1C9@BN8PR12MB3235.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kuflNtEHMdPVMIXqAzRo9qVViFxjCVb3/jQbLUip2sHKpk6yIiqmZVc4i3hAsHL49m9rckm83WGLakLOxB+GbEmFCkMF70bGFMjaCIHxVAr6OUVFsDwpJa51jseXMVQtVHu5yshx+3CTQP+5D3kdIRY8YJL4AKdWsWuiuE+qGN0itB54BKwXCL/ouJ7b+7mCS5dj/S6ZWON0npjrW5S+oN+viEH6G5TPgSDT+c8Sv2fZMLaeCL/7uJ6V2XFY+/NaLe8mEcIbYZq0/ZLaMkTjKn4SQe1OLApXFWcl79KBtACqsB1+nRH7XBqGpcW/aODi/nPjTEj1/qnCSFud16LEY5gXnQCXYG804MSPw41xpfszljorlAq6uBXy8XNvRGHjve/pVoZSSzdXgpx0TDBs/qKRJh/v1n+CyxivEX4Jh3Bx6Ngl31+pZNDjUGnYakz2jbnV6COBhsZUQcMx2rfFWMAuKdbbMPJc0U1JhHqZl0UvK84aetqEZFV/9MH1CZpckm5N0cCIt4rNhd/7RfmHvJ/zIiIplh7BX2bFLabFzKc8MJbS9YH75DIXFLajKehVduxi+n2g+f1C/kpy844cPmv6hfK44ayWaFQQbTx70iJ4tK7fjUVgHZV6JcmxOztBVmO7trqg/zapLhkcfC/1/w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR12MB2504.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(26005)(5660300002)(6506007)(6512007)(2616005)(66946007)(6486002)(86362001)(508600001)(8936002)(186003)(66556008)(2906002)(54906003)(66476007)(4326008)(316002)(38100700002)(83380400001)(6862004)(37006003)(8676002)(6636002)(36756003)(6666004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?yF60nBjGH67Bv0LIWm3+F8dFsfOwAsWbrehwSwvCfRSkRApKKwEXIPXrZkwn?=
 =?us-ascii?Q?AwfDIWxIgonQMiWPuwW/YCLDwbQk9gceioz++yAiJV8JtpZeB0HOWo9EKDWr?=
 =?us-ascii?Q?EBpwd1Y4aMJJUoNyjvdLZRLS0sljtF1OE6ICKGhx3mWzvFhXhSSD/hzBFra7?=
 =?us-ascii?Q?bfvNl1/4rFEQd01g2TI4O8mcnYcdpqmhFLMmLXBrWbSrDc2gHjCEnx3efGsF?=
 =?us-ascii?Q?ayAwv+oS1X2/VZ/MrLjsfJ1e5n0ppitneG6gfivBaAMDr0D5Lmejwq6UpZK4?=
 =?us-ascii?Q?sGsV3KkA6CGckDG64xhnloxeA7tNqTo8AfhgL1il0U3WeVVoCO6rMVHqoJRj?=
 =?us-ascii?Q?wpcBZeT2rTDO0HQTwGE7not7HeCoHSasIxwmEknwwDcgd0p8P92T04IpNBLf?=
 =?us-ascii?Q?ebT+tOBbcUhQ6OYyqOuTO3WlB5JhrOyU7N7rzwKNd6F4PzopSApm8wdpcyZL?=
 =?us-ascii?Q?a9py2722rCyI0dFzt7d8SFjzmbSP8OA4SO4yxqGCaX5/EQ/YPn4NkTuOx4eb?=
 =?us-ascii?Q?eMfVPYFbhFImpWQaoV3R1UMe6WQ6wuxC7IBjPmF/qpBNsfVAm4aT4C3tVkYN?=
 =?us-ascii?Q?FVYGSYfihHKYHziiwFRKjZub7A3DhB3YyR6FdpTPoyR2ke2aLpCRQLzSIVDO?=
 =?us-ascii?Q?dUquCCaWWrOredRd2EZuNgzvj6V/jHUAd+k5lsDfPNUF/u+C0E3+XMZ2hMxI?=
 =?us-ascii?Q?0Pn3Dkox9jvElAxyW0FpMlM0H4VOw7jzSxD7F2wtBNB8mmoTKBqY+1rxMiKr?=
 =?us-ascii?Q?ee0O01gaMgKdbzT8zD38iQKe/K790BbPru/WocBiv5Y+3aUVOkbRtFhvIKwF?=
 =?us-ascii?Q?FCixiO81/Pr/eVXitt6QpF6i+a5VfwMcqAK59yISGYAppVRqWcwGT3wnGcBv?=
 =?us-ascii?Q?/E2K5vZAfT7H9ZybZgSL+BSS94ofSYJkZXWCwbV7us7GsuizGnMFMZIwCHKh?=
 =?us-ascii?Q?g0IvroZGlCZTZW9dQMi+EJ8KmarP+33Mi9Lr5MQBxiVrKbCWUnFHTJI644Lj?=
 =?us-ascii?Q?xU84vHZLVPrnXoXslmzv2jmt0JyoLKxWmHM1RwzxuwJ7oCO6aeyooiICUO8O?=
 =?us-ascii?Q?J+QcuR2FUgV9xNnS0l69amRvLEr+ADp76N4PYpkJP/qZ4hAXR8V9qFw27CDr?=
 =?us-ascii?Q?yACr7WJuNfs3YenIuDss9wh7ZsuezdniSgItkK0n4dvln7cHD12ZhufuTIRp?=
 =?us-ascii?Q?Q2QAu+BEh4AlhuTcDzpI9OqYJeVLd+Ip2oV+DQsLCKkz/lOsjSam6W0/V3ky?=
 =?us-ascii?Q?D8z9+wIWYgK+f4S2K/WOjSwAAMFeclZ0tUOI+HkD5nYv61jTgx4pIcXutfZO?=
 =?us-ascii?Q?UbFZLE3BBtN29rEa7sV6jCf95Zo/kO8WK6MUFEl+X6oWZyJZQPT3XTNKrIJz?=
 =?us-ascii?Q?9kZ30mMPyDf1eTLLK+VJ7UCC/f/g2DMMk2qSx9B1wL7T+u/pGtJ4gs8OtXml?=
 =?us-ascii?Q?hK1GxjBJ+fnbKwQW/QujFAv9Agx9xNCHr5+xrzHn3nasrxm+hrIl7ddmtnX1?=
 =?us-ascii?Q?m5sfGAZ7Tggsdtr8BdLP/BBHsDCBbDbqbKh+ezorKy/5qrP9qniXbpX0z6/f?=
 =?us-ascii?Q?5I7Qn4/4rqjtPScjoH/AaDGvL/zurPLUxNdlSZ8Ks/aJbrcfmy5aMNPxsozI?=
 =?us-ascii?Q?BIWbjqY9DtERnzxjlGfoqecdAIfLmY56r3WRka4lImhtRrkcldmDYwMnJVmP?=
 =?us-ascii?Q?oHr3DYDtF7Viny8jbY0wolTwTINKp6tBTrG9TdCDYBMx+6CWqhf1/ef12ETr?=
 =?us-ascii?Q?tWogOc5rOA=3D=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 126b4f66-4f11-46e3-5d24-08da0ff4f8e8
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB2504.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2022 13:23:25.1417
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: T2aQnMbPceIoKbzhCGA1e02Sl+D3pQ6R29NRsZiLZvz5D/7Ku1JjRG1OO2P/H4nTzQ1uezY7q0FFj8u6rqeb2g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB3235
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 25, 2022 at 01:42:26PM +0800, Limonciello, Mario wrote:
> Currently the arguments passed to `cpufreq_unregister_driver` are matched
> against the currently registered driver.
> 
> This means that the only way for a driver to be unregistered is if it's
> module is unloaded.  Loosen that restriction to allow other kernel modules
> to unregister a registered driver.
> 
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
>  drivers/cpufreq/cpufreq.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> index 80f535cc8a75..4711c17a89bb 100644
> --- a/drivers/cpufreq/cpufreq.c
> +++ b/drivers/cpufreq/cpufreq.c
> @@ -2885,10 +2885,10 @@ int cpufreq_unregister_driver(struct cpufreq_driver *driver)
>  {
>  	unsigned long flags;
>  
> -	if (!cpufreq_driver || (driver != cpufreq_driver))
> +	if (!cpufreq_driver)
>  		return -EINVAL;
>  
> -	pr_debug("unregistering driver %s\n", driver->name);
> +	pr_debug("unregistering driver %s\n", cpufreq_driver->name);
>  

This is amd-pstate only use case, I suggest we only modify the amd-pstate
driver, and don't impact generic cpufreq. Actually, only acpi-cpufreq could
be registered earlier than amd-pstate. So how about exposing the
acpi_cpufreq_exit(), and call this to free the acpi_cpufreq_driver in
amd-pstate directly?

Thanks,
Ray
