Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24B9B519594
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 04:40:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344098AbiEDCni (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 22:43:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344071AbiEDCne (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 22:43:34 -0400
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on2138.outbound.protection.outlook.com [40.107.113.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0F1C1F63D;
        Tue,  3 May 2022 19:39:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EHN4mpISxK6JXRni33QU/fu/UJF8Uf6ZQidp7OjTDc7u+b3I59hha0rhQ6LwUVJE8dLSkqTa2ZLONIWnw3fWfgqU4z1leBf6e4UOJ66Dx3/wF+qoxeC+iQXmHmeXKJbyvtXmuOXBM+A2WrjJRpWhVersp3tPeiKWeuHCp8eCqEjOG7aK3qrn6Oh8+wT35nSWqyrFDMMHKbLgHCa0WxwwOC0DqQQDZpddlIrpnEaezRb2uGUxa+4k8Y5tt/MPgv3iPwSqMXkTQ1RERT2yZyLALXQWCAMUr5djV3s7pqtZpwQqAN/m2geTpZQuc2eM50FWzPbHL2LsZj0AiB1k2AfgJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yMKLXYUPaB2iaMv77+Y4YcgPrZNs9krGFtWWpzOdCF0=;
 b=ZyYuI+bo87ygpyn94jwig9qUICIduu55j7UQwnSWysIbGiofD9TZldqO4nme977dkP4TTgMvsrOFEg0UfvTxnK39418uRQt2cO12l0OOEYgCaHkEoTc1w7A0YOKhViFXkqEc+9DoxXGO4KajxQCUozXaOybzpBQn3LUCN8juxI0MRUQFFjCGtkEtv+KRdXhlKRFdOowN8RlMioGL9be+HJ9sqzjZhoEZcOximsCpfR35EdctBQPDDL1nuqww77jW+4m6OneePcnZ1pvvoI4APeenbRRB3BRI8f6U/ieZumO80kxlLwyvvwwSFSWh9MQy/I19fS/uPtJWkPf0OdnnoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=zenithal.me; dmarc=pass action=none header.from=zenithal.me;
 dkim=pass header.d=zenithal.me; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zenithal.me;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yMKLXYUPaB2iaMv77+Y4YcgPrZNs9krGFtWWpzOdCF0=;
 b=ioAcBmeZRy/ywVn5BPmzed7VwGC0v1r+nGEcZyooVo1/D8c5mEzWtHIp2u1MUZbffNMkl7+qYLZ4zXyQj+tI5zOYgPJPoPiJbKMy5j7ihusas8HcmmWojtXmS9KHhKH+gFkyyMY4TZzEErdAFDV3huKj+hz52dGJn4ot2Pos7og=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=zenithal.me;
Received: from TYCP286MB1393.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:c0::6) by
 OSZP286MB1485.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:1a6::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5206.12; Wed, 4 May 2022 02:39:54 +0000
Received: from TYCP286MB1393.JPNP286.PROD.OUTLOOK.COM
 ([fe80::bd99:5c83:e2dc:a8f7]) by TYCP286MB1393.JPNP286.PROD.OUTLOOK.COM
 ([fe80::bd99:5c83:e2dc:a8f7%6]) with mapi id 15.20.5206.025; Wed, 4 May 2022
 02:39:53 +0000
Date:   Wed, 4 May 2022 10:39:45 +0800
From:   "Hongren (Zenithal) Zheng" <i@zenithal.me>
To:     Heiko Stuebner <heiko@sntech.de>
Cc:     Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv@lists.infradead.org, Atish Patra <atishp@rivosinc.com>,
        Anup Patel <anup@brainfault.org>,
        Eric Biederman <ebiederm@xmission.com>,
        Kees Cook <keescook@chromium.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        linux-man@vger.kernel.org, Jiatai He <jiatai2021@iscas.ac.cn>
Subject: Re: [PATCH 1/3] RISC-V: add Bitmanip/Scalar Crypto parsing from DT
Message-ID: <YnHmc+2EdTsu2npO@Sun>
References: <Ym0+Erz5DEnB78vu@Sun>
 <Ym0+nr9KZBO118Dx@Sun>
 <4734719.31r3eYUQgx@phil>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4734719.31r3eYUQgx@phil>
X-Operating-System: Linux Sun 5.15.26
X-Mailer: Mutt 2.2.1 (2022-02-19)
X-ClientProxiedBy: BY5PR20CA0008.namprd20.prod.outlook.com
 (2603:10b6:a03:1f4::21) To TYCP286MB1393.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:c0::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 89969328-cfc9-4583-7ff5-08da2d775e0c
X-MS-TrafficTypeDiagnostic: OSZP286MB1485:EE_
X-Microsoft-Antispam-PRVS: <OSZP286MB1485BFA2C73DB1FD14CAB960BCC39@OSZP286MB1485.JPNP286.PROD.OUTLOOK.COM>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jvIXzCFOSJmJZ54J9urPGbMI/bEGzneniRzPXmG6xpLEJ2LNuXCPptvxIWQljEYIV6YlNIenriBl7Nr4zzzuVIjvaMhqpP/FnBq81kr6RYDuj13pVG02sQoHVcaRFmAhG1VyuEy81u3kY7phTFeyXUn8BJ126kTOuoMRoUUjBT540QUJYmZX1bRqrewe/cUEeZhdKeANxbMoBExnCWVkMBw7MgQWgsO+EnYlf4pewv01FUu9Pv67zYiMYkUBxR/2EtV7RLtpDFHVuSYtNBK/y8b2WP11vBqNMsgrJM6paWYXr8L9sC/z6W2lM1f8hia70chLzLHMx8qj/oip0WDCAVzxJqge972bLgmHWt0zxrwYzWM3KnhgjuUYNui66MsKAq2QmxopfAc45ufhswZmJUTO3fUP1TqtAiLK+dhiVB/X3juZWBXxhqiUJ12flvoCFv7Lqt78yaDw27ZTrZpz8MOTa4zQUzVnH+Z4Y7DSU4JEldTEFpds17dUfbN/FU7Gaqf0GZ3qTqYFLlrfRcOPl7NDtCa5PRjM77UY6g1rx18pMU0kJdDZk3hKU9lAGkoeBARLSEyY3l57rjeylnbJ+8BZMBVOTMnPj3NPlEucBfj4Dg4dIG/AjMP0SvtzfgKTXSPO5lTfebuv+8HQF26rTyFd6BicEEzgZ+SL6GzXhnGAiQXPKvUEBJEQ/FytBYoV150adyl6Skz3e+5/YXJpHw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCP286MB1393.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(39830400003)(346002)(396003)(136003)(376002)(52116002)(6512007)(9686003)(6506007)(5660300002)(33716001)(7416002)(2906002)(8936002)(66556008)(8676002)(83380400001)(508600001)(4326008)(66946007)(66476007)(86362001)(6486002)(786003)(6916009)(54906003)(6666004)(186003)(316002)(38100700002)(49092004)(67856001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?mfpH7IGKzpD5xvSOMT/f87qnSGWBNtY1clgJerQHRePWwElL4J8Z0OWnMLIp?=
 =?us-ascii?Q?9GUa8uLkb095ZLj1Zqn4cdzgEg+aOwkwWUz571U8Xi0J7ju9GaU1AmL8S5hc?=
 =?us-ascii?Q?lKRjhZYauIUdNVfPMfQGNdZBMV5j9ASmEXGDVV8Hw/Com/bBngNSexmd3FjB?=
 =?us-ascii?Q?0tKexWzBDeAo3QCvE5q9F8I5uQ1+znY3Bq1LNwLq6ox/GkcndpV7yfeeplBU?=
 =?us-ascii?Q?OS5aTcuXO8rIqG6o4pNVKSFmygl+waVx+mtQ2Ziycnp9/EpPjbMJV9awcf+P?=
 =?us-ascii?Q?BHYvuva2l33C/ePmW7OKFRABwTKWTqmImZcNhdjnhOMBI0bdGn3XlciySfqD?=
 =?us-ascii?Q?nzgtXYXgNfoI3vGS7TS1E/POMPRHUMf5DbTvKIoNGxIlEM40NpckS1rwz3mF?=
 =?us-ascii?Q?vn7E62Mro/TDCrXWYAYk6br8Wc9GtRGDIN74kQhs77eD2F/0YRClwkIIAIxa?=
 =?us-ascii?Q?r/TF6wQEDm3QW5IglvSQrccA6tT/70cXpQHH2LGuACNGkypgwwT4hmwhDLPP?=
 =?us-ascii?Q?U2O2EhjArIT9mw7MN8KGzsuzuuzhtvw5b/YL4pHEzSMr6fr7T92Sb5b09QfN?=
 =?us-ascii?Q?w+qW04YhXloQ+D3oxsQmZF6Lc/UnWTBrYuU3vlhz/q1E5I8b9W1IbA8zO55F?=
 =?us-ascii?Q?diB4nwHTucD4/wAVSr/0VLgH3LNZK/ay7Y5A38W7nFJxnMBIpdfmokeM0rOY?=
 =?us-ascii?Q?dP7lo1mGfFzNFF9umPsZB3X+bAaQgLPG9HV6uaiNU7b1NAa3ULkU3xgn8MeJ?=
 =?us-ascii?Q?V3VK+P1I3/24oXajGD3s3VOIWLp1F+TQfDULPsQzk2uNkYKo7m79mMHrDu4A?=
 =?us-ascii?Q?odyUwA+SgtZKLQR+6DH8U6Eou+9mM3er3SOFvH6HdUVsS83kEnKX/JewH39q?=
 =?us-ascii?Q?PaQvfZUoazJbwxtoMyZmnRT5EqR+6Cb+KvagnJnWfqxuSZzkv4ecNTA62K0T?=
 =?us-ascii?Q?Bk6b+VhOiInemvRJShkhUCrI189hfVP5EnAzeuL8phEqb07vec8NnkFR3ism?=
 =?us-ascii?Q?5+r4/8MfRuOQBt9Ne8gDTf7FgABlxLIemLbAQJSHV14NjwbpP0xTrHrw1hpC?=
 =?us-ascii?Q?bKD4UF2jvcnwgcfTx3qsslYBEtNWGrt0ITgurhZGO81HHMobM/cwnhE8Ffgv?=
 =?us-ascii?Q?sBMAHAGRNjtR05mCHiwqv+PobVhvTEz5pR/GZWY21o6NbWjzFU/CVPQwsLvW?=
 =?us-ascii?Q?pxo4SWZcluqToIbI/ZUlCWCxzWjnGK7MYgJnMx1gUyN6fKrtrMAQIUYnKUr9?=
 =?us-ascii?Q?6a2YjlnyhW1ysZm6v4/ZsxzSHzGnaR9v30krGuN2SLPbCWhf7s4wqiC7c1WE?=
 =?us-ascii?Q?ICiab7aQEc2ebE5V7WUO6Lys1Axd3mAICBQcaKtUkabdagiILzYxOIEPaHib?=
 =?us-ascii?Q?UXiqrRLyncX2C/eLN1gCSVqrngMjjlLan6CWdF9hnBxae1+sH225lXjiNdED?=
 =?us-ascii?Q?3VKmZ435x7Fd7S3wHV9E79oXeYRS9k/6/qEbTf1WfPJUuSHBshmF/xNUx/1I?=
 =?us-ascii?Q?b2g8OqAy5pdxXlZuN86S9IN/vogIanoiVhXDXpep2hoKO4jK+sPeeL6U06BF?=
 =?us-ascii?Q?4RtQ9Srjk/p5/snzY19/xBTmlt0TWrwW8CE7BEuaMYxYGeCDE/in1E2BpJCQ?=
 =?us-ascii?Q?JLkixAQqAcAZUJRy3Pk52Fsh12rDiaPf+A/YudbKNRZqO8UaKNBkrvbLUoyk?=
 =?us-ascii?Q?kKMiQ7qNcTafVNnQ+buX+pbb+UrFnqBwVkq9c5a0W8G70rQTUvhsA3TCXeY/?=
 =?us-ascii?Q?3tkOXedy1A=3D=3D?=
X-OriginatorOrg: zenithal.me
X-MS-Exchange-CrossTenant-Network-Message-Id: 89969328-cfc9-4583-7ff5-08da2d775e0c
X-MS-Exchange-CrossTenant-AuthSource: TYCP286MB1393.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 May 2022 02:39:53.2331
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 436d481c-43b1-4418-8d7f-84c1e4887cf0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mUL0SqD0mB4M3IHgqiYqwvTHDZYY8iC/F2ndLdl31ZZo0j71nX5+gArIuplCtgMX
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSZP286MB1485
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 04, 2022 at 01:21:23AM +0200, Heiko Stuebner wrote:
> Am Samstag, 30. April 2022, 15:50:22 CEST schrieb Hongren (Zenithal) Zheng:
> > This commit parses Zb/Zk related string from DT and
> > output them in cpuinfo
> > 
> > One thing worth noting is that if DT provides zk,
> > all zbkb, zbkc, zbkx and zkn, zkr, zkt would be enabled.
> > 
> > Note that zk is a valid extension name and the current
> > DT binding spec allows this.
> > 
> > There currently lacks a mechanism to merge them when
> > producing cpuinfo. Namely if you provide a riscv,isa
> > "rv64imafdc_zk_zks", the cpuinfo output would be
> > "rv64imafdc_zbkb_zbkc_zbkx_zknd_zkne_zknh_zkr_zksed
> > _zksh_zkt"
> > 
> > Tested-by: Jiatai He <jiatai2021@iscas.ac.cn>
> > Signed-off-by: Hongren (Zenithal) Zheng <i@zenithal.me>
> > ---
> >  arch/riscv/include/asm/hwcap.h | 14 ++++++++++++++
> >  arch/riscv/kernel/cpu.c        | 14 ++++++++++++++
> >  arch/riscv/kernel/cpufeature.c | 33 +++++++++++++++++++++++++++++++++
> >  3 files changed, 61 insertions(+)
> > 
> > diff --git a/arch/riscv/include/asm/hwcap.h b/arch/riscv/include/asm/hwcap.h
> > index 0734e42f74f2..199eda39e0b8 100644
> > --- a/arch/riscv/include/asm/hwcap.h
> > +++ b/arch/riscv/include/asm/hwcap.h
> > @@ -52,6 +52,20 @@ extern unsigned long elf_hwcap;
> >   */
> >  enum riscv_isa_ext_id {
> >  	RISCV_ISA_EXT_SSCOFPMF = RISCV_ISA_EXT_BASE,
> > +	RISCV_ISA_EXT_ZBA,
> > +	RISCV_ISA_EXT_ZBB,
> > +	RISCV_ISA_EXT_ZBC,
> > +	RISCV_ISA_EXT_ZBS,
> > +	RISCV_ISA_EXT_ZBKB,
> > +	RISCV_ISA_EXT_ZBKC,
> > +	RISCV_ISA_EXT_ZBKX,
> > +	RISCV_ISA_EXT_ZKNE,
> > +	RISCV_ISA_EXT_ZKND,
> > +	RISCV_ISA_EXT_ZKNH,
> > +	RISCV_ISA_EXT_ZKSED,
> > +	RISCV_ISA_EXT_ZKSH,
> > +	RISCV_ISA_EXT_ZKR,
> > +	RISCV_ISA_EXT_ZKT,
> >  	RISCV_ISA_EXT_ID_MAX = RISCV_ISA_EXT_MAX,
> >  };
> >  
> > diff --git a/arch/riscv/kernel/cpu.c b/arch/riscv/kernel/cpu.c
> > index ccb617791e56..7251336969c1 100644
> > --- a/arch/riscv/kernel/cpu.c
> > +++ b/arch/riscv/kernel/cpu.c
> > @@ -87,6 +87,20 @@ int riscv_of_parent_hartid(struct device_node *node)
> >   *    extensions by an underscore.
> >   */
> >  static struct riscv_isa_ext_data isa_ext_arr[] = {
> > +	__RISCV_ISA_EXT_DATA(zba, RISCV_ISA_EXT_ZBA),
> > +	__RISCV_ISA_EXT_DATA(zbb, RISCV_ISA_EXT_ZBB),
> > +	__RISCV_ISA_EXT_DATA(zbc, RISCV_ISA_EXT_ZBC),
> > +	__RISCV_ISA_EXT_DATA(zbkb, RISCV_ISA_EXT_ZBKB),
> > +	__RISCV_ISA_EXT_DATA(zbkc, RISCV_ISA_EXT_ZBKC),
> > +	__RISCV_ISA_EXT_DATA(zbkx, RISCV_ISA_EXT_ZBKX),
> > +	__RISCV_ISA_EXT_DATA(zbs, RISCV_ISA_EXT_ZBS),
> > +	__RISCV_ISA_EXT_DATA(zknd, RISCV_ISA_EXT_ZKND),
> > +	__RISCV_ISA_EXT_DATA(zkne, RISCV_ISA_EXT_ZKNE),
> > +	__RISCV_ISA_EXT_DATA(zknh, RISCV_ISA_EXT_ZKNH),
> > +	__RISCV_ISA_EXT_DATA(zkr, RISCV_ISA_EXT_ZKR),
> > +	__RISCV_ISA_EXT_DATA(zksed, RISCV_ISA_EXT_ZKSED),
> > +	__RISCV_ISA_EXT_DATA(zksh, RISCV_ISA_EXT_ZKSH),
> > +	__RISCV_ISA_EXT_DATA(zkt, RISCV_ISA_EXT_ZKT),
> >  	__RISCV_ISA_EXT_DATA(sscofpmf, RISCV_ISA_EXT_SSCOFPMF),
> 
> I guess a bit of sorting rule might be helpful, here it's the additions
> above sscofpmf while in the enum it's the other way around.

Here the order is defined by the rule that
"Standard supervisor-level extensions (starts with 'S')
should be listed after standard unprivileged extensions."
You can see the comment above this snippet.
You can also see the for loop in print_isa_ext.

Although I do not know should I place 'Zbs' before 'Zbk*'
or after them as 'Zbk*' belong to scalar crypto but
they are prefixed with "b". It seems it is undecided now.

In the enum it is sorted according to the logical id.
As "This enum represent the logical ID" in
arch/riscv/include/asm/hwcap.h said.

> As the list will get a long longer over time, I guess consistency
> might improve readability.

Agreed. I think changing the internal logical id is
acceptable for me and it brings no API change.

I need feedback on whether I could change the logical id
of the existing sscofpmf extension.

> 
> >  	__RISCV_ISA_EXT_DATA("", RISCV_ISA_EXT_MAX),
> >  };
> > diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeature.c
> > index 1b2d42d7f589..10f9daf3734e 100644
> > --- a/arch/riscv/kernel/cpufeature.c
> > +++ b/arch/riscv/kernel/cpufeature.c
> > @@ -192,6 +192,39 @@ void __init riscv_fill_hwcap(void)
> >  				set_bit(*ext - 'a', this_isa);
> >  			} else {
> >  				SET_ISA_EXT_MAP("sscofpmf", RISCV_ISA_EXT_SSCOFPMF);
> > +				SET_ISA_EXT_MAP("zba"     , RISCV_ISA_EXT_ZBA     );
> 
> not sure if the additional whitespaces are really necessary? [especially the ones at the end]
> What did checkpatch have to say about them?

checkpatch did complain about them. Also checkpatch complaint
about the style issue for PATCH 3/3.
It's my fault not to check style before sending.
Will fix the style issue in the next version.
I think I'll send the next version after getting more feedbacks.

> 
> > +				SET_ISA_EXT_MAP("zbb"     , RISCV_ISA_EXT_ZBB     );
> > +				SET_ISA_EXT_MAP("zbc"     , RISCV_ISA_EXT_ZBC     );
> > +				SET_ISA_EXT_MAP("zbs"     , RISCV_ISA_EXT_ZBS     );
> > +				SET_ISA_EXT_MAP("zbkb"    , RISCV_ISA_EXT_ZBKB    );
> > +				SET_ISA_EXT_MAP("zbkc"    , RISCV_ISA_EXT_ZBKC    );
> > +				SET_ISA_EXT_MAP("zbks"    , RISCV_ISA_EXT_ZBKX    );
> > +				SET_ISA_EXT_MAP("zknd"    , RISCV_ISA_EXT_ZKND    );
> > +				SET_ISA_EXT_MAP("zkne"    , RISCV_ISA_EXT_ZKNE    );
> > +				SET_ISA_EXT_MAP("zknh"    , RISCV_ISA_EXT_ZKNH    );
> > +				SET_ISA_EXT_MAP("zksed"   , RISCV_ISA_EXT_ZKSED   );
> > +				SET_ISA_EXT_MAP("zksh"    , RISCV_ISA_EXT_ZKSH    );
> > +				SET_ISA_EXT_MAP("zkr"     , RISCV_ISA_EXT_ZKR     );
> > +				SET_ISA_EXT_MAP("zkt"     , RISCV_ISA_EXT_ZKT     );
> > +				SET_ISA_EXT_MAP("zkn"     , RISCV_ISA_EXT_ZBKB    );
> > +				SET_ISA_EXT_MAP("zkn"     , RISCV_ISA_EXT_ZBKC    );
> > +				SET_ISA_EXT_MAP("zkn"     , RISCV_ISA_EXT_ZBKX    );
> > +				SET_ISA_EXT_MAP("zkn"     , RISCV_ISA_EXT_ZKND    );
> > +				SET_ISA_EXT_MAP("zkn"     , RISCV_ISA_EXT_ZKNE    );
> > +				SET_ISA_EXT_MAP("zkn"     , RISCV_ISA_EXT_ZKNH    );
> > +				SET_ISA_EXT_MAP("zks"     , RISCV_ISA_EXT_ZBKB    );
> > +				SET_ISA_EXT_MAP("zks"     , RISCV_ISA_EXT_ZBKC    );
> > +				SET_ISA_EXT_MAP("zks"     , RISCV_ISA_EXT_ZBKX    );
> > +				SET_ISA_EXT_MAP("zks"     , RISCV_ISA_EXT_ZKSED   );
> > +				SET_ISA_EXT_MAP("zks"     , RISCV_ISA_EXT_ZKSH    );
> > +				SET_ISA_EXT_MAP("zk"      , RISCV_ISA_EXT_ZBKB    );
> > +				SET_ISA_EXT_MAP("zk"      , RISCV_ISA_EXT_ZBKC    );
> > +				SET_ISA_EXT_MAP("zk"      , RISCV_ISA_EXT_ZBKX    );
> > +				SET_ISA_EXT_MAP("zk"      , RISCV_ISA_EXT_ZKND    );
> > +				SET_ISA_EXT_MAP("zk"      , RISCV_ISA_EXT_ZKNE    );
> > +				SET_ISA_EXT_MAP("zk"      , RISCV_ISA_EXT_ZKNH    );
> > +				SET_ISA_EXT_MAP("zk"      , RISCV_ISA_EXT_ZKR     );
> > +				SET_ISA_EXT_MAP("zk"      , RISCV_ISA_EXT_ZKT     );
> >  			}
> >  #undef SET_ISA_EXT_MAP
> >  		}
> > 
> 
> 
> 
> 
