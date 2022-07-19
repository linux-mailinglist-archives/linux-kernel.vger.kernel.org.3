Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CE9757A0F3
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 16:13:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238756AbiGSONn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 10:13:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237198AbiGSONP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 10:13:15 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51CE559259;
        Tue, 19 Jul 2022 06:36:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 6D483CE1C01;
        Tue, 19 Jul 2022 13:36:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5416C341C6;
        Tue, 19 Jul 2022 13:36:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658237812;
        bh=LgIus1vM08oJb7atpj/1Ixv/EE+zSIDg/3ScTjK636I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hc8opsDf62QaLIIbJ/8bhboVP/hhdbVhKBYx6dB3I94dx260mmGeQLkcDze6Gq6xI
         JXBxqA2ycpbxSD/4fyvcKM0qPo/o+JKPLAubROYEwZAjB+BKViK1xiYplGR1qidVdq
         6dUcaV51IgrKQuzIStBgWxro57Iag2GgeuzVCSQ5FnewwcSZ6aEA1e0PQ3z43iLgH+
         MrnO9upkv1JiDLCNxxBla63/46x+ttmowfsWhAnWF4w3Jid7rprrfXpHz4WyMD4pbq
         02c+alBWnJuCYyzpIoxjY0iMNOuKBk90iM5QSm5ViMFIBGZu217ibq9PMmrvUx44M/
         oV6ts8BZILgzw==
Date:   Tue, 19 Jul 2022 14:36:45 +0100
From:   Will Deacon <will@kernel.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     Sami Tolvanen <samitolvanen@google.com>,
        linux-kernel@vger.kernel.org, Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Joao Moreira <joao@overdrivepizza.com>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-hardening@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, llvm@lists.linux.dev
Subject: Re: [RFC PATCH v3 00/20] KCFI support
Message-ID: <20220719133645.GA14089@willie-the-truck>
References: <20220610233513.1798771-1-samitolvanen@google.com>
 <202206131001.6BA9933C@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202206131001.6BA9933C@keescook>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 13, 2022 at 10:04:12AM -0700, Kees Cook wrote:
> On Fri, Jun 10, 2022 at 04:34:53PM -0700, Sami Tolvanen wrote:
> > KCFI is a proposed forward-edge control-flow integrity scheme for
> > Clang, which is more suitable for kernel use than the existing CFI
> > scheme used by CONFIG_CFI_CLANG. KCFI doesn't require LTO, doesn't
> > alter function references to point to a jump table, and won't break
> > function address equality. The latest LLVM patch is here:
> > 
> >   https://reviews.llvm.org/D119296
> > 
> > This RFC series replaces the current arm64 CFI implementation with
> > KCFI and adds support for x86_64.
> 
> I think the "RFC" prefix for this series can be dropped. :)
> 
> It looks to me like all of Peter's concerns have been addressed. I'd say
> let's get the Clang side landed, and once that's done, land this via x86
> -tip?
> 
> Peter and Will does this sound right to you? It touches arm64, so if
> -tip isn't okay, I could take it in one of my trees?

The arm64 bits look fine to me. Please just check if it conflicts horribly
with -next so that we have a chance to figure out a shared branch if
necessary.

Will
