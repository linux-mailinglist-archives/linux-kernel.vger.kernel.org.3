Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 639B84C3E7A
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 07:39:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237737AbiBYGjk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 01:39:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232191AbiBYGjh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 01:39:37 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F05A4968E
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 22:39:06 -0800 (PST)
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 21P4x9YD017973;
        Fri, 25 Feb 2022 06:38:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=Rj2R45UBXm7cFfvNwOx0KJ4Zri6y59EUs/gD1/FPExA=;
 b=JscF3F51sJNJj5PedF0ySQOp9QJtFDJV/pxD094jCatyPUzgvCtXYbN3d8DKffmfQ62h
 g7y+JA8s/xmETK2ot4kDcL6ihcqxPTXxnEvjYlbaoMU6CI1oGW82/YWqS4m7GLJRWNRR
 oDjUdflV6PJhXsaWbnbndjN52hs2mDfXR7zI9IzYo3FfWonk9HqDyDzZB6KiuVwz7L0W
 JyDrAOX/D+eK7Mo2v1M18Trl1/2vnsXxRwV2websu3k/NZuKmuVKobFsLbnWyjPsHi94
 S33lhdzbRYcwEHS4tspcqogTyHv7F9EfYVF3ybb8TctTC7S6ggn2+EzmthBcim1wW+7H cg== 
Received: from ppma04fra.de.ibm.com (6a.4a.5195.ip4.static.sl-reverse.com [149.81.74.106])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3edpjvyb10-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 25 Feb 2022 06:38:21 +0000
Received: from pps.filterd (ppma04fra.de.ibm.com [127.0.0.1])
        by ppma04fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 21P6X7T0007939;
        Fri, 25 Feb 2022 06:38:19 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma04fra.de.ibm.com with ESMTP id 3ear69v3aa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 25 Feb 2022 06:38:19 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 21P6cFfX50200930
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 25 Feb 2022 06:38:16 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D82C0A4054;
        Fri, 25 Feb 2022 06:38:15 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 74C8FA4062;
        Fri, 25 Feb 2022 06:38:11 +0000 (GMT)
Received: from [9.43.81.146] (unknown [9.43.81.146])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri, 25 Feb 2022 06:38:11 +0000 (GMT)
Message-ID: <ea6bc468-c7ae-c844-5111-8f0dc3207f89@linux.ibm.com>
Date:   Fri, 25 Feb 2022 12:08:09 +0530
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
From:   kajoljain <kjain@linux.ibm.com>
In-Reply-To: <ddf18609-84ad-e263-7dff-7b2cc68557ef@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: BiJsuX5IxH5jzlocfLO1s6ThJ7P-BZOt
X-Proofpoint-GUID: BiJsuX5IxH5jzlocfLO1s6ThJ7P-BZOt
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-02-25_05,2022-02-24_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 lowpriorityscore=0 suspectscore=0 adultscore=0 clxscore=1015 mlxscore=0
 malwarescore=0 bulkscore=0 spamscore=0 phishscore=0 mlxlogscore=999
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2202250034
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H5,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/25/22 11:25, Nageswara Sastry wrote:
> 
> 
> On 17/02/22 10:03 pm, Kajol Jain wrote:
>> Patchset adds performance stats reporting support for nvdimm.
>> Added interface includes support for pmu register/unregister
>> functions. A structure is added called nvdimm_pmu to be used for
>> adding arch/platform specific data such as cpumask, nvdimm device
>> pointer and pmu event functions like event_init/add/read/del.
>> User could use the standard perf tool to access perf events
>> exposed via pmu.
>>
>> Interface also defines supported event list, config fields for the
>> event attributes and their corresponding bit values which are exported
>> via sysfs. Patch 3 exposes IBM pseries platform nmem* device
>> performance stats using this interface.
>>
>> Result from power9 pseries lpar with 2 nvdimm device:
>>
>> Ex: List all event by perf list
>>
>> command:# perf list nmem
>>
>>    nmem0/cache_rh_cnt/                                [Kernel PMU event]
>>    nmem0/cache_wh_cnt/                                [Kernel PMU event]
>>    nmem0/cri_res_util/                                [Kernel PMU event]
>>    nmem0/ctl_res_cnt/                                 [Kernel PMU event]
>>    nmem0/ctl_res_tm/                                  [Kernel PMU event]
>>    nmem0/fast_w_cnt/                                  [Kernel PMU event]
>>    nmem0/host_l_cnt/                                  [Kernel PMU event]
>>    nmem0/host_l_dur/                                  [Kernel PMU event]
>>    nmem0/host_s_cnt/                                  [Kernel PMU event]
>>    nmem0/host_s_dur/                                  [Kernel PMU event]
>>    nmem0/med_r_cnt/                                   [Kernel PMU event]
>>    nmem0/med_r_dur/                                   [Kernel PMU event]
>>    nmem0/med_w_cnt/                                   [Kernel PMU event]
>>    nmem0/med_w_dur/                                   [Kernel PMU event]
>>    nmem0/mem_life/                                    [Kernel PMU event]
>>    nmem0/poweron_secs/                                [Kernel PMU event]
>>    ...
>>    nmem1/mem_life/                                    [Kernel PMU event]
>>    nmem1/poweron_secs/                                [Kernel PMU event]
>>
>> Patch1:
>>          Introduces the nvdimm_pmu structure
>> Patch2:
>>          Adds common interface to add arch/platform specific data
>>          includes nvdimm device pointer, pmu data along with
>>          pmu event functions. It also defines supported event list
>>          and adds attribute groups for format, events and cpumask.
>>          It also adds code for cpu hotplug support.
>> Patch3:
>>          Add code in arch/powerpc/platform/pseries/papr_scm.c to expose
>>          nmem* pmu. It fills in the nvdimm_pmu structure with pmu name,
>>          capabilities, cpumask and event functions and then registers
>>          the pmu by adding callbacks to register_nvdimm_pmu.
>> Patch4:
>>          Sysfs documentation patch
>>
>> Changelog
> 
> Tested these patches with the automated tests at
> avocado-misc-tests/perf/perf_nmem.py
> URL:
> https://github.com/avocado-framework-tests/avocado-misc-tests/blob/master/perf/perf_nmem.py
> 
> 
> 1. On the system where target id and online id were different then not
> seeing value in 'cpumask' and those tests failed.
> 
> Example:
> Log from dmesg
> ...
> papr_scm ibm,persistent-memory:ibm,pmemory@44100003: Region registered
> with target node 1 and online node 0
> ...

Hi Nageswara Sastry,
       Thanks for testing the patch set. Yes you right, incase target
node id and online node id is different, it can happen when target
node is not online and hence can cause this issue, thanks for pointing
it.

Function dev_to_node will return node id for a given nvdimm device which
can be offline in some scenarios. We should use numa node id return by
numa_map_to_online_node function in that scenario. This function incase
given node is offline, it will lookup for next closest online node and
return that nodeid.

Can you try with below change and see, if you are still getting this
issue. Please let me know.

diff --git a/arch/powerpc/platforms/pseries/papr_scm.c
b/arch/powerpc/platforms/pseries/papr_scm.c
index bdf2620db461..4dd513d7c029 100644
--- a/arch/powerpc/platforms/pseries/papr_scm.c
+++ b/arch/powerpc/platforms/pseries/papr_scm.c
@@ -536,7 +536,7 @@ static void papr_scm_pmu_register(struct
papr_scm_priv *p)
                                PERF_PMU_CAP_NO_EXCLUDE;

        /*updating the cpumask variable */
-       nodeid = dev_to_node(&p->pdev->dev);
+       nodeid = numa_map_to_online_node(dev_to_node(&p->pdev->dev));
        nd_pmu->arch_cpumask = *cpumask_of_node(nodeid);

Thanks,
Kajol Jain

> 
> tests log:
>  (1/9) perf_nmem.py:perfNMEM.test_pmu_register_dmesg: PASS (1.13 s)
>  (2/9) perf_nmem.py:perfNMEM.test_sysfs: PASS (1.10 s)
>  (3/9) perf_nmem.py:perfNMEM.test_pmu_count: PASS (1.07 s)
>  (4/9) perf_nmem.py:perfNMEM.test_all_events: PASS (18.14 s)
>  (5/9) perf_nmem.py:perfNMEM.test_all_group_events: PASS (2.18 s)
>  (6/9) perf_nmem.py:perfNMEM.test_mixed_events: CANCEL: With single PMU
> mixed events test is not possible. (1.10 s)
>  (7/9) perf_nmem.py:perfNMEM.test_pmu_cpumask: ERROR: invalid literal
> for int() with base 10: '' (1.10 s)
>  (8/9) perf_nmem.py:perfNMEM.test_cpumask: ERROR: invalid literal for
> int() with base 10: '' (1.10 s)
>  (9/9) perf_nmem.py:perfNMEM.test_cpumask_cpu_off: ERROR: invalid
> literal for int() with base 10: '' (1.07 s)
> 
> 2. On the system where target id and online id were same then seeing
> value in 'cpumask' and those tests pass.
> 
> tests log:
>  (1/9) perf_nmem.py:perfNMEM.test_pmu_register_dmesg: PASS (1.16 s)
>  (2/9) perf_nmem.py:perfNMEM.test_sysfs: PASS (1.10 s)
>  (3/9) perf_nmem.py:perfNMEM.test_pmu_count: PASS (1.12 s)
>  (4/9) perf_nmem.py:perfNMEM.test_all_events: PASS (18.10 s)
>  (5/9) perf_nmem.py:perfNMEM.test_all_group_events: PASS (2.23 s)
>  (6/9) perf_nmem.py:perfNMEM.test_mixed_events: CANCEL: With single PMU
> mixed events test is not possible. (1.13 s)
>  (7/9) perf_nmem.py:perfNMEM.test_pmu_cpumask: PASS (1.08 s)
>  (8/9) perf_nmem.py:perfNMEM.test_cpumask: PASS (1.09 s)
>  (9/9) perf_nmem.py:perfNMEM.test_cpumask_cpu_off: PASS (1.62 s)
> 
>> ---
>> Resend v5 -> v6
>> - No logic change, just a rebase to latest upstream and
>>    tested the patchset.
>>
>> - Link to the patchset Resend v5: https://lkml.org/lkml/2021/11/15/3979
>>
>> v5 -> Resend v5
>> - Resend the patchset
>>
>> - Link to the patchset v5: https://lkml.org/lkml/2021/9/28/643
>>
>> v4 -> v5:
>> - Remove multiple variables defined in nvdimm_pmu structure include
>>    name and pmu functions(event_int/add/del/read) as they are just
>>    used to copy them again in pmu variable. Now we are directly doing
>>    this step in arch specific code as suggested by Dan Williams.
>>
>> - Remove attribute group field from nvdimm pmu structure and
>>    defined these attribute groups in common interface which
>>    includes format, event list along with cpumask as suggested by
>>    Dan Williams.
>>    Since we added static defination for attrbute groups needed in
>>    common interface, removes corresponding code from papr.
>>
>> - Add nvdimm pmu event list with event codes in the common interface.
>>
>> - Remove Acked-by/Reviewed-by/Tested-by tags as code is refactored
>>    to handle review comments from Dan.
>>
>> - Make nvdimm_pmu_free_hotplug_memory function static as reported
>>    by kernel test robot, also add corresponding Reported-by tag.
>>
>> - Link to the patchset v4: https://lkml.org/lkml/2021/9/3/45
>>
>> v3 -> v4
>> - Rebase code on top of current papr_scm code without any logical
>>    changes.
>>
>> - Added Acked-by tag from Peter Zijlstra and Reviewed by tag
>>    from Madhavan Srinivasan.
>>
>> - Link to the patchset v3: https://lkml.org/lkml/2021/6/17/605
>>
>> v2 -> v3
>> - Added Tested-by tag.
>>
>> - Fix nvdimm mailing list in the ABI Documentation.
>>
>> - Link to the patchset v2: https://lkml.org/lkml/2021/6/14/25
>>
>> v1 -> v2
>> - Fix hotplug code by adding pmu migration call
>>    incase current designated cpu got offline. As
>>    pointed by Peter Zijlstra.
>>
>> - Removed the retun -1 part from cpu hotplug offline
>>    function.
>>
>> - Link to the patchset v1: https://lkml.org/lkml/2021/6/8/500
>>
>> Kajol Jain (4):
>>    drivers/nvdimm: Add nvdimm pmu structure
>>    drivers/nvdimm: Add perf interface to expose nvdimm performance stats
>>    powerpc/papr_scm: Add perf interface support
>>    docs: ABI: sysfs-bus-nvdimm: Document sysfs event format entries for
>>      nvdimm pmu
>>
>>   Documentation/ABI/testing/sysfs-bus-nvdimm |  35 +++
>>   arch/powerpc/include/asm/device.h          |   5 +
>>   arch/powerpc/platforms/pseries/papr_scm.c  | 225 ++++++++++++++
>>   drivers/nvdimm/Makefile                    |   1 +
>>   drivers/nvdimm/nd_perf.c                   | 328 +++++++++++++++++++++
>>   include/linux/nd.h                         |  41 +++
>>   6 files changed, 635 insertions(+)
>>   create mode 100644 drivers/nvdimm/nd_perf.c
>>
> 
