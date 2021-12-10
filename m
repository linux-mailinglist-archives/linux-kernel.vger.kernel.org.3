Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7BBB046FCC9
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 09:32:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236065AbhLJIgL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Dec 2021 03:36:11 -0500
Received: from mail-bn7nam10on2137.outbound.protection.outlook.com ([40.107.92.137]:55681
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232663AbhLJIgK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 03:36:10 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fw9s8vRYZnoaPKeW0OllUkUnF3vkc8jthr1ZyI8AC2SWVChkhRjIXiZukkTaPRVWCygFBhdTCXzDdm/SfWbf9RgAxGdxqEP4hzOOdUYVbL6LHusaqpTEgBZWxyOnrVbSv8kqeltGuTaH5v4v+8qI0R88J40Xej9IMYgX9+68XrGt5Fhgy4GgFl3sB09bnmHizkrb7NOFSieum2dByPkrnFRogl87x5uZ/jVNoVc8a5bbP5tn/sUiGPyX+ezWryzcH2PgNCxWmfgD1QD9zzQhKKht/Wpeth6DY9tuOi0W38XC+2Gu5654I2eOaoa+R+fIBPl8xrDbfk1TUpP9mD5Ftw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q9SOd6MM1sDJ7cSd5W9EopOI285yg8iZL3esFOLu8Qo=;
 b=jLmLmGrI0E0cOMM6uZ8Jtf6vv7tAMJVRu4Sq6GreZz6aG8O9vpKT+S878NPtfqZbJjxeJ1B8FxT8r46lflQYM8GLrWfUwFJwtaYalRV9W60bUXTI3aWVy9YzwGHZtXSeGIMwwIaKPan3aGuMg9xtieVt/xZj3TuQKCEXczztA9rL3rKGja9NTbnRif0YtyKSq29r+41nAtwyYl/p0x5R16ZahlvRzKaGMHmvzXBuAeGvjwB6GkAg+kmuls176pRHe4We9ct3vejou6XVowsSYtJqhvE7m++i19xuYTjj3o2wqfN8wqdTC7sZAj232jcTM+7+QqJd8yOHDpkyZS70iQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q9SOd6MM1sDJ7cSd5W9EopOI285yg8iZL3esFOLu8Qo=;
 b=YqyquIVWulYlqHvbkYVDgYxr/WWzKP/XL5olWUCTXkDVGtsS9w6MIKk5pamGoyja91hPo10XD0XaoAI8tvgwpJSsQf1HeBrLbOYPcGwNJZHUJSc3SFqZFWdQa8IY7KymOmukSWjbLsAIJXi2CFLeUZNftLxwiIcG6QGoHkb/leo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from DM5PR0102MB3590.prod.exchangelabs.com (2603:10b6:4:a4::25) by
 DM5PR0102MB3368.prod.exchangelabs.com (2603:10b6:4:9f::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4755.21; Fri, 10 Dec 2021 08:32:32 +0000
Received: from DM5PR0102MB3590.prod.exchangelabs.com
 ([fe80::38e1:cab:501d:6b96]) by DM5PR0102MB3590.prod.exchangelabs.com
 ([fe80::38e1:cab:501d:6b96%4]) with mapi id 15.20.4755.021; Fri, 10 Dec 2021
 08:32:32 +0000
Date:   Fri, 10 Dec 2021 00:32:09 -0800 (PST)
From:   ilkka@os.amperecomputing.com
X-X-Sender: ikoskine@ubuntu200401
To:     "Russell King (Oracle)" <linux@armlinux.org.uk>
cc:     Ilkka Koskinen <ilkka@os.amperecomputing.com>,
        lorenzo.pieralisi@arm.com, guohanjun@huawei.com,
        sudeep.holla@arm.com, rafael@kernel.org, lenb@kernel.org,
        robert.moore@intel.com, linux-acpi@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devel@acpica.org, patches@amperecomputing.com,
        scott@os.amperecomputing.com, darren@os.amperecomputing.com
Subject: Re: [PATCH 2/2] ACPI: AGDI: Add driver for Arm Generic Diagnostic
 Dump and Reset device
In-Reply-To: <YbIwfzND2R4WyQO7@shell.armlinux.org.uk>
Message-ID: <alpine.DEB.2.22.394.2112092359001.2491@ubuntu200401>
References: <20211203024311.49865-1-ilkka@os.amperecomputing.com> <20211203024311.49865-3-ilkka@os.amperecomputing.com> <YbIwfzND2R4WyQO7@shell.armlinux.org.uk>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
Content-Type: text/plain; charset=US-ASCII; format=flowed
X-ClientProxiedBy: MWHPR10CA0017.namprd10.prod.outlook.com (2603:10b6:301::27)
 To DM5PR0102MB3590.prod.exchangelabs.com (2603:10b6:4:a4::25)
MIME-Version: 1.0
Received: from ubuntu200401 (24.22.97.92) by MWHPR10CA0017.namprd10.prod.outlook.com (2603:10b6:301::27) with Microsoft SMTP Server (version=TLS1_2, cipher=) via Frontend Transport; Fri, 10 Dec 2021 08:32:30 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7eed8fcc-4903-4b03-0f25-08d9bbb79bda
X-MS-TrafficTypeDiagnostic: DM5PR0102MB3368:EE_
X-Microsoft-Antispam-PRVS: <DM5PR0102MB3368B729FF2CE4C01E9E88D99D719@DM5PR0102MB3368.prod.exchangelabs.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SfwjDE1OIS7aLTQYhpSzPD2rSvFioLNiV1PWOZ8Gu8hmMzN418v9tYp4egpThteAvkEqHUP6x72dxnbvuNXqjXR6ebJpeMaXEiu8iEi6aGZL24DD6/7SGYR1PNS2MGL0R/R11gxAyHWiwmHU9ACU3toGPczg9iL+c9VCVmVMccjoHtTWgNJ4VgTP8B1piAFUyf6BGVBIxQWWwu2YoAkpGUzwgLJ56Bk78Jv2dIIOhyOWzGfRpiOzI4TPBI1LoLfFjA9cmhnnHMAXd3fyvgZRyeO0i3xSDpxkNNeGgtGv2yKwCVk395heCzeV7bRSEpoIO9p2UiIFd0LvjBzSUHLIZfgynG5qdiMN915kcQOiiMtFgyZWeOC0XEjR2YFrIfcIhNihunlN+SD1GP2MWsuM6McvTKXL9QjQweOfbSg7D798HNJXmdEOSwb7ky6Lyh5zXEoNfEe8ycysp4HfijK6G06J34nebfGfLHxyOUkZS88FEXHo1BB6HFxgXNGpG/Ysr12WLUZwNspMxHwxmx+C5O3jIiAwftbepUX24849BeZWd0hez4hMH6xPRteDXjz5H3dvJBd4mLfZkWqbut1eoNp2GxwDUKxXwinxw4IJsBgvhu9xZpyBObOpQ3qmn4H2dOwRoE/ezHtpFaVm8B9BY0Z7jhbO2k2LosZ7M0j6KgnfBdjbVVvYno9Ks0UPC9v3BjyPucZEeuEQ63PH3UrTozrai96IYwKkGhbnxMpmbj533uF//kMWuiLFTze2rLR8cPxCnKEekOoycsz2G+pA0CumSTq2FR+tDOLalkmsLOJ3o536V2RcjY1UtTVThs8J
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR0102MB3590.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(186003)(8936002)(2906002)(8676002)(38100700002)(966005)(9576002)(86362001)(7416002)(66946007)(508600001)(956004)(26005)(52116002)(6496006)(5660300002)(55016003)(9686003)(4326008)(83380400001)(107886003)(316002)(6666004)(6916009)(66556008)(38350700002)(66476007)(33716001)(41533002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?XY1qBA6rxVEwCi9UWdGiimYh4r4E3i3sxQya/lLkEF2xWj3s2pbtgjrAv7YR?=
 =?us-ascii?Q?qiW2onRZ5huXIgW3y1MtROytyfMdAUKm2HMRBgZO6CdkKo7D5+bYjmARsFlW?=
 =?us-ascii?Q?xjf+r3JtG65NS6CUeSM0JAKA+2fC3LXZ9c/SRx6pSWeA1Clj2lq2rzu2N+gB?=
 =?us-ascii?Q?nHGQ8Ve3AexKwRngEf7GOusKbWRbCFQh5GZ5PjVORlpJWuvMRYzLduM3p0UQ?=
 =?us-ascii?Q?dqoEWCoKwu2aZr1VUPWeIUTcN2cQfzpJebuvHqFPGzbyPrxXARDiauM0UL46?=
 =?us-ascii?Q?RVqLD52woLT/pfQ282Lkj0nlwOB2jwee0oRWzALUuxNeGQCFdupbSART6TS+?=
 =?us-ascii?Q?QIUtz9M9Ps3X0DFfjO5+IvaxsixW/AVqlaU0mAvRSN6IJMBXmo2NU7qaaAbs?=
 =?us-ascii?Q?M/OpSSbuiO5cDfuXw4/S6g8wJUOPQSeapol3ywYnvxkQKbsX8/3lcvW/ng+M?=
 =?us-ascii?Q?2jiEHL+x6FhbgufgXsGXSOvtz0UTBwBDAVHVLH0CJFWDziFjXuJ1T2RhAXvV?=
 =?us-ascii?Q?Ee3Ld5D8qDfAkmVgInuXUwvmoogeThV22RnojD3sp0ZfKlmoxC9Mb4pFiCgw?=
 =?us-ascii?Q?40G4EGGTwgRcyQI2mN4OS8lOd38HY/nUCl4cAWKNN6NHVda4cTP1n/pHOkLO?=
 =?us-ascii?Q?FtLfmGIs0rno6KrOsQj4iKoLX7rAN1MzNaJQZswEMaSaOKz12NctsLh+DQZL?=
 =?us-ascii?Q?NcucycEx5LB0Xbpw2PutHon+x3X0Vi9ci77U1ZRaLmDdGcTe3T/w/97hoGeA?=
 =?us-ascii?Q?o9jvjYyg0IDbdzaQbYam97Tdz7i2M6mFE20y8gg1o1ulKVGTqRs3Ku2/Z63D?=
 =?us-ascii?Q?lTW1uhG74JslVTPTytpVKJ15U1YXJf3gkTsIQirtl+e56yNt72WiDoLxgrwW?=
 =?us-ascii?Q?UKI+rpA9NOAQhu1Smvs+m0i8gkP8HdswK33mEeukDdKzFJ6eqQ8f8Tah03t6?=
 =?us-ascii?Q?lJXpnX0rv95M3MuYtFIqZwWyt837IfCLL9tR5G6OZ7WU42gPVfGpwMxQsU5r?=
 =?us-ascii?Q?Mlon3yDiFMtcN0IFzOhpjG0X9Nle04SStK28UPleP8R8Z9/tFESixA1xfCFr?=
 =?us-ascii?Q?rRl14vjdSeH0aUv4rcLNWt+RWVPTS3Y+BCIch/8lhCdFhVJgumzYVIvIG98g?=
 =?us-ascii?Q?X8X2UTIWyPOf2lH7vE2ndzDAiyzetWPYfyJ+l2Mh624fa6YABpwKDq0TJeyc?=
 =?us-ascii?Q?NeBGuADs9gpnfuLrv57wqFyqX3/d7C231Jz5jiVol6nn3bbUrcm0pDYN14RO?=
 =?us-ascii?Q?mL63kKYnlgmAJD4Q4DXSvmUialEo+KCtPHs17FPZReSzhwMY/141pu7B21qD?=
 =?us-ascii?Q?fSCLgPAe6761KOay8mQZccrPW0xsUL89y8ZfuGLHQ6SyYyD/MD0TDLkbrTLh?=
 =?us-ascii?Q?oQxeSHGpM2EdPMGQx3CKH5mwwTk+WkYunK/5cScjf37B8vGGUawE35ep0wDC?=
 =?us-ascii?Q?dn9Txw8KymgEdlrOp+GDfAXLrq0wksYWHGzorpvI4ptfY/ZzcflysXdGO2Of?=
 =?us-ascii?Q?ZmlObV067OLCEog+6pHOjqteg6l9Onuh4ZkYPOSU0W1uCgeVeF7zQdYTpkaS?=
 =?us-ascii?Q?/KjHrsA/KENlbNtt4AToQeqRD9pMzJwTLyjsOnyYXSxx72f1+NH2NJw2gUap?=
 =?us-ascii?Q?J0J50Y8lzbMDw2ngiNEXLZy1mLIDctgapfoM1o3ENarsgqPRYfjzUy3T8xrG?=
 =?us-ascii?Q?Xp6Q5r1a9TMk4zDKoa8UTql2yvpFViVzTTgo3/41yg9YZx6yjptPA3c+FczX?=
 =?us-ascii?Q?2v1eG0v0gA=3D=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7eed8fcc-4903-4b03-0f25-08d9bbb79bda
X-MS-Exchange-CrossTenant-AuthSource: DM5PR0102MB3590.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Dec 2021 08:32:32.1241
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Mgcj1UcklT2PY7Gau5+Q0sJ6Y10RSmOHWAy6OxsgS4OolCBCcaMg+OI1iPi7Hw3yo0TWZcZ1LVub9IjI0zJAwRn+Y2q/nrEPYTQkY/gFwaiTatDF/thmuZxFwPWE0RDy
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR0102MB3368
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

Thanks for reviewing the patch

On Thu, 9 Dec 2021, Russell King (Oracle) wrote:
> Hi,
>
> On Thu, Dec 02, 2021 at 06:43:11PM -0800, Ilkka Koskinen wrote:
>> +static int __init agdi_init(void)
>> +{
>> +	int ret;
>> +	acpi_status status;
>> +	struct acpi_table_agdi *agdi_table;
>> +	struct agdi_data *pdata;
>> +	struct platform_device *pdev;
>> +
>> +	if (acpi_disabled)
>> +		return 0;
>> +
>> +	status = acpi_get_table(ACPI_SIG_AGDI, 0,
>> +				(struct acpi_table_header **) &agdi_table);
>> +	if (ACPI_FAILURE(status))
>> +		return -ENODEV;
>> +
>> +	pdata = kzalloc(sizeof(*pdata), GFP_ATOMIC);
>
> Why does this need to be GFP_ATOMIC? Also, struct agdi_data is a single
> int in size, why do you need to kzalloc() it?

There's no reason for that. It should obviously be GFP_KERNEL

>
>> +	if (!pdata) {
>> +		ret = -ENOMEM;
>> +		goto err_put_table;
>> +	}
>> +
>> +	if (agdi_table->flags & ACPI_AGDI_SIGNALING_MODE) {
>> +		pr_warn("Interrupt signaling is not supported");
>> +		ret = -ENODEV;
>> +		goto err_free_pdata;
>> +	}
>> +
>> +	pdata->sdei_event = agdi_table->sdei_event;
>> +
>> +	pdev = platform_device_register_data(NULL, "agdi", 0, pdata, sizeof(*pdata));
>
> platform_device_register_data() uses kmemdup() internally with the
> platform data, meaning it takes a copy of the platform data. There is
> no need for the pdata allocation to persist past this point. Hence,
> given that it is a single int in size, you may as well put
> "struct agdi_data" on the stack.

I somehow missed kmemdup() part. I remove the allocation and move pdata to 
the stack instead.

Thanks,
Ilkka


>
> Thanks.
>
> -- 
> RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
> FTTP is here! 40Mbps down 10Mbps up. Decent connectivity at last!
>
