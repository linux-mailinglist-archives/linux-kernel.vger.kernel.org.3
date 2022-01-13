Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE13448D078
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jan 2022 03:41:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231757AbiAMCkM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jan 2022 21:40:12 -0500
Received: from mail-co1nam11on2088.outbound.protection.outlook.com ([40.107.220.88]:62966
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231704AbiAMCkD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jan 2022 21:40:03 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LUeo6Jj/WvUS8goEP3yrkhXMqc6yxbSgsuGHExO3YWAUU9QWDixSry7H7QSJlnXlHM/Z7mlKL3MH4V34VpbYZZPC824By6d9eXtuOeBYHHOKPtm4vBZBxpMLeP7Jff/DmZY8oPNA1OtvyR2qM+NhP324vbXyNBkuOCJH5WVqBjQiQcLeIomo6w9RfFYHjTNtqtDs/0fchlh28jzdT7bKQ9PwcgkJvLdYbCUaRTJ2eaglwPHynEcc4EaqOqZlkOc0SzQLEYIRZEmRGMKbmGtDGexL1E/dBjrgh6+WaN5iKI1zTXX7agRf7+375tGknIgYAYlSuFuZ7WAhbUW2Jkv3Ew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jIMktXi/NE+jceptTg9UwwkFDIVaaiDARrvcDu1W60U=;
 b=VWWWQ+rJomymlysTxyNImCTi2y7+FJ16hKSEUBn57gB7hSOtnBdNdrdME4Bl2nS9rKbSq2TiQBaVYfqsWdyA4VXyomXl9Het7+6XYGP009JDz1lgFJDbzuXdHHcSVVRugUD3NLOwukF5DGwWg9CtAe3uxjSpHlcW7VWmZpuxcqWBsHLmjM78waobu35ZwiMkGs6PyY+Bsb3wB59a/a1wuY1HycZiMZu0sYYC9QJYvoTdExiQIqEWpSpb47vNrXDuQFw36bxTnb2TX1aMMAdbVTnf7LKkzZEUhAP0+8LD8acg4pLygZx/uRt5mgG1+HaBP/kE46BPZ5fFHaNWgOjUcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jIMktXi/NE+jceptTg9UwwkFDIVaaiDARrvcDu1W60U=;
 b=mg+y1cbCS2rMgVuoQTodiEk8OE0JVkdW6UdF8btf66ScW0k6akKHMHU8JylbDISA7w//G3kAMv8RKBsyvNkWWZ6nlIK8TXFC9cHopNz1lOBl4+7p10Cn7hVmiykACpj5H4QVxosdQZOvY/MvYC0ead6UYlVmt6sP/Mv+vrBb9gE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB2504.namprd12.prod.outlook.com (2603:10b6:4:b5::19) by
 DM6PR12MB4058.namprd12.prod.outlook.com (2603:10b6:5:21d::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4888.9; Thu, 13 Jan 2022 02:39:59 +0000
Received: from DM5PR12MB2504.namprd12.prod.outlook.com
 ([fe80::f02e:2cba:7c63:e368]) by DM5PR12MB2504.namprd12.prod.outlook.com
 ([fe80::f02e:2cba:7c63:e368%4]) with mapi id 15.20.4867.012; Thu, 13 Jan 2022
 02:39:59 +0000
Date:   Thu, 13 Jan 2022 10:39:34 +0800
From:   Huang Rui <ray.huang@amd.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Linux ACPI <linux-acpi@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Steven Noonan <steven@valvesoftware.com>
Subject: Re: [PATCH v1 2/2] ACPI: CPPC: Drop redundant local variable from
 cpc_read()
Message-ID: <Yd+Q5htH5dit/gIX@amd.com>
References: <11905930.O9o76ZdvQC@kreacher>
 <4374346.LvFx2qVVIh@kreacher>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4374346.LvFx2qVVIh@kreacher>
X-ClientProxiedBy: SGAP274CA0009.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b6::21)
 To DM5PR12MB2504.namprd12.prod.outlook.com (2603:10b6:4:b5::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 15e95a10-567d-4a7d-513f-08d9d63dfdc1
X-MS-TrafficTypeDiagnostic: DM6PR12MB4058:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB40583D33264DC99886435F0FEC539@DM6PR12MB4058.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:321;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gNeyn2OHjkj0DkWTl17+EdgHbRxu8OxGY2NCXsPwOrDePQAgBB6VHhN5ebiQkTsBG5BqkGiykiQbxhphAkIH8arFKsidMP128VunN8oXwdOWZnp5+Su8a6x4Hd8WAOlN584Y4pgVKzU543/yCTF8oZC2PV52rUCJx0tcTtWbRrWDOeuR4LFuPpExm78uVj6TirtMd+VOdku6mupU3OR4dUXLRk+7aAhHzZPNQMZXAzjlFVO3n4fRuTJhcleRde4OJ8CMTIca6qcYa+eZMx2Pqw9iv0u+5mMBXvj+8YChmbccAp39mjLKUPuomOZ8bSd2eLsJjm0iYrZGs1OF58mpg1mVg5sZAVTIaq9eXT/+D9CaGvoJwl0AG2ED1+mkuToH5DTyar8K772qlYIiLT2oWG1eZfznMQzR7oR670iAzuNIav1xm1PhS+3i3sWQVMY2dNx8riapsS6D2ZdJad8+C7/rA8Xjx+0bDTmUkitt3tAddXC5HfNcdk8H2oV19h3Wr7kmW9YqHHWkK9iKqwlZGGuC2rwKp7sfs0ZRIbVeKMTQMnDXst9w+i3szWyZMhIY8iLJr9Xj0DfApSpbTMSiGdTaK6EnsjvyrTnJIlykNojy/xifxnqPk+xo2vRrjPPOQb9mpuIj3cFMgnwQ5Ok8IXHwSFpK5WtUPlqJnowlJlAIyp8SRZ6dUHsjsjiCNbxMbKvSppfj6+P3H+7Dunqk/KCZNFAt1GOhfwvbI8ZUy/o=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR12MB2504.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(6506007)(83380400001)(2906002)(36756003)(6512007)(54906003)(84970400001)(8676002)(8936002)(6486002)(38100700002)(316002)(4326008)(66556008)(66476007)(6916009)(66946007)(6666004)(508600001)(2616005)(86362001)(5660300002)(26005)(186003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?o9ObKt9mNFg0pKd3ryd6TsZcoqxBqyoe3rnwpFuUy4jD1IS2dBZGSEbRbtT+?=
 =?us-ascii?Q?c59tqaWtL+fVZi6xfwRDNGPzqhKXyxXZwmIcjhxOLTfmq9bUTbBV83jlHOeq?=
 =?us-ascii?Q?4W1ToOYcrvi6If1/d8FPwDfIuHKqfkcv4JSwd6DL8q8fT+jTGCLyWzQ3g93q?=
 =?us-ascii?Q?iUQKMgqji05FcrRMRKbFjWRfMOICvE8/I9nukzQNsm7AjquW9lakctAs5XLk?=
 =?us-ascii?Q?FoK/IXUjLRRPGpLUfyojtH9UUxWwtuw7BKJDQkpoS+vCBEMYwdbbQLMqEAvh?=
 =?us-ascii?Q?Ze3QX7Mn1bqP68S2buvsS85aL6q1Zc38zOTubPPfsJ+dcHXQMTpKialnaUUr?=
 =?us-ascii?Q?CdoShWmH+AL125Gdsjf8eihrH7iEXBHWyxYpgzAiDPUKhndN9aVNSu/7Py1T?=
 =?us-ascii?Q?ssH1nnWqYsJRrFFR9K5aHSH5wQdhZ7E4oG94tShFkyKi7+6Ux5pClG6EQI1+?=
 =?us-ascii?Q?AbYxsGSOXi01/eWyz7ZtSOGNpQtUHP2SqfGXG5N6JRko6PwEueRi8gFLHclU?=
 =?us-ascii?Q?iR+S7VqPPagFNiP3EkHEpr05gDZqsr+b8qS4zvBp8qHczAbyN0xDLl9mZE9h?=
 =?us-ascii?Q?Lq+iiOftWHl/uD5SqpE+D02pmPGX/6n34Ba0XEhma86pn0jFBHZnQZZZaIfg?=
 =?us-ascii?Q?P0fh1gexSuUWtDBvzRy9EKUWpx4q0+K4z/04gl5relYwOXo8V7v7vkZzJuFO?=
 =?us-ascii?Q?WSOGcvw/KUGS1BSUnIMrdr5K2g5ls3RGu2xL9xX/dCKYUPBYFQxdMmgJ/XX3?=
 =?us-ascii?Q?o5c46xvM7YWYV5XZW2RIZ12HMKn6BsmIut67pBjPBuXDe06MTBC1B2cINZB/?=
 =?us-ascii?Q?RIKGNa4mgF2acpGrcXH0PlMnZ7jaqJuzPeitRLp8PBgG5PLfA++bq5+ureVh?=
 =?us-ascii?Q?wgpNytsEQMzvgKtO0Eiomot6MI8CkNTC5mmpMdBtKznkxBkUjLlmpouW7Eud?=
 =?us-ascii?Q?VOKO7OQbEkxzr5/tgtEUAYa9zSCrx8FDtV1N8MvrvKCKEOViRI9EqyUnBK6Y?=
 =?us-ascii?Q?xEpThFo40f2DoRsFsexIUiIxr/kjAByMoqEL+dnojiCm0FiFjnd+931rcEcl?=
 =?us-ascii?Q?J001DAD6XEjrJA2AcgZpo/86YAodavNbY7TA4PIK/lizv8hdes2xZaOqojgR?=
 =?us-ascii?Q?ZcCKCzczC5k7fNXVvqWyHdHCqW/ziE0dS+mQnPOgi0mm7C4/jYHtIWFe2NUp?=
 =?us-ascii?Q?HXN96Qp3KiTEO3cp0WYwy0sl4frS7c8xtgic0pDaviTpQiEZauuGMQGrKGR/?=
 =?us-ascii?Q?1hebx8VrPlqhJiBDKBw4NwdQ1C4+jlXFW2kSzXB0yIzyLKAC2Ir2goG6oqTX?=
 =?us-ascii?Q?I9JRhxyuuIX8qZhXjl6afmqJKZs5VDqbuMIOPCUNof2SQv5PbiR7r3o7CwcH?=
 =?us-ascii?Q?KOgc9A8XQVPxst0ysSDaX19tHZqTzNwm+tHa2m5xWzADMOeX6yr6zxuIK83v?=
 =?us-ascii?Q?hOGyx1JQAkisA3pv36Sn4UuI/Bu6rwljm0u5cotlZH4t/ZJhck4PZ3ze2zFO?=
 =?us-ascii?Q?CQF09dptjcQVlAEmkXnDYyysSyItm0UEWk97wvkHCidZn2E1FFsJT2DY0Qbf?=
 =?us-ascii?Q?QCzJi8rH109JzVCjxP+8jiUv4MOHABjZjKq27hZRUQeXmrwAXTmsH76Jd1ab?=
 =?us-ascii?Q?N7E2xfYpHLxGs+P5wlBVvSQ=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 15e95a10-567d-4a7d-513f-08d9d63dfdc1
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB2504.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2022 02:39:58.9852
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ndCmjzdXD+XrFGa3+oHKRzNA1RgWK0XpuPd8VFSet8g/QndzR2YW9ba3A1vq7UNO6Atrzt3Zi5sNJfnd+rdsww==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4058
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 13, 2022 at 02:27:22AM +0800, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> The ret_val local variable in cpc_read() is not necessary, so
> eliminate it.
> 
> No functional impact.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Acked-by: Huang Rui <ray.huang@amd.com>

> ---
>  drivers/acpi/cppc_acpi.c |    7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
> 
> Index: linux-pm/drivers/acpi/cppc_acpi.c
> ===================================================================
> --- linux-pm.orig/drivers/acpi/cppc_acpi.c
> +++ linux-pm/drivers/acpi/cppc_acpi.c
> @@ -915,14 +915,13 @@ int __weak cpc_write_ffh(int cpunum, str
>  
>  static int cpc_read(int cpu, struct cpc_register_resource *reg_res, u64 *val)
>  {
> -	int ret_val = 0;
>  	void __iomem *vaddr = NULL;
>  	int pcc_ss_id = per_cpu(cpu_pcc_subspace_idx, cpu);
>  	struct cpc_reg *reg = &reg_res->cpc_entry.reg;
>  
>  	if (reg_res->type == ACPI_TYPE_INTEGER) {
>  		*val = reg_res->cpc_entry.int_value;
> -		return ret_val;
> +		return 0;
>  	}
>  
>  	*val = 0;
> @@ -968,10 +967,10 @@ static int cpc_read(int cpu, struct cpc_
>  	default:
>  		pr_debug("Error: Cannot read %u bit width from PCC for ss: %d\n",
>  			 reg->bit_width, pcc_ss_id);
> -		ret_val = -EFAULT;
> +		return -EFAULT;
>  	}
>  
> -	return ret_val;
> +	return 0;
>  }
>  
>  static int cpc_write(int cpu, struct cpc_register_resource *reg_res, u64 val)
> 
> 
> 
