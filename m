Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5161515DD6
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Apr 2022 15:48:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359502AbiD3Nvn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Apr 2022 09:51:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234594AbiD3Nvj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Apr 2022 09:51:39 -0400
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on2128.outbound.protection.outlook.com [40.107.113.128])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CF6166CBC;
        Sat, 30 Apr 2022 06:48:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WPtH588ARqhvA8o2TkarAYyNEAjqMG2LcWiZAKfc3tYqS3xCN/62N1sm9q7D1sptsxWLGAKy4v8hoAKZBetRtpSNrXriJLu0S8veOJ2ZFifn9hXUhN9a0fpoXjZ94pm5c3RVvrGUJORW5V4WstXt4PhFiryd8UtTvmVzvWtYa3wFRTJdgiXGIngUgXt+Hcth51WrxfRyhe4JaltqKm3AjE9dxoW1gfJI83IhVs3xAglpD7LLcZiAfsVBEldDLaWSnm0OBZlA/aJBfyTDoVFaWObB90AbjbsmkddVn4SgjhDfptu8UB9POEctYLEWOpttPDw3MLfPwSKGcGXIfDBArg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M+gKlK7myVKHZqyCWusQle6tdHd9gd6nwgEnmnydETQ=;
 b=nY/N6+Be/WflNql5UrioUkKf9h9lHZY2zd5oHKgLZDCeowo4pXYSQ9o1YMv89FbXAiUNndbZsvoGesL0qXfuMeZ0/diRsxTl4nehmNZkMkrDdRdfoIOOVH25Aw5+xTWrk2tFbHHxgP0tFsT5km6UvoLNK4V2L+o/DZrFa225HN1T9g8fDBWwmGQcwvGZdvyTO/V+1t0xFvRqdgys+RKw0SwDfJJxI1m+JA6MzofemhzU/A5TZmbS8YmD2c/VafC5MZllYLdrhkMnqwRnM6dpZ1Mryz5zsvUoc3BQnFF1veCq6v2iad9nEVAdzKSDB+6Ows89OUAF/sbOY0/MBZW16w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=zenithal.me; dmarc=pass action=none header.from=zenithal.me;
 dkim=pass header.d=zenithal.me; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zenithal.me;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M+gKlK7myVKHZqyCWusQle6tdHd9gd6nwgEnmnydETQ=;
 b=G3qgDSmEblQgtvpDbcOFIV7y5eclXC4HIdzuU2oYPjFOGcLggcmg22tv8Hwh1KEaDhv1sRzGkU/4vTAqMpUpeFtagkHr1WhGLgvlLJSU+qFUlYhkYULQgjXRemtCgEmM80uWeYmRBrsadCAB8VpEuBWwS/1YGcuhLkSjqc9RwMk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=zenithal.me;
Received: from TYCP286MB1393.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:c0::6) by
 TYCP286MB1706.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:187::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5206.13; Sat, 30 Apr 2022 13:48:11 +0000
Received: from TYCP286MB1393.JPNP286.PROD.OUTLOOK.COM
 ([fe80::bd99:5c83:e2dc:a8f7]) by TYCP286MB1393.JPNP286.PROD.OUTLOOK.COM
 ([fe80::bd99:5c83:e2dc:a8f7%6]) with mapi id 15.20.5206.012; Sat, 30 Apr 2022
 13:48:10 +0000
Date:   Sat, 30 Apr 2022 21:48:02 +0800
From:   "Hongren (Zenithal) Zheng" <i@zenithal.me>
To:     Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>
Cc:     Atish Patra <atishp@rivosinc.com>,
        Anup Patel <anup@brainfault.org>,
        Eric Biederman <ebiederm@xmission.com>,
        Kees Cook <keescook@chromium.org>, linux-mm@kvack.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        linux-man@vger.kernel.org, Jiatai He <jiatai2021@iscas.ac.cn>
Subject: [PATCH 0/3] RISC-V: Add Bitmanip/Scalar Crypto HWCAP
Message-ID: <Ym0+Erz5DEnB78vu@Sun>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Operating-System: Linux Sun 5.15.26
X-Mailer: Mutt 2.2.1 (2022-02-19)
X-ClientProxiedBy: SJ0PR05CA0208.namprd05.prod.outlook.com
 (2603:10b6:a03:330::33) To TYCP286MB1393.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:c0::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 853486b2-3137-4a52-36e2-08da2ab01077
X-MS-TrafficTypeDiagnostic: TYCP286MB1706:EE_
X-Microsoft-Antispam-PRVS: <TYCP286MB1706816689531A38448334A2BCFF9@TYCP286MB1706.JPNP286.PROD.OUTLOOK.COM>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: G+eJOJ/Mj/awsD9vY2W5x1MDQdI91DefWCy2qd3jfPcYjVff1difs36b1kHDbW1vRObiEj4URKC4HXLpEJWNKp4M/DHiEZ71lLWfGB3DhaMZtBJ85roZxCwx3ivfvvqamIBho04k2t2DcY6CvXE4+YLEsStnhfRBrQkYySnNatP+R2T8tk5ZRXbgd6TvkWYcVIwLWiTjtRGoh/xKtF6NqKzinnYTnkiRdq0yc9SjDxMZOC37Pw1m5RBPvApUPIVxARS0XOCyDIOaAxaGztDYR4/W/FgQdfrKejiEzs2wjdZg1CydYYEY8xW799FFTSmLIbXxZ+S0Uq52E3jB+W+pZuZU2M3+LZqB8W7t9XDQ1qHUylHPgGPyCq+MBvyaut8pwPL1lBooeB1KqNCZ1hY3KpHU84xtfSiQGCaciqgLEysAeOYYPdG21EqJHhCTxKW6fF7aY/dRBqGWqahVWtssHGbLm0vDKTLoLuuMPuu9qeguC2PVMVONCzWhy7DERUQmcfStp3OBLvo1M9IXmBNXA2Azc0RzUUTbLzXddpeTORlrtPr9v+VQfjU3fjAIHn1AQOhfKuTdTxTsmClYpsGVhtb99ppEfq40xDtEWNYll/IZZ2RRdq1+KFQ79GB7TrLARqhs6ajgpcP3HhHl6ifcCMe4ZaEGHk95kzCDcV8uSFBOgmLzU7DRwAXkgOMe4KomHUu+r6eOfdhWnMK+wppUHqYuYWWL6LsAX8KNyfgjqDoXsa5S3F70PX5GySkZGBzFBW4IqpB4Jifzh+t181zVXzHZUc2hHyTYQrVCdsTU4CI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCP286MB1393.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(376002)(346002)(396003)(136003)(39830400003)(6506007)(83380400001)(86362001)(966005)(6666004)(52116002)(6486002)(38100700002)(508600001)(6512007)(9686003)(186003)(8936002)(2906002)(316002)(786003)(33716001)(7416002)(66946007)(54906003)(66476007)(66556008)(110136005)(5660300002)(8676002)(4326008)(49092004)(67856001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?fB7sDSH+cjlQIyzSiYme9UR9dMrVtO4h67CQgqbDsY/PvX5WvhU8I+x08nZP?=
 =?us-ascii?Q?OmbiaRtR9M6zFVNJRj8n6M8jN4YJ1IsLhUrqT/ioFQEkQlZwls5MnIS+82GT?=
 =?us-ascii?Q?b7RMZFXpUHaAKtG/UUMiRDT90G8evzneo7GptHK0+aSXPk3DSyB2m4We+JKj?=
 =?us-ascii?Q?PWMBJOH1z5B/bCgCAEPPrv9fYiqVIwnwEDpTmM02keGYg1ccbuQ+3cwk09Nu?=
 =?us-ascii?Q?J9oTxlyhO1okRWo7AtO5sa5hO2UkrTxgrvrXn5xk+8A3R/xg6SzWqxUfvibg?=
 =?us-ascii?Q?a8NhgXR4WPux/2QAntFinkoc8uEu91p+8xjar2mrYW+1sl10bAYtf7lbHJyC?=
 =?us-ascii?Q?YhC0uYekijDwglC0tqD7eqBxTgeNQdQ/EJt3oI3fAaHTWNE8Vp5Alcu5tgoU?=
 =?us-ascii?Q?yzyshBQcMuVfbRKI93crVqPX+2vPdZ54Zq1u+oTSeWnR+i8VH8nFrjAsOuYk?=
 =?us-ascii?Q?rf+hbV0rsnyb61Ap/RZC30HfnRJ7IXjQBSY7uKwlAed8piPP6Ly2FMKjiE1F?=
 =?us-ascii?Q?gX/nc7tqQZPDCc7yJKP2B5g23PCCZtCUsEXBr/Ggm/Jvs+Q3U2l9lM3PEfDZ?=
 =?us-ascii?Q?Zi16fDIsIDItva+boLdrrBPj71W+XI+/WTqsiEW1O3iEGSt/BLuQUIlE7dud?=
 =?us-ascii?Q?CS1aXWdtw3R5AnQzK7pL3KYzkA1xpzHpdsg5OyNWKop26gXbTiGD/ufg5wJ8?=
 =?us-ascii?Q?0NHjvfHHfxtKCzaGfp5RE6DU+gRGnHdUYur1aus0rfWs9HcslviAyKfY4/iW?=
 =?us-ascii?Q?+hEJ+ExndBoIrCg4oaUP2dwUk3o9pQVhUrPcSiGxsR0jdS/Bcmw2D4qU952O?=
 =?us-ascii?Q?Mf6UiGKrCE6z0rWKWKec8GF86t6Wp18dZ8X5Ag2TkfwzRBnWgDCPbYUtAkbo?=
 =?us-ascii?Q?LEDmO72PLBBtx9h6lfKfnizamx9rcYrN6mcWJPHVYTAlpGual2tR3C17UMD7?=
 =?us-ascii?Q?RPdHQ8G92GDhQmZ7k7fWOiTaho65BMw+DuFabj0aZr109450rxthEjtNWVBf?=
 =?us-ascii?Q?gCdHwfN2QcG2wBQvRpCIIoLSchYe8JmP0GJNCkiIHKt998JEBoUrdGYGHfFx?=
 =?us-ascii?Q?3QDDEFz1gi5KkxTVTUQsvTHfdmNgAa3SYgdvnUSh4HYwMNHt0a4o+Nar7XWn?=
 =?us-ascii?Q?0G3uJJ9GCXbpW2G+rsm47Btz+Vfl/7a4Kg07ptYQ6lF8+xZtwvNjRlYdj6sK?=
 =?us-ascii?Q?fyIeYEndh1EBesCsEYbcUkvSlcFzs420cnpNOhfnpKFQXR0JWqbWb/jJnHrp?=
 =?us-ascii?Q?POz/ScjJ5cZcXCKrH3IPyWHzaOBYyllKhjwoq40v6ly9kRedlWPSyAoiUQYe?=
 =?us-ascii?Q?T+LpCkgYbxDCPwyrERPW/GPKCOBjOyhmWNj+H9aTbzkzSYOp8Yh0V61Yx/Tf?=
 =?us-ascii?Q?XJ54j1dL92P7LPtjrOKkb03gMM4orTuT201nIKHqfGGDuI0rW+ZSyKRjF7Yp?=
 =?us-ascii?Q?sITx3HXSDya5ekQBPSN4932YeaszaeX1W9E2AVRnylh7I7CCtgeTlCXW13e9?=
 =?us-ascii?Q?7nyNQB8zlc8058Ig3OYhA10UZZt3Jx09E6b7npGNfQ3i3I1/TR6KmwLXuyMD?=
 =?us-ascii?Q?1IA4Dsw6+Se7c1NwTBole+EAIpr8JuZlZsBSAHGllyt/VR63rwk9QXuzvqbD?=
 =?us-ascii?Q?cYkxwcyljqg6nuj2MIny+QImLVM2KBqfMSK4cIi5foR+Ank0dF7jb8kFeEKR?=
 =?us-ascii?Q?fVVrCkeh63oO2clOF5mgOjZ8OE2VFfNJeqxmhIk9XptcF6H9e0yNhT6aoPue?=
 =?us-ascii?Q?hLEbhQZUZQ=3D=3D?=
X-OriginatorOrg: zenithal.me
X-MS-Exchange-CrossTenant-Network-Message-Id: 853486b2-3137-4a52-36e2-08da2ab01077
X-MS-Exchange-CrossTenant-AuthSource: TYCP286MB1393.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2022 13:48:10.8955
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 436d481c-43b1-4418-8d7f-84c1e4887cf0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: x3uNWMGI8dHouC7NVlLOmpQsuontxGVcNQcluuIsdfjWDXXRIavnaidhB0HVT1HK
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCP286MB1706
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset proposes a currently viable and forward
compatible way to expose the bitmanip/scalar crypto
capability of the platform to the userspace.

Currently viable refers to the property that hardware
platforms can easily modify the riscv,isa field in DT to
tell the kernel it has the capability. Note that QEMU
has already done so in its device tree.

Forward compatible refers to the property that userspace
can still detect the capability of the environment by
using HWCAP regardless of how the mechanism changes
below kernel in the future. I do know that it has not
been settled how to discover a capability, but I think
kernel has to offer some API after all, and HWCAP
is the preferred way among other mechanisms for now.

More discussion on userspace discovering
can be found on my PR to openssl
https://github.com/openssl/openssl/pull/18197

Hongren (Zenithal) Zheng (3):
  RISC-V: add Bitmanip/Scalar Crypto parsing from DT
  RISC-V: uapi: add HWCAP for Bitmanip/Scalar Crypto
  RISC-V: HWCAP: parse Bitmanip/Scalar Crypto HWCAP from DT

 arch/riscv/include/asm/elf.h        |  2 +
 arch/riscv/include/asm/hwcap.h      | 16 ++++++
 arch/riscv/include/uapi/asm/hwcap.h | 22 ++++++++
 arch/riscv/kernel/cpu.c             | 14 +++++
 arch/riscv/kernel/cpufeature.c      | 79 +++++++++++++++++++++++++----
 5 files changed, 123 insertions(+), 10 deletions(-)

-- 
2.35.1

