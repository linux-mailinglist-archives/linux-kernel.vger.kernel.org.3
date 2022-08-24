Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22A7E59FF4A
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Aug 2022 18:17:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239072AbiHXQQw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Aug 2022 12:16:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237458AbiHXQQu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Aug 2022 12:16:50 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9113326F6;
        Wed, 24 Aug 2022 09:16:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=kULtSLmXAg2mmU6izdJJrTMPsKQ/4zaIhDQaWWwzK3o=; b=bSCAwSIRCDDU3VeFWu5DIbeSkm
        umiEh7LIyj/bJoGk0OvRlrrD1yOzHRRZNXwUnzIR64kfonK293kfPZ+CcWM4sPAlInpI5qedl2emb
        UelxpwtyFgSaT7SiTugm6xMJaZwJZmUNspe0SCqQ1UucOhwSm5E79jREOnAEmLynj4+BvaN2ZImLr
        dPya6YujQolbZs2U0ATbu0flgEWVaxn+OFsRF+0NCrqEmJqkpcuIETKrzycB5+I2/yX71IqpxuBwT
        3OVNOvn9JsCi6hpnlnzKPn6ZgEAtbOkHTLaAi9F47SreGec6tI2/28cNkAlqY7MhUgu6+8e4KnLKy
        KZAsKBTQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=worktop.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oQt3V-005mck-5m; Wed, 24 Aug 2022 16:16:37 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 14379980BE2; Wed, 24 Aug 2022 18:16:35 +0200 (CEST)
Date:   Wed, 24 Aug 2022 18:16:34 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Borislav Petkov <bp@alien8.de>
Cc:     X86 ML <x86@kernel.org>, Michael Matz <matz@suse.de>,
        linux-toolchains@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>
Subject: Re: [PATCH] x86/sev: Mark snp_abort() noreturn
Message-ID: <YwZO4iYumjhxv73h@worktop.programming.kicks-ass.net>
References: <20220824152420.20547-1-bp@alien8.de>
 <YwZF8pvWHqFYQOVB@worktop.programming.kicks-ass.net>
 <YwZIaJIr4Zmpaams@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YwZIaJIr4Zmpaams@zn.tnic>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 24, 2022 at 05:48:56PM +0200, Borislav Petkov wrote:
> On Wed, Aug 24, 2022 at 05:38:26PM +0200, Peter Zijlstra wrote:
> > You'll probably also have to add it to the
> > objtool/check.c:global_noreturn[] list, for the case where objtool fails
> > to recognise it as noreturn.
> 
> How come?
> 
> Doesn't objtool see the attribute?

If only there would be a trace of it left in the ELF file...
