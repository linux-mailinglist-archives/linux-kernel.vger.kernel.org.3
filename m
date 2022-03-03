Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CE464CBFBD
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Mar 2022 15:15:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233856AbiCCOPq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Mar 2022 09:15:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231147AbiCCOPn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Mar 2022 09:15:43 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6ACE818CC5C
        for <linux-kernel@vger.kernel.org>; Thu,  3 Mar 2022 06:14:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=qWQNOthXTquOrhHmzl9lJmVcX4KkTKg2fea12CYh7ts=; b=daTg9H0LzTWywP8J4AOyFF8HBx
        f3yQ2gydD0pRWTogso66lz7wlkNfGX+hIr4GZQ+x1jV2I0H3fhDPG05ZLgUeKNZ7ZqikymyEs+0Ws
        3QLhR5ztDhesX8o9sqhYfFdze331xoS20sPdUwWfdMT8+etPMjyVsEKbJWnPERtb4r0HLcIlhfWz2
        SHghMLQ6umhJYfr7WIWAj5wnqeVAr1kpZxl65C3cSFdrL+ww3vbEBs4ojkVrat5L9a1ECFX5653nk
        xSNjP/ktZsyH5EnZkAEj3oa996Z6sKNQ07AtRiVRHSGAZollARMXttGOcECfioTWAB3jd5RIZsVcy
        TfwdcfQA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nPmCg-00Bhis-Oe; Thu, 03 Mar 2022 14:13:14 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id C83E6300230;
        Thu,  3 Mar 2022 15:13:12 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id A6EA230268E82; Thu,  3 Mar 2022 15:13:12 +0100 (CET)
Date:   Thu, 3 Mar 2022 15:13:12 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Miroslav Benes <mbenes@suse.cz>
Cc:     Andrew Cooper <Andrew.Cooper3@citrix.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "joao@overdrivepizza.com" <joao@overdrivepizza.com>,
        "hjl.tools@gmail.com" <hjl.tools@gmail.com>,
        "jpoimboe@redhat.com" <jpoimboe@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "ndesaulniers@google.com" <ndesaulniers@google.com>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "samitolvanen@google.com" <samitolvanen@google.com>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "alyssa.milburn@intel.com" <alyssa.milburn@intel.com>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "mhiramat@kernel.org" <mhiramat@kernel.org>,
        "alexei.starovoitov@gmail.com" <alexei.starovoitov@gmail.com>
Subject: Re: [PATCH v2 33/39] objtool: Add IBT/ENDBR decoding
Message-ID: <YiDM+P1tElLUvxtI@hirez.programming.kicks-ass.net>
References: <20220224145138.952963315@infradead.org>
 <20220224151323.959862564@infradead.org>
 <alpine.LSU.2.21.2203031138040.704@pobox.suse.cz>
 <aa6076af-0f7c-ae48-4eb4-8bf2e3f0ed06@citrix.com>
 <alpine.LSU.2.21.2203031330530.704@pobox.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <alpine.LSU.2.21.2203031330530.704@pobox.suse.cz>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 03, 2022 at 01:33:06PM +0100, Miroslav Benes wrote:
> On Thu, 3 Mar 2022, Andrew Cooper wrote:
> 
> > On 03/03/2022 10:53, Miroslav Benes wrote:
> > > Hi,
> > >
> > > On Thu, 24 Feb 2022, Peter Zijlstra wrote:
> > >
> > >> Decode ENDBR instructions and WARN about NOTRACK prefixes.
> > > I guess it has been already mentioned somewhere, but could you explain 
> > > NOTRACK prefix here, please? If I understand it right, it disables IBT for 
> > > the indirect branch instruction meaning that its target does not have to 
> > > start with ENDBR?
> > 
> > CET-IBT has loads of get-out clauses.  The NOTRACK prefix is one; the
> > legacy code bitmap (implicit NOTRACK for whole libraries) is another.
> > 
> > And yes - the purpose of NOTRACK is to exempt a specific indirect branch
> > from checks.
> > 
> > GCC can emit NOTRACK'd calls in some cases when e.g. the programmer
> > launders a function pointer through (void *), or when
> > __attribute__((no_cf_check)) is used explicitly.
> > 
> > 
> > Each of the get-out clauses has separate enable bits, as each of them
> > reduces security.  In this series, Linux sets MSR_S_CET.ENDBR_EN but
> > specifically does not set NOTRACK_EN, so NOTRACK prefixes will be
> > ignored and suffer #CP if encountered.
> 
> Thanks for the explanation. I would be nice to include it somewhere so 
> that it is not lost.

I'll add something to the Changelog. Thanks!
