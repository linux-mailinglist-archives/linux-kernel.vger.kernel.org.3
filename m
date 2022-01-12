Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B002648C759
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jan 2022 16:38:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245085AbiALPil (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jan 2022 10:38:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234800AbiALPik (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jan 2022 10:38:40 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AEE5C06173F;
        Wed, 12 Jan 2022 07:38:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=ZJZXi7uKPajL3QMTUFGMnMN7b0ltmbxkEaYGU+MZrck=; b=rX9qbDMnl+iED6l5LqCDVa2ucV
        fFaMZmyFgrCpzD4oj9qI3RuAMiWkHLHBMu1TGESCzPR+Wy9NuXnFNcDlIh3RtR9859H4LgdwBaOku
        qgTSBLvygkdBmF3Xc8vdG6zH/E3Su4fXMUyE0nXPvCEEoHZW+UwVHOk6FJE6EHa9RIan4vCsEtbuT
        BDqsEBAI7CkKS4hwjWATxq4LBuX/pkkSRBriyf0bcGY4Wuj82iMqeibIiMHWT0Pjwu3d6hVpYo2kt
        52Haa59lBTKiDbcXUfYt2c9YKRGmhgxxQ8M9imc8OiLGPGKuldM55IbJgpCCgRCK2FGTZ8wP+vMtE
        durYpLuA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1n7fho-004Cwg-GE; Wed, 12 Jan 2022 15:38:32 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 79D9D300222;
        Wed, 12 Jan 2022 16:38:32 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 5CAFA2B33E98B; Wed, 12 Jan 2022 16:38:32 +0100 (CET)
Date:   Wed, 12 Jan 2022 16:38:32 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Florian Weimer <fw@deneb.enyo.de>
Cc:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        paulmck <paulmck@kernel.org>, Boqun Feng <boqun.feng@gmail.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Paul Turner <pjt@google.com>,
        linux-api <linux-api@vger.kernel.org>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        carlos <carlos@redhat.com>
Subject: Re: [RFC PATCH] rseq: x86: implement abort-at-ip extension
Message-ID: <Yd71+Da44h9Ge0+s@hirez.programming.kicks-ass.net>
References: <20220107170302.8325-1-mathieu.desnoyers@efficios.com>
 <87a6g7ny0j.fsf@mid.deneb.enyo.de>
 <1968088162.13310.1641584935813.JavaMail.zimbra@efficios.com>
 <87y23l6l2j.fsf@mid.deneb.enyo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87y23l6l2j.fsf@mid.deneb.enyo.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 12, 2022 at 04:16:36PM +0100, Florian Weimer wrote:

> You could perhaps push a signal frame onto the stack.  It's going to
> be expensive, but it's already in the context switch path, so maybe it
> does not matter.

Please no! Signals are a trainwreck that need change (see the whole
AVX-512 / AMX saga), we shouldn't use more of that just cause.
