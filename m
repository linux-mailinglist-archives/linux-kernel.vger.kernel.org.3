Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 650F34C1846
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Feb 2022 17:14:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241271AbiBWQO0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Feb 2022 11:14:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234136AbiBWQOY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 11:14:24 -0500
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2046.outbound.protection.outlook.com [40.107.220.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBF4FB45BB
        for <linux-kernel@vger.kernel.org>; Wed, 23 Feb 2022 08:13:56 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Hd4a16fHglmbTLe8TAJ3S64UtUICRhj/Sy8dW5e0oadPjRxD2UQxeCW4Xc7a/Nq8dpyoPJ4buW1+ziZwWukA2z22lwdFbbIAvv7G9Y5IqojISPGo8XafaPx/zJR/U7mvSavLiKKGjBJ97AhJoTn+j8ppqrwQD9885+1h9lrhTmEBGQiJ6Aegu3fhivpuaoeWKc/Q4B/CM7BQkNfBNfzWK3Ms213yIXUoiJb4mMrk1S5QietIeTw5VELpeERrjLx35Gw5VwEhgZtKuoAnlTYo1lpuWhujrk05qNGYhdkrEqEoAmqxkm/8pQZpxJrxdEL7SNmCvGz1zg9P4iA73LnXjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=64RdqPZdxyKzKgRykwMVTou8TeK9SljeH5cNR+IXsnA=;
 b=cFSBIbND1LvquscJ39f65Pkf9BqShdAsfRdjUPbfnZ1xnivxZJlE4m/qVYVylfmG29/yxvhX0JCYnkf6qyv/5oTN0Jv+hjq1FmjxqUtmq4E7uOUov/D7zZYVxoXPoH82PZXitQM77XABV7vfl/JHBDwu+QblFC1QmRord3uA/wMCZakLApWibn1MbmjadqwNDZFsJixz55SyRzd7j0bMblNiVirdKwdowisfZv2kX62lnRnwJVnduvbKgIP3XjsE8UVl85VucSfNAnwanh/xrAOig29UeHww8PljIH8ROsgrbHLgQzBrXpiZfigJ/Uha9EAQ5mjd7tHB1E83cH9O7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=64RdqPZdxyKzKgRykwMVTou8TeK9SljeH5cNR+IXsnA=;
 b=p36K/6tRRcvY/b2Gkp/puIs7pbGFfa90dwUdB4sITiEABdJyVcKGIZZMqZBAPvOUwquz+1I0SXij8M1KcTIdtSnKkI0LsfOt0imYhuzcMBpzamW/ShxbXR0lrSxB4hIqIgGclxmALNlJ6Wx1ojadMMurJgeURLWejOFow7OxKsc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5874.namprd12.prod.outlook.com (2603:10b6:208:396::17)
 by BN8PR12MB3634.namprd12.prod.outlook.com (2603:10b6:408:47::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.26; Wed, 23 Feb
 2022 16:13:54 +0000
Received: from BL1PR12MB5874.namprd12.prod.outlook.com
 ([fe80::8d44:d69b:b031:1d50]) by BL1PR12MB5874.namprd12.prod.outlook.com
 ([fe80::8d44:d69b:b031:1d50%4]) with mapi id 15.20.5017.023; Wed, 23 Feb 2022
 16:13:54 +0000
Message-ID: <3c6224ca-c0da-7ba9-1396-a2e74c4a40e8@amd.com>
Date:   Wed, 23 Feb 2022 10:13:50 -0600
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: [PATCH v2] kernel/sched: Update schedstats when migrating threads
Content-Language: en-US
From:   Carlos Bilbao <carlos.bilbao@amd.com>
To:     Phil Auld <pauld@redhat.com>, Peter Zijlstra <peterz@infradead.org>
Cc:     Peter Zijlstra <peterz@infradead.org>, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, mingo@redhat.com,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, linux-kernel@vger.kernel.org
References: <20220126152222.5429-1-carlos.bilbao@amd.com>
 <YhYKL4hxx4TNKHGD@hirez.programming.kicks-ass.net>
 <aac8f860-c01f-bda0-9f1b-029b234213c2@amd.com>
 <YhZSqd+d03oWUPP6@lorien.usersys.redhat.com>
 <0e42c46a-ccc4-e793-00b8-ae407e06846f@amd.com>
 <YhZXGv34YTV5omKq@lorien.usersys.redhat.com>
 <b7a28537-8bfb-7f0d-5ed3-f301983e4e30@amd.com>
In-Reply-To: <b7a28537-8bfb-7f0d-5ed3-f301983e4e30@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL1PR13CA0246.namprd13.prod.outlook.com
 (2603:10b6:208:2ba::11) To BL1PR12MB5874.namprd12.prod.outlook.com
 (2603:10b6:208:396::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4753ee1d-66b9-4dce-8180-08d9f6e77cd1
X-MS-TrafficTypeDiagnostic: BN8PR12MB3634:EE_
X-Microsoft-Antispam-PRVS: <BN8PR12MB363445AB1B195F249F1FAA8CF83C9@BN8PR12MB3634.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DAMZwa/0Oi8hN0CEJsjm4RgjofvuMfezp5wevFRg+yvAmgLjfPX0mknNYMFB0xDjMTxudM6SVn02lgQFON9bhDkET8UloKjdln53KPeIJ9wGnkMqWUniw3y7t2MgfdgFO07OAn+rTyemfQIlt9grenTuGsV55RvHCrJ1L3Ciouin6Aa4L9wPYZWxdHvGn+EpLU+tlOqoDZJGLc8dv8A0pLP7WDL+wCTHd2j/uhRb2xxdfuVhrVID3ybG9aFxxDE+/gOtnExc4oaCScxCbiuyS/u6m0pm7ai2bDjw/vT5Tui8zo0TSPICMpXAdaZ62o+/9V/ID0rkNPJEG5hRiLyEeDUZ1arnC/+x0+LkCTOr540ljrkzyOz27tK3yNb2z3MvD6m6HD0iiZbpUJA65fGZ5EZpsW5uaKyq+B7EIQ8EgB+bdyUAFcq3lqa7/8r5+A+rlMknj3YyVeg7uwytM7fpSfesZYd76U3I7lWNiTixGEYe+xOZAC2dmwdoN4CupiDmRU6SCh5qvX5y1ljh65iQF/7hSWqtLO1jkLhdSCT05w8THgWfSph+85juvAVYEUU+fAxI2JsG7qbQDuWt9OxRwVnltggoF1ul9jhSQ8/j6EvfmialgqYMdkl+SV1gM6RcJHaG63pb0177X1aNKGdwwVTO+lTvbEFCPVCBesOBn6YK7ysazk2K1hyNcMUa98Pp/1x1TP9ividUiHVqXjr/6EJdyTA73+jing3etS/FgAMZCufH8J2v85Bz4N8tIM0U
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5874.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(36756003)(86362001)(6506007)(186003)(26005)(38100700002)(6666004)(2906002)(31686004)(44832011)(508600001)(316002)(83380400001)(110136005)(4326008)(31696002)(6512007)(8936002)(4744005)(2616005)(15650500001)(5660300002)(8676002)(6486002)(66946007)(66556008)(66476007)(7416002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aURjTTJBQjZ6U2EwY2poQjNDNlp3SmQ0Zk12Q201K25sVUp1M2dQUUthOVl6?=
 =?utf-8?B?YktBOGJDeDZPVHQ1YVl6WVNweTl5aENjQ041N2tKVkY0YXNWS0FMUGxKMUhw?=
 =?utf-8?B?aytMeDh4VnoybUVEVUxYbTlyenFCd1pweEJodk4wc3FtTUN2TFJXcjR0K2Ex?=
 =?utf-8?B?NW1xSGxWOVUzck82SkN1MUd1cjBUVzV0RlZzc09pTlhWWktLSk94d1ZnYndv?=
 =?utf-8?B?ckMrZkVncUJUSFJWOFlJY3VDVGpoUHA0eXFGVHpiRVFVSm9SZm5qdnppVHQ0?=
 =?utf-8?B?SEo4NmVQMXBUMENIeWlPWExneE9GOTZUUXpXdTNFWGNPQ2hEWmJpTVpyZXJh?=
 =?utf-8?B?d0ZFb3VERU56bkFmNkx4aE0ydnhHR2xiMHBYSkt5UnlLdlFZWnFOM25lWkc0?=
 =?utf-8?B?bnRJLzBxeVVacU53RWJyY3Y5dHUrbllSL3A4cGRUU05NMTlaL2V5UEY4S0RQ?=
 =?utf-8?B?NmZLMjJqSkNSb0dWS08xUDVnRk1md2FucHZ6ZUVVWWJJVXRWTzhSUkZsMWFN?=
 =?utf-8?B?Y3A5YzVLQXVFeW9WM2VXaC82ZWZDQlhHc1BUNFIrRTFYWWdpTnVQZnZQUmxG?=
 =?utf-8?B?YWN6bWZGOFZTMko5d0dzTFJmSmtDNWRLSk5PYlhXT3NDMmlIYk1VTVduWWNa?=
 =?utf-8?B?eFVYK1p4Rjl0NXpkVHNqajhnWWNsbEZReU1QdkM4V3FxTFo1MGdzaEE0ZkM5?=
 =?utf-8?B?MHhsamhaaVZRSkhmVUtDNUNCMHR1RU10L0g4YXV5NmRwazlUbXBialdacUNk?=
 =?utf-8?B?VjIwY3R3YmwrSFdKOHg3Wkl1Wi9QbEV1a29Nd2lVVTRJbUI0b2R4Z1Nmcy80?=
 =?utf-8?B?dkpOZDB1K1RwdlJMNktmWVk5bTVQdUFPc3pnR1dEQzBldnd1eDlydXN2YnFW?=
 =?utf-8?B?b0xNdk9SL0htcE9KUE5WMXlYZXk5WFdmQ3ZEcGRiUWtDUERTSkIyQURZVlVw?=
 =?utf-8?B?NTMwNUR5dy9vZHZSNkJXNG1waUw2UnorTTZWL01CSU8rampsNEdKNGhUdUVl?=
 =?utf-8?B?Vy90SGo4R08xeGtIbm5aamQxTGJveEJ4dTNidVQvSjNJTWdiOHFpUm05aHR4?=
 =?utf-8?B?bUtnUituZXoxeFZtYXFxNkhXd3pTL05EYk9QaHFhMDhKSlEzM2dXTHhJVGNG?=
 =?utf-8?B?bEQxVkpDbHVMcXIyV0lRYnBKeUx2TGxPVDgvZHU5SzRlZ1I0VDVBUnZwRHhj?=
 =?utf-8?B?T0FuWjVGditDd0xsbmZ2TkxDWlBZckJIQ2hiUkJraXhIdDRodlFNVWhHb0VO?=
 =?utf-8?B?NlQyYXBxSXRhRmplWlYxREhRMlI0QWJKNGc1a2tKMlVLcDBZYTY2QVZ2VE91?=
 =?utf-8?B?TnBRR3hNQlp2ZEFMUDg3UU5WczhJSjAzQWRPVW9MeldpZklXQytJWFplaWYy?=
 =?utf-8?B?Z0N3dkpPdEtkMmt5Z0hldmdWZ3JwUHgvMGh5NFFtRG80cHc3Y2lFZXBkYUpz?=
 =?utf-8?B?Wm9LNFRuL3RkMmJoMjBYWithOGxVVWdteEVXZHd2VDlMUkZNNTFhTUlBdWxk?=
 =?utf-8?B?VHl4c1cwZmZEdEViLzlSQkRVcDlleTMrSWZXN3c2WXc0MUl5b2hRbU11Vzhu?=
 =?utf-8?B?eXhoaEthNm5GT1FodjRvRXR4YzJuQWNZY09Hallxek9SQkZlT2pkdWJ4MkNP?=
 =?utf-8?B?c2V5MGljcUoxYU5JQXhCbUhPZCs5Rll5emE5UmVHWGZZTEd0bSt1eVFjSUdZ?=
 =?utf-8?B?NHVERGdJK1FkTFd1WHdhSU85UW5majhOZkUrOC80azJ6SUcwazZFT0dEVXl5?=
 =?utf-8?B?OUl0M0F0bkxsdU4yanovWHNkTDQvQk1DclhVZGVNU1VRRUxsblNuakVsaUR4?=
 =?utf-8?B?ZFVqZnd2ZGlhNURJQzlsejRQRklINlh0OXF0WXZ5Q3NNeWc1VkFTSExHc3Q3?=
 =?utf-8?B?SWY0QlZBUUtLdlp4YXBTTmNxV1dMQmR3T1NUU1BRZjRVNnJnTEx0cnlRZit0?=
 =?utf-8?B?Z3F0MWEybHNQT3JDZWJkVlFKWTROdU9xa3JHUTRXaE5Ua3Zxb0RzdEtXdVk2?=
 =?utf-8?B?Q2I2bWlnNzlMcHFVYlpHUjZFRHl6eWx2WUhpUmxkUS9aUTR3L0ZoVzU3cDhR?=
 =?utf-8?B?QXdTUEFSU2wyVkpDOE1lWE00MXQ4L25Tc3FXL3JDVU55cDF6VG9PVFRQMG1Q?=
 =?utf-8?B?THNiVmZ4aDZ3VzFuYUlaM2FVMmpYV2VUTVJ1V2V2YUg5OHVRM0dVR2RlVVZU?=
 =?utf-8?Q?4ZAMNMMLzUonlZaD2s+kI64=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4753ee1d-66b9-4dce-8180-08d9f6e77cd1
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5874.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Feb 2022 16:13:54.2869
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mUN/wSZ9/lKz4WJ0hJ49qi6LwYqCQOR7KGg9DQWn2DGPJWFEDqa9lckjtCEMif0xMSgcoQnyRv3KwcDQuF/esw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB3634
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The kernel manages per-task scheduler statistics or schedstats. Update
function migrate_task_to() to increase the counter for migrations.

Signed-off-by: Carlos Bilbao <carlos.bilbao@amd.com>
---
Changelog:
	v2: Update commit message, don't reinitialize sched fields.
---
 kernel/sched/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index fcf0c180617c..1360e501c737 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -8751,7 +8751,7 @@ int migrate_task_to(struct task_struct *p, int target_cpu)
 	if (!cpumask_test_cpu(target_cpu, p->cpus_ptr))
 		return -EINVAL;
 
-	/* TODO: This is not properly updating schedstats */
+	schedstat_inc(p->stats.nr_migrations_cold);
 
 	trace_sched_move_numa(p, curr_cpu, target_cpu);
 	return stop_one_cpu(curr_cpu, migration_cpu_stop, &arg);
-- 
2.27.0
