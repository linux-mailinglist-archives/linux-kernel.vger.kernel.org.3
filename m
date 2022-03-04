Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4CE54CCD55
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 06:32:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238199AbiCDFdi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Mar 2022 00:33:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231272AbiCDFde (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 00:33:34 -0500
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2101.outbound.protection.outlook.com [40.107.223.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 099014AE17;
        Thu,  3 Mar 2022 21:32:46 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y9YwPjG5rEPm96ySXcxNlbMjaZ/kLX7SJ9B0766OuhXCtXA8NRtM/VO/iLbIDolMUguVM2z1b5Ukd8o892DYcIqlJTixcaN4N1CcAwsLfvnDkz0MgI8F3AMAzZ3mMFxFqdKvvmqQq2KMjdtPyLPcGcSdLPoN2M9xPj9Qc7egy+BQ08zt1wCynXJIVrk9c3eSWrybvkwqa02BdiexHnj8sdX/jKDT4Tzy6bStCQ2UiQgYYw+/ipqemLc5p6C20jvS6yKaGSwqJLA68/omajINYCzjNgLoXJ7sL8/S9xWT3pY9NqL3qj2DMJJs+ix6rJu5W/fWnPuyzEBsyBAQ5vRjPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1IJ5JIoA7UgnECfm8JS9UcCWTcoQuUdDFZ1D9lglx5s=;
 b=nqdX1Jg/i76BF+0wyMam8QLwv6e8j9n9UwJdOq4k0SVfG1BF1DWgnjQvDvdsp+LKphVq1iMQia2jlF1h/QwaXkDxvOrFeFTa868u3LQpV9rZF1z13vQQzdBmuDO62/6qGsEFxoGUsUeUhlvZFDJczH7L2qbn46NvpEhGbLHSyxKcE3pp7d1Bq/6OUA6vs5hbHszE8imevfUcsgIeUg1N5Po4WtovtOms74AvTltt4xtR+o6hGmHNja/RCw2tj3cfxwr5J2SDtYgDo6U+kA29BoRYUFF9edU39RZ1VcalkXJg1yRNZPbfOTdkxQF3/SNNj36IWV2Km2zP3X5jvwtL5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1IJ5JIoA7UgnECfm8JS9UcCWTcoQuUdDFZ1D9lglx5s=;
 b=K950M0Dj1oCZC1niok6SXQASBke9XG3jwL6E1FfAXbkctm2wtlR863Kp8qHqXL/696uhdYAlbNVEHC5emUj7Pj0VsDSR+HwX36Z8Frt9QLeTddDYx+gey6z5g+sfDIepGSwi+aGsQ8JHxYDvFZT6woRS/NLTDcIPZ1yKH0zjvLI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from DM5PR0102MB3590.prod.exchangelabs.com (2603:10b6:4:a4::25) by
 BYAPR01MB5399.prod.exchangelabs.com (2603:10b6:a03:11c::24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5017.26; Fri, 4 Mar 2022 05:32:42 +0000
Received: from DM5PR0102MB3590.prod.exchangelabs.com
 ([fe80::181b:1522:26bc:c243]) by DM5PR0102MB3590.prod.exchangelabs.com
 ([fe80::181b:1522:26bc:c243%4]) with mapi id 15.20.5017.026; Fri, 4 Mar 2022
 05:32:42 +0000
Date:   Thu, 3 Mar 2022 21:32:26 -0800 (PST)
From:   Ilkka Koskinen <ilkka@os.amperecomputing.com>
X-X-Sender: ikoskine@ubuntu200401
To:     Ilkka Koskinen <ilkka@os.amperecomputing.com>
cc:     lorenzo.pieralisi@arm.com, guohanjun@huawei.com,
        sudeep.holla@arm.com, rafael@kernel.org, linux@armlinux.org.uk,
        lenb@kernel.org, robert.moore@intel.com, james.morse@arm.com,
        linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, patches@amperecomputing.com,
        scott@os.amperecomputing.com, darren@os.amperecomputing.com
Subject: Re: xFrom e2ebdef7c3a5e7ba998ff20bf62806c388efeaac Mon Sep 17 00:00:00
 2001
In-Reply-To: <20220304052241.151946-1-ilkka@os.amperecomputing.com>
Message-ID: <alpine.DEB.2.22.394.2203032130410.2294@ubuntu200401>
References: <20220304052241.151946-1-ilkka@os.amperecomputing.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
Content-Type: text/plain; format=flowed; charset=US-ASCII
X-ClientProxiedBy: MWHPR15CA0037.namprd15.prod.outlook.com
 (2603:10b6:300:ad::23) To DM5PR0102MB3590.prod.exchangelabs.com
 (2603:10b6:4:a4::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3994eb76-5931-4a2a-3423-08d9fda06759
X-MS-TrafficTypeDiagnostic: BYAPR01MB5399:EE_
X-Microsoft-Antispam-PRVS: <BYAPR01MB5399FE74EBFB0CA78311D2519D059@BYAPR01MB5399.prod.exchangelabs.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: alli65nCdu8kEaRX97TjV5mAymCg3ND2/G/twvmVuJ36GEos+nebNE4GssrvZ9tdlCg0eO12t2E50vUPvi7uzufZnzjzqirNqleqVQgFJ6RLAgb6FBnG65hKcaIShXGYkOV/Rakb9cieTAxDsTLBR+nD1Yh9a1Qzon2tudyisM+TCSaqrOQPyW6Gth0O1A1BL5ylPVKKj+FNp0FJ1XuUVQl+DakumCrU3hOLLMKGXaMRc7LGJAeK/E5UWYrpwW528K5LUOV2Fu3Rk4FOgI4wGjXl6aQNtmtFUq7ECeF9oiTZmpA9Hme+Mvdwv9Oi5vjjV3bhFASCLIOhHxwOUeaoWAADPefGdKiAEz7FfyBkKg35GFIDPXLqcFlwlvIBsnhgntULhbxKItCH/3CTZw8e7GSjtvxtnvOLD534G4iCVtt17D89iI38JGnP9kGGv8a2Y7hpC7cpboNjzTXEVae2QgHyJqrYWz+TEo2PHHOnMJgfMB+uowqK0x0sM3Q7sUw+3GQ34TIdCzZxkEqsYYoLccQ4mOmfmKYwJHurF3uYGIlRyLq5g0SH8w2Cd8nVulAI/e/zaRSeZFIJ+U0otxlt3XWdDuPU447j+X3cNoHXPw4oiDt3EmpQwD4IH7Modq/I2AdCv39AJVk9n9FAE3cVEv2oEF3rqqwao0UTkPyXILwd9odQpWXyfpxmQvsNUVW5c5v89ZrADhb0hA7vrpLFyaA3MMPzn7yAaPwcSwBgIgZiq9dUaQJq+iDKKwtcS1d4o0PF0uDjR6WvB0gJdMaFoopDIEoHpG5idU04YClYBxo=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR0102MB3590.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(4636009)(366004)(8676002)(316002)(83380400001)(6862004)(4326008)(66556008)(66476007)(508600001)(6666004)(9686003)(186003)(26005)(33716001)(2906002)(107886003)(5660300002)(6506007)(52116002)(966005)(8936002)(6486002)(6200100001)(38100700002)(38350700002)(86362001)(6512007)(7416002)(66946007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Gha+3Y6YfsBr3MFJHPHdTXubj/weOfts3+CWKpDVMwphdf9e2fWOV92lwOKd?=
 =?us-ascii?Q?RN2BLjiIKp1mEEWuyGIkXN+J0bizQdS58FSQhPwKFodlPi4h8iJFXp8PSY2Y?=
 =?us-ascii?Q?+ThsVeRUnuc0Wk6hM6TUh0sOznOugoqoAKHJvqF+3WbSK4/ISUUu8eVBA1T7?=
 =?us-ascii?Q?1lgv3JProz4In4SbkjScZpDnaIZT/mwNl+Onua+MVzC3DbuIEa/32Q+tM/ex?=
 =?us-ascii?Q?j8XHUGYUunmaxEidQO17acpoSc/ZCNncbOHaXrWXnUVAU0RvcJhcnScyBhN0?=
 =?us-ascii?Q?vdrFE+3rKO14h29Dc6dBc4OxZ5XGM5U7XhUrgYCKhtskbuQMVBLf/1A81u9i?=
 =?us-ascii?Q?UNjefQBzzQyYfwNm2UU8PV5/iyqCZbWAFPg2G5FFMMkClCz62kxibeR3fsF7?=
 =?us-ascii?Q?39RDDK5/YLHHwv2zkfIgb0JDRMRlVkzSMsPhnH5sMbGpWJpnIf1m5T+ddM9X?=
 =?us-ascii?Q?yMLsLyNYnSuGgSKACMqcIbAXKLVFbcOzGl2S9Ex4PEd4TANHk6HpGL/cZ/Yr?=
 =?us-ascii?Q?AsRoRIyq2ejKAHAg+D8D5+xB5eQqGzvmqybbMsLW82EXcBZf7wio1f5KVETY?=
 =?us-ascii?Q?pGfrmBYUCUArgspcsTTpZL6jr64Mj6snS4IQA8dLJ4TZTd3uPpQorxy2DEtv?=
 =?us-ascii?Q?p8Dak7KHUveUpK/z6oRU15SlREbjbJ3VwATfqcbX9b/L0U0HWf6pLi67gyI0?=
 =?us-ascii?Q?v/HvqkEqznzqlodlotCoXwPJZdfqHNCMBi5qH82BO79BJl46vXkUthlWHGnA?=
 =?us-ascii?Q?dMqGb/NlMQprAdMn9UfyohPk9sRPS1QnAn3AwGIzoU+P1eaxlsox89oeIj7P?=
 =?us-ascii?Q?cRAFXZ86wgqaG0US0n8JLZTasjOgPLFa0BoGUH6GWPTtMfUCRVoK9Mp+yQpa?=
 =?us-ascii?Q?vI3qngicSLz5DEIPSjoQRfWqYzgkuR59k6U2AdFSQyxopufkmxKn5WVmXH33?=
 =?us-ascii?Q?Koo5R9AsnU3eIZjAOu1GbCqjIZ3bpKhnSCLUJ35Elr3I1B93Xwi3VEjOLtie?=
 =?us-ascii?Q?ev9XZW95uZhg4W3JobbWP/3ZidNGU4Kd9TxQHtvIVuCfO+swJz0zRdaTB6VX?=
 =?us-ascii?Q?BuO0LGtq5l5QXt+F4F5KhLo+oYrnd0JjmbfRndMWRBRfWLEISlb5GfuFcrk8?=
 =?us-ascii?Q?+6p58OdZdE//o0Dawg2/A3dOA8VkaqpmZ5d5S/GWEdVnoGjLLooP82OdhoUT?=
 =?us-ascii?Q?4Uk605znRpp137ES0NCNwISs5rhBgfBYpPyVPQBXWHsLYtBnc9YK+llg0phV?=
 =?us-ascii?Q?TC5/dfafDpMDSVAc4V1SIUvowvxRdMgaIWuOqyUs3lZxKZ7waciGRKKkRDad?=
 =?us-ascii?Q?ebu1lIhrVc+HCxBjQ/IjgNeOBtU5rsVukO6hGRWRLo3VbVqMN5WPKzy5qps+?=
 =?us-ascii?Q?2Yrl1x1VkzcMV1iHlXsvGdCX0ec0NGfnkVnywPBvWHq/pA7pxWOQrxzSrsao?=
 =?us-ascii?Q?56sq0QK7/XWLcoxEJSNyp4Lm2pz5Mf7YneDrRSb9L5OOVUv9B5l9kCtmMIBG?=
 =?us-ascii?Q?TmMyZTduD4vrTMzV1bWIdqI81+mh7QvoAFeV1+/L5B0uyIRHXtbp5dTxu/A9?=
 =?us-ascii?Q?kvEnBAkpdW+BtdsacQTeDxUF/fa9XaxdYjo0Y1p70gV8RFZiQ536P6wEQS4Q?=
 =?us-ascii?Q?Asb5AxPQuNwbgKkefDFNuNptnewOk1hdOIflvVes1XdCYmle3LAiSwzs1ygC?=
 =?us-ascii?Q?NCZWE8G6ZYB+WdBfhM7eXwDWqSQloO7rZo8sTLc87U2ISDSn/pUXr0+ncoPh?=
 =?us-ascii?Q?VJ/WIV555g=3D=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3994eb76-5931-4a2a-3423-08d9fda06759
X-MS-Exchange-CrossTenant-AuthSource: DM5PR0102MB3590.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2022 05:32:42.2160
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: U2innuwPG+N7UVj0LR2QyEolI0hLZkHXfuanfAa5bl1yEozn+VBm3Qs1zg2bWQmEJ6apvxO4SOwrsw4Lesas4aVSWXu9jARdohfTjA7ZVs+JQEJfCyG0pjuIQhTsqAjc
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR01MB5399
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Sorry about the mess. I'll resubmit the patch set.

On Fri, 4 Mar 2022, Ilkka Koskinen wrote:

> Hi Lorenzo,
>
> Would you prefer this version, which doesn't have platform device/driver
> any more?
>
> --Ilkka
>
>
> ----
>
> Arm Generic Diagnostic Dump and Reset device enables a maintainer to
> request OS to perform a diagnostic dump and reset a system via SDEI
> event or an interrupt. This patchset adds support for the SDEI path.
>
> I do have a patch to enable the interrupt path as well but I'm holding
> it back since AGDI table is missing interrupt configuration fields
> (trigger type etc.).
>
> The recently published specification is available at
> https://developer.arm.com/documentation/den0093/latest
>
> The patchset was tested on Ampere Altra/Mt. Jade.
>
> The patchset applies on top of
>  git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm bleeding-edge (9db71e8e3027)
>
> I also tested it works on top of Shuai Xue's new patches in bleeding-edge branch (c6f4ba2d2b9a)
>
> From v1:
>     * Moved pdata to the stack and dropped unnecessary kzalloc() in agdi_init()
>     * Changed the ACPICA patch upstreaming order comment in the paragraph above
>
> From v2:
>     * The first patch was split. The most of it was merged to ACPICA project
>       at first and later ported to linux-acpi
>       (fd919e37cb15914c6fe13e13d530a4f732407c6d). The rest are in the first
>       patch.
>
> From v3:
>     Fixed:
> 	* Moved header files in alphabetical order and removed unnecessary ones
>
> From v4:
> 	* Platform device/driver stuff removed
> 	* acpi_agdi_init() call moved from device_initcall to acpi_init()
> 	* Slightly modified Kconfig text to keep checkpatch happy
>
> Ilkka Koskinen (2):
>  ACPI: tables: Add AGDI to the list of known table signatures
>  ACPI: AGDI: Add support for Arm Generic Diagnostic Dump and Reset
>    device
>
> drivers/acpi/arm64/Kconfig  | 10 +++++++
> drivers/acpi/arm64/Makefile |  1 +
> drivers/acpi/arm64/agdi.c   | 52 +++++++++++++++++++++++++++++++++++++
> drivers/acpi/bus.c          |  2 ++
> drivers/acpi/tables.c       |  2 +-
> include/linux/acpi_agdi.h   | 13 ++++++++++
> 6 files changed, 79 insertions(+), 1 deletion(-)
> create mode 100644 drivers/acpi/arm64/agdi.c
> create mode 100644 include/linux/acpi_agdi.h
>
> -- 
> 2.17.1
>
>
