Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3786A5247E3
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 10:30:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351458AbiELI2e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 04:28:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351449AbiELI2a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 04:28:30 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D95842181CD
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 01:28:28 -0700 (PDT)
Received: from kwepemi500013.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4KzPwx4cDmzGpj2;
        Thu, 12 May 2022 16:25:37 +0800 (CST)
Received: from M910t (10.110.54.157) by kwepemi500013.china.huawei.com
 (7.221.188.120) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Thu, 12 May
 2022 16:28:25 +0800
Date:   Thu, 12 May 2022 16:28:20 +0800
From:   Changbin Du <changbin.du@huawei.com>
To:     Nick Desaulniers <ndesaulniers@google.com>
CC:     Changbin Du <changbin.du@huawei.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Steven Rostedt <rostedt@goodmis.org>, <hw.huiwang@huawei.com>,
        <linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <llvm@lists.linux.dev>, <codegen-riscv@discourse.llvm.org>,
        <llvmproject@discourse.llvm.org>, <craig.topper@sifive.com>,
        <asb@asbradbury.org>
Subject: Re: riscv: llvm-compiler: calling convention violation: temporary
 register $t2 is used to pass the ninth function parameter
Message-ID: <20220512082820.7t2rwwo3fffgwoxn@M910t>
References: <20220510065336.hlfjrc25ajed5zj4@M910t>
 <CAKwvOd=OnJ=ZhsbX+epzbhg3sWg9yOaR=zQ4jF_Deo=B8Nx9Og@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CAKwvOd=OnJ=ZhsbX+epzbhg3sWg9yOaR=zQ4jF_Deo=B8Nx9Og@mail.gmail.com>
X-Originating-IP: [10.110.54.157]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemi500013.china.huawei.com (7.221.188.120)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URI_DOTEDU autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 11, 2022 at 11:39:07AM -0700, Nick Desaulniers wrote:
> On Mon, May 9, 2022 at 11:54 PM Changbin Du <changbin.du@huawei.com> wrote:
> >
[snip]
> > I also built a simple test function with 9 parameters by clang and same cflags,
> > but cannot reproduce it. Maybe it is conditional?
> >
> > Simple test code:
> > __attribute__ ((noinline))
> > void test_func(int *a, int *b, int *c, int *d, int *e, int *f, int *g, int *h, int *i)
> > {
> >         printf("__find_rr_leaf: %d\n", *i);
> > }
> >
> > int main(void)
> > {
> >         int a,b,c,d,e,f,g,h,i = 100;
> >
> >         test_func(&a,&b,&c,&d,&e,&f,&g,&h,&i);
> >         return 0;
> > }
> 
> Hmm...any chance you could come up with a more concise test case then
> using creduce [0] or cvise [1]?
> [0] https://embed.cs.utah.edu/creduce/
> [1] https://github.com/marxin/cvise
> 
>
okay, let me try to reduce the orignal source with creduce.

> 
> 
> -- 
> Thanks,
> ~Nick Desaulniers

-- 
Cheers,
Changbin Du
