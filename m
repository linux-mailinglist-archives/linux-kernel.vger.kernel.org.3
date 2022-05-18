Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 285BA52B1CD
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 07:21:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230169AbiERFUI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 01:20:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230064AbiERFUG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 01:20:06 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2048.outbound.protection.outlook.com [40.107.94.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CF096542;
        Tue, 17 May 2022 22:20:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nUPatN5BGq2Dvjn6f4E5dLeMHl7wlLm1Ino0od+9gj3o7SG8p/Del1gFrW8CIOJ0sPOROueQRJSOd57zwOWaKkkjpZMcAjHejXj74nYPh6T2OL7/gUSwGMdiRxppDAS6GBjoGUNeKj55SeDrAd0iJnMOHdb+21zVGPxm5SZHcNco44rBafpLl4v/Xn64jqMjkl7TzphlodoneL7yEHqZ5U6M2zfKE+7ZBAhmu2dSbB7c/uPZAyX2IGldhk/gyxcuVJqOl1MFJXjc05tJU+FMa+xryghJWt8aTmYfnNus6x7Q/syxdV0tIqt/d5kbKAoArWiQG9D6hV1wQz3sCGa4WQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kmqoVya8SBKjVRa2r3TTehkp4gb64wXw/fjS7taodKM=;
 b=QVoTt1Flp5BCJKNxjZLke3MY3kDKP6hUnoLIhYLlhstXKCylsukDzN2/0QO3rpHwhHqFVSAaGbLQmQG4/Y7sznjO909rpSi8Y6ctAMfTUXNurtSJbUBgctDXJ5kLF76hbozOlruW5KWcrOMr9CwgABee7H2iCz9ZM5SjzGeygxY1r6y5cTx4bs5lhXMAGhbt83ZRUetdZ4AMs+S1SZAkjI5H8BJRCsWtbZjFGyfleLlkOcDNTtuAuqB9qXmRF7/Sl3sCOOwJAIWXXlCAzhu6l1SoDezL/N0334sGqxzihmLmcyUFW4JQCxWyWqi7bSxpZLkQW6JRQQnDHaYtG0sDPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kmqoVya8SBKjVRa2r3TTehkp4gb64wXw/fjS7taodKM=;
 b=shDElxCyaLh5q8lO+3b0dqH0iUlwm82vHbHtkP9wYopMMz7b/r4dxZ5q63G7A021/fBdU2cXFCtO0ntX5s1HgcQi0KeAaDXeLUR61JnQxn8WMi3FRJnRmgvGprwmCnjpKSlDTRpWupba45y0Zs0rRw1XZ3o+NpyQkk+8Q7zFrLM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB2504.namprd12.prod.outlook.com (2603:10b6:4:b5::19) by
 LV2PR12MB5750.namprd12.prod.outlook.com (2603:10b6:408:17e::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5250.18; Wed, 18 May 2022 05:19:59 +0000
Received: from DM5PR12MB2504.namprd12.prod.outlook.com
 ([fe80::b846:d865:5901:f76d]) by DM5PR12MB2504.namprd12.prod.outlook.com
 ([fe80::b846:d865:5901:f76d%7]) with mapi id 15.20.5273.014; Wed, 18 May 2022
 05:19:59 +0000
Date:   Wed, 18 May 2022 13:19:36 +0800
From:   Huang Rui <ray.huang@amd.com>
To:     Shuah Khan <skhan@linuxfoundation.org>
Cc:     "Meng, Li (Jassmine)" <Li.Meng@amd.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        "Fontenot, Nathan" <Nathan.Fontenot@amd.com>,
        "Sharma, Deepak" <Deepak.Sharma@amd.com>,
        "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        "Limonciello, Mario" <Mario.Limonciello@amd.com>,
        "Su, Jinzhou (Joe)" <Jinzhou.Su@amd.com>,
        "Yuan, Perry" <Perry.Yuan@amd.com>,
        "Du, Xiaojian" <Xiaojian.Du@amd.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Borislav Petkov <bp@alien8.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH V5 0/3] Add unit test module for AMD P-State driver
Message-ID: <YoSB6JRplJR79Beu@amd.com>
References: <20220505022913.329259-1-li.meng@amd.com>
 <YnNxlzRW2NGCx5dO@amd.com>
 <615adab4-515c-7d61-5662-bd342b759d6d@linuxfoundation.org>
 <27434868-1d0f-4493-3265-bea4e1dc8494@linuxfoundation.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <27434868-1d0f-4493-3265-bea4e1dc8494@linuxfoundation.org>
X-ClientProxiedBy: HK0PR01CA0070.apcprd01.prod.exchangelabs.com
 (2603:1096:203:a6::34) To DM5PR12MB2504.namprd12.prod.outlook.com
 (2603:10b6:4:b5::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0cd44961-e882-4276-54bb-08da388e0d6b
X-MS-TrafficTypeDiagnostic: LV2PR12MB5750:EE_
X-Microsoft-Antispam-PRVS: <LV2PR12MB5750090C6522A7DF4E49F11EECD19@LV2PR12MB5750.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: j5HhrKP12U25gty7qKVvF8XaDLR2FjS/tt93JL8IsM91XaNesZswvEzLmIoH1NhGCAdHWEQjiMLVD1mwF0LlEERtYKbgEkjiyC7R/vVKXJy5KA6zcHyFVBYhdq3LWymlPdIZTSR+iIzutc6bwAeD1wk6sofaOS/w5dS8/GCB3dLeubtjGawfYWgT+ER8NPreWtnKl1/2jlGZGrC48EzGjOt/77hryp7s41y8fpBACZLM8sNhFYqFXIymcLNGcgZKpbzfCKh56PFN8vN7VP4kYJtg0XjDkGuLBQoqp50r4+6TDehUrFlsZaqq7wZavXHYsbWaMebmYSVAXov9j04bwiJr0cL/kNiBA+JdAw5Z8BWbXAoGEIvOzijM5FOs94CMqq5eDei2uP4ZlDkEk35LNLK4HLtS5TveiNRCxPM9goMXzd0VHKUl/U2VNK1xkMYVidE6viKFM6SR6YDdXxuC/Lr7ZtHMMkKNB9FjtshqbavUXvZQ2sq+sO1n2yT/nK1IYRanC/QLkinflvKMZEWSu2BFw44vL8C/l5Pj98hxFxiwqnty2+rn6It6Qisdt6xDchMI9YpQy3d+tz0JlGe/4vv/cH8JAjtDbzWc86tAY3tmfD+O7nsu+mzlmmSCV28GoJ/bnr2Z+YYbqEvYaMoUaV/urcgH2C1VIX27CbXyvJ6PLYfXU5unR1ERG5nSK7JXZY5Smfx2t5zIDw56qOi53/g38xlWw6b8+5TR5qk203NcjwvgLMvZ3CGTCJLrylSGhJ9azcSG/QMmDsYG3fqMNQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR12MB2504.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(5660300002)(2906002)(6506007)(2616005)(6666004)(36756003)(83380400001)(66946007)(186003)(53546011)(66476007)(6512007)(6486002)(966005)(38100700002)(508600001)(8936002)(45080400002)(26005)(8676002)(54906003)(66556008)(6916009)(4326008)(316002)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Lnq8091462OF2uMq0ZsUgOGqocCxa2eJ85AJ1yZY3k7H11ORsFcQRzJSs+qC?=
 =?us-ascii?Q?/7hxkwQEMZ8Qwppr7Ms5ApyKQtSBwl6HlyTJCh3+MAk5zTLztEAfoO+kUaWz?=
 =?us-ascii?Q?Rq5MhZsiBJxaCR+QqQuajYG6wYN2MIki1yEpGJuf5kyYof640h5LcRZOWkhW?=
 =?us-ascii?Q?OjX2T4FqFaCYwQL3pkXh5+HzklZfUctpdaCMtTlQdAKDJwoOfuJLqBSp4e92?=
 =?us-ascii?Q?tuXoXPDjt+XxU3bS9P02e8Slnw+3HUhyWHHuAhhRMOXS82z9QqebVe0TexPR?=
 =?us-ascii?Q?iLJerYEq9RfLjgiHlIn6sY/AE7XWQbdmOzCS+bDdkh/ltQMsnOQS7TjC6vW/?=
 =?us-ascii?Q?mvUbph8tcdM6L2iylSNT+xivLF9A/mYjEPbcKnJvBaY69Y+VJAKmm/D5Lw9o?=
 =?us-ascii?Q?xcmwmVekyXVF/D8G0VMPQtcgJS1/15X9gUpr3nc7y44ML/lLSg7LGTTMIUkt?=
 =?us-ascii?Q?+otm78cDjQP3kz4v10DqYZosNgvOa2yNwgxBAi3lc0mevEXOmh8+E/0iedWd?=
 =?us-ascii?Q?PqKNJHeTwNaNPqSX3dC9LSgvH391XLuEP7QawYm1b/Pifx9CM0kmTZQCxHwI?=
 =?us-ascii?Q?tKGTWr+nJr5m/rlJS1+3FZd/aDa6GxrY3n1EPejo9IK5Dv28HdhaI7iPZ1Ri?=
 =?us-ascii?Q?Vqxs41Q60U5JU5R/1W1G8cjWXJpvo5ND61dy1f0UsKaqAUdOnOSBMb38XMU0?=
 =?us-ascii?Q?E3Votq5kDTiBxy72cPnOZ72qSNaUK25QFrEj6LCJgnx+LMvN1GP1wRg5m/WR?=
 =?us-ascii?Q?4+Sm4VcIKRC3uGdBh8OpTZCXlP3fnfvG1NnvLoFlozsEapxa6iRdMaI5QKge?=
 =?us-ascii?Q?xLewZxVt+7In9vYXSZ/KwjecFfO0eaRxX9IkJ5u2LhJlxvjPY8R6XBzNmKeX?=
 =?us-ascii?Q?9eoG0tQYVPW8OlFpvMFbezM0z8fZ0GHQPHxAc6ZFEtpPcWNfV7PaauTpuAjn?=
 =?us-ascii?Q?3Lsxnod3aJKScbKxCa1AdQahqtrLMFkH3k89Qe6WF8FqhFjAul0bKf6rcMHW?=
 =?us-ascii?Q?dHNnp52Q2KEOKzVIt0jpc1pRZ7VTT0g24zVzMn6K5VrsHe9m+zherLUzviWB?=
 =?us-ascii?Q?dPnaoie51Peg+iPwJVwFkqf3gTNJi8gqGgAOMinvQLsmM0uXgUIQbMiDfze9?=
 =?us-ascii?Q?U2xTIX7Em2ybL1tPCBDiPzIk21ASpucKMKXAcUOr45X64eFwqY0nS3uyvahj?=
 =?us-ascii?Q?dnZHR/pQ/iXqZ3e4HzbSSLFsIw1UQjZ92yrV0xppizkiZewyDqj6j0HCr/Nw?=
 =?us-ascii?Q?XDR6/ahNQGPqJebit4Mz0/UaUp7W0QZFfbWRf8Kwl8jN1Gx6zKTSnWJ/52Hw?=
 =?us-ascii?Q?byY5KJQ3lF6EMXQZWiUvfdG6Pd8IgYwxCP36ESelCcKJK9VK5nlvT2MmeuGE?=
 =?us-ascii?Q?Pr5q324p5ItzrQIfHZUEWuZ3PYamjy69jo7UquQD9tIjqVABG7/ekZPTP/UQ?=
 =?us-ascii?Q?dL9sNxz42+vJi6bJ8zOms/WjqKm3+dIzy06LnQJpuXi9PIzfr/5osy3ARR1l?=
 =?us-ascii?Q?gZGqNbTQZHH2IrNd5uXcn0cHv5mIBe7mcjNvzjAGWgxpI94Y+BWlMNdo2QHr?=
 =?us-ascii?Q?adjqUxjp7xfR8D3lniy38lswlE1rlHL3S+06d4b2Dpmm7fQBgO2wGvFAQq0d?=
 =?us-ascii?Q?yOvltct+WaO/n5m4BW0bf98SnTy3kMNs1SQGeHUtpiZ01Z0yRR9V+Gg/BqE1?=
 =?us-ascii?Q?5srmvwg02GAChcKaA+5xk14GDxd0eXPJe1qN+0H09wzMnkzRd0vvy+gS9KWb?=
 =?us-ascii?Q?kRToQ2IqJA=3D=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0cd44961-e882-4276-54bb-08da388e0d6b
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB2504.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2022 05:19:59.0026
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nYuVlCMMjTNkh7+9v3d8qVDjtQR0PH+i68UE6i0BYfi6WcuRBg4gXCQGnr4D1SmEOmRZWNaHGzE/Udx/w7BD3Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5750
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 18, 2022 at 04:03:05AM +0800, Shuah Khan wrote:
> On 5/17/22 8:45 AM, Shuah Khan wrote:
> > On 5/5/22 12:41 AM, Huang Rui wrote:
> >> On Thu, May 05, 2022 at 10:29:10AM +0800, Meng, Li (Jassmine) wrote:
> >>> Hi all:
> >>>
> >>> AMD P-State unit test(amd-pstate-ut) is a kernel module for testing
> >>> the functions of amd-pstate driver.
> >>> It could import as a module to launch some test tasks.
> >>> 1) It can help all users to verify their processor support (SBIOS/
> >>> Firmware or Hardware).
> >>> 2) Kernel can have a basic function test to avoid the kernel regression
> >>> during the update.
> >>> 3) We can introduce more functional or performance tests to align the
> >>> together, it will benefit power and performance scale optimization.
> >>>
> >>> We upstream out AMD P-state driver into Linux kernel and use this unit
> >>> test module to verify the required conditions and basic functions of
> >>> amd-pstate before integration test.
> >>>
> >>> We use test module in the kselftest frameworks to implement it.
> >>> We create amd-pstate-ut module and tie it into kselftest.
> >>>
> >>> For example: The test case aput_acpi_cpc is used to check whether the
> >>> _CPC object is exist in SBIOS.
> >>> The amd-pstate initialization will fail if the _CPC in ACPI SBIOS is not
> >>> existed at the detected processor, so it is a necessary condition.
> >>>
> >>> At present, it only implements the basic framework and some simple test
> >>> cases.
> >>>
> >>> TODO : 1) we will add more test cases to improve the depth and coverage of
> >>> the test.
> >>>
> >>> Please check the documentation amd-pstate.rst for details of the test steps.
> >>>
> >>> See patch series in below git repo:
> >>> V1: https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flore.kernel.org%2Flinux-pm%2F20220323071502.2674156-1-li.meng%40amd.com%2F&amp;data=05%7C01%7Cray.huang%40amd.com%7C267a994f51e34371021c08da384042f1%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637884145911708064%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&amp;sdata=m9BlIFlf8IEeSGjycWdppnIMoZTbfmi3tIsuRJZL6cw%3D&amp;reserved=0
> >>> V2: https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flore.kernel.org%2Flkml%2F20220413090510.4039589-1-li.meng%40amd.com%2F&amp;data=05%7C01%7Cray.huang%40amd.com%7C267a994f51e34371021c08da384042f1%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637884145911708064%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&amp;sdata=h1o69SJ5iaVChb1h8a3FZURAeKAj6vlB%2FmR%2BtfmpoE4%3D&amp;reserved=0
> >>> V3: https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flore.kernel.org%2Flkml%2F20220421074152.599419-1-li.meng%40amd.com%2F&amp;data=05%7C01%7Cray.huang%40amd.com%7C267a994f51e34371021c08da384042f1%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637884145911708064%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&amp;sdata=WcXo7q2snNWM8nUSF08HjPDB7UuwFMDTTwe6zLcXHyY%3D&amp;reserved=0
> >>> V4: https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flore.kernel.org%2Flkml%2F20220427135315.3447550-1-li.meng%40amd.com%2F&amp;data=05%7C01%7Cray.huang%40amd.com%7C267a994f51e34371021c08da384042f1%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637884145911708064%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&amp;sdata=Rnn9bLhc1sDkNyBlmwmb8Zy4IJUKwtIq0M0qhcUbdM8%3D&amp;reserved=0
> >>>
> > 
> >>> Changes from V4 -> V5:
> >>> - selftests: amd-pstate:
> >>> - - add print the current scaling_driver.
> >>> - - add amd-pstate-ut.ko into TEST_GEN_FILES.
> >>> - - move "insmod/rmmod amd-pstate-ut.ko" stuff into script amd_pstate_ut.sh
> >>> - - add a check of read back from X86_FEATURE_CPPC in get_shared_mem().
> >>> - Documentation: amd-pstate:
> >>> - - delete the test step about insmod/rmmod amd-pstate-ut.ko
> >>>
> >>> Thanks,
> >>> Jasmine
> >>>
> > 
> > Sorry for the delay on this. I will review the series in the next couple
> > of days.
> > 
> > Did you consider using KUnit for this? I think asked that question when
> > reviewing the previous version.
> > 
> 
> I reviewed the patches and the test driver amd-pstate-ut doesn't belong under
> selftests. I would recommend the following approach:
> 
> - add this test driver under drivers/cpufreq
> 
> - KUnit is a better fit for this unit test driver unless you want
>    to be able to run this without KUnit configured
> 
> - add the test script under selftests - the script then can load the
>    test driver and run tests and unload the driver.
> 

Thanks Shuah. We would like to introduce more CPU benchmark testing based
the amd-pstate-ut next step, it may not be all the stuff in the kernel
module. E.X.  use the script to trigger the tbench, gitsource, kernbench,
netperf, speedometer, and etc. testing and monitor the cpu frequency and
performance goals change, power consumption at runtime. Can the KUnit +
Kselftests work more straight forward in user scenario?

Thanks,
Ray
