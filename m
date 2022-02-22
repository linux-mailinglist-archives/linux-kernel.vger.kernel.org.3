Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46BCD4BF2E3
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 08:48:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229489AbiBVHrS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 02:47:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229865AbiBVHrO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 02:47:14 -0500
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2069.outbound.protection.outlook.com [40.107.92.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7927795A0E;
        Mon, 21 Feb 2022 23:37:14 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BE2dhRTcY3s8vhkDTWH/aUaiSE4mtxCEIV/TKz4iXQToAWrcBCCM1vHOkdxgAH8cbeYYvZDH3GMURiSc2w71Z2ADhqMfH4NQrr+xZrP4ukWzynPUTwLkb5lpziC8u4nShrmZ56kSNIbmijEuIj6dXwIPytp7dRhiNciG2H7CK74M75GvluJVYD8hLMe6D9r+jlDi4y94VmT5eSq5VSiT/bziMD87tYV0jm5+4QxWTVVkZzAGR7LMbcciUVBr3NkddcOPeJTxg2EONG7xuhkyDdXf4lnaa2w6vdyMTEvtDZyM9tDKub0/48PumbNnboMXtIM98ctoOAU4aLHKhXsP/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LuCA2Qzf5CPHbpklukIWDt6xBO7QY1vaWfI0kod/Dow=;
 b=mFVxoSmRKUJrVoWlv89HN09NgU9Hkk6Np9A3l2HO+uXLVNFb+vMgR0O1E6mlLR0Jlyz7y0P1L8KWvH28g34mmdywJ4SNLuyvPoPmkgaMR9b89kS6EyWSIxdV4X5eUTflll3t1Wvhiza69OcvnU5caHHEtinuWFXgVYbVuYynGD9PpcgkTKqtCBYctX7rxSLqW6lo8kafmuL8KScWxTFETxb4kkthEAATn3L/OD5rOa+/GDpen3cJsodxP+uw+iYw/QtKosMgS7hsC/znmhFBhbYQ9wVH6Y/HhrPwKriXVHaJaFt0cXEV9Z2fDKLudDFv5BSZjqGfmdGrtszzvtAstQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=kernel.org smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LuCA2Qzf5CPHbpklukIWDt6xBO7QY1vaWfI0kod/Dow=;
 b=GZOJ11SkNiB7hEUQX3jthZDmcn3amuQFFSPZnly2Fqvv2MgKY1B5c3YMgdhjYbVJULq/gU4Ql8twtVRyX1elhQH5nl6vEs1RM3OYbJCTPE6aqU1qbXoMNUKl9t+5u4HP4Lz9o5DAEMvIoi2/NZgwm4ReL5bMP9AkSc7Y4RU/YRw=
Received: from SA0PR11CA0055.namprd11.prod.outlook.com (2603:10b6:806:d0::30)
 by CY4PR02MB3238.namprd02.prod.outlook.com (2603:10b6:910:80::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.24; Tue, 22 Feb
 2022 07:37:11 +0000
Received: from SN1NAM02FT0053.eop-nam02.prod.protection.outlook.com
 (2603:10b6:806:d0:cafe::72) by SA0PR11CA0055.outlook.office365.com
 (2603:10b6:806:d0::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.16 via Frontend
 Transport; Tue, 22 Feb 2022 07:37:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch01.xlnx.xilinx.com;
Received: from xsj-pvapexch01.xlnx.xilinx.com (149.199.62.198) by
 SN1NAM02FT0053.mail.protection.outlook.com (10.97.4.115) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4975.11 via Frontend Transport; Tue, 22 Feb 2022 07:37:11 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Mon, 21 Feb 2022 23:37:09 -0800
Received: from smtp.xilinx.com (172.19.127.95) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Mon, 21 Feb 2022 23:37:09 -0800
Envelope-to: broonie@kernel.org,
 greg@kroah.com,
 david@ixit.cz,
 gregkh@linuxfoundation.org,
 linux-kernel@vger.kernel.org,
 linux-next@vger.kernel.org,
 sean.anderson@seco.com
Received: from [10.254.241.50] (port=33614)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <michal.simek@xilinx.com>)
        id 1nMPjR-0009Lj-Bl; Mon, 21 Feb 2022 23:37:09 -0800
Message-ID: <14cb5cd9-c1c5-bdc7-f0e3-e2b224bc26ff@xilinx.com>
Date:   Tue, 22 Feb 2022 08:37:06 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: linux-next: manual merge of the usb tree with the xilinx tree
Content-Language: en-US
To:     <broonie@kernel.org>, Greg KH <greg@kroah.com>
CC:     David Heidelberg <david@ixit.cz>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Michal Simek <michal.simek@xilinx.com>,
        Sean Anderson <sean.anderson@seco.com>
References: <20220221192143.1661784-1-broonie@kernel.org>
From:   Michal Simek <michal.simek@xilinx.com>
In-Reply-To: <20220221192143.1661784-1-broonie@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3f1df173-4450-429b-38ea-08d9f5d6233c
X-MS-TrafficTypeDiagnostic: CY4PR02MB3238:EE_
X-Microsoft-Antispam-PRVS: <CY4PR02MB3238E10D054C0D3D04C9FAF4C63B9@CY4PR02MB3238.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Q6eDivs2gl/SoxjzbS0aseoHwzskOKNnzvS3aKbvlYU7o4/MeceVpapqLBTES1rgiyShVQ+FP9Pto9NDoNI2oIB8WVcXGTdezdDzgvOVX59W/LR8EHEqgzOZIQ0dsqsrvUf88F8kzJsVou0I1d64gaTOZ3E6UTeP+At7PBU0ZxfvnkQmns++aMxoAfAhVEN0E+toL6JZhxYPtckYlS9KsnY6bH6k+W1qdyewFNadcWJkG2AiyXqXZpydBRqVftv4R41wmOfebKEvIxeaKgdpU6bxfnjoDZCi9YMKhdg2x1IHjXt6vwqmmkAfZ7/omYpEx9jsV8B4ZaeS0kY5iutCDB/0DgBVIkib3kGVZb+QKFhMnKv5/EQCzMZF/Vd3SewYfEv8haWNo3JxucjfnIduFFcmo9e1JUh/DosW4s9OwzL+enjUFwQvM3oteQcjn6Fe37O6BLNCNAFSr98/RGhyf2Y24L/4ffXQXE4I9VAyKC1h2vvGIXyr2YEP88s0uYyeMsNVZVFf5gBHCJZ+KOhKhDf7V9PmE0F78ZuDMqJB+H4tDQldJKJpCN6TnV639CWCCmFw7XnFY70/E4N0+R7gCd+0goHgi6KODC+vxCGH1EE5lpZ7ESSE54EUBPCQ/0/YbVcYvjyccoIw7fLi/vsk3VMK2ex4AjrVhLT7Iyez5bxadLcR+z74TYhgiyp9aLn3BdC/UgpFMeU4siYTW1Y9CjG9g5aFnkwtKKH22UNs3p/6HReljXxbqYzCjdKWhocMDlyG47Uj2O19d/3gYlIM0hx0a4/5fCYWuJByPeIdQ3IjT1v5GO0X1Vqv5utzkeje
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch01.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(40470700004)(46966006)(186003)(26005)(2616005)(70206006)(70586007)(966005)(36860700001)(53546011)(31696002)(6666004)(54906003)(110136005)(82310400004)(316002)(508600001)(8676002)(356005)(7636003)(426003)(336012)(83380400001)(4326008)(47076005)(5660300002)(31686004)(8936002)(2906002)(9786002)(40460700003)(36756003)(44832011)(50156003)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Feb 2022 07:37:11.1810
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f1df173-4450-429b-38ea-08d9f5d6233c
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch01.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1NAM02FT0053.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR02MB3238
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mark,

On 2/21/22 20:21, broonie@kernel.org wrote:
> Hi all,
> 
> Today's linux-next merge of the usb tree got a conflict in:
> 
>    arch/arm64/boot/dts/xilinx/zynqmp.dtsi
> 
> between commit:
> 
>    eceb6f8677d31 ("arm64: xilinx: dts: drop legacy property #stream-id-cells")
> 
> from the xilinx tree and commit:
> 
>    d8b1c3d0d700f ("arm64: dts: zynqmp: Move USB clocks to dwc3 node")
> 
> from the usb tree.
> 
> I fixed it up (see below) and can carry the fix as necessary. This
> is now fixed as far as linux-next is concerned, but any non trivial
> conflicts should be mentioned to your upstream maintainer when your tree
> is submitted for merging.  You may also want to consider cooperating
> with the maintainer of the conflicting tree to minimise any particularly
> complex conflicts.
> 
> diff --cc arch/arm64/boot/dts/xilinx/zynqmp.dtsi
> index 056761c974fda,ba68fb8529ee0..0000000000000
> --- a/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
> +++ b/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
> @@@ -823,6 -824,8 +822,7 @@@
>    				interrupt-parent = <&gic>;
>    				interrupt-names = "dwc_usb3", "otg";
>    				interrupts = <0 65 4>, <0 69 4>;
> + 				clock-names = "bus_early", "ref";
>   -				#stream-id-cells = <1>;
>    				iommus = <&smmu 0x860>;
>    				snps,quirk-frame-length-adjustment = <0x20>;
>    				/* dma-coherent; */
> @@@ -849,6 -851,8 +848,7 @@@
>    				interrupt-parent = <&gic>;
>    				interrupt-names = "dwc_usb3", "otg";
>    				interrupts = <0 70 4>, <0 74 4>;
> + 				clock-names = "bus_early", "ref";
>   -				#stream-id-cells = <1>;
>    				iommus = <&smmu 0x861>;
>    				snps,quirk-frame-length-adjustment = <0x20>;
>    				/* dma-coherent; */

Thanks for letting us know.
This conflict was reported some time ago by Stephen already.
https://lore.kernel.org/all/20220210141550.56359523@canb.auug.org.au/

Thanks,
Michal

