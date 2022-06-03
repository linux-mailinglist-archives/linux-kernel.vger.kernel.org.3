Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE3DC53C384
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Jun 2022 06:09:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230459AbiFCEJI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Jun 2022 00:09:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbiFCEJF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jun 2022 00:09:05 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC3E12A274
        for <linux-kernel@vger.kernel.org>; Thu,  2 Jun 2022 21:09:03 -0700 (PDT)
Received: from kwepemi500013.china.huawei.com (unknown [172.30.72.56])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4LDqBR6ZxPzKmHw;
        Fri,  3 Jun 2022 12:08:47 +0800 (CST)
Received: from M910t (10.110.54.157) by kwepemi500013.china.huawei.com
 (7.221.188.120) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Fri, 3 Jun
 2022 12:08:59 +0800
Date:   Fri, 3 Jun 2022 12:08:52 +0800
From:   Changbin Du <changbin.du@huawei.com>
To:     Nathan Chancellor <nathan@kernel.org>
CC:     Changbin Du <changbin.du@huawei.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>, <changbin.du@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, Hui Wang <hw.huiwang@huawei.com>,
        <linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <llvm@lists.linux.dev>
Subject: Re: riscv: alternatives: move length validation inside the subsection
Message-ID: <20220603040852.uduno354yrdyexs3@M910t>
References: <20220602112734.it2bzlqaismotjof@M910t>
 <YpjMdVjLzoIoSGz9@dev-arch.thelio-3990X>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <YpjMdVjLzoIoSGz9@dev-arch.thelio-3990X>
X-Originating-IP: [10.110.54.157]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemi500013.china.huawei.com (7.221.188.120)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 02, 2022 at 07:43:01AM -0700, Nathan Chancellor wrote:
> On Thu, Jun 02, 2022 at 07:27:34PM +0800, Changbin Du wrote:
> > Apply the same fix from commit 966a0acce2fc ("arm64/alternatives: move
> > length validation inside the subsection") to riscv.  Due to the one-pass
> > design of LLVM's integrated assembler, it can not compute the length of
> > instructions if the .org directive is outside of the subsection that these
> > instructions are in.
> > 
> > Here is the build error reported by llvm:
> > 
> > In file included from ./arch/riscv/include/asm/pgtable.h:108:
> > ./arch/riscv/include/asm/tlbflush.h:23:2: error: expected assembly-time absolute expression
> >         ALT_FLUSH_TLB_PAGE(__asm__ __volatile__ ("sfence.vma %0" : : "r" (addr) : "memory"));
> >         ^
> > ./arch/riscv/include/asm/errata_list.h:41:5: note: expanded from macro 'ALT_FLUSH_TLB_PAGE'
> > asm(ALTERNATIVE("sfence.vma %0", "sfence.vma", SIFIVE_VENDOR_ID,        \
> >     ^
> > ./arch/riscv/include/asm/alternative-macros.h:187:2: note: expanded from macro 'ALTERNATIVE'
> >         _ALTERNATIVE_CFG(old_content, new_content, vendor_id, errata_id, CONFIG_k)
> >         ^
> > ./arch/riscv/include/asm/alternative-macros.h:113:2: note: expanded from macro '_ALTERNATIVE_CFG'
> >         __ALTERNATIVE_CFG(old_c, new_c, vendor_id, errata_id, IS_ENABLED(CONFIG_k))
> >         ^
> > ./arch/riscv/include/asm/alternative-macros.h:110:2: note: expanded from macro '__ALTERNATIVE_CFG'
> >         ALT_NEW_CONTENT(vendor_id, errata_id, enable, new_c)
> >         ^
> > ./arch/riscv/include/asm/alternative-macros.h:98:3: note: expanded from macro 'ALT_NEW_CONTENT'
> >         ".org   . - (887b - 886b) + (889b - 888b)\n"                    \
> >          ^
> > <inline asm>:25:6: note: instantiated into assembly here
> > .org    . - (887b - 886b) + (889b - 888b)
> >         ^
> > 
> > Signed-off-by: Changbin Du <changbin.du@gmail.com>
> 
> Thanks for the patch! I already sent an equivalent change two weeks ago
> as https://lore.kernel.org/20220516214520.3252074-1-nathan@kernel.org/,
> which I think is slightly better because it handles the __ASSEMBLY__
> version of the macro as well.
> 
Agreed. Thank you, and please ignore this one.

> Cheers,
> Nathan
> 
