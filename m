Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91FFE58028B
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jul 2022 18:22:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235197AbiGYQWH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jul 2022 12:22:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232954AbiGYQWE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jul 2022 12:22:04 -0400
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6B3FD64CA
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jul 2022 09:22:03 -0700 (PDT)
Received: from gate.crashing.org (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id 26PGDQiC023484;
        Mon, 25 Jul 2022 11:13:26 -0500
Received: (from segher@localhost)
        by gate.crashing.org (8.14.1/8.14.1/Submit) id 26PGDNOE023478;
        Mon, 25 Jul 2022 11:13:23 -0500
X-Authentication-Warning: gate.crashing.org: segher set sender to segher@kernel.crashing.org using -f
Date:   Mon, 25 Jul 2022 11:13:23 -0500
From:   Segher Boessenkool <segher@kernel.crashing.org>
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>,
        lkp@intel.com, linux-kernel@vger.kernel.org, npiggin@gmail.com,
        Julia.Lawall@inria.fr, paulus@samba.org,
        Jason Wang <wangborong@cdjrlc.com>,
        linuxppc-dev@lists.ozlabs.org, hbathini@linux.ibm.com,
        joel@jms.id.au
Subject: Re: [PATCH] powerpc: Remove the static variable initialisations to 0
Message-ID: <20220725161323.GT25951@gate.crashing.org>
References: <20220723092436.7149-1-wangborong@cdjrlc.com> <20220723133405.GF17705@kitsune.suse.cz> <20220723192211.GP25951@gate.crashing.org> <87fsipdg7b.fsf@mpe.ellerman.id.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87fsipdg7b.fsf@mpe.ellerman.id.au>
User-Agent: Mutt/1.4.2.3i
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 25, 2022 at 01:27:52PM +1000, Michael Ellerman wrote:
> Segher Boessenkool <segher@kernel.crashing.org> writes:
> > On Sat, Jul 23, 2022 at 03:34:05PM +0200, Michal Suchánek wrote:
> >> Hello,
> >> 
> >> On Sat, Jul 23, 2022 at 05:24:36PM +0800, Jason Wang wrote:
> >> > Initialise global and static variable to 0 is always unnecessary.
> >> > Remove the unnecessary initialisations.
> >> 
> >> Isn't this change also unnecessary?
> >> 
> >> Initializing to 0 does not affect correctness, or even any kind of
> >> semantics in any way.
> >
> > It did make a difference when the kernel was still compiled with
> > -fcommon (which used to be the GCC default on most configurations, it is
> > traditional on Unix).  No explicit initialiser puts an object in .bss if
> > you use -fcommon.  This matters a bit for data layout.
> 
> The kernel has built with -fno-common since ~2002.

2001, yes (255649c18287).  And before that it was important to
initialise everything with static storage duration explicitly in the
source code.  It was part of the collective memory, I wondered if this
patch originated that way?

> I think the belief is that an explicit initialiser of 0 forces the
> variable into .data, but AFAICS that is not true with any compiler we
> support.

Exactly, you get identical code either way, if you use -fno-common.
People will still see this difference if they use a compiler before
GCC 10 for compiling most other things though.


Segher
