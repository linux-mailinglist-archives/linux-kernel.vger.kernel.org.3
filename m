Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24AC9462E20
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 09:01:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239338AbhK3IEq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 03:04:46 -0500
Received: from mail-dm6nam11on2048.outbound.protection.outlook.com ([40.107.223.48]:28079
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S234202AbhK3IEp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 03:04:45 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ay8s27AEc9Az4EnY5xBu087lH1Fxm+zLLpMZOqeBlEuD+jU5EgZ4iHE5O2OpcglVhfvUNF54knwAOvH5Z98SVSsKWrIL68NwbRQZ23xQgInz6caGKfdCbp8uEiZ3JPrOlqQuMWqqSvwCVZ99X6GsQRTxjM4v61Ef5oAX1utFLld9UpkUIqt+1YxDcJ5YQigVAlzXW4C1dqNUTr5/hP4Qbs4c9D3LKnSXdybLA4Yhv2YvFrqhAjAir6IhXRSF+sFf3RxbhkRGoLwippdzA6gcobx1N6UZbS4xW5oNxv6LoOz4Kx8bd2/BmW3OkIWcSSVOvKT2AIyErKOKFsaU8PoilA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M4yDGRsjoB/n+KPgHhE8CmMLKsc4XoI/38UrH5ZrTEo=;
 b=FbmFhWPXlMoyiBIO1UPDGpctSADm1+pcwALdQHwLjzXj0QStONNgTn87IxoIgvbrBoS6C46v32yvXhtdUxxQIpK0jjfJztI2MybtRC2d5O3TqPTrmkr9KdG44pLxN1HaLU8+F8Or3WOMmkFi3k2vv3xATMCXbJ6vuVHkg10V3NEevYT8nucxI2sxPMsRupDznlpTarDsCGXyDsWhetuyMR3qowYomStz4ShjiRKbTFqvqKxVBo3Foa1YUHkKbKsjCLyu3bZvGBOknsgOhxOr+DCEkOsFrWKSexXAHGQtNUIqxlSqWS9PjxFN+aKSuqflJ1kV3oVDikPz0kd0iUBZJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.80.198) smtp.rcpttodomain=linaro.org smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M4yDGRsjoB/n+KPgHhE8CmMLKsc4XoI/38UrH5ZrTEo=;
 b=L4d8QJcsIRfxrbaj3TYaYovVZZ+IXQ4X/6K64oeW2ERgc0GXxB19Jqhxspx//eYmcaGUJo3R5xQHxs4BcFzdK09rvo03qR0pFrMeEnXU4tqLA+bWyJl/AGWdCrRpq7bcD1q7PpWdRWiR8hAocpQF+4CyeyWQvKzpT7XM6DrE7nc=
Received: from DM6PR13CA0012.namprd13.prod.outlook.com (2603:10b6:5:bc::25) by
 MWHPR02MB2688.namprd02.prod.outlook.com (2603:10b6:300:107::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.23; Tue, 30 Nov
 2021 08:01:25 +0000
Received: from DM3NAM02FT021.eop-nam02.prod.protection.outlook.com
 (2603:10b6:5:bc:cafe::53) by DM6PR13CA0012.outlook.office365.com
 (2603:10b6:5:bc::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.11 via Frontend
 Transport; Tue, 30 Nov 2021 08:01:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.80.198)
 smtp.mailfrom=xilinx.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.80.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.80.198; helo=xir-pvapexch01.xlnx.xilinx.com;
Received: from xir-pvapexch01.xlnx.xilinx.com (149.199.80.198) by
 DM3NAM02FT021.mail.protection.outlook.com (10.13.4.249) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4734.20 via Frontend Transport; Tue, 30 Nov 2021 08:01:24 +0000
Received: from xir-pvapexch01.xlnx.xilinx.com (172.21.17.15) by
 xir-pvapexch01.xlnx.xilinx.com (172.21.17.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Tue, 30 Nov 2021 08:01:23 +0000
Received: from smtp.xilinx.com (172.21.105.198) by
 xir-pvapexch01.xlnx.xilinx.com (172.21.17.15) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Tue, 30 Nov 2021 08:01:23 +0000
Envelope-to: michal.simek@xilinx.com,
 ben.levinsky@xilinx.com,
 sergei.korneichuk@xilinx.com,
 mathieu.poirier@linaro.org,
 bjorn.andersson@linaro.org,
 robh+dt@kernel.org,
 laurent.pinchart@ideasonboard.com,
 bill.mills@linaro.org,
 linux-remoteproc@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Received: from [10.71.116.9] (port=59148)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <tanmay.shah@xilinx.com>)
        id 1mry4n-0005Tc-EF; Tue, 30 Nov 2021 08:01:22 +0000
Message-ID: <e934c9b1-aadc-530e-1b62-401404dcdf55@xilinx.com>
Date:   Tue, 30 Nov 2021 13:31:17 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.3.2
Subject: Re: [PATCH v2 2/6] arm64: dts: xilinx: zynqmp: Add RPU subsystem
 device node
Content-Language: en-US
To:     Mathieu Poirier <mathieu.poirier@linaro.org>
CC:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Michal Simek <michal.simek@xilinx.com>,
        "Laurent Pinchart" <laurent.pinchart@ideasonboard.com>,
        Ben Levinsky <ben.levinsky@xilinx.com>,
        Bill Mills <bill.mills@linaro.org>,
        "Sergei Korneichuk" <sergei.korneichuk@xilinx.com>,
        <linux-remoteproc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
References: <20211123062050.1442712-1-tanmay.shah@xilinx.com>
 <20211123062050.1442712-3-tanmay.shah@xilinx.com>
 <20211129175803.GB676889@p14s>
From:   Tanmay Shah <tanmay.shah@xilinx.com>
In-Reply-To: <20211129175803.GB676889@p14s>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7990087a-ff20-4e77-3332-08d9b3d79aee
X-MS-TrafficTypeDiagnostic: MWHPR02MB2688:
X-Microsoft-Antispam-PRVS: <MWHPR02MB268873B9600E6086E58648F9CA679@MWHPR02MB2688.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: A/xhYfPEFJVNXAEITNXu2uWLbeasDQGcNLa8N5SYZTByk+HnIScvpQsn8f57p9yQeNp7lFbMOqOJ2lgaraT6K6YM2O8YsjufjPiHWkki69WXif3rUD6tecd1alu8tCRCb4DGw1X3hW8VXBkQBKZ8tdgaSaleGrfZtjU021wulk5E8gTLo4QrzMjANO0hmZJanzGkp7W/CzFOh52xA7cQCEiii2Wp9Y19130OSBAV83AXkdqxJPHYOQpivjMbvNZuJKgJcsoDfjcAbpQiKUEgGqrqjla4Px+7AKd3JY+aU92Hp1ftgsdNdo6JCIhXYK4KAvq/aLhz0AYN+0vi980GeWd2tAsGfYORCI4tAqE2y8ZBJDvYC4PJMTEPZv1X4bltPy/A44N0z2jCKBTlXH8fkhaQVIttAi8h+Z66B75NFEID1WKYa6AlPC1cLNq2bgBI/+RWgw0Bt2DXkjL/Hu9NJLPTrtuoQkMhER133sAqI1GOlFe6aU7e6OZUDVkomRpS7eHS60tqRZVSkzy4stDmLWkKVsrRUDjm0hyh0k3Bszb7Vi++jI5ruVfPEmPTui2riohpMp/K6xjjG5tyV/Tabx/u7kaxwmfANmthBx3SdNRSwOQEwu9zztUZ2tDxW649BsGAsx5TZvA6Q26AMcJjagrQ9okDSAhvSbxsp+U91KLNsgkJM48YeCPu+PywoU5N6XXVl0yUZEfovDb6BYzOE7UR6ODRD1ts45p+h4eZApE75RuJ7fTxG6R/1JXa0hQXWEUUTjKlLvxM5GloIzRUTQ==
X-Forefront-Antispam-Report: CIP:149.199.80.198;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:xir-pvapexch01.xlnx.xilinx.com;PTR:unknown-80-198.xilinx.com;CAT:NONE;SFS:(36840700001)(46966006)(26005)(426003)(8676002)(7636003)(2616005)(31686004)(83380400001)(6666004)(53546011)(2906002)(54906003)(316002)(82310400004)(47076005)(31696002)(70206006)(356005)(186003)(4326008)(70586007)(9786002)(6916009)(36756003)(336012)(8936002)(5660300002)(44832011)(36860700001)(508600001)(50156003)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2021 08:01:24.6079
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7990087a-ff20-4e77-3332-08d9b3d79aee
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.80.198];Helo=[xir-pvapexch01.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: DM3NAM02FT021.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR02MB2688
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mathieu,

Thanks for reviews. Please find my responses inline.

On 11/29/21 11:28 PM, Mathieu Poirier wrote:
> On Mon, Nov 22, 2021 at 10:20:46PM -0800, Tanmay Shah wrote:
>> RPU subsystem can be configured in cluster-mode or split mode.
>> Also each r5 core has separate power domains.
>>
>> Signed-off-by: Tanmay Shah <tanmay.shah@xilinx.com>
>> ---
>>   arch/arm64/boot/dts/xilinx/zynqmp.dtsi | 17 +++++++++++++++++
>>   1 file changed, 17 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/xilinx/zynqmp.dtsi b/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
>> index 28dccb891a53..f4fb98ccb1b5 100644
>> --- a/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
>> +++ b/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
>> @@ -654,6 +654,23 @@ qspi: spi@ff0f0000 {
>>   			power-domains = <&zynqmp_firmware PD_QSPI>;
>>   		};
>>   
>> +		r5fss: r5fss@ff9a0000 {
>> +			compatible = "xlnx,zynqmp-r5fss";
>> +			xlnx,cluster-mode = <1>;
>> +
>> +                        reg = <0x0 0Xff9a0000 0x0 0x228>;
> This line is giving me an obvious checkpatch warning.  Please make sure you run
> checkpatch.pl before sending out a patchset.
>

I ran checkpatch.pl on patches that contains .c files and .h files and I 
had fixed lot of style related warnings using checkpatch.pl.

However, I had misunderstanding that checkpatch.pl should not be used 
for patches with .yaml and .dtsi files.

So I skipped it for bindings patch and dtsi patch. Thanks for correcting 
me here. I will make sure to run checkpatch.pl for all patches from 
here. Also, I will fix this error in next revision.


>> +
>> +			r5f_core0: r5f-0 {
>> +				compatible = "xlnx,zynqmp-r5f";
>> +				power-domains = <&zynqmp_firmware PD_RPU_0>;
>> +			};
>> +
>> +			r5f_core1: r5f-1 {
>> +				compatible = "xlnx,zynqmp-r5f";
>> +				power-domains = <&zynqmp_firmware PD_RPU_1>;
>> +			};
>> +		};
>> +
>>   		psgtr: phy@fd400000 {
>>   			compatible = "xlnx,zynqmp-psgtr-v1.1";
>>   			status = "disabled";
>> -- 
>> 2.25.1
>>
