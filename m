Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04B654A3594
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jan 2022 11:08:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354351AbiA3KIL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Jan 2022 05:08:11 -0500
Received: from mail-os0jpn01olkn2082.outbound.protection.outlook.com ([40.92.98.82]:26868
        "EHLO JPN01-OS0-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S235274AbiA3KIJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Jan 2022 05:08:09 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VFUs9L2bvpOQDIQFsk/4qSCT2Enth3ZfnKRHzrc6UShEyOp+pXcyzji/ybsDY4H/wT5oVwpyBO0vyzQlzbIqyEPG+sSMT2U9Dhpm7/YlRBVoS3az6F5pxp0GfORmoTDBl4yLdcs/SGiEcrRXDT0U1pzWYIlO01C6FTGIHqfZbVEPMnD9RWApdMvOPvzjQONeiq7leYCCcdFZA24p89DDlAPsM2DpSeEUWT9dBaJ41ho1Yd2Dk40la8wWbRRYW20Mme91F4WVWL/djMudqmj9ifspXe7FtKZwi/IzbBBL7gHEW2rhKUlOl5JPmC9W8Pp5NFsVB0RdDGUACqb2eAYvUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Hlq0khu9T8ojMEtJvKsDUGlUfNgQOIoK2Ok+x46DlCs=;
 b=Z945Ecjqar4vGoqzQu0CCYYHcWngjKhlQJSWlz7Ym6JqdatE+gad/RBJn64qaKhXk9y7t8EzQh7XD2CX2jOXCp3wKj/P1cG2bE+F6h4EPY1XED4LO1kdeOZM9fdVESPgvHnz4ydRrxqt8rsaD8VTq6wNmKn283gOzoROuAOefRiob+5Flr5Tw1/4xiU2EIfg1QvPC4cMTprXF+SJhNVoB9Ax2TazD8k54AiA7jY/EVohILERsBzs1jzYPlj3RkgRkWq3BysUK3Ggr3JPTUILeeVCU/FTaEMi/d8DnCPpUaSJeNhO+9/4QW+dtgJY7WPqF9zfR8vftXoW/YSlij/yQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from TYCP286MB1913.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:11e::14)
 by OS3P286MB1192.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:117::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.15; Sun, 30 Jan
 2022 10:08:06 +0000
Received: from TYCP286MB1913.JPNP286.PROD.OUTLOOK.COM
 ([fe80::41d6:4a04:e5c9:86a6]) by TYCP286MB1913.JPNP286.PROD.OUTLOOK.COM
 ([fe80::41d6:4a04:e5c9:86a6%4]) with mapi id 15.20.4930.020; Sun, 30 Jan 2022
 10:08:06 +0000
From:   Oscar Shiang <oscar0225@livemail.tw>
To:     mtosatti@redhat.com
Cc:     oscar0225@livemail.tw, abelits@belits.com, bristot@redhat.com,
        cl@linux.com, frederic@kernel.org, juri.lelli@redhat.com,
        linux-kernel@vger.kernel.org, nilal@redhat.com,
        nsaenzju@redhat.com, peterx@redhat.com, peterz@infradead.org,
        tglx@linutronix.de
Subject: Re: [PATCH v10 1/10] add basic task isolation prctl interface
Date:   Sun, 30 Jan 2022 18:07:34 +0800
Message-ID: <TYCP286MB1913558D9B5E5CCBB86548E5A1249@TYCP286MB1913.JPNP286.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.32.0 (Apple Git-132)
In-Reply-To: <F94506EB-DA71-43F1-9126-8FBB134F6104@livemail.tw>
References: <F94506EB-DA71-43F1-9126-8FBB134F6104@livemail.tw>
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-TMN:  [/lagy50ln3KW80qX1gtmMH+uUEG1BcUoepxYzPLJsv3a4soGkEmJjWNF44FyO+Ry]
X-ClientProxiedBy: HK2PR0401CA0024.apcprd04.prod.outlook.com
 (2603:1096:202:2::34) To TYCP286MB1913.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:11e::14)
X-Microsoft-Original-Message-ID: <20220130100734.6134-1-oscar0225@livemail.tw>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0a2e6c3b-122b-46e8-263f-08d9e3d86909
X-MS-TrafficTypeDiagnostic: OS3P286MB1192:EE_
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ew14hZtKcLqwxUG1xaQAtRJQj24UP2h3xNJ6RSFAmFZfAigjf0EJ+PlYIXaqxH0hbSkdKWNTujrvdFHECtd0Y/uRInk9g6Wu0o+MYUb+5Y/ikvHPv9324p/CR22YEEzqec1vWDLbo8K+0k6niQaNHFqFdWbkE5FyIgb/rODPZU9Tnv4HKw9Ckr5CON+g5zOrttAkfTmyBrqCZc5Bu7Wfyl8Pbwm2fq0GenUiRwlQr3ZtMVFDK97l3yVwXQ7UimeNO71yc692r8MFhfmcmYOpwqpoV1ns1IxzNanPnz/p/0oCA/Ws4tIz9rl13oISgwDSc7d/G7fiXmnDngBjzkN++er1cdpwbjwqgiOK2iJQer2xJV/j2TukU+4lqeiQMAIe9RisGoeT/Loeu51I2QI7jit2tlJ3FSevxMtJHj6B+pk8Uf1kqawjtVjRdtTH/Byb7iwxIpme5Qrfjy65p/6KzaUBENrMC7Hak/nd3ndCwFI1saTkStqcTp8Z7paHQxCqjxq2DPk3P7jz7yMog8lucxpE6gFV+HC5vxhidO8yO6z3989819Odx7wvKVnHdeG/
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?OzZ+zxuYUGSJIIiykHIUEfqWW/+0mMwboAmy1nOSu1Ci3tR4rf+0s580nmXe?=
 =?us-ascii?Q?MJy3mRZyz7qE8oWKray01R0zKLS+WeDmjiLbQY364FaFCuzvfIlGvyq32G40?=
 =?us-ascii?Q?FEAepXc0/5L/CV1c4ZgTVeH95ZaIzAXdMJAIwbaxw55LQYsx1Jcm7/t4ooWe?=
 =?us-ascii?Q?eRxyMPB2x89zYlcZ6kVIwjHyIyaeIILVjnUh4azCPbnAeLlwojZFRiapRuCJ?=
 =?us-ascii?Q?xndHjVI61TuVzyjnj0pvwwTfQx/TLHID/g+FQgUbcUNVwkCXfcU+BTK5XqRT?=
 =?us-ascii?Q?0xMi7OR/pLTN+DSovGFqVfWoG2RA8aj+qxIX6w743kQDAnijVAwc/N6UEe/9?=
 =?us-ascii?Q?aB2l/CP73zCALabe2Q93LQ1TQscqntbhkJ0wJlactHUOv0tPxs13Q/CDQzvi?=
 =?us-ascii?Q?zayPP3G9ZFYo1u2fQrwFDDPhDQ0K86Z7zLVdeehq0I+yaSvtFJx1jzJIzFiH?=
 =?us-ascii?Q?XV0mMPrL36uEX+l1GSvCQenjFcYYYhTQX2BQAcGBi8uB4dJzZ9m8e3oS3iVz?=
 =?us-ascii?Q?xYH14tJ2yEPOb7J2VHYoIiZL4wWwEN/9nUQI7uQVK6afhUVZNOU8vLE2+5/y?=
 =?us-ascii?Q?OD7KU3lPrDYn7HZsG2hFI9RiLxYsMZn8LvcON/R42gB2MKwbjOj2Kg3WhDD3?=
 =?us-ascii?Q?/J117GQ542fhcP9B7KGZAL/mclDU+UFebClPIAquy2WEiruRI2xj3DXCk2Z9?=
 =?us-ascii?Q?m8pF05xDVuCRPIUsA+6xfAlgaocG6UNSodaXThOBYkcwTcZv4z353hR6D05k?=
 =?us-ascii?Q?78kXZZtmwWkGpWaJno7UnHjePfuR6P7N7A0Miv2F/N97K07vkWRCWRQtS1Jn?=
 =?us-ascii?Q?v1vJEY7iyO/mLr9kUyTjeer1UI741w+PaXZCfYDs5otc10xCYod6jFMsW3Xs?=
 =?us-ascii?Q?AFWKM8r0IaIfld8QZqF83zvkXYR6SqiMCd4wncu4FxJ4HXO0ZhIa0UzY2/Ra?=
 =?us-ascii?Q?OSfe34Pp6g3hYwMvcy2XEQVgbTnVWTL/lp9rIHBBt4aPURIESEi35tW3jngI?=
 =?us-ascii?Q?v4p/6irrcgiLmkVsGOjGmtzzFQ=3D=3D?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-05f45.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a2e6c3b-122b-46e8-263f-08d9e3d86909
X-MS-Exchange-CrossTenant-AuthSource: TYCP286MB1913.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2022 10:08:06.6471
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3P286MB1192
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry for the mess content in the previous mail.

What I am saying is:

The function, prctl_task_isoln_cfg_get, in include/linux/task_isolation.h
is inconsistent with other functions. Other functions used for prctl have
a "prctl_task_isol" prefix instead of "prctl_task_isoln".

So I think prctl_task_isoln_cfg_get should be fixed to 
prctl_task_isol_cfg_get.

Thanks,
Oscar
