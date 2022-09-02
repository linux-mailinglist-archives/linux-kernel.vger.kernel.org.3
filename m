Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA3CC5AB63E
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 18:10:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237470AbiIBQKi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Sep 2022 12:10:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236876AbiIBQKU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Sep 2022 12:10:20 -0400
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 937CA12E4C4
        for <linux-kernel@vger.kernel.org>; Fri,  2 Sep 2022 09:03:05 -0700 (PDT)
Received: from gate.crashing.org (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id 282Fxtno015877;
        Fri, 2 Sep 2022 10:59:55 -0500
Received: (from segher@localhost)
        by gate.crashing.org (8.14.1/8.14.1/Submit) id 282FxsqO015876;
        Fri, 2 Sep 2022 10:59:54 -0500
X-Authentication-Warning: gate.crashing.org: segher set sender to segher@kernel.crashing.org using -f
Date:   Fri, 2 Sep 2022 10:59:54 -0500
From:   Segher Boessenkool <segher@kernel.crashing.org>
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH v2 2/2] powerpc/math-emu: Remove -w build flag and fix warnings
Message-ID: <20220902155954.GP25951@gate.crashing.org>
References: <a7384eafc6a27aea15bdc9e8f9a12aac593fccb7.1662113301.git.christophe.leroy@csgroup.eu> <35c86b7ca823954c6cd593acc3690dc3748da9b1.1662113301.git.christophe.leroy@csgroup.eu> <YxIjM/jdLajq4dFk@dev-arch.thelio-3990X>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YxIjM/jdLajq4dFk@dev-arch.thelio-3990X>
User-Agent: Mutt/1.4.2.3i
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 02, 2022 at 08:37:23AM -0700, Nathan Chancellor wrote:
> On Fri, Sep 02, 2022 at 12:08:55PM +0200, Christophe Leroy wrote:
> > This should have been detected by gcc at build time, but due to
> > '-w' flag it went undetected.
> > 
> > Removing that flag leads to many warnings hence errors.

> Thanks for figuring out what was going on here! I took this patch for a
> spin with clang and it has a few more errors around
> -Wimplicit-fallthrough:

Maybe add -Wno-implicit-fallthrough?  This code is a copy from outside
the kernel, no one has ever wanted to maintain it, if nothing else (the
more politically correct formulation is "we cannot as easily pick up
improvements from upstream if we modify stuff").


Segher
