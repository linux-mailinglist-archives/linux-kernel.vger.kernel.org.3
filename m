Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A4724C434C
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 12:24:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240019AbiBYLYa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 06:24:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240014AbiBYLY3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 06:24:29 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2294E1B30A8
        for <linux-kernel@vger.kernel.org>; Fri, 25 Feb 2022 03:23:57 -0800 (PST)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 21PBNJkf009007;
        Fri, 25 Feb 2022 11:23:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=JR6MshcxA/GhNfLYaL464dq6rM47p/hNN7EPDSzVqMY=;
 b=XhsWaXFFWpHLk2vMwXpGZmavj1SJDEO9zsWHVqHRdKaWJ+H90GpzstY6aT9NOncBJoCZ
 WWB1HjaLDuxbC0SL66M07xB7DGIZVjuZzoeeHJeD6OAFzDpyq0Y0OOM0x4UDgNaeafWA
 TOC19mG7IXLQSuzyooB1C+kzT7wg3yDOqZ7k9J7pIlYHGPpqQe9bYXgt0iSqZOen14Q1
 CmKCftUgo9Yr8HmfN9sKRTmcPl7aM7UPjmP9YOCTcB3fde142wp8EZsUfTI+q7XdJBCo
 bPcEuYYlfnE4p5F4PhqUbC3f9suc7y/WO3fxStNUGKLTCn/erYdgmDyURyjL+MjiXsV7 4Q== 
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3edsju7xm5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 25 Feb 2022 11:23:37 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 21PBCiXw022989;
        Fri, 25 Feb 2022 11:23:36 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma06ams.nl.ibm.com with ESMTP id 3eaqtjr42t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 25 Feb 2022 11:23:36 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 21PBNTBA55640460
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 25 Feb 2022 11:23:29 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1B8F652050;
        Fri, 25 Feb 2022 11:23:29 +0000 (GMT)
Received: from [9.43.81.177] (unknown [9.43.81.177])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 0E62B5204E;
        Fri, 25 Feb 2022 11:23:23 +0000 (GMT)
Message-ID: <f5f5904a-aedc-2976-d392-75d4cf91e8aa@linux.ibm.com>
Date:   Fri, 25 Feb 2022 16:53:22 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v6 0/4] Add perf interface to expose nvdimm
Content-Language: en-US
To:     Nageswara Sastry <rnsastry@linux.ibm.com>, mpe@ellerman.id.au,
        linuxppc-dev@lists.ozlabs.org, nvdimm@lists.linux.dev,
        linux-kernel@vger.kernel.org, peterz@infradead.org,
        dan.j.williams@intel.com, ira.weiny@intel.com,
        vishal.l.verma@intel.com
Cc:     santosh@fossix.org, maddy@linux.ibm.com,
        aneesh.kumar@linux.ibm.com, atrajeev@linux.vnet.ibm.com,
        vaibhav@linux.ibm.com, tglx@linutronix.de
References: <20220217163357.276036-1-kjain@linux.ibm.com>
 <ddf18609-84ad-e263-7dff-7b2cc68557ef@linux.ibm.com>
 <ea6bc468-c7ae-c844-5111-8f0dc3207f89@linux.ibm.com>
 <d7945e63-4cd6-1947-ed9f-a81203226c47@linux.ibm.com>
From:   kajoljain <kjain@linux.ibm.com>
In-Reply-To: <d7945e63-4cd6-1947-ed9f-a81203226c47@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: qLNX9OLKaVHLaEsfKQNSP10dcqym0tXG
X-Proofpoint-GUID: qLNX9OLKaVHLaEsfKQNSP10dcqym0tXG
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-02-25_07,2022-02-25_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 mlxscore=0
 malwarescore=0 suspectscore=0 clxscore=1015 adultscore=0 phishscore=0
 bulkscore=0 priorityscore=1501 mlxlogscore=999 lowpriorityscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2202250060
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H5,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/25/22 16:41, Nageswara Sastry wrote:
> 
> 
> On 25/02/22 12:08 pm, kajoljain wrote:
>>
>>
>> On 2/25/22 11:25, Nageswara Sastry wrote:
>>>
>>>
>>> On 17/02/22 10:03 pm, Kajol Jain wrote:
>>>> Patchset adds performance stats reporting support for nvdimm.
>>>> Added interface includes support for pmu register/unregister
>>>> functions. A structure is added called nvdimm_pmu to be used for
>>>> adding arch/platform specific data such as cpumask, nvdimm device
>>>> pointer and pmu event functions like event_init/add/read/del.
>>>> User could use the standard perf tool to access perf events
>>>> exposed via pmu.
>>>>
>>>> Interface also defines supported event list, config fields for the
>>>> event attributes and their corresponding bit values which are exported
>>>> via sysfs. Patch 3 exposes IBM pseries platform nmem* device
>>>> performance stats using this interface.
>>>>
>>>> Result from power9 pseries lpar with 2 nvdimm device:
>>>>
>>>> Ex: List all event by perf list
>>>>
>>>> command:# perf list nmem
>>>>
>>>>     nmem0/cache_rh_cnt/                                [Kernel PMU
>>>> event]
>>>>     nmem0/cache_wh_cnt/                                [Kernel PMU
>>>> event]
>>>>     nmem0/cri_res_util/                                [Kernel PMU
>>>> event]
>>>>     nmem0/ctl_res_cnt/                                 [Kernel PMU
>>>> event]
>>>>     nmem0/ctl_res_tm/                                  [Kernel PMU
>>>> event]
>>>>     nmem0/fast_w_cnt/                                  [Kernel PMU
>>>> event]
>>>>     nmem0/host_l_cnt/                                  [Kernel PMU
>>>> event]
>>>>     nmem0/host_l_dur/                                  [Kernel PMU
>>>> event]
>>>>     nmem0/host_s_cnt/                                  [Kernel PMU
>>>> event]
>>>>     nmem0/host_s_dur/                                  [Kernel PMU
>>>> event]
>>>>     nmem0/med_r_cnt/                                   [Kernel PMU
>>>> event]
>>>>     nmem0/med_r_dur/                                   [Kernel PMU
>>>> event]
>>>>     nmem0/med_w_cnt/                                   [Kernel PMU
>>>> event]
>>>>     nmem0/med_w_dur/                                   [Kernel PMU
>>>> event]
>>>>     nmem0/mem_life/                                    [Kernel PMU
>>>> event]
>>>>     nmem0/poweron_secs/                                [Kernel PMU
>>>> event]
>>>>     ...
>>>>     nmem1/mem_life/                                    [Kernel PMU
>>>> event]
>>>>     nmem1/poweron_secs/                                [Kernel PMU
>>>> event]
>>>>
>>>> Patch1:
>>>>           Introduces the nvdimm_pmu structure
>>>> Patch2:
>>>>           Adds common interface to add arch/platform specific data
>>>>           includes nvdimm device pointer, pmu data along with
>>>>           pmu event functions. It also defines supported event list
>>>>           and adds attribute groups for format, events and cpumask.
>>>>           It also adds code for cpu hotplug support.
>>>> Patch3:
>>>>           Add code in arch/powerpc/platform/pseries/papr_scm.c to
>>>> expose
>>>>           nmem* pmu. It fills in the nvdimm_pmu structure with pmu
>>>> name,
>>>>           capabilities, cpumask and event functions and then registers
>>>>           the pmu by adding callbacks to register_nvdimm_pmu.
>>>> Patch4:
>>>>           Sysfs documentation patch
>>>>
>>>> Changelog
>>>
>>> Tested these patches with the automated tests at
>>> avocado-misc-tests/perf/perf_nmem.py
>>> URL:
>>> https://github.com/avocado-framework-tests/avocado-misc-tests/blob/master/perf/perf_nmem.py
>>>
>>>
>>>
>>> 1. On the system where target id and online id were different then not
>>> seeing value in 'cpumask' and those tests failed.
>>>
>>> Example:
>>> Log from dmesg
>>> ...
>>> papr_scm ibm,persistent-memory:ibm,pmemory@44100003: Region registered
>>> with target node 1 and online node 0
>>> ...
>>
>> Hi Nageswara Sastry,
>>         Thanks for testing the patch set. Yes you right, incase target
>> node id and online node id is different, it can happen when target
>> node is not online and hence can cause this issue, thanks for pointing
>> it.
>>
>> Function dev_to_node will return node id for a given nvdimm device which
>> can be offline in some scenarios. We should use numa node id return by
>> numa_map_to_online_node function in that scenario. This function incase
>> given node is offline, it will lookup for next closest online node and
>> return that nodeid.
>>
>> Can you try with below change and see, if you are still getting this
>> issue. Please let me know.
>>
>> diff --git a/arch/powerpc/platforms/pseries/papr_scm.c
>> b/arch/powerpc/platforms/pseries/papr_scm.c
>> index bdf2620db461..4dd513d7c029 100644
>> --- a/arch/powerpc/platforms/pseries/papr_scm.c
>> +++ b/arch/powerpc/platforms/pseries/papr_scm.c
>> @@ -536,7 +536,7 @@ static void papr_scm_pmu_register(struct
>> papr_scm_priv *p)
>>                                  PERF_PMU_CAP_NO_EXCLUDE;
>>
>>          /*updating the cpumask variable */
>> -       nodeid = dev_to_node(&p->pdev->dev);
>> +       nodeid = numa_map_to_online_node(dev_to_node(&p->pdev->dev));
>>          nd_pmu->arch_cpumask = *cpumask_of_node(nodeid);
>>
>> Thanks,
>> Kajol Jain
>>
> 
> With the above patch all the tests are passing on the system where
> target id and online id were different. Here is the the result:
> 
> (1/9) perf_nmem.py:perfNMEM.test_pmu_register_dmesg: PASS (3.47 s)
> (2/9) perf_nmem.py:perfNMEM.test_sysfs: PASS (1.15 s)
> (3/9) perf_nmem.py:perfNMEM.test_pmu_count: PASS (1.08 s)
> (4/9) perf_nmem.py:perfNMEM.test_all_events: PASS (18.15 s)
> (5/9) perf_nmem.py:perfNMEM.test_all_group_events: PASS (2.22 s)
> (6/9) perf_nmem.py:perfNMEM.test_mixed_events: CANCEL: With single PMU
> mixed events test is not possible. (1.18 s)
> (7/9) perf_nmem.py:perfNMEM.test_pmu_cpumask: PASS (1.12 s)
> (8/9) perf_nmem.py:perfNMEM.test_cpumask: PASS (1.17 s)
> (9/9) perf_nmem.py:perfNMEM.test_cpumask_cpu_off: PASS (1.81 s)
> 
> Tested-by: Nageswara R Sastry <rnsastry@linux.ibm.com>

Hi Nageswara,
   Thanks for testing this change. I will send new patch series v7 with
this change and also include your Tested-by tag.

Thanks,
Kajol Jain

> 
