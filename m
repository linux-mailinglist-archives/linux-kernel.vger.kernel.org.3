Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D45A4BA613
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 17:36:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243218AbiBQQfE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 11:35:04 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:36622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243135AbiBQQfD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 11:35:03 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF2552B2C6A
        for <linux-kernel@vger.kernel.org>; Thu, 17 Feb 2022 08:34:47 -0800 (PST)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 21HFBlpF023451;
        Thu, 17 Feb 2022 16:34:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : content-transfer-encoding : mime-version; s=pp1;
 bh=SFxiKoVaZ3nMnn78vpSGvPN3c/wa+VkWgiWtKDOBJBc=;
 b=CoqqcKq2gqAqCL98Pe9GQVx4fL0tu64slMAHkcYNpSyxnehJ9R3Pjt5eX5IxtClcDJi7
 ROvS3/G1c2YumXfEH9nULBiZTk+y+ogMi6ywNwjC4rbQ4ZKzlTnsm+Zn8mBLAis+D+gM
 yv6ttKFoBn7+ETnt0gvPGQ/zNzc5J6PAbhmyvxXbOqY0pZJ+6z8lp9quJCS6RUB4YSqb
 ROHUkBmwMsthNYwRq7vykS+h/KyCWIjYKAv0UedTY2brJr+kXavHZUhWItwCoUDADEDq
 m/odTPOthsowNoAzfLb2cm5ln64/smiOGf9TyChxCCn2Gx6Dr6qN+5u1NJzjhOuvpJbm LQ== 
Received: from ppma02fra.de.ibm.com (47.49.7a9f.ip4.static.sl-reverse.com [159.122.73.71])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3e9rsqj837-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 17 Feb 2022 16:34:21 +0000
Received: from pps.filterd (ppma02fra.de.ibm.com [127.0.0.1])
        by ppma02fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 21HGHPJi024680;
        Thu, 17 Feb 2022 16:34:19 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma02fra.de.ibm.com with ESMTP id 3e64haa45g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 17 Feb 2022 16:34:18 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 21HGYCah32178446
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 17 Feb 2022 16:34:12 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5C1AB52051;
        Thu, 17 Feb 2022 16:34:12 +0000 (GMT)
Received: from li-e8dccbcc-2adc-11b2-a85c-bc1f33b9b810.ibm.com.com (unknown [9.43.54.12])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 983EC52057;
        Thu, 17 Feb 2022 16:34:07 +0000 (GMT)
From:   Kajol Jain <kjain@linux.ibm.com>
To:     mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org,
        nvdimm@lists.linux.dev, linux-kernel@vger.kernel.org,
        peterz@infradead.org, dan.j.williams@intel.com,
        ira.weiny@intel.com, vishal.l.verma@intel.com
Cc:     santosh@fossix.org, maddy@linux.ibm.com, rnsastry@linux.ibm.com,
        aneesh.kumar@linux.ibm.com, atrajeev@linux.vnet.ibm.com,
        vaibhav@linux.ibm.com, tglx@linutronix.de, kjain@linux.ibm.com
Subject: [PATCH v6 0/4] Add perf interface to expose nvdimm
Date:   Thu, 17 Feb 2022 22:03:53 +0530
Message-Id: <20220217163357.276036-1-kjain@linux.ibm.com>
X-Mailer: git-send-email 2.27.0
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: EA4kAF5icLgOS-KY8Yk0WsUXoUMk5w1n
X-Proofpoint-GUID: EA4kAF5icLgOS-KY8Yk0WsUXoUMk5w1n
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-02-17_06,2022-02-17_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 spamscore=0
 priorityscore=1501 mlxlogscore=999 malwarescore=0 bulkscore=0
 clxscore=1011 impostorscore=0 phishscore=0 suspectscore=0 adultscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2202170075
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Patchset adds performance stats reporting support for nvdimm.
Added interface includes support for pmu register/unregister
functions. A structure is added called nvdimm_pmu to be used for
adding arch/platform specific data such as cpumask, nvdimm device
pointer and pmu event functions like event_init/add/read/del.
User could use the standard perf tool to access perf events
exposed via pmu.

Interface also defines supported event list, config fields for the
event attributes and their corresponding bit values which are exported
via sysfs. Patch 3 exposes IBM pseries platform nmem* device
performance stats using this interface.

Result from power9 pseries lpar with 2 nvdimm device:

Ex: List all event by perf list

command:# perf list nmem

  nmem0/cache_rh_cnt/                                [Kernel PMU event]
  nmem0/cache_wh_cnt/                                [Kernel PMU event]
  nmem0/cri_res_util/                                [Kernel PMU event]
  nmem0/ctl_res_cnt/                                 [Kernel PMU event]
  nmem0/ctl_res_tm/                                  [Kernel PMU event]
  nmem0/fast_w_cnt/                                  [Kernel PMU event]
  nmem0/host_l_cnt/                                  [Kernel PMU event]
  nmem0/host_l_dur/                                  [Kernel PMU event]
  nmem0/host_s_cnt/                                  [Kernel PMU event]
  nmem0/host_s_dur/                                  [Kernel PMU event]
  nmem0/med_r_cnt/                                   [Kernel PMU event]
  nmem0/med_r_dur/                                   [Kernel PMU event]
  nmem0/med_w_cnt/                                   [Kernel PMU event]
  nmem0/med_w_dur/                                   [Kernel PMU event]
  nmem0/mem_life/                                    [Kernel PMU event]
  nmem0/poweron_secs/                                [Kernel PMU event]
  ...
  nmem1/mem_life/                                    [Kernel PMU event]
  nmem1/poweron_secs/                                [Kernel PMU event]

Patch1:
        Introduces the nvdimm_pmu structure
Patch2:
        Adds common interface to add arch/platform specific data
        includes nvdimm device pointer, pmu data along with
        pmu event functions. It also defines supported event list
        and adds attribute groups for format, events and cpumask.
        It also adds code for cpu hotplug support.
Patch3:
        Add code in arch/powerpc/platform/pseries/papr_scm.c to expose
        nmem* pmu. It fills in the nvdimm_pmu structure with pmu name,
        capabilities, cpumask and event functions and then registers
        the pmu by adding callbacks to register_nvdimm_pmu.
Patch4:
        Sysfs documentation patch

Changelog
---
Resend v5 -> v6
- No logic change, just a rebase to latest upstream and
  tested the patchset.

- Link to the patchset Resend v5: https://lkml.org/lkml/2021/11/15/3979

v5 -> Resend v5
- Resend the patchset

- Link to the patchset v5: https://lkml.org/lkml/2021/9/28/643

v4 -> v5:
- Remove multiple variables defined in nvdimm_pmu structure include
  name and pmu functions(event_int/add/del/read) as they are just
  used to copy them again in pmu variable. Now we are directly doing
  this step in arch specific code as suggested by Dan Williams.

- Remove attribute group field from nvdimm pmu structure and
  defined these attribute groups in common interface which
  includes format, event list along with cpumask as suggested by
  Dan Williams.
  Since we added static defination for attrbute groups needed in
  common interface, removes corresponding code from papr.

- Add nvdimm pmu event list with event codes in the common interface.

- Remove Acked-by/Reviewed-by/Tested-by tags as code is refactored
  to handle review comments from Dan.

- Make nvdimm_pmu_free_hotplug_memory function static as reported
  by kernel test robot, also add corresponding Reported-by tag.

- Link to the patchset v4: https://lkml.org/lkml/2021/9/3/45

v3 -> v4
- Rebase code on top of current papr_scm code without any logical
  changes.

- Added Acked-by tag from Peter Zijlstra and Reviewed by tag
  from Madhavan Srinivasan.

- Link to the patchset v3: https://lkml.org/lkml/2021/6/17/605

v2 -> v3
- Added Tested-by tag.

- Fix nvdimm mailing list in the ABI Documentation.

- Link to the patchset v2: https://lkml.org/lkml/2021/6/14/25

v1 -> v2
- Fix hotplug code by adding pmu migration call
  incase current designated cpu got offline. As
  pointed by Peter Zijlstra.

- Removed the retun -1 part from cpu hotplug offline
  function.

- Link to the patchset v1: https://lkml.org/lkml/2021/6/8/500

Kajol Jain (4):
  drivers/nvdimm: Add nvdimm pmu structure
  drivers/nvdimm: Add perf interface to expose nvdimm performance stats
  powerpc/papr_scm: Add perf interface support
  docs: ABI: sysfs-bus-nvdimm: Document sysfs event format entries for
    nvdimm pmu

 Documentation/ABI/testing/sysfs-bus-nvdimm |  35 +++
 arch/powerpc/include/asm/device.h          |   5 +
 arch/powerpc/platforms/pseries/papr_scm.c  | 225 ++++++++++++++
 drivers/nvdimm/Makefile                    |   1 +
 drivers/nvdimm/nd_perf.c                   | 328 +++++++++++++++++++++
 include/linux/nd.h                         |  41 +++
 6 files changed, 635 insertions(+)
 create mode 100644 drivers/nvdimm/nd_perf.c

-- 
2.31.1

