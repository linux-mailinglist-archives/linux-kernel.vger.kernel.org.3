Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B625C578F39
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 02:26:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234234AbiGSAZu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 20:25:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231673AbiGSAZt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 20:25:49 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2080.outbound.protection.outlook.com [40.107.237.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A06717AB3;
        Mon, 18 Jul 2022 17:25:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c05u/E4JQGoibI+KaDQ1dk+Dyk7fQNBQxas2X1frDMFiZId8+PQVc1By5k0H1w4B4vUw0twgCxpN42N3m/raienBXrbqYcbVfU8ti7SsXspGi2oFKm6/vAwgfrCmufFPh2QBhTY6+EjrbTjOtjrh8502MnO+aiwj/1mC7TthrTJ0ycMNwPlIkqBQsXVT32lb5JUoNXJyEu9ifI5HCLB8LqOlCE3lFxURYSrihVhlhPJzKSLRlH3okwiePqgBEh4hEHHCqO6OEQNNA6BHn7Pdd19PlUeKpkT68QslPFhyZAgYeJtr3oFP6TGTt4DsnrjEbhsNWVRjuzZa+BS2yCicnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5Jxi3jfwbbu6XzvigD5b7l3gNKCXr1iUtKHQMJoq328=;
 b=Z7xrmTe3cJSUoOoV3lLWSS6qjxSAyzt/XHPMYOb/12QKoBYKdWqJCm+lU1XHKv0NpIRDcjgruNcrmHue5K/bKFXArGmwdeM3/UYGtucLd27mATgE1X7hEa7L/i+hJdWaxnqD0pdlPUSnQpIFocT0C4/dcJfouI/qbOrq0nVmOTzK07tfDHnIDRPbSA0ZW7yKTZ6uVhNJU4FQE0nv8whG+0lX50vYDVIYxPhNjSIfMNNT0oiCRbZIh7HKtWJxs2iVgBjOyY4zw7d7/ojHSActaf9HmL/FJBjhgaeDCiw+boS0WjzMm8gNgxuWGFpmHPEx7SPbNSVT/d1cjqcTEebJAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5Jxi3jfwbbu6XzvigD5b7l3gNKCXr1iUtKHQMJoq328=;
 b=rKKYzALe5loCX6fHFi+E8nL9TctvA5h7jsV+bgy2JBxm1jw4rBiMVswiKkR+gduka1TJkQn4q1djoTB6YYiL6mIwx3cHeiSMQ7BDXhDmQYs4yFQ873SB25SNYZQo+IgjMDJzmqctTtUrIuRuBAYmUNAKVTvKeTeMGvHYKt+lX70=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB2504.namprd12.prod.outlook.com (2603:10b6:4:b5::19) by
 MN2PR12MB4109.namprd12.prod.outlook.com (2603:10b6:208:1d9::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.14; Tue, 19 Jul
 2022 00:25:46 +0000
Received: from DM5PR12MB2504.namprd12.prod.outlook.com
 ([fe80::ec80:e3fd:e3e2:605d]) by DM5PR12MB2504.namprd12.prod.outlook.com
 ([fe80::ec80:e3fd:e3e2:605d%5]) with mapi id 15.20.5438.023; Tue, 19 Jul 2022
 00:25:45 +0000
Date:   Tue, 19 Jul 2022 08:25:23 +0800
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
Subject: Re: [PATCH v4 01/13] x86/msr: Add the MSR definition for AMD CPPC
 hardware control.
Message-ID: <YtX586RDd9Xw44IO@amd.com>
References: <cover.1657876961.git.Perry.Yuan@amd.com>
 <ca830355f1470ce53cd56917b0adee66c0b50f00.1657876961.git.Perry.Yuan@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ca830355f1470ce53cd56917b0adee66c0b50f00.1657876961.git.Perry.Yuan@amd.com>
X-ClientProxiedBy: SI2PR04CA0015.apcprd04.prod.outlook.com
 (2603:1096:4:197::21) To DM5PR12MB2504.namprd12.prod.outlook.com
 (2603:10b6:4:b5::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9379c193-7288-4d28-4179-08da691d38ca
X-MS-TrafficTypeDiagnostic: MN2PR12MB4109:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HwoN+PQDACT0/KA+p4dBe2Iaz4eeZqUz0XIHnAfk5pFoq4h3zA8AKqJUKkw+PBI+yXjrcVqx33fpaFoaSPPBJ0/T2I6nxdNCt1HUMdGz8Mx7MGJzb9dLMtO6V8b5BxQyneli3212/0h2lZNgfT0ypPamYb6tq1l4nMfZHZC6IHQSXeGVBezfb2yYn+rXdw7kzfxH+xlVK9JrRrr98792B24pGiuCTGMPJuQpwTpNSs+iyD43WsGjV+ypRHt4gHblezZOD/ejFkfg85AQYnmKutfmt5JjH1rhYfMvHIwZMLMl2ZyhK2tW9wTIULO78DmltnRJFwRokSEHABeLK9kcp4n7S/HQ/KnzoBzVEK2tJTIXmHCXfZDxQaTOhWni2i3mNKHgWX7ie3UVUt8PS39+flXFgLivk3VUfgmytpVPtFyqxN+b/nrhX3XRt9bgX61wbQRxXfVdbzb+rkRPBlfaxeNk7Y+K9pS897+cgFvp0VzdQEx/Ddslnl7RllAdil1b717ib6Smpyj2vS28jZdrNhvl1s2+Jtl4znHXrCV0TxTbzObNRezPwLUAPaxsXLQQK1XgNP31weskOvOGNKWzJkJfWtoirEaZaNC9WKJm1+XCfmLtwRXPa3Kzd8qkGhfVrURB0FU0vjLfOo88QfqIw3h8wEHY0NzXQD7oQmKNUEkaqrYelc24KZei3jwr99EY8JRqjiFi75hzUHDaoqQ1EVKjGlszwMjUkulHhSIvWBpOXSvY+Du6GRLxYeiekJaCES/36W7g2iCO4/NBiuDSLVB7sgY2oTfYNZxsRevELzQABqE2m+o9odvvckHNvvPR
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR12MB2504.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(396003)(376002)(136003)(346002)(39860400002)(6486002)(41300700001)(6666004)(966005)(478600001)(2616005)(186003)(6506007)(6512007)(26005)(86362001)(2906002)(6862004)(8936002)(5660300002)(36756003)(8676002)(66476007)(38100700002)(316002)(66556008)(54906003)(66946007)(37006003)(4326008)(6636002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?bFJ4FEbVUmenPZFU6FE9OQC34TLurCKVDYDWbaczdlDACz3VcMJjDI24gZ3r?=
 =?us-ascii?Q?xbdpufpobmH0S3eLp6RnK6x7xL1wxr0f4wM5Ih0IfrDL9UwQuftQneMwX5PT?=
 =?us-ascii?Q?n61IF//GQ0pf1aUS1/dgNCtcJuVk5+TSQOiIKPnwIh7AMe1VWWnrflzLB8+F?=
 =?us-ascii?Q?x0nDswrcyz97U16z4mWB/5KRmOms3GWdiKDRMKWzo8MIrOi2IJrItMh4EQDS?=
 =?us-ascii?Q?g+kBOfPfywM2rp4DJPXDxUK+pk4p3xEvLOOgqI0U3Fy/cxlitxC5EdyrIdWS?=
 =?us-ascii?Q?9ULqH8/W3+mao1ux5ferMUU/9rQORhs3YU9UD59MqnKY6PtMD9TxOp/rr7zV?=
 =?us-ascii?Q?EbpJEQxg9FM2w++/P7iy/lTOMLq17xv40DjUYqDp0XQsiRZUYUb37SbFtrEo?=
 =?us-ascii?Q?a6z3R+pPtYwe3k/J4RaAGsGFOMEGPf696WMFifmmL7irymR9GMYJjgS0F6sA?=
 =?us-ascii?Q?lVO/5o6xJS6Q0/SY6BGVwou6PY5Na6fVhA/Agz3B39wnJRVy/NrCONQ+0H/o?=
 =?us-ascii?Q?ZzSTItEXwKeMkoWa+7COa05NMO0+QA8P9Ea9cP1SG+v/Hf95R8Ulyl6TCQFU?=
 =?us-ascii?Q?96ejwiT6leMGCekCuOHACv1UAn3ClsoD31DEEwH9JAMoB7lWtJp2eV9LXwIx?=
 =?us-ascii?Q?dWjcBS0Xqwpt0i7EDNPLPErdwPaZGs5/B9PJ3QsSCzZYiGe5ibLsOA7i708v?=
 =?us-ascii?Q?ExXMtapJUn1n8DPyTkzDDONCvZaMRnUk+ht62Zl/v+q+pzewP69KvzevQow6?=
 =?us-ascii?Q?JkGJv+SHNr80dsAlxbQXKVOWECixzoMqDGtLG9apFuQpQXE34X7hyykbp6KI?=
 =?us-ascii?Q?xeMpeR0JxigTCNPwNKqIBiqf+qA4EX+R8M+vM8tPODXY7Q/TuIgqzw7ABcEs?=
 =?us-ascii?Q?suDnxL0CHaWVkRtptv1XirvbL/SdD8JuvvQLteKeebcbXcJP5Z8sBY0dUg8o?=
 =?us-ascii?Q?Q6LnFg5dax9WHIYwfkIpVy7GB/o+aru/T0dOI7XXEmxwMNyB7b4bPEFUF0ih?=
 =?us-ascii?Q?ppaXpZWm7R0Qx29xQWDs6TeBpmDLFSA0UN8wmEQeqCBZUrBkImdwwOWbPbRH?=
 =?us-ascii?Q?3UBjZ9cA+OkmQQ5kPnj2RMjvvQCL0K0u2eZIUjp9gWks7Pqz4ZqHXGSf3Vwo?=
 =?us-ascii?Q?3B87ugfXpw358A8+xjU48mAoy/fw+IQH07u9yjJIlfvqPUd9Ydk3er2Uem1g?=
 =?us-ascii?Q?zQrzGhodlmBRI6wq/waxlN7h2eRX7enyI7dT3rd/c+3FYjUyDp0PDIfX4U2D?=
 =?us-ascii?Q?4DOFZh2hT4LDrreHAiYowYsPNUWc3TvZvXvzxwNzgDOnSA9Z7jN/jJfDxeKu?=
 =?us-ascii?Q?vDBAPX8h9xJA/gQBOYxu+1upNX/IbMej39marufzjbCLX+HreGDQUc0qT2O0?=
 =?us-ascii?Q?fhj7iaUG/Nr1T3yLHwF231TRoMx3SIp+MyXqHixNaOO57tmip7r8X7O2h87S?=
 =?us-ascii?Q?Lfm9iWIy6bDfyzHjz7E2bXCmEAlvU7AC0gINaIU0JsrdAEkUiDs+I7u1DDEn?=
 =?us-ascii?Q?c/LGIT+2jMP2N6xTgQ01u1PoINFJvnfQJAuyVwOkpL4y7WYSVG7UPWtkz+7w?=
 =?us-ascii?Q?9GUlVZpDTzesIOvA1sajnTHVkUWNO1PyHJ/V3eyG?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9379c193-7288-4d28-4179-08da691d38ca
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB2504.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2022 00:25:45.7687
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: x4Sxxn4gzJO5T5yin+tr/ynNHqzlDXtzEsr4Uj7DkSnZLUZ39bSLUDY2se7BUP6CIvWQENSq3Y2+FxmkJgi8Ig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4109
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 15, 2022 at 06:04:20PM +0800, Yuan, Perry wrote:
> This MSR can be used for controlling whether the CPU boost state
> is enabled in the hardware.
> 
> AMD Processor Programming Reference (PPR)
> Link: https://www.amd.com/system/files/TechDocs/40332.pdf [p1095]
> Link: https://www.amd.com/system/files/TechDocs/56569-A1-PUB.zip [p162]
> 
> Signed-off-by: Perry Yuan <Perry.Yuan@amd.com>
> ---
>  arch/x86/include/asm/msr-index.h | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/x86/include/asm/msr-index.h b/arch/x86/include/asm/msr-index.h
> index d27e0581b777..869508de8269 100644
> --- a/arch/x86/include/asm/msr-index.h
> +++ b/arch/x86/include/asm/msr-index.h
> @@ -548,6 +548,7 @@
>  #define MSR_AMD_CPPC_CAP2		0xc00102b2
>  #define MSR_AMD_CPPC_REQ		0xc00102b3
>  #define MSR_AMD_CPPC_STATUS		0xc00102b4
> +#define MSR_AMD_CPPC_HW_CTL		0xc0010015

It's actually the duplicated macro definition with MSR_K7_HWCR:

#define MSR_K7_HWCR                     0xc0010015

Thanks,
Ray

>  
>  #define AMD_CPPC_LOWEST_PERF(x)		(((x) >> 0) & 0xff)
>  #define AMD_CPPC_LOWNONLIN_PERF(x)	(((x) >> 8) & 0xff)
> -- 
> 2.32.0
> 
