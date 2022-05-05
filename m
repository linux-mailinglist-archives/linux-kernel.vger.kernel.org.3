Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E99A51B942
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 09:36:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345355AbiEEHk1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 03:40:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345357AbiEEHkY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 03:40:24 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACF0248E59;
        Thu,  5 May 2022 00:36:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=wcYnBFlZFnuL55r/7R4vP4SWucs4Cfa2ZGuWm0/JeN4=; b=Mef7Zg8e6eUtD1INYhQtlDQDK2
        TnLMqT87vd+VUwl51mcl7AmONX5pV/tgJ0uw7oTAwA7caDwbAukT4DnHzM8KLsHAsS9h9m+DgpXuG
        +vZiTI4lrPOlk+6McJj9+HclMTCtZGIETMOAMT5HqfbSX5vWN6kdGECWPnC2bc6QU14ROKZ/njaTk
        P/frbgH2tbsIm+YynyjOXa/y3RbefwHuSkpyLgOuwHCTiJpEqGhu595W7vOTiU7+3kkTAFKsBRGbx
        2HEU+isTfSeF35GTlMtDZkhil0YktLztT2YFIxRy6Xht0XtGFMZdpMqVPuxA3tnx+vbxF/Ljm5v+Z
        GEa2qq6g==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nmW2D-00HN1E-Dk; Thu, 05 May 2022 07:36:25 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id EBDE8980DFE; Thu,  5 May 2022 09:36:22 +0200 (CEST)
Date:   Thu, 5 May 2022 09:36:22 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Sami Tolvanen <samitolvanen@google.com>
Cc:     Peter Collingbourne <pcc@google.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Joao Moreira <joao@overdrivepizza.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-hardening@vger.kernel.org, andrew.cooper3@citrix.com,
        Kees Cook <keescook@chromium.org>,
        Mark Rutland <mark.rutland@arm.com>, hjl.tools@gmail.com,
        alyssa.milburn@linux.intel.com,
        Nick Desaulniers <ndesaulniers@google.com>,
        gabriel.gomes@linux.intel.com, rick.p.edgecombe@intel.com
Subject: Re: [RFC PATCH 01/11] x86: kernel FineIBT
Message-ID: <20220505073622.GC2501@worktop.programming.kicks-ass.net>
References: <20220420004241.2093-1-joao@overdrivepizza.com>
 <20220420004241.2093-2-joao@overdrivepizza.com>
 <20220429013704.4n4lmadpstdioe7a@treble>
 <d82459b887bcaf9181ad836051e2d16b@overdrivepizza.com>
 <20220503220244.vyz5flk3gg3y6rbw@treble>
 <YnJTYzralOhGGmED@hirez.programming.kicks-ass.net>
 <YnKx5a9WvJ1UhWPm@google.com>
 <YnLDGcJGKfqi5+8w@hirez.programming.kicks-ass.net>
 <CABCJKueqqq-keiyE8tYJQtfitxQt08vQwEfG41C8t3aJC8AwKQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABCJKueqqq-keiyE8tYJQtfitxQt08vQwEfG41C8t3aJC8AwKQ@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 04, 2022 at 05:28:57PM -0700, Sami Tolvanen wrote:
> On Wed, May 4, 2022 at 11:17 AM Peter Zijlstra <peterz@infradead.org> wrote:
> > __cfi_\sym:                                     __cfi_\sym:
> >                                                         int3; int3                              # 2
> >         endbr                   # 4                     mov     \hash, %eax                     # 5
> >         call    __fineibt_\hash # 5                     int3; int3                              # 2
> > \sym:                                           \sym:
> 
> OK, that looks reasonable to me.
> 
> > It seems to preserve the properties of the last one in that direct calls
> > will already be correct and we don't need linker fixups, and objtool can
> > simply parse the preamble as regular instructions without needing
> > further help.
> 
> Wouldn't objtool still print out unreachable instruction warnings here?

Depends a bit on what kind of symbol they end up being, if they're
STT_FUNC we'll probably get the complaint that it falls through into the
next symbol, while if they're STT_NOTYPE then yes, we'll get the
unreachable thing.

So either way we need to special case the __cfi_\sym things anyway.

But that should be relatively straight forward. I think I would lean
towards making then STT_FUNC (they really are for FineIBT anyway) and
then supressing the fallthrough warning for all functions that start
with "__cfi_". This way we get an ORC entry for them and the unwinder
will be happy.
