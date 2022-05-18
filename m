Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B7A852C0A8
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 19:10:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240007AbiERQRe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 12:17:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239971AbiERQRc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 12:17:32 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2CE717707E
        for <linux-kernel@vger.kernel.org>; Wed, 18 May 2022 09:17:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 3737FCE21AE
        for <linux-kernel@vger.kernel.org>; Wed, 18 May 2022 16:17:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F140C385A5;
        Wed, 18 May 2022 16:17:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652890647;
        bh=dmIZ4Nql4iIBiLdds0xyVW1A/Xf8DpSW87Riaa/jSn0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jCo8ns3RJzooC9MrZspB4ZE24hbQ43csw2DVuEEk4WxhSfaJgll3XQ5Cib00iRTzE
         8IwB5gI1ZOYGJFWB+VeSsEWSqeqA1T2trHsLXXlmMkjx5PvinxZgjpEnf3z7gLzZpf
         ubqm2S37FbwZtu2i1I7mcfM82SaCxT+nEiKn8ViA6qcfx3vg2QJUOIBFmLwq95gqGD
         9OdtqmfQqzlhf2zB5FhiFTkOkGQmjQRQLLVNSyCaH5H0F7TAgUXxa3R+5wh5u+zJFS
         myB50Ehr1m94KuBTpPxhmWoy8AKKC5YGJr6N0c78Ucw9PShwNpI6qQjw/TOcvejYo2
         1N2l67jZ1JmoA==
Date:   Wed, 18 May 2022 09:17:25 -0700
From:   Josh Poimboeuf <jpoimboe@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        llvm@lists.linux.dev, linux-kernel@vger.kernel.org,
        kasan-dev@googlegroups.com
Subject: Re: objtool "no non-local symbols" error with tip of tree LLVM
Message-ID: <20220518161725.2bkzavre2bg4xu72@treble>
References: <YoK4U9RgQ9N+HhXJ@dev-arch.thelio-3990X>
 <20220516214005.GQ76023@worktop.programming.kicks-ass.net>
 <YoPAZ6JfsF0LrQNc@hirez.programming.kicks-ass.net>
 <YoPCTEYjoPqE4ZxB@hirez.programming.kicks-ass.net>
 <20220518012429.4zqzarvwsraxivux@treble>
 <YoSEXii2v0ob/8db@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YoSEXii2v0ob/8db@hirez.programming.kicks-ass.net>
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 18, 2022 at 07:30:06AM +0200, Peter Zijlstra wrote:
> On Tue, May 17, 2022 at 06:24:29PM -0700, Josh Poimboeuf wrote:
> > On Tue, May 17, 2022 at 05:42:04PM +0200, Peter Zijlstra wrote:
> > > +	for (;;) {
> > > +		symtab_data = elf_getdata(s, symtab_data);
> > > +		if (t)
> > > +			shndx_data = elf_getdata(t, shndx_data);
> > >  
> > > +		if (!symtab_data) {
> > > +			if (!idx) {
> > > +				void *buf;
> > 
> > I'm confused by whatever this is doing, how is !symtab_data possible,
> > i.e. why would symtab not have data?
> 
> Elf_Data *elf_getdata(Elf_Scn *scn, Elf_Data *data);
> 
> is an iterator, if @data is null it will return the first element, which
> you then feed into @data the next time to get the next element, once it
> returns NULL, you've found the end.
> 
> In our specific case, we iterate the data sections, if idx fits inside
> the current section, we good, otherwise we lower idx by however many did
> fit and try the next.

Ok, I think I see.  But why are there multiple data blocks to begin
with?  It's because of a previous call to elf_newdata() right?

If so then I don't see how it would "fit" in an existing data block,
since each block should already be full.  Or... is the hole the one you
just made, by moving the old symbol out?

If so, the function seems weirdly generalized for the two distinct cases
and the loop seems unnecessary.  When adding a symbol at the end, just
use elf_newdata().  When adding a symbol in the middle, the hole should
be in the first data block.

-- 
Josh
