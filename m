Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 974C84F1391
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Apr 2022 13:03:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359081AbiDDLFm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 07:05:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353742AbiDDLFg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 07:05:36 -0400
Received: from angie.orcam.me.uk (angie.orcam.me.uk [IPv6:2001:4190:8020::34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 91334BB8
        for <linux-kernel@vger.kernel.org>; Mon,  4 Apr 2022 04:03:39 -0700 (PDT)
Received: by angie.orcam.me.uk (Postfix, from userid 500)
        id 402BE92009C; Mon,  4 Apr 2022 13:03:37 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by angie.orcam.me.uk (Postfix) with ESMTP id 309AA92009B;
        Mon,  4 Apr 2022 12:03:37 +0100 (BST)
Date:   Mon, 4 Apr 2022 12:03:37 +0100 (BST)
From:   "Maciej W. Rozycki" <macro@orcam.me.uk>
To:     Kees Cook <keescook@chromium.org>
cc:     James Jones <linux@theinnocuous.com>, bp@alien8.de, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86: Remove a.out support
In-Reply-To: <67CF27C5-5013-4EF4-B24C-8D9EB52536FB@chromium.org>
Message-ID: <alpine.DEB.2.21.2204041135210.47162@angie.orcam.me.uk>
References: <4c449fab-8135-5057-7d2c-7b948ce130cc@theinnocuous.com> <0b31b1d3-852d-6cab-82ae-5eecaec05679@theinnocuous.com> <202203151150.1CDB1D8DA@keescook> <bfbd9394-161b-0e70-00c5-79d0dd722e08@theinnocuous.com> <alpine.DEB.2.21.2204022255430.47162@angie.orcam.me.uk>
 <67CF27C5-5013-4EF4-B24C-8D9EB52536FB@chromium.org>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2 Apr 2022, Kees Cook wrote:

> > Chiming in late as I'm scanning outstanding mailing list traffic: if this 
> >is as you say all statically linked stuff, then converting from a.out to 
> >ELF might be as easy as:
> >
> >$ objcopy -I a.out-i386-linux -O elf32-i386 a.out-binary elf-binary
> 
> Based on my research (and the wrapper I ended up writing), I don't think 
> this is sufficient because entry point handling is different between ELF 
> and a.out (specifically the stack layout and initial sp register value).

 Fair enough.  I guess the exact value of %esp doesn't matter that much 
(why would it?), but the arguments and environment may well be structured 
differently (and indeed based on a glance over binfmt_aout.c there's extra 
indirection involved compared to the ELF i386 psABI).

  Maciej
