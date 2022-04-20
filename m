Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57A5950826A
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 09:41:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359867AbiDTHn4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 03:43:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241235AbiDTHnx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 03:43:53 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4847F396B1;
        Wed, 20 Apr 2022 00:41:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=loHgwO9WdPiHY+qI9O6T45I75jtAzJoMT4qm2QpWt5g=; b=V2RchLGI6xz9pyK8YlHujLlD/X
        EE6WJAMG0vax+Uflad9dXecchGGgdrEsgr9/jn+Mlna3FwhPqKb8soGIf+88VVZHsT+f+4RamJTHg
        0i4jQfkRusmvaBRyWgvTg0oUNrm0KRgEEqWI4AHB6Po/2YoCgzyxIhwI6YMo3tGYZCjyDYffHF83B
        fcn90QQ0wuA5gcSv9F6QzLORGiSSO75scNG7C5EvYN2+q6Ppq38Bh+q8BEhD3AQnsivSvFPtIzE03
        F6mTVl5e7Wc3jcFL2ZMB40pMwhnaSS8x4TcDmkG9C/Go20R/TKuhBgzJXOZev+/Lovfl/XL64d0A8
        mdiuVEwA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nh4xC-0073vt-Eu; Wed, 20 Apr 2022 07:40:46 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id B013B9861A4; Wed, 20 Apr 2022 09:40:44 +0200 (CEST)
Date:   Wed, 20 Apr 2022 09:40:44 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     joao@overdrivepizza.com
Cc:     linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
        jpoimboe@redhat.com, andrew.cooper3@citrix.com,
        keescook@chromium.org, samitolvanen@google.com,
        mark.rutland@arm.com, hjl.tools@gmail.com,
        alyssa.milburn@linux.intel.com, ndesaulniers@google.com,
        gabriel.gomes@linux.intel.com, rick.p.edgecombe@intel.com
Subject: Re: [RFC PATCH 00/11] Kernel FineIBT Support
Message-ID: <20220420074044.GC2731@worktop.programming.kicks-ass.net>
References: <20220420004241.2093-1-joao@overdrivepizza.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220420004241.2093-1-joao@overdrivepizza.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 19, 2022 at 05:42:30PM -0700, joao@overdrivepizza.com wrote:
> @PeterZ @JoshP
> 
> I'm a bit unaware of the details on why the objtool approach to bypass ENDBRs
> was removed from the IBT series. Is this approach now sensible considering that
> it is a requirement for a new/enhanced feature? If not, how extending the Linker
> to emit already fixed offsets sounds like?

Josh hates objtool modifying actualy code. He much prefers objtool only
emits out of band data.

Now, I did sneak in that jump_label nop'ing, and necessity (broken
compilers) had us do the KCOV nop'ing in noinstr, but if you look at the
recent objtool series here:

  https://lkml.kernel.org/r/cover.1650300597.git.jpoimboe@redhat.com

you'll see his thoughs on that :-)

Now, I obviously don't mind, it's easy enough to figure out what objtool
actually does with something like:

  $ OBJTOOL_ARGS="--backup" make O=ibt-build/ -j$lots vmlinux
  $ objdiff.sh ibt-build/vmlinux.o

Where objdiff.sh is the below crummy script.

Now, one compromise that I did get out of Josh was that he objected less
to rewriting relocations than to rewriting the immediates. From my
testing the relocations got us the vast majority of direct call sites,
very few are immediates.

Josh, any way you might reconsider all that? :-)

---
#!/bin/bash

name=$1
pre=${name}.orig
post=${name}

function to_text {
	obj=$1
	( objdump -wdr $obj;
	  readelf -W --relocs --symbols $obj |
		  awk '/^Relocation section/ { $6=0 } { print $0 }'
	) > ${obj}.tmp
}

to_text $pre
to_text $post

diff -u ${pre}.tmp ${post}.tmp

rm ${pre}.tmp ${post}.tmp
