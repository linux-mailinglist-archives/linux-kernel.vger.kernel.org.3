Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 018954B0D86
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 13:25:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241526AbiBJMZD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 07:25:03 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:41686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241519AbiBJMYt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 07:24:49 -0500
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2075.outbound.protection.outlook.com [40.107.237.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44E55103D;
        Thu, 10 Feb 2022 04:24:50 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QSXkQPHEC7AfCfy43cDpM/n2pueGcHFBlRi6i3P0ANPF41KLnuESQWPfGUiMV13M3RSnBG/e0vQLCMduQFIyxbKhhuAFQpQPwGgEr9wh5tWAI9LZr9YhImI3rayUb+XvorP4EMmfyNhXvvSetYy0PeYQZ6mvrRUZQAX98abZPqmrb1rLoY2RtCxrSxvuuThd4NBvfaCgHDz/EryBbA82M15XoCCukW5jHb4/V8rGr1eiMhiMUmUwli6iuA2fkI92fY2ZtJBG6u8LO39bu3cTf1v/Ep1L0/J0Ju6wKSwwdK/NDzqbfzlCU29s0B89NSbknuumvEU+OpBXBwQZvgeapw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BkQQyXBAq0+5kyulfUQswHSNy0oqllRdyt7sGRsbtbo=;
 b=IzO5IKMZiTDlAy9pkDXC1FdsxTnHc2M2fMkyFT2TtZ+vwbwGsyqNpRyFjxTpDXNhVZ5wpxEWnH8mw4n/wUaWt36GbboHq2twmdXVPn5AwS81jQBtgnoPZOEh6SqaoDV/ZLhfMXW7hpAVV+STuAbPVfNONlhwr2yh9oobiKF+arufLjh6tSo5CiSDAxtoJYRXZaxSdT9Sk2rq6UfXhe8/NH8UL+MuYl++4/utS8fmPak7W+i7ySP4dEoocM8UAI9zOMnH0OGO1nwbgI843aQEY/7Md+b8jD104YPaExzQB0JEcgBRVq/dX1dyPQiz1nZTtKMVqtiqCnLBxlnKp001eg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=kroah.com smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BkQQyXBAq0+5kyulfUQswHSNy0oqllRdyt7sGRsbtbo=;
 b=sbtq04XXsYM7PVvExraeTPq924laHxRUBMT1FY4EwkFHg1lrnH33u6itO5D7k6UbxE8AFHfSrupt2FXJGjOdIvb5OYHJI9x0TV95VgMGUO9Nk5a/f4g4Oj6tD06szApuRxYbIAlTw6F1st83khAPc6mz4NuPe+JVKqSid2+gKQs=
Received: from SN7PR04CA0212.namprd04.prod.outlook.com (2603:10b6:806:127::7)
 by CH2PR02MB6823.namprd02.prod.outlook.com (2603:10b6:610:7f::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.11; Thu, 10 Feb
 2022 12:24:48 +0000
Received: from SN1NAM02FT0058.eop-nam02.prod.protection.outlook.com
 (2603:10b6:806:127:cafe::9d) by SN7PR04CA0212.outlook.office365.com
 (2603:10b6:806:127::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.12 via Frontend
 Transport; Thu, 10 Feb 2022 12:24:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch01.xlnx.xilinx.com;
Received: from xsj-pvapexch01.xlnx.xilinx.com (149.199.62.198) by
 SN1NAM02FT0058.mail.protection.outlook.com (10.97.5.116) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4975.11 via Frontend Transport; Thu, 10 Feb 2022 12:24:47 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Thu, 10 Feb 2022 04:24:47 -0800
Received: from smtp.xilinx.com (172.19.127.95) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Thu, 10 Feb 2022 04:24:47 -0800
Envelope-to: greg@kroah.com,
 sfr@canb.auug.org.au,
 monstr@monstr.eu,
 david@ixit.cz,
 linux-kernel@vger.kernel.org,
 linux-next@vger.kernel.org,
 sean.anderson@seco.com
Received: from [10.254.241.49] (port=45778)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <michal.simek@xilinx.com>)
        id 1nI8VD-000Ajz-5l; Thu, 10 Feb 2022 04:24:47 -0800
Message-ID: <d7f84e0a-7c3a-116a-0911-2ed5a0bab2d9@xilinx.com>
Date:   Thu, 10 Feb 2022 13:24:44 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: linux-next: manual merge of the usb tree with the xilinx tree
Content-Language: en-US
To:     Greg KH <greg@kroah.com>, Stephen Rothwell <sfr@canb.auug.org.au>
CC:     Michal Simek <monstr@monstr.eu>, David Heidelberg <david@ixit.cz>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Michal Simek <michal.simek@xilinx.com>,
        Sean Anderson <sean.anderson@seco.com>
References: <20220210141550.56359523@canb.auug.org.au>
 <YgTGdwkTkDgx+pan@kroah.com>
From:   Michal Simek <michal.simek@xilinx.com>
In-Reply-To: <YgTGdwkTkDgx+pan@kroah.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 45986a11-cf96-4159-47f2-08d9ec905410
X-MS-TrafficTypeDiagnostic: CH2PR02MB6823:EE_
X-Microsoft-Antispam-PRVS: <CH2PR02MB6823C5ABBF7CE397B76F5BAAC62F9@CH2PR02MB6823.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dLkcduR2Sn76fsZ5JkfTPKpc1KbPy2Spk5Nt8/bYcOpE+5rj2TS+eK1y7hQ0yYE0IwwJwsRLWMR7nwzWYgFhbjMKKPVhOnsB0FigtHvkZODNCCc6eMs+Cqqjd2Wh/FwbUHMf922fKUf7R2qbHs2mRLR+aCAdiAuS+iAgsP6eKBtib1IK3YFZM7f73w9LQSvGFoAdkJYxo/CGrfwj1AQEqe0xoMAQZMwsI2aJV6hDIw7FPU9vTgqVtwuw7WTdmFTa2N53qFF6hVp8L3xZ4UBXxLKYfLXzjGitbD73noKYapB67XeVn6IMbzPrENXTqzXCoCYM53j2n5BofeRv5kAyGLR5TO8x7Gp+djFDNkw+BSQlokaPIwWORG/yUelx0v0oKnWoG5DCdys7gepJx9YPG1M3Pb/+4jkU048oCjP03wo7qIFCnSM+kfYFQPoqjsoE2fzpu23H4HDV1Eaocn3Kz7ZkIoArvQtlr4vgWMqTccaq5i8reh2UcDGqeIfJ/r44ud4V2hnAyvIP7z7Y9lTpgVw+/xr/N8R/QGkPUEMFJqcm4uSdK85dPEMufPr10LaFLksE+pYReoCYmMXUklu4+BJL4WrzynXwZs/FoNzwaYp2HsCwEqX4L7sNv0NJge90TIAbKZhuF7uHrS0vOevt8DTX6W8dU1jFeCLlvqtfON3wIrfOO81srnkM4GFeZPZjB86tY68Z54CDDjdb1PV8/1np+DsgYSY4Mu6MVpy/hu8=
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch01.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(40470700004)(46966006)(426003)(70586007)(70206006)(110136005)(4326008)(31696002)(336012)(8936002)(8676002)(2616005)(82310400004)(53546011)(356005)(40460700003)(316002)(186003)(26005)(54906003)(36860700001)(5660300002)(47076005)(508600001)(6666004)(44832011)(9786002)(7636003)(2906002)(36756003)(83380400001)(31686004)(50156003)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2022 12:24:47.8653
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 45986a11-cf96-4159-47f2-08d9ec905410
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch01.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1NAM02FT0058.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR02MB6823
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/10/22 09:01, Greg KH wrote:
> On Thu, Feb 10, 2022 at 02:15:50PM +1100, Stephen Rothwell wrote:
>> Hi all,
>>
>> Today's linux-next merge of the usb tree got a conflict in:
>>
>>    arch/arm64/boot/dts/xilinx/zynqmp.dtsi
>>
>> between commit:
>>
>>    eceb6f8677d3 ("arm64: xilinx: dts: drop legacy property #stream-id-cells")
>>
>> from the xilinx tree and commit:
>>
>>    d8b1c3d0d700 ("arm64: dts: zynqmp: Move USB clocks to dwc3 node")
>>
>> from the usb tree.
>>
>> I fixed it up (see below) and can carry the fix as necessary. This
>> is now fixed as far as linux-next is concerned, but any non trivial
>> conflicts should be mentioned to your upstream maintainer when your tree
>> is submitted for merging.  You may also want to consider cooperating
>> with the maintainer of the conflicting tree to minimise any particularly
>> complex conflicts.
>>
>> diff --cc arch/arm64/boot/dts/xilinx/zynqmp.dtsi
>> index 056761c974fd,ba68fb8529ee..000000000000
>> --- a/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
>> +++ b/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
>> @@@ -823,6 -824,8 +822,7 @@@
>>    				interrupt-parent = <&gic>;
>>    				interrupt-names = "dwc_usb3", "otg";
>>    				interrupts = <0 65 4>, <0 69 4>;
>> + 				clock-names = "bus_early", "ref";
>>   -				#stream-id-cells = <1>;
>>    				iommus = <&smmu 0x860>;
>>    				snps,quirk-frame-length-adjustment = <0x20>;
>>    				/* dma-coherent; */
>> @@@ -849,6 -851,8 +848,7 @@@
>>    				interrupt-parent = <&gic>;
>>    				interrupt-names = "dwc_usb3", "otg";
>>    				interrupts = <0 70 4>, <0 74 4>;
>> + 				clock-names = "bus_early", "ref";
>>   -				#stream-id-cells = <1>;
>>    				iommus = <&smmu 0x861>;
>>    				snps,quirk-frame-length-adjustment = <0x20>;
>>    				/* dma-coherent; */
>> -- 
>> Cheers,
>> Stephen Rothwell
> 
> 
> 
> Looks good, thanks!

+1 on this.

Thanks,
Michal
