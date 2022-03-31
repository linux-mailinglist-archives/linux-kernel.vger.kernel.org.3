Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFDBE4ED49E
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 09:14:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231156AbiCaHPb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 03:15:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232007AbiCaHOl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 03:14:41 -0400
Received: from angie.orcam.me.uk (angie.orcam.me.uk [78.133.224.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3741991AD4
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 00:11:56 -0700 (PDT)
Received: by angie.orcam.me.uk (Postfix, from userid 500)
        id 78A299200B3; Thu, 31 Mar 2022 09:11:55 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by angie.orcam.me.uk (Postfix) with ESMTP id 7570E92009E;
        Thu, 31 Mar 2022 08:11:55 +0100 (BST)
Date:   Thu, 31 Mar 2022 08:11:55 +0100 (BST)
From:   "Maciej W. Rozycki" <macro@orcam.me.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
cc:     Thomas Gleixner <tglx@linutronix.de>,
        Dmitry Osipenko <dmitry.osipenko@collabora.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>
Subject: Re: [GIT pull] x86/irq for v5.18-rc1
In-Reply-To: <CAHk-=wg_Kyh4zVmBSc4H79jH+yv9wN7dMsf-5x=EDrORbL3fuQ@mail.gmail.com>
Message-ID: <alpine.DEB.2.21.2203301406450.22465@angie.orcam.me.uk>
References: <164786042536.122591.4459156564791679956.tglx@xen13> <164786043041.122591.4693682080153649212.tglx@xen13> <CAHk-=wg_Kyh4zVmBSc4H79jH+yv9wN7dMsf-5x=EDrORbL3fuQ@mail.gmail.com>
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

On Mon, 21 Mar 2022, Linus Torvalds wrote:

> >  - Handle the IRT routing table format in AMI BIOSes correctly
> 
> *Very* minor nit here in the hope of future cleanups: the other x86
> irq routing table structions (Christ, that's a sentence that shouldn't
> exist in a sane world) use "__attribute__((packed))" and this one uses
> "__packed".

 I have reviewed and reverified the code for resubmission now and frankly 
I don't know where this "__packed" artefact has come from.  I certainly 
have "__attribute__((packed))" in all my copies of the change including 
one I have submitted (though `checkpatch.pl' does want it indeed to be 
`__packed' instead).

 Also accessing memory beyond __va(0x100000) does not appear to crash on 
my 32-bit x86 machine, so it must be something specific to x86-64.  Not an 
excuse for a range overrun of course, but still odd (and as I previously 
mentioned I find it odd too that this code is ever run for x86-64 in the 
first place).

 Finally, following your suggestion I have added verification for a range 
overrun for the whole table for both the existing $PIR format and the new 
$IRT format.  It isn't a big deal and we shouldn't trust external sources 
of data.

  Maciej
