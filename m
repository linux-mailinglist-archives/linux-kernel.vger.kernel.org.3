Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16D064CCE26
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 07:58:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229529AbiCDG6F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Mar 2022 01:58:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236816AbiCDG6A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 01:58:00 -0500
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2068.outbound.protection.outlook.com [40.107.92.68])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E596918E3C8;
        Thu,  3 Mar 2022 22:57:02 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U7ZnyLGCtLHPCs/I0qsjxytYYTlkyh7wB2j1DJPXRDP1VOzylVoYIT3ZnslpgYZ+eIF/aGrQY/r8SWkcf6w1YD10T2oRNv7cAmzu0q65QG1p8NvH3ARwXHGYoQf7wfAdnNOPTx3xpODCyCg8wK0g8DEPEkL4Zd7CBfJN9T06fiCbxwGLqL+9A0Qf53EZLTxCZrd8ZefuNIQ13cb+hCZAOmUwVfX5L3PGgQutzTogZRUa2RPPzZmwAhn3TFtQyFJMhRGQ973yGzgKmYPbwf3E0KBs88ieT0DWzZKPcjuj9p9RYHoR6ybLK9GbKHRSMY0ybio9ymND/ME/CIJecixv9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h8j3gXNxmFvcW2Zn+LWDh3nBmuIVvKKh0+DK915vi5Q=;
 b=U80N9n64Edt/AX4e5un72nZOywrdJaC80ogKB1qY+v8cuzRRLC7bLjqjcOOBY0XW6PECNySqKf6XLaZzFBKUuGucasvhaxsfpMJeqfRRs+lxQpyxcGs1CRhnuYtrJelyaLTKhpq8lNNjzj0z1UoefbRXGXAM7kG/oZZnEqLt7oNxT9ardGXDbmXxQvLcIAteLbLdV6uveRTlqzrGxsvByXi5t0OI4kpflLVP9tGg0856fQ8IE+wlgOT6oTm+/HjztPQlu7AmgwEbfgi+8Eaog4RILlP3GM+eF2L17UhB2xFMcQ8dLwaBQurH4A6Q2ce0YoY/y/XSoP9/4hGqBD3big==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h8j3gXNxmFvcW2Zn+LWDh3nBmuIVvKKh0+DK915vi5Q=;
 b=DaAvv+WkegjQHzMejXVJOcwmu9TT+Hqp5NpMKdbhNJb2/qEycRrBupiuxmvR4gCe5g1yqlz6778epbTPfSO2dIDkcY2JCrDQGXwlEhh+w8T4axCpO2DVOXDSEcxGeaFk/QFkfmO3Ip6YMjSDuUFN0IL6zyJlcQG+rZGiqer0eh4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB2504.namprd12.prod.outlook.com (2603:10b6:4:b5::19) by
 SN1PR12MB2384.namprd12.prod.outlook.com (2603:10b6:802:25::25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5038.17; Fri, 4 Mar 2022 06:57:00 +0000
Received: from DM5PR12MB2504.namprd12.prod.outlook.com
 ([fe80::8d40:da47:7312:64b8]) by DM5PR12MB2504.namprd12.prod.outlook.com
 ([fe80::8d40:da47:7312:64b8%6]) with mapi id 15.20.5038.017; Fri, 4 Mar 2022
 06:57:00 +0000
Date:   Fri, 4 Mar 2022 14:56:36 +0800
From:   Huang Rui <ray.huang@amd.com>
To:     "Su, Jinzhou (Joe)" <Jinzhou.Su@amd.com>
Cc:     "rjw@rjwysocki.net" <rjw@rjwysocki.net>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "srinivas.pandruvada@linux.intel.com" 
        <srinivas.pandruvada@linux.intel.com>,
        "dsmythies@telus.net" <dsmythies@telus.net>,
        "viresh.kumar@linaro.org" <viresh.kumar@linaro.org>,
        "todd.e.brandt@linux.intel.com" <todd.e.brandt@linux.intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Sharma, Deepak" <Deepak.Sharma@amd.com>,
        "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        "Du, Xiaojian" <Xiaojian.Du@amd.com>,
        "Yuan, Perry" <Perry.Yuan@amd.com>,
        "Meng, Li (Jassmine)" <Li.Meng@amd.com>
Subject: Re: [PATCH V2 4/4] Documentation: amd-pstate: add tracer tool
 introduction
Message-ID: <YiG4JL+g/E1yNjDI@amd.com>
References: <20220304060724.314582-1-Jinzhou.Su@amd.com>
 <20220304060724.314582-5-Jinzhou.Su@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220304060724.314582-5-Jinzhou.Su@amd.com>
X-ClientProxiedBy: SG2PR01CA0142.apcprd01.prod.exchangelabs.com
 (2603:1096:4:8f::22) To DM5PR12MB2504.namprd12.prod.outlook.com
 (2603:10b6:4:b5::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 211bf136-2aff-42bd-0ad9-08d9fdac2e47
X-MS-TrafficTypeDiagnostic: SN1PR12MB2384:EE_
X-Microsoft-Antispam-PRVS: <SN1PR12MB2384CCD5DD4D46C2836342AAEC059@SN1PR12MB2384.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Rh8DKYI5h0Y1Ta2PA1UZ4cPlrCT5fRR91nFXmjXOj9GejJdrBOh29Pfglj7dzaeqV8lzxR4hBys1ScOh1/yr6qKxUq6y4IUp00O81YcizmJspUlg1iETVD4mMJuU3gx0H5RkFL3NJ3VEWGTFd8VST3LpDCcQpQqSCfJJf5iyAifLAi/IQi2aY1Hoe0iST7srMUSQ+288/a3JxJd5RuGhari5R3U5ljYM/B6FsyLQUkh/RnxxnHMt0ymbT1kqFAsHaeoSPRIo2LQs4wEb1amsMIA0zxG8PUTaR4fSRjX/SQfjeW241PR9zsgOLsKawO5Uhi7kjHR/kPwLI/VKSoQvk5lbWCsIcpPrjkpocvZbdBPpxscirOv+ZnDxlGOLIvrZFXpVQ8lXk31ngsLoTb6AoqAazYDcDBMjoZ/clIg+uh6Whweovshv+yDAOjE8A8tRRARmMMoCANquMQgnD1sd4IJyWXr3syOa1gL+e4b+DFI2MEXgxSr+9zkyc+nqbKDQq2aJr36+pzMs//QfOZBYZfh10l/fSRmgUwVZczWyUY4lPoYZ8Nqo7aXwA6tF+hWCb9Yl9+l84z5verA2Q4BYBJTsJolUvRqCpPu0jeiYV2K76Afq8t8FGfpHz8bJlSfTuBKLy00GgL0MO+b2geHs3A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR12MB2504.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(6636002)(66946007)(86362001)(6486002)(2906002)(8676002)(6862004)(66556008)(66476007)(4326008)(83380400001)(5660300002)(316002)(54906003)(36756003)(37006003)(8936002)(508600001)(38100700002)(6506007)(6512007)(6666004)(2616005)(186003)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?D94NYfI+8bDqIvw6Cl/mIcH7i+dpnQ13nydzqAjeNbh7reEm9gtLUkdeNPZz?=
 =?us-ascii?Q?UsyGhsL+RFVafZXxoYhZi1fE0Wxv1/1T3gG6oBcBJSbyqn6IJYkK+rPq+We3?=
 =?us-ascii?Q?2dzgu7KpGX1AixRCv+NFh44mZWXVCtq6np3c6z5KNwhUAhcLJDLrf5h8zSLl?=
 =?us-ascii?Q?IB169wiI3Zvz0EBAuet4AWE2qFHnqWR4aYVxjGs3zTF5hUzudd7j89Njh7k8?=
 =?us-ascii?Q?816lnVmRsIUwavTNIb13/pn/ivT4MqufwFpwg5GFC6JK4MGfLCa0Uk4WfYfZ?=
 =?us-ascii?Q?+J+pIOs8v5urLhCvEIJYXSl2QQkiP1zuVERhfSzQYxTEMRgMT0pkAxqWlnXR?=
 =?us-ascii?Q?mrgC+x93vJ66OsJd8hUHyXllqgZLO9X+b7BJD9Rl20XkMjepaUUHg+Ubns76?=
 =?us-ascii?Q?J41mpgOoNeqswLNwpqJrHzvsHyz+FmeAbSahDZUBXXr7OFnyhiJytRqi9zeS?=
 =?us-ascii?Q?ftkDlJzFYPH2SgysmFwDwxPD5C8EYiq1pZk5D9c24QWK/B0OXHcI8W3PLrwk?=
 =?us-ascii?Q?OlKS7dn3cj4qOtCx2yHe2iphtHBxvg3VXf2S/+flqWaWm/vboiPdEcG1A1V9?=
 =?us-ascii?Q?fQSlHxxncywX2hzsdVGpa+bFGCdfhBHN5l/E0rl639Ky0hczyDn6OYW4+61T?=
 =?us-ascii?Q?+n7/l9RVNgf5HZLW6I0xCrFfJujqEqe53Fy5QiZNIo8Wq2p7huMLZuRgYMUM?=
 =?us-ascii?Q?6GDdVqnMuyPV7ORbdIh7NH8ylDPm74SdMAjHAW0d+N9Jbq85aOciihuqyo1b?=
 =?us-ascii?Q?4axnY2hkaW0f9ig4CpBXGPHOOXrcHyebXOgFTg8GnADDEsHCTWkXWGGamSKy?=
 =?us-ascii?Q?G+u4y79V5pRXaaHPH0TgedynQTeu5GAUPQhq42Y5ts4i/FUQk6QP9zxlcIN0?=
 =?us-ascii?Q?505XWVPCYNqC2nCMxjoS44tKJR0pHmI2vIBXmMhYvkzj3ovXAqVEC0zGEpjs?=
 =?us-ascii?Q?pawXGsBa4RV+5k+aMjHpbJQV+weWk19+gXvhh6s9DEJZUeJn7xDYru2Utjob?=
 =?us-ascii?Q?3wrVAib3mvhrFrswMKyF1+wiEMhegW2ZVP2RfFIzzFBDhEP6O6KuOznUZP4G?=
 =?us-ascii?Q?wU1Ehp4We3K3qwIan/tR74x2fQ9a7tDa/W0XxMtZWS3+2xVKGnc109rsyVA+?=
 =?us-ascii?Q?ANTcUZp3D4gXIUx0vboe9iaTcdRjQtGHXGiDd/gmV8G0ETVzod5EPZZa/RvL?=
 =?us-ascii?Q?uVGPPTLUDtbNnhiah9QrlAs+ckxlxR/sEl6WATyvWUMnpzkPpVcnwqkmCqSm?=
 =?us-ascii?Q?SHnfaffgr86JzoLbpY5pi/Mt2KFzVh7Ztf/e8aWvBsUDkf6ZANeq2xcnbJPf?=
 =?us-ascii?Q?EfNB22s5/Ybd4HlJW2aLDEdn+dS58ooSAqVg7Dp0FJ4RoQHIMW5RyVj4E+OV?=
 =?us-ascii?Q?N0tduD98if8uwRCHLsnMgyXSfm3x08esW6B5hae6MMt9QhZgvKZHJSj6FAXk?=
 =?us-ascii?Q?cDyzDsLJ1UmSmv+NXb1QqIP3D07TwQXL9ZJtPmbT1Sd5CF5iFfldcvh36jNV?=
 =?us-ascii?Q?ABQinfHOOJivk5rNgd0r8S8zqspDE6sXyRXIhkNRlZsgjYo06cQAQL/JeKGD?=
 =?us-ascii?Q?Z6fLRbVYey1aH7jh+Q0oMcsYfY1WdxERlkVLE9GfWzNODgLYaRQ3fYzMvj4f?=
 =?us-ascii?Q?fOiADOgA4yyhIPEdALRm63Q=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 211bf136-2aff-42bd-0ad9-08d9fdac2e47
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB2504.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2022 06:57:00.5370
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pZ8rsO+h64OnCM8QuJSk7AG+ggNbGAiJTsyD2OVVd0DSLB0sGkqga62cyDT4TSdgYztzBjD6HPdfGQKjXgtQcA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2384
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 04, 2022 at 02:07:24PM +0800, Su, Jinzhou (Joe) wrote:
> Add amd pstate tracer tool introduction
> 
> Signed-off-by: Jinzhou Su <Jinzhou.Su@amd.com>
> ---
>  Documentation/admin-guide/pm/amd-pstate.rst | 26 +++++++++++++++++++++
>  1 file changed, 26 insertions(+)
> 
> diff --git a/Documentation/admin-guide/pm/amd-pstate.rst b/Documentation/admin-guide/pm/amd-pstate.rst
> index 2f066df4ee9c..17dd7396e8fc 100644
> --- a/Documentation/admin-guide/pm/amd-pstate.rst
> +++ b/Documentation/admin-guide/pm/amd-pstate.rst
> @@ -369,6 +369,32 @@ governor (for the policies it is attached to), or by the ``CPUFreq`` core (for t
>  policies with other scaling governors).
>  
>  
> +Tracer Tool
> +-------------
> +
> +``amd_pstate_tracer.py`` can record and parse amd-pstate trace log, then

amd-pstate -> ``amd-pstate``

> +generate performance plots. This utility can be used to debug and tune the
> +performance of the amd-pstate driver. The tracer tool needs to import intel

amd-pstate -> ``amd-pstate``

> +pstate tracer.
> +
> +Tracer tool located in linux/tools/power/x86/amd_pstate_tracer. It can be

linux/tools/power/x86/amd_pstate_tracer -> ``linux/tools/power/x86/amd_pstate_tracer``

> +used in two ways. If trace file is available, then directly parse the file
> +with command ::
> +
> + ./amd_pstate_trace.py [-c cpus] -t <trace_file> -n <test_name>
> +
> +Or generate trace file with root privilege, then parse and plot with command ::
> +
> + sudo ./amd_pstate_trace.py [-c cpus] -n <test_name> -i <interval> [-m kbytes]
> +
> +The test result can be found in ``results/test_name``. Following is the example
> +about part of the output. ::
> +
> + common_cpu  common_secs  common_usecs  min_perf  des_perf  max_perf  freq    mperf   apef    tsc       load   duration_ms  sample_num  elapsed_time  common_comm
> + CPU_005     712          116384        39        49        166       0.7565  9645075 2214891 38431470  25.1   11.646       469         2.496         kworker/5:0-40
> + CPU_006     712          116408        39        49        166       0.6769  8950227 1839034 37192089  24.06  11.272       470         2.496         kworker/6:0-1264
> +
> +
>  Reference
>  ===========
>  
> -- 
> 2.27.0
> 
