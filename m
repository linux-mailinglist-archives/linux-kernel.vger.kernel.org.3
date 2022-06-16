Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4348854DE31
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 11:31:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232439AbiFPJbW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 05:31:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbiFPJbV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 05:31:21 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36D3D3BA67
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jun 2022 02:31:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=/FLWc2TEgQvR6Lestc/lCyA2NX/oAWdgoQaLyVOcOsg=; b=Mtv0e/0LUtujFXUBTyvN/ogSTh
        2DwxkKZc8SnJ7MCr0ztCYUVLCD9GVP3jLiDiDZxjwviLX3Ljttry0RcUNaDwlQLO05yTG/DkaJvVF
        nfNYY6UFvtX6uIjmLp6mUoeezK5cRE73isYCZxMUohsm3bLZYWfl8kgnTlwyFsKZjnwDdpo58OVax
        6RQO2f23hOUuscc3R14mclfwXPLsH13b88v8W6MBQoKRqndH0ha5FvJ3QebZMEhWypCLf3C19BvaB
        /eMeFfKf9J5AhnZG1QvK4YpBy5uqBVU/irEC5pxpESCitQdUvnxxY1xO65UhJ38+98hjbf81IS3pD
        4peHHqlg==;
Received: from dhcp-077-249-017-003.chello.nl ([77.249.17.3] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1o1lq0-008Nat-CN; Thu, 16 Jun 2022 09:30:53 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 0FEE630023F;
        Thu, 16 Jun 2022 11:30:50 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id EA3162014ABD6; Thu, 16 Jun 2022 11:30:49 +0200 (CEST)
Date:   Thu, 16 Jun 2022 11:30:49 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
Cc:     "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
        "Lutomirski, Andy" <luto@kernel.org>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "hjl.tools@gmail.com" <hjl.tools@gmail.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "kcc@google.com" <kcc@google.com>,
        "andreyknvl@gmail.com" <andreyknvl@gmail.com>,
        "ak@linux.intel.com" <ak@linux.intel.com>,
        "dvyukov@google.com" <dvyukov@google.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "ryabinin.a.a@gmail.com" <ryabinin.a.a@gmail.com>,
        "glider@google.com" <glider@google.com>
Subject: Re: [PATCHv3 5/8] x86/uaccess: Provide untagged_addr() and remove
 tags before address check
Message-ID: <Yqr4SVMyHRTkc+LN@hirez.programming.kicks-ass.net>
References: <20220610143527.22974-1-kirill.shutemov@linux.intel.com>
 <20220610143527.22974-6-kirill.shutemov@linux.intel.com>
 <c7e2f8fb44da067e7565d091edeac300977b65ed.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c7e2f8fb44da067e7565d091edeac300977b65ed.camel@intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 13, 2022 at 05:36:43PM +0000, Edgecombe, Rick P wrote:
> On Fri, 2022-06-10 at 17:35 +0300, Kirill A. Shutemov wrote:
> > +#ifdef CONFIG_X86_64
> > +/*
> > + * Mask out tag bits from the address.
> > + *
> > + * Magic with the 'sign' allows to untag userspace pointer without
> > any branches
> > + * while leaving kernel addresses intact.
> 
> Trying to understand the magic part here. I guess how it works is, when
> the high bit is set, it does the opposite of untagging the addresses by
> setting the tag bits instead of clearing them. So:

The magic is really rather simple to see; there's two observations:

  x ^ y ^ y == x

That is; xor is it's own inverse. And secondly, xor with 1 is a bit
toggle.

So if we mask a negative value, we destroy the sign. Therefore, if we
xor with the sign-bit, we have a nop for positive numbers and a toggle
for negatives (effectively making them positive, -1, 2s complement
yada-yada) then we can mask, without fear of destroying the sign, and
then we xor again to undo whatever we did before, effectively restoring
the sign.

Anyway, concequence of all this is that LAM_U48 won't work correct on
5-level kernels, because the mask will still destroy kernel pointers.

As such, this patch only does LAM_U57.


