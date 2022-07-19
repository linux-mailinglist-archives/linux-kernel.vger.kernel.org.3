Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 259C1578ED7
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 02:11:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236434AbiGSALQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 20:11:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236527AbiGSALK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 20:11:10 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47C7733E0C
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 17:11:09 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id e15so17521310edj.2
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 17:11:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9twpH2Ssc0YmVOQRm9GWFwzaNV8adNbuZG+aBF8KB48=;
        b=HWFlRJamLb1qTqzKe1twXKvEhXrmLIWhrAxrDtrWxvwT1R4W7GxrJAyPWToqshdSTF
         zrVxThcXVV/p/+HNv8rzxIL5vKyRdlsmuiDhFUVxniuBFAB+QR2iUUBX6X873d2TYQJX
         JYI3DDfVOOcWbGTVR95I4Uc4aHkWNM2mzf5j0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9twpH2Ssc0YmVOQRm9GWFwzaNV8adNbuZG+aBF8KB48=;
        b=aq7J/VJq+51vkpBeq1C2/vxZfQn2P3nOpn0m10GtOhD99x79iYV4JLxif/LgRPHlgU
         PqQztejelYHiilhtoFvs+Y+1qUiD81eKXSDsw9nXKXm0mGNN5VzAkioa27jxmUpqlXe9
         UmeAXpiUubBedXGDNbBxd/9YK5XYYeSoIUR5OiFnuHjkX+YB4BudCBMwe2+oib6WgU5i
         uQhx1JKlUtM9o1A+8F3Ah1LR74rVyxCQzsRUwB8xy37zlbrQRI3tn4U/RBobP/gPisNS
         L4RsIUb14Ue/WIxHYESGfHsaJkAFBhnJ2WFpw+M9acY30qbL3IK0BSLJaxWqxmaeOXrH
         yOOg==
X-Gm-Message-State: AJIora+ERzA45e6HDtv/M3ynfhQM0bZ4gL5L2DDEd3x7oDhpa3Of5a+2
        7UvE2QoO6FnQcSLjvbHUO9qOaQ0Btl7KMzT63x8=
X-Google-Smtp-Source: AGRyM1u16XKnLSD06WX3MAHVeO/4JaDK2xzESzZpeXu6cQbbbiYPIAQGnJ9vpw6VxkgUKgjvZva0NQ==
X-Received: by 2002:a05:6402:1e8f:b0:43a:ddfc:5c4e with SMTP id f15-20020a0564021e8f00b0043addfc5c4emr41032933edf.358.1658189467637;
        Mon, 18 Jul 2022 17:11:07 -0700 (PDT)
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com. [209.85.221.54])
        by smtp.gmail.com with ESMTPSA id la23-20020a170907781700b0072b92daef1csm6128474ejc.146.2022.07.18.17.11.07
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Jul 2022 17:11:07 -0700 (PDT)
Received: by mail-wr1-f54.google.com with SMTP id v16so3490985wrr.6
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 17:11:07 -0700 (PDT)
X-Received: by 2002:a05:6000:1a88:b0:21d:aa97:cb16 with SMTP id
 f8-20020a0560001a8800b0021daa97cb16mr25098121wry.97.1658189045434; Mon, 18
 Jul 2022 17:04:05 -0700 (PDT)
MIME-Version: 1.0
References: <87tu7euska.ffs@tglx> <CAHk-=wjpzVRU0Yr_0DJSB_bKHW3_74UucNpJBjxfHPo_R=PYNg@mail.gmail.com>
 <87o7xmup5t.ffs@tglx> <YtXOMPpmx8TcFtOX@worktop.programming.kicks-ass.net>
 <87lesqukm5.ffs@tglx> <2f7f899cb75b79b08b0662ff4d2cb877@overdrivepizza.com>
 <CABCJKudvSv9bAOrDLHki5XPYNJK6=PS-x8v=E08es8w4LJpxBw@mail.gmail.com>
 <87fsiyuhyz.ffs@tglx> <CAHk-=wjEDJ4+xg0CWR7CaCKnO6Nhzn+vjJy7CjaVmf9R+g_3ag@mail.gmail.com>
 <CAHk-=wj6U3UamfLLV+rPu1WmKG_w3p0Bg=YbQcG1DxHpmP40Ag@mail.gmail.com> <YtXzgWnbTQH48JGR@worktop.programming.kicks-ass.net>
In-Reply-To: <YtXzgWnbTQH48JGR@worktop.programming.kicks-ass.net>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 18 Jul 2022 17:03:49 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiJNViWKCCrDPByGWmVVXuEKhRGykx4q8diXSxEqGfOMw@mail.gmail.com>
Message-ID: <CAHk-=wiJNViWKCCrDPByGWmVVXuEKhRGykx4q8diXSxEqGfOMw@mail.gmail.com>
Subject: Re: [patch 00/38] x86/retbleed: Call depth tracking mitigation
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Sami Tolvanen <samitolvanen@google.com>,
        Joao Moreira <joao@overdrivepizza.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
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
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 18, 2022 at 4:58 PM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Mon, Jul 18, 2022 at 04:52:09PM -0700, Linus Torvalds wrote:
> > I also happen to believe that the kCFI code should have entirely
> > different targets for direct jumps and for indirect jumps, but that's
> > a separate issue. Maybe it already does that?
>
> kCFI is purely about indirect calls.

So it already only adds the pattern to things that have their address
taken, not all functions?

If so, that's simple enough to sort out: don't do any RSB stack
adjustment for those thunks AT ALL.

Because they should just then end up with a jump to the "real" target,
and that real target will do the RSB stack thing.

               Linus
