Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 895E9504F2B
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Apr 2022 13:01:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237829AbiDRLES (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 07:04:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237808AbiDRLEM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 07:04:12 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2072.outbound.protection.outlook.com [40.107.220.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF4C5BF73;
        Mon, 18 Apr 2022 04:01:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WUtsW9DM8pMBpX17ZgdgIR+Q7eFk7Bht1+JoOpNDx02HcJkNh4UtlDtTbXBbx/8UkNbXs4BdTrLeRsw28P/ZzMWoOG4Ej2v0p1Q8tK+gM1iH7n+seFA1j323gJt8tc7w6u1IbXd54gkOlkl4Px+HX0I/fcAHkp7tRLZLZw9ElVLBedLRhAtSt/MkUiB4JmJQlJ4uB6y2otLviJrlaEPHncOPEOwLWM4343NACKTKblaZRKrlwBwDMruz37CTplUFOFpfkFagFKkaUzVLTj8rnBib5ngNDVNTrQOnjvTDLnsxh4gGOsfuqupNwVtaIn3qHFExEXwz7cwfh9uta2b/LQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n3vxHy3FQJbT6CXrS/PNAyUXdy5EhYWh8m4CQTPpDj8=;
 b=e/QlTxD4XJEreUQBR0/mXqlQGpddev3nid8/joZ9OzjhbUtezZHdKc/xTnsorYv/gDZhu/+QwUCJtt8l9rXmM6ooBwd4XtpFXHZtShk/tzqZ4h06pEZBEnXQAQccVVqoX+eo0G5HwbnRYsN4FMnw8SkxbMEHSV2EyGinDbEhREesUeJ7SmK4PSgKcgEVlYBxYyFuPD/xjagDpRdueDmsPVTTi7SfdNLXpyomdeit4PzqPp9Z10uA4DSszhfHjiB1D8tMGmQctR+/YNSDkn317bdNmaUpqNvv1s1xCPUmFmJQbWFzpzZ8zKbtlgc/QkNPHPTAa3Yx29OwGrbsE+qAig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.238) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n3vxHy3FQJbT6CXrS/PNAyUXdy5EhYWh8m4CQTPpDj8=;
 b=fGRnN9Mxa4Uqrl2mRkDykk4iF7/QZcTK9sJ+PeIFXmZ/B0h80q1JkPipkxYs+8iISotpRAKufK97oUWj1wMTG7uK89ngB+7rwuB8Oh2iOj/3dHDJmE95UyEKqmziVciYIRjNhaoO2Xp0aJQlxc5MGXO1xtCg3SA4XW9sTw2JFACPWUYb9CUv+a+QZ0azEQOhnq+LjC4MJN34GVfG17g9AD5aBc1jrTrztDozm1MyO3psYvkggcf7+pjpLdwTzxnwLBru0Y6ROH4t+5qj5onInSDQhKVsZUPBZIupt3dbl6CX7u/PjU3bHKM3KP36dIzHbjVHUkog9xajU05anYs98Q==
Received: from BN8PR12CA0003.namprd12.prod.outlook.com (2603:10b6:408:60::16)
 by DM5PR12MB1931.namprd12.prod.outlook.com (2603:10b6:3:109::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.20; Mon, 18 Apr
 2022 11:01:32 +0000
Received: from BN8NAM11FT004.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:60:cafe::48) by BN8PR12CA0003.outlook.office365.com
 (2603:10b6:408:60::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.18 via Frontend
 Transport; Mon, 18 Apr 2022 11:01:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.238)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.238 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.238; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.238) by
 BN8NAM11FT004.mail.protection.outlook.com (10.13.176.164) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5164.19 via Frontend Transport; Mon, 18 Apr 2022 11:01:32 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 DRHQMAIL105.nvidia.com (10.27.9.14) with Microsoft SMTP Server (TLS) id
 15.0.1497.32; Mon, 18 Apr 2022 11:01:31 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Mon, 18 Apr 2022 04:01:31 -0700
Received: from kkartik-desktop.nvidia.com (10.127.8.13) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.986.22 via Frontend
 Transport; Mon, 18 Apr 2022 04:01:28 -0700
From:   Kartik <kkartik@nvidia.com>
To:     <robh@kernel.org>
CC:     <devicetree@vger.kernel.org>, <jassisinghbrar@gmail.com>,
        <jonathanh@nvidia.com>, <kkartik@nvidia.com>, <krzk+dt@kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <thierry.reding@gmail.com>
Subject: Re: [PATCH 2/3] dt-bindings: tegra186-hsp: add type for shared mailboxes
Date:   Mon, 18 Apr 2022 16:31:12 +0530
Message-ID: <1650279672-11757-1-git-send-email-kkartik@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <YlgnXKGHqcCgItlb@robh.at.kernel.org>
References: <YlgnXKGHqcCgItlb@robh.at.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 510521a6-49d0-40ea-6760-08da212acc2d
X-MS-TrafficTypeDiagnostic: DM5PR12MB1931:EE_
X-Microsoft-Antispam-PRVS: <DM5PR12MB19311C9FFD1B7F03F066AA33CDF39@DM5PR12MB1931.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NlbwC2FCb3t63gY1LArqkIaKUKYAQx4IJhQuR1kL8SwrmfAg294BvAp2A7MjX4G7B1arvrhSTiPoGoLhbv7zoDjBgw/hLWPo0D+HvlGCnJBJu6+Uf9pw5TLtHzPc43ktbxoi2F427FaF8DKHFor98i61x0fkE37MfmFvUykB4RzE7UUjDlPUZAdcQlLhTqWnWjk2B0nVkTNz9+gOOoSy/vFLNq3+T7M4/TOIuwNcd4yxGJrZ2RQinJCujW4xTQB3hP8porgiIVrRgnrkLxSyVU6RL3iWgUdILRwh/yFe4jpDd1tWG6Doi8uNyZbza9Mq36ADjVDnxMijKMmK3dzFPyASszohhJhyBw5P8OoHQPMTNqjuUyD8Ne921sJ82oiIV0UYWNQtfWfxH1yE9xrWC3wbB2QO+WcHpM4BkA2yIPwdxkyvAO+Du3z7/FLopLz378+vKuCGvWx7HkhVSHYYsWISShUg6DPItQLyi6BSmmHkHKGCTYW771vVqzvwYdQ+NZavCMwbg+LA5WcLSykw1vz96gT+z5EzyzfuZ3kYOlVvbImnm7mC0T7iegULduPzJQnJJ3bzJUxlwMcmCZYYKM72vPl3bkSeG+PKpTBvx0ElCVBA4og/FFvDVoNL5M0SXInjAWYjHD7uiRd2Ok6sKoeqUEbyvVT+sEuVCtJc6lS11G9AffLdnnxODNKjsr4DP5QscLaEzLAFM2QF7SZvvg==
X-Forefront-Antispam-Report: CIP:12.22.5.238;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(40470700004)(46966006)(53546011)(426003)(336012)(186003)(5660300002)(70586007)(508600001)(70206006)(47076005)(36756003)(54906003)(4326008)(15650500001)(8936002)(7696005)(6666004)(6916009)(8676002)(36860700001)(26005)(2906002)(83380400001)(316002)(86362001)(356005)(82310400005)(81166007)(40460700003)(2616005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Apr 2022 11:01:32.2498
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 510521a6-49d0-40ea-6760-08da212acc2d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.238];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT004.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1931
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/04/2022 13:53, Rob Herring wrote:
>> Tegra234 supports sending/receiving 32-bit and 128-bit data over
>> a shared mailbox. Based on the data size to be used, clients need
>> to specify the type of shared mailbox in the device tree.
>> 
>> Add a macro for 128-bit shared mailbox. Mailbox clients can use this
>> macro as a flag in device tree to enable 128-bit data support for a
>> shared mailbox.
>> 
>> Signed-off-by: Kartik <kkartik@nvidia.com>
>
>Need a full name here.

This is my legal name as per the government ID's.

>
>> ---
>>  .../devicetree/bindings/mailbox/nvidia,tegra186-hsp.yaml | 9 +++++++++
>>  include/dt-bindings/mailbox/tegra186-hsp.h               | 5 +++++
>>  2 files changed, 14 insertions(+)
>> 
>> diff --git a/Documentation/devicetree/bindings/mailbox/nvidia,tegra186-hsp.yaml b/Documentation/devicetree/bindings/mailbox/nvidia,tegra186-hsp.yaml
>> index 9f7a7296b57f..a3e87516d637 100644
>> --- a/Documentation/devicetree/bindings/mailbox/nvidia,tegra186-hsp.yaml
>> +++ b/Documentation/devicetree/bindings/mailbox/nvidia,tegra186-hsp.yaml
>> @@ -26,6 +26,15 @@ description: |
>>    second cell is used to identify the mailbox that the client is going
>>    to use.
>>  
>> +  For shared mailboxes, the first cell composed of two fields:
>> +    - bits 15..8:
>> +        A bit mask of flags that further specifies the type of shared
>> +        mailbox to be used (based on the data size). If no flag is
>> +        specified then, 32-bit shared mailbox is used.
>> +    - bits 7..0:
>> +        Defines the type of the mailbox to be used. This field should be
>> +        TEGRA_HSP_MBOX_TYPE_SM for shared mailboxes.
>> +
>>    For doorbells, the second cell specifies the index of the doorbell to
>>    use.
>>  
>> diff --git a/include/dt-bindings/mailbox/tegra186-hsp.h b/include/dt-bindings/mailbox/tegra186-hsp.h
>> index 3bdec7a84d35..b9ccae2aa9e2 100644
>> --- a/include/dt-bindings/mailbox/tegra186-hsp.h
>> +++ b/include/dt-bindings/mailbox/tegra186-hsp.h
>> @@ -15,6 +15,11 @@
>>  #define TEGRA_HSP_MBOX_TYPE_SS 0x2
>>  #define TEGRA_HSP_MBOX_TYPE_AS 0x3
>>  
>> +/*
>> + * These define the types of shared mailbox supported based on data size.
>> + */
>> +#define TEGRA_HSP_MBOX_TYPE_SM_128BIT (1 << 8)
>> +
>>  /*
>>   * These defines represent the bit associated with the given master ID in the
>>   * doorbell registers.
>> -- 
>> 2.17.1
>> 
>> 
