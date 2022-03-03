Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDBC64CB9A5
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Mar 2022 09:55:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231713AbiCCI4C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Mar 2022 03:56:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230184AbiCCI4A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Mar 2022 03:56:00 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F20C177755
        for <linux-kernel@vger.kernel.org>; Thu,  3 Mar 2022 00:55:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=H+SUlXCWXBIEUIT6TfbeNkXNa6WYFXh2j7WAqR2WhX8=; b=COtNTXAHFGJNloB10+Vmk+o+li
        5X69cK2j4zoTkZ0ARRgZ8PK+pAyLmK5RG2CBqEzRh0WIpEoZ7ZHXNBXPBel2tSw/e4IQeYTd1vU12
        UpWSM534PaFmVwsod/WiiZwtaqUys55PGzCPwDF/9YKz6n8vPVU24wMJI4bafDTXRDadfXficrGZB
        WAwA6uWKs4jtD+IsYljmPAOil80dFahuQXPa4bSFzQ5CS70gs3QGxYMApFa2+p/G+HLVjMwa1Z/hc
        Mzb0c6QqYnied4xBbunnQqTLo4eT5HyLTlFypARx6aGm31qFSmzc0kRvy0mdqz1jKEaujtgXWmrJ/
        PfjdGxDg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nPhEi-00ErvT-Gk; Thu, 03 Mar 2022 08:55:00 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 05992300242;
        Thu,  3 Mar 2022 09:54:59 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id E494A2079ED7B; Thu,  3 Mar 2022 09:54:58 +0100 (CET)
Date:   Thu, 3 Mar 2022 09:54:58 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Lai Jiangshan <jiangshanlai@gmail.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        Lai Jiangshan <jiangshan.ljs@antgroup.com>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH V2 3/7] x86/entry: move PUSH_AND_CLEAR_REGS out of
 error_entry
Message-ID: <YiCCYrhr8zZ7Kd86@hirez.programming.kicks-ass.net>
References: <20220303035434.20471-1-jiangshanlai@gmail.com>
 <20220303035434.20471-4-jiangshanlai@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220303035434.20471-4-jiangshanlai@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 03, 2022 at 11:54:30AM +0800, Lai Jiangshan wrote:
> From: Lai Jiangshan <jiangshan.ljs@antgroup.com>
> 
> Moving PUSH_AND_CLEAR_REGS out of error_entry doesn't change any
> functionality.  It will enlarge the size:
> 
> size arch/x86/entry/entry_64.o.before:
>    text	   data	    bss	    dec	    hex	filename
>   17916	    384	      0	  18300	   477c	arch/x86/entry/entry_64.o
> 
> size --format=SysV arch/x86/entry/entry_64.o.before:
> .entry.text                      5528      0
> .orc_unwind                      6456      0
> .orc_unwind_ip                   4304      0
> 
> size arch/x86/entry/entry_64.o.after:
>    text	   data	    bss	    dec	    hex	filename
>   26868	    384	      0	  27252	   6a74	arch/x86/entry/entry_64.o
> 
> size --format=SysV arch/x86/entry/entry_64.o.after:
> .entry.text                      8200      0
> .orc_unwind                     10224      0
> .orc_unwind_ip                   6816      0
> 
> But .entry.text in x86_64 is 2M aligned, enlarging it to 8.2k doesn't
> enlarge the final text size.
> 
> The tables .orc_unwind[_ip] are enlarged due to it adds many pushes.
> 
> It is prepared for not calling error_entry() from XENPV in later patch
> and for future converting the whole error_entry into C code.

And also, IIUC, folding that int80 thing a few patches down, right?
