Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C38D5805ED
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jul 2022 22:48:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236675AbiGYUsv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jul 2022 16:48:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233251AbiGYUst (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jul 2022 16:48:49 -0400
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CF18065D2
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jul 2022 13:48:48 -0700 (PDT)
Received: from gate.crashing.org (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id 26PKgJnT031642;
        Mon, 25 Jul 2022 15:42:19 -0500
Received: (from segher@localhost)
        by gate.crashing.org (8.14.1/8.14.1/Submit) id 26PKgHLw031641;
        Mon, 25 Jul 2022 15:42:17 -0500
X-Authentication-Warning: gate.crashing.org: segher set sender to segher@kernel.crashing.org using -f
Date:   Mon, 25 Jul 2022 15:42:17 -0500
From:   Segher Boessenkool <segher@kernel.crashing.org>
To:     Timothy Pearson <tpearson@raptorengineering.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Dan =?iso-8859-1?Q?Hor=E1k?= <dan@danny.cz>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        amd-gfx <amd-gfx@lists.freedesktop.org>,
        Alex Deucher <alexdeucher@gmail.com>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, linux@roeck-us.net
Subject: Re: [PATCH] drm/amdgpu: Re-enable DCN for 64-bit powerpc
Message-ID: <20220725204217.GU25951@gate.crashing.org>
References: <20220725123918.1903255-1-mpe@ellerman.id.au> <CAHk-=wihON4Ytte5zLHWNQtTapUvCpkToxY06OjX-_2B+Gq6Gg@mail.gmail.com> <1446417444.13111032.1658777648586.JavaMail.zimbra@raptorengineeringinc.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1446417444.13111032.1658777648586.JavaMail.zimbra@raptorengineeringinc.com>
User-Agent: Mutt/1.4.2.3i
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 25, 2022 at 02:34:08PM -0500, Timothy Pearson wrote:
> >> Further digging shows that the build failures only occur with compilers
> >> that default to 64-bit long double.
> > 
> > Where the heck do we have 'long double' things anywhere in the kernel?
> > 
> > I tried to grep for it, and failed miserably. I found some constants
> > that would qualify, but they were in the v4l colorspaces-details.rst
> > doc file.
> > 
> > Strange.
> 
> We don't, at least not that I can see.  The affected code uses standard doubles.
> 
> What I'm wondering is if the compiler is getting confused between standard and long doubles when they are both the same bit length...

The compiler emits the same code (DFmode things, double precision float)
in both cases, and it itself does not see any difference anymore fairly
early in the pipeline.  Compare to int and long on most 32-bit targets,
both are SImode, the compiler will not see different types anymore:
there *are* no types, except in the compiler frontend.

It only happens for powerpc64le things, and not for powerpc64 builds.

It is probably a GCC problem.  I don't see what forces the GCC build
here to use 64-bit long double either btw?  Compilers build via buildall
have all kinds of unnecessary things disabled, but not that, not
directly at least.


Segher
