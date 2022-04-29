Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 690E9515319
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 19:59:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379800AbiD2SCm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 14:02:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231160AbiD2SCk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 14:02:40 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DDF08FFB7
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 10:59:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3AA27B8376D
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 17:59:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29E19C385A4;
        Fri, 29 Apr 2022 17:59:18 +0000 (UTC)
Date:   Fri, 29 Apr 2022 13:59:16 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        llvm@lists.linux.dev, Michael Ellerman <mpe@ellerman.id.au>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>
Subject: Re: [PATCH v2 2/2] ftrace: recordmcount: Handle sections with no
 non-weak symbols
Message-ID: <20220429135916.47c3e623@gandalf.local.home>
In-Reply-To: <1651252324.js9790ngjg.naveen@linux.ibm.com>
References: <cover.1651166001.git.naveen.n.rao@linux.vnet.ibm.com>
        <126aca34935cf1c7168e17970c706e36577094e7.1651166001.git.naveen.n.rao@linux.vnet.ibm.com>
        <20220428184212.18fbf438@gandalf.local.home>
        <1651252324.js9790ngjg.naveen@linux.ibm.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 29 Apr 2022 23:09:19 +0530
"Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com> wrote:

> If I'm understanding your suggestion right:
> - we now create a new section in each object file: __mcount_loc_weak, 
>   and capture such relocations using weak symbols there.

Yes, but it would be putting the same information it puts into __mcount_loc
but also add it here too. That is, it will duplicate the data.

> - we then ask the linker to put these separately between, say, 
>   __start_mcount_loc_weak and __stop_mcount_loc_weak

Yes, but it will also go in the location between __start_mcount_loc and
__stop_mcount_loc.

> - on ftrace init, we go through entries in this range, but discard those 
>   that belong to functions that also have an entry between 
>   __start_mcount_loc and __stop_mcount loc.

But we should be able to know if it was overridden or not, by seeing if
there's another function that was called. Or at least, we can validate them
to make sure that they are correct.

> 
> The primary issue I see here is that the mcount locations within the new 
> weak section will end up being offsets from a different function in 
> vmlinux, since the linker does not create a symbol for the weak 
> functions that were over-ridden.

The point of this section is to know which functions in __mcount_loc may
have been overridden, as they would be found in the __mcount_loc_weak
section. And then we can do something "special" to them.

> 
> As an example, in the issue described in this patch set, if powerpc 
> starts over-riding kexec_arch_apply_relocations(), then the current weak 
> implementation in kexec_file.o gets carried over to the final vmlinux, 
> but the instructions will instead appear under the previous function in 
> kexec_file.o: crash_prepare_elf64_headers(). This function may or may 
> not be traced to begin with, so we won't be able to figure out if this 
> is valid or not.

If it was overridden, then there would be two entries for function that
overrides the weak function in the __mcount_loc section, right? One for the
new function, and one that was overridden. Of course this could be more
complex if the new function had been marked notrace.

I was thinking of doing this just so that we know what functions are weak
and perhaps need extra processing.

Another issue with weak functions and ftrace just came up here:

  https://lore.kernel.org/all/20220428095803.66c17c32@gandalf.local.home/


-- Steve
