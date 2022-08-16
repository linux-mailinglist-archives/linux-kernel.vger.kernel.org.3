Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BD75595E0D
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 16:06:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235901AbiHPOFu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 10:05:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235952AbiHPOEc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 10:04:32 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D76B86610C
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 07:04:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B88A5B819C9
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 14:04:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACAB4C433C1;
        Tue, 16 Aug 2022 14:04:15 +0000 (UTC)
Date:   Tue, 16 Aug 2022 10:04:23 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Cc:     Michael Ellerman <mpe@ellerman.id.au>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        <linux-kernel@vger.kernel.org>, <linuxppc-dev@lists.ozlabs.org>,
        llvm@lists.linux.dev
Subject: Re: [PATCH 0/2] ftrace/recordmcount: Handle object files without
 section symbols
Message-ID: <20220816100423.5ee2e17c@gandalf.local.home>
In-Reply-To: <cover.1651047542.git.naveen.n.rao@linux.vnet.ibm.com>
References: <cover.1651047542.git.naveen.n.rao@linux.vnet.ibm.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 27 Apr 2022 15:01:20 +0530
"Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com> wrote:

> This solves a build issue on powerpc with binutils v2.36 and newer [1].
> Since commit d1bcae833b32f1 ("ELF: Don't generate unused section
> symbols") [2], binutils started dropping section symbols that it thought
> were unused. Due to this, in certain scenarios, recordmcount is unable 
> to find a non-weak symbol to generate a relocation record against.
> 
> Clang integrated assembler is also aggressive in dropping section 
> symbols [3].
> 
> In the past, there have been various workarounds to address this. See 
> commits 55d5b7dd6451b5 ("initramfs: fix clang build failure") and 
> 6e7b64b9dd6d96 ("elfcore: fix building with clang") and a recent patch:
> https://lore.kernel.org/linuxppc-dev/20220425174128.11455-1-naveen.n.rao@linux.vnet.ibm.com/T/#u
> 
> Fix this issue by using the weak symbol in the relocation record. This 
> can result in duplicate locations in the mcount table if those weak 
> functions are overridden, so have ftrace skip dupicate entries.
> 
> Objtool already follows this approach, so patch 2 updates recordmcount 
> to do the same. Patch 1 updates ftrace to skip duplicate entries.
> 
> - Naveen
> 
> 
> [1] https://github.com/linuxppc/issues/issues/388
> [2] https://sourceware.org/git/?p=binutils-gdb.git;a=commit;h=d1bcae833b32f1
> [3] https://github.com/ClangBuiltLinux/linux/issues/981
> 
>

There's been work to handle weak functions, but I'm not sure that work
handled the issues here. Are these patches still needed, or was there
another workaround to handle the problems this addressed?

-- Steve
