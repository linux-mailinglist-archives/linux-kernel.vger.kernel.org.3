Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3993052B64F
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 11:29:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234122AbiERJWI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 05:22:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234093AbiERJWB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 05:22:01 -0400
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01on2109.outbound.protection.outlook.com [40.107.114.109])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39F4818B35;
        Wed, 18 May 2022 02:21:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DRcMWW8ND1CAICEhSFg/cis8GTnJ39Dk5aa2mNYyZOVp7Npr+xM9QWXSesIBxW/7PUuNyatg5XM1OmgaDmgG9C8oX+dbPWENm71jFzapJHJdLGjpTfPYpUj4Io4Ik6Bc0YM/bVOAM3+k3WlL2RyHLMa8P2xkWYggMUD9ihMwWJhGGymZmlP2we9Io+UlhMmz55LCRe7shnxujOSiaZRhfH6bxLsfWM7PJuUmLpOk4uYTiRo4PUnFQIS8Je4WO99pOfuMz6sJoWX4I69HtLIF1s6SJdVv6568qGP7VCk+cjZp9ZoI1tYdp2fefuqZwpc4DeUOsBJ3YLs+0omzFvgWQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/1f573SWXxEk5PfadIY6U9lmnZCLu0AgN2Uwa9AUsoQ=;
 b=WmFQ5j7RYD9igm4AdBowRl3agVyVtK6CZ1ahUrJJZoVFUr5XSdWtL/26T8507NEwQI1O2yYD0UC1kQZJgeRVWOGwh7mvRPxYMR0Ms9hZSBZBWYaMmPoGuhXWSePCLgh+u1L5TZ6XO5UAw/I91JVYBSQ876JW2hBVK/IOTtjMAmVMLUIeQxpVarby2J4wc7qEPdNQU0AnJtn2zGonB5tigu+a0l0iJbtbp43IsADQLE5kaCo0Wt/OT4wr1D3EFkoGGp6W+wPdeg3iDBAeY/UaYKNHBh57mhCl5i9RmD3CeuFoNUKtZMIfw/l5Lmd2jx4eMu39VvxBHzjFV4J1d8q+Sw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=zenithal.me; dmarc=pass action=none header.from=zenithal.me;
 dkim=pass header.d=zenithal.me; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zenithal.me;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/1f573SWXxEk5PfadIY6U9lmnZCLu0AgN2Uwa9AUsoQ=;
 b=IUl3qvblbPlaf23ubiNjlRg5BFCaH6Wte0DWgWnVqnIpWHkrGJy1gT04flVgtR6SS/sceomAapAxVYN79E6ZpzZ4Bk8c64WSd7c97YUuoWKQA2KqwB7wpEY4kVd/mNAiQCh40xs7byqFjOqhULZP5xocd9hO5gD+f8grOLk85+c=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=zenithal.me;
Received: from TYCP286MB1393.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:c0::6) by
 OS0P286MB0611.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:cd::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5250.14; Wed, 18 May 2022 09:21:53 +0000
Received: from TYCP286MB1393.JPNP286.PROD.OUTLOOK.COM
 ([fe80::bd99:5c83:e2dc:a8f7]) by TYCP286MB1393.JPNP286.PROD.OUTLOOK.COM
 ([fe80::bd99:5c83:e2dc:a8f7%7]) with mapi id 15.20.5273.014; Wed, 18 May 2022
 09:21:53 +0000
Date:   Wed, 18 May 2022 17:21:45 +0800
From:   "Hongren (Zenithal) Zheng" <i@zenithal.me>
To:     Palmer Dabbelt <palmer@rivosinc.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Heiko Stuebner <heiko@sntech.de>
Cc:     Atish Patra <atishp@rivosinc.com>,
        Anup Patel <anup@brainfault.org>,
        Eric Biederman <ebiederm@xmission.com>,
        Kees Cook <keescook@chromium.org>, linux-mm@kvack.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        linux-man@vger.kernel.org, Jiatai He <jiatai2021@iscas.ac.cn>
Subject: [PATCH -next v2 0/3] RISC-V: Add Bitmanip/Scalar Crypto HWCAP
Message-ID: <YoS6qRhxGuwHmK7q@Sun>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Operating-System: Linux Sun 5.15.26
X-Mailer: Mutt 2.2.1 (2022-02-19)
X-ClientProxiedBy: BYAPR01CA0023.prod.exchangelabs.com (2603:10b6:a02:80::36)
 To TYCP286MB1393.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:c0::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 78aa9645-94ee-4957-e2ae-08da38afd899
X-MS-TrafficTypeDiagnostic: OS0P286MB0611:EE_
X-Microsoft-Antispam-PRVS: <OS0P286MB0611D856D1293F2A7894E0C0BCD19@OS0P286MB0611.JPNP286.PROD.OUTLOOK.COM>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PBNysPPQe1tDonHls8Ve2y82x2E2TSC/Yt38i7zvJI+4PRXeaOlDXQW5iC8TXTwoLo8U+RWsSU4clTvFf4e8qg7ykfEjL1zRIPFtSHWUi3W+nE6Hnxk+Hm5m475279PVsS9fw/T1x+roZW3BCkyEdB7scqNfIjB/uG3ngal0JZzLUwGmfgQ8LnzKki+SM69lNV7UEfmn0IvCiYKTz+/f2iax65JyyWRNaBjZBGT4+37CLyMmreQRR6CJJPdFJMhIibKg/myVmj/+In8QE4oascjJfFYZphh2wvrhcMgiGshlh3A4H/xOb06FXNTHYY7PWy1x6Gd0e/UUoB+P1pcJhpvQgFbzsq7GkBYkJPj4YxGZj9K7VI0RxjmAoLG+XrIuoqt1PbcrwobIgV5OWJ9x0OcNVLE5U2amOiNyeblM87BFIGPagdBiVjgbV8z+usQpR5NUYPxI1jb5TESsH8k1MMAOiWJkwjHT43aPozEgYWrioM6oeEKe6izEUPzypjWvPNw7ceQsdwTZr5QSTDVYKd47fuEzCHALV4mEfnExIw7tFRW3YrThKFevQ7GCe8fPyQ1NeJpX9KWALkmih5YwFgvTefXlwPcJA6tGsVoY8kE8/5zA94iTMOjdkPuYrr/CNjT+7/vl4KzTUpAB7F5DU7+79r6i8+dXve1F/RQgwTvONiMIIHub+8mXMpoPK+PCUn4q7sPGt8JBFnk/GjjjUYzm5fwTuV7gx8keHR5QBeBkF9/4f+cKhnersGk6j3LwH8ADgwJnZnKFJoM+TpKQEg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCP286MB1393.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230001)(7916004)(396003)(376002)(136003)(366004)(346002)(39830400003)(508600001)(66556008)(54906003)(66946007)(66476007)(41300700001)(6512007)(9686003)(8676002)(6666004)(786003)(41320700001)(33716001)(8936002)(52116002)(186003)(86362001)(966005)(6486002)(110136005)(83380400001)(38100700002)(316002)(2906002)(7416002)(5660300002)(4326008)(6506007)(49092004);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?PDmRMqBziys4ToZTq5TPxQsq9Rx4RdbCuTL0tzIxG7+fcwU/5JAqD85Sfk8J?=
 =?us-ascii?Q?9YzppHueM+qZmsIj/QXeUpzLIDBjKOwacSXchxK/rAMmddVRbSbYJUthmA8C?=
 =?us-ascii?Q?J3G4BKtTyapa7du9T1r7saANC7ZGMt24sC6gdgVBuLli37EBSHyFwIBKtT26?=
 =?us-ascii?Q?ONrM0GgyrmswHch7GyOwn0U+psweAkYRHVmuc9jq5ZEPpeLm473IHM6siD2u?=
 =?us-ascii?Q?gIFA146O6YqxOHYrn7JJ6MfGQk8k/henkY6f5yntoNysHEXxNUuqXygpFjwp?=
 =?us-ascii?Q?rOBvYc8so3T+BeaZsXluadrxCxXg0sV6XLfDUqcjCPtOlWNqF0UN0JYIStdw?=
 =?us-ascii?Q?ta3IVF4vGG6Ldwz66XU6zC0Ee0G16CLM9nBnzyHZCJAv0yyFOGzgBK2ySUT1?=
 =?us-ascii?Q?V1D4lhkbi6TRnaihbaoeYaJGbFe0CxGwqNjbJcBhDktb2V18N7fGZur6K/jj?=
 =?us-ascii?Q?kUirVzI+pJWD0UwfGmULsLDYvz6DXMbqUDL+0jzSNwJpShWUbH5nJCy+tBKJ?=
 =?us-ascii?Q?pmXquTNP3gnzaQe97Kdhe3rPOkZ3FQqdkva22Hyig4emGLpThvuAiJezRLJs?=
 =?us-ascii?Q?PI2MkRPb16KE13+WtA0LXSeZegmdTQrHtCa7NlkGRwh1dzsNtszds/GyX2yw?=
 =?us-ascii?Q?7oJzjIrZsmzs5O/Iy5WQU1J1pz21r+Nw3Y0E699l9kfW/bNYTfaYyUb5YvUy?=
 =?us-ascii?Q?gqHaOMnq1wMOWozdL9Z9UFA5S9sRb42lol8xT8Hd8B7TqOt/3NcFGHmKwVzw?=
 =?us-ascii?Q?XnRLoV/XGQHvjrZ8T7VbQNjs2AQ68zthlmNWztosnc7bq8LvDMiGvLKNB7ty?=
 =?us-ascii?Q?+6LY6y2394bFjcFAw3DPJ3Dxu1yyaBMwlWYqtN5OPnQjOSevxHwLwzA9sfpD?=
 =?us-ascii?Q?yoVG8WHAhfQattrRCPnCkAiLmXt6xyu3106zYv0ZRmd7sUUzjan9EzEJVzKX?=
 =?us-ascii?Q?0/VMANV9dz3Xn1tulz5RJaAYO7s1/7/b0tsznRS3S19aSNxcgedtGgQxjC/T?=
 =?us-ascii?Q?vmgA4C2FW9Pzj3mJ1Be2oom58EMnSDFFFaAJnT4XhtldpJSiN7oCy5J5xdmF?=
 =?us-ascii?Q?9vLCWqWMUlE/o/WW79GKVwWyygnKt27qhUmZgWnhBwMes9zV4t9uLUPQygzs?=
 =?us-ascii?Q?UgFk7DYruXcpXfuH6cwykVZURVFrsWc1Fza3H1OTO7X1BWLzE7YIHOxPChGU?=
 =?us-ascii?Q?Om1o4maq/anNjw6S19MJ9qUOpKCSvLKjCvGQOb6SGcnGcp9na90fjchfeLPi?=
 =?us-ascii?Q?NXyP4L7yYmCxz+39uEtb7o5AVo04etf9gPnkLwLmgXtGqyV6j1GsU3Hgl8SK?=
 =?us-ascii?Q?HWKFAXLXy1mfj+sr4qO3WUezH1FHPjPVDNpdr10f98Djyu+R+eCiTUrUv+Qa?=
 =?us-ascii?Q?z6AjDJQgVrobf7NxIxjZm2h+4dMbMf98SmN5GzVO3LB9PVnkxo/KPRlZW1Jg?=
 =?us-ascii?Q?TOggoRBT2nHL3W5rj3fdgkGu3QOs5Q3jLu5zy1yF5QipIrA7GX9GKzzgjSqF?=
 =?us-ascii?Q?qKbQna73kRLpYHgbMd047VgQXHXhsr6GK+xxo94IsK1vdQGtqVYUo02FnJLj?=
 =?us-ascii?Q?aU0VxCzrEzI/XRGaYJoxYuWjnd13fpCc5EH6Yo7/auj1wgl6BECNPi3OXeNe?=
 =?us-ascii?Q?YFYwFyRxb+wNrfP3z4DaoWccRWG/xF13VjdX59aej/zDt9zvSH957+6kUH0G?=
 =?us-ascii?Q?etWptzsN3VlawryE9bM+Yi3Sjv+YeDeIX+yLX8sAOv6jkHY0kSZl2No1RjHf?=
 =?us-ascii?Q?rmL7+9WYgw=3D=3D?=
X-OriginatorOrg: zenithal.me
X-MS-Exchange-CrossTenant-Network-Message-Id: 78aa9645-94ee-4957-e2ae-08da38afd899
X-MS-Exchange-CrossTenant-AuthSource: TYCP286MB1393.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2022 09:21:53.2148
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 436d481c-43b1-4418-8d7f-84c1e4887cf0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 87BUp6WPhfzaWTSVU/2jJogk880ttq9nLunDi29EDb+1cYJwlNjP8HReUD+BxEl9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS0P286MB0611
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

