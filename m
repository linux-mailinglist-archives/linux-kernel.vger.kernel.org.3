Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2392458C9B4
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Aug 2022 15:45:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243129AbiHHNpU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Aug 2022 09:45:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243077AbiHHNpK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Aug 2022 09:45:10 -0400
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2063.outbound.protection.outlook.com [40.107.95.63])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42711BF6D;
        Mon,  8 Aug 2022 06:45:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oQKTX6yPhFPQKqLmul7FrbZAz7hEeaLWswwI65LGHXkRBvwrEs+wj6FHaJgd9U9Ttqrf2FrEb/YpVZD58ctr4uKxVxg32tWhJe7pBP57wneMekjtd/7r4cTqvkkmMcxRtf5SUeVrgE+NGe7gRfS8P0JE7OC/wnPLU3fWHgsIUzC501F+YPI6z0KtZxEovNEqOiGKpKNKPQU1FHJrNXe40ygHgXJJbYTFGhEgcxdtvGOyJqDYQVJTlCmxGjEedGHil0qARggLOQCED/6WMe9Pc6TcoPHcAdhiRVhucE0cq7nGqFSR5N2CZko81c+ay05NnTJm37XX88qh1rqdCp0spQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jrCJQV0T2NEjYL9GKh4+r1Cj9R9UDXowEW1H/9zTNyw=;
 b=Cc8IeALkXjwBnF10m42zYww6qmegmzTmchjudpv2YRwNDNAzGU42BGk7rVQ0HJrOIZywBrMhyA1KTuebAhDLry1+EhLBCBwRXuKQFwwSYR0Jk7GiJFzwciQ5y9hVLxoo8ocK0mMUhhNOGlSywrDfIJ5Wdidy0kAQesg+r204H/FgxhdeQ/0t/3RDqw8XGoV2BD+/3mHxzlKfefGcoKUSf+xz4yg301505mi0uFKE/HO0h3c+kIXRZ/BdJkK8HBaMqsha32AZHpPaWHrZC9YsVoGwGkojg5zaGjfBt99KPtgiq0EyLUw8Vpg8Et/ylch41gwytqteurLecyTCH1HKeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jrCJQV0T2NEjYL9GKh4+r1Cj9R9UDXowEW1H/9zTNyw=;
 b=oSPprlb2VYs6UgQ8SZBMqY7igXZTlKzzEybFrghLDTntCVWnNwT7SNaLkoeXcaKl2f0iHRsnHWFrxdYvMNiCBushjdHdI8sG721yKVDTeeZw+3AeMaU1kfpgKA3fZtHz+Je9lTRfesNlsfwT3WfV2SEJwqOlFVazQsQJNoBmPRU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6222.namprd12.prod.outlook.com (2603:10b6:208:3c2::19)
 by MW4PR12MB6731.namprd12.prod.outlook.com (2603:10b6:303:1eb::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.14; Mon, 8 Aug
 2022 13:45:04 +0000
Received: from MN0PR12MB6222.namprd12.prod.outlook.com
 ([fe80::41ae:b861:f98a:3e39]) by MN0PR12MB6222.namprd12.prod.outlook.com
 ([fe80::41ae:b861:f98a:3e39%4]) with mapi id 15.20.5504.020; Mon, 8 Aug 2022
 13:45:04 +0000
Message-ID: <fd0ae1c3-a502-93f4-ab86-20c181b88e77@amd.com>
Date:   Mon, 8 Aug 2022 08:45:02 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH V2 2/4] selftests: amd-pstate: Trigger tbench benchmark
 and test cpus
Content-Language: en-US
To:     "Limonciello, Mario" <mario.limonciello@amd.com>,
        Meng Li <li.meng@amd.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Huang Rui <ray.huang@amd.com>, linux-pm@vger.kernel.org
Cc:     "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Nathan Fontenot <nathan.fontenot@amd.com>,
        Deepak Sharma <deepak.sharma@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Jinzhou Su <Jinzhou.Su@amd.com>,
        Perry Yuan <Perry.Yuan@amd.com>,
        Xiaojian Du <Xiaojian.Du@amd.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Borislav Petkov <bp@alien8.de>, linux-kernel@vger.kernel.org
References: <20220804054414.1510764-1-li.meng@amd.com>
 <20220804054414.1510764-3-li.meng@amd.com>
 <3fbc3697-1c9f-81db-31d0-a3799ba868e4@amd.com>
From:   Nathan Fontenot <nafonten@amd.com>
In-Reply-To: <3fbc3697-1c9f-81db-31d0-a3799ba868e4@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MN2PR22CA0005.namprd22.prod.outlook.com
 (2603:10b6:208:238::10) To MN0PR12MB6222.namprd12.prod.outlook.com
 (2603:10b6:208:3c2::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0aa48017-58f3-4414-d533-08da794432cf
X-MS-TrafficTypeDiagnostic: MW4PR12MB6731:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NDFTdshuebbC/IVhwCV9OnT7ED902+9BCNL6uggH8cvt5cQJLQ/Ez09dA6+qbwhqlaffufoAHrMaaNOjfBIPyUhGC98iCANX+VUWxeccPg0tG7YfRAyXHNxRvg7eSaEDqZt9kvpyEpTTadNMI656ShyUUmUm/9oMhwcjOFikfmbtTa8VrBR5wwuZ2n3vWz4VwJHKgLtIEiuthGjN24a3bsiYxJrVjDU0YI+xoA/ChQc7mvWMhN3fckX/npThhtBTifPUuMdK2WZdnw5LqR6k+KsoFNOXJdwook2L6rVwZOdm4wHo64BM6OZuspdG1tXor65+KdEYyeuGJmKA1D6xJmCjO4Khpzr+EJYBm37cveqxof7aiO6xunVxHVXtYOFv3VsZRCnRjTdchpPSSNqWcnkTB8yW6UF6dOSD45eug9xQjGE/FwVEfpruQBQTtH08jPg9roS0CCaf7VYloEBRiiCEnQN6/xoJPlZflQkv/syGN7cpxLLedKq9SJW2yEoq9KwL71AbEmgBT4YlF3ie42CGAr3AQwmQ1IiOrvfQh3n5cFOd2xQjoimsW/212BVT4m/L6wCInACnHqpORZLw5HIiyCZD+7Gw88aAHsDxvKBRNqwgPqy3+BtPcvvlf+WcW6WbA8ZckUj9iBWyhbq3fjbhjDRZ5aIQ+YU/5VBlztN/Ge4FbaX7eDl1/yISFkjSfkeOsiZUuJzlRoNylKL0K3RioMl5D1ZBusQ+rZbEnpMgvpA0sfi2740uL7jTtmy4dY3C8725Ig/NW2AQtRqlKc/jqDPZs1Ac6XPI06W7tafD/5BTQ2BtgVNkEXLimbtSf3bHRzPJDMa87c9nHjCEWrIwfdYMkQxehfbRUX7bMSk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6222.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(346002)(376002)(136003)(396003)(366004)(8676002)(8936002)(30864003)(36756003)(31686004)(4326008)(316002)(6486002)(5660300002)(478600001)(54906003)(110136005)(66556008)(66946007)(66476007)(41300700001)(31696002)(53546011)(6506007)(2906002)(186003)(2616005)(38100700002)(83380400001)(26005)(6512007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TlV1Mnd6aTBwR25jODhOVUp0aWlkSVdtYlVCeUtGajV2Y0lxRkd5WmFnM3V4?=
 =?utf-8?B?RWhHVlZWU1IzQU9BSjYrU1p3RHZvSG54S2Q5Q2M1WnJKaGdva2swMFh3RUtn?=
 =?utf-8?B?VHlBb0ZFTVFXSzlHbHIyQXpaVlp1M3poQllUMXhub0RNdXU1dXNqQXJkcTBO?=
 =?utf-8?B?SUlQN2dWRHAxSTQ1TVVNclNQRDFYUWxFU3NLTmFTMDRScEFxWTJRY0VQSzl3?=
 =?utf-8?B?REVWTEhDM3l4VWpNUC9vZEs3ZWpJaDkzdUZlcm1qVkxxeVdkM0xWWWZTQmUy?=
 =?utf-8?B?U2plTTlQWEJpOVI2NmdMQzgwY01XK01BRzNFTTNmZmNHVWtrb2dUUFpNZ1N1?=
 =?utf-8?B?ZnFkdHNnUkNBOWM0YzdGMk1JYk1oaDllWk9KS1RJZnhpb2h2dHkxd3VacWZm?=
 =?utf-8?B?Q2VGRGRIbEdwd1JZSG9vNVpKbVB6TW84Y0V5UDdLY0Q1US96cXBTUStEbGQy?=
 =?utf-8?B?Z3FvUHJXeS9MaHZqR20vS2dZZXlCY0NvK20xMXZnS253U1J6bFdaZTFyaFR6?=
 =?utf-8?B?QnBLR2JYWE0zS3JNL3RqbHB5UXhGV2V2QVg5S1IrOERRM29zYUNGNlJ1dTdY?=
 =?utf-8?B?RFFVTUZmanpmajVYbkJKWkdCdCtidFFjTTcvdDNVcGJoRXJzbUMzbG10dlVQ?=
 =?utf-8?B?QXpza1pnU1I0ajJsdU9lVVQxYzRVazYvNGV6TGRLOWtGNkRUbE9KcDdwdDcv?=
 =?utf-8?B?OU1jWXBlWmFDcVBYdFdxRXFVazZHQ2E4RjdXUEcrTEJjckEwaFdFbWFpU2la?=
 =?utf-8?B?QXJ4MUd1aFhtUVFJY0N1a096NDFsTFlEeGlvZlo1aDFISEVBUXg5c2RhbXB6?=
 =?utf-8?B?NnhjdTYwQnVLc3lDLzc4bGxUdFJYMjdOWkdnRmFKMEZSNkk5Z3ZJMDc3T3A4?=
 =?utf-8?B?SUU1aU1WWXlCcVRrUlZxa3kyOG4yUmdoME40bXB0YmtzUGwvMytoeENsQmlH?=
 =?utf-8?B?VlM3M29ldlhCbDRVRzFZMytaTXF1aytmQnBOeWk2RkJSeXQzLzBhdWpDUFBr?=
 =?utf-8?B?R3M2TjE1NWNCOEIvR2NTQ042SFI5ejMzT3NCVkZsbFI3WUlvS1RDUHhtaGtq?=
 =?utf-8?B?TTMwckhBcnlQZ0hseitoWG53VkFJZkdNOC8rYkZWUkJJcjBJQllpdmZtMkpm?=
 =?utf-8?B?MnpwKzFEclRTRFd4S1hpZ0RHUTZTeGliQzVReVpoT0tVcUVLSUtTZHBjR2Nh?=
 =?utf-8?B?NDFqSk9ZYmdKbkdxdWtySFJraUZoQ0o3cVR4djNsU0ZGODcrbzRjb25lNkNw?=
 =?utf-8?B?RE1hbGI5Z01UV09OYUJNekQzSVlDKzV5ZEcyUjhxL3kzTGdiSm1kS0lPeFBV?=
 =?utf-8?B?L0hMYjZ3MGlSMlZYaElLOTJFZmR0VU5QKzA3UGpyTjl3bTNyQTZFL0lzN2NU?=
 =?utf-8?B?SVMzY0RaaWVwSk4zR2xXYjZWLzBuNVM1ODBGWWl4dkJYZWFFTkg5amVucC9l?=
 =?utf-8?B?YzNBdkZGazhocUJjRTdNL2p3MEJFbStnSWJLL2lZZUI3OXdZYUJKeGNQaExV?=
 =?utf-8?B?ZkNnQzEyR3RsdVJINW4rMDBiczhwb2pxRHZMRkgrbit3Rk80WXZrR254RjFP?=
 =?utf-8?B?MEFSaEduKzVZRWJ5SWxMQ1pDSWVPY2NDQWJkNXUyV2hzNy9kRzl4Yll0OHQ3?=
 =?utf-8?B?RWF1ZlEvT3UxSjNWWDVJMHZjc2JqbldMN3VGeGJ0a2hZNmN4NkRRNjRYN2hu?=
 =?utf-8?B?WDZwQ2gySlV6UU42a3NJTXFVa0RNS2xCVUJrNFQ3UlkvcUJSWUNyZWxuQmM2?=
 =?utf-8?B?bzM5Tzhnc0M3R0VoZVJhMnhySkpCNFBOWmlpazJETkFWTU1OTnhmaVY4MnFh?=
 =?utf-8?B?VWRMSU1QQkkxei90YkR3a2tEQ2IrSE9OM1hiaUdKNitOd3lnMWcxOWwzNG5w?=
 =?utf-8?B?bHNjczhmN0RmOXlOa3hML2lmam5FS21mMjVTK1Y0L0pCaGVBMmxEZE5HSWVw?=
 =?utf-8?B?eUhDdTduMDhVbUEyQ0lzN2dqUS9XVFIxckxBWERZTGZEZlB6OGRwUXR0bXJv?=
 =?utf-8?B?SC85dFRKa0RaRjhPZ0c2QldadndTakxHVmdMTTUxdzZaeFZndWtUZVYyZVY2?=
 =?utf-8?B?NzRYTjU5akV2WDhtYk83ZmxUaFQ2UkFqRnk2MTJBVlNlQ3JlWGRkeXhIMWFZ?=
 =?utf-8?Q?ehSCId/FUe2t6VG2QAdpj17HZ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0aa48017-58f3-4414-d533-08da794432cf
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6222.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2022 13:45:04.4970
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UHxeyZ7+s3dvxAA1GnBaDiTD2zaoUZN9FkN8qV2dgrLjQiWQr83ZhjGjKxtYR4xtHd/hN/4VhCmgTtGPfMf18A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6731
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/4/22 09:27, Limonciello, Mario wrote:
> On 8/4/2022 00:44, Meng Li wrote:
>> Add tbench.sh trigger the tbench testing and monitor the cpu desire
>> performance, frequency, load, power consumption and throughput etc.
>>
>> Signed-off-by: Meng Li <li.meng@amd.com>
>> ---
>>   tools/testing/selftests/amd-pstate/Makefile  |  10 +-
>>   tools/testing/selftests/amd-pstate/run.sh    | 217 ++++++++++-
>>   tools/testing/selftests/amd-pstate/tbench.sh | 358 +++++++++++++++++++
>>   3 files changed, 576 insertions(+), 9 deletions(-)
>>   create mode 100755 tools/testing/selftests/amd-pstate/tbench.sh
>>
>> diff --git a/tools/testing/selftests/amd-pstate/Makefile b/tools/testing/selftests/amd-pstate/Makefile
>> index 6f4c7b01e3bb..cac8dedb7226 100644
>> --- a/tools/testing/selftests/amd-pstate/Makefile
>> +++ b/tools/testing/selftests/amd-pstate/Makefile
>> @@ -4,7 +4,15 @@
>>   # No binaries, but make sure arg-less "make" doesn't trigger "run_tests"
>>   all:
>>   +uname_M := $(shell uname -m 2>/dev/null || echo not)
>> +ARCH ?= $(shell echo $(uname_M) | sed -e s/i.86/x86/ -e s/x86_64/x86/)
>> +
>> +ifeq (x86,$(ARCH))
>> +TEST_GEN_FILES += ../../../power/x86/amd_pstate_tracer/amd_pstate_trace.py
>> +TEST_GEN_FILES += ../../../power/x86/intel_pstate_tracer/intel_pstate_tracer.py
>> +endif
>> +
>>   TEST_PROGS := run.sh
>> -TEST_FILES := basic.sh
>> +TEST_FILES := basic.sh tbench.sh
>>     include ../lib.mk
>> diff --git a/tools/testing/selftests/amd-pstate/run.sh b/tools/testing/selftests/amd-pstate/run.sh
>> index dfacbec063c0..aa264e96a6e6 100755
>> --- a/tools/testing/selftests/amd-pstate/run.sh
>> +++ b/tools/testing/selftests/amd-pstate/run.sh
>> @@ -9,6 +9,7 @@ else
>>   fi
>>     source basic.sh
>> +source tbench.sh
>>     # amd-pstate-ut only run on x86/x86_64 AMD systems.
>>   ARCH=$(uname -m 2>/dev/null | sed -e 's/i.86/x86/' -e 's/x86_64/x86/')
>> @@ -16,9 +17,107 @@ VENDOR=$(cat /proc/cpuinfo | grep -m 1 'vendor_id' | awk '{print $NF}')
>>     FUNC=all
>>   OUTFILE=selftest
>> +OUTFILE_TBENCH="$OUTFILE.tbench"
>> +
>> +SYSFS=
>> +CPUROOT=
>> +CPUFREQROOT=
>> +MAKE_CPUS=
>> +
>> +TIME_LIMIT=100
>> +PROCESS_NUM=128
>> +LOOP_TIMES=3
>> +TRACER_INTERVAL=10
>> +CURRENT_TEST=amd-pstate
>> +COMPARATIVE_TEST=
>>     # Kselftest framework requirement - SKIP code is 4.
>>   ksft_skip=4
>> +all_scaling_names=("acpi-cpufreq" "amd-pstate")
>> +
>> +# Get current cpufreq scaling driver name
>> +scaling_name()
>> +{
>> +    if [ "$COMPARATIVE_TEST" = "" ]; then
>> +        echo "$CURRENT_TEST"
>> +    else
>> +        echo "$COMPARATIVE_TEST"
>> +    fi
>> +}
>> +
>> +# Counts CPUs with cpufreq directories
>> +count_cpus()
>> +{
>> +    count=0;
>> +
>> +    for cpu in `ls $CPUROOT | grep "cpu[0-9].*"`; do
>> +        if [ -d $CPUROOT/$cpu/cpufreq ]; then
>> +            let count=count+1;
>> +        fi
>> +    done
>> +
>> +    echo $count;
>> +}
>> +
>> +# $1: policy
>> +find_current_governor()
>> +{
>> +    cat $CPUFREQROOT/$1/scaling_governor
>> +}
>> +
>> +# $1: policy
>> +backup_governor()
>> +{
>> +    local cur_gov=$(find_current_governor $1)
>> +
>> +    printf "Governor backup done for $1: $cur_gov\n"
>> +    echo "$1 $cur_gov" >> $OUTFILE.backup_governor.log
>> +}
>> +
>> +restore_governor()
>> +{
>> +    i=0;
>> +
>> +    policies=$(awk '{print $1}' $OUTFILE.backup_governor.log)
>> +    for policy in $policies; do
>> +        let i++;
>> +        governor=$(sed -n ''$i'p' $OUTFILE.backup_governor.log | awk '{print $2}')
>> +
>> +        # switch governor
>> +        _switch_governor $policy $governor
>> +        printf "Governor restored for $policy to $governor\n"
>> +    done
>> +}
>> +
>> +# $1: policy, $2: governor
>> +_switch_governor()
>> +{
>> +    echo $2 > $CPUFREQROOT/$1/scaling_governor
>> +}
>> +
>> +for_each_policy()
>> +{
>> +    policies=$(ls $CPUFREQROOT| grep "policy[0-9].*")
>> +    for policy in $policies; do
>> +        $@ $policy
>> +    done
>> +}
>> +
>> +# $1: governor, $2: policy
>> +switch_governor()
>> +{
>> +    local filepath=$CPUFREQROOT/$2/scaling_available_governors
>> +
>> +    # Exit if cpu isn't managed by cpufreq core
>> +    if [ ! -f $filepath ]; then
>> +        return;
>> +    fi
>> +
>> +    # switch governor
>> +    _switch_governor $2 $1
>> +
>> +    printf "Switched governor for $2 to $1\n"
>> +}
>>     # All amd-pstate tests
>>   amd_pstate_all()
>> @@ -27,8 +126,19 @@ amd_pstate_all()
>>       printf "***** Running AMD P-state Sanity Tests  *****\n"
>>       printf "=============================================\n\n"
>>   +    count=$(count_cpus)
>> +    if [ $count = 0 ]; then
>> +        printf "No cpu is managed by cpufreq core, exiting\n"
>> +        exit;
>> +    else
>> +        printf "AMD P-state manages: $count CPUs\n"
>> +    fi
>> +
>>       # unit test for amd-pstate kernel driver
>>       amd_pstate_basic
>> +
>> +    # tbench
>> +    amd_pstate_tbench
>>   }
>>     helpme()
>> @@ -37,21 +147,27 @@ helpme()
>>       [-h <help>]
>>       [-o <output-file-for-dump>]
>>       [-c <all: All testing,
>> -         basic: Basic testing.>]
>> +         basic: Basic testing,
>> +         tbench: Tbench testing.>]
>> +    [-t <tbench time limit>]
>> +    [-p <tbench process number>]
>> +    [-l <loop times for tbench>]
>> +    [-i <amd tracer interval>]
>> +    [-m <comparative test: acpi-cpufreq>]
>>       \n"
>>       exit 2
>>   }
>>     parse_arguments()
>>   {
>> -    while getopts ho:c: arg
>> +    while getopts ho:c:t:p:l:i:m: arg
>>       do
>>           case $arg in
>>               h) # --help
>>                   helpme
>>                   ;;
>>   -            c) # --func_type (Function to perform: basic (default: all))
>> +            c) # --func_type (Function to perform: basic, tbench (default: all))
>>                   FUNC=$OPTARG
>>                   ;;
>>   @@ -59,6 +175,26 @@ parse_arguments()
>>                   OUTFILE=$OPTARG
>>                   ;;
>>   +            t) # --tbench-time-limit
>> +                TIME_LIMIT=$OPTARG
>> +                ;;
>> +
>> +            p) # --tbench-process-number
>> +                PROCESS_NUM=$OPTARG
>> +                ;;
>> +
>> +            l) # --tbench-loop-times
>> +                LOOP_TIMES=$OPTARG
>> +                ;;
>> +
>> +            i) # --amd-tracer-interval
>> +                TRACER_INTERVAL=$OPTARG
>> +                ;;
>> +
>> +            m) # --comparative-test
>> +                COMPARATIVE_TEST=$OPTARG
>> +                ;;
>> +
>>               *)
>>                   helpme
>>                   ;;
>> @@ -80,10 +216,28 @@ prerequisite()
>>       fi
>>         scaling_driver=$(cat /sys/devices/system/cpu/cpufreq/policy0/scaling_driver)
>> -    if [ "$scaling_driver" != "amd-pstate" ]; then
>> -        echo "$0 # Skipped: Test can only run on amd-pstate driver."
>> -        echo "$0 # Current cpufreq scaling drvier is $scaling_driver."
>> -        exit $ksft_skip
>> +    if [ "$COMPARATIVE_TEST" = "" ]; then
>> +        if [ "$scaling_driver" != "$CURRENT_TEST" ]; then
>> +            echo "$0 # Skipped: Test can only run on $CURRENT_TEST driver or run comparative test."
>> +            echo "$0 # Current cpufreq scaling drvier is $scaling_driver."
>> +            exit $ksft_skip
>> +        fi
>> +    else
>> +        case "$FUNC" in
>> +            "tbench")
>> +                if [ "$scaling_driver" != "$COMPARATIVE_TEST" ]; then
>> +                    echo "$0 # Skipped: Comparison test can only run on $COMPARATIVE_TEST driver."
>> +                    echo "$0 # Current cpufreq scaling drvier is $scaling_driver."
>> +                    exit $ksft_skip
>> +                fi
>> +                ;;
>> +
>> +            *)
>> +                echo "$0 # Skipped: Comparison test are only for tbench or gitsource."
>> +                echo "$0 # Current comparative test is for $FUNC."
>> +                exit $ksft_skip
>> +                ;;
>> +        esac
>>       fi
>>         msg="Skip all tests:"
>> @@ -91,10 +245,44 @@ prerequisite()
>>           echo $msg please run this as root >&2
>>           exit $ksft_skip
>>       fi
>> +
>> +    if [ ! -f perf ] ; then
>> +        echo $msg please build perf under directory tools/perf and copy it to directory amd-pstate. >&2
>> +        exit $ksft_skip
>> +    fi
>> +
>> +    SYSFS=`mount -t sysfs | head -1 | awk '{ print $3 }'`
>> +
>> +    if [ ! -d "$SYSFS" ]; then
>> +        echo $msg sysfs is not mounted >&2
>> +        exit 2
>> +    fi
>> +
>> +    CPUROOT=$SYSFS/devices/system/cpu
>> +    CPUFREQROOT="$CPUROOT/cpufreq"
>> +
>> +    if ! ls $CPUROOT/cpu* > /dev/null 2>&1; then
>> +        echo $msg cpus not available in sysfs >&2
>> +        exit 2
>> +    fi
>> +
>> +    if ! ls $CPUROOT/cpufreq > /dev/null 2>&1; then
>> +        echo $msg cpufreq directory not available in sysfs >&2
>> +        exit 2
>> +    fi
>>   }
>>     do_test()
>>   {
>> +    # Check if CPUs are managed by cpufreq or not
>> +    count=$(count_cpus)
>> +    MAKE_CPUS=$((count*2))
>> +
>> +    if [ $count = 0 ]; then
>> +        echo "No cpu is managed by cpufreq core, exiting"
>> +        exit 2;
>> +    fi
>> +
>>       case "$FUNC" in
>>           "all")
>>               amd_pstate_all
>> @@ -104,6 +292,10 @@ do_test()
>>               amd_pstate_basic
>>               ;;
>>   +        "tbench")
>> +            amd_pstate_tbench
>> +            ;;
>> +
>>           *)
>>               echo "Invalid [-f] function type"
>>               helpme
>> @@ -116,7 +308,15 @@ pre_clear_dumps()
>>   {
>>       case "$FUNC" in
>>           "all")
>> -            rm -rf $OUTFILE*
>> +            rm -rf $OUTFILE.log
>> +            rm -rf $OUTFILE.backup_governor.log
>> +            rm -rf *.png
>> +            ;;
>> +
>> +        "tbench")
>> +            rm -rf $OUTFILE.log
>> +            rm -rf $OUTFILE.backup_governor.log
>> +            rm -rf tbench_*.png
>>               ;;
>>             *)
>> @@ -127,6 +327,7 @@ pre_clear_dumps()
>>   post_clear_dumps()
>>   {
>>       rm -rf $OUTFILE.log
>> +    rm -rf $OUTFILE.backup_governor.log
>>   }
>>     # Parse arguments
>> diff --git a/tools/testing/selftests/amd-pstate/tbench.sh b/tools/testing/selftests/amd-pstate/tbench.sh
>> new file mode 100755
>> index 000000000000..161b78fc12d7
>> --- /dev/null
>> +++ b/tools/testing/selftests/amd-pstate/tbench.sh
>> @@ -0,0 +1,358 @@
>> +#!/bin/sh
>> +# SPDX-License-Identifier: GPL-2.0
>> +
>> +# Testing and monitor the cpu frequency and performance when
>> +# this script trigger tbench test.
>> +
>> +# protect against multiple inclusion
>> +if [ $FILE_TBENCH ]; then
>> +    return 0
>> +else
>> +    FILE_TBENCH=DONE
>> +fi
>> +
>> +tbench_name="dbench-4.0"
>> +tbench_tar="$tbench_name.tar.gz"
>> +tbench_url="https://ftp.samba.org/pub/pub/tridge/dbench/dbench-4.0.tar.gz"
> 
> Since you already store tbench_name and tbench_tar, perhaps you should just encode them into tbench_url rather than hardcoding again.
> 
>> +tbench_governors=("ondemand" "schedutil")
>> +
>> +# $1: governor, $2: round, $3: des-perf, $4: freq, $5: load, $6: performance, $7: energy, $8: performance per watt
>> +store_csv_tbench()
>> +{
>> +    echo "$1, $2, $3, $4, $5, $6, $7, $8" | tee -a $OUTFILE_TBENCH.csv > /dev/null 2>&1
>> +}
>> +
>> +# clear some special lines
>> +clear_csv_tbench()
>> +{
>> +    if [ -f $OUTFILE_TBENCH.csv ]; then
>> +        sed -i '/Comprison(%)/d' $OUTFILE_TBENCH.csv
>> +        sed -i "/$(scaling_name)/d" $OUTFILE_TBENCH.csv
>> +    fi
>> +}
>> +
>> +# find string $1 in file csv and get the number of lines
>> +get_lines_csv_tbench()
>> +{
>> +    if [ -f $OUTFILE_TBENCH.csv ]; then
>> +        return `grep -c "$1" $OUTFILE_TBENCH.csv`
>> +    else
>> +        return 0
>> +    fi
>> +}
>> +
>> +pre_clear_tbench()
>> +{
>> +    post_clear_tbench
>> +    rm -rf tbench_*.png
>> +    clear_csv_tbench
>> +}
>> +
>> +post_clear_tbench()
>> +{
>> +    rm -rf results/tracer-tbench*
>> +    rm -rf $OUTFILE_TBENCH*.log
>> +    rm -rf $OUTFILE_TBENCH*.result
>> +
>> +}
>> +
>> +install_tbench()
>> +{
>> +    if [ ! -d $tbench_name ]; then
> 
> tbench is also available in the repositories for common major distros.
> What about before falling to downloading and compiling it you first try to grab package from apt/yum?
> 
> Something similar to this:
> 
> if apt policy tbench 2>&1 1>/dev/null;
>     sudo apt install tbench
> elif yum list available | grep tbench 2>&1 1>/dev/null;
>     sudo yum install tbench
> else
>     #do existing/install with wget/curl.
> fi
> 

It may be worth adding a check to see if tbench (and the perf tools) are already installed.

-Nathan

>> +        printf "Download tbench, please wait a moment ...\n\n"
>> +        wget -O $tbench_tar $tbench_url > /dev/null 2>&1
>> +
>> +        printf "Tar tbench ...\n\n"
>> +        tar -xzf $tbench_tar
>> +
>> +        printf "Compile and install tbench ...\n\n"
>> +        cd $tbench_name
>> +        ./autogen.sh
>> +        ./configure > /dev/null 2>&1
>> +        make > /dev/null 2>&1
>> +        make install > /dev/null 2>&1
>> +        cd ..
>> +    fi
>> +}
>> +
>> +# $1: governor, $2: loop
>> +run_tbench()
>> +{
>> +    echo "Launching amd pstate tracer for $1 #$2 tracer_interval: $TRACER_INTERVAL"
>> +    ./amd_pstate_trace.py -n tracer-tbench-$1-$2 -i $TRACER_INTERVAL > /dev/null 2>&1 &
>> +
>> +    printf "Test tbench for $1 #$2 time_limit: $TIME_LIMIT procs_num: $PROCESS_NUM\n"
>> +    cd $tbench_name
>> +    ./tbench_srv > /dev/null 2>&1 &
>> +    ./../perf stat -a --per-socket -I 1000 -e power/energy-pkg/ ./tbench -t $TIME_LIMIT $PROCESS_NUM > ../$OUTFILE_TBENCH-perf-$1-$2.log 2>&1
>> +    cd ..
>> +
>> +    pid=`pidof tbench_srv`
>> +    kill $pid
>> +
>> +    for job in `jobs -p`
>> +    do
>> +        echo "Waiting for job id $job"
>> +        wait $job
>> +    done
>> +}
>> +
>> +# $1: governor, $2: loop
>> +parse_tbench()
>> +{
>> +    awk '{print $5}' results/tracer-tbench-$1-$2/cpu.csv | sed -e '1d' | sed s/,// > $OUTFILE_TBENCH-des-perf-$1-$2.log
>> +    avg_des_perf=$(awk 'BEGIN {i=0; sum=0};{i++; sum += $1};END {print sum/i}' $OUTFILE_TBENCH-des-perf-$1-$2.log)
>> +    printf "Tbench-$1-#$2 avg des perf: $avg_des_perf\n" | tee -a $OUTFILE_TBENCH.result
>> +
>> +    awk '{print $7}' results/tracer-tbench-$1-$2/cpu.csv | sed -e '1d' | sed s/,// > $OUTFILE_TBENCH-freq-$1-$2.log
>> +    avg_freq=$(awk 'BEGIN {i=0; sum=0};{i++; sum += $1};END {print sum/i}' $OUTFILE_TBENCH-freq-$1-$2.log)
>> +    printf "Tbench-$1-#$2 avg freq: $avg_freq\n" | tee -a $OUTFILE_TBENCH.result
>> +
>> +    awk '{print $11}' results/tracer-tbench-$1-$2/cpu.csv | sed -e '1d' | sed s/,// > $OUTFILE_TBENCH-load-$1-$2.log
>> +    avg_load=$(awk 'BEGIN {i=0; sum=0};{i++; sum += $1};END {print sum/i}' $OUTFILE_TBENCH-load-$1-$2.log)
>> +    printf "Tbench-$1-#$2 avg load: $avg_load\n" | tee -a $OUTFILE_TBENCH.result
>> +
>> +    grep Throughput $OUTFILE_TBENCH-perf-$1-$2.log | awk '{print $2}' > $OUTFILE_TBENCH-throughput-$1-$2.log
>> +    tp_sum=$(awk 'BEGIN {sum=0};{sum += $1};END {print sum}' $OUTFILE_TBENCH-throughput-$1-$2.log)
>> +    printf "Tbench-$1-#$2 throughput(MB/s): $tp_sum\n" | tee -a $OUTFILE_TBENCH.result
>> +
>> +    grep Joules $OUTFILE_TBENCH-perf-$1-$2.log | awk '{print $4}' > $OUTFILE_TBENCH-energy-$1-$2.log
>> +    en_sum=$(awk 'BEGIN {sum=0};{sum += $1};END {print sum}' $OUTFILE_TBENCH-energy-$1-$2.log)
>> +    printf "Tbench-$1-#$2 power consumption(J): $en_sum\n" | tee -a $OUTFILE_TBENCH.result
>> +
>> +    # Permance is throughput per second, denoted T/t, where T is throught rendered in t seconds.
>> +    # It is well known that P=E/t, where P is power measured in watts(W), E is energy measured in joules(J),
>> +    # and t is time measured in seconds(s). This means that performance per watt becomes
>> +    #       T/t   T/t    T
>> +    #       --- = --- = ---
>> +    #        P    E/t    E
>> +    # with unit given by MB per joule.
>> +    ppw=`echo "scale=4;($TIME_LIMIT-1)*$tp_sum/$en_sum" | bc | awk '{printf "%.4f", $0}'`
>> +    printf "Tbench-$1-#$2 performance per watt(MB/J): $ppw\n" | tee -a $OUTFILE_TBENCH.result
>> +    printf "\n" | tee -a $OUTFILE_TBENCH.result
>> +
>> +    driver_name=`echo $(scaling_name)`
>> +    store_csv_tbench "$driver_name-$1" $2 $avg_des_perf $avg_freq $avg_load $tp_sum $en_sum $ppw
>> +}
>> +
>> +# $1: governor
>> +loop_tbench()
>> +{
>> +    printf "\nTbench total test times is $LOOP_TIMES for $1\n\n"
>> +    for i in `seq 1 $LOOP_TIMES`
>> +    do
>> +        run_tbench $1 $i
>> +        parse_tbench $1 $i
>> +    done
>> +}
>> +
>> +# $1: governor
>> +gather_tbench()
>> +{
>> +    printf "Tbench test result for $1 (loops:$LOOP_TIMES)" | tee -a $OUTFILE_TBENCH.result
>> +    printf "\n--------------------------------------------------\n" | tee -a $OUTFILE_TBENCH.result
>> +
>> +    grep "Tbench-$1-#" $OUTFILE_TBENCH.result | grep "avg des perf:" | awk '{print $NF}' > $OUTFILE_TBENCH-des-perf-$1.log
>> +    avg_des_perf=$(awk 'BEGIN {sum=0};{sum += $1};END {print sum/'$LOOP_TIMES'}' $OUTFILE_TBENCH-des-perf-$1.log)
>> +    printf "Tbench-$1 avg des perf: $avg_des_perf\n" | tee -a $OUTFILE_TBENCH.result
>> +
>> +    grep "Tbench-$1-#" $OUTFILE_TBENCH.result | grep "avg freq:" | awk '{print $NF}' > $OUTFILE_TBENCH-freq-$1.log
>> +    avg_freq=$(awk 'BEGIN {sum=0};{sum += $1};END {print sum/'$LOOP_TIMES'}' $OUTFILE_TBENCH-freq-$1.log)
>> +    printf "Tbench-$1 avg freq: $avg_freq\n" | tee -a $OUTFILE_TBENCH.result
>> +
>> +    grep "Tbench-$1-#" $OUTFILE_TBENCH.result | grep "avg load:" | awk '{print $NF}' > $OUTFILE_TBENCH-load-$1.log
>> +    avg_load=$(awk 'BEGIN {sum=0};{sum += $1};END {print sum/'$LOOP_TIMES'}' $OUTFILE_TBENCH-load-$1.log)
>> +    printf "Tbench-$1 avg load: $avg_load\n" | tee -a $OUTFILE_TBENCH.result
>> +
>> +    grep "Tbench-$1-#" $OUTFILE_TBENCH.result | grep "throughput(MB/s):" | awk '{print $NF}' > $OUTFILE_TBENCH-throughput-$1.log
>> +    tp_sum=$(awk 'BEGIN {sum=0};{sum += $1};END {print sum}' $OUTFILE_TBENCH-throughput-$1.log)
>> +    printf "Tbench-$1 total throughput(MB/s): $tp_sum\n" | tee -a $OUTFILE_TBENCH.result
>> +
>> +    avg_tp=$(awk 'BEGIN {sum=0};{sum += $1};END {print sum/'$LOOP_TIMES'}' $OUTFILE_TBENCH-throughput-$1.log)
>> +    printf "Tbench-$1 avg throughput(MB/s): $avg_tp\n" | tee -a $OUTFILE_TBENCH.result
>> +
>> +    grep "Tbench-$1-#" $OUTFILE_TBENCH.result | grep "power consumption(J):" | awk '{print $NF}' > $OUTFILE_TBENCH-energy-$1.log
>> +    en_sum=$(awk 'BEGIN {sum=0};{sum += $1};END {print sum}' $OUTFILE_TBENCH-energy-$1.log)
>> +    printf "Tbench-$1 total power consumption(J): $en_sum\n" | tee -a $OUTFILE_TBENCH.result
>> +
>> +    avg_en=$(awk 'BEGIN {sum=0};{sum += $1};END {print sum/'$LOOP_TIMES'}' $OUTFILE_TBENCH-energy-$1.log)
>> +    printf "Tbench-$1 avg power consumption(J): $avg_en\n" | tee -a $OUTFILE_TBENCH.result
>> +
>> +    # Permance is throughput per second, denoted T/t, where T is throught rendered in t seconds.
>> +    # It is well known that P=E/t, where P is power measured in watts(W), E is energy measured in joules(J),
>> +    # and t is time measured in seconds(s). This means that performance per watt becomes
>> +    #       T/t   T/t    T
>> +    #       --- = --- = ---
>> +    #        P    E/t    E
>> +    # with unit given by MB per joule.
>> +    ppw=`echo "scale=4;($TIME_LIMIT-1)*$avg_tp/$avg_en" | bc | awk '{printf "%.4f", $0}'`
>> +    printf "Tbench-$1 performance per watt(MB/J): $ppw\n" | tee -a $OUTFILE_TBENCH.result
>> +    printf "\n" | tee -a $OUTFILE_TBENCH.result
>> +
>> +    driver_name=`echo $(scaling_name)`
>> +    store_csv_tbench "$driver_name-$1" "Average" $avg_des_perf $avg_freq $avg_load $avg_tp $avg_en $ppw
>> +}
>> +
>> +# $1: base scaling_driver $2: base governor $3: comparative scaling_driver $4: comparative governor
>> +__calc_comp_tbench()
>> +{
>> +    base=`grep "$1-$2" $OUTFILE_TBENCH.csv | grep "Average"`
>> +    comp=`grep "$3-$4" $OUTFILE_TBENCH.csv | grep "Average"`
>> +
>> +    if [ -n "$base" -a -n "$comp" ]; then
>> +        printf "\n==================================================\n" | tee -a $OUTFILE_TBENCH.result
>> +        printf "Tbench comparison $1-$2 VS $3-$4" | tee -a $OUTFILE_TBENCH.result
>> +        printf "\n==================================================\n" | tee -a $OUTFILE_TBENCH.result
>> +
>> +        # get the base values
>> +        des_perf_base=`echo "$base" | awk '{print $3}' | sed s/,//`
>> +        freq_base=`echo "$base" | awk '{print $4}' | sed s/,//`
>> +        load_base=`echo "$base" | awk '{print $5}' | sed s/,//`
>> +        perf_base=`echo "$base" | awk '{print $6}' | sed s/,//`
>> +        energy_base=`echo "$base" | awk '{print $7}' | sed s/,//`
>> +        ppw_base=`echo "$base" | awk '{print $8}' | sed s/,//`
>> +
>> +        # get the comparative values
>> +        des_perf_comp=`echo "$comp" | awk '{print $3}' | sed s/,//`
>> +        freq_comp=`echo "$comp" | awk '{print $4}' | sed s/,//`
>> +        load_comp=`echo "$comp" | awk '{print $5}' | sed s/,//`
>> +        perf_comp=`echo "$comp" | awk '{print $6}' | sed s/,//`
>> +        energy_comp=`echo "$comp" | awk '{print $7}' | sed s/,//`
>> +        ppw_comp=`echo "$comp" | awk '{print $8}' | sed s/,//`
>> +
>> +        # compare the base and comp values
>> +        des_perf_drop=`echo "scale=4;($des_perf_comp-$des_perf_base)*100/$des_perf_base" | bc | awk '{printf "%.4f", $0}'`
>> +        printf "Tbench-$1 des perf base: $des_perf_base comprison: $des_perf_comp percent: $des_perf_drop\n" | tee -a $OUTFILE_TBENCH.result
>> +
>> +        freq_drop=`echo "scale=4;($freq_comp-$freq_base)*100/$freq_base" | bc | awk '{printf "%.4f", $0}'`
>> +        printf "Tbench-$1 freq base: $freq_base comprison: $freq_comp percent: $freq_drop\n" | tee -a $OUTFILE_TBENCH.result
>> +
>> +        load_drop=`echo "scale=4;($load_comp-$load_base)*100/$load_base" | bc | awk '{printf "%.4f", $0}'`
>> +        printf "Tbench-$1 load base: $load_base comprison: $load_comp percent: $load_drop\n" | tee -a $OUTFILE_TBENCH.result
>> +
>> +        perf_drop=`echo "scale=4;($perf_comp-$perf_base)*100/$perf_base" | bc | awk '{printf "%.4f", $0}'`
>> +        printf "Tbench-$1 perf base: $perf_base comprison: $perf_comp percent: $perf_drop\n" | tee -a $OUTFILE_TBENCH.result
>> +
>> +        energy_drop=`echo "scale=4;($energy_comp-$energy_base)*100/$energy_base" | bc | awk '{printf "%.4f", $0}'`
>> +        printf "Tbench-$1 energy base: $energy_base comprison: $energy_comp percent: $energy_drop\n" | tee -a $OUTFILE_TBENCH.result
>> +
>> +        ppw_drop=`echo "scale=4;($ppw_comp-$ppw_base)*100/$ppw_base" | bc | awk '{printf "%.4f", $0}'`
>> +        printf "Tbench-$1 performance per watt base: $ppw_base comprison: $ppw_comp percent: $ppw_drop\n" | tee -a $OUTFILE_TBENCH.result
>> +        printf "\n" | tee -a $OUTFILE_TBENCH.result
>> +
>> +        store_csv_tbench "$1-$2 VS $3-$4" "Comprison(%)" "$des_perf_drop" "$freq_drop" "$load_drop" "$perf_drop" "$energy_drop" "$ppw_drop"
>> +    fi
>> +}
>> +
>> +# calculate the comparison(%)
>> +calc_comp_tbench()
>> +{
>> +    # acpi-cpufreq-ondemand VS acpi-cpufreq-schedutil
>> +    __calc_comp_tbench ${all_scaling_names[0]} ${tbench_governors[0]} ${all_scaling_names[0]} ${tbench_governors[1]}
>> +
>> +    # amd-pstate-ondemand VS amd-pstate-schedutil
>> +    __calc_comp_tbench ${all_scaling_names[1]} ${tbench_governors[0]} ${all_scaling_names[1]} ${tbench_governors[1]}
>> +
>> +    # acpi-cpufreq-ondemand VS amd-pstate-ondemand
>> +    __calc_comp_tbench ${all_scaling_names[0]} ${tbench_governors[0]} ${all_scaling_names[1]} ${tbench_governors[0]}
>> +
>> +    # acpi-cpufreq-schedutil VS amd-pstate-schedutil
>> +    __calc_comp_tbench ${all_scaling_names[0]} ${tbench_governors[1]} ${all_scaling_names[1]} ${tbench_governors[1]}
>> +}
>> +
>> +# $1: file_name, $2: title, $3: ylable, $4: column
>> +plot_png_tbench()
>> +{
>> +    # all_scaling_names[1] all_scaling_names[0] flag
>> +    #    amd-pstate           acpi-cpufreq
>> +    #         N                   N             0
>> +    #         N                   Y             1
>> +    #         Y                   N             2
>> +    #         Y                   Y             3
>> +    ret=`grep -c "${all_scaling_names[1]}" $OUTFILE_TBENCH.csv`
>> +    if [ $ret -eq 0 ]; then
>> +        ret=`grep -c "${all_scaling_names[0]}" $OUTFILE_TBENCH.csv`
>> +        if [ $ret -eq 0 ]; then
>> +            flag=0
>> +        else
>> +            flag=1
>> +        fi
>> +    else
>> +        ret=`grep -c "${all_scaling_names[0]}" $OUTFILE_TBENCH.csv`
>> +        if [ $ret -eq 0 ]; then
>> +            flag=2
>> +        else
>> +            flag=3
>> +        fi
>> +    fi
>> +
>> +    gnuplot << EOF
>> +        set term png
>> +        set output "$1"
>> +
>> +        set title "$2"
>> +        set xlabel "Test Cycles (round)"
>> +        set ylabel "$3"
>> +
>> +        set grid
>> +        set style data histogram
>> +        set style fill solid 0.5 border
>> +        set boxwidth 0.8
>> +
>> +        if ($flag == 1) {
>> +            plot \
>> +            "<(sed -n -e 's/,//g' -e '/${all_scaling_names[0]}-${tbench_governors[0]}/p' $OUTFILE_TBENCH.csv)" using $4:xtic(2) title "${all_scaling_names[0]}-${tbench_governors[0]}", \
>> +            "<(sed -n -e 's/,//g' -e '/${all_scaling_names[0]}-${tbench_governors[1]}/p' $OUTFILE_TBENCH.csv)" using $4:xtic(2) title "${all_scaling_names[0]}-${tbench_governors[1]}"
>> +        } else {
>> +            if ($flag == 2) {
>> +                plot \
>> +                "<(sed -n -e 's/,//g' -e '/${all_scaling_names[1]}-${tbench_governors[0]}/p' $OUTFILE_TBENCH.csv)" using $4:xtic(2) title "${all_scaling_names[1]}-${tbench_governors[0]}", \
>> +                "<(sed -n -e 's/,//g' -e '/${all_scaling_names[1]}-${tbench_governors[1]}/p' $OUTFILE_TBENCH.csv)" using $4:xtic(2) title "${all_scaling_names[1]}-${tbench_governors[1]}"
>> +            } else {
>> +                if ($flag == 3 ) {
>> +                    plot \
>> +                    "<(sed -n -e 's/,//g' -e '/${all_scaling_names[0]}-${tbench_governors[0]}/p' $OUTFILE_TBENCH.csv)" using $4:xtic(2) title "${all_scaling_names[0]}-${tbench_governors[0]}", \
>> +                    "<(sed -n -e 's/,//g' -e '/${all_scaling_names[0]}-${tbench_governors[1]}/p' $OUTFILE_TBENCH.csv)" using $4:xtic(2) title "${all_scaling_names[0]}-${tbench_governors[1]}", \
>> +                    "<(sed -n -e 's/,//g' -e '/${all_scaling_names[1]}-${tbench_governors[0]}/p' $OUTFILE_TBENCH.csv)" using $4:xtic(2) title "${all_scaling_names[1]}-${tbench_governors[0]}", \
>> +                    "<(sed -n -e 's/,//g' -e '/${all_scaling_names[1]}-${tbench_governors[1]}/p' $OUTFILE_TBENCH.csv)" using $4:xtic(2) title "${all_scaling_names[1]}-${tbench_governors[1]}"
>> +                }
>> +            }
>> +        }
>> +        quit
>> +EOF
>> +}
>> +
>> +amd_pstate_tbench()
>> +{
>> +    printf "\n---------------------------------------------\n"
>> +    printf "*** Running tbench                        ***"
>> +    printf "\n---------------------------------------------\n"
>> +
>> +    pre_clear_tbench
>> +
>> +    install_tbench
>> +
>> +    get_lines_csv_tbench "Governor"
>> +    if [ $? -eq 0 ]; then
>> +        # add titles and unit for csv file
>> +        store_csv_tbench "Governor" "Round" "Des-perf" "Freq" "Load" "Performance" "Energy" "Performance Per Watt"
>> +        store_csv_tbench "Unit" "" "" "GHz" "" "MB/s" "J" "MB/J"
>> +    fi
>> +
>> +    for_each_policy backup_governor
>> +    for governor in ${tbench_governors[*]} ; do
>> +        printf "\nSpecified governor is $governor\n\n"
>> +        for_each_policy switch_governor $governor
>> +        loop_tbench $governor
>> +        gather_tbench $governor
>> +    done
>> +    restore_governor
>> +
>> +    plot_png_tbench "tbench_perfromance.png" "Tbench Benchmark Performance" "Performance" 6
>> +    plot_png_tbench "tbench_energy.png" "Tbench Benchmark Energy" "Energy (J)" 7
>> +    plot_png_tbench "tbench_ppw.png" "Tbench Benchmark Performance Per Watt" "Performance Per Watt (MB/J)" 8
>> +
>> +    calc_comp_tbench
>> +
>> +    post_clear_tbench
>> +}
> 
