Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5873D59F1EB
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Aug 2022 05:20:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233130AbiHXDUQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 23:20:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231311AbiHXDUL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 23:20:11 -0400
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D9225006B
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 20:20:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=DXkUL0lTzcYhM1i/H/AeEilwAfKbgCrix6DGQiR8Bxo=; b=rjYP9EQGlOZZRNzLa52ScLzVHU
        7IBJLINQwn5JiKKIXHKtetyjBem940cu29ZjwnYxy6hlGqosMVSRpXS9jjEKNMbZtzTlwsJE0ZZM8
        I6qUnAA1jw2m+auAjUPGJvaJFPp0CWXzI68LnqglFYGTCVePXqydvrTnJ1SfY1JRR29g/D1oT+8eV
        mnAJndSS+wHc71lUYIjGejh0lxlns7nv8pgXICWUsH1B3FYdjjbmFMgERvzpA3MUy6/htAlnI8hF9
        BhC6tWgZFFLwF8TlJ2e5c22cRZddIqVsqeNQn1AhWEhw9YyPF3NAdTGJ3PfXficiRRe1WiVVw4xXX
        FdtqglyA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.95 #2 (Red Hat Linux))
        id 1oQgw0-007d7D-KS;
        Wed, 24 Aug 2022 03:20:04 +0000
Date:   Wed, 24 Aug 2022 04:20:04 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Bart Van Assche <bvanassche@acm.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Hellwig <hch@lst.de>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Jens Axboe <axboe@kernel.dk>
Subject: Re: [for-linus][PATCH 01/10] tracing: Suppress sparse warnings
 triggered by is_signed_type()
Message-ID: <YwWY5KrhY0RGpC4l@ZenIV>
References: <20220821000844.510643400@goodmis.org>
 <CAHk-=wjsxu782N0P+oMu35N7rJAOeh3buQFWJaZHZTNmVSB=3Q@mail.gmail.com>
 <5700ac75-f6a9-877e-4011-9b314f12b5ab@acm.org>
 <CAHk-=wjqkWEr0MRO5hWuBoTDgNUj4qQK8V_Y36et=61mdPztJw@mail.gmail.com>
 <02daa3d6-2847-d7e0-e23e-411076c6d4db@rasmusvillemoes.dk>
 <0163b361-14bf-7b4c-751a-14f1a004b1a9@acm.org>
 <CAHk-=wjMLb30d0WT_RyKBCX+JBkg3QQU6pCYkrV8f58Ya4Rgzw@mail.gmail.com>
 <CAHk-=wiwr2Ff_1SKzRkjSbNLFYfk4KurvZhLuwVuTT-m9w5_6A@mail.gmail.com>
 <YwWIQ/3BDQHOiTek@ZenIV>
 <YwWWoQXmVc8uasBh@ZenIV>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YwWWoQXmVc8uasBh@ZenIV>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 24, 2022 at 04:10:25AM +0100, Al Viro wrote:
> *IF* you want to go that way, I would suggest a new return value for
> restricted_binop() ("comparison with magical value"), with
> something like
> 		switch (restricted_binop(op, ctype)) {
> 		case 1:
> 		....
> 
> 		default:
> 			break;
> 		case 4:
> 			// comparison with magic value:
> 			// quietly go for underlying type, if not fouled
> 			// if fouled, just return NULL and let the caller
> 			// deal with that - loudly.
> 			if (!(lclass & rclass & TYPE_FOULED))

 			if (!((lclass | rclass) & TYPE_FOULED))

that is - we don't need both of them being fouled to trigger a warning;
either one should suffice.
