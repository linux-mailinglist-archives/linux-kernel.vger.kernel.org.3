Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6FBC57A813
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 22:11:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239034AbiGSULH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 16:11:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230219AbiGSULF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 16:11:05 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E61224BD07
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 13:11:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=GOR0llpLdBloIiRCsrXpHgKNvJE14oFor6X1Vr5Wpto=; b=Tfaqp4ttkQei6Oeicdchy18prg
        3S7V4zJifcIfx01svr+64oiwdsjfd354P4zmJP6zXuZ/Zv+sP7A+lcSb2XKjm+o5un0nSQ6+cYy3/
        pqO31l2si35IgStN24u1jE6dbmondXwK8sFKKxxvZ+tMRYgU87FetIJ098VreftPB1Wy85lHhNspI
        uWZOzFdGGefDWwvGl6SPKbm+5PkanbL/sH25YFH5Xjujb5ILttJLdjmHnHqUEnv+uPezu9iB/o7s7
        3Y/Ae671uzrzQUk+s91Rg4myBhsBOhmcQY3yKddT/WxMiE/1GUmPvFo8+c6A+rWQ9PgM0hMslkTtM
        +OQip1IA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=worktop.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oDtXq-005AAp-4v; Tue, 19 Jul 2022 20:10:15 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 43EA19802A4; Tue, 19 Jul 2022 22:10:11 +0200 (CEST)
Date:   Tue, 19 Jul 2022 22:10:11 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Sami Tolvanen <samitolvanen@google.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        David Laight <David.Laight@aculab.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Joao Moreira <joao@overdrivepizza.com>,
        LKML <linux-kernel@vger.kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        "Cooper, Andrew" <andrew.cooper3@citrix.com>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Johannes Wikner <kwikner@ethz.ch>,
        Alyssa Milburn <alyssa.milburn@linux.intel.com>,
        Jann Horn <jannh@google.com>, "H.J. Lu" <hjl.tools@gmail.com>,
        "Moreira, Joao" <joao.moreira@intel.com>,
        "Nuzman, Joseph" <joseph.nuzman@intel.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        "Gross, Jurgen" <jgross@suse.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Peter Collingbourne <pcc@google.com>
Subject: Re: [patch 00/38] x86/retbleed: Call depth tracking mitigation
Message-ID: <YtcPowwHVxIrE/D1@worktop.programming.kicks-ass.net>
References: <CABCJKudvSv9bAOrDLHki5XPYNJK6=PS-x8v=E08es8w4LJpxBw@mail.gmail.com>
 <87fsiyuhyz.ffs@tglx>
 <CAHk-=wjEDJ4+xg0CWR7CaCKnO6Nhzn+vjJy7CjaVmf9R+g_3ag@mail.gmail.com>
 <CAHk-=wj6U3UamfLLV+rPu1WmKG_w3p0Bg=YbQcG1DxHpmP40Ag@mail.gmail.com>
 <CAHk-=wiYHXeWnF8Ea5xb735ehJ8FbjTT6UCvHYjX=Ooc7Z5sOw@mail.gmail.com>
 <0e038c2795784b7eb4de52f77b67206a@AcuMS.aculab.com>
 <CAHk-=whycTCSPwqV53ybUX=fDKMDk_Y8JaLug3KfUSiMF2TOQg@mail.gmail.com>
 <YtbolH9YegJWUmHT@google.com>
 <CAHk-=wghqo3OtyR54FkBjkuELubPE3RzRNYU1z90BYtfuaoxzA@mail.gmail.com>
 <YtbysBfeEZJmHtiB@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YtbysBfeEZJmHtiB@google.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 19, 2022 at 11:06:40AM -0700, Sami Tolvanen wrote:
> On Tue, Jul 19, 2022 at 10:27:00AM -0700, Linus Torvalds wrote:
> > On Tue, Jul 19, 2022 at 10:23 AM Sami Tolvanen <samitolvanen@google.com> wrote:
> > >
> > > The preamble hash is encoded into an instruction just to avoid special
> > > casing objtool, which would otherwise get confused about the random
> > > bytes. On arm64, we just emit a bare constant before the function.
> > 
> > Ahh.
> > 
> > I think objtool would want to understand about kCFI anyway, so I think
> > in the long run that hack isn't a goog idea.
> > 
> > But I get why you'd do it as a "do this as just a compiler thing and
> > hide it from objtool" as a development strategy.
> 
> I believe it was actually Peter's idea to use an instruction. :) In
> earlier revisions of KCFI, I did teach objtool about the preambles, but
> that was just so it can ignore them.

Right; even if we teach objtool about kCFI, having text be actual
instructions makes things much nicer. Objdump and friends also shit
their pants if you put random bytes in. It only costs a single byte to
encode the immediate, so why not.

Specifically, the encoding used is:

	movl $0x12345678, %eax

and that is 0xb8 followed by the constant, but there's plenty other
single byte ops that could be used.
