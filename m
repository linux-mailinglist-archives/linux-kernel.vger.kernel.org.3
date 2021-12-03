Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D748B467816
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Dec 2021 14:20:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352401AbhLCNXh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Dec 2021 08:23:37 -0500
Received: from mail-bn8nam08on2045.outbound.protection.outlook.com ([40.107.100.45]:13444
        "EHLO NAM04-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1352301AbhLCNXe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Dec 2021 08:23:34 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Tmce+5Q7WvjV2M/zcJ6mUl4nwn00KrLQuY8UPmJb6QX5LfUPI6Ryi09RMQTtT8zbfEQKNv5WxW+z2IJqO2kvVpbfMKvCjFZORfYvStZ8vganiwzX3Rr0k9bcnWiNppTXXeEmtsxQGArIjfc4Bxli41MYiACxSEp60o9KEf+u9+yEYExnVrVCTFDyOU4ZVp+03D6Kn8XszwJmyMPgjbZfiZjiFtsaAJC63n7jmqsm3kNzpajVwcubQ2B79V5/yU4zDZnFIhrlVgKkQUZhDh9nH6UKoTilDE1mQ1YCJvUERbD+aaiJtjSTuN1JaxWn5/HMotobXL1S0UF2lYkeITGXnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dp8rXwnUowIE/nPFHx3b8rIqqEDfhurQJrOkJFdxKvo=;
 b=fpLWA7VWWLGCQIKazIqqIrs7lnx1UmeMe1OIUZBXBoeE8ip98w0x8inuzTRxk1RjKLlOWEErZCGx3Ld/qPhOL5BKhoA4HaU3wOHkshOaYxPZV4ujexWSvIq8bbxdhJ2i0R6BHkiMQnCFrrzKNg86rgm4dmbq09QwhNmdWc5f+4wO/0sR/hnBP3rd3y5pkXd3zlGqw1r19JI2hzNgA1e+GucHuWvm4R6pHVYNBEPELZFHa/5IbvIajoVWDQwvyG0k/fbkQvccP6mW8EqhZdWXiWV+VHumvuX94Z2XLKS45AlATZ+FtclAQhXWsNxy/JEXR7INffL50l+B7x4TRIYq1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=gondor.apana.org.au
 smtp.mailfrom=xilinx.com; dmarc=pass (p=none sp=none pct=100) action=none
 header.from=xilinx.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dp8rXwnUowIE/nPFHx3b8rIqqEDfhurQJrOkJFdxKvo=;
 b=DmWxp1yn6CbPn8fuFuk4W3xUn/9wVS/E4hlyALFHi93VeICBVq9wbuqI2jpkaPshiMOW2U57w+bOp0uIFEekFhqm/XcFLIZw3uTtSq7py1RRxcSxtk8XSPerCfbvXnFRZOJtPXSuJ+8dcZ0+X5Z0Ffaq4tguwczYUQslLOsou2A=
Received: from SA0PR11CA0119.namprd11.prod.outlook.com (2603:10b6:806:d1::34)
 by PH0PR02MB7639.namprd02.prod.outlook.com (2603:10b6:510:5c::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.23; Fri, 3 Dec
 2021 13:20:08 +0000
Received: from SN1NAM02FT0019.eop-nam02.prod.protection.outlook.com
 (2603:10b6:806:d1:cafe::7) by SA0PR11CA0119.outlook.office365.com
 (2603:10b6:806:d1::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.23 via Frontend
 Transport; Fri, 3 Dec 2021 13:20:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch01.xlnx.xilinx.com;
Received: from xsj-pvapexch01.xlnx.xilinx.com (149.199.62.198) by
 SN1NAM02FT0019.mail.protection.outlook.com (10.97.4.209) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4755.13 via Frontend Transport; Fri, 3 Dec 2021 13:20:07 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Fri, 3 Dec 2021 05:20:05 -0800
Received: from smtp.xilinx.com (172.19.127.96) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Fri, 3 Dec 2021 05:20:05 -0800
Envelope-to: herbert@gondor.apana.org.au,
 davem@davemloft.net,
 linux-crypto@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org,
 robh+dt@kernel.org,
 devicetree@vger.kernel.org
Received: from [10.254.241.49] (port=41048)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <michal.simek@xilinx.com>)
        id 1mt8Ts-0009Hh-Nc; Fri, 03 Dec 2021 05:20:04 -0800
Message-ID: <96043ffc-ecdb-9851-4dc4-f8294c9c2499@xilinx.com>
Date:   Fri, 3 Dec 2021 14:20:01 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [RFC PATCH 2/6] firmware: xilinx: Add ZynqMP SHA API for SHA3
 functionality
Content-Language: en-US
To:     Harsha <harsha.harsha@xilinx.com>, <herbert@gondor.apana.org.au>,
        <davem@davemloft.net>, <linux-crypto@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <michal.simek@xilinx.com>,
        <linux-arm-kernel@lists.infradead.org>, <robh+dt@kernel.org>,
        <devicetree@vger.kernel.org>
CC:     <saratcha@xilinx.com>, <harshj@xilinx.com>
References: <1638213623-32613-1-git-send-email-harsha.harsha@xilinx.com>
 <1638213623-32613-3-git-send-email-harsha.harsha@xilinx.com>
From:   Michal Simek <michal.simek@xilinx.com>
In-Reply-To: <1638213623-32613-3-git-send-email-harsha.harsha@xilinx.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9106307b-7a6d-4909-2c0f-08d9b65fa02b
X-MS-TrafficTypeDiagnostic: PH0PR02MB7639:
X-Microsoft-Antispam-PRVS: <PH0PR02MB7639ACE7C3CA7A33080D40BDC66A9@PH0PR02MB7639.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:4502;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cl8eagmHzcavToMcu0r+rvKvqlPTBi42VG/eRPQ6bqJ5Gc27Pf5ts2bLbDoP9ZWkFTJ4YLCgzcD4itfkfN5VcWk6MX7fvHx60u+4Ye/JshctXf5fMOXv+22pmLqTDDWN981S+rVlBJ9KvMAjFR3Og7ZPubx7SJOeMzfcPeNm1IfDiVDnE80TqzE2Xq1NCqoTWq7jP3JTQjafyj0Pl3CervGglApTlMlt4ekz17pvdTjnOKSZ40UJhXcJCNWRo6IVM7ownmsHGzyB6CGQvbAoImzKcoKE4+hh6GvBGs+imjj179w2VNFAOzBU0p4G1tTVmGAaWaCz24KFH607s1MI0W1Amn6cAuBwPXoQydTmdOYpme9QFirjtW7Qwvumy3GHYbfRzMJ3AfOeX8M5H33eNp/Bf62DmwQOuGntwLz32ntN5bUU8lj8YVs923wmI60XXehctr3hSvf7HyDQsY/yMaFwd7qmBtLkyNk+iZn2Ix8Z4nbYsBtXJzmjB21qTabI2zKHKbAUHykq5sYBNEc8svqyEq4Avw+z2p3XJ3uz+RSNSYztx7f5eamN0x/K9m6/65ZA9AeN5GUT641JWwkDFf9RGEtOX+K1mEySXFl1TqntHM6tFojBsGH/SKU0gMFXUIpRIRTLBRft7lS4K8guie7qn7xsC92/cqbO4xaz1H1qdKAxwqQHdvG8csrN/+WboTvRdkxWITQlzk8YWJ+mQ8vk8dxv2DVgjZUyLmQ3UCeM6RZsL9Guq52hAOhyfuW/4KFINV5SsBH/wIGjQBw8KA==
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch01.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(46966006)(36840700001)(4326008)(8936002)(8676002)(5660300002)(53546011)(6666004)(54906003)(2906002)(7636003)(36860700001)(508600001)(9786002)(186003)(2616005)(44832011)(356005)(31696002)(82310400004)(47076005)(31686004)(26005)(70586007)(70206006)(107886003)(426003)(110136005)(316002)(83380400001)(36756003)(336012)(50156003)(2101003)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Dec 2021 13:20:07.4186
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9106307b-7a6d-4909-2c0f-08d9b65fa02b
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch01.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1NAM02FT0019.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR02MB7639
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/29/21 20:20, Harsha wrote:
> This patch adds zynqmp_pm_sha_hash API in the ZynqMP firmware to compute
> SHA3 hash of given data.
> 
> Signed-off-by: Harsha <harsha.harsha@xilinx.com>
> ---
>   drivers/firmware/xilinx/zynqmp.c     | 26 ++++++++++++++++++++++++++
>   include/linux/firmware/xlnx-zynqmp.h |  8 ++++++++
>   2 files changed, 34 insertions(+)
> 
> diff --git a/drivers/firmware/xilinx/zynqmp.c b/drivers/firmware/xilinx/zynqmp.c
> index 3dd45a7..a84c5ea 100644
> --- a/drivers/firmware/xilinx/zynqmp.c
> +++ b/drivers/firmware/xilinx/zynqmp.c
> @@ -1117,6 +1117,32 @@ int zynqmp_pm_aes_engine(const u64 address, u32 *out)
>   EXPORT_SYMBOL_GPL(zynqmp_pm_aes_engine);
>   
>   /**
> + * zynqmp_pm_sha_hash - Access the SHA engine to calculate the hash
> + * @address:	Address of the data/ Address of output buffer where
> + *		hash should be stored.
> + * @size:	Size of the data.
> + * @flags:
> + *	BIT(0) - for initializing csudma driver and SHA3(Here address
> + *		 and size inputs can be NULL).
> + *	BIT(1) - to call Sha3_Update API which can be called multiple
> + *		 times when data is not contiguous.
> + *	BIT(2) - to get final hash of the whole updated data.
> + *		 Hash will be overwritten at provided address with
> + *		 48 bytes.
> + *
> + * Return:	Returns status, either success or error code.
> + */
> +int zynqmp_pm_sha_hash(const u64 address, const u32 size, const u32 flags)
> +{
> +	u32 lower_addr = lower_32_bits(address);
> +	u32 upper_addr = upper_32_bits(address);
> +
> +	return zynqmp_pm_invoke_fn(PM_SECURE_SHA, upper_addr, lower_addr,
> +				   size, flags, NULL);
> +}
> +EXPORT_SYMBOL_GPL(zynqmp_pm_sha_hash);
> +
> +/**
>    * zynqmp_pm_system_shutdown - PM call to request a system shutdown or restart
>    * @type:	Shutdown or restart? 0 for shutdown, 1 for restart
>    * @subtype:	Specifies which system should be restarted or shut down
> diff --git a/include/linux/firmware/xlnx-zynqmp.h b/include/linux/firmware/xlnx-zynqmp.h
> index 47fd4e5..38ef708 100644
> --- a/include/linux/firmware/xlnx-zynqmp.h
> +++ b/include/linux/firmware/xlnx-zynqmp.h
> @@ -78,6 +78,7 @@ enum pm_api_id {
>   	PM_FPGA_LOAD = 22,
>   	PM_FPGA_GET_STATUS = 23,
>   	PM_GET_CHIPID = 24,
> +	PM_SECURE_SHA = 26,
>   	PM_PINCTRL_REQUEST = 28,
>   	PM_PINCTRL_RELEASE = 29,
>   	PM_PINCTRL_GET_FUNCTION = 30,
> @@ -410,6 +411,7 @@ int zynqmp_pm_set_requirement(const u32 node, const u32 capabilities,
>   			      const u32 qos,
>   			      const enum zynqmp_pm_request_ack ack);
>   int zynqmp_pm_aes_engine(const u64 address, u32 *out);
> +int zynqmp_pm_sha_hash(const u64 address, const u32 size, const u32 flags);
>   int zynqmp_pm_fpga_load(const u64 address, const u32 size, const u32 flags);
>   int zynqmp_pm_fpga_get_status(u32 *value);
>   int zynqmp_pm_write_ggs(u32 index, u32 value);
> @@ -581,6 +583,12 @@ static inline int zynqmp_pm_aes_engine(const u64 address, u32 *out)
>   	return -ENODEV;
>   }
>   
> +static inline int zynqmp_pm_sha_hash(const u64 address, const u32 size,
> +				     const u32 flags)
> +{
> +	return -ENODEV;
> +}
> +
>   static inline int zynqmp_pm_fpga_load(const u64 address, const u32 size,
>   				      const u32 flags)
>   {
> 

Acked-by: Michal Simek <michal.simek@xilinx.com>

Thanks,
Michal
