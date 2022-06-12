Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5B8C547B72
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Jun 2022 20:21:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232764AbiFLSVK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Jun 2022 14:21:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229554AbiFLSVI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Jun 2022 14:21:08 -0400
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01on2134.outbound.protection.outlook.com [40.107.114.134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48A114550D
        for <linux-kernel@vger.kernel.org>; Sun, 12 Jun 2022 11:21:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OCmvIN6eSIsjiQCzOIo6KtSBusEMLLzL7+DTVg2vauVBlG6r4cdRTxGgPXYrQ6qOPF3pb8gNDPOCaoAha0ZN8ScUXLlwu5U8bbSUboeT5MWPzJEt8psx04SATq3d3MJsZ+Il2RXdaDWux4nb79EOFofi0ZTEt+WGJD9uagU0+h34LkTFVxJXKzxrvorq3/dv9R1QedpVVFQgoziji6Fu7lmnmJAmrsWVliwOhLRd0Oae2Iwj05v1CT912jHQbzJuWxhIUkRwBiJ+hSw59IOQ1nB0NVgVqexwe6AmKSGhlMco8168MpsiEsp+MysiTzGDJiAWJWlu6PrFXvk5leMWaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+E75zd4cORogddjglPcXpX9Ngq8HGQkNzEOjLfD5Wyc=;
 b=I2tiPQ/vmrJ1+bsRFwu80SGMWNNP88prTEMiZWbmyOV6MnmjFgogOWAsHTDQQOazNpiG7e2lp7PRgh1V3/1pJvTKskEt+YDy8JftxK8kGDFkaAk4G1JoU+HFMc1DsQpc0P/QFhcEWo6QnJWPKCuuJYcnTNKVfUkPCBMyrk2FnS28iDNf6l/Pz9viOHlL7y4xQp9Jk0pc5e6nu1wShHgibyNuh5Nndh0+xdXHEbC7C67AHkhD8B2d5XNkh3EgXlFb3j1DvFpG5xFE9ijentmT0cin5TCGZ0TYj38ZOX4YYmi9zNbCU6gm+gFmXMdLiu9XmddtdAZoBbI5q0cOeWCQBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=zenithal.me; dmarc=pass action=none header.from=zenithal.me;
 dkim=pass header.d=zenithal.me; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zenithal.me;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+E75zd4cORogddjglPcXpX9Ngq8HGQkNzEOjLfD5Wyc=;
 b=Qnv4HxGded6Fyv5/DBNcl4TePZEjiMyPMqAF1w+kVSbIwN/AyGCw/HFltCt8GgNG1APZscgT8kmapNs0K3/TRUqMRXh7kAKbxvlITA2sE6z9fNmVAB8IzRYYv+UbNN1MmPpeN+jnkAXt8EA4ayMmwPHYMrked3hu13zHJykiXH0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=zenithal.me;
Received: from TYCP286MB1393.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:c0::6) by
 TYBP286MB0189.JPNP286.PROD.OUTLOOK.COM (2603:1096:404:802b::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.13; Sun, 12 Jun
 2022 18:21:04 +0000
Received: from TYCP286MB1393.JPNP286.PROD.OUTLOOK.COM
 ([fe80::a162:2f17:bb41:c95]) by TYCP286MB1393.JPNP286.PROD.OUTLOOK.COM
 ([fe80::a162:2f17:bb41:c95%9]) with mapi id 15.20.5332.020; Sun, 12 Jun 2022
 18:21:04 +0000
Date:   Mon, 13 Jun 2022 02:20:57 +0800
From:   Hongren Zheng <i@zenithal.me>
To:     Palmer Dabbelt <palmer@rivosinc.com>
Cc:     Kito Cheng <kito.cheng@gmail.com>,
        Nelson Chu <nelson.chu@sifive.com>,
        Atish Patra <atishp@rivosinc.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] RISC-V: cpu.c: remove nonexistent ext from cpuinfo
Message-ID: <YqYuiVwarHnbggtf@Sun>
References: <YoSw8lNHJqRDy6lg@Sun>
 <mhng-7b349805-02ff-47b3-b9b5-31dcbd2bb256@palmer-ri-x1c9>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <mhng-7b349805-02ff-47b3-b9b5-31dcbd2bb256@palmer-ri-x1c9>
X-Operating-System: Linux Sun 5.15.26
X-Mailer: Mutt 2.2.1 (2022-02-19)
X-ClientProxiedBy: SJ0PR03CA0368.namprd03.prod.outlook.com
 (2603:10b6:a03:3a1::13) To TYCP286MB1393.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:c0::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b38b36b2-de67-4064-4443-08da4ca04f74
X-MS-TrafficTypeDiagnostic: TYBP286MB0189:EE_
X-Microsoft-Antispam-PRVS: <TYBP286MB0189989308F9A364A2800769BCA89@TYBP286MB0189.JPNP286.PROD.OUTLOOK.COM>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XupK7bdjhBcSGRsrjCJlVdY81t33wip8GpKUDbzmJkQZB5WMNsiNbt/4NgLYvN3DolPs9l4ZEoaQgH04hikit8NLMGJsnGnf1Z1zNvwFBFdIVfhChV6/qe/qYYVcx4DBEFzWii30se5H8PnMW7ZnD85dl1mkPqUA+8FL1wTJcYIpEbNPDBaSJIZdQZnXJe5aaJW9sPTctGBDaBeWVdzIKY5lwENBGh9aRPByc8raV6+1iduf1dJ+lvBODM124XUWk0hlKrF7POOD4VMCEEMJ9HBhT43eCgZ6ONjIUNur96XX3VroFpndsAb/xeQiL9jwwFXLcXAgwCP93rl22MvjbpqUbRgRJ85NwFDSL/JTQ2oml3KUxjCP6rAR1zgAMhPagCeAOxQRfXa6Qm8A4T2ZJxpj+krZttMtcRdz8t4iWK/x4sv4/Z9jStJDvHgxUsLdzDcT0crsqQjnHR4jdDUunBjtyS75larAqGDAoxIouWsqcaQjalMmVgHuDvzAKliEGmPzCBSFcLfr0ol+iBtL9C4uo0/+NX123McqiujT2Of+I7CtAcY3m22OlSGH4o7QMDWBx4P/NLnrY0rUUIlkBAzk9xfjNkH6uX+2I1kPDj41toBU33RCotBz16Wy0PEaWdfcfus05+pFqg7Guszqb+dTD7p79CQP0nHX0WOE3pSv/CGXw47x6Y60un50HF7s9tW6d5isKugPDWmPKhr7SptsID2C7UERAba83txtYXPg8CtU75BmRBQ7xLaC5UKl3LMkWcrfBmiqoMIl2a4d3w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCP286MB1393.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230016)(7916004)(39830400003)(346002)(396003)(136003)(366004)(41300700001)(2906002)(6666004)(8936002)(9686003)(6512007)(5660300002)(966005)(6486002)(508600001)(41320700001)(52116002)(6506007)(66476007)(786003)(316002)(6916009)(54906003)(33716001)(38100700002)(8676002)(4326008)(86362001)(186003)(66556008)(83380400001)(66946007)(49092004);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?kYn40gKDa5h3VTF9DnPBaDVZCWdoIjcPo9Uc5v+Mcie5e3uaAxsz3fzRrNsI?=
 =?us-ascii?Q?igZSnCmB0dng+CJ3qpZWTyB12twGOpvDtAQCHSfrk4lu5Hl7Vzy5QS9jlQng?=
 =?us-ascii?Q?kvamMEZyuQCl1nGQLngKc/KdjiDsKWh8Jb87GMav3oIR9ETroaf+zbfn8pMy?=
 =?us-ascii?Q?l2SR6miwGI9cKCy+HlPZFMXixHfGRKbUIbq5O1nKBR3Lv35A3T5ZyryDJT9K?=
 =?us-ascii?Q?DCNqMcycTNYa+tq80Kc5SWfum0QrWgezUuwlx70C6spD6Gl4nqOrSbfgV9J7?=
 =?us-ascii?Q?tYvS/4lVzVGZnT2CHEagVjLRNkH5cc/mjdMAqoRmMIUcroyCxHE3B5FEF2Pf?=
 =?us-ascii?Q?rzlgkT3sX5QxDrChxHE3C4aqaJBIQkpPSExzn6uueYejwJDEDQHi3Yr/QK9d?=
 =?us-ascii?Q?0DXhdD8EBynbQ+6pXvC1/NdzPOdb8BTKQuArHg+JN3/OxAhJrVALfKSWiu0n?=
 =?us-ascii?Q?D1hrJNA7kOGPNwYXGkXU+UrPd1A90GWhZkwyqaljna5G5vqjPLX6sBgbNFjF?=
 =?us-ascii?Q?6ljzJU265sudKAdf0AgBEgAoHbgba7wVddci57l3ZoxBUGmWJaTHSx/ZLUVy?=
 =?us-ascii?Q?1RvboTkGbU8HQ48P3QSU+midbMWou4N99Y2nekW4Vl79gyc6bOuGBE93fm8m?=
 =?us-ascii?Q?2VbqXPRBl9mm+UmYxayD0rnKb1dNXC5CZp7SDqoP6HQN6vyA7xmfx30t6QFV?=
 =?us-ascii?Q?YvjmxR4fnl2WpuP5w6BDfY6LyFYhDPdCc9hSIQzGoxnXlkaxJN+0g6a8+9Xr?=
 =?us-ascii?Q?ieT/y6+mk8MSTLl15MRWNvBNK9Dku2V2777avW02+k8A5HnYjYRMxoVAIYLy?=
 =?us-ascii?Q?xj/Fva/ox0Y6LmZ7A2LmJbwm5YGPfXVug3TErJZ2BLth4ZfgdBabH5aFinCn?=
 =?us-ascii?Q?metMr7YXUcaHhUZR/zxBno6o6ZiwDIGcYpy7j5o7SEoaOXcx36otxGhA12RX?=
 =?us-ascii?Q?atV1nvw32AVjQxQmsrwy1IB+ZQaGrz8XoxXDEmqLHFSRhQGtRtSxW/Jx+fXg?=
 =?us-ascii?Q?26YxYu+l15j2d/ltiPSjHVt1yiRtAW4RNobpR40GnzVNcEQIPnKw3oFe5vWX?=
 =?us-ascii?Q?uRJ34HiO+W9rdb176WrIyv++MMbEQ8TUhPpcTHDsvPUjYCipms5G7DrMeBRM?=
 =?us-ascii?Q?U1gJUdRrtlPg70Kz94dF3DBvdDOT94xs859MShREfqZLfs5Ijz0khLHoBI94?=
 =?us-ascii?Q?zFRyhhW9ENGIdZI+VcMwbd90Y9OLSgRHznN185GvfckJfRXWFTb0YPsLd3Ij?=
 =?us-ascii?Q?SHyvPQcFbt+nlOfCvz+EDKlqnnyw1zI4b5JsGCVwUJ4T2uz4bpwTqaSXjZb9?=
 =?us-ascii?Q?MVElxt2nT+aG3f2R7O65004HPPzrDe6SHVcaqNlU6WhOmx9ROzVfpvJNPk87?=
 =?us-ascii?Q?apKgJXKV9I/PJpKxWwO4tkAzezZqU3IZRtsOKDxInsqVgJtRkftiVHCjjRrp?=
 =?us-ascii?Q?pBCmgu2by6FYa4Zq/0z/IGKvjHXr0eBs/HLG6NmX3DNg02v69BrMNluINiCj?=
 =?us-ascii?Q?IBuXTF0FltOO/x+/pGG5xjdPAtPDZpUZl5AOrJyCdWuj5AmLI8L/2/nyE+MV?=
 =?us-ascii?Q?TgXxU9LzrncKX0bEDp9HJRpOhWcCCRetuyk5eNAH1kKDVpf0QM9MF/CJRtP3?=
 =?us-ascii?Q?UaCq6Ypf675svu/23ZlNcsDyj4/UFZUYjgAU91+RpSahRJDDe0PscGuJF+sP?=
 =?us-ascii?Q?OX2NQHASaTwG/fQkmET0cHDFMSeddMkFwhdOiiJZNqMlIbzyaNK8Ue/891CU?=
 =?us-ascii?Q?rypLkSu7PA=3D=3D?=
X-OriginatorOrg: zenithal.me
X-MS-Exchange-CrossTenant-Network-Message-Id: b38b36b2-de67-4064-4443-08da4ca04f74
X-MS-Exchange-CrossTenant-AuthSource: TYCP286MB1393.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2022 18:21:03.8938
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 436d481c-43b1-4418-8d7f-84c1e4887cf0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PY8LTWzjw1ZX6dtLaZMB5+95IBjo+6fsQV/fLIkCqLoQHxafsnCQ2bZSEf6W5uyo
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYBP286MB0189
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 01, 2022 at 08:52:42PM -0700, Palmer Dabbelt wrote:
> On Wed, 18 May 2022 01:40:18 PDT (-0700), i@zenithal.me wrote:
> > On Tue, Apr 26, 2022 at 06:08:01AM +0800, Hongren (Zenithal) Zheng wrote:
> > > There are no single-letter B/K/J extentions,
> > > as they are never ratified. For P, it is still in
> > > progress and not ratified.
> > > 
> > > The ordering constraint of these placerholders is now removed
> > > from the spec. By commit ("Delete more nonexistent
> > > extensions from the naming constraints") of riscv/riscv-isa-manual
> > 
> > Hi, is there any further update on this patch?
> 
> IIRC there was some debate as to whether that change constituted an
> incompatible change to the spec, but I guess it's stuck around for long
> enough that maybe we should count on it being canon now?  I added Kito and
> Nelson, there's a GNU toolchain call tomorrow morning so hopefully we can
> remember to talk about it...

Hi, I'm curious about the output of the meeting, any update on this?

> 
> > 
> > > 
> > > Signed-off-by: Hongren (Zenithal) Zheng <i@zenithal.me>
> > > ---
> > >  arch/riscv/kernel/cpu.c | 4 +---
> > >  1 file changed, 1 insertion(+), 3 deletions(-)
> > > 
> > > diff --git a/arch/riscv/kernel/cpu.c b/arch/riscv/kernel/cpu.c
> > > index ccb617791e56..53a061ab0743 100644
> > > --- a/arch/riscv/kernel/cpu.c
> > > +++ b/arch/riscv/kernel/cpu.c
> > > @@ -113,10 +113,8 @@ static void print_isa_ext(struct seq_file *f)
> > >  /*
> > >   * These are the only valid base (single letter) ISA extensions as per the spec.
> > >   * It also specifies the canonical order in which it appears in the spec.
> > > - * Some of the extension may just be a place holder for now (B, K, P, J).
> > > - * This should be updated once corresponding extensions are ratified.
> > >   */
> > > -static const char base_riscv_exts[13] = "imafdqcbkjpvh";
> > > +static const char base_riscv_exts[9] = "imafdqcvh";
> > 
> > The base_riscv_exts "imafdqcvh" is exactly the spec now, as
> > https://github.com/riscv/riscv-isa-manual/commit/db7a4a0dad0e99d1ec1fc67b582624fc0aeae98e
> > (Add single-letter "H" extension to the table)
> > has shown
> 
> Oddly enough I stumbled upon that one this morning, it's another one of
> these like the HPM stuff: we used to say "there's no letter describing the
> hypervisor behavior, so it's part of the base" (see the commentary on the
> binutils patch), but now that there's a letter I'm assuming we should split
> that out?

I'm afraid I could not help here because I'm not familiar with this area.

> 
> Not clear if the RISC-V folks want H to be ignored by software like those
> other recent changes, and if so it's also not clear that's a good idea.
> 
> Anyway, sorry this is taking a while but I think it's going to be too late
> for this merge window -- kind of silly for such a small patch, but it's got
> interface implications and it's all a bit of a hot topic right now.
> 
> > 
> > > 
> > >  static void print_isa(struct seq_file *f, const char *isa)
> > >  {
> > > --
> > > 2.35.1
> > > 
