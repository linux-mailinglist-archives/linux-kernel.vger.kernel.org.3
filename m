Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6DAC14675F2
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Dec 2021 12:12:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380281AbhLCLPW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Dec 2021 06:15:22 -0500
Received: from mail-dm3nam07on2049.outbound.protection.outlook.com ([40.107.95.49]:49121
        "EHLO NAM02-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S242868AbhLCLPV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Dec 2021 06:15:21 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ew/WlwANzj5X4swj5TGTNXRB1RSWF30D6zwd51ihF6ueraRPE81Nin/El8hk8Sf70YfY+aLhAyn/LlitKuHwpdhXWZBjczoOl2vw++m4MKjF4munQt3etMOy+IF/xrBryX+YsZ9xJAS4vIVkyNXoQfLrTzsczFHV3caIsRlXPoAWYYl0LHQCjcpwpGaCUqy/iNRofLJX17oWM8IAgyv+d+wnR06oApzdnmGDOwC6xCXYb+yEsY3UJIb8dOJoctPBbYDA4+iuIctuOXBYvOzYKF1MiyaFATCMIehIbPhd1DlLZMLpwEH5vZLRbaoxV8y5vDak+lYXzNALgYyYRCcCaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+N0L6seX7q1xd+NQCUjjsbBSpGPdHxN2M2YNz+UkiuQ=;
 b=EYhmDvwJ+6QRI0j8+HVlbw6cNxnRj5YRs+tYUmvogfA5gzsyLwYK+WvMV+Xmd7DGMSl9bJ2S5FV6lS1SksVpM4hEiXsRULbdJfqDBJbdNkq02ohTuwfTBHMBSduzhH6EpAPZGOXcC1gN1XXamf5p6kIc0jPdey4382Nr1cqoNfv6W70Ew1cH7Lxd5eRKs78tR9ZQ8oIXUTMTvSu4nv2cN7Pd3jXqOwgoffxbB9+XG9M8fm9h64bzLfscxSoKHBieOFICKKB3Nsgb5IoQ350d3POjYMFovPzutb5tHfBsS3zN1nCeZeMAc2j+SIPdx+CPxbwYEecqYGgC+XRX3vuV6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.80.198) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+N0L6seX7q1xd+NQCUjjsbBSpGPdHxN2M2YNz+UkiuQ=;
 b=a191ZZZB8EDsp6JJrOX2VrKUZcuHxS2hE5VFyTh5vyw5mN4sRBDO0pT9ieR+YTSsodP5foCHDBP5IF22NhhjfqhcJsOi1j1+FWXkk9TFRh/Nsr7+zifh9L0XqJXAxzdHj4SybV0bNnJLeYdOv9gDw3gk/QZIOypJWjfT6O7eMkk=
Received: from DM6PR02CA0052.namprd02.prod.outlook.com (2603:10b6:5:177::29)
 by CH2PR02MB6200.namprd02.prod.outlook.com (2603:10b6:610:8::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.23; Fri, 3 Dec
 2021 11:11:56 +0000
Received: from DM3NAM02FT046.eop-nam02.prod.protection.outlook.com
 (2603:10b6:5:177:cafe::e1) by DM6PR02CA0052.outlook.office365.com
 (2603:10b6:5:177::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.23 via Frontend
 Transport; Fri, 3 Dec 2021 11:11:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.80.198)
 smtp.mailfrom=xilinx.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.80.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.80.198; helo=xir-pvapexch02.xlnx.xilinx.com;
Received: from xir-pvapexch02.xlnx.xilinx.com (149.199.80.198) by
 DM3NAM02FT046.mail.protection.outlook.com (10.13.4.67) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4755.13 via Frontend Transport; Fri, 3 Dec 2021 11:11:55 +0000
Received: from xir-pvapexch02.xlnx.xilinx.com (172.21.17.17) by
 xir-pvapexch02.xlnx.xilinx.com (172.21.17.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Fri, 3 Dec 2021 11:11:54 +0000
Received: from smtp.xilinx.com (172.21.105.197) by
 xir-pvapexch02.xlnx.xilinx.com (172.21.17.17) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Fri, 3 Dec 2021 11:11:54 +0000
Envelope-to: stefano.stabellini@xilinx.com,
 linux-ide@vger.kernel.org,
 axboe@kernel.dk,
 linux-kernel@vger.kernel.org,
 sstabellini@kernel.org
Received: from [10.71.119.136] (port=9903)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <ayan.kumar.halder@xilinx.com>)
        id 1mt6Tp-0000l1-F6; Fri, 03 Dec 2021 11:11:54 +0000
Message-ID: <df61e958-7bd6-94df-0da2-56aa1084350d@xilinx.com>
Date:   Fri, 3 Dec 2021 11:11:53 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
To:     <linux-ide@vger.kernel.org>
CC:     <axboe@kernel.dk>, <linux-kernel@vger.kernel.org>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Stefano Stabellini <stefano.stabellini@xilinx.com>
From:   Ayan Kumar Halder <ayan.kumar.halder@xilinx.com>
Subject: Need help to debug ata errors
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b31281c6-dd3e-4849-6e35-08d9b64db797
X-MS-TrafficTypeDiagnostic: CH2PR02MB6200:
X-Microsoft-Antispam-PRVS: <CH2PR02MB6200D868DAFE996021DAFF4AB26A9@CH2PR02MB6200.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rTCkWY8uKrBWbIXZM84jdeSgLcgeeE6BhlFFLc+kDnh0OBO4fw6TmeoLzbeHTEFNiQTIdCd+n/UnnBYbYKyBLbfR18kCpqsX5Z2Eh7mFxuOCaS+Yjx2arwHWlRKOANaTeRCOtvQvDWvPMkOqrjpenxJdMnEDdxt9YXl/YupeqWgkZ51Pj6PrKuhlPYhjtRQTGEPHBXpwsMuhJ3c18dDKMOr9bM3qABSQagviwcQGvc1+5RzuwpdwhXeybcvjgUb+e7M/i2iezTG8Vun5AoXD0vuFhhz8q0cs8KUnl13MZfcNwReABt+IW4vGMyMn4KNBe9FdB4CpTlcsGR515qqIrYuexEWRmbDdE7XwBc0BOkYFLbiCBChccTX297pUhHn3xsTWL1ESISy8lBmcHRSLUzaAc1/ZX7jZ9vOfnwZqH/yjT/CetvQGMLrmFtbFbNVku9CuTm9hp83LnF9dxccBPBpZjCRA6yzFegdEd2MhsWMJFqVBpZ8HCgD+zWxkis3lzuwESnygdtr4WuB0wZVpxtX026z7ibpsI8k0V60c6TL4H18BIXWDX62HHQBukOP1RUhmSPfDYQY9QIfvAo2LaEtbGkwtkkCipTRkqWCtsCtLL53leKAAG98jswIeitt7mJYzqD/jNsSAV3ytydq0qAo/vmKNBAmnmqnOtU5FAR1J3aLEwJvYILwAWtZiSDAQB3B6omDDJ3Ui7L7HbrFxISsO/ABygG0FWkd8snwYGBtUxoxy+DVmntBJztb+MRenGAf2U73GNAzBsKNfIqHVpaoAuf4mCPtTUche3niXebKtFvnY79iOGzscY8niYGzNXwEuEXT5/coXtclwz7eQReBsa/AeG5OhD7W8J+waN6HrGNkdrbZ3H0fElPayu8QpA7XMHQJiIJtVmrA7UXom24zw+Ugw9IujeWdW396c79g=
X-Forefront-Antispam-Report: CIP:149.199.80.198;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:xir-pvapexch02.xlnx.xilinx.com;PTR:unknown-80-198.xilinx.com;CAT:NONE;SFS:(36840700001)(46966006)(316002)(31696002)(2906002)(4326008)(54906003)(356005)(70206006)(36756003)(6916009)(107886003)(7636003)(5660300002)(2616005)(83380400001)(9786002)(47076005)(70586007)(4744005)(186003)(31686004)(26005)(426003)(82310400004)(8676002)(966005)(336012)(8936002)(508600001)(36860700001)(10126625002)(50156003)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Dec 2021 11:11:55.6340
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b31281c6-dd3e-4849-6e35-08d9b64db797
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.80.198];Helo=[xir-pvapexch02.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: DM3NAM02FT046.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR02MB6200
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

I am trying to run linux as a DomU guest on Xen with AHCI assigned to it.
I can confirm that SATA works (ie able to detect sdb) as a Dom0 guest. 
However, it does not work as a DomU guest.

Hardware :- ZCU102 board and it has two sata ports
Kernel :- 5.10

I have enabled the debug logs in drivers/ata

1. Logs from dom0 (where SATA works) https://pastebin.com/2BhMDq47
2. Logs from domU (where SATA does not work) https://pastebin.com/fE8WZnZ0

Can some help me to answer these questions
1. What does this mean "1st FIS failed" ?

2. In the dom0 logs, PORT_SCR_ERR = 0x41d0002 whereas in domU logs, 
PORT_SCR_ERR = 0. Does it give some hints ?

3. Any other issues or hints to debug this ?

I can confirm that in domU scenario, we do not get any interrupts from 
the device. What might be going wrong here ?

Thanks in advance.

Kind regards,
Ayan
