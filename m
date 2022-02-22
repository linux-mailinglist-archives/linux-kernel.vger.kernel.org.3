Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0150F4C0202
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 20:26:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235199AbiBVT1A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 14:27:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230047AbiBVT04 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 14:26:56 -0500
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2103.outbound.protection.outlook.com [40.107.236.103])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40841A6525;
        Tue, 22 Feb 2022 11:26:30 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h5Ni/rJiHrdI+3Hez9cJekNwZApb8T8ovOKMWmpOOrGoqCtLgEHR/00bJRSzcMweMq2X7n7qCqYJddj6n9U3hUNmOv0vYGLs2XM9dhiLpnfuaDOlFFRhCVQsvBnxAbKjLVQwQGjQc67mDcJc03pZaLrhNFYw5yb1corPEe9Wbq7LyohAxYZoKCVyoFCaXFt/k0i5DcJO7QvxQm91sYVyl3dwbOLMbE0497UIYTDasZtz3qy9SxWW0q8SdN56WyMFjfGzqZPGaHIayLRazgtzT+7h3zvElVZAC7IzRxip7No2PlhlxiFX0KjP44FeGwVa0WA5ILWsdVpCcpI6qlIcxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XtsBZAh045T9CLJ/h3vHLS7uy0QIH6cTJxybv2ZVNn0=;
 b=gsgQHi8WovEvcyFYEFnmwSljA6pSDCsqZyjpjgef1QDtgPFcq2n4Tf/NYP78R6hck/dRWWVRO7ilBd4Wuj+xpzjAzF3i8EX86neU+z9Gyez6FKql1BbY/OV8tMTm9UTXxEh4GomatvznBm+BAhm8v33SfrGmn4iJqcZ/kt40lImIPE1ECGRFhxruF4fjFF92An+G8lAFp9mF9zWAklHExh1sDpvTy64ruG554iJaPOGtQfGzjPjjf2IIzftG8qOnsZ18MCcQbGwlB84ytjkrX8uKbDw62/SFHTPDvHSSOOd9RRBkTB5QteBoWRGBRGKzQwWD1CsFeCEbkWnALgT/Uw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XtsBZAh045T9CLJ/h3vHLS7uy0QIH6cTJxybv2ZVNn0=;
 b=k9VhrFkukdeK83inOUs8I1rVyXg83iNJ5iKuuFAT3VX/Wa/kSOvfwqlMiqhg0d8jS1kBPm78C7/PDcu7Kw5APgFowOtvo8NzMm76WO94f70+yqWcxizCla0ttDMH7XC2q0CaLClh5njnKmcEt/c+qEsb9obtWeDz55cMqTVhoGo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from DM5PR0102MB3590.prod.exchangelabs.com (2603:10b6:4:a4::25) by
 BYAPR01MB4552.prod.exchangelabs.com (2603:10b6:a03:9e::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4995.24; Tue, 22 Feb 2022 19:26:28 +0000
Received: from DM5PR0102MB3590.prod.exchangelabs.com
 ([fe80::e085:6acb:773c:c3e7]) by DM5PR0102MB3590.prod.exchangelabs.com
 ([fe80::e085:6acb:773c:c3e7%3]) with mapi id 15.20.4995.027; Tue, 22 Feb 2022
 19:26:27 +0000
Date:   Tue, 22 Feb 2022 11:26:12 -0800 (PST)
From:   Ilkka Koskinen <ilkka@os.amperecomputing.com>
X-X-Sender: ikoskine@ubuntu200401
To:     "Rafael J. Wysocki" <rafael@kernel.org>
cc:     Ilkka Koskinen <ilkka@os.amperecomputing.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Hanjun Guo <guohanjun@huawei.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        Len Brown <lenb@kernel.org>,
        Robert Moore <robert.moore@intel.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        patches@amperecomputing.com, scott@os.amperecomputing.com,
        darren@os.amperecomputing.com, James Morse <james.morse@arm.com>
Subject: Re: [PATCH v5 1/2] ACPI: tables: Add AGDI to the list of known table
 signatures
In-Reply-To: <CAJZ5v0h7hCQLQP7-uF+Zh6Yx11AxxYK3rjLS17XHfA17z8fR0Q@mail.gmail.com>
Message-ID: <alpine.DEB.2.22.394.2202221124460.13671@ubuntu200401>
References: <20220215035553.102315-1-ilkka@os.amperecomputing.com> <20220215035553.102315-2-ilkka@os.amperecomputing.com> <CAJZ5v0h7hCQLQP7-uF+Zh6Yx11AxxYK3rjLS17XHfA17z8fR0Q@mail.gmail.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
Content-Type: text/plain; charset=US-ASCII; format=flowed
X-ClientProxiedBy: MWHPR17CA0074.namprd17.prod.outlook.com
 (2603:10b6:300:c2::12) To DM5PR0102MB3590.prod.exchangelabs.com
 (2603:10b6:4:a4::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 92da39af-643a-4516-e758-08d9f63938ad
X-MS-TrafficTypeDiagnostic: BYAPR01MB4552:EE_
X-Microsoft-Antispam-PRVS: <BYAPR01MB455205EF5D8782C55E6737489D3B9@BYAPR01MB4552.prod.exchangelabs.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gyBNDc2Og9d9YGO5OGjo36OopCiiwYGLz92hO4W0Jh+7sVvb2m/5p/YBsyCrtHQps/BE14FtiUU38zDktUm2scrAhlDw84hpHCbOHnVmgJFv+OTQdqmbc638+c0YU9atBHtodVaQix90lHGO6G4xxyH4y0I4+xbyHRYDQjPa7eXEcdZzAhbCRiNAOy1544LDAxX34rMHYXNBApSlI1Rbyn1e3eyPThbjGgkLQag24L2mqXwgv4gXF7Bv1c58aVrzcHjsCejYwClu4fZHV/t1EtM07XBNbeMe+jRz5jkf9DFFYIUCGfuxj4I4I6scdQwpQ/I9ju3nbILmoVljRk6FYcIIcTsL9bRSvnWROtvBYNVjm8IkGfyImwzQB2wfTT7xxYo558QWoEyfwHYC1VtfMvg81+KattAsFduC+GyUp5F+KCt3f8sYw2oMAyaPa2kLVplqOMca33DXeAadWCrkbFkfFDtCTzLh1f/gY/dAcGFRSKGrkpuuvr0wK/ydzEDqK75ZNP9TNLyw/QjbideiwAtwIU513aBEm2/JyG+4glOt4l53aGVxjD5FycLTtUXbw6MnO7a94qtGVXyr/NbF7CEkbWcC+SLMWlAu/PhHyZgTrFnWgN9/Izt87GalM3V5x6ofWKMFegEtUz9mJav1ZeADWnSFqV7Na/NG3gpbh7QW7ZxVfRbKFItKtOjMXmLxAaib+2oFhNP40nNJKTvLOQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR0102MB3590.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(7916004)(366004)(54906003)(66476007)(33716001)(6916009)(66946007)(26005)(8936002)(86362001)(186003)(5660300002)(83380400001)(7416002)(4326008)(8676002)(66556008)(316002)(6506007)(9686003)(52116002)(6486002)(6666004)(2906002)(38100700002)(38350700002)(508600001)(53546011)(6512007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?9HQHvNZPc1WHvRo2BTJMNvW9g4o/M0NZcOiqHicZMYpKlegs08yelIhP+BBy?=
 =?us-ascii?Q?p2H/VwM0nS+YeV2E09e/bzE9p4c2Cxg1mgVmvEhYp7Uw8TsbOaVbkaP1Lzaz?=
 =?us-ascii?Q?AeHF03wumnUV9E7fj0fDySxCc3NkYORyjbzZzjYiWhrdOqc78dekFoVK4bRX?=
 =?us-ascii?Q?+xl53QMNdG3SZz8YjX3vFNXpQVJmTFVZG7A+VwNS+uD2yaEgitYMU8dl5fPM?=
 =?us-ascii?Q?w61Yqi2XnZD7+l51mCqnmi2Re7TQMXy1gV7O2tHj/jU5WIc1Ksb+nG1kbGKE?=
 =?us-ascii?Q?zhVGLfmSYWRU5W/ASYbYepDJPLFEOQjWP6oGB77Oi9cz4TAiYBAMwvyIc0L2?=
 =?us-ascii?Q?xJnpe1zbDFoSW8TkPXIossPhf5rbMrsz53LhFDC8U/TQhTIuIr7sCbKhcGTt?=
 =?us-ascii?Q?G6XSxOMZ+PGLPNy4xev29mbpuv+7xacBbTYmxS//4Jt8niDOi01U8nU4Zx5h?=
 =?us-ascii?Q?yC5vniAPquKfmJEvFycaLn5qQAv3yQddyyleCm9xZXe1qomU/33QI1WlW2Hv?=
 =?us-ascii?Q?yZadjh+5033WK4hjLaraC7OjdyZoKUDgji1876R7xYVOK40MVzJtTuFQp3o9?=
 =?us-ascii?Q?1Kb+oHWZRsKs0aX8tkXYsbIFT2BhMmT8UbKZXuoOFRuPfGWBBS8aVY+EI4JW?=
 =?us-ascii?Q?xfjTfm/DCQSkBR/RPTsqcUfrQKUxE8QCJeEPXjQ6aZBzYZHH/9C2Hf/oZkhP?=
 =?us-ascii?Q?rTF7NciXCYes4Du5uvtpdmnzUmIrctIJ5xDKsAEGUZmc5yg28Hmqhkdgb54P?=
 =?us-ascii?Q?xQg1/ot53rtcWknrEYG80bvKPT8nqdY7/tLG+kb40y/iG9gfETJDl+n91wu9?=
 =?us-ascii?Q?fNJm1msN5Iw7lkll3aj4RTeTllL3rIBT33GzJ5QWJJRy8xDkfZJD0nCXAu6U?=
 =?us-ascii?Q?yVtN5f0L57QYj2e8gABrVqFfz6qJpNnrz9VTTCwWep7+hGgZzq5rWzp1AmGf?=
 =?us-ascii?Q?lDl1Q3Dsp3juwZi+tviYcSMhQ/K9DHVlmaIZIV286UQZ0awXMikPxC1EdNgU?=
 =?us-ascii?Q?2LgUqB8y1J1/gPV8ssajUy8yu9uNK0TFjkAAFnv2AUFKrr6sOys7CM8mJsNP?=
 =?us-ascii?Q?b++KCLE98WUl/Q9YCwF3u3j6Jr/qwpmNVEsbKKDM1bkSfZ4pguPleR+i6Cma?=
 =?us-ascii?Q?703OBCSegn2ZVLy6xC7QmppLig766rL2GAFfqthzxJ/vIswHtddmm8JCMiJF?=
 =?us-ascii?Q?qcwBnicUoBWPAiaXAqiPldBz0nvfes9qrXlz0X+JBOGNxyOWTQlY7luFJfJa?=
 =?us-ascii?Q?6ocTa0x6Li49kGCfMpKD78FC8rCzgY5Gvqm66py9G2mvAwp9niC/zW0dDu3X?=
 =?us-ascii?Q?xH2qtRwWE5+9fuZaQREY1LIXd0jnXaKezL4t4LWkmBCQtYj2/5P40TNw8jNJ?=
 =?us-ascii?Q?FhHmVi7BlCb23ZZEZe/s0/ZeS3itFRfdInYmO9fpwPe7o7vt/kPSelFaLKNC?=
 =?us-ascii?Q?CF3iEi1Yh935fV9YiIYel7JZGWdFe0oeVssRMl/F4lltoZu3K/ouMswDfFQt?=
 =?us-ascii?Q?d+mYXXwAaF2uCw9k5udCT9UqjfYPyjvu3thLq2AV2126VGP5tUG7iJ3yJD1g?=
 =?us-ascii?Q?69hXw7yfBVdp11wESrW8iAohFxByjXLtUFyn6pwXlSdOEii2DOecCSo7nMwz?=
 =?us-ascii?Q?O6oLnzfZtz3sLe2vnXDCbxeMPGYOQ7wZQ2LutkJY4M2YSRjcKr/AOLx3xJze?=
 =?us-ascii?Q?JcpZlir0L9XAQGpz0mOmExfSbXo+Tx4NddnmcW2c62Dpc0Sx73u/DGqrgXoo?=
 =?us-ascii?Q?bfWaBzZIIQ=3D=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 92da39af-643a-4516-e758-08d9f63938ad
X-MS-Exchange-CrossTenant-AuthSource: DM5PR0102MB3590.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Feb 2022 19:26:27.8500
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XjLshPQSbGDQyhCDDIiyhP1Nx9SVqDJ6vXTd947SnV00jNXmJMH5jgyjGhZFEdCxrVWY7OweJr7kkYd4i1qFbJM2PqjVmo20uhWhzh6Hh6LV9TX7TV1w9Ur6Ohra0Rin
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR01MB4552
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 17 Feb 2022, Rafael J. Wysocki wrote:

> On Tue, Feb 15, 2022 at 4:56 AM Ilkka Koskinen
> <ilkka@os.amperecomputing.com> wrote:
>>
>> Add AGDI to the list of known ACPI table signatures to allow the
>> kernel to recognize it when upgrading tables via initrd.
>>
>> Signed-off-by: Ilkka Koskinen <ilkka@os.amperecomputing.com>
>> Reviewed-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
>
> This is fine with me and please route the series through arm64.  Thanks!

Thanks for reviewing! Sounds good to me.

Br, Ilkka


>
>> ---
>>  drivers/acpi/tables.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/acpi/tables.c b/drivers/acpi/tables.c
>> index 2d7ed7126faa..ae29b13b8774 100644
>> --- a/drivers/acpi/tables.c
>> +++ b/drivers/acpi/tables.c
>> @@ -545,7 +545,7 @@ static const char table_sigs[][ACPI_NAMESEG_SIZE] __initconst = {
>>         ACPI_SIG_WDDT, ACPI_SIG_WDRT, ACPI_SIG_DSDT, ACPI_SIG_FADT,
>>         ACPI_SIG_PSDT, ACPI_SIG_RSDT, ACPI_SIG_XSDT, ACPI_SIG_SSDT,
>>         ACPI_SIG_IORT, ACPI_SIG_NFIT, ACPI_SIG_HMAT, ACPI_SIG_PPTT,
>> -       ACPI_SIG_NHLT, ACPI_SIG_AEST, ACPI_SIG_CEDT };
>> +       ACPI_SIG_NHLT, ACPI_SIG_AEST, ACPI_SIG_CEDT, ACPI_SIG_AGDI };
>>
>>  #define ACPI_HEADER_SIZE sizeof(struct acpi_table_header)
>>
>> --
>> 2.17.1
>>
>
