Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 92AF9468496
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Dec 2021 12:56:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384844AbhLDL7b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Dec 2021 06:59:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229551AbhLDL73 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Dec 2021 06:59:29 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54D8CC061751
        for <linux-kernel@vger.kernel.org>; Sat,  4 Dec 2021 03:56:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=t3Dl7tMLWvxnBX3erOD3oeWsFzyCNOPqIhOLkEK/8dQ=; b=oJwj0uUiEdDSmipXbx3UhWW5hv
        1UvehUcfwLG3j3sgRqRDPAwzuIlO6L5JioD010b8SH9NRQ2P41L3lVjsWvGYSdFQUHUuTghqkQ/x2
        St52ZuEXHl29ARp7T1ivOg2K0iSKLxxvcmXDv4LQ/sUgFPkYwCmPy+Bm84mrBQAhFZPsMi04pG8FD
        WsYa6CEpyFh8Br8X5AeYt4NfizCjYMjHCoZQzfGh+dLvLDY5ygEeETXZY1XqiRm6Rwbmo0b4WxQCK
        fmyQtzwHmqD6irSJZRc8pXTjoesXVq8Bfoe5a3UQN1ZgsoHe3fVbpfUWRoVkNVmpgMmB9CZe0RdDE
        jOYB8F8g==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mtTdp-002Bul-Vh; Sat, 04 Dec 2021 11:55:46 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 90C4E98168C; Sat,  4 Dec 2021 12:55:45 +0100 (CET)
Date:   Sat, 4 Dec 2021 12:55:45 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Jiaxun Yang <jiaxun.yang@flygoat.com>
Cc:     x86@kernel.org, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com,
        chang.seok.bae@intel.com, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 00/10] x86: Allocate AVX512 xstate ondemand
Message-ID: <20211204115545.GW16608@worktop.programming.kicks-ass.net>
References: <20211203003636.11417-1-jiaxun.yang@flygoat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211203003636.11417-1-jiaxun.yang@flygoat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 03, 2021 at 12:36:26AM +0000, Jiaxun Yang wrote:
> This series makes allocation of AVX512 xstate buffer ondemand.
> It can save some memory (~2k for a thread not using AVX512).
> 
> Also we are going to have heterogeneous processors that
> only some cores support AVX512, it can be helpful when
> dealing with such processors.
> 
> Patch 1~6 are some preparations.
> Patch 7 moves reallocation of xstate buffer to save_fpregs_to_fpstate.
> Patch 8~10 are some cleanup and enablement work.
> 
> Tested on a Skylake-X system with AVX512 intensive y-cruncher and numpy,
> the performance impact seems neglectable.
> 
> Any sugguestions are welcomed.

If we're going to do asymmetric avx512 it needs to come with a prctl()
interface like AMX. 
