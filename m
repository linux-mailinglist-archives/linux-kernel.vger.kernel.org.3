Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0FAD4C496E
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 16:44:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242302AbiBYPoQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 10:44:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242307AbiBYPoL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 10:44:11 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 796B522EDF3
        for <linux-kernel@vger.kernel.org>; Fri, 25 Feb 2022 07:43:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Z8O9C1ayM0iVxKknw+Jr7/ytuJpBQ60SVz3LG+uOJHY=; b=MbfOa76gDoSq2d7ZTpr0/KFmdS
        8LLvf6cz7GIKQAnQcUvFpfa+25Q8mKe+qsYhSHffIfWfbcbMayW9LZ/si3c6rHX0A8T55Rbxlt3df
        SOIhfOFRqPFP/Hyy2XktJoWaTM/g9YxKIMF21yn2n7yhpaIljhCd26iMMJrHDMn2P5IwZsM4/kUTl
        EMzIh46E1Tu0zJ2O53OOkM9AX0wUc9t1DT0HyeSmOhzrTzcP+xzIy69cm9pUH2ecQKfj+qlPin94k
        xwd8QLfgPO7AG6d0nViI54TFA6e0OHXNfHG3R2//7ArxkDJj97E4nuB9GlmLl5OSsulq4Pyn4k/1O
        D3mL/35A==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nNcka-00CznF-Vk; Fri, 25 Feb 2022 15:43:21 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 971F5300472;
        Fri, 25 Feb 2022 16:43:20 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 811D03060F95C; Fri, 25 Feb 2022 16:43:20 +0100 (CET)
Date:   Fri, 25 Feb 2022 16:43:20 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     x86@kernel.org, joao@overdrivepizza.com, hjl.tools@gmail.com,
        andrew.cooper3@citrix.com, linux-kernel@vger.kernel.org,
        ndesaulniers@google.com, keescook@chromium.org,
        samitolvanen@google.com, mark.rutland@arm.com,
        alyssa.milburn@intel.com, mbenes@suse.cz, rostedt@goodmis.org,
        mhiramat@kernel.org, alexei.starovoitov@gmail.com
Subject: Re: [PATCH v2 00/39] x86: Kernel IBT
Message-ID: <Yhj5GKLfyxbNCGua@hirez.programming.kicks-ass.net>
References: <20220224145138.952963315@infradead.org>
 <20220224202602.3gvz5tnxvwb4maod@treble>
 <Yhj1oFcTl2RnghBz@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yhj1oFcTl2RnghBz@hirez.programming.kicks-ass.net>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 25, 2022 at 04:28:32PM +0100, Peter Zijlstra wrote:
> +void *skip_endbr(void *addr)
> +{
> +	unsigned long size, offset;
> +
> +	if (is_endbr(*(unsigned int *)addr) &&
> +	    kallsyms_lookup_size_offset((unsigned long)addr, &size, &offset) &&
> +	    !offset)
> +		addr += 4;
> +
> +	return addr;
> +}

Damn, I just realized this makes KERNEL_IBT hard depend on KALLSYMS :-(
