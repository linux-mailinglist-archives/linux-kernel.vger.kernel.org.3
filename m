Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E50ED4BF1D5
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 07:02:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230075AbiBVGBf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 01:01:35 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:47186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230044AbiBVGBd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 01:01:33 -0500
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam08on2083.outbound.protection.outlook.com [40.107.102.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDB42532E4
        for <linux-kernel@vger.kernel.org>; Mon, 21 Feb 2022 22:01:07 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fREjpnhinrgxENhxAoX4dLlVKx7mAnhpsTTIt7/BKddiYM4GVmUUOvD2AnUtM80aI2OwyAYYUBNrsdB+mGOX+eOhbxl1xZHPe/JJorxW5hKmgrn80PV6oR6i5MRrWsJ0jh3t9x4r7TcLExBEilfY/4b49rSn9vOHQkVPyefy90oe9FL4aU+wuRdXtG3E6S4LYRU+ouoXL0ATZf6NIYcYjVdGawkYNqzS4jt6YAozB8TNUtB3/Cw/+GD1IddLhtudjTnZfkZ6nIfFzAzj5F5k/QmD7SLVkrPjIWKLawDudSRKWdygnwwk6cLaxFNp8IjuLEQhpT5pi0/JSZ9ueUcmug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=40tnxze86/nvroJo7aa4L0K8g+Oy3FnDTyamIyigIVk=;
 b=dEZMaVDTKS4WR5MY14tVpoBpvvmj8QinWY+Nf94srSghauFjtn/h3kLzWPcdPyz2OKkhv5xTqRZe5eFg03DY2+y6ekylu9SAGh0gT/yfc+65Hi7spE8xOR6JYogn3Hfp6E+KwJbEx4Fz2cC17IKxplXBrsvmOY0Ph8cDPgIWB74fhB+aiGCVtI7rJS/CQHnZly0Znqr+qG3UCt1Kdo1kjbFqeH4dPCZam11Sp2KjzmAjdNq1k4yzJoybFIXren9zQyFF8i7NXByUp5gSdG9vYaVDUWWnCsN3I6o4Z+ml4x8lZlttya/rdyW+6yUPzMXwopEkT3cVwqdXMxFPLYQHrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=40tnxze86/nvroJo7aa4L0K8g+Oy3FnDTyamIyigIVk=;
 b=pgAOI79hvEyAcXUw4Ap8IGccKhKvvY58EsMa7ukOW2rzm+/3ptHNFZL+k9a0w4f8tmI8ITKyYaGoMmoTUfcQLz7Zv1ZQgYuAF2nS2oSFYiP7VhT6oAcdAXC8GwwRZcgjE1ucSWoEcq42vcfwukpsYrrxNwf6RrDGQOK01DXTHQE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW2PR12MB2379.namprd12.prod.outlook.com (2603:10b6:907:9::24)
 by BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.14; Tue, 22 Feb
 2022 06:01:06 +0000
Received: from MW2PR12MB2379.namprd12.prod.outlook.com
 ([fe80::c90d:9f80:a049:b432]) by MW2PR12MB2379.namprd12.prod.outlook.com
 ([fe80::c90d:9f80:a049:b432%2]) with mapi id 15.20.4995.027; Tue, 22 Feb 2022
 06:01:05 +0000
Message-ID: <fed30e08-e6a3-4c20-175e-50b3af02af3e@amd.com>
Date:   Tue, 22 Feb 2022 11:30:48 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH v4] sched/fair: Consider cpu affinity when allowing NUMA
 imbalance in find_idlest_group
Content-Language: en-US
To:     Mel Gorman <mgorman@techsingularity.net>
Cc:     peterz@infradead.org, aubrey.li@linux.intel.com, efault@gmx.de,
        gautham.shenoy@amd.com, linux-kernel@vger.kernel.org,
        mingo@kernel.org, song.bao.hua@hisilicon.com,
        srikar@linux.vnet.ibm.com, valentin.schneider@arm.com,
        vincent.guittot@linaro.org
References: <20220217055408.28151-1-kprateek.nayak@amd.com>
 <20220217100523.GV3366@techsingularity.net>
 <a57dbac2-1b8e-ea5c-8b6c-3a97ac186ad9@amd.com>
 <20220217131512.GW3366@techsingularity.net>
From:   K Prateek Nayak <kprateek.nayak@amd.com>
In-Reply-To: <20220217131512.GW3366@techsingularity.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0142.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:6::27) To MW2PR12MB2379.namprd12.prod.outlook.com
 (2603:10b6:907:9::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e4c35555-6614-4d0b-928f-08d9f5c8b63d
X-MS-TrafficTypeDiagnostic: BL0PR12MB5506:EE_
X-Microsoft-Antispam-PRVS: <BL0PR12MB5506E05C393EEAAF5AE90356983B9@BL0PR12MB5506.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gdJDHf8BdlmJu6S8aSuhdz3RlMM/8fbkbSZ3Fy4gkRC8HvLCg4nmj9GGazyxoS1Zccp3KV88AqCj+DcXCxPmjUd7KrD8kW4MLN4xMeg+iXxA5ej+Rj4h67h1tx013VUaT7cw9BdZTK0NqFaFiFd0wjggmUbcZW6LEfhGSxOORK/lYJefSkpHahHaztNxfFP8BhpGAYERNtHCGYEnOLPk1u8sXBDQaTXgM4bVq4esyzQmU+e88b4vOPwV4U3zyqdFy/haeDhPE1avYPKqkhq+T6SRmzREBudl2QrDiMC4XUVruDhVZo+/XikMrcoi3abCv7ZKp5Vypg6Z3oT62RGS9/q1lNyzHPG/WGKVKHTuNKLH0KC7wBPH9WB9jgfLXp3XzTy+v1JhqXuTf75pl6xtoFhb3RIB71YSEEoAimhkdaMpMF0iX2vPQwW9yyhvy+LMQR8GLWFq6uX/kHKAXgTkS+jBd4KmnN2+vuto62JO1LiXoJrp5axVETkDKvhp+zOW99j4iU8oo/ZQ7l2db5AsaZfmzKPKcr7q4Irx+hTY199clCwnyLwuBK+B4jZNzl9exEWUFZxPH3FS8nUjNODJHDvE35lcWXgHmbZDc4Hyut7QHqlz8XMDGm6XBdlKQSS7X/j419JpP7fRP709ykCH7jXoaAUqzmRgPQENEM4cd0y4cUeiv19UMZLiGjKti/Ny1U+IUIsNIX6YoSP5Ll8VNQPI9b0z7s5nWO1JCn69s1k=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB2379.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(26005)(5660300002)(86362001)(8936002)(186003)(2616005)(38100700002)(2906002)(6512007)(31696002)(7416002)(316002)(66946007)(66476007)(31686004)(66556008)(6916009)(53546011)(6506007)(6486002)(8676002)(508600001)(4326008)(36756003)(6666004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RjFZcXVDZkVzZHJCT1NBL2VOTnBvVFZ5dEVTY0VQcURNdEIyYVd5eWpYTGto?=
 =?utf-8?B?TUZGUGg5Q01JS0FuM2R5dHRGVlFUaWxmUnBhVFNWWkNUK3RaQlZrSUdsbTVh?=
 =?utf-8?B?d0JLc0VYdkJEOEs3M1REMCtVMmZkT0tKZTdLZ3ZIUHJkWVdkcDZRU1k3Sjdt?=
 =?utf-8?B?SERzRHNZZnJueHhFQUEreVl0aFArM01RNi9sWWFocVdsODdTMjZIcm9rTVNl?=
 =?utf-8?B?WTdpbGtTVW85dlVyS1RGdzZhUGJnQ3FLdm03aWdUaUFtYjBMR1cvbDlzcUkz?=
 =?utf-8?B?alpUMWN1REhpR3FUOVFESW9SWkVnM1dOUVluRkcza2YzM2Z3R3Zya3ZKOEJU?=
 =?utf-8?B?Q2dqZExpV1ZxT3FUU21qNUlyVWtIeHVkWnI3em5McU5OM3ltMmp6Y0hMMC9w?=
 =?utf-8?B?NTROOFdaSnY1K3plUXlFbjcrYjU0VWFZUHBOUHV4SnI5VWcyY3hNQmI2c0V4?=
 =?utf-8?B?MGhITEZtVmtOUnNyV1QxdUhielRQZE1BT002ZG54S2xvQnNna3lIWnhpRHk4?=
 =?utf-8?B?aHVQNXFXWG1objB3ajgvSFhLZ0J4Zk9IdU1xWjRKTk9NNk85eUpua2VYOTJO?=
 =?utf-8?B?V3FOTmNDbjNHZ2labXBWVmZUM1FncC8rVGIyMjhXSzVzS2ZNcUNIUkJPZ0w0?=
 =?utf-8?B?SWJWWUtmRXRrN3BWVm1XWllMdnM5bmtjUm5TZlk1VzJwK0Vra1c2TzMxM1RO?=
 =?utf-8?B?NitTN1NHQzZKdW9FOTIzSVpBWHVXVCtEOFlka2ZZVXZaRDZnNTV3b1k5MTlW?=
 =?utf-8?B?cTkrQVdmWkpxZkUvNkFTUDJ6c3JsQWhvckhWOURyWjFxc3F1Y3FQZDFtTlVD?=
 =?utf-8?B?T2NHeFZ1NjdqTkhjSWtSQUtFRDRFZmJDRjBrODJzbUZyMzF5YUtZekdWYkR2?=
 =?utf-8?B?YWU5bVYrbVVZd0t2amdaS3kyOTE5RXNTejNzQ21UVEVtdDVJaktnSHhTbmFw?=
 =?utf-8?B?TjRRY3NoTFgrU3NxdVdRc0x6MVpPcDFzRDh4YXVPdWFoS3dUQjBNOCtBbUdP?=
 =?utf-8?B?L2IwMUoyS1htOHdxQVlWMCs5YWVpN2VKYXRwUHJqTmY5QUpiVjA2akc4MkY3?=
 =?utf-8?B?NU5QenE5VllsNUJpcVJicmwvTUdWY3hYUU9WSnBvK0JEd1hIcWZ6MXhrTGJL?=
 =?utf-8?B?cHpwL0crcmNLeVNHNUJGT1JsZ1ZtSDcxNFR4anpUTnR1OFRzTXFHQ0IrL3Bn?=
 =?utf-8?B?UUZ3VUxPYUNOVU03cmZobmdoZlFRSXJOcnZwWFR1SGx5aXlHMjI5dXRLdlpM?=
 =?utf-8?B?eGtGanVQdzFXekQzUkVZMHgvNERhK0ZvaWN5c3crclNTRmI0cHhTcG4rVVdZ?=
 =?utf-8?B?aHlNNVZHVDFNa3N1Rkl6SlYvak9SQ1lpNG40WXQ1ZEU1RU85VTV3SU5KQ3JC?=
 =?utf-8?B?MkNsTngzUUpQeFF0L01PWWhlcnBrSVpmOCsvNmFaQ3hJZEdKbWNPaEZYQmJD?=
 =?utf-8?B?VDJETm1LdjhRallxeHg2ZnoyS1dRajI1YVBndFFiSC9xOU1kamw5ZjEzTVlI?=
 =?utf-8?B?QXFpZTNmUHZJYlRwSGtXK2FSZXZvK1lyZTkyRXNMZUE0dHlxdUxURjE0eWJY?=
 =?utf-8?B?M05ibk0zQmRmWnJPK3VoK1VZLzlPbkFpSEU1cHMzTXRqdEI3UzR3andEY2Rs?=
 =?utf-8?B?RC9OYmN0RXNoK0o0K0FreXJOUS9qQjdweW0xcXV1b2F5amdYQTd0MmgrN01h?=
 =?utf-8?B?WmN4NUlrZ1NMeENKV01QcHE3ZzBDbkpZQ29jR2VubjBrMncxd29zQU50UDla?=
 =?utf-8?B?dGJNd1ZrZGhVbC8rbWV0NW9pcnNuc0plUVN3ZldXQU00Uzg2S2ZzTHVjRWdz?=
 =?utf-8?B?a0FSbktrdGo2WklwYWZiQzVENXZFUEd3L0Y4NHo2Z1Z1eEZpbm9rZ3c3N0NV?=
 =?utf-8?B?SWtlRHovbmJUOU1SWktHTGhJS0psaFZlWUpJelpVajk4bk92WlV4cU9jSEhB?=
 =?utf-8?B?Kys2N3Jpa3NGQnM1ZVpwOERralo0SnNLU0tYWWNBY0ZoWU9zSGRHMFo4UGtu?=
 =?utf-8?B?ZjdPSTcrTzFqeWdOaHV2MjNBM1RMbEErV0IvT2svOU1aSVRxZHltcE5jNXNy?=
 =?utf-8?B?azVlY3RCUll2NjA2WnVtV2oxd0ZoSDBXSUsyQThuYVlURHJFTjBaNU0xU1lj?=
 =?utf-8?B?akZNUDZnV1NOUGtNUndLc3B3ZStqWDBWaHphTGUvUHZNNE5pcnN1RW40bFBM?=
 =?utf-8?Q?XnrQTqVdZaK055cVs7ZKvQA=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e4c35555-6614-4d0b-928f-08d9f5c8b63d
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB2379.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Feb 2022 06:01:05.5638
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HpSSw+xnLeU7nnwdqoiBo5Od2RbGoPMpsbn5ew7IcIarCtz3GxtxSmTH2vqXlYrPGmvTHm1u1vCoKgy1Mtjy/g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB5506
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Mel,

On 2/17/2022 6:45 PM, Mel Gorman wrote:
> I don't object to the change but I would wonder if it's measurable for
> anything other than a fork-intensive microbenchmark given it's one branch
> in a relatively heavy operation.

I used stress-ng to see if we get any measurable difference from the
optimizations in a fork intensive scenario. I'm measuring time in ns
between the events sched_process_fork and sched_wakeup_new for the
stress-ng processes.

Following are the results from testing:

- Un-affined runs:
  Command: stress-ng -t 30s --exec <Worker>

  Kernel versions:
  - balance-wake - This patch
  - branch - This patch + Mel's suggested branch
  - branch-unlikely - This patch + Mel's suggested branch + unlikely

  Result format: Amean in ns [Co-eff of Var] (% Improvement)

  Workers balance-wake            	  branch          		  branch-unlikely
  1       18613.20 [0.01] (0.00 pct)      18348.00 [0.04] (1.42 pct)      18299.20 [0.02] (1.69 pct)
  2       18634.40 [0.03] (0.00 pct)      18163.80 [0.04] (2.53 pct)      19037.80 [0.05] (-2.16 pct)
  4       20997.40 [0.02] (0.00 pct)      20980.80 [0.02] (0.08 pct)      21527.40 [0.02] (-2.52 pct)
  8       20890.20 [0.01] (0.00 pct)      19714.60 [0.07] (5.63 pct)      20021.40 [0.05] (4.16 pct)
  16      21200.20 [0.02] (0.00 pct)      20564.40 [0.00] (3.00 pct)      20676.00 [0.01] (2.47 pct)
  32      21301.80 [0.02] (0.00 pct)      20767.40 [0.02] (2.51 pct)      20945.00 [0.01] (1.67 pct)
  64      22772.40 [0.01] (0.00 pct)      22505.00 [0.01] (1.17 pct)      22629.40 [0.00] (0.63 pct)
  128     25843.00 [0.01] (0.00 pct)      25124.80 [0.00] (2.78 pct)      25377.40 [0.00] (1.80 pct)
  256     18691.00 [0.02] (0.00 pct)      19086.40 [0.05] (-2.12 pct)     18013.00 [0.04] (3.63 pct)
  512     19658.40 [0.03] (0.00 pct)      19568.80 [0.01] (0.46 pct)      18972.00 [0.02] (3.49 pct)
  1024    19126.80 [0.04] (0.00 pct)      18762.80 [0.02] (1.90 pct)      18878.20 [0.04] (1.30 pct)

- Affined runs:
  Command: taskset -c 0-254 stress-ng -t 30s --exec <Worker>

  Kernel versions:
  - balance-wake-affine - This patch + affined run
  - branch-affine - This patch + Mel's suggested branch + affined run
  - branch-unlikely-affine - This patch + Mel's suggested branch + unlikely + affined run

  Result format: Amean in ns [Co-eff of Var] (% Improvement)

  Workers balance-wake-affine             branch-affine           	  branch-unlikely-affine
  1       18515.00 [0.01] (0.00 pct)      18538.00 [0.02] (-0.12 pct)     18568.40 [0.01] (-0.29 pct)
  2       17882.80 [0.01] (0.00 pct)      19627.80 [0.09] (-9.76 pct)     18790.40 [0.01] (-5.08 pct)
  4       21204.20 [0.01] (0.00 pct)      21410.60 [0.04] (-0.97 pct)     21715.20 [0.03] (-2.41 pct)
  8       20840.20 [0.01] (0.00 pct)      19684.60 [0.07] (5.55 pct)      21074.20 [0.02] (-1.12 pct)
  16      21115.20 [0.02] (0.00 pct)      20823.00 [0.01] (1.38 pct)      20719.80 [0.00] (1.87 pct)
  32      21159.00 [0.02] (0.00 pct)      21371.20 [0.01] (-1.00 pct)     21253.20 [0.01] (-0.45 pct)
  64      22768.20 [0.01] (0.00 pct)      22816.80 [0.00] (-0.21 pct)     22662.00 [0.00] (0.47 pct)
  128     25671.80 [0.00] (0.00 pct)      25528.20 [0.00] (0.56 pct)      25404.00 [0.00] (1.04 pct)
  256     27209.00 [0.01] (0.00 pct)      26751.00 [0.01] (1.68 pct)      26733.20 [0.00] (1.75 pct)
  512     20241.00 [0.03] (0.00 pct)      19378.60 [0.03] (4.26 pct)      19671.40 [0.00] (2.81 pct)
  1024    19380.80 [0.05] (0.00 pct)      18940.40 [0.02] (2.27 pct)      19071.80 [0.00] (1.59 pct)


With or without the unlikely, adding the check before doing the
cpumask operation benefits most cases of un-affined tasks.

--
Thanks and Regards,
Prateek

