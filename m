Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFA3B542776
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 09:05:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240710AbiFHHE1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 03:04:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236354AbiFHGDz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 02:03:55 -0400
Received: from zeniv-ca.linux.org.uk (zeniv-ca.linux.org.uk [IPv6:2607:5300:60:148a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A25347B491
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jun 2022 21:54:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=+Aq0BEXW9Vx+qdJvDk57eAicNJ2BKjCbJLuilgiXECE=; b=JhoGfEViWh+8/+pz1wq98sMeQv
        EpyDPOIMiUcj6oAzclYz7wHD+SJn5oDpUu1dWWNvi1W6fEAetRQejsyUxlXh2Kieu3Zg8VA5AdQO/
        1biPimiuOp6Rsf6q+aTCd3oGSvhtorbSo9INV3gSqR91Ytt6TN8f8C26dZ8lnjzVEsZ8PN+1JxJ3r
        uBVR95r4TED4GhuhGJNJXqU2BhIVT0wSO1gOoy8Rev+s/01ocQ0xxvRhc1a/DuTeWfKX9CY2i3ITq
        tW6fwDendyi3TRLkvx1K4hwV8QIbH4Z44/60n0zCtNdaBVweVcJC/W09Binc7n4X5NRICV7fFsEn+
        vGC3VREw==;
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nyni9-004zX5-2C; Wed, 08 Jun 2022 04:54:29 +0000
Date:   Wed, 8 Jun 2022 04:54:29 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Justin Stitt <jstitt007@gmail.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Tom Rix <trix@redhat.com>, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, Richard Smith <richardsmith@google.com>
Subject: Re: [PATCH] include/uapi/linux/swab.h: add __u16 cast to __swab16
 conditional
Message-ID: <YqArhaiEu+6YWZfg@zeniv-ca.linux.org.uk>
References: <20220607222006.22719-1-jstitt007@gmail.com>
 <20220607152744.d7c801d092529309500ac9a6@linux-foundation.org>
 <CAKwvOdmXeRbFjkHgFXps4pLH6Q6pGWRNOqA85=h2aFnR=uaggg@mail.gmail.com>
 <20220607162128.b5d4aa70f4a8a7610ce29250@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220607162128.b5d4aa70f4a8a7610ce29250@linux-foundation.org>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 07, 2022 at 04:21:28PM -0700, Andrew Morton wrote:

> > 6.5.15/5
> > >> If both the second and third operands have arithmetic type, the result type that would be determined by the usual arithmetic conversions, were they applied to those two operands, is the type of the result.
> > 6.3.1.8/1
> > >> Otherwise, the integer promotions are performed on both operands.
> > 6.3.1.1/2
> > >> If an int can represent all values of the original type (as restricted by the width, for a bit-field), the value is converted to an int; otherwise, it is converted to an unsigned int. These are called the integer promotions.
> 
> Geeze.  Can we please turn this into English and add it to the changelog?
> 
> Is it saying that an expression
> 
> 	int ? u16 : u16
> 
> has type int?  Or something else?  What did we do wrong here and is it
> possible to correct our types rather than adding a cast?

Not quite.  Same rules as u16 + u16 - on architectures where int is wider
than 16 bits it's (int)u16 + (int)u16 and yields int, on 16bit ones it's
(unsigned int)u16 + (unsigned int)u16 and yields unsigned int.

You *can't* get smaller-than-int out of ? :, same as you can't get it
out of addition, etc.

__builtin_choose_expr() would do it, but I would take a cast over that
ugliness.

FWIW, it might make sense for clang to keep track of the following
property: expression has the same value as it would if integer promotions
in it had been replaced with integer promotion of result.

Example: with
	unsigned short x, y, mask;

expresion "x & y" is interpreted as and_int((int)x, (int)y), which is equal
to (int)and_u16(x, y), so that expression has the property in question.
"x != 12 ? x : y" has the same property.  "x + y", OTOH, doesn't - if x and y
are both 32768, x + y is add_int((int)x, (int)y), i.e. 65536, while
(int)add_u16(x, y) would be 0.

For a somewhat more subtle example,
	(x & ~mask) | (y & mask)
is interpreted as
	or_int(and_int((int)x, not_int((int)mask)), and_int((int)y, (int)mask))
which is equal to
	(int)or_u16(and_u16(x,not_u16(mask)), and_u16(y, mask))
IOW, the property in question holds for that one, despite having a subexpression
(~mask) that does *NOT* have that property.  (int)not_u16(0) is 0xffff and
not_int((int)0) is (assuming 32bit int) 0xffffffff.  Upper 16 bits get fouled;
applying & with known-16bit launders them off...

That predicate is behind the handling of small bitwise types in sparse;
otherwise all operations on __be16 would trigger warnings due to promotions
from __be16 to int.  And aforementioned subtle example is common enough, so we
had to deal with it.  See commit d24967cb847b "[PATCH] handle fouled-bitwise"
in sparse git...
