Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8EAC4A8A02
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Feb 2022 18:28:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352840AbiBCR2T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Feb 2022 12:28:19 -0500
Received: from mail-eopbgr60078.outbound.protection.outlook.com ([40.107.6.78]:46992
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S238751AbiBCR2Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Feb 2022 12:28:16 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HRZj6mhy2YexG6aaO6XdB9MpY0nrI4rNUIBMR0JkHlgqpw+u73s8AiR15/190uzE5T8TW2IIYE/93xRT00o0BJGZlsaWn/xvPEhyZWpbeTAEMCxyECFBv/eYrVXSxBMfg7R+Ck8TJH1f+SFGFzWFq9vJdebPQRK+KqJc+vs/0A2Kqll4Ee8giKfNmiDJ6az/a4QdKHVl8JTWzryGC6y5LLkjgTUnotM5doPl0dHYOtAGwH7Fm0XOIMIjc4xLGc0UWlJMMc1BdqzXQ7HAjI2I7hq8DOqRK3tTgRMFB489Grut40ArQzIOfeCJ/SRckxO9UXtGKyfj8KVex82PpaKsrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Hk1V7SziqmPF1A71FHrrOkpjJ0MYbIEt7n69gtx/qnA=;
 b=jZZKrAnS5g1jsF55g+ovS1yUSEutoWYEbgu05tWw/NeIBezbQUMN/22P+wFh4PdyF1x4xpb2I7FA9TVR9RkHTOHMyMWn9mjxSbwqyvhQcDcvda5TDI/QCQ9e/sNdpPJyP6zAPEOxHT32GllVkXbKjHEwEz3SkbhzcK7LbKKYDdHr8d9+EEfULTZL8GOxvJoLWiUWTC6x+mq1OtvUsZ+Nws6DGugfE7esB0sEgfniVq9cnxpNM7FB8yqfU1n5Xd2EbazcjGsMXDingUQy3kh+R2eaBIIAK9hp7TQhABhdiZnMekxjEzzSbLz3oXRqvDOuzXj2kjN/Q+MAisfQRyGCxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 194.138.21.70) smtp.rcpttodomain=ew.tq-group.com smtp.mailfrom=siemens.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=siemens.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Hk1V7SziqmPF1A71FHrrOkpjJ0MYbIEt7n69gtx/qnA=;
 b=yArajqWfr8FKK4lk8YV7BgGK1AOFv71otMQA1s7bCRWajephZCtVz7MKbXhzRtSOQy/UDOHdZsV4XMcdrzogbmUCe9m4VItoBhb4n9StR3/erfq22pz8Zi6Ymi+MA7YwL8cwvmEu4lldYonhmksaIUkwElmmTexog8Yg8GFEdhR+oeYvg3XBIW65tBxghYFvJNEpcIPXu1P3xjB59X3vQeYNUoseuFDDOH5B1ErphuMO2tGktDgZbhY0nNROabpb/23JuEuUYFKZKOTLEQOMmfrywg5eThABlHuENVEBAmCWHxI4fR2rIafxrjQXHoPdeYswKR8+LJNBcpUa8RgPGg==
Received: from DB8PR09CA0005.eurprd09.prod.outlook.com (2603:10a6:10:a0::18)
 by AS8PR10MB4805.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:337::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.12; Thu, 3 Feb
 2022 17:28:14 +0000
Received: from DB5EUR01FT030.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:10:a0:cafe::e4) by DB8PR09CA0005.outlook.office365.com
 (2603:10a6:10:a0::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.12 via Frontend
 Transport; Thu, 3 Feb 2022 17:28:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 194.138.21.70)
 smtp.mailfrom=siemens.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=siemens.com;
Received-SPF: Pass (protection.outlook.com: domain of siemens.com designates
 194.138.21.70 as permitted sender) receiver=protection.outlook.com;
 client-ip=194.138.21.70; helo=hybrid.siemens.com;
Received: from hybrid.siemens.com (194.138.21.70) by
 DB5EUR01FT030.mail.protection.outlook.com (10.152.4.254) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4951.12 via Frontend Transport; Thu, 3 Feb 2022 17:28:13 +0000
Received: from DEMCHDC8A0A.ad011.siemens.net (139.25.226.106) by
 DEMCHDC9SJA.ad011.siemens.net (194.138.21.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.18; Thu, 3 Feb 2022 18:28:12 +0100
Received: from [167.87.72.47] (167.87.72.47) by DEMCHDC8A0A.ad011.siemens.net
 (139.25.226.106) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Thu, 3 Feb
 2022 18:28:11 +0100
Message-ID: <2e375860-83d6-c5bb-3ab4-1b02e672c2e5@siemens.com>
Date:   Thu, 3 Feb 2022 18:28:10 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 1/2] arm64: dts: ti: k3-am65: disable optional peripherals
 by default
Content-Language: en-US
To:     Matthias Schiffer <matthias.schiffer@ew.tq-group.com>,
        Nishanth Menon <nm@ti.com>,
        Kishon Vijay Abraham I <kishon@ti.com>
CC:     Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <5beef188724ef42b0c2147ca9bf6e6ca25c75dec.1641900122.git.matthias.schiffer@ew.tq-group.com>
 <20220202203217.sf2cr4orwl4usvyf@starry>
 <e427670b-0570-df33-c114-fd0633ac1d44@siemens.com>
 <76703db31c4562dba1301e839c70381cf8e403b3.camel@ew.tq-group.com>
From:   Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <76703db31c4562dba1301e839c70381cf8e403b3.camel@ew.tq-group.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.87.72.47]
X-ClientProxiedBy: DEMCHDC8A0A.ad011.siemens.net (139.25.226.106) To
 DEMCHDC8A0A.ad011.siemens.net (139.25.226.106)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ab1f7684-e9f3-448a-f675-08d9e73a8e88
X-MS-TrafficTypeDiagnostic: AS8PR10MB4805:EE_
X-Microsoft-Antispam-PRVS: <AS8PR10MB48050036B2F017EDF68007D495289@AS8PR10MB4805.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yYW2ke4C9kQtLbIKkkjG69Ea6pm1j2BaSqOscAJ+sxXg8TM31Oa4aRbXfLIPEfesoVIJ6oq5YjnyWh6M/GdG/TwHYCZL7WY0oQE2ES03RkUSxEtMNYLVaVAMLjyHZpCPyZnXXgYhMXYM6Nmor2cF6mbnqODHY/E+Cgs3uSgCw3xjyED+NOYRbnU92SIncrvnidlMdI4pYHadvL75FzYuwlwma/S0LElMql0AIB8w4VaOmZfvUO/RoHq8MX4yuKSsWNmGL//AsGOBNkObagK2ZD8sa0jjL1+5uNyuhZpSXYFAQ7xerSqjcNzEG/Y9zA8eEAzqbeHvrVi0O9CwJS5L7jeBlUXjdx/koTNqBLsXma4EYPPNOX/6i1YILBrYScAxsod0pZB7JPGHWaDzBO3C3YP17g+W3EVFVX5SR9/ZhDYVXsu7tVQ9aRaiLZ61sdsMytH4cLpjLfmXGY5RKmqmVOteJOEpsQu3k/IueZR6Bz16q8i774rLAe7nRf8M2GozpwJ0/R5/JjfDtTesMikFLA5/fSZqXfm463zEFcvlVyy4Sb1WKM6s0nUeEjt9U6n/EWiV7W8MdUeuFCM79eLh9KBAApAxwVTwX6mmI7ir4/MPDAhTUio0U0wEoWNk8gA5GGg+/q7J+MtWvRE47DOLfcoZXzvvNsAs9EQURzdXDtAcSKLF9SLDKNaGcOkxd1bGyC3QjquZVIrVLAULs7pu4vTqjhWli5c8QhAB499KRfR8to2RsSM3T4lsBB1NKrPu
X-Forefront-Antispam-Report: CIP:194.138.21.70;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:hybrid.siemens.com;PTR:hybrid.siemens.com;CAT:NONE;SFS:(13230001)(4636009)(40470700004)(46966006)(36840700001)(36860700001)(31686004)(83380400001)(53546011)(2616005)(956004)(336012)(186003)(16526019)(26005)(36756003)(47076005)(2906002)(5660300002)(31696002)(8676002)(8936002)(70586007)(110136005)(86362001)(70206006)(4326008)(44832011)(82960400001)(508600001)(316002)(40460700003)(6706004)(16576012)(82310400004)(7636003)(356005)(7596003)(54906003)(3940600001)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2022 17:28:13.4470
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ab1f7684-e9f3-448a-f675-08d9e73a8e88
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;Ip=[194.138.21.70];Helo=[hybrid.siemens.com]
X-MS-Exchange-CrossTenant-AuthSource: DB5EUR01FT030.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR10MB4805
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03.02.22 14:06, Matthias Schiffer wrote:
> On Thu, 2022-02-03 at 12:39 +0100, Jan Kiszka wrote:
>> On 02.02.22 21:32, Nishanth Menon wrote:
>>> On 12:25-20220111, Matthias Schiffer wrote:
>>>> All peripharals that require pinmuxing or other configuration to
>>>> work
>>>> should be disabled by default. Dependent DTS are adjusted
>>>> accordingly.
>>>>
>>>> The following nodes are now "disabled" according to dtx_diff and
>>>> were not
>>>> overridden to "okay", as they define no pinctrl:
>>>>
>>>> k3-am654-base-board:
>>>> - mcu_i2c0
>>>> - mcu_spi0..2
>>>> - cal
>>>> - main_i2c3
>>>> - ehrpwm0..5
>>>> - main_uart1..2
>>>> - main_spi1..4
>>>>
>>>> k3-am65-iot2050*:
>>>> - mci_spi1..2
>>>> - cal
>>>> - ehrpwm0..5
>>>> - main_spi0..4
>>>>
>>>> Signed-off-by: Matthias Schiffer <
>>>> matthias.schiffer@ew.tq-group.com>
>>>
>>> Jan: you ok with this series? Please ack.
>>>
>>
>> Just rebased the still-too-long backlog to our system fully working
>> over 
>> mainline.
> 
> Thanks for testing. As noted earlier, I will send a v2 of this patch
> that fixes one more inconsistency.
> 
>> Basically looks good, but this might be a regression of the 
>> patch:
>>
>> [    1.810083] OF: /bus@100000/pcie@5600000: phandle pcie-mode@4070
>> needs 1, found 0
>> ...
>> [    1.854840] OF: /bus@100000/pcie@5600000: phandle pcie-devid@210
>> needs 1, found 0
>>
>> Jan
>>
> 
> That seems to be an older issue, rather than a regression of this
> patch:
> 
> k3-am65-main.dtsi defines:
> 
>     ti,syscon-pcie-id = <&pcie_devid>;
>     ti,syscon-pcie-mode = <&pcie0_mode>
> 
> While according the driver binding docs something like the following is
> expected:
> 
>     ti,syscon-pcie-id = <&scm_conf 0x0210>;
>     ti,syscon-pcie-mode = <&scm_conf 0x4060>;
> 
> I assume that the k3-am65-main.dtsi section was imported from ti-linux
> without accounting for the mainline driver's different binding.
> 

Yep, 7dcf07ac88676a365ce3245b44af2be432f21120 caused it, and this seems 
to be the fix (though I cannot find a negative impact yet, except for 
the warning):

diff --git a/arch/arm64/boot/dts/ti/k3-am65-main.dtsi b/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
index 09cfdc72c64b..be79c0bc1776 100644
--- a/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
@@ -694,8 +694,8 @@ pcie0_rc: pcie@5500000 {
 		#size-cells = <2>;
 		ranges = <0x81000000 0 0          0x0 0x10020000 0 0x00010000>,
 			 <0x82000000 0 0x10030000 0x0 0x10030000 0 0x07FD0000>;
-		ti,syscon-pcie-id = <&pcie_devid>;
-		ti,syscon-pcie-mode = <&pcie0_mode>;
+		ti,syscon-pcie-id = <&scm_conf 0x0210>;
+		ti,syscon-pcie-mode = <&scm_conf 0x4060>;
 		bus-range = <0x0 0xff>;
 		num-viewport = <16>;
 		max-link-speed = <2>;
@@ -723,7 +723,7 @@ pcie0_ep: pcie-ep@5500000 {
 		reg =  <0x0 0x5500000 0x0 0x1000>, <0x0 0x5501000 0x0 0x1000>, <0x0 0x10000000 0x0 0x8000000>, <0x0 0x5506000 0x0 0x1000>;
 		reg-names = "app", "dbics", "addr_space", "atu";
 		power-domains = <&k3_pds 120 TI_SCI_PD_EXCLUSIVE>;
-		ti,syscon-pcie-mode = <&pcie0_mode>;
+		ti,syscon-pcie-mode = <&scm_conf 0x4060>;
 		num-ib-windows = <16>;
 		num-ob-windows = <16>;
 		max-link-speed = <2>;
@@ -740,8 +740,8 @@ pcie1_rc: pcie@5600000 {
 		#size-cells = <2>;
 		ranges = <0x81000000 0 0          0x0   0x18020000 0 0x00010000>,
 			 <0x82000000 0 0x18030000 0x0   0x18030000 0 0x07FD0000>;
-		ti,syscon-pcie-id = <&pcie_devid>;
-		ti,syscon-pcie-mode = <&pcie1_mode>;
+		ti,syscon-pcie-id = <&scm_conf 0x0210>;
+		ti,syscon-pcie-mode = <&scm_conf 0x4070>;
 		bus-range = <0x0 0xff>;
 		num-viewport = <16>;
 		max-link-speed = <2>;
@@ -769,7 +769,7 @@ pcie1_ep: pcie-ep@5600000 {
 		reg =  <0x0 0x5600000 0x0 0x1000>, <0x0 0x5601000 0x0 0x1000>, <0x0 0x18000000 0x0 0x4000000>, <0x0 0x5606000 0x0 0x1000>;
 		reg-names = "app", "dbics", "addr_space", "atu";
 		power-domains = <&k3_pds 121 TI_SCI_PD_EXCLUSIVE>;
-		ti,syscon-pcie-mode = <&pcie1_mode>;
+		ti,syscon-pcie-mode = <&scm_conf 0x4070>;
 		num-ib-windows = <16>;
 		num-ob-windows = <16>;
 		max-link-speed = <2>;

Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux
