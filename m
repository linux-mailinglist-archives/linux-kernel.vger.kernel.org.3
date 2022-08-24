Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 688D35A024B
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Aug 2022 21:51:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240016AbiHXTvQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Aug 2022 15:51:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237608AbiHXTvO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Aug 2022 15:51:14 -0400
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 709995466B;
        Wed, 24 Aug 2022 12:51:11 -0700 (PDT)
Received: from gate.crashing.org (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id 27OJhneA002823;
        Wed, 24 Aug 2022 14:43:49 -0500
Received: (from segher@localhost)
        by gate.crashing.org (8.14.1/8.14.1/Submit) id 27OJhnnE002822;
        Wed, 24 Aug 2022 14:43:49 -0500
X-Authentication-Warning: gate.crashing.org: segher set sender to segher@kernel.crashing.org using -f
Date:   Wed, 24 Aug 2022 14:43:49 -0500
From:   Segher Boessenkool <segher@kernel.crashing.org>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Borislav Petkov <bp@alien8.de>, X86 ML <x86@kernel.org>,
        Michael Matz <matz@suse.de>, linux-toolchains@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] x86/sev: Mark snp_abort() noreturn
Message-ID: <20220824194349.GB25951@gate.crashing.org>
References: <20220824152420.20547-1-bp@alien8.de> <20220824172929.GA25951@gate.crashing.org> <CAKwvOdm+yFhZ2pYLJ5vpj1YyNJmG=UVF4cTz_m+0UfDGNGsRbQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKwvOdm+yFhZ2pYLJ5vpj1YyNJmG=UVF4cTz_m+0UfDGNGsRbQ@mail.gmail.com>
User-Agent: Mutt/1.4.2.3i
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 24, 2022 at 11:44:35AM -0700, Nick Desaulniers wrote:
> On Wed, Aug 24, 2022 at 10:33 AM Segher Boessenkool
> <segher@kernel.crashing.org> wrote:
> > On Wed, Aug 24, 2022 at 05:24:20PM +0200, Borislav Petkov wrote:
> > > Mark both the function prototype and definition as noreturn in order to
> > > prevent the compiler from doing transformations which confuse objtool
> > > like so:
> > >
> > >   vmlinux.o: warning: objtool: sme_enable+0x71: unreachable instruction
> >
> > Would -Wmissing-noreturn have caught this?
> 
> Oh, that's shiny. Is that relatively new?

Relatively, yes.


commit 0ca3fb0a168e9db2bd5405855d3932f62b08b7c9
Author: Kaveh R. Ghazi <ghazi@caip.rutgers.edu>
Date:   Tue Oct 20 07:32:08 1998 +0000

    New warning, `missing-noreturn':


The alias -Wsuggest-attribute=noreturn is newer:


commit 94ee697923f5a93881edbc5e1b3f810b290f0fc7
Author: Manuel López-Ibáñez <manu@gcc.gnu.org>
Date:   Sun Apr 29 09:15:30 2012 +0000

	* common.opt (Wmissing-noreturn): Alias of -Wsuggest-attribute=noret



Segher
