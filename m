Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C8935154D6
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 21:47:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380385AbiD2Tuw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 15:50:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238988AbiD2Tut (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 15:50:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 659F1D4CAA
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 12:47:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BD981612FD
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 19:47:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51AE2C385A4;
        Fri, 29 Apr 2022 19:47:28 +0000 (UTC)
Date:   Fri, 29 Apr 2022 15:47:26 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        llvm@lists.linux.dev, Michael Ellerman <mpe@ellerman.id.au>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>
Subject: Re: [PATCH v2 2/2] ftrace: recordmcount: Handle sections with no
 non-weak symbols
Message-ID: <20220429154726.19f72a1a@gandalf.local.home>
In-Reply-To: <1651257788.xtscezsfky.naveen@linux.ibm.com>
References: <cover.1651166001.git.naveen.n.rao@linux.vnet.ibm.com>
        <126aca34935cf1c7168e17970c706e36577094e7.1651166001.git.naveen.n.rao@linux.vnet.ibm.com>
        <20220428184212.18fbf438@gandalf.local.home>
        <1651252324.js9790ngjg.naveen@linux.ibm.com>
        <20220429135916.47c3e623@gandalf.local.home>
        <1651257788.xtscezsfky.naveen@linux.ibm.com>
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

On Sat, 30 Apr 2022 01:03:01 +0530
"Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com> wrote:

> > The point of this section is to know which functions in __mcount_loc may
> > have been overridden, as they would be found in the __mcount_loc_weak
> > section. And then we can do something "special" to them.  
> 
> I'm not sure I follow that. How are you intending to figure out which 
> functions were overridden by looking at entries in the __mcount_loc_weak 
> section?

If there's duplicates (or something strange with the offset) then we could
delete the one that has the match in the weak section.

> 
> In the final vmlinux image, we only get offsets into .text for all 
> mcount locations, but no symbol information. The only hint is the fact 
> that a single kallsym symbol has multiple mcount locations within it. 
> Even then, the symbol with duplicate mcount entries won't be the 
> function that was overridden.
> 
> We could do a kallsyms_lookup() on each entry and consult the 
> __mcount_loc_weak section to identify duplicates, but that looks to be 
> very expensive.
> 
> Did you have a different approach in mind?

We only need to look at the ones in the weak section. How many that is may
determine if that's feasible or not.

> 
> >   
> >> 
> >> As an example, in the issue described in this patch set, if powerpc 
> >> starts over-riding kexec_arch_apply_relocations(), then the current weak 
> >> implementation in kexec_file.o gets carried over to the final vmlinux, 
> >> but the instructions will instead appear under the previous function in 
> >> kexec_file.o: crash_prepare_elf64_headers(). This function may or may 
> >> not be traced to begin with, so we won't be able to figure out if this 
> >> is valid or not.  
> > 
> > If it was overridden, then there would be two entries for function that
> > overrides the weak function in the __mcount_loc section, right? One for the
> > new function, and one that was overridden.  
> 
> In the final vmlinux, we will have two entries: one pointing at the 
> correct function, while the other will point to some other function 
> name. So, at least from kallsym perspective, duplicate mcount entries 
> won't be for the function that was overridden, but some arbitrary 
> function that came before the weak function in the object file.

Right, and we should be able to find them.

> 
> > Of course this could be more
> > complex if the new function had been marked notrace.
> > 
> > I was thinking of doing this just so that we know what functions are weak
> > and perhaps need extra processing.
> > 
> > Another issue with weak functions and ftrace just came up here:
> > 
> >   https://lore.kernel.org/all/20220428095803.66c17c32@gandalf.local.home/  
> 
> I noticed this just yesterday:
> 
>   # cat available_filter_functions | sort | uniq -d | wc -l
>   430
> 
> I'm fairly certain that some of those are due to weak functions -- I 
> just wasn't sure if all of those were.

Probably :-/

> 
> I suppose this will now also be a problem with ftrace_location(), given 
> that it was recently changed to look at an entire function for mcount 
> locations?
> 

Maybe. I have to focus on other things at the moment, but I'll try to find
some time to look at this deeper.

-- Steve
