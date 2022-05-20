Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D5D752E2E7
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 05:11:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345065AbiETDLo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 23:11:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345045AbiETDK6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 23:10:58 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2050.outbound.protection.outlook.com [40.107.237.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C30112AE16;
        Thu, 19 May 2022 20:10:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cZxd3hjzavVvOmzyAsVNHjFoBKtTdkp/hz5glS872NCMjmS5VlW8RLygB/amwmtOJZ0c6B3rr3OZVu87kmPaLfjUeq0ZymhEohFQQ2lCf8fWl735ZeVftlAjIkGlDYXnXJ5X85h0qJRIKjLWs8/qBv+LXaMZB1eS0gXyKd0f5lWFY6kyDYTWe2gp2wrWNSznIe6l8PjaIxpzo01FXq5xOgNfauB0+a8o/WYimAl9n30K69Y9tKTWfYSvviiKibz9KkrEGKT4+KthS/Ko9mmgLJ0AbdN0YsJeJIvn6mWaWqK6aiQ1eVm6VAdlx8mnc5wRhioSNrFqmPsMv1BFzDSnMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xc58ztUwCnc1VC1kseQvYguAJCiZ49N+ypQU7gUzRyk=;
 b=jj3O/McZxxGSjqeAC6T63tOl6hjwqwqSX8HzGAniDbaofRN0OLyhFb9q6zjmmK4HB4R8hFAa0AS4RucS1onb5UJFDDdvkQzOCCoCSbbYkkK/mbEMGU7YuQL+MhCItMXyS42JYrRgWtO9EI0rF9sVji144x+IqTRBvemeR/wLb7bDKjvui1NcKiqxGP6JmShdweU4j7plFB/7nlWyGzRFV/GuNjfrLwuOhK6yoBobtqXz9sLUcPAYSeM02Hj5thZqrTuFKslMVUVpXfj4UPJkz3oNl3E8wu6QxruoRdyiRMSYxQJ0V6nqtdb5MMihYPMzjdwnAox778uZXdlUlq6AXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=linaro.org smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xc58ztUwCnc1VC1kseQvYguAJCiZ49N+ypQU7gUzRyk=;
 b=DR+Qxj1T+qDwnrczVbNLsePx0z2xPK7Kur67gRr8r07gtrAH38cunSVdVJblgo6GG9RbJdntEUGcu+FJWItYn++CL+dFm5FkYr8d/AACVHGcl9dJ7K7iV/q5sM26UzI2K9Krs9wAlOpakGqA7kVc7OiOkWI9iGyCjc4tE6XD124=
Received: from SN7PR18CA0022.namprd18.prod.outlook.com (2603:10b6:806:f3::21)
 by PH7PR02MB8955.namprd02.prod.outlook.com (2603:10b6:510:1f9::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.18; Fri, 20 May
 2022 03:10:54 +0000
Received: from SN1NAM02FT0010.eop-nam02.prod.protection.outlook.com
 (2603:10b6:806:f3:cafe::4d) by SN7PR18CA0022.outlook.office365.com
 (2603:10b6:806:f3::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.17 via Frontend
 Transport; Fri, 20 May 2022 03:10:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch02.xlnx.xilinx.com; pr=C
Received: from xsj-pvapexch02.xlnx.xilinx.com (149.199.62.198) by
 SN1NAM02FT0010.mail.protection.outlook.com (10.97.4.76) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5273.14 via Frontend Transport; Fri, 20 May 2022 03:10:54 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Thu, 19 May 2022 20:10:46 -0700
Received: from smtp.xilinx.com (172.19.127.95) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Thu, 19 May 2022 20:10:46 -0700
Envelope-to: mathieu.poirier@linaro.org,
 bjorn.andersson@linaro.org,
 robh+dt@kernel.org,
 krzk+dt@kernel.org,
 linux-remoteproc@vger.kernel.org,
 devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Received: from [10.23.120.20] (port=64934)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <tanmay.shah@xilinx.com>)
        id 1nrt2L-0008zb-TB; Thu, 19 May 2022 20:10:46 -0700
Message-ID: <b4bef7c4-7f12-1cdb-c2f0-a248c125b9b4@xilinx.com>
Date:   Thu, 19 May 2022 20:10:44 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.9.0
From:   <tanmay.shah@xilinx.com>
To:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        <bjorn.andersson@linaro.org>, <robh+dt@kernel.org>,
        <krzk+dt@kernel.org>, <michal.simek@xilinx.com>,
        <linux-remoteproc@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v5 0/6] Add Xilinx RPU subsystem support
References: <20220518194426.3784095-1-tanmay.shah@xilinx.com>
 <CANLsYkw9HuLso9bGL4fM7C9qH+basgKA9yKFwms4WB4OUHqymQ@mail.gmail.com>
In-Reply-To: <CANLsYkw9HuLso9bGL4fM7C9qH+basgKA9yKFwms4WB4OUHqymQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6ad0fb10-2d05-4821-e22e-08da3a0e5a3d
X-MS-TrafficTypeDiagnostic: PH7PR02MB8955:EE_
X-Microsoft-Antispam-PRVS: <PH7PR02MB8955E8E576CEB5DAFB5FC252CAD39@PH7PR02MB8955.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: N2MvgR4B455eGkuzPFdFONBq+ml3qFy1tLG74J/qi5GIMuonxgGMZdX4a1P2pO99X3IX2CeoKfuYHWkOpasBqcuNXLERa20UogP3PWw0Pjz/QtJaOrBlTib6FqqqvC7Cx1S2HEle/3YK7Tg09JRTt5hz5Aeq2ktdMv5aY53v7utlfK3LI+A35EE/bzRpWYheHAWPbABiYrPxN+o6+nD1n34YGVX9GE3slBQ5sOpJxxHpZPdwkJwCiXpfRx2R6oJKsITJVxvOpwa68LSTQu/DiXodpQIg+nAy7j2Dh6ZZV4P3oSkUdvYRBPOMRQaeXy/Qoa/SpeL+g3Oi3S22xuC+gBW2MbGqWzsVnNHDEEkYXO9/3QPjnktgi3Z7Fgmz7+opshBBpa5Dl+hm2kEKORKthKBLdHLsBSW1ajcGnHca3ixkLnYeCFp7Ffm6hplSaBXJYQWX5XOcNSyhQXbQvUy9XlRrz4k3QS4QvkZ5ZaLCZJzInomO+nWW9CxBn260IOmmhc0BqZNmI9r788tW+oQJrN8yNhx9z6WKoIiCIR/ckFpJwDA++nSkQaor7gpO94NZ6qKyIsyWTQIm3hRjrblUoWrYQYjVOGbMkd0dD/PcdgP5IDmWT5osJpa+fwelhu1Nlx/hE2ydqUwA4rEFWr+VguiBkAhoSZrPi4uu73y7FGx/VI7h8II+eEbzB8S7xDxXJiAkHGD7xqkcKa2O6a7xpJtlwb0/ZmuMfe1wHicFBV6rgNuBRhmDg2uWXCh1QLXp
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch02.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(40470700004)(46966006)(186003)(53546011)(336012)(82310400005)(356005)(110136005)(426003)(47076005)(36756003)(8936002)(9786002)(2876002)(31696002)(2616005)(8676002)(5660300002)(70586007)(83380400001)(26005)(2906002)(31686004)(316002)(508600001)(36860700001)(70206006)(40460700003)(7636003)(50156003)(43740500002)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2022 03:10:54.3523
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ad0fb10-2d05-4821-e22e-08da3a0e5a3d
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch02.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1NAM02FT0010.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR02MB8955
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/19/22 3:19 AM, Mathieu Poirier <mathieu.poirier@linaro.org> wrote:
> Hi Tanmay,
> 
> I have replaced the previous version of this set with this one in my
> queue.  That way you don't go back to the bottom.
> 

Thanks Mathieu. Sure it will help.

> Thanks,
> Mathieu.
> 
> On Wed, 18 May 2022 at 20:46, Tanmay Shah <tanmay.shah@xilinx.com> wrote:
> >
> > This patch series adds bindings document for RPU subsystem found on Xilinx
> > ZynqMP platforms. It also adds device nodes and driver to enable RPU
> > subsystem in split mode and lockstep mode.
> >
> > Xilinx ZynqMP platform contains Remote Processing Unit(RPU). RPU subsystem
> > contains two arm cortex r5f cores. RPU subsystem can be configured in
> > split mode, lockstep mode and single-cpu mode.
> >
> > RPU subsystem also contains 4 Tightly Coupled Memory(TCM) banks.
> > In lockstep mode, all 4 banks are combined and total of 256KB memory is
> > made available to r5 core0. In split mode, both cores can access two
> > TCM banks i.e. 128 KB.
> >
> > RPU can also fetch data and execute instructions from DDR memory along with
> > TCM memory.
> > ---
> >
> > Changes in v5:
> >    - Add constraints of the possible values of xlnx,cluster-mode property
> >    - fix description of power-domains property for r5 core
> >    - Remove reg, address-cells and size-cells properties as it is not required
> >    - Fix description of mboxes property
> >    - Add description of each memory-region and remove old .txt binding link
> >      reference in the description
> >    - Remove optional reg property from r5fss node
> >    - Move r5fss node out of axi node
> >
> > Changes in v4:
> >    - Add memory-region, mboxes and mbox-names properties in dt-bindings example
> >    - Add reserved memory region node and use it in Xilinx dt RPU subsystem node
> >    - Remove redundant header files
> >    - use dev_err_probe() to report errors during probe
> >    - Fix missing check on error code returned by zynqmp_r5_add_rproc_core()
> >    - Fix memory leaks all over the driver when resource allocation fails for any core
> >    - make cluster mode check only at one place
> >    - remove redundant initialization of variable
> >    - remove redundant use of of_node_put()
> >    - Fix Comment format problem
> >    - Assign offset of zynqmp_tcm_banks instead of duplicating it
> >    - Add tcm and memory regions rproc carveouts during prepare instead of parse_fw
> >    - Remove rproc_mem_entry object from r5_core
> >    - Use put_device() and rproc_del() APIs to fix memory leaks
> >    - Replace pr_* with dev_*. This was missed in v3, fix now.
> >    - Use "GPL" instead of "GPL v2" in MODULE_LICENSE macro. This was reported by checkpatch script.
> >
> > Changes in v3:
> >    - Fix checkpatch script indentation warning
> >    - Remove unused variable from xilinx remoteproc driver
> >    - use C style comments, i.e /*...*/
> >    - Remove redundant debug information which can be derived using /proc/device-tree
> >    - Fix multiline comment format
> >    - s/"final fot TCM"/"final for TCM"
> >    - Function devm_kzalloc() does not return an code on error, just NULL.
> >      Remove redundant error check for this function throughout the driver.
> >    - Fix RPU mode configuration and add documentation accordingly
> >    - Get rid of the indentations to match function documentation style with rest of the driver
> >    - Fix memory leak by only using r5_rproc->priv and not replace it with new instance
> >    - Use 'i' for the outer loop and 'j' for the inner one as per convention
> >    - Remove redundant error and NULL checks throughout the driver
> >    - Use devm_kcalloc() when more than one element is required
> >    - Add memory-regions carveouts during driver probe instead of parse_fw call
> >      This removes redundant copy of reserved_mem object in r5_core structure.
> >    - Fix memory leak by using of_node_put()
> >    - Fix indentation of tcm_mem_map function args
> >    - Remove redundant init of variables
> >    - Initialize tcm bank size variable for lockstep mode
> >    - Replace u32 with phys_addr_t for variable stroing memory bank address
> >    - Add documentation of TCM behavior in lockstep mode
> >    - Use dev_get_drvdata instead of platform driver API
> >    - Remove info level messages
> >    - Fix checkpatch.pl warnings
> >    - Add documentation for the Xilinx r5f platform to understand driver design
> >
> > Changes in v2:
> >    - Remove proprietary copyright footer from cover letter
> >
> >
> > Ben Levinsky (3):
> >    firmware: xilinx: Add ZynqMP firmware ioctl enums for RPU
> >      configuration.
> >    firmware: xilinx: Add shutdown/wakeup APIs
> >    firmware: xilinx: Add RPU configuration APIs
> >
> > Tanmay Shah (3):
> >    dt-bindings: remoteproc: Add Xilinx RPU subsystem bindings
> >    arm64: dts: xilinx: zynqmp: Add RPU subsystem device node
> >    drivers: remoteproc: Add Xilinx r5 remoteproc driver
> >
> >   .../bindings/remoteproc/xlnx,r5f-rproc.yaml   |  128 ++
> >   arch/arm64/boot/dts/xilinx/zynqmp.dtsi        |   33 +
> >   drivers/firmware/xilinx/zynqmp.c              |   97 ++
> >   drivers/remoteproc/Kconfig                    |   12 +
> >   drivers/remoteproc/Makefile                   |    1 +
> >   drivers/remoteproc/xlnx_r5_remoteproc.c       | 1045 +++++++++++++++++
> >   include/dt-bindings/power/xlnx-zynqmp-power.h |    6 +
> >   include/linux/firmware/xlnx-zynqmp.h          |   60 +
> >   8 files changed, 1382 insertions(+)
> >   create mode 100644 Documentation/devicetree/bindings/remoteproc/xlnx,r5f-rproc.yaml
> >   create mode 100644 drivers/remoteproc/xlnx_r5_remoteproc.c
> >
> >
> > base-commit: 01a1a0c8d456b11f2f6b9b822414481beaa44d6f
> > --
> > 2.25.1
> >
> 
