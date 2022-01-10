Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86E16489BBF
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 16:02:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235864AbiAJPCx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 10:02:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233681AbiAJPCv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 10:02:51 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63C1DC06173F
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jan 2022 07:02:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=y40BAHNG1efKDJCM2nKdzIsOy9eS9i8aYnZiWAFB4Kc=; b=faNYTUfm6sqpK2gh7S3XBq+3sd
        3KT7KSh+D2fpWCuRpf6fyLk7ELIYEGY63cLZBiPz/0D5pj45kgJ3UI/Y1O3YWGgR7uYeVRh02v0Xx
        3UDg0YxZsZ97AyhsCOmuZaTOhqRwMfQayBwpOClP3MTri1DZWtwdNIEtwa/nH8ctusq1EfTNf3dt6
        pA+8PZpn/1A2tfWqsrPwsKK7NNOCX4bohYVitaYx4/Egc1cmXtYTTVytw5lqZVq+syMAA/NA930Eh
        VY684PK/GUlPI1vkyU9wP+os05/uH4jYDzB9DJ4Q6KFfJfeX7RUVryIXw+CBPsaGIepH8Hb8xkrqJ
        n2w0Oo/Q==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1n6wBv-000Pjj-Se; Mon, 10 Jan 2022 15:02:36 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 6429F300237;
        Mon, 10 Jan 2022 16:02:33 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 43B4220244CDF; Mon, 10 Jan 2022 16:02:33 +0100 (CET)
Date:   Mon, 10 Jan 2022 16:02:33 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Jaegeuk Kim <jaegeuk@kernel.org>, linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        Tim Murray <timmurray@google.com>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>
Subject: Re: [PATCH] f2fs: move f2fs to use reader-unfair rwsems
Message-ID: <YdxKiVHBUYvVP7W2@hirez.programming.kicks-ass.net>
References: <20220108164617.3130175-1-jaegeuk@kernel.org>
 <YdvoxkAAquI17UbX@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YdvoxkAAquI17UbX@infradead.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 10, 2022 at 12:05:26AM -0800, Christoph Hellwig wrote:
> Adding the locking primitive maintainers to this patch adding open coded
> locking primitives..
> 
> On Sat, Jan 08, 2022 at 08:46:17AM -0800, Jaegeuk Kim wrote:
> > From: Tim Murray <timmurray@google.com>
> > 
> > f2fs rw_semaphores work better if writers can starve readers,
> > especially for the checkpoint thread, because writers are strictly
> > more important than reader threads. This prevents significant priority
> > inversion between low-priority readers that blocked while trying to
> > acquire the read lock and a second acquisition of the write lock that
> > might be blocking high priority work.

*groan*... that's nowhere near enough Changelog to justify any of this.
Because next is a whole series of patches making things even worse
because lockdep no longers works as expected on this custom thing.

Can we start by describing the actual problem?
