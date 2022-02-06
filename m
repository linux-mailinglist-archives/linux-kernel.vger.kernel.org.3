Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07A214AAFDE
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Feb 2022 15:06:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240619AbiBFOGa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Feb 2022 09:06:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236926AbiBFOG3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Feb 2022 09:06:29 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F393FC06173B
        for <linux-kernel@vger.kernel.org>; Sun,  6 Feb 2022 06:06:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=/ZKh7PGdl0Uet/UFu2VVQowIubV7FncomByUr8ikUOw=; b=SCE6xtScNRFKrj0XcK/YdXdmvC
        pBNowuinYTnoGZyETIxdCdLn7VG2/fRnDUYJ9EliHTOEum3cwZfDjO7qyHUhMKfE+hZ+b9k0PnsSd
        2bRjJm5va6VCxtPNxqsb3P7HvNyOvZmwp28XuAgJWVDfs1OkZxHykif/cHan8WBB3tFPyyBQ5ZxIw
        FCJuziS6AgZlH1rBiu2ffz81kq89gtY5tmlxPaY2vgX06EZsMAtSKrzo61UZZROVQt5wLt14rhFsk
        NiqfgxLwLfyPi6DhbhGJOWg1pNMUZyrmp4VdB3d6WSjCjMEsgAi+iC6wfPjUv0d176D4aF5j98pnH
        NiJpNDoA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nGiBM-007RDK-Nn; Sun, 06 Feb 2022 14:06:24 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id D3BFC3002C3;
        Sun,  6 Feb 2022 15:06:21 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id ACCE12CA510C0; Sun,  6 Feb 2022 15:06:21 +0100 (CET)
Date:   Sun, 6 Feb 2022 15:06:21 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     Boqun Feng <boqun.feng@gmail.com>, linux-kernel@vger.kernel.org,
        ardb@kernel.org, arnd@arndb.de, will@kernel.org
Subject: Re: [PATCH v2] atomics: fix atomic64_{read_acquire,set_release}
 fallbacks
Message-ID: <Yf/V3dlRIDxS9hWu@hirez.programming.kicks-ass.net>
References: <20220203161243.3955547-1-mark.rutland@arm.com>
 <YfxxSX3v6nSJ0tKo@tardis>
 <Yf0K8oxan1NvjKmE@FVFF77S0Q05N>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yf0K8oxan1NvjKmE@FVFF77S0Q05N>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 04, 2022 at 11:16:02AM +0000, Mark Rutland wrote:
> Sure; how about I add the following to the commit message:
> 
> | Since the fallback templates are used to generate the atomic64_*() and
> | atomic_*() operations, the __native_word() check is added to both. For
> | the atomic_*() operations, which are always 32-bit, the __native_word()
> | check is redundant but not harmful, as it is always true.

Thanks!
