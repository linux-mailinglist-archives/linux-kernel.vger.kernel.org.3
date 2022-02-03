Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1696D4A8347
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Feb 2022 12:40:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350306AbiBCLkD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Feb 2022 06:40:03 -0500
Received: from mail-eopbgr20071.outbound.protection.outlook.com ([40.107.2.71]:62174
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1350298AbiBCLkC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Feb 2022 06:40:02 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DCnoC6v/7JwRubH4ot1T9VSNctWj4mUN9CSkF5m7dPk/PNU3lJZmcQeclAKaILJ1FV+LbMYLZlvVZJN6Ns4/6cKK9ivsb1BTztmTIqpMtN4+4ATmdB/f5r697Oxbp6OWp2Ahk+MdIKPCPcIIM110QXasDfDNlIOBtLob213tcY6vkfCnPKUzcI2ArwHYEgZyiTYwE7/8DcG+ZMOyy2Pp56MFuKXaUBYF0nVK8bvdnKaM901jNq4MqL4cgm6Zg9nnuoi2u9JQIBcgmj7hSh3Av8lWmC/Kxju+jIM5IF2xyXJCvzHRSa9sl/WW0JKFRFID9x4rmiKLWCx4+a0m+zZjPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9GSNs47m20ASgJsyx2+5Yqb8M1KranWXfep8uqTdKQ4=;
 b=TxhBQe9cy6r6dWqwPQpIsMyT4WqQd97cdE6rXcfbdrioi4PTe1DPfKS0RD2X1+HicEZC4PHYnB9VjIxsnLFzmxAtEQgNB1dnvn3iYXQUmc2cbh4Pi0N8Jg/3qz67dxCN50U2r0xX2hoIzdiGAfJG6G1e5n/ZYJJ21zM+lamF7+X0f+vEVwK1bo00vX4qQ5dfV/vh6EawEvGP8x8tvX+IoJvPu05ijEhuqloQis6VgaxAGTAze8AXMeuRrsoDngQfDSET1k85nCks6Kqd7XBZr2qkLuiLLYqvRVBXiXI7HjbyhJV87VxGZw/YxDiBiKmKcAC3yYBIwuX+5BQBJ9kRrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 194.138.21.70) smtp.rcpttodomain=ti.com smtp.mailfrom=siemens.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=siemens.com; dkim=none
 (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9GSNs47m20ASgJsyx2+5Yqb8M1KranWXfep8uqTdKQ4=;
 b=bujh4v4ewL17ErxKbEgeSPOMlb8SwmuSbGwoP6KhVcsYFqG7q/ZEiDVBkP8SEG/Z3cDwDfKFr/V3vM4A+vpXkEOrVevRGJT1cMrGkOIMQfuqTTeb/nbgF2F8+sEmfK8DAVx1AWIr5XyOlIDRWAWOXgM8qERkVSuC60NHsgRyphD5jVpfmDxrYPWRkMYes5lnLhX7b0uHlTp3J+0+wkMU76vNWLPJRyriVbSpVM50T92BP69OaNV/vAMUnY0tAdDFHPhtAPv+mFTjezWL9SErvcpacvfQYRmoVeD7T6mu0ZBzdcf/OAGyDjcvtLuMR7VAK22FyhecqjVfMJNLUokc7w==
Received: from AM4P190CA0011.EURP190.PROD.OUTLOOK.COM (2603:10a6:200:56::21)
 by AM6PR10MB3398.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:d4::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.12; Thu, 3 Feb
 2022 11:39:59 +0000
Received: from VE1EUR01FT035.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:200:56:cafe::87) by AM4P190CA0011.outlook.office365.com
 (2603:10a6:200:56::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.12 via Frontend
 Transport; Thu, 3 Feb 2022 11:39:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 194.138.21.70)
 smtp.mailfrom=siemens.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=siemens.com;
Received-SPF: Pass (protection.outlook.com: domain of siemens.com designates
 194.138.21.70 as permitted sender) receiver=protection.outlook.com;
 client-ip=194.138.21.70; helo=hybrid.siemens.com;
Received: from hybrid.siemens.com (194.138.21.70) by
 VE1EUR01FT035.mail.protection.outlook.com (10.152.2.236) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4951.12 via Frontend Transport; Thu, 3 Feb 2022 11:39:59 +0000
Received: from DEMCHDC8A0A.ad011.siemens.net (139.25.226.106) by
 DEMCHDC9SJA.ad011.siemens.net (194.138.21.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.18; Thu, 3 Feb 2022 12:39:59 +0100
Received: from [167.87.72.47] (167.87.72.47) by DEMCHDC8A0A.ad011.siemens.net
 (139.25.226.106) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Thu, 3 Feb
 2022 12:39:58 +0100
Message-ID: <e427670b-0570-df33-c114-fd0633ac1d44@siemens.com>
Date:   Thu, 3 Feb 2022 12:39:57 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 1/2] arm64: dts: ti: k3-am65: disable optional peripherals
 by default
Content-Language: en-US
To:     Nishanth Menon <nm@ti.com>,
        Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
CC:     Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <5beef188724ef42b0c2147ca9bf6e6ca25c75dec.1641900122.git.matthias.schiffer@ew.tq-group.com>
 <20220202203217.sf2cr4orwl4usvyf@starry>
From:   Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20220202203217.sf2cr4orwl4usvyf@starry>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.87.72.47]
X-ClientProxiedBy: DEMCHDC8A0A.ad011.siemens.net (139.25.226.106) To
 DEMCHDC8A0A.ad011.siemens.net (139.25.226.106)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e170aeaf-7f16-46c1-e67f-08d9e709e8c9
X-MS-TrafficTypeDiagnostic: AM6PR10MB3398:EE_
X-Microsoft-Antispam-PRVS: <AM6PR10MB33988F9230789355322E7D4D95289@AM6PR10MB3398.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:3383;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CsuaAJo/zhqGxNKg4nDpZMiJiHJtNVdXLfhXgHnSxyTf9u8nEWrcyuiXyT+qlTjEZQuW/rW/+SmJHZzyzV+9YujiQxbXTq4SwoV355PoN/nBCJNkHaaRi1+p8rMAETxB7HGw4MlbqL4hAJsRbDrnhrtYQq92Xf62i4zdrsy3pHFdW3GTGVFmWSv6cs3lv9ZRD47m022O9XUcZ8CB9BRkVWR5VBm2fqyWCV0vydmBN2hSCxWlP0llYGieUN53iF+TirPvxKpusHqGsSsNQacGZVc1HacPz841CXoFMnthzTAoMucTw3qG/FE0n+8+GQSZj59tYwTvmG0IWOHVBWcokosXJrlD1LWwK0k8ee4qEg3zPmwiiYOP/RYsMu4gglSdl29+aE/o0bjGz+rccnEom+nSoRpPaAckmJHXteu14BBN8kpl/rUl80nCHVflMjZWY16WjDxK4af2/iu3HYthVdaPCpG3fqVX5lA3RNG7jvskuGiYxINJtL/a3wUQvzTpzMqH3WtPtKd/OzYCjAxC5H240feeb1RozNnRc5sCaJXRRZq50tmo0t43S814u9ukBnldD/tgaNw1XgtyxqxHXYIbzhHG1mV2y8KAeme9aGUGOaKP5JtE35cNGX3HDv6ez/qlqpy3fdcH+PNaVYMBp7lapPqCc0tIZ6W65m2Ez+Upg0zhWNTtd6isDLVlkbwSudOOy1nSYJFq8ERhtfSxr45ECBp0EWtCiDoEWlWOhwok4O/Pzas4F1IsgcV+DL22
X-Forefront-Antispam-Report: CIP:194.138.21.70;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:hybrid.siemens.com;PTR:hybrid.siemens.com;CAT:NONE;SFS:(13230001)(4636009)(46966006)(36840700001)(40470700004)(31696002)(110136005)(54906003)(6706004)(2616005)(40460700003)(36860700001)(86362001)(8936002)(8676002)(70206006)(70586007)(956004)(4326008)(508600001)(16576012)(82310400004)(316002)(31686004)(7596003)(47076005)(5660300002)(16526019)(186003)(36756003)(44832011)(53546011)(7636003)(2906002)(83380400001)(26005)(336012)(356005)(82960400001)(3940600001)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2022 11:39:59.5040
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e170aeaf-7f16-46c1-e67f-08d9e709e8c9
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;Ip=[194.138.21.70];Helo=[hybrid.siemens.com]
X-MS-Exchange-CrossTenant-AuthSource: VE1EUR01FT035.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR10MB3398
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02.02.22 21:32, Nishanth Menon wrote:
> On 12:25-20220111, Matthias Schiffer wrote:
>> All peripharals that require pinmuxing or other configuration to work
>> should be disabled by default. Dependent DTS are adjusted accordingly.
>>
>> The following nodes are now "disabled" according to dtx_diff and were not
>> overridden to "okay", as they define no pinctrl:
>>
>> k3-am654-base-board:
>> - mcu_i2c0
>> - mcu_spi0..2
>> - cal
>> - main_i2c3
>> - ehrpwm0..5
>> - main_uart1..2
>> - main_spi1..4
>>
>> k3-am65-iot2050*:
>> - mci_spi1..2
>> - cal
>> - ehrpwm0..5
>> - main_spi0..4
>>
>> Signed-off-by: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
> 
> 
> Jan: you ok with this series? Please ack.
> 

Just rebased the still-too-long backlog to our system fully working over 
mainline. Basically looks good, but this might be a regression of the 
patch:

[    1.810083] OF: /bus@100000/pcie@5600000: phandle pcie-mode@4070 needs 1, found 0
...
[    1.854840] OF: /bus@100000/pcie@5600000: phandle pcie-devid@210 needs 1, found 0

Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux
