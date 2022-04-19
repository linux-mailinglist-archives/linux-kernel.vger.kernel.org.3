Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DF6E506D3F
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 15:12:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349733AbiDSNNg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 09:13:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347234AbiDSNNc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 09:13:32 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C3492ED57
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 06:10:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=DmKV20mrS057BFjgATIFfZZcbYOc9ROzIdfK5243MKM=; b=mjrfG+wkWhTeI0dI2U3/RqSdqu
        JoEaZ6bbl++VC4ETSUfRnKxCv6dr1hOw+XrwTv4Ait7LcnTbVcAEtrFWMRnh9yoRhKXY4frfOgGbb
        WRNdWc0IHmp5CpK7GWAYLZbVXP/vtkU1UBtssh2G+cjh5mO1i6RnyjK8A83skYrT65Rhysx/LXvre
        CUahQjroG2a0As//v7wBm/gJiP24DK5hQMeHT1FrRe7hbWNQSh1xrTHR30i0eFoZYgiF46/PMslHf
        4VaCpC3D9WOKP5xaWO72w1gsnZ2ld22v3EacVlCoKir72iUhhezdGKMRAHBZjDpa8mBgcJVydYGV4
        f/URuBWw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ngncl-006pDV-GG; Tue, 19 Apr 2022 13:10:31 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 3704A986195; Tue, 19 Apr 2022 15:10:29 +0200 (CEST)
Date:   Tue, 19 Apr 2022 15:10:29 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Andrew Cooper <amc96@srcf.net>
Cc:     Andrew Cooper <Andrew.Cooper3@citrix.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Miroslav Benes <mbenes@suse.cz>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>
Subject: Re: [PATCH v2 06/25] x86/xen: Add ANNOTATE_ENDBR to startup_xen()
Message-ID: <20220419131029.GV2731@worktop.programming.kicks-ass.net>
References: <cover.1650300597.git.jpoimboe@redhat.com>
 <a87bd48b06d11ec4b98122a429e71e489b4e48c3.1650300597.git.jpoimboe@redhat.com>
 <b94cbac6-0a4d-8e4a-ec58-bbd46e385d45@citrix.com>
 <20220419115737.GU2731@worktop.programming.kicks-ass.net>
 <8fbbd4ca-54b1-8c1c-19bc-3d0e6044ff5d@srcf.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8fbbd4ca-54b1-8c1c-19bc-3d0e6044ff5d@srcf.net>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 19, 2022 at 01:12:14PM +0100, Andrew Cooper wrote:

> > Subject: x86/xen: Add ANNOTATE_ENDBR to startup_xen()
> > From: Josh Poimboeuf <jpoimboe@redhat.com>
> > Date: Mon, 18 Apr 2022 09:50:25 -0700
> >
> > From: Josh Poimboeuf <jpoimboe@redhat.com>
> >
> > The startup_xen() kernel entry point is referenced by the ".note.Xen"
> > section, and is the real entry point of the VM. It *will* be
> > indirectly branched to, *however* currently Xen doesn't support PV VM
> > with CET active.
> 
> Technically it's always IRET'd to, but the point is that it's never
> "branched to" by the execution context of the VM.
> 
> So it would be better to say that it's never indirectly branched to. 
> That's what the IBT checks care about.

Right, so I was thinking the IRET could set the NEED_ENDBR bit, but
yeah, that might be stretching the definition of an indirect-branch a
wee bit.

How about so then?

---
Subject: x86/xen: Add ANNOTATE_NOENDBR to startup_xen()
From: Josh Poimboeuf <jpoimboe@redhat.com>
Date: Mon, 18 Apr 2022 09:50:25 -0700

From: Josh Poimboeuf <jpoimboe@redhat.com>

The startup_xen() kernel entry point is referenced by the ".note.Xen"
section, and is the real entry point of the VM. Control transfer is
through IRET, which *could* set NEED_ENDBR, however Xen currently does
no such thing.

Add ANNOTATE_NOENDBR to silence future objtool warnings.

Fixes: ed53a0d97192 ("x86/alternative: Use .ibt_endbr_seal to seal indirect calls")
Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Andrew Cooper <andrew.cooper3@citrix.com>
Link: https://lkml.kernel.org/r/a87bd48b06d11ec4b98122a429e71e489b4e48c3.1650300597.git.jpoimboe@redhat.com

