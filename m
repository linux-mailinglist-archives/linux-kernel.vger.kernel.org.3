Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9B234DD874
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Mar 2022 11:50:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235273AbiCRKvc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Mar 2022 06:51:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235291AbiCRKv2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Mar 2022 06:51:28 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A794283ECC;
        Fri, 18 Mar 2022 03:50:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=CU3Zr9Ix9W0fGRu7idIDFNfy1dvFhYz4Oam7t61V8Zk=; b=FpMdUAdHqEGMLGTMr1gk9sHpjf
        cuPta60XfUQCBVPSaeqxNVmXf6eND1gSDvd9yPlMtwI2r3mI/GdmFXKDoiIkRH8/QnXHeRTOWGPfm
        j7J6pG0oMkzFO1f8N2aT/JiJBHZqCl25HK3MtqXfHvAGH2R13IR68VRBLOKhnElKQu08nJBFkQQQh
        q0F9Dj2muG1p1xygIWsSN7OxWpqeuPTHpvwnMcTlMwdCLi+5+ZGga1lk85fW27aCtzsDvKoPrQBf9
        3ZW40y3cCjiFsy65dbzfMvZCas9VPES7DZfM5xjJ2U/8vJR4XasVCBNviA4cVRdMl+Knqrc7LiU6A
        BlAh0bpw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nVABE-002Bdv-Uk; Fri, 18 Mar 2022 10:50:01 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id B160B3001C7;
        Fri, 18 Mar 2022 11:49:58 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 84F462D35E96F; Fri, 18 Mar 2022 11:49:58 +0100 (CET)
Date:   Fri, 18 Mar 2022 11:49:58 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     David Laight <David.Laight@aculab.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-tip-commits@vger.kernel.org" 
        <linux-tip-commits@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>
Subject: Re: [tip: x86/core] objtool: Find unused ENDBR instructions
Message-ID: <YjRj1lmqPFdkslpr@hirez.programming.kicks-ass.net>
References: <20220308154319.763643193@infradead.org>
 <164734101940.16921.11639161864874862247.tip-bot2@tip-bot2>
 <a5fa50d9f00542de8a6ad7a3fe0c49b3@AcuMS.aculab.com>
 <20220317222254.lm2f2337jejcf3uu@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220317222254.lm2f2337jejcf3uu@treble>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 17, 2022 at 03:22:54PM -0700, Josh Poimboeuf wrote:
> On Tue, Mar 15, 2022 at 03:39:52PM +0000, David Laight wrote:
> > From: Peter Zijlstra
> > > 
> > > objtool: Find unused ENDBR instructions
> > > 
> > > Find all ENDBR instructions which are never referenced and stick them
> > > in a section such that the kernel can poison them, sealing the
> > > functions from ever being an indirect call target.
> > 
> > Thought, what happens if the only indirect call is from
> > code in a module?
> 
> Then <boom>, I guess.  Is it safe to assume in-tree modules don't need
> to do indirect calls to exported functions?  I guess we'll find out :-)

So exported functions will keep their ENDBR. Specifically, their address
is taken by the EXPORT_SYMBOL thing.

Sealing them might work, but let's not do that just now ;-)

Any unexported function discovered through kallsyms OTOH... those
deservedly will go *boom*.
