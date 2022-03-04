Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CFC24CDEBA
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 21:26:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229937AbiCDUYH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Mar 2022 15:24:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229869AbiCDUYC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 15:24:02 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E44620D505
        for <linux-kernel@vger.kernel.org>; Fri,  4 Mar 2022 12:23:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Coz50aIh+op5vSEWnrPJPbjgvlYxj+XgQk9B6io0ZLs=; b=PGMB4Hrpmshy4FMED5pRwSdoYp
        hJexJHKeDWUVViplILvIyAvnsFd4DbQKl9HFMfD/M6XEzHF86MwU1fwUDM54aF3mh4tak1NcW4kGO
        cpLXUe+w0E5zcCKbjDNm87E0E5RbwQgfuiXay+3NCqp069qfgsAz29hKO9xr9QZMUUPEhiMenz6u/
        CRKA5XqUOlNfMzC0QS8Nxgy7ZYAbWPyyuitk0MK7YwO51re8QnzeHo21OVAJB3gDVwUrlsi8Ztkxz
        oCA0ZXfRos2Voxd7SvO0kC54wCPHHjl3NGvfzTd7+6Ziz5UbWUsPQrRiSmGI9BN1FuDwKb/Eshkdm
        HtN9tpoQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nQES2-00Cz5S-HF; Fri, 04 Mar 2022 20:22:59 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 254D098624E; Fri,  4 Mar 2022 21:22:58 +0100 (CET)
Date:   Fri, 4 Mar 2022 21:22:58 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     x86@kernel.org, joao@overdrivepizza.com, hjl.tools@gmail.com,
        andrew.cooper3@citrix.com, linux-kernel@vger.kernel.org,
        ndesaulniers@google.com, keescook@chromium.org,
        samitolvanen@google.com, mark.rutland@arm.com,
        alyssa.milburn@intel.com, mbenes@suse.cz, rostedt@goodmis.org,
        mhiramat@kernel.org, alexei.starovoitov@gmail.com
Subject: Re: [PATCH v3 05/39] x86/ibt: Add ANNOTATE_NOENDBR
Message-ID: <20220304202258.GP11184@worktop.programming.kicks-ass.net>
References: <20220303112321.422525803@infradead.org>
 <20220303112825.251775688@infradead.org>
 <20220304185953.pom5at6roevsmm2w@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220304185953.pom5at6roevsmm2w@treble>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 04, 2022 at 10:59:53AM -0800, Josh Poimboeuf wrote:
> On Thu, Mar 03, 2022 at 12:23:26PM +0100, Peter Zijlstra wrote:
> > In order to have objtool warn about code references to !ENDBR
> > instruction, we need an annotation to allow this for non-control-flow
> > instances -- consider text range checks, text patching, or return
> > trampolines etc.
> > 
> > Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> > Reviewed-by: Kees Cook <keescook@chromium.org>
> > ---
> >  include/linux/objtool.h |   16 ++++++++++++++++
> >  1 file changed, 16 insertions(+)
> 
> Also needs copied over to tools/include/linux/objtool.h to avoid the
> sync warning.

Urgh yeah, I keep meaning to add that bit and then immediately forget
about it :/
