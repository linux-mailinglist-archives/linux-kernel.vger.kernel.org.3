Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6555C5081B5
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 09:07:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359589AbiDTHKa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 03:10:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231806AbiDTHK2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 03:10:28 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34E4A255A6
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 00:07:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Eew1vcVRWgxdl8FVkHcJEWW3P0l9fvQWBN1beOCN3aY=; b=Z1EWrAMqhJP9gbeGLhx3yllU/j
        IkU+/vtkf0sWHJP8ZL+/uIn/sb5dOoSyEEmyWorREVskY/tyJE6vVOu+rSJ/JXgG9VM7p+iHlk+k+
        8kVC3QOiewlk8ma8YFGhAYZDMQb0BycCurXSy9zyxgeu+sGEuVg6Wc7bXpRDnb3XYzE56f/eyNdUn
        Q56RHihyME9xPspjnx3vOsuCkkYda3jQ1oOpIE2mTZPpCyZ/AwEsw4gHShZw81xHFmZi4Used9SiW
        /0oKEIRHQUfcwnbff36N0+RCYZkcjIIly4fGK6gSMtbOfFxsKgdxl+jAlty8T6ogaBfs3OrycSUK3
        FHTqmbSw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nh4R2-003qyW-NM; Wed, 20 Apr 2022 07:07:32 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id B04859861A4; Wed, 20 Apr 2022 09:07:30 +0200 (CEST)
Date:   Wed, 20 Apr 2022 09:07:30 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     x86@kernel.org, brgerst@gmail.com, jiangshanlai@gmail.com,
        Andrew.Cooper3@citrix.com, linux-kernel@vger.kernel.org,
        Andy Lutomirski <luto@kernel.org>
Subject: Re: [PATCH 2/2] x86,entry: Use PUSH_AND_CLEAR_REGS for compat
Message-ID: <20220420070730.GB2731@worktop.programming.kicks-ass.net>
References: <20220419204109.520779286@infradead.org>
 <20220419205241.339242797@infradead.org>
 <20220420032123.6c344rjr4poockjr@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220420032123.6c344rjr4poockjr@treble>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 19, 2022 at 08:21:23PM -0700, Josh Poimboeuf wrote:
> On Tue, Apr 19, 2022 at 10:41:11PM +0200, Peter Zijlstra wrote:
> > Since the upper regs don't exist for ia32 code, preserving them
> > doesn't hurt and it simplifies the code.
> 
> But an attacker can still control those registers, so clearing them on
> the stack is better, as it reduces user control over the kernel stack.
> 
> 64-bit syscalls *do* have to save those registers to the stack, so
> whether it truly matters if compat mode is made equally insecure, I
> can't say.  But without evidence to the contrary, my feeling is that we
> should err on the side of caution.

Right, so earlier Brian said simpler might be better, and I figured I'd
try to see if I could make that stick, because I too like simpler ;-)

Also, since int80 already has to do this, attackers already have their
attack surface.
