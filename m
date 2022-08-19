Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01D0559A80E
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Aug 2022 00:07:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236150AbiHSWC7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Aug 2022 18:02:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231598AbiHSWC4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 18:02:56 -0400
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2073.outbound.protection.outlook.com [40.107.95.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02D8FBB01A;
        Fri, 19 Aug 2022 15:02:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=adChdzo9/l/ASCY6l/j4IJx2T2wWv0aiZVr8lJMKZFBfBV1PT8d6erlc6sUqMk6Yys9pF83IeRPpQj7pKn3qn6Qoojba6RKh1/y0VLDRlIsGp1XmUYJ7Gi3/ud01Z+aX+fD2LxNaS11H0LbGusZ1mXA07jBj2PpcZnwIsCkikNXcF4ZTuwWXnKpMaCRSV1yuV0VobPilNQM2YR7EV+8qE63zEqbtLG23jwPJ7BLlfiqFIZHuU9SCxC3rQZQCLqIkDlphz7DESS/8hW9hScnIntlDy6jlGcWhrlIWy5Of1QZuXtlYp6OWOPZEpVUtIv4bPOVblDFrxwdGnjSp+Q6MgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=crVUCIv2ZEg7L3KCkq82zLoaqspG7ekJ/1OV2BvG+4E=;
 b=TfyNnhgHfxAmDxifVz7esA6ONpnPc4evvAhPWv1KreAhFfPy8TWTau5tPAVL/fRz9sRSx++Xw4DJRrRIBCYrF/6ZJwR3oKXBTMLLTHLOK01L0N8rkDr5SUMfQHtv6QAkBDdiQ31+q2naQj36+M09FDicmNnz4f+n2XBgtqNfUTeSZdTLaoFOh2Li+lF+sIEFqhqD9i5vqO/U04AsaXhpWmC67ZugtniI2NWE4KTRCQfhXzAURem0gSE0EiA6v8rDULlphkyWbJCTW9pJW7ZsTSQhR6+ap1KKnF2oq3zZ8D8yvDvWrNGCz3ecThVPCJ1Z/VDugPOGA9Gnjs2+98RFMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=crVUCIv2ZEg7L3KCkq82zLoaqspG7ekJ/1OV2BvG+4E=;
 b=kwTKhnNR5w2AEKSNslxOZVcFSTWvAq7ycYiPtjzVdXYysXFMvntE/SGxs8UMAwUYMwUBFDGPuQ/3s7U+yQrouLdNF4lKCxsQ7aB92YXTwNzUWVZMl/Or9Nl0v0K9o9BirK4Vw24Arc+wgC82lZIbvLCVAI8GeT6cp4BjluHifYrhYywNIuIwI30N2Cw/51kYgxdj3Pq5mRy/eGw7mn3VMRo7UtlPPYyfgX5csBkfX5BYx8l7Rz2aTpPpgZJ5J6udx5RqJKdB7OrznVPpcJZAPefEnwP3grxuZWWf44/9B1v8e7n3giwXclJKJ8yhCgEq2Mly94W3OIPFAew3WkrDDA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB2763.namprd12.prod.outlook.com (2603:10b6:5:48::16) by
 BYAPR12MB2920.namprd12.prod.outlook.com (2603:10b6:a03:139::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.18; Fri, 19 Aug
 2022 22:02:51 +0000
Received: from DM6PR12MB2763.namprd12.prod.outlook.com
 ([fe80::6012:2e0d:2697:8b02]) by DM6PR12MB2763.namprd12.prod.outlook.com
 ([fe80::6012:2e0d:2697:8b02%3]) with mapi id 15.20.5546.016; Fri, 19 Aug 2022
 22:02:50 +0000
Subject: Re: [RFC 2/2] ACPI: OSI: Deprecate some abused _OSI strings
To:     Mario Limonciello <mario.limonciello@amd.com>,
        linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
        rafael@kernel.org, Len Brown <lenb@kernel.org>
Cc:     kherbst@redhat.com, nouveau@lists.freedesktop.org,
        hdegoede@redhat.com, kai.heng.feng@canonical.com,
        Dell.Client.Kernel@dell.com
References: <20220819142519.5684-1-mario.limonciello@amd.com>
 <20220819142519.5684-3-mario.limonciello@amd.com>
From:   Daniel Dadap <ddadap@nvidia.com>
Message-ID: <b2ee7875-506d-860f-114f-5dd2103e0998@nvidia.com>
Date:   Fri, 19 Aug 2022 17:02:47 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.1
In-Reply-To: <20220819142519.5684-3-mario.limonciello@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-ClientProxiedBy: SA9PR13CA0142.namprd13.prod.outlook.com
 (2603:10b6:806:27::27) To DM6PR12MB2763.namprd12.prod.outlook.com
 (2603:10b6:5:48::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5bb1390a-95e3-42dd-26c3-08da822e8f01
X-MS-TrafficTypeDiagnostic: BYAPR12MB2920:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ukdt1zF8RvSO4C8mir32Srl0BAsuGr0zCYFMfULc3ndalU6VvH1VgKy8X719rWTHJZKeRCiZEVEJMMQ1JdIUH39JGUkm5uAeAIiK8awpEEQepOB7nzpL+Kx1brTcD0pzplcZeBodd41003Ia8O9fjucqLhaIbNnj5aewToqfV/W+XQUfXFtL6OuxSh9ijRFmcqKJdh0JqGgtsbbiW6DmhABEgtk2hcz/6w1Fzz18rbmLXNRKsNnjHAA9CBsm5NkZ3cekIikSUNJVYjVIruDQ+5arPMdzP3RoCK/RF6/Lq8E/42e8IZoi0A6roLYjhcKCN8VxabWQDefOZXyxt2wxut5TpdK/e/nvsl9UUuHNOytKqAsbGKmme/GpgogrNX1mxUZ5h034uLkmn9UfoKC4Sbr/LPDSaa47KdLwpLvkKUu+llVUAS4T+n49WvjS+niyCr5diTYc6YiZsZ2otvV/VGckK3p5/UD3h07tI4t51BiqIT62DtvfxOpTbusV2am/BSSZGwCgOtbL6MTgJhF8zAq2xbe+IYeBzgsf19iAPzs8zeSL1Bbl5QCXD1JnSaYcO2gbITF8zHAu9tgF4jyxeVTLl7NVS5Sa6uRzmg9DFaOUBdpyP0XtVIMmg52u1Uilzmn9TE+p6m9vYZWMeQSbmojvSRGsI9hVOWeRULz4KpY3qt4ibohm01F20VUoMqH1XcLAcpBW7fvfOkvYBW9hqe2IBdNGsMNj4Zir7q0y9gHe9L+Sn+IgiZ7CNWcVL0+8kUUK0+ToQfjikEv5x2HoMGG9jH8ErCeq0m5+1lGYOtg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB2763.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(136003)(376002)(39860400002)(346002)(396003)(366004)(53546011)(26005)(6512007)(6506007)(31696002)(41300700001)(86362001)(6666004)(36756003)(31686004)(2616005)(186003)(83380400001)(478600001)(6486002)(8676002)(5660300002)(4326008)(66556008)(110136005)(316002)(66946007)(7416002)(66476007)(8936002)(38100700002)(2906002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aUZ6aWpiZWYzdmY0TzZhMU1peCt4TjZ6UjVkc2lzY0RyY2tNb3ZvcjdFYXZK?=
 =?utf-8?B?V1I3a0xvT0lCWllPamxacXBNcWRmNEVFcXUwdFFXa3dZZ2hFV3NlMk5aaHp5?=
 =?utf-8?B?QURYSC9rSDZjNW94OHVROW1KZkVDSHpHNVcraEkxTDY2WmYya0hGeUNTV25i?=
 =?utf-8?B?UExhRjB6VHEyNzdrbG5tOWZwelJzempRQksrVW81Z2lKaEgxVjRORHRnOE5H?=
 =?utf-8?B?eGVmOXF1MTZDUk5nNms3SkxyUE4wQ25JdW9IRnlSSkhCVWVjZkZtWTkzU3NY?=
 =?utf-8?B?cEtha2FOOXE5UFU3WDVjL2JGVlNwWElrbm1sNkozZVoyLzRKUXAvNG1Mb1kw?=
 =?utf-8?B?R3FvTkg3dnR4dmJGcDNmSlU3ZHNzRzhUb2ZqdWJMSEtKQ29iVzByZTkrVlRk?=
 =?utf-8?B?OWpkK0dFa3RjemNIY2RVRVFhVXYzL2FsSGFVUGFUWEdQanZESnVYQ0xZVHox?=
 =?utf-8?B?NWtZb3dZMDRUU3RvUHhOaXpCczdwbTBOU3QwR3BxMXcwOWxQc2tURHNGSGsz?=
 =?utf-8?B?NWVaWVIxVmgreHd4anc1Nko4ZW16U0RrMjVyS0JKa3hoLzlwQ1NRSldEQlFy?=
 =?utf-8?B?akhJdUxWdmNONG11UWFnd0F6YTBpVzFIVjBsV1FXSDVNYVZnTXhxMVhnVkR0?=
 =?utf-8?B?WHdZNUpFVkREQlhxcWFFdzNIdzBzY0M1TGJNcHV6N1VIcnNlUVQ1d2dEWGU4?=
 =?utf-8?B?L2lRZDBpbktTWHR3UzdDVTBDdEZ2RXkzZHJHQytXL0tORVBVZjUwWk5JdkR4?=
 =?utf-8?B?aVRoczRxdWNqd3ZNa1lZWE5PUDg0WG44UGQ5YllubnpYd3NhMXVVZVdINmd1?=
 =?utf-8?B?RWpyNU5WZTlIeVBJd0hXb05aZ0ZUYm5zd0J6RDlreE9mbXNKdXVseW1xNjVv?=
 =?utf-8?B?dzVGWjJNNWtSYk5DTTZpUEl6cVZBMGZUSDE4bGxCV203cG5pSWYraTExR2tQ?=
 =?utf-8?B?UHpDYlJ4akFDeFdOblcxY0VDa2xIOEZta28xVlFqNFFNVVV6Y0ZlVnNCbGVY?=
 =?utf-8?B?MWM0aWZSOUxLUEhxRk9LdHFiNGlYV2ZBQS9RNHVLQVp6NDZEL0pQMk9EbkRo?=
 =?utf-8?B?eGFWeFdkM3k4bGQwU2IxRExWbnNKSk8vRXZ5a2duYk8zb1FQTkVBengrY2ov?=
 =?utf-8?B?MmZqOHhVY2RSa3VDMkRLQ1RrSGM4eDRmMXZ0bDlSMmpZZ1NyRTBpbG80VGla?=
 =?utf-8?B?bE9QY2hnNUdqNlhFN3NVMkVGQTMwMWoxWUV3VUxRNXI0SmY2RjVnTVUySE9D?=
 =?utf-8?B?STRBK3h4V0UrYlVuekhKcEFoalNQSVZ2dUErZEEwMUFpOVB2cEtWc081amZY?=
 =?utf-8?B?V1VWc3BxanRpTWt4S1VsbXRma3htWUVPNUFDQmtlT0lFVFl2N3VVeWNGaTEr?=
 =?utf-8?B?R1hxTGJQK1ptcysrd2ZrRTU3aTZRSHRtL1VuNCtMdGRxKzJiMVdvQWo3dmhw?=
 =?utf-8?B?R3RDb3dEZmV2SzYrZVpZNnRMUTkxbEdrVnI0VE5wU2l6WUlVNVAxT3FQaWE4?=
 =?utf-8?B?M1liUGw1R2VKZ0ZSbFI3QU5GUDlCNmYxUE5jTm05QU5OYUIwZWNIS01qa0x0?=
 =?utf-8?B?NlNDNXFPeGhuNk9GOEFwWkV6dXJlTEhlTUhxTkRhZkNyampNaGdHSGx2bjBn?=
 =?utf-8?B?aWtvcjA4WDFiTUlVQkdLZ0c3ZTFsMGNKelpJTDhtRkphazBJdXR1SUNERHdV?=
 =?utf-8?B?WG80MlpxTWNmdStsMHpORnlZRWJtMEd6aXc4ZWo1eWVrWlkwQi9EdlIvdlI2?=
 =?utf-8?B?TUZ1NUY0SHRkdzhtRG5kNGJwZityOS83cGo0RmZ2K0V4Z25Iem02ZUZxRWQv?=
 =?utf-8?B?UDBCL1FZK3pJUy91M0ZiQkl2d1I4NmhZOVdXMjlNQWs2dWYzSEh2ZFNRSHd4?=
 =?utf-8?B?YWQwNS9ZTmNGQU4vd21Mc1B2Z2s2d2wrVkhmU1N4dDlGRWxQR3p0ZEhsc2Z2?=
 =?utf-8?B?dWZqM1l2L1Q2RWFXMDhnNE1UQzA1T094Ull2RW1VZ04vU29TTnRYWW12bWcw?=
 =?utf-8?B?NVM3NW1uSG5Bekt3S2I3WmJCVEttdmdxQUh2UWZCQzhFOTUxT290eTJzM2Fn?=
 =?utf-8?B?NktYNzlHU3IxSnMzbEcrd0hlaE5keWlGTFZQcTZxVFphZWxCaWovaS9EY3BD?=
 =?utf-8?Q?qQoCFWD7qoZR8GK3vlhKMz9nh?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5bb1390a-95e3-42dd-26c3-08da822e8f01
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2763.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2022 22:02:50.7232
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uix37S1Xe3dX1zJRn1s6LIvWucSgLjTsyIBEQBei3J3PzRZSEQ80JIK7Gl5WeRdJUjOu1dIEpFvPTGTw0M5ykg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2920
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 8/19/22 9:25 AM, Mario Limonciello wrote:
> The Linux-Lenovo-NV-HDMI-Audio and Linux-HPI-Hybrid-Graphics have
> been seen in the wild being abused by other vendors.  If these use
> cases are still needed for modern laptops, they should be done via
> kernel drivers instead.
>
> As we can't have nice things, mark these strings to only be applied
> to laptops from 2022 or earlier.  This should avoid breaking any
> older laptops.  In the future if the kernel drivers need to call
> Linux-only ASL for any reason, it could be a custom _DSM used only
> for Linux or something similar. This approach allows kernel developers
> to control whether to stop calling the ASL when the deficiency by
> the kernel is resolved.
>
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
>   Documentation/firmware-guide/acpi/osi.rst | 24 ++++++++++-------------
>   drivers/acpi/osi.c                        | 22 +++++++++++++++------
>   2 files changed, 26 insertions(+), 20 deletions(-)
>
> diff --git a/Documentation/firmware-guide/acpi/osi.rst b/Documentation/firmware-guide/acpi/osi.rst
> index 05869c0045d7..392b982741fe 100644
> --- a/Documentation/firmware-guide/acpi/osi.rst
> +++ b/Documentation/firmware-guide/acpi/osi.rst
> @@ -41,26 +41,22 @@ But it is likely that they will all eventually be added.
>   What should an OEM do if they want to support Linux and Windows
>   using the same BIOS image?  Often they need to do something different
>   for Linux to deal with how Linux is different from Windows.
> -Here the BIOS should ask exactly what it wants to know:
>   
> +In this case, the OEM should create custom ASL to be executed by the
> +Linux kernel and changes to Linux kernel drivers to execute this custom
> +ASL.  The easiest way to accomplish this is to introduce a device specific
> +method (_DSM) that is called from the Linux kernel.
> +
> +In the past the kernel used to support something like:
>   _OSI("Linux-OEM-my_interface_name")
>   where 'OEM' is needed if this is an OEM-specific hook,
>   and 'my_interface_name' describes the hook, which could be a
>   quirk, a bug, or a bug-fix.
>   
> -In addition, the OEM should send a patch to upstream Linux
> -via the linux-acpi@vger.kernel.org mailing list.  When that patch
> -is checked into Linux, the OS will answer "YES" when the BIOS
> -on the OEM's system uses _OSI to ask if the interface is supported
> -by the OS.  Linux distributors can back-port that patch for Linux
> -pre-installs, and it will be included by all distributions that
> -re-base to upstream.  If the distribution can not update the kernel binary,
> -they can also add an acpi_osi=Linux-OEM-my_interface_name
> -cmdline parameter to the boot loader, as needed.
> -
> -If the string refers to a feature where the upstream kernel
> -eventually grows support, a patch should be sent to remove
> -the string when that support is added to the kernel.
> +However this was discovered to be abused by other BIOS vendors to change
> +completely unrelated code on completely unrelated systems.  As such it's
> +been deprecated and any old hooks will not be activated on systems from
> +2023 or later.
>   
>   That was easy.  Read on, to find out how to do it wrong.
>   
> diff --git a/drivers/acpi/osi.c b/drivers/acpi/osi.c
> index c2f6b2f553d9..18c339c3f277 100644
> --- a/drivers/acpi/osi.c
> +++ b/drivers/acpi/osi.c
> @@ -25,6 +25,7 @@
>   struct acpi_osi_entry {
>   	char string[OSI_STRING_LENGTH_MAX];
>   	bool enable;
> +	unsigned int max_bios_year;
>   };
>   
>   static struct acpi_osi_config {
> @@ -40,25 +41,29 @@ static struct acpi_osi_config {
>   static struct acpi_osi_config osi_config;
>   static struct acpi_osi_entry
>   osi_setup_entries[OSI_STRING_ENTRIES_MAX] __initdata = {
> -	{"Module Device", true},
> -	{"Processor Device", true},
> -	{"3.0 _SCP Extensions", true},
> -	{"Processor Aggregator Device", true},
> +	{"Module Device", true, 0},
> +	{"Processor Device", true, 0},
> +	{"3.0 _SCP Extensions", true, 0},
> +	{"Processor Aggregator Device", true, 0},


Since you're going to have to update this whole table anyway, maybe it 
would be more self-documenting if you used named initializers? e.g.:

{ .string = "Module Device", .enable = true, .max_bios_year = 0 },

For that matter, do we really need to explicitly set max_bios_year in 
entries that don't use it? They're all zero-initialized anyway due to 
the static declaration.


>   	/*
>   	 * Linux-Lenovo-NV-HDMI-Audio is used by BIOS to power on NVidia's HDMI
>   	 * audio device which is turned off for power-saving in Windows OS.
>   	 * This power management feature observed on some Lenovo Thinkpad
>   	 * systems which will not be able to output audio via HDMI without
>   	 * a BIOS workaround.
> +	 *
> +	 * This _OSI string is only applied to systems from 2022 or earlier.
>   	 */
> -	{"Linux-Lenovo-NV-HDMI-Audio", true},
> +	{"Linux-Lenovo-NV-HDMI-Audio", true, 2022},


Oof. I remember this one. Setting it to this year seems a bit generous, 
as IIUC systems haven't shipped with this feature in a few years, so 
there shouldn't be anything legitimately needing this key in recent 
years, but if it's been found being abused in the wild as you say, I 
suppose it's safer to not break things, even if they're being naughty.


>   	/*
>   	 * Linux-HPI-Hybrid-Graphics is used by BIOS to enable dGPU to
>   	 * output video directly to external monitors on HP Inc. mobile
>   	 * workstations as Nvidia and AMD VGA drivers provide limited
>   	 * hybrid graphics supports.
> +	 *
> +	 * This _OSI string is only applied to systems from 2022 or earlier.
>   	 */
> -	{"Linux-HPI-Hybrid-Graphics", true},
> +	{"Linux-HPI-Hybrid-Graphics", true, 2022},
>   };
>   
>   static u32 acpi_osi_handler(acpi_string interface, u32 supported)
> @@ -122,9 +127,11 @@ void __init acpi_osi_setup(char *str)
>   		osi = &osi_setup_entries[i];
>   		if (!strcmp(osi->string, str)) {
>   			osi->enable = enable;
> +			osi->max_bios_year = 0;
>   			break;
>   		} else if (osi->string[0] == '\0') {
>   			osi->enable = enable;
> +			osi->max_bios_year = 0;
>   			strncpy(osi->string, str, OSI_STRING_LENGTH_MAX);
>   			break;
>   		}
> @@ -225,6 +232,9 @@ static void __init acpi_osi_setup_late(void)
>   		str = osi->string;
>   		if (*str == '\0')
>   			break;
> +		if (osi->max_bios_year &&
> +		    dmi_get_bios_year() > osi->max_bios_year)
> +			continue;
>   		if (osi->enable) {
>   			status = acpi_install_interface(str);
>   			if (ACPI_SUCCESS(status))
