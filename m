Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A0F1508C79
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 17:51:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379757AbiDTPyQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 11:54:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232903AbiDTPyO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 11:54:14 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 339C03FDB4
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 08:51:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=64YXxcekbBcHuR/pr9BA25gJNm0zvp5b2EChe5V7YSU=; b=MrsvalZVr0CQIT6szVIkkuWZ4A
        TbpXqRendCyaA6KlLbK+GDCq2k1ScDQXQq85oaFOgFLLk0HSnvHDaqAx0ThJ8XOpxMhqAl8EXEKNu
        vq78Lrx4DbuWOgKVsdADM2ObhI23B+arlKunYymzdTH9lieMoTI3o1zh3dF7A3DnPkdbDJsSJ2cQm
        OZ/mJhvJjyc/ojyxfpANiU5Ele6k1U5UDIR5tx/eq6D8ZyPeDwjU0gIkI3buKSWI5pi95q5IiyJBZ
        IPD9oH2IAb/UP6lZ4iPvySK5tzjenuDFDWZH+Mbb4r16gOjxmmVzVh4UpZe+9aFERtEGsYGzREmVA
        Na2Yezfg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nhCbu-0079ps-2e; Wed, 20 Apr 2022 15:51:18 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 6BC109861A4; Wed, 20 Apr 2022 17:51:16 +0200 (CEST)
Date:   Wed, 20 Apr 2022 17:51:16 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     x86@kernel.org, brgerst@gmail.com, jiangshanlai@gmail.com,
        Andrew.Cooper3@citrix.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] x86: Simplify Retpoline thunk
Message-ID: <20220420155116.GH2731@worktop.programming.kicks-ass.net>
References: <20220419204109.520779286@infradead.org>
 <20220419205241.280037046@infradead.org>
 <20220420152736.qzl3nikds6mq5nrr@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220420152736.qzl3nikds6mq5nrr@treble>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 20, 2022 at 08:27:36AM -0700, Josh Poimboeuf wrote:
> On Tue, Apr 19, 2022 at 10:41:10PM +0200, Peter Zijlstra wrote:
> > Now that we rewrite all the indirect call sites, per commit:
> > 
> >   750850090081 ("x86/alternative: Implement .retpoline_sites support")
> > 
> > it doesn't make sense to have the retpoline thunks be an ALTERNATIVE_2
> > that still includes a 'naked' indirect jump.
> > 
> > (this accidentally 'defunnels' i386 by going back to full retpolines)
> 
> So mitigations=off no longer works on i386?

Also true I suppose... does anybody care? /me runs like heck.

I'd hate to make all this more complicated just because i386 tho :/
