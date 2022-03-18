Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58B364DE018
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Mar 2022 18:41:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239704AbiCRRmR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Mar 2022 13:42:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235185AbiCRRmQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Mar 2022 13:42:16 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23E2F196089
        for <linux-kernel@vger.kernel.org>; Fri, 18 Mar 2022 10:40:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=UnwUchRztZx67XW2Wtg1p3jNoABacVhXYIkA4iPmYBY=; b=NONTVbUiR71+d0XeEcUfDpp0vP
        MD45EexewpUEUT12NhXyk4l9VOCb8yLfi+bcTQEWXsMpckaEb5xChedWfPc5fTjh1h2fK129+/85J
        Hm6FR3HNVdlvUi0F8DR4eW9s8pGpgqzWUO+fQGa31kyz/uvvTyJdE9/olTzVv69mADm7ilhVw1Brg
        AQzsAGv9FQeZ/kJ/CkQxgaFNjZDnuzXpKvg1MlyiZQVuH5pNRndlIxKG2D1AQbjmJzSMGOKH3YEtU
        bmLflbLqjsYd3ir/edfDfNhnm9cull9gwj+kle9CAxHUvu8tv3Tc9szD51ViCjMB6xaJ8PSmFGwly
        bTW7Rhzw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nVGaT-002GNw-QN; Fri, 18 Mar 2022 17:40:29 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 01ACF98841D; Fri, 18 Mar 2022 18:40:27 +0100 (CET)
Date:   Fri, 18 Mar 2022 18:40:27 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     Josh Poimboeuf <jpoimboe@redhat.com>,
        Jason Baron <jbaron@akamai.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ard Biesheuvel <ardb@kernel.org>, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, x86@kernel.org
Subject: Re: [PATCH v2] static_call: Don't make __static_call_return0 static
Message-ID: <20220318174027.GS8939@worktop.programming.kicks-ass.net>
References: <30821468a0e7d28251954b578e5051dc09300d04.1647258493.git.christophe.leroy@csgroup.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <30821468a0e7d28251954b578e5051dc09300d04.1647258493.git.christophe.leroy@csgroup.eu>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 14, 2022 at 12:49:36PM +0100, Christophe Leroy wrote:
> System.map shows that vmlinux contains several instances of
> __static_call_return0():
> 
> 	c0004fc0 t __static_call_return0
> 	c0011518 t __static_call_return0
> 	c00d8160 t __static_call_return0
> 
> arch_static_call_transform() uses the middle one to check whether we are
> setting a call to __static_call_return0 or not:
> 
> 	c0011520 <arch_static_call_transform>:
> 	c0011520:       3d 20 c0 01     lis     r9,-16383	<== r9 =  0xc001 << 16
> 	c0011524:       39 29 15 18     addi    r9,r9,5400	<== r9 += 0x1518
> 	c0011528:       7c 05 48 00     cmpw    r5,r9		<== r9 has value 0xc0011518 here
> 
> So if static_call_update() is called with one of the other instances of
> __static_call_return0(), arch_static_call_transform() won't recognise it.
> 
> In order to work properly, global single instance of __static_call_return0() is required.
> 
> Fixes: 3f2a8fc4b15d ("static_call/x86: Add __static_call_return0()")
> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>

Thanks! I've transferred Josh' ack from v1 in the presumption he's fine
with this one too :-)
