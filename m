Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5392B514840
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 13:34:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358507AbiD2LiD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 07:38:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358492AbiD2LiC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 07:38:02 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2084.outbound.protection.outlook.com [40.107.243.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9A3056C2D
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 04:34:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Bz+I43X87H/gNSxjxEtIghFIhk1hkK67oCvd5N1zr9mgQuMIY0J8XvqbQcMGvv7Cx8B0tSIdIC9HFogNGqzBj69Pdi/cwkEWDFrJ6pkulowYKicfr2nAUZ+OKMjhv+T9U1rP60wFLWfZBrjyHcoWAayVTm5Gv2oIwuWpTVfJTGL4xYJSAxhAa1o9pCG3Ymc+jZTJQ7HhGlyMIFH2uH5DdAs+gwhGAzbLEFRnmyRRPOuH1W9gNgHyBUJVBduPcqKAPYPoDpDx+4wxWUsWFfXqVUj0orkOPiuliLvgryFUnmLLU/UdTYO6OAt8JG+l3/LKSlLbstP7V8oCm8bWPjqb+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a6IGux4P5Fa0CQnEfWmljPFeyRY/9+V7R77H36UR5zE=;
 b=ofEXb80ZQwAmRr779OnyDbfTWx3O5VpvfM74DnL1zkxf5mB4hEeEq1yarb24qgrW0IFvu0jV2DVLMQwK2wFAg7m+tnJxWG1xpEc8wo0qsRxMXrxMdWNq18hFdEQeDEssqJKWpdu4hQ7Wqmdr1VzmSWvQUwE3lvBz9fikMSp2TMv4SPD/TWX8PP/tJWRMHsJg5hCqMz/w0t94bQBjscr4l7lqeYlAmMswvYBLim6lc5UHvT1sSQDzDc1oXh7yJQtn4b6yAHi+sJv40ipq2VIljFHLIe0iEAL5GxYrlpGCHfH97nkVC5evsS2JwmsAMiDuwaYEiJjpXzg1DnK89jm7gg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a6IGux4P5Fa0CQnEfWmljPFeyRY/9+V7R77H36UR5zE=;
 b=EruSZGYwu1R9Kp5OP7O4b+KzQbQ8LZJx/jl3kAiPSK6qga/ByzbmsO5gwQokWLmOL1r9ULfUlZb+6yNIvaGp/5SXmiv2jHjCR0aHpw8tZ/8odxwr1bzXvRgGNRjtyI/sD6JliwrpHI8gKEcCHy0v9g/p9cLKcKASaDlH9DnpOCo=
Received: from DS7PR03CA0057.namprd03.prod.outlook.com (2603:10b6:5:3b5::32)
 by SN4PR0201MB3582.namprd02.prod.outlook.com (2603:10b6:803:47::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.20; Fri, 29 Apr
 2022 11:34:41 +0000
Received: from DM3NAM02FT037.eop-nam02.prod.protection.outlook.com
 (2603:10b6:5:3b5:cafe::c7) by DS7PR03CA0057.outlook.office365.com
 (2603:10b6:5:3b5::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.14 via Frontend
 Transport; Fri, 29 Apr 2022 11:34:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch02.xlnx.xilinx.com;
Received: from xsj-pvapexch02.xlnx.xilinx.com (149.199.62.198) by
 DM3NAM02FT037.mail.protection.outlook.com (10.13.4.166) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5206.12 via Frontend Transport; Fri, 29 Apr 2022 11:34:41 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Fri, 29 Apr 2022 04:34:36 -0700
Received: from smtp.xilinx.com (172.19.127.96) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Fri, 29 Apr 2022 04:34:36 -0700
Envelope-to: linux-kernel@vger.kernel.org,
 gregkh@linuxfoundation.org,
 corbet@lwn.net,
 linux-arm-kernel@lists.infradead.org,
 arnd@arndb.de
Received: from [10.254.241.50] (port=51646)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <michal.simek@xilinx.com>)
        id 1nkOtQ-0002kI-1S; Fri, 29 Apr 2022 04:34:36 -0700
Message-ID: <bdf10e9f-37e3-ee1d-481b-9285fa133a9e@xilinx.com>
Date:   Fri, 29 Apr 2022 13:34:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH] firmware: xilinx: add support for sd/usb/gem config
Content-Language: en-US
To:     Ronak Jain <ronak.jain@xilinx.com>, <michal.simek@xilinx.com>,
        <linux-kernel@vger.kernel.org>
CC:     <gregkh@linuxfoundation.org>, <corbet@lwn.net>,
        <linux-arm-kernel@lists.infradead.org>, <arnd@arndb.de>,
        <lakshmi.sai.krishna.potthuri@xilinx.com>, <radheys@xilinx.com>,
        <agodhasa@xilinx.com>
References: <1651227402-17658-1-git-send-email-ronak.jain@xilinx.com>
From:   Michal Simek <michal.simek@xilinx.com>
In-Reply-To: <1651227402-17658-1-git-send-email-ronak.jain@xilinx.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fa06f7b3-3cb9-4a6b-bffd-08da29d44029
X-MS-TrafficTypeDiagnostic: SN4PR0201MB3582:EE_
X-Microsoft-Antispam-PRVS: <SN4PR0201MB358255E376132EC0EE7F3EFFC6FC9@SN4PR0201MB3582.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: A5T8ntMeO9m7YLTLUB/RqEKBM+D+qqGXBMNG/aOe6swu7f2cX9S9MZIcjpssvZqyHhd+lI854HAER1/IP/NCQOM+PM3V/VkJaoU3DoeYRKcoxFlkXK9PcMk0w4EzNkfxqS/7xYA/OY3ZAASGkeAxEB89oN2KCsOyiLgWhdUki+TB96eJt0PgU+jSC3jLFsfKHeIZFywBVuulXbxdCHI6yxMZINBYBm/3XF4crLuWjsXU54Ej8zm/EM5TiVz1FRB7tQspLe7ANFx/mGkg591Pmdudi2KDum9yGuGBAKG1yD3vsPMh9WU7wrvbS76qe4tetJXV+dFh9N8F8DB2l73F1j5jxYf7KDgVgrL3IHZlbdtyoQgHjgon+EAFV1RYtL3u/ET7W6dnbhIri+bNn0Jf6+EC3T8r8SFSwUFvrn+Iw3eBrdsTLubD6xvMcpA+XkE6fBiG6GbM4AsX90b/SDlpY0IcAX5XjI+OSm6N7MPvH82BsaxkSpQXK6a+s9k59DamUhykODnz7VVw4cMBwyXBy8ZRgEMK4/kvgSnQn3EgBxJhJxb50+A0h0SRmeif95VRes6uVIGisDPPM5ACtG1myKT+h11ZmE9/SuxJRrNhTCS0+zr+C2f6Qh1/EHuJZmfYcZfaelVapMLZj9wcqL0dPhHNKg5jJVjhcLnVMroT7DM9X/409N2S5fwPaD7OdG2SKA6ed3BRET1gUjzUNbCOUEkOSoTYE16kDLl/pHdlCBQ=
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch02.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(13230001)(4636009)(46966006)(40470700004)(36840700001)(336012)(186003)(82310400005)(47076005)(356005)(44832011)(7636003)(426003)(316002)(107886003)(5660300002)(6666004)(8936002)(53546011)(2616005)(26005)(9786002)(31696002)(70586007)(70206006)(4744005)(4326008)(8676002)(36860700001)(508600001)(31686004)(2906002)(110136005)(36756003)(54906003)(83380400001)(40460700003)(50156003)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2022 11:34:41.1380
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fa06f7b3-3cb9-4a6b-bffd-08da29d44029
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch02.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: DM3NAM02FT037.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR0201MB3582
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/29/22 12:16, Ronak Jain wrote:
> Add new APIs in firmware to configure SD/GEM/USB registers. Internally
> it calls PM IOCTL for below SD/GEM/USB register configuration:
> - SD/EMMC select
> - SD slot type
> - SD base clock
> - SD 8 bit support
> - GEM SGMII Mode
> - SD fixed config
> - GEM fixed config
> - USB fixed config
> 
> Signed-off-by: Ronak Jain <ronak.jain@xilinx.com>

I think it was said that you shouldn't send interface changes without any user.
It means every function you add should be also used.

Thanks,
Michal
