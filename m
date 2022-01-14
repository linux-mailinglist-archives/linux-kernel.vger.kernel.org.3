Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3F3148E6ED
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jan 2022 09:53:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237985AbiANIxM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jan 2022 03:53:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230177AbiANIxL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jan 2022 03:53:11 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D0A7C061574
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jan 2022 00:53:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=XDdFiFYcMGjCRySrjyxXHgb42tImQV0MD5bVeKoPEFU=; b=U7F/KxmsVN8BvK8HHguJBC5oND
        ZjWbpqt+Jb0lYCWHk3f+4H2bPtpy08rL/7ImuspsyEqzM3FAKdBdKHrvzprUlXew8zugXXoXtbkT+
        do9Eop2wMDfMK0k7+isOSyGetFbnNBy1T2hR8Gf41MEgmv6DrwAWsNAl8ozO/wBiQGv7KBNf91NXq
        bUD2Pb9T575+cToGoIs4UlHUSlINnRZvkLGlMi2JG9Bsqxwi6pJBo1mAjZ4IPhm8/yuZ4rwueESQl
        tchc3b/yKGFDURRX5yNRGIAV1QTuP4heE90zBba4NIf9F72mo3JYEB9keMaP4wvyTGFLNvnzKJ9dZ
        UV2UqBCw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1n8IKa-0017Cv-3Q; Fri, 14 Jan 2022 08:53:08 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id BC3D23002C1;
        Fri, 14 Jan 2022 09:53:07 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id A0C9B3023C766; Fri, 14 Jan 2022 09:53:07 +0100 (CET)
Date:   Fri, 14 Jan 2022 09:53:07 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Sergei Trofimovich <slyich@gmail.com>
Cc:     linux-kernel@vger.kernel.org, Josh Poimboeuf <jpoimboe@redhat.com>
Subject: Re: [PATCH] objtool: check: give big enough buffer for pv_ops
Message-ID: <YeE588tXLrgWoUu4@hirez.programming.kicks-ass.net>
References: <20220114075756.838243-1-slyich@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220114075756.838243-1-slyich@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 14, 2022 at 07:57:56AM +0000, Sergei Trofimovich wrote:
> On gcc-12 build fails flagging possible buffer overflow:
> 
>     check.c: In function 'validate_call':
>     check.c:2865:58: error: '%d' directive output may be truncated writing between 1 and 10 bytes into a region of size 9 [-Werror=format-truncation=]
>      2865 |                 snprintf(pvname, sizeof(pvname), "pv_ops[%d]", idx);
>           |                                                          ^~
> 
> I think it's a valid warning:
> 
>     static char pvname[16];
>     int idx;
>     ...
>     idx = (rel->addend / sizeof(void *));
>     snprintf(pvname, sizeof(pvname), "pv_ops[%d]", idx);
> 
> we have only 7 chars for %d while it could take up to 9.

Right, very unlikely to have that many pv_ops, but it doesn't hurt to
fix this.

Thanks!
