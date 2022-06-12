Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81C6F547B89
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Jun 2022 20:45:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234175AbiFLSoh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Jun 2022 14:44:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231961AbiFLSo0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Jun 2022 14:44:26 -0400
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on2109.outbound.protection.outlook.com [40.107.113.109])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F7D35C84D;
        Sun, 12 Jun 2022 11:44:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f7rJV68LeMBCOX4oy4MvVj77f97f8GMGzkVYX6D6uzg6538XV0X/TWalzXbJfv4w6PUke4RrykHB2dYK1q8OJ0xrg67F/Zb8pHhGc/hxinyY/OjZzPslkXXpRBgAO492EGK/FEXvIKuLzG5bxGdThqDxUTuvJODcR76OGybFbwV/KCOhQyYnMbuP/TsvFe3a0wypopIbF/p8yCYWBiSAOgIC2QatJXpTycv/2f7eyF+S9MTZnsHgMzcP32DGXQyI11IZ1UHuy+F9qlQjhzSfwtbZgiLSbfIGmd9IZjilIxIkY0ilAb3PW9jbmdQMkz8t6kyvIBcLj/3suOCcMXtYkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jP1otuVAhfpdsT9FK7khumgrA5N/W7n1VI2gtNJq5BY=;
 b=QAD1QwOM5JhjkEOn8CzPaL87fb9O/Wmsd4FFUcGt9MGjEwoGvJ338ZGWa8/uIYs/0SIl4IHZ4qhYWaPESkPsYNM/US/rqN2Q0mIKuaEjbz663B700ShqJ93xOfkdH2tNLWqMRBeV95AiWoUT2a0X0kZ8w8jkyO0huAzKskgl0jYneLCHseDK2JrNngwPjmatBVKcQpavhLqcK71ZTAO2U5+6BrHXY2xm1SU5eBoNJRLd8CwaEtHD3/vBmC1fkDx5P0CbX4WKnFAa8BSrjORKTooJtNBt7jJlu4V520smDPMEqKs+YV+uI6zmhc1kHt3Njpe7ylG4E/KOrwyPP7XgDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=zenithal.me; dmarc=pass action=none header.from=zenithal.me;
 dkim=pass header.d=zenithal.me; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zenithal.me;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jP1otuVAhfpdsT9FK7khumgrA5N/W7n1VI2gtNJq5BY=;
 b=eO16Rm5WnSulfBq4WEM+swmrUPbe5fzghC0w/GMilG9REcJH8udk9mreilsrVWDFLMb6S4OikzRo/xzQCVk+1e9Ar8OU6sPhX/5KX8gBiMjpbsUxpbviSOFLCc3iuLqJMEDV0yFji6n2sMnU4Azg5nB5/14TB0iFlsYC/Vy/UeU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=zenithal.me;
Received: from TYCP286MB1393.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:c0::6) by
 OSZP286MB1063.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:111::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5332.13; Sun, 12 Jun 2022 18:44:19 +0000
Received: from TYCP286MB1393.JPNP286.PROD.OUTLOOK.COM
 ([fe80::a162:2f17:bb41:c95]) by TYCP286MB1393.JPNP286.PROD.OUTLOOK.COM
 ([fe80::a162:2f17:bb41:c95%9]) with mapi id 15.20.5332.020; Sun, 12 Jun 2022
 18:44:19 +0000
Date:   Mon, 13 Jun 2022 02:44:11 +0800
From:   "Hongren (Zenithal) Zheng" <i@zenithal.me>
To:     Palmer Dabbelt <palmer@rivosinc.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>
Cc:     Atish Patra <atishp@rivosinc.com>,
        Anup Patel <anup@brainfault.org>,
        Eric Biederman <ebiederm@xmission.com>,
        Kees Cook <keescook@chromium.org>, linux-mm@kvack.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        linux-man@vger.kernel.org, Jiatai He <jiatai2021@iscas.ac.cn>,
        Heiko Stuebner <heiko@sntech.de>, Conor.Dooley@microchip.com
Subject: [PATCH v3 0/3] RISC-V: Add Bitmanip/Scalar Crypto HWCAP
Message-ID: <YqYz+xDsXr/tNaNu@Sun>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Operating-System: Linux Sun 5.15.26
X-Mailer: Mutt 2.2.1 (2022-02-19)
X-ClientProxiedBy: BY5PR16CA0007.namprd16.prod.outlook.com
 (2603:10b6:a03:1a0::20) To TYCP286MB1393.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:c0::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 84168702-0d6b-48e9-2600-08da4ca38ef3
X-MS-TrafficTypeDiagnostic: OSZP286MB1063:EE_
X-Microsoft-Antispam-PRVS: <OSZP286MB1063FD767E70D8608A964475BCA89@OSZP286MB1063.JPNP286.PROD.OUTLOOK.COM>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EigIxfDKDq4hAZmEUkz8QWBh3zrj95Dez02u6p6IgwG0Gz/5AehzJa+08QFKUZflK9Uq1OgCq1TC8hdRDfh8dlQwyDOljIcTc27yg5Ff7FhDOeQgZAg6oSB/99tuxGBR6bs4ql25kIHqHCtY23/c3quvQLthsokae7AUPOg4obfd+CiR9/VkJclp37rovz9LkziDLMf6dO9dAyU5kt61he9Of4J67iyEPkAMicxL6NOhXHaCpN+lXxfxtFMxhlpTVkwgq37L+kQ80DwCMOhQw3XkIvAyqDZcOHW93KWr2mP2W7tuyKkTGJp5y6jT5oVJKQOTpllA9OuFySrcVhSn/9qSYqGNfaS1qI3elxwP1K4SRrXNzDUS7bK406hCIIbBBdg31vy62V7eqaQzEA9nvam1TprDnMGNv1S96NkRIhWc4uHsEHFxUUH1Sht/RaqwaUxXSX5hE3jidrNpJXuVbo0bUoMT2zDrHvEWDwyYtRv7c9hmWD4IsSpS6kUUMor36AXOYftSlzL2t8FI6uloyTJYlbDWHd0KxyDm2FOTM2wavOu1/xlQfRFfFSe0fiMm9XC1VEj86EdL916JQ+i7zkt26YEVDs9bJKZoCJkEWoyLkdAhKq3CPTeZnC5JwjQb3bYPwUh9B0JYFyXKfpHYnEJ2IxU83fc2K5lJ4G2NS4oBROAZdzUdG/AsXLDL4jjM2dH6ZGTjHgugLk+vL7dWRvLMwp296PG9XH6McyFtR9lcghMbn6yetT40HuDOHs96u8llsA0WSqyquCBy5xbe9w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCP286MB1393.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230016)(7916004)(136003)(39830400003)(366004)(346002)(396003)(41300700001)(41320700001)(6506007)(52116002)(9686003)(6512007)(6666004)(786003)(316002)(110136005)(54906003)(66946007)(66556008)(66476007)(33716001)(6486002)(966005)(86362001)(508600001)(38100700002)(186003)(83380400001)(8676002)(4326008)(2906002)(7416002)(5660300002)(8936002)(49092004);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?6Yvm7kLugR5bnDvggZqEwmEaTHERQMzqLWx7o1/LSaGi5fOnDxRX7F6PhUCK?=
 =?us-ascii?Q?GoT1zcMJy/f4nNb+678cuzvI6fRdYRCxQnXpJ5QCQkOM4GmLdDcDERS/F8kl?=
 =?us-ascii?Q?0lquP6P70GyajDajK9v9FUgDcgGnONCXpIIxr3WIErFo2pygxay4bcku2j59?=
 =?us-ascii?Q?Gw2gDcyfn/oEX2aCd5wnG6de4TeGLkRhwzmKjPOrXuxCo4NHgNgcBwPdQVM0?=
 =?us-ascii?Q?HTcidv+i+amQXwyXW04iLJwC24Oa7kLhBRk7yZdRcTXvsLzVtjQ5PsR5Vwcn?=
 =?us-ascii?Q?BAxJB84Lz2iMAWQJFCGvecWFCN8cWxGsk0rBSF53UuQ45Ge1hKMqJdv+CxLz?=
 =?us-ascii?Q?5+ZKaGxVlAp1zQkyuuHVlIgRARDM3NSe4ON77Q63jjSsT+KD/hwQnZOWxQ/K?=
 =?us-ascii?Q?cbHPVijTsVGVzrTf59CM6A2aNUJ8LBso6R2YZjf6eiZ5YfQlnBSD7HSez7bQ?=
 =?us-ascii?Q?0Q03wp6aBSz0ZvBNbYw2AcTGgoTbRvZVCnJ5jjPiT9WGDbtmaLYXh7O75wTx?=
 =?us-ascii?Q?s35DAGEFxpKios38eynAKpey6X+Y7/JtVZzudiK3cqETG1X/5VnTcqVCrIwX?=
 =?us-ascii?Q?xZsXzI/hzYf4kBWVFuC2TvvKEd4/goD/2Dr4tLRC58+5A8wNjh9BTaczdXfp?=
 =?us-ascii?Q?z5D5wL1dGDzICdcDth+AKzxxyKNhjlg4RjiIbGD0aaFh07GLWQKtEj38LEWC?=
 =?us-ascii?Q?f/9SlW9dcYAUNmzA92XQkXFn1dhgBcSiQE9ile7ZFI5aX5aMUC7GdnkUE+1E?=
 =?us-ascii?Q?+dbWFDipc50ssysitWdr3paSbuyRvmthdgfQzz/gFHZKbV4atv1leySYzyZT?=
 =?us-ascii?Q?o/rdX1+T2yjEfZzhaO1nT54N9JJl37PGtgiRQEEtE2R+xeZKp+XFBZFxSx2J?=
 =?us-ascii?Q?6LY1XJGNBA5J+dK9zYTOGfPXAk2JmZgTSqQCdvq7bbktVgXexRrgjMJDQ6Oh?=
 =?us-ascii?Q?RF2lmj+tKwr64QC0CBtgRb3/g2WI+2HCq1sXcYa0VqqgBln84ice4taRnMjs?=
 =?us-ascii?Q?QtH/xdTqVpTvy8CAvuHyKFq2tGe5ghDMuR+krKgdxZjV1d7q5nojAoieTot4?=
 =?us-ascii?Q?UXhYN97xFG4M9ddXTasMkBfdN/vODldQRgvJvQDW6NYfHUT2iLbRDtUVFb7T?=
 =?us-ascii?Q?fpvMhUQTBvWWFh3cFQzldQPL4+ed0IRMAb2nj6JDYqKtdlqOhbaTxkb2Rzio?=
 =?us-ascii?Q?8q1zOtiu7b7CD0j2vS9OsWvc8OlKnQb6J5WyJHPYCXen8WqUzwT2UqmP1IeE?=
 =?us-ascii?Q?pwiRV5IZID2lUZJJbdYHcKgPHVO5mMLKBMZ6rjkDbYvDWXKPjCJn8T4Po09n?=
 =?us-ascii?Q?ZPuFE4z6okYp/EFMVAEpltbCf5n7T71RpzbOWC8HY18qneXs69I81XZnF6ew?=
 =?us-ascii?Q?82QjVU2DENJrzuCV47uJyVN8iiT5Wx4iTvckE0hUMhKNxMMMT+wEWMPazX2s?=
 =?us-ascii?Q?j9RgfXSEBJRgzrjjB4ZrBG4CjTuVUXgBE5Uvmq98q4Sfgnh38HHRukNx/txU?=
 =?us-ascii?Q?asxoyGw8QMrjCGDJWrUDoYNO8dfi34IOc2fhIvWTX8nbA7q37vNF5n2HqbVD?=
 =?us-ascii?Q?TnXjS3gfZ71rpVCoq+9ykyc83SOaSj8uSvSYzxQdtkJ/V2CWyJQcIoiE7AyF?=
 =?us-ascii?Q?j2UezLjJqinb9Bjen/MraKsMT9j1MoN5pktZWueFOKv9Wp4T+mcrGp0J13sL?=
 =?us-ascii?Q?MURgaE1ZL6PMn4Ya+AVw39wKbVnm7AZXy9GH/XHHKpwHis0eBvjGIHEi3052?=
 =?us-ascii?Q?dsFunsCemQ=3D=3D?=
X-OriginatorOrg: zenithal.me
X-MS-Exchange-CrossTenant-Network-Message-Id: 84168702-0d6b-48e9-2600-08da4ca38ef3
X-MS-Exchange-CrossTenant-AuthSource: TYCP286MB1393.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2022 18:44:18.9420
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 436d481c-43b1-4418-8d7f-84c1e4887cf0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3dc5uBQPcVb7I4ufMjXqESN1S2jxgaQtCiFRSVs37XbhYhh2VIHdc38CQkfuxRCf
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSZP286MB1063
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
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

A note here is that the draft riscv-platform spec
considers DT as mandatory discovery mechanism for embedded platform
For other discovery mechanism like ACPI/SMBIOS, similar
code path can be added but the HWCAP interface could
remain unchanged

More discussion on userspace discovering
can be found on my PR to openssl
https://github.com/openssl/openssl/pull/18197

---
v2:
  * Fixed checkpatch problem found by Heiko Stuebner
  * rebased on riscv/for-next as that branch has merged
    the support of Svpbmt extension
  * Changed the order of logical ids in riscv_isa_ext_id
    to the order specified in riscv-isa-manual
  * added note on riscv-platform-spec

v3:
  * rebased on master as riscv/for-next has been merged
  * fix commit message as suggested by Conor Dooley

Hongren (Zenithal) Zheng (3):
  RISC-V: add Bitmanip/Scalar Crypto parsing from DT
  RISC-V: uapi: add HWCAP for Bitmanip/Scalar Crypto
  RISC-V: HWCAP: parse Bitmanip/Scalar Crypto HWCAP from DT

 arch/riscv/include/asm/elf.h        |  2 +
 arch/riscv/include/asm/hwcap.h      | 22 +++++++-
 arch/riscv/include/uapi/asm/hwcap.h | 22 ++++++++
 arch/riscv/kernel/cpu.c             | 14 +++++
 arch/riscv/kernel/cpufeature.c      | 81 +++++++++++++++++++++++++----
 5 files changed, 129 insertions(+), 12 deletions(-)

-- 
2.35.1

