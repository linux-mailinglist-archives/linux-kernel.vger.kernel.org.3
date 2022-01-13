Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96B0D48D099
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jan 2022 04:01:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231841AbiAMDBD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jan 2022 22:01:03 -0500
Received: from mail-bn7nam10on2082.outbound.protection.outlook.com ([40.107.92.82]:19169
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231833AbiAMDBB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jan 2022 22:01:01 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Zsbq4nQY3vNfu8jaCbCoeReWQQlbLSUSWUct0QUbIjO9gZO/n5uQ4qQf6lGjxG19Nz6+ptOOaKsv13BpvBvhnUU0ZTP137XmcTVRZ/EXwAQAp3Fyz/mTeNaiqaUijuNoKn22AKc9lFeMrSJqpW+r3jGSQ/wHfAd8Iqcjsg2G3EOM4BKgoohPKxv+wGczZ6FwvK7mIqqaAfnJpN5sXo5rMmlLo2TQcBI+BvbCVEy37q/qGn9Ik9aVctbcY7MCJAnBSn7LI2zunwHFhvzIIS10j929dOCUZEGMwGWXwo8DnLvqMSzpbQ0sIELuco8yiipzElonRf3LUVRGVSRy/VrPRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=211oei5EbsRXvc8+S11vB9/wSJki5EynCQBXnBDO0bE=;
 b=AeZgbUiyy40Op9GWdLaZQTtQnV2ZeY5RSeypQl2z8bU2usjfZEkyKTSRXbV8QlbAoeU32Q+bljNzZBsO1VNxdsWyOlvDVbiSGhzqe87GQ7EH0Z33LLDP6kBWW04IBdsrIgfv6kV2BMIhuLfde/ZEI4OojzHF/Tkn35W5hvljiad74H0+d/kdSmSKzP7ylYqBYbtcgdlv/5DLsGt/Zyq8NhDhUFrMUtRIk3TP8+LTTCDH6nSEGaVW4i8+R5NRRlyoPh7y6sBUBE9KODjQfcqOjDDXkk/JGHMKctPHDoHyxJFBVF0lB1xzOpV16wlO/geNUv8FoOkspjlhHY6w9UmEgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=211oei5EbsRXvc8+S11vB9/wSJki5EynCQBXnBDO0bE=;
 b=QVO7rib4pLmeoY2d0EFH0KJB3SJONT3FNkX/Wu+K2xWdW5go1uDZSS0x+TKNyEVuQlb7fWqhMgr06xitTTmEt0ANlmi83g/VuCn8akNMWkt3XCrqdmB6TOY3+RmAytIifRkfjRSGn5MjDpqZeo5ycBtrEOKkPj+ZwSWB4IHomzQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB2504.namprd12.prod.outlook.com (2603:10b6:4:b5::19) by
 DM5PR12MB2504.namprd12.prod.outlook.com (2603:10b6:4:b5::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4867.11; Thu, 13 Jan 2022 03:00:59 +0000
Received: from DM5PR12MB2504.namprd12.prod.outlook.com
 ([fe80::f02e:2cba:7c63:e368]) by DM5PR12MB2504.namprd12.prod.outlook.com
 ([fe80::f02e:2cba:7c63:e368%4]) with mapi id 15.20.4867.012; Thu, 13 Jan 2022
 03:00:59 +0000
Date:   Thu, 13 Jan 2022 11:00:36 +0800
From:   Huang Rui <ray.huang@amd.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Linux ACPI <linux-acpi@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Steven Noonan <steven@valvesoftware.com>
Subject: Re: [PATCH v1 1/2] ACPI: CPPC: Fix up I/O port access in cpc_read()
Message-ID: <Yd+V1PyRnxg+jE6p@amd.com>
References: <11905930.O9o76ZdvQC@kreacher>
 <5789025.lOV4Wx5bFT@kreacher>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5789025.lOV4Wx5bFT@kreacher>
X-ClientProxiedBy: HK2PR06CA0019.apcprd06.prod.outlook.com
 (2603:1096:202:2e::31) To DM5PR12MB2504.namprd12.prod.outlook.com
 (2603:10b6:4:b5::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ae63c582-9da7-4bdf-a1cd-08d9d640ecb0
X-MS-TrafficTypeDiagnostic: DM5PR12MB2504:EE_
X-Microsoft-Antispam-PRVS: <DM5PR12MB250444560C7EC833BA71BA5BEC539@DM5PR12MB2504.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4125;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5JKemdp/XYalBpyaFiIgnjn/LpoRGh9/EACIBQwZoWoadMWO6BR0Se2xxmo0IEtPkBiNS4iWdlSzm0GrUoIlD6v2PxIquq0//vWlHvwBD9QzJ/i05C86Lp6vmb+ngTF0NNmFnFSi0Vb0SyC4mWRns72vrq4qmOzAZBUV1QpRDZOJRonGTJ3ZdAQ7VBo8/yQ1pdhXgan1cNXoW5x00nhEqDnqBbpmjx+Jc6Ly8gcLRe1/OkLDzPkGOcRGPSF0LywD5lCCJanoOKuGUlygNuYCX3aff+X7DuRzNwhECmrbb+9gewNsUJU0R7nzYDL9UybcSDTX2dktYGZn4aK/ary7BSlxJGI32VoqeLQHSpn5hHVm9QVOoTtM5cXxgGlwrh+tk283gqdHdSVELc6w1kL0sc3DKMsd71htmP6zSNd1aYgxkkRLElT2XCho9xGLt006f2qlIa0gDv238vtXkv/I7T0pgaqIUnT4NVV0oxJ+YtBIcjnXMh2FxUGqUxmi5nvpbe1BNkBZG56vW0H1Jnfd12RANYOGv7/nAvgSeTOpudSaGX8g2mKJ3nRY2g4jov0+E0dZXyNcvubFBGaRvvZa466KhjhWOdlDZpZeiQ9v2nCWC9D4ysx1zP/yU85NSCIDsMCuO4tH+WwtoYOwuNsLu12x5elmCQS10qIQ4IkdFGoAQoekoC8wStKa3SnFFA74E9Wq7ua6wSk5MZrRD6btjZ1xg/G8+qwNt6ev91napJc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR12MB2504.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(8936002)(66476007)(186003)(38100700002)(316002)(26005)(6666004)(54906003)(6506007)(83380400001)(66556008)(4326008)(8676002)(2906002)(966005)(66946007)(84970400001)(6486002)(36756003)(86362001)(508600001)(6916009)(6512007)(2616005)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?bqxOYRPP0SSpT6HinclcOECEz0rVRFs1m3vKWGBxzHiW2JsDamqVGhoSEp9b?=
 =?us-ascii?Q?uQ3LG/vVuQWUqBv0JcmoCRgDSu2W6yjMcOoiITxYeQ+xJht/+wCEde0ThmjD?=
 =?us-ascii?Q?IPwfK6nRcuQfeUjQc/DwqZruZtEk844QZ/gJ2/URUDZ8TMksX79eoI7lR/SD?=
 =?us-ascii?Q?u17ggJ6kV8THkKmCtR99n9/lvFNEZJmnzr4G8/BB6O4Wp1KejqLsiKtjios6?=
 =?us-ascii?Q?8mYbnrH++UDiEr87RU1MmNme3qk/iFBX+rfgxc/gXwFrFhAJmXH2BRQkmwOU?=
 =?us-ascii?Q?QWqjXKxgpmXmCrZBbl6GOYrGJMuJR0L7WmI+pSbMJ7DjHp1h0b1RG0//u5mG?=
 =?us-ascii?Q?hBv3T/y11rn4s8wWnNwT9WLmEKxpfnfKam2nxTbqg3spMzZf8qstmvsvQkcp?=
 =?us-ascii?Q?0nVpSqdwBf1+hN843ZerfpabhZ5kqnpIwNTSYTNvWxJBqnzo6HLgmT3Ii5v9?=
 =?us-ascii?Q?vytBrIvezRY9WtJ2i15tl/rXfNyPS/K8XgXkOWEeDbjLmVn4aWHALxSnayBL?=
 =?us-ascii?Q?VjoQhGIMr6YnxvKO5MaUXHVWMfXls6yyTZSRIfJEh8RMnPJCee9f3+O2c5IV?=
 =?us-ascii?Q?6Hhm/0BVOESERj7+0T2w1ah/BCHypSz9JlZ6vCV9GB66l+ZOsxzbZFm6Tk6R?=
 =?us-ascii?Q?gRJMgin7zYInHHf8vj8kjgBSh4l9dyhY5SKpYeGfGT9m6EQKNeX1Ub4T7Q4V?=
 =?us-ascii?Q?yBA60Ay6V5fwQMUkFKdCCaSyf5lt6Cgg4C/+xMSQX/TEueBWOb2jlESw3+MQ?=
 =?us-ascii?Q?sQPav/9XTJsv2LTy1Us+e33/zc3aqaoxFsTrc/n2QsgX2+/VHYrcfJv65jxp?=
 =?us-ascii?Q?wcmxPXG9qAYcQodRNTLWq4PvmQxmTxhIx1IdnIPJD5Ngoa4a7gPicRhRg6vj?=
 =?us-ascii?Q?MgQlFJ3NXSad9+ITt7pyhkE/qiqoi/XB2LxFb2/Zsqh3U2bX2TDcLua3zYoG?=
 =?us-ascii?Q?znpNXJV/HSv+sqfQs1EMD9Su2oLD0I3Svt6I0vZDBlMPOioZdIiq+hWlTKlJ?=
 =?us-ascii?Q?AQ6YHrEq3ULxNwZbE18oJDPXc5inS5tHaYFwDfNqsaQw2ddyUKYcnKFlQ6NY?=
 =?us-ascii?Q?kBRudUZ9L1VnW6E/yd+chvumP5gLyYhARqBs+r+9u0LRLFQBVD8BvEyrW3Nj?=
 =?us-ascii?Q?uIe2dudQ6+6J4+6lx4QkWBHXiix+pDXfdeOEtFeEcYynQxpukdQHNiwjgARQ?=
 =?us-ascii?Q?9hVehZIF92sM2Zx0fGcXXAYsYpWXjeZEmbtZFyTP8zlxbCudwd50Tb9xiw5l?=
 =?us-ascii?Q?mW0Y3zGgBjI7sGz6ROwTuSGwGVP5eCPZf7dHU2Tx8/mSbikI/fy/3QbTblfg?=
 =?us-ascii?Q?RO8Q4niP3G0nUjz4JHaFPqxRLqWN+eChiYS5/icnPB6L7562Oc3JejOT/yAK?=
 =?us-ascii?Q?fDyXQ+QiQUZEPms5fARTED76bvYqY96l66fPyVWxYVA3s0ijJnoAbIfpEQ9C?=
 =?us-ascii?Q?coJREdAdmKnVomQljODluNQLVSnipYgmY+9D6j5Ux/1nWxn7gU4Tw01J6adU?=
 =?us-ascii?Q?hHsUEomIzaw6SlrS3ayGhe4SVtgLl6AdL4LqW4Rs9TsB1oxg+vkY2ClbY6E8?=
 =?us-ascii?Q?9hIbiNDJVoNx+6LFZMn7dhqkztW2BVyP0dACyX1WfFoybADoMk3AQoxlpquj?=
 =?us-ascii?Q?XqmyAyxDFPSPQDSQZTmCABU=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ae63c582-9da7-4bdf-a1cd-08d9d640ecb0
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB2504.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2022 03:00:59.0010
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qAQ0R9PvIRqCUtAUodXcSknkrgEeamEFPlUP5on/spNJ/LuLXGufmRIgkBjK5wtsGDZAi1/4SgkC+ePBfCVRbw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2504
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 12, 2022 at 07:26:32PM +0100, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> The code as currently implemented does not work on big endian systems,
> so fix it up.
> 
> Fixes: a2c8f92bea5f ("ACPI: CPPC: Implement support for SystemIO registers")
> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> Suggested-by: Dan Carpenter <dan.carpenter@oracle.com>
> Link: https://lore.kernel.org/linux-acpi/20220111092928.GA24968@kili/
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Acked-by: Huang Rui <ray.huang@amd.com>

> ---
>  drivers/acpi/cppc_acpi.c |    4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> Index: linux-pm/drivers/acpi/cppc_acpi.c
> ===================================================================
> --- linux-pm.orig/drivers/acpi/cppc_acpi.c
> +++ linux-pm/drivers/acpi/cppc_acpi.c
> @@ -929,16 +929,18 @@ static int cpc_read(int cpu, struct cpc_
>  
>  	if (reg->space_id == ACPI_ADR_SPACE_SYSTEM_IO) {
>  		u32 width = 8 << (reg->access_width - 1);
> +		u32 val_u32;
>  		acpi_status status;
>  
>  		status = acpi_os_read_port((acpi_io_address)reg->address,
> -					   (u32 *)val, width);
> +					   &val_u32, width);
>  		if (ACPI_FAILURE(status)) {
>  			pr_debug("Error: Failed to read SystemIO port %llx\n",
>  				 reg->address);
>  			return -EFAULT;
>  		}
>  
> +		*val = val_u32;
>  		return 0;
>  	} else if (reg->space_id == ACPI_ADR_SPACE_PLATFORM_COMM && pcc_ss_id >= 0)
>  		vaddr = GET_PCC_VADDR(reg->address, pcc_ss_id);
> 
> 
> 
