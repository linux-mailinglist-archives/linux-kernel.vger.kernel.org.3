Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 823AA5ACCAD
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Sep 2022 09:28:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235459AbiIEHWK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Sep 2022 03:22:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236305AbiIEHVX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Sep 2022 03:21:23 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 442044361D
        for <linux-kernel@vger.kernel.org>; Mon,  5 Sep 2022 00:17:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=t2PBhD4tG/Sd24mg1y9JF8kau2tsDVuXNdrrbtxRewM=; b=IVfI9ofbUPorJudsRSnYUmlPQb
        +DRzmycivKykc+D3XRRW7S3HoB9XAEKk8HM0xkyWfW2YyrvPvnXqzC+43jA6rVL25ZXgALFdeLxX5
        paqeqJrU0ORJBXh9l/OjrUrKTmaBqcnTbHJGSZz6lpC4QtvOayEktfHUGMDnrhmrSD4yQu+QcsxEX
        h/nvEwMXa3h8mDe8oOlhpRYqQkFr8iLtTGZ308//XRUm1q6L6ku7ABbga4kBYveJ8+zgSqsJwIg8O
        3wYt84jFZ5S8kr7ujom/9JX6PDszuThwbpQ0c9Hg6NatiwcatjzgNjWC/hZzeR1lL0+BKLjqdcgX7
        CHnqcm2A==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oV6Le-009Sra-9A; Mon, 05 Sep 2022 07:16:47 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id BCA203001FD;
        Mon,  5 Sep 2022 09:16:43 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 79AF42B63D24B; Mon,  5 Sep 2022 09:16:43 +0200 (CEST)
Date:   Mon, 5 Sep 2022 09:16:43 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
        x86@kernel.org, Tim Chen <tim.c.chen@linux.intel.com>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Andrew Cooper <Andrew.Cooper3@citrix.com>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Johannes Wikner <kwikner@ethz.ch>,
        Alyssa Milburn <alyssa.milburn@linux.intel.com>,
        Jann Horn <jannh@google.com>, "H.J. Lu" <hjl.tools@gmail.com>,
        Joao Moreira <joao.moreira@intel.com>,
        Joseph Nuzman <joseph.nuzman@intel.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Juergen Gross <jgross@suse.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        K Prateek Nayak <kprateek.nayak@amd.com>,
        Eric Dumazet <edumazet@google.com>
Subject: Re: [PATCH v2 37/59] x86/putuser: Provide room for padding
Message-ID: <YxWiW97HPV6kWjgz@hirez.programming.kicks-ass.net>
References: <20220902130625.217071627@infradead.org>
 <20220902130950.205726504@infradead.org>
 <CAHk-=wig7_=CpkvZXrbcM97pBGk5MCbVkA0yBGP2moiho-XS_Q@mail.gmail.com>
 <YxI3Zf5drSHAkBL3@hirez.programming.kicks-ass.net>
 <YxJmdG9Ug7euJdZS@hirez.programming.kicks-ass.net>
 <CAHk-=wj-njE+DwycFcVQ=ouXZpgKU2rjG3G0keNXSFWa_etrEA@mail.gmail.com>
 <CAHk-=whbunYr933WanyFxjp_WkT-NWNtSE6pt5A9Jq9_DjymEw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=whbunYr933WanyFxjp_WkT-NWNtSE6pt5A9Jq9_DjymEw@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 03, 2022 at 10:26:45AM -0700, Linus Torvalds wrote:
> On Fri, Sep 2, 2022 at 2:46 PM Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> >
> > Hmm. It doesn't look too horrible, but yeah, fi it still ends up
> > getting the same padding overhead I'm not sure it ends up really
> > mattering.
> 
> Oh, and I think it's buggy anyway.
> 
> If there are any tail-calls to a leaf function, the tracking now gets
> out of whack. So it's no longer a "don't bother counting the last
> level", now it ends up being a "count got off by one".

See validate_sibling_call(), it too calls validate_call().

(Although prehaps I should go s/sibling/tail/ on all that for clarity)
