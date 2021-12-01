Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6108D464ADF
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 10:45:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348332AbhLAJsm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 04:48:42 -0500
Received: from szxga03-in.huawei.com ([45.249.212.189]:28210 "EHLO
        szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346106AbhLAJsk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 04:48:40 -0500
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.56])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4J3vKN0Mmsz8vmm;
        Wed,  1 Dec 2021 17:43:20 +0800 (CST)
Received: from kwepemm600001.china.huawei.com (7.193.23.3) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Wed, 1 Dec 2021 17:45:13 +0800
Received: from [10.67.103.10] (10.67.103.10) by kwepemm600001.china.huawei.com
 (7.193.23.3) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.20; Wed, 1 Dec
 2021 17:45:12 +0800
To:     <Brice.Goglin@inria.fr>
CC:     <hwloc-devel@lists.open-mpi.org>, <linux-kernel@vger.kernel.org>,
        <song.bao.hua@hisilicon.com>, <linuxarm@huawei.com>,
        "shenyang (M)" <shenyang39@huawei.com>,
        Jonathan Cameron <jonathan.cameron@huawei.com>,
        yangyicong <yangyicong@huawei.com>
From:   Chengchang Tang <tangchengchang@huawei.com>
Subject: [RFC] hwloc: Add support for exporting latency, bandwidth topology
 through calibration
Message-ID: <802b22da-199a-a724-972b-9bc0cabd43fb@huawei.com>
Date:   Wed, 1 Dec 2021 17:45:12 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.103.10]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemm600001.china.huawei.com (7.193.23.3)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, hwloc can export hardware and network locality for 
applications to obtain and set their affinity. However, in many 
scenarios, the information provided by the topology is not enough, for 
example, it cannot reflect the actual memory latency and bandwidth data 
between different schedule domain. We hope to provide more detailed and 
precise information of HW capabilities in hwloc by adding several new 
calibration tools, so that application can achieve a more refined design 
to achieve higher performance and fully tap the capabilities of the HW.

We mainly focus on exposing memory/bus bandwidth, cache coherence/bus 
communication latency etc to users. Those topology information has 
neither standard ACPI nor dts interface to export, but they can be 
beneficial of user applications. Some examples,
1. the memory bandwidth while we spread tasks between multiple clusters 
vs. gather them in one cluster
2. the memory bandwidth while we spread tasks between multiple NUMA 
nodes vs. gather them in one NUMA
3. the cache synchronization latency while we spread tasks between 
multiple clusters vs. gather them in one cluster
4. the cache synchronization latency while we spread tasks between 
multiple NUMA nodes vs. gather them in one NUMA node
5. bus bandwidth and congestion in complex topology, for example, for 
the below topology
node 1 - node0 - node2 - node3
the bus between node0 and node2 might become bottleneck as the 
communications between node1 and node3 also depend on it.
numa distance can't describe this kind of complex bus topology at all.
6. I/O bandwidth and latency while we access I/O devices such as 
accelerators, networks, storages from the NUMA node which devices belong 
to vs. from different NUMA nodes.
...

If possible, we also can export more such as IPC bandwidth and 
latency(for example, pipe), spinlock/mutex latency etc. Calibration 
tools will provide these data about different entities at some certain 
topology levels so that application could select the spreading and 
gathering strategy of threads according to this data.

The design of the calibration tool will be similar to netloc. Three 
steps are required to use the calibration tool.

The first step is to get data about system bandwidth, latency, etc by 
running some benchmark tests since the standard operating system does 
not support providing this information. The raw data will be saved in 
files. This step may need to be performed by a privilege user.

The second step is to convert the original file generated in the 
previous step into a file in a readable format by the calibration tool. 
No privileges are required for this step.

In the third step, the application could obtain the calibration 
information of the system through a C APIs exposed by calibration tool 
and hwloc commands can be also extended to show these new information. 
The source of the calibration data is the readable file generated in the 
second step. E.g. hwloc_get_mem_bandwidth(hwloc_topology_t topology, 
unsigned idx1, unsigned idx2) could be used to get the memory bandwidth 
ability between idx1 and idx2 in some topology type.

