Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AFE655D02F
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:07:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245126AbiF1Fon (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 01:44:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245111AbiF1Fol (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 01:44:41 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2055.outbound.protection.outlook.com [40.107.92.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D22881EAC9;
        Mon, 27 Jun 2022 22:44:40 -0700 (PDT)
ARC-Seal: i=2; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=pass;
 b=eOIuR1WNx12ubOqjddbhUWUC5c+6rHj5l6/WfRTCt/V/70rL7hc56J/CBBhuvbURyiRQzic2KWWMtXww5daOwooXTu78PpX1IdncE9RxJk6O6wKV9dYMDwp7U5OZCS3Jsqbgg3XX1vasuuIVvGfFLVO3IuIjPwH0vVAg+BqduSj/9tEhwV3Yh7w3/SyZDRxmu1V00tfNvo8ffKwQBhxsqEU/mtF3zvPh6E7SkyUptQXoUYE10iKZGvYkNraVGFE8DA6XNbhAv8HLM/4Uj7XRs4LMYXI7Bi9EThOD4sJxXJQkLpmuDLtSqw426MEW6Ui3FxqgvDl87LGOpOG1GIoDvA==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x9BLM+typ11ubbiEQ216cyxzCory2RRLJk3GjCPcMTw=;
 b=SPuzWxUQBNKUnfQBhDNl2lqpP5MkH5mL3BL3Br87Zn4HTM8QA4TzXWMlq+aU7UroCyIkHU1+9X8JMioaTsqkCMnB9STTT8uCZ+NbSNh3XohZompr+uTEl/KcgGFZKD7XFLUjAM1SksYXh9DeGzwBfS4aXhte2TCqswidbKJbN3lZZCgQLvGw0PjHX+Wg42UARc3+Puq4Nyj2vbykdWcU345QQqueooKVMRgPIsd98eFJn6lrCAeXQ8E/AhA2k+Z/VxdlGg17zlKhgv4T14xCKT/D1ikJw+PmmBOJGkbmz/+r7v73mJkxFizkToTNb0WEnLUfgG9lM3RhIgPQHtRI6w==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 20.83.241.18) smtp.rcpttodomain=arndb.de smtp.mailfrom=xilinx.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=xilinx.com; dkim=none
 (message not signed); arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=xilinx.com] dmarc=[1,1,header.from=xilinx.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x9BLM+typ11ubbiEQ216cyxzCory2RRLJk3GjCPcMTw=;
 b=sSap7TyE1OLM9MJ+Oa8mgHpYCke9M+LJkC3xWzfXKZ0U7mYrez3r8ijPDG6zXWMFlabio7OYyW7BTo7JZ1+KPDyAQ6nJ+8FzTeBEUEldDP0q3FvunbPtTt88Ngedc/9Nx3hxpbmFigHxjvZmzXv4kZBVMpl67RznpwqSIB18xRE=
Received: from SA9PR13CA0165.namprd13.prod.outlook.com (2603:10b6:806:28::20)
 by BY5PR02MB6721.namprd02.prod.outlook.com (2603:10b6:a03:208::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.15; Tue, 28 Jun
 2022 05:44:37 +0000
Received: from SN1NAM02FT0051.eop-nam02.prod.protection.outlook.com
 (2603:10b6:806:28:cafe::59) by SA9PR13CA0165.outlook.office365.com
 (2603:10b6:806:28::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.7 via Frontend
 Transport; Tue, 28 Jun 2022 05:44:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 20.83.241.18)
 smtp.mailfrom=xilinx.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 20.83.241.18 as permitted sender) receiver=protection.outlook.com;
 client-ip=20.83.241.18;
 helo=mailrelay000001.14r1f435wfvunndds3vy4cdalc.xx.internal.cloudapp.net;
 pr=C
Received: from
 mailrelay000001.14r1f435wfvunndds3vy4cdalc.xx.internal.cloudapp.net
 (20.83.241.18) by SN1NAM02FT0051.mail.protection.outlook.com (10.97.5.34)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.15 via Frontend
 Transport; Tue, 28 Jun 2022 05:44:36 +0000
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2169.outbound.protection.outlook.com [104.47.59.169])
        by mailrelay000001.14r1f435wfvunndds3vy4cdalc.xx.internal.cloudapp.net (Postfix) with ESMTPS id 71EAF419D5;
        Tue, 28 Jun 2022 05:44:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eCVKMqfhOhvybfwMdGVosSRdL17GZBDZNJExMhFiBn1BtD/SqiNBIFB6cUb8oa0RkxPeRqCRI1pGoUhFJtEdkouATxApee8q4wqA6qLZRpg6eY5EtQ9KmdngjM5G1F5ckwbgw30r3JX36wKeVUKPG4HERKe38jAJKyDpeik7pdBaEprW8yFQYjtrkcv4VZmzK8c1T7TG7V2H0Qp/b/WWkx8Sp59J8k7TL4p6xnoP/VgHTsUVwyeIyZYJPFI5/zC7fy0IyoHZYMcX/3BdPiEusqwJcA66VsKSI1/5J2Us7yvj5PpBw1Vp7ATMDbPBXGOC0iSRWA6uG+Cwu+LmJkjtwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x9BLM+typ11ubbiEQ216cyxzCory2RRLJk3GjCPcMTw=;
 b=QEWIEhrV9f2u3h4d30nmIHsPU8MxL4hl0g9AX2iODqK5XEx8pvSu6Yo2DFKFVGMcVzqxHi7bU7+EGA9g83woQmzbH977TvptxybBXrao/VulcRdgxkfgkRt5ZFf6qEnpUpVcf6SmfkIfawrbst0snmL1a4mbCm9EuMDKN7aKhKz1ONoWj7rb4H0AORIteSVWJozO2FonfCrg/kH7S94yCxewo3inTq6R2WhOI/HriIvqjXxJPkyi5d0pYXNZAjyMyUGTzs5UwE0dYeKfg5InBU8YWQbM/fu14sroFqUK/RmrdBi+gGUYcs+P/wAeDNVvYXjCoMIjsVBCedmVewRIiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=kernel.org smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
Received: from DM6PR02CA0141.namprd02.prod.outlook.com (2603:10b6:5:332::8) by
 BL0PR02MB5572.namprd02.prod.outlook.com (2603:10b6:208:8a::24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5373.18; Tue, 28 Jun 2022 05:44:34 +0000
Received: from DM3NAM02FT061.eop-nam02.prod.protection.outlook.com
 (2603:10b6:5:332:cafe::10) by DM6PR02CA0141.outlook.office365.com
 (2603:10b6:5:332::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.15 via Frontend
 Transport; Tue, 28 Jun 2022 05:44:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=xilinx.com;
Received: from xsj-pvapexch01.xlnx.xilinx.com (149.199.62.198) by
 DM3NAM02FT061.mail.protection.outlook.com (10.13.4.230) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5373.15 via Frontend Transport; Tue, 28 Jun 2022 05:44:33 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Mon, 27 Jun 2022 22:43:55 -0700
Received: from smtp.xilinx.com (172.19.127.95) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Mon, 27 Jun 2022 22:43:55 -0700
Envelope-to: git@xilinx.com,
 robh+dt@kernel.org,
 krzysztof.kozlowski+dt@linaro.org,
 devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 arnd@arndb.de,
 gregkh@linuxfoundation.org,
 linux-arm-kernel@lists.infradead.org,
 git@amd.com
Received: from [10.140.6.6] (port=51114 helo=xhdappanad40.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <appana.durga.rao@xilinx.com>)
        id 1o640w-0007Ut-RA; Mon, 27 Jun 2022 22:43:55 -0700
From:   Appana Durga Kedareswara rao <appana.durga.rao@xilinx.com>
To:     <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <appana.durga.rao@xilinx.com>, <michal.simek@xilinx.com>,
        <derek.kiernan@xilinx.com>, <dragan.cvetic@xilinx.com>,
        <arnd@arndb.de>, <gregkh@linuxfoundation.org>,
        <linux-arm-kernel@lists.infradead.org>
CC:     <git@amd.com>, <git@xilinx.com>
Subject: [PATCH 3/4] dt-bindings: misc: tmr-inject: Add device-tree binding for TMR Inject
Date:   Tue, 28 Jun 2022 11:13:37 +0530
Message-ID: <20220628054338.1631516-4-appana.durga.rao@xilinx.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220628054338.1631516-1-appana.durga.rao@xilinx.com>
References: <20220628054338.1631516-1-appana.durga.rao@xilinx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 1
X-MS-Office365-Filtering-Correlation-Id: cde90a15-a538-4d67-c321-08da58c94976
X-MS-TrafficTypeDiagnostic: BL0PR02MB5572:EE_|SN1NAM02FT0051:EE_|BY5PR02MB6721:EE_
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: YG/wZKkC0v+Qx0edHcwxgEsn8DMMXOY82u6ynkiaIW3aI7VMcAcuJ7aGFy65EHRCmkChoYMlQFMam/c1r5JRI69WGbnsJtjowr9jsuhLUMMBUmKtLge6v3ldFeCe1PDTQJ2rnJ33izYL0P67NJx0VFvRvb6NHXMh2JetBMuQab0EkDca3lGrf0AbXyR5w1QUJCY2ohXYVPp+CiJrO/EK0mlVNgRH9pOngAIMFshhMS+dkEKkg8sV2tyavg6ogYUVs9GpMnrfwpdZwfO1z1X8elzo02DXCj6drx93lxqmltFfgTtD0AEY7UnV6KgUR2VZFZYMzLxVLwX4ShMkiOCzfE42MWkUUXcMa58KOXKrA+PzubYIXSg/eUXSIAdRI1JSJaEhtGb2l06tj8xRCKTZ68hfB6Vju6h+jURB2xYRd50R7sMCTUwvpaGuD4pnU09p0l0pHtE0pEyG2wpUorPuX8YjhudAnSs4c3q/HNvqXgxFhRUTBvX3E0NoYp0vUH3gOM9OtTzREU8nEADVCx3lc27tWGxe2VAcAsdiUhEuhpnFq6Risy9pB1pH9utzAOyi+UhyvfEhE+OU9iTf+8b4NCl41bGOHZbXbP8gqHDmnhaQBKOepgBtBlObgPKV5ifZO3azEaTJw6Db4Q3Ww73YolKF9q/I7ztXh/9uFxxPmaTkcbHLaln8JEPB/bAGn9z1uhS8pPKyoLYxaULMWl5eBVbLjBEiZ8g6PsK+tXN47jpghUMTAvewcjVv4oLv8zemHbRvN40Mz/uZgxJZ62iDvGDlnMUxf5FanPiD9D162f7Gr/P80Gwa/icuNWAEghdARLS7WHCuMbe/RbwwMKJfrj7iP9fW7wgGQBAwt8IDR9Ke84keZy1Ri442j4gyMNejhsos/q1ducZHL3oepBYoCCHzKVv18eQdDy/YZbbxCbM=
X-Forefront-Antispam-Report-Untrusted: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch01.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(13230016)(4636009)(346002)(376002)(396003)(39860400002)(136003)(40470700004)(36840700001)(46966006)(4326008)(2616005)(8936002)(316002)(41300700001)(921005)(9786002)(70206006)(7696005)(26005)(1076003)(70586007)(107886003)(8676002)(478600001)(356005)(966005)(36756003)(426003)(40480700001)(2906002)(82310400005)(83380400001)(6666004)(7636003)(82740400003)(103116003)(36860700001)(5660300002)(40460700003)(336012)(54906003)(110136005)(186003)(47076005)(102446001);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR02MB5572
X-MS-Exchange-Transport-CrossTenantHeadersStripped: SN1NAM02FT0051.eop-nam02.prod.protection.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 3aab8d67-0f15-4a0b-e817-08da58c94799
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?/OrzrRs+I0+JW6h99HTTLjJkoU8EXicJlSjDgYyDclOQoxYEVFJ3QFWty1om?=
 =?us-ascii?Q?nuXsYbq6USva8+WZ5I63ovhTQLAO94yPwsBq+AWtLatEMStA8FCT+GZAm0lq?=
 =?us-ascii?Q?3GeS6FBGay6SIUC28M48RmXCnwdttXUaxJnyk7hz+k92rLRDV2G/Kp8vGQUY?=
 =?us-ascii?Q?ICKjjnj+iE9tJCxMc9cjH06oziA+fzibNSA3lPaEIZPQqJmf6eXoVWg6rax1?=
 =?us-ascii?Q?DhsBsAtctjO1D49e/IxHw9sWmxjuu/b7jlVzgPFsrZQmUy65NH3AzTnQ853E?=
 =?us-ascii?Q?xn+SoiFj+3XcdIVJaZgvLbjXUQFtK/S9X2wOaH/FNkd9kByxph0Dr+LBD7cJ?=
 =?us-ascii?Q?jf4nRFPRr5taa6OAPr1IeNckQHjHpl0v3OHxn8hkmtBk+L6vEaPMCseviB1u?=
 =?us-ascii?Q?23djOfUXhyK7/k6icA2pqLMJVCm8xn3UfMn9usHq1QNeSP2MJnFewoOtAAx9?=
 =?us-ascii?Q?Dg7ocIVbY/VA/aYCqQIdiJlEfBT4Rm4Tgmmx7yOh7hdM2HNIpi0aiWHrs1PX?=
 =?us-ascii?Q?RWJuI0cooBRLNqMpu3tAYOVWDamqR/f7VCuJOmQcYjBCTzKbZc+unpdS69S+?=
 =?us-ascii?Q?XiD99s5+R2oMiWMPRnEYCli/ftUOJHGKS++VkE0b2eun7B32COy1n0A7eWLp?=
 =?us-ascii?Q?iI0Ln48WwhjQl9uqTM/WbOTQhni30WoFqEmkPYRo4o7vMNgxb76asX0QcWhZ?=
 =?us-ascii?Q?6eNnHypm1Fmv+wf4YKPx3rti2FVtODoWxiJv8768vYqgwOHpMopnNxVVZA2C?=
 =?us-ascii?Q?+7dSvDmw1I2jbkLVb6xPg29t3yyvE3ncnIwQdCGas9986snh87ljC6YqIPih?=
 =?us-ascii?Q?KEdW7u4Va4KBZhYUpbRQ3an33WxMSWjj1sPV7zoKzCG0FFx0dYHS2Fsf5Hty?=
 =?us-ascii?Q?oIsqKPHjMJkh9yghDHCMbFTSpyh/hMIulZAaKuX6MiyKwzYvdE8XS7REoSVp?=
 =?us-ascii?Q?4/aCIcdCLTj8Kp5Ck+Bhvw=3D=3D?=
X-Forefront-Antispam-Report: CIP:20.83.241.18;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mailrelay000001.14r1f435wfvunndds3vy4cdalc.xx.internal.cloudapp.net;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(346002)(136003)(396003)(39860400002)(376002)(46966006)(40470700004)(36840700001)(8676002)(47076005)(107886003)(6666004)(40460700003)(4326008)(336012)(478600001)(186003)(36860700001)(70206006)(103116003)(316002)(1076003)(54906003)(2616005)(81166007)(83380400001)(110136005)(41300700001)(7696005)(36756003)(82740400003)(426003)(8936002)(26005)(921005)(5660300002)(40480700001)(9786002)(966005)(2906002)(82310400005)(102446001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jun 2022 05:44:36.9287
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cde90a15-a538-4d67-c321-08da58c94976
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[20.83.241.18];Helo=[mailrelay000001.14r1f435wfvunndds3vy4cdalc.xx.internal.cloudapp.net]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-SN1NAM02FT0051.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR02MB6721
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This commit adds documentation for Triple Modular Redundancy (TMR)
Inject IP.

Signed-off-by: Appana Durga Kedareswara rao <appana.durga.rao@xilinx.com>
---
 .../bindings/misc/xlnx,tmr-inject.yaml        | 47 +++++++++++++++++++
 1 file changed, 47 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/misc/xlnx,tmr-inject.yaml

diff --git a/Documentation/devicetree/bindings/misc/xlnx,tmr-inject.yaml b/Documentation/devicetree/bindings/misc/xlnx,tmr-inject.yaml
new file mode 100644
index 000000000000..4daf9539000b
--- /dev/null
+++ b/Documentation/devicetree/bindings/misc/xlnx,tmr-inject.yaml
@@ -0,0 +1,47 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/misc/xlnx,tmr-inject.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Xilinx TMR Inject Device Tree Bindings
+
+maintainers:
+  - Appana Durga Kedareswara rao <appana.durga.rao@xilinx.com>
+
+description: |
+  The Triple Modular Redundancy(TMR) Inject core provides functional fault
+  injection by changing selected MicroBlaze instructions, which provides the
+  possibility to verify that the TMR subsystem error detection and fault
+  recovery logic is working properly.
+
+properties:
+  compatible:
+    enum:
+      - xlnx,tmr-inject-1.0
+
+  reg:
+    maxItems: 1
+
+  xlnx,magic:
+    minimum: 0
+    maximum: 255
+    description: |
+      Magic number used when injecting faults. The fault inject write data least
+      significant byte (bits 7:0) must match this number to have any effect.
+    $ref: /schemas/types.yaml#/definitions/uint32
+
+required:
+  - compatible
+  - reg
+  - xlnx,magic
+
+additionalProperties: false
+
+examples:
+  - |
+    tmr-inject@44a30000 {
+            compatible = "xlnx,tmr-inject-1.0";
+            reg = <0x44a10000 0x10000>;
+            xlnx,magic = <0x46>;
+    };
-- 
2.25.1

